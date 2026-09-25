#!/bin/bash
cd /home/kooshi/source/lean-dir
while kill -0 549390 2>/dev/null; do sleep 30; done
echo "== 10 8/9 at R = 1.25 (pullback control)"; python3 tools/fs73_screen.py force K --targets '8/9' --radii 1.25
echo "== 11 LRAT for 8/9's smallest refusal"; for k in force:32,-16,-16,-8:R1.25 force:32,-16,-16,-8:R1.5; do if grep "\"key\": \"$k\"" data/fs73/census/K-rows.jsonl | grep -q '"verdict": "refused'; then python3 tools/fs73_screen.py confirm K --key $k --solver cadical --budget 3000 --lrat; break; fi; done
echo "== 12 period 32 (priced first)"; python3 tools/fs73_screen.py periods K --resume --only 32 --past-plateau
echo "QUEUE4 DONE"
