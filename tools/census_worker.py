"""One census worker: its own incremental solver, its own slice, one JSONL line per ask.

Checkpoints per ask because the standing rule is that any phase over ~15 minutes resumes exactly,
and the audit question -- "if this process dies at any instant, what does the relaunch redo?" --
must have the answer "at most the one ask that was in flight".

The state pickle carries `keep` (the selection every ask is taken FROM) and `ask` (the groups to
delete one at a time). They are different sets on every round after the first: a criticality
witness is permanent, so a group once witnessed is never asked again.
"""
import sys, os, json, time, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

state, wid, nw, budget, outp = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
d = pickle.load(open(state, 'rb'))
hard, pres, weights = d['hard'], d['pres'], d['weights']
keep = set(d.get('keep', range(len(pres))))
ask = sorted(d.get('ask', sorted(keep)))
mine = [g for i, g in enumerate(ask) if i % nw == wid]
done = set()
if os.path.exists(outp):
    for ln in open(outp):
        try: done.add(json.loads(ln)["group"])
        except Exception: pass
todo = [g for g in mine if g not in done]
from pysat.solvers import Solver
t0 = time.time()
with Solver(name=d.get('solver', 'cadical153'), bootstrap_with=hard) as s, open(outp, 'a') as f:
    for k, g in enumerate(todo):
        a = [pres[x] for x in sorted(keep - {g})]
        w0 = time.time()
        if budget:
            s.conf_budget(budget); r = s.solve_limited(assumptions=a, expect_interrupt=False)
        else:
            r = s.solve(assumptions=a)
        v = {True: "critical", False: "droppable-alone", None: "undecided"}[r]
        f.write(json.dumps(dict(group=g, verdict=v, weight=weights[g],
                                seconds=round(time.time() - w0, 2))) + "\n"); f.flush()
        print(f"  w{wid}: {k+1}/{len(todo)} group {g} (weight {weights[g]}) -> {v} "
              f"[{time.time()-w0:.1f}s, {time.time()-t0:.0f}s total]", file=sys.stderr, flush=True)
print(json.dumps(dict(worker=wid, asked=len(todo), seconds=round(time.time() - t0, 1))))
