
**4.3 `CLAUDE.md` drafts, each in current-state wording** (the front page applies them in place; old text from `CLAUDE.md` at 304,245 bytes).

*D-C1 — § The aim, link 4 (replaces "4. **Regular colourings need seven in print.** … and Thm 1.1 applies."):*

<!--D-C1-->
4. **Regular colourings need seven, verified and almost everywhere** (row 132). Closed colour classes need seven (`[Voronov2023]` Thm 1.3: six
   closed sets covering a disc of radius 3 realize the unit distance; closedness enters once, as compactness giving a band), and so does any
   colouring with slack (Thm 1.1) — proofs repaired locally, the paper an unrefereed preprint. Almost everywhere, boundaries free: slack needs
   seven; polygons and locally finite convex tilings need seven bar one edge case (`d = 2`), `[SokolovVoronov2025]` repaired, its map theorem a
   GAP at the fills; nice maps need seven (`[Thomassen1999]`). Maps need six: `[Woodall1973]` Thm 6 and Townsend's manuscript, each repairing
   the other (`[Townsend1981]` prints no proof); `[Coulson2004]`'s six is for tiles with an area bound.
<!--/D-C1-->

*D-C2 — § The aim, link 5 (the owner's ruling, item 77; replaces "5. **So, given MR, Hadwiger–Nelson is one question: …** … since 1950."):*

<!--D-C2-->
5. **So, given MR, Hadwiger–Nelson is one question: can vanishing holes save a colour?** With no MR, `χ_m⁰(ℝ²) ≥ 7` iff six classes, each
   free of monochromatic pairs at distances in `[1−ε, 1+ε]`, cannot cover the plane up to holes of density tending to 0 as `ε → 0` (row 131;
   `[SokolovVoronov2025]` §9's hypothesis). A refutation needs no wild set: it is a sequence of periodic grid-square colourings, wild only in the
   limit, whose normal form FS-103 holds. Both answers decide the problem. *No* — Voronov's contradiction survives a free colour of vanishing
   density — gives `χ_m⁰(ℝ²) = 7`, hence `χ(ℝ²) = 7` given MR. *Yes* — such a sequence, with six or five colours — gives `χ(ℝ²) ≤ 6`, or
   `= 5`, **with no MR**: the first move of the upper bound since 1950.
<!--/D-C2-->

*D-C3 — § The aim, link 6 (replaces "6. **Its tools are Voronov's topology …** … along every optimal family."):*

<!--D-C3-->
6. **Its tools are Voronov's circle topology made robust, and the density topology** — the room after ergodic theory in G30's ladder. Two
   proof shapes are closed (row 131): counting holes met by circles caps at `O(ε)`, and trichromatic points vanish from partial colourings; the
   index of density traces fails where a unit-arc interface faces a bowtie (row 132). A reading, with its test: finite perimeter is
   Lipschitz-in-probability, the quantitative form of the continuity every CP colouring has. Killing test: a CP colouring whose disagreement
   `P(c(0) ≠ c(h))` is continuous but not `O(|h|)` along every optimal family.
<!--/D-C3-->

*D-C4 — § The aim, the program paragraph (replaces "**The program** (`plans/STUB-regularity-wall.md`): … the map argument."):*

<!--D-C4-->
**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability: can vanishing
holes save a colour?** — competitor R proves Voronov's contradiction survives a free colour of vanishing density, competitor W builds periodic
grid-square slack six-colourings with vanishing holes, each checked exactly, an advisor between them (`plans/PROTOCOL-competitor-and-advisor.md`);
**Lean throughout** — MR in full (Einsiedler–Lindenstrauss, Einsiedler–Fish), the collapse, the measurable chain, the map argument.
<!--/D-C4-->

*D-C5 — § Frontier, "Last updated" (replaces the whole italic paragraph beginning "*Last updated: 2026-09-26"):*

<!--D-C5-->
*Last updated: 2026-09-27 — **FS-106, the regular half, closed** (rows 131–132; `plans/FS106-regular-half.md` §R-close): the regular classes
verified and transferred almost everywhere bar named steps, and the measurable question restated as stability, `χ_m⁰ ≥ 7 ⟺ lim µ₆(ε) < 1`;
FS-107 renamed. Before it, **the reframe** (Kooshi, 2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No finite-witness
search runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*
<!--/D-C5-->

*D-C6 — "Where the problem stands", item 31 (replaces "31. **The regularity wall** … FS-106 is that verification."):*

<!--D-C6-->
31. **The regularity wall, verified; the question is stability** (§ The aim; rows 131–132; FS-107). Regular classes need seven almost
   everywhere — slack, polygons and convex tilings (bar `d = 2`), nice maps — and maps six; closed classes are the tight question itself. With
   no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131): given MR, Hadwiger–Nelson is whether vanishing holes can save a colour, and a refutation is
   a sequence of periodic colourings, never a wild set. Bearing on the answer: none moved; the question restated exactly.
<!--/D-C6-->

*D-C7 — § Paths forward, "Open milestones" (replaces the paragraph beginning "**Open milestones, in order.**"):*

<!--D-C7-->
**Open milestones, in order.** **None is open.** FS-106, the regular half, is **closed** (rows 131–132; `plans/FS106-regular-half.md`
§R-close). **Next: FS-107, stability: can vanishing holes save a colour?** (the owner's rename, 2026-09-27; `plans/STUB-regularity-wall.md`
§ FS-107); the finite-witness-free week runs to 2026-10-01 (§ Toolchain). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays
paused behind it. Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list.
<!--/D-C7-->

*D-C8 — § Paths forward, ranked rows 1–4 (replace rows 1–3; old rows 4–29 become 5–30, the tail "30–62" becomes "31–63"):*

<!--D-C8-->
| 1 | **FS-107 stability: can vanishing holes save a colour?** — `plans/STUB-regularity-wall.md` § FS-107 (renamed 2026-09-27; the competitor protocol) | link 5 in row 131's form. R: for some radius `R` and `δ₀ > 0`, every partial six-colouring of `U_R` with no monochromatic pair in the band leaves `δ₀|U_R|` uncovered, for every `ε` — Voronov robust to a free colour of vanishing density, counted non-locally; W: for every `δ`, a periodic grid-square six-colouring with a band and holes of density `≤ δ`, checked exactly; shared constraints and a break table (A2 §3) | decisive both ways: R gives `χ_m⁰ = 7`, so `χ(ℝ²) = 7` given MR; W gives `χ(ℝ²) ≤ 6` with no MR; a named obstruction on either side is a result |
| 2 | **FS-104 `χ_CP(ℝ²)` at six** — `plans/STUB-cp-plane-six.md` | is `χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6` (row 130)? — row 131's question at five colours; its null-set step to Falconer's `χ_m` is FS-107's sub-question; standing here: `χ_B`, the ZF + DC audit (Soifer's Open AC Problem 62.14), the density family, `k`-point correlations (FS-80) | decisive: given MR it is rung D (row 128); success low, a named no-go the likely product |
| 3 | **FS-109 the hole dial** — `plans/STUB-hole-dial.md` (post-ban) | trace `1 − µ₆^per(ε)` as `ε → 0` along eroded `[Parts2020c]` tilings and along W's families: flat near `10⁻⁴` is R's evidence, falling is W's | a dial on FS-107's question, informative both ways; decides nothing alone |
| 4 | **FS-108 the print residuals of the regular half** — `plans/STUB-regular-half-residuals.md` | S–V Thm 2's `d = 2` edge case; a second mind on its Lemma 3 at `√3 ≤ d < 2`; S–V Thm 1's fills under Condition 6 by Woodall's step-3 merge, and his cone at six colours; Townsend's (c) filled in full; `[Townsend2005]` against the manuscript | none on the answer while it holds (row 131 makes regular classes constraints); a counterexample at `d = 2` is a polygonal six-colouring, `χ(ℝ²) ≤ 6` with no MR |
<!--/D-C8-->

*D-C9 — a new grokking, after G81 (the §PA sweep's first recognition):*

<!--D-C9-->
* **G82 — The measurable question is a stability question: a refutation is regular, and only its limit is wild. [hand, two minds, one blind
  (row 131); the reading one mind]** A weak-* limit of near-colourings is a colouring (the circle measure is Rajchman), so `χ_m⁰ ≥ 7` is the
  stability of a regular theorem: W's objects are periodic tilings checked exactly, and R must count a defect non-locally, Voronov's
  contradiction being feature-local. *Do: when a question asks whether a class of colourings exists, ask whether its limit object is a weak-*
  limit of regular near-solutions; if so, pose it as stability, build on the regular objects, and test a stability proof against strips and
  erosion (row 131's no-gos) first. Nothing kills the equivalence; it forbids a construction needing a wild set. Killing test of the reading:
  a feature-local proof of `lim µ₆(ε) < 1`.*
<!--/D-C9-->

*D-C10 — G71, one sentence appended before its "*Do:*" (the §PA sweep's second recognition):*

<!--D-C10-->
The index of a density trace (row 132) is this height on a curve; its bound between complementary curves fails only at a swap, which a
unit-arc interface facing a bowtie forces: Condition 5 buys general position, not the height.
<!--/D-C10-->

*D-C11 — G72's count (replaces "**The count so far — thirteen of fifteen** … from reading and from re-deriving a known proof."):*

<!--D-C11-->
**The count so far — thirteen of sixteen** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72;
the latest, FS-106, the other kind: its headline from extending row 130's compactness, its structural form yielding lemmas and a no-go).
<!--/D-C11-->

*D-C12 — G79's record (replaces "Its record, milestone by milestone: `plans/GROKKING-INSTANCES.md` §G79. FS-103: … produced no theorem."):*

<!--D-C12-->
Its record, milestone by milestone: `plans/GROKKING-INSTANCES.md` §G79 (FS-106: the headline from an example invariant, the walls from
counterexample invariants).
<!--/D-C12-->

