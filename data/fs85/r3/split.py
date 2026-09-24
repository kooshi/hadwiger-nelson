"""FS-85 R3: the exact facts the 5-part argument uses, each computed from its definition (no colouring enumerated).
F1  Theta_all (characters of Lambda/8Lambda in every Z_k, k = -4..4) has 42 elements, and the characters of order | 8 in
    Z_k for |k| <= 2 alone are the same 42 (so the 2-power part of the 90 on Lambda5 is Theta_all).
F2  beta = (5 + sqrt33)/2 = 2 + z + w - 2zw generates a prime above 2 (norm 4); P+ = (1/9) beta^3 O, P- = (1/9) beta'^3 O.
    [Lambda:P+] = [Lambda:P-] = 64, P+ + P- = Lambda, P+ cap P- = 8 Lambda.
F3  Theta_all = C+ disjoint-union C-, C+- = Theta_all cap Ann(P+-), 21 each.
F4  The six order-2 characters of Theta_all: three in C+, three in C-, each triple summing to 0; the pair (pi1, pi2) of a triple
    takes all three nonzero values on U_{|k|<=2}.
F5  For each admissible pi, Phi_pi = two lines of the dual F5^4; the six lines at one chirality are distinct; the three planes
    Pi_pi = span(lines) at one chirality are pairwise distinct (dim of pairwise sums reported)."""
import itertools, os, collections
PLANT = os.environ.get("PLANT", "")
from fractions import Fraction as Fr
from lat import UNITS, mul, ONE, Z, W, c9, add, sc, neg, conj
from phi import ADM, phi, dot

FAM = {k: [UNITS[(j, k)] for j in range(3)] for k in range(-4, 5)}
T8 = list(itertools.product(range(8), repeat=4))

def in_Z(t, k, m=8):
    return any(dot(t, u, m) == m // 2 for u in FAM[k])

theta_all = [t for t in T8 if all(in_Z(t, k) for k in range(-4, 5))]
theta_25 = [t for t in T8 if all(in_Z(t, k) for k in range(-2, 3))]
print("F1 |Theta_all| =", len(theta_all), "; order|8 characters in Z_k for |k|<=2:", len(theta_25),
      "; equal sets:", set(theta_all) == set(theta_25))
assert len(theta_all) == 42 and set(theta_all) == set(theta_25)

# F2
def E(a, b, c, d): return (Fr(a), Fr(b), Fr(c), Fr(d))
beta = E(2, 1, 1, -2)
betap = conj(beta)   # conj fixes sqrt33? check below: we need the Galois conjugate sqrt33 -> -sqrt33 instead
# sqrt33 = -(2z-1)(2w-1); sqrt33 -> -sqrt33 is sig3 (sqrt-3 -> -sqrt-3, sqrt-11 fixed): z -> 1-z, w -> w
def sig3(p):
    a, b, c, d = p
    return (a + b, -b, c + d, -d)
s33 = neg(mul(add(sc(2, Z), neg(ONE)), add(sc(2, W), neg(ONE))))
assert mul(s33, s33) == E(33, 0, 0, 0)
assert beta == sc(Fr(1, 2), add(E(5, 0, 0, 0), s33)), "beta = (5+sqrt33)/2"
betap = sig3(beta)
assert betap == sc(Fr(1, 2), add(E(5, 0, 0, 0), neg(s33)))
assert mul(beta, betap) == E(-2, 0, 0, 0)
basis = [E(1, 0, 0, 0), E(0, 1, 0, 0), E(0, 0, 1, 0), E(0, 0, 0, 1)]
def gens(gamma):   # coords9 generators of (1/9) gamma O
    return [tuple(int(x) for x in mul(gamma, e)) for e in basis]
b3 = mul(mul(beta, beta), beta); bp3 = mul(mul(betap, betap), betap)
if PLANT == "P1": b3 = mul(beta, beta); bp3 = mul(betap, betap)     # planted: squares, not cubes
Pp = gens(b3); Pm = gens(bp3)
from sympy import Matrix
def idx(rows): return abs(Matrix(rows).det())
def hnf_index(rows):
    from sympy.matrices.normalforms import smith_normal_form
    from sympy import ZZ
    S = smith_normal_form(Matrix(rows), domain=ZZ)
    d = 1
    for i in range(4): d *= S[i, i]
    return abs(d)
print("F2 [Lambda:P+] =", idx(Pp), " [Lambda:P-] =", idx(Pm), " [Lambda : P+ + P-] =", hnf_index(Pp + Pm))
assert idx(Pp) == 64 and idx(Pm) == 64 and hnf_index(Pp + Pm) == 1
# P+ cap P- = 8 Lambda: both contain 8 Lambda (8 = -beta^3 beta'^3) and index count 64*64 = 4096 = [Lambda:8Lambda]
assert mul(b3, bp3) == E(-8, 0, 0, 0)

# F3
def ann(t, P): return all(dot(t, g, 8) == 0 for g in P)
Cp = [t for t in theta_all if ann(t, Pp)]; Cm = [t for t in theta_all if ann(t, Pm)]
print("F3 |C+| =", len(Cp), " |C-| =", len(Cm), " disjoint:", not set(Cp) & set(Cm),
      " union = Theta_all:", set(Cp) | set(Cm) == set(theta_all))
assert len(Cp) == 21 and len(Cm) == 21 and set(Cp) | set(Cm) == set(theta_all) and not set(Cp) & set(Cm)

# F4
def ord2(C): return [tuple(x // 4 for x in t) for t in C if all(x % 4 == 0 for x in t)]
O2p, O2m = ord2(Cp), ord2(Cm)
print("F4 order-2 in C+:", O2p, " in C-:", O2m)
assert sorted(O2p + O2m) == sorted(ADM)
for O in (O2p, O2m):
    assert len(O) == 3 and all(sum(col) % 2 == 0 for col in zip(*O))
    vals = {(dot(O[0], u, 2), dot(O[1], u, 2)) for k in range(-2, 3) for u in FAM[k]}
    assert vals == {(0, 1), (1, 0), (1, 1)}, vals

# F5
import collections
def rank5(vecs):
    M = [list(v) for v in vecs]; r = 0; cols = 4
    for c in range(cols):
        piv = next((i for i in range(r, len(M)) if M[i][c] % 5), None)
        if piv is None: continue
        M[r], M[piv] = M[piv], M[r]
        inv = pow(M[r][c], -1, 5); M[r] = [(x * inv) % 5 for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c] % 5:
                f = M[i][c]; M[i] = [(x - f * y) % 5 for x, y in zip(M[i], M[r])]
        r += 1
    return r
def lines(pi):
    P = phi(pi)
    L = sorted({min(tuple((c * x) % 5 for x in t) for c in range(1, 5)) for t in P})
    # Phi is exactly the nonzero points of these lines
    pts = {tuple((c * x) % 5 for x in l) for l in L for c in range(1, 5)}
    assert pts == set(P), "Phi is not a union of full lines"
    return L
for name, O in (("C+", O2p), ("C-", O2m)):
    Ls = {pi: lines(pi) for pi in O}
    if PLANT == "P2": Ls[O[1]] = [Ls[O[0]][0], Ls[O[1]][1]]          # planted: a shared line
    if PLANT == "P3":                                               # planted: a shared plane, lines still distinct
        a, b = Ls[O[0]]; Ls[O[1]] = [tuple((x + y) % 5 for x, y in zip(a, b)), tuple((x + 2*y) % 5 for x, y in zip(a, b))]
    allL = [l for pi in O for l in Ls[pi]]
    assert all(len(Ls[pi]) == 2 and rank5(Ls[pi]) == 2 for pi in O)
    distinct = len({l for l in allL}) == 6 and all(rank5([a, b]) == 2 for a, b in itertools.combinations(allL, 2))
    pair = {(i, j): rank5(Ls[O[i]] + Ls[O[j]]) for i, j in itertools.combinations(range(3), 2)}
    print("F5", name, "lines:", {pi: Ls[pi] for pi in O})
    print("    six lines pairwise distinct:", distinct, "; dim(Pi_i + Pi_j):", pair, "; dim of all six:", rank5(allL))
    assert distinct, "two of the six lines coincide"
    assert all(v == 4 for v in pair.values()), "two planes meet in more than 0"
print("ALL CHECKS PASS")

# F0  Lambda5 = <U_{|k|<=2}> has index 81 in Lambda (prime to 40), and its quotient is (Z/3)^4
from sympy.matrices.normalforms import smith_normal_form
from sympy import ZZ
L5rows = [list(UNITS[(j, k)]) for j in range(6) for k in range(-2, 3)]
S = smith_normal_form(Matrix(L5rows), domain=ZZ)
inv = [abs(S[i, i]) for i in range(4)]
print("F0 Smith invariants of Lambda/Lambda5:", inv)
assert sorted(inv) == [3, 3, 3, 3]
ind = 1
for x in inv: ind *= x
assert ind % 2 and ind % 5, ind

# F6  the characters of order | 40 in Z_k for all |k| <= 2 (acting on coords9): exactly 42 + 48, and every order-10 one is
#     pi/2 + theta5 with pi admissible (so its 2-part is one of the six order-2 characters of Theta_all)
T5 = list(itertools.product(range(5), repeat=4))
cnt = collections.Counter(); twoparts = set()
for t8 in T8:
    J = [[u for u in FAM[k] if dot(t8, u, 8) == 4] for k in (range(-2, 3) if PLANT != "P4" else (-2, -1, 1, 2))]
    if not all(J): continue
    for t5 in T5:
        if all(any(dot(t5, u, 5) == 0 for u in Jk) for Jk in J):
            o8 = max((8 // __import__('math').gcd(8, *[x for x in t8])) if any(t8) else 1, 1)
            o = o8 * (5 if any(t5) else 1)
            cnt[o] += 1
            if any(t5): twoparts.add(tuple(x // 4 if x % 4 == 0 else None for x in t8))
print("F6 orders of the order|40 characters of Theta_{-2..2}:", dict(sorted(cnt.items())), " 2-parts of the 5-part:", sorted(twoparts))
assert sum(cnt.values()) == 90 and cnt[10] == 48 and sorted(twoparts) == sorted(ADM)
print("F0, F6 PASS")
