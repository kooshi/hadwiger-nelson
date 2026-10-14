#!/bin/bash
# FS131-LP1: elaborate the generator_unitary evidence file and its planted control at this pin, from this tree's build,
# each under the memory tool; stdout to <stem>.out, stderr to <stem>.err, exit status to <stem>.rc.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
R=$W/data/fs131/lp1/rfl
cd $W
for f in GeneratorUnitary GeneratorUnitaryPlant; do
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 2 --wait 7200 --name lp1 -- lake env lean $R/$f.lean > $R/$f.out 2> $R/$f.err
  echo $? > $R/$f.rc
done
