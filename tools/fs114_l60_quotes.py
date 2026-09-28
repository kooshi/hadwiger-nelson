#!/usr/bin/env python3
"""FS114-L60 quotation check (standing rule 5): every statement the brief FS114-L60 quotes, checked against its source.

Normalisation, applied to both sides and to nothing else: whitespace runs collapsed to one space; markdown emphasis
('**', '*') and code ticks ('`') removed. A row with a line number is also checked AT that line (the brief cites the line).
Rows marked GLOSS are the brief's own words about a source (not in quotation marks there); for those the tool checks that
the source's own words, given here, exist, and the record compares the two by hand.

Run:  python3 tools/fs114_l60_quotes.py            (faithful: every row FOUND, exit 0)
      python3 tools/fs114_l60_quotes.py --plant    (one word of the L60 quotation changed, "below" -> "at most": that row must
                                                    be NOT FOUND and its faithful twin FOUND; exit 0 only if both happen)
"""
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent


def norm(s: str) -> str:
    s = s.replace('**', '').replace('*', '').replace('`', '')
    return re.sub(r'\s+', ' ', s).strip()


def found(path: Path, quote: str, line: int | None):
    raw = path.read_text(encoding='utf-8')
    whole = norm(raw) .find(norm(quote)) >= 0
    at_line = None
    if line is not None:
        lines = raw.split('\n')
        at_line = norm(quote) in norm(lines[line - 1]) if 0 < line <= len(lines) else False
    return whole, at_line


D = REPO / 'plans/FS112-derivation.md'
N = REPO / 'plans/FS112-N-proof.md'
N4 = REPO / 'plans/FS114-N4-proof.md'
CV = REPO / 'plans/FS114-CV-verification.md'
CVB = REPO / 'plans/FS114-CVB-verification.md'
CL = REPO / 'CLAUDE.md'
CONS = REPO / 'plans/CONSOLIDATION-2026-09-27.md'

L60_Q = ("FS112-L60 — A unit arc with constant sides has angular length below 60°; along it neither side colour recurs 60° apart. "
         "[hand; two minds, one blind: N; NB; tools exact]")

ROWS = [
    # (id, kind, path, quote, line)
    ('B1 derivation l. 66', 'VERBATIM', D, L60_Q, 66),
    ('B2 rests-on', 'VERBATIM', D, "Rests on it: FS112-N2-RED, FS112-N3-COR3.", 68),
    ('B3 DIAM_OVER token', 'VERBATIM', N, "DIAM_OVER", 376),
    ('B3 10201/10000 token', 'VERBATIM', N, "10201/10000", 376),
    ('B3 DIAM_OVER (10201/10000) as printed', 'VERBATIM', N, "DIAM_OVER (10201/10000)", 376),
    ('B4 N112-P2', 'VERBATIM', N, "(four arcs, each < 60°)", 284),
    ('B5 N4-L60 correction (owner note, gloss)', 'GLOSS', N4,
     "at most 60°, with equality only when the outer tile lies in B̄(A, 1) ∩ B̄(B, 1) (the Reuleaux cap)", 369),
    ('B5 N4-L60 row "Corrected:"', 'GLOSS', N4,
     "Corrected: ℓ ≤ 60°, with equality only when the outer tile lies in B̄(A, 1) ∩ B̄(B, 1), i.e. in the Reuleaux cap.", 190),
    ('B6 CV-EXISTS (brief gloss)', 'GLOSS', CV, "every valid map has a vertex of at least four colours", 22),
    ('B6 CV-EXISTS two minds (brief gloss)', 'GLOSS', CVB, "Two minds, both blind to each other", 284),
    ('R0 Kooshi (standing rule 0)', 'VERBATIM', CL,
     "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, "
     "and you will surprise yourself.", None),
    ('R3 Kooshi (standing rule 3)', 'VERBATIM', CL,
     "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", None),
    ('R3 Kooshi finite graph', 'VERBATIM', CL, "search for a finite graph is out. It would be huge, not feasible.", None),
    ('R4 Kooshi', 'VERBATIM', CL, "A proven theorem about why its impossible is also valid. All novel knowledge is a success", None),
    ('R10 Kooshi', 'VERBATIM', CONS,
     "It's ok if jobs overrun a bit. Setting a budget is reasonable, but holding them to it is not worth the stress.", None),
]


def run(plant: bool) -> int:
    rows = list(ROWS)
    if plant:
        rows.append(('PLANT B1 "below" -> "at most"', 'PLANT', D, L60_Q.replace('below 60°', 'at most 60°'), 66))
    bad = 0
    for rid, kind, path, q, line in rows:
        whole, at_line = found(path, q, line)
        at = '' if line is None else (f' at l. {line}: {"yes" if at_line else "NO"}')
        verdict = 'FOUND' if whole else 'NOT FOUND'
        print(f'{rid:48s} {kind:8s} {verdict:9s}{at}   [{path.relative_to(REPO)}]')
        if kind == 'PLANT':
            if whole:
                print('  PLANT DID NOT FIRE: the mutated quotation was found')
                bad += 1
        else:
            if not whole or (line is not None and not at_line):
                bad += 1
    if plant:
        twin = found(D, L60_Q, 66)
        print(f'faithful twin of the plant: {"FOUND" if twin[0] and twin[1] else "NOT FOUND"}')
        if not (twin[0] and twin[1]):
            bad += 1
    print('RESULT:', 'PASS' if bad == 0 else f'FAIL ({bad})')
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(run('--plant' in sys.argv[1:]))
