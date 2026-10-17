#!/usr/bin/env bash
# FS131-IRF1: the three scans once before the gate, to read the counts the gate's inputs record (dupnames, axioms, vacuity,
# assumptions); logs in data/fs131/irf1/pre/, exit status on each log's last line.
cd "$(dirname "$0")/../../../.." || exit 2
export SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6
d=data/fs131/irf1/pre
run() { local name="$1" mem="$2"; shift 2; local t0=$(date +%s)
  python3 scripts/slot.py --mem "$mem" --cpus 4 --wait 3600 --name "irf1-pre-$name" -- "$@" > "$d/$name.log" 2>&1; local st=$?
  echo "exit=$st wall=$(( $(date +%s) - t0 ))s" >> "$d/$name.log"; echo "$name exit=$st"; }
{ run dupnames 8 ./scripts/dupnames.sh; run axioms 8 ./scripts/axioms.sh; run vacuity 8 ./scripts/vacuity.sh; run assumptions 8 ./scripts/assumptions.sh; echo done; } > "$d/run-pre.out" 2>&1
