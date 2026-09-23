#!/usr/bin/env python3
"""fs73_census_check -- the standalone checker for FS-73's census (phase P1): the subgroup sandwiches F_known <= F <= P <= P_found of
de Grey's lattice over K = Q(sqrt3, sqrt11) and of the three rich 2-unit lattices over Q(sqrt3, sqrt5) (their GENERATOR graphs).
FROZEN once committed: a change is a new file, never an edit.

STANDARD LIBRARY ONLY, and it imports nothing from tools/.  It reads only data/fs73/census/: the lattice files lattice-TAG.json, the
rows (K-rows.jsonl, rich-rows.jsonl), the stated sandwiches (K-sandwich.json and the rich rows' sandwich rows), the colourings under
colourings/, and, for step (iii), the certificate witness under cert/.  Nothing here trusts tools/fs73_screen.py, which wrote them.

THE OBJECTS.  A lattice Lambda is the Z-span of the rows H of its lattice file (integer 2n-vectors over M: a point (x, y) of F^2 with
x, y on the basis 1, sqrt r1, sqrt r2, sqrt(r1 r2)); every other vector in the census is in lattice coordinates, i.e. an integer
combination of H's rows.  U is the constraint set: every unit vector of Lambda for de Grey's lattice ('complete'), the generators for
the rich lattices ('generators': the graph is Cay(Lambda, S), a spanning subgraph of the saturated one).  A periodic colouring is a
colouring of Cay(Lambda/W, U mod W); Per(c) its period group; KPer(c) its Kempe period group (the translations fixing every (a,b)-Kempe
component, a != b); P is the intersection of Per(c) over the periodic proper colourings, and P <= Per(c) and P <= KPer(c) for each one
(plan section 0, R3); F, the forced group, lies inside P.

WHAT IT CHECKS, in order of marginal value (a reviewer may stop after any step and keep what it established):
  (0) the lattice files: every u in U is a unit vector (x^2 + y^2 = M^2 exactly in F), lies in Lambda, U = -U, and span(U) = Lambda.
      For a 'complete' file, U is re-enumerated independently: every unit vector of F(i) with denominator dividing M (a box search in
      the real embeddings, decided in integers), filtered by membership -- it must equal U.
  (i) every colouring the rows analysed: its W has finite index and holds no u; the file's class map is a bijection Lambda/W ->
      prod Z/d_i; each stated generator of Per(c) is a period, W <= Per(c), and Per(c) is EXACT (descended to Lambda/Per, no nonzero
      class is a period); c is proper on Cay(Lambda/Per, U mod Per), hence on Cay(Lambda, U).  This alone makes the intersection of
      the stated Per(c) a sound upper bound for P.
  (ii) KPer(c) recomputed on Lambda/Per(c) from the colouring alone -- every component of every two-colour subgraph at all six colour
      pairs, its voltage group from BFS potentials over the full multiset U -- and compared with the stated one; P_found recomputed
      as the intersection of KPer(c) over every analysed colouring and compared with the stated sandwich.  So P <= P_found, checked.
  (iii) F_known: at K, the certified forced vector read from the certificate's own witness file (its pair difference), its orbit under
      the z-rotation and complex conjugation computed in the field, and the span of the orbit, which must equal the stated F_known.
      The certificate itself (the LRAT proof that the pair is forced) is checked by the frozen tools/fs73_cert_check.py: --cert runs
      it as a separate process (it is a sibling standalone checker, not a dependency).  The rich lattices state F_known = 0.
  (iv) LAST, and the only step that trusts a solver: every UNSAT on file behind "P_N exactly" (a 'sep' confirmation, or a period
      with no colouring at all) is re-asked on this file's OWN encoding -- classes by Hermite reduction, not the writer's Smith
      indexing; pins only the origin (colour 0) and its least neighbour (colour 1) -- by --solver (default kissat), for asks of at most
      --max-classes classes.  Skipping (iv) (--no-solver) loses no step of the sandwich's soundness: P_N's exactness is a LOWER bound
      on P_N, which the sandwich does not use.

Usage:
  fs73_census_check.py [--no-solver] [--solver kissat] [--max-classes 100000] [--budget 600] [--cert] [--only degrey,tu14,...]
  fs73_census_check.py --controls        planted faults, each refused for its named reason, plus the faithful twin
Exit 0 and 'CENSUS VERIFIED' when every step run passes; exit 1 and 'REFUSED <CODE>: <detail>' otherwise.
"""
import glob
import gzip
import hashlib
import itertools
import json
import math
import os
import subprocess
import sys
import tempfile
import time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CENSUS = os.path.join(ROOT, 'data', 'fs73', 'census')
CERT_WITNESS = os.path.join(CENSUS, 'cert', 't-16_8_8_0-R1.5', 'witness.json')


class Refusal(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


def need(ok, code, detail):
    if not ok:
        raise Refusal(code, detail)


# ================================================================ the field F = Q(sqrt r1, sqrt r2) on integer 4-vectors

class Field:
    def __init__(self, rad):
        self.rad = list(rad)
        k = len(self.rad)
        self.n = 2 ** k
        self.tab = {}
        for a in range(self.n):
            for b in range(self.n):
                coef = 1
                for i in range(k):
                    if a >> i & 1 and b >> i & 1:
                        coef *= self.rad[i]
                self.tab[(a, b)] = (coef, a ^ b)

    def mul(self, p, q):
        out = [0] * self.n
        for a, pa in enumerate(p):
            if pa:
                for b, qb in enumerate(q):
                    if qb:
                        coef, c = self.tab[(a, b)]
                        out[c] += coef * pa * qb
        return out

    def emb(self, p, sg):
        s = 0.0
        for a, pa in enumerate(p):
            if pa:
                t = float(pa)
                for i in range(len(self.rad)):
                    if a >> i & 1:
                        t *= sg[i] * math.sqrt(self.rad[i])
                s += t
        return s

    def signs(self):
        return list(itertools.product((1, -1), repeat=len(self.rad)))


def is_unit(F, v, M):
    n = F.n
    s = [a + b for a, b in zip(F.mul(v[:n], v[:n]), F.mul(v[n:], v[n:]))]
    return s[0] == M * M and not any(s[1:])


# ================================================================ integer lattices (row Hermite form, pivot columns increasing)

def hnf(rows, r):
    A = [list(v) for v in rows if any(v)]
    out = []
    for col in range(r):
        while True:
            nz = [row for row in A if row[col]]
            if len(nz) <= 1:
                break
            nz.sort(key=lambda row: abs(row[col]))
            p = nz[0]
            for row in nz[1:]:
                q = row[col] // p[col]
                if q:
                    for j in range(col, r):
                        row[j] -= q * p[j]
            A = [row for row in A if any(row)]
        nz = [row for row in A if row[col]]
        if nz:
            p = nz[0]
            A = [row for row in A if row is not p]
            if p[col] < 0:
                p = [-x for x in p]
            out.append(p)
    piv = [next(j for j in range(r) if row[j]) for row in out]
    for i in range(len(out)):
        for k in range(i):
            q = out[k][piv[i]] // out[i][piv[i]]
            if q:
                out[k] = [a - q * b for a, b in zip(out[k], out[i])]
    return [tuple(row) for row in out]


def coords(H, v, r):
    """integer coefficients c with sum c_i H_i = v, or None; H in row Hermite form"""
    v = list(v)
    c = []
    piv = [next(j for j in range(r) if row[j]) for row in H]
    i = 0
    for j in range(r):
        if i < len(H) and piv[i] == j:
            q, rem = divmod(v[j], H[i][j])
            if rem:
                return None
            c.append(q)
            if q:
                v = [a - q * b for a, b in zip(v, H[i])]
            i += 1
        elif v[j]:
            return None
    return c


def member(H, v, r):
    return coords(H, v, r) is not None


def span_add(H, v, r):
    return H if (not any(v) or member(H, v, r)) else hnf(list(H) + [tuple(v)], r)


def same(H1, H2, r):
    return hnf(H1, r) == hnf(H2, r)


def intersect(L1, L2, r):
    rows = [list(b) + list(b) for b in L1] + [list(b) + [0] * r for b in L2]
    H = hnf(rows, 2 * r)
    return hnf([row[r:] for row in H if not any(row[:r])], r)


def index_of(H, r):
    if len(H) < r:
        return None
    return math.prod(abs(row[i]) for i, row in enumerate(H))


def invariant_factors(H, r):
    """Lambda / span(H) as (free rank, torsion invariant factors), by a plain Smith diagonalisation of the relation matrix"""
    A = [list(row) for row in H if any(row)]
    m = len(A)
    d = []
    t = 0
    while t < m and t < r:
        cand = [(abs(A[i][j]), i, j) for i in range(t, m) for j in range(t, r) if A[i][j]]
        if not cand:
            break
        while True:
            _, i, j = min((abs(A[i][j]), i, j) for i in range(t, m) for j in range(t, r) if A[i][j])
            A[t], A[i] = A[i], A[t]
            for row in A:
                row[t], row[j] = row[j], row[t]
            p = A[t][t]
            for i in range(t + 1, m):
                q = A[i][t] // p
                if q:
                    A[i] = [a - q * b for a, b in zip(A[i], A[t])]
            for j in range(t + 1, r):
                q = A[t][j] // p
                if q:
                    for row in A:
                        row[j] -= q * row[t]
            if any(A[i][t] for i in range(t + 1, m)) or any(A[t][j] for j in range(t + 1, r)):
                continue                                        # a smaller remainder appeared: it becomes the pivot
            bad = next((i for i in range(t + 1, m) for j in range(t + 1, r) if A[i][j] % p), None)
            if bad is None:
                break
            A[t] = [a + b for a, b in zip(A[t], A[bad])]           # divisibility: fold the offending row in and repeat
        d.append(abs(A[t][t]))
        t += 1
    return {'free': r - len(d), 'torsion': [x for x in d if x > 1]}


class HermiteQuotient:
    """Lambda / W for a full-rank W, by canonical Hermite reduction (0 <= x_i < W[i][i]); independent of any Smith indexing"""
    def __init__(self, W, r):
        self.W = hnf(W, r)
        need(len(self.W) == r, 'W_NOT_FINITE_INDEX', f'rank {len(self.W)} < {r}')
        self.r = r
        self.piv = [row[i] for i, row in enumerate(self.W)]
        self.n = math.prod(self.piv)

    def red(self, x):
        x = list(x)
        for i, row in enumerate(self.W):
            q = x[i] // row[i]
            if q:
                x = [a - q * b for a, b in zip(x, row)]
        return tuple(x)

    def reps(self):
        return [tuple(t) for t in itertools.product(*[range(p) for p in self.piv])]


# ================================================================ inputs

def load_rows(name):
    path = os.path.join(CENSUS, name)
    rows = []
    for line in open(path):
        if line.strip():
            rows.append(json.loads(line))
    return rows


def load_lattice(tag):
    d = json.load(open(os.path.join(CENSUS, f'lattice-{tag}.json')))
    F = Field(d['field_radicands'])
    return d, F


def colouring_files():
    out = {}
    for fn in glob.glob(os.path.join(CENSUS, 'colourings', '*.json.gz')):
        sha = os.path.basename(fn)[:-len('.json.gz')].rsplit('-', 1)[1]
        out.setdefault(sha, fn)
    return out


class ColouringFile:
    """a colouring of Lambda/W as the writer indexed it: class index = big-endian mixed radix of ((x C) mod d) over the coordinates
    with d_i > 1 (C = I, d = (N, ..., N) when W = N Lambda and the file carries no Smith data).  The class map is CHECKED to be a
    bijection Lambda/W -> prod Z/d_i: C C^-1 = I, every row of W maps to 0, and prod d_i = [Lambda : W]."""
    def __init__(self, path, r, sha=None, doc=None):
        d = doc if doc is not None else json.load(gzip.open(path, 'rt'))
        self.path = path
        s = d['colouring']
        if sha is not None:
            need(hashlib.sha256(s.encode()).hexdigest()[:16] == sha, 'COLOURING_SHA', f'{path}: the colouring is not the one named')
        self.col = [int(ch) for ch in s]
        self.W = [tuple(w) for w in d['W']]
        need(len(self.W) == r, 'W_SHAPE', f'{path}: W has {len(self.W)} rows, rank {r}')
        if 'smith_C' in d:
            C, Ci, dd = d['smith_C'], d['smith_Cinv'], d['smith_d']
        else:
            N = self.W[0][0]
            need(all(self.W[i][j] == (N if i == j else 0) for i in range(r) for j in range(r)), 'NO_SMITH_DATA',
                 f'{path}: W is not N Lambda and the file carries no Smith data')
            C = [[1 if i == j else 0 for j in range(r)] for i in range(r)]
            Ci, dd = C, [N] * r
        prod = [[sum(C[i][k] * Ci[k][j] for k in range(r)) for j in range(r)] for i in range(r)]
        need(prod == [[1 if i == j else 0 for j in range(r)] for i in range(r)], 'SMITH_C', f'{path}: C C^-1 != I')
        self.C, self.keep = C, [i for i in range(r) if dd[i] > 1]
        self.mods = [dd[i] for i in self.keep]
        for w in self.W:
            y = self._y(w)
            need(all(y[i] % dd[i] == 0 for i in range(r) if dd[i]), 'SMITH_W', f'{path}: a row of W is not in the kernel')
        self.n = math.prod(self.mods)
        need(self.n == index_of(hnf(self.W, r), r), 'SMITH_INDEX', f'{path}: prod d = {self.n} != [Lambda : W]')
        need(len(self.col) == self.n, 'COLOURING_LENGTH', f'{path}: {len(self.col)} colours for {self.n} classes')
        need(set(self.col) <= {0, 1, 2, 3}, 'COLOURS', f'{path}: colours outside 0..3')
        self.pw = [math.prod(self.mods[i + 1:]) for i in range(len(self.mods))]
        self.r = r

    def _y(self, x):
        return [sum(x[k] * self.C[k][j] for k in range(len(x))) for j in range(len(x))]

    def digits(self, x):
        y = self._y(x)
        return [y[i] % m for i, m in zip(self.keep, self.mods)]

    def idx(self, x):
        return sum(dg * p for dg, p in zip(self.digits(x), self.pw))

    def is_period(self, t):
        """c(x + t) = c(x) for every class x, by digit-wise addition over the whole quotient"""
        td = self.digits(t)
        col = self.col
        k = len(self.mods)
        tables = [[((dv + td[i]) % self.mods[i]) * self.pw[i] for dv in range(self.mods[i])] for i in range(k)]
        # iterate the classes in index order: the last digit fastest
        head = list(itertools.product(*[range(m) for m in self.mods[:-1]]))
        last = tables[-1]
        mlast = self.mods[-1]
        i = 0
        for h in head:
            base = sum(tables[j][h[j]] for j in range(k - 1))
            for dv in range(mlast):
                if col[i] != col[base + last[dv]]:
                    return False
                i += 1
        return True


# ================================================================ step (0): the lattice file

def box_units(F, D):
    """every unit vector of F(i) whose coordinates have denominator dividing D, as 2n-vectors over D (n = 4): X, Y integer 4-vectors
    with X^2 + Y^2 = D^2; each coordinate satisfies |sigma(X)| <= D in every real embedding (floats bound the search with a margin,
    integers decide)"""
    sq = [math.sqrt(x) for x in F.rad]
    s1, s2 = sq
    eps = 1e-6
    B = []
    for a in range(-D, D + 1):
        for b in range(-int(D / s1) - 1, int(D / s1) + 2):
            for c in range(-int(D / s2) - 1, int(D / s2) + 2):
                lo, hi = -1e30, 1e30
                for g1, g2 in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
                    base = a + g1 * b * s1 + g2 * c * s2
                    kk = g1 * g2
                    l_, h_ = sorted(((-D - base) * kk, (D - base) * kk))
                    lo, hi = max(lo, l_), min(hi, h_)
                if lo > hi + eps:
                    continue
                for dd in range(math.ceil((lo - eps) / (s1 * s2)), math.floor((hi + eps) / (s1 * s2)) + 1):
                    B.append((a, b, c, dd))
    by_sq = {}
    for e in B:
        by_sq.setdefault(tuple(F.mul(e, e)), []).append(e)
    target = (D * D, 0, 0, 0)
    out = set()
    for e in B:
        need_ = tuple(t - v for t, v in zip(target, F.mul(e, e)))
        for f in by_sq.get(need_, ()):
            out.add(tuple(e) + tuple(f))
    return out


def step0(tag, log, doc=None):
    d, F = load_lattice(tag) if doc is None else (doc, Field(doc['field_radicands']))
    M, H, U8 = d['M'], [tuple(h) for h in d['H']], [tuple(u) for u in d['U']]
    dim = 2 * F.n
    need(hnf(H, dim) == H, 'H_NOT_HERMITE', f'{tag}: the file basis is not in row Hermite form')
    r = len(H)
    U = []
    for u in U8:
        need(is_unit(F, u, M), 'NOT_UNIT', f'{tag}: {u} is not a unit vector')
        c = coords(H, u, dim)
        need(c is not None, 'U_OUTSIDE', f'{tag}: {u} is not in the lattice')
        U.append(tuple(c))
    need(set(U) == {tuple(-x for x in u) for u in U}, 'U_NOT_SYMMETRIC', tag)
    need(hnf(U8, dim) == H, 'SPAN', f'{tag}: span(U) != Lambda')
    if d['saturation'].startswith('complete'):
        t0 = time.time()
        full = set()
        for v in box_units(F, M):
            if coords(H, v, dim) is not None:
                full.add(v)
        need(full == set(U8), 'NOT_COMPLETE', f'{tag}: the box search finds {len(full)} unit vectors in Lambda, the file lists {len(U8)}')
        log(f'  (0) {tag}: {len(U)} unit vectors, all exact and in Lambda; U = -U; span(U) = Lambda (rank {r}); U COMPLETE by an '
            f'independent box search at D = M = {M} ({time.time() - t0:.1f} s)')
    else:
        inv = [p for p in (3, 5, 7, 9, 11, 13, 17, 19, 23, 29, 31, 37, 41)
               if M % p == 0 and coords(H, tuple([M // p] + [0] * (dim - 1)), dim) is not None]
        log(f'  (0) {tag}: 1/p lies in Lambda for p in {inv} (so -1 lies in p Lambda and p Lambda is inadmissible); not for the '
            f'other p <= 41')
        log(f'  (0) {tag}: {len(U)} unit vectors, all exact and in Lambda; U = -U; span(U) = Lambda (rank {r}); U is a GENERATOR set '
            f'(the file says: {d["saturation"][:60]}...) -- every conclusion below is about the generator graph Cay(Lambda, S)')
    return {'d': d, 'F': F, 'M': M, 'H': H, 'r': r, 'U': U, 'dim': dim}


# ================================================================ steps (i) and (ii): the colourings, Per, KPer, P_found

def descend(cf, P, r):
    Q = HermiteQuotient(P, r)
    col = {}
    for x in Q.reps():
        col[x] = cf.col[cf.idx(x)]
    return Q, col


def check_colouring(L, cf, Per_stated, KPer_stated, label, log, verbose=False):
    r, U = L['r'], L['U']
    W = hnf(cf.W, r)
    for u in U:
        need(not member(W, u, r), 'W_INADMISSIBLE', f'{label}: a unit vector lies in W')
    Per = hnf([tuple(p) for p in Per_stated], r)
    need(len(Per) == r, 'PER_NOT_FINITE_INDEX', label)
    for w in W:
        need(member(Per, w, r), 'W_NOT_IN_PER', f'{label}: W is not inside the stated Per')
    for t in Per:
        need(cf.is_period(t), 'PERIOD_FALSE', f'{label}: the stated period {t} is not a period of the colouring')
    Q, col = descend(cf, Per, r)
    reps = Q.reps()
    for s_ in {Q.red(u) for u in U}:
        for x in reps:
            need(col[Q.red([a + b for a, b in zip(x, s_)])] != col[x], 'IMPROPER',
                 f'{label}: the edge {x} -> {x} + {s_} (mod Per) is monochromatic')
    for t in reps:
        if not any(t):
            continue
        need(any(col[Q.red([a + b for a, b in zip(x, t)])] != col[x] for x in reps), 'PER_NOT_EXACT',
             f'{label}: {t} is a period outside the stated Per')
    # (ii) KPer on Lambda/Per: every component of every two-colour subgraph, its voltage group from BFS potentials (actual lattice
    # points) over the full multiset U; x + u lands in the class red(x + red(u)), and the potential moves by u itself
    steps = [(u, Q.red(u)) for u in U]
    nxt_cache = {}

    def step(x, s_):
        key = (x, s_)
        if key not in nxt_cache:
            nxt_cache[key] = Q.red([a + b for a, b in zip(x, s_)])
        return nxt_cache[key]
    K = list(Per)
    for a_, b_ in itertools.combinations(range(4), 2):
        nodes = [x for x in reps if col[x] in (a_, b_)]
        pot = {}
        for root in nodes:
            if root in pot:
                continue
            pot[root] = root
            comp = [root]
            front = [root]
            while front:
                nxt = []
                for x in front:
                    for u, su in steps:
                        y = step(x, su)
                        if col[y] in (a_, b_) and y not in pot:
                            pot[y] = tuple(p + q for p, q in zip(pot[x], u))
                            comp.append(y)
                            nxt.append(y)
                front = nxt
            V = []
            seen = set()
            for x in comp:
                px = pot[x]
                for u, su in steps:
                    y = step(x, su)
                    if col[y] in (a_, b_):
                        g = tuple(p + q - s2 for p, q, s2 in zip(px, u, pot[y]))
                        if any(g) and g not in seen:
                            seen.add(g)
                            V = span_add(V, g, r)
            K = intersect(K, V, r) if V else []
            if not K:
                break
        if not K:
            break
    need(same(K, [tuple(k) for k in KPer_stated], r) if K or KPer_stated else True, 'KPER_MISMATCH',
         f'{label}: KPer recomputed as {invariant_factors(K, r)}, stated {invariant_factors(hnf([tuple(k) for k in KPer_stated], r), r)}')
    if verbose:
        log(f'      {label}: proper, Lambda/Per = {invariant_factors(Per, r)}, Lambda/KPer = {invariant_factors(K, r)}')
    return Per, K


def steps_i_ii(tag, L, rows, stated_P, log, prefix=''):
    files = colouring_files()
    r = L['r']
    ana = [d for d in rows if d['key'].startswith(f'{prefix}analyse:')]
    need(ana, 'NO_COLOURINGS', tag)
    Pf = None
    t0 = time.time()
    for d in ana:
        sha = d['colouring_sha']
        need(sha in files, 'COLOURING_MISSING', f'{tag}: the analysed colouring {sha} has no file under colourings/')
        cf = ColouringFile(files[sha], r, sha)
        Per, K = check_colouring(L, cf, d['Per'], d['KPer'], f'{tag}:{sha}', log)
        Pf = K if Pf is None else intersect(Pf, K, r)
    need(same(Pf, [tuple(p) for p in stated_P], r), 'P_FOUND_MISMATCH',
         f'{tag}: the intersection of KPer is {invariant_factors(Pf, r)}; stated {invariant_factors(hnf([tuple(p) for p in stated_P], r), r)}')
    log(f'  (i)+(ii) {tag}: {len(ana)} colourings, each proper, each Per(c) exact, each KPer(c) recomputed and equal to the stated one '
        f'({time.time() - t0:.1f} s); P_found = intersection of KPer = the stated P_found: rank {len(Pf)}, '
        f'Lambda/P_found = {invariant_factors(Pf, r)}')
    return Pf


# ================================================================ step (iii): F_known

def z_to_point(Z):
    """de Grey's lattice: the certificate's Z = [a, b, c, d] = (a + b zeta6 + c w + d zeta6 w)/9 as an integer 8-vector over M = 36 on
    (1, sqrt3, sqrt11, sqrt33) for x and y: zeta6 = (1 + i sqrt3)/2, w = (1 + i sqrt11)/2, zeta6 w = (1 - sqrt33 + i sqrt3 + i sqrt11)/4"""
    a, b, c, d = Z
    return (4 * a + 2 * b + 2 * c + d, 0, 0, -d, 0, 2 * b + d, 2 * c + d, 0)


def rot_zeta6(F, v, M):
    """multiplication by zeta6 = (1 + i sqrt3)/2 of a point over M; exact (asserts the halving is integral)"""
    n = F.n
    x, y = v[:n], v[n:]
    s3 = [0, 1, 0, 0]
    x2 = [p - q for p, q in zip(x, F.mul(y, s3))]
    y2 = [p + q for p, q in zip(F.mul(x, s3), y)]
    need(all(t % 2 == 0 for t in x2 + y2), 'ROTATION', 'zeta6 does not preserve the lattice denominator')
    return tuple(t // 2 for t in x2 + y2)


def step_iii_K(L, stated_F, log, run_cert):
    F, M, H, r = L['F'], L['M'], L['H'], L['r']
    need(F.rad == [3, 11] and M == 36, 'NOT_DEGREY', 'step (iii) at K expects de Grey\'s lattice over Q(sqrt3, sqrt11), M = 36')
    wit = json.load(open(CERT_WITNESS))
    Z = wit['pair_difference_Z']
    v8 = z_to_point(Z)
    need(is_unit(F, v8, M) is False, 'PAIR_IS_EDGE', 'the certified pair is at distance 1')
    v = coords(H, v8, 8)
    need(v is not None, 'V_OUTSIDE', 'the certified difference is not in Lambda')
    orbit = set()
    front = [v8]
    seen = {v8}
    while front:
        nxt = []
        for p in front:
            for q in (rot_zeta6(F, p, M), tuple(p[:4]) + tuple(-t for t in p[4:])):
                if q not in seen:
                    seen.add(q)
                    nxt.append(q)
        front = nxt
    Fk = hnf([tuple(coords(H, p, 8)) for p in seen], r)
    need(same(Fk, [tuple(f) for f in stated_F], r), 'F_KNOWN_MISMATCH',
         f'the orbit span is {invariant_factors(Fk, r)}; stated {invariant_factors(hnf([tuple(f) for f in stated_F], r), r)}')
    sha = hashlib.sha256(open(CERT_WITNESS, 'rb').read()).hexdigest()
    log(f'  (iii) degrey: the certificate witness ({os.path.relpath(CERT_WITNESS, ROOT)}, sha256 {sha[:16]}...) certifies the pair '
        f'difference Z = {Z}, i.e. v = {tuple(v)} in lattice coordinates; its orbit under zeta6 and conjugation has {len(seen)} '
        f'elements and spans Lambda/F_known = {invariant_factors(Fk, r)} = the stated F_known')
    if run_cert:
        t0 = time.time()
        p = subprocess.run([sys.executable, os.path.join(ROOT, 'tools', 'fs73_cert_check.py'), CERT_WITNESS], capture_output=True,
                           text=True)
        last = (p.stdout.strip().splitlines() or [''])[-1]
        need(p.returncode == 0 and 'CERTIFIED' in p.stdout, 'CERTIFICATE', f'tools/fs73_cert_check.py: {last}')
        log(f'  (iii) tools/fs73_cert_check.py on the witness: {last} ({time.time() - t0:.0f} s)')
    else:
        log('  (iii) the LRAT certificate itself: run  python3 tools/fs73_cert_check.py ' + os.path.relpath(CERT_WITNESS, ROOT) +
            '   (or pass --cert here)')
    return Fk


# ================================================================ step (iv): the solver claims, on this file's own encoding

def solver_ask(L, W, target, solver, budget, gap=False):
    """is there a proper 4-colouring of Cay(Lambda/W, U mod W) [with c(target) != c(0)]?  Own encoding: classes by Hermite reduction;
    x(v, k) = 4 v + k + 1; at-least-one per vertex; one clause per edge and colour; the origin pinned to 0, its least neighbour to 1
    (sound: a colour permutation fixing 0 moves any neighbour's colour to 1, and 'c(target) != c(0)' is invariant under it)"""
    r, U = L['r'], L['U']
    Q = HermiteQuotient(W, r)
    reps = Q.reps()
    ix = {x: i for i, x in enumerate(reps)}
    steps = sorted({Q.red(u) for u in U})
    need(tuple([0] * r) not in steps, 'W_INADMISSIBLE', 'a unit vector lies in W')
    edges = set()
    for x in reps:
        i = ix[x]
        for s in steps:
            j = ix[Q.red([a + b for a, b in zip(x, s)])]
            edges.add((min(i, j), max(i, j)))
    o = ix[tuple([0] * r)]
    nb = ix[steps[0]]
    cl = [[4 * v + k + 1 for k in range(4)] for v in range(len(reps))]
    for i, j in sorted(edges):
        for k in range(4):
            cl.append([-(4 * i + k + 1), -(4 * j + k + 1)])
    cl += [[4 * o + 1], [4 * nb + 2]]
    if target is not None:
        cl.append([-(4 * ix[Q.red(target)] + 1)])
    if gap:
        # a gapped colouring, translated so the gap sits at the origin: with 0 and its least neighbour pinned to 0 and 1, the missing
        # colour is 2 or 3, and the swap of 2 and 3 fixes both pins, so 'colour 3 is absent from the closed neighbourhood' is sound
        cl += [[-(4 * o + 4)]] + [[-(4 * ix[s_] + 4)] for s_ in steps]
    fd, path = tempfile.mkstemp(suffix='.cnf')
    with os.fdopen(fd, 'w') as f:
        f.write(f'p cnf {4 * len(reps)} {len(cl)}\n')
        f.write(''.join(' '.join(map(str, c)) + ' 0\n' for c in cl))
    t0 = os.times()
    try:
        p = subprocess.run([solver, '-q', path], capture_output=True, text=True, timeout=budget)
        status = next((ln[2:].strip() for ln in p.stdout.splitlines() if ln.startswith('s ')), None)
        verdict = {'SATISFIABLE': 'SAT', 'UNSATISFIABLE': 'UNSAT'}.get(status, 'UNKNOWN')
    except subprocess.TimeoutExpired:
        verdict = 'UNKNOWN'
    finally:
        os.remove(path)
    t1 = os.times()
    return verdict, round((t1.children_user - t0.children_user) + (t1.children_system - t0.children_system), 2), len(reps)


def step_iv(tag, L, rows, solver, budget, max_classes, log, prefix=''):
    r = L['r']
    asks = [d for d in rows if d['key'].startswith(prefix) and d.get('verdict') == 'UNSAT' and d.get('W') and
            (':sep:' in d['key'] or d['key'].endswith(':plain') or d.get('aim') == 'gap')]
    done = skipped = 0
    for d in asks:
        W = [tuple(w) for w in d['W']]
        n = index_of(hnf(W, r), r)
        if n > max_classes:
            skipped += 1
            log(f'      (iv) {d["key"]}: {n:,} classes > --max-classes: NOT re-asked (the writer\'s UNSAT, CNF sha256 '
                f'{d.get("cnf_sha256", "?")[:16]}..., stands unchecked here)')
            continue
        target = d.get('target') if ':sep:' in d['key'] else None
        v, cpu, nn = solver_ask(L, W, tuple(target) if target else None, solver, budget, gap=d.get('aim') == 'gap')
        need(v == 'UNSAT', 'SOLVER_DISAGREES' if v == 'SAT' else 'SOLVER_UNDECIDED',
             f'{d["key"]}: {solver} on this file\'s encoding answers {v} ({cpu} s)')
        done += 1
        log(f'      (iv) {d["key"]}: UNSAT on the independent encoding ({nn:,} classes, {cpu} s CPU, {solver})')
    log(f'  (iv) {tag}: {done} UNSAT claims re-asked and confirmed; {skipped} above the class cap, listed above')


# ================================================================ the named targets (real and imaginary points), re-derived here

TARGETS = {'degrey': {'2': ((2, 0, 0, 0), (0, 0, 0, 0), 1), '4': ((4, 0, 0, 0), (0, 0, 0, 0), 1),
                      '8/3': ((8, 0, 0, 0), (0, 0, 0, 0), 3), '8/9': ((8, 0, 0, 0), (0, 0, 0, 0), 9)},
           'rich': {'2': ((2, 0, 0, 0), (0, 0, 0, 0), 1), '2/3': ((2, 0, 0, 0), (0, 0, 0, 0), 3), '4/3': ((4, 0, 0, 0), (0, 0, 0, 0), 3),
                    '8/3': ((8, 0, 0, 0), (0, 0, 0, 0), 3), '4': ((4, 0, 0, 0), (0, 0, 0, 0), 1), '4/7': ((4, 0, 0, 0), (0, 0, 0, 0), 7),
                    '4/sqrt3': ((0, 4, 0, 0), (0, 0, 0, 0), 3), 'isqrt3': ((0, 0, 0, 0), (0, 1, 0, 0), 1)}}


def targets_in(L, P, which, log, tag):
    M, H, r = L['M'], L['H'], L['r']
    out = {}
    for nm, (x4, y4, den) in TARGETS[which].items():
        need(M % den == 0, 'TARGET_DENOMINATOR', nm)
        v8 = tuple(t * (M // den) for t in tuple(x4) + tuple(y4))
        c = coords(H, v8, 2 * L['F'].n)
        out[nm] = None if c is None else member(P, c, r)
    log(f'      targets in P_found ({tag}): ' + ', '.join(f'{k}: {"not in Lambda" if v is None else ("IN" if v else "out")}'
                                                        for k, v in out.items()))
    return out


# ================================================================ the census

def stated_K():
    s = json.load(open(os.path.join(CENSUS, 'K-sandwich.json')))
    return s['P_found']['generators'], s['F_known']['generators']


def stated_rich(rows, tag):
    sw = [d for d in rows if d['key'].startswith(f'{tag}|sandwich:')]
    need(sw, 'NO_SANDWICH', tag)
    s = sw[-1]
    return s['P_found']['generators'], s['F_known']['generators']


def run(only, solver, budget, max_classes, run_cert, no_solver, log=print):
    t0 = time.time()
    if 'degrey' in only:
        L = step0('degrey', log)
        rows = load_rows('K-rows.jsonl')
        P_st, F_st = stated_K()
        Pf = steps_i_ii('degrey', L, rows, P_st, log)
        Fk = step_iii_K(L, F_st, log, run_cert)
        r = L['r']
        need(all(member(Pf, f, r) for f in Fk), 'F_NOT_IN_P', 'F_known is not inside P_found')
        targets_in(L, Pf, 'degrey', log, 'degrey')
        log(f'  SANDWICH degrey (checked): F_known (Lambda/F_known = {invariant_factors(Fk, r)}) <= F <= P <= P_found (Lambda/P_found = '
            f'{invariant_factors(Pf, r)}); ' + ('F_known = P_found, so F = P: C3-inherit holds at de Grey\'s lattice'
                                               if same(Fk, Pf, r) else 'the gap P_found/F_known is open'))
        if not no_solver:
            step_iv('degrey', L, rows, solver, budget, max_classes, log)
    rich = [t for t in ('tu14', 'tu30', 'tu42') if t in only]
    if rich:
        rrows = load_rows('rich-rows.jsonl')
        for tag in rich:
            L = step0(tag, log)
            P_st, F_st = stated_rich(rrows, tag)
            Pf = steps_i_ii(tag, L, rrows, P_st, log, prefix=f'{tag}|')
            r = L['r']
            need(not F_st, 'F_KNOWN_UNBACKED', f'{tag}: F_known is stated nonzero but no certificate exists for the rich lattices')
            log(f'  (iii) {tag}: F_known = 0 as stated (no certified forced vector on this lattice)')
            targets_in(L, Pf, 'rich', log, tag)
            log(f'  SANDWICH {tag} (checked, GENERATOR graph): 0 = F_known <= F <= P <= P_found, Lambda/P_found = {invariant_factors(Pf, r)}')
            if not no_solver:
                step_iv(tag, L, rrows, solver, budget, max_classes, log, prefix=f'{tag}|')
    log(f'CENSUS VERIFIED ({", ".join(only)}; {time.time() - t0:.0f} s)')


# ================================================================ planted faults

def controls():
    """each plant must be refused for its own reason; the faithful twin must pass.  The bed is the smallest analysed colouring of de
    Grey's lattice whose period group is strictly larger than its W (so a hidden period exists to hide), which runs in seconds."""
    quiet = lambda *a: None
    L = step0('degrey', quiet)
    r = L['r']
    rows = load_rows('K-rows.jsonl')
    files = colouring_files()
    cands = []
    for d in rows:
        if d['key'].startswith('analyse:') and d['colouring_sha'] in files:
            doc = json.load(gzip.open(files[d['colouring_sha']], 'rt'))
            nW = index_of(hnf([tuple(w) for w in doc['W']], r), r)
            nP = index_of(hnf([tuple(p) for p in d['Per']], r), r)
            if nP < nW:
                cands.append((nW, d['colouring_sha'], d, doc))
    need(cands, 'NO_BED', 'no analysed colouring has Per strictly larger than W')
    nW, sha, d, doc = min(cands, key=lambda t: (t[0], t[1]))
    print(f'  bed: colouring {sha} ({nW} classes; Lambda/Per = {invariant_factors(hnf([tuple(p) for p in d["Per"]], r), r)})')
    results = []

    def attempt(name, expect, fn):
        try:
            fn()
            got = 'PASS'
        except Refusal as e:
            got = e.code
        ok = got == expect
        results.append(ok)
        print(f'  [{"ok " if ok else "FAIL"}] {name}: expected {expect}, got {got}')

    def cf_of(doc_):
        return ColouringFile('bed', r, None, doc_)

    def faithful():
        check_colouring(L, cf_of(doc), d['Per'], d['KPer'], 'twin', quiet)

    def improper():
        # recolour one whole coset of Per (so every stated period survives) with the colour of a neighbouring coset
        cf = cf_of(doc)
        Per = hnf([tuple(p) for p in d['Per']], r)
        Q = HermiteQuotient(Per, r)
        x = Q.reps()[1]
        y = Q.red([a + b for a, b in zip(x, L['U'][0])])
        newc = str(cf.col[cf.idx(y)])
        cl = list(doc['colouring'])
        for z in HermiteQuotient(cf.W, r).reps():
            if Q.red(z) == x:
                cl[cf.idx(z)] = newc
        check_colouring(L, cf_of(dict(doc, colouring=''.join(cl))), d['Per'], d['KPer'], 'improper', quiet)

    def false_period():
        Per = hnf([tuple(p) for p in d['Per']], r)
        t = HermiteQuotient(Per, r).reps()[1]               # a nonzero class of Lambda/Per: not a period, since Per is exact
        check_colouring(L, cf_of(doc), list(Per) + [t], d['KPer'], 'false-period', quiet)

    def hidden_period():
        check_colouring(L, cf_of(doc), doc['W'], d['KPer'], 'hidden-period', quiet)     # Per stated as W, strictly too small

    def kper_wrong():
        check_colouring(L, cf_of(doc), d['Per'], [tuple(2 * x for x in k) for k in d['KPer']], 'kper', quiet)

    def not_unit():
        bad = json.loads(json.dumps(L['d']))
        bad['U'][0] = [a + b for a, b in zip(bad['U'][0], bad['H'][0])]         # moved by one lattice step: still in Lambda
        step0('degrey', quiet, doc=bad)

    def fknown_wrong():
        _, F_st = stated_K()
        step_iii_K(L, [tuple(2 * x for x in f) for f in F_st], quiet, False)

    attempt('the faithful twin', 'PASS', faithful)
    attempt('a Per-coset recoloured to its neighbour\'s colour', 'IMPROPER', improper)
    attempt('a false period stated', 'PERIOD_FALSE', false_period)
    attempt('a true period hidden (Per stated as W)', 'PER_NOT_EXACT', hidden_period)
    attempt('KPer stated as 2 KPer', 'KPER_MISMATCH', kper_wrong)
    attempt('a unit vector of the lattice file moved by one lattice step', 'NOT_UNIT', not_unit)
    attempt('F_known stated as 2 F_known', 'F_KNOWN_MISMATCH', fknown_wrong)
    ok = all(results)
    print('CONTROLS PASSED' if ok else 'CONTROLS FAILED')
    return 0 if ok else 1


def main():
    argv = sys.argv[1:]
    if '--controls' in argv:
        return controls()
    get = lambda k, dflt: argv[argv.index(k) + 1] if k in argv else dflt
    only = get('--only', 'degrey,tu14,tu30,tu42').split(',')
    try:
        run(only, get('--solver', 'kissat'), int(get('--budget', '600')), int(get('--max-classes', '100000')), '--cert' in argv,
            '--no-solver' in argv)
    except Refusal as e:
        print(f'REFUSED {e.code}: {e.detail}')
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
