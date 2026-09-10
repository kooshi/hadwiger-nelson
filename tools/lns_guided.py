"""Colouring-guided repair: choose the vertices that kill the colourings, not a random prefix.

**Why the random version fails, measured.** A swap-LNS that repairs `base` with a random PREFIX of
outside material ran 8,000 iterations in 120 s from Heule-510 and from a 582-vertex 1-minimal
object and found **not one improving swap**. It is fast and it is blind: a prefix of a shuffled
pool tests a vanishing fraction of the subsets, and the repairing subsets are specific.

**What replaces it is this project's own kill engine (M49 §R8, M50), one level up.** After removing
`r` vertices the selection is four-colourable, so the job of the repair is exactly to **destroy
every one of its colourings**. A colouring `c` of `base` is destroyed by an outside vertex `v`
precisely when `v`'s neighbours inside `base` already wear all four colours under `c` -- a bitmask
test, no solver. So:

  harvest colourings of `base`  ->  score each outside vertex by which colourings it kills
  ->  greedy set cover over the harvest  ->  ONE ask to confirm the cover really refuses.

Colourings are harvested under random unit assumptions rather than by blocking the previous model,
because blocking returns near-identical colourings and diversity is the whole point of the harvest.

**The economics, and they are why this is the move.** Harvesting a colouring of a sub-critical
selection measures 0.00-0.02 s; the confirming refutation measures 2-20 s. So the search spends its
time in the cheap verdict and pays the expensive one only when it has a candidate that a hitting-set
argument already says should work -- the same inversion `typem.grow_to_refusal` records for growth
against deletion.

**Claim scope.** An accepted iterate is a selection whose refutation was EXHIBITED under the
recorded fingerprint: an upper bound. A cover that fails its confirming ask is discarded and the
harvest grows -- a failed cover is evidence about the harvest, never about the object.
"""
import sys, os, json, time, pickle, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

sp, seed, iters, destroy, budget, outp = (sys.argv[1], int(sys.argv[2]), int(sys.argv[3]),
                                          int(sys.argv[4]), int(sys.argv[5]), sys.argv[6])
HARVEST = int(sys.argv[7]) if len(sys.argv) > 7 else 48
d = pickle.load(open(sp, "rb"))
hard, pres, weights = d["hard"], d["pres"], d["weights"]
members, edges, nv, centre = d["members"], d["edges"], d["nv"], d["centre"]
vof = {m[0]: g for g, m in enumerate(members)}          # vertex granularity: one vertex per group
nbr = [[] for _ in range(nv)]
for (u, v) in edges:
    nbr[u].append(v); nbr[v].append(u)
keep = set(json.load(open(d["start_file"])) if "start_file" in d else d["start"])
m = len(pres)
rng = random.Random(seed)
from pysat.solvers import Solver
t0 = time.time(); asks = [0]; harvests = [0]
best = (sum(weights[g] for g in keep), sorted(keep))
stats = dict(iterations=0, covers_tried=0, covers_confirmed=0, accepted=0)


def save(note=""):
    json.dump(dict(seed=seed, destroy=destroy, harvest=HARVEST, best_weight=best[0],
                   best_keep=best[1], asks=asks[0], harvest_solves=harvests[0],
                   seconds=round(time.time() - t0, 1), note=note, **stats), open(outp, "w"))


with Solver(name=d.get("solver", "cadical153"), bootstrap_with=hard) as s:
    def refuses(sel):
        asks[0] += 1
        a = [pres[x] for x in sorted(sel)]
        if budget:
            s.conf_budget(budget)
            return s.solve_limited(assumptions=a, expect_interrupt=False)
        return s.solve(assumptions=a)

    def colourings(sel, want):
        """`want` proper four-colourings of `sel`, diversified by random unit assumptions."""
        verts = [centre] + [members[g][0] for g in sel]
        out = []
        for _ in range(want):
            extra = []
            for _ in range(6):
                v = rng.choice(verts); extra.append(v * 4 + rng.randrange(4) + 1)
            harvests[0] += 1
            r = s.solve(assumptions=[pres[x] for x in sorted(sel)] + extra)
            if r is not True:
                harvests[0] += 1
                r = s.solve(assumptions=[pres[x] for x in sorted(sel)])
                if r is not True: return out
            mod = s.get_model()
            col = {}
            for v in verts:
                for c in range(4):
                    if mod[v * 4 + c] > 0: col[v] = c; break
            out.append(col)
        return out

    def killers(col, cur_verts):
        """Outside groups whose neighbourhood inside the selection is RAINBOW under `col` -- adding
        any one of them makes `col` unextendable, which is the only way a single vertex can destroy
        a colouring."""
        out = []
        for g in range(m):
            if g in cur_verts: continue
            v = members[g][0]; seen = 0
            for w in nbr[v]:
                c = col.get(w)
                if c is not None: seen |= 1 << c
            if seen == 15: out.append(g)
        return out

    seen_cols = []
    for it in range(iters):
        stats["iterations"] = it + 1
        r = destroy
        R = set(rng.sample(sorted(keep), min(r, len(keep) - 1)))
        cur = keep - R
        added = []
        # COUNTEREXAMPLE-GUIDED repair: ask, take the colouring the solver hands back, and add a
        # vertex that this very colouring cannot survive. Each step is one COLOURABLE ask (0.00-
        # 0.02 s measured); the loop ends either at a refutation or at the budget `r-1`, past which
        # the swap could not pay for itself.
        while True:
            asks[0] += 1
            a_ = [pres[x] for x in sorted(cur)]
            if budget:
                s.conf_budget(budget); res = s.solve_limited(assumptions=a_, expect_interrupt=False)
            else:
                res = s.solve(assumptions=a_)
            if res is False: break
            if res is None: added = None; break
            mod = s.get_model()
            col = {centre: next(c for c in range(4) if mod[centre * 4 + c] > 0)}
            for g in cur:
                v = members[g][0]
                for c in range(4):
                    if mod[v * 4 + c] > 0: col[v] = c; break
            if len(added) >= r - 1: added = None; break
            ks = killers(col, cur)
            if not ks: added = None; break
            seen_cols.append(col); seen_cols[:] = seen_cols[-64:]
            def score(g):
                v = members[g][0]; n = 0
                for c2 in seen_cols:
                    sn = 0
                    for w in nbr[v]:
                        cc = c2.get(w)
                        if cc is not None: sn |= 1 << cc
                    if sn == 15: n += 1
                return n
            g = max(rng.sample(ks, min(24, len(ks))), key=score)
            cur = cur | {g}; added.append(g)
        if added is None:
            if it % 200 == 0:
                print(f"  s{seed}(r={r}) it{it:6d}: no swap under {r} "
                      f"[best {best[0]}, ask {asks[0]}, {time.time()-t0:.0f}s]",
                      file=sys.stderr, flush=True)
            if it % 100 == 99: save()
            continue
        stats["covers_confirmed"] += 1
        w = sum(weights[g] for g in cur)
        print(f"  s{seed}(r={r}) it{it:6d}: SWAP -{len(R)} +{len(added)} -> {w:5d}"
              f"{'   ACCEPT' if w < best[0] else ''} [ask {asks[0]}, {time.time()-t0:.0f}s]",
              file=sys.stderr, flush=True)
        if w < best[0]:
            best = (w, sorted(cur)); stats["accepted"] += 1
        keep = cur
        save()
save("done")
print(json.dumps(dict(seed=seed, best_weight=best[0], asks=asks[0], **stats)))
