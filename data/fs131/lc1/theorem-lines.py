#!/usr/bin/env python3
"""FS131-LC1: the record's "Theorems this phase proved, final" lines, printed from the gate's own logs — every
declaration the landing brings (the kernel's list, DECLS) with the banner its record is under and its axioms as the
audit printed them (AXIOMS_LOG).  Usage: theorem-lines.py DECLS AXIOMS_LOG"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import records as r  # noqa: E402

wave, mods, total = r.decls(sys.argv[1])
recs = {n: (ax, sec) for n, ax, sec in r.l1.l10b.records(open(sys.argv[2], encoding="utf-8").read())}
ORDER = ["propext", "Classical.choice", "Quot.sound"]
kind = {"THM": "theorem", "DEF": "definition", "IND": "structure"}
for n in sorted(wave, key=lambda n: (recs[n][1] != "IMPORTED", n)):
    ax, sec = recs[n]
    names = [a for a in ORDER if a in ax] + sorted(a.replace("HadwigerNelson.", "") for a in ax if a not in ORDER)
    print(f"- `{n.replace('HadwigerNelson.', '')}` — {kind[wave[n][0]]}; [kernel]; under {sec}; axioms: "
          f"{'[' + ', '.join(names) + ']' if names else 'none'}")
print(f"({len(wave)} declarations of {total} constants in {len(mods)} module)")
