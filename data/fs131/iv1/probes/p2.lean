import Proofs.HadwigerNelson.Arith.UpperHalf
example (z : ℂ) (a b : ℚ) (ha : z.re = a) (hb : z.im = b) : ((2 * a : ℚ) : ℂ) = z + (starRingEnd ℂ) z := by
  rw [Complex.add_conj, ha]
  push_cast
  rfl
example (z : ℂ) (a b : ℚ) (ha : z.re = a) (hb : z.im = b) : ((2 * a : ℚ) : ℂ) = z + (starRingEnd ℂ) z := by
  rw [Complex.add_conj, ha]
  norm_cast
example (z : ℂ) (a b : ℚ) (ha : z.re = a) (hb : z.im = b) :
    ((2 * b : ℚ) : ℂ) = ((starRingEnd ℂ) z - z) * Complex.I := by
  rw [← neg_sub, Complex.sub_conj, hb]
  push_cast
  linear_combination (2 * (b : ℂ)) * Complex.I_sq
example (z : ℂ) (a b : ℚ) (ha : z.re = a) (hb : z.im = b) :
    ((2 * b : ℚ) : ℂ) = ((starRingEnd ℂ) z - z) * Complex.I := by
  apply Complex.ext
  · simp [ha, hb]
    trace_state
    sorry
  · simp [ha, hb]
    trace_state
    sorry
