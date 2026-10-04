#!/bin/bash
# Iteration only, never evidence. usage: iter.sh Plane/RingBand   (module path under Proofs/HadwigerNelson)
# Scratch olean tree: S=/home/kooshi/scratch-fs131 (disk). Mirrors worktree .lake/build/lib/lean by symlink; a recompiled module replaces its symlink.
set -e
WT=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3
S=/home/kooshi/scratch-fs131
M=$1
cd $WT
if [ ! -d $S/Proofs ]; then mkdir -p $S; cp -rs $WT/.lake/build/lib/lean/Proofs $S/Proofs; fi
LP=$(lake env printenv LEAN_PATH)
OUT=$S/Proofs/HadwigerNelson/$M.olean
rm -f $OUT $S/Proofs/HadwigerNelson/$M.ilean
LEAN_PATH=$S:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o $OUT Proofs/HadwigerNelson/$M.lean
