#!/bin/bash
# FS131-ICL1 iteration helper (never evidence; the build is): compile one module of this job against a scratch farm with the
# lakefile's options, writing its .olean into the farm (FS131-K12A's lean1.sh, this job's farm and slot name). The farm is a
# symlink copy of the tree's compiled library with this job's modules written over it (LEAN.md § Searching — Lean).
# $1 = module path under Proofs/HadwigerNelson without .lean (e.g. Plane/WindowDensity); $2 = memory GiB (default 5);
# $3 = source file (default Proofs/HadwigerNelson/$1.lean)
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch
S=$W/build/icl1-farm
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
SRC="${3:-Proofs/HadwigerNelson/$1.lean}"
if [ ! -d "$S/Proofs" ]; then mkdir -p "$S" && cp -rs "$W/.lake/build/lib/lean/Proofs" "$S/Proofs" && ln -s "$W/.lake/build/lib/lean/Proofs.olean" "$S/Proofs.olean"; fi
mkdir -p "$S/Proofs/HadwigerNelson/$(dirname "$1")"
rm -f "$S/Proofs/HadwigerNelson/$1.olean" "$S/Proofs/HadwigerNelson/$1.ilean"
cd "$W" && exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${2:-5}" --cpus 2 --wait 7200 --name icl1 -- env LEAN_PATH="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" /usr/bin/time -f "wall=%es maxrss=%MkB" "$T/bin/lean" -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o "$S/Proofs/HadwigerNelson/$1.olean" "$SRC"
