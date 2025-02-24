# Regex Syntax

## Basic Characters

| Pattern | Description |
|---------|-------------|
| `a`  | Matches the character "a" |
| `.`  | Any character except newline |
| `\d` | Any digit (0-9) |
| `\D` | Any non-digit |
| `\w` | Any word character (a-z, A-Z, 0-9, _) |
| `\W` | Any non-word character |
| `\s` | Any whitespace character (space, tab, newline) |
| `\S` | Any non-whitespace character |

## Anchors

| Pattern | Description |
|---------|-------------|
| `^`  | Start of a string |
| `$`  | End of a string |
| `\b` | Word boundary |
| `\B` | Not a word boundary |

## Quantifiers

| Pattern | Description |
|---------|-------------|
| `*`  | 0 or more times |
| `+`  | 1 or more times |
| `?`  | 0 or 1 time |
| `{n}` | Exactly `n` times |
| `{n,}` | `n` or more times |
| `{n,m}` | Between `n` and `m` times |

## Character Classes

| Pattern | Description |
|---------|-------------|
| `[abc]` | Matches "a", "b", or "c" |
| `[^abc]` | Matches anything except "a", "b", or "c" |
| `[a-z]` | Matches any lowercase letter |
| `[A-Z]` | Matches any uppercase letter |
| `[0-9]` | Matches any digit |

## Groups & Capturing

| Pattern | Description |
|---------|-------------|
| `(abc)` | Capturing group for "abc" |
| `(?:abc)` | Non-capturing group |
| `\1` | Backreference to first capturing group |

## Logical OR & Lookarounds

| Pattern    | Description                                           |
| ---------- | ----------------------------------------------------- |
| `a\|b`     | Matches "a" or "b"                                    |
| `(?=abc)`  | Lookahead: Matches if "abc" follows                   |
| `(?!abc)`  | Negative Lookahead: Matches if "abc" does NOT follow  |
| `(?<=abc)` | Lookbehind: Matches if preceded by "abc"              |
| `(?<!abc)` | Negative Lookbehind: Matches if NOT preceded by "abc" |

## Escaping Special Characters

| Pattern | Description            |
|---------|------------------------|
| `\.` | Matches a literal `.`  |
| `\*` | Matches a literal `*`  |
| `\?` | Matches a literal `?`  |
| `\|` | Matches a literal `\|` |
| `\(` | Matches a literal `(`  |
| `\)` | Matches a literal `)`  |

## Common Examples

| Pattern | Matches |
|---------|---------|
| `^\d{3}-\d{2}-\d{4}$` | Social Security Number (###-##-####) |
| `\b[A-Z][a-z]+\b` | Capitalized words |
| `\d{1,2}/\d{1,2}/\d{4}` | Date format (MM/DD/YYYY or DD/MM/YYYY) |
| `\w+@\w+\.\w+` | Basic email pattern |