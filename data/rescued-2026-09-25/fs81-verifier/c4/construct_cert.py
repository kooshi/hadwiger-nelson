"""The verifier's explicit NONEMPTY points (C4), turned into certificates in phase 0's NONEMPTY format and checked by
tools/fs81_theta_check.py --no-enumerate.  The point is built from the layer formula (the verifier's), then lifted to
theta in (a,b,c,e)-dual coordinates by V2's theta_from_x (PARI's integer solver), which fails unless r.x is an integer for
every relation r of the LISTED units -- an independent check of the Gauss-lemma reduction."""
import json, math, os, subprocess, sys
from fractions import Fraction as F
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import fs81_theta as T
import fs73v2_xbb as X
OUT = os.path.dirname(os.path.abspath(__file__))

def point(d, name, K):
    n = (d + 1) // 4; m = 5 ** K
    cK = (F(m, 2), F(m, 2))
    if name == "A" and n % 2 == 1:                      # the field-level point (theta2, theta2, chi)
        f = (F(m, 6), F(m, 6))
        return {0: cK, 1: cK, -1: (cK[0] + f[0], cK[1] + f[1])}
    g = (cK[0] / d, cK[1] / d)                            # the alternating point
    ks = [0, 1, -1] if name == "A" else [-2, -1, 0, 1, 2]
    return {k: (cK[0] + (1 if k % 2 == 0 else -1) * g[0], cK[1] + (1 if k % 2 == 0 else -1) * g[1]) for k in ks}

def run(d, name, K, plant=False):
    layers = T.configuration(d, name, K)
    ks = [0, 1, -1] if name == "A" else [-2, -1, 0, 1, 2]
    D, units = T.units_of(d, layers, K)
    mu = point(d, name, K)
    if plant:                                             # a wrong point: shift one layer by a small non-lattice amount
        k0 = ks[0]; mu[k0] = (mu[k0][0] + F(1, 1000), mu[k0][1])
    where = {}
    for k, b in zip(ks, layers):
        for r in T.rational_units(K):
            x = T.mul(d, b, r)
            u = tuple(int(t * D) for t in x)
            val = mu[k][0] * r[0] + mu[k][1] * r[2]           # <mu_k, r>, r = (Re, 0, Im, 0)
            where[u] = val
            where[tuple(-t for t in u)] = -val
    xs = []
    for u in units:
        v = where[tuple(u)] % 1
        xs.append(v)
    inband = all(F(1, 3) <= v <= F(2, 3) for v in xs)
    basis = X.kernel_basis([tuple(u) for u in units])
    tag = f"d{d}-{name}-K{K}" + ("-PLANT" if plant else "")
    try:
        th, nvec = X.theta_from_x([tuple(u) for u in units], basis, xs)
    except Exception as e:
        return {"tag": tag, "in_band": inband, "lift": f"FAILED ({type(e).__name__})"}
    cert = {"d": d, "key": T.key_of(units, D), "units": [list(u) for u in units], "N": len(units), "verdict": "NONEMPTY",
            "finder": "the verifier's explicit layer construction (FS81-C-verification §4)",
            "theta_abce_dual": [[v.numerator, v.denominator] for v in th]}
    path = os.path.join(OUT, tag + "-construct.json")
    json.dump(cert, open(path, "w"))
    p = subprocess.run([sys.executable, "/home/kooshi/source/lean-dir/tools/fs81_theta_check.py", "--no-enumerate", path],
                       capture_output=True, text=True)
    return {"tag": tag, "pairs": len(units), "in_band": inband, "lift": "ok",
            "check": ("PASS" if p.returncode == 0 else "FAIL") + ": " + (p.stdout + p.stderr).strip().splitlines()[-1][:110]}

for d, name, K in [(119, "A", 2), (107, "B", 2), (23, "A", 1), (11, "A", 3), (35, "A", 3), (491, "B", 3), (2603, "B", 4), (527, "B", 3)]:
    print(json.dumps(run(d, name, K)), flush=True)
print(json.dumps(run(119, "A", 2, plant=True)))
