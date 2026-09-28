#!/usr/bin/env python3
"""FS114-CV: quotation check (standing rule 5).

Each row of the TSV is: label <TAB> source path <TAB> region <TAB> quotation.
  region: 'all' (the whole file), 'header' (the text before the file's first line starting with '## '),
          or 'lines:a-b' (1-based, inclusive).
A quotation passes iff, after collapsing every run of whitespace to one space, it is a substring of the region
(also whitespace-collapsed).  Reading only the named region is deliberate: a fenced part of a file is never read.

--self-test runs the faithful file, then a plant (one character of one quotation altered) that must fail for its own row
only; a plant that does not fire, or fires elsewhere, is reported as a DEFECT and the exit status is non-zero.

Run: python3 tools/fs114_cv_quotes.py --file data/fs114/fs114-cv/quotes.tsv [--self-test]
"""
from __future__ import annotations

import re
import sys


def region_text(path: str, region: str) -> str:
    with open(path, encoding="utf-8") as fh:
        lines = fh.read().split("\n")
    if region == "all":
        sel = lines
    elif region == "header":
        sel = []
        for ln in lines:
            if ln.startswith("## "):
                break
            sel.append(ln)
    elif region.startswith("lines:"):
        a, b = region[6:].split("-")
        sel = lines[int(a) - 1:int(b)]
    else:
        raise SystemExit(f"unknown region {region!r}")
    return "\n".join(sel)


def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def load(tsv: str):
    rows = []
    with open(tsv, encoding="utf-8") as fh:
        for ln in fh:
            ln = ln.rstrip("\n")
            if not ln or ln.startswith("#"):
                continue
            label, path, region, quote = ln.split("\t")
            rows.append((label, path, region, quote))
    return rows


def run(rows) -> dict:
    out = {}
    for label, path, region, quote in rows:
        ok = norm(quote) in norm(region_text(path, region))
        out[label] = ok
    return out


def main() -> int:
    args = sys.argv[1:]
    tsv = args[args.index("--file") + 1]
    rows = load(tsv)
    res = run(rows)
    for label, _, region, _ in rows:
        print(f"{'EXACT' if res[label] else 'MISMATCH'}  {label}  [{region}]")
    faithful_ok = all(res.values())
    print(f"faithful run: {'PASS' if faithful_ok else 'FAIL'} ({sum(res.values())}/{len(res)})")
    if "--self-test" not in args:
        return 0 if faithful_ok else 1
    # plant: alter the last character of the first row's quotation
    label0, p0, r0, q0 = rows[0]
    planted = [(label0, p0, r0, q0[:-1] + ("X" if q0[-1] != "X" else "Y"))] + rows[1:]
    pres = run(planted)
    fired = [lb for lb, ok in pres.items() if not ok]
    if fired == [label0]:
        print(f"plant 'alter_last_char' on {label0}: FIRES for its own row only")
        return 0 if faithful_ok else 1
    print(f"plant 'alter_last_char' on {label0}: DEFECT (rows failing: {fired})")
    return 2


if __name__ == "__main__":
    sys.exit(main())
