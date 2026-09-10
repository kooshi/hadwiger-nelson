"""States at INTERMEDIATE output symmetry -- the rungs of Parts's ladder we have never entered.

`[Parts2020a]` §§3-5: his search *"alternates reduction with orbit-addition at output symmetry
24 -> 6 -> 3 -> 2 -> 1"*. This project has only ever worked at the two ends. At symmetry 24 the
exact optimum of the 757 closure is **624 vertices** (OptUx over 47 orbit-halves, 168 s); at
symmetry 1 nine random-order descents land 582-609 and the best is 583. The rungs between are a
search space nobody here has entered, and they are where his 509 comes from if the ladder is the
mechanism.

A selection closed under a SUBGROUP still has that subgroup as a graph automorphism, so the census
collapse survives every rung -- it just collapses by the subgroup's index instead of by 24.
"""
from __future__ import annotations
import sys, os, json, pickle, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
from census import fingerprint
from fractions import Fraction as Fr


def zeta6_perm(pts):
    """The rotation's permutation of the base points (order 6; the centre is its only fixed point)."""
    half = Fr(1, 2); s3 = (Fr(0), half, Fr(0), Fr(0))
    idx = {p: i for i, p in enumerate(pts)}
    out = []
    for p in pts:
        x, y = p
        q = (T.ksub(T.kscale(x, half), T.kmul(s3, y)), T.kadd(T.kmul(s3, x), T.kscale(y, half)))
        if q not in idx: return None
        out.append(idx[q])
    return out


def build(arena_pkl, present_hex, sym=6, k=4):
    D = pickle.load(open(arena_pkl, "rb"))
    pts, Ei, Ec, n = D["pts"], D["Ei"], D["Ec"], D["n"]
    A = T.Arena(pts, Ei, Ec)
    present = int(present_hex, 16) if isinstance(present_hex, str) else present_hex
    live = sorted(v for v in range(A.N) if (present >> v) & 1)
    idx = {v: i for i, v in enumerate(live)}
    edges = [(idx[u], idx[v]) for (u, v) in A.induced(present)]
    nv = len(live); centre = idx[A.centre]
    p6 = zeta6_perm(pts)
    if p6 is None: raise SystemExit("the base is not closed under the rotation")
    step = {6: 1, 3: 2, 2: 3, 1: 6}[sym]                 # zeta6^step generates the wanted subgroup
    def img(v):                                          # one application of zeta6^step
        b = v if v < n else v - n
        for _ in range(step): b = p6[b]
        return b if v < n else n + b
    # orbits of the live vertices under that subgroup
    seen, members, labels = set(), [], []
    for v in live:
        if v in seen or v == A.centre: continue
        orb, w = [], v
        while w not in seen:
            seen.add(w); orb.append(idx[w]); w = img(w)
        members.append(sorted(orb)); labels.append(["sym%d" % sym, v])
    gof = {}
    for gi, mem in enumerate(members):
        for v in mem: gof[v] = gi
    covered = sum(len(m) for m in members) + 1
    if covered != nv:
        raise SystemExit(f"orbit cover is {covered} of {nv}: the selection is not closed under "
                         f"the order-{sym} subgroup")
    var = lambda v, c: v * k + c + 1
    top = nv * k; pres = []
    for _ in members: top += 1; pres.append(top)
    cls = []
    for v in range(nv):
        gi = gof.get(v)
        if gi is None: cls.append([var(v, c) for c in range(k)])
        else:
            cls.append([-pres[gi]] + [var(v, c) for c in range(k)])
            for c in range(k): cls.append([-var(v, c), pres[gi]])
    for (u, v) in edges:
        for c in range(k): cls.append([-var(u, c), -var(v, c)])
    cls.append([var(centre, 0)])
    return dict(hard=cls, pres=pres, weights=[len(m) for m in members], labels=labels,
                members=members, live=live, nv=nv, centre=centre, edges=edges,
                granularity=f"symmetry-{sym}", pin="centre", solver="cadical153",
                fingerprint=fingerprint(nv, edges, members))


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--arena", default="/tmp/arena244.pkl")
    ap.add_argument("--present", default="closure")
    ap.add_argument("--sym", type=int, default=6, choices=[6, 3, 2, 1])
    ap.add_argument("--out", required=True)
    a = ap.parse_args()
    D = pickle.load(open(a.arena, "rb"))
    st = build(a.arena, D[a.present] if a.present in D else a.present, a.sym)
    pickle.dump(st, open(a.out, "wb"), protocol=5)
    print(json.dumps(dict(out=a.out, granularity=st["granularity"], vertices=st["nv"],
                          groups=len(st["weights"]), weight=sum(st["weights"]),
                          sizes=sorted({len(m) for m in st["members"]}),
                          fingerprint=st["fingerprint"])))
