#!/usr/bin/env bash
# FS131-KN4: elaborate one skeleton module against the tree's build, with a scratch olean farm for its unbuilt
# upstream skeleton modules (LEAN.md: a LEAN_PATH entry holding Proofs/ hides later entries, so the farm is a symlink
# copy of the build's library with the modules under work written over it).
# usage: lean1.sh <Module/Path/Without/Extension relative to Proofs/HadwigerNelson> [-o]
set -u
root=$(cd "$(dirname "$0")/../../.." && pwd)
farm=${KN4_FARM:-/tmp/claude-1000/kn4-farm}
lib=$root/.lake/build/lib/lean
if [ ! -d "$farm/Proofs" ]; then
  mkdir -p "$farm"
  cp -rs "$lib/Proofs" "$farm/" 2>/dev/null
  [ -e "$farm/Proofs.olean" ] || true
fi
mod=$1
src=$root/Proofs/HadwigerNelson/$mod.lean
out=$farm/Proofs/HadwigerNelson/$mod.olean
mkdir -p "$(dirname "$out")"
rm -f "$out"
cd "$root"
LEAN_PATH="$farm:$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "^$lib\$" | paste -sd:)" \
  lean -DautoImplicit=false -DrelaxedAutoImplicit=false -o "$out" "$src"
