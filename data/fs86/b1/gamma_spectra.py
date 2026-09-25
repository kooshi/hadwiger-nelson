#!/usr/bin/env python3
"""FS-86 verifier B1: exact-enough spectra of Gamma_p = UD(F_p, 2) = Cay(F_p^2, {x^2+y^2=1}), p = 3 mod 4.

For each nonzero character (a,b) the eigenvalue is sum_{x^2+y^2=1} cos(2 pi (a x + b y)/p); it depends only on
c = a^2 + b^2 (the circle's rotation group acts transitively on each nonzero conic, p = 3 mod 4 has no isotropic
vectors).  We compute it as an integer combination  sum_k n_k cos(2 pi k / p)  (n_k exact integer counts) and evaluate
with mpmath at 60 digits; the comparison with -(p+1)/3 is reported with its margin.  Rigour: every term's error is
below 10^-55, so any margin above 10^-50 is a certified sign.

Question asked: is lambda_min / (p+1) > -1/3 strictly (Hoffman's ratio bound alpha/n < 1/4, i.e. four colours
refused by the spectrum alone)?  Also reports -2/(p+1) (the primitive-character floor up the tower) and the Hoffman
ratio h = -lambda_min / (d - lambda_min).
Plant: --plant replaces the circle by a coset of it (x^2+y^2 = c0, c0 a non-residue); the degree/sanity checks must
then fail (the eigenvalue at the trivial character is still p+1, but the row sum over characters no longer returns the
count of 0 in S = 0 ... we instead check sum over all characters of eigenvalue == p^2 * [0 in S] = 0 and that the
eigenvalue function reproduces the number of closed walks of length 2 = (p+1) * p^2).
"""
import sys
from mpmath import mp, mpf, cos, pi
mp.dps = 60

def circle(p, c0=1):
    return [(x, y) for x in range(p) for y in range(p) if (x*x + y*y - c0) % p == 0]

def eig_counts(p, S, a, b):
    n = [0]*p
    for (x, y) in S:
        n[(a*x + b*y) % p] += 1
    return n

def value(p, n):
    return sum(n[k] * cos(2*pi*k/p) for k in range(p))

def run(p, plant=False):
    S = circle(p, 1)
    if plant:
        # a deliberately wrong connection set: drop one point (breaks symmetry S=-S and the degree)
        S = S[1:]
    d = len(S)
    # one representative (a,b) per value of a^2+b^2
    reps = {}
    for a in range(p):
        for b in range(p):
            c = (a*a + b*b) % p
            if (a, b) != (0, 0) and c not in reps:
                reps[c] = (a, b)
    assert 0 not in reps, "isotropic vector found: p must be 3 mod 4"
    eigs = {c: value(p, eig_counts(p, S, *reps[c])) for c in reps}
    # sanity 1 (exact identity): trace of A^2 = n * d  <=>  d^2 + sum over nonzero chars lambda^2 = p^2 d
    # each value c != 0 is taken by (p+1) characters (the conic a^2+b^2=c has p+1 points)
    tr2 = mpf(d)**2 + sum((p+1) * eigs[c]**2 for c in eigs)
    ok_tr2 = abs(tr2 - p*p*d) < mpf(10)**-40
    # sanity 2: trace of A = 0 (no loops)  <=>  d + (p+1) sum_c lambda_c = 0
    tr1 = d + sum((p+1)*eigs[c] for c in eigs)
    ok_tr1 = abs(tr1) < mpf(10)**-40
    lmin = min(eigs.values())
    thr = -mpf(d)/3
    return dict(p=p, d=d, lmin=lmin, margin=lmin - thr, ratio=lmin/d, h=-lmin/(d - lmin),
                prim=-mpf(2)/(p+1), ok=(ok_tr1 and ok_tr2), weil=2*mp.sqrt(p))

if __name__ == "__main__":
    plant = "--plant" in sys.argv
    ps = [int(a) for a in sys.argv[1:] if a != "--plant"] or [11, 19, 23, 31, 43, 47, 59, 71, 79, 83, 131]
    for p in ps:
        r = run(p, plant)
        print(f"p={r['p']:4d} d={r['d']:4d} lmin={mp.nstr(r['lmin'], 25):>30} "
              f"lmin+d/3={mp.nstr(r['margin'], 12):>18} ratio={mp.nstr(r['ratio'],12)} "
              f"hoffman={mp.nstr(r['h'],12)} (1/4 threshold) weil={mp.nstr(r['weil'],8)} "
              f"trace-checks={'PASS' if r['ok'] else 'FAIL'}")
