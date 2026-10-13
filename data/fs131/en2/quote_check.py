#!/usr/bin/env python3
"""FS131-EN2 stage 1: every block quotation in the brief against the file its source line names,
and the claim list's two statements against the asker's record.

A quotation is a line of the brief starting with "> " whose next line is "> — source: <path> ...".
Line 1 of the output: the number of quotations that are NOT a verbatim line of their source (expect 0),
then the number checked.  Line 2: the number of the claim list's two statements that are NOT the asker's
lines with the line breaks joined (expect 0), then 2.
--plant: change one character of each quotation, and of each statement, before comparing (all must miss)."""
import sys, re, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
brief = (root / "data/fs131/briefs/FS131-EN2-two-questions.md").read_text().splitlines()
plant = "--plant" in sys.argv


def bend(q):
    return q[:10] + ("x" if q[10] != "x" else "y") + q[11:] if plant else q


miss = n = 0
for i, line in enumerate(brief[:-1]):
    m = re.match(r"> — source: (\S+)", brief[i + 1])
    if not (line.startswith("> ") and m):
        continue
    src = (root / m.group(1)).read_text().splitlines()
    n += 1
    if bend(line[2:]) not in src:
        miss += 1
print(miss, n)

claims = (root / "data/fs131/claims-EN2.md").read_text().splitlines()
plan = (root / ".claude/worktrees/fs131-wch/plans/FS131-KN3-chain-plan.md").read_text().splitlines()


def joined(a, b):  # the asker's lines a..b (1-based, inclusive), bullets and breaks joined
    text = " ".join(s.strip() for s in plan[a - 1:b])
    return text[2:] if text.startswith("- ") else text


miss2 = 0
for cid, (a, b) in {"EN2-MEAN": (396, 399), "EN2-DECOMP": (400, 402)}.items():
    line = next(s for s in claims if s.startswith(cid + ": "))
    if bend(line[len(cid) + 2:]) != joined(a, b):
        miss2 += 1
print(miss2, 2)
