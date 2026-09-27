#!/usr/bin/env python3
"""FS107-W's exact checker for periodic grid-square partial colourings (FS-107, claim W; brief item 3).

A *member* is a periodic partial colouring of the plane by closed grid squares of side ``h``: the square with
integer index ``(i, j)`` is ``[i h, (i+1) h] x [j h, (j+1) h]``.  The colouring is invariant under a lattice
``Lambda`` of integer offsets (grid units), given by two basis vectors.  One representative per coloured coset of
``Lambda`` is listed; every other square is uncovered.

**The verdict is exact.**  Two closed squares whose index offset is ``(dx, dy)`` realise exactly the distances in
``[h*sqrt(gx^2 + gy^2), h*sqrt((|dx|+1)^2 + (|dy|+1)^2)]`` with ``gx = max(|dx| - 1, 0)`` (the set of distances
between two compact connected sets is an interval).  A same-coloured pair at that offset violates the closed band
``[1 - eps, 1 + eps]`` iff ``min <= 1 + eps`` and ``max >= 1 - eps`` -- compared as squares of rationals, so no
float enters the verdict.  Closed squares make the check slightly stronger than the claim's half-open squares
(the two differ only when an interval endpoint equals a band endpoint); a pass here is a pass there.

Checked over the torus's periodic images: a pair ``(p, p + Delta)`` for every coloured square ``p`` of one period
cell and every offset ``Delta`` in the band annulus (G68: the quotient carries every pair of the plane).

Also reported (diagnostics; not part of the verdict):
  * the uncovered density and each class's density, exactly (K-DENS: a band-proper class must be <= 0.2470);
  * the exact slack ``eps*``: the colouring is band-proper for ``[1 - e, 1 + e]`` iff ``e < eps*`` (closed band),
    where ``eps* = min`` over same-coloured offsets of ``max(1 - max_dist, min_dist - 1)``;
  * junctions (claims.md D-JUNC): connected components of the uncovered set (edge-adjacency = components of the
    interior; the corner-adjacency count is printed beside it), each with its *type*, the colours having a square
    within distance ``h`` of it; the least distance between two junctions of complementary type (disjoint
    three-element types, K-C6) and the equal-type junction pairs whose distance interval meets ``(1, 2)`` (K-KILL).

Usage:  fs107_w_check.py MEMBER.json [--json OUT.json]      exit 0 ACCEPT, 1 REJECT, 2 malformed input
        fs107_w_check.py --self-test                         plants and stubs (see ``self_test``)

Grade of what it computes: [tools], exact.  It certifies members; a family is a derivation (G21).
"""

from __future__ import annotations

import argparse
import json
import math
import sys
from fractions import Fraction
from itertools import combinations

import numpy as np

K_DENS = Fraction(2470, 10000)  # m1(R^2) <= 0.246989 < 0.2470 (claims.md K-DENS)


# ----------------------------------------------------------------------------------------------------------------
# The lattice: Hermite normal form and reduction to a canonical period cell [0, A) x [0, C).
# ----------------------------------------------------------------------------------------------------------------

def _egcd(a: int, b: int) -> tuple[int, int, int]:
    """Return (g, s, t) with s*a + t*b = g = gcd(a, b) >= 0."""
    if b == 0:
        return (abs(a), 1 if a >= 0 else -1, 0)
    g, s, t = _egcd(b, a % b)
    return (g, t, s - (a // b) * t)


class Torus:
    """The quotient Z^2 / Lambda in Hermite normal form: Lambda = Z(A, 0) + Z(B, C), 0 <= B < A, A*C = |det|."""

    def __init__(self, basis: list[list[int]]):
        (a, b), (c, d) = basis
        det = a * d - b * c
        if det == 0:
            raise ValueError("period basis is singular")
        g, s, t = _egcd(b, d)            # s*b + t*d = g = C, the y-projection's generator
        self.C = g
        self.A = abs(det) // g
        bx = s * a + t * c               # the vector s*v1 + t*v2 = (bx, C)
        self.B = bx % self.A
        self.det = abs(det)
        # sanity: both input vectors reduce to the origin
        for v in basis:
            if self.reduce(v[0], v[1]) != (0, 0):
                raise AssertionError("HNF construction failed")

    def reduce(self, i, j):
        """Canonical representative of (i, j) mod Lambda; works on ints or numpy int arrays."""
        y = np.floor_divide(j, self.C)
        jj = j - y * self.C
        ii = np.mod(i - y * self.B, self.A)
        if isinstance(ii, np.ndarray):
            return ii, jj
        return (int(ii), int(jj))

    def lift_offset(self, i, j):
        """(i, j) minus its canonical representative: an element of Lambda."""
        ci, cj = self.reduce(i, j)
        return (i - ci, j - cj)


# ----------------------------------------------------------------------------------------------------------------
# Loading a member.
# ----------------------------------------------------------------------------------------------------------------

class Member:
    def __init__(self, data: dict):
        self.name = data.get("name", "?")
        self.k = int(data["colours"])
        self.h = Fraction(data["h"])
        self.eps = Fraction(data["eps"])
        if not (self.h > 0 and 0 <= self.eps < 1):
            raise ValueError("need h > 0 and 0 <= eps < 1")
        self.torus = Torus(data["basis"])
        T = self.torus
        self.M = np.full((T.A, T.C), -1, dtype=np.int16)
        for (i, j, col) in data["cells"]:
            if not (0 <= col < self.k):
                raise ValueError(f"colour {col} out of range at cell {(i, j)}")
            ci, cj = T.reduce(int(i), int(j))
            if self.M[ci, cj] != -1:
                raise ValueError(f"cell {(i, j)} repeats a coloured coset (overlap at canonical {(ci, cj)})")
            self.M[ci, cj] = col
        self.data = data


# ----------------------------------------------------------------------------------------------------------------
# The exact band check.
# ----------------------------------------------------------------------------------------------------------------

def offset_interval_sq(dx: int, dy: int) -> tuple[int, int]:
    """Squared min and max distance, in grid units squared, between closed unit squares at index offset (dx, dy)."""
    gx, gy = max(abs(dx) - 1, 0), max(abs(dy) - 1, 0)
    return gx * gx + gy * gy, (abs(dx) + 1) ** 2 + (abs(dy) + 1) ** 2


def band_offsets(h: Fraction, eps: Fraction) -> list[tuple[int, int]]:
    """Every index offset whose closed-square distance interval meets the closed band [1 - eps, 1 + eps]."""
    hi2 = ((1 + eps) / h) ** 2
    lo2 = ((1 - eps) / h) ** 2
    R = int((1 + eps) / h) + 2
    out = []
    for dx in range(-R, R + 1):
        for dy in range(-R, R + 1):
            mn2, mx2 = offset_interval_sq(dx, dy)
            if mn2 <= hi2 and mx2 >= lo2:
                out.append((dx, dy))
    return out


def band_check(mem: Member, max_examples: int = 8):
    """Return (violations, examples): ordered same-coloured pairs (p, p + Delta), Delta in the band annulus."""
    T = mem.torus
    ii, jj = np.nonzero(mem.M >= 0)
    cols = mem.M[ii, jj]
    total = 0
    examples = []
    for (dx, dy) in band_offsets(mem.h, mem.eps):
        qi, qj = T.reduce(ii + dx, jj + dy)
        bad = mem.M[qi, qj] == cols
        n = int(bad.sum())
        if n:
            total += n
            for idx in np.nonzero(bad)[0][: max(0, max_examples - len(examples))]:
                p = (int(ii[idx]), int(jj[idx]))
                mn2, mx2 = offset_interval_sq(dx, dy)
                examples.append({"cell": p, "offset": (dx, dy), "colour": int(cols[idx]),
                                 "dist_interval": [float(mem.h) * math.sqrt(mn2), float(mem.h) * math.sqrt(mx2)]})
    return total, examples


def _cmp_margins(h: Fraction, a: tuple[str, int], b: tuple[str, int]) -> int:
    """Exact comparison of two margins, each ('in', n) = 1 - h*sqrt(n) or ('out', n) = h*sqrt(n) - 1.
    Returns -1, 0, 1 as a <, =, > b."""
    def key(m):  # value = s0 + s1*h*sqrt(n)
        return (1, -1) if m[0] == "in" else (-1, 1)
    (c0, c1), (d0, d1) = key(a), key(b)
    # a - b = (c0 - d0) + h*(c1*sqrt(na) - d1*sqrt(nb)); decide its sign exactly
    na, nb = a[1], b[1]
    const = Fraction(c0 - d0)
    # sign of const + h*c1*sqrt(na) - h*d1*sqrt(nb)
    def sign_lin(k0: Fraction, k1: Fraction, n1: int, k2: Fraction, n2: int) -> int:
        # sign of k0 + k1*sqrt(n1) + k2*sqrt(n2), exactly
        x = k1 * k1 * n1  # not used directly; do it by isolating and squaring
        vals = [(k1, n1), (k2, n2)]
        # move the radicals: S = k1 sqrt n1 + k2 sqrt n2; compare S with -k0
        def sgn_rad_sum() -> int:
            # sign of k1 sqrt n1 + k2 sqrt n2
            s1 = (k1 > 0) - (k1 < 0) if n1 else 0
            s2 = (k2 > 0) - (k2 < 0) if n2 else 0
            if s1 == 0:
                return s2
            if s2 == 0 or s1 == s2:
                return s1
            a2, b2 = k1 * k1 * n1, k2 * k2 * n2
            return s1 if a2 > b2 else (s2 if b2 > a2 else 0)
        s = sgn_rad_sum()
        target = -k0
        # compare S with target; S^2 = k1^2 n1 + k2^2 n2 + 2 k1 k2 sqrt(n1 n2)
        st = (target > 0) - (target < 0)
        if s != st:
            return (s > st) - (s < st)
        if s == 0:
            return 0
        # same sign: compare |S| with |target| by squares
        p = k1 * k1 * n1 + k2 * k2 * n2
        q = 2 * k1 * k2          # |S|^2 = p + q sqrt(n1 n2) (S has sign s)
        t2 = target * target
        # sign of (p - t2) + q sqrt(n1 n2)
        r0, r1, rn = p - t2, q, n1 * n2
        if r1 == 0 or rn == 0:
            d = (r0 > 0) - (r0 < 0)
        else:
            sr1 = (r1 > 0) - (r1 < 0)
            sr0 = (r0 > 0) - (r0 < 0)
            if sr0 == sr1 or sr0 == 0:
                d = sr1
            else:
                aa, bb = r0 * r0, r1 * r1 * rn
                d = sr0 if aa > bb else (sr1 if bb > aa else 0)
        # |S| vs |t|: d > 0 means |S| > |t|; S - t has sign s*d
        return s * d
    return sign_lin(const, h * c1, na, -h * d1, nb)


def exact_slack(mem: Member, window: Fraction = Fraction(1, 4)):
    """The exact eps* over same-coloured offsets whose interval lies within `window` of 1 (None if none there)."""
    T = mem.torus
    ii, jj = np.nonzero(mem.M >= 0)
    cols = mem.M[ii, jj]
    h = mem.h
    best = None
    R = int((1 + window) / h) + 2
    hi2, lo2 = ((1 + window) / h) ** 2, ((1 - window) / h) ** 2
    for dx in range(-R, R + 1):
        for dy in range(-R, R + 1):
            mn2, mx2 = offset_interval_sq(dx, dy)
            if not (mn2 <= hi2 and mx2 >= lo2):
                continue
            qi, qj = T.reduce(ii + dx, jj + dy)
            if not np.any(mem.M[qi, qj] == cols):
                continue
            # margin of this offset: max(1 - h sqrt(mx2), h sqrt(mn2) - 1)
            m_in, m_out = ("in", mx2), ("out", mn2)
            m = m_in if _cmp_margins(h, m_in, m_out) >= 0 else m_out
            if best is None or _cmp_margins(h, m, best[0]) < 0:
                best = (m, (dx, dy))
    return best


def margin_value(h: Fraction, m) -> float:
    kind, n = m
    return (1 - float(h) * math.sqrt(n)) if kind == "in" else (float(h) * math.sqrt(n) - 1)


# ----------------------------------------------------------------------------------------------------------------
# Junctions (claims.md D-JUNC).
# ----------------------------------------------------------------------------------------------------------------

def junctions(mem: Member):
    """Components of the uncovered squares in the plane, read on the torus.  Returns a dict of diagnostics."""
    T = mem.torus
    unc = mem.M < 0
    A, C = T.A, T.C
    comp = -np.ones((A, C), dtype=np.int64)
    lift = {}           # canonical cell -> its lift in the plane (bounded components only)
    wraps = []
    ncomp = 0
    nbrs4 = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    for (si, sj) in zip(*np.nonzero(unc)):
        si, sj = int(si), int(sj)
        if comp[si, sj] >= 0:
            continue
        cid = ncomp
        ncomp += 1
        wrap = False
        comp[si, sj] = cid
        lift[(si, sj)] = (si, sj)
        stack = [(si, sj)]
        while stack:
            ci, cj = stack.pop()
            li, lj = lift[(ci, cj)]
            for (dx, dy) in nbrs4:
                zi, zj = li + dx, lj + dy
                qi, qj = T.reduce(zi, zj)
                if not unc[qi, qj]:
                    continue
                if comp[qi, qj] < 0:
                    comp[qi, qj] = cid
                    lift[(qi, qj)] = (zi, zj)
                    stack.append((qi, qj))
                elif lift[(qi, qj)] != (zi, zj):
                    wrap = True
        wraps.append(wrap)
    # corner-adjacency count (closure components), for the record
    parent = list(range(ncomp))

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x
    for (ci, cj) in zip(*np.nonzero(unc)):
        for (dx, dy) in [(1, 1), (1, -1)]:
            qi, qj = T.reduce(int(ci) + dx, int(cj) + dy)
            if unc[qi, qj]:
                a, b = find(int(comp[ci, cj])), find(int(comp[qi, qj]))
                if a != b:
                    parent[a] = b
    ncomp8 = len({find(x) for x in range(ncomp)})
    # types: colours with a square within distance h (gap^2 <= 1 in grid units)
    near = [(dx, dy) for dx in range(-2, 3) for dy in range(-2, 3)
            if offset_interval_sq(dx, dy)[0] <= 1 and (dx, dy) != (0, 0)]
    types = [set() for _ in range(ncomp)]
    ui, uj = np.nonzero(unc)
    cid_arr = comp[ui, uj]
    for (dx, dy) in near:
        qi, qj = T.reduce(ui + dx, uj + dy)
        cc = mem.M[qi, qj]
        for c_id, col in zip(cid_arr[cc >= 0], cc[cc >= 0]):
            types[int(c_id)].add(int(col))
    type_hist = {}
    for t in types:
        key = "".join(str(c) for c in sorted(t)) or "-"
        type_hist[key] = type_hist.get(key, 0) + 1
    out = {"components_edge": ncomp, "components_corner": ncomp8, "wrapping": int(sum(wraps)),
           "type_histogram": dict(sorted(type_hist.items()))}
    # pair distances within 2: scan offsets with gap distance <= 2
    h = mem.h
    R2 = (2 / h) ** 2
    Rg = int(2 / h) + 2
    lifts_i = np.array([lift[(int(a), int(b))][0] for a, b in zip(ui, uj)])
    lifts_j = np.array([lift[(int(a), int(b))][1] for a, b in zip(ui, uj)])
    frozen = [frozenset(t) for t in types]
    comp_pairs = {}      # (cid, cid2, lam) -> [min gap2, max max2]
    for dx in range(-Rg, Rg + 1):
        for dy in range(-Rg, Rg + 1):
            mn2, mx2 = offset_interval_sq(dx, dy)
            if mn2 > R2:
                continue
            zi, zj = lifts_i + dx, lifts_j + dy
            qi, qj = T.reduce(zi, zj)
            hit = unc[qi, qj]
            if not np.any(hit):
                continue
            for idx in np.nonzero(hit)[0]:
                c1 = int(cid_arr[idx])
                q = (int(qi[idx]), int(qj[idx]))
                c2 = int(comp[q])
                if wraps[c1] or wraps[c2]:
                    continue
                lam = (int(zi[idx]) - lift[q][0], int(zj[idx]) - lift[q][1])
                if c2 == c1 and lam == (0, 0):
                    continue
                key = (c1, c2, lam)
                cur = comp_pairs.get(key)
                if cur is None:
                    comp_pairs[key] = [mn2, mx2]
                else:
                    cur[0] = min(cur[0], mn2)
                    cur[1] = max(cur[1], mx2)
    least_comp = None
    kill = 0
    least_kill = None
    for (c1, c2, lam), (mn2, mx2) in comp_pairs.items():
        t1, t2 = frozen[c1], frozen[c2]
        d = float(h) * math.sqrt(mn2)
        if len(t1) == 3 and len(t2) == 3 and not (t1 & t2):
            if least_comp is None or d < least_comp:
                least_comp = d
        if t1 == t2 and len(t1) >= 3:
            if mn2 < R2 and mx2 * h * h > 1:
                kill += 1
                if least_kill is None or d < least_kill:
                    least_kill = d
    out["least_dist_complementary_types"] = least_comp
    out["equal_type_pairs_meeting_(1,2)"] = kill // 1
    out["least_dist_equal_types_meeting_(1,2)"] = least_kill
    return out


# ----------------------------------------------------------------------------------------------------------------
# The report.
# ----------------------------------------------------------------------------------------------------------------

def check(mem: Member, with_junctions: bool = True, window: Fraction = Fraction(1, 4)) -> dict:
    T = mem.torus
    n = T.det
    coloured = int((mem.M >= 0).sum())
    unc = Fraction(n - coloured, n)
    dens = {c: Fraction(int((mem.M == c).sum()), n) for c in range(mem.k)}
    viol, ex = band_check(mem)
    slack = exact_slack(mem, window)
    rep = {
        "name": mem.name, "colours": mem.k, "h": str(mem.h), "eps": str(mem.eps),
        "period_cell": {"A": T.A, "B": T.B, "C": T.C, "squares": n},
        "square_period_L_grid_units": T.det,  # Lambda contains det*Z^2
        "band_offsets_checked": len(band_offsets(mem.h, mem.eps)),
        "ordered_pairs_checked": coloured * len(band_offsets(mem.h, mem.eps)),
        "violations": viol, "violation_examples": ex,
        "verdict": "ACCEPT" if viol == 0 else "REJECT",
        "uncovered_density": str(unc), "uncovered_density_float": float(unc),
        "class_densities": {str(c): str(d) for c, d in dens.items()},
        "max_class_density_float": float(max(dens.values())),
        "K_DENS_ok": all(d <= K_DENS for d in dens.values()),
        "floor_eps2_over_(6+eps)^2": float(mem.eps ** 2 / (6 + mem.eps) ** 2),
    }
    if slack is None:
        rep["exact_slack"] = f">= {window} (no same-coloured offset within {window} of the unit distance)"
    else:
        m, off = slack
        rep["exact_slack"] = {"expr": ("1 - h*sqrt(%d)" if m[0] == "in" else "h*sqrt(%d) - 1") % m[1],
                              "value": margin_value(mem.h, m), "offset": off}
        rep["least_margin_to_band"] = margin_value(mem.h, m) - float(mem.eps)
    if with_junctions:
        rep["junctions"] = junctions(mem)
    return rep


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("member", nargs="?")
    ap.add_argument("--json")
    ap.add_argument("--no-junctions", action="store_true")
    ap.add_argument("--window", default="1/4", help="report the exact slack only within this distance of 1")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args(argv)
    if a.self_test:
        return self_test()
    if not a.member:
        ap.error("a member file or --self-test")
    try:
        with open(a.member) as f:
            mem = Member(json.load(f))
    except (ValueError, KeyError, AssertionError) as e:
        print(f"MALFORMED: {e}", file=sys.stderr)
        return 2
    rep = check(mem, with_junctions=not a.no_junctions, window=Fraction(a.window))
    print(json.dumps(rep, indent=1, default=str))
    if a.json:
        with open(a.json, "w") as f:
            json.dump(rep, f, indent=1, default=str)
    return 0 if rep["verdict"] == "ACCEPT" else 1


# ----------------------------------------------------------------------------------------------------------------
# Self-test: the known positive, a planted pair that must fire for its own reason beside a faithful stub that must
# pass, a near-miss plant that must not fire, an exact band-edge plant, and an overlap plant.
# ----------------------------------------------------------------------------------------------------------------

def self_test() -> int:
    sys.path.insert(0, __file__.rsplit("/", 1)[0])
    from fs107_w_members import hex_seven_minus_one  # noqa: E402

    fails = []

    def expect(cond, msg):
        print(("  ok   " if cond else "  FAIL ") + msg)
        if not cond:
            fails.append(msg)

    print("[1] known positive: slack hexagonal seven-colouring, one class uncovered, rasterised (h = 1/40, eps = 1/20)")
    data = hex_seven_minus_one()
    mem = Member(data)
    rep = check(mem, with_junctions=True)
    expect(rep["verdict"] == "ACCEPT", f"faithful stub ACCEPTED (violations = {rep['violations']})")
    expect(rep["uncovered_density"] == "1/7", f"uncovered density exactly 1/7 (got {rep['uncovered_density']})")
    expect(all(v == "1/7" for v in rep["class_densities"].values()), "every class density exactly 1/7")
    expect(rep["K_DENS_ok"], "K-DENS holds (1/7 <= 0.2470)")
    slack = rep["exact_slack"]["value"]
    expect(slack > float(mem.eps), f"exact slack {slack:.5f} exceeds the claimed eps = {float(mem.eps)}")
    base_viol = rep["violations"]

    print("[2] planted monochromatic pair: recolour one uncovered square to the colour of a square one unit away")
    T = mem.torus
    # find a coloured square p and an uncovered square q with offset in the band, set q to p's colour
    offs = band_offsets(mem.h, mem.eps)
    target = None
    for (pi, pj) in zip(*np.nonzero(mem.M >= 0)):
        for (dx, dy) in offs:
            q = T.reduce(int(pi) + dx, int(pj) + dy)
            if mem.M[q] < 0 and abs(dx) == max(abs(dx), abs(dy)) and dy == 0:
                target = ((int(pi), int(pj)), q, int(mem.M[pi, pj]), (dx, dy))
                break
        if target:
            break
    expect(target is not None, "a plant site exists")
    p, q, col, off = target
    planted = dict(data)
    planted["cells"] = data["cells"] + [[q[0], q[1], col]]
    pm = Member(planted)
    prep = check(pm, with_junctions=False)
    expect(prep["verdict"] == "REJECT", f"planted member REJECTED (violations = {prep['violations']})")
    # fires for its own reason: every violation involves the planted square q (as p or as p + Delta)
    ii, jj = np.nonzero(pm.M >= 0)
    own = True
    count = 0
    for (dx, dy) in band_offsets(pm.h, pm.eps):
        qi, qj = T.reduce(ii + dx, jj + dy)
        bad = np.nonzero(pm.M[qi, qj] == pm.M[ii, jj])[0]
        for idx in bad:
            count += 1
            a = (int(ii[idx]), int(jj[idx]))
            b = (int(qi[idx]), int(qj[idx]))
            if a != q and b != q:
                own = False
    expect(own, "every violation involves the planted square")
    upper = 2 * len(offs)
    expect(0 < prep["violations"] - base_viol <= upper,
           f"two-sided bound: 0 < {prep['violations'] - base_viol} <= {upper} (2 x band offsets)")

    print("[3] near miss; and a pinned diagnostic of the hex member's holes")
    # (a) diagnostic, not an assertion: how many colours each uncovered square of the hex member sees in its band.
    #     (A hypothesis that all see six was refuted here, 2026-09-27: at h = 1/40, eps = 1/20 the counts are
    #     486 see six, 339 see five, 12 see four, of 837.)  Asserted only as that exact histogram, a regression pin.
    ui0, uj0 = np.nonzero(mem.M < 0)
    seen = np.zeros((len(ui0), mem.k), dtype=bool)
    for (dx, dy) in offs:
        qi0, qj0 = T.reduce(ui0 + dx, uj0 + dy)
        cc0 = mem.M[qi0, qj0]
        for kk in range(mem.k):
            seen[:, kk] |= cc0 == kk
    hist = {int(k): int((seen.sum(1) == k).sum()) for k in range(mem.k + 1) if (seen.sum(1) == k).any()}
    expect(hist == {4: 12, 5: 339, 6: 486}, f"hole-square colour-sight histogram pinned: {hist}")
    # (b) synthetic pair at the UPPER band edge: h = 1/10, eps = 1/10; gap 12 squares = 1.2 > 1.1 passes,
    #     gap 11 squares = 1.1 = 1 + eps exactly is a violation (closed band)
    far = {"name": "near-miss", "colours": 2, "h": "1/10", "eps": "1/10", "basis": [[60, 0], [0, 60]],
           "cells": [[0, 0, 0], [13, 0, 0]]}
    expect(check(Member(far), with_junctions=False)["verdict"] == "ACCEPT",
           "same colour at min distance 1.2 > 1 + eps: ACCEPTED (the refusal in [2] came from the band)")
    at = dict(far)
    at["cells"] = [[0, 0, 0], [12, 0, 0]]
    expect(check(Member(at), with_junctions=False)["verdict"] == "REJECT",
           "same colour at min distance exactly 1 + eps: REJECTED (closed band)")

    print("[4] exact band edge: h = 1/10, eps = 1/2, same colour at offset (2, 3): max distance is exactly 1 - eps")
    edge = {"name": "edge", "colours": 2, "h": "1/10", "eps": "1/2", "basis": [[50, 0], [0, 50]],
            "cells": [[0, 0, 0], [2, 3, 0]]}
    erep = check(Member(edge), with_junctions=False)
    expect(erep["verdict"] == "REJECT", "closed band: max distance = 1 - eps exactly is a violation")
    edge2 = dict(edge)
    edge2["cells"] = [[0, 0, 0], [1, 3, 0]]   # max^2 = (2^2 + 4^2)/100 = 1/5 < 1/4
    e2 = check(Member(edge2), with_junctions=False)
    expect(e2["verdict"] == "ACCEPT", "one square nearer: max distance < 1 - eps, accepted")
    es = exact_slack(Member(edge2), window=Fraction(1))
    expect(es is not None and es[0] == ("in", 20), f"exact slack at window 1 is 1 - h*sqrt(20) (got {es})")

    print("[5] overlap: a second colour on an already coloured coset is malformed")
    bad = dict(data)
    c0 = data["cells"][0]
    bad["cells"] = data["cells"] + [[c0[0] + data["basis"][0][0], c0[1] + data["basis"][0][1], (c0[2] + 1) % 6]]
    try:
        Member(bad)
        expect(False, "overlap refused")
    except ValueError:
        expect(True, "overlap refused")

    print("[6] exact comparison of margins: 1 - h sqrt(a) against h sqrt(b) - 1")
    h = Fraction(1, 10)
    expect(_cmp_margins(h, ("in", 81), ("out", 121)) == 0, "1 - 0.9 = 1.1 - 1 exactly (equal margins)")
    expect(_cmp_margins(h, ("in", 80), ("out", 121)) > 0, "1 - sqrt(0.80) > 0.1")
    expect(_cmp_margins(h, ("out", 122), ("in", 81)) > 0, "sqrt(1.22) - 1 > 0.1")

    print("SELF-TEST", "PASSED" if not fails else f"FAILED ({len(fails)})")
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main())
