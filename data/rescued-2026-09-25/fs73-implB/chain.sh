#!/bin/bash
# the P2 table, field by field, sequentially (one rows file); each field resumes from the rows (a key present is never re-asked)
B=/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implB
cd /home/kooshi/source/lean-dir
until grep -q '^EXIT' $B/table-K.log; do sleep 5; done
for f in Q11 Q35 Q3_23 Q3_47 Q167 PILOT; do
  echo "== $f $(date -Is)" >> $B/table-chain.log
  python3 -u tools/fs73_table.py table $f >> $B/table-chain.log 2>&1
  echo "EXIT-$f $?" >> $B/table-chain.log
done
echo CHAIN-DONE >> $B/table-chain.log
