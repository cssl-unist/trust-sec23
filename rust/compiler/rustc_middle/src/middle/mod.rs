pub mod codegen_fn_attrs;
pub mod cstore;
pub mod dependency_format;
pub mod exported_symbols;
pub mod lang_items;
pub mod lib_features {
    use rustc_data_structures::fx::{FxHashMap, FxHashSet};
    use rustc_span::symbol::Symbol;

    #[derive(HashStable)]
    pub struct LibFeatures {
        // A map from feature to stabilisation version.
        pub stable: FxHashMap<Symbol, Symbol>,
        pub unstable: FxHashSet<Symbol>,
    }

    impl LibFeatures {
        pub fn to_vec(&self) -> Vec<(Symbol, Option<Symbol>)> {
            let mut all_features: Vec<_> = self
                .stable
                .iter()
                .map(|(f, s)| (*f, Some(*s)))
                .chain(self.unstable.iter().map(|f| (*f, None)))
                .collect();
            all_features.sort_unstable_by_key(|f| f.0.as_str());
            all_features
        }
    }
}
pub mod limits;
pub mod privacy;
pub mod region;
pub mod resolve_lifetime;
pub mod stability;
