#!/usr/bin/env python3
"""fs70_rotations -- THE IN-FIELD ROTATION SWEEP over F = Q(sqrt3, sqrt5).  UNTRUSTED (tools/).

WHAT THIS IS.  Every five-colour forcer anyone has built is a base point set `B` plus a ROTATED COPY `psi.B` of
itself, joined wherever the two layers land at distance 1 (CLAUDE.md G62; [Voronov2021] section 5 -- "trying a
finite set of values for psi ... arrange the found values of psi in descending order by the number of new edges";
[Heule2019]).  FS-70 phase 1b asked that shape at ONE rotation, `rho15`, and got 78 cross edges on 352,326.  This
tool asks it at EVERY rotation of the field that makes a cross edge on the base at all, ranked by how many.

TWO ENUMERATIONS, EACH COMPLETE FOR ITS OWN BOUND (CLAUDE.md G21).  A rotation makes a cross edge exactly when
`|z - psi.w| = 1` for some `z, w` in `B`.  That can be enumerated from either end, and the two ends bound
different things:

  `scan`  -- THE LIST THIS PHASE REPORTS.  Take every unit vector `psi` of the pool and count its cross edges on
     `B` EXACTLY.  Complete for "every rotation whose DENOMINATOR is at most the pool's cap" -- a bound on the
     object of interest -- and every count in it is exact.  Cost: one grid join per rotation, parallel.

  `sweep` -- THE GENERATOR.  Write `s = psi.w - z` (a unit vector) and read the condition as
     `psi = (z + s)/w` with `|z + s| = |w|`, `w != 0`; bucket `B` by the EXACT value of `|.|^2` and look the
     matches up.  This reaches rotations of ANY denominator -- but it bounds `s` instead of `psi`, so a rotation
     whose cross edges are joined by a vector outside the pool is undercounted or missed.  Its counts are
     therefore LOWER BOUNDS and its product is a candidate list, re-counted by `scan`.

MEASURED, NOT ASSUMED, AND IT IS WHY THE TWO ARE SPLIT THIS WAY.  `rho15`'s 138 pairs are joined by unit vectors
of denominator 1, 2, 3, 4, 6, 8, 9, 12, 16, 18, 24, 36, 48, 72 and 144 -- so the atlas, which stops at 42, sees
82 of them, and after dropping the 30 with `w = 0` the sweep reports 52.  The exact anatomy reports 138.  (And
the sweep run with the base lattice's own 30 unit vectors cannot find `rho15` at all, and can produce nothing
outside the CM field: `s` in `Lambda` forces `psi = (z+s)/w` into it.)

THE THREE THINGS EVERY ROW CARRIES BESIDES ITS COUNT.
  * `two_unit` -- `psi` has 2-adic depth 0.  The base lattice is 2-INTEGRAL (its 30 unit vectors all have depth
    0), so for a 2-unit `psi` the arena lattice `Lambda + psi.Lambda` is 2-integral too, every unit vector of it
    is a unit at both primes above 2 (norm 1 and integral forces valuation 0 on both sides), and the residue map
    to the residue field of size 4 is a proper four-colouring of the WHOLE arena -- by Theorem A (CLAUDE.md row
    57), with no solver.  Such a rotation is DEAD and is counted, never asked.
  * `commensurate` -- `psi` lies in the CM field `E0 = Q(sqrt-3, sqrt-5)`, which is exactly the Q-span of the
    base lattice.  Then `psi.Lambda` and `Lambda` span the same 4-dimensional Q-space, the arena is a graph in
    ONE rank-4 lattice, and the twist is commensurate in G62's sense.  Incommensurate rotations (rho15 among
    them) give an arena lattice of rank 6 or 8.  The test is exact and costs four comparisons: `psi = (x, y)` is
    in `E0` iff `x` has no sqrt3 and no sqrt5 part and `y` has no rational and no sqrt15 part.
  * `type_m_n` -- `|1 - psi|^2 = 1/n` for an integer `n`: G7's type-M family, where a DIAGONAL circle exists at
    `|w|^2 = n`.  `rho15` is `n = 4`.

COUNTS, AND WHAT IS NOT A CROSS EDGE.  `pairs_all` is the number of ordered pairs `(z, w)` in `B^2` with
`|z - psi.w| = 1`.  Such a pair is a CROSS edge of the arena only when its two endpoints are not both inside one
half.  The origin lies in both halves for EVERY psi, so the 30 pairs with `w = 0` and the 30 with `z = 0` are
edges inside a half; a commensurate rotation, whose halves share far more, loses many more.  `scan` computes the
shared set exactly and reports `cross`, `diagonal` (the pairs with `z = w` -- G53's circle) and `off_diagonal`.

THE FLOAT THAT PROPOSES AND THE EXACT ARITHMETIC THAT DECIDES.  Every geometric question here is put to a float
grid and answered by the field: the grid proposes every pair whose squared distance is within 1e-6 of the target,
the float error on these coordinates is ~1e-15, and `e_normF(z - w) == 1` decides -- sound because the identity
embedding of F in R is injective, so the field element equals the rational 1 exactly when the real number does.
In the sweep the norm match is exact too (the hash is verified against the full field element before any hit is
taken), the grouping of ten million hits into rotations is by the float ANGLE binned at 1e-9 radians with no two
occupied bins adjacent, and that grouping is then CHECKED EXACTLY on every class the run reports.

Commands
  python3 tools/fs70_rotations.py scan  SPEC k [--pool atlas|lattice|denom:N] [--out F] [--top N] [--jobs N]
  python3 tools/fs70_rotations.py sweep SPEC k [--pool atlas|lattice|denom:N] [--out F] [--top N]
  python3 tools/fs70_rotations.py anatomy SPEC k --psi 'A,B,C,D,E,F,G,H,m' [--out DIR] [--lattice-check]
  python3 tools/fs70_rotations.py count SPEC k --psi ...        # G53's counting screen on the base alone
  python3 tools/fs70_rotations.py screen SPEC k --psi ...      # the 2-unit theorem, checked: an explicit
                                                              # additive four-colouring of the arena, no solver
  python3 tools/fs70_rotations.py --selftest [--plants]

Planted faults (--plant): psi_digit (rho15 is fed with one wrong digit and must be refused as a rotation),
norm_match_loose (the exact field-element check after the hash lookup is skipped, so hash collisions produce
rotations that are not unit vectors), centre_uncorrected (the 60 shared-centre pairs are left in the cross count,
so rho15 reads 138 where the arena has 78), geom_tol_tight (the geometric proposal band is collapsed to zero
width, so the exact anatomy misses every cross edge), pool_truncated (the pool of `s` is silently cut to its
first eight vectors -- a negative that measures its enumeration), grid_radius_short (the grid neighbourhood is
one cell short -- the defect this tool actually shipped with, which lost six of a known 42,660 pairs).
"""
from collections import defaultdict
from fractions import Fraction as Fr
import hashlib
import json
import math
import os
import sys
import time

import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs70_fabric as FB                                                         # noqa: E402
import fs70_field as FF                                                          # noqa: E402

PLANT = None
for _i, _a in enumerate(sys.argv):
    if _a == '--plant' and _i + 1 < len(sys.argv):
        PLANT = sys.argv[_i + 1]

PLANTS = ('psi_digit', 'norm_match_loose', 'centre_uncorrected', 'geom_tol_tight', 'pool_truncated',
          'grid_radius_short')

ATLAS = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'data', 'fs70', 'atlas.jsonl')
ANGLE_SCALE = 1e9                 # the angle bin, in radians^-1; float error is ~1e-15
GEOM_TOL = 1e-6                   # the proposal band on |.|^2; the exact field test decides


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- exact arithmetic this tool adds

def e_scale_field(u, z):
    """multiply an element of E = F(i) by an element of F"""
    return (FF.f_mul(u, z[0]), FF.f_mul(u, z[1]))


def e_div(p, q):
    """p / q in E, exactly: p conj(q) / |q|^2, with the field inverse of the norm"""
    n = FF.e_normF(q)
    if n == FF.ZERO:
        raise ZeroDivisionError('division by the zero vector')
    return e_scale_field(FF.f_inv(n), FF.e_mul(p, FF.e_conj(q)))


def in_CM(z):
    """is z in E0 = Q(sqrt-3, sqrt-5), the Q-span of the CM base lattice?

    E0 = Q<1, sqrt15, i sqrt3, i sqrt5>: the real part carries no sqrt3 and no sqrt5, the imaginary part no
    rational and no sqrt15.  A rotation in E0 maps the base lattice's Q-span to itself, so the arena stays inside
    ONE rank-4 lattice -- G62's commensurate twist."""
    x, y = z
    return x[1] == 0 and x[2] == 0 and y[0] == 0 and y[3] == 0


def type_m_n(psi):
    """the integer n of G7's type-M family (|1 - psi|^2 = 1/n, diagonal circle |w|^2 = n), or None"""
    q = FF.e_normF(FF.e_sub(FF.E_ONE, psi))
    if any(v != 0 for v in q[1:]) or q[0] == 0:
        return None
    inv = Fr(1) / q[0]
    return int(inv) if inv.denominator == 1 else None


def galois(z, s3, s5):
    """the Galois action of Gal(F/Q) on E = F(i), fixing i: sqrt3 -> s3 sqrt3, sqrt5 -> s5 sqrt5.

    It maps the base lattice to itself (its generators zeta6 and u are permuted: zeta6 -> zeta6^{+-1},
    u -> u^{+-1}), preserves `x^2 + y^2 = 1`, and therefore carries the whole arena to an ISOMORPHIC arena with
    the same cross-edge count.  CLAUDE.md G27's hidden arithmetic symmetry, used here to quotient the list."""
    def g(u):
        return (u[0], s3 * u[1], s5 * u[2], s3 * s5 * u[3])
    return (g(z[0]), g(z[1]))


_Z6 = [FF.e_pow(FF.ZETA6, m) for m in range(6)]


def sym_orbit(psi):
    """the orbit of psi under the group that preserves the arena's cross-edge count: multiplication by a sixth
    root of unity (the base is zeta6-invariant), inversion (= conjugation on a unit vector; it swaps the two
    halves) and the four Galois maps.  Order at most 48."""
    out = {}
    for s3 in (1, -1):
        for s5 in (1, -1):
            w = galois(psi, s3, s5)
            for inv in (False, True):
                v = FF.e_conj(w) if inv else w
                for zr in _Z6:
                    r = FF.e_mul(zr, v)
                    out[FF.canonical(r)] = r
    return list(out.values())


def sym_orbit_angles(psi):
    """the 48 orbit members' ANGLES, in floats, without building a single field element.

    Each of the three generators is one line in float: a Galois map re-embeds the four rational coordinates with
    signs, conjugation negates the angle, and multiplication by zeta6^m adds m pi/3.  The exact orbit is the same
    set; this is 20 float operations against 3.3 ms of Fraction arithmetic, and it is only ever used to find
    which OTHER bins of the sweep are siblings -- the bin's own psi and its canonical name stay exact."""
    (a, b, c, d), (e, f, g, h) = psi
    a, b, c, d = float(a), float(b), float(c), float(d)
    e, f, g, h = float(e), float(f), float(g), float(h)
    out = []
    for s3 in (1.0, -1.0):
        for s5 in (1.0, -1.0):
            x = a + s3 * b * S3F + s5 * c * S5F + s3 * s5 * d * S3F * S5F
            y = e + s3 * f * S3F + s5 * g * S5F + s3 * s5 * h * S3F * S5F
            th = math.atan2(y, x)
            for sgn in (1.0, -1.0):                     # conjugation = inversion on a unit vector
                for m in range(6):                      # multiplication by zeta6^m
                    out.append(sgn * th + m * math.pi / 3.0)
    return out


def canonical_psi(psi):
    """the lexicographically least nine-integer form in the orbit -- one name per class"""
    best = None
    for s3 in (1, -1):
        for s5 in (1, -1):
            w = galois(psi, s3, s5)
            for inv in (False, True):
                v = FF.e_conj(w) if inv else w
                for zr in _Z6:
                    t = FF.e_to_ints(FF.e_mul(zr, v))
                    if best is None or t < best:
                        best = t
    return best


def same_class(a, b):
    """is b in the exact symmetry orbit of a?  The grouping is done on float angles for speed; this is the
    exact check, run on every class this tool actually reports."""
    kb = FF.canonical(b)
    return any(FF.canonical(r) == kb for r in sym_orbit(a))


def psi_from_arg(text):
    """'A,B,C,D,E,F,G,H,m' -> the exact element, asserted to be a unit vector"""
    t = tuple(int(v) for v in text.replace(' ', '').split(','))
    if len(t) != 9:
        raise SystemExit(f'--psi wants nine integers A,..,H,m; got {len(t)}')
    z = FF.e_from_ints(t)
    if planted('psi_digit'):
        z = (tuple(z[0][:1]) + (Fr(1, 8),) + tuple(z[0][2:]), z[1])     # PLANT: one wrong digit
    if not FF.e_is_unit_vector(z):
        raise SystemExit(f'{FF.e_str(z)} is not a unit vector (|.|^2 = {FF.f_str(FF.e_normF(z))}): '
                         f'it is not a rotation of this plane and no arena can be built on it')
    return z


# ---------------------------------------------------------------- the base, the pool, the vectorised norms

def base_ball(spec, k):
    lat = FB.Lattice(FB.generators(spec), spec)
    lat.saturate('b')
    pts = list(FB.word_ball(lat, k))
    return lat, pts


def pool_vectors(name, lat):
    """the pool of unit vectors `s`, as nine-integer tuples, with the name that goes in the header"""
    if name == 'lattice':
        return [FF.e_to_ints(z) for z in lat.units], f'the base lattice\'s own saturation ({len(lat.units)})'
    rows = [json.loads(l) for l in open(ATLAS)]
    if name.startswith('denom:'):
        cap = int(name.split(':')[1])
        rows = [r for r in rows if r['m'] <= cap]
        nm = f'every unit vector of denominator <= {cap} ({len(rows)})'
    else:
        nm = f'the atlas: every unit vector of denominator <= {max(r["m"] for r in rows)} ({len(rows)})'
    out = [tuple(r['x'] + r['y']) + (r['m'],) for r in rows]
    if planted('pool_truncated'):
        out = out[:8]                                  # PLANT: the pool silently cut
    return out, nm


def imul_np(p, q):
    a1, b1, c1, d1 = p[:, 0], p[:, 1], p[:, 2], p[:, 3]
    a2, b2, c2, d2 = q[:, 0], q[:, 1], q[:, 2], q[:, 3]
    return np.stack([a1 * a2 + 3 * b1 * b2 + 5 * c1 * c2 + 15 * d1 * d2,
                     a1 * b2 + b1 * a2 + 5 * (c1 * d2 + d1 * c2),
                     a1 * c2 + c1 * a2 + 3 * (b1 * d2 + d1 * b2),
                     a1 * d2 + d1 * a2 + b1 * c2 + c1 * b2], axis=1)


def norms_np(V):
    """|v|^2 as an integer 4-tuple over the square of the denominator V is written over"""
    return imul_np(V[:, :4], V[:, :4]) + imul_np(V[:, 4:], V[:, 4:])


def _hash4(N):
    return (N[:, 0] * 1000003 + N[:, 1] * 1000033 + N[:, 2] * 1000037 + N[:, 3] * 1000039)


S3F, S5F = math.sqrt(3), math.sqrt(5)


def cfloat(V, den):
    s15 = S3F * S5F
    return (((V[:, 0] + V[:, 1] * S3F + V[:, 2] * S5F + V[:, 3] * s15) / den)
            + 1j * ((V[:, 4] + V[:, 5] * S3F + V[:, 6] * S5F + V[:, 7] * s15) / den))


# ---------------------------------------------------------------- the sweep

def sweep(spec, k, pool='atlas', verbose=True, verify_top=25):
    """the `(z + s)/w` generator: every rotation, at ANY denominator, with a cross edge on the word ball whose
    joining unit vector lies in the pool.  Its counts are LOWER BOUNDS (see the row comment); `scan` is what
    counts.  Its value is that it reaches rotations the atlas does not contain."""
    t0 = time.time()
    lat, pts = base_ball(spec, k)
    M = lat.M
    Z = np.array(pts, dtype=np.int64)
    n = len(pts)
    zero = pts.index(tuple([0] * 8))
    S, pool_name = pool_vectors(pool, lat)
    if verbose:
        print(f'base {spec} at sums of <= {k}: {n} points, lattice M = {M}, rank {lat.rank}, '
              f'{len(lat.units)} unit vectors')
        print(f'pool of s: {pool_name}')

    NB = norms_np(Z)
    kb = _hash4(NB)
    ordb = np.argsort(kb, kind='stable')
    kbs = kb[ordb]
    uk, ustart = np.unique(kbs, return_index=True)
    ucount = np.diff(np.append(ustart, n))
    UN = NB[ordb[ustart]]                       # the exact norm of each hash class, for the exact check
    zf = cfloat(Z, M)
    if verbose:
        print(f'{len(uk)} norm classes, largest {int(ucount.max())}   ({time.time()-t0:.1f}s)')

    KEYS, SI, IZ, IW = [], [], [], []
    t1 = time.time()
    for si, s9 in enumerate(S):
        m = s9[8]
        L = math.lcm(M, m)
        K1, K2 = L // M, L // m
        sv = np.array(s9[:8], dtype=np.int64)
        P = K1 * Z + K2 * sv
        NP = norms_np(P)
        ok = (NP % (K1 * K1) == 0).all(axis=1)
        iz = np.nonzero(ok)[0]
        if not len(iz):
            continue
        NQ = NP[ok] // (K1 * K1)
        kq = _hash4(NQ)
        idx = np.clip(np.searchsorted(uk, kq), 0, len(uk) - 1)
        hit = (uk[idx] == kq)
        if not planted('norm_match_loose'):
            hit &= (UN[idx] == NQ).all(axis=1)    # PLANT (when skipped): a hash collision becomes a "rotation"
        iz, idx = iz[hit], idx[hit]
        if not len(iz):
            continue
        cnts, starts = ucount[idx], ustart[idx]
        tot = int(cnts.sum())
        oz = np.repeat(iz, cnts)
        ar = np.arange(tot) - np.repeat(np.cumsum(cnts) - cnts, cnts) + np.repeat(starts, cnts)
        ow = ordb[ar]
        keep = ow != zero                        # w = 0 gives |z + s| = 0 and psi = 0/0: not a rotation
        oz, ow = oz[keep], ow[keep]
        if not len(oz):
            continue
        pf = cfloat(P, L)
        psi = pf[oz] / zf[ow]
        KEYS.append(np.rint(np.angle(psi) * ANGLE_SCALE).astype(np.int64))
        SI.append(np.full(len(oz), si, dtype=np.int32))
        IZ.append(oz.astype(np.int32))
        IW.append(ow.astype(np.int32))
    if not KEYS:
        raise SystemExit('the pool produced no cross edge at all on this base: nothing to rank')
    K = np.concatenate(KEYS)
    SIa, IZa, IWa = np.concatenate(SI), np.concatenate(IZ), np.concatenate(IW)
    if verbose:
        print(f'{len(K):,} (z, s, w) hits   ({time.time()-t1:.1f}s)')

    o = np.argsort(K, kind='stable')
    Ks = K[o]
    ub, bst = np.unique(Ks, return_index=True)
    bcnt = np.diff(np.append(bst, len(Ks)))
    diag = np.add.reduceat((IZa[o] == IWa[o]).astype(np.int64), bst)
    rep = o[bst]
    adjacent = int((np.diff(ub) == 1).sum())
    if verbose:
        print(f'{len(ub):,} occupied angle bins; adjacent occupied bins (a rotation could be split): {adjacent}')

    # the exact rotation of every bin, and the symmetry class it belongs to
    t2 = time.time()
    exact, bad = [], 0
    for b in range(len(ub)):
        r = int(rep[b])
        s9 = S[int(SIa[r])]
        # plain ints, never numpy ones: a Fraction built on a numpy.int64 is unhashable (its __hash__ calls
        # pow(den, -1, m)), and it fails at the first canonical() rather than where it was made
        z = FF.e_from_ints(FF.ints_reduce(pts[int(IZa[r])], M))
        w = FF.e_from_ints(FF.ints_reduce(pts[int(IWa[r])], M))
        p = FF.e_add(z, FF.e_from_ints(s9))
        psi = e_div(p, w)
        if not FF.e_is_unit_vector(psi):
            bad += 1
            exact.append(None)
            continue
        exact.append(psi)
    if bad:
        raise SystemExit(f'{bad} of {len(ub)} bins produced a psi that is NOT a unit vector: the norm match is '
                         f'not exact (this is what --plant norm_match_loose does)')
    if verbose:
        print(f'exact psi for every bin ({time.time()-t2:.1f}s); grouping into symmetry classes')

    # group bins into classes: every orbit member of a bin's psi is itself a bin (the symmetry maps the sweep's
    # hits to the sweep's hits), so the orbit's float angles name the sibling bins directly.
    t3 = time.time()
    bin_of = {int(v): i for i, v in enumerate(ub)}
    parent = list(range(len(ub)))

    def find(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]
            a = parent[a]
        return a

    def union(a, b):
        ra, rb = find(a), find(b)
        if ra != rb:
            parent[max(ra, rb)] = min(ra, rb)

    TWO_PI = 2.0 * math.pi
    for b, psi in enumerate(exact):
        for th in sym_orbit_angles(psi):
            th = (th + math.pi) % TWO_PI - math.pi           # back into (-pi, pi], where np.angle put the bins
            kk = int(round(th * ANGLE_SCALE))
            for d in (0, -1, 1):
                j = bin_of.get(kk + d)
                if j is not None:
                    union(b, j)
                    break
    groups = defaultdict(list)
    for b in range(len(ub)):
        groups[find(b)].append(b)
    if verbose:
        print(f'{len(groups):,} symmetry classes   ({time.time()-t3:.1f}s)')

    # The members of a class NEED NOT agree here, and that is a property of this enumeration rather than a
    # defect: the bijection that carries psi's triples to (zeta6 psi)'s sends s to zeta6.s, whose denominator
    # can be twice s's and so can fall outside the pool.  (Galois preserves denominators, so it does preserve
    # the count.)  The class is reported at its LARGEST member, the best lower bound the pool supports.  The
    # scan's identical control IS sound, because there each member's count is computed from the geometry.
    rows, unequal = [], 0
    for g, members in groups.items():
        cs = {int(bcnt[b]) for b in members}
        if len(cs) != 1:
            unequal += 1
        # the representative: the member with the largest diagonal, as in `scan` -- which is the type-M member
        # where the class has one, since `|1 - psi|` moves when psi is multiplied by a sixth root of unity and
        # `type_m_n` and `diagonal` are properties of the member, not of the class
        b = max(members, key=lambda x: (int(diag[x]), int(bcnt[x])))
        psi = exact[b]
        r = flags(psi)
        # NOT the cross count: only the (z, w) pairs whose joining unit vector s = psi.w - z lies in the pool,
        # and with w = 0 dropped.  MEASURED on rho15: 52 of its 138 pairs, because 56 of the 138 have s of
        # denominator up to 144 while the atlas stops at 42.  A LOWER bound, and a candidate generator.
        r.update(orbit=len(members), cross_lower=int(bcnt[b]), diagonal_lower=int(diag[b]),
                 counts_equal_in_class=len(cs) == 1)
        if planted('centre_uncorrected'):
            r['cross_lower'] += 60                  # PLANT: the shared-centre pairs put back in
        r['_members'] = members
        rows.append(r)
    rows.sort(key=lambda r: (-r['cross_lower'], -r['diagonal_lower']))

    # THE GROUPING IS BY FLOAT ANGLE; THIS IS ITS EXACT CHECK, on every class this run reports or asks.  Two
    # rotations that the float bins merged would land here as a member whose exact psi is NOT in the
    # representative's orbit.
    checked = 0
    for r in rows[:verify_top]:
        rep = FF.e_from_ints(tuple(r['psi']))
        for b in r['_members']:
            if not same_class(rep, exact[b]):
                raise SystemExit(f'class {r["psi_str"]} has a member whose exact psi = {FF.e_str(exact[b])} is '
                                 f'NOT in its symmetry orbit: the float-angle grouping merged two rotations')
        checked += 1
    for r in rows:
        del r['_members']
    if verbose:
        print(f'the exact orbit check passed on the top {checked} classes')
    meta = {'base_spec': spec, 'base_k': k, 'base_points': n, 'base_M': M, 'base_rank': lat.rank,
            'base_units': len(lat.units), 'base_lattice_sha': lat.sha(), 'pool': pool, 'pool_name': pool_name,
            'pool_size': len(S), 'hits': int(len(K)), 'bins': int(len(ub)), 'classes': len(rows),
            'adjacent_bins': adjacent, 'classes_with_unequal_counts': unequal,
            'angle_scale': ANGLE_SCALE, 'seconds': round(time.time() - t0, 1),
            'route': 'the (z + s)/w generator: complete for rotations whose JOINING unit vector lies in the '
                     'pool, at any denominator of psi; its counts are LOWER BOUNDS on the cross count and its '
                     'product is a candidate list, re-counted exactly by `scan`'}
    if unequal and verbose:
        print(f'   {unequal} of {len(rows)} classes have members with unequal counts -- expected, since the '
              f'pool is not closed under multiplication by zeta6; each is reported at its largest member')
    return meta, rows, (lat, pts)


# ---------------------------------------------------------------- the exact arena anatomy

CELL = 0.5


def _grid(xs, ys):
    cells = defaultdict(list)
    fx = np.floor(xs / CELL).astype(np.int64)
    fy = np.floor(ys / CELL).astype(np.int64)
    for j in range(len(xs)):
        cells[(int(fx[j]), int(fy[j]))].append(j)
    return {c: np.array(v, dtype=np.int64) for c, v in cells.items()}


def near_pairs(bf, pf, target=1.0, tol=GEOM_TOL):
    """every (i, j) whose FLOAT squared distance is within `tol` of `target`, by a grid of cell `CELL`.

    This only PROPOSES.  The float error on these coordinates is ~1e-15, six orders of magnitude below the band,
    so the proposal is a superset of the true set and cannot miss a pair; exact field arithmetic decides each
    one at the call site.

    THE CELL RADIUS IS DERIVED, NOT GUESSED, AND THE GUESS WAS WRONG.  With cell 1 and the obvious 3x3
    neighbourhood this routine silently LOST pairs: `floor` puts a rotated coordinate that lands at
    0.9999999999999998 a whole cell below one that lands at 1.0, and a pair with `|dx|` near 1 then straddles
    TWO cells.  Measured, at psi = zeta6 on the 4,141-point ball: 6 of 42,660 pairs missing -- and a missing
    cross edge makes an arena EASIER to colour, so the defect flatters exactly the null this phase is looking
    for.  Found by the symmetry control (a class's members must have equal cross counts), which was written for
    something else.  The radius is now `int(D/CELL) + 1` with `D = sqrt(target + tol)` the largest distance a
    pair can have, which bounds `|floor(a) - floor(b)|` for `|a - b| <= D/CELL` with nothing left to chance."""
    if planted('geom_tol_tight'):
        tol = 0.0                                  # PLANT: a zero-width band proposes nothing
    bx, by, px, py = bf.real, bf.imag, pf.real, pf.imag
    R = int(math.sqrt(target + tol) / CELL) + 1
    if planted('grid_radius_short'):
        R = max(1, R - 1)                          # PLANT: the radius this routine got wrong once already
    cells = _grid(px, py)
    out = []
    off = [(dx, dy) for dx in range(-R, R + 1) for dy in range(-R, R + 1)]
    for (cx, cy), bi in _grid(bx, by).items():
        near = [cells[(cx + dx, cy + dy)] for dx, dy in off if (cx + dx, cy + dy) in cells]
        if not near:
            continue
        pj = np.concatenate(near)
        d2 = (bx[bi][:, None] - px[pj][None, :]) ** 2 + (by[bi][:, None] - py[pj][None, :]) ** 2
        ii, jj = np.nonzero(np.abs(d2 - target) <= tol)
        out.extend(zip(bi[ii].tolist(), pj[jj].tolist()))
    return out


def cross_pairs(B, PB, bf, pf, tol=GEOM_TOL):
    """every (i, j) with |B[i] - PB[j]| = 1 EXACTLY: the grid proposes, the field decides.

    The exact decision is sound because the identity embedding F -> R is injective: the field element
    |B[i] - PB[j]|^2 equals the rational 1 exactly when the real number does."""
    return [(i, j) for i, j in near_pairs(bf, pf, 1.0, tol)
            if FF.e_normF(FF.e_sub(B[i], PB[j])) == FF.ONE]


def overlap_indices(B, bf, PB, pf):
    """(the j with PB[j] in B, the i with B[i] in PB) -- the points the two halves SHARE.

    Always at least the centre, since psi fixes the origin.  A commensurate rotation shares far more, and every
    shared point turns what the sweep counts as a cross pair into an edge INSIDE a half."""
    pairs = near_pairs(bf, pf, 0.0, GEOM_TOL)
    jb, ip = set(), set()
    for i, j in pairs:
        if FF.canonical(B[i]) == FF.canonical(PB[j]):
            jb.add(j)
            ip.add(i)
    return jb, ip


def diagonal_circle(lat, pts, psi):
    """the base points `w` with `|w - psi.w| = 1`, i.e. `|w|^2 = 1/|1 - psi|^2` -- G53's circle.

    fs70_arena builds this only for a type-M rotation, where `|1 - psi|^2` is `1/n` for an integer `n`.  It
    exists for ANY rotation whose `1/|1 - psi|^2` is a norm the base realises; type-M is the case where that
    norm is a rational integer."""
    q = FF.e_normF(FF.e_sub(FF.E_ONE, psi))
    if q == FF.ZERO:
        return None, []
    r = FF.f_inv(q)
    out = []
    for i, p in enumerate(pts):
        z = FF.e_from_ints(FF.ints_reduce(list(p), lat.M))
        if FF.e_normF(z) == r:
            out.append(i)
    return r, out


def counting_screen(spec, k, psi, colours=4, solver='cadical195', verbose=True):
    """G53's counting compulsion on the base alone: `2L > (circle count)` refutes the arena with no arena solve.

    `L` is the least number of circle points carrying the centre's colour over all proper colourings of the
    BASE, by a cardinality constraint and a binary search -- fs70_arena's `min_share`, reused unchanged so that
    the instrument (and its two-sided control, whose UNSAT branch has to be seen to fire) is the one phase 1b
    already validated."""
    import fs70_arena as AR
    lat, pts = base_ball(spec, k)
    keys, edges = FB.unit_graph(pts, lat)
    r, circ = diagonal_circle(lat, keys, psi)
    zero = keys.index(tuple([0] * 8))
    if not circ:
        return {'circle': 0, 'note': 'the diagonal circle is empty in this base: G53 says nothing'}
    L, best, trail = AR.min_share(len(keys), edges, zero, circ, colours, solver, None, verbose)
    return {'circle': len(circ), 'radius_sq': FF.f_str(r), 'L': L, 'ratio': L / len(circ),
            'refutes': 2 * L > len(circ), 'achieved': best['achieved'] if best else None}


def flags(psi):
    """everything about a rotation that is decided by arithmetic alone, before any geometry"""
    z6 = {FF.canonical(z) for z in _Z6}
    return {'psi': list(FF.e_to_ints(psi)), 'psi_canonical': list(canonical_psi(psi)),
            'psi_str': FF.e_str(psi), 'den': FF.e_denominator(psi), 'depth2': FF.depths(psi)[0],
            'two_unit': FF.is_two_unit(psi), 'commensurate': in_CM(psi), 'type_m_n': type_m_n(psi),
            'trivial': FF.canonical(psi) in z6}


_SCAN = {}


def _scan_init(spec, k):
    lat, pts = base_ball(spec, k)
    B = [FF.e_from_ints(FF.ints_reduce(list(p), lat.M)) for p in pts]
    bf = np.array([complex(FF.f_float(z[0]), FF.f_float(z[1])) for z in B])
    _SCAN.update(lat=lat, pts=pts, B=B, bf=bf)


def scan_one(psi9):
    """the EXACT cross-edge anatomy of one rotation on the shared base -- the scan's unit of work.

    psi.B is taken in FLOAT for the grid join (instant) and EXACTLY only on the few hundred pairs the join
    proposes, which is what makes a 2,020-rotation scan a few minutes rather than a day."""
    psi = FF.e_from_ints(tuple(psi9))
    B, bf = _SCAN['B'], _SCAN['bf']
    pf = bf * complex(FF.f_float(psi[0]), FF.f_float(psi[1]))

    class _PB:                    # psi.B, computed exactly only where it is asked for
        def __getitem__(self, j):
            return FF.e_mul(psi, B[j])
    PB = _PB()
    jb, ip = overlap_indices(B, bf, PB, pf)
    pairs = cross_pairs(B, PB, bf, pf)
    cross = [(i, j) for i, j in pairs if j not in jb and i not in ip]
    diag = sum(1 for i, j in cross if i == j)
    row = flags(psi)
    row.update(pairs_all=len(pairs), shared=len(jb), cross=len(cross), diagonal=diag,
               off_diagonal=len(cross) - diag)
    return row


def scan(spec, k, pool='atlas', jobs=14, verbose=True, partial=None):
    """EVERY rotation in the pool, with its exact cross-edge count on the base.

    This is the list the phase reports.  It is complete for "every unit vector of E = F(i) whose denominator is
    at most the pool's cap", which is a bound on the ROTATION itself -- the object of interest -- and every count
    in it is exact.  (The `(z + s)/w` sweep below reaches rotations of unbounded denominator but bounds the
    JOINING vector instead, so its counts are lower bounds; the two are complementary and both are run.)"""
    import multiprocessing as mp
    t0 = time.time()
    lat, pts = base_ball(spec, k)
    S, pool_name = pool_vectors(pool, lat)
    if verbose:
        print(f'base {spec} at sums of <= {k}: {len(pts)} points, lattice M = {lat.M}, rank {lat.rank}, '
              f'{len(lat.units)} unit vectors')
        print(f'scanning {len(S)} rotations ({pool_name}) on {jobs} workers')
    # EVERY ROW IS ON DISK AS IT LANDS (CLAUDE.md's checkpointing rule): a kill costs the rotations in flight
    # and nothing decided, and a re-run with the same `partial` path picks up where it stopped.  Resume
    # command and cost are in `data/fs70/records/phase-1c.md`.
    done, rows = {}, []
    if partial and os.path.exists(partial):
        for line in open(partial):
            r = json.loads(line)
            done[tuple(r['psi'])] = r
        if verbose:
            print(f'resuming: {len(done)} rotations already counted in {partial}')
    todo = [list(s) for s in S if tuple(s) not in done]
    rows.extend(done.values())
    ctx = mp.get_context('fork')          # Python 3.14 defaults to forkserver, where a worker re-imports and
    fh = open(partial, 'a') if partial else None                            # loses the parent's base entirely
    with ctx.Pool(jobs, initializer=_scan_init, initargs=(spec, k)) as p:
        for i, r in enumerate(p.imap_unordered(scan_one, todo, chunksize=1)):
            rows.append(r)
            if fh:
                fh.write(json.dumps(r) + '\n')
                fh.flush()
            if verbose and (i + 1) % 100 == 0:
                print(f'   {i+1}/{len(todo)} rotations counted ({time.time()-t0:.0f}s)', flush=True)
    if fh:
        fh.close()
    # THE CONTROL ON THE WHOLE SCAN, and it is free: the arena of `psi` and of `zeta6^m . sigma(psi)^{+-1}` is
    # ONE graph (rotate the plane by zeta6^-m, swap the halves, apply the field automorphism), so every member
    # of a symmetry class must return the same `cross`, `pairs_all` and `shared`.  `diagonal` must NOT: it names
    # the pairs with `z = w`, which is a fact about the chosen parametrisation of the class and not about the
    # graph -- `|w - psi.w| = |1 - psi||w|` moves when psi is multiplied by a sixth root of unity.  So the class
    # is reported at the member with the LARGEST diagonal, which is the type-M one where the class has one.
    byclass, unequal = {}, 0
    for r in rows:
        kk = tuple(r['psi_canonical'])
        if kk in byclass:
            b = byclass[kk]
            if (b['cross'], b['pairs_all'], b['shared']) != (r['cross'], r['pairs_all'], r['shared']):
                unequal += 1
                print(f'   UNEQUAL in class {kk}: {b["psi_str"]} gives '
                      f'{(b["cross"], b["pairs_all"], b["shared"])} and {r["psi_str"]} gives '
                      f'{(r["cross"], r["pairs_all"], r["shared"])}')
            n = b['members'] + 1
            if r['diagonal'] > b['diagonal']:
                r['members'] = n
                byclass[kk] = r
            else:
                b['members'] = n
        else:
            r['members'] = 1
            byclass[kk] = r
    out = sorted(byclass.values(), key=lambda r: (-r['off_diagonal'], -r['cross']))

    # the second control, with an answer known by hand: psi in <zeta6> maps the zeta6-invariant base ONTO
    # itself, so its pairs are exactly the ordered unit-distance pairs of the base.  This is the case the grid
    # join got wrong, and it is checked on every run rather than only in the self-test.
    _, bedges = FB.unit_graph(pts, lat)
    for r in rows:
        if r['trivial'] and r['pairs_all'] != 2 * len(bedges):
            raise SystemExit(f'psi = {r["psi_str"]} maps the base onto itself, so it must give exactly '
                             f'{2*len(bedges)} pairs (twice the base\'s {len(bedges)} edges); it gives '
                             f'{r["pairs_all"]}.  The geometric join is losing pairs.')
    meta = {'base_spec': spec, 'base_k': k, 'base_points': len(pts), 'base_M': lat.M,
            'base_rank': lat.rank, 'base_units': len(lat.units), 'base_lattice_sha': lat.sha(),
            'pool': pool, 'pool_name': pool_name, 'pool_size': len(S), 'classes': len(out),
            'classes_with_unequal_counts': unequal, 'seconds': round(time.time() - t0, 1),
            'route': 'exact: a float grid proposes every pair near distance 1 and the field decides'}
    if unequal:
        raise SystemExit(f'{unequal} symmetry classes have members with different cross counts: the Galois and '
                         f'zeta6 maps are supposed to carry the arena to the SAME graph')
    if verbose:
        print(f'{len(out)} symmetry classes of {len(S)} rotations   ({meta["seconds"]}s); '
              f'the class-equality control passed on all of them')
    return meta, out


def arena_exact(spec, k, psi, verbose=True):
    """the arena A = B union psi.B with its COMPLETE unit-distance graph and its anatomy.

    Completeness, in two halves.  Within a half: `FB.unit_graph` steps every unit vector of the base lattice's
    saturation from every point, and the saturation is complete by construction, so a half's graph is the base's
    own -- and psi is an isometry, so the rotated half's graph is the same index pairs.  Between the halves: the
    geometric join above, whose float band cannot miss an edge.  So the arena graph is complete, and a COLOURING
    of it means something (a partial graph's would not)."""
    t0 = time.time()
    lat, pts = base_ball(spec, k)
    M = lat.M
    keys, bedges = FB.unit_graph(pts, lat)
    B = [FF.e_from_ints(FF.ints_reduce(list(p), M)) for p in keys]
    PB = [FF.e_mul(psi, z) for z in B]
    bf = np.array([complex(FF.f_float(z[0]), FF.f_float(z[1])) for z in B])
    pf = np.array([complex(FF.f_float(z[0]), FF.f_float(z[1])) for z in PB])
    cp = cross_pairs(B, PB, bf, pf)

    kb = [FF.canonical(z) for z in B]
    kp = [FF.canonical(z) for z in PB]
    index, apts = {}, []
    for kk in kb + kp:
        if kk not in index:
            index[kk] = len(apts)
            apts.append(kk)
    i0 = [index[kk] for kk in kb]
    i1 = [index[kk] for kk in kp]
    shared = len(set(i0) & set(i1))

    E = set()
    for a, b in bedges:
        E.add(tuple(sorted((i0[a], i0[b]))))
    n_in0 = len(E)
    for a, b in bedges:
        E.add(tuple(sorted((i1[a], i1[b]))))
    inside0, inside1 = set(i0), set(i1)
    ncross, ndiag = 0, 0
    for a, b in cp:
        e = tuple(sorted((i0[a], i1[b])))
        E.add(e)
        if not ((e[0] in inside0 and e[1] in inside0) or (e[0] in inside1 and e[1] in inside1)):
            ncross += 1
            if a == b:
                ndiag += 1
    edges = sorted(E)
    anat = {'points': len(apts), 'edges': len(edges), 'base_points': len(keys), 'base_edges': len(bedges),
            'shared_points': shared, 'within_half0': n_in0, 'cross': ncross, 'diagonal': ndiag,
            'off_diagonal': ncross - ndiag, 'cross_pairs_all': len(cp)}
    if verbose:
        print(f'arena {spec} at <= {k} with psi = {FF.e_str(psi)}: {len(apts)} points '
              f'({len(keys)} per half, {shared} shared), {len(edges)} edges, avg degree '
              f'{2*len(edges)/len(apts):.2f}   ({time.time()-t0:.1f}s)')
        print(f'   cross edges: {ncross} ({ndiag} diagonal, {ncross-ndiag} off-diagonal); '
              f'(z, w) pairs at distance 1: {len(cp)}')
    return lat, apts, edges, anat, (B, PB, i0, i1)


def write_arena(out, spec, k, psi, apts, edges, anat, lat):
    """graph.json in fs70_fabric's schema, so fs70_ask.py can ask it"""
    os.makedirs(out, exist_ok=True)
    MA = 1
    for kk in apts:
        MA = math.lcm(MA, FF.e_denominator((kk[0], kk[1])))
    pts8 = [FF.ints_over(FF.e_to_ints((kk[0], kk[1])), MA) for kk in apts]
    gens = list(lat.S) + [FF.e_mul(psi, z) for z in lat.S]
    A = FB.Lattice(gens, f'arena({spec},{",".join(str(v) for v in FF.e_to_ints(psi))})')
    N = len(pts8)
    meta = {'lattice': A.spec, 'lattice_sha': A.sha(), 'M': MA, 'rank': A.rank, 'g': None,
            'shape': {'shape': 'arena', 'k': k, 'psi': list(FF.e_to_ints(psi))},
            'points': N, 'edges': len(edges), 'avg_degree': 2 * len(edges) / N, 'partial': False,
            'base_spec': spec, 'base_lattice_sha': lat.sha(), 'arena': anat,
            'edge_derivation': 'within a half: the base lattice saturation (complete by construction); between '
                               'the halves: a float grid proposing and exact field arithmetic deciding',
            'cnf_sha': {}}
    meta['points_sha256'] = hashlib.sha256(
        json.dumps(sorted(pts8), separators=(',', ':')).encode()).hexdigest()
    with open(os.path.join(out, 'graph.json'), 'w') as f:
        json.dump({'meta': meta, 'M': MA, 'points': [list(p) for p in pts8],
                   'edges': [list(e) for e in edges]}, f)
    print(f'  wrote {out}: {N} points, {len(edges)} edges, avg degree {2*len(edges)/N:.2f}, M = {MA}')
    return meta


# ---------------------------------------------------------------- the 2-unit theorem, checked

def additive_arena(A, apts, edges, verbose=True):
    """an ADDITIVE four-colouring of an arena GRAPH, or the exact statement that it has none.

    Not the additive screen of `fs70_fabric`, which asks for a colouring proper on every unit vector of a
    SATURATED lattice: that needs the saturation, which costs the box of the arena's denominator and is
    unaffordable above M = 144.  This asks the weaker and sufficient question -- is there a homomorphism to a
    group of order 4 that is nonzero on every EDGE DIFFERENCE THIS GRAPH ACTUALLY HAS -- which needs only the
    lattice's HNF, a few hundred distinct differences and 4^rank <= 65,536 candidates.  A hit is an explicit
    four-colouring of the arena with no solver; a miss says nothing (the graph may still be four-colourable).

    For a 2-UNIT psi a hit is guaranteed and is the theorem in G35/row 57: the base lattice is 2-integral, so
    the whole arena is, every unit vector of it is a unit at both primes above 2 (norm 1 and integral forces
    valuation 0 on each side), and reduction at one of them is such a homomorphism.  Running the search rather
    than quoting the theorem is what makes the screen CHECKED."""
    R = A.rank
    idx = {p: i for i, p in enumerate(apts)}
    diffs = {}
    for a, b in edges:
        pa, pb = apts[a], apts[b]
        d = tuple(x - y for x, y in zip(pa[0] + pa[1], pb[0] + pb[1]))
        diffs.setdefault(d, (a, b))
    D = []
    for d in diffs:
        c = A.coords((d[:4], d[4:]))
        assert c is not None, 'an arena edge difference is not in the arena lattice'
        D.append(c)
    U = np.array(D, dtype=np.int64)
    res = {'rank': R, 'distinct_differences': len(D), 'arena_M': A.M}
    # Z/4
    Av = FB.all_vectors_mod(4, R)
    good = (((Av @ U.T) % 4) != 0).all(axis=1)
    res['proper_Z4'] = int(good.sum())
    phi = None
    if good.any():
        phi = ('Z4', Av[np.nonzero(good)[0][0]])
    else:                                                            # Klein
        Bv = FB.all_vectors_mod(2, R)
        kill = ((Bv @ U.T) % 2 == 0)
        n = 0
        for ib in range(len(Bv)):
            hit = np.nonzero(~(kill[ib] & kill).any(axis=1))[0]
            n += len(hit)
            if phi is None and len(hit):
                phi = ('K4', (Bv[ib], Bv[hit[0]]))
        res['proper_K4'] = n
    if phi is None:
        res['verified'] = False
        res['note'] = 'no additive four-colouring of this arena graph in either group'
        return res, None
    col = []
    for p in apts:
        c = np.array(A.coords((p[0], p[1])), dtype=np.int64)
        if phi[0] == 'Z4':
            col.append(int((phi[1] @ c) % 4))
        else:
            b, cc = phi[1]
            col.append(int((b @ c) % 2) * 2 + int((cc @ c) % 2))
    bad = [(x, y) for x, y in edges if col[x] == col[y]]
    res.update(group=phi[0], monochromatic_edges=len(bad), verified=not bad, colours=len(set(col)))
    if verbose:
        print(f'   additive screen on the arena GRAPH: rank {R}, {len(D)} distinct edge differences; '
              f'{phi[0]} colouring found, {len(bad)} monochromatic edges of {len(edges)} -- '
              f'{"PROPER: four-colourable with no solver" if not bad else "NOT PROPER"}')
    return res, col


def residue_screen(spec, k, psi, verbose=True):
    """the arena, its anatomy, and an additive four-colouring of it if one exists"""
    lat, apts, edges, anat, _ = arena_exact(spec, k, psi, verbose=verbose)
    gens = list(lat.S) + [FF.e_mul(psi, z) for z in lat.S]
    A = FB.Lattice(gens, f'arena({spec})')
    res, col = additive_arena(A, apts, edges, verbose=verbose)
    res.update(two_unit=FF.is_two_unit(psi), points=len(apts), edges=len(edges), anatomy=anat)
    return res


# ---------------------------------------------------------------- self-test

RHO15_9 = (7, 0, 0, 0, 0, 0, 0, 1, 8)


def selftest():
    # --- the exact arithmetic this tool adds
    rho = FF.e_from_ints(RHO15_9)
    assert FF.e_is_unit_vector(rho)
    assert type_m_n(rho) == 4, type_m_n(rho)
    assert not in_CM(rho), 'rho15 is not in the CM field: i sqrt15 generates a fourth quadratic subfield'
    assert in_CM(FF.ZETA6) and in_CM(FF.U_SQRT5), 'the base generators must be in the CM field'
    assert not FF.is_two_unit(rho) and FF.depths(rho)[0] == -4
    # e_div against multiplication, on a pair that is not its own inverse
    p, q = FF.e_mul(rho, FF.ZETA6), FF.U_SQRT5
    assert FF.e_mul(e_div(p, q), q) == p, 'e_div is not the inverse of e_mul'
    assert FF.e_is_unit_vector(e_div(p, q))
    # the symmetry orbit: every member is a unit vector, and the canonical name is stable across the orbit
    orb = sym_orbit(rho)
    assert all(FF.e_is_unit_vector(z) for z in orb)
    assert len({canonical_psi(z) for z in orb}) == 1, 'the canonical name is not constant on an orbit'
    assert FF.e_mul(rho, FF.e_conj(rho)) == FF.E_ONE

    # --- the base is 2-integral, which is what makes the 2-unit screen a theorem
    lat, pts = base_ball('group6:u3:2', 2)
    assert lat.M == 18 and lat.rank == 4 and len(lat.units) == 30, (lat.M, lat.rank, len(lat.units))
    assert all(FF.is_two_unit(z) for z in lat.units), 'the base lattice has a unit vector of nonzero 2-depth'

    # --- THE REGRESSION TEST FOR THE GRID JOIN'S LOST PAIRS.  psi = zeta6 maps the base onto itself, so the
    # answer is known by hand: exactly twice the base's edge count.  With cell 1 and a 3x3 neighbourhood this
    # read 42,654 against 42,660 -- six pairs lost to `floor` at a coordinate of 0.9999999999999998.
    lat3, pts3 = base_ball('group6:u3:2', 3)
    _, e3 = FB.unit_graph(pts3, lat3)
    B3 = [FF.e_from_ints(FF.ints_reduce(list(p), lat3.M)) for p in pts3]
    bf3 = np.array([complex(FF.f_float(z[0]), FF.f_float(z[1])) for z in B3])
    PB3 = [FF.e_mul(FF.ZETA6, z) for z in B3]
    pf3 = bf3 * complex(FF.f_float(FF.ZETA6[0]), FF.f_float(FF.ZETA6[1]))
    got = len(cross_pairs(B3, PB3, bf3, pf3))
    assert got == 2 * len(e3), (f'zeta6 maps the base onto itself, so the join must find {2*len(e3)} pairs '
                                f'(twice its {len(e3)} edges); it found {got}')

    # --- THE CONTROL THE BRIEF ASKS FOR, part 1: the exact anatomy must reproduce phase 1b's arena to the
    # integer, by a route that shares no code with it (its edges come from the arena lattice's saturation;
    # these come from a float grid and the field).
    _, apts, edges, anat, _ = arena_exact('group6:u3:2', 4, rho, verbose=False)
    assert anat['points'] == 54433, anat['points']
    assert anat['edges'] == 352326, anat['edges']
    assert anat['cross'] == 78 and anat['diagonal'] == 30 and anat['off_diagonal'] == 48, anat
    assert anat['shared_points'] == 1, anat['shared_points']
    assert anat['cross_pairs_all'] == 138, anat['cross_pairs_all']
    assert anat['cross_pairs_all'] - 60 == anat['cross'], \
        'the sixty shared-centre pairs are not the whole difference between the pair count and the arena'

    # --- part 2: the SCAN must find rho15 with exactly that anatomy, from its own pool
    want = canonical_psi(rho)
    smeta, srows = scan('group6:u3:2', 4, 'denom:8', jobs=8, verbose=False)
    sf = [r for r in srows if tuple(r['psi_canonical']) == want]
    assert sf, 'the scan did NOT find rho15: the one rotation this milestone has already built an arena on'
    r = sf[0]
    assert (r['cross'], r['diagonal'], r['off_diagonal'], r['pairs_all'], r['shared']) == (78, 30, 48, 138, 1), r
    assert r['type_m_n'] == 4 and not r['two_unit'] and not r['commensurate'] and not r['trivial']
    assert smeta['classes_with_unequal_counts'] == 0
    # the trivial rotations are present and are recognised as trivial: psi in <zeta6> maps the base to itself
    tr = [r for r in srows if r['trivial']]
    assert tr and all(x['shared'] == smeta['base_points'] for x in tr), \
        'a sixth root of unity does not map the zeta6-invariant base onto itself'

    # --- part 3: the (z+s)/w sweep finds rho15 too, and its count is the LOWER BOUND the header claims.
    # 52 of 138, because 56 of the 138 joining vectors have denominator up to 144 and the atlas stops at 42,
    # and the 30 pairs with w = 0 are dropped as 0/0.  This is why the sweep generates and the scan counts.
    meta, rows, _ = sweep('group6:u3:2', 3, 'atlas', verbose=False)
    found = [x for x in rows if tuple(x['psi_canonical']) == want]
    assert found, 'the (z+s)/w sweep did not find rho15'
    assert found[0]['type_m_n'] == 4, 'the class representative is not the type-M member'
    k3 = scan('group6:u3:2', 3, 'denom:8', jobs=8, verbose=False)[1]
    k3r = [x for x in k3 if tuple(x['psi_canonical']) == want][0]
    assert 0 < found[0]['cross_lower'] < k3r['pairs_all'], \
        (f'the sweep is claimed to be a LOWER bound on the pair count: it reads '
         f'{found[0]["cross_lower"]} against the exact {k3r["pairs_all"]}')
    assert meta['adjacent_bins'] == 0, 'two occupied angle bins are adjacent: a rotation may have been split'

    # --- part 4: the pool IS the enumeration.  The base lattice's own 30 unit vectors cannot produce rho15 at
    # all, and can produce nothing outside the CM field.
    meta2, rows2, _ = sweep('group6:u3:2', 3, 'lattice', verbose=False)
    assert not [x for x in rows2 if tuple(x['psi_canonical']) == want], \
        'the lattice-only pool found rho15: then the atlas pool buys nothing and the header is wrong'
    assert all(x['commensurate'] for x in rows2), \
        'a lattice-only pool produced an incommensurate rotation: s in Lambda forces psi = (z+s)/w in the CM field'

    print('fs70_rotations selftest OK')
    print(f'  rho15\'s arena, rebuilt here: 54,433 points, 352,326 edges, 78 cross = 30 diagonal + 48 '
          f'off-diagonal, 1 shared point -- phase 1b\'s numbers, by an independent route')
    print(f'  the scan (denominators <= 8): {smeta["classes"]} classes of {smeta["pool_size"]} rotations, '
          f'rho15 among them with that same anatomy ({smeta["seconds"]}s)')
    print(f'  the (z+s)/w sweep on {meta["base_points"]} base points with {meta["pool_size"]} unit vectors: '
          f'{meta["hits"]:,} hits, {meta["bins"]:,} bins, {meta["classes"]:,} classes ({meta["seconds"]}s); '
          f'rho15\'s lower bound {found[0]["cross_lower"]} against the exact {k3r["pairs_all"]}')
    print(f'  the lattice-only pool: {meta2["classes"]:,} classes, every one commensurate, rho15 absent')


def run_plants():
    import subprocess as sp
    print('--- faithful twin')
    selftest()
    ok = True
    for name in PLANTS:
        print(f'--- plant {name}: a check must refuse it')
        if name == 'psi_digit':
            r = sp.run([sys.executable, __file__, 'anatomy', 'group6:u3:2', '2',
                        '--psi', '7,0,0,0,0,0,0,1,8', '--plant', name], capture_output=True, text=True)
        else:
            r = sp.run([sys.executable, __file__, '--selftest', '--plant', name], capture_output=True, text=True)
        fired = r.returncode != 0
        why = ((r.stderr.strip() or r.stdout.strip()).split('\n') or [''])[-1]
        if fired:
            print(f'    refused: {why[:190]}')
        else:
            print(f'    NOT REFUSED -- plant {name} left the check green: it is blind')
            ok = False
    if not ok:
        raise SystemExit('a planted fault did not fire')
    print(f'all {len(PLANTS)} plants fired; faithful twin green')


# ---------------------------------------------------------------- main

def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


if __name__ == '__main__':
    argv = sys.argv[1:]
    if PLANT is not None and PLANT not in PLANTS:
        raise SystemExit(f'unknown plant {PLANT}; known: {", ".join(PLANTS)}')
    out = _opt(argv, '--out')
    if not argv:
        print(__doc__)
    elif '--plants' in argv:
        run_plants()
    elif '--selftest' in argv:
        selftest()
    elif argv[0] in ('sweep', 'scan'):
        if argv[0] == 'scan':
            meta, rows = scan(argv[1], int(argv[2]), _opt(argv, '--pool', 'atlas'),
                              _opt(argv, '--jobs', 14, int), partial=_opt(argv, '--partial'))
            cols = ('cross', 'diagonal', 'off_diagonal')
        else:
            meta, rows, _ = sweep(argv[1], int(argv[2]), _opt(argv, '--pool', 'atlas'))
            cols = ('cross_lower', 'diagonal_lower', None)
        top = _opt(argv, '--top', 20, int)
        print(f'\n{"psi":>36} {"den":>5} {"d2":>4} {"2u":>3} {"CM":>3} {"triv":>5} {"n":>5} '
              f'{"cross":>9} {"diag":>6} {"off":>9}')
        for r in rows[:top]:
            off = r[cols[2]] if cols[2] else '-'
            print(f'{r["psi_str"][:36]:>36} {r["den"]:>5} {r["depth2"]:>4} '
                  f'{"y" if r["two_unit"] else ".":>3} {"y" if r["commensurate"] else ".":>3} '
                  f'{"y" if r["trivial"] else ".":>5} {str(r["type_m_n"]):>5} '
                  f'{r[cols[0]]:>9} {r[cols[1]]:>6} {str(off):>9}')
        print(f'\n{len(rows):,} symmetry classes; wall-breaking (not a 2-unit): '
              f'{sum(1 for r in rows if not r["two_unit"]):,}; '
              f'incommensurate: {sum(1 for r in rows if not r["commensurate"]):,}; '
              f'type-M: {sum(1 for r in rows if r["type_m_n"]):,}; '
              f'trivial: {sum(1 for r in rows if r["trivial"]):,}')
        if out:
            with open(out, 'w') as fh:
                fh.write(json.dumps({'header': meta}) + '\n')
                for r in rows:
                    fh.write(json.dumps(r) + '\n')
            print('wrote', out)
    elif argv[0] == 'anatomy':
        psi = psi_from_arg(_opt(argv, '--psi'))
        lat, apts, edges, anat, _ = arena_exact(argv[1], int(argv[2]), psi)
        if out:
            write_arena(out, argv[1], int(argv[2]), psi, apts, edges, anat, lat)
    elif argv[0] == 'merge':
        # the sweep's classes that the scan's pool does not contain (denominator above its cap), counted
        # EXACTLY by the scan's own routine and appended to the list
        import multiprocessing as mp
        scanf, sweepf = argv[1], argv[2]
        srows = [json.loads(l) for l in open(scanf)]
        header = srows[0]['header']
        srows = [r for r in srows if 'psi' in r]
        have = {tuple(r['psi_canonical']) for r in srows}
        wrows = [json.loads(l) for l in open(sweepf)]
        wrows = [r for r in wrows if 'psi' in r and tuple(r['psi_canonical']) not in have]
        print(f'{len(srows)} classes in the scan; {len(wrows)} classes the sweep found that it does not have')
        spec, kk = header['base_spec'], header['base_k']
        ctx = mp.get_context('fork')
        with ctx.Pool(_opt(argv, '--jobs', 14, int), initializer=_scan_init, initargs=(spec, kk)) as p:
            new = p.map(scan_one, [r['psi'] for r in wrows], chunksize=1)
        for r in new:
            r['members'] = 1
            r['from_sweep'] = True
        allr = sorted(srows + new, key=lambda r: (-r['off_diagonal'], -r['cross']))
        header['merged_from_sweep'] = len(new)
        header['pool_name'] += (f'; plus {len(new)} classes of higher denominator that the (z+s)/w sweep over '
                                f'{sweepf} found, each counted exactly by the same routine')
        with open(scanf, 'w') as fh:
            fh.write(json.dumps({'header': header}) + '\n')
            for r in allr:
                fh.write(json.dumps(r) + '\n')
        print(f'merged: {len(allr)} classes now in {scanf}')
        for r in sorted(new, key=lambda r: -r['off_diagonal'])[:10]:
            print(f'   {r["psi_str"][:44]:<44} den={r["den"]:<5} cross={r["cross"]:<6} '
                  f'off={r["off_diagonal"]:<6} 2u={"y" if r["two_unit"] else "."}')
    elif argv[0] == 'count':
        psi = psi_from_arg(_opt(argv, '--psi'))
        res = counting_screen(argv[1], int(argv[2]), psi, _opt(argv, '--colours', 4, int))
        print(json.dumps(res, indent=1))
        if res.get('refutes'):
            print('G53 REFUTES this arena -- HALT AND VERIFY')
    elif argv[0] == 'screen':
        psi = psi_from_arg(_opt(argv, '--psi'))
        res = residue_screen(argv[1], int(argv[2]), psi)
        print(json.dumps({k: v for k, v in res.items() if k != 'anatomy'}, indent=1))
    else:
        raise SystemExit(f'unknown command {argv[0]!r}; run with no arguments for the grammar')
