"""Count 4-colourings of Cay(Lambda/N Lambda, U) for L21cc6506 at N = 4, 8 (origin 0, first generator's image 1; enumeration by blocking
clauses on the full assignment, capped).  A check of reading C6."""
import sys, itertools, time
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from pysat.solvers import Solver
M, d = 420, 167
U = sorted(units_be(M, d)); H = [[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
UC = [tuple(coords_in(H, u)) for u in U]
CAP = int(sys.argv[2]) if len(sys.argv) > 2 else 5000
for N in [int(sys.argv[1])]:
    gens = sorted({tuple(x % N for x in c) for c in UC})
    verts = list(itertools.product(range(N), repeat=4)); vid = {v: i for i, v in enumerate(verts)}
    var = lambda v, c: 4*v + c + 1
    cls = [[var(v, c) for c in range(4)] for v in range(len(verts))]
    for v in range(len(verts)):
        for c1 in range(4):
            for c2 in range(c1+1, 4): cls.append([-var(v,c1), -var(v,c2)])
    for vv in verts:
        for g in gens:
            w = tuple((a+b) % N for a, b in zip(vv, g)); i, j = vid[vv], vid[w]
            if i < j:
                for c in range(4): cls.append([-var(i, c), -var(j, c)])
    g0 = vid[gens[0]]
    cls += [[var(0, 0)], [var(g0, 1)]]
    s = Solver(name='cadical153', bootstrap_with=cls)
    n = 0; t = time.time(); sols = []
    while n < CAP and s.solve():
        m = s.get_model(); col = [next(c for c in range(4) if m[var(v,c)-1] > 0) for v in range(len(verts))]
        sols.append(col); n += 1
        s.add_clause([-var(v, col[v]) for v in range(len(verts))])
    print('N', N, 'colourings with origin 0 and gens[0] 1:', n, '(capped)' if n >= CAP else '(complete)', f'{time.time()-t:.1f}s')
    # classify: additive (colour determined by a hom to Z/4 or V4 up to relabelling)? count distinct period groups sizes
    import collections
    def per_size(col):
        cnt = 0
        for tv in verts:
            if all(col[vid[tuple((a+b)%N for a,b in zip(v,tv))]] == col[vid[v]] for v in verts): cnt += 1
        return cnt
    if n <= 400:
        print('period-group sizes (|Per/N Lambda|):', collections.Counter(per_size(c) for c in sols))
