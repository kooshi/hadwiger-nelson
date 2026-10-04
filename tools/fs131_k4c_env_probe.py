#!/usr/bin/env python3
"""FS131-K4c: a float probe (not a proof, not a search) of the formal N2-ENV statement's shape before it is written in Lean.

Frame P = 0, the closed arc e([0, l]), l <= pi/3. A toward lens point z = (1 - s) e(phi), away z = (1 + s) e(phi), with the profile
0 < s <= psi * min(phi, l - phi). For each, the part of the closed unit disc about z outside the union of the open unit discs about
the arc's points is sampled; the probe reports its largest distance from P (toward) and from the radius-2 arc R2 (away), and checks
the near-tile clause (every point of the lens I = B(A,1) cap B(B,1) within 1 of a toward lens point). Expectation (N2-ENV): each
radius tends to 0 with psi; the near clause holds for small psi.

--plant flips the profile to s = 3 * min(phi, l - phi) (psi = 3): the toward radius must then stay large (it fires)."""
import math, sys

def e(t): return complex(math.cos(t), math.sin(t))

def mind_arc(p, l, n=200):
    return min(abs(p - e(l * i / n)) for i in range(n + 1))

def dist_R2(p, l, n=200):
    return min(abs(p - 2 * e(l * i / n)) for i in range(n + 1))

def probe(l, psi, away, nphi=12, nb=60, nr=12):
    worst = 0.0
    for i in range(1, nphi):
        phi = l * i / nphi
        s = psi * min(phi, l - phi)
        z = (1 + s if away else 1 - s) * e(phi)
        for a in range(nb):
            for r in range(1, nr + 1):
                p = z + (r / nr) * e(2 * math.pi * a / nb)
                if mind_arc(p, l) >= 1:
                    d = dist_R2(p, l) if away else abs(p)
                    worst = max(worst, d)
    return worst

def near(l, psi, nphi=10, ng=40):
    A, B = e(0), e(l)
    bad = 0
    for i in range(1, nphi):
        phi = l * i / nphi
        s = psi * min(phi, l - phi)
        z = (1 - s) * e(phi)
        for a in range(ng):
            for b in range(ng):
                p = complex(-1 + 3 * a / ng, -1 + 3 * b / ng)
                if abs(p - A) <= 1 and abs(p - B) <= 1 and abs(p - z) >= 1:
                    bad += 1
    return bad

if __name__ == "__main__":
    plant = "--plant" in sys.argv
    l = math.pi / 3
    rows = []
    for psi in ([3.0] if plant else [0.4, 0.1, 0.02]):
        rows.append((psi, probe(l, psi, False), probe(l, psi, True), near(l, psi)))
    for psi, t, a, nb in rows:
        print(f"psi={psi}: toward max|p-P|={t:.4f}  away max dist(p,R2)={a:.4f}  near-clause violations={nb}")
    if plant:
        ok = rows[0][1] > 0.1
        print("PLANT FIRED" if ok else "PLANT DID NOT FIRE")
        sys.exit(0 if ok else 1)
    mono = rows[0][1] >= rows[-1][1] and rows[0][2] >= rows[-1][2]
    print("OK (radii shrink with psi)" if mono else "UNEXPECTED")
    sys.exit(0 if mono else 1)
