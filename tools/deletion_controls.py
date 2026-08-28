#!/usr/bin/env python3
"""Red/green controls for the vertex-deleted object model (M51 amendment 2026-08-28). Each guard is
seen to FAIL before it is believed. Uses a CONTROL label for any file it writes and deletes it."""
import sys, json, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as B
LABEL = "S29-depth2r-it2v2-depth1-it2v2-depth1"
t0 = time.time()
rows = json.load(open(B.BUILD / "m50-batch.json"))["rows"]
vr = [r for r in rows if r["kind"] == "vertex-deletion" and r["label"] == LABEL and r["verdict"] == "confirmed"][-1]
D = vr["deleted"]
# (c) counts: the model's reduced object = the independent vertex_delete computation
obj, removed = B.load_object(LABEL)
base_fp = obj.fingerprint(removed)
obj.delete_vertices(D)
ue = obj.unit_edges(); tp = [e for e in obj.cheats if tuple(e) not in set(removed)]
assert len(ue) == vr["unit_after"] and len(tp) == vr["cheats_after"], (len(ue), len(tp), vr["unit_after"], vr["cheats_after"])
assert obj.fingerprint(removed) != base_fp, "deleting vertices must move the fingerprint"
print(f"[dctl] (c) reduced object: unit {len(ue)} cheats {len(tp)} = the vertex-deletion row; live seed {len(obj.live_seed())}", flush=True)
assert len(obj.live_seed()) == 214 - len(D)
# (a) red: deleting A refused
try:
    obj.delete_vertices([obj.A]); print("[dctl] (a) FAILED TO FIRE"); sys.exit(1)
except AssertionError as e:
    print(f"[dctl] (a) red fired: {e}")
# (b) roundtrip through the object JSON writer/loader with deleted
cl = "CONTROL-vdel"
(B.BUILD / f"m50-object-{cl}.json").write_text(json.dumps(
    {"prov": obj.prov[214:], "removed": [list(e) for e in removed], "deleted": sorted(obj.deleted),
     "fingerprint": obj.fingerprint(removed), "fingerprint_bare": obj.fingerprint(),
     "n": obj.n, "unit": len(ue), "cheats": len(tp)}))
try:
    o2, r2 = B.load_object(cl)
    assert o2.fingerprint(r2) == obj.fingerprint(removed) and sorted(o2.deleted) == sorted(D) and len(o2.unit_edges()) == len(ue)
    print(f"[dctl] (b) roundtrip: fingerprint {o2.fingerprint(r2)} equal, deleted {len(o2.deleted)}, unit {len(o2.unit_edges())}")
    # (b-red) a file whose deleted list omits one vertex must fail the fingerprint check
    d = json.loads((B.BUILD / f"m50-object-{cl}.json").read_text()); d["deleted"] = sorted(D)[:-1]
    (B.BUILD / f"m50-object-{cl}.json").write_text(json.dumps(d))
    try:
        B.load_object(cl); print("[dctl] (b-red) FAILED TO FIRE"); sys.exit(1)
    except AssertionError as e:
        print(f"[dctl] (b-red) fired: {str(e)[:70]}")
    # (b-red2) deleted containing A refused on load
    d["deleted"] = sorted(D) + [obj.A]; (B.BUILD / f"m50-object-{cl}.json").write_text(json.dumps(d))
    try:
        B.load_object(cl); print("[dctl] (b-red2) FAILED TO FIRE"); sys.exit(1)
    except AssertionError as e:
        print(f"[dctl] (b-red2) fired: {str(e)[:70]}")
finally:
    (B.BUILD / f"m50-object-{cl}.json").unlink(missing_ok=True)
# (d) pool on a small deleted object (the seed alone with 5 deletions): no deleted parent/neighbour
s = B.Obj(); dd = [v for v in range(214) if v not in (s.A, s.B)][:5]; s.delete_vertices(dd)
pool = B.pool_depth1(s)
assert all(rec[1] not in s.deleted and rec[2] not in s.deleted for rec in pool.prov)
assert all(v not in s.deleted for N in pool.nbrs for v in N)
full = B.pool_depth1(B.Obj())
print(f"[dctl] (d) seed pool with 5 deletions: {len(pool.pts)} pts (full seed pool {len(full.pts)}), no deleted parent or neighbour")
# (d-red) a planted pool point glued to a deleted vertex is refused by the constructor
bad = list(full.prov)[:1]; bp = list(full.pts)[:1]
rec = ("glue", dd[0], (dd[0] + 1) % 214 if (dd[0] + 1) % 214 not in (s.A, s.B) else 3, 1)
try:
    B.Pool(s, "depth1", {}, [rec], bp); print("[dctl] (d-red) FAILED TO FIRE"); sys.exit(1)
except AssertionError as e:
    print(f"[dctl] (d-red) fired: {str(e)[:60]}")
# (e) the seed-projection block on the reduced object
assert obj.live_seed() == [v for v in range(214) if v not in set(D)] and len(obj.live_seed()) == 186
print(f"[dctl] (e) block_on = live seed = {len(obj.live_seed())}")
# (f) the refused vertex 154 on top of D is SAT (the composition's own verdict, re-asked here)
import coloring, rigidity, forcer
import twodist as T
def forces(o):
    u = o.unit_edges(); c = [e for e in o.cheats if tuple(e) not in set(removed)]
    edges = u + c
    cls = coloring.base_clauses(o.n, edges, B.K) + rigidity.amo_clauses(o.n, B.K)
    cls += T._brk_full(o.n, B.K, T._degree_order(o.n, edges))
    cls += [[-coloring.var(o.A, k, B.K), -coloring.var(o.B, k, B.K)] for k in range(B.K)]
    return forcer._solve(cls, o.n * B.K, 600)[0]
o3, _ = B.load_object(LABEL); o3.delete_vertices(D + [154])
st = forces(o3); assert st == "sat", st
print(f"[dctl] (f) red: D + refused vertex 154 -> {st.upper()} (a separating colouring exists)")
o4, _ = B.load_object(LABEL); o4.delete_vertices(D)
st = forces(o4); assert st == "unsat", st
print(f"[dctl] (f) green: D alone -> {st.upper()} (still forces A = B)")
print(f"[dctl] ALL CONTROLS AS REQUIRED ({time.time()-t0:.0f}s)")
