# LW — the Geombinatorics archive walk: report to the owner

*Job LW of the consolidation and library run, 2026-09-27. Record `data/consolidation-2026-09-27/lw/record.md`; verbatim notes
`lw/reading-notes.md`; catalogue `lw/catalogue.md` (= `~/source/library/geombinatorics/CATALOGUE.md`). Stages 1 and 2 (partial) saved, stage 4
done for what was read; stage 3 not started (budget). Every claim below held at one mind (LW) unless marked.*

## 1. Bearing on FS-112 and FS-111

**The choice.** FS-112 (the unit-arc half) should still open next, re-aimed in three places by what print holds:
1. **Its question is posed in print.** `[Polymath2021]` (Geombinatorics XXX(4), 2021), p. 199: *"Our failure to discover 6-tilings of larger
   disks motivates hope that one might be able to strengthen the seminal result of Thomassen [11], who showed that the plane cannot be tiled with
   six colors if the distance between adjacent tiles of the same color is strictly greater than 1, i.e. we prohibit tilings in which either (i)
   some unit-diameter circle encloses two same-colored tiles, or (ii) the unit-radius tactic is employed. It may be possible to eliminate
   criterion (ii) via an exhaustive computer search of all possibilities, but this has, as yet, remained beyond our reach."* The tactic, p. 194:
   *"a tile T of color 1 can share a boundary segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E is drawn
   as an arc of radius 1 centered on P."* FS-112 allows both (i) and (ii), so its NO answers this question a fortiori (for circular-arc maps,
   almost everywhere). Row 134 is the complementary strengthening (drop (i), keep (ii) forbidden), which the paper does not ask.
2. **Known positives for its exact checkers exist in print**: tight six-colourings using unit arcs of a strip of height √3 + √15/2 ≈ 3.6685
   (`[AxenovichEtAl2014]` Thm 4.2: *"The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at
   the opposite corner of the tile"*) and of a disk of radius ≈ 2.12426 (`[Polymath2021]` Fig. 10). FS-112's checkers should accept them before
   any of their refusals is believed (G21). A reading for the planner: a NO at bounded complexity should bound the widest six-map-colourable
   strip, so ω(6) ≥ 3.668 is a dial the milestone can aim at.
3. **The near-optimal designs in print avoid both FS-111's junctions and FS-112's interfaces** (`[Parts2020c]` p. 37, measured by numerical
   optimisation in a restricted family): *"a) vertices in which three or more colored tiles converge are disadvantageous (a void is superior to
   any such vertex); [...] d) the curving of pairs of opposite tile sides is optimized with a radius of 1/2."* Radius-1 arcs appear only as void
   boundaries (p. 34). A prior, never a cap (§ Counter-priors): it says the best known designs escape the unit-arc seam by leaving voids.

**Alternative weighed.** Open FS-111 (the cone scale) first. Nothing read bears on it beyond item 3's measured prior; no article gives a
junction-scale bound or a family of unbounded complexity.

**Why FS-112 wins.** It now answers a question the literature posed in writing (the publication rule's second clause, once formalized), and it
has printed known positives to calibrate against; FS-111 gained nothing.

**Confidence: medium-high.** What would change it: an unread flagged article (the ranked debts in § 4) holding a six-colouring theorem for maps
with unit arcs, or a lower bound on junction scales; the top three debts are the ones to read first.

**Searched:** all 187 articles of the 44 held issues screened by title, contents page and zbMATH review text; 44 flagged; 10 read in full
(below). Nothing read pre-empts rows 131–134.

## 2. Every article read, with its verdict

| article | grade in print | verdict |
|---|---|---|
| `[Polymath2021]` XXX(4) 190–201 | survey; constructions by figure with exact radii | **poses FS-112's question; names its object; supplies known positives** (§ 1) |
| `[GwynStavrianos2022]` XXXII(1) 5–28 | proofs (Lemma 2, Thm 2, Cor 1, Thm 9); a conjecture | **pre-empts the aim's link 2** (`FS103-M-EASY`, `χ(ℝ²) ≤ χ_m⁰(ℝ²)`, prior art recorded as "not searched as stated"): p. 12, *"Lemma 2. If a given finite unit-distance graph G = (V, E) is not k-colorable, then pk ≥ 1/\|E(G)\|."* and *"Corollary 1. If pk = 0, then χ(C) ≤ k."*, badness defined through an invariant mean on E(2); credited to the Polymath16 wiki's "Probabilistic formulation". I checked the proof: correct. With it, link 5's *yes* half is Theorem 2 plus one remark (filling holes of density δ with one colour gives badness ≤ 2δ). **Poses** Conjecture 1 (p. 24, *"pk (G) = qk (G) for general graphs G"*), which follows by weak-* compactness in its Definition-13 form (my sketch, one mind; their Theorem 7 has a Fubini gap for finitely additive means) |
| `[Parts2020c]` XXX(1) 25–39 | explicit constructions, numerically optimised | bears on FS-111/112/109 as a measured prior (§ 1 item 3); §2.4: *"We are unaware of any way to obtain a Siamese-free tiling with the relative proportion of tiles of some color being less than 1/8"* — a count dial FS-109 lacks |
| `[Soifer2019]` XXVIII(4), printed pp. 210–214 (header says 206–210) | problems posed | the first form of Open Problems 55.1–55.2 (p. 213: *"CNP – Triangle-Free. Construct a triangle-free 5-chromatic unit-distance graph."*), answered in its existence half by row 121; and *"The Ronald L. Graham New $1,000 Problem. Prove or disprove the existence of a 6-chromatic unit-distance graph."* — no row answers it |
| `[Mundinger2024]` XXXIV(1) 20–29 | constructions, validity checked numerically | six-colourings of type (1,1,1,1,1,d), d ∈ [0.354, 0.657]; their d = 1 null is a search; Soifer's X6 unanswered by any row |
| `[Soifer2024b]` XXXIV(1) 30–37 | problems posed | Conjecture 61.1 (7-chromatic two-distance graph), 61.2–61.3, Bukh 60.18, 64.3 (`χ = 7`); none answered |
| `[Soifer2025]` XXXIV(3) 113–115 | survey | nothing new for us |
| `[Thurey2025]` XXXIV(3) 116–119 | construction | no bearing |
| `[Voloshin2026]` XXXV(4) 155–159 | proof | no bearing (mixed hypergraphs) |
| `[Parts2023]` XXXII(4) 159–185 (journal copy; arXiv read at FS-23) | pp. 159–163, 184 re-read | its lower bounds are trichromatic-point arguments (row 131's second no-go); nothing new |

## 3. Drafts for the owner (none applied)

**`CLOSED-QUESTIONS.md` §3, a new entry (draft):** *"Can Thomassen's six-colour theorem be strengthened by eliminating the unit-radius tactic?"*
— `[Polymath2021]` p. 199 (quoted in § 1). Answered in the complementary direction only: row 134 drops criterion (i) and keeps the tactic
forbidden (Condition 5), for circular-arc maps a.e.; FS-112's NO would answer it as posed, a fortiori. Also, as an adjacent entry: `[GwynStavrianos2022]`
Conjecture 1 (a probabilistic de Bruijn–Erdős) — answered at [hand, one mind] in its Definition-13 form; hold it until a second mind checks.
And the Graham $1,000 problem (`[Soifer2019]` p. 213) beside the §3 entry on absoluteness: given MR it is row 130's measurable question.

**`LEDGER.md` (drafts):** row 130's prior-art line — add: "the unconditional inequality `χ(ℝ²) ≤ χ_m⁰(ℝ²)` (N-EASY) is in print as
`[GwynStavrianos2022]` Lemma 2 / Theorem 2 / Corollary 1, for badness defined through an invariant mean on E(2) (infimum 0 suffices), credited
there to the Polymath16 wiki's 'Probabilistic formulation of Hadwiger–Nelson problem'". Row 131's prior-art line — add: "the step 'a refutation
gives `χ(ℝ²) ≤ 6`' is `[GwynStavrianos2022]` Theorem 2 once holes are filled". Row 134's prior-art line — add: "`[Polymath2021]` p. 199 poses
Thomassen's theorem with the unit-radius tactic allowed (FS-112's question); row 134 is the complementary case, not asked there". In
`plans/FS103-derivation.md`, FS103-M-EASY's *Prior art* line likewise.

**`CLAUDE.md` (drafts):** § The aim link 2: after "([hand, two minds]: FS103-N's N-EASY, PA1's (E))" add "; in print as
`[GwynStavrianos2022]` Thm 2, through an invariant mean". § Paths forward, FS-112's row: "posed in print as Polymath16's 'eliminate the
unit-radius tactic' (`[Polymath2021]` p. 199); known positives: `[AxenovichEtAl2014]` Thm 4.2's strip, `[Polymath2021]` Fig. 10's disk".

**Stub banners (drafts):** `plans/STUB-unit-arc-half.md` — under "The question": the printed form and the two known positives; under
"Registered expectations": `[Parts2020c]` §2.5's observation as a measured prior. `plans/STUB-reg-scale.md` — `[Parts2020c]` §2.5 (a) under
"The room". `plans/STUB-hole-dial.md` — `[Parts2020c]` §2.4's tile-share dial (no Siamese-free 7-tiling below 1/8).

**`BIBLIOGRAPHY.md` outside § G (drafts, rule 0b):** § A rows `[Soifer2019]` (held now: `library/geombinatorics/geombinatorics-v28-n4-2019-04.pdf`,
read in full; printed pp. 210–214, its header says 206–210), `[Polymath2021]` (held, read in full), `[Mundinger2024]` (journal copy held, read in
full), `[Parts2020c]` (read in full), `[Parts2021]`/`[Parts2022]` (journal copies held), `[Parts2023]`, `[deGreyParts2022]` (journal copies);
§ C `[Johnson2018]` (held now, not read); § B lines for the 44 new files (or one line pointing to the catalogue, which § G's pointer does now).
`[GwynStavrianos2022]` belongs in § A (it is load-bearing for link 2's attribution).

## 4. Debts left

- **Stage 2's remainder: 34 flagged articles not read**, ranked in `lw/record.md` § Stage 2 — first `[Parts2021]` (XXX(4) 177–189), Kahle–
  Martinez-Figueroa–Soifer's square-grid problem (XXIX(4) 167–184), `[Parts2022]` (XXXI(4) 189–195), the Coulson visualization (XXXI(4) 156),
  Sirgedas (XXX(3) 138–151), Martinez-Figueroa (XXXIII(1) 14–38).
- **Stage 3 not started:** zbMATH's listing of the journal for 1991–2015, flagging, and fetching the older issues. Known targets already:
  Soifer, "Six-realizable set X6", III(4) (1994) 140–145 (the posing paper of X6); Hoffman–Soifer, "Almost chromatic number of the plane",
  3(2) (1993) 38–40; Soifer, "Relatives of chromatic number of the plane I", 1(4) (1992) 13–17; the 2015 issues XXIV(3)–XXV(1) (Kloeckner,
  "Coloring distance graphs: a few answers and many questions"; Malen, "Measurable colorings of S²_r"; Maier, "Coloring regions on a sphere to
  forbid the unit distance").
- **XXXIII(4) (April 2024) is not held**: two downloads failed ("no PDF after three tries"); its four articles are catalogued from zbMATH.
- The Polymath16 wiki page "Probabilistic formulation of Hadwiger–Nelson problem" (credited by Gwyn–Stavrianos) is not held.

## 5. Gates

- `python3 tools/bib_audit.py`: exit 0 (462 keyed rows; every cited work resolves), read directly after each edit.
- Renames: 44 files, the map in `lw/rename-map.json`; the catalogue's volume and number checked against each issue's own cover or contents page.
- The brief's premise corrected: 16 of the 45 recent issues have no usable text layer (XXV(2)–XXIX(1) are scans; XXX(2), XXX(3), XXXIV(4) garbled).
- Theorems this phase proved: the check of `[GwynStavrianos2022]` Lemma 2 / Theorem 2 (correct); the sketch of their Conjecture 1 (one mind, not claimed).
