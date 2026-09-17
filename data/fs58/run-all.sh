#!/usr/bin/env bash
# Regenerates every record in data/fs58. Resumable: a finished record (renamed from .tmp on success) is skipped on relaunch.
set -u
cd /home/kooshi/source/lean-dir/data/fs58
T=/home/kooshi/source/lean-dir/tools/fs58_seven_cycle.py
job() { out=$1; shift; [ -s "$out" ] && { echo "skip $out"; return; }; echo "run  $out"; ( time python3 $T "$@" ) > "$out.tmp" 2>&1 && mv "$out.tmp" "$out" || echo "FAILED $out (see $out.tmp)"; }
job census-420.out census 420
job census-2184.out census 2184
job residue-3.out residue
job family.out family 200000
job union-R140-5000.out union 140 5000
job union-R420-5000.out union 420 5000
job union-R84-50000.out union 84 50000
job union-R420-50000.out union 420 50000
job least-denominator.out least 140 400000
echo ALL-DONE
