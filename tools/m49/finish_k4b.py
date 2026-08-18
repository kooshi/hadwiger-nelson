"""Finish the k=4 descent, laddered: for each of the three refusers, the two-generation seam-then-up
pool restricted to radius r about the target's midpoint (r = 1.5, 3, 6, then whole); the first
radius that is UNSAT is committed through the certified step (ddmin shrink on the SUB-pool, 2-bit
re-encode, necessity witnesses). Then the unit part alone at k=4."""
import sys, json, time
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T, mechanism, closure as CL
from pathlib import Path
mechanism.WORKERS = 24
path = Path("/home/kooshi/source/lean-dir/build/m49-calib122.json")
pts, ue, tp = T.load_core122()
art = json.loads(path.read_text())
rem = [r for r in art["rows"] if r.get("verdict") == "removed" and r.get("label") in ("core122-k4", "core122-k4-deep")]
best = min((r for r in art["rows"] if r["kind"] == "edge-critical"), key=lambda r: r["mu_upper"])
two = [tuple(e) for e in best["essential"]]
def pool_deep(pts, centres):
    h1, f1 = T.pool_seam(pts, centres)
    hu, f2 = T.pool_up(list(pts) + list(h1), centres)
    return list(h1) + list(hu), f1 + f2
def sub_pool(halo, e, r, pts):
    if r is None: return halo
    a, b = CL.approx(pts[e[0]]), CL.approx(pts[e[1]]); mx, my = (a[0]+b[0])/2, (a[1]+b[1])/2
    return [q for q in halo if (CL.approx(q)[0]-mx)**2 + (CL.approx(q)[1]-my)**2 <= r*r]
for r in rem:
    e = tuple(r["target"]); assert e in two
    assert T.fingerprint(len(pts), ue + two) == r["stage_fingerprint"]
    centres = [pts[e[0]], pts[e[1]]]
    halo = {"seam": lambda: T.pool_seam(pts, centres)[0], "up": lambda: T.pool_up(pts, centres)[0],
            "deep": lambda: sub_pool(pool_deep(pts, centres)[0], e, r.get("radius"), pts)}[r["pool"]]()
    nb = len(pts)
    assert T.fingerprint(nb + len(halo), T.closure_unit_edges(list(pts) + list(halo))) == r["pool_fingerprint"]
    pts = pts + [halo[j - nb] for j in r["halo"]["ids"]]; ue = T.closure_unit_edges(pts); two = [f for f in two if f != e]
print(f"replayed {len(rem)} removals: n={len(pts)} unit={len(ue)} two={two}", flush=True)
fp0 = T.fingerprint(len(pts), ue + two)
steps = len(rem)
for e in list(two):
    centres = [pts[e[0]], pts[e[1]]]
    full, fus = pool_deep(pts, centres)
    for rad in (1.5, 3.0, 6.0, None):
        halo = sub_pool(full, e, rad, pts)
        t = time.time()
        probe = T.descend_step(pts, ue, two, e, halo, 4, 600.0, shrink_halo=False, framing="unsat")
        print(f"[core122-k4-deep] {e} radius {rad} ({len(halo)} pts): {probe['outcome']} ({time.time()-t:.0f}s)", flush=True)
        if probe["outcome"] != "unsat":
            continue
        t = time.time()
        row = T.descend_step(pts, ue, two, e, halo, 4, 600.0, framing="unsat", shrink="ddmin")
        row.update({"label": "core122-k4-deep", "pool": "deep", "radius": rad, "pool_new_points": len(halo), "fusions": fus,
                    "stage0_fingerprint": fp0, "two_edges_before": len(two), "step": steps})
        if row["verdict"] == "removed":
            nb = len(pts); newpts = [halo[i - nb] for i in row["halo"]["ids"]]
            pts = pts + newpts; ue = T.closure_unit_edges(pts); two = [f for f in two if f != e]; steps += 1
            row["mu_upper"] = len(two); row["object_after"] = {"n": len(pts), "unit": len(ue), "two": len(two)}
            print(f"[core122-k4-deep] step {steps}: REMOVED {e} with deep halo (radius {rad}) of {len(newpts)} pts → n={len(pts)}, unit={len(ue)}, mu_upper={len(two)} ({time.time()-t:.0f}s)", flush=True)
            T.record(path, row)
            break
        else:
            print(f"[core122-k4-deep] {e} radius {rad}: {row['verdict']} (outcome {row['outcome']}, reencode {row.get('reencode')}, halo 1-minimal {row.get('halo',{}).get('one_minimal')}) ({time.time()-t:.0f}s)", flush=True)
            T.record(path, row)
print(f"remaining two-edges: {two}", flush=True)
st, _, dt = T.refute(len(pts), ue, 4, cap=1800)
print(f"UNIT PART ALONE at k=4: {st} ({dt:.1f}s)   n={len(pts)} unit={len(ue)}", flush=True)
json.dump({"n": len(pts), "unit": ue, "two": two, "steps": steps}, open("/home/kooshi/source/lean-dir/build/m49-calib122-object.json", "w"))
if not two and st == "unsat":
    print("!!! A UNIT-DISTANCE GRAPH THAT REFUSES FOUR COLOURS, BUILT BY DESCENT — HALT AND VERIFY (re-derive, second encoding, kernel)", flush=True)
