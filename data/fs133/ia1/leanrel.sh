#!/bin/bash
# FS133-IA1: run one Lean file at the RELEASE's pin (Lean v4.34.1's own binary; LEAN_PATH = the audit's compiled copy
# of the release, `data/fs132/i1/readback/release-lean-path.txt`).  No `lake`: nothing is written there.  $1 = file
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1
RLP=$(tr -d '\n' < $W/data/fs132/i1/readback/release-lean-path.txt)
exec env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 10 --cpus 2 --wait 7200 --name ia1 -- env LEAN_PATH="$RLP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.34.1/bin/lean "$1"
