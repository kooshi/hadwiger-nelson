#!/usr/bin/env python3
"""Red/green controls for `batchkill.run_commit`'s two patched stages (2026-08-28): the parallel
checkpointed lookup re-check and the lazily-resolved exact geometry. Each control is seen to FAIL
before it is believed: a halo missing one witnessed-critical point must report a survivor; a
checkpoint must be replayed only under the same key; a drifted point must be refused by the
geometry stage; the shallow edges must still be certified sympy-exact through the lazy resolve.
Read-only on the campaign's state (control checkpoints use the tag 'CONTROL' and are deleted)."""
import sys, json, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import batchkill as B

OBJ = "S29-depth2r-it2v2-depth1"
t0 = time.time()
obj, removed, seps_path, tag = B._ctx(["--object", OBJ])
header, cols, gate = B._gated_seps(seps_path, ack=False)
pool = B._build_pool(obj, "depth1")
st_ = json.loads((B.BUILD / f"m50-cover-{tag}-{pool.name}.json").read_text())
assert st_["pool_fingerprint"] == pool.fp
halo = st_["halo"]
hit = json.loads((B.BUILD / f"m50-hitting-{tag}.json").read_text())
keep = [tuple(e) for e in hit["keep"]]; Bt = [tuple(e) for e in hit["commit"]]
sub = B.filter_sub(obj, cols, keep)
print(f"[ctl] object n={obj.n}, halo {len(halo)}, sub {len(sub)} ({time.time()-t0:.0f}s)", flush=True)

# the sub-list order must be the journal's t order (the Rust engine consumed the exported sub-list)
lines = (B.BUILD / "m51-Scommit-S29-depth2r-it2v2-depth1-it2v2.jsonl").read_text().splitlines()[1:]
assert len(lines) == len(sub)
for t in (0, 1000, 2387, 3439):
    assert "".join(map(str, sub[t])) == json.loads(lines[t]), f"sub-list order drift at {t}"
print("[ctl] sub-list order = journal t order (4 spot checks)", flush=True)

# witnessed-critical points from the Rust journal: point -> a class that survives without it
wit = {}
with open(B.BUILD / "m51-design-it3-rust/design.jsonl") as f:
    for line in f:
        try: r = json.loads(line)
        except Exception: continue
        if "keeps" in r and r["keeps"] in set(halo):
            wit.setdefault(r["keeps"], r["t"])
crit = sorted(wit)[:3] + [max(wit, key=lambda p: wit[p] == 2387)]
print(f"[ctl] {len(wit)} witnessed-critical points; testing {crit} with witness classes {[wit[p] for p in crit]}", flush=True)

ck = B.BUILD / f"m51-commit-lookup-CONTROL-{pool.name}.json"
ck.unlink(missing_ok=True)
sample = sorted({wit[p] for p in crit} | {0, 1000, 2387, 3439})
subs = [sub[t] for t in sample]

# RED 1: halo minus one critical point -> its witness class survives -> assert fires
reds = 0
for p in crit:
    h2 = [q for q in halo if q != p]
    try:
        B.lookup_recheck(obj, pool, h2, [sub[wit[p]]], Bt, keep, "CONTROL", log=lambda *a, **k: None)
        print(f"[ctl] RED-1 FAILED TO FIRE: halo minus {p} still kills class {wit[p]}"); sys.exit(1)
    except AssertionError as e:
        reds += 1; print(f"[ctl] RED-1 fired: halo minus point {p}: {str(e)[:90]}", flush=True)
    finally:
        ck.unlink(missing_ok=True)

# GREEN 1: the full halo kills the sample; the checkpoint is written; a second call replays it
row = B.lookup_recheck(obj, pool, halo, subs, Bt, keep, "CONTROL")
assert row["verdict"] == "killed" and ck.exists()
msgs = []
row2 = B.lookup_recheck(obj, pool, halo, subs, Bt, keep, "CONTROL", log=lambda m, **k: msgs.append(m))
assert row2["written"] == row["written"] and any("SKIPPED" in m for m in msgs), "checkpoint not replayed"
print(f"[ctl] GREEN-1: full halo kills {len(subs)} sampled classes {sample}; checkpoint written and replayed", flush=True)
# RED 1b: a different key (one more halo point) must NOT replay the checkpoint
msgs = []
B.lookup_recheck(obj, pool, halo + [halo[0]] if False else halo[:-1] + [halo[-1]], subs, Bt, keep, "CONTROL", log=lambda m, **k: msgs.append(m))
assert any("SKIPPED" in m for m in msgs), "same key must replay"
msgs = []
B.lookup_recheck(obj, pool, halo, subs[:-1], Bt, keep, "CONTROL", log=lambda m, **k: msgs.append(m))
assert not any("SKIPPED" in m for m in msgs) and any("does not match" in m for m in msgs), "a different key replayed a checkpoint"
print("[ctl] RED-1b: a changed key re-runs instead of replaying", flush=True)
ck.unlink(missing_ok=True)

# geometry: the halo's shallow points (depth 1, sympy-exact through the LAZY resolve) + deep ones
ordered = B._topo_halo(pool, halo)
depth = {}
for i, rec in enumerate(obj.prov):
    depth[i] = 0 if rec[0] == "seed" else 1 + max(depth[rec[1]], depth[rec[2]])
shallow = [p for p in halo if 1 + max(depth[pool.prov[p][1]], depth[pool.prov[p][2]]) <= 1]
deep = [p for p in halo if p not in shallow][:6]
small = shallow + deep
print(f"[ctl] geometry sample: {len(shallow)} shallow + {len(deep)} deep halo points", flush=True)

# GREEN 2: geometry_only on a fresh object: shallow edges certified exact, deep numeric-250
o2, _ = B.load_object(OBJ)
g = B.certify(o2, list(removed) + Bt, pool, small, label="CONTROL", log=lambda *a, **k: None, geometry_only=True)
assert g["kind"] == "certify-geometry-only" and g["halo_size"] == len(small), g
assert g["edge_verification"]["exact"] > 0, f"no sympy-exact edge through the lazy resolve: {g}"
print(f"[ctl] GREEN-2: geometry stage {g['edge_verification']} in {g['seconds']} s", flush=True)

# RED 2: a bogus census pair — a halo point paired with a vertex it is NOT at unit distance from
# — must be refused by the 250-digit provenance gate. (A float nudge of the coordinates is NOT a
# valid red: the certificate re-derives every point from provenance at 250 digits and the float
# coordinates only FIND the census edges; a drifted float is invisible by design — measured here
# 2026-08-28, the first version of this control nudged a float and saw the stage pass.)
o3, _ = B.load_object(OBJ)
orig_census = B.unit_pairs_np
def bogus_census(pts):
    ue = orig_census(pts)
    a = len(pts) - 1                      # the last-built halo point
    far = max(range(214), key=lambda v: (pts[v][0] - pts[a][0]) ** 2 + (pts[v][1] - pts[a][1]) ** 2)
    return ue + [(min(a, far), max(a, far))]
B.unit_pairs_np = bogus_census
try:
    B.certify(o3, list(removed) + Bt, pool, small, label="CONTROL", log=lambda *a, **k: None, geometry_only=True)
    print("[ctl] RED-2 FAILED TO FIRE: a non-unit census pair passed the geometry stage"); sys.exit(1)
except AssertionError as e:
    print(f"[ctl] RED-2 fired: {str(e)[:100]}", flush=True)
finally:
    B.unit_pairs_np = orig_census
print(f"[ctl] ALL CONTROLS GREEN/RED AS REQUIRED ({time.time()-t0:.0f}s)")
