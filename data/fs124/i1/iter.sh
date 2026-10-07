#!/bin/bash
# FS124-I1 — iteration only (never evidence): elaborate one file against an overlay of this worktree's build.
# The overlay (build/fs124-i1-olean, ignored by git) is a symlink copy of .lake/build/lib/lean; with `keep`
# the file's .olean is written into the overlay (the symlink is removed first, so the real build is never
# written through), so that a later module elaborates against the edited one.
# usage: data/fs124/i1/iter.sh <path/to/File.lean> [keep]
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk1
M=$W/build/fs124-i1-olean
cd "$W" || exit 2
if [ ! -d "$M" ]; then mkdir -p "$M" && cp -rs "$W/.lake/build/lib/lean/." "$M/" || exit 2; fi
f=$1
extra=""
if [ "$2" = "keep" ]; then
  o=$M/${f%.lean}.olean
  mkdir -p "$(dirname "$o")"; rm -f "$o"; extra="-o $o"
fi
PKGS=$(lake env printenv LEAN_PATH | tr ':' '\n' | grep -v "fs124-wk1/.lake/build" | paste -sd:)
LEAN_PATH=$M:$PKGS timeout 1200 lean -DautoImplicit=false -DrelaxedAutoImplicit=false -Dlinter.missingDocs=true $extra "$f"
