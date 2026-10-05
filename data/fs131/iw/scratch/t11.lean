import Mathlib
example (n : ℕ) (hn : 2 ≤ n) (i : Fin n) : finRotate n i ≠ i := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  intro h
  rw [finRotate_apply] at h
  have : (1 : Fin (m + 1)) = 0 := by simpa using h
  rw [Fin.one_eq_zero_iff] at this
  omega
