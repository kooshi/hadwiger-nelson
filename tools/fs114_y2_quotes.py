#!/usr/bin/env python3
"""FS114-Y2 stage 1 (standing rule 5): every quotation of my brief set (`data/fs114/briefs/Y2-114-construction-round2.md`, the card
`data/fs114/briefs/ROUND2-card.md`, FS114-Y's brief `data/fs114/briefs/Y114-construction.md`, `data/fs114/briefs/STANDING-RULES.md`) and
every statement my record quotes, checked verbatim against the source it names.

Normalisation, applied to quotation and source alike: typographic quotes to straight ones, backticks, bold `**` and italic `*` removed,
blockquote markers and table pipes kept (they are text), a line-break hyphen joined, all whitespace runs to one space.  Exit 1 if any
quotation is MISSING.

The paper's text is `pdftotext -layout ~/source/library/pdf/arXiv-2502.01958-maptype.pdf` written into MY scratch directory
(`scratchpad/fs114-y2/sv.txt`; regenerate with that command) -- FS114-Y's copy in its own scratch directory is fenced and not read.

--self-test: the first quotation with one word altered must read MISSING while its faithful twin reads FOUND (the plant fires for its
own reason, the altered word); a faithful quotation checked against the wrong file must read MISSING.
Run: python3 tools/fs114_y2_quotes.py [--self-test]
"""
import pathlib
import re
import sys

R = pathlib.Path('/home/kooshi/source/lean-dir')
SCR = pathlib.Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs114-y2')
SVTXT = str(SCR / 'sv.txt')
CLAIMS = 'data/fs114/claims.md'
CARD = 'data/fs114/briefs/ROUND2-card.md'
YREC = 'plans/FS114-Y-construction.md'
YBREC = 'plans/FS114-YB-verification.md'
CVREC = 'plans/FS114-CV-verification.md'

Q = [
    # --- FS114-Y's brief (part of mine): Kooshi's words, the question ---
    ("My goal is to fully solve, and then verify in Lean, HN. Then we publish.", 'CLAUDE.md'),
    ("Let's see some ambition. I know we can do it.", 'CLAUDE.md'),
    ("search for a finite graph is out. It would be huge, not feasible.", 'CLAUDE.md'),
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", CLAIMS),
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", SVTXT),
    # --- the standing rules' quotations of Kooshi ---
    ("From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you "
     "will surprise yourself.", 'CLAUDE.md'),
    ("to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", 'CLAUDE.md'),
    ("A proven theorem about why its impossible is also valid. All novel knowledge is a success", 'CLAUDE.md'),
    ("It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.",
     'plans/CONSOLIDATION-2026-09-27.md'),
    # --- the card's statements my record works, quoted from the card (their own sources, the proof side's records, are fenced) ---
    ("K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.", CARD),
    ("K2: no such map realises the zero-charge extreme.", CARD),
    ("its non-tactic edges form disjoint closed curves through the four-colour vertices. Every other edge is a unit arc centred at a "
     "four-colour vertex 1 from both its ends. Every tile with an absent colour lies in a Reuleaux triangle of width 1, whose corners have "
     "degree at least 5.", CARD),
    ("Each tactic edge at p names a four-colour vertex at distance exactly 1 from p, sharing a tile with it.", CARD),
    ("The charge is negative at exactly one vertex type: a degree-4 vertex with three or four tactic edges.", CARD),
    ("(A) a unit arc of ∂x, shared with one member and centred at a point q ∈ F ∪ R where the other member touches x at q alone", CARD),
    ("A degree-4 four-colour vertex with three or four tactic edges, in a non-Siamese valid map.", CARD),
    # --- the claim list ---
    ("there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at "
     "least four colours.", CLAIMS),
    ("tiles that lie entirely within each other’s annulus of exclusion", CLAIMS),
    # --- the open records my record quotes ---
    ("every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step", CVREC),
    ("In a valid map, any two close complementary cubic trichromatic partners `u′`, `u″` of a cubic trichromatic vertex `u` have a common "
     "unit point with `u` in common", YREC),
    ("or both meet `cl x` only in finite sets at mutual distance exactly 1", YBREC),
]


def norm(s):
    s = s.replace('“', '"').replace('”', '"').replace('‘', "'").replace('’', "'")
    s = s.replace('`', '').replace('**', '').replace('*', '')
    s = re.sub(r'(?m)^\s*>\s?', '', s)
    s = re.sub(r'-\s*\n\s*', '-', s)
    s = re.sub(r'\s+', ' ', s)
    return s.strip()


def src(path):
    p = pathlib.Path(path)
    if not p.is_absolute():
        p = R / p
    return norm(p.read_text(errors='replace'))


def check(pairs):
    miss = 0
    for q, f in pairs:
        ok = norm(q) in src(f)
        miss += not ok
        print(f"{'FOUND  ' if ok else 'MISSING'} [{pathlib.Path(f).name}] {q[:90]}{'…' if len(q) > 90 else ''}")
    return miss


def main():
    if '--self-test' in sys.argv:
        q0, f0 = Q[0]
        bad = q0.replace('fully', 'partly')
        assert bad != q0
        r1 = norm(bad) in src(f0)
        r2 = norm(q0) in src(f0)
        r3 = norm(q0) in src(CLAIMS)
        print(f"altered word -> {'FOUND' if r1 else 'MISSING'} (want MISSING); faithful twin -> {'FOUND' if r2 else 'MISSING'} (want FOUND); "
              f"faithful against the wrong file -> {'FOUND' if r3 else 'MISSING'} (want MISSING)")
        ok = (not r1) and r2 and (not r3)
        print('SELF-TEST', 'PASS' if ok else 'FAIL')
        sys.exit(0 if ok else 1)
    miss = check(Q)
    print(f"{len(Q) - miss} of {len(Q)} FOUND")
    sys.exit(1 if miss else 0)


if __name__ == '__main__':
    main()
