#!/bin/bash
cd /home/kooshi/source/lean-dir
Q2=$(cat /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implA/queue2.leader)
while kill -0 $Q2 2>/dev/null; do sleep 30; done
echo "== 9 P-D3 falsifier (union of two translates)"; python3 tools/fs73_screen.py pd3 K
echo "QUEUE3 DONE"
