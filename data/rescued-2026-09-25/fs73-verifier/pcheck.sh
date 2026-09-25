#!/bin/bash
# usage: pcheck.sh <pair> <brk>  -- drat-trim faithful/planted pair under the shared heavy lock
set -o pipefail
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad
cd /home/kooshi/source/lean-dir
pair=$1; brk=$2
echo "start $(date -Is) pair=$pair brk=$brk"
flock -w 3600 $S/locks/heavy.lock python3 tools/fs73v_proofcheck.py $pair $brk build/fs73v/proof-$pair-$brk.drat 20000 > $S/fs73-verifier/pcheck-$pair-$brk.json
echo "exit $? $(date -Is)"
