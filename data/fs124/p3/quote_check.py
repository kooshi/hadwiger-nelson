#!/usr/bin/env python3
"""FS124-P3 stage 1: check every quotation in the brief against its source.

A quotation is a run of lines starting with "> " whose last line is
"> — source: <path> [§ ...]".  Each quoted line (a leading "> " of a nested
quote stripped once more) must occur verbatim, as a substring, in the file
named.  Exit 0 iff every quotation is found.  --fault alters one character of
the first quotation and must exit 1.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
BRIEF = ROOT / "data/fs124/briefs/FS124-P3-round-two.md"


def quotations(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith("> "):
            body = line[2:]
            m = re.match(r"— source: (\S+)", body)
            if m:
                out.append((cur, m.group(1)))
                cur = []
            else:
                cur.append(body[2:] if body.startswith("> ") else body)
        else:
            cur = []
    return out


def main():
    fault = "--fault" in sys.argv
    qs = quotations(BRIEF.read_text())
    bad = 0
    for n, (lines, src) in enumerate(qs, 1):
        path = ROOT / src
        if not path.exists():
            print(f"{n:2d} MISSING SOURCE {src}")
            bad += 1
            continue
        body = path.read_text()
        for line in lines:
            probe = line
            if fault and n == 1:
                probe = line[:10] + "#" + line[11:]
            ok = probe in body
            print(f"{n:2d} {'match   ' if ok else 'MISMATCH'} {src} :: {line[:70]}")
            bad += 0 if ok else 1
    print(f"quotations={len(qs)} mismatches={bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
