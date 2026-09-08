# Theorem A in the kernel — the general residue colouring (subplan)

*Opened 2026-09-08 by Opus 5, on Kooshi's go, from `plans/STUB-theorem-A-kernel.md`. Branch
`backlog`. The stub's §3a fork is settled: generality is the objective, and the first action was the
reading it registered. This subplan records what that reading found and the shape it forces.*

## 0. What is to be proved

`plans/FIELD-WALL-THEOREM.md` §5.1, Theorem A:

> Let `F ⊂ ℝ` be a number field, `L = F(i)`, and `𝔭` a nonzero prime of `O_L` fixed by complex
> conjugation. Then the unit-distance graph on `F²` is properly colourable with `N(𝔭)` colours.

The stub's §3a ladder put the interesting rung at 4 — drop `ℂ`, distance and geometry entirely.
**This subplan targets rung 4 and reaches rung 2's mathematics on the way**, by replacing the
number theory with the two properties the proof actually uses.

## 1. What the registered reading found

The stub's first instruction: read `LocalGlobal.addCayleyMap`/`addCayleyColoring`,
`Additive.additiveColoring`, `UnitQuadrance` before writing any statement, and decide whether A1 is
nearly free from them or whether they already are the general theorem with the norm-one condition
missing. Read 2026-09-08. **Neither.** They are three different theorems and none of them is this
one:

| existing | what it says | why it is not A1 |
|---|---|---|
| `Additive.additiveColoring` | a hom `V →+ G` nonzero on every edge difference colours a graph on the group `V` | the hom is **total**; A1's residue map is defined only on a subring `A`, and the whole difficulty is that the plane is not `A` |
| `LocalGlobal.addCayleyMap` / `colorable_of_addCayleyMap` | a hom whose kernel misses the connection set maps one Cayley graph to another | again total, and it is a **quotient** statement (fewer vertices), not a coset-representative statement |
| `LocalGlobal.addCayleyColoring` | a table proper along the connection set colours the Cayley graph | a restatement of properness; no algebra |
| `UnitQuadrance.unitQuadrance.map` | a ring hom applied coordinatewise is a graph hom | M58's functoriality — a **different mechanism** (the finite-plane bound), not the residue colouring |

So the work is not free. But the reading pays anyway, because it names the exact gap:
`additiveColoring` is the case `A = ⊤` of the theorem to be written, and the general theorem is
`additiveColoring` with the homomorphism made **partial**. That single change — a hom out of a
subgroup instead of the whole group — is what forces the coset representatives, and it is the whole
content of B1's §8.

## 2. The theorem, in the shape the proof forces

Stripped to what B1's §8 uses, with no `ℂ`, no distance, no ring, no Cayley structure:

> **A graph drawn in an abelian group, all of whose edge differences lie in a subgroup `A` and are
> nonzero under a homomorphism `ψ : A →+ G`, is `|G|`-colourable.**

Choose one representative per coset of `A`; colour a point by `ψ` of its offset from its own
representative. Adjacent points differ by an element of `A`, so they share a representative, so
their colours differ by `ψ` of the edge difference, which is nonzero.

That is rung 4 and past it: the Cayley structure is gone too — the theorem never asks that the
edge set be translation-invariant.

The arithmetic then enters as a *sufficient condition for the two hypotheses*, in three layers:

1. **The unit layer** (replaces "the residue field is a field, so units are nonzero"): if `A` is a
   subring of a commutative ring `L` stable under `σ : L →+* L`, and `u ∈ A` satisfies
   `u · σu = 1`, then `u` is a **unit of `A`**, so its image under any ring hom to a nontrivial
   ring is nonzero. The norm-one condition's entire role.
2. **The integrality layer** (replaces `v_𝔭(u) = 0`): if `L` is a field, `σ` an involution and `A`
   a **valuation subring** stable under `σ`, then every norm-one element lies in `A` — because
   `u · σu = 1` makes `u` a unit of `L` with `u⁻¹ = σu`, and a valuation subring holds `u` or
   `u⁻¹`; in the second case `σ(σu) = u ∈ A`. Two lines, and it is Theorem A's arithmetic step
   with the Dedekind theory deleted. Mathlib's `ValuationSubring` is exactly this hypothesis
   bundled (`mem_or_inv_mem`).
3. **The plane layer**: `dist z w = 1` in `ℂ` is `(z − w) · conj(z − w) = 1`, so A1 as the stub
   stated it is the specialization at `L = ℂ`, `σ = starRingEnd ℂ`.

**Why this is more general than the write-up's Theorem A, and not less.** The write-up's hypotheses
(number field, `L = F(i)`, prime `𝔭` with `𝔭̄ = 𝔭`) enter only to produce a σ-stable valuation
subring with a finite residue field. Layer 2 takes that object as the hypothesis. Everything the
write-up proves follows; nothing it proves is lost; and the statement now also covers B1's `A`,
which is **not** a valuation ring (it is the intersection of the two, one per prime above `2`) and
so is outside the write-up's own statement.

## 3. Module layout

New module `Proofs/HadwigerNelson/ResidueColouring.lean`, imported by `FieldWall4.lean`.

| § | content |
|---|---|
| 1 | `cosetRep`, `sub_cosetRep_mem`, `cosetRep_eq_of_sub_mem`; `residue ψ`, `residue_sub` |
| 2 | `residueColoring` (a `Γ.Coloring G`), `colorable_of_residue` (the numeral form) |
| 3 | `normOne σ`; `isUnit_of_mem_normOne`; `colorable_of_normOne`; `ValuationSubring` bridge |
| 4 | the plane: `colorable_unitDistance_induce_of_subring` — A1 as the stub stated it |
| 5 | the ring-free corollary at `unitQuadrance R`; `additiveColoring` recovered as `A = ⊤` |
| 6 | spec: a model of the hypotheses, the grid, and the planted reds |

Then `FieldWall4.lean` is **cut back**: its §8 colouring machinery (`mk_surjective`, `base`,
`mk_base`, `sub_base_mem`, `base_eq_of_sub_mem`) is deleted, `psiOf` is replaced by a bundled ring
hom `psiA : oddDenom →+* F4`, `psiOf_ne_zero_of_unit` is replaced by the unit layer (which needs a
new six-line `conj_mem_oddDenom`), and `colorable_four_of_subset_seamPlane` becomes an application
of §4. Every name registered in `scripts/Axioms.lean` survives — none of the deleted ones is there.

## 4. Decisions

| # | choice | alternative weighed | why | confidence |
|---|---|---|---|---|
| D1 | the drawn-graph form `f : V → M`, not a Cayley graph on `M` | state it for `addCayley S` only | `induce` (what B1's headline is) has vertex type `↥S`, not a group; `f` covers both and costs nothing | high |
| D2 | hypothesis as `∃ a : A, (a : M) = f v − f w ∧ ψ a ≠ 0` | a dependent pair `∃ h : _ ∈ A, ψ ⟨_, h⟩ ≠ 0`, or two separate hypotheses | one quantifier, no dependent-pair juggling at the call site, and it reads as "the difference lies in `A` with nonzero residue" | medium — if consumers find it awkward, split into `hmem`/`hne` at the ring layer only |
| D3 | `ψ : A →+ G` bundled out of a subgroup | a junk-extended total `ψ : M → G` with an additivity hypothesis (B1's `psiOf`) | the bundled hom composes, carries `map_zero`/`map_add` free, and makes the unit layer one `IsUnit.map` | high |
| D4 | `ValuationSubring` for layer 2 | an explicit `∀ z w, z * w = 1 → z ∈ A ∨ w ∈ A` hypothesis | Mathlib's bundled object is the same hypothesis and brings its own API; the unbundled form is stated too, as the primitive | high |
| D5 | refactor `FieldWall4` rather than leave it | keep both proofs | the stub called the re-derivation the honest test of the abstraction; two copies of one argument is the thing the standard forbids | high |
| D6 | do **not** move `Quad` out of `FieldWall4` | move it, so `R[i]` is available and `unitQuadrance R` becomes an instance | the `unitQuadrance` corollary is available at the **group** level with no ring structure on `R × R`, which is all a consumer needs; moving `Quad` is file surgery that buys a decoration | medium — revisit if a consumer wants the norm-one form over a general ring |

## 5. Registered predictions (scored at the close)

* **P1** — the general theorem plus its three layers lands under 300 lines.
* **P2** — the `FieldWall4` refactor is a net **deletion** (its line count falls).
* **P3** — `additiveColoring` is recoverable as the `A = ⊤` case in under ten lines.
* **P4** — `Subring.toAddSubgroup` coercion friction: `↥A.toAddSubgroup` will *not* be transparently
  `↥A` at the call site, and an explicit `AddMonoidHom` will be needed. (Registered because the
  opposite would save ten lines and I do not know which holds.)
* **P5** — the number-field instantiation (§6, phase 3) will need `IsFractionRing`,
  `IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`, an automorphism fixing the prime,
  and finiteness of the residue field; the σ-stability step is where it stalls if it stalls.
* **P6** — no existing proof in the repository breaks except inside `FieldWall4.lean`.

## 6. Phases and the stop rules

* **Phase 1** — `ResidueColouring.lean`, §§1–6. Unconditional.
* **Phase 2** — the `FieldWall4` refactor. Unconditional; it is the test of Phase 1.
* **Phase 3** — the number-field instantiation (rung 2). **Stop rule, carried from the stub and
  hardened: one attempt, ~150 lines. If the σ-stability of `valuationSubringAtPrime` under a ring
  automorphism fixing the prime is not available within that budget, stop and report Phase 3 as
  not landed, naming the exact missing statement.** Phases 1–2 are the milestone either way; Phase
  3 is the literature-facing instantiation and the ladder's own analysis prices it at "nothing new"
  (§3a rung 3).
* Standing rules (`plans/BACKLOG-FOR-OPUS.md`): never `lake build` — `./scripts/build.sh`; one
  heavy job at a time; HALT on any unexplained crash; register every new headline in
  `scripts/Axioms.lean`; results into `plans/STUB-theorem-A-kernel.md` as `## §B. Built`; do not
  touch `CLAUDE.md` § Frontier / § Grokkings or the frontier-set ranking.

## 7. Domain-modeling pass

*(to be run and recorded before implementation)*

## 8. Obligation-modeling pass

*(to be run and recorded before implementation)*

## 9. Experience-modeling pass

*(to be run and recorded before implementation)*

## 10. Results

*(to be written at the close)*
