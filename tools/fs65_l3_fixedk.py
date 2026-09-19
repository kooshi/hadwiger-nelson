#!/usr/bin/env python3
"""fs65_l3_fixedk -- the FIXED-CARDINALITY strengthening of the TRIPLE-LEVEL SDP (FS-65, from an
external review of 2026-09-18).

WHICH RELAXATION THIS IS, AND WHICH ONE YOU PROBABLY WANT.  This file strengthens FS-50's TRIPLE-LEVEL
programme (tools/fplane_sdp_blocks.py), whose largest variable is a 3-set.  The review's proposal was
for FS-54's LEVEL-3 (GLV L_3, tools/fs54_d4_quad.py), which carries 4-SET variables and is the
programme that read 80.59 at q = 19; its |T| = 3 equations -- 555 of the 573 -- have nowhere to land
here, so only |T| <= 2 fits and that is 18 equations at q = 19.  Use `fs54_d4_quad.py solve
--fixed-k K` for the real thing; data/fs62/q19/fixedk/README.md has both.

WHAT THIS ONE MEASURED, which is a null worth keeping: on the triple-level relaxation the
strengthening is worth EXACTLY INTEGER ROUNDING and nothing more.  f(k) = k for every k <= floor(N)
and f(k) = 1 above it, so the threshold is floor(14.0879) = 14 at q = 7 and floor(29.1769) = 29 at
q = 11 -- both of which the plain bound already gave.  That is the null the level-3 run has to beat.

WHAT THE TRIPLE-LEVEL RELAXATION HOLDS.  `tools/fplane_sdp_blocks.py` carries one variable per orbit
of an independent set CONTAINING THE ORIGIN of size 1, 2 or 3, under translations, rotations and the
reflection -- at q = 19 that is 1 + 17 + 555 = 573 live classes, which is the number the review
quotes.  Reading: y_T = P(T subset S | 0 in S) for a randomly placed maximum independent set S, so
Y[u,v] = y_{0,u,v}, Y[u,u] = Y[u,0] = y_{0,u}, Y[0,0] = 1, and tr Y = E[|S| | 0 in S].  The existing
relaxation MAXIMISES tr Y, which is why its answer is an upper bound on alpha.

WHAT THIS ADDS.  If |S| = k exactly then for every u, given {0,u} subset S, the number of v with
{0,u,v} subset S is exactly k -- counting v = 0 and v = u.  So

    sum_{v in V} Y[u,v] = k * Y[u,u]      for every u in V,

i.e. EVERY ROW SUM OF Y IS k TIMES ITS DIAGONAL.  Under the symmetry that is one equation per circle
plus one for the origin row, and the origin row is sum_v Y[0,v] = k, which says tr Y = k.

HOW THE TEST IS PUT, and why not as feasibility.  Impose the PER-CIRCLE equations at cardinality k
and keep MAXIMISING tr Y; call the value f(k).  A real independent set of size exactly k gives a
feasible point with tr Y = k, so f(k) >= k whenever such a set exists, and therefore

    f(k) < k   =>   no independent set of size k   =>   alpha < k,

since any larger independent set has an independent k-subset.  The first version of this file
instead imposed tr Y = k as well and asked SCS whether the system was feasible.  Same mathematics,
but the test is numerically degenerate exactly at the boundary: at q = 11, k = 28 -- where a 28-set
EXISTS and is on disk -- it returned a margin of -5e-08 and reported a refutation.  A test whose
false positive sits at the answer is not a test.  f(k) is a number in the units the unstrengthened
bound already has, and it degrades gracefully.

HOW MANY EQUATIONS, HONESTLY.  The review says 574 equations, "for independent T with |T| <= 3".
That count is the VARIABLE count, not the equation count: the equation for a 3-set T involves
y_{T + v}, a FOUR-set moment variable, and the triple-level relaxation does not carry one.  What the
existing variable set supports is exactly |T| <= 2, which is the row-sum family above --
**18 non-vacuous equations at q = 19**, not 574.  Extending to |T| = 3 is a level-4 relaxation and a
different, far larger object.  The 18 are still the whole cardinality content available here, and
the first of them alone is what converts a bound into a decision.

THE CONTROL, RUN BEFORE ANY SOLVER (--control).  From an ACTUAL independent set S, averaged over the
2(q+1) orthogonal maps, build the moment vector y directly and check: it is constant on the union-
find classes (which independently tests the block code's identification logic), it is 0 on the killed
classes, y[{0}] = 1, it satisfies every inequality the relaxation imposes, and it satisfies the new
equations at k = |S| EXACTLY.  A wrong equation shows up here, with no solver and no ambiguity.

Floats (SCS); readings, never bounds.  An exact certificate needs the rounding machinery of
tools/fs54_l3_cert_round.py and is not attempted here.
"""
import argparse, json, sys, time
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane_sdp_blocks as BL
import fplane_cert_check as CC


# ---------------------------------------------------------------- the moment vector of a real set

def orthogonal_images(S, pts):
    """the 2(q+1) images of a point set under the stabiliser of the origin (rotations and the
    reflection), as index sets.  Uses the block code's own zeta and field, never a second copy."""
    F = S["field"]; q = F.q; zeta = S["zeta"]
    fmul, fsub, fadd, fneg = F.mul, F.sub, F.add, F.neg
    cmul = lambda a, b: (fsub(fmul(a[0], b[0]), fmul(a[1], b[1])), fadd(fmul(a[0], b[1]), fmul(a[1], b[0])))
    rots = []
    z = (F.one, F.zero)
    for _ in range(S["m"]):
        rots.append(z); z = cmul(z, zeta)
    out = []
    for r in rots:
        for refl in (False, True):
            img = set()
            for (x, y) in pts:
                yy = fneg(y) if refl else y
                img.add(cmul(r, (x, yy)))
            out.append(img)
    return out


def canonical_y(S, pts):
    """y_T = (1/(|O| |S|)) sum_{o in O} |{t : T + t subset o(S)}|, for every profile index.

    Translation-invariant by construction and rotation-invariant by the average, so it must be
    constant on the union-find classes -- which is checked by the caller, not assumed."""
    F = S["field"]; q = F.q; m = S["m"]
    fadd = F.add
    idx = {}                                     # field point -> flat index, for numpy
    elems = []
    for x in range(q):
        for y in range(q):
            pass
    # the field's elements in the block code's own representation
    pts_all = sorted({(x, y) for x in range(q) for y in range(q)}) if F.f == 1 else None
    if pts_all is None:
        raise SystemExit("prime fields only here; a prime power needs the field's element list")
    for i, p in enumerate(pts_all):
        idx[p] = i
    N = len(pts_all)
    # shift tables: shift_of[u][t] = index of (t + u)
    shift = np.zeros((N, N), dtype=np.int32)
    for iu, u in enumerate(pts_all):
        for it, t in enumerate(pts_all):
            shift[iu, it] = idx[(fadd(t[0], u[0]), fadd(t[1], u[1]))]

    imgs = orthogonal_images(S, pts)
    masks = []
    for img in imgs:
        mask = np.zeros(N, dtype=np.float64)
        for p in img:
            mask[idx[p]] = 1.0
        masks.append(mask)
    k = len(pts)
    Z = len(masks) * k

    # every profile index, so the class-consistency check has something to check
    NP, C, classes, base, angle = S["NP"], S["C"], S["classes"], S["base"], S["angle"]
    Ntot = NP + C + 1
    yv = np.zeros(Ntot)
    F_ = S["field"]
    fmul, fsub, fadd2 = F_.mul, F_.sub, F_.add
    cmul = lambda a, b: (fsub(fmul(a[0], b[0]), fmul(a[1], b[1])), fadd2(fmul(a[0], b[1]), fmul(a[1], b[0])))
    zeta = S["zeta"]

    rolled = [[mask[shift[iu]] for iu in range(N)] for mask in masks]   # rolled[o][u][t] = o(S)[t+u]
    for ci_, c in enumerate(classes):
        u = base[c]; iu = idx[u]
        w = base[classes[0]]
        for cj, cp_ in enumerate(classes):
            w = base[cp_]
            for th in range(m):
                iv = idx[w]
                tot = 0.0
                for o in range(len(masks)):
                    tot += float(np.dot(masks[o] * rolled[o][iu], rolled[o][iv]))
                yv[S["idx_prof"](c, cp_, th)] = tot / Z
                w = cmul(w, zeta)
    for c in classes:
        iu = idx[base[c]]
        tot = 0.0
        for o in range(len(masks)):
            tot += float(np.dot(masks[o], rolled[o][iu]))
        yv[S["idx_zero"](c)] = tot / Z
    yv[NP + C] = 1.0                              # y_{0} = 1 by construction
    return yv


def class_vector(S, yv_idx):
    """collapse a per-index vector onto classes, and report the worst disagreement inside a class."""
    K = S["K"]; cls = S["cls"]
    out = np.zeros(K); cnt = np.zeros(K); lo = np.full(K, np.inf); hi = np.full(K, -np.inf)
    for i, v in enumerate(yv_idx):
        k = cls[i]; out[k] += v; cnt[k] += 1
        lo[k] = min(lo[k], v); hi[k] = max(hi[k], v)
    return out / np.maximum(cnt, 1), float(np.max(hi - lo))


# ---------------------------------------------------------------- the equations

def fixed_k_rows(S, k):
    """the row-sum equations as (coefficient dict over classes, right-hand side) pairs.

    row 0 (the origin, T = {0}):   y[g0] + m * sum_c y[diag(c)] = k          (tr Y = k)
    row c (T = {0, u_c}):          sum_{c',th} y[prof(c,c',th)] = (k-1) * y[diag(c)]
    """
    m, classes, cls = S["m"], S["classes"], S["cls"]
    rows = []
    coef = {S["g0"]: 1.0}
    for c in classes:
        d = int(S["diag_cls"][c]); coef[d] = coef.get(d, 0.0) + m
    rows.append(("origin", coef, float(k)))
    for c in classes:
        d = int(S["diag_cls"][c])
        coef = {}
        for cp_ in classes:
            for th in range(m):
                kk = int(cls[S["idx_prof"](c, cp_, th)])
                coef[kk] = coef.get(kk, 0.0) + 1.0
        coef[d] = coef.get(d, 0.0) - (k - 1.0)
        rows.append((f"circle {c}", coef, 0.0))
    return rows


def residuals(S, yc, k):
    return [(name, sum(v * yc[i] for i, v in coef.items()) - rhs) for name, coef, rhs in fixed_k_rows(S, k)]


# ---------------------------------------------------------------- the solve

def solve_bound(S, k, solver="SCS", verbose=False, solver_opts=None, real=True, origin_eq=False):
    """f(k) = max tr Y subject to the triple-level constraints AND the per-circle row-sum equations
    at cardinality k.  THE TEST IS f(k) < k.

    Why this and not a feasibility margin.  A real independent set of size exactly k gives a y that
    satisfies the per-circle equations at k and has tr Y = k, so f(k) >= k always holds when such a
    set exists.  Contrapositive: f(k) < k proves there is none, hence alpha < k.  The first attempt
    here imposed tr Y = k as well and asked a solver whether the system was feasible; that is the
    same mathematics but it is numerically degenerate exactly at the boundary -- at q = 11, k = 28,
    where a 28-set EXISTS and is on disk, the margin came back -5e-08 and the run reported a
    refutation.  A test whose false-positive lives at the answer is not a test.  f(k) is a number
    with units, the same units the unstrengthened bound already has, and it degrades gracefully.

    The origin row (tr Y = k) is deliberately NOT imposed: it would fix the objective and throw the
    quantity away.  --origin-eq puts it back for the feasibility reading."""
    import cvxpy as cp
    K = S["K"]; y = cp.Variable(K, nonneg=True)
    cons = [y[S["g0"]] == 1]
    for kk in np.nonzero(S["killed"])[0]:
        cons.append(y[int(kk)] == 0)
    seen = set()
    for c in S["classes"]:
        dc = S["diag_cls"][c]
        for cp_ in S["classes"]:
            for th in range(S["m"]):
                kk = int(S["cls"][S["idx_prof"](c, cp_, th)])
                if not S["killed"][kk] and (kk, dc) not in seen and kk != dc:
                    cons.append(y[kk] <= y[dc]); seen.add((kk, dc))
    neq = 0
    for name, coef, rhs in fixed_k_rows(S, k):                 # the strengthening
        if name == "origin" and not origin_eq:
            continue
        cons.append(sum(v * y[i] for i, v in coef.items()) == rhs); neq += 1
    Ymaps = BL.block_maps_real(S, "Y") if real else BL.block_maps(S, "Y")
    Mmaps = BL.block_maps_real(S, "M") if real else BL.block_maps(S, "M")
    for (j, d, A), (_, _, Am) in zip(Ymaps, Mmaps):
        D = d if real else 2 * d
        Yb = cp.reshape(A @ y, (D, D), order="C"); Mb = cp.reshape(Am @ y, (D, D), order="C")
        cons += [Yb >> 0, Mb - Yb >> 0]
    obj = y[S["g0"]] + S["m"] * sum(y[S["diag_cls"][c]] for c in S["classes"])      # tr Y
    prob = cp.Problem(cp.Maximize(obj), cons)
    prob.solve(solver=solver, verbose=verbose, **(solver_opts or {}))
    return prob.value, prob.status, y.value, neq


# ---------------------------------------------------------------- controls and CLI

def read_set(path, q):
    vals = [int(x) for x in Path(path).read_text().split()]
    return [(v // q, v % q) for v in vals]


def control(S, pts, tol=1e-9):
    """the feasibility control: an actual independent set must satisfy everything, exactly."""
    q = S["field"].q; k = len(pts)
    ok = True
    # it really is independent, from the definition, before it is used as a control
    Q = S["Q"]; F = S["field"]
    bad = [(a, b) for i, a in enumerate(pts) for b in pts[i + 1:]
           if Q((F.sub(a[0], b[0]), F.sub(a[1], b[1]))) == F.one]
    print(f"  the set: {k} points, {len(bad)} unit-distance pairs "
          f"{'PASS' if not bad else 'FAIL'}", flush=True)
    ok &= not bad

    yv = canonical_y(S, pts)
    yc, spread = class_vector(S, yv)
    print(f"  constant on the union-find classes: max spread {spread:.3e} "
          f"{'PASS' if spread < tol else 'FAIL'}", flush=True)
    ok &= spread < tol

    kz = float(np.max(np.abs(yc[S["killed"]]))) if S["killed"].any() else 0.0
    print(f"  zero on the killed classes: max |y| {kz:.3e} {'PASS' if kz < tol else 'FAIL'}", flush=True)
    ok &= kz < tol

    tr = yc[S["g0"]] + S["m"] * sum(yc[S["diag_cls"][c]] for c in S["classes"])
    print(f"  tr Y = {tr:.10f}, want {k}  {'PASS' if abs(tr - k) < 1e-8 else 'FAIL'}", flush=True)
    ok &= abs(tr - k) < 1e-8

    res = residuals(S, yc, k)
    worst = max(abs(r) for _, r in res)
    nz = [(n, r) for n, r in res if abs(r) > tol]
    print(f"  the {len(res)} fixed-cardinality equations at k = {k}: worst residual {worst:.3e} "
          f"{'PASS' if not nz else 'FAIL ' + str(nz[:3])}", flush=True)
    ok &= not nz

    # and they must FAIL at any other k -- an equation satisfied by every k constrains nothing
    for kk in (k - 1, k + 1):
        w = max(abs(r) for _, r in residuals(S, yc, kk))
        print(f"  the same equations at k = {kk}: worst residual {w:.3e} "
              f"{'PASS (they bite)' if w > 1e-6 else 'FAIL (vacuous)'}", flush=True)
        ok &= w > 1e-6
    return ok, yc


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--q", type=int, required=True)
    ap.add_argument("--k", type=int, help="the cardinality imposed; the question is its feasibility")
    ap.add_argument("--set", help="a file of vertex indices v = x*q + y, for --control")
    ap.add_argument("--control", action="store_true", help="check the equations on a real set and exit")
    ap.add_argument("--origin-eq", action="store_true",
                    help="also impose tr Y = k, which makes it a feasibility question and throws "
                         "away the quantity; the default keeps f(k) as a number")
    ap.add_argument("--complex-blocks", action="store_true")
    ap.add_argument("--eps", type=float, default=None)
    ap.add_argument("--max-iters", type=int, default=None)
    ap.add_argument("--verbose", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()

    t0 = time.time()
    S = BL.setup(CC.Field(a.q))
    live = S["K"] - int(S["killed"].sum())
    print(f"[l3k] q={a.q}: {S['C']} circles, {S['K']} classes ({live} live) in {time.time()-t0:.1f} s", flush=True)

    if a.control:
        if not a.set:
            ap.error("--control needs --set")
        pts = read_set(a.set, a.q)
        ok, _ = control(S, pts)
        print("CONTROL " + ("PASS" if ok else "FAIL"))
        return 0 if ok else 1

    if a.k is None:
        ap.error("--k is required unless --control")
    opts = {}
    if a.eps: opts["eps"] = a.eps
    if a.max_iters: opts["max_iters"] = a.max_iters
    t1 = time.time()
    val, st, yv, neq = solve_bound(S, a.k, verbose=a.verbose, solver_opts=opts,
                                   real=not a.complex_blocks, origin_eq=a.origin_eq)
    dt = time.time() - t1
    refuted = val is not None and st in ("optimal", "optimal_inaccurate") and val < a.k - 1e-6
    print(f"[l3k] q={a.q} k={a.k}: f(k) = {val:.6f} against k = {a.k}  "
          f"({'REFUTED' if refuted else 'not refuted'}; {neq} equations, status {st}) in {dt:.1f} s",
          flush=True)
    if refuted:
        print(f"       => no independent set of size {a.k}, so alpha(UD(F_{a.q},2)) <= {a.k - 1}, "
              f"as a FLOAT READING (not a certificate)", flush=True)
    rec = dict(kind="fs65-l3-fixedk", q=a.q, k=a.k, classes=int(S["K"]), live=live,
               f_of_k=None if val is None else float(val), status=st, refuted=bool(refuted),
               equations=neq, origin_eq=bool(a.origin_eq), seconds=round(time.time() - t0, 1),
               claim_scope="f(k) = max tr Y over the triple-level relaxation with the per-circle "
                           "fixed-cardinality row-sum equations imposed at cardinality k. A real "
                           "independent set of size exactly k yields a feasible point with tr Y = k, "
                           "so f(k) < k proves no such set exists, hence alpha < k (any larger "
                           "independent set has a k-subset). It rests on SCS's floats and is NOT a "
                           "certificate; f(k) >= k proves nothing.")
    if a.out:
        Path(a.out).write_text(json.dumps(rec, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
