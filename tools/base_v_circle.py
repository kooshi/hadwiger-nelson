#!/usr/bin/env python3
"""BASE-V: exact checks of the derived circle-colouring claims (Lemma 5, Prop. 18, the < 9 branch).

Job BASE-V (blind verifier, 2026-09-27), record `plans/BASE-V-verification.md`.

A *circle colouring* is a finite list of arcs on the unit circle, each with a colour in {1, 2, 3},
adjacent arcs of different colours (the definition of `[SokolovVoronov2025]` §7.1).  Angles are exact
`Fraction`s in DEGREES; two points of the unit circle are at distance exactly 1 iff their angular
separation is exactly 60 degrees, and at distance > 1 iff it lies in (60, 300).

"Proper" (the print's two conditions):
  (i)  no two monochromatic (interior) points at distance 1 share a colour;
  (ii) no two bichromatic points (arc endpoints) at distance 1 share a pair of colours.

The derived claims checked here, on colourings GIVEN BY FORMULA (never generated or searched):
  H1  the height lift h (steps +-1 mod 3) has winding W != 0, and D(x) = h(x+60) - h(x) stays in one band
      {3k+1, 3k+2} at every generic x (k >= 0 once W > 0), with W/6 in [3k+1, 3k+2];
  H2  the running-maximum recolouring h'(x) = max_{y <= x} h(y) is proper and cyclic, its bichromatic
      points are a subset of the old ones, and each kept point keeps its pair of colours;
  H3  (Prop. 18) a cyclic proper colouring with 3m >= 9 bichromatic points: for each pair, the points
      P_j, P_{j+k+1}, P_{j+2k+2} (every third boundary, index gaps k+1) are pairwise > 1 apart;
  H4  (the < 9 branch) a cyclic proper colouring with < 9 bichromatic points has exactly 6, at exact 60-degree
      spacing (D == 1).

Run: `python3 tools/base_v_circle.py` (seconds).  `--plant N` runs planted fault N and must FAIL for its
own reason (see PLANTS).
"""
from __future__ import annotations

import sys
from fractions import Fraction as F

FULL = F(360)
SIX = F(60)


def norm(a: F) -> F:
    a = a % FULL
    return a


class Colouring:
    """Arcs (starts[i], starts[i+1]) with colour cols[i]; starts strictly increasing in [0, 360)."""

    def __init__(self, starts, cols):
        starts = [F(s) for s in starts]
        assert len(starts) == len(cols) >= 1
        assert all(0 <= s < FULL for s in starts)
        assert all(starts[i] < starts[i + 1] for i in range(len(starts) - 1)), "starts must increase"
        assert all(c in (1, 2, 3) for c in cols)
        n = len(cols)
        if n > 1:
            assert all(cols[i] != cols[(i + 1) % n] for i in range(n)), "adjacent arcs must differ"
        self.starts = starts
        self.cols = list(cols)

    @property
    def n(self) -> int:
        return len(self.cols)

    def arc(self, i):
        a = self.starts[i]
        b = self.starts[(i + 1) % self.n] if self.n > 1 else a + FULL
        if b <= a:
            b += FULL
        return a, b

    def colour_at(self, x: F) -> int:
        """Colour of a GENERIC point x (must not be a boundary)."""
        x = norm(x)
        assert x not in self.starts or self.n == 1, f"{x} is a boundary"
        for i in range(self.n):
            a, b = self.arc(i)
            for xx in (x, x + FULL):
                if a < xx < b:
                    return self.cols[i]
        raise AssertionError("uncovered")

    def boundaries(self):
        """(angle, left colour, right colour) going counterclockwise."""
        if self.n == 1:
            return []
        return [(self.starts[i], self.cols[i - 1], self.cols[i]) for i in range(self.n)]


def pair(c1, c2):
    return frozenset((c1, c2))


def generic_points(col: Colouring):
    """Midpoints of the refinement of the circle by every boundary b and b - 60 (so that on each piece
    both x and x + 60 are generic and constant-coloured)."""
    cuts = sorted({norm(b) for b, _, _ in col.boundaries()} | {norm(b - SIX) for b, _, _ in col.boundaries()})
    if not cuts:
        return [F(0), F(90), F(200)]
    pts = []
    for i, c in enumerate(cuts):
        d = cuts[(i + 1) % len(cuts)]
        if d <= c:
            d += FULL
        pts.append(norm((c + d) / 2))
    return pts


def proper(col: Colouring):
    """Return (True, '') or (False, reason)."""
    # (i): generic x and x + 60 of one colour
    for x in generic_points(col):
        if col.colour_at(x) == col.colour_at(x + SIX):
            return False, f"(i) fails: colour {col.colour_at(x)} at {x} and {norm(x + SIX)}"
    # (ii): boundaries b, b + 60 with the same pair
    bmap = {norm(b): pair(l, r) for b, l, r in col.boundaries()}
    for b, p in bmap.items():
        q = bmap.get(norm(b + SIX))
        if q is not None and q == p:
            return False, f"(ii) fails: pair {sorted(p)} at {b} and {norm(b + SIX)}"
    return True, ""


def step(cfrom, cto):
    d = (cto - cfrom) % 3
    assert d in (1, 2)
    return 1 if d == 1 else -1


def lift(col: Colouring):
    """Heights per arc: h[0] = cols[0] (an integer = colour mod 3), steps +-1 at each boundary.
    Returns (h list aligned with arcs, W = winding)."""
    h = [col.cols[0]]
    for i in range(1, col.n):
        h.append(h[-1] + step(col.cols[i - 1], col.cols[i]))
    W = (h[-1] + step(col.cols[-1], col.cols[0]) - h[0]) if col.n > 1 else 0
    for i in range(col.n):
        assert h[i] % 3 == col.cols[i] % 3
    return h, W


def height_at(col: Colouring, h, W, x: F):
    """Height at a generic real x (unwrapped: x in [0, 360) + 360 t)."""
    t = x // FULL
    xr = x - t * FULL
    for i in range(col.n):
        a, b = col.arc(i)
        if a < xr < b:
            return h[i] + W * t
        if a < xr + FULL < b:  # the wrapping arc, xr small
            return h[i] + W * (t - 1)
    raise AssertionError("uncovered")


def band(col: Colouring):
    """Check H1.  Returns (W, k, sorted set of D values)."""
    h, W = lift(col)
    Ds = set()
    for x in generic_points(col):
        Ds.add(height_at(col, h, W, x + SIX) - height_at(col, h, W, x))
    ks = {(d - 1) // 3 for d in Ds}
    assert all(d % 3 != 0 for d in Ds), f"D hits 0 mod 3: {sorted(Ds)}"
    assert len(ks) == 1, f"D leaves one band: {sorted(Ds)}"
    (k,) = ks
    assert W != 0, "winding zero"
    avg = F(W, 6)
    assert 3 * k + 1 <= avg <= 3 * k + 2, f"W/6 = {avg} outside band {k}"
    return W, k, sorted(Ds)


def running_max_recolour(col: Colouring):
    """H2's construction.  Orientation: if W < 0 reflect heights (running minimum)."""
    h, W = lift(col)
    sgn = 1 if W > 0 else -1
    hs = [sgn * v for v in h]
    Ws = sgn * W
    # running max over the unwrapped line: two laps suffice (the max over (-inf, x] for x in lap 1
    # equals the max over [lap 0, x] since heights drop by Ws per lap going left).
    seq = [(i, hs[i] - Ws) for i in range(col.n)] + [(i, hs[i]) for i in range(col.n)]
    best = None
    newh = []
    for i, v in seq:
        best = v if best is None else max(best, v)
        newh.append((i, best))
    lap1 = [v for (i, v) in newh[col.n:]]  # new height on arc i, lap 1
    # new boundaries: where the new height changes between consecutive arcs (cyclically, with +Ws)
    starts, cols = [], []
    for i in range(col.n):
        prev = lap1[i - 1] if i > 0 else newh[col.n - 1][1]  # arc n-1 of lap 0
        if i == 0 or lap1[i] != prev:
            if lap1[i] != prev:
                assert lap1[i] == prev + 1, "running max jumps by more than 1"
            starts.append(col.starts[i])
            cols.append((sgn * lap1[i]) % 3 or 3)
    # merge a possible equal-colour wrap between last kept arc and arc 0
    if len(cols) > 1 and cols[0] == cols[-1]:
        starts.pop(0)
        cols.pop(0)
        # rotate so starts increase: fine, starts[0] is still the smallest remaining
    return Colouring(starts, cols), sgn


def check_H2(col: Colouring):
    new, sgn = running_max_recolour(col)
    ok, why = proper(new)
    assert ok, f"recoloured not proper: {why}"
    # cyclic: every step has the same sign
    if new.n > 1:
        steps = {step(new.cols[i - 1], new.cols[i]) for i in range(new.n)}
        assert len(steps) == 1, "recoloured not cyclic"
    old = {norm(b): pair(l, r) for b, l, r in col.boundaries()}
    for b, l, r in new.boundaries():
        assert norm(b) in old, f"new bichromatic point {b} not old"
        assert old[norm(b)] == pair(l, r), f"pair changed at {b}: {sorted(old[norm(b)])} -> {sorted(pair(l, r))}"
    return new


def sep_gt1(a: F, b: F) -> bool:
    d = norm(a - b)
    return SIX < d < FULL - SIX


def check_H3_H4(cyc: Colouring):
    ok, why = proper(cyc)
    assert ok, why
    W, k, Ds = band(cyc)
    if W < 0:  # orientation: the band {3k+1, 3k+2} with k < 0 is the mirror of band -k-1
        k, Ds = -k - 1, sorted(-d for d in Ds)
    bs = cyc.boundaries()
    n = len(bs)
    assert n % 3 == 0
    m = n // 3
    if n < 9:
        # H4: exactly six, at exact 60-degree spacing, D == 1
        assert n == 6, f"cyclic proper with {n} < 9 bichromatic points and n != 6"
        angles = sorted(norm(b) for b, _, _ in bs)
        assert all(norm(angles[(i + 1) % 6] - angles[i]) == SIX for i in range(6)), "not a regular hexagon"
        assert Ds == [1], f"D not identically 1: {Ds}"
        return ("hexagon", k)
    # H3
    angles = [b for b, _, _ in bs]  # already counterclockwise from starts
    pairs = [pair(l, r) for _, l, r in bs]
    for p in {frozenset((1, 2)), frozenset((2, 3)), frozenset((1, 3))}:
        idx = [i for i in range(n) if pairs[i] == p]
        assert len(idx) == m, f"pair {sorted(p)} occurs {len(idx)} times, not {m}"
        assert m >= 3 * (k + 1), f"m = {m} < 3(k+1) = {3 * (k + 1)}"
        chosen = [angles[idx[0]], angles[idx[k + 1]], angles[idx[2 * k + 2]]]
        for a in range(3):
            for b in range(a + 1, 3):
                assert sep_gt1(chosen[a], chosen[b]), f"pair {sorted(p)}: {chosen} not pairwise > 1"
    return ("prop18", k)


# ---------------------------------------------------------------- colourings given by formula

def cyclic_equal(N, orient=1, offset=F(0)):
    """N equal arcs, colours 1,2,3,1,2,3,... (orient=-1: 1,3,2,...)."""
    starts = [offset + F(360 * i, N) for i in range(N)]
    cols = [((orient * i) % 3) + 1 for i in range(N)]
    return Colouring(starts, cols)


def with_islands(base_N, island_len, island_at, period=None):
    """Equal cyclic colouring on base_N arcs, plus a backtracking island of the colour two steps back
    (-1 in height) at relative position island_at inside every arc listed by `period` (every arc if None)."""
    arcs = []
    L = F(360, base_N)
    for i in range(base_N):
        c = (i % 3) + 1
        a = L * i
        if period is None or i % period == 0:
            back = ((c - 2) % 3) + 1  # colour with height one lower
            arcs += [(a, c), (a + island_at, back), (a + island_at + island_len, c)]
        else:
            arcs.append((a, c))
    # merge consecutive equal colours
    merged = []
    for s, c in arcs:
        if merged and merged[-1][1] == c:
            continue
        merged.append((s, c))
    if len(merged) > 1 and merged[0][1] == merged[-1][1]:
        merged.pop()
        # the last arc merges into arc 0: shift arc 0's start is not needed for a colouring on the circle:
        # arc 0 now runs from the old last start; represent by starting list at merged[0].
    return Colouring([s for s, _ in merged], [c for _, c in merged])


EXAMPLES = {
    # name: (colouring, expected_proper)
    "E1 hexagon (6 x 60)": (cyclic_equal(6), True),
    "E1r hexagon, reversed orientation": (cyclic_equal(6, orient=-1), True),
    "E2 nine x 40": (cyclic_equal(9), True),
    "E3 nine x 40 + one island (1,3,1) in arc 0 at (10,12)": (with_islands(9, F(2), F(10), period=9), True),
    "E4 twelve x 30": (cyclic_equal(12), True),
    "E5 twenty-four x 15 (m = 8)": (cyclic_equal(24), True),
    "E6 twenty-seven arcs (m = 9)": (cyclic_equal(27), True),
    "E7 fifteen x 24 (m = 5, band theory says improper)": (cyclic_equal(15), False),
    "E8 eighteen x 20 (m = 6, improper)": (cyclic_equal(18), False),
    "E9 two-colour hexagon": (Colouring([F(60 * i) for i in range(6)], [1, 2] * 3), False),
    "E10 hexagon + one island (improper: an island breaks D == 1)": (with_islands(6, F(2), F(10), period=6), False),
    "E11 hexagon + an island in every sector (W = 6, 18 bichromatic points)": (with_islands(6, F(2), F(10)), True),
    "E12 twelve x 30 + islands in every arc": (with_islands(12, F(1), F(5)), True),
    # E13: islands at relative (20, 23) land, 60 degrees later, on the island of arc i+2 (same colour c-1): improper.
    "E13 nine x 40 + islands at (20,23) in every arc (improper)": (with_islands(9, F(3), F(20)), False),
    # E14: islands at (5, 8): proper by hand (needs a < 20 and a + len <= 20).
    "E14 nine x 40 + islands at (5,8) in every arc": (with_islands(9, F(3), F(5)), True),
}


def run():
    fails = 0
    for name, (col, expect) in EXAMPLES.items():
        ok, why = proper(col)
        if ok != expect:
            print(f"FAIL {name}: proper={ok} expected {expect} ({why})")
            fails += 1
            continue
        if not ok:
            # H1 contrapositive: an improper colouring may break the band; report what it does
            print(f"ok   {name}: improper as expected ({why})")
            continue
        W, k, Ds = band(col)
        new = check_H2(col)
        kind, k2 = check_H3_H4(new)
        assert k2 == (k if W > 0 else -k - 1)
        print(f"ok   {name}: n={col.n} W={W} band k={k} D in {Ds}; recoloured n={new.n} -> {kind}")
    return fails


PLANTS = {
    1: "H2 with a pair-changing recolouring (recolour an island to the THIRD colour): must fail 'pair changed'",
    2: "H3 with index gap k instead of k+1: must fail 'not pairwise > 1' on E4 (m = 4, k = 0 -> gap 0)",
    3: "proper() with (ii) disabled: E9 must then be reported proper, i.e. the expectation check must FAIL",
    4: "band() fed an improper colouring (E8): must fail 'D hits 0 mod 3'",
}


def plant(n):
    global proper
    if n == 1:
        col = EXAMPLES["E3 nine x 40 + one island (1,3,1) in arc 0 at (10,12)"][0]
        # island colour 3 in a colour-1 arc between (0,40); recolour it to 2 (the third colour) instead of 1
        starts = list(col.starts)
        cols = list(col.cols)
        i = cols.index(3) if cols[1] == 3 else 1
        cols[i] = 2 if cols[i - 1] != 2 and cols[(i + 1) % len(cols)] != 2 else cols[i]
        bad = Colouring(starts, cols)
        ok, why = proper(bad)
        print("plant 1: recoloured-to-third proper?", ok, why)
        old = {norm(b): pair(l, r) for b, l, r in col.boundaries()}
        for b, l, r in bad.boundaries():
            if old.get(norm(b)) is not None and old[norm(b)] != pair(l, r):
                raise AssertionError(f"pair changed at {b}")
        raise SystemExit("plant 1 did not fire")
    if n == 2:
        col = cyclic_equal(12)
        bs = col.boundaries()
        W, k, _ = band(col)
        idx = [i for i, (_, l, r) in enumerate(bs) if pair(l, r) == frozenset((1, 2))]
        chosen = [bs[idx[0]][0], bs[idx[k]][0], bs[idx[2 * k]][0]]  # gap k: degenerate
        for a in range(3):
            for b in range(a + 1, 3):
                assert sep_gt1(chosen[a], chosen[b]), f"not pairwise > 1: {chosen}"
        raise SystemExit("plant 2 did not fire")
    if n == 3:
        orig = proper

        def proper_no_ii(col):
            for x in generic_points(col):
                if col.colour_at(x) == col.colour_at(x + SIX):
                    return False, "(i)"
            return True, ""

        proper = proper_no_ii
        try:
            f = run()
        finally:
            proper = orig
        assert f == 0, f"expectation check fired ({f} failure(s)) with (ii) disabled"
        raise SystemExit("plant 3 did not fire")
    if n == 4:
        band(EXAMPLES["E8 eighteen x 20 (m = 6, improper)"][0])
        raise SystemExit("plant 4 did not fire")


if __name__ == "__main__":
    if len(sys.argv) == 3 and sys.argv[1] == "--plant":
        plant(int(sys.argv[2]))
    else:
        f = run()
        print("ALL OK" if f == 0 else f"{f} FAILURE(S)")
        sys.exit(1 if f else 0)
