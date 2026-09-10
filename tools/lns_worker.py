"""Large-neighbourhood search by STRICTLY FAVOURABLE SWAPS: drop `r` vertices, put back fewer.

**Why a portfolio of descents cannot reach the target, with the number.** Nine random-order
1-minimal descents from the 757-vertex closure land at 582, 586, 589, 593, 595, 598, 599, 599, 609
-- mean 594.4, standard deviation 7.6. Heule's own 510, which those descents all contain and which
is exactly vertex-critical, is **eleven standard deviations below that mean.** The minimum of `N`
samples improves like `sqrt(2 ln N)`, so no number of orders and no amount of parallelism gets
there: the distribution has to MOVE, not be resampled. Moving it needs a move that adds material,
which a descent by construction cannot make -- `[Parts2020a]` §5.6's sentence, measured.

**The neighbourhood, and the version of it that was wrong.** The first draft destroyed `r` vertices
and repaired from a pool that CONTAINED them. Measured on one iteration: it re-added 96 of 100,
grew a 509-vertex object to 585, and then spent about a hundred asks -- most of them the expensive
refuting kind, 2-20 s each -- trimming back toward where a plain descent lands anyway. An LNS that
is a slow re-run of the thing it exists to beat.

So the neighbourhood is a swap that must PAY: destroy `r`, repair from material currently OUTSIDE
the selection, and refuse to spend `r` or more. A failing iteration is then about `log2(r)`
COLOURABLE asks, measured at 0.00-0.9 s; only an iteration that is about to improve pays a refusing
ask. Failure is cheap and success is what costs, which is the right way round.

**What a reported weight means.** Every accepted iterate REFUSES four colours -- an exhibited
refutation under the recorded fingerprint -- so it is a genuine upper bound. Minimality is NOT
claimed here; only an independent census certifies that, and it is run separately.
"""
import sys, os, json, time, pickle, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

sp, seed, iters, destroy, budget, outp = (sys.argv[1], int(sys.argv[2]), int(sys.argv[3]),
                                          int(sys.argv[4]), int(sys.argv[5]), sys.argv[6])
width = int(sys.argv[7]) if len(sys.argv) > 7 else 6
d = pickle.load(open(sp, "rb"))
hard, pres, weights = d["hard"], d["pres"], d["weights"]
keep = set(d["start"]); m = len(pres)
rng = random.Random(seed)
from pysat.solvers import Solver
t0 = time.time(); asks = [0]
best = (sum(weights[g] for g in keep), sorted(keep))
hist = []
if os.path.exists(outp):
    try:
        prev = json.load(open(outp))
        if prev.get("best_keep"):
            keep = set(prev["best_keep"]); best = (prev["best_weight"], prev["best_keep"])
        hist = prev.get("history", [])
    except Exception:
        pass


def save(note=""):
    json.dump(dict(seed=seed, destroy=destroy, width=width, best_weight=best[0],
                   best_keep=best[1], asks=asks[0], iterations=len(hist),
                   accepted=sum(1 for h in hist if h.get("accepted")),
                   history=hist[-300:], seconds=round(time.time() - t0, 1), note=note),
              open(outp, "w"))


with Solver(name=d.get("solver", "cadical153"), bootstrap_with=hard) as s:
    def refuses(sel):
        asks[0] += 1
        a = [pres[x] for x in sorted(sel)]
        if budget:
            s.conf_budget(budget)
            return s.solve_limited(assumptions=a, expect_interrupt=False)
        return s.solve(assumptions=a)

    for it in range(iters):
        r = destroy
        R = set(rng.sample(sorted(keep), min(r, len(keep) - 1)))
        base = keep - R
        outside = sorted(set(range(m)) - keep)
        if not outside:
            break
        pool = rng.sample(outside, min(width * r, len(outside)))
        cap = r - 1                            # anything costing r or more is not an improvement
        found, k, prev = None, 1, 0
        while k <= cap:
            kk = min(k, cap)
            if refuses(base | set(pool[:kk])) is False:
                found = kk; break
            prev = kk
            if kk >= cap: break
            k *= 2
        if found is not None and found > prev + 1:
            lo, hi = prev + 1, found - 1
            while lo <= hi:
                mid = (lo + hi) // 2
                if refuses(base | set(pool[:mid])) is False: found = mid; hi = mid - 1
                else: lo = mid + 1
        if found is None:
            hist.append(dict(it=it, verdict="no-cheaper-swap", destroyed=len(R)))
            if it % 500 == 0:
                print(f"  s{seed}(r={r}) it{it:6d}: no swap cheaper than {r} "
                      f"[best {best[0]}, ask {asks[0]}, {time.time()-t0:.0f}s]",
                      file=sys.stderr, flush=True)
            if it % 200 == 199: save()
            continue
        cand = base | set(pool[:found])
        w = sum(weights[g] for g in cand)
        hist.append(dict(it=it, destroyed=len(R), repaired=found, weight=w, accepted=w < best[0]))
        print(f"  s{seed}(r={r}) it{it:6d}: SWAP -{len(R)} +{found} -> {w:5d} vertices"
              f"{'   ACCEPT' if w < best[0] else ''} [ask {asks[0]}, {time.time()-t0:.0f}s]",
              file=sys.stderr, flush=True)
        if w < best[0]: best = (w, sorted(cand))
        keep = cand
        save()
save("done")
print(json.dumps(dict(seed=seed, best_weight=best[0], asks=asks[0], iterations=len(hist))))
