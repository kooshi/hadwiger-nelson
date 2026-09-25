#!/bin/bash
# the standalone checker on every witness file; one line per file; controls on one witness of each kind
cd /home/kooshi/source/lean-dir
out=data/fs79/phase0/checker-run.txt
: > $out
for f in data/fs79/phase0/witnesses/*.json; do
  r=$(timeout 300 python3 tools/fs79_p0_check.py "$f" 2>&1 | tail -1); echo "$(basename $f) :: $r" >> $out
done
for kind in additive linear residue; do
  f=$(ls data/fs79/phase0/witnesses/*-$kind*.json 2>/dev/null | head -1)
  [ -n "$f" ] && { echo "== controls on $(basename $f)" >> $out; timeout 600 python3 tools/fs79_p0_check.py "$f" --controls >> $out 2>&1; }
done
echo "CHECKALL DONE $(date -Is)" >> $out
