"""A rigorous LOWER bound on the minimum refusing selection, from correction sets that cost nothing.

**Where the constraints come from.** Every ask that comes back *colourable* carries a model, and
that model is a proper four-colouring of the asked selection. Extend it greedily onto the groups
that were dropped and you get a larger colourable set `T`; the groups outside `T` form a
**correction set** `C`, and the argument is one line: colourability is downward closed, so any
selection inside `keep \\ C` is colourable and therefore does not refuse -- hence **every refusing
selection contains a member of `C`.** The census's `critical` verdicts are the singleton case.

So the minimum refusing selection is at least the minimum-weight hitting set of the collected
correction sets, which is a weighted MaxSAT this size solves exactly in seconds. Every descent
already makes the asks; the only thing that was missing was writing the models down.

**The termination condition, if it ever fires.** If a minimum hitting set itself REFUSES, it is
optimal -- lower bound meets upper bound and the search is over. That is the implicit-hitting-set
algorithm, and this file reports the coincidence when it happens rather than assuming it.

**What this is NOT.** A bound computed from correction sets gathered so far is a bound, full stop --
it never rises above the truth, and gathering more can only raise it. An `unknown` ask contributes
NOTHING here (no model, no set), which is why a budgeted run's bound stays honest.
"""
from __future__ import annotations
import sys, os, json, glob, pickle, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def collect(paths):
    out, seen = [], set()
    for p in paths:
        if not os.path.exists(p): continue
        for ln in open(p):
            try: c = tuple(sorted(json.loads(ln)))
            except Exception: continue
            if c and c not in seen: seen.add(c); out.append(list(c))
    # a correction set containing another is redundant: hitting the smaller hits the larger
    out.sort(key=len)
    kept, sets = [], []
    for c in out:
        s = set(c)
        if not any(k <= s for k in sets): kept.append(c); sets.append(s)
    return kept


def bound(corr, weights, verbose=False):
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    w = WCNF()
    for c in corr: w.append([g + 1 for g in c])
    for g, wt in enumerate(weights): w.append([-(g + 1)], weight=wt)
    with RC2(w) as rc:
        m = rc.compute()
        if m is None: return None, None
        keep = sorted(g for g in range(len(weights)) if m[g] > 0)
        return sum(weights[g] for g in keep), keep


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--state", required=True)
    ap.add_argument("--corr", nargs="+", required=True, help="glob(s) of *.corr.jsonl")
    ap.add_argument("--census", default="", help="a census.json whose `critical` groups are singletons")
    ap.add_argument("--verify", action="store_true", help="ask whether the hitting set itself refuses")
    a = ap.parse_args()
    d = pickle.load(open(a.state, "rb")); weights = d["weights"]
    paths = [p for g in a.corr for p in glob.glob(g)]
    corr = collect(paths)
    if a.census and os.path.exists(a.census):
        s = json.load(open(a.census))
        for g in s.get("critical_groups", []): corr.append([g])
        corr = collect([]) or corr
    lb, keep = bound(corr, weights)
    print(json.dumps(dict(kind="hitting-set-lower-bound", files=len(paths),
                          correction_sets=len(corr),
                          smallest=min((len(c) for c in corr), default=None),
                          lower_bound_weight=lb, hitting_set_groups=len(keep or []),
                          scope="a bound from the correction sets gathered SO FAR; gathering more "
                                "can only raise it, and it never exceeds the truth"), indent=1))
    if a.verify and keep:
        from pysat.solvers import Solver
        with Solver(name="cadical153", bootstrap_with=d["hard"]) as s:
            r = s.solve(assumptions=[d["pres"][g] for g in keep])
        print(f"the minimum hitting set itself: "
              f"{'REFUSES -- lower bound meets upper bound, this is the OPTIMUM' if r is False else 'is four-colourable, so the bound is not yet tight'}")
