#!/usr/bin/env python3
"""FS131-I6E: read the output of `lake env lean data/fs131/i6e/I6eAxioms.lean` and count, per section, the records on
the standard three axioms, the records resting on `sorryAx`, and anything else.

Asserts: the CONTROL section shows `sorryAx` (a reader that cannot report a `sorry` has not been watched to fire);
every section headed "expected: the standard three" is all clean; every record printed is counted (an unparsed line,
an error or an unknown constant is a failure). Exit 1 on any failure, exit 2 if nothing was read.

Usage: python3 tools/fs131_i6e_axioms.py <output file> [--plant]
  --plant reads the WIRED section as if it were expected clean: the check must report it and exit 1."""
import re, sys

path = sys.argv[1]
text = open(path).read()
STD = {"propext", "Classical.choice", "Quot.sound"}
sec, out, bad = None, {}, 0
for block in re.split(r"\n(?=(?:===|'|\S+\.lean:))", text):
    block = block.strip()
    if not block:
        continue
    if block.startswith("==="):
        sec = block
        out[sec] = [0, 0]
        continue
    flat = block.replace("\n", " ")
    m = re.match(r"'([^']+)' depends on axioms: \[(.*)\]", flat)
    if not m:
        bad += 1
        print("UNREAD | " + flat[:160])
        continue
    ax = {a.strip() for a in m.group(2).split(",")}
    if "sorryAx" in ax:
        out[sec][1] += 1
    elif ax <= STD:
        out[sec][0] += 1
    else:
        bad += 1
        print("OTHER AXIOM | " + flat[:200])
if not out:
    print("NOTHING READ")
    sys.exit(2)
for k, (c, s) in out.items():
    expect_clean = "expected: the standard three" in k or ("--plant" in sys.argv and "WIRED" in k)
    ok = (s >= 1 and c == 0) if "CONTROL" in k else (s == 0 if expect_clean else True)
    bad += not ok
    print(("ok   " if ok else "FAIL ") + f"| clean {c:3d} | sorryAx {s:3d} | {k}")
print(f"records: {sum(c + s for c, s in out.values())}  failures: {bad}")
sys.exit(1 if bad else 0)
