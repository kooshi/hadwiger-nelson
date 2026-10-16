"""FS131-KEL1 stage 1: check each block quotation of the brief against its named source, verbatim.

Usage: python3 -I data/fs131/kel1/quote_check.py <brief> <repo-root> [--plant]
Each quotation is a run of '> ' lines ending in '> — source: <path>'. The quoted text (prefix stripped,
lines joined by newline) must occur in the source file as a substring. --plant alters one character of
the first quotation and requires that check to fail (the negative control).
"""
import re, sys, pathlib

brief, root = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
plant = "--plant" in sys.argv
lines = brief.read_text().splitlines()
quotes, cur = [], []
for ln in lines:
    if ln.startswith("> — source: "):
        quotes.append(("\n".join(cur), ln[len("> — source: "):].strip()))
        cur = []
    elif ln.startswith("> "):
        cur.append(ln[2:])
    elif ln == ">":
        cur.append("")
    else:
        cur = []
bad = 0
for i, (text, src) in enumerate(quotes):
    if plant and i == 0:
        text = text[:10] + ("X" if text[10] != "X" else "Y") + text[11:]
    body = (root / src).read_text()
    ok = text in body
    # a markdown table row quoted from a table: the brief strips nothing else
    print(f"{'OK  ' if ok else 'MISS'} #{i+1} {src} ({len(text)} chars)")
    bad += not ok
print(f"{len(quotes)} quotations, {bad} missing")
sys.exit(1 if bad else 0)
