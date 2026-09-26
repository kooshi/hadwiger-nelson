#!/usr/bin/env bash
# J40 stage 1: check the brief's quoted fragments occur in J27D's record (fixed strings, grep -F).
set -u
R=plans/FS67-J27D-derivation.md; P=plans/FS67-tight-products.md
miss=0
chk() { if grep -qF -- "$2" "$1"; then echo "OK   [$1] $2"; else echo "MISS [$1] $2"; miss=$((miss+1)); fi; }
chk $R '"uniquely colorable graph"'
chk $R 'expander'
chk $R 'Lemma W'
chk $R 'is a component invariant'
chk $R 'DC-2 at `τ_k = 1/(k−1)`, `G` any `k`-gap-free graph'
chk $P 'In [17] it is proved that A(n) implies B(n) and B(n) implies H(n).'
chk $R 'DA-4: FS67 fails for a finite connected uniquely `k`-colourable `G` at every `k ≥ 4`'
[ "${PLANT:-0}" = 1 ] && chk $R '"uniquely colourable" × "expander"'
echo "missing=$miss"; exit $miss
