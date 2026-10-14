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
  refine ⟨⟨⟨rfl⟩, fun χ ψ h => AddChar.ext _ _ fun g => Circle.ext (congrFun h g)⟩, ?_⟩
  have hrange : Set.range (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) =
      ({f | f 0 = 1} ∩ ⋂ g : G, ⋂ h : G, {f : G → ℂ | f (g + h) = f g * f h}) ∩
        ⋂ g : G, {f : G → ℂ | ‖f g‖ = 1} := by
    ext f
    simp only [Set.mem_range, Set.mem_inter_iff, Set.mem_iInter, Set.mem_setOf_eq]
    constructor
    · rintro ⟨χ, rfl⟩
      refine ⟨⟨?_, fun g h => ?_⟩, fun g => Circle.norm_coe _⟩
      · show ((χ 0 : Circle) : ℂ) = 1
        rw [AddChar.map_zero_eq_one, Circle.coe_one]
      · show ((χ (g + h) : Circle) : ℂ) = (χ g : ℂ) * (χ h : ℂ)
        rw [AddChar.map_add_eq_mul, Circle.coe_mul]
    · rintro ⟨⟨h0, hadd⟩, hn⟩
      let χ : AddChar G Circle :=
        { toFun := fun g => ⟨f g, mem_sphere_zero_iff_norm.2 (hn g)⟩
          map_zero_eq_one' := Circle.ext (by rw [Circle.coe_one]; exact h0)
          map_add_eq_mul' := fun a b => Circle.ext (by rw [Circle.coe_mul]; exact hadd a b) }
      exact ⟨χ, rfl⟩
  rw [hrange]
  have h1 : IsClosed {f : G → ℂ | f 0 = 1} := isClosed_eq (continuous_apply 0) continuous_const
  have h2 : ∀ g h : G, IsClosed {f : G → ℂ | f (g + h) = f g * f h} := fun g h =>
    isClosed_eq (continuous_apply (g + h)) ((continuous_apply g).mul (continuous_apply h))
  have h3 : ∀ g : G, IsClosed {f : G → ℂ | ‖f g‖ = 1} := fun g =>
    isClosed_eq (continuous_norm.comp (continuous_apply g)) continuous_const
  exact (h1.inter (isClosed_iInter fun g => isClosed_iInter fun h => h2 g h)).inter (isClosed_iInter h3)

/-- The characters form a topological group: products and inverses are computed pointwise. -/
scoped instance isTopologicalGroup_dual : IsTopologicalGroup (AddChar G Circle) where
  continuous_mul := by
    refine continuous_induced_rng.2 (continuous_pi fun g => ?_)
    show Continuous fun p : AddChar G Circle × AddChar G Circle => (((p.1 * p.2) g : Circle) : ℂ)
    simp only [AddChar.mul_apply, Circle.coe_mul]
    exact ((continuous_evalChar G g).comp continuous_fst).mul ((continuous_evalChar G g).comp continuous_snd)
  continuous_inv := by
    refine continuous_induced_rng.2 (continuous_pi fun g => ?_)
    show Continuous fun χ : AddChar G Circle => ((χ⁻¹ g : Circle) : ℂ)
    simp only [AddChar.inv_apply', Circle.coe_inv_eq_conj]
    exact Complex.continuous_conj.comp (continuous_evalChar G g)

scoped instance t2Space_dual : T2Space (AddChar G Circle) :=
  (isClosedEmbedding_coe G).isEmbedding.t2Space

/-- **Compact**: the range of the closed embedding lies in the compact product of unit circles. -/
scoped instance compactSpace_dual : CompactSpace (AddChar G Circle) := by
  have hK : IsCompact (Set.univ.pi fun _ : G => Metric.sphere (0 : ℂ) 1) :=
    isCompact_univ_pi fun _ => isCompact_sphere 0 1
  have hsub : Set.range (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) ⊆
      Set.univ.pi fun _ : G => Metric.sphere (0 : ℂ) 1 := by
    rintro _ ⟨χ, rfl⟩ g _
    exact mem_sphere_zero_iff_norm.2 (Circle.norm_coe _)
  have hc : IsCompact (Set.range fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) :=
    hK.of_isClosed_subset (isClosedEmbedding_coe G).isClosed_range hsub
  refine ⟨?_⟩
  rw [(isClosedEmbedding_coe G).isInducing.isCompact_iff, Set.image_univ]
  exact hc

scoped instance secondCountableTopology_dual [Countable G] : SecondCountableTopology (AddChar G Circle) :=
  (isClosedEmbedding_coe G).isInducing.secondCountableTopology

/-- **Polish** for countable `G`: a closed subspace of the Polish space `G → ℂ`. -/
scoped instance polishSpace_dual [Countable G] : PolishSpace (AddChar G Circle) :=
  (isClosedEmbedding_coe G).polishSpace

/-- **The Borel σ-algebra of the pointwise topology is the cylinder σ-algebra**, for countable `G`: both are pulled back
by the same map, and the Borel σ-algebra of the countable product `G → ℂ` is the product one (`borel_comap`,
`Pi.borelSpace`). -/
scoped instance borelSpace_dual [Countable G] : BorelSpace (AddChar G Circle) := by
  refine ⟨?_⟩
  show MeasurableSpace.comap (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) MeasurableSpace.pi =
    @borel _ (TopologicalSpace.induced (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) inferInstance)
  rw [borel_comap, ← BorelSpace.measurable_eq (α := G → ℂ)]

/-- **The cylinder σ-algebra on the characters of a countable group is standard Borel** (Polish and Borel). What the
release's `action_ergodic_decomposition` asks of `Dual F`. -/
instance standardBorelSpace_dual [Countable G] : StandardBorelSpace (AddChar G Circle) :=
  inferInstance

variable {G}

/-- `ℚ/ℤ` embeds in the circle, `q ↦ exp (2πiq)`, as an additive map into `Additive Circle` with trivial kernel. -/
private theorem exists_ratCircle : ∃ e : AddCircle (1 : ℚ) →+ Additive Circle, ∀ x, e x = 0 → x = 0 := by
  let f : ℚ →+ Additive Circle :=
    AddMonoidHom.mk' (fun q : ℚ => Additive.ofMul (Circle.exp (2 * Real.pi * (q : ℝ)))) fun a b => by
      rw [Rat.cast_add, mul_add, Circle.exp_add]
      rfl
  have hf : AddSubgroup.zmultiples (1 : ℚ) ≤ f.ker := by
    rintro _ ⟨n, rfl⟩
    rw [AddMonoidHom.mem_ker]
    show Additive.ofMul (Circle.exp (2 * Real.pi * (((n • (1 : ℚ)) : ℚ) : ℝ))) = 0
    rw [zsmul_one, Rat.cast_intCast, Circle.exp_two_pi_mul_int]
    rfl
  refine ⟨QuotientAddGroup.lift _ f hf, fun x hx => ?_⟩
  induction x using QuotientAddGroup.induction_on with
  | H q =>
    rw [QuotientAddGroup.lift_mk] at hx
    have h1 : Circle.exp (2 * Real.pi * (q : ℝ)) = 1 := hx
    obtain ⟨n, hn⟩ := Circle.exp_eq_one.mp h1
    have hq : (q : ℝ) = (n : ℝ) := by
      have hpi : (2 * Real.pi) ≠ 0 := by positivity
      apply mul_left_cancel₀ hpi
      linarith
    have hq' : q = (n : ℚ) := by exact_mod_cast hq
    rw [QuotientAddGroup.eq_zero_iff, hq']
    exact ⟨n, zsmul_one n⟩

/-- **The characters separate the points of `G`**: for `r ≠ 0` some character is not `1` at `r` — a character into
`ℚ/ℤ` that does not vanish at `r` (`CharacterModule.exists_character_apply_ne_zero_of_ne_zero`), carried into the circle. -/
theorem exists_apply_ne_one {r : G} (hr : r ≠ 0) : ∃ ψ : AddChar G Circle, ψ r ≠ 1 := by
  obtain ⟨c, hc⟩ := CharacterModule.exists_character_apply_ne_zero_of_ne_zero hr
  obtain ⟨e, he⟩ := exists_ratCircle
  refine ⟨AddChar.toAddMonoidHomEquiv.symm (e.comp c), fun h => hc (he _ ?_)⟩
  exact congrArg Additive.ofMul h

/-- Evaluation at `r`, as a bounded continuous function on the compact dual. -/
private def evalBCF (r : G) : BoundedContinuousFunction (AddChar G Circle) ℂ :=
  BoundedContinuousFunction.mkOfCompact ⟨fun χ => (χ r : ℂ), continuous_evalChar G r⟩

private theorem evalBCF_apply (r : G) (χ : AddChar G Circle) : evalBCF r χ = (χ r : ℂ) := rfl

private theorem evalBCF_add (r s : G) : evalBCF (r + s) = evalBCF r * evalBCF s := by
  ext χ
  rw [BoundedContinuousFunction.mul_apply, evalBCF_apply, evalBCF_apply, evalBCF_apply, AddChar.map_add_eq_mul,
    Circle.coe_mul]

private theorem evalBCF_zero : evalBCF (0 : G) = 1 := by
  ext χ
  rw [evalBCF_apply, AddChar.map_zero_eq_one, Circle.coe_one]
  rfl

private theorem star_evalBCF (r : G) : star (evalBCF r) = evalBCF (-r) := by
  ext χ
  rw [BoundedContinuousFunction.star_apply, evalBCF_apply, evalBCF_apply, AddChar.map_neg_eq_inv,
    Circle.coe_inv_eq_conj]
  rfl

variable (G) in
/-- The span of the evaluations: a star subalgebra of the bounded continuous functions on the dual. -/
private def fourierAlg : StarSubalgebra ℂ (BoundedContinuousFunction (AddChar G Circle) ℂ) where
  carrier := Submodule.span ℂ (Set.range (evalBCF (G := G)))
  mul_mem' {a b} ha hb := by
    induction ha using Submodule.span_induction with
    | mem x hx =>
      induction hb using Submodule.span_induction with
      | mem y hy =>
        obtain ⟨r, rfl⟩ := hx
        obtain ⟨s, rfl⟩ := hy
        rw [← evalBCF_add]
        exact Submodule.subset_span ⟨r + s, rfl⟩
      | zero => rw [mul_zero]; exact Submodule.zero_mem _
      | add y z _ _ hy hz => rw [mul_add]; exact Submodule.add_mem _ hy hz
      | smul c y _ hy => rw [mul_smul_comm]; exact Submodule.smul_mem _ c hy
    | zero => rw [zero_mul]; exact Submodule.zero_mem _
    | add x y _ _ hx hy => rw [add_mul]; exact Submodule.add_mem _ hx hy
    | smul c x _ hx => rw [smul_mul_assoc]; exact Submodule.smul_mem _ c hx
  one_mem' := by
    rw [← evalBCF_zero]
    exact Submodule.subset_span ⟨0, rfl⟩
  add_mem' := Submodule.add_mem _
  zero_mem' := Submodule.zero_mem _
  algebraMap_mem' c := by
    rw [Algebra.algebraMap_eq_smul_one, ← evalBCF_zero]
    exact Submodule.smul_mem _ c (Submodule.subset_span ⟨0, rfl⟩)
  star_mem' {a} ha := by
    induction ha using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨r, rfl⟩ := hx
      rw [star_evalBCF]
      exact Submodule.subset_span ⟨-r, rfl⟩
    | zero => rw [star_zero]; exact Submodule.zero_mem _
    | add x y _ _ hx hy => rw [star_add]; exact Submodule.add_mem _ hx hy
    | smul c x _ hx => rw [star_smul]; exact Submodule.smul_mem _ _ hx

/-- **Fourier uniqueness** on the dual of a countable group (FS100-X02D's T4): two finite measures with the same Fourier
coefficients are equal. No Herglotz–Bochner: the evaluations, as bounded continuous functions, span a star subalgebra
(`ev_r · ev_s = ev_{r+s}`, `star ev_r = ev_{-r}`, `ev_0 = 1`) that separates points, and
`ext_of_forall_mem_subalgebra_integral_eq_of_polish` concludes. -/
theorem measure_eq_of_fourier [Countable G] {σ σ' : Measure (AddChar G Circle)} [IsFiniteMeasure σ]
    [IsFiniteMeasure σ'] (h : ∀ r : G, ∫ χ, (χ r : ℂ) ∂σ = ∫ χ, (χ r : ℂ) ∂σ') : σ = σ' := by
  refine ext_of_forall_mem_subalgebra_integral_eq_of_polish (A := fourierAlg G) ?_ ?_
  · intro χ χ' hne
    have hr : ∃ r : G, χ r ≠ χ' r := by
      by_contra hall
      push Not at hall
      exact hne (AddChar.ext _ _ hall)
    obtain ⟨r, hr⟩ := hr
    refine ⟨fun ψ => (ψ r : ℂ), ⟨BoundedContinuousFunction.toContinuousMapStarₐ ℂ (evalBCF r),
      ⟨evalBCF r, Submodule.subset_span ⟨r, rfl⟩, rfl⟩, rfl⟩, ?_⟩
    exact fun h' => hr (Circle.ext h')
  · intro g hg
    have hg' : g ∈ Submodule.span ℂ (Set.range (evalBCF (G := G))) := hg
    clear hg
    induction hg' using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨r, rfl⟩ := hx
      exact h r
    | zero => simp
    | add x y _ _ hx hy =>
      rw [BoundedContinuousFunction.coe_add]
      simp only [Pi.add_apply]
      rw [integral_add (x.integrable σ) (y.integrable σ),
        integral_add (x.integrable σ') (y.integrable σ'), hx, hy]
    | smul a x _ hx =>
      rw [BoundedContinuousFunction.coe_smul]
      simp only [smul_eq_mul]
      rw [integral_const_mul, integral_const_mul, hx]

variable (G)

/-- **Haar measure on the dual of a countable group**: Mathlib's Haar measure normalised on the whole compact group. -/
def dualHaar [Countable G] : Measure (AddChar G Circle) :=
  Measure.haarMeasure ⊤

instance isProbabilityMeasure_dualHaar [Countable G] : IsProbabilityMeasure (dualHaar G) :=
  ⟨by simpa [dualHaar] using Measure.haarMeasure_self (G := AddChar G Circle) (K₀ := ⊤)⟩

instance isHaarMeasure_dualHaar [Countable G] : (dualHaar G).IsHaarMeasure := by
  unfold dualHaar
  infer_instance

/-- **Haar measure is Haar in the library's Fourier form**: at `r ≠ 0` take `ψ` with `ψ r ≠ 1`; left invariance gives
`∫ χ(r) = ψ(r) ∫ χ(r)`, so the coefficient is `0`. -/
theorem isHaarFourier_dualHaar [Countable G] : IsHaarFourier (dualHaar G) := by
  refine ⟨inferInstance, fun r hr => ?_⟩
  obtain ⟨ψ, hψ⟩ := exists_apply_ne_one hr
  have hinv := integral_mul_left_eq_self (μ := dualHaar G) (fun χ : AddChar G Circle => (χ r : ℂ)) ψ
  have hmul : ∀ χ : AddChar G Circle, ((ψ * χ) r : ℂ) = (ψ r : ℂ) * (χ r : ℂ) := fun χ => by
    rw [AddChar.mul_apply, Circle.coe_mul]
  simp only [hmul, integral_const_mul] at hinv
  have hne : (ψ r : ℂ) ≠ 1 := fun h => hψ (Circle.ext (by rw [h, Circle.coe_one]))
  have h0 : ((ψ r : ℂ) - 1) * ∫ χ, (χ r : ℂ) ∂(dualHaar G) = 0 := by rw [sub_mul, hinv, one_mul, sub_self]
  exact (mul_eq_zero.mp h0).resolve_left (sub_ne_zero.mpr hne)

variable {G}

/-- **The Fourier form of Haar measure is Haar measure**: `IsHaarFourier m` exactly when `m = dualHaar G` — Fourier
uniqueness, the coefficients being `1` at `0` and `0` elsewhere on both sides. -/
theorem isHaarFourier_iff [Countable G] {m : Measure (AddChar G Circle)} : IsHaarFourier m ↔ m = dualHaar G := by
  refine ⟨fun hm => ?_, fun h => h ▸ isHaarFourier_dualHaar G⟩
  haveI : IsProbabilityMeasure m := hm.1
  refine measure_eq_of_fourier fun r => ?_
  by_cases hr : r = 0
  · subst hr
    simp only [AddChar.map_zero_eq_one, Circle.coe_one, integral_const, probReal_univ, one_smul]
  · rw [hm.2 r hr, (isHaarFourier_dualHaar G).2 r hr]

/-- **Some measure is Haar in Fourier form**, for countable `G`, with no Herglotz–Bochner (`SpectralInputs.exists_isHaarFourier`
states it over `BochnerHerglotz G`). -/
theorem exists_isHaarFourier_of_countable [Countable G] : ∃ m : Measure (AddChar G Circle), IsHaarFourier m :=
  ⟨dualHaar G, isHaarFourier_dualHaar G⟩

/-- **The dual of an injective endomorphism carries Haar to Haar**, in Fourier form: `∫ χ(φ r) dm = 0` for `r ≠ 0`, since
`φ r ≠ 0`. Needs no countability. -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.map_dual
    {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) (φ : G →+ G)
    (hφ : Function.Injective φ) : IsHaarFourier (m.map fun χ => χ.compAddMonoidHom φ) := by
  haveI : IsProbabilityMeasure m := hm.1
  have hmeas : Measurable fun χ : AddChar G Circle => χ.compAddMonoidHom φ :=
    measurable_of_evalChar fun y => measurable_evalChar (φ y)
  refine ⟨Measure.isProbabilityMeasure_map hmeas.aemeasurable, fun r hr => ?_⟩
  rw [integral_map hmeas.aemeasurable (measurable_evalChar r).aestronglyMeasurable]
  exact hm.2 (φ r) ((map_ne_zero_iff φ hφ).mpr hr)

/-- **Translation carries Haar to Haar**, in Fourier form: `∫ (χ a)(r) dm = a(r) ∫ χ(r) dm`. Needs no countability. -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.map_mul_right
    {m : Measure (AddChar G Circle)} (hm : IsHaarFourier m) (a : AddChar G Circle) :
    IsHaarFourier (m.map fun χ => χ * a) := by
  haveI : IsProbabilityMeasure m := hm.1
  refine ⟨Measure.isProbabilityMeasure_map (measurable_mulRight a).aemeasurable, fun r hr => ?_⟩
  rw [integral_evalChar_map_mulRight, hm.2 r hr, zero_mul]

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
