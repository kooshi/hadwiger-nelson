#!/usr/bin/env python3
"""The mechanism hunt's sweep driver (M33): onset curves, the class-avoidance spectrum, cores.

UNTRUSTED, like everything in `tools/`. A core this tool names becomes mathematics only when
the A5 certificate lands (plans/M33-mechanism-hunt.md §0a); a bug here can cost a theorem and
never buy one.

## The division of labour (§0f F2)

`tools/rigidity.py` owns the SAT encodings and never sees a coordinate; THIS module owns the
geometry (exact 16-basis field arithmetic over primes 3·5·7·11) and never builds a clause.
Regions are id-mapped at the boundary once: every emitted reading speaks OBJECT ids only.

## Verbs

    python3 tools/mechanism.py                    # --status: what exists, what runs next
    python3 tools/mechanism.py --self-test        # driver checks: checkers seen red, guards trip
    python3 tools/mechanism.py --controls         # P8 (791 pairs), P9 (M20 skeleton), P10 (hexagram)
    python3 tools/mechanism.py --fabric-info      # free geometry: size the fabric stage (A4)
    python3 tools/mechanism.py --sweep OBJ CENTRE      # min-cover curve at every ring mark
    python3 tools/mechanism.py --spectrum OBJ CENTRE   # class onsets by binary search + re-encode
    python3 tools/mechanism.py --shrink OBJ CENTRE CLASS R2   # 1-minimal core from a fired region

Sweeps belong on the DESKTOP (§0e); artifacts are written per-row — re-running resumes after
the last written row; delete the artifact to restart. A monotonicity violation aborts naming
§0f F4; a containment violation aborts naming §0a A2; both leave status "aborted-invariant".
`unknown` rows are capped readings — not bounds, not claims.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from fractions import Fraction as F
from pathlib import Path
from threading import Lock

TOOLS = Path(__file__).resolve().parent
BUILD = TOOLS.parent / "build"
sys.path.insert(0, str(TOOLS))

import heule as H  # noqa: E402  — the shared 16-basis field ops
from rigidity import (amo_clauses, avoid_verdict, class_avoid, class_avoid_binary,  # noqa: E402
                      min_cover, mono_realizable)

INVARIANT_EXIT = 4

# The standing parallelism rule (Kooshi, 2026-08-10): use as many threads as RAM allows.
# `_solve` runs CaDiCaL as a subprocess (the GIL drops during the wait), so a THREAD pool
# parallelizes the SAT calls; at ≤ 2k-vertex graphs each worker is tens of MB — cores − 2
# is safely inside RAM on both machines.
WORKERS = max(2, (os.cpu_count() or 4) - 2)
_ARTLOCK = Lock()


def pmap(fn, items):
    """Order-preserving parallel map over the shared pool."""
    if len(items) <= 1:
        return [fn(x) for x in items]
    with ThreadPoolExecutor(max_workers=WORKERS) as ex:
        return list(ex.map(fn, items))

BVAL = [1.0] * 16
for _i in range(16):
    _v = 1.0
    for _k, _p in enumerate(H.PRIMES):
        if (_i >> _k) & 1:
            _v *= _p ** 0.5
    BVAL[_i] = _v


def fnum(vec) -> float:
    return sum(float(x) * BVAL[i] for i, x in enumerate(vec) if x)


def d2(p, q):
    dx = H.sub(p[0], q[0])
    dy = H.sub(p[1], q[1])
    return H.add(H.mul(dx, dx), H.mul(dy, dy))


def xy(pts) -> list[tuple[float, float]]:
    return [(fnum(p[0]), fnum(p[1])) for p in pts]


def r2_str(vec) -> str:
    """Sparse exact rendering: {basis index: p/q} — the artifact's exact twin of the float."""
    return json.dumps({str(i): f"{x.numerator}/{x.denominator}" for i, x in enumerate(vec) if x})


# ------------------------------------------------------------------ objects

def _tuples(pts, denom=1):
    den = F(denom)
    return [(tuple(F(x) / den for x in p[0]), tuple(F(y) / den for y in p[1])) for p in pts]


def unit_edges_of(pts, fxy) -> list[tuple[int, int]]:
    """Float-prefiltered, exactly-confirmed unit pairs — an integer identity, never a tolerance."""
    one = H.rat(1)
    out = []
    n = len(pts)
    for i in range(n):
        xi, yi = fxy[i]
        for j in range(i + 1, n):
            dx = xi - fxy[j][0]
            dy = yi - fxy[j][1]
            f = dx * dx + dy * dy
            if abs(f - 1.0) < 1e-6 and d2(pts[i], pts[j]) == one:
                out.append((i, j))
    return out


def load_object(name: str) -> dict:
    """`{name, pts, xy, edges, centres: {label: exact point}}` — centres are geometric points;
    a centre that is also a VERTEX is dropped from every region (fan semantics: G − v)."""
    if name == "heule510":
        d = json.load(open(TOOLS / "heule510.json"))
        pts = _tuples(d["coords"], d["denom"])
        edges = [tuple(e) for e in d["edges"]]
        return {"name": name, "pts": pts, "xy": xy(pts), "edges": edges,
                "centres": {"v0": pts[0]}}
    if name == "degrey1581":
        import construct as CN
        cfg = CN.degrey_from_primitives()
        pts = _tuples(cfg.pts, cfg.denom)
        fxy = xy(pts)
        edges = unit_edges_of(pts, fxy)
        if len(pts) != 1581 or len(edges) != 7877:
            raise SystemExit(f"DEGREY REGEN MISMATCH: {len(pts)} pts / {len(edges)} edges "
                             "(committed: 1581 / 7877) — the construction moved; halt")
        return {"name": name, "pts": pts, "xy": fxy, "edges": edges,
                "centres": {"origin": (H.rat(0), H.rat(0)), "centre2": (H.rat(-2), H.rat(0))}}
    if name == "fabric":
        import construct as CN
        cfg = CN.orbit(CN.degrey_seed(), CN.hex12())
        pts = _tuples(cfg.pts, cfg.denom)
        fxy = xy(pts)
        return {"name": name, "pts": pts, "xy": fxy, "edges": unit_edges_of(pts, fxy),
                "centres": {"origin": (H.rat(0), H.rat(0))}}
    if name.startswith("hexchunkB") and name[9:].isdigit():
        import closure as CL
        cpts, mpiv, _hexpiv = CL.hexagram_points(int(name[9:]))
        pts = [(tuple(p[0]), tuple(p[1])) for p in cpts]
        fxy = xy(pts)
        return {"name": name, "pts": pts, "xy": fxy, "edges": unit_edges_of(pts, fxy),
                "centres": {"meta": (tuple(mpiv[0]), tuple(mpiv[1]))}}
    raise SystemExit(f"UNKNOWN OBJECT {name!r} (heule510 | degrey1581 | fabric | hexchunkB<n>)")


# ------------------------------------------------------------------ classes and instances

CLASSES = {
    "eq-pair-sqrt3": {"arity": 2, "d2": F(3)},
    "mono-triple-sqrt3": {"arity": 3, "d2": F(3), "mutual": True},
    "eq-pair-2": {"arity": 2, "d2": F(4)},
    "eq-pair-4": {"arity": 2, "d2": F(16)},
    "eq-pair-4rt3": {"arity": 2, "d2": F(16, 3)},
}


def instances_of(obj: dict, ids: list[int], cls: dict) -> list[tuple]:
    """Class instances entirely inside the id set, float-prefiltered and exactly confirmed —
    with the §0g guards: no instance tuple may contain a graph edge (class distances are never
    1), and each mutual triple's three pairs must appear in the pair inventory."""
    target = H.rat(cls["d2"])
    tf = float(F(cls["d2"]))
    pts, fxy = obj["pts"], obj["xy"]
    eset = {tuple(sorted(e)) for e in obj["edges"]}
    pairs = []
    for a in range(len(ids)):
        i = ids[a]
        xi, yi = fxy[i]
        for b in range(a + 1, len(ids)):
            j = ids[b]
            dx = xi - fxy[j][0]
            dy = yi - fxy[j][1]
            if abs(dx * dx + dy * dy - tf) < 1e-6 and d2(pts[i], pts[j]) == target:
                pairs.append((i, j))
    for p in pairs:
        if p in eset:
            raise SystemExit(f"ENUMERATOR GUARD: instance pair {p} is a graph edge — the class "
                             "d² spec collides with the unit distance; check the class table")
    if cls["arity"] == 2:
        return pairs
    adj: dict[int, set] = {}
    for a, b in pairs:
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)
    pset = set(pairs)
    tris = []
    for a, b in pairs:
        for c in adj.get(a, set()) & adj.get(b, set()):
            if c > b:
                for q in [(a, b), (a, c), (b, c)]:
                    if tuple(sorted(q)) not in pset:
                        raise SystemExit(f"ENUMERATOR GUARD (§0a A2): triple {(a, b, c)} has a "
                                         f"pair {q} missing from the pair inventory")
                tris.append((a, b, c))
    return tris


# ------------------------------------------------------------------ regions

def spectrum_of(obj: dict, centre) -> list[tuple[float, object, int]]:
    """(float r², exact r², object id) per vertex about the centre, sorted."""
    return sorted((fnum(d2(p, centre)), d2(p, centre), i) for i, p in enumerate(obj["pts"]))


def region_at(obj: dict, centre, mark: float) -> dict:
    """The induced ball at the mark, centre VERTEX excluded (fan semantics), id-mapped once.
    S is the unit circle about the centre (the full object's), intersected with the ball."""
    spec = spectrum_of(obj, centre)
    one = H.rat(1)
    ids = sorted(i for f, _, i in spec if 1e-9 < f <= mark + 1e-9)
    pos = {i: a for a, i in enumerate(ids)}
    edges = [(pos[a], pos[b]) for a, b in obj["edges"] if a in pos and b in pos]
    S_obj = [i for f, r2v, i in spec if r2v == one and i in pos]
    return {"ids": ids, "pos": pos, "n": len(ids), "edges": edges,
            "S_obj": S_obj, "S": [pos[i] for i in S_obj]}


# ------------------------------------------------------------------ invariants (abort contract)

def abort_invariant(which: str, detail: str, art: dict | None = None,
                    path: Path | None = None) -> None:
    if art is not None and path is not None:
        art["status"] = "aborted-invariant"
        path.write_text(json.dumps(art, indent=1))
    print(f"\n*** {which} VIOLATION — instrument bug; run aborted"
          + (f"; artifact {path.name} status=aborted-invariant" if path else ""))
    print(f"*** {detail}")
    raise SystemExit(INVARIANT_EXIT)


def check_cover_monotone(rows, art=None, path=None) -> None:
    """§0f F4: the (lo, hi) interval sequence must admit a nondecreasing selection; `unknown`
    rows widen intervals and are skipped, never compared."""
    running = 1
    prev = None
    for r in rows:
        if r["cover"]["verdict"] in ("unknown", "vacuous"):
            continue
        running = max(running, r["cover"]["lo"])
        if running > r["cover"]["hi"]:
            abort_invariant("MONOTONICITY (§0f F4)",
                            f"cover interval at mark {r['r2']} (hi={r['cover']['hi']}) below the "
                            f"running floor {running} set by mark {prev}", art, path)
        prev = r["r2"]


def check_class_monotone(rows, name: str, art=None, path=None) -> None:
    """§0f F4 for a class: fired at a smaller mark while clean at a larger one is impossible."""
    fired_at = None
    for r in sorted(rows, key=lambda r: r["r2"]):
        v = r.get("verdict")
        if v == "fired":
            fired_at = r["r2"]
        elif v == "clean" and fired_at is not None:
            abort_invariant("MONOTONICITY (§0f F4)",
                            f"class {name}: fired at mark {fired_at} yet clean at larger mark "
                            f"{r['r2']}", art, path)


def check_containment(pair_verdict: str, triple_verdict: str, where: str,
                      art=None, path=None) -> None:
    """§0a A2: no equal √3-pair ⟹ no mono √3-triple, so triple-fired ∧ pair-clean is a bug."""
    if triple_verdict == "fired" and pair_verdict == "clean":
        abort_invariant("CONTAINMENT (§0a A2)",
                        f"at {where}: mono-triple-sqrt3 fired while eq-pair-sqrt3 read clean",
                        art, path)


# ------------------------------------------------------------------ the sweep (min-cover curves)

def base_and_classes(obj, reg, k, cap, class_names, want_witness=False):
    """One region's readings: the shared base row (the cover ladder's guard row) + one
    avoidance row per class, verdicts through `avoid_verdict` only."""
    mc = min_cover(reg["n"], reg["edges"], k, reg["S"], cap)
    base = mc["rows"][0]["outcome"]
    out = {"cover": {"rows": mc["rows"], "lo": mc.get("lo"), "hi": mc.get("hi"),
                     "verdict": mc["verdict"]},
           "classes": {}}
    for cn in class_names:
        inst_obj = instances_of(obj, reg["ids"], CLASSES[cn])
        inst = [tuple(reg["pos"][v] for v in t) for t in inst_obj]
        if base == "sat" and inst:
            row = class_avoid(reg["n"], reg["edges"], k, inst, cap, want_model=want_witness)
            row.pop("colours", None)
            row["verdict"] = avoid_verdict(base, row["outcome"], len(inst))
            row["promotion"] = "provisional" if row["verdict"] == "fired" else None
        else:
            row = {"n_instances": len(inst), "outcome": None,
                   "verdict": avoid_verdict(base, None, len(inst)), "promotion": None}
        out["classes"][cn] = row
    if "mono-triple-sqrt3" in out["classes"] and "eq-pair-sqrt3" in out["classes"]:
        check_containment(out["classes"]["eq-pair-sqrt3"]["verdict"],
                          out["classes"]["mono-triple-sqrt3"]["verdict"], "region")
    return out


def art_path(obj_name: str, centre: str) -> Path:
    return BUILD / f"m33-spectrum-{obj_name}-{centre}.json"


def load_art(path: Path, obj_name: str, centre: str, k: int) -> dict:
    if path.exists():
        return json.loads(path.read_text())
    return {"schema": "m33-spectrum v1 (plans/M33-mechanism-hunt.md §0h)",
            "object": obj_name, "centre": centre, "k": k, "machine": None,
            "marks": [], "onsets": {"cover": {}, "classes": {}},
            "invariants_checked": ["F4-monotone", "A2-containment"], "status": "partial"}


def sweep(obj_name: str, centre: str, cap: float, machine: str, quantiles: int | None) -> None:
    obj = load_object(obj_name)
    if centre not in obj["centres"]:
        raise SystemExit(f"UNKNOWN CENTRE {centre!r} ({' | '.join(obj['centres'])})")
    ct = obj["centres"][centre]
    spec = spectrum_of(obj, ct)
    marks = sorted({round(f, 9) for f, _, _ in spec if f > 1e-9})
    if quantiles and len(marks) > quantiles:
        step = len(marks) / quantiles
        marks = sorted({marks[min(len(marks) - 1, int(step * (q + 1)) - 1)]
                        for q in range(quantiles)})
    path = art_path(obj_name, centre)
    art = load_art(path, obj_name, centre, 4)
    art["machine"] = machine
    done = {r["r2"] for r in art["marks"]}
    exact_by_mark = {round(f, 9): r2v for f, r2v, _ in spec}
    todo = [m for m in marks if m not in done]

    def run_mark(m: float) -> dict:
        reg = region_at(obj, ct, m)
        t0 = time.time()
        row = {"r2": m, "r2_exact": r2_str(exact_by_mark[m]), "n": reg["n"],
               "n_edges": len(reg["edges"]), "n_target": len(reg["S"])}
        row.update(base_and_classes(obj, reg, 4, cap, [], False))
        row["seconds"] = round(time.time() - t0, 2)
        return row

    with ThreadPoolExecutor(max_workers=WORKERS) as ex:
        futures = {ex.submit(run_mark, m): m for m in todo}
        from concurrent.futures import as_completed
        for fut in as_completed(futures):
            row = fut.result()
            with _ARTLOCK:
                art["marks"].append(row)
                art["marks"].sort(key=lambda r: r["r2"])
                check_cover_monotone(art["marks"], art, path)
                path.write_text(json.dumps(art, indent=1))
            cov = row["cover"]
            print(f"  r²≤{row['r2']:<10.4f} n={row['n']:<5d} |S∩ball|={row['n_target']:<3d} "
                  f"cover=[{cov['lo']},{cov['hi']}] {cov['verdict']} ({row['seconds']}s)",
                  flush=True)
    for level in (2, 3, 4):
        onset = next((r["r2"] for r in art["marks"]
                      if r["cover"]["verdict"] in ("settled", "fanned", "interval")
                      and r["cover"]["lo"] >= level), None)
        art["onsets"]["cover"][str(level)] = onset
    art["status"] = "done"
    path.write_text(json.dumps(art, indent=1))
    print(f"cover onsets: {art['onsets']['cover']}  → {path.name}")


# ------------------------------------------------------------------ the spectrum (class onsets)

def class_onset(obj_name: str, centre: str, cls_name: str, cap: float, machine: str) -> None:
    """Binary search over the ring marks (§0f F4 exploits monotonicity); the fired onset is
    confirmed through the decorrelated binary re-encode before being reported."""
    if cls_name not in CLASSES:
        raise SystemExit(f"UNKNOWN CLASS {cls_name!r} ({' | '.join(CLASSES)})")
    obj = load_object(obj_name)
    ct = obj["centres"][centre]
    spec = spectrum_of(obj, ct)
    marks = sorted({round(f, 9) for f, _, _ in spec if f > 1e-9})
    path = art_path(obj_name, centre)
    art = load_art(path, obj_name, centre, 4)
    art["machine"] = machine
    rows = []

    def probe(m: float) -> str:
        reg = region_at(obj, ct, m)
        r = base_and_classes(obj, reg, 4, cap, [cls_name], False)["classes"][cls_name]
        r["r2"] = m
        r["n"] = reg["n"]
        rows.append(r)
        print(f"  probe r²≤{m:.4f} n={reg['n']} → {r['verdict']} "
              f"({r.get('seconds', 0)}s, {r['n_instances']} instances)", flush=True)
        return r["verdict"]

    lo, hi = 0, len(marks) - 1
    top = probe(marks[hi])
    onset = None
    if top == "fired":
        while lo < hi:
            mid = (lo + hi) // 2
            v = probe(marks[mid])
            if v == "fired":
                hi = mid
            elif v in ("clean", "empty"):
                lo = mid + 1
            else:  # unknown / vacuous / unknown-at-base: step up once, else give the interval
                lo = mid + 1
        onset = marks[hi]
        reg = region_at(obj, ct, onset)
        inst_obj = instances_of(obj, reg["ids"], CLASSES[cls_name])
        inst = [tuple(reg["pos"][v] for v in t) for t in inst_obj]
        rb = class_avoid_binary(reg["n"], reg["edges"], 4, inst, cap)
        promotion = "reencode-confirmed" if rb["outcome"] == "unsat" else "DISAGREEMENT"
        if promotion == "DISAGREEMENT":
            abort_invariant("RE-ENCODE (§0g G-3)",
                            f"one-hot fired at mark {onset} but binary read {rb['outcome']} — "
                            "one clause generator is wrong; halt everything", art, path)
    else:
        promotion = None
    check_class_monotone(rows, cls_name, art, path)
    art["onsets"]["classes"][cls_name] = {"onset_r2": onset, "promotion": promotion,
                                          "rows": rows, "top_verdict": top}
    path.write_text(json.dumps(art, indent=1))
    print(f"class {cls_name}: onset {onset} ({promotion or top})  → {path.name}")


# ------------------------------------------------------------------ the shrink (1-minimal cores)

def greedy_1min(ids: list[int], order: list[int], fired_on) -> tuple[list[int], list[int], int]:
    """The shared greedy engine: speculative parallel batches, sound by monotonicity — a
    REJECTED deletion (the property un-fired) stays rejected after further deletions (the
    witnessing colouring restricts), so within a pass rejections are skipped for good; on an
    acceptance, later batch results were tested against a stale set and are simply requeued.
    Runs to the zero-acceptance fixpoint; the caller performs the necessity census."""
    deletions: list[int] = []
    changed = True
    passes = 0
    while changed:
        changed = False
        passes += 1
        queue = [w for w in order if w in ids]
        qi = 0
        while qi < len(queue):
            batch = [w for w in queue[qi:qi + WORKERS] if w in ids]
            if not batch:
                qi += WORKERS
                continue
            base_ids = list(ids)
            oks = pmap(lambda v: fired_on([w for w in base_ids if w != v])[0], batch)
            acc = next((bi for bi, ok in enumerate(oks) if ok), None)
            if acc is None:
                qi += len(batch)
            else:
                ids = [w for w in base_ids if w != batch[acc]]
                deletions.append(batch[acc])
                changed = True
                qi += acc + 1
        print(f"  pass {passes}: |core| = {len(ids)}", flush=True)
    return ids, deletions, passes


def shrink_cover(obj_name: str, centre: str, level: int, start_mark: float, cap: float,
                 machine: str) -> None:
    """The coverage-core shrink (P3): the minimal ambient web forcing ≥ `level` colours onto
    the target circle S in every proper 4-colouring. S is HELD FIXED — it is the claim's
    subject, so only ambient (non-S) vertices are deletable. fired ⟺ the base row (j = k) is
    SAT and coverage_query at j = level−1 is UNSAT. Coverage queries carry NO palette
    breaking (their restrictions name colours). Solver-measured, never a theorem."""
    from rigidity import coverage_query
    obj = load_object(obj_name)
    ct = obj["centres"][centre]
    reg = region_at(obj, ct, start_mark)
    S_set = set(reg["S_obj"])
    ids = list(reg["ids"])
    spec_f = {i: f for f, _, i in spectrum_of(obj, ct)}

    def fired_on(sub: list[int]) -> tuple[bool, dict]:
        pos = {i: a for a, i in enumerate(sub)}
        eds = [(pos[a], pos[b]) for a, b in obj["edges"] if a in pos and b in pos]
        S = [pos[i] for i in reg["S_obj"]]
        base = coverage_query(len(sub), eds, 4, S, 4, cap)
        if base["outcome"] != "sat":
            return False, base
        row = coverage_query(len(sub), eds, 4, S, level - 1, cap)
        return row["outcome"] == "unsat", row

    ok, _ = fired_on(ids)
    if not ok:
        raise SystemExit(f"SHRINK-COVER REJECTED: min-cover ≥ {level} does not hold at mark "
                         f"{start_mark} — shrink starts from a fired region only")
    order = sorted([i for i in ids if i not in S_set], key=lambda i: -spec_f[i])
    ids, deletions, passes = greedy_1min(ids, order, fired_on)
    res = pmap(lambda v: (v, *fired_on([w for w in ids if w != v])),
               [v for v in ids if v not in S_set])
    witnesses = {}
    for v, ok, row in res:
        if ok:
            abort_invariant("FIXPOINT (§0g G-3)",
                            f"ambient vertex {v} still fires after the zero-acceptance pass")
        witnesses[str(v)] = row.get("used_on_target")
    rings: dict[str, int] = {}
    for i in ids:
        key = f"{spec_f[i]:.6f}"
        rings[key] = rings.get(key, 0) + 1
    core = {"schema": "m33-core v1 (plans/M33-mechanism-hunt.md §0h)", "object": obj_name,
            "centre": centre, "query": {"type": "coverage", "level": level}, "k": 4,
            "machine": machine, "start_mark": start_mark, "vertices": sorted(ids),
            "n": len(ids), "n_target": len(S_set), "deletion_order": deletions,
            "passes": passes,
            "necessity": {"complete": True, "witnesses_validated": len(witnesses),
                          "note": "ambient members only — S is the claim's subject"},
            "anatomy": {"rings": rings}, "status": "solver-measured"}
    out = BUILD / f"m33-covercore-{obj_name}-{centre}-L{level}.json"
    out.write_text(json.dumps(core, indent=1))
    print(f"COVER CORE (level {level}): {len(ids)} vertices ({len(S_set)} target + "
          f"{len(ids) - len(S_set)} ambient), {passes} passes  → {out.name}")

def shrink(obj_name: str, centre: str, cls_name: str, start_mark: float, cap: float,
           machine: str) -> None:
    """Greedy deletion to the 1-MINIMAL FIXPOINT (§0g G-3): every surviving vertex's deletion
    un-fires the class, witnessed by a validated clean model held in the artifact. The core's
    own UNSAT is then re-confirmed through the binary re-encode. Solver-measured, never a
    theorem — promotion is A5's certificate."""
    obj = load_object(obj_name)
    ct = obj["centres"][centre]
    cls = CLASSES[cls_name]
    reg = region_at(obj, ct, start_mark)
    ids = list(reg["ids"])
    spec_f = {i: f for f, _, i in spectrum_of(obj, ct)}

    def fired_on(sub: list[int]) -> tuple[bool, dict]:
        pos = {i: a for a, i in enumerate(sub)}
        eds = [(pos[a], pos[b]) for a, b in obj["edges"] if a in pos and b in pos]
        inst_obj = instances_of(obj, sub, cls)
        if not inst_obj:
            return False, {"outcome": "no-instances"}
        inst = [tuple(pos[v] for v in t) for t in inst_obj]
        row = class_avoid(len(sub), eds, 4, inst, cap, want_model=True)
        return row["outcome"] == "unsat", row

    ok, _ = fired_on(ids)
    if not ok:
        raise SystemExit(f"SHRINK REJECTED: the class does not fire at mark {start_mark} — "
                         "shrink starts from a FIRED region only")
    ids, deletions, passes = greedy_1min(ids, sorted(ids, key=lambda i: -spec_f[i]), fired_on)
    # The necessity census (§0g G-3), fully parallel: every member's deletion must un-fire,
    # each witnessed by a validated clean model held in the artifact.
    res = pmap(lambda v: (v, *fired_on([w for w in ids if w != v])), list(ids))
    witnesses = {}
    for v, ok, row in res:
        if ok:
            abort_invariant("FIXPOINT (§0g G-3)",
                            f"vertex {v} still fires after the zero-acceptance pass said it "
                            "would not — the greedy loop is inconsistent")
        witnesses[str(v)] = row.get("colours")
    pos = {i: a for a, i in enumerate(ids)}
    eds = [(pos[a], pos[b]) for a, b in obj["edges"] if a in pos and b in pos]
    inst = [tuple(pos[v] for v in t) for t in instances_of(obj, ids, cls)]
    rb = class_avoid_binary(len(ids), eds, 4, inst, cap)
    if rb["outcome"] != "unsat":
        abort_invariant("RE-ENCODE (§0g G-3)",
                        f"the final core fires one-hot but binary read {rb['outcome']}")
    rings: dict[str, int] = {}
    for i in ids:
        key = f"{spec_f[i]:.6f}"
        rings[key] = rings.get(key, 0) + 1
    core = {"schema": "m33-core v1 (plans/M33-mechanism-hunt.md §0h)", "object": obj_name,
            "centre": centre, "class": {"name": cls_name, "arity": cls["arity"],
                                        "d2": str(cls["d2"])}, "k": 4, "machine": machine,
            "start_mark": start_mark, "vertices": sorted(ids), "n": len(ids),
            "deletion_order": deletions, "passes": passes,
            "necessity": {"complete": True, "witnesses_validated": len(witnesses)},
            "necessity_witnesses": witnesses,
            "reencode": {"encoding": "binary-2bit", "outcome": rb["outcome"]},
            "anatomy": {"rings": rings}, "status": "solver-measured"}
    out = BUILD / f"m33-core-{obj_name}-{cls_name}.json"
    out.write_text(json.dumps(core, indent=1))
    print(f"CORE: {len(ids)} vertices, {passes} passes, 1-minimal with witnesses, "
          f"re-encode confirmed  → {out.name}")


# ------------------------------------------------------------------ controls (P8, P9, P10)

def controls(cap: float, machine: str) -> None:
    out = {"schema": "m33-controls v1", "machine": machine, "checks": []}
    failures = []

    def expect(got, want, what):
        ok = got == want
        print(f"  {'ok  ' if ok else 'FAIL'} {what}: {got!r}" + ("" if ok else f" (want {want!r})"))
        out["checks"].append({"what": what, "got": str(got), "want": str(want), "ok": ok})
        if not ok:
            failures.append(what)

    # P9 — the M20 skeleton: outer 120°-triple (0,1,2), seam-image unit triangle (3,4,5),
    # one spoke each; at k=3 the images exclude their own outer's colour yet must be rainbow
    print("P9 — the M20 kernel↔instrument skeleton (6 vertices, k=3):")
    skel = [(3, 4), (4, 5), (3, 5), (0, 3), (1, 4), (2, 5)]
    r = mono_realizable(6, skel, 3, (0, 1, 2), cap)
    expect(r["outcome"], "unsat", "require-mono outer triple → UNSAT (no_mono_outer_triple)")
    r = mono_realizable(6, skel[:-1], 3, (0, 1, 2), cap)
    expect(r["outcome"], "sat", "one spoke dropped → SAT (the compulsion needs every spoke)")

    # P8 — the 791 forcer's six forced pairs
    print("P8 — the 791 forcer (six forced-equal pairs, k=4):")
    fj = json.load(open(BUILD / "m30-forcer791.json"))
    n79, e79 = fj["n"], [tuple(e) for e in fj["edges"]]
    base = class_avoid(n79, e79, 4, [], cap)
    expect(base["outcome"], "sat", "base guard: the 791 is 4-colourable")
    six = [(6, 306), (44, 272), (78, 269), (137, 171), (148, 249), (182, 217)]
    eset = {tuple(sorted(e)) for e in e79}
    ctrl = next((0, b) for b in range(1, n79)
                if (0, b) not in eset and (0, b) not in six)
    rows = pmap(lambda pr: class_avoid(n79, e79, 4, [pr], cap), six + [ctrl])
    for pr, row in zip(six, rows[:6]):
        expect(avoid_verdict(base["outcome"], row["outcome"], 1), "fired",
               f"forced pair {pr} cannot be avoided ({row['seconds']}s)")
    expect(avoid_verdict(base["outcome"], rows[6]["outcome"], 1), "clean",
           f"matched non-forced pair {ctrl} avoidable ({rows[6]['seconds']}s)")

    # P10 — the certified hexagram chunk stays clean at every probed class
    print("P10 — the certified hexagram chunk (B=2, k=4):")
    obj = load_object("hexchunkB2")
    n_hx = len(obj["pts"])
    ids = list(range(n_hx))
    pos = {i: i for i in ids}
    base = class_avoid(n_hx, obj["edges"], 4, [], cap)
    expect(base["outcome"], "sat", f"base guard: the chunk ({n_hx} pts, "
           f"{len(obj['edges'])} edges) is 4-colourable")
    # Expectations per §0i: the √3 classes stay clean (G1's rot3 protection), and eq-pair-2
    # FIRES — the d = 2 pigeonhole found by the first control run, binary-confirmed; the
    # control now pins that discovered truth so a regression (either way) goes red.
    probe_classes = {"eq-pair-sqrt3": ("clean", "empty"),
                     "mono-triple-sqrt3": ("clean", "empty"),
                     "eq-pair-2": ("fired",)}
    insts = {cn: instances_of(obj, ids, CLASSES[cn]) for cn in probe_classes}

    def hx_row(cn):
        inst = insts[cn]
        if base["outcome"] == "sat" and inst:
            row = class_avoid(n_hx, obj["edges"], 4,
                              [tuple(pos[v] for v in t) for t in inst], cap)
            return avoid_verdict(base["outcome"], row["outcome"], len(inst))
        return avoid_verdict(base["outcome"], None, len(inst))

    names = list(probe_classes)
    for cn, v in zip(names, pmap(hx_row, names)):
        expect(v in probe_classes[cn], True,
               f"{cn}: {len(insts[cn])} instances → {v} (want {'/'.join(probe_classes[cn])})")

    out["ok"] = not failures
    (BUILD / "m33-controls.json").write_text(json.dumps(out, indent=1))
    print("CONTROLS:", "ok" if not failures else f"{len(failures)} FAILURES: {failures}",
          "→ build/m33-controls.json")
    if failures:
        sys.exit(1)


# ------------------------------------------------------------------ driver self-test

def self_test() -> None:
    """The driver's own checkers seen red on cue; the geometry guards trip by name."""
    failures = []

    def expect(got, want, what):
        ok = got == want
        print(f"  {'ok  ' if ok else 'FAIL'} {what}: {got!r}" + ("" if ok else f" (want {want!r})"))
        if not ok:
            failures.append(what)

    def expect_abort(fn, what):
        try:
            fn()
            expect("no-abort", "SystemExit", what)
        except SystemExit as e:
            expect(e.code, INVARIANT_EXIT, what)

    # the cover-monotone checker aborts on a synthetic violation, passes honest intervals
    bad = [{"r2": 1.0, "cover": {"lo": 3, "hi": 3, "verdict": "settled"}},
           {"r2": 2.0, "cover": {"lo": 2, "hi": 2, "verdict": "settled"}}]
    expect_abort(lambda: check_cover_monotone(bad), "synthetic cover regression aborts (F4)")
    good = [{"r2": 1.0, "cover": {"lo": 2, "hi": 3, "verdict": "interval"}},
            {"r2": 1.5, "cover": {"lo": 1, "hi": 4, "verdict": "unknown"}},
            {"r2": 2.0, "cover": {"lo": 3, "hi": 3, "verdict": "settled"}}]
    check_cover_monotone(good)
    expect(True, True, "honest intervals + unknown rows pass the monotone check")

    # the class-monotone checker aborts on fired-below-clean
    badc = [{"r2": 1.0, "verdict": "fired"}, {"r2": 2.0, "verdict": "clean"}]
    expect_abort(lambda: check_class_monotone(badc, "synthetic"),
                 "synthetic class regression aborts (F4)")

    # the A2 containment checker aborts on triple-fired + pair-clean
    expect_abort(lambda: check_containment("clean", "fired", "synthetic"),
                 "synthetic containment violation aborts (A2)")
    check_containment("fired", "fired", "ok")
    check_containment("fired", "clean", "ok")
    expect(True, True, "legal containment combinations pass")

    # geometry guards on a planted mini-object: unit edge + √3 pair + √3 triangle
    s3 = tuple([F(0)] * 16)
    rt3 = tuple([F(0), F(1)] + [F(0)] * 14)          # √3 (basis index 1 = prime 3)
    mini_pts = [((s3, s3)),                          # (0, 0)
                ((tuple([F(1)] + [F(0)] * 15), s3)),  # (1, 0)     — unit edge with 0
                ((rt3, s3)),                          # (√3, 0)    — √3 pair with 0
                ((tuple([F(0), F(1, 2)] + [F(0)] * 14),
                  tuple([F(3, 2)] + [F(0)] * 15)))]   # (√3/2, 3/2) — √3 triangle with 0,2
    mini = {"pts": mini_pts, "xy": xy(mini_pts),
            "edges": unit_edges_of(mini_pts, xy(mini_pts))}
    expect(mini["edges"], [(0, 1)], "mini-object: exactly the planted unit edge found")
    pr = instances_of(mini, [0, 1, 2, 3], CLASSES["eq-pair-sqrt3"])
    expect(sorted(pr), [(0, 2), (0, 3), (2, 3)], "mini-object: the three √3 pairs found")
    tr = instances_of(mini, [0, 1, 2, 3], CLASSES["mono-triple-sqrt3"])
    expect(tr, [(0, 2, 3)], "mini-object: the planted √3 triangle found")
    try:
        instances_of(mini, [0, 1, 2, 3], {"arity": 2, "d2": F(1)})
        expect("no-error", "SystemExit", "d²=1 class spec trips the internal-edge guard")
    except SystemExit as e:
        expect("GUARD" in str(e), True, "d²=1 class spec trips the internal-edge guard")

    # region round-trip: object ids in, object ids out
    obj = {"pts": mini_pts, "xy": xy(mini_pts), "edges": [(0, 1)]}
    reg = region_at(obj, mini_pts[0], 3.5)
    expect(reg["ids"], [1, 2, 3], "region excludes the centre vertex, keeps object ids")
    expect(reg["S_obj"], [1], "the S target is reported in object ids")

    print("SELF-TEST:", "ok" if not failures else f"{len(failures)} FAILURES: {failures}")
    if failures:
        sys.exit(1)


# ------------------------------------------------------------------ status and CLI

def status() -> None:
    print("mechanism.py — the M33 sweep driver (runs nothing by default).")
    arts = sorted(BUILD.glob("m33-*.json"))
    if not arts:
        print("no m33 artifacts yet. Next: --self-test, then --controls, then (on the DESKTOP,")
        print("§0e) --spectrum fabric origin mono-triple-sqrt3   (P6, the first real verdict).")
        return
    for a in arts:
        try:
            d = json.loads(a.read_text())
            print(f"  {a.name}: status={d.get('status', d.get('ok', '?'))} "
                  f"machine={d.get('machine', '?')}")
        except Exception as e:  # noqa: BLE001 — status display must not crash on a partial file
            print(f"  {a.name}: unreadable ({e})")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--controls", action="store_true")
    ap.add_argument("--fabric-info", action="store_true")
    ap.add_argument("--sweep", nargs=2, metavar=("OBJ", "CENTRE"))
    ap.add_argument("--spectrum", nargs=3, metavar=("OBJ", "CENTRE", "CLASS"))
    ap.add_argument("--shrink", nargs=4, metavar=("OBJ", "CENTRE", "CLASS", "R2"))
    ap.add_argument("--shrink-cover", nargs=4, metavar=("OBJ", "CENTRE", "LEVEL", "R2"))
    ap.add_argument("--cap", type=float, default=300.0)
    ap.add_argument("--machine", default="laptop", help="named beside every number (§0e)")
    ap.add_argument("--quantiles", type=int, default=None,
                    help="thin the mark list (the 1581 sweeps use ~28)")
    args = ap.parse_args()
    if args.self_test:
        self_test()
    elif args.controls:
        controls(args.cap, args.machine)
    elif args.fabric_info:
        obj = load_object("fabric")
        spec = spectrum_of(obj, obj["centres"]["origin"])
        one = H.rat(1)
        unit = sum(1 for _, r, _ in spec if r == one)
        print(f"fabric stage (orbit(S, hex12)): {len(obj['pts'])} points, "
              f"{len(obj['edges'])} unit edges, |unit circle about origin| = {unit}, "
              f"max r² ≈ {spec[-1][0]:.4f}")
        for cn in ("eq-pair-sqrt3", "mono-triple-sqrt3", "eq-pair-2"):
            inst = instances_of(obj, list(range(len(obj["pts"]))), CLASSES[cn])
            print(f"  {cn}: {len(inst)} instances")
    elif args.sweep:
        sweep(args.sweep[0], args.sweep[1], args.cap, args.machine, args.quantiles)
    elif args.spectrum:
        class_onset(args.spectrum[0], args.spectrum[1], args.spectrum[2], args.cap, args.machine)
    elif args.shrink:
        shrink(args.shrink[0], args.shrink[1], args.shrink[2], float(args.shrink[3]),
               args.cap, args.machine)
    elif args.shrink_cover:
        shrink_cover(args.shrink_cover[0], args.shrink_cover[1], int(args.shrink_cover[2]),
                     float(args.shrink_cover[3]), args.cap, args.machine)
    else:
        status()


if __name__ == "__main__":
    main()
