#!/usr/bin/env bash
# FS131-G4: run the four gate scripts (axioms, its self-test, vacuity, its self-test) under the slot, one at a time,
# each to its own driver log, with its exit status written on the log's last line. Usage: run-gate.sh <tag>
tag="$1"; d=data/fs131/g4; S=/home/kooshi/source/lean-dir/scripts/slot.py
run() { local name="$1"; shift
  "$S" --mem 30 --cpus 4 -- "$@" > "$d/$name-$tag.log" 2>&1; local st=$?
  echo "exit=$st" >> "$d/$name-$tag.log"; echo "$name exit=$st"; }
run axioms ./scripts/axioms.sh
run axioms-selftest ./scripts/axioms.sh --self-test
run vacuity ./scripts/vacuity.sh
run vacuity-selftest ./scripts/vacuity.sh --self-test
echo DONE
