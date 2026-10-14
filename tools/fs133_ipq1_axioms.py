#!/usr/bin/env python3
"""FS133-IPQ1 — FS133-ICD1's reader, unchanged but for this line. Read a `#print axioms` output (FS133-IA1's reader as FS133-IB2 copied it, extended here by the OPEN kinds) and set each record against what it must print.

  fs133_ia1_axioms.py <print.out> <expect.tsv> [--control]

`expect.tsv`: one line per declaration, `<full name>\\t<CLEAN|IMPORTED>`.  CLEAN: the printed axioms are a subset of the
standard three.  IMPORTED: the standard three (a subset) and the declared outside theorem
`HadwigerNelson.Outside.OAI158.Spectral.residual_fourier`, which must be there.  Any other axiom (`sorryAx` first) fails;
a declaration of the table with no record in the print fails; a record of the print that the table does not hold fails.
`--control` plants four faults in a copy of the print (a `sorryAx` in a CLEAN record; the import in a CLEAN record; the
import missing from an IMPORTED record, when the table has one; a record removed) and requires each reported.
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}
IMPORT = "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier"


def parse(text):
    """-> {name: set of axioms}.  A record may be wrapped over several lines."""
    out = {}
    flat = re.sub(r"\n\s+", " ", text)
    for m in re.finditer(r"'([^']+)' depends on axioms: \[([^\]]*)\]", flat):
        out[m.group(1)] = {a.strip() for a in m.group(2).split(",") if a.strip()}
    for m in re.finditer(r"'([^']+)' does not depend on any axioms", flat):
        out[m.group(1)] = set()
    return out


def judge(records, expect):
    bad = []
    for name, want in expect.items():
        if name not in records:
            bad.append(f"NO RECORD   {name}")
            continue
        ax = set(records[name])
        if want.startswith("OPEN-"):
            if "sorryAx" not in ax:
                bad.append(f"NOT OPEN    {name}: listed as an outstanding leaf, prints no sorryAx")
            ax.discard("sorryAx")
            # an outstanding leaf cannot print the import its proof will read: only the CLEAN side is judged
            want = "CLEAN" if want == "OPEN-CLEAN" else "OPEN"
        other = ax - STD - {IMPORT}
        if other:
            bad.append(f"OTHER AXIOM {name}: {sorted(other)}")
        if want == "CLEAN" and IMPORT in ax:
            bad.append(f"IMPORT      {name}: a record that must be clean prints the declared outside theorem")
        if want == "IMPORTED" and IMPORT not in ax:
            bad.append(f"NO IMPORT   {name}: a record that must rest on the declared outside theorem does not print it")
    for name in records:
        if name not in expect:
            bad.append(f"UNLISTED    {name}: in the print, not in the table")
    return bad


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    text = open(args[0], encoding="utf-8").read()
    expect = {}
    for ln in open(args[1], encoding="utf-8").read().splitlines():
        if ln.strip() and not ln.startswith("#"):
            n, w = ln.split("\t")
            assert w in ("CLEAN", "IMPORTED", "OPEN-CLEAN", "OPEN-IMPORTED"), ln
            expect[n] = w
    records = parse(text)
    if not records or not expect:
        print("FAIL: an empty print or an empty table — nothing was read")
        return 2
    if control:
        clean = sorted(n for n, w in expect.items() if w == "CLEAN" and n in records)
        imported = sorted(n for n, w in expect.items() if w == "IMPORTED" and n in records)
        plants = []
        r = {k: set(v) for k, v in records.items()}; r[clean[0]].add("sorryAx"); plants.append(("sorryAx in a clean record", r))
        r = {k: set(v) for k, v in records.items()}; r[clean[-1]].add(IMPORT); plants.append(("the import in a clean record", r))
        if imported:
            r = {k: set(v) for k, v in records.items()}; r[imported[0]].discard(IMPORT); plants.append(("the import missing from an imported record", r))
        r = {k: set(v) for k, v in records.items()}; del r[clean[0]]; plants.append(("a record removed", r))
        ok = True
        for label, r in plants:
            b = judge(r, expect)
            print(f"plant '{label}': {'REPORTED' if b else 'SILENT'}" + (f" ({b[0]})" if b else ""))
            ok = ok and bool(b)
        b = judge(records, expect)
        print(f"unplanted: {'PASS' if not b else 'FAIL'}")
        print("CONTROL OK" if ok and not b else "CONTROL FAILED")
        return 0 if ok and not b else 1
    bad = judge(records, expect)
    nc = sum(1 for n, w in expect.items() if w == "CLEAN")
    ni = sum(1 for n, w in expect.items() if w == "IMPORTED")
    sets = {}
    for n in expect:
        if n in records:
            key = "[" + ", ".join(sorted(records[n], key=lambda a: (a not in STD, a))) + "]"
            sets[key] = sets.get(key, 0) + 1
    print(f"records: {len(records)}  table: {len(expect)} ({nc} CLEAN, {ni} IMPORTED)")
    for k, v in sorted(sets.items()):
        print(f"  {v:3d}  {k}")
    for b in bad:
        print(b)
    print("AXIOMS OK" if not bad else f"AXIOMS FAILED: {len(bad)}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
