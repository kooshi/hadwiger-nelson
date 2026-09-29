#!/usr/bin/env python3
"""FS121-O1: check that every quotation in a TSV (source<TAB>quote) occurs verbatim in its source.

Whitespace is normalised (runs of spaces/newlines, and markdown line-wrap indentation, collapse to one space) because
records wrap lines; nothing else is. Exit 0 iff every quote is found. --plant corrupts the first quote by one
character and expects the checker to report it missing (exit 0 iff the plant fires)."""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
def norm(s): return re.sub(r'\s+', ' ', s).strip()
def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    plant = '--plant' in sys.argv
    rows = [l.rstrip('\n').split('\t', 1) for l in open(args[0], encoding='utf-8') if l.strip() and not l.startswith('#')]
    if plant: rows[0][1] = rows[0][1][:-1] + ('Z' if rows[0][1][-1] != 'Z' else 'Y')
    miss = 0
    for i, (src, q) in enumerate(rows):
        text = norm((ROOT / src).read_text(encoding='utf-8'))
        ok = norm(q) in text
        miss += not ok
        print(f"{'ok  ' if ok else 'MISS'} {i+1:2d} {src}: {q[:70]}")
    print(f"quotes: {len(rows)}  found: {len(rows)-miss}  missing: {miss}")
    if plant:
        print('PLANT FIRED' if miss else 'PLANT DID NOT FIRE'); sys.exit(0 if miss else 1)
    sys.exit(1 if miss else 0)
main()
