#!/bin/bash
# FS131-KPD1 iteration helper (never evidence; the build is): elaborate one module of Rigidity/ against a scratch olean farm
# (a symlink copy of this tree's compiled Proofs with the modules under work written over it; LEAN.md § Searching — Lean).
# $1 = module name under Proofs/HadwigerNelson/Rigidity without .lean; $2 (optional) = source file to compile instead.
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/kpd1-farm
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1
P=/home/kooshi/source/lean-dir/.lake/packages
T=/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0
if [ ! -d $S/Proofs ]; then mkdir -p $S && cp -as $W/.lake/build/lib/lean/Proofs $S/; fi
SRC=${2:-Proofs/HadwigerNelson/Rigidity/$1.lean}
OUT=$S/Proofs/HadwigerNelson/Rigidity/$1.olean
rm -f $OUT
cd $W && exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 5 --cpus 2 --wait 7200 --name kpd1 -- env LEAN_PATH="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$T/lib/lean" $T/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o $OUT $SRC
