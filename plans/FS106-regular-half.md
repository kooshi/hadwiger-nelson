# FS-106 — the regular half: plan (job FS106-P)

*Job FS106-P (de Bruijn, planner), Opus 5.5, 2026-09-26. Brief `data/fs106/briefs/P106-planner.md` with `data/fs106/briefs/STANDING-RULES.md`.
Advisor: Poros (job FS106-A). The stub is `plans/STUB-regularity-wall.md` § FS-106. Frame: `CLAUDE.md` § The aim and § Counter-priors (read
from disk first). Grades are `CLAUDE.md` § Notation's. The fixed claim list is `data/fs106/claims.md`; job briefs are `data/fs106/briefs/`.*

## Theorems this phase proved

- None. This is a planning job; every mathematical statement below is a claim for the jobs, or a planner's reading graded as such.

## Would-have-searched-here log

- Stage 1: none (reading only).

## Stage 1 — SAVED: quotation check, first-hand reading notes, §G part 1 (G1–G81)

### 1.1 Quotation check (standing rule 5)

| # | quotation in the brief | source checked on disk | result |
|---|---|---|---|
| Q1 | "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim, l. 76–77 | verbatim (the brief stops before the parenthesis "(Anything we do must be formalized …)"; nothing lost for this job) |
| Q2 | "Let's see some ambition. I know we can do it. Look at what you've done in just the last couple days, and we've already reduced it to a single set of fields!" | `CLAUDE.md` § Counter-priors, l. 119–121 | verbatim |
| Q3 | closed classes need seven, "`[Voronov2023]` Thm 1.3" | the PDF, p. 3: "Suppose that the disc of radius 3 defined by an arbitrary 2-dimensional norm is covered by 6 closed sets. Then at least one of these sets realizes the unit distance." | matches; the theorem is local (a radius-3 disc) and for every norm |
| Q4 | band-avoiding colourings, "(Thm 1.1)" | p. 2: "For any 2-dimensional norm ∥ · ∥U and ε > 0 it holds that χ[1−ε,1+ε] (R2 ; U ) ≥ 7." | matches |
| Q5 | nice maps, "`[Thomassen1999]`" | unheld; Voronov's gloss (p. 3): "7 colors are required for a map-type coloring of the two-dimensional surface with some metric, if the diameter of the surface is large enough, all the regions are simply connected, the diameter of each region is less than 1, and any two regions of the same color are at a distance greater than 1" | **second-hand only**; Voronov glosses it for "the two-dimensional surface with some metric", not the plane — the reading job checks the statement's setting on arrival |
| Q6 | polygons, "`[SokolovVoronov2025]`" | the PDF, p. 5: "Theorem 2. There is no polygonal colouring of the plane in 6 colors, i.e. χpoly (R2 ) = 7." with Condition 8: "Polygonal coloring of the plane is such a map-type coloring that all regions are polygons." | matches; "map-type" = Conditions 2 and 3 (Jordan, locally finite), and Condition 1 asks properness **at every point**, boundaries and vertices included |
| Q7 | maps need six, "`[Townsend1981]`, `[Townsend2005]`, `[Coulson2004]`" | `[Townsend1981]` (held since 22:51 today) p. 114: "THEOREM. Every 5-coloured map in the plane contains a monochrome unit." | **the 1981 note states the theorem and one lemma and gives no proof** ("The proofs of the lemma and theorem need care and attention to line detail, requiring about two hundred lines of argument altogether", p. 115); `[SokolovVoronov2025]` p. 2 attributes `6 ≤ χmap` to "[12, 10]" = Woodall 1973 and Townsend **2005**, and `6 ≤ χpoly` to Coulson. So the printed proof of "maps need six" is Townsend 2005's (unheld) — logged as a prior-art item |
| Q8 | "The normal form: density-open classes, avoiding distance 1 at every point, covering the plane off a null set." | `CLAUDE.md` § The aim link 5 | matches ("each class may be taken density-open and avoiding the unit distance at every point, covering the plane off a null set (FS-103's V1 and M, D1–D5)") |
| Q9 | "Given MR, a yes to the second question is `χ(ℝ²) = 7`; a regular almost-everywhere-proper six-colouring is `χ(ℝ²) ≤ 6` with no MR" | stub links 5–6; `CLAUDE.md` link 5 | matches in substance; the second half is FS103-N's N-EASY / PA1's (E), [hand, two minds] |
| Q10 | § The aim link 4: "An almost-everywhere-proper colouring with slack needs seven outright: move it by a random rigid motion, as in link 2, and Thm 1.1 applies." | `CLAUDE.md` l. 94–95 | **a claim, not a held result**; "with slack" has two readings (null monochromatic pairs in the band for `Leb ⊗ Leb`, or for `Leb ⊗ σ_d` at every `d` in the band) and the random-motion route needs the second or an averaging step; filed as claim C-AE-SLACK, with FS103-M's D4 as the other route |

### 1.2 First-hand reading notes (enough to state the claims; not a verification)

- **`[Voronov2023]`** (`~/source/library/pdf/arXiv-2304.10163-voronov.pdf`, v3, read in full today for statements and the proof's skeleton).
  The proof of Thm 1.1 is: Prop 2.1 (discretise to hexagon tiles of diameter `h`, `2h < ε`) → Obs 2.2–2.3 (monochromatic regions 1-connected)
  → Lemma 2.2 (a trichromatic point within distance 1 of any point) → Prop 2.2 (trichromatic points with disjoint multicolours are `≥ 2 + 2ε`
  apart) → §3 (the circle about a trichromatic point is properly 3-coloured in the complementary colours; cyclic reduction, Prop 3.2; three
  points of each two-colour multicolour pairwise more than 1 apart, Props 3.3–3.4) → §4 (the index of complementary arcs, Prop 4.1) → §5 (the
  bicycle, Thm 1.2) → Lemma 6.1 (two trichromatic points with one multicolour at distance in `(1, 2)`) → contradiction. **Thm 1.3's proof**
  (p. 14) colours each hexagon of diameter `ε/3` by a closed set it meets, applies Thm 1.1's argument on `U₃(0)`, and takes a limit of
  monochromatic near-unit pairs: "the distance from each of the points x∗, y∗ to the closed set Ai is less than εj … and x∗ ∈ Ai, y∗ ∈ Ai,
  ∥x∗ − y∗∥ = 1". **Closedness is used there and, as far as this reading sees, nowhere else.**
- **`[SokolovVoronov2025]`** (held, read today for this question). **The exact-distance transplant of Voronov's method is in print here**, for
  maps (Conditions 1–5: proper at every point, Jordan boundaries, locally finite, and "fa": every boundary meets every unit circle in finitely
  many points). Slack is replaced by: Props 1–4 (curves of one colour; a monochromatic point's colour is absent from the multicolour of every
  point at distance 1), **Lemma 1** ("There do not exist two bichromatic points with the same multicolor that are exactly one unit apart" — its
  proof colours the two points), Lemma 2 (no chromaticity ≥ 4), **Props 9–11 and Corollary 2** (a trichromatic point `u` has, in every
  neighbourhood of `ω(u)`, a closed curve around `u` in the three complementary colours — the deformed annulus that replaces "the circle is
  coloured in the other three colours"), Cor 3, Lemma 3 (the index argument, Prop 12, on curves at distance exactly 1), Lemma 4. **Its §9
  conclusion** says the unit-arc condition is a matter of the area `S(ε)` one must delete to recover a forbidden interval (`Ω(ε²)` without unit
  arcs, `Ω(ε)` with them) and: "if any upper bound µ(C1 ∪ · · · ∪ C6 ) ≤ µ∗6 < 1 on the fraction of the plane that can be correctly colored in 6
  colors with forbidden interval [1− ε, 1 + ε], ε > 0 were established, it would follow definitively that χmap (R2 ) = 7." Its **Question 2**:
  "Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if
  trichromatic vertices of degree greater than 3 are allowed?"
- **`[Townsend1981]`** (held, read in full: two pages). Theorem as in Q7; Woodall's lemma is refuted by an annulus sector split by "the arc of
  unit radius centre a" — **a unit-arc boundary**, the same feature `[SokolovVoronov2025]` must forbid; the replacement lemma is on "finitely
  disconnected unit annuli". No proof in the note.

### §G — the re-grokking (WORKFLOW 3.1), part 1: G1–G81

*Verdicts: **bears** (→ the phase it changes, §G part 3), **silent** (why), **falsifiable here** (a registered prediction). The milestone's object:
colourings of `ℝ²` proper almost everywhere, their regular classes, and Voronov's circle method on density-open classes.*

- G1 field wall — silent: arithmetic of finite graphs; FS-106 is archimedean (no field enters after row 128).
- G2 rings about rotation centres — silent: construction grammar of witnesses.
- G3 radially crystal — silent: witness anatomy.
- G4 one shell vocabulary — silent.
- G5 1-sum — silent.
- G6 hexagram is fabric — silent.
- G7 type-M family — silent: rotations of finite graphs.
- G8 direction group — silent.
- G9 rigidity at the forcing level — silent (finite graphs); its "hunt one rung below the top" form bears weakly on §IQ (ask what every colouring carries at five and six colours, not only whether six exists).
- G10 distributed forcing — silent.
- G11 Moser subgraph unnecessary — silent.
- G12 quadrature law — silent.
- **G13 fan ladder — bears**: Voronov's circle about a trichromatic point is a fan (the unit circle about a point avoids every colour seen at it); its a.e. form is FS103-M's D1 (a positive-density colour at `x` is absent from density points at distance 1) → Phase T (name D1 as the measurable fan; claim H-D1).
- G14 width without degree — silent.
- **G15 pigeonhole × kill — bears**: Voronov's proof factors — Lemma 6.1 is the pigeonhole (two trichromatic points, one multicolour, distance in `(1,2)`; or disjoint multicolours within 2), the bicycle (Thm 1.2) and Prop 2.2 the kills → Phase T must transfer both acts separately; claims C-T-PIG and C-T-KILL.
- G16 distance-2 pigeonhole — bears weakly: Prop 2.2 / S–V Cor 3 are distance-2 statements (disjoint multicolours cannot sit within 2) → Phase T, the kill at distance `< 2`.
- G17 globality at the top rung — bears: Voronov's and S–V's arguments are local (a radius-3 disc) → every a.e. claim is stated on a bounded disc as well as on the plane (Phase R, the claim forms).
- G18 composition — silent (solver).
- G19 5-tight fabric — silent.
- **G20 brick colourings, boundary-tight by force — bears**: tight seven-colourings exist (cell diagonal exactly 1), so "tight" is no obstruction to seven; positive control for every a.e. claim: it must not refute the tight hexagonal/brick 7-colourings → Phase R/T controls.
- **G21 a negative measures its enumeration — bears**: "the regular half transfers" is the flattering outcome (standing rule 4); every GAP or TRUE graded with the acceptance test's scope; the blind second mind audits a TRUE at the rate of a FALSE → all phases.
- **G22 where a six-colouring cannot live — bears**: no cell-constant or polygonal six-colouring (`[SokolovVoronov2025]`), classes non-polygonal and finer than 1/2 — the a.e. form of each is a claim (C-AE-POLY) and W's constraint list for FS-107 → Phase R, and the FS-107 hand-over.
- G23 refining is not a route down — silent.
- **G24 integrality — bears**: relaxations stop below the integer; row 129's five is one class at a time → the transfer must read how classes fit (topology), never class sizes → Phase T (no per-class density route is registered).
- G25 recursive forcing ladder — silent.
- G26 six-target (√3 and 2) — silent (finite gadgets); the measurable six-question is row 130's.
- G27 hidden arithmetic symmetry — silent.
- G28 fine tail factors — silent.
- **G29 cell family closed; limit lemma — bears**: row 41's limit lemma (bounded families within `ε` of 1) is the kernel's form of Thm 1.3's compactness step; Voronov's radius-3 disc was compared with ours → Phase R (the closed-set step, claim C-CS-1) and the Lean note.
- **G30 derivation kills; the discipline ladder — bears**: the next rooms are continuum topology (Voronov's index) and geometric measure theory (density topology, finite perimeter); write the question for a stranger (the claim list) → §PA's disciplines; §IQ.
- G31 no compulsion in held witnesses — silent.
- G32 two-distance dial — silent.
- G33 batches compose — silent.
- G34 field is the selection — silent.
- G35 wall is 2-adic — silent.
- G36 residue colouring canonical — silent.
- G37 endgame's shape — silent.
- G38 linear thresholds — silent.
- G39 redundancy before rigidity — silent.
- G40 absorption — silent.
- G41 additive colourings — silent.
- G42 additive rigidity — silent.
- G43 residue plane seals — silent.
- G44 Kloosterman — silent.
- G45 lift — silent.
- **G46 recognize the classical theory — bears**: recognition sentence for §PA: Voronov's index is the degree (winding) of a 3-colouring of a curve lifted to the 3-cycle's universal cover; its measurable replacement lives in the theory of approximately continuous functions and traces of density-open sets; `[SokolovVoronov2025]` is the exact-distance transplant → §PA queries; Phase T's first step is to read S–V's replacements against the normal form.
- G47 compulsion face of sealing — silent.
- **G48 tightness mechanism; the conjecture — bears (frame only)**: given MR the bold form at the collapse fields is HN itself; FS-106's *No* is `χ_m⁰ = 7` → frame line in the plan; nothing in phases.
- **G49 prior-art gate — bears**: search in the discipline's words (measurable colourings, density topology, forbidden interval, map-type colourings), the posers' listings (Voronov, Sokolov, Townsend, Woodall, Thomassen, Coulson, Parts, Falconer, Croft) → §PA.
- **G50 read what the search found — bears, and fires**: `[SokolovVoronov2025]` was held and "read" at FS-18 for the cell family; its exact-distance transplant (Props 1–17), its §9 remark (the deleted area `S(ε)` and `µ∗₆ < 1`) and its Question 2 — each bears on link 5 — were never drawn; likewise `[CurrieEggleton2016]`'s six superseded by Voronov's seven (inventory item 3) → an instance for `plans/GROKKING-INSTANCES.md` §G50 (proposed at the close).
- G52 wall breaking not sufficient — silent.
- G53 counting compulsion — silent.
- G54 tight or slack (Hoffman) — silent; the word "tight" here is Hoffman's, not link 5's (no band avoided) — a naming note for the claim list.
- G55 unit-vector ring; chain — silent.
- G56 the window for six — silent.
- G57 triangle-free window — silent.
- G58 antipodal conjecture — silent.
- G59 wall at six — silent.
- **G60 fractional caps — bears**: density alone caps at 4.36 (row 129) → Phase T registers no route that bounds one class's density; FS-107's W constraint (each class `≤ m₁ ≤ 0.2470`).
- G61 three colours at arithmetic — silent.
- G62 twisted bilayers — silent.
- G63 transcendence free — silent.
- **G64 six may be skipped — bears (sentence discipline)**: keep S and W apart; "seven is forced" never inferred from six being skipped → the claim list's wording.
- G65 refusal phase diagram — silent (search banned; no balls).
- G66 tower — silent.
- **G67 grokked by form — bears**: every claim written with what it forbids or what kills it → the claim list's format.
- G68 quotient before ball — silent.
- G69 rigidity arithmetic — silent.
- G70 √3-clean is residue — silent.
- **G71 three colours are linear — bears, strongly**: `K₃`'s universal cover is a line; Voronov's index (Def 4.2, Prop 4.1) and S–V's line `l_{1,2,3}` with "c(x) = (⌊x + 1/2⌋ mod 3) + 1" (Def 6) **are** the height of a 3-colouring of a path — Chandgotia's height in one dimension; the method works at six colours because the circle about a trichromatic point sees exactly three colours → §IQ's invariant; Phase T's central claim C-T-IND (a height for density-traces).
- G72 invariant question — bears → §IQ.
- G73 four colours cell by cell — bears weakly: at four colours there is no height; Voronov's circle colourings are 3-colourings, so the height exists exactly where he uses it → §IQ note (six = 3 + 3).
- G74 layers — silent.
- G75 triangles pin the spectrum — silent.
- G76 four-colour rigidity over a field — silent.
- G77 character colourings — silent.
- G78 rank-one Kempe — silent.
- **G79 example invariant — bears**: the walls in print arrive as counterexample invariants (Townsend's unit-arc counterexample to Woodall's lemma; S–V's Question 2; M's non-list-colourable boundary configuration); the flip — what every a.e.-proper colouring carries at its circles — is §IQ → §IQ, Phase T.
- G80 infinite rank — silent (MR's input).
- **G81 the field is the plane — bears (frame)**: given MR every question left is archimedean → FS-106 spends nothing field-specific.
- **G51 competitor and advisor — bears**: blind second minds on every derivation; the competition proper is FS-107; within FS-106 a competitor pays where two routes to the heart are live (C-T via S–V's exact-distance transplant, C-Q via stability) → Phase T staffing.

## Stage 1 — SAVED
