#!/usr/bin/env python3
"""fs50_race — price the cardinality encodings and the orbit cubes for "an independent set of size ≥ N in UD(F_p, 2)"
(FS-50 stub D2/D3). Writes a DIMACS file (edge clauses, the origin pinned, the cube's pins and exclusions, the cardinality
constraint from pysat's CardEnc) and runs the toolchain's `cadical` with a wall (`-t`), so a record is written on EVERY
path (sat / unsat / unknown at the wall). A cube pins a point of quadrance class c and excludes every class below it —
sound for a refutation: the rotations act transitively on each class, so the smallest class an independent set meets can
be rotated onto its representative. A 'sat' is verified from the definition; 'unsat' and 'unknown' are the solver's word."""
import argparse, json, os, subprocess, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane
from pysat.card import CardEnc, EncType

def cadical_bin():
    """the Lean toolchain's cadical, resolved from the repository's pin so a detached shell without `lean` on PATH still finds it"""
    pin = (Path(__file__).resolve().parent.parent / "lean-toolchain").read_text().strip()  # e.g. leanprover/lean4:v4.32.0
    cand = Path.home() / ".elan" / "toolchains" / pin.replace("/", "--").replace(":", "---") / "bin" / "cadical"
    if not cand.exists():
        pre = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip()
        cand = Path(pre) / "bin" / "cadical"
    assert cand.exists(), f"cadical not found at {cand}"
    return str(cand)

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True); ap.add_argument("--N", type=int, required=True)
    ap.add_argument("--enc", default="totalizer"); ap.add_argument("--cube", type=int, default=0, help="pin a point of this class; exclude classes below")
    ap.add_argument("--wall", type=float, default=840.0); ap.add_argument("--out", required=True)
    ap.add_argument("--cnf", help="where to write the DIMACS (default beside --out)")
    a = ap.parse_args()
    p, n = a.p, a.p * a.p
    E, deg = fplane.ud_edges(p)
    t0 = time.time()
    clauses = [[-(u + 1), -(v + 1)] for u, v in E]
    clauses.append([1])  # the origin, v = 0·p + 0
    pinned = [0]; excluded = 0
    if a.cube:
        cls = {}
        for x in range(p):
            for y in range(p):
                if (x, y) != (0, 0):
                    cls.setdefault((x * x + y * y) % p, []).append(x * p + y)
        rep = cls[a.cube][0]; clauses.append([rep + 1]); pinned.append(rep)
        for c in range(1, a.cube):
            for v in cls.get(c, []):
                clauses.append([-(v + 1)]); excluded += 1
    card = CardEnc.atleast(lits=list(range(1, n + 1)), bound=a.N, top_id=n, encoding=getattr(EncType, a.enc))
    clauses.extend(card.clauses); nv = max(n, card.nv)
    cnf = Path(a.cnf) if a.cnf else Path(a.out).with_suffix(".cnf")
    with open(cnf, "w") as f:
        f.write(f"p cnf {nv} {len(clauses)}\n")
        for cl in clauses:
            f.write(" ".join(map(str, cl)) + " 0\n")
    t1 = time.time()
    r = subprocess.run([cadical_bin(), "-q", "-t", str(int(a.wall)), str(cnf)], capture_output=True, text=True)
    secs = time.time() - t1
    verdict = {10: "sat", 20: "unsat", 0: "unknown"}.get(r.returncode, f"exit{r.returncode}")
    rec = dict(kind="fs50-race", p=p, n=n, N=a.N, encoding=a.enc, cube=a.cube, pinned=pinned, excluded=excluded, wall=a.wall,
               clauses=len(clauses), aux_vars=nv - n, encode_seconds=t1 - t0, solve_seconds=secs, verdict=verdict,
               solver="cadical 2.1.2 (the Lean toolchain's), -t wall", cnf=str(cnf))
    if verdict == "sat":
        m = set()
        for line in r.stdout.splitlines():
            if line.startswith("v "):
                m.update(int(x) for x in line[2:].split() if int(x) > 0)
        S = [v for v in range(n) if (v + 1) in m]
        Es = set(E); assert all((min(u, v), max(u, v)) not in Es for u in S for v in S if u != v), "not independent"
        assert len(S) >= a.N, "model smaller than N"
        rec["independent_set"] = S; rec["size"] = len(S)
    Path(a.out).write_text(json.dumps(rec, indent=1))
    print(json.dumps({k: rec[k] for k in ("encoding", "cube", "verdict", "solve_seconds", "clauses")}))

if __name__ == "__main__":
    main()
