#!/bin/bash
# FS131-IRF1: one build of this worktree through ./scripts/build.sh under the slot (the brief's line), its log and exit kept.
# Usage: data/fs131/irf1/build.sh <label>   -> data/fs131/irf1/build-<label>.log, build-<label>.exit
cd "$(dirname "$0")/../../.." || exit 2
source scripts/dev-env.sh 2>/dev/null
label="$1"; log="data/fs131/irf1/build-${label}.log"
echo "HEAD=$(git rev-parse HEAD) start=$(date -u +%Y-%m-%dT%H:%M:%SZ) dirty=$(git status --porcelain --untracked-files=no | wc -l)" > "$log"
SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 5 --wait 3600 --name "irf1-build-${label}" -- env MEMMAX=8G BATCH=3 ./scripts/build.sh >> "$log" 2>&1
st=$?
echo "exit=$st end=$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$log"
echo "$st" > "data/fs131/irf1/build-${label}.exit"
