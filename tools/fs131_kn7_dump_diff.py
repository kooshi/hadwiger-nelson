#!/usr/bin/env python3
"""FS131-KN7 (Amendment 1): compare two prints of data/fs131/kn7/lean/ModuleDump.lean (every constant of a module, kind,
name, stored type with every argument shown, a definition's value).

usage: fs131_kn7_dump_diff.py <before log> <after log> [--plant]
Prints ADDED / REMOVED / CHANGED / SAME per constant; for a CHANGED one, the shortest differing middle of the two texts
(common prefix and suffix cut). Exit 0 when the before log has at least one constant and the comparison ran; the verdict is
in the lines. --plant changes one character of the after-print of every constant in memory: every constant present in
both must then read CHANGED (the negative control: a comparison that cannot see a change says SAME)."""
import re, sys
def read(path):
    out = {}
    for line in open(path):
        m = re.search(r"DUMP (axiom|theorem|def|opaque|inductive|ctor|rec|quot) (\S+) : (.*)$", line.rstrip("\n"))
        if m:
            out[m.group(2)] = (m.group(1), m.group(3))
    return out
a, b = read(sys.argv[1]), read(sys.argv[2])
if not a:
    print("FAIL: no constant in", sys.argv[1]); sys.exit(1)
if "--plant" in sys.argv:
    b = {k: (v[0], v[1][:-1] + ("#" if v[1][-1:] != "#" else "!")) for k, v in b.items()}
counts = {"ADDED": 0, "REMOVED": 0, "CHANGED": 0, "SAME": 0}
for n in sorted(set(a) | set(b)):
    if n not in a:
        counts["ADDED"] += 1; print(f"ADDED   {b[n][0]} {n}")
    elif n not in b:
        counts["REMOVED"] += 1; print(f"REMOVED {a[n][0]} {n}")
    elif a[n] == b[n]:
        counts["SAME"] += 1; print(f"SAME    {a[n][0]} {n}")
    else:
        counts["CHANGED"] += 1
        x, y = a[n][1], b[n][1]
        i = 0
        while i < min(len(x), len(y)) and x[i] == y[i]: i += 1
        j = 0
        while j < min(len(x), len(y)) - i and x[-1 - j] == y[-1 - j]: j += 1
        print(f"CHANGED {a[n][0]} {n}\n  common prefix {i} chars, common suffix {j} chars\n  before: …{x[i:len(x)-j]}…\n  after:  …{y[i:len(y)-j]}…")
print(" ".join(f"{k}={v}" for k, v in counts.items()))
