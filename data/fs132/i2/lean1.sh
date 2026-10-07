#!/bin/bash
# FS132-I2 iteration helper (never evidence): elaborate one generated module against a scratch olean farm.
# $1 = module name under Proofs/HadwigerNelson/Outside without .lean
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/i2-olean
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi2
P=/home/kooshi/source/lean-dir/.lake/packages
mkdir -p $S/Proofs/HadwigerNelson/Outside
cd $W && exec /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 2 -- env LEAN_PATH="$S:$P/Cli/.lake/build/lib/lean:$P/batteries/.lake/build/lib/lean:$P/Qq/.lake/build/lib/lean:$P/aesop/.lake/build/lib/lean:$P/proofwidgets/.lake/build/lib/lean:$P/importGraph/.lake/build/lib/lean:$P/LeanSearchClient/.lake/build/lib/lean:$P/plausible/.lake/build/lib/lean:$P/mathlib/.lake/build/lib/lean:$W/.lake/build/lib/lean:/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/lib/lean" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o $S/Proofs/HadwigerNelson/Outside/$1.olean Proofs/HadwigerNelson/Outside/$1.lean
