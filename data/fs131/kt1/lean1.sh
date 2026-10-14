#!/usr/bin/env bash
# FS131-KT1: elaborate one Lean file under the slot (lakefile options passed by hand: lake env lean does not apply them).
# usage: data/fs131/kt1/lean1.sh <file.lean> <logname> [<olean out path>]
# The log is data/fs131/kt1/logs/<logname>.log; its last line is "exit=<status>" (read that, never a pipe's status).
set -u
cd "$(dirname "$0")/../../.."
file="$1"; name="$2"; out="${3:-}"
log="data/fs131/kt1/logs/$name.log"
args=(-DautoImplicit=false -DrelaxedAutoImplicit=false)
if [ -n "$out" ]; then mkdir -p "$(dirname "$out")"; args+=(-o "$out"); fi
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 600 --name kt1 -- \
  lake env lean "${args[@]}" "$file" > "$log" 2>&1
echo "exit=$?" >> "$log"
