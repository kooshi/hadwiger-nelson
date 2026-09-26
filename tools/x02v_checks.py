#!/usr/bin/env python3
"""X02V exact checks (FS-100 x2x3 crunch): two derived claims, each checked in exact arithmetic, with plants.

C1 (PE-1's counterexample).  F = Q(sqrt5), L = Q(sqrt5, i), w = (2+i)/sqrt5, v = (5+12i)/13.
    w, v are norm one for L/F; w^2 = (2+i)/(2-i) lies in Q(i); v = (3+2i)/(3-2i); w and v are multiplicatively
    independent (valuation matrix at the Gaussian primes 2+i, 3+2i is the identity for (w^2, v)); Q(w) = L
    (minimal polynomial of degree 4).  So Gamma = <w, v> has Q(Gamma) = L while its index-2 subgroup <w^2, v>
    lies in Q(i): the Gamma-action on M^ is not totally irreducible.
C2 (ED-1's scope).  F = Q(cbrt2) (one real, one complex place), L = F(i): some unit eps of L gives u = eps/sigma(eps),
    sigma: i -> -i, with u*sigma(u) = 1 and u^|mu_L| != 1, so u is a non-torsion element of U with H(u) = 1, and U_N is
    infinite for every N >= 1.  Control: F = Q(sqrt2) (totally real) gives only torsion u = eps/sigma(eps).

Run: python3 tools/x02v_checks.py            (expects ALL CHECKS PASS)
     python3 tools/x02v_checks.py --plant X  (X in dep, subfield, notnormone; each must make its check FAIL)
"""
import subprocess
import sys

import sympy as sp

PLANT = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] == "--plant" else None
failures = []


def check(name, ok):
    print(("PASS " if ok else "FAIL ") + name)
    if not ok:
        failures.append(name)


# ---------- C1 ----------
I, s5 = sp.I, sp.sqrt(5)
w = (2 + I) / s5
v = sp.Rational(5, 13) + sp.Rational(12, 13) * I
if PLANT == "subfield":
    w = sp.Rational(3, 5) + sp.Rational(4, 5) * I  # an element of Q(i): Q(w) = Q(i), degree 2
if PLANT == "dep":
    v = sp.expand(w**4)  # dependent on w
check("C1 w norm one", sp.simplify(w * sp.conjugate(w)) == 1)
check("C1 v norm one", sp.simplify(v * sp.conjugate(v)) == 1)
w2 = sp.nsimplify(sp.expand(w**2))
check("C1 w^2 in Q(i)", sp.simplify(sp.im(w2)).is_rational and sp.simplify(sp.re(w2)).is_rational)
check("C1 w^2 = (2+i)/(2-i)", sp.simplify(w2 - (2 + I) / (2 - I)) == 0)
x = sp.symbols("x")
deg = sp.degree(sp.minimal_polynomial(w, x), x)
check("C1 [Q(w):Q] = 4, so Q(w) = L", deg == 4)


def gauss_val(z, pi):
    """Valuation of the Gaussian rational z at the Gaussian prime pi (exact, via norms and divisibility)."""
    z = sp.nsimplify(z)
    num, den = sp.fraction(sp.together(z))
    # write z = a/b with a in Z[i], b in Z
    re, im = sp.re(z), sp.im(z)
    d = sp.ilcm(sp.fraction(re)[1], sp.fraction(im)[1])
    a = sp.expand(z * d)
    val = 0

    def divides(p, q):
        r = sp.expand(q / p)
        return sp.re(r).is_integer and sp.im(r).is_integer

    while divides(pi, a) and a != 0:
        a = sp.expand(a / pi)
        val += 1
    dd = sp.Integer(d)
    dd_g = dd
    while divides(pi, dd_g):
        dd_g = sp.expand(dd_g / pi)
        val -= 1
    return val


primes = [2 + I, 3 + 2 * I]
Mv = sp.Matrix([[gauss_val(w2, p) for p in primes], [gauss_val(v, p) for p in primes]])
print("   valuation matrix of (w^2, v) at (2+i, 3+2i):", Mv.tolist())
check("C1 w^2, v multiplicatively independent (det != 0)", Mv.det() != 0)

# ---------- C2 ----------
GP = r"""
default(parisize, 10^8);
C = polcompositum(x^3 - 2, x^2 + 1, 1)[1]; L = C[1]; a = C[2];
nf = bnfinit(L, 1);
aut = nfgaloisconj(nf);
sig = 0; for (k = 1, #aut, if (aut[k] != x && Mod(subst(lift(a), x, aut[k]), L) == a, sig = aut[k]));
wmu = nf.tu[1];
fu = nf.fu;
PLANT
out = []; for (k = 1, #fu, e = nfbasistoalg(nf, fu[k]); se = Mod(subst(lift(e), x, sig), L); u = if(pl, e, e / se); nrm = u * Mod(subst(lift(u), x, sig), L); out = concat(out, [[lift(nrm) == 1, u^wmu != 1]]));
print(#aut, " ", wmu, " ", sig != 0, " ", out);
"""
GP2 = GP.replace("x^3 - 2", "x^2 - 2")


def run_gp(src, plant):
    # plant: skip the division by sigma(eps), so u = eps is not norm one (a first plant, eps -> 2*eps, could not fire:
    # 2*eps/sigma(2*eps) = eps/sigma(eps); kept here as the record of a plant that tested nothing)
    src = src.replace("PLANT", "pl = 1;" if plant else "pl = 0;")
    r = subprocess.run(["gp", "-q", "-f"], input=src, capture_output=True, text=True, timeout=120)
    return r.stdout.strip() + r.stderr.strip()


o = run_gp(GP, PLANT == "notnormone")
print("   Q(cbrt2)(i): #Aut(L/Q), #mu_L, [(u*sigma(u)==1, u^#mu != 1) per fundamental unit]:", o)
check("C2 cbrt2: a fundamental unit gives a norm-one non-torsion u", "[1, 1]" in o)
o2 = run_gp(GP2, False)
print("   control Q(sqrt2)(i):", o2)
check("C2 control sqrt2 (totally real): every eps/sigma(eps) torsion", "[1, 1]" not in o2 and "[1, 0]" in o2)

print("ALL CHECKS PASS" if not failures else f"{len(failures)} CHECK(S) FAILED: {failures}")
sys.exit(1 if failures else 0)
