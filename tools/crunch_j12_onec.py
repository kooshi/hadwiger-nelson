#!/usr/bin/env python3
"""J12 (FS-91, crunch 2026-09-25) -- ONE-c: the band torsion characters of R_5 at four colours have unbounded orders.

Derived claims checked (plans/FS91-S1D-one-prime.md, Stage 4):
  C1  (criterion) tau_e, e in N^{-1}Z[i]/Z[i], 5 !| N, is band on U_5 iff the orbit of e under multiplication by
      conj(w) = t*conj(pi)^2 (t = 5^{-1} mod N) stays in Q = [1/4, 3/4]^2 mod Z[i].
  C3  (the family) for every (a, b) with a, b >= 1 satisfying the closing lemma's condition (J12-CL with the parity and X3
      leaves), the word c0^a 0^b closes to a band torsion character; its order N divides 2 * Norm(beta_L), L = a + b,
      beta_L = pi^L - (-i)^L conj(pi)^L = pi^L (1 - omega^L), whose prime factors are those of the homogenised Phi_k(omega),
      k | L (the advisor's pointer, with omega = -i conj(w) the rotating-frame rotation).
What is computed: the COMPLETE box 1 <= a, b <= B (a finite set the derivation fixes; the ban's edge, logged).  For every pair the
exact sufficient condition admits: (i) the rotating-frame orbit is verified directly; (ii) e0 = P + Q and its order N; (iii) an
INDEPENDENT band check in the original frame by C1 (modular arithmetic in Z[i]/N, the full w-orbit to its return); (iv) N | 2 Norm(beta_L);
(v) N's factorisation; (vi) a third code path in S0B-L4's convention: the character tested on the whole group <i, w> mod N
built by breadth-first closure (re-implemented for the one character; no order is scanned).
Controls and plants:
  K3  three colours ([1/3, 2/3]; margins 1/6 and 0): the closing condition admits NO pair (the lens is empty, FS81-T3's side), and the
      original-frame checker at [1/3, 2/3] rejects every four-colour family member (none has order dividing 6).
  P1  multiplier plant: conj(pi)^2 in place of t*conj(pi)^2 (the division by 5 forgotten): the original-frame check must reject some
      member (its reason: the map is no longer the unit conj(w) mod N).
  P2  a shifted parameter e0 + (1/N)*(1+0i) on each member: the original-frame check must reject at least one (non-vacuity).
Exit 0 iff all faithful checks pass and every control/plant behaves as named.
"""
from fractions import Fraction as Fr
from math import gcd, isqrt
import sys, time

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from crunch_j12_onea import G, I, frac1
from crunch_j12_oneb import OMEGA, PI, P, compose, orbit

try:
    from sympy import factorint
except Exception:  # pragma: no cover
    factorint = None

C0 = G(Fr(-1, 6), Fr(-1, 6))       # the X3 centre through C = (1+i)/3, rotating frame
PAR = G(0)


def lcm(a, b): return a * b // gcd(a, b)


def order_of(e):  # least N with N e in Z[i]
    return lcm(e.a.denominator, e.b.denominator)


def family(B, lo=Fr(1, 4)):
    """complete box 1<=a,b<=B of words c0^a 0^b; sufficient condition of J12-CL with margins r(parity)=1/2-lo... in Q0."""
    half = Fr(1, 2) - lo           # half-side of Q0 = [-half, half]^2
    r_par = half                   # parity leaf: centre 0, margin = half
    r_x3 = half - Fr(1, 6)         # X3 leaf: centre (+-1+-i)/6
    Wc, W0 = [(C0.a, C0.b)], [(Fr(0), Fr(0))]
    out = []
    for a in range(1, B + 1):
        for b in range(1, B + 1):
            word = Wc * a + W0 * b
            A, t = compose(word)
            Q = t / (G(1) - A)
            RaQ = C0 + (OMEGA ** a) * (Q - C0)
            if r_x3 < 0:
                continue
            if (Q - C0).norm() <= r_x3 * r_x3 and (RaQ - PAR).norm() <= r_par * r_par:
                pts, back = orbit(word, Q)
                direct = back == Q and all(abs(q.a) <= half and abs(q.b) <= half for q in pts)
                out.append((a, b, Q, direct))
    return out


def band_check_original(e0, N, lo=Fr(1, 4), hi=Fr(3, 4), plant_no_div=False):
    """C1: orbit of e0 (as integer vector x = N e0 mod N) under x -> t*conj(pi)^2*x mod N; every point in [lo,hi]^2 mod 1."""
    t = pow(5, -1, N) if not plant_no_div else 1
    m = (PI.conj() * PI.conj())
    ma, mb = (int(m.a) * t) % N, (int(m.b) * t) % N
    x0 = ((int(e0.a * N)) % N, (int(e0.b * N)) % N)
    x, period = x0, 0
    ok = True
    while True:
        xa, xb = Fr(x[0], N), Fr(x[1], N)
        if not (lo <= xa <= hi and lo <= xb <= hi):
            ok = False
        x = ((ma * x[0] - mb * x[1]) % N, (ma * x[1] + mb * x[0]) % N)
        period += 1
        if x == x0 or period > 4 * N * N:
            break
    return ok, period


def s0b_style_check(e0, N):
    """Third code path, S0B-L4's convention (data/fs89/s0b/torsion_points.py, re-implemented for ONE fixed character):
    tau(x + yi) = (A x + B y)/N with A = N Re e0, B = N Im e0; test 4*((A x + B y) mod N) in [N, 3N] on the WHOLE group
    <i, w> mod N, built by breadth-first closure (not by orbit iteration)."""
    inv5 = pow(5, -1, N)
    w = ((3 * inv5) % N, (4 * inv5) % N)
    def mul(p, q):
        return ((p[0]*q[0] - p[1]*q[1]) % N, (p[0]*q[1] + p[1]*q[0]) % N)
    S, frontier = {(1 % N, 0)}, [(1 % N, 0)]
    while frontier:
        new = []
        for s_ in frontier:
            for g in ((0, 1 % N), w):
                t = mul(s_, g)
                if t not in S:
                    S.add(t); new.append(t)
        frontier = new
    A, Bc = int(e0.a * N) % N, int(e0.b * N) % N
    ok = all(N <= 4 * ((A * x + Bc * y) % N) <= 3 * N for x, y in S)
    return ok, len(S)


def beta_norm(L):
    pib = PI.conj()
    b = PI ** L - ((G(0, -1)) ** L) * (pib ** L)
    assert b.is_gauss_int()
    return int(b.norm())


def main():
    B = int(sys.argv[2]) if len(sys.argv) > 2 else 10
    t0 = time.time()
    lines, ok = [], True
    fam = family(B)
    lines.append(f"box 1<=a,b<={B}: admitted by the closing condition: {len(fam)}; direct-verified: {sum(1 for x in fam if x[3])}")
    ok &= len(fam) > 0 and all(x[3] for x in fam)
    orders = []
    for (a, b, Q, d) in fam:
        e0 = P + Q
        N = order_of(e0)
        L = a + b
        bn = beta_norm(L)
        c1, per = band_check_original(e0, N)
        div = (2 * bn) % N == 0
        five = N % 5 != 0
        fac = factorint(N) if (factorint and N < 10**30) else "?"
        s0b, usize = s0b_style_check(e0, N)
        ok &= c1 and div and five and s0b
        orders.append(N)
        lines.append(f"  a={a:2d} b={b:2d} L={L:2d} N={N} (5!|N {five}) N|2Nm(beta_L) {div} C1-band {c1} period {per} S0B-style {s0b} |U5 mod N|={usize} "
                     f"sqrt(L)<=N {isqrt(L) <= N} factors {fac}")
    lines.append(f"distinct orders: {len(set(orders))}; max order {max(orders)}")
    # K3: three colours
    fam3 = family(B, lo=Fr(1, 3))
    rej3 = all(not band_check_original(P + Q, order_of(P + Q), lo=Fr(1, 3), hi=Fr(2, 3))[0] for (_, _, Q, _) in fam)
    k3 = (len(fam3) == 0) and rej3
    lines.append(f"K3 three colours: closing condition admits {len(fam3)} (expect 0); original-frame checker at [1/3,2/3] rejects "
                 f"every four-colour member: {rej3} -> {'AS NAMED' if k3 else 'NOT AS NAMED'}")
    ok &= k3
    # P1: multiplier plant
    p1 = any(not band_check_original(P + Q, order_of(P + Q), plant_no_div=True)[0] for (_, _, Q, _) in fam)
    lines.append(f"P1 multiplier plant (no division by 5): some member rejected: {p1} -> {'FIRES' if p1 else 'DID NOT FIRE'}")
    ok &= p1
    # P2: shifted parameter
    rej, rej_s = 0, 0
    for (_, _, Q, _) in fam:
        e0 = P + Q
        N = order_of(e0)
        e1 = e0 + G(Fr(1, N))
        if not band_check_original(e1, order_of(e1))[0]:
            rej += 1
        if not s0b_style_check(e1, order_of(e1))[0]:
            rej_s += 1
    p2 = rej > 0 and rej_s > 0
    lines.append(f"P2 shifted parameter: rejected by C1 {rej}, by the S0B-style path {rej_s}, of {len(fam)} -> "
                 f"{'FIRES (both paths)' if p2 else 'DID NOT FIRE'}")
    ok &= p2
    lines.append(f"time {time.time() - t0:.1f}s")
    lines.append("ALL PASS" if ok else "SOME CHECK FAILED")
    out = "\n".join(lines)
    print(out)
    if len(sys.argv) > 1:
        open(sys.argv[1], "w").write(out + "\n")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
