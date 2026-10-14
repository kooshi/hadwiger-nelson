#!/usr/bin/env bash
# FS131-ID1: the axioms of every declaration of the working file, between builds: a copy of the module with
# lean/AxiomsFooter.lean appended, elaborated under the slot.  Writes axioms-footer.txt; `--control` appends a theorem
# proved by `sorry` to the copy and must see `sorryAx` in its line (writes axioms-footer.control.txt).
# exit 0 iff (real) every line's axioms are within the standard three and the count is positive;
#            (control) the planted theorem's line holds sorryAx.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/id1
F=Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean
mkdir -p $D/stmt
out=$D/axioms-footer.txt
cat $F > $D/stmt/AxCopy.lean
if [ "${1:-}" = "--control" ]; then
  out=$D/axioms-footer.control.txt
  printf '\ntheorem HadwigerNelson.DyadicQuadratic.planted_sorry : (2 : Nat) + 2 = 5 := by sorry\n' >> $D/stmt/AxCopy.lean
fi
cat $D/lean/AxiomsFooter.lean >> $D/stmt/AxCopy.lean
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name id1 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/AxCopy.lean > $D/stmt/AxCopy.full.txt 2> $D/stmt/AxCopy.err
st=$?
rm -f $D/stmt/AxCopy.lean
grep -E '^AXIOMS' $D/stmt/AxCopy.full.txt > $out
n=$(grep -c '^AXIOMS ' $out); cnt=$(grep '^AXIOMS-COUNT' $out | awk '{print $2}')
bad=$(grep '^AXIOMS ' $out | grep -vE ' : \[(Classical\.choice|Quot\.sound|propext)?(, (Classical\.choice|Quot\.sound|propext))*\]$' | wc -l)
echo "lean exit $st; lines $n; AXIOMS-COUNT $cnt; lines with an axiom beyond the standard three: $bad"
grep '^AXIOMS ' $out | grep -vE ' : \[(Classical\.choice|Quot\.sound|propext)?(, (Classical\.choice|Quot\.sound|propext))*\]$'
if [ "${1:-}" = "--control" ]; then
  if grep -q '^AXIOMS public HadwigerNelson.DyadicQuadratic.planted_sorry : .*sorryAx' $out && [ "$bad" -ge 1 ]; then echo "CONTROL: the planted sorry is reported — the check can fail"; exit 0; fi
  echo "THE CONTROL DID NOT FIRE"; exit 1
fi
[ "$st" -eq 0 ] && [ "$n" -gt 0 ] && [ "$n" = "$cnt" ] && [ "$bad" -eq 0 ] && { echo "PASS: every declaration is on the standard three"; exit 0; }
echo FAIL; exit 1
