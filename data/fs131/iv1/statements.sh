#!/usr/bin/env bash
# FS131-IV1: are the skeleton's statements unchanged in the working instances file?  Between builds: elaborates the
# skeleton (git 223241b0a) and the working file, each with lean/StatementFooter.lean appended, and runs
# statement_diff.py --scope instances on the two prints (then its control).  Both are elaborated at ONE path
# (stmt/Copy.lean), in turn: an instance binder's stored name carries the file's module name, so two paths print two
# texts for one statement (FS131-IU1).  The prints are compacted (compact_dump.py) and the raw ones removed.
# usage: data/fs131/iv1/statements.sh           exit 0 iff PASS and the reader's control fires.
#        data/fs131/iv1/statements.sh --plant   the fault planted in the file, not in the reader: a hypothesis added to
#                                               `two_le_chromaticNumber_planeOver` in the candidate copy; exit 0 iff the
#                                               comparison FAILS naming that theorem.
set -uo pipefail
PLANT=0; [ "${1:-}" = --plant ] && PLANT=1
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/iv1
F=Proofs/HadwigerNelson/Instances/UpperHalfValues.lean
mkdir -p $D/stmt
for w in Skeleton Candidate; do
  if [ $w = Skeleton ]; then git show 223241b0a:$F > $D/stmt/Copy.lean || exit 2
  else cat $F > $D/stmt/Copy.lean
    if [ "$PLANT" = 1 ]; then  # the planted fault: one hypothesis added to one leaf's statement, in the copy only
      sed -i 's/^theorem two_le_chromaticNumber_planeOver (F : Subfield ℝ) :$/theorem two_le_chromaticNumber_planeOver (F : Subfield ℝ) (_h : F ≠ ⊥) :/' $D/stmt/Copy.lean
      grep -q '(_h : F ≠ ⊥) :$' $D/stmt/Copy.lean || { echo "PLANT NOT APPLIED"; exit 2; }
    fi
  fi
  cat $D/lean/StatementFooter.lean >> $D/stmt/Copy.lean
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name iv1 -- \
    lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Copy.lean > $D/stmt/$w.full.txt 2> $D/stmt/$w.err
  echo "$w: lean exit $?; errors: $(grep -c ': error' $D/stmt/$w.full.txt); sorry warnings: $(grep -c "declaration uses .sorry." $D/stmt/$w.full.txt)"
  grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/$w.full.txt > $D/stmt/$w.raw.txt
  python3 $D/compact_dump.py $D/stmt/$w.raw.txt $D/stmt/$w.txt || exit 2
  rm -f $D/stmt/$w.raw.txt $D/stmt/$w.full.txt
done
rm -f $D/stmt/Copy.lean
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt --scope instances > $D/stmt/diff.out; a=$?
cat $D/stmt/diff.out
if [ "$PLANT" = 1 ]; then
  if [ $a -eq 1 ] && grep -q '^TYPE     THM HadwigerNelson.UpperHalf.two_le_chromaticNumber_planeOver' $D/stmt/diff.out; then
    echo "PLANT: the comparison failed and named the planted theorem — the check can fail"; exit 0
  else echo "PLANT: THE PLANTED FAULT WAS NOT REPORTED"; exit 1; fi
fi
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt --scope instances --control | tail -6; b=${PIPESTATUS[0]}
echo "statements.sh: real exit $a, control exit $b"
[ $a -eq 0 ] && [ $b -eq 0 ]
