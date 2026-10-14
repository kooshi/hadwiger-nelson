#!/bin/bash
# FS131-IPD1: elaborate one module of the tree (path under Proofs/, dotted name in $1, e.g. Outside.OAI158) at THIS pin
# with the lakefile's three options by flag, against the scratch farm build/ipd1/farm2 — a symbolic copy of the tree's
# compiled library (`cp -as`, every file a link into .lake/build) with the ported modules' oleans linked in — writing
# the module's .olean into the farm.  The link at the target path is removed first, so nothing is ever written through
# it into .lake/build.  $2 = log label.  Log: data/fs131/ipd1/farm2/<module>-<label>.{out,rc,time}.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
F=$W/build/ipd1/farm2
D=$W/data/fs131/ipd1/farm2
P=/home/kooshi/source/lean-dir/.lake/packages
mkdir -p "$D"
rel=${1//.//}
tgt=$F/Proofs/HadwigerNelson/$rel.olean
[ -L "$tgt" ] && rm "$tgt"
case "$tgt" in "$F"/*) ;; *) echo "target outside the farm"; exit 2;; esac
LP="$F"; for d in Cli batteries Qq aesop proofwidgets importGraph LeanSearchClient plausible mathlib; do LP="$LP:$P/$d/.lake/build/lib/lean"; done
LP="$LP:/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/lib/lean"
m=$(basename $rel)
t0=$(date +%s)
cd $W && env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem ${FARM_MEM:-7} --cpus 2 --wait 7200 --name ipd1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean --root=. -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o "$tgt" Proofs/HadwigerNelson/$rel.lean > "$D/$m-$2.out" 2>&1
rc=$?
echo $rc > "$D/$m-$2.rc"; echo $(( $(date +%s) - t0 )) > "$D/$m-$2.time"
echo "$m $2 rc=$rc $(cat $D/$m-$2.time)s errors=$(grep -c ': error' $D/$m-$2.out) warnings=$(grep -c ': warning' $D/$m-$2.out)"
