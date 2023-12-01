use crate::spec::{LinkerFlavor, Target, TargetOptions};

pub fn target() -> Target {
    let mut base = super::netbsd_base::opts();
    base.vendor = "rumprun".to_string();
    base.cpu = "x86-64".to_string();
    base.pre_link_args.get_mut(&LinkerFlavor::Gcc).unwrap().push("-m64".to_string());
    base.linker = Some("x86_64-rumprun-netbsd-gcc".to_string());
    base.max_atomic_width = Some(64);

    base.dynamic_linking = false;
    base.has_rpath = false;
    base.position_independent_executables = false;
    base.disable_redzone = true;
    base.stack_probes = true;

    Target {
        llvm_target: "x86_64-rumprun-netbsd".to_string(),
        pointer_width: 64,
        data_layout: "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
            .to_string(),
        arch: "x86_64".to_string(),
        options: TargetOptions { mcount: "__mcount".to_string(), ..base },
    }
}
