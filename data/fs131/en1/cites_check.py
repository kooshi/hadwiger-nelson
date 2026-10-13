#!/usr/bin/env python3
"""FS131-EN1 stage 6: do the proofs on the path of rows 121 and 123 cite R-U, or the Haar-null clause?

usage: cites_check.py <path>:<first>-<last> [...]      (paths from the repository root; 1-based line ranges)
Prints two counts over all ranges: mentions of the lemma `R-U`; mentions of `m(E)`, `Haar(E)` or `Haar(E_S)`."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
ru = re.compile(r"(?<![A-Za-z0-9-])R-U(?![A-Za-z0-9-])")
hn = re.compile(r"m\(E\)|Haar\(E(_S)?\)")
a = b = 0
for arg in sys.argv[1:]:
    path, rng = arg.rsplit(":", 1)
    lo, hi = map(int, rng.split("-"))
    for line in (root / path).read_text().splitlines()[lo - 1:hi]:
        a += len(ru.findall(line)); b += len(hn.findall(line))
print(a, b)
