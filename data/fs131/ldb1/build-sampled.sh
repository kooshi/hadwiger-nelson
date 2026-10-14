#!/bin/bash
# FS131-LDB1 (FS133-LD1's script, its paths changed): the build ($1 = label) with FS131-LC1's sampler (data/fs131/lc1/sample-lean.sh, run unchanged) beside it;
# the sampler stops when the build has exited.  The sampler's log is data/fs131/ldb1/$1.mem.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g
cd "$W" || exit 2
L="$1"
rm -f "data/fs131/ldb1/$L.stop"
bash data/fs131/lc1/sample-lean.sh "$W" "data/fs131/ldb1/$L.mem" "data/fs131/ldb1/$L.stop" 5 &
data/fs131/ldb1/build.sh "$L"
rc=$?
touch "data/fs131/ldb1/$L.stop"
wait
exit $rc
