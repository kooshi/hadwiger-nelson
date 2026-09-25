#!/usr/bin/env python3
"""J21 (crunch 2026-09-25): C14.2 (c) at the dyadic place of Q(sqrt 167), a sanity check of a derived bound (not a search).

The dyadic place of F = Q(sqrt 167) has F_v = Q_2(sqrt 167) = Q_2(i) (-167 = 1 mod 8), O = Z_2[i], uniformizer pi = 1 + i,
residue field F_2 (q = 2), and i in F_v, so the place is split in F(i)/F; in the coordinates (x + iy, x - iy) its local graph is
the hyperbola graph H(F_v) = Cay(F_v^2, {(t, 1/t) : t in F_v^x}).

C14.2 (c) (plans/FS86-C-Coxeter.md, round 2 step 5) takes the window Phi_n = pi^{-n} O^2 and the connection measure nu_n, the average over
k in [-n, n] of Haar measure on {(pi^k e, pi^{-k} e^{-1}) : e in O^x}, and derives (2n + 1) * min_{xi != 0} nu_n^(xi) >= -1 - 2/(q - 1),
which is -3 at q = 2, so the Hoffman ratio of the window graph is <= 3/(2n + 4).

This tool multiplies Phi_n by pi^n (a group isomorphism onto O^2) and reads nu_n on the finite quotient O^2 / 2^j O^2 = (Z/2^j)^4
(the pushforward of Haar on O^x is uniform on (O/2^j)^x), then every character of that quotient by one 4-D FFT. It checks, for n = 1..3:
  (2n + 1) * lambda_min >= -3 - 1e-9 and Hoffman ratio <= 3/(2n + 4) + 1e-9, with lambda_min real to 1e-9.
Characters of Phi_n that are non-trivial on pi^{2j - n} O^2 are not seen (a finite-resolution check of a derived bound).

Plant (--plant): drop the averaging over levels (use k = 0 only, weight 1); then lambda_min = -1 (one coordinate of valuation -1:
the integral of psi over O^x is -1/(q - 1) = -1), so (2n + 1) * lambda_min = -(2n + 1) < -3 for n >= 2 and the check must fail.
Exit 0: bound holds at every n checked; 1: it fails; 2: an internal consistency error (non-real spectrum, mass not 1).
"""
import argparse
import sys

import numpy as np


def mul(x, y, N):
    a, b = x
    c, d = y
    return ((a * c - b * d) % N, (a * d + b * c) % N)


def inv(x, N):
    a, b = x
    nrm = (a * a + b * b) % N
    assert nrm % 2 == 1
    ni = pow(nrm, -1, N)
    return ((a * ni) % N, ((-b) * ni) % N)


def pipow(k, N):
    r = (1, 0)
    for _ in range(k):
        r = mul(r, (1, 1), N)
    return r


def spectrum(n, j, plant=False):
    N = 2 ** j
    units = [(a, b) for a in range(N) for b in range(N) if (a + b) % 2 == 1]
    ks = [0] if plant else list(range(-n, n + 1))
    nu = np.zeros((N, N, N, N))
    w = 1.0 / (len(ks) * len(units))
    for k in ks:
        p1 = pipow(k + n, N)
        p2 = pipow(n - k, N)
        for e in units:
            u = mul(p1, e, N)
            v = mul(p2, inv(e, N), N)
            nu[u[0], u[1], v[0], v[1]] += w
    mass = nu.sum()
    F = np.fft.fftn(nu)
    if abs(mass - 1) > 1e-9 or np.max(np.abs(F.imag)) > 1e-9:
        return None
    lam = F.real
    lam[0, 0, 0, 0] = np.inf
    return lam.min()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--plant', action='store_true')
    ap.add_argument('--j', type=int, default=5)
    a = ap.parse_args()
    ok = True
    for n in (1, 2, 3):
        lmin = spectrum(n, a.j, a.plant)
        if lmin is None:
            print('ERROR: mass or reality check failed at n=%d' % n)
            sys.exit(2)
        scaled = (2 * n + 1) * lmin
        hoff = -lmin / (1 - lmin)
        good = scaled >= -3 - 1e-9 and hoff <= 3 / (2 * n + 4) + 1e-9
        ok &= good
        print('n=%d j=%d: lambda_min=%+.6f  (2n+1)*lambda_min=%+.6f (floor -3)  Hoffman=%.6f (bound 3/(2n+4)=%.6f)  %s'
              % (n, a.j, lmin, scaled, hoff, 3 / (2 * n + 4), 'OK' if good else 'FAIL'))
    print('RESULT:', 'OK' if ok else 'FAIL')
    sys.exit(0 if ok else 1)


if __name__ == '__main__':
    main()
