#!/bin/bash
# FS131-IRF1 (after FS131-KFS1's seq.sh): elaborate the named modules in order with `lean -o` into this tree's build, so the
# next module's iteration sees them. Iteration only; the build through ./scripts/build.sh is the check.
cd "$(dirname "$0")/../../.." || exit 2
source scripts/dev-env.sh 2>/dev/null
for m in "$@"; do
  echo "== $m"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o ".lake/build/lib/lean/${m}.olean" -i ".lake/build/lib/lean/${m}.ilean" "${m}.lean"
  echo "exit $?"
done
