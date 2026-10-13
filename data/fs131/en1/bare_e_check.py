#!/usr/bin/env python3
"""FS131-EN1: does a stretch of J45's record name the union E, or only E_S?

usage: bare_e_check.py <first>-<last> [<first>-<last> ...]     (1-based line ranges of plans/FS84-SI-D-derivation.md)
Counts the occurrences of the set `E` written bare: an `E` that is not `E_S`, not an expectation `E[`, `E⟨`, and not part
of a word. Prints the count over all ranges, then the count of `E_S`.
Guard: each range must begin at a line starting with "**Lemma", "**Corollary" or "*Remarks" (so a shifted file fails loudly)."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
src = (root / "plans/FS84-SI-D-derivation.md").read_text().splitlines()
bare = re.compile(r"(?<![A-Za-z_\\])E(?![A-Za-z_\[⟨])")
es = re.compile(r"(?<![A-Za-z])E_S(?![A-Za-z])")
nb = ns = 0
for r in sys.argv[1:]:
    a, b = map(int, r.split("-"))
    if not src[a - 1].startswith(("**Lemma", "**Corollary", "*Remarks")):
        sys.exit(f"range {r} does not start at a lemma: {src[a - 1][:40]!r}")
    for line in src[a - 1:b]:
        nb += len(bare.findall(line)); ns += len(es.findall(line))
print(nb, ns)
