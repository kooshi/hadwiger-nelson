"""FS-73 P3b — standalone checker for route 2's certificate (`tools/fs73_theta_struct.py`): Θ(L21cc6506) = ∅.

Fractions and integers only; imports nothing from this repository; re-derives everything from the lattice key except the
Farkas vectors, which it checks. The argument it checks, with θ ∈ Hom(span U, ℝ) and ⟨μ, x⟩ = μ_p x_p + μ_q x_q:

  R1  U (enumerated here, a third loop order: over (a, c), then b, solving for e) is exactly {b·x : b ∈ B5, x ∈ U_R},
      60 = 5 × 12 distinct products, where U_R = the unit vectors with no √d part and B5 is read from the certificate.
  R2  The certificate's basis spans span U; in its dual coordinates w (periods ℤ⁴), μ_b(w) := (θ(b), θ(b·i)) satisfies
      θ(b·x) = ⟨μ_b(w), x⟩ for every x ∈ U_R (checked on coordinates), μ_1 = 210(w1, w2), μ_v = 5(w3, w4). So
      θ ∈ Θ ⟹ μ_b(w) ∈ Θ_R := {μ : ⟨μ, x⟩ mod 1 ∈ [1/3, 2/3] ∀x ∈ U_R} for every b ∈ B5 (and conversely).
  R3  Θ_R ∩ [0,5)² = c0 + (D0 ∪ F4), c0 = (5/2, 5/2), D0 = {δ : |⟨δ,x⟩| ≤ 1/6 ∀x ∈ U_R}, F4 = {(±5/6, ±5/6)}, by
      enumerating every vertex of the band arrangement (a nonempty cell is a bounded polytope, so it has a vertex; distinct
      bands of one family never touch, so a vertex lies in one cell), and Θ_R is 5ℤ²-periodic.
  R4  Take θ ∈ Θ with w ∈ [0,1)⁴. Then ν = μ_v = c0 + δ2 and μ_1 = c0 + 5k + δ1 with k ∈ {0..41}², δ1, δ2 ∈ D0 ∪ F4 (the
      pieces lie inside (0,5)², so k and the pieces are determined). For each condition b, μ_b(w) − c0 − 5m ∈ piece for some
      (piece, m); since D0 ⊆ [−1/6, 1/6]² (x = (1,0), (0,1) ∈ U_R), (piece, m) is one of the candidates whose box meets the
      exact interval range of μ_b − c0 over the case. For every case and candidate combination this checker derives, the
      certificate must hold a Farkas vector y ≥ 0 over labelled rows A δ ≤ b with yA = 0 and y·b < 0, which it rebuilds and
      checks. So no θ exists: Θ = ∅, and by H-i the lattice's unit-distance graph is not 3-colourable.

Usage: python3 tools/fs73_theta_struct_check.py CERT.json
"""
import itertools
import json
import math
import sys
from fractions import Fraction as Fr

C = json.load(open(sys.argv[1]))
KEY, D = C["key"], int(C["d"])
M = int(KEY.split("|")[0])
H = [list(map(int, r.split(","))) for r in KEY.split("|")[1].split(";")]


def in_H(v):
    v = list(v)
    for i in range(4):
        if v[i] % H[i][i]:
            return False
        q = v[i] // H[i][i]
        v = [v[t] - q * H[i][t] for t in range(4)]
    return not any(v)


# ---- R1 -----------------------------------------------------------------------------------------------------------
U = set()
for a in range(-M, M + 1):
    for c in range(-M, M + 1):
        R = M * M - a * a - c * c
        if R < 0 or R % D:
            continue
        s = R // D
        b = 0
        while b * b <= s:
            e2 = s - b * b
            e = math.isqrt(e2)
            if e * e == e2:
                for bb in {b, -b}:
                    for ee in {e, -e}:
                        if a * bb + c * ee == 0 and in_H((a, bb, c, ee)):
                            U.add((a, bb, c, ee))
            b += 1
UR = sorted(u for u in U if u[1] == 0 and u[3] == 0)


def mul(u, v):
    a1, b1, c1, e1 = u
    a2, b2, c2, e2 = v
    t = [(a1 * a2 + D * b1 * b2) - (c1 * c2 + D * e1 * e2), (a1 * b2 + b1 * a2) - (c1 * e2 + e1 * c2),
         (a1 * c2 + D * b1 * e2) + (c1 * a2 + D * e1 * b2), (a1 * e2 + b1 * c2) + (c1 * b2 + e1 * a2)]
    assert all(x % M == 0 for x in t), "R1: a product b*x is not a point of (1/M)Z^4"
    return tuple(x // M for x in t)


B5 = {n: tuple(b) for n, b in C["B5"].items()}
assert "1" in B5 and "v" in B5 and all(b in U for b in B5.values()), "R1: a rotation is not a unit vector"
prods = [mul(b, x) for b in B5.values() for x in UR]
assert len(set(prods)) == len(prods) == len(U), f"R1: {len(set(prods))} distinct products against {len(U)} unit vectors"
assert set(prods) == U, "R1: the products are not the unit vectors"
print(f"R1 OK: {len(U)} unit vectors = {len(B5)} rotations x {len(UR)} rational unit vectors")


# ---- R2 -----------------------------------------------------------------------------------------------------------
def solve(Brows, v):
    n = len(Brows)
    Mx = [[Fr(Brows[k][i]) for k in range(n)] + [Fr(v[i])] for i in range(n)]
    for col in range(n):
        piv = next(i for i in range(col, n) if Mx[i][col] != 0)
        Mx[col], Mx[piv] = Mx[piv], Mx[col]
        Mx[col] = [t / Mx[col][col] for t in Mx[col]]
        for i in range(n):
            if i != col and Mx[i][col] != 0:
                f = Mx[i][col]
                Mx[i] = [Mx[i][t] - f * Mx[col][t] for t in range(n + 1)]
    return [Mx[i][n] for i in range(n)]


def det4(A):
    A = [[Fr(x) for x in r] for r in A]
    dt = Fr(1)
    for col in range(4):
        piv = next((i for i in range(col, 4) if A[i][col] != 0), None)
        if piv is None:
            return Fr(0)
        if piv != col:
            A[col], A[piv] = A[piv], A[col]
            dt = -dt
        dt *= A[col][col]
        for i in range(col + 1, 4):
            f = A[i][col] / A[col][col]
            A[i] = [A[i][t] - f * A[col][t] for t in range(4)]
    return dt


basis = C["basis"]
coords = {u: solve(basis, u) for u in U}
assert all(t.denominator == 1 for cu in coords.values() for t in cu), "R2: a unit vector is not in the basis lattice"
g = 0
for q in itertools.combinations(sorted(coords), 4):
    g = math.gcd(g, int(abs(det4([coords[u] for u in q]))))
    if g == 1:
        break
assert g == 1, "R2: the unit vectors do not span the basis lattice"
I = (0, 0, M, 0)
Mb = {n: [solve(basis, b), solve(basis, mul(b, I))] for n, b in B5.items()}
for n, b in B5.items():
    for x in UR:
        xr, xi = Fr(x[0], M), Fr(x[2], M)
        assert solve(basis, mul(b, x)) == [xr * Mb[n][0][k] + xi * Mb[n][1][k] for k in range(4)], "R2: not linear"
assert Mb["1"] == [[210, 0, 0, 0], [0, 210, 0, 0]] and Mb["v"] == [[0, 0, 5, 0], [0, 0, 0, 5]], "R2: frame"
assert M == 420
print("R2 OK: basis spans span U; mu_1 = 210 (w1,w2), mu_v = 5 (w3,w4); theta(b x) = <mu_b, x>")

# ---- R3 -----------------------------------------------------------------------------------------------------------
X = [(Fr(u[0], M), Fr(u[2], M)) for u in UR]
dot = lambda m, x: m[0] * x[0] + m[1] * x[1]
inband = lambda t: Fr(1, 3) <= t - math.floor(t) <= Fr(2, 3)
lines = []
for (a, b) in X:
    vals = [a * p + b * q for p in (0, 5) for q in (0, 5)]
    for k in range(math.floor(3 * min(vals)) - 1, math.ceil(3 * max(vals)) + 2):
        if k % 3:
            lines.append((a, b, Fr(k, 3)))
V = set()
for (a1, b1, c1), (a2, b2, c2) in itertools.combinations(lines, 2):
    dt = a1 * b2 - a2 * b1
    if dt:
        p, q = (c1 * b2 - c2 * b1) / dt, (a1 * c2 - a2 * c1) / dt
        if 0 <= p < 5 and 0 <= q < 5 and all(inband(dot((p, q), x)) for x in X):
            V.add((p, q))
c0 = (Fr(5, 2), Fr(5, 2))
assert all(dot(c0, x) - math.floor(dot(c0, x)) == Fr(1, 2) for x in X)
F4 = [(Fr(5, 6), Fr(5, 6)), (Fr(5, 6), Fr(-5, 6)), (Fr(-5, 6), Fr(5, 6)), (Fr(-5, 6), Fr(-5, 6))]
near = [v for v in V if abs(v[0] - c0[0]) <= Fr(1, 6) and abs(v[1] - c0[1]) <= Fr(1, 6)]
assert all(max(abs(dot((v[0] - c0[0], v[1] - c0[1]), x)) for x in X) <= Fr(1, 6) for v in near)
assert sorted((v[0] - c0[0], v[1] - c0[1]) for v in V if v not in near) == sorted(F4), "R3: unexpected vertices"
# each isolated point is a whole cell: its band square lies inside (0,5)^2 and holds no other vertex
for f in F4:
    pt = (c0[0] + f[0], c0[1] + f[1])
    sq = [(math.floor(t) + Fr(1, 3), math.floor(t) + Fr(2, 3)) for t in pt]
    assert all(0 < lo and hi < 5 for lo, hi in sq)
    assert [v for v in V if sq[0][0] <= v[0] <= sq[0][1] and sq[1][0] <= v[1] <= sq[1][1]] == [pt]
# every vertex near c0 is in c0's cell (the same band for each x), so that cell is c0 + D0 and holds them all
assert all(math.floor(dot(v, x)) == math.floor(dot(c0, x)) for v in near for x in X)
print(f"R3 OK: Theta_R = c0 + (D0 u F4) + 5Z^2 ({len(near)} vertices of D0, 4 isolated points)")

# ---- R4 -----------------------------------------------------------------------------------------------------------
pieces = {"D0": ((Fr(-1, 6), Fr(-1, 6)), (Fr(1, 6), Fr(1, 6)))}
for t, f in enumerate(F4):
    pieces[f"F{t}"] = (f, f)
# the route-2 file names F-pieces by its own order of F4: (5/6,5/6),(5/6,-5/6),(-5/6,5/6),(-5/6,-5/6) — same as here
conds = C["conditions"]
assert set(conds) <= set(B5) - {"1", "v"} and conds
cert = {}
for e in C["farkas_certificates"]:
    cert[(tuple(e["case"]), tuple((n, tuple(e["targets"][n])) for n in conds))] = e["farkas"]
Jac = [[Fr(1, 210), 0, 0, 0], [0, Fr(1, 210), 0, 0], [0, 0, Fr(1, 5), 0], [0, 0, 0, Fr(1, 5)]]
checked = cases = survivors = 0
for k1 in range(42):
    for k2 in range(42):
        for p1 in pieces:
            for p2 in pieces:
                cases += 1
                w0 = [(c0[0] + 5 * k1) / 210, (c0[1] + 5 * k2) / 210, c0[0] / 5, c0[1] / 5]
                lo = [pieces[p1][0][0], pieces[p1][0][1], pieces[p2][0][0], pieces[p2][0][1]]
                hi = [pieces[p1][1][0], pieces[p1][1][1], pieces[p2][1][0], pieces[p2][1][1]]
                aff, cand = {}, {}
                for n in conds:
                    G = [[sum(Mb[n][ax][t] * Jac[t][s] for t in range(4)) for s in range(4)] for ax in range(2)]
                    h = [sum(Mb[n][ax][t] * w0[t] for t in range(4)) - c0[ax] for ax in range(2)]
                    rlo = [h[ax] + sum(min(G[ax][s] * lo[s], G[ax][s] * hi[s]) for s in range(4)) for ax in range(2)]
                    rhi = [h[ax] + sum(max(G[ax][s] * lo[s], G[ax][s] * hi[s]) for s in range(4)) for ax in range(2)]
                    aff[n] = (G, h)
                    cand[n] = [(pc, m0, m1) for pc, (plo, phi) in pieces.items()
                               for m0 in range(math.floor((rlo[0] - phi[0]) / 5) - 1, math.ceil((rhi[0] - plo[0]) / 5) + 2)
                               for m1 in range(math.floor((rlo[1] - phi[1]) / 5) - 1, math.ceil((rhi[1] - plo[1]) / 5) + 2)
                               if plo[0] + 5 * m0 <= rhi[0] and phi[0] + 5 * m0 >= rlo[0]
                               and plo[1] + 5 * m1 <= rhi[1] and phi[1] + 5 * m1 >= rlo[1]]
                if any(not cand[n] for n in conds):
                    continue
                survivors += 1
                for combo in itertools.product(*[cand[n] for n in conds]):
                    y = cert.get(((k1, k2, p1, p2), tuple((n, tuple(t)) for n, t in zip(conds, combo))))
                    assert y is not None, f"no certificate for case {(k1, k2, p1, p2)} targets {combo}"
                    target = {"d1": (p1, 0, 0), "d2": (p2, 0, 0)}
                    E = [[Fr(int(s == i)) for s in range(4)] for i in range(4)]
                    maps = {"d1": ([E[0], E[1]], [Fr(0), Fr(0)]), "d2": ([E[2], E[3]], [Fr(0), Fr(0)])}
                    for n, t in zip(conds, combo):
                        target[n] = t
                        maps[n] = aff[n]
                    sumA, sumb = [Fr(0)] * 4, Fr(0)
                    for lab in y:
                        who, kind, val = lab[0], lab[1], Fr(lab[-1])
                        assert val > 0 and who in target
                        pc, m0, m1 = target[who]
                        G, h = maps[who]
                        gh = [h[0] - 5 * m0, h[1] - 5 * m1]           # g(δ) = G δ + gh, required in the piece
                        if kind == "x":
                            assert pc == "D0" and (lab[2], 0, lab[3], 0) in U
                            xa, xb = Fr(lab[2], M), Fr(lab[3], M)       # <g, x> <= 1/6
                            row = [xa * G[0][s] + xb * G[1][s] for s in range(4)]
                            rhs = Fr(1, 6) - (xa * gh[0] + xb * gh[1])
                        else:
                            assert kind == "pt" and pc != "D0"
                            ax, sg = lab[2], lab[3]
                            assert ax in (0, 1) and sg in (1, -1)
                            f = pieces[pc][0]
                            row = [sg * G[ax][s] for s in range(4)]     # sg (g_ax - f_ax) <= 0
                            rhs = -sg * (gh[ax] - f[ax])
                        sumA = [sumA[s] + val * row[s] for s in range(4)]
                        sumb += val * rhs
                    assert all(t == 0 for t in sumA) and sumb < 0, f"Farkas vector fails at {(k1, k2, p1, p2)} {combo}"
                    checked += 1
print(f"R4 OK: {cases} cases, {survivors} survive the bounding boxes, {checked} candidate combinations each refuted"
      f" by a checked Farkas vector (conditions {conds})")
print("STRUCT CERTIFICATE OK => Theta EMPTY (by H-i the graph is not 3-colourable)")
