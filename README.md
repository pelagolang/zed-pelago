# Pelago for Zed

Language support for [Pelago](https://github.com/pelagolang/pelago) (`.pel` files) in the Zed editor.

- **Colours, brackets, indents, outline:** from the Tree-sitter grammar in `pelagolang/tree-sitter-pelago`, pinned by commit in `extension.toml`.
  The query files in `languages/pelago/` are copies of that repository's `queries/`; copy them again when the grammar changes and bump the commit.
- **Language server:** the extension starts `pelago lsp` (errors as you type, hover, go to definition, references, completion). The `pelago` tool must be on your `PATH`.

## Try it locally

Zed: command palette, "zed: install dev extension", choose this folder. (Zed builds the grammar and the Rust part itself; you need a Rust toolchain
installed with `rustup`.) Check the Zed log if a grammar fails to build: the generated `parser.c` is large.

## Checking the Rust part by itself

```
rustup target add wasm32-wasip1
cargo build --release --target wasm32-wasip1
```
