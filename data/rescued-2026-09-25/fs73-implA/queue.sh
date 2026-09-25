#!/bin/bash
cd /home/kooshi/source/lean-dir
echo "== 1 periods 20, 21, 22, 24 past the plateau rule"; python3 tools/fs73_screen.py periods K --resume --only 20,21,22,24 --past-plateau
echo "== 2 off-plane vector (-16,8,8,0)"; python3 tools/fs73_screen.py force K --targets 'c:-16,8,8,0' --radii 1.5,2.0
echo "== 3 cadical on the identical 8/9 CNF"; python3 tools/fs73_screen.py confirm K --key force:32,-16,-16,-8:R1.5 --solver cadical --budget 3000
echo "== 4 smaller balls for 8/9"; python3 tools/fs73_screen.py force K --targets '8/9' --radii 1.0,1.25
echo "== 5 period 32 (priced first)"; python3 tools/fs73_screen.py periods K --resume --only 32 --past-plateau
echo "QUEUE DONE"
