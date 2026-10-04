#!/usr/bin/env bash
# Iteration only (FS131-IC1). Usage: chk.sh <abs .lean path> — elaborate against the scratch mirror, print the messages
# (each cut to 240 characters, at most 12 lines after each error/warning header).
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c; S=/home/kooshi/scratch-w4c
cd $W; source scripts/dev-env.sh
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$S/lib/lean:$LP timeout 1200 lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$1" 2>&1 | awk '/: (error|warning)/{n=14} n>0{print substr($0,1,240); n--}'
