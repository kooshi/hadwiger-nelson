#!/usr/bin/env python3
"""FS-73 close, prior-art check (2026-09-23).  UNTRUSTED (a check, not a proof tool).

Jaan Parts (Polymath16, twelfth thread, 13 April 2019) reported that the unit-distance graph on V43 + V43 + V43 forces every vertex at
radius 8/sqrt27 to take the origin's colour, where V_{7+12n} = {0} u {zeta6^i eta^j : j = -n..n}, eta = (sqrt33 + i sqrt3)/6 (the half
Moser twist).  8/sqrt27 = |v| for FS-73's forced vector v = -(4/9)(1 + sqrt-11).  Question: is v, or a point of its order-24 orbit, among
those vertices?  Floats propose the Minkowski sum; sympy confirms the one identity quoted.  Answer: NO -- the six vertices at that radius
are (8/9) sqrt-3 zeta6^m, e.g. eta^3 - conj(eta)^3 exactly, which lie in 8 Lambda but are reached through eta^(+-3), outside Lambda.
"""
import cmath
import itertools
import math

import sympy as sp

z6 = cmath.exp(1j * math.pi / 3)
eta = (math.sqrt(33) + 1j * math.sqrt(3)) / 6
S = [0j] + [z6 ** i * eta ** j for i in range(6) for j in range(-3, 4)]          # V43
v = -(4 / 9) * (1 + 1j * math.sqrt(11))
orbit = set()
for base in (v, -(4 / 9) * (1 - 1j * math.sqrt(11))):                          # the Galois flip sqrt-11 -> -sqrt-11
    for i in range(6):
        for w in (z6 ** i * base, (z6 ** i * base).conjugate()):
            orbit.add((round(w.real, 9), round(w.imag, 9)))
pts = {}
for a, b, c in itertools.combinations_with_replacement(range(len(S)), 3):
    p = S[a] + S[b] + S[c]
    pts.setdefault((round(p.real, 9), round(p.imag, 9)), (a, b, c))
r = 8 / math.sqrt(27)
on_r = sorted(k for k in pts if abs(math.hypot(*k) - r) < 1e-7)
print(f'|orbit(v)| = {len(orbit)}; |V43+V43+V43| = {len(pts)}; vertices at radius 8/sqrt27: {len(on_r)}; orbit points among them: '
      f'{sum(k in pts for k in orbit)}')
for k in on_r:
    print('  ', k, [m for m in range(6) if abs(complex(*k) - (8 / 9) * 1j * math.sqrt(3) * z6 ** m) < 1e-8])
E = (sp.sqrt(33) + sp.I * sp.sqrt(3)) / 6
assert sp.simplify(sp.expand(E ** 3 - sp.conjugate(E) ** 3) - sp.Rational(8, 9) * sp.I * sp.sqrt(3)) == 0
print('exact: eta^3 - conj(eta)^3 = (8/9) sqrt-3')
assert not any(k in pts for k in orbit) and len(on_r) == 6
