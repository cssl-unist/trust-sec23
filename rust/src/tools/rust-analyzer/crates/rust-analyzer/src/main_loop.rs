//! The main loop of `rust-analyzer` responsible for dispatching LSP
//! requests/replies and notifications back to the client.
use std::{
    env, fmt, panic,
    time::{Duration, Instant},
};

use base_db::VfsPath;
use crossbeam_channel::{select, Receiver};
use ide::{Canceled, FileId};
use lsp_server::{Connection, Notification, Request, Response};
use lsp_types::notification::Notification as _;
use project_model::ProjectWorkspace;
use vfs::ChangeKind;

use crate::{
    config::Config,
    dispatch::{NotificationDispatcher, RequestDispatcher},
    document::DocumentData,
    from_proto,
    global_state::{file_id_to_url, url_to_file_id, GlobalState, Status},
    handlers, lsp_ext,
    lsp_utils::{apply_document_changes, is_canceled, notification_is, Progress},
    Result,
};

pub fn main_loop(config: Config, connection: Connection) -> Result<()> {
    log::info!("initial config: {:#?}", config);

    // Windows scheduler implements priority boosts: if thread waits for an
    // event (like a condvar), and event fires, priority of the thread is
    // temporary bumped. This optimization backfires in our case: each time the
    // `main_loop` schedules a task to run on a threadpool, the worker threads
    // gets a higher priority, and (on a machine with fewer cores) displaces the
    // main loop! We work-around this by marking the main loop as a
    // higher-priority thread.
    //
    // https://docs.microsoft.com/en-us/windows/win32/procthread/scheduling-priorities
    // https://docs.microsoft.com/en-us/windows/win32/procthread/priority-boosts
    // https://github.com/rust-analyzer/rust-analyzer/issues/2835
    #[cfg(windows)]
    unsafe {
        use winapi::um::processthreadsapi::*;
        let thread = GetCurrentThread();
        let thread_priority_above_normal = 1;
        SetThreadPriority(thread, thread_priority_above_normal);
    }

    GlobalState::new(connection.sender, config).run(connection.receiver)
}

enum Event {
    Lsp(lsp_server::Message),
    Task(Task),
    Vfs(vfs::loader::Message),
    Flycheck(flycheck::Message),
}

#[derive(Debug)]
pub(crate) enum Task {
    Response(Response),
    Diagnostics(Vec<(FileId, Vec<lsp_types::Diagnostic>)>),
    Workspaces(Vec<anyhow::Result<ProjectWorkspace>>),
    Unit,
}

impl fmt::Debug for Event {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let debug_verbose_not = |not: &Notification, f: &mut fmt::Formatter| {
            f.debug_struct("Notification").field("method", &not.method).finish()
        };

        match self {
            Event::Lsp(lsp_server::Message::Notification(not)) => {
                if notification_is::<lsp_types::notification::DidOpenTextDocument>(not)
                    || notification_is::<lsp_types::notification::DidChangeTextDocument>(not)
                {
                    return debug_verbose_not(not, f);
                }
            }
            Event::Task(Task::Response(resp)) => {
                return f
                    .debug_struct("Response")
                    .field("id", &resp.id)
                    .field("error", &resp.error)
                    .finish();
            }
            _ => (),
        }
        match self {
            Event::Lsp(it) => fmt::Debug::fmt(it, f),
            Event::Task(it) => fmt::Debug::fmt(it, f),
            Event::Vfs(it) => fmt::Debug::fmt(it, f),
            Event::Flycheck(it) => fmt::Debug::fmt(it, f),
        }
    }
}

impl GlobalState {
    fn run(mut self, inbox: Receiver<lsp_server::Message>) -> Result<()> {
        if self.config.linked_projects.is_empty() && self.config.notifications.cargo_toml_not_found
        {
            self.show_message(
                lsp_types::MessageType::Error,
                "rust-analyzer failed to discover workspace".to_string(),
            );
        };

        let save_registration_options = lsp_types::TextDocumentSaveRegistrationOptions {
            include_text: Some(false),
            text_document_registration_options: lsp_types::TextDocumentRegistrationOptions {
                document_selector: Some(vec![
                    lsp_types::DocumentFilter {
                        language: None,
                        scheme: None,
                        pattern: Some("**/*.rs".into()),
                    },
                    lsp_types::DocumentFilter {
                        language: None,
                        scheme: None,
                        pattern: Some("**/Cargo.toml".into()),
                    },
                    lsp_types::DocumentFilter {
                        language: None,
                        scheme: None,
                        pattern: Some("**/Cargo.lock".into()),
                    },
                ]),
            },
        };

        let registration = lsp_types::Registration {
            id: "textDocument/didSave".to_string(),
            method: "textDocument/didSave".to_string(),
            register_options: Some(serde_json::to_value(save_registration_options).unwrap()),
        };
        self.send_request::<lsp_types::request::RegisterCapability>(
            lsp_types::RegistrationParams { registrations: vec![registration] },
            |_, _| (),
        );

        self.fetch_workspaces();

        while let Some(event) = self.next_event(&inbox) {
            if let Event::Lsp(lsp_server::Message::Notification(not)) = &event {
                if not.method == lsp_types::notification::Exit::METHOD {
                    return Ok(());
                }
            }
            self.handle_event(event)?
        }

        Err("client exited without proper shutdown sequence")?
    }

    fn next_event(&self, inbox: &Receiver<lsp_server::Message>) -> Option<Event> {
        select! {
            recv(inbox) -> msg =>
                msg.ok().map(Event::Lsp),

            recv(self.task_pool.receiver) -> task =>
                Some(Event::Task(task.unwrap())),

            recv(self.loader.receiver) -> task =>
                Some(Event::Vfs(task.unwrap())),

            recv(self.flycheck_receiver) -> task =>
                Some(Event::Flycheck(task.unwrap())),
        }
    }

    fn handle_event(&mut self, event: Event) -> Result<()> {
        let loop_start = Instant::now();
        // NOTE: don't count blocking select! call as a loop-turn time
        let _p = profile::span("GlobalState::handle_event");

        log::info!("handle_event({:?})", event);
        let task_queue_len = self.task_pool.handle.len();
        if task_queue_len > 0 {
            log::info!("task queue len: {}", task_queue_len);
        }

        let prev_status = self.status;
        match event {
            Event::Lsp(msg) => match msg {
                lsp_server::Message::Request(req) => self.on_request(loop_start, req)?,
                lsp_server::Message::Notification(not) => {
                    self.on_notification(not)?;
                }
                lsp_server::Message::Response(resp) => self.complete_request(resp),
            },
            Event::Task(task) => {
                match task {
                    Task::Response(response) => self.respond(response),
                    Task::Diagnostics(diagnostics_per_file) => {
                        for (file_id, diagnostics) in diagnostics_per_file {
                            self.diagnostics.set_native_diagnostics(file_id, diagnostics)
                        }
                    }
                    Task::Workspaces(workspaces) => self.switch_workspaces(workspaces),
                    Task::Unit => (),
                }
                self.analysis_host.maybe_collect_garbage();
            }
            Event::Vfs(mut task) => {
                let _p = profile::span("GlobalState::handle_event/vfs");
                loop {
                    match task {
                        vfs::loader::Message::Loaded { files } => {
                            let vfs = &mut self.vfs.write().0;
                            for (path, contents) in files {
                                let path = VfsPath::from(path);
                                if !self.mem_docs.contains_key(&path) {
                                    vfs.set_file_contents(path, contents)
                                }
                            }
                        }
                        vfs::loader::Message::Progress { n_total, n_done } => {
                            if n_total == 0 {
                                self.transition(Status::Invalid);
                            } else {
                                let state = if n_done == 0 {
                                    self.transition(Status::Loading);
                                    Progress::Begin
                                } else if n_done < n_total {
                                    Progress::Report
                                } else {
                                    assert_eq!(n_done, n_total);
                                    self.transition(Status::Ready);
                                    Progress::End
                                };
                                self.report_progress(
                                    "roots scanned",
                                    state,
                                    Some(format!("{}/{}", n_done, n_total)),
                                    Some(Progress::percentage(n_done, n_total)),
                                )
                            }
                        }
                    }
                    // Coalesce many VFS event into a single loop turn
                    task = match self.loader.receiver.try_recv() {
                        Ok(task) => task,
                        Err(_) => break,
                    }
                }
            }
            Event::Flycheck(task) => match task {
                flycheck::Message::AddDiagnostic { workspace_root, diagnostic } => {
                    let diagnostics = crate::diagnostics::to_proto::map_rust_diagnostic_to_lsp(
                        &self.config.diagnostics_map,
                        &diagnostic,
                        &workspace_root,
                    );
                    for diag in diagnostics {
                        match url_to_file_id(&self.vfs.read().0, &diag.url) {
                            Ok(file_id) => self.diagnostics.add_check_diagnostic(
                                file_id,
                                diag.diagnostic,
                                diag.fixes,
                            ),
                            Err(err) => {
                                log::error!("File with cargo diagnostic not found in VFS: {}", err);
                            }
                        };
                    }
                }

                flycheck::Message::Progress(status) => {
                    let (state, message) = match status {
                        flycheck::Progress::DidStart => {
                            self.diagnostics.clear_check();
                            (Progress::Begin, None)
                        }
                        flycheck::Progress::DidCheckCrate(target) => {
                            (Progress::Report, Some(target))
                        }
                        flycheck::Progress::DidCancel => (Progress::End, None),
                        flycheck::Progress::DidFinish(result) => {
                            if let Err(err) = result {
                                log::error!("cargo check failed: {}", err)
                            }
                            (Progress::End, None)
                        }
                    };

                    self.report_progress("cargo check", state, message, None);
                }
            },
        }

        let state_changed = self.process_changes();
        if prev_status == Status::Loading && self.status == Status::Ready {
            if let Some(flycheck) = &self.flycheck {
                flycheck.update();
            }
        }

        if self.status == Status::Ready && (state_changed || prev_status == Status::Loading) {
            let subscriptions = self
                .mem_docs
                .keys()
                .map(|path| self.vfs.read().0.file_id(&path).unwrap())
                .collect::<Vec<_>>();

            self.update_file_notifications_on_threadpool(subscriptions);
        }

        if let Some(diagnostic_changes) = self.diagnostics.take_changes() {
            for file_id in diagnostic_changes {
                let url = file_id_to_url(&self.vfs.read().0, file_id);
                let diagnostics = self.diagnostics.diagnostics_for(file_id).cloned().collect();
                let version = from_proto::vfs_path(&url)
                    .map(|path| self.mem_docs.get(&path)?.version)
                    .unwrap_or_default();

                self.send_notification::<lsp_types::notification::PublishDiagnostics>(
                    lsp_types::PublishDiagnosticsParams { uri: url, diagnostics, version },
                );
            }
        }

        let loop_duration = loop_start.elapsed();
        if loop_duration > Duration::from_millis(100) {
            log::warn!("overly long loop turn: {:?}", loop_duration);
            if env::var("RA_PROFILE").is_ok() {
                self.show_message(
                    lsp_types::MessageType::Error,
                    format!("overly long loop turn: {:?}", loop_duration),
                )
            }
        }
        Ok(())
    }

    fn on_request(&mut self, request_received: Instant, req: Request) -> Result<()> {
        self.register_request(&req, request_received);

        if self.shutdown_requested {
            self.respond(Response::new_err(
                req.id,
                lsp_server::ErrorCode::InvalidRequest as i32,
                "Shutdown already requested.".to_owned(),
            ));

            return Ok(());
        }

        if self.status == Status::Loading && req.method != "shutdown" {
            self.respond(lsp_server::Response::new_err(
                req.id,
                // FIXME: i32 should impl From<ErrorCode> (from() guarantees lossless conversion)
                lsp_server::ErrorCode::ContentModified as i32,
                "Rust Analyzer is still loading...".to_owned(),
            ));
            return Ok(());
        }

        RequestDispatcher { req: Some(req), global_state: self }
            .on_sync::<lsp_ext::ReloadWorkspace>(|s, ()| Ok(s.fetch_workspaces()))?
            .on_sync::<lsp_ext::JoinLines>(|s, p| handlers::handle_join_lines(s.snapshot(), p))?
            .on_sync::<lsp_ext::OnEnter>(|s, p| handlers::handle_on_enter(s.snapshot(), p))?
            .on_sync::<lsp_types::request::Shutdown>(|s, ()| {
                s.shutdown_requested = true;
                Ok(())
            })?
            .on_sync::<lsp_types::request::SelectionRangeRequest>(|s, p| {
                handlers::handle_selection_range(s.snapshot(), p)
            })?
            .on_sync::<lsp_ext::MatchingBrace>(|s, p| {
                handlers::handle_matching_brace(s.snapshot(), p)
            })?
            .on_sync::<lsp_ext::MemoryUsage>(|s, p| handlers::handle_memory_usage(s, p))?
            .on::<lsp_ext::AnalyzerStatus>(handlers::handle_analyzer_status)?
            .on::<lsp_ext::SyntaxTree>(handlers::handle_syntax_tree)?
            .on::<lsp_ext::ExpandMacro>(handlers::handle_expand_macro)?
            .on::<lsp_ext::ParentModule>(handlers::handle_parent_module)?
            .on::<lsp_ext::Runnables>(handlers::handle_runnables)?
            .on::<lsp_ext::InlayHints>(handlers::handle_inlay_hints)?
            .on::<lsp_ext::CodeActionRequest>(handlers::handle_code_action)?
            .on::<lsp_ext::ResolveCodeActionRequest>(handlers::handle_resolve_code_action)?
            .on::<lsp_ext::HoverRequest>(handlers::handle_hover)?
            .on::<lsp_types::request::OnTypeFormatting>(handlers::handle_on_type_formatting)?
            .on::<lsp_types::request::DocumentSymbolRequest>(handlers::handle_document_symbol)?
            .on::<lsp_types::request::WorkspaceSymbol>(handlers::handle_workspace_symbol)?
            .on::<lsp_types::request::GotoDefinition>(handlers::handle_goto_definition)?
            .on::<lsp_types::request::GotoImplementation>(handlers::handle_goto_implementation)?
            .on::<lsp_types::request::GotoTypeDefinition>(handlers::handle_goto_type_definition)?
            .on::<lsp_types::request::Completion>(handlers::handle_completion)?
            .on::<lsp_types::request::CodeLensRequest>(handlers::handle_code_lens)?
            .on::<lsp_types::request::CodeLensResolve>(handlers::handle_code_lens_resolve)?
            .on::<lsp_types::request::FoldingRangeRequest>(handlers::handle_folding_range)?
            .on::<lsp_types::request::SignatureHelpRequest>(handlers::handle_signature_help)?
            .on::<lsp_types::request::PrepareRenameRequest>(handlers::handle_prepare_rename)?
            .on::<lsp_types::request::Rename>(handlers::handle_rename)?
            .on::<lsp_types::request::References>(handlers::handle_references)?
            .on::<lsp_types::request::Formatting>(handlers::handle_formatting)?
            .on::<lsp_types::request::DocumentHighlightRequest>(
                handlers::handle_document_highlight,
            )?
            .on::<lsp_types::request::CallHierarchyPrepare>(
                handlers::handle_call_hierarchy_prepare,
            )?
            .on::<lsp_types::request::CallHierarchyIncomingCalls>(
                handlers::handle_call_hierarchy_incoming,
            )?
            .on::<lsp_types::request::CallHierarchyOutgoingCalls>(
                handlers::handle_call_hierarchy_outgoing,
            )?
            .on::<lsp_types::request::SemanticTokensFullRequest>(
                handlers::handle_semantic_tokens_full,
            )?
            .on::<lsp_types::request::SemanticTokensFullDeltaRequest>(
                handlers::handle_semantic_tokens_full_delta,
            )?
            .on::<lsp_types::request::SemanticTokensRangeRequest>(
                handlers::handle_semantic_tokens_range,
            )?
            .on::<lsp_ext::Ssr>(handlers::handle_ssr)?
            .finish();
        Ok(())
    }
    fn on_notification(&mut self, not: Notification) -> Result<()> {
        NotificationDispatcher { not: Some(not), global_state: self }
            .on::<lsp_types::notification::Cancel>(|this, params| {
                let id: lsp_server::RequestId = match params.id {
                    lsp_types::NumberOrString::Number(id) => id.into(),
                    lsp_types::NumberOrString::String(id) => id.into(),
                };
                this.cancel(id);
                Ok(())
            })?
            .on::<lsp_types::notification::DidOpenTextDocument>(|this, params| {
                if let Ok(path) = from_proto::vfs_path(&params.text_document.uri) {
                    if this
                        .mem_docs
                        .insert(path.clone(), DocumentData::new(params.text_document.version))
                        .is_some()
                    {
                        log::error!("duplicate DidOpenTextDocument: {}", path)
                    }
                    this.vfs
                        .write()
                        .0
                        .set_file_contents(path, Some(params.text_document.text.into_bytes()));
                }
                Ok(())
            })?
            .on::<lsp_types::notification::DidChangeTextDocument>(|this, params| {
                if let Ok(path) = from_proto::vfs_path(&params.text_document.uri) {
                    let doc = this.mem_docs.get_mut(&path).unwrap();
                    let vfs = &mut this.vfs.write().0;
                    let file_id = vfs.file_id(&path).unwrap();
                    let mut text = String::from_utf8(vfs.file_contents(file_id).to_vec()).unwrap();
                    apply_document_changes(&mut text, params.content_changes);

                    // The version passed in DidChangeTextDocument is the version after all edits are applied
                    // so we should apply it before the vfs is notified.
                    doc.version = params.text_document.version;

                    vfs.set_file_contents(path.clone(), Some(text.into_bytes()));
                }
                Ok(())
            })?
            .on::<lsp_types::notification::DidCloseTextDocument>(|this, params| {
                let mut version = None;
                if let Ok(path) = from_proto::vfs_path(&params.text_document.uri) {
                    match this.mem_docs.remove(&path) {
                        Some(doc) => version = doc.version,
                        None => log::error!("orphan DidCloseTextDocument: {}", path),
                    }

                    this.semantic_tokens_cache.lock().remove(&params.text_document.uri);

                    if let Some(path) = path.as_path() {
                        this.loader.handle.invalidate(path.to_path_buf());
                    }
                }

                // Clear the diagnostics for the previously known version of the file.
                // This prevents stale "cargo check" diagnostics if the file is
                // closed, "cargo check" is run and then the file is reopened.
                this.send_notification::<lsp_types::notification::PublishDiagnostics>(
                    lsp_types::PublishDiagnosticsParams {
                        uri: params.text_document.uri,
                        diagnostics: Vec::new(),
                        version,
                    },
                );
                Ok(())
            })?
            .on::<lsp_types::notification::DidSaveTextDocument>(|this, params| {
                if let Some(flycheck) = &this.flycheck {
                    flycheck.update();
                }
                if let Ok(abs_path) = from_proto::abs_path(&params.text_document.uri) {
                    this.maybe_refresh(&[(abs_path, ChangeKind::Modify)]);
                }
                Ok(())
            })?
            .on::<lsp_types::notification::DidChangeConfiguration>(|this, _params| {
                // As stated in https://github.com/microsoft/language-server-protocol/issues/676,
                // this notification's parameters should be ignored and the actual config queried separately.
                this.send_request::<lsp_types::request::WorkspaceConfiguration>(
                    lsp_types::ConfigurationParams {
                        items: vec![lsp_types::ConfigurationItem {
                            scope_uri: None,
                            section: Some("rust-analyzer".to_string()),
                        }],
                    },
                    |this, resp| {
                        log::debug!("config update response: '{:?}", resp);
                        let Response { error, result, .. } = resp;

                        match (error, result) {
                            (Some(err), _) => {
                                log::error!("failed to fetch the server settings: {:?}", err)
                            }
                            (None, Some(mut configs)) => {
                                if let Some(json) = configs.get_mut(0) {
                                    // Note that json can be null according to the spec if the client can't
                                    // provide a configuration. This is handled in Config::update below.
                                    let mut config = this.config.clone();
                                    config.update(json.take());
                                    this.update_configuration(config);
                                }
                            }
                            (None, None) => log::error!(
                                "received empty server settings response from the client"
                            ),
                        }
                    },
                );

                return Ok(());
            })?
            .on::<lsp_types::notification::DidChangeWatchedFiles>(|this, params| {
                for change in params.changes {
                    if let Ok(path) = from_proto::abs_path(&change.uri) {
                        this.loader.handle.invalidate(path);
                    }
                }
                Ok(())
            })?
            .finish();
        Ok(())
    }
    fn update_file_notifications_on_threadpool(&mut self, subscriptions: Vec<FileId>) {
        log::trace!("updating notifications for {:?}", subscriptions);
        if self.config.publish_diagnostics {
            let snapshot = self.snapshot();
            let subscriptions = subscriptions.clone();
            self.task_pool.handle.spawn(move || {
                let diagnostics = subscriptions
                    .into_iter()
                    .filter_map(|file_id| {
                        handlers::publish_diagnostics(&snapshot, file_id)
                            .map_err(|err| {
                                if !is_canceled(&*err) {
                                    log::error!("failed to compute diagnostics: {:?}", err);
                                }
                                ()
                            })
                            .ok()
                            .map(|diags| (file_id, diags))
                    })
                    .collect::<Vec<_>>();
                Task::Diagnostics(diagnostics)
            })
        }
        self.task_pool.handle.spawn({
            let subs = subscriptions;
            let snap = self.snapshot();
            move || {
                snap.analysis.prime_caches(subs).unwrap_or_else(|_: Canceled| ());
                Task::Unit
            }
        });
    }
}
