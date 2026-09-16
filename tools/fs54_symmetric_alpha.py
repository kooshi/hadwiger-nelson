#!/usr/bin/env python3
"""FS-54 §M — the largest H-invariant independent set of UD(F_27,2), for each conjugacy class of subgroups H of PRIME
order (data/fs54/symmetric/prime-order-classes.json, from GAP via tools/fs54_aut_gap.py).

An H-invariant independent set is a union of H-orbits: an orbit containing an edge can never be used, two usable
orbits joined by an edge exclude each other, and an orbit counts with its size.  So the question is a weighted maximum
independent set on the orbit graph, solved here by OR-Tools CP-SAT (maximise, with a wall-clock limit per class).
Every returned set is re-checked against the edge set rebuilt by tools/fs54_structure.py before it is written.

Verdict words, per class: OPTIMAL (CP-SAT proved no larger H-invariant set exists — a solver's word, [solver]);
FEASIBLE (the best found and the solver's upper bound, both reported; nothing refuted between them).
Checkpoint: one JSON line per finished class in --out; a rerun skips classes already there.
Run: .venv/bin/python tools/fs54_symmetric_alpha.py --seconds 180 --workers 24"""
import argparse, contextlib, io, json, os, sys, time
sys.path.insert(0, os.path.dirname(__file__))
with contextlib.redirect_stdout(io.StringIO()):
    import fs54_structure as S
from ortools.sat.python import cp_model

EDGES = S.edges
ADJ = [set() for _ in range(729)]
for i, j in EDGES:
    ADJ[i].add(j); ADJ[j].add(i)


def solve(orbits, seconds, workers, seed):
    where = {}
    for k, o in enumerate(orbits):
        for v in o:
            where[v] = k
    usable = [k for k, o in enumerate(orbits) if not any(w in ADJ[v] for v in o for w in o)]
    uset = set(usable)
    oedges = set()
    for k in usable:
        for v in orbits[k]:
            for w in ADJ[v]:
                m = where[w]
                if m in uset and m != k:
                    oedges.add((min(k, m), max(k, m)))
    model = cp_model.CpModel()
    x = {k: model.NewBoolVar(f"o{k}") for k in usable}
    for a, b in oedges:
        model.AddBoolOr([x[a].Not(), x[b].Not()])
    model.Maximize(sum(len(orbits[k]) * x[k] for k in usable))
    solver = cp_model.CpSolver()
    solver.parameters.max_time_in_seconds = seconds
    solver.parameters.num_workers = workers
    solver.parameters.random_seed = seed
    st = solver.Solve(model)
    chosen = sorted(v for k in usable if solver.Value(x[k]) for v in orbits[k]) if st in (cp_model.OPTIMAL, cp_model.FEASIBLE) else []
    assert all(w not in set(chosen) for v in chosen for w in ADJ[v]), "returned set is not independent"
    return {"usable_orbits": len(usable), "orbit_graph_edges": len(oedges), "status": solver.StatusName(st),
            "best": len(chosen), "bound": int(round(solver.BestObjectiveBound())), "wall_seconds": round(solver.WallTime(), 1),
            "set": chosen}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--classes", default="data/fs54/symmetric/prime-order-classes.json")
    ap.add_argument("--out", default="data/fs54/symmetric/prime-order-alpha.jsonl")
    ap.add_argument("--seconds", type=float, default=180)
    ap.add_argument("--workers", type=int, default=24)
    ap.add_argument("--seed", type=int, default=1)
    args = ap.parse_args()
    classes = json.load(open(args.classes))
    done = set()
    if os.path.exists(args.out):
        done = {json.loads(l)["class_index"] for l in open(args.out) if l.strip()}
    for ci, c in enumerate(classes):
        if ci in done:
            continue
        r = solve(c["orbits"], args.seconds, args.workers, args.seed)
        row = {"class_index": ci, "order": c["order"], "fixed_points": c["fixed_points"], "orbits": len(c["orbits"]),
               "class_size_elements": c["class_size_elements"], "seconds_limit": args.seconds, "workers": args.workers,
               "seed": args.seed, **r,
               "claim_scope": "the largest independent set invariant under this subgroup: OPTIMAL = CP-SAT proved it "
                              "([solver], untrusted); FEASIBLE = best found and solver bound, nothing refuted between"}
        with open(args.out, "a") as fh:
            fh.write(json.dumps(row) + "\n")
        print(f"class {ci:2d} order {c['order']} fixed {c['fixed_points']:2d} orbits {len(c['orbits'])}: usable "
              f"{r['usable_orbits']}, best {r['best']}, bound {r['bound']}, {r['status']} in {r['wall_seconds']}s", flush=True)


if __name__ == "__main__":
    main()
