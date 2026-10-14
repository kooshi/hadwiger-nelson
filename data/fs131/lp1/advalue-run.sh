#!/bin/bash
# FS131-LP1: the ADAPTED_VALUE elaboration control (item 807's "owed": FS131-IPD1's variant, `algebra_commRing` with
# `StarSubalgebra.commRingTopologicalClosure …` as its whole value, `build/ipd1/ctlsrc/…`, copied to
# data/fs131/lp1/readback/advalue/OAI158SpectralMeasure-variant.lean).  Steps:
#   1. a scratch farm build/lp1/advfarm: a symbolic copy of this tree's compiled `Proofs` (`cp -as`, each file a link into
#      .lake/build), the link at SpectralMeasure's .olean removed and the variant compiled there with `lean -o` (the
#      lakefile's options by flag); the real .olean's hash checked unchanged after;
#   2. the release's print (data/fs131/ko1/leanrel.sh), this pin's print from the build (`lake env lean`) and this pin's
#      print from the farm (LEAN_PATH = the farm, then the packages), each a file-writing dumper of the one module.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
A=$W/data/fs131/lp1/readback/advalue
F=$W/build/lp1/advfarm
P=/home/kooshi/source/lean-dir/.lake/packages
REAL=$W/.lake/build/lib/lean/Proofs/HadwigerNelson/Outside/OAI158SpectralMeasure.olean
cd $W
sha256sum $REAL > $A/real-olean-before.sha256
rm -rf $F && mkdir -p $F && cp -as $W/.lake/build/lib/lean/Proofs $F/Proofs
tgt=$F/Proofs/HadwigerNelson/Outside/OAI158SpectralMeasure.olean
[ -L "$tgt" ] && rm "$tgt"
for x in ilean c; do [ -L "${tgt%.olean}.$x" ] && rm "${tgt%.olean}.$x"; done
LP="$F"; for d in Cli batteries Qq aesop proofwidgets importGraph LeanSearchClient plausible mathlib; do LP="$LP:$P/$d/.lake/build/lib/lean"; done
LP="$LP:/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/lib/lean"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 7 --cpus 2 --wait 7200 --name lp1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean --root=build/lp1/ctlsrc -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o "$tgt" build/lp1/ctlsrc/Proofs/HadwigerNelson/Outside/OAI158SpectralMeasure.lean > $A/variant-elab.out 2>&1
echo $? > $A/variant-elab.rc
sha256sum $REAL > $A/real-olean-after.sha256
[ -L "$tgt" ] && echo "LINK STILL THERE" >> $A/variant-elab.out
KO1_MEM=8 bash $W/data/fs131/ko1/leanrel.sh $A/ReleaseDumpFile.lean > $A/ReleaseDumpFile.log 2>&1; echo $? > $A/ReleaseDump.rc
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 --wait 7200 --name lp1 -- lake env lean $A/HereDumpFile.lean > $A/HereDumpFile.log 2>&1; echo $? > $A/HereDump.rc
mv $A/HereDump.out $A/HereDump-build.out
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 2 --wait 7200 --name lp1 -- env LEAN_PATH="$LP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/lean $A/HereDumpFile.lean > $A/HereDumpFile-variant.log 2>&1; echo $? > $A/HereDump-variant.rc
mv $A/HereDump.out $A/HereDump-variant.out
