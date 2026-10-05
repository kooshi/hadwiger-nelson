#!/bin/bash
# FS131-IMM1: elaborate a scratch file against a private olean mirror (build/imm-mirror, a copy of .lake/build/lib/lean taken
# after a green build) — iteration only, never evidence; the build is ./scripts/build.sh under the slot.
# Refresh the mirror after a build: cp -a .lake/build/lib/lean/. build/imm-mirror/
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm
M=$W/build/imm-mirror
LP=$(cd "$W" && lake env printenv LEAN_PATH | sed "s#$W/.lake/build/lib/lean#$M#")
cd "$W" && LEAN_PATH=$LP lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@"
