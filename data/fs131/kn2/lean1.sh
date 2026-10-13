#!/usr/bin/env bash
# FS131-KN2: one file through `lake env lean` under the slot, with the lakefile's two options, timed.
# usage: data/fs131/kn2/lean1.sh <file.lean> [extra lean args]   (run from the worktree root)
# Writes <file>.out (messages) and <file>.time (wall clock, peak RSS); prints both; exit status is lean's.
set -u
f="$1"; shift
tag="data/fs131/kn2/logs/$(basename "$f" .lean)"
mkdir -p data/fs131/kn2/logs
/usr/bin/time -v -o "$tag.time" env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 8 --cpus 2 --name kn2 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" "$f" > "$tag.out" 2> "$tag.err"
st=$?
cat "$tag.out"
grep -v "^slot: admitted" "$tag.err"
grep -E "Elapsed|Maximum resident" "$tag.time"
echo "lean-exit=$st"
exit $st
