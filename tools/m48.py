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
    three, four = [3 * x for x in one], [4 * x for x in one]
    assert type(three) is type(one), f"NORM CONSTANT TYPE MISMATCH in {tag}"
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


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--census", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        AR.self_test()
        st, cls = stage_degrey()
        print(f"  [ok ] 1581 stage {st['fingerprint']}: {st['n']} vertices, {st['m_edges']} edges, "
              f"{len(cls['sqrt3'])} sqrt3 pairs, {len(cls['two'])} distance-2 pairs")
    elif a.census:
        ph = phase_census()
        record(ART_ARITY, ph)
        print(json.dumps(ph, indent=1, default=str))
    else:
        ap.print_help()


if __name__ == "__main__":
    main()
