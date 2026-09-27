# LW2 — the Geombinatorics archive walk, continued: report to the owner

*Job LW2 of the consolidation and library run, 2026-09-27 (brief `briefs/LW2-archive-walk-continued.md`). Record: `lw/record.md` § Continuation —
LW2 (stages 0, 1, 2 SAVED; this report is stage 3). Every claim is at one mind (LW2) unless marked; "two minds" means LW's and mine.*

## 0. The second reading of LW's two held findings (stage 0)

I read both papers from the held issues before re-reading LW's notes, then compared line by line.

| finding | LW said | my verdict | where I differ |
|---|---|---|---|
| **H1** `[Polymath2021]` poses FS-112's question | p. 199 asks to *"strengthen the seminal result of Thomassen [11]"* by eliminating *"(ii) the unit-radius tactic"*, defined on p. 194; FS-112's NO would answer it a fortiori | **Agree.** Both quotations are verbatim (checked on the rendered pages). Within its class — locally finite tilings bounded by segments and circular arcs — FS-112 contains the paper's question, whatever reading of criterion (i), because FS-112 forbids neither (i) nor (ii). Outside that class (the paper's tiles are *"bounded by a closed curve"*, p. 191) FS-112 as stated is silent. Row 134 is the complementary case, and incomparable with Thomassen's theorem: it drops (i) but forbids every radius-1 arc. No row touches the tactic itself | (1) **The six-tiled disk is not an exact known positive.** For the strip the tactic is in print (p. 194; Fig. 6's caption, p. 196: *"The sloping boundaries are arcs of radius 1"*). For the disk (Fig. 10, p. 200) the text never says so and gives no coordinates beyond the radius and a unit pentagon. The strip (`[AxenovichEtAl2014]` Thm 4.2) is the one exact positive. (2) Five page numbers were off, now fixed in § G: the `8/9` pair is on p. 198 (not 199), the `8/3` pair on pp. 192–193, Table 1 on p. 195, Fig. 6 on p. 196, Table 2 on p. 200. (3) The paper's (i)/(ii) do not cover every case of Thomassen's hypothesis. Two same-coloured tiles at distance exactly 1 through a point contact are neither — which is why FS-112's containment needs no reading of (i) |
| **H2** `[GwynStavrianos2022]` prints link 2 | Lemma 2, Theorem 2 and Corollary 1 (p. 12) are link 2 in invariant-mean form; the proof is correct; Theorem 7 (p. 22) has a Fubini gap | **The proof check is confirmed** — correct for every left-invariant mean and every colouring, measurable or not (now two minds). **The Theorem 7 gap is confirmed.** The step *"Again by Lemma 1, we get that there exists some fixed value c of c_r"* needs the two finitely additive expectations taken in the other order, and no Fubini theorem holds for such means. **Conjecture 1 in its Definition-13 form is re-derived by compactness** (two minds, not blind). Its *"By consequence, pk = qk"* still rests on Theorem 7 | **The paper prints link 2's argument, not link 2.** Its hypothesis is "the infimum of badness under *some* fixed invariant mean is 0". For some invariant means, a *measurable* colouring whose monochromatic unit pairs have measure zero still has positive badness (a Haar-null set can be thick). LW's note limited this to non-measurable colourings, which understates it. Link 2 (`χ(ℝ²) ≤ χ_m⁰(ℝ²)`) follows in one unprinted line: rerun Lemma 2 with Haar measure on large balls of E(2), or choose a mean that vanishes on null sets. So the printed statement is stronger in scope and weaker in reach: it implies link 2 with the line, and link 2 does not imply it. **The attribution still moves** (the argument is in print, 2022). **The credited wiki page** (Polymath16, "Probabilistic formulation", last edited 7 May 2019, now read in part) has the averaging device only, applied to a colouring assumed proper — *"Suppose for sake of contradiction that we have a 4-coloring [...] with no unit edges monochromatic"* — and states no badness theorem |

## 1. Bearing on FS-112 and FS-111

**The choice.** FS-112, the unit-arc half, still opens next. What print holds re-aims it in four places:
1. **Its question is posed in print** (`[Polymath2021]` p. 199; § 0, H1). FS-112's NO answers the question as posed, for locally finite
   segment-and-arc tilings, almost everywhere. That answer covers every reading of the paper's criteria.
2. **One exact known positive, not two:** `[AxenovichEtAl2014]` Thm 4.2's strip of height √3 + √15/2. The Polymath disk needs reconstruction
   before a checker can take it.
3. **A measured instance of the tactic saving colours:** `[Parts2021]` p. 181, "Wavy sides": *"one can use the trick of drawing the relevant part
   of this side as an arc with a radius of 1 centered at the nearest corner of the adjacent tile to slightly reduce the distance between the
   tiles"*. p. 182: *"for m = 6, it is possible to reduce k from 31 to 29 (due to reduction of d by only 0.15%)"*. This is multi-fold colouring,
   so it moves nothing at ordinary colouring (`m = 1`). But it is print evidence that the tactic buys colours in the neighbouring tiling problem.
   The stub's registered "a YES by formula (0.03)" should be re-registered with it in view (G21: say what the registration's population was).
4. **Its everywhere-form sibling is thirty years old:** `[Kainen1992]` p. 35, *"(2) CONJECTURE. The chromatic number of the plane is
   robust."* Kainen's p. 34 Theorem 1 colours every band up to `(√7 − 2)/(√7 + 2)` with seven colours, and `[Voronov2023]` Thm 1.1 proves every
   band needs seven. So the conjecture says `χ(ℝ²) = 7` in other words (§ 3). It frames link 5 and FS-112 historically, and changes no step.

**Alternative weighed.** Open FS-111 (the cone scale) first. Nothing read gives a junction-scale bound or a family of unbounded complexity.
`[BrownDunfieldPerry1994]`'s Theorem 8 argues topologically about how regions meet, at no scale. `[Parts2020c]`'s measured observation — the
best designs avoid junctions and leave voids (LW) — is still the only print prior for FS-111.

**Why FS-112 wins.** It answers a question the literature posed in writing, and it has one exact positive to calibrate its checkers against.
FS-111 gained nothing.

**Confidence: medium-high.** What would change it: an unread older article holding a six-map with unit arcs or a junction-scale bound. The
candidates are Soifer's 2003 "polychromatic number and 6-coloring" (12(4) 191–216) and the Hoffman–Soifer correction (3(3) 102), both debts.

**Searched:** LW's 34 unread flagged recent articles, in its ranked order (nine read or disposed of, § 2); zbMATH's full 1991–2015 index of the
journal (429 records), screened by keyword (132 flagged) and ranked by hand; three older issues fetched and four articles read. Nothing read
pre-empts rows 131–134.

## 2. Every article read, with its verdict

| article | grade in print | verdict |
|---|---|---|
| `[Polymath2021]` XXX(4) 190–201 (second reading) | survey; constructions by figure | poses FS-112's question; the strip is the one exact positive (§ 0) |
| `[GwynStavrianos2022]` XXXII(1) 5–28 (second reading) | proofs; a conjecture; Theorem 7 with a gap | prints link 2's argument, and a statement link 2 follows from in one line (§ 0) |
| `[Polymath16wikiProb]` (Polymath16 wiki, archived) | wiki, lemmas with proofs | the averaging device for a proper colouring; no badness theorem; opening, contents, table head and "Further questions" read |
| `[Parts2021]` XXX(4) 177–189 | constructions by numerical search | bears on FS-112 (§ 1 item 3); main result *"χm < (1 + 2/√3)² · m + 3.501"* (p. 177), a claim with measured support |
| `[KahleEtAl2020]` XXIX(4) 167–184 | proofs and computer-found examples | no bearing (achromatic number of the grid) |
| `[Parts2022]` XXXI(4) 189–195 | proof, human-checkable | no pre-emption: seven for the band `[1, d]`, `d > 2 sin(2π/9)` (p. 191), by a tri-chromatic-point argument (row 131's second no-go); covered by `[Voronov2023]` Thm 1.1 |
| `[ConwayEtAl2022]` XXXI(4) 156 | two pictures | no bearing |
| `[MartinezFigueroa2023]` XXXIII(1) 14–38 | proofs | on the 2-sphere with a band, Lovász's neighbourhood-complex bound stops at four (Theorem 3.1, p. 21) — the band analogue of G73's coindex ceiling |
| `[LiShapiroWeatherspoon2022]`, `[Triplett2025]`, `[FiscusEtAl2024]` | proofs | no bearing (Szlam's lemma family; a hypergraph reformulation) |
| `[Johnson2018]` XXVIII(2) 87–92 | proofs (immediate from χ ≥ 5) | no bearing on the direction. Relays W. Kuperberg's question (p. 90): *"Is there any integer n such that ℝ² = ℝ × ℝ can be 2 × n colored so as to forbid Euclidean distance 1?"* — no row answers it |
| `[Kainen1992]` 2(2) 33–36 | a theorem with a short proof; a conjecture | **poses a conjecture equivalent to `χ(ℝ²) = 7`** given `[Voronov2023]` Thm 1.1 (§ 3); its Theorem 1 is the upper half of Voronov's Cor. 1.1, in print in 1992 |
| `[HoffmanSoifer1993]` 3(2) 38–40 | a construction; a problem | poses *"find χa"* (almost chromatic number, *"4 ≤ χa ≤ 6"*); as printed its unit squares contain unit pairs (the correction is unread); no row answers it |
| `[Soifer1994X6]` 3(4) 140–145 | a proof by explicit tiling | poses X₆ (the posing paper of `[Mundinger2024]`'s question): *"if 1 ∉ X6, then χ = 7 / if 1 ∈ X6, then χ ≤ 6"* (p. 141); a second dial beside FS-109's hole dial; no row answers it |
| `[BrownDunfieldPerry1994]` 3(4) 110–114 | proofs (one step a sketch) | the band question's lineage: six for every band in 1994 (*"h(2, α, β) ≥ 6 for all α, β"*, p. 113), and Erdős's question, which `[Voronov2023]` answers with seven; row 132 unaffected |

Not read, with reason: `[deGreyParts2022]` (read in § A from arXiv). LW's debt 11 is `[Soifer2019]`, which LW read; its list named the paper
twice. `[ExooIsmailescu2017]` (`χ_f ≥ 383/102`) is superseded for row 129 by `χ_f(ℝ²) ≥ 4.0487`.

## 3. Theorems this job proved (all [hand], one mind unless marked)

- **Check of GS Lemma 2, Theorem 2 and Corollary 1:** correct (two minds).
- **GS's theorem does not give link 2 for an arbitrary mean.** A counterexample shape: take a colouring proper almost everywhere, and recolour
  it to one colour on a dense null `G_δ` set. Its monochromatic set in E(2) is then comeager and Haar-null. A comeager set contains a translate
  of every finite set, so some invariant mean gives it mean 1. Link 2 follows from GS's argument with Haar averages on large balls.
- **A quantitative form of FS103-M-EASY** (not printed). Suppose `χ(ℝ²) > k` and `G` is a finite unit-distance graph that is not
  `k`-colourable. Then every measurable `k`-colouring has monochromatic unit pairs of lower density at least `1/|E(G)|` over large balls of E(2).
- **GS Conjecture 1, Definition-13 form,** by compactness (two minds, not blind).
- **Kainen's robustness conjecture ⟺ `χ(ℝ²) = 7`, given `[Voronov2023]` Thm 1.1.** Every band graph `G(u)` contains a closed band, so
  `χ(G(u)) ≥ 7`. Kainen's Theorem 1 gives `χ(G(u)) ≤ 7` for `u ≤ (√7 − 2)/(√7 + 2)`. So "some `u > 0` has `χ(G(u)) = χ(ℝ²)`" holds exactly
  when `χ(ℝ²) = 7`.

## 4. Drafts for the owner (none applied)

**`CLOSED-QUESTIONS.md` §3 (drafts).**
- (a) **LW's entry for `[Polymath2021]` p. 199, with this scope:** "answered in the complementary direction only (row 134: criterion (i)
  dropped and every radius-1 arc forbidden, for segment-and-arc maps a.e.); FS-112's NO would answer it as posed, for locally finite
  segment-and-arc tilings, whatever reading of (i)."
- (b) **`[Kainen1992]` Conjecture (2), "The chromatic number of the plane is robust"** — *reduced, not answered:* given `[Voronov2023]`
  Thm 1.1 it is equivalent to `χ(ℝ²) = 7`. Given MR, its measurable analogue is row 131's `lim µ₆(ε) < 1` read as stability.
- (c) **Posed and open, no row answers them:** `[Soifer1994X6]` (find X₆); `[HoffmanSoifer1993]` (find `χa`); Kuperberg's 2 × n question
  (`[Johnson2018]` p. 90).
- (d) **Erdős's `h(2, α, β)`** (as quoted by `[BrownDunfieldPerry1994]` p. 113) is answered by `[Voronov2023]` and not by us. If §3 lists only
  questions our rows answer, omit it.
- (e) **GS Conjecture 1:** hold as LW proposed; now two minds, not blind.

**`LEDGER.md` (drafts).**
- **Row 130's prior-art line** (replacing LW's draft): "the argument of `χ(ℝ²) ≤ χ_m⁰(ℝ²)` (N-EASY) is in print as `[GwynStavrianos2022]`
  Lemma 2 / Theorem 2 / Corollary 1. There it is stated for badness under an invariant mean on E(2) (infimum 0 suffices, every colouring,
  quantitative `1/|E(G)|`); N-EASY follows with Haar averages in place of the mean, a step not printed. The averaging device is
  `[Polymath16wikiProb]`'s (2018–19)."
- **FS103-M-EASY's prior-art line** in `plans/FS103-derivation.md:114`: the same.
- **Row 131:** LW's hole-filling remark, unchanged. Add: "`[Kainen1992]`'s robustness conjecture is the everywhere form of the band question.
  Given `[Voronov2023]` Thm 1.1 it is `χ(ℝ²) = 7`."
- **Row 132's prior art:** "six for every band is `[BrownDunfieldPerry1994]` Thm 9 (1994), after Erdős's question (1985). The seven-colour
  upper half of Voronov's Cor. 1.1 is `[Kainen1992]` Thm 1."
- **Row 134's prior art:** LW's line, plus "`[Parts2021]` p. 181 uses the tactic ('wavy sides') and measures it saving two colours at `m = 6`".

**`CLAUDE.md` (drafts).**
- **§ The aim, link 2:** "; its argument in print as `[GwynStavrianos2022]` Thm 2 (invariant-mean badness), from which it follows with Haar
  averages".
- **§ Paths forward, FS-112's row:** "posed in print (`[Polymath2021]` p. 199, 'eliminate the unit-radius tactic'); one exact known positive,
  `[AxenovichEtAl2014]` Thm 4.2's strip; the tactic measured saving colours in multi-fold tilings (`[Parts2021]` p. 182)".
- **FS-109's row:** "a second dial: `[Soifer1994X6]`'s X₆".

**Stub banners (drafts).**
- `plans/STUB-unit-arc-half.md`: the printed question and its scope (§ 0), the strip as the one exact positive, and `[Parts2021]`'s wavy
  sides under "Registered expectations".
- `plans/STUB-hole-dial.md`: X₆ as a second dial (`[Soifer1994X6]`, `[Mundinger2024]`).

**`BIBLIOGRAPHY.md` outside § G (drafts, rule 0b).**
- **§ C row `[HoffmanSoifer1993]`:** held now (`library/geombinatorics/geombinatorics-v03-n2-1993-10.pdf`) and read in full; the
  correction unread.
- **§ A rows:** `[Parts2021]` read in full (it is a named-only row in rule 0d's "Nice to have" list; take it off); `[Parts2022]` read in full.
- **§ C row `[Johnson2018]`:** pp. 87–91 read.
- **§ B:** lines for the three new files, or the § G pointer, which covers them now.

## 5. Debts left

- **Older, ranked** (§ G's "Older, flagged and not read"):
  1. the Hoffman–Soifer correction, 3(3) 102 — not held; issue 11;
  2. Soifer 2003, "…II: polychromatic number and 6-coloring", 12(4) 191–216;
  3. the set-theory cluster (Shelah–Soifer 2003, 2004; Soifer 2007 on Solovay's model; Delahaye–Cook 2006), which bears on links 1–2 and
     FS-104's ZF + DC audit;
  4. Brown–Dunfield–Perry I (held) and II;
  5. Fisher–Ullman 1992 and Hochberg–O'Donnell 1993 (row 129's history);
  6. the rational-points papers;
  7. Kloeckner, Malen and Maier (2015).
- **Recent, from LW's list:**
  1. Sirgedas XXX(3) 138–151 (render 14 pages);
  2. Soifer 2018 XXVIII(1) 5–17;
  3. Krizan XXVI(4);
  4. the maps pair (Soifer XXXVI(1), Xie XXXIII(2));
  5. the witnesses' journal copies;
  6. Ellison–Johnson XXIX(2).
- **The Polymath16 wiki page's Lemmas 1–40** (text saved at `lw/lw2/polymath16-wiki-probabilistic-formulation.txt`).

## 6. Gates and incidents

- `python3 tools/bib_audit.py`: exit 0 after each stage that edited `BIBLIOGRAPHY.md` (stages 0 and 2), read directly.
- `CATALOGUE.md` and `lw/catalogue.md`: identical (`cmp`).
- **Fetches:**
  - Three through the wrapper, one at a time, each exit 0.
  - `pgrep -f geomb_fetch.py` matched its own shell (the self-match rule, `CLAUDE.md` § Building). The check used `ps` on the process name
    instead.
  - The first file landed in `lw/lw2/` by mistake. It was moved to the library and never committed.
- **Slip:** stage 0's commit (`6a8d9ead`) took in job LP's uncommitted § R edits to `BIBLIOGRAPHY.md`, because a commit by path takes the whole
  file. Nothing was lost; LP's § R lines are in that commit under my subject. Before stage 2's commit I checked the diff was mine only.
- Theorems this phase proved: § 3.
