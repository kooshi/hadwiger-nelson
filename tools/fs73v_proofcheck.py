#!/usr/bin/env python3
"""FS-73 independent verifier: check a Glucose DRUP proof with drat-trim, as a faithful/planted PAIR.

faithful : drat-trim(F, P) must print 's VERIFIED'.
planted  : F' = F minus the unit clause pinning q to colour 1. F' is satisfiable (Theorem B's residue colouring, relabelled,
           satisfies it -- asserted here by exhibiting that colouring as a model of F'), so NO refutation of F' exists and
           drat-trim(F', P) must NOT print 's VERIFIED'. A 'VERIFIED' there is a checker defect.
"""
from __future__ import annotations

import json
import os
import resource
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs73v_lattice as L  # noqa: E402
import fs73v_sat as S  # noqa: E402

DRAT = os.path.join(S.SCR, "drat-trim/drat-trim")


def run_drat(cnf, proof, tlim):
    r0 = resource.getrusage(resource.RUSAGE_CHILDREN)
    t0 = time.time()
    pr = subprocess.run([DRAT, cnf, proof, "-t", str(tlim)], capture_output=True, text=True)
    r1 = resource.getrusage(resource.RUSAGE_CHILDREN)
    lines = (pr.stdout + pr.stderr).splitlines()
    return {"exit": pr.returncode, "s_lines": [l for l in lines if l.startswith("s ")],
            "tail": [l for l in lines if l.startswith("c ")][-4:],
            "cpu_s": round((r1.ru_utime - r0.ru_utime) + (r1.ru_stime - r0.ru_stime), 2),
            "wall_s": round(time.time() - t0, 2), "maxrss_kb_children": r1.ru_maxrss}


def main(name, brk, seed, proof, tlim):
    B = L.build(verbose=False)
    p, q, _ = S.pair_facts(B, name)
    cnf = os.path.join(S.SCR, f"cnf-{name}-{brk}-s{seed}.cnf")
    # rebuild the CNF deterministically and confirm it is the file the solver read
    tmp = cnf + ".rebuild"
    meta, perm, clauses = S.make_cnf(B, p, q, brk, seed, tmp)
    import hashlib
    h_file = hashlib.sha256(open(cnf, "rb").read()).hexdigest()
    assert h_file == meta["sha256"], "CNF on disk is not the deterministic rebuild"
    os.remove(tmp)
    n = len(B["pts"])
    qlit = 1 * n + perm[B["index"][q]] + 1
    assert [qlit] in clauses
    planted = [c for c in clauses if c != [qlit]]
    assert len(planted) == len(clauses) - 1
    # exhibit a model of F' (so F' is SAT and the planted check's failure is reachable): residue colouring, relabelled
    import itertools
    base = [L.residue_colour(tuple(int(t) for t in v), 1) for v in B["pts"]]
    found = None
    for pi in itertools.permutations(range(4)):  # some relabelling of the residue colouring satisfies F'
        col = [pi[c] for c in base]
        model = set()
        for v in range(n):
            for c in range(4):
                lit = c * n + perm[v] + 1
                model.add(lit if col[v] == c else -lit)
        if all(any(l in model for l in c) for c in planted):
            found = pi
            break
    assert found is not None, "no relabelling of the residue colouring satisfies F'"
    rec_model = {"relabelling": found}
    fprime = cnf + ".planted-no-q-pin"
    with open(fprime, "w") as f:
        f.write(f"p cnf {4 * n} {len(planted)}\n")
        for c in planted:
            f.write(" ".join(map(str, c)) + " 0\n")
    rec = {"pair": name, "brk": brk, "cnf_sha256": h_file, "proof": proof, "proof_bytes": os.path.getsize(proof),
           "proof_sha256": hashlib.sha256(open(proof, "rb").read()).hexdigest(),
           "planted_Fprime_model_exhibited": rec_model}
    rec["faithful"] = run_drat(cnf, proof, tlim)
    rec["planted"] = run_drat(fprime, proof, tlim)
    rec["faithful_ok"] = rec["faithful"]["s_lines"] == ["s VERIFIED"]
    rec["planted_refused"] = "s VERIFIED" not in rec["planted"]["s_lines"]
    os.remove(fprime)
    return rec


if __name__ == "__main__":
    name, brk, proof = sys.argv[1], sys.argv[2], sys.argv[3]
    tlim = int(sys.argv[4]) if len(sys.argv) > 4 else 20000
    rec = main(name, brk, 20260923, proof, tlim)
    print(json.dumps(rec, indent=1))
    with open(os.path.join(S.SCR, "proofchecks.jsonl"), "a") as f:
        f.write(json.dumps(rec) + "\n")
