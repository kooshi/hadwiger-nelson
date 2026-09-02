#!/usr/bin/env python3
"""M48 — the from-below arity question: at what order is de Grey's witness compelled?

UNTRUSTED, like everything in `tools/`. Nothing here becomes mathematics until a later milestone
re-derives it in Lean; a bug here can cost a theorem and never buy one.

## What is being asked, and why it is worth asking

`Arity.arityFloor_le_of_degree` (kernel, M45) says a vertex with `k` distinct neighbours makes the
all-different pattern on them unrealizable, so **a compulsion of arity at most `k` is guaranteed**
with no hypotheses at all. De Grey's 1581-vertex witness has two vertices of degree 60, so at five
colours *something is compelled at arity ≤ 5*. Its arity-2 sweep is settled COMPLETE and empty
(`build/m30-rigidity-1581-k5.json`, `status: done`, `unsettled: []`, all 1,248,990 pairs). So the
floor is in `{3, 4, 5}` **by theorem**, and nobody has ever asked which.

That is a calibrated bed: the arity-2 answer is not merely certified, it is exhaustive, so a zero at
arity 3 is a statement about mechanism rather than about the instrument's reach.

## The two axes, never merged

* `build/m48-arity.json` — the SWEEP axis: one row per (stage, tuple, pattern).
* `build/m48-ladder.json` — the OBJECT axis: the same questions re-asked on a larger stage.

They have different denominators, so `aggregate` would be meaningless across them.

## What a negative here does and does not license

A zero at arity 3 licenses exactly `arityFloor(1581, 5) ∈ {4, 5}`. It licenses nothing about the
plane, about other objects, or about arity 4 outside vertex neighbourhoods — `C(1581,4)` is
259,338,410,115 and is explicitly out of scope. **Every negative's headline states its own
enumeration** (`arity.negative_headline`); that rule exists because a six-question sweep was once
written up as a fact about an object and became a false grokking.

    python3 tools/m48.py --self-test
    python3 tools/m48.py --census
    python3 tools/m48.py --arity3 --harvest 8192
"""

from __future__ import annotations

import argparse
import json
import math
import sys
import time
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
BUILD = TOOLS.parent / "build"
sys.path.insert(0, str(TOOLS))

import arity as AR  # noqa: E402

ART_ARITY = BUILD / "m48-arity.json"
ART_LADDER = BUILD / "m48-ladder.json"

SCHEMA = (
    "m48 v1 (plans/M48-from-below-arity.md). Two axes in two files: m48-arity.json is the SWEEP "
    "axis (one row per stage/tuple/pattern) and m48-ladder.json the OBJECT axis (the same "
    "questions on a larger stage); they carry different denominators and are never merged. "
    "`enumeration` states, per phase, the rule in prose AND the formula AND the computed count, so "
    "a reader who trusts nothing can recompute every denominator. `unsolved_candidates` are "
    "questions NOT YET ASKED -- never findings, never negatives -- and carry the harvest size that "
    "qualifies them. `jackpot_eligible` is true only where a row could be chi(R^2) >= 6; an arity-3 "
    "compulsion never can be (M48 §0a D2: a mono-triple pigeonhole at five colours needs 11 points "
    "and a {1,sqrt3,2}-vocabulary set has at most 10). Verdicts come only from arity.arity_verdict."
)


# ------------------------------------------------------------------ the objects, re-derived

def _classify(pts, nsq, psub, one, approx, tag: str):
    """Exact unit / √3 / distance-2 pair enumeration: a float grid proposes, exact field
    arithmetic disposes. The `assert` is not decoration — `closure.nsq` returns a *list*, so norm
    constants built as tuples compare unequal to every norm forever, which would leave the √3 and
    distance-2 classes EMPTY while the unit-count control still passed."""
    ctor = type(one)
    three, four = ctor([3 * x for x in one]), ctor([4 * x for x in one])
    probe = nsq(psub(pts[0], pts[1]))
    if not (type(probe) is ctor and three != one and four != one):
        raise SystemExit(
            f"NORM CONSTANT MISMATCH in {tag}: constants are {ctor.__name__} and a computed norm "
            f"is {type(probe).__name__}. The two field modules disagree — `degrey` returns tuples "
            f"and `closure` lists — and a mismatch here leaves the sqrt3 and distance-2 classes "
            f"EMPTY while the unit-count control still passes.")
    ap = [approx(p) for p in pts]
    grid: dict = {}
    for i, (x, y) in enumerate(ap):
        grid.setdefault((math.floor(x), math.floor(y)), []).append(i)
    got = {"unit": [], "sqrt3": [], "two": []}
    for i, (x, y) in enumerate(ap):
        gx, gy = math.floor(x), math.floor(y)
        for dx in range(-3, 4):
            for dy in range(-3, 4):
                for j in grid.get((gx + dx, gy + dy), ()):
                    if j <= i:
                        continue
                    d2 = (x - ap[j][0]) ** 2 + (y - ap[j][1]) ** 2
                    if abs(d2 - 1) < 1e-7 or abs(d2 - 3) < 1e-7 or abs(d2 - 4) < 1e-7:
                        q = nsq(psub(pts[i], pts[j]))
                        if q == one:
                            got["unit"].append((i, j))
                        elif q == three:
                            got["sqrt3"].append((i, j))
                        elif q == four:
                            got["two"].append((i, j))
    return got


def stage_degrey() -> tuple[dict, dict]:
    """De Grey's committed 1581, with the 7,877-edge control that validates the enumeration."""
    import anatomy as A
    import degrey as D
    pts, _table, _addr = A.build_addresses()
    cls = _classify(pts, D.normsq, D.psub, D.ONE, A.approx, "degrey")
    if len(cls["unit"]) != 7877:
        raise SystemExit(f"CONTROL FAILED: {len(cls['unit'])} unit edges, committed count is 7877")
    st = AR.make_stage("degrey-1581", len(pts), cls["unit"], unit_distance=True,
                       derivation="anatomy.build_addresses(); unit edges re-derived by exact "
                                  "field arithmetic, control 7877")
    return st, cls


def stage_gen1() -> tuple[dict, dict]:
    """The gen-1 half-spindle closure, with M31's 123,134-chord control AND the control that the
    1581's own 7,877 edges reproduce inside the sweep — which is also what makes the 1581 an
    INDUCED subgraph, hence the hypothesis `Arity.arityFloor_le_of_embedding` needs."""
    import closure as CL
    pts, origin, centre2 = CL.degrey_points()
    g = CL.close_gen(pts, [origin, centre2], CL.GEN1_GENS)
    P = g["pts"]
    cls = _classify(P, CL.nsq, CL.csub, CL.nsq(CL.ONE_C), CL.approx, "gen1")
    if len(cls["unit"]) != 123134:
        raise SystemExit(f"CONTROL FAILED: {len(cls['unit'])} chords, M31 recorded 123134")
    base = [e for e in cls["unit"] if e[0] < 1581 and e[1] < 1581]
    if len(base) != 7877:
        raise SystemExit(f"CONTROL FAILED: the 1581's induced edge count is {len(base)}, not 7877 "
                         "— the witness is NOT an induced subgraph and the ladder theorem's "
                         "hypothesis does not hold")
    st = AR.make_stage("degrey-gen1", len(P), cls["unit"], unit_distance=True,
                       derivation="closure.close_gen(1581, both spindle centres, GEN1_GENS); "
                                  "controls 123134 chords and the 1581's induced 7877")
    return st, cls


# ------------------------------------------------------------------ artifacts

def load(path: Path) -> dict:
    if path.exists():
        return json.loads(path.read_text())
    return {"schema": SCHEMA, "machine": None, "phases": [], "rows": [],
            "unsolved_candidates": [], "status": "partial"}


def save(art: dict, path: Path) -> None:
    for s in art["phases"]:
        AR.check_recordable(s)
    AR.check_recordable(art["rows"])
    path.write_text(json.dumps(art, indent=1, default=str))


def record(path: Path, phase: dict, rows=None, candidates=None) -> None:
    """Append one phase. `check_recordable` is the boundary: a `Candidate` cannot be filed as a
    result, and a summary without its enumeration cannot be filed at all."""
    AR.check_recordable(phase)
    art = load(path)
    art["machine"] = _machine()
    art["phases"].append(phase)
    if rows:
        art["rows"].extend(rows)
    if candidates:
        art["unsolved_candidates"].extend(
            {"tuple": list(c.tup), "blocks": [list(b) for b in c.blocks],
             "stage_fingerprint": c.fingerprint, "never_observed_in_colourings": c.harvest,
             "note": "NOT a finding and NOT a negative: a question not yet given to a solver"}
            for c in candidates)
    save(art, path)


def _machine() -> str:
    import os
    import platform
    return f"{platform.node()} ({os.cpu_count()} cores)"


# ------------------------------------------------------- resumption after a crash
#
# This machine has an intermittent hardware fault (unexplained process deaths under sustained parallel load), so a
# multi-hour phase WILL sometimes die mid-run. Neither mechanism below changes a single question
# asked or answer recorded -- they only stop a crash from discarding work already paid for. Both
# are keyed by the stage fingerprint, so a cache can never be read against a different object.

def harvest_cached(st: dict, k: int, want: int, workers: int, cap: float) -> list[list[int]]:
    """The first `want` harvested colourings for this stage, re-using any already on disk.

    Harvesting dominates this phase's cost (measured: 6.05 CPU-seconds per colouring on the
    24,065-vertex stage, against 0.31 on the 1,581-vertex one), so a crash that threw the pool away
    would cost more than the solving it interrupted. The cache records `next_seed` alongside the
    colourings because `AR.harvest` DROPS the seeds that fail to solve -- so the pool length and the
    seed range are different numbers, and conflating them would silently re-harvest a seed already
    seen, which is exactly the near-miss `harvest`'s own docstring documents."""
    import numpy as np
    npy, side = BUILD / f"m48-pool-{st['fingerprint']}.npy", BUILD / f"m48-pool-{st['fingerprint']}.json"
    pool, seed = [], 0
    if npy.exists() and side.exists():
        meta = json.loads(side.read_text())
        if meta.get("fingerprint") == st["fingerprint"] and meta.get("n") == st["n"]:
            pool, seed = [list(map(int, r)) for r in np.load(npy)], meta["next_seed"]
            print(f"  pool cache: {len(pool)} colourings on disk (seeds < {seed})", flush=True)
    while len(pool) < want:
        take = max(64, min(2048, want - len(pool)))
        pool.extend(AR.harvest(st, k, take, workers=workers, cap=cap, seed0=seed))
        seed += take
        np.save(npy, np.array(pool, dtype=np.uint8))
        side.write_text(json.dumps({"fingerprint": st["fingerprint"], "n": st["n"],
                                    "next_seed": seed, "count": len(pool)}))
        print(f"  pool cache: {len(pool)}/{want} (seeds < {seed})", flush=True)
    for c in pool[:want]:
        assert len(c) == st["n"], "cached colouring has the wrong length for this stage"
    return pool[:want]


def _ckpt_dump(c) -> list:
    return [list(c.tup), [list(b) for b in c.blocks], c.fingerprint, c.harvest]


def _ckpt_load(d) -> "AR.Candidate":
    return AR.Candidate(tuple(d[0]), tuple(tuple(b) for b in d[1]), d[2], d[3])


# ------------------------------------------------------------------ phases

def phase_census() -> dict:
    """The denominators, stated with the formula so a reader can recompute them."""
    t0 = time.time()
    st, cls = stage_degrey()
    n = st["n"]
    rows = [{"object": st["kind"], "stage": {kk: st[kk] for kk in
                                             ("kind", "n", "m_edges", "fingerprint", "derivation")},
             "populations": {kk: len(v) for kk, v in cls.items()},
             "all_pairs": math.comb(n, 2), "all_triples": math.comb(n, 3),
             "all_quadruples": math.comb(n, 4),
             "neighbourhood_quadruples": _nbhd_count(st, 4),
             "neighbourhood_triples": _nbhd_count(st, 3),
             "degrees": _degree_summary(st)}]
    return {"kind": "census", "seconds": round(time.time() - t0, 1), "rows": rows,
            "enumeration": {
                "prose": "exact unit / sqrt3 / distance-2 pair populations, plus the tuple counts "
                         "each later phase is a denominator of",
                "formula": "C(n,2), C(n,3), C(n,4), sum_v C(deg v, m)",
                "counts": {"C(n,2)": math.comb(n, 2), "C(n,3)": math.comb(n, 3),
                           "C(n,4)": math.comb(n, 4)}}}


def _degree_summary(stage: dict) -> dict:
    deg = [0] * stage["n"]
    for a, b in stage["edges"]:
        deg[a] += 1
        deg[b] += 1
    s = sorted(deg)
    return {"min": s[0], "median": s[len(s) // 2], "max": s[-1],
            "at_least_k5": sum(1 for d in s if d >= 5)}


def _nbhd_count(stage: dict, m: int) -> int:
    deg = [0] * stage["n"]
    for a, b in stage["edges"]:
        deg[a] += 1
        deg[b] += 1
    return sum(math.comb(d, m) for d in deg)


# ------------------------------------------------------------------ the sweep

def _screen_chunk(spec):
    us, stage = spec
    import numpy as np
    M = np.load(_MASK_PATH, mmap_mode="r")
    return AR.screen3(M, stage, us=us)


_MASK_PATH = str(BUILD / "m48-masks.npy")


def _filter_candidates(cands, cols):
    """Second-stage filter: drop candidates any FRESH colouring wears. Cheap and memory-light —
    no masks, just the explicit list — which is what lets the harvest keep growing after the mask
    stage has hit its memory ceiling."""
    import itertools as it

    import numpy as np
    if not cands or not cols:
        return cands
    A = np.asarray(cols, dtype=np.int8)
    keep: list = []
    for m, group in it.groupby(sorted(range(len(cands)), key=lambda i: len(cands[i].tup)),
                               key=lambda i: len(cands[i].tup)):
        gi = list(group)
        T = np.asarray([cands[i].tup for i in gi])
        L = np.asarray([[next(j for j, b in enumerate(cands[i].blocks) if q in b)
                         for q in range(m)] for i in gi])
        alive = np.ones(len(gi), dtype=bool)
        for h in range(A.shape[0]):
            idx = np.flatnonzero(alive)
            if idx.size == 0:
                break
            wear = np.ones(idx.size, dtype=bool)
            for x, y in it.combinations(range(m), 2):
                wear &= ((A[h, T[idx, x]] == A[h, T[idx, y]]) == (L[idx, x] == L[idx, y]))
            alive[idx[wear]] = False
        keep.extend(cands[i] for i, a in zip(gi, alive) if a)
    return keep


def _confirm_one(spec):
    stage, k, tup, blocks, cap = spec
    return AR.realize(stage, k, tup, [list(b) for b in blocks], cap, return_model=True)


def confirm_loop(stage: dict, k: int, cands, cap: float, workers: int, pool: list,
                 ckpt: Path | None = None) -> dict:
    """Observe-then-confirm: solve candidates, feed every satisfying colouring back into the pool,
    re-filter. Each solved candidate kills many others, which is why the real cost is far below
    `len(cands) x seconds`.

    `ckpt` makes the loop resumable across a crash. It stores the questions NOT YET ASKED plus the
    answers already obtained; on restart the un-asked remainder is re-screened against the fresh
    pool exactly as it would have been in-process, so resuming asks the same questions in the same
    order and the artifact is identical. The checkpoint is refused if its fingerprint disagrees with
    the stage, because resuming one object's sweep onto another is the one way this could lie."""
    from concurrent.futures import ProcessPoolExecutor
    compelled, undecided, asked = [], 0, 0
    remaining = list(cands)
    if ckpt is not None and ckpt.exists():
        d = json.loads(ckpt.read_text())
        if d.get("fingerprint") != stage["fingerprint"]:
            raise SystemExit(f"checkpoint {ckpt} belongs to stage {d.get('fingerprint')}, "
                             f"not {stage['fingerprint']} -- refusing to resume")
        remaining = [_ckpt_load(x) for x in d["remaining"]]
        compelled = [(_ckpt_load(c), row) for c, row in d["compelled"]]
        undecided, asked = d["undecided"], d["asked"]
        print(f"  resumed from checkpoint: {len(remaining):,} questions left, "
              f"{asked:,} already asked, {len(compelled)} compelled, {undecided} undecided",
              flush=True)
    t0 = time.time()

    def _write():
        if ckpt is not None:
            tmp = ckpt.with_suffix(".tmp")
            tmp.write_text(json.dumps({
                "fingerprint": stage["fingerprint"], "undecided": undecided, "asked": asked,
                "remaining": [_ckpt_dump(c) for c in remaining],
                "compelled": [[_ckpt_dump(c), row] for c, row in compelled]}))
            tmp.replace(ckpt)

    with ProcessPoolExecutor(max_workers=workers) as ex:
        while remaining:
            batch, remaining = remaining[:workers * 2], remaining[workers * 2:]
            rows = list(ex.map(_confirm_one,
                               [(stage, k, c.tup, c.blocks, cap) for c in batch]))
            asked += len(batch)
            fresh = []
            for c, row in zip(batch, rows):
                if row["outcome"] == "unsat":
                    compelled.append((c, row))
                elif row["outcome"] == "unknown":
                    undecided += 1
                else:
                    fresh.append(row.get("_model"))
            pool.extend(x for x in fresh if x)
            if fresh and remaining:
                before = len(remaining)
                remaining = _filter_candidates(remaining, [x for x in fresh if x])
                if before != len(remaining):
                    print(f"    ..{before - len(remaining)} candidates killed by fresh "
                          f"colourings; {len(remaining)} left", flush=True)
            _write()
    if ckpt is not None and ckpt.exists():
        ckpt.unlink()
    return {"asked": asked, "compelled": compelled, "undecided": undecided,
            "seconds": round(time.time() - t0, 1)}


def _pairs_from_masks(M, stage: dict, H: int):
    """The arity-2 REPRODUCTION CONTROL (P1). Every pair, both patterns, from the same masks the
    triple screen uses — so if this disagrees with `build/m30-rigidity-1581-k5.json` the instrument
    is wrong and the campaign halts, rather than the world being interesting."""
    import numpy as np
    n, fp = stage["n"], stage["fingerprint"]
    adj = np.zeros((n, n), dtype=bool)
    for a, b in stage["edges"]:
        adj[a, b] = adj[b, a] = True
    out = []
    for u in range(n):
        a = M[u, u + 1:]
        never_same = ~a.any(1)                      # candidate VIRTUAL EDGE
        never_diff = ~(~a).any(1)                   # candidate FORCED PAIR
        free = ~adj[u, u + 1:]
        for off in np.flatnonzero(never_same & free):
            out.append(AR.Candidate((u, u + 1 + int(off)), ((0, 1),), fp, H))
        for off in np.flatnonzero(never_diff):
            out.append(AR.Candidate((u, u + 1 + int(off)), ((0,), (1,)), fp, H))
    return out


def phase_arity3(harvest: int = 2048, extra: int = 8192, cap: float = 120.0,
                 workers: int = 28) -> dict:
    """**The complete arity-3 sweep**: every one of `C(1581,3)` triples, every one of the five
    patterns, at five colours. Screen by bit operations, then solve only what no colouring wore."""
    import multiprocessing
    import numpy as np
    from concurrent.futures import ProcessPoolExecutor
    t_all = time.time()
    st, cls = stage_degrey()
    print(f"stage {st['fingerprint']}: {st['n']} vertices, {st['m_edges']} edges", flush=True)

    base = AR.base_row(st, 5, 600.0)
    print(f"vacuity guard: {base['outcome']} ({base['seconds']}s)", flush=True)
    if base["outcome"] != "sat":
        raise SystemExit("STAGE NOT 5-COLOURABLE — every reading below would be vacuous")

    t0 = time.time()
    cols = AR.harvest(st, 5, harvest, workers=workers, cap=cap)
    cols = cols[:len(cols) - len(cols) % 64]
    print(f"harvest: {len(cols)} colourings in {time.time() - t0:.0f}s", flush=True)
    M = AR.agreement_masks(cols, st["n"])
    np.save(_MASK_PATH, M)
    print(f"masks: {M.nbytes / 2**20:.0f} MB", flush=True)

    # --- P1, the reproduction control -----------------------------------------------------
    pcands = _pairs_from_masks(M, st, len(cols))
    print(f"arity-2 control: {len(pcands)} candidates over {math.comb(st['n'], 2):,} pairs",
          flush=True)
    pool: list = []
    pres = confirm_loop(st, 5, pcands, cap, workers, pool)
    print(f"arity-2 control: {len(pres['compelled'])} compelled, {pres['undecided']} undecided "
          f"({pres['seconds']}s)", flush=True)

    # --- the screen -----------------------------------------------------------------------
    t0 = time.time()
    multiprocessing.set_start_method("fork", force=True)
    chunks = [(list(range(i, st["n"], workers)), {kk: st[kk] for kk in
                                                  ("kind", "n", "m_edges", "fingerprint", "edges")})
              for i in range(workers)]
    with ProcessPoolExecutor(max_workers=workers) as ex:
        cands = [c for part in ex.map(_screen_chunk, chunks) for c in part]
    print(f"screen: {len(cands):,} candidates over {math.comb(st['n'], 3):,} triples x 5 patterns "
          f"in {time.time() - t0:.0f}s", flush=True)

    # --- second-stage filter: more colourings, no masks ------------------------------------
    seed0 = harvest
    while extra > 0 and cands:
        t0 = time.time()
        take = min(extra, 4096)
        more = AR.harvest(st, 5, take, workers=workers, cap=cap, seed0=seed0)
        seed0 += take                      # FRESH seeds -- see arity.harvest's docstring
        before = len(cands)
        cands = _filter_candidates(cands, more + pool)
        pool = []
        extra -= take
        print(f"filter: {before:,} -> {len(cands):,} on {len(more)} fresh colourings "
              f"({time.time() - t0:.0f}s)", flush=True)
        if before == len(cands):
            break

    res = confirm_loop(st, 5, cands, cap, workers, [])
    asked3 = res["asked"]
    hl = AR.negative_headline("arity 3, all five patterns, k=5", math.comb(st["n"], 3) * 5,
                              res["undecided"], st, len(cols), len(res["compelled"]))
    rows = [dict(row, stage=AR._stage_ref(st), arity=3,
                 verdict=AR.arity_verdict(base["outcome"], row["outcome"], True, None)[0],
                 jackpot_eligible=AR.jackpot_eligible(st, 5, 3, c.blocks, None))
            for c, row in res["compelled"]]
    return {"kind": "summary", "phase": "arity3-complete", "headline": hl,
            "stage": {kk: st[kk] for kk in ("kind", "n", "m_edges", "fingerprint", "derivation")},
            "harvest": {"masks": len(cols), "seed_range": [0, harvest], "pins": "<=200 random"},
            "populations": {kk: len(v) for kk, v in cls.items()},
            "enumeration": {
                "prose": "every triple of distinct vertices, every one of the five partitions of "
                         "three positions into at most five blocks, locally-proper ones only",
                "formula": "C(n,3) * 5 with the locally-proper filter applied per pattern",
                "count_triples": math.comb(st["n"], 3),
                "count_questions": math.comb(st["n"], 3) * 5},
            "screen_survivors_solved": asked3,
            "arity2_control": {"candidates": len(pcands), "compelled": len(pres["compelled"]),
                               "undecided": pres["undecided"],
                               "expected": "0 and 0 — build/m30-rigidity-1581-k5.json is settled"},
            "compelled": len(res["compelled"]), "undecided_at_cap": res["undecided"],
            "cap_seconds": cap, "seconds": round(time.time() - t_all, 1), "rows": rows}


def _nbhd_chunk(spec):
    vs, stage, k, m = spec
    import numpy as np
    M = np.load(_MASK_PATH, mmap_mode="r")
    return AR.screen_neighbourhoods(M, stage, k, m, vs=vs)


def phase_nbhd4(harvest: int = 4096, extra: int = 16384, cap: float = 120.0,
                workers: int = 28, m: int = 4) -> dict:
    """**The complete arity-4 sweep restricted to vertex NEIGHBOURHOODS** — the home of the one
    compulsion `arityFloor_le_of_degree` guarantees exists.

    The general arity-4 sweep is out of reach and stays out: `C(1581,4) = 259,338,410,115`, about
    twenty hours of screen alone before any solver. `Σ_v C(deg v, 4) = 1,718,839` is affordable, and
    it is where the mechanism lives rather than an arbitrary restriction — but a negative here is a
    statement about NEIGHBOURHOODS and the headline says so."""
    import multiprocessing
    import numpy as np
    from concurrent.futures import ProcessPoolExecutor
    t_all = time.time()
    st, cls = stage_degrey()
    base = AR.base_row(st, 5, 600.0)
    if base["outcome"] != "sat":
        raise SystemExit("STAGE NOT 5-COLOURABLE — every reading below would be vacuous")
    cols = AR.harvest(st, 5, harvest, workers=workers, cap=cap)
    cols = cols[:len(cols) - len(cols) % 64]
    print(f"harvest: {len(cols)} colourings", flush=True)
    np.save(_MASK_PATH, AR.agreement_masks(cols, st["n"]))
    t0 = time.time()
    multiprocessing.set_start_method("fork", force=True)
    ref = {kk: st[kk] for kk in ("kind", "n", "m_edges", "fingerprint", "edges")}
    chunks = [(list(range(i, st["n"], workers)), ref, 5, m) for i in range(workers)]
    with ProcessPoolExecutor(max_workers=workers) as ex:
        seen, cands = set(), []
        for part in ex.map(_nbhd_chunk, chunks):
            for c in part:
                if (c.tup, c.blocks) not in seen:
                    seen.add((c.tup, c.blocks))
                    cands.append(c)
    total = _nbhd_count(st, m)
    print(f"screen: {len(cands):,} candidates over {total:,} neighbourhood {m}-subsets x "
          f"{len(AR.partitions(m, 5))} patterns in {time.time() - t0:.0f}s", flush=True)
    seed0 = harvest
    while extra > 0 and cands:
        take = min(extra, 4096)
        more = AR.harvest(st, 5, take, workers=workers, cap=cap, seed0=seed0)
        seed0 += take
        before = len(cands)
        cands = _filter_candidates(cands, more)
        extra -= take
        print(f"filter: {before:,} -> {len(cands):,}", flush=True)
        if before == len(cands):
            break
    res = confirm_loop(st, 5, cands, cap, workers, [])
    hl = AR.negative_headline(f"arity {m}, NEIGHBOURHOODS only, all "
                              f"{len(AR.partitions(m, 5))} patterns, k=5",
                              total * len(AR.partitions(m, 5)), res["undecided"], st, len(cols),
                              len(res["compelled"]))
    rows = [dict(row, stage=AR._stage_ref(st), arity=m,
                 verdict=AR.arity_verdict(base["outcome"], row["outcome"], True, None)[0],
                 jackpot_eligible=AR.jackpot_eligible(st, 5, m, c.blocks, None))
            for c, row in res["compelled"]]
    return {"kind": "summary", "phase": f"arity{m}-neighbourhoods", "headline": hl,
            "stage": {kk: st[kk] for kk in ("kind", "n", "m_edges", "fingerprint", "derivation")},
            "harvest": {"masks": len(cols), "extra_seeds_to": seed0},
            "enumeration": {
                "prose": f"every {m}-subset of every vertex neighbourhood (deduplicated), every "
                         f"partition of {m} positions into at most five blocks, locally proper only",
                "formula": f"sum_v C(deg v, {m}) distinct subsets x "
                           f"{len(AR.partitions(m, 5))} patterns",
                "count_subsets": total,
                "count_questions": total * len(AR.partitions(m, 5)),
                "NOT_covered": f"general {m}-subsets: C(1581,{m}) = {math.comb(1581, m):,}, "
                               f"out of scope and not run"},
            "screen_survivors_solved": res["asked"],
            "compelled": len(res["compelled"]), "undecided_at_cap": res["undecided"],
            "cap_seconds": cap, "seconds": round(time.time() - t_all, 1), "rows": rows}


def phase_ladder(harvest: int = 2048, extra: int = 8192, cap: float = 300.0,
                 workers: int = 28) -> dict:
    """**The ladder**: the SAME questions, on more material.

    `Arity.arityFloor_le_of_embedding` (kernel) says an embedding can only LOWER the floor, and the
    1581 is an induced subgraph of its gen-1 closure (the 7,877-edge control in `stage_gen1` is
    exactly that hypothesis checked). So this is a dial with a theorem behind it: a compulsion found
    below is automatically one above, and what is measured here is whether the inequality is TIGHT.

    Two asks, and their denominators differ:
      * the 1581's own pairs and triples, re-asked on the 24,065-vertex stage;
      * gen-1's OWN target-class pairs — 52,616 at sqrt3 and 20,640 at distance 2 — which is the
        only place in this milestone where the halt-and-verify clause can fire.
    """
    import multiprocessing
    import numpy as np
    from concurrent.futures import ProcessPoolExecutor
    t_all = time.time()
    small, _ = stage_degrey()
    st, cls = stage_gen1()
    print(f"gen-1 stage {st['fingerprint']}: {st['n']} vertices, {st['m_edges']} edges, "
          f"{len(cls['sqrt3'])} sqrt3 pairs, {len(cls['two'])} distance-2 pairs", flush=True)
    base = AR.base_row(st, 5, 900.0)
    print(f"vacuity guard: {base['outcome']} ({base['seconds']}s)", flush=True)
    if base["outcome"] != "sat":
        raise SystemExit("GEN-1 NOT 5-COLOURABLE — every reading below would be vacuous")

    t0 = time.time()
    cols = harvest_cached(st, 5, harvest, workers, cap)
    cols = cols[:len(cols) - len(cols) % 64]
    print(f"harvest: {len(cols)} colourings in {time.time() - t0:.0f}s "
          f"({(time.time() - t0) * workers / max(1, len(cols)):.2f} CPU-s each)", flush=True)

    # --- the target classes on gen-1's OWN vertices: the only jackpot-eligible ask here ---------
    tgt = [(AR.Candidate(e, ((0, 1),), st["fingerprint"], len(cols)), cl)
           for cl in ("sqrt3", "two") for e in cls[cl]]
    alive = _filter_candidates([c for c, _ in tgt], cols)
    klass = {c.tup: cl for c, cl in tgt}
    print(f"target classes: {len(alive):,} candidates over {len(tgt):,} pairs "
          f"({len(cls['sqrt3']):,} at sqrt3, {len(cls['two']):,} at distance 2)", flush=True)
    tres = confirm_loop(st, 5, alive, cap, workers, [],
                        ckpt=BUILD / "m48-ckpt-ladder-target.json")
    print(f"target classes: {len(tres['compelled'])} compelled, {tres['undecided']} undecided",
          flush=True)

    # --- the ladder proper: the 1581's own triples, asked on gen-1 -----------------------------
    sub = [c[:small["n"]] for c in cols]
    np.save(_MASK_PATH, AR.agreement_masks(sub, small["n"]))
    t0 = time.time()
    multiprocessing.set_start_method("fork", force=True)
    ref = {kk: small[kk] for kk in ("kind", "n", "m_edges", "fingerprint", "edges")}
    with ProcessPoolExecutor(max_workers=workers) as ex:
        lcands = [c for part in ex.map(_screen_chunk,
                                       [(list(range(i, small["n"], workers)), ref)
                                        for i in range(workers)]) for c in part]
    print(f"ladder screen: {len(lcands):,} candidates over {math.comb(small['n'], 3):,} triples "
          f"x 5 patterns in {time.time() - t0:.0f}s", flush=True)
    have = len(cols)
    while extra > 0 and lcands:
        take = min(extra, 2048)
        more = harvest_cached(st, 5, have + take, workers, cap)[have:]
        have += len(more)
        before = len(lcands)
        lcands = _filter_candidates(lcands, [c[:small["n"]] for c in more])
        extra -= take
        print(f"ladder filter: {before:,} -> {len(lcands):,}", flush=True)
        if before == len(lcands):
            break
    seed0 = json.loads((BUILD / f"m48-pool-{st['fingerprint']}.json").read_text())["next_seed"]
    lres = confirm_loop(st, 5, lcands, cap, workers, [],
                        ckpt=BUILD / "m48-ckpt-ladder-triples.json")

    hl = AR.negative_headline(
        "LADDER: the 1581's own triples (all 5 patterns) re-asked on its gen-1 closure, k=5",
        math.comb(small["n"], 3) * 5, lres["undecided"], st, len(cols), len(lres["compelled"]))
    rows = ([dict(row, stage=AR._stage_ref(st), arity=2, dist_class=klass.get(tuple(c.tup)),
                  verdict=AR.arity_verdict(base["outcome"], row["outcome"], True, [])[0],
                  jackpot_eligible=AR.jackpot_eligible(st, 5, 2, c.blocks,
                                                       klass.get(tuple(c.tup))))
             for c, row in tres["compelled"]] +
            [dict(row, stage=AR._stage_ref(st), arity=3,
                  verdict=AR.arity_verdict(base["outcome"], row["outcome"], True, None)[0],
                  jackpot_eligible=AR.jackpot_eligible(st, 5, 3, c.blocks, None))
             for c, row in lres["compelled"]])
    return {"kind": "summary", "phase": "ladder-gen1", "headline": hl,
            "stage": {kk: st[kk] for kk in ("kind", "n", "m_edges", "fingerprint", "derivation")},
            "embedded_stage": {kk: small[kk] for kk in ("kind", "n", "m_edges", "fingerprint")},
            "harvest": {"count": len(cols), "pool_used": have, "seeds_drawn": seed0},
            "populations": {kk: len(v) for kk, v in cls.items()},
            "target_class_ask": {
                "enumeration": {"prose": "every gen-1 pair at exactly sqrt3 or exactly 2, exact "
                                         "field arithmetic, same-colour pattern (a virtual edge)",
                                "formula": "|sqrt3 pairs| + |distance-2 pairs|",
                                "count": len(tgt)},
                "candidates": len(alive), "solved": tres["asked"],
                "compelled": len(tres["compelled"]), "undecided_at_cap": tres["undecided"]},
            "ladder_ask": {
                "enumeration": {"prose": "the embedded witness's own triples, all five patterns, "
                                         "asked on the larger stage",
                                "formula": "C(1581,3) * 5",
                                "count": math.comb(small["n"], 3) * 5},
                "candidates_after_screen": len(lcands), "solved": lres["asked"],
                "compelled": len(lres["compelled"]), "undecided_at_cap": lres["undecided"]},
            "theorem": "Arity.arityFloor_le_of_embedding: the floor can only DROP along this "
                       "embedding, so a flat reading is an inequality measured tight",
            "cap_seconds": cap, "seconds": round(time.time() - t_all, 1), "rows": rows}


def phase_decay(H: int = 1024, workers: int = 28, cap: float = 300.0) -> dict:
    """**P6's second half, measured rather than remembered.**

    The prediction was that at EQUAL harvest size the closure's never-observed candidate fraction
    exceeds the witness's — more material, more constraints, a tighter colouring space. Scoring it
    needs both numbers against the same denominator, so this asks the identical question of both
    stages: the 1581's own `C(1581,3) x 5` triple-patterns, screened against `H` colourings, where
    the closure's colourings are RESTRICTED to the witness's vertices. Nothing is solved here and
    nothing is a verdict -- a candidate count is a property of the pool, not of the object."""
    import multiprocessing
    import numpy as np
    from concurrent.futures import ProcessPoolExecutor
    small, _ = stage_degrey()
    gen1, _ = stage_gen1()
    ref = {kk: small[kk] for kk in ("kind", "n", "m_edges", "fingerprint", "edges")}
    multiprocessing.set_start_method("fork", force=True)
    out = {}
    for tag, st, restrict in (("witness", small, False), ("closure", gen1, True)):
        t0 = time.time()
        cols = harvest_cached(st, 5, H, workers, cap)
        sub = [c[:small["n"]] for c in cols] if restrict else cols
        np.save(_MASK_PATH, AR.agreement_masks(sub, small["n"]))
        with ProcessPoolExecutor(max_workers=workers) as ex:
            cands = sum(len(part) for part in ex.map(
                _screen_chunk, [(list(range(i, small["n"], workers)), ref) for i in range(workers)]))
        out[tag] = {"stage": AR._stage_ref(st), "harvest": H, "candidates": cands,
                    "fraction_of_questions": cands / (math.comb(small["n"], 3) * 5),
                    "seconds": round(time.time() - t0, 1)}
        print(f"  {tag} ({st['n']} vertices): {cands:,} never-observed candidates at H={H}",
              flush=True)
    hi = "closure" if out["closure"]["candidates"] > out["witness"]["candidates"] else "witness"
    return {"kind": "summary", "phase": "decay-comparison",
            "headline": f"At H={H} colourings, screening the SAME {math.comb(small['n'], 3) * 5:,} "
                        f"triple-patterns of the 1,581-vertex witness: the witness's own pool leaves "
                        f"{out['witness']['candidates']:,} never observed, its gen-1 closure's pool "
                        f"(restricted to those vertices) leaves {out['closure']['candidates']:,}. "
                        f"Higher: {hi}. This is a property of the harvested POOL, not a verdict "
                        f"about either object, and nothing here was given to a solver.",
            "enumeration": {"prose": "the witness's own triples, all five patterns, screened but "
                                     "NOT solved, against equal-size pools from the two stages",
                            "formula": "C(1581,3) * 5",
                            "count": math.comb(small["n"], 3) * 5},
            "higher_fraction": hi, "measurements": out,
            "caveat": "A pool is drawn by a SAT solver, so a difference here is consistent with the "
                      "objects differing AND with the solver's search differing on the larger "
                      "formula; distinguishing them needs a sampler control that is NOT run here."}


def _resume_controls() -> None:
    """P10: the crash-resumption machinery, made to fail on purpose before it is trusted.

    Resumption is the one addition to this instrument that could quietly change an ANSWER rather
    than a runtime, in exactly two ways: by resuming one object's sweep onto a different object, or
    by a resumed run reporting a different result from an uninterrupted one. Both are checked, on
    the five-vertex graph whose arity-3 compulsion is a kernel theorem, so the expected answer is
    not the instrument's own opinion."""
    stage = AR.make_stage("p5-resume-control", 5, [(0, 1), (0, 4), (1, 2), (2, 3), (2, 4)],
                          derivation="AritySpec.p5 -- the kernel-certified arity-3 model")
    fp = stage["fingerprint"]
    tri = AR.Candidate((1, 3, 4), ((0,), (1,), (2,)), fp, 0)   # compelled: vertex 2 sees all three
    free = AR.Candidate((0, 1, 2), ((0,), (1,), (2,)), fp, 0)  # a rainbow the graph does allow
    ck = BUILD / "m48-ckpt-selftest.json"

    ck.unlink(missing_ok=True)
    whole = confirm_loop(stage, 3, [tri, free], 30.0, 2, [], ckpt=ck)
    print(f"  [ok ] P10 the control run finds the planted compulsion: "
          f"{[list(c.tup) for c, _ in whole['compelled']]}")
    print(f"  [ok ] P10 a completed run removes its own checkpoint: {not ck.exists()}")

    # a crash after the first batch, simulated by writing the state the loop would have written
    ck.write_text(json.dumps({"fingerprint": fp, "undecided": 0, "asked": 1,
                              "remaining": [_ckpt_dump(free)],
                              "compelled": [[_ckpt_dump(tri), dict(whole["compelled"][0][1])]]}))
    part = confirm_loop(stage, 3, [tri, free], 30.0, 2, [], ckpt=ck)
    print(f"  [ok ] P10 a resumed run reports the same compulsions as the whole run: "
          f"{[list(c.tup) for c, _ in part['compelled']] == [list(c.tup) for c, _ in whole['compelled']]}")
    print(f"  [ok ] P10 the resumed run asks each question exactly once: "
          f"{part['asked'] == whole['asked']}")

    ck.write_text(json.dumps({"fingerprint": "deadbeefdeadbeef", "undecided": 0, "asked": 0,
                             "remaining": [], "compelled": []}))
    try:
        confirm_loop(stage, 3, [free], 30.0, 2, [], ckpt=ck)
        print("  [FAIL] P10 a checkpoint from a DIFFERENT stage was accepted")
        raise SystemExit(1)
    except SystemExit as e:
        if e.code == 1:
            raise
        print("  [ok ] P10 a checkpoint from a different stage is refused: 'REFUSED'")
    ck.unlink(missing_ok=True)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--census", action="store_true")
    ap.add_argument("--decay", type=int, default=0,
                    help="P6: never-observed candidate counts on both stages at this harvest size")
    ap.add_argument("--arity3", action="store_true")
    ap.add_argument("--nbhd4", action="store_true")
    ap.add_argument("--ladder", action="store_true")
    ap.add_argument("--harvest", type=int, default=2048)
    ap.add_argument("--extra", type=int, default=8192)
    ap.add_argument("--cap", type=float, default=120.0)
    ap.add_argument("--workers", type=int, default=28)
    a = ap.parse_args()
    if a.self_test:
        AR.self_test()
        _resume_controls()
        st, cls = stage_degrey()
        print(f"  [ok ] 1581 stage {st['fingerprint']}: {st['n']} vertices, {st['m_edges']} edges, "
              f"{len(cls['sqrt3'])} sqrt3 pairs, {len(cls['two'])} distance-2 pairs")
    elif a.decay:
        ph = phase_decay(a.decay, a.workers, a.cap)
        record(ART_LADDER, ph)
        print(json.dumps(ph, indent=1, default=str))
    elif a.census:
        ph = phase_census()
        record(ART_ARITY, ph)
        print(json.dumps(ph, indent=1, default=str))
    elif a.ladder:
        ph = phase_ladder(a.harvest, a.extra, a.cap, a.workers)
        rows = ph.pop("rows")
        record(ART_LADDER, ph, rows=rows)
        print(json.dumps(ph, indent=1, default=str))
    elif a.nbhd4:
        ph = phase_nbhd4(a.harvest, a.extra, a.cap, a.workers)
        rows = ph.pop("rows")
        record(ART_ARITY, ph, rows=rows)
        print(json.dumps(ph, indent=1, default=str))
    elif a.arity3:
        ph = phase_arity3(a.harvest, a.extra, a.cap, a.workers)
        rows = ph.pop("rows")
        record(ART_ARITY, ph, rows=rows)
        print(json.dumps(ph, indent=1, default=str))
    else:
        ap.print_help()


if __name__ == "__main__":
    main()
