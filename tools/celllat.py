#!/usr/bin/env python3
"""The constraint graph of a triangular lattice's cells, across scales (M39).

UNTRUSTED, like everything in `tools/`. A colouring found here becomes mathematics
only when it replays through the kernel; a refusal is bounded by the torus sizes
probed, never a claim about the family.

## The object (M39 §0a)

Colour each point of the plane by which cell of the triangular lattice it lands in
(nearest lattice point, at scale p). Such a colouring is proper exactly when it
properly colours the CONSTRAINT GRAPH G(p) on lattice addresses: join u and v when
their cells contain a pair of points one unit apart. Hence

    chi(R^2)  <=  chi(G(p))   for every p,

and M38 proved chi(G(p)) = 7 for p in (1/2, 1) — the classical hexagonal
seven-colouring, recovered as a graph-colouring fact. Below p = 1/2 the graph
changes and nobody has looked.

## The exact criterion

Everything is done in the ADDRESS space with the integral form
Q(a,b) = a^2 + ab + b^2, so distances are p^2 * Q of address differences and all
arithmetic is rational. Two cells at offset d realize the distance set
{ |addr d + w| : w in H } where H = C - C = 2C is the difference body of the
Voronoi cell — the hexagon with vertices 2*hole_i. Since Q is convex:

  * max over H is attained at a VERTEX of H (six candidates);
  * min over H is 0 if -addr d lies in H, else attained on an EDGE (a
    one-parameter quadratic minimised exactly).

So d is an edge of G(p) iff  minQ <= T^2 <= maxQ  with T = 1/p. This is
NECESSARY as well as sufficient — M38's inscribed-disc test was only sufficient,
and using a sufficient test to measure a family measures the test (G21).

    python3 tools/celllat.py                 # status; runs nothing
    python3 tools/celllat.py --self-test
    python3 tools/celllat.py --census        # edge sets and clique numbers by scale
    python3 tools/celllat.py --colour T k    # SAT-colour G(1/T) with k colours
    python3 tools/celllat.py --sweep         # the registered campaign
"""

from __future__ import annotations

import argparse
import json
import sys
from fractions import Fraction as F
from itertools import combinations
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
BUILD = TOOLS.parent / "build"
sys.path.insert(0, str(TOOLS))

from forcer import _solve  # noqa: E402

ART = BUILD / "m39-cells.json"
SCHEMA = ("m39-cells v1 (plans/M39-constraint-graph.md §0a; the edge criterion is EXACT "
          "— necessary and sufficient — so an `unsat` row is a statement about the graph "
          "at that scale and torus, and the standing caveat is the torus grid, not the "
          "test. chi(R^2) <= chi(G(p)) for every p, so any k <= 6 colouring found here "
          "is an upper-bound result and must be halted on, not celebrated.)")

CATASTROPHE_EXIT = 5

# ---------------------------------------------------------------- the form


def Q(v):
    a, b = v
    return a * a + a * b + b * b


def ip2(u, v):
    """Twice the polarization: Q(u+v) = Q(u) + ip2(u,v) + Q(v)."""
    a, b = u
    c, d = v
    return 2 * (a * c + b * d) + (a * d + b * c)


# the difference body H = 2C: the hexagon with these six vertices (address coords)
HOLES2 = [(F(2, 3), F(2, 3)), (F(-2, 3), F(4, 3)), (F(-4, 3), F(2, 3)),
          (F(-2, 3), F(-2, 3)), (F(2, 3), F(-4, 3)), (F(4, 3), F(-2, 3))]


def _min_on_segment(d, p0, p1):
    """min of Q(d + (1-t) p0 + t p1) over t in [0,1], exactly."""
    # write the point as A + t*B with A = d + p0, B = p1 - p0
    A = (d[0] + p0[0], d[1] + p0[1])
    B = (p1[0] - p0[0], p1[1] - p0[1])
    qb = Q(B)
    if qb == 0:
        return Q(A)
    # Q(A + tB) = Q(A) + t*ip2(A,B) + t^2 Q(B); minimum at t* = -ip2/(2 Q(B))
    t = F(-ip2(A, B), 2 * qb)
    t = max(F(0), min(F(1), t))
    P = (A[0] + t * B[0], A[1] + t * B[1])
    return Q(P)


def _inside(d):
    """Is -addr d inside the hexagon H?  (H is convex, vertices HOLES2 in order.)"""
    x = (-d[0], -d[1])
    sign = 0
    n = len(HOLES2)
    for i in range(n):
        p0, p1 = HOLES2[i], HOLES2[(i + 1) % n]
        cross = (p1[0] - p0[0]) * (x[1] - p0[1]) - (p1[1] - p0[1]) * (x[0] - p0[0])
        if cross == 0:
            continue
        s = 1 if cross > 0 else -1
        if sign == 0:
            sign = s
        elif s != sign:
            return False
    return True


def interval(d):
    """The exact [min, max] of Q over the cell pair at offset d (in units of p^2)."""
    mx = max(Q((d[0] + v[0], d[1] + v[1])) for v in HOLES2)
    if _inside(d):
        mn = F(0)
    else:
        n = len(HOLES2)
        mn = min(_min_on_segment(d, HOLES2[i], HOLES2[(i + 1) % n]) for i in range(n))
    return mn, mx


def edge_set(T, reach=14):
    """Every nonzero offset whose cell pair realizes the unit distance, at 1/p = T."""
    T2 = F(T) ** 2
    out = []
    for a in range(-reach, reach + 1):
        for b in range(-reach, reach + 1):
            if (a, b) == (0, 0):
                continue
            mn, mx = interval((F(a), F(b)))
            if mn <= T2 <= mx:
                out.append((a, b))
    return out


def edge_norms(T, reach=14):
    return sorted({Q(d) for d in edge_set(T, reach)})


# ---------------------------------------------------------------- cliques


def max_clique(T, reach=6, cap=8):
    """A largest clique of G(1/T) among offsets within `reach`, capped at `cap`."""
    es = set(edge_set(T, reach))
    pts = [(a, b) for a in range(-reach, reach + 1) for b in range(-reach, reach + 1)]
    adj = {u: {v for v in pts if v != u and (v[0] - u[0], v[1] - u[1]) in es} for u in pts}
    best = [(0, 0)]

    def grow(cur, cand):
        nonlocal best
        if len(cur) > len(best):
            best = list(cur)
        if len(cur) >= cap or not cand:
            return
        for i, v in enumerate(sorted(cand)):
            if len(cur) + len(cand) - i <= len(best):
                return
            grow(cur + [v], {w for w in cand if w in adj[v] and w > v})

    for u in pts:
        grow([u], {w for w in adj[u] if w > u})
    return best


# ---------------------------------------------------------------- SAT colouring


def colour(T, k, m, n, cap=300.0):
    """Colour G(1/T) on the torus Z^2/(m,n) with k colours. A proper colouring of the
    quotient lifts to the lattice, hence to the plane."""
    es = edge_set(T)
    cells = [(i, j) for i in range(m) for j in range(n)]
    idx = {c: t for t, c in enumerate(cells)}

    def var(c, col):
        return idx[c] * k + col + 1

    clauses = []
    for c in cells:
        clauses.append([var(c, col) for col in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                clauses.append([-var(c, c1), -var(c, c2)])
    selfloop = False
    for (da, db) in es:
        if da % m == 0 and db % n == 0:
            selfloop = True
            break
        for c in cells:
            c2 = ((c[0] + da) % m, (c[1] + db) % n)
            if c2 == c:
                selfloop = True
                break
            for col in range(k):
                clauses.append([-var(c, col), -var(c2, col)])
        if selfloop:
            break
    if selfloop:
        return {"T": str(T), "k": k, "m": m, "n": n, "outcome": "torus-too-small",
                "n_edges": len(es)}
    # first-occurrence symmetry breaking over the cell order (colour-invariant)
    for t in range(1, min(len(cells), 60)):
        for col in range(1, k):
            clauses.append([-var(cells[t], col)] +
                           [var(cells[e], col - 1) for e in range(t)])
    status, model = _solve(clauses, len(cells) * k, cap)
    row = {"T": str(T), "k": k, "m": m, "n": n, "outcome": status, "n_edges": len(es),
           "edge_norms": edge_norms(T)}
    if status == "sat":
        tab = {}
        for c in cells:
            for col in range(k):
                if var(c, col) in model:
                    tab[c] = col
        bad = validate(tab, es, m, n)
        if bad:
            raise SystemExit(f"MODEL INVALID: {bad} — generator and validator disagree")
        row["table"] = [[tab[(i, j)] for j in range(n)] for i in range(m)]
        if k <= 4:
            catastrophe(row)
    return row


def validate(tab, es, m, n):
    """Independent re-check of a found colouring against the edge set."""
    for (da, db) in es:
        for c in tab:
            c2 = ((c[0] + da) % m, (c[1] + db) % n)
            if tab[c] == tab[c2]:
                return f"same colour across offset ({da},{db}) at {c}"
    return None


def catastrophe(row):
    art = load_art()
    art["status"] = "CATASTROPHE"
    art["catastrophe_row"] = row
    ART.write_text(json.dumps(art, indent=1, default=str))
    print("=" * 78 + "\nCELL-LATTICE CATASTROPHE: a k <= 4 colouring of the constraint\n"
          "graph was found and validated. A proper colouring of G(p) IS a proper\n"
          "colouring of the plane, so this contradicts the kernel theorem chi(R^2) >= 5.\n"
          "The edge criterion or the encoding is wrong. HALT. Report to Kooshi.\n" + "=" * 78)
    raise SystemExit(CATASTROPHE_EXIT)


# ---------------------------------------------------------------- artifact


def load_art():
    if ART.exists():
        return json.loads(ART.read_text())
    return {"schema": SCHEMA, "rows": [], "census": [], "status": "partial"}


def record(row):
    art = load_art()
    def _key(r):
        return (r.get("kind", "torus"), r.get("T"), r.get("k"), r.get("m"), r.get("n"),
                r.get("radius"))
    key = _key(row)
    if not any(_key(r) == key for r in art["rows"]):
        art["rows"].append(row)
        ART.write_text(json.dumps(art, indent=1, default=str))


# ---------------------------------------------------------------- self-test


def self_test():
    fails = []

    def expect(name, got, want):
        ok = got == want
        print(f"  [{'ok ' if ok else 'FAIL'}] {name}: {got!r}" +
              ("" if ok else f"  (want {want!r})"))
        if not ok:
            fails.append(name)

    print("self-test:")
    # C2, the green control: on the coarse window M38 says the edge norms are {1,3,4}
    expect("edge norms at T = 3/2 (p = 2/3, inside M38's window)",
           edge_norms(F(3, 2)), [1, 3, 4])
    expect("edge norms at T = 7/6 (p = 6/7, M37's witness scale)",
           edge_norms(F(7, 6)), [1, 3, 4])
    # the shell is a 7-clique there
    expect("clique number at T = 7/6", len(max_clique(F(7, 6), reach=3)), 7)
    # a planted red: an offset whose interval misses T^2 is not an edge
    mn, mx = interval((F(7), F(0)))
    expect("planted red: the far offset (7,0) has T^2 = 49/36 below its min",
           mn > F(7, 6) ** 2, True)
    # the min/max computation against a dense sampling of H (sampling can only refute)
    import random
    rng = random.Random(39)
    worst = None
    for _ in range(300):
        d = (F(rng.randint(-6, 6)), F(rng.randint(-6, 6)))
        mn, mx = interval(d)
        for _ in range(200):
            i = rng.randrange(6)
            j = rng.randrange(6)
            t = F(rng.randint(0, 20), 20)
            u = F(rng.randint(0, 20), 20)
            # a random convex combination of two vertices and the centre
            P = (HOLES2[i][0] * t + HOLES2[j][0] * (1 - t),
                 HOLES2[i][1] * t + HOLES2[j][1] * (1 - t))
            P = (P[0] * u, P[1] * u)
            q = Q((d[0] + P[0], d[1] + P[1]))
            if q < mn or q > mx:
                worst = (d, q, mn, mx)
    expect("300 offsets x 200 sampled points of H stay inside [min, max]", worst, None)
    print("SELF-TEST:", "ok" if not fails else f"{len(fails)} FAILURES: {fails}")
    return not fails


def sweep(cap: float = 300.0) -> None:
    """The registered campaign (§0c): the k = 4 mass red first (any SAT is catastrophe),
    then k = 6 — where a SAT would be chi(R^2) <= 6 — then k = 7, across the scales whose
    clique number leaves room."""
    scales = [F(13, 6), F(7, 3), F(5, 2), F(8, 3), F(3), F(10, 3), F(7, 2), F(4),
              F(9, 2), F(5), F(6), F(7)]
    print("mass red: k = 4 must refuse at every scale (a SAT contradicts chi >= 5)")
    for T in scales[:6]:
        r = colour(T, 4, 12, 12, cap)
        record(r)
        print(f"  T={T} k=4 12x12 -> {r['outcome']}", flush=True)
    for k in (6, 7):
        print(f"k = {k}:")
        for T in scales:
            for (m, n) in ((12, 12), (18, 18)):
                r = colour(T, k, m, n, cap)
                record(r)
                print(f"  T={T!s:>6} k={k} {m}x{n} edges={r['n_edges']:>4} "
                      f"-> {r['outcome']}", flush=True)
                if r["outcome"] == "sat":
                    print("=" * 78, flush=True)
                    print(f"  {k}-COLOURING OF THE CONSTRAINT GRAPH FOUND at p = 1/{T}.",
                          flush=True)
                    if k <= 6:
                        print("  READ THIS BEFORE INTERPRETING: a proper colouring of\n"
                              "  G(p) IS a proper colouring of the plane, so this is a\n"
                              "  claim that chi(R^2) <= " + str(k) + " — open since 1950.\n"
                              "  It is a CANDIDATE until the edge set is re-derived\n"
                              "  independently and the lift is checked. HALT and report.",
                              flush=True)
                    print("=" * 78, flush=True)
                    break
    art = load_art()
    art["status"] = "done"
    ART.write_text(json.dumps(art, indent=1, default=str))
    print(f"campaign complete -> {ART.name}")


def patch(T, k, radius, cap=600.0):
    """Refute k colours on a finite BALL of addresses. Unlike a torus refusal this is a
    statement about the graph itself: no periodicity is assumed, so an unsat here means
    chi(G(1/T)) > k outright."""
    es = set(edge_set(T))
    pts = [(a, b) for a in range(-radius, radius + 1) for b in range(-radius, radius + 1)
           if Q((a, b)) <= radius * radius]
    idx = {c: t for t, c in enumerate(pts)}
    clauses = []
    for c in pts:
        clauses.append([idx[c] * k + col + 1 for col in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                clauses.append([-(idx[c] * k + c1 + 1), -(idx[c] * k + c2 + 1)])
    npairs = 0
    for u in pts:
        for (da, db) in es:
            v = (u[0] + da, u[1] + db)
            if v in idx and idx[v] > idx[u]:
                npairs += 1
                for col in range(k):
                    clauses.append([-(idx[u] * k + col + 1), -(idx[v] * k + col + 1)])
    for t in range(1, min(len(pts), 40)):
        for col in range(1, k):
            clauses.append([-(idx[pts[t]] * k + col + 1)] +
                           [idx[pts[e]] * k + col for e in range(t)])
    import time
    t0 = time.time()
    status, _ = _solve(clauses, len(pts) * k, cap)
    return {"kind": "patch", "T": str(T), "k": k, "radius": radius, "n_vertices": len(pts),
            "n_pairs": npairs, "outcome": status, "seconds": round(time.time() - t0, 2)}


# ---------------------------------------------------------------- census / CLI


def census(Ts):
    art = load_art()
    rows = []
    print(f"{'T = 1/p':>10} {'p':>8}  {'edge norms':<44} {'omega':>5}")
    for T in Ts:
        norms = edge_norms(T)
        w = len(max_clique(T, reach=4))
        shown = str(norms if len(norms) <= 10 else norms[:10] + ["..."])
        print(f"{str(T):>10} {float(1/T):>8.4f}  {shown:<44} {w:>5}", flush=True)
        rows.append({"T": str(T), "p": float(1 / T), "edge_norms": norms, "omega": w})
    art["census"] = rows
    ART.write_text(json.dumps(art, indent=1, default=str))
    return rows


def status():
    art = load_art()
    print(f"{ART.name}: {len(art.get('rows', []))} colouring rows, "
          f"{len(art.get('census', []))} census rows, status {art.get('status')}")
    print("run nothing by default; see --help")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--census", action="store_true")
    ap.add_argument("--sweep", action="store_true")
    ap.add_argument("--patch", nargs=3, metavar=("T", "K", "R"))
    ap.add_argument("--colour", nargs=4, metavar=("T", "K", "M", "N"))
    ap.add_argument("--cap", type=float, default=300.0)
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    elif args.census:
        Ts = [F(n, 6) for n in range(7, 61)]
        census(Ts)
    elif args.sweep:
        sweep(args.cap)
    elif args.patch:
        r = patch(F(args.patch[0]), int(args.patch[1]), int(args.patch[2]), args.cap)
        record(r)
        print(json.dumps(r, indent=1, default=str))
    elif args.colour:
        T = F(args.colour[0])
        r = colour(T, int(args.colour[1]), int(args.colour[2]), int(args.colour[3]),
                   args.cap)
        record(r)
        print(json.dumps({k: v for k, v in r.items() if k != "table"}, indent=1,
                         default=str))
    else:
        status()


if __name__ == "__main__":
    main()
