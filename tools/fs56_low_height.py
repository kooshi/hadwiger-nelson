#!/usr/bin/env python3
"""fs56_low_height -- FS-56 phase D measurements: what the plane over Q(sqrt 167) looks like at small height.

Points are integer 4-vectors (a, b, c, e) over a denominator N, meaning (x, y) = ((a + b s)/N, (c + e s)/N), s = sqrt 167.
A unit vector over N:  a^2 + c^2 + 167 (b^2 + e^2) = N^2  and  ab + ce = 0  (so that x^2 + y^2 = 1 exactly).
W_N = all unit vectors whose denominator divides N; Lambda_N = the Z-span of W_N; the graph is Cay(Lambda_N, W_N), a
subgraph of the plane over Q(sqrt 167).  Everything here is exact integer arithmetic; nothing is a bound on chi of the plane.

  survey                         -> unit-vector counts, triangles and 5-cycles, lattice index, additive colourings Z/p,
                                    shortest odd cycle through 0 (breadth-first), per denominator
  ball N R CNF                    write DIMACS for "the radius-R ball of Cay(Lambda_N, W_N) is 3-colourable", with the colour
                                    of 0 and of one neighbour pinned (WLOG, by permuting colours); the vertex list beside it
  check-model N R MODEL           verify a solver's model is a proper 3-colouring of that ball (exit 0) -- a colouring is only
                                    believed after this
"""
import itertools
import json
import sys
from math import gcd, isqrt

D = 167
DENOMINATORS = (84, 168, 420, 2184, 5460, 10920)


def units(N):
    out = set()
    bmax = isqrt(N * N // D)
    for b in range(-bmax, bmax + 1):
        for e in range(-bmax, bmax + 1):
            r = N * N - D * (b * b + e * e)
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
        assert a * a + c * c + D * (b * b + e * e) == N * N and a * b + c * e == 0
    return W


def add(p, q):
    return tuple(x + y for x, y in zip(p, q))


def hnf_coords(W):
    """coordinates of each w in a Z-basis of span(W) (column-style Hermite normal form by integer row reduction)"""
    rows = [list(w) for w in W]
    basis = []
    m = [r[:] for r in rows]
    col = 0
    work = m
    while col < 4:
        work = [r for r in work if any(r)]
        piv = [r for r in work if r[col] != 0]
        if not piv:
            col += 1
            continue
        while len([r for r in work if r[col] != 0]) > 1:
            nz = sorted((r for r in work if r[col] != 0), key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(4):
                    r[j] -= q * p[j]
        p = next(r for r in work if r[col] != 0)
        basis.append(p[:])
        work = [r for r in work if r is not p]
        col += 1
    # solve w = sum coeff_i basis_i (basis is echelon)
    coords = []
    for w in W:
        v, cf = list(w), []
        for bvec in basis:
            lead = next(j for j in range(4) if bvec[j])
            q, rem = divmod(v[lead], bvec[lead])
            assert rem == 0
            cf.append(q)
            v = [v[j] - q * bvec[j] for j in range(4)]
        assert not any(v)
        coords.append(cf)
    index = 1
    for bvec in basis:
        index *= abs(next(x for x in bvec if x))
    return basis, coords, index


def survey():
    print("# the plane over Q(sqrt 167) at small height (exact; tools/fs56_low_height.py survey)")
    for N in DENOMINATORS:
        W = units(N)
        Wset = set(W)
        irr = sum(1 for w in W if w[1] or w[3])
        tri = any(tuple(-x for x in add(u, v)) in Wset for u in W for v in W)
        S2 = {add(u, v) for u in W for v in W}
        five = any(tuple(-x for x in add(s, w)) in S2 for s in S2 for w in W)
        basis, C, index = hnf_coords(W)
        additive = [p for p in (2, 3, 4, 5)
                    if any(all(sum(c * f for c, f in zip(row, phi)) % p for row in C)
                           for phi in itertools.product(range(p), repeat=len(basis)))]
        par = [tuple(sum(c * f for c, f in zip(row, phi)) % 2 for row in C)
               for phi in itertools.product(range(2), repeat=len(basis))]
        klein = any(all(a or b for a, b in zip(u, v)) for u, v in itertools.combinations(par, 2))
        print(f"N={N}: |W| = {len(W)} ({irr} leave Q(i)); rank {len(basis)}, index {index} in Z^4; triangle {tri}; "
              f"5-cycle {five}; additive colourings nonzero on every unit vector into Z/p for p in {additive}, "
              f"into (Z/2)^2: {klein}")
    for N, depth in ((84, 5), (168, 4), (420, 3), (2184, 3), (10920, 2)):
        W = units(N)
        dist, frontier, odd = {(0, 0, 0, 0): 0}, [(0, 0, 0, 0)], None
        for L in range(depth):
            nxt = []
            for p in frontier:
                for w in W:
                    q = add(p, w)
                    d = dist.get(q)
                    if d is None:
                        dist[q] = L + 1
                        nxt.append(q)
                    elif d == L and odd is None:
                        odd = 2 * L + 1
            frontier = nxt
        if odd is None:
            last = set(frontier)
            if any(add(p, w) in last for p in frontier for w in W):
                odd = 2 * depth + 1
        print(f"N={N}: ball of radius {depth} about 0 has {len(dist)} points; shortest odd closed walk through 0 "
              f"{odd if odd else 'longer than %d' % (2 * depth + 1)}")


def ball(N, R):
    W = units(N)
    dist, frontier = {(0, 0, 0, 0): 0}, [(0, 0, 0, 0)]
    for L in range(R):
        nxt = []
        for p in frontier:
            for w in W:
                q = add(p, w)
                if q not in dist:
                    dist[q] = L + 1
                    nxt.append(q)
        frontier = nxt
    V = sorted(dist, key=lambda p: (dist[p], p))
    idx = {p: i for i, p in enumerate(V)}
    E = [(idx[p], idx[q]) for p in V for w in W if (q := add(p, w)) in idx and idx[p] < idx[q]]
    return W, V, E


def write_cnf(N, R, path):
    W, V, E = ball(N, R)
    var = lambda v, c: 3 * v + c + 1
    clauses = [[var(v, 0), var(v, 1), var(v, 2)] for v in range(len(V))]
    clauses += [[-var(u, c), -var(v, c)] for u, v in E for c in range(3)]
    nb = next(v for u, v in E if u == 0)
    clauses += [[var(0, 0)], [var(nb, 1)]]  # WLOG by permuting colours: any edge may take colours 0 and 1
    with open(path, "w") as f:
        f.write(f"c FS-56: 3-colourability of the radius-{R} ball of Cay(Lambda_{N}, W_{N}) over Q(sqrt 167); "
                f"{len(V)} vertices, {len(E)} edges; vertex 0 colour 0, vertex {nb} colour 1\n")
        f.write(f"p cnf {3 * len(V)} {len(clauses)}\n")
        for cl in clauses:
            f.write(" ".join(map(str, cl)) + " 0\n")
    with open(path + ".vertices.json", "w") as f:
        json.dump({"N": N, "R": R, "vertices": V}, f)
    print(f"wrote {path}: {len(V)} vertices, {len(E)} edges, {len(clauses)} clauses")


def monochromatic_unit_pair(V, colour, N):
    """every pair of same-coloured points, exact integer quadrance; returns (first unit pair or None, pairs checked)"""
    import numpy as np
    P = np.array(V, dtype=np.int64)
    col = np.array(colour)
    pairs = 0
    for c in range(3):
        Q = P[col == c]
        for i in range(0, len(Q), 512):
            d = Q[i:i + 512, None, :] - Q[None, :, :]
            quad = d[..., 0] ** 2 + d[..., 2] ** 2 + D * (d[..., 1] ** 2 + d[..., 3] ** 2)
            cross = d[..., 0] * d[..., 1] + d[..., 2] * d[..., 3]
            hit = (quad == N * N) & (cross == 0)
            if hit.any():
                a, b = np.argwhere(hit)[0]
                return (Q[i + a].tolist(), Q[b].tolist()), pairs
            pairs += d.shape[0] * d.shape[1]
    return None, pairs


def check_model(N, R, model_path):
    W, V, E = ball(N, R)
    lits = set()
    for line in open(model_path):
        if line.startswith("v "):
            lits.update(int(t) for t in line.split()[1:] if t != "0")
    colour = []
    for v in range(len(V)):
        cs = [c for c in range(3) if 3 * v + c + 1 in lits]
        if not cs:
            print(f"REFUSED: vertex {v} has no colour in the model")
            return 1
        colour.append(cs[0])
    bad = [(u, v) for u, v in E if colour[u] == colour[v]]
    if bad:
        print(f"REFUSED: {len(bad)} monochromatic edges, e.g. {bad[0]}")
        return 1
    print(f"VERIFIED: a proper 3-colouring of the radius-{R} ball of Cay(Lambda_{N}, W_{N}) ({len(V)} vertices, {len(E)} edges)")
    if "--exhaustive" in sys.argv:
        hit, pairs = monochromatic_unit_pair(V, colour, N)
        if hit:
            print(f"REFUSED: same-coloured points at unit distance: {hit[0]} and {hit[1]}")
            return 1
        print(f"VERIFIED EXHAUSTIVELY: no two of the {len(V)} points with the same colour are at distance 1 "
              f"({pairs} ordered same-colour pairs checked by exact quadrance, independently of the unit-vector list)")
        # its control: recolour one endpoint of an edge the check must see, and confirm it fires
        u, v = E[0]
        planted = list(colour)
        planted[v] = planted[u]
        phit, _ = monochromatic_unit_pair(V, planted, N)
        print(f"control: with vertex {v} recoloured to match its neighbour {u}, the exhaustive check "
              f"{'FIRES as designed' if phit else 'DOES NOT FIRE -- the check is blind'}")
        if not phit:
            return 1
    return 0


if __name__ == "__main__":
    cmd = sys.argv[1]
    if cmd == "survey":
        survey()
    elif cmd == "ball":
        write_cnf(int(sys.argv[2]), int(sys.argv[3]), sys.argv[4])
    elif cmd == "check-model":
        sys.exit(check_model(int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]))
