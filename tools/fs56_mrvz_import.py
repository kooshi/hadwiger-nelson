#!/usr/bin/env python3
"""fs56_mrvz_import -- turn the published supplementary material of [MatolcsiEtAl2025] (G27 and its dual witness,
https://bit.ly/fcn-4, copied to ~/source/library/supplementary/mrvz-2311.10069-fcn4/) into FS-56's class-sum certificate
format, so that tools/fs56_gf_check.py re-verifies chi_gf(G27) >= 4 with its own arithmetic, congruence test and enumeration.

What is taken from the authors: the Moser coefficients of the 27 vertices, the list of 16,855 congruences (as vertex maps), and
the rational witness y.  What is NOT taken: their adjacency matrix, their independent-set list, their constraint matrix, their
unit-vector test -- the checker recomputes all of it.  The sign convention was read off their matrix iec.npz (row r is +1 on
independent sets containing the map's domain Y, -1 on those containing its image Y'), so their inequality
  y^T C - 4 e + 1 >= 0   is   4 [0 in S] - sum_r y_r ([Y_r in S] - [Y'_r in S]) <= 1,
i.e. weight -y_r on Y_r, +y_r on Y'_r, and +4 on the singleton {0}; weights on the same set are summed.

Points: a + b w1 + c w3 + d w1 w3 with w1 = (1/2, sqrt3/2), w3 = (5/6, sqrt11/6), over denominator 12 in the basis
1, sqrt3, sqrt11, sqrt33 of Q(sqrt3, sqrt11).
  python3 tools/fs56_mrvz_import.py [SRC_DIR] [OUT]
"""
import hashlib
import json
import sys
from fractions import Fraction
from pathlib import Path

SRC = Path(sys.argv[1] if len(sys.argv) > 1 else Path.home() / "source/library/supplementary/mrvz-2311.10069-fcn4")
OUT = Path(sys.argv[2] if len(sys.argv) > 2 else "data/fs56/g27/cert-g27-mrvz.json")

GEN = [((12, 0, 0, 0), (0, 0, 0, 0)),     # 1
       ((6, 0, 0, 0), (0, 6, 0, 0)),      # w1 = (1/2, sqrt3/2)
       ((10, 0, 0, 0), (0, 0, 2, 0)),     # w3 = (5/6, sqrt11/6)
       ((5, 0, 0, -1), (0, 5, 1, 0))]     # w1 w3 = ((5 - sqrt33)/12, (5 sqrt3 + sqrt11)/12)

coeffs = [list(map(int, l.split())) for l in (SRC / "G_27_coeffs.txt").read_text().splitlines() if l.strip()]
assert len(coeffs) == 27 and all(len(c) == 4 for c in coeffs)
points = []
for c in coeffs:
    x = [sum(k * g[0][t] for k, g in zip(c, GEN)) for t in range(4)]
    y = [sum(k * g[1][t] for k, g in zip(c, GEN)) for t in range(4)]
    points.append([x, y])
rows = [list(map(int, l.split())) for l in (SRC / "G_27_isometries.txt").read_text().splitlines() if l.strip()]
wit = [tuple(map(int, l.split())) for l in (SRC / "witness.txt").read_text().splitlines() if l.strip()]
assert len(rows) == len(wit) == 16855
weights = {(0,): Fraction(4)}
for row, (num, den) in zip(rows, wit):
    Y = tuple(sorted(i for i, v in enumerate(row) if v != -1))
    Yp = tuple(sorted(row[i] for i in Y))
    yr = Fraction(num, den)
    weights[Y] = weights.get(Y, 0) - yr
    weights[Yp] = weights.get(Yp, 0) + yr
listed = [(Y, y) for Y, y in sorted(weights.items()) if y != 0]
k = max(len(Y) for Y, _ in listed)
w = sum((y for Y, y in listed if len(Y) == 1), Fraction(0))
sha = {f: hashlib.sha256((SRC / f).read_bytes()).hexdigest() for f in ("G_27_coeffs.txt", "G_27_isometries.txt", "witness.txt")}
cert = {
    "kind": "fs56-gf-certificate",
    "field": {"radicands": [3, 11]},
    "denominator": 12,
    "level": k,
    "points": points,
    "w": str(w),
    "weights": [{"set": list(Y), "y": str(y)} for Y, y in listed],
    "claim": ("every fractional colouring of the 27-point graph G27 of Matolcsi-Ruzsa-Varga-Zsamboki, all of whose points lie in "
              "Q(sqrt3, sqrt11)^2, whose weight on each point set depends only on its congruence class, weighs at least 4"),
    "derivation": "plans/FS56-quadratic-167.md §1 (B2, B3); the certificate form §4",
    "produced_by": "tools/fs56_mrvz_import.py from the authors' published witness (untrusted; the checker recomputes everything)",
    "provenance": {"source": "https://static.renyi.hu/ai-shared/daniel/fcn-4/ (bit.ly/fcn-4)", "sha256": sha,
                   "sign_convention": "read off iec.npz: +1 on sets containing the domain Y, -1 on sets containing the image Y'"},
}
OUT.parent.mkdir(parents=True, exist_ok=True)
OUT.write_text(json.dumps(cert))
print(f"wrote {OUT}: {len(listed)} weighted sets (level {k}), w = {w}, from {len(rows)} congruence rows")
