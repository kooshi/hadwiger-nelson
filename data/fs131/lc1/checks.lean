import Proofs
/-!
FS131-LC1 — the landing's statements as the kernel holds them, their axioms, and the models of their hypotheses that
the library does not itself hold as theorems or `example`s.  An iteration file: elaborated by `lake env lean` with the
lakefile's two options (`-DautoImplicit=false -DrelaxedAutoImplicit=false`), read by the record's read-aloud and by the
gate's pass.  Nothing here is a library theorem and nothing here is a claim of the landing: the terms of `FS131LC1`
are kernel-checked when this file is elaborated, and each prints its axioms.

Three parts: (1) every headline by `#check @…` (the stored binders, section variables included) and the new
definition by `#print`; (2) the model terms; (3) `#print axioms` of the headlines and of the terms.
-/
open MeasureTheory Set Filter Topology Metric
open HadwigerNelson HadwigerNelson.Plane

/-! ## 1. The statements, as stored -/

#print HadwigerNelson.Plane.chiLebesgue
#print HadwigerNelson.HasDensityOneAt
#print HadwigerNelson.Plane.AeColouring.core
#print HadwigerNelson.Plane.chiM
#print HadwigerNelson.Plane.chiM0
#print HadwigerNelson.Plane.AeColouring
#print HadwigerNelson.Plane.UnitPairsNull

#check @HadwigerNelson.exists_proper_ae_eq_of_proper_on_conull
#check @HadwigerNelson.exists_proper_nullMeasurable_of_avoiding_cover
#check @HadwigerNelson.davies_lemma_B1_euclidean
#check @HadwigerNelson.Plane.davies_lemma_B1
#check @HadwigerNelson.Plane.exists_proper_of_aeColouring
#check @HadwigerNelson.Plane.exists_proper_of_nullMeasurable_weak
#check @HadwigerNelson.Plane.exists_aeColouring_of_nullMeasurable_proper
#check @HadwigerNelson.Plane.nonempty_aeColouring_iff_exists_nullMeasurable_proper
#check @HadwigerNelson.Plane.chiM0_eq_chiLebesgue
#check @HadwigerNelson.Plane.chiLebesgue_le_chiM
#check @HadwigerNelson.Plane.chromaticNumber_plane_le_chiLebesgue
#check @HadwigerNelson.Plane.colorable_iff_exists_nullMeasurable_proper
#check @HadwigerNelson.Plane.chromaticNumber_plane_eq_chiLebesgue
#check @HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue
#check @HadwigerNelson.Plane.nullMeasurable_iff_forall_fibre
#check @HadwigerNelson.Plane.chiLebesgue_le
#check @HadwigerNelson.exists_translate_mem
#check @HadwigerNelson.exists_nullMeasurable_selector
#check @HadwigerNelson.ae_hasDensityOneAt_fibre
#check @HadwigerNelson.HasDensityOneAt.inter
#check @HadwigerNelson.hasDensityOneAt_univ
#check @HadwigerNelson.hasDensityOneAt_congr_ae
#check @HadwigerNelson.hasDensityOneAt_preimage_add_right
#check @HadwigerNelson.HasDensityOneAt.nonempty
#check @HadwigerNelson.Plane.AeColouring.core_dist_ne_one
#check @HadwigerNelson.Plane.AeColouring.volume_compl_iUnion_core
#check @HadwigerNelson.Plane.mem_densitySet_iff_hasDensityOneAt
-- the declared outside theorem the last three headlines rest on, and the library's composition over it
#check @HadwigerNelson.Outside.OAI158.proper_to_borel_weak
#check @HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
-- what the two sides of the plane's headline are
#check @SimpleGraph.chromaticNumber
#check @HadwigerNelson.unitDistance_adj
-- which measure and which σ-algebra `volume` and `Measurable` are on `ℂ`
#check (inferInstance : MeasurableSpace ℂ)
#check (inferInstance : BorelSpace ℂ)
#check (inferInstance : (volume : Measure ℂ).IsAddHaarMeasure)
#check (inferInstance : (volume : Measure (EuclideanSpace ℝ (Fin 2))).IsAddHaarMeasure)

/-! ## 2. Models of the hypotheses, as terms -/

namespace FS131LC1

/-- The lemma's printed form at the paper's own standing hypotheses — `d = 2`, `D = {1}` (finite, nonempty, in
`(0, ∞)`), `k = 9 ⩾ 2` — every hypothesis at once: the nine classes of `sq9Col`, carried to `EuclideanSpace ℝ (Fin 2)`
by the isometry `Complex.orthonormalBasisOneI.repr`.  The library's `example` is the plane's form over `ℂ`. -/
theorem model_euclidean :
    ∃ f : EuclideanSpace ℝ (Fin 2) → Fin 9, NullMeasurable f volume ∧
      (∀ᵐ x, x ∈ (fun j : Fin 9 => (fun x => sq9Col (Complex.orthonormalBasisOneI.repr.symm x)) ⁻¹' {j}) (f x)) ∧
      ∀ x y, dist x y ∈ ({1} : Set ℝ) → f x ≠ f y :=
  davies_lemma_B1_euclidean {1}
    (A := fun j : Fin 9 => (fun x => sq9Col (Complex.orthonormalBasisOneI.repr.symm x)) ⁻¹' {j})
    (fun j => ((measurable_sq9Col.comp Complex.orthonormalBasisOneI.repr.symm.continuous.measurable)
      (measurableSet_singleton j)).nullMeasurableSet)
    (fun j x hx y hy h => sq9Col_ne_of_dist_eq_one
      (by rw [LinearIsometryEquiv.dist_map]; exact h) (hx.trans hy.symm))
    (by
      have : (⋃ j : Fin 9, (fun x => sq9Col (Complex.orthonormalBasisOneI.repr.symm x)) ⁻¹' {j}) = univ := by
        ext x; simp
      rw [this, compl_univ, measure_empty])

/-- `r7Col` is NOT proper: the lattice point `0` and the point `3/7 + (5/7)ω` of the opposite arc of the Reuleaux tile
`U(0, 0)` are at distance `1` (`(3/7)² + (3/7)(5/7) + (5/7)² = 1`) and both have colour `0`.  So the two `example`s
that run the weak-to-proper step on `r7Col` run it where it changes the colouring. -/
theorem r7Col_not_proper : ∃ x y : ℂ, dist x y = 1 ∧ r7Col x = r7Col y := by
  refine ⟨((0 : ℝ) : ℂ) + (0 : ℝ) * e (Real.pi / 3), ((3 / 7 : ℝ) : ℂ) + (5 / 7 : ℝ) * e (Real.pi / 3), ?_, ?_⟩
  · have h : Complex.normSq (((3 / 7 : ℝ) : ℂ) + (5 / 7 : ℝ) * e (Real.pi / 3)) = 1 := by
      rw [normSq_add_mul]; norm_num [triQ]
    rw [dist_comm, dist_eq_norm]
    have h0 : ((0 : ℝ) : ℂ) + (0 : ℝ) * e (Real.pi / 3) = 0 := by simp
    rw [h0, sub_zero, ← Complex.sq_norm] at *
    nlinarith [norm_nonneg (((3 / 7 : ℝ) : ℂ) + (5 / 7 : ℝ) * e (Real.pi / 3))]
  · rw [r7Col_add_mul, r7Col_add_mul]
    norm_num [r7ColTri, triQ, r7UpCol]

/-- The core form of the lemma is run by the library where `S ≠ univ`: the cores of the `AeColouring` whose colouring
is `r7Col` — the conull set `exists_proper_of_aeColouring` hands the lemma — do not cover the plane. -/
theorem model_core_ne_univ : ∃ a : AeColouring 7, a.col = r7Col ∧ (⋃ j, a.core j) ≠ univ := by
  obtain ⟨a, ha⟩ := r7_aeColouring
  refine ⟨a, ha, fun huniv => ?_⟩
  obtain ⟨x, y, hxy, hc⟩ := r7Col_not_proper
  have hx : x ∈ ⋃ j, a.core j := huniv ▸ mem_univ x
  have hy : y ∈ ⋃ j, a.core j := huniv ▸ mem_univ y
  obtain ⟨i, hi⟩ := mem_iUnion.1 hx
  obtain ⟨j, hj⟩ := mem_iUnion.1 hy
  have hij : i = j := by rw [← a.col_eq_of_mem_core hi, ← a.col_eq_of_mem_core hj, ha, hc]
  subst hij
  exact a.core_dist_ne_one i hi hj hxy

/-- "The number is the same" (the corrected docstrings of `AeColouring` and `chiM0`): with `k` colours, a
Lebesgue-measurable colouring proper at almost every unit pair exists exactly when a Borel one does — the two
theorems those docstrings name, composed. -/
theorem lebesgue_weak_iff_nonempty_aeColouring {k : ℕ} :
    (∃ c : ℂ → Fin k, NullMeasurable c volume ∧ ∀ j, UnitPairsNull (c ⁻¹' {j})) ↔ Nonempty (AeColouring k) :=
  ⟨fun ⟨_, hc, hn⟩ => (exists_proper_of_nullMeasurable_weak hc hn).elim fun _ h =>
      (exists_aeColouring_of_nullMeasurable_proper h.1 h.2.2).elim fun a _ => ⟨a⟩,
   fun ⟨a⟩ => ⟨a.col, a.measurable.nullMeasurable, a.unitPairsNull⟩⟩

/-- The Lebesgue form of the weak-to-proper step, run on its named inhabitant (`r7Col`: Borel, so Lebesgue
measurable; each class with null unit pairs).  The library's `example` runs the `AeColouring` form. -/
theorem model_weak :
    ∃ f : ℂ → Fin 7, NullMeasurable f volume ∧ f =ᵐ[volume] r7Col ∧ ∀ x y, dist x y = 1 → f x ≠ f y := by
  obtain ⟨a, ha⟩ := r7_aeColouring
  rw [← ha]
  exact exists_proper_of_nullMeasurable_weak a.measurable.nullMeasurable a.unitPairsNull

/-- The converse, run on its named inhabitant (`sq9Col`). -/
theorem model_converse : ∃ a : AeColouring 9, a.col =ᵐ[volume] sq9Col :=
  exists_aeColouring_of_nullMeasurable_proper measurable_sq9Col.nullMeasurable
    fun _ _ h => sq9Col_ne_of_dist_eq_one h

/-- `exists_translate_mem` at its named inhabitant, `V x = univ`. -/
theorem model_translate (F : Finset ℂ) : ∃ ξ : ℂ, ∀ x ∈ F, x + ξ ∈ (fun _ : ℂ => (univ : Set ℂ)) x :=
  exists_translate_mem (μ := volume) F (fun _ _ => nullMeasurableSet_univ) fun x _ => hasDensityOneAt_univ x

/-- Both sides of the colour-by-colour statements hold at seven: a Lebesgue-measurable seven-colouring proper at
every unit pair exists.  On the standard three. -/
theorem model_seven : ∃ f : ℂ → Fin 7, NullMeasurable f volume ∧ ∀ x y, dist x y = 1 → f x ≠ f y :=
  nonempty_aeColouring_iff_exists_nullMeasurable_proper.mp (r7_aeColouring.elim fun a _ => ⟨a⟩)

/-- Sanity of the definition, not a claim: the new number is at most seven with no import… -/
theorem chiLebesgue_le_seven : chiLebesgue ≤ 7 :=
  model_seven.elim fun _ h => chiLebesgue_le h.1 h.2

/-- …and at least six given the OTHER declared outside theorem (`no_proper_five_coloring`), through
`χ(ℝ²) ≤ chiLebesgue`, which needs no import.  Sanity of the definition, not a claim of this landing. -/
theorem six_le_chiLebesgue : 6 ≤ chiLebesgue := by
  have h := Outside.OAI158.six_le_chromaticNumber_plane
  rw [chromaticNumber_plane_eq_complex] at h
  exact h.trans chromaticNumber_plane_le_chiLebesgue

/-- Both sides of `colorable_iff_exists_nullMeasurable_proper` fail at five, given `no_proper_five_coloring`. -/
theorem not_exists_five : ¬ ∃ f : ℂ → Fin 5, NullMeasurable f volume ∧ ∀ x y, dist x y = 1 → f x ≠ f y :=
  fun ⟨f, _, hp⟩ => Outside.OAI158.not_colorable_five
    ⟨SimpleGraph.Coloring.mk f fun {x y} hxy => hp x y (unitDistance_adj.mp hxy)⟩

end FS131LC1

/-! ## 3. Axioms -/

#print axioms HadwigerNelson.exists_proper_ae_eq_of_proper_on_conull
#print axioms HadwigerNelson.exists_proper_nullMeasurable_of_avoiding_cover
#print axioms HadwigerNelson.davies_lemma_B1_euclidean
#print axioms HadwigerNelson.Plane.davies_lemma_B1
#print axioms HadwigerNelson.Plane.exists_proper_of_aeColouring
#print axioms HadwigerNelson.Plane.exists_proper_of_nullMeasurable_weak
#print axioms HadwigerNelson.Plane.exists_aeColouring_of_nullMeasurable_proper
#print axioms HadwigerNelson.Plane.nonempty_aeColouring_iff_exists_nullMeasurable_proper
#print axioms HadwigerNelson.Plane.chiM0_eq_chiLebesgue
#print axioms HadwigerNelson.Plane.chiLebesgue_le_chiM
#print axioms HadwigerNelson.Plane.chromaticNumber_plane_le_chiLebesgue
#print axioms HadwigerNelson.Plane.colorable_iff_exists_nullMeasurable_proper
#print axioms HadwigerNelson.Plane.chromaticNumber_plane_eq_chiLebesgue
#print axioms HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue
#print axioms FS131LC1.model_euclidean
#print axioms FS131LC1.r7Col_not_proper
#print axioms FS131LC1.model_core_ne_univ
#print axioms FS131LC1.lebesgue_weak_iff_nonempty_aeColouring
#print axioms FS131LC1.model_weak
#print axioms FS131LC1.model_converse
#print axioms FS131LC1.model_translate
#print axioms FS131LC1.model_seven
#print axioms FS131LC1.chiLebesgue_le_seven
#print axioms FS131LC1.six_le_chiLebesgue
#print axioms FS131LC1.not_exists_five
