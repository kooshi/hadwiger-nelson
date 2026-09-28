#!/usr/bin/env python3
"""FS114-N6 quotation check (standing rule 5): the statements my round-5 brief and the round cards quote or restate, against
their sources where a source is open to me. Whitespace and markdown emphasis (**) collapsed on both sides, nothing else
normalised. Each row is VERBATIM (the brief or card claims a quotation) or SUMMARY (the brief restates; the check is that the
source's own words, given here, exist at the source, and the record compares the two by hand).
Run: python3 tools/fs114_n6_quotes.py [--plant]   (the plant changes one character of one quotation: the pinwheel's cone range
"[60°, 180°]" to "[60°, 120°]" in N5-PIN0; it must be NOT FOUND, its faithful twin FOUND)."""
import re, sys
from pathlib import Path
REPO = Path(__file__).resolve().parent.parent

def norm(s):
    return re.sub(r'\s+', ' ', s.replace('**', ''))

def text(p):
    return norm(Path(p).read_text(encoding='utf-8'))

N = REPO / 'plans/FS114-N-proof.md'
N4 = REPO / 'plans/FS114-N4-proof.md'
N5 = REPO / 'plans/FS114-N5-proof.md'
NB4 = REPO / 'plans/FS114-NB4-verification.md'
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
 ('brief K1 (SUMMARY; N2-KILL)', N, "K1 *(a claim)*: a vertex of degree 4 in a non-Siamese valid map has at most two tactic edges"),
 ('brief N4-BOWTIE two minds (SUMMARY; NB4-G2)', NB4,
  "with it N4-BOWTIE TRUE | [hand, two minds: N4; NB4 blind on the reduction and forced structure, sighted on the kill]"),
 ('brief N5-BENDG (SUMMARY)', N5,
  "a Γ-arc of `ω(p)` survives the bends only if its outer colour is carried at `p`, and then its inner colour is carried at `p` or has R2 support"),
 ('brief N5-PIN0 centres and cones (SUMMARY)', N5,
  "The pinwheel at radius `1 + ε`: centres `q_j = p + e(θ_j + 90°)`, cones `α_j ∈ [60°, 180°]`"),
 ('brief N5-PIN0 no contradiction (SUMMARY)', N5, "No contradiction at this radius"),
 ('brief K1-PIN120 first (SUMMARY; N5 §4.2)', N5,
  "with N5-SIGHT and N4-LENS as the tools and the case `α_j = 120°` first (it is the only one where the up-tile argument applies unchanged)"),
 ('brief N5-SIGHT (SUMMARY)', N5,
  "If `|u − v| = 1` and a tile `T` at `u` has a cone not contained in the closed half-plane facing `v`, then `T`'s colour is carried at `v` by no tile meeting `B(u, 1)`"),
 ('brief N5-UP (SUMMARY)', N5, "Let `T` be a tile at `top` whose cone contains the direction 90° (straight out)."),
 ('brief L60 at most (SUMMARY; L60-LE)', L60, "a unit arc with constant sides has `ℓ ≤ 60°`"),
 ('brief (R-V) GAP (SUMMARY; N5-RV)', N5, "Not excluded: K1-ΓRING is GAP at (R-V)"),
 ('brief row 130 (SUMMARY)', CL, "`χ_CP(ℝ²) = χ_m⁰(ℝ²)` with no MR (row 130)"),
 ('card2 N2-GSD GAP-mu (SUMMARY)', N, "GS-D: GAP** at K1, K2-loc, GAP-μ and the Siamese class"),
 ('card2 tactic edge definition (VERBATIM)', N,
  "a tactic edge is an edge of the map (between vertices of degree ≥ 3) that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone"),
 ('LOCAL-F (VERBATIM, claim list)', C,
  "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours"),
]
PLANT_ROW = 7
if '--plant' in sys.argv:
    t = Q[PLANT_ROW]
    Q = [(t[0] + ' (faithful)', t[1], t[2]),
         (t[0] + ' (PLANT: [60,180] -> [60,120])', t[1], t[2].replace('[60°, 180°]', '[60°, 120°]'))]
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
