"""De Grey's lattice: the 54 unit vectors modulo the Eisenstein sublattice T0 spanned by one hexagon.  For each coset class, the set
of unit vectors in it, as offsets in T0 coordinates, and whether they contain a unit triangle of T0."""
import itertools, collections
from fractions import Fraction as Fr
import sympy
from degrey_lang import load
H, U8, U, cols = load()
U = [tuple(u) for u in U]
Us = set(U)
# find a hexagon: u and the unit vectors v with u - v in U and ... group U into hexagons by the triangle relation
def neg(v): return tuple(-x for x in v)
def add(a,b): return tuple(x+y for x,y in zip(a,b))
def sub(a,b): return tuple(x-y for x,y in zip(a,b))
hexes = []
seen = set()
for u in U:
    if u in seen: continue
    h = {u}
    frontier = [u]
    while frontier:
        a = frontier.pop()
        for b in U:
            if b not in h and b != neg(a) and sub(a, b) in Us:  # a, b at 60 degrees
                h.add(b); frontier.append(b)
    hexes.append(sorted(h)); seen |= h
print('hexagons:', len(hexes), [len(h) for h in hexes])
H0 = hexes[0]
# T0 basis: two of the hexagon's vectors at 60 degrees
e1 = H0[0]; e2 = next(b for b in H0 if b != neg(e1) and sub(e1, b) in Us)
B = sympy.Matrix([list(e1), list(e2)]).T  # 4x2
def t0coords(v):
    """solve v = a e1 + b e2 over Q; None if no solution"""
    sol = sympy.Matrix(B).gauss_jordan_solve(sympy.Matrix(list(v)))
    try:
        x, params = sol
    except Exception:
        return None
    if params.shape[0] > 0: return None
    return tuple(Fr(int(a.p), int(a.q)) for a in x)
def incoset(v):
    try:
        c = t0coords(v)
    except ValueError:
        return None
    if c is None or any(q.denominator != 1 for q in c): return None
    return tuple(int(q) for q in c)
classes = collections.defaultdict(list)
for w in U:
    placed = False
    for rep in list(classes):
        c = incoset(sub(w, rep))
        if c is not None:
            classes[rep].append((w, c)); placed = True; break
    if not placed:
        classes[w].append((w, (0, 0)))
print('coset classes of U mod T0:', len(classes), sorted(len(v) for v in classes.values()))
# in T0 coords (a,b) meaning a e1 + b e2 with e1, e2 at 60 degrees; triangle offsets {p, p+e1, p+e2} or {p, p+e1, p+e1-e2}...
T0units = {(1,0),(0,1),(-1,0),(0,-1)}
# e1 - e2 is a unit vector of T0 too (a, b at 60 degrees => a - b unit)
T0units |= {(1,-1),(-1,1)}
for rep, mem in classes.items():
    offs = [c for _, c in mem]
    tri = any(sub(p,q) in T0units and sub(p,r) in T0units and sub(q,r) in T0units for p,q,r in itertools.combinations(offs,3))
    print(len(mem), 'offsets', sorted(offs), 'contains a T0 triangle:', tri)
