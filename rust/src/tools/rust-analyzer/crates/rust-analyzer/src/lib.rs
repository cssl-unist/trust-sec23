//! Implementation of the LSP for rust-analyzer.
//!
//! This crate takes Rust-specific analysis results from ide and translates
//! into LSP types.
//!
//! It also is the root of all state. `world` module defines the bulk of the
//! state, and `main_loop` module defines the rules for modifying it.
//!
//! The `cli` submodule implements some batch-processing analysis, primarily as
//! a debugging aid.
#![recursion_limit = "512"]

pub mod cli;

#[allow(unused)]
macro_rules! eprintln {
    ($($tt:tt)*) => { stdx::eprintln!($($tt)*) };
}

mod global_state;
mod reload;
mod main_loop;
mod dispatch;
mod handlers;
mod caps;
mod cargo_target_spec;
mod to_proto;
mod from_proto;
mod semantic_tokens;
mod markdown;
mod diagnostics;
mod line_endings;
mod request_metrics;
mod lsp_utils;
mod thread_pool;
mod document;
pub mod lsp_ext;
pub mod config;

use serde::de::DeserializeOwned;

pub type Result<T, E = Box<dyn std::error::Error + Send + Sync>> = std::result::Result<T, E>;
pub use crate::{caps::server_capabilities, main_loop::main_loop};
use ide::AnalysisHost;
use std::fmt;
use vfs::Vfs;

pub fn from_json<T: DeserializeOwned>(what: &'static str, json: serde_json::Value) -> Result<T> {
    let res = T::deserialize(&json)
        .map_err(|e| format!("Failed to deserialize {}: {}; {}", what, e, json))?;
    Ok(res)
}

#[derive(Debug)]
struct LspError {
    code: i32,
    message: String,
}

impl LspError {
    fn new(code: i32, message: String) -> LspError {
        LspError { code, message }
    }
}

impl fmt::Display for LspError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Language Server request failed with {}. ({})", self.code, self.message)
    }
}

impl std::error::Error for LspError {}

fn print_memory_usage(mut host: AnalysisHost, vfs: Vfs) {
    let mut mem = host.per_query_memory_usage();

    let before = profile::memory_usage();
    drop(vfs);
    let vfs = before.allocated - profile::memory_usage().allocated;
    mem.push(("VFS".into(), vfs));

    let before = profile::memory_usage();
    drop(host);
    mem.push(("Unaccounted".into(), before.allocated - profile::memory_usage().allocated));

    mem.push(("Remaining".into(), profile::memory_usage().allocated));

    for (name, bytes) in mem {
        eprintln!("{:>8} {}", bytes, name);
    }
}
