#!/usr/bin/env python3
"""FS131-EN1: how often a hypothesis name occurs inside one Lean theorem's text (binder included).

usage: unused_check.py <theorem name> <hypothesis name>
Prints the count of whole-word occurrences between the theorem's header line and the next blank line.
A name bound once and never used prints 1."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
src = (root / "Proofs/HadwigerNelson/SpectralChain.lean").read_text().splitlines()
thm, hyp = sys.argv[1], sys.argv[2]
start = next(i for i, l in enumerate(src) if l.startswith("theorem " + thm + " "))
end = next(i for i in range(start, len(src)) if src[i].strip() == "")
print(sum(len(re.findall(r"(?<![A-Za-z0-9_'])" + re.escape(hyp) + r"(?![A-Za-z0-9_'])", l)) for l in src[start:end]))
