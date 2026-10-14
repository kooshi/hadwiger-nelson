#!/usr/bin/env bash
# FS131-KN7 (the method of item 717): the trial elaboration of one scratch copy at this pin.
# usage: data/fs131/kn7/trial.sh <bundle> <attempt>
# Remakes the copies (build/fs131-kn7/release-copies/, ignored by git), scans the bundle (output kept:
# logs/scan-<bundle>.out, with the control's output), and ONLY IF the scan has no hit elaborates it, alone, under a
# slot of 8 GiB with no -o (no compiled file is written).  Log: logs/trial-<bundle>-<attempt>.log, ending
# "seconds=<n>" and "exit=<status>".
set -u
cd "$(dirname "$0")/../../.."
b="$1"; n="$2"; out=build/fs131-kn7/release-copies; L=data/fs131/kn7/logs
python3 -I tools/fs131_kn7_release_copy.py make /home/kooshi/source/math/lean "$out" > "$L/make-$b-$n.out" 2>&1 || { echo "make failed"; cat "$L/make-$b-$n.out"; exit 1; }
python3 -I tools/fs131_kn7_release_copy.py scan "$out/$b.lean" > "$L/scan-$b.out" 2>&1; s=$?
python3 -I tools/fs131_kn7_release_copy.py scan "$out/$b.lean" --plant > "$L/scan-$b-control.out" 2>&1; c=$?
tail -1 "$L/scan-$b.out"; tail -1 "$L/scan-$b-control.out"
if [ "$s" -ne 0 ] || [ "$c" -ne 0 ]; then echo "NOT ELABORATED: scan=$s control=$c"; exit 1; fi
log="$L/trial-$b-$n.log"; t0=$(date +%s)
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 --wait 1800 --name kn7t -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$out/$b.lean" > "$log" 2>&1
st=$?; echo "seconds=$(( $(date +%s) - t0 ))" >> "$log"; echo "exit=$st" >> "$log"
echo "errors=$(grep -c ': error' "$log") warnings=$(grep -c ': warning' "$log")"; tail -2 "$log"
