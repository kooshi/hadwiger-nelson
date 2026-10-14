#!/usr/bin/env bash
# FS131-IC1: are the skeleton's statements unchanged in the working file?  Elaborates the skeleton (git 34d9113b2) and
# the working module, each with lean/StatementFooter.lean appended, and runs statement_diff.py on the two prints
# (then its control).  Both are elaborated at ONE path (stmt/Copy.lean), in turn: an instance binder's stored name
# carries the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`), so two paths print two texts for one
# statement (FS131-IU1's tool defect: 29 false differences on an untouched file).
# usage: data/fs131/ic1/statements.sh [candidate-file]   exit 0 iff PASS and the control fires.
#   candidate-file defaults to the module; a planted copy may be given to watch the check fail on a real file.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/ic1
M=Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean
CAND="${1:-$M}"
mkdir -p $D/stmt
for w in Skeleton Candidate; do
  if [ $w = Skeleton ]; then git show 34d9113b2:$M > $D/stmt/Copy.lean || exit 2
  else cat "$CAND" > $D/stmt/Copy.lean || exit 2; fi
  cat $D/lean/StatementFooter.lean >> $D/stmt/Copy.lean
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ic1 -- \
    lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Copy.lean > $D/stmt/$w.full.txt 2> $D/stmt/$w.err
  echo "$w: lean exit $?; errors: $(grep -c ': error' $D/stmt/$w.full.txt); sorry warnings: $(grep -c "declaration uses .sorry." $D/stmt/$w.full.txt)"
  grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/$w.full.txt > $D/stmt/$w.txt
done
rm -f $D/stmt/Copy.lean
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt "$CAND"; a=$?
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt "$CAND" --control | tail -1; b=${PIPESTATUS[0]}
[ $a -eq 0 ] && [ $b -eq 0 ]
