"""copy_probe — Q8/Q9 (STANDING-QUESTIONS, 2026-09-01): a transformed whole copy of the object's
UNIT part, and whether the union refuses four colours.

For each transform T (the mirror across the forced pair's line; rotations about 205, 206 and the
origin by the spindle angle of a pair distance d, sin(θ/2) = 1/(2d), both signs) build T(U), fuse
points coincident with U or with each other, detect cross unit chords (float, tol 1e-7 — a probe;
a commit re-derives exactly), and ask k = 4 on U ∪ T(U). UNSAT = a 5-chromatic unit-distance graph
(HALT AND CERTIFY). Also: the complete k = 4 forced-equal / virtual-edge sweep of U alone
(`rigidity.Rigidity`), the prerequisite of regime (a). Predictions registered in the ledger before
this ran: P-Q8a (U forces no pair equal at 4), P-Q8b (d = 5 about an endpoint has the most cross
chords among rotations), P-Q9 (the mirror has the most cross chords of all; still SAT).
"""
from __future__ import annotations
import argparse, json, math, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
from scipy.spatial import cKDTree
from batchkill import BUILD, load_object
import coloring, forcer, rigidity
import twodist as T

TOL = 1e-7
DISTS = [("5", 5.0), ("2", 2.0), ("sqrt3", math.sqrt(3)), ("sqrt7", math.sqrt(7)), ("4", 4.0)]


def spindle_angle(d: float) -> float:
    return 2 * math.asin(1 / (2 * d))


def transforms(pts, live, a=205, b=206, origin=0):
    A, B = np.array(pts[a]), np.array(pts[b])
    out = []
    # mirror across the line AB
    u = (B - A) / np.linalg.norm(B - A)
    def mirror(P):
        rel = P - A
        along = rel @ u
        perp = rel - np.outer(along, u)
        return A + np.outer(along, u) - perp
    out.append(("mirror-205-206", mirror))
    for name, d in DISTS:
        th = spindle_angle(d)
        for cname, c in (("about205", A), ("about206", B), ("aboutv0", np.array(pts[origin]))):
            for sgn in (+1, -1):
                def rot(P, c=c, th=sgn * th):
                    R = np.array([[math.cos(th), -math.sin(th)], [math.sin(th), math.cos(th)]])
                    return c + (P - c) @ R.T
                out.append((f"rot-d{name}-{cname}-{'+' if sgn > 0 else '-'}{math.degrees(th):.4f}", rot))
    return out


def union_graph(pts, live, unit_edges, tf):
    P = np.array(pts)
    live_idx = np.array(sorted(live))
    Q = tf(P[live_idx])
    n = len(pts)
    tree = cKDTree(P[live_idx])
    # fuse copy points coincident with originals
    d, j = tree.query(Q, k=1)
    idx_map = {}
    new_pts = []
    fused_orig = 0
    # fuse copy points with each other (coincidences within the copy are impossible for an isometry
    # unless the original has them — none by construction)
    for ci, li in enumerate(live_idx):
        if d[ci] < TOL:
            idx_map[li] = int(live_idx[j[ci]]); fused_orig += 1
        else:
            idx_map[li] = n + len(new_pts); new_pts.append(Q[ci])
    edges = set(tuple(sorted(e)) for e in unit_edges)
    copy_edges = set()
    for (x, y) in unit_edges:
        if x in idx_map and y in idx_map:
            e = tuple(sorted((idx_map[x], idx_map[y])))
            if e[0] != e[1]:
                copy_edges.add(e)
    # cross chords: original live points vs NEW copy points at unit distance
    cross = set()
    if new_pts:
        NP = np.array(new_pts)
        t2 = cKDTree(NP)
        pairs = tree.query_ball_tree(t2, 1 + TOL)
        for oi, lst in enumerate(pairs):
            for ni in lst:
                if abs(np.linalg.norm(P[live_idx[oi]] - NP[ni]) - 1) < TOL:
                    cross.add((int(live_idx[oi]), n + ni))
    all_edges = edges | copy_edges | cross
    return n + len(new_pts), sorted(all_edges), dict(fused=fused_orig, copy_edges=len(copy_edges),
                                                    cross=len(cross), new_pts=len(new_pts))


def ask_k(n, edges, k, cap):
    cls = coloring.base_clauses(n, edges, k) + rigidity.amo_clauses(n, k)
    cls += T._brk_full(n, k, T._degree_order(n, edges))
    t0 = time.time()
    st, _ = forcer._solve(cls, n * k, cap)
    return st, time.time() - t0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True)
    ap.add_argument("--cap", type=float, default=900)
    ap.add_argument("--rigidity-cap", type=float, default=600)
    ap.add_argument("--skip-rigidity", action="store_true")
    ap.add_argument("--out", type=Path, default=None)
    a = ap.parse_args()
    obj, removed = load_object(a.object)
    ue = obj.unit_edges()
    live = set(range(obj.n)) - set(obj.deleted)
    print(f"[probe] object {a.object}: n={obj.n} live={len(live)} unit={len(ue)} |205-206|="
          f"{math.dist(obj.pts[205], obj.pts[206]):.6f}", flush=True)
    st0, t0 = ask_k(obj.n, ue, 4, a.cap)
    print(f"[probe] U alone k=4: {st0.upper()} ({t0:.1f}s)  [control: must be SAT]", flush=True)
    rows = []
    for name, tf in transforms(obj.pts, live):
        n2, e2, info = union_graph(obj.pts, live, ue, tf)
        st, t = ask_k(n2, e2, 4, a.cap)
        row = dict(transform=name, n=n2, edges=len(e2), **info, k4=st, secs=round(t, 1))
        rows.append(row)
        flag = "  <<< UNSAT: 5-CHROMATIC UNIT GRAPH — HALT AND CERTIFY" if st == "unsat" else ""
        print(f"[probe] {name:34s} n={n2:5d} E={len(e2):6d} fused={info['fused']:4d} "
              f"cross={info['cross']:5d}  k=4 {st.upper():7s} {t:6.1f}s{flag}", flush=True)
    rig = None
    if not a.skip_rigidity:
        print(f"[probe] k=4 rigidity sweep of U alone (cap {a.rigidity_cap}s per query)…", flush=True)
        R = rigidity.Rigidity(obj.n, ue, 4, timeout=a.rigidity_cap)
        t1 = time.time(); R.run(); t1 = time.time() - t1
        def dist(p):
            return round(math.dist(obj.pts[p[0]], obj.pts[p[1]]), 6)
        rig = dict(status=R.status, calls=R.calls, models=len(R.models),
                   eq_confirmed=[(u, v, dist((u, v))) for u, v in R.eq_confirmed],
                   eq_unsettled=len(R.eq_unsettled), ne_confirmed=len(R.ne_confirmed),
                   ne_unsettled=len(R.ne_unsettled), secs=round(t1, 1))
        print(f"[probe] rigidity: status={R.status} calls={R.calls} models={len(R.models)} "
              f"forced-equal={len(R.eq_confirmed)} (unsettled {len(R.eq_unsettled)}) "
              f"virtual-edges={len(R.ne_confirmed)} (unsettled {len(R.ne_unsettled)}) {t1:.0f}s", flush=True)
        for u, v, d in rig["eq_confirmed"][:40]:
            print(f"[probe]   forced-equal ({u},{v}) d={d} 4d^2-1={4*d*d-1:.4f}")
    out = a.out or (BUILD / f"m51-copyprobe-{a.object}.json")
    json.dump(dict(kind="copy-probe", object=a.object, unit_control=st0, rows=rows, rigidity=rig,
                   tol=TOL, note="float chord detection at 1e-7; a probe, not a certificate"),
              open(out, "w"), indent=1)
    print(f"[probe] wrote {out}")


if __name__ == "__main__":
    main()
