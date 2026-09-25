#!/bin/bash
cd /home/kooshi/source/lean-dir
P="python3 tools/fs79_p0.py"
L="flock -w 14400 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock"
echo "STAGE cheap-screen $(date -Is)"
$L $P screen --ids all --budget 30 --theta_cap 60 --noquot
echo "STAGE deep-screen $(date -Is)"
$L $P screen --ids survivors --budget 120 --theta_cap 900 --quot_total 900
$P price
echo "STAGE classify43 $(date -Is)"
$L $P classify --q 43 --k 4 --maxsize 7 --budget 60
echo "CHAIN FINISHED $(date -Is)"
