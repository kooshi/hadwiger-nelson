"""The EXACT minimum refusing selection, by implicit hitting set -- Parts's reduction in its
modern form, and the thing this project has never run.

**What `[Parts2020a]` §5.5 actually describes.** A *hyperedge* of his hypergraph `Y` is a set of
vertices whose simultaneous deletion loses refusal; the reduction then checks the subgraphs that
contain at least one vertex of every hyperedge, **in increasing order of size**, and stops at the
first that refuses -- so it lands on the MINIMUM, not on a 1-minimal object. Our single-deletion
census is precisely his degree-1 layer, and until now nothing here went past it. Nine greedy
descents delete 147-174 vertices of 756 where a 510-vertex answer must delete 247.

**The loop, and why every step is sound.** A hyperedge is a **correction set**: colourability is
downward closed, so if `keep \\ C` is four-colourable then every selection avoiding `C` is
colourable, hence **every refusing selection meets `C`**. So

    h  :=  minimum-weight hitting set of the correction sets found so far      (a MaxSAT solve)
    if h refuses            ->  h is OPTIMAL: it is a lower bound that is attained
    else                    ->  its own colouring, extended greedily, yields a maximal colourable
                                T containing h, and `keep \\ T` is a NEW correction set that h
                                does not meet -- so the next hitting set differs and the weight
                                of `h` is non-decreasing.

`weight(h)` is a **rigorous lower bound at every iteration**, rising monotonically; the best
refuting selection seen is the upper bound. **The pair is the product** -- a run stopped early
still reports a sandwich, and the sandwich closing is a proof of optimality rather than a
1-minimality certificate.

**What an `unknown` does.** Nothing: no model, so no correction set, so no constraint. Folding it
either way would let the hitting-set value stop being a lower bound, which is `gmus.py`'s Rule 2
and the reason a budgeted run here still reports honestly.
"""
from __future__ import annotations
import sys, os, json, time, pickle, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--state", required=True)
    ap.add_argument("--keep", default="", help="json list of group indices; default all")
    ap.add_argument("--out", required=True)
    ap.add_argument("--seed-corr", default="", help="jsonl of correction sets to start from")
    ap.add_argument("--budget", type=int, default=0)
    ap.add_argument("--iters", type=int, default=10 ** 7)
    ap.add_argument("--wall", type=float, default=0.0)
    a = ap.parse_args()
    d = pickle.load(open(a.state, "rb"))
    hard, pres, weights = d["hard"], d["pres"], d["weights"]
    members, edges, nv, centre = d["members"], d["edges"], d["nv"], d["centre"]
    keep = sorted(json.load(open(a.keep))) if a.keep else sorted(range(len(weights)))
    kset = set(keep)
    nbr = [[] for _ in range(nv)]
    for (u, v) in edges:
        nbr[u].append(v); nbr[v].append(u)
    t0 = time.time(); log = lambda m: print(f"[{time.time()-t0:7.0f}s] {m}", flush=True)
    log(f"exact reduction over {len(keep)} groups / {sum(weights[g] for g in keep)} vertices, "
        f"fingerprint {d.get('fingerprint','UNSET')}")
    from pysat.solvers import Solver
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    corr = []
    if a.seed_corr and os.path.exists(a.seed_corr):
        for ln in open(a.seed_corr):
            try: c = sorted(set(json.loads(ln)) & kset)
            except Exception: continue
            if c: corr.append(c)
        log(f"  seeded with {len(corr)} correction sets")
    ub, ub_set = sum(weights[g] for g in keep), list(keep)
    lb = 0
    with Solver(name=d.get("solver", "cadical153"), bootstrap_with=hard) as s:
        def ask(sel):
            aa = [pres[x] for x in sorted(sel)]
            if a.budget:
                s.conf_budget(a.budget)
                return s.solve_limited(assumptions=aa, expect_interrupt=False)
            return s.solve(assumptions=aa)

        if ask(keep) is not False:
            log("  the starting selection does not refuse -- nothing to reduce"); return
        for it in range(a.iters):
            if a.wall and time.time() - t0 > a.wall:
                log("  wall reached"); break
            w = WCNF()
            for c in corr: w.append([g + 1 for g in c])
            for g in keep: w.append([-(g + 1)], weight=weights[g])
            with RC2(w) as rc:
                mod = rc.compute()
            h = sorted(g for g in keep if mod[g] > 0)
            hw = sum(weights[g] for g in h)
            if hw > lb: lb = hw
            r = ask(h)
            if r is False:
                log(f"  it {it}: hitting set of weight {hw} REFUSES -- lower bound meets upper "
                    f"bound: this is the EXACT MINIMUM ({hw} vertices + the hard centre)")
                ub, ub_set = hw, h
                json.dump(dict(kind="exact-minimum", optimal=True, weight=hw, keep=h,
                               correction_sets=len(corr), iterations=it + 1,
                               fingerprint=d.get("fingerprint"),
                               seconds=round(time.time() - t0, 1)), open(a.out, "w"), indent=1)
                return
            if r is None:
                log(f"  it {it}: hitting set undecided at budget -- no correction set, no "
                    f"constraint; stopping rather than folding it either way"); break
            model = s.get_model()
            col = {centre: next(c for c in range(4) if model[centre * 4 + c] > 0)}
            for g in h:
                v = members[g][0]
                for c in range(4):
                    if model[v * 4 + c] > 0: col[v] = c; break
            left = [g for g in keep if g not in set(h)]
            moved = True
            while moved:
                moved = False
                for g in list(left):
                    v = members[g][0]
                    used = {col[wv] for wv in nbr[v] if wv in col}
                    free = [c for c in range(4) if c not in used]
                    if free:
                        col[v] = free[0]; left.remove(g); moved = True
            if not left:
                log("  greedy extension coloured everything -- the selection does not refuse; stop")
                break
            # SHRINK the correction set to a MINIMAL one. A greedily-extended colouring leaves a
            # correction set that is valid but fat -- measured on the 757 object, ~148 vertices,
            # and 695 such sets moved the bound only from 145 to 147. A set is minimal when no
            # member can be given back, and each test is a COLOURABLE ask, which on a sub-critical
            # selection measures 0.00-0.02 s. Small sets are what make a hitting-set bound climb.
            left = sorted(left)
            i = 0
            while i < len(left):
                trial = left[:i] + left[i + 1:]
                if not trial: break
                rr = ask([g for g in keep if g not in set(trial)])
                if rr is True: left = trial            # still a correction set without that member
                else: i += 1
            corr.append(sorted(left))
            if it % 25 == 0 or it < 5:
                log(f"  it {it}: LB {lb}  <=  minimum  <=  UB {ub}   "
                    f"({len(corr)} correction sets, smallest {min(len(c) for c in corr)}, "
                    f"newest {len(left)})")
            json.dump(dict(kind="exact-reduction-in-progress", optimal=False,
                           lower_bound=lb, upper_bound=ub, correction_sets=len(corr),
                           iterations=it + 1, fingerprint=d.get("fingerprint"),
                           seconds=round(time.time() - t0, 1),
                           scope="LB is the minimum-weight hitting set of the correction sets found "
                                 "SO FAR -- rigorous and monotonically rising; UB is the best "
                                 "selection witnessed to refuse. The pair is the product."),
                      open(a.out, "w"), indent=1)
    log(f"FINAL sandwich: {lb} <= minimum <= {ub} vertices")


if __name__ == "__main__":
    main()
