import Proofs
/-!
FS124-L1 — the definition and the theorems the landing is for, as the kernel holds them, with their axioms, for the
reading aloud; the two halves of each join theorem proved apart, so that each half's axioms print (a half taken out of
the `iff` would print the whole theorem's list); and the models of the hypotheses, as terms.  Iteration file, run by
the gate's runner after the build (`lake env lean data/fs124/l1/checks.lean`); never a library module, and nothing
here is a theorem of the library.
-/
open HadwigerNelson HadwigerNelson.Plane Metric Set MeasureTheory
set_option pp.funBinderTypes true
set_option pp.numericTypes true
set_option pp.fullNames true

-- § 1  the definitions, as stored
#print HadwigerNelson.Plane.rigidMotion
#print HadwigerNelson.Plane.monoPairSet
#print HadwigerNelson.Plane.AeProperOn
#print HadwigerNelson.Plane.IsWeakColouringOn
#print HadwigerNelson.Plane.arcLength
#print HadwigerNelson.Plane.e

-- § 2  the statements, as stored
#check @radius_graph
#check @radius_countable
#check @radius_up
#check @radius_down
#check @radius_five
#check @colorable_iff_forall_ball
#check @seven_le_chromaticNumber_plane_iff_exists_ball
#check @exists_radius_of_not_colorable
#check @colorable_plane_of_forall_aeProperOn_ball
#check @exists_isWeakColouringOn_of_colorable
#check @AeProperOn.ae_rigidMotion
#check @aeProperOn_iff_ae
#check @exists_isWeakColouringOn_iff_subtype
#check @exists_isWeakColouringOn_ball_iff
#check @exists_isWeakColouringOn_seven
#check @exists_radius_no_weak_four

-- § 3  their axioms
#print axioms radius_graph
#print axioms radius_countable
#print axioms radius_up
#print axioms radius_down
#print axioms radius_five
#print axioms colorable_iff_forall_ball
#print axioms seven_le_chromaticNumber_plane_iff_exists_ball
#print axioms exists_radius_of_not_colorable
#print axioms exists_isWeakColouringOn_of_colorable
#print axioms exists_radius_no_weak_four

namespace FS124L1

-- § 4  the two halves of each join theorem, proved apart (the implementer's `data/fs124/i1/lean/Halves.lean`, on the
--      gated tree)

/-- `colorable_iff_forall_ball`, `←`: C124-RADIUS-UP. -/
theorem colorable_of_forall_ball {k : ℕ}
    (h : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c) : (unitDistance ℂ).Colorable k :=
  SimpleGraph.chromaticNumber_le_iff_colorable.mp (radius_up h).2

/-- `colorable_iff_forall_ball`, `→`: C124-RADIUS-DOWN. -/
theorem forall_ball_of_colorable {k : ℕ} (h : (unitDistance ℂ).Colorable k) :
    ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c :=
  fun _ _ => radius_down (SimpleGraph.chromaticNumber_le_iff_colorable.mpr h) _ isOpen_ball

/-- `seven_le_chromaticNumber_plane_iff_exists_ball`, `→`: seven gives a disc with no weak six-colouring. -/
theorem exists_ball_of_seven_le (h : 7 ≤ (unitDistance ℂ).chromaticNumber) :
    ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  have h6 : ¬ (unitDistance ℂ).Colorable 6 :=
    (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 6)).mp h
  obtain ⟨R, hR, hRp⟩ := exists_radius_of_not_colorable h6
  exact ⟨R, hR, fun ⟨c, hc⟩ => hRp 0 c hc.aeProperOn⟩

/-- `seven_le_chromaticNumber_plane_iff_exists_ball`, `←`: a disc with no weak six-colouring gives seven. -/
theorem seven_le_of_exists_ball (h : ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 6, IsWeakColouringOn (ball (0 : ℂ) R) c) :
    7 ≤ (unitDistance ℂ).chromaticNumber := by
  refine (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 6)).mpr fun hcol => ?_
  obtain ⟨R, -, hR⟩ := h
  exact hR (radius_down (SimpleGraph.chromaticNumber_le_iff_colorable.mpr hcol) _ isOpen_ball)

-- § 5  the models of the hypotheses, as terms

/-- `radius_graph`, `radius_countable`: every hypothesis at once on a **bounded** open set with a unit pair in it —
`U` the open disc of radius `2`, `c` the seven-colouring R7, `V = {0, 1}`.  (The module's own `example`s run the two
theorems at `U = univ`, where the clause "the motion carries `V` into `U`" asks nothing.) -/
theorem model_graph : ∃ (c : ℂ → Fin 7) (U V : Set ℂ), IsOpen U ∧ IsWeakColouringOn U c ∧ V.Finite ∧ V ⊆ U ∧
    V.Countable ∧ IsCompact (closure V) ∧ closure V ⊆ U ∧ (∃ v ∈ V, ∃ w ∈ V, dist v w = 1) ∧ U ≠ univ := by
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_seven
  have hfin : ({0, 1} : Set ℂ).Finite := by simp
  have hsub : ({0, 1} : Set ℂ) ⊆ ball (0 : ℂ) 2 := by
    rintro z (rfl | rfl) <;> simp
  have hcl : closure ({0, 1} : Set ℂ) = {0, 1} := hfin.isClosed.closure_eq
  refine ⟨c, ball 0 2, {0, 1}, isOpen_ball, hc _, hfin, hsub, hfin.countable, hcl ▸ hfin.isCompact, hcl ▸ hsub,
    ⟨0, by simp, 1, by simp, by simp⟩, fun h => ?_⟩
  have h3 : (3 : ℂ) ∈ ball (0 : ℂ) 2 := h ▸ mem_univ _
  rw [mem_ball, dist_zero_right] at h3
  norm_num at h3

/-- `radius_up`: its hypothesis at `k = 7`. -/
theorem model_up : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin 7, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_seven
  exact fun R _ => ⟨c, hc _⟩

/-- `radius_down`: its hypothesis at `k = 7`. -/
theorem model_down : (unitDistance ℂ).chromaticNumber ≤ (7 : ℕ) := by
  rw [← chromaticNumber_plane_eq_complex]
  exact chromaticNumber_plane_interval.2

/-- `colorable_iff_forall_ball` at `k = 7`: both sides hold, with no import. -/
theorem join_seven : (unitDistance ℂ).Colorable 7 ∧
    ∀ R > (0 : ℝ), ∃ c : ℂ → Fin 7, IsWeakColouringOn (ball (0 : ℂ) R) c :=
  ⟨colorable_of_forall_ball model_up, model_up⟩

/-- `colorable_iff_forall_ball` at `k = 4`: both sides fail, with no import. -/
theorem join_four : ¬ (unitDistance ℂ).Colorable 4 ∧
    ¬ ∀ R > (0 : ℝ), ∃ c : ℂ → Fin 4, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  refine ⟨fun ⟨C⟩ => isEmpty_coloring_plane_four.false C, fun h => ?_⟩
  obtain ⟨R, hR, hno⟩ := exists_radius_no_weak_four
  exact hno 0 (h R hR)

/-- The criterion's sentence one colour up is false on both sides, with no import: `8 ≤ χ(ℝ²)` fails and every disc
has a weak seven-colouring. -/
theorem criterion_at_seven : ¬ (8 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber ∧
    ¬ ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 7, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  refine ⟨fun h => ?_, fun ⟨R, hR, hno⟩ => hno (model_up R hR)⟩
  have h7 : (unitDistance ℂ).chromaticNumber ≤ (7 : ℕ) := model_down
  have h78 : (8 : ℕ∞) ≤ (7 : ℕ) := h.trans h7
  exact absurd h78 (by decide)

/-- The criterion's sentence one colour down holds on both sides, on the two imports: `6 ≤ χ(ℝ²)` and some disc has no
weak five-colouring. -/
theorem criterion_at_five : (6 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber ∧
    ∃ R > (0 : ℝ), ¬ ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  refine ⟨?_, ?_⟩
  · exact (add_one_le_chromaticNumber_iff_not_colorable (G := unitDistance ℂ) (n := 5)).mpr
      Outside.OAI158.not_colorable_five
  · obtain ⟨R, hR, h⟩ := radius_five
    exact ⟨R, hR, h 0⟩

/-- `radius_up`'s hypothesis at `k = 5` is empty, given the declared outside theorem (so `radius_up` at five says
nothing beyond that import). -/
theorem up_hypothesis_five_empty :
    ¬ ∀ R > (0 : ℝ), ∃ c : ℂ → Fin 5, IsWeakColouringOn (ball (0 : ℂ) R) c := by
  obtain ⟨R, hR, h⟩ := radius_five
  exact fun hall => h 0 (hall R hR)

end FS124L1

#print axioms FS124L1.colorable_of_forall_ball
#print axioms FS124L1.forall_ball_of_colorable
#print axioms FS124L1.exists_ball_of_seven_le
#print axioms FS124L1.seven_le_of_exists_ball
#print axioms FS124L1.model_graph
#print axioms FS124L1.model_up
#print axioms FS124L1.model_down
#print axioms FS124L1.join_seven
#print axioms FS124L1.join_four
#print axioms FS124L1.criterion_at_seven
#print axioms FS124L1.criterion_at_five
#print axioms FS124L1.up_hypothesis_five_empty
-- controls: a theorem on each declared outside theorem prints it (the print sees an import when one is there)
#print axioms HadwigerNelson.Outside.OAI158.not_colorable_five
#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
