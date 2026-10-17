#!/usr/bin/env bash
# FS131-ISF2: the lint's negative control. With the plant in RationalFour/Forbid (working tree only), build under the
# slot, then run the gate's lint step; then the caller restores the file and rebuilds. Logs: data/fs131/isf2/lintplant/.
cd /home/kooshi/source/lean-dir/.claude/worktrees/kcs1 || exit 2
source scripts/dev-env.sh
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
d=data/fs131/isf2/lintplant; tag="$1"
python3 scripts/slot.py --mem 16 --cpus 10 --name "isf2-build-$tag" -- env MEMMAX=16G BATCH=4 ./scripts/build.sh > "$d/build-$tag.log" 2>&1
st=$?; echo "build exit=$st" >> "$d/build-$tag.log"
if [ "$st" -ne 0 ]; then echo "STEP build-$tag exit=$st"; exit "$st"; fi
python3 scripts/slot.py --mem 8 --cpus 4 --name "isf2-lint-$tag" -- lake lint --no-build -- --no-build --trace > "$d/lint-$tag.log" 2>&1
st=$?; echo "lint exit=$st" >> "$d/lint-$tag.log"
echo "STEP lint-$tag exit=$st"
