#!/bin/bash
# elaborate the experimental copy (module name from --root) against the farm; no olean written
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
LP=$(tr -d '\n' < $W/data/fs131/ipa1/leanpath-farm.txt)
cd $W/build/ipd1/expt && env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 2 --wait 7200 --name ipd1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean --root=. -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true Proofs/HadwigerNelson/Outside/$1.lean
