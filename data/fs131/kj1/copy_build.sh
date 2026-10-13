#!/usr/bin/env bash
# FS131-KJ1 stage 2: make this worktree's .lake/build a replica of the build of the tree that gated the residue module
# (fs131-wnf, gate green at c2f4e4f54; its library is main's at 39fee2edb), instead of recompiling the modules main changed
# under Plane/ and Outside/. rsync compares by content (--checksum), copies what differs, deletes what the source lacks, and
# itemizes every change; a second, dry run must then itemize nothing (the comparison). Lake's own trace check at the build is
# the third reading: only the modules whose sources differ from the gated tree may be rebuilt.
set -u
SRC=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf/.lake/build/
DST=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc/.lake/build/
LOG=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc/data/fs131/kj1/logs
rsync -a --checksum --delete --itemize-changes "$SRC" "$DST" > "$LOG/copy_build.itemized.txt" 2> "$LOG/copy_build.err"
echo "copy exit=$?" > "$LOG/copy_build.done"
rsync -a --checksum --delete --itemize-changes --dry-run "$SRC" "$DST" > "$LOG/copy_build.verify.txt" 2>> "$LOG/copy_build.err"
echo "verify exit=$? lines=$(wc -l < "$LOG/copy_build.verify.txt")" >> "$LOG/copy_build.done"
