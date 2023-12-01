//! High-level APIs for executing the resolver.
//!
//! This module provides functions for running the resolver given a workspace.
//! There are roughly 3 main functions:
//!
//! - `resolve_ws`: A simple, high-level function with no options.
//! - `resolve_ws_with_opts`: A medium-level function with options like
//!   user-provided features. This is the most appropriate function to use in
//!   most cases.
//! - `resolve_with_previous`: A low-level function for running the resolver,
//!   providing the most power and flexibility.

use crate::core::compiler::{CompileKind, RustcTargetData};
use crate::core::registry::PackageRegistry;
use crate::core::resolver::features::{FeatureResolver, ForceAllTargets, ResolvedFeatures};
use crate::core::resolver::{self, HasDevUnits, Resolve, ResolveOpts};
use crate::core::summary::Summary;
use crate::core::Feature;
use crate::core::{PackageId, PackageIdSpec, PackageSet, Source, SourceId, Workspace};
use crate::ops;
use crate::sources::PathSource;
use crate::util::errors::{CargoResult, CargoResultExt};
use crate::util::{profile, CanonicalUrl};
use log::{debug, trace};
use std::collections::HashSet;

/// Result for `resolve_ws_with_opts`.
pub struct WorkspaceResolve<'cfg> {
    /// Packages to be downloaded.
    pub pkg_set: PackageSet<'cfg>,
    /// The resolve for the entire workspace.
    ///
    /// This may be `None` for things like `cargo install` and `-Zavoid-dev-deps`.
    /// This does not include `paths` overrides.
    pub workspace_resolve: Option<Resolve>,
    /// The narrowed resolve, with the specific features enabled, and only the
    /// given package specs requested.
    pub targeted_resolve: Resolve,
    /// The features activated per package.
    pub resolved_features: ResolvedFeatures,
}

const UNUSED_PATCH_WARNING: &str = "\
Check that the patched package version and available features are compatible
with the dependency requirements. If the patch has a different version from
what is locked in the Cargo.lock file, run `cargo update` to use the new
version. This may also occur with an optional dependency that is not enabled.";

/// Resolves all dependencies for the workspace using the previous
/// lock file as a guide if present.
///
/// This function will also write the result of resolution as a new lock file
/// (unless it is an ephemeral workspace such as `cargo install` or `cargo
/// package`).
///
/// This is a simple interface used by commands like `clean`, `fetch`, and
/// `package`, which don't specify any options or features.
pub fn resolve_ws<'a>(ws: &Workspace<'a>) -> CargoResult<(PackageSet<'a>, Resolve)> {
    let mut registry = PackageRegistry::new(ws.config())?;
    let resolve = resolve_with_registry(ws, &mut registry)?;
    let packages = get_resolved_packages(&resolve, registry)?;
    Ok((packages, resolve))
}

/// Resolves dependencies for some packages of the workspace,
/// taking into account `paths` overrides and activated features.
///
/// This function will also write the result of resolution as a new lock file
/// (unless `Workspace::require_optional_deps` is false, such as `cargo
/// install` or `-Z avoid-dev-deps`), or it is an ephemeral workspace (`cargo
/// install` or `cargo package`).
///
/// `specs` may be empty, which indicates it should resolve all workspace
/// members. In this case, `opts.all_features` must be `true`.
pub fn resolve_ws_with_opts<'cfg>(
    ws: &Workspace<'cfg>,
    target_data: &RustcTargetData,
    requested_targets: &[CompileKind],
    opts: &ResolveOpts,
    specs: &[PackageIdSpec],
    has_dev_units: HasDevUnits,
    force_all_targets: ForceAllTargets,
) -> CargoResult<WorkspaceResolve<'cfg>> {
    let mut registry = PackageRegistry::new(ws.config())?;
    let mut add_patches = true;
    let resolve = if ws.ignore_lock() {
        None
    } else if ws.require_optional_deps() {
        // First, resolve the root_package's *listed* dependencies, as well as
        // downloading and updating all remotes and such.
        let resolve = resolve_with_registry(ws, &mut registry)?;
        // No need to add patches again, `resolve_with_registry` has done it.
        add_patches = false;

        // Second, resolve with precisely what we're doing. Filter out
        // transitive dependencies if necessary, specify features, handle
        // overrides, etc.
        let _p = profile::start("resolving with overrides...");

        add_overrides(&mut registry, ws)?;

        for &(ref replace_spec, ref dep) in ws.root_replace() {
            if !resolve
                .iter()
                .any(|r| replace_spec.matches(r) && !dep.matches_id(r))
            {
                ws.config()
                    .shell()
                    .warn(format!("package replacement is not used: {}", replace_spec))?
            }
        }

        Some(resolve)
    } else {
        ops::load_pkg_lockfile(ws)?
    };

    let resolved_with_overrides = resolve_with_previous(
        &mut registry,
        ws,
        opts,
        resolve.as_ref(),
        None,
        specs,
        add_patches,
    )?;

    let pkg_set = get_resolved_packages(&resolved_with_overrides, registry)?;

    let member_ids = ws
        .members_with_features(specs, &opts.features)?
        .into_iter()
        .map(|(p, _fts)| p.package_id())
        .collect::<Vec<_>>();
    pkg_set.download_accessible(
        &resolved_with_overrides,
        &member_ids,
        has_dev_units,
        requested_targets,
        target_data,
        force_all_targets,
    )?;

    let resolved_features = FeatureResolver::resolve(
        ws,
        target_data,
        &resolved_with_overrides,
        &pkg_set,
        &opts.features,
        specs,
        requested_targets,
        has_dev_units,
        force_all_targets,
    )?;

    Ok(WorkspaceResolve {
        pkg_set,
        workspace_resolve: resolve,
        targeted_resolve: resolved_with_overrides,
        resolved_features,
    })
}

fn resolve_with_registry<'cfg>(
    ws: &Workspace<'cfg>,
    registry: &mut PackageRegistry<'cfg>,
) -> CargoResult<Resolve> {
    let prev = ops::load_pkg_lockfile(ws)?;
    let mut resolve = resolve_with_previous(
        registry,
        ws,
        &ResolveOpts::everything(),
        prev.as_ref(),
        None,
        &[],
        true,
    )?;

    if !ws.is_ephemeral() && ws.require_optional_deps() {
        ops::write_pkg_lockfile(ws, &mut resolve)?;
    }
    Ok(resolve)
}

/// Resolves all dependencies for a package using an optional previous instance.
/// of resolve to guide the resolution process.
///
/// This also takes an optional hash set, `to_avoid`, which is a list of package
/// IDs that should be avoided when consulting the previous instance of resolve
/// (often used in pairings with updates).
///
/// The previous resolve normally comes from a lock file. This function does not
/// read or write lock files from the filesystem.
///
/// `specs` may be empty, which indicates it should resolve all workspace
/// members. In this case, `opts.all_features` must be `true`.
///
/// If `register_patches` is true, then entries from the `[patch]` table in
/// the manifest will be added to the given `PackageRegistry`.
pub fn resolve_with_previous<'cfg>(
    registry: &mut PackageRegistry<'cfg>,
    ws: &Workspace<'cfg>,
    opts: &ResolveOpts,
    previous: Option<&Resolve>,
    to_avoid: Option<&HashSet<PackageId>>,
    specs: &[PackageIdSpec],
    register_patches: bool,
) -> CargoResult<Resolve> {
    // We only want one Cargo at a time resolving a crate graph since this can
    // involve a lot of frobbing of the global caches.
    let _lock = ws.config().acquire_package_cache_lock()?;

    // Here we place an artificial limitation that all non-registry sources
    // cannot be locked at more than one revision. This means that if a Git
    // repository provides more than one package, they must all be updated in
    // step when any of them are updated.
    //
    // TODO: this seems like a hokey reason to single out the registry as being
    // different.
    let to_avoid_sources: HashSet<SourceId> = to_avoid
        .map(|set| {
            set.iter()
                .map(|p| p.source_id())
                .filter(|s| !s.is_registry())
                .collect()
        })
        .unwrap_or_default();

    let pre_patch_keep = |p: &PackageId| {
        !to_avoid_sources.contains(&p.source_id())
            && match to_avoid {
                Some(set) => !set.contains(p),
                None => true,
            }
    };

    // This is a set of PackageIds of `[patch]` entries that should not be
    // locked.
    let mut avoid_patch_ids = HashSet::new();
    if register_patches {
        for (url, patches) in ws.root_patch() {
            let previous = match previous {
                Some(r) => r,
                None => {
                    let patches: Vec<_> = patches.iter().map(|p| (p, None)).collect();
                    let unlock_ids = registry.patch(url, &patches)?;
                    // Since nothing is locked, this shouldn't possibly return anything.
                    assert!(unlock_ids.is_empty());
                    continue;
                }
            };
            let patches = patches
                .iter()
                .map(|dep| {
                    let unused = previous.unused_patches().iter().cloned();
                    let candidates = previous.iter().chain(unused);
                    match candidates
                        .filter(pre_patch_keep)
                        .find(|&id| dep.matches_id(id))
                    {
                        Some(id) => {
                            let mut locked_dep = dep.clone();
                            locked_dep.lock_to(id);
                            (dep, Some((locked_dep, id)))
                        }
                        None => (dep, None),
                    }
                })
                .collect::<Vec<_>>();
            let canonical = CanonicalUrl::new(url)?;
            for (orig_patch, unlock_id) in registry.patch(url, &patches)? {
                // Avoid the locked patch ID.
                avoid_patch_ids.insert(unlock_id);
                // Also avoid the thing it is patching.
                avoid_patch_ids.extend(previous.iter().filter(|id| {
                    orig_patch.matches_ignoring_source(*id)
                        && *id.source_id().canonical_url() == canonical
                }));
            }
        }
    }
    debug!("avoid_patch_ids={:?}", avoid_patch_ids);

    let keep = |p: &PackageId| pre_patch_keep(p) && !avoid_patch_ids.contains(p);

    // In the case where a previous instance of resolve is available, we
    // want to lock as many packages as possible to the previous version
    // without disturbing the graph structure.
    if let Some(r) = previous {
        trace!("previous: {:?}", r);
        register_previous_locks(ws, registry, r, &keep);
    }
    // Everything in the previous lock file we want to keep is prioritized
    // in dependency selection if it comes up, aka we want to have
    // conservative updates.
    let try_to_use = previous
        .map(|r| {
            r.iter()
                .filter(keep)
                .inspect(|id| {
                    debug!("attempting to prefer {}", id);
                })
                .collect()
        })
        .unwrap_or_default();

    if register_patches {
        registry.lock_patches();
    }

    for member in ws.members() {
        registry.add_sources(Some(member.package_id().source_id()))?;
    }

    let summaries: Vec<(Summary, ResolveOpts)> = ws
        .members_with_features(specs, &opts.features)?
        .into_iter()
        .map(|(member, features)| {
            let summary = registry.lock(member.summary().clone());
            (
                summary,
                ResolveOpts {
                    dev_deps: opts.dev_deps,
                    features,
                },
            )
        })
        .collect();

    let root_replace = ws.root_replace();

    let replace = match previous {
        Some(r) => root_replace
            .iter()
            .map(|&(ref spec, ref dep)| {
                for (&key, &val) in r.replacements().iter() {
                    if spec.matches(key) && dep.matches_id(val) && keep(&val) {
                        let mut dep = dep.clone();
                        dep.lock_to(val);
                        return (spec.clone(), dep);
                    }
                }
                (spec.clone(), dep.clone())
            })
            .collect::<Vec<_>>(),
        None => root_replace.to_vec(),
    };

    ws.preload(registry);
    let mut resolved = resolver::resolve(
        &summaries,
        &replace,
        registry,
        &try_to_use,
        Some(ws.config()),
        ws.unstable_features()
            .require(Feature::public_dependency())
            .is_ok(),
    )?;
    resolved.register_used_patches(&registry.patches());
    if register_patches {
        // It would be good if this warning was more targeted and helpful
        // (such as showing close candidates that failed to match). However,
        // that's not terribly easy to do, so just show a general help
        // message.
        let warnings: Vec<String> = resolved
            .unused_patches()
            .iter()
            .map(|pkgid| format!("Patch `{}` was not used in the crate graph.", pkgid))
            .collect();
        if !warnings.is_empty() {
            ws.config().shell().warn(format!(
                "{}\n{}",
                warnings.join("\n"),
                UNUSED_PATCH_WARNING
            ))?;
        }
    }
    if let Some(previous) = previous {
        resolved.merge_from(previous)?;
    }
    Ok(resolved)
}

/// Read the `paths` configuration variable to discover all path overrides that
/// have been configured.
pub fn add_overrides<'a>(
    registry: &mut PackageRegistry<'a>,
    ws: &Workspace<'a>,
) -> CargoResult<()> {
    let config = ws.config();
    let paths = match config.get_list("paths")? {
        Some(list) => list,
        None => return Ok(()),
    };

    let paths = paths.val.iter().map(|(s, def)| {
        // The path listed next to the string is the config file in which the
        // key was located, so we want to pop off the `.cargo/config` component
        // to get the directory containing the `.cargo` folder.
        (def.root(config).join(s), def)
    });

    for (path, definition) in paths {
        let id = SourceId::for_path(&path)?;
        let mut source = PathSource::new_recursive(&path, id, ws.config());
        source.update().chain_err(|| {
            format!(
                "failed to update path override `{}` \
                 (defined in `{}`)",
                path.display(),
                definition
            )
        })?;
        registry.add_override(Box::new(source));
    }
    Ok(())
}

pub fn get_resolved_packages<'cfg>(
    resolve: &Resolve,
    registry: PackageRegistry<'cfg>,
) -> CargoResult<PackageSet<'cfg>> {
    let ids: Vec<PackageId> = resolve.iter().collect();
    registry.get(&ids)
}

/// In this function we're responsible for informing the `registry` of all
/// locked dependencies from the previous lock file we had, `resolve`.
///
/// This gets particularly tricky for a couple of reasons. The first is that we
/// want all updates to be conservative, so we actually want to take the
/// `resolve` into account (and avoid unnecessary registry updates and such).
/// the second, however, is that we want to be resilient to updates of
/// manifests. For example if a dependency is added or a version is changed we
/// want to make sure that we properly re-resolve (conservatively) instead of
/// providing an opaque error.
///
/// The logic here is somewhat subtle, but there should be more comments below to
/// clarify things.
///
/// Note that this function, at the time of this writing, is basically the
/// entire fix for issue #4127.
fn register_previous_locks(
    ws: &Workspace<'_>,
    registry: &mut PackageRegistry<'_>,
    resolve: &Resolve,
    keep: &dyn Fn(&PackageId) -> bool,
) {
    let path_pkg = |id: SourceId| {
        if !id.is_path() {
            return None;
        }
        if let Ok(path) = id.url().to_file_path() {
            if let Ok(pkg) = ws.load(&path.join("Cargo.toml")) {
                return Some(pkg);
            }
        }
        None
    };

    // Ok so we've been passed in a `keep` function which basically says "if I
    // return `true` then this package wasn't listed for an update on the command
    // line". That is, if we run `cargo update -p foo` then `keep(bar)` will return
    // `true`, whereas `keep(foo)` will return `false` (roughly speaking).
    //
    // This isn't actually quite what we want, however. Instead we want to
    // further refine this `keep` function with *all transitive dependencies* of
    // the packages we're not keeping. For example, consider a case like this:
    //
    // * There's a crate `log`.
    // * There's a crate `serde` which depends on `log`.
    //
    // Let's say we then run `cargo update -p serde`. This may *also* want to
    // update the `log` dependency as our newer version of `serde` may have a
    // new minimum version required for `log`. Now this isn't always guaranteed
    // to work. What'll happen here is we *won't* lock the `log` dependency nor
    // the `log` crate itself, but we will inform the registry "please prefer
    // this version of `log`". That way if our newer version of serde works with
    // the older version of `log`, we conservatively won't update `log`. If,
    // however, nothing else in the dependency graph depends on `log` and the
    // newer version of `serde` requires a new version of `log` it'll get pulled
    // in (as we didn't accidentally lock it to an old version).
    //
    // Additionally, here we process all path dependencies listed in the previous
    // resolve. They can not only have their dependencies change but also
    // the versions of the package change as well. If this ends up happening
    // then we want to make sure we don't lock a package ID node that doesn't
    // actually exist. Note that we don't do transitive visits of all the
    // package's dependencies here as that'll be covered below to poison those
    // if they changed.
    let mut avoid_locking = HashSet::new();
    registry.add_to_yanked_whitelist(resolve.iter().filter(keep));
    for node in resolve.iter() {
        if !keep(&node) {
            add_deps(resolve, node, &mut avoid_locking);
        } else if let Some(pkg) = path_pkg(node.source_id()) {
            if pkg.package_id() != node {
                avoid_locking.insert(node);
            }
        }
    }

    // Ok, but the above loop isn't the entire story! Updates to the dependency
    // graph can come from two locations, the `cargo update` command or
    // manifests themselves. For example a manifest on the filesystem may
    // have been updated to have an updated version requirement on `serde`. In
    // this case both `keep(serde)` and `keep(log)` return `true` (the `keep`
    // that's an argument to this function). We, however, don't want to keep
    // either of those! Otherwise we'll get obscure resolve errors about locked
    // versions.
    //
    // To solve this problem we iterate over all packages with path sources
    // (aka ones with manifests that are changing) and take a look at all of
    // their dependencies. If any dependency does not match something in the
    // previous lock file, then we're guaranteed that the main resolver will
    // update the source of this dependency no matter what. Knowing this we
    // poison all packages from the same source, forcing them all to get
    // updated.
    //
    // This may seem like a heavy hammer, and it is! It means that if you change
    // anything from crates.io then all of crates.io becomes unlocked. Note,
    // however, that we still want conservative updates. This currently happens
    // because the first candidate the resolver picks is the previously locked
    // version, and only if that fails to activate to we move on and try
    // a different version. (giving the guise of conservative updates)
    //
    // For example let's say we had `serde = "0.1"` written in our lock file.
    // When we later edit this to `serde = "0.1.3"` we don't want to lock serde
    // at its old version, 0.1.1. Instead we want to allow it to update to
    // `0.1.3` and update its own dependencies (like above). To do this *all
    // crates from crates.io* are not locked (aka added to `avoid_locking`).
    // For dependencies like `log` their previous version in the lock file will
    // come up first before newer version, if newer version are available.
    let mut path_deps = ws.members().cloned().collect::<Vec<_>>();
    let mut visited = HashSet::new();
    while let Some(member) = path_deps.pop() {
        if !visited.insert(member.package_id()) {
            continue;
        }
        let is_ws_member = ws.is_member(&member);
        for dep in member.dependencies() {
            // If this dependency didn't match anything special then we may want
            // to poison the source as it may have been added. If this path
            // dependencies is **not** a workspace member, however, and it's an
            // optional/non-transitive dependency then it won't be necessarily
            // be in our lock file. If this shows up then we avoid poisoning
            // this source as otherwise we'd repeatedly update the registry.
            //
            // TODO: this breaks adding an optional dependency in a
            // non-workspace member and then simultaneously editing the
            // dependency on that crate to enable the feature. For now,
            // this bug is better than the always-updating registry though.
            if !is_ws_member && (dep.is_optional() || !dep.is_transitive()) {
                continue;
            }

            // If this is a path dependency, then try to push it onto our
            // worklist.
            if let Some(pkg) = path_pkg(dep.source_id()) {
                path_deps.push(pkg);
                continue;
            }

            // If we match *anything* in the dependency graph then we consider
            // ourselves all ok, and assume that we'll resolve to that.
            if resolve.iter().any(|id| dep.matches_ignoring_source(id)) {
                continue;
            }

            // Ok if nothing matches, then we poison the source of these
            // dependencies and the previous lock file.
            debug!(
                "poisoning {} because {} looks like it changed {}",
                dep.source_id(),
                member.package_id(),
                dep.package_name()
            );
            for id in resolve
                .iter()
                .filter(|id| id.source_id() == dep.source_id())
            {
                add_deps(resolve, id, &mut avoid_locking);
            }
        }
    }

    // Alright now that we've got our new, fresh, shiny, and refined `keep`
    // function let's put it to action. Take a look at the previous lock file,
    // filter everything by this callback, and then shove everything else into
    // the registry as a locked dependency.
    let keep = |id: &PackageId| keep(id) && !avoid_locking.contains(id);

    registry.clear_lock();
    for node in resolve.iter().filter(keep) {
        let deps = resolve
            .deps_not_replaced(node)
            .map(|p| p.0)
            .filter(keep)
            .collect();
        registry.register_lock(node, deps);
    }

    /// Recursively add `node` and all its transitive dependencies to `set`.
    fn add_deps(resolve: &Resolve, node: PackageId, set: &mut HashSet<PackageId>) {
        if !set.insert(node) {
            return;
        }
        debug!("ignoring any lock pointing directly at {}", node);
        for (dep, _) in resolve.deps_not_replaced(node) {
            add_deps(resolve, dep, set);
        }
    }
}
