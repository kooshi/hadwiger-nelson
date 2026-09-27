# Poros — FS-112 plan-phase advisor record (job FS112-A)

*Poros (Opus 5.5), 2026-09-27, planning advisor for FS-112, the unit-arc half, beside the planner FS112-P (de Bruijn). Brief:
`data/fs112/briefs/A112-advisor.md`, with `data/fs112/briefs/STANDING-RULES.md`. HEAD at launch: 96ea0744. This record is **fenced from every
competitor and blind verifier of FS-112** (it carries routes and hunches; `plans/PROTOCOL-competitor-and-advisor.md` §1 rule 1).*

## Theorems this phase proved

*(none — an advisor's record; the one-line computations below are hunches with basis "derived", handed to the jobs, not theorems)*

## Would-have-searched-here log

- Would have fitted coordinates to `[Polymath2021]` Fig. 10's disk numerically. Instead: the printed radius and "the points A,B,C,D,E lie at the
  vertices of a unit-edge regular pentagon" (p. 199) fix the field; the reconstruction is a construction-side derivation by formula.
- Would have scanned tile shapes near `[AxenovichEtAl2014]`'s strip. Instead: its printed description ("symmetric tiles have width 1/2, with the rounded
  boundary being a circular arc of radius 1 centered at the opposite corner of the tile") gives the gothic-arch tile exactly (below, §1.5).

## Fence log

Not a blind job. Read only: the files my brief names, the FS-110 records they point into (`plans/FS110-NB-verification.md` §2.3–2.6,
`plans/FS110-Y-construction.md` §4.5 and stage 5, `plans/FS110-N-proof.md` §2.3's (S1)/(S2) statement), the three frozen checkers' headers, and
the print. No FS-112 job's file other than the two briefs.

---

## Stage 0 — quotation check (standing rule 5)

Every quotation in my brief and the standing rules, against its source, on the page:

| quotation | source | verdict |
|---|---|---|
| rule 0: "From here on out, you may doubt your ability … You are capable, and you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim |
| rule 3: "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time"; "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Toolchain; § Publication | verbatim |
| rule 4: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` item 23 of § Where the problem stands | verbatim |
| rule 10: "It's ok if jobs overrun a bit. …" | Kooshi, 2026-09-27 (session; no file address) | not checkable from disk; logged |
| stub banner: `[Polymath2021]` "to strengthen the seminal result of Thomassen [11]", "(ii) the unit-radius tactic" | issue v30-n4 pdf p. 35 = printed p. 199 ("… (ii) the unit-radius tactic is employed.") | verbatim; the tactic's definition is on printed p. 194 (pdf p. 30), as the banner says |
| stub banner: `[AxenovichEtAl2014]` "with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile" | Thm 4.2's proof | verbatim |
| stub banner: `[Parts2021]` p. 181 "an arc with a radius of 1 centered at the nearest corner of the adjacent tile to slightly reduce the distance between the tiles"; p. 182 "for m = 6, it is possible to reduce k from 31 to 29 (due to reduction of d by only 0.15%)" | issue v30-n4 | verbatim |
| stub banner: `[Parts2020c]` §2.5 "a) vertices in which three or more colored tiles converge are disadvantageous (a void is superior to any such vertex)"; "d) the curving of pairs of opposite tile sides is optimized with a radius of 1/2" | issue v30-n1 | verbatim |
| stub banner: `[Kainen1992]` "(2) CONJECTURE. The chromatic number of the plane is robust." | issue v02-n2 | verbatim |
| my brief: "`[Parts2021]`'s wavy sides save two colours at `m = 6`" | p. 182 | a paraphrase, faithful: `k` from 31 to 29 at `m = 6` |
| my brief: "`[Parts2020c]`'s optimised tilings leave the unit-arc seam by leaving voids" | p. 34 ("In this case, the void boundaries are formed by arcs of radius 1.") and §2.5 (a) | a paraphrase, faithful **for the type-B-only variant**; in the record tiling the curving radius is 1/2 and the tactic is absent (§1.5) |

**One residue found on the page that the banner does not carry** (`[Parts2020c]` § 3, "Future work"), verbatim: *"Here we have restricted
ourselves to the case of highly symmetrical tilings with only a few tiles in the repeating cell, and in the case of k = 6 to tilings in which all
tiles are congruent. There is a chance that using more asymmetric tilings, it will be possible to increase the fraction of the colored plane."* —
and: *"It is very doubtful that Siamese tiles can help in finding a proper 6-tiling"*. The first is the population of the measured prior, in the
author's own words (G21); the second bears on (S1), whose inner arc is a Siamese contact.

## Stage 0 — SAVED

---

## Stage 1 — SAVED: my expectation, written before any planner draft (brief item 1)

### 1.1 The frame on five axes

- **Object.** A locally finite map bounded by segments and circular arcs, radius-1 arcs allowed, carrying a full a.e.-proper six-colouring;
  bounded complexity `K` where door (A) needs it (FS-107's W-EQ-K). Row 134 closed the same object with every radius-1 arc forbidden.
- **Question.** Does it exist (Q-full)? Row 134's route is a chain of local lemmas plus one propagation to infinity (N4-PROP's bi-infinite stuck
  line). With unit arcs, **every seam is already realised locally and exactly** (S1, T2, BB, MX), so no purely local lemma can refute the object on
  the region those fragments cover. The question has become one of **global consistency of local configurations that each exist**.
- **Discipline.** Under Condition 5 the wall was Woodall's and Sokolov–Voronov's map colouring plus Voronov's circle topology. A question of the form
  "local configurations exist; do they fit together over the whole plane?" is the tiling-theory and symbolic-dynamics question (the domino problem;
  a "no" there is proved by a conserved quantity or a propagation, a "yes" by a periodic or hierarchical construction), and the proof technique that
  wins such questions in map colouring is **discharging** (Heesch, Appel–Haken): every local configuration is "reducible" or pays a charge, and a
  global count (Euler's formula) says the charges cannot balance. I register this as a reading, not a route (hunch `h-discharging`).
- **Audience.** Posed twice in print: `[SokolovVoronov2025]` Question 2 and `[Polymath2021]` p. 199 (the stub's banner, item 1).
- **Product.** A NO (answers both, closes door (A)) or a YES (`χ(ℝ²) ≤ 6`, no MR). Everything else is a rung: the localisation, the invariant, the dial.

### 1.2 The seams: what would close each, what would realise each

Reading the fragments against the local calculus, **the three seams are two objects, and both are unit-arc centres**:
- **(S1)** — a three-colour centre: a bowtie `u` at the centre of two boundary arcs of `ω(u)` (through `w₀`, `w₀′`).
- **T2 and NB-4's exception** — one object, a four-colour vertex with its arc budget. T2's seam points are themselves four-colour vertices: in the
  exact fragment `P(w) = {1, 3, 4, 5}` and `P(w′) = {1, 2, 4, 6}` (`plans/FS110-Y-construction.md` stage 5). N-X says a seam point with no unit arc
  through it, between disjoint types, is a four-colour vertex. So T2 at `w₀` *is* NB-4's exception at `w₀`, and A4-SIX-ARCS then demands at least six
  boundary unit arcs centred at `w₀`, or arcs totalling at least 60°. T2's `w` has two of them; it needs four more.

| seam | what would realise it (construction side, by formula) | what would close it (proof side) | my expectation |
|---|---|---|---|
| **(S1)** | **Resolve the arc ends.** The exact fragment closes its arcs by segments, and its arc ends are uncoloured. Y2-S1i item 4: each end is a vertex `x` at distance 1 from `u`, of type `⊇ {b, c, j}` with `j ∈ P(v)`. Its circle `ω(x)` passes through `u`, so `u`'s repeated colour `a` must hold the tangent line of `ω(x)` at `u`, and not only the escape lines at `w₀, w₀′`. An arc-ended (S1) is the next realisation. | Two routes. (a) The cascade at generic `d`: N2-S1 forces `a` at `σ_v^{±1}w₀`, the forced points need seams of their own, and one shows that the cascade cannot close. (b) The arc-end route: the ends' demands on `u`'s `a`-sectors, summed over both arcs, exceed what a bowtie can hold. | **Realisable with resolved ends, locally (0.7)**: the fragment's margins are 30°, and the arcs are short (half-angle ≈ 14°). N2-S1's exceptional distances `{1, √3}` are the triangular lattice's, and the fragments all sit at `d = 1`: **any global (S1) system lives on the unit triangular lattice** (hunch `h-lattice`). There BB's lattice warning already fails at the `C`-points, where more than two covering pairs pass through one seam point. |
| **T2 / NB-4's exception** | A four-colour vertex `w` with its full arc budget: at least six arcs of `ω(w)` in `Γ`, each arc's points and ends resolved. T2 grown until `w` and `w′` are closed. | The arc budget. Each arc of `ω(w)` is bounded on each side by a tile of one of `w`'s colours (TS-U: facing inside, away outside), so it confines that colour's sectors at `w` to a cone narrower than a half-plane (§1.3). **Six arcs at `w`, confining four colours, may overdraw the 360°**, which is NB-4's own 240° < 360° count with the arcs paying in. | **The crux of the milestone (0.6)**: the first obstruction is at a four-colour unit-arc centre (the stub's 0.5, raised). Falsifier: an exact four-colour vertex with six resolved arcs. |

### 1.3 The Condition-5 chain under unit arcs: which steps survive, where the first break sits

**Where Condition 5 fails.** Two distinct unit circles meet in at most two points, so a boundary arc of radius 1 centred at `P` violates Condition 5
on exactly one circle, `ω(P)`. Every step of the chain that reads Condition 5 on a circle `ω(y)` therefore breaks only where `y` is a **unit-arc
centre** (basis: derived, one line).

| step | expectation with unit arcs | the break, where |
|---|---|---|
| **NB-4** | **Broken locally, and exactly**: T2's and BB's seam points are four-colour vertices in exact fragments. Global status open. | at change points `y` of a four-colour ring carrying arcs of `ω(σ_v^{±1}y)`. The centres are ring points. |
| **NB-5** | **Broken locally, and exactly** (S1, T2, BB, MX). | at `w₀` through (S1), or through a four-colour `w₀` (T2). |
| **W-MERGE** (the merge itself, when `int D_c(v) ≠ ∅`) | **Survives (0.75)**: its inputs are contacts on `ω(v)` and the choice of `ρ` off finitely many values, and there are still finitely many vertices within distance `1 ± ρ`. | — |
| **N3-DEG** (`int D_c(v) = ∅` only in Woodall's cone) | **Fails at unit-arc centres (0.7).** An out-type contact of colour `c` along an arc of `ω(v)` of angular length `α` confines `D_c(v)` to a cone of opening `180° − α` (one line: a recolouring direction `e` needs `e·θ ≤ 0` for every `θ` in the arc), and an in-type arc contact does the mirror. So `D_c(v)` can be empty with no cusp horn. **New "arc cones"**: Woodall's reduction stalls at unit-arc centres whose arcs bound tiles of the centre's own colours. That is exactly the tactic's point `P` in `[Polymath2021]`'s definition. | at `v` a unit-arc centre |
| **N4** (shadow, shave, ray, stuck, FIN) | **N4-FIN survives (0.7)**: the inequality chain admits no curvature-1 sequence either (`f̃(1) = ∞`). **N4-SHADOW degenerates** when a horn's flank at `N` is an arc of `ω(v)`: the "circle through `v` concentric with that arc" then has radius 0. | at cone vertices that are unit-arc centres |
| **The base** (S–V Cor. 1 a.e., CB's route with CE's repair) | **The most Condition-5-dependent step (breaks: 0.8).** D1's (P′) reads *"each open arc of ω(y) near x lies in one tile (Condition 5)"*; D4's bicycle runs on circles pseudo-coloured by finitely many arcs; D5's circle-only reduction reads `ω(u)`'s colour changes. D2's strip survives with one exceptional direction per arc through `u`, which is finitely many, unless the chain needs that direction. | at trichromatic `u` whose circle carries a `Γ`-arc (`u` an arc centre), or whose pigeonhole points are arc centres |

**Where the first break sits.** In the chain's order it is NB-4, trivially, and it is already realised locally. The informative statement is the
localisation (hunch `h-loc`): **every step's proof holds verbatim at a vertex whose relevant circles (all centred within distance 2 of it) include no
`ω(P)` with `P` a unit-arc centre.** Then:
- every defect of a tight six-map with unit arcs lies within distance 2 of the set `𝒞` of unit-arc centres;
- trichromatic vertices recur at bounded spacing (K-BICH, and the base's radius), so `𝒞` must be relatively dense;
- at bounded `K` that is allowed, so the question moves to how the arc system closes up.

### 1.4 YB3-SAME: proof or local counter-fragment?

**I expect a local counter-fragment (0.6).** YB3 named the event: a `c`-tile ringed by `d, e, f` is swept by `ω(p)` as `p` runs along a same-type
edge, and `W` changes by ±1. No hypothesis excludes it. The facing constraints look satisfiable, because the edge's two ends are distinct vertices
whose `c`-sectors can face opposite ways (the island Siamese with one end's `c`-tile and outer to the other's). **Bearing on the answer: none.**
- Row 134's chain does not use windings (N3-RED bypasses them).
- With unit arcs, `W` is undefined at every vertex whose ring carries a `Γ`-arc, because the arc cuts the ring's lift.

So a unit-arc route through windings would first have to rebuild a winding with defects. Recommendation: rank YB3-SAME last. One in-ban exact
fragment by the construction side decides the counter-fragment direction. Do not spend the proof side on it.

### 1.5 The print: what it says about the construction side's chances at `m = 1`, and what it does not say

| source | what it measured, and on what population | what it says at `m = 1` | what it does not say |
|---|---|---|---|
| `[Parts2021]` | multi-fold tilings. The tiles are congruent, centrally symmetric and lattice-arranged, with two shape parameters (`w`, `u`). Wavy sides shorten the same-colour distance by at most ≈ 0.8% (p. 181), at `m = 6` by 0.15%, enough to cross one integer (31 → 29). It is "the only successful case of a trick with wavy sides" (p. 183) in `m ≤ 2000`, and is expected "only for small m (practically for m < 40)" (p. 181). | The tactic is a **perturbation of about 1% in separation**, and it decides only next to an integer threshold. At `m = 1` a lattice of congruent tiles needs seven, and a 1% change in separation does not turn seven into six. So within this population the tactic cannot give `m = 1`, `k = 6`. | Anything about maps whose tiles are not congruent, or with four-colour vertices, or where the tactic is used as a seam between tiles and not as a sliver of separation. |
| `[Parts2020c]` | The plane-level optimum of a partial six-colouring over "highly symmetrical tilings with only a few tiles in the repeating cell, and in the case of k = 6 … tilings in which all tiles are congruent" (§ 3, Stage 0 above). The holes are `δ₆ ≈ 1.43·10⁻⁴`. Its findings: vertices where three or more tiles meet lose to voids; the optimal curving radius is 1/2; radius-1 arcs appear only as void boundaries, in the type-B variant (p. 34). | A full map has no voids and must have trichromatic vertices (K-BICH), and **every one of them is a place the measured optimum pays to avoid**. A YES must pay at each trichromatic vertex with a seam (S1, T2, a four-colour vertex) that the optimum never uses. This agrees with FS-110: every close covering pair needs a unit arc. | Whether the voids can shrink to 0 (only fixed designs are measured); anything about asymmetric designs (the author expects they may do better); whether a void can be replaced by a four-colour vertex plus arcs (under (a) it is always worse *given that a void is available*, which a full map does not allow). |
| `[Polymath2021]`, `[AxenovichEtAl2014]` | Found designs that use the tactic: a strip of height `√15/2 + √3 ≈ 3.668` (Axenovich et al.'s Fig. 4; Polymath's Fig. 6) and a disk of radius `√((25 + 9√5)/10) ≈ 2.12426` (Fig. 10). Neither was improved: *"Our failure to discover 6-tilings of larger disks motivates hope …"*. | **The tactic's measured reach is local**: about one to two units past what Condition 5 allows. | Whether 2.124 and 3.668 are bounds or only the designs found. Neither is proved maximal. |

**What none of them says**, and it is the construction side's whole population: formula designs built from the seam calculus. Those are
asymmetric, carry four-colour vertices and use the tactic as a seam between tiles. So the print is a measured prior on a different population. It is
not a cap (§ Counter-priors), and it says nothing at all about the limit.

### 1.6 What I will advise the planner (brief item 2), my leanings before any draft

1. **Claim statements.**
   - Keep **NO_K** (bounded complexity, which door (A) needs) apart from **NO_lf** (every locally finite map, which S–V Question 2 as posed needs).
     Row 134's chain used no `K`; a global count would need it.
   - Add **LOC**, the localisation, as a claim of Q-rule's structural kind.
   - Add **SEAMS-TWO**: T2's seam points are NB-4's exception.
   - Add **ARC-END**: Y2-S1i item 4, extended to four-colour centres.
2. **Killing tests.**
   - **The tactic controls.** The strip and the disk, once reconstructed and checked exactly, are full local six-maps with the tactic. Every NO
     route must fail on them at a named step and say where the plane's extent beyond them is spent: the analogue of the seven-colour control.
   - The fragments (S1, T2, BB, MX) refute every kill confined to their coloured regions.
   - **The Condition-5 control**: every unit-arc lemma, read with no unit arcs, must reproduce row 134's chain step and never contradict it.
3. **The checkers.** **None of the frozen checkers can ACCEPT the strip exactly** (read from their headers):
   - `tools/fs110_y_check.py` and `tools/fs110_yb_check.py` compute in `ℚ(√3)` only.
   - `tools/fs110_yb4_check.py` handles one quadratic field and falls back to intervals, and *"Equality with 1 is only ever asserted exactly"*.
   - The strip's printed height `√15/2 + √3` needs `ℚ(√3, √5)`: its gothic-arch tile has sides `√3/2` and apex `√15/4`. The disk needs `√5` and a
     nested radical. Every tight contact would read AMBIGUOUS, never ACCEPT.

   So a new `tools/fs112_*` checker needs exact arithmetic in a general number field. Calibrate it first on FS-110's `ℚ(√3)` fragments against the
   frozen checkers' verdicts (same inputs, same verdicts), then on the strip. **The strip is [external], and its reconstruction from a figure is a
   derivation**: its ACCEPT calibrates the pair (reconstruction, checker). A REJECT has three possible causes (the checker, the reconstruction, the
   print), and the plan must say how each is told apart.
4. **The contest.**
   - The construction side's first product is a **dial**, not a YES: the largest arc-closed disc or strip it can give by formula, read against 2.124
     and 3.668, and where its designs fail.
   - The proof side's first product is **LOC plus the arc-budget invariant** (G79's example invariant: what every unit-arc centre must carry).
   - The strip and disk reconstructions are the construction side's stage 0.
5. **Fences.**
   - This record and the planner's routes are fenced from both sides and from every blind verifier by path.
   - Standing rule 13's three fences; neutral subjects; no `git log -p` on fenced paths; the close inventory fenced; protocol rule 12.

### 1.7 Hunch ledger (registered 2026-09-27, before any planner draft)

hunch: h-seams-two
  claim: T2's seam points are four-colour vertices, so T2 and NB-4's exception are one object, and FS-112 has two seam species (three-colour and four-colour unit-arc centres), not three
  basis: read
  falsifier: a T2 realisation in which `w₀` carries an arc of `ω(u)` or `ω(v)` and is not a four-colour vertex
  registered: 2026-09-27
  status: open (read: T2's exact fragment has `P(w) = {1, 3, 4, 5}`; N-X, three minds, one blind, forces it when no unit arc passes through `w₀`)

hunch: h-loc
  claim: each Condition-5 step's proof holds verbatim at every vertex none of whose read circles is `ω(P)` for a unit-arc centre `P`, so every defect of a tight six-map with unit arcs lies within distance 2 of the set of arc centres
  basis: derived
  falsifier: a chain step whose proof fails at a vertex whose read circles are all free of `Γ`-arcs
  registered: 2026-09-27
  status: open

hunch: h-arc-cone
  claim: W-MERGE survives unit arcs, and N3-DEG fails at unit-arc centres (`D_c(v)` confined to a cone of opening `180° − α` by an arc contact of length `α`)
  basis: derived
  falsifier: W-MERGE's clearance failing at a vertex with `int D_c(v) ≠ ∅` and a `Γ`-arc of `ω(v)` bounding a `c`-tile; or N3-DEG's dichotomy surviving an out-type arc contact
  registered: 2026-09-27
  status: open

hunch: h-four-colour-crux
  claim: the first global obstruction, if the answer is NO, is at a four-colour unit-arc centre: six or more arcs of `ω(w)` confining four colours overdraw 360°
  basis: analogy
  falsifier: an exact four-colour vertex with at least six resolved unit arcs centred at it
  registered: 2026-09-27
  status: open (0.6)

hunch: h-lattice
  claim: any global system of (S1) seams has its covering pairs at distances in `{1, √3}`, N2-S1's exceptions, so it decorates the unit triangular lattice
  basis: analogy
  falsifier: an (S1) realisation at a distance outside `{1, √3}` whose N2-S1 cascade closes
  registered: 2026-09-27
  status: open

hunch: h-no-local-kill
  claim: no NO argument confined to a disc of radius at most 3 exists; the NO needs a global step (a propagation to infinity like N4-PROP, or a count over growing regions)
  basis: prior
  falsifier: a NO proof whose every step reads a disc of radius at most 3 about one point
  registered: 2026-09-27
  status: open (0.6)

hunch: h-discharging
  claim: the global step, if it exists, is a discharging count: each arc transfers angular budget between its centre and its ends, every trichromatic or four-colour vertex needs a positive net budget, and bounded `K` with a count over a large disc gives the contradiction
  basis: analogy
  falsifier: an exact arc-closed patch in which every vertex's angular demand is met with slack
  registered: 2026-09-27
  status: open

hunch: h-yb3-counter
  claim: YB3-SAME is settled by a local exact counter-fragment (transport fails), not by a proof
  basis: prior
  falsifier: a derivation that the swept `c`-island forces a covering pair or a four-colour vertex
  registered: 2026-09-27
  status: open (0.6)

hunch: h-dial
  claim: in this milestone the construction side gives, by formula and checked exactly, an arc-closed six-map of a disc larger than radius 2.124 or of a strip higher than 3.668
  basis: prior
  falsifier: the milestone's close without such a patch
  registered: 2026-09-27
  status: open (0.3)

hunch: h-answer-no
  claim: the unit-arc half is answered NO (seven colours needed), at bounded `K` at least
  basis: prior
  falsifier: a full tight six-map with unit arcs, given by formula and checked exactly
  registered: 2026-09-27
  status: open (0.85; an instrument for G21, never evidence; a YES by formula in this milestone 0.02)

### 1.8 Cards (fates blank)

question: is-the-no-local-or-global
  evidence: N4-PROP needs a bi-infinite stuck line (`plans/FS110-derivation.md` l. 80); NB-4, NB-5 and Cor. 1 read discs of radius 2 or 3; `[Polymath2021]` p. 199 six-tiles a disk of radius 2.12426 with the tactic; four exact seam fragments
  expected: the unit-arc NO, like row 134's, is a chain of local lemmas plus one propagation
  ask: does row 134's NO hold on every disc of some radius R, and if not, which step is global? The answer sets whether FS-112's NO needs a global step
  if bounded: the unit-arc question has a disc form; the construction side's largest arc-closed disc is a lower bound on the unit-arc R, and the proof side aims at a Voronov-style radius-R argument robust to arcs
  if unbounded: the unit-arc NO needs a named global step (propagation or count), and the claim list carries it as a claim with its own killing test
  answered by: a derivation
  cost: one stage of the proof side, or an hour of the planner reading N4 §2.4–2.8
  hunch: unbounded — N4-PROP is a propagation along a whole line, and NB4-TM's terminal modification is a limit
  falsifier: a truncation of N4-PROP to a segment of bounded length that still contradicts FIN
  rank: 1

question: which-arithmetic-calibrates-the-strip
  evidence: `tools/fs110_y_check.py` and `tools/fs110_yb_check.py` compute in `ℚ(√3)` only; `tools/fs110_yb4_check.py` is one quadratic field plus intervals and asserts equality with 1 only exactly; the strip's height `√15/2 + √3` needs `ℚ(√3, √5)`
  expected: the frozen checkers calibrate on the strip, as the brief asks
  ask: which exact arithmetic will the new checker use, and which known positive in that arithmetic does it pass before the strip?
  if a general number field: calibrate on FS-110's fragments against the frozen verdicts, then the strip; a strip REJECT is diagnosed by pair and cause
  if intervals only: the checker cannot ACCEPT any tight contact, so it cannot certify a tight map at all; redesign before any refusal is believed
  answered by: the record
  cost: minutes (the headers are read)
  rank: 2

question: are-the-seams-two
  evidence: T2's exact fragment has four-colour seam points `P(w) = {1, 3, 4, 5}`, `P(w′) = {1, 2, 4, 6}`; N-X (three minds, one blind); A4-SIX-ARCS (one mind)
  expected: three seams, three objects, as the stub lists them
  ask: does the claim list treat T2 and NB-4's four-colour exception as one object, the four-colour unit-arc centre?
  if one: the contest has two seam objects, and the four-colour centre's arc budget is the proof side's first target
  if three: the planner names what distinguishes T2 from NB-4's exception at the seam point
  answered by: the planner
  cost: one line in the claim list
  rank: 3

### 1.9 Evidence inventory

- `data/fs112/briefs/A112-advisor.md`, `STANDING-RULES.md` — read against: a plan-phase advisor brief like FS-110's — surprised: no
- `plans/STUB-unit-arc-half.md` with its banner — read against: three seams and a winding GAP — surprised: yes; the banner's print makes the tactic the common tool of every good printed six-tiling
- `LEDGER.md` rows 131–134 — read against: row 134 as the closed Condition-5 half — surprised: no
- `plans/FS110-derivation.md` — read against: the chain as the stub names it — surprised: yes; N4-PROP is the chain's one global step, and it matters for FS-112's shape (card 1)
- `plans/POROS-2026-09-27-fs110-competition.md` A5-5, A6-2, A6-3 — read against: a hand-over to FS-112 — surprised: no; A5-5.6's "three objects and no single invariant" is contradicted by T2's four-colour seam points (card 3)
- `data/fs110/claims.md` §0–§9 — read against: the claims FS-112 inherits — surprised: no
- `plans/FS110-NB-verification.md` §2.3–2.6 — read against: NB-4 as "a 60° squeeze" — surprised: yes; the squeeze runs through the ring's change points, and the exception's arcs are centred at ring points `y_{k±1}`, not at `v`
- `plans/FS110-Y-construction.md` §4.5, stage 5 — read against: fragments with their arcs resolved — surprised: yes; S1's arc ends are uncoloured (arcs closed by segments), so "(S1) realised" is realised with open ends
- the three frozen checkers' headers — read against: checkers that can take the strip — surprised: yes; none can ACCEPT it exactly (card 2)
- `[AxenovichEtAl2014]` Thm 4.2 — read against: a strip given by coordinates — surprised: yes; given by a sentence and a figure, no coordinates
- `[Polymath2021]` pp. 190–201 — read against: the question posed and the strip — surprised: yes; a six-tiled disk of radius 2.124 exists in print, a stronger local positive than the strip for disc-local arguments
- `[Parts2021]` pp. 177–189 — read against: the tactic measured at `m = 1` — surprised: no; it is measured only as a separation sliver in a congruent lattice family
- `[Parts2020c]` §2.5 and § 3 — read against: the voids as the whole story — surprised: yes; § 3 states its own population (congruent, symmetric) and doubts Siamese tiles, which (S1)'s inner arc is
- `plans/PROTOCOL-competitor-and-advisor.md` §1 — read against: the fences as amended — surprised: no

## Stage 1 — SAVED

---

## Stage 2 — SAVED: the planner's stages 1–3 read against my expectation; advice sent (brief item 2)

*Read: `plans/FS112-unit-arc-half.md` stages 1, 2a, 2b, 3 (commits 13b13328, 0085b7df, 9a493af4, 619ea64e) and FS112-P's message with its §G bears
list. Also `plans/POROS-2026-09-27-fs110-competition.md` l. 608–625 (A4-SIX-ARCS and A4-TSU, verbatim).*

### 2.1 Against my expectation

- **Convergences, reached independently** (my §1 was committed first, at 1ad0ee6c):
  - the chain walk as the proof side's stage 1, with the verdicts survives / survives off centres / fails;
  - the four-colour vertex's arc budget as §IQ (b) (my `h-four-colour-crux`);
  - the strip rebuilt by formula as the construction side's first calibration;
  - YB3-SAME as a counterexample invariant (G79).
- **What the planner found that I did not:**
  - the Polymath16 threads 6–9 (2018): Hockertz's reduction claim, de Grey's six-colour-vertex Reuleaux argument, and Gibbs's "constraint". The
    question was worked informally in 2018;
  - `[Parts2022]` p. 190's band triangle argument;
  - the tight seven-colouring as a second checker control (G20).
- **What I found that the plan did not have at stage 3:**
  - the disk of radius 2.124 as a control;
  - the frozen checkers' arithmetic;
  - N4-PROP as the chain's only global step;
  - the per-circle scope of Condition 5.
- **Divergences:**
  - the planner reads the strip as "self kind only" and says nothing held calibrates the pair kind; I read both claims as false (below);
  - §IQ (b)'s paraphrase of A4-SIX-ARCS drops its hypothesis;
  - §IQ item 5 puts YB3-SAME among instances a unit arc might break, but YB3-SAME is a Condition-5 statement.

### 2.2 Advice sent to FS112-P (SendMessage, eight items; the planner decides)

1. **The arc kinds.**
   - Polymath's tactic is self and pair at one arc. Its T touches P and borders `E ⊂ ω(P)`.
   - Polymath says the strip "makes use of a tactic that we shall also employ below". Fig. 6's caption: "The sloping boundaries are arcs of radius 1,
     as explained in the main text". So the strip's pair kind is to be read from the reconstruction.
   - The pair kind is calibrated locally by FS-110's S1: `u_b`–`w′_out` = `[1, 1.35]` along an arc of `ω(u)`
     (`plans/FS110-Y-construction.md` §4.5).
   - Proposal: define the kinds in N3-CONF's vocabulary — in-contact, out-contact, both, inert — by the arc's side colours in `P_cl(P)`. With it, a
     claim ARC-INERT.
2. **§IQ (b) drops A4-SIX-ARCS's hypothesis** "with no covering pair (v, y), y ∈ ω(v)". On the other branch NB §2.3 puts the arcs on
   `ω(σ_v^{±1}y)`, centred at ring points. NB-4's printed exception reads "ω(y_k) … passes through y_k", which is impossible; it is a MISSTATED
   suspect, likely `ω(v)`.
3. **YB3-SAME** has no unit arc and no bearing on the answer. Rank it last, as a construction-side fragment.
4. **Condition 5 fails on exactly one circle per arc**, `ω(P)`. The walk names, per step, the circles it reads.
5. **Local or global.** N4-PROP is the chain's one global step. The strip and the disk are local six-maps with the tactic. Every NO route must fail on
   them at a named step; the global step becomes a claim.
6. **Checkers.** None frozen can ACCEPT the strip exactly. Build a new checker with general number-field arithmetic and calibrate it in this order:
   FS-110's fragments with the frozen checkers' verdicts, then the seven-colouring, the strip, the disk. An ACCEPT calibrates the pair
   (reconstruction, checker). A REJECT has three causes. Two independent reconstructions.
7. **SEAMS-TWO** as a claim: T2's seam points are four-colour vertices.
8. **The 0.03's population.** Take it from `[Parts2020c]` §3's own words. Register a dial beside it: the largest arc-closed disc or strip (0.3).

Fences: this record, fenced by path from both sides and every blind verifier.

### 2.3 Hunches (new; registered 2026-09-27)

hunch: h-arc-inert
  claim: a unit arc of `ω(P)` neither of whose side colours lies in `P_cl(P)` can be bent off curvature 1, locally and keeping the map valid, so every tight six-map with unit arcs may be assumed to have an in- or out-contact at every arc's centre
  basis: derived
  falsifier: an inert unit arc in a tight fragment whose every small bend creates a same-colour pair at distance exactly 1
  registered: 2026-09-27
  status: open (sketch: an arc of `ω(P)` is at distance exactly 1 from `P` along its length and from any other point at at most two of its points)

hunch: h-nb4-slip
  claim: NB-4's printed exception "no Γ-arc of ω(y_k) or ω(y_{k±1}) passes through y_k" is a slip for "of ω(v) or ω(y_{k±1})"
  basis: read
  falsifier: NB's author, or a re-derivation, showing an arc of `ω(y_k)` enters the argument at `y_k` in another sense
  registered: 2026-09-27
  status: open (`plans/FS110-NB-verification.md` §2.3; `ω(y_k)` is centred at `y_k` and cannot pass through it)

### 2.4 Cards: fates

- `is-the-no-local-or-global` (rank 1): sent to the planner as item 5; fate blank until the claim list.
- `which-arithmetic-calibrates-the-strip` (rank 2): sent as item 6; fate blank.
- `are-the-seams-two` (rank 3): sent as item 7; fate blank.

### 2.5 Evidence inventory (additions)

- `plans/FS112-unit-arc-half.md` stages 1–3 — read against: my §1 — surprised: yes; the Polymath16 threads carry the question in 2018 (Hockertz, de Grey, Gibbs), which my expectation did not know
- A4-SIX-ARCS verbatim (FS110 competition record l. 612) — read against: §IQ (b)'s paraphrase — surprised: yes; the hypothesis "no covering pair (v, y), y ∈ ω(v)" is dropped in the paraphrase

## Stage 2 — SAVED

---

## Stage 3 — SAVED: the claim-list draft reviewed (brief item 2, continued)

*Read: `data/fs112/claims.md` at b8e561c2 in full; FS112-P's message (all eight stage-2 items adopted, a reservation on the disk). Rendered:
`[Polymath2021]` Fig. 10 (pdf page 36 at 110 dpi), kept at `data/fs112/fs112-a/polymath2021-p199-fig10-disk.png`.*

### 3.1 Correction to my own stage-2 item (sent at once, before the claim list)

ARC-INERT as first sent ("an arc of `ω(P)` is at distance exactly 1 from `P` alone and from any other point `Q` at at most two of its points") handled
a point against the arc, not a tile against the arc. Sent corrected:
- the whole-sub-arc same-colour contacts of an inert arc are only a Siamese contact (which forces `P ∈ cl`, so not inert) or an outer contact along
  the concentric circle of radius 2 about `P`, and only the inner colour can make that one;
- the inward bend is free away from isolated contact points;
- the claim is a GAP at those points.

**Retractions so far: FS112-A 1** (free: nothing built on it; the planner filed the corrected form verbatim).

hunch: h-arc-inert
  status: narrowed (2026-09-27): TRUE off isolated contact points, a GAP at them; one mind; filed as ARC-INERT in `data/fs112/claims.md` §6

### 3.2 Advice sent on the draft (seven items; the planner decides)

1. **Stale vocabulary.** "self, pair, free" remains in §2 C-S1-G, §3's C-CHAIN question and §6 C-UA-INC, but §0 now defines in/out/both/inert.
2. **C-SEAMS-TWO drops N-X's "disjoint types".**
3. **C-GLOBAL is misnamed and unconditional.** It is the condition the positives force; call it C-BEYOND, with the disk's clause conditional on
   CAL-DISK. The open question, whether any bounded-radius NO exists, becomes C-LOCAL (my rank-1 card).
4. **CAL-DISK.** No printed rule exists in words, but Fig. 10 is legible. A by-eye transcription of its combinatorics, then exact solving, is
   derivation, as at FS-85 (protocol §1 rule 11). Fitting to pixels is out. The rebuild must reproduce `r² = (25 + 9√5)/10` exactly. The disk is the
   only positive for disc-local arguments at radius 1.834–2.124.
5. **Killing test 4 (G17) cannot fire as written.** FS-110's fragments have open arc ends. Proposed: C-ARC-END, the arc-closed fragment as the
   informative local object, and the construction side's first product as the dial.
6. **C-HOCK's pointer.** N4's horn curvatures `(−1, 1)` are radii > 1, which Hockertz allows. The first test is A6-C2's (or WC's) radius-9/10 arc.
7. **Killing tests 7 and 8 are out of order.** Also: the construction side's blind verifier rebuilds the strip independently.

### 3.3 Cards: fates

- `is-the-no-local-or-global` (rank 1): the planner filed C-GLOBAL as a necessary condition from the positives. I asked for the open question as a
  separate claim (C-LOCAL). Fate: partly answered (the positives' condition filed); the question itself pending the planner's decision.
- `which-arithmetic-calibrates-the-strip` (rank 2): **answered** — adopted as §7 "The checker" (exact number-field arithmetic, the order FS-110 →
  CAL-7 → CAL-STRIP → CAL-DISK, three REJECT causes, two rebuilds). It changed the plan.
- `are-the-seams-two` (rank 3): **answered** — filed as C-SEAMS-TWO; a hypothesis to restore (item 2).

### 3.4 Evidence inventory (additions)

- `data/fs112/claims.md` at b8e561c2 — read against: my stage-2 advice adopted cleanly — surprised: yes, mildly. Adopting the kinds left the old
  words in three places, and a second dropped hypothesis appeared (N-X's "disjoint types"), the same failure standing rule 5 exists for.
- `[Polymath2021]` Fig. 10, rendered — read against: an illegible figure with no rule — surprised: yes. It is legible: labels A–E, C and D on the
  boundary circle, curved edges visible. A combinatorial transcription is feasible.

## Stage 3 — SAVED
