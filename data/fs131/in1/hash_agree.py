#!/usr/bin/env python3
"""FS131-IN1 — two compact dumps (compact_dump.py) agree on Lean's own hash of every stored type.

`Expr.hash` does not read binder names, so it is the comparison that survives a print made at another path (where an
anonymous instance binder's stored name differs).  Every constant of the first dump that is in the second must carry
the same hash on its TYPE line (and, for a definition, on its VALUE line unless --types-only).
Usage: hash_agree.py <a.txt> <b.txt> [--types-only] [--control]
--control changes one hash of the second dump in memory and must report exactly one disagreement; exit 0 only then.
"""
import sys, pathlib
def rd(p):
    d, cur = {}, None
    for ln in pathlib.Path(p).read_text().splitlines():
        if ln.startswith("@@ "): cur = " ".join(x for x in ln.split(" ")[2:] if x != "INTERNAL"); d[cur] = {}
        elif ln.startswith("TYPE ") and cur: d[cur]["T"] = ln.split(" ")[1]
        elif ln.startswith("VALUE ") and cur: d[cur]["V"] = ln.split(" ")[1]
    if not d: print(f"EMPTY: {p}"); sys.exit(2)
    return d
args = [a for a in sys.argv[1:] if not a.startswith("--")]
a, b = rd(args[0]), rd(args[1])
keys = ("T",) if "--types-only" in sys.argv else ("T", "V")
if "--control" in sys.argv:
    n = sorted(k for k in b if k in a)[0]; b[n]["T"] = str(int(b[n]["T"]) + 1)
both = [n for n in a if n in b]
bad = [(n, k) for n in both for k in keys if a[n].get(k) != b[n].get(k)]
print(f"constants in both dumps: {len(both)} (of {len(a)} and {len(b)}); hash disagreements: {len(bad)}")
for n, k in bad: print(f"  DISAGREE {k} {n}")
if "--control" in sys.argv:
    ok = len(bad) == 1; print("CONTROL: " + ("the check can fail" if ok else "DID NOT FIRE AS PLANTED")); sys.exit(0 if ok else 1)
if not both: print("NOTHING COMPARED"); sys.exit(2)
print("PASS" if not bad else "FAIL"); sys.exit(1 if bad else 0)
