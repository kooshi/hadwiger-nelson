# FS-106 — the regular half: plan (job FS106-P)

*Job FS106-P (de Bruijn, planner), Opus 5.5, 2026-09-26. Brief `data/fs106/briefs/P106-planner.md` with `data/fs106/briefs/STANDING-RULES.md`.
Advisor: Poros (job FS106-A). The stub is `plans/STUB-regularity-wall.md` § FS-106. Frame: `CLAUDE.md` § The aim and § Counter-priors (read
from disk first). Grades are `CLAUDE.md` § Notation's. The fixed claim list is `data/fs106/claims.md`; job briefs are `data/fs106/briefs/`.*

## Theorems this phase proved

- None. This is a planning job; every mathematical statement below is a claim for the jobs, or a planner's reading graded as such.

## Would-have-searched-here log

- Stage 1: none (reading only).
- Stage 2: none (reading only).
- Stage 3: none; the gate is reading and database queries, no search for a finite witness.
- Stages 4–5: none.

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

## Stage 2 — SAVED: §G part 2 (every row's mechanism; the method rules) and part 3 (the extraction)

### §G part 2a — `LEDGER.md` rows 1–130 (§ A read from disk: every row's headline; rows 40, 41, 128–130 in full)

- row 1 — bears (control): the two circles about a point 3-colour at exact distance — exact-distance circle systems do not force what Voronov's slack bicycle forces; the transfer must use density, not the exact graph alone → Phase T control.
- row 2 — silent: seam arithmetic.
- row 3 — bears weakly: coverage monotone — the fan form of D1 → Phase T wording.
- row 4 — bears: fan ⟺ coverage is the form of 'the circle about x avoids P(x)' → Phase T (D1 as the fan).
- row 5 — silent.
- row 6 — silent.
- row 7 — silent.
- row 8 — silent.
- row 9 — bears weakly: a compulsion on circles at exact distance — a model of what a circle-trace invariant looks like; no transfer.
- row 10 — silent.
- row 11 — silent: strip automaton.
- row 12 — silent.
- row 13 — silent.
- row 14 — silent.
- row 15 — silent.
- row 16 — silent.
- row 17 — bears weakly: circle–circle intersection trichotomy = Voronov's Property 1 in the Euclidean norm (kernel) → Lean note.
- row 18 — silent.
- row 19 — silent.
- row 20 — silent.
- row 21 — silent.
- row 22 — silent.
- row 23 — silent.
- row 24 — silent.
- row 25 — silent.
- row 26 — silent.
- row 27 — silent.
- row 28 — silent.
- row 29 — silent.
- row 30 — silent (finite mechanism hunt).
- row 31 — silent.
- row 32 — bears weakly: hex-shell K₇ ({1,√3,2}) — a distance-set six-target; no measurable content.
- row 33 — bears (control + Lean): the boundary-tight 7-colouring in the kernel — tight seven exists; every a.e. claim must leave it standing → controls; Lean home of seven's upper half.
- row 34 — bears: coset colourings need 7 (floor via `[SokolovVoronov2025]`) — a regular class held in the kernel; its a.e. form is automatic (open cells) → Phase R note.
- row 35 — bears: cell-constant colourings need 7 — the a.e. form (boundaries free) is the regular class 'cell-constant a.e.' → claim C-AE-CELL folded into C-AE-POLY.
- row 36 — silent (scale).
- row 37 — silent.
- row 38 — silent.
- row 39 — silent (finite cores).
- row 40 — bears: the family's ≥ 7 is conditional on `[Voronov2023]` Thm 1.1 and `[SokolovVoronov2025]` — FS-106's verification discharges or corrects row 40's condition → Phase V output line for the close.
- row 41 — bears: the limit lemma (bounded families within ε of 1 ⟹ χ ≥ k+1) is the kernel's form of the compactness step of Thm 1.3 → claim C-CS-1, Lean note.
- row 42 — silent.
- row 43 — silent.
- row 44 — silent (finite dial).
- row 45 — silent.
- row 46 — silent.
- row 47 — silent.
- row 48 — silent.
- row 49 — silent.
- row 50 — silent.
- row 51 — silent.
- row 52 — silent.
- row 53 — silent.
- row 54 — silent.
- row 55 — silent.
- row 56 — silent.
- row 57 — silent.
- row 58 — silent (forcing gadgets).
- row 59 — silent.
- row 60 — silent.
- row 61 — silent.
- row 62 — silent.
- row 63 — silent.
- row 64 — silent.
- row 65 — silent.
- row 66 — silent (fan gap on finite planes).
- row 67 — silent.
- row 68 — silent.
- row 69 — silent.
- row 70 — silent.
- row 71 — bears weakly: fractional blow-up caps at 4.36 — no density route to six (with row 129).
- row 72 — silent.
- row 73 — silent.
- row 74 — silent.
- row 75 — silent.
- row 76 — silent.
- row 77 — silent (audit).
- row 78 — silent.
- row 79 — bears: the height lift (three colours linear) is the index Voronov uses — row 79's mechanism in one dimension → §IQ.
- row 80 — bears: four colours have no height — the method's index lives only on 3-coloured curves → §IQ note.
- row 81 — silent.
- row 82 — silent.
- row 83 — silent.
- row 84 — silent.
- row 85 — silent.
- row 86 — silent.
- row 87 — silent.
- row 88 — silent.
- row 89 — silent.
- row 90 — silent.
- row 91 — silent.
- row 92 — silent.
- row 93 — silent.
- row 94 — silent.
- row 95 — silent.
- row 96 — silent.
- row 97 — silent.
- row 98 — silent.
- row 99 — silent.
- row 100 — silent.
- row 101 — silent.
- row 102 — silent.
- row 103 — silent.
- row 104 — silent.
- row 105 — silent.
- row 106 — silent (the stripe lemma is triangle-lattice combinatorics).
- row 107 — bears (frame): the bridge — χ(ℝ²) as a sup over fields — is how any a.e. theorem reaches χ(ℝ²) only through N-EASY and MR; nothing in phases.
- row 108 — silent.
- row 109 — bears weakly: the mixing selection's Borel/measurable format — descriptive-combinatorics vocabulary for §PA.
- row 110 — silent.
- row 111 — silent.
- row 112 — silent.
- row 113 — silent.
- row 114 — silent.
- row 115 — silent.
- row 116 — silent.
- row 117 — silent.
- row 118 — silent.
- row 119 — silent.
- row 120 — bears (frame): MR is the only input the *No* direction needs beyond FS-106 → the plan's frame line.
- row 121 — silent.
- row 122 — silent.
- row 123 — bears (frame): the five is per-class (row 129) → the six must be joint.
- row 124 — silent.
- row 125 — bears (frame): six at ℚ(√167) contains χ_CP ≥ 6 — FS-106's product feeds it.
- row 126 — silent.
- row 127 — bears (Lean lane): FS-101 is where any a.e. theorem is formalized → Lean note.
- row 128 — bears (frame): given MR the plane's number is χ_CP = χ_m⁰ → the question is FS-106's.
- row 129 — bears: one class at a time never gives six; the transfer must read the joint structure; W's per-class cap `m₁ ≤ 0.2470` → Phase T, FS-107.
- row 130 — bears, centrally: M1 (weak-* limit of fractional colourings, properness surviving by Rajchman decay), D1–D5 (density lemma, boundary lists, slack ⟹ Borel, slack costs a colour), the null-set GAP — Phase H re-verifies D1–D4; M1's compactness is the tool of claim C-Q-COMP.

### §G part 2b — the method rules (`CLAUDE.md` § Grokkings [method], § The standard of evidence, § Building, § The gate)

- Standard of evidence, "the artifact is the certificate plus the checker" — bears: the claim list is what a stranger checks; no claim rests on a figure.
- "Read the final statement aloud against the informal claim" — bears: every a.e. form is read against its everywhere form and against link 5, one hypothesis changed at a time (Phase R).
- "Write the certificate for the reviewer early" — bears: the claim list is written before any derivation; each claim names what it forbids.
- "Order a verification's steps by marginal evidential value" — bears: Phase V checks first the steps the transfer depends on (Thm 1.3's closed-set step; S–V Lemma 1, Props 9–11; Voronov Prop 4.1), the rest after.
- "Report the hunt honestly" — bears: GAP and FALSE are results (standing rule 4).
- Checkpointing (PROTECTED) — bears weakly: no long runs; each job saves by stage (standing rule 2), which is this milestone's checkpoint.
- A blocking run is killable; kill by pid; pipes; running scripts; generated modules; the kernel's cost model — silent (no processes, no builds in FS-106).
- The gate: "every theorem whose hypothesis is a structure ships a named inhabitant" — bears: every a.e. claim names a model of its hypotheses (the tight hexagonal 7-colouring; Townsend's unit-arc sector; a map with unit-arc boundaries) as its control.
- "State the uninformative outcome and confirm it is REACHABLE" — bears: §6.3's expectations name both outcomes and why each can occur.
- "A positive control proves an instrument finds things of the shape its generator can represent" — bears: a transfer argument checked only on polygonal or map-type examples says nothing about density-open classes; the controls include a non-map class (a fat-Cantor boundary).
- "Do not mistake a one-sided filter for an inverted monotonicity" — bears: D4's support colouring is one-sided (slack ⟹ Borel); a tight colouring is outside its domain, not a counterexample to it.
- "A TRUE explanation that fully accounts … will stop you looking for a second" — bears: when a step of Voronov's proof fails on density-open classes for one reason, check every other hypothesis it uses before naming the step.
- "When two numbers are compared, exactly ONE thing may differ" — bears, as a design rule: the claim ladder changes one hypothesis per rung (interval → closed → map with coloured boundaries → map a.e. → polygonal a.e. → density-open).
- "Count your generator's free parameters" — silent (no generator).
- "Enumerate the parameter first" — silent.
- "A measured half and a derived half fail in opposite directions" — silent (nothing measured).
- G21, G30, G46, G49, G50, G67, G72, G79, G51 — walked in part 1.

### §G part 3 — the extraction: each *bears* as an instruction to a phase

| from | instruction | phase |
|---|---|---|
| G13, rows 3–4, 130 (D1) | state the measurable fan: at a point `x`, every colour of positive upper density is absent from the density points of `S(x, 1)` (D1); second mind on D1–D4 | H |
| G15, G16 | transfer the pigeonhole (Lemma 6.1; S–V Lemma 4) and the kills (Thm 1.2 bicycle; Prop 2.2; S–V Cor 3, Lemma 3) as separate claims | T |
| G17 | every a.e. claim in two forms: on `ℝ²` and on a disc of radius 3 | R, T |
| G20, rows 33–35 | controls: the tight hexagonal / brick 7-colouring must survive every claim; a claim that refutes seven is misstated | all |
| G21, standing rule 4 | the blind mind audits TRUE at FALSE's rate; the acceptance test's scope in the headline | all |
| G22, G60, G24, rows 71, 129 | no route through one class's density; FS-107's W constraints carried forward | T, hand-over |
| G29, row 41 | name Thm 1.3's closed-set step exactly; note the kernel's limit lemma as its Lean form | V, R, L |
| G30, G46, G49, G50 | §PA in the discipline's words (density topology, approximately continuous functions, forbidden-interval colourings, map-type colourings, measurable chromatic number); S–V's exact-distance transplant and §9 are the nearest print | PA, T |
| G48, G81, rows 107, 120, 125, 128 | frame only: FS-106's *No* needs MR (row 120) to reach `χ(ℝ²)`; its *Yes* needs nothing (N-EASY) | plan frame |
| G64, G67 | claims worded so S and W never merge; each claim says what it forbids | claims |
| G71, G73, rows 79–80 | the index is `K₃`'s height on a path; name the invariant a density-trace must carry to have one (claim C-T-IND) | IQ, T |
| G72, G79 | §IQ: what every a.e.-proper colouring carries on its unit circles | IQ |
| G51 | blind second mind per derivation; a competitor on the heart where two routes are live (structural and quantitative) | T staffing |
| row 1 | control: exact-distance circle systems 3-colour; a transfer must use density, not the exact-distance graph on circles | T |
| row 40 | the verification of `[Voronov2023]` and `[SokolovVoronov2025]` discharges or corrects row 40's condition — an item for the close | V |
| row 127 | Lean lane FS-101 for every landed claim | L |

**The test of the re-grokking (WORKFLOW 3.1 item 3).** It changed the plan: (1) G50 fired — `[SokolovVoronov2025]`'s exact-distance transplant,
§9 remark and Question 2 re-aim Phase T from "invent a measurable replacement" to "read S–V's replacements against the normal form, and run its
§9 route quantitatively"; (2) G71 names the invariant the index is, so §IQ is not open-ended; (3) G20 and row 1 supply controls; (4) row 40's
condition becomes a close item.

## Stage 2 — SAVED

## Stage 3 — SAVED: §PA (the prior-art gate) and §IQ (the invariant question)

### §PA — searched 2026-09-26 by the planner (zbMATH Open API for discovery and reviews; Semantic Scholar and OpenAlex citing lists; arXiv abstract pages)

**PA.1 `[Voronov2023]`'s citation graph.** Its references (read, p. 15–16) hold no measurable form: the forbidden-interval line (Exoo; Currie–Eggleton;
Chybowska-Sokół et al.; Parts 2023), maps (Woodall; Townsend 2005; Thomassen), infinitesimal layers (Kanel-Belov–Voronov–Cherkashin 2018; 3-dimensional
slices, arXiv:2208.02230). **Citing works** — Semantic Scholar: five (arXiv:2512.15516 Axenovich–Liu–Sagdeev, *Ramsey problems for graphs in Euclidean
spaces and Cartesian powers*; `[SokolovVoronov2025]`; arXiv:2404.11454, canonical geometric Ramsey; arXiv:2302.09972, max-norm triangles;
arXiv:2208.02230); OpenAlex: one (arXiv:2302.09972). The two databases disagree on the list (G49's rule: identifiers compared, not counts); **no citing
work holds a measurable or almost-everywhere form of the method.** The Voronov author listing (zbMATH, 17 records 2015–2026) adds **arXiv:2607.19946,
Didin–Voronov, *The chromatic number of Euclidean space with dense color classes*** (22 July 2026): "12 dense colors suffice to color ℝ²" — a pathology-side
item for FS-107 (dense classes; measurability unstated in the abstract), not held. And Cherkashin–Voronov 2024, *On the chromatic number of 2-dimensional
spheres* (Zbl 1532.05064), not held.
**PA.2 `[SokolovVoronov2025]`'s references** (read): Woodall 1973, Townsend 2005, Coulson 2004, Falconer 1981, Manta 2021, Parts 2020 (*What percent …*,
the `1/6997` in §9), Voronov 2023, Chybowska-Sokół et al., Exoo, de Grey, Exoo–Ismailescu, Soifer. **Its §9 is the nearest print to this milestone's
heart** (Stage 1 §1.2): the deleted area `S(ε)` and the conditional "µ∗₆ < 1 ⟹ χmap = 7". Citing works: one (arXiv:2512.15516).
**PA.3 The map line, first-hand status.** `[Townsend1981]` read: a statement, a counterexample to Woodall's lemma built from a unit-radius arc, a
replacement lemma, no proof. `[Townsend2005]` (Zbl 1506.05079; zbMATH holds no review) unheld — Kooshi fetching. `[Coulson2004]` held, unread; zbMATH's
review: "if convex polygons are used as a colouring base at least 6 colours are necessary". `[Thomassen1999]` (Zbl 0986.05041, review withheld) unheld.
`[Pritikin1998]` (Zbl 0920.05027) unheld. `[Woodall1973]` held, unread.
**PA.4 The fraction line (new to this project's reading).** `[Parts2020c]` (arXiv:2010.12668, in `BIBLIOGRAPHY.md`, not held): "a tiling of more than
99.985698% of the Euclidean plane with six colors" and "any unit-distance graph of order at most 6992 … can be properly 6-colored". This is the best
known lower bound on the six-colourable fraction; a stable-Voronov theorem (claim C-Q-STAB) must leave that much room. Fetchable from arXiv.
`[Mundinger2024]` (arXiv:2501.18527; held key) — "two novel six-colorings" for the off-diagonal variant; bears on FS-107's W, not here.
**PA.5 Measurable and almost-everywhere colourings.** zbMATH `ab:"measurable chromatic number"`: 17 records — Falconer's line and its descendants
(Székely 1983; Székely–Wormald 1989; Bachoc–Nebe–Oliveira–Vallentin 2009; Oliveira–Vallentin 2010; Bachoc–Passuello–Thiery 2015; Bogolubsky–Raigorodskii
2015; Malen 2015 on spheres; `[Payne2009]`; the descriptive line: Miller 2008, Conley–Miller 2016, Bernshteyn 2019, Weilacher 2022, Higgins–Spaas–Tenenbaum
2026). All bound densities or treat Borel graphs; **none takes a regularity theorem (closed, map, polygon, interval) to its almost-everywhere form.**
`ab:"density topology"`: 243 records (Tall 1976; Lukeš–Malý–Zajíček 1986, *Fine topology methods in real analysis and potential theory*; Wilczyński 2002,
*Density topologies*; Ciesielski–Wilczyński 1995, *Density continuous transformations on ℝ²*; Filipczak–Wilczyński 2010, *Strict density topology of
the plane*) — the handbooks for Phase T's density-open classes; none meets a colouring question. `ab:"monochrome unit" | ab:"monochromatic unit"`:
4 records, none measurable. FS103-G's gate (Falconer, Croft, Payne, BDOV, Kechris–Marks) is not re-run; its negatives stand.
**PA.6 Verdict.** Not found in print: an almost-everywhere form of any of the regular-class theorems; a measurable or density-topology form of Voronov's
method; the equivalence of link 5 with S–V §9's stability question. **Found in print and not drawn before:** S–V's exact-distance transplant, its §9
and its Question 2 (G50). Queries, all run 2026-09-26: `au:"Voronov, V" & py:2015-2026`; `au:"Townsend, S"`; `au:"Coulson, D"`; `au:"Thomassen, C" &
ti:"Nelson"`; `au:"Pritikin, D"`; `ab:"measurable chromatic number"`; `ab:"density topology"`; `ti:"forbidden" & ti:"interval" & ab:"plane"`;
`ab:"monochrome unit" | ab:"monochromatic unit"`; `ti:"colouring the plane"`; `ti:"coloring the plane"`; `ab:"nice coloring"`; `ab:"map-type"`; the
`an:` reviews of Zbl 1506.05079, 1081.05022, 0458.05032, 0920.05027. OR-groups in parentheses return HTTP 404 from the API (a tool note).
**PA.7 Fetches owed** (by the reading job or Kooshi): `[Townsend2005]`, `[Thomassen1999]`, `[Pritikin1998]` (Kooshi, in flight); `[Parts2020c]`
(arXiv:2010.12668); Didin–Voronov (arXiv:2607.19946); Cherkashin–Voronov 2024; Lukeš–Malý–Zajíček 1986 §§ on the density topology (library).
**PA.8 What the gate changed.** Phase T's two routes are print-anchored: T-S reads S–V's exact-distance replacements against the normal form; T-Q is
S–V §9 made measurable. The first derivation target moves to S–V's Question 2 in its a.e. form (the advisor's order, adopted in §6).

### §IQ — the invariant question (WORKFLOW 3.3)

1. **Existence form.** Is there a Lebesgue-measurable colouring of `ℝ²` with at most six colours, proper at almost every unit pair?
2. **Structural form.** *For every almost-everywhere-proper measurable `k`-colouring of `ℝ²`, what does it carry on the unit circle about each point, as a
   function of the colours of positive density at that point, that Voronov's argument reads from a closed colouring?* Posed for `Cay(ℝ², S¹)` with any
   norm's circle (Voronov's generality), no field, no arithmetic.
3. **The invariant it forces.** Two candidates, one held and one not.
   - *Held (one mind, FS103-M's D1; the measurable fan):* the essential multicolour `P(x)` (colours of positive upper density at `x`) is absent from the
     density points of `S(x, 1)`.
   - *Not known — finding it is the milestone:* an **index** for the trace of a density-open 3-colouring along a curve — `K₃`'s height (G71), which
     Voronov (Def 4.2) and S–V (Def 6) read from finitely many bichromatic points. A density trace can switch colour on a Cantor set; the index needs a
     substitute for finiteness (a bounded-variation or approximate-continuity condition on almost every circle), or a proof that none exists.
   - The advisor's tangent form (Poros, A4, one mind): at a boundary point the unit relation linearises to "same projection onto `e`", and Prop 2.2
     survives iff the projected colour sets meet in positive length; it fails exactly at a four-way (bowtie) vertex and at interfaces tangent to a unit
     circle — S–V's Conditions 6 and 5.
4. **Route.** Derivation only (the ban; and a search could only check a derived statement).
5. **Open instances it would decide.** S–V Question 2 (maps with unit-arc boundaries and high-degree trichromatic vertices); the a.e. forms of
   Thomassen's, Townsend's, Coulson's and S–V's theorems; S–V §9's `µ∗₆ < 1`; FS103-M's null-set step (C-FMT (d)) and its hunch; Falconer's `χ_m(ℝ²) ≥ 6`;
   and, given MR, rung D.

## Stage 3 — SAVED

## Stage 4 — SAVED: the fixed claim list and the advisor's first advice

**The list** is `data/fs106/claims.md` (statements only, for blind jobs): §0 definitions (Voronov's, S–V's Conditions 1–8, FS-103's D-M and D-CP,
this list's D-NF, D-SLACK, D-AEMAP, D-MU); §1 held inputs (D1, D2, D4 one mind; M1 and N-EASY two); §2 the printed theorems to verify (V-1.1, V-1.2,
V-1.3, V-2.1, V-2.2, V-P2.2, V-4.1, V-6.1; SV-1, SV-2, SV-L1, SV-C2, SV-C3, SV-L3, SV-L4; TW-81; TW-05, CO-04, WO-73, TH-99, PR-98, PA-20 on
arrival); §3 the closed-set step (C-CS-1, C-CS-2); §4 the a.e. forms (C-AE-SLACK, C-AE-CLOSED, C-AE-POLY, C-AE-FA, C-AE-MAP6, C-AE-Q2 and
C-AE-Q2-EV, C-AE-NICE, C-AE-CONV); §5 the transfer, structural route T-S (C-T-L1a, C-T-L1b, C-T-TRI, C-T-CHR4, C-T-ANN, C-T-IND, C-T-BIKE, C-T-PIG, C-T-KILL,
C-T-TAN); §6 the quantitative route T-Q (C-Q-REM, C-Q-COMP, C-Q-EQ, C-Q-STAB, C-Q-HOLE); §7 C-ROW40.

**The rationale (never given to a blind job).** Each claim changes one hypothesis against its printed parent (§G part 2b's ladder). What each forbids:
C-CS-1 names the closed-set step as "compactness ⟹ band" — a TRUE makes the heart question "band against no band"; C-AE-SLACK forbids an a.e. slack
six-colouring; C-AE-Q2 FALSE is a six-colouring of a map with unit-arc boundaries, hence `χ(ℝ²) ≤ 6` with no MR (I-EASY); C-T-L1 is FS103-M's hunch in
S–V's form; C-T-BIKE TRUE says Thm 1.2 has no exact-distance form on two circles alone, so density must enter (row 1's control); C-Q-EQ TRUE makes link 5
exactly S–V §9's stability question; C-Q-STAB is then HN's measurable form; C-Q-HOLE is its named step. The controls every derivation runs: the tight
hexagonal / brick 7-colouring (G20, row 33) must survive each a.e. claim at seven colours; `[Townsend1981]`'s unit-arc 2-coloured sector; a density-open
class whose boundary is a fat Cantor set (a non-map shape, the "generator image" rule of § Make the gate fail).

**The advisor's first advice** (FS106-A's message, 2026-09-26, after my §G bears list; its record `plans/POROS-2026-09-26-fs106-regular-half.md`,
commit d8a6ec5f) and what I did with each:

| advice | decision |
|---|---|
| REM: state in CP form; name "the origin is a.s. a density point of its class"; say which normal form (everywhere-avoiding) | adopted in C-Q-REM (CP form, `η < 1/48` its constant) |
| COMP: band-properness is weak-* closed in spectral form; rounding keeps disjoint supports; `µ₆` monotone | adopted: C-Q-COMP (ii) and C-Q-EQ's "lim" |
| T-Q: the equivalence moves the difficulty; name "Lemma 2.2 and Lemma 6.1 with holes" | adopted: C-Q-STAB in its wording, C-Q-HOLE |
| name the closed-set step as "compactness ⟹ band"; register the tight bicycle as 3-colourable by arcs | adopted: C-CS-1, C-T-BIKE |
| the tangent form of Prop 2.2 (bowtie, tangent interfaces) | adopted as C-T-TAN, quoted as its one-mind wording |
| SV Lemma 1 a.e.: expect TRUE for C² interfaces; "do not take it as fails a.e. as written" | adopted, with a correction of my message: what fails as written is S–V's **proof** (it colours the two points); the **statement** C-T-L1 is open |
| verify Townsend 2005 and Coulson 2004 before building on them | adopted: Phase V reads them first-hand; C-AE-MAP6 rests on no unread proof |
| first derivation target: S–V Question 2 a.e. (C-AE-Q2), before the normal form; confidence medium | adopted as Phase R's first target; the normal form (T-S) runs beside it in the competitor slot (§6) — disagreement recorded: I keep T-Q live in parallel, because C-Q-EQ, if TRUE, makes it the whole question |
| a.e. slack corollary: random motion + de Bruijn–Erdős needs every distance; repair by Prop 2.1 with a positive-measure colour per tile | adopted: C-AE-SLACK in both forms (a), (b); the route is the job's |
| fences: the advisor's record and `data/fs106/fs106-a/`; my rationale; FS-103's records for a blind REM deriver; blind Voronov verifiers get the PDF and statements, never where the band is used | adopted in every blind brief |

## Stage 4 — SAVED

### 4.1 The advisor's review of the list, and what I did (after stage 4's commit)

- C-T-L1 split into **C-T-L1a** (C² interfaces; the advisor expects TRUE from its second-order form, which I keep out of the list) and **C-T-L1b** (corners,
  cones, no regularity; open). Adopted.
- C-T-BIKE: the 2-colouring of one unit circle by half-open 60° arcs stated as a fact beside the claim. Adopted. Which outcome matters: a 3-colouring by
  arcs means the bicycle is no tight engine on circles alone; "none" would be the surprise.
- C-Q-REM: the constant left for the job (`η` unprinted); (ii) stated at the origin of the stationary colouring; the pointwise core given its own verdict
  line. Adopted. **Disagreement recorded:** the advisor calls that core (its A3) "a different statement" from FS103-M's D1; as I read them they are one
  statement — D1 says a density point `y` of `S_j` and a point `x` with `d̄_j(x) > 0` are never at distance 1, which is A3 read from `y`'s side. The
  verdict line in C-Q-REM costs nothing either way; Phase H's second mind on D1 settles it.
- C-Q-HOLE: a route to C-Q-STAB with no trichromatic point is allowed. Adopted.
- C-CS-1: "the only use of closedness" made the checkable half. Adopted.
- Fences: `data/fs106/fs106-a/` by path in every blind brief. Adopted.

## Stage 5 — SAVED: the plan (WORKFLOW 4)

**Frame.** FS-106 is a derivation milestone. Its *No* half (the regular classes cannot save a colour; the method runs tight) gives `χ_m⁰(ℝ²) = 7`, hence
`χ(ℝ²) = 7` **given MR** (row 120, rows 128–130). Its *Yes* half (an a.e.-proper six-colouring in some regular class, e.g. a map with unit-arc boundaries)
gives `χ(ℝ²) ≤ 6` **with no MR** (I-EASY). A named step is the third outcome and FS-107's target. Staffing: at most three agents at once — the advisor
(FS106-A, standing) and two workers; all Opus 5.5; no job spawns another.

### 5.1 Phases

| phase | job (brief) | claims | minds | record | budget / stop rule | wave |
|---|---|---|---|---|---|---|
| **V** verify print, sighted | FS106-V (`V106-verify-print.md`) | V-1.1, V-1.2, V-1.3, V-2.1, V-2.2, V-P2.2, V-4.1, V-6.1; SV-1, SV-2, SV-L1, SV-C2, SV-C3, SV-L3, SV-L4; TW-81; CO-04, WO-73, and TW-05, TH-99, PR-98, PA-20 as they land; C-CS-1, C-CS-2; C-AE-SLACK, C-AE-CLOSED; C-ROW40 | 1 (sighted) | `plans/FS106-V-verification.md` | ~300k, hand back by 400k; stop when every §2–§3 claim and the two short §4 claims have a verdict or a named GAP | 1 |
| **VB** verify print, blind; second mind on the held inputs | FS106-VB (`VB106-blind-print.md`) | the same §2–§3 claims from the PDFs and statements alone; **Phase H:** I-D1, I-D2, I-D4 and the density-point lemma of D-NF (second minds) | 1 (blind) | `plans/FS106-VB-verification.md` | as V | 1 |
| **TS** the structural route: regular classes a.e., then the transfer | FS106-TS (`TS106-structural.md`) | C-AE-Q2 first (and C-AE-Q2-EV), then C-AE-FA, C-AE-POLY, C-AE-MAP6, C-AE-NICE, C-AE-CONV; then C-T-L1a, C-T-L1b, C-T-BIKE, C-T-TAN, C-T-TRIa, C-T-TRIb, C-T-CHR4, C-T-ANN, C-T-IND, C-T-PIG, C-T-KILL | 1 | `plans/FS106-TS-derivation.md` | ~300k, hand back by 400k; stop at a saved stage; C-AE-Q2 gets a verdict or a named GAP before any C-T claim | 2 |
| **TQ** the quantitative route | FS106-TQ (`TQ106-quantitative.md`) | C-Q-REM, C-Q-COMP, C-Q-EQ, then C-Q-HOLEa, C-Q-LOCAL, C-Q-STAB | 1 | `plans/FS106-TQ-derivation.md` | as TS; C-Q-EQ gets a verdict before C-Q-STAB | 2 |
| **B** blind second minds on wave 2 | FS106-SB, FS106-QB (`B106-blind-second.md`, one brief, two instances) | every TS claim TS graded TRUE or FALSE (SB); every TQ claim (QB) | 1 each (blind) | `plans/FS106-SB-verification.md`, `plans/FS106-QB-verification.md` | ~250k each; stop when every assigned claim has a verdict | 3 |
| **L** Lean slots (written, not built) | the close | C-CS-1 (compactness ⟹ band; row 41's limit lemma is the kernel neighbour); C-AE-SLACK over V-1.1 as a named hypothesis; C-Q-COMP after M1 enters FS-101 | — | the close's record | — | close |

**Order and the competitor.** Waves are sequential; within a wave the two workers are blind to each other's records until both have saved their
verdict stage (V and VB; TS and TQ). TS and TQ are the competition inside FS-106: two routes to the heart, not two attempts at one claim. **Where a
competitor proper would pay** (G51): on C-AE-Q2 and on C-Q-STAB — each decisive, each with a *Yes* that is a construction and a *No* that is a proof;
that is FS-107's shape, so FS-106 names them as FS-107's first two contests rather than running them twice here. **Where the advisor stands:** it
reads V and VB's records after both save, TS's and TQ's after each stage, and names where each would have to break the other.

**Dependencies.** Wave 2 needs wave 1's verdicts on V-1.1 (TQ uses it as a black box; TS uses the proof's steps) and on SV-L1, SV-C2, SV-L3 (TS
transplants them). If V or VB returns FALSE or GAP on V-1.1 or SV-2, wave 2 is re-briefed before launch (the planner's rule, the owner's call).
Townsend 2005, Thomassen 1999 and Pritikin 1998 are read by FS106-V when they land; C-AE-MAP6's verdict waits for Townsend 2005.

**Checkpoints and resume.** Every job saves by stage (standing rule 2); the record's last `Stage n — SAVED` is the checkpoint; the resume command is the
job's brief with "you are resuming" — it reads its record and `git log -- <record>` and continues at the first unsaved stage. A kill redoes at most one
stage. No job runs a process longer than two minutes (exact checks of seconds only; `tools/fs106_<job>_*.py`).

### 5.2 Fences (blind jobs: VB, SB, QB)

Standing rule 13's list (the session transcripts under `~/.claude/projects/-home-kooshi-source-lean-dir/`, memory included; `chats-bak/`; every file in
the shared harness scratchpad the job did not create), and: this plan (`plans/FS106-regular-half.md` — its rationale lines say where the band is used);
the advisor's record `plans/POROS-2026-09-26-fs106-regular-half.md` and `data/fs106/fs106-a/`; `data/fs106/fs106-p/`; every other FS-106 job's record
and working directory until the blind job's verdict stage is committed; for any blind deriver of D1, REM or the normal form, `plans/FS103-M-derivation.md`,
`plans/FS103-N-verification.md`, `plans/FS103-V1-verification.md`, `plans/FS103-V2-verification.md` and `plans/POROS-2026-09-26-hn-paths.md`. Blind print
verifiers get the PDFs and `data/fs106/claims.md`, never a list of where a hypothesis is used.

### 5.3 Registered expectations (instruments for G21, scored at the close; both outcomes reachable, and why)

| # | claim | expectation | why the other outcome is reachable |
|---|---|---|---|
| E1 | V-1.1 (Voronov's proof) | TRUE, 0.8 | an unrefereed preprint; Lemma 2.2's limit of discrete colourings and Obs 2.2's recolouring are delicate |
| E2 | SV-2 (polygons) | TRUE, 0.75 | S–V's Prop 8 (recolouring to degree 3) and Prop 17 are short; a published proof has failed before (Woodall, `[Townsend1981]`) |
| E3 | C-CS-1 | TRUE, 0.9 | a second use of closedness hidden in "the same tools" of Thm 1.1's bounded form |
| E4 | C-AE-SLACK | TRUE, 0.9 | form (a) versus (b) may split; D4 is one mind |
| E5 | C-AE-CLOSED | TRUE, 0.55 | closed classes may touch at distance 1 on a null set of pairs and still realize no positive set; the a.e. form is weaker than Thm 1.3's hypothesis |
| E6 | C-AE-Q2 | TRUE 0.5, FALSE 0.15, GAP 0.35 | FALSE is a six-coloured map with unit-arc boundaries — `χ(ℝ²) ≤ 6` with no MR; Townsend's unit-arc counterexample shows the feature is real |
| E7 | C-AE-POLY | TRUE, 0.65 | S–V's Lemma 1 proof colours the two points; polygons have no unit arcs, but corners are C-T-L1b's case |
| E8 | C-T-L1a / C-T-L1b | TRUE 0.8 / TRUE 0.5 | cones touching at distance 1 carry no unit pair (the advisor's A4): the general case may admit a facing-away pair |
| E9 | C-T-BIKE | TRUE, 0.7 | the two circles' unit graph has more cycles than one circle's; an odd cycle among them refutes 3 colours by arcs |
| E10 | C-Q-REM / C-Q-COMP / C-Q-EQ | TRUE 0.85 / 0.85 / 0.8 | REM's constant or COMP's band-closedness may fail for a measurable (not CP) colouring; the equivalence needs both |
| E11 | C-Q-STAB | decided in FS-106: TRUE 0.1, FALSE 0.1; GAP 0.8, at a non-local obstruction (C-Q-LOCAL) | FALSE is a sequence of six-colourings with shrinking holes, a construction; TRUE is HN's measurable form given C-Q-EQ |
| E12 | the milestone | the closed-set step named (C-CS-1) and the heart reduced to C-AE-Q2 or C-Q-STAB, both handed to FS-107 | a TRUE on C-Q-STAB or a FALSE on C-AE-Q2 ends the question here |

Per the counter-priors, these numbers are instruments, not caps: none shrinks a claim or stops a job.

### 5.4 Hand-over to FS-107 (drafted now, rewritten at the close)

- **R's targets:** whichever of C-AE-Q2, C-T-L1b, C-T-TRIb, C-T-ANN, C-T-IND, C-Q-STAB is GAP — each a named step.
- **W's targets:** a six-colouring of a map whose boundaries include unit arcs (C-AE-Q2 FALSE); a sequence of six-colourings of `U₃(0)` with slack `ε → 0`
  and a free colour of density `→ 0` (C-Q-STAB FALSE; C-Q-COMP turns it into a CP six-colouring). Constraints held: each class of density `≤ m₁ ≤ 0.2470`
  (row 129); tight (C-AE-SLACK); non-polygonal unless C-AE-POLY fails; `[Parts2020c]`'s 99.985698 % and Didin–Voronov's dense classes as material.

### 5.5 Proposed edits (for the close; I edit none of these files)

- `BIBLIOGRAPHY.md`: `[SokolovVoronov2025]` read status — "§§4–9 read 2026-09-26 (FS106-P) for the exact-distance transplant, §9's `µ∗₆` and Question 2;
  their bearing on link 5 drawn only now (G50)"; `[Townsend1981]` — held (`library/papers/townsend-1981-…pdf`), read in full, "states the theorem and a
  lemma; no proof"; `[Voronov2023]` — "read in full again 2026-09-26 (FS106-P) for the proof's skeleton"; new rows: Didin–Voronov 2026 (arXiv:2607.19946,
  not held), Cherkashin–Voronov 2024 (Zbl 1532.05064, not held), Axenovich–Liu–Sagdeev 2025 (arXiv:2512.15516, listing only), Lukeš–Malý–Zajíček 1986 and
  Wilczyński 2002 (density topology; listing only).
- `plans/GROKKING-INSTANCES.md` §G50: `[SokolovVoronov2025]` held and "read" at FS-18 for the cell family; its exact-distance transplant, §9 and Question 2
  bear on link 5 and were not drawn until FS106-P.
- `LEDGER.md` row 40: its condition, per C-ROW40's verdict.

### 5.6 Would-have-searched-here log

- None in any stage: the gate was reading and database queries.

## Stage 5 — SAVED

## Stage 6 — SAVED: the job briefs (drafts for the owner)

`data/fs106/briefs/V106-verify-print.md` (FS106-V, wave 1, sighted), `VB106-blind-print.md` (FS106-VB, wave 1, blind, with Phase H),
`TS106-structural.md` (FS106-TS, wave 2), `TQ106-quantitative.md` (FS106-TQ, wave 2), `B106-blind-second.md` (FS106-SB and FS106-QB, wave 3, blind).
Each carries the no-children rule with its reason, the standing rules (rule 0 first), its record path, stages, budget and report path; the blind ones
carry §5.2's fences by path.

## Stage 6 — SAVED

## Stage 6b — SAVED: the advisor's real review applied

The advisor **retracted** its first review in full (sent before it had read the list; its claim ids and its "fences fine as written" were invented) — a
slip recorded against FS106-A, logged by it to the owner. The four edits I made in §4.1 from that message (L1 split, the one-circle fact beside C-T-BIKE,
`η` unprinted, the no-trichromatic-point route) coincide with its real review and stand. The real review (on the list at be4359b0/c5c55929), and what I did:

| advice | decision |
|---|---|
| C-T-TRI MISSTATED: a cusp junction (two tangent boundaries, a horn `{0<x, x²<y<2x²}` of density 0 at its tip) in the band-proper hexagonal 7-colouring leaves every `|P(x)| ≤ 2`; V-2.2 is for any number of colours | split: **C-T-TRIa** (density form, `P`) and **C-T-TRIb** (support form, `P_supp`, Voronov's and S–V's closure notion). The counterexample stays in the advisor's record (fenced). **The cusp is the third exceptional configuration** beside the bowtie and the unit arc: density sees two colours where the closure sees three, and the kills need density while existence is topological — named for Phase T (TS brief item 3) |
| C-Q-HOLE MISSTATED: excise a disc of radius `ρ ≪ ε` about every trichromatic point of a Parts-type partial colouring; the defect stays small and no trichromatic point is left | replaced by **C-Q-HOLEa** (holes of radius `r`, `4r < ε`, are fillable — invisible to the proof) and **C-Q-LOCAL** (the feature-local no-go and its consequence: C-Q-STAB needs an obstruction spread over positive measure). T-Q's route description changes from "stabilise Voronov" to "find a non-local obstruction" (TQ brief rewritten) |
| C-T-L1: the second-order criterion; the borderline is S–V's Condition 5 | already split (L1a, L1b); the criterion stays in the advisor's record, fenced |
| C-Q-REM: print "some absolute `η > 0`" | done |
| C-AE-CLOSED is a special case of the tight question, not a corollary of the print | recorded here: its verdict is the first instance of link 5 in a class with Voronov's topology (closed sets), and FS106-V is told it is not expected to follow from Thm 1.3 by citation |
| fences must name `data/fs106/fs106-a/` and the advisor's record by path | they do (§5.2, and each blind brief) |

## Stage 6b — SAVED

## §R-close — the close (WORKFLOW step 9, the mathematics half; job FS106-C, the close planner)

*de Bruijn (Opus 5.5), 2026-09-27. Brief `data/fs106/briefs/C106-close-math.md` with `data/fs106/briefs/STANDING-RULES.md`; its template
`data/fs105/briefs/C105-close-math.md`. Worked from `plans/FS106-close-inventory.md` (items 1–77). Drafts only: `CLAUDE.md`, `LEDGER.md`,
`plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, `CLOSED-QUESTIONS.md`, `plans/GROKKING-INSTANCES.md` and the protocols are written by the front-page
job FS106-X. Every number below is read from the record named beside it, never from the inventory. Records: V = `plans/FS106-V-verification.md`
(FS106-V, with § Continuation — FS106-V2 and — FS106-V3: one sighted line, three agents), VB = `plans/FS106-VB-verification.md` (blind),
TS = `plans/FS106-TS-derivation.md`, TQ = `plans/FS106-TQ-derivation.md`, SB = `plans/FS106-SB-verification.md` (blind on TS),
QB = `plans/FS106-QB-verification.md` (blind on TQ), A = `plans/POROS-2026-09-26-fs106-regular-half.md` (FS106-A), A2 =
`plans/POROS-2026-09-27-fs106-close-and-fs107.md` (FS106-A2), P = this plan (FS106-P), claims = `data/fs106/claims.md`.*

## Theorems this phase proved

None new: a close. The close's own readings, one mind each and marked where used: C-AE-SLACK's plane form as a corollary of QB's Lemma F (1.1,
row C-AE-SLACK); the diameter bound behind A2's fill check (1.3, D7).

### Stage 1 — SAVED (quotation check; reconciliation)

**1.0 Quotation check of the brief and of the owner's message (standing rule 5).**

| # | the brief or message says | source | result |
|---|---|---|---|
| Q1 | A12: "it needs simply connected regions, which Prop. 8's recolouring can destroy" (owner's addition) | SB §2.1 row A12 ("needs simply connected regions"; "A7's recolouring can destroy it") | matches |
| Q2 | TS's "Prop. 12 holds wherever the curves exist" (owner's addition, in quotation marks) | TS §2.5 table: "Prop. 12, Cor. 4 (the index) \| Lemma 1, Prop. 3 \| hold wherever the curves exist"; TS §2.3 l. 153: "… no Condition 5 wherever their curves exist" | **a paraphrase inside quotation marks** (drops "Cor. 4", changes the verb's number); harmless to the content, logged as a standing-rule-5 instance with items 38 and 40 |
| Q3 | "[Coulson2004]'s printed theorem (six, with an area bound)" (not in quotation marks) | SB §2.2: Thm 3.5, "A tile based colouring with excluded distance D must employ at least 6 colours"; SB §3.3 (area bound) | matches |
| Q4 | "`CLAUDE.md` is at 304,245 bytes" | `wc -c CLAUDE.md` at this job's start | matches |
| Q5 | "Row 40's correction … its condition is `[Voronov2023]` Thm 1.3 alone" | V §2.1 row C-ROW40 ("contradicting **V-1.3 alone**"); A stage 4 ("Row 40: V-1.3 alone discharges it") | matches |
| Q6 | the owner's ruling: FS-107 renamed "stability: can vanishing holes save a colour?"; link 5 in TQ-EQ's form; draft that version only | inventory item 77 | matches; the two-version draft of the brief is superseded |
| Q7 | standing rule 3 quotes Kooshi as "The intent of the ban is to eliminate the crutch …" | `CLAUDE.md` § Toolchain: *"to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"* | the known slip (item 38), still in the standing rules; not corrected by me (a brief file, the owner's) |

**1.1 Reconciliation — every claim of `data/fs106/claims.md`.** Minds and blindness: V, V2, V3 are one sighted line (V2 and V3 read their
predecessors); VB blind to V, V2, V3 and the plan; TS and TQ blind to each other until their verdict stages; SB blind to TS until its stage 3
(`2c5fabef`); QB blind to TQ until its stage 3; A and A2 not blind (their checks are sighted readings, never counted as a mind unless they
derive). "Two minds, one blind" means one derivation plus a blind one.

*§0–§1, definitions and held inputs.*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| D-NF's density statement (the classes `S̃_j` avoid distance 1) | TRUE | FS103-M; VB blind (second mind) | [hand, two minds, one blind] | none |
| I-D1, I-D2, I-D4 | TRUE | FS103-M; VB blind | [hand, two minds, one blind] | A's quote check (item 29): I-D4's "…" drops the definition of `supp S_j` — restore it in claims.md; D-SLACK uses the closed band, I-D4 the open one (harmless). D1 also re-derived sighted by TQ (TQ-CORE) and blind by QB (QB-CORE) |

*§2, the printed theorems (verdicts on the proofs as printed).*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| V-1.1, V-1.2, V-1.3, V-2.1, V-2.2, V-P2.2, V-4.1, V-6.1 (`[Voronov2023]`) | TRUE after local repairs (V's R1–R10: Lemma 2.2's limit step wrong as printed — the fills move colours; Prop. 3.4's hypothesis unsatisfiable, Lemma 6.1 uses it outside it; none changes a statement but Prop. 3.4's hypothesis) | V; VB blind (the same repairs reached independently: Lemma 2.2's limit after hole fills; Prop. 4.1's sign reversed with a swap excluded; the bicycle needs `α < ε/2`; VB: Prop. 3.4's disc claim false for the band, a circle-only repair) | [hand, two minds, one blind] over an unrefereed preprint | none of truth (A stage 4) |
| SV-L1 | TRUE; region-only proofs from Cond. 5 (V; VB sketch); with no Cond. 5 or 6 as TS-L1 (below) | V; VB blind | [hand, two minds, one blind] | V: the printed proof uses Obs. 1 |
| SV-C2, SV-C3 | TRUE | V; VB blind | [hand, two minds, one blind] | none |
| SV-L3 | GAP as printed for `√3 ≤ d < 2` (Fig. 5's triangle bipartite there); repaired for `1 ≤ d < 2` by the transplanted bicycle | V ([hand] at `√3` + [measured, float] pairings) and VB blind (GAP: the three curves unproved) — **one gap** (A stage 4); repair V2 only | GAP as printed, two minds; **repair [hand, one mind, sketch: constants not computed]** — the weakest link of "polygons need seven" (A2 §1b.1) | settled: one gap, one repair |
| SV-L4 | GAP as printed; repaired for polygons: (a) by Cond. 7 after Prop. 8 (V2) and under Cond. 6 by TS-T; (b) the eleventh point on the `{4,5,6}`-component of `u` (V2), needing simply connected regions — **A12, closed by fills** in the order Prop. 8 → fills → Lemma 4; (c) the same-multicolour pair at distance in `(1, 2)` by continuity + TS-L1 (SB A11-REP; V2), `d = 1` by the transplanted bicycle, **`d = 2` open** | V2 sighted; A12: V (l. 172 (b), "repairable by fills") and SB blind; TS-T: TS and SB blind | (a) [hand, two minds, one blind]; (b) [hand]: A12's gap two minds, one blind; the fill's order V2 + A2's check, H3 two minds, one blind; (c) `d = 2` open (V3 reduced it to orientation constraints) | A12 settled by A2 §1b.1 (the owner's addition, point 1): handled by fills; **the close writes the fill step into the chain** (Stage 4 drafts) |
| SV-2 (polygons) | GAP as printed; **TRUE [hand] except the `d = 2` edge case**, weakest link SV-L3 for `√3 ≤ d < 2` (one mind, sketch); Obs. 1 not needed (region-only Props. 7/8) | chain: the V line sighted; SB blind relative to the printed chain; Prop. 7 region-only in three written versions (TS, V3 sighted; SB blind) | [hand, two minds on the chain, one blind; SV-L3's repair one mind, sketch] | VB's Obs. 1 / Prop. 8 GAP vs V2's TRUE: settled for V2 (V3's run-apex crossing, `ρ₋ ≈ s_b²/(2 sin β)`, A2 §1b.4), and TS's region-only route makes the a.e. form independent of it |
| SV-1 | GAP at Prop. 19's fills under Cond. 6 (fills can create degree-4 trichromatic vertices) plus SV-2's residuals; SV-L4 (a) closed by TS-T | V2; TS | [hand, one mind for the GAP's location] | tool proposed: Woodall's step-3 merge (V3), except the cone case at six colours (item 57) |
| TW-81 (`[Townsend1981]`) | the lemma TRUE (constant `π/3`; V3 in general, VB for a one-sided annulus); the theorem: **no proof printed** | V, VB blind, A, V3 on "no proof"; the lemma: V3 (general), VB blind (the one-sided case) | no proof: three readings; lemma [hand, one mind in general, two on the one-sided case] | V: the scan reads "fine detail", not "line detail" (P §1.1 Q7); Woodall's assertion is `⅔π`, Townsend's lemma `π/3` |
| TW-05 (`[Townsend2005]`) | unheld; **Townsend's 1979 manuscript read instead** (its text may differ): ⅓π lemma TRUE (two steps supplied via lemma (L)), Thm 2 TRUE, Thm 4 GAP in its generality (petal sets), its Corollary repaired [sketch], **Thm 5 (maps need six) GAP at simplification (c)** — Woodall's steps 2, 3, 5 fill it | V3 | [hand, one mind]; the fill [hand, one mind, outline] (V3's own correction, item 58) | the manuscript's Definition 4 colours boundaries from adjacent regions — S–V's Obs. 1 as a hypothesis |
| CO-04 (`[Coulson2004]`) | 3.2–3.3 TRUE, 3.4–3.5 unverified (figures, V3); printed theorem **six**, tile-based, area bound (SB read in full) | V3; SB | [hand, one mind] on 3.2–3.3; the statement read twice | TS read it as unread (TS "prior-art debt"); link 4 lists it among "maps need six" — a correction (A2 §1b.3; item 76) |
| WO-73 (`[Woodall1973]`) | Thm 6 (maps need six): step 6 GAP (Townsend's `⅔π` counterexample), repaired by Townsend's ⅓π lemma; steps 1, 4, 6 checked, 2, 3, 5, 7 in outline, 8 not | V3 | [hand, one mind; outline at 2, 3, 5, 7] | V3's stage-3 overstatement corrected at its stage 4 (item 58) |
| TH-99 (`[Thomassen1999]`) | TRUE in the plane (the count repaired) | V3 in full; TS read it once (the clique step checked, the 2-separator surgery read) before V3 committed | [hand, one mind + a partial independent reading] | OCR "radius 2" (= ½) and "12k + 3" need the page images (V3) |
| PR-98 (`[Pritikin1998]`) | TRUE: the uncovered set is closed, density ≈ `1.61·10⁻⁴` | V3 | [hand, one mind] | his phrase is "\"nearly\" all", not "almost all" (V3) |
| PA-20 (`[Parts2020c]`) | constructions recorded, not verified | V3; QB read §§1, 2.1–2.3 | [external] | `BIBLIOGRAPHY.md` still says "not held" (QB) |

*§3, the closed-set step.*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| C-CS-1 | TRUE: Thm 1.3 uses closedness once, as compactness giving a band | V; VB blind | [hand, two minds, one blind] | none |
| C-CS-2 | TRUE | V; VB blind | [hand, two minds, one blind] | none |

*§4, the almost-everywhere forms.*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| C-AE-SLACK | TRUE given V-1.3, both forms, on `ℝ²` and `U₃(0)`; no random rigid motion needed (supports `supp S_j` are closed, cover, and realize no distance in the open band) | V; **the plane form also follows from QB's Lemma F** (a full slack colouring is a partial one with nothing uncovered, against `ε²/(6+ε)²`) — QB blind, the corollary the close's reading; TQ §4.2 sighted | [hand, two minds, one blind, given V-1.3] (the corollary: the close's reading, one mind) | forms (a) ⟺ (b): V's polar coordinates ((b) ⟹ (a)) and QB's Lemma B (both ways), two minds, one blind |
| C-AE-CLOSED | **GAP — equivalent to an open question**: "no a.e.-proper measurable 6-colouring of `U₃(0)` with essentially closed classes"; cleanest form: can six open sets, each avoiding distance 1 at every pair, have dense union in `U₃(0)` and closures with null unit pairs? It implies the a.e. forms of S–V Thms 1–2 and of Question 2 for null-boundary maps | V | [hand, one mind] | the list's closed sets may touch at distance 1 on a null set of pairs (the closed-hexagon 7-colouring, A) |
| C-AE-POLY | **TRUE [hand] except the `d = 2` edge case**, weakest link SV-L3 at `√3 ≤ d < 2` (one mind, sketch); A12 closed by fills | TS region-only (sighted, one); SB blind relative to the printed chain; the V line | [hand, two minds on the chain, one blind] | TS TRUE vs SB "inherits A12": settled by A2 §1b.1 (fills) |
| C-AE-FA | GAP at Prop. 19's fills under Cond. 6, plus C-AE-POLY's residuals; SV-L4 (a) closed | TS; V2 | [hand, one mind] | none |
| C-AE-MAP6 (five colours, a.e.) | reduced (TS) to Townsend's annulus lemma a.e.; that lemma, Townsend's Thms 1–2 and the Corollaries of Thms 3–4 are region-only (V3); **Thm 5's simplification (c) is the open step, filled by Woodall's steps 2, 3, 5 read in outline** — so TRUE modulo those steps; "boundaries of measure 0" is used by no step, only to identify D-AEMAP with `Leb ⊗ σ`-a.e. properness | TS (the reduction, blind to V3); V3 | [hand, one mind per link; Woodall's fill in outline] | none; E-less (no registered expectation) |
| C-AE-Q2, C-AE-Q2-EV | **GAP at four named steps**, no counterexample: [G1] S–V Lemma 2 without Cond. 5 (local configuration C5 against its Prop. 5); [G2] Cor. 2's annulus at a bowtie, a unit-arc boundary through `u`, spiralling boundaries; [G3] Prop. 17's last step; **[G4] Prop. 12's swap exclusion**, failing at a unit-arc interface facing a bowtie or a 4-chromatic point | TS ([G1]–[G3]); SB ([G4], blind, with checker `tools/fs106_sb_c5_check.py` line (I)) | [hand; one mind per step] | TS §2.5 "hold wherever the curves exist" is FALSE without Conds. 5–6: settled for SB by A2 §1b.2 (the owner's addition, point 3) |
| C-AE-NICE | TRUE: V3's wording — "Let `G` be a connected graph in `ℝ²` whose faces are open topological discs of diameter `< 1`, each bounded by a cycle of `G`. If each face receives one of `k` colours so that any two distinct faces of one colour are at distance `> 1` (points of `G` carry no colour), then `k ≥ 7`." Thomassen reads no boundary colour | V3; TS independently (its a.e. form is TH-99 itself) | [hand, two readings, neither blind by protocol but independent] | C-AE-NICE′ (no unit pair between faces): GAP with C-AE-Q2 (TS; V3 — follows from C-AE-CLOSED for null-boundary locally finite `G`) |
| C-AE-CONV | **TRUE at C-AE-POLY's grade** for locally finite tilings by convex polygons, with the fill step written in: merge tiles by colour (no unit pair created), fill the annular merged regions, apply C-AE-POLY; seven, against `[Coulson2004]`'s printed six | TS; SB blind (GAP at A12) | [hand, two minds on the reduction, one blind] | TS TRUE vs SB GAP at A12: settled by A2 §1b.3 (the owner's addition, point 4) — A12 is closed by fills |

*§5, the method transfer.*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| C-T-L1a | TRUE (Jordan interfaces suffice) | TS | [hand, one mind] | — |
| C-T-L1b | TRUE for locally map-like classes; GAP in general at two steps (the first-order stripe structure of strong blow-ups; graph interfaces killed at second order) | TS | [hand, one mind] | — |
| C-T-TRIa | **FALSE**: the cusped hexagonal 7-colouring | A (A7); TS checked | [hand, two minds] | — |
| C-T-TRIb | GAP at the hull step | TS | [hand, one mind] | — |
| C-T-CHR4 | GAP; `|P(x)| ≥ 5` only on the null set `{x : σ(ω(x) ∩ E) > 0}` | TS | [hand, one mind] | — |
| C-T-ANN | GAP | TS | [hand, one mind] | — |
| C-T-IND | **MISSTATED.** Carried form (SB): under reading (A) (the lift agrees a.e.) `Ind` is well defined whenever a continuous lift exists, and complementary curves with **no swap** satisfy `|Ind γ₁ − Ind γ₂| ≤ 1` for any continuous lifts. The "iff finitely many changes" is FALSE under both readings; a swap with `|ΔInd| = 2` exists without Conds. 5–6 | the no-swap bound: TS (finitely many changes) and SB blind (any lifts) — two minds; the "iff" FALSE and the swap: SB, one mind + checker | [hand] | TS's "corrected form TRUE" vs SB: settled for SB by A2 §1b.2 (the owner's addition, point 2); TS's "K3 has no index" holds for a three-colour K3 or under reading (B) only |
| C-T-BIKE | GAP; the bicycle needs three colours at every `d ∈ (1, 2)` (a triangle at `|x − v| = √3`) | TS | [hand, one mind] | A's hunch "3-colourable by arcs" open, not tested (the scan is banned) |
| C-T-PIG | GAP | TS | [hand, one mind] | — |
| C-T-KILL | the disjoint half TRUE under C-T-TAN; the same-multicolour half GAP | TS | [hand, one mind] | — |
| C-T-TAN | TRUE in a precise strong-blow-up form; fails exactly at cone points (tangent interfaces, bowties), and also at cusps and weak-* limits | TS | [hand, one mind] | A's "nowhere else" killed (A2 §2.2) |

*§6, the quantitative route.*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| C-Q-REM | core TRUE; (i) TRUE for every `ε > 0` (TQ `η = 1/20`, any `η < 1/(1+4π)`; QB `η = 1/10`); (ii) TRUE in CP form (a jointly measurable modification exists); its uniform form FALSE (zigzag, TQ) | TQ; QB blind | [hand, two minds, one blind]; the uniform form's falsity one mind | QB's stage-2 "(i) false for large `ε`" was QB's slip (no point is kept for `ε > 1/2`), conceded (QB §4.2 T1) |
| C-Q-COMP | (i) TRUE (upper density suffices); (ii) `µ₆(ε)` attained (stationary, and by a.e. sample) TRUE; "`µ₆(ε) < 1`" TRUE given V-1.3, and "for every `ε`" ⟺ V-1.1 (QB) | TQ; QB blind | [hand, two minds, one blind]; the ⟺ V-1.1 one mind (QB) | none |
| C-Q-EQ (= TQ-EQ) | **TRUE, no MR, no Voronov**: `χ_m⁰ ≤ 6 ⟺ χ_CP ≤ 6 ⟺ µ₆⁰ = 1 ⟺ lim µ₆(ε) = 1 ⟺` periodic grid-square slack partial 6-colourings with vanishing holes; the same for every `k` (QB) | TQ; QB blind, by a different route at `(c) ⟹ (a)` (TQ: maximal inequality + random threshold; QB: averaging + support selection); one shared analytic input (the circle measure is Rajchman, QB Lemma K — which row 130 already uses) | [hand, two minds, one blind; (a) ⟺ (b) is row 130's] | G21 (QB §3.2): "a compactness restatement: it moves no value"; "the novelty of TQ-EQ over row 130 is modest: the slack side and the periodic/pixelated forms" |
| C-Q-STAB | **GAP — it is `χ_m⁰ ≥ 7` itself**; the radius-3 wording is sufficient, not equivalent; the exact disc form is "for some radius `R`" | TQ; QB agrees (the fallacy to watch: from "`µ₆(ε) < 1` for each `ε`" to "`lim µ₆(ε) < 1`") | [hand, one mind] | — |
| C-Q-HOLEa | TRUE; general form HOLE-t (holes within `t < ε/2` of the coloured set fill at a band loss of `2t`) | TQ; QB's Lemma F is a sibling fill lemma, blind | [hand, one mind on HOLE-t] | — |
| C-Q-LOCAL | TRUE for every `δ > δ₆` (chromaticity 1); **GAP at `δ = δ₆`, likely TRUE** (the missing step: `1_H ∗ 1_{U₃}` non-constant); consequence TRUE in the sharpened pixel-lemma form (QB-P): a trichromatic-point step carries C-Q-STAB's full strength at every `δ` | TQ; QB blind; A2 at the endpoint | [hand, two minds for `δ > δ₆` over Parts [external]] | TQ "MISSTATED at `δ₆`" (average translate) vs QB GAP: settled for QB by A2 §1a.2 — keep "at least", verdict "TRUE for `δ > δ₆`; GAP at `δ = δ₆`"; inventory item 50's C-Q-LOCAL edit withdrawn (item 69) |

*§7, row 40.*

| claim | verdict | minds; blindness | grade | divergence and settlement |
|---|---|---|---|---|
| C-ROW40 | **DISCHARGED and corrected**: `tools/celllat.py`'s `G(p)` joins closed cells realizing distance 1, so a proper colouring's classes are six closed sets covering the plane, none realizing 1 — against V-1.3 alone; `[SokolovVoronov2025]` and the band are not needed | V; A agrees | row 40's condition becomes `[Voronov2023]` Thm 1.3 at [hand, two minds, one blind, after repairs; an unrefereed preprint] | none |

**1.2 Lemmas and results outside the claim list.** Each with its minds; the derivation file (stage 2) holds the full entries.

| id | statement (short) | minds; blindness | grade |
|---|---|---|---|
| TS-U | the unit-arc lemma: a unit-arc boundary `c \| c′` puts `c` in the wedge facing it, `c′` in the wedge facing away at its centre, neither in the side cones (SB's exact form: `O_c ⊆ ⋂ D(p,1)`, `O_{c′} ∩ ⋃ D̄(p,1) = ∅`) | TS; SB blind | [hand, two minds, one blind] |
| TS-L1 | S–V Lemma 1 for a.e.-proper maps, no Cond. 5, no Cond. 6 | TS (Baire); SB blind (countability) | [hand, two minds, one blind] |
| TS-C | a chain of same-colour regions whose closures meet has diameter `≤ 1` | TS; SB blind (L0′, a different route) | [hand, two minds, one blind] |
| TS-C′ | a connected support piece with `H¹`-null zero-density points has diameter `≤ 1` | TS | [hand, one mind] |
| TS-T | a point of chromaticity `≥ 3` within 1 of every point (SB: within `1/√2 + ε`; Cond. 5 alone makes it trichromatic, Cond. 6 degree 3) | TS; SB blind, sharper | [hand, two minds, one blind] |
| the diameter lemma | a connected set with no two points at distance 1 has diameter `≤ 1` (V2); two same-colour regions with meeting closures have union of diameter `≤ 1` (V2) | V2; SB's L0/L0′ blind | [hand, two minds, one blind] |
| lemma (L) | a two-colour change point of a 2-coloured open set with no monochrome unit has its unit circle outside the set | V3 | [hand, one mind] |
| C5 | a local configuration satisfying S–V Prop. 5's hypothesis and every pair constraint, where its conclusion fails (unit arc at `x`; bowtie or 4-chromatic `y`); survives Cond. 6, killed by Cond. 5 | TS; SB blind + checker (three plants) | [hand, two minds, one blind] + [measured, float sampling] |
| IND-X (the swap) | at a unit-arc interface facing a bowtie, complementary translate curves swap and `\|Ind γ₁ − Ind γ₂\| = 2` | SB; A2 re-ran the checker (exit 0, PASS) | [hand, one mind] + [measured] |
| A-LEM2, A-P7, A10-GAP, A11-REP, A12-GAP, SWEEP, IND-A | S–V Lemma 2 a.e. with Cond. 5; Prop. 7 a.e. (legs `< 1/2`); Prop. 12's printed swap gap (closed by Lemma 1 under Cond. 5); the appendix's same-multicolour distance in `(1,2)`; A12; the sweep at a swap; the index well defined under (A) | SB (A12 also V) | [hand, one mind each; A12 two, one blind] |
| TQ-SUP | `µ₆⁰ = lim µ₆(ε) = lim µ₆^tile(ε) = lim µ₆^per(ε)`; QB stronger: `µ₆^per(ε) = µ₆(ε)` at each `ε`, `µ₆⁰` attained | TQ; QB blind | [hand, two minds, one blind] |
| TQ-EPS2 | every band-proper partial 6-colouring leaves lower density `≥ ε²/(6+ε)²` uncovered (QB's constant; TQ's `ε²/78`), **given V-1.3**; unconditionally it implies V-1.1 at each `ε` | TQ; QB blind | [hand, two minds, one blind, conditional on V-1.3] |
| TQ-HIT | strips of width `2ε` at spacing 2 (density `ε`; TQ's `4ε` at spacing `1/2`) are effective holes meeting every unit circle and bicycle: a hitting-form argument proves at most `1 − µ₆(ε) ≳ ε` | TQ; QB blind (cap `ε`) | [hand, two minds, one blind] |
| TQ-ERODE / QB-P (the pixel lemma) | erosion removes every multichromatic coloured point at cost `O(κ)`; a trichromatic-point method cannot see partial colourings | TQ; QB blind | [hand, two minds, one blind] |
| TQ-P, TQ-T, HOLE-t | periodisation with gaps; Voronov's Prop. 2.1 for partial colourings; thin holes fill | TQ | [hand, one mind] |
| QB-B, QB-K, QB-V11 | D-SLACK's forms equal; the unit-pair form is weak-* continuous (Rajchman); "`µ₆(ε) < 1` ∀ε" ⟺ V-1.1 | QB | [hand, one mind; QB-K standard] |
| TQ-SYN | TS's open steps are regularity gaps and TQ's is the hole gap; TQ-EQ trades the first for the second | TQ | [derived, one mind] |
| PD-EQ | `χ_m⁰ ≥ 7` ⟺ a lower bound, uniform as `ε → 0`, on the monochromatic fraction of band pairs of every measurable six-colouring | A2 | [hand, sketch, one mind] — the operator-norm step "I have not written in full" (A2 §2.2); **not claimed** |
| VB's own | Voronov's Lemma 2.2 without recolouring (nested fills); the bicycle's arc identification by additivity; the circle-only matched-arc recolouring (Prop. 3.4's repair); Townsend's lemma for a one-sided annulus | VB | [hand, one mind each] |
| V2's own | Prop. 17's last step; Lemma 5's nesting; Prop. 18's rotated arc; Props. 14–15's clauses; tangent directions at a trichromatic vertex under Cond. 5; Prop. 16 MISSTATED (TRUE with the hypothesis "the exterior of `ω` near `y` lies in `A(u)`") | V2 | [hand, one mind each] |
| V3's own | Woodall's step-4 lemma for arcs `> ⅔π`; Woodall's step 6 repaired by the ⅓π lemma; Prop. 7/8 region-only at a run apex | V3 | [hand, one mind each] |
| V's own | density points at distance 1 carry a positive measure of unit pairs; SV-L3's printed proof covers exactly `1 < d < √3` | V | [hand, one mind]; the float pairings [measured] |

**1.3 Divergences, and how each was settled.**

| # | where | the sides | settled by | outcome |
|---|---|---|---|---|
| D1 | SV-L3 | V: GAP for `√3 ≤ d < 2` (Fig. 5 bipartite); VB: GAP (three curves unproved) | A stage 4 | one gap; V2's repair, one mind, sketch |
| D2 | Obs. 1 / Prop. 8 | VB: GAP with a local counter-configuration; V: TRUE with an unwritten region-only variant | V3 stage 4 (the configuration cannot occur at a run apex); TS's region-only route | V2 right; the a.e. form never needs Obs. 1 |
| D3 | SV-L4 (a) | V: TRUE for cubic maps, open under Cond. 6 with bichromatic vertices of degree ≥ 4 (VB passed it) | TS-T (TS; SB blind) | closed |
| D4 | TQ-EPS2's constant | TQ `ε²/78` (and `ε²/144` in its §3.4); QB `ε²/(6+ε)²` | A2 §1a.1 | QB's constant; TQ's §3.4 figure to go |
| D5 | TQ-HIT's cap | TQ `4ε`; QB `ε` | A2 §1a.1 | `ε`; the no-go unchanged |
| D6 | C-Q-LOCAL at `δ₆` | TQ MISSTATED; QB GAP likely TRUE | A2 §1a.2 | GAP, likely TRUE |
| D7 | A12, C-AE-POLY, C-AE-CONV | SB: GAP at A12; TS: TRUE (not seeing A12); V (l. 172 (b)) had named it "repairable by fills" | A2 §1b.1, §1b.3 | **handled by fills**, in the order Prop. 8 → fills → Lemma 4. The close's check of the one step A2 relies on: the filled region `R` is connected, open, one-coloured and a.e.-proper, so by the diameter lemma `diam R ≤ 1`, hence its hull (the region with its holes) has diameter `≤ 1`, and H3 applies [the close's reading, one mind] |
| D8 | C-T-IND | TS: "iff finitely many changes", corrected form TRUE; SB: the "iff" FALSE, the bound TRUE only given no swap, a swap with `\|ΔInd\| = 2` | A2 §1b.2 | SB's form carried; TS's withdrawn |
| D9 | TS §2.5's Prop. 12 row | TS: "hold wherever the curves exist"; SB: FALSE without Conds. 5–6 | A2 §1b.2 | FALSE; C-AE-Q2 gains [G4] |
| D10 | TQ §4.4's scoring of A's "robust Voronov" hunch | TQ scored it on uncovered area; A's hunch counted monochromatic band pairs | A2 §2.2 | a denominator mismatch; the pair form is not capped by TQ-HIT and is decisive (PD-EQ, one mind, sketch) |
| D11 | C-Q-REM (i) for large `ε` | QB stage 2: false; TQ: vacuous (nothing kept) | QB §4.2 T1 (conceded) | TQ right |
| D12 | Coulson | TS: unread, C-AE-CONV "stronger than Coulson's six"; SB: read — six, tile-based, area bound | A2 §1b.3 | link 4's "maps need six" list is wrong to include Coulson |

**No divergence remains open.** Every open item is a named GAP (the list in Stage 3's verdict), not a disagreement between minds.

### Stage 1 — SAVED

### Stage 2 — SAVED (the derivation file `plans/FS106-derivation.md`)

45 entries (`b5177885`), in `plans/FS105-derivation.md`'s form; every entry parses under `tools/fs71_ledger_b_check.py`'s entry grammar with all
five fields (checked with its own parser, in memory). Ids: §1 the printed theorems (V23, CS, ROW40, SVL3, SV2, SV1, SVDEF, TW, WO, TH, PR, CO); §2
the a.e. forms (AE-SLACK, AE-CLOSED, AE-POLY, AE-CONV, AE-NICE, AE-MAP6, AE-FA, AE-Q2); §3 the structural lemmas (TS-U, TS-L1, TS-C, TS-C2 = TS-C′,
TS-T, DIAM, L, C5, IND, IND-X, TAN, L1, TRI, BIKE, CHR); §4 the quantitative route (EQ, SUP, EPS2, HIT, PIX, REM, COMP, LOCAL, STAB, SYN, PDEQ, the
last not claimed). Their § B lines are drafted in Stage 4.

### Stage 2 — SAVED

### Stage 3 — SAVED (§G re-read; §PA sweep; §IQ, G72, G79; expectations scored; conjecture sweep; the verdict; the search log)

**3.1 §G re-read — which extractions paid, which entry should have borne and was not used.**

| extraction (P §G part 3) | paid? | how |
|---|---|---|
| G13, D1 (the measurable fan) | **paid** | D1 now has four derivations (FS103-M; VB blind; TQ-CORE sighted; QB-CORE blind); C-Q-REM's kept point is D1 at two radii |
| G15, G16 (transfer pigeonhole and kills separately) | **paid** | C-T-PIG and C-T-KILL got separate verdicts; the kill's disjoint half holds under C-T-TAN, the pigeonhole is a GAP — the split located the wall |
| G17 (every claim on `ℝ²` and on a disc) | **paid** | C-Q-STAB's radius-3 wording is sufficient, the exact form "some `R`" (TQ §4.5); A2's R question is the disc form |
| G20 (seven-colour controls) | **paid** | the cusped hexagonal 7-colouring killed C-T-TRIa (A7, TS); TS's control K1 names where "six" is spent; R's killing test 2 in FS-107 |
| G21 (audit the flattering result blind) | **paid, three times** | QB blind on TQ-EQ, with "it moves no value"; the dropped grade bracket on TQ-EPS2 caught (QB §4.1); the flattering TRUE on C-AE-CONV (TS) was the one missing a step (SB's A12, then closed) |
| G22, G24, G60 (no per-class density route; W's constraints) | **paid** | no density route registered; W's class-density constraint carried (A2 §3.4) |
| G29, row 41 (name the closed-set step; its Lean form) | **half** | C-CS-1 named at two minds; the Lean slot (phase L) was never written — owed to FS-101 |
| G30, G46, G49, G50 (§PA in the discipline's words; S–V's transplant) | **paid** | G50 fired at planning (S–V's transplant, §9 and Question 2, held since FS-18) and re-aimed Phase T |
| G48, G81 (frame) | paid | FS-106's *No* needs MR; its *Yes* none (I-EASY) — carried into link 5's drafts |
| G64, G67 (claim wording) | paid | no S/W merge anywhere |
| G71, G73 (the index is `K₃`'s height) | **paid, and it predicted the failure's shape** | C-T-IND is exactly the height of a density trace; SB's reading (A) is "a continuous lift agreeing a.e."; the index bound fails only at a swap, where complementarity — not the height — breaks |
| G72, G79 (§IQ) | see 3.3 | |
| G51 (blind second minds) | **paid** | the blind minds produced every settled divergence of truth (A12 with V, [G4], C-T-IND, TQ-EPS2's constant, TQ-HIT's cap, C-Q-LOCAL's endpoint) |
| row 1 (exact-distance circle systems 3-colour) | paid | C-T-BIKE: three colours are needed on the bicycle; whether three suffice by arcs stays open |
| row 40 | **paid** | discharged by V-1.3 alone |
| row 127 (Lean lane) | **not run** | no Lean slot written; owed |

**Entries that should have borne and were not used (each a new instance under WORKFLOW 3.1):**
1. **G72 at ranking time.** P and A ranked S–V's Question 2 first ("the wall in its regular form", A stage 1) when an equivalence (C-Q-EQ, both
   minds' own) was on the table. A2 §2.3 rule 1: "once an equivalent form of the question is on the table, rank every special case below it."
   G72's structural form was applied to the *question* and not to the *ranking of the claims*. Q2 was still productive (TS's lemmas), not the wall.
2. **G21's quantifier, for lists of exceptions.** A's "the tangent form fails only at … and nowhere else" was derived for piecewise-smooth
   blow-ups and read as a statement about all colourings; cusps, spirals and weak-* limits joined the list within a day (A2 §2.3 rule 2).
3. **§ Make the gate fail, "exactly one thing may differ".** TQ §4.4 scored A's "robust Voronov, linear in ε" on uncovered area; A's hunch
   counted monochromatic band pairs (A2 §2.2): two denominators, one credited. The rule was on the page.
4. **G50, four times in one milestone:** `[SokolovVoronov2025]`'s transplant, §9 and Q2 (P); `[Townsend1981]` cited as a proof of "maps need
   six" in `CLAUDE.md` link 4 while printing none; `[Coulson2004]` cited among map theorems while its theorem is tile-based (held, unread);
   `[Parts2020c]` listed "not held" while held (QB §1.1).

**3.2 §PA sweep — what did the milestone teach us about the object?** Each answer promoted (drafts in Stage 4).
1. **The measurable question is a stability question, and its regular form is periodic.** TQ-EQ (e): a refutation of `χ_m⁰ ≥ 7` is a sequence of
   periodic grid-square six-colourings with a band and vanishing holes; the wild set exists only in the limit. In the literature's words this is
   the forbidden-interval line (`χ_{[1−ε,1+ε]}`, Exoo; Currie–Eggleton; Voronov) run in the "what percent of the plane" line (`[Pritikin1998]`,
   `[Parts2020c]`): `1 − µ₆⁰` is the uncovered fraction of their tilings in the limit of vanishing slack, and TQ-SUP says the tight and slack
   suprema coincide. **Promoted:** a grokking draft (G82, Stage 4) and FS-107's re-aim; the `m₁(ℝ²)` literature's compactness step as a prior-art
   debt (item 66).
2. **The index method is degree theory, and it dies where general position fails.** Voronov's index is the degree of a circle's 3-colouring
   lifted to `K₃`'s cover (G71); the bound `|ΔInd| ≤ 1` needs no swap — two complementary curves changing colour at one instant — which is
   non-generic in a map and **forced** at a unit-arc interface facing a bowtie (IND-X). Condition 5 is general position for unit circles.
   **Promoted:** one sentence in G71 (Stage 4) and FS-107's R-S constraint [G4].
3. **Hole-filling is the map line's common tool.** Voronov's Obs. 2.2, Townsend's simplification (a), V2's fills and A12's repair are one move:
   a connected one-coloured region avoiding distance 1 has diameter ≤ 1, so its holes fill. Where the region is not connected through open
   sets — a bichromatic vertex of degree ≥ 4 — the move fails (S–V's Prop. 19 under Cond. 6; Townsend's (c)), and Woodall's step-3 merge is
   the repair tool, except at his "cone". **Promoted:** the Woodall-merge stub (item 57).
4. **Maps, tiles and nice maps are three theorems with three hypotheses**, and the literature and `CLAUDE.md` link 4 had merged them: maps need
   six (Woodall 1973, with Townsend's repair), tiles with an area bound need six (`[Coulson2004]`), nice maps need seven (`[Thomassen1999]`),
   polygons need seven (`[SokolovVoronov2025]` Thm 2, repaired). **Promoted:** link 4's rewrite.

**3.3 §IQ re-read, G72's count and G79's record.**
- *Existence form* (P §IQ 1): is there a Lebesgue-measurable colouring of `ℝ²` with at most six colours, proper at almost every unit pair? Open.
- *Structural form* (P §IQ 2): what every a.e.-proper measurable colouring carries on the unit circle about each point. Answered in part: the
  measurable fan (D1, four derivations); the index of a density trace exists under reading (A) when a continuous lift exists, and its bound
  holds absent a swap (FS106-IND); a swap is forced at a unit-arc interface facing a bowtie (FS106-IND-X). "Finding the index is the
  milestone" (P §IQ 3): found, with the exact place it fails.
- **Did the headline come through the structural question?** No. TQ-EQ came from the quantitative route: a recognition at the prior-art gate
  (S–V §9, drawn at planning) and row 130's weak-* compactness extended to the slack side. The structural form produced TS's lemmas and the
  index no-go. **G72's count: sixteenth, FS-106 — the other kind; the count reads thirteen of sixteen.**
- **G79's record, FS-106:** TQ-EQ from an example invariant (the weak-* limit colouring every near-covering family carries); D1 and TS-T
  (a trichromatic point within `1/√2 + ε` of every point) likewise; the walls arrived as counterexample invariants — C5 and IND-X (what W's limit
  must carry at a failure of the index: a unit-arc interface facing a bowtie), TQ-HIT (what a hitting-form proof cannot exceed), the pixel lemma
  (a counterexample to C-Q-STAB can have no multichromatic coloured point); the one flip made, A2's PD-EQ (the band-pair fraction every CP
  colouring drives to 0), is an example invariant and located R's decisive quantity (one mind, sketch).

**3.4 Expectations E1–E12 (P §5.3), scored.**

| # | expectation | outcome | score |
|---|---|---|---|
| E1 | V-1.1 TRUE, 0.8 | TRUE after repairs (V, VB) | met |
| E2 | SV-2 TRUE, 0.75 | GAP as printed; TRUE after repairs except `d = 2` | half: the theorem likely, the print not |
| E3 | C-CS-1 TRUE, 0.9 | TRUE | met |
| E4 | C-AE-SLACK TRUE, 0.9 | TRUE; forms (a), (b) agree | met |
| E5 | C-AE-CLOSED TRUE, 0.55 | GAP: equivalent to the tight question for essentially closed classes | undecided |
| E6 | C-AE-Q2 TRUE .5 / FALSE .15 / GAP .35 | GAP at four steps | the .35 branch |
| E7 | C-AE-POLY TRUE, 0.65 | TRUE except `d = 2` | met, with a residual |
| E8 | C-T-L1a TRUE .8 / C-T-L1b TRUE .5 | L1a TRUE; L1b TRUE for map-like classes, GAP in general | met / half |
| E9 | C-T-BIKE TRUE, 0.7 | GAP (three colours needed; three by arcs open) | undecided |
| E10 | C-Q-REM / COMP / EQ TRUE .85/.85/.8 | all TRUE, two minds, one blind | met |
| E11 | C-Q-STAB GAP .8 | GAP: it is `χ_m⁰ ≥ 7` itself | met |
| E12 | the closed-set step named, the heart reduced to C-AE-Q2 or C-Q-STAB, both handed to FS-107 | named; the heart is C-Q-STAB **by equivalence**, Q2 a special case | met, sharpened |

Eight met, three half or undecided, none missed outright. The pattern (G21): the expectations that did not land TRUE were the ones about print
holding as printed (E2) and about the method transferring (E5, E9); every expectation about a derivation of our own landed.

**3.5 Conjecture sweep.** `grep -i "conjecture\|not claimed"` over the plan and the seven records: no unpursued conjecture; PD-EQ is "not
claimed" and filed (FS106-PDEQ) with FS-107 as its home; the `d = 2` case, Woodall's merge and SV-1's fills are stubs (items 36, 57).

**3.6 The verdict, in four parts.**
- **The choice:** close FS-106 as *landed*. The regular half is verified in print with repairs, transferred almost everywhere except at named
  steps, and the measurable question is restated exactly as a stability question (TQ-EQ, two minds, one blind). Nothing moves the answer.
- **The alternative weighed:** keep FS-106 open to close its residuals first — SV-2's `d = 2` case, a second mind on SV-L3's transplanted
  bicycle, Woodall's fill of Townsend's (c) walked in full, SV-1's fills under Condition 6.
- **Why this one:** by TQ-EQ the regular classes are no longer the route. Each regular theorem is now a constraint on W's limit, not a path to
  the answer, and FS-107 decides the problem either way. The residuals keep their value as the program's print record and move to stubs.
- **Confidence: high** on the close. **Medium** that every residual is repairable: `d = 2` has no local contradiction found (V3). The fact that
  would change the close: a counterexample at `d = 2` — a polygonal six-colouring. That would be `χ(ℝ²) ≤ 6` with no MR, and FS-107's W would
  become its verification.

**3.7 Would-have-searched log (the close and its jobs).** The close: none (reading and reconciliation). The jobs, collected:
- TS: a global six-colouring extending C5, or a map realising [G3]'s cone → each stated as a local configuration and checked by hand.
- TS: an arc-offset scan for C-T-BIKE → reduced to the forced set, left GAP.
- TQ: an optimiser over periodic grid-square slack colourings, to trace `1 − µ₆(ε)` → the two-sided bracket derived; the trace proposed for
  after 2026-10-01.
- QB: SAT/MILP for a pixelated band-proper colouring → the pixel lemma.
- QB: a Delsarte-type LP bound on `µ₆(ε)` → Lemma F by hand.
- QB: Parts's tiling rebuilt numerically at `δ₆` → left as the named GAP.
- SB: a solver for C5's local colourings → built by hand and checked by sampling.
- SB: random traces for an index violation → the swap derived.
- VB: a numerical grid check of the bicycle's arcs → additivity.
- V2: a float check of Prop. 17's cone colours → by hand.
- V3: a float search for VB's configuration → the closed-form crossing.
- A2: a numerical trace of eroded Parts tilings → FS-107's registered post-ban dial.

### Stage 3 — SAVED
