#!/usr/bin/env python3
"""FS137-E1: append a stage's text to the record, filling each {{expect:NAME}} with the saved output data/fs137/e1/out/NAME.txt
in the gate's form (first line after 'expect: ', the others indented), and checking the previous stage's SAVED line is last."""
import sys, re, os
HERE = os.path.dirname(os.path.abspath(__file__)); REC = os.path.join(HERE, "..", "..", "..", "plans", "FS137-E1-derivation.md")
prev, src = sys.argv[1], sys.argv[2]
s = open(REC).read(); add = open(src).read()
assert s.rstrip().endswith(prev), "the record does not end at " + prev
def fill(m):
    lines = open(os.path.join(HERE, "out", m.group(1) + ".txt")).read().rstrip("\n").split("\n")
    return "expect: " + lines[0] + "".join("\n    " + l for l in lines[1:])
add = re.sub(r"\{\{expect:([\w.]+)\}\}", fill, add)
open(REC, "w").write(s.rstrip() + "\n" + add)
