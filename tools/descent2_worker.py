"""One joint-drop order (phase 2), by BINARY SEARCH on a prefix rather than by halving a chunk.

**The monotonicity that makes this logarithmic.** Fix an order `g1..gn` of the candidates and let
`P_k` be `keep` with the first `k` removed. Refusal is UPWARD closed -- more vertices can only make
four-colouring harder -- and `P_k` is a subset of `P_{k-1}`, so *if `P_k` refuses then `P_{k-1}`
refuses*. The predicate is monotone in `k`, so the largest droppable prefix is found in
`log2(n)` asks instead of `n`. And `P_1` always refuses, because phase 1 witnessed every candidate
droppable BY ITSELF -- so every round drops at least one vertex and the loop cannot stall.

The first candidate that fails is critical for the new selection: a permanent witness, free, with
no ask of its own.

What the order buys is the local minimum: a different order reaches a different 1-minimal set,
which is `plans/DESCENT-ALGORITHM.md` (WO-9)'s finding and the reason several orders run at once.
"""
import sys, os, json, time, pickle, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

VERDICT = {True: "colourable", False: "refuses", None: "undecided"}
sp, seed, budget, outp = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
d = pickle.load(open(sp, "rb"))
hard, pres, weights = d["hard"], d["pres"], d["weights"]
keep, cand = set(d["keep"]), list(d["cand"])
keep0 = sorted(keep)
members = d.get("members", [[g] for g in range(len(pres))])
_ingrp = {v for m in members for v in m}
hardv = [v for v in range(d.get("nv", 0)) if v not in _ingrp]
nbr = {}
for (u, v) in d.get("edges", ()):
    nbr.setdefault(u, []).append(v); nbr.setdefault(v, []).append(u)
corr = open(outp.replace(".json", ".corr.jsonl"), "a") if d.get("edges") else None
random.Random(seed).shuffle(cand)
from pysat.solvers import Solver

asks = [0]
t0 = time.time()


def main():
    global keep
    dropped, witnessed = [], []
    with Solver(name=d.get("solver", "cadical153"), bootstrap_with=hard) as s:
        def refuses(sel):
            asks[0] += 1
            a = [pres[x] for x in sorted(sel)]
            if budget:
                s.conf_budget(budget)
                r = s.solve_limited(assumptions=a, expect_interrupt=False)
            else:
                r = s.solve(assumptions=a)
            if r is True and corr is not None:
                harvest(s.get_model(), set(sel))
            return r

        def harvest(model, sel):
            """A colourable ask is not a dead end: its model is a proper four-colouring of the
            selection, and greedily extending it onto the DROPPED groups yields a larger colourable
            set `T`. Everything outside `T` is then a **correction set** -- every refusing selection
            must contain one of its members -- which is a rigorous constraint on the minimum and the
            only source of a LOWER bound that costs nothing. Written down, never acted on here."""
            col = {}
            for gi in sel:
                for v in members[gi]:
                    for c in range(4):
                        if model[v * 4 + c] > 0: col[v] = c; break
            for v in hardv:
                for c in range(4):
                    if model[v * 4 + c] > 0: col[v] = c; break
            left = [g for g in keep0 if g not in sel]
            moved = True
            while moved:
                moved = False
                for gi in list(left):
                    ok, tent = True, {}
                    for v in members[gi]:
                        used = {col[w] for w in nbr.get(v, ()) if w in col} | {tent[w] for w in nbr.get(v, ()) if w in tent}
                        free = [c for c in range(4) if c not in used]
                        if not free: ok = False; break
                        tent[v] = free[0]
                    if ok:
                        col.update(tent); left.remove(gi); moved = True
            if left:
                corr.write(json.dumps(sorted(left)) + "\n"); corr.flush()

        rest = list(cand)
        n_und = 0
        while rest:
            n = len(rest)
            # GALLOP first, then bisect. A plain bisection spends log2(n) asks to learn that even
            # ONE candidate will not come off, which is the common case late in a descent; galloping
            # asks about a prefix of 1 first -- the cheapest and most informative ask there is --
            # and doubles only while it keeps succeeding, so the cost is ~2*log2(best+1) rather
            # than log2(n) whatever the answer.
            best, step, fail = 0, 1, None
            while best + step <= n:
                r = refuses(keep - set(rest[:best + step]))
                if r is None: n_und += 1
                print(f"  s{seed}: gallop {best+step:4d}/{n:4d} -> {VERDICT[r]:11s} "
                      f"[ask {asks[0]}, {time.time()-t0:6.0f}s]", file=sys.stderr, flush=True)
                if r is False: best += step; step *= 2
                else: fail = best + step; break
            if fail is None and best < n:
                r = refuses(keep - set(rest[:n]))
                if r is None: n_und += 1
                if r is False: best = n
                else: fail = n
            if fail is not None:
                lo, hi = best + 1, fail - 1
                while lo <= hi:
                    mid = (lo + hi) // 2
                    r = refuses(keep - set(rest[:mid]))
                    if r is None: n_und += 1
                    print(f"  s{seed}: bisect {mid:4d}/{n:4d} -> {VERDICT[r]:11s} "
                          f"[ask {asks[0]}, {time.time()-t0:6.0f}s]", file=sys.stderr, flush=True)
                    if r is False: best = mid; lo = mid + 1
                    else: fail = mid; hi = mid - 1
            if best:
                keep -= set(rest[:best]); dropped.extend(rest[:best]); rest = rest[best:]
                print(f"  s{seed}: DROPPED {best} -> keep {len(keep)} / "
                      f"{sum(weights[g] for g in keep)} vertices [{time.time()-t0:.0f}s]",
                      file=sys.stderr, flush=True)
            # rest[0] is the candidate whose removal broke the prefix, and the search's last
            # colourable ask was at exactly best+1 -- that ask IS its criticality witness.
            if rest:
                witnessed.append(rest[0]); rest = rest[1:]
        json.dump(dict(seed=seed, dropped=sorted(dropped), witnessed=sorted(witnessed),
                       undecided_asks=n_und,
                       asks=asks[0], weight_dropped=sum(weights[g] for g in dropped),
                       keep=sorted(keep), weight_keep=sum(weights[g] for g in keep),
                       seconds=round(time.time() - t0, 1)), open(outp, "w"))
        print(json.dumps(dict(seed=seed, dropped=len(dropped), asks=asks[0],
                              weight_keep=sum(weights[g] for g in keep))))


main()
