#!/usr/bin/env python3
"""fplane_sdp — the triple-level semidefinite bound on α(UD(F_p, 2)) (Schrijver 2005's shape, transplanted to the Cayley
graph on F_p² with its point stabiliser O(2, p); the advisor's card 1 of `plans/POROS-2026-09-14-fs50-planning.md`).

For an independent S ⊆ V = F_p², n = p², and x^z = 1_{S−z} ∈ {0,1}^V:
  Y  = (1/|S|) Σ_{z∈S} x^z (x^z)ᵀ  ⪰ 0,     Y[u,v] = #{z ∈ S : u+z ∈ S, v+z ∈ S}/|S|   (a triple count)
  M  = (1/|S|) Σ_{z∈V} x^z (x^z)ᵀ,          M[u,v] = |S ∩ (S − (v−u))|/|S| = g(Q(v−u))  (the pair autocorrelation)
so M − Y = (1/|S|) Σ_{z∉S} … ⪰ 0.  Y ≥ 0 entrywise; Y[u,v] = 0 when u, v or u−v is a unit vector; Y[u,u] = Y[0,u] = g(Q(u));
Σ_v Y[u,v] = |S|·g(Q(u)); tr Y = |S|; Y[u,v] ≤ Y[u,u]; Y[gu,gv] = Y[u,v] for g ∈ O(2,p) (average over the stabiliser);
and the S₃ identity Y[u,v] = Y[−u, v−u] (the same triple {z, z+u, z+v} from another base point). Everything is linear in
the orbit variables once |S| = s is FIXED, so the bound is found by bisection on s: the largest s for which the SDP is
feasible. Feasibility at the verified set's own Y_S is the load-bearing control; the pair-only reduction must reproduce
Delsarte's LP. Floats (Clarabel/SCS): the value is a reading; the certificate would be an exact rational dual (Q4)."""
import argparse, json, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane_lp as L
import fplane

def build(p):
    n = p * p
    pts = [(v // p, v % p) for v in range(n)]
    vid = lambda x, y: (x % p) * p + (y % p)
    cls = [L.Q(pt, p) for pt in pts]
    # the stabiliser generators: a rotation of order p+1 and the reflection (x, y) -> (x, -y)
    circ = fplane.circle(p)
    gen = None
    for a, b in circ:
        z = (a, b); k = 1
        while z != (1, 0):
            z = L.mul(z, (a, b), p); k += 1
        if k == p + 1:
            gen = (a, b); break
    assert gen is not None
    a, b = gen
    rot = [vid(a * x - b * y, b * x + a * y) for (x, y) in pts]
    refl = [vid(x, -y) for (x, y) in pts]
    neg = [vid(-x, -y) for (x, y) in pts]
    sub = lambda u, v: vid(pts[u][0] - pts[v][0], pts[u][1] - pts[v][1])
    # union-find over ordered pairs under: rotation, reflection, swap, S3 (u,v) -> (-u, v-u)
    parent = list(range(n * n))
    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]; i = parent[i]
        return i
    def union(i, j):
        i, j = find(i), find(j)
        if i != j: parent[i] = j
    for u in range(n):
        for v in range(n):
            i = u * n + v
            union(i, rot[u] * n + rot[v]); union(i, refl[u] * n + refl[v]); union(i, v * n + u)
            union(i, neg[u] * n + sub(v, u))
    roots = {}
    orb = np.zeros(n * n, dtype=np.int64)
    for i in range(n * n):
        r = find(i)
        if r not in roots: roots[r] = len(roots)
        orb[i] = roots[r]
    K = len(roots)
    # a representative pair per orbit, and which orbits are killed by a unit vector
    rep = [None] * K
    killed = np.zeros(K, dtype=bool)
    for u in range(n):
        for v in range(n):
            k = orb[u * n + v]
            if rep[k] is None: rep[k] = (u, v)
            if cls[u] == 1 or cls[v] == 1 or cls[sub(u, v)] == 1: killed[k] = True
    g_orbit = [orb[0 * n + v] for v in range(n)]      # g(Q(v)) = Y[0, v]
    diag_orbit = [orb[u * n + u] for u in range(n)]
    for u in range(n):
        assert diag_orbit[u] == g_orbit[u], "S3 should tie Y[u,u] to Y[0,u]"
    class_rep = {}
    for v in range(n):
        class_rep.setdefault(cls[v], v)
    return dict(p=p, n=n, pts=pts, cls=cls, sub=sub, orb=orb, K=K, rep=rep, killed=killed, g_orbit=g_orbit, class_rep=class_rep, rot=rot, refl=refl)

def matrices(B):
    """vec(Y) = A @ y and vec(M) = C @ y as ONE sparse linear map each (a chain of K scaled terms canonicalises
    catastrophically in cvxpy: 254 s against 17 s at p = 11 for the same problem)"""
    import scipy.sparse as sp
    n, K, orb = B["n"], B["K"], B["orb"]
    rows = np.arange(n * n)
    A = sp.csr_matrix((np.ones(n * n), (rows, orb)), shape=(n * n, K))
    Morb = np.zeros(n * n, dtype=np.int64)
    for u in range(n):
        for v in range(n):
            Morb[u * n + v] = B["g_orbit"][B["sub"](v, u)]
    C = sp.csr_matrix((np.ones(n * n), (rows, Morb)), shape=(n * n, K))
    return A, C

def _YM(B, A, C, y):
    import cvxpy as cp
    n = B["n"]
    return cp.reshape(A @ y, (n, n), order="C"), cp.reshape(C @ y, (n, n), order="C")

def feasible(B, E, Mlist, s, lp_rows=None, pair_only=False, solver="SCS", plant=None):
    import cvxpy as cp
    n, K = B["n"], B["K"]
    y = cp.Variable(K, nonneg=True)
    Y, M = _YM(B, E, Mlist, y)
    cons = [y[B["g_orbit"][0]] == 1]
    for k in range(K):
        if B["killed"][k]: cons.append(y[k] == 0)
    cons.append(sum(y[B["g_orbit"][u]] for u in range(n)) == s)           # tr Y = |S|
    if pair_only:
        cons.append(M >> 0)
    else:
        cons += [Y >> 0, M - Y >> 0]
        seen = set()
        for k in range(K):
            if B["killed"][k]: continue
            u, v = B["rep"][k]
            if u != v and (k, B["g_orbit"][u]) not in seen:
                cons.append(y[k] <= y[B["g_orbit"][u]]); seen.add((k, B["g_orbit"][u]))
        for c, u in B["class_rep"].items():                                 # row sums: Σ_v Y[u,v] = s·g(Q(u))
            cons.append(cp.sum(Y[u, :]) == s * y[B["g_orbit"][u]])
    if lp_rows:
        for coef, b in lp_rows:                                             # Σ_c coef[c] g(c) ≤ b, g(c) = y[g_orbit[class_rep[c]]]
            cons.append(sum(coef[c] * y[B["g_orbit"][B["class_rep"][c]]] for c in coef) <= b)
    if plant == "wrong-sign":
        cons.append(Y - M >> 0)   # the mis-signed second matrix: must make the true set infeasible
    prob = cp.Problem(cp.Minimize(0), cons)
    try:
        prob.solve(solver=solver, verbose=False)
    except Exception as e:
        return None, str(e)
    return prob.status, None

def linear_bound(B, E, Mlist, lp_rows=None, solver="SCS"):
    """Schrijver's linear form: maximise tr Y = Σ_u Y[u,u] under Y ⪰ 0, M − Y ⪰ 0, the zeros, Y[u,v] ≤ Y[u,u], y ≥ 0,
    g(0) = 1 — no row-sum identities (they need |S| fixed). One solve; its dual is the object an exact certificate rounds."""
    import cvxpy as cp
    n, K = B["n"], B["K"]
    y = cp.Variable(K, nonneg=True)
    Y, M = _YM(B, E, Mlist, y)
    cons = [y[B["g_orbit"][0]] == 1, Y >> 0, M - Y >> 0]
    for k in range(K):
        if B["killed"][k]: cons.append(y[k] == 0)
    seen = set()
    for k in range(K):
        if B["killed"][k]: continue
        u, v = B["rep"][k]
        if u != v and (k, B["g_orbit"][u]) not in seen:
            cons.append(y[k] <= y[B["g_orbit"][u]]); seen.add((k, B["g_orbit"][u]))
    if lp_rows:
        for coef, b in lp_rows:
            cons.append(sum(coef[c] * y[B["g_orbit"][B["class_rep"][c]]] for c in coef) <= b)
    obj = sum(y[B["g_orbit"][u]] for u in range(n))
    prob = cp.Problem(cp.Maximize(obj), cons)
    prob.solve(solver=solver, verbose=False)
    return prob.value, prob.status

def lp_rows_for(p, names):
    """the [KMOR2016] (2) rows over translates, as {class: count} dictionaries with their bound"""
    lib = L.graph_library(p); out = []
    for name in names:
        if name not in lib: continue
        V = lib[name]; alpha = L.alpha_exact(len(V), L.induced_edges(V, p)); seen = set()
        for zx in range(p):
            for zy in range(p):
                cnt = {}
                for x in V:
                    c = L.Q(((x[0] + zx) % p, (x[1] + zy) % p), p); cnt[c] = cnt.get(c, 0) + 1
                key = tuple(sorted(cnt.items()))
                if key in seen: continue
                seen.add(key); out.append((cnt, alpha))
    return out

def bisect(B, E, Mlist, lo, hi, tol=0.05, **kw):
    assert feasible(B, E, Mlist, lo, **kw)[0] in ("optimal", "optimal_inaccurate"), f"lo={lo} infeasible: {feasible(B, E, Mlist, lo, **kw)}"
    st = feasible(B, E, Mlist, hi, **kw)[0]
    if st in ("optimal", "optimal_inaccurate"):
        return hi, "hi feasible"
    while hi - lo > tol:
        mid = (lo + hi) / 2
        st = feasible(B, E, Mlist, mid, **kw)[0]
        if st in ("optimal", "optimal_inaccurate"): lo = mid
        elif st in ("infeasible", "infeasible_inaccurate"): hi = mid
        else: return lo, f"solver status {st} at {mid}"
    return lo, "ok"

def control_true_set(B, E, Mlist, S, solver="SCS"):
    """build Y_S from the verified set and check every constraint of the SDP holds at s = |S| (the load-bearing control)"""
    import cvxpy as cp
    n, K, p = B["n"], B["K"], B["p"]
    Sset = set(S); s = len(S)
    vid = lambda x, y: (x % p) * p + (y % p)
    def addv(u, z): return vid(B["pts"][u][0] + B["pts"][z][0], B["pts"][u][1] + B["pts"][z][1])
    Ys = np.zeros((n, n))
    for z in S:
        inS = [u for u in range(n) if addv(u, z) in Sset]
        for u in inS:
            for v in inS:
                Ys[u, v] += 1.0 / s
    # the S3 and swap identities are identities of the triple count and must hold EXACTLY on the raw Y_S (only the O(2)
    # symmetry is imposed by averaging): check them before averaging — a wrong S3 map is invisible in a float value
    vid = lambda x, y: (x % p) * p + (y % p)
    neg = lambda u: vid(-B["pts"][u][0], -B["pts"][u][1])
    s3_ok = True; swap_ok = True
    for u in range(n):
        for v in range(n):
            if abs(Ys[u, v] - Ys[v, u]) > 1e-12: swap_ok = False
            if abs(Ys[u, v] - Ys[neg(u), B["sub"](v, u)]) > 1e-12: s3_ok = False
    # orbit-average over O(2) (the set itself is not symmetric; averaging preserves every constraint)
    yv = np.zeros(K); cnt = np.zeros(K)
    for u in range(n):
        for v in range(n):
            k = B["orb"][u * n + v]; yv[k] += Ys[u, v]; cnt[k] += 1
    yv = yv / cnt
    Yavg = (E @ yv).reshape(n, n); Mavg = (Mlist @ yv).reshape(n, n)
    checks = dict(
        s3_identity_on_raw_Y=bool(s3_ok), swap_identity_on_raw_Y=bool(swap_ok),
        trace=bool(abs(np.trace(Yavg) - s) < 1e-9),
        g0=bool(abs(yv[B["g_orbit"][0]] - 1) < 1e-9),
        killed_zero=bool(np.all(yv[B["killed"]] == 0)),
        nonneg=bool(np.all(yv >= -1e-12)),
        Y_psd=float(np.linalg.eigvalsh((Yavg + Yavg.T) / 2).min()) > -1e-9,
        M_minus_Y_psd=float(np.linalg.eigvalsh((Mavg - Yavg + (Mavg - Yavg).T) / 2).min()) > -1e-9,
        rowsums=bool(np.allclose(Yavg.sum(axis=1), s * np.array([yv[B["g_orbit"][u]] for u in range(n)]), atol=1e-9)),
        entry_le_diag=bool(np.all(Yavg <= np.diag(Yavg)[:, None] + 1e-12)))
    return checks, yv

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True); ap.add_argument("--solver", default="SCS")
    ap.add_argument("--lp-graphs", default="triangle,rhombus,wheel6,spindle,circle+centre,wheelpair,hex2+centre,hex3+centre,hexpatch19")
    ap.add_argument("--lo", type=float); ap.add_argument("--hi", type=float); ap.add_argument("--tol", type=float, default=0.05)
    ap.add_argument("--true-set", help="a JSON record holding a verified independent set (independent_set or best_set) for the control")
    ap.add_argument("--out")
    ap.add_argument("--linear-only", action="store_true", help="only Schrijver's linear form (one solve), no bisection")
    a = ap.parse_args()
    t0 = time.time(); B = build(a.p); E, Mlist = matrices(B)
    print(f"[sdp] p={a.p}: n={B['n']}, {B['K']} pair orbits under O(2)×swap×S3, {int(B['killed'].sum())} killed by a unit vector; build {time.time()-t0:.1f} s", flush=True)
    rec = dict(kind="fplane-sdp", p=a.p, n=B["n"], orbits=int(B["K"]), killed=int(B["killed"].sum()), solver=a.solver)
    m = L.Model(a.p); dels, _ = m.solve_max(); rec["delsarte"] = dels
    lo = a.lo or 1.0; hi = a.hi or dels + 1
    rows = lp_rows_for(a.p, [g for g in a.lp_graphs.split(",") if g])
    v, st = linear_bound(B, E, Mlist, solver=a.solver); rec["linear_bound"] = v; rec["linear_status"] = st
    print(f"[sdp] linear form (max tr Y, one solve): {v:.4f} ({st})", flush=True)
    v, st = linear_bound(B, E, Mlist, lp_rows=rows, solver=a.solver); rec["linear_plus_lp_bound"] = v
    print(f"[sdp] linear form + {len(rows)} subgraph rows: {v:.4f} ({st})", flush=True)
    if a.linear_only:
        if a.true_set:
            r = json.load(open(a.true_set)); S = r.get("independent_set") or r.get("best_set")
            checks, yv = control_true_set(B, E, Mlist, S, a.solver); rec["true_set_size"] = len(S); rec["true_set_checks"] = checks
            print(f"[sdp] control — the verified {len(S)}-set's own Y satisfies every constraint: {checks}", flush=True)
            st, _ = feasible(B, E, Mlist, len(S), solver=a.solver); rec["feasible_at_true_size"] = st
            st2, _ = feasible(B, E, Mlist, len(S), solver=a.solver, plant="wrong-sign"); rec["planted_wrong_sign_at_true_size"] = st2
            print(f"[sdp] control — the bisection form at s={len(S)}: {st}; with the second matrix mis-signed (plant): {st2}", flush=True)
        rec["claim_scope"] = ("float readings (SCS/Clarabel): the triple-level SDP bound is NOT a bound on alpha until an exact rational dual "
                              "certificate is checked by tools/fplane_cert_check.py; the controls are the reasons to read the value")
        rec["seconds"] = time.time() - t0
        if a.out:
            Path(a.out).write_text(json.dumps(rec, indent=1)); print(f"  wrote {a.out}")
        return
    v, note = bisect(B, E, Mlist, lo, hi, tol=a.tol, pair_only=True, solver=a.solver); rec["pair_only_bound"] = v
    print(f"[sdp] pair-only (must reproduce Delsarte {dels:.3f}): {v:.3f} ({note})", flush=True)
    v, note = bisect(B, E, Mlist, lo, hi, tol=a.tol, solver=a.solver); rec["triple_bound"] = v
    print(f"[sdp] triple level: {v:.3f} ({note})", flush=True)
    v2, note = bisect(B, E, Mlist, lo, hi, tol=a.tol, lp_rows=rows, solver=a.solver); rec["triple_plus_lp_bound"] = v2; rec["lp_rows"] = len(rows)
    print(f"[sdp] triple level + {len(rows)} subgraph rows: {v2:.3f} ({note})", flush=True)
    if a.true_set:
        r = json.load(open(a.true_set)); S = r.get("independent_set") or r.get("best_set")
        checks, yv = control_true_set(B, E, Mlist, S, a.solver); rec["true_set_size"] = len(S); rec["true_set_checks"] = checks
        print(f"[sdp] control — the verified {len(S)}-set's own Y satisfies every constraint: {checks}", flush=True)
        st, _ = feasible(B, E, Mlist, len(S), solver=a.solver); rec["feasible_at_true_size"] = st
        st2, _ = feasible(B, E, Mlist, len(S), solver=a.solver, plant="wrong-sign"); rec["planted_wrong_sign_at_true_size"] = st2
        print(f"[sdp] control — SDP at s={len(S)}: {st}; with the second matrix mis-signed (plant): {st2}", flush=True)
    rec["seconds"] = time.time() - t0
    if a.out:
        Path(a.out).write_text(json.dumps(rec, indent=1)); print(f"  wrote {a.out}")

if __name__ == "__main__":
    main()
