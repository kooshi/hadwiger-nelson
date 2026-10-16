#!/usr/bin/env bash
# FS131-KCS1 (after FS131-K8B1's seq.sh): elaborate the new skeleton modules in dependency order inside one slot, writing
# each new module's .olean for the next (new modules only; no .olean Lake built is overwritten). Iteration only: the build
# is the check. usage (worktree root): data/fs131/kcs1/seq.sh <tag> <Dir/Module>...; logs data/fs131/kcs1/logs/<Module>-<tag>.log.
set -u
tag="$1"; shift
for dm in "$@"; do
  m=$(basename "$dm")
  log="data/fs131/kcs1/logs/$m-$tag.log"
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o ".lake/build/lib/lean/Proofs/HadwigerNelson/$dm.olean" \
    "Proofs/HadwigerNelson/$dm.lean" > "$log" 2>&1
  echo "exit=$?" >> "$log"
done
