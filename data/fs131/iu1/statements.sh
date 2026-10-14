#!/usr/bin/env bash
# FS131-IU1: are the skeleton's statements unchanged in the working file?  Between builds: elaborates the skeleton
# (git 223241b0a) and the working module, each with lean/StatementFooter.lean appended, and runs statement_diff.py on
# the two prints (then its control).  Both are elaborated at ONE path (stmt/Copy.lean), in turn: an instance binder's
# stored name carries the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`), so two paths print two texts
# for one statement (seen: 29 false differences on an untouched file).
# usage: data/fs131/iu1/statements.sh   exit 0 iff PASS and the control fires.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/iu1
mkdir -p $D/stmt
for w in Skeleton Candidate; do
  if [ $w = Skeleton ]; then git show 223241b0a:Proofs/HadwigerNelson/Arith/UpperHalf.lean > $D/stmt/Copy.lean || exit 2
  else cat Proofs/HadwigerNelson/Arith/UpperHalf.lean > $D/stmt/Copy.lean; fi
  cat $D/lean/StatementFooter.lean >> $D/stmt/Copy.lean
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --name iu1 -- \
    lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Copy.lean > $D/stmt/$w.full.txt 2> $D/stmt/$w.err
  echo "$w: lean exit $?; errors: $(grep -c ': error' $D/stmt/$w.full.txt); sorry warnings: $(grep -c "declaration uses .sorry." $D/stmt/$w.full.txt)"
  grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/$w.full.txt > $D/stmt/$w.txt
done
rm -f $D/stmt/Copy.lean
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt; a=$?
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt --control | tail -1; b=${PIPESTATUS[0]}
[ $a -eq 0 ] && [ $b -eq 0 ]
