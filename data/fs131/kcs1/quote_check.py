#!/usr/bin/env python3
"""FS131-KCS1 stage 1: check every blockquote of the brief against its named source.

Each blockquote ends with a line '> — source: <path>[ § ...]'. The quoted text (the '> ' prefix removed,
whitespace collapsed) must occur in the source file (whitespace collapsed). A planted control (one word
changed in the first quote) must be reported MISMATCH.
"""
import re, sys, pathlib

ROOT = pathlib.Path(sys.argv[1])
BRIEF = pathlib.Path(sys.argv[2])
plant = len(sys.argv) > 3 and sys.argv[3] == "--plant"

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

lines = BRIEF.read_text().splitlines()
quotes, cur = [], []
for ln in lines:
    if ln.startswith(">"):
        cur.append(ln[1:].lstrip(" ") if not ln.startswith("> ") else ln[2:])
    else:
        if cur:
            quotes.append(cur); cur = []
if cur:
    quotes.append(cur)

fails = 0
for i, q in enumerate(quotes):
    src_line = [l for l in q if l.startswith("— source:")]
    body = [l for l in q if not l.startswith("— source:")]
    if not src_line:
        print(f"quote {i}: NO SOURCE LINE"); fails += 1; continue
    src = src_line[0][len("— source:"):].strip()
    path = src.split(" § ")[0].split(" ")[0].strip()
    text = norm("\n".join(body))
    if plant and i == 0:
        text = text.replace("formalized", "formalised", 1)
    full = norm((ROOT / path).read_text())
    ok = text in full
    if not ok:
        # find the longest prefix that matches, to locate the divergence
        lo, hi = 0, len(text)
        while lo < hi:
            mid = (lo + hi + 1) // 2
            if text[:mid] in full: lo = mid
            else: hi = mid - 1
        print(f"quote {i} ({path}): MISMATCH after {lo} of {len(text)} chars: ...{text[max(0,lo-60):lo]}|{text[lo:lo+80]}...")
        fails += 1
    else:
        print(f"quote {i} ({path}): VERBATIM ({len(text)} chars)")
print(f"{len(quotes)} quotes, {fails} mismatches")
sys.exit(1 if fails else 0)
