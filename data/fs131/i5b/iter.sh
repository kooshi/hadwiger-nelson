#!/usr/bin/env bash
# FS131-I5b — iteration only, never evidence. Usage: iter.sh Plane/ValidMap/Chain [more modules in dependency order]
# Compiles each module's olean into a scratch mirror of .lake/build (symlinks to the real build, replaced per module),
# with the scratch first on LEAN_PATH, so dependents can be checked against edited modules. (Wave 4's iter.sh, re-pointed.)
set -e
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5
S=${S:-/home/kooshi/scratch-w5-i5b}
cd $W
source scripts/dev-env.sh
if [ ! -d $S/lib/lean/Proofs ]; then mkdir -p $S/lib/lean; cp -rs $W/.lake/build/lib/lean/Proofs $S/lib/lean/Proofs; fi
LP=$(lake env printenv LEAN_PATH)
for m in "$@"; do
  f=Proofs/HadwigerNelson/$m.lean
  o=$S/lib/lean/Proofs/HadwigerNelson/$m.olean
  rm -f $o
  echo "== $m"
  LEAN_PATH=$S/lib/lean:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o $o $f 2>&1 | grep -v "declaration uses" || true
done
