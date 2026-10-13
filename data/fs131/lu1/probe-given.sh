#!/usr/bin/env bash
# FS131-LU1: the gate's read-only steps on the built tree BEFORE any registration — what each says of the module as
# merged.  One step at a time under the slot (m.sh), each to data/fs131/lu1/probes/<name>-<tag>.log with its exit on the
# last line; a summary line per step on stdout.  Nothing here writes outside data/fs131/lu1/ and build/gate/.
# Usage: probe-given.sh <tag>
cd "$(dirname "$0")/../../.." || exit 2
tag="${1:?tag}"; L=data/fs131/lu1
echo "HEAD=$(git rev-parse HEAD) $(date -u +%Y-%m-%dT%H:%M:%SZ) tracked files modified: $(git status --porcelain --untracked-files=no | wc -l)"
$L/m.sh "uptodate-$tag" 4 2 lake build --no-build Proofs
$L/m.sh "checks-$tag" 6 2 lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false $L/checks.lean
$L/m.sh "decls-$tag" 6 2 lake env lean $L/decls.lean
$L/m.sh "dupnames-$tag" 8 4 ./scripts/dupnames.sh
$L/m.sh "lint-$tag" 8 4 lake lint --no-build -- --no-build --trace
$L/m.sh "vacuity-$tag" 8 4 ./scripts/vacuity.sh
cp "$(readlink -f build/gate/vacuity/latest)" "$L/probes/receipt-vacuity-$tag.log" 2>/dev/null
$L/m.sh "assumptions-$tag" 8 4 ./scripts/assumptions.sh
cp "$(readlink -f build/gate/assumptions/latest)" "$L/probes/receipt-assumptions-$tag.log" 2>/dev/null
echo "probe-given $tag done $(date -u +%Y-%m-%dT%H:%M:%SZ)"
