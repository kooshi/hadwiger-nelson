#!/usr/bin/env python3
"""FS121-V2: check that the brief's three quoted statements are verbatim in the frozen claim list, data/fs121/claims.md § 5.

Usage: python3 tools/fs121_v2_quotes.py [--plant]
--plant alters one character of the brief's first quotation in memory; the check must then report a mismatch (exit 1).
Exit 0 iff every quotation matches character for character."""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

BRIEF = os.path.join(ROOT, "data/fs121/briefs/FS121-V2-verify.md")
CLAIMS = os.path.join(ROOT, "data/fs121/claims.md")
NAMES = ["DB1-L3", "FS121-D1-VT", "FS121-D1-EROSION"]

def grab(text, name, quoted):
    prefix = r"> - " if quoted else r"^- "
    m = re.search(prefix + r"\*\*" + re.escape(name) + r"\*\* \*\(proposed at round 1\)\*: (.*)$", text, re.M)
    return None if m is None else m.group(1)

def main():
    plant = "--plant" in sys.argv
    brief = open(BRIEF, encoding="utf-8").read()
    claims = open(CLAIMS, encoding="utf-8").read()
    if plant:  # drop the prime from the first REG-J′ in the brief's first quotation
        brief = brief.replace("REG-J′, at every point of Σ", "REG-J, at every point of Σ", 1)
    ok = 0
    for n in NAMES:
        b, c = grab(brief, n, True), grab(claims, n, False)
        same = b is not None and c is not None and b == c
        ok += same
        print(f"{n}: brief {'found' if b else 'MISSING'}, list {'found' if c else 'MISSING'}, "
              f"{'verbatim' if same else 'MISMATCH'} ({len(b or '')} / {len(c or '')} chars)")
    print(f"{ok} of {len(NAMES)} verbatim")
    sys.exit(0 if ok == len(NAMES) else 1)

main()
