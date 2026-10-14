#!/bin/bash
# FS131-IKC2: elaborate one file of this tree with `lake env lean` under the slot (iteration only; not the build).
# Usage: data/fs131/ikc2/chk.sh <file.lean> [mem GiB, default 5]
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf || exit 2
f="$1"; mem="${2:-5}"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem "$mem" --cpus 1 --wait 7200 --name ikc2 -- \
  /usr/bin/time -f "TIME %e s RSS %M KB" lake env lean "$f"
