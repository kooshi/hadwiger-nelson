#!/usr/bin/env python3
"""FS114-Y5 stage 1 (standing rule 5): the quotations of my brief set (`data/fs114/briefs/Y5-114-construction-round5.md`, the cards
`ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`, FS114-Y's brief `Y114-construction.md`, `STANDING-RULES.md`) and every statement my record
quotes, each checked verbatim against the source it names.

Normalisation, applied to quotation and source alike: typographic quotes to straight ones, backticks, `**` and `*` removed, a line-break hyphen
joined, every whitespace run to one space.  Exit 1 if any quotation is MISSING.  The paper's text is `pdftotext -layout` of the held
`[SokolovVoronov2025]` PDF, written into MY scratch directory (`scratchpad/fs114-y5/`, regenerated on every run); no other job's scratch file is read.

--self-test: the first quotation with one word altered must read MISSING while its faithful twin reads FOUND; a faithful quotation checked
against the wrong file must read MISSING (each fires for its own reason).
Run: python3 tools/fs114_y5_quotes.py [--self-test]
"""
import pathlib
import re
import subprocess
import sys

R = pathlib.Path('/home/kooshi/source/lean-dir')
SCR = pathlib.Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs114-y5')
SVTXT = str(SCR / 'sv.txt')
CLAIMS = 'data/fs114/claims.md'
C2 = 'data/fs114/briefs/ROUND2-card.md'
C3 = 'data/fs114/briefs/ROUND3-card.md'
C4 = 'data/fs114/briefs/ROUND4-card.md'
Y2 = 'plans/FS114-Y2-construction.md'
Y3 = 'plans/FS114-Y3-construction.md'
Y4 = 'plans/FS114-Y4-construction.md'
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
    # K1, as my brief and the round-4 card state it, against the round-2 card
    ("K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges", C4),
    ("K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.", C2),
    ("K1-PIN: the pinwheel (each tile inner for one edge), the (2, 1, 1, 0) patterns, and three tactic edges in general. None walked yet.", C4),
    # the definition of a tactic edge the card works (repeat (A) of N114-RD) and the tactic-edge sentence
    ("(A) a unit arc of ∂x, shared with one member and centred at a point q ∈ F ∪ R where the other member touches x at q alone", C2),
    ("Each tactic edge at p names a four-colour vertex at distance exactly 1 from p, sharing a tile with it.", C2),
    # statements this record rests on
    ("At a unit arc α ⊂ ω(P) of angular length ℓ, an inner side colour in P_cl(P) has its sectors at P in the closed cone of width π − ℓ "
     "facing α, an outer one in the closed cone facing away", D112),
    ("a unit arc with constant sides has ℓ ≤ 60° (its ends lie in the closure of one tile)", L60),
    ("at the centre q of a tactic edge e from p whose arc subtends β at q, the inner tile lies at q in the cone [d + β − 90°, d + 90°] and the "
     "tile T of the outer colour in [d + 90° + β, d + 270°]", Y2),
    ("in a non-Siamese map every tile meeting the open unit disc about a vertex p is a tile at p or has a colour absent at p", Y2),
    ("If |u − v| = 1, a tile at u with a direction ψ at u with cos(ψ − arg(v − u)) > 0 has points within < 1 of v, hence of every tile at v: in "
     "a non-Siamese map its colour is absent at v unless it is that tile", Y4),
    ("N-E1 (ω(u) meets no open tile of a colour of P_cl(u))", Y3),
    ("No non-Siamese simple valid fragment holding a Reuleaux bowtie at p contains neighbourhoods of the closed unit disc about p and of r", Y4),
    ("A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in Γ, every "
     "arc of kind both.", CLAIMS),
    ("there are an explicit radius R and a derivation that no valid fragment exists on the closed disc of radius R about a vertex of at least "
     "four colours.", CLAIMS),
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
