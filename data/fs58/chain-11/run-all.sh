#!/bin/bash
# FS-58 phase B (B0 pool, controls, B1 screen) over Q(sqrt 11): regenerate every record in data/fs58/chain-11/.
# Resumable: rerun this script; `screen` skips every (L, u) line and lattice line already on disk, `pool` and `control`
# rebuild their records from scratch (seconds). Launch detached from a snapshot copy, never from this file while it runs:
#   cp data/fs58/chain-11/run-all.sh "$SCRATCH/run-all-snapshot.sh"
#   setsid bash -c 'echo $$ > data/fs58/chain-11/run-all.pgid; exec bash "$SCRATCH/run-all-snapshot.sh"' > data/fs58/chain-11/run-all.log 2>&1 &
set -u
cd "$(dirname "$0")/../../.."
D=11
# The brief's six denominators all give the SAME 36 vectors (pool records share one vector_set_sha256); 50 is the first
# denominator that grows W₃(N) (100 vectors), run beyond the brief to test whether the null is a small-pool artefact.
for N in 10 20 40 70 140 280 50; do
  python3 -u tools/fs58_chain.py pool $D $N > data/fs58/chain-11/pool-$N.log 2>&1 || { echo "pool $N FAILED (exit $?)"; exit 1; }
  python3 -u tools/fs58_chain.py control $D $N --wall 60 > /dev/null 2> data/fs58/chain-11/control-$N.err \
    || { echo "control $N FAILED (exit $?): see data/fs58/chain-11/control-$N.out and control-$N.err"; exit 1; }
  [ -s data/fs58/chain-11/control-$N.err ] || rm -f data/fs58/chain-11/control-$N.err
  echo "$(date -Is) control $N: $(tail -1 data/fs58/chain-11/control-$N.out)"
  python3 -u tools/fs58_chain.py screen $D $N --lattices 50 --wall 60 >> data/fs58/chain-11/screen-$N.log 2>&1 \
    || { echo "screen $N FAILED (exit $?)"; exit 1; }
  echo "$(date -Is) screen $N done: $(grep -c . data/fs58/chain-11/screen-$N.jsonl) lines"
  python3 -u tools/fs58_chain.py verify $D $N > data/fs58/chain-11/verify-$N.out 2>&1
  echo "$(date -Is) verify $N exit $?: $(tail -1 data/fs58/chain-11/verify-$N.out)"
done
# Pool records only (no screen) for the other denominators that grow W₃(N): 130 and 230 (108 vectors), 250 (196).
for N in 130 230 250; do
  python3 -u tools/fs58_chain.py pool $D $N > data/fs58/chain-11/pool-$N.log 2>&1 || { echo "pool $N FAILED (exit $?)"; exit 1; }
done
echo "$(date -Is) ALL DONE"
