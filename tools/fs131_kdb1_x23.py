#!/usr/bin/env python3
"""FS131-IDB3 (lane X of plan FS131-KDB1) — [AmbrusEtAl2023]'s dual certificate as Lean data.

Reads the shipped files only (data/pa-ambrus2023/verification23.nb for the 23 points, g23.csv for the 2,350 coefficients),
refusing either if its checksum is not the one the record holds; reads them back against the paper (Table 1, transcribed in
data/fs131/idb3/paper-table1.txt; Table 2, its text in data/fs131/idb3/paper-table2.txt) and against the covering's
parameters (Cells/Data.lean's P23); builds the integer data the core-only checker Plane/DensityBound/X23Check reads, runs an
exact Python mirror of every check, and writes the generated modules:

  X23Data.lean          the points, w1, the w2 rows, the congruence rows (in parts), the DFS vertices, the frontier, the
                        enclosures; the small checks by `decide +kernel`
  X23CongNN.lean        congruence parts, one theorem per part
  X23AtomsNN.lean       atom-check chunks, one theorem per chunk (at most CHUNK mask tests each)

Nothing here is trusted: the kernel re-checks every claim; a bug here can only produce data the kernel refuses.

Usage (from the worktree root):
  python3 tools/fs131_kdb1_x23.py --plan            the counts, nothing written
  python3 tools/fs131_kdb1_x23.py --write           the modules and data/fs131/idb3/gen/summary.json
  python3 tools/fs131_kdb1_x23.py --plant NAME      write with one planted fault (see PLANTS), into --out DIR
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from fractions import Fraction as Fr
from math import isqrt, lcm
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
import j26_ambrus_check as J  # noqa: E402  (read only: its point and coefficient readers)

NB = ROOT / 'data/pa-ambrus2023/verification23.nb'
CSV = ROOT / 'data/pa-ambrus2023/g23.csv'
SHA = {NB: '7d230f20d41a2a3355bee78241c9d626134548c18eeec4de8a1d1217a74cecec',
       CSV: 'cbfe22f5028f23a84f17d97802a93517e702eea0181d692ad7f5477763cf7274'}
TABLE1 = ROOT / 'data/fs131/idb3/paper-table1.txt'
TABLE2 = ROOT / 'data/fs131/idb3/paper-table2.txt'
CELLDATA = ROOT / 'Proofs/HadwigerNelson/Plane/DensityBound/Cells/Data.lean'
OUTDIR = ROOT / 'Proofs/HadwigerNelson/Plane/DensityBound'
SUMMARY = ROOT / 'data/fs131/idb3/gen/summary.json'

N = 23
WS = 10 ** 21                      # the atom check's scale: one w_C row has 21 decimals
WS20 = 10 ** 20                    # the covering's scale (P23)
NU = Fr(1, 10 ** 5)               # the paper's nu (item 895's ruling 1)
B72, OFF, M23, OFFS = 2 ** 72, 2 ** 70, 2 ** 23, 2 ** 120
S64 = 2 ** 64
KENC = 2 ** 128
KF = 15                            # the frontier depth
CHUNK = 80_000                     # mask tests per atom theorem, at most
ATOMS_PER_MODULE = 8
CONG_PART = 300                    # congruence rows per part
PLANTS = ('distance', 'congruence', 'atom')


def sha256(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


# ---------- exact arithmetic in Z[sqrt3, sqrt11] (coordinates 1, s3, s11, s33) ----------

def qmul(x, y):
    a, b, c, d = x
    e, f, g, h = y
    return (a * e + 3 * (b * f) + 11 * (c * g) + 33 * (d * h),
            a * f + b * e + 11 * (c * h + d * g),
            a * g + c * e + 3 * (b * h + d * f),
            a * h + d * e + b * g + c * f)


def qadd(x, y): return tuple(p + q for p, q in zip(x, y))
def qsub(x, y): return tuple(p - q for p, q in zip(x, y))
def qneg(x): return tuple(-p for p in x)
def qsmul(m, x): return tuple(m * p for p in x)
def cmul(x, y): return (qsub(qmul(x[0], y[0]), qmul(x[1], y[1])), qadd(qmul(x[0], y[1]), qmul(x[1], y[0])))
def cadd(x, y): return (qadd(x[0], y[0]), qadd(x[1], y[1]))
def csub(x, y): return (qsub(x[0], y[0]), qsub(x[1], y[1]))
def conj(x): return (x[0], qneg(x[1]))
def csmul(m, x): return (qsmul(m, x[0]), qsmul(m, x[1]))
def normsq(x): return qadd(qmul(x[0], x[0]), qmul(x[1], x[1]))
def sqd(p, q): return normsq(csub(p, q))


def finv(x):
    """Inverse in Q(sqrt3)(sqrt11), Fractions."""
    a, b, c, d = x
    def m3(u, v): return (u[0] * v[0] + 3 * u[1] * v[1], u[0] * v[1] + u[1] * v[0])
    p, q = (a, b), (c, d)
    n = (m3(p, p)[0] - 11 * m3(q, q)[0], m3(p, p)[1] - 11 * m3(q, q)[1])
    den = n[0] ** 2 - 3 * n[1] ** 2
    ninv = (n[0] / den, -n[1] / den)
    pr, qr = m3(p, ninv), m3((-q[0], -q[1]), ninv)
    r = (pr[0], pr[1], qr[0], qr[1])
    assert qmul(r, x) == (1, 0, 0, 0)
    return r


def cdiv(x, y):
    ni = finv(normsq(y))
    t = cmul(x, conj(y))
    return (qmul(t[0], ni), qmul(t[1], ni))


# ---------- packing (mirrors X23Check) ----------

def pack_digits(ds):
    r = 0
    for k, v in enumerate(ds):
        assert 0 <= v < B72, (k, v)
        r += v << (72 * k)
    return r


def sd(v):
    assert -OFF <= v < B72 - OFF, v
    return v + OFF


def dg(r, k): return (r >> (72 * k)) % B72
def sdg(r, k): return dg(r, k) - OFF
def pack(m, c): return m + M23 * max(c + OFF, 0)


def tval(S, t):
    m = t % M23
    return (t // M23) - OFF if (m & S) == m else 0


def masklist(I):
    m = 0
    for i in I:
        m |= 1 << i
    return m


def pack_st(S, acc): return S + M23 * max(acc + OFFS, 0)
def dec_st(q): return q % M23, q // M23 - OFFS


# ---------- reading ----------

def read_all():
    for p, h in SHA.items():
        got = sha256(p)
        if got != h:
            sys.exit(f'REFUSED: {p} has sha256 {got}, the record holds {h}')
    xs = J.read_points(NB)
    w0, wT, w1, w2, wc = J.read_coeffs(CSV)
    return xs, w0, wT, w1, w2, wc


def to12(x):
    re_, im_ = x
    P = (tuple(12 * c for c in re_), tuple(12 * c for c in im_))
    for part in P:
        for c in part:
            assert c.denominator == 1, ('12x not integral', x)
    return tuple(tuple(int(c) for c in part) for part in P)


def readback_table1(P):
    rows = [ln.split() for ln in TABLE1.read_text().splitlines() if ln.strip() and not ln.startswith('#')]
    assert len(rows) == N
    bad = 0
    for k, r in enumerate(rows):
        assert int(r[0]) == k + 1
        v = tuple(int(t) for t in r[1:])
        mine = P[k][0] + P[k][1]
        if v != mine:
            bad += 1
            print(f'TABLE 1 MISMATCH x{k + 1}: paper {v} notebook {mine}')
    return bad


def readback_table2(w0, wT, w1, w2):
    text = TABLE2.read_text().replace('−', '-')
    head = re.findall(r'(-?\d+\.\d+)', text.split('(i, j)')[0])
    pairs = re.findall(r'\((\d+), (\d+)\)\s+(-?\d+\.\d+)', text)
    bad = 0
    if [Fr(t) for t in head] != [w0, wT, w1]:
        bad += 1
        print('TABLE 2 MISMATCH w0, wT, w1(1):', head)
    paper = {(int(i), int(j)): Fr(v) for i, j, v in pairs}
    mine = {(i, j): v for v, i, j in w2}
    if len(paper) != 26 or paper != mine:
        bad += 1
        print('TABLE 2 MISMATCH w2:', len(paper), sorted(set(paper.items()) ^ set(mine.items()))[:4])
    return bad


def read_p23():
    s = CELLDATA.read_text()
    m = re.search(r'def P23 : Params := ⟨(\d+), (\d+), (\d+), (\d+), \[([^\]]*)\], \[([^\]]*)\]⟩', s)
    WSp, w1N, TN, TD = (int(m.group(k)) for k in range(1, 5))
    Ws = [int(t) for t in m.group(5).split(',')]
    Ds = [int(t) for t in m.group(6).split(',')]
    return WSp, w1N, TN, TD, Ws, Ds


def scaled(v, ws=WS):
    n = v * ws
    assert n.denominator == 1, ('not exact', ws, v)
    return int(n)


# ---------- the build ----------

def build(plant=None):
    xs, w0, wT, w1, w2, wc = read_all()
    P = [to12(x) for x in xs]
    bad = readback_table1(P) + readback_table2(w0, wT, w1, w2)
    WSp, w1Np, TN, TD, Ws, Ds = read_p23()
    w0N, w1N = scaled(w0, WS20), scaled(w1)
    w2T = [(i - 1, j - 1, scaled(v)) for v, i, j in w2]          # g23's order, 0-based, at 10^21
    assert WSp == WS20 and w1Np * 10 == w1N and (TN, TD) == (99994, 100000)
    assert Ws == [w0N] + [c // 10 for _, _, c in w2T] and all(c % 10 == 0 for _, _, c in w2T), \
        'P23.Ws is not w0 then the w2 rows in g23 order'
    boundN = scaled(wT + NU)

    # points, packed
    ptsL = [pack_digits([sd(c) for c in P[i][0] + P[i][1]]) for i in range(N)]

    # edges and adjacency
    adj = [0] * N
    nedges = 0
    for i in range(N):
        for j in range(N):
            if i != j and sqd(P[i], P[j]) == (144, 0, 0, 0):
                adj[i] |= 1 << j
                nedges += i < j
    assert nedges == 47

    # congruence rows with explicit isometries (the row's own order is the correspondence)
    rows, dens = [], []
    for v, I1, J1 in wc:
        I, Jl = [i - 1 for i in I1], [j - 1 for j in J1]
        assert len(I) == len(Jl) and I and all(0 <= t < N for t in I + Jl)
        Pf = [tuple(tuple(Fr(c) for c in part) for part in P[i]) for i in I]
        Qf = [tuple(tuple(Fr(c) for c in part) for part in P[j]) for j in Jl]
        found = None
        one, zero = (Fr(1), Fr(0), Fr(0), Fr(0)), (Fr(0),) * 4
        for b in (0, 1):
            Pb = [conj(p) if b else p for p in Pf]
            if len(I) == 1:
                u = (one, zero)
            else:
                u = cdiv(csub(Qf[1], Qf[0]), csub(Pb[1], Pb[0]))
            vv = csub(Qf[0], cmul(u, Pb[0]))            # in 12x coordinates: Q = u P + vv
            if normsq(u) == one and all(cadd(cmul(u, p), vv) == q for p, q in zip(Pb, Qf)):
                found = (b, u, vv)
                break
        assert found, ('no isometry', I1, J1)
        b, u, vv = found
        m = lcm(*[c.denominator for part in u + vv for c in part])
        U = tuple(tuple(int(c * m) for c in part) for part in u)
        V = tuple(tuple(int(c * m) for c in part) for part in vv)
        dens.append(m)
        c = scaled(v)
        n = len(I)
        rows.append(pack_digits([sd(c), b, m] + [sd(t) for t in U[0] + U[1]] + [sd(t) for t in V[0] + V[1]] + [n] + I + Jl))

    # terms and groups (mirror X23Check.terms, groupsOf)
    terms = [pack(1, w1N)] + [pack((1 << i) | (1 << j), c) for i, j, c in w2T]
    for r in rows:
        n = dg(r, 19)
        I = [dg(r, 20 + k) for k in range(n)]
        Jl = [dg(r, 20 + n + k) for k in range(n)]
        c = sdg(r, 0)
        terms += [pack(masklist(I), -c), pack(masklist(Jl), c)]
    assert len(terms) == 4669
    groups = [[t for t in terms if ((t % M23) >> v) == 1] for v in range(N)]
    assert sum(len(g) for g in groups) == len(terms)
    verts = list(zip(adj, groups))

    if plant == 'distance':
        Ds = Ds[:5] + [Ds[5] + 2] + Ds[6:]
    if plant == 'congruence':
        r = rows[7]
        rows[7] = r + (1 << (72 * 11))           # V's first coordinate moved by one
    if plant == 'atom':
        boundN_used = boundN - 10 ** 15 - 10 ** 13   # bound below max L: wT - 10^-7
    else:
        boundN_used = boundN

    # the DFS (mirror X23Check.collect / dfsG), with the work counted
    def collect(vs, v, S, acc, out):
        if not vs:
            out.append((S, acc))
            return
        a, g = vs[0]
        collect(vs[1:], v + 1, S, acc, out)
        if a & S == 0:
            S2 = S | (1 << v)
            collect(vs[1:], v + 1, S2, acc + sum(tval(S2, t) for t in g), out)

    def dfs_cost(vs, v, S, acc, bound):
        """(ok, tests, max acc over nonempty leaves)"""
        if not vs:
            return (S == 0 or acc <= bound), 0, (acc if S else None)
        a, g = vs[0]
        ok1, n1, m1 = dfs_cost(vs[1:], v + 1, S, acc, bound)
        if a & S != 0:
            return ok1, n1, m1
        S2 = S | (1 << v)
        ok2, n2, m2 = dfs_cost(vs[1:], v + 1, S2, acc + sum(tval(S2, t) for t in g), bound)
        mx = max([x for x in (m1, m2) if x is not None], default=None)
        return ok1 and ok2, n1 + n2 + len(g), mx

    front = []
    collect(verts[:KF], 0, 0, 0, front)
    for S, acc in front:
        assert dec_st(pack_st(S, acc)) == (S, acc)
    costs, okall, maxL = [], True, None
    for S, acc in front:
        ok, n, mx = dfs_cost(verts[KF:], KF, S, acc, boundN_used)
        okall &= ok
        costs.append(n)
        if mx is not None:
            maxL = mx if maxL is None else max(maxL, mx)
    chunks, cur, curn, chunk_tests = [], [], 0, []
    for st, n in zip(front, costs):
        if n > CHUNK:
            sys.exit(f'REFUSED: a subtree of {n} tests over the chunk size {CHUNK} at depth {KF}')
        if curn + n > CHUNK:
            chunks.append(cur)
            chunk_tests.append(curn)
            cur, curn = [], 0
        cur.append(st)
        curn += n
    chunks.append(cur)
    chunk_tests.append(curn)

    # distances: enclosures and the check (mirror X23Check.distOk)
    l3, l11, l33 = isqrt(3 * KENC * KENC), isqrt(11 * KENC * KENC), isqrt(33 * KENC * KENC)
    enc = (KENC, l3, l3 + 1, l11, l11 + 1, l33, l33 + 1)

    def lowmul(b, l, u): return b * l if b >= 0 else b * u
    def highmul(b, l, u): return b * u if b >= 0 else b * l

    dok = True
    for D, (i, j, _) in zip(Ds[1:], w2T):
        q = sqd(P[i], P[j])
        lo = q[0] * KENC + lowmul(q[1], l3, l3 + 1) + lowmul(q[2], l11, l11 + 1) + lowmul(q[3], l33, l33 + 1)
        hi = q[0] * KENC + highmul(q[1], l3, l3 + 1) + highmul(q[2], l11, l11 + 1) + highmul(q[3], l33, l33 + 1)
        dok &= D >= 1 and 144 * (D - 1) ** 2 * KENC <= lo * S64 * S64 and hi * S64 * S64 <= 144 * (D + 1) ** 2 * KENC

    # congruence mirror (X23Check.rowOk)
    def pt(i):
        r = ptsL[i]
        return (tuple(sdg(r, k) for k in range(4)), tuple(sdg(r, 4 + k) for k in range(4)))

    def row_ok(r):
        b, m, n = dg(r, 1) == 1, dg(r, 2), dg(r, 19)
        U = (tuple(sdg(r, 3 + k) for k in range(4)), tuple(sdg(r, 7 + k) for k in range(4)))
        V = (tuple(sdg(r, 11 + k) for k in range(4)), tuple(sdg(r, 15 + k) for k in range(4)))
        I = [dg(r, 20 + k) for k in range(n)]
        Jl = [dg(r, 20 + n + k) for k in range(n)]
        if not (m > 0 and normsq(U) == (m * m, 0, 0, 0)):
            return False
        return all(cadd(cmul(U, conj(pt(i)) if b else pt(i)), V) == csmul(m, pt(j)) for i, j in zip(I, Jl))

    cong_ok = all(row_ok(r) for r in rows)
    stats = dict(points=N, edges=nedges, w2=len(w2T), rows=len(rows), terms=len(terms),
                 group_sizes=[len(g) for g in groups], frontier_depth=KF, frontier=len(front),
                 tests=sum(costs), chunks=len(chunks), chunk_tests=chunk_tests, max_subtree=max(costs),
                 max_den=max(dens), bound=boundN_used, maxL=maxL, minV_minus_nu=(boundN - maxL) / WS - float(NU) if maxL else None,
                 atoms_ok=okall, congruences_ok=cong_ok, distances_ok=dok, table_mismatches=bad,
                 sha256={str(p.relative_to(ROOT)): h for p, h in SHA.items()})
    data = dict(ptsL=ptsL, w1N=w1N, w2T=w2T, boundN=boundN_used, rows=rows, verts=verts, front=front, chunks=chunks,
                enc=enc, w0N=w0N)
    return stats, data


# ---------- Lean emission ----------

HEADER = 'Proofs.HadwigerNelson.Plane.DensityBound'


def lean_list(xs, per_line=1):
    return '[' + ',\n  '.join(', '.join(str(x) for x in xs[k:k + per_line]) for k in range(0, len(xs), per_line)) + ']'


def emit(stats, data, outdir: Path):
    outdir.mkdir(parents=True, exist_ok=True)
    rows = data['rows']
    nparts = (len(rows) + CONG_PART - 1) // CONG_PART
    parts = [rows[k * CONG_PART:(k + 1) * CONG_PART] for k in range(nparts)]
    chunks = data['chunks']
    w2s = ', '.join(f'({i}, {j}, {c})' for i, j, c in data['w2T'])
    verts = ',\n  '.join(f'({a}, {lean_list(g, 4)})' for a, g in data['verts'])
    fr_defs = []
    for k, ch in enumerate(chunks):
        fr_defs.append(f'/-- Frontier chunk {k}: {len(ch)} states. -/\ndef fr{k:02d} : List Nat := {lean_list([pack_st(*s) for s in ch], 4)}\n')
    frL = ' ++ '.join(f'fr{k:02d}' for k in range(len(chunks)))
    wc_defs = []
    for k, part in enumerate(parts):
        wc_defs.append(f'/-- Congruence rows {k * CONG_PART}–{k * CONG_PART + len(part) - 1}. -/\ndef wc{k:02d} : List Nat := {lean_list(part)}\n')
    wcR = ' ++ '.join(f'wc{k:02d}' for k in range(nparts))
    e = data['enc']
    data_mod = f'''import {HEADER}.X23Check

/-!
# `[AmbrusEtAl2023]`'s certificate as data (FS-131, FS131-IDB3; generated by `tools/fs131_kdb1_x23.py`)

The 23 points of Table 1 (the notebook's list, `verification23.nb`) as `12·xᵢ`; the `w₁`, `w₂` and `w_C` coefficients of
`g23.csv` at scale `10²⁰`, exactly; for each of the 2,321 congruence rows an isometry `z ↦ u·(b ? z̄ : z) + v`; the DFS
vertices (adjacency mask, terms by highest point); the frontier at depth {KF}; the enclosures of `√3, √11, √33` at `2¹²⁸`.
Sources' sha256: `g23.csv` `{SHA[CSV][:16]}…`, `verification23.nb` `{SHA[NB][:16]}…`.
-/

namespace HadwigerNelson.DensityBound.X23Check

/-- The 23 points `12·xᵢ` (0-based), each packed as eight signed digits. -/
def ptsL : List Nat := {lean_list(data["ptsL"])}

/-- `w₁(1)·10²⁰` (the paper's 1-based point 1; `w₁` vanishes elsewhere). -/
def w1N : Int := {data["w1N"]}

/-- `w₀·10²⁰`. -/
def w0N : Int := {data["w0N"]}

/-- The 26 `w₂` rows `(i, j, w₂(i, j)·10²⁰)`, 0-based, in `g23.csv`'s order. -/
def w2T : List (Nat × Nat × Int) := [{w2s}]

/-- `(w_T + ν)·10²⁰`, `ν = 10⁻⁵`. -/
def boundN : Int := {data["boundN"]}

{chr(10).join(wc_defs)}
/-- All congruence rows, in `g23.csv`'s order. -/
def wcR : List Nat := {wcR}

set_option maxRecDepth 100000 in
/-- The DFS vertices: point `v`'s adjacency mask and the terms whose highest point is `v`. -/
def vertsL : List (Nat × List Nat) := [{verts}]

/-- The frontier depth. -/
def KF : Nat := {KF}

{chr(10).join(fr_defs)}
/-- The frontier: every state of the DFS at depth `KF`, packed, in its order. -/
def frL : List Nat := {frL}

/-- The enclosures of `√3`, `√11`, `√33` at `K = 2¹²⁸`. -/
def enclL : Encl := ⟨{", ".join(str(x) for x in e)}⟩

theorem encl_ok : enclL.ok = true := by decide +kernel

theorem adj_ok : adjOk ptsL vertsL = true := by decide +kernel

theorem terms_ok : termsOk w1N w2T wcR = true := by decide +kernel

theorem groups_eq : vertsL.map Prod.snd = groupsOf (terms w1N w2T wcR) := by decide +kernel

theorem one_group : (terms w1N w2T wcR).all oneGroup = true := by decide +kernel

theorem verts_length : vertsL.length = 23 := by decide +kernel

theorem frontier_eq : (collect (vertsL.take KF) 0 0 0).map packSt = frL := by decide +kernel

theorem frontier_rt : (collect (vertsL.take KF) 0 0 0).all (fun p => decide (decSt (packSt p) = p)) = true := by
  decide +kernel

end HadwigerNelson.DensityBound.X23Check
'''
    files = {'X23Data.lean': data_mod}
    for k in range(nparts):
        files[f'X23Cong{k:02d}.lean'] = f'''import {HEADER}.X23Data

/-!
# Congruence rows {k * CONG_PART}–{k * CONG_PART + len(parts[k]) - 1} (FS-131, FS131-IDB3; generated by `tools/fs131_kdb1_x23.py`)
-/

namespace HadwigerNelson.DensityBound.X23Check

theorem wc{k:02d}_ok : wc{k:02d}.all (rowOk ptsL) = true := by decide +kernel

end HadwigerNelson.DensityBound.X23Check
'''
    nmods = (len(chunks) + ATOMS_PER_MODULE - 1) // ATOMS_PER_MODULE
    for mdl in range(nmods):
        ks = range(mdl * ATOMS_PER_MODULE, min(len(chunks), (mdl + 1) * ATOMS_PER_MODULE))
        thms = '\n'.join(f'theorem fr{k:02d}_ok : fr{k:02d}.all (subtreeOk boundN (vertsL.drop KF) KF) = true := by\n  decide +kernel\n' for k in ks)
        files[f'X23Atoms{mdl:02d}.lean'] = f'''import {HEADER}.X23Data

/-!
# Atom-check chunks {ks[0]}–{ks[-1]} (FS-131, FS131-IDB3; generated by `tools/fs131_kdb1_x23.py`)

Each chunk runs the DFS below its frontier states: every independent extension's `L(S)·10²⁰` at most `boundN`.
-/

namespace HadwigerNelson.DensityBound.X23Check

{thms}
end HadwigerNelson.DensityBound.X23Check
'''
    cong_imports = '\n'.join(f'import {HEADER}.X23Cong{k:02d}' for k in range(nparts))
    atom_imports = '\n'.join(f'import {HEADER}.X23Atoms{k:02d}' for k in range(nmods))
    wc_simp = ', '.join(f'wc{k:02d}_ok' for k in range(nparts))
    fr_simp = ', '.join(f'fr{k:02d}_ok' for k in range(len(chunks)))
    wc_show = ' ++ ('.join(f'wc{k:02d}' for k in range(nparts)) + ')' * (nparts - 1)
    fr_show = ' ++ ('.join(f'fr{k:02d}' for k in range(len(chunks))) + ')' * (len(chunks) - 1)
    files['X23All.lean'] = f'''{cong_imports}
{atom_imports}

/-!
# The certificate's kernel checks assembled (FS-131, FS131-IDB3; generated by `tools/fs131_kdb1_x23.py`)

Every congruence row is an isometry (`wcR_ok`, from {nparts} parts) and the DFS accepts every frontier state's subtree
(`frL_ok`, from {len(chunks)} chunks in {nmods} modules).
-/

namespace HadwigerNelson.DensityBound.X23Check

theorem wcR_ok : wcR.all (rowOk ptsL) = true := by
  show ({wc_show}).all (rowOk ptsL) = true
  simp only [List.all_append, {wc_simp}, Bool.and_self, Bool.true_and]

theorem frL_ok : frL.all (subtreeOk boundN (vertsL.drop KF) KF) = true := by
  show ({fr_show}).all (subtreeOk boundN (vertsL.drop KF) KF) = true
  simp only [List.all_append, {fr_simp}, Bool.and_self, Bool.true_and]

end HadwigerNelson.DensityBound.X23Check
'''
    for name, text in files.items():
        (outdir / name).write_text(text)
    return files, nparts, nmods


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--plan', action='store_true')
    ap.add_argument('--write', action='store_true')
    ap.add_argument('--plant', choices=PLANTS)
    ap.add_argument('--out')
    ap.add_argument('--kf', type=int)
    a = ap.parse_args()
    global KF
    if a.kf:
        KF = a.kf
    stats, data = build(a.plant)
    print(json.dumps({k: v for k, v in stats.items() if k != 'chunk_tests'}, indent=1))
    print('chunk tests: min', min(stats['chunk_tests']), 'max', max(stats['chunk_tests']))
    if a.plan:
        return 0
    if a.plant:
        files, nparts, nmods = emit(stats, data, Path(a.out))
        print('PLANTED', a.plant, 'into', a.out, 'modules', sorted(files))
        return 0
    if a.write:
        bad = stats['table_mismatches'] or not (stats['atoms_ok'] and stats['congruences_ok'] and stats['distances_ok'])
        if bad:
            print('REFUSED: a read-back or a mirrored check failed; nothing written')
            return 1
        files, nparts, nmods = emit(stats, data, OUTDIR)
        stats['cong_modules'], stats['atom_modules'] = nparts, nmods
        stats['module_sha256'] = {n: hashlib.sha256(t.encode()).hexdigest() for n, t in sorted(files.items())}
        SUMMARY.parent.mkdir(parents=True, exist_ok=True)
        SUMMARY.write_text(json.dumps(stats, indent=1) + '\n')
        print('WROTE', len(files), 'modules;', SUMMARY.relative_to(ROOT))
    return 0


if __name__ == '__main__':
    sys.exit(main())
