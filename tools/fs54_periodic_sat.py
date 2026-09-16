#!/usr/bin/env python3
"""FS-54 D2 — a SAT cross-check of tools/fs54_periodic_alpha.py, and the 1-dimensional (line-periodic) case it cannot do.

For every orbit representative W recorded in the alpha tool's JSON (dimension 2 or 3), rebuild the quotient Cayley graph
independently and ask CaDiCaL (pysat): an independent set of size alpha_quotient exists (must be SAT) and one of size
alpha_quotient + 1 exists (must be UNSAT).  Vertex 0 is pinned into the set (the quotient is vertex-transitive).

For dimension 1 (an F_3-line W, 3 points, quotient on 243 vertices) it enumerates the unit-free lines up to the point
stabiliser and asks, per orbit and per threshold s, whether the quotient has an independent set of size >= s, under a
CONFLICT budget; a line-periodic independent set of the plane then has 3*s points.  UNKNOWN is reported as UNKNOWN.
Run: python3 tools/fs54_periodic_sat.py check data/fs54/periodic-alpha-q27-dim2.json
     python3 tools/fs54_periodic_sat.py lines --thresholds 39 40 41 --conflicts 2000000"""
import argparse, io, contextlib, itertools, json, sys, time
sys.path.insert(0, __import__("os").path.dirname(__file__))
with contextlib.redirect_stdout(io.StringIO()):
    from fs54_periodic_alpha import U, span, annihilator, GENS, _index, POINTS, N
from pysat.card import CardEnc, EncType
from pysat.solvers import Solver


def quotient(basis):
    P = annihilator(basis)
    img = {tuple(sum(x * y for x, y in zip(r, u)) % 3 for r in P) for u in U}
    assert all(any(c) for c in img), "W contains a unit vector"
    qpts = list(itertools.product(range(3), repeat=len(P)))
    qidx = {p: i for i, p in enumerate(qpts)}
    edges = {tuple(sorted((qidx[p], qidx[tuple((a + b) % 3 for a, b in zip(p, c))]))) for p in qpts for c in img}
    return len(qpts), edges


def ask(n, edges, s, conflicts=None):
    cnf = [[-(i + 1), -(j + 1)] for i, j in edges]
    card = CardEnc.atleast(lits=list(range(1, n + 1)), bound=s, top_id=n, encoding=EncType.seqcounter)
    with Solver(name="cadical153", bootstrap_with=cnf + card.clauses + [[1]]) as sol:
        if conflicts:
            sol.conf_budget(conflicts)
            r = sol.solve_limited()
        else:
            r = sol.solve()
        model = sol.get_model() if r else None
    if r:
        I = {i for i in range(n) if model[i] > 0}
        assert len(I) >= s and not any(a in I and b in I for a, b in edges), "solver model is not independent"
    return {True: "SAT", False: "UNSAT", None: "UNKNOWN"}[r]


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    c = sub.add_parser("check"); c.add_argument("json")
    l = sub.add_parser("lines"); l.add_argument("--thresholds", type=int, nargs="+", required=True)
    l.add_argument("--conflicts", type=int, default=2_000_000)
    l.add_argument("--out", default="data/fs54/periodic-lines-q27.json")
    args = ap.parse_args()
    if args.cmd == "check":
        rec = json.load(open(args.json))
        bad = 0
        for k, blk in rec["by_dim"].items():
            for o in blk["orbits_detail"]:
                n, edges = quotient([tuple(b) for b in o["basis"]])
                a = o["alpha_quotient"]
                lo, hi = ask(n, edges, a), ask(n, edges, a + 1)
                ok = lo == "SAT" and hi == "UNSAT"
                bad += not ok
                if not ok:
                    print("MISMATCH", k, o["basis"], a, lo, hi)
            print(f"dim {k}: {len(blk['orbits_detail'])} orbits cross-checked by SAT, mismatches {bad}", flush=True)
        sys.exit(1 if bad else 0)
    Uidx = {_index(u) for u in U}
    seen, reps = set(), []
    for v in POINTS[1:]:
        L = frozenset(_index(x) for x in span([v]))
        if L in seen or L & Uidx:
            seen.add(L)
            continue
        orbit, frontier = {L}, [L]
        while frontier:
            T = frontier.pop()
            for g in GENS:
                gT = frozenset(g[i] for i in T)
                if gT not in orbit:
                    orbit.add(gT); frontier.append(gT)
        seen |= orbit
        reps.append((v, len(orbit)))
    print(f"unit-free lines: {sum(o for _, o in reps)} in {len(reps)} orbits", flush=True)
    out = {"q": 27, "modulus": "t^3-t-1", "conflict_budget": args.conflicts,
           "claim_scope": "per orbit of unit-free F_3-lines W: SAT = a W-periodic independent set of 3*s points exists "
                          "(model verified); UNSAT = none exists; UNKNOWN = the solver stopped at the conflict budget "
                          "and says nothing about the graph", "orbits": []}
    for v, osize in reps:
        n, edges = quotient([v])
        row = {"line": v, "orbit_size": osize, "quotient_vertices": n, "quotient_degree": 2 * len(edges) // n, "asks": {}}
        for s in args.thresholds:
            t0 = time.time()
            row["asks"][s] = [ask(n, edges, s, args.conflicts), round(time.time() - t0, 1)]
            print(f"  line {v} (orbit {osize}, degree {row['quotient_degree']}): size >= {s} -> {row['asks'][s]}", flush=True)
        out["orbits"].append(row)
    json.dump(out, open(args.out, "w"), indent=1)


if __name__ == "__main__":
    main()
