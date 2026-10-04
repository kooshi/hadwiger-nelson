#!/usr/bin/env bash
# Iteration only, never evidence (FS131-IC1). Usage: iter.sh Plane/ValidMap/Contact [more modules in dependency order]
# Compiles each module's olean into a scratch mirror of the worktree's .lake/build (symlinks to the real build, the
# rebuilt module's link replaced by a real file), with the scratch first on LEAN_PATH, so dependents check against edits.
set -e
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c
S=/home/kooshi/scratch-w4c
cd $W
source scripts/dev-env.sh
if [ ! -d $S/lib/lean/Proofs ]; then mkdir -p $S/lib/lean; cp -rs $W/.lake/build/lib/lean/Proofs $S/lib/lean/Proofs; fi
LP=$(lake env printenv LEAN_PATH)
for m in "$@"; do
  f=Proofs/HadwigerNelson/$m.lean
  o=$S/lib/lean/Proofs/HadwigerNelson/$m.olean
  i=$S/lib/lean/Proofs/HadwigerNelson/$m.ilean
  mkdir -p $(dirname $o)
  rm -f $o $i
  LEAN_PATH=$S/lib/lean:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o $o -i $i $f 2>&1 | grep -v "declaration uses" || true
done
