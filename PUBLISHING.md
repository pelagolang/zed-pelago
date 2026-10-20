# Publishing to the Zed extensions registry

Not published yet, and nothing here is automatic: the owner opens the registry PR. Rules: <https://zed.dev/docs/extensions/publishing/overview>.

## Before the PR

- [ ] **Make the repositories public.** `zed-pelago` and `tree-sitter-pelago` are private today; the registry needs both public (Zed clones the grammar from its URL, so a private grammar cannot even be installed by others). CI's grammar checks are skipped while this repository is private.
- [ ] **Licence.** The registry's CI fails a PR without an accepted licence file (Apache 2.0, BSD 2 or 3, CC BY 4.0, GPLv3, LGPLv3, MIT, Unlicense, zlib) at the root of this repository,
  named `LICENSE*` or `LICENCE*`. The Pelago compiler's `Cargo.toml` says `MIT OR Apache-2.0`, but `ROADMAP.md` still lists "Choose a license" as open, so no file was added. `Cargo.toml` here says `Apache-2.0`; make the two agree.
- [ ] **Re-test in Zed once** at the exact commit you will submit (the registry requires it; the first try-out is done): command palette, `zed: install dev extension`, pick this folder. The checklist is in the pelago repository, `docs/plans/cards/S-05-zed-and-tree-sitter.md`.
- [ ] **Grammar pin.** `extension.toml` pins `tree-sitter-pelago` by `commit`. If the grammar or its queries changed, copy `queries/*.scm` into `languages/pelago/`, bump the commit, and run `script/check-queries.sh`.
- [ ] **Version.** `extension.toml` and `Cargo.toml` both say `0.0.1`; keep them equal and bump both for every release. The registry entry must carry the same version.
- [ ] The id `pelago` and the name `Pelago` follow the registry's rules (kebab case, no `zed` or `extension`, matches the language). On 2026-10-20 the registry's `extensions.toml` had no `pelago` entry (the part of the file that could be read, up to the `p`s).

## The registry PR

Fork `zed-industries/extensions` to your own account (not an organisation), then:

```
git clone https://github.com/<you>/extensions
cd extensions
git submodule init
git submodule update
git submodule add https://github.com/pelagolang/zed-pelago.git extensions/pelago
git add extensions/pelago
```

Add to the top-level `extensions.toml`:

```toml
[pelago]
submodule = "extensions/pelago"
version = "0.0.1"
```

Then `pnpm sort-extensions` (sorts `extensions.toml` and `.gitmodules`) and open the PR. One extension per PR; answer maintainers within three weeks.
The submodule commit must be on a branch of this repository (for example `main`) and the repository must be public.

## Updating later

Bump `version` here, push, then in a fork of the registry run `git submodule update --remote extensions/pelago`, set the new `version` in `extensions.toml`, and open a PR.

## Rules that must keep holding

- No theme: Pelago colours come from the user's own Zed theme. This repository contributes none.
- The extension does not bundle `pelago`; it finds it on `PATH` (`worktree.which`).
