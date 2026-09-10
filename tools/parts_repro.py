#!/usr/bin/env python3
"""[Parts2020a] reproduced: his base, his orbit labels, his type-M decomposition.

This module is the *calibration layer* of M63. Nothing here searches; everything here is a
statement about his published objects that we can check, so that when the search runs later we
know the ground it stands on is his and not ours.

WHY IT EXISTS. `[Parts2020a]` (arXiv:2010.12665) reports the record 509-vertex 5-chromatic
unit-distance graph as ORBIT FILLINGS over a base lattice with an order-24 symmetry group
(his Tables 2-7). Reading those tables requires four conventions to agree with his exactly:

  1. the base lattice          -- his 5.6, our `typem.parts_lattice`
  2. the group                 -- his order-24 group, our `typem.parts_group`
  3. the ORBIT LABEL           -- which member of an orbit names it; he never states the rule
  4. the L / rho*S split       -- which points are the large subgraph and which the small

Each is a guess until it is checked, and `self_test()` checks all four at once against data he
published and data we already hold, with no free parameters:

  * Heule's 510-vertex graph (`tools/heule510.json`, held here since M06) splits under
    rho15 = (7 + i*sqrt15)/8 into 375 + 136 sharing the origin, with EVERY point of both sides
    landing exactly on his denominator-12 lattice -- zero points off it.
  * The L side's orbit fillings then reproduce his Table 2's 375-column on all 41 rows.
  * The S side's orbit set is exactly his Table 4's, with every filling inside his {M} ranges.
  * The rho15 cross edges fall into his two named connecting orbits with his counts:
    the REFERENCE orbit (0,4,4,0) at radius 2, and the AUXILIARY orbit (0,0,2,6) at
    radius^2 = (17 +- sqrt33)/6, twelve edges each.

THE ORBIT LABEL RULE, recovered rather than assumed. His labels are all-even, non-negative and
carry a zero coordinate (`[Parts2020a]` publishes 41 of them in Table 2 alone). That does not
pin a unique member: the orbit at radius 1/3 contains both (4,0,0,0) and (2,0,2,0), and he
writes (4,0,0,0). The rule that reproduces all 41 is **maximize the number of zero coordinates,
then take the lexicographic minimum**. Measured, not guessed -- see `self_test`.

THE AUXILIARY ORBIT IS ONE ORBIT AT TWO RADII, and that is the geometric content of his remark
that "the existence of triangles of the second kind is essential". Two of the twenty-four group
elements are Galois (sqrt3, sqrt11 |-> -sqrt3, -sqrt11 and its partner), so an orbit carries two
squared norms n and sigma(n): the twelve points of (0,0,2,6) sit six at radius sqrt((17+sqrt33)/6)
= 1.9470 and six at sqrt((17-sqrt33)/6) = 1.3696, and an auxiliary edge joins one half on the L
side to the other half on the S side. His own sentence gives the two radii as sqrt11/2 +- sqrt3/6,
whose squares are exactly those. Both cross-edge families -- reference (t = r = 2) and auxiliary
(t, r the conjugate pair) -- have the same coupling constant

    c = (t^2 + r^2 - 1) / (2 t r) = 7/8 = Re(rho15),

which is WHY one rotation realizes both, and why no second rotation is needed.

RADIUS. His base is "orbits that fall completely or partially on a disk of radius r = 2". Because
the group does not preserve a Euclidean disk, an orbit meeting the disk carries points outside it,
so a both-conjugates-inside truncation at r = 2 is a strictly smaller set: it MISSES the orbit
(0,0,6,6) (true radius 2.5243) that his section 6 names as one of the two whose addition produced
the record, and it misses 37 of Heule-510's own 510 points. `PARTS_R = 2.6` is the smallest
round radius admitting (0,0,6,6); the honest construction is whole orbits meeting the radius-2
disk, and `orbits_meeting_disk` builds that directly so the two can be compared rather than
assumed equal.
"""
import json, math, os, pickle, sys
from collections import defaultdict
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PARTS_R = 2.6
RHO_RE, RHO_IM2 = Fr(7, 8), 15        # rho15 = (7 + i sqrt15)/8
TOWER_PRIMES = [3, 5, 7, 11]          # bit order of the 16-slot multiquadratic basis
K_SLOTS = (0, 1, 8, 9)                # 1, sqrt3, sqrt11, sqrt33


# --------------------------------------------------------------------------- the base
class Base:
    """His base graph B: the lattice, its orbits, and his label for each orbit.

    Attributes:
      pts    -- K-points, ordered by radius (typem's own order)
      tups   -- the (a,b,c,d) lattice tuple of each point, x = (a + b*sqrt33)/12,
                y = (c*sqrt3 + d*sqrt11)/12
      orbits -- list of index lists
      label  -- orbit index -> his (a,b,c,d) label
      of     -- lattice tuple -> orbit index
      radii  -- orbit index -> (r_small, r_large), the two Euclidean radii of the orbit
    """

    def __init__(self, r=PARTS_R, verbose=False):
        self.r = r
        self.pts, self.tups = T.parts_lattice(r)
        self.orbits, outside = T.parts_orbits(self.pts)
        if outside:
            raise AssertionError(f"base at r={r} is not group-closed: {outside} images outside")
        self.of = {}
        for oi, o in enumerate(self.orbits):
            for i in o:
                self.of[self.tups[i]] = oi
        self.label = {oi: orbit_label([self.tups[i] for i in o]) for oi, o in enumerate(self.orbits)}
        self.by_label = {v: k for k, v in self.label.items()}
        if len(self.by_label) != len(self.orbits):
            raise AssertionError("two orbits share a label -- the label rule is not injective here")
        self.radii = {oi: orbit_radii(self.pts[self.orbits[oi][0]]) for oi in range(len(self.orbits))}
        if verbose:
            sizes = defaultdict(int)
            for o in self.orbits:
                sizes[len(o)] += 1
            print(f"base r={r}: {len(self.pts)} points, {len(self.orbits)} orbits, sizes {dict(sorted(sizes.items()))}")

    def size(self, label):
        return len(self.orbits[self.by_label[label]])

    def members(self, label):
        """The lattice tuples of an orbit, in his listing order (by radius then coordinates)."""
        return [self.tups[i] for i in self.orbits[self.by_label[label]]]


def orbit_label(tuples):
    """His label for an orbit: among the all-even non-negative members carrying a zero
    coordinate, the one with the most zeros, ties broken lexicographically.

    Recovered from his own Table 2, where all 41 published labels are reproduced by this rule and
    the two obvious alternatives (plain lexicographic minimum; the member on an axis) are not."""
    good = [t for t in tuples
            if all(v >= 0 for v in t) and all(v % 2 == 0 for v in t) and any(v == 0 for v in t)]
    if not good:
        good = [t for t in tuples if all(v >= 0 for v in t)]
    if not good:
        good = list(tuples)
    return min(good, key=lambda t: (-sum(1 for v in t if v == 0), t))


def orbit_radii(p):
    """(smaller, larger) Euclidean radius of the orbit through a K-point.

    An orbit carries the two Galois-conjugate squared norms; a Euclidean disk is therefore not
    group-invariant, which is the whole reason his radius-2 clause says "completely or partially"."""
    n = T.norm2(p)
    a, b = float(n[0]), float(n[3])          # norm2 in the basis (1, sqrt3, sqrt11, sqrt33)
    s = math.sqrt(33.0)
    vals = sorted(math.sqrt(max(v, 0.0)) for v in (a + b * s, a - b * s))
    return (vals[0], vals[1])


def orbits_meeting_disk(base, r=2.0):
    """His base as stated: the orbits with at least one point inside the disk of radius r.

    Returns the set of orbit labels. Compare against a truncation to see whether "r = 2, orbits
    meeting the disk" and "both conjugates within R" name the same set -- they need not."""
    out = set()
    for oi, o in enumerate(base.orbits):
        if base.radii[oi][0] <= r + 1e-9:
            out.add(base.label[oi])
    return out


# ------------------------------------------------------------- the type-M decomposition
def _tmul(u, v):
    out = [Fr(0)] * 16
    for i, a in enumerate(u):
        if not a:
            continue
        for j, b in enumerate(v):
            if not b:
                continue
            f = 1
            for bit in range(4):
                if (i >> bit) & 1 and (j >> bit) & 1:
                    f *= TOWER_PRIMES[bit]
            out[i ^ j] += a * b * f
    return out


_SQRT15 = [Fr(0)] * 16
_SQRT15[3] = Fr(1)


def _rho_inv(p):
    """multiply a tower point by conj(rho15) = (7 - i sqrt15)/8"""
    x, y = p
    rx, ry = _tmul(_SQRT15, x), _tmul(_SQRT15, y)
    return ([RHO_RE * x[i] + Fr(1, 8) * ry[i] for i in range(16)],
            [RHO_RE * y[i] - Fr(1, 8) * rx[i] for i in range(16)])


def _in_K(p):
    return all(p[0][i] == 0 and p[1][i] == 0 for i in range(16) if i not in K_SLOTS)


def _to_lattice(p):
    """K-point -> (a,b,c,d) on his denominator-12 lattice, or None if it is not on it."""
    x, y = p
    if x[1] or x[8] or y[0] or y[9]:
        return None
    vals = (x[0] * 12, x[9] * 12, y[1] * 12, y[8] * 12)
    if any(v.denominator != 1 for v in vals):
        return None
    return tuple(int(v) for v in vals)


def split_type_m(path):
    """Split a witness stored in the 16-slot tower into L and rho*S about the shared centre.

    A type-M graph is G = L u rho*S with L drawn in K = Q(sqrt3, sqrt11) and rho = rho15
    adjoining sqrt15 ~ sqrt5, so the split needs no search: a vertex is on the L side exactly
    when it is sqrt5-free, and on the S side exactly when rho^-1 of it is.

    Returns a dict with 'L' and 'S' mapping vertex index -> lattice tuple, 'shared' the indices
    on both sides, and 'off_lattice' the indices on neither -- which must be empty for the object
    to be a type-M graph over his base at all."""
    d = json.load(open(path))
    den = Fr(d["denom"])
    if d.get("primes") != TOWER_PRIMES:
        raise AssertionError(f"{path}: tower primes {d.get('primes')} != {TOWER_PRIMES}")
    pts = [([Fr(c) / den for c in x], [Fr(c) / den for c in y]) for x, y in d["coords"]]
    L, S, shared, off = {}, {}, [], []
    for i, p in enumerate(pts):
        tl = _to_lattice(p) if _in_K(p) else None
        q = _rho_inv(p)
        ts = _to_lattice(q) if _in_K(q) else None
        if tl is not None and ts is not None:
            shared.append(i)
        if tl is not None:
            L[i] = tl
        if ts is not None:
            S[i] = ts
        if tl is None and ts is None:
            off.append(i)
    return {"L": L, "S": S, "shared": shared, "off_lattice": off,
            "n": len(pts), "edges": len(d["edges"]), "path": path}


def fillings(tuples, base):
    """Orbit fillings of a vertex set: his orbit label -> how many of its members are present."""
    out = defaultdict(int)
    for t in tuples:
        oi = base.of.get(t)
        if oi is None:
            raise KeyError(f"lattice point {t} is outside the base at r={base.r}")
        out[base.label[oi]] += 1
    return dict(out)


# ------------------------------------------------------------------------ his published data
def table2(path=None):
    """[Parts2020a] Table 2: orbit fillings of five L-subgraphs, as a checked artifact."""
    path = path or os.path.join(ROOT, "data", "m62", "parts-table2-orbit-fillings.json")
    return json.load(open(path))


# ------------------------------------------------------------------------------- self-test
def self_test(r=PARTS_R, verbose=True):
    """Every convention this module fixes, checked against data we did not choose.

    Fails loudly. A silent pass is not available: each check prints what it compared."""
    fails = []

    def chk(name, cond, detail=""):
        print(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    print(f"parts_repro self-test (base radius {r})")
    B = Base(r, verbose=verbose)
    chk("base is group-closed", True, f"{len(B.pts)} points / {len(B.orbits)} orbits")
    chk("orbit labels are injective", len(B.by_label) == len(B.orbits))

    t2 = table2()
    rows = t2["rows"]
    for col in t2["columns"]:
        s = sum(r_["fill"][col] for r_ in rows)
        chk(f"Table 2 column {col} sums to {col}", s == int(col.split("_")[0]), f"got {s}")
    missing = [r_["orbit"] for r_ in rows if tuple(r_["orbit"]) not in B.by_label]
    chk("all 41 Table-2 labels are canonical reps of our orbits", not missing, str(missing))
    over = [r_["orbit"] for r_ in rows
            if tuple(r_["orbit"]) in B.by_label
            and max(r_["fill"].values()) > B.size(tuple(r_["orbit"]))]
    chk("every Table-2 filling fits its orbit", not over, str(over))

    sp = split_type_m(os.path.join(ROOT, "tools", "heule510.json"))
    chk("Heule-510 is entirely on his lattice", not sp["off_lattice"],
        f"off {len(sp['off_lattice'])}")
    chk("Heule-510 splits 375 + 136 sharing one vertex",
        len(sp["L"]) == 375 and len(sp["S"]) == 136 and len(sp["shared"]) == 1,
        f"L {len(sp['L'])} S {len(sp['S'])} shared {len(sp['shared'])}")

    fl = fillings(sp["L"].values(), B)
    exp = {tuple(r_["orbit"]): r_["fill"]["375_heule510"] for r_ in rows}
    bad = [(k, fl.get(k, 0), v) for k, v in exp.items() if fl.get(k, 0) != v]
    extra = [k for k in fl if k not in exp]
    chk("Heule-510's L reproduces Table 2's 375 column, all 41 rows",
        not bad and not extra, f"mismatches {bad} extra {extra}")

    fs = fillings(sp["S"].values(), B)
    t4 = {(0,0,0,0), (0,0,4,0), (0,0,8,0), (0,4,0,0), (6,2,0,0), (0,2,2,0), (0,2,6,0),
          (0,0,2,6), (6,0,0,6), (0,4,4,0), (12,2,2,0), (6,2,4,0), (6,0,4,6), (0,2,4,6)}
    chk("Heule-510's S uses exactly Table 4's fourteen orbits", set(fs) == t4,
        f"ours-his {sorted(set(fs)-t4)} his-ours {sorted(t4-set(fs))}")

    X = T.cross_edges_rho15_fast(B.pts)
    fam = defaultdict(int)
    for (u, v) in X:
        fam[(B.label[B.of[B.tups[u]]], B.label[B.of[B.tups[v]]])] += 1
    ref = fam.get(((0, 4, 4, 0), (0, 4, 4, 0)), 0)
    aux = fam.get(((0, 0, 2, 6), (0, 0, 2, 6)), 0)
    chk("reference orbit (0,4,4,0) carries twelve cross edges", ref == 12, f"got {ref}")
    chk("auxiliary orbit (0,0,2,6) carries twelve cross edges", aux == 12, f"got {aux}")
    ra = B.radii[B.by_label[(0, 0, 2, 6)]]
    want = (math.sqrt((17 - math.sqrt(33)) / 6), math.sqrt((17 + math.sqrt(33)) / 6))
    chk("auxiliary orbit sits at his two radii sqrt11/2 -+ sqrt3/6",
        all(abs(a - b) < 1e-12 for a, b in zip(ra, want)), f"{ra} vs {want}")
    rr = B.radii[B.by_label[(0, 4, 4, 0)]]
    chk("reference orbit sits at radius 2", abs(rr[0] - 2) < 1e-12 and abs(rr[1] - 2) < 1e-12, str(rr))

    # the coupling constant both families share, which is why one rotation realizes both
    for nm, (t, u) in (("reference", (2.0, 2.0)), ("auxiliary", want)):
        c = (t * t + u * u - 1) / (2 * t * u)
        chk(f"{nm} coupling constant is Re(rho15) = 7/8", abs(c - 0.875) < 1e-12, f"{c:.15f}")

    print(f"\n{'ALL CHECKS PASSED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


if __name__ == "__main__":
    ok = self_test(verbose=True)
    sys.exit(0 if ok else 1)


# --------------------------------------------------------- his lattice tuples as K-points
def kpoint(t):
    """(a,b,c,d) -> the K-point (x, y) in typem's basis (1, sqrt3, sqrt11, sqrt33).

    Deliberately NOT `typem.lattice_point`, which parameterizes the same lattice differently
    (the Minkowski-power basis of M31). His convention is the one stated in his own readme:
    x = (a + b*sqrt33)/12, y = (c*sqrt3 + d*sqrt11)/12."""
    a, b, c, d = t
    return ((Fr(a, 12), Fr(0), Fr(0), Fr(b, 12)), (Fr(0), Fr(c, 12), Fr(d, 12), Fr(0)))
