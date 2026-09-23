#!/usr/bin/env python3
"""FS-73 independent verifier: the forcing asks, with this file's own CNF encoding.

Written without reading tools/fs73_screen.py or any CNF of the census.

The ask for a pair (p, q) of ball points: is there a proper 4-colouring c of the ball graph with c(p) != c(q)?
UNSAT means every proper 4-colouring of the ball identifies p and q, hence (the ball being a subgraph of Cay(Lambda, U))
every proper 4-colouring of Cay(Lambda, U) has c(x) = c(x + q - p) for all x.

Encoding (this file's own):
  * vertex order: a seeded random permutation of the ball (seed recorded);
  * variables colour-major: x(v, c) = c * n + pos(v) + 1;
  * exactly-one colour per vertex (at-least-one clause + all six pairwise at-most-one clauses);
  * per edge and colour: (-x(u,c) | -x(w,c));
  * pins x(p,0), x(q,1)  -- sound: any colouring with c(p) != c(q) can be relabelled to c(p)=0, c(q)=1;
  * ONE optional break of the remaining 2<->3 symmetry (never two):
      'cn'   : a common neighbour w of p and q is pinned x(w,2).  Sound: c(w) not in {c(p), c(q)} = {0,1}, so
               c(w) in {2,3}; if c(w)=3 apply the transposition (2 3) to the whole colouring, which keeps it proper
               and keeps the pins.
      'nb'   : a neighbour w of p (w != q) gets the unit clause -x(w,3).  Sound: if c(w)=3 apply (2 3); the pins stay.
      'none' : no break (a residual symmetry of order 2).
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import random
import resource
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs73v_lattice as L  # noqa: E402

SCR = "/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-verifier"

# the pairs, as exact field elements z = a + b sqrt-3 + c sqrt-11 + d sqrt33 (a, b, c, d rational)
PAIRS = {
    # name: (p, q)
    "eight_ninths": ((Fr(-4, 9), 0, 0, 0), (Fr(4, 9), 0, 0, 0)),               # delta = 8/9
    "v": ((Fr(2, 9), 0, Fr(2, 9), 0), (Fr(-2, 9), 0, Fr(-2, 9), 0)),         # delta = -(4/9)(1 + sqrt-11)
    "harder_eight_thirds": ((Fr(-4, 3), 0, 0, 0), (Fr(4, 3), 0, 0, 0)),      # delta = 8/3 (positive control)
    "two": ((Fr(-1), 0, 0, 0), (Fr(1), 0, 0, 0)),                              # delta = 2 (negative control)
    "four_ninths": ((Fr(-2, 9), 0, 0, 0), (Fr(2, 9), 0, 0, 0)),               # delta = 4/9 (negative control)
    "sixteen_ninths_half": ((Fr(-8, 9), 0, 0, 0), (Fr(0), 0, 0, 0)),          # delta = 8/9 off-centre (not a control)
}


def ipt(z):
    return L.to_int(tuple(Fr(t) for t in z))


def pair_facts(B, name):
    p, q = (ipt(z) for z in PAIRS[name])
    idx = B["index"]
    H = B["H"]
    delta = tuple(b - a for a, b in zip(p, q))
    facts = {
        "p_int36": p, "q_int36": q, "delta_int36": delta,
        "p_in_Lambda": L.member(H, p) is not None, "q_in_Lambda": L.member(H, q) is not None,
        "p_in_ball": p in idx, "q_in_ball": q in idx,
        "delta_is_unit": delta in set(B["U"]),
    }
    Np = L.neighbours_of(B, p)
    Nq = L.neighbours_of(B, q)
    facts["deg_p"] = len(Np)
    facts["deg_q"] = len(Nq)
    facts["common_neighbours"] = sorted(Np & Nq)
    return p, q, facts


def make_cnf(B, p, q, brk, seed, path):
    pts = B["pts"]
    n = len(pts)
    idx = B["index"]
    rng = random.Random(seed)
    perm = list(range(n))
    rng.shuffle(perm)  # pos(v) = perm[v]

    def x(v, c):
        return c * n + perm[v] + 1

    clauses = []
    for v in range(n):
        clauses.append([x(v, 0), x(v, 1), x(v, 2), x(v, 3)])
        for c1 in range(4):
            for c2 in range(c1 + 1, 4):
                clauses.append([-x(v, c1), -x(v, c2)])
    for (u, w) in B["edges"]:
        for c in range(4):
            clauses.append([-x(u, c), -x(w, c)])
    ip, iq = idx[p], idx[q]
    clauses.append([x(ip, 0)])
    clauses.append([x(iq, 1)])
    brk_info = {"mode": brk}
    if brk == "cn":
        cn = sorted(L.neighbours_of(B, p) & L.neighbours_of(B, q))
        assert cn, "no common neighbour"
        w = cn[0]
        clauses.append([x(idx[w], 2)])
        brk_info["w"] = w
    elif brk == "nb":
        nb = sorted(L.neighbours_of(B, p) - {q})
        w = nb[0]
        clauses.append([-x(idx[w], 3)])
        brk_info["w"] = w
    else:
        assert brk == "none"
    rng.shuffle(clauses)  # clause order is also this file's own
    with open(path, "w") as f:
        f.write(f"p cnf {4 * n} {len(clauses)}\n")
        for cl in clauses:
            f.write(" ".join(map(str, cl)) + " 0\n")
    h = hashlib.sha256(open(path, "rb").read()).hexdigest()
    return dict(nvars=4 * n, nclauses=len(clauses), sha256=h, perm_seed=seed, brk=brk_info), perm, clauses


def decode(model, n, perm):
    """Colouring from a model: the unique true colour per vertex (asserted unique)."""
    pos = set(l for l in model if l > 0)
    col = []
    for v in range(n):
        cs = [c for c in range(4) if c * n + perm[v] + 1 in pos]
        assert len(cs) == 1, (v, cs)
        col.append(cs[0])
    return col


def verify_colouring(B, col, p=None, q=None):
    """Independent of the CNF: every edge of the graph (recomputed from U) gets two different colours."""
    idx = B["index"]
    bad = 0
    checked = 0
    for pt, i in idx.items():
        for u in B["U"]:
            r = tuple(a + b for a, b in zip(pt, u))
            j = idx.get(r)
            if j is not None:
                checked += 1
                if col[i] == col[j]:
                    bad += 1
    out = {"directed_edges_checked": checked, "monochromatic": bad, "colours_used": sorted(set(col))}
    if p is not None:
        out["c_p"], out["c_q"] = col[idx[p]], col[idx[q]]
    return out


def cpu():
    r = resource.getrusage(resource.RUSAGE_SELF)
    return r.ru_utime + r.ru_stime


def run(name, brk, solver, seed, budget_s, proof_path=None):
    B = L.build(verbose=False)
    p, q, facts = pair_facts(B, name)
    assert facts["p_in_Lambda"] and facts["q_in_Lambda"] and facts["p_in_ball"] and facts["q_in_ball"]
    assert not facts["delta_is_unit"]
    cnf_path = os.path.join(SCR, f"cnf-{name}-{brk}-s{seed}.cnf")
    meta, perm, clauses = make_cnf(B, p, q, brk, seed, cnf_path)
    rec = {"pair": name, "facts": {k: v for k, v in facts.items() if k != "common_neighbours"},
           "n_common_neighbours": len(facts["common_neighbours"]), "cnf": meta, "cnf_path": cnf_path,
           "solver": solver, "budget_s": budget_s}
    from pysat.solvers import Solver
    kw = {}
    if proof_path:
        kw["with_proof"] = True
    t0w, t0c = time.time(), cpu()
    s = Solver(name=solver, bootstrap_with=clauses, **kw)
    import threading
    timer = threading.Timer(budget_s, lambda: s.interrupt())
    timer.daemon = True  # an exception must never leave a live timer holding the process (and the shared lock) open
    timer.start()
    try:
        if solver == "lingeling":  # PySAT's Lingeling has no interruptible solve; the launcher bounds it by wall clock
            res = s.solve()
        else:
            res = s.solve_limited(expect_interrupt=True)
    finally:
        timer.cancel()
    rec["wall_s"] = round(time.time() - t0w, 2)
    rec["cpu_s_process"] = round(cpu() - t0c, 2)
    rec["verdict"] = {True: "SAT", False: "UNSAT", None: "UNKNOWN(budget)"}[res]
    rec["stats"] = s.accum_stats()
    if res is True:
        col = decode(s.get_model(), len(B["pts"]), perm)
        chk = verify_colouring(B, col, p, q)
        rec["colouring_check"] = chk
        assert chk["monochromatic"] == 0 and chk["c_p"] != chk["c_q"]
        cpath = os.path.join(SCR, f"colouring-{name}-{brk}-s{seed}.json")
        json.dump({"points_int36": [list(map(int, t)) for t in B["pts"]], "colour": col}, open(cpath, "w"))
        rec["colouring_path"] = cpath
    if res is False and proof_path:
        pr = s.get_proof()
        with open(proof_path, "w") as f:
            for line in pr:
                f.write(line + "\n")
        rec["proof_path"] = proof_path
        rec["proof_lines"] = len(pr)
    s.delete()
    return rec


GLUCOSE = os.path.join(SCR, "glucose/simp/glucose_release")


def run_external(name, brk, seed, budget_s, proof_path=None):
    """Write the CNF and run the standalone Glucose binary on it (proof streamed to disk when asked)."""
    import subprocess
    B = L.build(verbose=False)
    p, q, facts = pair_facts(B, name)
    assert facts["p_in_Lambda"] and facts["q_in_Lambda"] and facts["p_in_ball"] and facts["q_in_ball"]
    assert not facts["delta_is_unit"]
    cnf_path = os.path.join(SCR, f"cnf-{name}-{brk}-s{seed}.cnf")
    meta, perm, clauses = make_cnf(B, p, q, brk, seed, cnf_path)
    del clauses
    rec = {"pair": name, "facts": {k: v for k, v in facts.items() if k != "common_neighbours"},
           "n_common_neighbours": len(facts["common_neighbours"]), "cnf": meta, "cnf_path": cnf_path,
           "solver": "glucose (audemard/glucose 674dbba7, simp/glucose_release)", "budget_s": budget_s}
    cmd = [GLUCOSE, "-model", f"-cpu-lim={int(budget_s)}", cnf_path]
    if proof_path:
        cmd[1:1] = ["-certified", "-vbyte", f"-certified-output={proof_path}"]  # binary DRUP (drat-trim reads it)
    rec["cmd"] = " ".join(cmd)
    t0 = time.time()
    r0 = resource.getrusage(resource.RUSAGE_CHILDREN)
    pr = subprocess.run(cmd, capture_output=True, text=True)
    r1 = resource.getrusage(resource.RUSAGE_CHILDREN)
    rec["wall_s"] = round(time.time() - t0, 2)
    rec["cpu_s_solver"] = round((r1.ru_utime - r0.ru_utime) + (r1.ru_stime - r0.ru_stime), 2)
    rec["maxrss_kb_children"] = r1.ru_maxrss
    rec["exit"] = pr.returncode  # glucose: 10 SAT, 20 UNSAT
    lines = pr.stdout.splitlines()
    status = [l for l in lines if l.startswith("s ")]
    rec["status_line"] = status[-1] if status else None
    rec["solver_tail"] = [l for l in lines if l.startswith("c") and ("conflicts" in l or "CPU time" in l or "decisions" in l)][-4:]
    if pr.returncode == 10:
        lits = []
        for l in lines:
            if l.startswith("v "):
                lits.extend(int(t) for t in l[2:].split())
        col = decode([t for t in lits if t != 0], len(B["pts"]), perm)
        chk = verify_colouring(B, col, p, q)
        rec["colouring_check"] = chk
        assert chk["monochromatic"] == 0 and chk["c_p"] != chk["c_q"]
        rec["verdict"] = "SAT"
    elif pr.returncode == 20:
        rec["verdict"] = "UNSAT"
        if proof_path:
            rec["proof_path"] = proof_path
            rec["proof_bytes"] = os.path.getsize(proof_path)
    else:
        rec["verdict"] = "UNKNOWN(budget)"
    return rec


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("pair", choices=sorted(PAIRS))
    ap.add_argument("--brk", default="nb", choices=["cn", "nb", "none"])
    ap.add_argument("--solver", default="glucose4")
    ap.add_argument("--seed", type=int, default=20260923)
    ap.add_argument("--budget", type=float, default=3600)
    ap.add_argument("--proof", default=None)
    ap.add_argument("--out", default=None)
    a = ap.parse_args()
    if a.solver == "glucose-ext":
        rec = run_external(a.pair, a.brk, a.seed, a.budget, a.proof)
    else:
        rec = run(a.pair, a.brk, a.solver, a.seed, a.budget, a.proof)
    js = json.dumps(rec, default=str, indent=1)
    print(js)
    if a.out:
        with open(a.out, "a") as f:
            f.write(json.dumps(rec, default=str) + "\n")
