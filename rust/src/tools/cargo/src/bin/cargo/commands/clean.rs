use crate::command_prelude::*;

use cargo::ops::{self, CleanOptions};
use cargo::util::print_available_packages;

pub fn cli() -> App {
    subcommand("clean")
        .about("Remove artifacts that cargo has generated in the past")
        .arg(opt("quiet", "No output printed to stdout").short("q"))
        .arg_package_spec_simple("Package to clean artifacts for")
        .arg_manifest_path()
        .arg_target_triple("Target triple to clean output for")
        .arg_target_dir()
        .arg_release("Whether or not to clean release artifacts")
        .arg_profile("Clean artifacts of the specified profile")
        .arg_doc("Whether or not to clean just the documentation directory")
        .after_help("Run `cargo help clean` for more detailed information.\n")
}

pub fn exec(config: &mut Config, args: &ArgMatches<'_>) -> CliResult {
    let ws = args.workspace(config)?;

    if args.is_present_with_zero_values("package") {
        print_available_packages(&ws)?;
    }

    let opts = CleanOptions {
        config,
        spec: values(args, "package"),
        targets: args.targets(),
        requested_profile: args.get_profile_name(config, "dev", ProfileChecking::Checked)?,
        profile_specified: args.is_present("profile") || args.is_present("release"),
        doc: args.is_present("doc"),
    };
    ops::clean(&ws, &opts)?;
    Ok(())
}
