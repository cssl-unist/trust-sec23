// Verify debuginfo for generators:
//  - Each variant points to the file and line of its yield point
//  - The generator types and variants are marked artificial
//  - Captured vars from the source are not marked artificial
//
// ignore-tidy-linelength
// compile-flags: -C debuginfo=2 --edition=2018
// only-msvc

async fn foo() {}
async fn async_fn_test() {
    foo().await;
    let s = String::from("foo");
    foo().await;
}

// FIXME: No way to reliably check the filename.

// CHECK-DAG:  [[ASYNC_FN:!.*]] = !DINamespace(name: "async_fn_test"
// CHECK-DAG:  [[GEN:!.*]] = !DICompositeType(tag: DW_TAG_union_type, name: "generator-0", scope: [[ASYNC_FN]], {{.*}}flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, scope: [[GEN]],
// For brevity, we only check the struct name and members of the last variant.
// CHECK-SAME: file: [[FILE:![0-9]*]], line: 11,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, scope: [[GEN]],
// CHECK-SAME: file: [[FILE]], line: 15,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, scope: [[GEN]],
// CHECK-SAME: file: [[FILE]], line: 15,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, scope: [[GEN]],
// CHECK-SAME: file: [[FILE]], line: 12,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, scope: [[GEN]],
// CHECK-SAME: file: [[FILE]], line: 14,
// CHECK-SAME: baseType: [[VARIANT:![0-9]*]]
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      [[S1:!.*]] = !DICompositeType(tag: DW_TAG_structure_type, name: "Suspend1", scope: [[ASYNC_FN]],
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "RUST$ENUM$DISR", scope: [[S1]],
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: [[S1]]
// CHECK-NOT:  flags: DIFlagArtificial
// CHECK-SAME: )

fn main() {
    let _dummy = async_fn_test();
}
