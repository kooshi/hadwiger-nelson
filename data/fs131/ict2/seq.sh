#!/usr/bin/env bash
# FS131-ICT2 iteration only (never evidence): elaborate the three CayleyThree modules in dependency order with the
# lakefile's options, writing each .olean for the next (none of them is compiled in this tree's build yet; the build
# recompiles them, having no trace). Usage (from the worktree root): data/fs131/ict2/seq.sh <tag>
set -u
tag="$1"
B=.lake/build/lib/lean/Proofs/HadwigerNelson/CayleyThree
mkdir -p "$B"
for m in Circular Fibre Density; do
  log="data/fs131/ict2/logs/$m-$tag.log"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true -o "$B/$m.olean" \
    "Proofs/HadwigerNelson/CayleyThree/$m.lean" > "$log" 2>&1
  st=$?; echo "exit=$st" >> "$log"; echo "$m exit=$st"; [ $st -eq 0 ] || break
done
