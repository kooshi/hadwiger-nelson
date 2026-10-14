#!/bin/bash
# One file through `lake env lean` under the slot, from the worktree (FS131-IDB1). Usage: lean1.sh <file> [mem GiB]
f="$1"; mem="${2:-4}"
source /home/kooshi/source/lean-dir/scripts/dev-env.sh 2>/dev/null
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "$mem" --cpus 2 --wait 7200 --name idb1 -- bash -c "cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g && /usr/bin/time -f 'TIME %e s  RSS %M KB' lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $f"
