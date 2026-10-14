#!/bin/bash
# FS131-IPD1 (FS131-IPB1's dump.sh, the here side's LEAN_PATH the farm of the whole library, data/fs131/ipd1/leanpath-farm2.txt): run the read-back's two dumps for one label directory (relative to the tree).
#   ReleaseDump.lean at the RELEASE's pin (data/fs131/ko1/leanrel.sh: Lean v4.34.1, the audit's compiled copy);
#   HereDump.lean at THIS pin from the scratch farm's oleans (LEAN_PATH = data/fs131/ipd1/leanpath-farm2.txt).
# Each under the memory tool; stdout to <Stem>.out (then xz), stderr to <Stem>.err, exit status to <Stem>.rc.
# $1 = label directory, e.g. data/fs131/ipb1/readback/laneB-centers; $2 = which (both | release | here)
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
L=$W/$1
which=${2:-both}
cd $W
if [ "$which" != here ]; then
  KO1_MEM=10 bash $W/data/fs131/ko1/leanrel.sh $L/ReleaseDump.lean > $L/ReleaseDump.out 2> $L/ReleaseDump.err
  echo $? > $L/ReleaseDump.rc
fi
if [ "$which" != release ]; then
  LP=$(tr -d '\n' < $W/data/fs131/ipd1/leanpath-farm2.txt)
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 2 --wait 7200 --name ipd1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean $L/HereDump.lean > $L/HereDump.out 2> $L/HereDump.err
  echo $? > $L/HereDump.rc
fi
