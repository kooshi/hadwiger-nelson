#!/usr/bin/env python3
"""FS116-Y1 readback: every block quotation in the brief, checked verbatim against its source (whitespace and the brief's '> ' prefixes
normalised; nothing else).  Self-test: an altered word must read MISSING, the faithful twin FOUND, and the faithful quotation against a wrong
file MISSING.
Run: python3 tools/fs116_y1_quotes.py [--selftest] [--source FILE]
"""
import os
import re
import sys

os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
BRIEF = "data/fs116/briefs/FS116-Y1-construction.md"
SOURCE = sys.argv[sys.argv.index("--source") + 1] if "--source" in sys.argv else "data/fs116/claims.md"


def norm(s):
    s = re.sub(r"(?m)^\s*>\s?", "", s)
    return re.sub(r"\s+", " ", s).strip()


def quotes(text):
    """the brief's block quotes: consecutive '>' lines up to the '— source:' line"""
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith(">"):
            cur.append(line)
        else:
            if cur:
                out.append("\n".join(cur))
                cur = []
    if cur:
        out.append("\n".join(cur))
    res = []
    for q in out:
        q = norm(q)
        q = re.sub(r"^- ", "", q)
        q = q.split(" — source:")[0].strip()
        res.append(q)
    return res


def found(q, path):
    return norm(q) in norm(open(path).read())


def main():
    txt = open(BRIEF).read()
    qs = quotes(txt)
    ok = True
    for q in qs:
        f = found(q, SOURCE)
        ok &= f
        print(("FOUND   " if f else "MISSING ") + q[:110] + " ... [" + SOURCE + "]")
    # the brief's other verbatim items: its hand-back sentence and the stages
    print(f"quotations: {len(qs)}, all found: {ok}")
    return 0 if ok else 1


def selftest():
    qs = quotes(open(BRIEF).read())
    q = qs[0]
    bad = q.replace("largest", "smallest")
    r1 = found(bad, "data/fs116/claims.md")
    r2 = found(q, "data/fs116/claims.md")
    r3 = found(q, "plans/STANDING-RULES.md")
    print("altered word:", "FOUND" if r1 else "MISSING")
    print("faithful twin:", "FOUND" if r2 else "MISSING")
    print("wrong file:", "FOUND" if r3 else "MISSING")
    ok = (not r1) and r2 and (not r3)
    print("SELFTEST", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(selftest() if "--selftest" in sys.argv else main())
