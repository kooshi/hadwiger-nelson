#!/usr/bin/env bash
# FS131-IJ2: elaborate one Lean file under the slot with the lakefile's two autoImplicit options (iteration only:
# never a verdict on a module; `LEAN.md` § Building). (FS131-IJ1's `lean1.sh`, for this job.)
# usage: data/fs131/ij2/lean1.sh <file.lean> <log> [extra lean args]      (paths relative to the worktree)
# stdout+stderr of lean go to <log>; its last two lines are "seconds=<n>" and "exit=<status>" (read those, never a
# pipe's status).
set -u
cd "$(dirname "$0")/../../.."
f="$1"; log="$2"; shift 2
t0=$(date +%s)
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ij2 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" "$f" > "$log" 2>&1
st=$?
echo "seconds=$(( $(date +%s) - t0 ))" >> "$log"; echo "exit=$st" >> "$log"
tail -2 "$log"
