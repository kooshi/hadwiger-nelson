#!/usr/bin/env python3
"""The colouring CNF's clause order, stated once.

Every tool here that touches a formula needs the same three facts — which DIMACS variable means
"vertex `v` has colour `c`", which clause sits at which position, and that a *pin* is the only
width-1 clause a colouring formula can contain. They were written down in three places, which is how
two of them drift; this is the one place.

The order must match `Sat/Encoding.lean`'s `coloringCNF k n E ++ cubeCNF k n cube` exactly, because
the certificate addresses clauses **by position**:

    ids 0 .. n-1                 one at-least-one clause per vertex, width k
    ids n .. n + k*|E| - 1       k clauses per edge, width 2, in edge order
    the rest                     one unit clause per pin, width 1

UNTRUSTED, like everything in `tools/`. Lean re-derives the agreement between the emitted table and
the formula (`ClauseTable.agreesWithCNF`), so a mistake here costs a theorem and cannot buy one.
"""

from __future__ import annotations

from pathlib import Path

K = 4  # colours


def var(v: int, c: int) -> int:
    """The DIMACS variable for "vertex `v` has colour `c`" — `colorVar k v c`, plus one."""
    return K * v + c + 1


def unvar(x: int) -> tuple[int, int]:
    """Inverse of `var`, for reading a formula back."""
    return divmod(x - 1, K)


def base_clauses(n: int, edges: list[tuple[int, int]]) -> list[list[int]]:
    """`coloringCNF K n edges`, in Lean's order. **Contains no unit clause** — see `is_unpinned`."""
    out = [[var(v, c) for c in range(K)] for v in range(n)]
    for (a, b) in edges:
        out += [[-var(a, c), -var(b, c)] for c in range(K)]
    return out


def pin_clauses(pins: list[tuple[int, int]]) -> list[list[int]]:
    """`cubeCNF K n pins` — one unit clause per pinned vertex."""
    return [[var(v, c)] for (v, c) in pins]


def is_unpinned(clauses: list[list[int]]) -> bool:
    """No clause of width 1.

    This is the invariant M06 broke: the emitter was handed a formula that already carried its pins,
    appended them again, and the double-counted cube surfaced two stages later as a failing size
    theorem in Lean. A pin is the only width-1 clause `coloringCNF` can produce, so the property is
    exactly the negation of that bug — and the emitters now build the base themselves rather than
    reading one, which makes the wrong input unrepresentable rather than merely detected.
    """
    return all(len(c) > 1 for c in clauses)


def write_cnf(path: Path, n: int, edges: list[tuple[int, int]],
              pins: list[tuple[int, int]]) -> None:
    """DIMACS for `coloringCNF K n edges ++ cubeCNF K n pins`."""
    cl = base_clauses(n, edges) + pin_clauses(pins)
    with open(path, "w") as f:
        f.write(f"p cnf {K * n} {len(cl)}\n")
        for c in cl:
            f.write(" ".join(map(str, c)) + " 0\n")


def read_cnf(path: Path) -> tuple[int, list[tuple[int, int]], list[tuple[int, int]]]:
    """Recover `(n, edges, pins)` from a DIMACS file this module wrote."""
    n, edges, pins = 0, [], []
    for line in open(path):
        if line[0] == "c":
            continue
        if line[0] == "p":
            n = int(line.split()[2]) // K
            continue
        lits = [int(x) for x in line.split()[:-1]]
        if len(lits) == 1:
            pins.append(unvar(lits[0]))
        elif len(lits) == 2:
            edges.append((unvar(-lits[0])[0], unvar(-lits[1])[0]))
    return n, sorted(set(edges)), pins
