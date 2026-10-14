#!/usr/bin/env bash
# FS131-IP23: compile one module (a scratch generated copy) to an .olean in the tree's library under the slot, so that
# a dumper can import it (iteration only: `LEAN.md` § Building; the build recompiles it).  The module's name is taken
# from its path under <root> (`lean --root`).
# usage: data/fs131/ip23/olean1.sh <root> <Module.Path> <log>      (paths relative to the worktree)
set -u
cd "$(dirname "$0")/../../.."
root="$1"; mod="$2"; log="$3"
rel="$(echo "$mod" | tr . /)"
out=".lake/build/lib/lean/$rel.olean"
t0=$(date +%s)
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 5 --cpus 2 --wait 7200 --name ip23 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false --root="$root" -o "$out" "$root/$rel.lean" > "$log" 2>&1
st=$?
echo "seconds=$(( $(date +%s) - t0 ))" >> "$log"; echo "exit=$st" >> "$log"; echo "olean=$out" >> "$log"
tail -3 "$log"
