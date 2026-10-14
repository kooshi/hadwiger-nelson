# STUB — FS-133: the one-class transfer — the finitary and the measurable densities of unit-avoiding sets are equal, with no hypothesis

> **Closed 2026-10-14 (FS133-LD1): its Lean module passed the gate.** `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` and the labelling claim both ways are kernel theorems on the standard three axioms (`Plane/OneClass`; `plans/FS133-LD1-landing.md` stage 4 reads each aloud against the claim list), through `[OAIMath2026]` family 158's rigidity step, ported (`Outside.OAI158.Spectral.residual_fourier`). Derived 2026-10-07 (FS133-E1; FS-133 inventory item 3): `plans/FS133-E1-derivation.md`; row 129 carries it. Prior art: the statement is not new — `[Davies2026]` (8 October 2026) proves it in dimension four and up and names the plane as its aim (`plans/FS131-ER1-davies-reading.md`).

*Minted 2026-10-07 by Poros (FS132-P1, `plans/POROS-2026-10-07-after-release.md` stage 3) at Kooshi's word of the same day:
"definitely build on it... write the stub" (`data/external/EXT-OAI1-request.md`, third word, item 3). The number was fixed by Keryx
(`plans/FS131-close-inventory.md` item 617). State: Not started. **It takes the deriver's first slot, ahead of FS-132** (the
record's § 3.1 says why).*

**Bearings (Ephodos, FS133-E1 §G, 2026-10-06):** G60, G80, G81, G82, G92, G21, G24, G63, G66, G76, G79, G87; rows 129, 130, 131 (attainment), 120, 128, 107 — `plans/FS133-one-class-transfer.md` § G.

## The mission, in plain language

Two numbers measure how large a set in the plane can be if no two of its points are at distance exactly 1.
- **`m₁(ℝ²)`**, the *measurable* one: the largest upper density of a Lebesgue-measurable such set. Known: between `0.2293` (Croft's
  tortoises) and `0.247` (`[AmbrusEtAl2023]`).
- **`α₁(ℝ²)`**, the *finitary* one: the smallest fraction `α(G)/|G|` of vertices an independent set must take, over all finite
  unit-distance graphs `G`. It is what finite graphs can see. Its reciprocal is the finitary fractional chromatic number
  `χ_f,0(ℝ²)`; `[DuczVarga2026]` showed it is above 4.

`α₁ ≥ m₁` is easy (drop a finite graph at random onto a measurable set). Whether they are equal has been asked in print three
times: `[Johnson1996fcn]` p. 103, Question 1 ("If the answer is "no", then what about the case G = ℝ²?"), `[MatolcsiEtAl2025]` § 2
("It is clear that χf,0 (R2 ) ≤ χf (R2 ), but it is not known whether equality holds."), and the first clause of `[DuczVarga2026]`
Conjecture 1 ("f (n)/n = m1 (R2 ) + o(1)") — all quoted at `CLOSED-QUESTIONS.md` ll. 655–668. Published opinion leaned toward *not
equal* (`[AmbrusEtAl2023]` § 4, per row 129's mechanism line).

**Where this project stood** (`LEDGER.md` row 129, [hand], two minds on the chain): equal, *given measure rigidity at the number
field ℚ(√635087)* — an outside theorem this project uses by statement (row 120).

**What changed on 2026-10-06.** The release (`[OAIMath2026]` family 158) proves a rigidity theorem of its own, at the field of all
real algebraic numbers, kernel-checked in its library and audited here (`wild_fourier`; `plans/EXT-OAI1-audit.md` stage 4), and
uses it to turn any proper `k`-colouring of the plane into a measurable one. The manuscript's reader noticed that the same nine
steps, run for *one colour class* instead of `k`, would give the density equality with no hypothesis — and that the manuscript does
not say so (`plans/EXT-OAI2-reading.md` § 2.6, "one mind; a candidate, not a result of this job"; one step unchecked).

**The sketch, as the reading gives it** (its ll. 354–363, paraphrased here only to orient — the deriver reads the lines): average
over the rigid motions of the algebraic plane to get an invariant random independent set of density `α₁`; split the indicator of
"the origin is in the set" into its part continuous in the plane's topology and a remainder; the rigidity theorem makes the
remainder uncorrelated at every algebraic translation, so the continuous part `p` has `∫ p · T_u p = 0` at every unit vector `u`;
a sample of `p` as a field on the plane is supported on a measurable set that avoids distance 1 almost everywhere and has mean
`α₁`; its density points avoid distance 1 everywhere (the manuscript's Lemma 4.3).

## The question (Poros, 2026-10-07)

### The card

question: does-the-rigidity-run-for-one-class
  evidence: `plans/EXT-OAI2-reading.md` ll. 352–364 (§ 2.6: "The step to check before it is claimed: the passage from a stationary field of mean `α₁` to a set of *upper density* `α₁`"); `LEDGER.md` row 129 ("At ℚ(√635087), given MR there: `α₁(ℝ²) = m₁(ℝ²)`"); `CLOSED-QUESTIONS.md` l. 655 ("answered at [hand], given MR")
  expected: the equality of the finitary and the measurable densities needs measure rigidity at a number field (row 120's outside input), so it stays conditional
  ask: does the release's rigidity theorem, run on an invariant random independent set of the algebraic plane in place of a colouring, give a measurable set avoiding distance 1 whose upper density is at least the finitary independence ratio?
  if it does: `α₁(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²)` hold with no hypothesis; row 129's plane clause loses "given MR"; three questions posed in print are answered at [hand] over an outside theorem; a short note is owed its Lean form and then a write-up
  if a step fails: the named step is where one class differs from a partition, row 129 keeps "given MR", and the finding is a limit of the release's transfer that its manuscript does not state
  answered by: derivation — Ephodos
  cost: one short derivation job, no search: the manuscript's § 4 (316 lines) re-read with one class, FS103-B-AMEN's Følner half restated at the algebraic plane, the density step, and the literature's definitions of `f(n)` and `m₁` read at their pages
  hunch: it runs; the density step closes by reverse Fatou on disc averages; the care is in which infimum the literature's `f(n)/n` names (0.85)
  falsifier: a step among the transfer's F3–F9 that uses the sum of the classes' fields being 1, or more than one class; or `[DuczVarga2026]`'s `f(n)` defined over graphs the argument's infimum does not cover
  rank: 1

### Existence form

*Is there an object?* **Is there a Lebesgue-measurable set in the plane, with no two points at distance exactly 1, whose upper
density is at least `α(G)/|G|` for every finite unit-distance graph `G`?** A YES is the equality, and more: it says the supremum
defining `m₁(ℝ²)` is attained. A NO would need a finite graph family beating every measurable set — the published expectation
before row 129 — and would contradict the release's theorem or locate the step where one class is not a colouring.

### Structural form

*About every solution, in the widest class where it makes sense.* **For which constraints on labelings of the algebraic plane,
invariant under its rigid motions, does a solution exist if and only if a measurable solution exists almost everywhere?** The
release proves it for "no two points at distance 1 share a label" with `k` labels. One class is "label 1 never at distance 1 from
label 1". Between and beyond: homomorphisms of the unit-distance graph into any finite graph `H` (circular and `b`-fold chromatic
numbers), several forbidden algebraic distances at once (the reading § 2.4: the argument "transfers any colouring avoiding a set of
algebraic distances"), and constraints on three or more points (no monochromatic unit triangle). The invariant every solution
carries is the part of its indicator fields that is continuous in the plane's topology — the conditional expectation onto the
manuscript's factor `𝓕_c`. The question cannot be answered without saying which constraints that projection preserves: a
constraint that is the vanishing of a correlation of two fields at one displacement survives if the remainders' *cross* spectral
measures are killed too (for one class and for colourings only the diagonal ones are needed); a constraint on three points asks
for a triple correlation, which the rigidity theorem as stated does not reach. A structural form that returns "pair constraints,
and exactly those" is a theorem about the transfer itself.

## The first claim a deriver takes

**C133-DENS (posed) — the unchecked step.** Let `H : ℝ² × Ω → [0, 1]` be jointly measurable with `∫ H(x, ω) dμ(ω) = α` for every
`x` and, for `μ`-almost every `ω`, `H(x, ω) H(x + u, ω) = 0` for almost every `(x, u) ∈ ℝ² × S¹`. Then for some `ω` the set
`{x : H(x, ω) > 0}` has upper density at least `α` and is unit-avoiding almost everywhere. (My route, a hunch: the disc averages
`A_R(ω)` have mean `α` and are bounded by 1, so the mean of `limsup_R A_R` is at least `α`.) Take it first because it is the one
step the reading left open and it is an afternoon.

**Then, in order.**
- **C133-INV (posed).** At the algebraic plane `E = ℚ̄`: there is an `E ⋊ K`-invariant probability on the independent subsets of
  the unit-distance graph of `E` with `P(0 ∈ I) ≥ inf α(G)/|G|` over finite `G ⊂ E` — FS103-B-AMEN's Følner half (for number fields; two blind per row 129; graded one mind at `plans/FS103-derivation.md` l. 86) restated where the group is `E ⋊ K`. Note the infimum over graphs in the
  *algebraic* plane is at least the infimum over all finite unit-distance graphs, which is the direction needed: **no redrawing
  lemma, so no Tarski.**
- **C133-ONE (posed).** `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`: steps F3–F9 of the transfer
  (`plans/EXT-OAI2-reading.md` § 2.1) with one field `p` in place of `k`, each step checked for a use of `Σ p_i = 1`.
- **C133-HOM (posed, the structural form's first rung).** For a finite graph `H`: a homomorphism of the plane's unit-distance graph
  to `H` exists iff a measurable one exists almost everywhere. The new step is the cross terms `⟨b_i, T_z b_j⟩`, `i ≠ j`.
- **Read at their pages before any sentence says "answers"**: `[DuczVarga2026]`'s definition of `f(n)`; `[MatolcsiEtAl2025]` § 2's
  `χ_f,0`; `[Johnson1996fcn]` pp. 103–104 (Questions 1 and 3) and `[Johnson2000surprises]` p. 143 (Problems 3 and 4). All four are
  held and were read on 2026-09-27 (`CLOSED-QUESTIONS.md` l. 655).

## What each answer gives

- **It runs.** Row 129's sentence "At ℚ(√635087), given MR there: `α₁(ℝ²) = m₁(ℝ²)` …" becomes unconditional, over one outside
  theorem that is kernel-checked in its own library. Answered in print's words: `[DuczVarga2026]` Conjecture 1's first clause;
  `[MatolcsiEtAl2025]` § 2's equality; `[Johnson1996fcn]` Question 1 for the plane and his Question 3 (the "Benda–Perles–Tarski
  property" for `χ_f`, row 129 having held it given MR). Every upper bound on `m₁` becomes the existence of finite unit-distance
  graphs: with `[AmbrusEtAl2023]`'s bound, finite graphs of fractional chromatic number above `4.0487` exist, where the best
  explicit one has `4.0007`. `CLAUDE.md` § The aim link 3 ("Density cannot give six") holds for the plane with no hypothesis.
  **A correction owed:** G80's and row 129's "finite-graph killing test for MR" (a proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at
  ℚ(√635087)) can then never fire, and must be withdrawn as a test.
- **A step fails.** The step names what a colouring has that one class lacks. Row 129 stays as it is, its killing test stays live,
  and the finding goes to the reading's § 2.6 as a correction.
- **Not claimed either way:** `m₁ = δ_Croft` (the conjecture's second clause); any value; anything at a number field (row 129's
  field form keeps "given MR": the release's rigidity "does not give MR(F) for any number field", the reading § 2.2).

## Registered expectations (Poros, before any derivation)

C133-DENS 0.95; C133-INV 0.90; C133-ONE 0.85; C133-HOM 0.60. That another group posts C133-ONE within thirty days of the release:
0.5 — an instrument, to be scored.

## Prior art, and the risk of being second

- **Not in the release**: the manuscript does not state it (the reading § 2.6), and the catalogue of 372 families has no entry on
  the fractional chromatic number of the plane or on the density of unit-avoiding sets (`rg` over `CONTENTS.md` for "fractional
  chromatic", "independence ratio", "avoiding distance", "density of sets": the only hit is family 157, on graph minors) — a search
  of headlines, not a reading.
- **The risk is high and it is specific.** The release is public; the people who posed the question (`[MatolcsiEtAl2025]`,
  `[DuczVarga2026]`) work on exactly this; and the step from `k` classes to one is the first thing a reader of the transfer who
  knows the fractional problem will try. This project's advantage is days, not months: it already holds the chain (row 129, two
  minds) with only the rigidity input to swap.
- **The gate before any claim** (§PA of the deriving lane): search the two disciplines' words — "fractional chromatic number of the
  plane", "measurable independence ratio / density of 1-avoiding sets" — on arXiv from 2026-10-06 on, at the opening and again at
  the record job.
- Whatever is written says: the rigidity theorem is `[OAIMath2026]`'s; the chain is row 129's; the observation that one class runs
  is the reading's (EXT-OAI2, 2026-10-07).

## Failure clauses

- If C133-ONE lands and C133-HOM does not, the milestone closes on C133-ONE; C133-HOM becomes a stub of its own.
- If the literature's `f(n)` is not the infimum the argument bounds, state the equality for the quantity it does bound and say
  which printed clause is and is not answered. "Answers" is used only after the page is read.

## Named deliverables

`plans/FS133-derivation.md` (the four claims with `uses only:` lines); the replacement sentences for row 129, `CLOSED-QUESTIONS.md`
ll. 655–668, G60 and G80 (drafts, Keryx files); for de Bruijn, the statement over the release's `wild_fourier` as a declared
outside theorem — the import skeleton (`data/external/oai1/audit/ImportSkeleton.lean`) does not yet propose it as an axiom ("no
consumer here"): this milestone is its first consumer.

## Siblings — other consequences a short job could close this week (listed, not minted; Poros's order)

1. **The bridge without Tarski** (the reading § 5.3; inventory item 618 (i)): the transfer reads the colouring only on the algebraic
   plane, so `χ(ℝ²) = χ(ℚ̄²) = sup_F χ(F²)` with no `RealAlgebraicDescent`, and some real number field's plane needs six. Answers:
   the hypothesis FS-39 priced at "months". First claim: the converse leg (their Lemma 4.3 and de Bruijn–Erdős) is not in their
   Lean — state exactly which of the six kernel consumers the import discharges. Risk of being second: low (it is about this
   project's own named hypothesis). Order: with the import job, de Bruijn's lane; not a deriver's slot.
2. **The axiom question** (the reading § 2.3): in ZFC the plane's number is `χ_m⁰(ℝ²)` (the transfer); where every set of reals is
   measurable it is `χ_m(ℝ²)` by definition; so the Shelah–Soifer question for the plane is this project's null-set step
   `χ_m⁰ = χ_m` (FS103-M-D, a GAP). First claim: that the two measurable numbers are absolute between the models compared — a
   descriptive-set-theory statement to be checked, not assumed. Answers: Soifer's Open AC Problem 62.14 in the form "equivalent
   to". Risk: medium. Order: third; it is the surviving half of FS-104 (the record's § 4).
3. **Falconer's number**: `χ_m(ℝ²) ≥ 6` and `χ_B(ℝ²) ≥ 6`, open since 1981 at five, follow from the release's Theorem 1.4 in one
   line (`χ_m⁰ ≤ χ_m ≤ χ_B`, FS103-M1c), and the manuscript's introduction does not say so. A filing line, not a job. Risk: certain
   to be noticed by everyone.
4. **Stability at five**: `lim µ₅(ε) < 1` (row 131 with Theorem 1.4). A filing line.
5. **The obstruction on a disc** (FS-132's C132-RADIUS): no measurable five-colouring of a disc of an explicit radius, proper at
   almost every unit pair inside it — the release's proof reads a bounded region (`plans/EXT-OAI1-audit.md` l. 404). In FS-132.

## Bearing on the answer

None on six against seven, and it should be ranked knowing that: one class at a time is capped below 4.37 (row 129, G60). It is
here because it is a result, it is short, three printed questions wait on it, and its window is closing. Why each bearing:
**G60, row 129** — the chain and the cap; **G80, row 120** — the rigidity it no longer needs for the plane, and the killing test
to withdraw; **G81, row 128** — the limit case where no place is stable; **G92** — the method: the release's transfer read at the
class its argument carries; **G24** — the fractional relaxation against integrality, the same theme one level down; **row 130** —
the colouring form this is the one-class shadow of; **row 107** — the redrawing lemma this route does not need.
