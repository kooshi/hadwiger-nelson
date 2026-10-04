#!/usr/bin/env bash
# Usage: chk.sh Plane/StuckChain  (or an absolute .lean path) — elaborate against the scratch mirror, print all messages (iteration only)
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4; S=/home/kooshi/scratch-w4
cd $W; source scripts/dev-env.sh
LP=$(lake env printenv LEAN_PATH)
case "$1" in /*) F="$1";; *) F=Proofs/HadwigerNelson/$1.lean;; esac
LEAN_PATH=$S/lib/lean:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false $F 2>&1
