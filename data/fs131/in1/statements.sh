#!/usr/bin/env bash
# FS131-IN1: are the skeleton's statements unchanged in the working file?  Between builds: elaborates the skeleton
# (git 34d9113b2) and the working module, each with lean/StatementFooter.lean appended, and runs statement_diff.py on
# the two prints (then its control).  Both are elaborated at ONE path (stmt/Copy.lean), in turn: an instance binder's
# stored name carries the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`), so two paths print two texts
# for one statement (FS131-IU1's tool defect: 29 false differences on an untouched file).
# The prints are compacted (compact_dump.py) before they are kept; the raw prints are removed.
# usage: data/fs131/in1/statements.sh [tag]   exit 0 iff PASS and the control fires.  Keeps stmt/<tag>-{Skeleton,Candidate}.txt
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/in1
tag=${1:-now}
mkdir -p $D/stmt
for w in Skeleton Candidate; do
  if [ $w = Skeleton ]; then git show 34d9113b2:Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean > $D/stmt/Copy.lean || exit 2
  else cat Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean > $D/stmt/Copy.lean; fi
  cat $D/lean/StatementFooter.lean >> $D/stmt/Copy.lean
  # the candidate also carries the skeleton's form of each leaf widened by ruling, proved from the widened one
  if [ $w = Candidate ]; then python3 $D/widenings.py >> $D/stmt/Copy.lean || exit 2; fi
  IN1_HEAD=0 $D/lean1.sh $D/stmt/Copy.lean > /dev/null 2>&1
  st=$?
  cp $D/logs/Copy.out $D/stmt/$w.full.txt
  echo "$w: lean exit $st; errors: $(grep -c ': error' $D/stmt/$w.full.txt); sorry warnings: $(grep -c "declaration uses .sorry." $D/stmt/$w.full.txt)"
  [ $st -eq 0 ] || { echo "statements.sh: $w did not elaborate"; grep ': error' -A 6 $D/stmt/$w.full.txt | head -30; exit 1; }
  grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/$w.full.txt > $D/stmt/$w.raw.txt
  python3 $D/compact_dump.py $D/stmt/$w.raw.txt $D/stmt/$tag-$w.txt || exit 2
  rm -f $D/stmt/$w.full.txt $D/stmt/$w.raw.txt
done
# control of the widenings' check: one of the two `example`s given an argument too few must not elaborate
cat Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean > $D/stmt/Copy.lean
python3 $D/widenings.py --plant >> $D/stmt/Copy.lean || exit 2
IN1_HEAD=0 $D/lean1.sh $D/stmt/Copy.lean > /dev/null 2>&1
wp=$(grep -c ': error' $D/logs/Copy.out)
echo "widenings: the skeleton's form of each widened leaf is one application of the working module's (the Candidate's error count above is theirs too); control (an argument too few): $wp error(s) — $([ "$wp" -ge 1 ] && echo 'the check can fail' || echo 'THE CONTROL DID NOT FIRE')"
rm -f $D/stmt/Copy.lean $D/logs/Copy.out $D/logs/Copy.err $D/logs/Copy.time
python3 $D/statement_diff.py $D/stmt/$tag-Skeleton.txt $D/stmt/$tag-Candidate.txt; a=$?
python3 $D/statement_diff.py $D/stmt/$tag-Skeleton.txt $D/stmt/$tag-Candidate.txt --control | tail -1; b=${PIPESTATUS[0]}
echo "statements.sh: diff exit $a, control exit $b"
[ $a -eq 0 ] && [ $b -eq 0 ] && [ "$wp" -ge 1 ]
