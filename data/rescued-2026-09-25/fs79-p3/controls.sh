set -e
cd /home/kooshi/source/lean-dir
python3 -u /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/controls.py
rm -rf /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/k3 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/plant4
python3 -u tools/fs79_p3_theta4.py tree 3 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/k3 --only 2 --workers 2
python3 -u tools/fs79_p3_theta4.py tree 4 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/plant4 --only 2 --workers 2 --drop 4
python3 -u tools/fs79_p3_theta4.py cells /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/plant4 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3/plant4-cells.jsonl --workers 4
echo CONTROLS-DONE
