#!/usr/bin/env bash
# usage: run.sh file.lean  (scratch check against scratch oleans)
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww
source scripts/dev-env.sh
SCR=/tmp/claude-1000/-home-kooshi-source-lean-dir/97d700e3-0ed0-4032-8dcd-cebbe8c929fe/scratchpad/iw-olean
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$SCR:$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" 2>&1
