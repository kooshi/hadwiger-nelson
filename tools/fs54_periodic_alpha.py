#!/usr/bin/env python3
"""FS-54 D2 (structural half) — the largest SUBSPACE-PERIODIC independent sets of UD(F_27, 2), exhaustively.

View F_27^2 as F_3^6.  For an F_3-subspace W, a union of cosets of W is independent iff W contains no unit vector and
the chosen cosets are independent in the quotient Cayley graph Cay(F_3^6 / W, image of the unit circle).  So the best
W-periodic independent set has |W| * alpha(quotient) points, and the maximum over all W of dimension k is exact once
alpha of each quotient is exact.  Subspaces are reduced to orbits under the point stabiliser of Aut (rotations by the
28 unit vectors, the reflection (x, y) -> (x, -y), and the Frobenius (x, y) -> (x^3, y^3); |Aut| = 729 * 168 by
nauty), which permutes subspaces and preserves the quotient up to isomorphism.

Thresholds: six colours need alpha >= 122, five need alpha >= 146; the exact certificate gives alpha <= 147.
  dim W = 4 (9 cosets):  at most 1 coset (2 cosets = 162 > 147)            -> 81
  dim W = 3 (27 cosets): 5 cosets would give 135 >= 122
  dim W = 2 (81 cosets): 14 cosets give 126 >= 122; 16 give 144; 17 would exceed the certificate
Run: python3 tools/fs54_periodic_alpha.py [--dims 4 3 2]"""
import argparse, itertools, json, sys, time

sys.path.insert(0, __import__("os").path.dirname(__file__))
from fs54_structure import U, fmul, F, ONE  # noqa: E402  (the structure script's own checks run on import)

N = 6


def span(basis):
    pts = set()
    for coef in itertools.product(range(3), repeat=len(basis)):
        pts.add(tuple(sum(c * b[i] for c, b in zip(coef, basis)) % 3 for i in range(N)))
    return frozenset(pts)


def rref_subspaces(k):
    """Every k-dimensional subspace of F_3^6 exactly once, as its reduced row echelon basis."""
    for piv in itertools.combinations(range(N), k):
        free = [(r, c) for r in range(k) for c in range(piv[r] + 1, N) if c not in piv]
        for vals in itertools.product(range(3), repeat=len(free)):
            rows = [[0] * N for _ in range(k)]
            for r in range(k):
                rows[r][piv[r]] = 1
            for (r, c), v in zip(free, vals):
                rows[r][c] = v
            yield [tuple(r) for r in rows]


def gauss_count(n, k, q=3):
    num = den = 1
    for i in range(k):
        num *= q ** (n - i) - 1
        den *= q ** (i + 1) - 1
    return num // den


# the point stabiliser's generators, as permutations of the 729 point indices (x digits then y digits)
def _rot(u):
    a, b = u[:3], u[3:]
    return lambda v: tuple((fmul(a, v[:3])[i] - fmul(b, v[3:])[i]) % 3 for i in range(3)) + \
        tuple((fmul(b, v[:3])[i] + fmul(a, v[3:])[i]) % 3 for i in range(3))


def _cube(x):
    return fmul(fmul(x, x), x)


def _index(v):
    i = 0
    for d in v:
        i = 3 * i + d
    return i


POINTS = [tuple(v) for v in itertools.product(range(3), repeat=N)]
# the rotation group is cyclic of order 28, but all 28 rotations are listed: a generator is not needed when the
# permutations are precomputed, and listing them all removes any doubt that the group generated is the whole of it
GEN_MAPS = [_rot(u) for u in U] + [lambda v: v[:3] + tuple((-c) % 3 for c in v[3:]),
                                   lambda v: _cube(v[:3]) + _cube(v[3:])]
GENS = [[_index(g(v)) for v in POINTS] for g in GEN_MAPS]


def annihilator(W):
    """Rows of a matrix P: F_3^6 -> F_3^(6-k) with kernel exactly W."""
    rows = []
    for a in itertools.product(range(3), repeat=N):
        if any(a) and all(sum(x * y for x, y in zip(a, w)) % 3 == 0 for w in W):
            cand = rows + [a]
            if len(span(cand)) == 3 ** len(cand):
                rows = cand
    return rows


def max_independent(nv, adj):
    """Exact alpha by max clique in the complement, Tomita-style colour bound; adj as bitmasks."""
    comp = [((1 << nv) - 1) & ~adj[v] & ~(1 << v) for v in range(nv)]
    best = [0, 0]

    def expand(R, size, chosen):
        # greedy colour the candidates for an upper bound
        order, bounds, P, color = [], [], R, 0
        while P:
            color += 1
            Q = P
            while Q:
                v = (Q & -Q).bit_length() - 1
                Q &= ~(1 << v) & ~comp[v]
                P &= ~(1 << v)
                order.append(v)
                bounds.append(color)
        for v, b in zip(reversed(order), reversed(bounds)):
            if size + b <= best[0]:
                return
            if not R >> v & 1:
                continue
            newR = R & comp[v]
            if newR:
                expand(newR, size + 1, chosen | (1 << v))
            elif size + 1 > best[0]:
                best[0], best[1] = size + 1, chosen | (1 << v)
            R &= ~(1 << v)

    # vertex-transitive quotient: fix vertex 0 in the set
    R0 = comp[0]
    if R0:
        expand(R0, 1, 1)
    else:
        best[0], best[1] = 1, 1
    return best[0], [v for v in range(nv) if best[1] >> v & 1]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dims", type=int, nargs="+", default=[4, 3, 2])
    ap.add_argument("--out", default="data/fs54/periodic-alpha-q27.json")
    args = ap.parse_args()
    Uidx = {_index(u) for u in U}
    record = {"q": 27, "modulus": "t^3-t-1",
              "claim_scope": "exhaustive over every F_3-subspace W of the stated dimension (orbit-reduced under the "
                             "point stabiliser of Aut); the maximum |W|*alpha(quotient) is the largest W-periodic "
                             "independent set, exactly. Says nothing about non-periodic sets.",
              "by_dim": {}}
    for k in args.dims:
        t0 = time.time()
        subs = list(rref_subspaces(k))
        assert len(subs) == gauss_count(N, k), (len(subs), gauss_count(N, k))
        seen, reps = set(), []
        usable = 0
        for basis in subs:
            S = frozenset(_index(v) for v in span(basis))
            if S in seen:
                continue
            if S & Uidx:
                seen.add(S)
                continue
            orbit, frontier = {S}, [S]
            while frontier:
                T = frontier.pop()
                for g in GENS:
                    gT = frozenset(g[i] for i in T)
                    if gT not in orbit:
                        orbit.add(gT)
                        frontier.append(gT)
            seen |= orbit
            usable += len(orbit)
            reps.append((basis, len(orbit)))
        results = []
        for basis, osize in reps:
            P = annihilator(basis)
            m = len(P)
            img = {tuple(sum(x * y for x, y in zip(r, u)) % 3 for r in P) for u in U}
            assert all(any(c) for c in img)
            qpts = list(itertools.product(range(3), repeat=m))
            qidx = {p: i for i, p in enumerate(qpts)}
            adj = [0] * len(qpts)
            for p in qpts:
                for c in img:
                    adj[qidx[p]] |= 1 << qidx[tuple((a + b) % 3 for a, b in zip(p, c))]
            a, S = max_independent(len(qpts), adj)
            chosen = {qpts[i] for i in S}
            witness = sorted(_index(v) for v in POINTS
                             if tuple(sum(x * y for x, y in zip(r, v)) % 3 for r in P) in chosen)
            assert len(witness) == a * 3 ** k
            results.append({"basis": basis, "orbit_size": osize, "quotient_degree": len(img),
                            "alpha_quotient": a, "periodic_set_size": a * 3 ** k, "witness_set": witness})
        best = max(r["periodic_set_size"] for r in results)
        best_witness = next(r["witness_set"] for r in results if r["periodic_set_size"] == best)
        for r in results:
            del r["witness_set"]
        record["by_dim"][k] = {"best_witness_set": best_witness, "subspaces": len(subs), "unit_free_subspaces": usable, "orbits": len(reps),
                               "best_periodic_alpha": best, "seconds": round(time.time() - t0, 2),
                               "orbits_detail": results}
        print(f"dim {k}: {len(subs)} subspaces, {usable} unit-free in {len(reps)} orbits; "
              f"best periodic independent set {best}; alpha(quotient) distribution "
              f"{sorted(set((r['alpha_quotient'], r['quotient_degree']) for r in results))}; {time.time()-t0:.1f}s",
              flush=True)
    with open(args.out, "w") as fh:
        json.dump(record, fh, indent=1)


if __name__ == "__main__":
    main()
