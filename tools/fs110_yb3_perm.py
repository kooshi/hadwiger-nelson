#!/usr/bin/env python3
"""FS110-YB3 — exact checks of the orientation algebra behind Y3-FLIP and Y3-BOW, built blind to FS110-Y3's tools.

Colours are 0..5.  A ring orientation is a cyclic order of three colours; W(v) "on" an orientation.
Transport (N2-TRANS, claims §7.1): along an a|b edge from u (third colour c) to u' (third colour d), c ≠ d,
W(u) on (d, e, f) = W(u') on (c, e, f): the orientation of u' is u's with colour d replaced *in place* by c.
At a same-type step (c = d) the convention of §7.1 (and Y3-FLIP) is the identity; YB3-SAME records that this
convention is not covered by N2-TRANS's statement.  This tool checks algebra only.

FLIP: around a tile of colour a with neighbours b_0..b_{m-1}, transport the orientation of v_0 once round
by direct simulation (no permutation-sign formula) and compare the returned orientation with (−1)^k.
BOW: at a bowtie u = (a,b,a,c) with flanks w1 = {a,b,x}, w2 = {a,b,y}: transport u→w1, u→w2 and w1→w2 (through u);
over every assignment of distinct a, b, c and x, y ∉ {a, b}: the three are inconsistent (so W = −W = 0) iff
x ≠ y and c ∉ {x, y}.

Run: python3 tools/fs110_yb3_perm.py [--plant S|R|D]
  S: a same-type step reverses the orientation (the FLIP formula must fire on a face with k ≥ 1)
  R: the replacement is done at the wrong slot (colour appended last): FLIP must fire on a face with a moving step
  D: the transport through the bowtie vertex reverses the orientation: the BOW table must fire
Exit 0 iff the mode's expectations held (for a plant: iff it was caught).
"""
import itertools
import sys

PLANT = None
if "--plant" in sys.argv:
    PLANT = sys.argv[sys.argv.index("--plant") + 1]


def canon(o):
    """cyclic order as the rotation starting at its least element."""
    i = o.index(min(o))
    return tuple(o[i:] + o[:i])


def same_orientation(o1, o2):
    assert set(o1) == set(o2)
    return canon(list(o1)) == canon(list(o2))


def transport(o, third_u, third_u2):
    """orientation at u' from orientation o at u; third_u = c (u's third colour), third_u2 = d (u′'s)."""
    o = list(o)
    if third_u == third_u2:  # same-type step: §7.1's convention
        if PLANT == "S":
            return (o[1], o[0], o[2])  # FAULT S: reverse at a same-type step
        return tuple(o)
    j = o.index(third_u2)
    if PLANT == "R":  # FAULT R: put c at the end instead of d's slot
        o.pop(j)
        o.append(third_u)
        return tuple(o)
    o[j] = third_u
    return tuple(o)


def flip(a, bs):
    m = len(bs)
    assert all(b != a for b in bs) and all(bs[i] != bs[(i + 1) % m] for i in range(m))
    ring0 = sorted(set(range(6)) - {a, bs[-1], bs[0]})
    o = tuple(ring0)
    k = 0
    for i in range(m):
        prev, nxt = bs[i - 1], bs[(i + 1) % m]
        ring_i = set(range(6)) - {a, bs[i - 1], bs[i]}
        assert set(o) == ring_i, (a, bs, i, o)
        if prev == nxt:
            k += 1
        o = transport(o, prev, nxt)  # v_i third = b_{i-1}, v_{i+1} third = b_{i+1}
    ret = same_orientation(o, tuple(ring0))
    return k, ret


FACES = [  # (tile colour, neighbours)
    (0, [1, 2, 3]),
    (0, [1, 2, 3, 4, 5]),
    (0, [2, 3, 4, 2, 3, 4]),        # the hexagon that §7.1's plant could not reach
    (0, [1, 2, 1, 3]),              # one same-type step (at b=2? steps where b_{i-1}=b_{i+1})
    (0, [1, 2, 1, 2]),              # four same-type steps
    (0, [1, 2, 1, 2, 3]),           # three same-type steps: k odd
    (0, [1, 2, 3, 1, 2, 3, 4]),
    (5, [1, 2, 1, 3, 1, 4]),        # k = 3
    (3, [0, 1, 0, 1, 0, 2]),
]


def bow_table():
    """return the set of (a,b,c,x,y) where the three transports are inconsistent, and the predicate's truth."""
    bad = []
    for a, b, c in itertools.permutations(range(6), 3):
        for x in range(6):
            for y in range(6):
                if x in (a, b) or y in (a, b):
                    continue
                o_u = tuple(sorted(set(range(6)) - {a, b, c}))
                o1 = transport(o_u, c, x)       # u → w1 along the first b|a edge
                o2 = transport(o_u, c, y)       # u → w2 along the second
                o2b = transport(o1, x, y)       # w1 → w2 through u (one homotopy along both b|a edges)
                if PLANT == "D":                # FAULT D: the corner at the bowtie reverses the orientation
                    o2b = (o2b[1], o2b[0], o2b[2])
                inconsistent = not same_orientation(o2, o2b)
                predicted = (x != y) and (c not in (x, y))
                bad.append(((a, b, c, x, y), inconsistent, predicted))
    return bad


def main():
    fails = []
    print(f"mode: {'faithful' if PLANT is None else 'PLANT ' + PLANT}")
    for a, bs in FACES:
        k, ret = flip(a, bs)
        want = (k % 2 == 0)
        print(f"FLIP tile {a} neighbours {bs}: same-type steps k={k}, orientation returned {'same' if ret else 'reversed'}; (−1)^k predicts {'same' if want else 'reversed'}")
        if ret != want:
            fails.append(f"FLIP mismatch on {a},{bs}")
    if not any(flip(a, bs)[0] % 2 == 1 for a, bs in FACES):
        fails.append("no face with k odd: the reversal outcome unreached")
    tab = bow_table()
    mism = [t for t in tab if t[1] != t[2]]
    n_inc = sum(1 for t in tab if t[1])
    print(f"BOW: {len(tab)} assignments; inconsistent (W forced 0) at {n_inc}; mismatches with 'x≠y ∧ c∉{{x,y}}': {len(mism)}")
    if mism:
        fails.append(f"BOW table mismatch, e.g. {mism[0]}")
    if n_inc == 0 or n_inc == len(tab):
        fails.append("BOW: one outcome unreached")
    for f in fails:
        print("FAIL:", f)
    if PLANT is None:
        print("RESULT:", "ALL PASS" if not fails else "FAILURES")
        return 0 if not fails else 1
    want = {"S": "FLIP mismatch", "R": "FLIP mismatch", "D": "BOW table mismatch"}[PLANT]
    caught = any(want in f for f in fails)
    print("PLANT", PLANT, "CAUGHT for its own reason" if caught else "NOT CAUGHT")
    return 0 if caught else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (AssertionError, ValueError) as e:
        print("CRASH (not a catch):", repr(e))
        sys.exit(2)
