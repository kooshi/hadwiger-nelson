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
OFFC = 1 << 852
FUEL = 1073741824
N = 27
ROWS_PER_MOD = 600
WLEAF = 150000
WSPLIT = 200000
WGROUP = 150000
WMODULE = 450000


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


def sort_rounds(ls, r):
    """the kernel's `sortRounds`: bottom-up rounds of `mergePairs`, then flattened when the rounds run out."""
    ls = [list(l) for l in ls]
    while True:
        if r == 0:
            return [t for l in ls for t in l]
        if len(ls) == 0:
            return []
        if len(ls) == 1:
            return ls[0]
        nl, k = [], 0
        while k + 1 < len(ls):
            nl.append(merge_r(ls[k], ls[k + 1])); k += 2
        if k < len(ls):
            nl.append(ls[k])
        ls = nl
        r -= 1


def sort_r(L):
    return sort_rounds([[t] for t in L], 20)


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


def build():
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
    # the rows in modules; each module's terms sorted; the root
    sing_terms = [term(1 << k, sing[k]) for k in range(N)]
    def row_terms(r, cpk):
        n = (r >> (72 * 19)) % B72
        I = [(r >> (72 * (20 + k))) % B72 for k in range(n)]
        J = [(r >> (72 * (20 + n + k))) % B72 for k in range(n)]
        return [mask(I) + M27 * (2 * OFFC - cpk), mask(J) + M27 * cpk]
    segs = []
    for lo in range(0, len(rows), ROWS_PER_MOD):
        rr, cc = rows[lo:lo + ROWS_PER_MOD], coefs[lo:lo + ROWS_PER_MOD]
        terms = [t for r, c in zip(rr, cc) for t in row_terms(r, c)]
        segs.append((rr, cc, sort_r(terms)))
    root = sort_rounds([sing_terms] + [sg[2] for sg in segs], 20)
    agg = sorted((mask(s), c) for s, c in wsets.items() if c != 0)
    if [(tkey(t), tcf(t)) for t in root if tcf(t) != 0] != agg:
        raise Refusal("the root is not the certificate's weights")
    if max(abs(tcf(t)) for t in root).bit_length() > 846:
        raise Refusal("a coefficient is too large for the offset")
    # the whole DFS tree: node = [k, S, |L|, children]
    nodes = []
    stack = [(0, 0, root, None)]
    while stack:
        k, S, L, par = stack.pop()
        i = len(nodes)
        nodes.append([k, S, len(L), []])
        if par is not None:
            nodes[par][3].append(i)
        if k == N:
            if val(0, L) > D:
                raise Refusal("the DFS refuses a leaf: some independent set weighs more than 1")
            continue
        bit, a = 1 << k, adj[k]
        # children in collect order: OUT first; pushed last so it is built first
        if a & S == 0:
            stack.append((k + 1, S | bit, step_in(bit, a, L), i))
        stack.append((k + 1, S, step_out(bit, L), i))
    # the stack builds OUT before IN, so each node's children list is [OUT, IN] (or [OUT])
    work = [0] * len(nodes)
    for i in range(len(nodes) - 1, -1, -1):
        work[i] = nodes[i][2] + sum(work[c] for c in nodes[i][3])
    def level(i, d):
        out, pw, st = [], 0, [i]
        while st:
            j = st.pop()
            if nodes[j][0] == d:
                out.append(j); continue
            pw += nodes[j][2]
            st.extend(reversed(nodes[j][3]))
        return out, pw
    memo = {}
    def best(i):
        if i in memo:
            return memo[i]
        if work[i] <= WLEAF:
            memo[i] = (nodes[i][2], None); return memo[i]
        k, opt = nodes[i][0], None
        for d in range(k + 1, N):
            kids, pw = level(i, d)
            if pw > WSPLIT:
                break
            cost = nodes[i][2] + sum(best(c)[0] for c in kids)
            if opt is None or cost < opt[0]:
                opt = (cost, d)
        if opt is None:
            raise Refusal(f"no split within budget below a node at depth {k}")
        memo[i] = opt
        return opt
    best(0)
    # the split tree, in preorder; each split's children in collect order, leaves grouped
    splits = []          # dict(id, node, k, d, state, items) ; items: ('grp', name, [states], work) | ('st', id)
    def state_of(i):
        return None
    def emit(i, state):
        sid = len(splits)
        k, d = nodes[i][0], memo[i][1]
        S, L = state
        kids = collect(adj, k, S, L, d, [])
        kid_nodes, _ = level(i, d)
        assert [nodes[c][1] for c in kid_nodes] == [st[0] for st in kids]
        rec = dict(id=sid, k=k, d=d, state=state, items=[], work=level(i, d)[1])
        splits.append(rec)
        grp, gw = [], 0
        for c, st in zip(kid_nodes, kids):
            if memo[c][1] is None:
                if grp and gw + work[c] > WGROUP:
                    rec["items"].append(["grp", grp, gw]); grp, gw = [], 0
                grp.append(st); gw += work[c]
            else:
                if grp:
                    rec["items"].append(["grp", grp, gw]); grp, gw = [], 0
                rec["items"].append(["st", emit(c, st)])
        if grp:
            rec["items"].append(["grp", grp, gw])
        return sid
    emit(0, (0, root))
    nlit = sum(len(sp["state"][1]) for sp in splits[1:]) + sum(
        len(L) for sp in splits for it in sp["items"] if it[0] == "grp" for _, L in it[1])
    ngroups = sum(1 for sp in splits for it in sp["items"] if it[0] == "grp")
    stats = dict(points=N, edges=nedges, order=order, D_bits=D.bit_length(), sets=len(wsets),
                 classes=len(classes), rows=len(rows), row_modules=len(segs), expanded=N + 2 * len(rows),
                 root=len(root), dfs_nodes=len(nodes), dfs_work=work[0], splits=len(splits), groups=ngroups,
                 literal_entries_below_root=nlit, wleaf=WLEAF, wsplit=WSPLIT, wgroup=WGROUP, cert_sha256=sha)
    return dict(Q=Q, adj=adj, paths=paths, D=D, sing=sing, segs=segs, root=root, splits=splits, stats=stats,
                order=order)


# ---------------------------------------------------------------------------------------------------- the modules
def hx(n):
    return f"0x{n:x}"


def lean_list(xs, indent="  "):
    return "[" + (",\n" + indent).join(hx(x) for x in xs) + "]"


def lean_list_dec(xs):
    return "[" + ", ".join(str(x) for x in xs) + "]"


def lean_states(sts, indent="  "):
    return "[" + (",\n" + indent).join(lean_list([S] + L, indent + " ") for S, L in sts) + "]"


PRE = "set_option maxRecDepth 200000\nset_option maxHeartbeats 0\n\n"
OPEN_X23 = "open HadwigerNelson.DensityBound.X23Check\n\n"


def head(imports, title, body_doc="", opens=""):
    imp = "".join(f"import {MODPFX}.{m}\n" for m in imports)
    doc = (f"/-!\n# {title} (FS-131, FS131-ISF1; generated by `tools/fs131_kfs1_g27.py`)\n"
           + (f"\n{body_doc}\n" if body_doc else "") + "-/\n\n")
    return imp + "\n" + doc + "namespace HadwigerNelson.G27\n\n" + opens


TAIL = "\nend HadwigerNelson.G27\n"


def modules(g):
    st = g["stats"]
    out = {}
    # ---- Data
    out["Data"] = (
        head(["Check"], "`G27`'s certificate: points, edges, paths, singletons",
             f"From `data/fs56/g27/cert-g27-mrvz.json` (sha256 `{st['cert_sha256'][:16]}…`): MRVZ's 27 points relabelled "
             f"in the DFS's order (MRVZ's labels `{st['order']}`), translated so that point 0 is the origin, each as "
             f"`12·xᵢ`; their {st['edges']} unit edges as adjacency masks; a path of edges from point 0 to each point; the "
             f"common denominator `Dn` of the weights ({st['D_bits']} bits) and the singletons' coefficients "
             f"`yᵢ·Dn + OFFC`.", OPEN_X23)
        + PRE +
        "/-- The 27 points `12·xᵢ` (0-based, in the DFS's order), each packed as eight signed digits. -/\n"
        f"def ptsL : List Nat := {lean_list([pack_point(z) for z in g['Q']])}\n\n"
        "/-- The adjacency masks, point by point. -/\n"
        f"def adjL : List Nat := {lean_list_dec(g['adj'])}\n\n"
        "/-- A path of edges from point 0 to each point (the points after 0). -/\n"
        "def pathsL : List (List Nat) := [" + ", ".join(lean_list_dec(p) for p in g["paths"]) + "]\n\n"
        "/-- The common denominator of the certificate's weights. -/\n"
        f"def Dn : Int := {g['D']}\n\n"
        "/-- The singletons' coefficients `yᵢ·Dn + OFFC`, point by point. -/\n"
        f"def singL : List Nat := {lean_list([x + OFFC for x in g['sing']])}\n\n"
        "theorem adj_ok : adjOk ptsL adjL = true := by decide +kernel\n\n"
        "theorem wf_ok : wfB adjL 0 = true := by decide +kernel\n\n"
        "theorem paths_ok : pathsOk adjL pathsL = true := by decide +kernel\n\n"
        "theorem origin_ok : (pt ptsL 0).beq ⟨Q4.ofInt 0, Q4.ofInt 0⟩ = true := by decide +kernel\n\n"
        "theorem sing_ok : singSumOk 4 Dn singL = true := by decide +kernel\n\n"
        "theorem Dn_pos : 0 < Dn := by decide\n" + TAIL)
    # ---- Rows
    segs = g["segs"]
    nseg = len(segs)
    base = 0
    for k, (rr, cc, ss) in enumerate(segs):
        half = (len(rr) + 1) // 2
        out[f"Rows{k:02d}"] = (
            head(["Data"], f"Congruence rows {base}–{base + len(rr) - 1}",
                 "Each row an isometry carrying its `I` onto its `J` (`rowOk`), naming points `< 27`, its coefficient "
                 "fitting; the rows' terms sorted by key and merged.", OPEN_X23) + PRE +
            f"/-- Congruence rows {base}–{base + len(rr) - 1}. -/\n"
            f"def rows{k:02d} : List Nat := {lean_list(rr)}\n\n"
            "/-- Their coefficients `c + OFFC`. -/\n"
            f"def coefs{k:02d} : List Nat := {lean_list(cc)}\n\n"
            "/-- Their terms, sorted by key and merged. -/\n"
            f"def sorted{k:02d} : List Nat := {lean_list(ss)}\n\n"
            f"theorem rows{k:02d}_ok0 : (rows{k:02d}.take {half}).all (rowOk ptsL) = true := by decide +kernel\n\n"
            f"theorem rows{k:02d}_ok1 : (rows{k:02d}.drop {half}).all (rowOk ptsL) = true := by decide +kernel\n\n"
            f"theorem rows{k:02d}_fit : rowsFit rows{k:02d} coefs{k:02d} = true := by decide +kernel\n\n"
            f"theorem rows{k:02d}_sort : eqL (sortR (rowsTerms rows{k:02d} coefs{k:02d})) sorted{k:02d} = true := by\n"
            "  decide +kernel\n" + TAIL)
        base += len(rr)
    # ---- the root
    root = g["root"]
    q = (len(root) + 3) // 4
    parts = [root[i * q:(i + 1) * q] for i in range(4)]
    out["RootData"] = (
        head(["Data"], "The root: the certificate's terms sorted by key, equal keys merged",
             f"{len(root)} terms, one per weighted set: `key + 2²⁷·(y·Dn + OFFC)`.") + PRE +
        "".join(f"/-- The sorted terms, part {i}. -/\ndef rootL{i} : List Nat := {lean_list(parts[i])}\n\n" for i in range(4)) +
        "/-- The sorted terms. -/\ndef rootL : List Nat := rootL0 ++ (rootL1 ++ (rootL2 ++ rootL3))\n\n"
        "/-- The DFS's root state: the empty set, then the sorted terms. -/\ndef rootSt : List Nat := 0 :: rootL\n" + TAIL)
    out["RootSort"] = (
        head(["RootData"] + [f"Rows{k:02d}" for k in range(nseg)], "The root is the rows' sorted terms merged") + PRE +
        "theorem root_ok : eqL (sortRounds 20 (singTerms 0 singL :: [" +
        ", ".join(f"sorted{k:02d}" for k in range(nseg)) + "])) rootL = true := by\n  decide +kernel\n" + TAIL)
    # ---- the split tree: states and checks
    splits = g["splits"]
    parent = {}
    for sp in splits:
        for it in sp["items"]:
            if it[0] == "st":
                parent[it[1]] = sp["id"]

    def stname(i):
        return "rootSt" if i == 0 else f"st{i:03d}"

    def stmod(i):
        return "RootData" if i == 0 else f"St{parent[i]:03d}"
    checks = []
    for sp in splits:
        i = sp["id"]
        names, body = [], []
        for j, it in enumerate(sp["items"]):
            if it[0] == "grp":
                nm = f"gp{i:03d}x{j:02d}"
                body.append(f"/-- Leaf states, group {j} of split {i}: {len(it[1])} states at point {sp['d']}. -/\n"
                            f"def {nm} : List (List Nat) := {lean_states(it[1])}\n\n")
                names.append(nm)
                checks.append((f"theorem {nm}_ok : {nm}.all (goodB Dn adjL {sp['d']}) = true := by\n  decide +kernel\n",
                               it[2], [f"St{i:03d}"]))
            else:
                c = it[1]
                S, L = splits[c]["state"]
                body.append(f"/-- The state of split {c}, at point {sp['d']}. -/\n"
                            f"def {stname(c)} : List Nat := {lean_list([S] + L)}\n\n")
                names.append(f"[{stname(c)}]")
        body.append(f"/-- The states at point {sp['d']} below split {i}, in the DFS's order. -/\n"
                    f"def out{i:03d} : List (List Nat) := " + " ++ ".join(names) + "\n")
        out[f"St{i:03d}"] = (head(["Data"], f"Split {i}: the states at point {sp['d']} below its state at point {sp['k']}")
                             + PRE + "".join(body) + TAIL)
        checks.append((f"theorem sp{i:03d}_ok : splitOk adjL {sp['k']} {sp['d']} {stname(i)} out{i:03d} = true := by\n"
                       "  decide +kernel\n", sp["work"], sorted({stmod(i), f"St{i:03d}"})))
    cmods, cur, curw, curimp = [], [], 0, set()
    for decl, w, imps in checks:
        if cur and (curw + w > WMODULE or len(curimp | set(imps)) > 3):
            cmods.append((cur, sorted(curimp), curw)); cur, curw, curimp = [], 0, set()
        cur.append(decl); curw += w; curimp |= set(imps)
    if cur:
        cmods.append((cur, sorted(curimp), curw))
    for k, (decls, imps, w) in enumerate(cmods):
        out[f"Chk{k:02d}"] = (head(imps, f"Residual DFS checks, part {k}", f"About {w} residual entries in all.")
                              + PRE + "\n".join(decls) + TAIL)
    # ---- the assembly
    L = [head(["RootSort"] + [f"Chk{k:02d}" for k in range(len(cmods))] + ["Sound"],
              "`G27`'s kernel checks assembled",
              "The rows' checks joined by module (`segs_ok`), the root (`root_sorted`), and the residual DFS accepting "
              "from the root (`good_root`): each split's state passes because its states one level down do."), PRE]
    L.append("/-- The congruence rows, by module. -/\ndef segR : List (List Nat) := [" +
             ", ".join(f"rows{k:02d}" for k in range(nseg)) + "]\n\n")
    L.append("/-- Their coefficients, by module. -/\ndef segC : List (List Nat) := [" +
             ", ".join(f"coefs{k:02d}" for k in range(nseg)) + "]\n\n")
    L.append("/-- Their sorted terms, by module. -/\ndef segS : List (List Nat) := [" +
             ", ".join(f"sorted{k:02d}" for k in range(nseg)) + "]\n\n")
    L.append("theorem segs_ok : SegsOk ptsL segR segC segS := by\n  simp only [segR, segC, segS, SegsOk]\n  exact ⟨" +
             ", ".join(f"⟨⟨{(len(segs[k][0]) + 1) // 2}, rows{k:02d}_ok0, rows{k:02d}_ok1⟩, rows{k:02d}_fit, rows{k:02d}_sort⟩"
                       for k in range(nseg)) +
             ", trivial⟩\n\n")
    L.append("theorem root_sorted : eqL (sortRounds 20 (singTerms 0 singL :: segS)) rootL = true := root_ok\n\n")
    for sp in reversed(splits):
        i = sp["id"]
        rw = [f"gp{i:03d}x{j:02d}_ok" if it[0] == "grp" else f"good{it[1]:03d}" for j, it in enumerate(sp["items"])]
        L.append(f"theorem good{i:03d} : goodB Dn adjL {sp['k']} {stname(i)} = true :=\n"
                 f"  goodB_of_split sp{i:03d}_ok (by\n    simp only [out{i:03d}, List.all_append, List.all_cons, "
                 "List.all_nil, " + ", ".join(rw) + ", Bool.and_true, Bool.true_and])\n\n")
    L.append("theorem good_root : goodB Dn adjL 0 rootSt = true := good000\n")
    L.append(TAIL)
    out["All"] = "".join(L)
    return out, dict(check_modules=len(cmods), check_module_work=[w for _, _, w in cmods])


HAND = ("Check.lean", "Sound.lean", "Law.lean", "Bound.lean")


def main(argv):
    try:
        g = build()
    except Refusal as e:
        print(f"REFUSED: {e}")
        return 1
    mods, counts = modules(g)
    st = dict(g["stats"], **counts)
    sizes = {name: len(text.encode()) for name, text in mods.items()}
    st["largest_module_bytes"] = max(sizes.values())
    st["total_bytes"] = sum(sizes.values())
    manifest = json.dumps(dict(stats=st, modules=sorted(mods), sizes=sizes), indent=1, sort_keys=True) + "\n"
    if max(sizes.values()) > 20_000_000:
        print("REFUSED: a module is over 20 MB")
        return 1
    if "--stats" in argv:
        print(json.dumps(st, indent=1))
        return 0
    if "--write" in argv:
        MODDIR.mkdir(parents=True, exist_ok=True)
        MANIFEST.parent.mkdir(parents=True, exist_ok=True)
        keep = set(HAND) | {f"{n}.lean" for n in mods}
        for p in sorted(MODDIR.glob("*.lean")):
            if p.name not in keep:
                p.unlink()
        for name, text in mods.items():
            (MODDIR / f"{name}.lean").write_text(text)
        MANIFEST.write_text(manifest)
        print(f"wrote {len(mods)} modules; {json.dumps(st)}")
        return 0
    if "--check" in argv:
        files = {f"{name}.lean": text for name, text in mods.items()}
        if "--plant" in argv:
            t = files["Rows00.lean"]
            k = t.index("def rows00 : List Nat := [0x") + len("def rows00 : List Nat := [0x")
            files["Rows00.lean"] = t[:k] + ("1" if t[k] != "1" else "2") + t[k + 1:]
        bad = []
        for name, text in sorted(files.items()):
            path = MODDIR / name
            if not path.exists() or path.read_text() != text:
                bad.append(name)
        if not MANIFEST.exists() or MANIFEST.read_text() != manifest:
            bad.append("manifest.json")
        for p in sorted(MODDIR.glob("*.lean")):
            if p.name not in files and p.name not in HAND:
                bad.append(f"{p.name} (on disk, not generated)")
        if bad:
            print("MISMATCH: " + ", ".join(bad))
            return 1
        print(f"IDENTICAL: {len(files)} modules and the manifest")
        return 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
