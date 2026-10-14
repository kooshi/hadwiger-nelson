#!/usr/bin/env bash
# FS131-KN5: elaborate lean/NameCheck.lean against the olean farm elab4.sh filled (KN5_FARM), from the worktree's root.
set -u
root=$(cd "$(dirname "$0")/../../.." && pwd)
farm=${KN5_FARM:?set KN5_FARM}
lib=$root/.lake/build/lib/lean
cd "$root"
LEAN_PATH="$farm:$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "^$lib\$" | paste -sd:)" \
  lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/kn5/lean/NameCheck.lean
