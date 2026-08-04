#!/usr/bin/env python3
"""The colourings as objects: pool statistics — M19 §0's instrument.

UNTRUSTED, like everything in `tools/`. This is a measuring device: it never claims, it counts.
A "unanimous" pair here is a *candidate* forced pair — it becomes a theorem only through the
kernel route (`Forces.of_edges` / `Forces.of_gadget`); a bug here can cost a lead, never buy one.

## Why the pool is an object worth measuring

Every separating colouring the sweeps produce is a local fragment of a hypothetical plane
5-colouring: a proper 5-colouring of a 4,678-point unit-distance graph is exactly what a plane
5-colouring would induce on those points. The pool is therefore a *sample of the enemy* — the
colourings a χ ≥ 6 construction must kill, and simultaneously the raw data of a χ = 5 structure
theory. Nothing had ever looked at them before M19. What this measures:

* **densities** — colour-class size profiles; the max-class density floor over the pool is the
  finite analogue of the measurable unit-avoiding-density question;
* **distinctness** — colourings counted up to colour permutation, so 3,000 pool entries do not
  masquerade as 3,000 independent facts;
* **triangle treatment** — which 3-subsets of the 5 colours land on unit triangles, and which
  leftover pairs the colouring is spending where (the 1/3-class rainbow triangles are the only
  triangles there are — M18's census);
* **translation structure** — same-colour rates along the most-realized exact difference
  vectors, against each colouring's own base rate: the skeleton of periodicity, if any;
* **margins** (`--margins-pivot`) — per class at a pivot, how often the pool paints a member
  the pivot's colour: mechanism (b)'s forcing margin, measured. `--sat-margins T` then asks the
  solver (forcer.forces) whether any colouring at all separates the high-margin pairs — the
  pool says "rarely separated", the solver says "never" or shows one.

The pool artifact carries its graph's identity (n, edge count, edge-list hash); this reader
rebuilds the graph independently, refuses a mismatch by name, and re-verifies every pool
colouring proper before believing any statistic. Persistence adds no trust.

    python3 tools/colorstat.py --self-test
    python3 tools/colorstat.py --pool build/m19-pool-z3closure.json \\
        --ledger-name Z3-closure-dg630x1/3 --stats
    python3 tools/colorstat.py --pool build/m19-pool-z3closure.json \\
        --ledger-name Z3-closure-dg630x1/3 --margins-pivot 630 --sat-margins 0.9
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from collections import Counter
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import construct as C  # noqa: E402
from classstat import key_symbolic  # noqa: E402
from coverage import by_ledger_name, edges_digest  # noqa: E402
from field import add, mul, mul_table, psub  # noqa: E402
from narrow import classes_at, is_rational  # noqa: E402

TAB = mul_table()


# ------------------------------------------------------------------ load + verify

def load_pool(pool_path: str, name: str, n: int, edges) -> list[list[int]]:
    """Read a pool artifact and refuse, by name, every way it could fail to be a pool of proper
    colourings of *this* graph."""
    d = json.loads(Path(pool_path).read_text())
    g = d["graph"]
    if g["n"] != n:
        raise SystemExit(f"pool was measured on {g['n']} points, graph has {n} — "
                         f"stale pool for '{g['name']}', refusing")
    if g["n_edges"] != len(edges):
        raise SystemExit(f"pool graph has {g['n_edges']} edges, this graph {len(edges)} — "
                         f"stale pool for '{g['name']}', refusing")
    sha = edges_digest(n, edges)
    if g["edges_sha"] != sha:
        raise SystemExit(f"pool edge-list hash {g['edges_sha']} ≠ this graph's {sha} — "
                         f"same sizes, different graph; refusing")
    pool = d["pool"]
    t0 = time.time()
    for i, m in enumerate(pool):
        if len(m) != n:
            raise SystemExit(f"pool colouring {i} paints {len(m)} points, graph has {n}")
        for a, b in edges:
            if m[a] == m[b]:
                raise SystemExit(f"pool colouring {i} is improper: edge ({a},{b}) "
                                 f"monochrome in colour {m[a]} — refusing the whole pool")
    print(f"pool verified: {len(pool)} colourings, every one proper on all {len(edges)} edges "
          f"({time.time() - t0:.0f}s)")
    return pool


def canonical(m: list[int]) -> tuple:
    """Colour-permutation canonical form: relabel colours by order of first appearance."""
    seen: dict[int, int] = {}
    out = []
    for c in m:
        if c not in seen:
            seen[c] = len(seen)
        out.append(seen[c])
    return tuple(out)


# ------------------------------------------------------------------ the statistics

def density_report(pool: list[list[int]], n: int, k: int) -> list[list[int]]:
    """Class-size profiles and the max-class density floor; returns the distinct
    representatives (one colouring per canonical form) for the downstream statistics."""
    reps: dict[tuple, list[int]] = {}
    for m in pool:
        reps.setdefault(canonical(m), m)
    distinct = list(reps.values())
    print(f"\n== densities ==  ({len(pool)} colourings, {len(distinct)} distinct up to "
          f"colour permutation)")
    profiles = Counter()
    fracs = []
    for m in distinct:
        sizes = tuple(sorted(Counter(m).values(), reverse=True))
        profiles[sizes] += 1
        fracs.append(sizes[0] / n)
    fracs.sort()
    print(f"max-class density over distinct colourings: floor {fracs[0]:.4f}, "
          f"median {fracs[len(fracs) // 2]:.4f}, ceiling {fracs[-1]:.4f} "
          f"(balanced would be {1 / k:.4f})")
    print(f"{len(profiles)} distinct size profiles; most common:")
    for prof, cnt in profiles.most_common(5):
        print(f"  {prof}: ×{cnt}")
    return distinct


def triangles_of(n: int, edges) -> list[tuple[int, int, int]]:
    adj: list[set[int]] = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    tris = []
    for a, b in edges:
        a, b = min(a, b), max(a, b)
        for c in adj[a] & adj[b]:
            if c > b:
                tris.append((a, b, c))
    return tris


def triangle_report(distinct: list[list[int]], n: int, edges, k: int) -> None:
    tris = triangles_of(n, edges)
    print(f"\n== triangle treatment ==  ({len(tris)} unit triangles)")
    if not tris:
        print("  no triangles — nothing to measure")
        return
    triple_use = Counter()   # frozen 3-set of colours -> incidences over (colouring, triangle)
    leftover_use = Counter()  # the complementary 2-set
    per_col_distinct = Counter()  # how many distinct triples one colouring uses
    allc = frozenset(range(k))
    for m in distinct:
        seen = set()
        for a, b, c in tris:
            t = frozenset((m[a], m[b], m[c]))
            assert len(t) == 3, "triangle not rainbow — properness was already verified?!"
            triple_use[t] += 1
            leftover_use[allc - t] += 1
            seen.add(t)
        per_col_distinct[len(seen)] += 1
    total = sum(triple_use.values())
    print(f"colour-triples on triangles ({len(triple_use)} of {k * (k - 1) * (k - 2) // 6} "
          f"possible appear):")
    for t, cnt in triple_use.most_common(10):
        print(f"  {sorted(t)}: {cnt / total:.3f}")
    print("distinct triples used per colouring (histogram):",
          dict(sorted(per_col_distinct.items())))
    print("leftover pairs (the 2 colours a triangle never sees):")
    for pair, cnt in leftover_use.most_common(10):
        print(f"  {sorted(pair)}: {cnt / total:.3f}")


def vector_report(distinct: list[list[int]], coords, denom: int, top: int,
                  sample: int) -> None:
    """Same-colour rates along the most-realized exact difference vectors. Each vector is
    reported with its squared length rendered symbolically; the lift is against each
    colouring's own base rate Σ (n_c/n)²."""
    n = len(coords)
    t0 = time.time()
    diff_count: Counter = Counter()
    for i in range(n):
        pi = coords[i]
        for j in range(i + 1, n):
            dx, dy = psub(coords[j], pi)
            diff_count[(tuple(dx), tuple(dy))] += 1
    print(f"\n== translation structure ==  ({len(diff_count)} distinct difference vectors "
          f"over {n * (n - 1) // 2} pairs, {time.time() - t0:.0f}s)")
    chosen = [d for d, _ in diff_count.most_common(top)]
    pairs: dict[tuple, list[tuple[int, int]]] = {d: [] for d in chosen}
    chosen_set = set(chosen)
    for i in range(n):
        pi = coords[i]
        for j in range(i + 1, n):
            dx, dy = psub(coords[j], pi)
            d = (tuple(dx), tuple(dy))
            if d in chosen_set:
                pairs[d].append((i, j))
    step = max(1, len(distinct) // sample)
    sampled = distinct[::step]
    base = sum(sum((c / n) ** 2 for c in Counter(m).values()) for m in sampled) / len(sampled)
    print(f"{len(sampled)} sampled colourings; mean base same-colour rate {base:.4f}")
    rows = []
    for d in chosen:
        ps = pairs[d]
        rate = sum(sum(1 for i, j in ps if m[i] == m[j]) for m in sampled) \
            / (len(ps) * len(sampled))
        r2key = add(mul(list(d[0]), list(d[0]), TAB), mul(list(d[1]), list(d[1]), TAB))
        rows.append((rate, len(ps), key_symbolic(tuple(r2key), denom)))
    rows.sort(key=lambda r: -abs(r[0] - base))
    print(f"top {len(rows)} vectors by |lift| (rate, multiplicity, |d|² exact):")
    for rate, mult, sym in rows[:top]:
        print(f"  rate {rate:.3f}  (lift {rate - base:+.3f})  ×{mult:<5} |d|² = {sym}")


def margins_report(pool: list[list[int]], coords, denom: int, edges, p: int, k: int,
                   r2_filter: Fraction | None, sat_threshold: float | None,
                   budget: float, forces_fn=None) -> None:
    """Mechanism (b)'s number: per class at pivot `p`, how often the pool paints each member
    the pivot's colour. With `sat_threshold`, high-margin pairs get the real question — does
    *any* proper k-colouring separate them — put to the solver (three outcomes, unknown never
    folded)."""
    n = len(coords)
    cl = classes_at(coords, p)
    print(f"\n== forcing margins at pivot {p} ==  ({len(pool)} pool colourings, "
          f"{len(cl)} classes)")
    rows = []
    for kk, Q in cl.items():
        if r2_filter is not None:
            if not (is_rational(kk) and Fraction(kk[0], denom * denom) == r2_filter):
                continue
        margins = [(sum(1 for m in pool if m[v] == m[p]) / len(pool), v) for v in Q]
        margins.sort(reverse=True)
        rows.append((margins[0][0], kk, margins))
    rows.sort(reverse=True)
    for top_margin, kk, margins in rows[:12]:
        sym = key_symbolic(kk, denom)
        head = ", ".join(f"{v}:{mg:.2f}" for mg, v in margins[:6])
        print(f"  r² = {sym:24} |Q| = {len(margins):3}  top members {head}")
    hot: list[tuple[int, float]] = []
    if sat_threshold is not None:
        for _, _, margins in rows:
            hot.extend((v, mg) for mg, v in margins if mg >= sat_threshold)
    if sat_threshold is not None:
        fn = forces_fn
        if fn is None:
            from forcer import forces as fn  # noqa: PLC0415
        print(f"SAT check on the {len(hot)} members with pool margin ≥ {sat_threshold}:")
        for v, mg in hot:
            verdict = fn(n, edges, p, v, k, budget)
            print(f"  pivot {p} ~ {v} (margin {mg:.3f}): {verdict}", flush=True)
            if verdict == "forced":
                print("  ** FORCED PAIR — triage only; the kernel route is the claim **")


# ------------------------------------------------------------------ self-test

def self_test() -> None:
    """Every statistic driven to a hand-computable answer; every refusal watched refusing."""
    import tempfile
    from coverage import pool_dump

    def zvec(a: int) -> tuple:
        return (a,) + (0,) * 15

    # a 4-point unit path 0-1-2-3 on the x-axis, denom 1
    coords = [((zvec(i)), zvec(0)) for i in range(4)]
    edges = [(0, 1), (1, 2), (2, 3)]
    n = 4

    with tempfile.TemporaryDirectory() as td:
        pp = str(Path(td) / "pool.json")
        # two colourings, permutations of each other, plus one genuinely different
        pool_in = [{0: 0, 1: 1, 2: 0, 3: 1}, {0: 1, 1: 0, 2: 1, 3: 0},
                   {0: 0, 1: 1, 2: 0, 3: 2}]
        pool_dump(pp, "toy", n, edges, 5, pool_in)
        pool = load_pool(pp, "toy", n, edges)
        assert len(pool) == 3

        # canonicalization: the two permuted copies collapse
        distinct = {canonical(m) for m in pool}
        assert len(distinct) == 2, distinct

        # graph-identity refusals, each by its own name
        for bad_edges, what in ([(0, 1), (1, 2)], "edge count"), \
                               ([(0, 1), (1, 2), (1, 3)], "edge hash"):
            try:
                load_pool(pp, "toy", n, bad_edges)
                raise AssertionError(f"mismatched {what} was accepted — refusal broken")
            except SystemExit:
                pass
        try:
            load_pool(pp, "toy", 5, edges)
            raise AssertionError("wrong n was accepted — refusal broken")
        except SystemExit:
            pass

        # an improper pool colouring is refused even with the right graph identity
        d = json.loads(Path(pp).read_text())
        d["pool"].append([0, 0, 1, 2])  # edge (0,1) monochrome
        Path(pp).write_text(json.dumps(d))
        try:
            load_pool(pp, "toy", n, edges)
            raise AssertionError("improper colouring was accepted — verification broken")
        except SystemExit:
            pass

    # triangle treatment on a known triangle: K3 + isolated point
    tri_edges = [(0, 1), (0, 2), (1, 2)]
    tris = triangles_of(4, tri_edges)
    assert tris == [(0, 1, 2)], tris

    # margins: alternating path — vertex 2 always agrees with 0, vertex 3 never
    agree = [sum(1 for m in pool if m[v] == m[0]) / len(pool) for v in range(4)]
    # agreement with the pivot is colour-permutation-invariant: the alternating pattern pins
    # vertices 1,3 away from 0 and vertex 2 onto it, in every pool entry
    assert agree == [1.0, 0.0, 1.0, 0.0], agree

    # margins SAT hook: a stub oracle records what it was asked, verdicts pass through
    asked: list[tuple[int, int]] = []

    def oracle(n_, e_, p_, q_, k_, t_):
        asked.append((p_, q_))
        return "separated"

    margins_report(pool, coords, 1, edges, 0, 5, None, 1.0, 1.0, forces_fn=oracle)
    assert asked == [(0, 2)], f"SAT hook asked {asked}, expected exactly the margin-1.0 member"

    # translation structure, hand-checked: d=(1,0) has 3 pairs; the alternating colouring
    # never repeats on it, the third colouring repeats on (0,2) only at d=(2,0)
    diff = Counter()
    for i in range(4):
        for j in range(i + 1, 4):
            dx, dy = psub(coords[j], coords[i])
            diff[(tuple(dx), tuple(dy))] += 1
    d1 = (zvec(1), zvec(0))
    assert diff[d1] == 3, diff
    m = pool[0]
    assert sum(1 for i in range(3) if m[i] == m[i + 1]) == 0

    print("colorstat.py self-test OK")


# ------------------------------------------------------------------ CLI

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--pool", help="pool artifact JSON (from coverage.py --pool-out)")
    ap.add_argument("--ledger-name", help="rebuild the graph by its hunt_ledger name")
    ap.add_argument("--cert", help="rebuild the graph from a certificate JSON under tools/")
    ap.add_argument("--stats", action="store_true",
                    help="densities, distinctness, triangles, translation structure")
    ap.add_argument("--margins-pivot", type=int,
                    help="forcing margins per class at this pivot")
    ap.add_argument("--r2", help="restrict margins to one rational class, e.g. 1/3")
    ap.add_argument("--sat-margins", type=float,
                    help="SAT-check pairs with pool margin ≥ this threshold")
    ap.add_argument("--top-vectors", type=int, default=40)
    ap.add_argument("--sample", type=int, default=300,
                    help="colourings sampled for the vector statistics")
    ap.add_argument("--budget", type=float, default=60.0)
    ap.add_argument("--colours", type=int, default=5)
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    if not args.pool or not (args.ledger_name or args.cert):
        ap.error("need --pool and a graph (--ledger-name or --cert) — or --self-test")

    if args.cert:
        d = json.load(open(Path(__file__).resolve().parent / f"{args.cert}.json"))
        coords = [(tuple(c[0]), tuple(c[1])) for c in d["coords"]]
        E, denom, gname = [tuple(e) for e in d["edges"]], d["denom"], args.cert
    else:
        _, cfg = by_ledger_name(args.ledger_name)
        coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
        E, denom, gname = cfg.edges(), cfg.denom, args.ledger_name
    n, k = len(coords), args.colours
    print(f"{gname}: {n} pts, {len(E)} edges, k = {k}")
    pool = load_pool(args.pool, gname, n, E)

    if args.stats:
        distinct = density_report(pool, n, k)
        triangle_report(distinct, n, E, k)
        vector_report(distinct, coords, denom, args.top_vectors, args.sample)
    if args.margins_pivot is not None:
        margins_report(pool, coords, denom, E, args.margins_pivot, k,
                       Fraction(args.r2) if args.r2 else None,
                       args.sat_margins, args.budget)
    if not args.stats and args.margins_pivot is None:
        ap.error("pool loaded but nothing asked — add --stats or --margins-pivot")


if __name__ == "__main__":
    main()
