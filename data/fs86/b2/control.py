"""B2 positive control: reproduce LEDGER row 67's spectrum table (plans/FS38-derivation.md §D-2(b)) on the full S_m, levels 1-8,
with this directory's independent ring build (tower.py); then plant faults and watch the table break.

Exactness: every eigenvalue is held exactly in Z[zeta_N] (tower.exact_eig).  "lambda_min = -d/3" is decided exactly (3*lambda + d = 0
as an integer vector); "no eigenvalue below -d/3" is decided by float with margin MARGIN on the characters not exactly equal to -d/3,
and every character whose float lies within MARGIN of -d/3 without being exactly equal is reported (none may exist, or the check
fails loudly).  Float error: |error| <= d * 1e-15 << MARGIN.
Run: python3 control.py  (seconds; writes control.out)
"""
import sys, numpy as np
from tower import circle, characters, exact_eig, to_float, all_residues, conj, mul, canon, is_zero, ONE

MARGIN = 1e-6
EXPECTED = {  # m: (n, d, lambda_min, #minimisers, |H_min|, second-least)   -- row 67 / FS38 §D-2(b)
    1: (4, 3, -1, 3, 1, 3), 2: (16, 6, -2, 9, 1, 2), 3: (64, 12, -4, 21, 1, 0), 4: (256, 24, -8, 45, 1, 0),
    5: (1024, 48, -16, 45, 4, -8), 6: (4096, 96, -32, 45, 16, -16), 7: (16384, 192, -64, 45, 64, -32),
    8: (65536, 384, -128, 45, 256, -64)}

def report(T, m):
    """Exact spectral report of Cay(O/P^m, T): (n, d, lambda_min as float, exact-tight flag, #minimisers, |H_min|,
    H_min == P^4/P^m flag, second-least eigenvalue float, list of near-threshold non-equal characters)."""
    u = characters(m)
    E = exact_eig(u, T, m)
    lam = to_float(E, m)
    d = len(T)
    thr = np.zeros(E.shape[1], dtype=np.int64); thr[0] = d
    eq = np.all(3 * E + thr == 0, axis=1) if d % 3 == 0 else np.zeros(len(u), bool)
    near = (~eq) & (np.abs(lam + d / 3) < MARGIN)
    below = (~eq) & (lam < -d / 3 - MARGIN)
    lmin = lam.min()
    # minimisers exactly: the characters whose exact eigenvalue equals the exact minimum
    imin = np.argmin(lam)
    ismin = np.all(E == E[imin], axis=1)
    # but distinct exact values can share a float to within 1e-9 only if equal (algebraic integers); check:
    close = np.abs(lam - lmin) < 1e-9
    assert np.array_equal(close, ismin), "two distinct exact eigenvalues within 1e-9 of the minimum"
    umin = u[ismin]
    N = 1 << ((m + 1) // 2)
    X = all_residues(m) if m <= 10 else None
    if X is not None:
        H = X[np.all((umin @ X.T) % N == 0, axis=0)]
        hsize = len(H)
        hP4 = bool(m >= 4 and np.all(H % 4 == 0) and hsize == 4 ** (m - 4)) if m >= 4 else (hsize == 1)
    else:
        hsize, hP4 = None, None
    vals = np.unique(np.round(lam, 9))
    second = vals[1] if len(vals) > 1 else None
    return dict(n=4 ** m, d=d, lmin=lmin, tight=bool(eq.any() and not below.any() and ismin[eq].all() and eq[ismin].all()),
                below=int(below.sum()), near=int(near.sum()), nmin=int(ismin.sum()), H=hsize, HisP4=hP4, second=second, umin=umin)

def table(S_fn, label, out):
    ok = True
    for m in range(1, 9):
        S = S_fn(m)
        r = report(S, m)
        exp = EXPECTED[m]
        got = (r['n'], r['d'], round(r['lmin'], 9), r['nmin'], r['H'], round(r['second'], 9))
        match = (got[0] == exp[0] and got[1] == exp[1] and abs(got[2] - exp[2]) < 1e-9 and got[3] == exp[3] and got[4] == exp[4]
                 and abs(got[5] - exp[5]) < 1e-9 and r['tight'] and r['near'] == 0)
        ok &= match
        print(f"{label} m={m} n={r['n']} d={r['d']} lmin={r['lmin']:.6f} tight(exact)={r['tight']} below={r['below']} near={r['near']} "
              f"#min={r['nmin']} |H_min|={r['H']} H_min=P4/P^m:{r['HisP4']} second={r['second']:.6f}  {'MATCH' if match else 'MISMATCH'}",
              file=out, flush=True)
    return ok

if __name__ == '__main__':
    out = open('control.out', 'w')
    class Tee:
        def write(self, s): out.write(s); sys.stdout.write(s)
        def flush(self): out.flush(); sys.stdout.flush()
    t = Tee()
    # 0. the circle itself: size 3*2^(m-1), closed under products and conjugation = inverse, S = -S, fibres of size two
    for m in range(1, 9):
        S = circle(m)
        assert len(S) == 3 * 2 ** (m - 1), (m, len(S))
        assert np.all(is_zero(mul(S, conj(S)) - ONE, m))
        enc = {tuple(x) for x in S}
        assert all(tuple(x) in enc for x in canon(-S, m))
        if m >= 2:
            down = {tuple(x) for x in canon(S, m - 1)}
            assert down == {tuple(x) for x in circle(m - 1)}
    print("circle checks: |S_m| = 3*2^(m-1), norm one, S = -S, S_m onto S_{m-1}: OK (m = 1..8)", file=t, flush=True)
    ok = table(circle, "FULL", t)
    print("POSITIVE CONTROL:", "PASS (row 67's table reproduced exactly at levels 1-8)" if ok else "FAIL", file=t, flush=True)
    # Plant 1: a wrong generator -- replace the pair +-s0 of S_m (s0 = the first element != 1) by +-(s0 + pi^(m-1)*w), not on the circle
    def planted_gen(m):
        S = circle(m)
        if m == 1:
            return S
        pim = ONE
        for _ in range(m - 1):
            pim = mul(pim, [1, 0, 1, 0])
        s0 = S[1]
        bad = canon(s0 + mul(pim, [0, 1, 0, 0]), m)
        keep = [x for x in S if not (np.array_equal(x, s0) or np.array_equal(x, canon(-s0, m)))]
        return canon(np.array(keep + [bad, -bad]), m)
    ok1 = table(planted_gen, "PLANT-GEN", t)
    print("PLANT 1 (a wrong generator pair at every level >= 2):", "WENT RED as it must" if not ok1 else "STAYED GREEN -- CONTROL IS BLIND", file=t, flush=True)
    # Plant 2: a wrong conjugation (the automorphism sqrt3 -> -sqrt3, w fixed), so the 'circle' is another torus
    def conj_bad(x):
        x = np.asarray(x)
        return np.stack([x[..., 0], x[..., 1], -x[..., 2], -x[..., 3]], axis=-1)
    def planted_conj(m):
        return circle(m, conj_fn=conj_bad)
    try:
        ok2 = table(planted_conj, "PLANT-CONJ", t)
    except AssertionError as e:
        ok2 = False
        print("PLANT-CONJ raised:", e, file=t, flush=True)
    print("PLANT 2 (the wrong conjugation):", "WENT RED as it must" if not ok2 else "STAYED GREEN -- CONTROL IS BLIND", file=t, flush=True)
    assert ok and not ok1 and not ok2
