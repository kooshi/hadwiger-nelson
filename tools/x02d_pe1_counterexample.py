#!/usr/bin/env python3
"""X02D: exact check of PE-1's counterexample over F = Q(sqrt 47), L = F(i).

v = (329 + i*sqrt47) / (48*sqrt47) and u' = (3 + i*sqrt47)/(3 - i*sqrt47).
Claims checked (exact, sympy):
  C1  48^2 - 47*7^2 = 1                      (Pell)
  C2  329^2 + 47 = 47 * 48^2                 (so N(z) = 47*48^2, z = 329 + sqrt(-47))
  C3  v * conj(v) = 1, conj: i -> -i, sqrt47 fixed   (v in U_F)
  C4  v^2 = a + b*i*sqrt47 with a, b rational        (v^2 in Q(sqrt -47))
  C5  v + 1/v = 329/(24*sqrt47) and v - 1/v = i/24   (so Q(v) contains sqrt47 and i: Q(v) = L)
  C6  u' * conj(u') = 1, u' = a' + b'*i*sqrt47       (u' in U_F and in Q(sqrt -47))
  C7  independence of v, u': N(z') = 3^2+47 = 56 = 2^3*7 with 7 split in Q(sqrt -47) (-47 a square mod 7)
      and 7 not dividing z' (3, 1 not both 0 mod 7), while 7 does not divide N(z) = 2^8*3^2*47: so u' has
      valuation +-1 at the primes above 7 and v^2 has valuation 0 there; and v is non-torsion because
      the prime above 3 dividing z does so to exponent 2 (N(z) has 3^2 and 3 does not divide z).
Run with --plant-norm (329 -> 330) or --plant-dependent (z' := z): the matching check must FAIL.
"""
import sys
from sympy import sqrt, I, Rational, simplify, expand, factorint, nsimplify, conjugate

plant_norm = "--plant-norm" in sys.argv
plant_dep = "--plant-dependent" in sys.argv

s = sqrt(47)
A = 330 if plant_norm else 329
z = A + I * s
v = z / (48 * s)
def conj(e):
    return e.subs(I, -I)

fails = []
def check(name, ok):
    print(f"{name}: {'ok' if ok else 'FAIL'}")
    if not ok:
        fails.append(name)

check("C1 Pell 48^2-47*7^2=1", 48**2 - 47 * 7**2 == 1)
check("C2 A^2+47 = 47*48^2", A**2 + 47 == 47 * 48**2)
check("C3 v*conj(v) = 1", simplify(expand(v * conj(v))) == 1)
v2 = expand(v**2)
a = simplify(v2.subs(I, 0))                       # real part (i -> 0 kills the imaginary part)
b = simplify((v2 - a) / (I * s))
check("C4 v^2 = a + b*i*sqrt47, a,b rational", a.is_rational and simplify(b).is_rational and simplify(v2 - a - b * I * s) == 0)
check("C5a v + 1/v = 329/(24 sqrt47)", simplify(v + 1 / v - Rational(A, 24) / s) == 0 and simplify((v + 1/v) * s).is_rational)
check("C5b v - 1/v = i/24", simplify(v - 1 / v - I / 24) == 0)
zp = z if plant_dep else 3 + I * s
up = zp / conj(zp)
check("C6 u'*conj(u') = 1", simplify(expand(up * conj(up))) == 1)
up_e = expand(simplify(up * conj(zp) * zp / (zp * conj(zp))))
Nz = A**2 + 47
zr, zi = (A, 1)
zpr, zpi = (A, 1) if plant_dep else (3, 1)
Nzp = zpr**2 + 47 * zpi**2
seven_split = any((x * x + 47) % 7 == 0 for x in range(7))
check("C7a 7 | N(z')", Nzp % 7 == 0)
check("C7b 7 split in Q(sqrt -47)", seven_split)
check("C7c 7 does not divide z'", not (zpr % 7 == 0 and zpi % 7 == 0))
check("C7d 7 does not divide N(z)", Nz % 7 != 0)
check("C7e 3^2 || N(z) and 3 does not divide z", factorint(Nz).get(3, 0) == 2 and not (zr % 3 == 0 and zi % 3 == 0))
print("N(z) =", factorint(Nz), " N(z') =", factorint(Nzp))
if fails:
    print("RESULT: FAIL", fails)
    sys.exit(1)
print("RESULT: all checks pass")
