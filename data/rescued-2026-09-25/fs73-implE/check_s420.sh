#!/bin/bash
cd /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implE
exec flock -w 3600 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock sh -c '
echo "== certcheck.py (committed, Coxeter)"; /usr/bin/time -v python3 /home/kooshi/source/lean-dir/data/fs73/coxeter-c3/certcheck.py runs/s420.json;
echo "== fs73_theta_check.py (mine)"; /usr/bin/time -v python3 /home/kooshi/source/lean-dir/tools/fs73_theta_check.py cert runs/s420.json;
echo CHECKS-DONE'
