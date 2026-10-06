#!/usr/bin/env python3
"""SEARCH-2026-10-06 — the runs. Each instance is one line of a JSONL file (the checkpoint: a relaunch skips the keys already
there, so a death redoes only the instances in flight); each UNSAT is cake_lpr-verified before its line is written, and its
proof kept gzipped beside the CNF's sha256; each SAT on a whole torus is checked by `violations` and written as a certificate.

  run.py OUT.jsonl JOBS grids NMAX                  torusGrid n m (Lean's own object), 3 <= n <= m <= NMAX
  run.py OUT.jsonl JOBS windows NAME N [N ...]      free-boundary windows of a named tiling on the N x N torus
  run.py OUT.jsonl JOBS tori NAME MAXINDEX          every quotient of a named tiling by a sublattice of index <= MAXINDEX
  run.py OUT.jsonl JOBS patterns P Q N {primal|dual} [tori MAXINDEX]
                                                    every diagonal pattern on the P x Q supercell (up to translation and
                                                    transpose): a window on the N x N torus, or its quotients
"""
import gzip
import hashlib
import itertools
import json
import multiprocessing
import os
import shutil
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from search_20261006_check import violations, torus_grid  # noqa: E402
from search_20261006_encode import build, window, run, diag_tiling, formula, write_cnf, CAKE  # noqa: E402

K = 6
TIMEOUT = 900
OUTDIR = None
RECHECK = None      # in recheck mode: key -> the line recorded for it


def recheck(key, M, cen, f0):
    """No solver: regenerate the CNF, require the recorded sha256, and run cake_lpr on the kept proof against it."""
    import subprocess
    import tempfile
    rec0 = RECHECK[key]
    with tempfile.TemporaryDirectory(dir=os.path.join(OUTDIR, "proofs")) as tmp:
        path = os.path.join(tmp, "x")
        write_cnf(formula(M, K, cen, f0), M.F * K, path)
        same = hashlib.sha256(open(path + ".cnf", "rb").read()).hexdigest() == rec0["cnf_sha256"]
        with gzip.open(os.path.join(OUTDIR, rec0["lrat"]), "rb") as a, open(path + ".lrat", "wb") as b:
            shutil.copyfileobj(a, b)
        q = subprocess.run([CAKE, path + ".cnf", path + ".lrat"], capture_output=True, text=True)
    ok = same and q.returncode == 0 and "s VERIFIED UNSAT" in q.stdout
    return dict(key=key, verdict="RECHECKED" if ok else "RECHECK-FAILED", cnf_same=same, cake=q.stdout.strip()[-40:])


def finish(key, M, v, col, dt, ncl, extra, whole):
    path = os.path.join(OUTDIR, "proofs", key)
    rec = dict(key=key, verdict=v, seconds=round(dt, 3), faces=M.F, darts=M.n, clauses=ncl, **extra)
    rec["cnf_sha256"] = hashlib.sha256(open(path + ".cnf", "rb").read()).hexdigest()
    if v == "UNSAT":
        with open(path + ".lrat", "rb") as a, gzip.open(path + ".lrat.gz", "wb") as b:
            shutil.copyfileobj(a, b)
        os.remove(path + ".lrat")
        rec["lrat"] = "proofs/" + key + ".lrat.gz"
        rec["cake_lpr"] = "s VERIFIED UNSAT"
    if v == "SAT" and whole:
        bad = {x: len(b) for x, b in violations(M, col, K).items() if b}
        rec["checker"] = "ACCEPTED" if not bad and M.chi2 == 0 else f"REJECTED {bad} chi2 {M.chi2}"
        cert = dict(k=K, map=dict(sigma=M.sigma, alpha=M.alpha), col_darts=[col[M.face[d]] for d in range(M.n)], source=extra)
        json.dump(cert, open(os.path.join(OUTDIR, "MODEL-" + key + ".json"), "w"))
    os.remove(path + ".cnf")
    return rec


def mapcheck(M):
    if M.chi2 != 0:
        return f"chi2 = {M.chi2}"
    if min(M.deg) < 3:
        return "three_le_deg fails"
    if any(M.mu):
        return "mu_zero fails"
    if max(M.len) >= K:
        return f"a face of length {max(M.len)} (edge_rainbow with proper needs len <= k - 1)"
    if max(M.deg) > K:
        return f"a vertex of degree {max(M.deg)} (proper needs deg <= k)"
    return None


def job(spec):
    key, kind, arg = spec
    try:
        path = os.path.join(OUTDIR, "proofs", key)
        if kind == "grid":
            M, _ = torus_grid(*arg)
            extra, cen, f0 = dict(map=f"torusGrid {arg[0]} {arg[1]}"), None, 0
        else:
            tiling, dual, A, B, Dd, win, label = arg
            M, dcell = build(tiling, A, B, Dd, dual)
            extra, cen, f0 = dict(map=label, lattice=[A, B, Dd]), None, 0
            if win:
                cen, m, f0 = window(M, dcell, A)
                if cen is None:
                    return dict(key=key, verdict="NO-WINDOW", **extra)
                extra.update(window=True, margin=m, centres=len(cen))
        degs = {d: M.deg.count(d) for d in sorted(set(M.deg))}
        lens = {s: M.len.count(s) for s in sorted(set(M.len))}
        extra.update(degrees=degs, lengths=lens)
        if cen is None:
            why = mapcheck(M)
            if why:
                return dict(key=key, verdict="MAP-EXCLUDED", reason=why, faces=M.F, **extra)
        if RECHECK is not None:
            return recheck(key, M, cen, f0)
        v, col, dt, ncl = run(M, K, path, cen, f0, TIMEOUT)
        return finish(key, M, v, col, dt, ncl, extra, cen is None)
    except Exception as e:  # a failure is a line, loudly, never a silence
        return dict(key=key, verdict="ERROR", error=repr(e)[:400])


def lattices(maxindex, minindex=1):
    for idx in range(minindex, maxindex + 1):
        for A in range(1, idx + 1):
            if idx % A == 0:
                for B in range(A):
                    yield A, B, idx // A


def canon(pat):
    p, q = len(pat), len(pat[0])
    best = None
    for T in (pat, [[pat[i][j] for i in range(p)] for j in range(q)]):       # the transpose keeps both diagonals
        pp, qq = len(T), len(T[0])
        for a in range(pp):
            for b in range(qq):
                c = (pp, qq, tuple(tuple(T[(i + a) % pp][(j + b) % qq] for j in range(qq)) for i in range(pp)))
                best = c if best is None or c < best else best
    return best


def patterns(p, q):
    reps = {}
    for flat in itertools.product(range(3), repeat=p * q):
        c = canon([list(flat[i * q:(i + 1) * q]) for i in range(p)])
        reps[c] = reps.get(c, 0) + 1
    assert sum(reps.values()) == 3 ** (p * q)
    return sorted(reps)


def main():
    global OUTDIR, RECHECK
    out, jobs, mode, args = sys.argv[1], int(sys.argv[2]), sys.argv[3], sys.argv[4:]
    if mode == "recheck":       # run.py OUT.jsonl JOBS recheck <mode> <args>: every UNSAT line of that mode, no solver
        mode, args = args[0], args[1:]
        RECHECK = {r["key"]: r for r in map(json.loads, open(out)) if r["verdict"] == "UNSAT"}
        if os.environ.get("SEARCH_PLANT"):      # the negative control: one recorded sha256 corrupted, to be seen refused
            RECHECK[os.environ["SEARCH_PLANT"]]["cnf_sha256"] = "0" * 64
    OUTDIR = os.path.dirname(os.path.abspath(out))
    os.makedirs(os.path.join(OUTDIR, "proofs"), exist_ok=True)
    specs = []
    if mode == "grids":
        specs = [(f"grid-{n}x{m}", "grid", (n, m)) for n in range(3, int(args[0]) + 1) for m in range(n, int(args[0]) + 1)]
    elif mode == "windows":
        specs = [(f"win-{args[0]}-{N}", "t", (args[0], False, int(N), 0, int(N), True, args[0])) for N in args[1:]]
    elif mode == "tori":
        specs = [(f"tor-{args[0]}-{A}.{B}.{D}", "t", (args[0], False, A, B, D, False, args[0])) for A, B, D in lattices(int(args[1]))]
    elif mode == "patterns":
        p, q, N, dual = int(args[0]), int(args[1]), int(args[2]), args[3] == "dual"
        for (pp, qq, pat) in patterns(p, q):
            name = f"{'dual' if dual else 'diag'}-{pp}x{qq}-" + "".join(str(x) for r in pat for x in r)
            til = diag_tiling([list(r) for r in pat])
            if len(args) > 4:
                specs += [(f"tor-{name}-{A}.{B}.{D}", "t", (til, dual, A, B, D, False, name)) for A, B, D in lattices(int(args[5]))]
            else:
                specs.append((f"win-{name}-{N}", "t", (til, dual, N, 0, N, True, name)))
    done = set()
    if os.path.exists(out):
        done = {json.loads(ln)["key"] for ln in open(out) if ln.strip()}
    todo = [s for s in specs if s[0] not in done]
    if RECHECK is not None:
        with multiprocessing.get_context("fork").Pool(jobs) as pool:
            res = list(pool.imap_unordered(job, [s for s in specs if s[0] in RECHECK]))
        bad = [r for r in res if r["verdict"] != "RECHECKED"]
        print(f"recheck {mode} {args}: {len(res)} UNSAT lines, {len(res) - len(bad)} RECHECKED (CNF regenerated to the recorded sha256, "
              f"kept proof verified by cake_lpr), {len(bad)} failed {bad[:3]}", flush=True)
        return 1 if bad or not res else 0
    print(f"{mode} {args}: {len(specs)} instances, {len(done & {s[0] for s in specs})} done, {len(todo)} to run on {jobs} workers", flush=True)
    tally = {}
    with multiprocessing.get_context("fork").Pool(jobs) as pool, open(out, "a") as h:
        for rec in pool.imap_unordered(job, todo):
            h.write(json.dumps(rec) + "\n")
            h.flush()
            tally[rec["verdict"]] = tally.get(rec["verdict"], 0) + 1
            if rec["verdict"] in ("SAT", "ERROR") and not rec.get("window"):
                print("  " + json.dumps(rec)[:600], flush=True)
    print(f"finished: {tally}", flush=True)
    return 1 if tally.get("ERROR") else 0


if __name__ == "__main__":
    sys.exit(main())
