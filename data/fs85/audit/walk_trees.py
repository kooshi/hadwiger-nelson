"""FS-85 input audit, task A1: walk Parts's colouring trees S, L1-L8 ([Parts2020hv], Table 4) as a fixed certificate.

The transcriptions (trees/*.txt) were read BY EYE from the paper's raster images of Table 4; this walker trusts none of them.
It never searches: it reads each tree as given and checks, node by node, the one deduction the node records.

Cell format, one node per line:  n  p1 p2 p3 p4  a b c d  k
  p_c   the earlier node Parts lists in colour port c (0 = unused colour of a root node, '-' = empty port)
  a..d  the vertex (a + b sqrt33 + i(c sqrt3 + d sqrt11))/12
  k     the cell's displayed colour: 1 red, 2 yellow, 3 green, 4 blue, b grey (branch), e white (end)
A line may end in '# ...' (a note).  '?' anywhere in a line marks an unreadable cell; the walker then refuses the tree.

What is checked, for every tree:
  (R) root cells: exactly one empty port, three 0-ports; displayed colour = the empty port; the root colouring is proper;
      (that the root colouring restricts the Table 1 case it answers is checked by golomb.py, task A2).
  (T) non-root cells, read in order as a binary tree in preorder (the shape is fixed by the port counts alone):
      4 ports filled = end (leaf), 3 = stem (one child, forced colour = the empty port), 2 = branch (two children),
      fewer = refused.  Every listed port neighbour m of node n is an ANCESTOR of n in that tree (never a node of a
      sibling branch), has colour c on n's path, and is at unit distance from n (two independent exact tests).
      A branch's colour on each side is read off the references to it on that side; the two sides must take its two
      free colours, one each.  The whole list is consumed exactly.
  (V) every vertex is a vertex of G481, rebuilt here from Table 3 by an integer orbit generator of our own.
  (P) the parameters of Table 2 (nodes, roots, ends, distinct vertices, non-root nodes) and the per-orbit counts of
      used vertices in Table 3 are recomputed from the transcription and compared.
Run:  python3 walk_trees.py [TREE ...]      (default: all nine)      python3 walk_trees.py --plant   (the fault plants)
"""
import sys, os
from itertools import product

HERE = os.path.dirname(os.path.abspath(__file__))

# ---------------------------------------------------------------- unit distance, two independent exact tests
def unit_int(p, q):
    """|p - q| = 1 exactly: 144|z|^2 = da^2 + 33 db^2 + 3 dc^2 + 11 dd^2 + 2 sqrt33 (da db + dc dd)."""
    da, db, dc, dd = (x - y for x, y in zip(p, q))
    return da*da + 33*db*db + 3*dc*dc + 11*dd*dd == 144 and da*db + dc*dd == 0

def paper_units():
    """Parts's list of the 30 unit differences (section 4, 'Verification notes')."""
    U = set()
    for s in (1, -1):
        U.add((12*s, 0, 0, 0))
    for s, t in product((1, -1), repeat=2):
        U.add((10*s, 0, 0, 2*t)); U.add((6*s, 0, 6*t, 0)); U.add((0, 2*s, 2*t, 0))
    for sg in product((1, -1), repeat=4):
        if sg.count(-1) % 2 == 1:
            U.add(tuple(x*y for x, y in zip(sg, (5, 1, 5, 1))))
            U.add(tuple(x*y for x, y in zip(sg, (3, 1, 1, 3))))
    assert len(U) == 30 and all(unit_int(u, (0, 0, 0, 0)) for u in U)
    return U
UNITS = paper_units()

def unit(p, q):
    a = unit_int(p, q)
    b = tuple(x - y for x, y in zip(p, q)) in UNITS
    assert a == b, ("the two unit tests disagree", p, q)
    return a

# ---------------------------------------------------------------- G481 from Table 3, by our own integer orbit generator
# Table 3 representatives, degree and order (as re-read by eye and degree-checked in data/fs85/verifier/g481.py).
T3 = [((0,0,0,0),30,1),((0,0,4,0),24,6),((12,0,0,0),23,6),((0,0,8,0),18,6),((0,0,12,0),8,6),
      ((6,2,0,0),15,12),((2,0,0,2),20,12),((10,0,0,2),16,12),((0,2,2,0),22,12),((4,0,0,4),11,12),((14,0,0,2),8,12),
      ((0,2,6,0),12,12),((8,0,0,4),10,12),((6,0,0,6),6,12),((0,2,10,0),8,12),
      ((2,0,4,2),15,24),((12,2,2,0),13,24),((2,0,6,4),8,24),((4,0,2,2),16,24),((4,0,6,2),12,24),((4,0,4,4),7,24),
      ((8,0,2,2),12,24),((8,0,6,2),10,24),((6,2,4,0),15,24),((2,0,2,4),9,24),((10,0,4,2),9,24),((8,0,4,4),8,24),
      ((12,2,6,0),8,24),((6,2,8,0),9,24)]

def rot60(v):
    """Multiplication by zeta = (1 + i sqrt3)/2 on (a + b sqrt33 + i(c sqrt3 + d sqrt11))/12."""
    a, b, c, d = v
    assert (a - 3*c) % 2 == 0 and (b - d) % 2 == 0
    return ((a - 3*c)//2, (b - d)//2, (a + c)//2, (3*b + d)//2)

def cconj(v):   # complex conjugation
    a, b, c, d = v; return (a, b, -c, -d)

def gal(v):     # Parts's 'conjugation symmetry': sqrt3 -> -sqrt3, sqrt33 -> -sqrt33 (sqrt11 fixed)
    a, b, c, d = v; return (a, -b, -c, d)

def orbit(v):
    out = set()
    for g in (False, True):
        for cj in (False, True):
            w = gal(v) if g else v
            w = cconj(w) if cj else w
            for _ in range(6):
                out.add(w); w = rot60(w)
    return out

G481 = {}
for rep, deg, order in T3:
    o = orbit(rep)
    assert len(o) == order, (rep, len(o), order)
    for p in o:
        assert p not in G481
        G481[p] = rep
assert len(G481) == 481
_deg = {p: 0 for p in G481}
for p in G481:
    for u in UNITS:
        q = tuple(x + y for x, y in zip(p, u))
        if q in G481:
            _deg[p] += 1
assert all(_deg[p] == deg for rep, deg, _ in T3 for p in G481 if G481[p] == rep), "Table 3 degree column"

# ---------------------------------------------------------------- Tables 2 and 3 (the paper's parameters, for comparison)
TREES = ['S', 'L1', 'L2', 'L3', 'L4', 'L5', 'L6', 'L7', 'L8']
TABLE2 = {  # nodes in total, root nodes, end nodes, vertices used, elementary checks
    'S': (11, 7, 1, 11, 4), 'L1': (147, 13, 5, 113, 134), 'L2': (43, 11, 1, 43, 32), 'L3': (144, 13, 6, 130, 131),
    'L4': (80, 11, 3, 74, 69), 'L5': (49, 13, 2, 46, 36), 'L6': (65, 13, 2, 64, 52), 'L7': (105, 13, 5, 88, 92),
    'L8': (247, 10, 14, 155, 237)}
TABLE3 = {  # orbit representative -> used vertices in S, L1..L8
    (0,0,0,0): (0,1,1,1,1,1,1,1,1), (0,0,4,0): (0,4,1,5,4,1,3,6,6), (12,0,0,0): (3,6,4,6,6,6,6,6,6),
    (0,0,8,0): (0,2,0,2,0,0,0,1,3), (0,0,12,0): (0,0,1,0,0,1,0,0,1), (6,2,0,0): (0,6,0,7,6,0,3,3,8),
    (2,0,0,2): (4,11,6,12,8,6,6,6,9), (10,0,0,2): (0,2,5,5,6,1,2,3,7), (0,2,2,0): (0,8,1,8,4,2,6,4,7),
    (4,0,0,4): (0,4,1,3,0,2,2,2,3), (14,0,0,2): (0,2,0,0,0,0,3,0,2), (0,2,6,0): (0,2,0,4,3,0,2,2,5),
    (8,0,0,4): (0,8,3,5,1,3,1,4,4), (6,0,0,6): (0,0,0,0,0,0,3,1,0), (0,2,10,0): (0,0,1,1,1,0,0,1,3),
    (2,0,4,2): (0,2,2,4,0,2,0,5,9), (12,2,2,0): (0,7,0,8,2,1,3,2,7), (2,0,6,4): (0,0,1,3,0,2,0,1,3),
    (4,0,2,2): (0,7,3,15,1,1,1,9,15), (4,0,6,2): (2,11,4,11,11,5,8,8,14), (4,0,4,4): (0,0,0,0,0,0,0,2,2),
    (8,0,2,2): (0,2,2,5,1,1,1,4,7), (8,0,6,2): (0,6,2,2,1,4,2,1,6), (6,2,4,0): (2,18,4,16,16,6,11,10,16),
    (2,0,2,4): (0,2,0,2,0,0,0,1,3), (10,0,4,2): (0,0,1,3,0,1,0,2,4), (8,0,4,4): (0,0,0,0,0,0,0,1,1),
    (12,2,6,0): (0,0,0,1,0,0,0,1,3), (6,2,8,0): (0,2,0,1,2,0,0,1,0)}
MONO = [(6, 0, 6, 0), (6, 0, -6, 0), (-12, 0, 0, 0)]

# ---------------------------------------------------------------- reading a transcription
def read(name, path=None):
    path = path or os.path.join(HERE, 'trees', name + '.txt')
    cells = []
    for raw in open(path):
        line = raw.split('#')[0].strip()
        if not line:
            continue
        if '?' in line:
            raise ValueError(f"{name}: unreadable cell recorded: {raw.strip()}")
        f = line.split()
        assert len(f) == 10, (name, raw)
        n = int(f[0])
        ports = [None if x == '-' else int(x) for x in f[1:5]]
        v = tuple(int(x) for x in f[5:9])
        k = f[9]
        assert k in ('1', '2', '3', '4', 'b', 'e'), (name, raw)
        cells.append((n, ports, v, k))
    return cells

# ---------------------------------------------------------------- the walk
def walk(name, cells, verbose=True):
    errs = []
    def err(msg):
        errs.append(msg)
    nums = [c[0] for c in cells]
    if nums != list(range(1, len(cells) + 1)):
        err("node numbers are not 1..N in order")
        return errs, None
    cell = {c[0]: c for c in cells}
    for n, ports, v, k in cells:
        if v not in G481:
            err(f"node {n}: vertex {v} is not a vertex of G481")
    # (R) roots
    roots = [c for c in cells if 0 in c[1]]
    R = len(roots)
    if [c[0] for c in roots] != list(range(1, R + 1)):
        err("root cells are not the first cells")
    colour = {}
    for n, ports, v, k in roots:
        empty = [i + 1 for i, p in enumerate(ports) if p is None]
        if len(empty) != 1 or any(p not in (None, 0) for p in ports):
            err(f"root {n}: ports {ports} are not three 0s and one empty port"); continue
        colour[n] = empty[0]
        if k != str(empty[0]):
            err(f"root {n}: displayed colour {k} but empty port {empty[0]}")
    for i, j in product(colour, colour):
        if i < j and colour[i] == colour[j] and unit(cell[i][2], cell[j][2]):
            err(f"root colouring improper: roots {i}, {j} colour {colour[i]} at unit distance")
    # Whether the root colouring is the restriction of the Table 1 case it answers is task A2's check (golomb.py);
    # a root may omit vertices of the triple (L2 omits two), since fewer assumptions only weaken what is refuted.
    # shape: preorder parse by port counts
    first = R + 1
    N = len(cells)
    kids = {}
    def filled(n):
        return sum(p is not None for p in cell[n][1])
    def shape(i):
        """Parse the subtree whose root cell is i; return the index after it."""
        while True:
            if i > N:
                raise IndexError("the list ends inside a path (a path with no end node)")
            f = filled(i)
            if f == 4:
                kids[i] = []
                return i + 1
            if f == 3:
                kids[i] = [i + 1]
                i += 1
                continue
            if f == 2:
                j = shape(i + 1)
                kids[i] = [i + 1, j]
                return shape(j)
            raise ValueError(f"node {i}: only {f} ports filled (not a stem, branch or end)")
    try:
        end = shape(first)
        if end != N + 1:
            err(f"the tree is complete at node {end - 1} but the list runs to {N}")
    except (IndexError, ValueError) as e:
        err(f"shape: {e}")
        return errs, None
    # subtree ranges, and each branch's colour on each side from the references to it
    def subtree_end(i):
        e = i
        stack = [i]
        while stack:
            x = stack.pop(); e = max(e, x)
            stack.extend(kids[x])
        return e
    side_colour = {}
    for n in kids:
        if filled(n) != 2:
            continue
        free = [c + 1 for c, p in enumerate(cell[n][1]) if p is None]
        sides = []
        for s in kids[n]:
            refs = {c + 1 for m in range(s, subtree_end(s) + 1) for c, p in enumerate(cell[m][1]) if p == n}
            if len(refs) > 1:
                err(f"branch {n}: its side from node {s} refers to it with colours {sorted(refs)}")
            sides.append(refs)
        a, b = sides
        opts = [(x, y) for x in free for y in free if x != y and (not a or a == {x}) and (not b or b == {y})]
        if not opts:
            err(f"branch {n}: free colours {free}, sides use {sorted(a)} and {sorted(b)}: no valid split")
            continue
        side_colour[(n, kids[n][0])], side_colour[(n, kids[n][1])] = opts[0]
        if cell[n][3] != 'b':
            err(f"branch {n}: displayed '{cell[n][3]}', not grey")
    # the walk proper: every path from the roots
    stats = {'ends': 0, 'checks': 0}
    def go(i, path):
        while True:
            n, ports, v, k = cell[i]
            stats['checks'] += 1
            for c, m in enumerate(ports, start=1):
                if m is None:
                    continue
                if m not in path:
                    err(f"node {n}: port {c} names node {m}, which is not on its path")
                    continue
                if path[m] != c:
                    err(f"node {n}: port {c} names node {m}, which has colour {path[m]} on this path")
                if not unit(v, cell[m][2]):
                    err(f"node {n}: port {c} neighbour {m} is not at unit distance")
            f = filled(i)
            if f == 4:
                stats['ends'] += 1
                if k != 'e':
                    err(f"end node {n}: displayed '{k}', not white")
                return
            if f == 3:
                c = [c for c, m in enumerate(ports, start=1) if m is None][0]
                if k != str(c):
                    err(f"stem {n}: displayed colour {k} but forced colour {c}")
                # a vertex met twice on one path must get the same colour
                for m, cm in path.items():
                    if cell[m][2] == v and cm != c:
                        err(f"stem {n}: vertex already on the path as node {m} with colour {cm}")
                path = dict(path); path[i] = c
                i += 1
                continue
            for s in kids[i]:
                p2 = dict(path); p2[i] = side_colour.get((i, s))
                go(s, p2)
            return
    go(first, dict(colour))
    if stats['checks'] != N - R:
        err(f"the walk visited {stats['checks']} non-root cells, not {N - R}")
    # (P) parameters
    used = {c[2] for c in cells}
    params = (N, R, stats['ends'], len(used), N - R)
    per_orbit = {rep: 0 for rep in TABLE3}
    for p in used:
        if p in G481:
            per_orbit[G481[p]] += 1
    col = TREES.index(name) if name in TREES else None
    if col is not None:
        if params != TABLE2[name]:
            err(f"Table 2 parameters {TABLE2[name]} but transcription gives {params}")
        bad = [(rep, TABLE3[rep][col], per_orbit[rep]) for rep in TABLE3 if TABLE3[rep][col] != per_orbit[rep]]
        if bad:
            err(f"Table 3 used-vertex counts differ (orbit, paper, transcription): {bad}")
    return errs, {'params': params, 'roots': {cell[n][2]: colour[n] for n in colour}}

# ---------------------------------------------------------------- the planted faults (one per tree; each must be refused, for its reason)
def ancestors_map(cells):
    """node -> set of its ancestors (roots included), from the preorder shape; used only to aim two plants."""
    cell = {c[0]: c for c in cells}
    R = sum(1 for c in cells if 0 in c[1])
    anc = {}
    def filled(n): return sum(p is not None for p in cell[n][1])
    def go(i, path):
        while True:
            anc[i] = set(path)
            f = filled(i)
            if f == 4: return i + 1
            if f == 3: path = path | {i}; i += 1; continue
            j = go(i + 1, path | {i}); return go(j, path | {i})
    go(R + 1, frozenset(range(1, R + 1)))
    return anc

def stem_colour(c):
    e = [i + 1 for i, p in enumerate(c[1]) if p is None]
    return e[0] if len(e) == 1 else None

def plants():
    """Yield (tree, description, planted cells, the node whose refusal is expected, a phrase the refusal must contain)."""
    def mut(cells, n, ports=None, v=None, k=None):
        out = []
        for c in cells:
            if c[0] == n:
                c = (n, ports if ports is not None else c[1], v if v is not None else c[2], k if k is not None else c[3])
            out.append(c)
        return out
    c = {t: read(t) for t in TREES}
    get = lambda t, n: c[t][n - 1]
    # S: a coordinate misread, -3 as 3 (node 10's last coordinate)
    v = get('S', 10)[2]; yield 'S', 'node 10: d = -3 read as 3', mut(c['S'], 10, v=v[:3] + (3,)), 10, 'unit distance'
    # L1: a port misread naming a node of the wrong colour (94's green port 93 read as 91, a red node)
    p = list(get('L1', 94)[1]); p[2] = 91; yield 'L1', "node 94: green port 93 read as 91", mut(c['L1'], 94, ports=p), 94, 'has colour'
    # L2: a coordinate misread off G481 (node 30, a = 18 read as 16)
    v = get('L2', 30)[2]; yield 'L2', 'node 30: a = 18 read as 16', mut(c['L2'], 30, v=(16,) + v[1:]), 30, 'not a vertex of G481'
    # L3: a port naming a node of the right colour at unit distance that lies in a SIBLING branch (the ancestor rule alone)
    anc = ancestors_map(c['L3']); cell = {x[0]: x for x in c['L3']}
    col = {x[0]: stem_colour(x) for x in c['L3']}
    found = None
    for n, ports, v, k in c['L3']:
        if 0 in ports or found: continue
        for ci, m in enumerate(ports):
            if m is None or found: continue
            for m2 in range(1, n):
                if m2 not in anc[n] and col.get(m2) == ci + 1 and cell[m2][3] == str(ci + 1) and unit(v, cell[m2][2]):
                    found = (n, ci, m2); break
    n, ci, m2 = found; p = list(cell[n][1]); p[ci] = m2
    yield 'L3', f"node {n}: port {ci + 1} redirected to node {m2}, adjacent and of that colour but in a sibling branch", \
        mut(c['L3'], n, ports=p), n, 'not on its path'
    # L4: a stem's displayed colour misread (node 40, red shown as yellow)
    yield 'L4', "node 40: displayed colour 1 read as 2", mut(c['L4'], 40, k='2'), 40, 'displayed colour'
    # L5: both sides of branch 22 refute the SAME colour: side B (27..49, the tail of the list) replaced by a copy of side A
    sideA = [x for x in c['L5'] if 23 <= x[0] <= 26]
    sh = lambda m: m + 4 if m is not None and 23 <= m <= 26 else m
    copy = [(x[0] + 4, [sh(m) for m in x[1]], x[2], x[3]) for x in sideA]
    yield 'L5', "branch 22: side B replaced by a copy of side A (both sides take colour 3)", \
        [x for x in c['L5'] if x[0] <= 26] + copy, 22, 'no valid split'
    # L6: an end node's port lost (node 65's blue port 62 read as empty): the last path then has no end
    p = list(get('L6', 65)[1]); p[3] = None
    yield 'L6', "node 65 (end): blue port 62 read as empty", mut(c['L6'], 65, ports=p), None, 'no end node'
    # L7: a port naming an ancestor of the right colour that is NOT at unit distance (the unit test alone)
    anc = ancestors_map(c['L7']); cell = {x[0]: x for x in c['L7']}
    col = {x[0]: stem_colour(x) for x in c['L7']}
    found = None
    for n, ports, v, k in c['L7']:
        if 0 in ports or found: continue
        for ci, m in enumerate(ports):
            if m is None or found: continue
            for m2 in sorted(anc[n]):
                if m2 != m and col.get(m2) == ci + 1 and not unit(v, cell[m2][2]):
                    found = (n, ci, m2); break
    n, ci, m2 = found; p = list(cell[n][1]); p[ci] = m2
    yield 'L7', f"node {n}: port {ci + 1} redirected to ancestor {m2}, of that colour but not adjacent", \
        mut(c['L7'], n, ports=p), n, 'not at unit distance'
    # L8: a sign pattern misread that stays INSIDE G481 (node 150: (0,-2,-2,0) read as (0,2,2,0)), so only the unit test can see it
    v = get('L8', 150)[2]; w = (v[0], -v[1], -v[2], v[3]); assert w in G481 and w != v
    yield 'L8', f"node 150: {v} read as {w} (still a vertex of G481)", mut(c['L8'], 150, v=w), 150, 'unit distance'

def run_plants():
    ok = True
    for t, desc, cells, n, phrase in plants():
        errs, _ = walk(t, cells)
        named = [e for e in errs if phrase in e and (n is None or f" {n}:" in e or f"node {n}" in e or f"branch {n}" in e)]
        # two-sided: refused (lower bound), and refused for the planted reason, not for scaffolding (upper bound: every
        # message is about the planted node, or a later node that names it, or the Table 2/3 counts the plant moved)
        stray = [e for e in errs if n is not None and str(n) not in e and not e.startswith('Table')]
        good = bool(errs) and bool(named) and not stray
        ok &= good
        print(f"plant {t:3s}: {'REFUSED, for the planted reason' if good else 'NOT CAUGHT AS PLANTED'} -- {desc}")
        for e in errs[:6]:
            print("        ", e)
    print("ALL PLANTS REFUSED" if ok else "A PLANT WAS NOT REFUSED AS PLANTED")
    return ok

def main(argv):
    if '--plant' in argv:
        return run_plants()
    names = [a for a in argv if not a.startswith('-')] or TREES
    allok = True
    for name in names:
        try:
            cells = read(name)
        except (ValueError, FileNotFoundError) as e:
            print(f"{name}: NOT WALKED: {e}"); allok = False; continue
        errs, info = walk(name, cells)
        if errs:
            allok = False
            print(f"{name}: REFUSED, {len(errs)} failures")
            for e in errs[:40]:
                print("   ", e)
        else:
            print(f"{name}: WALKS  (nodes, roots, ends, vertices, non-root) = {info['params']} = Table 2; Table 3 counts agree")
    print("ALL WALK" if allok else "NOT ALL WALK")
    return allok

if __name__ == '__main__':
    sys.exit(0 if main(sys.argv[1:]) else 1)
