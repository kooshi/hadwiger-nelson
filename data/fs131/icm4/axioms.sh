#!/bin/bash
# FS131-ICM4: print the axioms of this job's modules from the built tree, under the slot. $1 = Axioms.lean or AxiomsPlant.lean; $2 = output.
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch || exit 2
source scripts/dev-env.sh 2>/dev/null
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 2 --wait 7200 --name icm4-ax -- timeout 900 lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "data/fs131/icm4/lean/$1" > "$2" 2>&1
echo "exit=$?" > "$2.exit"
