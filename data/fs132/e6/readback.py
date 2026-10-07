#!/usr/bin/env python3
"""FS132-E6 readback: each quotation of the brief (its first line) against its source file.
Prints one line per quotation: the count of exact occurrences (grep -cF semantics, whole file) and the first line number.
With --fault, the first quotation has one character changed; its count must then read 0."""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
Q = [
 ("data/external/EXT-OAI1-request.md", "> […] I'll hand the reins over to you […]. Keep us on track to 6 or 7. I suggest walking the standard workflow at this point once things settle into a clear direction. I'll go with whatever you recommend on the open questions with that in mind. Keep your handoff current in case of auto compaction."),
 ("plans/STUB-six-by-the-nerve.md", "question: what-does-a-seeds-circle-force-in-the-balls-about-its-ring-points"),
 ("plans/STUB-six-by-the-nerve.md", "- **C132-LENS (posed, not derived).** On a six-sector turning seed, if at each of the ring points `y_1` and `y_{−1}` at least two"),
 ("plans/STUB-six-by-the-nerve.md", "- **C132-PLACED (posed).** At the four-label ring point `y` of C132-LENS (ii): in the grammar of C132-PLACE's list, the labels"),
 ("plans/STUB-six-by-the-nerve.md", "- **C132-ARC (posed).** In the setting of C132-COMP-SHARP, with exactly one of the six sets — a set of `x`, with labels `t_0`,"),
 ("plans/FS132-E4-derivation.md", "derivation: C132-PLACE"),
 ("plans/FS132-E4-derivation.md", "derivation: C132-TURN-EDGE"),
 ("plans/FS132-E4-derivation.md", "- **L4 — the six-sector ring `a, b, n, a, b, n`** (`a | b` at `ψ`, `b | n` at `ψ + π/3`, `n | a` at `ψ − π/3`; control"),
 ("plans/FS132-E4-derivation.md", "### Argument — no witness between the two ring labels"),
 ("plans/FS132-E4-derivation.md", "### Where C132-TURN stalls"),
 ("plans/FS132-E5-derivation.md", "derivation: C132-WIT-SIDE"),
 ("plans/SEARCH-2026-10-07.md", "### 1.5 The argument's shape (for the derivers' lane; [hand], one mind — mine — and unchecked)"),
]
fault = "--fault" in sys.argv
bad = 0
for n, (path, text) in enumerate(Q, 1):
    if fault and n == 1:
        text = text.replace("6 or 7", "5 or 7")
    lines = (ROOT / path).read_text(encoding="utf-8").split("\n")
    hits = [i + 1 for i, l in enumerate(lines) if text in l]
    whole = [i for i in hits if lines[i - 1].strip() == text.strip() or lines[i - 1].strip().lstrip("> ").strip() == text.lstrip("> ").strip()]
    print(f"q{n:02d} {path}: occurrences={len(hits)} first-line={hits[0] if hits else '-'} whole-line={'yes' if whole else 'no'}")
    bad += (len(hits) == 0)
print(f"quotations={len(Q)} unmatched={bad}")
