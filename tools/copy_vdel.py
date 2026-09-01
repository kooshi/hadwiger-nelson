"""copy_vdel — the cheat-ENDPOINT census (Kooshi: "shrinking out the cheats or their endpoints") on
X or on X ∪ T(U): delete one live seed vertex (its unit edges and its cheats go with it) and ask
whether 205 = 206 stays forced at five colours. UNSAT = deletable alone. Parallel, checkpointed."""
from __future__ import annotations
import json, sys, time, threading
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from batchkill import BUILD, load_object
import coloring, forcer, rigidity, mechanism
import twodist as T
import copy_probe as CP
K = 5

def main():
    label, tname, cap = sys.argv[1], sys.argv[2], float(sys.argv[3])
    obj, removed = load_object(label)
    ue = obj.unit_edges(); live = set(range(obj.n)) - set(obj.deleted)
    n2, e2, info = (obj.n, ue, dict(cross=0)) if tname == "none" else CP.resolve(tname, obj.pts, live)(ue)
    cheats = [tuple(e) for e in obj.cheats if tuple(e) not in set(map(tuple, removed))]
    ne = [[-coloring.var(obj.A, c, K), -coloring.var(obj.B, c, K)] for c in range(K)]
    seeds = [v for v in sorted(live) if v < 214 and v not in (obj.A, obj.B)]
    cheat_ends = {v for e in cheats for v in e}
    print(f"[vdel] {tname}: n={n2} unit {len(e2)} cross {info['cross']} cheats {len(cheats)} live seed {len(seeds)} (cheat endpoints {len(cheat_ends & set(seeds))})", flush=True)
    ckp = BUILD / f"m51-copyvdel-{tname}.jsonl"; done = {}
    if ckp.exists():
        for line in ckp.read_text().splitlines():
            r = json.loads(line)
            if r["st"] in ("sat", "unsat"): done[r["v"]] = r["st"]
    lock = threading.Lock()
    # deleting a seed vertex deletes its unit edges (original AND every copy's image of it: the copy
    # is a copy of U, so the vertex's images in the copies go too — they are the same vertex's material)
    # images of each live vertex in the copies: recompute the fusion bookkeeping per copy
    import numpy as np, math
    from scipy.spatial import cKDTree
    images = {v: {v} for v in live}
    if tname != "none":
        tfs = dict(CP.transforms(obj.pts, live)); names = tname[6:].split("|") if tname.startswith("multi:") else [tname]
        P = np.array(obj.pts); live_idx = np.array(sorted(live)); all_pts = [tuple(p) for p in P]
        for nm in names:
            Q = tfs[nm](P[live_idx]); tree = cKDTree(np.array(all_pts)); d, j = tree.query(Q, k=1)
            for ci, li in enumerate(live_idx):
                if d[ci] < CP.TOL: images[int(li)].add(int(j[ci]))
                else: images[int(li)].add(len(all_pts)); all_pts.append(tuple(Q[ci]))
        assert len(all_pts) == n2, (len(all_pts), n2)
    def ask(v):
        if v in done: return done[v]
        gone = images[v]
        edges = [e for e in e2 if e[0] not in gone and e[1] not in gone] + [e for e in cheats if v not in e]
        cls = coloring.base_clauses(n2, edges, K) + rigidity.amo_clauses(n2, K)
        cls += T._brk_full(n2, K, T._degree_order(n2, edges)) + ne
        t1 = time.time(); st, _ = forcer._solve(cls, n2 * K, cap)
        with lock, ckp.open("a") as f:
            f.write(json.dumps({"v": v, "st": st, "seconds": round(time.time() - t1, 1), "cheats_at_v": sum(1 for e in cheats if v in e)}) + "\n")
        return st
    t0 = time.time()
    outs = mechanism.pmap(ask, seeds)
    dele = [v for v, st in zip(seeds, outs) if st == "unsat"]; keep = [v for v, st in zip(seeds, outs) if st == "sat"]; unk = [v for v, st in zip(seeds, outs) if st == "unknown"]
    print(f"[vdel] {tname}: deletable alone {len(dele)}, needed {len(keep)}, unknown {len(unk)} of {len(seeds)}; cheats at deletable vertices {sum(1 for e in cheats if e[0] in dele or e[1] in dele)}; {time.time()-t0:.0f}s", flush=True)
    print(f"[vdel]   deletable: {dele}", flush=True)
    json.dump(dict(kind="copy-vdel", object=label, transform=tname, deletable=dele, needed=keep, unknown=unk, cap=cap,
                   note="single-vertex deletion; only the copy's IMAGE of the vertex is deleted with it (the copy is U's copy); float chords"),
              open(BUILD / f"m51-copyvdel-{tname}.json", "w"), indent=1)

if __name__ == "__main__":
    main()
