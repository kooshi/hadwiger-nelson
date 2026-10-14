#!/bin/bash
# FS131-K12A: elaborate one scratch leaf file against the farm (as lean1.sh), timed. $1 = path under data/fs131/k12a/leaves
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch
S=$W/build/k12a-farm
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
cd "$W" && exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${2:-5}" --cpus 2 --wait 7200 --name k12a -- env LEAN_PATH="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" /usr/bin/time -f "wall=%es maxrss=%MkB" "$T/bin/lean" -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=false "data/fs131/k12a/leaves/$1"
