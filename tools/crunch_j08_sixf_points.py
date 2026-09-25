#!/usr/bin/env python3
"""J08 stage 6: the measured half for SIX-f -- the derived band-1/6 (and 1/5, 1/4) types checked on actual unit vectors.

For every passing class-tuple in data/fs91/j08/sixf.json, its representative torsion character tau (a sum of local
characters (u x + v y)/M read through Z[1/c] -> Z/M) plus an archimedean alpha(x, y) = r (x cos b + y sin b) is evaluated on
every rational unit vector (a/c, b/c) from the primitive Pythagorean triples with c <= CMAX (all signs and the swap), for
r = r_max and 8 directions b: every value must lie in the closed band.  And r = r_max + 1/200 must FAIL somewhere for some
direction (density of U_Q makes r_max sharp; a pass there would refute the sumset derivation's r_max) -- the plant that
must fire.  Also a negative control: an order-27 character at 3 (not in any list) must fail at band 1/6.
Writes data/fs91/j08/sixf-points.json always.
"""
import json
import math
import sys
from fractions import Fraction
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SIXF = ROOT / "data" / "fs91" / "j08" / "sixf.json"
OUT = ROOT / "data" / "fs91" / "j08" / "sixf-points.json"
CMAX = 1500


def vectors():
    out = []
    for m in range(1, 60):
        for n in range(1, m):
            if (m - n) % 2 == 1 and math.gcd(m, n) == 1:
                a, b, c = m * m - n * n, 2 * m * n, m * m + n * n
                if c > CMAX:
                    continue
                for x, y in ((a, b), (b, a)):
                    for sx in (1, -1):
                        for sy in (1, -1):
                            out.append((sx * x, sy * y, c))
    out += [(1, 0, 1), (-1, 0, 1), (0, 1, 1), (0, -1, 1)]
    return out


def tau(rep, mod, x, y, c):
    s = Fraction(0)
    for name, (u, v) in rep.items():
        M = mod[name]
        ci = pow(c, -1, M)
        s += Fraction(((u * x + v * y) * ci) % M, M)
    return float(s % 1)


def band_ok(val, k):
    d = val % 1.0
    d = min(d, 1 - d)
    return d >= 1.0 / k - 1e-12


def main():
    data = json.loads(SIXF.read_text())
    vecs = vectors()
    ok = True
    rep = {"kind": "fs91-j08-sixf-points", "vectors": len(vecs), "rows": []}
    for k in ("4", "5", "6"):
        for r in data["results"][k]:
            rmax = r["r_max_float"]
            tv = [tau(r["representative"], r["moduli"], x, y, c) for x, y, c in vecs]
            holds = all(band_ok(t + rmax * (x / c * math.cos(b) + y / c * math.sin(b)), int(k))
                        for t, (x, y, c) in zip(tv, vecs) for b in [j * math.pi / 4 for j in range(8)])
            rr = rmax + 1 / 200
            breaks = not all(band_ok(t + rr * (x / c * math.cos(b) + y / c * math.sin(b)), int(k))
                             for t, (x, y, c) in zip(tv, vecs) for b in [j * math.pi / 4 for j in range(8)])
            ok &= holds and breaks
            rep["rows"].append({"k": k, "type": r["type"], "holds_at_r_max": holds, "breaks_above": breaks})
            print(f"k={k} {r['type']:<45} holds at r_max={r['r_max']}: {holds}; breaks at r_max+1/200: {breaks}")
    neg = {"3": [1, 0]}
    negfail = not all(band_ok(tau(neg, {"3": 27}, x, y, c), 6) for x, y, c in vecs)
    print(f"negative control x/27 at band 1/6 fails on some unit vector: {negfail}")
    ok &= negfail
    rep["negative_control_fired"] = negfail
    rep["ok"] = bool(ok)
    OUT.write_text(json.dumps(rep, indent=1) + "\n")
    print(f"{len(vecs)} unit vectors;", "ALL OK" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
