#!/bin/bash
# FS131-IPB1 (FS131-IPA1's farm-run.sh, its log folder changed): elaborate one generated module in the scratch farm (the planner's data/fs131/ko1/farm1.sh, unchanged)
# and keep its log.  $1 = module (e.g. OAI158SmallArcs), $2 = try label (e.g. try1).
# Writes data/fs131/ipb1/farm/<module>-<try>.out (lean's stdout+stderr) and .rc (the exit status, read directly),
# and .time (wall seconds).  The olean goes to build/ko1-farm (the tree's ignored build/).
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
D=$W/data/fs131/ipb1/farm
mkdir -p "$D" "$W/build/ko1-farm/Proofs/HadwigerNelson/Outside"
t0=$(date +%s)
bash "$W/data/fs131/ko1/farm1.sh" "$1" > "$D/$1-$2.out" 2>&1
rc=$?
t1=$(date +%s)
echo "$rc" > "$D/$1-$2.rc"
echo "$((t1 - t0))" > "$D/$1-$2.time"
echo "$1 $2 rc=$rc $((t1 - t0))s errors=$(grep -c ': error' "$D/$1-$2.out") warnings=$(grep -c ': warning' "$D/$1-$2.out")"
