#!/usr/bin/env bash
# FS131-KN3: elaborate one module of the first layer under the slot and write its .olean where the next module finds it.
# usage: data/fs131/kn3/lean1.sh Rigidity/Entropy   (path under Proofs/HadwigerNelson, no extension)
# The log is data/fs131/kn3/logs/<name>.log; its last line is "exit=<status>" (read that, never a pipe's status).
set -u
cd "$(dirname "$0")/../../.."
mod="$1"; name="$(basename "$mod")"
mkdir -p data/fs131/kn3/logs ".lake/build/lib/lean/Proofs/HadwigerNelson/$(dirname "$mod")"
log="data/fs131/kn3/logs/$name.log"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 90 --name kn3 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -o ".lake/build/lib/lean/Proofs/HadwigerNelson/$mod.olean" "Proofs/HadwigerNelson/$mod.lean" > "$log" 2>&1
echo "exit=$?" >> "$log"
