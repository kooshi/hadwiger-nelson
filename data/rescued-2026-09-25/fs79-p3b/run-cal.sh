#!/bin/bash
cd /home/kooshi/source/lean-dir
for M in 2352 1584 1344; do
  python3 tools/fs79_p3b_theta4.py find --ids $M --k 4 --cap 150 --tag cal > /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3b/cal-$M.log 2>&1 &
done
wait
echo ALL-DONE
