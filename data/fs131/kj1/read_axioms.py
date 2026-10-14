#!/usr/bin/env python3
"""FS131-KJ1: read the print of data/fs131/kj1/lean/Axioms.lean and class every record.

  CLEAN     its axioms are a subset of [propext, Classical.choice, Quot.sound]
  WEIL      those and HadwigerNelson.StandingFive.kloosterman_bound (the declared outside theorem), at least that one
  SORRY     sorryAx among them
  OTHER     anything else (fails)

usage: read_axioms.py <print> [--expect-sorry <file>]   the file lists, one per line, the PUBLIC records expected to print
       sorryAx ('#' comments and blank lines skipped; an absent or empty file means none is expected).
Fails (exit 1) if: a record is OTHER; the set of SORRY records (public and private) differs from the expected list in either
direction; the three planted records are not read as planted (planted_sorry SORRY, planted_weil WEIL, planted_clean CLEAN)
— the control that the reader can see a `sorry` and the import at all; a module's AXIOMS-COUNT line is missing or
disagrees with the rows read. Prints one line per module and per class, the WEIL and SORRY records by name."""
import re, sys
STD = {"propext", "Classical.choice", "Quot.sound"}
WEIL = "HadwigerNelson.StandingFive.kloosterman_bound"
path = sys.argv[1]
expect = set()
if "--expect-sorry" in sys.argv:
    f = sys.argv[sys.argv.index("--expect-sorry") + 1]
    try:
        expect = {l.strip() for l in open(f) if l.strip() and not l.startswith("#")}
    except FileNotFoundError:
        expect = set()
rows, counts, src = [], {}, {}
for line in open(path):
    m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", line.rstrip("\n"))
    if m:
        ax = {a.strip() for a in m.group(4).split(",") if a.strip()}
        rows.append((m.group(1), m.group(2), m.group(3), ax)); continue
    m = re.match(r"AXIOMS-COUNT (\S+) (\d+)$", line.strip())
    if m:
        counts[m.group(1)] = int(m.group(2)); continue
    m = re.match(r"SORRY-FROM (\S+) : \[(.*)\]$", line.rstrip("\n"))
    if m:
        src[m.group(1)] = m.group(2)
def cls(ax):
    if "sorryAx" in ax: return "SORRY"
    if ax <= STD: return "CLEAN"
    if ax <= STD | {WEIL}: return "WEIL"
    return "OTHER"
bad = 0
mods = []
for r in rows:
    if r[0] not in mods: mods.append(r[0])
for mod in mods:
    mine = [r for r in rows if r[0] == mod]
    if counts.get(mod) != len(mine):
        print(f"FAIL {mod}: AXIOMS-COUNT {counts.get(mod)} but {len(mine)} rows read"); bad += 1
    by = {}
    for _, kind, name, ax in mine:
        by.setdefault(cls(ax), []).append((kind, name))
    pub = sum(1 for r in mine if r[1] == "public")
    print(f"{mod}: {len(mine)} records ({pub} public) — " + ", ".join(f"{k} {len(v)}" for k, v in sorted(by.items())))
    for k in ("WEIL", "SORRY", "OTHER"):
        for kind, name in by.get(k, []):
            extra = f"   from {src.get(name, '?')}" if k == "SORRY" else ""
            print(f"    {k} {kind} {name}{extra}")
    if "OTHER" in by and mod != "PLANTED":
        bad += 1
planted = {r[2].split(".")[-1]: cls(r[3]) for r in rows if r[0] == "PLANTED"}
want = {"planted_sorry": "SORRY", "planted_weil": "WEIL", "planted_clean": "CLEAN"}
if planted != want:
    print(f"FAIL control: planted records read as {planted}, wanted {want}"); bad += 1
else:
    print("CONTROL: 3 of 3 planted records read as planted (a sorry shows as SORRY, the import as WEIL)")
got = {r[2] for r in rows if r[0] != "PLANTED" and cls(r[3]) == "SORRY"}
if got != expect:
    for n in sorted(got - expect): print(f"FAIL unexpected sorryAx: {n}")
    for n in sorted(expect - got): print(f"FAIL listed as expecting sorryAx and prints none: {n}")
    bad += 1
else:
    print(f"SORRY records: {len(got)}, equal to the expected list ({len(expect)})")
print("PASS" if not bad else f"FAIL ({bad})")
sys.exit(1 if bad else 0)
