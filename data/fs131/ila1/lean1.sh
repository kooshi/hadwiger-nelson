#!/usr/bin/env bash
# FS131-ILA1: elaborate one working file with the lakefile's two options, under the slot; output to data/fs131/ila1/logs/<name>.log
set -u
f="$1"; name="$2"
mkdir -p data/fs131/ila1/logs
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 5 --cpus 2 --wait 7200 --name ila1 -- \
  bash -c "lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false '$f' > 'data/fs131/ila1/logs/$name.log' 2>&1; echo \"lean-exit \$?\" >> 'data/fs131/ila1/logs/$name.log'"
tail -1 "data/fs131/ila1/logs/$name.log"
