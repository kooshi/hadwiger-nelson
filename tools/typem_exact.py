#!/usr/bin/env python3
"""typem_exact — the type-M rotation enumerator, with NO float in any verdict.

WHY THIS MODULE EXISTS (2026-09-11). Two audits found the stored rotation list
`data/m62/rotations-moser-r2.05.json` untrustworthy for two independent reasons:

  1. **It has no producer.** Its keys (`type_m_admissible`, `record_rotation`, `max_families`,
     `family_list`) appear nowhere in committed code; `typem.cmd_rotations` cannot emit them.
     A file nobody can regenerate is provenance, not data.
  2. **A float decides an exact verdict.** `typem.sieve` cuts on `if kfloat(D) < 0`, and
     `CrossLaw.collinear` refuses on `if kfloat(D) <= 0`, where D is an EXACT element of
     K = ℚ(√3, √11). Near zero the float sign flips and a candidate is dropped in silence.

The defect class matters more than either instance. **A cross-edge law that MISSES edges yields an
easier graph, which yields a colouring, which reads as a sound elimination** (Poros, 2026-09-11). A
dropped candidate does not announce itself as a bug: it announces itself as a productive search. So
every control here asserts that edges are NOT MISSED, not merely that none are invented.

WHAT IS HERE
  * `ksign` — the exact sign of a + b√3 + c√11 + d√33, decided by norms down the tower ℚ ⊂ ℚ(√3) ⊂ K.
    No floats, no interval refinement, no precision parameter, O(1) rational operations.
  * exact bases — `parts_lattice_exact` (his §5.6 denominator-12 lattice) and `moser_ball_exact`,
    with the disk membership decided exactly instead of by a float with a 1e-9 slack.
  * the angle census — the rotations with cos θ ∈ K that carry any cross edge, enumerated over the
    base's LINES (`CrossLaw`'s own derivation), with kinds, edge counts and the arithmetic ranking.
  * **rotation classes up to base symmetry**, never angles: for a base closed under negation and
    under a Galois flip, {±c, ±τc} are one rotation wearing four labels, and reporting four
    negatives where there is one would inflate the survey's headline in the flattering direction.
  * the radicand square-class sieve re-derived exactly — the "412" number, with the float removed.

    python3 tools/typem_exact.py --self-test
    python3 tools/typem_exact.py census --base parts:2.44 --out data/m62/rotations-parts-r2.44.json
    python3 tools/typem_exact.py sieve  --base moser:2.05 --out data/m62/radicands-moser-r2.05.json

UNTRUSTED like everything in tools/. It reads `typem.py` and never writes it (two live jobs import
that module; Python 3.14's forkserver re-imports it per worker, so an edit lands mid-run).
"""
from __future__ import annotations
import argparse, json, math, sys, time
from collections import defaultdict
from fractions import Fraction as Fr
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
ROOT = Path(__file__).resolve().parent.parent

import typem as T                                     # READ-ONLY. Never edited by this module.
from typem import Z, ONE, kadd, ksub, kneg, kscale, kmul, kdiv, kinv, kfloat, k_is_square, kstr

# ============================================================ §1  THE EXACT SIGN PREDICATE
# An element of K is (a, b, c, d) meaning a + b√3 + c√11 + d√33, all Fractions — typem's shape.
#
# METHOD: norms down the tower, two levels, closed form.
#
#   Level 1, F = ℚ(√3).  For x = a + b√3 with a, b ≠ 0 of OPPOSITE sign, x > 0 iff the positive
#   term dominates, and both sides may be squared because both are positive:
#       a > 0 > b :  x > 0  ⟺  a > |b|√3  ⟺  a² − 3b² > 0
#       a < 0 < b :  x > 0  ⟺  b√3 > |a|  ⟺  3b² − a² > 0
#   so in both cases sign(x) = sign(a) · sign(a² − 3b²).  Same signs or a zero term are immediate.
#   a² − 3b² = 0 with b ≠ 0 would make √3 rational, so the sub-sign is never 0 here.
#
#   Level 2, K = F(√11).  Identical argument with A, B ∈ F in place of a, b and the norm
#   A² − 11B², which vanishes only if √11 ∈ F.  The recursion bottoms out in ℚ, where the sign of
#   a Fraction is exact by construction.
#
# WHY THIS SHAPE, against the alternative actually weighed (exact interval arithmetic over
# Fraction with a doubling precision loop and a proof-carrying fallback): the interval method needs
# a termination argument (it loops forever on a true zero unless a separation bound is supplied),
# a precision parameter that becomes a tuning knob, and a fallback path that is exercised only in
# the rare case — i.e. the path that is never tested is the one that decides the hard inputs. The
# tower method has no loop, no parameter, no fallback and no rare path: every input takes the same
# four multiplications. Its whole correctness argument is the two lines above, and the one external
# fact it needs — √11 ∉ ℚ(√3) — is the same fact `k_is_square` already rests on.
#
# COST: the deciding quantity is a rational of roughly four times the input's bit length. On the
# radicands this sieve meets that is tens of bits; `Fraction` comparison is exact at any size.


def _sgn(q) -> int:
    return (q > 0) - (q < 0)


def f_sign(A) -> int:
    """Exact sign of A = a + b√3, a, b ∈ ℚ, given as the pair (a, b)."""
    a, b = A
    if b == 0:
        return _sgn(a)
    if a == 0:
        return _sgn(b)
    sa, sb = _sgn(a), _sgn(b)
    if sa == sb:
        return sa
    t = a * a - 3 * b * b
    if t == 0:                                        # ⟹ √3 = |a/b| ∈ ℚ. Impossible.
        raise ArithmeticError(f"a² = 3b² with b ≠ 0 makes √3 rational: {A!r}")
    return sa * _sgn(t)


def ksign(x) -> int:
    """Exact sign (−1, 0, +1) of a + b√3 + c√11 + d√33. No floating point anywhere."""
    a, b, c, d = x
    A, B = (a, b), (c, d)                             # x = A + B√11 with A, B ∈ ℚ(√3)
    sA, sB = f_sign(A), f_sign(B)
    if sB == 0:
        return sA
    if sA == 0:
        return sB
    if sA == sB:
        return sA
    # A² − 11B², in F
    A2 = (A[0] * A[0] + 3 * A[1] * A[1], 2 * A[0] * A[1])
    B2 = (B[0] * B[0] + 3 * B[1] * B[1], 2 * B[0] * B[1])
    Tt = (A2[0] - 11 * B2[0], A2[1] - 11 * B2[1])
    sT = f_sign(Tt)
    if sT == 0:                                       # ⟹ √11 ∈ ℚ(√3). Impossible.
        raise ArithmeticError(f"A² = 11B² with B ≠ 0 puts √11 in ℚ(√3): {x!r}")
    return sA * sT


def kcmp(x, y) -> int:
    """Exact three-way comparison of two K elements."""
    return ksign(ksub(x, y))


def kpos(x) -> bool:  return ksign(x) > 0
def knonneg(x) -> bool:  return ksign(x) >= 0


class KOrder:
    """A total order on K for sorting and for canonical pair keys — exact, never `kfloat`.

    `typem.radius_families` canonicalises an unordered radius pair with `kfloat(a) <= kfloat(b)`.
    Two distinct radii whose floats collide therefore produce TWO keys for one unordered pair and
    the family count inflates. This class is the replacement; use it wherever a K element is
    sorted or a pair is put in canonical order."""

    def __init__(self, x):
        self.x = x

    def __lt__(self, other):
        return kcmp(self.x, other.x) < 0

    def __eq__(self, other):
        return self.x == other.x

    def __hash__(self):
        return hash(self.x)


def kpair(a, b):
    """The canonical unordered pair {a, b}, ordered EXACTLY."""
    return (a, b) if kcmp(a, b) <= 0 else (b, a)


# ============================================================ §2  THE FLOAT CONTROL
# A measured demonstration that the float test this module replaces gets the sign wrong, rather
# than an assertion that it might.

def kfloat_sign(x) -> int:
    """typem's decision procedure, isolated: the sign as a float would report it."""
    return _sgn(kfloat(x))


def _cf_convergents(alpha: float, n: int):
    """Continued-fraction convergents of a positive real — only to MANUFACTURE hard inputs; no
    verdict is taken from this function."""
    from fractions import Fraction
    x = Fraction(alpha).limit_denominator(10 ** 18)
    out, (h0, h1, k0, k1) = [], (0, 1, 1, 0)
    while len(out) < n and x.denominator:
        a = x.numerator // x.denominator
        h0, h1 = h1, a * h1 + h0
        k0, k1 = k1, a * k1 + k0
        out.append(Fr(h1, k1))
        rem = x - a
        if rem == 0:
            break
        x = 1 / rem
    return out


def near_zero_probes():
    """K elements engineered to sit within float error of zero, with their TRUE signs.

    Shape: p/q ± √33 and p/q ± √3, with p/q a continued-fraction convergent of the radical. The
    true value is ~1/(2q²·radical); once that falls below the ~1e-16 relative error of the float
    sum, the float sign is a coin toss and the exact sign is still right. The shape matches what
    the sieve actually meets — the stored file's own top radicands are `α + δ√33` with α < 0 —
    so this is the live failure mode, not a contrived one."""
    probes = []
    for radical, slot, name in ((33, 3, "√33"), (3, 1, "√3"), (11, 2, "√11")):
        for p in _cf_convergents(math.sqrt(radical), 40)[12:]:
            for sgn in (+1, -1):
                x = [Fr(0)] * 4
                x[0] = -p * sgn
                x[slot] = Fr(sgn)
                # true sign: sgn·(radical − (p/q)²) has the sign of sgn·(radical·q² − p²)
                true = _sgn(sgn) * _sgn(radical * p.denominator ** 2 - p.numerator ** 2)
                probes.append((tuple(x), true, f"{-p * sgn} + {sgn}·{name}"))
    return probes


# ============================================================ §3  EXACT BASES
# Every base here decides membership with `ksign`. typem's builders cut with
# `kfloat(norm2(p)) <= r2 + 1e-12` (three sites) and `parts_lattice` with a float disk test and a
# 1e-9 slack; a point on the boundary is then admitted or dropped by rounding.

def norm2(p):
    x, y = p
    return kadd(kmul(x, x), kmul(y, y))


def parts_lattice_exact(r: Fr):
    """`[Parts2020a]` §5.6's denominator-12 lattice inside the disk of radius r — EXACT membership.

    z = (a + b√33 + i(c√3 + d√11))/12 with a ≡ b ≡ c ≡ d (mod 2) and a − b + c + d ≡ 0 (mod 4);
    the disk bounds the norm AND its Galois conjugate:

        (a ± b√33)² + (c√3 ± d√11)² ≤ (12r)²  for both sign choices,

    which expands to  (a² + 33b² + 3c² + 11d²) ± 2(ab + cd)√33 ≤ L — an element of ℚ(√33), so the
    pair of conditions is the single exact test  L − A − |2(ab+cd)|·√33 ≥ 0."""
    L = (12 * Fr(r)) ** 2
    Lf = float(L)
    A_ = int(Lf ** 0.5) + 2
    B_ = int((Lf / 33) ** 0.5) + 2
    C_ = int((Lf / 3) ** 0.5) + 2
    D_ = int((Lf / 11) ** 0.5) + 2
    out = []
    for a in range(-A_, A_ + 1):
        for b in range(-B_, B_ + 1):
            ab = a * b
            for c in range(-C_, C_ + 1):
                for d in range(-D_, D_ + 1):
                    if (a - b) % 2 or (a - c) % 2 or (a - d) % 2 or (a - b + c + d) % 4:
                        continue
                    A = a * a + 33 * b * b + 3 * c * c + 11 * d * d
                    slack = (Fr(L - A), Fr(0), Fr(0), Fr(-2 * abs(ab + c * d)))
                    if ksign(slack) >= 0:
                        out.append((a, b, c, d))
    pts = [((Fr(a, 12), Fr(0), Fr(0), Fr(b, 12)), (Fr(0), Fr(c, 12), Fr(d, 12), Fr(0)))
           for (a, b, c, d) in out]
    order = sorted(range(len(pts)), key=lambda i: (KOrder(norm2(pts[i])),
                                                   KOrder(pts[i][0]), KOrder(pts[i][1])))
    return [pts[i] for i in order], [out[i] for i in order]


def moser_ball_exact(r: Fr, span: int = 4):
    """The Moser lattice ℤ⟨1, ζ₆, ω₃, ζ₆ω₃⟩ inside the disk of radius r — EXACT membership.

    This is the base the stored 412-class list was computed on. The project records it as the
    WRONG base for this problem (only 90 of Heule-510's 510 points lie in it at any radius,
    M62 §R7/§R22); it is rebuilt here only so the corrected counts can be compared with the
    stored ones on the same ground."""
    r2 = (Fr(r) * Fr(r), Fr(0), Fr(0), Fr(0))
    seen = {}
    for a in range(-span, span + 1):
        for b in range(-span, span + 1):
            for c in range(-span, span + 1):
                for d in range(-span, span + 1):
                    p = T.lattice_point(a, b, c, d)
                    if ksign(ksub(r2, norm2(p))) >= 0:
                        seen.setdefault(p, (a, b, c, d))
    pts = sorted(seen, key=lambda p: (KOrder(norm2(p)), KOrder(p[0]), KOrder(p[1])))
    return pts, [seen[p] for p in pts]


BASES = {
    "parts": ("[Parts2020a] §5.6 denominator-12 lattice, exact disk", parts_lattice_exact),
    "moser": ("Moser lattice ℤ⟨1,ζ₆,ω₃,ζ₆ω₃⟩ ball, exact radius cut", moser_ball_exact),
}


def build_base(spec: str):
    """`parts:2.44` / `moser:2.05` → (name, description, points, coefficient tuples)."""
    kind, _, rs = spec.partition(":")
    if kind not in BASES:
        raise SystemExit(f"unknown base {kind!r}; known: {', '.join(BASES)}")
    desc, fn = BASES[kind]
    r = Fr(rs)                                        # EXACT: Fr("2.44") is 61/25, not a float
    pts, coeffs = fn(r)
    return f"{kind}:{r}", f"{desc}, radius {r}", pts, coeffs


# ============================================================ §4  THE ANGLE CENSUS
# The law (CrossLaw's docstring, M63 phase C §C5, and this plan's §1.1):
#   |u − ρv|² = 1  ⟺  Re(ρ·conj(u)v) = k,  k = (|u|² + |v|² − 1)/2.
# With ρ = c + is, c ∈ K, s ∉ K, and conj(u)v = p + iq, the identity splits over {1, s}:
#   q = 0  (u, v collinear with the centre)   and   c·p = k.
# So the rotations with cos ∈ K carrying any cross edge are exactly cos = k/p over collinear pairs.

def line_key(p):
    """Exact canonical key of the line through the origin and p; None at the origin.

    Both coordinates lie in K, so v = λu with λ ∈ K for collinear points and dividing by the first
    nonzero coordinate is canonical. It folds antipodes together automatically, which the committed
    `cross_edges_rho15_fast` — which keys rays on `round(x/m, 9)` and by SIGNED direction — does
    not: that function can split a line at a rounding boundary and cannot see an antipodal pair at
    all. Missing a line means missing its cross edges, which is the elimination-flattering
    direction."""
    x, y = p
    if x == Z and y == Z:
        return None
    return (ONE, kdiv(y, x)) if x != Z else (Z, ONE)


def conj_mul(u, v):
    """conj(u)·v = p + iq for u, v ∈ K² read as K(i)."""
    ux, uy = u
    vx, vy = v
    return (kadd(kmul(ux, vx), kmul(uy, vy)), ksub(kmul(ux, vy), kmul(uy, vx)))


def census(pts, coeffs=None, verbose=True):
    """Every rotation with cos θ ∈ K that carries a cross edge on this base.

    Returns a dict keyed by the exact cosine, each value carrying its realizing radius pairs (the
    "kinds"), its ordered non-centre cross-edge count, and the Theorem-B verdict. Centre edges
    (u = 0 with |v|² = 1, and its mirror) belong to EVERY rotation and are counted once, apart."""
    n = len(pts)
    norms = [norm2(p) for p in pts]
    lines = defaultdict(list)
    centre = None
    for i, p in enumerate(pts):
        k = line_key(p)
        if k is None:
            if centre is not None:
                raise AssertionError("two origins in the base")
            centre = i
        else:
            lines[k].append(i)
    n_unit = sum(1 for nn in norms if nn == ONE)
    centre_edges = 2 * n_unit if centre is not None else 0

    by_cos = {}
    half = Fr(1, 2)
    collinear_pairs = 0
    for idx in lines.values():
        for i in idx:
            ni = norms[i]
            for j in idx:
                p, q = conj_mul(pts[i], pts[j])
                if q != Z:                             # CONTROL: must never fire on one line
                    raise AssertionError("a line key grouped two non-collinear points")
                collinear_pairs += 1
                if p == Z:
                    continue                           # impossible off the centre; guarded anyway
                k = kscale(ksub(kadd(ni, norms[j]), ONE), half)
                c = kdiv(k, p)
                e = by_cos.get(c)
                if e is None:
                    e = by_cos[c] = dict(cos=c, edges=0, kinds=set(), diag=0, offdiag_ordered=0)
                e["edges"] += 1
                e["kinds"].add(kpair(ni, norms[j]))
                if i == j:
                    e["diag"] += 1
                else:
                    e["offdiag_ordered"] += 1

    out = {}
    for c, e in by_cos.items():
        s2 = ksub(ONE, kmul(c, c))                     # sin²θ
        sgn = ksign(s2)
        e["sin2"] = s2
        e["is_rotation"] = sgn > 0                     # |cos| < 1, decided EXACTLY
        e["sin2_sign"] = sgn
        e["in_K"] = k_is_square(s2) if sgn > 0 else None   # Theorem B: ρ ∈ K(i) ⟹ 4-colourable
        e["kinds"] = sorted(e["kinds"], key=lambda ab: (KOrder(ab[0]), KOrder(ab[1])))
        e["n_kinds"] = len(e["kinds"])
        e["total_edges"] = e["edges"] + centre_edges
        out[c] = e
    if verbose:
        print(f"  base: {n} points, {len(lines)} lines, {collinear_pairs} ordered collinear pairs, "
              f"{n_unit} points of norm 1 → {centre_edges} centre cross edges (every rotation)")
    return dict(cosines=out, n_points=n, n_lines=len(lines), n_unit=n_unit,
                centre_edges=centre_edges, collinear_pairs=collinear_pairs)


# ============================================================ §5  ROTATION CLASSES UP TO SYMMETRY
# The reporting unit is a ROTATION UP TO THE BASE'S OWN SYMMETRY, never an angle.
#
#  * If the base is closed under negation, relabelling the S-copy by v ↦ −v is a graph isomorphism
#    of the arena onto the arena of −ρ, whose cosine is −c.
#  * If the base is closed under a field automorphism τ ∈ Gal(K/ℚ) applied coordinatewise, τ is a
#    unit-distance bijection carrying the ρ-arena onto the τ(ρ)-arena, whose cosine is τ(c).
#  * ρ and ρ̄ give the SAME adjacency: the law reads only cos.
#
# So the fibre is {±c, ±τc}. Reporting four negatives where there is one negative would inflate the
# survey's headline in exactly the flattering direction. **Every symmetry used is VERIFIED against
# the actual point set, never assumed**: if a base fails to carry one, the merge that symmetry
# licenses is not performed, and the run says so.

GALOIS = {                                            # τ on (1, √3, √11, √33), as sign patterns
    "id":      (1, 1, 1, 1),
    "s3":      (1, -1, 1, -1),                        # √3 ↦ −√3   (so √33 ↦ −√33)
    "s11":     (1, 1, -1, -1),                        # √11 ↦ −√11 (so √33 ↦ −√33)
    "s3s11":   (1, -1, -1, 1),                        # complex conjugation on this lattice
}


def gal_apply(sig, x):
    return tuple(s * v for s, v in zip(sig, x))


def gal_point(sig, p):
    return (gal_apply(sig, p[0]), gal_apply(sig, p[1]))


def verify_symmetries(pts):
    """Which of {negation} ∪ Gal(K/ℚ) actually map this point set onto itself. Exact set test."""
    S = set(pts)
    found = {}
    found["negation"] = all((kneg(p[0]), kneg(p[1])) in S for p in pts)
    for name, sig in GALOIS.items():
        if name == "id":
            continue
        found[name] = all(gal_point(sig, p) in S for p in pts)
    return found


def rotation_classes(cosines, syms):
    """Group cosines into orbits under the VERIFIED symmetries. Returns [(rep, [variants])]."""
    maps = [lambda c: c]
    if syms.get("negation"):
        maps.append(lambda c: kneg(c))
    for name, sig in GALOIS.items():
        if name != "id" and syms.get(name):
            maps.append(lambda c, sig=sig: gal_apply(sig, c))
    keys = set(cosines)
    seen, classes = set(), []
    for c in sorted(keys, key=KOrder):
        if c in seen:
            continue
        orbit, frontier = {c}, [c]
        while frontier:
            x = frontier.pop()
            for m in maps:
                y = m(x)
                if y in keys and y not in orbit:
                    orbit.add(y)
                    frontier.append(y)
        seen |= orbit
        classes.append((c, sorted(orbit, key=KOrder)))
    return classes, len(maps)


# ============================================================ §6  THE ARITHMETIC RANKING
SQ11 = {(t * t) % 11 for t in range(1, 11)}            # {1, 3, 4, 5, 9}


def eleven_images(r):
    """The images of r ∈ K in 𝔽₁₁ at the two primes above 11, after normalising by K-squares.

    K = ℚ(√3, √11) has 11 = (𝔭₁𝔭₂)²: 3 is a square mod 11 (5² = 25 ≡ 3) so 11 splits in ℚ(√3),
    and it ramifies in ℚ(√11). Both primes have residue field 𝔽₁₁ and both are usable (11 ≡ 3
    mod 4), which is why 11 is the ONLY prime that can seal a field over K (G43).

    At each, √11 ↦ 0 and √3 ↦ ±5, so the image of a + b√3 + c√11 + d√33 is a ± 5b.

    Normalisation, and it is exact: clear denominators by a rational square, then strip factors of
    11 — legitimate because **11 = (√11)² is a square in K**, so dividing by it does not change the
    extension K(√r). An image of 0 after that means the prime ramifies in K(√r), which leaves 𝔽₁₁
    as the residue field, so the field stays 5-sealed there."""
    M = 1
    for v in r:
        M = M * v.denominator // math.gcd(M, v.denominator)
    scaled = [v * M * M for v in r]                    # r·M², a rational-SQUARE multiple of r
    if any(v.denominator != 1 for v in scaled):
        raise ValueError(f"clearing denominators failed on {r!r}")
    co = [int(v) for v in scaled]
    if not any(co):
        raise ValueError("the zero radicand has no square class")
    # Strip factors of 11 only. Division by 11 = (√11)² is division by a K-SQUARE, so it does not
    # move the square class; dividing by any other common factor would.
    while all(c % 11 == 0 for c in co):
        co = [c // 11 for c in co]
    A, B = co[0], co[1]
    return ((A + 5 * B) % 11, (A - 5 * B) % 11)


def eleven_status(r):
    """'inert-both' (6-open at 11), 'split/ramified' (still 5-sealed), or None if undecidable."""
    try:
        i1, i2 = eleven_images(r)
    except Exception as exc:
        wall_and_eleven.last_error = f"eleven_images: {exc!r}"
        return None
    tags = []
    for v in (i1, i2):
        tags.append("ram" if v == 0 else ("inert" if v not in SQ11 else "split"))
    return "+".join(tags)


def wall_and_eleven(r):
    """(breaks_alone, inert-at-both-primes-above-11) for the radicand r ∈ K, or None if undecided.

    wall: `tools/wall_break_test.classify_radicand` — −r a square in BOTH 2-adic completions of K,
    so K(√r) has i in every completion above 2 and no conjugation-fixed prime above 2 survives.
    6-open needs the wall broken AND 11 inert at both primes (G43)."""
    wall = None
    try:
        import wall_break_test as W
        from residue_colouring import sqrt33_2adic
        if not hasattr(wall_and_eleven, "_sq"):
            wall_and_eleven._sq = W.SquareClasses()
            wall_and_eleven._S = sqrt33_2adic(17)
        wall = W.classify_radicand(r, wall_and_eleven._S, wall_and_eleven._sq)["breaks_alone"]
    except Exception as exc:                           # LOUD: a silent None would read as "no"
        wall = None
        wall_and_eleven.last_error = repr(exc)
    st = eleven_status(r)
    inert = None if st is None else (st == "inert+inert")
    return wall, (inert, st)


# ============================================================ §7  THE RADICAND SQUARE-CLASS SIEVE
# typem.sieve, with the float sign test replaced by `ksign` and the family canonicalisation
# replaced by the exact order. This is the instrument that produced "412"; rerun here to say
# whether the float was costing candidates.

def sieve_exact(pts, float_shadow=True, verbose=True):
    norms = [norm2(p) for p in pts]
    mult = defaultdict(int)
    for nn in norms:
        mult[nn] += 1
    radii = sorted(mult, key=KOrder)
    half = Fr(1, 2)
    by_D = defaultdict(list)
    admits = rejected = no_rot = 0
    float_flips = []
    edge_capable_pairs = 0
    for a in radii:
        for b in radii:
            w = mult[a] * mult[b]
            N = kmul(a, b)
            k = kscale(ksub(kadd(a, b), ONE), half)
            D = ksub(N, kmul(k, k))
            sgn = ksign(D)
            if float_shadow and sgn != kfloat_sign(D) and not (sgn == 0 and kfloat_sign(D) == 0):
                float_flips.append((a, b, D, sgn, kfloat_sign(D)))
            if sgn < 0:
                no_rot += w
                continue
            if k_is_square(D):
                rejected += w
                continue
            admits += w
            cap = k_is_square(N)                       # ab a square in K ⟺ a collinear pair can exist
            if cap:
                edge_capable_pairs += w
            by_D[D].append((a, b, w, cap))
    reps, merged = [], defaultdict(list)
    for D, entries in by_D.items():
        hit = None
        for rrep in reps:
            if k_is_square(kmul(D, rrep)):
                hit = rrep
                break
        if hit is None:
            reps.append(D)
            hit = D
        merged[hit].extend(entries)
    classes = []
    for D, entries in merged.items():
        fams = {kpair(a, b) for a, b, _, _ in entries}
        cap_fams = {kpair(a, b) for a, b, _, cap in entries if cap}
        classes.append(dict(radicand=D, families=len(fams), edge_capable_families=len(cap_fams),
                            weighted_pairs=sum(w for _, _, w, _ in entries)))
    classes.sort(key=lambda e: (-e["edge_capable_families"], -e["families"], -e["weighted_pairs"]))
    if verbose:
        print(f"  radii {len(radii)}, ordered pairs {len(pts)**2}: no rotation {no_rot}, "
              f"rejected-in-K {rejected}, admitting {admits} ({edge_capable_pairs} edge-capable)")
    return dict(radii=len(radii), no_rotation=no_rot, rejected_in_K=rejected, admitting=admits,
                edge_capable_pairs=edge_capable_pairs, raw_radicands=len(by_D),
                classes=classes, float_flips=float_flips)


# ============================================================ §8  CONTROLS
def _hdr(s):
    print(f"\n{s}\n" + "-" * len(s))


def self_test(quick=False) -> bool:
    ok = True

    def check(what, cond):
        nonlocal ok
        print(f"  {'ok  ' if cond else 'FAIL'} {what}")
        ok = ok and bool(cond)

    _hdr("§1  the exact sign predicate, on known values")
    for v, want in (((Fr(0), Fr(0), Fr(0), Fr(0)), 0),
                    ((Fr(1), Fr(0), Fr(0), Fr(0)), +1),
                    ((Fr(-1), Fr(0), Fr(0), Fr(0)), -1),
                    ((Fr(-1), Fr(1), Fr(0), Fr(0)), +1),        # √3 − 1 > 0
                    ((Fr(-2), Fr(1), Fr(0), Fr(0)), -1),        # √3 − 2 < 0
                    ((Fr(0), Fr(-1), Fr(1), Fr(0)), +1),        # √11 − √3 > 0
                    ((Fr(-6), Fr(0), Fr(0), Fr(1)), -1),        # √33 − 6 < 0
                    ((Fr(-5), Fr(0), Fr(0), Fr(1)), +1),        # √33 − 5 > 0
                    ((Fr(15, 4), Fr(0), Fr(0), Fr(0)), +1),
                    ((Fr(-95, 24), Fr(0), Fr(0), Fr(17, 24)), +1)):   # a stored top radicand
        got = ksign(v)
        check(f"sign({kstr(v)}) = {got:+d}, want {want:+d}", got == want)

    _hdr("§2  the float test gets near-zero signs WRONG, and this one does not")
    probes = near_zero_probes()
    wrong_float = [(x, t) for x, t, _ in probes if kfloat_sign(x) != t]
    wrong_exact = [(x, t) for x, t, _ in probes if ksign(x) != t]
    check(f"{len(probes)} engineered near-zero probes built", len(probes) >= 40)
    check(f"the float sign is WRONG on {len(wrong_float)} of them  ← the defect, measured",
          len(wrong_float) > 0)
    check(f"the exact sign is wrong on {len(wrong_exact)} of them", len(wrong_exact) == 0)
    if wrong_float:
        x, t = wrong_float[0]
        print(f"       worked example: {kstr(x)}")
        print(f"         true sign {t:+d};  kfloat says {kfloat(x):+.3e} → {kfloat_sign(x):+d}")
        print(f"         a sieve cutting on `kfloat(D) < 0` drops this candidate in silence")
    tiniest = min(probes, key=lambda pr: abs(kfloat(pr[0])) if kfloat(pr[0]) else 1.0)
    check(f"smallest probe |value| ≈ {abs(kfloat(tiniest[0])):.3e}, exact sign {ksign(tiniest[0]):+d}"
          f" (float {kfloat_sign(tiniest[0]):+d})", ksign(tiniest[0]) == tiniest[1])

    _hdr("§3  the negative control: break the predicate on purpose and watch it go red")
    def broken_sign(x):                                # the float test, wearing ksign's name
        return kfloat_sign(x)
    caught = sum(1 for x, t, _ in probes if broken_sign(x) != t)
    check(f"a planted float-based sign predicate fails {caught} probes (must be > 0, or the "
          f"probe set cannot discriminate)", caught > 0)
    try:
        f_sign((Fr(3), Fr(0)))                          # sanity: no exception on the easy path
        bad = False
    except Exception:
        bad = True
    check("the exact predicate raises on no legitimate input", not bad)

    _hdr("§4  the exact bases agree with, or correct, the committed float-cut builders")
    print("      typem cuts its disks with a float and a 1e-9/1e-12 slack (five sites). A point on")
    print("      the boundary is then admitted or dropped by rounding, and a dropped point takes")
    print("      its cross edges with it — the elimination-flattering direction again.")
    t0 = time.time()
    for rs, want in (("2", 1603), ("2.44", 3433), ("2.6", 4513)):
        pe, _ = parts_lattice_exact(Fr(rs))
        pf, _ = T.parts_lattice(float(Fr(rs)))
        check(f"parts_lattice({rs}): exact {len(pe)} points = committed {len(pf)}, "
              f"sets identical (exact-only {len(set(pe)-set(pf))}, "
              f"committed-only {len(set(pf)-set(pe))})", set(pe) == set(pf))
        if want:
            check(f"  and it is {want} points, as [Parts2020a] §5.6 states", len(pe) == want)
    for rs in ("2.05", "2.5"):
        me, _ = moser_ball_exact(Fr(rs))
        mf, _ = T.build_base(float(Fr(rs)), span=4)
        check(f"moser ball {rs}: exact {len(me)} = committed {len(mf)}, sets identical",
              set(me) == set(mf))
    print(f"       [{time.time()-t0:.1f}s]  MEASURED: the float disk cut costs nothing on any base "
          f"this project uses. The defect is real; it does not fire here.")

    _hdr("§5  CALIBRATION against the known positive — the record's own rotation, ρ₁₅")
    print("      The published record (Parts 2020, 509 vertices) uses cos θ = 7/8. Two independent")
    print("      derivations already agree that this rotation carries 126 ordered cross edges on")
    print("      his lattice. This is the third. A disagreement HALTS; it is never adjusted away.")
    for rr, want in ((Fr(2), 126), (Fr("2.44"), 126)):
        pts, _ = parts_lattice_exact(rr)
        res = census(pts, verbose=False)
        seven_eighths = (Fr(7, 8), Fr(0), Fr(0), Fr(0))
        e = res["cosines"].get(seven_eighths)
        if e is None:
            check(f"parts_lattice({rr}): cos = 7/8 present in the census", False)
            continue
        tot = e["total_edges"]
        check(f"parts_lattice({rr}) ({len(pts)} pts): cos = 7/8 gives {tot} ordered cross edges, "
              f"want {want}", tot == want)
        print(f"       decomposition: {res['centre_edges']} centre + {e['offdiag_ordered']} "
              f"off-diagonal (ordered) + {e['diag']} diagonal = {tot}")
        print(f"       kinds (distinct radius pairs): {e['n_kinds']}  → "
              + "; ".join(f"{{{kstr(a)}, {kstr(b)}}}" for a, b in e["kinds"]))
        check(f"  its sin² = {kstr(e['sin2'])} is NOT a square in K (the rotation leaves K)",
              e["in_K"] is False)
        check(f"  sin² lies in the square class of 15 (the record's field ℚ(√3,√5,√11))",
              k_is_square(kmul(e["sin2"], (Fr(15), Fr(0), Fr(0), Fr(0)))))
        # the committed law is an INDEPENDENT oracle for the same number
        law = T.CrossLaw.rho15()
        comm = law.edges(pts)
        check(f"  the committed CrossLaw.rho15().edges() returns {len(comm)} on the same points",
              len(comm) == want)
        mine = set(census_edges(pts, seven_eighths))
        check(f"  every committed edge is in my edge set and vice versa "
              f"(|mine|={len(mine)}, |committed|={len(comm)})", mine == set(comm))
        if quick:
            break

    _hdr("§6  the edge-MISSING direction: the committed float ray-keying, measured")
    print("      A law that misses edges gives an easier graph, gives a colouring, and reads as a")
    print("      sound elimination. So the control asserts edges are NOT MISSED, not merely that")
    print("      none are invented.")
    for spec, want in (("parts:2", 126), ("parts:2.44", 126), ("moser:2.05", 66)):
        _, _, bp, _ = build_base(spec)
        exact_e = set(census_edges(bp, (Fr(7, 8), Fr(0), Fr(0), Fr(0))))
        fast_e = set(T.cross_edges_rho15_fast(bp))
        check(f"{spec}: the committed float-KEYED fast law (round(x/m, 9), signed rays) misses "
              f"{len(exact_e - fast_e)} and invents {len(fast_e - exact_e)} of {len(exact_e)}",
              exact_e == fast_e and len(exact_e) == want)
    pts, _ = parts_lattice_exact(Fr(2))

    _hdr("§7  rotation classes are counted up to the base's OWN symmetries, verified not assumed")
    syms = verify_symmetries(pts)
    check(f"parts_lattice(2) symmetries verified on the point set: "
          + ", ".join(f"{k}={'yes' if v else 'NO'}" for k, v in syms.items()),
          syms["negation"] and syms["s3s11"])
    res = census(pts, verbose=False)
    live = {c: e for c, e in res["cosines"].items() if e["is_rotation"] and e["in_K"] is False}
    classes, nmaps = rotation_classes(live, syms)
    c78 = (Fr(7, 8), Fr(0), Fr(0), Fr(0))
    cls = [v for _, v in classes if c78 in v]
    check(f"ρ₁₅'s own class exists and holds its sign variant "
          f"({[kstr(x) for x in cls[0]] if cls else '—'})",
          bool(cls) and kneg(c78) in cls[0])
    check("a planted broken merge (no symmetry at all) splits ρ₁₅ into more classes — the control",
          len(rotation_classes(live, {})[0]) > len(classes))

    _hdr("§8  the arithmetic ranking's own controls — the 11-test, against known fields")
    print("      A ranking column that computes nothing still prints a verdict. These are the")
    print("      positive signals for the thing that did not happen.")
    for rad, want, why in ((15, "split+split", "the record's own field K(√15) = ℚ(√3,√5,√11): "
                            "11 SPLITS, so 𝔽₁₁ survives and the field is 5-SEALED — which is "
                            "exactly why the record is 5-chromatic and not 6 (ledger row 52)"),
                           (5, "split+split", "same field by √3 ∈ K"),
                           (7, "inert+inert", "K(√7): 11 goes inert, so 11 stops sealing (G37)"),
                           (35, "inert+inert", "K(√35) is 11-inert (G43) — and keeps the wall"),
                           (13, "inert+inert", "K(√13) (G43)"),
                           (3, "split+split", "3 ≡ 5² mod 11"),
                           (2, "inert+inert", "2 is a non-residue mod 11")):
        got = eleven_status((Fr(rad), Fr(0), Fr(0), Fr(0)))
        check(f"11 at radicand {rad}: {got}  — {why}", got == want)
    check("√33's radicand ramifies at both primes above 11 (its image is 0)",
          eleven_status((Fr(0), Fr(0), Fr(0), Fr(1))) == "ram+ram")
    check("the 11-test is not constant: it returns at least two distinct verdicts above",
          len({eleven_status((Fr(t), Fr(0), Fr(0), Fr(0))) for t in (15, 7, 33)}) >= 2)
    w15, (i15, s15) = wall_and_eleven((Fr(15), Fr(0), Fr(0), Fr(0)))
    check(f"the 2-adic wall at 15: breaks_alone = {w15} (it must, the record is 5-chromatic)",
          w15 is True)
    check(f"so K(√15) is NOT 6-open (wall broken but 11 split): six_open = {bool(w15) and bool(i15)}",
          not (bool(w15) and bool(i15)))
    wp, (ip, sp) = wall_and_eleven((Fr(1), Fr(0), Fr(0), Fr(0)))
    check(f"a planted radicand of 1 (a square — no extension at all) is not wall-breaking: {wp}",
          wp is False)


    _hdr("§9  the margin: how close the float sign test comes to flipping, measured")
    print("      §2 proves the float test CAN be wrong. This asks whether it IS wrong on the")
    print("      objects this project uses — the only question that decides whether any standing")
    print("      number is affected.")
    for spec in ("parts:2", "parts:2.44", "moser:2.05"):
        _, _, bp, _ = build_base(spec)
        rad = sorted({norm2(p) for p in bp}, key=KOrder)
        worst, flips = None, 0
        for aa in rad:
            for bb in rad:
                kk = kscale(ksub(kadd(aa, bb), ONE), Fr(1, 2))
                D = ksub(kmul(aa, bb), kmul(kk, kk))
                if ksign(D) != kfloat_sign(D):
                    flips += 1
                if D != Z and (worst is None or abs(kfloat(D)) < worst):
                    worst = abs(kfloat(D))
        check(f"{spec}: {len(rad)} radii, smallest |D| = {worst:.3e}, float sign flips = {flips}",
              flips == 0)
    print("       So no standing count on these bases is an undercount from the float sign test.")

    print("\nSELF-TEST:", "ok" if ok else "FAILED")
    return ok


def census_edges(pts, cos):
    """The ordered cross edges at a given exact cosine — for controls; the census counts them."""
    law = T.CrossLaw(cos=cos)
    return law.edges(pts)


# ============================================================ §9  CLI
def _ser(x):
    return [str(v) for v in x]


def cmd_census(a):
    t0 = time.time()
    name, desc, pts, coeffs = build_base(a.base)
    print(f"base {name}: {desc} → {len(pts)} points")
    res = census(pts)
    syms = verify_symmetries(pts)
    print(f"  base symmetries (verified on the point set): "
          + ", ".join(f"{k}={'yes' if v else 'NO'}" for k, v in syms.items()))
    cos_all = res["cosines"]
    rot = {c: e for c, e in cos_all.items() if e["is_rotation"]}
    live = {c: e for c, e in rot.items() if e["in_K"] is False}
    multi = {c: e for c, e in live.items() if e["n_kinds"] >= 2}
    print(f"  cosines in K carrying a cross edge: {len(cos_all)}; "
          f"with |cos| < 1 (exact): {len(rot)}; "
          f"leaving K (Theorem B does not four-colour): {len(live)}; "
          f"with ≥ 2 kinds (type-M admissible): {len(multi)}")
    classes, nmaps = rotation_classes(multi, syms)
    print(f"  → {len(classes)} ROTATION CLASSES up to base symmetry "
          f"({nmaps} verified label-maps), from {len(multi)} angles")

    rows = []
    for rep, variants in classes:
        e = multi[rep]
        wall, (inert, est) = wall_and_eleven(e["sin2"])
        best = max(variants, key=lambda c: (multi[c]["n_kinds"], multi[c]["edges"]))
        rows.append(dict(
            cos=_ser(rep), cos_str=kstr(rep), cos_float=kfloat(rep),
            variants=[kstr(v) for v in variants], n_variants=len(variants),
            kinds=multi[best]["n_kinds"],
            per_variant=[dict(cos=kstr(v), kinds=multi[v]["n_kinds"],
                              offdiag_ordered=multi[v]["offdiag_ordered"], diag=multi[v]["diag"],
                              total_edges=multi[v]["total_edges"]) for v in variants],
            radicand=_ser(e["sin2"]), radicand_str=kstr(e["sin2"]),
            wall_breaks=wall, eleven_inert_both=inert, eleven=est,
            six_open=(bool(wall) and bool(inert)) if (wall is not None and inert is not None) else None,
            kind_list=[[kstr(x), kstr(y)] for x, y in multi[best]["kinds"]]))
    rows.sort(key=lambda r: (not bool(r["wall_breaks"]), -r["kinds"]))
    nwall = sum(1 for r in rows if r["wall_breaks"])
    nopen = sum(1 for r in rows if r["six_open"])
    nundec = sum(1 for r in rows if r["wall_breaks"] is None)
    print(f"  wall-breaking classes: {nwall} of {len(rows)}"
          + (f"  (UNDECIDED for {nundec} — see `wall_error` in the JSON)" if nundec else "")
          + f";  6-open: {nopen}")
    print(f"\n  {'rank':>4} {'cos θ':>26} {'≈':>8} {'vars':>4} {'kinds':>5} {'wall':>6} {'11':>12}")
    shown = rows if a.top is None else rows[:a.top]
    if a.top is not None and len(rows) > a.top:
        print(f"  ** DISPLAY TRUNCATED to {a.top} of {len(rows)} rows; the JSON holds all {len(rows)} **")
    for i, r in enumerate(shown, 1):
        print(f"  {i:4} {r['cos_str']:>26} {r['cos_float']:>8.4f} {r['n_variants']:>4} "
              f"{r['kinds']:>5} {str(r['wall_breaks']):>6} {str(r['eleven']):>12}")
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        json.dump(dict(
            kind="typem-exact-angle-census", tool="tools/typem_exact.py",
            command=f"python3 tools/typem_exact.py census --base {a.base}",
            base=dict(spec=name, description=desc, points=len(pts), lines=res["n_lines"],
                      unit_norm_points=res["n_unit"], centre_cross_edges=res["centre_edges"],
                      symmetries=syms),
            truncated=False, cap=None,
            counts=dict(cosines_in_K=len(cos_all), rotations=len(rot), leaving_K=len(live),
                        two_or_more_kinds=len(multi), rotation_classes=len(rows),
                        wall_breaking=nwall, six_open=nopen, wall_undecided=nundec),
            wall_error=getattr(wall_and_eleven, "last_error", None),
            classes=rows, seconds=round(time.time() - t0, 1),
            claim_scope=(
                "EXACT: every verdict — the disk membership, the collinearity, the cosine, "
                "|cos| < 1, and the Theorem-B squareness — is decided in K by exact rational "
                "arithmetic. Floats appear only in display columns. NOTHING IS TRUNCATED: every "
                "rotation class is listed. The reporting unit is a rotation UP TO THE BASE'S "
                "VERIFIED SYMMETRIES, not an angle: `variants` names the angles that collapse. "
                "SCOPE: rotations with cos θ ∈ K only; cos θ ∉ K needs the two-equation law and is "
                "not enumerated here. A listed class ADMITS cross edges of ≥ 2 kinds on this base "
                "at this radius; that is necessary for a type-M construction and NOT sufficient. "
                "No claim is made that any of them yields a 5-chromatic graph.")),
            open(a.out, "w"), indent=1)
        print(f"\nwrote {a.out}")


def cmd_sieve(a):
    t0 = time.time()
    name, desc, pts, coeffs = build_base(a.base)
    print(f"base {name}: {desc} → {len(pts)} points")
    print("  re-deriving the radicand square-class sieve EXACTLY (typem.sieve with ksign in place "
          "of the float sign test and the exact order in place of kfloat canonicalisation)")
    res = sieve_exact(pts)
    cls = res["classes"]
    multi = [c for c in cls if c["families"] >= 2]
    capm = [c for c in cls if c["edge_capable_families"] >= 2]
    print(f"  raw radicands {res['raw_radicands']} → {len(cls)} square classes leaving K")
    print(f"  classes with ≥ 2 radius families (the stored file's 'type_m_admissible'): {len(multi)}")
    print(f"  classes with ≥ 2 EDGE-CAPABLE families (ab a square in K — the honest count): "
          f"{len(capm)}")
    flips = res["float_flips"]
    print(f"  float sign flips on this base's radicands: {len(flips)}"
          + ("  ← the float test would have mis-sorted these" if flips else
             "  (none — on THIS base the defect does not fire; it is still a defect)"))
    for aa, bb, D, se, sf in flips[:5]:
        print(f"      D = {kstr(D)}: exact {se:+d}, float {sf:+d}")
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        json.dump(dict(
            kind="typem-exact-radicand-sieve", tool="tools/typem_exact.py",
            command=f"python3 tools/typem_exact.py sieve --base {a.base}",
            base=dict(spec=name, description=desc, points=len(pts)),
            truncated=False, cap=None,
            counts=dict(radii=res["radii"], no_rotation=res["no_rotation"],
                        rejected_in_K=res["rejected_in_K"], admitting=res["admitting"],
                        edge_capable_pairs=res["edge_capable_pairs"],
                        raw_radicands=res["raw_radicands"], classes_leaving_K=len(cls),
                        two_or_more_families=len(multi),
                        two_or_more_edge_capable_families=len(capm),
                        float_sign_flips=len(flips)),
            classes=[dict(radicand=_ser(c["radicand"]), radicand_str=kstr(c["radicand"]),
                          families=c["families"],
                          edge_capable_families=c["edge_capable_families"],
                          weighted_pairs=c["weighted_pairs"]) for c in cls],
            seconds=round(time.time() - t0, 1),
            claim_scope=(
                "EXACT: the sign of every radicand D = ab − k² is decided by `ksign`, not by a "
                "float; unordered radius pairs are canonicalised by exact comparison. NOTHING IS "
                "TRUNCATED: every class is listed. A class is a FIELD, not a rotation — one square "
                "class can hold several angles. `families` counts radius pairs including those no "
                "line of the base realises; `edge_capable_families` counts only pairs with ab a "
                "square in K, which is necessary for any cross edge to exist.")),
            open(a.out, "w"), indent=1)
        print(f"wrote {a.out}")


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    ap.add_argument("--quick", action="store_true")
    sub = ap.add_subparsers(dest="cmd")
    p = sub.add_parser("census", help="rotations with cos in K, up to base symmetry")
    p.add_argument("--base", default="parts:2.44")
    p.add_argument("--top", type=int, default=None, help="display cap only; the JSON is complete")
    p.add_argument("--out")
    p.set_defaults(f=cmd_census)
    q = sub.add_parser("sieve", help="the radicand square-class sieve, exactly")
    q.add_argument("--base", default="moser:2.05")
    q.add_argument("--out")
    q.set_defaults(f=cmd_sieve)
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if self_test(a.quick) else 1)
    if not getattr(a, "f", None):
        ap.error("give a subcommand or --self-test")
    a.f(a)


if __name__ == "__main__":
    main()
