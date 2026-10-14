#!/usr/bin/env bash
# FS131-IN1: the models of data/fs131/in1/lean/ModelsBody.lean, kernel-checked.
# usage: data/fs131/in1/models.sh source|compiled <tag>
#   source:   the module's SOURCE with the models appended, against the farm (between builds)
#   compiled: `import` of the COMPILED module, then the models, against this worktree's library (after the build)
# Keeps logs/models-<tag>.txt.  Exit 0 iff lean exits 0 with no error and no `sorry` line.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/in1; mode=$1; tag=$2
mkdir -p $D/stmt
if [ $mode = source ]; then
  cat Proofs/HadwigerNelson/Arith/ThreeColourCriterion.lean $D/lean/ModelsBody.lean > $D/stmt/ModelsCopy.lean
  IN1_HEAD=0 $D/lean1.sh $D/stmt/ModelsCopy.lean > /dev/null 2>&1; st=$?
else
  { echo "import Proofs.HadwigerNelson.Arith.ThreeColourCriterion"; cat $D/lean/ModelsBody.lean; } > $D/stmt/ModelsCopy.lean
  IN1_NOFARM=1 IN1_HEAD=0 $D/lean1.sh $D/stmt/ModelsCopy.lean > /dev/null 2>&1; st=$?
fi
cp $D/logs/ModelsCopy.out $D/logs/models-$tag.txt
rm -f $D/stmt/ModelsCopy.lean $D/logs/ModelsCopy.out $D/logs/ModelsCopy.err $D/logs/ModelsCopy.time
e=$(grep -c ': error' $D/logs/models-$tag.txt); s=$(grep -c "declaration uses .sorry." $D/logs/models-$tag.txt)
echo "models.sh ($mode): lean exit $st; errors $e; sorry warnings $s; examples $(grep -c '^example' $D/lean/ModelsBody.lean)"
cat $D/logs/models-$tag.txt | cut -c1-300
[ $st -eq 0 ] && [ $e -eq 0 ] && [ $s -eq 0 ]
