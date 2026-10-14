# FS133-K1 — the kernel plan for the one-class transfer

*de Bruijn, the planner; job FS133-K1 (brief: `data/fs133/briefs/FS133-K1-kernel-plan.md`). The claim list is
`data/fs133/claims-K1.md`; the derivation is `plans/FS133-E1-derivation.md` (thirteen entries, one mind), read from the
start — this job is not blind. Working files: `data/fs133/k1/`. The outside release is `[OAIMath2026]` family 158 at
commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written), compiled at its
own pin by the audit (`~/.cache/ext-oai1/lean`, EXT-OAI1).*

## Theorems this phase proved

None: a planning job. The skeleton's statements are typed and compile with `sorry` at every leaf (stage 4).

## Stage 1 — SAVED: the readback

**1.1 The brief against the claim list, the claim list against the derivation.** `data/fs133/k1/readback.py` (the
E1 job's tool does not read a source address that carries a `§` section, and is another job's; this one does both
readbacks):

- `readback.py brief` — the nine quotations of the brief, each quoted line a substring of its source: **9 matched,
  0 mismatched**, exit 0 (`readback-brief.out`). With `--fault` (the last character of each quoted line changed):
  0 matched, 9 mismatched, exit 1 (`readback-brief-fault.out`).
- `readback.py claims` — each `K133-<ID>` line of `data/fs133/claims-K1.md` against the `statement:` field of the
  entry `C133-<ID>` at the line number the claim list gives, wrapped lines joined; each `K133-NC-<ID>` against that
  entry's `not claimed:` field: **12 matched, 0 mismatched**, exit 0 (`readback-claims.out`); `K133-NC-ALL` has no
  entry (a line of the claim list's own) and is reported as such. With `--fault`: 0 matched, 12 mismatched, exit 1.

No mismatch, so no finding about the brief's quotations or the claim list's copies.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; both claim lists; the derivation whole
(894 lines); the release's `Ergodicity.lean` ll. 325–415, `Representations.lean` (outline, and ll. 165–193),
`Basic.lean` ll. 1–60 and 222–228, `BorelTransfer.lean` (outline, and ll. 59–68); `plans/EXT-OAI1-audit.md` stage 8's
"Not imported, and why"; the heads of `tools/fs132_k1_port.py` and `tools/fs132_i1_readback.py`.

**1.3 Each statement, its symbols resolved** — in § Stage 3, beside the Lean statement it became.

## Stage 2 — SAVED: how the outside theorem enters

**2.1 The decision** (the coordinator's rulings: the brief's Amendments 1 and 2). The outside theorem enters as the
release's Lean lemma **`OAI.PlaneFiveColor.Spectral.residual_fourier`**
(`lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean` l. 403), declared as an `axiom` in a module of its own,
`Proofs/HadwigerNelson/Outside/OAI158Rigidity.lean`, over copies of the release's definitions. It is the library's
fourth declared axiom and the release's third. It is **not** the manuscript's Theorem 2.3 (`wild_fourier`, l. 335): it
is that theorem composed, in the release's Lean, with the spectral theorem for a unitary representation of the
discrete algebraic plane — the derivation's steps F5–F6 in one line ("`b ⊥ 𝓗_c`, `V_u b = b`, so `⟨b, T_z b⟩ = 0`"),
and the one statement the release's own transfer consumes (`BorelTransfer.lean` l. 61).

**2.2 The statement as the release's kernel stores it** (`data/fs133/k1/readback/ReleaseDump.lean`, run at the
release's pin on the audit's compiled copy; binders read from the stored type, not from the file, where they stand on
a `variable` line, ll. 377–380, with `include hcov`):
`{H : Type u_1} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H] (U : DiscreteE →* unitary (H →L[ℂ] H))
(W : K → unitary (H →L[ℂ] H)) (hcov : ∀ k z w, (W k) (op U z w) = op U (kCoeff k * z) ((W k) w)) (v : H)
(hv : v ∈ (space U)ᗮ) (hfix : ∀ k, (W k) v = v) (z : E) (hz : z ≠ 0) : ⟪v, op U z v⟫_ℂ = 0`.
The declaration here writes every binder in the axiom's own signature. It names seven of the release's constants, all
copied: `E` (`Basic.lean` l. 9), `K` (ll. 11–15), `DiscreteE` (l. 44) with its derived `instCommGroupDiscreteE`,
`kCoeff` (l. 224), `ContinuousVectors.op` (`Representations.lean` l. 171), `ContinuousVectors.space` (ll. 182–192).
None pulls in anything further of the release (the dump's `USES` lines: Mathlib and core only, and each other). The
release's discrete topology on `DiscreteE` is not copied: the statement does not read it.

**2.3 Its axioms at the release's pin**, from the compiled constant (`ReleaseAxioms.lean`, `ReleaseAxioms.out`):
`'OAI.PlaneFiveColor.Spectral.residual_fourier' depends on axioms: [propext, Classical.choice, Quot.sound]`.

**2.4 The read-back across the two pins — six of eight term for term, two up to instance arguments.** One dumper
at both pins (`DumpBody.lean.inc`, FS132-I1's), compared by `readback_terms.py` (a wrapper over
`tools/fs132_i1_readback.py` with this job's table and both namespace pairs; `decls.out`):

| declaration | verdict |
|---|---|
| `Spectral.E`, `Spectral.K`, `Spectral.DiscreteE`, `Spectral.kCoeff`, `ContinuousVectors.op`, `ContinuousVectors.space` | **IDENTICAL**, kind, universes, type, value and constants named (the one rename applied to the release's print: `Set.ofPred` there is `setOf` here) |
| `Spectral.instCommGroupDiscreteE` (derived) | **UP TO INSTANCES**: the two toolchains' `deriving` handlers package the same structure differently (`Monoid.mk` over `One.mk` there, over `Semigroup.mk` here — Mathlib's `Monoid` has other parents at the two pins) |
| `Spectral.residual_fourier` (`theorem` there, `axiom` here) | **UP TO INSTANCES**: binders, kinds, names and every explicit and implicit argument agree; the stored types differ only inside instance arguments |

The second comparison (`readback_erased.py`, over FS132-I2's dumper `ErasedBody.lean.inc`, which writes every
instance argument and every proof argument `_`; `erased.out`) reads all eight alike, and lists the constants named
at one pin only. For the axiom: there `CStarModule.toInner`, `WithCStarModule.instCStarModuleComplex`,
`instCommCStarAlgebraComplex`, `CommSemiring.toSemiring`, `SubsemiringClass.toCommSemiring` and nineteen more of
Mathlib's instance projections; here `InnerProductSpace.toInner`, `DivisionSemiring.toSemiring`,
`Semifield.toDivisionSemiring`, `NormedField.toNormedCommRing`. **So the axiom is not the release's stored statement
term for term, and cannot be at these two pins**: Mathlib's `InnerProductSpace` reaches its inner product through
another class at v4.34.1 than at v4.32.0. What this leaves to trust, as for the ported modules (`LEAN.md`
§ Assumptions): that Mathlib's instances for one class on one type agree at each pin — here the inner product of
`H`, the ring structure of the algebraic plane and of `ℂ`. The library's other two declared theorems of the release
are term for term; this one is at the weaker grade, and its docstring and `ARCHITECTURE.md` line must say so.

**2026-10-13, corrected by FS133-IA1 (the coordinator's Amendment 1 to that job's brief).** The cause given above is
wrong as stated. The inner product of `H` is reached through `CStarModule` at this pin too, when
`Mathlib.Analysis.CStarAlgebra.Module.Constructions` is imported; the four constants § 5.1's leaf R lists as absent at
this pin exist here, in that module and in `Mathlib.Analysis.CStarAlgebra.Classes`, which `Outside/OAI158Rigidity` did
not import — `RebuildProbe.lean` asked under the module's own five imports. With the two imports added (the axiom's
text untouched) the two stored statements differ at four places, in two instance terms, on one path — the `Semiring`
of a `Semifield`, through `CommSemiring` at v4.34.1 and through `DivisionSemiring` at v4.32.0 — and no import list
changes that. The release's statement, rebuilt at this pin, is kernel-equal to the declared one
(`plans/FS133-IA1-implementation.md` stages 2 and 6).

*Controls.* `readback_terms.py --control` plants four faults in this pin's print (the axiom's first explicit binder
made implicit; its first instance binder made explicit; a constant changed in the definition `K`; a declaration
missing): each refused (`decls-control.out`). `readback_erased.py --control` plants a binder kind and a constant
(`kCoeff` for `K`) in the axiom's erased type: each refused (`erased-control.out`). The prints are kept compressed
(`*.out.xz`; `xz -dk` before a re-run). The landing runs both again on the module as recompiled on the joined tree.

**2.5 The four items of `LEAN.md` § Assumptions.** (1) The docstring names `[OAIMath2026]`, the file and line at the
pin, and says what the lemma is and is not. (2) This stage. (3) The model: `Spectral.residual_fourier_model`, in the
same file — the regular representation on `ℓ²` of the algebraic plane, the point mass at the origin, `v ≠ 0`, with
the conclusion proved there by computation; a leaf (plan: § Stage 5, leaf M). (4) The `ARCHITECTURE.md` § Trust line
is drafted in § Drafts; `scripts/Axioms.lean` needs one `AxiomAudit.declareImport` line at the landing.

**2.6 Against a port** (measured from the release's compiled constants, `ReleaseDump.lean`'s second block and
`ReleaseAxioms.lean`; `cones.txt`):

| statement | the release's declarations it rests on | modules | |
|---|---|---|---|
| the headline (`no_proper_five_coloring`) | 3,520 | 70 | the audit's row: "every module of the cone is used" |
| `proper_to_borel_weak` (the transfer) | 1,997 | 32 | the audit's row: "six to eight jobs; about 16,600 lines" |
| **`residual_fourier`** | **1,802** | **30** | this job; wholly inside the transfer's cone (0 of its declarations outside) |
| `wild_fourier` | 1,644 | 29 | the audit's row; wholly inside `residual_fourier`'s |

So one port of the transfer's cone would discharge **two** of the release's three declared theorems here — the
transfer and this lemma — under their present names; the five-colour obstruction needs the rest of the release. (My
message to the coordinator said "all three"; that was wrong, and Amendment 2 corrects it.) A port is declined for
this job and is a decision for the publication pass.

**2.7 What is ported instead: the generic lemmas of the transfer's proof** (kernel-checked here, no axiom) — the
plan is § Stage 5, leaf P. Their cones, from the same run: `exists_measurable_field` 14 declarations (one module),
`orbitExtension_inner` 41 (three), `projection_range` 21, `projection_covariance_fixed` 14,
`projection_coefficient` 18, `positive_orthogonal` 1, `circle_closed_induction` 13, `Koopman.nonlinear_commute` 1 —
all in `Representations.lean`, `BorelTransfer.lean` and `Basic.lean`, none in the label model.

## Stage 3 — SAVED: the statements typed, each read back against its claim

Modules (all new; namespace `HadwigerNelson.Plane` for facts about the plane, `HadwigerNelson.OneClass` for this
milestone's, root `SimpleGraph` for `finIndepRatio` beside the library's `fractionalChromaticNumber`):
`Outside/OAI158Rigidity`, `Plane/OneClass/{SectionDensity, Defs, Field, InvariantLaw, Algebraic, Fractional, Pair}`.

**3.1 The definitions, each beside the printed one** (`[Davies2026]` is the paper of 8 October; its words are quoted in
`plans/FS131-ER1-davies-reading.md` ll. 91–94, the others in `plans/FS133-one-class-transfer.md` § PA.3).

| word | here | the printed definition | the difference, and what covers it |
|---|---|---|---|
| `ᾱ(G)`, `α₁(X)` | `SimpleGraph.finIndepRatio G := ⨅ S nonempty finite, indepNum (G.induce S) / |S|`, in `ℝ≥0∞`; `α₁(ℝ²)` is `(unitDistance ℂ).finIndepRatio`, `α₁(𝒜²)` is `(unitDistance E).finIndepRatio` with `E = algebraicClosure ℚ ℂ` | `[Davies2026]` p. 6: "ᾱ(G) is the infimum of the independence ratios of its nonempty finite induced subgraphs"; `[MatolcsiEtAl2025]` p. 5 | none: Mathlib's `indepNum` of Mathlib's `induce`. Read through `le_finIndepRatio_iff` and `finIndepRatio_le_of_forall_card_le` |
| `m₁(ℝ²)` | `Plane.mOne := ⨆ A Borel, (unitDistance ℂ).IsIndepSet A, upperDensity A`; `upperDensity` is the library's (`Plane/Suprema`): `limsup_{R→∞}` over real `R` of `|A ∩ B(0,R)| / |B(0,R)|` | `[Davies2026]` p. 2: "the supremum of the upper densities of measurable D-avoiding sets"; `[DuczVarga2026]` § 2.1 the same words | (a) Borel here, Lebesgue there: the same number — `mOne_eq_iSup_nullMeasurableSet`, a leaf. (b) the window: discs about the origin here; the papers name none. That every usual window gives one number is the derivation's C133-PER, **not in this module and not claimed**: the headline is about this `upperDensity` |
| `f(n)` | `Plane.minIndepNum n := ⨅ S : {S : Finset ℂ // S.card = n}, indepNum ((unitDistance ℂ).induce S)`, in `ℕ` | `[DuczVarga2026]` p. 1: "the minimum possible independence number of a unit-distance graph arising from n points in the plane" | none |
| `χ_f` | the library's `SimpleGraph.fractionalChromaticNumber` (`Fractional.lean`): `⨅ n / b` over `b`-fold colourings with `n` colours | `[MatolcsiEtAl2025]` p. 4: the infimum of total weights of fractional colourings in which finitely many independent sets have positive weight; `[Johnson1996fcn]`: the `b`-fold form. `[Davies2026]` has no fractional chromatic number | the library's is Johnson's form. That MRVZ's weighted form is the same number (round the finitely many weights up to rationals) is **not proved here**; said in `Fractional`'s module docstring |
| `χ_f,0(ℝ²)` | `⨆ S : Finset ℂ, ((unitDistance ℂ).induce S).fractionalChromaticNumber` | `[MatolcsiEtAl2025]` p. 4: "sup{χf (G) : G ⊆ R2 , G is finite}" | none |
| invariant law | `OneClass.IsInvariantLaw G P`: `P : Measure (E → Bool)` a probability, `∀ᵐ I ∂P, G.IsIndepSet {z | I z = true}`, `P.map (shiftLab z) = P`, `P.map (turnLab u) = P` | the derivation: an `E ⋊ K`-invariant Borel probability on the compact space `𝓘_S ⊆ {0,1}^E` | a probability on the closed set `𝓘_S` is a probability on `{0,1}^E` that gives its complement measure zero; the product σ-algebra on `E → Bool` is the Borel one (`E` countable). `P(0 ∈ I)` is `P {I | I 0 = true}` |
| admissible | `AdmissibleOn N X ℓ`, `AdmissibleAe N ℓ` for a pattern `N : ℝ → Λ → Λ → Prop` | the derivation's stage 6 definitions (`R`, `N_r`) | `R` is `{r | ∃ a b, N r a b}`; symmetry of `N_r` is not asked (both orders of each pair of points are read); "Lebesgue-measurable `ℓ`" is "every fibre `NullMeasurableSet`" |

Each definition has an inhabitant or a drift check in its file: `sectionDensity_univ`, `sectionDensity_empty`;
`isIndepSet_ball_half` (an index of `mOne`'s supremum), `mOne_le_one`; `minIndepNum_one`; `finIndepRatio_le_one`,
`inv_le_finIndepRatio_of_colorable`; `isInvariantLaw_dirac` and `exists_isInvariantLaw_unitDistance`;
`IsInvariantLaw.isPlaneSystem`; `isAlgPattern_colourPattern`, `admissibleOn_colourPattern_iff`,
`exists_admissible_colourPattern_seven`; `Spectral.residual_fourier_model`.

**3.2 Each claim, read back.**

- **K133-DENS-CLASS** → `Plane.sectionDensity_pos_set`. Read aloud: for measures `lam` on `X` and a probability `μ` on
  `Ω`, a measurable `H : X × Ω → ℝ` with `H ≤ 1`, a real `α` with `α ≤ ∫ H (x, ω) dμ` for `lam`-almost every `x`, and
  measurable windows of non-zero finite measure: `D ω = limsup_n lam (Xn n ∩ {x | 0 < H (x, ω)}) / lam (Xn n)` is
  measurable, `ofReal α ≤ ∫⁻ D dμ`, `0 < μ {ω | ofReal α ≤ D ω}`, and every `S` with `μ Sᶜ = 0` holds such an `ω`.
  Against the claim: the same four conclusions. **Wider than the claim in three places** (each a finding; the proof
  reads none of them): no σ-finiteness of `lam`; no `0 ≤ H`; and the statement it is proved from is about any
  measurable `W ⊆ X × Ω` covered pointwise with probability at least `α` (`le_lintegral_sectionDensity` and its
  three companions). `α ≥ 0` is not asked: `ofReal` of a negative `α` is `0`. Not claimed: as the entry's line.
- **K133-INV-CLASS** → `OneClass.exists_isInvariantLaw` (existence, with equality) and
  `OneClass.IsShiftInvariantLaw.measure_zero_le` (the bound). Read aloud: for `S ⊆ E` with `kCoeff u * s ∈ S` for all
  `u ∈ K`, `s ∈ S`, some `P` is an invariant law of `circulantGraph S` with `P {I | I 0 = true} =
  (circulantGraph S).finIndepRatio`; and every translation-invariant law of **any** graph `G` on `E` has
  `P {I | I 0 = true} ≤ G.finIndepRatio`. Against the claim: `Cay(E, S)` is Mathlib's `circulantGraph S`, which
  symmetrises and drops `0`, so "`S ⊆ E ∖ {0}` symmetric" is not a hypothesis (a widening by construction); the bound
  is for any graph, not only a Cayley graph (a widening; step (1) reads only the translations of the law). `a_S` is
  `finIndepRatio`. Not claimed: ergodicity, uniqueness, a single set of that density, necessity of amenability.
- **K133-ALG** → `OneClass.IsInvariantLaw.measure_zero_le_mOne`: for `P` an invariant law of `unitDistance E`,
  `P {I | I 0 = true} ≤ mOne`. The claim word for word. On the declared outside theorem.
- **K133-ONE** → first line: `finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`; second line:
  `iSup_fractionalChromaticNumber_plane` (`χ_f,0(ℝ²)`), `fractionalChromaticNumber_plane`,
  `fractionalChromaticNumber_algPlane`, each `= mOne⁻¹`. All six equalities are stated. `1 / m₁` is `mOne⁻¹` in
  `ℝ≥0∞`; `one_seventh_le_mOne` says `mOne ≠ 0`, so no reciprocal is `⊤`. Not claimed: any value; `m₁ = δ_Croft`;
  attainment by a finite graph; MRVZ's weighted form of `χ_f`; other windows.
- **K133-FN** → `tendsto_minIndepNum_div : Tendsto (fun n => (minIndepNum n : ℝ≥0∞) / n) atTop (𝓝 mOne)`. No rate.
- **K133-PAIR** → `exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane`, for `[Finite Λ]` and
  `IsAlgPattern N`. The forward leaf gives **Borel** fibres (stronger than the claim's Lebesgue); the converse leaf
  takes Lebesgue-measurable fibres and asks only countably many positive distances, **not algebraic** ones (wider:
  the entry's own "uses only" line for the converse). Not claimed: three-point constraints, non-algebraic distances
  in the forward direction, infinitely many labels, admissibility at every pair for a measurable labelling.

**3.3 One statement that is not in the claim list and carries two of them: the field theorem**
(`OneClass.exists_field`, `Plane/OneClass/Field`). C133-ALG's steps F3–F9 and C133-PAIR's steps F2–F5 are the same
argument for one observable and for one observable per label; typed once, for a finite family `f i` of
`[0, 1]`-valued rotation-fixed observables on any `IsPlaneSystem` (a probability space with covariant
measure-preserving actions of `E` and `K`): fields `H i : ℂ × Ω → [0, 1]`, jointly measurable, with (a) the means of
the `f i` at every `x`, (b) every almost-sure affine relation among the `f i`, (c) zero product of `H i (x, ·)` and
`H j (x + w, ·)` on the whole circle `‖w‖ = ‖z‖` whenever `f i · (f j ∘ τ z) = 0` almost surely at one `z ≠ 0` of
`E`. It is **a generalization** of both entries' forward halves (any probability space, not the space of independent
sets; any number of observables; every algebraic radius at once — the form C133-ALG's "not claimed" line says no
entry was written for), and the place where the outside theorem is consumed, once.

**3.4 Defects and widenings found by typing** (each sent to the coordinator): no statement of the claim list is
false or vacuous as typed. Widenings: the three of K133-DENS-CLASS; `circulantGraph` and "any graph" in
K133-INV-CLASS; the converse of K133-PAIR without algebraicity; the field theorem. One narrowing that is a choice,
not a defect: `m₁` is read with discs about the origin (3.1).

## Stage 4 — the skeleton (its build's receipt is in § 4.2)

**4.1 Leaves** (`sorry` at each and nowhere else; the count is of `sorry`s by module). Proved in the skeleton, from
the leaves, with no `sorry` of their own: `exists_mem_le_sectionDensity`, `sectionDensity_pos_set`,
`upperDensity_le_mOne`, `mOne_le_one`, `exists_isInvariantLaw_unitDistance`, `exists_invariant_of_closed`,
`finIndepRatio_algPlane_le_mOne`, `finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`,
`tendsto_minIndepNum_div`, `fractionalChromaticNumber_induce_le`, the three `χ_f` equalities, `AdmissibleOn.mono`,
and both clauses of C133-PAIR. So the assembly of every headline from its leaves is already checked by the
elaborator.

## Stage 5 — SAVED: the plan per leaf

*For an implementer with none of this job's context. Read `LEAN.md` whole first. `E`, `K`, `kCoeff`, `DiscreteE`,
`ContinuousVectors.op`, `.space` are in `Outside/OAI158Rigidity` (namespace `HadwigerNelson.Outside.OAI158`).
Mathlib names below were confirmed at the pin by `data/fs133/k1/Checks.lean` (`Checks.out`; one name there,
`MeasurableEquiv.map_count`, does not exist — find the count measure's invariance under an equivalence by
`exact?`). Library names were read in their files. **No statement in the skeleton may change**; a change you need
comes back to the planner through the coordinator. Prices are in implementer-hours of agent work and are guesses
until a leaf's first child lands: re-price from it.*

### 5.0 The split — four lanes, no file shared

| lane | files | leaves | needs first |
|---|---|---|---|
| **A, the outside side** | `Outside/OAI158Rigidity` (two leaves), the new generated `Outside/OAI158Transfer`, `Plane/OneClass/Field` | M, X, P, F | nothing |
| **B, measure and laws** | `Plane/OneClass/SectionDensity`, `Plane/OneClass/Defs`, `Plane/OneClass/InvariantLaw` | D1–D5, G1–G12, I1–I7 | nothing |
| **C, the plane** | `Plane/OneClass/Algebraic`, then `Plane/OneClass/Fractional` | A1–A5, C1–C3 | statements of A, B only (it can start at once against the skeleton) |
| **D, pairs** | `Plane/OneClass/Pair` | Q1–Q5 | statements of A, B only |

Two implementers: A+D and B+C. The order that removes most risk first: **P, then F** (the heaviest link), in
parallel with **I3–I4** (the two compactness leaves).

### 5.1 Lane A

**P — the ported module `Outside/OAI158Transfer` (generated; no statement of ours).** Make it with the generator of
the last port (`tools/fs132_i2_port.py` is the pattern: the cone from the release's compiled constants, declarations
copied by line range, a patch refused on a statement or a definition; its read-back `tools/fs132_i2_readback.py`;
the licence text `Outside/OAIMath2026-LICENSE.txt` beside the module; an instance on a Mathlib type is `scoped`). Write a
generator of this job's own (`tools/fs133_*`), never edit FS-132's. **Targets** (cones measured, § 2.7):
`EuclideanFiveColor.Koopman.unitary`, `unitary_apply`, `nonlinear_commute`; `ContinuousVectors.isClosed_space`,
`op_mem`, `orbit_continuous`, `nonlinear_mem`, `projection_range`, `covariance_mem`, `projection_covariance_fixed`,
`op_orthogonal`, `projection_coefficient`; `EuclideanFiveColor.projection_fixed_of_contraction`,
`positive_orthogonal`, `exists_measurable_field`; `PlaneFiveColor.Spectral.dense_E`, `orbit_uniformContinuous`,
`orbitExtension`, `orbitExtension_continuous`, `orbitExtension_eq`, `orbitExtension_inner`, `normalized_algebraic`,
`circle_closed_induction`, `E_countable`, `kCoeff_ne_zero`. **Line ranges** (the generator computes the exact cone;
these are where it lies): `Analysis/PlaneSpectrum/Representations.lean` ll. 132–163 (Koopman), 165–231 (continuous
vectors; **omit l. 171 and ll. 182–192**, the definitions `op` and `space`, which this library already has upstream
in `OAI158Rigidity` — the module imports it and opens its namespace), 280–297, 299–348, 350–395;
`Geometry/PlaneColoring/BorelTransfer.lean` ll. 99–125, 126–166, 168–198, 248–311, 313–335; from
`Analysis/PlaneSpectrum/Basic.lean` only what the cone names (`E_countable` ll. 51–58, the `kCoeff` lemmas ll.
226–232, and whatever `dense_E` and `circle_closed_induction` pull: 22 and 9 declarations). Nothing of the label
model (`LabelModel.*`), of `DiscreteE`'s topology, of `D` or `C`. *Hard:* Mathlib differences between v4.34.1 and
v4.32.0 (`LEAN.md` lists four renames; the inner-product hierarchy differs — § 2.4 — so a proof that names
`CStarModule` paths needs a patch, allowed on a proof line, refused on a statement). *Price:* 2–4 h; the first module
of FS-132's port is the yardstick. *Done:* the module builds with no `sorry`, `#print axioms` of each target is the
standard three, the read-back verdicts are IDENTICAL or UP-TO-INSTANCES.

**F — `OneClass.exists_field`** (`Field.lean`; the heaviest link, re-priced). It is the release's
`exists_label_field` (`BorelTransfer.lean` ll. 9–96, 200–245, 337–368: about 200 lines) rewritten for an arbitrary
plane system and a finite family; write it in `Field.lean` (ours), never in the ported module. Fix `H := Lp ℂ 2 P`.
Children, in order, each named:
1. `koopmanShift`, `koopmanTurn` : unitaries of `Lp ℂ 2 P` from `τ z`, `ρ u` (ported `Koopman.unitary`; the
   measurable equivalences come from `shift_zero`/`shift_add`, `turn_one`/`turn_mul` — inverse `τ (-z)`, `ρ u⁻¹`);
   `planeRep : DiscreteE →* unitary (H →L[ℂ] H)` (the release's `representation`, ll. 249–267) and
   `turn_covariance` (its `rotation_covariance`, ll. 270–276, from `IsPlaneSystem.cov`).
2. `obsVector i : H` for `f i` (bounded, so `MemLp`), `obsVector_turn_fixed` (from `hfix`), and
   `inner_obsVector_shift : ⟪obsVector i, op U z (obsVector j)⟫ = ∫ f i * (f j ∘ τ z)` (direction: check against
   `Koopman.unitary_apply` — composition with `τ z` or with its inverse; the statement of `exists_field` is written
   for `(T_z g) ω = g (τ z ω)`; if the ported unitary composes with the inverse, define the representation at `-z`).
3. `proj i := (space U).starProjection (obsVector i)`; `proj_turn_fixed` (ported `projection_covariance_fixed`);
   `proj_range` (ported `projection_range`: real, in `[0, 1]` almost everywhere);
   **`inner_proj_shift`** — the one use of the outside theorem: for `z ≠ 0`,
   `⟪proj i, op U z (proj j)⟫ = ⟪obsVector i, op U z (obsVector j)⟫`. From `residual_fourier_cross` at
   `obsVector i - proj i`, `obsVector j - proj j` (in `(space U)ᗮ` by `Submodule.sub_starProjection_mem_orthogonal`,
   turn-fixed), and the vanishing of the two mixed terms (ported `op_mem`, `op_orthogonal`). The release's
   `projection_coefficient` is this for `i = j`; the two-vector form is ours and is ten lines.
4. `field i : ℂ → H := orbitExtension U (proj i)`; continuous; `field_range` (the `[0,1]`-valued functions are a
   closed set of `Lp`, and `field i a = op U a (proj i)` on `E`, where the range is `proj_range` transported by
   `Koopman.nonlinear_commute` with `clamp` — the release's `fieldVector_range`, ll. 216–233);
   `inner_field : ⟪field i x, field j y⟫ = ⟪proj i, …⟫` at `y - x` (ported `orbitExtension_inner`).
5. `inner_field_circle`: zero at one `z ≠ 0` of `E` gives zero at every `w` with `‖w‖ = ‖z‖`: the set of `w` where
   it vanishes is closed, and contains `kCoeff u * z` for `u ∈ K` (turn-fixedness and covariance), which is dense in
   that circle (ported `circle_closed_induction` is the unit case; scale by `z`, or re-run its proof).
6. The constant: `oneVector` is in `space U` and fixed by every `op U a` (the release's ll. 74–84); so
   `⟪field i x, 1⟫ = ⟪obsVector i, 1⟫` (the mean, clause (a)) and affine relations pass (`starProjection` and
   `orbitExtension` are linear on `space U` and fix `1`; clause (b)).
7. `exists_measurable_field` (ported) for each `i`, real part clamped to `[0, 1]`; `positive_orthogonal` (ported)
   turns `⟪field i x, field j (x + w)⟫ = 0` into the almost sure zero product (clause (c)).
*Hard:* step 2's direction convention, and step 5's scaling. *Price:* 4–8 h after P. *If P stalls:* F can be written
against P's statements as hypotheses in a scratch copy, but lands only after P.

**X — `Spectral.residual_fourier_cross`.** `inner_map_polarization` (confirmed) for `T := op U z`: `⟪v, T w⟫` is a
combination of four values `⟪x, T x⟫` at `x = v + w, v - w, v + I • w, v - I • w` (read its statement for the
order of the arguments); each `x` is in `(space U)ᗮ` (a submodule) and turn-fixed (`map_add`, `map_smul`), so each
value is `0` by `residual_fourier`. 15 lines. Its axioms must print the standard three and `residual_fourier`.

**M — `Spectral.residual_fourier_model`.** `H := Lp ℂ 2 (Measure.count : Measure E)` (or `lp (fun _ : E => ℂ) 2`);
`U z` composition with `· + z`, `W u` with multiplication by `kCoeff u` (both bijections of `E`, count-preserving;
`Lp.compMeasurePreserving` confirmed; the ported `Koopman.unitary` is downstream of this file, so build the two
unitaries by hand here or with `Unitary.linearIsometryEquiv.symm`); `v` the indicator of `{0}`. Covariance and
`W u v = v` are computations on points. `v ∈ (space U)ᗮ`: for `w ∈ space U` the coordinate at `0` of `op U a w`
tends to `w 0` as `a → 0`, and is `w (±a)`; along a sequence of distinct non-zero `a_n → 0` in `E` (`E` is dense in
`ℂ`: `1/n` will do) the values `w (a_n)` are square-summable, so tend to `0`; hence `w 0 = 0 = ⟪v, w⟫`. The last
clause is `⟪δ_0, δ_{∓z}⟫ = 0`. *No axiom may appear in its `#print axioms`.* Price: 2–3 h.

**R — the rebuilt-type comparison (Amendment 3's idea): dropped as posed, and what survives.** Measured
(`data/fs133/k1/readback/RebuildProbe.lean`, `.out`): of the 120 constants the release's stored type of
`residual_fourier` names, **four do not exist at this pin** — `instCommCStarAlgebraComplex`, `CStarModule.toInner`,
`CommCStarAlgebra.toNormedCommRing`, `WithCStarModule.instCStarModuleComplex` — so the release's term cannot be
rebuilt here constant by constant: they are the path by which v4.34.1 reaches the inner product of `H` and the
normed ring `ℂ`. What survives, as an optional leaf for lane A (2–3 h of meta-code, a receipt and a docstring
sentence): parse the release's dump (`ReleaseDump.out.xz`, the `DUMP … type` line) into an `Expr` at this pin with
every application headed by one of those four replaced by a metavariable of the same type class, let this pin's
instance resolution fill them, and ask `Meta.isDefEq` and then the kernel (`Lean.Meta.check` on an `Eq` statement
proved by `rfl`) whether the result is the declared type. A yes would shrink what is trusted from "Mathlib's
instances agree at each pin" to "those four paths mean the inner product and the norm they mean here". Control: a
planted change in the rebuilt type (a binder kind, `kCoeff` for another constant) must be refused.

### 5.2 Lane B

**D1 `sectionDensity_univ`, D2 `sectionDensity_empty`**: unfold, `ENNReal.div_self`, `limsup_const`. 10 lines.
**D3 `measurable_sectionDensity`**: each `ω ↦ lam (Xn n ∩ {x | (x, ω) ∈ W})` is
`(lam.restrict (Xn n)) {x | (x, ω) ∈ W}`, measurable by `measurable_measure_prodMk_right` for the finite measure
`lam.restrict (Xn n)` (it wants the section as `Prod.mk · ω ⁻¹' W` — check which factor it fixes; swap if needed);
divide by a constant; `Measurable.limsup` (or `measurable_limsup`). **D4 `le_lintegral_sectionDensity`** — the
reverse Fatou step: with `A n ω` the ratio, `A n ≤ 1`; `∫⁻ A n dμ = (lam (Xn n))⁻¹ * (lam.restrict (Xn n)).prod μ W`
by `lintegral_prod`/`Measure.prod_apply` (Tonelli, both orders: `Measure.prod_swap` or `lintegral_prod_symm`),
`≥ α` by `hcov` and `lintegral_mono_ae`; then `limsup_lintegral_le 1 …` (confirmed; it asks `A n ≤ g` almost
everywhere and `∫⁻ g ≠ ⊤`; `g = 1`, `μ` a probability) gives `α ≤ limsup ∫⁻ A n ≤ ∫⁻ limsup A n`. 40–60 lines.
**D5 `measure_le_sectionDensity_pos`**: by contradiction, `D < α` almost everywhere; `α ≠ ⊤` (else D4 is absurd as
`D ≤ 1`); `∫⁻ D < α` by `lintegral_strict_mono` against the constant (`D` measurable by D3, `∫⁻ D ≤ 1 < ⊤`).
**`ofReal_integral_le_measure_pos`**: if `h` is not integrable the integral is `0`; else `∫ h ≤ ∫ 1_{h>0}` pointwise
(`h ≤ 1`, and `h ≤ 0` off the set), and that is `μ.real {h > 0}`. Lane price: 3–4 h.

**G1 `le_finIndepRatio_iff`, G2 `finIndepRatio_le_of_forall_card_le`** — the two readings of `finIndepRatio`;
everything else goes through them. The bridge is one fact: for `S : Finset V`,
`(G.induce ↑S).indepNum = the largest card of I ⊆ S with G.IsIndepSet ↑I` — from `exists_isNIndepSet_indepNum` and
`IsIndepSet.card_le_indepNum` (confirmed) through `Finset.map`/`Finset.subtype` between `Finset ↥S` and
`{I // I ⊆ S}` (Mathlib has `isNIndepSet_induce`-like lemmas near `Clique.lean` l. 925: read them first). Name the
bridge (`indepNum_induce_finset`) and prove G1, G2, **G3 `finIndepRatio_le_one`**, **G4
`finIndepRatio_le_of_embedding`** (image of `S` under `f`; an independent subset of the image pulls back),
**G5 `inv_le_finIndepRatio_of_colorable`** (pigeonhole: `Finset.exists_lt_card_fiber_of_…` or
`Finset.card_eq_sum_card_fiberwise`; a colour class is independent), **G6
`inv_finIndepRatio_le_iSup_fractionalChromaticNumber`** (the library's `le_fractionalChromaticNumber_of_indepNum`
on `G.induce ↑S` with `a := indepNum`; when `indepNum = 0` the set is empty; `ENNReal.inv_le_iff`-style algebra and
`iInf`/`iSup` duality: `(⨅ x)⁻¹ = ⨆ x⁻¹`, `ENNReal.inv_iInf`). **G7 `isIndepSet_unitDistance_iff`** (`unitDistance_adj`;
`dist x x = 0 ≠ 1` covers `x = y`), **G8 `isIndepSet_ball_half`**, **G9 `mOne_eq_iSup_nullMeasurableSet`**
(`NullMeasurableSet.exists_measurable_subset_ae_eq`, confirmed: a Borel subset equal almost everywhere; a subset of
an independent set is independent; `upperDensity` agrees on almost-everywhere-equal sets — name that lemma,
`upperDensity_congr_ae`; A1 uses it too), **G10 `minIndepNum_one`**, **G11 `algPlaneEmbedding`'s `map_rel_iff'`**
(`unitDistance_adj` twice; the subtype's distance is the ambient one: `Subtype.dist_eq`), **G12
`IsInvariantLaw.isPlaneSystem`, `isInvariantLaw_dirac`** (measurability of `shiftLab z`, `turnLab u`:
`measurable_pi_lambda`; `MeasurePreserving` from the `map` equalities; the five algebraic laws by `funext` and
`ring`-like rewriting in `E`; the covariance is checked by hand in § 6.1). Lane price for G: 4–6 h.

**I1 `IsShiftInvariantLaw.measure_zero_le`**: by G1's dual — show `P {I 0 = true} * S.card ≤ indepNum` for each
nonempty finite `S`: `∑ g ∈ S, P {I | I g = true} = ∫⁻ I, #{g ∈ S | I g = true} ∂P` (`lintegral_finset_sum` of
indicators), each term is `P {I 0 = true}` (`{I | I g = true} = shiftLab g ⁻¹' {I | I 0 = true}` and
`h.shift g`), and the integrand is at most `indepNum` almost surely (`h.indep`, `IsIndepSet.card_le_indepNum` through
the bridge). 40 lines.
**I2 `exists_foelner_finset`**: a `ℚ`-basis `b` of `A` indexed by a countable type (`Module.Basis.ofVectorSpace`,
confirmed), enumerate it; `F n` := the points `∑_{i<n} (c i / n!) • b i` with integers `|c i| ≤ n · n!` — an
injective image of a box, so its card is `(2 n n! + 1)^n`. For fixed `z`, once `n` passes the support of `z` and the
denominators of its coordinates, `z` is in the lattice and moves the box by at most `|z_i| n!` in coordinate `i`:
the proportion leaving is at most `∑_i |z_i| / (2n) → 0`. *Hard:* bookkeeping in `Finsupp` coordinates. If it
fights, a simpler family: restrict to what is needed, `A = E`, but the proof is the same. Price: 4–6 h.
**I3 `exists_shiftInvariant_of_foelner`**: `X := E → Λ` is compact, Hausdorff, second countable
(`Pi.compactSpace`; `E` countable — leaf `countable_algPlane`, from `Algebraic.countable`, as the release's
`E_countable`), Borel (`Pi.borelSpace` needs `Countable E`, `SecondCountableTopology Λ`, `BorelSpace Λ` — give `Λ`
the instances locally from `DiscreteTopology` + `MeasurableSingletonClass` + `Finite`). `ν n : ProbabilityMeasure X`
:= the average over `r ∈ F n` of `dirac (shiftLab r (ℓ n))`. `CompactSpace (ProbabilityMeasure X)` (instance,
`Mathlib/MeasureTheory/Measure/Prokhorov.lean` l. 167; it asks `T2Space`, `BorelSpace`) and first countability of
the weak topology on a compact metrizable space — or avoid sequences: take a cluster point of `ν` along `atTop`
(`exists_clusterPt_of_compactSpace`/`CompactSpace.…`) and argue with `ClusterPt` and continuity of
`ν ↦ ∫ g dν` for continuous `g`. Each claim is a closed condition met eventually up to an error tending to `0`:
(carried by `C`) `ν n C = 1` and `C` closed (Portmanteau: `ProbabilityMeasure.le_liminf…`/`limsup_measure_closed_le`);
(invariance) for continuous `g`, `|∫ g∘shiftLab z dν n − ∫ g dν n| ≤ 2 ‖g‖ · #{r ∈ F n | r + z ∉ F n} / #F n`, and a
Borel probability on a metrizable space is determined by its integrals of continuous bounded functions
(`ProbabilityMeasure` ext via `BoundedContinuousFunction`); (the origin's label) `{ℓ' | ℓ' 0 = a}` is clopen, so its
indicator is continuous and `ν n` of it is `#{r ∈ F n | ℓ n r = a} / #F n ≥ c`. Price: 6–10 h; the heaviest of lane B.
**I4 `exists_turnInvariant`** — no Markov–Kakutani. Child, generic (state it in this file):
*`exists_common_fixed` — for a compact metrizable Borel `X`, countably many commuting continuous `g i : X → X`, and
a nonempty weakly closed set `𝒫` of `ProbabilityMeasure X` such that for each `i`, `P ∈ 𝒫` and `n > 0` the Cesàro
average `(1/n) ∑_{k<n} (g i)^k_* P` is in `𝒫`: some `P ∈ 𝒫` has `(g i)_* P = P` for every `i`.* Proof: one map
first (Krylov–Bogolyubov: a cluster point `Q` of the Cesàro averages is in `𝒫` and fixed, as
`(g)_* A_n − A_n` has total mass at most `2/n` and `ProbabilityMeasure.continuous_map` (confirmed) carries the
limit); then enumerate the maps, let `𝒫_j` be the members of `𝒫` fixed by the first `j` maps — closed, nonempty by
the one-map step applied to map `j` on `𝒫_j` (Cesàro averages of `g j` stay fixed by the earlier maps because the
maps commute), nested — and intersect (`IsCompact.nonempty_iInter_of_directed_nonempty_isCompact_isClosed`,
confirmed). Then I4 is its instance: `g u := turnLab u` (`K` is countable — a subtype of the countable `E` through
`kCoeff`, injective — and commutative), `𝒫` := carried by `C`, shift-invariant, with the origin's label law of
`P₀`; pushing forward by `turnLab u` keeps each (`shiftLab z ∘ turnLab u = turnLab u ∘ shiftLab (kCoeff u * z)`,
`turnLab u ℓ 0 = ℓ 0` as `u * 0 = 0`, `hturn`), averages keep each, and each is weakly closed (as in I3).
Price: 6–10 h.
**I5 `exists_isInvariantLaw`**: `C := {I | (circulantGraph S).IsIndepSet {z | I z = true}}` is closed (an
intersection over pairs of clopen conditions), shift-invariant (`circulantGraph_adj`, confirmed: adjacency reads
`a - b`), turn-invariant (`hS`; `u a − u b = u (a − b)`). `F` from I2 at `A := E`. `ℓ n` := the indicator of an
independent `I ⊆ F n` with `ratio * #F n ≤ #I` (G1 at `r := ratio`). I3 gives `P₀` with
`ofReal ratio.toReal ≤ P₀ {I 0 = true}` (take `a := true`, `c := ratio.toReal`; `ratio ≤ 1`), I4 gives `P`; `≤` is
I1. **I6 `norm_kCoeff_mul`** (`norm_mul`, `Circle.norm_coe`), **I7 `unitDistance_algPlane_eq_circulantGraph`**
(`SimpleGraph.ext`; `dist a b = ‖(a:ℂ) − (b:ℂ)‖`; `fromRel` adds `a ≠ b`, which `‖a − b‖ = 1` implies, and the
symmetric alternative, which `norm_sub_rev` merges). Proved in the skeleton from these:
`exists_isInvariantLaw_unitDistance`, `exists_invariant_of_closed` (lane D's F1).

### 5.3 Lane C

**A1 `exists_measurable_indep_of_field`.** Children, each to be stated as a lemma in `Algebraic.lean`:
(i) `ae_unitPairsNull_section`: for `P`-almost every `ω`, `UnitPairsNull {x | 0 < H (x, ω)}`. The set
`B := {(ω, x, θ) | 0 < H (x, ω) ∧ 0 < H (x + e θ, ω)}` is measurable; each `(x, θ)`-section is `P`-null by `hunit`
(`‖e θ‖ = 1`; a product of two positive numbers is not `0`); so `B` is null for `P ⊗ (volume ⊗ arcLength)` and
almost every `ω`-section is null (`Measure.ae_prod_iff_ae_ae`, confirmed; `arcLength` and `volume` are s-finite).
(ii) the density step: D's set form with `X := ℂ`, `Xn n := ball 0 (n + 1)`, `W := {p | 0 < H p}`, `α := ofReal δ`,
`hcov` from `ofReal_integral_le_measure_pos` and `hmean`; `exists_mem_le_sectionDensity` on the full-measure event of
(i) gives one `ω` with both. (iii) `sectionDensity_ball_le_upperDensity`: the `limsup` over `n` of the ratios on
`ball 0 (n + 1)` is at most `upperDensity` (`Filter.limsup_le_limsup_of_le` along `n ↦ (n + 1 : ℝ)`, which tends
to `atTop`; both confirmed). (iv) **the density points — already in the library**: `A := densitySet W_ω` is Borel
(`measurableSet_densitySet`, `Plane/Cover` l. 993), equals `W_ω` almost everywhere (`ae_eq_densitySet`,
`Plane/Slack` l. 1235), so has the same `upperDensity` (G9's `upperDensity_congr_ae`), and holds no two points at
distance one: `dist_ne_one_of_mem_densitySet hW hnull hy (upperDensityAt_pos_of_mem_densitySet hx)`
(`Plane/DensityPoints` ll. 104, 173). Price: 3–5 h.
**A2 `IsInvariantLaw.measure_zero_le_mOne`**: `exists_field` at `ι := Unit`, the system of G12, `f I := if I 0 then
1 else 0` (measurable: a coordinate; fixed by `turnLab u`: `u * 0 = 0`); clause (c) at `z := 1`: almost surely
`f I * f (shiftLab 1 I) = 0`, because `I 0` and `I 1` are not both true for an independent `I` (`dist 0 1 = 1`).
Then A1 with `δ := ∫ f = (P {I 0 = true}).toReal`, and `upperDensity_le_mOne`. 40 lines.
**A3 `mOne_le_finIndepRatio`** (C133-EASY): by G1 it is enough that for measurable independent `A`, finite nonempty
`S` and `c < upperDensity A` some translate `t` has `c * #S ≤ #{g ∈ S | g + t ∈ A}` (that set is independent: G7).
Average over `t ∈ ball 0 R`: `∫⁻_{ball 0 R} #{g ∈ S | g + t ∈ A} dt = ∑_g volume (A ∩ ball g R) ≥
#S · (volume (A ∩ ball 0 (R − r)))` for `r` bounding `‖g‖`, and `volume (ball 0 (R − r)) / volume (ball 0 R) → 1`;
if the count were below `c #S` at every `t` the integral would be too small for `R` along the `limsup`. Mind the
strict/non-strict edges: prove `c ≤ ratio` for every `c < upperDensity A`, then `le_of_forall_lt`. Price: 4–6 h.
**A4 `one_seventh_le_mOne`**: `inv_le_finIndepRatio_of_colorable` with `(unitDistance ℂ).Colorable 7` — from
`chromaticNumber_plane_interval.2` and `chromaticNumber_plane_eq_complex` as `Outside/OAI158` l. 209 does (those two
are axiom-free; find their module and import it, **not** `Outside/OAI158`) — rewritten by
`finIndepRatio_plane_eq_mOne`. **A5 `tendsto_minIndepNum_div_finIndepRatio`** (Fekete): `u n := (minIndepNum n : ℝ)`
is `Subadditive` (two configurations placed more than `1` apart: the union of an `a`-set and a far translate of a
`b`-set has independence number the sum — independence number is translation-invariant; write the bridge for
`indepNum` of a disjoint far union), so `u n / n → Subadditive.lim` (`Subadditive.tendsto_lim`, confirmed; it wants
a lower bound: `u ≥ 0`), and the limit is `inf_n u n / n`, which is `finIndepRatio.toReal` by G1/G2 read at sets of
each card; move to `ℝ≥0∞` with `ENNReal.tendsto_ofReal`. Price: 4–6 h.

**C1 `exists_periodic_indep`** (periodisation): take measurable independent `A` and `c < c' < upperDensity A`; pick
an integer `L > 2 / (c' − c)`-ish and a disc `ball 0 R` where the ratio exceeds `c'`; the squares of the tiling
`L ℤ²` inside the disc cover it up to a boundary layer, so one square `q + [0, L)²` has `|A ∩ ·| > (c' − small) L²`;
`A' := (A ∩ (q + [1/2, L − 1/2)²)) + L ℤ²` is Borel, `IsPeriodicSet L`, independent (two points of different copies
differ by more than `1` in a coordinate), and loses at most `2L − 1` of area. The statement's square is `[0, L)²` at
the origin: translate by `q` first. **C2 `exists_fold_cover`**: from C1's `P`: (i) `P_r := {x | volume (P ∩ ball x r)
> (3/4) volume (ball x r)}` is open (continuity of `x ↦ volume (P ∩ ball x r)`), periodic, independent (two discs
one unit apart, each more than `3/4` full of `P`, translate onto each other and meet); (ii) its density tends to
`P`'s as `r → 0` (Lebesgue differentiation — `Besicovitch.ae_tendsto_measure_inter_div`, confirmed, for closed
balls; the library's `densitySet` API is the same fact — and dominated convergence on a period); (iii) for
`s = L / M`, `U_M` := the union of the half-open grid squares of side `s` contained in `P_r`, with its periodicity;
`1_{U_M} → 1_{P_r}` pointwise as `M → ∞` along powers of two (`P_r` is open), so the count `n'` of such squares in a
period has `n' s² → |P_r ∩ period|`; (iv) the translates `U_M + t`, `t ∈ {0, s, …, (M−1)s}²`, are `N = M²`
independent sets and every `x` lies in exactly `n'` of them (`x − t` runs once through its coset modulo `L`, which
meets each half-open square once). Use the library's `gridCell`, `IsGridUnion`, `IsPeriodicSet` (`Plane/Suprema`).
**C3 `fractionalChromaticNumber_plane_le`**: for `c < mOne`, C2 gives `FractionalColorable b N` (the map
`x ↦ {j | x ∈ U j}` as a `Finset`; adjacent points share no `j`), so `χ_f ≤ N / b ≤ c⁻¹`
(`FractionalColorable.fractionalChromaticNumber_le`); let `c ↑ mOne` (`ENNReal` order: `le_of_forall_lt`-shaped,
through `ENNReal.inv_le_inv`). *Hard:* C2 is the longest chain of the milestone outside lane A and is other
people's mathematics (Fisher–Ullman's assertion): price 12–20 h; **it is separable** — everything else lands
without it, and only `fractionalChromaticNumber_plane`, `…_algPlane` and half of `iSup_…_plane` wait for it.

### 5.4 Lane D

**Q1–Q3** (`admissibleOn_colourPattern_iff`, `isAlgPattern_colourPattern`, `exists_admissible_colourPattern_seven`):
unfold; `Set.countable_singleton`-shaped; `isAlgebraic_one`; the seven-colouring is the library's (find the Borel
one: `Plane/CoverExamples` or the module `Outside/OAI158` l. 216 uses for `proper_to_borel_weak_model`).
**Q4 `exists_measurable_admissibleAe`** (forward): `C := {ℓ : E → Λ | admissible on E}` — closed, shift- and
turn-invariant (distances are preserved), nonempty (the restriction of `ℓ`); `exists_invariant_of_closed` gives
`P`; the system `(P, shiftLab, turnLab)` is an `IsPlaneSystem` (as G12); `exists_field` at `ι := Λ`,
`f a ℓ := if ℓ 0 = a then 1 else 0`; `∑_a f a = 1` gives `∑_a H a (x, ·) = 1` (clause (b)); for `N r a b` take
`z := (r : E)` (`r` algebraic and non-zero): `f a · (f b ∘ shiftLab z) = 0` almost surely by admissibility at the
points `0`, `z` (distance `r`), so clause (c) gives zero products on the circle of radius `r`. Then Tonelli over
the countably many `(r, a, b)` as in A1 (i), fix one `ω`, and let `ℓ' x` be the least `a` (for a fixed enumeration
of `Λ`) with `0 < H a (x, ω)` where the sum is `1`, a fixed label elsewhere — the release's `positiveSelect`
(`BorelTransfer.lean` ll. 373–399; its `sample_field` ll. 407–433 is the pattern; port them into `OAI158Transfer` if
their statements fit, else write them here). Price: 6–10 h after F.
**Q5 `exists_admissibleOn_of_ae`** (converse; no outside theorem): cores `A a := fibre a ∩` its density points (the
library's `HasDensityOneAt`, `ae_hasDensityOneAt_fibre`, `Plane/LebesgueNumber` ll. 68–141, written for
null-measurable fibres); (i) a two-set, radius-`r` form of the density-point lemma: if `x` is a density point of
`A a`, `y` of `A b`, `dist x y = r > 0`, then the pairs `(x', θ)` with `x' ∈ A a`, `x' + r e θ ∈ A b` have positive
measure — the library's proof of `dist_ne_one_of_mem_densitySet` (`Plane/DensityPoints` ll. 45–165) run for two
sets and a radius, or `Plane/LebesgueNumber`'s `davies_lemma_B1` (l. 374), which is already for a set of distances
and a family of sets: **read its statement first; Q5 may be an instance**; (ii) every finite `F ⊂ ℂ` has a translate
inside the conull union of the cores (`exists_translate_mem`, `Plane/LebesgueNumber` l. 156), so `F` has an
admissible labelling; (iii) compactness: `Finset.rado_selection` (confirmed) as `exists_proper_ae_eq_of_proper_on_conull`
uses it (l. 260), or Tychonoff on `ℂ → Λ` with closed two-coordinate constraints. Price: 6–10 h.

### 5.5 What each headline's `#print axioms` must read when its leaves are done

The standard three and `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier` for: `exists_field`,
`residual_fourier_cross`, `IsInvariantLaw.measure_zero_le_mOne`, `finIndepRatio_*_eq_mOne`, `one_seventh_le_mOne`,
`tendsto_minIndepNum_div`, the three `χ_f` equalities, `exists_measurable_admissibleAe`, both clauses of C133-PAIR.
The standard three only for: everything in `SectionDensity`, `Defs`, `InvariantLaw`; `residual_fourier_model`;
`exists_measurable_indep_of_field`, `mOne_le_finIndepRatio`, `tendsto_minIndepNum_div_finIndepRatio`;
`exists_periodic_indep`, `exists_fold_cover`, `fractionalChromaticNumber_plane_le`; `exists_admissibleOn_of_ae`;
and every declaration of the ported module. A record of the second list that prints the import is a route that
went wrong.

## Stage 6 — SAVED: the three modeling passes (each a fresh skill invocation, scoped to this job)

### 6.1 `debruijn-domain-modeling`

Each representation against the problem's structure; what was kept, what was rejected and why.

- **The random set, not the function.** C133-DENS-CLASS reads `H` only through `{H > 0}` and the probability that a
  point is covered: `sectionDensity` is about a measurable `W ⊆ X × Ω`; the entry's `H`-form is its instance.
- **`E → Bool`, not `Set E`, for a random subset.** `Set E` is `E → Prop`, and Mathlib's topology on `Prop` is
  Sierpiński's: the product is not Hausdorff, and the compactness leaves (I3, I4) would have to leave the type.
  `E → Bool` is the derivation's `{0,1}^E` verbatim; independence is a `Prop` about `{z | I z = true}`, held as a
  field. The same carrier with `Λ` for `Bool` serves C133-PAIR's labellings, so I3 and I4 are stated once.
- **Extrinsic laws.** A law is a `Measure (E → Bool)` and a `Prop`-structure beside it, not a measure on a subtype of
  independent sets: only the proofs read independence, so it is a side predicate (`∀ᵐ`), not an index.
- **Two maps and a covariance, not an action of a semidirect product.** `IsPlaneSystem P τ ρ` has the shape of the
  outside theorem's hypotheses (`U`, `W`, `hcov`) and of the release's label model, which leaf F transcribes; a
  `MulAction` of `Multiplicative E ⋊ K` would be built only to be unpacked. Its covariance convention was checked
  by hand on the model: `shiftLab z (turnLab u ℓ) x = ℓ (u x + u z) = turnLab u (shiftLab (u z) ℓ) x`.
- **One field theorem for one observable and for many.** C133-ALG's F3–F9 and C133-PAIR's F2–F5 were two copies of
  one argument; `exists_field` over a `Fintype` of observables is the collapse, and it earns the next statement
  free (several algebraic radii at once: clause (c) at several `z`).
- **A pattern is a relation indexed by the distance**, `N : ℝ → Λ → Λ → Prop`; the entry's set `R` is where it is
  inhabited.
- *Seams hunted.* `z = 0` in clause (c) is excluded and must be: `⟨b_i, b_j⟩` need not vanish. `α = ⊤` and a
  negative real `α` are harmless in `SectionDensity`. An empty vertex type makes `finIndepRatio` `⊤`
  (`finIndepRatio_le_one` asks `Nonempty`). An asymmetric pattern keeps the two notions of admissibility aligned
  (both read every ordered pair; the almost-everywhere one through `(x, θ) ↦ (x + r e θ, θ + π)`).
- *Changes it made:* none to a definition; one to two statements, found when the skeleton's own assembly refused
  to elaborate: the Følner property was written with `Finset.filter`, whose decidability instance is part of the
  stored statement, and the two leaves that share the property stored different instances. It is now written with
  `Set.ncard` (`{a | a ∈ F n ∧ a + z ∉ F n}.ncard`), which carries none.

### 6.2 `debruijn-obligation-modeling`

The partition: **assume** — `Spectral.residual_fourier` alone; **test** — the drift checks and models of § 3.1;
**prove** — the rest. For each heavy leaf, the statement its proof derives from and the measure down which its
children descend are in § 5: F descends by layer (the measure space → the Hilbert space → the topology of `ℂ` →
back to the measure space), with **`inner_proj_shift`** the one place the import is read and the two-vector form
(`residual_fourier_cross`) the strengthening that makes C133-PAIR's cross terms the same line as C133-ALG's
diagonal ones; I4 descends by the index of an enumeration of the rotations, from the one-map statement
(Krylov–Bogolyubov inside a closed set stable under Cesàro averages), which is the strengthening that removes
Markov–Kakutani and convexity from the statement; C2 descends by the regularity of the set (measurable periodic →
open periodic → finitely many grid squares → a count). Mutation audit, in words: `exists_field` without `hfix`, or
at `z = 0`, is false; `sectionDensity_setOf_pos` without `h1` is false (`H = 2·1_A`); C133-ALG for laws invariant
under translations only is the entry's "not claimed"; `exists_isInvariantLaw` without `hS` loses the rotations'
invariance of the carrier. *Changes it made:* `exists_invariant_of_closed` and `countable_algPlane` are stated
(lane D's step F1 is then two named leaves composed in the skeleton, with no Følner argument of its own).

### 6.3 `debruijn-experience-modeling`

The consumers: later modules, implementers, `exact?`, and a reader of the publication surface.
- **Two names misread and were changed**: `…measure_zero_le…` reads as "measure zero"; they are
  `IsShiftInvariantLaw.measure_origin_le` and `IsInvariantLaw.measure_origin_le_mOne`. `sectionDensity_pos_set` is
  `sectionDensity_setOf_pos`.
- **`mOne` had one reading lemma and now has two**: `upperDensity_le_mOne` and `mOne_le_iff` — no consumer unfolds
  the supremum. `finIndepRatio` has `le_finIndepRatio_iff` and `finIndepRatio_le_of_forall_card_le`.
- **No `@[simp]`, no instance, no notation is minted.** In particular no headline is a simp lemma: each rests on a
  declared import, and a rewrite that fires in silence would spread the import into statements that never named it.
  `countable_algPlane` is a theorem, not an instance (`E` is Mathlib's type): consumers write `haveI`.
- **`prob` is a field** of the law structures and of `IsPlaneSystem`; the docstring gives the idiom
  (`haveI := h.prob`). Kept: a law that is not a probability is not a law.
- **Every theorem that rests on the import says so in its docstring**, and § 5.5 lists which `#print axioms` must
  not show it. The module docstrings carry the "not claimed" lines.
- *Not done, left to the implementers' landing:* a cold-import proof that uses only the public lemmas.

## Drafts for the files this job does not write

- **`LEAN.md` § Assumptions: outside theorems and our own, item 2**, *following* "with a control that fires
  (`Outside.OAI158`; `tools/fs132_i1_readback.py`, on a print made at each pin by one dumper); the landing runs it
  again on the module as recompiled on the joined tree.": **"Where a Mathlib refactor between the pins makes the
  two stored terms differ only inside instance arguments, the planner makes a second print with every instance and
  proof argument erased (FS132-I2's dumper), requires it identical with its own control, lists the constants that
  appear at one pin only, and says the grade in the axiom's docstring and its trust line — 'up to instance
  arguments', never 'term for term'; and it checks which of the release-side constants exist at this pin before
  proposing to rebuild the release's term here (`Outside.OAI158.Spectral.residual_fourier`:
  `data/fs133/k1/readback/`, FS133-K1)."**
- **`LEAN.md` § Searching — Lean**, a new bullet: "`Set E` is `E → Prop` and Mathlib's topology on `Prop` is
  Sierpiński's: a random subset of a countable set that needs compactness is a measure on `E → Bool`
  (`OneClass.IsInvariantLaw`, FS133-K1)."
- **`scripts/Axioms.lean`** (the landing's): one `AxiomAudit.declareImport` line for
  `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier`, and the records of § 5.5's first list under IMPORTED.
- **`CLAUDE.md` § Trust ledger** (the landing's counts): a fourth declared outside axiom, the release's third, "the
  release's lemma `residual_fourier`, its statement the release's up to instance arguments".
- **`ARCHITECTURE.md`**: written in this job (eight rows in § 3's table after `Plane/LebesgueNumber`, one row in
  § 5 Trust); `tools/check_architecture.py` reads PASS.
- **`BIBLIOGRAPHY.md`**: no new work; the row keyed `OAIMath2026` gains "FS-133's module declares its Lean lemma
  `residual_fourier` (`Outside/OAI158Rigidity`) and ports the generic lemmas of its transfer's proof".

## Stage 4.2 — SAVED: the skeleton's build, its leaves, and its axioms

- **The build** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; log `data/fs133/k1/build-skeleton.log`,
  full output `build/gate/build/20261013T211622Z-979653.log`): `build: OK — 249 of 249 batches, 8 module(s)
  rebuilt, 8 module(s) with warnings, 6m50s`, exit 0. Every warning is `declaration uses 'sorry'`; none is a linter's.
  `tools/check_architecture.py`: PASS (349 modules on disk, 349 rows).
- **Leaves** (`sorry` lines by module; each is a whole proof body, none sits inside a proof): `OAI158Rigidity` 2,
  `SectionDensity` 6, `Defs` 13, `Field` 1, `InvariantLaw` 8, `Algebraic` 5, `Fractional` 3, `Pair` 5 — 43. The
  generated `Outside/OAI158Transfer` (leaf P) does not exist yet and has no statement of this job's.
- **Axioms** (`data/fs133/k1/Axioms.lean`, `Axioms.out`): each of the eight headlines, C133-ALG,
  `exists_isInvariantLaw`, `sectionDensity_setOf_pos` and `residual_fourier_cross` prints
  `[propext, sorryAx, Classical.choice, Quot.sound]`. **The declared outside theorem is not in any of these prints,
  and cannot be in a skeleton**: the one place it is read is inside the leaf `residual_fourier_cross`, which
  `exists_field` (a leaf) will use; no proof term exists yet that names it. § 5.5 lists the records whose print
  must show `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier` once the leaves are done, and those whose
  print must not.
- **Not run in this job** (the landing's, on the joined tree): `scripts/axioms.sh`, `vacuity.sh`, `dupnames.sh`,
  `assumptions.sh`, the lint. The new `axiom` is not yet declared to `scripts/Axioms.lean`, so `axioms.sh` would
  fail on it as an undeclared library axiom until the landing adds its line (§ Drafts).
- **A slip of mine, repaired**: twice a command of the form `cd <tree> && ( … ) &` put the `cd` in the background
  job, and what followed ran in the coordinator's tree: one file (`data/fs133/k1/Axioms.lean`) was written there
  and a `git add` there failed on a missing path. The file is moved into this tree; `git status` in the
  coordinator's tree reads clean; nothing was committed there.
