#!/usr/bin/env python3
"""FS-89 Stage 0B: exact checks of the heteroclinic characters of Theta_4(U5) (band [1/4, 3/4]).

Two independent descriptions of one character, checked against each other:
 (A) ADELIC.  A character of R5 = Z[i][1/5] is (e; beta1, beta2), e in C, beta_j in Z_5 (the completions of Z[i] at
     pi = 2+i, where i -> iota1 = sqrt(-1) = 3 mod 5, and at pibar, where i -> iota2 = -iota1):
         theta(x) = Re(conj(e) x) - { (beta2 * x_1 + beta1 * x_2) / 2 }_5     (mod 1),
     x_j the image of x in the j-th completion, {.}_5 the 5-adic fractional part.  Torsion characters are (q; q, q),
     q in Q(i) with denominator prime to 5 (then theta(x) = prime-to-5 part of Re(conj(q) x)).
 (B) ORBIT.  theta restricted to w^m Z[i] is y -> <e_m, w^{-m} y>, and the orbit (e_m) lies in Q = [1/4,3/4]^2 with
     e_{m+1} - wbar e_m in pi^{-1} Z[i].

The heteroclinic character: forward half of an order-3 character chi = (q; q, q), q = (1+i)/3, backward half of the
parity character theta_2 = (P; P, P), P = (1+i)/2:  theta* = (e; beta1 = q, beta2 = P), with e in the lens
|e - q| <= 1/12, |e - P| <= 1/4.  Claims checked here, exactly:
  1. theta*(i^k w^m) in [1/4, 3/4] for |m| <= M, k = 0..3  (formula A);
  2. theta*(i^k w^m) = <e_m, i^k> with e_m = C_m + wbar^m (e - q) (m >= 0), P + wbar^m (e - P) (m <= 0), C_m the lift
     of i^m q into Q  (formula A against the orbit B), and the orbit is an orbit (Q-membership, digit lattice);
  3. theta* = chi + lambda_{e-q} on i^k w^m, m >= 0, and = theta_2 + lambda_{e-P} on m <= 0 (formula A for all three);
  4. controls that must fail: e outside the parity disc; e outside the order-3 disc; beta2 = q (then theta* would be the
     T+A character chi + lambda, and at the chosen e outside chi's backward disc the band must fail somewhere).
"""
from __future__ import annotations

import sys
from fractions import Fraction as Fr

N = 60                      # 5-adic precision (digits); every x used has |valuation| <= M << N
MOD = 5 ** N


def sqrt_minus1(r0: int) -> int:
    """Hensel lift of r0^2 = -1 mod 5 to mod 5^N."""
    r = r0
    for _ in range(8):
        # Newton: r <- r - (r^2+1)/(2r)
        r = (r - (r * r + 1) * pow(2 * r, -1, MOD)) % MOD
    assert (r * r + 1) % MOD == 0 and r % 5 == r0
    return r


IOTA1 = sqrt_minus1(3)      # the pi-adic completion: pi = 2 + i -> 2 + iota1 = 0 mod 5
IOTA2 = (-IOTA1) % MOD      # the pibar-adic completion
assert (2 + IOTA1) % 5 == 0 and (2 - IOTA2) % 5 == 0


def v5(n: int) -> int:
    if n == 0:
        return 10 ** 9
    k = 0
    while n % 5 == 0:
        n //= 5
        k += 1
    return k


def rat_to_5adic(r: Fr) -> tuple[int, int]:
    """r in Q -> (X, k) with r = X / 5^k, X in Z_5 mod 5^N (k >= 0 chosen minimal with 5^k r 5-integral)."""
    if r == 0:
        return 0, 0
    k = max(0, v5(r.denominator) - v5(r.numerator))
    s = r * 5 ** k
    X = (s.numerator * pow(s.denominator, -1, MOD)) % MOD
    return X, k


def embed(x: tuple[Fr, Fr], iota: int) -> tuple[int, int]:
    """a + b i -> a + b iota as (X, k): value X / 5^k."""
    a, b = x
    Xa, ka = rat_to_5adic(a)
    Xb, kb = rat_to_5adic(b)
    k = max(ka, kb)
    X = (Xa * 5 ** (k - ka) + Xb * iota * 5 ** (k - kb)) % MOD
    return X, k


def frac5(X: int, k: int) -> Fr:
    return Fr(X % 5 ** k, 5 ** k) if k > 0 else Fr(0)


def cmul(p, q):
    return (p[0] * q[0] - p[1] * q[1], p[0] * q[1] + p[1] * q[0])


def cpow(p, m):
    if m < 0:
        n2 = p[0] ** 2 + p[1] ** 2
        p = (p[0] / n2, -p[1] / n2)
        m = -m
    out = (Fr(1), Fr(0))
    for _ in range(m):
        out = cmul(out, p)
    return out


W = (Fr(3, 5), Fr(4, 5))
WB = (Fr(3, 5), Fr(-4, 5))
I = (Fr(0), Fr(1))


class Char:
    """(e; beta1, beta2): e a Gaussian rational (exact archimedean part), beta_j Gaussian rationals prime to 5 in the
    denominator, embedded into the j-th completion."""

    def __init__(self, e, beta1, beta2):
        self.e = e
        self.b1 = embed(beta1, IOTA1)
        self.b2 = embed(beta2, IOTA2)
        assert self.b1[1] == 0 and self.b2[1] == 0, "beta must be 5-integral"
        self.b1, self.b2 = self.b1[0], self.b2[0]

    def __call__(self, x) -> Fr:
        arch = self.e[0] * x[0] + self.e[1] * x[1]          # Re(conj(e) x)
        X1, k1 = embed(x, IOTA1)
        X2, k2 = embed(x, IOTA2)
        k = max(k1, k2)
        Y = (self.b2 * X1 * 5 ** (k - k1) + self.b1 * X2 * 5 ** (k - k2)) % MOD
        Y = (Y * pow(2, -1, MOD)) % MOD
        return (arch - frac5(Y, k)) % 1


def in_band(t: Fr) -> bool:
    return Fr(1, 4) <= t <= Fr(3, 4)


def lift_Q(z):
    """The representative of z mod Z[i] in [0,1)^2 (Q = [1/4,3/4]^2 lies inside it)."""
    return (z[0] - (z[0].numerator // z[0].denominator), z[1] - (z[1].numerator // z[1].denominator))


def in_pi_inv_lattice(z) -> bool:
    """z in pi^{-1} Z[i] = (pibar/5) Z[i]  <=>  pi * z in Z[i]."""
    pz = cmul((Fr(2), Fr(1)), z)
    return pz[0].denominator == 1 and pz[1].denominator == 1


def check(e, M=25, verbose=True):
    q = (Fr(1, 3), Fr(1, 3))
    P = (Fr(1, 2), Fr(1, 2))
    th = Char(e, q, P)
    chi = Char(q, q, q)
    th2 = Char(P, P, P)
    lam = lambda d: (lambda x: (d[0] * x[0] + d[1] * x[1]) % 1)
    lq, lP = lam((e[0] - q[0], e[1] - q[1])), lam((e[0] - P[0], e[1] - P[1]))
    band_ok, agree_fwd, agree_bwd, orbit_ok, formula_vs_orbit = True, True, True, True, True
    worst = None
    orbit = {}
    for m in range(-M, M + 1):
        # orbit description
        if m >= 0:
            em = (cmul(cpow(I, m), q)[0] + cmul(cpow(WB, m), (e[0] - q[0], e[1] - q[1]))[0],
                  cmul(cpow(I, m), q)[1] + cmul(cpow(WB, m), (e[0] - q[0], e[1] - q[1]))[1])
        else:
            d = cmul(cpow(WB, m), (e[0] - P[0], e[1] - P[1]))
            em = (P[0] + d[0], P[1] + d[1])
        # lift into [0,1)^2 via the Z[i]-part of C_m only (the displacement is small); check membership in Q
        em = lift_Q(em)
        orbit[m] = em
        orbit_ok &= Fr(1, 4) <= em[0] <= Fr(3, 4) and Fr(1, 4) <= em[1] <= Fr(3, 4)
        for k in range(4):
            x = cmul(cpow(I, k), cpow(W, m))
            t = th(x)
            band_ok &= in_band(t)
            if worst is None or min(t - Fr(1, 4), Fr(3, 4) - t) < worst[0]:
                worst = (min(t - Fr(1, 4), Fr(3, 4) - t), m, k)
            if m >= 0:
                agree_fwd &= t == (chi(x) + lq(x)) % 1
            if m <= 0:
                agree_bwd &= t == (th2(x) + lP(x)) % 1
            ik = cpow(I, k)
            formula_vs_orbit &= t == (orbit[m][0] * ik[0] + orbit[m][1] * ik[1]) % 1
    for m in range(-M, M):
        dz = (orbit[m + 1][0] - cmul(WB, orbit[m])[0], orbit[m + 1][1] - cmul(WB, orbit[m])[1])
        orbit_ok &= in_pi_inv_lattice(dz)
    if verbose:
        print(f"e = ({e[0]}, {e[1]}):  band on |m|<={M}: {band_ok}  (least margin {worst[0]} at m={worst[1]}, k={worst[2]});"
              f"  = chi+lambda forward: {agree_fwd};  = theta2+lambda backward: {agree_bwd};"
              f"  orbit valid: {orbit_ok};  formula A = orbit B: {formula_vs_orbit}")
    return band_ok, agree_fwd, agree_bwd, orbit_ok, formula_vs_orbit


def main() -> int:
    ok = True
    print("theta* = (e; beta1 = (1+i)/3 [pi-adic], beta2 = (1+i)/2 [pibar-adic])")
    for e in [(Fr(23, 60), Fr(23, 60)), (Fr(1, 3), Fr(1, 3)), (Fr(2, 5), Fr(7, 20)), (Fr(3, 8), Fr(1, 3))]:
        r = check(e)
        ok &= all(r)
    print("controls (must NOT all pass):")
    # outside the parity disc (|e-P| > 1/4) but inside the order-3 disc: backward band must fail
    r1 = check((Fr(13, 48), Fr(13, 48)))          # |e - q| = sqrt2/16 < 1/12? (1/3-13/48 = 1/16): 0.088 > 1/12 -> both
    r2 = check((Fr(3, 10), Fr(3, 10)))            # |e-q|=sqrt2/30=0.047 ok ; |e-P| = sqrt2/5 = 0.283 > 1/4 -> bwd fails
    r3 = check((Fr(9, 20), Fr(9, 20)))            # |e-P| small ; |e-q| = 7sqrt2/60 = 0.165 > 1/12 -> fwd fails
    fired = (not r1[0]) and (not r2[0]) and (not r3[0])
    print("controls fired:", fired)
    ok &= fired
    print("VERDICT:", "heteroclinic characters verified in Theta_4(U5)" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
