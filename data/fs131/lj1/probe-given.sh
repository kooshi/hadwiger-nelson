#!/usr/bin/env bash
# FS131-LJ1: the tree as merged and built, before any registration and before any edit of the assumptions list —
# each step under the slot through m.sh, one at a time; every exit on the last line of its own log.
cd "$(dirname "$0")/../../.." || exit 2
D=data/fs131/lj1
$D/m.sh decls-given 8 2 lake env lean $D/decls.lean
$D/m.sh dupnames-given 8 2 ./scripts/dupnames.sh
$D/m.sh assumptions-selftest-first 8 2 ./scripts/assumptions.sh --self-test
$D/m.sh assumptions-given 8 2 ./scripts/assumptions.sh
cp build/gate/assumptions/latest $D/probes/receipt-assumptions-given.log 2>/dev/null || echo "no latest assumptions receipt"
$D/m.sh vacuity-given 8 2 ./scripts/vacuity.sh
cp build/gate/vacuity/latest $D/probes/receipt-vacuity-given.log 2>/dev/null || echo "no latest vacuity receipt"
echo "PROBE-GIVEN DONE $(date -u +%FT%TZ)"
