//! FIXME: write short doc here

use super::*;

pub(super) fn opt_generic_param_list(p: &mut Parser) {
    if !p.at(T![<]) {
        return;
    }
    generic_param_list(p);
}

fn generic_param_list(p: &mut Parser) {
    assert!(p.at(T![<]));
    let m = p.start();
    p.bump(T![<]);

    while !p.at(EOF) && !p.at(T![>]) {
        let m = p.start();

        // test generic_lifetime_type_attribute
        // fn foo<#[derive(Lifetime)] 'a, #[derive(Type)] T>(_: &'a T) {
        // }
        attributes::outer_attrs(p);

        match p.current() {
            LIFETIME => lifetime_param(p, m),
            IDENT => type_param(p, m),
            CONST_KW => const_param(p, m),
            _ => {
                m.abandon(p);
                p.err_and_bump("expected type parameter")
            }
        }
        if !p.at(T![>]) && !p.expect(T![,]) {
            break;
        }
    }
    p.expect(T![>]);
    m.complete(p, GENERIC_PARAM_LIST);
}

fn lifetime_param(p: &mut Parser, m: Marker) {
    assert!(p.at(LIFETIME));
    p.bump(LIFETIME);
    if p.at(T![:]) {
        lifetime_bounds(p);
    }
    m.complete(p, LIFETIME_PARAM);
}

fn type_param(p: &mut Parser, m: Marker) {
    assert!(p.at(IDENT));
    name(p);
    if p.at(T![:]) {
        bounds(p);
    }
    // test type_param_default
    // struct S<T = i32>;
    if p.at(T![=]) {
        p.bump(T![=]);
        types::type_(p)
    }
    m.complete(p, TYPE_PARAM);
}

// test const_param
// struct S<const N: u32>;
fn const_param(p: &mut Parser, m: Marker) {
    assert!(p.at(CONST_KW));
    p.bump(T![const]);
    name(p);
    types::ascription(p);
    m.complete(p, CONST_PARAM);
}

// test type_param_bounds
// struct S<T: 'a + ?Sized + (Copy)>;
pub(super) fn bounds(p: &mut Parser) {
    assert!(p.at(T![:]));
    p.bump(T![:]);
    bounds_without_colon(p);
}

fn lifetime_bounds(p: &mut Parser) {
    assert!(p.at(T![:]));
    p.bump(T![:]);
    while p.at(LIFETIME) {
        p.bump(LIFETIME);
        if !p.eat(T![+]) {
            break;
        }
    }
}

pub(super) fn bounds_without_colon_m(p: &mut Parser, marker: Marker) -> CompletedMarker {
    while type_bound(p) {
        if !p.eat(T![+]) {
            break;
        }
    }

    marker.complete(p, TYPE_BOUND_LIST)
}

pub(super) fn bounds_without_colon(p: &mut Parser) {
    let m = p.start();
    bounds_without_colon_m(p, m);
}

fn type_bound(p: &mut Parser) -> bool {
    let m = p.start();
    let has_paren = p.eat(T!['(']);
    p.eat(T![?]);
    match p.current() {
        LIFETIME => p.bump(LIFETIME),
        T![for] => types::for_type(p),
        _ if paths::is_use_path_start(p) => types::path_type_(p, false),
        _ => {
            m.abandon(p);
            return false;
        }
    }
    if has_paren {
        p.expect(T![')']);
    }
    m.complete(p, TYPE_BOUND);

    true
}

// test where_clause
// fn foo()
// where
//    'a: 'b + 'c,
//    T: Clone + Copy + 'static,
//    Iterator::Item: 'a,
//    <T as Iterator>::Item: 'a
// {}
pub(super) fn opt_where_clause(p: &mut Parser) {
    if !p.at(T![where]) {
        return;
    }
    let m = p.start();
    p.bump(T![where]);

    while is_where_predicate(p) {
        where_predicate(p);

        let comma = p.eat(T![,]);

        if is_where_clause_end(p) {
            break;
        }

        if !comma {
            p.error("expected comma");
        }
    }

    m.complete(p, WHERE_CLAUSE);
}

fn is_where_predicate(p: &mut Parser) -> bool {
    match p.current() {
        LIFETIME => true,
        T![impl] => false,
        token => types::TYPE_FIRST.contains(token),
    }
}

fn is_where_clause_end(p: &mut Parser) -> bool {
    matches!(p.current(), T!['{'] | T![;] | T![=])
}

fn where_predicate(p: &mut Parser) {
    let m = p.start();
    match p.current() {
        LIFETIME => {
            p.bump(LIFETIME);
            if p.at(T![:]) {
                bounds(p);
            } else {
                p.error("expected colon");
            }
        }
        T![impl] => {
            p.error("expected lifetime or type");
        }
        _ => {
            // test where_pred_for
            // fn for_trait<F>()
            // where
            //    for<'a> F: Fn(&'a str)
            // { }
            if p.at(T![for]) {
                types::for_binder(p);
            }

            types::type_(p);

            if p.at(T![:]) {
                bounds(p);
            } else {
                p.error("expected colon");
            }
        }
    }
    m.complete(p, WHERE_PRED);
}
