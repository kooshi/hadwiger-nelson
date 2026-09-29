#!/usr/bin/env python3
"""FS121-V4 readback: check each statement the brief quotes against the frozen claim list, verbatim up to whitespace.

Usage: python3 tools/fs121_v4_quotes.py BRIEF CLAIMS [--plant]
--plant flips one character in the first extracted quotation; the check must then report a mismatch (exit 1).
"""
import re, sys

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

def brief_quotes(text):
    # each quoted block: consecutive lines beginning with "> " and not "> — source"
    blocks, cur = [], []
    for line in text.splitlines():
        if line.startswith(">"):
            body = line[1:].lstrip()
            if body.startswith("— source"):
                if cur:
                    blocks.append(" ".join(cur)); cur = []
                continue
            cur.append(body)
        else:
            if cur:
                blocks.append(" ".join(cur)); cur = []
    if cur:
        blocks.append(" ".join(cur))
    return [norm(re.sub(r"^- ", "", b)) for b in blocks]

def main():
    brief = open(sys.argv[1]).read()
    claims = norm(open(sys.argv[2]).read())
    qs = brief_quotes(brief)
    if "--plant" in sys.argv:
        qs[0] = qs[0].replace("if and only if", "if and only iff", 1)
    bad = 0
    for q in qs:
        name = re.match(r"\*\*(\S+)\*\*", q)
        ok = q in claims
        print(("ok   " if ok else "MISS ") + (name.group(1) if name else q[:40]) + f"  ({len(q)} chars)")
        bad += not ok
    print(f"quotations: {len(qs)}  verbatim: {len(qs)-bad}")
    sys.exit(1 if bad else 0)

main()
