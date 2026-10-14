#!/usr/bin/env python3
"""FS131-KN4, route R-1: exact checks behind the layer dichotomy (plans/FS131-KN4-three-four-colours-plan.md § 2.3).

Claims checked with Fractions:
 (1) (2 - i) w = 2 + i for w = (3 + 4i)/5, and 1/5 = w + 1/w - 1.
 (2) Over the 4^4 sign patterns the forms n1 = 2a' - b' - 2a - b and n2 = a' + 2b' + a - 2b have |n| <= 1 on the box |.| <= 1/6,
     with |n| = 1 only at corners (all four coordinates of absolute value 1/6).
 (3) A rotation step from a corner leaves the box: for (a, b) a corner, ((3a + 4b)/5, (-4a + 3b)/5) and its inverse
     ((3a - 4b)/5, (4a + 3b)/5) each have a coordinate of absolute value 7/30 > 1/6.
 (4) The vertices of the box with n1 = n2 = 0 failing the rotation equations: none (the two forms determine (a', b') linearly).
Usage: layer_check.py [--plant w | --plant box]
"""
import sys
from fractions import Fraction as Fr
from itertools import product

plant = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] == "--plant" else None
six = Fr(1, 6) if plant != "box" else Fr(1, 5)   # plant: a wider box must break (2): the bound is no longer 1
w = (Fr(3, 5), Fr(4, 5)) if plant != "w" else (Fr(4, 5), Fr(3, 5))   # plant: the wrong unit vector must break (1)

def mul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
ok = True
# (1)
ok1 = mul((Fr(2), Fr(-1)), w) == (Fr(2), Fr(1))
winv = (w[0], -w[1])
ok1 &= (w[0] + winv[0] - 1, w[1] + winv[1]) == (Fr(1, 5), Fr(0))
print("(1) (2-i)w = 2+i and 1/5 = w + 1/w - 1:", ok1); ok &= ok1
# (2): the forms are linear, so extremes are at vertices of the box
ok2 = True
for sa, sb, sa2, sb2 in product([-1, 1], repeat=4):
    a, b, a2, b2 = sa*six, sb*six, sa2*six, sb2*six
    n1 = 2*a2 - b2 - 2*a - b
    n2 = a2 + 2*b2 + a - 2*b
    ok2 &= abs(n1) <= 1 and abs(n2) <= 1
ok2 &= (2 + 1 + 2 + 1) * six == 1          # the bound is exactly 1, so |n| = 1 forces every coordinate to its extreme
print("(2) |n1|, |n2| <= 1 on the box, with equality only at corners:", ok2); ok &= ok2
# (3)
ok3 = True
for sa, sb in product([-1, 1], repeat=2):
    a, b = sa*six, sb*six
    fwd = ((3*a + 4*b)/5, (-4*a + 3*b)/5)
    bwd = ((3*a - 4*b)/5, (4*a + 3*b)/5)
    ok3 &= max(abs(fwd[0]), abs(fwd[1])) > six and max(abs(bwd[0]), abs(bwd[1])) > six
print("(3) a rotation step from a corner leaves the box, both ways:", ok3); ok &= ok3
# (4) n1 = n2 = 0  <=>  rotation: solve the 2x2 system symbolically at a generic rational point
a, b = Fr(1, 7), Fr(-1, 11)
a2, b2 = (3*a + 4*b)/5, (-4*a + 3*b)/5
ok4 = (2*a2 - b2 - 2*a - b == 0) and (a2 + 2*b2 + a - 2*b == 0)
print("(4) the rotation solves n1 = n2 = 0:", ok4); ok &= ok4
print("ALL PASS" if ok else "FAIL")
sys.exit(0 if ok else 1)
