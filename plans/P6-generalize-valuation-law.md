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

## §M1 Domain-modeling pass (WORKFLOW step 5, `debruijn-domain-modeling`)

Three changes, two of them substantive, one cut.

**(a) The scalar half of the law needs no primality — and the mechanism is not the one the
specialization used.** `ValuationLaw.lean` cancels the unit vector by `𝔽₄`-has-no-zero-divisors
(`F4.eq_zero_of_mul_eq_zero`, sixteen cases by `decide`). That is not what is happening. A ring
homomorphism's kernel is an **ideal**, and *a unit is invisible to an ideal* — `a·u ∈ I ↔ a ∈ I`
for any ideal and any unit, which is Mathlib's `Ideal.mul_unit_mem_iff_mem`. So the primitive is

```lean
theorem map_mul_eq_zero_iff_of_isUnit (ψ : A →+* G) {a u : A} (hu : IsUnit u) :
    ψ (a * u) = 0 ↔ ψ a = 0
```

with **no hypothesis on `G` whatsoever** — not `NoZeroDivisors`, not `Nontrivial`, not `Fintype`.
The skeleton had both instances on this lemma and they were incidental structure inherited from
the four-element field.

**(b) The `σ`-stable-kernel hypothesis is stated interiorly, through Mathlib's own restriction.**
The skeleton's hypothesis carried a dependent double binder
(`∀ z, ∀ hz : z ∈ A, ψ ⟨σ z, hσ z hz⟩ = 0 → …`), which is the anonymous-constructor smell.
`RingHom.restrict` (`Mathlib/Algebra/Ring/Subring/Basic.lean:981`) restricts `σ : L →+* L` to
`A →+* A` given exactly the stability hypothesis we already hold, so the statement becomes

```lean
theorem map_mul_conj_eq_zero_iff [NoZeroDivisors G] (hσ : ∀ z ∈ A, σ z ∈ A) (ψ : A →+* G)
    (hker : ∀ z : A, ψ (σ.restrict A A hσ z) = 0 → ψ z = 0) (v : A) :
    ψ (v * σ.restrict A A hσ v) = 0 ↔ ψ v = 0
```

— one binder, no anonymous constructors, and `[Nontrivial G]` drops out (`mul_eq_zero` does not
want it). **This is the half where primality is genuinely spent**, and the honest hypothesis is
`(RingHom.ker ψ).IsPrime`; `[NoZeroDivisors G]` is chosen instead because it is *instance-implicit*
and therefore free at every call site (every target here is a residue field), where `IsPrime` is a
hypothesis every caller would have to discharge by hand. The alternative is recorded in a `--`
comment beside the statement.

**(c) Cut.** `forces_iff_forall_coloring` / `separated_iff_forall_coloring` are dropped — no
consumer, and a caller holding both directions can assemble the `iff` in one line. Eight
declarations in `Palette.lean`, not ten.

**The adversarial member, and it is the mathematics.** Drop `hker` from (b) and the statement is
false, with the counterexample being **exactly a split prime**: take `A = ZMod 5 × ZMod 5`
(which *is* `ℤ[i]/5`), `σ` the coordinate swap (which *is* complex conjugation), `ψ` the first
projection (which *is* reduction at one of the two primes above 5). Then `v = (1, 0)` has
`ψ v = 1 ≠ 0` while `v · σ v = 0`, so `ψ (v · σ v) = 0`. That is the concrete reason the field-wall
theorem demands a prime **fixed** by conjugation, and it ships as a red in `ResidueColouring.lean`
§4, decidable in four lines.

**Non-vacuity.** §4's model is `ℤ` with `σ = RingHom.id`, `A = ⊤`, `ψ = Int.castRingHom (ZMod 2)`;
its norm-one set is `{1, −1}`, so the norm-one hypothesis is exercised by a member that is not the
identity. The field-level inhabitant is `ValuationLaw.lean`'s own `oddDenom` / `psiA`, named in a
`--` comment.

## §M2 Obligation-modeling pass (`debruijn-obligation-modeling`)

**There is no induction in this package**, and saying so is the pass's first finding: no recursion,
no termination measure, no case tree. The space that has to be characterized is not a space of
inputs but **the space of consumers** — every old statement is fixed in advance, byte-identical, and
only the proofs move. So the local obligation is:

> does each fixed old statement derive from the new general one in two lines? A re-proof that stays
> long is a report that the general statement is the wrong one.

**Both routes into the general layer are used, so both earn their place.** The colouring-level
consumers (`residueColouring_eq_of_forces` and `residueColouring_ne_of_separated`, *both named in
`scripts/Axioms.lean`*) need the residue colouring as an object, which is `normOneColoring`; the
difference-keyed consumers (`not_forces_of_sub`, `not_separated_of_sub`) need the law as a statement
about `Forces`, which is `not_forces_of_map_ne_zero`. The distance-keyed forms and then the seven
table rows derive from the difference-keyed ones. That is the chain, and it is four links:

    general law  →  difference form  →  distance form  →  table row

**`div_mem_normOne` is on probation.** Its only consumer is `sub_mem_oddDenom_of_dist`, whose
existing three-line `field_simp` already produces the same fact. It stays **iff** that proof gets no
longer; otherwise it is speculative structure and is cut, with the cut recorded.

**Mutation audit, designed before the proofs** — three reds, each pinning one hypothesis:

| hypothesis | red |
|---|---|
| `hker` (the kernel is `σ`-stable) in `map_mul_conj_eq_zero_iff` | `A = ZMod 5 × ZMod 5`, `σ` = swap, `ψ` = first projection: `v = (1,0)` has `ψ v ≠ 0` and `v · σ v = 0`. **This is the split prime, concretely** |
| `IsUnit u` in `map_mul_eq_zero_iff_of_isUnit` | `ψ = Int.castRingHom (ZMod 2)`, `a = 1`, `u = 2`: `ψ (1·2) = 0` while `ψ 1 ≠ 0` |
| `Fintype.card α = k` in `Forces.eq_of_card` | `Forces (⊤ : SimpleGraph (Fin 2)) 1 0 1` holds **vacuously** (there is no `Fin 1`-colouring of an edge) while a `Bool`-colouring separates the two vertices |

One implementation note banked from the probe: `map_mul_normOne_eq_zero_iff` needs
`(a := ⟨d, hd⟩)` supplied — the unifier cannot invert `⟨d * u, _⟩` into a product of subtypes on its
own. Every other step of the package elaborated first try.

## §M3 Experience-modeling pass (`debruijn-experience-modeling`)

**The module is named `Palette.lean`** because *palette* is the word this repository already uses for
exactly this concept ("palette symmetry costs 6.5–35× solver time", "up to palette", "the palette
pin"). One vocabulary throughout beats an abstractly better name.

**`cosetResidue_eq_iff_map` exists to remove a fumble the module docstring currently warns about.**
`ResidueColouring.lean`'s own "Using this file" section says *"the subgroup cannot be inferred from
the homomorphism — write `cosetResidue (A := A.toAddSubgroup) ψ.toAddMonoidHom`, or the elaborator
reports a mismatch"*. Taking `ψ : A →+* G` and doing that conversion internally is the fix, and it is
the difference between a warning and a design.

**Argument order is set from the call sites**, not from the proofs: `h.eq_of_card hk C` puts the
colouring last so dot-notation reads as a sentence; `not_forces_of_coloring_ne hk C hne` matches
`Additive.not_forces_of_addMonoidHom`'s existing shape so the two are learned once.

**Machine-user budget: one new instance and one new `@[simp]` lemma, both justified.**
`NoZeroDivisors F4` is canonical for a project-local four-element field. `normOneColoring_apply` is
tagged `@[simp]` to match `additiveColoring_apply`, which is the same unfolding lemma for the same
kind of sealed colouring one module over. Nothing else is tagged.

**`map_mul_conj_eq_zero_iff` keeps the file's `_conj` vocabulary** rather than a more accurate
`_norm`, because `norm` is already spoken for by `‖·‖` and because the file has `conjOn`,
`conj_mem_valuationSubringAtPrime` and `conj_mem_oddDenom`. The hypothesis's *meaning* — that the
prime is fixed by conjugation — goes in the docstring, where a reader expecting the Frobenius
identity will meet it.

## §3 Registered predictions

| # | prediction | how it fails |
|---|---|---|
| **P1** | `FieldWall4.lean` is **smaller** at the close than 1398 lines. | It is not, in which case the generalization added a layer rather than absorbing one, and the report says so in those words. |
| **P2** | All seven rows of `[Parts2020a]`'s Table 1 (`ValuationLaw.lean` §4) hold with their statements byte-identical. | Any row needs a hypothesis it did not need before. |
| **P3** | `./scripts/axioms.sh` reports **725 or more clean and exactly 5 purchases**. | The 5 moves — halt and report. |
| **P4** | The `σ`-stable-kernel hypothesis `ψ (σ z) = 0 → ψ z = 0` suffices for the squared-distance half; the Frobenius identity is *not* needed in general. | The general proof needs `ψ ∘ σ = F ∘ ψ` for an injective `F` after all, in which case that hypothesis is named precisely in the report and the finding is *why the law looked field-specific*. **Probed and provisionally met before this file was written** (`map_mul_conj_eq_zero_iff` elaborates). |
| **P5** | No file outside this package needs editing. | A consumer elsewhere breaks — say so, do not edit it. |
| **P6** | `Additive.lean` gets smaller. | It does not. |
| **P7** | The scalar half of the law is proved with **no** hypothesis on the residue ring (§M1(a)). | It needs one after all. |

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

## §R Results — closed 2026-09-09, LANDED

**The gate, all four items.** `./scripts/build.sh` → `build: OK`. No live `sorry` in `Proofs/`.
`./scripts/axioms.sh` → **747 clean, 5 declared purchases** (baseline 725/5 — the five did not move,
and twenty-two new declarations are audited). `lake lint` → *Linting passed for Proofs*.

### The honest test

| file | before | after | |
|---|---|---|---|
| `FieldWall4.lean` | 1398 | **1392** | **−6 — P1 met** |
| `Additive.lean` | 125 | **122** | −3 — P6 met |
| `ValuationLaw.lean` | 461 | 484 | +23 (three new named facts, below) |
| `ResidueColouring.lean` | 534 | 760 | +226 — the general layer, its docstrings and its two reds |
| `Palette.lean` | — | 114 | new leaf |

The specialization shrank, which is what the test asks. Where it shrank matters more than by how
much: the two proofs the law touches lost 9 lines to the general statements, and **two `private`
theorems of `FieldWall4` turned out to be re-proofs of lemmas `ResidueColouring` already had** —
`mul_conj_eq_one` is `mem_normOne_conj_iff`, and `dist_eq_one_of_normSq` is
`sub_mem_normOne_conj_iff`. Both deleted, both uncited anywhere. Against that, the
`NoZeroDivisors F4` instance and its docstring cost 6.

### Evidence the generalization is absorption and not a layer

Every general declaration has a consumer in this package, which is the check that distinguishes the
two:

| general | instantiated at |
|---|---|
| `normOneColoring` | `colorable_of_normOne` (its own corollary) **and** `seamResidueColouring` |
| `cosetResidue_eq_iff_map` | `residueColouring_eq_iff_sub`, `residueColouring_ne_of_dist_one` |
| `cosetResidue_ne_of_mem_normOne` | `residueColouring_ne_of_dist_one` |
| `map_mul_eq_zero_iff_of_isUnit` | `map_mul_normOne_eq_zero_iff` |
| `map_mul_normOne_eq_zero_iff` | `residueColouring_eq_of_dist_two`, `map_eq_zero_iff_of_mul_conj_eq` |
| `map_mul_conj_eq_zero_iff` | `psiA_eq_zero_iff_normSq` |
| `div_mem_normOne` | `map_eq_zero_iff_of_mul_conj_eq` |
| `map_eq_zero_iff_of_mul_conj_eq` | `sub_mem_oddDenom_of_dist` |
| `not_forces_of_map_ne_zero`, `not_separated_of_map_eq_zero` | `not_forces_of_sub`, `not_separated_of_sub` |
| `Forces.eq_of_card`, `Separated.ne_of_card` | `residueColouring_eq_of_forces`, `..._ne_of_separated` |
| `not_forces_of_coloring_ne`, `not_separated_of_coloring_eq` | `Additive`'s two, and the two above |

Two of `Palette`'s eight — `Forces.of_equiv`, `Separated.of_equiv` — have **no consumer**, and are
kept deliberately: they are the converse direction of the module's own claim, one line each, and
without them the module states half of "compulsions are palette-independent". Recorded rather than
hidden.

### Predictions

| # | outcome |
|---|---|
| **P1** | **MET** — 1398 → 1392 |
| **P2** | **MET** — no pre-existing declaration line was removed or altered anywhere in the package (`git diff -U0 d093033`), so all eleven statements and the seven table rows are byte-identical. The only removals are the two `private` duplicates above |
| **P3** | **MET** — 747 clean, exactly 5 purchases |
| **P4** | **MET** — `map_mul_conj_eq_zero_iff` takes only `ψ (σ z) = 0 → ψ z = 0`. The Frobenius identity `psiA_conj` survives as what *discharges* it at `𝔽₄` (`psiA_ker_stable`), never as what the law needs |
| **P5** | **MET in substance** — no consumer outside the package changed. Two non-consumer files were touched: `Proofs.lean` (one import line, the flat surface) and `scripts/Axioms.lean` (twenty-two audit lines). Neither is another package's |
| **P6** | **MET** — 125 → 122 |
| **P7** | **MET** — `map_mul_eq_zero_iff_of_isUnit` has no hypothesis on the residue ring at all |

### The probation, and its reversal — worth recording as a process note

§M2 put `div_mem_normOne` on probation because its only consumer computed the same fact more
directly, and it was **cut**, with the cut written into the module docstring so nobody re-derived
the negative. Then the *scope* question that had been left implicit got asked out loud — the
difference-keyed law was general and the **distance**-keyed law, which is the form the ledger states
it in, was not — and closing that gap produced `map_eq_zero_iff_of_mul_conj_eq`, whose proof is
exactly `div_mem_normOne` composed with `map_mul_normOne_eq_zero_iff`. The lemma came back with a
consumer, and `sub_mem_oddDenom_of_dist` became an instance (27 → 20 lines).

The process note is the useful part: **the cut was right on the evidence available and wrong on the
evidence one question later.** What surfaced the question was not a better instinct but a written
scope claim being read back against what was actually proved.

### Scope, stated plainly

**What is now general**: the residue law keyed on the difference, keyed on the scalar over a field,
its two compulsion consumers, and the residue colouring as an object — at any commutative ring, any
`σ`-stable subring, any residue map into a ring, any colour count.

**What is necessarily not**: the *integrality* step — that a unit vector lies in the subring. Over
`K` that is `mem_oddDenom_of_unit`, an elementary parity descent, and it cannot be general because
`oddDenom` is an intersection of two localizations rather than a valuation ring, so
`normOne_subset_valuationSubring` does not reach it. `map_eq_zero_iff_of_mul_conj_eq` takes exactly
that one fact as its hypothesis `hq`, and nothing else — **so a caller at a new prime of a new field
owes one lemma and gets the law.** That is the debt this milestone set out to pay, and the shape of
the payment is visible in the signature.
