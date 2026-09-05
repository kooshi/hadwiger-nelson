#!/usr/bin/env python3
"""forced_spindle — a forced-equal pair at FOUR colours in pure K-fabric, spindled at its own distance
(2026-09-05). If every proper 4-colouring of the unit part U gives x, y the same colour and |x − y| = d,
then U ∪ R(U) — R the rotation about x with cos θ = 1 − 1/(2d²), sin θ = √(4d² − 1)/(2d²), so that
|y − R(y)| = 1 — has no proper 4-colouring: a 5-chromatic unit-distance graph. For d = 8/3 the radicand
is 247/9 and 247 ≡ 7 (mod 8): the spindle breaks the wall, as Theorem B says any 5-forcer must, and the
union lives in ℚ(√3, √11, √247) — a field with neither √5 nor √7.

    python3 tools/forced_spindle.py --object <label> --dial data/m53/rigidity-dial-it4.json [--pair x,y] [--shrink]

Steps: confirm the forcing by one SAT ask (U + "x ≠ y" at 4 colours UNSAT); optionally shrink U to a
1-minimal forcing core by greedy vertex deletion (outside-in), with every remaining vertex's necessity
witnessed; rotate the core about x; find the cross chords at 60 digits (and refuse any near-miss);
refute the union at four colours DIRECTLY (a control independent of the theorem); write the object.
UNTRUSTED like all of tools/.
"""
from __future__ import annotations
import argparse, json, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import mpmath as mp


def colour_clauses(n, edges, k, var):
    cl = []
    for v in range(n):
        cl.append([var(v, c) for c in range(k)])
    for u, v in edges:
        for c in range(k):
            cl.append([-var(u, c), -var(v, c)])
    return cl


def forces(n, edges, x, y, k=4, extra=None):
    """UNSAT of (proper k-colouring ∧ x ≠ y) ⟺ x, y forced equal."""
    from pysat.solvers import Solver
    var = lambda v, c: v * k + c + 1
    cl = colour_clauses(n, edges, k, var)
    for c in range(k):
        cl.append([-var(x, c), -var(y, c)])
    cl.append([var(x, 0)])                       # palette pin
    if extra:
        cl += extra
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        return not s.solve()


def colourable(n, edges, k=4):
    from pysat.solvers import Solver
    var = lambda v, c: v * k + c + 1
    cl = colour_clauses(n, edges, k, var)
    cl.append([var(0, 0)])
    with Solver(name="cadical153", bootstrap_with=cl) as s:
        ok = s.solve()
        return ok, (s.get_model() if ok else None)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--dial", required=True)
    ap.add_argument("--pair", default=None); ap.add_argument("--shrink", action="store_true")
    ap.add_argument("--dps", type=int, default=60); ap.add_argument("--out", default="build/m54/forced-spindle.json")
    a = ap.parse_args()
    t0 = time.time()
    import batchkill as BK
    obj, _ = BK.load_object(a.object)
    live = sorted(i for i in range(obj.n) if i not in obj.deleted); idx = {v: i for i, v in enumerate(live)}
    edges = [(idx[u], idx[v]) for u, v in obj.unit_edges()]
    dial = json.loads(Path(a.dial).read_text())
    pairs = [(u, v, k) for u, v, k in dial["forced_pairs"] if k == "64/9"]
    if a.pair:
        x0, y0 = (int(t) for t in a.pair.split(","))
    else:
        x0, y0, _ = pairs[0]
    x, y = idx[x0], idx[y0]
    n = len(live)
    mp.mp.dps = a.dps
    ex = obj.mp_values(a.dps)
    d = abs(ex[x0] - ex[y0])
    assert abs(d - mp.mpf(8) / 3) < mp.mpf(10) ** -(a.dps - 10), ("the pair is not at distance 8/3", d)
    assert forces(n, edges, x, y), "the pair is NOT forced equal at four colours on the unit part — the dial file disagrees with this object"
    print(f"[spindle] {a.object}: pair {x0},{y0} at 8/3 confirmed forced equal at 4 colours on {n} points / {len(edges)} edges [{time.time()-t0:.0f}s]", flush=True)
    keep = set(range(n))
    if a.shrink:
        mid = (ex[x0] + ex[y0]) / 2
        order = sorted((v for v in range(n) if v not in (x, y)), key=lambda v: -abs(ex[live[v]] - mid))
        for cnt, v in enumerate(order):
            trial = keep - {v}
            sub = [(u, w) for u, w in edges if u in trial and w in trial]
            if forces(n, sub, x, y):
                keep = trial
            if cnt % 200 == 0:
                print(f"[spindle] shrink {cnt}/{len(order)} tried, {len(keep)} kept [{time.time()-t0:.0f}s]", flush=True)
        # necessity witnesses: every kept vertex's deletion admits a separating 4-colouring
        sub = [(u, w) for u, w in edges if u in keep and w in keep]
        assert forces(n, sub, x, y)
        for v in sorted(keep):
            if v in (x, y):
                continue
            sub_v = [(u, w) for u, w in sub if u != v and w != v]
            assert not forces(n, sub_v, x, y), ("not 1-minimal: vertex can be dropped", live[v])
        print(f"[spindle] 1-minimal core: {len(keep)} vertices, {len(sub)} unit edges, every vertex necessary [{time.time()-t0:.0f}s]", flush=True)
    core = sorted(keep); cidx = {v: i for i, v in enumerate(core)}
    cedges = [(cidx[u], cidx[w]) for u, w in edges if u in keep and w in keep]
    # the spindle rotation about x: cos = 119/128, sin = 3√247/128
    c, s_ = mp.mpf(119) / 128, 3 * mp.sqrt(247) / 128
    R = c + 1j * s_ if False else mp.mpc(c, s_)
    zx = ex[x0]
    pts = [ex[live[v]] for v in core]
    rot = [zx + R * (p - zx) for p in pts]
    assert abs(abs(rot[cidx[y]] - pts[cidx[y]]) - 1) < mp.mpf(10) ** -(a.dps - 10), "the spindle chord y–R(y) is not unit"
    # fusions and cross chords at high precision
    m = len(core)
    tol = mp.mpf(10) ** -(a.dps - 15)
    fused = {}
    for i in range(m):
        for j in range(m):
            if abs(rot[j] - pts[i]) < tol:
                fused[j] = i
    assert fused.get(cidx[x]) == cidx[x], "the centre must fuse with itself"
    cross = []; near = 0
    for i in range(m):
        for j in range(m):
            if j in fused:
                continue
            dd = abs(rot[j] - pts[i])
            if abs(dd - 1) < tol:
                cross.append((i, j))
            elif abs(dd - 1) < mp.mpf(10) ** -6:
                near += 1
    assert near == 0, ("near-unit cross chords within 1e-6 but not within tol — refuse", near)
    # union graph: core vertices 0..m-1, copy vertices m + j for unfused j
    copy_id = {}
    nxt = m
    for j in range(m):
        if j in fused:
            copy_id[j] = fused[j]
        else:
            copy_id[j] = nxt; nxt += 1
    uedges = set(cedges)
    for u, w in cedges:
        uedges.add(tuple(sorted((copy_id[u], copy_id[w]))))
    for i, j in cross:
        uedges.add(tuple(sorted((i, copy_id[j]))))
    uedges = sorted(e for e in uedges if e[0] != e[1])
    N = nxt
    ok, _ = colourable(N, uedges, 4)
    ok5, _ = colourable(N, uedges, 5)
    print(f"[spindle] union: {N} points ({m} core + {N - m} copy, {len(fused)} fused), {len(uedges)} unit edges, {len(cross)} cross chords; "
          f"4-colourable: {ok} (must be False); 5-colourable: {ok5} (control, must be True) [{time.time()-t0:.0f}s]", flush=True)
    out = {"kind": "forced-spindle", "object": a.object, "pair": [x0, y0], "distance": "8/3", "rotation": {"cos": "119/128", "sin": "3*sqrt(247)/128"},
           "field": "Q(sqrt3, sqrt11, sqrt247)", "wall": "247 ≡ 7 (mod 8): broken", "core_size": m, "core_vertices": [live[v] for v in core],
           "core_edges": len(cedges), "union_points": N, "union_edges": len(uedges), "cross_chords": len(cross), "fused": len(fused),
           "union_4colourable": ok, "union_5colourable": ok5, "shrunk": a.shrink, "dps": a.dps, "seconds": round(time.time() - t0, 1),
           "claim_scope": "forcing by one SAT refutation (cadical via pysat); chords at dps digits with a 1e-6 near-miss refusal; the union's "
                          "4-refusal asked directly, not inferred from the spindle theorem"}
    Path(a.out).write_text(json.dumps(out, indent=1)); print(f"[spindle] wrote {a.out}")


if __name__ == "__main__":
    main()
