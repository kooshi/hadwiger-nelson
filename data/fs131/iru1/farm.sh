#!/bin/bash
# FS131-IRU1 iteration helper (never evidence; the build is the receipt): elaborate one module of this worktree against a
# scratch farm of .olean files — a symlink copy of the tree's compiled library (`build/iru1-farm`, gitignored), the
# module's own .olean written into the farm (its symlink removed first) when $2 = o, so `.lake/build` is never written.
# After FS133-IB2's farm1.sh and FS131-K12A's lean1.sh. Usage: farm.sh <path under Proofs/HadwigerNelson, no .lean> [o|-] [GiB]
#   An optional $4 names a source file to compile under the module's name instead of the module's own (a copy under data/).
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/il5
F=$W/build/iru1-farm
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
cd "$W" || exit 2
if [ ! -d "$F/Proofs" ]; then mkdir -p "$F" && cp -rs "$W/.lake/build/lib/lean/Proofs" "$F/Proofs" && ln -s "$W/.lake/build/lib/lean/Proofs.olean" "$F/Proofs.olean"; fi
SRC="${4:-Proofs/HadwigerNelson/$1.lean}"
OUT=()
if [ "${2:--}" = o ]; then mkdir -p "$F/Proofs/HadwigerNelson/$(dirname "$1")"; rm -f "$F/Proofs/HadwigerNelson/$1.olean"; OUT=(-o "$F/Proofs/HadwigerNelson/$1.olean"); fi
ROOT=()
[ -n "${4:-}" ] && ROOT=(--root="${SRC%/Proofs/HadwigerNelson/$1.lean}")
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${3:-6}" --cpus 2 --wait 7200 --name iru1f -- env LEAN_PATH="$F:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true "${ROOT[@]}" "${OUT[@]}" "$SRC"
