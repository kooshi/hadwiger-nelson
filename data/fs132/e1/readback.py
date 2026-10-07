#!/usr/bin/env python3
"""FS132-E1 readback: every quotation in the brief (a run of '> ' lines closed by '> — source: <path>')
is looked for verbatim, line by line, in its source. --fault changes one character of each quoted line first."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs132/briefs/FS132-E1-opening-and-first-claim.md").read_text().splitlines()
fault = "--fault" in sys.argv
quotes, cur = [], []
for ln in brief:
    if ln.startswith("> — source: "):
        quotes.append((ln[len("> — source: "):].strip(), cur)); cur = []
    elif ln.startswith("> "):
        cur.append(ln[2:])
    elif ln.strip() == ">":
        cur.append("")
    else:
        cur = []
ok = bad = 0
for src, lines in quotes:
    text = (root / src).read_text()
    for q in lines:
        q = q.lstrip("> ").strip() if q.startswith(">") else q.strip()
        if not q:
            continue
        if fault:
            q = q[:5] + ("#" if q[5:6] != "#" else "!") + q[6:]
        if q in text:
            ok += 1
        else:
            bad += 1
            print(f"MISMATCH [{src}]: {q[:110]}")
print(f"quotations={len(quotes)} lines_matched={ok} lines_mismatched={bad}")
sys.exit(1 if bad else 0)
