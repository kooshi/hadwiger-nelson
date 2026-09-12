#!/usr/bin/env python3
"""shapefree -- the shape-free denominator-12 module of K^2, K = Q(sqrt3, sqrt11)  (M63 phase H3).

WHAT THIS COMPUTES
------------------
A point of the plane is z = p1 + i p2 with p1, p2 in K.  `[Parts2020a]` sec 5.6 writes his base
lattice as z = (a + b sqrt33 + i(c sqrt3 + d sqrt11))/12 -- his SHAPE, which uses four of the eight
rational slots available, confining the real part to Q(sqrt33) and the imaginary part to
sqrt3 Q + sqrt11 Q.  This module drops that confinement: eight integers,

    p1 = (a0 + a1 sqrt3 + a2 sqrt11 + a3 sqrt33)/12 ,  p2 = (b0 + b1 sqrt3 + b2 sqrt11 + b3 sqrt33)/12 ,

and cuts it by the EXACT four-conjugate disk condition sigma_k(|z|^2) <= R^2 at all four real
embeddings of K (Parts's own |z|^2 always lands in Q(sqrt33), which is why his cut has two).

Provides:
  * exact K arithmetic and an exact sign predicate (norms down the tower Q < Q(sqrt3) < K);
  * the maximal submodule stable under a given finite group of K-linear maps, by exhaustive
    enumeration of residues (every group element here has denominator 2, so 2Z^r is contained in
    the answer and the answer is a union of residue classes mod 2);
  * two INDEPENDENT enumerators of the cut module -- a coordinate-box pairing and a
    trace-ellipsoid pairing -- which must agree on every count reported;
  * shell counts, orbit structure, and the in-arena unit degree of a circle point.

WHAT THIS DOES NOT COMPUTE
--------------------------
  * No cross edges and no rotation: this module is a BASE, not an arena.  The cross-edge law at
    cos th = 3/4 is a separate instrument.
  * No colouring, no chromatic claim, and no statement that any point set here refuses four colours.
  * No claim that group closure selects a base.  It does not: see IDX256_CONG vs CLOSED_CONG.
  * Nothing about whether a point set attaining these counts is USEFUL.  A count on a circle is an
    arithmetic possibility; it is not a constructed graph.
  * The in-arena degree function reports how many unit translates of a circle point survive a given
    radius cut.  It says nothing about the base graph's own required extent, which the endpoint
    bound 1/|sin th| does not govern -- that bound constrains CROSS-edge endpoints only.

Slot convention everywhere: a K element is the integer 4-tuple (x0,x1,x2,x3) meaning
(x0 + x1 sqrt3 + x2 sqrt11 + x3 sqrt33)/12; a point is the 8-tuple (p1 slots, p2 slots).
Parts's coordinates (a,b,c,d) are slots (a0, a3, b1, b2).
"""
from fractions import Fraction as Fr
from itertools import product
from collections import Counter, defaultdict

__all__ = ["k_sign", "ksq", "norm144", "all_embeddings_le", "maximal_stable", "group8",
           "enumerate_box", "enumerate_trace", "PARTS_CONG", "CLOSED_CONG", "IDX256_CONG",
           "GENERATED_CONG"]

# ===================================================================== exact arithmetic in K
def _sgn(n): return (n > 0) - (n < 0)

def f_sign(a, b):
    """Exact sign of a + b*sqrt3 for integers a, b."""
    if a >= 0 and b >= 0: return 1 if (a or b) else 0
    if a <= 0 and b <= 0: return -1 if (a or b) else 0
    return _sgn(a) * _sgn(a*a - 3*b*b)

def k_sign(a, b, c, d):
    """Exact sign of a + b sqrt3 + c sqrt11 + d sqrt33 for integers.  No float, no tolerance.
    Method: x = A + B sqrt11 with A, B in Q(sqrt3); when A and B have opposite sign both sides of
    the comparison are positive and may be squared, giving sign(x) = sign(A) sign(A^2 - 11 B^2)."""
    sA = f_sign(a, b); sB = f_sign(c, d)
    if sA >= 0 and sB >= 0: return 1 if (sA or sB) else 0
    if sA <= 0 and sB <= 0: return -1 if (sA or sB) else 0
    return sA * f_sign(a*a + 3*b*b - 11*(c*c + 3*d*d), 2*a*b - 22*c*d)

def kmul(x, y):
    x0,x1,x2,x3 = x; y0,y1,y2,y3 = y
    return (x0*y0 + 3*x1*y1 + 11*x2*y2 + 33*x3*y3,
            x0*y1 + x1*y0 + 11*(x2*y3 + x3*y2),
            x0*y2 + x2*y0 + 3*(x1*y3 + x3*y1),
            x0*y3 + x3*y0 + x1*y2 + x2*y1)

def ksq(x):
    x0,x1,x2,x3 = x
    return (x0*x0 + 3*x1*x1 + 11*x2*x2 + 33*x3*x3, 2*x0*x1 + 22*x2*x3,
            2*x0*x2 + 6*x1*x3, 2*x0*x3 + 2*x1*x2)

def norm144(v):
    """144 |z|^2 as a K element, for an 8-slot integer point v."""
    sa, sb = ksq(v[:4]), ksq(v[4:])
    return tuple(sa[i] + sb[i] for i in range(4))

def all_embeddings_le(m, num, den):
    """Is every real embedding of (m0 + m1 s3 + m2 s11 + m3 s33) at most num/den?  Exact."""
    A0 = m[0]*den - num
    for e3 in (1, -1):
        for e11 in (1, -1):
            if k_sign(A0, e3*m[1]*den, e11*m[2]*den, e3*e11*m[3]*den) > 0:
                return False
    return True

# ===================================================================== the symmetry group
def _s3(y): return (3*y[1], y[0], 3*y[3], y[2])          # multiplication by sqrt3

def _rot_map(re, im):
    """multiplication by (re + i*im) where re, im are K elements given as slot tuples of a
    HALF-integer rotation: we pass the doubled form and halve."""
    raise NotImplementedError

def z6_map(v):
    """zeta6 = (1 + i sqrt3)/2 : p1 -> (p1 - sqrt3 p2)/2, p2 -> (sqrt3 p1 + p2)/2."""
    a, b = v[:4], v[4:]
    return tuple(Fr(a[i] - _s3(b)[i], 2) for i in range(4)) + \
           tuple(Fr(_s3(a)[i] + b[i], 2) for i in range(4))

def z12_map(v):
    """zeta12 = (sqrt3 + i)/2 : p1 -> (sqrt3 p1 - p2)/2, p2 -> (p1 + sqrt3 p2)/2."""
    a, b = v[:4], v[4:]
    return tuple(Fr(_s3(a)[i] - b[i], 2) for i in range(4)) + \
           tuple(Fr(a[i] + _s3(b)[i], 2) for i in range(4))

def i_map(v):
    """multiplication by i (the quarter turn) : (p1, p2) -> (-p2, p1)."""
    return tuple(Fr(-x) for x in v[4:]) + tuple(Fr(x) for x in v[:4])

def gal_map(f3, f11):
    """sqrt3 -> f3 sqrt3, sqrt11 -> f11 sqrt11, applied to both coordinates."""
    def g(v):
        out = []
        for h in (v[:4], v[4:]):
            out += [Fr(h[0]), Fr(f3)*h[1], Fr(f11)*h[2], Fr(f3*f11)*h[3]]
        return tuple(out)
    return g

def as_matrix(f, r=8):
    cols = [f(tuple(1 if i == j else 0 for i in range(r))) for j in range(r)]
    return tuple(tuple(Fr(cols[j][i]) for j in range(r)) for i in range(r))

def _mm(A, B):
    n = len(A)
    return tuple(tuple(sum(A[i][k]*B[k][j] for k in range(n)) for j in range(n)) for i in range(n))

def matvec(A, v):
    return tuple(sum(A[i][j]*v[j] for j in range(len(v))) for i in range(len(A)))

def group8(gens):
    I = tuple(tuple(Fr(1 if i == j else 0) for j in range(8)) for i in range(8))
    seen = {I}; front = [I]
    while front:
        nxt = []
        for M in front:
            for G in gens:
                P = _mm(G, M)
                if P not in seen: seen.add(P); nxt.append(P)
        front = nxt
    return sorted(seen)

GROUP24 = group8([as_matrix(z6_map),  as_matrix(gal_map(-1,1)), as_matrix(gal_map(1,-1))])
GROUP48 = group8([as_matrix(z12_map), as_matrix(gal_map(-1,1)), as_matrix(gal_map(1,-1))])

def maximal_stable(mats, mask=None):
    """The largest sublattice of Z^8 (restricted to the slots in `mask`) that every matrix in
    `mats` maps into itself.  `mats` must be a GROUP, so the set is automatically stable.  Every
    element's denominator divides D, so D*Z^8 lies inside the answer and the answer is a union of
    residue classes mod D -- enumerated exhaustively.  Returns (index, residue set, free slots)."""
    from math import lcm
    D = 1
    for M in mats:
        for row in M:
            for e in row: D = lcm(D, e.denominator)
    free = list(range(8)) if mask is None else [j for j in range(8) if mask[j]]
    good = []
    for res in product(range(D), repeat=len(free)):
        v = [0]*8
        for j, t in zip(free, res): v[j] = t
        v = tuple(v); ok = True
        for M in mats:
            w = matvec(M, v)
            if any(x.denominator != 1 for x in w): ok = False; break
            if mask is not None and any(w[j] != 0 for j in range(8) if not mask[j]): ok = False; break
        if ok: good.append(res)
    return D**len(free)//len(good), set(good), free

# ===================================================================== the congruence families
def PARTS_CONG(v):
    """`[Parts2020a]` sec 5.6 / Philip Gibbs's Polymath16 ring R2-bar, on the shape slots.
    NECESSARY for the RING; only SUFFICIENT for group closure (see CLOSED_CONG)."""
    if any(v[j] for j in (1, 2, 4, 7)): return False
    a, b, c, d = v[0], v[3], v[5], v[6]
    return (a-b) % 2 == 0 and (a-c) % 2 == 0 and (a-d) % 2 == 0 and (a-b+c+d) % 4 == 0

def CLOSED_CONG(v):
    """The MAXIMAL group-stable denominator-12 shape-free module: index 16 in Z^8.
    Stable under zeta12 and Gal(K/Q), hence under a group of order 48.  NOT a ring, and NOT
    generated by its own unit vectors (its unit shell is the same 60, which span only IDX256_CONG).
    Use it to study the module, never as a base."""
    return (v[0]-v[5]) % 2 == 0 and (v[1]-v[4]) % 2 == 0 and \
           (v[2]-v[7]) % 2 == 0 and (v[3]-v[6]) % 2 == 0

def _pc(a, b, c, d):
    return (a-b) % 2 == 0 and (a-c) % 2 == 0 and (a-d) % 2 == 0 and (a-b+c+d) % 4 == 0

def IDX256_CONG(v):
    """THE BASE.  Parts's ring conditions applied to the Parts-slot half AND to the complementary
    half (which is i times a Parts-slot point): index 256 in Z^8, order-48 closed.

    This is exactly the lattice GENERATED by the module's 60 unit vectors -- measured, by two
    independent index routines -- which is the property that selects a base: a unit-distance graph's
    edges are its unit vectors, so a point outside their Z-span carries no edge from the origin.
    Generation is strictly stronger than group closure; CLOSED_CONG below is the weaker property and
    admits a lattice 16 times denser that is NOT generated by its unit vectors."""
    return _pc(v[0], v[3], v[5], v[6]) and _pc(v[4], v[7], -v[1], -v[2])

GENERATED_CONG = IDX256_CONG      # the lattice generated by the 60 unit vectors -- the usable base

# ===================================================================== enumerators
def enumerate_box(R2num, R2den, cong):
    """IMPLEMENTATION 1.  Bound each coordinate by the inverse Hadamard transform, filter each
    exactly by sigma_k(x)^2 <= 144 R^2, bucket by parity, pair.  Pure scalar integer arithmetic."""
    L, Ld = 144*R2num, R2den
    import math
    lim = math.sqrt(L/Ld)
    BOX = tuple(int(lim/w) + 2 for w in (1.0, 3**0.5, 11**0.5, 33**0.5))
    cand = []
    for x0 in range(-BOX[0], BOX[0]+1):
      for x1 in range(-BOX[1], BOX[1]+1):
        for x2 in range(-BOX[2], BOX[2]+1):
          for x3 in range(-BOX[3], BOX[3]+1):
            if all_embeddings_le(ksq((x0,x1,x2,x3)), L, Ld): cand.append((x0,x1,x2,x3))
    assert not any(abs(x[i]) == BOX[i] for x in cand for i in range(4)), \
        "a survivor touches the enumeration wall -- the box is binding"
    sq = {x: ksq(x) for x in cand}
    byp = defaultdict(list)
    for y in cand: byp[(y[0] & 1, y[1] & 1, y[2] & 1, y[3] & 1)].append(y)
    out = []
    for x in cand:
        sx = sq[x]
        if cong is CLOSED_CONG or cong is IDX256_CONG:
            ys = byp[(x[1] & 1, x[0] & 1, x[3] & 1, x[2] & 1)]
        else:
            ys = cand
        for y in ys:
            sy = sq[y]
            m = (sx[0]+sy[0], sx[1]+sy[1], sx[2]+sy[2], sx[3]+sy[3])
            if all_embeddings_le(m, L, Ld):
                v = x + y
                if cong is None or cong(v): out.append(v)
    return out

def enumerate_trace(R2num, R2den, cong):
    """IMPLEMENTATION 2, deliberately unlike 1.  The trace form is DIAGONAL in this basis:
    Tr(|z|^2) = 4(q(x) + q(y))/144 with q = x0^2 + 3x1^2 + 11x2^2 + 33x3^2, so the necessary
    condition is q(x) + q(y) <= 144 R^2.  That candidate set is strictly LARGER than the box's,
    so this cannot inherit a bound error from it.  Same exact test, different enumeration."""
    L, Ld = 144*R2num, R2den
    QMAX = L // Ld
    lim = [int((QMAX/w)**0.5) + 1 for w in (1, 3, 11, 33)]
    cand = []
    for x0 in range(-lim[0], lim[0]+1):
      s0 = x0*x0
      if s0 > QMAX: continue
      for x1 in range(-lim[1], lim[1]+1):
        s1 = s0 + 3*x1*x1
        if s1 > QMAX: continue
        for x2 in range(-lim[2], lim[2]+1):
          s2 = s1 + 11*x2*x2
          if s2 > QMAX: continue
          for x3 in range(-lim[3], lim[3]+1):
            s3 = s2 + 33*x3*x3
            if s3 <= QMAX: cand.append((s3, (x0,x1,x2,x3)))
    cand.sort()
    out = []
    for qi, x in cand:
        sx = ksq(x)
        for qj, y in cand:
            if qi + qj > QMAX: break
            v = x + y
            if cong is not None and not cong(v): continue
            sy = ksq(y)
            m = (sx[0]+sy[0], sx[1]+sy[1], sx[2]+sy[2], sx[3]+sy[3])
            if all_embeddings_le(m, L, Ld): out.append(v)
    return out

# ===================================================================== generation
def span_index(rows, n):
    """Index in Z^n of the Z-span of integer n-tuples `rows`; 0 if they do not span.
    Integer Hermite reduction, no fractions.  This is the routine that decides whether a lattice is
    GENERATED by a given set -- for a base, by its own unit vectors."""
    M = [list(r) for r in rows]
    piv, r = [], 0
    for c in range(n):
        while True:
            nz = [i for i in range(r, len(M)) if M[i][c] != 0]
            if not nz: break
            i0 = min(nz, key=lambda i: abs(M[i][c]))
            M[r], M[i0] = M[i0], M[r]
            done = True
            for i in range(r+1, len(M)):
                if M[i][c]:
                    q = M[i][c] // M[r][c]
                    for j in range(n): M[i][j] -= q*M[r][j]
                    if M[i][c]: done = False
            if done: break
        if any(M[i][c] for i in range(r, len(M))):
            piv.append(M[r][c]); r += 1
            if r == len(M): break
    if len(piv) < n: return 0
    d = 1
    for x in piv: d *= abs(x)
    return d

# ===================================================================== self-test
def self_test():
    ok = lambda c, m: print(("  PASS  " if c else "  FAIL  ") + m) or (c or (_ for _ in ()).throw(AssertionError(m)))
    import math
    print("1. exact sign predicate, both outcomes, against float")
    bad = 0
    import random; random.seed(5)
    for _ in range(20000):
        a,b,c,d = [random.randint(-400,400) for _ in range(4)]
        val = a + b*math.sqrt(3) + c*math.sqrt(11) + d*math.sqrt(33)
        if abs(val) < 1e-6: continue
        if k_sign(a,b,c,d) != _sgn(val): bad += 1
    ok(bad == 0, f"20k random signs agree with float ({bad} disagreements)")
    ok(k_sign(-5,0,0,1) == 1 and k_sign(-6,0,0,1) == -1,
       "sqrt33 straddling cases both directions (this pair caught a real bug in the a>=0,b>=0 branch)")
    planted = lambda a,b,c,d: k_sign(a,b,c,0)          # NEGATIVE CONTROL: drop the sqrt33 slot
    fires = sum(1 for t in [(1,0,0,-1),(2,0,0,-1),(5,0,0,-1)] if planted(*t) != k_sign(*t))
    ok(fires > 0, f"negative control (sqrt33 slot dropped) disagrees on {fires} of 3 planted inputs")

    print("2. group structure")
    ok(len(GROUP24) == 24 and len(GROUP48) == 48, "orders 24 and 48")
    i24, _, _ = maximal_stable(GROUP24); i48, _, _ = maximal_stable(GROUP48)
    ok(i24 == 16 and i48 == 16, f"maximal stable index is 16 under both groups (got {i24}, {i48})")
    SHAPE = [1,0,0,1,0,1,1,0]
    iS, resS, _ = maximal_stable(GROUP24, SHAPE)
    ok(iS == 4, f"maximal stable index inside Parts's shape is 4 (got {iS}) -- his congruences give 16")
    ok(resS == {(0,0,0,0),(0,1,0,1),(1,0,1,0),(1,1,1,1)},
       "and the four surviving residues are exactly a=c, b=d (mod 2)")

    print("3. the two enumerators agree, on a radius small enough to be quick")
    for cong, nm in ((CLOSED_CONG, "closed (index 16)"), (IDX256_CONG, "index 256"), (None, "no congruence")):
        A = enumerate_box(1, 1, cong); B = enumerate_trace(1, 1, cong)
        ok(len(A) == len(B) and set(A) == set(B), f"R^2 = 1, {nm}: {len(A)} == {len(B)}")
    print("4. known answers")
    A = enumerate_box(16, 7, CLOSED_CONG)
    sh = Counter(m[0]//144 for m in map(norm144, A) if m[1]==0 and m[2]==0 and m[3]==0 and m[0]%144==0)
    ok(len(A) == 260401, f"closed module inside R = 4/sqrt7: {len(A)} (expected 260401)")
    ok(sh[1] == 60 and sh[2] == 60, f"shells: |p|^2=1 -> {sh[1]}, |p|^2=2 -> {sh[2]} (expected 60, 60)")
    print("5. the cut is not vacuous: a first-embedding-only cut must admit MORE")
    circ = [v for v in A if norm144(v) == (288,0,0,0)]
    unit = [v for v in A if norm144(v) == (144,0,0,0)]
    q = circ[0]
    four = sum(1 for s in unit if all_embeddings_le(norm144(tuple(q[i]+s[i] for i in range(8))), 2304, 7))
    one  = sum(1 for s in unit if k_sign(*[norm144(tuple(q[i]+s[i] for i in range(8)))[j]*7
                                           - (2304 if j==0 else 0) for j in range(4)]) <= 0)
    ok(0 < four < one, f"unit translates inside: {four} at four embeddings vs {one} at one "
                       f"-- the conjugate conditions bite (two-sided)")
    print("6. generation -- the property that selects a base")
    for rows, n, want in [([(1,0),(0,1)],2,1), ([(2,0),(0,2)],2,4), ([(1,0),(2,0)],2,0),
                          ([(2,1,0),(0,3,0),(0,0,5)],3,30)]:
        ok(span_index(rows,n) == want, f"index routine control {rows} -> {want}")
    ok(span_index(unit, 8) == 256,
       f"the 60 unit vectors span index {span_index(unit,8)} (expected 256) -- the generated base")
    ok(all(IDX256_CONG(v) for v in unit),
       "and all 60 satisfy IDX256_CONG, so the span IS that lattice (equal indices, one contains the other)")
    ok(span_index(unit + circ, 8) == 256,
       "the 60 circle points add nothing to the span -- the diagonal circle is edge-reachable")
    gen = [v for v in A if IDX256_CONG(v)]
    ok(len(gen) == 16309, f"the generated base inside R = 4/sqrt7: {len(gen)} (expected 16309)")
    ok(span_index([v for v in A if CLOSED_CONG(v) and norm144(v) == (144,0,0,0)], 8) != 16,
       "NEGATIVE: the maximal group-CLOSED module is NOT generated by its unit vectors")
    print("ALL SELF-TESTS PASSED")

if __name__ == "__main__":
    import sys
    if "--self-test" in sys.argv: self_test()
    else: print(__doc__)
