#!/bin/bash
# FS131-ICO2 iteration helper (a copy of FS131-ICO1's lean1.sh) (never evidence; the build is): compile one module against a scratch farm, with the
# lakefile's options (FS131-K12A's lean1.sh, this worktree). The farm is a symlink copy of the tree's compiled library with
# the modules under work written over it (LEAN.md § Searching — Lean). $1 = module path under Proofs/HadwigerNelson without
# .lean, or a path to a .lean file elsewhere (then $3 names the module path it is compiled as); $2 = memory GiB (default 6).
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/kcl1
S=$W/build/ico1-farm
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
if [ ! -d "$S/Proofs" ]; then mkdir -p "$S" && cp -rs "$W/.lake/build/lib/lean/Proofs" "$S/Proofs" && ln -s "$W/.lake/build/lib/lean/Proofs.olean" "$S/Proofs.olean"; fi
SRC="Proofs/HadwigerNelson/$1.lean"; MOD="$1"
if [ -f "$1" ]; then SRC="$1"; MOD="${3:?module path needed}"; fi
mkdir -p "$S/Proofs/HadwigerNelson/$(dirname "$MOD")"
rm -f "$S/Proofs/HadwigerNelson/$MOD.olean" "$S/Proofs/HadwigerNelson/$MOD.ilean"
cd "$W" && exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${2:-6}" --cpus 2 --wait 7200 --name ico2 -- env LEAN_PATH="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" "$T/bin/lean" -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o "$S/Proofs/HadwigerNelson/$MOD.olean" "$SRC"
