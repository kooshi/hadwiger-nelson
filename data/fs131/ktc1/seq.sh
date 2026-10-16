#!/usr/bin/env bash
# Compile the new skeleton modules in order into the worktree's build directory (iteration only; the build is the check).
set -euo pipefail
cd /home/kooshi/source/lean-dir/.claude/worktrees/kel1
for mod in "$@"; do
  f="Proofs/HadwigerNelson/CayleyThree/$mod.lean"
  o=".lake/build/lib/lean/Proofs/HadwigerNelson/CayleyThree/$mod.olean"
  mkdir -p "$(dirname "$o")"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$o" "$f"
done
