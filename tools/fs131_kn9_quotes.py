#!/usr/bin/env python3
"""FS131-KN9: check every block quotation of a brief against its source, verbatim.

A quotation is a run of lines beginning with "> " that ends in a line "> — source: <path>[ § …]".
Its text (the lines before the source line, the "> " prefix removed, joined by newlines) must be a
substring of the source file read from the repository root given. Nested markdown in the quote is
compared as written.

Usage: fs131_kn9_quotes.py <brief> <repo-root> [--plant]
  --plant  changes one character of the first quotation and requires that check to FAIL.
Exit 0 iff every quotation is found (or, under --plant, iff the planted one is reported missing).
"""
import re
import sys
from pathlib import Path


def quotes(brief: str):
    lines = brief.splitlines()
    cur = []
    for ln in lines:
        if ln.startswith("> — source: "):
            src = ln[len("> — source: "):].strip()
            path = src.split(" § ")[0].strip()
            yield "\n".join(cur), path
            cur = []
        elif ln.startswith("> "):
            cur.append(ln[2:])
        elif ln.strip() == ">":
            cur.append("")
        else:
            cur = []


def main():
    brief = Path(sys.argv[1]).read_text()
    root = Path(sys.argv[2])
    plant = "--plant" in sys.argv
    found = list(quotes(brief))
    if not found:
        print("FAIL: no quotation parsed from the brief")
        return 1
    bad = 0
    for i, (text, path) in enumerate(found):
        if plant and i == 0:
            text = text[:20] + ("X" if text[20] != "X" else "Y") + text[21:]
        src = (root / path).read_text()
        ok = text in src
        # paragraph-level fallback: a quote spanning several source lines joined as one
        print(f"{'OK  ' if ok else 'MISS'} [{i}] {path}  ({len(text)} chars) {text[:70]!r}")
        if not ok:
            bad += 1
    print(f"{len(found)} quotations, {bad} missing")
    if plant:
        return 0 if bad == 1 else 1
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
