#!/bin/bash
# FS131-KO1 iteration helper: elaborate one generated module at THIS pin (v4.32.0) with the lakefile's options by flag,
# writing its .olean into the scratch farm `build/ko1-farm` (first on LEAN_PATH; it holds only ported modules, so it
# serves modules whose imports are ported modules and Mathlib).  $1 = module name under Proofs/HadwigerNelson/Outside.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
S=$W/build/ko1-farm
P=/home/kooshi/source/lean-dir/.lake/packages
LP="$S"; for d in Cli batteries Qq aesop proofwidgets importGraph LeanSearchClient plausible mathlib; do LP="$LP:$P/$d/.lake/build/lib/lean"; done
LP="$LP:/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/lib/lean"
cd $W && exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem ${KO1_MEM:-6} --cpus 2 --wait 7200 --name ko1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean --root=. -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o $S/Proofs/HadwigerNelson/Outside/$1.olean Proofs/HadwigerNelson/Outside/$1.lean
