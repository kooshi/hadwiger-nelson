#!/bin/bash
# FS131-IKC4: run probes one at a time, each in its own slot (a cap kill ends only its own slot), each line "<GiB>:<file>".
# Usage: run_probes.sh <logdir> <GiB>:<file.lean> ...   Reads only; logs <logdir>/<name>.log, <logdir>/<name>.slot.
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf
cd $W || exit 2
logdir="$1"; shift
mkdir -p "$logdir"
for spec in "$@"; do
  mem="${spec%%:*}"; f="${spec#*:}"; n="$(basename "$f" .lean)"
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "$mem" --cpus 1 \
    --wait 7200 --name ikc4 -- data/fs131/ikc4/farm.sh e "$logdir" "$f" > "$logdir/$n.slot" 2>&1
  echo "$n slot-exit $? mem $mem" >> "$logdir/slot-exits.txt"
done
echo DONE >> "$logdir/slot-exits.txt"
