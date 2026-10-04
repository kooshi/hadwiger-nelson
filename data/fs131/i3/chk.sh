#!/bin/bash
# Iteration only, never evidence. usage: chk.sh Plane/LocalStructure   -- checks the module against the scratch olean tree (no olean written)
WT=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3
S=/home/kooshi/scratch-fs131
cd $WT
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$S:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true Proofs/HadwigerNelson/$1.lean
