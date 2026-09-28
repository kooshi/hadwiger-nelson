#!/usr/bin/env python3
"""FS114-N3 quotation check (standing rule 5): the round-2 brief's and card's quoted or restated statements, and the ones this
record relies on, verbatim against their sources. Whitespace and markdown emphasis (**) collapsed on both sides, nothing else
normalised. Run: python3 tools/fs114_n3_quotes.py [--plant]   (the plant changes one word of one quotation: it must be NOT FOUND,
its faithful twin FOUND)."""
import re, sys
from pathlib import Path
REPO = Path(__file__).resolve().parent.parent

def norm(s):
    return re.sub(r'\s+', ' ', s.replace('**', ''))

def text(p):
    return norm(Path(p).read_text(encoding='utf-8'))

N = REPO / 'plans/FS114-N-proof.md'
NB = REPO / 'plans/FS114-NB-verification.md'
D = REPO / 'plans/FS112-derivation.md'
C = REPO / 'data/fs114/claims.md'
CV = REPO / 'plans/FS114-CV-verification.md'
Q = [
 ('rule 0: Kooshi', REPO / 'CLAUDE.md',
  "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter."),
 ('rule 10: Kooshi', REPO / 'plans/CONSOLIDATION-2026-09-27.md',
  "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."),
 ('card K1 (N2-GSD)', N, "K1 — a degree-4 vertex of a non-Siamese valid map has at most two tactic edges (local, radius 2)"),
 ('card K1 (N2-KILL)', N, "K1 *(a claim)*: a vertex of degree 4 in a non-Siamese valid map has at most two tactic edges"),
 ('card K2-loc (N2-GSD)', N, "K2-loc — under K1, the zero-charge extreme is excluded at a uniform radius"),
 ('card GAP-mu (N2-GSD)', N, "GAP-μ — simple is assumed: pockets (two tiles meeting twice) and holes (at most five tiles each, non-Siamese) are not charged by the count"),
 ('card negative charge (N2-ENDS)', N, "It is negative at exactly one vertex type: a degree-4 vertex with three or four tactic edges."),
 ('card N2-ENDS charges', N, "the charge `n` (cubic), `n − 2` (degree 4), `n` (degree 5), `n + 6` (degree 6), plus `2U`, sums to zero."),
 ('card N2-ENDS partner', N, "so a tactic edge at a vertex `p` names a four-colour vertex at distance exactly 1 from `p` sharing a tile with it"),
 ('card N2-DIAM', N, "A tile's inner tactic arcs total at most 180°"),
 ('card extreme shape', N, "they form disjoint closed curves through the four-colour vertices"),
 ('card N2-SLACK', N, "`A = E′ − V₄ + 3V₆ + U` exactly"),
 ('card N2-VCAP', N, "The per-vertex (A) cap `e(q) ≤ d(d − 3)` is attained at degree 4 by the strip's midline vertices"),
 ('card N114-RD', N, "In a valid map every repeat at a tile `x` is (S) a close pair, or (A) a unit arc of `∂x` shared with one member and centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q` alone, or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R` with `|p − q| = 1 = diam x`"),
 ('card NB reading radius', NB, "so RD reads `B̄(j_x, 1 + 1/√3) ≈ B̄(j_x, 1.577)`"),
 ('card N2-SIAM', N, "Route T as a count is blind to Siamese vertices"),
 ('card N2-REFINE', N, "With Siamese pairs there is no density bound."),
 ('tactic edge definition', N, "a tactic edge is an edge of the map (between vertices of degree ≥ 3) that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone (NB-A1: each edge supplies at most one)"),
 ('NB-A1', NB, "In a non-Siamese valid map each edge supplies at most one type-(A) repeat, and a supplying edge is one whole unit arc"),
 ('FS112-NB4P', D, "NB-4 corrected: at a vertex of exactly four colours, let `(v, y₀)` be a covering pair at a change point of its ring; if no point of `y₀`'s `σ_v`-orbit lies in the closure of an arc of `Γ` on `ω(v)`, and no arc of `Γ` on `ω(y_{k±1})` has `y_k` in its closure, contradiction; the bound on the colours at `y_k` is not needed."),
 ('FS112-U1', D, "At a unit arc `α ⊂ ω(P)` of angular length `ℓ`, an inner side colour in `P_cl(P)` has its sectors at `P` in the closed cone of width `π − ℓ` facing `α`, an outer one in the closed cone facing away; both side cones hold neither"),
 ('FS112-A4SIX', D, "A four-colour vertex with no covering pair on its unit circle has on that circle arcs of `Γ` centred at it of total length at least 60°, or at least six, one in each of six consecutive 60° windows"),
 ('FS112-N3-COR3', C, "In a valid map, a close complementary pair of cubic trichromatic vertices `u, u′` (disjoint multicolours, `d < 2`) sits on a unit rhombus `u, q₊, u′, q₋` whose other corners are vertices of at least four colours"),
 ('FS112-SIX', D, "A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in `Γ`, every arc of kind both."),
 ('C114-LOCAL-F', C, "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours"),
 ('CV-EXISTS (owner message)', CV, "every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step"),
 ('GS-D', C, "GS-D — DENSE3's form *(this list)*: no valid map exists (Q-full's NO), attacked with FS112-N3-DENSE3 as a held property of every counterexample."),
]
if '--plant' in sys.argv:
    t = Q[2]
    Q = [(t[0] + ' (faithful)', t[1], t[2]), (t[0] + ' (PLANT: two -> three)', t[1], t[2].replace('at most two', 'at most three'))]
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
