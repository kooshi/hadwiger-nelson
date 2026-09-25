#!/bin/bash
cd /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implE
exec flock -w 3600 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock \
  /usr/bin/time -v python3 /home/kooshi/source/lean-dir/tools/fs73_theta_cert.py build "420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" 167 runs/s420 \
  --basis-rows "2,0,0,0;0,0,2,0;83,0,0,1;0,-1,83,0" --order-units order_structured.json --cap 12000 --ckpt 60
