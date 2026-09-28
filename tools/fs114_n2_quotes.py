#!/usr/bin/env python3
"""FS114-N2 quotation check (standing rule 5): the continuation brief's quotations and the new ones in the record's
stage N2-2/N2-3, verbatim against their sources. Whitespace collapsed on both sides, nothing else normalised.
Run: python3 tools/fs114_n2_quotes.py [--plant]   (the plant changes one word of one quotation: must be NOT FOUND,
its faithful twin FOUND)."""
import re, sys
from pathlib import Path
REPO = Path(__file__).resolve().parent.parent
G = Path.home() / 'source/library/hadwiger-nelson-problem-group/threads'
def text(p):
    return re.sub(r'\s+', ' ', Path(p).read_text(encoding='utf-8'))
Q = [
 ('brief: FS114-N closing lines', REPO/'plans/FS114-N-proof.md',
  "the kill — an upper bound on (A) and (B) supply at a degree-4 four-colour vertex (and at degree 5, 6), from FS112-U1's wedges, A4SIX, SIX and tile diameter `≤ 1`; then N114-FIVE's (B) step at five colours (the positive control) before any six-colour claim; C114-REDBLOCK and C114-ENCLOSED3 by derivation; `μ` (pockets) and Siamese (S) repeats in the count. **Stage 3:** discharging at bounded `K` (Mohar Thm 3.1) and the question of an area-normalised charge."),
 ('rule 10: Kooshi', REPO/'plans/CONSOLIDATION-2026-09-27.md',
  "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress."),
 ('FS111-C1-PW', REPO/'data/fs111/claims.md', "Q-NO ⟹ `δ₀(K) > 0` for every `K`."),
 ('FS111-V0 note', REPO/'plans/FS111-V0-verification.md',
  "the converse is weaker — `δ₀(K) > 0 ∀K` does not give Q-NO, which also covers maps with no uniform bound on arcs per disc or on `1/radius`."),
 ('Sirgedas block', G/'Z50mmulkXCQ.txt', 'Define a red "block" as a red tile and its neighbors.'),
 ('Sirgedas pentagon', G/'Z50mmulkXCQ.txt', 'A pentagon in the red metagraph means that the boundaries of the 5 red blocks share a common point. So, exactly 5 tiles meet at this common point, using all 5 non-red colors.'),
 ('Sirgedas quad', G/'Z50mmulkXCQ.txt', 'If only 4 tiles meet at the common point, then we have 4 edges emanating from the common point.'),
 ('Sirgedas planarity', G/'Z50mmulkXCQ.txt', 'No! Proof: connect one diagonal via 2 tiles (tiles are vertices in the image above). The other diagonal can\'t be formed, because the diagonals must cross at a vertex, making two red vertices too close together.'),
 ('Sirgedas distance 3', G/'Z50mmulkXCQ.txt', 'Note that two red tiles must have "tile distance" at least 3.'),
 ('NB pinch', REPO/'plans/FS114-NB-verification.md', 'Fails only at a hole (a boundary component disjoint from the outer one)'),
 ('NB D1', REPO/'plans/FS114-NB-verification.md', 'an absent colour carries at most 3 tiles (pairwise unit contacts)'),
 ('disk C0', REPO/'plans/FS112-Y-construction.md', 'side `A_kA_{k+1}`: unit arc centred `A_{k+3}` (convex)'),
]
if '--plant' in sys.argv:
    t = Q[4]
    Q = [(t[0] + ' (faithful)', t[1], t[2]), (t[0] + ' (PLANT: red -> blue)', t[1], t[2].replace('a red tile', 'a blue tile'))]
bad = 0
for name, src, q in Q:
    ok = re.sub(r'\s+', ' ', q) in text(src)
    print(('FOUND     ' if ok else 'NOT FOUND ') + name)
    if '--plant' in sys.argv:
        bad += (ok != ('PLANT' not in name))
    else:
        bad += not ok
print('RESULT', 'OK' if bad == 0 else f'{bad} unexpected')
sys.exit(1 if bad else 0)
