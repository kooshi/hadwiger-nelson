#!/bin/bash
# FS131-ICM4 iteration helper (never evidence; the build is the receipt): elaborate one module of the worktree against a
# scratch farm of .olean files — a symlink copy of this tree's compiled library with the modules under work compiled
# over it (`LEAN.md` § Searching — Lean: a farm; FS133-IB2's farm1.sh). $1 = module path without .lean; $2 = "o" to
# write its .olean into the farm (the farm's symlink is removed first, so the tree's build is never written).
F=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/icm4-farm
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch
P=$W/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
cd $W || exit 2
source scripts/dev-env.sh 2>/dev/null
OUT=()
if [ "$2" = o ]; then rm -f "$F/$1.olean" "$F/$1.ilean"; mkdir -p "$(dirname "$F/$1.olean")"; OUT=(-o "$F/$1.olean"); fi
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name icm4f -- env LEAN_PATH="$F:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" timeout 900 $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true "${OUT[@]}" "$1.lean"
