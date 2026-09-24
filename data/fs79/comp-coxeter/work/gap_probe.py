"""Check of reading C6: does L21cc6506 have a GAPPED periodic 4-colouring on a small quotient Lambda/N Lambda?  (A gap frees every
pair, row 66, so it would kill the reading.)  Quotient graph Cay(Lambda/N Lambda, U mod N) in Hermite coordinates; pysat, capped."""
import sys, itertools, time
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from pysat.solvers import Solver
M, d = 420, 167
U = sorted(units_be(M, d)); H = [[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
UC = [tuple(coords_in(H, u)) for u in U]
for N in range(2, 9):
    gens = sorted({tuple(x % N for x in c) for c in UC})
    if (0,0,0,0) in gens: print('N', N, 'inadmissible'); continue
    verts = list(itertools.product(range(N), repeat=4)); vid = {v: i for i, v in enumerate(verts)}
    var = lambda v, c: 4*v + c + 1
    cls = []
    for v in range(len(verts)):
        cls.append([var(v, c) for c in range(4)])
    for vv in verts:
        for g in gens:
            w = tuple((a+b) % N for a, b in zip(vv, g))
            i, j = vid[vv], vid[w]
            if i < j:
                for c in range(4): cls.append([-var(i, c), -var(j, c)])
    cls.append([var(0, 0)])
    # gap at the origin: colour 3 absent from the closed neighbourhood of 0 (origin coloured 0)
    nb = [vid[g] for g in gens]
    gap = [[-var(j, 3)] for j in nb]
    for name, extra in (('gapped', gap), ('plain', [])):
        s = Solver(name='cadical153', bootstrap_with=cls + extra)
        t = time.time(); r = s.solve(); dt = time.time() - t
        print('N', N, 'vertices', len(verts), 'gens mod N', len(gens), name, 'SAT' if r else 'UNSAT', f'{dt:.1f}s', flush=True)
        s.delete()
        if name == 'gapped' and r: break
