"""Poros's question on L21cc6506: which locally proper square and cube patterns occur in actual (periodic) 4-colourings?
Square orbit types under Sym(4): abab, abac (monochromatic s+t diagonal), abcb (monochromatic s-t diagonal), abcd.
Cube: does any monopole (antipodal) pattern occur, for any triple?"""
import sys, itertools, time, collections
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from pysat.solvers import Solver
M, d = 420, 167
U = sorted(units_be(M, d)); H = [[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
UC = [tuple(coords_in(H, u)) for u in U]
reps = sorted({min(u, tuple(-x for x in u)) for u in UC})
def colourings(N, cap):
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
    cls += [[var(0, 0)]]
    s = Solver(name='cadical153', bootstrap_with=cls); out = []
    while len(out) < cap and s.solve():
        m = s.get_model(); col = [next(c for c in range(4) if m[var(v,c)-1] > 0) for v in range(len(verts))]
        s.add_clause([-var(v, col[v]) for v in range(len(verts))])
        out.append(col)
    return verts, vid, out
def sqtype(a, b, c, dd):
    if a == c and b == dd: return 'abab'
    if a == c: return 'abac'
    if b == dd: return 'abcb'
    return 'abcd'
if __name__ == '__main__':
  for N, cap in ((4, 3000), (8, 300)):
    t = time.time()
    verts, vid, cols = colourings(N, cap)
    sh = lambda v, u: vid[tuple((a+b) % N for a, b in zip(v, u))]
    missing_sq = collections.Counter(); seen_types = collections.defaultdict(set)
    for (i, s_), (j, t_) in itertools.combinations(enumerate(reps), 2):
        for col in cols:
            for v in verts:
                x = vid[v]; xs = sh(v, s_); xst = vid[tuple((a+b+c) % N for a, b, c in zip(v, s_, t_))]; xt = sh(v, t_)
                seen_types[(i, j)].add(sqtype(col[x], col[xs], col[xst], col[xt]))
            if len(seen_types[(i, j)]) == 4: break
        for ty in ('abab', 'abac', 'abcb', 'abcd'):
            if ty not in seen_types[(i, j)]: missing_sq[ty] += 1
    print(f'N={N}: {len(cols)} colourings; pairs={len(seen_types)}; pairs missing a square type: {dict(missing_sq)}  ({time.time()-t:.0f}s)', flush=True)
    # monopoles
    mono = 0; tri_with_mono = 0
    for s_, t_, u_ in itertools.combinations(reps, 3):
        found = False
        for col in cols:
            for v in verts:
                P = lambda *g: vid[tuple((sum(z) ) % N for z in zip(v, *g))] if g else vid[v]
                x = vid[v]
                pairs = [(x, P(s_, t_, u_)), (P(s_), P(t_, u_)), (P(t_), P(s_, u_)), (P(u_), P(s_, t_))]
                if all(col[a] == col[b] for a, b in pairs) and len({col[x], col[P(s_, t_)], col[P(s_, u_)], col[P(t_, u_)]}) == 4:
                    found = True; break
            if found: break
        tri_with_mono += found
    print(f'N={N}: triples with a monopole in some colouring: {tri_with_mono} of {len(list(itertools.combinations(reps, 3)))}', flush=True)
