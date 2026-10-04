#!/usr/bin/env bash
# Iteration only, never evidence: elaborate a file with the lakefile's options against the built oleans
# (and, first on the path, a private scratch olean dir for edited Woodall modules).
# usage: data/fs131/iwb/run.sh <file.lean> [-o out.olean]
set -uo pipefail
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww
source scripts/dev-env.sh
SCR=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww/build/iwb-olean
mkdir -p $SCR/Proofs/HadwigerNelson/Plane/Woodall
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$SCR:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false -DmaxHeartbeats=400000 "$@" 2>&1
