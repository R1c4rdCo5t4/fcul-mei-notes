# Typed Arithmetic Expressions

### Overview
- The goal is to avoid "stuck terms" (e.g. `succ false`), which represent erroneous programs.
- Types ensure that terms evaluate correctly without reaching such states.
- Evaluating a term → normal form (value)

The syntax for arithmetic expressions includes:
- **Boolean constants:** `true`, `false`;
- **Numeric constants:** `0`, `succ t`, `pred t`, `iszero t`;
- **Conditionals:** `if t1 then t2 else t2`.
#### Values
- **Booleans**: `true`, `false`.
- **Numeric values**: `0`, `succ nv`, `pred nv`.
#### Types
- `Bool`: for boolean terms.
- `Nat`: for numeric terms.

```
T ::= Nat | Str
```

### Reduction, Typification and Soundness
- "Well-typed programs do not go wrong"
- **Progress Theorem**: well-typed terms either evaluate to a value or take a step in evaluation:
	- If `e : T`, then either `e val` or there exists `e′` such that `e → e′`.
- **Preservation Theorem**: well-typed terms preserve their type throughout the evaluation:
	- If `e : T` and `e → e′`, then `e′ : T`.
- Safety = Progress + Preservation

> Based on Chapter 8 of Types and Programming Languages, Benjamin C. Pierce, The MIT Press