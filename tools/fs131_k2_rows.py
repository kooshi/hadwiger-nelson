#!/usr/bin/env python3
"""FS131-K2: wave 2's rows, quoted verbatim from plans/LEAN-BACKLOG.md into data/fs131/k2/rows-wave2.md.

Each row's block runs from its '### ' heading to the next heading; the 28 formalize rows of wave 2 (the CSV) and the three
rows merged into them. --check re-reads the CSV and the backlog and confirms the committed file is exactly the extraction
(so no quotation drifted); --self-test plants one changed character in a copy and one missing row and watches both fire.

  python3 tools/fs131_k2_rows.py            # write data/fs131/k2/rows-wave2.md
  python3 tools/fs131_k2_rows.py --check    # exit 0 iff the committed file is the verbatim extraction
  python3 tools/fs131_k2_rows.py --self-test
"""
import csv
import sys
from pathlib import Path

import subprocess
# The worktree holds the tool; the table and the extraction live in the main tree (the brief's `touches:`), found as the
# parent of git's common directory.
_common = subprocess.run(["git", "rev-parse", "--path-format=absolute", "--git-common-dir"], capture_output=True, text=True,
                         cwd=Path(__file__).resolve().parent, check=True).stdout.strip()
ROOT = Path(_common).parent
BACKLOG = ROOT / "plans" / "LEAN-BACKLOG.md"
CSV = ROOT / "data" / "fs131" / "k1" / "dispositions.csv"
OUT = ROOT / "data" / "fs131" / "k2" / "rows-wave2.md"


def wave2_ids():
    rows = list(csv.DictReader(CSV.open()))
    form = [r["id"] for r in rows if r["wave"] == "2" and r["disposition"] == "formalize"]
    merged = [r["id"] for r in rows if r["disposition"] == "merged into"
              and any(t in form for t in r["merged_into"].split(";"))]
    return form, merged


def extract(text, ids):
    lines = text.split("\n")
    out = []
    for i in ids:
        idx = [n for n, l in enumerate(lines) if l.startswith("<!--row " + i + " ")]
        if len(idx) != 1:
            raise SystemExit(f"row {i}: {len(idx)} row tags")
        n = idx[0] - 1
        m = n + 1
        while m < len(lines) and not lines[m].startswith("### ") and not lines[m].startswith("## "):
            m += 1
        out.append("\n".join(lines[n:m]))
    return "\n\n".join(out)


def build(text):
    form, merged = wave2_ids()
    if len(form) != 28:
        raise SystemExit(f"expected 28 wave-2 formalize rows, found {len(form)}")
    return extract(text, form + merged)


def main():
    text = BACKLOG.read_text()
    if "--self-test" in sys.argv:
        good = build(text)
        fired = []
        bad = text.replace("the fill move on B(x, η/2)", "the fill move on B(x, η/3)", 1)
        fired.append(("planted character change", build(bad) != good))
        try:
            extract(text.replace("<!--row FS106-REM ", "<!--rowX FS106-REM ", 1), ["FS106-REM"])
            fired.append(("planted missing row tag", False))
        except SystemExit:
            fired.append(("planted missing row tag", True))
        for name, ok in fired:
            print(f"  {name}: {'FIRED' if ok else 'DID NOT FIRE'}")
        sys.exit(0 if all(ok for _, ok in fired) else 1)
    s = build(text)
    if "--check" in sys.argv:
        ok = OUT.read_text() == s
        print("OK: rows-wave2.md is the verbatim extraction" if ok else "MISMATCH: rows-wave2.md drifted from the backlog")
        sys.exit(0 if ok else 1)
    OUT.write_text(s)
    print(f"wrote {OUT.relative_to(ROOT)}: {s.count('<!--row ')} rows")


if __name__ == "__main__":
    main()
