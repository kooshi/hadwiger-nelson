#!/bin/bash
# FS131-KO1: bring a compiled library into this tree from fs131-wrc (read only there), and compare by checksum.
set -u
SRC=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc/.lake/build
DST=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/.lake/build
OUT=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1/data/fs131/ko1/copy
date -u +%FT%TZ > $OUT/started.txt
git -C /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc rev-parse HEAD > $OUT/source-head.txt
(cd $SRC && find . -type f -print0 | sort -z | xargs -0 sha256sum) > $OUT/source-before.sha256; echo "src-before exit=$?" >> $OUT/status.txt
test -e $DST && { echo "DST exists, refusing" >> $OUT/status.txt; exit 3; }
cp -a $SRC $DST; echo "cp exit=$?" >> $OUT/status.txt
(cd $DST && find . -type f -print0 | sort -z | xargs -0 sha256sum) > $OUT/dest.sha256; echo "dst exit=$?" >> $OUT/status.txt
(cd $SRC && find . -type f -print0 | sort -z | xargs -0 sha256sum) > $OUT/source-after.sha256; echo "src-after exit=$?" >> $OUT/status.txt
cmp $OUT/source-before.sha256 $OUT/dest.sha256; echo "cmp before-dest exit=$?" >> $OUT/status.txt
cmp $OUT/source-before.sha256 $OUT/source-after.sha256; echo "cmp before-after exit=$?" >> $OUT/status.txt
wc -l < $OUT/dest.sha256 >> $OUT/status.txt
date -u +%FT%TZ > $OUT/finished.txt
