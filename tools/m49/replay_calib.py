"""Replay the k=4 calibration descent from its rows (deterministic pools), verify each step's
fingerprints against the recorded ones, and test the CURRENT object: (a) with its remaining 2-edges
(expected UNSAT at k=4), (b) its UNIT part alone at k=4 — if UNSAT, a seam-field UDG is 5-chromatic
already (P4b HALT-AND-VERIFY clause)."""
import sys, json, time
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T
pts, ue, tp = T.load_core122()
art = json.load(open("/home/kooshi/source/lean-dir/build/m49-calib122.json"))
rem = [r for r in art["rows"] if r.get("verdict") == "removed" and r.get("label") == "core122-k4"]
best = min((r for r in art["rows"] if r["kind"] == "edge-critical"), key=lambda r: r["mu_upper"])
two = [tuple(e) for e in best["essential"]]
print(f"start: n={len(pts)} unit={len(ue)} two={len(two)}; {len(rem)} removal rows")
for i, r in enumerate(rem, 1):
    e = tuple(r["target"]); assert e in two, (i, e)
    assert T.fingerprint(len(pts), ue + two) == r["stage_fingerprint"], f"stage fp mismatch at step {i}"
    halo, fus = (T.pool_seam if r["pool"] == "seam" else T.pool_up)(pts, [pts[e[0]], pts[e[1]]])
    nb = len(pts)
    ue_all = T.closure_unit_edges(list(pts) + list(halo))
    assert T.fingerprint(nb + len(halo), ue_all) == r["pool_fingerprint"], f"pool fp mismatch at step {i}"
    newpts = [halo[j - nb] for j in r["halo"]["ids"]]
    pts = pts + newpts
    ue = T.closure_unit_edges(pts)
    two = [f for f in two if f != e]
    assert r["object_after"] == {"n": len(pts), "unit": len(ue), "two": len(two)}, (i, r["object_after"], len(pts), len(ue), len(two))
print(f"replayed {len(rem)} steps exactly: n={len(pts)} unit={len(ue)} two={len(two)}")
st, _, dt = T.refute(len(pts), ue + two, 4, cap=600); print(f"object with remaining 2-edges at k=4: {st} ({dt:.1f}s) [expected unsat]")
st1, col, dt1 = T.refute(len(pts), ue, 4, cap=600); print(f"UNIT PART ALONE at k=4: {st1} ({dt1:.1f}s)")
json.dump({"n": len(pts), "unit": ue, "two": two, "steps": len(rem)}, open("/home/kooshi/source/lean-dir/build/m49-calib122-object.json", "w"))
if st1 == "unsat":
    print("!!! the unit part alone refuses four colours: a seam-field unit-distance graph with chi >= 5 — HALT AND VERIFY")
