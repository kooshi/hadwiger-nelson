#!/bin/bash
# usage: ask.sh <pair> <brk> <budget_s>   -- one Glucose ask under the shared heavy lock, proof to build/fs73v/
set -o pipefail
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad
cd /home/kooshi/source/lean-dir
pair=$1; brk=$2; bud=$3
echo "start $(date -Is) pair=$pair brk=$brk budget=$bud" 
flock -w 1800 $S/locks/heavy.lock python3 tools/fs73v_sat.py $pair --brk $brk --solver glucose-ext --budget $bud \
   --proof build/fs73v/proof-$pair-$brk.drat --out $S/fs73-verifier/asks.jsonl > $S/fs73-verifier/ask-$pair-$brk.json
echo "exit $? $(date -Is)"
