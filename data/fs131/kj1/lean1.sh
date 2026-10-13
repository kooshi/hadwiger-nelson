#!/usr/bin/env bash
# FS131-KJ1: elaborate one file against this worktree's built library, under a slot (4 GiB), with the lakefile's two
# autoImplicit options (lake env lean does not apply them). usage: lean1.sh <file.lean> <out>   exit: lean's.
set -u
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wrc || exit 2
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "${KJ1_MEM:-4}" --cpus 2 --wait 7200 --name kj1-lean -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$1" > "$2" 2> "$2.err"
st=$?
echo "lean exit $st" >> "$2.err"
exit $st
