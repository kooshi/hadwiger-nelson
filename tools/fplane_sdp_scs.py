#!/usr/bin/env python3
"""fplane_sdp_scs — the real-block triple-level SDP (fplane_sdp_blocks, --real) driven through SCS's own API in CHUNKS with
warm-start checkpoints, so a long solve at p = 83 is observable (one line per chunk: iterations, primal/dual residuals, gap,
objective) and resumable (the iterate x, y, s is saved to --ckpt after every chunk; a relaunch continues from it).
Written after two eight-hour solves were lost to their walls with nothing on disk (2026-09-15). The value is a reading;
the certificate is the producer's (fplane_cert_round.py --blocks --real)."""
import argparse, json, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane_sdp_blocks as F

def build_problem(p):
    import cvxpy as cp
    S = F.setup(p); K = S["K"]; y = cp.Variable(K, nonneg=True)
    cons = [y[S["g0"]] == 1]
    for k in np.nonzero(S["killed"])[0]: cons.append(y[int(k)] == 0)
    seen = set()
    for c in S["classes"]:
        dc = S["diag_cls"][c]
        for cp_ in S["classes"]:
            for th in range(S["m"]):
                k = int(S["cls"][S["idx_prof"](c, cp_, th)])
                if not S["killed"][k] and (k, dc) not in seen and k != dc:
                    cons.append(y[k] <= y[dc]); seen.add((k, dc))
    for (j, d, A), (_, _, Am) in zip(F.block_maps_real(S, "Y"), F.block_maps_real(S, "M")):
        Yb = cp.reshape(A @ y, (d, d), order="C"); Mb = cp.reshape(Am @ y, (d, d), order="C")
        cons += [Yb >> 0, Mb - Yb >> 0]
    obj = y[S["g0"]] + S["m"] * sum(y[S["diag_cls"][c]] for c in S["classes"])
    prob = cp.Problem(cp.Maximize(obj), cons)
    return S, prob, y

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True); ap.add_argument("--eps", type=float, default=1e-5)
    ap.add_argument("--chunk", type=int, default=2000); ap.add_argument("--max-iters", type=int, default=400000)
    ap.add_argument("--ckpt", required=True); ap.add_argument("--out"); ap.add_argument("--indirect", action="store_true", help="SCS's conjugate-gradient linear solver instead of the cached direct factorisation"); ap.add_argument("--stop-after-chunks", type=int, default=0, help="(control) exit after this many chunks")
    a = ap.parse_args()
    import cvxpy as cp, scs
    t0 = time.time(); S, prob, yvar = build_problem(a.p)
    print(f"[scs] p={a.p}: {S['K']} classes; building SCS data …", flush=True)
    data, chain, inv = prob.get_problem_data(cp.SCS)
    dims = data["dims"]; cone = dict(z=int(dims.zero), l=int(dims.nonneg), s=[int(x) for x in dims.psd])
    A, b, c = data["A"], data["b"], data["c"]
    print(f"[scs] A {A.shape} nnz {A.nnz}; {len(cone['s'])} PSD blocks ≤ {max(cone['s'])}; setup {time.time()-t0:.0f} s", flush=True)
    ck = Path(a.ckpt); x0 = y0 = s0 = None; done_iters = 0
    if ck.exists():
        z = np.load(ck); x0, y0, s0, done_iters = z["x"], z["y"], z["s"], int(z["iters"]); print(f"[scs] resumed from {ck}: {done_iters} iterations done", flush=True)
    solver = scs.SCS(dict(A=A, b=b, c=c), cone, use_indirect=a.indirect, eps_abs=a.eps, eps_rel=a.eps, max_iters=a.chunk, verbose=False, normalize=True)
    chunks = 0; result = None
    while done_iters < a.max_iters:
        t1 = time.time()
        if x0 is not None: result = solver.solve(warm_start=True, x=x0, y=y0, s=s0)
        else: result = solver.solve()
        info = result["info"]; x0, y0, s0 = result["x"], result["y"], result["s"]; done_iters += int(info["iter"]); chunks += 1
        np.savez(ck, x=x0, y=y0, s=s0, iters=done_iters)
        print(f"[scs] chunk {chunks}: +{info['iter']} it ({done_iters} total), {time.time()-t1:.0f} s, pobj {info['pobj']:.5f} dobj {info['dobj']:.5f} "
              f"res_pri {info['res_pri']:.2e} res_dual {info['res_dual']:.2e} gap {info['gap']:.2e} status {info['status']}", flush=True)
        if info["status"].lower().startswith("solved"): break
        if a.stop_after_chunks and chunks >= a.stop_after_chunks: print("[scs] stopping after the requested chunks (control)", flush=True); return
    sol = chain.solvers[-1].invert(result, inv[-1]); prob.unpack_results(sol, chain, inv)
    value = float(prob.value); status = result["info"]["status"]
    print(f"[scs] VALUE at p={a.p} (real blocks): {value:.6f}  status {status}  {done_iters} iterations  {time.time()-t0:.0f} s", flush=True)
    if a.out:
        Path(a.out).write_text(json.dumps(dict(kind="fplane-sdp-scs", p=a.p, n=a.p * a.p, real_blocks=True, value=value, status=status, iterations=done_iters,
            eps=a.eps, seconds=time.time() - t0, ckpt=str(ck), claim_scope="a float reading of the block-diagonalised (real) triple-level SDP through SCS in warm-started chunks; never a bound"), indent=1))
        print(f"  wrote {a.out}", flush=True)

if __name__ == "__main__":
    main()
