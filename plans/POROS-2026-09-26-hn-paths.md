# Poros — paths to the full answer of Hadwiger–Nelson, and to its Lean verification (job PA1, 2026-09-26)

*Advisory record for job PA1 (brief `data/paths-2026-09-26/briefs/PA1-poros-paths.md`, standing rules
`data/fs105/briefs/STANDING-RULES.md` read as "this job"). Written by Poros, Opus 5.5. No planner beside me; this record is the
options Kooshi chooses from. Current state only within each stage; stages are appended and saved in order.*

## Stage 1 — SAVED (the expectation, written before any search or any reading of rows 100–130)

### 1.1 Quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| Kooshi, 2026-09-26: "My goal is to fully solve, and then verify in Lean, HN. Then we publish. (Anything we do must be formalized in Lean before publishing, that's the bar for AI found proofs, and I think we can go all the way to an HN solution)." | `CLAUDE.md` line 111 (§ Publication) | matches word for word; the brief's continuation ("Your recommendation does sound good to me, but spawn a Poros advisor …") is not in any file — it is the owner's transcription, unverifiable from disk, and nothing below rests on it |
| Kooshi on FS-62: "one possibility with some soft evidence" | `CLAUDE.md` line 276; `data/rerank-2026-09-26/briefs/R1-rerank-planner.md` line 16: *"It's just one possibility with some soft evidence."* | a verbatim substring; matches |
| "Where things stand" (three bullets) | the brief calls them orientation, not a source | checked against rows 128–130 in stage 2 |

### 1.2 My expectation (registered before reading the ledger rows, the stubs or any paper)

**Which value.** My prior on `χ(ℝ²)`: **7 at 0.55, 6 at 0.30, 5 at 0.15.** Basis: prior (the literature's mood and its
structural facts as I recall them, none re-read today) — every "nice" colouring class that has been fully analysed needs seven
(hexagonal and polygonal colourings, `[SokolovVoronov2025]`; cell colourings, rows 34–41; G22), every relaxation that is not
integral stops near 4.36 (the fractional chromatic number; row 129 as the brief summarises it), and every lower bound above four
came from a finite witness, never from analysis. Seven is favoured because no one has ever seen a six-colouring of any
structured kind, and five is disfavoured because a five-colouring would have to be wild in a way no construction has hinted at.
Confidence in this prior: **low** — it is exactly the kind of fluent prior this job exists to distrust. What would move it most: a
measurable six-colouring of any kind (→ 6 or 5 up to ~0.5), or a finite six-chromatic unit-distance graph (→ 6 or 7, with 7
favoured).

**Where a proof would most likely come from** (my expectation, before reading how the project now frames it):
1. **From below, six** — most likely from a **finite witness** found by search and certified through the existing LRAT checker
   (the only route that has ever moved the lower bound: Moser 1961 → de Grey 2018), *unless* the collapse to measurable colourings
   (rows 128–130, "given MR") turns an **analytic** argument into a proof of six. I expect the analytic route to need a *joint*
   (multi-class) constraint, not a one-class density bound, and I expect it to be harder than it looks.
2. **From below, seven** — I expect no finite witness is findable (a seven-chromatic unit-distance graph, if one exists, is likely
   astronomically large), so seven would have to come from analysis on the collapsed (measurable) problem, or from a structural
   theorem saying colourings of a field plane are "tame" enough that the polygonal bound applies.
3. **From above, five or six** — only from an explicit construction; I expect none within reach, and I expect the project's
   instruments (residue maps, characters, cut-and-project windows) all to cap at seven or above for the fields that matter.
4. **The Lean side** — I expect the finite-witness route to be the cheapest to formalize by far (the pipeline exists and rung B
   went through it), and any route through MR (entropy, leafwise measures, Einsiedler–Lindenstrauss) to be **very high** cost —
   plausibly years of Mathlib work — so that the cost criterion will favour routes that avoid MR or use only a weak, formalizable
   fragment of it.

**Probability that the project reaches the full answer**, meaning the value of `χ(ℝ²)` proved *and* formalized: **about 0.03–0.05**
over the next year, all routes together. Probability that it reaches a *new bound* (six from below, or a conditional collapse
formalized) in that time: **about 0.15**. These are priors, basis prior, and I register them so the stages below can be scored
against them.

### 1.3 Hunches registered at the opening

Three hunches were registered here before any reading (commit `b96d82da`): `mr-is-the-formalization-bottleneck`,
`six-needs-a-joint-constraint`, `the-finite-witness-route-is-cheapest-in-lean`. Their entries, with the same claims and dates and now scored,
are in §3.5.

### 1.4 "Would have searched here" log

- (none yet)

## Stage 2a — SAVED (the survey, and paths P0–P2)

### 2.0 What I read, against what I expected (evidence inventory)

- `LEDGER.md` rows 120–130, read in full; rows 100–119 by headline only (sampled, not read whole) — read against: "every headline above five rests on MR" — surprised: yes; in one place: row 128's *load-bearing step* and row 130 (`χ_CP = χ_m⁰ = χ(A_σ)`) are stated **with no MR**; MR enters only to remove the SP witness. So MR is needed for exactly one arrow, `χ(ℝ²) ≥ χ_m⁰(ℝ²)`.
- The brief's three "where things stand" bullets, against rows 128–130 — read against: "the owner paraphrased" — surprised: no; each matches its row (row 129 says `1/α_loc ≤ 4.36`; the brief's "below 4.37" is the same bound).
- `plans/FRONTIER-STUBS.md` rows 1–10, first 1,800 characters each (sampled) — read against: "the table is about six and about fields" — surprised: no; rows 2–4, 7–9 are the product-locality cluster (six at a field *below* the plane's number), not the plane's value.
- `plans/STUB-cp-plane-six.md` (FS-104), whole — read against: "route (d), an MR-free invariant LP, is named" — surprised: yes; it is named (`χ(ℝ²) ≥ χ_g(H)` "by amenability alone, no MR") and ranked **last**, behind three routes that each need MR.
- FS-103 §R-close stage 3 (whole) and FS-105 §R-close 3.6 (the verdict) — read against: "MR's residual risk is one external theorem" — surprised: no; (EL2021 Thm 1.3 by statement, its `[11]` Prop. 6.4 unread).
- `BIBLIOGRAPHY.md` rows for Falconer, Woodall, Townsend, Coulson, Pritikin — read against: "Falconer bounds `χ_m⁰`" — surprised: yes; `[Falconer1981]` Thm 2 "bounds `χ_m`, not `χ_m⁰` (its Lemma 1 meets the null boundary in one point)". So Falconer's "+1" mechanism lives on the null set that `χ_m⁰` ignores — the real reason the owner's null-set step matters (P0 below).
- Mathlib at the project's pin (`.lake/packages/mathlib`, grepped by statement shape) — read against: "none of the analytic inputs exist" — surprised: yes; partly. **Present:** Prokhorov (`MeasureTheory/Measure/Prokhorov.lean`), Riesz–Markov–Kakutani, Følner sequences (`MeasureTheory/Group/FoelnerFilter.lean`, definitions and means), the Lebesgue density theorem (`ae_tendsto_measure_inter_div_of_measurableSet`), the mean ergodic theorem, Birkhoff sums, topological entropy, adele rings, `PontryaginDual` (the definition). **Absent:** measure-theoretic (Kolmogorov–Sinai) entropy, leafwise/conditional measures along foliations, Einsiedler–Lindenstrauss anything, Bochner's theorem, Bessel functions (the three "Bessel" hits are Bessel's inequality), invariant means / amenability of solvable groups, Markov–Kakutani, Pontryagin duality as a theorem, Tarski's quantifier elimination. The project itself holds de Bruijn–Erdős (`Proofs/HadwigerNelson/Bridge.lean`) and the LRAT checker (rung B).

### 2.1 One elementary fact the paths below use (derived here, [hand, one mind — mine]; needs a second)

**(E) `χ(ℝ²) ≤ χ_m⁰(ℝ²)`, with no MR, by a random rigid motion.** Let `c` be a measurable `k`-colouring whose monochromatic unit pairs
`N = {(x, θ) : c(x) = c(x + e^{iθ})}` are null in `ℝ² × S¹`. For a finite unit-distance graph `H` and an edge `(h_i, h_j)`, the map
`(φ, t) ↦ (R_φ h_i + t, φ + arg(h_j − h_i))` is a measure-preserving bijection of `S¹ × ℝ²`, so the motions `g = (φ, t)` making that edge
monochromatic under `c ∘ g` form a null set; finitely many edges, still null; so `χ(H) ≤ k`, and de Bruijn–Erdős gives `χ(ℝ²) ≤ k`. This is
the upper half of the collapse by a route that avoids CP colourings, the adelic completion and MR (rows 125 and 130 reach the same inequality
through `χ_CP`, two minds). **Consequence for planning:** *every* upper bound on `χ(ℝ²)` can be MR-free (a measurable a.e.-proper colouring),
and every lower bound can be MR-free if it is a certificate (a finite graph, or the invariant certificate of P1). **MR is needed for exactly one
kind of result: an analytic lower bound on `χ_m⁰` transferred to `χ(ℝ²)`.** Its Lean cost therefore attaches to one path family, not to the
problem.

### 2.2 The paths (first half)

**P0 — the baseline to beat (the owner's): FS-104, `χ_CP(ℝ²)` at six, first colouring Falconer's null set.**
- *What it proves.* First milestone: `χ_m⁰(ℝ²) = χ_m(ℝ²)` (if some a.e.-proper colouring's metrical boundary `E` is list-colourable from lists
  of size ≥ 2 — FS103-M's D1–D5); with MR, `χ(ℝ²) = χ_m(ℝ²)`, Falconer's measurable chromatic number. That is a **collapse of HN to a named
  45-year-old open problem** (the write-up Kooshi named), and it makes Falconer-type boundary arguments — the only "+1" mechanism in print
  beyond densities — usable for HN. Then six needs `χ_m(ℝ²) ≥ 6`, open since 1981.
- *Rests on.* MR (row 120: EL2021 Thm 1.3 by statement + FS105-DED), row 128's load-bearing step (no MR, two blind + two held), row 130's M1
  (two), D1–D5 (one mind), and the open `χ_m ≥ 6`.
- *Lean cost:* **very high.** MR needs KS entropy for `ℤ^d`-actions and Einsiedler–Lindenstrauss's leafwise-measure machinery (none in
  Mathlib); the collapse needs spectral measures on the solenoid `R̂` (Bochner absent; Pontryagin duality only as a definition), a mixing
  selection over infinitely many places and weak-* orbit closures (Prokhorov present); the null-set step itself is moderate (Lebesgue density
  is in Mathlib). The first milestone is cheap on paper; the path is ruinous to formalize because of what sits under it.
- *First milestone and kill.* D1–D5 with M's hunch (two adjacent boundary points cannot both carry the list `{a, b}`). Kill: an a.e.-proper
  colouring with such a pair, or a finite configuration forced inside `E` that is not 2-list-colourable.
- *Probability it reaches the answer (value + Lean, one year):* **0.005.** The first milestone names the value and does not move it.
- *Search:* none (derivation); later FS-104's route (d) is an LP, post-ban.
- *Evidence:* the chain [hand, ≥ two minds] except D1–D5 [hand, one]; that six follows: **none**; soft evidence *against* quick progress: `χ_m`
  has not moved since 1981, and "remove measurability from Falconer" was tried on Polymath16 in May 2018 and not done (FS-103 §R-close 3.2 item 5).

**P1 — the invariant certificate: MR-free, a finite witness compressed by its symmetry (FS-104's route (d), promoted and made the lead).**
- *The object.* For a finite `H ⊂ ℝ²` and a finite set `Φ` of isometries, `χ_g(H; Φ)` is the least `k` for which there is a probability
  distribution on proper `k`-colourings of `UD(H)` whose marginals agree along every `φ ∈ Φ` (the law on `S` pushed by `φ` equals the law on
  `φ(S)`, whenever `S, φ(S) ⊆ H`). Three facts, derived here [hand, one mind each — mine; each needs a second]:
  1. **`χ(ℝ²) ≥ χ_g(H; Φ)`, no MR** — `Γ = ⟨Φ⟩` is a subgroup of the solvable Euclidean group, hence amenable; average the pattern of any
     colouring on `gH` over a Følner set of `Γ`. With a certificate of margin `δ`, *one* Følner set with boundary ratio below `δ`/(total weight)
     suffices, so the proof is finite and exact — no limits, no invariant mean. (Tao's Polymath16 remark that finitely additive
     isometry-invariant random colourings exist at every `k ≥ χ` is the in-print ancestor, FS-103 §R-close 3.2 item 5.)
  2. **`χ(H) ≤ χ_g(H; Φ) ≤ χ(ΓH)`**, and `sup_H χ_g = χ(ℝ²)`. So the certificate is never weaker than a finite witness and never stronger in
     the limit: its whole value is **compression** — a small `H` and a few isometries standing for a witness spread over a Følner set of `ΓH`
     (G72's third move — "a finite witness has to rebuild the symmetry by brute force" — applied to rung D).
  3. **The certificate inherits the field wall: `χ_g(H; Φ) ≤ L(F)` when `H` and `Φ` are defined over `F`.** Colour each coset of `O_𝔭²` (𝔭 a
     stable place realising `L(F)`, whose unit vectors are integral) by `x ↦ c₀(v·r(x − p_C) + s)` with `v` uniform in the norm-one torus mod 𝔭
     and `s` uniform in the residue plane, independently per coset: the law is invariant under every `F`-isometry and every sample is proper. So
     **a certificate for six must be drawn in a field with `L ≥ 6`** — the collapse fields (ℚ(√635087), triangle-free; de Grey's field) or `K(√7)`
     — a free theorem that aims the instrument before it runs, and a control: over K or K(√5) it must stop at 4 and 5.
- *What it proves.* `χ(ℝ²) ≥ 6` (or 7) **unconditionally**, from a certificate a stranger checks without MR.
- *Rests on.* Nothing held above five; row 128 says only where to look (given MR, a collapse field loses nothing against the plane).
- *Lean cost:* **medium, and low for a crystallographic `Φ`.** The averaging lemma for `ℤ^r` translations plus a finite rotation group is
  elementary (boxes); for rotations of infinite order `Γ` has exponential growth (a Baumslag–Solitar-like group) and explicit Følner sets are a
  real but bounded job. The dual certificate is "every proper 5-colouring of `H` gives `Σ_S w_S f_S ≥ 1`", a pseudo-Boolean refutation the
  existing LRAT checker can carry after a cardinality encoding. Exact geometry in a number field: held.
- *First milestone (in-ban, derivation):* second minds on facts 1–3; then the **calibration question at five**, the known positive: *is there
  `H ⊂ K(√5)²` with `χ(H) = 4` and `χ_g(H; Φ) ≥ 5`, far smaller than Parts's 509?* Post-ban, the LP answers it. **Kill:** no such `H` up to a
  priced size, or a derivation that the pure-combinatorial invariant bound equals `χ_f`-type bounds (then it caps at 4.36 like row 129).
- *Probability it reaches the answer:* **0.02.** *Soft evidence against:* pure configurations never beat `m₁ < 1/4` — that took Fourier
  analysis (`[AmbrusEtAl2023]`) — so invariance at one class is weak; the joint (all-classes) version is untested. *For:* G72's
  kilobytes-against-10⁸ at three colours.
- *Search:* the LP and the choice of `H` are post-ban; facts 1–3 and the LP's shape are in-ban derivations.

**P2 — the finite witness, aimed by the collapse (post-ban).**
- *What it proves.* `χ(ℝ²) ≥ 6` (or 7), unconditionally, through the rung-B pipeline (exact geometry, LRAT in the kernel).
- *What the collapse adds.* Given MR, a six-chromatic unit-distance graph exists iff one exists over ℚ(√635087) (triangle-free) and iff one exists
  over de Grey's field (row 128): the search may stay in one field of degree 2 or 16, and G65's degree law, G53's counting screen and FS-49's
  distance-2 gadget on `[ExooIsmailescu2019]`'s host are the aiming instruments.
- *Lean cost:* **low to medium — set by the witness's size.** Rung B's graph went through; a witness of `10⁵`–`10⁶` vertices is untested
  against the kernel's cost model (feed the core, G/"The kernel's cost model"). Pritikin: a seven-witness has more than 6,197 vertices.
- *First milestone and kill (post-ban):* a priced search at six in a collapse field with the degree law aimed before any ball is built; kill:
  the law prices every refusal ball beyond the machine (G65's `N₁₄`), as it did at FS-61 for four colours over ℚ(√47).
- *Probability:* **0.015.** *Evidence:* existence iff HN ≥ 6 (compactness, derived); findable size: none; soft against: Polymath16 and Heule
  searched hard for six and reported nothing.
- *Search:* yes — the path *is* search; banned to 2026-10-01.

**Fact 3's second mind should check two details I passed over:** reflections (conjugation acts on the residue plane; randomise over it too, it
is an automorphism) and a dyadic inert place realising `L(F)` (the same construction on `U_Q`). Fact 1's proof needs a right-Følner set
(`|F_N φ Δ F_N| / |F_N| → 0`), which amenability supplies.

## Stage 2b — SAVED (paths P3–P5)

**P3 — six for `χ_m⁰` by analysis: correlation hierarchies on the product graph, transferred through MR.**
- *The frame.* Row 129 proves the per-class route caps at `1/m₁ ≤ 4.36`. That cap is a statement about one colour class of `UD(ℝ²)`. The
  classical door, in combinatorial optimisation's words: **`G` is `t`-colourable iff the Cartesian product `G □ K_t` has an independent set
  meeting every fibre** (the Gvozdenović–Laurent reduction of `χ` to `α`; recalled, not read). For the plane: `χ_CP(ℝ²) ≤ t` iff
  `UD(ℝ²) □ K_t` carries a rigid-motion-invariant random independent set of density exactly `1/t` per fibre. A *single* independent set of
  the product is a *whole* colouring, so density bounds on the product graph are not subject to row 129's cap; the gain appears only at
  higher levels of a moment (Lasserre / `k`-point) hierarchy — level one is the vector-colouring bound, below `χ_f`. With the collapse, `χ_CP
  = χ(A_σ)` (BDOV's operator chromatic number, row 130), so the operator-SDP literature (Bachoc–DeCorte–Oliveira–Vallentin 2014;
  DeCorte–Oliveira–Vallentin's complete-positivity bounds; de Laat–Vallentin's `k`-point hierarchy) **now bounds HN, given MR**, where before it
  bounded only a measurable relaxation.
- *What it would prove.* `χ_m⁰(ℝ²) ≥ 6`, hence (MR) `χ(ℝ²) ≥ 6`; or, if it provably cannot pass 5 at every level, a no-go of a named format.
- *Rests on.* MR (row 120), row 128, row 130; an unproved completeness statement (does the hierarchy converge to `χ_CP`? — a derivation owed).
- *Lean cost:* **very high**: Bessel functions (absent; `J₀`'s minimum `−0.40276` is one line on paper and weeks in Lean), Fourier analysis
  on `ℝ² ⋊ SO(2)` and Bochner (absent), SDP certificates with transcendental entries (interval arithmetic), **plus P5** (MR in Lean) to
  transfer. The costliest route in the table.
- *First milestone (in-ban, derivation):* the level-two shape of the product-graph hierarchy for `k = 5` and whether its value can exceed
  4.36 at all (a derivation, as FS-104's route (c) asks: "its shape derived first"); kill: a proof that every finite level equals `χ_f` on
  vertex-transitive amenable graphs, or that level two stays below 5.
- *Probability:* **0.005** (the answer and its Lean proof in a year). *Evidence:* the product reduction is classical [external, recalled];
  its bite at the plane: none.
- *Search:* none in-ban; the SDP is post-ban and machine-long, so it waits on the derivation.

**P4 — from above: a measurable six- (or five-) colouring, MR-free.**
- *What it proves.* By (E), a measurable colouring proper at almost every unit pair gives `χ(ℝ²) ≤ 6` with no MR; with a six-lower-bound
  (P1/P2) that is the answer six; a five would be the answer five with the kernel's rung B.
- *What is known about its shape* (the no-go map): no polygonal colouring uses six (`[SokolovVoronov2025]`; G22); no map-type colouring
  (Townsend, Coulson — held or named, not read); **no slack colouring uses five** (`χ^{sl} ≥ 6`, `[CurrieEggleton2016]`, FS103-M D5), so a five
  would be *tight*; each class has density at most `m₁ ≤ 0.247`. So a six has non-polygonal, non-map classes finer than 1/2.
- *A new format-level question no stub names* [reading, prior]: **do a.e.-proper colourings with finite perimeter density need seven?** In
  geometric measure theory's words: a Caccioppoli partition of the plane with no monochromatic unit pair a.e. — is Townsend's map argument
  valid for it? If yes, `χ_m⁰ ≤ 6` needs **fractal (infinite-perimeter) classes**, and a perimeter-minimising selection (a minimiser exists:
  perimeter is lower semicontinuous and the constraint is closed in `L¹`) would turn any finite-perimeter six into a regular one — the
  variational door GMT supplies (Almgren–Taylor regularity of minimal partitions is its classical model). Two-sided: a yes is a no-go for
  every tame format; a no names the shape a six must have.
- *Lean cost:* **medium** for (E) and a concrete construction's properness; unknown for a fractal construction.
- *First milestone:* the no-go map at six in one table with every entry graded (read Townsend 2005 and Coulson 2004, held or on loan), then
  the finite-perimeter question as a derivation; kill (of the path, not of the question): a derivation that finite-perimeter a.e.-proper
  colourings need seven *and* a reason fractal ones cannot do better — then P4 is closed at six and the evidence for seven rises.
- *Probability:* **0.005** — needs HN ≤ 6 (my prior 0.45) and a construction no one has hinted at in seventy years.
- *Search:* none for the derivation; a constructive search (a CP/model-set colouring of `ℝ²`, FS-64's instrument aimed at the real place) is
  post-ban.

**P5 — the MR lane: formalize MR once, reuse it everywhere (enabling, not a route to a value).**
- *What it buys.* Rows 121, 123–130's lower halves in Lean; with (E), `χ(ℝ²) = χ_m⁰(ℝ²)` in Lean; every analytic lower bound (P0, P3)
  becomes a Lean lower bound on HN. It is the only path whose cost is paid once and reused by several others.
- *Lean cost:* **very high** if EL2021 Thm 1.3 is proved (KS entropy of `ℤ^d`-actions, leafwise measures, Einsiedler–Lindenstrauss's
  entropy symmetry: person-years; nothing in Mathlib); **high** if Thm 1.3 enters as a named hypothesis, as `BochnerHerglotz` and
  `InvariantMeasureOnClosed` already do in row 127 — then the in-house parts are EF's pigeonhole (elementary number theory + measure), the
  entropy splitting PE-2 (still needs KS entropy), the solenoid `R̂` and its dual, and the mixing selection.
- *First milestone:* **a ruling from Kooshi** (card C1 below) on whether a published theorem stated as a named hypothesis meets the bar;
  then the smallest self-contained piece — EF's zero-entropy pigeonhole at ℚ(√635087), which is where the project's own mathematics is.
- *Probability:* 0 on its own; it multiplies P0 and P3.
- *Search:* none.

### Would have searched here (stage 2)
- P1's calibration: I would have run the invariant LP on small configurations in `K(√5)` to see whether `χ_g` reaches 5 below 509 points;
  instead I derived its upper bound by the field wall (fact 3) and its sandwich `χ(H) ≤ χ_g ≤ χ(ΓH)` (fact 2), which say where and why it can
  help, and left the calibration post-ban.

*P3's exactness input is held and read here: `[DeCorteOliveiraVallentin2022]` Thm 5.1 (the completely-positive programme is exact for
`α` on a compact transitive group; `BIBLIOGRAPHY.md` line 296). The plane is not compact, so the transfer to `UD(ℝ²) □ K_t` is a derivation
owed, not a citation; `[GvozdenovicLaurent2008]` is in the bibliography as "listing only … not read".*

## Stage 3 — SAVED (frame items, the comparison table, the order, cards and ledger)

### 3.1 Frame items

**(a) What the ledger opens that no stub names.**
1. **The answer can be MR-free in every case; MR attaches to one path family.** By (E) every upper bound is a measurable colouring with no MR,
   and every lower bound that is a certificate (a graph, or P1's invariant certificate) needs none. MR is needed only to carry an *analytic*
   lower bound on `χ_m⁰` to `χ(ℝ²)`. Asymmetry by value: **seven** needs one lower bound (the hexagon is the upper, already in the kernel,
   row 33); **five** needs one construction (the lower is rung B, in the kernel); **six** needs both a lower bound and a construction — two
   open problems. No stub or plan I read states this planning fact. *Evidence:* derived (E, one mind); the rows' grades (read).
2. **(E) as a cheap Lean slot:** `χ(ℝ²) ≤ χ_m⁰(ℝ²)` by Fubini over rigid motions and the project's de Bruijn–Erdős — days, not months; it
   is half of the collapse's equality in the kernel, needs no MR, no CP colourings, no Tarski, and it is what any future measurable
   construction (P4) consumes. FS-101's lane could take it next to row 127.
3. **The invariant certificate's field wall** (P1 fact 3): a free theorem that says where route (d) can work before any LP runs.
4. **The finite-perimeter question** (P4): geometric measure theory — Caccioppoli partitions, minimal clusters — is a discipline the ladder in
   G30 has not entered; its standard handle on an arbitrary partition (perimeter, reduced boundary, a minimiser's regularity) is the
   example invariant (G79) a map-type argument would need.

**(b) Cheap on paper, ruinous to formalize** (each with the route that avoids it):

| step | on paper | in Lean at the pin | avoided by |
|---|---|---|---|
| MR (row 120) | "EL2021 Thm 1.2, by statement" | KS entropy, leafwise measures, EL's entropy symmetry: none present; person-years | P1, P2 (lower), P4 (upper) — every certificate route; paid once only if P3/P0 are chosen (P5) |
| `J₀`'s minimum `−0.40276` (rows 122, 129) and `m₁ < 1/4` (the only witness-free five) | one line; a published bound | no Bessel functions; certified interval bounds on an oscillatory integral | never needed by P1, P2, P4 |
| "extend to the adelic completion, select over all stable places at once" (row 128) | a paragraph | adeles present; the solenoid's dual as a theorem, Bochner, spectral measures absent | not needed by P1, P2, P4 (row 128 only says *where* to look) |
| amenability of the rigid motions | "solvable, hence amenable" | Følner sequences defined; no invariant means for solvable groups | P1's finite form: one Følner set of bounded boundary against a certificate's margin |
| the bridge (row 107, Tarski's fragment) | "`χ(ℝ²)` is a max over number fields" | no quantifier elimination | **needed by no path here**: lower bounds transfer upward by inclusion, and (E) bounds `ℝ²` directly |

**Is there a route that avoids MR, or pays for it once?** Both: P1/P2 + P4 avoid it outright; P5 pays it once for P0 and P3, and its price
halves (very high → high) if Kooshi rules that EL2021 Thm 1.3 may enter as a named hypothesis, as row 127 already does for Bochner–Herglotz.

**(c) Where the collapse makes a classical tool newly decisive — and where it only looks so.**
- **Operator SDP bounds become bounds on HN (given MR):** `χ_CP = χ(A_σ)`, BDOV's operator chromatic number (row 130), so the
  Bachoc–DeCorte–Oliveira–Vallentin family now bears on the plane's number itself. Decisive only at level ≥ 2 on the product graph
  `UD(ℝ²) □ K_t` (P3): level one is Hoffman/`ϑ`, which reads 3.48 and rounds to 4.
- **Falconer's boundary argument** becomes decisive only after the null-set step (P0): his Thm 2 uses properness on the null boundary, which
  `χ_m⁰` ignores (`BIBLIOGRAPHY.md` line 169).
- **Density LPs look newly decisive and are not**: row 129 proves them capped at 4.36 (one class at a time); the collapse makes the cap exact
  rather than lifting it. Spending on a better `m₁` bound moves nothing toward six.
- **Amenability** (Følner averaging) becomes decisive for *certificates* (P1), with no analysis and no MR — the cheapest classical tool the
  collapse's picture points at.

### 3.2 The comparison table

| path | direction | what it would prove | Lean cost | P(answer + Lean, 1 yr) | first milestone | kill | search? | evidence |
|---|---|---|---|---|---|---|---|---|
| **P0** FS-104 via Falconer's null set (baseline) | below, six | `χ = χ_m` given MR; then six needs `χ_m ≥ 6` (open 45 yr) | very high (MR + collapse) | 0.005 | D1–D5, the boundary list-colouring | a non-2-list-colourable configuration forced in `E` | no (derivation) | chain derived (≥ 2 minds), D1–D5 one mind; six: none |
| **P1** invariant certificate `χ_g(H; Φ)` | below, six or seven | `χ(ℝ²) ≥ 6` unconditionally | medium (low for crystallographic `Φ`) | 0.02 | second minds on (E) and facts 1–3; then (post-ban) calibration at five in `K(√5)` | no small `H` beats `χ(H)` at five, or a cap theorem | in-ban derivation; LP post-ban | facts derived (one mind); its bite: none; soft against (pure configurations never beat `m₁ < 1/4`) |
| **P2** finite witness in a collapse field | below, six or seven | `χ(ℝ²) ≥ 6` unconditionally | low–medium (size-set) | 0.015 | post-ban aimed search, degree law first | every refusal ball priced beyond the machine | yes, post-ban | existence iff HN ≥ 6 (derived); size: none |
| **P3** product-graph hierarchy + MR | below, six | `χ_m⁰ ≥ 6`, then HN via MR | very high (+ P5) | 0.005 | level-two shape at `k = 5`, can it pass 4.36 | every level equals a fractional bound | no; SDP post-ban | reduction classical (recalled); bite: none |
| **P4** measurable six/five colouring | above, six or five | `χ(ℝ²) ≤ 6` (or `= 5`) unconditionally | medium (construction-dependent) | 0.005 | the no-go map at six; the finite-perimeter question | finite-perimeter ⟹ seven, and no fractal escape | no; construction post-ban | no-gos in print (partly read); existence: none |
| **P5** MR lane (enabling) | — | MR in Lean, reused by P0, P3 | very high / high with named hypotheses | 0 alone | Kooshi's ruling (C1), then EF's pigeonhole at ℚ(√635087) | — | no | MR [hand, ≥ 2 minds, one external theorem by statement] |

All paths together: about **0.05**, the top of my stage-1 expectation. The likeliest product of the next month on any path is not the answer but
a no-go of a named format or the collapse's write-up — the advisor's FS-104 prior (≈ 0.03 for six) and mine agree.

### 3.3 The recommended order (a decision in four parts)

- **The choice.** (1) In-ban, now: a derivation job with a blind verifier on (E) and P1's facts 1–3, and the Lean slot for (E); P0's D1–D5
  alongside only as the write-up's naming step. (2) Kooshi's ruling on named hypotheses (C1) before any spending on P5. (3) From 2026-10-01:
  P1's calibration at five, then six in ℚ(√635087), `K(√7)` and de Grey's field, with P2 run from the same configurations. (4) P3's level-two
  derivation only if P1's calibration shows invariance helps. (5) P4's no-go map as reading, whenever a slot is free.
- **The alternative weighed.** The owner's order: FS-104 led by the null-set step (P0), its route (d) last.
- **Why this one won.** Kooshi's bar makes Lean cost first-class; P0's path carries MR's very high cost and its first milestone names the value
  without moving it, while P1 attacks the value directly with a certificate a stranger checks without MR, at medium Lean cost, and its first
  milestone is a two-sided calibration against a certified positive (five). P0's first step stays in the plan, as a cheap write-up item.
- **Confidence: medium.** The one fact that would change it: P1's calibration at five failing — no configuration where invariance beats the
  plain chromatic number below a few hundred points. Then the certificate route is only a finite witness in costume, and the order falls back
  to P2 (search) plus P5 (MR once) for an analytic attempt.
- **Default if Kooshi says nothing:** the owner's FS-104 proceeds as planned; this record stands as the alternative, and (E) waits.

**Where I differ from the owner:** I would move FS-104's route (d) from last to first, and move the null-set step from "the aim" to "the
write-up's naming step". We agree on the picture (the collapse; six is `χ_m⁰`'s question given MR) and that success in a year is unlikely.

### 3.4 Cards

question: may-a-published-theorem-enter-lean-as-a-named-hypothesis
  evidence: row 127 already states `BochnerHerglotz` and `InvariantMeasureOnClosed` as named hypotheses; row 120's external input is EL2021 Thm 1.3, used by statement; Mathlib at the pin has no KS entropy or leafwise measures (grep, stage 2.0)
  expected: Kooshi's bar ("formalized in Lean before publishing") was stated without deciding this
  ask: does a result count as formalized if a refereed published theorem (EL2021 Thm 1.3) appears in Lean as a named hypothesis, the rest kernel-checked?
  if yes: MR's lane costs high, not very high; P0 and P3 stay live; the collapse write-up (FS-102) can be formalized conditionally now
  if no: every MR-dependent headline is unpublishable for years; lead with P1, P2, P4 and formalize (E) first
  answered by: Kooshi
  cost: one ruling
  rank: 1

question: do-the-mr-free-facts-hold
  evidence: this record §2.1 (E) and §2.2 P1 facts 1–3, each [hand, one mind]; fact 3's reflections and dyadic cases passed over (stage 2b note)
  expected: all four hold; fact 3 needs the conjugation randomised
  ask: are (E), `χ(ℝ²) ≥ χ_g(H; Φ)`, `χ(H) ≤ χ_g ≤ χ(ΓH)` and `χ_g(H; Φ) ≤ L(F)` correct as stated, with proofs a stranger accepts?
  if they hold: P1 is a live MR-free route and (E) is a Lean slot; brief the calibration for 2026-10-01
  if one fails: P1 or the MR-free planning fact falls; the owner's order stands unchanged
  answered by: a fresh mind
  cost: one derivation job and one blind verifier, in-ban, a few hours each
  hunch: all hold; fact 3 is the one most likely to need a repair
  falsifier: an `F`-isometry under which the random affine-frame colouring's law is not invariant
  rank: 2

### 3.5 Hunch ledger (scored at this stage)

hunch: mr-is-the-formalization-bottleneck
  claim: every route above five without a certificate passes through MR, and MR's Lean cost is very high
  basis: prior
  falsifier: a row among 128–130 whose conclusion needs no MR, or MR's needed form provable from Mathlib plus weeks
  registered: 2026-09-26
  status: confirmed in part (by: rows 128–130 carry "given MR" on every lower-bound headline; Mathlib grep finds no KS entropy or leafwise measures) — refined: MR is needed for one arrow only, `χ(ℝ²) ≥ χ_m⁰`, and (E) plus certificates avoid it (derived, one mind)

hunch: six-needs-a-joint-constraint
  claim: no one-class argument gives six; a proof of six must constrain several classes jointly
  basis: prior
  falsifier: row 129 or a paper giving six from one-class information
  registered: 2026-09-26
  status: confirmed (by: derivation — row 129, "that route never gives six", two minds)

hunch: the-finite-witness-route-is-cheapest-in-lean
  claim: a finite certificate is the cheapest route to a Lean-verified headline by an order of magnitude
  basis: prior
  falsifier: a witness priced beyond the kernel, or an analytic route priced below it
  registered: 2026-09-26
  status: open (refined: P1's invariant certificate is the same kind at a smaller size)

hunch: invariance-helps-at-five
  claim: some `H ⊂ K(√5)²` with `χ(H) = 4` has `χ_g(H; Φ) ≥ 5` at no more than 200 points
  basis: analogy
  falsifier: the post-ban LP finds none up to 200 points with `Φ` a crystallographic group plus the Heule rotation
  registered: 2026-09-26
  status: open (prior 0.25)

hunch: finite-perimeter-colourings-need-seven
  claim: an a.e.-proper measurable colouring of the plane whose classes have locally finite perimeter uses at least seven colours
  basis: prior
  falsifier: an a.e.-proper six-colouring with finite-perimeter classes, or a step of Townsend's map argument that needs more than finite perimeter
  registered: 2026-09-26
  status: open

### 3.6 Theorems this phase proved

- (E) `χ(ℝ²) ≤ χ_m⁰(ℝ²)`, by random rigid motions and de Bruijn–Erdős — [hand, one mind] — §2.1.
- P1 fact 1, `χ(ℝ²) ≥ χ_g(H; Φ)` (finite Følner form) — [hand, one mind] — §2.2.
- P1 fact 2, `χ(H) ≤ χ_g(H; Φ) ≤ χ(ΓH)` and `sup_H χ_g = χ(ℝ²)` — [hand, one mind] — §2.2.
- P1 fact 3, `χ_g(H; Φ) ≤ L(F)` over `F` — [hand, one mind; reflections and the dyadic case to check] — §2.2, stage 2b note.

None is claimed new: (E) and fact 1 are likely folklore (Tao's Polymath16 remark is fact 1's ancestor); no gate was run on them.

### 3.7 Proposed `BIBLIOGRAPHY.md` edits (the close writes them)
- `[GvozdenovicLaurent2008]`: add "PA1 P3 uses its `χ` ↔ `α(G □ K_t)` reduction (recalled); read §§1–3 before citing".
- A row for de Laat–Vallentin's `k`-point hierarchy (Math. Program., 2015; recalled, not fetched) — P3.
- `[Townsend2005]`, `[Coulson2004]`: P4's no-go map needs them read (Coulson held; Townsend on loan request).

### Would have searched here (stage 3)
- None. The comparison needed no computation beyond the Mathlib grep (a reading, not a search).
