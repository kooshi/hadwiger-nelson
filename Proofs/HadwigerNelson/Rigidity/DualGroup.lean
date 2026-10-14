import Proofs.HadwigerNelson.Arith.SpectralInputs
import Mathlib.MeasureTheory.Measure.FiniteMeasureExt
import Mathlib.MeasureTheory.Measure.Haar.Unique
import Mathlib.MeasureTheory.Constructions.Polish.Basic
import Mathlib.Algebra.Module.CharacterModule
import Mathlib.Analysis.SpecialFunctions.Complex.Circle
import Mathlib.Topology.Algebra.Group.Basic

/-!
# The dual of a discrete abelian group as a compact group: topology, Polish and Borel, Haar, Fourier uniqueness (FS-131, job FS131-KN8; module M4 of `plans/FS131-KN3-chain-plan.md`; skeleton)

**Read aloud, against the informal claim.** For a discrete abelian group `G`, its characters `Ĝ = AddChar G Circle` carry
the library's cylinder σ-algebra (`SpectralChain.dualMeasurableSpace`, the σ-algebra of the evaluations `χ ↦ χ(g)`) and a
group structure, and no topology. This module gives them **the topology of pointwise convergence**, induced by the same map
`χ ↦ (g ↦ (χ g : ℂ))` into `G → ℂ` — for discrete `G` the compact-open topology of Pontryagin duality — and proves what the
entropy split reads of it:

* `Ĝ` is a compact Hausdorff topological group (`isClosedEmbedding_coe`: the map is a closed embedding, its image inside the
  compact product of unit circles);
* for **countable** `G`: second countable, **Polish**, and its Borel σ-algebra **is** the cylinder σ-algebra
  (`borelSpace_dual`), so `Ĝ` is a standard Borel space (`standardBorelSpace_dual`) — the hypothesis the release's ergodic
  decomposition asks of the space it decomposes (`plans/FS131-KN7-chain-next.md` § Stage 4);
* **the characters separate the points of `G`** (`exists_apply_ne_one`, from Mathlib's character modules);
* **Fourier uniqueness** (`measure_eq_of_fourier`): two finite measures on `Ĝ` with the same Fourier coefficients are equal.
  **It reads no Herglotz–Bochner**: the evaluations span a point-separating star subalgebra of bounded continuous functions,
  and Mathlib's `ext_of_forall_mem_subalgebra_integral_eq_of_polish` concludes. `SpectralInputs.ext_of_fourier` states the
  same over `BochnerHerglotz G`; at countable `G` that hypothesis is idle for it;
* **Haar measure** `dualHaar G` (Mathlib's `haarMeasure ⊤`, a probability), which is exactly the library's Fourier form:
  `isHaarFourier_iff : IsHaarFourier m ↔ m = dualHaar G`; so an `IsHaarFourier` measure is invariant under every
  translation (`IsHaarFourier.map_mul_right`) and under the dual of every injective endomorphism of `G`
  (`IsHaarFourier.map_dual`) — the rotations of the chain among them — with no Herglotz–Bochner either.

**The topology is a scoped instance** (namespace `HadwigerNelson.Rigidity`): a topology on Mathlib's `AddChar` is speech
into every future instance search, and every consumer is in this namespace. The facts a consumer outside reads are
topology-free — Fourier uniqueness, the Fourier form of Haar, `StandardBorelSpace` of the cylinder σ-algebra (a global
instance: it is a property of the library's own global σ-algebra).

**Models.** Every statement is about every (countable) `G`; `G = ℤ` is the spec example (`dualHaar_fourier_zero`, and the
probability instance at `ℤ`). The trivial group is the unsampled member: its dual is one point and `dualHaar` is the point
mass, and `IsHaarFourier` there has no coefficient off `0` to check.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs Topology

noncomputable section

variable (G : Type*) [AddCommGroup G]

/-- **The topology of pointwise convergence on the characters of `G`**, induced by `χ ↦ (g ↦ (χ g : ℂ))` — the map the
library's cylinder σ-algebra is the comap of. For discrete `G` it is the compact-open topology. Scoped: see the module
docstring. -/
scoped instance dualTopologicalSpace : TopologicalSpace (AddChar G Circle) :=
  TopologicalSpace.induced (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) inferInstance

/-- Each evaluation `χ ↦ (χ g : ℂ)` is continuous. -/
theorem continuous_evalChar (g : G) : Continuous fun χ : AddChar G Circle => (χ g : ℂ) :=
  (continuous_apply g).comp
    (continuous_induced_dom : Continuous fun χ : AddChar G Circle => fun g : G => (χ g : ℂ))

/-- **The defining map is a closed embedding** into `G → ℂ`: injective (`AddChar.ext`), inducing by definition, and its range
— the maps `f` with `f 0 = 1`, `f (g + h) = f g * f h` and `‖f g‖ = 1` — is closed. -/
theorem isClosedEmbedding_coe : IsClosedEmbedding (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) := by
  sorry

/-- The characters form a topological group: products and inverses are computed pointwise. -/
scoped instance isTopologicalGroup_dual : IsTopologicalGroup (AddChar G Circle) := by
  sorry

scoped instance t2Space_dual : T2Space (AddChar G Circle) :=
  (isClosedEmbedding_coe G).isEmbedding.t2Space

/-- **Compact**: the range of the closed embedding lies in the compact product of unit circles. -/
scoped instance compactSpace_dual : CompactSpace (AddChar G Circle) := by
  sorry

scoped instance secondCountableTopology_dual [Countable G] : SecondCountableTopology (AddChar G Circle) :=
  (isClosedEmbedding_coe G).isInducing.secondCountableTopology

/-- **Polish** for countable `G`: a closed subspace of the Polish space `G → ℂ`. -/
scoped instance polishSpace_dual [Countable G] : PolishSpace (AddChar G Circle) := by
  sorry

/-- **The Borel σ-algebra of the pointwise topology is the cylinder σ-algebra**, for countable `G`: both are pulled back
by the same map, and the Borel σ-algebra of the countable product `G → ℂ` is the product one (`borel_comap`,
`Pi.borelSpace`). -/
scoped instance borelSpace_dual [Countable G] : BorelSpace (AddChar G Circle) := by
  sorry

/-- **The cylinder σ-algebra on the characters of a countable group is standard Borel** (Polish and Borel). What the
release's `action_ergodic_decomposition` asks of `Dual F`. -/
instance standardBorelSpace_dual [Countable G] : StandardBorelSpace (AddChar G Circle) := by
  sorry

variable {G}

/-- **The characters separate the points of `G`**: for `r ≠ 0` some character is not `1` at `r` — a character into
`ℚ/ℤ` that does not vanish at `r` (`CharacterModule.exists_character_apply_ne_zero_of_ne_zero`), carried into the circle. -/
theorem exists_apply_ne_one {r : G} (hr : r ≠ 0) : ∃ ψ : AddChar G Circle, ψ r ≠ 1 := by
  sorry

/-- **Fourier uniqueness** on the dual of a countable group (FS100-X02D's T4): two finite measures with the same Fourier
coefficients are equal. No Herglotz–Bochner: the evaluations, as bounded continuous functions, span a star subalgebra
(`ev_r · ev_s = ev_{r+s}`, `star ev_r = ev_{-r}`, `ev_0 = 1`) that separates points, and
`ext_of_forall_mem_subalgebra_integral_eq_of_polish` concludes. -/
theorem measure_eq_of_fourier [Countable G] {σ σ' : Measure (AddChar G Circle)} [IsFiniteMeasure σ]
    [IsFiniteMeasure σ'] (h : ∀ r : G, ∫ χ, (χ r : ℂ) ∂σ = ∫ χ, (χ r : ℂ) ∂σ') : σ = σ' := by
  sorry

variable (G)

/-- **Haar measure on the dual of a countable group**: Mathlib's Haar measure normalised on the whole compact group. -/
def dualHaar [Countable G] : Measure (AddChar G Circle) :=
  Measure.haarMeasure ⊤

instance isProbabilityMeasure_dualHaar [Countable G] : IsProbabilityMeasure (dualHaar G) := by
  sorry

instance isHaarMeasure_dualHaar [Countable G] : (dualHaar G).IsHaarMeasure := by
  unfold dualHaar
  infer_instance

/-- **Haar measure is Haar in the library's Fourier form**: at `r ≠ 0` take `ψ` with `ψ r ≠ 1`; left invariance gives
`∫ χ(r) = ψ(r) ∫ χ(r)`, so the coefficient is `0`. -/
theorem isHaarFourier_dualHaar [Countable G] : IsHaarFourier (dualHaar G) := by
  sorry

variable {G}

/-- **The Fourier form of Haar measure is Haar measure**: `IsHaarFourier m` exactly when `m = dualHaar G` — Fourier
uniqueness, the coefficients being `1` at `0` and `0` elsewhere on both sides. -/
theorem isHaarFourier_iff [Countable G] {m : Measure (AddChar G Circle)} : IsHaarFourier m ↔ m = dualHaar G := by
  sorry

/-- **Some measure is Haar in Fourier form**, for countable `G`, with no Herglotz–Bochner (`SpectralInputs.exists_isHaarFourier`
states it over `BochnerHerglotz G`). -/
theorem exists_isHaarFourier_of_countable [Countable G] : ∃ m : Measure (AddChar G Circle), IsHaarFourier m :=
  ⟨dualHaar G, isHaarFourier_dualHaar G⟩

/-- **The dual of an injective endomorphism carries Haar to Haar**, in Fourier form: `∫ χ(φ r) dm = 0` for `r ≠ 0`, since
`φ r ≠ 0`. Needs no countability. -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.map_dual
    {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) (φ : G →+ G)
    (hφ : Function.Injective φ) : IsHaarFourier (m.map fun χ => χ.compAddMonoidHom φ) := by
  sorry

/-- **Translation carries Haar to Haar**, in Fourier form: `∫ (χ a)(r) dm = a(r) ∫ χ(r) dm`. Needs no countability. -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.map_mul_right
    {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) (a : AddChar G Circle) :
    IsHaarFourier (m.map fun χ => χ * a) := by
  sorry

/-- **Haar measure is invariant under the dual of an injective endomorphism**, for countable `G`. -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.map_dual_eq [Countable G]
    {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) (φ : G →+ G)
    (hφ : Function.Injective φ) : m.map (fun χ => χ.compAddMonoidHom φ) = m :=
  (isHaarFourier_iff.mp (hm.map_dual φ hφ)).trans (isHaarFourier_iff.mp hm).symm

/-- **Haar measure is translation invariant**, for countable `G`, with no Herglotz–Bochner
(`SpectralInputs.IsHaarFourier.map_mulRight` states it over `BochnerHerglotz G`). -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.map_mul_right_eq [Countable G]
    {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m)
    (a : AddChar G Circle) : m.map (fun χ => χ * a) = m :=
  (isHaarFourier_iff.mp (hm.map_mul_right a)).trans (isHaarFourier_iff.mp hm).symm

/-- Spec: Haar measure's coefficient at `0` is its mass, `1` (it would fail if `dualHaar` drifted off a probability). -/
theorem dualHaar_fourier_zero [Countable G] : ∫ χ, (χ 0 : ℂ) ∂(dualHaar G) = 1 := by
  simp [AddChar.map_zero_eq_one]

example : IsProbabilityMeasure (dualHaar ℤ) := inferInstance

end

end HadwigerNelson.Rigidity
