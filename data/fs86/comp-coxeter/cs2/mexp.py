"""Lower bound for M = Z_2-span{t-1 : t norm-one unit, t = 1 mod P} in O = Z_2[zeta_n] (n = 12 control, n = 24):
v_u = N(u)(t-1) for t = u/conj(u), u = 1 mod P, N(u) odd; report the least c with P^c inside the Z_2-span of the samples."""
import sys, random
from sympy import Matrix, gcd
from math import gcd as igcd
from tower import setup

n = int(sys.argv[1]); random.seed(int(sys.argv[2]) if len(sys.argv) > 2 else 1)
d, mul, power_x, conj = setup(n)
e = 2 if n == 12 else 4
one = [1]+[0]*(d-1)
zeta = power_x(n//8) if n % 8 == 0 else power_x(n//4)
pi = [one[j]-zeta[j] for j in range(d)]
units = [a for a in range(1, n) if igcd(a, n) == 1]
def sigma(v, a):
    r = [0]*d
    for i, c in enumerate(v):
        if c:
            p = power_x(a*i); r = [r[j]+c*p[j] for j in range(d)]
    return r
def ppow(t):
    r = one
    for _ in range(t): r = mul(r, pi)
    return r
def norm(v):
    r = one
    for a in units: r = mul(r, sigma(v, a))
    return r[0]
vecs = []
tries = 0
while len(vecs) < 40:
    tries += 1
    w = [random.randint(-3, 3) for _ in range(d)]
    u = [one[j] + mul(pi, w)[j] for j in range(d)]
    if norm(u) % 2 == 0: continue
    ub = conj(u)
    prod_others = one
    for a in units:
        if a != 1: prod_others = mul(prod_others, sigma(ub, a))
    diff = [u[j]-ub[j] for j in range(d)]
    vecs.append(mul(diff, prod_others))
A = Matrix(vecs).T          # d x N, columns = samples
# Z-row-reduce to a basis via Hermite-like: use smith normal form invariants
from sympy.matrices.normalforms import smith_normal_form
from sympy import ZZ
snf = smith_normal_form(A, domain=ZZ)
invs = [snf[i, i] for i in range(min(snf.shape)) if snf[i, i] != 0]
def v2(x):
    x = abs(int(x)); k = 0
    while x % 2 == 0: x//=2; k+=1
    return k
print("n =", n, "rank =", len(invs), "2-adic elementary divisor exponents:", sorted(v2(x) for x in invs))
# test P^c subset span (over Z_2): solve A X = basis of P^c; need a Z_2-solution. Use column space: P^c in span iff
# the 2-adic SNF of [A | Pc] equals that of A.
for c in range(1, 4*e+1):
    Pc = Matrix([mul(ppow(c), power_x(i)) for i in range(d)]).T
    snf2 = smith_normal_form(A.row_join(Pc), domain=ZZ)
    inv2 = [snf2[i, i] for i in range(min(snf2.shape)) if snf2[i, i] != 0]
    if sorted(v2(x) for x in inv2) == sorted(v2(x) for x in invs):
        print(f"P^{c} is inside the Z_2-span of the samples (so P^{c} ⊆ M); first such c = {c}"); break
    else:
        print(f"P^{c} not inside the samples' span")
