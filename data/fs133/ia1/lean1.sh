#!/bin/bash
# FS133-IA1: elaborate one Lean file of the worktree under the slot, with the lakefile's two options (iteration only:
# `lake env lean` builds nothing and is not the build).  $1 = path relative to the worktree root; further arguments
# go to `lean` (e.g. `-o <olean>`).
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
f="$1"; shift
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ia1 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" "$f"
