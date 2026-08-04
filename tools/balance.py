#!/usr/bin/env python3
"""Cardinality-constrained colouring: can the graph be k-coloured with every class ≤ s?

UNTRUSTED, like everything in `tools/`. The solver only *proposes*; a SAT answer becomes a
theorem only after the witness is re-checked by the Lean kernel (`decide +kernel` over the
committed literal — `Proofs/HadwigerNelson/Instances/DeGreyBalanced.lean`), and an UNSAT
answer is a tool observation until an LRAT certificate goes through the kernel route.

## What it settled in M19 §0(c)

The pools said every 5-colouring of de Grey's graph has a colour class ≥ 21.1% of the
vertices; this instrument said that was the sampler's taste: **SAT at s = 317** — the exact
pigeonhole optimum ⌈1581/5⌉ — with witness class sizes [317, 316, 316, 316, 316]. Pool
statistics measure the solver's preferences, not the colouring space; only SAT/UNSAT
verdicts and matched contrasts are solver-independent.

## Encoding

Sinz sequential-counter per colour on top of `coloring.base_clauses`: registers
`r[i][j]` = "at least j of the first i+1 vertices wear this colour", clauses forbid
register `s` before another positive. Streamed to DIMACS (n·s registers per colour —
de Grey at s = 317 is 2.5M vars / 5.1M clauses, solving in ~2 min).

## Emission (`--emit`)

Packs the witness one hex nibble per vertex (nibble v = colour of vertex v) and writes a
Lean `def` fragment, after re-verifying the model proper and within the bound — the tool
refuses to emit anything it cannot re-check, and the kernel re-checks everything again.

    python3 tools/balance.py --self-test
    python3 tools/balance.py --cert degrey_cert --max-class 317
    python3 tools/balance.py --cert degrey_cert --max-class 317 --emit build/balanced.lean
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from coloring import base_clauses, var  # noqa: E402

REPO = Path(__file__).resolve().parent.parent
CADICAL = os.environ.get("CADICAL") or str(
    Path(subprocess.check_output(["lean", "--print-prefix"], text=True, cwd=REPO).strip())
    / "bin" / "cadical")


# ------------------------------------------------------------------ encode + solve

def write_cnf(path: Path, n: int, edges, k: int, s: int) -> tuple[int, int]:
    """Base colouring clauses + one sequential counter per colour, streamed to DIMACS."""
    base = base_clauses(n, edges, k)
    nv = k * n
    extra = 0
    with path.open("w") as f:
        f.write(" " * 60 + "\n")  # placeholder header, patched below
        for cl in base:
            f.write(" ".join(map(str, cl)) + " 0\n")
        for c in range(k):
            def r(i: int, j: int) -> int:
                return nv + (i * s + (j - 1)) + 1
            x = [var(v, c, k) for v in range(n)]
            lines = [f"{-x[0]} {r(0, 1)} 0"]
            for i in range(1, n):
                lines.append(f"{-x[i]} {r(i, 1)} 0")
                lines.append(f"{-r(i - 1, 1)} {r(i, 1)} 0")
                for j in range(2, s + 1):
                    lines.append(f"{-x[i]} {-r(i - 1, j - 1)} {r(i, j)} 0")
                    lines.append(f"{-r(i - 1, j)} {r(i, j)} 0")
                lines.append(f"{-x[i]} {-r(i - 1, s)} 0")
            f.write("\n".join(lines) + "\n")
            extra += len(lines)
            nv += n * s
    header = f"p cnf {nv} {len(base) + extra}"
    with path.open("r+b") as f:
        f.write(header.encode().ljust(60))
    return nv, len(base) + extra


def solve_bounded(n: int, edges, k: int, s: int,
                  timeout: float | None = None) -> tuple[str, list[int] | None]:
    """One (k, s) question. Returns (verdict, colours) — colours only on sat, already
    re-verified proper and within the bound; unknown is never folded into either side."""
    with tempfile.NamedTemporaryFile(suffix=".cnf", delete=False) as tf:
        cnf = Path(tf.name)
    try:
        write_cnf(cnf, n, edges, k, s)
        cmd = [CADICAL, "-q", str(cnf)]
        try:
            res = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
        except subprocess.TimeoutExpired:
            return "unknown", None
        if res.returncode == 20:
            return "unsat", None
        if res.returncode != 10:
            return "unknown", None
        model = set()
        for line in res.stdout.splitlines():
            if line.startswith("v"):
                for tok in line.split()[1:]:
                    lit = int(tok)
                    if lit > 0:
                        model.add(lit)
        colours = []
        for v in range(n):
            cs = [c for c in range(k) if var(v, c, k) in model]
            if len(cs) != 1:
                raise SystemExit(f"vertex {v} wears {len(cs)} colours in the model — "
                                 f"encoding bug, refusing")
        colours = [next(c for c in range(k) if var(v, c, k) in model) for v in range(n)]
        verify_witness(n, edges, colours, k, s)
        return "sat", colours
    finally:
        cnf.unlink(missing_ok=True)


def verify_witness(n: int, edges, colours: list[int], k: int, s: int) -> None:
    """Refuse, by name, every way a witness could fail its own claim."""
    if len(colours) != n:
        raise SystemExit(f"witness paints {len(colours)} of {n} vertices — refusing")
    for a, b in edges:
        if colours[a] == colours[b]:
            raise SystemExit(f"witness improper: edge ({a},{b}) monochrome in "
                             f"{colours[a]} — refusing")
    for c in range(k):
        size = colours.count(c)
        if size > s:
            raise SystemExit(f"witness class {c} has {size} > {s} vertices — refusing")


# ------------------------------------------------------------------ emission

def pack_nibbles(colours: list[int]) -> int:
    """One hex nibble per vertex, vertex 0 in the least-significant nibble."""
    w = 0
    for v in reversed(range(len(colours))):
        w = (w << 4) | colours[v]
    return w


def emit_lean(path: Path, name: str, colours: list[int], graph_note: str) -> None:
    w = pack_nibbles(colours)
    # re-extract every nibble before trusting the packing
    for v, c in enumerate(colours):
        assert (w >> (4 * v)) & 15 == c, "nibble packing broke — tool bug"
    sizes = sorted((colours.count(c) for c in set(colours)), reverse=True)
    path.write_text(
        f"-- emitted by tools/balance.py — {graph_note}; class sizes {sizes}\n"
        f"def {name} : Nat :=\n  0x{w:x}\n")
    print(f"witness ({len(colours)} vertices, sizes {sizes}) written to {path}")


# ------------------------------------------------------------------ self-test

def self_test() -> None:
    """Every verdict driven to a hand-computable case; every refusal watched refusing."""
    tri = [(0, 1), (0, 2), (1, 2)]
    # a balanced triangle: 3 colours, classes [1,1,1]
    st, cols = solve_bounded(3, tri, 3, 1)
    assert st == "sat" and sorted(cols) == [0, 1, 2], (st, cols)
    # chromatic infeasibility: K3 has no proper 2-colouring at any bound
    st, _ = solve_bounded(3, tri, 2, 3)
    assert st == "unsat", st
    # counting infeasibility: path P3, 2 colours, classes ≤ 1 — capacity 2 < 3
    path3 = [(0, 1), (1, 2)]
    st, _ = solve_bounded(3, path3, 2, 1)
    assert st == "unsat", st
    # the same path at s = 2 is satisfiable, classes [2, 1]
    st, cols = solve_bounded(3, path3, 2, 2)
    assert st == "sat" and sorted(cols.count(c) for c in {0, 1}) == [1, 2], (st, cols)

    # refusals, each by name
    try:
        verify_witness(3, tri, [0, 0, 1], 3, 1)
        raise AssertionError("improper witness accepted — refusal broken")
    except SystemExit:
        pass
    try:
        verify_witness(3, path3, [0, 1, 0], 2, 1)
        raise AssertionError("over-bound class accepted — refusal broken")
    except SystemExit:
        pass

    # emission round-trip: every nibble re-extracts
    import tempfile as tfmod
    with tfmod.TemporaryDirectory() as td:
        p = Path(td) / "w.lean"
        emit_lean(p, "testWitness", [4, 0, 3, 2, 1], "self-test")
        text = p.read_text()
        w = int(text.split("0x")[1].strip(), 16)
        assert [(w >> (4 * v)) & 15 for v in range(5)] == [4, 0, 3, 2, 1]

    print("balance.py self-test OK")


# ------------------------------------------------------------------ CLI

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--cert", help="graph by certificate JSON under tools/")
    ap.add_argument("--ledger-name", help="graph by hunt_ledger name")
    ap.add_argument("--max-class", type=int, required=False,
                    help="the bound s: every colour class must have ≤ s vertices")
    ap.add_argument("--colours", type=int, default=5)
    ap.add_argument("--timeout", type=float, default=None)
    ap.add_argument("--emit", help="write the witness as a Lean Nat literal to this path")
    ap.add_argument("--emit-name", default="balancedWitnessPacked")
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    if not (args.cert or args.ledger_name) or args.max_class is None:
        ap.error("need a graph (--cert or --ledger-name) and --max-class — or --self-test")

    if args.cert:
        d = json.load(open(Path(__file__).resolve().parent / f"{args.cert}.json"))
        edges = [tuple(e) for e in d["edges"]]
        n, gname = len(d["coords"]), args.cert
    else:
        from coverage import by_ledger_name  # noqa: PLC0415
        _, cfg = by_ledger_name(args.ledger_name)
        edges, n, gname = cfg.edges(), len(cfg), args.ledger_name

    k, s = args.colours, args.max_class
    print(f"{gname}: {n} pts, {len(edges)} edges — {k} colours, every class ≤ {s}?")
    t0 = time.time()
    st, cols = solve_bounded(n, edges, k, s, args.timeout)
    print(f"{st} ({time.time() - t0:.0f}s)")
    if st == "sat":
        sizes = sorted((cols.count(c) for c in range(k)), reverse=True)
        print(f"witness verified proper, class sizes {sizes}")
        if args.emit:
            from coverage import edges_digest  # noqa: PLC0415
            emit_lean(Path(args.emit), args.emit_name, cols,
                      f"{gname} n={n} edges_sha={edges_digest(n, edges)} k={k} s={s}")
    elif args.emit:
        print("nothing to emit — the verdict was not sat")


if __name__ == "__main__":
    main()
