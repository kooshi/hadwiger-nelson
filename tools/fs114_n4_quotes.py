#!/usr/bin/env python3
"""FS114-N4 quotation check (standing rule 5): the statements my round-3 brief and the two cards quote or restate, verbatim
against their sources where a source is open to me. Whitespace and markdown emphasis (**) collapsed on both sides, nothing else
normalised. Each row is marked VERBATIM (the card or brief claims a quotation) or SUMMARY (the card restates; the check is that
the source's own words, given here, exist at the source, and the record compares the two by hand).
Run: python3 tools/fs114_n4_quotes.py [--plant]   (the plant changes one word of one quotation: it must be NOT FOUND, its
faithful twin FOUND)."""
import re, sys
from pathlib import Path
REPO = Path(__file__).resolve().parent.parent

def norm(s):
    return re.sub(r'\s+', ' ', s.replace('**', ''))

def text(p):
    return norm(Path(p).read_text(encoding='utf-8'))

N = REPO / 'plans/FS114-N-proof.md'
N3 = REPO / 'plans/FS114-N3-proof.md'
D = REPO / 'plans/FS112-derivation.md'
C = REPO / 'data/fs114/claims.md'
CV = REPO / 'plans/FS114-CV-verification.md'
CVB = REPO / 'plans/FS114-CVB-verification.md'
SR = REPO / 'data/fs114/briefs/STANDING-RULES.md'
Q = [
 ('rule 0: Kooshi', REPO / 'CLAUDE.md',
  "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself."),
 ('rule 4: Kooshi', REPO / 'CLAUDE.md', "A proven theorem about why its impossible is also valid. All novel knowledge is a success"),
 ('rule 10: Kooshi', REPO / 'plans/CONSOLIDATION-2026-09-27.md',
  "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."),
 ('rule 3: Kooshi (ban beyond)', REPO / 'CLAUDE.md', "search for a finite graph is out. It would be huge, not feasible."),
 ('card3 CV-EXISTS (VERBATIM, CV)', CV, "every valid map has a vertex of at least four colours"),
 ('card3 CV-EXISTS (VERBATIM, CVB)', CVB, "Every valid map has a vertex of at least four colours, in the map itself"),
 ('card3 CVB two minds', CVB, "with FS114-CV's, **two minds**, blind to each other"),
 ('card3 LOCAL-F source (SUMMARY)', C, "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours"),
 ('card3 THOM-TOP source (SUMMARY)', CVB, "`M − x` is connected at a pinched tile and disconnected at a holed one"),
 ('card3 N3-K1 source (SUMMARY)', N3, "K1: GAP** — not derivable from structure within radius `1 + ε`"),
 ('card3 DR source (SUMMARY)', N3, "a degree-4 vertex with two opposite Reuleaux lenses and all four edges tactic"),
 ('card3 N3-DR0 source (SUMMARY)', N3, "DR's degenerate member (a change point `60°` from a Reuleaux corner, `s′ ∈ {0°, −60°}`) does not exist"),
 ('card3 N3-DR1 source (SUMMARY)', N3, "`t₄` reaches the ring at `y′` or `y″`, and `z_a` reaches `y″` or `z_{−b}` reaches `y′`"),
 ('card3 N3-CONT source (SUMMARY)', N3, "every end of a tactic edge at `p` and every Reuleaux corner carries a non-tactic edge"),
 ('card3 N3-JOINT (VERBATIM)', N3, "`N + U + 3V₆ = V₄`"),
 ('card3 N3-PAY source (SUMMARY)', N3, "A DR vertex takes `½` from the continuation end at each of its four tactic ends"),
 ('card3 K2-loc moot (SUMMARY)', N3, "K2-loc as stated (\"under K1\") is **moot**"),
 ('card3 GAP-mu stands', N3, "GAP-μ stands as stated"),
 ('card3 SIAM-KILL subsumed (SUMMARY)', N3, "the Siamese class needs no count and no separate kill — it needs C114-LOCAL-F's radius"),
 ('card3 SIX source (SUMMARY)', D, "A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in `Γ`, every arc of kind both."),
 ('card3 SIX grade', D, "[hand; two minds, one blind: N; NB]**"),
 ('brief A4SIX', D, "A four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at it of total length at least 60°, or at least six, one in each of six consecutive 60° windows (C-UA-BUDGET, branch 1)."),
 ('brief NB4P', D, "NB-4 corrected: at a vertex of exactly four colours, let `(v, y₀)` be a covering pair at a change point of its ring; if no point of `y₀`'s `σ_v`-orbit lies in the closure of an arc of `Γ` on `ω(v)`, and no arc of `Γ` on `ω(y_{k±1})` has `y_k` in its closure, contradiction; the bound on the colours at `y_k` is not needed."),
 ('brief COR3', D, "In a valid map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint multicolours, `d < 2`) sits on a unit rhombus `u, q₊, u′, q₋` whose other corners are vertices of at least four colours"),
 ('brief K1 at radius 2 (N2-ENDS)', N, "It is negative at exactly one vertex type: a degree-4 vertex with three or four tactic edges."),
 ('card2 K1', N, "K1 *(a claim)*: a vertex of degree 4 in a non-Siamese valid map has at most two tactic edges"),
 ('card2 N2-ENDS partner', N, "so a tactic edge at a vertex `p` names a four-colour vertex at distance exactly 1 from `p` sharing a tile with it"),
 ('card2 tactic edge definition', N, "a tactic edge is an edge of the map (between vertices of degree ≥ 3) that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone"),
 ('card2 LOCAL-F strip bound', C, "By the strip, any such `R` exceeds `√15/4 + √3/2 ≈ 1.834`."),
]
if '--plant' in sys.argv:
    t = Q[19]
    Q = [(t[0] + ' (faithful)', t[1], t[2]), (t[0] + ' (PLANT: 180 -> 120)', t[1], t[2].replace('at least 180°', 'at least 120°'))]
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
