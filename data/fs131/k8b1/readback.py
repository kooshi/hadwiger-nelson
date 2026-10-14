#!/usr/bin/env python3
"""FS131-K8B1, stage 1 (copied from FS131-KT1's data/fs131/kt1/readback.py, unchanged in logic): check every quotation of the brief against its source, verbatim (standing rule 3).

A quotation is a run of lines beginning with "> " that ends with a line "> — source: <path>[ § …]". Its text (the lines
before the source line, with the "> " stripped) must occur, character for character, in the source file at the root given.

Usage: readback.py <brief> <root> [--plant]
--plant changes one character of the first quotation and must report MISMATCH (the control).
Exit 0 iff every quotation matches (without --plant), or iff the planted one is reported (with --plant).
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


def main():
    brief, root = Path(sys.argv[1]), Path(sys.argv[2])
    plant = "--plant" in sys.argv
    qs = quotations(brief.read_text())
    if not qs:
        print("NO QUOTATIONS FOUND — the reader is broken")
        return 2
    if plant:
        q, s = qs[0]
        qs[0] = (q.replace("formalized", "formalised", 1), s)
    bad = 0
    for i, (q, s) in enumerate(qs, 1):
        src = (root / s).read_text()
        ok = q in src
        bad += not ok
        print(f"[{i}] {'MATCH' if ok else 'MISMATCH'}  {len(q):5d} chars  {s}")
    print(f"quotations={len(qs)} mismatches={bad}")
    if plant:
        return 0 if bad == 1 else 1
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
