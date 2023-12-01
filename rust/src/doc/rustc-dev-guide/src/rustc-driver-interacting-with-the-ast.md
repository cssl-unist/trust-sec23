# Example: Type checking through `rustc_interface`

`rustc_interface` allows you to interact with Rust code at various stages of compilation.

## Getting the type of an expression

NOTE: For the example to compile, you will need to first run the following:

    rustup component add rustc-dev

To get the type of an expression, use the `global_ctxt` to get a `TyCtxt`:

```rust
// In this example, config specifies the rust program:
//   fn main() { let message = \"Hello, world!\"; println!(\"{}\", message); }
// Our goal is to get the type of the string literal "Hello, world!".
//
// See https://github.com/rust-lang/rustc-dev-guide/blob/master/examples/rustc-driver-example.rs for a complete example of configuring rustc_interface
rustc_interface::run_compiler(config, |compiler| {
    compiler.enter(|queries| {
        // Analyze the crate and inspect the types under the cursor.
        queries.global_ctxt().unwrap().take().enter(|tcx| {
            // Every compilation contains a single crate.
            let krate = tcx.hir().krate();
            // Iterate over the top-level items in the crate, looking for the main function.
            for (_, item) in &krate.items {
                // Use pattern-matching to find a specific node inside the main function.
                if let rustc_hir::ItemKind::Fn(_, _, body_id) = item.kind {
                    let expr = &tcx.hir().body(body_id).value;
                    if let rustc_hir::ExprKind::Block(block, _) = expr.kind {
                        if let rustc_hir::StmtKind::Local(local) = block.stmts[0].kind {
                            if let Some(expr) = local.init {
                                let hir_id = expr.hir_id; // hir_id identifies the string "Hello, world!"
                                let def_id = tcx.hir().local_def_id(item.hir_id); // def_id identifies the main function
                                let ty = tcx.typeck_tables_of(def_id).node_type(hir_id);
                                println!("{:?}: {:?}", expr, ty); // prints expr(HirId { owner: DefIndex(3), local_id: 4 }: "Hello, world!"): &'static str
                            }
                        }
                    }
                }
            }
        })
    });
});
```
