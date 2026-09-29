#!/usr/bin/env python3
"""FS116-Y2 readback (standing rule 3): every block quotation in the brief, checked verbatim against its source (whitespace and the
brief's '> ' prefixes normalised; nothing else), and the brief's named unquoted attributions checked for presence at their sources.
Self-test (--selftest): an altered word must read MISSING, the faithful twin FOUND, and the faithful quotation against a wrong file MISSING.
Run: python3 tools/fs116_y2_quotes.py [--selftest] [--source FILE]
"""
import os
import re
import sys

os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
BRIEF = "data/fs116/briefs/FS116-Y2-construction.md"
SOURCE = sys.argv[sys.argv.index("--source") + 1] if "--source" in sys.argv else "data/fs116/claims.md"


def norm(s):
    s = re.sub(r"(?m)^\s*>\s?", "", s)
    return re.sub(r"\s+", " ", s).strip()


def quotes(text):
    """the brief's block quotes: consecutive '>' lines, the '— source:' tail dropped"""
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith(">"):
            cur.append(line)
        elif cur:
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


# unquoted attributions in the brief: (the brief's words, a phrase that must be present at the source, the source)
ATTRIB = [
    ("RING-Q fails at small radius ... FS116-N1-QDISK, exact ... holds B̄(A₀, R) for every R < 1.5985",
     "so RING-Q with any radius below `1.5985` in place of \"above 2\" is FALSE", "plans/FS116-N1-proof.md"),
    ("A fragment by formula holding the disk-corner configuration beyond radius 2 makes RING-Q FALSE outright",
     "A fragment by formula holding it on `B̄(p, R)` with `R > 2` makes RING-Q FALSE", "plans/FS116-N1-proof.md"),
    ("the construction side builds at that ring first (plans/FS116-local-exclusion.md § 4.5)",
     "(the construction side builds at that ring first)", "plans/FS116-local-exclusion.md"),
    ("FS116-Y1-STRIPCEIL rules out the strip itself",
     "the strip cannot be saturated along its midline, and cannot decide SAT-STRIP", "plans/FS116-Y1-construction.md"),
    ("Y-SAT's parenthetical cannot hold as written; read ... a geometry differing from the strip inside the unit disc",
     "a positive there needs a geometry that differs from the strip inside the unit disc", "plans/FS116-Y1-construction.md"),
]


def main():
    qs = quotes(open(BRIEF).read())
    ok = True
    for q in qs:
        f = found(q, SOURCE)
        ok &= f
        print(("FOUND   " if f else "MISSING ") + q[:110] + " ... [" + SOURCE + "]")
    aok = True
    for words, phrase, src in ATTRIB:
        f = found(phrase, src)
        aok &= f
        print(("PRESENT " if f else "ABSENT  ") + words[:100] + " <- [" + src + "]")
    print(f"attributions: {len(ATTRIB)}, all present: {aok}")
    print(f"quotations: {len(qs)}, all found: {ok}")
    return 0 if (ok and aok) else 1


def selftest():
    qs = quotes(open(BRIEF).read())
    q = qs[0]
    bad = q.replace("above", "below")
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
