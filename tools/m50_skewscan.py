"""M50 — the weighted-ladder scan (the stall study's first half; plans/M50-batch-descent.md §Sⁱᵛ).

The SUPPORT ladder — which colour patterns are realizable at all (compulsions, virtual edges,
the arity floor) — has been swept to completion four times and reads flat below arity 4 (M45/M48).
This instrument climbs the WEIGHTED ladder on the same held data: the class-uniform measure over a
persisted separating-colouring list, restricted to palette-INVARIANT functionals only — the lists
are palette-canonicalized, so any non-invariant statistic (a raw vertex marginal, say) measures
the canonicalization order, not the object (G21).

Functionals, and why each is a currency rather than a proxy:
  * pair agreement mass `P[u,v] = #{c in S : c_u = c_v} / |S|`. For a pair ABSENT from the stage
    (a floor cheat, or any non-edge), `P·|S|` is EXACTLY the number of classes a halo must kill to
    force that pair distinct — the cover cost of the pair-target, in the same units the design
    engine spends. Not an analogy: the design targets classes, and the mono classes are the ones a
    distinctness forcing must exclude.
  * extremes: `P = 0` at a pair not adjacent in the stage = a CONDITIONAL virtual edge of this
    stage (separating colourings never wear it mono); `P = 1` = conditional forced-EQUAL
    (separation of A,B implies agreement here — an alternative target: forcing such a pair
    DISTINCT kills all of S at once).
  * small-set rainbow statistics on a named cast: never-rainbow 4-sets are the total pigeonholes
    (§R5's family), never-3-distinct triples their arity-3 siblings; Kooshi's quadrilateral
    {98, 118, 107, 126} is the planted control.

Every number is a measurement of the NAMED list under the CLASS-uniform measure CONDITIONED on
separation — never of "the object's colouring space" (extension multiplicities are unweighted,
non-separating colourings absent by construction). The JSON row says so.

Usage:
  python3 tools/m50_skewscan.py --scan build/m50-S-S29-depth2r-it2v2.jsonl --object S29-depth2r
  python3 tools/m50_skewscan.py --scan build/m50-S29.jsonl                  # seed-stage list
  python3 tools/m50_skewscan.py --unitchi S29-depth2r [--k 4]               # chi(unit part) ask
"""
from __future__ import annotations
import argparse, itertools, json, math, sys, time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np  # noqa: E402
from batchkill import BUILD, Obj, load_object, load_seps  # noqa: E402
import coloring, forcer, rigidity  # noqa: E402
import twodist as T  # noqa: E402

# Named distance vocabulary (exact values; labels used in tables). Matching at 1e-6 on floats from
# the provenance recursion is safe: the vocabulary's members are separated by >> 1e-3.
DIST_NAMES = [
    (1.0, "1"), (math.sqrt(3.0), "sqrt3"), (2.0, "2"), (math.sqrt(7.0), "sqrt7"),
    (2.0 * math.sqrt(3.0), "2sqrt3"), (3.0, "3"),
]


def dist_label(d: float) -> str:
    for v, name in DIST_NAMES:
        if abs(d - v) < 1e-6:
            return name
    return f"{d:.6f}"


def agreement_matrix(X: np.ndarray) -> np.ndarray:
    """P[u,v] = fraction of rows where colours agree. Palette-invariant. Five float32 matmuls."""
    n = X.shape[1]
    acc = np.zeros((n, n), dtype=np.float64)
    for k in range(5):
        B = (X == k).astype(np.float32)
        acc += (B.T @ B).astype(np.float64)
    return acc / X.shape[0]


def scan(list_path: Path, object_label: str | None):
    header, cols = load_seps(list_path)
    X = np.array(cols, dtype=np.int8)
    # rows may carry a full witness colouring (seed + one arbitrary halo extension); the halo
    # columns are SOLVER-CHOSEN witnesses, not ensemble draws (the M19 lesson) — project to seed.
    assert X.shape[1] >= 214
    X = X[:, :214]
    N, n = X.shape
    batch = {tuple(sorted(e)) for e in header["batch"]}

    if object_label:
        obj, removed = load_object(object_label)
    else:
        obj, removed = Obj(), []
    pts = np.array(obj.pts[:214])
    D = np.sqrt(((pts[:, None, :] - pts[None, :, :]) ** 2).sum(-1))
    unit = {tuple(sorted(e)) for e in obj.unit_edges() if e[0] < 214 and e[1] < 214}
    cheats = {tuple(sorted(e)) for e in obj.cheats}
    removed_set = {tuple(sorted(e)) for e in removed}
    # the stage's PRESENT constraints on seed vertices: unit edges + cheats not absent
    absent = batch | removed_set
    present = unit | (cheats - absent)
    A, B = obj.A, obj.B

    t0 = time.time()
    P = agreement_matrix(X)
    pairs = [(u, v) for u in range(n) for v in range(u + 1, n)]

    # sanity: every present constraint must read P = 0 (rows are proper on the stage)
    viol = [(u, v) for (u, v) in present if P[u, v] > 0]
    assert not viol, f"list improper on present constraints: {viol[:5]}"
    assert P[A, B] == 0.0, "list not separating"

    nonadj = [(u, v) for (u, v) in pairs if (u, v) not in present]
    base = float(np.mean([P[u, v] for u, v in nonadj]))

    def row(u, v):
        return dict(pair=[u, v], P=round(float(P[u, v]), 6), d=dist_label(D[u, v]),
                    cls=("removed-cheat" if (u, v) in removed_set else
                         "floor-cheat" if (u, v) in cheats else "non-edge"))

    cond_virtual = [row(u, v) for (u, v) in nonadj if P[u, v] == 0.0 and (u, v) != (min(A, B), max(A, B))]
    cond_equal = [row(u, v) for (u, v) in nonadj if P[u, v] == 1.0]
    lo = sorted((r for r in (row(u, v) for u, v in nonadj) if r["P"] > 0), key=lambda r: r["P"])[:25]
    hi = sorted((row(u, v) for u, v in nonadj), key=lambda r: -r["P"])[:25]

    # distance-class aggregates over non-adjacent pairs (the "nominated distances" claim, weighed)
    agg: dict[str, list[float]] = {}
    for u, v in nonadj:
        agg.setdefault(dist_label(D[u, v]), []).append(float(P[u, v]))
    dist_agg = {k: dict(mean=round(float(np.mean(v)), 4), n=len(v))
                for k, v in agg.items() if k in {x for _, x in DIST_NAMES}}

    # ---- small-set rainbow statistics, palette-invariant, two-tier cast:
    # triples on the MEDIUM cast (all absent-edge endpoints + the named core), minimal 4-sets on
    # the TIGHT cast (the named core: quadrilateral, blind centres, forced pair, kept refuser and
    # it-1 kept-ten endpoints) — the |cast|^4 blow-up is what the tiering buys off.
    quad = [98, 118, 107, 126]
    kept10 = [4, 205, 21, 210, 38, 211, 71, 107, 98, 213, 118, 212, 126, 203, 206]
    cast_t = sorted({58, 115, *quad, A, B, *kept10})
    cast_m = sorted(set(cast_t) | {x for e in absent for x in e if x < 214})
    cpairs = [(a, b) for i, a in enumerate(cast_m) for b in cast_m[i + 1:]]
    pcol = {p: j for j, p in enumerate(cpairs)}
    # packed per-pair distinctness bits: row-major bit i = "colours differ in row i"
    Dis = np.packbits(np.stack([(X[:, a] != X[:, b]) for a, b in cpairs], axis=0), axis=1)

    def never_rainbow(sub):
        idx = [pcol[tuple(sorted(p))] for p in itertools.combinations(sub, 2)]
        return not bool(np.bitwise_and.reduce(Dis[idx], axis=0).any())

    trip3 = [s for s in itertools.combinations(cast_m, 3) if never_rainbow(s)]
    # minimal never-rainbow 4-sets on the tight cast: contain no never-rainbow triple
    tset = {frozenset(s) for s in trip3}
    quads4 = [s for s in itertools.combinations(cast_t, 4)
              if not any(t <= frozenset(s) for t in tset) and never_rainbow(s)]

    qpairs = {f"{u}-{v}": round(float(P[u, v]), 4) for u, v in itertools.combinations(quad, 2)}
    qidx = [pcol[tuple(sorted(p))] for p in itertools.combinations(quad, 2)]
    quad_rainbow = int(np.unpackbits(np.bitwise_and.reduce(Dis[qidx], axis=0))[:N].sum())

    out = dict(
        kind="weighted-ladder-scan",
        claim_scope=("class-uniform measure over the NAMED list (one rep per seed palette class), "
                     "conditioned on properness of the stage and separation of A,B; palette-"
                     "invariant functionals only; says nothing about extension multiplicities"),
        list=str(list_path.name), N=N, stage_fp=header.get("stage_fingerprint"),
        object=object_label, baseline_P=round(base, 4),
        conditional_virtual_edges=cond_virtual, conditional_forced_equal=cond_equal,
        lowest_P=lo, highest_P=hi, distance_aggregates=dist_agg,
        cast_tight=cast_t, cast_medium=cast_m,
        never3distinct_triples=[list(s) for s in trip3],
        minimal_total_pigeonhole_4sets=[list(s) for s in quads4],
        quad_control=dict(pairs=qpairs, rainbow_rows=quad_rainbow),
        floor_edge_costs=sorted([row(u, v) for (u, v) in
                                 {tuple(sorted(e)) for e in absent} - removed_set - unit],
                                key=lambda r: r["P"]),
        secs=round(time.time() - t0, 1),
    )
    tag = list_path.stem.replace("m50-S-", "").replace("m50-", "")
    path = BUILD / f"m50-skewscan-{tag}.json"
    path.write_text(json.dumps(out, indent=1))
    print(f"[skewscan] {list_path.name}: N={N}, baseline P={base:.4f}, "
          f"{len(cond_virtual)} conditional virtual edges, {len(cond_equal)} conditional "
          f"forced-equal, quad rainbow rows={quad_rainbow}; -> {path.name}")
    for name, rows in [("cond-virtual", cond_virtual), ("cond-equal", cond_equal),
                       ("lowest P", lo[:12]), ("highest P", hi[:12]),
                       ("floor-edge costs", out["floor_edge_costs"][:12])]:
        print(f"  {name}:")
        for r in rows:
            print(f"    {tuple(r['pair'])}  P={r['P']:.4f}  d={r['d']}  [{r['cls']}]")
    print(f"  distance aggregates (non-adjacent): {json.dumps(dist_agg)}")
    print(f"  quad pairs: {json.dumps(qpairs)}")
    print(f"  never-3-distinct triples: {trip3}")
    print(f"  minimal total-pigeonhole 4-sets ({len(quads4)}): {quads4[:20]}")
    return out


def unitchi(label: str, k: int, cap: float):
    """One ask: is the committed object's UNIT part (cheats deleted) k-colourable? The descent's
    phase monitor — the first commit whose unit part refuses k = 4 has minted a 5-chromatic
    unit-distance graph as a side effect (see §Sⁱᵛ)."""
    obj, removed = load_object(label)
    ue = obj.unit_edges()
    print(f"[unitchi] object {label}: n={obj.n}, unit edges {len(ue)}, k={k}")
    cls = coloring.base_clauses(obj.n, ue, k) + rigidity.amo_clauses(obj.n, k)
    cls += T._brk_full(obj.n, k, T._degree_order(obj.n, ue))
    t0 = time.time()
    st, _ = forcer._solve(cls, obj.n * k, cap)
    print(f"[unitchi] {label} k={k}: {st.upper()} ({time.time()-t0:.1f}s)"
          + ("  — unit part still k-colourable" if st == "sat" else
         "  — UNIT PART REFUSES: a (k+1)-chromatic unit graph is minted" if st == "unsat" else ""))
    return st


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--scan", type=Path)
    ap.add_argument("--object", default=None)
    ap.add_argument("--unitchi", default=None)
    ap.add_argument("--k", type=int, default=4)
    ap.add_argument("--cap", type=float, default=900.0)
    a = ap.parse_args()
    if a.scan:
        scan(a.scan, a.object)
    if a.unitchi:
        unitchi(a.unitchi, a.k, a.cap)
