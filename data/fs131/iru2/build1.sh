#!/usr/bin/env bash
# FS131-IRU2: the merged tree's build, under the slot with the brief's command line; log, exit and wall to data/fs131/iru2/.
cd /home/kooshi/source/lean-dir/.claude/worktrees/il5 || exit 2
source scripts/dev-env.sh 2>/dev/null
D=data/fs131/iru2; t0=$(date +%s)
SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 --name iru2-build1 -- env MEMMAX=8G BATCH=3 ./scripts/build.sh > $D/build1-full.log 2>&1
st=$?; echo "exit=$st wall=$(( $(date +%s) - t0 ))s" > $D/build1.exit
