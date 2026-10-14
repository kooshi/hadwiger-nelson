#!/bin/bash
# FS133-LD1: the build ($1 = label) with FS131-LC1's sampler (data/fs131/lc1/sample-lean.sh, run unchanged) beside it;
# the sampler stops when the build has exited.  The sampler's log is data/fs133/ld1/$1.mem.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
L="$1"
rm -f "data/fs133/ld1/$L.stop"
bash data/fs131/lc1/sample-lean.sh "$W" "data/fs133/ld1/$L.mem" "data/fs133/ld1/$L.stop" 5 &
data/fs133/ld1/build.sh "$L"
rc=$?
touch "data/fs133/ld1/$L.stop"
wait
exit $rc
