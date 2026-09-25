#!/bin/bash
cd /home/kooshi/source/lean-dir
for c in 1-v-z 1-v-zb 1-v-vb v-z 1-z 1-v z-zb 1-z-zb v-vb-z 1-vb-z; do
  echo "== $c"
  timeout 900 python3 tools/fs73v2_xbb.py 167 "420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2" /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-verifier2/xbb-sub-$c.json --units-file /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-verifier2/sub-$c.json --log-every 1000000 2>&1 | tail -1
done
echo ALLDONE
