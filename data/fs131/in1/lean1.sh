#!/usr/bin/env bash
# FS131-IN1: one file through `lean` under the slot, with the lakefile's two options, timed — an iteration device.
# The module's upstream `.olean`s are read from the scratch farm (data/fs131/in1/farm.sh), because this worktree's own
# `.lake/build` does not hold them; Mathlib and the other packages are Lake's own path.  After the build at the end the
# worktree's library is complete and `IN1_NOFARM=1` reads it instead (plain `lake env lean`).
# usage: data/fs131/in1/lean1.sh <file.lean> [extra lean args]   (paths relative to the worktree root)
# Writes logs/<name>.out (messages), .err and .time (wall clock, peak RSS); prints them; exit status is lean's.
set -u
cd "$(dirname "$0")/../../.." || exit 2
here=$PWD
f="$1"; shift
tag="data/fs131/in1/logs/$(basename "$f" .lean)"
mkdir -p data/fs131/in1/logs
lib=$here/.lake/build/lib/lean
if [ "${IN1_NOFARM:-0}" = 1 ]; then
  LP=$(lake env printenv LEAN_PATH)
else
  [ -d "$here/build/in1-farm/Proofs" ] || { echo "no farm: run data/fs131/in1/farm.sh"; exit 2; }
  LP="$here/build/in1-farm:$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "^$lib\$" | paste -sd:)"
fi
/usr/bin/time -v -o "$tag.time" env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name in1 -- \
  env LEAN_PATH="$LP" lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@" "$f" > "$tag.out" 2> "$tag.err"
st=$?
head -c ${IN1_HEAD:-60000} "$tag.out"
grep -v "^slot: admitted" "$tag.err" | head -50
grep -E "Elapsed|Maximum resident" "$tag.time"
echo "lean-exit=$st"
exit $st
