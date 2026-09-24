#!/bin/bash
cd /home/kooshi/source/lean-dir
OUTF=data/fs79/phase0/owner-recheck-167.jsonl
echo "START $(date -Is)"
for i in 0 1 2 3 4 5 6; do
  flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock python3 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-owner/recheck167.py ask $i gap
  if ! grep -q "\"idx\": $i,.*\"aim\": \"gap\".*\"verdict\": \"SAT\"" $OUTF 2>/dev/null && ! python3 -c "
import json,sys
rs=[json.loads(l) for l in open('$OUTF')]
sys.exit(0 if any(r['idx']==$i and r['aim']=='gap' and r['verdict']=='SAT' for r in rs) else 1)"; then
    flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock python3 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-owner/recheck167.py ask $i plain
  fi
done
echo "CHAIN FINISHED $(date -Is)"
