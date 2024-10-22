
# Untyped Arithmetic Expressions
### Overview
- **Focus**: building a formal system for modeling untyped arithmetic expressions
- **Purpose**: introduces basic concepts of operational semantics using arithmetic expressions and is a foundation for more complex typed systems developed later

### Syntax
Set of expressions defined by:
- Constants `0`, `true` and `false` 
- Operation `succ(t)` and `pred(t)` (successor/predecessor)
- Conditional `if t1 then t2 else t3` and `iszero(t)`
- Expression grammar: `t ::= 0 | true | false | succ(t) | pred(t) | iszero(t) | if t1 then t2 else t3`

### Semantics
- **Big-step operational semantics:** evaluates the entire expression in one step
	- e.g. `succ(0) -> 1`, `pred(succ(0)) -> 0`
- **Small-step operational semantics:** evaluates in incremental steps
	- Useful for understanding stepwise execution of programs
	- Focuses on a single step of computation for each rule

### Evaluation Rules
- **Values**: the results of evaluations
	- `v ::= 0 | true | false | succ(v)`
	- Only fully reduced forms are considered values
- **Rules**:
	- **EF-IfTrue**: `if true then t1 else t2 -> t1`
	- **EF-IfFalse**: `if false then t1 else t2 -> t2`
	- **EF-If**: `if t1 then t2 else t3 -> if t1' then t2 else t3` (if `t1 -> t1'`)
	- **EF-Succ**: `succ(t1) -> succ(t1')` (if `t1 -> t1'`)
	- **EF-PredZero**: `pred(0) -> 0`
	- **EF-PredSucc**: `pred(succ(nv)) -> nv` (where `nv` is a numeric value)
	- **EF-Pred**: `pred(t1) -> pred(t1')` (if `t1 -> t1'`)
	- **EF-IsZeroZero**: `iszero(0) -> true`
	- **EF-IsZeroSucc**: `iszero(succ(nv)) -> false` (where `nv` is a numeric value)
	- **EF-IsZero**: `iszero(t1) -> iszero(t1')` (if `t1 -> t1'`)

- **Determinacy**: if `t -> t1` and `t -> t2` then `t1 = t2`

### Splitting an Expression into a Tree
1. Identify the root
2. Break down sub-expressions
3. Repeat recursively

```haskell
e.g. if iszero(pred(succ(0))) then succ(0) else 0

            if
          /  |   \
    iszero succ(0) 0
        |
      pred
        |
      succ
        |
        0
```


> Based on Chapter 3 of Types and Programming Languages, Benjamin C. Pierce, The MIT Press