#!/usr/bin/env bash
# FS124-I5: are the skeleton's statements unchanged?  Elaborates the planner's skeleton (git 8cd74a6b) and a candidate
# file (default: the module in the worktree), each with a footer that prints every declaration's stored type and its
# hash, and checks that every line of the skeleton's print is a line of the candidate's (the candidate may hold more:
# helpers).  usage: statements.sh [candidate.lean]   exit 0 iff every skeleton declaration is found unchanged.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs124/i5
CAND="${1:-Proofs/HadwigerNelson/Plane/ThreeArcs.lean}"
mkdir -p $D/stmt
git show 8cd74a6b:Proofs/HadwigerNelson/Plane/ThreeArcs.lean > $D/stmt/Skeleton.lean || exit 2
cat $D/lean/StatementDump.footer >> $D/stmt/Skeleton.lean
cat "$CAND" $D/lean/StatementDump.footer > $D/stmt/Candidate.lean
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Skeleton.lean 2>&1 | grep '^STMT ' > $D/stmt/skeleton.txt
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $D/stmt/Candidate.lean > $D/stmt/candidate-full.txt 2>&1
grep '^STMT ' $D/stmt/candidate-full.txt > $D/stmt/candidate.txt
ns=$(wc -l < $D/stmt/skeleton.txt); nc=$(wc -l < $D/stmt/candidate.txt)
nt=$(grep -c '^STMT theorem ' $D/stmt/skeleton.txt)
# the reader's own check: every `theorem <name>` written in the skeleton's source is a line of its print (41 of them;
# the print holds more — a structure's fields are theorems to the kernel)
nsrc=0; nfound=0
for nm in $(git show 8cd74a6b:Proofs/HadwigerNelson/Plane/ThreeArcs.lean | sed -n 's/^theorem \([A-Za-z0-9_.]*\).*/\1/p'); do
  nsrc=$((nsrc+1)); if grep -qE "^STMT theorem HadwigerNelson\.Plane\.([A-Za-z]*\.)?${nm//./\\.} #" $D/stmt/skeleton.txt; then nfound=$((nfound+1)); else echo "not in the print: $nm"; fi
done
if [ "$nsrc" -ne 41 ] || [ "$nfound" -ne 41 ]; then echo "FAIL: $nsrc theorems written in the skeleton, $nfound of them in its print (expected 41 and 41): the reader is broken"; exit 2; fi
missing=$(grep -vxFf $D/stmt/candidate.txt $D/stmt/skeleton.txt)
nm=$(printf '%s' "$missing" | grep -c '^STMT ')
echo "skeleton: $ns declarations ($nt theorems to the kernel, $nsrc written, $nfound of them printed); candidate: $nc declarations ($(grep -c '^STMT theorem ' $D/stmt/candidate.txt) theorems); skeleton declarations not found unchanged in the candidate: $nm"
if [ "$nm" -ne 0 ]; then printf '%s\n' "$missing" | cut -c1-300; echo "RESULT: FAIL"; exit 1; fi
echo "RESULT: PASS — every declaration of the skeleton is in the candidate with the same stored type"
