#!/usr/bin/env python3
"""M45 — the arity-floor campaign driver (plans/M45-arity-floor.md).

Two axes, deliberately in two files, because a field can be ignored but a second file must be
opened on purpose:

  build/m45-arity.json    the SPINE. Per (stage, tuple, pattern): is this partial colouring
                          realizable? The arity floor of each stage, bracketed from below by the
                          sweeps and from above by the fan shrink.
  build/m45-orbits.json   a DIFFERENT axis: how orbit-complete a 1-minimal core is against its own
                          base rate, and whether that survives a randomized shrink order.

Stages are named, never implied:

  core-minus:T           the 1-minimal core at scale 1/T with its highest-degree vertex removed --
                         ONE vertex short of refuting, so a compulsion is guaranteed to exist there
                         (Arity.compels_of_fan applied through the A1 criticality factorization).
  ball:T:R               the radius-R ball at scale 1/T -- M43's stage. Bigger, but not critical.

Both are recorded with a fingerprint of their edge list, because these are DIFFERENT GRAPHS and a
conclusion has already turned out to be stage-dependent once.
"""

from __future__ import annotations

import argparse
import itertools
import json
import os
import random
import sys
import time
from collections import Counter
from concurrent.futures import ProcessPoolExecutor
from fractions import Fraction as F

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import arity as A  # noqa: E402
import celllat as C  # noqa: E402
import m44 as M  # noqa: E402
from coloring import base_clauses, var  # noqa: E402
from forcer import _solve  # noqa: E402
from rigidity import amo_clauses, min_cover  # noqa: E402

ARITY_ART = "build/m45-arity.json"
ORBIT_ART = "build/m45-orbits.json"

ORBIT_SCHEMA = (
    "m45-orbits v1 (plans/M45-arity-floor.md section 10.5). A DIFFERENT AXIS from "
    "build/m45-arity.json and kept in a separate file so the two cannot be plotted together by "
    "accident. `complete_orbits`/`n_orbits` count the core's dihedral orbits about the origin that "
    "are wholly contained in it; `control_*` is the SAME statistic on same-size random subsets of "
    "the same ball, which is the only thing that makes the core's number mean anything -- read "
    "without it, the observation inverts. `shrink_order` records whether the core came from the "
    "standing outside-in-by-shell traversal or from a randomized one: the standing traversal "
    "deletes in shell-sized batches and may therefore MANUFACTURE shell completeness, so a row "
    "with shrink_order='norm-batched' is not evidence about the objects until a randomized row "
    "agrees with it."
)


# ---------------------------------------------------------------- stages

def core_stage(T) -> tuple[dict, list, int]:
    """`core-minus:T` — the 1-minimal core minus its highest-degree vertex. Returns
    `(stage, addresses, dropped_index_into_core)`. Edges are re-derived two independent ways by
    `m44.core_edges`, which reports disagreement rather than silently preferring one."""
    T = F(T)
    rec = [c for c in M.load_cores() if F(c["T"]) == T]
    if not rec:
        raise SystemExit(f"no recorded k = 6 core at T = {T}")
    pts = [tuple(v) for v in rec[0]["core"]]
    es, agree = M.core_edges(T, pts)
    deg = Counter()
    for a, b in es:
        deg[a] += 1
        deg[b] += 1
    v = max(range(len(pts)), key=lambda i: deg[i])
    keep = [i for i in range(len(pts)) if i != v]
    ri = {o: i for i, o in enumerate(keep)}
    e2 = [(ri[a], ri[b]) for a, b in es if a != v and b != v]
    stage = A.make_stage("core-minus", len(keep), e2, T=str(T), dropped_address=list(pts[v]),
                         dropped_degree=deg[v], core_n=len(pts), edge_derivation=agree)
    return stage, [pts[i] for i in keep], v


def ball_stage(T, R) -> tuple[dict, list, None]:
    """`ball:T:R` — M43's stage shape. The Q-ball needs a wider coordinate box than [-R,R]^2."""
    T = F(T)
    es = set(C.edge_set40(T))
    bx = int(1.1548 * R) + 2
    pts = [(x, y) for x in range(-bx, bx + 1) for y in range(-bx, bx + 1) if C.Q((x, y)) <= R * R]
    pts.sort(key=lambda v: (C.Q(v), v))
    idx = {p: i for i, p in enumerate(pts)}
    E = []
    for u in pts:
        for (da, db) in es:
            w = (u[0] + da, u[1] + db)
            if w in idx and idx[w] > idx[u]:
                E.append((idx[u], idx[w]))
    return A.make_stage("ball", len(pts), E, T=str(T), R=R), pts, None


def build_stage(spec: str):
    parts = spec.split(":")
    if parts[0] == "core-minus":
        return core_stage(parts[1])
    if parts[0] == "ball":
        return ball_stage(parts[1], int(parts[2]))
    raise SystemExit(f"unknown stage {spec!r} (core-minus:T | ball:T:R)")


# ---------------------------------------------------------------- the sweeps

_G = {}


def _init(stage, k):
    _G["stage"], _G["k"] = stage, k


def _confirm(spec):
    tup, blocks, cap, enc = spec
    row = A.realize(_G["stage"], _G["k"], tup, blocks, cap, enc)
    return row


def sweep(stage, k, arity, cap, workers, harvest_count, cap_tuples=None, seed=0):
    """Observe, then confirm. Returns `(rows, compelled_pairs)`; only never-observed patterns reach
    the solver, and a compulsion is claimed only on an `unsat`."""
    base = A.base_row(stage, k, 600.0)
    if base["outcome"] != "sat":
        return {"base": base, "rows": [], "note": "stage not colourable — every question vacuous"}, set()
    t0 = time.time()
    cols = A.harvest(stage, k, harvest_count, workers=workers)
    n = stage["n"]
    adj = {tuple(e) for e in stage["edges"]}
    tuples = [t for t in itertools.combinations(range(n), arity)]
    if cap_tuples and len(tuples) > cap_tuples:
        random.Random(seed).shuffle(tuples)
        tuples = tuples[:cap_tuples]
        sampled = True
    else:
        sampled = False
    pats = A.partitions(arity, k)
    todo = []
    for t in tuples:
        for bl in pats:
            if not A.locally_proper(stage, t, bl):
                continue
            if not A.observed(cols, t, bl):
                todo.append((t, bl, cap, "free-fwd"))
    print(f"    harvest {len(cols)} colourings in {time.time() - t0:.1f}s; "
          f"{len(tuples)} tuples{' (SAMPLED)' if sampled else ''} -> {len(todo)} candidates",
          flush=True)
    t0 = time.time()
    with ProcessPoolExecutor(max_workers=workers, initializer=_init,
                             initargs=(stage, k)) as ex:
        res = list(ex.map(_confirm, todo, chunksize=1))
    print(f"    confirm {len(res)} queries in {time.time() - t0:.1f}s", flush=True)
    return {"base": base, "rows": res, "n_tuples": len(tuples), "sampled": sampled,
            "harvest": len(cols)}, res


def pair_compulsions(res_rows) -> set:
    """The compelled PAIRS of a completed arity-2 sweep — the evidence every higher-arity verdict
    structurally requires."""
    return {tuple(r["tuple"]) for r in res_rows if r["outcome"] == "unsat"}


# ---------------------------------------------------------------- the fan bracket

def fan_shrink(stage, k, centre_nbrs, cap, verbose=True):
    """A 1-MINIMAL fanned subset of a fanned set. `Arity.compels_of_fan` turns any fanned set into a
    compulsion of its own size, so the minimal one is a measured UPPER BOUND on the arity floor."""
    S = list(centre_nbrs)
    mc = min_cover(stage["n"], stage["edges"], k, S, cap)
    if mc["verdict"] != "fanned":
        return {"verdict": mc["verdict"], "start": len(S), "rows": mc["rows"]}
    changed = True
    while changed:
        changed = False
        for v in list(S):
            if len(S) <= 1:
                break
            trial = [w for w in S if w != v]
            r = min_cover(stage["n"], stage["edges"], k, trial, cap)
            if r["verdict"] == "fanned":
                S = trial
                changed = True
                if verbose:
                    print(f"      shrink -> {len(S)}", flush=True)
    necessity = []
    for v in S:
        trial = [w for w in S if w != v]
        necessity.append({"v": v, "verdict": min_cover(stage["n"], stage["edges"], k,
                                                       trial, cap)["verdict"]})
    return {"verdict": "fanned", "start": len(centre_nbrs), "minimal": len(S),
            "set": S, "necessity": necessity,
            "one_minimal": all(x["verdict"] != "fanned" for x in necessity)}


# ---------------------------------------------------------------- artifacts

def record(path, schema, section, row):
    import fcntl
    lock = path + ".lock"
    with open(lock, "w") as lf:
        fcntl.flock(lf, fcntl.LOCK_EX)
        art = {"schema": schema}
        if os.path.exists(path):
            art = json.load(open(path))
        art["schema"] = schema
        art.setdefault(section, []).append(row)
        json.dump(art, open(path, "w"), indent=1, default=str)


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--stage", help="core-minus:T | ball:T:R")
    ap.add_argument("--k", type=int, default=6)
    ap.add_argument("--arity", type=int, default=2)
    ap.add_argument("--cap", type=float, default=900.0)
    ap.add_argument("--workers", type=int, default=28)
    ap.add_argument("--harvest", type=int, default=400)
    ap.add_argument("--cap-tuples", type=int, default=None)
    ap.add_argument("--fan", action="store_true", help="the fan bracket instead of a sweep")
    a = ap.parse_args()
    if not a.stage:
        ap.print_help()
        return
    stage, pts, dropped = build_stage(a.stage)
    print(f"stage {a.stage}: n = {stage['n']}, m = {stage['m_edges']}, "
          f"fingerprint {stage['fingerprint']}", flush=True)
    if a.fan:
        if dropped is None:
            raise SystemExit("--fan needs a core-minus stage (the deleted vertex IS the centre)")
        raise SystemExit("--fan: supply the neighbour set from the driver; see plans section 10.4")
    res, rows = sweep(stage, a.k, a.arity, a.cap, a.workers, a.harvest, a.cap_tuples)
    print(json.dumps({kk: vv for kk, vv in res.items() if kk != "rows"}, indent=1, default=str))


if __name__ == "__main__":
    main()
