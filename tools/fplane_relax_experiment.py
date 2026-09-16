"""FS-53 phase B item 0: do the extra le_diag rows bind?

ONE module (fplane_sdp_blocks), ONE solve path (real blocks), ONE solver (SCS), ONE tolerance, ONE
backend (CPU).  EXACTLY ONE thing differs between the arms: the le_diag constraint list.

  arm "all"  -- the TIGHTER relaxation: y[k] <= y[diag(c)] for EVERY diagonal class c the orbit k
                appears under (what tools/fplane_sdp_blocks.py and fplane_sdp_scs.py solve).
  arm "one"  -- the CERTIFIED shape: at most ONE le_diag row per orbit k (what the frozen checker's
                canonical list carries, one per orbit).
  arm "none" -- THE PLANT.  No le_diag rows at all.  The optimum MUST rise strictly; if it does not,
                this instrument cannot see the constraint class and its "inactive" verdict is empty.

Denominators spelled out: each number is the optimum of the block-diagonalised triple-level SDP over
the SAME variable set, at eps_abs = eps_rel = 1e-8, SCS on the CPU, real blocks.
"""
import json, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import fplane_sdp_blocks as F
import fplane_cert_check as CC
import cvxpy as cp

def solve_arm(S, arm, eps, max_iters):
    K = S["K"]; y = cp.Variable(K, nonneg=True)
    cons = [y[S["g0"]] == 1]
    if arm != "nokilled":
        for k in np.nonzero(S["killed"])[0]:
            cons.append(y[int(k)] == 0)
    seen = set(); seen_k = set(); nrows = 0
    if arm != "none":
        for c in S["classes"]:
            dc = S["diag_cls"][c]
            for cp_ in S["classes"]:
                for th in range(S["m"]):
                    k = int(S["cls"][S["idx_prof"](c, cp_, th)])
                    if S["killed"][k] or k == dc:
                        continue
                    if (k, dc) in seen:
                        continue
                    if arm == "one" and k in seen_k:
                        continue
                    cons.append(y[k] <= y[dc]); seen.add((k, dc)); seen_k.add(k); nrows += 1
    Ymaps = F.block_maps_real(S, "Y"); Mmaps = F.block_maps_real(S, "M")
    for (j, d, A), (_, _, Am) in zip(Ymaps, Mmaps):
        Yb = cp.reshape(A @ y, (d, d), order="C"); Mb = cp.reshape(Am @ y, (d, d), order="C")
        cons += [Yb >> 0, Mb - Yb >> 0]
    obj = y[S["g0"]] + S["m"] * sum(y[S["diag_cls"][c]] for c in S["classes"])
    prob = cp.Problem(cp.Maximize(obj), cons)
    t0 = time.time()
    prob.solve(solver="SCS", eps_abs=eps, eps_rel=eps, max_iters=max_iters)
    return dict(arm=arm, le_diag_rows=nrows, value=float(prob.value), status=prob.status,
                seconds=round(time.time() - t0, 1),
                scs_iters=int(prob.solver_stats.num_iters or 0))

def main():
    q = int(sys.argv[1]); modulus = sys.argv[2] if len(sys.argv) > 2 and sys.argv[2] != "-" else None
    eps = 1e-8; max_iters = 200000
    field = CC.Field(q, modulus) if modulus else CC.Field(q)
    t0 = time.time(); S = F.setup(field)
    print(f"[exp] {field.source}: {S['C']} circles, {S['K']} profile classes, "
          f"{int(S['killed'].sum())} killed; setup {time.time()-t0:.1f} s", flush=True)
    out = []
    for arm in ("all", "one", "none", "nokilled"):
        r = solve_arm(S, arm, eps, max_iters)
        out.append(r)
        print(f"[exp] q={q} arm={arm:4s} le_diag rows={r['le_diag_rows']:7d} "
              f"value={r['value']:.6f} ({r['status']}, {r['scs_iters']} iters, {r['seconds']} s)", flush=True)
    a = next(r for r in out if r["arm"] == "all"); o = next(r for r in out if r["arm"] == "one")
    n = next(r for r in out if r["arm"] == "none")
    print(f"[exp] q={q} TIGHTER(all) {a['value']:.6f}  vs  CERTIFIED-SHAPE(one) {o['value']:.6f}  "
          f"difference {o['value']-a['value']:+.3e}", flush=True)
    nk = next(r for r in out if r["arm"] == "nokilled")
    reach = nk["value"] > a["value"] + 1e-6
    print(f"[exp] q={q} REACHABILITY CONTROL (the killed-orbit equalities dropped instead) "
          f"{nk['value']:.6f}: {'FIRED (rose by %.6f) - the instrument DOES detect a constraint class being dropped' % (nk['value']-a['value']) if reach else 'DID NOT FIRE - this instrument cannot detect ANY dropped class; every verdict above is empty'}", flush=True)
    plant_fired = n["value"] > a["value"] + 1e-6
    print(f"[exp] q={q} PLANT (no le_diag at all) {n['value']:.6f}: "
          f"{'FIRED (rose by %.6f) - the instrument can see this constraint class' % (n['value']-a['value']) if plant_fired else 'DID NOT FIRE - the verdict below is EMPTY'}", flush=True)
    rec = dict(kind="fs53-le-diag-experiment", **CC._ident(field), eps=eps, solver="SCS",
               backend="cpu", real_blocks=True, arms=out, plant_fired=bool(plant_fired), reachability_control_fired=bool(reach),
               claim_scope="float readings of one relaxation's optimum under three le_diag lists; "
                           "one module, one solve path, one solver, one tolerance, one backend, the "
                           "constraint list the only thing differing; never a bound")
    Path(sys.argv[3] if len(sys.argv) > 3 else f"/tmp/exp-q{q}.json").write_text(json.dumps(rec, indent=1))

main()
