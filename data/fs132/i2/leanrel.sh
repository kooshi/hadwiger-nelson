#!/bin/bash
# FS132-I2: run one Lean file at the RELEASE's pin (Lean v4.34.1's own binary; LEAN_PATH = the audit's compiled copy
# of the release, `data/fs132/i1/readback/release-lean-path.txt`).  No `lake`: nothing is written there.  $1 = file
W=/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi2
RLP=$(tr -d '\n' < $W/data/fs132/i1/readback/release-lean-path.txt)
exec /home/kooshi/source/lean-dir/scripts/slot.py --mem 12 --cpus 2 -- env LEAN_PATH="$RLP" /home/kooshi/.elan/toolchains/leanprover--lean4---v4.34.1/bin/lean "$1"
