#!/usr/bin/env python3
"""FS114-N7 quotation check (standing rule 5): the statements my round-6 brief quotes or restates, against their sources where
a source is open to me. Whitespace and markdown emphasis (**) collapsed on both sides, nothing else normalised. Each row is
VERBATIM (a quotation) or SUMMARY (the brief restates; the check is that the source's own words, given here, exist at the
source, and the record compares the two by hand).
Run: python3 tools/fs114_n7_quotes.py [--plant]   (the plant changes one character of one quotation: N2-ENDS's degree-4
charge "(n − 2)" to "(n − 1)"; it must be NOT FOUND, its faithful twin FOUND)."""
import re, sys
from pathlib import Path
REPO = Path(__file__).resolve().parent.parent

def norm(s):
    return re.sub(r'\s+', ' ', s.replace('**', ''))

def text(p):
    return norm(Path(p).read_text(encoding='utf-8'))

N = REPO / 'plans/FS114-N-proof.md'
N3 = REPO / 'plans/FS114-N3-proof.md'
N6 = REPO / 'plans/FS114-N6-proof.md'
NB5 = REPO / 'plans/FS114-NB5-verification.md'
NB6 = REPO / 'plans/FS114-NB6-verification.md'
L60 = REPO / 'plans/FS114-L60-audit.md'
CV = REPO / 'plans/FS114-CV-verification.md'
D112 = REPO / 'plans/FS112-derivation.md'
CL = REPO / 'CLAUDE.md'
Q = [
 ('rule 0: Kooshi (VERBATIM)', CL,
  "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself."),
 ('rule 4: Kooshi (VERBATIM)', CL, "A proven theorem about why its impossible is also valid. All novel knowledge is a success"),
 ('rule 3: Kooshi ban beyond (VERBATIM)', CL, "search for a finite graph is out. It would be huge, not feasible."),
 ('brief K1 (SUMMARY; N2-KILL)', N, "K1 *(a claim)*: a vertex of degree 4 in a non-Siamese valid map has at most two tactic edges (`n(p) ≥ 2`)."),
 ('brief N2-ENDS charges (SUMMARY)', N,
  "With `n(p)` the non-tactic edges at `p`: `Σ_{d=3} n + Σ_{d=4} (n − 2) + Σ_{d=5} n + Σ_{d=6} (n + 6) + 2U = 0`"),
 ('brief N6-NOQ (SUMMARY)', N6, "No pinwheel has a ring free of (Q) arcs"),
 ('brief N6-CENT non-Reuleaux lenses (SUMMARY)', N6, "non-Reuleaux lenses need a (Q) arc"),
 ('brief NB6-QSTART (SUMMARY)', NB6,
  "after N6-P60′ a (Q) arc of `T_{j+2}` from `q_j` (outer tile `z_j`) is admitted by N6-QOUT's zone when `α_{j+1} = 60°`, `α_{j+2} ≤ 120°`: GAP"),
 ('brief NB5-RVKILL (SUMMARY)', NB5, "(R-V) does not exist on `B̄(p, √3)`"),
 ('brief (Q) is FS-112 (VERBATIM, FS112 header)', D112, "(Q) an arc whose centre carries both side colours and at least four colours"),
 ('brief NB6 gloss too wide (SUMMARY)', NB6, "a boundary arc along `ω(p)` whose outer colour is carried at `p`"),
 ('brief CV-EXISTS whole NO (SUMMARY)', CV, "by CV-EXISTS the NO follows from C114-LOCAL-F alone"),
 ('brief L60 equality shape (SUMMARY; L60-EQ)', L60, "at `ℓ = 60°` both side tiles lie in the lens `B̄(A, 1) ∩ B̄(B, 1)`"),
 ('brief N3-JOINT (SUMMARY)', N3, "Route T's count restated: `N + U + 3V₆ = V₄` (non-tactic edges)"),
 ('brief N3-PAY (SUMMARY)', N3, "DR vertices pay: in DR the four continuation ends (N3-CONT) supply `½` each"),
 ('LOCAL-F (VERBATIM, claim list)', REPO / 'data/fs114/claims.md',
  "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours"),
]
PLANT_ROW = 4
if '--plant' in sys.argv:
    t = Q[PLANT_ROW]
    Q = [(t[0] + ' (faithful)', t[1], t[2]),
         (t[0] + ' (PLANT: (n - 2) -> (n - 1))', t[1], t[2].replace('(n − 2)', '(n − 1)'))]
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
