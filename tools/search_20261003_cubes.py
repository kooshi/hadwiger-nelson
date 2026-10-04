#!/usr/bin/env python3
"""SEARCH-2026-10-03: cube-and-conquer with a per-cube LRAT proof, checkpointed per cube.

The base formula is the encoder's CNF (tools/search_20261003_encode.py, written with --cnf-only). A cube fixes s chosen variables
to every one of the 2^s sign patterns; cube i is the base formula plus s unit clauses, appended AFTER the base clauses (so the base
clause ids are unchanged), the j-th unit being +var_j if bit j of i is 1 and -var_j otherwise. The 2^s patterns are a syntactic
cover: if every cube is UNSAT, the base formula is UNSAT, whatever the variables mean.

Each worker solves one cube with cadical (binary LRAT), checks the proof with cake_lpr at once, gzips it, and appends one JSON line to
OUT/cubes.jsonl. Resume: re-run the same command; cubes already in cubes.jsonl are skipped (a cube in flight at a kill is redone).
A SAT cube stops the run (its model is kept for the decoder). A cube that times out is recorded UNKNOWN and the run continues;
UNKNOWN cubes are run again on resume (pass a longer --cube-timeout, and --only to choose them).

Usage:
  python3 tools/search_20261003_cubes.py BASE.cnf OUT --vars v1,v2,... --workers N --cube-timeout S [--only i,j,...] [--keep-proofs]
"""
import argparse
import gzip
import json
import multiprocessing
import os
import shutil
import subprocess
import sys
import time

CADICAL = os.path.expanduser("~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical")
CAKE = os.path.expanduser("~/source/cake_lpr/cake_lpr")

G = {}


def _die_with_parent():
    import ctypes
    import signal
    ctypes.CDLL("libc.so.6", use_errno=True).prctl(1, signal.SIGKILL)   # PR_SET_PDEATHSIG: cadical dies with its worker


def init(base, out, vars_, timeout, keep):
    with open(base) as f:
        hdr = f.readline().split()
        body = f.read()
    G.update(nv=int(hdr[2]), nc=int(hdr[3]), body=body, out=out, vars=vars_, timeout=timeout, keep=keep)


def units(i):
    return [v if (i >> j) & 1 else -v for j, v in enumerate(G["vars"])]


def solve(i):
    out = G["out"]
    u = units(i)
    cnf = os.path.join(out, f"cube{i:05d}.cnf")
    with open(cnf, "w") as f:
        f.write(f"p cnf {G['nv']} {G['nc'] + len(u)}\n")
        f.write(G["body"])
        for lit in u:
            f.write(f"{lit} 0\n")
    proof = os.path.join(out, f"cube{i:05d}.lrat")
    log = os.path.join(out, f"cube{i:05d}.log")
    t0 = time.time()
    with open(log, "w") as lf:
        r = subprocess.run([CADICAL, "--lrat=true", "-t", str(G["timeout"]), cnf, proof], stdout=lf, stderr=subprocess.STDOUT,
                           preexec_fn=_die_with_parent)
    wall = time.time() - t0
    entry = {"cube": i, "units": u, "rc": r.returncode, "wall": round(wall, 2)}
    if r.returncode == 20:
        c = subprocess.run([CAKE, cnf, proof], capture_output=True, text=True)
        last = (c.stdout + c.stderr).strip().splitlines()
        entry["cake"] = last[-1] if last else ""
        entry["status"] = "UNSAT-VERIFIED" if entry["cake"] == "s VERIFIED UNSAT" else "UNSAT-PROOF-REJECTED"
        entry["proof_bytes"] = os.path.getsize(proof)
        if G["keep"]:
            with open(proof, "rb") as a, gzip.open(proof + ".gz", "wb", compresslevel=6) as b:
                shutil.copyfileobj(a, b)
            entry["proof_gz"] = os.path.basename(proof) + ".gz"
        os.remove(proof)
        os.remove(log)
    elif r.returncode == 10:
        entry["status"] = "SAT"
        if os.path.exists(proof):
            os.remove(proof)
    else:
        entry["status"] = "UNKNOWN" if r.returncode == 0 else f"ERROR-rc{r.returncode}"
        if os.path.exists(proof):
            os.remove(proof)
    os.remove(cnf)
    return entry


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("base")
    ap.add_argument("out")
    ap.add_argument("--vars", required=True)
    ap.add_argument("--workers", type=int, required=True)
    ap.add_argument("--cube-timeout", type=int, required=True)
    ap.add_argument("--only", default="")
    ap.add_argument("--keep-proofs", action="store_true")
    a = ap.parse_args()
    vars_ = [int(x) for x in a.vars.split(",")]
    os.makedirs(a.out, exist_ok=True)
    man = os.path.join(a.out, "manifest.json")
    m = {"base": os.path.abspath(a.base), "vars": vars_, "cubes": 1 << len(vars_),
         "rule": "cube i = base + units (+v_j if bit j of i else -v_j), appended after the base clauses"}
    if os.path.exists(man):
        old = json.load(open(man))
        if old["vars"] != vars_ or old["base"] != m["base"]:
            sys.exit(f"REFUSED: {man} was made for other vars or another base")
    else:
        json.dump(m, open(man, "w"), indent=1)
    rec = os.path.join(a.out, "cubes.jsonl")
    done = set()
    if os.path.exists(rec):
        for line in open(rec):
            e = json.loads(line)
            if e["status"] == "SAT" or (e["status"] == "UNSAT-VERIFIED" and (e.get("proof_gz") or not a.keep_proofs)):
                done.add(e["cube"])          # an UNKNOWN cube (timed out) is run again on resume
    todo = [int(x) for x in a.only.split(",")] if a.only else list(range(1 << len(vars_)))
    todo = [i for i in todo if i not in done]
    print(f"cubes: {len(todo)} to run ({len(done)} done) of {1 << len(vars_)}; workers {a.workers}; cube timeout {a.cube_timeout} s",
          flush=True)
    ctx = multiprocessing.get_context("fork")
    t0 = time.time()
    counts = {}
    with ctx.Pool(a.workers, initializer=init, initargs=(a.base, a.out, vars_, a.cube_timeout, a.keep_proofs)) as pool:
        for e in pool.imap_unordered(solve, todo):
            with open(rec, "a") as f:
                f.write(json.dumps(e) + "\n")
            counts[e["status"]] = counts.get(e["status"], 0) + 1
            n = sum(counts.values())
            if n % 16 == 0 or e["status"] not in ("UNSAT-VERIFIED",):
                print(f"[{time.time() - t0:.0f}s] {n}/{len(todo)} {counts} last: cube {e['cube']} {e['status']} {e['wall']}s", flush=True)
            if e["status"] == "SAT" or e["status"].startswith("ERROR") or e["status"] == "UNSAT-PROOF-REJECTED":
                print(f"STOP: cube {e['cube']} {e['status']}", flush=True)
                pool.terminate()
                break
    print(f"CUBES END: {counts} wall {time.time() - t0:.0f}s", flush=True)


if __name__ == "__main__":
    main()
