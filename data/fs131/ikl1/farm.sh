#!/bin/bash
# FS131-IKL1: a farm — a symlink copy of this tree's compiled library (`cp -as`), with the working modules compiled
# over their links by `lean -o`, so a file importing them elaborates without a build. The build's own library is
# untouched (only links are read). The module name is the source's path below IKL1_ROOT (default: the tree). Usage: farm.sh <ModulePath relative to Proofs/HadwigerNelson> <source .lean> ...
set -uo pipefail
TREE=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1
FARM=$TREE/data/fs131/ikl1/farm
cd "$TREE" || exit 2
source scripts/dev-env.sh 2>/dev/null
if [[ ! -d "$FARM/Proofs" ]]; then
  mkdir -p "$FARM"
  cp -as "$TREE/.lake/build/lib/lean/Proofs" "$FARM/Proofs" || exit 3
  cp -as "$TREE/.lake/build/lib/lean/Proofs.olean" "$FARM/" 2>/dev/null || true
fi
while [[ $# -ge 2 ]]; do
  mod="$1"; src="$2"; shift 2
  out="$FARM/Proofs/HadwigerNelson/$mod.olean"
  ilean="$FARM/Proofs/HadwigerNelson/$mod.ilean"
  mkdir -p "$(dirname "$out")"
  rm -f "$out" "$ilean"
  env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name ikl1f -- \
    timeout 900 lake env bash -c 'LEAN_PATH="'"$FARM"':$LEAN_PATH" exec lean -DautoImplicit=false -DrelaxedAutoImplicit=false -R "$4" -o "$1" -i "$2" "$3"' _ "$out" "$ilean" "$src" "${IKL1_ROOT:-$TREE}"
  rc=$?
  echo "farm: $mod from $src exit $rc"
  [[ $rc -eq 0 ]] || exit $rc
done
