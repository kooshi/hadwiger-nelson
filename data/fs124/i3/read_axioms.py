#!/usr/bin/env python3
"""FS124-I3 — reads the output of data/fs124/i3/lean/PrintAxioms.lean.

Every `#print axioms` line of the scratch file must have its record in the output (a count, so a record that did not print
is a failure, not a silence); every record outside the controls must hold axioms within
[propext, Classical.choice, Quot.sound]; each of the four controls must hold `sorryAx` (the print tells a proof from a
`sorry`). Exit 0 iff all three hold.
Usage: read_axioms.py <PrintAxioms.lean> <its output>
"""
import re, sys, pathlib

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
CONTROLS = {"FS124I3.control_planted", "FS124I3.control_cites", "HadwigerNelson.Plane.exists_closePair_full",
            "HadwigerNelson.Plane.closePair_both_saved_of_isSector"}


def main():
    src = pathlib.Path(sys.argv[1]).read_text()
    out = re.sub(r"\s*\n\s+", " ", pathlib.Path(sys.argv[2]).read_text())   # a long list wraps: join continuation lines
    asked = re.findall(r"^#print axioms (\S+)", src, flags=re.M)
    recs = {}
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", out):
        recs[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", out):
        recs[m.group(1)] = set()
    bad = 0
    missing = [n for n in asked if n not in recs]
    for n in missing:
        print(f"NO RECORD   {n}"); bad += 1
    clean = free = 0
    for n in asked:
        if n in CONTROLS or n not in recs:
            continue
        ax = recs[n]
        if not ax <= STANDARD:
            print(f"NOT CLEAN   {n}: {sorted(ax - STANDARD)}"); bad += 1
        elif ax:
            clean += 1
        else:
            free += 1
    fired = 0
    for n in sorted(CONTROLS):
        if n not in asked:
            print(f"CONTROL NOT ASKED  {n}"); bad += 1
        elif "sorryAx" in recs.get(n, set()):
            fired += 1
            print(f"control fired: {n} prints sorryAx")
        else:
            print(f"CONTROL SILENT     {n}: {sorted(recs.get(n, set()))}"); bad += 1
    n_real = len([n for n in asked if n not in CONTROLS])
    print(f"asked: {len(asked)} ({n_real} records, {len(CONTROLS)} controls); printed: {len(recs)}")
    print(f"records on a subset of the standard three: {clean} with axioms, {free} axiom-free; controls fired: {fired} of {len(CONTROLS)}")
    print("PASS" if not bad else f"FAIL: {bad}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
