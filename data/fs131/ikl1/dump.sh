#!/bin/bash
# FS131-IKL1: dump every constant of the modules below from this tree's compiled library (read-only), to $1 (xz).
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1 || exit 2
OUT="$1"
P=Proofs.HadwigerNelson
MODS="$P.Arith.CircleCos,$P.Rigidity.ClassRatio,$P.Rigidity.CountCompletion,$P.Rigidity.CountDescent,$P.Rigidity.CountModels,$P.Arith.FibreCert,$P.Arith.FibreCert3,$P.Arith.FibreCertSound,$P.Arith.FibreCert11Bound,$P.Arith.FibreCert11Psd,$P.Arith.FibreCert11Global,$P.Arith.UpperHalf,$P.Arith.StandingFive,$P.Arith.RatioBound,$P.SpectralChain${IKL1_EXTRA:+,$IKL1_EXTRA}"
TMP="${OUT%.xz}"
IKL1_DUMP_OUT="$TMP" IKL1_DUMP_MODULES="$MODS" ./data/fs131/ikl1/lean1.sh "${IKL1_DUMPER:-data/fs131/ikl1/lean/StatementDump.lean}"
rc=$?
[[ $rc -eq 0 ]] || { echo "dump: lean exit $rc"; exit $rc; }
grep -c "^@@ " "$TMP"
xz -f -T2 "$TMP" && sha256sum "$OUT"
