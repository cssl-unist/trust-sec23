# Appendix C: Glossary

The compiler uses a number of...idiosyncratic abbreviations and things. This
glossary attempts to list them and give you a few pointers for understanding
them better.

Term                                     | Meaning
-----------------------------------------|--------
arena/arena allocation <div id="arena"/> |  An _arena_ is a large memory buffer from which other memory allocations are made. This style of allocation is called _arena allocation_. See [this chapter](../memory.md) for more info.
AST <div id="ast"/>                      |  The abstract syntax tree produced by the `rustc_ast` crate; reflects user syntax very closely.
binder <div id="binder"/>                |  A "binder" is a place where a variable or type is declared; for example, the `<T>` is a binder for the generic type parameter `T` in `fn foo<T>(..)`, and \|`a`\|` ...` is a binder for the parameter `a`. See [the background chapter for more](./background.html#free-vs-bound).
BodyId <div id="body-id"/                |  An identifier that refers to a specific body (definition of a function or constant) in the crate. See [the HIR chapter for more](../hir.html#identifiers-in-the-hir).
bound variable <div id="bound-var"/>     |  A "bound variable" is one that is declared within an expression/term. For example, the variable `a` is bound within the closure expression \|`a`\|` a * 2`. See [the background chapter for more](./background.html#free-vs-bound)
codegen <div id="codegen"/>              |  The code to translate MIR into LLVM IR.
codegen unit <div id="codegen-unit"/>    |  When we produce LLVM IR, we group the Rust code into a number of codegen units (sometimes abbreviated as CGUs). Each of these units is processed by LLVM independently from one another, enabling parallelism. They are also the unit of incremental re-use. ([see more](../backend/codegen.md))
completeness <div id="completeness"/>    |  A technical term in type theory, it means that every type-safe program also type-checks. Having both soundness and completeness is very hard, and usually soundness is more important. (see "soundness").
control-flow graph <div id="cfg"/>       |  A representation of the control-flow of a program; see [the background chapter for more](./background.html#cfg)
CTFE <div id="ctfe"/>                    |  Short for Compile-Time Function Evaluation, this is the ability of the compiler to evaluate `const fn`s at compile time. This is part of the compiler's constant evaluation system. ([see more](../const-eval.html))
cx <div id="cx"/>                        |  We tend to use "cx" as an abbreviation for context. See also `tcx`, `infcx`, etc.
DAG <div id="dag"/>                      |  A directed acyclic graph is used during compilation to keep track of dependencies between queries. ([see more](../queries/incremental-compilation.html))
data-flow analysis <div id="data-flow"/> |  A static analysis that figures out what properties are true at each point in the control-flow of a program; see [the background chapter for more](./background.html#dataflow).
DefId <div id="def-id"/>                 |  An index identifying a definition (see `librustc_middle/hir/def_id.rs`). Uniquely identifies a `DefPath`. See [the HIR chapter for more](../hir.html#identifiers-in-the-hir).
Double pointer <div id="double-ptr"/>    |  A pointer with additional metadata. See "fat pointer" for more.
drop glue <div id="drop-glue"/>          |  (internal) compiler-generated instructions that handle calling the destructors (`Drop`) for data types.
DST <div id="dst"/>                      |  Short for Dynamically-Sized Type, this is a type for which the compiler cannot statically know the size in memory (e.g. `str` or `[u8]`). Such types don't implement `Sized` and cannot be allocated on the stack. They can only occur as the last field in a struct. They can only be used behind a pointer (e.g. `&str` or `&[u8]`).
early-bound lifetime <div id="ebl"/>     |  A lifetime region that is substituted at its definition site. Bound in an item's `Generics` and substituted using a `Substs`. Contrast with **late-bound lifetime**. ([see more](https://doc.rust-lang.org/nightly/nightly-rustc/rustc_middle/ty/enum.RegionKind.html#bound-regions))
empty type <div id="empty-type"/>        |  see "uninhabited type".
Fat pointer <div id="fat-ptr"/>          |  A two word value carrying the address of some value, along with some further information necessary to put the value to use. Rust includes two kinds of "fat pointers": references to slices, and trait objects. A reference to a slice carries the starting address of the slice and its length. A trait object carries a value's address and a pointer to the trait's implementation appropriate to that value. "Fat pointers" are also known as "wide pointers", and "double pointers".
free variable <div id="free-var"/>       |  A "free variable" is one that is not bound within an expression or term; see [the background chapter for more](./background.html#free-vs-bound)
generics <div id="generics"/>            |  The set of generic type parameters defined on a type or item.
HIR <div id="hir"/>                      |  The High-level IR, created by lowering and desugaring the AST. ([see more](../hir.html))
HirId <div id="hir-id"/>                 |  Identifies a particular node in the HIR by combining a def-id with an "intra-definition offset". See [the HIR chapter for more](../hir.html#identifiers-in-the-hir).
HIR Map <div id="hir-map"/>              |  The HIR map, accessible via tcx.hir, allows you to quickly navigate the HIR and convert between various forms of identifiers.
ICE <div id="ice"/>                      |  Short for internal compiler error, this is when the compiler crashes.
ICH <div id="ich"/>                      |  Short for incremental compilation hash, these are used as fingerprints for things such as HIR and crate metadata, to check if changes have been made. This is useful in incremental compilation to see if part of a crate has changed and should be recompiled.
infcx <div id="infcx"/>                  |  The inference context (see `librustc_middle/infer`)
inference variable <div id="inf-var"/>   |  When doing type or region inference, an "inference variable" is a kind of special type/region that represents what you are trying to infer. Think of X in algebra. For example, if we are trying to infer the type of a variable in a program, we create an inference variable to represent that unknown type.
intern <div id="intern"/>                |  Interning refers to storing certain frequently-used constant data, such as strings, and then referring to the data by an identifier (e.g. a `Symbol`) rather than the data itself, to reduce memory usage and number of allocations. See [this chapter](../memory.md) for more info.
IR <div id="ir"/>                        |  Short for Intermediate Representation, a general term in compilers. During compilation, the code is transformed from raw source (ASCII text) to various IRs. In Rust, these are primarily HIR, MIR, and LLVM IR. Each IR is well-suited for some set of computations. For example, MIR is well-suited for the borrow checker, and LLVM IR is well-suited for codegen because LLVM accepts it.
IRLO <div id="irlo"/>                    |  `IRLO` or `irlo` is sometimes used as an abbreviation for [internals.rust-lang.org](https://internals.rust-lang.org).
item <div id="item"/>                    |  A kind of "definition" in the language, such as a static, const, use statement, module, struct, etc. Concretely, this corresponds to the `Item` type.
lang item <div id="lang-item"/>          |  Items that represent concepts intrinsic to the language itself, such as special built-in traits like `Sync` and `Send`; or traits representing operations such as `Add`; or functions that are called by the compiler. ([see more](https://doc.rust-lang.org/1.9.0/book/lang-items.html))
late-bound lifetime <div id="lbl"/>      |  A lifetime region that is substituted at its call site. Bound in a HRTB and substituted by specific functions in the compiler, such as `liberate_late_bound_regions`. Contrast with **early-bound lifetime**. ([see more](https://doc.rust-lang.org/nightly/nightly-rustc/rustc_middle/ty/enum.RegionKind.html#bound-regions))
local crate <div id="local-crate"/>      |  The crate currently being compiled.
LTO <div id="lto"/>                      |  Short for Link-Time Optimizations, this is a set of optimizations offered by LLVM that occur just before the final binary is linked. These include optimizations like removing functions that are never used in the final program, for example. _ThinLTO_ is a variant of LTO that aims to be a bit more scalable and efficient, but possibly sacrifices some optimizations. You may also read issues in the Rust repo about "FatLTO", which is the loving nickname given to non-Thin LTO. LLVM documentation: [here][lto] and [here][thinlto].
[LLVM] <div id="llvm"/>                  |  (actually not an acronym :P) an open-source compiler backend. It accepts LLVM IR and outputs native binaries. Various languages (e.g. Rust) can then implement a compiler front-end that outputs LLVM IR and use LLVM to compile to all the platforms LLVM supports.
memoization <div id="memoization"/>      |  The process of storing the results of (pure) computations (such as pure function calls) to avoid having to repeat them in the future. This is typically a trade-off between execution speed and memory usage.
MIR <div id="mir"/>                      |  The Mid-level IR that is created after type-checking for use by borrowck and codegen. ([see more](../mir/index.html))
miri <div id="miri"/>                    |  An interpreter for MIR used for constant evaluation. ([see more](../miri.html))
monomorphization <div id="mono"/>        |  The process of taking generic implementations of types and functions and instantiating them with concrete types. For example, in the code we might have `Vec<T>`, but in the final executable, we will have a copy of the `Vec` code for every concrete type used in the program (e.g. a copy for `Vec<usize>`, a copy for `Vec<MyStruct>`, etc).
normalize <div id="normalize"/>          |  A general term for converting to a more canonical form, but in the case of rustc typically refers to [associated type normalization](../traits/associated-types.html#normalize).
newtype <div id="newtype"/>              |  A wrapper around some other type (e.g., `struct Foo(T)` is a "newtype" for `T`). This is commonly used in Rust to give a stronger type for indices.
NLL <div id="nll"/>                      |  Short for [non-lexical lifetimes](../borrow_check/region_inference.html), this is an extension to Rust's borrowing system to make it be based on the control-flow graph.
node-id or NodeId <div id="node-id"/>    |  An index identifying a particular node in the AST or HIR; gradually being phased out and replaced with `HirId`. See [the HIR chapter for more](../hir.html#identifiers-in-the-hir).
obligation <div id="obligation"/>        |  Something that must be proven by the trait system. ([see more](../traits/resolution.html))
placeholder <div id="placeholder"/>      |  **NOTE: skolemization is deprecated by placeholder** a way of handling subtyping around "for-all" types (e.g., `for<'a> fn(&'a u32)`) as well as solving higher-ranked trait bounds (e.g., `for<'a> T: Trait<'a>`). See [the chapter on placeholder and universes](../borrow_check/region_inference/placeholders_and_universes.md) for more details.
point <div id="point"/>                  |  Used in the NLL analysis to refer to some particular location in the MIR; typically used to refer to a node in the control-flow graph.
polymorphize <div id="polymorphize"/>    |  An optimization that avoids unnecessary monomorphisation. ([see more](../backend/monomorph.md#polymorphization))
projection <div id="projection"/>        |  A general term for a "relative path", e.g. `x.f` is a "field projection", and `T::Item` is an ["associated type projection"](../traits/goals-and-clauses.html#trait-ref).
promoted constants <div id="pc"/>        |  Constants extracted from a function and lifted to static scope; see [this section](../mir/index.html#promoted) for more details.
provider <div id="provider"/>            |  The function that executes a query. ([see more](../query.html))
quantified <div id="quantified"/>        |  In math or logic, existential and universal quantification are used to ask questions like "is there any type T for which is true?" or "is this true for all types T?"; see [the background chapter for more](./background.html#quantified).
query <div id="query"/>                  |  Perhaps some sub-computation during compilation. ([see more](../query.html))
region <div id="region"/>                |  Another term for "lifetime" often used in the literature and in the borrow checker.
rib <div id="rib"/>                      |  A data structure in the name resolver that keeps track of a single scope for names. ([see more](../name-resolution.html))
sess <div id="sess"/>                    |  The compiler session, which stores global data used throughout compilation
side tables <div id="side-tables"/>      |  Because the AST and HIR are immutable once created, we often carry extra information about them in the form of hashtables, indexed by the id of a particular node.
sigil <div id="sigil"/>                  |  Like a keyword but composed entirely of non-alphanumeric tokens. For example, `&` is a sigil for references.
soundness <div id="soundness"/>          |  A technical term in type theory. Roughly, if a type system is sound, then if a program type-checks, it is type-safe; i.e. I can never (in safe rust) force a value into a variable of the wrong type. (see "completeness").
span <div id="span"/>                    |  A location in the user's source code, used for error reporting primarily. These are like a file-name/line-number/column tuple on steroids: they carry a start/end point, and also track macro expansions and compiler desugaring. All while being packed into a few bytes (really, it's an index into a table). See the Span datatype for more.
substs <div id="substs"/>                |  The substitutions for a given generic type or item (e.g. the `i32`, `u32` in `HashMap<i32, u32>`).
tcx <div id="tcx"/>                      |  The "typing context", main data structure of the compiler. ([see more](../ty.html))
'tcx <div id="lifetime-tcx"/>            |  The lifetime of the allocation arena. ([see more](../ty.html))
token <div id="token"/>                  |  The smallest unit of parsing. Tokens are produced after lexing ([see more](../the-parser.html)).
[TLS] <div id="tls"/>                    |  Thread-Local Storage. Variables may be defined so that each thread has its own copy (rather than all threads sharing the variable). This has some interactions with LLVM. Not all platforms support TLS.
trait reference <div id="trait-ref"/>    |  The name of a trait along with a suitable set of input type/lifetimes. ([see more](../traits/goals-and-clauses.html#trait-ref))
trans <div id="trans"/>                  |  The code to translate MIR into LLVM IR. Renamed to codegen.
ty <div id="ty"/>                        |  The internal representation of a type. ([see more](../ty.html))
UFCS <div id="ufcs"/>                    |  Short for Universal Function Call Syntax, this is an unambiguous syntax for calling a method. ([see more](../type-checking.html))
uninhabited type <div id="ut"/>          |  A type which has _no_ values. This is not the same as a ZST, which has exactly 1 value. An example of an uninhabited type is `enum Foo {}`, which has no variants, and so, can never be created. The compiler can treat code that deals with uninhabited types as dead code, since there is no such value to be manipulated. `!` (the never type) is an uninhabited type. Uninhabited types are also called "empty types".
upvar <div id="upvar"/>                  |  A variable captured by a closure from outside the closure.
variance <div id="variance"/>            |  Determines how changes to a generic type/lifetime parameter affect subtyping; for example, if `T` is a subtype of `U`, then `Vec<T>` is a subtype `Vec<U>` because `Vec` is *covariant* in its generic parameter. See [the background chapter](./background.html#variance) for a more general explanation. See the [variance chapter](../variance.html) for an explanation of how type checking handles variance.
Wide pointer <div id="wide-ptr"/>        |  A pointer with additional metadata. See "fat pointer" for more.
ZST <div id="zst"/>                      |  Zero-Sized Type. A type whose values have size 0 bytes. Since `2^0 = 1`, such types can have exactly one value. For example, `()` (unit) is a ZST. `struct Foo;` is also a ZST. The compiler can do some nice optimizations around ZSTs.

[LLVM]: https://llvm.org/
[lto]: https://llvm.org/docs/LinkTimeOptimization.html
[thinlto]: https://clang.llvm.org/docs/ThinLTO.html
[TLS]: https://llvm.org/docs/LangRef.html#thread-local-storage-models
