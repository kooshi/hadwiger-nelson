#!/usr/bin/env python3
"""FS110-N2: exact check of N2-FLIP (face monodromy of the ring winding) on faces given by formula.

A tile of colour 1 with neighbour colours b_0..b_{m-1} in cyclic order; its boundary vertex v_i has type {1, b_{i-1}, b_i}.
N2-TRANS (hand): along the edge v_i -> v_{i+1}, the ring orientation is transported by putting v_i's third colour in the slot of
v_{i+1}'s third colour (identity when the types agree).  N2-FLIP (hand): after a full turn the orientation is reversed iff the
number k of same-type steps (b_{i-1} = b_{i+1}) is odd.  This tool checks the parity rule on named faces; the proof is by hand.
Usage: python3 tools/fs110_n_face.py [--plant wrongslot]   Exit 0 iff all hold; the plant must exit non-zero.
"""
import sys
PLANT = sys.argv[2] if len(sys.argv) == 3 and sys.argv[1] == "--plant" else None

def transport(b):
    m = len(b); C = {2, 3, 4, 5, 6}
    t = lambda i: {1, b[(i - 1) % m], b[i % m]}
    ring = sorted(C - t(0)); lab = list(ring); k = 0
    for i in range(m):
        u, up = t(i), t(i + 1)
        assert len(u) == 3, "a boundary vertex must be trivalent with three colours"
        if u == up:
            k += 1
            continue
        c = (u - up).pop(); d = (up - u).pop()
        if PLANT == "wrongslot":
            lab = [c if x == lab[0] else x for x in lab]   # planted: overwrite a fixed slot, not d's slot
        else:
            lab = [c if x == d else x for x in lab]
    if set(lab) != set(ring):
        return k, None
    perm = [ring.index(x) for x in lab]
    return k, sum(1 for i in range(3) for j in range(i + 1, 3) if perm[i] > perm[j]) % 2

cases = {"pentagon 2..6": [2, 3, 4, 5, 6], "hexagon 2,3,4,2,3,4": [2, 3, 4, 2, 3, 4], "pentagon one repeat": [2, 3, 2, 4, 5],
         "hexagon two repeats": [2, 3, 2, 3, 4, 5], "heptagon one repeat": [2, 3, 2, 4, 5, 6, 4]}
fails = []
for n, b in cases.items():
    k, par = transport(b)
    good = par is not None and par == k % 2
    print(f"{'ok  ' if good else 'FAIL'} {n}: k={k} flip={par}")
    if not good:
        fails.append(n)
print("RESULT:", "PASS" if not fails else "FAIL " + "; ".join(fails))
sys.exit(1 if fails else 0)
