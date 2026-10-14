"""FS131-KDB1 prototype (untrusted, a planning instrument): emulate the kernel's J0 covering check of
phi(t) = w1 + w0 J0(t) + sum w2 J0(t d_k) >= 1 - mu on [0, T1], with
  * per-term chains: J = (J0, J1) propagated cell by cell from x = 0 by Taylor polynomials built from the
    Bessel ODE recurrence, each certified by an exact defect bound (the ODE comparison lemma),
  * per-cell lower bound: the 27 polynomials combined into Q(tau), shifted to the cell midpoint, quadratic part
    minimised exactly, higher terms bounded crudely.
Exact integer / Fraction arithmetic throughout (what the kernel would compute); floats only to choose cells.
Counts the operations a kernel run would perform. Usage: python3 proto_chain.py T_END [--plan out.json]
"""
import sys, json, math, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, 'tools')
import j26_ambrus_check as J
import mpmath

P = 64
S = 1 << P
TB = 20                     # t-grid points are multiples of 2^-TB
mpmath.mp.dps = 60
pts = J.read_points(Path('data/pa-ambrus2023/verification23.nb'))
w0, wT, w1, w2, wc = J.read_coeffs(Path('data/pa-ambrus2023/g23.csv'))
terms = [(w0, mpmath.mpf(1))] + [(v, mpmath.sqrt(J.ffloat(J.sqdist(pts[i-1], pts[j-1])))) for v, i, j in w2]
Dt = []        # d~_k as ints at scale 2^P
for v, d in terms:
    Dt.append(int(mpmath.nint(d * S)))
Dt[0] = S       # w0's distance is exactly 1
W = [v for v, _ in terms]
MU = Fr(6, 10**5)
TARGET = 1 - MU
ETA = Fr(1, S)  # |d - d~| <= 2^-P (rounding to nearest gives 2^-(P+1))

OPS = {'mul': 0, 'add': 0, 'div': 0}

def taylor(m0, m1, C, N):
    """Coefficients a_0..a_N, b_0..b_N (ints, scale 2^P) of the Taylor polynomials at x_left = C / 2^(P+TB)."""
    a = [m0] + [0] * N
    b = [m1] + [0] * N
    sc = 1 << (P + TB)
    for n in range(N):
        a[n + 1] = -((2 * b[n] + (n + 1)) // (2 * (n + 1)))  # round(-b_n/(n+1))
        if C == 0:
            # n b_n = a_{n-1} - b_n  ->  b_{n+1} = a_n / (n+2)
            b[n + 1] = (2 * a[n] + (n + 2)) // (2 * (n + 2))
        else:
            am1 = a[n - 1] if n >= 1 else 0
            num = C * a[n] + sc * (am1 - (n + 1) * b[n])
            den = C * (n + 1)
            b[n + 1] = (2 * num + den) // (2 * den)
        OPS['mul'] += 4; OPS['add'] += 3; OPS['div'] += 2
    if C == 0:
        b[0] = 0
    return a, b

def defect_bound(a, b, C, h):
    """Upper bound (Fraction) on sup_{s in [0,h]} |delta0| + |delta1|, exact."""
    N = len(a) - 1
    d0 = [(n + 1) * a[n + 1] + b[n] for n in range(N)] + [b[N]]
    g = [(n + 1) * b[n + 1] - a[n] for n in range(N)] + [-a[N]]
    D0 = sum(Fr(abs(x), S) * h ** n for n, x in enumerate(d0))
    OPS['mul'] += 2 * (N + 1); OPS['add'] += 2 * (N + 1)
    if C == 0:
        d1 = [g[n] + (b[n + 1] if n + 1 <= N else 0) for n in range(N + 1)]
        D1 = sum(Fr(abs(x), S) * h ** n for n, x in enumerate(d1))
    else:
        sc = 1 << (P + TB)
        X = []
        for n in range(N + 2):
            gn = g[n] if n <= N else 0
            gm = g[n - 1] if n >= 1 else 0
            bn = b[n] if n <= N else 0
            X.append(C * gn + sc * (gm + bn))
        D1 = sum(Fr(abs(x), S * sc) * h ** n for n, x in enumerate(X)) / Fr(C, sc)
        OPS['mul'] += 3 * (N + 2); OPS['add'] += 3 * (N + 2)
    return D0 + D1

def horner(coef, s):
    v = Fr(0)
    for x in reversed(coef):
        v = v * s + Fr(x, S)
    OPS['mul'] += len(coef); OPS['add'] += len(coef)
    return v

def shift(q, u0):
    """q(tau) -> coefficients of q(u0 + u)."""
    q = list(q)
    n = len(q)
    for i in range(n):
        for j in range(n - 2, i - 1, -1):
            q[j] += q[j + 1] * u0
    OPS['mul'] += n * n // 2; OPS['add'] += n * n // 2
    return q

def quad_min(q0, q1, q2, rho):
    cands = [q0 - q1 * rho + q2 * rho * rho, q0 + q1 * rho + q2 * rho * rho]
    if q2 > 0:
        v = -q1 / (2 * q2)
        if -rho <= v <= rho:
            cands.append(q0 - q1 * q1 / (4 * q2))
    return min(cands)

def cell(states, t0, wdt, N):
    """Try the cell [t0, t0 + wdt] (Fractions, dyadic). Returns (ok, newstates, margin)."""
    Q = None
    err = Fr(0)
    new = []
    for k in range(len(W)):
        m0, m1, r = states[k]
        C = int(t0 * (1 << TB)) * Dt[k]             # x_left at scale 2^(P+TB)
        h = wdt * Fr(Dt[k], S)
        a, b = taylor(m0, m1, C, N)
        D = defect_bound(a, b, C, h)
        p0h, p1h = horner(a, h), horner(b, h)
        n0, n1 = round(p0h * S), round(p1h * S)
        rr = r + h * D + abs(p0h - Fr(n0, S)) + abs(p1h - Fr(n1, S))
        new.append((n0, n1, rr))
        err += abs(W[k]) * (r + h * D + (t0 + wdt) * ETA)
        dk = Fr(Dt[k], S)
        coef = [W[k] * Fr(a[n], S) * dk ** n for n in range(N + 1)]
        OPS['mul'] += 2 * (N + 1)
        Q = coef if Q is None else [x + y for x, y in zip(Q, coef)]
    Q[0] += w1
    Qm = shift(Q, wdt / 2)
    rho = wdt / 2
    lb = quad_min(Qm[0], Qm[1], Qm[2], rho) - sum(abs(Qm[n]) * rho ** n for n in range(3, len(Qm)))
    margin = lb - err - TARGET
    return margin >= 0, new, margin

def degree_for(wdt):
    hmax = float(wdt) * 2.3
    N = 6
    while hmax ** (N + 1) / math.factorial(N + 1) > 1e-15:
        N += 1
    return N

def run(T_END, plan_out=None):
    states = [(S, 0, Fr(0)) for _ in W]
    t0 = Fr(0)
    wdt = Fr(1, 1 << 8)
    cells = []
    minmargin = None
    t_start = time.time()
    while t0 < T_END:
        while True:
            N = degree_for(wdt)
            ok, new, margin = cell(states, t0, wdt, N)
            if ok:
                break
            wdt /= 2
            if wdt < Fr(1, 1 << TB):
                raise SystemExit(f"cell too small at t={float(t0)} margin={float(margin)}")
        cells.append((t0, wdt, N, margin, [(st[0], st[1], st[2]) for st in states]))
        minmargin = margin if minmargin is None else min(minmargin, margin)
        states = new
        t0 += wdt
        if len(cells) % 200 == 0:
            print(f"t={float(t0):.4f} cells={len(cells)} w={float(wdt)} N={N} margin={float(margin):.3e} "
                  f"maxr={max(float(s[2]) for s in states):.2e} {time.time()-t_start:.0f}s", flush=True)
        # try to grow
        nxt = wdt * 2
        if nxt <= 1 and (t0 / nxt).denominator == 1:
            wdt = nxt
        if t0 + wdt > T_END:
            wdt = T_END - t0
    print("cells", len(cells), "min margin", float(minmargin), "max r", max(float(s[2]) for s in states))
    print("sum N over cells", sum(c[2] for c in cells), "OPS", OPS)
    if plan_out:
        json.dump({'cells': [[str(c[0]), str(c[1]), c[2], str(c[3]), [[x[0], x[1], -((-x[2].numerator * S) // x[2].denominator)] for x in c[4]]] for c in cells],
                   'final': [[s[0], s[1], str(s[2])] for s in states]}, open(plan_out, 'w'))
    return cells, states

if __name__ == '__main__':
    T_END = Fr(sys.argv[1])
    run(T_END, sys.argv[3] if len(sys.argv) > 3 and sys.argv[2] == '--plan' else None)
