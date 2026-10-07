#!/usr/bin/env python3
"""FS133-E1 stage 1: check every quotation in a brief (or the claim list) against its source.

A quotation is a run of '> ' lines closed by '> — source: <path>'.  Each quoted line must occur verbatim
(as a substring) in the source file.  Usage: fs133_e1_readback.py <file> [--fault].
Planted-fault control: with --fault the last character of each quoted line is changed, and every quoted
line must then be reported as a mismatch (the script exits 1).  Exit 0 iff no mismatch.
"""
import sys, os
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
args = [a for a in sys.argv[1:] if a != "--fault"]
fault = "--fault" in sys.argv
lines = open(os.path.join(ROOT, args[0]), encoding="utf-8").read().split("\n")
quotes, cur = [], []
for ln in lines:
    if ln.startswith("> — source: "):
        quotes.append((cur, ln[len("> — source: "):].strip())); cur = []
    elif ln.startswith("> "):
        cur.append(ln[2:])
    else:
        cur = []
ok = bad = 0
for q, src in quotes:
    path = src if src.startswith("/") else os.path.join(ROOT, src)
    try:
        text = open(path, encoding="utf-8").read()
    except OSError as e:
        print("MISSING SOURCE", src, e); bad += 1; continue
    for ql in q:
        probe = ql[:-1] + ("#" if ql[-1] != "#" else "@") if fault else ql
        if probe in text:
            ok += 1; print("match   ", os.path.basename(src), "|", ql[:80])
        else:
            bad += 1; print("MISMATCH", os.path.basename(src), "|", ql[:80])
print(f"quotations: {len(quotes)}  lines matched: {ok}  mismatched: {bad}")
sys.exit(1 if bad else 0)
