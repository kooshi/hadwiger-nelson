"""FS-86 B3: exact Hoffman certificates for plan §S.1 (R4) on Lambda_510 over Q(sqrt59), at every prime of norm <= 59 where the lattice
is integral (7, 11, 23, 29, 31, 41, 43, 47, 53, 59) and at the extra inert primes 13 and 19.

For each prime P of F above p: the level-one image target G_P = Cay(k^2, V), k the residue field, V the image of U; its exact full-circle
membership; and whether Hoffman's ratio bound refuses four colours, i.e. whether every eigenvalue lambda satisfies lambda > -d/3
(then alpha < n/4, so no four-colouring).  Exactness: an eigenvalue is lambda_xi = sum_r n_r(xi) cos(2 pi r/p), an element of the real
cyclotomic field; the Galois group acts by xi -> j xi, so one xi per projective class covers every character.  For each class PARI
computes f = charpoly(2(3 lambda + d)) in Q(zeta_p) and counts its real roots in (-oo, 0] by Sturm (polsturm): zero for every class <=>
lambda_min > -d/3 exactly.  Floats are printed for reading only.
Run: python3 b3.py   (about a minute; writes b3.out, and gp scripts/outputs under gp/)
"""
import os, sys, subprocess, itertools, numpy as np
sys.path.insert(0, '../stageA')
from units_fast import units_fast
from sympy import legendre_symbol, sqrt_mod

D, M = 59, 510
U = units_fast(M, D)
PRIMES = [7, 11, 13, 19, 23, 29, 31, 41, 43, 47, 53, 59]
os.makedirs('gp', exist_ok=True)
out = open('b3.out', 'w')
def say(*a):
    print(*a); print(*a, file=out, flush=True)

def places(p):
    if p == D:
        return [('ramified', 0)]
    if legendre_symbol(D % p, p) == 1:
        return [('split', s) for s in sorted(set(sqrt_mod(D % p, p, all_roots=True)))]
    return [('inert', None)]

def image(p, kind, s):
    mi = pow(M, -1, p)
    if kind == 'inert':
        V = {((a * mi) % p, (b * mi) % p, (c * mi) % p, (e * mi) % p) for (a, b, c, e) in U}
    else:
        V = {(((a + b * s) * mi) % p, ((c + e * s) * mi) % p) for (a, b, c, e) in U}
    return np.array(sorted(V), dtype=np.int64)

def on_circle(V, p, kind):
    if kind == 'inert':
        x0, x1, y0, y1 = V.T
        return ((x0 * x0 + D * x1 * x1 + y0 * y0 + D * y1 * y1 - 1) % p == 0) & ((2 * (x0 * x1 + y0 * y1)) % p == 0)
    x, y = V.T
    return (x * x + y * y - 1) % p == 0

def circle_size(p, kind):
    q = p * p if kind == 'inert' else p
    return q + 1 if q % 4 == 3 else q - 1

def proj_classes(p, n):
    """One representative per nonzero vector of F_p^n up to F_p^* scaling (first nonzero coordinate 1)."""
    reps = []
    for lead in range(n):
        for tail in itertools.product(range(p), repeat=n - lead - 1):
            reps.append([0] * lead + [1] + list(tail))
    assert len(reps) == (p ** n - 1) // (p - 1)
    return np.array(reps, dtype=np.int64)

summary = []
CONTROLS = [(3, 'control'), (7, 'control'), (11, 'control')]   # the full planes Gamma_3, Gamma_7 (chi 3, 4: Hoffman CANNOT refuse
# four colours on them) and Gamma_11 (Hoffman ratio above 1/4 by the planner's float): all three must read 'does NOT refuse'
def full_plane(p):
    return np.array([(x, y) for x in range(p) for y in range(p) if (x * x + y * y - 1) % p == 0], dtype=np.int64)
for p, kind0 in CONTROLS + [(p, None) for p in PRIMES]:
    for kind, s in ([('control', None)] if kind0 == 'control' else places(p)):
        V = full_plane(p) if kind == 'control' else image(p, kind, s)
        d = len(V)
        kk = 'split' if kind == 'control' else kind
        oc = bool(on_circle(V, p, kk).all())
        full = oc and d == circle_size(p, kk)
        Xi = proj_classes(p, V.shape[1])
        R = (Xi @ V.T) % p
        cnt = np.stack([(R == r).sum(1) for r in range(p)], 1)
        # float over EVERY nonzero character (each class times every j in F_p^*): reading only
        cosj = np.cos(2 * np.pi * (np.outer(np.arange(1, p), np.arange(p)) % p) / p)   # (j, r) -> cos(2 pi j r / p)
        lam = cnt @ cosj.T
        lmin = lam.min()
        # gp script: one polsturm count per class
        tag = f"p{p}_{kind}_{s if s is not None else 't'}"
        gpin = f"gp/{tag}.gp"
        with open(gpin, 'w') as g:
            g.write(f"p={p}; d={d}; P=polcyclo(p,x);\n")
            g.write("C=[" + ";".join(",".join(str(int(v)) for v in row) for row in cnt) + "];\n")
            g.write("bad=0; zero=0; neg=0;\n")
            g.write("for(k=1,#C[,1], A=3*sum(r=0,p-1,C[k,r+1]*(x^r+x^((p-r)%p)))+2*d; f=charpoly(Mod(A,P)); "
                    "c=polsturm(f,[-oo,0]); if(c>0, bad++; if(polcoef(f,0)==0, zero++, neg++)));\n")
            g.write("print(\"classes \", #C[,1], \" with a conjugate <= -d/3: \", bad, \" (of which with a conjugate = -d/3 exactly: \", zero, \")\");\n")
        res = subprocess.run(['gp', '-q', '-f', '--default', 'parisizemax=2G', gpin], input='\\q\n', capture_output=True, text=True, timeout=1800)
        gpres = res.stdout.strip()
        open(f"gp/{tag}.out", 'w').write(gpres + "\n")
        import re
        mt = re.fullmatch(r"classes (\d+) with a conjugate <= -d/3: (\d+) \(of which with a conjugate = -d/3 exactly: (\d+)\)", gpres)
        assert mt and int(mt.group(1)) == len(cnt), f"gp output not understood at p={p}: {gpres!r} {res.stderr[:300]!r}"
        refuses = int(mt.group(2)) == 0
        ratio = -lmin / (d - lmin)
        say(f"p={p:2d} {kind:8s} s={s}: image {d}/{circle_size(p, kind)} (on circle: {oc}; full circle: {full}); float lambda_min={lmin:.6f}, "
            f"-d/3={-d / 3:.6f}, Hoffman ratio={ratio:.6f}; EXACT (PARI polsturm): {gpres} -> Hoffman {'REFUSES four colours' if refuses else 'does NOT refuse'}")
        summary.append((p, kind, s, d, full, round(ratio, 6), refuses))
        if kind == 'control':
            assert not refuses, f"CONTROL FAILED at Gamma_{p}: the test refused a graph it must not refuse"

say("\nSUMMARY (p, place, image size, full circle, float ratio, exact Hoffman refusal):")
for row in summary:
    say("  ", row)
