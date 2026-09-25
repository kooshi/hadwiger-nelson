#!/bin/bash
cd /home/kooshi/source/lean-dir
S=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implA
while kill -0 549390 2>/dev/null; do sleep 30; done
echo "== 10 8/9 ladder 1.25, 1.3, 1.4 (pullback control)"; python3 tools/fs73_screen.py force K --targets '8/9' --radii 1.25,1.3,1.4
echo "== 11 v ladder 1.0, 1.25, 1.3, 1.4"; python3 tools/fs73_screen.py force K --targets 'c:-16,8,8,0' --radii 1.0,1.25,1.3,1.4
for t in 32,-16,-16,-8 -16,8,8,0; do k=$(python3 $S/smallest.py $t); echo "== 12 LRAT for the smallest refusal of $t: $k"; [ -n "$k" ] && python3 tools/fs73_screen.py confirm K --key $k --solver cadical --budget 3000 --lrat; done
echo "== 13 period 32 (priced first)"; python3 tools/fs73_screen.py periods K --resume --only 32 --past-plateau
echo "QUEUE5 DONE"
