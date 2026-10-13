#!/usr/bin/env bash
# FS131-IC1: the models of the hypotheses (lean/ModelsBody.lean), elaborated.
#   models.sh copy    — before the build: the working module's text with the body appended, at stmt/Copy.lean
#   models.sh built   — after the build: lean/Models.lean (the import line and the same body) against the built library
# exit status is lean's; the messages are logs/Models-<mode>.out.
set -uo pipefail
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/ic1
M=Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean
mode="${1:-copy}"
mkdir -p $D/stmt
if [ "$mode" = copy ]; then cat $M $D/lean/ModelsBody.lean > $D/stmt/Copy.lean; f=$D/stmt/Copy.lean
else { echo "import Proofs.HadwigerNelson.Arith.ThreeColourCharacter"; cat $D/lean/ModelsBody.lean; } > $D/lean/Models.lean; f=$D/lean/Models.lean; fi
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ic1 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $f > $D/logs/Models-$mode.out 2> $D/logs/Models-$mode.err
st=$?
[ "$mode" = copy ] && rm -f $D/stmt/Copy.lean
cat $D/logs/Models-$mode.out
echo "models ($mode): lean exit $st; errors: $(grep -c ': error' $D/logs/Models-$mode.out); examples in the body: $(grep -c '^example' $D/lean/ModelsBody.lean)"
exit $st
