#!/bin/bash
# FS131-LEB gate, run from inside the worktree; each step's exit status is written to data/fs131/leb/gate.status.
# Resume: re-run this script (every step is idempotent; the build is incremental).
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-leb
SLOT=/home/kooshi/source/lean-dir/scripts/slot.py
OUT=data/fs131/leb
: > $OUT/gate.status
$SLOT --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh > $OUT/gate-build.log 2>&1; echo "build $?" >> $OUT/gate.status
$SLOT --mem 24 --cpus 4 -- ./scripts/axioms.sh > $OUT/gate-axioms.log 2>&1; echo "axioms $?" >> $OUT/gate.status
$SLOT --mem 24 --cpus 4 -- ./scripts/vacuity.sh > $OUT/gate-vacuity.log 2>&1; echo "vacuity $?" >> $OUT/gate.status
$SLOT --mem 24 --cpus 4 -- ./scripts/vacuity.sh --self-test > $OUT/gate-vacuity-selftest.log 2>&1; echo "vacuity-selftest $?" >> $OUT/gate.status
python3 tools/check_architecture.py > $OUT/gate-arch.log 2>&1; echo "arch $?" >> $OUT/gate.status
grep -rn --include="*.lean" "sorry" Proofs/HadwigerNelson/Topology > $OUT/gate-sorry.log 2>&1; echo "sorry-grep $? (1 = none found)" >> $OUT/gate.status
echo "DONE" >> $OUT/gate.status
