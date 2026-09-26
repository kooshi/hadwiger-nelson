#!/usr/bin/env python3
"""J28D (crunch 2026-09-25): which stable places are absorbed into the tight compact factor Y' (hypothesis H*:
lambda/d > -1/3 for every nontrivial character at every level) and which stay in X (need an all-levels ratio < 1/4).

Level one: Gamma_p = Cay(F_p^2, {x^2+y^2=1}) (p = 3 mod 4, circle of p+1 points), eigenvalues
lambda(xi) = sum_{s on circle} cos(2 pi <xi,s>/p) (float; error < 1e-9 asserted against the margin).
Higher levels: Lemma P (FS86-LP) gives |lambda|/d <= 2/(p+1) for characters new at level >= 2, which is < 1/3 for p >= 7.
Stable odd places of F = Q(sqrt d): p = 3 mod 4 with (d/p) = 1 (residue F_p), or p | d with p = 3 mod 4 (ramified); residue field F_p.
Usage: crunch_j28d_factors.py [--plant]   (plant: the split conic x^2 - y^2 = 1 in place of the circle; must fail the size assert)
"""
import math, sys

PLANT = "--plant" in sys.argv

def circle(p):
    pts = [(x, y) for x in range(p) for y in range(p)
           if ((x * x - y * y) if PLANT else (x * x + y * y)) % p == 1]
    assert len(pts) == p + 1, f"circle over F_{p} has {len(pts)} points, expected {p+1}"
    return pts

def spectrum(p):
    pts = circle(p); d = p + 1; lo, hi = 1.0, -1.0
    for a in range(p):
        for b in range(p):
            if a == 0 and b == 0: continue
            lam = sum(math.cos(2 * math.pi * ((a * x + b * y) % p) / p) for x, y in pts) / d
            lo, hi = min(lo, lam), max(hi, lam)
    return lo, hi

def legendre(a, p):
    return pow(a % p, (p - 1) // 2, p)

def stable_places(d, bound):
    out = []
    for p in range(3, bound, 2):
        if any(p % q == 0 for q in range(3, int(p ** 0.5) + 1, 2)): continue
        if p % 4 != 3: continue
        if d % p == 0: out.append((p, "ramified"))
        elif legendre(d, p) == 1: out.append((p, "split in F"))
    return out

def main():
    print("# J28D factor table (level one exact-float spectra; Lemma P above level one)")
    fields = {59: "type (B)", 83: "type (B)", 131: "type (B)", 47: "type (A)", 11: "control (stable 7)"}
    for d, kind in fields.items():
        print(f"\n## Q(sqrt {d}) — {kind}")
        for p, how in stable_places(d, 72):
            lo, hi = spectrum(p)
            hoff = -lo / (1 - lo)
            hstar = lo > -1 / 3 + 1e-9 and 2 / (p + 1) < 1 / 3
            print(f"p={p:3d} ({how:10s}) lambda_min/d={lo:+.9f} max|lambda|/d={max(-lo,hi):.9f} "
                  f"Hoffman={hoff:.9f} margin(lambda_min/d + 1/3)={lo + 1/3:+.3e} -> {'Y-prime (H*)' if hstar else 'X (needs all-levels ratio < 1/4)'}")
    # two-sided controls: H* must FAIL at 7, 11, 19 (Hoffman >= 1/4) and PASS at 23 and 31 (thin margins)
    for p, want in [(7, False), (11, False), (19, False), (23, True), (31, True)]:
        lo, _ = spectrum(p)
        got = lo > -1 / 3 + 1e-9
        assert got == want, f"control failed at p={p}: H* level one {got}, expected {want}"
    print("\ncontrols: H* fails at 7, 11, 19 and holds at 23, 31 — as B1's exact table says")

main()
