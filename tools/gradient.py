#!/usr/bin/env python3
"""M41 — the k = 5 gradient hunt: overlap census, tiled unions, menus, the autopsy.

UNTRUSTED, like everything in `tools/`. Any verdict that matters is double-encoded or
re-derived; a k = 5 UNSAT on a union is a chi(R^2) >= 6 CANDIDATE and triggers the
halt-and-verify protocol of plans/M41-k5-gradient.md P5 — never a claim on its own.

Phase-2 entry (D3): the exact overlap census. For crystal transforms T of the committed
1581 (translations by hex-lattice vectors, exact zeta6 rotations about the two spindle
pivots, the mirror), compute |V ∩ T(V)| by exact key match — zero floats. A transform
with full overlap is a SYMMETRY (reported as such, useless for tiling); a transform
sharing < 5% is recorded and never SAT-probed (near-disjoint unions teach nothing).
Union edges, when a union is built, are RE-DERIVED on the full vertex set (§0f A4):
a union of edge lists misses every cross chord.

    python3 tools/gradient.py --self-test
    python3 tools/gradient.py --overlap      # the census -> build/m41-gradient.json
"""

from __future__ import annotations

import argparse
import json
import sys
from fractions import Fraction as F
from pathlib import Path

TOOLS = Path(__file__).resolve().parent
BUILD = TOOLS.parent / "build"
sys.path.insert(0, str(TOOLS))

import degrey as D  # noqa: E402
from anatomy import (ZETA6, ORIGIN, CENTRE2, build_addresses, cmul, cconj, key,  # noqa: E402
                     approx)

ART = BUILD / "m41-gradient.json"
SCHEMA = ("m41-gradient v1 (plans/M41-k5-gradient.md §0). Overlap census rows are exact "
          "(field-key identification, zero floats). full-overlap = symmetry of the "
          "committed 1581, not a tiling candidate. machine recorded per row; laptop and "
          "desktop timings are never compared.")


def load_art():
    if ART.exists():
        return json.loads(ART.read_text())
    return {"schema": SCHEMA, "overlap": [], "unions": [], "autopsy": [], "galois": [],
            "equivariance": [], "status": "partial"}


def save_art(art):
    ART.write_text(json.dumps(art, indent=1, default=str))


# ------------------------------------------------------------------ transforms

def translate(p, t):
    return (D.add(p[0], t[0]), D.add(p[1], t[1]))


def rot_about(p, c, r):
    """r a unit rotation as a point pair (cos, sin) in field currency."""
    d = (D.sub(p[0], c[0]), D.sub(p[1], c[1]))
    rd = cmul(d, r)
    return (D.add(rd[0], c[0]), D.add(rd[1], c[1]))


def mirror_x(p):
    return (p[0], D.neg(p[1]))


def hex_translations():
    """The candidate lattice vectors: units zeta6^k, the sqrt3 family (1+zeta6)zeta6^k,
    the distance-2 family 2*zeta6^k (= the spindle-centre separation), and 3*zeta6^k."""
    out = {}
    one = (D.ONE, D.ZERO)
    u = one
    for k in range(6):
        out[f"t1.z{k}"] = u
        u = cmul(u, ZETA6)
    w = (D.add(D.ONE, ZETA6[0]), ZETA6[1])          # 1 + zeta6, |.| = sqrt3
    for k in range(6):
        out[f"ts3.z{k}"] = w
        w = cmul(w, ZETA6)
    two = (D.add(D.ONE, D.ONE), D.ZERO)
    for k in range(6):
        out[f"t2.z{k}"] = two
        two = cmul(two, ZETA6)
    three = (D.rat(3), D.ZERO)
    for k in range(6):
        out[f"t3.z{k}"] = three
        three = cmul(three, ZETA6)
    return out


def census(pts):
    keys = {key(p) for p in pts}
    n = len(pts)
    rows = []

    def probe(name, image_pts):
        shared = sum(1 for q in image_pts if key(q) in keys)
        kind = ("symmetry" if shared == n else
                "candidate" if shared >= n * 0.05 else "near-disjoint")
        rows.append({"transform": name, "shared": shared, "of": n,
                     "frac": round(shared / n, 4), "kind": kind})
        return shared

    for name, t in hex_translations().items():
        probe(name, [translate(p, t) for p in pts])
    # exact zeta6^k rotations about each spindle pivot, k = 1..5
    for cname, c in (("origin", ORIGIN), ("centre2", CENTRE2)):
        r = ZETA6
        for k in range(1, 6):
            probe(f"rot6^{k}@{cname}", [rot_about(p, c, r) for p in pts])
            r = cmul(r, ZETA6)
    probe("mirror-x", [mirror_x(p) for p in pts])
    return rows


# ------------------------------------------------------------------ SAT helpers

from forcer import _solve  # noqa: E402


def _colour_clauses(n, edges, k, break_sym=60):
    """One-hot colour clauses + first-occurrence palette breaking (colour-invariant)."""
    def var(v, c):
        return v * k + c + 1
    cls = []
    for v in range(n):
        cls.append([var(v, c) for c in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                cls.append([-var(v, c1), -var(v, c2)])
    for (a, b) in edges:
        for c in range(k):
            cls.append([-var(a, c), -var(b, c)])
    for t in range(1, min(n, break_sym)):
        for c in range(1, k):
            cls.append([-var(t, c)] + [var(e, c - 1) for e in range(t)])
    return cls


def _sat(n, edges, k, cap=120.0, extra=None, break_sym=60):
    cls = _colour_clauses(n, edges, k, break_sym)
    if extra:
        cls = cls + extra
    return _solve(cls, n * k, cap)


# ================================================================== phase 0: the autopsy

def _load_cores():
    art40 = json.loads((BUILD / "m40-chiomega.json").read_text())
    out = []
    for c in art40["cores"]:
        if c.get("outcome") == "core":
            out.append({"T": c["T"], "k_refused": c["k"],
                        "pts": [tuple(v) for v in c["core"]], "n": c["n_core"]})
    return out


def _core_edges(T, pts):
    import celllat as CL
    es = set(CL.edge_set(F(T), reach=CL.edge_reach(F(T))))
    idx = {p: i for i, p in enumerate(pts)}
    edges = []
    for i, u in enumerate(pts):
        for j in range(i + 1, len(pts)):
            v = pts[j]
            if (v[0] - u[0], v[1] - u[1]) in es or (u[0] - v[0], u[1] - v[1]) in es:
                edges.append((i, j))
    return edges


def _census_models(n, edges, k, cap_models=2000, cap=120.0):
    """Count canonical (first-occurrence palette) proper k-colourings, blocking-clause
    enumeration. Returns (count, capped?)."""
    def var(v, c):
        return v * k + c + 1
    cls = _colour_clauses(n, edges, k, break_sym=n)
    count = 0
    while count < cap_models:
        status, model = _solve(cls, n * k, cap)
        if status == "unsat":
            return count, False
        if status != "sat":
            return count, True
        count += 1
        block = []
        for v in range(n):
            for c in range(k):
                if var(v, c) in model:
                    block.append(-var(v, c))
                    break
        cls.append(block)
    return count, True


def _max_indep_sets(n, edges, cap_sets=300000):
    """Maximal independent sets = maximal cliques of the complement (Bron-Kerbosch)."""
    adj = [set() for _ in range(n)]
    for (a, b) in edges:
        adj[a].add(b)
        adj[b].add(a)
    comp = [set(range(n)) - adj[v] - {v} for v in range(n)]
    out = []

    def bk(r, p, x):
        if len(out) > cap_sets:
            return
        if not p and not x:
            out.append(frozenset(r))
            return
        pivot = max(p | x, key=lambda u: len(comp[u] & p))
        for v in list(p - comp[pivot]):
            bk(r | {v}, p & comp[v], x & comp[v])
            p = p - {v}
            x = x | {v}

    bk(set(), set(range(n)), set())
    return (out, len(out) > cap_sets)


def _chi_f_bracket(n, edges):
    """Exact-verified bracket on the fractional chromatic number: scipy proposes,
    Fractions certify (scaled feasible primal = upper bound; scaled feasible dual =
    lower bound). Returns dict or a skipped-marker."""
    sets, capped = _max_indep_sets(n, edges)
    if capped:
        return {"skipped": f"maximal-IS enumeration exceeded cap ({len(sets)})"}
    try:
        import numpy as np
        from scipy.optimize import linprog
    except ImportError:
        return {"skipped": "scipy unavailable"}
    m = len(sets)
    M = np.zeros((n, m))
    for j, S in enumerate(sets):
        for v in S:
            M[v, j] = 1.0
    res = linprog(c=np.ones(m), A_ub=-M, b_ub=-np.ones(n), method="highs")
    if not res.success:
        return {"skipped": f"LP failed: {res.message}"}
    # exact upper: rationalize x, scale by the exact minimum coverage
    x = [F(float(v)).limit_denominator(10**9) for v in res.x]
    cover = [sum(x[j] for j in range(m) if v in sets[j]) for v in range(n)]
    mincov = min(cover)
    upper = sum(x) / mincov if mincov > 0 else None
    # exact lower: rationalize dual y >= 0 with sum_{v in S} y_v <= 1, scale by max
    y = [max(F(0), F(float(-v)).limit_denominator(10**9))
         for v in res.ineqlin.marginals]
    load = [sum(y[v] for v in S) for S in sets]
    maxload = max(load)
    lower = sum(y) / maxload if maxload > 0 else F(0)
    return {"n_max_indep_sets": m,
            "chi_f_lower": [str(lower), float(lower)],
            "chi_f_upper": [str(upper), float(upper)] if upper else None}


def _point_group():
    """The 12 dihedral maps in address coordinates."""
    import celllat as CL
    maps = []
    for use_refl in (False, True):
        for r in range(6):
            def f(v, r=r, use_refl=use_refl):
                w = (CL.refl(v) if use_refl else v)
                for _ in range(r):
                    w = CL.rot6(w)
                return w
            maps.append((f"{'refl.' if use_refl else ''}rot{60*r}", f))
    return maps


def autopsy(core, cap=120.0):
    """The D1 protocol on one core. Every SAT verdict three-outcome honest."""
    T, pts, kref = core["T"], core["pts"], core["k_refused"]
    n = len(pts)
    chi = kref + 1
    edges = _core_edges(T, pts)
    rep = {"T": T, "n": n, "k_refused": kref, "n_edges": len(edges), "machine": "laptop"}
    # base confirmations: refuses k_refused, colours at chi
    s0, _ = _sat(n, edges, kref, cap)
    s1, _ = _sat(n, edges, chi, cap)
    rep["confirm"] = {"refuses": s0, "colours_at_chi": s1}
    # (a) canonical colouring census at chi
    print("  census...", flush=True)
    cnt, capped = _census_models(n, edges, chi, cap=cap)
    rep["census_at_chi"] = {"count": cnt, "capped": capped}
    print(f"  census: {cnt}{'+ (capped)' if capped else ''}; chi_f...", flush=True)
    # (b) fractional chromatic bracket
    rep["chi_f"] = _chi_f_bracket(n, edges)
    # (c) symmetry/defect anatomy
    keyset = set(pts)
    stab, sym = [], []
    for name, g in _point_group():
        gpts = {g(v) for v in pts}
        if gpts == keyset:
            stab.append(name)
        else:
            inter = sorted(keyset & gpts)
            union = sorted(keyset | gpts)
            iu = {p: i for i, p in enumerate(union)}
            eu = _core_edges(T, union)
            su, _ = _sat(len(union), eu, kref, cap)
            ei = _core_edges(T, inter)
            si, _ = _sat(len(inter), ei, kref, cap)
            sym.append({"g": name, "shared": len(inter),
                        "union_refuses_k": su, "inter_refuses_k": si})
    rep["stabilizer"] = stab
    rep["symmetrization"] = sym
    # (d) the factorization sweep at k = chi - 1 = k_refused
    import celllat as CL
    norms = sorted({CL.Q((pts[i][0] - pts[j][0], pts[i][1] - pts[j][1]))
                    for i in range(n) for j in range(i + 1, n)})
    radii = sorted({CL.Q(p) for p in pts})
    fires = []
    adj = [set() for _ in range(n)]
    for (a, b) in edges:
        adj[a].add(b)
        adj[b].add(a)
    for r in radii:
        Rverts = [i for i, p in enumerate(pts) if CL.Q(p) <= r]
        if len(Rverts) < 4:
            continue
        rmap = {v: t for t, v in enumerate(Rverts)}
        Redges = [(rmap[a], rmap[b]) for (a, b) in edges if a in rmap and b in rmap]
        sR, _ = _sat(len(Rverts), Redges, kref, cap)
        proper_sub = len(Rverts) < n
        if sR != "sat":
            fires.append({"region_r": int(r), "n": len(Rverts),
                          "verdict": f"region itself {sR} at k={kref}"})
            continue
        row = {"region_r": int(r), "n": len(Rverts), "proper_subregion": proper_sub,
               "classes": {}}
        # eq-pair-N classes: avoid = norm-N pairs become edges
        for N in norms:
            pairs = [(rmap[a], rmap[b]) for a in Rverts for b in Rverts if a < b and
                     CL.Q((pts[a][0] - pts[b][0], pts[a][1] - pts[b][1])) == N]
            if not pairs:
                continue
            st, _ = _sat(len(Rverts), Redges + pairs, kref, cap)
            row["classes"][f"eq-pair-{int(N)}"] = ("FIRES" if st == "unsat" else st)
        # fan classes: for v in R, is N(v) forced to cover all k colours in R - v?
        fan_hits = []
        for v in Rverts:
            nbrs = [rmap[w] for w in adj[v] if w in rmap]
            if len(nbrs) < kref:
                continue
            sub = [w for w in Rverts if w != v]
            smap = {w: t for t, w in enumerate(sub)}
            sedges = [(smap[a], smap[b]) for (a, b) in edges
                      if a in smap and b in smap]
            def var(t, c):
                return t * kref + c + 1
            base = _colour_clauses(len(sub), sedges, kref, break_sym=0)
            top = len(sub) * kref
            miss = []
            for c in range(kref):
                top += 1
                for w in adj[v]:
                    if w in smap:
                        base.append([-top, -var(smap[w], c)])
                miss.append(top)
            base.append(miss)
            st, _ = _solve(base, top, cap)
            if st == "unsat":
                fan_hits.append(int(v))
        row["fan_fires_at"] = fan_hits
        fires.append(row)
    rep["factorization"] = fires
    factored = [r for r in fires
                if r.get("proper_subregion") and
                (any(v == "FIRES" for v in r.get("classes", {}).values()) or
                 r.get("fan_fires_at"))]
    rep["verdict"] = ("FACTORED" if factored else
                     "HOLISTIC (relative to eq-pair + fan vocabulary, norm-ball regions)")
    return rep


# ================================================================== phase 4: Galois

def flip(vec, mask):
    """The Galois flip: negate basis components sharing an odd number of primes with
    mask (mask over PRIMES = [3,5,7,11] bit order of degrey.py)."""
    return tuple(-x if bin(i & mask).count("1") % 2 else x for i, x in enumerate(vec))


def flip_point(p, mask):
    return (flip(p[0], mask), flip(p[1], mask))


def galois(pts):
    """The 15 nontrivial conjugates: identity screen, then centroid-spectrum screen."""
    import degrey as Dg
    keys = {key(p) for p in pts}
    n = len(pts)
    cx = tuple(sum(p[0][i] for p in pts) / n for i in range(16))
    cy = tuple(sum(p[1][i] for p in pts) / n for i in range(16))

    def spectrum(qs, c):
        out = {}
        for q in qs:
            dx = tuple(q[0][i] - c[0][i] for i in range(16))
            dy = tuple(q[1][i] - c[1][i] for i in range(16))
            d2 = key((Dg.add(Dg.mul(dx, dx), Dg.mul(dy, dy)), Dg.ZERO))
            out[d2] = out.get(d2, 0) + 1
        return out

    base_spec = spectrum(pts, (cx, cy))
    rows = []
    for mask in range(1, 16):
        prims = [Dg.PRIMES[i] for i in range(4) if (mask >> i) & 1]
        qs = [flip_point(p, mask) for p in pts]
        same_set = all(key(q) in keys for q in qs)
        row = {"flip": prims, "identical_set": same_set}
        if not same_set:
            qcx = flip(cx, mask)
            qcy = flip(cy, mask)
            qspec = spectrum(qs, (qcx, qcy))
            row["centroid_spectrum_match"] = (qspec == base_spec)
        rows.append(row)
    return rows


# ================================================================== phase 2 entry: unions

UNION_LADDER = ["rot60", "rot180", "mirror", "translate1", "hexclosure",
                "rotx3", "rotx4", "rotx5"]


def build_union(name, pts):
    ident = {key(p): p for p in pts}
    imgs = []
    if name.startswith("rotx") and name[4:].isdigit():
        # rotxN = union of N copies: V, rot60(V), ..., rot60^{N-1}(V)
        r = ZETA6
        for _ in range(int(name[4:]) - 1):
            imgs.append([rot_about(p, ORIGIN, r) for p in pts])
            r = cmul(r, ZETA6)
    elif name == "rot60":
        imgs = [[rot_about(p, ORIGIN, ZETA6) for p in pts]]
    elif name == "rot180":
        r = cmul(cmul(ZETA6, ZETA6), ZETA6)
        imgs = [[rot_about(p, ORIGIN, r) for p in pts]]
    elif name == "mirror":
        imgs = [[mirror_x(p) for p in pts]]
    elif name == "translate1":
        one = (D.ONE, D.ZERO)
        imgs = [[translate(p, one) for p in pts]]
    elif name == "hexclosure":
        r = ZETA6
        for _ in range(5):
            imgs.append([rot_about(p, ORIGIN, r) for p in pts])
            r = cmul(r, ZETA6)
    else:
        raise SystemExit(f"unknown union {name}")
    allpts = dict(ident)
    for img in imgs:
        for q in img:
            allpts.setdefault(key(q), q)
    return list(allpts.values())


def union_probe(name, k=5, cap=600.0):
    from mechanism import unit_edges_of, xy as mxy
    pts, _, _ = build_addresses()
    upts = build_union(name, pts)
    edges = unit_edges_of(upts, mxy(upts))
    import time
    t0 = time.time()
    st, model = _sat(len(upts), edges, k, cap)
    row = {"union": name, "n": len(upts), "n_edges": len(edges), "k": k,
           "outcome": st, "seconds": round(time.time() - t0, 1),
           "machine": "laptop", "cap": cap}
    if st == "sat":
        # independent validation of the model against the edge list
        col = {}
        for v in range(len(upts)):
            for c in range(k):
                if v * k + c + 1 in model:
                    col[v] = c
                    break
        bad = [e for e in edges if col[e[0]] == col[e[1]]]
        if bad:
            raise SystemExit(f"MODEL INVALID on {name}: {bad[:3]} — encoder/validator disagree")
        row["validated"] = True
    return row


# ================================================================== P9: the 791 identity

def p9_check():
    """Is V ∩ −V (about the construction origin) exactly the 791-forcer's vertex set?"""
    import construct as C
    pts, table, _ = build_addresses()
    keys = {key(p) for p in pts}
    r180 = cmul(cmul(ZETA6, ZETA6), ZETA6)
    centro = {i for i, p in enumerate(pts) if key(rot_about(p, ORIGIN, r180)) in keys}
    sa = C.orbit(C.degrey_seed(), C.hex12())
    sasb = C.spindle(sa, C.index_of(sa, 0, 0), C.index_of(sa, 2, 0))
    y = C.delete(sasb, [C.index_of(sasb, F(1, 3), 0), C.index_of(sasb, F(-1, 3), 0)])
    forcer = set()
    missing = 0
    for (xv, yv) in y.pts:
        kk = (tuple(F(v, y.denom) for v in xv), tuple(F(v, y.denom) for v in yv))
        if kk in table:
            forcer.add(table[kk])
        else:
            missing += 1
    return {"n_centro": len(centro), "n_forcer": len(forcer),
            "forcer_pts_outside_1581": missing,
            "equal": centro == forcer,
            "centro_minus_forcer": len(centro - forcer),
            "forcer_minus_centro": len(forcer - centro)}


# ------------------------------------------------------------------ self-test

def self_test():
    fails = []

    def expect(name, got, want):
        ok = got == want
        print(f"  [{'ok ' if ok else 'FAIL'}] {name}: {got!r}" +
              ("" if ok else f"  (want {want!r})"))
        if not ok:
            fails.append(name)

    print("m41 gradient self-test:")
    pts, _, _ = build_addresses()
    expect("committed 1581 loads", len(pts), 1581)
    keys = {key(p) for p in pts}
    ident = sum(1 for p in pts if key(p) in keys)
    expect("identity transform overlaps fully (planted green)", ident, 1581)
    far = (D.rat(100), D.ZERO)
    gone = sum(1 for p in pts if key(translate(p, far)) in keys)
    expect("far translation overlaps zero (planted red)", gone, 0)
    # rotation exactness: rot6^6 about origin is the identity
    r = ZETA6
    for _ in range(5):
        r = cmul(r, ZETA6)
    p0 = pts[7]
    expect("zeta6^6 is the exact identity on a sample point",
           key(rot_about(p0, ORIGIN, r)), key(p0))
    print("SELF-TEST:", "ok" if not fails else f"{len(fails)} FAILURES: {fails}")
    return not fails


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--overlap", action="store_true")
    ap.add_argument("--autopsy", action="store_true")
    ap.add_argument("--galois", action="store_true")
    ap.add_argument("--union", type=str, metavar="NAME",
                    help="|".join(UNION_LADDER))
    ap.add_argument("--p9", action="store_true")
    ap.add_argument("--cap", type=float, default=600.0)
    args = ap.parse_args()
    if args.self_test:
        sys.exit(0 if self_test() else 1)
    elif args.autopsy:
        art = load_art()
        for core in _load_cores():
            print(f"autopsy: T={core['T']} n={core['n']} refuses k={core['k_refused']}",
                  flush=True)
            rep = autopsy(core, cap=min(args.cap, 120.0))
            art["autopsy"].append(rep)
            save_art(art)
            print(json.dumps({k: v for k, v in rep.items()
                              if k not in ("factorization", "symmetrization")},
                             indent=1, default=str), flush=True)
            print(" verdict:", rep["verdict"], flush=True)
    elif args.galois:
        pts, _, _ = build_addresses()
        rows = galois(pts)
        art = load_art()
        art["galois"] = {"object": "degrey1581", "rows": rows}
        save_art(art)
        for r in rows:
            print(r, flush=True)
        try:
            from mechanism import load_object
            h = load_object("heule510")
            hrows = galois(h["pts"])
            art["galois_heule510"] = {"object": "heule510", "rows": hrows}
            save_art(art)
            print("heule510 control:", flush=True)
            for r in hrows:
                print(" ", r, flush=True)
        except SystemExit as e:
            print(f"heule510 control unavailable: {e}", flush=True)
    elif args.union:
        row = union_probe(args.union, k=5, cap=args.cap)
        art = load_art()
        art["unions"].append(row)
        save_art(art)
        print(json.dumps(row, indent=1, default=str))
        if row["outcome"] == "unsat":
            print("=" * 78 + "\nk = 5 REFUSAL ON A UNION OF UNIT-DISTANCE GRAPHS.\n"
                  "READ plans/M41-k5-gradient.md P5 BEFORE INTERPRETING: this is a\n"
                  "chi(R^2) >= 6 CANDIDATE. Halt; re-derive independently; second\n"
                  "encoding; report to Kooshi before a word of interpretation.\n" + "=" * 78)
    elif args.p9:
        r = p9_check()
        art = load_art()
        art["p9"] = r
        save_art(art)
        print(json.dumps(r, indent=1))
    elif args.overlap:
        pts, _, _ = build_addresses()
        rows = census(pts)
        art = load_art()
        art["overlap"] = rows
        save_art(art)
        for r in sorted(rows, key=lambda x: -x["shared"]):
            print(f"  {r['transform']:>16}: {r['shared']:>5}/{r['of']}  ({r['frac']:.1%})"
                  f"  {r['kind']}", flush=True)
    else:
        art = load_art()
        print(f"{ART.name}: {len(art.get('overlap', []))} overlap rows; see --help")


if __name__ == "__main__":
    main()
