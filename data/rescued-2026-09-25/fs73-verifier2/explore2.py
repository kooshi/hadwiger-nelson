import json, sys, itertools, math
from fractions import Fraction as F
sys.path.insert(0, 'tools')
from fs73v2_units import det, solve, hnf
name = sys.argv[1]
info = json.load(open(f'{sys.argv[2]}/units-{name}.json'))
pos = [tuple(u) for u in info['pos']]
spanB = info['span_hnf']
ds = abs(det(spanB))
cands = []
for quad in itertools.combinations(range(len(pos)), 4):
    M = [list(pos[i]) for i in quad]
    k = abs(det(M)) / ds
    if k: cands.append((k, quad))
cands.sort()
def frame_stats(quad):
    A = [list(pos[i]) for i in quad]
    Q = [solve(A, list(u)) for u in pos]
    G = [[int(x) for x in solve(spanB, list(pos[j]))] for j in quad]  # G[j][i] = coord_i(u_j)
    rowsM = [[G[j][i] for j in range(4)] for i in range(4)]
    T = hnf(rowsM)
    diag = [T[i][i] for i in range(4)]
    others = [i for i in range(len(pos)) if i not in quad]
    # interval filter over all cubes
    surv = 0; total = 0
    killcount = {}
    for n in itertools.product(*[range(x) for x in diag]):
        total += 1
        dead = False
        for i in others:
            q = Q[i]
            lo = sum(qj*(nj + F(1,3)) + (qj/3 if qj < 0 else 0) for qj, nj in zip(q, n))
            hi = sum(qj*(nj + F(1,3)) + (qj/3 if qj > 0 else 0) for qj, nj in zip(q, n))
            # exists m with [m+1/3, m+2/3] meeting [lo,hi]?  i.e. m <= hi-1/3 and m >= lo-2/3
            if math.floor(hi - F(1,3)) < math.ceil(lo - F(2,3)):
                dead = True; killcount[i] = killcount.get(i,0)+1; break
        if not dead: surv += 1
    return diag, total, surv, max(sum(abs(x) for x in Q[i]) for i in others)
for k, quad in cands[:int(sys.argv[3])]:
    print(k, quad, frame_stats(quad))
