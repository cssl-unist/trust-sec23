// only-x86_64

#![feature(asm)]

fn main() {
    let mut foo = 0;
    unsafe {
        asm!("", options(nomem, readonly));
        //~^ ERROR the `nomem` and `readonly` options are mutually exclusive
        asm!("", options(pure, nomem, noreturn));
        //~^ ERROR the `pure` and `noreturn` options are mutually exclusive
        //~^^ ERROR asm with `pure` option must have at least one output
        asm!("{}", in(reg) foo, options(pure, nomem));
        //~^ ERROR asm with `pure` option must have at least one output
        asm!("{}", out(reg) foo, options(noreturn));
        //~^ ERROR asm outputs are not allowed with the `noreturn` option
    }
}
