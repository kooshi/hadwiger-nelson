#!/usr/bin/env python3
"""FP stage 4: CLAUDE.md (A1-A12 of the drafts table) and WORKFLOW.md 3.2 item 8's one sentence (B1). Old strings asserted once."""
from pathlib import Path

def once(text, old, new, where):
    n = text.count(old)
    assert n == 1, f"{where}: occurs {n} times: {old[:90]!r}"
    return text.replace(old, new)

p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8"); before = len(t.encode())
E = [
 ("A1", "**nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread**",
        "not found in print — `[Johnson2000]` and `[Johnson2006]` pose it as open (`CLOSED-QUESTIONS.md` §1.7)"),
 ("A2", "— and all stop where\nMadore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form (that\nformulation);",
        "— and all but `[Fischer1990]` (Thm 1(i), the coset construction) stop where\nMadore's Prop. 3.9 declines to formulate the general case. **Ours:** Theorem A's general form made metric-free (not found in\nprint; `[Johnson1982]` unread);"),
 ("A3", "The equality is his; the six later posers",
        "The equality is his, restated in two surveys (`[Johnson2000]` p. 176, `[Johnson2006]` p. 214); the six later posers"),
 ("A4", "Theorem A's general form (his congruence family is a proper subfamily",
        "Theorem A's metric-free form and reach (the construction `[Fischer1990]`'s; his congruence family is a proper subfamily"),
 ("A5", "`[Johnson2000]`, `[Johnson2006]` first;", "`[Johnson2000]`, `[Johnson2006]` read, not found;"),
 ("A6", "is **`[Madore2015]` ¶5.4 with ¶1.3, by Tarski** (noted by `[BendaPerles2000]`, unread;",
        "is **`[BendaPerles2000]` pp. 117–118 (1976), by Tarski** (re-derived as `[Madore2015]` ¶5.4 with ¶1.3, whose fn. 5 credits them;"),
 ("A7", "bridge, which is `[Madore2015]` ¶5.4 plus de Bruijn–Erdős]**",
        "bridge, which is `[BendaPerles2000]` pp. 117–118 (Madore's ¶5.4) plus de Bruijn–Erdős]**"),
 ("A8", "three of five items answered at FS-110 (row 134); left: Townsend's (c) in full; `[Townsend2005]`",
        "four of five answered (row 134; `[Townsend2005]` is the manuscript, (c) unargued); left: Townsend's (c) in full"),
 ("A9", "de Bruijn–Erdős finishes ([hand, two minds]: FS103-N's N-EASY, PA1's (E)).",
        "de Bruijn–Erdős finishes ([hand, two minds]: FS103-N's N-EASY, PA1's (E)); its argument is in print (`[GwynStavrianos2022]` Lemma 2, Thm 2,\n"
        "   under an invariant mean; the Haar-average line unprinted, row 130), and choice enters at de Bruijn–Erdős alone (a reading, one mind;\n"
        "   `[ShelahSoifer2003b]` p. 42 names that step)."),
 ("A10a", "W-3's winding transport fails across same-type edges (YB3-SAME) | decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR; NO answers `[SokolovVoronov2025]` Question 2 a.e. for circular-arc maps and closes door (A) |",
        "W-3's winding transport fails across same-type edges (YB3-SAME); posed in print (`[Polymath2021]` p. 199: \"eliminate criterion (ii)\", \"(ii) the unit-radius tactic\"), one exact positive (`[AxenovichEtAl2014]` Thm 4.2's strip), the tactic saving colours in six-fold tilings (`[Parts2021]` p. 182) | decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR; NO answers `[SokolovVoronov2025]` Question 2 and `[Polymath2021]`'s a.e. for circular-arc maps and closes door (A) |"),
 ("A11", "along eroded `[Parts2020c]` tilings and W's families; C-VOID's thin-hole test in the ban |",
        "along eroded `[Parts2020c]` tilings and W's families; C-VOID's thin-hole test in the ban; a second dial, `[Soifer1994X6]`'s X₆ |"),
 ("A12", "— his examples ℚ and ℚ(√3) are the chain's stopping controls.",
        "— his examples ℚ and ℚ(√3) are the chain's stopping controls; the Soifer–Shelah translate graphs (`[SoiferShelah2004g]`) are ambiguous even\n"
        "modulo null sets of edges, their connection set accumulating at 0, where the unit circle's does not (two readers: the consolidation run's LW3, FP)."),
]
for k, a, b in E:
    t = once(t, a, b, k)
p.write_text(t, encoding="utf-8")
print(f"CLAUDE.md {before} -> {len(t.encode())} bytes")

p = Path("WORKFLOW.md"); t = p.read_text(encoding="utf-8")
t = once(t, "it is in neither OpenAlex nor Semantic Scholar and\n      nothing cites it, so **no citation walk can arrive at it**",
    "it is in neither OpenAlex nor Semantic Scholar, and\n      the two surveys that cite it and restate its value (`[Johnson2000]`, `[Johnson2006]`, in the same unindexed journal) are\n"
    "      not in OpenAlex either, so **no database citation walk can arrive at it**", "B1")
p.write_text(t, encoding="utf-8")
print("WORKFLOW applied")
