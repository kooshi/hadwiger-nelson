#!/usr/bin/env python3
"""FS131-IN1 stage 1: every quotation of the brief against its source, byte for byte.

A quotation is a run of lines beginning '> ' whose last line is '> — source: <path> ...'. The quoted text (the run
without its source line, each line's '> ' removed, joined by newlines) must occur verbatim in the source file, read
from the main checkout (the coordinator's copy: the brief's sources are its files).

--plant: change one token of each quotation in memory ('(mod 12)' -> '(mod 24)', else the first digit) and require
every quotation to MISMATCH; exit 1 if any planted quotation still matches.
Exit 0 only if every quotation matches (or, under --plant, every planted one mismatches).
"""
import re
import sys
from pathlib import Path

MAIN = Path("/home/kooshi/source/lean-dir")
BRIEF = MAIN / "data/fs131/briefs/FS131-IN1-leaves.md"


def quotations(text):
    out, run = [], []
    for line in text.splitlines():
        if line.startswith("> "):
            run.append(line[2:])
        else:
            if run:
                out.append(run)
            run = []
    if run:
        out.append(run)
    res = []
    for run in out:
        m = re.match(r"— source: (\S+)", run[-1])
        if not m:
            print(f"NO SOURCE LINE: {run[0][:60]!r}")
            sys.exit(2)
        res.append(("\n".join(run[:-1]), m.group(1)))
    return res


def plant(q):
    if "(mod 12)" in q:
        return q.replace("(mod 12)", "(mod 24)", 1)
    m = re.search(r"\d", q)
    i = m.start()
    return q[:i] + str((int(q[i]) + 1) % 10) + q[i + 1:]


def main():
    planted = "--plant" in sys.argv
    qs = quotations(BRIEF.read_text())
    if not qs:
        print("NO QUOTATIONS FOUND")
        sys.exit(2)
    bad = 0
    for q, src in qs:
        body = (MAIN / src).read_text()
        probe = plant(q) if planted else q
        hit = probe in body
        label = q[:48].replace("\n", " ")
        if planted:
            verdict = "PLANT MISSED (still matches)" if hit else "plant fires"
            bad += hit
        else:
            verdict = "MATCH" if hit else "MISMATCH"
            bad += not hit
        print(f"{verdict:30s} {src:40s} {len(q):5d} chars  {label!r}")
    print(f"quotations={len(qs)} bad={bad} planted={planted}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
