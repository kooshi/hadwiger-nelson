"""The negative control for the census's load-bearing claim, run before any census is believed.

The claim: *a criticality witness is permanent* -- if `keep` minus `g` is four-colourable then so is
`S` minus `g` for every `S` inside `keep`. It is a theorem (colourability is downward closed), which
is exactly why it needs a control: a theorem-shaped belief is the kind this project has been wrong
about, and the cost of being wrong here is a descent that silently keeps vertices it could drop --
or worse, an encoding bug that makes the two asks incomparable.

So: witness a vertex critical at the full selection, delete a large random slice of OTHER vertices,
and re-ask. Every re-ask must still be colourable. The RED half is the other direction -- a vertex
witnessed *droppable* at the full selection must be allowed to become critical lower down, and if
the run never sees that happen the control is not discriminating and says so.
"""
import sys, os, json, time, pickle, random, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
ap = argparse.ArgumentParser()
ap.add_argument("--state", required=True)
ap.add_argument("--trials", type=int, default=12)
ap.add_argument("--slice", type=float, default=0.25, help="fraction of OTHER groups to remove")
a = ap.parse_args()
d = pickle.load(open(a.state, "rb")); hard, pres, weights = d["hard"], d["pres"], d["weights"]
m = len(pres); rng = random.Random(7)
from pysat.solvers import Solver
t0 = time.time()
crit, drop = [], []
with Solver(name="cadical153", bootstrap_with=hard) as s:
    allg = list(range(m))
    for g in rng.sample(allg, min(40, m)):
        r = s.solve(assumptions=[pres[x] for x in allg if x != g])
        (crit if r else drop).append(g)
        if len(crit) >= a.trials and len(drop) >= a.trials: break
    print(f"probe: {len(crit)} critical, {len(drop)} droppable-alone at the full selection "
          f"[{time.time()-t0:.0f}s]", flush=True)
    ok = bad = 0
    for g in crit[:a.trials]:
        others = [x for x in allg if x != g]
        gone = set(rng.sample(others, int(len(others) * a.slice)))
        r = s.solve(assumptions=[pres[x] for x in others if x not in gone])
        if r: ok += 1
        else:
            bad += 1
            print(f"  CONTROL FAILED: group {g} was witnessed critical at the full selection and "
                  f"is NOT critical after removing {len(gone)} others -- the permanence claim, the "
                  f"encoding, or the bookkeeping is wrong", flush=True)
    print(f"permanence: {ok}/{ok+bad} still critical after removing "
          f"{int(a.slice*100)}% of the others", flush=True)
    flips = 0
    for g in drop[:a.trials]:
        others = [x for x in allg if x != g]
        gone = set(rng.sample(others, int(len(others) * a.slice)))
        r = s.solve(assumptions=[pres[x] for x in others if x not in gone])
        if r: flips += 1
    print(f"discrimination: {flips}/{min(a.trials,len(drop))} droppable-alone groups BECAME "
          f"critical lower down"
          + ("" if flips else "  -- ZERO, so this control did not discriminate and its green half "
                              "is weak evidence"), flush=True)
print(f"[{time.time()-t0:.0f}s] done")
