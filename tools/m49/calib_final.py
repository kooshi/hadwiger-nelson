"""Replay the stalled k=4 calibration (34 steps), save the final object, and probe the three
refusing edges with a DEEPER pool (two seam generations, then seam+up two generations)."""
import sys, json, time
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T, mechanism
mechanism.WORKERS = 24
pts, ue, tp = T.load_core122()
art = json.load(open("/home/kooshi/source/lean-dir/build/m49-calib122.json"))
rem = [r for r in art["rows"] if r.get("verdict") == "removed" and r.get("label") == "core122-k4"]
best = min((r for r in art["rows"] if r["kind"] == "edge-critical"), key=lambda r: r["mu_upper"])
two = [tuple(e) for e in best["essential"]]
halos = []
for i, r in enumerate(rem, 1):
    e = tuple(r["target"]); assert e in two
    assert T.fingerprint(len(pts), ue + two) == r["stage_fingerprint"]
    halo, fus = (T.pool_seam if r["pool"] == "seam" else T.pool_up)(pts, [pts[e[0]], pts[e[1]]])
    nb = len(pts)
    assert T.fingerprint(nb + len(halo), T.closure_unit_edges(list(pts) + list(halo))) == r["pool_fingerprint"]
    newpts = [halo[j - nb] for j in r["halo"]["ids"]]
    pts = pts + newpts; ue = T.closure_unit_edges(pts); two = [f for f in two if f != e]
    halos.append((e, r["pool"], len(newpts)))
print(f"replayed {len(rem)} steps: n={len(pts)} unit={len(ue)} two={two}")
print("halo sizes:", [h[2] for h in halos], "pools:", set(h[1] for h in halos))
st, _, dt = T.refute(len(pts), ue + two, 4, cap=600); print(f"final object with its 3 two-edges at k=4: {st} ({dt:.1f}s)")
st1, _, dt1 = T.refute(len(pts), ue, 4, cap=600); print(f"unit part alone at k=4: {st1} ({dt1:.1f}s)")
json.dump({"n": len(pts), "unit": ue, "two": two, "steps": len(rem), "halos": halos,
           "pts_closure": [[str(x) for x in p] for p in pts] if hasattr(pts[0], '__iter__') else None},
          open("/home/kooshi/source/lean-dir/build/m49-calib122-object.json", "w"))
# deeper pools for the three refusers
for e in two:
    centres = [pts[e[0]], pts[e[1]]]
    h1, _ = T.pool_seam(pts, centres)
    h2, _ = T.pool_seam(list(pts) + list(h1), centres)          # second generation about the same centres
    pool2 = list(h1) + list(h2)
    t = time.time()
    row = T.descend_step(pts, ue, two, e, pool2, 4, 300.0, shrink_halo=False, framing="unsat")
    print(f"edge {e}: two-generation seam pool ({len(pool2)} pts): {row['outcome']} ({time.time()-t:.0f}s)", flush=True)
    hu, _ = T.pool_up(list(pts) + list(h1), centres)
    pool3 = list(h1) + list(hu)
    t = time.time()
    row = T.descend_step(pts, ue, two, e, pool3, 4, 300.0, shrink_halo=False, framing="unsat")
    print(f"edge {e}: seam-then-up pool ({len(pool3)} pts): {row['outcome']} ({time.time()-t:.0f}s)", flush=True)
