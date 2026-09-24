"""Poros's C6 question: over ALL orbits (translation x relabelling) of 4-colourings of Cay(Lambda/4Lambda, U) for L21cc6506, the least
rank of KPer, and the index of the intersection of all KPers with Per of the two Theta_4 colourings (an upper bound for P, T36)."""
import sys, itertools, time, json
import numpy as np
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from pysat.solvers import Solver
from kper_additive import intersect, rank, span_hnf
import sympy
from fractions import Fraction as Fr
M, d, N = 420, 167, 4
U = sorted(units_be(M, d)); H = [[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
UC = [tuple(coords_in(H, u)) for u in U]
verts = list(itertools.product(range(N), repeat=4)); vid = {v: i for i, v in enumerate(verts)}
V = np.array(verts)
def idx(g):
    s = (V + np.array(g)) % N
    return ((s[:, 0]*N + s[:, 1])*N + s[:, 2])*N + s[:, 3]
TR = np.array([idx(t) for t in verts])          # TR[t][x] = index of x + t
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
g0 = vid[gens[0]]
cls += [[var(0, 0)], [var(g0, 1)]]
import os
REPS = 'kper_orbits_reps.npy'; LINES = 'kper_orbits_lines.jsonl'
t0 = time.time()
if os.path.exists(REPS):
    reps = list(np.load(REPS)); n = -1
else:
  s = Solver(name='cadical153', bootstrap_with=cls)
  seen = set(); reps = []; n = 0
  while s.solve():
      m = s.get_model(); col = np.array([next(c for c in range(4) if m[var(v,c)-1] > 0) for v in range(len(verts))], dtype=np.int8)
      s.add_clause([-var(v, int(col[v])) for v in range(len(verts))]); n += 1
      key = col.tobytes()
      if key in seen: continue
      reps.append(col)
      # mark the whole orbit's pinned members
      Ct = col[TR]                                   # (translations, vertices): Ct[t][x] = col[x+t]
      for row in Ct:
          a, b = int(row[0]), int(row[g0])
          others = [c for c in range(4) if c not in (a, b)]
          for o in (others, others[::-1]):
              sig = np.zeros(4, dtype=np.int8); sig[a] = 0; sig[b] = 1; sig[o[0]] = 2; sig[o[1]] = 3
              seen.add(sig[row].tobytes())
  np.save(REPS, np.array(reps))
print('pinned colourings', n, 'orbits', len(reps), f'{time.time()-t0:.0f}s', flush=True)
def kper(col):
    tot = None
    for p in range(4):
        for q in range(p+1, 4):
            done = {}
            for y0 in range(len(verts)):
                if col[y0] not in (p, q) or y0 in done: continue
                done[y0] = verts[y0]; stack = [y0]; volts = []
                while stack:
                    y = stack.pop(); ly = done[y]
                    for u in UC:
                        z = vid[tuple((a+b) % N for a, b in zip(verts[y], u))]
                        if col[z] not in (p, q): continue
                        lz = tuple(a+b for a, b in zip(ly, u))
                        if z in done:
                            v = tuple(a-b for a, b in zip(lz, done[z]))
                            if any(v): volts.append(v)
                        else:
                            done[z] = lz; stack.append(z)
                Vg = [list(x) for x in span_hnf(volts)] if volts else []
                tot = Vg if tot is None else intersect(tot, Vg)
                if not tot: return []
    return tot
done = {}
if os.path.exists(LINES):
    for L in open(LINES):
        o = json.loads(L); done[o['orbit']] = o
ranks = {}; inter = None; minrank = 4
out = open(LINES, 'a')
for r_i, col in enumerate(reps):
    if r_i in done:
        K = done[r_i]['kper']
    else:
        K = kper(col); K = [list(map(int, x)) for x in K] if K else []
        out.write(json.dumps({'orbit': r_i, 'kper': K}) + '\n'); out.flush()
    r = rank(K) if K else 0
    ranks[r] = ranks.get(r, 0) + 1; minrank = min(minrank, r)
    if r == 4: inter = K if inter is None else intersect(inter, K)
print('KPer ranks over orbits:', ranks, 'least rank', minrank, flush=True)
if inter:
    print('intersection of all full-rank KPers: index in Lambda', abs(sympy.Matrix(inter).det()), inter, flush=True)
    # Per of the two Theta_4 colourings, in H-coordinates: {x : theta(x) in Z}
    for f in ['L21cc6506-linear.json', 'L21cc6506-linear-probe.json']:
        w = json.load(open('/home/kooshi/source/lean-dir/data/fs79/phase0/witnesses/'+f))
        B = w['basis']; th = [Fr(x) for x in w['theta_on_basis']]
        # theta on H rows
        thH = [sum(Fr(x)*y for x, y in zip(coords_in(B, h), th)) for h in H]
        den = 1
        for t in thH: den = den*t.denominator//__import__('math').gcd(den, t.denominator)
        # Per = kernel of x -> sum x_i * thH_i * den mod den
        from kper_additive import int_kernel
        coeffs = [int(t*den) for t in thH]
        # solve sum coeffs_i x_i = den * k : integer kernel of [coeffs, -den]
        ker = int_kernel([coeffs + [-den]], 5)
        Per = [list(v[:4]) for v in ker]
        Per = [list(x) for x in span_hnf(Per)]
        print(f, 'Per index', abs(sympy.Matrix(Per).det()), flush=True)
        inter = intersect(inter, Per)
    print('intersection with both Theta_4 Pers: index', abs(sympy.Matrix(inter).det()), inter, flush=True)
    # does it contain N0 * (every H basis vector) for N0 a {2,3,5,7}-number? smallest m with m*Z^4 inside
    Mi = sympy.Matrix(inter)
    inv = Mi.inv()
    m = 1
    for x in inv: m = m * sympy.Rational(x).q // sympy.gcd(m, sympy.Rational(x).q)
    print('exponent of Lambda / intersection (least m with m*Lambda inside):', m, sympy.factorint(m), flush=True)
