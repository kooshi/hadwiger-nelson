#!/usr/bin/env bash
# Iteration only, never evidence: elaborate one Woodall module with the lakefile's options against scratch oleans.
# usage: data/fs131/iw/iter.sh Collar|NoFourFive|Steps   (writes the scratch olean so downstream modules see edits)
set -uo pipefail
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww
source scripts/dev-env.sh
SCR=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/iw-olean
mkdir -p $SCR/Proofs/HadwigerNelson/Plane/Woodall
m=$1
rm -f $SCR/Proofs/HadwigerNelson/Plane/Woodall/$m.olean $SCR/Proofs/HadwigerNelson/Plane/Woodall/$m.ilean
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$SCR:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -DmaxHeartbeats=400000 \
  -o $SCR/Proofs/HadwigerNelson/Plane/Woodall/$m.olean Proofs/HadwigerNelson/Plane/Woodall/$m.lean 2>&1
