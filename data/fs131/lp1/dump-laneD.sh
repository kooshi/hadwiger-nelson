#!/bin/bash
# FS131-LP1: lane D's two read-back prints (FS131-IPD1's file-writing dumpers, `data/fs131/ipd1/readback/laneD/
# {Release,Here}DumpFile.lean`, their output path changed to this directory and nothing else).
#   the release side at the RELEASE's pin (data/fs131/ko1/leanrel.sh: Lean v4.34.1, the audit's compiled copy);
#   this side from this tree's registered build (`lake env lean`), under the memory tool.
# Each writes <Stem>Dump.out itself; stdout/stderr of the run to <Stem>DumpFile.log/.err; exit status to <Stem>Dump.rc.
# $1 = both | release | here
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
L=$W/data/fs131/lp1/readback/laneD
which=${1:-both}
cd $W
if [ "$which" != here ]; then
  rm -f $L/ReleaseDump.out
  KO1_MEM=10 bash $W/data/fs131/ko1/leanrel.sh $L/ReleaseDumpFile.lean > $L/ReleaseDumpFile.log 2> $L/ReleaseDumpFile.err
  echo $? > $L/ReleaseDump.rc
fi
if [ "$which" != release ]; then
  rm -f $L/HereDump.out
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 2 --wait 7200 --name lp1 -- lake env lean $L/HereDumpFile.lean > $L/HereDumpFile.log 2> $L/HereDumpFile.err
  echo $? > $L/HereDump.rc
fi
