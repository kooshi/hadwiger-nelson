#!/usr/bin/env bash
# Iterate one Lean file against this worktree's oleans (iteration only, never evidence; LEAN.md § Building).
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop || exit 2
exec /home/kooshi/source/lean-dir/scripts/slot.py --mem 16 --cpus 4 --wait 1200 -- lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$@"
