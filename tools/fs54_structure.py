#!/usr/bin/env python3
"""FS-54 D3 — the exact structure of UD(F_27, 2), recomputed from the number 27 and the modulus alone.

F_27 = F_3[t]/(t^3 - t - 1).  A point (x, y) of F_27^2 is a vector of six trits; the vertex index is the repository's
convention (tools/fplane_review_verify.py): x's coefficients then y's, constant coefficient most significant, read in
base 3.  Two points are adjacent iff their difference (dx, dy) has dx^2 + dy^2 = 1.

Prints, each as an assertion that fails loudly:
  1. the edge set and its sha256 (must be b15ae514...; the Python tools' convention);
  2. the triangles: every edge lies in exactly ONE triangle, and every triangle is an F_3-line {z, z+u, z+2u};
  3. the 14 unit directions (the unit circle modulo +-1) form a CAP in PG(5,3): no three are F_3-collinear;
  4. the complete spectrum, the identity lambda_a = 3 m_a - 14 (m_a = directions in the hyperplane a^perp),
     and its agreement with the complex character sums;
  5. the Kloosterman sums over F_27, their congruence K = -1 (mod 3), and that the spectrum is {-K} x 28;
  5b. Moisio's identity in characteristic 3: each eigenvalue is the trace of Frobenius t = 28 - #E(a) of the elliptic
     curve y^2 = x^3 + x^2 - a over F_27, and 3 divides #E(a) for every a, so Hasse (#E <= 28 + 2 sqrt 27 = 38.4) and
     3 | #E give #E <= 36, i.e. lambda_min >= -8 -- attained;
  6. the automorphism group order from nauty's dreadnaut (if installed), against the obvious semi-affine group
     27^2 . |O(2,27)| . |Gal(F_27/F_3)| = 729 * 56 * 3.
Standard library plus numpy.  Run: python3 tools/fs54_structure.py"""
import cmath, collections, hashlib, itertools, shutil, subprocess, sys
import numpy as np

RED = (1, 1, 0)  # t^3 = 1 + t


def fmul(a, b):
    r = [0] * 5
    for i in range(3):
        for j in range(3):
            r[i + j] += a[i] * b[j]
    for d in (4, 3):
        c, r[d] = r[d], 0
        for i in range(3):
            r[d - 3 + i] += c * RED[i]
    return tuple(x % 3 for x in r[:3])


def fadd(a, b):
    return tuple((x + y) % 3 for x, y in zip(a, b))


F = [tuple(c) for c in itertools.product(range(3), repeat=3)]
ONE, ZERO = (1, 0, 0), (0, 0, 0)
U = [x + y for x in F for y in F if fadd(fmul(x, x), fmul(y, y)) == ONE]
V = [tuple(v) for v in itertools.product(range(3), repeat=6)]


def index(v):
    i = 0
    for d in v:
        i = 3 * i + d
    return i


def vadd(a, b):
    return tuple((x + y) % 3 for x, y in zip(a, b))


def vscale(c, a):
    return tuple((c * x) % 3 for x in a)


def check(cond, msg):
    if not cond:
        sys.exit("FAILED: " + msg)
    print("  ok:", msg)


print("1. the graph")
Uset = set(U)
edges = {tuple(sorted((index(v), index(vadd(v, u))))) for v in V for u in U}
h = hashlib.sha256(repr(sorted(edges)).encode()).hexdigest()
check(len(U) == 28 and len(edges) == 10206, f"|unit circle| = {len(U)}, |E| = {len(edges)}")
check(h == "b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d", f"edges_sha256 = {h}")

print("2. triangles")
per_edge = collections.Counter(sum(1 for w in U if vadd(u, vscale(2, w)) in Uset) for u in U)
check(per_edge == {1: 28}, f"third points w (w and u - w both unit) per edge (0, u): {dict(per_edge)} -- exactly one")
check(all(vscale(2, u) in Uset and vscale(2, u) == vscale(-1, u) for u in U),
      "that third point is 2u = -u: every triangle is the F_3-line {0, u, 2u}")
tri = len(edges) // 3
check(tri * 6 == 729 * 28, f"so the 10,206 edges split into {tri} edge-disjoint collinear triangles (729*28/6)")

print("3. the 14 directions are a cap in PG(5,3)")
D = sorted({min(u, vscale(2, u)) for u in U})
check(len(D) == 14, "14 directions (unit circle modulo +-1)")
coll = [(a, b) for a, b in itertools.combinations(D, 2) if vadd(a, b) in Uset or vadd(a, vscale(2, b)) in Uset]
check(not coll, "no two directions a, b with a + b or a - b a unit vector: no three directions collinear")

print("4. spectrum")
Ua, A = np.array(U), np.array(V)
dots = (A @ Ua.T) % 3
m = (dots == 0).sum(axis=1) // 2
lam = 3 * m - 14
lam[0] = 28
complex_sums = np.exp(2j * np.pi * dots / 3).sum(axis=1)
check(np.allclose(complex_sums.imag, 0) and np.allclose(complex_sums.real, lam),
      "eigenvalue at character a equals 3*m_a - 14, m_a = number of directions in the hyperplane a^perp")
spec = sorted(collections.Counter(lam.tolist()).items())
print("  spectrum (eigenvalue, multiplicity):", spec)
check(dict(spec)[-8] == 112 and min(lam) == -8, "lambda_min = -8, multiplicity 112 (56 hyperplanes holding exactly 2 directions)")
check(all(x % 3 == 1 for x in lam), "every eigenvalue is 1 (mod 3); Weil's |lambda| <= 2 sqrt 27 = 10.39 then forces lambda >= -8")


def tr(a):  # absolute trace F_27 -> F_3: a + a^3 + a^9
    a3 = fmul(fmul(a, a), a)
    a9 = fmul(fmul(a3, a3), a3)
    return fadd(fadd(a, a3), a9)[0]


def finv(a):
    return next(b for b in F if fmul(a, b) == ONE)


print("5. Kloosterman sums and the elliptic curves y^2 = x^3 + x^2 - a")
w = cmath.exp(2j * cmath.pi / 3)
K = {c: round(sum(w ** tr(fadd(x, fmul(c, finv(x)))) for x in F if x != ZERO).real) for c in F if c != ZERO}
check(all(k % 3 == 2 for k in K.values()), f"Kloosterman sums over F_27 are all -1 (mod 3): {sorted(collections.Counter(K.values()).items())}")
check(collections.Counter({-k: 28 * n for k, n in collections.Counter(K.values()).items()}) + collections.Counter({28: 1})
      == collections.Counter(lam.tolist()), "the nontrivial spectrum is {-K(c) : c in F_27^*}, each value 28 times")

sqcount = collections.Counter(fmul(y, y) for y in F)
curve = {}
for a in K:
    affine = sum(sqcount[fadd(fadd(fmul(fmul(x, x), x), fmul(x, x)), tuple((-c) % 3 for c in a))] for x in F)
    curve[a] = affine + 1  # projective points
check(all(28 - curve[a] == -K[a] for a in K), "trace of Frobenius of y^2 = x^3 + x^2 - a equals -K(a) for all 26 a (Moisio)")
check(all(curve[a] % 3 == 0 for a in K) and max(curve.values()) == 36,
      f"3 | #E(a) for every a, and the largest curve has {max(curve.values())} points: Hasse allows 38, divisibility caps it at 36, so lambda_min = 28 - 36 = -8")

print("6. automorphisms")
if shutil.which("dreadnaut"):
    adj = collections.defaultdict(list)
    for i, j in edges:
        adj[i].append(j)
        adj[j].append(i)
    inp = "n=729 g\n" + "".join(f"{i}: {' '.join(map(str, sorted(adj[i])))};\n" for i in range(729)) + "x\nq\n"
    out = subprocess.run(["dreadnaut"], input=inp, capture_output=True, text=True).stdout
    size = next(l for l in out.splitlines() if "grpsize" in l)
    print("  dreadnaut:", size.strip())
    check("grpsize=122472;" in size, "|Aut| = 122,472 = 729 * 56 * 3: exactly translations, O(2,27) and the Frobenius, nothing hidden")
else:
    print("  dreadnaut not installed; skipped")
