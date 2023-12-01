use crate::core::compiler::{CompileKind, RustcTargetData};
use crate::core::dependency::DepKind;
use crate::core::package::SerializedPackage;
use crate::core::resolver::{HasDevUnits, Resolve, ResolveOpts};
use crate::core::{Dependency, Package, PackageId, Workspace};
use crate::ops::{self, Packages};
use crate::util::interning::InternedString;
use crate::util::CargoResult;
use cargo_platform::Platform;
use serde::Serialize;
use std::collections::BTreeMap;
use std::path::PathBuf;

const VERSION: u32 = 1;

pub struct OutputMetadataOptions {
    pub features: Vec<String>,
    pub no_default_features: bool,
    pub all_features: bool,
    pub no_deps: bool,
    pub version: u32,
    pub filter_platforms: Vec<String>,
}

/// Loads the manifest, resolves the dependencies of the package to the concrete
/// used versions - considering overrides - and writes all dependencies in a JSON
/// format to stdout.
pub fn output_metadata(ws: &Workspace<'_>, opt: &OutputMetadataOptions) -> CargoResult<ExportInfo> {
    if opt.version != VERSION {
        anyhow::bail!(
            "metadata version {} not supported, only {} is currently supported",
            opt.version,
            VERSION
        );
    }
    let config = ws.config();
    let (packages, resolve) = if opt.no_deps {
        let packages = ws.members().map(|pkg| pkg.serialized(config)).collect();
        (packages, None)
    } else {
        let (packages, resolve) = build_resolve_graph(ws, opt)?;
        (packages, Some(resolve))
    };

    Ok(ExportInfo {
        packages,
        workspace_members: ws.members().map(|pkg| pkg.package_id()).collect(),
        resolve,
        target_directory: ws.target_dir().into_path_unlocked(),
        version: VERSION,
        workspace_root: ws.root().to_path_buf(),
        metadata: ws.custom_metadata().cloned(),
    })
}

/// This is the structure that is serialized and displayed to the user.
///
/// See cargo-metadata.adoc for detailed documentation of the format.
#[derive(Serialize)]
pub struct ExportInfo {
    packages: Vec<SerializedPackage>,
    workspace_members: Vec<PackageId>,
    resolve: Option<MetadataResolve>,
    target_directory: PathBuf,
    version: u32,
    workspace_root: PathBuf,
    metadata: Option<toml::Value>,
}

#[derive(Serialize)]
struct MetadataResolve {
    nodes: Vec<MetadataResolveNode>,
    root: Option<PackageId>,
}

#[derive(Serialize)]
struct MetadataResolveNode {
    id: PackageId,
    dependencies: Vec<PackageId>,
    deps: Vec<Dep>,
    features: Vec<InternedString>,
}

#[derive(Serialize)]
struct Dep {
    name: String,
    pkg: PackageId,
    dep_kinds: Vec<DepKindInfo>,
}

#[derive(Serialize, PartialEq, Eq, PartialOrd, Ord)]
struct DepKindInfo {
    kind: DepKind,
    target: Option<Platform>,
}

impl From<&Dependency> for DepKindInfo {
    fn from(dep: &Dependency) -> DepKindInfo {
        DepKindInfo {
            kind: dep.kind(),
            target: dep.platform().cloned(),
        }
    }
}

/// Builds the resolve graph as it will be displayed to the user.
fn build_resolve_graph(
    ws: &Workspace<'_>,
    metadata_opts: &OutputMetadataOptions,
) -> CargoResult<(Vec<SerializedPackage>, MetadataResolve)> {
    // TODO: Without --filter-platform, features are being resolved for `host` only.
    // How should this work?
    let requested_kinds =
        CompileKind::from_requested_targets(ws.config(), &metadata_opts.filter_platforms)?;
    let target_data = RustcTargetData::new(ws, &requested_kinds)?;
    // Resolve entire workspace.
    let specs = Packages::All.to_package_id_specs(ws)?;
    let resolve_opts = ResolveOpts::new(
        /*dev_deps*/ true,
        &metadata_opts.features,
        metadata_opts.all_features,
        !metadata_opts.no_default_features,
    );
    let ws_resolve = ops::resolve_ws_with_opts(
        ws,
        &target_data,
        &requested_kinds,
        &resolve_opts,
        &specs,
        HasDevUnits::Yes,
        crate::core::resolver::features::ForceAllTargets::No,
    )?;
    // Download all Packages. This is needed to serialize the information
    // for every package. In theory this could honor target filtering,
    // but that would be somewhat complex.
    let package_map: BTreeMap<PackageId, Package> = ws_resolve
        .pkg_set
        .get_many(ws_resolve.pkg_set.package_ids())?
        .into_iter()
        // This is a little lazy, but serde doesn't handle Rc fields very well.
        .map(|pkg| (pkg.package_id(), Package::clone(pkg)))
        .collect();

    // Start from the workspace roots, and recurse through filling out the
    // map, filtering targets as necessary.
    let mut node_map = BTreeMap::new();
    for member_pkg in ws.members() {
        build_resolve_graph_r(
            &mut node_map,
            member_pkg.package_id(),
            &ws_resolve.targeted_resolve,
            &package_map,
            &target_data,
            &requested_kinds,
        );
    }
    // Get a Vec of Packages.
    let config = ws.config();
    let actual_packages = package_map
        .into_iter()
        .filter_map(|(pkg_id, pkg)| node_map.get(&pkg_id).map(|_| pkg))
        .map(|pkg| pkg.serialized(config))
        .collect();

    let mr = MetadataResolve {
        nodes: node_map.into_iter().map(|(_pkg_id, node)| node).collect(),
        root: ws.current_opt().map(|pkg| pkg.package_id()),
    };
    Ok((actual_packages, mr))
}

fn build_resolve_graph_r(
    node_map: &mut BTreeMap<PackageId, MetadataResolveNode>,
    pkg_id: PackageId,
    resolve: &Resolve,
    package_map: &BTreeMap<PackageId, Package>,
    target_data: &RustcTargetData,
    requested_kinds: &[CompileKind],
) {
    if node_map.contains_key(&pkg_id) {
        return;
    }
    // This normalizes the IDs so that they are consistent between the
    // `packages` array and the `resolve` map. This is a bit of a hack to
    // compensate for the fact that
    // SourceKind::Git(GitReference::Branch("master")) is the same as
    // SourceKind::Git(GitReference::DefaultBranch). We want IDs in the JSON
    // to be opaque, and compare with basic string equality, so this will
    // always prefer the style of ID in the Package instead of the resolver.
    // Cargo generally only exposes PackageIds from the Package struct, and
    // AFAIK this is the only place where the resolver variant is exposed.
    //
    // This diverges because the SourceIds created for Packages are built
    // based on the Dependency declaration, but the SourceIds in the resolver
    // are deserialized from Cargo.lock. Cargo.lock may have been generated by
    // an older (or newer!) version of Cargo which uses a different style.
    let normalize_id = |id| -> PackageId { *package_map.get_key_value(&id).unwrap().0 };
    let features = resolve.features(pkg_id).to_vec();

    let deps: Vec<Dep> = resolve
        .deps(pkg_id)
        .filter(|(_dep_id, deps)| {
            if requested_kinds == [CompileKind::Host] {
                true
            } else {
                requested_kinds.iter().any(|kind| {
                    deps.iter()
                        .any(|dep| target_data.dep_platform_activated(dep, *kind))
                })
            }
        })
        .filter_map(|(dep_id, deps)| {
            let mut dep_kinds: Vec<_> = deps.iter().map(DepKindInfo::from).collect();
            dep_kinds.sort();
            package_map
                .get(&dep_id)
                .and_then(|pkg| pkg.targets().iter().find(|t| t.is_lib()))
                .and_then(|lib_target| resolve.extern_crate_name(pkg_id, dep_id, lib_target).ok())
                .map(|name| Dep {
                    name,
                    pkg: normalize_id(dep_id),
                    dep_kinds,
                })
        })
        .collect();
    let dumb_deps: Vec<PackageId> = deps.iter().map(|dep| normalize_id(dep.pkg)).collect();
    let to_visit = dumb_deps.clone();
    let node = MetadataResolveNode {
        id: normalize_id(pkg_id),
        dependencies: dumb_deps,
        deps,
        features,
    };
    node_map.insert(pkg_id, node);
    for dep_id in to_visit {
        build_resolve_graph_r(
            node_map,
            dep_id,
            resolve,
            package_map,
            target_data,
            requested_kinds,
        );
    }
}
