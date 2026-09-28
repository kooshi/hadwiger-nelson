#!/usr/bin/env python3
"""FS114-Y3 stage 1 (standing rule 5): the quotations of my brief set (`data/fs114/briefs/Y3-114-construction-round3.md`, the cards
`ROUND3-card.md` and `ROUND2-card.md`, FS114-Y's brief `Y114-construction.md`, `STANDING-RULES.md`) and every statement my record quotes, each checked
verbatim against the source it names.

Normalisation, applied to quotation and source alike: typographic quotes to straight ones, backticks, `**` and `*` removed, a line-break hyphen
joined, every whitespace run to one space.  Exit 1 if any quotation is MISSING.

The paper's text is `pdftotext -layout ~/source/library/pdf/arXiv-2502.01958-maptype.pdf` written into MY scratch directory (`scratchpad/fs114-y3/`,
regenerated on every run); no other job's scratch file is read.

--self-test: the first quotation with one word altered must read MISSING while its faithful twin reads FOUND; a faithful quotation checked
against the wrong file must read MISSING (each fires for its own reason: the altered word, the wrong source).
Run: python3 tools/fs114_y3_quotes.py [--self-test]
"""
import pathlib
import re
import subprocess
import sys

R = pathlib.Path('/home/kooshi/source/lean-dir')
SCR = pathlib.Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs114-y3')
SVTXT = str(SCR / 'sv.txt')
CLAIMS = 'data/fs114/claims.md'
C2 = 'data/fs114/briefs/ROUND2-card.md'
C3 = 'data/fs114/briefs/ROUND3-card.md'
Y2 = 'plans/FS114-Y2-construction.md'
CV = 'plans/FS114-CV-verification.md'
D112 = 'plans/FS112-derivation.md'

Q = [
    # FS114-Y's brief (part of mine): Kooshi, and the question
    ("My goal is to fully solve, and then verify in Lean, HN. Then we publish.", 'CLAUDE.md'),
    ("Let's see some ambition. I know we can do it.", 'CLAUDE.md'),
    ("search for a finite graph is out. It would be huge, not feasible.", 'CLAUDE.md'),
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", CLAIMS),
    ("Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if "
     "trichromatic vertices of degree greater than 3 are allowed?", SVTXT),
    # the standing rules' quotations of Kooshi
    ("From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you "
     "will surprise yourself.", 'CLAUDE.md'),
    ("to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", 'CLAUDE.md'),
    ("A proven theorem about why its impossible is also valid. All novel knowledge is a success", 'CLAUDE.md'),
    ("It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.",
     'plans/CONSOLIDATION-2026-09-27.md'),
    # the round-3 card's summaries, checked against the open records they summarise (the fenced proof-side records are not checked)
    ("every valid map has a vertex of at least four colours", CV),
    ("holds the closed disc of radius `3√3/5 ≈ 1.0392` about a degree-4 vertex `p` of four colours", Y2),
    ("the fragment carries about `66.9°` about `q1`", Y2),
    ("I did not derive that the sliver, and so the five colours, are forced in every map with a Reuleaux bowtie at `p`", Y2),
    # the round-3 card itself, the sentences my record works
    ("An extension to radius 2 refutes K1 at its reported radius.", C3),
    ("A stop at a named radius is a local exclusion about a four-colour vertex", C3),
    ("Y2 did not derive that the five colours at `q_i` are forced in every map with a Reuleaux bowtie at `p`: its argument covers the design's "
     "arrangement only.", C3),
    # the statements my record quotes
    ("A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in `Γ`, every "
     "arc of kind both.", CLAIMS),
    ("A four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at it of total length at least 60°, or "
     "at least six, one in each of six consecutive 60° windows (C-UA-BUDGET, branch 1).", CLAIMS),
    ("At a unit arc `α ⊂ ω(P)` of angular length `ℓ`, an inner side colour in `P_cl(P)` has its sectors at `P` in the closed cone of width `π − ℓ` "
     "facing `α`, an outer one in the closed cone facing away; both side cones hold neither", D112),
    ("K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.", C2),
    ("Each tactic edge at p names a four-colour vertex at distance exactly 1 from p, sharing a tile with it.", C2),
    ("(A) a unit arc of ∂x, shared with one member and centred at a point q ∈ F ∪ R where the other member touches x at q alone", C2),
    ("there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at "
     "least four colours.", CLAIMS),
    ("in a non-Siamese map every tile meeting the open unit disc about a vertex `p` is a tile at `p` or has a colour absent at `p`", Y2),
    ("tiles that lie entirely within each other’s annulus of exclusion", CLAIMS),
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
