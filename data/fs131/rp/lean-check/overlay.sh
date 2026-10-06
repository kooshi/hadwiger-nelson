#!/usr/bin/env bash
# FS131-RP1: three files read a declaration this pass moved upstream, so the oleans on disk cannot check them.
# Compile the two changed upstream modules into an overlay directory (build/ is scratch) and elaborate the three against
# the overlay first, the built library second.  Iteration only — never evidence.
cd "$(dirname "$0")/../../../.." || exit 2
O=build/rp-overlay; P=Proofs/HadwigerNelson/Plane
# Lean takes every `Proofs.*` module from the first path entry that holds `Proofs/`, so the overlay is a symlink copy of the
# built library with the two changed modules compiled over their links.
rm -rf "$O"; mkdir -p "$O"; cp -rs "$PWD/.lake/build/lib/lean/Proofs" "$O/Proofs"; rm -f "$O/$P/Basic.olean" "$O/$P/ValidMap/Basic.olean"
OPTS="-DautoImplicit=false -DrelaxedAutoImplicit=false"
lake env lean $OPTS -o "$O/$P/Basic.olean" "$P/Basic.lean" || { echo "overlay Basic FAILED"; exit 1; }
lake env lean $OPTS -o "$O/$P/ValidMap/Basic.olean" "$P/ValidMap/Basic.lean" || { echo "overlay ValidMap/Basic FAILED"; exit 1; }
for f in SixFragment ValidMap/Pushforward ValidMap/OpenMove; do
  ( n=$(echo "$f" | tr '/' '_'); lake env sh -c "LEAN_PATH=$PWD/$O:\$LEAN_PATH lean $OPTS $P/$f.lean" > "data/fs131/rp/lean-check/overlay_$n.log" 2>&1; echo "exit $?" >> "data/fs131/rp/lean-check/overlay_$n.log" ) &
done
wait
echo "overlay done"
