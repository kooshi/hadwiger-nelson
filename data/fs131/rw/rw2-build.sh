#!/usr/bin/env bash
# FS131-RW2's build wrapper: runs the slotted build from the worktree and ALWAYS appends an exit-status line.
# usage: data/fs131/rw/rw2-build.sh <logname>   (log goes to data/fs131/rw/<logname>.log)
set -u
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p || { echo "EXIT 99 (no worktree)"; exit 99; }
LOG="data/fs131/rw/$1.log"
echo "START $(date -u +%Y%m%dT%H%M%SZ)" > "$LOG"
/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh >> "$LOG" 2>&1
rc=$?
echo "EXIT $rc $(date -u +%Y%m%dT%H%M%SZ)" >> "$LOG"
exit $rc
