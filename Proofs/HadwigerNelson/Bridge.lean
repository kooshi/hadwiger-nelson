import Proofs.HadwigerNelson.Transcendental
import Proofs.HadwigerNelson.Instances.Seven
import Mathlib.Combinatorics.SimpleGraph.Finsubgraph
import Mathlib.FieldTheory.IntermediateField.Adjoin.Basic
import Mathlib.RingTheory.AlgebraicIndependent.Transcendental
import Mathlib.Algebra.MvPolynomial.Rename
import Mathlib.NumberTheory.Real.Irrational

/-!
# The bridge: `χ(ℝ²)` is the largest `χ(F²)` over real number fields, given real algebraic descent (FS-39, J17K)

**Read aloud, against the informal claim.** Colour the plane so that points at distance exactly one get different
colours; call the least number of colours `χ(ℝ²)`. Do the same for the points whose two coordinates lie in a number
field `F ⊂ ℝ`, and call it `χ(F²)`. Then `χ(ℝ²)` is the largest of the numbers `χ(F²)` — the supremum over all real
number fields, and it is attained by one of them (`chromaticNumber_plane_eq_iSup_numberField_of_descent`,
`exists_numberField_chromaticNumber_eq_plane_of_descent`). Its corollary: `χ(ℝ²) ≠ 6` exactly when every real number
field whose plane needs six colours has a finite real extension whose plane needs seven
(`chromaticNumber_plane_ne_six_iff_of_descent`, FS62-T2).

**One hypothesis, named: `RealAlgebraicDescent`** — a finite system of polynomial equations with rational coefficients
that has a real solution has a real *algebraic* solution. It is true (Tarski 1951: the theory of real closed fields
admits quantifier elimination, so the real algebraic numbers, a real closed field, are an elementary substructure of
`ℝ`; equivalently the Artin–Lang homomorphism theorem, Lang 1953; `plans/M2-S1D-bridge.md` §2.1). It has no kernel
proof here because Mathlib has no quantifier elimination for real closed fields (§3.1 there); its price in the kernel is
months (§3.2). Everything else in this file is proved: the encoding of a unit-distance drawing as a finite system of
rational polynomials (`exists_numberField_drawing_of_descent`, C1 of `plans/M2-kernel-lane.md` §4.2), de Bruijn–Erdős
(Mathlib's `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`), the upper bound `χ(ℝ²) ≤ 7` that makes the
supremum a maximum (`Instances/Seven.lean`), and the compositum of two real number fields.

**Why the hypothesis is not vacuous, and not trivially true.** It is not a structure with an empty domain — it is a
proposition that is true and unproved here, so the gate's `VACUITY DECLARED:` marker (which asserts a provably empty
domain) is withheld on purpose, as for `five_le_chromaticNumber_planeOver_seven_of_G4`. Two controls stand beside it:
its one-variable case is proved (`realAlgebraicDescent_one`), and its twin one notch stronger — rational in place of
algebraic — is refuted in the kernel (`not_rationalDescent`, by `X² − 2`).
-/

namespace HadwigerNelson
namespace Bridge

open SimpleGraph MvPolynomial

/-! ## The hypothesis and its two controls -/

/-- **Real algebraic descent** (`plans/M2-S1D-bridge.md` §2.1's (∃T) for `ℚ`): every finite system of polynomial
equations with rational coefficients that has a solution in `ℝ` has one whose coordinates are algebraic over `ℚ`.

**True, and not proved here: an external theorem, taken as a hypothesis** (Tarski 1951, quantifier elimination for real
closed fields, with `ℚ`'s real algebraic closure real closed — `RealClosed.lean`; equivalently Artin–Lang, `[Lang1953]`,
not read: cited through `[GoelPatilVerma2022]` Thm 3.11). Mathlib has no quantifier elimination for
real closed fields, so every theorem in this file that assumes it carries the suffix `_of_descent`. Not a vacuous
hypothesis: it is a proposition, not an empty domain (`realAlgebraicDescent_one` proves its one-variable case). -/
def RealAlgebraicDescent : Prop :=
  ∀ (n : ℕ) (S : Finset (MvPolynomial (Fin n) ℚ)), (∃ x : Fin n → ℝ, ∀ p ∈ S, MvPolynomial.aeval x p = 0) →
    ∃ x : Fin n → ℝ, (∀ i, IsAlgebraic ℚ (x i)) ∧ ∀ p ∈ S, MvPolynomial.aeval x p = 0

/-- **The partial inhabitant**: `RealAlgebraicDescent` in one variable. If some polynomial of the system is nonzero,
the given real solution is a root of it and so already algebraic; if all are zero, `0` solves the system. -/
theorem realAlgebraicDescent_one (S : Finset (MvPolynomial (Fin 1) ℚ))
    (h : ∃ x : Fin 1 → ℝ, ∀ p ∈ S, MvPolynomial.aeval x p = 0) :
    ∃ x : Fin 1 → ℝ, (∀ i, IsAlgebraic ℚ (x i)) ∧ ∀ p ∈ S, MvPolynomial.aeval x p = 0 := by
  obtain ⟨x, hx⟩ := h
  by_cases hne : ∃ p ∈ S, p ≠ 0
  · obtain ⟨p, hp, hp0⟩ := hne
    refine ⟨x, fun i => ?_, hx⟩
    have hdep : ¬ AlgebraicIndependent ℚ x := fun hind =>
      hp0 ((algebraicIndependent_iff.mp hind) p (hx p hp))
    rw [algebraicIndependent_unique_type_iff] at hdep
    rw [Subsingleton.elim i default]
    exact not_not.mp hdep
  · push Not at hne
    refine ⟨fun _ => 0, fun _ => isAlgebraic_zero, fun p hp => ?_⟩
    rw [hne p hp, map_zero]

/-- **The planted false twin**: `RealAlgebraicDescent` with *rational* in place of *algebraic*. -/
def RationalDescent : Prop :=
  ∀ (n : ℕ) (S : Finset (MvPolynomial (Fin n) ℚ)), (∃ x : Fin n → ℝ, ∀ p ∈ S, MvPolynomial.aeval x p = 0) →
    ∃ x : Fin n → ℝ, (∀ i, x i ∈ Set.range ((↑) : ℚ → ℝ)) ∧ ∀ p ∈ S, MvPolynomial.aeval x p = 0

/-- **The twin is false** — `X₀² − 2` has the real root `√2` and no rational one. So a hypothesis of this shape one notch
too strong does not survive the kernel, and `RealAlgebraicDescent`'s survival is not a matter of its shape. -/
theorem not_rationalDescent : ¬ RationalDescent := by
  intro h
  obtain ⟨x, hx, hS⟩ := h 1 {X 0 ^ 2 - 2} ⟨fun _ => Real.sqrt 2, by
    intro p hp
    rw [Finset.mem_singleton] at hp
    subst hp
    simp⟩
  obtain ⟨q, hq⟩ := hx 0
  have h2 : (q : ℝ) ^ 2 = 2 := by
    have := hS _ (Finset.mem_singleton_self _)
    simp only [map_sub, map_pow, aeval_X, map_ofNat] at this
    rw [hq]; linarith
  exact irrational_sqrt_two ⟨|q|, by
    rw [Rat.cast_abs, ← Real.sqrt_sq_eq_abs, h2]⟩

/-- `RealAlgebraicDescent` for any finite set of variables, by renaming along `σ ≃ Fin n`. -/
theorem RealAlgebraicDescent.of_finite (hD : RealAlgebraicDescent) {σ : Type*} [Finite σ]
    (S : Finset (MvPolynomial σ ℚ)) (h : ∃ x : σ → ℝ, ∀ p ∈ S, MvPolynomial.aeval x p = 0) :
    ∃ x : σ → ℝ, (∀ i, IsAlgebraic ℚ (x i)) ∧ ∀ p ∈ S, MvPolynomial.aeval x p = 0 := by
  classical
  obtain ⟨n, ⟨e⟩⟩ := Finite.exists_equiv_fin σ
  obtain ⟨y, hy, hyS⟩ := hD n (S.image (rename e)) (by
    obtain ⟨x, hx⟩ := h
    refine ⟨x ∘ e.symm, ?_⟩
    simp only [Finset.mem_image]
    rintro _ ⟨p, hp, rfl⟩
    rw [aeval_rename]
    simpa [Function.comp_def] using hx p hp)
  refine ⟨y ∘ e, fun i => hy (e i), fun p hp => ?_⟩
  rw [← aeval_rename]
  exact hyS _ (Finset.mem_image_of_mem _ hp)

/-! ## Finitely many real algebraic numbers generate a number field -/

/-- The subfield of `ℝ` generated by a set `S`, over `ℚ`. -/
noncomputable def adjoinReal (S : Set ℝ) : Subfield ℝ :=
  (IntermediateField.adjoin ℚ S).toSubfield

theorem subset_adjoinReal (S : Set ℝ) : S ⊆ adjoinReal S :=
  IntermediateField.subset_adjoin ℚ S

/-- **Finitely many real algebraic numbers generate a number field.** -/
theorem numberField_adjoinReal {S : Set ℝ} (hS : S.Finite) (halg : ∀ x ∈ S, IsAlgebraic ℚ x) :
    NumberField (adjoinReal S) := by
  haveI : Finite S := hS.to_subtype
  haveI : FiniteDimensional ℚ (IntermediateField.adjoin ℚ S) :=
    IntermediateField.finiteDimensional_adjoin fun x hx => (halg x hx).isIntegral
  show NumberField (IntermediateField.adjoin ℚ S).toSubfield
  exact ⟨⟩

/-! ## C1 — a unit-distance drawing descends to a real number field -/

/-- The edge polynomial of `u ~ v`, in the variables `inl w` (the real part of `w`) and `inr w` (its imaginary
part): `(X_{inl u} − X_{inl v})² + (X_{inr u} − X_{inr v})² − 1`. -/
noncomputable def edgePoly {ι : Type*} (u v : ι) : MvPolynomial (ι ⊕ ι) ℚ :=
  (X (Sum.inl u) - X (Sum.inl v)) ^ 2 + (X (Sum.inr u) - X (Sum.inr v)) ^ 2 - 1

theorem aeval_edgePoly {ι : Type*} (x : ι ⊕ ι → ℝ) (u v : ι) :
    MvPolynomial.aeval x (edgePoly u v) =
      (x (Sum.inl u) - x (Sum.inl v)) ^ 2 + (x (Sum.inr u) - x (Sum.inr v)) ^ 2 - 1 := by
  simp [edgePoly]

/-- The point of `ℂ` with coordinates `x (inl i)`, `x (inr i)`. -/
def ofCoords {ι : Type*} (x : ι ⊕ ι → ℝ) (i : ι) : ℂ := ⟨x (Sum.inl i), x (Sum.inr i)⟩

/-- A drawing is a unit drawing exactly when its coordinates solve every edge polynomial. -/
theorem dist_ofCoords_eq_one_iff {ι : Type*} (x : ι ⊕ ι → ℝ) (u v : ι) :
    dist (ofCoords x u) (ofCoords x v) = 1 ↔ MvPolynomial.aeval x (edgePoly u v) = 0 := by
  rw [RouteC.dist_eq_one_iff_quadrance, aeval_edgePoly, sub_eq_zero]
  rfl

/-- **C1** (`plans/M2-kernel-lane.md` §4.2): "For every finite graph `H` and every map `f : V(H) → ℝ²` with
`‖f(x) − f(y)‖ = 1` on every edge, there is a real number field `F` and a map `g : V(H) → F²` with `‖g(x) − g(y)‖ = 1`
on every edge." Non-injective `g` is allowed.

**Conditional, and not vacuous**: it assumes `RealAlgebraicDescent`, which is true (Tarski; Artin–Lang) and unproved
here. The proof encodes the drawing as a finite system of rational polynomials (`edgePoly`), descends its real
solution to a real algebraic one, and takes `F` the field its finitely many coordinates generate. -/
theorem exists_numberField_drawing_of_descent (hD : RealAlgebraicDescent) {ι : Type*} [Finite ι]
    (G : SimpleGraph ι) (f : ι → ℂ) (hf : ∀ x y, G.Adj x y → dist (f x) (f y) = 1) :
    ∃ F : Subfield ℝ, NumberField F ∧ ∃ g : ι → ℂ, (∀ i, g i ∈ planeOver F) ∧
      ∀ x y, G.Adj x y → dist (g x) (g y) = 1 := by
  classical
  haveI := Fintype.ofFinite ι
  let S : Finset (MvPolynomial (ι ⊕ ι) ℚ) :=
    (Finset.univ.filter fun uv : ι × ι => G.Adj uv.1 uv.2).image fun uv => edgePoly uv.1 uv.2
  have hmem : ∀ p ∈ S, ∃ u v, G.Adj u v ∧ edgePoly u v = p := by
    intro p hp
    obtain ⟨⟨u, v⟩, huv, rfl⟩ := Finset.mem_image.mp hp
    exact ⟨u, v, (Finset.mem_filter.mp huv).2, rfl⟩
  have hedge : ∀ u v, G.Adj u v → edgePoly u v ∈ S := fun u v h =>
    Finset.mem_image.mpr ⟨(u, v), Finset.mem_filter.mpr ⟨Finset.mem_univ _, h⟩, rfl⟩
  let x₀ : ι ⊕ ι → ℝ := Sum.elim (fun i => (f i).re) (fun i => (f i).im)
  have hx₀ : ofCoords x₀ = f := funext fun i => Complex.ext rfl rfl
  obtain ⟨y, hyalg, hy⟩ := hD.of_finite S ⟨x₀, fun p hp => by
    obtain ⟨u, v, huv, rfl⟩ := hmem p hp
    rw [← dist_ofCoords_eq_one_iff, hx₀]
    exact hf u v huv⟩
  refine ⟨adjoinReal (Set.range y), numberField_adjoinReal (Set.finite_range y) ?_, ofCoords y, ?_, ?_⟩
  · rintro _ ⟨i, rfl⟩; exact hyalg i
  · intro i
    exact ⟨subset_adjoinReal _ ⟨_, rfl⟩, subset_adjoinReal _ ⟨_, rfl⟩⟩
  · intro u v huv
    exact (dist_ofCoords_eq_one_iff y u v).mpr (hy _ (hedge u v huv))

/-! ## C2 — the bridge -/

/-- The plane over any real subfield needs at most as many colours as the plane. -/
theorem chromaticNumber_planeOver_le_plane (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ (unitDistance ℂ).chromaticNumber :=
  chromaticNumber_mono_of_hom (Embedding.induce _).toHom

/-- `χ(ℝ²) ≤ 7`, in `ℂ` (`Instances/Seven.lean`). -/
theorem chromaticNumber_complex_le_seven : (unitDistance ℂ).chromaticNumber ≤ 7 := by
  rw [chromaticNumber_unitDistance_congr Complex.orthonormalBasisOneI.repr.toIsometryEquiv]
  exact chromaticNumber_plane_le_seven

/-- **The free half of C2**: `sup_F χ(F²) ≤ χ(ℝ²)` over the real number fields — no hypothesis, since each plane over
`F` is an induced subgraph of the plane. -/
theorem iSup_numberField_le_chromaticNumber_plane :
    ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤
      (unitDistance ℂ).chromaticNumber :=
  iSup₂_le fun F _ => chromaticNumber_planeOver_le_plane F

/-- The supremum is at most seven, hence finite. -/
theorem iSup_numberField_le_seven :
    ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ≤ 7 :=
  iSup_numberField_le_chromaticNumber_plane.trans chromaticNumber_complex_le_seven

/-- **The hard half of C2**, by de Bruijn–Erdős: a finite piece of the plane is a unit drawing of a finite graph, which
descends to a number field `F` (C1) and so is coloured by any colouring of `F²`. -/
theorem chromaticNumber_plane_le_iSup_numberField_of_descent (hD : RealAlgebraicDescent) :
    (unitDistance ℂ).chromaticNumber ≤
      ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  set S := ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber with hSdef
  obtain ⟨k, hk⟩ : ∃ k : ℕ, S = k :=
    ENat.ne_top_iff_exists.mp (ne_top_of_le_ne_top (by decide) iSup_numberField_le_seven) |>.imp
      fun _ h => h.symm
  rw [hk, chromaticNumber_le_iff_colorable]
  refine nonempty_hom_of_forall_finite_subgraph_hom fun G' hfin => Nonempty.some (α := G'.coe.Coloring (Fin k)) ?_
  haveI := hfin.to_subtype
  obtain ⟨F, hF, g, hgF, hg⟩ := exists_numberField_drawing_of_descent hD G'.coe Subtype.val
    fun x y h => G'.adj_sub h
  have hcol : ((unitDistance ℂ).induce (planeOver F)).Colorable k := by
    rw [← chromaticNumber_le_iff_colorable, ← hk]
    exact le_iSup₂ (f := fun (F : Subfield ℝ) (_ : NumberField F) =>
      ((unitDistance ℂ).induce (planeOver F)).chromaticNumber) F hF
  exact hcol.of_hom (⟨fun v => ⟨g v, hgF v⟩, fun {x y} h => hg x y h⟩ :
    G'.coe →g (unitDistance ℂ).induce (planeOver F))

/-- **C2** (`plans/M2-kernel-lane.md` §4.2): "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, the chromatic number of
`F²` meaning that of the unit-distance graph on `F × F`." (`[Madore2015]` ¶5.4 with ¶1.3, by Tarski.)

**Conditional, and not vacuous**: it assumes `RealAlgebraicDescent`, true (Tarski 1951; Artin–Lang, Lang 1953;
`plans/M2-S1D-bridge.md` §2.1) and without a kernel proof because Mathlib has no quantifier elimination for real closed
fields (§3.1 there). The gate's `VACUITY DECLARED:` marker is withheld on purpose: the hypothesis is true, not empty. -/
theorem chromaticNumber_plane_eq_iSup_numberField_of_descent (hD : RealAlgebraicDescent) :
    (unitDistance ℂ).chromaticNumber =
      ⨆ (F : Subfield ℝ) (_ : NumberField F), ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  le_antisymm (chromaticNumber_plane_le_iSup_numberField_of_descent hD) iSup_numberField_le_chromaticNumber_plane

/-- `ℚ`, as the subfield of `ℝ` generated by nothing, is a number field: the index of the supremum is nonempty. -/
theorem nonempty_numberField : Nonempty {F : Subfield ℝ // NumberField F} :=
  ⟨⟨adjoinReal ∅, numberField_adjoinReal Set.finite_empty fun _ h => h.elim⟩⟩

/-- **Attainment** (`plans/M2-S1D-bridge.md` §2.2: "every term is at most 7, `S` is finite, and the supremum is a
maximum"): some real number field's plane needs exactly as many colours as the plane.

**Conditional, and not vacuous**: it assumes `RealAlgebraicDescent` (true, unproved here; see C2). -/
theorem exists_numberField_chromaticNumber_eq_plane_of_descent (hD : RealAlgebraicDescent) :
    ∃ F : Subfield ℝ, NumberField F ∧
      ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = (unitDistance ℂ).chromaticNumber := by
  haveI := nonempty_numberField
  rw [chromaticNumber_plane_eq_iSup_numberField_of_descent hD, iSup_subtype']
  obtain ⟨⟨F, hF⟩, h⟩ := ENat.exists_eq_iSup_of_lt_top (f := fun F : {F : Subfield ℝ // NumberField F} =>
      ((unitDistance ℂ).induce (planeOver F.1)).chromaticNumber)
    (lt_of_le_of_lt (iSup_le fun F => (chromaticNumber_planeOver_le_plane F.1).trans
      chromaticNumber_complex_le_seven) (by decide))
  exact ⟨F, hF, h⟩

/-! ## C4 — the exact form of "`χ(ℝ²) ≠ 6`" -/

/-- A real subfield as an intermediate field over `ℚ`. -/
noncomputable def toRatIntermediateField (F : Subfield ℝ) : IntermediateField ℚ ℝ :=
  F.toIntermediateField fun q => by simp

/-- **The compositum of two real number fields is a real number field.** -/
theorem numberField_sup {F E : Subfield ℝ} (hF : NumberField F) (hE : NumberField E) : NumberField ↥(F ⊔ E) := by
  haveI : FiniteDimensional ℚ (toRatIntermediateField F) := hF.to_finiteDimensional
  haveI : FiniteDimensional ℚ (toRatIntermediateField E) := hE.to_finiteDimensional
  have h : (toRatIntermediateField F ⊔ toRatIntermediateField E).toSubfield = F ⊔ E :=
    IntermediateField.sup_toSubfield _ _
  rw [← h]
  haveI : FiniteDimensional ℚ ↥(toRatIntermediateField F ⊔ toRatIntermediateField E) := inferInstance
  exact ⟨⟩

/-- **C4** (`plans/M2-kernel-lane.md` §4.2; `plans/STUB-plane-bridge.md` §5, FS62-T2): "`χ(ℝ²) ≠ 6` if and only if
every real number field `F` with `χ(F²) = 6` has a finite extension `F′ ⊂ ℝ` with `χ(F′²) = 7`". A number field
`F′ ⊇ F` is a finite extension of `F`.

A restatement of Hadwiger–Nelson's top rung ("six is never where the climb stops"), not a reduction of it (G64).

**Conditional, and not vacuous**: it assumes `RealAlgebraicDescent` (true, unproved here; see C2). -/
theorem chromaticNumber_plane_ne_six_iff_of_descent (hD : RealAlgebraicDescent) :
    (unitDistance ℂ).chromaticNumber ≠ 6 ↔ ∀ F : Subfield ℝ, NumberField F →
      ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = 6 →
      ∃ F' : Subfield ℝ, F ≤ F' ∧ NumberField F' ∧ ((unitDistance ℂ).induce (planeOver F')).chromaticNumber = 7 := by
  obtain ⟨E, hE, hEeq⟩ := exists_numberField_chromaticNumber_eq_plane_of_descent hD
  constructor
  · intro hne F hF h6
    have h6le : (6 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := h6 ▸ chromaticNumber_planeOver_le_plane F
    have h7 : (unitDistance ℂ).chromaticNumber = 7 := by
      have hle := chromaticNumber_complex_le_seven
      generalize (unitDistance ℂ).chromaticNumber = c at h6le hle hne ⊢
      induction c using ENat.recTopCoe with
      | top => exact absurd hle (by decide)
      | coe c =>
        have h1 : 6 ≤ c := by exact_mod_cast h6le
        have h2 : c ≤ 7 := by exact_mod_cast hle
        have h3 : c ≠ 6 := fun h => hne (by rw [h]; rfl)
        have : c = 7 := by omega
        rw [this]; rfl
    refine ⟨F ⊔ E, le_sup_left, numberField_sup hF hE, le_antisymm ?_ ?_⟩
    · exact h7 ▸ chromaticNumber_planeOver_le_plane _
    · rw [← h7, ← hEeq]
      exact chromaticNumber_mono_of_hom (induceHomOfLE _ fun z hz =>
        show z.re ∈ F ⊔ E ∧ z.im ∈ F ⊔ E from ⟨le_sup_right (α := Subfield ℝ) hz.1,
          le_sup_right (α := Subfield ℝ) hz.2⟩).toHom
  · intro h h6
    obtain ⟨F', -, -, hF'⟩ := h E hE (hEeq.trans h6)
    have := chromaticNumber_planeOver_le_plane F'
    rw [hF', h6] at this
    exact absurd this (by decide)

/-! ## Spec -/

-- The edge polynomial of `0 ~ 1` evaluates to `(x₀ − x₁)² + (y₀ − y₁)² − 1`: at the unit segment `0—1` it vanishes.
example : MvPolynomial.aeval (Sum.elim ![(0 : ℝ), 1] ![0, 0]) (edgePoly (0 : Fin 2) 1) = 0 := by
  rw [aeval_edgePoly]; simp
-- … and at a segment of length two it does not.
example : MvPolynomial.aeval (Sum.elim ![(0 : ℝ), 2] ![0, 0]) (edgePoly (0 : Fin 2) 1) ≠ 0 := by
  rw [aeval_edgePoly]; norm_num
-- `ofCoords` reads real parts from `inl` and imaginary parts from `inr`.
example : ofCoords (Sum.elim ![(3 : ℝ)] ![4]) 0 = ⟨3, 4⟩ := rfl
-- `adjoinReal` holds its generators: `√2 ∈ ℚ(√2)`.
example : Real.sqrt 2 ∈ adjoinReal {Real.sqrt 2} := subset_adjoinReal _ rfl

end Bridge
end HadwigerNelson
