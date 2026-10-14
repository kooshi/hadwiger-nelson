#!/bin/bash
# FS131-ICM4: the guarded environment lint (LEAN.md § The gate), under the slot. $1 = log path.
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch || exit 2
source scripts/dev-env.sh 2>/dev/null
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 7 --cpus 2 --wait 7200 --name icm4-lint -- lake lint --no-build -- --no-build --trace > "$1" 2>&1
echo "exit=$?" > "$1.exit"
