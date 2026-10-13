#!/usr/bin/env bash
# FS131-IV1: everything read from the built modules, in one run (after the build; each step's status kept).
# usage: data/fs131/iv1/after-build.sh    writes logs/after-build.out; exit 0 iff every step is as expected.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/iv1; L=$D/logs; bad=0
step() { echo; echo "=== $1"; }
# 1. the statements, from the compiled modules
step "1. statement dump of the three compiled modules"
HEADC=0 $D/lean1.sh $D/lean/StatementDump.lean > $L/StatementDump.run.out 2>&1; s=$?; tail -3 $L/StatementDump.run.out; [ $s -eq 0 ] || bad=1
python3 $D/compact_dump.py $L/StatementDump.out $D/statements-after.txt || bad=1
cp $L/StatementDump.out $D/stmt/after.raw.txt   # kept for the planted-file control below; removed at the end
rm -f $L/StatementDump.out
step "1a. before (this tree's build as given) against after (this job's build): all three modules"
python3 $D/statement_diff.py $D/statements-before.txt $D/statements-after.txt --scope module > $L/statements-final.out; s=$?; cat $L/statements-final.out; [ $s -eq 0 ] || bad=1
step "1b. the reader's control (five planted faults)"
python3 $D/statement_diff.py $D/statements-before.txt $D/statements-after.txt --scope module --control > $L/statements-final.control.out; s=$?; tail -7 $L/statements-final.control.out; [ $s -eq 0 ] || bad=1
step "1c. Arith/UpperHalf: the skeleton's compiled module (FS131-IU1's dump) against this job's build"
python3 $D/statement_diff.py data/fs131/iu1/statements-before.txt $D/statements-after.txt --scope upperhalf > $L/statements-final.upperhalf.out; s=$?; cat $L/statements-final.upperhalf.out; [ $s -eq 0 ] || bad=1
step "1d. a fault planted in a copy of the raw after-dump, past the kept head of exists_stablePrime_rat's stored type"
python3 - $D/stmt/after.raw.txt $D/stmt/after.planted.raw.txt <<'PY' || bad=1
import sys, pathlib
src, dst = map(pathlib.Path, sys.argv[1:3])
lines = src.read_text().split("\n")
i = next(k for k, l in enumerate(lines) if l == "@@ THM HadwigerNelson.UpperHalf.exists_stablePrime_rat")
t = lines[i + 1]; assert t.startswith("TYPE ") and len(t) > 1200
j = t.index("HadwigerNelson.SpectralChain.conjO", 400)   # past the 160 characters the compact form keeps
lines[i + 1] = t[:j] + "HadwigerNelson.SpectralChain.conjX" + t[j + len("HadwigerNelson.SpectralChain.conjO"):]
dst.write_text("\n".join(lines))
print(f"planted: one constant renamed at character {j} of a stored type of {len(t)} characters")
PY
python3 $D/compact_dump.py $D/stmt/after.planted.raw.txt $D/stmt/after.planted.txt > /dev/null || bad=1
python3 $D/statement_diff.py $D/statements-before.txt $D/stmt/after.planted.txt --scope module > $L/statements-planted-file.out; s=$?; tail -2 $L/statements-planted-file.out
if [ $s -eq 1 ] && grep -q '^TYPE     THM HadwigerNelson.UpperHalf.exists_stablePrime_rat' $L/statements-planted-file.out; then echo "PLANTED FILE: reported, naming the theorem"; else echo "PLANTED FILE: NOT REPORTED"; bad=1; fi
rm -f $D/stmt/after.raw.txt $D/stmt/after.planted.raw.txt $D/stmt/after.planted.txt
# 2. the axioms of the 52 public declarations
step "2. axioms of every public declaration of the three files, from the compiled modules"
python3 $D/make_audit.py $D/statements-after.txt || bad=1
$D/lean1.sh $D/lean/Axioms.lean > /dev/null 2>&1; s=$?; echo "lean exit $s"; [ $s -eq 0 ] || bad=1
cp $L/Axioms.out $D/axioms.txt
python3 $D/read_axioms.py $D/axioms.txt 52 --names $D/audit-block.txt > $L/read_axioms.out; s=$?; cat $L/read_axioms.out; [ $s -eq 0 ] || bad=1
python3 $D/read_axioms.py $D/axioms.txt 52 --names $D/audit-block.txt --control > $L/read_axioms.control.out; s=$?; tail -1 $L/read_axioms.control.out; [ $s -eq 0 ] || bad=1
# 3. the models
step "3. the headlines at their inhabitants, from the compiled modules"
$D/lean1.sh $D/lean/Models.lean > /dev/null 2>&1; s=$?; echo "lean exit $s"; [ $s -eq 0 ] || bad=1
cp $L/Models.out $D/models.txt
python3 $D/read_axioms.py $D/models.txt 11 > $L/read_models.out; s=$?; cat $L/read_models.out; [ $s -eq 0 ] || bad=1
# 4. every typed declaration, private helpers included
step "4. axioms of every typed theorem and definition, private helpers included (a footer on a copy of each file)"
$D/axioms-footer.sh > $L/axioms-footer.out 2>&1; s=$?; cat $L/axioms-footer.out; [ $s -eq 0 ] || bad=1
$D/axioms-footer.sh --control > $L/axioms-footer.control.out 2>&1; s=$?; tail -2 $L/axioms-footer.control.out; [ $s -eq 0 ] || bad=1
# 5. the leaves as the compiled module prints them, before and after
step "5. #check of the leaves and their readers: the same print before and after the build"
$D/lean1.sh $D/probes/p3.lean > /dev/null 2>&1; s=$?; echo "lean exit $s"; [ $s -eq 0 ] || bad=1
if cmp -s $L/p3.out $L/p3.before-build.out; then echo "identical"; else echo "DIFFER"; bad=1; fi
echo; echo "after-build: $([ $bad -eq 0 ] && echo ALL STEPS AS EXPECTED || echo SOME STEP FAILED)"
exit $bad
