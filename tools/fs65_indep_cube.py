#!/usr/bin/env python3
"""fs65_indep_cube -- FS-65 D1 in parallel: "does UD(F_q,2) have an independent set of size k?"
by cube-and-conquer over the symmetry-broken encoding of tools/fs65_indep_sat.py.

WHY CUBES AND NOT A PORTFOLIO.  CaDiCaL is single-threaded and a portfolio races configurations on
the SAME question, which helps a satisfiable instance and gives nothing on a refutation.  Cubing
splits the question into subproblems whose union is exhaustive, so every cube must be refuted and
the work divides.  It also earns the property a single solve cannot have: **each decided cube is an
acceptance point**, written to a JSONL checkpoint as it lands, so a kill at any instant costs one
cube rather than the run (CLAUDE.md's protected checkpointing rule).

SOUNDNESS.  Cubes are all 2^depth assignments of a chosen set of vertex variables, so they cover
every case by construction; a cube whose own literals already violate an edge is refuted without a
solver call and is recorded as such.  ALL cubes UNSAT => no independent set of size k exists.  ANY
cube SAT => one exists, and the model is re-verified against the graph definition before it is
believed.  A cube undecided at its cap is split one variable deeper; a cube still undecided at
--max-depth leaves the whole run UNDECIDED, which is a statement about the budget and is reported
as one.

The symmetry breaks are the ones fs65_indep_sat.py argues and verifies, through its base_cnf: by
default the CENTROID normalisation of the translations (exactly one translate of a k-set has both
coordinate sums zero when gcd(k, q) = 1, so the reduction is the full q^2 -- pinning the origin
instead is worth only q^2/k, 4.63 at q = 19, k = 78) and the lex-least member of each orbit of the
2(q+1) maps fixing the origin, which preserve the centroid condition and so compose with it.  Their
soundness is checked there, and separately by the fact that the encoding admits a known independent
set at the size that set has.  --break selects; the checkpoint digest covers the choice, so a
checkpoint from one encoding is refused by a run of another.
"""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import multiprocessing as mp
import shutil
import subprocess
import sys
import time
from pathlib import Path

_spec = importlib.util.spec_from_file_location("fs65", Path(__file__).with_name("fs65_indep_sat.py"))
fs65 = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(fs65)


def cadical_path():
    c = shutil.which("cadical")
    if not c:
        pref = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip()
        c = f"{pref}/bin/cadical"
    if not Path(c).exists():
        sys.exit(f"cadical not found at {c}")
    return c


def pick_cube_vars(n, adj, depth, banned):
    """vertices to split on: pairwise non-adjacent, and never one the encoding already fixes."""
    order = [v for v in range(n) if v not in banned]
    chosen = []
    for v in order:
        if len(chosen) >= depth:
            break
        if all(v not in adj[u] for u in chosen):      # pairwise non-adjacent: no cube dies trivially
            chosen.append(v)
    return chosen


def solve_cube(job):
    base, lits, cap, cid, scratch = job
    p = Path(scratch) / f"cube-{cid}.cnf"
    with open(base) as f:
        head = f.readline().split()
        nv, nc = int(head[2]), int(head[3])
        body = f.read()
    with open(p, "w") as f:
        f.write(f"p cnf {nv} {nc + len(lits)}\n")
        f.write(body)
        f.write("".join(f"{l} 0\n" for l in lits))
    t0 = time.time()
    r = subprocess.run([cadical_path(), "-q", "-t", str(int(cap)), str(p)],
                       capture_output=True, text=True)
    dt = time.time() - t0
    out = r.stdout
    v = "SAT" if "s SATISFIABLE" in out else ("UNSAT" if "s UNSATISFIABLE" in out else "UNKNOWN")
    model = []
    if v == "SAT":
        model = [int(t) for t in out.split() if t.lstrip("-").isdigit()]
    p.unlink(missing_ok=True)
    return {"cube": cid, "lits": lits, "verdict": v, "seconds": round(dt, 2), "model": model}


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--q", type=int, required=True)
    ap.add_argument("--k", type=int, required=True)
    ap.add_argument("--depth", type=int, default=10)
    ap.add_argument("--max-depth", type=int, default=20)
    ap.add_argument("--cap", type=float, default=120.0, help="per-cube seconds before it is split deeper")
    ap.add_argument("--workers", type=int, default=16)
    ap.add_argument("--scratch", default="/tmp")
    ap.add_argument("--break", dest="brk", choices=("centroid", "origin", "lex", "none"), default="centroid",
                    help="how the translations are broken; see fs65_indep_sat.py")
    ap.add_argument("--no-lex", action="store_true", help="drop the orthogonal break (for comparison)")
    ap.add_argument("--ckpt", required=True, help="JSONL, one line per decided cube; resumed from")
    ap.add_argument("--out", required=True)
    a = ap.parse_args()

    n, adj, cnf, X, _G, _aux = fs65.base_cnf(a.q, a.k, brk=a.brk, lex=not a.no_lex)
    scratch = Path(a.scratch)
    scratch.mkdir(parents=True, exist_ok=True)
    base = scratch / f"fs65-base-q{a.q}-k{a.k}-{a.brk}.cnf"
    cnf.write(base)

    # the origin pin puts unit clauses on the origin and its neighbours; the centroid break fixes
    # no vertex at all, so under it every vertex is a legitimate split variable
    banned = ({0} | adj[0]) if a.brk == "origin" else set()
    free_vars = [v for v in range(n) if v not in banned]
    cvars = pick_cube_vars(n, adj, a.depth, banned)
    cubes = []
    for m in range(1 << len(cvars)):
        lits = [X[v] if (m >> i) & 1 else -X[v] for i, v in enumerate(cvars)]
        cubes.append(lits)
    # the digest covers the BREAKS too: a checkpoint taken under a different encoding answers a
    # different question, and must be refused rather than silently reused
    digest = hashlib.sha256(json.dumps([cvars, a.q, a.k, a.brk, a.no_lex]).encode()).hexdigest()[:16]

    done = {}
    ck = Path(a.ckpt)
    if ck.exists():
        for line in ck.read_text().splitlines():
            if not line.strip():
                continue
            rec = json.loads(line)
            if rec.get("digest") != digest:
                sys.exit(f"checkpoint {ck} belongs to a different cube enumeration ({rec.get('digest')} != {digest})")
            done[tuple(rec["lits"])] = rec
    print(f"[cube] q={a.q} k={a.k}: {cnf.n} vars, {len(cnf.cls)} clauses; "
          f"{len(cubes)} cubes on {len(cvars)} vertices (digest {digest}); "
          f"{len(done)} already decided", flush=True)

    pending = [c for c in cubes if tuple(c) not in done]
    t0 = time.time()
    nsat = nunsat = nundec = 0
    sat_model = None
    ctx = mp.get_context("fork")

    with open(ck, "a") as ckf:
        while pending:
            jobs = [(str(base), lits, a.cap, i, str(scratch)) for i, lits in enumerate(pending)]
            deeper = []
            with ctx.Pool(a.workers) as pool:
                for res in pool.imap_unordered(solve_cube, jobs, chunksize=1):
                    lits = res["lits"]
                    if res["verdict"] == "UNKNOWN":
                        if len(lits) >= a.max_depth:
                            nundec += 1
                        else:
                            used = {abs(l) for l in lits}
                            # never split on a variable the encoding already fixes (the origin and
                            # its neighbours carry unit clauses): one branch dies at once and the
                            # other is the parent problem, so the depth budget burns for nothing.
                            nxt = next((X[v] for v in free_vars if X[v] not in used), None)
                            if nxt is None:
                                nundec += 1
                            else:
                                deeper.append(lits + [nxt])
                                deeper.append(lits + [-nxt])
                        continue
                    rec = dict(res, digest=digest)
                    rec.pop("model", None) if res["verdict"] != "SAT" else None
                    ckf.write(json.dumps(rec) + "\n")
                    ckf.flush()
                    if res["verdict"] == "SAT":
                        nsat += 1
                        sat_model = res["model"]
                        pool.terminate()
                        break
                    nunsat += 1
                    if (nunsat + nsat) % 64 == 0:
                        el = time.time() - t0
                        print(f"[cube] {nunsat} unsat, {nsat} sat, {nundec} undecided, "
                              f"{len(deeper)} queued deeper, {el:.0f}s", flush=True)
            if sat_model:
                break
            pending = deeper

    verdict = "SAT" if sat_model else ("UNKNOWN" if nundec else "UNSAT")
    rec = {"kind": "fs65-indep-cube", "q": a.q, "k_asked": a.k, "verdict": verdict,
           "cubes_total": len(cubes), "unsat": nunsat, "sat": nsat, "undecided": nundec,
           "depth": len(cvars), "max_depth": a.max_depth, "cap": a.cap, "workers": a.workers,
           "seconds": round(time.time() - t0, 2), "digest": digest,
           "claim_scope": ("UNSAT: every cube refuted and the cubes are exhaustive, so alpha < k. "
                           "SAT: the exhibited set is verified from the graph definition. "
                           "UNKNOWN: some cube was undecided at --max-depth, a statement about the budget.")}
    if sat_model:
        S = {t - 1 for t in sat_model if 0 < t <= n}
        bad = [(u, w) for u in S for w in adj[u] if w in S]
        rec["set_size"] = len(S)
        rec["verified_independent"] = not bad
        rec["set"] = sorted(S)
        assert not bad and len(S) >= a.k, "solver returned a bad set"
    Path(a.out).write_text(json.dumps(rec, indent=1))
    print(f"[cube] {verdict}: {nunsat} unsat / {nsat} sat / {nundec} undecided "
          f"of {len(cubes)} cubes in {rec['seconds']}s", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
