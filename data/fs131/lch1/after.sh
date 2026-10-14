#!/bin/bash
# FS131-LCH1: after a build of the joined tree — the stored statements (every constant; full text for the chain's modules
# and main's touched ones), the ruled changes undone (ReAdd), and every chain record's axioms with its sorry leaves.
# Usage: after.sh <n>   (writes statements-after-<n>.txt, readd-<n>.txt, axioms-all-<n>.txt). Resume: rerun (each
# output is rewritten whole).
set -u
n=$1
D=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/lch1
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1 || exit 2
LCH1_OUT=$D/statements-after-$n.txt \
LCH1_FULL=Proofs.HadwigerNelson.Rigidity.,Proofs.HadwigerNelson.Plane.WindowDensity,Proofs.HadwigerNelson.Plane.OneAvoidingDensity,Proofs.HadwigerNelson.Instances.SqrtFortySeven,Proofs.HadwigerNelson.Instances.SqrtClassValues,Proofs.HadwigerNelson.Outside.OAI015,Proofs.HadwigerNelson.Arith.UpperHalf,Proofs.HadwigerNelson.SpectralChain,Proofs.HadwigerNelson.Plane.OneClass.,Proofs.HadwigerNelson.Arith.ThreeFourColours,Proofs.HadwigerNelson.Plane.DensityBound.Theorem,Proofs.HadwigerNelson.Plane.MOneBound,Proofs.HadwigerNelson.Arith.CircleCos \
  lake env lean $D/lean/StatementDump.lean; e1=$?
echo "dump exit=$e1"
lake env lean $D/lean/ReAdd.lean > $D/readd-$n.txt 2>&1; e2=$?
echo "readd exit=$e2"
lake env lean $D/lean/AxiomsAll.lean > $D/axioms-all-$n.txt 2>&1; e3=$?
echo "axioms exit=$e3"
[ $e1 -eq 0 ] && [ $e2 -eq 0 ] && [ $e3 -eq 0 ]
