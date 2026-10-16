#!/usr/bin/env bash
# FS131-ICT3 iteration only (never evidence): elaborate the three CayleyThree modules' current text with the lakefile's
# options against the tree's compiled library, writing nothing (no -o). Each module reads its imports' compiled .olean.
# Usage (from the worktree root): data/fs131/ict3/check-modules.sh <tag>
set -u
tag="$1"
for m in Circular Fibre Density; do
  log="data/fs131/ict3/logs/$m-$tag.log"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true \
    "Proofs/HadwigerNelson/CayleyThree/$m.lean" > "$log" 2>&1
  st=$?; echo "exit=$st" >> "$log"; echo "$m exit=$st warnings=$(grep -c 'warning' "$log")"
done
