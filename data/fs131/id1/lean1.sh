#!/usr/bin/env bash
# FS131-ID1: one file through `lake env lean` under the slot, with the lakefile's two options, timed.
# usage: data/fs131/id1/lean1.sh <file.lean> [extra lean args]   (run from anywhere; it changes to the worktree root)
# Writes logs/<name>.out (messages) and .time (wall clock, peak RSS); prints both; exit status is lean's.
# (Pattern: data/fs131/iu1/lean1.sh on branch fs131-wnf.)
set -u
cd "$(dirname "$0")/../../.." || exit 2
f="$1"; shift
tag="data/fs131/id1/logs/$(basename "$f" .lean)"
mkdir -p data/fs131/id1/logs
/usr/bin/time -v -o "$tag.time" env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name id1 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" "$f" > "$tag.out" 2> "$tag.err"
st=$?
head -c 60000 "$tag.out"
grep -v "^slot: admitted" "$tag.err" | head -50
grep -E "Elapsed|Maximum resident" "$tag.time"
echo "lean-exit=$st"
exit $st
