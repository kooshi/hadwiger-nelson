#!/usr/bin/env bash
# FS-54 D2 — the calibrated plane-independent ladder at q = 27 (P8 registered: plateaus at 117, probability 0.7).
# Each stage rewrites its --out every progress tick; a killed stage resumes with: --start <its out> --out <its out>.
set -u
BIN=/home/kooshi/source/descent-engine/target/release/plane-independent
D=/home/kooshi/source/lean-dir/data/fs54/ladder
common=(--q 27 --modulus 't^3-t-1' --target 122 --threads 12 --progress-seconds 30 --no-colour)
stage() { name=$1; shift; [ -f "$D/$name.done" ] && { echo "skip $name"; return; }
  echo "== $name $(date -Is)"; "$BIN" "${common[@]}" "$@" --out "$D/$name.json" > "$D/$name.log" 2>&1
  echo "exit $? $(date -Is)" >> "$D/$name.log"; touch "$D/$name.done"; }
stage free-s1 --seed 1 --max-seconds 900
for m in 2 4 7 14 28; do stage rot$m-s1 --seed 1 --rotation-order $m --max-seconds 300; done
stage line-s1 --seed 1 --line-direction --max-seconds 300
stage free-s2 --seed 2 --max-seconds 600
echo "LADDER COMPLETE $(date -Is)"
