#!/usr/bin/env python3
"""X1 stage 5, item 10 (second pass): Amendment 2's rulings on the atlas — B, C, D, E1-E6 — and F9 on plans/STUB-reg-scale.md § Bearing.
(A1 and A2 were applied provisionally before the ruling and stand as ruled.)  Run from anywhere:  python3 data/workflow3/x1/file_atlas2.py
"""
import sys
from common import read, write, once, poros_pairs

P = "tools/viz_proof_atlas_facts.py"
F = poros_pairs()


def main():
    s = read(P)
    R = [
        # B: drop the two "scored" registrations
        ('  words=(GSTUB, "the global step decided (NO or YES) at one mind within FS-114 | 0.2"),\n', ""),
        ('tier=1,\n  registered=dict(p=0.03, src=GSTUB, quote="a YES by formula | 0.03",\n'
         '                  population="within FS-114: a full valid six-map given by formula and checked exactly"))',
         "tier=1)"),
        # C: N3BASE's whole note
        ('  note="Its base — row 134\'s print steps — BASE-V re-derived row 134\'s print steps blind: every step but Lemma 4 at cusps upgraded.")',
         '  note="BASE-V re-derived row 134\'s print steps blind: every step but Lemma 4 at cusps upgraded.")'),
        # D: SRAY's words line
        (',\n  words=(PF(4), "it moves to 2 the day FS-114\'s plan commits to that form"))', ")"),
        # E1: BASEV and R134's stale ring
        ('BASEV = ({"file": "CLAUDE.md", "section": "### Paths forward, ranked"}, "beside BASE-V\'s blind re-derivation of row 134\'s print steps")',
         'BASEV = ({"file": "CLAUDE.md", "section": "### Paths forward, ranked"}, "with BASE-V beside them (row 134\'s base re-derived but for Lemma 4 at cusps)")'),
        ('verifying="its base steps under blind re-derivation (BASE-V)", ', ""),
        # E2: TSMNO's quote and the edge UANO→TSMNO
        ('"At bounded complexity that is whether a tight six-map exists (row 133): under Condition 5 none does (row 134); with unit arcs each would have a "\n'
         '  "vertex of four colours or a repeated colour within 3 of every point"',
         '"At bounded complexity that is whether a tight six-map exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a "\n'
         '  "vertex of at least four colours (rows 135, 137)"'),
        ('E("UANO", "TSMNO", "rests", STANDS, "with unit arcs each would have a vertex of four colours or a repeated colour within 3 of every point")',
         'E("UANO", "TSMNO", "rests", STANDS, "with unit arcs every one has a vertex of at least four colours (rows 135, 137)")'),
        # E3: N3DENSE3's also, G83's new title
        ('also=[({"file": "CLAUDE.md", "grok": "G83"}, "With unit arcs, the tight question lives at four-colour vertices.")],',
         'also=[({"file": "CLAUDE.md", "grok": "G83"}, "With unit arcs, the tight question lives at one four-colour vertex.")],'),
        # E4: HORNEND's also and note
        ('(B("FS112-C-DOUBLE"), "hand; one mind: FS112-C2, a sketch")', '(B("FS112-C-DOUBLE"), "hand; two minds: FS112-C2, a sketch; FS114-CV, blind")'),
        ('(second quote above, one mind, a sketch)', '(second quote above, two minds: FS112-C2, a sketch; FS114-CV, blind)'),
        # E5: the edge BOWTIE→TSMYES, same words, at FS-115's row in plans/FRONTIER-STUBS.md (rank 6)
        ('E("BOWTIE", "TSMYES", "partial", PF(4), "its fragments (the pencil, BOWTIE) are local positives a YES could use",',
         'E("BOWTIE", "TSMYES", "partial", {"file": "plans/FRONTIER-STUBS.md", "row": "6"}, "its fragments (the pencil, BOWTIE) are local positives a YES could use",'),
    ]
    for o, n in R:
        s = once(s, o, n, o[:50])
    # E6: UNB's quote and its edge (two occurrences)
    o6 = '"A family refuting it with holes → 0 is W\'s claim itself: χ(ℝ²) ≤ 6 with no MR."'
    assert s.count(o6) == 2
    s = s.replace(o6, '"A family refuting (B) with holes → 0 is still W\'s claim itself: χ(ℝ²) ≤ 6 with no MR."')
    write(P, s)
    # F9's substitution in plans/STUB-reg-scale.md § Bearing (Amendment 2)
    st = read("plans/STUB-reg-scale.md")
    write("plans/STUB-reg-scale.md", once(st, F["F9"][0][0], F["F9"][0][1], "F9 STUB-reg-scale"))
    print("applied", len(R) + 2, "rulings")


if __name__ == "__main__":
    main()
