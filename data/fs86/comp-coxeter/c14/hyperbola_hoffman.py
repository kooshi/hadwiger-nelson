"""C14.2(c) sanity check: least eigenvalue of the averaged hyperbola connection measure on p^{-n}Z_p^2 / p^M Z_p^2.

Coordinates: y = p^{-n}(a, b), a, b in Z/p^N, N = n + M. The level-k piece is {(p^k e, p^{-k} e^{-1}) : e unit},
i.e. a = p^{n+k} e, b = p^{n-k} e^{-1} (mod p^N), for k in [-n, n], with e uniform over units mod p^N.
All eigenvalues at once by a 2-D FFT of the (symmetric) measure. Claim to check: (2n+1)*lambda_min >= -1 - 2/(p-1).
"""
import sys
import numpy as np

def run(p, n, M):
    N = n + M
    q = p ** N
    units = [e for e in range(q) if e % p]
    inv = {e: pow(e, -1, q) for e in units}
    nu = np.zeros((q, q))
    w = 1.0 / ((2 * n + 1) * len(units))
    for k in range(-n, n + 1):
        for e in units:
            a = (p ** (n + k) * e) % q
            b = (p ** (n - k) * inv[e]) % q
            nu[a, b] += w
    assert abs(nu.sum() - 1) < 1e-9
    # symmetry check: nu(-y) = nu(y)
    assert np.allclose(nu, nu[(-np.arange(q)) % q][:, (-np.arange(q)) % q])
    ev = np.fft.fft2(nu).real
    ev[0, 0] = np.inf
    lam = ev.min()
    bound = -(1 + 2 / (p - 1)) / (2 * n + 1)
    print(f"p={p} n={n} M={M}: lambda_min={lam:.6f}  (2n+1)*lambda_min={(2*n+1)*lam:.4f}  claimed floor={-(1+2/(p-1)):.4f}  ok={lam >= bound - 1e-9}")
    return lam >= bound - 1e-9

if __name__ == "__main__":
    ok = True
    for (p, n, M) in [(3, 1, 1), (3, 2, 1), (3, 2, 2), (5, 1, 1), (5, 2, 1), (5, 1, 3), (7, 1, 1), (7, 2, 1), (13, 1, 1)]:
        ok &= run(p, n, M)
    print("ALL OK" if ok else "FAILURE")
    sys.exit(0 if ok else 1)
