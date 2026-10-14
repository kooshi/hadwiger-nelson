#!/bin/bash
# FS131-IPD1: dump every constant of the named modules from the scratch farm's oleans (LEAN_PATH =
# data/fs131/ipa1/leanpath-farm.txt) under the memory tool.  $1 = output stem (a path under the tree, no suffix);
# $2 = comma-separated module names under Proofs/HadwigerNelson/Outside (e.g. OAI158Basic,OAI158Centers).
# Writes <stem>.lean, <stem>.out (stdout), <stem>.err, <stem>.rc (the exit status, read directly).
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
O=$W/$1
mkdir -p "$(dirname "$O")"
{ for m in ${2//,/ }; do echo "import Proofs.HadwigerNelson.Outside.$m"; done
  cat $W/data/fs131/ipd1/lean/ModuleDumpHead.lean
  printf '#eval FS131IPD1Dump.run ['; first=1
  for m in ${2//,/ }; do [ $first = 1 ] || printf ', '; printf '`Proofs.HadwigerNelson.Outside.%s' "$m"; first=0; done
  echo ']'; } > "$O.lean"
LP=$(tr -d '\n' < $W/data/fs131/ipa1/leanpath-farm.txt)
cd $W
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem ${DUMP_MEM:-10} --cpus 2 --wait 7200 --name ipd1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean "$O.lean" > "$O.out" 2> "$O.err"
echo $? > "$O.rc"
echo "dump $1: rc=$(cat $O.rc) $(tail -1 $O.out)"
