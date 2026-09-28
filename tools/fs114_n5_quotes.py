#!/usr/bin/env python3
"""FS114-N5 quotation check (standing rule 5): the statements my round-4 brief and the round-4 card quote or restate, against
their sources where a source is open to me. Whitespace and markdown emphasis (**) collapsed on both sides, nothing else
normalised. Each row is VERBATIM (the brief or card claims a quotation) or SUMMARY (the card restates; the check is that the
source's own words, given here, exist at the source, and the record compares the two by hand).
Run: python3 tools/fs114_n5_quotes.py [--plant]   (the plant changes one word of one quotation: "at most 60°" to "below 60°"
in the L60 statement; it must be NOT FOUND, its faithful twin FOUND)."""
import re, sys
from pathlib import Path
REPO = Path(__file__).resolve().parent.parent

def norm(s):
    return re.sub(r'\s+', ' ', s.replace('**', ''))

def text(p):
    return norm(Path(p).read_text(encoding='utf-8'))

N = REPO / 'plans/FS114-N-proof.md'
N3 = REPO / 'plans/FS114-N3-proof.md'
N4 = REPO / 'plans/FS114-N4-proof.md'
L60 = REPO / 'plans/FS114-L60-audit.md'
C = REPO / 'data/fs114/claims.md'
CL = REPO / 'CLAUDE.md'
Q = [
 ('rule 0: Kooshi (VERBATIM)', CL,
  "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself."),
 ('rule 4: Kooshi (VERBATIM)', CL, "A proven theorem about why its impossible is also valid. All novel knowledge is a success"),
 ('rule 10: Kooshi (VERBATIM)', REPO / 'plans/CONSOLIDATION-2026-09-27.md',
  "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."),
 ('rule 3: Kooshi ban beyond (VERBATIM)', CL, "search for a finite graph is out. It would be huge, not feasible."),
 ('card4 L60 corrected (SUMMARY; L60-LE)', L60, "a unit arc with constant sides has `ℓ ≤ 60°`"),
 ('card4 L60 at 60 (SUMMARY; proposed statement)', L60,
  "A unit arc with constant sides has angular length at most 60°. At exactly 60° both side tiles lie in the lens `B̄(A, 1) ∩ B̄(B, 1)` of its ends"),
 ('card4 chain intact (SUMMARY)', L60, "FS112-N3-DENSE3 and FS114-CV-EXISTS are intact."),
 ('card4 N4-BOWTIE (SUMMARY)', N4,
  "No valid fragment (non-Siamese, simple class) on the closed disc of radius `√3` about `p` holds a Reuleaux bowtie whose lune rings are free of `Γ`"),
 ('card4 N4-FIVE (SUMMARY)', N4,
  "a corner carries five colours if and only if its lune's ring is degenerate; otherwise it carries exactly four"),
 ('card4 N4 registration p 0.6 (SUMMARY)', N4,
  "the Reuleaux bowtie with a lune ring carrying an arc of `ω(p)` is excluded by the same three moves at radius at most 2* — p = 0.6"),
 ('card4 K1 (SUMMARY; N2-KILL)', N, "K1 *(a claim)*: a vertex of degree 4 in a non-Siamese valid map has at most two tactic edges"),
 ('card4 N4-OWN/LENS/OPP named (SUMMARY)', N4, "N4-OPP | (N4-OWN's general form)"),
 ('brief K1-PIN shapes (SUMMARY; N4 §4.3 row)', N4,
  "`++++` (the pinwheel), `+++−` and `++−−` (the `(2, 1, 1, 0)` patterns), three tactic edges | not walked at radius 2"),
 ('brief three moves (SUMMARY; N4 §5.2)', N4,
  "The method that worked here has three moves, each reading at most `√3`"),
 ('brief LOCAL-F (VERBATIM, claim list)', C,
  "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours"),
 ('card2 N2-ENDS charge (SUMMARY)', N, "It is negative at exactly one vertex type: a degree-4 vertex with three or four tactic edges."),
 ('card3 N3-FLANK source (SUMMARY)', N3,
  "each of the two branches of `ω(p)` leaving `q` lies, near `q`, on `Γ` or in a tile of colour `c₅` or `c₆`"),
 ('card2 tactic edge definition (VERBATIM)', N,
  "a tactic edge is an edge of the map (between vertices of degree ≥ 3) that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone"),
 ('LOCAL-F strip bound (VERBATIM, claim list)', C, "By the strip, any such `R` exceeds `√15/4 + √3/2 ≈ 1.834`."),
]
if '--plant' in sys.argv:
    t = Q[5]
    Q = [(t[0] + ' (faithful)', t[1], t[2]), (t[0] + ' (PLANT: at most -> below)', t[1], t[2].replace('at most 60°', 'below 60°'))]
bad = 0
for name, src, q in Q:
    ok = norm(q) in text(src)
    print(('FOUND     ' if ok else 'NOT FOUND ') + name)
    if '--plant' in sys.argv:
        bad += (ok != ('PLANT' not in name))
    else:
        bad += not ok
print('RESULT', 'OK' if bad == 0 else f'{bad} unexpected')
sys.exit(1 if bad else 0)
