#!/usr/bin/env python3
"""FS131-KO1 stage 1: the readback of the brief's quotations.

Every quotation in the brief (a run of '> ' lines closed by '> — source: <path>[ § section]') must occur verbatim,
as one substring (its lines joined by newlines), in its source file; and where the source line names a section
(`§ <heading>`), the quotation must lie under a heading of that text.  Read in this branch's tree, where the brief and
its sources are committed (the branch is cut from `main` after the brief's commit).

Usage: fs131_ko1_readback.py [--fault]
--fault changes the last character of every quotation; every item must then mismatch (exit 1).
Exit 0 iff at least one quotation was found and none mismatched.
"""
import os
import sys

TREE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BRIEF = "data/fs131/briefs/FS131-KO1-port-plan.md"
fault = "--fault" in sys.argv


def rd(p):
    return open(os.path.join(TREE, p), encoding="utf-8").read()


def spoil(s):
    return s[:-1] + ("#" if s[-1] != "#" else "@") if fault else s


ok = bad = 0
cur = []
for ln in rd(BRIEF).split("\n"):
    if ln.startswith("> — source: "):
        ref = ln[len("> — source: "):]
        src, _, sec = ref.partition(" § ")
        text = rd(src.strip())
        q = spoil("\n".join(cur))
        pos = text.find(q)
        verdict = "match   " if pos >= 0 else "MISMATCH"
        if pos >= 0 and sec:
            h = text.rfind("\n#", 0, pos)
            heading = text[h + 1:text.index("\n", h + 1)] if h >= 0 else ""
            if heading.lstrip("#").strip() != sec.strip():
                verdict = "MISMATCH"
                print(f"  (the quotation is under '{heading}', not '§ {sec}')")
        if verdict.startswith("match"):
            ok += 1
        else:
            bad += 1
        print(verdict, src.strip(), f"({len(cur)} lines)", "|", cur[0][:70] if cur else "")
        cur = []
    elif ln.startswith("> "):
        cur.append(ln[2:])
print(f"{ok} matched, {bad} mismatched")
sys.exit(0 if ok and not bad else 1)
