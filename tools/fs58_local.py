#!/usr/bin/env python3
"""fs58_local -- FS-58's opening measurements: the local picture of ℚ(√d)² at the split places 3 and 2, and a probe of
the chain target (a pair forced equal at three colours) on word balls.

Plan: plans/FS58-four-colours.md §0. Outputs: data/fs58/opening/. UNTRUSTED like everything in tools/: exact integer
arithmetic for every graph and every colouring; character means are floats (exponential sums), reported as readings.

  tower              the plane S_1 = Cay(𝔽₉², C) with C the 8-point circle x² + y² = 1 (the residue plane of ℚ(√d) at 3 for
                     every d ≡ 2 (mod 3)): its spectrum, its 3-tightness, every proper 3-colouring (origin 0, one neighbour 1)
                     and whether each is affine; then the unit circle of (O/3^m)², O = ℤ₃[i], m = 1, 2, 3: the least character
                     mean over all characters, how many reach −1/2, and the least over characters primitive at level m
  split-means P LEV  Tamagawa-weighted character means ψ(αt + β/t) on the split circle over ℚ_P(i) (P ≡ 3 mod 4 inert,
                     residue 𝔽_{P²}), characters of level ≤ LEV, t ∈ ⊔ shells P^k O^×, weight dt / max(1, |t|)²
  dyadic-means L     the same over ℚ₂(i) (ℚ(√d)'s dyadic completion when −d ≡ 1 mod 8), weight dt / max(|t²+1|, |t²−1|, |2t|)
                     (4 on units), characters α, β ∈ 2^−L O
  balls N R PAIRS    the Cayley ball of radius R of W_N (unit vectors of ℚ(√167)(i) with denominator dividing N): points,
                     edges, 3-colourability, and for up to PAIRS pairs (p, p + 3u), u ∈ W_N, p at word depth ≤ 1, whether the
                     pair is forced equal at three colours (incremental CaDiCaL with one selector per pair)
  tensor Q           the tensor product S_1 × P_Q of the 3-adic residue plane (Cay(𝔽₉², 8-point circle)) with the residue plane
                     P_Q = Cay(𝔽_Q², circle) at a prime Q: is there a 3-colouring with f(0, 0) ≠ f(0, e) for some e ≠ 0, i.e.
                     one not pulled back from S_1? (Q = 3 is the positive control: P_3 is 3-colourable.) Separable colourings
                     are verified on every edge
  counts             unit vectors of ℚ(√d)(i) outside ℚ(i) by denominator, for d = 11, 23, 167
  circles D N DRAWS  independent triples U = {0, a, b} (a, b sums of 1–3 directions of W_N over ℚ(√D), no unit distance inside
                     U): is the unit-distance graph on the union of the unit circles about U, directions W_N, non-bipartite?
                     (FS-58 §2 D7; run D = 3 as the positive control)
"""
import cmath
import itertools
import random
import sys
import time
from pathlib import Path

import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))


# ---------------------------------------------------------------- tower
def cmd_tower():
    from pysat.solvers import Cadical153
    F = [(a, b) for a in range(3) for b in range(3)]
    add = lambda u, v: ((u[0] + v[0]) % 3, (u[1] + v[1]) % 3)
    mul = lambda u, v: ((u[0] * v[0] - u[1] * v[1]) % 3, (u[0] * v[1] + u[1] * v[0]) % 3)
    C = [(x, y) for x in F for y in F if add(mul(x, x), mul(y, y)) == (1, 0)]
    V = [(x, y) for x in F for y in F]
    idx = {v: i for i, v in enumerate(V)}
    w3 = cmath.exp(2j * cmath.pi / 3)
    eig = [round(sum(w3 ** ((2 * mul(a[0], c[0])[0] + 2 * mul(a[1], c[1])[0]) % 3) for c in C).real, 9) for a in V]
    spectrum = {v: eig.count(v) for v in sorted(set(eig))}
    lmin, d = min(eig), len(C)
    print(f"S_1 = Cay(F_9^2, C): |C| = {d}; spectrum {spectrum}")
    print(f"  lambda_min = {lmin}; 3-tight iff lambda_min = -d/2 = {-d / 2}: {lmin == -d / 2}; "
          f"Hoffman alpha <= {81 * -lmin / (d - lmin)} against 81/3 = 27")
    var = lambda v, c: 3 * v + c + 1
    s = Cadical153()
    for v in range(81):
        s.add_clause([var(v, c) for c in range(3)])
        for c in range(3):
            for c2 in range(c + 1, 3):
                s.add_clause([-var(v, c), -var(v, c2)])
        for w in C:
            u = idx[(add(V[v][0], w[0]), add(V[v][1], w[1]))]
            if u > v:
                for c in range(3):
                    s.add_clause([-var(v, c), -var(u, c)])
    s.add_clause([var(0, 0)])
    s.add_clause([var(idx[C[0]], 1)])
    cols = []
    while s.solve():
        m = s.get_model()
        col = [next(c for c in range(3) if m[var(v, c) - 1] > 0) for v in range(81)]
        for v in range(81):
            for w in C:
                assert col[v] != col[idx[(add(V[v][0], w[0]), add(V[v][1], w[1]))]], 'INSTRUMENT CATASTROPHE: improper model'
        cols.append(col)
        s.add_clause([-var(v, col[v]) for v in range(81)])
    coords = lambda v: (v[0][0], v[0][1], v[1][0], v[1][1])
    forms = [f for f in itertools.product(range(3), repeat=4) if any(f)]

    def affine(col):
        for f in forms:
            mp = {}
            if all(mp.setdefault(sum(a * b for a, b in zip(f, coords(v))) % 3, col[idx[v]]) == col[idx[v]] for v in V):
                if len(set(mp.values())) == 3:
                    return True
        return False
    print(f"  proper 3-colourings with the origin 0 and neighbour {C[0]} 1: {len(cols)} (exhaustive); "
          f"affine x -> sigma(L(x)): {sum(map(affine, cols))}")
    for m in (1, 2, 3):
        M = 3 ** m
        pts = set()
        inv2 = pow(2, -1, M)
        for t0, t1 in itertools.product(range(M), repeat=2):
            if t0 % 3 == 0 and t1 % 3 == 0:
                continue
            ni = pow((t0 * t0 + t1 * t1) % M, -1, M)
            i0, i1 = t0 * ni % M, -t1 * ni % M
            x = ((t0 + i0) * inv2 % M, (t1 + i1) * inv2 % M)
            dd = ((t0 - i0) * inv2 % M, (t1 - i1) * inv2 % M)
            y = (dd[1] % M, -dd[0] % M)
            assert (x[0] ** 2 - x[1] ** 2 + y[0] ** 2 - y[1] ** 2) % M == 1 and (2 * x[0] * x[1] + 2 * y[0] * y[1]) % M == 0
            pts.add((x[0], x[1], y[0], y[1]))
        P = np.array(sorted(pts))
        A = np.array(list(itertools.product(range(M), repeat=4)))
        means = np.zeros(len(A))
        for j in range(0, len(A), 20000):
            a = A[j:j + 20000]
            ph = 2 * (np.outer(a[:, 0], P[:, 0]) - np.outer(a[:, 1], P[:, 1]) + np.outer(a[:, 2], P[:, 2])
                      - np.outer(a[:, 3], P[:, 3])) % M
            means[j:j + 20000] = np.cos(2 * np.pi * ph / M).mean(axis=1)
        nonzero = np.arange(len(A)) > 0
        prim = (A % 3).any(axis=1) if m > 1 else nonzero
        print(f"  level m={m}: |circle| = {len(P)}; least mean over nonzero characters {means[nonzero].min():.6f}; "
              f"characters at exactly -1/2: {int((np.abs(means + 0.5) < 1e-9).sum())}; "
              f"least over level-{m}-primitive: {means[prim & nonzero].min():.6f}")


# ---------------------------------------------------------------- split-means
def cmd_split_means(p, lev):
    q = p * p

    def units(L):
        M = p ** L
        a, b = np.divmod(np.arange(M * M), M)
        u = ((a % p) != 0) | ((b % p) != 0)
        a, b = a[u], b[u]
        n = (a * a + b * b) % M
        e = (p - 1) * p ** (L - 1) - 1
        r, base = np.ones_like(n), n.copy()
        while e:
            if e & 1:
                r = (r * base) % M
            base, e = (base * base) % M, e >> 1
        return a, b, (a * r) % M, (-b * r) % M
    shells = {k: units(max(lev + abs(k), 1)) for k in range(-(lev + 1), lev + 2)}
    mass = lambda k: (1 - 1 / q) * q ** (-abs(k)) / (1 + 1 / q)
    tail = lambda k0: q ** (-k0) * q / (q + 1)

    def mean(al, be):
        tot = 0.0
        for k, (sa, sb, ia, ib) in shells.items():
            D = p ** (lev + abs(k))
            e1, e2 = k - lev, -k - lev
            n1 = 0 if e1 >= 0 else ((al[0] * sa - al[1] * sb) * p ** (lev + abs(k) + e1)) % D
            n2 = 0 if e2 >= 0 else ((be[0] * ia - be[1] * ib) * p ** (lev + abs(k) + e2)) % D
            ph = (2 * (n1 + n2)) % D
            cnt = np.bincount(np.broadcast_to(ph, sa.shape), minlength=D)
            tot += mass(k) * float((cnt * np.cos(2 * np.pi * np.arange(D) / D)).sum() / sa.size)
        return tot + tail(lev + 2) * ((be == (0, 0)) + (al == (0, 0)))
    res = []
    for al in [(0, 0)] + [(p ** j, 0) for j in range(lev)]:        # t -> ct normalises alpha by units
        for be in itertools.product(range(p ** lev), repeat=2):
            if al != (0, 0) or be != (0, 0):
                res.append((mean(al, be), al, be))
    res.sort()
    print(f"split circle over Q_{p}(i) (residue F_{q}), characters of level <= {lev}, Tamagawa weights: least means")
    for r in res[:4]:
        print("  %.6f  alpha=%s beta=%s" % r)


# ---------------------------------------------------------------- dyadic-means
def cmd_dyadic_means(L):
    kmax = 2 * L + 2

    def units(m):
        M = 2 ** m
        a, b = np.divmod(np.arange(M * M, dtype=np.int64), M)
        u = ((a + b) % 2) == 1
        a, b = a[u], b[u]
        n = (a * a + b * b) % M
        e = 2 ** (m - 1) - 1 if m > 1 else 0
        r, base = np.ones_like(n), n.copy()
        while e:
            if e & 1:
                r = (r * base) % M
            base, e = (base * base) % M, e >> 1
        return M, a, b, (a * r) % M, (-b * r) % M

    def gpow(z, k, M):
        r = (1, 0)
        for _ in range(k):
            r = ((r[0] * z[0] - r[1] * z[1]) % M, (r[0] * z[1] + r[1] * z[0]) % M)
        return r
    cache = {}

    def shell_avg(A, B, k):                     # t = pi^k s, pi = 1 + i; numerator over 2^(L+k)
        m = L + k + 2
        if m not in cache:
            cache[m] = units(m)
        M, sa, sb, ia, ib = cache[m]
        D = 2 ** (L + k)
        pk, pbk = gpow((1, 1), k, M), gpow((1, -1), k, M)
        c1 = ((A[0] * pk[0] - A[1] * pk[1]) * 2 ** k % M, (A[0] * pk[1] + A[1] * pk[0]) * 2 ** k % M)
        c2 = ((B[0] * pbk[0] - B[1] * pbk[1]) % M, (B[0] * pbk[1] + B[1] * pbk[0]) % M)
        ph = ((2 * (c1[0] * sa - c1[1] * sb + c2[0] * ia - c2[1] * ib)) % D).astype(np.int64)
        cnt = np.bincount(ph, minlength=D)
        return float((cnt * np.cos(2 * np.pi * np.arange(D) / D)).sum() / sa.size)
    mass = lambda k: (4 if k == 0 else 1) * 2.0 ** (-abs(k) - 1) / 3.0   # total 3 before normalising

    def mean(A, B):                              # shells k < 0 by t -> 1/t, which swaps alpha and beta
        return mass(0) * shell_avg(A, B, 0) + sum(mass(k) * (shell_avg(A, B, k) + shell_avg(B, A, k))
                                                  for k in range(1, kmax + 1))
    R = list(itertools.product(range(2 ** (L + 1)), repeat=2))
    res = {}
    for A in R:
        for B in R:
            if A != (0, 0) or B != (0, 0):
                res.setdefault(round(mean(A, B), 9), (A, B))
    print(f"dyadic circle over Q_2(i), characters alpha, beta in 2^-{L} O, canonical weights (unit shell mass 2/3); "
          f"shells |k| <= {kmax}, omitted tail mass {2 * 2.0 ** (-kmax - 1) / 3:.4f}: least means")
    for v in sorted(res)[:4]:
        print("  %.6f  A=%s B=%s" % (v, *res[v]))


# ---------------------------------------------------------------- balls
def cmd_balls(N, R, maxpairs):
    from pysat.solvers import Cadical153
    from fs56_low_height import units
    W = units(N)
    add = lambda p, q: tuple(x + y for x, y in zip(p, q))
    V, order, depth, frontier = {(0, 0, 0, 0): 0}, [(0, 0, 0, 0)], [0], [(0, 0, 0, 0)]
    for r in range(R):
        nxt = []
        for p in frontier:
            for w in W:
                q = add(p, w)
                if q not in V:
                    V[q] = len(order)
                    order.append(q)
                    depth.append(r + 1)
                    nxt.append(q)
        frontier = nxt
    E = {(i, j) for i, p in enumerate(order) for w in W if (j := V.get(add(p, w))) is not None and j > i}
    n = len(order)
    print(f"N={N} |W|={len(W)} word radius {R}: {n} points, {len(E)} edges, mean degree {2 * len(E) / n:.2f}")
    var = lambda v, c: 3 * v + c + 1
    s = Cadical153()
    for v in range(n):
        s.add_clause([var(v, c) for c in range(3)])
    for a, b in E:
        for c in range(3):
            s.add_clause([-var(a, c), -var(b, c)])
    a0, b0 = min(E)
    s.add_clause([var(a0, 0)])
    s.add_clause([var(b0, 1)])
    t = time.time()
    if not s.solve():
        print(f"  NOT 3-colourable (solver claim, unchecked; {time.time() - t:.1f} s)")
        return
    m = s.get_model()
    col = [next(c for c in range(3) if m[var(v, c) - 1] > 0) for v in range(n)]
    assert all(col[a] != col[b] for a, b in E), 'INSTRUMENT CATASTROPHE: improper model'
    print(f"  3-colourable, model verified on every edge ({time.time() - t:.1f} s)")
    pairs = sorted({(min(i, j), max(i, j)) for i, p in enumerate(order) if depth[i] <= 1 for u in W
                    if (j := V.get(add(p, tuple(3 * x for x in u)))) is not None})
    random.seed(1)
    random.shuffle(pairs)
    pairs = pairs[:maxpairs]
    open_ = [pq for pq in pairs if col[pq[0]] == col[pq[1]]]
    nextvar, forced = 3 * n + 1, 0
    if open_:                                    # positive control: a planted abstract rhombus must read as forced
        i, j = open_[0]
        x, y = n, n + 1
        cl = [[var(v, c) for c in range(3)] for v in (x, y)]
        cl += [[-var(a, c), -var(b, c)] for a, b in ((x, y), (x, i), (x, j), (y, i), (y, j)) for c in range(3)]
        for c_ in cl:
            s.add_clause(c_ + [-(3 * (n + 2) + 1)])   # guarded by a control selector
        g = 3 * (n + 2) + 1
        for c in range(3):
            s.add_clause([-(g + 1), -var(i, c), -var(j, c)])
        control_forced = not s.solve(assumptions=[g, g + 1])
        control_free = s.solve(assumptions=[g + 1])
        print(f"  control: planted rhombus on one open pair reads forced = {control_forced}; unplanted reads separable = {control_free}")
        assert control_forced and control_free, 'CONTROL FAILED: the forcing probe cannot see a planted forced pair'
        nextvar = g + 2
    for i, j in open_:
        for c in range(3):
            s.add_clause([-nextvar, -var(i, c), -var(j, c)])
        if not s.solve(assumptions=[nextvar]):
            forced += 1
        else:                                    # a separable verdict is certified by its colouring, checked here
            m = s.get_model()
            c2 = [next(c for c in range(3) if m[var(v, c) - 1] > 0) for v in range(n)]
            assert all(c2[a] != c2[b] for a, b in E) and c2[i] != c2[j], 'INSTRUMENT CATASTROPHE: separating model fails'
        nextvar += 1
    print(f"  pairs (p, p + 3u) with p at depth <= 1: {len(pairs)} asked; Separable (colouring verified): {len(pairs) - forced} "
          f"({len(pairs) - len(open_)} by the first model); Forced (solver claim): {forced}")


# ---------------------------------------------------------------- tensor
def cmd_tensor(q):
    from pysat.solvers import Cadical153
    add9 = lambda u, v: ((u[0] + v[0]) % 3, (u[1] + v[1]) % 3)
    mul9 = lambda u, v: ((u[0] * v[0] - u[1] * v[1]) % 3, (u[0] * v[1] + u[1] * v[0]) % 3)
    F9 = [(a, b) for a in range(3) for b in range(3)]
    V3 = [(x, y) for x in F9 for y in F9]
    C3 = [(x, y) for x, y in V3 if add9(mul9(x, x), mul9(y, y)) == (1, 0)]
    Vq = [(x, y) for x in range(q) for y in range(q)]
    Cq = [(x, y) for x, y in Vq if (x * x + y * y) % q == 1]
    i3, iq = {v: i for i, v in enumerate(V3)}, {v: i for i, v in enumerate(Vq)}
    nq = len(Vq)
    vid = lambda a, b: a * nq + b
    N = len(V3) * nq
    E = []
    for a, r in enumerate(V3):
        for b, rq in enumerate(Vq):
            for c in C3:
                a2 = i3[(add9(r[0], c[0]), add9(r[1], c[1]))]
                for cq in Cq:
                    w = vid(a2, iq[((rq[0] + cq[0]) % q, (rq[1] + cq[1]) % q)])
                    if w > vid(a, b):
                        E.append((vid(a, b), w))
    var = lambda v, c: 3 * v + c + 1
    s = Cadical153()
    for v in range(N):
        s.add_clause([var(v, c) for c in range(3)])
    for u, w in E:
        for c in range(3):
            s.add_clause([-var(u, c), -var(w, c)])
    print(f"S_1 x P_{q}: {N} vertices, {len(E)} edges, degree {len(C3) * len(Cq)}; 3-colourable: {s.solve()}")
    nxt, found = 3 * N + 1, None
    for b in range(1, nq):
        for c in range(3):
            s.add_clause([-nxt, -var(vid(0, 0), c), -var(vid(0, b), c)])
        if s.solve(assumptions=[nxt]):
            m = s.get_model()
            g = [next(c for c in range(3) if m[var(v, c) - 1] > 0) for v in range(N)]
            assert all(g[u] != g[w] for u, w in E) and g[vid(0, 0)] != g[vid(0, b)], 'INSTRUMENT CATASTROPHE'
            found = Vq[b]
            break
        nxt += 1
    if found:
        print(f"  Separable (colouring verified): f(0,0) != f(0,{found}) — a 3-colouring not pulled back from S_1")
    else:
        print(f"  Forced (solver claim) for all {nq - 1} points e != 0: every 3-colouring is pulled back from S_1")


# ---------------------------------------------------------------- counts / circles
def units_d(N, d):
    """every unit vector ((a + b√d)/N, (c + e√d)/N) of ℚ(√d)(i), d squarefree > 1 (tools/fs56_low_height.units with d free)"""
    from math import gcd, isqrt
    out = set()
    bmax = isqrt(N * N // d)
    for b in range(-bmax, bmax + 1):
        for e in range(-bmax, bmax + 1):
            r = N * N - d * (b * b + e * e)
            if r < 0:
                continue
            if b == 0 and e == 0:
                for a in range(-N, N + 1):
                    c2 = r - a * a
                    if c2 >= 0 and isqrt(c2) ** 2 == c2:
                        out.add((a, 0, isqrt(c2), 0))
                        out.add((a, 0, -isqrt(c2), 0))
                continue
            g = gcd(b, e)
            base = (e * e + b * b) // (g * g)
            if r % base:
                continue
            k = isqrt(r // base)
            if k * k * base != r:
                continue
            for kk in {k, -k}:
                out.add((kk * (-e) // g, b, kk * b // g, e))
    W = sorted(out)
    for a, b, c, e in W:
        assert a * a + c * c + d * (b * b + e * e) == N * N and a * b + c * e == 0
    return W


def cmd_counts():
    for d in (11, 23, 167):
        row = [f"{N}:{sum(1 for w in units_d(N, d) if w[1] or w[3])}"
               for N in (8, 10, 12, 20, 24, 28, 40, 56, 60, 70, 84, 120, 140, 168, 280, 420, 840)]
        print(f"Q(sqrt{d}): directions outside Q(i) by denominator:", ' '.join(row))


def cmd_circles(d, N, draws):
    W = units_d(N, d)
    Wset = set(W)
    add = lambda p, q: tuple(x + y for x, y in zip(p, q))
    sub = lambda p, q: tuple(x - y for x, y in zip(p, q))
    cache = {}

    def cross(delta):
        if delta not in cache:
            cache[delta] = [(i, j) for i, w in enumerate(W) for j, w2 in enumerate(W) if add(delta, sub(w, w2)) in Wset]
        return cache[delta]

    def odd(U):                                   # union-find with parity over the circle points
        node, rep = {}, {}
        for a, u in enumerate(U):
            for i, w in enumerate(W):
                node[(a, i)] = rep.setdefault(add(u, w), len(rep))
        parent, par = list(range(len(rep))), [0] * len(rep)

        def find(x):
            p = 0
            while parent[x] != x:
                p ^= par[x]
                x = parent[x]
            return x, p
        for a in range(3):
            for b in range(a + 1, 3):
                for i, j in cross(sub(U[a], U[b])):
                    x, px = find(node[(a, i)])
                    y, py = find(node[(b, j)])
                    if x == y:
                        if px == py:
                            return True
                    else:
                        parent[x], par[x] = y, px ^ py ^ 1
        return False
    random.seed(3)
    indep = good = 0
    for _ in range(draws):
        a = b = (0, 0, 0, 0)
        for _ in range(random.randint(1, 3)):
            a = add(a, random.choice(W))
        for _ in range(random.randint(1, 3)):
            b = add(b, random.choice(W))
        if a == b or (0, 0, 0, 0) in (a, b) or a in Wset or b in Wset or sub(a, b) in Wset:
            continue
        indep += 1
        good += odd([(0, 0, 0, 0), a, b])
    print(f"Q(sqrt{d}), W_{N} ({len(W)} directions): independent triples with a non-bipartite circle union: {good} of {indep} "
          f"({draws} draws)")


if __name__ == '__main__':
    cmd, args = sys.argv[1], sys.argv[2:]
    if cmd == 'tower':
        cmd_tower()
    elif cmd == 'split-means':
        cmd_split_means(int(args[0]), int(args[1]))
    elif cmd == 'dyadic-means':
        cmd_dyadic_means(int(args[0]))
    elif cmd == 'tensor':
        cmd_tensor(int(args[0]))
    elif cmd == 'counts':
        cmd_counts()
    elif cmd == 'circles':
        cmd_circles(int(args[0]), int(args[1]), int(args[2]))
    elif cmd == 'balls':
        cmd_balls(int(args[0]), int(args[1]), int(args[2]))
    else:
        raise SystemExit(__doc__)
