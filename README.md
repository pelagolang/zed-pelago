<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
    <img alt="Pelago" src="assets/logo.svg" width="240">
  </picture>
</p>

# Pelago for Zed

Language support for [Pelago](https://github.com/pelagolang/pelago) (`.pel` files) in the Zed editor.

- **Colours, brackets, indents, outline:** from the Tree-sitter grammar in `pelagolang/tree-sitter-pelago`, pinned by commit in `extension.toml`.
  The query files in `languages/pelago/` are copies of that repository's `queries/`; copy them again when the grammar changes and bump the commit.
- **Language server:** the extension starts `pelago lsp` (errors as you type, hover, go to definition, references, completion). The `pelago` tool must be on your `PATH` (on Windows the folder that holds `pelago.exe`, or `cargo install --path compiler` in the compiler repository); restart Zed after changing `PATH`.

## Icons

The logo above is in `assets/`. Zed takes file icons from the user's icon theme, and as far as the extension documentation shows, a language extension has no way to set an icon or a registry image, so there is nothing more to wire in here.

## Try it locally

Zed: command palette, "zed: install dev extension", choose this folder. (Zed builds the grammar and the Rust part itself; you need a Rust toolchain
installed with `rustup`.) Check the Zed log if a grammar fails to build: the generated `parser.c` is large.

## Checking the Rust part by itself

```
rustup target add wasm32-wasip2
cargo build --release --target wasm32-wasip2
```

`script/check-queries.sh` checks that the files in `languages/pelago/` are exact copies of the ones in the pinned grammar commit. CI runs both,
and also builds the pinned grammar to wasm the way Zed does.

## Publishing

Not published yet; see [PUBLISHING.md](PUBLISHING.md) for what the Zed registry needs.

## Licence

MIT OR Apache-2.0, at your option: see `LICENSE-MIT` and `LICENSE-APACHE`.
