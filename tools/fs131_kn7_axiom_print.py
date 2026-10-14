#!/usr/bin/env python3
"""FS131-KN7: the declared statement's print (default options) in two logs, compared character for character.

usage: fs131_kn7_axiom_print.py <old log> <new log> [--plant]
The block is the text from the line beginning `@positive_entropy_rigidity :` up to (not including) the line beginning
`@haar_or_zero_entropy`. Exit 0: both blocks found and identical; exit 1 otherwise. --plant changes one character of the
new block in memory and requires the comparison to report it (the negative control)."""
import re, sys
def block(path):
    t = open(path).read()
    m = re.search(r"^(@positive_entropy_rigidity : .*?)^@haar_or_zero_entropy", t, re.S | re.M)
    return m.group(1) if m else None
a, b = block(sys.argv[1]), block(sys.argv[2])
if a is None or b is None:
    print("FAIL: block missing in", sys.argv[1] if a is None else sys.argv[2]); sys.exit(1)
if "--plant" in sys.argv:
    b = b.replace("ksEntropy", "ksEntropyOn", 1)
print(f"old={len(a)} chars new={len(b)} chars", "IDENTICAL" if a == b else "DIFFER")
sys.exit(0 if a == b else 1)
