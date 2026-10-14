#!/usr/bin/env python3
"""FS131-ICL1 readback: every quotation of the brief, character for character, against its source.

A quotation is a run of lines beginning '> ' followed by a line '> — source: <path>[ § ...]'. The quoted text (the
'> ' prefix removed, a leading '- ' list marker removed) must occur as one whole line of the source file, read at the
main tree (ROOT). Prints one verdict per quotation; exits 1 on any mismatch or on zero quotations found.

--plant changes one character of each quotation in memory and requires every one to be reported (the control).
"""
import re
import sys
from pathlib import Path

ROOT = Path("/home/kooshi/source/lean-dir")
BRIEF = ROOT / "data/fs131/briefs/FS131-ICL1-count-plane-extension.md"


def quotations(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith("> — source: "):
            src = line[len("> — source: "):].split(" § ")[0].strip()
            out.append((src, "\n".join(cur)))
            cur = []
        elif line.startswith("> "):
            cur.append(line[2:])
        else:
            cur = []
    return out


def check(plant):
    qs = quotations(BRIEF.read_text())
    if not qs:
        print("FAIL: no quotation found in the brief")
        return 1
    bad = 0
    for src, q in qs:
        q = re.sub(r"^- ", "", q)
        if plant:
            i = len(q) // 2
            q = q[:i] + ("X" if q[i] != "X" else "Y") + q[i + 1:]
        lines = (ROOT / src).read_text().splitlines()
        lines = [re.sub(r"^- ", "", l) for l in lines]
        ok = q in lines
        bad += not ok
        print(("IDENTICAL " if ok else "MISMATCH  ") + f"{src}: {q[:70]}…")
    print(f"{len(qs)} quotations, {bad} mismatched")
    if plant:
        return 0 if bad == len(qs) else 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(check("--plant" in sys.argv))
