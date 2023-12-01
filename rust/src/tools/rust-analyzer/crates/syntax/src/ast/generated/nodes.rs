//! Generated file, do not edit by hand, see `xtask/src/codegen`

use crate::{
    ast::{self, support, AstChildren, AstNode},
    SyntaxKind::{self, *},
    SyntaxNode, SyntaxToken, T,
};
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Name {
    pub(crate) syntax: SyntaxNode,
}
impl Name {
    pub fn ident_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![ident]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct NameRef {
    pub(crate) syntax: SyntaxNode,
}
impl NameRef {
    pub fn ident_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![ident]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Path {
    pub(crate) syntax: SyntaxNode,
}
impl Path {
    pub fn qualifier(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn coloncolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![::]) }
    pub fn segment(&self) -> Option<PathSegment> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PathSegment {
    pub(crate) syntax: SyntaxNode,
}
impl PathSegment {
    pub fn crate_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![crate]) }
    pub fn self_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![self]) }
    pub fn super_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![super]) }
    pub fn coloncolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![::]) }
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
    pub fn generic_arg_list(&self) -> Option<GenericArgList> { support::child(&self.syntax) }
    pub fn param_list(&self) -> Option<ParamList> { support::child(&self.syntax) }
    pub fn ret_type(&self) -> Option<RetType> { support::child(&self.syntax) }
    pub fn l_angle_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![<]) }
    pub fn path_type(&self) -> Option<PathType> { support::child(&self.syntax) }
    pub fn as_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![as]) }
    pub fn r_angle_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![>]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct GenericArgList {
    pub(crate) syntax: SyntaxNode,
}
impl GenericArgList {
    pub fn coloncolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![::]) }
    pub fn l_angle_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![<]) }
    pub fn generic_args(&self) -> AstChildren<GenericArg> { support::children(&self.syntax) }
    pub fn r_angle_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![>]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ParamList {
    pub(crate) syntax: SyntaxNode,
}
impl ParamList {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn self_param(&self) -> Option<SelfParam> { support::child(&self.syntax) }
    pub fn comma_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![,]) }
    pub fn params(&self) -> AstChildren<Param> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
    pub fn pipe_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![|]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RetType {
    pub(crate) syntax: SyntaxNode,
}
impl RetType {
    pub fn thin_arrow_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![->]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PathType {
    pub(crate) syntax: SyntaxNode,
}
impl PathType {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TypeArg {
    pub(crate) syntax: SyntaxNode,
}
impl TypeArg {
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct AssocTypeArg {
    pub(crate) syntax: SyntaxNode,
}
impl ast::TypeBoundsOwner for AssocTypeArg {}
impl AssocTypeArg {
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct LifetimeArg {
    pub(crate) syntax: SyntaxNode,
}
impl LifetimeArg {
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ConstArg {
    pub(crate) syntax: SyntaxNode,
}
impl ConstArg {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TypeBoundList {
    pub(crate) syntax: SyntaxNode,
}
impl TypeBoundList {
    pub fn bounds(&self) -> AstChildren<TypeBound> { support::children(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MacroCall {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for MacroCall {}
impl ast::NameOwner for MacroCall {}
impl MacroCall {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn excl_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![!]) }
    pub fn token_tree(&self) -> Option<TokenTree> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Attr {
    pub(crate) syntax: SyntaxNode,
}
impl Attr {
    pub fn pound_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![#]) }
    pub fn excl_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![!]) }
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn literal(&self) -> Option<Literal> { support::child(&self.syntax) }
    pub fn token_tree(&self) -> Option<TokenTree> { support::child(&self.syntax) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TokenTree {
    pub(crate) syntax: SyntaxNode,
}
impl TokenTree {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MacroItems {
    pub(crate) syntax: SyntaxNode,
}
impl ast::ModuleItemOwner for MacroItems {}
impl MacroItems {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MacroStmts {
    pub(crate) syntax: SyntaxNode,
}
impl MacroStmts {
    pub fn statements(&self) -> AstChildren<Stmt> { support::children(&self.syntax) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct SourceFile {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for SourceFile {}
impl ast::ModuleItemOwner for SourceFile {}
impl SourceFile {
    pub fn shebang_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![shebang]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Const {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Const {}
impl ast::NameOwner for Const {}
impl ast::VisibilityOwner for Const {}
impl Const {
    pub fn default_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![default]) }
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn underscore_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![_]) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn body(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Enum {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Enum {}
impl ast::NameOwner for Enum {}
impl ast::VisibilityOwner for Enum {}
impl ast::GenericParamsOwner for Enum {}
impl Enum {
    pub fn enum_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![enum]) }
    pub fn variant_list(&self) -> Option<VariantList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ExternBlock {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ExternBlock {}
impl ExternBlock {
    pub fn abi(&self) -> Option<Abi> { support::child(&self.syntax) }
    pub fn extern_item_list(&self) -> Option<ExternItemList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ExternCrate {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ExternCrate {}
impl ast::VisibilityOwner for ExternCrate {}
impl ExternCrate {
    pub fn extern_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![extern]) }
    pub fn crate_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![crate]) }
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
    pub fn self_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![self]) }
    pub fn rename(&self) -> Option<Rename> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Fn {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Fn {}
impl ast::NameOwner for Fn {}
impl ast::VisibilityOwner for Fn {}
impl ast::GenericParamsOwner for Fn {}
impl Fn {
    pub fn default_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![default]) }
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn async_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![async]) }
    pub fn unsafe_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![unsafe]) }
    pub fn abi(&self) -> Option<Abi> { support::child(&self.syntax) }
    pub fn fn_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![fn]) }
    pub fn param_list(&self) -> Option<ParamList> { support::child(&self.syntax) }
    pub fn ret_type(&self) -> Option<RetType> { support::child(&self.syntax) }
    pub fn body(&self) -> Option<BlockExpr> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Impl {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Impl {}
impl ast::VisibilityOwner for Impl {}
impl ast::GenericParamsOwner for Impl {}
impl Impl {
    pub fn default_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![default]) }
    pub fn unsafe_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![unsafe]) }
    pub fn impl_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![impl]) }
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn excl_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![!]) }
    pub fn for_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![for]) }
    pub fn assoc_item_list(&self) -> Option<AssocItemList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Module {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Module {}
impl ast::NameOwner for Module {}
impl ast::VisibilityOwner for Module {}
impl Module {
    pub fn mod_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mod]) }
    pub fn item_list(&self) -> Option<ItemList> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Static {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Static {}
impl ast::NameOwner for Static {}
impl ast::VisibilityOwner for Static {}
impl Static {
    pub fn static_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![static]) }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn body(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Struct {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Struct {}
impl ast::NameOwner for Struct {}
impl ast::VisibilityOwner for Struct {}
impl ast::GenericParamsOwner for Struct {}
impl Struct {
    pub fn struct_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![struct]) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
    pub fn field_list(&self) -> Option<FieldList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Trait {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Trait {}
impl ast::NameOwner for Trait {}
impl ast::VisibilityOwner for Trait {}
impl ast::GenericParamsOwner for Trait {}
impl ast::TypeBoundsOwner for Trait {}
impl Trait {
    pub fn unsafe_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![unsafe]) }
    pub fn auto_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![auto]) }
    pub fn trait_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![trait]) }
    pub fn assoc_item_list(&self) -> Option<AssocItemList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TypeAlias {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for TypeAlias {}
impl ast::NameOwner for TypeAlias {}
impl ast::VisibilityOwner for TypeAlias {}
impl ast::GenericParamsOwner for TypeAlias {}
impl ast::TypeBoundsOwner for TypeAlias {}
impl TypeAlias {
    pub fn default_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![default]) }
    pub fn type_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![type]) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Union {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Union {}
impl ast::NameOwner for Union {}
impl ast::VisibilityOwner for Union {}
impl ast::GenericParamsOwner for Union {}
impl Union {
    pub fn union_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![union]) }
    pub fn record_field_list(&self) -> Option<RecordFieldList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Use {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Use {}
impl ast::VisibilityOwner for Use {}
impl Use {
    pub fn use_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![use]) }
    pub fn use_tree(&self) -> Option<UseTree> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Visibility {
    pub(crate) syntax: SyntaxNode,
}
impl Visibility {
    pub fn pub_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![pub]) }
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn super_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![super]) }
    pub fn self_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![self]) }
    pub fn crate_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![crate]) }
    pub fn in_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![in]) }
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ItemList {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ItemList {}
impl ast::ModuleItemOwner for ItemList {}
impl ItemList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Rename {
    pub(crate) syntax: SyntaxNode,
}
impl ast::NameOwner for Rename {}
impl Rename {
    pub fn as_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![as]) }
    pub fn underscore_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![_]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct UseTree {
    pub(crate) syntax: SyntaxNode,
}
impl UseTree {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn coloncolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![::]) }
    pub fn star_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![*]) }
    pub fn use_tree_list(&self) -> Option<UseTreeList> { support::child(&self.syntax) }
    pub fn rename(&self) -> Option<Rename> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct UseTreeList {
    pub(crate) syntax: SyntaxNode,
}
impl UseTreeList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn use_trees(&self) -> AstChildren<UseTree> { support::children(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Abi {
    pub(crate) syntax: SyntaxNode,
}
impl Abi {
    pub fn extern_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![extern]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct GenericParamList {
    pub(crate) syntax: SyntaxNode,
}
impl GenericParamList {
    pub fn l_angle_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![<]) }
    pub fn generic_params(&self) -> AstChildren<GenericParam> { support::children(&self.syntax) }
    pub fn r_angle_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![>]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct WhereClause {
    pub(crate) syntax: SyntaxNode,
}
impl WhereClause {
    pub fn where_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![where]) }
    pub fn predicates(&self) -> AstChildren<WherePred> { support::children(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct BlockExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for BlockExpr {}
impl BlockExpr {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn statements(&self) -> AstChildren<Stmt> { support::children(&self.syntax) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct SelfParam {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for SelfParam {}
impl SelfParam {
    pub fn amp_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![&]) }
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn self_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![self]) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Param {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Param {}
impl Param {
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn dotdotdot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![...]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordFieldList {
    pub(crate) syntax: SyntaxNode,
}
impl RecordFieldList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn fields(&self) -> AstChildren<RecordField> { support::children(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TupleFieldList {
    pub(crate) syntax: SyntaxNode,
}
impl TupleFieldList {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn fields(&self) -> AstChildren<TupleField> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordField {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for RecordField {}
impl ast::NameOwner for RecordField {}
impl ast::VisibilityOwner for RecordField {}
impl RecordField {
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TupleField {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for TupleField {}
impl ast::VisibilityOwner for TupleField {}
impl TupleField {
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct VariantList {
    pub(crate) syntax: SyntaxNode,
}
impl VariantList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn variants(&self) -> AstChildren<Variant> { support::children(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Variant {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Variant {}
impl ast::NameOwner for Variant {}
impl ast::VisibilityOwner for Variant {}
impl Variant {
    pub fn field_list(&self) -> Option<FieldList> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct AssocItemList {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for AssocItemList {}
impl AssocItemList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn assoc_items(&self) -> AstChildren<AssocItem> { support::children(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ExternItemList {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ExternItemList {}
impl ExternItemList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn extern_items(&self) -> AstChildren<ExternItem> { support::children(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ConstParam {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ConstParam {}
impl ast::NameOwner for ConstParam {}
impl ConstParam {
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn default_val(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct LifetimeParam {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for LifetimeParam {}
impl ast::TypeBoundsOwner for LifetimeParam {}
impl LifetimeParam {
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TypeParam {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for TypeParam {}
impl ast::NameOwner for TypeParam {}
impl ast::TypeBoundsOwner for TypeParam {}
impl TypeParam {
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn default_type(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct WherePred {
    pub(crate) syntax: SyntaxNode,
}
impl ast::TypeBoundsOwner for WherePred {}
impl WherePred {
    pub fn for_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![for]) }
    pub fn generic_param_list(&self) -> Option<GenericParamList> { support::child(&self.syntax) }
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Literal {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for Literal {}
impl Literal {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ExprStmt {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ExprStmt {}
impl ExprStmt {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct LetStmt {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for LetStmt {}
impl LetStmt {
    pub fn let_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![let]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn initializer(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ArrayExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ArrayExpr {}
impl ArrayExpr {
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn exprs(&self) -> AstChildren<Expr> { support::children(&self.syntax) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct AwaitExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for AwaitExpr {}
impl AwaitExpr {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn dot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![.]) }
    pub fn await_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![await]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct BinExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for BinExpr {}
impl BinExpr {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct BoxExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for BoxExpr {}
impl BoxExpr {
    pub fn box_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![box]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct BreakExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for BreakExpr {}
impl BreakExpr {
    pub fn break_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![break]) }
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct CallExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for CallExpr {}
impl ast::ArgListOwner for CallExpr {}
impl CallExpr {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct CastExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for CastExpr {}
impl CastExpr {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn as_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![as]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ClosureExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ClosureExpr {}
impl ClosureExpr {
    pub fn static_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![static]) }
    pub fn async_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![async]) }
    pub fn move_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![move]) }
    pub fn param_list(&self) -> Option<ParamList> { support::child(&self.syntax) }
    pub fn ret_type(&self) -> Option<RetType> { support::child(&self.syntax) }
    pub fn body(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ContinueExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ContinueExpr {}
impl ContinueExpr {
    pub fn continue_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![continue])
    }
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct EffectExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for EffectExpr {}
impl EffectExpr {
    pub fn label(&self) -> Option<Label> { support::child(&self.syntax) }
    pub fn try_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![try]) }
    pub fn unsafe_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![unsafe]) }
    pub fn async_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![async]) }
    pub fn block_expr(&self) -> Option<BlockExpr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct FieldExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for FieldExpr {}
impl FieldExpr {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn dot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![.]) }
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ForExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ForExpr {}
impl ast::LoopBodyOwner for ForExpr {}
impl ForExpr {
    pub fn for_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![for]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
    pub fn in_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![in]) }
    pub fn iterable(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct IfExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for IfExpr {}
impl IfExpr {
    pub fn if_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![if]) }
    pub fn condition(&self) -> Option<Condition> { support::child(&self.syntax) }
    pub fn else_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![else]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct IndexExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for IndexExpr {}
impl IndexExpr {
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct LoopExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for LoopExpr {}
impl ast::LoopBodyOwner for LoopExpr {}
impl LoopExpr {
    pub fn loop_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![loop]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MatchExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for MatchExpr {}
impl MatchExpr {
    pub fn match_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![match]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn match_arm_list(&self) -> Option<MatchArmList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MethodCallExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for MethodCallExpr {}
impl ast::ArgListOwner for MethodCallExpr {}
impl MethodCallExpr {
    pub fn receiver(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn dot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![.]) }
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
    pub fn generic_arg_list(&self) -> Option<GenericArgList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ParenExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ParenExpr {}
impl ParenExpr {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PathExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for PathExpr {}
impl PathExpr {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PrefixExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for PrefixExpr {}
impl PrefixExpr {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RangeExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for RangeExpr {}
impl RangeExpr {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordExpr {
    pub(crate) syntax: SyntaxNode,
}
impl RecordExpr {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn record_expr_field_list(&self) -> Option<RecordExprFieldList> {
        support::child(&self.syntax)
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RefExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for RefExpr {}
impl RefExpr {
    pub fn amp_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![&]) }
    pub fn raw_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![raw]) }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ReturnExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for ReturnExpr {}
impl ReturnExpr {
    pub fn return_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![return]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TryExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for TryExpr {}
impl TryExpr {
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn question_mark_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![?]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TupleExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for TupleExpr {}
impl TupleExpr {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn fields(&self) -> AstChildren<Expr> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct WhileExpr {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for WhileExpr {}
impl ast::LoopBodyOwner for WhileExpr {}
impl WhileExpr {
    pub fn while_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![while]) }
    pub fn condition(&self) -> Option<Condition> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Label {
    pub(crate) syntax: SyntaxNode,
}
impl Label {
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordExprFieldList {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for RecordExprFieldList {}
impl RecordExprFieldList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn fields(&self) -> AstChildren<RecordExprField> { support::children(&self.syntax) }
    pub fn dotdot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![..]) }
    pub fn spread(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordExprField {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for RecordExprField {}
impl RecordExprField {
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ArgList {
    pub(crate) syntax: SyntaxNode,
}
impl ArgList {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn args(&self) -> AstChildren<Expr> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct Condition {
    pub(crate) syntax: SyntaxNode,
}
impl Condition {
    pub fn let_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![let]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
    pub fn eq_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MatchArmList {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for MatchArmList {}
impl MatchArmList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn arms(&self) -> AstChildren<MatchArm> { support::children(&self.syntax) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MatchArm {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for MatchArm {}
impl MatchArm {
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
    pub fn guard(&self) -> Option<MatchGuard> { support::child(&self.syntax) }
    pub fn fat_arrow_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![=>]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn comma_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![,]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MatchGuard {
    pub(crate) syntax: SyntaxNode,
}
impl MatchGuard {
    pub fn if_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![if]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ArrayType {
    pub(crate) syntax: SyntaxNode,
}
impl ArrayType {
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn semicolon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![;]) }
    pub fn expr(&self) -> Option<Expr> { support::child(&self.syntax) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct DynTraitType {
    pub(crate) syntax: SyntaxNode,
}
impl DynTraitType {
    pub fn dyn_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![dyn]) }
    pub fn type_bound_list(&self) -> Option<TypeBoundList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct FnPtrType {
    pub(crate) syntax: SyntaxNode,
}
impl FnPtrType {
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn async_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![async]) }
    pub fn unsafe_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![unsafe]) }
    pub fn abi(&self) -> Option<Abi> { support::child(&self.syntax) }
    pub fn fn_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![fn]) }
    pub fn param_list(&self) -> Option<ParamList> { support::child(&self.syntax) }
    pub fn ret_type(&self) -> Option<RetType> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ForType {
    pub(crate) syntax: SyntaxNode,
}
impl ForType {
    pub fn for_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![for]) }
    pub fn generic_param_list(&self) -> Option<GenericParamList> { support::child(&self.syntax) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ImplTraitType {
    pub(crate) syntax: SyntaxNode,
}
impl ImplTraitType {
    pub fn impl_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![impl]) }
    pub fn type_bound_list(&self) -> Option<TypeBoundList> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct InferType {
    pub(crate) syntax: SyntaxNode,
}
impl InferType {
    pub fn underscore_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![_]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct NeverType {
    pub(crate) syntax: SyntaxNode,
}
impl NeverType {
    pub fn excl_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![!]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ParenType {
    pub(crate) syntax: SyntaxNode,
}
impl ParenType {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PtrType {
    pub(crate) syntax: SyntaxNode,
}
impl PtrType {
    pub fn star_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![*]) }
    pub fn const_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![const]) }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RefType {
    pub(crate) syntax: SyntaxNode,
}
impl RefType {
    pub fn amp_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![&]) }
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct SliceType {
    pub(crate) syntax: SyntaxNode,
}
impl SliceType {
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TupleType {
    pub(crate) syntax: SyntaxNode,
}
impl TupleType {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn fields(&self) -> AstChildren<Type> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TypeBound {
    pub(crate) syntax: SyntaxNode,
}
impl TypeBound {
    pub fn lifetime_token(&self) -> Option<SyntaxToken> {
        support::token(&self.syntax, T![lifetime])
    }
    pub fn question_mark_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![?]) }
    pub fn ty(&self) -> Option<Type> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct IdentPat {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for IdentPat {}
impl ast::NameOwner for IdentPat {}
impl IdentPat {
    pub fn ref_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![ref]) }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn at_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![@]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct BoxPat {
    pub(crate) syntax: SyntaxNode,
}
impl BoxPat {
    pub fn box_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![box]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RestPat {
    pub(crate) syntax: SyntaxNode,
}
impl RestPat {
    pub fn dotdot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![..]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct LiteralPat {
    pub(crate) syntax: SyntaxNode,
}
impl LiteralPat {
    pub fn literal(&self) -> Option<Literal> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct MacroPat {
    pub(crate) syntax: SyntaxNode,
}
impl MacroPat {
    pub fn macro_call(&self) -> Option<MacroCall> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct OrPat {
    pub(crate) syntax: SyntaxNode,
}
impl OrPat {
    pub fn pats(&self) -> AstChildren<Pat> { support::children(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct ParenPat {
    pub(crate) syntax: SyntaxNode,
}
impl ParenPat {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PathPat {
    pub(crate) syntax: SyntaxNode,
}
impl PathPat {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct WildcardPat {
    pub(crate) syntax: SyntaxNode,
}
impl WildcardPat {
    pub fn underscore_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![_]) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RangePat {
    pub(crate) syntax: SyntaxNode,
}
impl RangePat {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordPat {
    pub(crate) syntax: SyntaxNode,
}
impl RecordPat {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn record_pat_field_list(&self) -> Option<RecordPatFieldList> {
        support::child(&self.syntax)
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RefPat {
    pub(crate) syntax: SyntaxNode,
}
impl RefPat {
    pub fn amp_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![&]) }
    pub fn mut_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![mut]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct SlicePat {
    pub(crate) syntax: SyntaxNode,
}
impl SlicePat {
    pub fn l_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['[']) }
    pub fn pats(&self) -> AstChildren<Pat> { support::children(&self.syntax) }
    pub fn r_brack_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![']']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TuplePat {
    pub(crate) syntax: SyntaxNode,
}
impl TuplePat {
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn fields(&self) -> AstChildren<Pat> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct TupleStructPat {
    pub(crate) syntax: SyntaxNode,
}
impl TupleStructPat {
    pub fn path(&self) -> Option<Path> { support::child(&self.syntax) }
    pub fn l_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['(']) }
    pub fn fields(&self) -> AstChildren<Pat> { support::children(&self.syntax) }
    pub fn r_paren_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![')']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordPatFieldList {
    pub(crate) syntax: SyntaxNode,
}
impl RecordPatFieldList {
    pub fn l_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['{']) }
    pub fn fields(&self) -> AstChildren<RecordPatField> { support::children(&self.syntax) }
    pub fn dotdot_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![..]) }
    pub fn r_curly_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T!['}']) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct RecordPatField {
    pub(crate) syntax: SyntaxNode,
}
impl ast::AttrsOwner for RecordPatField {}
impl RecordPatField {
    pub fn name_ref(&self) -> Option<NameRef> { support::child(&self.syntax) }
    pub fn colon_token(&self) -> Option<SyntaxToken> { support::token(&self.syntax, T![:]) }
    pub fn pat(&self) -> Option<Pat> { support::child(&self.syntax) }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum GenericArg {
    TypeArg(TypeArg),
    AssocTypeArg(AssocTypeArg),
    LifetimeArg(LifetimeArg),
    ConstArg(ConstArg),
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Type {
    ArrayType(ArrayType),
    DynTraitType(DynTraitType),
    FnPtrType(FnPtrType),
    ForType(ForType),
    ImplTraitType(ImplTraitType),
    InferType(InferType),
    NeverType(NeverType),
    ParenType(ParenType),
    PathType(PathType),
    PtrType(PtrType),
    RefType(RefType),
    SliceType(SliceType),
    TupleType(TupleType),
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Expr {
    ArrayExpr(ArrayExpr),
    AwaitExpr(AwaitExpr),
    BinExpr(BinExpr),
    BlockExpr(BlockExpr),
    BoxExpr(BoxExpr),
    BreakExpr(BreakExpr),
    CallExpr(CallExpr),
    CastExpr(CastExpr),
    ClosureExpr(ClosureExpr),
    ContinueExpr(ContinueExpr),
    EffectExpr(EffectExpr),
    FieldExpr(FieldExpr),
    ForExpr(ForExpr),
    IfExpr(IfExpr),
    IndexExpr(IndexExpr),
    Literal(Literal),
    LoopExpr(LoopExpr),
    MacroCall(MacroCall),
    MatchExpr(MatchExpr),
    MethodCallExpr(MethodCallExpr),
    ParenExpr(ParenExpr),
    PathExpr(PathExpr),
    PrefixExpr(PrefixExpr),
    RangeExpr(RangeExpr),
    RecordExpr(RecordExpr),
    RefExpr(RefExpr),
    ReturnExpr(ReturnExpr),
    TryExpr(TryExpr),
    TupleExpr(TupleExpr),
    WhileExpr(WhileExpr),
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Item {
    Const(Const),
    Enum(Enum),
    ExternBlock(ExternBlock),
    ExternCrate(ExternCrate),
    Fn(Fn),
    Impl(Impl),
    MacroCall(MacroCall),
    Module(Module),
    Static(Static),
    Struct(Struct),
    Trait(Trait),
    TypeAlias(TypeAlias),
    Union(Union),
    Use(Use),
}
impl ast::AttrsOwner for Item {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Stmt {
    ExprStmt(ExprStmt),
    Item(Item),
    LetStmt(LetStmt),
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum Pat {
    IdentPat(IdentPat),
    BoxPat(BoxPat),
    RestPat(RestPat),
    LiteralPat(LiteralPat),
    MacroPat(MacroPat),
    OrPat(OrPat),
    ParenPat(ParenPat),
    PathPat(PathPat),
    WildcardPat(WildcardPat),
    RangePat(RangePat),
    RecordPat(RecordPat),
    RefPat(RefPat),
    SlicePat(SlicePat),
    TuplePat(TuplePat),
    TupleStructPat(TupleStructPat),
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum FieldList {
    RecordFieldList(RecordFieldList),
    TupleFieldList(TupleFieldList),
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum AdtDef {
    Enum(Enum),
    Struct(Struct),
    Union(Union),
}
impl ast::AttrsOwner for AdtDef {}
impl ast::GenericParamsOwner for AdtDef {}
impl ast::NameOwner for AdtDef {}
impl ast::VisibilityOwner for AdtDef {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum AssocItem {
    Const(Const),
    Fn(Fn),
    MacroCall(MacroCall),
    TypeAlias(TypeAlias),
}
impl ast::AttrsOwner for AssocItem {}
impl ast::NameOwner for AssocItem {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum ExternItem {
    Fn(Fn),
    MacroCall(MacroCall),
    Static(Static),
    TypeAlias(TypeAlias),
}
impl ast::AttrsOwner for ExternItem {}
impl ast::NameOwner for ExternItem {}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum GenericParam {
    ConstParam(ConstParam),
    LifetimeParam(LifetimeParam),
    TypeParam(TypeParam),
}
impl ast::AttrsOwner for GenericParam {}
impl AstNode for Name {
    fn can_cast(kind: SyntaxKind) -> bool { kind == NAME }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for NameRef {
    fn can_cast(kind: SyntaxKind) -> bool { kind == NAME_REF }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Path {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PATH }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for PathSegment {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PATH_SEGMENT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for GenericArgList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == GENERIC_ARG_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ParamList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PARAM_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RetType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RET_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for PathType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PATH_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TypeArg {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TYPE_ARG }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for AssocTypeArg {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ASSOC_TYPE_ARG }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for LifetimeArg {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LIFETIME_ARG }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ConstArg {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CONST_ARG }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TypeBoundList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TYPE_BOUND_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MacroCall {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MACRO_CALL }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Attr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ATTR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TokenTree {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TOKEN_TREE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MacroItems {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MACRO_ITEMS }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MacroStmts {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MACRO_STMTS }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for SourceFile {
    fn can_cast(kind: SyntaxKind) -> bool { kind == SOURCE_FILE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Const {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CONST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Enum {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ENUM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ExternBlock {
    fn can_cast(kind: SyntaxKind) -> bool { kind == EXTERN_BLOCK }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ExternCrate {
    fn can_cast(kind: SyntaxKind) -> bool { kind == EXTERN_CRATE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Fn {
    fn can_cast(kind: SyntaxKind) -> bool { kind == FN }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Impl {
    fn can_cast(kind: SyntaxKind) -> bool { kind == IMPL }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Module {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MODULE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Static {
    fn can_cast(kind: SyntaxKind) -> bool { kind == STATIC }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Struct {
    fn can_cast(kind: SyntaxKind) -> bool { kind == STRUCT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Trait {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TRAIT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TypeAlias {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TYPE_ALIAS }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Union {
    fn can_cast(kind: SyntaxKind) -> bool { kind == UNION }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Use {
    fn can_cast(kind: SyntaxKind) -> bool { kind == USE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Visibility {
    fn can_cast(kind: SyntaxKind) -> bool { kind == VISIBILITY }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ItemList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ITEM_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Rename {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RENAME }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for UseTree {
    fn can_cast(kind: SyntaxKind) -> bool { kind == USE_TREE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for UseTreeList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == USE_TREE_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Abi {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ABI }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for GenericParamList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == GENERIC_PARAM_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for WhereClause {
    fn can_cast(kind: SyntaxKind) -> bool { kind == WHERE_CLAUSE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for BlockExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == BLOCK_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for SelfParam {
    fn can_cast(kind: SyntaxKind) -> bool { kind == SELF_PARAM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Param {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PARAM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordFieldList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_FIELD_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TupleFieldList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TUPLE_FIELD_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordField {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_FIELD }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TupleField {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TUPLE_FIELD }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for VariantList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == VARIANT_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Variant {
    fn can_cast(kind: SyntaxKind) -> bool { kind == VARIANT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for AssocItemList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ASSOC_ITEM_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ExternItemList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == EXTERN_ITEM_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ConstParam {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CONST_PARAM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for LifetimeParam {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LIFETIME_PARAM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TypeParam {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TYPE_PARAM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for WherePred {
    fn can_cast(kind: SyntaxKind) -> bool { kind == WHERE_PRED }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Literal {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LITERAL }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ExprStmt {
    fn can_cast(kind: SyntaxKind) -> bool { kind == EXPR_STMT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for LetStmt {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LET_STMT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ArrayExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ARRAY_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for AwaitExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == AWAIT_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for BinExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == BIN_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for BoxExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == BOX_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for BreakExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == BREAK_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for CallExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CALL_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for CastExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CAST_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ClosureExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CLOSURE_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ContinueExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CONTINUE_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for EffectExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == EFFECT_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for FieldExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == FIELD_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ForExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == FOR_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for IfExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == IF_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for IndexExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == INDEX_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for LoopExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LOOP_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MatchExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MATCH_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MethodCallExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == METHOD_CALL_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ParenExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PAREN_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for PathExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PATH_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for PrefixExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PREFIX_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RangeExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RANGE_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RefExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == REF_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ReturnExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RETURN_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TryExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TRY_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TupleExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TUPLE_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for WhileExpr {
    fn can_cast(kind: SyntaxKind) -> bool { kind == WHILE_EXPR }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Label {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LABEL }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordExprFieldList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_EXPR_FIELD_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordExprField {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_EXPR_FIELD }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ArgList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ARG_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for Condition {
    fn can_cast(kind: SyntaxKind) -> bool { kind == CONDITION }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MatchArmList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MATCH_ARM_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MatchArm {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MATCH_ARM }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MatchGuard {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MATCH_GUARD }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ArrayType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == ARRAY_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for DynTraitType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == DYN_TRAIT_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for FnPtrType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == FN_PTR_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ForType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == FOR_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ImplTraitType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == IMPL_TRAIT_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for InferType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == INFER_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for NeverType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == NEVER_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ParenType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PAREN_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for PtrType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PTR_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RefType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == REF_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for SliceType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == SLICE_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TupleType {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TUPLE_TYPE }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TypeBound {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TYPE_BOUND }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for IdentPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == IDENT_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for BoxPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == BOX_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RestPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == REST_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for LiteralPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == LITERAL_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for MacroPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == MACRO_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for OrPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == OR_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for ParenPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PAREN_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for PathPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == PATH_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for WildcardPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == WILDCARD_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RangePat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RANGE_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RefPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == REF_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for SlicePat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == SLICE_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TuplePat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TUPLE_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for TupleStructPat {
    fn can_cast(kind: SyntaxKind) -> bool { kind == TUPLE_STRUCT_PAT }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordPatFieldList {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_PAT_FIELD_LIST }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl AstNode for RecordPatField {
    fn can_cast(kind: SyntaxKind) -> bool { kind == RECORD_PAT_FIELD }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        if Self::can_cast(syntax.kind()) {
            Some(Self { syntax })
        } else {
            None
        }
    }
    fn syntax(&self) -> &SyntaxNode { &self.syntax }
}
impl From<TypeArg> for GenericArg {
    fn from(node: TypeArg) -> GenericArg { GenericArg::TypeArg(node) }
}
impl From<AssocTypeArg> for GenericArg {
    fn from(node: AssocTypeArg) -> GenericArg { GenericArg::AssocTypeArg(node) }
}
impl From<LifetimeArg> for GenericArg {
    fn from(node: LifetimeArg) -> GenericArg { GenericArg::LifetimeArg(node) }
}
impl From<ConstArg> for GenericArg {
    fn from(node: ConstArg) -> GenericArg { GenericArg::ConstArg(node) }
}
impl AstNode for GenericArg {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            TYPE_ARG | ASSOC_TYPE_ARG | LIFETIME_ARG | CONST_ARG => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            TYPE_ARG => GenericArg::TypeArg(TypeArg { syntax }),
            ASSOC_TYPE_ARG => GenericArg::AssocTypeArg(AssocTypeArg { syntax }),
            LIFETIME_ARG => GenericArg::LifetimeArg(LifetimeArg { syntax }),
            CONST_ARG => GenericArg::ConstArg(ConstArg { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            GenericArg::TypeArg(it) => &it.syntax,
            GenericArg::AssocTypeArg(it) => &it.syntax,
            GenericArg::LifetimeArg(it) => &it.syntax,
            GenericArg::ConstArg(it) => &it.syntax,
        }
    }
}
impl From<ArrayType> for Type {
    fn from(node: ArrayType) -> Type { Type::ArrayType(node) }
}
impl From<DynTraitType> for Type {
    fn from(node: DynTraitType) -> Type { Type::DynTraitType(node) }
}
impl From<FnPtrType> for Type {
    fn from(node: FnPtrType) -> Type { Type::FnPtrType(node) }
}
impl From<ForType> for Type {
    fn from(node: ForType) -> Type { Type::ForType(node) }
}
impl From<ImplTraitType> for Type {
    fn from(node: ImplTraitType) -> Type { Type::ImplTraitType(node) }
}
impl From<InferType> for Type {
    fn from(node: InferType) -> Type { Type::InferType(node) }
}
impl From<NeverType> for Type {
    fn from(node: NeverType) -> Type { Type::NeverType(node) }
}
impl From<ParenType> for Type {
    fn from(node: ParenType) -> Type { Type::ParenType(node) }
}
impl From<PathType> for Type {
    fn from(node: PathType) -> Type { Type::PathType(node) }
}
impl From<PtrType> for Type {
    fn from(node: PtrType) -> Type { Type::PtrType(node) }
}
impl From<RefType> for Type {
    fn from(node: RefType) -> Type { Type::RefType(node) }
}
impl From<SliceType> for Type {
    fn from(node: SliceType) -> Type { Type::SliceType(node) }
}
impl From<TupleType> for Type {
    fn from(node: TupleType) -> Type { Type::TupleType(node) }
}
impl AstNode for Type {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            ARRAY_TYPE | DYN_TRAIT_TYPE | FN_PTR_TYPE | FOR_TYPE | IMPL_TRAIT_TYPE | INFER_TYPE
            | NEVER_TYPE | PAREN_TYPE | PATH_TYPE | PTR_TYPE | REF_TYPE | SLICE_TYPE
            | TUPLE_TYPE => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            ARRAY_TYPE => Type::ArrayType(ArrayType { syntax }),
            DYN_TRAIT_TYPE => Type::DynTraitType(DynTraitType { syntax }),
            FN_PTR_TYPE => Type::FnPtrType(FnPtrType { syntax }),
            FOR_TYPE => Type::ForType(ForType { syntax }),
            IMPL_TRAIT_TYPE => Type::ImplTraitType(ImplTraitType { syntax }),
            INFER_TYPE => Type::InferType(InferType { syntax }),
            NEVER_TYPE => Type::NeverType(NeverType { syntax }),
            PAREN_TYPE => Type::ParenType(ParenType { syntax }),
            PATH_TYPE => Type::PathType(PathType { syntax }),
            PTR_TYPE => Type::PtrType(PtrType { syntax }),
            REF_TYPE => Type::RefType(RefType { syntax }),
            SLICE_TYPE => Type::SliceType(SliceType { syntax }),
            TUPLE_TYPE => Type::TupleType(TupleType { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            Type::ArrayType(it) => &it.syntax,
            Type::DynTraitType(it) => &it.syntax,
            Type::FnPtrType(it) => &it.syntax,
            Type::ForType(it) => &it.syntax,
            Type::ImplTraitType(it) => &it.syntax,
            Type::InferType(it) => &it.syntax,
            Type::NeverType(it) => &it.syntax,
            Type::ParenType(it) => &it.syntax,
            Type::PathType(it) => &it.syntax,
            Type::PtrType(it) => &it.syntax,
            Type::RefType(it) => &it.syntax,
            Type::SliceType(it) => &it.syntax,
            Type::TupleType(it) => &it.syntax,
        }
    }
}
impl From<ArrayExpr> for Expr {
    fn from(node: ArrayExpr) -> Expr { Expr::ArrayExpr(node) }
}
impl From<AwaitExpr> for Expr {
    fn from(node: AwaitExpr) -> Expr { Expr::AwaitExpr(node) }
}
impl From<BinExpr> for Expr {
    fn from(node: BinExpr) -> Expr { Expr::BinExpr(node) }
}
impl From<BlockExpr> for Expr {
    fn from(node: BlockExpr) -> Expr { Expr::BlockExpr(node) }
}
impl From<BoxExpr> for Expr {
    fn from(node: BoxExpr) -> Expr { Expr::BoxExpr(node) }
}
impl From<BreakExpr> for Expr {
    fn from(node: BreakExpr) -> Expr { Expr::BreakExpr(node) }
}
impl From<CallExpr> for Expr {
    fn from(node: CallExpr) -> Expr { Expr::CallExpr(node) }
}
impl From<CastExpr> for Expr {
    fn from(node: CastExpr) -> Expr { Expr::CastExpr(node) }
}
impl From<ClosureExpr> for Expr {
    fn from(node: ClosureExpr) -> Expr { Expr::ClosureExpr(node) }
}
impl From<ContinueExpr> for Expr {
    fn from(node: ContinueExpr) -> Expr { Expr::ContinueExpr(node) }
}
impl From<EffectExpr> for Expr {
    fn from(node: EffectExpr) -> Expr { Expr::EffectExpr(node) }
}
impl From<FieldExpr> for Expr {
    fn from(node: FieldExpr) -> Expr { Expr::FieldExpr(node) }
}
impl From<ForExpr> for Expr {
    fn from(node: ForExpr) -> Expr { Expr::ForExpr(node) }
}
impl From<IfExpr> for Expr {
    fn from(node: IfExpr) -> Expr { Expr::IfExpr(node) }
}
impl From<IndexExpr> for Expr {
    fn from(node: IndexExpr) -> Expr { Expr::IndexExpr(node) }
}
impl From<Literal> for Expr {
    fn from(node: Literal) -> Expr { Expr::Literal(node) }
}
impl From<LoopExpr> for Expr {
    fn from(node: LoopExpr) -> Expr { Expr::LoopExpr(node) }
}
impl From<MacroCall> for Expr {
    fn from(node: MacroCall) -> Expr { Expr::MacroCall(node) }
}
impl From<MatchExpr> for Expr {
    fn from(node: MatchExpr) -> Expr { Expr::MatchExpr(node) }
}
impl From<MethodCallExpr> for Expr {
    fn from(node: MethodCallExpr) -> Expr { Expr::MethodCallExpr(node) }
}
impl From<ParenExpr> for Expr {
    fn from(node: ParenExpr) -> Expr { Expr::ParenExpr(node) }
}
impl From<PathExpr> for Expr {
    fn from(node: PathExpr) -> Expr { Expr::PathExpr(node) }
}
impl From<PrefixExpr> for Expr {
    fn from(node: PrefixExpr) -> Expr { Expr::PrefixExpr(node) }
}
impl From<RangeExpr> for Expr {
    fn from(node: RangeExpr) -> Expr { Expr::RangeExpr(node) }
}
impl From<RecordExpr> for Expr {
    fn from(node: RecordExpr) -> Expr { Expr::RecordExpr(node) }
}
impl From<RefExpr> for Expr {
    fn from(node: RefExpr) -> Expr { Expr::RefExpr(node) }
}
impl From<ReturnExpr> for Expr {
    fn from(node: ReturnExpr) -> Expr { Expr::ReturnExpr(node) }
}
impl From<TryExpr> for Expr {
    fn from(node: TryExpr) -> Expr { Expr::TryExpr(node) }
}
impl From<TupleExpr> for Expr {
    fn from(node: TupleExpr) -> Expr { Expr::TupleExpr(node) }
}
impl From<WhileExpr> for Expr {
    fn from(node: WhileExpr) -> Expr { Expr::WhileExpr(node) }
}
impl AstNode for Expr {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            ARRAY_EXPR | AWAIT_EXPR | BIN_EXPR | BLOCK_EXPR | BOX_EXPR | BREAK_EXPR | CALL_EXPR
            | CAST_EXPR | CLOSURE_EXPR | CONTINUE_EXPR | EFFECT_EXPR | FIELD_EXPR | FOR_EXPR
            | IF_EXPR | INDEX_EXPR | LITERAL | LOOP_EXPR | MACRO_CALL | MATCH_EXPR
            | METHOD_CALL_EXPR | PAREN_EXPR | PATH_EXPR | PREFIX_EXPR | RANGE_EXPR
            | RECORD_EXPR | REF_EXPR | RETURN_EXPR | TRY_EXPR | TUPLE_EXPR | WHILE_EXPR => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            ARRAY_EXPR => Expr::ArrayExpr(ArrayExpr { syntax }),
            AWAIT_EXPR => Expr::AwaitExpr(AwaitExpr { syntax }),
            BIN_EXPR => Expr::BinExpr(BinExpr { syntax }),
            BLOCK_EXPR => Expr::BlockExpr(BlockExpr { syntax }),
            BOX_EXPR => Expr::BoxExpr(BoxExpr { syntax }),
            BREAK_EXPR => Expr::BreakExpr(BreakExpr { syntax }),
            CALL_EXPR => Expr::CallExpr(CallExpr { syntax }),
            CAST_EXPR => Expr::CastExpr(CastExpr { syntax }),
            CLOSURE_EXPR => Expr::ClosureExpr(ClosureExpr { syntax }),
            CONTINUE_EXPR => Expr::ContinueExpr(ContinueExpr { syntax }),
            EFFECT_EXPR => Expr::EffectExpr(EffectExpr { syntax }),
            FIELD_EXPR => Expr::FieldExpr(FieldExpr { syntax }),
            FOR_EXPR => Expr::ForExpr(ForExpr { syntax }),
            IF_EXPR => Expr::IfExpr(IfExpr { syntax }),
            INDEX_EXPR => Expr::IndexExpr(IndexExpr { syntax }),
            LITERAL => Expr::Literal(Literal { syntax }),
            LOOP_EXPR => Expr::LoopExpr(LoopExpr { syntax }),
            MACRO_CALL => Expr::MacroCall(MacroCall { syntax }),
            MATCH_EXPR => Expr::MatchExpr(MatchExpr { syntax }),
            METHOD_CALL_EXPR => Expr::MethodCallExpr(MethodCallExpr { syntax }),
            PAREN_EXPR => Expr::ParenExpr(ParenExpr { syntax }),
            PATH_EXPR => Expr::PathExpr(PathExpr { syntax }),
            PREFIX_EXPR => Expr::PrefixExpr(PrefixExpr { syntax }),
            RANGE_EXPR => Expr::RangeExpr(RangeExpr { syntax }),
            RECORD_EXPR => Expr::RecordExpr(RecordExpr { syntax }),
            REF_EXPR => Expr::RefExpr(RefExpr { syntax }),
            RETURN_EXPR => Expr::ReturnExpr(ReturnExpr { syntax }),
            TRY_EXPR => Expr::TryExpr(TryExpr { syntax }),
            TUPLE_EXPR => Expr::TupleExpr(TupleExpr { syntax }),
            WHILE_EXPR => Expr::WhileExpr(WhileExpr { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            Expr::ArrayExpr(it) => &it.syntax,
            Expr::AwaitExpr(it) => &it.syntax,
            Expr::BinExpr(it) => &it.syntax,
            Expr::BlockExpr(it) => &it.syntax,
            Expr::BoxExpr(it) => &it.syntax,
            Expr::BreakExpr(it) => &it.syntax,
            Expr::CallExpr(it) => &it.syntax,
            Expr::CastExpr(it) => &it.syntax,
            Expr::ClosureExpr(it) => &it.syntax,
            Expr::ContinueExpr(it) => &it.syntax,
            Expr::EffectExpr(it) => &it.syntax,
            Expr::FieldExpr(it) => &it.syntax,
            Expr::ForExpr(it) => &it.syntax,
            Expr::IfExpr(it) => &it.syntax,
            Expr::IndexExpr(it) => &it.syntax,
            Expr::Literal(it) => &it.syntax,
            Expr::LoopExpr(it) => &it.syntax,
            Expr::MacroCall(it) => &it.syntax,
            Expr::MatchExpr(it) => &it.syntax,
            Expr::MethodCallExpr(it) => &it.syntax,
            Expr::ParenExpr(it) => &it.syntax,
            Expr::PathExpr(it) => &it.syntax,
            Expr::PrefixExpr(it) => &it.syntax,
            Expr::RangeExpr(it) => &it.syntax,
            Expr::RecordExpr(it) => &it.syntax,
            Expr::RefExpr(it) => &it.syntax,
            Expr::ReturnExpr(it) => &it.syntax,
            Expr::TryExpr(it) => &it.syntax,
            Expr::TupleExpr(it) => &it.syntax,
            Expr::WhileExpr(it) => &it.syntax,
        }
    }
}
impl From<Const> for Item {
    fn from(node: Const) -> Item { Item::Const(node) }
}
impl From<Enum> for Item {
    fn from(node: Enum) -> Item { Item::Enum(node) }
}
impl From<ExternBlock> for Item {
    fn from(node: ExternBlock) -> Item { Item::ExternBlock(node) }
}
impl From<ExternCrate> for Item {
    fn from(node: ExternCrate) -> Item { Item::ExternCrate(node) }
}
impl From<Fn> for Item {
    fn from(node: Fn) -> Item { Item::Fn(node) }
}
impl From<Impl> for Item {
    fn from(node: Impl) -> Item { Item::Impl(node) }
}
impl From<MacroCall> for Item {
    fn from(node: MacroCall) -> Item { Item::MacroCall(node) }
}
impl From<Module> for Item {
    fn from(node: Module) -> Item { Item::Module(node) }
}
impl From<Static> for Item {
    fn from(node: Static) -> Item { Item::Static(node) }
}
impl From<Struct> for Item {
    fn from(node: Struct) -> Item { Item::Struct(node) }
}
impl From<Trait> for Item {
    fn from(node: Trait) -> Item { Item::Trait(node) }
}
impl From<TypeAlias> for Item {
    fn from(node: TypeAlias) -> Item { Item::TypeAlias(node) }
}
impl From<Union> for Item {
    fn from(node: Union) -> Item { Item::Union(node) }
}
impl From<Use> for Item {
    fn from(node: Use) -> Item { Item::Use(node) }
}
impl AstNode for Item {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            CONST | ENUM | EXTERN_BLOCK | EXTERN_CRATE | FN | IMPL | MACRO_CALL | MODULE
            | STATIC | STRUCT | TRAIT | TYPE_ALIAS | UNION | USE => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            CONST => Item::Const(Const { syntax }),
            ENUM => Item::Enum(Enum { syntax }),
            EXTERN_BLOCK => Item::ExternBlock(ExternBlock { syntax }),
            EXTERN_CRATE => Item::ExternCrate(ExternCrate { syntax }),
            FN => Item::Fn(Fn { syntax }),
            IMPL => Item::Impl(Impl { syntax }),
            MACRO_CALL => Item::MacroCall(MacroCall { syntax }),
            MODULE => Item::Module(Module { syntax }),
            STATIC => Item::Static(Static { syntax }),
            STRUCT => Item::Struct(Struct { syntax }),
            TRAIT => Item::Trait(Trait { syntax }),
            TYPE_ALIAS => Item::TypeAlias(TypeAlias { syntax }),
            UNION => Item::Union(Union { syntax }),
            USE => Item::Use(Use { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            Item::Const(it) => &it.syntax,
            Item::Enum(it) => &it.syntax,
            Item::ExternBlock(it) => &it.syntax,
            Item::ExternCrate(it) => &it.syntax,
            Item::Fn(it) => &it.syntax,
            Item::Impl(it) => &it.syntax,
            Item::MacroCall(it) => &it.syntax,
            Item::Module(it) => &it.syntax,
            Item::Static(it) => &it.syntax,
            Item::Struct(it) => &it.syntax,
            Item::Trait(it) => &it.syntax,
            Item::TypeAlias(it) => &it.syntax,
            Item::Union(it) => &it.syntax,
            Item::Use(it) => &it.syntax,
        }
    }
}
impl From<ExprStmt> for Stmt {
    fn from(node: ExprStmt) -> Stmt { Stmt::ExprStmt(node) }
}
impl From<Item> for Stmt {
    fn from(node: Item) -> Stmt { Stmt::Item(node) }
}
impl From<LetStmt> for Stmt {
    fn from(node: LetStmt) -> Stmt { Stmt::LetStmt(node) }
}
impl From<IdentPat> for Pat {
    fn from(node: IdentPat) -> Pat { Pat::IdentPat(node) }
}
impl From<BoxPat> for Pat {
    fn from(node: BoxPat) -> Pat { Pat::BoxPat(node) }
}
impl From<RestPat> for Pat {
    fn from(node: RestPat) -> Pat { Pat::RestPat(node) }
}
impl From<LiteralPat> for Pat {
    fn from(node: LiteralPat) -> Pat { Pat::LiteralPat(node) }
}
impl From<MacroPat> for Pat {
    fn from(node: MacroPat) -> Pat { Pat::MacroPat(node) }
}
impl From<OrPat> for Pat {
    fn from(node: OrPat) -> Pat { Pat::OrPat(node) }
}
impl From<ParenPat> for Pat {
    fn from(node: ParenPat) -> Pat { Pat::ParenPat(node) }
}
impl From<PathPat> for Pat {
    fn from(node: PathPat) -> Pat { Pat::PathPat(node) }
}
impl From<WildcardPat> for Pat {
    fn from(node: WildcardPat) -> Pat { Pat::WildcardPat(node) }
}
impl From<RangePat> for Pat {
    fn from(node: RangePat) -> Pat { Pat::RangePat(node) }
}
impl From<RecordPat> for Pat {
    fn from(node: RecordPat) -> Pat { Pat::RecordPat(node) }
}
impl From<RefPat> for Pat {
    fn from(node: RefPat) -> Pat { Pat::RefPat(node) }
}
impl From<SlicePat> for Pat {
    fn from(node: SlicePat) -> Pat { Pat::SlicePat(node) }
}
impl From<TuplePat> for Pat {
    fn from(node: TuplePat) -> Pat { Pat::TuplePat(node) }
}
impl From<TupleStructPat> for Pat {
    fn from(node: TupleStructPat) -> Pat { Pat::TupleStructPat(node) }
}
impl AstNode for Pat {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            IDENT_PAT | BOX_PAT | REST_PAT | LITERAL_PAT | MACRO_PAT | OR_PAT | PAREN_PAT
            | PATH_PAT | WILDCARD_PAT | RANGE_PAT | RECORD_PAT | REF_PAT | SLICE_PAT
            | TUPLE_PAT | TUPLE_STRUCT_PAT => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            IDENT_PAT => Pat::IdentPat(IdentPat { syntax }),
            BOX_PAT => Pat::BoxPat(BoxPat { syntax }),
            REST_PAT => Pat::RestPat(RestPat { syntax }),
            LITERAL_PAT => Pat::LiteralPat(LiteralPat { syntax }),
            MACRO_PAT => Pat::MacroPat(MacroPat { syntax }),
            OR_PAT => Pat::OrPat(OrPat { syntax }),
            PAREN_PAT => Pat::ParenPat(ParenPat { syntax }),
            PATH_PAT => Pat::PathPat(PathPat { syntax }),
            WILDCARD_PAT => Pat::WildcardPat(WildcardPat { syntax }),
            RANGE_PAT => Pat::RangePat(RangePat { syntax }),
            RECORD_PAT => Pat::RecordPat(RecordPat { syntax }),
            REF_PAT => Pat::RefPat(RefPat { syntax }),
            SLICE_PAT => Pat::SlicePat(SlicePat { syntax }),
            TUPLE_PAT => Pat::TuplePat(TuplePat { syntax }),
            TUPLE_STRUCT_PAT => Pat::TupleStructPat(TupleStructPat { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            Pat::IdentPat(it) => &it.syntax,
            Pat::BoxPat(it) => &it.syntax,
            Pat::RestPat(it) => &it.syntax,
            Pat::LiteralPat(it) => &it.syntax,
            Pat::MacroPat(it) => &it.syntax,
            Pat::OrPat(it) => &it.syntax,
            Pat::ParenPat(it) => &it.syntax,
            Pat::PathPat(it) => &it.syntax,
            Pat::WildcardPat(it) => &it.syntax,
            Pat::RangePat(it) => &it.syntax,
            Pat::RecordPat(it) => &it.syntax,
            Pat::RefPat(it) => &it.syntax,
            Pat::SlicePat(it) => &it.syntax,
            Pat::TuplePat(it) => &it.syntax,
            Pat::TupleStructPat(it) => &it.syntax,
        }
    }
}
impl From<RecordFieldList> for FieldList {
    fn from(node: RecordFieldList) -> FieldList { FieldList::RecordFieldList(node) }
}
impl From<TupleFieldList> for FieldList {
    fn from(node: TupleFieldList) -> FieldList { FieldList::TupleFieldList(node) }
}
impl AstNode for FieldList {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            RECORD_FIELD_LIST | TUPLE_FIELD_LIST => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            RECORD_FIELD_LIST => FieldList::RecordFieldList(RecordFieldList { syntax }),
            TUPLE_FIELD_LIST => FieldList::TupleFieldList(TupleFieldList { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            FieldList::RecordFieldList(it) => &it.syntax,
            FieldList::TupleFieldList(it) => &it.syntax,
        }
    }
}
impl From<Enum> for AdtDef {
    fn from(node: Enum) -> AdtDef { AdtDef::Enum(node) }
}
impl From<Struct> for AdtDef {
    fn from(node: Struct) -> AdtDef { AdtDef::Struct(node) }
}
impl From<Union> for AdtDef {
    fn from(node: Union) -> AdtDef { AdtDef::Union(node) }
}
impl AstNode for AdtDef {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            ENUM | STRUCT | UNION => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            ENUM => AdtDef::Enum(Enum { syntax }),
            STRUCT => AdtDef::Struct(Struct { syntax }),
            UNION => AdtDef::Union(Union { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            AdtDef::Enum(it) => &it.syntax,
            AdtDef::Struct(it) => &it.syntax,
            AdtDef::Union(it) => &it.syntax,
        }
    }
}
impl From<Const> for AssocItem {
    fn from(node: Const) -> AssocItem { AssocItem::Const(node) }
}
impl From<Fn> for AssocItem {
    fn from(node: Fn) -> AssocItem { AssocItem::Fn(node) }
}
impl From<MacroCall> for AssocItem {
    fn from(node: MacroCall) -> AssocItem { AssocItem::MacroCall(node) }
}
impl From<TypeAlias> for AssocItem {
    fn from(node: TypeAlias) -> AssocItem { AssocItem::TypeAlias(node) }
}
impl AstNode for AssocItem {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            CONST | FN | MACRO_CALL | TYPE_ALIAS => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            CONST => AssocItem::Const(Const { syntax }),
            FN => AssocItem::Fn(Fn { syntax }),
            MACRO_CALL => AssocItem::MacroCall(MacroCall { syntax }),
            TYPE_ALIAS => AssocItem::TypeAlias(TypeAlias { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            AssocItem::Const(it) => &it.syntax,
            AssocItem::Fn(it) => &it.syntax,
            AssocItem::MacroCall(it) => &it.syntax,
            AssocItem::TypeAlias(it) => &it.syntax,
        }
    }
}
impl From<Fn> for ExternItem {
    fn from(node: Fn) -> ExternItem { ExternItem::Fn(node) }
}
impl From<MacroCall> for ExternItem {
    fn from(node: MacroCall) -> ExternItem { ExternItem::MacroCall(node) }
}
impl From<Static> for ExternItem {
    fn from(node: Static) -> ExternItem { ExternItem::Static(node) }
}
impl From<TypeAlias> for ExternItem {
    fn from(node: TypeAlias) -> ExternItem { ExternItem::TypeAlias(node) }
}
impl AstNode for ExternItem {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            FN | MACRO_CALL | STATIC | TYPE_ALIAS => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            FN => ExternItem::Fn(Fn { syntax }),
            MACRO_CALL => ExternItem::MacroCall(MacroCall { syntax }),
            STATIC => ExternItem::Static(Static { syntax }),
            TYPE_ALIAS => ExternItem::TypeAlias(TypeAlias { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            ExternItem::Fn(it) => &it.syntax,
            ExternItem::MacroCall(it) => &it.syntax,
            ExternItem::Static(it) => &it.syntax,
            ExternItem::TypeAlias(it) => &it.syntax,
        }
    }
}
impl From<ConstParam> for GenericParam {
    fn from(node: ConstParam) -> GenericParam { GenericParam::ConstParam(node) }
}
impl From<LifetimeParam> for GenericParam {
    fn from(node: LifetimeParam) -> GenericParam { GenericParam::LifetimeParam(node) }
}
impl From<TypeParam> for GenericParam {
    fn from(node: TypeParam) -> GenericParam { GenericParam::TypeParam(node) }
}
impl AstNode for GenericParam {
    fn can_cast(kind: SyntaxKind) -> bool {
        match kind {
            CONST_PARAM | LIFETIME_PARAM | TYPE_PARAM => true,
            _ => false,
        }
    }
    fn cast(syntax: SyntaxNode) -> Option<Self> {
        let res = match syntax.kind() {
            CONST_PARAM => GenericParam::ConstParam(ConstParam { syntax }),
            LIFETIME_PARAM => GenericParam::LifetimeParam(LifetimeParam { syntax }),
            TYPE_PARAM => GenericParam::TypeParam(TypeParam { syntax }),
            _ => return None,
        };
        Some(res)
    }
    fn syntax(&self) -> &SyntaxNode {
        match self {
            GenericParam::ConstParam(it) => &it.syntax,
            GenericParam::LifetimeParam(it) => &it.syntax,
            GenericParam::TypeParam(it) => &it.syntax,
        }
    }
}
impl std::fmt::Display for GenericArg {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Type {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Expr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Item {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Stmt {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Pat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for FieldList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for AdtDef {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for AssocItem {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ExternItem {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for GenericParam {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Name {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for NameRef {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Path {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for PathSegment {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for GenericArgList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ParamList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RetType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for PathType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TypeArg {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for AssocTypeArg {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for LifetimeArg {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ConstArg {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TypeBoundList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MacroCall {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Attr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TokenTree {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MacroItems {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MacroStmts {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for SourceFile {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Const {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Enum {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ExternBlock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ExternCrate {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Fn {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Impl {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Module {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Static {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Struct {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Trait {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TypeAlias {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Union {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Use {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Visibility {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ItemList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Rename {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for UseTree {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for UseTreeList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Abi {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for GenericParamList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for WhereClause {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for BlockExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for SelfParam {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Param {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordFieldList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TupleFieldList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordField {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TupleField {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for VariantList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Variant {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for AssocItemList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ExternItemList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ConstParam {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for LifetimeParam {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TypeParam {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for WherePred {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Literal {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ExprStmt {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for LetStmt {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ArrayExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for AwaitExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for BinExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for BoxExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for BreakExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for CallExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for CastExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ClosureExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ContinueExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for EffectExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for FieldExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ForExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for IfExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for IndexExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for LoopExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MatchExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MethodCallExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ParenExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for PathExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for PrefixExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RangeExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RefExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ReturnExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TryExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TupleExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for WhileExpr {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Label {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordExprFieldList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordExprField {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ArgList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for Condition {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MatchArmList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MatchArm {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MatchGuard {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ArrayType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for DynTraitType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for FnPtrType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ForType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ImplTraitType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for InferType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for NeverType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ParenType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for PtrType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RefType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for SliceType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TupleType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TypeBound {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for IdentPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for BoxPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RestPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for LiteralPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for MacroPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for OrPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for ParenPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for PathPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for WildcardPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RangePat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RefPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for SlicePat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TuplePat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for TupleStructPat {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordPatFieldList {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
impl std::fmt::Display for RecordPatField {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        std::fmt::Display::fmt(self.syntax(), f)
    }
}
