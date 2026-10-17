#!/usr/bin/env bash
# FS131-ISF1: a farm for iteration while a build walks (LEAN.md: a symlink copy of the tree's compiled library, the modules
# under work compiled into it with `lean -o`; the build's own files are never written). Iteration only.
#   data/fs131/isf1/farm.sh init                 -- (re)make build/isf1-farm as a symlink copy of .lake/build/lib/lean
#   data/fs131/isf1/farm.sh olean <Mod.Path>      -- compile Proofs/<Mod/Path>.lean into the farm (replacing its link)
#   data/fs131/isf1/farm.sh lean <file.lean>      -- elaborate a file against the farm
set -u
ROOT="$(pwd)"
FARM="$ROOT/build/isf1-farm"
PKGS="$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "$ROOT/.lake/build/lib/lean" | paste -sd:)"
export LEAN_PATH="$FARM/lib:$PKGS"
OPTS="-DautoImplicit=false -DrelaxedAutoImplicit=false"
case "$1" in
  init) rm -rf "$FARM"; mkdir -p "$FARM"; cp -as "$ROOT/.lake/build/lib/lean" "$FARM/lib";;
  olean) f="Proofs/${2//.//}.lean"; o="$FARM/lib/Proofs/${2//.//}.olean"; mkdir -p "$(dirname "$o")"; rm -f "$o" "${o%.olean}.ilean";
         lean $OPTS -o "$o" "$f";;
  lean) lean $OPTS "$2";;
esac
