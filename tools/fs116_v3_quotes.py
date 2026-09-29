#!/usr/bin/env python3
"""FS116-V3: the readback. Compare the five statements quoted in the brief with the frozen claim list's section 11.

Usage (from the repository root or with paths adjusted):
  python3 tools/fs116_v3_quotes.py [--root DIR] [--plant]

Prints one line per statement and a final count "identical: n of 5".
--plant alters one character of the brief's first quotation in memory (a planted fault): the count must drop to 4.
"""
import argparse
import difflib
import os
import sys

NAMES = ["FS116-N1-GERM-R", "FS116-N1-GERM-S", "FS116-N1-TOUCH", "FS116-N1-ECHO", "FS116-N1-AXIS"]


def grab(text, name, prefix):
    for line in text.splitlines():
        s = line.strip()
        if s.startswith(prefix) and (name + "**") in s:
            return s[len(prefix):].strip()
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=".")
    ap.add_argument("--plant", action="store_true")
    a = ap.parse_args()
    brief = open(os.path.join(a.root, "data/fs116/briefs/FS116-V3-verify.md"), encoding="utf-8").read()
    claims = open(os.path.join(a.root, "data/fs116/claims.md"), encoding="utf-8").read()
    if "## 11." not in claims:
        print("claim list has no section 11")
        sys.exit(1)
    sec11 = claims.split("## 11.", 1)[1]
    same = 0
    for i, n in enumerate(NAMES):
        b = grab(brief, n, "> -")
        c = grab(sec11, n, "-")
        if a.plant and i == 0 and b:
            b = b.replace("(150°, 330°)", "(150°, 331°)", 1)
        ok = b is not None and c is not None and b == c
        same += ok
        print(f"{n}: brief {'found' if b else 'MISSING'}, list {'found' if c else 'MISSING'}, "
              f"{'identical' if ok else 'DIFFER'} ({len(b or '')} and {len(c or '')} characters)")
        if b and c and not ok:
            for d in difflib.ndiff([b], [c]):
                if d.startswith("?"):
                    print("   ", d.rstrip()[:200])
    print(f"identical: {same} of {len(NAMES)}")


if __name__ == "__main__":
    main()
