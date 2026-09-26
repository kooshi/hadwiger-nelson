import Proofs.HadwigerNelson.Transcendental
import Proofs.HadwigerNelson.Instances.FinitePlane11
import Proofs.HadwigerNelson.Chain
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap
import Mathlib.MeasureTheory.Integral.IntegrableOn
import Mathlib.MeasureTheory.Constructions.Pi
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

/-!
# X11K skeleton: `χ(ℚ(√47)²) = 5`, conditional on named hypotheses

`plans/FS100-K-kernel-47.md` §D is the map this file follows, node by node. Part U (the upper half) is complete but for one
leaf; part L (the lower half) is SP-Cor's chain (`plans/FS84-SI-D-derivation.md` §4.2) over an **interface**: the set `E` of
characters, its part `TA` (`T + A`) and an entropy-like `h` are data, and the project's lemmas R-U, A⁺ at `S = ∅`, PE-2 and
EF_F⁺ are named `Prop`s about that data. The true `E`, `T + A` and Kolmogorov–Sinai entropy are meant to satisfy them; the
composition below is valid for every choice.

## Part U: `χ(ℚ(√47)²) ≤ 5` (Theorem A at the prime 11)

`47 ≡ 3 ≡ 5² (mod 11)` and `11 ≡ 3 (mod 4)`: the prime 11 splits in `ℚ(√47)` with residue field `𝔽₁₁`, where `−1` is not a
square. Reducing `a + b√47 ↦ a + 5b` on the coordinates that are integral at 11 is a ring map onto `ZMod 11`; every unit vector
of `ℚ(√47)²` has 11-integral coordinates (the descent, node U6); so the kernel's coset step
(`unitQuadrance_colorable_of_subring`) pulls the five-colouring of `Γ₁₁` (`chromaticNumber_finitePlane11`) back to the plane.

Skeleton: the composition is proved; the one leaf is `exists_residue11`, nodes U4–U6 of `plans/FS100-K-kernel-47.md` §D.
-/

namespace HadwigerNelson.X11K

open SimpleGraph RouteC

/-- `ℚ(√47)`, as a subfield of `ℝ`. -/
noncomputable abbrev F47 : Subfield ℝ := SquareClass.fieldOfRadicands {47}

/-- **Nodes U4–U6 (the leaf).** A subring `A` of `ℚ(√47)` holding both coordinates of every unit vector, with a ring map to
`ZMod 11` (`a + b√47 ↦ a + 5b` on the 11-integral coordinates). -/
theorem exists_residue11 :
    ∃ (A : Subring F47) (_ : A →+* ZMod 11),
      ∀ v : F47 × F47, v.1 ^ 2 + v.2 ^ 2 = 1 → v.1 ∈ A ∧ v.2 ∈ A := by
  sorry

/-- **Node U: `χ(ℚ(√47)²) ≤ 5`** — Theorem A at 11, through the finite plane `Γ₁₁`. -/
theorem chromaticNumber_planeOver_sqrt47_le_five :
    ((unitDistance ℂ).induce (planeOver F47)).chromaticNumber ≤ 5 := by
  obtain ⟨A, φ, hA⟩ := exists_residue11
  have h11 : (unitQuadrance (ZMod 11)).Colorable 5 := by
    have h := chromaticNumber_finitePlane11
    exact (chromaticNumber_le_iff_colorable).mp h.le
  rw [chromaticNumber_planeOver_eq]
  exact (unitQuadrance_colorable_of_subring A hA φ h11).chromaticNumber_le


/-! ## Part L: the lower half — SP-Cor's chain over an interface -/

open MeasureTheory

noncomputable section Chain

variable (F : Subfield ℝ)

/-- `U_F`: the unit vectors of `F²`, as points of `ℂ`. -/
def unitVectors : Set ℂ := {u | u ∈ planeOver F ∧ ‖u‖ = 1}

/-- `R = ℤ[U]`, the subring of `ℂ` the unit vectors generate. -/
def unitRing : Subring ℂ := Subring.closure (unitVectors F)

theorem unitVectors_subset_unitRing : unitVectors F ⊆ unitRing F := Subring.subset_closure

/-- The unit vector `u`, as an element of `R`. -/
def uvRing {F : Subfield ℝ} (u : unitVectors F) : unitRing F := ⟨u, unitVectors_subset_unitRing F u.2⟩

/-- `X₄(F)`: the proper four-colourings of `Cay(R, U)`. -/
def X4 : Set (unitRing F → Fin 4) := {c | ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → c x ≠ c y}

/-- The cylinder σ-algebra on the characters of an abelian group (the Borel one when the group is countable). -/
instance dualMeasurableSpace (G : Type*) [AddCommGroup G] : MeasurableSpace (AddChar G Circle) :=
  MeasurableSpace.comap (fun χ : AddChar G Circle => fun g : G => (χ g : ℂ)) MeasurableSpace.pi

/-- `R̂`, the characters of `R`. -/
abbrev Dual := AddChar (unitRing F) Circle

/-- The rotation `(u·χ)(r) = χ(ur)`. -/
def rot {F : Subfield ℝ} (u : unitVectors F) (χ : Dual F) : Dual F :=
  χ.compAddMonoidHom (AddMonoidHom.mulLeft (uvRing u))

/-- A measure on `R̂` invariant under every rotation. -/
def RotInv (τ : Measure (Dual F)) : Prop := ∀ u : unitVectors F, τ.map (rot u) = τ

/-- **A translation- and rotation-invariant random proper four-colouring** of `Cay(R, U)` — SP-Cor's `μ`. -/
structure InvariantColouring where
  μ : Measure (unitRing F → Fin 4)
  isProb : IsProbabilityMeasure μ
  carried : μ (X4 F)ᶜ = 0
  shift_inv : ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ
  rot_inv : ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

/-- `⟨e_i, e_j⟩` for the vertices of a regular tetrahedron: `1` on the diagonal, `−1/3` off it. -/
def tetra (i j : Fin 4) : ℝ := if i = j then 1 else -1 / 3

/-- `C(y) = E_μ⟨g(0), g(y)⟩`. -/
noncomputable def corr (μ : Measure (unitRing F → Fin 4)) (y : unitRing F) : ℝ := ∫ c, tetra (c 0) (c y) ∂μ

/-- **The trace spectral measure** (`plans/FS84-SI-D-derivation.md` §1.2): a finite measure `σ` on `R̂` with
`∫ χ(y) dσ = C(y)` for every `y`. -/
def IsTraceSpectral (μ : Measure (unitRing F → Fin 4)) (σ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂σ = (corr F μ y : ℂ)

/-- Positive-definite functions on an abelian group. -/
def PosDef {G : Type*} [AddCommGroup G] (C : G → ℂ) : Prop :=
  ∀ (s : Finset G) (z : G → ℂ),
    (∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * C (x - y)).im = 0 ∧
      0 ≤ (∑ x ∈ s, ∑ y ∈ s, z x * star (z y) * C (x - y)).re

/-- **X-BH, external: Herglotz–Bochner on a discrete abelian group, with uniqueness.** "Bochner's theorem … as generalised by
Weil: any positive definite function on a locally compact abelian group `G` is the Fourier–Stieltjes transform of a positive
measure on the dual group" (Rudin, *Fourier Analysis on Groups* 1.4.3; not quoted from a held copy); uniqueness is the injectivity
of the Fourier–Stieltjes transform (Rudin 1.3.6). Mathlib lacks both for groups (it has `Measure.ext_of_charFun` on
inner-product spaces). -/
def BochnerHerglotz (G : Type*) [AddCommGroup G] : Prop :=
  ∀ C : G → ℂ, PosDef C → ∃ σ : Measure (AddChar G Circle), IsFiniteMeasure σ ∧ (∀ y, ∫ χ, (χ y : ℂ) ∂σ = C y) ∧
    ∀ σ' : Measure (AddChar G Circle), IsFiniteMeasure σ' → (∀ y, ∫ χ, (χ y : ℂ) ∂σ' = C y) → σ' = σ

/-- **The interface.** `E` (meant: `⋃_S (T + A + Fin_S)`), `TA` (meant: `T + A`, which is `E_∅`) and `h` (meant:
Kolmogorov–Sinai entropy, `h τ u = h_τ(u)`) are data; the properties below are the definitional ones the chain uses. -/
structure Interface where
  E : Set (Dual F)
  TA : Set (Dual F)
  measurableSet_E : MeasurableSet E
  measurableSet_TA : MeasurableSet TA
  TA_subset_E : TA ⊆ E
  rot_preimage_E : ∀ u : unitVectors F, rot u ⁻¹' E = E
  h : Measure (Dual F) → unitVectors F → ENNReal

/-- The interface's model: everything empty or zero (the structure is inhabited; its content is in the `Prop`s below). -/
def Interface.trivial : Interface F where
  E := ∅
  TA := ∅
  measurableSet_E := MeasurableSet.empty
  measurableSet_TA := MeasurableSet.empty
  TA_subset_E := subset_refl _
  rot_preimage_E _ := Set.preimage_empty
  h _ _ := 0

variable {F}

/-- **R-U** (`plans/FS84-SI-D-derivation.md` §5.4, J45; blind J46): "every finite `U`-invariant measure on `R̂` gives
`E_S ∖ (T + A)` measure 0, for every finite `S`"; here in its union form, `τ(E ∖ (T + A)) = 0` (§4.1, "`E` is a countable union"). -/
def Interface.RU (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ (I.E \ I.TA) = 0

/-- **A⁺ at `S = ∅`, remark (ii)** (§3, J45; blind X05V): for every rotation-invariant random proper four-colouring,
"`u ↦ ∫_{R̂∖E_S} χ(u) dσ_μ` is constant on `U`: strict at every `u`, in particular at `u = 1`". Rests on SI-3, SI-4, N2 and
R88-TCA at `S = ∅` (row 113). VACUITY NOTE: this `Prop` quantifies over `InvariantColouring`, which is empty exactly when the
headline's conclusion holds; its content is its derivation from R88-TCA, which never assumes that emptiness. -/
def Interface.APlus0 (I : Interface F) : Prop :=
  ∀ (μ : InvariantColouring F) (σ : Measure (Dual F)), IsTraceSpectral F μ.μ σ →
    ∫ χ in I.TAᶜ, (χ 1 : ℂ).re ∂σ < 0

/-- **PE-2**, in the consequence form the chain uses (queue §2 list X02; X02D, X02V blind; over EL2021 Thm 1.2): "every
`U`-invariant finite positive measure `τ` on `R̂`: `τ = a·m + τ′` with `a ≥ 0`, `τ′` a `U`-invariant finite positive measure,
and `h_{τ′}(u) = 0` for every `u ∈ U`." The Haar part `a·m` is recorded by the two properties used: it is `E`-null (N1) and its
Fourier coefficients vanish off `0`. -/
def Interface.PE2 (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ →
    ∃ τH τ' : Measure (Dual F), τ = τH + τ' ∧ RotInv F τ' ∧ τH I.E = 0 ∧
      (∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂τH = 0) ∧ ∀ u, I.h τ' u = 0

/-- **EF_F⁺**, weakened to the form the chain uses (zero entropy at every `u`, where EF_F⁺ needs one non-torsion `u*`):
"every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for **one** non-torsion `u* ∈ U`
satisfies `μ(R̂ ∖ (T + A)) = 0`" (`plans/FS100-X01D-derivation.md` line 194; second derivation X12B). -/
def Interface.EFPlus (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → (∀ u, I.h τ u = 0) → τ I.TAᶜ = 0

/-- **MR**, Fourier form: every rotation-invariant `E`-null finite measure has vanishing Fourier coefficients off `0` (for
`a·m` they vanish; the converse is Fourier uniqueness on `R̂`). -/
def Interface.MR (I : Interface F) : Prop :=
  ∀ τ : Measure (Dual F), IsFiniteMeasure τ → RotInv F τ → τ I.E = 0 → ∀ r : unitRing F, r ≠ 0 → ∫ χ, (χ r : ℂ) ∂τ = 0

/-- **Node M** (`plans/FS100-X01D-derivation.md` §4.1): PE-2 and EF_F⁺ give MR. -/
theorem Interface.mr_of_pe2_efPlus (I : Interface F) (hPE : I.PE2) (hEF : I.EFPlus) : I.MR := by
  intro τ hfin hrot hE r hr
  obtain ⟨τH, τ', rfl, hrot', hHE, hHF, hh⟩ := hPE τ hfin hrot
  have hfin' : IsFiniteMeasure τ' := isFiniteMeasure_of_le (τH + τ') (Measure.le_add_left le_rfl)
  have hTAc : τ' I.TAᶜ = 0 := hEF τ' hfin' hrot' hh
  have hE' : τ' I.E = 0 := by
    rw [Measure.add_apply] at hE
    exact (add_eq_zero.mp hE).2
  have hTA : τ' I.TA = 0 := measure_mono_null I.TA_subset_E hE'
  have hzero : τ' = 0 := by
    rw [← Measure.measure_univ_eq_zero, ← Set.union_compl_self I.TA]
    exact measure_union_null hTA hTAc
  rw [hzero, add_zero]
  exact hHF r hr

/-- **Node L0**: a proper four-colouring of the plane restricts to `X₄(F)`. -/
theorem x4_nonempty_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 4) : (X4 F).Nonempty := by
  obtain ⟨C⟩ := h
  have hsub : ∀ x : unitRing F, (x : ℂ) ∈ planeOver F := fun x =>
    (Subring.closure_le (t := Chain.planeOverSubring F)).mpr (fun _ hu => hu.1) x.2
  refine ⟨fun x => C ⟨x, hsub x⟩, fun x y hxy => C.valid ?_⟩
  show dist (x : ℂ) (y : ℂ) = 1
  rw [dist_comm, Complex.dist_eq]
  exact hxy.2

/-- **Node L1** (formalizable; Markov–Kakutani twice): `X₄(F) ≠ ∅` gives an invariant random colouring. -/
theorem exists_invariantColouring (h : (X4 F).Nonempty) : Nonempty (InvariantColouring F) := by
  sorry

/-- **Node L2's input**: the correlation of an invariant random colouring is positive definite. -/
theorem posDef_corr (μ : InvariantColouring F) : PosDef (fun y => (corr F μ.μ y : ℂ)) := by
  sorry

/-- Evaluation at `y` is measurable on `R̂`. -/
theorem measurable_eval (y : unitRing F) : Measurable (fun χ : Dual F => (χ y : ℂ)) :=
  (measurable_pi_apply y).comp (comap_measurable (fun χ : Dual F => fun g : unitRing F => (χ g : ℂ)))

/-- Rotation is measurable on `R̂`. -/
theorem measurable_rot (u : unitVectors F) : Measurable (rot u) := by
  intro s ⟨t, ht, hts⟩
  have hΦ : Measurable (fun f : unitRing F → ℂ => fun r : unitRing F => f (uvRing u * r)) :=
    measurable_pi_lambda _ fun r => measurable_pi_apply _
  refine ⟨_, hΦ ht, ?_⟩
  rw [← hts]
  rfl

/-- **Node L3**: the trace spectral measure is rotation-invariant (`C(uy) = C(y)`, and uniqueness). -/
theorem rotInv_of_isTraceSpectral (hBH : BochnerHerglotz (unitRing F)) (μ : InvariantColouring F) {σ : Measure (Dual F)}
    (hσ : IsTraceSpectral F μ.μ σ) : RotInv F σ := by
  intro u
  obtain ⟨σ₀, -, -, huniq⟩ := hBH _ (posDef_corr μ)
  have hρ : Measurable (fun (c : unitRing F → Fin 4) (x : unitRing F) => c (uvRing u * x)) :=
    measurable_pi_lambda _ fun x => measurable_pi_apply _
  have hcorr : ∀ y, corr F μ.μ (uvRing u * y) = corr F μ.μ y := by
    intro y
    have hm : Measurable (fun c : unitRing F → Fin 4 => tetra (c 0) (c y)) :=
      (measurable_of_countable (fun p : Fin 4 × Fin 4 => tetra p.1 p.2)).comp
        (f := fun c : unitRing F → Fin 4 => (c 0, c y)) ((measurable_pi_apply 0).prodMk (measurable_pi_apply y))
    calc corr F μ.μ (uvRing u * y)
        = ∫ c, (fun c' : unitRing F → Fin 4 => tetra (c' 0) (c' y)) (fun x => c (uvRing u * x)) ∂μ.μ := by
          unfold corr; congr 1; funext c; simp only [mul_zero]
      _ = ∫ c', tetra (c' 0) (c' y) ∂(μ.μ.map (fun c x => c (uvRing u * x))) :=
          (integral_map hρ.aemeasurable hm.aestronglyMeasurable).symm
      _ = corr F μ.μ y := by rw [μ.rot_inv u]; rfl
  have hmap : ∀ y, ∫ χ, (χ y : ℂ) ∂(σ.map (rot u)) = (corr F μ.μ y : ℂ) := by
    intro y
    rw [integral_map (measurable_rot u).aemeasurable (measurable_eval y).aestronglyMeasurable]
    show ∫ χ, (χ (uvRing u * y) : ℂ) ∂σ = _
    rw [hσ.2, hcorr]
  haveI := hσ.1
  rw [huniq _ inferInstance hmap, huniq σ hσ.1 hσ.2]

/-- **Node L6, SP-Cor** (`plans/FS84-SI-D-derivation.md` §4.2): given Herglotz–Bochner, R-U, A⁺ at `S = ∅` and MR, the
plane over `F` has no proper four-colouring of `Cay(R, U)`. -/
theorem Interface.x4_eq_empty (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hRU : I.RU) (hA : I.APlus0)
    (hMR : I.MR) : X4 F = ∅ := by
  by_contra hne
  obtain ⟨μ⟩ := exists_invariantColouring (Set.nonempty_iff_ne_empty.mpr hne)
  obtain ⟨σ, hσfin, hσ, -⟩ := hBH _ (posDef_corr μ)
  have hTS : IsTraceSpectral F μ.μ σ := ⟨hσfin, hσ⟩
  have hrot := rotInv_of_isTraceSpectral hBH μ hTS
  -- the evaluation `χ ↦ χ 1` is measurable, and bounded by `1`
  have hev := measurable_eval (F := F) 1
  have hint : ∀ ν : Measure (Dual F), IsFiniteMeasure ν → Integrable (fun χ : Dual F => (χ 1 : ℂ)) ν := by
    intro ν _
    refine Integrable.of_bound hev.aestronglyMeasurable 1 (Filter.Eventually.of_forall fun χ => ?_)
    simp
  -- `τ := σ|_{Eᶜ}`: rotation-invariant, finite, `E`-null
  have hmrot := measurable_rot (F := F)
  have hτrot : RotInv F (σ.restrict I.Eᶜ) := by
    intro u
    have hpre : rot u ⁻¹' I.Eᶜ = I.Eᶜ := by rw [Set.preimage_compl, I.rot_preimage_E u]
    conv_lhs => rw [← hpre]
    rw [← Measure.restrict_map (hmrot u) I.measurableSet_E.compl, hrot u]
  have hτE : (σ.restrict I.Eᶜ) I.E = 0 := by
    rw [Measure.restrict_apply I.measurableSet_E, Set.inter_compl_self, measure_empty]
  have hMRτ := hMR _ inferInstance hτrot hτE 1 one_ne_zero
  -- A⁺ and R-U: `∫_{TAᶜ} = ∫_{Eᶜ} + ∫_{E∖TA}`, the second over a null set
  have hAμ := hA μ σ hTS
  have hnull : σ (I.E \ I.TA) = 0 := hRU σ hσfin hrot
  have hsplit : I.TAᶜ = I.Eᶜ ∪ (I.E \ I.TA) := by
    ext χ
    simp only [Set.mem_compl_iff, Set.mem_union, Set.mem_sdiff]
    constructor
    · intro h
      by_cases h1 : χ ∈ I.E
      · exact Or.inr ⟨h1, h⟩
      · exact Or.inl h1
    · rintro (h | ⟨-, h⟩)
      · exact fun h' => h (I.TA_subset_E h')
      · exact h
  have hre : ∫ χ in I.Eᶜ, (χ 1 : ℂ).re ∂σ = 0 := by
    have h := integral_re (𝕜 := ℂ) (hint (σ.restrict I.Eᶜ) inferInstance)
    simp only [RCLike.re_to_complex] at h
    rw [h, hMRτ, Complex.zero_re]
  have hint' : Integrable (fun χ : Dual F => (χ 1 : ℂ).re) σ := by
    simpa only [RCLike.re_to_complex] using (hint σ hσfin).re
  rw [hsplit, setIntegral_union (disjoint_compl_left.mono_right Set.sdiff_subset)
    (I.measurableSet_E.diff I.measurableSet_TA) hint'.integrableOn hint'.integrableOn,
    hre, setIntegral_measure_zero _ hnull, add_zero] at hAμ
  exact lt_irrefl 0 hAμ

/-- **The lower half**: `χ(F²) ≥ 5` from the chain. -/
theorem Interface.five_le_chromaticNumber (I : Interface F) (hBH : BochnerHerglotz (unitRing F)) (hRU : I.RU)
    (hA : I.APlus0) (hPE : I.PE2) (hEF : I.EFPlus) :
    5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have h := (add_one_le_chromaticNumber_iff_not_colorable
    (G := (unitDistance ℂ).induce (planeOver F)) (n := 4)).mpr fun hc => by
    have hne := x4_nonempty_of_colorable hc
    rw [I.x4_eq_empty hBH hRU hA (I.mr_of_pe2_efPlus hPE hEF)] at hne
    exact Set.not_nonempty_empty hne
  exact_mod_cast h

end Chain

/-! ## The headline -/

/-- **`χ(ℚ(√47)²) = 5`, conditional on the named hypotheses**: Herglotz–Bochner on `ℤ[U]` (X-BH), and an interface
`(E, T + A, h)` satisfying R-U, A⁺ at `S = ∅` (over R88-TCA, row 113), PE-2 (over EL2021 Thm 1.2) and EF_F⁺. The upper half
is Theorem A at 11 (part U). -/
theorem chromaticNumber_planeOver_sqrt47_eq_five (hBH : BochnerHerglotz (unitRing F47)) (I : Interface F47)
    (hRU : I.RU) (hA : I.APlus0) (hPE : I.PE2) (hEF : I.EFPlus) :
    ((unitDistance ℂ).induce (planeOver F47)).chromaticNumber = 5 :=
  le_antisymm chromaticNumber_planeOver_sqrt47_le_five (I.five_le_chromaticNumber hBH hRU hA hPE hEF)

/-! ## Spec -/

example : tetra 0 0 = 1 := by simp [tetra]
example : tetra 0 1 = -1 / 3 := by simp [tetra]
example : (Interface.trivial F47).E = ∅ := rfl

end HadwigerNelson.X11K
