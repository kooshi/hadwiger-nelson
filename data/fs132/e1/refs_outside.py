#!/usr/bin/env python3
"""FS132-E1: which labels does a section of the release's manuscript cite that it does not define itself?
Usage: refs_outside.py <section.tex>   (prints the sorted outside labels on one line)
A receipt for 'section 7 consumes nothing of sections 5-6 but Definition 6.1 and Theorem 6.5': no search, a text read."""
import re, sys, pathlib
M = pathlib.Path("/home/kooshi/source/math/preprints/The-Euclidean-plane-is-not-five-colorable-September-23-2026/build/sections")
t = (M / sys.argv[1]).read_text()
defined = set(re.findall(r"\\label\{([^}]*)\}", t))
cited = set()
for m in re.finditer(r"\\(?:eq)?ref\{([^}]*)\}", t):
    cited.update(x.strip() for x in m.group(1).split(","))
print(" ".join(sorted(cited - defined)) or "(none)")
