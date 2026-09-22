#!/usr/bin/env python3
"""fs70_fabric -- lattices of unit vectors over F = Q(sqrt3, sqrt5), their saturation (every unit vector the lattice
holds), the 3-adic gate, the additive four-colouring screen with its forced sublattice, the three fabric shapes
(Harder words, Haugland lenses, Minkowski balls) and the CNF of every pin the screen allows.  UNTRUSTED (tools/).

ARITHMETIC.  Inside one lattice everything is an INTEGER 8-tuple over the lattice denominator M (plan section 3.7:
Fraction arithmetic blew 5.8 GB on a depth-8 word ball).  Addition is tuple addition, a hash is a tuple, and the
exact unit test happens once per lattice (on the saturation) rather than once per pair.

SATURATION, two methods (plan section 3.2).
  B (default, and complete BY CONSTRUCTION): Lambda is inside (1/M)Z^8, so every unit vector of Lambda has
    coordinate denominator dividing M; `fs70_field.units_over(M)` enumerates exactly those and lattice membership
    filters.  Cost is the box of M, which is tiny for every lattice this milestone uses (M <= 120).
  A (cross-check): PARI's qfminim on the trace form B(l,m) = Tr(x x' + y y'), for which a unit vector has
    B(l,l) = 4; gp enumerates the vectors of norm <= 4 exactly and the exact test decides.  Overflows a 4 GB stack
    on a dense lattice (`zeta12+u3+rho15`), which is why B is the default -- the plan had it the other way round.
  `--sat-method both` runs both and asserts they agree: two independent enumerations are the real control.

THE 3-ADIC GATE (plan section 3.1).  A lattice all of whose unit vectors are 3-units maps homomorphically into
UD(F_9^2), which is 3-colourable, and a 3-colourable graph carries no four-colour pair compulsion.  So a lattice
with no unit vector of nonzero 3-depth is DEAD and must not be asked.  The gate reports pass/fail and names the
3-non-unit that passes it.

THE ADDITIVE SCREEN (plan section 3.4; CLAUDE.md G41).  An additive 4-colouring of Lambda is a homomorphism phi to
a group of order 4 (Z/4 or the Klein group) nonzero on every unit vector of Lambda; it four-colours every finite
graph drawn in Lambda.  So if some phi has phi(delta) != 0 there is no forced-equal pair at delta in Lambda, and if
some phi has phi(delta) = 0 there is no virtual edge at delta.  The screen's product is a SUBLATTICE, not four
booleans: Lambda_forced = intersection over all proper phi of ker phi, with 4 Lambda contained in it; a
forced-equal pair at delta is additively allowed iff delta lies in Lambda_forced.

Commands
  python3 tools/fs70_fabric.py --selftest [--plants]
  python3 tools/fs70_fabric.py lattice SPEC...            # saturation, gate, screen, Lambda_forced, targets
  python3 tools/fs70_fabric.py screen SPEC... [--out F]   # the same, one jsonl row per lattice
  python3 tools/fs70_fabric.py survivors SPEC [--target D] # the additive colourings that kill a target, described
  python3 tools/fs70_fabric.py word SPEC k [--out DIR] [--target D] [--core m]
  python3 tools/fs70_fabric.py wordunion SPEC k --target D [--out DIR] [--core m]   # the balls about 0 AND D
  python3 tools/fs70_fabric.py tn SPEC n [--out DIR] [--target D] [--core m]
  python3 tools/fs70_fabric.py ball SPEC R [--out DIR] [--core m]
options: --sat-method a|b|both (default b), --plant NAME, --no-cnf (graph.json alone; fs70_ask.py builds the CNF)

Generator grammar (SPEC): family names joined by '+' -- zeta12, u3, v4, w4, rho15, q5, s5, q7, s7, d6 (each the
zeta12-and-conjugation orbit of the named vector) -- and group:u3:k for Harder's S_k = {zeta12^m u^n, |n| <= k}.
Two spellings of one lattice give one HNF and one identity sha; a record stores both.

Planted faults (--plant): basis_drop (the last generator is dropped before the HNF), sat_generators (the
saturation returns the generators only), screen_partial (the screen tests only the first unit vector).
"""
from collections import defaultdict
from fractions import Fraction as Fr
import hashlib
import itertools
import json
import math
import os
import subprocess
import sys
import time

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs70_field as FF                                                          # noqa: E402
from fs70_field import (ONE, ZERO, E_ZERO, E_ONE, ZETA6, ZETA12, I_SQRT3, U_SQRT5, V_SQRT15, W_MIX, RHO15,
                        canonical, depths, e_add, e_conj, e_denominator, e_is_unit_vector, e_mul, e_neg, e_sub,
                        e_pow, e_scale, e_str, e_to_ints, e_from_ints, f_scale, ints_over, ints_reduce,
                        ints_float, real_scalar, units_over)                     # noqa: E402

PLANT = None


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- families of unit vectors

def orbit(z):
    """the <= 24 vectors zeta12^k z and zeta12^k conj(z) (closed under negation, since zeta12^6 = -1)"""
    out = {}
    for k in range(12):
        for w in (z, e_conj(z)):
            r = e_mul(e_pow(ZETA12, k), w)
            out[canonical(r)] = r
    return list(out.values())


# ((sqrt3 + sqrt15) + i(-sqrt3 + sqrt15))/6: the cheapest 3-depth +-1 family (atlas row, denominator 6)
D6 = ((Fr(0), Fr(1, 6), Fr(0), Fr(1, 6)), (Fr(0), Fr(-1, 6), Fr(0), Fr(1, 6)))
Q5 = ((Fr(3, 5), Fr(0), Fr(0), Fr(0)), (Fr(4, 5), Fr(0), Fr(0), Fr(0)))           # (3 + 4i)/5
S5V = ((Fr(0), Fr(0), Fr(2, 5), Fr(0)), (Fr(0), Fr(0), Fr(1, 5), Fr(0)))          # (2 sqrt5 + i sqrt5)/5
Q7 = ((Fr(1, 7), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(4, 7), Fr(0), Fr(0)))           # (1 + 4 i sqrt3)/7
S7V = ((Fr(2, 7), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(3, 7), Fr(0)))          # (2 + 3 i sqrt5)/7

FAMILY_SEED = {'zeta12': E_ONE, 'u3': U_SQRT5, 'v4': V_SQRT15, 'w4': W_MIX, 'rho15': RHO15,
               'q5': Q5, 's5': S5V, 'q7': Q7, 's7': S7V, 'd6': D6}
FAMILIES = {nm: orbit(z) for nm, z in FAMILY_SEED.items()}
for _nm, _fam in FAMILIES.items():
    for _z in _fam:
        assert e_is_unit_vector(_z), (_nm, e_str(_z))


def generators(spec):
    """the generator list of a SPEC.  Raises with the grammar on an unknown name (never silent)."""
    S = {}
    for part in spec.split('+'):
        if part.startswith('twounits:') or part.startswith('threeunits:'):
            kind, D = part.split(':')
            for M in range(1, int(D) + 1):
                for z in FF.units_of_denominator(M):
                    keep = FF.is_two_unit(z) if kind == 'twounits' else FF.is_three_unit(z)
                    if keep:
                        S[canonical(z)] = z
        elif part.startswith('group:'):
            _, nm, k = part.split(':')
            if nm not in FAMILY_SEED:
                raise SystemExit(f'unknown family {nm!r} in {part!r}.\n'
                                 f'grammar: names joined by "+" from {", ".join(sorted(FAMILY_SEED))}, '
                                 f'or group:NAME:k for {{zeta12^m NAME^n, |n| <= k}}')
            base = FAMILY_SEED[nm]
            for n in range(-int(k), int(k) + 1):
                for m in range(12):
                    z = e_mul(e_pow(ZETA12, m), e_pow(base, n))
                    S[canonical(z)] = z
        elif part in FAMILIES:
            for z in FAMILIES[part]:
                S[canonical(z)] = z
        else:
            raise SystemExit(f'unknown family {part!r}.\n'
                             f'grammar: names joined by "+" from {", ".join(sorted(FAMILY_SEED))}, '
                             f'or group:NAME:k for {{zeta12^m NAME^n, |n| <= k}}')
    return list(S.values())


# ---------------------------------------------------------------- integer lattices in F^2 = Q^8

def to_vec8(z):
    return tuple(z[0]) + tuple(z[1])


def hnf(rows, dim=8):
    """row Hermite normal form of the Z-span of integer vectors (pivot columns increasing)"""
    work = [list(r) for r in rows if any(r)]
    basis = []
    for col in range(dim):
        while len([r for r in work if r[col]]) > 1:
            nz = sorted((r for r in work if r[col]), key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(dim):
                    r[j] -= q * p[j]
            work = [r for r in work if any(r)]
        k = next((i for i, r in enumerate(work) if r[col]), None)
        if k is None:
            continue
        p = work.pop(k)
        if p[col] < 0:
            p = [-x for x in p]
        basis.append((col, p))
    for i in range(len(basis)):
        ci, pi = basis[i]
        for k in range(i):
            pk = basis[k][1]
            q = pk[ci] // pi[ci]
            if q:
                for j in range(dim):
                    pk[j] -= q * pi[j]
    return [tuple(r) for _, r in basis]


def _log10_int(n):
    if n == 0:
        return -math.inf
    s = str(abs(n))
    return (len(s) - 1) + math.log10(float('0.' + s[:17]) * 10)


def bareiss_det(Aint):
    """exact integer determinant by fraction-free Gaussian elimination"""
    A = [list(r) for r in Aint]
    n = len(A)
    if n == 0:
        return 1
    sign = 1
    prev = 1
    for k in range(n - 1):
        if A[k][k] == 0:
            piv = next((i for i in range(k + 1, n) if A[i][k] != 0), None)
            if piv is None:
                return 0
            A[k], A[piv] = A[piv], A[k]
            sign = -sign
        for i in range(k + 1, n):
            for j in range(k + 1, n):
                A[i][j] = (A[i][j] * A[k][k] - A[i][k] * A[k][j]) // prev
        prev = A[k][k]
    return sign * A[n - 1][n - 1]


def coords_in_basis(H, v, dim=8):
    """integer coordinates of v in the HNF basis H, or None"""
    v = list(v)
    cs = []
    for row in H:
        c = next(j for j in range(dim) if row[j])
        if v[c] % row[c]:
            return None
        q = v[c] // row[c]
        cs.append(q)
        if q:
            for j in range(dim):
                v[j] -= q * row[j]
    return tuple(cs) if not any(v) else None


class Lattice:
    """The Z-span of a set of unit vectors, as an integer lattice over one denominator M."""

    def __init__(self, S, spec=None):
        self.spec = spec
        self.S = list(S)
        self.M = 1
        for z in self.S:
            d = e_denominator(z)
            self.M = self.M * d // math.gcd(self.M, d)
        rows = [ints_over(e_to_ints(z), self.M) for z in self.S]
        self.H = hnf(rows)
        if planted('basis_drop'):
            self.H = self.H[:-1]               # PLANT: the basis loses a row, so it no longer spans
        self.rank = len(self.H)
        self.basis = [e_from_ints(ints_reduce(row, self.M)) for row in self.H]
        # steps (the saturation) are filled in by saturate()
        self.units = None
        self.unit_vec8 = None
        self.sat_complete = None

    # -- identity
    def key(self):
        return f'{self.M}|' + ';'.join(','.join(str(x) for x in r) for r in self.H)

    def sha(self):
        return hashlib.sha256(self.key().encode()).hexdigest()[:16]

    # -- membership
    def contains_vec8(self, v8):
        return coords_in_basis(self.H, v8) is not None

    def contains(self, z):
        d = e_denominator(z)
        if self.M % d:
            return False
        return self.contains_vec8(ints_over(e_to_ints(z), self.M))

    def coords(self, z):
        d = e_denominator(z)
        if self.M % d:
            return None
        return coords_in_basis(self.H, ints_over(e_to_ints(z), self.M))

    def vec8(self, z):
        d = e_denominator(z)
        assert self.M % d == 0, (e_str(z), self.M)
        return ints_over(e_to_ints(z), self.M)

    # -- the trace form and the covolume
    def gram(self):
        G = []
        for bi in self.basis:
            row = []
            for bj in self.basis:
                s = FF.f_add(FF.f_mul(bi[0], bj[0]), FF.f_mul(bi[1], bj[1]))
                row.append(FF.f_trace(s))
            G.append(row)
        return G

    def gram_int(self):
        """M^2 * Gram, an integer matrix: the basis rows are integers over M, so M^2 B(b_i, b_j) = Tr of a product
        of integral elements, an integer."""
        G = []
        for ri in self.H:
            row = []
            for rj in self.H:
                xi, yi = (tuple(Fr(q) for q in ri[:4]), tuple(Fr(q) for q in ri[4:]))
                xj, yj = (tuple(Fr(q) for q in rj[:4]), tuple(Fr(q) for q in rj[4:]))
                s = FF.f_add(FF.f_mul(xi, xj), FF.f_mul(yi, yj))
                t = FF.f_trace(s)
                assert t.denominator == 1, t
                row.append(int(t))
            G.append(row)
        return G

    def covolume(self):
        """sqrt(det of the trace-form Gram) -- the covolume of the Minkowski embedding into R^8.  Exact integer
        determinant (Bareiss) divided by M^rank, so it survives an astronomically large denominator."""
        det = bareiss_det(self.gram_int())
        assert det > 0, det
        try:
            return math.sqrt(det) / self.M ** self.rank
        except OverflowError:
            return float('inf')

    def log10_covolume(self):
        det = bareiss_det(self.gram_int())
        return 0.5 * _log10_int(det) - self.rank * math.log10(self.M)

    # -- saturation
    def saturate(self, method='b'):
        """`method` = 'b' (default, complete), 'a' (gp cross-check), 'both' (agree or raise), or 'gens' (the
        GENERATOR set only -- an incomplete constraint set, used where M is astronomical).  With 'gens' the screen's
        proper counts are UPPER bounds: "no additive colouring exists" stays sound, and a kill does NOT."""
        self.sat_complete = method != 'gens'
        if method == 'gens':
            units = list(self.S)
            for z in units:
                assert e_is_unit_vector(z) and self.contains(z)
            self.units = units
            self.unit_vec8 = [self.vec8(z) for z in units]
            return units
        if method == 'both':
            ub = self._sat_b()
            ua = self._sat_a()
            ka, kb = {canonical(z) for z in ua}, {canonical(z) for z in ub}
            assert ka == kb, (f'the two saturation methods disagree: A found {len(ka)}, B found {len(kb)}, '
                              f'symmetric difference {len(ka ^ kb)}')
            units = ub
        elif method == 'a':
            units = self._sat_a()
        else:
            units = self._sat_b()
        if planted('sat_generators'):
            units = list(self.S)               # PLANT: the generators pass for the whole saturation
        for z in units:                        # every returned vector really is a unit vector of the lattice
            assert e_is_unit_vector(z), e_str(z)
            assert self.contains(z), f'saturation returned {e_str(z)}, which is not in the lattice'
        self.units = units
        self.unit_vec8 = [self.vec8(z) for z in units]
        return units

    # method B is affordable while the embedding box fits in memory: 90 bytes and 2.3 us per element, so
    # 3e7 is about 2.7 GB and a minute.  Above that the enumeration is refused BY NAME rather than truncated
    # silently -- a truncated saturation would make the additive screen's kills unsound (a colouring proper on a
    # subset of the unit vectors is not a colouring), while leaving "no additive colouring exists" sound.
    SAT_B_BOX_CAP = 3e7

    def sat_b_cost(self):
        return FF.box_estimate(self.M)

    def _sat_b(self):
        """method B: every unit vector of denominator dividing M, filtered by membership.  Complete."""
        if self.sat_b_cost() > self.SAT_B_BOX_CAP:
            raise SystemExit(
                f'saturation method B on {self.spec} needs the embedding box of M = {self.M}, about '
                f'{self.sat_b_cost():.3g} elements (~{self.sat_b_cost()*90/2**30:.0f} GB, '
                f'~{self.sat_b_cost()/4.6e5/60:.0f} min) -- above the cap {self.SAT_B_BOX_CAP:.0g}.  '
                f'Split the lattice (one extra family at a time keeps M small), or try --sat-method a, which '
                f'costs about {1039/max(self.covolume(), 1e-12):.3g} lattice vectors in gp.')
        out = []
        for v8 in units_over(self.M):
            if self.contains_vec8(v8):
                out.append(e_from_ints(ints_reduce(v8, self.M)))
        return out

    def _sat_a(self):
        """method A: qfminim on the trace form at norm 4, filtered by the four embeddings then decided exactly."""
        G = self.gram()
        L = 1
        for row in G:
            for q in row:
                L = L * q.denominator // math.gcd(L, q.denominator)
        Gi = [[int(q * L) for q in row] for row in G]
        mat = '[' + ';'.join(','.join(str(x) for x in row) for row in Gi) + ']'
        emb_rows = []
        for (x, y) in self.basis:
            row = []
            for s3 in (FF.S3F, -FF.S3F):
                for s5 in (FF.S5F, -FF.S5F):
                    row.append(repr(FF.f_float(x, s3, s5)))
                    row.append(repr(FF.f_float(y, s3, s5)))
            emb_rows.append(','.join(row))
        emb = '[' + ';'.join(emb_rows) + ']'
        script = (f'G = {mat}; Emb = {emb}; v = qfminim(G, {4 * L}, , 2); n = 0; '
                  f'for(k=1, #v[3], w = v[3][,k]~ * Emb; ok = 1; for(t=0,3, if(abs(w[2*t+1]^2 + w[2*t+2]^2 - 1) > 1e-6, ok = 0)); '
                  f'if(ok, n++; print(Vec(v[3][,k])))); print("count ", n)')
        out = subprocess.run(['gp', '-q', '-s', '4000000000'], input=script + '\n', capture_output=True, text=True)
        if out.returncode != 0 or 'count' not in out.stdout:
            raise RuntimeError('method A (gp qfminim) failed -- use --sat-method b.  gp said: '
                               + (out.stderr[-600:] or out.stdout[-600:]))
        units = {}
        for line in out.stdout.strip().split('\n'):
            if line.startswith('count'):
                continue
            c = [int(x) for x in line.strip('[] \n').split(',')]
            for sign in (1, -1):
                z = E_ZERO
                for ci, b in zip(c, self.basis):
                    if ci:
                        z = e_add(z, e_scale(sign * ci, b))
                if e_is_unit_vector(z):
                    units[canonical(z)] = z
        return list(units.values())

    # -- the 3-adic gate
    def gate(self):
        """(passes, witness, counts): a lattice passes when its saturation holds a unit vector of nonzero 3-depth."""
        assert self.units is not None, 'saturate() first'
        best = None
        n_non = 0
        for z in self.units:
            d3 = depths(z)[1]
            if d3 != 0:
                n_non += 1
                if best is None or e_denominator(z) < e_denominator(best):
                    best = z
        return (best is not None, best, {'three_non_units': n_non, 'three_units': len(self.units) - n_non})


# ---------------------------------------------------------------- the additive screen and Lambda_forced

def _coord_matrix(lat, zs):
    C = []
    for z in zs:
        c = lat.coords(z)
        assert c is not None, e_str(z)
        C.append(c)
    return np.array(C, dtype=np.int64)


def all_vectors_mod(q, rank):
    """every vector of (Z/q)^rank, as rows (q^rank x rank); rank <= 8 so this is at most 65536 x 8"""
    return np.array(list(itertools.product(range(q), repeat=rank)), dtype=np.int64)


def additive_screen(lat, targets, chunk=8192):
    """Every proper additive 4-colouring of the lattice, in both groups of order 4, and Lambda_forced.

    Z/4: a hom is a coefficient vector a in (Z/4)^rank, phi(c) = a.c mod 4; proper iff a.c(z) != 0 for every unit
    vector z.  Klein: a hom is a PAIR (b, c) of (Z/2)^rank functionals, phi(v) = (b.v, c.v) mod 2; proper iff no
    unit vector is killed by both.  Both enumerations are complete (4^rank and 2^rank x 2^rank = 4^rank maps)."""
    R = lat.rank
    U = _coord_matrix(lat, lat.units)                                  # g x R
    if planted('screen_partial'):
        U = U[:1]                              # PLANT: only the first unit vector constrains the screen
    T = {nm: lat.coords(z) for nm, z in targets.items()}

    # ---- Z/4
    A = all_vectors_mod(4, R)                                          # 4^R x R
    proper4 = np.ones(len(A), dtype=bool)
    for i in range(0, len(A), chunk):
        blk = A[i:i + chunk]
        vals = (blk @ U.T) % 4                                         # chunk x g
        proper4[i:i + len(blk)] = (vals != 0).all(axis=1)
    A4 = A[proper4]
    z4 = {}
    for nm, c in T.items():
        if c is None:
            z4[nm] = None
        else:
            z4[nm] = int(((A4 @ np.array(c, dtype=np.int64)) % 4 == 0).sum())

    # ---- Klein: b, c range over (Z/2)^R; kill[b] is the bitmask of unit vectors b annihilates
    B = all_vectors_mod(2, R)                                          # 2^R x R
    killmat = ((B @ U.T) % 2 == 0)                                     # 2^R x g
    masks = [int(''.join('1' if v else '0' for v in row[::-1]), 2) for row in killmat]
    properK = []
    for ib, mb in enumerate(masks):
        if mb == 0:
            # b alone is already nonzero on every unit vector: every partner c works
            properK.extend((ib, ic) for ic in range(len(masks)))
        else:
            for ic, mc in enumerate(masks):
                if mb & mc == 0:
                    properK.append((ib, ic))
    zK = {}
    for nm, c in T.items():
        if c is None:
            zK[nm] = None
            continue
        cv = np.array(c, dtype=np.int64)
        bt = ((B @ cv) % 2 == 0)                                       # does b kill the target?
        zK[nm] = int(sum(1 for ib, ic in properK if bt[ib] and bt[ic]))

    # ---- Lambda_forced: the mod-4 conditions a.v = 0 (proper Z/4) and 2 b.v = 0 (each component of a proper Klein)
    rows = [tuple(int(x) for x in a) for a in A4]
    comps = set()
    for ib, ic in properK:
        comps.add(ib)
        comps.add(ic)
    for ib in comps:
        rows.append(tuple(2 * int(x) for x in B[ib]))
    forced_basis, forced_index = forced_sublattice(rows, R)
    return {'rank': R, 'g': len(lat.units),
            'Z4': {'proper': int(len(A4)), 'target_zero': z4},
            'K4': {'proper': int(len(properK)), 'target_zero': zK},
            'forced_basis': forced_basis, 'forced_index': forced_index,
            'targets_in_lattice': {nm: (c is not None) for nm, c in T.items()},
            'z4_examples': [list(int(x) for x in a) for a in A4[:3]]}


def forced_sublattice(rows, R, chunk=8192):
    """{v in Z^R : r.v = 0 mod 4 for every row r}, as an HNF basis over Z (it contains 4 Z^R), and its index."""
    if not rows:
        return [list(r) for r in np.eye(R, dtype=int).tolist()], 1
    Rm = np.array(sorted(set(rows)), dtype=np.int64) % 4
    V = all_vectors_mod(4, R)
    keep = np.ones(len(V), dtype=bool)
    for i in range(0, len(V), chunk):
        blk = V[i:i + chunk]
        keep[i:i + len(blk)] = (((blk @ Rm.T) % 4) == 0).all(axis=1)
    sols = V[keep]
    gens = [tuple(int(x) for x in s) for s in sols] + [tuple(4 if j == k else 0 for j in range(R)) for k in range(R)]
    Hf = hnf(gens, dim=R)
    index = 1
    for k, row in enumerate(Hf):
        c = next(j for j in range(R) if row[j])
        index *= row[c]
    return [list(r) for r in Hf], index


def in_forced(lat, screen, z):
    """is the difference z additively allowed as a forced-equal pair?  (z in Lambda_forced)"""
    c = lat.coords(z)
    if c is None:
        return None
    return coords_in_basis(screen['forced_basis'], list(c), dim=lat.rank) is not None


# ---------------------------------------------------------------- chainable distances over the field

def chain_pool(dmax=8):
    """the unit vectors of F(i) of denominator <= dmax -- the pool the chain enumeration searches."""
    pool = []
    for M in range(1, dmax + 1):
        pool.extend(FF.units_of_denominator(M))
    return pool


_CHAIN_CACHE = {}


def chainable_reciprocals(dmax=8, maxlen=4):
    """{real r != 0 that is a sum of at most maxlen unit vectors of denominator <= dmax} -> the least such length.
    delta = 1/r is then chainable with that many copies (G55).  Lengths 1 and 2 exhaustively; length 3 as
    (pair, single) and length 4 as (pair, pair), matched on the imaginary part -- which is exact and complete for
    those lengths over this pool.  The pool is the enumeration: a distance absent from the answer is absent from
    THIS pool at THIS length (G21)."""
    if (dmax, maxlen) in _CHAIN_CACHE:
        return _CHAIN_CACHE[(dmax, maxlen)]
    pool = chain_pool(dmax)
    out = {}

    def note(r, n):
        if r[1] != ZERO or r[0] == ZERO:
            return
        key = tuple(r[0])
        if key not in out or out[key] > n:
            out[key] = n

    for z in pool:
        note(z, 1)
    pairs = []
    by_im = defaultdict(list)
    for i, a in enumerate(pool):
        for b in pool[i:]:
            s = e_add(a, b)
            pairs.append(s)
            by_im[tuple(s[1])].append(s)
            note(s, 2)
    if maxlen >= 3:
        single_by_im = defaultdict(list)
        for z in pool:
            single_by_im[tuple(z[1])].append(z)
        for s in pairs:
            neg = tuple(-q for q in s[1])
            for t in single_by_im.get(neg, ()):
                note(e_add(s, t), 3)
    if maxlen >= 4:
        for s in pairs:
            neg = tuple(-q for q in s[1])
            for t in by_im.get(neg, ()):
                note(e_add(s, t), 4)
    _CHAIN_CACHE[(dmax, maxlen)] = out
    return out


# the closers of plan section 3.5, verified exactly in fs70_field's self-test
KNOWN_CLOSERS = {'2': 2, '4/3': 3, '4': 4, '8/3': 6}


def f_max_embedding(u):
    """max over the four real embeddings of |u| -- the size of a field element, for capping a target list"""
    a, b, c, d = (float(q) for q in u)
    return max(abs(a + sb * b * FF.S3F + sc * c * FF.S5F + sb * sc * d * FF.S15F)
               for sb in (1, -1) for sc in (1, -1))


def chainable_targets(lat, screen, dmax=8, maxlen=4, size_cap=8.0):
    """every real delta in Lambda_forced whose reciprocal the pool reaches, with its chain length.  Capped at
    size_cap in every real embedding (a huge delta is chainable and useless: the copies' fabric scales with it)."""
    recips = chainable_reciprocals(dmax, maxlen)
    out = []
    for key, n in recips.items():
        inv = (FF.f_inv(tuple(key)), ZERO)
        size = f_max_embedding(inv[0])
        if size > size_cap:
            continue
        if lat.coords(inv) is None or not in_forced(lat, screen, inv):
            continue
        out.append({'delta': FF.f_str(inv[0]), 'chain': n, 'size': round(size, 6),
                    'delta_ints': list(e_to_ints(inv))})
    # the known closers, whose chain lengths come from the exact identities of plan section 3.5
    for label, n in KNOWN_CLOSERS.items():
        d = real_scalar(Fr(label))
        if lat.coords(d) is None or not in_forced(lat, screen, d):
            continue
        have = next((o for o in out if o['delta_ints'] == list(e_to_ints(d))), None)
        if have is None:
            out.append({'delta': label, 'chain': n, 'size': float(Fr(label)),
                        'delta_ints': list(e_to_ints(d))})
        else:
            have['chain'] = min(have['chain'], n)
    out.sort(key=lambda o: (o['chain'], o['size']))
    return out


# ---------------------------------------------------------------- targets

def target_element(name):
    if name in ('isqrt3', 'i sqrt3'):
        return I_SQRT3
    return real_scalar(Fr(name))


TARGET_NAMES = ('isqrt3', '2', '4/3', '8/3', '4')
SCREEN_TARGETS = {'i sqrt3': I_SQRT3, '2': real_scalar(2), '4/3': real_scalar(Fr(4, 3)),
                  '8/3': real_scalar(Fr(8, 3)), '4': real_scalar(4)}


# ---------------------------------------------------------------- shapes (integer arithmetic throughout)

def word_ball(lat, k, steps=None, centres=None):
    """every point that is a sum of at most k generators (Harder's shape, plan section 3.3).

    `centres` (phase 1): a list of 8-tuples to grow the ball about instead of the origin alone; the result is the
    UNION of the balls, and the value at a point is its distance to the nearest centre.  The union of the balls
    about `0` and about a target `B` CONTAINS the lens T_{2k+1}(0 -> B) (a lens point has word-distance <= k to one
    of the two ends, since the two distances sum to at most 2k+1), so it is the affordable SUPERSET of a lens
    whose own construction would need a ball of radius 2k+1 -- and a refusal on a superset is a refusal."""
    S = [lat.vec8(z) for z in (lat.S if steps is None else steps)]
    zero = tuple([0] * 8)
    starts = [zero] if centres is None else [tuple(c) for c in centres]
    seen = {c: 0 for c in starts}
    frontier = list(seen)
    for d in range(1, k + 1):
        nxt = []
        for p in frontier:
            for s in S:
                q = tuple(a + b for a, b in zip(p, s))
                if q not in seen:
                    seen[q] = d
                    nxt.append(q)
        frontier = nxt
    return seen


def lens(lat, A8, B8, n, steps=None):
    """Haugland's T_n: every point on a unit-vector path from A to B of graph length <= n.

    ONE breadth-first search, not two (phase 1): the generator set is symmetric (-S = S, since every family is a
    zeta12-orbit), so word distance is translation-invariant and d_B(p) = d(p - B) with d the distance from the
    origin.  A lens point has d(p) <= n and d(p - B) <= n, so a single ball of radius n about the origin carries
    both numbers -- half the memory and half the time of the two-search form, and the same set (asserted in the
    self-test against the old form)."""
    S = [lat.vec8(z) for z in (lat.S if steps is None else steps)]
    shift = tuple(b - a for a, b in zip(A8, B8))
    dist = {tuple([0] * 8): 0}
    frontier = [tuple([0] * 8)]
    for d in range(1, n + 1):
        nxt = []
        for p in frontier:
            for s in S:
                q = tuple(a + b for a, b in zip(p, s))
                if q not in dist:
                    dist[q] = d
                    nxt.append(q)
        frontier = nxt
    out = {}
    for p, a in dist.items():
        q = tuple(x - y for x, y in zip(p, shift))
        b = dist.get(q)
        if b is not None and a + b <= n:
            out[tuple(x + y for x, y in zip(p, A8))] = a
    return out


def minkowski_ball(lat, R):
    """every lattice point all four of whose real embeddings lie in the disc of radius R (the FS-61 ball shape with
    four embeddings).  Enumerated from the coordinate box of the embedding: both coordinates' numerators over M lie
    in embedding_box(ceil(M R)), and lattice membership plus the exact four-embedding test decide."""
    M = lat.M
    box = FF.embedding_box(int(math.ceil(M * R)) + 1)
    R2 = Fr(int(round(R * 10 ** 6)), 10 ** 6) ** 2
    # exact-ish embedding constants as high-precision rationals (the test has a 1e-6 margin, as the ball's radius does)
    s3 = Fr(1732050807568877, 10 ** 15)
    s5 = Fr(2236067977499790, 10 ** 15)
    s15 = Fr(3872983346207417, 10 ** 15)
    marg = Fr(1, 10 ** 6)
    # bucket the box by the embedding vector to prune: |sigma(x)|^2 <= R^2 M^2 needed componentwise
    out = {}
    bnd = float(R * M) + 1e-6
    box_f = []
    for e in box:
        a, b, c, d = e
        v = (a + b * FF.S3F + c * FF.S5F + d * FF.S15F, a - b * FF.S3F + c * FF.S5F - d * FF.S15F,
             a + b * FF.S3F - c * FF.S5F - d * FF.S15F, a - b * FF.S3F - c * FF.S5F + d * FF.S15F)
        if max(abs(t) for t in v) <= bnd:
            box_f.append((e, v))
    for (ex, vx) in box_f:
        rem = [bnd * bnd - t * t + 1e-6 for t in vx]
        if min(rem) < 0:
            continue
        for (ey, vy) in box_f:
            ok = True
            for t in range(4):
                if vy[t] * vy[t] > rem[t]:
                    ok = False
                    break
            if not ok:
                continue
            v8 = ex + ey
            if not lat.contains_vec8(v8):
                continue
            # exact decision
            n2 = FF.e_normF((tuple(Fr(q, M) for q in ex), tuple(Fr(q, M) for q in ey)))
            a, b, c, d = n2
            good = True
            for sb in (1, -1):
                for sc in (1, -1):
                    if a + sb * b * s3 + sc * c * s5 + sb * sc * d * s15 > R2 + marg:
                        good = False
            if good:
                out[v8] = 0
    return out


def unit_graph(points, lat):
    """the COMPLETE unit-distance graph on a point set of the lattice: every edge direction is a unit vector of the
    lattice, and lat.units is the whole saturation, so stepping by each of them finds every edge."""
    keys = list(points)
    index = {k: i for i, k in enumerate(keys)}
    steps = lat.unit_vec8
    edges = set()
    for k in keys:
        i = index[k]
        for s in steps:
            j = index.get(tuple(a + b for a, b in zip(k, s)))
            if j is not None and i < j:
                edges.add((i, j))
    return keys, sorted(edges)


def unit_graph_geometric(points, lat, cell=1.0):
    """the complete unit-distance graph derived from the GEOMETRY rather than from the saturation: a float grid of
    cell size 1 proposes every pair within 1 +- 1e-6, and exact integer arithmetic decides.  Independent of the
    saturation, so it is the control on it -- and it also reports the edge DIRECTIONS that occur, which is how a
    graph built from a subset of the directions is caught (section 5b's `partial`)."""
    keys = list(points)
    M = lat.M
    xs = []
    for k in keys:
        x, y = ints_float(k, M)
        xs.append((x, y))
    grid = defaultdict(list)
    for i, (x, y) in enumerate(xs):
        grid[(math.floor(x / cell), math.floor(y / cell))].append(i)
    N2 = (ONE, ZERO)
    edges = set()
    dirs = defaultdict(int)
    tol = 1e-6
    for (gx, gy), idxs in grid.items():
        near = []
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                near.extend(grid.get((gx + dx, gy + dy), ()))
        for i in idxs:
            xi, yi = xs[i]
            for j in near:
                if j <= i:
                    continue
                d2 = (xs[j][0] - xi) ** 2 + (xs[j][1] - yi) ** 2
                if abs(d2 - 1.0) > tol:
                    continue
                dv = tuple(a - b for a, b in zip(keys[j], keys[i]))
                z = (tuple(Fr(q, M) for q in dv[:4]), tuple(Fr(q, M) for q in dv[4:]))
                if FF.e_normF(z) == ONE:
                    edges.add((i, j))
                    dirs[dv] += 1
    return keys, sorted(edges), dirs


def unit_graph_from_steps(points, lat, steps_e):
    """the graph built from a PROPER SUBSET of the saturation -- a partial graph (a refusal still stands; a
    colouring does not)."""
    keys = list(points)
    index = {k: i for i, k in enumerate(keys)}
    steps = [lat.vec8(z) for z in steps_e]
    edges = set()
    for k in keys:
        i = index[k]
        for s in steps:
            j = index.get(tuple(a + b for a, b in zip(k, s)))
            if j is not None and i < j:
                edges.add((i, j))
    return keys, sorted(edges)


def m_core(n, edges, m):
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    alive = set(range(n))
    changed = True
    while changed:
        changed = False
        for v in list(alive):
            if len(adj[v] & alive) < m:
                alive.discard(v)
                changed = True
    keep = sorted(alive)
    pos = {v: i for i, v in enumerate(keep)}
    return keep, [(pos[a], pos[b]) for a, b in edges if a in alive and b in alive]


# ---------------------------------------------------------------- CNF

def var(v, c, k=4):
    return k * v + c + 1


def coloring_cnf(n, edges, k, pins, precedence=True, amo=True):
    """one-hot k-colouring.  pins: [(vertex, colour)].  precedence breaks the residual value symmetry among the
    colours no pin names (CLAUDE.md, the symmetry checklist): colour c at v needs colour c-1 somewhere earlier."""
    clauses = []
    for v in range(n):
        clauses.append([var(v, c, k) for c in range(k)])
        if amo:
            for c1 in range(k):
                for c2 in range(c1 + 1, k):
                    clauses.append([-var(v, c1, k), -var(v, c2, k)])
    for a, b in edges:
        for c in range(k):
            clauses.append([-var(a, c, k), -var(b, c, k)])
    for v, c in pins:
        clauses.append([var(v, c, k)])
    if precedence:
        pinned = {c for _, c in pins}
        free = [c for c in range(k) if c not in pinned]
        # LINEAR precedence: s[v][c] = "colour c occurs at some u <= v", so colour free[j] may appear at v only
        # if free[j-1] already has.  The naive form is one clause of length v per vertex -- O(n^2) literals, which
        # is 1.1 GB of CNF at n = 20,000 and is why this encoding is auxiliary-variable based.
        nxt = k * n
        sv = {}
        for c in free:
            for v in range(n):
                nxt += 1
                sv[(v, c)] = nxt
        for c in free:
            for v in range(n):
                clauses.append([-var(v, c, k), sv[(v, c)]])                       # x[v][c] -> s[v][c]
                if v:
                    clauses.append([-sv[(v - 1, c)], sv[(v, c)]])                 # s[v-1][c] -> s[v][c]
                    clauses.append([-sv[(v, c)], sv[(v - 1, c)], var(v, c, k)])   # s[v][c] -> s[v-1][c] or x[v][c]
                else:
                    clauses.append([-sv[(v, c)], var(v, c, k)])
        for j in range(1, len(free)):
            c, cp = free[j], free[j - 1]
            clauses.append([-var(0, c, k)])
            for v in range(1, n):
                clauses.append([-var(v, c, k), sv[(v - 1, cp)]])
    return clauses


def cnf_nvars(n, k, pins):
    pinned = {c for _, c in pins}
    free = [c for c in range(k) if c not in pinned]
    return k * n + len(free) * n


def write_cnf(path, nvars, clauses):
    with open(path, 'w') as f:
        f.write(f'p cnf {nvars} {len(clauses)}\n')
        for cl in clauses:
            f.write(' '.join(str(x) for x in cl) + ' 0\n')
    return hashlib.sha256(open(path, 'rb').read()).hexdigest()[:16]


# ---------------------------------------------------------------- writing a shape

def write_shape(out, lat, keys, edges, shape, extra, partial=False, A=None, B=None, cnfs_too=True):
    """`cnfs_too=False` (phase 1's `--no-cnf`) writes graph.json alone.  The CNF of a pin is O(edges) on disk --
    about 400 MB per pin at half a million points -- and `fs70_ask.py` builds the one CNF it needs from
    graph.json; writing ten of them per shape is minutes of I/O and gigabytes for nothing."""
    os.makedirs(out, exist_ok=True)
    N = len(keys)
    deg = 2 * len(edges) / N if N else 0
    index = {k: i for i, k in enumerate(keys)}
    meta = {'lattice': lat.spec, 'lattice_sha': lat.sha(), 'M': lat.M, 'rank': lat.rank, 'g': len(lat.units),
            'shape': shape, 'points': N, 'edges': len(edges), 'avg_degree': deg, 'partial': partial}
    meta.update(extra)
    pt_sha = hashlib.sha256(json.dumps(sorted(keys), separators=(',', ':')).encode()).hexdigest()
    meta['points_sha256'] = pt_sha
    cnfs = {}
    if not cnfs_too:
        meta['cnf_sha'] = {}
        with open(os.path.join(out, 'graph.json'), 'w') as f:
            json.dump({'meta': meta, 'M': lat.M, 'points': [list(k) for k in keys],
                       'edges': [list(e) for e in edges]}, f)
        print(f'  wrote {out}: {N} points, {len(edges)} edges, avg degree {deg:.2f}'
              + (' [PARTIAL graph]' if partial else '') + '  [no CNFs: fs70_ask.py builds the one it needs]')
        return meta
    with open(os.path.join(out, 'graph.json'), 'w') as f:
        json.dump({'meta': meta, 'M': lat.M, 'points': [list(k) for k in keys], 'edges': [list(e) for e in edges]}, f)
    # control: a unit triangle pinned where one exists (0, 1, zeta6), else the origin and one neighbour
    i0 = index.get(tuple([0] * 8))
    pins = []
    if i0 is not None:
        pins = [(i0, 0)]
        for z, c in ((E_ONE, 1), (ZETA6, 2)):
            j = index.get(lat.vec8(z))
            if j is not None:
                pins.append((j, c))
    if pins:
        cnfs['control'] = write_cnf(os.path.join(out, 'control.cnf'), cnf_nvars(N, 4, pins),
                                    coloring_cnf(N, edges, 4, pins))
        meta['control_pins'] = pins
    # the target asks
    for nm in TARGET_NAMES:
        z = target_element(nm)
        if lat.coords(z) is None:
            continue
        jt = index.get(lat.vec8(z))
        if jt is None or i0 is None:
            continue
        tag = nm.replace('/', 'over').replace(' ', '')
        pe = [(i0, 0), (jt, 1)]
        ps = [(i0, 0), (jt, 0)]
        cnfs[f'eq_{tag}'] = write_cnf(os.path.join(out, f'eq_{tag}.cnf'), cnf_nvars(N, 4, pe),
                                      coloring_cnf(N, edges, 4, pe))
        cnfs[f'sep_{tag}'] = write_cnf(os.path.join(out, f'sep_{tag}.cnf'), cnf_nvars(N, 4, ps),
                                       coloring_cnf(N, edges, 4, ps))
    meta['cnf_sha'] = cnfs
    with open(os.path.join(out, 'graph.json'), 'w') as f:
        json.dump({'meta': meta, 'M': lat.M, 'points': [list(k) for k in keys], 'edges': [list(e) for e in edges]}, f)
    print(f'  wrote {out}: {N} points, {len(edges)} edges, avg degree {deg:.2f}'
          + (' [PARTIAL graph]' if partial else ''))
    print(f'  cnfs: {", ".join(sorted(cnfs))}')
    return meta


# ---------------------------------------------------------------- the ball law (G65, four embeddings)

def phi_overlap(R):
    """the overlap of a disc of radius R with its unit translate, as a fraction of the disc (G65's phi)"""
    if R < 0.5:
        return 0.0
    return (2 * R * R * math.acos(1 / (2 * R)) - 0.5 * math.sqrt(4 * R * R - 1)) / (math.pi * R * R)


def ball_prediction(lat, R):
    pts = math.pi ** 4 * R ** 8 / lat.covolume()
    return pts, len(lat.units) * phi_overlap(R) ** 4


# ---------------------------------------------------------------- commands

def lattice_record(spec, method='auto', dmax=8, maxlen=4):
    lat = Lattice(generators(spec), spec)
    t0 = time.time()
    if method == 'auto':
        method = 'b' if lat.sat_b_cost() <= lat.SAT_B_BOX_CAP else 'gens'
    lat.saturate(method)
    passes, witness, counts = lat.gate()
    screen = additive_screen(lat, SCREEN_TARGETS)
    targets = chainable_targets(lat, screen, dmax, maxlen)
    dep = defaultdict(int)
    for z in lat.units:
        dep[str(depths(z))] += 1
    rec = {'gate': 'pass' if passes else 'fail',
           'saturation_complete': lat.sat_complete,
           'gate_witness': (e_str(witness) if witness is not None else None),
           'gate_witness_ints': (list(e_to_ints(witness)) if witness is not None else None),
           'gate_counts': counts,
           'lattice': spec, 'lattice_sha': lat.sha(), 'M': lat.M, 'rank': lat.rank,
           'generators': len(lat.S), 'g': len(lat.units),
           'covolume': lat.covolume(), 'log10_covolume': round(lat.log10_covolume(), 4),
           'depth_classes': dict(sorted(dep.items())),
           'additive': {'Z4': screen['Z4'], 'K4': screen['K4']},
           'forced_basis': screen['forced_basis'], 'forced_index': screen['forced_index'],
           'targets_in_lattice': screen['targets_in_lattice'],
           'targets': targets,
           'sat_method': method, 'seconds': round(time.time() - t0, 2)}
    return lat, screen, rec


def print_record(rec):
    print(f'== {rec["lattice"]}  [{rec["lattice_sha"]}]  M = {rec["M"]}, rank {rec["rank"]}, '
          f'|S| = {rec["generators"]}, g = {rec["g"]}'
          + ('' if rec['saturation_complete'] else ' (GENERATORS ONLY: proper counts are upper bounds)')
          + f', log10 covolume {rec["log10_covolume"]:.3f}')
    print(f'   3-adic gate: {rec["gate"].upper()}'
          + (f' via {rec["gate_witness"]} ({rec["gate_counts"]["three_non_units"]} of {rec["g"]} are 3-non-units)'
             if rec['gate'] == 'pass' else '  -- every unit vector is a 3-unit: DEAD by the 3-adic gate'))
    for g in ('Z4', 'K4'):
        a = rec['additive'][g]
        print(f'   additive {g}: {a["proper"]:6d} proper;  phi(target) = 0 at ' +
              ', '.join(f'{nm} {v}' for nm, v in a['target_zero'].items()))
    print(f'   Lambda_forced: index {rec["forced_index"]} in Lambda; basis rows {len(rec["forced_basis"])}')
    print(f'   chainable targets in Lambda_forced: '
          + (', '.join(f'{t["delta"]} (chain {t["chain"]})' for t in rec['targets'][:12]) or 'none'))


def cmd_lattice(specs, method, out=None):
    rows = []
    for spec in specs:
        lat, screen, rec = lattice_record(spec, method)
        print_record(rec)
        print()
        rows.append(rec)
    if out:
        with open(out, 'w') as fh:
            for r in rows:
                fh.write(json.dumps(r, separators=(',', ':')) + '\n')
        print('wrote', out)
    return rows


def cmd_survivors(spec, method, target='isqrt3'):
    """The proper additive Z/4-colourings that kill a target (phi(target) = 0), described: their images on the HNF
    basis, their values on the named vectors, and their orbit structure under the symmetries of the lattice
    (multiplication by zeta12, complex conjugation, and the colour automorphism phi -> -phi).  This is what the
    owner's re-grade of P1 asks for: the survivors are the four-colourings that make the target monochromatic, so
    what they ARE is what kills the ask."""
    lat = Lattice(generators(spec), spec)
    if method == 'auto':
        method = 'b' if lat.sat_b_cost() <= lat.SAT_B_BOX_CAP else 'gens'
    lat.saturate(method)
    R = lat.rank
    U = _coord_matrix(lat, lat.units)
    A = all_vectors_mod(4, R)
    proper = (((A @ U.T) % 4) != 0).all(axis=1)
    A4 = A[proper]
    tz = target_element(target)
    tc = np.array(lat.coords(tz), dtype=np.int64)
    surv = A4[((A4 @ tc) % 4) == 0]
    print(f'{spec}: {len(A4)} proper Z/4 additive colourings, {len(surv)} with phi({target}) = 0 '
          f'(saturation {"complete" if lat.sat_complete else "GENERATORS ONLY: an upper bound"}, g = {len(lat.units)})')
    named = {'1': E_ONE, 'zeta12': ZETA12, 'zeta6': ZETA6, 'i sqrt3': I_SQRT3, 'u': U_SQRT5,
             '2': real_scalar(2), '1/3': real_scalar(Fr(1, 3)), '4/3': real_scalar(Fr(4, 3))}
    ncoords = {nm: np.array(lat.coords(z), dtype=np.int64) for nm, z in named.items() if lat.coords(z) is not None}
    # the symmetry group action: phi -> phi o sigma^{-1} for sigma in <zeta12 multiplication, conjugation>, and
    # phi -> -phi.  Realised on coordinate vectors by the integer matrix of sigma in the HNF basis.
    def matrix_of(sigma):
        rows = []
        for b in lat.basis:
            c = lat.coords(sigma(b))
            if c is None:
                return None
            rows.append(list(c))
        return np.array(rows, dtype=np.int64)
    gens_act = []
    for nm, sigma in (('zeta12*', lambda z: e_mul(ZETA12, z)), ('conj', e_conj), ('neg', lambda z: e_neg(z))):
        Mx = matrix_of(sigma)
        if Mx is None:
            print(f'  (the lattice is not stable under {nm}: not a symmetry here)')
        else:
            gens_act.append((nm, Mx))
    sset = {tuple(int(x) for x in a) for a in surv}
    seen = set()
    orbits = []
    for a in sorted(sset):
        if a in seen:
            continue
        orb = {a}
        stack = [a]
        while stack:
            cur = np.array(stack.pop(), dtype=np.int64)
            cands = [tuple(int(x) for x in (cur @ Mx) % 4) for _, Mx in gens_act]
            cands.append(tuple(int((-x) % 4) for x in cur))
            for c in cands:
                if c in sset and c not in orb:
                    orb.add(c)
                    stack.append(c)
        seen |= orb
        orbits.append(sorted(orb))
    print(f'  orbits under <zeta12 multiplication, conjugation, phi -> -phi>: {len(orbits)}, sizes '
          f'{[len(o) for o in orbits]}')
    for oi, orb in enumerate(orbits):
        a = np.array(orb[0], dtype=np.int64)
        vals = {nm: int((a @ c) % 4) for nm, c in ncoords.items()}
        print(f'  orbit {oi}: size {len(orb)}; representative images on the HNF basis {orb[0]}; values {vals}')
    return orbits


def cmd_word(spec, k, out, target, core, method, steps_spec=None, union=False, cnfs_too=True):
    lat = Lattice(generators(spec), spec)
    lat.saturate('b' if method == 'auto' else method)
    t0 = time.time()
    centres = None
    if union:
        tz = target_element(target)
        if lat.coords(tz) is None:
            raise SystemExit(f'the target {target} is not in the lattice {spec}: no union ball can reach it')
        centres = [tuple([0] * 8), lat.vec8(tz)]
    pts = word_ball(lat, k, centres=centres)
    keys, edges = unit_graph(pts, lat)
    print(f'word {"union " if union else ""}ball k = {k} over {spec}'
          f'{f" (centres 0 and {target})" if union else ""}: |S| = {len(lat.S)}, g = {len(lat.units)}, '
          f'{len(keys)} points, {len(edges)} edges, avg degree {2*len(edges)/max(1,len(keys)):.2f} '
          f'({time.time()-t0:.1f}s)')
    if core:
        keep, edges = m_core(len(keys), edges, core)
        keys = [keys[i] for i in keep]
        print(f'  {core}-core: {len(keys)} points, {len(edges)} edges, '
              f'avg degree {2*len(edges)/max(1,len(keys)):.2f}')
    if out:
        shape = {'shape': 'wordunion' if union else 'word', 'k': k}
        if union:
            shape['target'] = target
        write_shape(out, lat, keys, edges, shape, {'core': core}, cnfs_too=cnfs_too)
    return lat, keys, edges


def cmd_tn(spec, n, out, target, core, method, cnfs_too=True):
    lat = Lattice(generators(spec), spec)
    lat.saturate('b' if method == 'auto' else method)
    A = tuple([0] * 8)
    tz = target_element(target)
    if lat.coords(tz) is None:
        raise SystemExit(f'the target {target} is not in the lattice {spec}: no lens can reach it')
    B = lat.vec8(tz)
    t0 = time.time()
    pts = lens(lat, A, B, n)
    if not pts:
        raise SystemExit(f'no path of length <= {n} from 0 to {target} in {spec}: raise n')
    keys, edges = unit_graph(pts, lat)
    print(f'lens n = {n} over {spec} (0 -> {target}): {len(keys)} points, {len(edges)} edges, '
          f'avg degree {2*len(edges)/max(1,len(keys)):.2f} ({time.time()-t0:.1f}s)')
    if core:
        keep, edges = m_core(len(keys), edges, core)
        keys = [keys[i] for i in keep]
        print(f'  {core}-core: {len(keys)} points, {len(edges)} edges, '
              f'avg degree {2*len(edges)/max(1,len(keys)):.2f}')
    if out:
        write_shape(out, lat, keys, edges, {'shape': 'lens', 'n': n, 'target': target}, {'core': core},
                    cnfs_too=cnfs_too)
    return lat, keys, edges


def cmd_ball(spec, R, out, core, method, cnfs_too=True):
    lat = Lattice(generators(spec), spec)
    lat.saturate('b' if method == 'auto' else method)
    pp, pd = ball_prediction(lat, R)
    t0 = time.time()
    pts = minkowski_ball(lat, R)
    keys, edges = unit_graph(pts, lat)
    deg = 2 * len(edges) / max(1, len(keys))
    print(f'ball R = {R} over {spec}: {len(keys)} points, {len(edges)} edges, avg degree {deg:.2f} '
          f'({time.time()-t0:.1f}s);  predicted {pp:.0f} points / degree {pd:.2f} (G65 with four embeddings)')
    if core:
        keep, edges = m_core(len(keys), edges, core)
        keys = [keys[i] for i in keep]
        print(f'  {core}-core: {len(keys)} points, {len(edges)} edges, '
              f'avg degree {2*len(edges)/max(1,len(keys)):.2f}')
    if out:
        write_shape(out, lat, keys, edges, {'shape': 'ball', 'R': R},
                    {'core': core, 'predicted_points': round(pp), 'predicted_degree': round(pd, 3)},
                    cnfs_too=cnfs_too)
    return lat, keys, edges


# ---------------------------------------------------------------- self-test

def selftest():
    # --- the grammar
    try:
        generators('zeta12+nosuch')
    except SystemExit as e:
        assert 'unknown family' in str(e), str(e)
    else:
        raise AssertionError('an unknown family name was accepted')
    assert len(generators('group:u3:2')) == 60, len(generators('group:u3:2'))
    assert len(generators('zeta12')) == 12
    assert len(generators('zeta12+u3')) == 36

    # --- the lattice of zeta12 and u: the plan's section 2.2 head row, and the owner's re-derivation
    lat = Lattice(generators('zeta12+u3'), 'zeta12+u3')
    assert lat.M == 6, lat.M
    assert lat.rank == 8, f'rank {lat.rank}, not 8: the basis does not span the generators\' Z-module'
    # every generator is in the lattice (the faithful twin of the basis_drop plant)
    for z in lat.S:
        assert lat.contains(z), f'generator {e_str(z)} is not in its own lattice'
    lat.saturate('b')
    assert len(lat.units) == 36, f'g = {len(lat.units)}: the saturation of zeta12+u3 is 36 (plan section 2.2)'
    # the saturation holds u and every twelfth root of unity
    assert lat.contains(U_SQRT5) and lat.contains(ZETA12)
    assert canonical(U_SQRT5) in {canonical(z) for z in lat.units}
    # the two methods agree
    lat2 = Lattice(generators('zeta12+u3'), 'zeta12+u3')
    lat2.saturate('both')
    assert len(lat2.units) == 36
    # a lattice whose saturation is STRICTLY bigger than its generator set (the faithful twin of sat_generators):
    # the plan's section 2.2 reads g = 300 for zeta12+u3+v4 from 60 generators, and g = 60 for zeta12+u3+q7
    lbig = Lattice(generators('zeta12+u3+v4'), 'zeta12+u3+v4')
    lbig.saturate('b')
    assert len(lbig.S) == 60 and len(lbig.units) == 300, (
        f'zeta12+u3+v4: |S| = {len(lbig.S)}, g = {len(lbig.units)}; the plan section 2.2 reads 60 generators and '
        f'g = 300 -- a saturation equal to the generator set means the enumeration never ran')
    assert len(lbig.units) > len(lbig.S), 'the saturation must exceed the generator set on this lattice'
    lq7 = Lattice(generators('zeta12+u3+q7'), 'zeta12+u3+q7')
    lq7.saturate('b')
    assert len(lq7.units) == 60, len(lq7.units)

    # --- the 3-adic gate: zeta12+u3 passes (u has 3-depth -2), zeta12+v4 and zeta12+w4 fail
    ok, wit, _ = lat.gate()
    assert ok and depths(wit)[1] != 0, (ok, e_str(wit) if wit else None)
    for dead in ('zeta12+v4', 'zeta12+w4'):
        ld = Lattice(generators(dead), dead)
        ld.saturate('b')
        okd, _, _ = ld.gate()
        assert not okd, f'{dead} passed the 3-adic gate; the plan says every one of its unit vectors is a 3-unit'
        assert len(ld.units) == 36, (dead, len(ld.units))

    # --- the additive screen: the plan's and the owner's counts, exactly
    scr = additive_screen(lat, SCREEN_TARGETS)
    assert scr['Z4']['proper'] == 1296, (
        f"proper Z/4 additive colourings {scr['Z4']['proper']}, not 1296: the screen did not test every unit vector")
    assert scr['K4']['proper'] == 1296, (
        f"proper Klein additive colourings {scr['K4']['proper']}, not 1296: the screen did not test every unit vector")
    tz4 = scr['Z4']['target_zero']
    assert (tz4['i sqrt3'], tz4['2'], tz4['4/3'], tz4['8/3']) == (432, 432, 1296, 1296), tz4
    tzk = scr['K4']['target_zero']
    assert (tzk['i sqrt3'], tzk['2'], tzk['4/3'], tzk['8/3']) == (0, 1296, 1296, 1296), tzk
    # every "proper" hom really is nonzero on every unit vector (the faithful twin of screen_partial)
    U = _coord_matrix(lat, lat.units)
    A = all_vectors_mod(4, lat.rank)
    prop = np.array([bool(((a @ U.T) % 4 != 0).all()) for a in A[:4096]])
    assert prop.sum() == int((((A[:4096] @ U.T) % 4) != 0).all(axis=1).sum())
    # --- Lambda_forced: 4/3 and 8/3 are in it, i sqrt3 and 2 are not (the screen's own reading, as a sublattice)
    assert in_forced(lat, scr, real_scalar(Fr(4, 3))) is True
    assert in_forced(lat, scr, real_scalar(Fr(8, 3))) is True
    assert in_forced(lat, scr, I_SQRT3) is False
    assert in_forced(lat, scr, real_scalar(2)) is False
    # 4 Lambda is inside Lambda_forced
    for k in range(lat.rank):
        v = [4 if j == k else 0 for j in range(lat.rank)]
        assert coords_in_basis(scr['forced_basis'], list(v), dim=lat.rank) is not None

    # --- THE TRIANGLE LEMMA (derived, two lines; holds on ANY lattice containing the unit triangle {0, 1, zeta6}).
    # For a proper additive phi : Lambda -> Z/4,  phi(i sqrt3) = 0  <=>  phi(2) = 0  <=>  phi(1) = 2.
    #   phi(2) = 2 phi(1) vanishes iff phi(1) in {0, 2}, and phi(1) != 0 because 1 is a unit vector.
    #   i sqrt3 = 2 zeta6 - 1, so phi(i sqrt3) = 2 phi(zeta6) - phi(1).
    #   (<=) phi(1) = 2: zeta6 and zeta6 - 1 are unit vectors, so phi(zeta6) is neither 0 nor 2, hence odd, hence
    #        2 phi(zeta6) = 2 and phi(i sqrt3) = 0.
    #   (=>) phi(i sqrt3) = 0 gives phi(1) = 2 phi(zeta6) in {0, 2}, and phi(1) != 0.
    # So the sqrt3 virtual edge and the distance-2 virtual edge are killed by exactly the same colourings, and the
    # kill reduces to one bit: does some proper phi have phi(1) = 2?  Checked here on four lattices.
    assert lat.contains(E_ONE) and lat.contains(ZETA6) and lat.contains(e_sub(ZETA6, E_ONE))
    for spec_t in ('zeta12+u3', 'zeta12+w4', 'zeta12+d6'):
        lt = Lattice(generators(spec_t), spec_t)
        lt.saturate('b')
        Ut = _coord_matrix(lt, lt.units)
        At = all_vectors_mod(4, lt.rank)
        A4t = At[((((At @ Ut.T) % 4) != 0)).all(axis=1)]
        v1 = (A4t @ np.array(lt.coords(E_ONE), dtype=np.int64)) % 4
        vs = (A4t @ np.array(lt.coords(I_SQRT3), dtype=np.int64)) % 4
        v2 = (A4t @ np.array(lt.coords(real_scalar(2)), dtype=np.int64)) % 4
        assert ((v1 == 2) == (vs == 0)).all(), f'the triangle lemma failed at sqrt3 on {spec_t}'
        assert ((v1 == 2) == (v2 == 0)).all(), f'the triangle lemma failed at 2 on {spec_t}'

    # --- the screen's theorem: a lattice containing (1/2){1, zeta6} has no additive four-colouring
    lv = Lattice(generators('zeta12+v4'), 'zeta12+v4')
    lv.saturate('b')
    assert lv.contains(real_scalar(Fr(1, 2))), 'v + vbar = 1/2 should be in the lattice'
    sv = additive_screen(lv, SCREEN_TARGETS)
    assert sv['Z4']['proper'] == 0 and sv['K4']['proper'] == 0, (sv['Z4']['proper'], sv['K4']['proper'])

    # --- the chain pool finds the plan's closers
    rec = chainable_reciprocals(8, 4)
    assert tuple(real_scalar(Fr(1, 2))[0]) in rec, '1/2 = v + vbar not found by the chain enumeration'
    assert rec[tuple(real_scalar(Fr(1, 2))[0])] == 2
    assert tuple(real_scalar(Fr(3, 4))[0]) in rec, '3/4 = -1 - v^2 - vbar^2 not found'
    assert rec[tuple(real_scalar(Fr(3, 4))[0])] <= 3
    assert tuple(real_scalar(Fr(1, 4))[0]) in rec and rec[tuple(real_scalar(Fr(1, 4))[0])] <= 4

    # --- shapes, in integer arithmetic; the complete graph against a partial one
    pts = word_ball(lat, 2)
    keys, edges = unit_graph(pts, lat)
    assert len(keys) == len(pts)
    keys_p, edges_p = unit_graph_from_steps(pts, lat, lat.S)
    assert len(edges_p) <= len(edges), (len(edges_p), len(edges))
    # every edge really has length 1 (exact)
    for (i, j) in edges[:300]:
        d = tuple(a - b for a, b in zip(keys[i], keys[j]))
        z = (tuple(Fr(q, lat.M) for q in d[:4]), tuple(Fr(q, lat.M) for q in d[4:]))
        assert e_is_unit_vector(z), (i, j)
    # a unit triangle exists in this lattice (omega = 3 since sqrt3 is in F): 0, 1, zeta6
    assert lat.contains(E_ONE) and lat.contains(ZETA6)
    # the geometric derivation (float grid proposes, exact integers decide) must agree with stepping through the
    # saturation -- two independent edge derivations, which is the control on both
    keys_g, edges_g, dirs_g = unit_graph_geometric(pts, lat)
    assert keys_g == keys and edges_g == edges, (len(edges_g), len(edges))
    assert set(dirs_g) <= {lat.vec8(z) for z in lat.units}, 'an edge direction outside the saturation'

    # --- phase 1: the one-search lens must give exactly the two-search lens's set (the old form, kept here as
    # the control on the rewrite), and the union ball must contain the lens it is the affordable superset of
    def lens_two_search(lt, A8, B8, nn):
        SS = [lt.vec8(z) for z in lt.S]

        def bfs(start):
            dd = {start: 0}
            fr = [start]
            for d in range(1, nn + 1):
                nx = []
                for p in fr:
                    for s in SS:
                        q = tuple(a + b for a, b in zip(p, s))
                        if q not in dd:
                            dd[q] = d
                            nx.append(q)
                fr = nx
            return dd
        dA, dB = bfs(A8), bfs(B8)
        return {p: d for p, d in dA.items() if p in dB and d + dB[p] <= nn}
    A8 = tuple([0] * 8)
    B8 = lat.vec8(target_element('4/3'))
    for nn in (2, 3, 4):
        one, two = lens(lat, A8, B8, nn), lens_two_search(lat, A8, B8, nn)
        assert one == two, f'the one-search lens differs from the two-search lens at n = {nn}: ' \
                           f'{len(one)} against {len(two)} points'
    # T_{2k+1} is inside the union of the two balls of radius k (the superset claim the union shape rests on)
    for kk in (1, 2):
        uni = word_ball(lat, kk, centres=[A8, B8])
        big = lens(lat, A8, B8, 2 * kk + 1)
        assert set(big) <= set(uni), (f'the union of the two radius-{kk} balls misses {len(set(big) - set(uni))} '
                                      f'points of the lens T_{2*kk+1}: the superset claim is false')

    # --- the LINEAR precedence break must not change any verdict (its own positive control): on three small
    # instances the broken and unbroken encodings must agree, and the broken one must still admit a model.
    import tempfile
    for (kk, pins, want) in ((4, [(0, 0)], 'SAT'), (3, [(0, 0)], 'SAT'), (2, [(0, 0)], 'UNSAT')):
        cl_b = coloring_cnf(len(keys), edges, kk, pins, precedence=True)
        cl_u = coloring_cnf(len(keys), edges, kk, pins, precedence=False)
        vs = []
        with tempfile.TemporaryDirectory() as td:
            for nm, cl, nv in (('b', cl_b, cnf_nvars(len(keys), kk, pins)), ('u', cl_u, kk * len(keys))):
                pth = os.path.join(td, nm + '.cnf')
                write_cnf(pth, nv, cl)
                r = subprocess.run(['kissat', '-q', pth], capture_output=True, text=True)
                vs.append('SAT' if r.returncode == 10 else 'UNSAT' if r.returncode == 20 else 'UNKNOWN')
        assert vs[0] == vs[1] == want, f'precedence changed the verdict at k = {kk}: broken {vs[0]}, plain {vs[1]}'

    print('fs70_fabric selftest OK')
    print(f'  zeta12+u3: M = {lat.M}, rank {lat.rank}, g = {len(lat.units)}, covolume {lat.covolume():.4f}')
    print(f'  additive Z/4 {scr["Z4"]["proper"]} / Klein {scr["K4"]["proper"]}; '
          f'Lambda_forced index {scr["forced_index"]}')


PLANTS = ('basis_drop', 'sat_generators', 'screen_partial')


def run_plants():
    import subprocess as sp
    print('--- faithful twin')
    selftest()
    ok = True
    for name in PLANTS:
        print(f'--- plant {name}: the self-test must fail')
        r = sp.run([sys.executable, __file__, '--selftest', '--plant', name], capture_output=True, text=True)
        if r.returncode == 0:
            print(f'    NOT REFUSED -- plant {name} left the self-test green: the check is blind')
            ok = False
        else:
            why = (r.stderr.strip().split('\n') or [''])[-1]
            print(f'    refused (exit {r.returncode}): {why[:170]}')
    if not ok:
        raise SystemExit('a planted fault did not fire')
    print('all three plants fired; faithful twin green')


# ---------------------------------------------------------------- main

def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


if __name__ == '__main__':
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = _opt(argv, '--plant')
        FF.PLANT = None
        if PLANT not in PLANTS:
            raise SystemExit(f'unknown plant {PLANT}; known: {", ".join(PLANTS)}')
    method = _opt(argv, '--sat-method', 'auto')
    out = _opt(argv, '--out')
    core = _opt(argv, '--core', None, int)
    target = _opt(argv, '--target', 'isqrt3')
    if not argv:
        print(__doc__)
    elif '--plants' in argv:
        run_plants()
    elif '--selftest' in argv:
        selftest()
    elif argv[0] in ('lattice', 'screen'):
        specs = [a for a in argv[1:] if not a.startswith('--')
                 and a not in (method, out, target, str(core))]
        specs = []
        i = 1
        while i < len(argv):
            if argv[i].startswith('--'):
                i += 2
                continue
            specs.append(argv[i])
            i += 1
        cmd_lattice(specs, method, out if argv[0] == 'screen' else None)
    elif argv[0] == 'survivors':
        cmd_survivors(argv[1], method, target)
    elif argv[0] == 'word':
        cmd_word(argv[1], int(argv[2]), out, target, core, method, cnfs_too='--no-cnf' not in argv)
    elif argv[0] == 'wordunion':
        cmd_word(argv[1], int(argv[2]), out, target, core, method, union=True, cnfs_too='--no-cnf' not in argv)
    elif argv[0] == 'tn':
        cmd_tn(argv[1], int(argv[2]), out, target, core, method, cnfs_too='--no-cnf' not in argv)
    elif argv[0] == 'ball':
        cmd_ball(argv[1], float(argv[2]), out, core, method, cnfs_too='--no-cnf' not in argv)
    else:
        raise SystemExit(f'unknown command {argv[0]!r}; see --help / no arguments for the grammar')
