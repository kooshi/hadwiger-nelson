"""Verifier 2: does (S') hold on the five-family graph?  Two exact checks.
(1) every Z-linear automorphism of L5 = <U5> permuting U5, and which family maps where;
(2) Parts's tree vertices (his coordinates (a + b sqrt33 + i c sqrt3 + i d sqrt11)/12) lie in L5, every tree edge is in U5, the root
    triple is in family 0, and eta^k * (tree vertices) lies in Lambda for |k| <= 2 with edges in families k-2..k+2.
"""
import glob, os, sys
from lat import *

U5 = {key: ULAM[key] for key in ULAM if abs(key[1]) <= 2}
fam = {v: key[1] for key, v in U5.items()}
vecs = list(U5.values())
B = [ULAM[(0, 0)], ULAM[(1, 0)], ULAM[(0, 1)], ULAM[(1, 1)]]   # 1, z, eta, z*eta : a Q-basis
Bi = inv([list(b) for b in B])
coef = {v: [sum(Fr(v[i]) * Bi[i][j] for i in range(4)) for j in range(4)] for v in vecs}
Uset = set(vecs)

def image(v, imgs):
    c = coef[v]
    out = [sum(c[j] * imgs[j][i] for j in range(4)) for i in range(4)]
    if all(x.denominator == 1 for x in out):
        return tuple(int(x) for x in out)
    return None

fam0 = [v for v in vecs if fam[v] == 0]
fam1 = [v for v in vecs if fam[v] == 1]
autos = []
for a in vecs:
    for b in vecs:
        if b == a: continue
        # family 0 lies in span(1, z): its image depends on a, b only
        ok = True
        for v in fam0:
            c = coef[v]; assert c[2] == 0 and c[3] == 0
            im = tuple(c[0] * a[i] + c[1] * b[i] for i in range(4))
            if not all(x.denominator == 1 for x in im) or tuple(int(x) for x in im) not in Uset:
                ok = False; break
        if not ok: continue
        for cc in vecs:
            for d in vecs:
                imgs = [a, b, cc, d]
                ims = [image(v, imgs) for v in vecs]
                if all(im is not None and im in Uset for im in ims) and len(set(ims)) == 30:
                    autos.append(imgs)
print("automorphisms of (L5, U5):", len(autos))
perms = set()
for imgs in autos:
    perm = tuple(fam[image(v, imgs)] for v in [ULAM[(0, k)] for k in range(-2, 3)])
    perms.add(perm)
print("induced permutations of families (-2..2) ->", sorted(perms))

# (2) Parts's trees
def parts_to_E(a, b, c, d):
    sqrt33 = scal(-1, mul(SQRTm3, SQRTm11))
    x = add(add(scal(a, ONE), scal(b, sqrt33)), add(scal(c, SQRTm3), scal(d, SQRTm11)))
    return scal(Fr(1, 12), x)

tree_dir = os.path.join(os.path.dirname(__file__), "..", "audit", "trees")
verts = set(); edges = set(); triples = []
for f in sorted(glob.glob(os.path.join(tree_dir, "*.txt"))):
    rows = {}
    for line in open(f):
        line = line.split("#")[0].split()
        if len(line) < 10: continue
        n = int(line[0]); ports = line[1:5]; a, b, c, d = map(int, line[5:9]); k = line[9]
        rows[n] = ((a, b, c, d), ports, k)
    for n, (co, ports, k) in rows.items():
        x = lam(parts_to_E(*co))
        assert x is not None, (f, n, co)
        verts.add(x)
        for p in ports:
            if p in ("-", "0"): continue
            m = int(p)
            y = lam(parts_to_E(*rows[m][0]))
            edges.add((x, y))
print("tree vertices", len(verts), "tree edges used", len(edges))
diffs = {tuple(a - b for a, b in zip(x, y)) for x, y in edges}
assert diffs <= Uset, "an edge outside U5"
print("every tree edge is a unit vector of U5; families used:", sorted({fam[d] for d in diffs}))
# every tree vertex in L5 = 3Z^4 (the component of 0)
print("every tree vertex in L5 (3Z^4):", all(all(c % 3 == 0 for c in x) for x in verts))
# the root triple: S's nodes 1,2,3 are (6,0,6,0), (6,0,-6,0), (-12,0,0,0) = z, z^-1, -1, family 0
for co in [(6, 0, 6, 0), (6, 0, -6, 0), (-12, 0, 0, 0)]:
    print("triple vertex", co, "->", [key for key, v in ULAM.items() if v == lam(parts_to_E(*co))])
# rotated copies eta^k * tree
for k in range(-2, 3):
    ek = power(ETA, k)
    rot = {x: lam(mul(ek, from_lam(x))) for x in verts}
    inlam = all(v is not None for v in rot.values())
    rdiffs = {tuple(a - b for a, b in zip(rot[x], rot[y])) for x, y in edges} if inlam else set()
    fams = sorted({key[1] for key, v in ULAM.items() if v in rdiffs})
    print(f"eta^{k} * tree in Lambda: {inlam}; edge families {fams}; all edges in U: {rdiffs <= set(ULAM.values())}")
