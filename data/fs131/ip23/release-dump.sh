#!/usr/bin/env bash
# FS131-IP23: print the release's declarations at the RELEASE's pin: elaborate the scratch file
# build/fs131-ip23/readback/ReleaseDump.lean (the release's text and the dumper; ignored by git) with `lake env lean`
# in the audit's working copy of the release (/home/kooshi/.cache/ext-oai1/lean), which writes no compiled file.
# Output: data/fs131/ip23/readback/ReleaseDump.out (stdout), .err (stderr), .exit.  (FS131-IE1's release-dump.sh.)
set -u
W="$(cd "$(dirname "$0")/../../.." && pwd)"
R=/home/kooshi/.cache/ext-oai1/lean
O="$W/data/fs131/ip23/readback"
cd "$R" || exit 1
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 --wait 7200 --name ip23-rel -- \
  lake env lean "$W/build/fs131-ip23/readback/ReleaseDump.lean" > "$O/ReleaseDump.out" 2> "$O/ReleaseDump.err"
echo "$?" > "$O/ReleaseDump.exit"
echo "exit=$(cat "$O/ReleaseDump.exit")"
