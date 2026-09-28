#!/usr/bin/env python3
"""FS114-Y4 stage 1 (standing rule 5): the quotations of my brief set (`data/fs114/briefs/Y4-114-construction-round4.md`, the cards
`ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-Y's brief `Y114-construction.md`, `STANDING-RULES.md`) and every statement my record
quotes, each checked verbatim against the source it names.

Normalisation, applied to quotation and source alike: typographic quotes to straight ones, backticks, `**` and `*` removed, a line-break hyphen
joined, every whitespace run to one space.  Exit 1 if any quotation is MISSING.  The paper's text is `pdftotext -layout` of the held
`[SokolovVoronov2025]` PDF, written into MY scratch directory (`scratchpad/fs114-y4/`, regenerated on every run); no other job's scratch file is read.

--self-test: the first quotation with one word altered must read MISSING while its faithful twin reads FOUND; a faithful quotation checked
against the wrong file must read MISSING (each fires for its own reason).
Run: python3 tools/fs114_y4_quotes.py [--self-test]
"""
import pathlib
import re
import subprocess
import sys

R = pathlib.Path('/home/kooshi/source/lean-dir')
SCR = pathlib.Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs114-y4')
SVTXT = str(SCR / 'sv.txt')
CLAIMS = 'data/fs114/claims.md'
C2 = 'data/fs114/briefs/ROUND2-card.md'
C3 = 'data/fs114/briefs/ROUND3-card.md'
C4 = 'data/fs114/briefs/ROUND4-card.md'
Y3 = 'plans/FS114-Y3-construction.md'
YB2 = 'plans/FS114-YB2-verification.md'
L60 = 'plans/FS114-L60-audit.md'
D112 = 'plans/FS112-derivation.md'

Q = [
    # Kooshi, as quoted in FS114-Y's brief and the standing rules
    ("My goal is to fully solve, and then verify in Lean, HN. Then we publish.", 'CLAUDE.md'),
    ("Let's see some ambition. I know we can do it.", 'CLAUDE.md'),
    ("search for a finite graph is out. It would be huge, not feasible.", 'CLAUDE.md'),
    ("From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you "
     "will surprise yourself.", 'CLAUDE.md'),
    ("A proven theorem about why its impossible is also valid. All novel knowledge is a success", 'CLAUDE.md'),
    ("to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", 'CLAUDE.md'),
    ("It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.",
     'plans/CONSOLIDATION-2026-09-27.md'),
    # the question
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", CLAIMS),
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", SVTXT),
    # K1 as the round-4 card restates it, against the round-2 card
    ("K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges", C4),
    ("K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.", C2),
    # the round-4 card's E1/E2 and RSTOP, against Y3's record (the card's wording is a summary: compared by hand in the record)
    ("E1: T2's sector at q2 lies in [240°, 300°] (colour 2 then passes (ii));", Y3),
    ("E2: some tile at q1 other than t1, T1 and the tiles between t1 and T1 has its whole sector after 60° (its colour passes (i)), and that "
     "colour has no tile at q2 pointing within 90° of 30° (it passes (ii)).", Y3),
    ("with σ_y = (2 4), step 5's E2 escape survives when λ > 60°.", Y3),
    ("Y2's x-action with y ↦ −y acting as (2 4), where E2 survives.", C4),
    ("The class with x ↦ −x acting as (1 3) is empty (YB2-EMPTY13, one mind).", C4),
    ("the (1 3) class holds no non-Siamese fragment with neighbourhoods of top, q1, qC filling U (R-T)", YB2),
    # statements this record rests on
    ("a unit arc with constant sides has ℓ ≤ 60° (its ends lie in the closure of one tile)", L60),
    ("At a unit arc α ⊂ ω(P) of angular length ℓ, an inner side colour in P_cl(P) has its sectors at P in the closed cone of width π − ℓ "
     "facing α, an outer one in the closed cone facing away", D112),
    ("A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in Γ, every "
     "arc of kind both.", CLAIMS),
    ("there are an explicit radius R and a derivation that no valid fragment exists on the closed disc of radius R about a vertex of at least "
     "four colours.", CLAIMS),
    ("tiles that lie entirely within each other’s annulus of exclusion", CLAIMS),
    ("two tiles of one colour, one with an arc of ω(top) from q1, the other with an arc of ω(q1) from top, straddle (1 − 2tt′)", YB2),
]


def norm(s):
    s = s.replace('“', '"').replace('”', '"').replace('‘', "'").replace('’', "'")
    s = s.replace('`', '').replace('**', '').replace('*', '')
    s = re.sub(r'-\s*\n\s*', '-', s)
    return re.sub(r'\s+', ' ', s).strip()


def text(src):
    return norm(pathlib.Path(src).read_text()) if src == SVTXT else norm((R / src).read_text())


def check(q, src):
    return norm(q) in text(src)


def main():
    SCR.mkdir(parents=True, exist_ok=True)
    subprocess.run(['pdftotext', '-layout', str(pathlib.Path.home() / 'source/library/pdf/arXiv-2502.01958-maptype.pdf'), SVTXT], check=True)
    if '--self-test' in sys.argv:
        q, src = Q[0]
        bad = q.replace('fully', 'finally')
        r1, r2, r3 = check(bad, src), check(q, src), check(q, CLAIMS)
        print(f"altered word: {'FOUND' if r1 else 'MISSING'} (want MISSING); faithful twin: {'FOUND' if r2 else 'MISSING'} (want FOUND); "
              f"faithful against the wrong file: {'FOUND' if r3 else 'MISSING'} (want MISSING)")
        ok = (not r1) and r2 and (not r3)
        print('SELF-TEST ' + ('PASS' if ok else 'FAIL'))
        sys.exit(0 if ok else 1)
    missing = 0
    for q, src in Q:
        f = check(q, src)
        missing += not f
        print(f"{'FOUND  ' if f else 'MISSING'} [{pathlib.Path(src).name}] {q[:90]}{'…' if len(q) > 90 else ''}")
    print(f"{len(Q) - missing} of {len(Q)} FOUND")
    sys.exit(1 if missing else 0)


if __name__ == '__main__':
    main()
