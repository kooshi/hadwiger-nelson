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

```markdown
hunch: mr-is-the-formalization-bottleneck
  claim: every route in the ledger that goes above five without a finite witness passes through MR (row 120), and MR's Lean cost is very high (years), so the cheapest formalizable path to any new headline avoids MR or reduces it to a statement provable from ergodic theory Mathlib already has
  basis: prior
  falsifier: a row among 128–130 whose conclusion does not use MR, or a form of MR the project needs that follows from Mathlib's existing ergodic theorems plus weeks of work
  registered: 2026-09-26
  status: open

hunch: six-needs-a-joint-constraint
  claim: no argument that bounds one colour class at a time (density, fractional, Hoffman-type) can give six; a proof of six on the collapsed problem must constrain several classes jointly (pair or triple correlations, a flag-algebra or SDP hierarchy, a Falconer-type density-point argument on a configuration)
  basis: prior
  falsifier: row 129 or a paper giving six (or a bound above 5 for the measurable chromatic number) from one-class information
  registered: 2026-09-26
  status: open

hunch: the-finite-witness-route-is-cheapest-in-lean
  claim: whatever the value, a finite six-chromatic unit-distance graph with an LRAT refutation is the cheapest route to a Lean-verified headline by an order of magnitude, if one exists at a size a solver can refute
  basis: prior
  falsifier: a finite witness priced (after the ban) at a size the kernel checker cannot absorb, or an analytic route whose Lean cost is priced below it
  registered: 2026-09-26
  status: open
```

### 1.4 "Would have searched here" log

- (none yet)

## Stage 2a — SAVED (the survey, and paths P0–P2)

### 2.0 What I read, against what I expected (evidence inventory)

- `LEDGER.md` rows 120–130, read in full; rows 100–119 by headline only (sampled, not read whole) — read against: "every headline above five
  rests on MR" — surprised: **yes, in one place**: row 128's *load-bearing step* and row 130 (`χ_CP = χ_m⁰ = χ(A_σ)`) are stated **with no
  MR**; MR enters only to remove the SP witness. So MR is needed for exactly one arrow, `χ(ℝ²) ≥ χ_m⁰(ℝ²)`.
- The brief's three "where things stand" bullets, against rows 128–130 — read against: "the owner paraphrased" — surprised: no; each matches
  its row (row 129 says `1/α_loc ≤ 4.36`; the brief's "below 4.37" is the same bound).
- `plans/FRONTIER-STUBS.md` rows 1–10, first 1,800 characters each (sampled) — read against: "the table is about six and about fields" —
  surprised: no; rows 2–4, 7–9 are the product-locality cluster (six at a field *below* the plane's number), not the plane's value.
- `plans/STUB-cp-plane-six.md` (FS-104), whole — read against: "route (d), an MR-free invariant LP, is named" — surprised: **yes**: it is
  named (`χ(ℝ²) ≥ χ_g(H)` "by amenability alone, no MR") and ranked **last**, behind three routes that each need MR.
- FS-103 §R-close stage 3 (whole) and FS-105 §R-close 3.6 (the verdict) — read against: "MR's residual risk is one external theorem" —
  surprised: no (EL2021 Thm 1.3 by statement, its `[11]` Prop. 6.4 unread).
- `BIBLIOGRAPHY.md` rows for Falconer, Woodall, Townsend, Coulson, Pritikin — read against: "Falconer bounds `χ_m⁰`" — surprised: **yes**:
  `[Falconer1981]` Thm 2 "bounds `χ_m`, not `χ_m⁰` (its Lemma 1 meets the null boundary in one point)". So Falconer's "+1" mechanism lives on
  the null set that `χ_m⁰` ignores — the real reason the owner's null-set step matters (P0 below).
- Mathlib at the project's pin (`.lake/packages/mathlib`, grepped by statement shape) — read against: "none of the analytic inputs exist" —
  surprised: partly. **Present:** Prokhorov (`MeasureTheory/Measure/Prokhorov.lean`), Riesz–Markov–Kakutani, Følner sequences
  (`MeasureTheory/Group/FoelnerFilter.lean`, definitions and means), the Lebesgue density theorem
  (`ae_tendsto_measure_inter_div_of_measurableSet`), the mean ergodic theorem, Birkhoff sums, topological entropy, adele rings,
  `PontryaginDual` (the definition). **Absent:** measure-theoretic (Kolmogorov–Sinai) entropy, leafwise/conditional measures along foliations,
  Einsiedler–Lindenstrauss anything, Bochner's theorem, Bessel functions (the three "Bessel" hits are Bessel's inequality), invariant means /
  amenability of solvable groups, Markov–Kakutani, Pontryagin duality as a theorem, Tarski's quantifier elimination. The project itself holds
  de Bruijn–Erdős (`Proofs/HadwigerNelson/Bridge.lean`) and the LRAT checker (rung B).

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
