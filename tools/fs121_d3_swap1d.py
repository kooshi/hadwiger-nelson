#!/usr/bin/env python3
"""FS121-D3: the one-dimensional model of FS121-D3-SWAP1D, checked exactly (rational arithmetic, no floats).

The space is the circle R/(5/2)Z; its unit-distance graph joins y and y + 1. The colouring c is given by formula: for y = x + o_i with
x in [0, 1/2), o = (0, 1, 2, 1/2, 3/2), c(y) = P_r(i) with r = floor(18 x) and the nine patterns P_0..P_8 below (proper 3-colourings of the
5-cycle i ~ i +- 1 mod 5, consecutive ones differing by the swap of two adjacent vertices, P_8(i) = P_0(i + 3)).

The check does NOT use the fibre structure: it builds c as a list of circle intervals and tests, on the circle itself,
  (P) a.e.-properness: no two intervals of one colour overlap in positive length after a shift by 1;
  (S) saturation: at every discontinuity y (left colour != right colour) both colours occur on a side of y + 1 or of y - 1
      (a point p lies in supp S_j iff colour j occurs on the left or on the right of p);
  (I) no idomatic three-partition of C_5 exists (exhaustive over the 243 maps V(C_5) -> [3]); and no a.e.-proper 2-colouring of the
      circle's graph exists because every fibre is a 5-cycle (checked as: C_5 has no proper 2-colouring).
Exit 0 iff (P), (S) hold, (I) finds no idomatic partition and no 2-colouring, and the last line reads ALL HOLD.
--plant seam : P_8 replaced by P_0 (the seam relabelling ignored)       -> (S) must fail
--plant skip : P_4 removed (P_3 -> P_5 is not a swap)                    -> (S) must fail
--plant even : (I) run on C_6 in place of C_5                            -> an idomatic partition is found, (I) must fail
--plant order: (G) checked for the order (c, a, b) in place of (a, b, c)   -> (G) must fail
(G) Grundy in the order (a, b, c), on the circle: every point of colour b has colour a at y + 1 or y - 1, and every point of colour c has
    colour a and colour b there (checked on pieces of one parameter step, 1/18, on which c, c(. + 1) and c(. - 1) are constant); with (P), class a is
    then a maximal unit-avoiding set and class b is maximal in the complement of class a.
"""
import sys, itertools
from fractions import Fraction as Fr

L = Fr(5, 2)
O = [Fr(0), Fr(1), Fr(2), Fr(1, 2), Fr(3, 2)]
PATTERNS = ["abab" "c", "abacb", "abcab", "acbab", "cabab", "babac", "babca", "bacba", "bcaba"]
plant = sys.argv[sys.argv.index('--plant') + 1] if '--plant' in sys.argv else None
if plant == 'seam':
    PATTERNS[8] = PATTERNS[0]
if plant == 'skip':
    del PATTERNS[4]
R = len(PATTERNS)
fail = []

# the patterns themselves (reported, not trusted: the circle checks below are the verdict)
for r, p in enumerate(PATTERNS):
    proper = all(p[i] != p[(i + 1) % 5] for i in range(5))
    print(f"P_{r} = {p}  proper on C_5: {proper}")

# build the colouring as circle intervals [a, b) with a colour; parameter step 1/(2R)
step = Fr(1, 2) / R
iv = []
for r, p in enumerate(PATTERNS):
    for i in range(5):
        a = O[i] + r * step
        iv.append((a, a + step, p[i]))
iv.sort()
assert iv[0][0] == 0 and all(iv[t][1] == iv[t + 1][0] for t in range(len(iv) - 1)) and iv[-1][1] == L, "intervals do not tile the circle"

def colour_at_open(a, b):
    """colour on the open interval (a, b) inside one piece, a < b in [0, L)"""
    for (s, e, col) in iv:
        if s <= a and b <= e:
            return col
    return None

def overlap(a1, b1, a2, b2):
    return max(Fr(0), min(b1, b2) - max(a1, a2))

# (P) properness: shift every interval by +1 (mod L, splitting at L) and compare with every interval it overlaps
bad = 0
for (s, e, col) in iv:
    pieces = []
    s1, e1 = s + 1, e + 1
    if e1 <= L:
        pieces.append((s1, e1))
    elif s1 >= L:
        pieces.append((s1 - L, e1 - L))
    else:
        pieces += [(s1, L), (Fr(0), e1 - L)]
    for (a, b) in pieces:
        for (s2, e2, col2) in iv:
            if col2 == col and overlap(a, b, s2, e2) > 0:
                bad += 1
print(f"(P) monochromatic overlaps under the shift by 1: {bad}")
if bad:
    fail.append('P')

# (S) saturation at every discontinuity
def left_right(p):
    p = p % L
    left = next(col for (s, e, col) in iv if s < p <= e) if p != 0 else iv[-1][2]
    right = next(col for (s, e, col) in iv if s <= p < e)
    return left, right

cuts = sorted({s for (s, e, col) in iv})
disc = [(p, *left_right(p)) for p in cuts if left_right(p)[0] != left_right(p)[1]]
unsat = []
for (p, lc, rc) in disc:
    near = set(left_right(p + 1)) | set(left_right(p - 1))
    for col in (lc, rc):
        if col not in near:
            unsat.append((p, col))
print(f"(S) discontinuities: {len(disc)}  unbound (point, colour) pairs: {len(unsat)}")
for u in unsat[:6]:
    print(f"    unbound: y = {u[0]}  colour {u[1]}")
if unsat or not disc:
    fail.append('S')

# (G) Grundy in the order (a, b, c), on pieces of one parameter step
order = 'cab' if plant == 'order' else 'abc'
g = step  # the parameter step 1/(2R): every breakpoint of c and of c(. +- 1) lies on its grid
pieces = [k * g for k in range(int(L / g))]
def col_on(a):
    return colour_at_open(a % L, a % L + g) if (a % L) + g <= L else None
assert all(col_on(a) is not None for a in pieces), "a piece of one step straddles a breakpoint"
gbad = 0
for a in pieces:
    me = col_on(a)
    seen = {col_on(a + 1), col_on(a - 1 + L)}
    lower = order[:order.index(me)]
    gbad += sum(1 for j in lower if j not in seen)
print(f"(G) Grundy defects in the order {order}: {gbad}")
if gbad:
    fail.append('G')

# (I) idomatic three-partitions of the fibre cycle; and 2-colourability of the fibre
n = 6 if plant == 'even' else 5
adj = {v: {(v - 1) % n, (v + 1) % n} for v in range(n)}
idom = 0
for col in itertools.product(range(3), repeat=n):
    if any(col[v] == col[w] for v in range(n) for w in adj[v]):
        continue
    if all(any(col[w] == j for w in adj[v]) for v in range(n) for j in range(3) if j != col[v]):
        idom += 1
two = sum(1 for col in itertools.product(range(2), repeat=5) if all(col[v] != col[(v + 1) % 5] for v in range(5)))
print(f"(I) idomatic 3-partitions of C_{n}: {idom}; proper 2-colourings of C_5: {two}")
if idom or two:
    fail.append('I')

print("ALL HOLD" if not fail else f"FAILED: {' '.join(fail)}")
sys.exit(1 if fail else 0)
