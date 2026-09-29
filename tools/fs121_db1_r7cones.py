#!/usr/bin/env python3
"""FS121-DB1 control: the cone picture at a centre of a unit arc of kind both, on R7 (k = 7), exact.

R7 (plans/FS111-M-regularity.md § 2.4): up tile U(m, n) is the Reuleaux triangle on the lattice points (m, n), (m + 1, n), (m, n + 1)
(lattice coordinates: (a, b) is a(1, 0) + b(1/2, √3/2)), coloured 2(m mod 2) + (n mod 2); down tile D(m, n) is the curvilinear triangle
on (m + 1, n), (m, n + 1), (m + 1, n + 1), coloured 4 + ((m − n) mod 3), with a cusp at each vertex.

At the lattice point v = (0, 0), for each of the three unit arcs centred at v (the arc of each up with vertex v, opposite v; inner colour
the up's, outer colour the down's across it), this computes, in whole degrees (every direction here is a multiple of 30°, so the
interval tests below are exact): the window W of the arc seen from v; the closed facing cone F and away cone A (width 180° − |W|);
the open side cones S1, S2 (width |W|); and the sectors at v (the three up corners, 120° each, bounded by the tangents of their two
arcs; the three down cusps, each a single direction). It checks lemma DB1-L1 (inner colour's sector in F; outer colour carried at v,
in A) and lemma DB1-L4's conclusion (the positive-angle sectors meeting S1 and those meeting S2 carry colours outside the two side
colours, and no colour meets both: four distinct colours), and counts the colours v carries and those of positive density.

Usage: python3 tools/fs121_db1_r7cones.py [--plant]   (--plant colours the ups by n mod 2 only; the check must then fail)
Prints one summary line; exits 0 either way.
"""
import math
import sys

PLANT = '--plant' in sys.argv


def cart(a, b):
    return (a + b / 2, b * math.sqrt(3) / 2)


def ang(p, q):
    """Direction from p to q, lattice coordinates, in whole degrees mod 360 (exact here: multiples of 30)."""
    (x0, y0), (x1, y1) = cart(*p), cart(*q)
    d = math.degrees(math.atan2(y1 - y0, x1 - x0))
    r = round(d)
    assert abs(d - r) < 1e-9 and r % 30 == 0, d
    return r % 360


def up_colour(m, n):
    return (n % 2) if PLANT else 2 * (m % 2) + (n % 2)


def down_colour(m, n):
    return 4 + ((m - n) % 3)


def inside_closed(d, lo, hi):
    """d in the closed arc of directions from lo counter-clockwise to hi (degrees)."""
    return (d - lo) % 360 <= (hi - lo) % 360


def meets_open(lo1, hi1, lo2, hi2):
    """Two open arcs of directions (counter-clockwise from lo to hi) share an open set; endpoints are integers, so test half-degrees."""
    for k in range(360):
        d = k + 0.5
        if 0 < (d - lo1) % 360 < (hi1 - lo1) % 360 and 0 < (d - lo2) % 360 < (hi2 - lo2) % 360:
            return True
    return False


def main():
    v = (0, 0)
    ups = [(m, n) for m in range(-2, 2) for n in range(-2, 2) if v in [(m, n), (m + 1, n), (m, n + 1)]]
    downs = [(m, n) for m in range(-2, 2) for n in range(-2, 2) if v in [(m + 1, n), (m, n + 1), (m + 1, n + 1)]]
    # sectors at v: (lo, hi, colour, positive_angle)
    sectors = []
    for (m, n) in ups:
        others = [p for p in [(m, n), (m + 1, n), (m, n + 1)] if p != v]
        a1, a2 = ang(v, others[0]), ang(v, others[1])
        if (a2 - a1) % 360 != 60:
            a1, a2 = a2, a1
        assert (a2 - a1) % 360 == 60
        sectors.append(((a1 - 30) % 360, (a2 + 30) % 360, up_colour(m, n), True, ('U', m, n), (a1, a2)))
    for (m, n) in downs:
        verts = [(m + 1, n), (m, n + 1), (m + 1, n + 1)]
        cx, cy = [sum(c) / 3 for c in zip(*[cart(*p) for p in verts])]
        x0, y0 = cart(*v)
        d = round(math.degrees(math.atan2(cy - y0, cx - x0))) % 360
        sectors.append((d, d, down_colour(m, n), False, ('D', m, n), None))
    carried = {s[2] for s in sectors}
    essential = {s[2] for s in sectors if s[3]}
    ok = 0
    for s in [s for s in sectors if s[4][0] == 'U']:
        a1, a2 = s[5]                      # window W = [a1, a2], |W| = 60
        m, n = s[4][1], s[4][2]
        inner = s[2]
        # the down across the arc opposite v: it has the arc's two ends and their sum minus v as vertices
        p1, p2 = [p for p in [(m, n), (m + 1, n), (m, n + 1)] if p != v]
        far = (p1[0] + p2[0] - v[0], p1[1] + p2[1] - v[1])
        dm = [(i, j) for i in range(-3, 3) for j in range(-3, 3)
              if sorted([(i + 1, j), (i, j + 1), (i + 1, j + 1)]) == sorted([p1, p2, far])]
        assert len(dm) == 1
        outer = down_colour(*dm[0])
        F = ((a2 - 90) % 360, (a1 + 90) % 360)
        A = ((F[0] + 180) % 360, (F[1] + 180) % 360)
        S1 = ((a1 + 90) % 360, (a2 + 90) % 360)
        S2 = ((a1 - 90) % 360, (a2 - 90) % 360)
        in_F = inside_closed(s[0], *F) and inside_closed(s[1], *F) and (s[1] - s[0]) % 360 <= (F[1] - F[0]) % 360
        outer_at_v = [t for t in sectors if t[2] == outer]
        out_in_A = bool(outer_at_v) and all(inside_closed(t[0], *A) and inside_closed(t[1], *A) for t in outer_at_v)
        c1 = {t[2] for t in sectors if t[3] and meets_open(t[0], t[1], *S1)}
        c2 = {t[2] for t in sectors if t[3] and meets_open(t[0], t[1], *S2)}
        side_ok = not ({inner, outer} & (c1 | c2)) and not (c1 & c2) and c1 and c2
        four = len({inner, outer} | c1 | c2) >= 4
        if in_F and out_in_A and side_ok and four:
            ok += 1
    print(f'arcs {len(ups)} cone-picture-ok {ok} carried {len(carried)} essential {len(essential)}')


if __name__ == '__main__':
    main()
