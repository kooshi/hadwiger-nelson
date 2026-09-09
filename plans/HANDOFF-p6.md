# Handoff — package P6 (FS-24 items G7c and G2)

*Written 2026-09-09 for whoever merges this branch, with no memory of the work. Branch
`consolidate/p6`; the subplan with the full record is `plans/P6-generalize-valuation-law.md`.*

---

## 1. What landed

Two things, and the second is the substantial one.

### A new module that makes a colour palette an implementation detail

This repository has two notions it uses constantly: *a pair of points that no proper colouring can
give different colours* (`Forces`) and *a pair no proper colouring can give the same colour*
(`Separated`). Both are defined over the palette `{0, 1, …, k−1}` — Lean's `Fin k` — which is the
right choice, because it matches how "this graph needs `k` colours" is stated.

The cost lands on anyone who *builds* a colouring. Such a colouring comes out valued in whatever
mathematical object built it — a group, a four-element field — never in `{0, 1, …, k−1}` on the
nose, so the caller has to translate. Two files were each doing that translation by hand.

`Proofs/HadwigerNelson/Palette.lean` (new, 114 lines, 8 lemmas) writes it once: **a forced pair is
forced in any palette of the right size, and a separated pair is separated in any palette of the
right size** (`Forces.eq_of_card`, `Separated.ne_of_card`, and the direct refutation forms
`not_forces_of_coloring_ne`, `not_separated_of_coloring_eq`). Nothing here is deep. It is in a
module of its own because adding a declaration to `Forcer.lean` would rebuild that file's
sixty-seven dependents forever after, where a new leaf costs one rebuild and nothing thereafter.

### The 2-adic law of four-colour compulsions, moved to the level its proof already occupied

*Background, in one paragraph.* Over the number field `K = ℚ(√3, √11)` the plane needs exactly four
colours, and the four-colouring that proves it is a **residue colouring**: pick a prime above 2 that
complex conjugation fixes, and colour a point by the residue of its coordinates modulo that prime.
Because that is one particular proper four-colouring, any claim of the form *"in every proper
four-colouring these two points agree"* must be true of it — and which pairs it identifies is
arithmetic, not geometry. `ValuationLaw.lean` is that observation as a theorem; it explains, row for
row, a table of computer-found results in a published paper that the paper does not explain.

That file was written at one field, one prime, one four-element residue field and the literal number
`4`. **Its proof needs none of those.** The general statements now live in
`Proofs/HadwigerNelson/ResidueColouring.lean` §4, and the law is two facts:

1. **A unit is invisible to a residue.** The kernel of a ring homomorphism is an *ideal*, and
   multiplying by a unit does not move anything in or out of an ideal. So if a difference factors as
   "a scalar times a unit vector", its residue is the scalar's (`map_mul_eq_zero_iff_of_isUnit`,
   `map_mul_normOne_eq_zero_iff`). **This half assumes nothing whatever about the residue ring** —
   not that it is finite, not that it is a field, not that it is non-trivial. The four-element
   field's *no-zero-divisors* argument, which is how the step was first written, is not the
   mechanism.
2. **A conjugation-stable kernel makes the norm a test for the element**
   (`map_mul_conj_eq_zero_iff`). The specialization used a fact peculiar to the four-element field
   (conjugation there is squaring); what the argument needs is only that conjugation maps the
   residue map's kernel into itself — **which is exactly the hypothesis the field-wall write-up
   states its theorem with: that the prime is fixed by conjugation.** This is the half where
   primality is spent.

On top sit the residue colouring as an object (`normOneColoring`), the law keyed on the difference
(`cosetResidue_eq_iff_map`) and, over a field, keyed on the *distance*
(`map_eq_zero_iff_of_mul_conj_eq`), and the two consumers the hunt speaks in:
`not_forces_of_map_ne_zero` and `not_separated_of_map_eq_zero`.

**Every one of `ValuationLaw.lean`'s statements is byte-identical to what it was**, including the
seven rows of the published table; every proof is now an instance of the general law.

### The one thing that stays field-specific, and why

A caller at a new prime of a new field owes exactly one fact: **that a unit vector is integral at
that prime.** Over `K` that is a parity descent (`mem_oddDenom_of_unit`), and it cannot be made
general, because `K`'s subring is an intersection of two localizations rather than a valuation ring,
so the general integrality theorem this file already has does not reach it.
`map_eq_zero_iff_of_mul_conj_eq` takes precisely that as its hypothesis `hq` and nothing else — so
the shape of the remaining debt is visible in the signature, which is the point.

### The gate

| check | result |
|---|---|
| `./scripts/build.sh` | **build: OK** |
| live `sorry` in `Proofs/` | **none** |
| `./scripts/axioms.sh` | **747 clean, 5 declared purchases** (baseline 725 / 5 — the five did not move) |
| `lake lint` | **Linting passed** |
| every cited name still resolves | 30 checked, 0 errors |
| pre-existing declaration statements altered | **none** — `git diff -U0 d093033` shows no removed `theorem`/`def` line except two `private` duplicates (below) |

**The honest test: `FieldWall4.lean` went 1398 → 1392 lines.** Six of those came from the two proofs
the law touches; two `private` theorems of that file turned out to be re-proofs of lemmas
`ResidueColouring.lean` already had (`mul_conj_eq_one` is `mem_normOne_conj_iff`;
`dist_eq_one_of_normSq` is `sub_mem_normOne_conj_iff`) and are gone. Against that, a new
`NoZeroDivisors F4` instance and its docstring cost six. `Additive.lean` went 125 → 122.
`ValuationLaw.lean` went 461 → 484 (it gains three genuinely useful named facts);
`ResidueColouring.lean` went 534 → 760, which is the general layer itself.

---

## 2. The amendments I would make to `CLAUDE.md`

*(I did not edit it — package P1 and the coordinator own it. Text below is written to be pasted.)*

### (a) Ledger row 59 — append to the end of the row's prose, before the file-paths cell

> **GENERALIZED 2026-09-09 (FS-24 item G2, package P6; kernel, standard three axioms).** The law was
> stated at one field, one prime, one four-element residue field and the literal `4`; its proof needs
> none of those, and the general statements now live in `ResidueColouring.lean` §4 with every
> `ValuationLaw.lean` statement — the seven `[Parts2020a]` rows included — **byte-identical** and
> every proof an instance. **Two findings came out of the move.** (1) **The scalar half needs
> nothing at all of the residue ring.** This row's own sentence *"`𝔽₄` has no zero divisors, by
> exhaustion over sixteen pairs"* names the wrong mechanism: the kernel of a ring homomorphism is an
> **ideal**, and an ideal absorbs units both ways (`map_mul_eq_zero_iff_of_isUnit`, no hypothesis on
> the target whatsoever). The sixteen-case exhaustion is true and was never the reason. (2) **The
> squared-distance half does not need Frobenius, and what it does need is the write-up's own
> hypothesis.** `psiA_conj` (conjugation induces squaring on `𝔽₄`) is special to that field;
> `map_mul_conj_eq_zero_iff` asks only that conjugation map the residue map's kernel into itself —
> *that the prime is fixed by conjugation* — and `psiA_conj` survives as what discharges it here
> (`psiA_ker_stable`). **The red that pins it is a split prime, concretely**: `ZMod 5 × ZMod 5` *is*
> `ℤ[i]/5`, the coordinate swap *is* complex conjugation, the first projection *is* reduction at one
> of the two primes above 5 — and conjugation exchanges them rather than fixing either, so
> `v = (1, 0)` has nonzero residue while its norm vanishes. **What a caller at a new prime of a new
> field now owes is one fact — that a unit vector is integral there** (`map_eq_zero_iff_of_mul_conj_eq`'s
> hypothesis `hq`), which is the only step that cannot be general (`K`'s subring is an intersection
> of two localizations, not a valuation ring, so `normOne_subset_valuationSubring` does not reach it).
> `FieldWall4.lean` got **smaller**, 1398 → 1392, which was the registered honest test.

And in the row's file-paths cell, append: `Proofs/HadwigerNelson/ResidueColouring.lean` §4,
`Proofs/HadwigerNelson/Palette.lean`, `plans/P6-generalize-valuation-law.md`.

### (b) Ledger row 57 (Theorem A) — one sentence appended to the `ResidueColouring.lean` half

> **Extended 2026-09-09 (P6):** the same file now carries the **residue law** — not only *that* the
> residue colouring colours, but *which pairs it identifies*: a unit cofactor is invisible to a
> residue (the kernel is an ideal; nothing is assumed of the residue ring), and a conjugation-stable
> kernel makes the norm a test for the element (where primality is spent, as `[NoZeroDivisors]`).
> The colouring is now available as an object (`normOneColoring`) and not only as a colourability,
> which is what a consumer that must *evaluate* it needs; `colorable_of_normOne` is its corollary,
> statement unchanged.

### (c) § Grokkings, G30 — the sixth failure mode gains an instance

Append to the sixth failure mode's paragraph (*"a CORRECT INSTANCE recorded where a THEOREM was
available"*):

> **A seventh instance, found while generalizing (2026-09-09, P6), and it is the sharpest kind: a
> proof that names the wrong mechanism.** `ValuationLaw.lean` cancelled a unit vector from a residue
> by *"`𝔽₄` has no zero divisors, by exhaustion over sixteen pairs"* — true, decided, and not the
> reason. The reason is that a ring homomorphism's **kernel is an ideal**, and an ideal absorbs units,
> which needs nothing at all of the residue ring. The sixteen-case `decide` is a correct instance
> standing where a one-line theorem was available, and no gate can see it: the statement is right,
> the proof is right, the hypothesis is merely stronger than the argument. *The detector, added to
> the mode's own list: a finite `decide` used to discharge a step that has a name in ring theory.*

### (d) § Grokkings, G21 — a process note worth one sentence

Append:

> **A reversal worth recording (2026-09-09, P6).** A general lemma (`div_mem_normOne`) was designed,
> measured against its only possible consumer, found not to earn its place, and **cut** — with the cut
> written into the module's docstring so nobody re-derived the negative. One question later it came
> back with a consumer, because the *scope claim* being made ("the law is general") was read back
> against what had actually been proved (only the difference-keyed half was; the distance-keyed half,
> which is the form the ledger states, was not). The cut was right on the evidence available and wrong
> on the evidence one question later. **What surfaced the question was not a better instinct but a
> written claim being checked against a written theorem** — which is the same discipline as this
> grokking, applied to a positive rather than to a negative.

---

## 3. What I did NOT do, and why

* **I did not touch `Homogeneous.lean` (item G1)**, which the stub ranks *above* G2 and calls
  blocking for the `√3`-carrier work. It belongs to package P3 and editing it here would have
  collided. It remains the highest-value item of FS-24 and is not done by this package.
* **I did not generalize the `Forces`/`Separated`/`Fan` definitions themselves** away from `Fin k`.
  `Forcer.lean`'s docstring argues for `Fin k` and I agree with it: it is what
  `SimpleGraph.Colorable` quantifies over, so a forcer and the thing it refutes speak about the same
  colourings with no bookkeeping between them. The boundary cost is what `Palette.lean` removes.
* **I did not fold `Fan.Fan` or `Arity.Realizes`/`Absorb.Extends` into the palette treatment**, though
  the stub's G7c bullet names them. None of them has a caller paying the by-hand cost today, and the
  four lemmas that would result would be speculative. `Palette.lean` is the place to add them the day
  one does.
* **Two of `Palette.lean`'s eight lemmas have no consumer** — `Forces.of_equiv` and
  `Separated.of_equiv`, the converse direction. Kept deliberately (one line each; without them the
  module states half of its own claim), and flagged here rather than left to be discovered.
* **I did not attempt the `√3`-carrier-over-`K` proof** that
  `plans/STUB-four-colour-valuation-law.md` leaves open. It is blocked on G1, not on anything here.

## 4. Things another package owns

* **`BIBLIOGRAPHY.md` (P1)** — the prior-art gate (subplan §PA) turned up two works that are **not in
  our bibliography** and should go into §C as named-only rows. Neither bears on this package; both
  are in this project's neighbourhood:
  * **arXiv:2308.02483**, *Prime and polynomial distances in colourings of the plane* — every finite
    colouring of the plane has a monochromatic pair at a distance `f(n)` for any non-constant integer
    polynomial `f`, and at a prime distance. Sits in `[Davies2024]`'s odd-distance line, which
    `BIBLIOGRAPHY.md` already tracks.
  * **arXiv:2511.10813**, *Four plane unit vectors generate a 3-colorable graph* — the Cayley graph
    on four plane unit vectors and their negatives is always 3-colourable, as a case of abelian
    Cayley graphs on four generators whose relation group has rank ≤ 2. **This is close to
    M24–M26's countable-lattice closures** (`χ = 4` exactly for the ⟨ζ₆, σ⟩ ladders) and deserves a
    real read before FS-20 cites anything in that area.
* **`Homogeneous.lean` (P3)** — item G1, as above.
* **`scripts/Axioms.lean`** — I extended it with twenty-two lines for the new public surface. If
  another package also extended it, the merge is additive but the conflict is textual.
* **`Proofs.lean`** — one added import line (`Proofs.HadwigerNelson.Palette`). Same note.

## 5. A note on the prior-art gate's result

The gate (subplan §PA) returned a **negative for the general statement** — nothing in the literature
states, at the level of an arbitrary field and an arbitrary conjugation-fixed prime, which distances
a residue colouring identifies — and it is a **weak** negative, because this project's own
bibliography already holds the answer for the specific case and holds it thoroughly:
`[Ducz2026]` has the identification half in coordinates for the rank-4 Moser ring (June 2026),
`[Parts2020a]` and `[Heule2019]` have the observations, `[Heule2021]` asks in print for a proof, and
`[Polymath16wiki]` has one instance from 2018. **Nothing found today changes any of that, and ledger
row 59's attribution paragraph needs no revision.** What is new here is a scope finding about our own
proof, not a claim against the literature: the specialization was leaning on a fact peculiar to the
four-element field where the general hypothesis is the one the field-wall write-up already states.
