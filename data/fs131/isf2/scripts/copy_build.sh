#!/usr/bin/env bash
# FS131-ISF2: copy main's compiled files for the four RationalFour modules (main's, not this branch's) into this
# worktree's .lake/build, by checksum, those files only (LEAN.md § Building, FS131-ICS1/IRU2's restricted copy).
# Listings of both sides before and after: data/fs131/isf2/logs/copy-*.
set -u
W=/home/kooshi/source/lean-dir/.claude/worktrees/kcs1; M=/home/kooshi/source/lean-dir
L=$W/data/fs131/isf2/logs; mkdir -p "$L"
cd "$M" && find .lake/build -path '*/RationalFour/*' -type f | sort > "$L/copy-files.txt"
echo "files to copy: $(wc -l < "$L/copy-files.txt")"
(cd "$M" && xargs -a "$L/copy-files.txt" sha256sum) > "$L/copy-main-before.sha256"
(cd "$W" && for f in $(cat "$L/copy-files.txt"); do [ -f "$f" ] && sha256sum "$f" || echo "ABSENT  $f"; done) > "$L/copy-wt-before.sha256"
rsync -a --checksum --itemize-changes --files-from="$L/copy-files.txt" "$M/" "$W/" > "$L/copy-rsync.out"; st=$?
echo "rsync exit=$st itemized=$(wc -l < "$L/copy-rsync.out")"
(cd "$W" && xargs -a "$L/copy-files.txt" sha256sum) > "$L/copy-wt-after.sha256"
(cd "$M" && xargs -a "$L/copy-files.txt" sha256sum) > "$L/copy-main-after.sha256"
cmp -s "$L/copy-wt-after.sha256" "$L/copy-main-before.sha256" && echo "worktree after = main before: EQUAL" || { echo "worktree after != main before"; exit 1; }
cmp -s "$L/copy-main-after.sha256" "$L/copy-main-before.sha256" && echo "main unchanged during the copy: EQUAL" || { echo "main changed during the copy"; exit 1; }
exit $st
