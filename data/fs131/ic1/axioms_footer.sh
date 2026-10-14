#!/usr/bin/env bash
# FS131-IC1: the axioms of every theorem the working module declares (private helpers included), before the build:
# a copy of the module with lean/AxiomsFooter.lean appended is elaborated and its AXIOMS lines read by
# read_axioms_footer.py.  Then the control: the same on a copy in which one leaf's proof is replaced by `sorry`
# (`isClosed_band`), which must report `sorryAx` on that leaf and on the two theorems that read it
# (`bandSet_three_nonempty_of_proper`, `fieldBandSet_three_nonempty_of_colorable`), and nowhere else.
# usage: data/fs131/ic1/axioms_footer.sh    exit 0 iff the real run is clean and the control fires as planted.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/ic1
M=Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean
mkdir -p $D/stmt
run() {  # $1 = source file, $2 = tag
  cat "$1" $D/lean/AxiomsFooter.lean > $D/stmt/Copy.lean
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ic1 -- \
    lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true $D/stmt/Copy.lean > $D/stmt/$2.full.txt 2> $D/stmt/$2.err
  echo "$2: lean exit $?; errors: $(grep -c ': error' $D/stmt/$2.full.txt); warnings: $(grep -c ': warning' $D/stmt/$2.full.txt)"
  grep -E '^AXIOMS' $D/stmt/$2.full.txt > $D/$3
  rm -f $D/stmt/Copy.lean
}
run $M Axioms axioms-footer.txt
python3 - "$M" > $D/stmt/Planted.lean <<'PY'
import sys, re
s = open(sys.argv[1], encoding="utf8").read()
old = "theorem isClosed_band (k : ℕ) : IsClosed (band k) :=\n  (isCompact_Icc.image (AddCircle.continuous_mk' 1)).isClosed"
assert s.count(old) == 1, "the control's target text is not in the module: rewrite the plant"
sys.stdout.write(s.replace(old, "theorem isClosed_band (k : ℕ) : IsClosed (band k) := by\n  sorry"))
PY
[ -s $D/stmt/Planted.lean ] || { echo "PLANT NOT WRITTEN"; exit 2; }
run $D/stmt/Planted.lean AxiomsControl axioms-footer.control.txt
rm -f $D/stmt/Planted.lean
python3 $D/read_axioms_footer.py $D/axioms-footer.txt; a=$?
python3 $D/read_axioms_footer.py $D/axioms-footer.control.txt --control; b=$?
[ $a -eq 0 ] && [ $b -eq 0 ]
