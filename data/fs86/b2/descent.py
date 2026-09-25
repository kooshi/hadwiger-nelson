"""B2: the infinite lattice Cay(Lambda_510, U) is not Hoffman-tight, and from which dyadic level Q_m is slack again.

The symbol sigma(theta) = sum_u cos(2 pi theta.c(u)) on the 4-torus (c(u): coordinates of U in a Z-basis of Lambda, lattice.py).
At the 45 level-4 minimisers theta0 = n0/4, sigma = -108 = -d/3 exactly (the tight levels 11-14).  Its gradient there is
2 pi g, g = -sum_u sin(2 pi theta0.c(u)) c(u), an exact integer vector (sines of quarter-turns).  g != 0 means sigma < -108 just off
theta0, so some 2-power torsion point, i.e. some character of some Q_m, has eigenvalue < -d/3 and Q_m is slack.
The certificate: an explicit n in (Z/2^k)^4, its eigenvalue on Q_{2k} = Cay(Lambda/2^k Lambda, U) held exactly as integer counts of
the residues n.c(u) mod 2^k, evaluated in float with error <= 324 * 1e-15 against the stated margin.
Run: python3 descent.py   (seconds; writes descent.out)
"""
import itertools, numpy as np

C = np.load('lattice_coords.npy')
d = len(C)
out = open('descent.out', 'w')
def say(*a):
    print(*a); print(*a, file=out, flush=True)

def sigma(theta):
    return np.cos(2 * np.pi * (C @ theta)).sum()

def exact_eig(n, k):
    """Eigenvalue of the character n of Lambda/2^k Lambda: counts of n.c(u) mod 2^k, and its float value."""
    N = 1 << k
    r = (C @ n) % N
    cnt = np.bincount(r, minlength=N)
    val = float(np.dot(cnt, np.cos(2 * np.pi * np.arange(N) / N)))
    return cnt, val

# the level-4 minimisers, as a SET-generator graph (T_4 = S_4, 24 residues) and as the multiset U (324): same 45 characters?
T4 = np.unique(C % 4, axis=0)
set_min, mult_min = [], []
for n in itertools.product(range(4), repeat=4):
    n = np.array(n)
    rs = (T4 @ n) % 4; rm = (C @ n) % 4
    if (rs == 0).sum() - (rs == 2).sum() == -8: set_min.append(tuple(n))
    if (rm == 0).sum() - (rm == 2).sum() == -108: mult_min.append(tuple(n))
say(f"level 4: {len(set_min)} minimisers of P_4 (lambda = -8); {len(mult_min)} characters with sum over all 324 u = -108; same set: "
    f"{sorted(set_min) == sorted(mult_min)}")
# their common kernel in Lambda/4Lambda
X = np.array(list(itertools.product(range(4), repeat=4)))
ker = X[np.all((X @ np.array(set_min).T) % 4 == 0, axis=1)]
say(f"common kernel of the 45 in Lambda/4Lambda: {len(ker)} element(s)  (trivial => H_min(Q_m) = 4Lambda/.. = P^4/P^m at every tight level m >= 5 where these are the minimisers)")

sinv = np.array([0, 1, 0, -1])
best = None
for n0 in mult_min:
    n0 = np.array(n0)
    r = (C @ n0) % 4
    g = -(sinv[r][:, None] * C).sum(0)
    if not np.any(g): continue
    th0 = n0 / 4.0
    # float line search along -g (aiming only)
    ts = np.linspace(0, 2e-3, 4001)[1:] / np.linalg.norm(g)
    vals = [sigma(th0 - t * g) for t in ts]
    j = int(np.argmin(vals))
    tstar, vstar = ts[j], vals[j]
    for k in range(7, 21):
        N = 1 << k
        n = np.round((th0 - tstar * g) * N).astype(np.int64) % N
        cnt, val = exact_eig(n, k)
        if val < -108 - 1e-6:
            if best is None or k < best[0] or (k == best[0] and val < best[3]):
                best = (k, tuple(n0), n.tolist(), val, g.tolist(), vstar, cnt)
            break
say(f"minimisers with nonzero symbol gradient: {sum(1 for n0 in mult_min if np.any(-(sinv[(C @ np.array(n0)) % 4][:, None] * C).sum(0)))} of {len(mult_min)}")
k, n0, n, val, g, vstar, cnt = best
say(f"float line minimum near theta0 = {n0}/4 along -g, g = {g}: sigma ~ {vstar:.4f} (aiming)")
say(f"CERTIFICATE: the character n = {n} of Lambda/2^{k} Lambda (level m = {2 * k}) has eigenvalue {val:.6f} < -108 = -d/3 on "
    f"Q_{2 * k} (margin {-108 - val:.6f}, float error <= 3.3e-13); exact residue counts of n.c(u) mod 2^{k} are in descent.out")
say("   counts (residue: number of u), nonzero only:", [(i, int(c)) for i, c in enumerate(cnt) if c])

# sharpen the level: at each k, every step n = n0 * 2^(k-2) + delta, delta in {-2..2}^4, around each of the 45 minimisers
say("smallest even level with a slack character among n0*2^(k-2) + delta, |delta_i| <= 2 (exact counts, float value):")
deltas = np.array(list(itertools.product(range(-2, 3), repeat=4)))
for k in range(8, 14):
    N = 1 << k
    found = None
    for n0 in mult_min:
        ns = (np.array(n0) * (N // 4) + deltas) % N
        R = (ns @ C.T) % N
        vals = np.cos(2 * np.pi * R / N).sum(1)
        j = int(np.argmin(vals))
        if vals[j] < -108 - 1e-6 and (found is None or vals[j] < found[1]):
            found = (ns[j].tolist(), float(vals[j]), n0)
    say(f"   k={k} (level {2 * k}): " + (f"SLACK witness n={found[0]} eigenvalue {found[1]:.6f} (near n0={found[2]})" if found else "none in this neighbourhood"))
    if found: break
