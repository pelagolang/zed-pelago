#!/bin/sh
# The query files in languages/pelago/ must be exact copies of the ones in the grammar commit that extension.toml pins.
# Usage: script/check-queries.sh            (needs git and network access to GitHub)
set -eu
here=$(cd "$(dirname "$0")/.." && pwd)
repo=$(sed -n 's/^repository = "\(.*tree-sitter-pelago\)"/\1/p' "$here/extension.toml")
commit=$(sed -n 's/^commit = "\(.*\)"/\1/p' "$here/extension.toml")
[ -n "$repo" ] && [ -n "$commit" ] || { echo "no grammar repository or commit in extension.toml" >&2; exit 2; }
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
git init -q "$tmp"
git -C "$tmp" fetch -q --depth 1 "$repo" "$commit"
git -C "$tmp" checkout -q FETCH_HEAD
status=0
for f in "$tmp"/queries/*.scm; do
  name=$(basename "$f")
  if ! cmp -s "$f" "$here/languages/pelago/$name"; then echo "DIFFERS: languages/pelago/$name"; status=1; fi
done
for f in "$here"/languages/pelago/*.scm; do
  [ -f "$tmp/queries/$(basename "$f")" ] || { echo "EXTRA: $f is not in the grammar"; status=1; }
done
[ $status -eq 0 ] && echo "queries match the grammar at $commit"
exit $status
