#!/usr/bin/env bash
# FS131-KJ1: what is read from the built tree after the last build — the axioms of every declaration of the line's nine
# files (reader's verdict and control), the statement comparison with the dump of the first build (and its control), the
# environment linters. Each step's exit status is printed; nothing is piped.
set -u
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc || exit 2
D=data/fs131/kj1
$D/lean1.sh $D/lean/Axioms.lean $D/logs/axioms-final.txt; echo "axioms print: lean exit $?"
python3 $D/read_axioms.py $D/logs/axioms-final.txt --expect-sorry $D/sorry-expected-final.txt > $D/logs/axioms-final.out; echo "axioms reader: exit $?"
$D/lean1.sh $D/lean/StatementDump.lean $D/logs/statements-final.txt; echo "statement dump: lean exit $?"
python3 $D/statement_diff.py $D/logs/statements-build1.txt $D/logs/statements-final.txt > $D/logs/statements-final.out; echo "statement comparison: exit $?"
python3 $D/statement_diff.py $D/logs/statements-build1.txt $D/logs/statements-final.txt --plant > $D/logs/statements-final.plant.out; echo "statement comparison control: exit $?"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 2 --wait 7200 --name kj1-lint -- lake lint --no-build -- --no-build --trace > $D/logs/lint.out 2> $D/logs/lint.err; echo "lint: exit $?"
