fn main() {
    let A = 3;
    //~^ ERROR refutable pattern in local binding: `i32::MIN..=1_i32` and
    //~| interpreted as a constant pattern, not a new variable
    //~| HELP introduce a variable instead
    //~| SUGGESTION a_var

    const A: i32 = 2;
    //~^ constant defined here
}
