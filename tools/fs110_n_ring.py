#!/usr/bin/env python3
"""FS110-N2: exact check of the ring-winding lemma N2-RING on rings given by formula.

A *ring* is the colouring of the unit circle about a trivalent vertex u by the three colours of the
complementary triple (N-E1), given as arcs [a_i, a_{i+1}) of rational degrees with colours in Z/3.
N-E0 (A-EXACT) demands c(t) != c(t + 60) wherever both are defined.

N2-RING (hand, FS110-N2 stage 4): lift c to c~ with steps +-1 at each change; D(t) = c~(t+60) - c~(t) never
== 0 mod 3; D leaves its band {3m+1, 3m+2} only by a jump of +-2 at a *swap* (t and t+60 change at once, with
c(t+60+) = c(t-) and c(t+60-) = c(t+)); if D keeps one band, 3W = sum of D over a hexagon in [18m+6, 18m+12],
so |W| >= 2.  Hence: W = 0 => a swap exists; no swap => |W| >= 2.

This tool checks those statements on named rings (controls) exactly (Fractions), and reports each change
point's neighbour pattern.  It proves nothing about all rings; the lemma's proof is the hand derivation.

Usage: python3 tools/fs110_n_ring.py [--plant swapdetector|nolift]
Exit 0 iff every assertion holds.  A plant must make it exit non-zero, for the planted reason.
"""
import sys
from fractions import Fraction as Fr

PLANT = None
if len(sys.argv) == 3 and sys.argv[1] == "--plant":
    PLANT = sys.argv[2]


def ring(arcs):
    """arcs: list of (start_deg, colour); arc i is [start_i, start_{i+1}); last wraps to 360."""
    starts = [Fr(a) % 360 for a, _ in arcs]
    assert starts == sorted(starts) and starts[0] == 0, "arcs must start at 0 and increase"
    return [(s, c % 3) for s, (_, c) in zip(starts, arcs)]


def colour_at(R, t):
    """colour on the open arc containing t (t not an endpoint)."""
    t = Fr(t) % 360
    c = R[-1][1]
    for s, col in R:
        if s <= t:
            c = col
    return c


def endpoints(R):
    return [s for s, _ in R]


def side(R, t, eps):
    return colour_at(R, t - eps), colour_at(R, t + eps)


def check_proper(R):
    pts = sorted(set(endpoints(R) + [(e + 60) % 360 for e in endpoints(R)] + [(e - 60) % 360 for e in endpoints(R)]))
    # sample midpoints between all critical points
    for i, p in enumerate(pts):
        q = pts[(i + 1) % len(pts)] + (360 if i + 1 == len(pts) else 0)
        m = (p + q) / 2
        if colour_at(R, m) == colour_at(R, m + 60):
            return False
    return True


def lift_steps(R):
    """change points with their step +-1 (mod 3 lift); raise if a change is not +-1 (impossible mod 3)."""
    out = []
    n = len(R)
    for i in range(n):
        prev = R[i - 1][1]
        cur = R[i][1]
        if prev == cur:
            continue
        d = (cur - prev) % 3
        step = 1 if d == 1 else -1
        if PLANT == "nolift":
            step = 1  # planted fault: forget the orientation of the step
        out.append((R[i][0], step))
    return out


def winding(R):
    s = sum(st for _, st in lift_steps(R))
    assert s % 3 == 0, f"lift sum {s} not divisible by 3"
    return s // 3


def swaps(R, eps):
    out = []
    for t, _ in lift_steps(R):
        a, b = side(R, t, eps)          # c(t-), c(t+)
        c1, c2 = side(R, t + 60, eps)   # c(t+60-), c(t+60+)
        if PLANT == "swapdetector":
            ok = (c1 == a and c2 == b)  # planted fault: compares the wrong sides
        else:
            ok = (c1 == b and c2 == a)
        if a != b and ok:
            out.append(t)
    return out


def D_values(R, eps):
    """lifted D on each elementary interval: c~(t+60) - c~(t), c~ from the recorded steps."""
    steps = dict(lift_steps(R))
    crit = sorted(set(endpoints(R) + [(e - 60) % 360 for e in endpoints(R)]))
    def ctil(t):  # lifted colour at t (t in (0, 720)), base c~(0+) = colour_at(0+)
        base = colour_at(R, eps)
        v = base
        for s in sorted(steps):
            for k in (0, 360):
                if 0 < s + k < t:
                    v += steps[s]
        return v
    vals = []
    for i, p in enumerate(crit):
        q = crit[(i + 1) % len(crit)] + (360 if i + 1 == len(crit) else 0)
        m = (p + q) / 2
        if m <= 0:
            m += 360
        vals.append(ctil(m + 60) - ctil(m))
    return vals


def pattern(R, t, eps):
    p, q = side(R, t, eps)
    return (p, q), side(R, t + 60, eps), side(R, t - 60, eps)


def classify(R, eps):
    """For each change point: which cone is forced (N2-SWAP, N2-ROT): per hand table of stage 4."""
    res = []
    for t, _ in lift_steps(R):
        (p, q), (s1, s2), (m1, m2) = pattern(R, t, eps)
        Aplus, Bplus = (s1 == q), (s2 == p)
        Aminus, Bminus = (m2 == p), (m1 == q)
        if Aplus and Bplus:
            kind = "swap(+60): unit arc of w(sigma x) or covering pair"
        elif Aminus and Bminus:
            kind = "swap(-60): unit arc of w(sigma^-1 x) or covering pair"
        elif Aplus and Aminus:
            kind = "outward cone forced: colour of t outside B(u,1)"
        elif Bplus and Bminus:
            kind = "inward cone forced: colour of t inside B(u,1)"
        else:
            kind = "free"
        res.append((t, kind))
    return res


EPS = Fr(1, 1000)
fails = []

def expect(name, cond):
    if not cond:
        fails.append(name)
    print(("ok   " if cond else "FAIL ") + name)

# controls, each given by formula
alt2 = ring([(60 * k, k % 2) for k in range(6)])            # two colours, 60-degree arcs (S-V Lemma 2's ring)
rot = ring([(60 * k, k) for k in range(6)])                 # rotating ring d,e,f,d,e,f
w3 = ring([(40 * k, k) for k in range(9)])                   # nine 40-degree arcs, W = 3, all changes single
w4 = ring([(30 * k, k) for k in range(12)])                  # twelve 30-degree arcs, W = 4
mixed = ring([(0, 0), (60, 1), (120, 0), (150, 2), (180, 1), (240, 2), (300, 1)])  # a mixed ring
bad = ring([(0, 0), (90, 1), (180, 0), (270, 1)])            # violates N-E0 (90-degree arcs)

expect("N-E0 rejects 90-degree two-colour ring", not check_proper(bad))
for name, R in [("alt2", alt2), ("rot", rot), ("w3", w3), ("w4", w4), ("mixed", mixed)]:
    pr = check_proper(R)
    expect(f"{name}: proper (N-E0)", pr)
    if not pr:
        continue
    W = winding(R)
    S = swaps(R, EPS)
    Ds = D_values(R, EPS)
    bands = {(d - 1) // 3 for d in Ds}
    print(f"     {name}: W={W} swaps={[str(s) for s in S]} D={sorted(set(Ds))} bands={sorted(bands)}")
    expect(f"{name}: D never 0 mod 3", all(d % 3 != 0 for d in Ds))
    expect(f"{name}: W=0 => swap", W != 0 or len(S) > 0)
    expect(f"{name}: no swap => |W|>=2", len(S) > 0 or abs(W) >= 2)
    expect(f"{name}: one band => no band-crossing needed", len(bands) == 1 or len(S) > 0)
    for t, kind in classify(R, EPS):
        print(f"       change at {t}: {kind}")

expect("alt2: W = 0 and six swaps", winding(alt2) == 0 and len(swaps(alt2, EPS)) == 6)
expect("rot: W = 2, no swap, outward cones", winding(rot) == 2 and not swaps(rot, EPS)
       and all(k.startswith("outward") for _, k in classify(rot, EPS)))
expect("w3: W = 3, no swap, all changes free", winding(w3) == 3 and not swaps(w3, EPS)
       and all(k == "free" for _, k in classify(w3, EPS)))
expect("w4: W = 4, no swap", winding(w4) == 4 and not swaps(w4, EPS))

print("RESULT:", "PASS" if not fails else "FAIL " + "; ".join(fails))
sys.exit(0 if not fails else 1)
