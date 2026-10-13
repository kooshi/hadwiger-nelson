#!/bin/bash
# FS133-K1: elaborate one module of the worktree under the slot, with the lakefile's two options; with a second
# argument "olean", also write its .olean into the build's library so that a later module can import it (the real
# build replaces it). $1 = module path relative to the worktree root.
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
cd "$W" || exit 2
out=()
if [ "$2" = olean ]; then
  o=".lake/build/lib/lean/${1%.lean}.olean"; mkdir -p "$(dirname "$o")"; out=(-o "$o")
fi
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 7200 --name k133 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "${out[@]}" "$1"
