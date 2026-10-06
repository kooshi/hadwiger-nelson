#!/usr/bin/env python3
"""FS131-MC1 — print the inhabitant note of a theorem's docstring: from its first marker to the docstring's end.

  fs131_mc_doctail.py <file.lean> <name> [<name> ...]
A reading aid for the docstring lines of the landing (which sentence is replaced); it decides nothing.
"""
import re, sys
MARK = re.compile(r"\*\*Inhabitant|Inhabitant|Model of the (local )?hypotheses|No Lean model|No model|At \[hand\]|At twelve colours|A step inside")

def tail(src, name):
    m = re.search(r"^(?:theorem|def|structure) " + re.escape(name) + r"\b", src, re.M)
    if not m:
        return None
    start = src.rfind("/--", 0, m.start())
    doc = src[start:m.start()]
    k = MARK.search(doc)
    return doc[k.start():] if k else "(no marker) " + doc[-300:]

if __name__ == "__main__":
    src = open(sys.argv[1]).read()
    for n in sys.argv[2:]:
        print("=== " + n); print(tail(src, n)); print()
