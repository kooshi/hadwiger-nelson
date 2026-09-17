#!/usr/bin/env python3
"""fs58_emit_witness -- put FS-58's 204-point witness over Q(sqrt11) through the repository's emitters.

UNTRUSTED, like everything in tools/. It is a thin driver and adds no emission logic of its own: it translates
`data/fs58/witness-11/witness.json` into the input `tools/emit_cert.py` reads, decompresses the proof, and runs
`tools/emit_cert.py` (the geometry: `Instances/SqrtEleven/{Table,Edges,Geom00,Valid}.lean`) and `tools/emit_mask.py`
(the refutation: `Instances/SqrtEleven/Cnf/`). Lean re-derives every claim from the emitted data, so a mistake here
can only produce modules that fail to build.

The translation. A witness point (a, b, c, e, m) is ((a + b sqrt11)/m, (c + e sqrt11)/m). Scaled by D = lcm of the
m's (150 for this witness), each coordinate is an integer combination of 1 and sqrt11, which in `emit_cert.py`'s
sixteen-slot mask order are slots 0 and 8 (bit 3 is sqrt11). The other fourteen slots are zero, which is what
`Q4.elevenOnly` asks of the emitted table and what `Instances/SqrtEleven.lean` decides.

The formula. `emit_mask.py` builds `coloringCNF 3 204 edges ++ cubeCNF 3 204 [(0,0), (1,1)]` from the edge list
through `tools/coloring.py`. The witness's proof numbers the formula the way `tools/fs58_check_witness.py` builds it
(per-vertex clauses, then per edge in sorted order, then the pin on edge [0, 1]). This driver refuses unless the file's
edge list is already sorted and the two constructions agree clause for clause, so the proof's clause ids address the
formula the emitter writes. (Lean's `agreesWithCNF` is the real check; this one only saves a wasted build.)

Usage (from the repository root):
    python3 tools/fs58_emit_witness.py                   # writes build/fs58-emit-11/ and the Lean modules
    python3 tools/fs58_emit_witness.py --four-colouring  # prints the proper 4-colouring that
                                                         # `Instances/SqrtEleven.lean` carries as its control
"""
import gzip
import hashlib
import json
import math
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import coloring  # noqa: E402

WITNESS = ROOT / "data/fs58/witness-11/witness.json"
PROOF = ROOT / "data/fs58/witness-11/witness.lrat.gz"
SCRATCH = ROOT / "build/fs58-emit-11"
NAME = "eleven204"
DIR = "Proofs/HadwigerNelson/Instances/SqrtEleven"
MOD = DIR.replace("/", ".")
COLOURS = 3
SQRT11_SLOT = 8   # mask bit 3 <-> sqrt11 in emit_cert.py's order {1, sqrt3, sqrt5, sqrt15, sqrt7, ...}


def four_colouring(n, edges):
    """A proper 4-colouring by DSatur-ordered backtracking. The kernel re-checks it edge by edge
    (`eleven204_colour_proper`), so nothing here is believed."""
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    col = [-1] * n

    def pick():
        free = [v for v in range(n) if col[v] < 0]
        if not free:
            return None
        return max(free, key=lambda v: (len({col[u] for u in adj[v] if col[u] >= 0}), len(adj[v]), -v))

    def search():
        v = pick()
        if v is None:
            return True
        used = {col[u] for u in adj[v]}
        for c in range(4):
            if c not in used:
                col[v] = c
                if search():
                    return True
        col[v] = -1
        return False

    assert search(), "no 4-colouring found"
    assert all(col[a] != col[b] for a, b in edges)
    return col


def main():
    W = json.load(open(WITNESS))
    if "--four-colouring" in sys.argv:
        col = four_colouring(len(W["points"]), [tuple(e) for e in W["edges"]])
        print("[" + ", ".join(map(str, col)) + "]")
        return
    pts = [tuple(p) for p in W["points"]]
    n = len(pts)
    edges = [tuple(e) for e in W["edges"]]
    assert edges == sorted(edges) and all(i < j for i, j in edges), "edge list must be sorted with i < j"
    assert len(set(edges)) == len(edges), "duplicate edge"
    p, q = W["pinned_edge"]
    assert (p, q) == (0, 1) and (0, 1) in set(edges), "the pin the emitter writes is [(0,0), (1,1)] on edge [0, 1]"

    D = 1
    for pt in pts:
        D = math.lcm(D, pt[4])
    coords = []
    for a, b, c, e, m in pts:
        assert D % m == 0
        s = D // m
        x = [0] * 16
        y = [0] * 16
        x[0], x[SQRT11_SLOT] = a * s, b * s
        y[0], y[SQRT11_SLOT] = c * s, e * s
        coords.append([x, y])

    # the formula the proof refutes, built the checker's way, against the one the emitter will build
    x_ = lambda v, k: 3 * v + k + 1
    checker = [[x_(v, 0), x_(v, 1), x_(v, 2)] for v in range(n)]
    for i, j in sorted(edges):
        checker += [[-x_(i, k), -x_(j, k)] for k in range(3)]
    checker += [[x_(p, 0)], [x_(q, 1)]]
    emitter = coloring.base_clauses(n, edges, COLOURS) + coloring.pin_clauses([(0, 0), (1, 1)], COLOURS)
    assert emitter == checker, "tools/coloring.py and the checker disagree on the formula"

    SCRATCH.mkdir(parents=True, exist_ok=True)
    cert = SCRATCH / f"{NAME}.json"
    json.dump({"denom": D, "coords": coords, "edges": [list(e) for e in edges]}, open(cert, "w"))
    text = gzip.decompress(PROOF.read_bytes())
    sha = hashlib.sha256(text).hexdigest()
    assert sha == W["proof_sha256_uncompressed"], f"proof sha256 {sha} does not match the witness file"
    lrat = SCRATCH / "witness.lrat"
    lrat.write_bytes(text)
    print(f"{n} points, {len(edges)} edges, denom {D}, proof sha256 {sha[:12]}...", flush=True)

    subprocess.run([sys.executable, "tools/emit_cert.py", str(cert), NAME, "--dir", DIR],
                   cwd=ROOT, check=True)
    subprocess.run([sys.executable, "tools/emit_mask.py", "--edges", str(cert), "--n", str(n),
                    "--edges-name", f"{NAME}.edges", "--import", f"{MOD}.Edges",
                    "--pins", "[(0,0),(1,1)]", "--colours", str(COLOURS), "--lrat", str(lrat),
                    "--name", NAME, "--out", f"{DIR}/Cnf", "--module", f"{MOD}.Cnf",
                    "--segments", "2", "--table-modules", "4"],
                   cwd=ROOT, check=True)


if __name__ == "__main__":
    main()
