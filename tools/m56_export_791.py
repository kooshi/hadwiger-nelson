"""M56 B3: the 791-forcer rebuilt exactly through tools/construct.py — delete2(spindle(orbit(S, hex12), (0,0), (2,0))) —
and exported in tools/heule510.json's shape (names, denom, coords, edges, primes). The edge set is compared with
build/m30-forcer791.json's (the M30 rigidity record's vertex order) — equality is the vertex-order control."""
import sys, json
from fractions import Fraction as F
sys.path.insert(0, 'tools')
import construct as C
import field as Fld
sa = C.orbit(C.degrey_seed(), C.hex12())
sasb = C.spindle(sa, C.index_of(sa, 0, 0), C.index_of(sa, 2, 0))
y = C.delete(sasb, [C.index_of(sasb, F(1, 3), 0), C.index_of(sasb, F(-1, 3), 0)])
E = sorted(tuple(e) for e in y.edges())
m30 = json.load(open('build/m30-forcer791.json'))
E30 = sorted(tuple(e) for e in m30["edges"])
print(f"construct: {len(y)} points, {len(E)} unit edges, denom {y.denom}; m30 record: n={m30['n']}, edges={len(E30)}; edge sets equal: {E == E30}")
assert len(y) == 791 and E == E30, "vertex order / edge set mismatch with the M30 record"
json.dump(dict(names=[str(i) for i in range(len(y))], denom=y.denom, coords=[[list(p[0]), list(p[1])] for p in y.pts], edges=E, primes=Fld.PRIMES,
               note="delete2(spindle(orbit(S,hex12),(0,0),(2,0))) via tools/construct.py; vertex order = build/m30-forcer791.json's (edge sets equal)"),
          open('build/m56/forcer791-field16.json', 'w'))
print("wrote build/m56/forcer791-field16.json")
