#!/usr/bin/env bash
# FS131-OL1 (after ML1's data/fs131/ml/run-gate.sh): the gate scripts (axioms, its self-test, vacuity, its self-test) under the
# slot, one at a time, each to its own driver log with its exit status on the log's last line; then the architecture check and the
# sorry scan. The commit under test is written first. Usage (from the worktree root): data/fs131/ol/run-gate.sh <tag>
tag="$1"; d=data/fs131/ol; S=/home/kooshi/source/lean-dir/scripts/slot.py
[ -n "$tag" ] || { echo "usage: run-gate.sh <tag>"; exit 2; }
{ echo "HEAD=$(git rev-parse HEAD)"; echo "status:"; git status --short; } > "$d/run-gate-$tag.head"
run() { local name="$1"; shift
  "$S" --mem 30 --cpus 4 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
run axioms ./scripts/axioms.sh
run axioms-selftest ./scripts/axioms.sh --self-test
run vacuity ./scripts/vacuity.sh
run vacuity-selftest ./scripts/vacuity.sh --self-test
python3 tools/check_architecture.py > "$d/arch-$tag.txt" 2>&1; st=$?; echo "exit=$st" >> "$d/arch-$tag.txt"; echo "arch exit=$st"
grep -rnP '^\s*sorry\s*$|:= sorry|by sorry|\bsorry\b' --include='*.lean' Proofs/ > "$d/sorry-$tag.txt"; echo "sorry-lines=$(wc -l < "$d/sorry-$tag.txt")"
for g in build axioms axioms-self-test vacuity vacuity-self-test; do echo "$g latest: $(readlink -f build/gate/$g/latest 2>/dev/null)"; done >> "$d/run-gate-$tag.head"
echo DONE
