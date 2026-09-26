#!/usr/bin/env python3
"""J27D stage 3.
  A. DC-2's bootstrap algebra (sympy, exact): with s = (k-1)*lam^2, e0 = s/(1+s), F(e) = s*e/(1-(k-1-s)*e), e* = (1-s)/(k-1-s):
     F(e) < e on (0, e*); and e0 < e*  <=>  lam < 1/(k-1).  Also iterates F exactly (Fractions) from e0 at lam = 1/(k-1) - 1/1000
     and at lam = 1/(k-1) + 1/1000 (the latter must NOT descend: e0 >= e*).
  B. DC-3: spectra of Gamma_p = Cay(F_p^2, {x^2+y^2=1}) for primes p = 3 mod 4 (one character per norm class; 50-digit mpmath),
     lam_min/d, lam_2/d, lam* = max|lam|/d over nontrivial characters; DC-1's hypothesis on H (|lam_min|/d < 1/(k-1)) and DC-2's
     (lam* < 1/(k-1)) at k = 3, 4, 5, with the smallest margin printed.  Controls: p = 3 has lam_min/d = -1/2 (Hoffman-tight at 3);
     p = 31 has lam_min + d/3 = 1.5617e-4 (CLAUDE.md G54).
Usage: crunch_j27d_dc.py [--plant]   (plant: drop one antipodal pair from every circle -> the controls must fail)"""
import sys
from fractions import Fraction as Fr
import sympy as sp, mpmath as mp
PLANT = "--plant" in sys.argv
ok = True
# A
s, e, k = sp.symbols("s e k", positive=True)
F = s*e/(1-(k-1-s)*e); estar = (1-s)/(k-1-s); e0 = s/(1+s)
d1 = sp.simplify((F - e)*(1-(k-1-s)*e)/e - (s - 1 + (k-1-s)*e))          # F<e  <=>  s-1+(k-1-s)e < 0  <=> e < e*
d2 = sp.simplify((estar - e0)*(1+s)*(k-1-s) - (1 - (k-1)*s))               # e* - e0 has the sign of 1-(k-1)s (both denominators > 0)
print(f"A  identities: (F-e) rewrite residue {d1}; (e*-e0)(1+s)(k-1-s) - (1-(k-1)s) = {d2}")
ok &= (d1 == 0 and d2 == 0)
for kk in (3, 4, 5, 8):
    for sign in (-1, 1):
        lam = Fr(1, kk-1) + sign*Fr(1, 1000); ss = (kk-1)*lam*lam
        e_ = ss/(1+ss); es = (1-ss)/(kk-1-ss); traj = [e_]
        for _ in range(40):
            if e_ >= es: break
            e_ = ss*e_/(1-(kk-1-ss)*e_); traj.append(e_)
        desc = traj[0] < es
        print(f"A  k={kk} lam=1/(k-1){'+' if sign>0 else '-'}1/1000: e0={float(traj[0]):.5f} e*={float(es):.5f} descends={desc} e_40={float(traj[-1]):.3e}")
        ok &= (desc == (sign < 0))
# B
mp.mp.dps = 50
def spectrum(p):
    circ = [(x, y) for x in range(p) for y in range(p) if (x*x + y*y) % p == 1]
    if PLANT: circ = [c for c in circ if c not in ((1, 0), (p-1, 0))]
    d = len(circ); reps = {}
    for a in range(p):
        for b in range(p):
            if (a, b) != (0, 0): reps.setdefault((a*a + b*b) % p, (a, b))
    ev = [mp.fsum(mp.cos(2*mp.pi*((a*x + b*y) % p)/p) for (x, y) in circ) for (a, b) in reps.values()]
    return d, ev
rows = []; minmargin = mp.mpf(1)
for p in [3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83, 103]:
    d, ev = spectrum(p); lmin, l2 = min(ev), max(ev); lst = max(abs(lmin), abs(l2))/d
    cells = []
    for kk in (3, 4, 5):
        t = mp.mpf(1)/(kk-1)
        for v in (abs(lmin)/d, lst):
            if p != 3 and abs(v - t) < minmargin: minmargin = abs(v - t)   # p = 3, k = 3 is an exact equality (the control)
        cells.append(("Y" if abs(lmin)/d < t else "n") + ("Y" if lst < t else "n"))
    rows.append((p, d, lmin/d, l2/d, lst, cells, lmin + mp.mpf(d)/3))
    print(f"B  p={p:3d} d={d:3d} lmin/d={mp.nstr(lmin/d,8):>11} l2/d={mp.nstr(l2/d,8):>10} lam*={mp.nstr(lst,8):>10}  k=3:{cells[0]} k=4:{cells[1]} k=5:{cells[2]}")
print(f"B  smallest |value - 1/(k-1)| over the table, p > 3: {mp.nstr(minmargin, 6)} (50-digit arithmetic; p = 3 at k = 3 is exact equality)")
ok &= minmargin > mp.mpf(10)**-30
c3 = [r for r in rows if r[0] == 3][0]; c31 = [r for r in rows if r[0] == 31][0]
ctl3 = abs(c3[2] + mp.mpf(1)/2) < mp.mpf(10)**-40
ctl31 = abs(c31[6] - mp.mpf("1.5617e-4")) < mp.mpf("5e-8")
print(f"B  control p=3 lmin/d = -1/2: {ctl3};  control p=31 lmin + d/3 = {mp.nstr(c31[6], 6)} (G54: 1.5617e-4): {ctl31}")
ok &= ctl3 and ctl31
print("ALL OK" if ok else "FAILED"); sys.exit(0 if ok else 1)
