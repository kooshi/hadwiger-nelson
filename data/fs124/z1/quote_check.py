#!/usr/bin/env python3
"""FS124-Z1 readback: every blockquote of the brief against the source it names.

A quotation is the run of lines beginning "> " that precedes a line "> — source: <path> ...".
It passes when its text, with a leading "> " of a nested quote and all runs of whitespace
normalized, is a substring of the source file normalized the same way.
--fault changes one character of every quotation: every one must then fail (exit 1).
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
BRIEF = ROOT / "data/fs124/briefs/FS124-Z1-record.md"
norm = lambda s: re.sub(r"\s+", " ", s).strip()
def quotes(text):
    buf = []
    for line in text.splitlines():
        if line.startswith("> — source:"):
            src = line.split("source:", 1)[1].strip().split(" §")[0].strip()
            yield norm(" ".join(buf)), src
            buf = []
        elif line.startswith(">"):
            buf.append(re.sub(r"^(>\s?)+", "", line))
        else:
            buf = []
fault = "--fault" in sys.argv
ok = bad = 0
for q, src in quotes(BRIEF.read_text()):
    if fault:
        q = q[:len(q)//2] + ("#" if q[len(q)//2] != "#" else "@") + q[len(q)//2+1:]
    body = norm((ROOT / src).read_text())
    body2 = norm(re.sub(r"(?m)^\s*>\s?", "", (ROOT / src).read_text()))
    hit = q in body or q in body2
    ok += hit; bad += (not hit)
    print(("match   " if hit else "MISMATCH"), src, "|", q[:70])
print(f"quotations={ok+bad} match={ok} mismatch={bad}")
sys.exit(1 if bad else 0)
