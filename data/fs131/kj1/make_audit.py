#!/usr/bin/env python3
"""FS131-KJ1: the audit block for the landing, made from the final print of data/fs131/kj1/lean/Axioms.lean — one
`#print axioms <name>` line per PUBLIC record of this line's six files (the residue module's three are on main already),
under CLEAN (a subset of the standard three) or IMPORTED (those and StandingFive.kloosterman_bound). Refuses to write if
any record is neither. usage: make_audit.py <print> <out>"""
import re, sys
STD = {"propext", "Classical.choice", "Quot.sound"}
WEIL = "HadwigerNelson.StandingFive.kloosterman_bound"
MODS = ["ThreeColourCharacter", "TorsionExtraction", "ThreeColourCriterion", "DyadicQuadratic", "ThreeFourColours",
        "UpperHalfCorollaries"]
rows = []
for line in open(sys.argv[1]):
    m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", line.rstrip("\n"))
    if m and m.group(1) in MODS and m.group(2) == "public":
        ax = {a.strip() for a in m.group(4).split(",") if a.strip()}
        cls = "CLEAN" if ax <= STD else "IMPORTED" if ax <= STD | {WEIL} else None
        if cls is None:
            sys.exit(f"record {m.group(3)} is neither CLEAN nor IMPORTED: {sorted(ax)}")
        rows.append((m.group(1), cls, m.group(3)))
out = ["-- FS131-KJ1: the three-and-four-colours line — the public records of its six files, from the built tree of branch",
       "-- fs131-wj1 (data/fs131/kj1/logs/axioms-final.txt). CLEAN: the standard three or fewer. IMPORTED: those and",
       "-- HadwigerNelson.StandingFive.kloosterman_bound (Weil's bound, already declared by a declareImport line)."]
for cls in ("CLEAN", "IMPORTED"):
    n = sum(1 for r in rows if r[1] == cls)
    out.append(f"-- {cls} ({n}):")
    for mod in MODS:
        mine = [r[2] for r in rows if r[0] == mod and r[1] == cls]
        if mine:
            out.append(f"-- {mod} ({len(mine)})")
            out += [f"#print axioms {n}" for n in mine]
open(sys.argv[2], "w").write("\n".join(out) + "\n")
print(f"audit block: {sum(1 for r in rows if r[1]=='CLEAN')} CLEAN, {sum(1 for r in rows if r[1]=='IMPORTED')} IMPORTED, {len(rows)} records")
