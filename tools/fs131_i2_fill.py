#!/usr/bin/env python3
"""FS131-I2 helper: replace the `sorry` leaf of a named theorem by a proof body read from a file.
usage: fs131_i2_fill.py <lean file> <theorem name> <body file>
The body file holds the tactic block (indented two spaces), replacing the first line that is exactly `  sorry`
after `theorem <name>`. Refuses if the name or the sorry is missing, or the theorem's header line changes."""
import re, sys
path, name, bodyf = sys.argv[1:4]
src = open(path).read()
m = re.search(r'^(theorem|lemma) ' + re.escape(name) + r'\b', src, re.M)
if not m:
    sys.exit(f"no theorem {name}")
j = src.find("\n  sorry\n", m.end())
if j < 0:
    sys.exit(f"no sorry leaf after {name}")
# the sorry must belong to this theorem: no other top-level declaration in between
between = src[m.end():j]
if re.search(r'^(theorem|lemma|def|noncomputable def|structure|instance) ', between, re.M):
    sys.exit(f"the next sorry is not {name}'s")
body = open(bodyf).read().rstrip("\n")
src = src[:j] + "\n" + body + "\n" + src[j + len("\n  sorry\n"):]
open(path, "w").write(src)
print("filled", name)
