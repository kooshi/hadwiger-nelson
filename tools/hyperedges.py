"""Degree-2 hyperedges of the reduction hypergraph -- the thing `[Parts2020a]` §5.5 builds and we
never did.

**What his reduction actually is, read from §5.5 and §5.7 rather than inferred.** A *hyperedge* of
degree `n` is a set of `n` vertices whose SIMULTANEOUS deletion loses the key property, no proper
subset of which does. Hyperedges are found stepwise in increasing degree. The reduction then
enumerates the deletion sets that contain no hyperedge entirely, **ordered by decreasing size**, and
checks them largest first -- so it converges on the MINIMUM graph, not on a 1-minimal one.

Our census is exactly his degree-1 search and we have never gone past it. That is the gap, stated
as a number: nine greedy 1-minimal descents delete 147-174 vertices of 756, where the deletion set a
510-vertex answer needs is 247 -- and a greedy descent is one randomly-chosen maximal hyperedge-free
set, sampled one at a time, where he enumerates them in order of size.

**The symmetry collapse carries over to degree 2 unchanged.** The base's order-24 group acts by
automorphisms fixing the pinned centre, so the pair `(u, v)` and the pair `(g(u), g(v))` give
isomorphic instances and one ask decides the whole pair-orbit. That turns ~187,000 pair asks into
about 8,000.

**Verdict vocabulary.** `hyperedge` = deleting both was WITNESSED to lose refusal (a four-colouring
was exhibited). `free-pair` = the refutation survived both deletions, which is a statement about
this pair only and NOT about any larger set. `undecided` = the budget ran out, folded into neither.
"""
from __future__ import annotations
import sys, os, json, time, pickle, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

state, wid, nw, budget, outp = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
d = pickle.load(open(state, "rb"))
hard, pres, weights = d["hard"], d["pres"], d["weights"]
keep = set(d["keep"]); pairs = d["pairs"]
mine = [p for i, p in enumerate(pairs) if i % nw == wid]
done = set()
if os.path.exists(outp):
    for ln in open(outp):
        try: done.add(tuple(json.loads(ln)["pair"]))
        except Exception: pass
todo = [p for p in mine if tuple(p) not in done]
from pysat.solvers import Solver
t0 = time.time()
with Solver(name=d.get("solver", "cadical153"), bootstrap_with=hard) as s, open(outp, "a") as f:
    for k, (u, v) in enumerate(todo):
        a = [pres[x] for x in sorted(keep - {u, v})]
        w0 = time.time()
        if budget:
            s.conf_budget(budget); r = s.solve_limited(assumptions=a, expect_interrupt=False)
        else:
            r = s.solve(assumptions=a)
        verdict = {True: "hyperedge", False: "free-pair", None: "undecided"}[r]
        f.write(json.dumps(dict(pair=[u, v], verdict=verdict,
                                seconds=round(time.time() - w0, 2))) + "\n"); f.flush()
        if k % 50 == 0:
            print(f"  w{wid}: {k+1}/{len(todo)} [{time.time()-t0:.0f}s]", file=sys.stderr, flush=True)
print(json.dumps(dict(worker=wid, asked=len(todo), seconds=round(time.time() - t0, 1))))
