#!/usr/bin/env bash
# FS131-IQ1: the no-statement-changed check on the BUILT module.  Prints every public constant the compiled
# `Arith/QuadraticPrime` declares (data/fs131/iq1/lean/BuiltDump.lean, which imports the `.olean`) and requires every
# line of the skeleton's print (data/fs131/iq1/statements-skeleton.txt, made at 223241b0a in stage 1) to be a line of it.
# `--control` checks against a copy of the skeleton's print with one hash altered and must FAIL naming that line.
# usage: statements-built.sh [--control]     exit 0 iff the verdict is the expected one.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/iq1
REF=$D/statements-skeleton.txt
if [ "${1:-}" = "--control" ]; then
  sed '0,/#[0-9]*/s/#\([0-9]\)\([0-9]*\)/#9\2\1/' $REF > $D/stmt/skeleton-control.txt
  cmp -s $REF $D/stmt/skeleton-control.txt && { echo "control: the plant changed nothing"; exit 2; }
  REF=$D/stmt/skeleton-control.txt
fi
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 4 --cpus 2 --name iq1-stmt -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/lean/BuiltDump.lean > $D/stmt/built-full.txt 2>$D/stmt/built.err
st=$?
grep '^STMT ' $D/stmt/built-full.txt > $D/stmt/built.txt
nb=$(wc -l < $D/stmt/built.txt); nr=$(wc -l < $REF)
if [ $st -ne 0 ] || [ "$nb" -lt 14 ] || [ "$nr" -ne 14 ]; then
  echo "FAIL: the dump did not run (lean exit $st; $nb lines printed, at least 14 expected; $nr reference lines, 14 expected)"; head -5 $D/stmt/built-full.txt; exit 2; fi
missing=$(grep -vxFf $D/stmt/built.txt $REF)
nm=$(printf '%s' "$missing" | grep -c '^STMT ')
echo "built module: $nb public constants; reference: $nr; reference lines not found in the built module: $nm"
if [ "${1:-}" = "--control" ]; then
  if [ "$nm" -eq 1 ]; then printf '%s\n' "$missing" | cut -c1-160; echo "CONTROL: fired (the altered line is reported)"; exit 0
  else echo "CONTROL: DID NOT FIRE ($nm lines reported, 1 expected)"; exit 1; fi
fi
if [ "$nm" -ne 0 ]; then printf '%s\n' "$missing" | cut -c1-400; echo "RESULT: FAIL"; exit 1; fi
echo "RESULT: PASS — every declaration of the skeleton is in the built module with the same stored type"
