#!/bin/bash
# FS133-ICD1: the build of this job, under the slot (10 GiB, 4 cpus; MEMMAX=10G BATCH=8, the brief's line).  Writes its
# pid, its whole output and its exit status under data/fs133/icd1/.  If it dies: run it again — Lake rebuilds only what
# is stale (the checkpoint is the compiled library under .lake/build).  $1 = a label for the log (default: build).
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
L="${1:-build}"
rm -f "data/fs133/icd1/$L.exit"
echo $$ > "data/fs133/icd1/$L.pid"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 4 --wait 7200 --name icd1 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh > "data/fs133/icd1/$L.log" 2>&1
rc=$?
echo "$rc" > "data/fs133/icd1/$L.exit"
exit $rc
