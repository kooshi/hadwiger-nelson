#!/usr/bin/env bash
# FS131-K8B1 (after FS131-KT1's data/fs131/kt1/seq.sh): elaborate the new modules in dependency order inside one slot,
# writing each new module's .olean for the next (only new modules: no .olean Lake built is overwritten).
# usage (from the worktree root): data/fs131/k8b1/seq.sh <tag> <Module>...; logs data/fs131/k8b1/logs/<Module>-<tag>.log, each ending "exit=<n>".
set -u
tag="$1"; shift
B=.lake/build/lib/lean/Proofs/HadwigerNelson/Rigidity
for m in "$@"; do
  log="data/fs131/k8b1/logs/$m-$tag.log"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$B/$m.olean" "Proofs/HadwigerNelson/Rigidity/$m.lean" > "$log" 2>&1
  echo "exit=$?" >> "$log"
done
