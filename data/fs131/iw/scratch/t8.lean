import Proofs.HadwigerNelson.Plane.Woodall.Collar
import Proofs.HadwigerNelson.Plane.LocalStructure
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

/-- **The previous sector's end is this sector's start**, through the `Fin` wrap: for `i ≠ 0` the sector before `i` ends at `i`'s start; for
`i = 0` it is the last sector, ending at `d (last n)`. -/
theorem prev_succ {n : ℕ} (i : Fin n) :
    (((finRotate n).symm i).succ = i.castSucc ∧ (i : ℕ) ≠ 0) ∨ (((finRotate n).symm i).succ = Fin.last n ∧ (i : ℕ) = 0) := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by have := i.pos; omega⟩
  set j := (finRotate (m + 1)).symm i with hj
  have hji : finRotate (m + 1) j = i := (finRotate (m + 1)).apply_symm_apply i
  by_cases hlt : (j : ℕ) < m
  · have h1 : finRotate (m + 1) j = ⟨j + 1, by omega⟩ := finRotate_of_lt hlt
    rw [h1] at hji
    have hi : (i : ℕ) = j + 1 := by rw [← hji]
    left
    refine ⟨?_, by omega⟩
    ext; simp [hi]
  · have hjm : (j : ℕ) = m := by have := j.isLt; omega
    have h1 : finRotate (m + 1) j = ⟨0, by omega⟩ := by
      have : j = ⟨m, by omega⟩ := by ext; simp [hjm]
      rw [this]; exact finRotate_last'
    rw [h1] at hji
    have hi : (i : ℕ) = 0 := by rw [← hji]
    right
    refine ⟨?_, hi⟩
    ext; simp [hjm]

/-- The start of the sector after `prev i` is `d i.castSucc`, up to the wrap `2π` when `i = 0`. -/
theorem d_prev_succ {n : ℕ} {d : Fin (n + 1) → ℝ} (hlast : d (Fin.last n) = d 0 + 2 * π) (i : Fin n) :
    (d ((finRotate n).symm i).succ = d i.castSucc ∧ (i : ℕ) ≠ 0) ∨
      (d ((finRotate n).symm i).succ = d i.castSucc + 2 * π ∧ (i : ℕ) = 0) := by
  rcases prev_succ i with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact Or.inl ⟨by rw [h1], h2⟩
  · refine Or.inr ⟨?_, h2⟩
    have : i.castSucc = 0 := by ext; simp [h2]
    rw [h1, hlast, this]

/-- **A sector edge lies in the closed range of only its two sectors** (positive angles): if `d i.castSucc` lies in the closed range of sector `i'`
mod `2π`, then `i'` is `i` or the sector before `i`. -/
theorem eq_of_edge_mem_angleIcc {n : ℕ} {d : Fin (n + 1) → ℝ} (hmono : StrictMono d) (hlast : d (Fin.last n) = d 0 + 2 * π)
    {i i' : Fin n} (hx : d i.castSucc ∈ angleIcc (d i'.castSucc) (d i'.succ)) : i' = i ∨ i' = (finRotate n).symm i := by
  obtain ⟨m, hm⟩ := mem_iUnion.mp hx
  obtain ⟨hm1, hm2⟩ := hm
  have hpi := Real.pi_pos
  have h0i' : d 0 ≤ d i'.castSucc := hmono.monotone (Fin.zero_le _)
  have hi'last : d i'.succ ≤ d (Fin.last n) := hmono.monotone (Fin.le_last _)
  have h0i : d 0 ≤ d i.castSucc := hmono.monotone (Fin.zero_le _)
  have hilast : d i.castSucc < d (Fin.last n) := hmono (Fin.castSucc_lt_last i)
  have hi'lt : d i'.castSucc < d i'.succ := hmono (Fin.castSucc_lt_succ)
  rw [hlast] at hi'last hilast
  have hm_lt : (m : ℝ) < 1 := by
    by_contra hcon; push Not at hcon; nlinarith
  have hm_gt : (-2 : ℝ) < m := by
    by_contra hcon; push Not at hcon; nlinarith
  have hm1' : m < 1 := by exact_mod_cast hm_lt
  have hm2' : -2 < m := by exact_mod_cast hm_gt
  have hm0 : m = 0 ∨ m = -1 := by omega
  rcases hm0 with rfl | rfl
  · -- the same period
    simp only [Int.cast_zero, mul_zero, add_zero] at hm1 hm2
    have hle1 : i'.castSucc ≤ i.castSucc := hmono.le_iff_le.mp hm1
    have hle2 : i.castSucc ≤ i'.succ := hmono.le_iff_le.mp hm2
    have h1 : (i' : ℕ) ≤ i := by simpa using hle1
    have h2 : (i : ℕ) ≤ i' + 1 := by rw [Fin.le_def] at hle2; simpa using hle2
    by_cases hii : (i : ℕ) = i'
    · left; exact Fin.ext hii.symm
    · right
      have hi1 : (i : ℕ) = i' + 1 := by omega
      rcases prev_succ i with ⟨hs, -⟩ | ⟨-, hz⟩
      · have := congrArg Fin.val hs
        rw [Fin.val_succ, Fin.val_castSucc] at this
        exact Fin.ext (by omega)
      · omega
  · -- the previous period: `i` is the first sector
    simp only [Int.cast_neg, Int.cast_one] at hm1 hm2
    have hsucc : d i'.succ = d (Fin.last n) := by rw [hlast]; linarith
    have hi'succ : i'.succ = Fin.last n := hmono.injective hsucc
    have hi0 : d i.castSucc = d 0 := by linarith
    have hi0' : i.castSucc = 0 := hmono.injective hi0
    have hiz : (i : ℕ) = 0 := by simpa using congrArg Fin.val hi0'
    right
    rcases prev_succ i with ⟨-, hne⟩ | ⟨hs, -⟩
    · exact absurd hiz hne
    · exact Fin.succ_injective _ (hi'succ.trans hs.symm)

end HadwigerNelson.Plane
