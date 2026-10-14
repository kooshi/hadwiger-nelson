#!/usr/bin/env python3
"""FS131-IKC2: read the axiom print of data/fs131/ikc2/lean/Axioms.lean.

Usage: fs131_ikc2_axioms.py <axioms.txt> [--control]
Exit 0 only if: the planted record reads sorryAx; COUNT is present and equals the number of AX lines; every AX and
PRIVATE line's axioms are a subset of the standard three; native_decide's per-declaration axioms appear nowhere.
--control re-reads the print with the first AX line's axioms replaced by [sorryAx] and must exit 1.
"""
import re, sys
STD = {"propext", "Classical.choice", "Quot.sound"}

def main():
    lines = open(sys.argv[1]).read().splitlines()
    if "--control" in sys.argv:
        for k, l in enumerate(lines):
            if l.startswith("AX "):
                lines[k] = re.sub(r":\s*\[.*\]$", ": [sorryAx]", l); print("CONTROL: planted sorryAx in", l.split()[1]); break
    bad, ax, priv, planted, count = [], 0, 0, None, None
    for l in lines:
        m = re.match(r"(AX|PRIVATE|PLANTED) (\S+) : \[(.*)\]$", l)
        if l.startswith("COUNT "): count = int(l.split()[1]); continue
        if not m: continue
        kind, name, axs = m.group(1), m.group(2), {a.strip() for a in m.group(3).split(",") if a.strip()}
        if kind == "PLANTED": planted = axs; continue
        if kind == "AX": ax += 1
        else: priv += 1
        if not axs <= STD or any("native" in a for a in axs): bad.append((name, sorted(axs)))
    print(f"AX={ax} PRIVATE={priv} COUNT={count} PLANTED={sorted(planted) if planted is not None else None}")
    ok = planted is not None and "sorryAx" in planted and count == ax and ax > 0 and not bad
    for b in bad: print("BAD", b)
    print("PASS" if ok else "FAIL"); sys.exit(0 if ok else 1)

main()
