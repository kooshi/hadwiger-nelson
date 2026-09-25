#!/bin/bash
cd /home/kooshi/source/lean-dir
python3 tools/fs79_p0.py screen --ids survivors --budget 60 --theta_cap 60 --quot_total 120 --quot_nmax 12
/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-phase0/checkall.sh
echo "QPASS FINISHED $(date -Is)"
