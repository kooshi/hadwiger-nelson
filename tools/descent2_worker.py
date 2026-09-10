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
                return s.solve_limited(assumptions=a, expect_interrupt=False)
            return s.solve(assumptions=a)

        rest = list(cand)
        n_und = 0
        while rest:
            lo, hi, best = 1, len(rest), 0
            while lo <= hi:
                mid = (lo + hi) // 2
                w0 = time.time()
                r = refuses(keep - set(rest[:mid]))
                if r is None: n_und += 1
                print(f"  s{seed}: prefix {mid:4d}/{len(rest):4d} -> {VERDICT[r]:11s} "
                      f"[{time.time()-w0:6.1f}s, ask {asks[0]}, {time.time()-t0:6.0f}s]",
                      file=sys.stderr, flush=True)
                if r is False: best = mid; lo = mid + 1
                else: hi = mid - 1          # `undecided` counts as NOT droppable: the safe side
            if best:
                keep -= set(rest[:best]); dropped.extend(rest[:best]); rest = rest[best:]
                print(f"  s{seed}: DROPPED {best} -> keep {len(keep)} / "
                      f"{sum(weights[g] for g in keep)} vertices [{time.time()-t0:.0f}s]",
                      file=sys.stderr, flush=True)
            # rest[0] is now the candidate whose removal broke the prefix -- the binary search's
            # last colourable ask was at exactly best+1, so that ask IS its criticality witness.
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
