#!/usr/bin/env bash
# FS131-KRU1: elaborate the new skeleton modules in import order with `lean -o` into this tree's build directory
# (new modules only; iteration, never evidence — the build is the check). Usage: data/fs131/kru1/seq.sh [Module ...]
set -u
cd "$(dirname "$0")/../../.."
mods=("$@")
[ ${#mods[@]} -eq 0 ] && mods=(Rigidity/NormOneGen Rigidity/UnitRingEq Rigidity/UsablePrime Rigidity/PlaneComponents Instances/UnitRingModels)
for m in "${mods[@]}"; do
  src="Proofs/HadwigerNelson/$m.lean"
  out=".lake/build/lib/lean/Proofs/HadwigerNelson/$m"
  mkdir -p "$(dirname "$out")"
  echo "== $m"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$out.olean" -i "$out.ilean" "$src"
  rc=$?
  echo "== $m exit=$rc"
  [ $rc -ne 0 ] && exit $rc
done
exit 0
