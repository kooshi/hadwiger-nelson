#!/usr/bin/env bash
# FS131-K8B1 (copied from FS131-KT1's data/fs131/kt1/lean1.sh): elaborate one Lean file under the slot, with the
# lakefile's two options passed by hand (lake env lean does not apply them).
# usage: data/fs131/k8b1/lean1.sh <file.lean> <logname>
# The log is data/fs131/k8b1/logs/<logname>.log; its last line is "exit=<status>" (read that, never a pipe's status).
set -u
cd "$(dirname "$0")/../../.."
file="$1"; name="$2"
log="data/fs131/k8b1/logs/$name.log"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 1800 --name k8b1 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "$file" > "$log" 2>&1
echo "exit=$?" >> "$log"
