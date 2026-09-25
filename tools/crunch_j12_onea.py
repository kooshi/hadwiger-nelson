#!/usr/bin/env python3
"""J12 (FS-91, crunch 2026-09-25) -- ONE-a: the heteroclinic band character at a general split prime p.

Claim checked (derived by hand in plans/FS91-S1D-one-prime.md, Stage 2, Theorem ONE-a):
  Let p = pi*pibar (p = 1 mod 4), w = pi/pibar, R = Z[i][1/p], S+ = Z[i][1/pibar], S- = Z[i][1/pi].
  Let C = (1+i)/3, P = (1+i)/2, tau = Re(conj(C) x) (order 3), theta2 = Re(conj(P) x) (order 2).
  The character theta equal to tau on S+ and to theta2 + lambda_{C-P} on S- is a band character
  (values on U = <i> x <w> in [1/4, 3/4]) and is not torsion + archimedean.

What this tool checks, exactly (Fractions only), at p in {5, 13, 17, 29} and |m| <= M:
  (1) w mod 3 lies in {+-1, +-i} (so tau takes only the values 1/3, 2/3 on U: the margin 1/12 is p-free);
  (2) the gluing identity on Z[i]: tau = theta2 + lambda_{C-P} on the generators 1, i (mod 1);
  (3) the band on i^k w^m for |m| <= M, k = 0..3, from the half each unit lies in;
  (4) the orbit model (S0B-T1 at p): the layer points e_m = theta(w^m) + i*theta(i w^m), lifted into
      Q = [1/4, 3/4]^2, satisfy the step rule e_{m+1} - conj(w) e_m in pi^{-1} Z[i] for every -M <= m < M,
      INCLUDING the junction steps -1 -> 0 -> 1 -- an independent check that the two halves glue to one character.
Plants (each must fire, and fire for its own reason):
  P1 band [1/3, 2/3] (three colours): must fail on the backward half only (|C-P| = sqrt2/6 > 1/6); never forward.
  P2 step lattice pibar^{-1} Z[i] in place of pi^{-1} Z[i]: must fail on the step check.
  P3 junction fault: backward displacement C-P+1/60 (the halves disagree on Z[i]): the step check must fail
     at the junction step -1 -> 0 and at no other step.
Exit status 0 iff every faithful check passes and every plant fires for its reason.
"""
from fractions import Fraction as Fr
import sys


class G:
    """Exact Gaussian rational a + b i."""
    __slots__ = ("a", "b")

    def __init__(self, a, b=0):
        self.a, self.b = Fr(a), Fr(b)

    def __add__(s, o): o = o if isinstance(o, G) else G(o); return G(s.a + o.a, s.b + o.b)
    __radd__ = __add__
    def __sub__(s, o): o = o if isinstance(o, G) else G(o); return G(s.a - o.a, s.b - o.b)
    def __neg__(s): return G(-s.a, -s.b)
    def __mul__(s, o):
        o = o if isinstance(o, G) else G(o)
        return G(s.a * o.a - s.b * o.b, s.a * o.b + s.b * o.a)
    __rmul__ = __mul__
    def conj(s): return G(s.a, -s.b)
    def norm(s): return s.a * s.a + s.b * s.b
    def inv(s): n = s.norm(); return G(s.a / n, -s.b / n)
    def __truediv__(s, o): o = o if isinstance(o, G) else G(o); return s * o.inv()
    def __pow__(s, n):
        r, x = G(1), (s if n >= 0 else s.inv())
        for _ in range(abs(n)): r = r * x
        return r
    def is_gauss_int(s): return s.a.denominator == 1 and s.b.denominator == 1
    def __eq__(s, o): o = o if isinstance(o, G) else G(o); return s.a == o.a and s.b == o.b
    def __repr__(s): return f"({s.a}+{s.b}i)"


I = G(0, 1)


def frac1(x):  # x mod 1 in [0,1)
    return x - (x.numerator // x.denominator)


def re_pair(c, x):  # Re(conj(c) x)
    return (c.conj() * x).a


def split_prime(p):
    for a in range(1, p):
        for b in range(1, p):
            if a * a + b * b == p:
                return G(a, b)
    raise ValueError(p)


def mod3_unit(u, p):
    """u in Z[i][1/p]: return the Gaussian integer in {0,1,2}+{0,1,2}i congruent to u mod 3."""
    # write u = y / p^n with y in Z[i]
    n, y = 0, u
    while not y.is_gauss_int():
        y, n = y * p, n + 1
    inv = pow(p % 3, -1, 3)  # p^{-1} mod 3
    f = pow(inv, n, 3)
    return G((int(y.a) * f) % 3, (int(y.b) * f) % 3)


def run(p, M, band=(Fr(1, 4), Fr(3, 4)), lattice="pi", back_shift=Fr(0)):
    pi = split_prime(p)
    pib = pi.conj()
    w = pi / pib
    wb = w.conj()
    C, P = G(Fr(1, 3), Fr(1, 3)), G(Fr(1, 2), Fr(1, 2))
    d_back = C - P + G(back_shift)
    lo, hi = band
    report = {"p": p, "pi": pi, "w": w}

    # (1) w mod 3 in {+-1, +-i}
    wm3 = mod3_unit(w, p)
    report["w_mod3"] = wm3
    mu4 = [G(1), G(2), G(0, 1), G(0, 2)]
    report["w_mod3_in_mu4"] = any(wm3 == z for z in mu4)

    def tau(x):  # order-3 character on R (factors through R/3R = Z[i]/3)
        return frac1(re_pair(C, mod3_unit(x, p)))

    def back(x):  # theta2 + lambda_{d_back} on S-  (theta2 = 1/2 on every unit; here x is a unit or in Z[i])
        return frac1(re_pair(P, x) + re_pair(d_back, x)) if x.is_gauss_int() else frac1(Fr(1, 2) + re_pair(d_back, x))

    # (2) gluing identity on Z[i] generators (faithful only when back_shift == 0)
    report["glue_on_Zi"] = all(tau(x) == frac1(re_pair(P, x) + re_pair(d_back, x)) for x in (G(1), I))

    # (3) band; theta(u) from the half u lies in
    def theta(u, m):
        return tau(u) if m >= 0 else back(u)
    fails_fwd, fails_back = [], []
    for m in range(-M, M + 1):
        wm = w ** m
        for k in range(4):
            u = (I ** k) * wm
            v = theta(u, m)
            if not (lo <= v <= hi):
                (fails_fwd if m >= 0 else fails_back).append((m, k, v))
    report["band_fail_forward"] = fails_fwd
    report["band_fail_backward"] = fails_back

    # (4) orbit model step rule, e_m lifted into Q (coordinates in [1/4,3/4] when in band; else into [0,1))
    e = {}
    for m in range(-M, M + 1):
        wm = w ** m
        e[m] = G(theta(wm, m), theta(I * wm, m))
    step_lat_inv = pi if lattice == "pi" else pib  # delta in lattice^{-1} Z[i]  <=>  lattice*delta in Z[i]
    step_fail = []
    for m in range(-M, M):
        delta = e[m + 1] - wb * e[m]
        if not (step_lat_inv * delta).is_gauss_int():
            step_fail.append(m)
    report["step_fail"] = step_fail
    return report


def main():
    M = 40
    ok = True
    lines = []
    for p in (5, 13, 17, 29):
        r = run(p, M)
        good = (r["w_mod3_in_mu4"] and r["glue_on_Zi"] and not r["band_fail_forward"]
                and not r["band_fail_backward"] and not r["step_fail"])
        ok &= good
        lines.append(f"p={p} pi={r['pi']} w={r['w']} w mod 3={r['w_mod3']} in mu4={r['w_mod3_in_mu4']} "
                     f"glue={r['glue_on_Zi']} band fails fwd/back={len(r['band_fail_forward'])}/{len(r['band_fail_backward'])} "
                     f"step fails={r['step_fail']}  -> {'PASS' if good else 'FAIL'}")
        # P1: three colours -- backward only
        r1 = run(p, M, band=(Fr(1, 3), Fr(2, 3)))
        p1 = (not r1["band_fail_forward"]) and bool(r1["band_fail_backward"])
        ok &= p1
        first = r1["band_fail_backward"][0] if r1["band_fail_backward"] else None
        lines.append(f"  P1 band [1/3,2/3]: fwd fails={len(r1['band_fail_forward'])} back fails={len(r1['band_fail_backward'])} "
                     f"(first {first}) -> {'FIRES (backward only, its reason)' if p1 else 'DID NOT FIRE AS NAMED'}")
        # P2: wrong step lattice
        r2 = run(p, M, lattice="pibar")
        p2 = bool(r2["step_fail"])
        ok &= p2
        lines.append(f"  P2 lattice pibar^-1: step fails at {len(r2['step_fail'])} of {2*M} steps -> "
                     f"{'FIRES' if p2 else 'DID NOT FIRE'}")
        # P3: junction fault -- step check fails exactly at m = -1
        r3 = run(p, M, back_shift=Fr(1, 60))
        p3 = (r3["step_fail"] == [-1]) and not r3["glue_on_Zi"]
        ok &= p3
        lines.append(f"  P3 junction fault: glue={r3['glue_on_Zi']} step fails at {r3['step_fail']} -> "
                     f"{'FIRES (junction only, its reason)' if p3 else 'DID NOT FIRE AS NAMED'}")
    lines.append("ALL PASS" if ok else "SOME CHECK FAILED")
    out = "\n".join(lines)
    print(out)
    with open(sys.argv[1] if len(sys.argv) > 1 else "/dev/null", "w") as fh:
        fh.write(out + "\n")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
