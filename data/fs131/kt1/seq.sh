#!/usr/bin/env bash
# FS131-KT1: elaborate lane T's modules in dependency order inside one slot, writing each .olean for the next.
# usage (from the worktree root): data/fs131/kt1/seq.sh <tag>; logs data/fs131/kt1/logs/<Module>-<tag>.log, each ending "exit=<n>".
set -u
tag="$1"
B=.lake/build/lib/lean/Proofs/HadwigerNelson/Rigidity
for m in TateModel TateLocal TateArch TateCharacter TateKernel TateExists; do
  log="data/fs131/kt1/logs/$m-$tag.log"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$B/$m.olean" "Proofs/HadwigerNelson/Rigidity/$m.lean" > "$log" 2>&1
  echo "exit=$?" >> "$log"
done
log="data/fs131/kt1/logs/Names-$tag.log"
lake env lean -DautoImplicit=false data/fs131/kt1/probes/Names.lean > "$log" 2>&1
echo "exit=$?" >> "$log"
