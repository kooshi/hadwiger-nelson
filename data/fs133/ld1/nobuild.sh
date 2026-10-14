#!/bin/bash
# FS133-LD1: ask Lake, under the slot, whether any module is out of date (builds nothing). $1 = log label.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ld1 -- lake build --no-build > "data/fs133/ld1/$1.log" 2>&1
rc=$?
echo "exit $rc" >> "data/fs133/ld1/$1.log"
exit $rc
