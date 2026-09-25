#!/bin/bash
cd /home/kooshi/source/lean-dir
for M in 2448 2328 2400 4200 10920 14280 24360; do
  python3 tools/fs79_p3b_theta4.py find --ids $M --k 4 --cap 1100 > /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3b/find-$M.log 2>&1 &
done
wait
echo ALL-DONE
