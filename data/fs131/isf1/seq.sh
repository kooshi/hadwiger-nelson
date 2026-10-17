#!/usr/bin/env bash
# FS131-ISF1: elaborate G27 modules in the order given with `lean -o` into this tree's build (iteration and measurement
# only; the build is the check). usage (from the worktree root): data/fs131/isf1/seq.sh <tag> <Module>...
# logs: data/fs131/isf1/probes/logs/<tag>-<Module>.log (each with the time report and "exit=<n>").
set -u
tag="$1"; shift
B=.lake/build/lib/lean/Proofs/HadwigerNelson/Plane/G27
mkdir -p "$B"
for m in "$@"; do
  data/fs131/isf1/probe.sh "$tag-$m" "Proofs/HadwigerNelson/Plane/G27/$m.lean" "$B/$m.olean" | sed "s/^/$m: /"
  grep -q "^exit=0" "data/fs131/isf1/probes/logs/$tag-$m.log" || { echo "STOP at $m"; exit 1; }
done
