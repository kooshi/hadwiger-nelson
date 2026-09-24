"""KPer of linear (Theta_4) colourings c(x) = floor(4 frac(theta(x)+beta)) on L21cc6506, via voltage groups on the circulant quotient."""
import sys, json, math
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, hnf, coords_in
from kper_additive import intersect, rank, index_in, span_hnf
M, d = 420, 167
U = sorted(units_be(M, d)); H = [list(h) for h in span_hnf(U)]
res = {}
def kper_linear(B, th, beta_num):
    thU = []
    for u in U:
        cc = coords_in(B, u); t = sum(Fr(x)*y for x, y in zip(cc, th)) % 1
        thU.append(t)
    N = 1
    for t in thU: N = N * t.denominator // math.gcd(N, t.denominator)
    for h in H:
        cc = coords_in(B, h); t = sum(Fr(x)*y for x, y in zip(cc, th)) % 1
        N = N * t.denominator // math.gcd(N, t.denominator)
    steps = [int(t*N) for t in thU]
    col = lambda y: (4*((y + beta_num) % N))//N
    for u, s in zip(U, steps):
        for y in range(N):
            assert col(y) != col((y+s) % N)
    Kp = None
    for p in range(4):
        for q in range(p+1, 4):
            seen = {}
            for y0 in range(N):
                if col(y0) not in (p, q) or y0 in seen: continue
                seen[y0] = (0,0,0,0); stack = [y0]; volts = []
                while stack:
                    y = stack.pop(); ly = seen[y]
                    for u, s in zip(U, steps):
                        z = (y+s) % N
                        if col(z) not in (p, q): continue
                        lz = tuple(a+b for a, b in zip(ly, u))
                        if z in seen:
                            v = tuple(a-b for a, b in zip(lz, seen[z]))
                            if any(v): volts.append(v)
                        else:
                            seen[z] = lz; stack.append(z)
                V = span_hnf(volts) if volts else []
                V = [list(x) for x in V]
                Kp = V if Kp is None else intersect(Kp, V)
                if not Kp: return N, []
    return N, Kp
for f in ['L21cc6506-linear.json', 'L21cc6506-linear-probe.json']:
    w = json.load(open('/home/kooshi/source/lean-dir/data/fs79/phase0/witnesses/'+f))
    B = w['basis']; th = [Fr(x) for x in w['theta_on_basis']]
    for beta in [0, 1, 7, 100]:
        N, K = kper_linear(B, th, beta)
        print(f, 'N', N, 'beta', beta, 'KPer rank', rank(K) if K else 0, 'index', index_in(K, H) if K else None, K)
