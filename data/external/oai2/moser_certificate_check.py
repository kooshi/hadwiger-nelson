#!/usr/bin/env python3
"""EXT-OAI2 stage 3: an independent exact check of the manuscript's Lemma 8.9
(seven-point certificate) and of the unit edges of its seven-point graph.

Manuscript (angular.tex, eqs (8.3)-(8.5)):
  G = {0, A, B, T, uA, uB, uT},  A=(sqrt3+i)/2, B=(sqrt3-i)/2, T=sqrt3, u=(5+i sqrt11)/6
  z_g = (35+12i)/37 * (g + (-290+149i)/250)
  claim: 0 < |z_g|^2 < 4 and  P := y^2 (3x^2-y^2)^2  <  P' := l^3 (1-l/4) (l-1)^2,  l = x^2+y^2.

Method: mpmath interval arithmetic at 60 digits (rigorous enclosures of sqrt3, sqrt11);
edges checked exactly with sympy.  Not the manuscript's own table: nothing from its
Tables 1-2 is read.  Control: --fault moves the translation by +100/250 i and must fail.
"""
import sys
from mpmath import iv, mp
import sympy as sp

iv.dps = 60
fault = "--fault" in sys.argv

s3, s11 = iv.sqrt(3), iv.sqrt(11)
I = iv.mpc(0, 1)
A = (s3 + I) / 2
B = (s3 - I) / 2
T = iv.mpc(s3, 0)
u = (5 + I * s11) / 6
G = {"0": iv.mpc(0, 0), "A": A, "B": B, "T": T, "uA": u * A, "uB": u * B, "uT": u * T}
rot = iv.mpc(iv.mpf(35) / 37, iv.mpf(12) / 37)
shift = iv.mpc(iv.mpf(-290) / 250, iv.mpf(249 if fault else 149) / 250)

ok = True
for name, g in G.items():
    z = rot * (g + shift)
    x, y = z.real, z.imag
    l = x * x + y * y
    P = y * y * (3 * x * x - y * y) ** 2
    Pp = l ** 3 * (1 - l / 4) * (l - 1) ** 2
    good = (l.a > 0) and (l.b < 4) and (P.b < Pp.a)
    ok = ok and bool(good)
    print(f"{name:>2}: |z|^2 in [{float(l.a):.6f},{float(l.b):.6f}]  P<= {float(P.b):.6g}  P'>= {float(Pp.a):.6g}  {'in region' if good else 'NOT in region'}")

# exact unit edges of the seven-point graph (rotation and translation preserve them)
r3, r11 = sp.sqrt(3), sp.sqrt(11)
As, Bs, Ts, us = (r3 + sp.I) / 2, (r3 - sp.I) / 2, r3, (5 + sp.I * r11) / 6
V = {"0": sp.Integer(0), "A": As, "B": Bs, "T": Ts, "uA": us * As, "uB": us * Bs, "uT": us * Ts}
edges = [("0", "A"), ("0", "B"), ("A", "B"), ("T", "A"), ("T", "B"),
         ("0", "uA"), ("0", "uB"), ("uA", "uB"), ("uT", "uA"), ("uT", "uB"), ("T", "uT")]
unit = all(sp.simplify(sp.expand((V[a] - V[b]) * sp.conjugate(V[a] - V[b])) - 1) == 0 for a, b in edges)
print("unit edges (11):", unit, "  |35+12i|^2 == 37^2:", 35 * 35 + 12 * 12 == 37 * 37)
print("CERTIFICATE", "HOLDS" if (ok and unit) else "FAILS")
