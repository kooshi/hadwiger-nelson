#!/usr/bin/env python3
"""FS131-IJ1, stage 1 (FS131-ITT1's reader, unchanged in logic): check every quotation of the brief against its source, verbatim (standing rule 3).

A quotation is a run of lines beginning with "> " that ends with a line "> — source: <path>[ § …]". Its text (the lines
before the source line, with the "> " stripped) must occur, character for character, in the source file at the root given.

Usage: fs131_ij1_quotes.py <brief> <root> [--plant]
--plant changes one character of every quotation in turn (its 40th character, to a character absent from its source) and
must report each planted quotation MISMATCH and every other quotation MATCH (the control).
Exit 0 iff every quotation matches (without --plant), or iff every plant is reported and nothing else (with --plant).
"""
import re
import sys
from pathlib import Path


def quotations(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith("> "):
            m = re.match(r"> — source: (\S+)", line)
            if m:
                out.append(("\n".join(cur), m.group(1)))
                cur = []
            else:
                cur.append(line[2:])
        else:
            cur = []
    return out


def check(qs, root):
    res = []
    for q, s in qs:
        src = (root / s).read_text()
        res.append(q in src)
    return res


def main():
    brief, root = Path(sys.argv[1]), Path(sys.argv[2])
    plant = "--plant" in sys.argv
    qs = quotations(brief.read_text())
    if not qs:
        print("NO QUOTATIONS FOUND — the reader is broken")
        return 2
    if not plant:
        res = check(qs, root)
        for i, ((q, s), ok) in enumerate(zip(qs, res), 1):
            print(f"[{i}] {'MATCH' if ok else 'MISMATCH'}  {len(q):5d} chars  {s}")
        bad = res.count(False)
        print(f"quotations={len(qs)} mismatches={bad}")
        return 0 if bad == 0 else 1
    fired = 0
    for j in range(len(qs)):
        q, s = qs[j]
        planted = q[:39] + "§" + q[40:]
        assert planted != q
        qs2 = list(qs)
        qs2[j] = (planted, s)
        res = check(qs2, root)
        ok = (not res[j]) and all(r for i, r in enumerate(res) if i != j)
        fired += ok
        print(f"plant in [{j + 1}]: {'FIRED, the others MATCH' if ok else 'NOT REPORTED AS PLANTED'}")
    print(f"plants={len(qs)} fired={fired}")
    return 0 if fired == len(qs) else 1


if __name__ == "__main__":
    sys.exit(main())
