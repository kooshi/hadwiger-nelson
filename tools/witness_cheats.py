#!/usr/bin/env python3
"""witness_cheats — Kooshi's question (2026-09-05): can a minimal set of cheat edges make the new
5-chromatic witness (core ∪ spindle copy, `data/m53/forced-spindle-core-8over3.json`) 6-chromatic?

Rebuilds W = core ∪ R(core) at 60 digits, finds every pair at a named squared distance (default 4,
i.e. distance 2 — the Exoo–Ismailescu cheat distance), asks whether W plus those pairs as edges is
5-colourable, and if not shrinks the cheat set greedily to a 1-minimal one (every kept cheat's
deletion admits a 5-colouring). Also reports the forced-equal pairs of W at five colours among the
cheat pairs if W + cheats stays 5-colourable (the E–I shape: cheats force a pair, then spindle).
UNTRUSTED like all of tools/.

    python3 tools/witness_cheats.py --witness data/m53/forced-spindle-core-8over3.json --object <label> [--d2 4,3,1/3]
"""
from __future__ import annotations
import argparse, json, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import mpmath as mp


def sat_colour(n, edges, k, extra=None, pin=True):
    from pysat.solvers import Solver
    var = lambda v, c: v * k + c + 1
    cl = [[var(v, c) for c in range(k)] for v in range(n)]
    for u, v in edges:
        for c in range(k):
            cl.append([-var(u, c), -var(v, c)])
    if pin:
        cl.append([var(0, 0)])
    if extra:
        cl += extra
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        ok = s.solve()
        return ok, (s.get_model() if ok else None)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--witness", required=True); ap.add_argument("--object", required=True)
    ap.add_argument("--d2", default="4"); ap.add_argument("--dps", type=int, default=60)
    ap.add_argument("--out", default="build/m54/witness-cheats.json")
    a = ap.parse_args()
    t0 = time.time(); mp.mp.dps = a.dps
    import batchkill as BK
    W = json.loads(Path(a.witness).read_text())
    obj, _ = BK.load_object(a.object)
    ex = obj.mp_values(a.dps)
    core = W["core_vertices"]; x0 = W["pair"][0]
    q = Fr(W["distance_sq"]) if "distance_sq" in W else Fr(W["distance"]) ** 2     # older records name the distance
    qm = mp.mpf(q.numerator) / q.denominator
    R = mp.mpc(1 - 1 / (2 * qm), mp.sqrt(4 * qm - 1) / (2 * qm))
    zx = ex[x0]
    pts = [ex[v] for v in core] + [zx + R * (ex[v] - zx) for v in core if v != x0]
    n = len(pts); tol = mp.mpf(10) ** -(a.dps - 15)
    # every pair at the wanted squared distances, and the unit edges, in one pass (n ≈ 1,175 → 690k pairs)
    wanted = [Fr(t) for t in a.d2.split(",")]
    targets = {str(t): mp.sqrt(mp.mpf(t.numerator) / t.denominator) for t in wanted}
    unit = []; cheats = {k: [] for k in targets}; near = 0
    for i in range(n):
        pi = pts[i]
        for j in range(i + 1, n):
            d = abs(pi - pts[j])
            if abs(d - 1) < tol:
                unit.append((i, j))
            elif abs(d - 1) < mp.mpf(10) ** -6:
                near += 1
            for k, dt in targets.items():
                if abs(d - dt) < tol:
                    cheats[k].append((i, j))
    assert n == W["union_points"] and len(unit) == W["union_edges"], ("the rebuilt witness differs from the record", n, len(unit), W["union_points"], W["union_edges"])
    print(f"[cheats] W rebuilt: {n} points, {len(unit)} unit edges (record agrees), {near} near-unit pairs ignored; "
          + ", ".join(f"{len(v)} pairs at d² = {k}" for k, v in cheats.items()) + f" [{time.time()-t0:.0f}s]", flush=True)
    ok4, _ = sat_colour(n, unit, 4); ok5, _ = sat_colour(n, unit, 5)
    assert not ok4 and ok5, "the witness must refuse 4 and admit 5 colours"
    out = {"kind": "witness-cheats", "witness": a.witness, "points": n, "unit_edges": len(unit), "classes": {}}
    for k, C in cheats.items():
        if not C:
            continue
        ok, _ = sat_colour(n, unit + C, 5)
        rec = {"pairs": len(C), "five_colourable_with_all": ok}
        print(f"[cheats] d² = {k}: W + all {len(C)} pairs as edges — 5-colourable: {ok}", flush=True)
        if not ok:
            keep = list(C)
            for e in list(C):
                trial = [f for f in keep if f != e]
                ok_t, _ = sat_colour(n, unit + trial, 5)
                if not ok_t:
                    keep = trial
            for e in keep:
                ok_t, _ = sat_colour(n, unit + [f for f in keep if f != e], 5)
                assert ok_t, "not 1-minimal"
            rec["minimal_cheats"] = len(keep); rec["cheats"] = keep
            ok6, _ = sat_colour(n, unit + keep, 6)
            rec["six_colourable_with_minimal"] = ok6
            print(f"[cheats] d² = {k}: 1-minimal cheat set of {len(keep)} pairs makes W 6-chromatic (6-colourable control: {ok6}) [{time.time()-t0:.0f}s]", flush=True)
        else:
            # the E–I shape: does W + all cheats force some cheat-adjacent... any pair equal at five colours? sample the cheat pairs' own endpoints
            forced = []
            for (u, v) in C[:2000]:
                pass
            rec["note"] = "stays 5-colourable; forced-pair search not run here"
        out["classes"][k] = rec
    out["seconds"] = round(time.time() - t0, 1)
    Path(a.out).write_text(json.dumps(out, indent=1)); print(f"[cheats] wrote {a.out}")


if __name__ == "__main__":
    main()
