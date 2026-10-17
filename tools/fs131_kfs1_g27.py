#!/usr/bin/env python3
"""fs131_kfs1_g27 -- generate the Lean data of `[MatolcsiEtAl2025]`'s G27 certificate for the kernel (FS-131, FS131-ISF1).

Reads `data/fs56/g27/cert-g27-mrvz.json` (MRVZ's witness as imported by `tools/fs56_mrvz_import.py` and checked outside
the kernel by `tools/fs56_gf_check.py`): 27 points of Q(sqrt3, sqrt11)^2 over denominator 12 and rational weights y_Y on
28,496 point sets with (i) congruence classes of sets of two or more points summing to 0, (ii) singletons summing to w = 4,
(iii) every independent set S with sum_{Y inside S} y_Y <= 1.  Nothing here is trusted: every fact the proof uses is
re-checked by the kernel (`Proofs/HadwigerNelson/Plane/G27/Check.lean`), and a generator bug can only produce data the
kernel refuses.

WHAT IT WRITES (the modules `Proofs/HadwigerNelson/Plane/G27/*.lean` and `data/fs131/isf1/gen/manifest.json`):
  * the points relabelled in the DFS's order (degree descending, ties by MRVZ's index) and translated so that point 0 is
    the origin, each as 12*x in X23Check's packing; the adjacency masks; a path of edges from point 0 to every point;
  * D = the common denominator of the weights; the singletons' coefficients y_i*D (they sum to 4D);
  * congruence rows: for each congruence class of weighted sets of two or more points (grouped by an exact isometry test),
    a representative R and, for each other member Y, an isometry z -> (U/m)(b ? conj z : z) + V/(12m) carrying R's points
    onto Y's, entry by entry, with the coefficient c = y_Y*D; the row's terms are -c on R and +c on Y, so the terms of a
    class sum to y_R*D on R exactly when the class sums to 0 -- which is checked here (the kernel needs only the rows);
  * the root: all terms sorted by key, equal keys merged (the kernel's `sortR` must reproduce it);
  * the residual DFS's frontier at depth KF (the kernel's `collectR` must reproduce it) and its chunks.

USAGE
  python3 tools/fs131_kfs1_g27.py --write [--kf N] [--chunk-work W]   write the modules and the manifest
  python3 tools/fs131_kfs1_g27.py --check                            regenerate in memory; exit 0 iff every module and
                                                                       the manifest on disk are byte-identical
  python3 tools/fs131_kfs1_g27.py --check --plant                    the same, with one digit of one generated module
                                                                       changed in memory first: must exit 1 naming it
"""

from __future__ import annotations

import hashlib
import json
import math
import sys
from fractions import Fraction as Fr
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CERT = ROOT / "data/fs56/g27/cert-g27-mrvz.json"
MODDIR = ROOT / "Proofs/HadwigerNelson/Plane/G27"
MANIFEST = ROOT / "data/fs131/isf1/gen/manifest.json"
MODPFX = "Proofs.HadwigerNelson.Plane.G27"

B72 = 1 << 72
OFF70 = 1 << 70
M27 = 1 << 27
OFFC = 1 << 1000
FUEL = 1073741824
N = 27


class Refusal(Exception):
    pass


# ---------------------------------------------------------------------------------------------------- the field K
def kmul(a, b):
    a0, a1, a2, a3 = a
    b0, b1, b2, b3 = b
    return (a0 * b0 + 3 * a1 * b1 + 11 * a2 * b2 + 33 * a3 * b3,
            a0 * b1 + a1 * b0 + 11 * (a2 * b3 + a3 * b2),
            a0 * b2 + a2 * b0 + 3 * (a1 * b3 + a3 * b1),
            a0 * b3 + a3 * b0 + a1 * b2 + a2 * b1)


def kadd(a, b):
    return tuple(x + y for x, y in zip(a, b))


def ksub(a, b):
    return tuple(x - y for x, y in zip(a, b))


def kneg(a):
    return tuple(-x for x in a)


def kinv(a):
    """inverse in K = Q(sqrt3, sqrt11) by the three conjugates (the norm is rational)."""
    a0, a1, a2, a3 = a
    c1 = (a0, -a1, a2, -a3)   # sqrt3 -> -sqrt3
    c2 = (a0, a1, -a2, -a3)   # sqrt11 -> -sqrt11
    c3 = (a0, -a1, -a2, a3)   # both
    p = kmul(kmul(c1, c2), c3)
    nrm = kmul(a, p)
    if nrm[1:] != (0, 0, 0) or nrm[0] == 0:
        raise Refusal(f"norm of {a} is not a nonzero rational: {nrm}")
    return tuple(Fr(x) / nrm[0] for x in p)


# complex numbers over K: (re, im)
def cmul(x, y):
    return (ksub(kmul(x[0], y[0]), kmul(x[1], y[1])), kadd(kmul(x[0], y[1]), kmul(x[1], y[0])))


def cadd(x, y):
    return (kadd(x[0], y[0]), kadd(x[1], y[1]))


def csub(x, y):
    return (ksub(x[0], y[0]), ksub(x[1], y[1]))


def cconj(x):
    return (x[0], kneg(x[1]))


def cnormsq(x):
    return kadd(kmul(x[0], x[0]), kmul(x[1], x[1]))


def cdiv(x, y):
    n = kinv(cnormsq(y))
    z = cmul(x, cconj(y))
    return (kmul(z[0], n), kmul(z[1], n))


def cscale(m, x):
    return (tuple(m * v for v in x[0]), tuple(m * v for v in x[1]))


# ---------------------------------------------------------------------------------------------------- packing
def sdigit(v):
    if not -OFF70 < v < OFF70:
        raise Refusal(f"signed digit {v} out of range")
    return v + OFF70


def pack_digits(ds):
    r = 0
    for k, d in enumerate(ds):
        if not 0 <= d < B72:
            raise Refusal(f"digit {d} out of range")
        r += d << (72 * k)
    return r


def c4_digits(z):
    return [sdigit(v) for v in z[0]] + [sdigit(v) for v in z[1]]


def pack_point(z):
    return pack_digits(c4_digits(z))


def row_tag(k):
    """digit 0 of row k: unread by `rowOk` (X23Check's weight slot), so it carries a 64-bit odd tag -- the kernel's caches
    hash a `Nat` literal by its low 64 bits, and rows that agree there collide (LEAN.md, FS131-KC13)."""
    return int.from_bytes(hashlib.sha256(f"FS131-ISF1 G27 row {k}".encode()).digest()[:8], "big") | 1


def pack_row(k, b, m, U, V, I, J):
    """X23Check's row: digit 0 = the tag (unread), 1 = b, 2 = m, 3-10 U, 11-18 V, 19 = n, then I, then J."""
    assert len(I) == len(J)
    return pack_digits([row_tag(k), 1 if b else 0, m] + c4_digits(U) + c4_digits(V) + [len(I)] + list(I) + list(J))


def mask(ix):
    r = 0
    for i in ix:
        r |= 1 << i
    return r


def term(k, c):
    if not 0 <= k < M27:
        raise Refusal(f"key {k} out of range")
    if not -OFFC <= c <= OFFC:
        raise Refusal("coefficient out of range")
    return k + M27 * (c + OFFC)


def tkey(t):
    return t % M27


def tcf(t):
    return t // M27 - OFFC


# ---------------------------------------------------------------------------------------------------- the kernel's twins
def merge_r(l1, l2, fuel=FUEL):
    out = []
    i = j = 0
    while fuel > 0 and i < len(l1) and j < len(l2):
        a, b = l1[i], l2[j]
        if tkey(a) < tkey(b):
            out.append(a); i += 1
        elif tkey(b) < tkey(a):
            out.append(b); j += 1
        elif OFFC <= a // M27 + b // M27:
            out.append(tkey(a) + M27 * (a // M27 + b // M27 - OFFC)); i += 1; j += 1
        else:
            out.append(a); out.append(b); i += 1; j += 1
        fuel -= 1
    if fuel == 0:
        raise Refusal("merge ran out of fuel")
    out.extend(l1[i:]); out.extend(l2[j:])
    return out


def sort_r(L):
    ls = [[t] for t in L]
    r = 20
    while r > 0 and len(ls) >= 2:
        nl = []
        k = 0
        while k + 1 < len(ls):
            nl.append(merge_r(ls[k], ls[k + 1])); k += 2
        if k < len(ls):
            nl.append(ls[k])
        ls = nl
        r -= 1
    if len(ls) >= 2:
        raise Refusal("sortR ran out of rounds")
    return ls[0] if ls else []


def step_out(bit, L):
    return [t for t in L if t & bit == 0]


def step_in(bit, a, L):
    sh = [t ^ bit for t in L if t & bit != 0 and t & a == 0]
    kp = [t for t in L if t & bit == 0 and t & a == 0]
    return merge_r(sh, kp)


def val(U, L):
    return sum(tcf(t) for t in L if tkey(t) & U == tkey(t))


def collect(adj, k, S, L, depth_end, out):
    """the kernel's collectR over adj[k:depth_end] (iterative, the same order)."""
    stack = [(k, S, L)]
    while stack:
        k, S, L = stack.pop()
        if k == depth_end:
            out.append((S, L))
            continue
        bit = 1 << k
        a = adj[k]
        # collectR lists the OUT subtree first, then the IN subtree: push IN first so OUT pops first
        if a & S == 0:
            stack.append((k + 1, S | bit, step_in(bit, a, L)))
        stack.append((k + 1, S, step_out(bit, L)))
    return out


def dfs_cost(adj, k, S, L, D):
    """run the DFS below a state: (work = sum of residual lengths over its nodes, leaves, worst leaf value, all ok)."""
    work = leaves = 0
    worst = None
    ok = True
    stack = [(k, S, L)]
    while stack:
        k, S, L = stack.pop()
        work += len(L)
        if k == N:
            leaves += 1
            v = val(0, L)
            worst = v if worst is None else max(worst, v)
            ok = ok and v <= D
            continue
        bit = 1 << k
        a = adj[k]
        if a & S == 0:
            stack.append((k + 1, S | bit, step_in(bit, a, L)))
        stack.append((k + 1, S, step_out(bit, L)))
    return work, leaves, worst, ok


# ---------------------------------------------------------------------------------------------------- the certificate
def load():
    raw = CERT.read_bytes()
    d = json.loads(raw)
    if d.get("field", {}).get("radicands") != [3, 11] or d.get("denominator") != 12 or d.get("w") != "4":
        raise Refusal("not the G27 certificate this generator reads")
    pts = [tuple(tuple(c) for c in p) for p in d["points"]]
    if len(pts) != N:
        raise Refusal("not 27 points")
    weights = [(tuple(sorted(w["set"])), Fr(w["y"])) for w in d["weights"]]
    return d, hashlib.sha256(raw).hexdigest(), pts, weights


def find_isometry(rep_pts, tgt_pts):
    """an isometry of K(i) carrying rep_pts (an ordered list) onto the set tgt_pts; (b, u, v, images) or None."""
    y1, y2 = rep_pts[0], rep_pts[1]
    dd = csub(y2, y1)
    q = cnormsq(dd)
    tset = {p: k for k, p in enumerate(tgt_pts)}
    for a in tgt_pts:
        for b in tgt_pts:
            if a == b or cnormsq(csub(b, a)) != q:
                continue
            for refl in (False, True):
                u = cdiv(csub(b, a), cconj(dd) if refl else dd)
                y1c = cconj(y1) if refl else y1
                v = csub(a, cmul(u, y1c))
                imgs = []
                for z in rep_pts:
                    w = cadd(cmul(u, cconj(z) if refl else z), v)
                    w = (tuple(Fr(x) for x in w[0]), tuple(Fr(x) for x in w[1]))
                    key = (tuple(int(x) if x.denominator == 1 else None for x in w[0]),
                           tuple(int(x) if x.denominator == 1 else None for x in w[1]))
                    if key not in tset:
                        break
                    imgs.append(tset[key])
                else:
                    if len(set(imgs)) == len(tgt_pts):
                        return refl, u, v, imgs
    return None


def build(kf, chunk_work):
    d, sha, P, weights = load()
    # the graph on MRVZ's labels
    def sqd(p, q):
        dx, dy = ksub(p[0], q[0]), ksub(p[1], q[1])
        return kadd(kmul(dx, dx), kmul(dy, dy))
    adj0 = [set() for _ in range(N)]
    for i in range(N):
        for j in range(N):
            if i != j and sqd(P[i], P[j]) == (144, 0, 0, 0):
                adj0[i].add(j)
    nedges = sum(len(a) for a in adj0) // 2
    order = sorted(range(N), key=lambda v: (-len(adj0[v]), v))
    pos = {v: k for k, v in enumerate(order)}
    origin = P[order[0]]
    Q = [csub(P[order[k]], origin) for k in range(N)]   # 12 * x_k, integer coordinates
    adj = [sum(1 << pos[u] for u in adj0[order[k]]) for k in range(N)]
    # paths from point 0 (BFS)
    parent = {0: None}
    queue = [0]
    for v in queue:
        for u in range(N):
            if adj[v] >> u & 1 and u not in parent:
                parent[u] = v
                queue.append(u)
    if len(parent) != N:
        raise Refusal("the graph is not connected")
    paths = []
    for i in range(N):
        p = []
        v = i
        while v != 0:
            p.append(v)
            v = parent[v]
        paths.append(p[::-1])
    # weights on the new labels, over one denominator
    D = 1
    for _, y in weights:
        D = D * y.denominator // math.gcd(D, y.denominator)
    wsets = {}
    for s, y in weights:
        ns = tuple(sorted(pos[v] for v in s))
        if ns in wsets:
            raise Refusal(f"set {s} listed twice")
        n = y * D
        assert n.denominator == 1
        wsets[ns] = int(n)
    sing = []
    for k in range(N):
        if (k,) not in wsets:
            raise Refusal(f"no weight on the singleton {k}")
        sing.append(wsets[(k,)])
    if sum(sing) != 4 * D:
        raise Refusal("the singletons do not sum to 4")
    # congruence classes of the sets of two or more points
    def inv(ns):
        return tuple(sorted(sqd(Q[a], Q[b]) for a in ns for b in ns if a < b))
    buckets = {}
    classes = []   # (rep, [(member, refl, u, v, images)])
    for ns in sorted(wsets, key=lambda s: (len(s), s)):
        if len(ns) < 2:
            continue
        key = (len(ns), inv(ns))
        placed = False
        for ci in buckets.get(key, []):
            rep = classes[ci][0]
            iso = find_isometry([Q[i] for i in rep], [Q[i] for i in ns])
            if iso is not None:
                refl, u, v, imgs = iso
                classes[ci][1].append((ns, refl, u, v, [ns[k] for k in imgs]))
                placed = True
                break
        if not placed:
            buckets.setdefault(key, []).append(len(classes))
            classes.append((ns, []))
    rows, coefs = [], []
    for rep, mems in classes:
        tot = wsets[rep] + sum(wsets[m[0]] for m in mems)
        if tot != 0:
            raise Refusal(f"the class of {rep} sums to {Fr(tot, D)}, not 0")
        for ns, refl, u, v, J in mems:
            den = 1
            for part in u:
                for x in part:
                    den = den * Fr(x).denominator // math.gcd(den, Fr(x).denominator)
            m = den
            U = (tuple(int(Fr(x) * m) for x in u[0]), tuple(int(Fr(x) * m) for x in u[1]))
            if cnormsq(U) != (m * m, 0, 0, 0):
                raise Refusal("|U|^2 != m^2")
            # V = m Q_j - U (b ? conj Q_i : Q_i), from the first correspondence; checked on all
            qi = cconj(Q[rep[0]]) if refl else Q[rep[0]]
            V = csub(cscale(m, Q[J[0]]), cmul(U, qi))
            for i, j in zip(rep, J):
                qi = cconj(Q[i]) if refl else Q[i]
                if cadd(cmul(U, qi), V) != cscale(m, Q[j]):
                    raise Refusal("row correspondence fails")
            rows.append(pack_row(len(rows), refl, m, U, V, rep, J))
            coefs.append(wsets[ns] + OFFC)
    # the terms, the root, the frontier
    expanded = [term(1 << k, sing[k]) for k in range(N)]
    for r, cpk in zip(rows, coefs):
        # decode back what the kernel decodes: I, J from the row
        n = (r >> (72 * 19)) % B72
        I = [(r >> (72 * (20 + k))) % B72 for k in range(n)]
        J = [(r >> (72 * (20 + n + k))) % B72 for k in range(n)]
        expanded.append(mask(I) + M27 * (2 * OFFC - cpk))
        expanded.append(mask(J) + M27 * cpk)
    root = sort_r(expanded)
    agg = sorted((mask(s), c) for s, c in wsets.items() if c != 0)
    if [(tkey(t), tcf(t)) for t in root if tcf(t) != 0] != agg:
        raise Refusal("the root is not the certificate's weights")
    frontier = collect(adj, 0, 0, root, kf, [])
    # chunks: consecutive frontier states, cut at a target work
    chunks, cur, curw = [], [], 0
    works = []
    allok = True
    totwork = 0
    for S, L in frontier:
        w, lv, worst, ok = dfs_cost(adj, kf, S, L, D)
        allok = allok and ok
        totwork += w
        works.append(w)
        if cur and curw + w > chunk_work:
            chunks.append(cur); cur, curw = [], 0
        cur.append((S, L)); curw += w
    if cur:
        chunks.append(cur)
    if not allok:
        raise Refusal("the DFS refuses a leaf: some independent set weighs more than 1")
    stats = dict(points=N, edges=nedges, order=order, D_bits=D.bit_length(), sets=len(wsets),
                 classes=len(classes), rows=len(rows), expanded=len(expanded), root=len(root), kf=kf,
                 frontier=len(frontier), frontier_entries=sum(len(L) for _, L in frontier), chunks=len(chunks),
                 chunk_work=[sum(works[i] for i in range(sum(len(c) for c in chunks[:k]),
                                                       sum(len(c) for c in chunks[:k + 1])))
                             for k in range(len(chunks))],
                 subtree_work=totwork, cert_sha256=sha)
    return dict(Q=Q, adj=adj, paths=paths, D=D, sing=sing, rows=rows, coefs=coefs, root=root, frontier=frontier,
                chunks=chunks, stats=stats, order=order, provenance=d.get("provenance"))


# ---------------------------------------------------------------------------------------------------- the modules
HEADER = "-- generated by tools/fs131_kfs1_g27.py; do not edit (regenerate, and check with --check)\n"


def lean_list(xs, indent="  "):
    return "[" + (",\n" + indent).join(str(x) for x in xs) + "]"


def lean_lists(xss, indent="  "):
    return "[" + (",\n" + indent).join(lean_list(xs, indent + " ") for xs in xss) + "]"


def modules(g, rows_per_mod, chunks_per_mod, root_per_mod):
    st = g["stats"]
    out = {}
    # Data
    out["Data"] = (
        f"import {MODPFX}.Check\n\n"
        f"/-!\n# `G27`'s certificate: points, edges, paths, singletons (FS-131, FS131-ISF1; generated by "
        f"`tools/fs131_kfs1_g27.py`)\n\n"
        f"From `data/fs56/g27/cert-g27-mrvz.json` (sha256 `{st['cert_sha256'][:16]}…`): MRVZ's 27 points relabelled in the "
        f"DFS's order (MRVZ's labels `{st['order']}`), translated so that point 0 is the origin, each as `12·xᵢ`; their "
        f"{st['edges']} unit edges as adjacency masks; a path of edges from point 0 to each point; the common denominator "
        f"`Dn` of the weights ({st['D_bits']} bits) and the singletons' coefficients `yᵢ·Dn` (packed `+ OFFC`).\n-/\n\n"
        f"namespace HadwigerNelson.G27\n\n"
        f"set_option maxRecDepth 100000\n\n"
        f"/-- The 27 points `12·xᵢ` (0-based, in the DFS's order), each packed as eight signed digits. -/\n"
        f"def ptsL : List Nat := {lean_list([pack_point(z) for z in g['Q']])}\n\n"
        f"/-- The adjacency masks, point by point. -/\n"
        f"def adjL : List Nat := {lean_list(g['adj'])}\n\n"
        f"/-- A path of edges from point 0 to each point (the points after 0). -/\n"
        f"def pathsL : List (List Nat) := {lean_lists(g['paths'])}\n\n"
        f"/-- The common denominator of the certificate's weights. -/\n"
        f"def Dn : Int := {g['D']}\n\n"
        f"/-- The singletons' coefficients `yᵢ·Dn + OFFC`, point by point. -/\n"
        f"def singL : List Nat := {lean_list([s + OFFC for s in g['sing']])}\n\n"
        f"/-- The frontier's depth. -/\n"
        f"def KF : Nat := {st['kf']}\n\n"
        f"theorem adj_ok : adjOk ptsL adjL = true := by decide +kernel\n\n"
        f"theorem paths_ok : pathsOk adjL pathsL = true := by decide +kernel\n\n"
        f"theorem sing_ok : singSumOk 4 Dn singL = true := by decide +kernel\n\n"
        f"end HadwigerNelson.G27\n")
    # Rows
    rows, coefs = g["rows"], g["coefs"]
    nrm = (len(rows) + rows_per_mod - 1) // rows_per_mod
    for k in range(nrm):
        lo, hi = k * rows_per_mod, min(len(rows), (k + 1) * rows_per_mod)
        out[f"Rows{k:02d}"] = (
            f"import {MODPFX}.Data\n\n"
            f"/-!\n# Congruence rows {lo}–{hi - 1} (FS-131, FS131-ISF1; generated by `tools/fs131_kfs1_g27.py`)\n\n"
            f"Each row an isometry carrying its `I` onto its `J` (`rowOk`), naming points `< 27`, its coefficient fitting.\n-/\n\n"
            f"namespace HadwigerNelson.G27\n\n"
            f"open HadwigerNelson.DensityBound.X23Check\n\n"
            f"set_option maxRecDepth 100000\n\n"
            f"/-- Congruence rows {lo}–{hi - 1}. -/\n"
            f"def rows{k:02d} : List Nat := {lean_list(rows[lo:hi])}\n\n"
            f"/-- Their coefficients `c + OFFC`. -/\n"
            f"def coefs{k:02d} : List Nat := {lean_list(coefs[lo:hi])}\n\n"
            f"theorem rows{k:02d}_ok : rows{k:02d}.all (rowOk ptsL) = true := by decide +kernel\n\n"
            f"theorem rows{k:02d}_fit : rowsFit rows{k:02d} coefs{k:02d} = true := by decide +kernel\n\n"
            f"end HadwigerNelson.G27\n")
    # Root parts
    root = g["root"]
    nroot = (len(root) + root_per_mod - 1) // root_per_mod
    for k in range(nroot):
        lo, hi = k * root_per_mod, min(len(root), (k + 1) * root_per_mod)
        out[f"Root{k:02d}"] = (
            f"import {MODPFX}.Data\n\n"
            f"/-!\n# The sorted terms {lo}–{hi - 1} (FS-131, FS131-ISF1; generated by `tools/fs131_kfs1_g27.py`)\n-/\n\n"
            f"namespace HadwigerNelson.G27\n\n"
            f"set_option maxRecDepth 100000\n\n"
            f"/-- The sorted, merged terms {lo}–{hi - 1}. -/\n"
            f"def root{k:02d} : List Nat := {lean_list(root[lo:hi])}\n\n"
            f"end HadwigerNelson.G27\n")
    # Atoms
    chunks = g["chunks"]
    nam = (len(chunks) + chunks_per_mod - 1) // chunks_per_mod
    for k in range(nam):
        lo, hi = k * chunks_per_mod, min(len(chunks), (k + 1) * chunks_per_mod)
        body = []
        for c in range(lo, hi):
            states = [[S] + L for S, L in chunks[c]]
            body.append(f"/-- Frontier chunk {c}: {len(states)} states. -/\n"
                        f"def fr{c:03d} : List (List Nat) := {lean_lists(states)}\n\n"
                        f"theorem fr{c:03d}_ok : fr{c:03d}.all (subtreeOk Dn (adjL.drop KF) KF) = true := by\n"
                        f"  decide +kernel\n")
        out[f"Atoms{k:02d}"] = (
            f"import {MODPFX}.Data\n\n"
            f"/-!\n# The residual DFS below frontier chunks {lo}–{hi - 1} (FS-131, FS131-ISF1; generated by "
            f"`tools/fs131_kfs1_g27.py`)\n\nEach chunk: every independent extension of each of its states weighs at most "
            f"`Dn` (`leafOk`).\n-/\n\n"
            f"namespace HadwigerNelson.G27\n\n"
            f"set_option maxRecDepth 100000\n\n" + "\n".join(body) + "\nend HadwigerNelson.G27\n")
    return out, dict(rows_mods=nrm, root_mods=nroot, atoms_mods=nam)


def main(argv):
    kf, cw = 14, 60000
    rows_per_mod, chunks_per_mod, root_per_mod = 600, 6, 3000
    only = None
    for k, a in enumerate(argv):
        if a == "--kf":
            kf = int(argv[k + 1])
        if a == "--chunk-work":
            cw = int(argv[k + 1])
        if a == "--only":
            only = argv[k + 1].split(",")
    try:
        g = build(kf, cw)
    except Refusal as e:
        print(f"REFUSED: {e}")
        return 1
    mods, counts = modules(g, rows_per_mod, chunks_per_mod, root_per_mod)
    st = dict(g["stats"], **counts)
    manifest = json.dumps(dict(stats=st, modules=sorted(mods)), indent=1, sort_keys=True) + "\n"
    if "--stats" in argv:
        print(json.dumps(st, indent=1))
        return 0
    if "--write" in argv:
        MODDIR.mkdir(parents=True, exist_ok=True)
        MANIFEST.parent.mkdir(parents=True, exist_ok=True)
        for name, text in mods.items():
            if only is None or name in only:
                (MODDIR / f"{name}.lean").write_text(text)
        MANIFEST.write_text(manifest)
        print(f"wrote {len(mods) if only is None else len(only)} modules; {json.dumps(st)}")
        return 0
    if "--check" in argv:
        files = {f"{name}.lean": text for name, text in mods.items()}
        files["manifest.json"] = manifest
        if "--plant" in argv:
            name = sorted(n for n in files if n.startswith("Rows"))[0]
            t = files[name]
            k = t.index("def rows")
            k = t.index("[", k) + 1
            d0 = t[k]
            files[name] = t[:k] + ("1" if d0 != "1" else "2") + t[k + 1:]
        bad = []
        for name, text in sorted(files.items()):
            path = MANIFEST if name == "manifest.json" else MODDIR / name
            if not path.exists() or path.read_text() != text:
                bad.append(name)
        # modules on disk that the generator would not write
        for p in sorted(MODDIR.glob("*.lean")):
            if p.name != "Check.lean" and p.name not in files and p.name not in ("Valid.lean", "Law.lean", "All.lean"):
                bad.append(f"{p.name} (not generated)")
        if bad:
            print("MISMATCH: " + ", ".join(bad))
            return 1
        print(f"IDENTICAL: {len(files)} files")
        return 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
