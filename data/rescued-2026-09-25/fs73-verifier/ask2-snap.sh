#!/bin/bash
# usage: ask2.sh <pair> <brk> <pysat-solver> <seed> <budget_s>  -- a PySAT ask under the shared heavy lock (no proof)
set -o pipefail
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad
cd /home/kooshi/source/lean-dir
echo "start $(date -Is) $*"
flock -w 3600 $S/locks/heavy.lock /usr/bin/time -f "time %U user %S sys %M KB %e wall" python3 tools/fs73v_sat.py $1 --brk $2 --solver $3 --seed $4 --budget $5 --out $S/fs73-verifier/asks.jsonl > $S/fs73-verifier/ask2-$1-$2-$3-$4.json
echo "exit $? $(date -Is)"
