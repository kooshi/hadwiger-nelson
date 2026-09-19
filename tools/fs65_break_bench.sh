#!/usr/bin/env bash
# fs65_break_bench -- time the three sound translation breaks against each other, one thing differing.
#
# The question this answers: the centroid normalisation quotients the full q^2 translations where
# pinning the origin quotients only q^2/k, so it is the mathematically stronger break -- but a break
# is also an encoding, and an encoding is measured, not assumed.  Runs sequentially on purpose:
# these are wall-clock comparisons and a contended core is a different measurement.
#
# usage: fs65_break_bench.sh <q> <k> <cap-seconds> <reps> <outdir>
set -u
Q=${1:?q}; K=${2:?k}; CAP=${3:-900}; REPS=${4:-2}; OUT=${5:?outdir}
mkdir -p "$OUT"
for B in origin centroid lex none; do
  for R in $(seq 1 "$REPS"); do
    python3 -u tools/fs65_indep_sat.py --q "$Q" --k "$K" --break "$B" \
      --timeout "$CAP" --workdir "$OUT" --out "$OUT/q$Q-k$K-$B-$R.json" 2>&1 | tee -a "$OUT/bench.log"
  done
done
echo "--- $OUT ---"
grep -h "^q=" "$OUT/bench.log"
