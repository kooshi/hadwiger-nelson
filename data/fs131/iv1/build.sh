#!/usr/bin/env bash
# FS131-IV1: the one build, under the slot, from the worktree root; its status is read from the script, never a pipe.
# usage: data/fs131/iv1/build.sh <tag>     writes logs/<tag>.{start,out,err,time,exit,end}
# If it dies, the relaunch is the same command: build.sh redoes only the batch in progress.
set -u
cd "$(dirname "$0")/../../.." || exit 2
tag="data/fs131/iv1/logs/${1:-build1}"
date -u +"%Y-%m-%d %H:%M:%S UTC" > "$tag.start"
git rev-parse HEAD >> "$tag.start"
/usr/bin/time -v -o "$tag.time" env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py \
  --mem 10 --cpus 4 --wait 7200 --name iv1 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh > "$tag.out" 2> "$tag.err"
st=$?
echo "$st" > "$tag.exit"
date -u +"%Y-%m-%d %H:%M:%S UTC" > "$tag.end"
tail -3 "$tag.out"
echo "build-exit=$st"
exit $st
