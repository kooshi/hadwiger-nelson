#!/usr/bin/env bash
# FS131-IP23: print the ported declarations at THIS pin from the compiled modules (data/fs131/ip23/readback/HereDump.lean
# under `lake env lean`).  Output: data/fs131/ip23/readback/HereDump.out (stdout), .err (stderr), .exit.
set -u
W="$(cd "$(dirname "$0")/../../.." && pwd)"
O="$W/data/fs131/ip23/readback"
cd "$W" || exit 1
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ip23 -- \
  lake env lean "$O/HereDump.lean" > "$O/HereDump.out" 2> "$O/HereDump.err"
echo "$?" > "$O/HereDump.exit"
echo "exit=$(cat "$O/HereDump.exit")"
