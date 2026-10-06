#!/usr/bin/env bash
# FS131-RP1: `lake env lean` over the edited files (iteration only — never evidence; the build is the evidence).
# Each file elaborates against the oleans on disk; one log per file, with its exit status as the last line.
cd "$(dirname "$0")/../../../.." || exit 2
for f in "$@"; do
  ( n=$(echo "$f" | tr '/' '_'); lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "Proofs/HadwigerNelson/$f.lean" > "data/fs131/rp/lean-check/$n.log" 2>&1; echo "exit $?" >> "data/fs131/rp/lean-check/$n.log" ) &
done
wait
echo "all done"
