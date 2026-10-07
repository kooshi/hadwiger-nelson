#!/usr/bin/env python3
"""EXT-OAI2 stage 1: check every quotation in the brief against its source.

A quotation is a run of '> ' lines closed by '> — source: <path>'.  Each quoted
line must occur verbatim (as a substring of some line) in the source file.
Planted-fault control: with --fault, one character of each quotation is changed
and the check must then report a mismatch for every quotation.
"""
import sys, os, re
ROOT = "/home/kooshi/source/lean-dir"
BRIEF = os.path.join(ROOT, "data/external/briefs/EXT-OAI2-outside-five-colour-manuscript.md")
fault = "--fault" in sys.argv
lines = open(BRIEF, encoding="utf-8").read().split("\n")
quotes, cur = [], []
for ln in lines:
    if ln.startswith("> — source: "):
        src = ln[len("> — source: "):].strip()
        quotes.append((cur, src)); cur = []
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
        ql2 = ql
        # nested quote marker in the brief ("> > We have ...") is the source's own "> "
        if fault:
            ql2 = ql2[:-1] + ("#" if ql2[-1] != "#" else "@")
        if ql2 in text:
            ok += 1; print("match   ", src.split("/")[-1], "|", ql[:70])
        else:
            bad += 1; print("MISMATCH", src.split("/")[-1], "|", ql[:70])
print(f"quotations: {len(quotes)}  lines matched: {ok}  mismatched: {bad}")
