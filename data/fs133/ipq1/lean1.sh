#!/bin/bash
# FS133-IPQ1: elaborate one Lean file of the worktree under the slot, with the lakefile's options (iteration only:
# `lake env lean` builds nothing and is not the build).  $1 = path relative to the worktree root; further arguments
# go to `lean`.  (FS133-ICD1's script, the slot's name changed.)
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
f="$1"; shift
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ipq1 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true "$@" "$f"
