#!/bin/bash
# FS132-Z1: run the derive gate on each file this job appends to; one output file and one exit line per file.
# usage: run_gates.sh <tag>   (tag = before | after)
tag="$1"
cd "$(dirname "$0")/../../../plans" || exit 2
for f in FS132-E1-derivation.md FS132-E2-derivation.md FS132-E3-derivation.md FS132-E4-derivation.md FS132-E5-derivation.md FS132-E6-derivation.md FS132-six-by-the-nerve.md FS116-derivation.md FS129-derivation.md; do
  out="../data/fs132/z1/gates/$tag-$f.out"
  start=$(date +%s)
  python3 ../.claude/skills/ephodos/scripts/derive_gate.py all "$f" > "$out" 2>&1
  code=$?
  echo "EXIT $code $(( $(date +%s) - start ))s $f" >> "../data/fs132/z1/gates/$tag-summary.txt"
done
echo DONE >> "../data/fs132/z1/gates/$tag-summary.txt"
