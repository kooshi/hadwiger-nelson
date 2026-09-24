"""Which generator pairs of L21cc6506 miss a square type in sampled periodic colourings (N=4: 3000, N=8: 300), and the good-pair graph."""
import sys, itertools, collections, math
import numpy as np
from language import colourings, reps
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
H = [[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
present = collections.defaultdict(set)
for N, cap in ((4, 3000), (8, 600)):
    verts, vid, cols = colourings(N, cap)
    C = np.array(cols, dtype=np.int8); V = np.array(verts)
    def idx(*g):
        s = V.copy()
        for x in g: s = s + np.array(x)
        s %= N
        return ((s[:, 0]*N + s[:, 1])*N + s[:, 2])*N + s[:, 3]
    for (i, s_), (j, t_) in itertools.combinations(enumerate(reps), 2):
        a, b, c, d = C[:, idx()], C[:, idx(s_)], C[:, idx(s_, t_)], C[:, idx(t_)]
        ac, bd = (a == c), (b == d)
        for name, m in (('abab', ac & bd), ('abac', ac & ~bd), ('abcb', ~ac & bd), ('abcd', ~ac & ~bd)):
            if m.any(): present[(i, j)].add(name)
# real coordinates: H-coordinates -> (a,b,c,e) -> complex number ((a + b sqrt167) + i (c + e sqrt167))/420
def cplx(hc):
    v = [sum(hc[r]*H[r][k] for r in range(4)) for k in range(4)]
    s = math.sqrt(167); return complex((v[0] + v[1]*s)/420, (v[2] + v[3]*s)/420)
if __name__ == '__main__':
  bad = {p: 4 - len(ts) for p, ts in present.items() if len(ts) < 4}
  print('pairs missing some type:', len(bad), 'of', len(present))
  miss_by = collections.Counter(t for p, ts in present.items() for t in ('abab','abac','abcb','abcd') if t not in ts)
  print('missing counts by type:', dict(miss_by))
  ang = collections.Counter()
  for (i, j), ts in present.items():
      if len(ts) < 4:
          z1, z2 = cplx(reps[i]), cplx(reps[j])
          a = math.degrees(math.acos(max(-1, min(1, (z1.conjugate()*z2).real))))
          ang[(round(min(a, 180-a), 3), tuple(sorted({'abab','abac','abcb','abcd'} - ts)))] += 1
  for k2, v in sorted(ang.items()): print('  angle(mod sign)', k2[0], 'missing', k2[1], 'pairs', v)
  # good-pair graph connectivity
  good = [p for p, ts in present.items() if len(ts) == 4]
  adj = collections.defaultdict(set)
  for i, j in good: adj[i].add(j); adj[j].add(i)
  seen = {0}; st = [0]
  while st:
      x = st.pop()
      for y in adj[x]:
          if y not in seen: seen.add(y); st.append(y)
  print('good pairs', len(good), '| directions reached from direction 0 in the good-pair graph:', len(seen), 'of', len(reps))
