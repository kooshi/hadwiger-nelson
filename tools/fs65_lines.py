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

RESUME.  --state DIR is the durable store: one record per case, r<r>-c<case>.json, written
atomically as each case finishes, and read back at startup so a decided case is never redone.
The unit of loss on a kill is therefore ONE case per worker, never the run.  What counts as
decided is a verdict of UNSAT or SAT; an UNKNOWN is skipped only while the seconds it ACTUALLY
SPENT reach the cap now asked for (--redo-unknown forces the retry), never the cap it was
launched with -- a case whose solver was killed lands as UNKNOWN too, and crediting it with a
nominal cap would drop it silently out of every future queue while nothing had decided it.
A timed-out case keeps no solver state, so a higher cap redoes it from zero: CHOOSE THE CAP
DELIBERATELY, that cost has been paid twice here already.  --plan prints what is left,
--status the tally.

  A PARTIAL RUN PROVES NOTHING.  alpha < k needs every one of the cases refuted; the tally
  exists to say how far that is from true, and 203 of 204 is worth exactly what 0 of 204 is.
"""
import argparse, importlib.util, json, os, subprocess, sys, time
from concurrent.futures import ProcessPoolExecutor, as_completed
from itertools import combinations
from multiprocessing import get_context
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


at_most = fs65.at_most          # the Sinz sequential counter, shared with the decision encoder


# ---------------------------------------------------------------- the durable store

def case_path(state, r, ci):
    return Path(state) / f"r{r}-c{ci}.json"


def load_case(state, r, ci):
    """the stored record for one case, or None.  Reads the same shape --out has always written."""
    p = case_path(state, r, ci)
    if not p.exists():
        return None
    try:
        d = json.loads(p.read_text())
    except (json.JSONDecodeError, OSError):
        return None
    cs = d.get("cases") or []
    return cs[0] if cs else None


def save_case(state, q, k, rec):
    """atomic: a kill during the write leaves the old record, never half of a new one."""
    p = case_path(state, rec["r"], rec["case"])
    tmp = p.with_suffix(".json.tmp")
    tmp.write_text(json.dumps({"kind": "fs65-lines", "q": q, "k": k, "cases": [rec]}, indent=1))
    os.replace(tmp, p)


def is_done(rec, timeout, redo_unknown):
    """decided, or an UNKNOWN that already SPENT at least the cap now asked for.

    The credit is the ELAPSED time, never the cap the run was launched with.  A case whose solver
    was killed -- by a batch being stopped, by an OOM, by the machine going down -- also lands here
    as UNKNOWN, and crediting it with its nominal cap would drop it silently out of every future
    queue while nothing had decided it.  Elapsed is what was actually bought, and it reads correctly
    for the legacy records too, which carry no cap at all."""
    if rec is None:
        return False
    if rec["verdict"] in ("UNSAT", "SAT"):
        return True
    if redo_unknown:
        return False
    return rec.get("seconds", 0) >= 0.98 * timeout


_CASES = {}


def all_cases(q, k):
    """every (r, case, pattern), in the order they are worked: descending r, ascending case.

    High r is where the refutations have come from (1/1 at r=9, 5/10 at r=8, 3/38 at r=7, 0/56 at
    r=6), because fixing r points also excludes their neighbours, so a fuller anchor line pins far
    more of the graph.  Descending r therefore decides the most cases per unit of solver time -- it
    is NOT hardest-first, and the bulk at r = 5, 6 is where the split stalls."""
    if (q, k) not in _CASES:
        lo = -(-k // q)
        out = []
        for r in range(q // 2, lo - 1, -1):
            for ci, P in enumerate(canon_patterns(q, r)):
                out.append((r, ci, P))
        _CASES[(q, k)] = out
    return _CASES[(q, k)]


# ---------------------------------------------------------------- one case

_PREP = {}


def prepare(q):
    if q not in _PREP:
        n, circ, adj = fs65.build(q)
        dirs, lines = unit_lines(q, circ)
        assert len(dirs) == (q + 1) // 2 and len(lines) == q * (q + 1) // 2
        _PREP[q] = (n, adj, lines)
    return _PREP[q]


def solve_case(job):
    q, k, r, ci, P, timeout, scratch, cad = job
    n, adj, lines = prepare(q)
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
    p = Path(scratch) / f"r{r}-c{ci}.cnf"; cnf.write(p)
    t0 = time.time()
    res = subprocess.run([cad, "-q", "-t", str(int(timeout)), str(p)],
                         capture_output=True, text=True)
    dt = time.time() - t0
    p.unlink(missing_ok=True)
    out = res.stdout
    v = "SAT" if "s SATISFIABLE" in out else ("UNSAT" if "s UNSATISFIABLE" in out else "UNKNOWN")
    return {"r": r, "case": ci, "pattern": list(P), "verdict": v, "seconds": round(dt, 1),
            "timeout_s": timeout, "returncode": res.returncode,   # < 0 means the solver was signalled
            "vars": cnf.n, "clauses": len(cnf.cls)}


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--q", type=int, default=19)
    ap.add_argument("--k", type=int, default=78)
    ap.add_argument("--r", type=int, help="only this maximum-occupancy class")
    ap.add_argument("--case", type=int, help="only this case index within --r")
    ap.add_argument("--timeout", type=float, default=300.0)
    ap.add_argument("--scratch", default="/tmp/fs65lines")
    ap.add_argument("--state", help="durable per-case store; skips what is already decided")
    ap.add_argument("--redo-unknown", action="store_true", help="re-run undecided cases at this cap")
    ap.add_argument("--jobs", type=int, default=1, help="cases in parallel (each writes its own record)")
    ap.add_argument("--plan", action="store_true", help="print the remaining cases, one 'r case' per line")
    ap.add_argument("--status", action="store_true", help="print the tally in --state and exit")
    ap.add_argument("--out", help="roll-up of this invocation (--status: of the whole store)")
    a = ap.parse_args()

    q, k = a.q, a.k
    lo = -(-k // q)
    assert lo <= q // 2, "pigeonhole floor exceeds the cycle's independence number"
    cases = all_cases(q, k)

    if a.r is not None:
        cases = [c for c in cases if c[0] == a.r]
    if a.case is not None:
        cases = [c for c in cases if c[1] == a.case]

    # ---- status: what the store holds, with no solving
    if a.status:
        if not a.state: ap.error("--status needs --state")
        rows, tally = [], {}
        for r, ci, P in all_cases(q, k):
            rec = load_case(a.state, r, ci)
            v = rec["verdict"] if rec else "MISSING"
            tally[(r, v)] = tally.get((r, v), 0) + 1
            if rec: rows.append(rec)
        rs = sorted({r for r, _, _ in all_cases(q, k)}, reverse=True)
        print(f"q={q} k={k}: {len(all_cases(q,k))} cases")
        for r in rs:
            tot = sum(n for (rr, _), n in tally.items() if rr == r)
            bits = " ".join(f"{v}={tally[(r,v)]}" for v in ("UNSAT", "SAT", "UNKNOWN", "MISSING")
                            if (r, v) in tally)
            print(f"  r={r}: {tot:>3} cases   {bits}")
        total = len(all_cases(q, k))
        nsat = sum(n for (_, v), n in tally.items() if v == "SAT")
        nunsat = sum(n for (_, v), n in tally.items() if v == "UNSAT")
        if nsat:
            note = f"SATISFIABLE in {nsat} case(s): an independent set of {k} EXISTS, so alpha >= {k}"
        elif nunsat == total:
            note = f"every case refuted: alpha(UD(F_{q},2)) < {k} is PROVED by this split"
        else:
            note = "a partial split proves nothing about alpha"
        print(f"\n{nunsat + nsat}/{total} decided -- " + note)
        if a.out:
            Path(a.out).write_text(json.dumps(
                {"kind": "fs65-lines-store", "q": q, "k": k,
                 "total_cases": len(all_cases(q, k)), "decided": done,
                 "cases": sorted(rows, key=lambda x: (-x["r"], x["case"]))}, indent=1))
        return 0

    # ---- what is left to do
    todo = [c for c in cases
            if not (a.state and is_done(load_case(a.state, c[0], c[1]), a.timeout, a.redo_unknown))]
    if a.plan:
        for r, ci, _ in todo:
            print(f"{r} {ci}")
        return 0
    if a.state:
        Path(a.state).mkdir(parents=True, exist_ok=True)
        print(f"{len(cases) - len(todo)} of {len(cases)} cases already done at >= {a.timeout:g}s; "
              f"{len(todo)} to run", flush=True)

    Path(a.scratch).mkdir(parents=True, exist_ok=True)
    cad = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip() + "/bin/cadical"
    prepare(q)                                   # once in the parent; fork hands it to every worker

    jobs = [(q, k, r, ci, P, a.timeout, a.scratch, cad) for r, ci, P in todo]
    results = []

    def land(rec):
        results.append(rec)
        if a.state:
            save_case(a.state, q, k, rec)        # the checkpoint: one case, atomically, as it lands
        print(f"  r={rec['r']} case {rec['case']:>3} {str(tuple(rec['pattern'])):<28} "
              f"-> {rec['verdict']:<7} {rec['seconds']:>6.1f}s", flush=True)
        if rec["verdict"] == "SAT":
            print("  *** SATISFIABLE: an independent set of this size EXISTS ***", flush=True)

    if a.jobs > 1 and len(jobs) > 1:
        # as_completed, never map: a result is checkpointed the moment it lands, so a kill cannot
        # lose a finished case behind a slow one queued ahead of it.
        with ProcessPoolExecutor(max_workers=a.jobs, mp_context=get_context("fork")) as ex:
            futs = [ex.submit(solve_case, j) for j in jobs]
            for f in as_completed(futs):
                land(f.result())
    else:
        for job in jobs:
            land(solve_case(job))

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
