#!/bin/bash
# FS131-LCH1: the stored statements before any edit is compiled — the chain tree (fs131-wq1, compiled for fs131-wm15 at
# 77d9d27ce) and main's gated build (fs131-w10g) — one after the other inside one slot. Resume: rerun this script; each
# dump is rewritten whole (no partial state).
set -u
D=/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/data/fs131/lch1
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1 || exit 2
LCH1_OUT=$D/statements-before-chain.txt \
LCH1_FULL=Proofs.HadwigerNelson.Rigidity.,Proofs.HadwigerNelson.Plane.WindowDensity,Proofs.HadwigerNelson.Plane.OneAvoidingDensity,Proofs.HadwigerNelson.Instances.SqrtFortySeven,Proofs.HadwigerNelson.Instances.SqrtClassValues,Proofs.HadwigerNelson.Outside.OAI015,Proofs.HadwigerNelson.Arith.UpperHalf,Proofs.HadwigerNelson.SpectralChain \
  lake env lean $D/lean/StatementDump.lean; e1=$?
echo "chain dump exit=$e1"
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g || exit 3
LCH1_OUT=$D/statements-before-main.txt \
LCH1_FULL=Proofs.HadwigerNelson.Plane.OneAvoidingDensity,Proofs.HadwigerNelson.Plane.OneClass.,Proofs.HadwigerNelson.Arith.ThreeFourColours,Proofs.HadwigerNelson.Instances.SqrtFortySeven,Proofs.HadwigerNelson.Arith.UpperHalf,Proofs.HadwigerNelson.SpectralChain,Proofs.HadwigerNelson.Plane.DensityBound.Theorem \
  lake env lean $D/lean/StatementDump.lean; e2=$?
echo "main dump exit=$e2"
[ $e1 -eq 0 ] && [ $e2 -eq 0 ]
