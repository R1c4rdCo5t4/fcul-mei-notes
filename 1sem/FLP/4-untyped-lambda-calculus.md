# Untyped Lambda Calculus

### Overview
- A formal system for expressing computation via function abstraction and application.
- Language of purely anonymous functions that is **Turing Complete** (can compute any program that has or will ever be made).
### Syntax
- **Variable**: `x`
- **Abstraction**: `λx.t` (a function with parameter `x` and body `t`)
- **Application**: `t1 t2` (applying function `t1` to argument `t2`)

### Variable Scope, Bound and Free Variables
- **Free Variables**: Variables that are not bound by any abstraction in the term.
- **Bound Variables**: Variables that appear within the body of an abstraction and are introduced by the `λ`:
	- Example: In `λx.x y`, `x` is **bound** (by `λx`), and `y` is **free**.
- **Scope of a Variable**: The region of a lambda expression where the variable is bound.
    - In `λx.(x (λy.y))`, the scope of `x` is the entire body `x (λy.y)`.

### Substitution
- **Substitution**: replacing free occurrences of a variable with another term in an expression.
    - Notation: `[x → s]t` means substitute `x` with `s` in the term `t`.
- **Rules**:
    - If the variable to be replaced is bound, no substitution is done within the scope of that binder.
    - Avoid variable capture: When substituting, ensure that no free variables in the term being substituted become accidentally bound by a lambda abstraction in the target.

### Operational Semantics
- **Beta-Reduction**: the main evaluation rule, where `(λx.t1) t2` reduces by substituting `t2` for `x` in `t1`.
- **Evaluation Strategies**:
    - **Full Beta-Reduction**: any redex (reducible expression) can be reduced at any time.
    - **Normal Order**: the outermost, leftmost redex is reduced first.
    - **Call-by-Value**: only reduces a redex when its argument is a value (already reduced).
    - **Call-by-Name**: reduces the outermost redex first without evaluating the argument; arguments are substituted as is and only evaluated when needed in the function body.

### Programming in λ-Calculus
- **Multiple arguments**: simulated via currying, where a function with multiple parameters is rewritten as a sequence of a single-parameter functions:
	- Example: `f = λx.λy.s` instead of `f(x, y)`.
- **Booleans**:
	- `true = λt.λf.t`
	- `false = λt.λf.f`
- **Logical operations**:
	- `and = λb.λc. b c false`
	- `or = λb.λc. b true c`
	- `not = λb. b false true`
- **Conditional**:
	- `if = λb.λt.λf. b t f`
	- Example: `if true then t else f` becomes `if true t f`, which reduces to `t`.
- **Pairs**:
	- A pair can be encoded as a function that takes a selector (either `fst` or `snd`).
	- **Pair construction**: `pair = λx.λy.λs. s x y`
	- **First element (fst)**: `fst = λp. p (λx.λy.x)`
	- **Second element (snd)**: `snd = λp. p (λx.λy.y)`
		- Example: `pair 1 2` would store `1` and `2` and `fst (pair 1 2)` would return `1`.