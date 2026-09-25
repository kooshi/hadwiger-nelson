import sys, time, collections, cmath, math
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
import fs79_p3_theta4 as T
U, half, B, C, QD = T.frame()
s = math.sqrt(167)
z_of = lambda u: complex(u[0] + u[1]*s, u[2] + u[3]*s) / 420
UR = [complex(1,0), complex(0,1), complex(.6,.8), complex(.8,.6), complex(.6,-.8), complex(.8,-.6)]
UR = UR + [-x for x in UR]
v = complex(83, s) / 84; z = (1+1j) * complex(15, -s) / 28
B5 = {'1': 1, 'v': v, 'vb': v.conjugate(), 'z': z, 'zb': z.conjugate()}
layer = {}
for i, u in enumerate(half):
    zu = z_of(u)
    hits = [n for n, b in B5.items() if any(abs(zu - b*x) < 1e-9 for x in UR)]
    assert len(hits) == 1, (i, hits)
    layer[i] = hits[0]
L = collections.defaultdict(list)
for i, n in layer.items(): L[n].append(i)
print({n: L[n] for n in L})
def run(order, j0, cap=240):
    k = 4; st = {'nodes':0,'leaves':0,'exact':0,'leaf_lp':0}
    stack = [[j0]]; t = time.time(); dep = collections.Counter()
    while stack and time.time()-t < cap:
        p = stack.pop(); r, c = T.certify_node(C, order, p, k, st); dep[len(p)] += 1; st['nodes'] += 1
        if c == 'leaf': st['leaves'] += 1
        elif c:
            for j in reversed(c): stack.append(p+[j])
    return st['nodes'], st['leaves'], len(stack), round(time.time()-t,1), sorted(dep.items())[:14]
l1 = lambda i: (sum(map(abs, C[i])), i)
cur = sorted(QD, key=l1) + sorted([i for i in range(30) if i not in QD], key=l1)
R = sorted(L['1'], key=l1); R.remove(0); R = [0] + R
orders = {'current': cur,
          'rational,v,vb,z,zb': R + sorted(L['v'], key=l1) + sorted(L['vb'], key=l1) + sorted(L['z'], key=l1) + sorted(L['zb'], key=l1),
          'rational,z,zb,v,vb': R + sorted(L['z'], key=l1) + sorted(L['zb'], key=l1) + sorted(L['v'], key=l1) + sorted(L['vb'], key=l1)}
Vv = sorted(L['v'], key=l1)
orders['r,v2,vb,z,zb,v4'] = R + Vv[:2] + sorted(L['vb'], key=l1) + sorted(L['z'], key=l1) + sorted(L['zb'], key=l1) + Vv[2:]
orders['r,v2,vb2,z2,zb2,rest'] = R + Vv[:2] + sorted(L['vb'], key=l1)[:2] + sorted(L['z'], key=l1)[:2] + sorted(L['zb'], key=l1)[:2] + sorted(L['vb'], key=l1)[2:] + sorted(L['z'], key=l1)[2:] + sorted(L['zb'], key=l1)[2:] + Vv[2:]
for name in sys.argv[1:]:
    o = orders[name]; assert sorted(o) == list(range(30)) and o[0] == 0
    print(name, run(o, 105), flush=True)
