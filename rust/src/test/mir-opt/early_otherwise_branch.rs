// compile-flags: -Z mir-opt-level=3
// EMIT_MIR early_otherwise_branch.opt1.EarlyOtherwiseBranch.diff
fn opt1(x: Option<u32>, y: Option<u32>) -> u32 {
    match (x, y) {
        (Some(a), Some(b)) => 0,
        _ => 1,
    }
}

// EMIT_MIR early_otherwise_branch.opt2.EarlyOtherwiseBranch.diff
fn opt2(x: Option<u32>, y: Option<u32>) -> u32 {
    match (x, y) {
        (Some(a), Some(b)) => 0,
        (None, None) => 0,
        _ => 1,
    }
}

fn main() {
    opt1(None, Some(0));
    opt2(None, Some(0));
}
