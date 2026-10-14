#!/bin/bash
# FS131-LP1, queued after the self-test: lane D's level one at both pins; the build of the docstring commit; the stored
# statements after the build; lane D's print at this pin from the rebuilt library.  Each step's exit status in
# data/fs131/lp1/queue1/<step>.rc, its time in <step>.time; a step's failure stops the queue.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
Q=$W/data/fs131/lp1/queue1; mkdir -p $Q
D=$W/data/fs131/lp1/readback/laneD
S="env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --wait 7200 --name lp1"
cd $W
# wait for the self-test's process group (it reads this pin's print, which the last step rewrites)
PG=$(cat $D/selftest.pgid)
while kill -0 -$PG 2>/dev/null; do sleep 20; done
echo "self-test group $PG gone at $(date -u +%FT%TZ)" > $Q/waited
step() { local n=$1; shift; local t0=$(date +%s); "$@"; local rc=$?; echo $rc > $Q/$n.rc; echo $(( $(date +%s) - t0 )) > $Q/$n.time; [ $rc -eq 0 ] || { echo "STOP at $n rc=$rc" > $Q/STOPPED; exit $rc; }; }
step level1-release bash -c "KO1_MEM=10 bash $W/data/fs131/ko1/leanrel.sh $D/ReleaseLevel1.lean > $D/ReleaseLevel1.out 2> $D/ReleaseLevel1.err; rc=\$?; echo \$rc > $D/ReleaseLevel1.rc; [ \$rc -le 1 ]"
step level1-here bash -c "$S --mem 8 --cpus 2 -- lake env lean $D/HereLevel1.lean > $D/HereLevel1.out 2> $D/HereLevel1.err"
step build bash -c "/usr/bin/time -v $S --mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh > $W/data/fs131/lp1/build/build1.log 2> $W/data/fs131/lp1/build/build1.time"
step stmt-after bash -c "$S --mem 8 --cpus 2 -- lake env lean data/fs131/lp1/lean/StmtDump.lean > data/fs131/lp1/stmt/after.out 2> data/fs131/lp1/stmt/after.err"
step dump-here bash data/fs131/lp1/dump-laneD.sh here
echo ALL-DONE > $Q/DONE
