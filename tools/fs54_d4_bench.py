#!/usr/bin/env python3
"""fs54_d4_bench — the measurements behind plans/FS54-D4-pricing.md §7: where an iteration of the level-3 programme at
q = 27 spends its time, instrument by instrument.  Each subcommand prints what it measured; none is a solve.

  arrowhead    build A (tools/fs54_d4_quad.py assembly), form G = A^T A, report the off-diagonal mass on the 4-set x 4-set
               part (structurally zero: each entry of each pattern matrix holds exactly one 4-set variable), and time an
               exact Schur-complement solve of (rho I + G) x = r against its residual.
  projection   the eigen-projection of the 102 q = 27 block sizes (18 x 351..378, 84 x 169..196) on random symmetric
               matrices: a thread pool with single-threaded BLAS at several pool widths (run with OPENBLAS_NUM_THREADS=1).
  cusolver     the same projection on the GPU through ctypes (cuSOLVER dsyevd + cuBLAS dgmm/dgemm, device-synchronised,
               data already on the device), with an eigenvalue check against numpy.  Pin the card by UUID with
               CUDA_VISIBLE_DEVICES.

Measured 2026-09-16 on the desktop (the desktop's processor, graphics card A): arrowhead off-diagonal noise 2.7e-15, Schur solve 530 ms including
forming the complement, residual 1.4e-15; projection 399 ms (1 thread) / 66 ms (8) / 62 ms (16); cuSOLVER 457 ms."""
import argparse, ctypes, math, sys, time
from pathlib import Path
import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))

SIZES_Q27 = [378] * 9 + [351] * 9 + [169] * 21 + [182] * 42 + [196] * 21


def arrowhead(q, modulus):
    import fs54_d4_quad as D
    P = D.Plane(q, modulus)
    dreps, _, _ = D.d_classes(P)
    Tb = D.Tables(P, dreps, log=lambda *a: None)
    data, cone, oc = D.assemble_scs(P, Tb, D.build(P, Tb, "l3", dreps), nonneg=False)
    A = data["A"].tocsc()
    t = time.time()
    G = (A.T @ A).tocsr()
    print(f"q={q}: A {A.shape} nnz {A.nnz}; G nnz {G.nnz} in {time.time()-t:.1f} s")
    nb, nv = int((Tb.var_size < 4).sum()), Tb.nvar
    G44 = G[nb:, nb:].tocoo()
    off = G44.row != G44.col
    print(f"  border {nb}, 4-set variables {nv-nb}; off-diagonal 4-set coupling: {int(off.sum())} entries, "
          f"max |value| {np.abs(G44.data[off]).max() if off.any() else 0:.2e}")
    rho = 1e-3
    r = np.random.default_rng(0).standard_normal(nv)
    t = time.time()
    d = G.diagonal()[nb:] + rho
    B = G[:nb, nb:].toarray()
    K = G[:nb, :nb].toarray() + rho * np.eye(nb)
    xb = np.linalg.solve(K - (B / d) @ B.T, r[:nb] - B @ (r[nb:] / d))
    x = np.concatenate([xb, (r[nb:] - B.T @ xb) / d])
    print(f"  exact Schur solve {1000*(time.time()-t):.0f} ms (forming the complement included); "
          f"relative residual {np.linalg.norm(G @ x + rho * x - r) / np.linalg.norm(r):.2e}")


def projection(widths):
    from concurrent.futures import ThreadPoolExecutor
    rng = np.random.default_rng(0)
    Ms = [(lambda M: (M + M.T) / 2)(rng.standard_normal((n, n))) for n in SIZES_Q27]

    def proj(M):
        ev, U = np.linalg.eigh(M)
        return (U * np.maximum(ev, 0)) @ U.T
    for w in widths:
        with ThreadPoolExecutor(w) as ex:
            best = 1e9
            for _ in range(3):
                t = time.time(); list(ex.map(proj, Ms)); best = min(best, time.time() - t)
        print(f"pool {w}: {best*1000:.0f} ms for the 102 q=27 blocks (min of 3)")


def cusolver(libdir="/opt/cuda/lib"):
    cudart = ctypes.CDLL(f"{libdir}/libcudart.so")
    cusolver_ = ctypes.CDLL(f"{libdir}/libcusolver.so")
    cublas = ctypes.CDLL(f"{libdir}/libcublas.so")
    c_void_p, c_int, c_double, c_size_t = ctypes.c_void_p, ctypes.c_int, ctypes.c_double, ctypes.c_size_t

    def chk(r, what):
        if r != 0:
            raise RuntimeError(f"{what} returned {r}")
    sync = getattr(cudart, "cudaSynchronize", None) or getattr(cudart, "cudaDeviceSynchronize")

    def malloc(nbytes):
        p = c_void_p(); chk(cudart.cudaMalloc(ctypes.byref(p), c_size_t(nbytes)), "cudaMalloc"); return p

    def h2d(dst, arr):
        chk(cudart.cudaMemcpy(dst, arr.ctypes.data_as(c_void_p), c_size_t(arr.nbytes), 1), "h2d")

    def d2h(arr, src):
        chk(cudart.cudaMemcpy(arr.ctypes.data_as(c_void_p), src, c_size_t(arr.nbytes), 2), "d2h")
    sh = c_void_p(); chk(cusolver_.cusolverDnCreate(ctypes.byref(sh)), "cusolverDnCreate")
    bh = c_void_p(); chk(cublas.cublasCreate_v2(ctypes.byref(bh)), "cublasCreate")
    rng = np.random.default_rng(0)
    maxn = max(SIZES_Q27)
    A = malloc(8 * maxn * maxn); W = malloc(8 * maxn); info = malloc(4); Uc = malloc(8 * maxn * maxn); Pd = malloc(8 * maxn * maxn)
    lw = c_int(); chk(cusolver_.cusolverDnDsyevd_bufferSize(sh, 1, 0, maxn, A, maxn, W, ctypes.byref(lw)), "bufferSize")
    work = malloc(8 * lw.value)
    n = 182
    M = (lambda X: (X + X.T) / 2)(rng.standard_normal((n, n)))
    h2d(A, np.asfortranarray(M)); chk(cusolver_.cusolverDnDsyevd(sh, 1, 0, n, A, n, W, work, lw, info), "syevd")
    ev = np.empty(n); d2h(ev, W)
    print("eigenvalue check against numpy:", bool(np.allclose(ev, np.linalg.eigvalsh(M))))
    h2d(A, np.asfortranarray((lambda X: (X + X.T) / 2)(rng.standard_normal((maxn, maxn)))))
    one, zero = c_double(1.0), c_double(0.0)
    best = 1e9
    for _ in range(3):
        sync(); t = time.time()
        for n in SIZES_Q27:
            chk(cusolver_.cusolverDnDsyevd(sh, 1, 0, n, A, n, W, work, lw, info), "syevd")
            chk(cublas.cublasDdgmm(bh, 1, n, n, A, n, W, 1, Uc, n), "dgmm")
            chk(cublas.cublasDgemm_v2(bh, 0, 1, n, n, n, ctypes.byref(one), Uc, n, A, n, ctypes.byref(zero), Pd, n), "dgemm")
        sync(); best = min(best, time.time() - t)
    print(f"cuSOLVER projection of the 102 q=27 blocks: {best*1000:.0f} ms (syevd + dgmm + dgemm, synchronised, min of 3)")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    a = sub.add_parser("arrowhead"); a.add_argument("--q", type=int, default=27); a.add_argument("--modulus", default="t^3-t-1")
    p = sub.add_parser("projection"); p.add_argument("--widths", default="1,8,16")
    sub.add_parser("cusolver")
    args = ap.parse_args()
    if args.cmd == "arrowhead":
        arrowhead(args.q, args.modulus if args.q == 27 else None)
    elif args.cmd == "projection":
        projection([int(w) for w in args.widths.split(",")])
    else:
        cusolver()


if __name__ == "__main__":
    main()
