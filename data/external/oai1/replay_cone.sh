#!/usr/bin/env bash
# EXT-OAI1 stage 5: replay each module of the cone through the kernel with the toolchain's `leanchecker`,
# ONE MODULE NAMED PER INVOCATION, sequentially (never bare: with no module it replays the whole search path).
# Each invocation builds a kernel environment from the module's imports as stored and re-checks the module's own
# declarations.  Run inside a slot, from the working copy, with env.sh sourced and LEAN_NUM_THREADS set.
# CHECKPOINT: one line per module in <log> ("OK <module> <seconds>s" or "FAIL ...").  RESUME: run again; modules
# already logged OK are skipped.  Ends with a line "REPLAY DONE modules=<n> ok=<n> failed=<n>".
set -u
JSON="$1"; LOG="$2"
mapfile -t MODS < <(python3 -c "import json,sys; print('\n'.join(sorted(json.load(open(sys.argv[1]))['inside'])))" "$JSON")
ok=0; failed=0
for m in "${MODS[@]}"; do
  if grep -qxF "OK $m" <(sed 's/ [0-9]*s$//' "$LOG" 2>/dev/null); then ok=$((ok+1)); continue; fi
  t0=$(date +%s)
  out=$(lake env leanchecker "$m" 2>&1); st=$?
  dt=$(( $(date +%s) - t0 ))
  if [ $st -eq 0 ]; then echo "OK $m ${dt}s" >> "$LOG"; ok=$((ok+1));
  else echo "FAIL $m exit=$st ${dt}s :: $(printf '%s' "$out" | head -c 600 | tr '\n' ' ')" >> "$LOG"; failed=$((failed+1)); fi
done
echo "REPLAY DONE modules=${#MODS[@]} ok=$ok failed=$failed $(date -u +%FT%TZ)" >> "$LOG"
[ $failed -eq 0 ]
