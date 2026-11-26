# Changelog

## 0.1.0

- Highlighting, brackets, indents and outline follow the pinned `tree-sitter-pelago` grammar, which now parses braid types (`braid<A, B; N>`, `(a, b; N)`), `x!` / `x!!`, mode marks in function types, and colours the 128/256-bit integer and `float16`..`float256` types and the window type `[T..]`.
- Comment settings for the Pelago comment forms: `///` line, `///* *///` block, `//~` doc line.
- The language server starts `pelago lsp`; `pelago` must be on `PATH`.
- No theme is shipped: colours come from your Zed theme.

## 0.0.1

- First version: grammar pin, queries and language server hook (not published).
