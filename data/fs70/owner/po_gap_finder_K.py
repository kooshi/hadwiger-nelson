#!/usr/bin/env python3
"""Owner's falsification control of phase 1d's fan-gap screen, asked the HARD way (FS-70, 2026-09-22).

On de Grey's K-lattice <zeta6^m rho^n : |n| <= 2> over K = Q(sqrt3, sqrt11), Harder's pair (0, 8/3) is forced at four
colours (in print, 2018; reproduced by phase 1d on a 23,083-point word ball).  By row 66 a GAPPED proper four-colouring of
Cay(Lambda/N Lambda, U mod N) would make every pair free on every graph in the lattice -- so none can exist, at any N.  Phase
1d's screen found six gap-free colourings there and read that as the control passing.  This script aims a FINDER at a gapped
colouring: it adds the clause set "colour 3 is absent from the closed neighbourhood of the origin" (WLOG by translation and colour
symmetry) and asks the solver.  UNSAT at every admissible N is what the theorem requires; a SAT here would refute the theorem,
the homomorphism, or my lattice -- and would be the finding.  The K arithmetic and the 54 unit vectors are my own
(po_kempe_control_K.py, radicand 11).  Usage: po_gap_finder_K.py NMAX [--plant]  (the plant asks the same finder on a lattice
where a gapped colouring DOES exist -- phase 1d's L1 transposition over Q(sqrt3,sqrt5) at N = 5 -- and must return SAT)."""
import sys, itertools, time
sys.path.insert(0, 'data/fs70/owner')
from pysat.solvers import Solver
NMAX = int(sys.argv[1]) if len(sys.argv) > 1 else 8
PLANT = '--plant' in sys.argv

def gapped_colouring_exists(rank, S, N, budget_note=''):
    """Cay((Z/N)^rank, S): is there a proper 4-colouring with colour 3 absent from N[0]?  Returns (verdict, seconds, nvert)."""
    Smod = sorted({tuple(x % N for x in s) for s in S})
    if tuple([0] * rank) in Smod: return ('loop', 0.0, N ** rank)
    verts = list(itertools.product(range(N), repeat=rank)); vidx = {v: i for i, v in enumerate(verts)}
    n = len(verts)
    var = lambda v, c: 4 * v + c + 1
    s = Solver(name='cadical195')
    for v in range(n):
        s.add_clause([var(v, c) for c in range(4)])
        for c1 in range(4):
            for c2 in range(c1 + 1, 4): s.add_clause([-var(v, c1), -var(v, c2)])
    edges = 0
    for v in verts:
        i = vidx[v]
        for sm in Smod:
            j = vidx[tuple((a + b) % N for a, b in zip(v, sm))]
            if i < j:
                edges += 1
                for c in range(4): s.add_clause([-var(i, c), -var(j, c)])
    # the gap: colour 3 absent from the closed neighbourhood of the origin (translation + colour symmetry make this WLOG)
    o = vidx[tuple([0] * rank)]
    s.add_clause([-var(o, 3)])
    for sm in Smod: s.add_clause([-var(vidx[sm], 3)])
    # symmetry: the origin takes colour 0 (colours 0,1,2 are still interchangeable under the gap clause; pin one)
    s.add_clause([var(o, 0)])
    t = time.time(); ok = s.solve(); secs = time.time() - t
    if ok:
        model = set(l for l in s.get_model() if l > 0)
        col = [next(c for c in range(4) if var(v, c) in model) for v in range(n)]
        bad = sum(1 for v in verts for sm in Smod if col[vidx[v]] == col[vidx[tuple((a + b) % N for a, b in zip(v, sm))]])
        closed = {col[o]} | {col[vidx[sm]] for sm in Smod}
        assert bad == 0 and 3 not in closed, "solver model does not satisfy what was asked"
    s.delete()
    return ('SAT (gapped colouring found)' if ok else 'UNSAT (no gapped colouring)', secs, n)

if PLANT:
    # L1 over Q(sqrt3,sqrt5): group6:u3:2 -- phase 1d found 50 gapped vertices at N = 5; my finder must find one too
    sys.argv = ['po_cm_lattice.py', '2']
    import po_cm_lattice as C   # runs its screen on import (prints); we take its lattice
    S = C.LU if hasattr(C, 'LU') else None
    rank = C.rank
    print(f"PLANT lattice: L1 = <zeta6, u^(+-1,+-2)> over Q(sqrt3,sqrt5), rank {rank}, g {len(S)}")
    v, secs, n = gapped_colouring_exists(rank, S, 5)
    print(f"  N = 5: {n} vertices -> {v} in {secs:.1f} s   [expected SAT: phase 1d reports 50 gapped vertices]")
    sys.exit(0)

import po_kempe_control_K as K   # prints its own control on import; we use its lattice: rank, LU (unit vectors in HNF coordinates)
S = K.LU; rank = K.rank
print(f"\nde Grey's K-lattice: rank {rank}, unit vectors {len(S)}; asking for a GAPPED four-colouring of the quotient at N = 2..{NMAX}")
for N in range(2, NMAX + 1):
    v, secs, n = gapped_colouring_exists(rank, S, N)
    print(f"  N = {N:2d}: {n:6d} vertices -> {v} in {secs:.1f} s")
