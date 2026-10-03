#!/usr/bin/env python3
"""FS116-S1 readback (standing rule 3): every block quotation in the brief checked verbatim against its source (whitespace, the brief's
'> ' prefixes and backticks normalised; nothing else), the brief's inline quotation checked at its source, and the brief's unquoted
attributions checked for a phrase present at their sources.
Self-test (--selftest): an altered word must read MISSING, the faithful twin FOUND, the faithful quotation against a wrong file MISSING.
Run from anywhere: python3 tools/fs116_s1_quotes.py [--selftest] [--line] [--plant]
--line prints the summary only and exits 0 (the gate's control form); --plant alters one word of the first quotation.
"""
import os
import re
import sys

os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
BRIEF = "data/fs116/briefs/FS116-S1-satstrip.md"
CLAIMS = "data/fs116/claims.md"


def norm(s):
    s = re.sub(r"(?m)^\s*>\s?", "", s)
    s = s.replace("`", "")
    return re.sub(r"\s+", " ", s).strip()


def block_quotes(text):
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


INLINE = [("a geometry differing from the strip inside the unit disc, saturated on B̄(p, 1)", "data/fs116/reports/FS116-Y1.md")]

# (the brief's words, a phrase that must be present at the source, the source)
ATTRIB = [
    ("the proof side ... stalled form ... touch point ... change point fed by a (Q) arc at a named inner germ",
     "The stalled form, for a fresh mind:", "plans/FS116-N1-proof.md"),
    ("... at 2q − p ... (Q) arc on an inner germ",
     "and `X` at `2q − p`, and (2) an axis point that is a change point with a (Q) arc on an inner germ", "plans/FS116-N1-proof.md"),
    ("its advice is a fresh mind on that stalled form, not a fourth push",
     "so no invention job: the provisional drop", "plans/FS116-N1-proof.md"),
    ("the capped strip cannot be saturated at radius 1 (FS116-Y1-STRIPCEIL)",
     "the strip cannot be saturated along its midline, and cannot decide SAT-STRIP", "plans/FS116-Y1-construction.md"),
    ("restated what a positive must carry: AXIS at all four axis points, saturation on all of B̄(p, 1), and ECHO's tiles at radius 2",
     "realises AXIS at all four axis points, and is saturated on the whole of `B̄(p, 1)`", "plans/FS116-Y2-construction.md"),
    ("SATPIN held at two minds, corrected wording",
     "minds: 2 — blind to: SATPIN's first derivation", "plans/FS116-V1-verification.md"),
    ("Crosses whose edges are not at right angles were not worked",
     "Crosses without right angles (eight distinct", "plans/FS116-N1-proof.md"),
]


def main():
    line = "--line" in sys.argv
    qs = block_quotes(open(BRIEF).read())
    if "--plant" in sys.argv:  # the control's planted fault: one word of the first quotation altered
        qs[0] = qs[0].replace("segments", "arcs")
    ok = True
    for q in qs:
        f = found(q, CLAIMS)
        ok &= f
        if not line:
            print(("FOUND   " if f else "MISSING ") + q[:100] + " ... [" + CLAIMS + "]")
    iok = True
    for q, src in INLINE:
        f = found(q, src)
        iok &= f
        if not line:
            print(("FOUND   " if f else "MISSING ") + q[:100] + " [" + src + "]")
    aok = True
    for words, phrase, src in ATTRIB:
        f = found(phrase, src)
        aok &= f
        if not line:
            print(("PRESENT " if f else "ABSENT  ") + words[:90] + " <- [" + src + "]")
    print(f"block quotations {len(qs)} found {ok}; inline {len(INLINE)} found {iok}; attributions {len(ATTRIB)} present {aok}")
    if line:
        return 0
    return 0 if (ok and iok and aok) else 1


def selftest():
    qs = block_quotes(open(BRIEF).read())
    q = qs[0]
    bad = q.replace("segments", "arcs")
    r1, r2, r3 = found(bad, CLAIMS), found(q, CLAIMS), found(q, "plans/STANDING-RULES.md")
    print("altered word:", "FOUND" if r1 else "MISSING")
    print("faithful twin:", "FOUND" if r2 else "MISSING")
    print("wrong file:", "FOUND" if r3 else "MISSING")
    ok = (not r1) and r2 and (not r3)
    print("SELFTEST", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(selftest() if "--selftest" in sys.argv else main())
