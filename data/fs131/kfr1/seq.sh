#!/usr/bin/env bash
# FS131-KFR1: elaborate the new skeleton modules in order with `lean -o` (iteration only; the build is the check).
set -u
cd "$(dirname "$0")/../../.."
for m in "$@"; do
  f="Proofs/HadwigerNelson/$m.lean"; o=".lake/build/lib/lean/Proofs/HadwigerNelson/$m"
  mkdir -p "$(dirname "$o")"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$o.olean" -i "$o.ilean" "$f" > "data/fs131/kfr1/logs/$(echo $m | tr / _).log" 2>&1
  echo "$m exit=$?"
done
