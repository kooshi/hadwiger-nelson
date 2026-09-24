"""C3b: G481 re-transcribed BY EYE from the rendered page 15 of [Parts2020hv] (Table 3), rebuilt from its orbits, checked exactly."""
from field import *
from lattice import *
import sys
# (a,b,c,d), radii text, degree, orbit order -- my reading of the rendered table (p15-15.png)
T3 = [((0,0,0,0),30,1),((0,0,4,0),24,6),((12,0,0,0),23,6),((0,0,8,0),18,6),((0,0,12,0),8,6),
      ((6,2,0,0),15,12),((2,0,0,2),20,12),((10,0,0,2),16,12),((0,2,2,0),22,12),((4,0,0,4),11,12),((14,0,0,2),8,12),
      ((0,2,6,0),12,12),((8,0,0,4),10,12),((6,0,0,6),6,12),((0,2,10,0),8,12),
      ((2,0,4,2),15,24),((12,2,2,0),13,24),((2,0,6,4),8,24),((4,0,2,2),16,24),((4,0,6,2),12,24),((4,0,4,4),7,24),
      ((8,0,2,2),12,24),((8,0,6,2),10,24),((6,2,4,0),15,24),((2,0,2,4),9,24),((10,0,4,2),9,24),((8,0,4,4),8,24),
      ((12,2,6,0),8,24),((6,2,8,0),9,24)]
if sys.argv[1:] == ['plant']:           # planted transcription error: (4,0,2,2) read as (4,0,2,6)
    T3 = [((4,0,2,6),16,24) if r[0] == (4,0,2,2) else r for r in T3]
SQ33 = neg(mul(SQ3, SQ11))              # sqrt33 = -sqrt(-3)sqrt(-11); i sqrt3 = sqrt(-3); i sqrt11 = sqrt(-11)
def pt(a,b,c,d):
    assert (a - b + c + d) % 4 == 0
    return smul(Fr(1,12), add(add(E(a), smul(b, SQ33)), add(smul(c, SQ3), smul(d, SQ11))))
z = ZETA
def galois_sigma(x): return (x[0], -x[1], x[2], -x[3])   # sqrt(-3) -> -sqrt(-3), sqrt(-11) fixed (b,c sign flip)
pts = {}; orbit_of = {}
for rep, deg, order in T3:
    x0 = pt(*rep)
    orb = set()
    for s in (False, True):
        y = galois_sigma(x0) if s else x0
        for cj in (False, True):
            y2 = conj(y) if cj else y
            for j in range(6):
                orb.add(mul(power(z, j), y2))
    assert len(orb) == order, (rep, len(orb), order)
    for p in orb:
        assert p not in pts, ("orbits overlap", rep)
        pts[p] = rep
if __name__ == "__main__": print("points:", len(pts))
def is_unit(v): return norm_rel(v) == ONE
if __name__ == "__main__":
    P = list(pts)
    U = {mul(power(z,a), power(ETA,b)) for a in range(6) for b in range(-4,5)}
    def is_unit(v): return norm_rel(v) == ONE
    deg = {p: 0 for p in P}; edges = []
    for i in range(len(P)):
        for j in range(i+1, len(P)):
            d = sub(P[i], P[j])
            if is_unit(d):
                deg[P[i]] += 1; deg[P[j]] += 1; edges.append((P[i], P[j]))
    print("edges:", len(edges), "; every edge difference in U:", all(sub(p,q) in U for p, q in edges))
    bad = [(rep, want, sorted({deg[p] for p in pts if pts[p] == rep})) for rep, want, _ in T3
           if {deg[p] for p in pts if pts[p] == rep} != {want}]
    print("orbits whose rebuilt degree differs from Table 3's 'vertex degree':", bad if bad else "none")
    for k in range(-4, 5):
        out = sum(1 for p in P if not in_Lambda(mul(power(ETA, k), p)))
        print(f"  eta^{k} * G481: points outside Lambda = {out}")
