#!/bin/bash
# FS131-ICM2: elaborate one file under the slot (4 GiB, 2 cpus), with the lakefile's implicit options.
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch || exit 2
source scripts/dev-env.sh 2>/dev/null
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name icm2 -- timeout 900 lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@"
