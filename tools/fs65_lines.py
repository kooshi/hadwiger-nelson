#!/usr/bin/env python3
"""fs65_lines -- FS-65 D1b: alpha(UD(F_q,2)) >= k by an EXHAUSTIVE split on the fullest line.

The reduction (external review, 2026-09-18, verified here). Every direction containing a unit
vector gives q parallel lines, and each such line induces a q-cycle, so it carries at most
floor(q/2) points of an independent set.  There are (q+1)/2 directions and q(q+1)/2 lines.  A
set of size k spread over q parallel lines has a line with at least ceil(k/q) points.  At
q = 19, k = 78 that is 5 <= r <= 9.

Take a line attaining the maximum r.  A rotation carries its direction to the horizontal (the
rotations act transitively on the (q+1)/2 directions) and a translation carries it to y = 0;
the stabiliser of that line acts on it as the dihedral group, so its occupancy pattern may be
taken canonical.  Enumerating r and the canonical patterns is therefore EXHAUSTIVE: refuting
every case proves alpha < k.  At q = 19, k = 78 there are 204 cases (79+76+38+10+1).

Per case: the anchor line holds exactly the pattern, every neighbour of a chosen point is
excluded, every unit-direction line is capped at r, and at least k points are required.

SOUNDNESS NOTE.  The lex symmetry break of fs65_indep_sat.py is NOT applied here.  Anchoring
the line already spends the translations and most of the orthogonal group, and imposing the
full 40-map lex constraint on top would be unsound -- it can discard the very representative a
case was built to keep.  This file therefore trades that break for the case split, which is why
the cases are the reduction rather than an addition to it.
"""
import argparse, importlib.util, json, subprocess, sys, time
from itertools import combinations
from pathlib import Path

_s = importlib.util.spec_from_file_location("fs65", Path(__file__).with_name("fs65_indep_sat.py"))
fs65 = importlib.util.module_from_spec(_s); _s.loader.exec_module(fs65)


def unit_lines(q, circ):
    dirs = sorted({min((a, b), ((-a) % q, (-b) % q)) for (a, b) in circ})
    lines = []
    for (a, b) in dirs:
        seen = set()
        for c in range(q):
            for d in range(q):
                L = tuple(sorted(((c + t * a) % q) * q + ((d + t * b) % q) for t in range(q)))
                if L not in seen:
                    seen.add(L); lines.append(L)
    return dirs, lines


def canon_patterns(q, r):
    out = set()
    for P in combinations(range(q), r):
        if any((P[i + 1] - P[i]) % q == 1 for i in range(len(P) - 1)) or (P[0] - P[-1]) % q == 1:
            continue
        best = None
        for s in range(q):
            for rev in (0, 1):
                img = tuple(sorted((p * (-1 if rev else 1) + s) % q for p in P))
                if best is None or img < best: best = img
        out.add(best)
    return sorted(out)


def at_most(cnf, lits, r):
    """Sinz sequential counter: at most r of lits are true."""
    n = len(lits)
    if r >= n: return
    R = [[cnf.new() for _ in range(r)] for _ in range(n)]
    cnf.add(-lits[0], R[0][0])
    for j in range(1, r): cnf.add(-R[0][j])
    for i in range(1, n):
        cnf.add(-lits[i], R[i][0])
        cnf.add(-R[i - 1][0], R[i][0])
        for j in range(1, r):
            cnf.add(-lits[i], -R[i - 1][j - 1], R[i][j])
            cnf.add(-R[i - 1][j], R[i][j])
        cnf.add(-lits[i], -R[i - 1][r - 1])


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--q", type=int, default=19)
    ap.add_argument("--k", type=int, default=78)
    ap.add_argument("--r", type=int, help="only this maximum-occupancy class")
    ap.add_argument("--case", type=int, help="only this case index within --r")
    ap.add_argument("--timeout", type=float, default=300.0)
    ap.add_argument("--scratch", default="/tmp/fs65lines")
    ap.add_argument("--out")
    a = ap.parse_args()

    q, k = a.q, a.k
    n, circ, adj = fs65.build(q)
    dirs, lines = unit_lines(q, circ)
    assert len(dirs) == (q + 1) // 2 and len(lines) == q * (q + 1) // 2
    lo = -(-k // q)
    assert lo <= q // 2, "pigeonhole floor exceeds the cycle's independence number"
    Path(a.scratch).mkdir(parents=True, exist_ok=True)
    cad = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip() + "/bin/cadical"

    rs = [a.r] if a.r else list(range(lo, q // 2 + 1))
    results = []
    for r in rs:
        pats = canon_patterns(q, r)
        idxs = [a.case] if a.case is not None else range(len(pats))
        for ci in idxs:
            P = pats[ci]
            cnf = fs65.CNF(n); X = [i + 1 for i in range(n)]
            for v in range(n):
                for w in adj[v]:
                    if v < w: cnf.add(-X[v], -X[w])
            anchor = [x * q + 0 for x in range(q)]
            for x in range(q):
                cnf.add(X[anchor[x]] if x in P else -X[anchor[x]])
            for x in P:
                for w in adj[anchor[x]]: cnf.add(-X[w])
            for L in lines:
                at_most(cnf, [X[v] for v in L], r)
            fs65.at_least_k(cnf, X, k)
            p = Path(a.scratch) / f"r{r}-c{ci}.cnf"; cnf.write(p)
            t0 = time.time()
            out = subprocess.run([cad, "-q", "-t", str(int(a.timeout)), str(p)],
                                 capture_output=True, text=True).stdout
            dt = time.time() - t0
            v = "SAT" if "s SATISFIABLE" in out else ("UNSAT" if "s UNSATISFIABLE" in out else "UNKNOWN")
            results.append({"r": r, "case": ci, "pattern": list(P), "verdict": v,
                            "seconds": round(dt, 1), "vars": cnf.n, "clauses": len(cnf.cls)})
            print(f"  r={r} case {ci:>3} {str(P):<28} -> {v:<7} {dt:>6.1f}s", flush=True)
            p.unlink(missing_ok=True)
            if v == "SAT":
                print("  *** SATISFIABLE: an independent set of this size EXISTS ***", flush=True)
    if a.out:
        Path(a.out).write_text(json.dumps({"kind": "fs65-lines", "q": q, "k": k,
                                           "cases": results}, indent=1))
    ns = sum(1 for x in results if x["verdict"] == "UNSAT")
    print(f"\n{ns}/{len(results)} refuted, "
          f"{sum(1 for x in results if x['verdict']=='SAT')} sat, "
          f"{sum(1 for x in results if x['verdict']=='UNKNOWN')} undecided")
    return 0


if __name__ == "__main__":
    sys.exit(main())
