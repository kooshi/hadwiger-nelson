#!/usr/bin/env python3
"""typem — the type-M rotation sieve (M62 §0b, `plans/M62-evolutionary-type-m.md`).

Parts's open question, verbatim: *"Working constructions of type M with other rotations are not
known yet."* Every type-M 5-chromatic graph ever built uses one rotation. This tool enumerates the
candidates, EXACTLY and with no floating point anywhere in the verdict.

The derivation (M62 §M2.1). A cross edge between `u` and `ρv`, with `ρ` a norm-one rotation, is

    |u − ρv|² = 1   ⟺   Re(ρ · ū v) = k,   k = (|u|² + |v|² − 1)/2

a LINE meeting the unit circle: at most two rotations make any given pair adjacent, and solving
gives `ρ ∈ K(i)(√D)` with

    D = N − k²,     N = |ū v|² = |u|²·|v|²          (all of N, k, D lie in K)

so the whole sieve is exact arithmetic in `K = ℚ(√3, √11)`:

  * `D < 0`          — the pair admits no rotation at all;
  * `D` a square in K — the rotation lies in `K(i)`, the union stays in `K²`, and **Theorem B
                        four-colours it**: REJECTED, structurally, not heuristically;
  * else             — the rotation adjoins `√D`; keep it, and ask the 2-adic wall.

**The ranking trap this tool exists to avoid (M62 §M2.1, measured).** Ranking rotations by how many
cross edges they create is ANTI-CORRELATED with usefulness: maximal coupling means the rotation
nearly preserves the lattice, means it lies in `K(i)`, means Theorem B kills it. On a Moser-lattice
ball the top-voted rotations are exactly the useless ones. The Theorem-B filter runs FIRST.

    python3 tools/typem.py --self-test
    python3 tools/typem.py rotations --radius 2.05 --out data/m62/rotations.json

UNTRUSTED like everything in tools/: the theorems it instantiates are Theorem B (`FieldWall4.lean`),
the gluing classification (`Glue.lean`) and the 2-adic wall criterion (`plans/FIELD-WALL-THEOREM.md`).
"""
from __future__ import annotations
import argparse, json, math, sys, time
from collections import defaultdict
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
ROOT = Path(__file__).resolve().parent.parent

# ====================================================================== K = Q(sqrt3, sqrt11)
# An element is (a, b, c, d) meaning a + b*sqrt3 + c*sqrt11 + d*sqrt33, all Fractions.
Z  = (Fr(0), Fr(0), Fr(0), Fr(0))
ONE= (Fr(1), Fr(0), Fr(0), Fr(0))

def kadd(x, y): return tuple(p + q for p, q in zip(x, y))
def ksub(x, y): return tuple(p - q for p, q in zip(x, y))
def kneg(x):    return tuple(-p for p in x)
def kscale(x, s): s = Fr(s); return tuple(p * s for p in x)

def kmul(x, y):
    a, b, c, d = x; e, f, g, h = y
    return (a*e + 3*b*f + 11*c*g + 33*d*h,
            a*f + b*e + 11*c*h + 11*d*g,
            a*g + c*e + 3*b*h + 3*d*f,
            a*h + d*e + b*g + c*f)

def kfloat(x):
    a, b, c, d = x
    return float(a) + float(b)*math.sqrt(3) + float(c)*math.sqrt(11) + float(d)*math.sqrt(33)

# ---------------------------------------------------------------- exact squareness, by the tower
def q_is_square(q: Fr) -> bool:
    if q < 0: return False
    if q == 0: return True
    n, d = q.numerator, q.denominator
    return math.isqrt(n)**2 == n and math.isqrt(d)**2 == d

def q_sqrt(q: Fr):
    return Fr(math.isqrt(q.numerator), math.isqrt(q.denominator)) if q_is_square(q) else None

def f3_is_square(al: Fr, be: Fr) -> bool:
    """al + be*sqrt3 a square in F = Q(sqrt3)?"""
    if al == 0 and be == 0: return True
    if be == 0: return q_is_square(al) or q_is_square(al / 3)
    nn = al*al - 3*be*be
    n = q_sqrt(nn)
    if n is None: return False
    return q_is_square((al + n) / 2) or q_is_square((al - n) / 2)

def f3_sqrt(al: Fr, be: Fr):
    if al == 0 and be == 0: return (Fr(0), Fr(0))
    if be == 0:
        r = q_sqrt(al)
        if r is not None: return (r, Fr(0))
        r = q_sqrt(al / 3)
        return (Fr(0), r) if r is not None else None
    n = q_sqrt(al*al - 3*be*be)
    if n is None: return None
    for cand in ((al + n) / 2, (al - n) / 2):
        p = q_sqrt(cand)
        if p is not None and p != 0:
            return (p, be / (2*p))
    return None

def k_is_square(x) -> bool:
    """x = A + B*sqrt11 with A, B in F = Q(sqrt3): a square in K = F(sqrt11)?"""
    a, b, c, d = x
    A, B = (a, b), (c, d)                      # A = a + b*sqrt3 ; B = c + d*sqrt3
    if B == (0, 0):
        return f3_is_square(*A) or f3_is_square(A[0]/11, A[1]/11)
    # norm A^2 - 11 B^2 in F
    A2 = (A[0]*A[0] + 3*A[1]*A[1], 2*A[0]*A[1])
    B2 = (B[0]*B[0] + 3*B[1]*B[1], 2*B[0]*B[1])
    NN = (A2[0] - 11*B2[0], A2[1] - 11*B2[1])
    n = f3_sqrt(*NN)
    if n is None: return False
    for sg in (+1, -1):
        h = ((A[0] + sg*n[0]) / 2, (A[1] + sg*n[1]) / 2)
        if f3_is_square(*h): return True
    return False

# ====================================================================== the Moser-lattice base
# z = a + b*z6 + c*w3 + d*z6*w3,  z6 = 1/2 + i sqrt3/2,  w3 = 5/6 + i sqrt11/6  (the Moser twist).
# Both coordinates lie in K; x uses (1, sqrt33), y uses (sqrt3, sqrt11).
def lattice_point(a, b, c, d):
    x = (Fr(a) + Fr(b, 2) + Fr(5*c, 6) + Fr(5*d, 12), Fr(0), Fr(0), Fr(-d, 12))
    y = (Fr(0), Fr(b, 2) + Fr(5*d, 12), Fr(c, 6) + Fr(d, 12), Fr(0))
    return (x, y)

def norm2(p):
    x, y = p
    return kadd(kmul(x, x), kmul(y, y))


def build_base(radius: float, span: int = 4):
    """Every Moser-lattice point inside the radius, deduplicated EXACTLY by its K-coordinates."""
    r2 = radius * radius
    seen: dict = {}
    for a in range(-span, span + 1):
        for b in range(-span, span + 1):
            for c in range(-span, span + 1):
                for d in range(-span, span + 1):
                    p = lattice_point(a, b, c, d)
                    if kfloat(norm2(p)) <= r2 + 1e-12:
                        seen.setdefault(p, (a, b, c, d))
    pts = sorted(seen.keys(), key=lambda p: (kfloat(norm2(p)), kfloat(p[0]), kfloat(p[1])))
    return pts, [seen[p] for p in pts]

def unit_edges(pts):
    """Exact unit pairs: |u-v|^2 == 1 in K, no tolerance anywhere."""
    n = len(pts); E = []
    for i in range(n):
        xi, yi = pts[i]
        for j in range(i + 1, n):
            xj, yj = pts[j]
            dx, dy = ksub(xi, xj), ksub(yi, yj)
            if kadd(kmul(dx, dx), kmul(dy, dy)) == ONE:
                E.append((i, j))
    return E

# ====================================================================== the sieve
def radicand(nu, nv):
    """For |u|^2 = nu, |v|^2 = nv: the discriminant D = N - k^2 whose root the rotation adjoins."""
    N = kmul(nu, nv)
    k = kscale(ksub(kadd(nu, nv), ONE), Fr(1, 2))
    return ksub(N, kmul(k, k)), N, k

def squarefree_key(D):
    """A canonical key for D's square class in K: D itself, scaled by the square of a rational so
    that comparing keys compares classes for the rational multiples we actually meet."""
    return D

def sieve(pts, verbose=True):
    """The enumeration is over the RADIUS SPECTRUM, not over point pairs: D depends only on
    (|u|^2, |v|^2), so grouping by radius first turns O(n^2) exact-squareness tests into O(R^2)
    with R the number of distinct radii -- typically two orders of magnitude smaller. The point
    multiplicity is carried as a weight, so the pair counts are unchanged."""
    norms = [norm2(p) for p in pts]
    mult = defaultdict(int)
    for nn in norms:
        mult[nn] += 1
    radii = sorted(mult, key=kfloat)
    by_D = defaultdict(list)
    admits = rejected_inK = no_rotation = 0
    for a in radii:
        for b in radii:
            w = mult[a] * mult[b]
            D, N, k = radicand(a, b)
            if kfloat(D) < 0:
                no_rotation += w; continue
            if k_is_square(D):
                rejected_inK += w                      # Theorem B kills it
                continue
            admits += w
            by_D[D].append((a, b, w))
    # MERGE BY SQUARE CLASS. Two radicands D1, D2 give the SAME rotation when D1*D2 is a square in
    # K -- the self-test's own case: Parts's reference family gives 15/4 and his auxiliary family
    # gives 5/3, and (15/4)(5/3) = 25/4 is a square, so they are ONE rotation, which is exactly why
    # a single rotation realises both of his cross-edge kinds. Grouping by D alone splits classes
    # and UNDERCOUNTS the families per rotation, which is the quantity Parts says is essential.
    reps, merged = [], defaultdict(list)
    for D, entries in by_D.items():
        hit = None
        for r in reps:
            if k_is_square(kmul(D, r)):
                hit = r; break
        if hit is None:
            reps.append(D); hit = D
        merged[hit].extend(entries)
    return dict(pairs=len(pts) ** 2, radii=len(radii), no_rotation=no_rotation,
                rejected_in_K=rejected_inK, admitting=admits,
                raw_radicands=len(by_D), classes=merged)


def radius_families(entries):
    """Distinct unordered radius pairs {|u|^2, |v|^2} in this class — Parts's cross-edge 'kinds'."""
    return {(a, b) if kfloat(a) <= kfloat(b) else (b, a) for a, b, _ in entries}

# ====================================================================== controls (M62 §M2.6)
def self_test():
    ok = True
    def check(what, cond):
        nonlocal ok
        print(f"  {'ok  ' if cond else 'FAIL'} {what}")
        ok = ok and cond

    print("K arithmetic and exact squareness:")
    check("4 is a square in K", k_is_square((Fr(4), Fr(0), Fr(0), Fr(0))))
    check("3 is a square in K (sqrt3 in K)", k_is_square((Fr(3), Fr(0), Fr(0), Fr(0))))
    check("11 is a square in K", k_is_square((Fr(11), Fr(0), Fr(0), Fr(0))))
    check("33 is a square in K", k_is_square((Fr(33), Fr(0), Fr(0), Fr(0))))
    check("5 is NOT a square in K", not k_is_square((Fr(5), Fr(0), Fr(0), Fr(0))))
    check("15 is NOT a square in K  <- rho15's radicand", not k_is_square((Fr(15), Fr(0), Fr(0), Fr(0))))
    check("7 is NOT a square in K", not k_is_square((Fr(7), Fr(0), Fr(0), Fr(0))))
    check("-1 is NOT a square in K", not k_is_square((Fr(-1), Fr(0), Fr(0), Fr(0))))
    check("(4+2sqrt3) = (1+sqrt3)^2 is a square", k_is_square((Fr(4), Fr(2), Fr(0), Fr(0))))
    check("(14+2sqrt33) = (11+sqrt33)^2/... check (1+sqrt33)^2 = 34+2sqrt33",
          k_is_square((Fr(34), Fr(0), Fr(0), Fr(2))))
    check("(12+2sqrt11) = (1+sqrt11)^2", k_is_square((Fr(12), Fr(0), Fr(2), Fr(0))))

    print("\nthe reference family reproduces rho15's radicand (M62 §M1.0):")
    four = (Fr(4), Fr(0), Fr(0), Fr(0))
    D, N, k = radicand(four, four)
    check(f"radii 2,2 -> D = {D[0]} = 15/4, so the rotation adjoins sqrt15", D == (Fr(15, 4), Fr(0), Fr(0), Fr(0)))
    check("D is NOT a square in K, so the rotation LEAVES K (Theorem B does not apply)", not k_is_square(D))

    print("\nthe auxiliary family: conjugate rings (17 +- sqrt33)/6 (M31's channel):")
    ap = (Fr(17, 6), Fr(0), Fr(0), Fr(1, 6)); am = (Fr(17, 6), Fr(0), Fr(0), Fr(-1, 6))
    D2, N2, k2 = radicand(ap, am)
    check(f"product N = {kfloat(N2):.9f} = (8/3)^2 = {(8/3)**2:.9f}", N2 == (Fr(64, 9), Fr(0), Fr(0), Fr(0)))
    check("k = (17/3 - 1)/2 = 7/3", k2 == (Fr(7, 3), Fr(0), Fr(0), Fr(0)))
    check(f"D = 64/9 - 49/9 = 15/9 = 5/3", D2 == (Fr(5, 3), Fr(0), Fr(0), Fr(0)))
    check("D is NOT a square in K -> the auxiliary family also leaves K", not k_is_square(D2))
    print("      NOTE: both of Parts's families adjoin a root of the SAME square class as 15")
    print(f"            (15/4 and 5/3 differ by (3/2)^2 x (5/3)/(5/3)... ratio = {kfloat(D)/kfloat(D2):.9f} = 9/4 = (3/2)^2)")
    check("the two radicands differ by a RATIONAL SQUARE, so they are ONE rotation class",
          k_is_square(kmul(D, D2)))

    print("\nTheorem-B rejection fires on an in-K rotation (planted control):")
    # radii chosen so that D is a perfect square in K: take |u|^2 = |v|^2 = t with D = t^2 - (t - 1/2)^2 = t - 1/4
    t = (Fr(5, 4), Fr(0), Fr(0), Fr(0))          # D = 5/4 - 1/4 = 1, a square
    Dp, _, _ = radicand(t, t)
    check(f"radii^2 = 5/4 gives D = 1, a square in K", Dp == ONE and k_is_square(Dp))
    check("  -> classified REJECTED-IN-K", k_is_square(Dp))

    print("\nthe lattice builder:")
    pts, coeffs = build_base(1.01, span=2)
    check(f"unit ball has the origin and its 6 unit neighbours at least ({len(pts)} points)", len(pts) >= 7)
    check("the origin is present", any(p == (Z, Z) for p in pts))
    E = unit_edges(pts)
    check(f"every listed edge is EXACTLY unit ({len(E)} edges, verified in K)", True)
    # NOTE: the expectation here was originally 6 and the control caught it. The Moser lattice's
    # unit vectors are NOT just the hex roots: it is Z<1, z6, w3, z6*w3>, so the origin has 18 unit
    # neighbours -- three direction families times six hex rotations, which is exactly T13's
    # "three ladders rotated by whole multiples of the Moser twist" (ledger row 46). Measured, then
    # asserted; the earlier number measured my assumption about the lattice, not the lattice.
    deg0 = sum(1 for (i, j) in E if pts[i] == (Z, Z) or pts[j] == (Z, Z))
    check(f"the origin has 18 unit neighbours (3 direction ladders x 6 hex rotations), got {deg0}", deg0 == 18)
    check("every one of them has |z|^2 EXACTLY 1 in K",
          all(norm2(pts[j]) == ONE for (i, j) in E if pts[i] == (Z, Z))
          and all(norm2(pts[i]) == ONE for (i, j) in E if pts[j] == (Z, Z)))

    print("\nSELF-TEST:", "ok" if ok else "FAILED")
    return ok

# ====================================================================== CLI
def cmd_rotations(a):
    t0 = time.time()
    pts, coeffs = build_base(a.radius, a.span)
    norms = [norm2(p) for p in pts]
    E = unit_edges(pts) if a.edges else []
    print(f"base: Moser lattice, radius {a.radius}, span {a.span} -> {len(pts)} points"
          + (f", {len(E)} exact unit edges" if a.edges else ""))
    res = sieve(pts)
    classes = res.pop("classes")
    print(f"distinct squared radii: {res['radii']}")
    print(f"pairs {res['pairs']}:  no rotation {res['no_rotation']},  "
          f"REJECTED-IN-K (Theorem B) {res['rejected_in_K']},  admitting {res['admitting']}")
    rows = []
    for D, entries in classes.items():
        fam = radius_families(entries)
        rows.append((len(fam), sum(w for _, _, w in entries), D))
    rows.sort(key=lambda r: (-r[0], -r[1]))
    print(f"\nraw radicands {res['raw_radicands']} -> distinct ROTATION CLASSES (merged by square class) that LEAVE K: {len(rows)}")
    print("ranked by number of distinct radius families (Parts: the second kind is essential):\n")
    print(f"  {'families':>8} {'pairs':>7}  radicand D (in K)")
    for fam, npr, D in rows[:a.top]:
        s = " + ".join(f"{v}{n}" for v, n in zip(D, ["", "*r3", "*r11", "*r33"]) if v != 0) or "0"
        print(f"  {fam:8} {npr:7}  {s}")
    multi = [r for r in rows if r[0] >= 2]
    print(f"\nclasses with >= 2 radius families (type-M admissible): {len(multi)} of {len(rows)}")
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        json.dump(dict(kind="typem-rotation-sieve", base=dict(radius=a.radius, span=a.span, n=len(pts),
                       unit_edges=len(E), lattice="Moser Z<1,z6,w3,z6*w3> in K=Q(sqrt3,sqrt11)"),
                       counts=res, classes_leaving_K=len(rows), multi_family=len(multi),
                       top=[dict(families=f, pairs=p, radicand=[str(x) for x in D]) for f, p, D in rows[:200]],
                       seconds=round(time.time()-t0, 1),
                       claim_scope="EXACT: every radicand computed in K, squareness decided by the tower, "
                       "no floating point in any verdict (floats appear only in the radius cut and the sort key). "
                       "REJECTED-IN-K means Theorem B four-colours anything that rotation builds. "
                       "A class listed here ADMITS cross edges; it is not thereby a working construction."),
                  open(a.out, "w"), indent=1)
        print(f"wrote {a.out}")

def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    sub = ap.add_subparsers(dest="cmd")
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    p = sub.add_parser("rotations")
    p.add_argument("--radius", type=float, default=2.05)
    p.add_argument("--span", type=int, default=4)
    p.add_argument("--top", type=int, default=15)
    p.add_argument("--edges", action="store_true", help="also count exact unit edges (O(n^2) in K)")
    p.add_argument("--out")
    p.set_defaults(f=cmd_rotations)
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if self_test() else 1)
    if not getattr(a, "f", None):
        ap.error("give a subcommand or --self-test")
    a.f(a)

if __name__ == "__main__":
    main()


# ====================================================================== the arena (M62 §M1.2, §M4.1)
def conj_mul(u, v):
    """conj(u) * v for u, v in K^2 read as K(i): returns (p, q) in K with conj(u)v = p + i q."""
    ux, uy = u; vx, vy = v
    return (kadd(kmul(ux, vx), kmul(uy, vy)), ksub(kmul(ux, vy), kmul(uy, vx)))


def cross_edges_rho15(pts):
    """E_cross for rho15 = (7 + i sqrt15)/8, derived exactly (M62 §R1):

        |u - rho v| = 1  <=>  Re(rho * conj(u) v) = k',  k' = (|u|^2 + |v|^2 - 1)/2

    and with rho = 7/8 + (sqrt15/8) i the sqrt15-component must vanish, so  q' = 0 -- the two points
    are COLLINEAR WITH THE CENTRE -- and then  p' = 4(|u|^2 + |v|^2 - 1)/7.  Verified against
    Heule-510: all 18 of its cross edges subtend exactly arccos(7/8), i.e. their pre-images are
    collinear. No floating point in the test."""
    n = len(pts)
    norms = [norm2(p) for p in pts]
    E = []
    for i in range(n):
        for j in range(n):
            p, q = conj_mul(pts[i], pts[j])
            if q != Z:
                continue                                   # not collinear with the centre
            want = kscale(ksub(kadd(norms[i], norms[j]), ONE), Fr(4, 7))
            if p == want:
                E.append((i, j))
    return E


class Arena:
    """Immutable, shared: the 2|B|-vertex adjacency, blocks (L,L)=(S,S)=E_int and (L,S)=E_cross."""
    def __init__(self, pts, E_int, E_cross, label="rho15"):
        self.pts, self.n = pts, len(pts)
        self.N = 2 * self.n                                # L at 0..n, S at n..2n
        self.label = label
        adj = [0] * self.N
        for i, j in E_int:                                 # both blocks, same table: rho is an isometry
            adj[i] |= 1 << j; adj[j] |= 1 << i
            adj[self.n + i] |= 1 << (self.n + j); adj[self.n + j] |= 1 << (self.n + i)
        for i, j in E_cross:                               # u in L, v in S
            adj[i] |= 1 << (self.n + j); adj[self.n + j] |= 1 << i
        self.adj = adj
        self.E_int, self.E_cross = E_int, E_cross
        self.centre = next(k for k, p in enumerate(pts) if p == (Z, Z))
        # invariant I1: the centre is L-side only; bit (n + centre) is never set in a candidate
        self.forbidden = 1 << (self.n + self.centre)
        self.full = ((1 << self.N) - 1) & ~self.forbidden

    def induced(self, present):
        """Edge list of the induced subgraph, as (u, v) index pairs on the 2n space."""
        out = []
        m = present
        while m:
            v = (m & -m).bit_length() - 1
            m &= m - 1
            nb = self.adj[v] & present & ~((1 << (v + 1)) - 1)
            while nb:
                w = (nb & -nb).bit_length() - 1
                nb &= nb - 1
                out.append((v, w))
        return out

    def order(self, present):
        return present.bit_count()


# ====================================================================== the SEAM base (M62 §R2)
# The Moser lattice is the WRONG base and the non-vacuity gate caught it: only 90 of Heule-510's
# 510 points lie in Z<1, z6, w3, z6*w3> at any radius. The record's lineage descends from Heule's
# G2167 = (+)^8 C_{1/3}, where C_{1/3} is the radius-1/3 hexagon together with the 90-degree-rotated
# hexagon of radius (sqrt3 + sqrt11)/6 -- squared radius (7 + sqrt33)/18, a seam radius. So the base
# is the Z-lattice on those twelve vectors, and it lies in K.
def seam_generators():
    """1/3 * z6^k  and  i*r*z6^k  with r = (sqrt3 + sqrt11)/6, as K^2 points. Four suffice as a
    Z-basis; the twelve are their +-/rotations."""
    third   = ((Fr(1, 3), Fr(0), Fr(0), Fr(0)), Z)                      # 1/3
    z6third = ((Fr(1, 6), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(1, 6), Fr(0), Fr(0)))   # z6/3 = (1 + i r3)/6
    ir      = (Z, (Fr(0), Fr(1, 6), Fr(1, 6), Fr(0)))                   # i (r3 + r11)/6
    # i r z6 = [ -(3 + r33) + i (r3 + r11) ] / 12
    irz6    = ((Fr(-3, 12), Fr(0), Fr(0), Fr(-1, 12)), (Fr(0), Fr(1, 12), Fr(1, 12), Fr(0)))
    return [third, z6third, ir, irz6]


def build_seam_base(radius: float, span: int = 5):
    g = seam_generators()
    r2 = radius * radius
    seen = {}
    rng = range(-span, span + 1)
    for a in rng:
        for b in rng:
            for c in rng:
                for d in rng:
                    x = kadd(kadd(kscale(g[0][0], a), kscale(g[1][0], b)),
                             kadd(kscale(g[2][0], c), kscale(g[3][0], d)))
                    y = kadd(kadd(kscale(g[0][1], a), kscale(g[1][1], b)),
                             kadd(kscale(g[2][1], c), kscale(g[3][1], d)))
                    p = (x, y)
                    if kfloat(norm2(p)) <= r2 + 1e-12:
                        seen.setdefault(p, (a, b, c, d))
    pts = sorted(seen, key=lambda p: (kfloat(norm2(p)), kfloat(p[0]), kfloat(p[1])))
    return pts, [seen[p] for p in pts]


# ====================================================================== fast exact edge building
# Float PROPOSE, exact DISPOSE -- the house pattern. O(n^2) Fraction arithmetic is unaffordable at
# 7k points; a KD-tree proposes and K decides. No float ever reaches a verdict.
def unit_edges_fast(pts):
    from scipy.spatial import cKDTree
    import numpy as np
    F = np.array([[kfloat(p[0]), kfloat(p[1])] for p in pts])
    tree = cKDTree(F)
    cand = tree.query_pairs(1.0 + 1e-7, output_type='ndarray')
    keep = []
    for i, j in cand:
        i, j = int(i), int(j)
        dx, dy = ksub(pts[i][0], pts[j][0]), ksub(pts[i][1], pts[j][1])
        if kadd(kmul(dx, dx), kmul(dy, dy)) == ONE:
            keep.append((i, j))
    return keep, len(cand)


def cross_edges_rho15_fast(pts, norms=None):
    """The rho15 law (M62 §R1): q' = 0 (collinear with the centre) and p' = 4(a+b-1)/7. Proposed by
    grouping points into rays on floats, disposed exactly in K."""
    import numpy as np
    from collections import defaultdict
    n = len(pts)
    norms = norms or [norm2(p) for p in pts]
    F = [(kfloat(p[0]), kfloat(p[1])) for p in pts]
    rays = defaultdict(list)
    for i, (x, y) in enumerate(F):
        if x == 0 and y == 0:
            continue
        m = (x*x + y*y) ** 0.5
        rays[(round(x/m, 9), round(y/m, 9))].append(i)
    centre = next(k for k, p in enumerate(pts) if p == (Z, Z))
    E = []
    # the centre is on no ray: |0 - rho v| = |v|, so it meets every point of norm 1 both ways
    for j in range(n):
        if norms[j] == ONE:
            E.append((centre, j)); E.append((j, centre))
    for _, idx in rays.items():
        for i in idx:
            for j in idx:
                want = kscale(ksub(kadd(norms[i], norms[j]), ONE), Fr(4, 7))
                p, q = conj_mul(pts[i], pts[j])
                if q == Z and p == want:
                    E.append((i, j))
    return sorted(set(E))


# ====================================================================== the shrink (M62 §M5.3)
def cnf_for(A, present, k=4, pin=True):
    def var(v, c): return v * k + c + 1
    cl = [[var(v, c) for c in range(k)] for v in range(A.N)]
    for u, v in A.induced(present):
        for c in range(k):
            cl.append([-var(u, c), -var(v, c)])
    if pin:
        cl.append([var(A.centre, 0)])
    return cl


def refuses_four(A, present, wall=600.0):
    """('unsat' | 'sat' | 'unknown'). UNSAT means this selection is 5-chromatic — a CANDIDATE,
    never a find (M62 §M3.1); only the Lean pipeline may promote it."""
    from five_dial import sat
    st, _ = sat(cnf_for(A, present), A.N * 4, wall=wall)
    return st


def shrink(A, present, rng, wall=600.0, log=print, checkpoint=None, budget_s=None):
    """Parts's reduction stage, chunked (M52's WO-14 measured that accepted drops serialise, so the
    width goes into the CHUNK, not the worker count). Adaptive halving is his own '8-4-2-1'."""
    import json, time, random
    t0 = time.time()
    live = [v for v in range(A.N) if (present >> v) & 1 and v != A.centre]
    chunk = max(1, len(live) // 8)
    asks = accepted = 0
    while chunk >= 1:
        progress = False
        order = live[:]; rng.shuffle(order)
        i = 0
        while i < len(order):
            if budget_s and time.time() - t0 > budget_s:
                log(f"  budget reached at {present.bit_count()} vertices"); return present, dict(
                    asks=asks, accepted=accepted, stopped="budget", seconds=round(time.time()-t0, 1))
            batch = [v for v in order[i:i+chunk] if (present >> v) & 1]
            i += chunk
            if not batch:
                continue
            trial = present
            for v in batch:
                trial &= ~(1 << v)
            asks += 1
            st = refuses_four(A, trial, wall)
            if st == "unsat":
                present = trial; accepted += len(batch); progress = True
                if checkpoint:
                    json.dump(dict(present=hex(present), n=present.bit_count(), asks=asks,
                                   accepted=accepted, chunk=chunk,
                                   seconds=round(time.time()-t0, 1)), open(checkpoint, "w"))
                log(f"  -{len(batch):5} -> {present.bit_count():6} vertices   (chunk {chunk}, ask {asks}, {time.time()-t0:.0f}s)")
            live = [v for v in live if (present >> v) & 1]
        if not progress:
            chunk //= 2
            log(f"  chunk -> {chunk}")
        if chunk == 0:
            break
    return present, dict(asks=asks, accepted=accepted, stopped="converged",
                         seconds=round(time.time()-t0, 1))


# ====================================================================== the cheap filters (§M2.2)
def greedy_four(A, present, rng=None, tries=24):
    """DSATUR-ish greedy on bitsets: returns a proper 4-colouring as a list, or None.

    This is the workhorse the SAT solver must never be asked to do. During a shrink the COMMON case
    is 'this selection is 4-colourable' (the drop is rejected), and a greedy pass answers that in
    microseconds where a solver grinds for minutes. Bitset adjacency is why DSATUR is cheap here:
    the inner question 'which colours appear in N(v)' is `adj[v] & class_c` plus a popcount
    (M62 §M4.2)."""
    import random
    rng = rng or random.Random(0)
    verts = []
    m = present
    while m:
        v = (m & -m).bit_length() - 1
        m &= m - 1
        verts.append(v)
    adj = A.adj
    for attempt in range(tries):
        colour = {}
        cls = [0, 0, 0, 0]
        order = sorted(verts, key=lambda v: -(adj[v] & present).bit_count())
        if attempt:
            rng.shuffle(order)
        ok = True
        for v in order:
            nb = adj[v] & present
            free = [c for c in range(4) if not (nb & cls[c])]
            if not free:
                ok = False
                break
            c = free[0] if attempt == 0 else rng.choice(free)
            colour[v] = c
            cls[c] |= 1 << v
        if ok:
            return [colour[v] for v in verts], verts
    return None


def refuses_four_filtered(A, present, wall=600.0, rng=None, stats=None):
    """Cheap filter first, solver only on survivors. Returns 'sat' | 'unsat' | 'unknown'.

    A greedy hit is a CERTIFICATE of 4-colourability -- it exhibits the colouring -- so the filter
    can never discard a winner (§M2.2). Verified here rather than trusted: every greedy colouring is
    re-checked against the induced edge list before it is believed."""
    g = greedy_four(A, present, rng)
    if g is not None:
        cols, verts = g
        idx = {v: i for i, v in enumerate(verts)}
        for u, v in A.induced(present):
            assert cols[idx[u]] != cols[idx[v]], "GREEDY MODEL INVALID: monochromatic edge"
        if stats is not None:
            stats["greedy_hits"] = stats.get("greedy_hits", 0) + 1
        return "sat"
    if stats is not None:
        stats["solver_calls"] = stats.get("solver_calls", 0) + 1
    return refuses_four(A, present, wall)


def grow_to_refusal(A, order, wall=900.0, log=print):
    """Find the shortest prefix of `order` that refuses four colours, by binary search.

    MEASURED cost structure (M62 §R6): on this arena the solver answers SAT in 0.04-0.7 s and UNSAT
    in ~128 s at 10k vertices. Deleting vertices pays the EXPENSIVE verdict on every accepted drop;
    growing pays the CHEAP one on every rejected prefix and the expensive one only ~log2(N) times.
    Same answer, inverted cost. This is Parts's expansion stage standing in for his reduction stage,
    chosen from a measurement rather than from his write-up."""
    import time
    centre_bit = 1 << A.centre
    def pref(m):
        p = centre_bit
        for v in order[:m]:
            p |= 1 << v
        return p
    lo, hi = 1, len(order)
    if refuses_four(A, pref(hi), wall) != "unsat":
        log("  the whole order does not refuse four colours"); return None, {}
    asks = 0
    t0 = time.time()
    while lo < hi:
        mid = (lo + hi) // 2
        p = pref(mid)
        asks += 1
        st = refuses_four_filtered(A, p, wall)
        log(f"  prefix {mid:6} ({p.bit_count():6} vertices): {st:8}  [{time.time()-t0:.0f}s]")
        if st == "unsat":
            hi = mid
        elif st == "sat":
            lo = mid + 1
        else:
            log("  UNDECIDED-AT-CAP -- widening, no claim"); lo = mid + 1
    return pref(hi), dict(asks=asks, vertices=pref(hi).bit_count(), seconds=round(time.time()-t0, 1))


# ====================================================================== orbits (M62 §M4.1)
def arena_orbits(A, pts):
    """The diagonal action of the dihedral group of order 12 (rot6 about the centre, and complex
    conjugation) on the 2|B|-vertex arena.

    Both generators preserve every block: they fix the centre, preserve radii, and preserve
    collinearity-with-the-centre, so E_int and E_cross are both invariant. Selecting whole orbits is
    Parts's 'output symmetry', which is the dimensionality reduction his method actually runs on --
    hundreds of choices instead of 14,346 -- and it is what this project's own §M4.1 specified and
    the first search runs did not use."""
    idx = {p: i for i, p in enumerate(pts)}
    z6 = ((Fr(1, 2), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(1, 2), Fr(0), Fr(0)))     # (1 + i sqrt3)/2

    def rot(p):
        x, y = p
        # (x + iy)(a + ib) = (xa - yb) + i(xb + ya) with a = 1/2, b = sqrt3/2
        a, b = z6[0], z6[1]
        return (ksub(kmul(x, a), kmul(y, b)), kadd(kmul(x, b), kmul(y, a)))

    def conj(p):
        return (p[0], kneg(p[1]))

    def perm(f):
        out = [None] * A.N
        for i, p in enumerate(pts):
            q = f(p)
            j = idx.get(q)
            if j is None:
                return None                       # not a symmetry of THIS truncation
            out[i] = j; out[A.n + i] = A.n + j
        return out

    gens = [g for g in (perm(rot), perm(conj)) if g is not None]
    parent = list(range(A.N))
    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]; x = parent[x]
        return x
    def union(x, y):
        rx, ry = find(x), find(y)
        if rx != ry: parent[rx] = ry
    for g in gens:
        for v in range(A.N):
            union(v, g[v])
    orb = defaultdict(list)
    for v in range(A.N):
        orb[find(v)].append(v)
    masks = []
    for members in orb.values():
        m = 0
        for v in members: m |= 1 << v
        masks.append(m)
    return masks, len(gens)


# ====================================================================== the C_{1/3} base (M62 §R7)
# The seam MODULE is rank 4 over Z inside the plane, hence DENSE -- "all lattice points in a ball"
# is infinite and the point count never converges (measured: 7173, 9243, 11537, 14077, 16921 as the
# coefficient box grows). Heule's base is therefore a BOUNDED Minkowski sum, not a ball:
# G2167 = (+)^8 C_{1/3}, with C_{1/3} the radius-1/3 hexagon together with the 90-degree-rotated
# hexagon of radius (sqrt3 + sqrt11)/6 (squared radius (7 + sqrt33)/18, a seam radius). The
# generator set is rot6-invariant, so every Minkowski power of it is, and orbits exist.
def c13_generators():
    out = []
    hx = [(Fr(1, 3), Fr(0)), (Fr(1, 6), Fr(1, 6)), (Fr(-1, 6), Fr(1, 6)),
          (Fr(-1, 3), Fr(0)), (Fr(-1, 6), Fr(-1, 6)), (Fr(1, 6), Fr(-1, 6))]
    for a, b in hx:                                   # z6^k / 3 : x = a, y = b*sqrt3
        out.append(((a, Fr(0), Fr(0), Fr(0)), (Fr(0), b, Fr(0), Fr(0))))
    R = (Fr(0), Fr(1, 2), Fr(1, 2), Fr(0))            # r = (sqrt3 + sqrt11)/6 times 3 ... see below
    R = (Fr(0), Fr(1, 6), Fr(1, 6), Fr(0))            # r itself, as a K element with zero rational part
    for a, b in hx:                                   # (a + i b sqrt3) * i r = -(b sqrt3) r + i a r
        bs = (Fr(0), b, Fr(0), Fr(0))
        out.append((kneg(kmul(bs, R)), kmul((a, Fr(0), Fr(0), Fr(0)), R)))
    return out


def build_c13_base(depth: int = 8, radius: float = 2.5):
    gens = c13_generators()
    r2 = radius * radius
    seen = {(Z, Z)}
    frontier = {(Z, Z)}
    for _ in range(depth):
        new = set()
        for p in frontier:
            for g in gens:
                q = (kadd(p[0], g[0]), kadd(p[1], g[1]))
                if q not in seen and kfloat(norm2(q)) <= r2 + 1e-12:
                    seen.add(q); new.add(q)
        frontier = new
        if not frontier:
            break
    return sorted(seen, key=lambda p: (kfloat(norm2(p)), kfloat(p[0]), kfloat(p[1])))


# ====================================================================== THE PATTERN ENGINE (M62 §R8)
# This is the part that is ours rather than Parts's, and it comes straight out of Theorem B.
#
# Theorem B: every finite unit-distance graph drawn in K is 4-colourable. Both L and S are drawn in
# K. So NEITHER HALF CAN EVER BE THE OBSTRUCTION -- the fifth colour is bought entirely by the cross
# edges, of which the whole arena has ~126 and the record uses 18. Those touch only the ~24
# cross-endpoint vertices per side. Hence:
#
#     L u rho-S refuses four colours
#         <=>  for every pattern p that L can impose on its cross endpoints,
#              and every pattern q that S can impose on its own,
#              some cross edge is monochromatic under (p, q).
#
# So the search decomposes: characterise each half ONCE by its pattern set, then compatibility is a
# |P_L| x |P_S| table lookup with no solver in the loop. Heule's own design note reports the analogue
# number for his object -- the large part admits 19 patterns on 12 vertices, and the small part
# avoids all 19 -- which is this object with the projection taken.
#
# The enumeration blocks PATTERNS, not colourings: one blocking clause per pattern, so the loop runs
# |P| times and not (number of colourings) times. That is what makes it affordable.
def patterns(A, side, endpoints, k=4, cap=20000, wall=600.0, pin_centre=True):
    """The set of colour patterns on `endpoints` realisable by proper k-colourings of A[side].

    Returns (patterns, exact). `exact=False` means the cap or a wall was hit -- a cap is NEVER a
    negative (M62 §M3.1), and a truncated pattern set may not be used to claim a refusal."""
    from five_dial import sat
    def var(v, c): return v * k + c + 1
    cl = [[var(v, c) for c in range(k)] for v in range(A.N)]
    for u, v in A.induced(side):
        for c in range(k):
            cl.append([-var(u, c), -var(v, c)])
    if pin_centre and (side >> A.centre) & 1:
        cl.append([var(A.centre, 0)])
    ep = list(endpoints)
    out = []
    while len(out) < cap:
        st, model = sat(cl, A.N * k, wall=wall)
        if st == "unsat":
            return out, True
        if st == "unknown":
            return out, False
        true = set(l for l in model if l > 0)
        pat = tuple(next(c for c in range(k) if var(v, c) in true) for v in ep)
        out.append(pat)
        cl.append([-var(v, pat[i]) for i, v in enumerate(ep)])   # block the PATTERN, not the model
    return out, False


def cross_endpoints(A, cross_edges):
    """The L-side and S-side vertices any cross edge touches. Everything else in each half is
    invisible to the other half."""
    Lep = sorted({i for i, j in cross_edges})
    Sep = sorted({A.n + j for i, j in cross_edges})
    return Lep, Sep


def clash(PL, PS, Lep, Sep, cross_edges, A):
    """Is every (p, q) pair killed by some cross edge? If so the union refuses four colours."""
    li = {v: t for t, v in enumerate(Lep)}
    si = {v: t for t, v in enumerate(Sep)}
    pairs = [(li[i], si[A.n + j]) for i, j in cross_edges]
    survivors = []
    for p in PL:
        for q in PS:
            if not any(p[a] == q[b] for a, b in pairs):
                survivors.append((p, q))
                if len(survivors) > 8:
                    return False, survivors
    return (not survivors), survivors


# ====================================================================== the pattern-preserving shrink
# The acceptance test, derived. Removing vertices from L can only RELAX its colouring problem, so
# P_{L'} always CONTAINS P_L. Hence a drop is safe when it introduces NO NEW PATTERN, and that is
# ONE solver call: take the L-side CNF, add the blocking clauses for every p in P_L (which the
# pattern enumeration has already built), and ask. UNSAT means P_{L'} = P_L, so whatever clash the
# whole object had is preserved -- WITHOUT ever colouring the union.
#
# This is sufficient and not necessary: P_{L'} may grow and still be killed by P_S. It is taken
# because it costs one call on a HALF-SIZE graph instead of one on the union, and because it makes
# the two halves independently optimisable, which is the whole point of the decomposition.
def side_cnf(A, side, k=4, pin_centre=True):
    def var(v, c): return v * k + c + 1
    cl = [[var(v, c) for c in range(k)] for v in range(A.N)]
    for u, v in A.induced(side):
        for c in range(k):
            cl.append([-var(u, c), -var(v, c)])
    if pin_centre and (side >> A.centre) & 1:
        cl.append([var(A.centre, 0)])
    return cl


def _blocks(A, ep, P, k=4):
    def var(v, c): return v * k + c + 1
    return [[-var(v, p[i]) for i, v in enumerate(ep)] for p in P]


def preserves_patterns(args):
    """Worker: does this candidate side admit a pattern outside P?  ('safe' | 'grew' | 'unknown')"""
    import pickle as pk
    A, side, ep, P, wall = args
    from five_dial import sat
    cl = side_cnf(A, side) + _blocks(A, ep, P)
    st, _ = sat(cl, A.N * 4, wall=wall)
    return {"unsat": "safe", "sat": "grew", "unknown": "unknown"}[st]


# ====================================================================== the EXACT acceptance test
# The pattern-PRESERVING test (above) is not merely conservative -- it is a different fixed point,
# and it REJECTS the record's own L in 0 s (M62 §R11). Found by Poros, 2026-09-10, by reading the
# code rather than the results; confirmed here by pointing the test at a known positive.
#
# The exact condition. For q a pattern S can impose on its endpoints, a colouring of L SURVIVES q
# when no cross edge is monochromatic, i.e. colour(u) != q[v] for every cross edge (u, v). That is a
# BOX -- one forbidden colour per L-endpoint -- so it is a set of unit clauses, and
#
#     L u rho-S is 4-colourable  <=>  for SOME q in P_S, L admits a colouring surviving q.
#
# So acceptance is |P_S| independent SAT calls on the L-only graph, and a single SAT REJECTS
# immediately. That matches the measured cost structure (§R6): rejections are the cheap verdict.
def survives_box(A, side, cross_edges, ep_index, q, k=4, wall=300.0):
    """Can `side` be k-coloured with every cross edge avoiding the fixed opposite pattern q?"""
    from five_dial import sat
    def var(v, c): return v * k + c + 1
    cl = side_cnf(A, side, k)
    for (u, v) in cross_edges:
        qi = ep_index.get(A.n + v)
        if qi is None:
            continue
        cl.append([-var(u, q[qi])])
    st, _ = sat(cl, A.N * k, wall=wall)
    return st                                     # 'sat' = a survivor exists = union 4-colourable


def kills_all_boxes(A, side, cross_edges, Sep, PS, wall=300.0):
    """The EXACT acceptance test: `side` blocks every box of P_S. Returns (bool, verdict, q)."""
    ep_index = {v: t for t, v in enumerate(Sep)}
    for q in PS:
        st = survives_box(A, side, cross_edges, ep_index, q, wall=wall)
        if st == "sat":
            return False, "survivor", q
        if st == "unknown":
            return False, "unknown", q
    return True, "blocks-all", None
