#!/usr/bin/env python3
"""FS106-TS stage 1: check the quotations my brief hands on against their sources.

Each row is (label, quotation, source path). A quotation is split at an ellipsis ("…" or "...");
every piece must occur in the source after deleting all whitespace and joining line-end hyphens.
A miss prints the longest prefix of the piece that does occur, so a garbled symbol is told apart
from a changed word.

  python3 tools/fs106_ts_quotes.py            # the check
  python3 tools/fs106_ts_quotes.py --plant    # the negative control: one quote mutated, one invented;
                                              # both must MISS while the untouched quotes keep their verdicts

Exit status: 0 when every row marked expect=OK reads OK and every row marked expect=MISS reads MISS
(the rows expected to miss are paraphrases the brief put in quotation marks; each is logged in the record).
"""
import re
import sys
from pathlib import Path

HOME = Path.home()
REPO = HOME / "source/lean-dir"
SCRATCH = Path("/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs106-ts")

ROWS = [
    # label, quotation, source, expected verdict
    ("TS-brief: 'send the advisor a short note'", "send the advisor a short note",
     (REPO / "data/fs106/briefs/TS106-structural.md", "*Brief for job"), "MISS"),  # the planner's text, after the re-brief block
    ("re-brief: C-AE-CLOSED gloss", "no almost-everywhere-proper six-colouring of `U₃(0)` with essentially closed classes",
     REPO / "plans/FS106-V-verification.md", "MISS"),
    ("V record: C-AE-CLOSED equivalence", "no a.e.-proper measurable 6-colouring of `U₃(0)` has essentially closed classes",
     REPO / "plans/FS106-V-verification.md", "OK"),
    ("rule 0: Kooshi", "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself.",
     REPO / "CLAUDE.md", "OK"),
    ("rule 4: Kooshi", "A proven theorem about why its impossible is also valid. All novel knowledge is a success",
     REPO / "CLAUDE.md", "OK"),
    ("rule 3: Kooshi (as the rules quote it)", "The intent of the ban is to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time.",
     REPO / "CLAUDE.md", "MISS"),
    ("rule 3: Kooshi (as CLAUDE.md quotes it)", "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time",
     REPO / "CLAUDE.md", "OK"),
    ("C-AE-Q2: S-V Question 2", "Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?",
     SCRATCH / "sv.txt", "OK"),
    ("D-SV Condition 5", "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden.",
     SCRATCH / "sv.txt", "OK"),
    ("D-SV Condition 6", "There are no trichromatic vertices of degree greater than 3.",
     SCRATCH / "sv.txt", "OK"),
    ("SV-L1", "There do not exist two bichromatic points with the same multicolor that are exactly one unit apart.",
     SCRATCH / "sv.txt", "OK"),
    ("SV-1", "If the coloring is proper, Jordan, locally finite, if a vertex with degree greater than 3 cannot be trichromatic, and if arcs of unit curvature are forbidden, then at least 7 colors will be required",
     SCRATCH / "sv.txt", "OK"),
    ("C-T-CHR4's S-V Lemma 2", "Under Condition 5, no point in a valid 6-coloring can have chromaticity k ≥ 4.",
     SCRATCH / "sv.txt", "OK"),
    ("C-T-TAN (advisor wording) against the advisor's record", "the unit relation becomes 'same projection onto e = w₀−u'",
     REPO / "plans/POROS-2026-09-26-fs106-regular-half.md", "MISS"),
    ("V-P2.2", "Then any two trichromatic points u, v for which C(u) ∩ C(v) = ∅ are at a distance",
     SCRATCH / "vor.txt", "OK"),
]


def norm(s: str) -> str:
    s = re.sub(r"-\s*\n\s*", "", s)          # join line-end hyphens
    s = re.sub(r"\s+", "", s)
    return s.replace("’", "'").replace("‘", "'").replace("“", '"').replace("”", '"')


def pieces(q: str):
    return [p for p in re.split(r"…|\.\.\.", q) if norm(p)]


def longest_prefix(piece: str, text: str) -> str:
    p = norm(piece)
    lo, hi = 0, len(p)
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if p[:mid] in text:
            lo = mid
        else:
            hi = mid - 1
    return p[:lo]


def verdict(q: str, src):
    # src is a path, or (path, marker): then only the text after the marker is the source
    # (a file that quotes its own body would otherwise find every quotation in itself).
    if isinstance(src, tuple):
        raw = src[0].read_text(errors="replace")
        raw = raw[raw.index(src[1]):]
    else:
        raw = src.read_text(errors="replace")
    text = norm(raw)
    misses = [pc for pc in pieces(q) if norm(pc) not in text]
    return ("OK" if not misses else "MISS"), misses, text


def main() -> int:
    rows = list(ROWS)
    if "--plant" in sys.argv:
        lab, q, src, _ = rows[3]
        words = q.split()
        i = max(range(len(words)), key=lambda k: len(words[k]))
        words[i] = words[i][::-1]
        rows = [(lab + " [PLANT: mutated]", " ".join(words), src, "MISS"),
                ("[PLANT: invented]", "Six density-open classes always suffice to colour the plane.", REPO / "CLAUDE.md", "MISS"),
                rows[3]]
    bad = 0
    for lab, q, src, want in rows:
        v, misses, text = verdict(q, src)
        flag = "" if v == want else "   <-- UNEXPECTED"
        bad += v != want
        print(f"{v:4} (expect {want:4}) {lab}{flag}")
        for m in misses:
            print(f"       miss piece; longest present prefix: {longest_prefix(m, text)[:80]!r}")
    print(f"rows={len(rows)} unexpected={bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
