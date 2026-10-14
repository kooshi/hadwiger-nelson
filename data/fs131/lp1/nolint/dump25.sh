#!/bin/bash
# FS131-LP1: FS131-IPD1's module dumper (data/fs131/ipd1/lean/ModuleDumpHead.lean, unchanged) over lanes A-C's 25
# generated modules (data/fs131/ipd1/modules25.txt), from this tree's build by `lake env lean`, under the memory tool.
# $1 = output stem under data/fs131/lp1/nolint/.  Writes <stem>.lean, .out, .err, .rc.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
O=$W/data/fs131/lp1/nolint/$1
M=$(tr -d '\n ' < $W/data/fs131/ipd1/modules25.txt)
{ for m in ${M//,/ }; do echo "import Proofs.HadwigerNelson.Outside.$m"; done
  cat $W/data/fs131/ipd1/lean/ModuleDumpHead.lean
  printf '#eval FS131IPD1Dump.run ['; first=1
  for m in ${M//,/ }; do [ $first = 1 ] || printf ', '; printf '`Proofs.HadwigerNelson.Outside.%s' "$m"; first=0; done
  echo ']'; } > "$O.lean"
cd $W
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 --wait 7200 --name lp1 -- lake env lean "$O.lean" > "$O.out" 2> "$O.err"
echo $? > "$O.rc"
echo "dump $1: rc=$(cat $O.rc) $(tail -1 $O.out)"
