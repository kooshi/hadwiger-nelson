"""KPer of the enumerated 4-periodic colourings of L21cc6506 (Hermite coordinates; quotient Lambda/4Lambda; voltages in 4Z^4)."""
import sys, itertools, time
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from pysat.solvers import Solver
from kper_additive import span_hnf, intersect, rank
M, d, N = 420, 167, 4
U = sorted(units_be(M, d)); H = [[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
UC = [tuple(coords_in(H, u)) for u in U]
verts = list(itertools.product(range(N), repeat=4)); vid = {v: i for i, v in enumerate(verts)}
var = lambda v, c: 4*v + c + 1
cls = [[var(v, c) for c in range(4)] for v in range(len(verts))]
for v in range(len(verts)):
    for c1 in range(4):
        for c2 in range(c1+1, 4): cls.append([-var(v,c1), -var(v,c2)])
gens = sorted({tuple(x % N for x in c) for c in UC})
for vv in verts:
    for g in gens:
        w = tuple((a+b) % N for a, b in zip(vv, g)); i, j = vid[vv], vid[w]
        if i < j:
            for c in range(4): cls.append([-var(i, c), -var(j, c)])
cls += [[var(0, 0)], [var(vid[gens[0]], 1)]]
s = Solver(name='cadical153', bootstrap_with=cls)
def kper(col):
    tot = None
    for p in range(4):
        for q in range(p+1, 4):
            seen = {}
            for y0 in range(len(verts)):
                if col[y0] not in (p, q) or y0 in seen: continue
                seen[y0] = verts[y0]; stack = [y0]; volts = []
                while stack:
                    y = stack.pop(); ly = seen[y]
                    for u in UC:
                        z = vid[tuple((a+b) % N for a, b in zip(verts[y], u))]
                        if col[z] not in (p, q): continue
                        lz = tuple(a+b for a, b in zip(ly, u))
                        if z in seen:
                            v = tuple(a-b for a, b in zip(lz, seen[z]))
                            if any(v): volts.append(v)
                        else:
                            seen[z] = lz; stack.append(z)
                V = [list(x) for x in span_hnf(volts)] if volts else []
                tot = V if tot is None else intersect(tot, V)
                if not tot or rank(tot) < 4: return tot
    return tot
import collections
ranks = collections.Counter(); inter = None; n = 0; t = time.time()
while n < int(sys.argv[1]) and s.solve():
    m = s.get_model(); col = [next(c for c in range(4) if m[var(v,c)-1] > 0) for v in range(len(verts))]
    s.add_clause([-var(v, col[v]) for v in range(len(verts))]); n += 1
    K = kper(col); r = rank(K) if K else 0; ranks[r] += 1
    if r == 4: inter = K if inter is None else intersect(inter, K)
    if r < 4:
        print('colouring', n, 'has KPer of rank', r, flush=True)
        break
print('colourings examined', n, 'KPer ranks', dict(ranks), 'intersection of full-rank KPers: rank', rank(inter) if inter else None,
      'det', abs(__import__('sympy').Matrix(inter).det()) if inter and rank(inter) == 4 else None, f'{time.time()-t:.0f}s')
