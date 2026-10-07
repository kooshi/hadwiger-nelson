#!/usr/bin/env python3
"""Replace the `sorry` body of one theorem in a Lean file by the text of a proof file.
usage: patch.py <lean file> <theorem name> <proof file>   (the proof file holds the tactic block, indented two spaces)"""
import sys, pathlib
f, name, pf = sys.argv[1:4]
p = pathlib.Path(f); s = p.read_text()
a = s.index('theorem ' + name + ' ')
b = s.index('  sorry\n', a)
nxt = s.find('\ntheorem ', a + 1)
assert nxt == -1 or b < nxt, 'no sorry in this theorem'
proof = pathlib.Path(pf).read_text().rstrip() + '\n'
p.write_text(s[:b] + proof + s[b + len('  sorry\n'):])
