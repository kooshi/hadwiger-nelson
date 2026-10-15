#!/usr/bin/env bash
# FS131-KN8: elaborate one module under the slot with the lakefile's two autoImplicit options, and write its .olean
# where the next module finds it (iteration only: Lake recompiles it at the next build; never a verdict on a module).
# usage: data/fs131/kn8/lean1.sh Rigidity/Entropy   (path under Proofs/HadwigerNelson, no extension)
# The log is data/fs131/kn8/logs/lean1-<name>.log; its last line is "exit=<status>" (read that, never a pipe's status).
set -u
cd "$(dirname "$0")/../../.."
mod="$1"; name="$(basename "$mod")"
log="data/fs131/kn8/logs/lean1-$name.log"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 1800 --name kn8s -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -o ".lake/build/lib/lean/Proofs/HadwigerNelson/$mod.olean" "Proofs/HadwigerNelson/$mod.lean" > "$log" 2>&1
echo "exit=$?" >> "$log"
tail -1 "$log"
