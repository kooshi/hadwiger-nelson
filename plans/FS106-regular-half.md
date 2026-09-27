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
| **TS** the structural route: regular classes a.e., then the transfer | FS106-TS (`TS106-structural.md`) | C-AE-Q2 first (and C-AE-Q2-EV), then C-AE-FA, C-AE-POLY, C-AE-MAP6, C-AE-NICE, C-AE-CONV; then C-T-L1a, C-T-L1b, C-T-BIKE, C-T-TAN, C-T-TRI, C-T-CHR4, C-T-ANN, C-T-IND, C-T-PIG, C-T-KILL | 1 | `plans/FS106-TS-derivation.md` | ~300k, hand back by 400k; stop at a saved stage; C-AE-Q2 gets a verdict or a named GAP before any C-T claim | 2 |
| **TQ** the quantitative route | FS106-TQ (`TQ106-quantitative.md`) | C-Q-REM, C-Q-COMP, C-Q-EQ, then C-Q-STAB and C-Q-HOLE | 1 | `plans/FS106-TQ-derivation.md` | as TS; C-Q-EQ gets a verdict before C-Q-STAB | 2 |
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
| E11 | C-Q-STAB | decided in FS-106: TRUE 0.1, FALSE 0.1; GAP at C-Q-HOLE 0.8 | FALSE is a sequence of six-colourings with shrinking holes, a construction; TRUE is HN's measurable form given C-Q-EQ |
| E12 | the milestone | the closed-set step named (C-CS-1) and the heart reduced to C-AE-Q2 or C-Q-STAB, both handed to FS-107 | a TRUE on C-Q-STAB or a FALSE on C-AE-Q2 ends the question here |

Per the counter-priors, these numbers are instruments, not caps: none shrinks a claim or stops a job.

### 5.4 Hand-over to FS-107 (drafted now, rewritten at the close)

- **R's targets:** whichever of C-AE-Q2, C-T-L1b, C-T-ANN, C-T-IND, C-Q-HOLE is GAP — each a named step.
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
