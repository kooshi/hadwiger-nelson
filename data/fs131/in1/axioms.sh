#!/usr/bin/env bash
# FS131-IN1: the axioms of every declaration of the module, and where each `sorryAx` comes from.
# usage: data/fs131/in1/axioms.sh source <tag>              between builds: the module's SOURCE + the footer, against the farm
#        data/fs131/in1/axioms.sh compiled <tag> [lib]      after the build: the COMPILED module, from this worktree's library
#                                                           (IN1_NOFARM=1 is set) or from the library directory given
# Keeps logs/axioms-<tag>.txt (the print) and prints read_axioms.py's verdict and its control's.  Extra args after are
# passed to read_axioms.py (e.g. --no-sorry).
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/in1; mode=$1; tag=$2; shift 2
mkdir -p $D/stmt
if [ $mode = source ]; then
  cat Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean $D/lean/AxiomsCore.lean $D/lean/AxiomsFooterCall.lean > $D/stmt/AxCopy.lean
  IN1_HEAD=0 $D/lean1.sh $D/stmt/AxCopy.lean > /dev/null 2>&1; st=$?
else
  cat $D/lean/AxiomsCompiledHead.lean $D/lean/AxiomsCore.lean $D/lean/AxiomsCompiledCall.lean > $D/stmt/AxCopy.lean
  IN1_NOFARM=1 IN1_HEAD=0 $D/lean1.sh $D/stmt/AxCopy.lean > /dev/null 2>&1; st=$?
fi
cp $D/logs/AxCopy.out $D/logs/axioms-$tag.txt
rm -f $D/stmt/AxCopy.lean $D/logs/AxCopy.out $D/logs/AxCopy.err $D/logs/AxCopy.time
echo "axioms.sh ($mode): lean exit $st"
python3 $D/read_axioms.py $D/logs/axioms-$tag.txt "$@"; a=$?
python3 $D/read_axioms.py $D/logs/axioms-$tag.txt "$@" --control | tail -1; b=${PIPESTATUS[0]}
echo "axioms.sh: check exit $a, control exit $b"
[ $st -eq 0 ] && [ $a -eq 0 ] && [ $b -eq 0 ]
