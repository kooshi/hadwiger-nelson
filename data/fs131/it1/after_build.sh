#!/usr/bin/env bash
# FS131-IT1: everything read from the BUILT module, in order; run from anywhere after scripts/build.sh has exited 0.
#   1. the compiled module's constants (lean/StatementDump.lean) against the dump made before the first rebuild
#      (statements-before.raw.txt): statement_diff.py, then its control;
#   2. the audit block from the kernel's list (make_audit.py), its records' axioms from the compiled module
#      (lean/Axioms.lean), read by read_axioms.py against the block and the expected-upstream list, then its control;
#   3. the models (lean/Models.lean).
# Every step's exit status is printed; the script's is 0 only if every one is 0.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/it1
fail=0
step() { echo "== $1: exit $2"; [ "$2" -eq 0 ] || fail=1; }

$D/lean1.sh $D/lean/StatementDump.lean > /dev/null; s=$?
step "dump of the compiled module" $s
cp $D/logs/StatementDump.out $D/statements-after.raw.txt
python3 $D/statement_diff.py $D/statements-before.raw.txt $D/statements-after.raw.txt > $D/logs/statements-final.out; s=$?
cat $D/logs/statements-final.out; step "statements, compiled before against compiled after" $s
python3 $D/statement_diff.py $D/statements-before.raw.txt $D/statements-after.raw.txt --control > $D/logs/statements-final.control.out; s=$?
tail -4 $D/logs/statements-final.control.out; step "its control" $s

python3 $D/make_audit.py $D/statements-after.raw.txt; s=$?
step "the audit block from the kernel's list" $s
$D/lean1.sh $D/lean/Axioms.lean > /dev/null; s=$?
step "axioms of the block's records, from the compiled module" $s
cp $D/logs/Axioms.out $D/axioms.txt
n=$(grep -c '^#print axioms' $D/audit-block.txt)
python3 $D/read_axioms.py $D/axioms.txt "$n" --names $D/audit-block.txt --sorry $D/sorry-expected.txt > $D/logs/read_axioms.out; s=$?
cat $D/logs/read_axioms.out; step "the axiom reader" $s
python3 $D/read_axioms.py $D/axioms.txt "$n" --names $D/audit-block.txt --sorry $D/sorry-expected.txt --control > $D/logs/read_axioms.control.out; s=$?
tail -1 $D/logs/read_axioms.control.out; step "its control" $s

$D/lean1.sh $D/lean/Models.lean > /dev/null; s=$?
step "the models" $s
cp $D/logs/Models.out $D/models.txt
cat $D/models.txt
exit $fail
