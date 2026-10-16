#!/bin/bash
# FS131-ICO2: one build through scripts/build.sh under the slot (the brief's line). $1 = log name under data/fs131/ico2/.
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/kcl1
L=$W/data/fs131/ico2/${1:?log name}.log
cd "$W" || exit 2
{ echo "start $(date -u +%FT%TZ) at $(git rev-parse --short HEAD)"; } > "$L"
SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 10 --name ico2-build -- env MEMMAX=16G BATCH=6 ./scripts/build.sh >> "$L" 2>&1
rc=$?
echo "exit=$rc $(date -u +%FT%TZ)" >> "$L"
exit $rc
