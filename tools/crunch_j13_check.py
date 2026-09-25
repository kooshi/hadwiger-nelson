#!/usr/bin/env python3
"""Crunch job J13 (blind verifier of J12, one prime): exact checks of the phase-1 derivations.

Record: plans/FS91-S1V-one-prime.md.  Output: data/fs91/j13/check.txt (written even on a null).

Notation (the record's).  l = 1 (mod 4) a prime, pi = a+bi with a^2+b^2 = l, w = pi/conj(pi), R_l = Z[i][1/l].
zeta in {+-1, +-i} with w = zeta (mod 3 R_l); betabar = zeta * conj(w).  The u-model: a band character of
R_l at band [1/4, 3/4] is a sequence u_t in Q0 = [-1/4, 1/4]^2 with u_{t+1} - betabar*u_t in pi^{-1} Z[i];
the layer values are e_t = P + conj(zeta)^t u_t, P = (1+i)/2.  Digits: a = 0 (parity leaf), b = (1-betabar) v0
with v0 = -(1+i)/6 (the order-3 leaf).

Parts:
  A  X1 at several primes: the glued heteroclinic (order-3 forward, parity backward) takes band values on
     i^k w^m, |m| <= M, computed from the characters themselves (not from the orbit model); gluing on Z[i].
  B  the u-model's premises at several primes: zeta = w mod 3, both digits lie in pi^{-1}Z[i].
  C  X3: the family c_p (word b a^p).  For every p <= PMAX (a complete enumeration of the range, fixed by the
     derivation): membership |c_p|^2 <= 1/16 exactly; for members, the periodic u-orbit (step rule, Q0, closure),
     and an INDEPENDENT check: the torsion character with layer-0 parameter e0 = P + c_p, of order N, takes
     band values on all of U_l mod N.
  D  X2: the two numeric inequalities of the branching lemma (max gap of {n alpha}, n <= N0, against the
     landing-arc width on a partition of [rho1, 1/4]), at 60 digits; and exact sample checks of the branching.
Plants (each must fire for its own reason): see run_plants().
"""
from fractions import Fraction as F
import sys, random

# ---------- Gaussian rationals ----------
class G:
    __slots__ = ("re", "im")
    def __init__(self, re, im=0):
        self.re = F(re); self.im = F(im)
    def __add__(s, o): o = g(o); return G(s.re + o.re, s.im + o.im)
    __radd__ = __add__
    def __sub__(s, o): o = g(o); return G(s.re - o.re, s.im - o.im)
    def __rsub__(s, o): return g(o) - s
    def __neg__(s): return G(-s.re, -s.im)
    def __mul__(s, o): o = g(o); return G(s.re*o.re - s.im*o.im, s.re*o.im + s.im*o.re)
    __rmul__ = __mul__
    def conj(s): return G(s.re, -s.im)
    def norm(s): return s.re*s.re + s.im*s.im
    def inv(s): n = s.norm(); return G(s.re/n, -s.im/n)
    def __truediv__(s, o): return s * g(o).inv()
    def __eq__(s, o): o = g(o); return s.re == o.re and s.im == o.im
    def __hash__(s): return hash((s.re, s.im))
    def __pow__(s, n):
        r = G(1); b = s
        if n < 0: b = b.inv(); n = -n
        while n:
            if n & 1: r = r * b
            b = b * b; n >>= 1
        return r
    def is_gauss_int(s): return s.re.denominator == 1 and s.im.denominator == 1
    def __repr__(s): return f"({s.re}{'+' if s.im >= 0 else '-'}{abs(s.im)}i)"

def g(x): return x if isinstance(x, G) else G(x)

I = G(0, 1)
P = G(F(1, 2), F(1, 2))
V0 = G(F(-1, 6), F(-1, 6))
Q_ORD3 = G(F(1, 3), F(1, 3))          # layer-0 parameter of the order-3 character chi
QUARTER = F(1, 4)

def fracpart(x):  # x mod 1 in [0,1)
    return x - (x.numerator // x.denominator)

def re_pair(e, x):  # <e, x> = Re(conj(e) x)
    return (e.conj() * x).re

def in_band(v):
    t = fracpart(v)
    return QUARTER <= t <= 3 * QUARTER

def pi_of(l):
    for a in range(1, int(l ** 0.5) + 2):
        b2 = l - a * a
        if b2 < 0: break
        b = int(round(b2 ** 0.5))
        if b * b == b2 and b > 0:
            return G(a, b)
    raise ValueError(l)

def in_pi_inv_lattice(x, pi):
    return (x * pi).is_gauss_int()

def unit_mod3(w, l):
    """w in R_l, return the element of {1,i,-1,-i} congruent to w mod 3 R_l, or None."""
    # w = pi/pibar = pi^2 / l ; mod 3: l invertible mod 3
    pi2l = w * l  # = pi^2, a Gaussian integer
    linv = pow(l % 3, -1, 3)
    a = (int(pi2l.re) * linv) % 3; b = (int(pi2l.im) * linv) % 3
    for z in (G(1), I, G(-1), -I):
        if (int(z.re) - a) % 3 == 0 and (int(z.im) - b) % 3 == 0:
            return z
    return None

def reduce_mod(x, N, l):
    """x in R_l (denominators powers of l), N coprime to l: its class in Z[i]/N as an integer pair."""
    d = 1
    while not (x * d).is_gauss_int():
        d *= l
        if d > l ** 4000: raise ValueError("not in R_l")
    xi = x * d
    dinv = pow(d % N, -1, N) if N > 1 else 0
    return (int(xi.re) * dinv % N, int(xi.im) * dinv % N)

def torsion_value(e0, xpair, N):
    """character with layer-0 parameter e0 (order dividing N) at the class xpair of Z[i]/N."""
    a, b = xpair
    return fracpart(e0.re * a + e0.im * b)

# ---------- per-prime data ----------
def prime_data(l):
    pi = pi_of(l); w = pi / pi.conj()
    zeta = unit_mod3(w, l)
    betabar = zeta * w.conj()
    beta = betabar.conj()
    o = (1 - beta) * V0
    return dict(l=l, pi=pi, w=w, zeta=zeta, betabar=betabar, beta=beta, o=o)

def chi(x, l):      # the order-3 character with layer-0 parameter (1+i)/3
    return torsion_value(Q_ORD3, reduce_mod(x, 3, l), 3)

def theta2(x, l):   # the parity character
    return torsion_value(P, reduce_mod(x, 2, l), 2)

# ---------- Part A: X1 ----------
def part_A(l, e, M=40, backward_arch=None, out=None):
    """Glued character: chi + lambda_{e-q} forward (m >= 0), theta2 + lambda_{e-P} backward (m <= 0).
    Returns (gluing_ok, first_failure or None)."""
    d = prime_data(l); w = d["w"]
    df = e - Q_ORD3
    db = (e - P) if backward_arch is None else backward_arch
    glue_ok = all(fracpart(chi(z, l) + re_pair(df, z) - theta2(z, l) - re_pair(db, z)) == 0 for z in (G(1), I))
    fail = None
    for m in range(-M, M + 1):
        wm = w ** m
        for k in range(4):
            u = (I ** k) * wm
            if m >= 0:
                v = chi(u, l) + re_pair(df, u)
                if not in_band(v): fail = fail or ("forward", m, k, v)
            if m <= 0:
                v = theta2(u, l) + re_pair(db, u)
                if not in_band(v): fail = fail or ("backward", m, k, v)
    return glue_ok, fail

# ---------- Part B: premises of the u-model ----------
def part_B(l):
    d = prime_data(l); pi = d["pi"]; w = d["w"]; bb = d["betabar"]
    res = {}
    res["zeta"] = d["zeta"]
    res["digit_b_in_lattice"] = in_pi_inv_lattice((1 - bb) * V0, pi)
    res["parity_step_in_lattice"] = in_pi_inv_lattice((1 - w.conj()) * P, pi)
    # the order-3 leaf in the u-frame is the constant v0: e_t(chi) - P == conj(zeta)^t v0 mod Z[i]
    ok = True
    for t in range(0, 12):
        wt = w ** t
        e_t = G(chi(wt, l), chi(I * wt, l))
        diff = e_t - P - (d["zeta"].conj() ** t) * V0
        ok = ok and diff.is_gauss_int()
    res["order3_leaf_is_v0_in_u_frame"] = ok
    # the parity leaf: e_t(theta2) == P for all t
    res["parity_leaf_is_0_in_u_frame"] = all(
        (G(theta2(w ** t, l), theta2(I * w ** t, l)) - P).is_gauss_int() for t in range(12))
    return res

# ---------- Part C: X3, the family b a^p ----------
def in_Q0(u):
    return abs(u.re) <= QUARTER and abs(u.im) <= QUARTER

def c_of(p, d):
    bb = d["betabar"]
    return V0 * (bb ** p) * (1 - bb) / (1 - bb ** (p + 1))

def lcm(a, b):
    from math import gcd
    return a // gcd(a, b) * b

def check_member(p, d, lattice_pi=None, e0_override=None):
    """Exact checks for the word b a^p at prime d['l'].  Returns a dict."""
    l = d["l"]; bb = d["betabar"]; pi = d["pi"] if lattice_pi is None else lattice_pi
    c = c_of(p, d)
    r = dict(p=p, member=(c.norm() <= F(1, 16)))
    # the periodic u-orbit
    u = c; orbit_ok = in_Q0(u); steps_ok = True
    digits = [(1 - bb) * V0] + [G(0)] * p
    for h in digits:
        un = bb * u + h
        steps_ok = steps_ok and in_pi_inv_lattice(un - bb * u, pi)
        orbit_ok = orbit_ok and in_Q0(un)
        u = un
    r["orbit_in_Q0"] = orbit_ok; r["steps_ok"] = steps_ok; r["closes"] = (u == c)
    # the torsion character, checked independently on U_l mod N
    e0 = (P + c) if e0_override is None else e0_override
    N = lcm(e0.re.denominator, e0.im.denominator)
    r["N"] = N; r["l_divides_N"] = (N % l == 0)
    if N % l == 0:
        return r
    wN = reduce_mod(d["w"], N, l)
    def mul(x, y):
        return ((x[0] * y[0] - x[1] * y[1]) % N, (x[0] * y[1] + x[1] * y[0]) % N)
    x = (1 % N, 0); iN = (0, 1 % N)
    start = (torsion_value(e0, x, N), torsion_value(e0, mul(iN, x), N))
    period = None; band = True; margin = None; classes = set(); first_bad = None
    for m in range(0, 20 * (p + 1) + 200):
        vals = (torsion_value(e0, x, N), torsion_value(e0, mul(iN, x), N))
        if m > 0 and vals == start:
            period = m; break
        y = x
        for k in range(4):
            classes.add(y); y = mul(iN, y)
        for v in vals:
            if not in_band(v):
                band = False; first_bad = first_bad or (m, v)
            dist = min(v - QUARTER, 3 * QUARTER - v)
            margin = dist if margin is None else min(margin, dist)
        x = mul(wN, x)
    r.update(tau_period=period, band_on_U_mod_N=band and period is not None, margin=margin,
             U_mod_N_seen=len(classes), first_bad=first_bad)
    return r

# ---------- Part D: X2, the branching lemma at l = 5 ----------
def part_D_numeric(rho1, N0, pieces=400, dps=60):
    import mpmath as mp
    mp.mp.dps = dps
    d = prime_data(5); bb = d["betabar"]
    psi = mp.atan2(mp.mpf(bb.im.numerator) / bb.im.denominator, mp.mpf(bb.re.numerator) / bb.re.denominator)
    alpha = psi / (2 * mp.pi)
    pts = sorted([mp.frac(n * alpha) for n in range(1, N0 + 1)])
    gaps = [pts[j + 1] - pts[j] for j in range(len(pts) - 1)] + [1 - pts[-1] + pts[0]]
    gmax = max(gaps) * 2 * mp.pi                       # radians
    o_abs = mp.sqrt(mp.mpf(d["o"].norm().numerator) / d["o"].norm().denominator)
    def dhi(r):
        C = (r * r + mp.mpf(1) / 5 - mp.mpf(1) / 16) / (2 * r * o_abs)
        return mp.acos(C) if C <= 1 else None
    def dlo(r):
        C = (r * r + mp.mpf(1) / 5 - rho1 * rho1) / (2 * r * o_abs)
        return mp.acos(min(mp.mpf(1), C))
    worst = None; ok = True
    a0 = mp.mpf(rho1.numerator) / rho1.denominator if isinstance(rho1, F) else rho1
    for j in range(pieces):
        ra = a0 + (mp.mpf(1) / 4 - a0) * j / pieces
        rb = a0 + (mp.mpf(1) / 4 - a0) * (j + 1) / pieces
        hi = dhi(ra)
        if hi is None:
            ok = False; worst = (ra, rb, None); break
        slack = hi - dlo(rb) - 2 * gmax
        if worst is None or slack < worst[2]:
            worst = (ra, rb, slack)
        if slack <= 0:
            ok = False
    return dict(alpha=alpha, gmax_deg=gmax * 180 / mp.pi, ok=ok,
                worst_piece=(float(worst[0]), float(worst[1]), None if worst[2] is None else float(worst[2] * 180 / mp.pi)))

def part_D_samples(rho1, N0, nsamp=200, seed=1):
    d = prime_data(5); bb = d["betabar"]; o = d["o"]
    pows = [None] + [bb ** n for n in range(1, N0 + 1)]
    q16 = F(1, 16); r1 = rho1 * rho1
    def in_Omega(L):
        v = L - o
        return L.norm() <= q16 and r1 <= v.norm() <= q16
    samples = [o + G(F(3, 20), F(1, 5)), o + G(F(1, 5), F(3, 20)), o + G(F(3, 20), F(-1, 5)),
               o + G(F(1, 5), F(-3, 20))]
    samples = [L for L in samples if in_Omega(L)]
    rnd = random.Random(seed); D = 10000
    while len(samples) < nsamp:
        L = G(F(rnd.randint(-2500, 2500), D), F(rnd.randint(-2500, 2500), D))
        if in_Omega(L): samples.append(L)
    worst = None
    for L in samples:
        v = L - o; cnt = 0
        for n in range(1, N0 + 1):
            Lp = pows[n] * v
            if in_Omega(Lp): cnt += 1
        worst = cnt if worst is None else min(worst, cnt)
    return dict(n_samples=len(samples), min_choices=worst)

# ---------- main ----------
def main():
    out = []
    say = out.append
    primes = [5, 13, 17, 29, 37, 41, 53, 61]
    say("== Part B: premises of the u-model ==")
    B_ok = True
    for l in primes:
        r = part_B(l); say(f"l={l}: {r}")
        B_ok = B_ok and r["zeta"] is not None and all(v for k, v in r.items() if k != "zeta")
    say(f"Part B all ok: {B_ok}")
    say("== Part A: X1 (heteroclinic at every listed prime), e in the lens ==")
    A_ok = True
    for l in primes:
        for e in (Q_ORD3, Q_ORD3 + G(F(1, 30), F(1, 30)), Q_ORD3 + G(F(1, 20), F(-1, 20))):
            glue, fail = part_A(l, e, M=30)
            say(f"l={l} e={e}: gluing on Z[i] {glue}; first band failure {fail}")
            A_ok = A_ok and glue and fail is None
    say(f"Part A all ok: {A_ok}")
    say("== Part C: X3, the family b a^p (complete range p <= PMAX) ==")
    C_ok = True
    for l, PMAX in ((5, 40), (13, 20), (17, 20)):
        d = prime_data(l); mem = []
        for p in range(PMAX + 1):
            r = check_member(p, d) if c_of(p, d).norm() <= F(1, 16) else dict(p=p, member=False)
            if r["member"]:
                mem.append(p)
                good = r["orbit_in_Q0"] and r["steps_ok"] and r["closes"] and not r["l_divides_N"] and r["band_on_U_mod_N"]
                C_ok = C_ok and good
                say(f"l={l} p={p}: member; orbit_in_Q0 {r['orbit_in_Q0']} steps {r['steps_ok']} closes {r['closes']}"
                    f" N={r['N']} (bits {r['N'].bit_length()}) tau_period={r.get('tau_period')} band_on_U_mod_N={r.get('band_on_U_mod_N')}"
                    f" margin={r.get('margin')} U_seen={r.get('U_mod_N_seen')} {'OK' if good else 'FAIL'}")
        say(f"l={l}: members p <= {PMAX}: {mem} ({len(mem)}/{PMAX + 1})")
    say(f"Part C all ok: {C_ok}")
    say("== Part D: X2 branching lemma at l = 5 ==")
    rho1 = F(43, 200); N0 = 200
    Dn = part_D_numeric(rho1, N0); say(f"numeric (rho1={rho1}, N0={N0}): {Dn}")
    Ds = part_D_samples(rho1, N0); say(f"exact samples: {Ds}")
    D_ok = Dn["ok"] and Ds["min_choices"] >= 2
    say(f"Part D all ok: {D_ok}")
    say("== Plants ==")
    fired = run_plants(say)
    say(f"plants fired for their reasons: {fired}")
    verdict = A_ok and B_ok and C_ok and D_ok and all(fired.values())
    say(f"OVERALL: {'PASS' if verdict else 'FAIL'}")
    import os
    os.makedirs("data/fs91/j13", exist_ok=True)
    with open("data/fs91/j13/check.txt", "w") as f:
        f.write("\n".join(out) + "\n")
    print("\n".join(out))
    return 0 if verdict else 1

def run_plants(say):
    fired = {}
    # P1: e outside the parity disc -> backward band failure, no forward failure
    e_bad = G(F(14, 51), F(14, 51))
    glue, fail = part_A(5, e_bad, M=40)
    fired["P1_parity_disc"] = (glue and fail is not None and fail[0] == "backward")
    say(f"P1 (e outside parity disc): glue {glue}, first failure {fail}")
    # P2: mismatched archimedean part on the backward half -> gluing on Z[i] fails
    glue2, _ = part_A(5, Q_ORD3 + G(F(1, 30), F(1, 30)), M=2, backward_arch=G(F(1, 30), F(1, 30)))
    fired["P2_gluing"] = (glue2 is False)
    say(f"P2 (backward archimedean part e-q instead of e-P): gluing {glue2}")
    # P3: a non-member p=1 at l=5: its torsion character fails the independent band check
    d5 = prime_data(5)
    r3 = check_member(1, d5)
    fired["P3_nonmember"] = (r3["member"] is False and r3.get("band_on_U_mod_N") is False and r3.get("first_bad") is not None)
    say(f"P3 (p=1, non-member): member {r3['member']}, N={r3['N']}, band {r3.get('band_on_U_mod_N')}, first bad {r3.get('first_bad')}")
    # P4: wrong digit lattice conj(pi)^{-1}Z[i] -> the b-step fails the step check
    r4 = check_member(3, d5, lattice_pi=d5["pi"].conj())
    fired["P4_lattice"] = (r4["steps_ok"] is False)
    say(f"P4 (step lattice pibar^-1 Z[i]): steps_ok {r4['steps_ok']}")
    # P5: rho1 at the lens tip -> width inequality fails
    r5 = part_D_numeric(F(1975, 10000), 200)
    fired["P5_rho1_tip"] = (r5["ok"] is False)
    say(f"P5 (rho1 = 0.1975): {r5}")
    # P6: N0 too small -> gap too large
    r6 = part_D_numeric(F(43, 200), 60)
    fired["P6_N0_small"] = (r6["ok"] is False)
    say(f"P6 (N0 = 60): {r6}")
    # faithful partner of P3: member p=3 passes the same check
    r3b = check_member(3, d5)
    fired["P3_partner_member_passes"] = bool(r3b.get("band_on_U_mod_N"))
    return fired

if __name__ == "__main__":
    sys.exit(main())
