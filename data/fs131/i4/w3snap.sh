#!/usr/bin/env bash
# Iteration only: compile the seven wave-3 modules AS THEY STAND on branch fs131-w3 into the scratch olean mirror, so wave 4's
# modules can be iterated against wave 3's proved engines (the worktree itself stays unmerged until wave 3 lands).
set -e
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4
S=/home/kooshi/scratch-w4
cd $W; source scripts/dev-env.sh
LP=$(lake env printenv LEAN_PATH)
mkdir -p $S/src/Proofs/HadwigerNelson/Plane
for m in Chord Lens LocalStructure Tiles SixFragment RingGerm; do
  git show fs131-w3:Proofs/HadwigerNelson/Plane/$m.lean > $S/src/Proofs/HadwigerNelson/Plane/$m.lean
  o=$S/lib/lean/Proofs/HadwigerNelson/Plane/$m.olean
  rm -f $o
  (cd $S/src && ELAN_TOOLCHAIN=$(cat $W/lean-toolchain) LEAN_PATH=$S/lib/lean:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o $o Proofs/HadwigerNelson/Plane/$m.lean 2>&1 | grep -v "declaration uses" || true)
  echo "built $m"
done
