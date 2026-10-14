#!/usr/bin/env bash
# FS131-ID1: are the skeleton's statements unchanged in the working file?  Elaborates the skeleton (git 34d9113b2) and
# the working module, each with lean/StatementFooter.lean appended, and runs statement_diff.py on the two prints (then
# its control).  Both are elaborated at ONE path (stmt/Copy.lean), in turn: an instance binder's stored name carries
# the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`), so two paths print two texts for one statement (the
# tool defect FS131-IU1's record names: 29 false differences on an untouched file).
# usage: data/fs131/id1/statements.sh [--skeleton-only]   exit 0 iff PASS and the control fires.
# (Pattern: data/fs131/iu1/statements.sh on branch fs131-wnf.)
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/id1
F=Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean
mkdir -p $D/stmt
for w in Skeleton Candidate; do
  if [ $w = Skeleton ]; then
    [ -s $D/stmt/Skeleton.txt ] && [ "${1:-}" != "--skeleton-only" ] && { echo "Skeleton: kept ($(grep -c '^@@ ' $D/stmt/Skeleton.txt) constants)"; continue; }
    git show 34d9113b2:$F > $D/stmt/Copy.lean || exit 2
  else
    [ "${1:-}" = "--skeleton-only" ] && continue
    cat $F > $D/stmt/Copy.lean
  fi
  cat $D/lean/StatementFooter.lean >> $D/stmt/Copy.lean
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name id1 -- \
    lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Copy.lean > $D/stmt/$w.full.txt 2> $D/stmt/$w.err
  echo "$w: lean exit $?; errors: $(grep -c ': error' $D/stmt/$w.full.txt); sorry warnings: $(grep -c "declaration uses .sorry." $D/stmt/$w.full.txt)"
  grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/$w.full.txt > $D/stmt/$w.txt
done
rm -f $D/stmt/Copy.lean
[ "${1:-}" = "--skeleton-only" ] && exit 0
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt; a=$?
python3 $D/statement_diff.py $D/stmt/Skeleton.txt $D/stmt/Candidate.txt --control | tail -1; b=${PIPESTATUS[0]}
[ $a -eq 0 ] && [ $b -eq 0 ]
