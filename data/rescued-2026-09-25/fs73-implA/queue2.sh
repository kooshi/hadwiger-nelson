#!/bin/bash
cd /home/kooshi/source/lean-dir
while kill -0 528563 2>/dev/null; do sleep 30; done
echo "== 6 cadical on the identical off-plane CNF"; python3 tools/fs73_screen.py confirm K --key force:-16,8,8,0:R1.5 --solver cadical --budget 3000
echo "== 7 off-plane at R = 1.0"; python3 tools/fs73_screen.py force K --targets 'c:-16,8,8,0' --radii 1.0
for k in force:-16,8,8,0:R1.0 force:32,-16,-16,-8:R1.0 force:32,-16,-16,-8:R1.25; do
  if grep -q "\"key\": \"$k\"" data/fs73/census/K-rows.jsonl && grep "\"key\": \"$k\"" data/fs73/census/K-rows.jsonl | grep -q '"verdict": "refused'; then
    echo "== 8 LRAT for $k"; python3 tools/fs73_screen.py confirm K --key $k --solver cadical --budget 3000 --lrat; break
  fi
done
echo "QUEUE2 DONE"
