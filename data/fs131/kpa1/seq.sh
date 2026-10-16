#!/usr/bin/env bash
# FS131-KPA1: elaborate the new PadicPlane skeleton modules in order with `lean -o` into this tree's build directory
# (new modules only; iteration, not the gate — the gate is ./scripts/build.sh). Usage: data/fs131/kpa1/seq.sh Mod1 Mod2 ...
set -uo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh
for m in "$@"; do
  src="Proofs/HadwigerNelson/PadicPlane/$m.lean"
  out=".lake/build/lib/lean/Proofs/HadwigerNelson/PadicPlane/$m.olean"
  mkdir -p "$(dirname "$out")"
  echo "== $m"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$out" "$src" || { echo "FAIL $m"; exit 1; }
done
