#!/usr/bin/env python3
"""FS132-I3: the sign identity behind `shift_pos`, as a polynomial identity modulo the three Pythagorean relations.
With a = d/2, b = d'/2, r = cos a - s3 sin a (= 2 cos(pi/3 + a)), r' likewise, s3 = sqrt 3:
  r^2 + r'^2 - 1 - 2 r r' cos(pi/3 + a + b) + 8 sin a sin b cos(a + b)  =  q1 g1 + q2 g2 + q3 g3
with g1 = ca^2 + sa^2 - 1, g2 = cb^2 + sb^2 - 1, g3 = s3^2 - 3.  Prints the quotients (the coefficients of Lean's
`linear_combination`) and the remainder, which must be 0.  --fault changes the 8 to a 7: the remainder must be non-zero."""
import sys
from sympy import symbols, reduced, expand, Rational
ca, sa, cb, sb, s3 = symbols('ca sa cb sb s3')
r, rp = ca - s3*sa, cb - s3*sb
cab, sab = ca*cb - sa*sb, sa*cb + ca*sb
cos_shift = Rational(1, 2)*cab - s3/2*sab          # cos(pi/3 + a + b)
k = 7 if '--fault' in sys.argv else 8
expr = expand(r**2 + rp**2 - 1 - 2*r*rp*cos_shift + k*sa*sb*cab)
G = [ca**2 + sa**2 - 1, cb**2 + sb**2 - 1, s3**2 - 3]
Q, R = reduced(expr, G, ca, sa, cb, sb, s3, order='lex')
for q in Q: print('q =', q)
print('remainder =', R)
assert expand(sum(q*g for q, g in zip(Q, G)) + R - expr) == 0
sys.exit(0 if R == 0 else 1)
