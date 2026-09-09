# P6 — Generalize the kernel: the palette helpers (G7c) and the 2-adic law (G2)

*Subplan, 2026-09-09. Package P6 of the six-way consolidation. Owner: de Bruijn (this session).
Branch `consolidate/p6`, worktree `/home/kooshi/source/lean-wt-p6`.*

---

## §0 What this is, for a reader with no memory of the project

This repository asks how many colours the plane needs so that no two points exactly one unit apart
share a colour, and it works over **number fields** rather than over all of `ℝ`. Over the field
`K = ℚ(√3, √11)` the answer is exactly four, and the four-colouring that proves it is a **residue
colouring**: pick a prime `𝔭` above `2` in `K(i)` that complex conjugation fixes, and colour a point
by the residue of its coordinates modulo that prime. There are four residues, so four colours.

Because that is *one* proper four-colouring, every claim of the form *"in every proper four-colouring
of this `K`-object, these two points get the same colour"* has to be true of it in particular — and
which pairs it identifies is pure arithmetic. `Proofs/HadwigerNelson/ValuationLaw.lean` is that
observation turned into a theorem, and it explains a table of computer-found results in a published
paper that the paper does not explain.

**The debt this milestone pays.** That file is written at one field, one prime, one residue ring
(the four-element field), and the literal number `4`. Its proof needs none of those: it needs a ring
closed under conjugation, a residue map into a ring with no zero divisors, and a prime the
conjugation fixes. The evidence is unusually direct — the proof already calls the general theorem by
name (`ValuationLaw.lean:126` invokes `ResidueColouring.map_ne_zero_of_mem_normOne`).

Generalized, the law becomes the compulsion statement **at every prime of every field this
project's own sieve names**, which is the vocabulary two earlier milestones already speak and which
the current statement cannot be spoken in.

A second, smaller debt comes first because the first consumes it: the notions `Forces` (a pair no
proper colouring separates) and `Separated` (a pair no proper colouring identifies) are defined over
the palette `Fin k`, which is the right choice, but two files each pay the cost of translating a
colouring by some *other* four- or `k`-element set into that palette by hand.

## §PA Prior-art gate (WORKFLOW step 3a) — run before any derivation

**The object, in the discipline's words.** *Colourings of a Cayley graph on a number field by
residues modulo a prime; which differences the residue map annihilates; the norm map on the residue
field of a prime fixed by an involution.* Two disciplines: **graph colouring / additive
combinatorics** and **algebraic number theory (splitting and inertia of primes, norm-one elements)**.

**Searched 2026-09-09**, none in this project's coined vocabulary:

* *"monochromatic distances every proper coloring plane over number field prime residue unit
  distance graph"* — returns the odd-distance and prime-distance literature
  (`[Davies2024]` = arXiv:2209.15598, already held and read; arXiv:2308.02483 *Prime and polynomial
  distances in colourings of the plane*, **not in our bibliography** — flagged in the handoff as a
  §C candidate, bears on `[Davies2024]`'s line and not on this package).
* *"Cayley graph coloring residue field prime norm one elements unit vectors chromatic number
  quadratic field which distances monochromatic valuation"* — Paley graphs, unitary Cayley graphs,
  structured Cayley graphs over finite fields. Nothing on point. One title worth a §C row:
  arXiv:2511.10813 *Four plane unit vectors generate a 3-colorable graph*, **not in our
  bibliography** — flagged in the handoff; it bears on M24–M26's countable-lattice closures, not on
  this package.
* *"chromatic number plane over field residue colouring forced/monochromatic pair distance criterion
  valuation general theorem Fischer additive colouring which pairs identified"* — nothing algebraic
  at all; the search engine's own summary says so.

**The question, not only the method.** *Has anyone stated, at the level of an arbitrary field and an
arbitrary conjugation-fixed prime, which distances a residue colouring identifies?* The negative is
the finding, and it is a **weak** negative because this project's own bibliography already holds the
answer for the specific case and it is thorough: `[Ducz2026]` (10 June 2026) has the identification
half **in coordinates** for the rank-4 Moser ring (`N + M ≡ 0 mod 4`), `[Parts2020a]`'s Table 1 and
`[Heule2019]` §5/§7 have the observations, `[Heule2021]` asks in print for a proof, and
`[Polymath16wiki]` (4 June 2018) has one instance. All of that is recorded in ledger row 59 and in
`BIBLIOGRAPHY.md`, and **nothing found today changes any of it.**

**What is genuinely new in this package is not a mathematical statement about `K`** — it is the
observation that the argument never mentions `K`, and specifically:

> the specialization used *"conjugation induces Frobenius on the residue field"*, which is a fact
> peculiar to the four-element field. The law only needs *"the kernel of the residue map is stable
> under conjugation"* — which is precisely the write-up's own hypothesis that the prime is fixed by
> conjugation.

That is a scope finding about our own proof, not a claim against the literature, and §3's P4
registers it as the thing most likely to break.

**Outside arXiv:** the relevant non-arXiv sources for this line (`[Heule2021]` in *Geombinatorics*,
`[Moorhouse2010]`'s unpublished draft, `[Madore2015]`) are already in `BIBLIOGRAPHY.md` with their
read status. No new non-arXiv search target was identified.

**Bibliography additions owed** (to package P1, via the handoff, since `BIBLIOGRAPHY.md` is theirs
this round): the two §C candidates above.

---

## §1 The shape

### A new leaf module — `Proofs/HadwigerNelson/Palette.lean`

**Why a new module and not `Forcer.lean`.** `Forcer.lean` has **67 transitive dependents**; a
*declaration* added there rebuilds all of them, forever after. `Palette.lean` imports `Fan` (which
imports `Forcer`) and is imported only by `ResidueColouring.lean` — which has **two** dependents,
both in this package. One rebuild, nothing thereafter. This is `CLAUDE.md`'s build rule and the
reason fourteen files in this repository each mint a private copy of `√3·√3 = 3`.

**What it says.** `Forces G k p q` and `Separated G k p q` quantify over `G.Coloring (Fin k)`. They
are nonetheless statements about *every* palette of `k` colours, because a bijection of palettes is
a bijection of colourings (`SimpleGraph.recolorOfEquiv`). Six declarations, three each side:

| name | reading |
|---|---|
| `Forces.eq_of_equiv` | a forced pair agrees under a colouring by any palette in bijection with `Fin k` |
| `Forces.of_equiv` | the converse — agreement in one such palette *is* forcing |
| `Forces.eq_of_card` | the `Fintype.card α = k` form, which is what callers hold |
| `Separated.ne_of_equiv`, `Separated.of_equiv`, `Separated.ne_of_card` | the duals |

plus the two refutation forms callers actually walk to,
`not_forces_of_coloring_ne` and `not_separated_of_coloring_eq`.

**Consumers.** `Additive.lean:56` and `:66` (each builds `Fintype.equivFinOfCardEq` inline);
`ValuationLaw.lean:200` (mints `F4.equivFin` with a comment explaining why); and the new general
compulsion consumers below.

### `ResidueColouring.lean` — a new §7, *"which pairs a residue colouring identifies"*

Five pieces of algebra and two consumers, all at the level `colorable_of_normOne` already occupies
(a commutative ring `L`, a subring `A` stable under a ring endomorphism `σ`, a residue map
`ψ : A →+* R` into a finite nontrivial ring):

1. **`normOneColoring`** — the residue colouring as a `Coloring`, not merely a `Colorable`. This is
   `colorable_of_normOne`'s own construction, named; `colorable_of_normOne` becomes its corollary
   with its statement untouched. Consumers that need to *evaluate* the colouring (every compulsion
   consumer does) cannot use a `Colorable`.
2. **`cosetResidue_eq_iff_map`** — two points of one coset share a colour iff the difference's
   residue vanishes. Generalizes `FieldWall4.residueColouring_eq_iff_sub`.
3. **`cosetResidue_ne_of_mem_normOne`** — a norm-one difference is never identified. Generalizes
   `FieldWall4.residueColouring_ne_of_dist_one`.
4. **`map_mul_normOne_eq_zero_iff`** — *a norm-one cofactor cannot move a residue off zero.* Needs
   `NoZeroDivisors R`. This is the scalar half of the law.
5. **`map_mul_conj_eq_zero_iff`** — *if the kernel of `ψ` is `σ`-stable, the norm's residue vanishes
   exactly with the element's.* This is the squared-distance half, and **the hypothesis is the
   finding**: the specialization used `ψ ∘ σ = Frobenius ∘ ψ`, true in the four-element field and
   false in general; what the argument needs is only `ψ (σ z) = 0 → ψ z = 0`, i.e. *the prime is
   fixed by conjugation*, which is the write-up's own hypothesis.
6. **`div_mem_normOne`** (over a field) — a difference whose norm is a nonzero scalar's norm is that
   scalar times a norm-one element. The geometry step, with the geometry removed.
7. **`not_forces_of_map_ne_zero` / `not_separated_of_map_eq_zero`** — the two compulsion consumers,
   general. *Distinct names from the `FieldWall4`-namespaced specializations*, so that inside
   `namespace FieldWall4` the two never shadow one another.

### `FieldWall4.lean` — shrink

Add `instance : NoZeroDivisors F4` (sixteen cases, `decide`), then re-prove
`residueColouring_ne_of_dist_one` and `residueColouring_eq_of_dist_two` through §7. Statements
unchanged. **The honest test of this package is that this file gets smaller**; `wc -l` before is
**1398**, and the result is reported either way.

### `ValuationLaw.lean` — re-express on the general law

Every statement in §1–§4 keeps its name, its signature and its meaning; the proofs become
instantiations. `psiA_conj` stays (it is a true and sharper fact about this residue field) and is
what discharges §7's `σ`-stable-kernel hypothesis. `seamColouring` stays — **ledger row 59 cites it
by name** — and gains a sibling `seamResidueColouring` valued in `F4` itself, which is what the
`Palette` helpers consume.

### `Additive.lean` — drop the inline equivalence

Two proofs, each `let e := Fintype.equivFinOfCardEq hk; …` → one call to a `Palette` helper.

---

## §2 The skeleton

Written as real files with `sorry` at every leaf, so the *specification* elaborates before any proof
effort. Commit `skeleton: P6` carries it. Every declaration below is a signature this milestone
commits to; the proofs are the milestone.

## §3 Registered predictions

| # | prediction | how it fails |
|---|---|---|
| **P1** | `FieldWall4.lean` is **smaller** at the close than 1398 lines. | It is not, in which case the generalization added a layer rather than absorbing one, and the report says so in those words. |
| **P2** | All seven rows of `[Parts2020a]`'s Table 1 (`ValuationLaw.lean` §4) hold with their statements byte-identical. | Any row needs a hypothesis it did not need before. |
| **P3** | `./scripts/axioms.sh` reports **725 or more clean and exactly 5 purchases**. | The 5 moves — halt and report. |
| **P4** | The `σ`-stable-kernel hypothesis `ψ (σ z) = 0 → ψ z = 0` suffices for the squared-distance half; the Frobenius identity is *not* needed in general. | The general proof needs `ψ ∘ σ = F ∘ ψ` for an injective `F` after all, in which case that hypothesis is named precisely in the report and the finding is *why the law looked field-specific*. **Probed and provisionally met before this file was written** (`map_mul_conj_eq_zero_iff` elaborates). |
| **P5** | No file outside this package needs editing. | A consumer elsewhere breaks — say so, do not edit it. |
| **P6** | `Additive.lean` gets smaller. | It does not. |

## §4 Risks

* **The build, not the mathematics.** `ResidueColouring.lean` has two dependents and both are mine;
  `Forcer.lean` has 67 and is not touched. Full builds go behind
  `flock /home/kooshi/source/.consolidation-build.lock`.
* **Vacuity** (`CLAUDE.md` G30's fifth failure mode). Every general theorem here has a
  structure-valued hypothesis — a subring, a ring homomorphism, a norm-one element. Each ships with
  a **named inhabitant**: `FieldWall4`'s own `oddDenom`/`psiA` instantiate every one of them, and
  `ValuationLaw.lean` §5 already carries a two-point `K`-object model that the table rows are read
  on. `Palette.lean` carries its own model (a two-vertex complete graph and a `Bool` palette).
* **Name shadowing.** The general consumers are `not_forces_of_map_ne_zero` /
  `not_separated_of_map_eq_zero`, deliberately *not* the names the `FieldWall4` namespace already
  uses.

## §R Results

*(filled at the close)*
