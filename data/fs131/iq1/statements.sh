#!/usr/bin/env bash
# FS131-IQ1: are the skeleton's statements unchanged?  Elaborates the planner's skeleton (git 223241b0a) and a candidate
# file (default: the module in the worktree), each with a footer that prints every public declaration's stored type and
# its hash, and checks that every line of the skeleton's print is a line of the candidate's (the candidate may hold more).
# The `example`s are not stored: their text (from `example` to the next blank line) is compared with the skeleton's.
# usage: statements.sh [candidate.lean]    exit 0 iff every skeleton declaration is found unchanged.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/iq1
BASE=223241b0a
MOD=Proofs/HadwigerNelson/Arith/QuadraticPrime.lean
CAND="${1:-$MOD}"
EXPECT_THEOREMS=13   # `theorem` lines written in the skeleton (12) + the Prop-valued instance (1)
mkdir -p $D/stmt
git show $BASE:$MOD > $D/stmt/Skeleton.lean || exit 2
cat $D/lean/StatementDump.footer >> $D/stmt/Skeleton.lean
cat "$CAND" $D/lean/StatementDump.footer > $D/stmt/Candidate.lean
run() { env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 4 --cpus 2 --name iq1-stmt -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$1" 2>/dev/null; }
run $D/stmt/Skeleton.lean > $D/stmt/skeleton-full.txt; grep '^STMT ' $D/stmt/skeleton-full.txt > $D/stmt/skeleton.txt
run $D/stmt/Candidate.lean > $D/stmt/candidate-full.txt; grep '^STMT ' $D/stmt/candidate-full.txt > $D/stmt/candidate.txt
ns=$(wc -l < $D/stmt/skeleton.txt); nc=$(wc -l < $D/stmt/candidate.txt)
# the reader's own check: every `theorem <name>` / named `instance` written in the skeleton's source is a line of its print
nsrc=0; nfound=0
for nm in $(git show $BASE:$MOD | sed -n -e 's/^theorem \([A-Za-z0-9_.₀-₉]*\).*/\1/p' -e 's/^instance \([A-Za-z0-9_.]*\) .*/\1/p'); do
  nsrc=$((nsrc+1))
  if grep -qF "STMT theorem HadwigerNelson.QuadraticPrime.$nm #" $D/stmt/skeleton.txt; then nfound=$((nfound+1)); else echo "not in the print: $nm"; fi
done
nst=$(grep -c '^STMT theorem ' $D/stmt/skeleton.txt)
# the print holds one line more than the theorems: the matcher `exists_maximal_card_of_padic.match_1_1` (a `def` the
# skeleton's own proof of that theorem generates); it is compared like the rest
if [ "$nsrc" -ne $EXPECT_THEOREMS ] || [ "$nfound" -ne $EXPECT_THEOREMS ] || [ "$nst" -ne $EXPECT_THEOREMS ] || [ "$ns" -ne $((EXPECT_THEOREMS+1)) ]; then
  echo "FAIL: $nsrc theorems written in the skeleton, $nfound of them in its print of $ns lines, $nst of them theorems (expected $EXPECT_THEOREMS, $EXPECT_THEOREMS, $((EXPECT_THEOREMS+1)), $EXPECT_THEOREMS): the reader is broken"; exit 2; fi
missing=$(grep -vxFf $D/stmt/candidate.txt $D/stmt/skeleton.txt)
nm=$(printf '%s' "$missing" | grep -c '^STMT ')
# examples, as text
ex() { awk '/^example/{p=1} p{print} /^$/{p=0}' "$1"; }
git show $BASE:$MOD | ex /dev/stdin > $D/stmt/skeleton-examples.txt
ex "$CAND" > $D/stmt/candidate-examples.txt
nex=$(grep -c '^example' $D/stmt/skeleton-examples.txt)
exdiff=0; cmp -s $D/stmt/skeleton-examples.txt $D/stmt/candidate-examples.txt || exdiff=1
echo "skeleton: $ns declarations ($nsrc written, $nfound printed); candidate: $nc public declarations; skeleton declarations not found unchanged in the candidate: $nm; examples: $nex in the skeleton, text $([ $exdiff -eq 0 ] && echo identical || echo DIFFERS)"
if [ "$nm" -ne 0 ]; then printf '%s\n' "$missing" | cut -c1-400; echo "RESULT: FAIL"; exit 1; fi
if [ "$exdiff" -ne 0 ] || [ "$nex" -ne 6 ]; then diff $D/stmt/skeleton-examples.txt $D/stmt/candidate-examples.txt | head -20; echo "RESULT: FAIL (examples; $nex counted, 6 expected)"; exit 1; fi
echo "RESULT: PASS — every declaration of the skeleton is in the candidate with the same stored type, and the six examples are the skeleton's text"
