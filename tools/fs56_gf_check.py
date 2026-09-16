#!/usr/bin/env python3
"""fs56_gf_check -- check a geometric fractional chromatic number certificate for a finite point set H in the plane over a
real multiquadratic field F = Q(sqrt d_1, ..., sqrt d_r).  Standard library only; every quantity is an exact integer.

WHAT A CERTIFICATE PROVES.  A certificate lists H (exact coordinates) and rational weights y_Y on point sets Y of H with
1 <= |Y| <= k.  The checker verifies
  (i)   on every congruence class of listed sets of two or more points, the weights sum to 0;
  (ii)  on the singletons they sum to w;
  (iii) every independent set S of H (no two points at distance 1) has  sum_{listed Y inside S} y_Y <= 1.
Then every fractional colouring gamma of H whose aggregate gamma_bar(Y) = sum_{S >= Y} gamma(S) is constant on congruence classes
of sets of at most k points, with value 1 on points, weighs  sum gamma(S) >= sum_S gamma(S) sum_{Y in S} y_Y
= sum_Y y_Y gamma_bar(Y) = w.  So  chi_gf(H; k) >= w,  and by the field blow-up (plans/FS56-field-blowup.md, Lemma B2: the
Matolcsi-Ruzsa-Varga-Zsamboki blow-up never leaves F) the plane over F needs at least ceil(w) colours.

HOW.  Coordinates are integer numerators over one common denominator N, in the basis sqrt(prod_{j in S} d_j), S a bitmask; the
radicands must be squarefree, pairwise coprime and > 1, so that basis is Q-independent and vector equality is field equality.
Adjacency is recomputed from  dx^2 + dy^2 = 1.  Congruence is decided without square roots: sets with equal sorted multisets of
pairwise quadrances are compared by an exact isometry test -- for some ordered pair (a, b) of Y' at the quadrance of (y1, y2),
every z in Y has a partner z' in Y' with (z' - a)(y2 - y1) = (z - y1)(b - a)  (rotation) or  (z' - a) conj(y2 - y1) =
conj(z - y1)(b - a)  (reflection), products taken in F(i).  Only "grouped together => congruent" is load-bearing: grouping
congruent sets apart removes constraints and can only lower the value certified.  (iii) is decided by exhaustive depth-first
enumeration of independent sets in index order, pruning a subtree when the value so far plus every positive weight still
reachable cannot exceed 1.

USAGE
  python3 tools/fs56_gf_check.py CERT.json [--show-points]     exit 0 CERTIFIED, 1 NOT A CERTIFICATE, 2 unreadable
  python3 tools/fs56_gf_check.py --self-test                   arithmetic, grouping and enumeration controls
"""

from __future__ import annotations

import itertools
import json
import math
import random
import sys
import time
from fractions import Fraction


class Refusal(Exception):
    """a well-formed file that is not a certificate"""


class Unreadable(Exception):
    """a file that cannot be read as a certificate at all"""


# ------------------------------------------------------------------------------------------------------------ the field
class Field:
    """Q(sqrt d_1, ..., sqrt d_r), elements as tuples of 2^r integers (numerators; the scale is the caller's)."""

    def __init__(self, radicands):
        rad = list(radicands)
        for d in rad:
            if not isinstance(d, int) or d <= 1:
                raise Refusal(f"radicand {d!r} is not an integer greater than 1")
            if any(d % (p * p) == 0 for p in range(2, math.isqrt(d) + 1)):
                raise Refusal(f"radicand {d} is not squarefree")
        for a, b in itertools.combinations(rad, 2):
            if math.gcd(a, b) != 1:
                raise Refusal(f"radicands {a} and {b} are not coprime")
        self.rad = rad
        self.B = 1 << len(rad)
        # table[ma][mb] = (mask, integer factor) for basis(ma) * basis(mb)
        self.table = [[(ma ^ mb, math.prod(rad[j] for j in range(len(rad)) if (ma & mb) >> j & 1)) for mb in range(self.B)]
                      for ma in range(self.B)]

    def zero(self):
        return (0,) * self.B

    def add(self, a, b):
        return tuple(x + y for x, y in zip(a, b))

    def sub(self, a, b):
        return tuple(x - y for x, y in zip(a, b))

    def neg(self, a):
        return tuple(-x for x in a)

    def mul(self, a, b):
        out = [0] * self.B
        for ma, ca in enumerate(a):
            if ca:
                row = self.table[ma]
                for mb, cb in enumerate(b):
                    if cb:
                        m, f = row[mb]
                        out[m] += ca * cb * f
        return tuple(out)

    def name(self):
        return "Q(" + ", ".join(f"√{d}" for d in self.rad) + ")"

    def show(self, a, den):
        parts = []
        for m, c in enumerate(a):
            if c:
                root = "" if m == 0 else "√" + str(math.prod(self.rad[j] for j in range(len(self.rad)) if m >> j & 1))
                parts.append(f"{Fraction(c, den)}{root}")
        return " + ".join(parts) if parts else "0"


class Plane:
    """points of F^2 over one denominator N, read as complex numbers x + iy with x, y in F."""

    def __init__(self, F: Field, N: int, points):
        self.F, self.N, self.pts = F, N, points
        n = len(points)
        self.unit = F.add((N * N,) + (0,) * (F.B - 1), F.zero())
        self.quad = {}
        self.adj = [0] * n
        for i in range(n):
            for j in range(i + 1, n):
                q = self.quadrance(points[i], points[j])
                self.quad[(i, j)] = q
                if q == self.unit:
                    self.adj[i] |= 1 << j
                    self.adj[j] |= 1 << i

    def quadrance(self, p, q):
        F = self.F
        dx, dy = F.sub(p[0], q[0]), F.sub(p[1], q[1])
        return F.add(F.mul(dx, dx), F.mul(dy, dy))

    def q(self, i, j):
        return self.quad[(i, j) if i < j else (j, i)]

    # complex arithmetic on differences (scale N), products at scale N^2
    def diff(self, i, j):
        F = self.F
        return (F.sub(self.pts[i][0], self.pts[j][0]), F.sub(self.pts[i][1], self.pts[j][1]))

    def cmul(self, u, v):
        F = self.F
        return (F.sub(F.mul(u[0], v[0]), F.mul(u[1], v[1])), F.add(F.mul(u[0], v[1]), F.mul(u[1], v[0])))

    @staticmethod
    def conj(u):
        return (u[0], tuple(-x for x in u[1]))

    def congruent(self, Y, Z):
        """exact: is there an isometry of the plane carrying the point set Y onto Z?  (|Y| = |Z| >= 2)"""
        y1, y2 = Y[0], Y[1]
        q12 = self.q(y1, y2)
        d12 = self.diff(y2, y1)
        d12c = self.conj(d12)
        for a, b in itertools.permutations(Z, 2):
            if self.q(a, b) != q12:
                continue
            dab = self.diff(b, a)
            for reflect in (False, True):
                ok = True
                for z in Y:
                    dz = self.diff(z, y1)
                    rhs = self.cmul(self.conj(dz) if reflect else dz, dab)
                    if not any(self.cmul(self.diff(zp, a), d12c if reflect else d12) == rhs for zp in Z):
                        ok = False
                        break
                if ok:
                    return True
        return False


# -------------------------------------------------------------------------------------------------------- the checking
def group_classes(P: Plane, sets):
    """partition the listed sets of size >= 2 into classes of congruent sets; returns a list of lists of set indices"""
    buckets = {}
    for t, Y in enumerate(sets):
        if len(Y) < 2:
            continue
        key = (len(Y), tuple(sorted(P.q(a, b) for a, b in itertools.combinations(Y, 2))))
        buckets.setdefault(key, []).append(t)
    classes = []
    for members in buckets.values():
        reps = []  # (representative set index, class list)
        for t in members:
            for r, cls in reps:
                if P.congruent(sets[r], sets[t]):
                    cls.append(t)
                    break
            else:
                cls = [t]
                reps.append((t, cls))
                classes.append(cls)
    return classes


def independent(P: Plane, Y):
    m = 0
    for v in Y:
        if P.adj[v] & m:
            return False
        m |= 1 << v
    return True


def max_over_independent_sets(P: Plane, weighted, threshold=None):
    """weighted: list of (bitmask, integer weight) over independent listed sets.  Depth-first over independent sets in index
    order.  With threshold T: return (False, S, value) at the first S with value > T, else (True, None, None) -- subtrees pruned
    when value + reachable positive weight <= T.  Without: return (True, S*, max) exactly (pruned against the best found)."""
    n = len(P.pts)
    bucket = [{} for _ in range(n)]  # by highest vertex: {mask: weight}
    for mask, y in weighted:
        top = mask.bit_length() - 1
        bucket[top][mask] = bucket[top].get(mask, 0) + y
    pos_tail = [0] * (n + 1)
    for v in range(n - 1, -1, -1):
        pos_tail[v] = pos_tail[v + 1] + sum(y for y in bucket[v].values() if y > 0)

    def gain(v, J):
        # sum of the weights of listed sets with highest vertex v inside J: by submasks of J below v when that is cheaper
        b = bucket[v]
        rest = J & ((1 << v) - 1)
        if (1 << bin(rest).count("1")) <= len(b):
            bit, total, m = 1 << v, b.get(1 << v, 0), rest
            while m:
                total += b.get(m | bit, 0)
                m = (m - 1) & rest
            return total
        return sum(y for mask, y in b.items() if mask & J == mask)
    best = [0, 0]  # value, set  (the empty set weighs 0)
    adj = P.adj
    stack = [(0, 0, 0, 0)]  # (I, forbidden, next vertex, value)
    visited = 0
    while stack:
        I, forb, p, val = stack.pop()
        visited += 1
        if threshold is not None:
            if val > threshold:
                return False, I, val, visited
            if val + pos_tail[p] <= threshold:
                continue
        else:
            if val > best[0]:
                best = [val, I]
            if val + pos_tail[p] <= best[0]:
                continue
        for v in range(n - 1, p - 1, -1):
            if forb >> v & 1:
                continue
            J = I | (1 << v)
            nv = val + gain(v, J)
            stack.append((J, forb | adj[v], v + 1, nv))
    if threshold is not None:
        return True, None, None, visited
    return True, best[1], best[0], visited


def approx(q):
    """a rational as the reader needs it: exact when short, else '≈ decimal' with the exact value's size"""
    q = Fraction(q)
    text = str(q)
    return text if len(text) <= 24 else f"≈ {float(q):.9g} (exact: {len(str(q.numerator))}-digit numerator)"


def bits(mask):
    return [v for v in range(mask.bit_length()) if mask >> v & 1]


def check(cert, log=print, show_points=False):
    t0 = time.time()
    try:
        F = Field(cert["field"]["radicands"])
        N = int(cert["denominator"])
        k = int(cert["level"])
        raw_pts = cert["points"]
        w_file = Fraction(cert["w"])
        raw_w = cert["weights"]
    except (KeyError, TypeError, ValueError) as e:
        raise Unreadable(f"missing or malformed field: {e!r}")
    if N <= 0 or k <= 0:
        raise Refusal("the denominator and the level must be positive")
    pts = []
    for t, pt in enumerate(raw_pts):
        if len(pt) != 2 or any(len(c) != F.B for c in pt):
            raise Unreadable(f"point {t} is not a pair of {F.B}-component vectors")
        pts.append((tuple(int(c) for c in pt[0]), tuple(int(c) for c in pt[1])))
    if len(set(pts)) != len(pts):
        seen = {}
        for t, pt in enumerate(pts):
            if pt in seen:
                raise Refusal(f"point {t} duplicates point {seen[pt]}")
            seen[pt] = t
    n = len(pts)
    if n > 62:
        log(f"note: {n} points; the enumeration of independent sets is exponential and may be slow")
    P = Plane(F, N, pts)
    edges = sum(bin(a).count("1") for a in P.adj) // 2
    if show_points:
        for t, (x, y) in enumerate(pts):
            log(f"  point {t}: ({F.show(x, N)}, {F.show(y, N)})")
    sets, ys = [], []
    seen_sets = {}
    for t, entry in enumerate(raw_w):
        Y = entry["set"]
        if not Y or any((not isinstance(v, int)) or v < 0 or v >= n for v in Y):
            raise Refusal(f"set #{t} {Y} names a point outside H (indices 0..{n - 1}) or is empty")
        if len(set(Y)) != len(Y):
            raise Refusal(f"set #{t} {Y} repeats a point")
        if len(Y) > k:
            raise Refusal(f"set #{t} has {len(Y)} points but the file declares level {k}")
        key = tuple(sorted(Y))
        if key in seen_sets:
            raise Refusal(f"set #{t} {list(key)} is listed twice (also #{seen_sets[key]})")
        seen_sets[key] = t
        sets.append(key)
        ys.append(Fraction(entry["y"]))
    log(f"[check] H: {n} points of {F.name()}^2 over denominator {N}, {edges} unit edges; level {k}; {len(sets)} weighted sets")

    # (ii)
    w = sum((y for Y, y in zip(sets, ys) if len(Y) == 1), Fraction(0))
    if w != w_file:
        raise Refusal(f"the singletons sum to {approx(w)} but the file claims w = {approx(w_file)}")
    # (i)
    classes = group_classes(P, sets)
    for cls in classes:
        s = sum((ys[t] for t in cls), Fraction(0))
        if s != 0:
            listed = ", ".join(f"#{t}" for t in cls[:6]) + (", …" if len(cls) > 6 else "")
            raise Refusal(f"the congruence class of set #{cls[0]} {list(sets[cls[0]])} ({len(cls)} listed sets: {listed}) "
                          f"sums to {approx(s)}; a class of sets of two or more points must sum to 0")
    log(f"[check] (i) {len(classes)} congruence classes of sets with two or more points, each summing to 0; "
        f"(ii) the singletons sum to w = {w} (≈ {float(w):.6f})  [{time.time() - t0:.1f} s]")
    # (iii) on a common integer scale
    D = 1
    for y in ys:
        D = D * y.denominator // math.gcd(D, y.denominator)
    weighted = [(sum(1 << v for v in Y), int(y * D)) for Y, y in zip(sets, ys) if independent(P, Y) and y != 0]
    ok, S, val, visited = max_over_independent_sets(P, weighted, threshold=D)
    if not ok:
        members = bits(S)
        contrib = sorted(((Fraction(y, D), bits(mask)) for mask, y in weighted if mask & S == mask), key=lambda c: -c[0])
        top = ", ".join(f"{Y} {'+' if c > 0 else ''}{approx(c)}" for c, Y in contrib[:4])
        raise Refusal(f"independent set {members} weighs {approx(Fraction(val, D))} > 1 (largest contributions: {top}, …)")
    log(f"[check] (iii) every independent set weighs at most 1 ({visited} nodes of the enumeration visited)  "
        f"[{time.time() - t0:.1f} s]")
    return F, n, k, w, time.time() - t0


def verdict_lines(F, n, k, w, seconds):
    c = math.ceil(w)
    return [f"CERTIFIED: H = {n} points of {F.name()}², level {k} — every fractional colouring of H whose weight on each point "
            f"set of at most {k} points depends only on the set's congruence class weighs at least w = {w} (≈ {float(w):.6f}); "
            f"exact arithmetic, no solver trusted ({seconds:.0f} s)",
            f"hence, by the field blow-up (plans/FS56-field-blowup.md, Lemma B2), the plane over {F.name()} needs at least {c} colours"]


# ------------------------------------------------------------------------------------------------------------ self-test
def moser_spindle_certificate():
    """the Moser spindle in Q(sqrt3, sqrt11)^2 over denominator 12, with y = 1/2 on every point: its independence number is 2"""
    # basis order for radicands [3, 11]: 1, √3, √11, √33
    w1 = ((6, 0, 0, 0), (0, 6, 0, 0))        # (1/2, √3/2)
    w3 = ((10, 0, 0, 0), (0, 0, 2, 0))       # (5/6, √11/6)
    w13 = ((5, 0, 0, -1), (0, 5, 1, 0))      # ((5 − √33)/12, (5√3 + √11)/12)
    one = ((12, 0, 0, 0), (0, 0, 0, 0))
    zero = ((0, 0, 0, 0), (0, 0, 0, 0))
    add = lambda p, q: (tuple(a + b for a, b in zip(p[0], q[0])), tuple(a + b for a, b in zip(p[1], q[1])))
    pts = [zero, one, w1, w3, w13, add(one, w1), add(w3, w13)]
    return {"kind": "fs56-gf-certificate", "field": {"radicands": [3, 11]}, "denominator": 12, "level": 1,
            "points": [[list(x), list(y)] for x, y in pts], "w": "7/2",
            "weights": [{"set": [v], "y": "1/2"} for v in range(7)]}


def self_test():
    failures = []

    def expect(name, cond):
        print(f"[self-test] {'ok ' if cond else 'BAD'} {name}")
        if not cond:
            failures.append(name)

    F = Field([3, 11])
    r3, r11 = (0, 1, 0, 0), (0, 0, 1, 0)
    r33 = F.mul(r3, r11)
    expect("√3·√11 = √33", r33 == (0, 0, 0, 1))
    expect("(√33)² = 33", F.mul(r33, r33) == (33, 0, 0, 0))
    for bad in ([12], [6, 10], [1]):
        try:
            Field(bad)
            expect(f"radicands {bad} refused", False)
        except Refusal:
            expect(f"radicands {bad} refused", True)
    # the spindle: 11 unit edges, and the certificate passes at w = 7/2
    cert = moser_spindle_certificate()
    lines = []
    Fs, n, k, w, sec = check(cert, log=lines.append)
    P = Plane(Field([3, 11]), 12, [(tuple(x), tuple(y)) for x, y in cert["points"]])
    expect("the Moser spindle has 11 unit edges", sum(bin(a).count("1") for a in P.adj) // 2 == 11)
    expect("the spindle certificate is accepted at w = 7/2", w == Fraction(7, 2))
    expect("the verdict claims 4 colours for w = 7/2", verdict_lines(Fs, n, k, w, sec)[1].endswith("at least 4 colours"))
    expect("the verdict claims only 3 colours for w = 3", verdict_lines(Fs, n, k, Fraction(3), sec)[1].endswith("at least 3 colours"))
    # a raised weight must be refused, naming an independent pair
    bad = json.loads(json.dumps(cert))
    bad["weights"][0]["y"] = "3/5"
    bad["w"] = "18/5"
    try:
        check(bad, log=lambda *_: None)
        expect("a raised spindle weight is refused", False)
    except Refusal as e:
        expect("a raised spindle weight is refused, naming an independent set", "independent set [0," in str(e))
    # homometric pair on a line: {0,1,4,10,12,17} and {0,1,8,11,13,17} share the multiset of distances, are not congruent
    A, B = [0, 1, 4, 10, 12, 17], [0, 1, 8, 11, 13, 17]
    pts = [((a, 0, 0, 0), (0, 0, 0, 0)) for a in A] + [((b, 0, 0, 0), (1, 0, 0, 0)) for b in B]  # second copy moved up by 1
    PH = Plane(F, 1, pts)
    YA, YB = tuple(range(6)), tuple(range(6, 12))
    same_multiset = sorted(PH.q(a, b) for a, b in itertools.combinations(YA, 2)) == \
        sorted(PH.q(a, b) for a, b in itertools.combinations(YB, 2))
    expect("the homometric pair has equal distance multisets", same_multiset)
    expect("the homometric pair is NOT grouped as congruent", not PH.congruent(YA, YB))
    YR = [((17 - a, 0, 0, 0), (0, 0, 0, 0)) for a in A]
    PR = Plane(F, 1, pts[:6] + YR)
    expect("a set and its mirror image are congruent", PR.congruent(tuple(range(6)), tuple(range(6, 12))))
    # inside the spindle: points 0, 1, w1, w3, w1w3, 1 + w1, w3 + w1w3 (indices 0..6)
    Pw = Plane(Field([3, 11]), 12, [(tuple(x), tuple(y)) for x, y in cert["points"]])
    expect("two unit triangles {0, 1, w1} and {1, 1+w1, w1} are congruent", Pw.congruent((0, 1, 2), (1, 5, 2)))
    expect("{0, 1, w1} and {0, 1, 1+w1} (a side of √3) are not", not Pw.congruent((0, 1, 2), (0, 1, 5)))
    expect("the rhombus {0, 1, w1, 1+w1} and its rotation by w3 {0, w3, w1w3, w3+w1w3} are congruent (√33 arithmetic)",
           Pw.congruent((0, 1, 2, 5), (0, 3, 4, 6)))
    # enumeration with pruning equals brute force on random graphs with random weights
    rng = random.Random(20260916)
    agree = True
    for trial in range(60):
        n = rng.randint(1, 11)
        Q = Plane(Field([2]), 1, [((t, 0), (0, 0)) for t in range(n)])  # points on a line; replace adjacency at random
        Q.adj = [0] * n
        for i, j in itertools.combinations(range(n), 2):
            if rng.random() < 0.3:
                Q.adj[i] |= 1 << j
                Q.adj[j] |= 1 << i
        weighted = []
        for _ in range(rng.randint(0, 25)):
            Y = rng.sample(range(n), rng.randint(1, min(3, n)))
            if independent(Q, Y):
                weighted.append((sum(1 << v for v in Y), rng.randint(-5, 5)))
        brute = 0
        for r in range(n + 1):
            for S in itertools.combinations(range(n), r):
                if independent(Q, S):
                    m = sum(1 << v for v in S)
                    brute = max(brute, sum(y for mask, y in weighted if mask & m == mask))
        _, _, best, _ = max_over_independent_sets(Q, weighted)
        T = rng.randint(-2, 6)
        ok, _, _, _ = max_over_independent_sets(Q, weighted, threshold=T)
        agree &= best == brute and ok == (brute <= T)
    expect("pruned enumeration equals brute force on 60 random weighted graphs (max and threshold)", agree)
    print(f"[self-test] {'ALL PASSED' if not failures else 'FAILED: ' + '; '.join(failures)}")
    return 0 if not failures else 1


def main(argv):
    if "--self-test" in argv:
        return self_test()
    args = [a for a in argv if not a.startswith("--")]
    if len(args) != 1:
        print(__doc__)
        return 2
    try:
        cert = json.loads(open(args[0]).read())
    except (OSError, json.JSONDecodeError) as e:
        print(f"UNREADABLE: {e}")
        return 2
    try:
        F, n, k, w, sec = check(cert, show_points="--show-points" in argv)
    except Unreadable as e:
        print(f"UNREADABLE: {e}")
        return 2
    except Refusal as e:
        print(f"NOT A CERTIFICATE: {e}")
        return 1
    for line in verdict_lines(F, n, k, w, sec):
        print(line)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
