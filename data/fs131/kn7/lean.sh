#!/usr/bin/env bash
# FS131-KN7: elaborate one scratch file against this worktree's built library, under the slot, with the lakefile's two
# autoImplicit options by flag; no compiled file is written. usage: data/fs131/kn7/lean.sh <file.lean> <tag> [mem]
# Log: data/fs131/kn7/logs/lean-<tag>.log, last line "exit=<status>" (read that, never a pipe's status).
set -u
cd "$(dirname "$0")/../../.."
f="$1"; tag="$2"; mem="${3:-4}"; log="data/fs131/kn7/logs/lean-$tag.log"; t0=$(date +%s)
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "$mem" --cpus 2 --wait 3600 --name kn7s -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$f" > "$log" 2>&1
st=$?; echo "seconds=$(( $(date +%s) - t0 ))" >> "$log"; echo "exit=$st" >> "$log"
echo "errors=$(grep -c ': error' "$log") exit=$st"
