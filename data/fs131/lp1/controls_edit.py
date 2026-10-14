#!/usr/bin/env python3
"""FS131-LP1: move scripts/axioms-controls.txt's state-reading controls to the library's state after the port (item 807:
imported 38 -> 26; declared imports and library axioms 3 -> 2), by the file's own rule (its header, lines 19-30): per
declared import `declared` and `library` move by one in both controls and `imported` by its records, the `old` digests'
texts follow, and `banner_dropped` loses that import's `FAIL outside-banners <one of its records>` and
`FAIL stale-declaration <the axiom>`.  Run only after `./scripts/axioms.sh --self-test` has been seen red on the old
file.  Every replacement must match exactly once."""
p = "scripts/axioms-controls.txt"
s = open(p).read()
R = [
("""# The `baseline` and `imported_declared` counts, and `banner_dropped`'s consequences, read the library's state: three declared
# imports — `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207; FS-131 wave 10, FS131-L10B's join), with twenty IMPORTED records — eight at that join and twelve of the
# three-colour criterion (`Arith/ThreeColourCriterion`, `Arith/ThreeFourColours`; FS131-LJ1's landing, records and no import) —,
# and `Outside.OAI158.no_proper_five_coloring` and `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158; FS-132,
# FS132-L1's landing), with six and twelve — five each at that landing, one and four more of FS-124's radius clause
# (`Plane/RadiusOutside`; FS124-L1's landing, which brings records and no import), and three more on the transfer of FS-131's
# measurable number (`Plane/LebesgueNumber`; FS131-LC1's landing, records and no import): thirty-eight IMPORTED records.
# (The first import, `falconer_lemma2_nonempty`, is a theorem since FS131-IF1.) A later import, or one's proof, or a later record resting on""",
"""# The `baseline` and `imported_declared` counts, and `banner_dropped`'s consequences, read the library's state: two declared
# imports — `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207; FS-131 wave 10, FS131-L10B's join), with twenty IMPORTED records — eight at that join and twelve of the
# three-colour criterion (`Arith/ThreeColourCriterion`, `Arith/ThreeFourColours`; FS131-LJ1's landing, records and no import) —,
# and `Outside.OAI158.no_proper_five_coloring` (`[OAIMath2026]` family 158; FS-132, FS132-L1's landing), with six — five at that
# landing and one of FS-124's radius clause (`Plane/RadiusOutside`; FS124-L1's landing, which brings records and no import):
# twenty-six IMPORTED records. (The first import, `falconer_lemma2_nonempty`, is a theorem since FS131-IF1; the third,
# `Outside.OAI158.proper_to_borel_weak`, is the release's theorem with its proof ported since FS131-IPD1's switch, and its twelve
# records are CLEAN since the port's landing, FS131-LP1.) A later import, or one's proof, or a later record resting on"""),
("""## control baseline
## expect PASS
## expect COUNT imported=38
## expect COUNT declared=3
## expect COUNT library=3
## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 38 imported""",
"""## control baseline
## expect PASS
## expect COUNT imported=26
## expect COUNT declared=2
## expect COUNT library=2
## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 26 imported"""),
("""## expect COUNT imported=39
## expect COUNT declared=4
## expect COUNT library=4
## arch t3c_import
## digest new 0 match (clean, purchases and imported compared)
## digest off 0 RECORDED COUNT IS STALE
## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 39 imported""",
"""## expect COUNT imported=27
## expect COUNT declared=3
## expect COUNT library=3
## arch t3c_import
## digest new 0 match (clean, purchases and imported compared)
## digest off 0 RECORDED COUNT IS STALE
## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 27 imported"""),
("""## expect FAIL outside-banners seven_le_chromaticNumber_plane_iff
## expect FAIL stale-declaration proper_to_borel_weak
""", ""),
]
for a, b in R:
    assert s.count(a) == 1, a[:60]
    s = s.replace(a, b)
open(p, "w").write(s)
print("edited", len(R), "blocks")
