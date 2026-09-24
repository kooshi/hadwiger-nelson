"""FS-85 input audit, task A2: Parts's root case split ([Parts2020hv] section 4, Table 1) against the trees' roots.

The 13-vertex 2-Golomb graph H (Fig. 5 numbering, coordinates as Parts's trees give them), its edges computed exactly,
Table 1's 36 root colourings R_ab transcribed, and for each R_ab the EXHIBITED symmetry that carries it onto the root of
the tree Table 1 assigns it.  Nothing is searched: the symmetries are the ones the hand proof in plans/FS85-input-audit.md
(A2) names, computed from their rule; this script only checks them.

That the 36 exhaust the proper colourings of H with a monochromatic triple {2,3,4} is the hand proof (A2, Lemma G); this
script does not enumerate colourings (the finite-witness-free week).  It checks: every R_ab is a proper colouring of H with
the triple monochromatic; every symmetry used is induced on H by an automorphism of G481 that preserves {2,3,4}; and each
R_ab, so transformed, restricts to the root colouring read from Table 4 (data/fs85/audit/trees/*.txt).
Run:  python3 golomb.py            python3 golomb.py --plant
"""
import sys
from walk_trees import unit, rot60, gal, read, G481

H = {1: (0, 0, 0, 0), 2: (6, 0, 6, 0), 3: (6, 0, -6, 0), 4: (-12, 0, 0, 0), 5: (-6, 0, -6, 0), 6: (-6, 0, 6, 0),
     7: (12, 0, 0, 0), 8: (1, 1, 1, -1), 9: (1, -1, -1, -1), 10: (-2, 0, 0, 2), 11: (-1, -1, -1, 1), 12: (-1, 1, 1, 1),
     13: (2, 0, 0, -2)}
IDX = {v: i for i, v in H.items()}
EDGES = [(i, j) for i in H for j in H if i < j and unit(H[i], H[j])]

# Table 1, as printed (page 11): R_a on vertices 1..10, and the colours of 11..13 for each b (R12 and R17 differ).
RA = {1: '4111222234', 2: '4111223234', 3: '4111223342', 4: '4111223423'}
RB = ['132', '134', '142', '312', '314', '341', '342', '412', '431', '432']
EXCEPT = {(1, 2): '143', (1, 7): '413'}
TABLE1 = {  # (a, b) -> the tree Table 1 names; '-' = no such colouring (row 1 only)
    (1, 0): '-', (1, 1): 'S', (1, 2): 'L1', (1, 3): '-', (1, 4): 'S', (1, 5): 'L2', (1, 6): '-', (1, 7): 'L2', (1, 8): 'S',
    (1, 9): '-',
    (2, 0): 'S', (2, 1): 'S', (2, 2): 'L3', (2, 3): 'L4', (2, 4): 'L4', (2, 5): 'L4', (2, 6): 'L4', (2, 7): 'L5',
    (2, 8): 'S', (2, 9): 'S',
    (3, 0): 'S', (3, 1): 'L6', (3, 2): 'S', (3, 3): 'S', (3, 4): 'S', (3, 5): 'S', (3, 6): 'S', (3, 7): 'S', (3, 8): 'L7',
    (3, 9): 'S'}
TABLE1.update({(4, b): 'L8' for b in range(10)})


def R(a, b):
    s = RA[a] + EXCEPT.get((a, b), RB[b])
    return {i + 1: int(ch) for i, ch in enumerate(s)}


def proper(c):
    return all(c[i] != c[j] for i, j in EDGES if i in c and j in c)


# ---- symmetries: automorphisms of G481 (the order-24 group), read as permutations of H's indices
def perm_of(f):
    """The permutation of H's indices induced by the coordinate map f; refuses if f does not preserve H."""
    p = {}
    for i, v in H.items():
        w = f(v)
        assert w in IDX, ("map does not preserve H", i, v, w)
        p[i] = IDX[w]
    return p


def rot(k):
    def f(v):
        for _ in range(k % 6):
            v = rot60(v)
        return v
    return f


R60, R120, R240, GAL = perm_of(rot(1)), perm_of(rot(2)), perm_of(rot(4)), perm_of(gal)
ID = {i: i for i in H}
for f in (rot(1), gal):  # each is an automorphism of G481 (maps G481 onto itself)
    assert all(f(p) in G481 for p in G481)


def pull(c, s):
    """The colouring c o s (vertex v gets the colour c gave s(v))."""
    return {v: c[s[v]] for v in c}


def recolour(c, pi):
    return {v: pi[c[v]] for v in c}


# ---- the tree roots, as read from Table 4 (A1's transcriptions), in H's numbering
def root_of(tree):
    out = {}
    for n, ports, v, k in read(tree):
        if 0 in ports:
            assert v in IDX, (tree, n, v, "root vertex not in H")
            out[IDX[v]] = [i + 1 for i, p in enumerate(ports) if p is None][0]
    return out


# ---- the exhibited reduction of each R_ab (the hand proof's step 4)
MONO_PAIRS = [(10, 13), (8, 11), (9, 12)]


def reduce_to_S(c):
    """A colouring with a monochromatic opposite pair (x, -x), x in {8,9,10}: rotate it to (10,13), then recolour the
    inner triangle to (2,3,4).  Returns (sigma name, sigma, pi) or None if no pair is monochromatic."""
    for x, y in MONO_PAIRS:
        if c[x] == c[y]:
            # the rotation by 0, 120 or 240 degrees whose pull-back puts x at 10 (and so -x at 13)
            for name, s in (('id', ID), ('rot120', R120), ('rot240', R240)):
                if s[10] == x:
                    assert s[13] == y and {s[2], s[3], s[4]} == {2, 3, 4}
                    d = pull(c, s)
                    pi = {1: 1, d[8]: 2, d[9]: 3, d[10]: 4}
                    return name, s, pi
    return None


def main(plant=False):
    ok = True
    print("H: 13 vertices,", len(EDGES), "edges:", EDGES)
    roots = {t: root_of(t) for t in ('S', 'L1', 'L2', 'L3', 'L4', 'L5', 'L6', 'L7', 'L8')}
    if plant:  # a misread root: L6's vertex 13 read as colour 3 instead of 4
        roots['L6'][13] = 3
    for t, r in roots.items():
        print(f"  root of {t}: " + ' '.join(f"{v}:{r[v]}" for v in sorted(r)))
    mono_count = 0
    for (a, b), tree in sorted(TABLE1.items()):
        if tree == '-':
            continue
        c = R(a, b)
        tag = f"R{a}{b} = {RA[a][0]} {RA[a][1:4]} {RA[a][4:7]} {RA[a][7:]} {EXCEPT.get((a, b), RB[b])}"
        if not proper(c) or not (c[2] == c[3] == c[4]):
            print(f"{tag}: NOT a proper colouring of H with the triple monochromatic"); ok = False; continue
        red = reduce_to_S(c)
        mono_count += red is not None
        if tree == 'S':
            if red is None:
                print(f"{tag} -> S: no monochromatic opposite pair, so S's root is not reached"); ok = False; continue
            name, s, pi = red
            d = recolour(pull(c, s), pi)
            how = f"pull back by {name}, colours {pi}"
        elif (a, b) == (1, 5):   # R15 -> R17 by Parts's isomorphism: rotation by pi/3 and colours (1 2)
            d = recolour(pull(c, perm_of(rot(-1))), {1: 2, 2: 1, 3: 3, 4: 4})
            assert d == R(1, 7), "R15 is not carried onto R17"
            how = "pull back by rot(-60), colours (1 2): = R17"
        else:
            d, how = c, "as is"
        r = roots[tree]
        agree = all(d[v] == r[v] for v in r)
        ok &= agree
        print(f"{tag} -> {tree:2s} ({how}): {'restricts to the root' if agree else 'DOES NOT restrict to the root'}"
              + ("   [mono opposite pair]" if red else ""))
    print("colourings with a monochromatic opposite pair:", mono_count, "(Parts: 19)")
    ok &= mono_count == 19
    print("ALL 36 CASES REACH THEIR TREE'S ROOT" if ok else "NOT ALL CASES REACH THEIR TREE'S ROOT")
    return ok


if __name__ == '__main__':
    plant = '--plant' in sys.argv
    good = main(plant)
    if plant:
        print("plant refused" if not good else "PLANT NOT REFUSED")
        sys.exit(0 if not good else 1)
    sys.exit(0 if good else 1)
