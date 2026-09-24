#!/usr/bin/env python3
"""Run heights_edge.analyse on de Grey's lattice and on saturated lattices over Q(sqrt167).  Uses tools/fs73_lattice (read-only)."""
import sys, time
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
import fs73_lattice as L
from heights_edge import analyse, sym

def run_degrey():
    lat = L.degrey()
    U = lat.saturate('trace')
    print('degrey rank', lat.rank, '|U|', len(U))
    print(analyse(sym(U), 'de Grey lattice'))

def run_167(M):
    F = L.Field((167,))
    pts = [(v, M) for v in L.units_over(F, M)]
    lat = L.Lattice(F, pts, f'L{M}', M=M)
    U = lat.saturate('box')
    print(f'Lambda_{M} rank', lat.rank, '|U|', len(U), '(box count', len(pts), ')')
    t = time.time()
    print(analyse(sym(U), f'Lambda_{M} over Q(sqrt167)'), f'{time.time()-t:.1f}s')

if __name__ == '__main__':
    if '--degrey' in sys.argv: run_degrey()
    for M in [int(x) for x in sys.argv[1:] if x.isdigit()]:
        run_167(M)
