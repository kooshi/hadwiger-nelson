#!/bin/bash
# Elaborate the new skeleton modules in order with `lean -o` into this tree's build (iteration only; the build is the check).
cd "$(dirname "$0")/../../.." || exit 2
mkdir -p .lake/build/lib/lean/Proofs/HadwigerNelson/RationalFour .lake/build/lib/lean/Proofs/HadwigerNelson/Instances
for m in "$@"; do
  echo "== $m"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o ".lake/build/lib/lean/${m}.olean" "${m}.lean" 2>&1 | grep -v "declaration uses .sorry"
  echo "exit ${PIPESTATUS[0]}"
done
