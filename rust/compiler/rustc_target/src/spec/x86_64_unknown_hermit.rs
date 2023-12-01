use crate::spec::Target;

pub fn target() -> Target {
    let mut base = super::hermit_base::opts();
    base.cpu = "x86-64".to_string();
    base.max_atomic_width = Some(64);
    base.features = "+rdrnd,+rdseed".to_string();
    base.stack_probes = true;

    Target {
        llvm_target: "x86_64-unknown-hermit".to_string(),
        pointer_width: 64,
        data_layout: "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
            .to_string(),
        arch: "x86_64".to_string(),
        options: base,
    }
}