#!/bin/bash
# FS131-IKL1: elaborate one file under the slot (4 GiB, 2 cpus), with the lakefile's implicit options.
# Extra LEAN_PATH entries (a farm of compiled working modules) may be given in IKL1_FARM, put in front.
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1 || exit 2
source scripts/dev-env.sh 2>/dev/null
if [[ -n "${IKL1_FARM:-}" ]]; then
  exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ikl1f -- timeout 900 lake env bash -c 'LEAN_PATH="$IKL1_FARM:$LEAN_PATH" exec lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@"' _ "$@"
fi
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ikl1f -- timeout 900 lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@"
