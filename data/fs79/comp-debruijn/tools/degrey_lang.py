#!/usr/bin/env python3
"""Load de Grey's 380 pinned colourings of Lambda/8Lambda (FS-73 census), infer the index order, and verify properness."""
import sys, json, gzip, itertools
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
import fs73_lattice as L

CEN = '/home/kooshi/source/lean-dir/data/fs73/census/'

def load():
    lat = json.load(open(CEN + 'lattice-degrey.json'))
    H = json.loads(lat['H']) if isinstance(lat['H'], str) else lat['H']
    U8 = json.loads(lat['U']) if isinstance(lat['U'], str) else lat['U']
    U = [L.coords_in(H, tuple(u)) for u in U8]
    assert all(u is not None for u in U)
    cols = json.load(gzip.open(CEN + 'K-8Lambda-classes-all.json.gz'))
    return H, U8, U, cols

def idx_fn(order):
    def f(v):
        v = [x % 8 for x in v]
        if order == 'big':
            return ((v[0]*8 + v[1])*8 + v[2])*8 + v[3]
        return ((v[3]*8 + v[2])*8 + v[1])*8 + v[0]
    return f

def proper(col, U, idx):
    for p in itertools.product(range(8), repeat=4):
        i = idx(p)
        for u in U:
            q = tuple(a + b for a, b in zip(p, u))
            if col[i] == col[idx(q)]:
                return False
    return True

if __name__ == '__main__':
    H, U8, U, cols = load()
    print('|U|', len(U), 'colourings', len(cols), 'len', len(cols[0]))
    for order in ('big', 'little'):
        f = idx_fn(order)
        ok = sum(proper(c, U, f) for c in cols[:5])
        print(order, 'proper among first 5:', ok)
