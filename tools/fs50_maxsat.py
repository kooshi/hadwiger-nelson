#!/usr/bin/env python3
"""fs50_maxsat — α(UD(F_p, 2)) as a MaxSAT problem (FS-50 stub D3, the pseudo-Boolean/core-guided alternative to a
cardinality circuit): hard clauses = the edges (and the origin pinned), one soft unit clause per vertex. RC2 (core-guided,
pysat) lowers an UPPER bound on α as it extracts cores and raises a lower bound as it finds models; the optimum is α on
the solver's word (no checkable proof). A wall via SIGTERM writes the record with the bounds reached so far."""
import argparse, json, signal, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane
from pysat.formula import WCNF
from pysat.examples.rc2 import RC2

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True); ap.add_argument("--out", required=True)
    ap.add_argument("--adapt", action="store_true"); ap.add_argument("--exhaust", action="store_true"); ap.add_argument("--minz", action="store_true")
    a = ap.parse_args()
    p, n = a.p, a.p * a.p
    E, deg = fplane.ud_edges(p)
    w = WCNF()
    for u, v in E:
        w.append([-(u + 1), -(v + 1)])
    w.append([1])
    for v in range(n):
        w.append([v + 1], weight=1)
    t0 = time.time(); rec = dict(kind="fs50-maxsat", p=p, n=n, solver="RC2 (pysat), cadical195 backend", adapt=a.adapt, exhaust=a.exhaust, minz=a.minz)
    rc2 = RC2(w, solver="cd19", adapt=a.adapt, exhaust=a.exhaust, minz=a.minz, verbose=0)
    state = dict(cores=0, cost=0)
    def flush(verdict):
        rec.update(verdict=verdict, seconds=time.time() - t0, cost_lower_bound=rc2.cost, alpha_upper_bound=n - rc2.cost, cores_extracted=len(getattr(rc2, "cores", []) or []))
        Path(a.out).write_text(json.dumps(rec, indent=1))
    def on_term(sig, frame):
        flush("interrupted"); print(json.dumps({k: rec[k] for k in ("p", "verdict", "seconds", "alpha_upper_bound")})); sys.exit(0)
    signal.signal(signal.SIGTERM, on_term); signal.signal(signal.SIGINT, on_term)
    model = rc2.compute()
    S = [v for v in range(n) if model[v] > 0]
    Es = set(E); assert all((min(u, v), max(u, v)) not in Es for u in S for v in S if u != v), "not independent"
    assert len(S) == n - rc2.cost
    flush("optimum"); rec.update(alpha=len(S), independent_set=S); Path(a.out).write_text(json.dumps(rec, indent=1))
    print(json.dumps({k: rec[k] for k in ("p", "verdict", "seconds", "alpha")}))

if __name__ == "__main__":
    main()
