#!/usr/bin/env python3
"""FS114-N: exact check of the Euler identities route T uses, on torus maps given by formula (no search, no enumeration).

For a map on the torus (cellular: every face a disc) with vertex degrees d(v), face lengths s(f), and map-graph degrees
deg_M(f) = #{faces g != f whose closures meet f's closure}:
  (E0)  V - E + F = 0
  (E1)  sum_f (s(f) - 6) + sum_v (2 d(v) - 6) = 0                         [Euler with 2E = sum d = sum s]
  (E2)  sum_f (deg_M(f) - 6) = sum_v (d(v) - 2)(d(v) - 3)                   [when no two faces meet in two places and no
                                                                             face meets itself: deg_M(f) = s(f) + sum_{v in f}(d(v) - 3)]
  (E3)  sum_f (deg_M(f) - (k - 1)) = (7 - k) F + sum_v (d - 2)(d - 3)        [the rainbow deficit at k colours; E2 rewritten]
The maps (each by formula, on an n-by-n or W-by-N torus): the square grid; the honeycomb (as bricks); the triangular lattice
(the square grid with every diagonal); the square grid with alternate diagonals (degrees 4 and 6 mixed); the prismatic
pentagonal tiling (every face a pentagon, vertices of degree 3 and 4: Sirgedas's case, C114-DUAL-COUNT).
The hypothesis of E2 (faces meet at most once, never themselves) is CHECKED per map and printed, never assumed.

Run:   python3 tools/fs114_n_count.py           exit 0 iff every identity holds on every map
       python3 tools/fs114_n_count.py --plant   the planted fault: deg_M from edge-adjacency only (vertex-only neighbours dropped);
                                                E2 must FAIL on every map with a vertex of degree >= 4 and HOLD on the honeycomb (cubic)
"""
import sys
from collections import defaultdict
from fractions import Fraction

def square(n):
    V = lambda i, j: (i % n, j % n)
    return [[V(i, j), V(i + 1, j), V(i + 1, j + 1), V(i, j + 1)] for i in range(n) for j in range(n)]

def honeycomb(n):  # bricks: n even; each face covers squares (i,j),(i+1,j) with i+j even
    assert n % 2 == 0
    V = lambda i, j: (i % n, j % n)
    return [[V(i, j), V(i + 1, j), V(i + 2, j), V(i + 2, j + 1), V(i + 1, j + 1), V(i, j + 1)]
            for j in range(n) for i in range(n) if (i + j) % 2 == 0]

def triangular(n):
    V = lambda i, j: (i % n, j % n)
    out = []
    for i in range(n):
        for j in range(n):
            out.append([V(i, j), V(i + 1, j), V(i + 1, j + 1)])
            out.append([V(i, j), V(i + 1, j + 1), V(i, j + 1)])
    return out

def alt_diagonals(n):  # diagonal (i,j)-(i+1,j+1) in squares with i+j even; n even
    assert n % 2 == 0
    V = lambda i, j: (i % n, j % n)
    out = []
    for i in range(n):
        for j in range(n):
            if (i + j) % 2 == 0:
                out.append([V(i, j), V(i + 1, j), V(i + 1, j + 1)])
                out.append([V(i, j), V(i + 1, j + 1), V(i, j + 1)])
            else:
                out.append([V(i, j), V(i + 1, j), V(i + 1, j + 1), V(i, j + 1)])
    return out

def prismatic_pentagonal(W, N):
    """Strips s = 0..N-1 (N even); x in half-units mod 2W; strip s shifted by s half-units.
    Levels: 0 = base (y = 0), 1 = eave (y = 1), 2 = apex (y = 3/2); the top of strip s is the base of strip s + 1."""
    assert N % 2 == 0
    def V(X, s, lev):
        s2 = s % N
        return (X % (2 * W), s2, lev)
    out = []
    for s in range(N):
        o = s
        for i in range(W):
            X = 2 * i + o
            out.append([V(X, s, 0), V(X + 2, s, 0), V(X + 2, s, 1), V(X + 1, s, 2), V(X, s, 1)])            # up-house
            k = i
            out.append([V(2*k - 1 + o, s + 1, 0), V(2*k + 1 + o, s + 1, 0), V(2*k + 1 + o, s, 2),           # down-house
                        V(2*k + o, s, 1), V(2*k - 1 + o, s, 2)])
    return out

def analyse(faces, edge_only=False):
    edges = set()
    vdeg = defaultdict(int)
    vfaces = defaultdict(list)
    for fi, f in enumerate(faces):
        assert len(set(f)) == len(f), "a face meets itself at a vertex"
        for a, b in zip(f, f[1:] + f[:1]):
            edges.add(frozenset((a, b)))
        for v in f:
            vfaces[v].append(fi)
    for e in edges:
        for v in e:
            vdeg[v] += 1
    V, E, F = len(vdeg), len(edges), len(faces)
    # faces meeting: through a shared vertex; edge-adjacency: through a shared edge
    fedges = [set(frozenset((a, b)) for a, b in zip(f, f[1:] + f[:1])) for f in faces]
    efaces = defaultdict(list)
    for fi, es in enumerate(fedges):
        for e in es:
            efaces[e].append(fi)
    degM = []
    multi = 0
    for fi, f in enumerate(faces):
        if edge_only:
            nb = set(g for e in fedges[fi] for g in efaces[e] if g != fi)
        else:
            touch = defaultdict(int)
            for v in f:
                for g in vfaces[v]:
                    if g != fi:
                        touch[g] += 1
            nb = set(touch)
            # "meet once": a neighbour sharing exactly one edge touches in 2 vertices; one sharing no edge in 1 vertex
            for g, t in touch.items():
                shared_edges = len(fedges[fi] & fedges[g])
                if not ((shared_edges == 1 and t == 2) or (shared_edges == 0 and t == 1)):
                    multi += 1
        degM.append(len(nb))
    s = [len(f) for f in faces]
    d = list(vdeg.values())
    E0 = V - E + F == 0
    E1 = sum(x - 6 for x in s) + sum(2 * x - 6 for x in d) == 0
    lhs2 = sum(x - 6 for x in degM)
    rhs2 = sum((x - 2) * (x - 3) for x in d)
    E2 = lhs2 == rhs2
    return dict(V=V, E=E, F=F, E0=E0, E1=E1, E2=E2, lhs2=lhs2, rhs2=rhs2, multi=multi,
                degs=sorted(set(d)), svals=sorted(set(s)), degM=sorted(set(degM)), sumDegM=sum(degM),
                V3=sum(1 for x in d if x == 3), V4=sum(1 for x in d if x == 4))

MAPS = [("square grid 8x8", square(8)), ("honeycomb (bricks) 8x8", honeycomb(8)), ("triangular 8x8", triangular(8)),
        ("square + alternate diagonals 8x8", alt_diagonals(8)), ("prismatic pentagonal 6x4", prismatic_pentagonal(6, 4))]

def main():
    if "--plant" in sys.argv:
        ok = True
        for name, faces in MAPS:
            r = analyse(faces, edge_only=True)
            cubic = r["degs"] == [3]
            expect = r["E2"] if cubic else not r["E2"]
            ok &= expect
            print(f"{name}: E2 with deg_M from edges only: {'holds' if r['E2'] else 'FAILS'} "
                  f"({r['lhs2']} vs {r['rhs2']}); expected {'hold (cubic)' if cubic else 'FAIL'}: {'as expected' if expect else 'NOT AS EXPECTED'}")
        print("PLANT FIRES FOR ITS OWN REASON" if ok else "PLANT DID NOT BEHAVE")
        sys.exit(0 if ok else 1)
    allok = True
    for name, faces in MAPS:
        r = analyse(faces)
        ok = r["E0"] and r["E1"] and r["E2"] and r["multi"] == 0
        allok &= ok
        F = r["F"]
        line = (f"{name}: V={r['V']} E={r['E']} F={F} d={r['degs']} s={r['svals']} deg_M={r['degM']} "
                f"E0={r['E0']} E1={r['E1']} E2={r['E2']} ({r['lhs2']} = {r['rhs2']}) multiplicities={r['multi']}")
        # E3 at k = 6 and k = 5: the rainbow deficit and its share of E (the 'curved edge' fraction if every repeat were a distinct edge)
        for k in (6, 5):
            deficit = r["sumDegM"] - (k - 1) * F
            line += f" | k={k}: deficit {deficit} = {Fraction(deficit, F)} F, deficit/E = {Fraction(deficit, r['E'])}"
        print(line)
        if name.startswith("prismatic"):
            print(f"   Sirgedas's case: V3 = {r['V3']} (F = {F}), V4 = {r['V4']} (F/2 = {Fraction(F, 2)}); "
                  f"k=6 deficit/E = {Fraction(r['sumDegM'] - 5 * F, r['E'])} (his '80%')")
        if name.startswith("square grid"):
            print(f"   Sirgedas's five-colour case: k=5 deficit/E = {Fraction(r['sumDegM'] - 4 * F, r['E'])} (his '200%')")
    print("ALL IDENTITIES HOLD" if allok else "AN IDENTITY FAILED")
    sys.exit(0 if allok else 1)

if __name__ == "__main__":
    main()
