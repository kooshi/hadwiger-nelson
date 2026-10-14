#!/usr/bin/env bash
# FS131-IT1: the statement check's control on the FILE (statement_diff.py --control plants in a dump, in memory).
# A copy of the working module with one hypothesis added to one statement that nothing in the file calls
# (`chromaticNumber_planeOver_ne_three_of_inv_three_mem … (_h : True)`) is elaborated at the path the skeleton's
# print was made at, and statement_diff.py must report exactly that one stored statement — and exit 1.
# Run after statements.sh (it leaves stmt/Skeleton.txt).  Exit 0 iff the plant is reported and nothing else is.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/it1
F=Proofs/HadwigerNelson/Arith/TorsionExtraction.lean
[ -s $D/stmt/Skeleton.txt ] || { echo "no stmt/Skeleton.txt: run statements.sh first"; exit 2; }
python3 - "$F" "$D/stmt/Copy.lean" "$D/lean/StatementFooter.lean" <<'PY' || exit 2
import sys, pathlib
src, dst, footer = map(pathlib.Path, sys.argv[1:4])
s = src.read_text()
a = "theorem chromaticNumber_planeOver_ne_three_of_inv_three_mem (h3 : (3 : ℂ)⁻¹ ∈ unitRing F) :"
assert s.count(a) == 1, "the plant's anchor is not in the file exactly once"
dst.write_text(s.replace(a, a[:-2] + " (_h : True) :") + footer.read_text())
PY
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name it1 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Copy.lean > $D/stmt/Planted.full.txt 2> $D/stmt/Planted.err
echo "Planted: lean exit $?; errors: $(grep -c ': error' $D/stmt/Planted.full.txt)"
grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/Planted.full.txt > $D/stmt/Planted.txt
rm -f $D/stmt/Copy.lean $D/stmt/Planted.full.txt
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Planted.txt > $D/stmt/Planted.diff; a=$?
grep -E '^(TYPE|VALUE|MISSING|KIND|PASS|FAIL)' $D/stmt/Planted.diff
n=$(grep -cE '^(TYPE|VALUE|MISSING|KIND) ' $D/stmt/Planted.diff)
if [ $a -eq 1 ] && [ "$n" -eq 1 ] && grep -q '^TYPE     THM HadwigerNelson.TorsionExtraction.chromaticNumber_planeOver_ne_three_of_inv_three_mem:' $D/stmt/Planted.diff; then
  echo "PLANTED FILE: the one changed statement is reported, and nothing else — the check can fail on the file"; exit 0
else
  echo "PLANTED FILE: THE CONTROL DID NOT FIRE AS PLANTED (diff exit $a, $n differences)"; exit 1
fi
