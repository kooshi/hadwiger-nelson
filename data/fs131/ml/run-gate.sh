#!/usr/bin/env bash
# FS131-ML1: the gate scripts (axioms, its self-test, vacuity, its self-test) under the slot, one at a time, each to its own
# driver log with its exit status on the log's last line; then the architecture check and the sorry scan.
# Usage (from the worktree root): data/fs131/ml/run-gate.sh <tag>
tag="$1"; d=data/fs131/ml; S=/home/kooshi/source/lean-dir/scripts/slot.py
run() { local name="$1"; shift
  "$S" --mem 30 --cpus 4 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
run axioms ./scripts/axioms.sh
run axioms-selftest ./scripts/axioms.sh --self-test
run vacuity ./scripts/vacuity.sh
run vacuity-selftest ./scripts/vacuity.sh --self-test
python3 tools/check_architecture.py > "$d/arch-$tag.txt" 2>&1; st=$?; echo "exit=$st" >> "$d/arch-$tag.txt"; echo "arch exit=$st"
grep -rnP '^\s*sorry\s*$|:= sorry|by sorry|\bsorry\b' --include='*.lean' Proofs/ > "$d/sorry-$tag.txt"; echo "sorry-lines=$(wc -l < "$d/sorry-$tag.txt")"
echo DONE
