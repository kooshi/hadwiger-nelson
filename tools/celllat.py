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
    es = set(edge_set40(T))  # I1 (M43): reach-correct; the fixed reach 14 clips at T >= 11
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


# ================================================================ M40: the chi > omega hunt
# (plans/M40-chi-omega-hunt.md — everything below writes to build/m40-chiomega.json and
#  leaves the M39 artifact frozen as the historical record. Bands are keyed by
#  POINT-GROUP CLASS, not norm (§0f A1): distinct dihedral classes share a norm with
#  different thresholds, first at 49.)

ART40 = BUILD / "m40-chiomega.json"
SCHEMA40 = ("m40-chiomega v1 (plans/M40-chi-omega-hunt.md). The unit of claim is the BAND "
            "(open T^2 interval between class thresholds); G(p) is one fixed graph per "
            "band. The corrected census SUPERSEDES m39-cells.json's `census` array, whose "
            "omega values were box- and cap-clipped (M39's kernel windows are unaffected). "
            "chi(R^2) <= chi(G(p)) for every p: any k <= 6 colouring found here is a "
            "chi(R^2) <= 6 candidate and must be halted on, not celebrated.")


def load_art40():
    if ART40.exists():
        return json.loads(ART40.read_text())
    return {"schema": SCHEMA40, "bands": [], "census": [], "rows": [], "cores": [],
            "colourings": [], "alpha": [], "spectral": [], "status": "partial"}


def save_art40(art):
    ART40.write_text(json.dumps(art, indent=1, default=str))


def record40(section, row):
    art = load_art40()
    art[section].append(row)
    save_art40(art)


# ---------------------------------------------------------------- point-group classes


def rot6(v):
    """Multiplication by zeta6 in address coordinates: (a,b) -> (-b, a+b)."""
    return (-v[1], v[0] + v[1])


def refl(v):
    """Conjugation (the a<->b dihedral reflection): (a,b) -> (a+b, -b)."""
    return (v[0] + v[1], -v[1])


def orbit(v):
    """The dihedral (order-12) orbit of an offset."""
    out, cur = set(), v
    for _ in range(6):
        cur = rot6(cur)
        out.add(cur)
        out.add(refl(cur))
    return out


def canon(v):
    """Canonical representative: lexicographic min of the orbit."""
    return min(orbit(v))


def edge_reach(T):
    """A reach guaranteed to contain every edge offset (coords bound 2r/sqrt3)."""
    import math
    return int(2 * (float(T) + 1.1548) / math.sqrt(3)) + 2


_ES40 = {}


def edge_set40(T):
    if T not in _ES40:
        _ES40[T] = edge_set(T, reach=edge_reach(T))
    return _ES40[T]


# ---------------------------------------------------------------- corrected cliques


def max_clique40(T, cap=13):
    """Exhaustive max clique (any clique translates to contain 0 and then lives in the
    edge norm-ball, so a box of edge_reach suffices). Returns the clique itself."""
    reach = edge_reach(T)
    es = set(edge_set(T, reach=reach))
    r2 = (float(T) + 1.1548) ** 2
    pts = [(a, b) for a in range(-reach, reach + 1) for b in range(-reach, reach + 1)
           if float(Q((a, b))) <= r2 + 1e-9]
    adj = {u: {v for v in pts if v != u and (v[0] - u[0], v[1] - u[1]) in es} for u in pts}
    best = []

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

    # lex order is translation-invariant, so every clique class has a translate whose
    # lex-least member is the origin: growing from (0,0) with candidates > (0,0) is
    # exhaustive over clique classes, and the norm-ball box contains that translate.
    grow([(0, 0)], {w for w in adj[(0, 0)] if w > (0, 0)})
    return best


# ---------------------------------------------------------------- bands


def class_reps(T2max):
    """Canonical reps of every offset class whose threshold window intersects (0, T2max]."""
    import math
    reach = int(2 * (math.sqrt(float(T2max)) + 1.1548) / math.sqrt(3)) + 2
    reps = {}
    for a in range(-reach, reach + 1):
        for b in range(-reach, reach + 1):
            if (a, b) == (0, 0):
                continue
            c = canon((a, b))
            if c not in reps:
                mn, mx = interval((F(a), F(b)))
                if mn <= T2max:
                    reps[c] = (mn, mx)
    return reps


def bands(T2max=F(50)):
    """The band decomposition: open T^2 intervals between consecutive class thresholds,
    each with its constant edge-class set."""
    reps = class_reps(T2max)
    cuts = sorted({v for mn, mx in reps.values() for v in (mn, mx) if v <= T2max})
    cuts = [c for c in cuts if c > 0]
    out = []
    lo = F(0)
    for hi in cuts + [T2max]:
        if hi <= lo:
            continue
        mid = (lo + hi) / 2
        cls = sorted(c for c, (mn, mx) in reps.items() if mn <= mid <= mx)
        if cls:
            out.append({"t2_lo": str(lo), "t2_hi": str(hi),
                        "p_lo": float(1 / hi ** F(1, 2)) if hi > 0 else None,
                        "p_hi": float(1 / lo ** F(1, 2)) if lo > 0 else None,
                        "classes": [list(c) for c in cls],
                        "norms": sorted({int(Q(c)) for c in cls})})
        lo = hi
    return out


# ---------------------------------------------------------------- shrink engine


def _ball_clauses(T, k, pts, idx, break_sym=True):
    es = set(edge_set40(T))
    clauses = []
    for c in pts:
        clauses.append([idx[c] * k + col + 1 for col in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                clauses.append([-(idx[c] * k + c1 + 1), -(idx[c] * k + c2 + 1)])
    for u in pts:
        for (da, db) in es:
            v = (u[0] + da, u[1] + db)
            if v in idx and idx[v] > idx[u]:
                for col in range(k):
                    clauses.append([-(idx[u] * k + col + 1), -(idx[v] * k + col + 1)])
    if break_sym:
        for t in range(1, min(len(pts), 40)):
            for col in range(1, k):
                clauses.append([-(idx[pts[t]] * k + col + 1)] +
                               [idx[pts[e]] * k + col for e in range(t)])
    return clauses


def _ball_status(T, k, pts, cap):
    idx = {c: t for t, c in enumerate(pts)}
    status, _ = _solve(_ball_clauses(T, k, pts, idx), len(pts) * k, cap)
    return status


def _ball_status_pinned(T, k, pts, cap, pin_tri):
    """Pinned ask (A3a): pin_tri must be the first three of pts, colours 0,1,2 —
    sound iff the three are pairwise adjacent AND present, which the caller protects."""
    idx = {c: t for t, c in enumerate(pts)}
    cl = _ball_clauses(T, k, pts, idx, break_sym=True)
    for i in range(3):
        cl.append([idx[pin_tri[i]] * k + i + 1])
    status, _ = _solve(cl, len(pts) * k, cap)
    return status


def shrink(T, k, radius, cap=300.0, pin=False):
    """1-minimal core of the ball refutation of k colours at scale 1/T. Sound because
    first-occurrence breaking is colour-invariant. With pin=True (M43) the D4 triangle
    is pinned for solver speed and PROTECTED from deletion; the pinned ask is
    equivalent to the plain one while the triangle is intact (A3a), so the core is
    1-minimal relative to the protected three, and the final certification re-asks
    every verdict. The final core is re-certified: the core itself must be unsat, and
    every single-vertex deletion must be SAT."""
    T = F(T)
    bx = int(1.1548 * radius) + 2  # M43: the [-R,R]^2 box CLIPS the hex Q-ball
    pts = [(a, b) for a in range(-bx, bx + 1) for b in range(-bx, bx + 1)
           if Q((a, b)) <= radius * radius]
    pts.sort(key=lambda v: (Q(v), v))
    protected = set()
    if pin:
        tri = triangle_for(band_of(T))
        protected = set(tri)
        pts = tri + [p for p in pts if p not in protected]
        ask = lambda ps: _ball_status_pinned(T, k, ps, cap, tri)
    else:
        ask = lambda ps: _ball_status(T, k, ps, cap)
    st = ask(pts)
    if st != "unsat":
        return {"kind": "core", "T": str(T), "k": k, "radius": radius,
                "outcome": f"base-{st}", "note": "ball does not refute; nothing to shrink"}
    cur = list(pts)
    # batched destructive pass (delta-debugging), outside-in; an unknown verdict keeps
    # the batch conservatively (sound: the surviving set still refutes)
    batch = max(1, len(pts) // 8)
    while batch >= 1:
        progress = True
        while progress:
            progress = False
            order = sorted((w for w in cur if w not in protected),
                           key=lambda w: (-Q(w), w))
            i = 0
            while i < len(order):
                chunk = [v for v in order[i:i + batch] if v in cur]
                if chunk and len(cur) - len(chunk) >= 1:
                    trial = [w for w in cur if w not in set(chunk)]
                    if ask(trial) == "unsat":
                        cur = trial
                        progress = progress or batch > 1
                i += batch
        batch //= 2
    # protected pin vertices: attempt their deletion UNPINNED (a pin vertex cannot be
    # deleted under its own pin) — small cores usually decide plain
    for v in list(protected):
        if len(cur) > 1:
            trial = [w for w in cur if w != v]
            if _ball_status(T, k, trial, cap) == "unsat":
                cur = trial
                protected.discard(v)
    # certification: core unsat, every deletion sat (per-vertex necessity witnesses);
    # protected members are certified with the UNPINNED ask
    assert ask(cur) == "unsat"

    def _necessary(v):
        trial = [w for w in cur if w != v]
        if v in protected:  # cannot ask under the pin it belongs to
            return _ball_status(T, k, trial, cap) == "sat"
        return ask(trial) == "sat"

    necessity = all(_necessary(v) for v in cur)
    # raw second-encoding attempt on the final core (no break, no pin) — honest verdict
    idxr = {c: t for t, c in enumerate(cur)}
    raw, _ = _solve(_ball_clauses(T, k, cur, idxr, break_sym=False),
                    len(cur) * k, cap * 4)
    orbs = {}
    for v in cur:
        orbs.setdefault(canon(v), []).append(v)
    return {"kind": "core", "T": str(T), "k": k, "radius": radius, "outcome": "core",
            "n_core": len(cur), "one_minimal": necessity, "pinned_shrink": pin,
            "raw_unsat_confirmed": raw,
            "core": [list(v) for v in sorted(cur)],
            "orbit_profile": sorted((int(Q(c)), len(vs)) for c, vs in orbs.items()),
            "n_orbits": len(orbs)}


# ---------------------------------------------------------------- colouring anatomy


def extract(T, k, m, n, cap=600.0):
    """Re-derive a torus colouring and anatomize it: class sizes, stabilizer sublattice
    (all torus translations fixing the colouring as a partition), coset structure."""
    r = colour(T, k, m, n, cap)
    if r["outcome"] != "sat":
        return {"kind": "colouring", "T": str(T), "k": k, "m": m, "n": n,
                "outcome": r["outcome"]}
    tab = r["table"]
    sizes = sorted([sum(1 for i in range(m) for j in range(n) if tab[i][j] == c)
                    for c in range(k)])
    # stabilizer as a PARTITION: translation t fixes the colouring iff it induces a
    # well-defined permutation of the colour classes
    stab = []
    for dx in range(m):
        for dy in range(n):
            perm = {}
            ok = True
            for i in range(m):
                for j in range(n):
                    a, b = tab[i][j], tab[(i + dx) % m][(j + dy) % n]
                    if a in perm and perm[a] != b:
                        ok = False
                        break
                    perm[a] = b
                if not ok:
                    break
            if ok:
                stab.append((dx, dy, "id" if all(a == b for a, b in perm.items())
                             else "perm"))
    strict = [(dx, dy) for dx, dy, kind in stab if kind == "id"]
    return {"kind": "colouring", "T": str(T), "k": k, "m": m, "n": n, "outcome": "sat",
            "class_sizes": sizes, "n_stab_partition": len(stab),
            "n_stab_strict": len(strict), "stab_strict": strict,
            "stab_partition": [[dx, dy, kd] for dx, dy, kd in stab],
            "table": tab}


# ---------------------------------------------------------------- exact alpha (torus)


def _atmost(lits, R, top):
    """Sinz sequential counter: at most R of lits are true. Returns (clauses, new_top)."""
    n = len(lits)
    if R >= n:
        return [], top
    if R < 0:
        return [[-l] for l in lits] if R == -1 else [[]], top
    s = [[0] * (R + 1) for _ in range(n)]  # s[i][j], j in 1..R -> var
    for i in range(n):
        for j in range(1, R + 1):
            top += 1
            s[i][j] = top
    cls = []
    for i in range(n):
        li = lits[i]
        if i == 0:
            cls.append([-li, s[0][1]])
        else:
            cls.append([-li, s[i][1]])
            for j in range(1, R + 1):
                cls.append([-s[i - 1][j], s[i][j]])
            for j in range(2, R + 1):
                cls.append([-s[i - 1][j - 1], -li, s[i][j]])
            cls.append([-s[i - 1][R], -li])
    return cls, top


def alpha(T, m, n, cap=600.0):
    """Exact independence number of the torus quotient, by SAT binary search with a
    certified UNSAT/SAT bracket. chi_f(torus) = m*n/alpha (vertex-transitive)."""
    es = edge_set40(T)
    cells = [(i, j) for i in range(m) for j in range(n)]
    idx = {c: t + 1 for t, c in enumerate(cells)}
    base = []
    for (da, db) in es:
        for c in cells:
            c2 = ((c[0] + da) % m, (c[1] + db) % n)
            if c2 == c:
                return {"kind": "alpha", "T": str(T), "m": m, "n": n,
                        "outcome": "torus-too-small"}
            if idx[c2] > idx[c]:
                base.append([-idx[c], -idx[c2]])
    N = len(cells)

    def ask(K):
        """SAT iff an independent set of size >= K exists (at most N-K zeros)."""
        neg = [-idx[c] for c in cells]
        cls, top = _atmost(neg, N - K, N)
        status, _ = _solve(base + cls, top, cap)
        return status

    lo, hi = 1, N  # invariant: ask(lo) = sat, ask(hi+1) would be unsat
    # greedy for a decent lower start
    taken, forbidden = [], set()
    for c in cells:
        if c not in forbidden:
            taken.append(c)
            for (da, db) in es:
                forbidden.add(((c[0] + da) % m, (c[1] + db) % n))
    lo = len(taken)
    hi = N
    while lo < hi:
        mid = (lo + hi + 1) // 2
        st = ask(mid)
        if st == "sat":
            lo = mid
        elif st == "unsat":
            hi = mid - 1
        else:
            return {"kind": "alpha", "T": str(T), "m": m, "n": n,
                    "outcome": f"unknown-at-{mid}", "bracket": [lo, hi]}
    return {"kind": "alpha", "T": str(T), "m": m, "n": n, "outcome": "exact",
            "alpha": lo, "N": N, "chi_f_torus": round(N / lo, 4)}


# ---------------------------------------------------------------- spectral (Hoffman)


def _cos_range_turns(lo, hi):
    """Range of cos(2 pi t) for t in [lo, hi] (floats, turns)."""
    import math
    if hi - lo >= 1.0:
        return (-1.0, 1.0)
    vals = [math.cos(2 * math.pi * lo), math.cos(2 * math.pi * hi)]
    kmin = math.ceil(2 * lo)  # turning points at t = k/2
    k = kmin
    while k <= 2 * hi:
        vals.append(1.0 if k % 2 == 0 else -1.0)
        k += 1
    return (min(vals), max(vals))


def spectral(T, tol=0.02, max_boxes=400_000):
    """Certified bracket on lambda_min of the band's Cayley graph, and the Hoffman
    chromatic bound chi >= 1 + d/(-lambda_min). The claimable bound uses the bracket's
    LOWER end (D6/A4: x/(d+x) monotone)."""
    import heapq
    import math
    S = edge_set40(T)
    d = len(S)

    def lam(t1, t2):
        return sum(math.cos(2 * math.pi * (a * t1 + b * t2)) for (a, b) in S)

    def box_lower(b):
        (l1, u1, l2, u2) = b
        lo = 0.0
        for (a, b2) in S:
            plo = a * (l1 if a >= 0 else u1) + b2 * (l2 if b2 >= 0 else u2)
            phi = a * (u1 if a >= 0 else l1) + b2 * (u2 if b2 >= 0 else l2)
            lo += _cos_range_turns(plo, phi)[0]
        return lo

    best_val = lam(0.5, 0.5)
    for i in range(24):
        for j in range(24):
            best_val = min(best_val, lam(i / 24, j / 24))
    heap = [(box_lower((0.0, 1.0, 0.0, 1.0)), (0.0, 1.0, 0.0, 1.0))]
    boxes = 0
    while heap and boxes < max_boxes:
        lo, (l1, u1, l2, u2) = heapq.heappop(heap)
        if lo >= best_val - tol:
            break
        boxes += 1
        m1, m2 = (l1 + u1) / 2, (l2 + u2) / 2
        best_val = min(best_val, lam(m1, m2))
        for nb in ((l1, m1, l2, m2), (m1, u1, l2, m2), (l1, m1, m2, u2),
                   (m1, u1, m2, u2)):
            bl = box_lower(nb)
            if bl < best_val - tol:
                heapq.heappush(heap, (bl, nb))
    lam_lo = min([lo for lo, _ in heap], default=best_val - tol)
    lam_lo = min(lam_lo, best_val)
    converged = not heap or all(lo >= best_val - tol for lo, _ in heap)
    bound_claim = 1 + d / (-lam_lo) if lam_lo < 0 else None
    return {"kind": "spectral", "T": str(T), "d": d,
            "lam_min_bracket": [round(lam_lo, 4), round(best_val, 4)],
            "converged": converged, "n_boxes": boxes,
            "hoffman_chi_lower": round(bound_claim, 4) if bound_claim else None}


# ---------------------------------------------------------------- M40 self-test


def self_test40():
    fails = []

    def expect(name, got, want):
        ok = got == want
        print(f"  [{'ok ' if ok else 'FAIL'}] {name}: {got!r}" +
              ("" if ok else f"  (want {want!r})"))
        if not ok:
            fails.append(name)

    print("M40 self-test:")
    # D1: the hand-derived threshold table, exactly
    for (v, mn, mx) in [((1, 0), F(0), F(13, 3)), ((1, 1), F(1, 3), F(25, 3)),
                        ((2, 0), F(1), F(28, 3)), ((1, 2), F(7, 3), F(43, 3)),
                        ((3, 0), F(4), F(49, 3)), ((2, 2), F(16, 3), F(64, 3)),
                        ((3, 1), F(19, 3), F(67, 3))]:
        got = interval((F(v[0]), F(v[1])))
        expect(f"D1 threshold interval for {v}", got, (mn, mx))
    # A1 planted check: norm 49 has two classes with DIFFERENT thresholds
    i70 = interval((F(7), F(0)))
    i35 = interval((F(3), F(5)))
    expect("A1: canon separates (7,0) and (3,5)", canon((7, 0)) != canon((3, 5)), True)
    expect("A1: norm-49 classes have different min thresholds", i70[0] != i35[0], True)
    expect("A1: (7,0) min is 36", i70[0], F(36))
    # D2: the side-3 triangle's 45 pairwise difference norms all lie in {1,3,4,7,9}
    tri = [(a, b) for a in range(4) for b in range(4) if a + b <= 3]
    expect("D2: the side-3 triangle has 10 points", len(tri), 10)
    dn = sorted({int(Q((u[0] - v[0], u[1] - v[1]))) for u, v in combinations(tri, 2)})
    expect("D2: its difference norms are exactly {1,3,4,7,9}", dn, [1, 3, 4, 7, 9])
    # D2: on the band (4, 13/3) those are exactly the edge norms
    expect("D2: edge norms at T = 41/20 are {1,3,4,7,9}",
           edge_norms(F(41, 20)), [1, 3, 4, 7, 9])
    # D3: G* band
    expect("D3: edge norms at T = 13/6 are {3,4,7,9}", edge_norms(F(13, 6)), [3, 4, 7, 9])
    # A2: an edge class always yields its equilateral triangle (associates)
    u = (3, 3)
    v = rot6(u)
    expect("A2: zeta6*(3,3) = (-3,6)", v, (-3, 6))
    expect("A2: all three sides of {0,u,zeta6 u} share norm 27",
           {int(Q(u)), int(Q(v)), int(Q((u[0] - v[0], u[1] - v[1])))}, {27})
    # the old census's reach-4 box provably clipped this triangle at T = 6
    es6 = set(edge_set40(F(6)))
    expect("D4: norm-27 offsets are edges at T = 6", u in es6 and v in es6, True)
    # sequential counter sanity: alpha of a 4-cycle (torus 2x2 with unit edges) is...
    # (cheap structural check: atmost(2 of 3) blocks all-three)
    cls, top = _atmost([1, 2, 3], 2, 3)
    st, _ = _solve([[1], [2], [3]] + cls, top, 60)
    expect("_atmost(3 lits, R=2) refuses all-three", st, "unsat")
    cls, top = _atmost([1, 2, 3], 2, 3)
    st, _ = _solve([[1], [2], [-3]] + cls, top, 60)
    expect("_atmost(3 lits, R=2) allows two", st, "sat")
    print("M40 SELF-TEST:", "ok" if not fails else f"{len(fails)} FAILURES: {fails}")
    return not fails


# ================================================================ M43: the fine-tail campaign
# (plans/M43-fine-tail.md — the from-above six-hunt at the 1/7 flanks and the unprobed
#  tail. Rows are MEASUREMENTS keyed by band (A5: explicit claim_scope — balls are
#  outright, tori are period-bounded); the transfer poset is a DERIVED section (A1).
#  Any k <= 6 torus SAT is a chi(R^2) <= 6 candidate: HALT AND VERIFY, never celebrate.)

ART43 = BUILD / "m43-finetail.json"
SCHEMA43 = ("m43-finetail v1 (plans/M43-fine-tail.md §0). Unit of claim: the BAND (open "
            "T^2 interval, canonical class reps). Rows are measurements only; `transfers` "
            "is derived (subset containments). claim_scope: `outright` = ball UNSAT, a "
            "statement about G(band) itself; `period-bounded` = torus verdicts, bounded "
            "by the swept period lattices; `none` = unknown/sat-patch. Any k <= 6 SAT on "
            "any torus IS a chi(R^2) <= 6 candidate — the halt-and-verify clause (P6) "
            "applies verbatim, before any interpretation.")


def load_art43():
    if ART43.exists():
        return json.loads(ART43.read_text())
    return {"schema": SCHEMA43, "rows": [], "transfers": [], "census": [], "sweeps": []}


def record43(section, row):
    import fcntl
    lock = ART43.with_suffix(".lock")
    with open(lock, "w") as lf:
        fcntl.flock(lf, fcntl.LOCK_EX)  # concurrent campaigns must not lose rows
        art = load_art43()
        art.setdefault(section, []).append(row)
        ART43.write_text(json.dumps(art, indent=1, default=str))


_BAND_CACHE = {}


def band_of(T):
    """The open band containing T^2 (id: exact interval + canonical classes). Boundary
    scales belong to NO band and are refused (§0d)."""
    T = F(T)
    if T in _BAND_CACHE:
        return _BAND_CACHE[T]
    T2 = T * T
    for b in bands(T2max=T2 * 2 + 10):
        if F(b["t2_lo"]) < T2 < F(b["t2_hi"]):
            _BAND_CACHE[T] = b
            return b
    raise SystemExit(f"T = {T}: boundary scale or out of range — belongs to no band")


def canonical_T(b):
    """The smallest-denominator rational T with T^2 interior to the band (A2: the probe
    scale is a coordinate, not a claim; this makes it a function of the band)."""
    lo2, hi2 = F(b["t2_lo"]), F(b["t2_hi"])
    a, b_, c, d = 0, 1, 1, 0  # Stern-Brocot: lo = a/b_, hi = c/d
    while True:
        m = F(a + c, b_ + d)
        if m * m <= lo2:
            a, b_ = m.numerator, m.denominator
        elif m * m >= hi2:
            c, d = m.numerator, m.denominator
        else:
            return m


def sector_rep(v):
    """The orbit member with 0 <= a <= b (unique per class; the registered-table
    convention — `canon` uses lex-min, which lands in a different sector)."""
    return next(o for o in sorted(orbit(v)) if 0 <= o[0] <= o[1])


def triangle_for(b):
    """The D4/A2 pin triangle {0, u, zeta6 u} for a band, u its least edge class (all
    three sides are associates of u, hence the same class, hence edges)."""
    u = min((sector_rep(tuple(v)) for v in b["classes"]), key=lambda v: (Q(v), v))
    return [(0, 0), u, rot6(u)]


def ball43(T, k, R, cap=600.0, pin=True, enc="direct"):
    """Ball probe at scale 1/T, reach-correct edge set (I1). UNSAT = chi(G(band)) > k
    OUTRIGHT (no periodicity). enc `direct`: optional triangle pin at the HEAD of the
    vertex order (A3a) + first-occurrence breaking. enc `a1`: the centre-deletion form
    (A3b) — delete (0,0), forbid colour k-1 on its neighbourhood, first-occurrence over
    colours 0..k-2 only, NO pin; exact by A1 unconditional + the omit-transposition."""
    T = F(T)
    b = band_of(T)
    es = set(edge_set40(T))
    # the Q-ball needs a WIDER coordinate box: Q >= (3/4) max(x,y)^2, so |x| <= 2R/sqrt3
    # (a [-R,R]^2 box CLIPS the hex ball — caught by this file's own self-test)
    bx = int(1.1548 * R) + 2
    pts = [(x, y) for x in range(-bx, bx + 1) for y in range(-bx, bx + 1)
           if Q((x, y)) <= R * R]
    pts.sort(key=lambda v: (Q(v), v))
    row = {"kind": "ball", "band": {"t2_lo": b["t2_lo"], "t2_hi": b["t2_hi"],
           "classes": b["classes"]}, "T": str(T), "k": k, "R": R, "enc": enc,
           "pin": bool(pin and enc == "direct"), "cap": cap}
    if enc == "a1":
        centre = (0, 0)
        nbrs = [e for e in es if Q(e) <= R * R]
        pts = [p for p in pts if p != centre]
        idx = {c: t for t, c in enumerate(pts)}
        clauses = []
        for c in pts:
            clauses.append([idx[c] * k + col + 1 for col in range(k)])
            for c1 in range(k):
                for c2 in range(c1 + 1, k):
                    clauses.append([-(idx[c] * k + c1 + 1), -(idx[c] * k + c2 + 1)])
        for u in pts:
            for (da, db) in es:
                v = (u[0] + da, u[1] + db)
                if v in idx and idx[v] > idx[u]:
                    for col in range(k):
                        clauses.append([-(idx[u] * k + col + 1),
                                        -(idx[v] * k + col + 1)])
        for e in nbrs:  # N(centre) confined to colours 0..k-2
            clauses.append([-(idx[e] * k + (k - 1) + 1)])
        for t in range(1, min(len(pts), 40)):  # chain over colours 0..k-2 only
            for col in range(1, k - 1):
                clauses.append([-(idx[pts[t]] * k + col + 1)] +
                               [idx[pts[e]] * k + col for e in range(t)])
        nvars = len(pts) * k
    else:
        if pin:
            head = triangle_for(b)
            if any(Q(v) > R * R for v in head):
                raise SystemExit(f"pin triangle {head} outside ball R={R}")
            rest = [p for p in pts if p not in set(head)]
            pts = head + rest
        idx = {c: t for t, c in enumerate(pts)}
        clauses = _ball_clauses(T, k, pts, idx)
        if pin:
            for i in range(3):
                clauses.append([idx[pts[i]] * k + i + 1])
        nvars = len(pts) * k
    import time
    t0 = time.time()
    status, _ = _solve(clauses, nvars, cap)
    row.update({"n_vertices": len(pts), "outcome": status,
                "claim_scope": "outright" if status == "unsat" else "none",
                "seconds": round(time.time() - t0, 2)})
    return row


def _hnf_reduce(x, y, d1, s, d2):
    q = y // d2
    return ((x - q * s) % d1, y - q * d2)


def hnf_colour(T, k, d1, s, d2, cap=60.0):
    """Colour the quotient Z^2/L, L = <(d1,0),(s,d2)> in HNF (0 <= s < d1, det = d1*d2).
    A proper colouring lifts L-periodically to the lattice, hence colours the plane.
    Degenerate quotients (an edge offset INSIDE L — a self-loop) are REFUSED (A4).
    Any k <= 6 SAT is validated against a freshly recomputed edge criterion and
    flagged JACKPOT (P6: halt and verify)."""
    T = F(T)
    b = band_of(T)
    es = edge_set40(T)
    for (da, db) in es:
        if db % d2 == 0 and (da - (db // d2) * s) % d1 == 0:
            return {"kind": "hnf", "T": str(T), "k": k, "L": [d1, s, d2],
                    "det": d1 * d2, "outcome": "degenerate", "offset": [da, db],
                    "claim_scope": "none"}
    cells = [(i, j) for i in range(d1) for j in range(d2)]
    idx = {c: t for t, c in enumerate(cells)}
    pairs = set()
    for u in cells:
        for (da, db) in es:
            v = _hnf_reduce(u[0] + da, u[1] + db, d1, s, d2)
            if v != u:
                pairs.add((min(idx[u], idx[v]), max(idx[u], idx[v])))
    clauses = []
    for c in cells:
        clauses.append([idx[c] * k + col + 1 for col in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                clauses.append([-(idx[c] * k + c1 + 1), -(idx[c] * k + c2 + 1)])
    for (i, j) in pairs:
        for col in range(k):
            clauses.append([-(i * k + col + 1), -(j * k + col + 1)])
    for t in range(1, min(len(cells), 60)):
        for col in range(1, k):
            clauses.append([-(idx[cells[t]] * k + col + 1)] +
                           [idx[cells[e]] * k + col for e in range(t)])
    import time
    t0 = time.time()
    status, model = _solve(clauses, len(cells) * k, cap)
    row = {"kind": "hnf", "band": {"t2_lo": b["t2_lo"], "t2_hi": b["t2_hi"],
           "classes": b["classes"]}, "T": str(T), "k": k, "L": [d1, s, d2],
           "det": d1 * d2, "outcome": status, "cap": cap,
           "claim_scope": "period-bounded" if status == "unsat" else "none",
           "seconds": round(time.time() - t0, 2)}
    if status == "sat":
        tab = {c: col for c in cells for col in range(k)
               if (idx[c] * k + col + 1) in model}
        # fresh-path validation: recompute the criterion per offset, no cache
        T2 = T * T
        reach = edge_reach(T)
        for a in range(-reach, reach + 1):
            for bb in range(-reach, reach + 1):
                if (a, bb) == (0, 0):
                    continue
                mn, mx = interval((F(a), F(bb)))
                if mn <= T2 <= mx:
                    for c in cells:
                        v = _hnf_reduce(c[0] + a, c[1] + bb, d1, s, d2)
                        if tab[c] == tab[v]:
                            raise SystemExit(
                                f"MODEL INVALID at offset ({a},{bb}) cell {c} — "
                                "generator and fresh validator disagree")
        row["table"] = [[tab[(i, j)] for j in range(d2)] for i in range(d1)]
        if k <= 6:
            row["JACKPOT"] = ("k <= 6 torus SAT: chi(R^2) <= 6 CANDIDATE. HALT AND "
                              "VERIFY (P6) — independent re-derivation before any "
                              "interpretation.")
    return row


def _ask43(spec):
    kind = spec[0]
    try:
        if kind == "hnf":
            return hnf_colour(*spec[1:])
        if kind == "ball":
            T, k, R, cap, pin, enc = spec[1:]
            return ball43(T, k, R, cap=cap, pin=pin, enc=enc)
    except SystemExit as e:  # a worker must not kill the pool silently
        return {"kind": kind, "outcome": "ERROR", "error": str(e), "spec": repr(spec)}
    raise ValueError(kind)


def _divisors(n):
    return [d for d in range(1, n + 1) if n % d == 0]


def skew_sweep(T, k, det_lo, det_hi, cap=60.0, workers=10):
    """ALL HNF sublattices with det in [det_lo, det_hi] at scale 1/T, colours k —
    exhaustive over periodic colourings of index <= det_hi when det_lo covers the
    floor. Aggregated per det; ANY sat halts the sweep (P6). Mass-red control: the
    first non-degenerate lattice of each sweep is also asked at k = 4 (must refuse)."""
    from concurrent.futures import ProcessPoolExecutor
    T = F(T)
    b = band_of(T)
    summary = {"kind": "skew-sweep", "band": {"t2_lo": b["t2_lo"], "t2_hi": b["t2_hi"]},
               "T": str(T), "k": k, "det_range": [det_lo, det_hi], "cap": cap,
               "per_det": [], "halted_sat": None, "massred": None}
    control_done = False
    with ProcessPoolExecutor(max_workers=workers) as ex:
        for det in range(det_lo, det_hi + 1):
            specs = [("hnf", T, k, det // d2, s, d2, cap)
                     for d2 in _divisors(det) for s in range(det // d2)]
            rows = list(ex.map(_ask43, specs))
            agg = {"det": det, "n": len(rows),
                   "degenerate": sum(r["outcome"] == "degenerate" for r in rows),
                   "unsat": sum(r["outcome"] == "unsat" for r in rows),
                   "unknown": sum(r["outcome"] == "unknown" for r in rows),
                   "error": sum(r["outcome"] == "ERROR" for r in rows)}
            sats = [r for r in rows if r["outcome"] == "sat"]
            if not control_done:
                nd = next((r for r in rows if r["outcome"] != "degenerate"), None)
                if nd is not None:
                    c = hnf_colour(T, 4, *nd["L"], cap=max(cap, 120.0))
                    summary["massred"] = {"L": nd["L"], "outcome": c["outcome"]}
                    if c["outcome"] == "sat":
                        raise SystemExit("MASS-RED VIOLATED: k=4 sat on a torus — "
                                         "instrument bug, halting")
                    control_done = True
            unk = [r["L"] for r in rows if r["outcome"] == "unknown"]
            if unk:
                agg["unknown_L"] = unk
            summary["per_det"].append(agg)
            print(f"  det {det:>3}: {agg['n']:>3} lattices, {agg['degenerate']:>3} degen, "
                  f"{agg['unsat']:>3} unsat, {agg['unknown']} unknown", flush=True)
            if sats:
                summary["halted_sat"] = sats[0]
                print("\n" + "=" * 72)
                print(sats[0].get("JACKPOT", "SAT — verify before interpretation"))
                print(f"  L = {sats[0]['L']}, k = {k}, T = {T}")
                print("=" * 72)
                break
    record43("sweeps", summary)
    return summary


def m43_census(t2lo, t2hi, k_asks=(6, 7), cap=300.0, workers=10):
    """Per-band quick census over (t2lo, t2hi): canonical scale, exhaustive omega,
    one ball ask per k in k_asks at R ~ 1.9 T (the sibling-refutation scale)."""
    from concurrent.futures import ProcessPoolExecutor
    bs = [b for b in bands(F(t2hi)) if F(b["t2_lo"]) >= F(t2lo) - F(1, 1000)
          and F(b["t2_hi"]) <= F(t2hi) + F(1, 1000)]
    print(f"m43 census: {len(bs)} bands in ({t2lo}, {t2hi})")
    out = []
    with ProcessPoolExecutor(max_workers=workers) as ex:
        omegas = list(ex.map(_omega_one, bs))
        specs = []
        for b in bs:
            Tc = canonical_T(b)
            R = int(1.9 * float(Tc)) + 1
            for k in k_asks:
                specs.append(("ball", Tc, k, R, cap, True, "direct"))
        balls = list(ex.map(_ask43, specs))
    i = 0
    for b, om in zip(bs, omegas):
        Tc = canonical_T(b)
        row = {"kind": "census-band", "band": {"t2_lo": b["t2_lo"], "t2_hi": b["t2_hi"],
               "classes": b["classes"], "norms": b["norms"]}, "T": str(Tc),
               "omega": om, "balls": []}
        for k in k_asks:
            r = balls[i]
            i += 1
            row["balls"].append({"k": r.get("k"), "R": r.get("R"),
                                 "outcome": r.get("outcome"),
                                 "claim_scope": r.get("claim_scope"),
                                 "seconds": r.get("seconds")})
        out.append(row)
        record43("census", row)
        print(f"  T^2 in ({b['t2_lo']}, {b['t2_hi']}): omega {om}, "
              + ", ".join(f"k={x['k']}:{x['outcome']}" for x in row["balls"]),
              flush=True)
    return out


def _omega_one(b):
    return len(max_clique40(canonical_T(b)))


def transfers43(t2max):
    """The derived transfer section (A1): containments between consecutive bands
    (comparable only across single-event thresholds)."""
    bs = bands(F(t2max))
    out = []
    for x, y in zip(bs, bs[1:]):
        cx = {tuple(c) for c in x["classes"]}
        cy = {tuple(c) for c in y["classes"]}
        if cx < cy:
            out.append({"from": "upper", "sub": x["t2_lo"], "sup": y["t2_lo"],
                        "note": "lower band subset of upper: sats transfer down, "
                                "unsats up", "diff": sorted(map(list, cy - cx))})
        elif cy < cx:
            out.append({"from": "lower", "sub": y["t2_lo"], "sup": x["t2_lo"],
                        "note": "upper band subset of lower", "diff":
                        sorted(map(list, cx - cy))})
    art = load_art43()
    art["transfers"] = out
    ART43.write_text(json.dumps(art, indent=1, default=str))
    return out


# ---------------------------------------------------------------- M43 self-test


def self_test43():
    fails = []

    def expect(name, got, want):
        ok = got == want
        print(f"  [{'ok ' if ok else 'FAIL'}] {name}: {got!r}" +
              ("" if ok else f"  (want {want!r})"))
        if not ok:
            fails.append(name)

    print("M43 self-test:")
    # D2 green control: the hand table around T^2 in (44, 54), exactly
    cuts = sorted({v for c, (mn, mx) in class_reps(F(54)).items()
                   for v in (mn, mx) if F(44) < v < F(54)})
    expect("D2: thresholds in (44,54)",
           cuts, [F(133, 3), F(139, 3), F(49), F(148, 3), F(151, 3), F(157, 3)])
    expect("D2: 133/3 is a double event (arrive (4,5), depart (1,5))",
           (interval((F(4), F(5)))[0], interval((F(1), F(5)))[1]),
           (F(133, 3), F(133, 3)))
    blo = band_of(F(48, 7))
    bhi = band_of(F(351, 50))
    expect("D2: B_lo interval", (blo["t2_lo"], blo["t2_hi"]), ("139/3", "49"))
    expect("D2: B_hi interval", (bhi["t2_lo"], bhi["t2_hi"]), ("49", "148/3"))
    lo_cls = {sector_rep(tuple(c)) for c in blo["classes"]}
    hi_cls = {sector_rep(tuple(c)) for c in bhi["classes"]}
    expect("D2: B_lo has the registered 11 classes",
           sorted(lo_cls), [(0, 6), (0, 7), (1, 6), (1, 7), (2, 5), (2, 6),
                            (3, 4), (3, 5), (3, 6), (4, 4), (4, 5)])
    expect("D2: B_hi = B_lo + (0,8)", sorted(hi_cls - lo_cls), [(0, 8)])
    expect("D2: B_lo norms", blo["norms"], [36, 37, 39, 43, 48, 49, 52, 57, 61, 63])
    # boundary refusal
    try:
        band_of(F(7))
        expect("A3: T = 7 refused as boundary", "accepted", "refused")
    except SystemExit:
        expect("A3: T = 7 refused as boundary", "refused", "refused")
    # I1: reach-14 clips at T = 13, agrees at T = 7
    expect("I1: edge_set(7,14) == edge_set40(7)",
           set(edge_set(F(7), 14)) == set(edge_set40(F(7))), True)
    expect("I1: edge_set(13,14) CLIPS (planted)",
           set(edge_set(F(13), 14)) < set(edge_set40(F(13))), True)
    # D4/A2: the registered pin triangle
    expect("D4: pin triangle for B_lo", triangle_for(blo), [(0, 0), (0, 6), (-6, 6)])
    # A3a planted red: K3 pinned OUT of head order under first-occurrence => unsat,
    # head order => sat (k = 3)
    def k3(pin_cols):
        cl = []
        for v in range(3):
            cl.append([v * 3 + c + 1 for c in range(3)])
            for c1 in range(3):
                for c2 in range(c1 + 1, 3):
                    cl.append([-(v * 3 + c1 + 1), -(v * 3 + c2 + 1)])
        for u in range(3):
            for v in range(u + 1, 3):
                for c in range(3):
                    cl.append([-(u * 3 + c + 1), -(v * 3 + c + 1)])
        for t in range(1, 3):
            for c in range(1, 3):
                cl.append([-(t * 3 + c + 1)] + [e * 3 + c for e in range(t)])
        for v, c in enumerate(pin_cols):
            cl.append([v * 3 + c + 1])
        return _solve(cl, 9, 60)[0]
    # (1,2,0) satisfies the staircase chain — the true conflicting pin is (0,2,1):
    # position 1 takes colour 2 while colour 1 first appears LATER, at position 2
    expect("A3a: K3 pin (0,2,1) + first-occurrence is UNSAT (seen red)",
           k3([0, 2, 1]), "unsat")
    expect("A3a: K3 pin (0,1,2) at head is SAT", k3([0, 1, 2]), "sat")
    # A4 planted red: <(37,0),(0,1)> swallows (0,6)
    r = hnf_colour(F(48, 7), 6, 37, 0, 1)
    expect("A4: degenerate lattice refused", r["outcome"], "degenerate")
    # I5 planted red + encoding agreement on a DECIDED refutation:
    # the (52/3, 20) band (M40: >= 7 outright, ball at 259/60)
    Td = F(259, 60)
    st_d = None
    for R in (5, 6, 7, 8):
        st_d = ball43(Td, 6, R, cap=300, pin=True, enc="direct")
        if st_d["outcome"] == "unsat":
            break
    expect("I5: known refutation reproduced (pinned direct)", st_d["outcome"], "unsat")
    st_a = ball43(Td, 6, st_d["R"], cap=300, enc="a1")
    expect("A3b: a1-form agrees on the refutation", st_a["outcome"], "unsat")
    st_u = ball43(Td, 6, st_d["R"], cap=300, pin=False, enc="direct")
    expect("I3: unpinned agrees on the refutation", st_u["outcome"], "unsat")
    print(f"       (pin timing on the decided row: pinned {st_d['seconds']}s, "
          f"unpinned {st_u['seconds']}s, a1 {st_a['seconds']}s)")
    # SAT-side agreement at the fine flank, R = 8 (small, known-colourable regime)
    sb = ball43(F(351, 50), 6, 8, cap=300, pin=True, enc="direct")
    sa = ball43(F(351, 50), 6, 8, cap=300, enc="a1")
    expect("I3: B_hi R=8 ball SAT (pinned)", sb["outcome"], "sat")
    expect("A3b: a1-form agrees on the SAT side", sa["outcome"], "sat")
    # canonical_T: interior and small-denominator
    for b in (blo, bhi):
        Tc = canonical_T(b)
        expect(f"A2: canonical T for ({b['t2_lo']},{b['t2_hi']}) is interior",
               F(b["t2_lo"]) < Tc * Tc < F(b["t2_hi"]), True)
    print("M43 SELF-TEST:", "ok" if not fails else f"{len(fails)} FAILURES: {fails}")
    return not fails


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
    # ---- M40 ----
    ap.add_argument("--self-test40", action="store_true")
    ap.add_argument("--census40", action="store_true",
                    help="corrected clique census (proper reach, cap 13)")
    ap.add_argument("--bands", type=str, metavar="T2MAX",
                    help="band decomposition up to T^2 = T2MAX")
    ap.add_argument("--clique", type=str, metavar="T",
                    help="exhaustive max clique at scale 1/T")
    ap.add_argument("--shrink", nargs=3, metavar=("T", "K", "R"),
                    help="1-minimal core of the ball refutation")
    ap.add_argument("--extract", nargs=4, metavar=("T", "K", "M", "N"),
                    help="torus colouring anatomy")
    ap.add_argument("--alpha", nargs=3, metavar=("T", "M", "N"),
                    help="exact torus independence number")
    ap.add_argument("--spectral", type=str, metavar="T",
                    help="certified Hoffman bracket at scale 1/T")
    # ---- M43 ----
    ap.add_argument("--self-test43", action="store_true")
    ap.add_argument("--m43-ball", nargs=3, metavar=("T", "K", "R"),
                    help="ball probe, reach-correct, pinned (unsat = outright)")
    ap.add_argument("--m43-skew", nargs=4, metavar=("T", "K", "DETLO", "DETHI"),
                    help="ALL HNF period lattices, det in range (sat = JACKPOT halt)")
    ap.add_argument("--m43-census", nargs=2, metavar=("T2LO", "T2HI"),
                    help="per-band quick census: omega + ball asks")
    ap.add_argument("--m43-transfers", type=str, metavar="T2MAX",
                    help="derived containment transfers between consecutive bands")
    ap.add_argument("--enc", type=str, default="direct", choices=["direct", "a1"])
    ap.add_argument("--no-pin", action="store_true")
    ap.add_argument("--pin", action="store_true",
                    help="pin the D4 triangle in --shrink (M43; protected from deletion)")
    ap.add_argument("--workers", type=int, default=10)
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    elif args.self_test40:
        sys.exit(0 if self_test40() else 1)
    elif args.self_test43:
        sys.exit(0 if self_test43() else 1)
    elif args.m43_ball:
        r = ball43(F(args.m43_ball[0]), int(args.m43_ball[1]), int(args.m43_ball[2]),
                   cap=args.cap, pin=not args.no_pin, enc=args.enc)
        record43("rows", r)
        print(json.dumps(r, indent=1, default=str))
    elif args.m43_skew:
        skew_sweep(F(args.m43_skew[0]), int(args.m43_skew[1]), int(args.m43_skew[2]),
                   int(args.m43_skew[3]), cap=args.cap, workers=args.workers)
    elif args.m43_census:
        m43_census(F(args.m43_census[0]), F(args.m43_census[1]), cap=args.cap,
                   workers=args.workers)
    elif args.m43_transfers:
        ts = transfers43(F(args.m43_transfers))
        print(f"{len(ts)} containment transfers recorded")
    elif args.census:
        Ts = [F(n, 6) for n in range(7, 61)]
        census(Ts)
    elif args.census40:
        art = load_art40()
        rows = []
        print(f"{'T = 1/p':>10} {'p':>8} {'omega':>5}  clique")
        for T in [F(n, 6) for n in range(7, 61)] + [F(41, 20)]:
            cl = max_clique40(T)
            rows.append({"T": str(T), "p": float(1 / T), "omega": len(cl),
                         "clique": [list(v) for v in sorted(cl)],
                         "norms": edge_norms(T, reach=edge_reach(T))})
            print(f"{str(T):>10} {float(1/T):>8.4f} {len(cl):>5}  {sorted(cl)}",
                  flush=True)
        art["census"] = rows
        save_art40(art)
    elif args.bands:
        bs = bands(F(args.bands))
        art = load_art40()
        art["bands"] = bs
        save_art40(art)
        for b in bs:
            plo = f"{b['p_lo']:.4f}" if b['p_lo'] else "0"
            phi = f"{b['p_hi']:.4f}" if b['p_hi'] else "1+"
            print(f"T^2 in ({b['t2_lo']}, {b['t2_hi']}): p in ({plo}, {phi})  "
                  f"norms {b['norms']}")
    elif args.clique:
        cl = max_clique40(F(args.clique))
        print(f"omega(G(1/{args.clique})) = {len(cl)}: {sorted(cl)}")
    elif args.shrink:
        r = shrink(F(args.shrink[0]), int(args.shrink[1]), int(args.shrink[2]), args.cap,
                   pin=args.pin)
        record40("cores", r)
        print(json.dumps(r, indent=1, default=str))
    elif args.extract:
        r = extract(F(args.extract[0]), int(args.extract[1]), int(args.extract[2]),
                    int(args.extract[3]), args.cap)
        record40("colourings", r)
        print(json.dumps({k: v for k, v in r.items() if k != "table"}, indent=1,
                         default=str))
    elif args.alpha:
        r = alpha(F(args.alpha[0]), int(args.alpha[1]), int(args.alpha[2]), args.cap)
        record40("alpha", r)
        print(json.dumps(r, indent=1, default=str))
    elif args.spectral:
        r = spectral(F(args.spectral))
        record40("spectral", r)
        print(json.dumps(r, indent=1, default=str))
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
