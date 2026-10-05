#!/usr/bin/env bash
# Iteration only, never evidence. Usage: iter.sh Plane/ValidMap/FlankUA [more modules in dependency order]
# Compiles each module's olean into a scratch mirror of .lake/build (symlinks to the real build, replaced per module),
# with the scratch first on LEAN_PATH, so dependents can be checked against edited modules. (FS131-I5d; wave 4's iter.sh, re-pointed.)
set -e
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5
S=${S:-/home/kooshi/scratch-w5d}
cd $W
source scripts/dev-env.sh
if [ ! -d $S/lib/lean/Proofs ]; then mkdir -p $S/lib/lean; cp -rs $W/.lake/build/lib/lean/Proofs $S/lib/lean/Proofs; fi
LP=$(lake env printenv LEAN_PATH)
for m in "$@"; do
  f=Proofs/HadwigerNelson/$m.lean
  [ -f "$f" ] || f=$m
  o=$S/lib/lean/Proofs/HadwigerNelson/$m.olean
  mkdir -p $(dirname $o)
  rm -f $o
  LEAN_PATH=$S/lib/lean:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o $o $f 2>&1 | grep -v "declaration uses" || true
done
