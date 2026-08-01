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

**The colour count is a parameter, defaulting to four.** Every witness in this repository refutes
4-colourings, so `K = 4` was written into this module and nothing pushed on it; chi(R^2) >= 6 means
refuting *five*-colourings, and M11 threaded the count through Lean's `Gadget` for the same reason.
Callers that say nothing still get four.

UNTRUSTED, like everything in `tools/`. Lean re-derives the agreement between the emitted table and
the formula (`ClauseTable.agreesWithCNF`), so a mistake here costs a theorem and cannot buy one.
"""

from __future__ import annotations

from pathlib import Path

K = 4  # colours


def var(v: int, c: int, k: int = K) -> int:
    """The DIMACS variable for "vertex `v` has colour `c`" — `colorVar k v c`, plus one."""
    return k * v + c + 1


def unvar(x: int, k: int = K) -> tuple[int, int]:
    """Inverse of `var`, for reading a formula back."""
    return divmod(x - 1, k)


def base_clauses(n: int, edges: list[tuple[int, int]], k: int = K) -> list[list[int]]:
    """`coloringCNF k n edges`, in Lean's order. **Contains no unit clause** — see `is_unpinned`."""
    out = [[var(v, c, k) for c in range(k)] for v in range(n)]
    for (a, b) in edges:
        out += [[-var(a, c, k), -var(b, c, k)] for c in range(k)]
    return out


def pin_clauses(pins: list[tuple[int, int]], k: int = K) -> list[list[int]]:
    """`cubeCNF k n pins` — one unit clause per pinned vertex."""
    return [[var(v, c, k)] for (v, c) in pins]


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
              pins: list[tuple[int, int]], k: int = K) -> None:
    """DIMACS for `coloringCNF k n edges ++ cubeCNF k n pins`."""
    cl = base_clauses(n, edges, k) + pin_clauses(pins, k)
    with open(path, "w") as f:
        f.write(f"p cnf {k * n} {len(cl)}\n")
        for c in cl:
            f.write(" ".join(map(str, c)) + " 0\n")


def read_cnf(path: Path, k: int = K) -> tuple[int, list[tuple[int, int]], list[tuple[int, int]]]:
    """Recover `(n, edges, pins)` from a DIMACS file this module wrote."""
    n, edges, pins = 0, [], []
    for line in open(path):
        if line[0] == "c":
            continue
        if line[0] == "p":
            n = int(line.split()[2]) // k
            continue
        lits = [int(x) for x in line.split()[:-1]]
        if len(lits) == 1:
            pins.append(unvar(lits[0], k))
        elif len(lits) == 2:
            edges.append((unvar(-lits[0], k)[0], unvar(-lits[1], k)[0]))
    return n, sorted(set(edges)), pins


def canon_patterns(k: int, m: int) -> list[list[int]]:
    """**One colour pattern per partition of `m` ports into at most `k` blocks.**

    Must agree with `Proofs/HadwigerNelson/Pattern.lean`'s `canonPatterns k m`, element for element
    and in the same order, because a profile's entries are read against that list. The agreement is
    not assumed: `--check` prints this list for comparison against `#eval canonPatterns k m`, and the
    Lean side re-derives every claim anyway, so a disagreement costs a theorem and cannot buy one.

    Colours are numbered in order of first occurrence, so position 0 is always colour 0 and no name
    is ever skipped.
    """
    out: list[list[int]] = []

    def go(prefix: list[int], used: int) -> None:
        if len(prefix) == m:
            out.append(list(prefix))
            return
        for c in range(min(used + 1, k)):
            go(prefix + [c], max(used, c + 1))

    go([], 0)
    return out
