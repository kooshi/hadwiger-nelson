#!/usr/bin/env bash
# FS131-RS1's build wrapper (RW2's pattern): runs the slotted build from the worktree and ALWAYS appends an exit-status line.
# usage: data/fs131/rs/rs1-build.sh <logname>   (log goes to data/fs131/rs/<logname>.log); run it from a snapshot copy under build/
set -u
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p || { echo "EXIT 99 (no worktree)"; exit 99; }
LOG="data/fs131/rs/$1.log"
echo "START $(date -u +%Y%m%dT%H%M%SZ) HEAD $(git rev-parse --short HEAD)" > "$LOG"
/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh >> "$LOG" 2>&1
rc=$?
echo "EXIT $rc $(date -u +%Y%m%dT%H%M%SZ)" >> "$LOG"
exit $rc
