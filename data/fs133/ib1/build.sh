#!/bin/bash
# FS133-IB1: the one build of this job, under the slot (12 GiB, 4 cpus; MEMMAX=12G BATCH=4).  Writes its pid, its
# whole output and its exit status under data/fs133/ib1/.  If it dies: run it again — Lake rebuilds only what is
# stale (the checkpoint is the compiled library under .lake/build).
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
rm -f data/fs133/ib1/build.exit
echo $$ > data/fs133/ib1/build.pid
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 4 --wait 7200 --name ib1 -- env MEMMAX=12G BATCH=4 ./scripts/build.sh > data/fs133/ib1/build.log 2>&1
rc=$?
echo "$rc" > data/fs133/ib1/build.exit
exit $rc
