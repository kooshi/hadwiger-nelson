# FS110-PA — prior art for a Condition-5-only round (Sokolov–Voronov's Condition 5 kept, Condition 6 dropped)

*Job FS110-PA (de Bruijn), Opus 5.5, 2026-09-27. Brief `data/fs110/briefs/PA110-sv-condition5.md` with `data/fs110/briefs/STANDING-RULES.md`
(rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read). Not blind; fenced from the two blind verifiers' records and the three
channels of standing rule 13. Working files: `data/fs110/fs110-pa/`. The question comes from FS110-A4's recommendation
(`plans/POROS-2026-09-27-fs110-competition.md` § A4-1.9): "a prior-art check showing that S–V or Townsend already settle maps with Condition 5
and without Condition 6. That check is owed before round 3".*

## Theorems this phase proved

*(filled stage by stage; this is a reading job, so most lines are findings, not theorems)*

## Would-have-searched-here log

- Stages 1–2: none (reading only).

## Stage 1 — SAVED: quotation check, fences, reading plan

**Quotation check (standing rule 5).**
- The brief's gloss "Condition 5 (no unit arcs on boundaries)" is **not verbatim and is weaker than the print.** `[SokolovVoronov2025]` p. 4:
  "Condition 5. (fa = “forbidden arcs”) If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of
  unit curvature are forbidden." The condition is **finite intersection of every boundary with every unit circle**; "no unit arcs" is only
  the first consequence the paper draws from it (p. 4, Observation 2: "1. The boundaries do not contain arcs of a circle of radius 1. 2. Any
  circle of radius 1 is partitioned into a finite number of monochromatic arcs."). A boundary meeting a unit circle in an infinite set with no
  arc (a Cantor set, or a sequence of tangencies) satisfies "no unit arcs" and violates Condition 5. **Which of the two a Condition-5-only
  round works under must be fixed in its registration**; FS-110's own list (`data/fs110/claims.md` l. 64–65) quotes the finite-intersection
  form verbatim, correctly. (S–V themselves slide between the two: Prop. 10's proof says "which states that the boundaries do not contain such
  arcs", p. 12, while needing the finite-intersection form, since its conclusion is "infinitely many points"; FS106-V's Cor. 2 row already
  notes this.)
- The standing rules' quotations of Kooshi ("From here on out …", "to eliminate the crutch …", "search for a finite graph is out …", "A proven
  theorem about why its impossible is also valid …") match `CLAUDE.md` § Counter-priors, § Toolchain, § Publication and § Where the problem
  stands item 23.
- The brief's "their §9 (the open questions)": §9 is headed "Conclusion" (p. 26) and holds Questions 1–2; checked.
- `[SokolovVoronov2025]` exists in one arXiv version: the arXiv API (queried 2026-09-27) returns `2502.01958v1` only (published and updated
  2025-02-04). The journal version (Discrete Math. 349 (2026) 115321, per `BIBLIOGRAPHY.md` l. 128) is not held; whether its §9 differs is
  unchecked (stage 3 tries).

**Fences.** A listing of the shared scratchpad directory (to create my subdirectory) showed other jobs' **file names**; no other file was opened.
My first extraction wrote `v3.txt` at the scratchpad's top level; its birth time equals the write (2026-09-27 10:26:16), so it overwrote
nothing, and it was moved into `scratchpad/fs110-pa/`. One `grep` for "third round|Condition 5|…" ran over `data/fs110/fs110-a4/*`, which
holds a copy named `FS110-NB-verification.md` (a blind verifier's record): **it printed no line from that file** (zero hits there); nothing
else of it was read. Logged for the owner.

**What is already known (read, not redone).** `plans/FS106-V-verification.md` §§3.1–3.2 (FS106-V), § Continuation — FS106-V2 (§7, the
Appendix, the verdicts), § Continuation — FS106-V3 stages 1 and 3 (Townsend's manuscript, Woodall §3). Their findings used below are cited by
section, never re-derived.

## Stage 1 — SAVED

## Stage 2 — SAVED: what `[SokolovVoronov2025]` prove, state and ask about Condition 5 without Condition 6 (read first-hand, v1)

*Copy: `~/source/library/pdf/arXiv-2502.01958-maptype.pdf` (v1, 29 pp.; my text extraction `scratchpad/fs110-pa/sv.txt`). Read for this job:
pp. 1–13, 17 (Lemma 3's statement), 19–20 (§7's opening), 24–29 (Prop. 17's end, §§8–10, references). Page = the print's footer.*

**Verbatim, with pages.**
1. Abstract (p. 1): "it is shown that at least 7 colors are required to color a map in which the boundaries are not arcs of a unit circle and
   three boundaries connect at each vertex." — the abstract states the **cubic** form (Condition 7), not Condition 6.
2. Conditions (p. 4): "Condition 5. (fa = “forbidden arcs”) If any boundary intersects with a circle of unit radius at a finite set of points, we
   say that arcs of unit curvature are forbidden." "Condition 6. (3col = “no trichromatic vertices of degree 4+”) There are no trichromatic
   vertices of degree greater than 3." "Condition 7. (cubic = “no vertices of degree 4+”) The degree of any vertex is 3".
3. Theorem 1 (p. 5): "If the coloring is proper, Jordan, locally finite, if a vertex with degree greater than 3 cannot be trichromatic, and if
   arcs of unit curvature are forbidden, then at least 7 colors will be required, i.e. χmap+fa+3col(R2) = 7." Then: "Obviously, Condition 7 is
   stronger than Condition 6. The formulation is somewhat simplified." Proof of Theorem 1 (p. 25) restates: "such that any edge intersects any
   circle of radius 1 at only a finite number of points, and no trichromatic vertex has degree greater than three."
4. **Proved under Condition 5 alone** (Conditions 1–5, no 6): Lemma 2 (p. 8): "Under Condition 5, no point in a valid 6-coloring can have
   chromaticity k ≥ 4." (with Prop. 6, p. 8: "If Condition 5 holds for a 6-coloring, then no point can have chromaticity greater than 4.")
   Lemma 3 (p. 17): "Suppose that the Conditions 4, 5 (“map-type”, “forbidden arcs”) are satisfied for a proper 6-coloring. Then there do not
   exist two trichromatic points u1, u2 with same multicolor such that 1 < ∥u1 − u2∥ < 2 and the boundaries between each pair of colors in
   their multicolor extend from each of them." Corollary 3 (p. 14) carries the same hypothesis: "and the boundaries between each pair of colors
   in their respective multicolor sets extend from each point", with the remark (p. 14): "Note that we cannot assert it unless the Condition 5 is
   satisfied and the breakpoints in rings may be unrecoverable."
5. **Where Condition 6 enters, in print:** Lemma 4 (p. 19): "Suppose that the Conditions 4, 5, 6 (“map-type”, “forbidden arcs”, “no trichromatic
   vertices of degree 4+”) are satisfied for a proper 6-coloring. Then there are either two trichromatic points between 1 and 2 with the same
   multicolor, or two trichromatic points less than 2 with non-intersecting multicolors." Its first step (p. 20): "It is straightforward to
   verify that within a distance of at most 1 from any point, there exists a trichromatic point." And §6 (p. 11) defines "x45, x46, x56 as the
   intersections of ωδ(u) with the boundaries separating regions of colors 4 and 5, colors 4 and 6, colors 5 and 6" — the three boundary types,
   which a trichromatic vertex of degree ≥ 4 need not have. Condition 6 is named nowhere else.
6. **§9 "Conclusion" (p. 26), in full on this point:** "Note that all reasoning remains valid if we consider the interior of a circle of radius 3."
   "Question 1. What is the minimum area of a convex region for which we can assert, under the conditions of Theorem 1, that a 6-coloring does not
   exist?" "Certainly, the conditions of Theorem 1 leave some frustration." "Question 2. Is it true that 7 colors are needed to color a locally
   finite map in the plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?" "The
   conditions of Theorems 1, 2 allow us to handle some exceptional cases and to carry out the rest of the reasoning in the same way as it was
   done for the forbidden distance interval. In the above formulations, all “features” form a locally finite set of points in the plane. […] It
   may seem strange that the existence of arcs of unit curvature (or of a countable number of intersections of a boundary with such an arc) is
   a problem of principle. But in this case, “pecularity” has Hausdorff dimension 1, not 0." (then the `S(ε) = Ω(ε²)` / `Ω(ε¹)` remark and the
   `µ*₆ < 1` remark).

**Finding.** S–V **state no result and ask no question about Condition 5 without Condition 6.** Question 2 drops **both** conditions at once;
the Condition-5-only case is its sub-case, unasked. Their §9 discusses only Condition 5's failure ("arcs of unit curvature", dimension 1); on
Condition 6 their only words are "the conditions of Theorem 1 leave some frustration" and "The formulation is somewhat simplified". What they
do prove with Condition 5 alone is Lemma 2 (no point of chromaticity ≥ 4), Lemma 3 and Corollary 3 **with the extension hypothesis built in**,
and every §4–6 proposition (FS106-V §3.2's map: Condition 6 enters only at Props. 9–10 / Cor. 2 and Lemma 4). FS106-V2 already located the
open steps a Condition-5-only proof must pass: SV-L4 (a) ("a trichromatic point within 1") and the Prop. 19 fills, both open when bichromatic
vertices of degree ≥ 4 occur, and the trichromatic degree-4 "bowtie" at Props. 9–10 (FS106-V §3.1, Cor. 2 row). Nothing in print closes them.

**Flag for the owner (a reading, one mind, not checked against FS-110's definitions beyond `data/fs110/claims.md` l. 27, 79, 135, 164).** S–V's
Lemma 2 (verified TRUE and region-only at FS106-V §3.1, Conds. 3 and 5) says that **under Condition 5 no point of a 6-coloured map has
chromaticity 4**, i.e. `|P_cl(x)| ≤ 3` everywhere (`P_cl` = the closure type = S–V's multicolour). FS-110's K-CHR4 ("`|P(x)| = 4` open",
`data/fs110/claims.md` l. 164) is open in the class with unit arcs; **under Condition 5 it is closed in print.** If the round's "four-colour seam
point" (A4-1.8, `plans/POROS-2026-09-27-fs110-competition.md` l. 771: "a strong escape at a four-colour seam point") means `|P_cl| = 4`, the
round's one surviving escape is empty by S–V Lemma 2 at six colours, and Y2-W4's "no arc means four colours" would then refute the escape outright.
If "four-colour" means something else (colours on the unit circle, `P_ess`, cusps outside Condition 3), the round is untouched. **Check the
definition before registering round 3.** (Checked as far as A4's own claim goes: its falsifier reads "a seam point with at most three colours,
or a four-colour seam point", l. 773, and its inputs include "a `(4, 2)` pair", l. 775 — the count is of the colours at the point, i.e. `|P_cl|`.
What is not checked: whether FS-110's class (bounded `K`, cusps, a.e.) keeps every input of Lemma 2's proof — Props. 3–6 and Condition 3.)

## Stage 2 — SAVED

## Stage 3 — SAVED: the searches (citing works, zbMATH, arXiv, the literature's words)

| source | query | count | what it held |
|---|---|---|---|
| arXiv API | id_list 2502.01958, 2304.10163 | 2 | S–V at **v1 only**; Voronov at v3 (13 Apr 2025) |
| Crossref | the S–V DOI `10.1016/j.disc.2026.115321` | 1 | Discrete Math. 349(12), 115321 (Dec 2026); **12 references, the same 12 as v1**; no abstract deposited; journal text not held |
| OpenAlex | `cites:W4407185544` (S–V; the record carries the DM DOI only) | **0** | — |
| OpenAlex | `cites:W4366733341` (`[Voronov2023]`, arXiv DOI) | 1 | *Monochromatic triangles in the max-norm plane* (arXiv:2302.09972) — not maps |
| Semantic Scholar | `arXiv:2502.01958` citations (paperId `0b38e593…`, DBLP `journals/dm/SokolovV26`, one record for arXiv + DM) | **1** | `[AxenovichLiuSagdeev2025]` (arXiv:2512.15516 v2): opened; its only use, p. 5: "Recently, Sokolov and Voronov [71] showed that any 6-coloring where each color class is a disjoint union of polygons, contains a monochromatic pair of points at distance 1." — nothing on Conditions 5–6 |
| Semantic Scholar | `arXiv:2304.10163` citations | — | **not obtained**: HTTP 429 three times; FS106-P §PA.1 walked this list (`BIBLIOGRAPHY.md` row `[AxenovichLiuSagdeev2025]`) |
| G49 cross-check | OpenAlex 0 vs Semantic Scholar 1 for S–V | — | the databases disagree; S2's one work is the ALS paper, opened above; OpenAlex's S–V record has no arXiv id, which is where its miss likely sits |
| OpenAlex | `cites:W2022153739` (`[Townsend1981]`) | 5 | Thomassen 1999; *On Radial Colorings of Annuli* (arXiv:1305.5229, 2013); Manta 2021; Chybowska-Sokół et al. 2023; **`[Soifer2024]` ch. 25** — opened, below |
| OpenAlex | `cites:W2030472577` (`[Woodall1973]`), 2020–2026 | 11 | Soifer 2024 chs. 3, 4, 6, 8, 11, 25; Manta 2021; Chybowska-Sokół 2023; 3 others off-topic (finite quadrance graphs, local fields, a `Q³` hunt) |
| OpenAlex | `cites:W2095865329` (`[Coulson2004]`), 2020–2026 | 1 | Manta 2021 |
| zbMATH API | `ti:"map-type colorings"` | 1 | S–V, DM 2026, review text withheld ("contents unavailable due to conflicting licenses") |
| zbMATH API | `ab:"Townsend" & ab:"Woodall"` | 1 | S–V |
| zbMATH API | `au:"Voronov, Vsevolod"` / `au:"Sokolov, Georgy"` | 22 / 7 | no later map paper by either; `[DidinVoronov2026]` (dense colour classes, already in `BIBLIOGRAPHY.md`) is the only new plane-colouring item |
| zbMATH API | `ab:"unit distance" & ab:"tangent"` | 1 | Gardner 1995 (not relevant) |
| zbMATH API | `ab:"map" & ab:"unit distance" & py:2020-2026` | 2 | not relevant (Erdős distance on graphs; layers) |
| zbMATH API | `ti:"chromatic number of the plane" & py:2024-2026` | 4 | S–V; Soifer, Geombinatorics 2025 (review: two-distance conjectures, no maps); Thürey 2025 (other metrics); De Neve et al., Amer. Math. Monthly 2025 (two forbidden distances; title via Crossref) |
| zbMATH API | `ab:"map-type"`, `ab:"unit curvature"`, `ab:"monochrome unit"`, `ab:"polygonal" & ab:"chromatic number of the plane"` | 34 / 4 / 0 / 0 | nothing on plane colouring |
| arXiv API | `abs:Townsend AND abs:Woodall`; `abs:"chromatic number of the plane" AND abs:map`; `… AND abs:polygonal`; `abs:"Hadwiger-Nelson" AND (tiling OR regions OR map OR Jordan)` | 1 each | S–V only |
| arXiv API | `abs:"chromatic number of the plane"` since 2025-02 | 3 | S–V; `[Ducz2026]`; `[DuczVarga2026]` — neither about maps |
| arXiv API | `abs:"unit distance" AND abs:tangent`; `abs:"monochrome unit"`; `abs:"map-type"` | 0 / 1 (physics) / 51 (none relevant) | — |

**Finding.** **No work since S–V proves, refutes or poses a Condition-5-only statement** — within these indexes, which reach neither Geombinatorics
issues after 2025 nor any citing work that OpenAlex, Semantic Scholar and zbMATH have not yet linked (S–V's journal version is dated Dec 2026).
This is a negative about the indexes' coverage as much as about the literature (G21).

## Stage 3 — SAVED

## Stage 4 — SAVED: Townsend's manuscript, Woodall 1973, and Soifer's reprint of Townsend's proof

**Do Townsend 1979 or Woodall 1973 treat maps with unit-arc boundaries excluded but bichromatic vertices of degree ≥ 4 allowed?** **No — neither
excludes unit arcs, and neither keeps bichromatic vertices of degree ≥ 4 in the class they finally argue about; both prove six, not seven.**
- **Townsend 1979** (FS106-V3 stage 1, read there in full): Definition 3 has no unit-arc restriction and his ⅔π counterexample to Woodall uses a
  boundary that is a unit arc (V3: "It uses a boundary that is a unit arc (`e`, excluded by S–V's Condition 5)"). Bichromatic vertices of degree
  ≥ 4 are **removed**, not treated: simplification (c) merges "two nonadjacent regions of the same color" at a vertex into one region — the step
  FS106-V3 found to be the manuscript's one substantive GAP and identified with S–V Lemma 4 (a)'s open step. With Condition 5 his ⅓π lemma needs
  no cut points at all (V3, Thm 4 row: "With Condition 5 there are no cut points at all").
- **Woodall 1973** (FS106-V3 stage 3, §3 read there): maps are general locally finite Jordan maps, unit arcs allowed; step 3 merges two same-set
  regions at a vertex "unless X and Y are completely contained within the “cone” outside two unit discs touching each other at P", and step 5
  excludes cones — so Woodall's steps 2, 3, 5 **eliminate** bichromatic vertices of degree ≥ 4 (V3: they "fill Townsend's (c) for maps with his
  local finiteness"). Again six colours only.
- **New this stage — `[Soifer2024]` ch. 25** (read: pp. 253–266, the text; figures not viewed; my extraction `scratchpad/fs110-pa/ch25.txt`).
  Soifer: "I have corrected JCTA's quarter-a-century old mistake, when I published Townsend's complete paper in the April 2005 issue of
  Geombinatorics [Tow2]" and the chapter conveys "the proof itself". Its "Initial Observations" (p. 257) keep **the same simplification (c)**:
  "(c) For each vertex v which is a boundary point of two nonadjacent regions of the same color, choose ε > 0 sufficiently small and describe an
  ε-neighborhood whose closure contains v and whose intersection with each of the two regions is non-null, coloring this ε-neighborhood the same
  color as the two regions, and thus forming one new region incorporating the original two and the ε-neighborhood (see Fig. 25.3)." So **FS106-V3's
  GAP at (c) is in the text Soifer reprints as `[Townsend2005]`**, as far as his reprint is faithful; `[Townsend2005]` itself is still unheld.
  The chapter ends with the proof (p. 266) and poses no open problem. (Soifer's ch. 8 was not located in my extraction; not read.)

**What it means for a Condition-5-only round (one line).** The Condition-5-only map question (S–V's Question 2 with Condition 5 kept) is **not
settled, stated or asked in print** — S–V prove seven only with Condition 6 (their abstract even with Condition 7), Townsend and Woodall prove six and
dispose of same-coloured vertices by merging, and nothing citing S–V touches it; the round is open ground, **provided its "four-colour seam point"
is not a point of chromaticity 4, which S–V's Lemma 2 already excludes under Condition 5 at six colours** (stage 2's flag).

**Theorems this phase proved.** None: a reading job. Findings above are [external] quotations and [reading] comparisons, one mind.

**Proposed `BIBLIOGRAPHY.md` edits** (the close writes them).
- `[SokolovVoronov2025]` (row 128): add "§9 and every use of Conditions 5–6 re-read first-hand (FS110-PA, 2026-09-27): no statement or question on
  Condition 5 without Condition 6; the abstract states the cubic form; the DM version (349(12) 115321, Dec 2026) has v1's 12 references, text not
  held; citing works 2026-09-27: OpenAlex 0, Semantic Scholar 1 (`[AxenovichLiuSagdeev2025]`, polygonal sentence only)".
- `[AxenovichLiuSagdeev2025]` (row 848): upgrade "Listing only" to "opened (FS110-PA): p. 5 cites S–V's polygonal theorem and Voronov's interval
  theorem; no map-type or a.e. statement"; it also cites `[SokolovVoronov2025]`.
- `[Soifer2024]` (row 150): add "ch. 25 read (FS110-PA; text pp. 253–266, figures not viewed): Townsend's proof as reprinted from `[Townsend2005]`,
  simplification (c) verbatim-equivalent to the 1979 manuscript's; no open problem".
- `[Townsend2005]` (row 139): add "Soifer 2024 ch. 25 reprints it; its simplification (c) matches the 1979 manuscript's (FS110-PA)".

**Would have searched here:** none (reading and literature search only).

## Stage 4 — SAVED
