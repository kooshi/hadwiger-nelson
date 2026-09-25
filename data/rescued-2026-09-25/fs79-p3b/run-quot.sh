#!/bin/bash
cd /home/kooshi/source/lean-dir
t0=$(date +%s)
python3 tools/fs79_p3b_theta4.py quot --ids 2448 --nmin 11 --nmax 11 --budget 300 --total 1800
used=$(( $(date +%s) - t0 ))
python3 tools/fs79_p3b_theta4.py quot --ids minimal --nmin 13 --nmax 24 --budget 300 --total $(( 1800 - used ))
echo ALL-DONE
