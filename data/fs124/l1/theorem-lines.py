#!/usr/bin/env python3
"""FS124-L1: the record's final list, printed from the gate's own logs — one line per declaration the landing brings,
with the banner its record is under and its axioms as the audit printed them.

Usage (from the worktree's root): data/fs124/l1/theorem-lines.py DECLS AXIOMS_LOG
Reads the kernel's list (`data/fs124/l1/decls.lean`'s output) and the audit's saved log through
`tools/fs124_l1_records.py`'s readers; prints Markdown.  Exit 1 if a declaration has no single record.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3] / "tools"))
import fs124_l1_records as r  # noqa: E402

P = "HadwigerNelson.Plane."
STD = "[propext, Classical.choice, Quot.sound]"


def main(argv):
    wave, mods, total = r.decls(argv[0])
    recs = r.l1.l10b.records(open(argv[1], encoding="utf-8").read())
    by = {}
    for n, ax, sec in recs:
        by.setdefault(n, []).append((ax, sec))
    bad = 0
    for mod in ("WeakColouringOn", "Radius", "RadiusOutside"):
        full = "Proofs.HadwigerNelson.Plane." + mod
        names = sorted(n for n, (k, m) in wave.items() if m == full)
        print(f"\n**`Plane/{mod}`** ({len(names)} declarations):\n")
        for n in names:
            got = by.get(n, [])
            if len(got) != 1:
                print(f"- `{n}` — NO SINGLE RECORD ({len(got)})")
                bad += 1
                continue
            ax, sec = got[0]
            extra = sorted(a for a in ax if a not in r.STD)
            kind = {"THM": "theorem", "DEF": "definition", "IND": "structure"}[wave[n][0]]
            if ax == r.STD:
                axs = STD
            elif not extra:
                axs = "[" + ", ".join(a for a in ("propext", "Classical.choice", "Quot.sound") if a in ax) + "]"
            else:
                axs = STD + " and `" + "`, `".join(extra) + "`"
            print(f"- `{n.replace(P, '')}` — {kind}; [kernel]; under {sec}; axioms: {axs}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
