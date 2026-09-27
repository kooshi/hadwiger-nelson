#!/usr/bin/env python3
"""FP stage 2: BIBLIOGRAPHY.md outside § G (E1-E3, E5, E7-E9). Each old string asserted to occur once, and every edit asserted to fall
outside § G (the lines between '## G.' and '## D.'), which this job may not edit."""
from pathlib import Path

p = Path("BIBLIOGRAPHY.md"); t = p.read_text(encoding="utf-8")
g0, g1 = t.index("\n## G. The Geombinatorics archive walk"), t.index("\n## D. Standing rules for this file")

def once(text, old, new, where):
    global g0, g1
    n = text.count(old)
    assert n == 1, f"{where}: occurs {n} times: {old[:90]!r}"
    i = text.index(old)
    assert not (g0 < i < g1), f"{where}: inside § G"
    out = text.replace(old, new)
    g0, g1 = out.index("\n## G. The Geombinatorics archive walk"), out.index("\n## D. Standing rules for this file")
    return out

G = " (the issue; § G)"
# E5 [Soifer2019]
t = once(t, "*Chromatic problems and prizes*, Geombinatorics XXVIII(4) (2019) 206–210 |",
    "*Chromatic problems and prizes*, Geombinatorics XXVIII(4) (April 2019), printed on pp. 210–214 (its own header reads \"206–210\") |", "Soifer2019 work")
t = once(t, "(listing only) | not held | posing read through `[Soifer2024]` ch. 55 (read in full); the paper unread — a debt, Kooshi's call to obtain |",
    "(listing only) | `library/geombinatorics/geombinatorics-v28-n4-2019-04.pdf`" + G + " | **read in full** (2026-09-27, the consolidation run's LW; "
    "p. 213 checked by FP): *\"CNP – Triangle-Free. Construct a triangle-free 5-chromatic unit-distance graph.\"* and *\"The Ronald L. Graham "
    "New $1,000 Problem. Prove or disprove the existence of a 6-chromatic unit-distance graph.\"* (the second recorded in FS-104's stub) |", "Soifer2019 cells")
# E5 [Polymath2021]
t = once(t, "| not held (Geombinatorics; the journal's archive or a loan — add to § R) | **not read — known through `[Soifer2024]` ch. 54 and the zbMATH summary** |",
    "| `library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf`" + G + " | **read in full** (2026-09-27, the consolidation run's LW; a second "
    "reading by LW2, which corrected five page numbers): p. 199 poses FS-112's question (`CLOSED-QUESTIONS.md` §3; `LEDGER.md` row 134) |", "Polymath2021")
# E5 [Mundinger2024]
i = t.index("| **[Mundinger2024]** |"); j = t.index("\n", i); row = t[i:j]
assert row.endswith("| not held | **abstract** |"), row[-60:]
t = t[:i] + row[:-len("| not held | **abstract** |")] + "| `library/geombinatorics/geombinatorics-v34-n1-2024-07.pdf` (the journal copy, XXXIV(1) 20–29; § G) | **read in full** (the journal copy, 2026-09-27, the consolidation run's LW) |" + t[j:]
# E5 [Parts2020c]
t = once(t, "| `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf` | **read: abstract, §1, §§2.1–2.3** (FS106-QB); constructions recorded but not verified (FS106-V3) |",
    "| `library/pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf`; the journal copy `library/geombinatorics/geombinatorics-v30-n1-2020-07.pdf` "
    "(XXX(1) 25–39; § G) | **read in full** (the journal copy, 2026-09-27, the consolidation run's LW: §2.4's tile-share dial and §2.5's observations, "
    "p. 37, bear on FS-109, FS-111 and FS-112; the arXiv copy's abstract, §1, §§2.1–2.3 read by FS106-QB); constructions recorded but not verified (FS106-V3) |", "Parts2020c")
t = once(t, "| `pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf` | `[Parts2020c]` | read: abstract, §1, §§2.1–2.3 |",
    "| `pdf/arXiv-2010.12668-parts-what-percent-plane-5-6-colored.pdf` | `[Parts2020c]` | read: abstract, §1, §§2.1–2.3; the journal copy read in full (§ G) |", "Parts2020c § B")
# E2 [Parts2021]/[Parts2022]
t = once(t, "| `[Parts2022]` = `library/pdf/arXiv-2206.12633.pdf`; `[Parts2021]` not held | **`[Parts2022]` scanned (2026-09-09): abstract and §1 — its \"in a certain sense `χ = 7`\" is `χ(d)` on the first island of certainty, not `χ(ℝ²)`; `[Parts2021]` not read** |",
    "| `[Parts2021]` = `library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf` (XXX(4) 177–189); `[Parts2022]` = `library/pdf/arXiv-2206.12633.pdf` and "
    "the journal copy `library/geombinatorics/geombinatorics-v31-n4-2022-04.pdf` (XXXI(4) 189–195); § G | **both read in full** (the journal copies, "
    "2026-09-27, the consolidation run's LW2): `[Parts2021]` p. 181's \"Wavy sides\" is the unit-radius tactic, measured on p. 182 saving two colours at "
    "`m = 6` (FS-112; `LEDGER.md` row 134); `[Parts2022]` p. 191 gives seven for the band `[1, d]`, `d ∈ (2 sin(2π/9), √7/2]`, by tri- and bi-chromatic "
    "vertices, covered by `[Voronov2023]` Thm 1.1 — its \"in a certain sense `χ = 7`\" is `χ(d)` on the first island of certainty, not `χ(ℝ²)` |", "Parts2021/2022")
t = once(t, "| `pdf/arXiv-2206.12633.pdf` | `[Parts2022]` | scanned: abstract, §1 |",
    "| `pdf/arXiv-2206.12633.pdf` | `[Parts2022]` | scanned: abstract, §1; the journal copy read in full (§ G) |", "Parts2022 § B")
t = once(t, "`[Parts2021]` (Geombinatorics 30(4) (2021) 177–189, zbMATH 1466.05077),\n`[JohnsonSchneiderTiemeyer2007]`",
    "`[JohnsonSchneiderTiemeyer2007]`", "R.5 Parts2021")
t = once(t, "(FS-38's ratio-bound ancestry; the proof is reproduced in `plans/FS38-derivation.md`), `[Parts2021]`,\n",
    "(FS-38's ratio-bound ancestry; the proof is reproduced in `plans/FS38-derivation.md`),\n", "0d Parts2021")
t = once(t, "scans (`[ChybowskaSokol2022]`, `[Parts2022]`, `[Davies2024]`,", "scans (`[ChybowskaSokol2022]`, `[Davies2024]`,", "0e Parts2022")
# E5 [Parts2023], [deGreyParts2022]
t = once(t, "| `library/pdf/arXiv-2303.14722-more-certainty-interval.pdf` | **read in full (2026-09-09, FS-23)** |",
    "| `library/pdf/arXiv-2303.14722-more-certainty-interval.pdf`; the journal copy `library/geombinatorics/geombinatorics-v32-n4-2023-04.pdf` "
    "(XXXII(4) 159–185; § G) | **read in full (2026-09-09, FS-23)**; journal pp. 159–163, 184 re-read (2026-09-27, the consolidation run's LW) |", "Parts2023")
t = once(t, "| `library/pdf/arXiv-2206.12635.pdf` | **read (2026-09-09, FS-23)** |",
    "| `library/pdf/arXiv-2206.12635.pdf`; the journal copy `library/geombinatorics/geombinatorics-v32-n2-2022-10.pdf` (XXXII(2) 57–71; § G) | **read (2026-09-09, FS-23)** |", "deGreyParts2022")
# E1 [HoffmanSoifer1993]
t = once(t, "checked against zbMATH, 2026-09-27) | **Title only** (FS-107 §PA, item 8): by `[MundingerEtAl2025]`'s text the off-diagonal variant, not holes; not held, unread |",
    "checked against zbMATH, 2026-09-27) | **Held and read in full** (2026-09-27, the consolidation run's LW2; `library/geombinatorics/geombinatorics-v03-n2-1993-10.pdf`, "
    "pp. 38–40; p. 38 checked by FP): p. 38 defines the almost chromatic number `χa` (*\"almost all (i.e., all but one) colors forbid the unit distance, and the "
    "remaining color forbids a distance\"*), prints *\"4 ≤ χa ≤ 6.\"* and poses *\"And the problem is: find χa.\"* — the off-diagonal variant, not holes; no "
    "row answers it (recorded in FS-109's stub). As printed its unit squares contain unit pairs; the construction is printed corrected in `[Soifer2003poly]` "
    "p. 204 (squares of diagonal 1 and √2 − 1; LW3); the 1994 correction itself unread |", "HoffmanSoifer1993")
# E3 [Johnson2018]
t = once(t, "zbMATH 1407.05234, contents withheld) | **Listing only, not held.** Title-level: consequences of de Grey's graph; nothing indicates quadratic fields. Low priority, same routes as `[Johnson2006]` |",
    "zbMATH 1407.05234, contents withheld) | **Held; pp. 87–91 read** (2026-09-27, the consolidation run's LW2; `library/geombinatorics/geombinatorics-v28-n2-2018-10.pdf`, "
    "a scan; § G): consequences of de Grey's graph through Szlam's lemma; nothing on quadratic fields, no bearing on the direction. It relays W. Kuperberg's "
    "question, p. 90, *\"Is there any integer n such that ℝ² = ℝ × ℝ can be 2 × n colored so as to forbid Euclidean distance 1?\"* (checked by FP), which "
    "no row answers |", "Johnson2018")
# E7 [ShelahSoifer2003b], [Soifer2007], [SoiferShelah2004]
t = once(t, "| the same series (FS-103 §PA) | not held | zbMATH review (Weese) read (2026-09-26, FS103-G) |",
    "| the same series (FS-103 §PA); `CLOSED-QUESTIONS.md` §3's absoluteness entry | `library/geombinatorics/geombinatorics-v13-n1-2003-07.pdf`" + G +
    " | **read in full** (2026-09-27, the consolidation run's LW3; pp. 42, 43, 45 checked by FP); zbMATH review (Weese) read (2026-09-26, FS103-G) |", "ShelahSoifer2003b")
t = once(t, "| the same series (FS-103 §PA) | not held | listing only, no review (",
    "| the same series (FS-103 §PA); `CLOSED-QUESTIONS.md` §3's absoluteness entry | `library/geombinatorics/geombinatorics-v17-n2-2007-10.pdf`" + G +
    " | **read in full** (2026-09-27, the consolidation run's LW3; p. 86 checked by FP: a statement, no proof); listing only, no review (", "Soifer2007")
t = once(t, "| not held | zbMATH review (Komjáth) read (2026-09-26, FS103-G) |",
    "| not held; its journal summary `[SoiferShelah2004g]` is (§ G) | zbMATH review (Komjáth) read (2026-09-26, FS103-G); the journal summary read in full (LW3) |", "SoiferShelah2004")
# E8 [Woodall1973]
t = once(t, "and the cone is FS-110's round-4 object; §§1–2 statements only |",
    "and the cone is FS-110's round-4 object; §§1–2 statements only — `[Soifer2003poly]` p. 200 attributes to it a closed six-colouring of type "
    "(1, 1, 1, 1/√3, 1/√3, 1/(2√3)), to check when §§1–2 are read (LW3) |", "Woodall1973")
# E9 listing-only rows after [HoffmanSoifer1993]
i = t.index("| **[HoffmanSoifer1993]**"); j = t.index("\n", i)
rows = ("\n| **[Soifer1992six]** *A six-coloring of the plane* (A. Soifer; J. Combin. Theory Ser. A 61 (1992) 292–294) | **Listing only** (from `[Soifer2003poly]`'s "
        "references, the consolidation run's LW3, 2026-09-27); not held, unread: the type (1, 1, 1, 1, 1, 1/√5) six-colouring `[Soifer1994X6]` p. 140 reports (FS-109's X₆) |"
        "\n| **[HoffmanSoifer1996]** *Another six-coloring of the plane* (I. Hoffman, A. Soifer; Discrete Math. 150 (1996) 427–429) | **Listing only** (the same references, "
        "LW3); not held, unread: presumably the journal form of `[HoffmanSoifer1993]`'s construction [title-level guess] |"
        "\n| **[Soifer1994inf]** *An infinite class of 6-colorings of the plane* (A. Soifer; Congr. Numer. 101 (1994) 83–86) | **Listing only** (the same references, LW3); "
        "not held, unread: presumably the family behind `[Soifer1994X6]`'s `[√2 − 1, 1/√5] ⊆ X₆` [title-level guess] |"
        "\n| **[Raiskii1970]** D. E. Raiskii, *Realizing of all distances in a decomposition of the space Rⁿ into n + 1 parts* (Mat. Zametki 7 (1970) 319–323; Math. "
        "Notes 7 (1970) 194–196) | **Listing only** (the same references, LW3; also `[BrownDunfieldPerry1994]`'s [5]); not held, unread: the lower bound `4 ≤ χa` rests "
        "on it (`[HoffmanSoifer1993]` p. 38) |")
t = t[:j] + rows + t[j:]
p.write_text(t, encoding="utf-8")
print("BIBLIOGRAPHY applied")
