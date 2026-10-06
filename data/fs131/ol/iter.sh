#!/usr/bin/env bash
# FS131-OL1: elaborate one Lean file against this worktree's oleans, under the slot (a script that imports the built library; it builds nothing).
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop || exit 2
exec /home/kooshi/source/lean-dir/scripts/slot.py --mem 20 --cpus 4 --wait 1200 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@"
