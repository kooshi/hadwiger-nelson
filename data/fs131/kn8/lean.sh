#!/usr/bin/env bash
# FS131-KN8: elaborate one scratch file under data/fs131/kn8/lean/ against this worktree's compiled library, under the slot,
# with the lakefile's two autoImplicit options; writes no compiled file.
# usage: data/fs131/kn8/lean.sh Probe    (the file data/fs131/kn8/lean/Probe.lean)
# The log is data/fs131/kn8/logs/lean-<name>.log; its last line is "exit=<status>" (read that, never a pipe's status).
set -u
cd "$(dirname "$0")/../../.."
name="$1"
log="data/fs131/kn8/logs/lean-$name.log"
env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 4 --cpus 2 --wait 1800 --name kn8p -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "data/fs131/kn8/lean/$name.lean" > "$log" 2>&1
echo "exit=$?" >> "$log"
tail -1 "$log"
