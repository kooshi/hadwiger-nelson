#!/usr/bin/env python3
"""FS131-ICT1 readback: every quotation of the brief, character for character, against its source.

A quotation is a run of lines beginning '> ' (or a bare '>') followed by a line '> — source: <path>[ § ...]'. The quoted
text, the '> ' prefix removed, must occur as one contiguous block of whole lines of the source file. Sources are read in
this worktree (ROOT, branch fs131-ktc1) and, for the record of the check, also in the main tree (MAIN). A quotation found
in neither is a MISMATCH. Exits 1 on any mismatch or on zero quotations found.

--plant changes one character of each quotation in memory and requires every one to be reported (the control).
"""
import sys
from pathlib import Path

ROOT = Path("/home/kooshi/source/lean-dir/.claude/worktrees/kel1")
MAIN = Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-ICT1-three-colour.md"


def quotations(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith("> — source: "):
            src = line[len("> — source: "):].split(" § ")[0].strip()
            out.append((src, cur))
            cur = []
        elif line.startswith("> "):
            cur.append(line[2:])
        elif line == ">":
            cur.append("")
        else:
            cur = []
    return out


def found(block, path):
    if not path.exists():
        return False
    lines = path.read_text().splitlines()
    n = len(block)
    return any(lines[i:i + n] == block for i in range(len(lines) - n + 1))


def check(plant):
    qs = quotations(BRIEF.read_text())
    if not qs:
        print("FAIL: no quotation found in the brief")
        return 1
    bad = 0
    for src, q in qs:
        q = list(q)
        if plant:
            k = max(range(len(q)), key=lambda i: len(q[i]))
            s = q[k]
            i = len(s) // 2
            q[k] = s[:i] + ("X" if s[i] != "X" else "Y") + s[i + 1:]
        in_wt, in_main = found(q, ROOT / src), found(q, MAIN / src)
        ok = in_wt or in_main
        bad += not ok
        chars = sum(len(l) + 1 for l in q)
        where = ("worktree+main" if in_wt and in_main else "worktree" if in_wt else "main" if in_main else "neither")
        print(("IDENTICAL " if ok else "MISMATCH  ") + f"{src} ({len(q)} lines, {chars} chars; found in {where}): {q[0][:60]}…")
    print(f"{len(qs)} quotations, {bad} mismatched")
    if plant:
        return 0 if bad == len(qs) else 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(check("--plant" in sys.argv))
