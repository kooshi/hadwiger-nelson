#!/usr/bin/env python3
"""X05V exact checks (crunch 2026-09-26). Each check confirms a derived claim in plans/FS100-X05V-verification.md; each has a
plant that must fire. Exact arithmetic only (sympy / fractions). Run: python3 tools/x05v_checks.py  (exit 0 iff every check passes
AND every plant fires)."""
import sys
from fractions import Fraction as Fr
import sympy as sp

FAILS = []

def expect(name, cond):
    print(("PASS " if cond else "FAIL ") + name)
    if not cond:
        FAILS.append(name)

# --- 1. Tetrahedral Gram identity and the SI-3 algebra ------------------------------------------------------------------
def tetra(gram_const=sp.Rational(-1, 3)):
    s = 1 / sp.sqrt(3)
    E = [sp.Matrix(v) * s for v in ([1, 1, 1], [1, -1, -1], [-1, 1, -1], [-1, -1, 1])]
    ok = all(sp.simplify(E[i].dot(E[j]) - (sp.Rational(4, 3) * int(i == j) + gram_const)) == 0 if i != j else
             sp.simplify(E[i].dot(E[j]) - 1) == 0 for i in range(4) for j in range(4))
    return E, ok

E, ok = tetra()
expect("1a tetrahedron Gram <e_i,e_j> = (4/3)delta - 1/3", ok)
_, ok_plant = tetra(sp.Rational(-1, 4))
expect("1a-plant wrong Gram constant -1/4 is refused", not ok_plant)

p = sp.symbols('p0:4'); q = sp.symbols('q0:4')
h = sum((p[j] * E[j] for j in range(4)), sp.zeros(3, 1)); hq = sum((q[j] * E[j] for j in range(4)), sp.zeros(3, 1))
lhs = sp.expand(h.dot(hq))
rhs = sp.expand(sp.Rational(4, 3) * sum(p[j] * q[j] for j in range(4)) - sp.Rational(1, 3) * sum(p) * sum(q))
expect("1b <sum p_j e_j, sum q_k e_k> = (4/3)<p,q> - (1/3)(sum p)(sum q)", sp.simplify(lhs - rhs) == 0)

# --- 2. FL-1(iii) is equivalent to  A >= (1-B)/3 - a/4 ---------------------------------------------------------------------
A, B, a = sp.symbols('A B a', real=True)
sigE_hat = sp.Rational(4, 3) * A - sp.Rational(1, 3)      # E<h(0),h(u)>, A = E<p(0),p(u)>
sigE_mass = sp.Rational(4, 3) * B - sp.Rational(1, 3)     # E|h(0)|^2,     B = E|p(0)|^2
tau_hat = sp.Rational(-1, 3) - sigE_hat                   # sigma^(u) = -1/3 on U; Haar contributes 0 at u != 0
tau_mass = 1 - a - sigE_mass
gap = sp.expand(tau_hat + tau_mass / 3)                   # FL-1(iii) says gap <= 0
target = sp.expand(-sp.Rational(4, 3) * (A - (1 - B) / 3 + a / 4))
expect("2a tau^(1) + tau(R^)/3 = -(4/3)(A - (1-B)/3 + a/4)", sp.simplify(gap - target) == 0)
expect("2a-plant a wrong sign on a is refused", sp.simplify(gap - sp.expand(-sp.Rational(4, 3) * (A - (1 - B) / 3 - a / 4))) != 0)

def fl1_iii_holds(pv, qv, aval=Fr(0)):
    Av = sum(Fr(x) * Fr(y) for x, y in zip(pv, qv)); Bv = sum(Fr(x) ** 2 for x in pv)
    return Av >= (1 - Bv) / 3 - aval / 4

half = Fr(1, 2); quarter = Fr(1, 4)
expect("2b pointwise FL-1(iii) fails at p=(1/2,1/2,0,0), q=(0,0,1/2,1/2), a=0",
       not fl1_iii_holds((half, half, 0, 0), (0, 0, half, half)))
expect("2b-plant uniform p=q=(1/4,..) satisfies it (equality)", fl1_iii_holds((quarter,) * 4, (quarter,) * 4))
expect("2b-plant deterministic disjoint p=e0,q=e1 satisfies it (equality)", fl1_iii_holds((1, 0, 0, 0), (0, 1, 0, 0)))

# --- 3. J0 dips below -1/3: rigorous rational enclosure of J0(x) by the alternating Taylor series ---------------------------
def J0_enclosure(x, terms=60):
    """J0(x) = sum_k (-1)^k (x/2)^{2k}/(k!)^2. Once terms decrease in modulus, consecutive partial sums bracket J0."""
    y = (x / 2) ** 2
    t = Fr(1); s = Fr(0); k = 0; prev = None
    sums = []
    while k < terms:
        s += t if k % 2 == 0 else -t
        sums.append(s)
        k += 1
        t = t * y / (k * k)
    # the terms t_k = y^k/(k!)^2 decrease once k^2 > y; check it holds for the last two and bracket
    assert (terms - 1) ** 2 > y
    lo, hi = sorted(sums[-2:])
    return lo, hi

lo, hi = J0_enclosure(Fr(383, 100))
expect(f"3 J0(3.83) in [{float(lo):.6f},{float(hi):.6f}] and hi < -1/3", hi < Fr(-1, 3))
lo2, hi2 = J0_enclosure(Fr(2))
expect(f"3-plant J0(2) in [{float(lo2):.6f},{float(hi2):.6f}] is NOT below -1/3", not (hi2 < Fr(-1, 3)))

# --- 4. The wave shape: E-part s*v*cos(phase), |s| <= 1/3 stays in the tetrahedron; FL-1(iii) fails when J0 < -1/3 ----------
# inradius of the tetrahedron with circumradius 1 is 1/3: the face planes are <x, e_j> = -1/3 (for the face opposite e_j)
v = sp.Matrix([1, 0, 0])
inside = all((sp.Rational(1, 3) * v).dot(E[j]) >= sp.Rational(-1, 3) and (-sp.Rational(1, 3) * v).dot(E[j]) >= sp.Rational(-1, 3)
             for j in range(4))
expect("4a s*v with |s|=1/3, v=(1,0,0) lies in the tetrahedron {x : <x,e_j> >= -1/3}", inside)
s_ = sp.symbols('s', positive=True); J = sp.symbols('J', real=True)
sigE_hat_w = s_ ** 2 / 2 * J; sigE_mass_w = s_ ** 2 / 2
gap_w = sp.simplify((sp.Rational(-1, 3) - sigE_hat_w) + (1 - sigE_mass_w) / 3)   # a = 0
expect("4b gap = (s^2/2)(-J - 1/3), positive iff J < -1/3", sp.simplify(gap_w - s_ ** 2 / 2 * (-J - sp.Rational(1, 3))) == 0)
expect("4b at J = hi(J0(3.83)) the gap is positive (FL-1(iii) fails for this shape)",
       (-hi - Fr(1, 3)) > 0)
expect("4b-plant at J = -1/4 the gap is negative (FL-1(iii) holds)", (Fr(1, 4) - Fr(1, 3)) < 0)

# --- 5. KC: C9's colouring at the stable 7 of Q(sqrt 11): theta = (2x+3y)/7 on the circle over F_7 -----------------------------
def circle_values(cx, cy, pmod=7):
    pts = [(x, y) for x in range(pmod) for y in range(pmod) if (x * x + y * y) % pmod == 1]
    return pts, sorted({(cx * x + cy * y) % pmod for x, y in pts})

pts, vals = circle_values(2, 3)
expect(f"5 circle over F_7 has {len(pts)} points; (2x+3y) mod 7 takes {vals}, inside {{2,3,4,5}}",
       len(pts) == 8 and set(vals) <= {2, 3, 4, 5})
_, vals_plant = circle_values(1, 0)
expect(f"5-plant theta = x/7 takes {vals_plant}, not inside {{2,..,5}}", not set(vals_plant) <= {2, 3, 4, 5})
# the floor lemma: s in (1/4,3/4) mod 1 => floor(4t) != floor(4(t+s)) mod 4, checked on the 7-grid exactly
ok = all((4 * t // 7) % 4 != (4 * ((t + s) % 7) // 7) % 4 for t in range(7) for s in (2, 3, 4, 5))
expect("5 floor(4 theta) differs mod 4 across every step s in {2,..,5}/7 (C9 proper on Gamma_7)", ok)
ok_plant = all((4 * t // 7) % 4 != (4 * ((t + s) % 7) // 7) % 4 for t in range(7) for s in (1, 2, 3, 4, 5))
expect("5-plant with step 1/7 allowed, properness fails", not ok_plant)

print(f"\n{len(FAILS)} failure(s)")
sys.exit(1 if FAILS else 0)
