#!/usr/bin/env bash
# FS131-LJ1 (FS131-LU1's, the directory and the slot name changed): one measured step under the slot.  Usage: m.sh <name> <mem GiB> <cpus> <cmd> [args...]
# stdout+stderr of the step -> data/fs131/lj1/<LJ1_DIR>/<name>.log (LJ1_DIR default "probes"), the exit status on its
# last line; the measurement (exit, wall, peak) appended to <dir>/measure.txt, prefixed with the step's name.  This
# machine's budget (the brief): SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6.  Prints "<name> exit=<n>"; exits with the step's status.
cd "$(dirname "$0")/../../.." || exit 2
name="$1"; mem="$2"; cpus="$3"; shift 3
d="data/fs131/lj1/${LJ1_DIR:-probes}"; mkdir -p "$d"
tmp="$d/.measure-$name.$$"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "$mem" --cpus "$cpus" \
  --wait "${LJ1_WAIT:-7200}" --name "lj1-$name" -- "$PWD/data/fs131/lj1/in-scope.sh" "$PWD/$tmp" "$@" > "$d/$name.log" 2>&1
st=$?
echo "exit=$st" >> "$d/$name.log"
if [ -f "$tmp" ]; then sed "s/^MEASURE /MEASURE $name mem-cap=${mem}G cpus=$cpus /" "$tmp" >> "$d/measure.txt"; rm -f "$tmp"
else echo "MEASURE $name mem-cap=${mem}G cpus=$cpus exit=$st NOT-MEASURED (the step did not reach its end inside the scope: refused, or killed)" >> "$d/measure.txt"; fi
echo "$name exit=$st"
exit "$st"
