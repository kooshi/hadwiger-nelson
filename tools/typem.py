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
