#!/usr/bin/env python3
"""FS131-IPD1, the generator's revision (change 2): the regenerated modules differ from their committed text ONLY in the
generated header's title line and its item 1 (the paragraph from the line opening `1. ` through the line holding
`Source lines copied:`).

For each module: the committed text (`git show <rev>:<path>`) and the file on disk are split into lines; outside the
module docstring (`/-!` … the first `-/` after it) the lines must be identical; inside it, the title (the line after
`/-!`) and item 1's paragraph are each replaced by one marker on both sides, and the rest must be identical.

Usage: fs131_ipd1_header_diff.py <rev> <module,module,…>        exit 0 iff every module differs only there
       fs131_ipd1_header_diff.py --control <rev> <module>       plant three changes in a copy of the file on disk and
                                                               require the two outside the header reported and the one
                                                               inside item 1 not; exit 0 iff so
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = "Proofs/HadwigerNelson/Outside"


def masked(text):
    ls = text.split("\n")
    s = ls.index("/-!")
    e = next(i for i in range(s + 1, len(ls)) if ls[i] == "-/")
    i1 = next(i for i in range(s, e) if ls[i].startswith("1. "))
    i2 = next(i for i in range(i1, e) if "Source lines copied:" in ls[i])
    return ls[:s + 1] + ["<TITLE>"] + ls[s + 2:i1] + ["<ITEM 1>"] + ls[i2 + 1:]


def compare(old, new):
    a, b = masked(old), masked(new)
    if a == b:
        return None
    for k, (x, y) in enumerate(zip(a, b)):
        if x != y:
            return f"first difference at masked line {k + 1}: {x[:80]!r} / {y[:80]!r}"
    return f"line counts differ outside the header's title and item 1: {len(a)} / {len(b)}"


def committed(rev, mod):
    return subprocess.run(["git", "-C", str(ROOT), "show", f"{rev}:{OUT}/{mod}.lean"], check=True,
                          capture_output=True, text=True).stdout


def main():
    if sys.argv[1] == "--control":
        rev, mod = sys.argv[2], sys.argv[3]
        old, new = committed(rev, mod), (ROOT / OUT / f"{mod}.lean").read_text()
        ls = new.split("\n")
        s = ls.index("/-!")
        i1 = next(i for i in range(s, len(ls)) if ls[i].startswith("1. "))
        i2 = next(i for i in range(s, len(ls)) if ls[i].startswith("2. "))
        code = next(i for i in range(len(ls) - 1, 0, -1) if ls[i].strip())
        plants = [("a code line changed", code, True), ("item 2 of the header changed", i2, True),
                  ("item 1 changed (the partner: inside what may differ)", i1, False)]
        good = True
        for label, at, must in plants:
            p = list(ls)
            p[at] = p[at] + " planted"
            r = compare(old, "\n".join(p))
            hit = r is not None
            print(f"control '{label}': {'REPORTED' if hit else 'PASSED'} (must be {'REPORTED' if must else 'PASSED'})")
            good = good and hit == must
        print("CONTROL OK" if good else "CONTROL FAILED")
        return 0 if good else 1
    rev, mods = sys.argv[1], sys.argv[2].split(",")
    bad = 0
    for m in mods:
        old, new = committed(rev, m), (ROOT / OUT / f"{m}.lean").read_text()
        r = compare(old, new)
        changed = old != new
        if r is None:
            print(f"OK: {m}: {'only the title and item 1 differ' if changed else 'identical'}")
        else:
            bad += 1
            print(f"DIFFERS: {m}: {r}")
    print(f"HEADER-DIFF {'OK' if not bad else 'FAILED'}: {len(mods) - bad} of {len(mods)} modules")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
