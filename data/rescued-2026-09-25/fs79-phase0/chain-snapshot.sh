#!/bin/bash
cd /home/kooshi/source/lean-dir
P="python3 tools/fs79_p0.py"
L="flock -w 7200 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock"
echo "chain start $(date -Is)"
$L $P recheck --budget 600
$L $P sweep --mmin 1 --mmax 2520 --budget 120
$L $P sweep --mlist 420,840,1260,1680,2100,2520,2940,3360,3780,4200,4620,5040,5460,5880,6300,6720,7140,7560,7980,8400,8820,9240,9660,10080,10500,10920,11340,11760,12180,12600,13020,13440,13860,14280,14700,15120,15540,15960,16380,16800,17220,17640,18060,18480,18900,19320,19740,20160,20580,21000,21420,21840,22260,22680,23100,23520,23940,24360,24780,25200,25620,26040,26460,26880,27300,27720,28140,28560,28980,29400,29820,30240 --budget 120
$L $P additive --mmax 30240
$L $P screen --ids auto --budget 60 --quot_total 900 --theta_cap 300
$L $P refusal-controls --budget 1800
$P price
echo "CHAIN FINISHED $(date -Is)"
