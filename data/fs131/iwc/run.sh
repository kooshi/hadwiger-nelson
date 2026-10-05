#!/usr/bin/env bash
# FS131-IWc iteration only, never evidence: elaborate a file with the lakefile's options against the built oleans in .lake/build
# (read only; nothing is written there). usage: data/fs131/iwc/run.sh <file.lean> [lean args...]
set -uo pipefail
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww
source scripts/dev-env.sh
LP=$(lake env printenv LEAN_PATH)
LEAN_PATH=$LP timeout 1200 lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" 2>&1
