use crate::spec::{Target, TargetOptions};

pub fn target() -> Target {
    let base = super::vxworks_base::opts();
    Target {
        llvm_target: "armv7-unknown-linux-gnueabihf".to_string(),
        pointer_width: 32,
        data_layout: "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64".to_string(),
        arch: "arm".to_string(),
        options: TargetOptions {
            // Info about features at https://wiki.debian.org/ArmHardFloatPort
            features: "+v7,+vfp3,-d32,+thumb2,-neon".to_string(),
            cpu: "generic".to_string(),
            max_atomic_width: Some(64),
            unsupported_abis: super::arm_base::unsupported_abis(),
            ..base
        },
    }
}
