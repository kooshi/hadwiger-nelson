#!/usr/bin/env python3
"""fs58_seven_cycle -- the prelude to FS-58: ℚ(√167)'s shortest odd cycle, the family it belongs to, the 3-adic barrier.

Record: plans/FS58-prelude-seven-cycle-gadget.md. Outputs: data/fs58/. UNTRUSTED like everything in tools/: exact integer
arithmetic throughout, colourings verified edge by edge, solver refusals reported as the solver's claims.

Points and unit vectors of ℚ(√167) are integer 4-vectors (a, b, c, e) over a denominator N, meaning
((a + b√167)/N, (c + e√167)/N); W_N = every unit vector with denominator dividing N (tools/fs56_low_height.units).

  census N            every zero-sum 7-multiset of W_N with no proper zero-sum part (the 7-cycles through 0, up to order),
                      its multiplicity pattern, and the triangle read as (straight run) + (two diamonds) under each pairing
  least MAXN CAP      odd girth of Cay(Λ_N, W_N) for every N ≤ MAXN with a direction outside ℚ(i): breadth-first from 0 to a
                      point cap; a miss reports the length below which no odd cycle exists
  family B            the isosceles gadget (a run of n ∈ {1, 3} unit edges closed by two unit diamonds of rational cosine):
                      exact constructions with odd girth, and the fields ℚ(√D), D ≡ 7 (mod 8) below 400, that hold one with a
                      diamond cosine of denominator ≤ B, beside the Legendre conditions (7/D) and (15/D)
  residue             the plane over 𝔽₉ (√167 ↦ t, t² = −1): no 2-colouring (exhaustive), a verified 3-colouring and the linear
                      rule it follows; the pulled-back rule (a + b + c)·m⁻¹ mod 3 checked nonzero on W_m for 3-free m; the planes
                      over 𝔽₂₅ and 𝔽₄₉ at 3 and 4 colours (CaDiCaL: SAT verified, UNSAT the solver's claim)
  union RDEN CAP      the gadget in every rotation of W_RDEN: every rotated copy through 0, then copies glued along existing edges
                      up to CAP points; every exact unit edge; directions with 3 in the denominator; additive Z/3 colourings
                      nonzero on every direction; 3-colourability by CaDiCaL with the model verified
"""
import itertools
import json
import math
import os
import subprocess
import sys
import time
from collections import Counter, defaultdict
from fractions import Fraction as Fr
from math import gcd, isqrt
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from fs56_low_height import units  # noqa: E402

D = 167
SQ = math.sqrt(D)
ZERO = (0, 0, 0, 0)
add = lambda p, q: tuple(x + y for x, y in zip(p, q))
sub = lambda p, q: tuple(x - y for x, y in zip(p, q))
neg = lambda p: tuple(-x for x in p)


def cadical():
    try:
        prefix = subprocess.run(['lean', '--print-prefix'], capture_output=True, text=True, check=True).stdout.strip()
        path = Path(prefix) / 'bin' / 'cadical'
        if path.exists():
            return str(path)
    except (OSError, subprocess.CalledProcessError):
        pass
    for path in Path.home().glob('.elan/toolchains/*/bin/cadical'):
        return str(path)
    raise SystemExit('cadical not found: run from a shell where `lean --print-prefix` works')


def solve_colouring(n, edges, k, stem, wall=600):
    """(status, colouring): SAT with a colouring verified on every edge, UNSAT (the solver's claim), or UNKNOWN."""
    var = lambda v, c: k * v + c + 1
    cnf = Path(f'{stem}.cnf')
    with cnf.open('w') as f:
        lines = [' '.join(str(var(v, c)) for c in range(k)) + ' 0' for v in range(n)]
        for a, b in edges:
            lines += [f'-{var(a, c)} -{var(b, c)} 0' for c in range(k)]
        a0, b0 = min(edges)
        lines += [f'{var(a0, 0)} 0', f'{var(b0, 1)} 0']        # WLOG one edge takes colours 0 and 1
        f.write(f'p cnf {k * n} {len(lines)}\n' + '\n'.join(lines) + '\n')
    r = subprocess.run([cadical(), '-q', '-t', str(wall), str(cnf)], capture_output=True, text=True)
    cnf.unlink()
    if r.returncode == 20:
        return 'UNSAT (solver claim)', None
    if r.returncode != 10:
        return f'UNKNOWN (exit {r.returncode})', None
    val = {abs(int(x)): int(x) > 0 for line in r.stdout.splitlines() if line.startswith('v') for x in line.split()[1:]}
    col = [next(c for c in range(k) if val.get(var(v, c))) for v in range(n)]
    bad = sum(1 for a, b in edges if col[a] == col[b])
    assert bad == 0, f'INSTRUMENT CATASTROPHE: the solver model leaves {bad} monochromatic edges'
    return 'SAT (colouring verified)', col


# ---------------------------------------------------------------- census
def cmd_census(N):
    W = units(N)
    n = len(W)
    S3 = defaultdict(list)
    for c in itertools.combinations_with_replacement(range(n), 3):
        t = ZERO
        for i in c:
            t = add(t, W[i])
        S3[t].append(c)
    sols = set()
    for c in itertools.combinations_with_replacement(range(n), 4):
        t = ZERO
        for i in c:
            t = add(t, W[i])
        for c3 in S3.get(neg(t), ()):
            sols.add(tuple(sorted(c + c3)))

    def proper_zero_part(ms):
        for r in range(2, 7):
            for part in set(itertools.combinations(ms, r)):
                t = ZERO
                for i in part:
                    t = add(t, W[i])
                if t == ZERO:
                    return True
        return False

    prim = sorted(ms for ms in sols if not proper_zero_part(ms))
    print(f'N={N}: |W_N| = {n}; zero-sum 7-multisets {len(sols)}, with no proper zero-sum part {len(prim)}')
    print('  multiplicity patterns:', dict(Counter(tuple(sorted(Counter(ms).values(), reverse=True)) for ms in prim)))
    dot = lambda p, q: (p[0]*q[0] + D*p[1]*q[1] + p[2]*q[2] + D*p[3]*q[3], p[0]*q[1] + p[1]*q[0] + p[2]*q[3] + p[3]*q[2])
    val = lambda r: (r[0] + r[1] * SQ) / N**2
    for ms in prim[:1]:
        cnt = Counter(ms)
        print('  first multiset:', [W[i] for i in ms])
        triple = [i for i, k in cnt.items() if k == 3]
        if not triple:
            continue
        w = W[triple[0]]
        rest = [i for i in ms if i != triple[0]]
        h = tuple(3 * x for x in w)
        for pa in (((0, 1), (2, 3)), ((0, 2), (1, 3)), ((0, 3), (1, 2))):
            d1 = add(W[rest[pa[0][0]]], W[rest[pa[0][1]]])
            d2 = add(W[rest[pa[1][0]]], W[rest[pa[1][1]]])
            L1, L2 = math.sqrt(val(dot(d1, d1))), math.sqrt(val(dot(d2, d2)))
            apex = 180 - math.degrees(math.acos(max(-1.0, min(1.0, val(dot(d1, d2)) / (L1 * L2)))))
            print(f'  run 3·{w}; pairing {pa}: |3w|² = {dot(h, h)}, |d1|² = {dot(d1, d1)}, |d2|² = {dot(d2, d2)}, '
                  f'd1·d2 = {dot(d1, d2)} (each (r, s) = (r + s√167)/N²); legs {L1:.6f}, {L2:.6f}; apex angle {apex:.4f}°')


# ---------------------------------------------------------------- least denominator with an odd cycle
def cmd_least(maxn, cap):
    for N in range(1, maxn + 1):
        W = units(N)
        if all(w[1] == 0 and w[3] == 0 for w in W):
            continue                                      # directions in ℚ(i) only: the graph is bipartite
        level = {ZERO: 0}
        frontier = [ZERO]
        found = None
        L = 0
        while frontier and found is None:
            nxt = []
            for p in frontier:
                for w in W:
                    q = add(p, w)
                    if q not in level:
                        if len(level) >= cap:
                            break
                        level[q] = L + 1
                        nxt.append(q)
                    elif level[q] == L:
                        found = 2 * L + 1
                        break
                if found is not None or len(level) >= cap:
                    break
            if found is None and len(level) >= cap:
                break
            frontier = nxt
            L += 1
        irr = sum(1 for w in W if w[1] or w[3])
        if found is not None:
            print(f'N={N}: |W| = {len(W)} ({irr} outside ℚ(i)); odd girth {found}')
        else:
            print(f'N={N}: |W| = {len(W)} ({irr} outside ℚ(i)); no odd cycle of length ≤ {2 * L - 1} '
                  f'(breadth-first from 0 stopped at {len(level):,} points)')


# ---------------------------------------------------------------- the family
def squarefree(X):
    m, k, p = X, 1, 2
    while p * p <= m:
        while m % (p * p) == 0:
            m //= p * p
            k *= p
        p += 1
    return m, k                                           # X = m·k²


def gadget(n, a, b):
    """The isosceles gadget of base n and diamond cosine a/b, built exactly: (D, points, unit edges, odd girth) or None."""
    c = Fr(a, b)
    X = (8 * (a + b) - n * n * b) * b                    # apex height² = X / (4b²)
    if X <= 0:
        return None
    Dd, k = squarefree(X)
    t2 = (1 - c) / (1 + c)                               # tan²(θ/2): rational square iff sin θ is rational
    if isqrt(t2.numerator) ** 2 != t2.numerator or isqrt(t2.denominator) ** 2 != t2.denominator:
        return None
    r = Fr(isqrt(t2.numerator), isqrt(t2.denominator)) / 2

    class Q:                                             # x + y√Dd
        def __init__(s, x, y=0):
            s.x, s.y = Fr(x), Fr(y)
        def __add__(s, o): return Q(s.x + o.x, s.y + o.y)
        def __sub__(s, o): return Q(s.x - o.x, s.y - o.y)
        def __mul__(s, o): return Q(s.x * o.x + Dd * s.y * o.y, s.x * o.y + s.y * o.x)
        def __eq__(s, o): return s.x == o.x and s.y == o.y
        def __hash__(s): return hash((s.x, s.y))

    z = Q(0)
    P = lambda u, v: (u, v)
    padd = lambda u, v: (u[0] + v[0], u[1] + v[1])
    J = lambda u: (z - u[1], u[0])
    sc = lambda f, u: (Q(f) * u[0], Q(f) * u[1])
    run = [P(z, Q(-i)) for i in range(n + 1)]
    B = run[-1]
    d = (Q(0, Fr(k, 2 * b)), Q(Fr(n, 2)))                 # base end → apex
    C = padd(B, d)
    dd = (z - d[0], d[1])                                 # apex → origin
    V = run + [C]
    for base, dv in ((B, d), (C, dd)):
        half = sc(Fr(1, 2), dv)
        V += [padd(base, padd(half, sc(r, J(dv)))), padd(base, padd(half, sc(-r, J(dv))))]
    assert padd(C, dd) == run[0]
    V = list(dict.fromkeys(V))                            # a flat diamond (θ = 0) has coincident middles
    unit = lambda u, v: (u[0] - v[0]) * (u[0] - v[0]) + (u[1] - v[1]) * (u[1] - v[1]) == Q(1)
    E = [(i, j) for i, j in itertools.combinations(range(len(V)), 2) if unit(V[i], V[j])]
    adj = defaultdict(list)
    for i, j in E:
        adj[i].append(j)
        adj[j].append(i)
    og = None
    for s0 in range(len(V)):
        dist = {s0: 0}
        qu = [s0]
        for x in qu:
            for y in adj[x]:
                if y not in dist:
                    dist[y] = dist[x] + 1
                    qu.append(y)
                elif dist[y] == dist[x]:
                    og = min(og or 99, 2 * dist[x] + 1)
    return Dd, len(V), len(E), og


def cmd_family(bound):
    print('Exact constructions (base n, diamond cosine) -> field, points, unit edges, odd girth:')
    for n, a, b in [(3, 24, 25), (3, 1, 1), (3, 4, 5), (3, 7, 25), (3, 5, 13), (1, 0, 1), (1, -3, 5), (1, 20, 29), (1, 527, 625)]:
        print(f'  n={n} cos θ={a}/{b}:', gadget(n, a, b))
    pts = [(1, 1), (0, 1)]
    for m in range(1, isqrt(bound) + 1):
        for k in range(1, m):
            if (m - k) % 2 == 0 or gcd(m, k) != 1:
                continue
            b = m * m + k * k
            if b > bound:
                break
            for a in (m * m - k * k, 2 * m * k):
                pts += [(a, b), (-a, b)]
    targets = [d for d in range(7, 400, 8) if all(d % (p * p) for p in range(2, 20))]
    leg = lambda a, p: 1 if pow(a % p, (p - 1) // 2, p) == 1 else -1
    isprime = lambda x: x > 1 and all(x % q for q in range(2, isqrt(x) + 1))
    for n in (1, 3):
        best = {}
        for a, b in pts:
            X = (8 * (a + b) - n * n * b) * b
            if X <= 0:
                continue
            for Dt in targets:
                if Dt not in best and X % Dt == 0 and isqrt(X // Dt) ** 2 == X // Dt:
                    best[Dt] = (a, b)
        print(f'n = {n} ({n + 4}-cycle), diamond-cosine denominator ≤ {bound:,}: squarefree D ≡ 7 (mod 8) below 400 holding the gadget:')
        print('  ', ', '.join(f'{Dt} (cos {a}/{b})' for Dt, (a, b) in sorted(best.items())))
        print('   none found:', [Dt for Dt in targets if Dt not in best])
        sym = 15 if n == 1 else 7
        clash = [p for p in targets if p > 7 and isprime(p) and p in best and leg(sym, p) != 1]
        print(f'   primes D > 7 found with ({sym}/D) = −1 (the proved necessary condition, D ≡ 3 mod 4 and D > 7, says none): {clash}')
        print(f'   primes D > 7 with ({sym}/D) = +1 not found at this height: {[p for p in targets if p > 7 and isprime(p) and p not in best and leg(sym, p) == 1]}')


# ---------------------------------------------------------------- the residue barrier at 3
def plane_over_extension(p):
    """UD(𝔽_p², 2) with 𝔽_p² = 𝔽_p[t]/(t² − 167), p inert in ℚ(√167): (vertices, circle, edges)."""
    assert pow(D % p, (p - 1) // 2, p) == p - 1
    els = [(x, y) for x in range(p) for y in range(p)]
    mul = lambda u, v: ((u[0] * v[0] + D * u[1] * v[1]) % p, (u[0] * v[1] + u[1] * v[0]) % p)
    pad = lambda u, v: ((u[0] + v[0]) % p, (u[1] + v[1]) % p)
    circle = [(x, y) for x in els for y in els if pad(mul(x, x), mul(y, y)) == (1, 0)]
    V = [(x, y) for x in els for y in els]
    ix = {v: i for i, v in enumerate(V)}
    E = set()
    for x, y in V:
        for a, b in circle:
            i, j = ix[(x, y)], ix[(pad(x, a), pad(y, b))]
            E.add((min(i, j), max(i, j)))
    return V, circle, sorted(E)


def cmd_residue():
    V, circle, E = plane_over_extension(3)
    print(f'UD(𝔽₉, 2): {len(V)} points, unit circle {len(circle)} points, {len(E)} edges')
    adj = defaultdict(set)
    for i, j in E:
        adj[i].add(j)
        adj[j].add(i)
    # 2-colouring: a breadth-first 2-colouring either succeeds or meets an odd cycle
    side = {0: 0}
    qu = [0]
    odd = False
    for x in qu:
        for y in adj[x]:
            if y not in side:
                side[y] = 1 - side[x]
                qu.append(y)
            elif side[y] == side[x]:
                odd = True
    print(f'  2-colourable: {not odd} (breadth-first, exhaustive)')
    rule = lambda v: (v[0][0] + v[0][1] + v[1][0]) % 3      # x = x₀ + x₁t, y = y₀ + y₁t  ↦  x₀ + x₁ + y₀
    bad = sum(1 for i, j in E if rule(V[i]) == rule(V[j]))
    print(f'  the linear rule colour(x, y) = x₀ + x₁ + y₀ (mod 3): {bad} monochromatic edges of {len(E)}')
    assert bad == 0
    print('  pulled back to ℚ(√167): colour((a + b√167)/m, (c + e√167)/m) = (a + b + c)·m⁻¹ (mod 3), for 3 ∤ m')
    total = 0
    for m in (140, 280, 560, 700, 980, 1540, 1960, 3640):
        W = units(m)
        inv = pow(m % 3, -1, 3)
        zeros = sum(1 for w in W if ((w[0] + w[1] + w[2]) * inv) % 3 == 0)
        total += len(W)
        print(f'    m={m}: {len(W)} unit vectors, rule zero on {zeros}')
        assert zeros == 0
    print(f'    checked {total} unit vectors with 3-free denominators')
    for p in (5, 7):
        Vp, cp, Ep = plane_over_extension(p)
        for k in (3, 4):
            st, _ = solve_colouring(len(Vp), Ep, k, f'fs58-plane{p}-k{k}', wall=300)
            print(f'UD(𝔽_{p}², 2): {len(Vp)} points, unit circle {len(cp)}, {len(Ep)} edges; {k}-colourable: {st}')


# ---------------------------------------------------------------- unions of the gadget in all rotations
M = 58800                                                # every rotation denominator used divides M/140
GW = (0, 0, -140, 0)
GA, GB, GC, GD = (-15, -7, 105, -1), (-15, 7, 105, 1), (15, -7, 105, 1), (15, 7, 105, -1)


def base_gadget():
    P = [ZERO]
    for _ in range(3):
        P.append(add(P[-1], GW))
    P4, P4b = add(P[3], GB), add(P[3], GD)
    P5 = add(P4, GD)
    P6, P6b = add(P5, GA), add(P5, GC)
    assert add(P6, GC) == ZERO and add(P6b, GA) == ZERO and add(P4b, GB) == P5
    edges = [(0, 1), (1, 2), (2, 3), (3, 4), (3, 5), (4, 6), (5, 6), (6, 7), (6, 8), (7, 0), (8, 0)]
    return P + [P4, P4b, P5, P6, P6b], edges


def cmd_union(rden, cap):
    assert M % (rden * 140) == 0, f'rotation denominator {rden} does not fit M = {M}'
    tag = f'union-R{rden}-{cap}'
    R = units(rden)
    G, GE = base_gadget()
    is_unit = lambda d: d[0]**2 + D * d[1]**2 + d[2]**2 + D * d[3]**2 == M * M and d[0] * d[1] + d[2] * d[3] == 0
    k = M // (rden * 140)

    def rot(r, u):
        a1, b1, c1, e1 = r
        a2, b2, c2, e2 = u
        return ((a1*a2 + D*b1*b2 - c1*c2 - D*e1*e2) * k, (a1*b2 + b1*a2 - c1*e2 - e1*c2) * k,
                (a1*c2 + D*b1*e2 + c1*a2 + D*e1*b2) * k, (a1*e2 + b1*c2 + c1*b2 + e1*a2) * k)

    rotG = [[rot(r, g) for g in G] for r in R]
    place = defaultdict(list)
    for i, vs in enumerate(rotG):
        for u, v in GE:
            dvec = sub(vs[v], vs[u])
            assert is_unit(dvec)
            place[dvec].append((i, u, v))
            place[neg(dvec)].append((i, v, u))
    pts, order, gadgets, E, queue = {}, [], set(), set(), []

    def point(p):
        if p not in pts:
            pts[p] = len(order)
            order.append(p)
        return pts[p]

    def put(i, T):
        if (i, T) in gadgets:
            return
        gadgets.add((i, T))
        ids = [point(add(T, g)) for g in rotG[i]]
        for u, v in GE:
            e = (min(ids[u], ids[v]), max(ids[u], ids[v]))
            if e not in E:
                E.add(e)
                queue.append(e)

    for i, vs in enumerate(rotG):                         # every rotated copy through the origin, by every vertex
        for g in vs:
            put(i, neg(g))
    seed = len(order)
    head = 0
    while head < len(queue) and len(order) < cap:        # glue copies along existing edges, breadth-first
        a, b = queue[head]
        head += 1
        pa = order[a]
        for i, u, v in place.get(sub(order[b], pa), ()):
            put(i, sub(pa, rotG[i][u]))
            if len(order) >= cap:
                break
    n = len(order)
    xy = [((p[0] + p[1] * SQ) / M, (p[2] + p[3] * SQ) / M) for p in order]
    grid = defaultdict(list)
    for j, (x, y) in enumerate(xy):
        grid[(math.floor(x), math.floor(y))].append(j)
    EA = set()
    for j, (x, y) in enumerate(xy):                       # floats propose, integers decide
        gx, gy = math.floor(x), math.floor(y)
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                for i2 in grid.get((gx + dx, gy + dy), ()):
                    if i2 > j and abs((x - xy[i2][0])**2 + (y - xy[i2][1])**2 - 1) < 1e-7 and is_unit(sub(order[i2], order[j])):
                        EA.add((j, i2))
    assert E <= EA, 'a gadget edge was not found by the unit-edge search'
    dirs = {sub(order[j], order[i]) for i, j in EA}
    dirs |= {neg(d) for d in dirs}

    def three_free(d):
        g = M
        for x in d:
            g = gcd(g, x)
        return (M // g) % 3 != 0

    n3 = sum(1 for d in dirs if not three_free(d)) // 2
    # additive colourings into Z/3: an echelon basis of the lattice the directions span, then all (Z/3)^rank functionals
    rows = lattice_basis(dirs)
    coords = [express(rows, d) for d in dirs]
    add3 = sum(1 for phi in itertools.product(range(3), repeat=len(rows)) if all(sum(p * x for p, x in zip(phi, c)) % 3 for c in coords))
    t = time.time()
    status, _ = solve_colouring(n, sorted(EA), 3, f'fs58-{tag}', wall=600)
    rec = dict(rotation_denominator=rden, rotations=len(R), cap=cap, seed_points=seed, points=n, gadget_copies=len(gadgets),
               gadget_edges=len(E), unit_edges=len(EA), directions_up_to_sign=len(dirs) // 2,
               directions_with_3_in_denominator=n3, lattice_rank=len(rows), additive_Z3_colourings=add3,
               three_colourable=status, solver_seconds=round(time.time() - t, 2))
    print(json.dumps(rec))


def lattice_basis(vectors):
    """An echelon basis of the Z-span of integer 4-vectors: Euclid down each column, keep one pivot row, move on."""
    rows = [list(v) for v in vectors if any(v)]
    basis = []
    for col in range(4):
        while True:
            nz = sorted((r for r in rows if r[col]), key=lambda r: abs(r[col]))
            if len(nz) <= 1:
                break
            for r in nz[1:]:
                q = r[col] // nz[0][col]
                for i in range(4):
                    r[i] -= q * nz[0][i]
            rows = [r for r in rows if any(r)]
        pivot = next((r for r in rows if r[col]), None)
        if pivot is not None:
            basis.append(pivot)
            rows = [r for r in rows if r is not pivot]
    return basis


def express(rows, d):
    v = list(d)
    c = []
    for r in rows:
        piv = next(i for i in range(4) if r[i])
        assert v[piv] % r[piv] == 0, 'direction outside the echelon lattice'
        q = v[piv] // r[piv]
        c.append(q)
        v = [x - q * y for x, y in zip(v, r)]
    assert not any(v)
    return c


if __name__ == '__main__':
    cmd, args = sys.argv[1], [int(x) for x in sys.argv[2:]]
    {'census': cmd_census, 'least': cmd_least, 'family': cmd_family, 'residue': cmd_residue, 'union': cmd_union}[cmd](*args)
