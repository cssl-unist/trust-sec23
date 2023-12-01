// Verify debuginfo for async fn:
//  - Each variant points to the file and line of its yield point
//  - The generator types and variants are marked artificial
//  - Captured vars from the source are not marked artificial
//
// ignore-tidy-linelength
// compile-flags: -C debuginfo=2 --edition=2018
// ignore-msvc

async fn foo() {}
async fn async_fn_test() {
    foo().await;
    let s = String::from("foo");
    foo().await;
}

// FIXME: No way to reliably check the filename.

// CHECK-DAG:  [[ASYNC_FN:!.*]] = !DINamespace(name: "async_fn_test"
// CHECK-DAG:  [[GEN:!.*]] = !DICompositeType(tag: DW_TAG_structure_type, name: "generator-0", scope: [[ASYNC_FN]], {{.*}}flags: DIFlagArtificial
// CHECK:      [[VARIANT:!.*]] = !DICompositeType(tag: DW_TAG_variant_part, scope: [[ASYNC_FN]],
// CHECK-SAME: flags: DIFlagArtificial
// CHECK-SAME: discriminator: [[DISC:![0-9]*]]
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "0", scope: [[VARIANT]],
// CHECK-SAME: file: [[FILE:![0-9]*]], line: 11,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DICompositeType(tag: DW_TAG_structure_type, name: "Unresumed", scope: [[GEN]],
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "1", scope: [[VARIANT]],
// CHECK-SAME: file: [[FILE]], line: 15,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "2", scope: [[VARIANT]],
// CHECK-SAME: file: [[FILE]], line: 15,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "3", scope: [[VARIANT]],
// CHECK-SAME: file: [[FILE]], line: 12,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "4", scope: [[VARIANT]],
// CHECK-SAME: file: [[FILE]], line: 14,
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      [[S1:!.*]] = !DICompositeType(tag: DW_TAG_structure_type, name: "Suspend1", scope: [[GEN]],
// CHECK-SAME: flags: DIFlagArtificial
// CHECK:      {{!.*}} = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: [[S1]]
// CHECK-NOT:  flags: DIFlagArtificial
// CHECK-SAME: )
// CHECK:      [[DISC]] = !DIDerivedType(tag: DW_TAG_member, name: "__state", scope: [[ASYNC_FN]],
// CHECK-SAME: flags: DIFlagArtificial

fn main() {
    let _dummy = async_fn_test();
}
