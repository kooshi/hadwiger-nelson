import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric
namespace ArcMap
variable {k : ℕ} {F : ArcMap k}

/-- **A point in the closure of a set is approached along some direction** (compactness of the circle of directions). -/
theorem coneAt_nonempty_of_mem_closure_region (j : Fin k) {v : ℂ} (hv : v ∈ closure (F.region j)) :
    (coneAt (F.region j) v).Nonempty := by
  by_contra hempty
  rw [Set.not_nonempty_iff_eq_empty] at hempty
  -- every direction has a radius `ε_β` and a window with no point of `region j` approaching along it
  have hno : ∀ β : ℝ, ∃ ε > 0, ∀ z ∈ F.region j, z ≠ v → dist z v < ε → ε ≤ ‖(z - v) / (‖z - v‖ : ℂ) - e β‖ := by
    intro β
    have hβ : β ∉ coneAt (F.region j) v := by rw [hempty]; exact id
    simp only [coneAt, mem_setOf_eq, not_forall, not_exists, not_and, not_lt] at hβ
    obtain ⟨ε, hε, h⟩ := hβ
    exact ⟨ε, hε, fun z hz hne hd => h z hz hne hd⟩
  choose ε hε hεno using hno
  have hopen : ∀ β ∈ Icc (0 : ℝ) (2 * π), IsOpen {β' : ℝ | ‖e β' - e β‖ < ε β / 2} := fun β _ =>
    isOpen_lt (by have := continuous_e; fun_prop) continuous_const
  obtain ⟨t, htsub, htfin, htcov⟩ := isCompact_Icc.elim_finite_subcover_image hopen
    (fun β hβ => mem_iUnion₂.mpr ⟨β, hβ, by simp [hε β]⟩)
  obtain ⟨ε', hε', hle⟩ := exists_pos_le_finset htfin.toFinset (fun β => ε β / 2) (fun β => by have := hε β; positivity)
  -- a point of the class near `v`, other than `v`
  obtain ⟨z, hz, hzv, hzd⟩ : ∃ z ∈ F.region j, z ≠ v ∧ dist z v < ε' := by
    obtain ⟨z, hz, hd⟩ := Metric.mem_closure_iff.mp hv ε' hε'
    by_cases hne : z = v
    · subst hne
      obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp (F.isOpen_region j) z hz
      refine ⟨z + ((min r ε' / 2 : ℝ) : ℂ), hball ?_, ?_, ?_⟩
      · rw [Metric.mem_ball, dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
        have := min_le_left r ε'; linarith
      · intro h0
        have := congrArg (fun w => w - z) h0
        simp only [add_sub_cancel_left, sub_self] at this
        have h1 : (0 : ℝ) < min r ε' / 2 := by positivity
        exact h1.ne' (by exact_mod_cast this)
      · rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
        have := min_le_right r ε'; linarith
    · exact ⟨z, hz, hne, by rw [dist_comm]; exact hd⟩
  -- its direction is `e β₁` for some `β₁ ∈ [0, 2π]`
  have hp : (0 : ℝ) < 2 * π := by positivity
  set β₀ := Complex.arg (z - v) with hβ₀
  have hdir : (z - v) / (‖z - v‖ : ℂ) = e β₀ := by
    have hn : (‖z - v‖ : ℂ) ≠ 0 := by exact_mod_cast norm_ne_zero_iff.mpr (sub_ne_zero.mpr hzv)
    rw [div_eq_iff hn, e, mul_comm]
    exact (Complex.norm_mul_exp_arg_mul_I (z - v)).symm
  set β₁ := toIcoMod hp 0 β₀ with hβ₁
  have hβ₁I : β₁ ∈ Icc (0 : ℝ) (2 * π) := ⟨(toIcoMod_mem_Ico hp 0 β₀).1, by have := (toIcoMod_mem_Ico hp 0 β₀).2; linarith⟩
  have heβ₁ : e β₁ = e β₀ := by
    obtain ⟨-, m, hm⟩ := (toIcoMod_eq_iff hp (a := 0) (b := β₀) (c := β₁)).mp rfl
    rw [hm, zsmul_eq_mul]
    have := e_add_int_mul_two_pi β₁ m
    rw [show β₁ + (m : ℝ) * (2 * π) = β₁ + 2 * π * m by ring] at *
    exact this.symm ▸ rfl
  obtain ⟨β, hβt, hβ₁β⟩ := mem_iUnion₂.mp (htcov hβ₁I)
  have hlt : ‖e β₁ - e β‖ < ε β / 2 := hβ₁β
  have hεβ : ε' ≤ ε β / 2 := hle β (htfin.mem_toFinset.mpr hβt)
  have := hεno β z hz hzv (by linarith)
  rw [hdir, ← heβ₁] at this
  linarith

end ArcMap
end HadwigerNelson.Plane
