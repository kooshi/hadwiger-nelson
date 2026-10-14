import Proofs.HadwigerNelson.Rigidity.Entropy
import Mathlib.Topology.Algebra.Group.Quotient
import Mathlib.MeasureTheory.Constructions.BorelSpace.Basic
import Mathlib.Logic.Equiv.Fin.Basic
import Mathlib.MeasureTheory.Measure.Count

/-!
# Entropy under powers, finite mixtures and finite-fibred factors (FS-131, job FS131-KN9; skeleton)

**What this module is for.** The deduction of `[EinsiedlerLindenstrauss2022]` Theorem 1.2 from its Theorem 1.3
(FS105-DED, `plans/FS105-D-deduction.md` § 2.1, [hand], two minds) reads three facts about the entropy of a map, its classical
inputs C4–C6 there (§ 2.2). Each is stated here in the form the deduction reads, over `Rigidity.ksEntropy` (the infimum form),
and each has an elementary route that needs no conditional measure:

* **C6, Abramov's power formula, in the direction read** (`ksEntropy_eq_zero_of_iterate`): if `T^q` has entropy zero for
  some `q ≥ 1`, so has `T`. The names of `T` of length `q·n` are the names of `T^q` of length `n` for the block label
  (`blockLabel`, `blockEntropy_iterate`), and with the infimum form this needs no invariance of the measure.
* **C5, affinity, in the direction read** (`ksEntropy_finite_mixture_eq_zero`): a uniform finite mixture of invariant
  probability measures of entropy zero has entropy zero — the chain's mixture lemma `Rigidity.ksEntropy_bind_eq_zero` at the
  uniform measure on `Fin J`.
* **C4, Abramov–Rokhlin, in the case read** (`ksEntropy_eq_zero_iff_of_finite`): over a factor by a finite subgroup `G` of a
  compact group, entropy zero on `X ⧸ G` gives entropy zero on `X`. **No Abramov–Rokhlin formula and no disintegration**: a
  finite measurable partition `Q` meeting each coset of `G` in at most one point (`exists_sectionPartition`) and the
  *pattern* of a partition `P` on the cosets (`exists_pattern_names_le`) make the names of `P` a function of the time-zero
  cell of `Q` and the names of the pattern; so `H_n(P) ≤ H_n(pattern) + log |Q|`, and the pattern is a partition of the
  factor.

**The σ-algebra on `X ⧸ G`** in `ksEntropy_eq_zero_iff_of_finite` is the Borel one, as in clause (4) of the declared
`Rigidity.positive_entropy_rigidity` and on its page: the projection is an open embedding on each translate of a small
open set, so the section partition's cells carry Borel sets to Borel sets (`exists_sectionPartition`), and the step needs
no Lusin–Souslin and no `PolishSpace`. **So the deduction of Theorem 1.2 needs no `PolishSpace`**: `Rigidity.haar_or_zero_entropy`
takes none since FS131-KN9 (the coordinator's ruling of 2026-10-14), and its proof reads the declared axiom's clause (4)
as stated. No form over Mathlib's quotient σ-algebra is stated: nothing reads one.

**Inhabitants.** The finite-fibred step's hypotheses: `finFour_fibre_model` (`ℤ/4`, the subgroup `{0, 2}`, the identity, the
uniform probability). The power and the mixture take a measurable map and invariant probability measures: the point mass
and the identity are a model of both, and `Rigidity/PositiveEntropy` reads them at the declared theorem's components. The
block label has a concrete check (an `example`). The plan per leaf: `plans/FS131-KN9-chain-zero-entropy.md` § Stage 2.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory

open scoped ENNReal

variable {X : Type*}

/-! ## C6 in the direction read: entropy zero passes from `T^q` to `T` -/

/-- **The block label of length `q`**: the word `(P x, P (T x), …, P (T^[q-1] x))`, as one letter of `Fin (k ^ q)`. The names
of `T^[q]` for it are the names of `T` read in blocks of `q` (`blockEntropy_iterate`). -/
def blockLabel {k : ℕ} (T : X → X) (P : X → Fin k) (q : ℕ) (x : X) : Fin (k ^ q) :=
  finFunctionFinEquiv fun i : Fin q => P (T^[i] x)

-- The block label of `(x mod 2)` along `x ↦ x + 1`, read for two steps from `0`: the word `(0, 1)`, the letter `0 + 1·2`.
example : blockLabel Nat.succ (fun x => (⟨x % 2, Nat.mod_lt _ two_pos⟩ : Fin 2)) 2 0 = 2 := by decide

/-- The block label is measurable when the map and the label map are. -/
theorem measurable_blockLabel {m : MeasurableSpace X} {k : ℕ} {T : X → X} (hT : Measurable T) {P : X → Fin k}
    (hP : Measurable P) (q : ℕ) : Measurable (blockLabel T P q) := by
  sorry

/-- **The names of `T^[q]` for the block label are the names of `T` of length `q·n`**: the two families of cells are one
family, re-indexed by the equivalence of words `(Fin (q·n) → Fin k) ≃ (Fin n → Fin (k ^ q))`. For every measure. -/
theorem blockEntropy_iterate {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) (q n : ℕ) :
    blockEntropy μ (T^[q]) (blockLabel T P q) n = blockEntropy μ T P (q * n) := by
  sorry

/-- **C6, in the direction the deduction reads** (FS105-DED, step B3): if `T^[q]` has entropy zero for some `q ≥ 1`, so has
`T`. With the infimum form no invariance is read: `h_μ(T, P) ≤ H_{q(n+1)}(T, P)/(q(n+1)) ≤ H_{n+1}(T^q, P^{(q)})/(n+1)` for
every `n`, the second step because `H ≥ 0` or both sides vanish under `ENNReal.ofReal`. -/
theorem ksEntropy_eq_zero_of_iterate {m : MeasurableSpace X} (μ : Measure X) {T : X → X} (hT : Measurable T) {q : ℕ}
    (hq : 0 < q) (h : ksEntropy μ (T^[q]) = 0) : ksEntropy μ T = 0 := by
  sorry

/-! ## C5 in the direction read: a finite mixture -/

/-- **C5, in the direction the deduction reads** (FS105-DED, step B2): the uniform mixture `J⁻¹ (ν 1 + … + ν J)` of
`T`-invariant probability measures of entropy zero has entropy zero. Route: `Rigidity.ksEntropy_bind_eq_zero` with the
uniform probability on `Fin J` and the kernel `j ↦ ν j`; at `J = 0` the measure is `0` (`ksEntropy_zero_measure`). -/
theorem ksEntropy_finite_mixture_eq_zero {m : MeasurableSpace X} {J : ℕ} (ν : Fin J → Measure X)
    (hν : ∀ j, IsProbabilityMeasure (ν j)) {T : X → X} (hT : Measurable T)
    (hpres : ∀ j, MeasurePreserving T (ν j) (ν j)) (hzero : ∀ j, ksEntropy (ν j) T = 0) :
    ksEntropy ((J : ℝ≥0∞)⁻¹ • ∑ j, ν j) T = 0 := by
  sorry

/-! ## C4 in the case read: a factor by a finite subgroup -/

/-- **Coarsening lowers Shannon entropy**: a function of an observation carries at most its entropy. The mass of a fibre of
`f ∘ A` is the sum of the masses of the fibres of `A` above it, and `−x log x` is subadditive on `[0, ∞)` (the port's
`negMulLog_sum_le`). Read by `exists_pattern_names_le`: the names of `P` are a function of `Q` and the names of the
pattern. Not in the port (FS131-KN9 searched `OAI015Shannon`). -/
theorem observationEntropy_comp_le {Y α β : Type*} [MeasurableSpace Y] [Fintype α] [Fintype β] (μ : Measure Y)
    [IsFiniteMeasure μ] (A : Y → α) (hA : ∀ a, MeasurableSet {y | A y = a}) (f : α → β) :
    Outside.OAI015.observationEntropy μ (fun y => f (A y)) ≤ Outside.OAI015.observationEntropy μ A := by
  sorry

section FiniteFibres

variable [AddCommGroup X] [TopologicalSpace X] [IsTopologicalAddGroup X] [MeasurableSpace X] [BorelSpace X]

/-- **A section partition**: on a compact T1 group, a finite subgroup `G` has a finite measurable partition `Q` each of whose
cells meets each coset of `G` in at most one point, and the projection carries every measurable subset of a cell to a
**Borel** set of `X ⧸ G`. Route: `V := (G ∖ {0})ᶜ` is an open neighbourhood of `0` (T1, `G` finite); an open `U ∋ 0` with
`U − U ⊆ V`; finitely many translates `x_i + U` cover `X` (`compact_covered_by_add_left_translates`); `Q x` is the first
translate containing `x`. On `x_i + U` the projection is injective (`U − U` meets `G` only in `0`), continuous and open
(`QuotientAddGroup.isOpenMap_coe`), so an open embedding there (`Topology.IsOpenEmbedding.of_continuous_injective_isOpenMap`),
whose images of Borel sets are Borel (`Topology.IsOpenEmbedding.measurableEmbedding`). No Lusin–Souslin. -/
theorem exists_sectionPartition [CompactSpace X] [T1Space X] (G : AddSubgroup X) (hG : (G : Set X).Finite) :
    ∃ (k : ℕ) (Q : X → Fin k), Measurable Q ∧ (∀ x, ∀ g ∈ G, Q (x + g) = Q x → g = 0) ∧
      ∀ (i : Fin k) (S : Set X), MeasurableSet S →
        MeasurableSet[borel (X ⧸ G)] (QuotientAddGroup.mk' G '' (Q ⁻¹' {i} ∩ S)) := by
  sorry

/-- **The names of a partition are bounded by the names of its pattern on the cosets.** Given a section partition `Q` of
`G` (`exists_sectionPartition`), every finite measurable partition `P` has a partition `R` of the factor — measurable for
the σ-algebra pulled back from the Borel σ-algebra of `X ⧸ G` — with `H_n(P) ≤ H_n(R) + log k` for every `n` and every
measurable `T`. `R` is the pattern: at `x`, for each cell `i` of `Q`, whether the coset `x + G` meets it, and if so the labels
`P` and `Q ∘ T` at the point where it does; each cell of `R` is the preimage of the image of a measurable subset of a cell of
`Q`. The names of `P` are a function of `Q` at time zero and the names of `R`, because `R y (Q y) = (P y, Q (T y))` at every
point (the point of `y + G` in `Q`'s cell of `y` is `y`); then the port's `observationEntropy_joint_le` and
`finiteShannon_le_log_card`, and coarsening by `negMulLog_sum_le`. Neither the finiteness of `G`, nor invariance of `μ`, nor
`T(G) ⊆ G` is read. -/
theorem exists_pattern_names_le (μ : Measure X) [IsProbabilityMeasure μ] (G : AddSubgroup X) {k : ℕ} {Q : X → Fin k}
    (hQ : Measurable Q) (hsec : ∀ x, ∀ g ∈ G, Q (x + g) = Q x → g = 0)
    (himg : ∀ (i : Fin k) (S : Set X), MeasurableSet S →
      MeasurableSet[borel (X ⧸ G)] (QuotientAddGroup.mk' G '' (Q ⁻¹' {i} ∩ S)))
    {T : X → X} (hT : Measurable T) {l : ℕ} {P : X → Fin l} (hP : Measurable P) :
    ∃ (K : ℕ) (R : X → Fin K), Measurable[MeasurableSpace.comap (QuotientAddGroup.mk' G) (borel (X ⧸ G))] R ∧
      ∀ n, blockEntropy μ T P n ≤ blockEntropy μ T R n + Real.log k := by
  sorry

/-- **C4, in the case the deduction reads** (FS105-DED, step B1), over the σ-algebra of the declared theorem's clause (4),
the Borel σ-algebra of `X ⧸ G` (`[EinsiedlerLindenstrauss2022]` p. 4, § 1.3): over the factor of a compact group by a
finite subgroup, entropy zero below is entropy zero above. `⇒`: for a measurable `P`, the pattern `R` of
`exists_pattern_names_le` is a partition of the factor, so its entropy is zero by the hypothesis through
`Rigidity.ksEntropy_map` (at `@ksEntropy_map … (borel (X ⧸ G))`, the projection and the induced map being continuous);
`Rigidity.exists_blockEntropy_le_mul` gives blocks `n ≥ log k / ε` with `H_n(R) ≤ εn`, so `h(T, P) ≤ 2ε`. `⇐`: a factor
has at most the entropy (`ksEntropy_map`, `ksEntropyOn_le_ksEntropy`). No `PolishSpace`. -/
theorem ksEntropy_eq_zero_iff_of_finite [CompactSpace X] [T1Space X] (G : AddSubgroup X) (hG : (G : Set X).Finite)
    (T : X →+ X) (hT : Continuous T) (hTG : G ≤ G.comap T) (μ : Measure X) [IsProbabilityMeasure μ]
    (hμ : MeasurePreserving T μ μ) :
    @ksEntropy (X ⧸ G) (borel (X ⧸ G)) (@Measure.map X (X ⧸ G) _ (borel (X ⧸ G)) (QuotientAddGroup.mk' G) μ)
        (QuotientAddGroup.map G G T hTG) = 0 ↔ ksEntropy μ T = 0 := by
  sorry

/-- **A model of the hypotheses of the finite-fibred step**, every clause at once with `G ≠ 0`: the discrete group `ℤ/4`
(compact, T1, Borel), its subgroup `{0, 2}` (finite, non-trivial), the identity (continuous, mapping `G` into `G`) and the
uniform probability, which it preserves. A model of `exists_sectionPartition` and `exists_pattern_names_le` too. -/
theorem finFour_fibre_model :
    ((AddSubgroup.zmultiples (2 : Fin 4) : Set (Fin 4))).Finite ∧ AddSubgroup.zmultiples (2 : Fin 4) ≠ ⊥ ∧
      AddSubgroup.zmultiples (2 : Fin 4) ≤ (AddSubgroup.zmultiples (2 : Fin 4)).comap (AddMonoidHom.id (Fin 4)) ∧
      IsProbabilityMeasure ((4 : ℝ≥0∞)⁻¹ • Measure.count : Measure (Fin 4)) ∧
      MeasurePreserving (AddMonoidHom.id (Fin 4)) ((4 : ℝ≥0∞)⁻¹ • Measure.count) ((4 : ℝ≥0∞)⁻¹ • Measure.count) := by
  sorry

end FiniteFibres

end HadwigerNelson.Rigidity
