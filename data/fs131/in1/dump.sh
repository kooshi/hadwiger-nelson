#!/usr/bin/env bash
# FS131-IN1: every constant of the COMPILED module `Arith/ThreeColourCriterion`, from a named library, compacted.
# usage: data/fs131/in1/dump.sh <library dir holding Proofs/…/ThreeColourCriterion.olean> <out.txt>
# The library is put in front of Lake's path with this worktree's own library taken out (a LEAN_PATH entry holding a
# `Proofs/` directory hides every later entry's).  Exit 0 only if lean exits 0 and the dump is not empty.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
here=$PWD; D=data/fs131/in1
libdir=$(cd "$1" && pwd); out=$2
[ -f "$libdir/Proofs/HadwigerNelson/Arith/ThreeColourCriterion.olean" ] || { echo "no compiled module in $libdir"; exit 2; }
own=$here/.lake/build/lib/lean
LP="$libdir:$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "^$own\$" | grep -v "^$libdir\$" | paste -sd:)"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name in1 -- \
  env LEAN_PATH="$LP" lean $D/lean/StatementDump.lean > $out.raw 2> $out.err
st=$?
echo "dump: lean exit $st; olean $(sha256sum "$libdir/Proofs/HadwigerNelson/Arith/ThreeColourCriterion.olean" | cut -c1-16) $(stat -c '%y' "$libdir/Proofs/HadwigerNelson/Arith/ThreeColourCriterion.olean" | cut -c1-19)"
[ $st -eq 0 ] || { head -20 $out.raw; exit 1; }
python3 $D/compact_dump.py $out.raw $out || exit 1
rm -f $out.raw; grep -v "^slot: admitted" $out.err; rm -f $out.err
