#!/usr/bin/env bash
# FS131-IC1: everything read from the BUILT module, after the one build.  Each step prints its verdict; the script's
# exit status is 0 only if every step and every control gave the expected verdict.
#   1. the stored constants of the compiled module (lean/StatementDump.lean) -> statements-built.txt
#   2. no statement changed: statements-skeleton.txt (the skeleton at 34d9113b2, elaborated from source — it was never
#      compiled in this tree) against the built module's dump, hygienic binder names normalized; then the control
#   3. the audit block and lean/Axioms.lean from the dump and the source (make_audit.py); the axioms of the nine public
#      theorems printed from the built module; read_axioms.py and its control
#   4. the models (models.sh built) with their axioms; read_axioms.py and its control
# usage: data/fs131/ic1/after_build.sh
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/ic1
slot() { env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ic1 -- "$@"; }
fail=0
ls -la --time-style=full-iso .lake/build/lib/lean/Proofs/HadwigerNelson/Arith/ThreeColourCharacter.olean || { echo "NO COMPILED MODULE"; exit 2; }

echo "== 1. dump of the compiled module"
slot lake env lean $D/lean/StatementDump.lean > $D/stmt/Built.full.txt 2> $D/logs/StatementDump.err; st=$?
grep -E '^(## |@@ |TYPE |VALUE )' $D/stmt/Built.full.txt > $D/statements-built.txt
echo "lean exit $st; errors: $(grep -c ': error' $D/stmt/Built.full.txt); $(head -1 $D/statements-built.txt)"
[ $st -eq 0 ] || fail=1

echo "== 2. no statement changed (skeleton's print against the built module's)"
python3 $D/statement_diff.py $D/statements-skeleton.txt $D/statements-built.txt --normalize-hyg > $D/logs/statements-built.out; a=$?
cat $D/logs/statements-built.out
python3 $D/statement_diff.py $D/statements-skeleton.txt $D/statements-built.txt --normalize-hyg --control > $D/logs/statements-built.control.out; b=$?
tail -1 $D/logs/statements-built.control.out
[ $a -eq 0 ] && [ $b -eq 0 ] || fail=1

echo "== 3. the audit block; the axioms of the public theorems, from the built module"
python3 $D/make_audit.py $D/statements-built.txt || fail=1
slot lake env lean $D/lean/Axioms.lean > $D/logs/Axioms.out 2> $D/logs/Axioms.err; st=$?
echo "lean exit $st"
n=$(grep -c '^#print axioms' $D/audit-block.txt)
python3 $D/read_axioms.py $D/logs/Axioms.out "$n" --names $D/audit-block.txt; a=$?
python3 $D/read_axioms.py $D/logs/Axioms.out "$n" --names $D/audit-block.txt --control | tail -1; b=${PIPESTATUS[0]}
[ $st -eq 0 ] && [ $a -eq 0 ] && [ $b -eq 0 ] || fail=1

echo "== 4. the models, against the built module"
$D/models.sh built | tail -1; st=${PIPESTATUS[0]}
n=$(grep -c '^#print axioms' $D/lean/ModelsBody.lean)
python3 $D/read_axioms.py $D/logs/Models-built.out "$n"; a=$?
python3 $D/read_axioms.py $D/logs/Models-built.out "$n" --control | tail -1; b=${PIPESTATUS[0]}
[ $st -eq 0 ] && [ $a -eq 0 ] && [ $b -eq 0 ] || fail=1

echo "== after_build: $([ $fail -eq 0 ] && echo 'every step as expected' || echo 'A STEP FAILED')"
exit $fail
