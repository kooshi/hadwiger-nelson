#!/usr/bin/env python3
"""J27V: independent spot check of three rows of J27D's DC-3 table (plans/FS67-J27D-derivation.md, Stage 3).

Gamma_p = Cay(F_p^2, S), S = {x^2 + y^2 = 1}, d = |S| = p + 1 for p = 3 mod 4. Every eigenvalue
lambda(a, b) = sum_{(x,y) in S} cos(2 pi (a x + b y)/p) is computed at 60 digits over ALL p^2 characters (no norm-class shortcut).
Reported: lambda_min/d, lambda_2/d (largest non-trivial), lambda* = max |nontrivial|/d, and the flags
DC-1 (|lambda_min|/d < 1/(k-1)) and DC-2 (lambda* < 1/(k-1)) at k = 3, 4, 5, compared with J27D's printed row.
--plant drops the antipodal pair (1,0), (-1,0) from S; the comparison must fail. (A first plant, the circle x^2 + y^2 = 2, could
not fire: every circle is a similarity image of the unit circle, since the norm F_{p^2} -> F_p is onto, so the graphs are isomorphic.)
"""
import sys
import mpmath as mp
mp.mp.dps = 60
J27D = {  # p: (lambda_min/d, lambda_2/d, lambda*, flags k=3,4,5 as 'YY'/'nn')
    7: ("-0.56174", "0.33650", "0.56174", ("nn", "nn", "nn")),
    11: ("-0.39965", "0.47641", "0.47641", ("YY", "nn", "nn")),
    31: ("-0.333328", "0.29287", "0.333328", ("YY", "YY", "nn")),
}
def row(p, plant=False):
    S = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]
    if plant: S = [s for s in S if s not in ((1, 0), (p - 1, 0))]
    d = len(S)
    eig = []
    for a in range(p):
        for b in range(p):
            if a == 0 and b == 0: continue
            eig.append(mp.fsum(mp.cos(2 * mp.pi * ((a * x + b * y) % p) / p) for x, y in S))
    lmin, l2 = min(eig), max(eig)
    lst = max(abs(lmin), abs(l2))
    flags = []
    for k in (3, 4, 5):
        t = mp.mpf(1) / (k - 1)
        flags.append(("Y" if abs(lmin) / d < t else "n") + ("Y" if lst / d < t else "n"))
    return d, lmin / d, l2 / d, lst / d, tuple(flags)

def main(plant):
    ok = True
    for p, (m, s2, st, fl) in J27D.items():
        d, lm, l2, ls, flags = row(p, plant)
        close = all(abs(v - mp.mpf(ref)) < mp.mpf(10) ** (-len(ref.split('.')[1])) for v, ref in ((lm, m), (l2, s2), (ls, st)))
        good = close and flags == fl
        ok &= good
        print(f"p={p} d={d} lmin/d={mp.nstr(lm, 12)} l2/d={mp.nstr(l2, 12)} l*={mp.nstr(ls, 12)} flags={flags} "
              f"| J27D {m} {s2} {st} {fl} : {'MATCH' if good else 'MISMATCH'}")
        if p == 31:
            print(f"   31 at k=4: 1/3 - l* = {mp.nstr(mp.mpf(1)/3 - ls, 6)} ; lambda_min + d/3 = {mp.nstr(lm * d + mp.mpf(d)/3, 6)}")
    return ok

if __name__ == "__main__":
    ok = main("--plant" in sys.argv)
    print("ALL MATCH" if ok else "MISMATCH FOUND")
    sys.exit(0 if ok else 1)
