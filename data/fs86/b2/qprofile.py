"""B2: the spectra of Lambda_510's dyadic quotients Q_m = Cay(O/P^m, T_m), T_m = U mod P^m, levels 1..11 (11 = injective).

Float spectrum of every character by FFT (aiming, and the sign test with margin); the extreme characters' eigenvalues exactly in
Z[zeta_N] (tower.exact_eig).  The exact sign certificate is separate (sign_cert.gp, via PARI's charpoly and Sturm count).
Run: python3 qprofile.py  (under a minute; writes qprofile.out and qprofile_min.json)
"""
import json, numpy as np
from tower import canon, circle, float_eigs_fft, exact_eig, to_float, characters, modulus

MARGIN = 1e-6
Z = np.load('U510_O.npy')

def level_of(u, m):
    """Least j <= m such that the character u of O/P^m is trivial on P^j/P^m (its conductor exponent)."""
    N = modulus(m)
    for j in range(0, m + 1):
        # generators of P^j mod P^m in canonical coordinates: pi^j * basis
        from tower import mul, ONE
        pj = ONE
        for _ in range(j): pj = mul(pj, [1, 0, 1, 0])
        gens = canon(np.stack([mul(pj, b) for b in np.eye(4, dtype=np.int64)]), m)
        if np.all((gens @ u) % N == 0):
            return j
    return None

if __name__ == '__main__':
    out = open('qprofile.out', 'w')
    def say(*a):
        print(*a); print(*a, file=out, flush=True)
    res = {}
    for m in range(1, 12):
        T = np.unique(canon(Z, m), axis=0)
        d = len(T)
        u, lam = float_eigs_fft(T, m)
        lmin = lam.min()
        thr = -d / 3
        nbelow = int((lam < thr - MARGIN).sum()); nnear = int((np.abs(lam - thr) <= MARGIN).sum())
        # exact eigenvalues of every character within 1e-6 of the float minimum, and of every near-threshold character
        sel = np.nonzero((lam < lmin + 1e-6) | (np.abs(lam - thr) <= MARGIN))[0]
        E = exact_eig(u[sel], T, m)
        lf = to_float(E, m)
        assert np.allclose(lf, lam[sel], atol=1e-8), "FFT and exact eigenvalues disagree"
        vmin = sel[np.argmin(lf)]
        Emin = exact_eig(u[[vmin]], T, m)[0]
        exact_thr = bool(d % 3 == 0 and np.all(3 * Emin + np.eye(len(Emin), dtype=np.int64)[0] * d == 0))
        nmin = int((np.abs(lam - lmin) < 1e-9).sum())
        lv = sorted({level_of(x, m) for x in u[np.abs(lam - lmin) < 1e-9][:200]})
        verdict = 'TIGHT' if (nbelow == 0 and exact_thr) else ('SLACK' if lmin < thr - MARGIN else 'NEAR (exact check needed)')
        say(f"m={m:2d} d={d:4d} -d/3={thr:10.4f} lambda_min={lmin:12.6f} ratio lambda_min/d={lmin / d:.6f} "
            f"#chars below -d/3={nbelow} #at -d/3 (float)={nnear} #minimisers={nmin} conductor levels of minimisers={lv} -> {verdict}")
        res[m] = dict(d=d, lmin=float(lmin), nbelow=nbelow, verdict=verdict, u=[int(x) for x in u[vmin]],
                      E=[int(x) for x in Emin], N=int(modulus(m)), levels=lv)
    json.dump(res, open('qprofile_min.json', 'w'), indent=1)
