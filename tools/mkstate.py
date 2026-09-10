"""Build the CNF state a census or a descent consumes, from an arena and a present-set.

**Granularity is the modelling decision, and it is not free either way.** At ORBIT granularity a
selection is invariant under the base's order-24 group, which is Parts's own representation and
keeps the search space at a few hundred bits -- but the objects it can reach are exactly the
orbit-closed ones, and the record's own 510-vertex graph is NOT orbit-closed (it is 510 of its
closure's 757). At VERTEX granularity every subset is reachable and the space is 2^N -- affordable
only once N is small, which is precisely what descending at orbit granularity first buys.

So the two are a sequence, not a choice: orbits until the object is small, vertices after.
"""
from __future__ import annotations
import sys, os, json, pickle, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
from census import fingerprint


def build(arena_pkl, present_hex, granularity="vertex", k=4, pin="centre"):
    D = pickle.load(open(arena_pkl, "rb"))
    pts, Ei, Ec, orb, n = D["pts"], D["Ei"], D["Ec"], D["orb"], D["n"]
    A = T.Arena(pts, Ei, Ec)
    present = int(present_hex, 16) if isinstance(present_hex, str) else present_hex
    live = sorted(v for v in range(A.N) if (present >> v) & 1)
    idx = {v: i for i, v in enumerate(live)}
    edges = [(idx[u], idx[v]) for (u, v) in A.induced(present)]
    nv = len(live)
    centre = idx[A.centre]
    if granularity == "vertex":
        members = [[i] for i in range(nv) if i != centre]
        labels = [["v", live[i]] for i in range(nv) if i != centre]
    else:
        of = {}
        for gi, o in enumerate(orb):
            for i in o: of[i] = gi
        buckets = {}
        for v in live:
            if v == A.centre: continue
            key = ("L", of[v]) if v < n else ("S", of[v - n])
            buckets.setdefault(key, []).append(idx[v])
        keys = sorted(buckets)
        members = [buckets[key] for key in keys]
        labels = [[key[0], key[1]] for key in keys]
    gof = {}
    for gi, mem in enumerate(members):
        for v in mem: gof[v] = gi
    var = lambda v, c: v * k + c + 1
    top = nv * k
    pres = []
    for _ in members: top += 1; pres.append(top)
    cls = []
    for v in range(nv):
        gi = gof.get(v)
        if gi is None:
            cls.append([var(v, c) for c in range(k)])
        else:
            cls.append([-pres[gi]] + [var(v, c) for c in range(k)])
            for c in range(k): cls.append([-var(v, c), pres[gi]])
    for (u, v) in edges:
        for c in range(k): cls.append([-var(u, c), -var(v, c)])
    if pin == "triangle":
        adj = [set() for _ in range(nv)]
        for (u, v) in edges: adj[u].add(v); adj[v].add(u)
        tri = None
        for u in sorted(adj[centre]):
            w = adj[centre] & adj[u]
            if w: tri = (centre, u, min(w)); break
        if tri is None: pin = "centre"
        else:
            for c, v in enumerate(tri): cls.append([var(v, c)])
    if pin == "centre":
        cls.append([var(centre, 0)])
    weights = [len(m) for m in members]
    return dict(hard=cls, pres=pres, weights=weights, labels=labels, members=members,
                live=live, nv=nv, centre=centre, edges=edges, granularity=granularity,
                pin=pin, solver="cadical153",
                fingerprint=fingerprint(nv, edges, members))


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--arena", default="/tmp/arena244.pkl")
    ap.add_argument("--present", default="closure")
    ap.add_argument("--granularity", default="vertex", choices=["vertex", "orbit"])
    ap.add_argument("--pin", default="centre", choices=["centre", "triangle"])
    ap.add_argument("--out", required=True)
    a = ap.parse_args()
    D = pickle.load(open(a.arena, "rb"))
    ph = D[a.present] if a.present in D else a.present
    st = build(a.arena, ph, a.granularity, pin=a.pin)
    pickle.dump(st, open(a.out, "wb"), protocol=5)
    print(json.dumps(dict(out=a.out, granularity=st["granularity"], vertices=st["nv"],
                          groups=len(st["weights"]), weight=sum(st["weights"]),
                          edges=len(st["edges"]), clauses=len(st["hard"]), pin=st["pin"],
                          fingerprint=st["fingerprint"]), indent=1))
