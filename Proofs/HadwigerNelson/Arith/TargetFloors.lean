import Proofs.HadwigerNelson.Arith.Floor128
import Proofs.HadwigerNelson.Arith.FloorPlanes

/-!
# `StandingFloor 7`: the finite-target floor of the standing five, from its two rows (FS-131 wave 10, second pass)

**Read aloud, against the informal claim.** `StandingFive.StandingFloor n` is the hypothesis TC1-STANDING-FIVE's "so
`L(F) ≥ 7`" hid (FS131-K10's statement defect; G56): the floor at `U₁₂₈` and at every `Γ_Q`, `Q ≡ 3 (mod 4)`, `Q ≥ 347`.
Here it is a theorem over **one** named classical hypothesis — Weil's bound for Kloosterman sums at the finite fields of
`q ≡ 3 (mod 4)`, `q ≥ 347` elements (`StandingFive.KloostermanBound`) — from `Floor128.targetFloor_seven_128` (no outside
theorem) and `StandingFive.targetFloor_seven_of_kloosterman`.

At the wave's join, `StandingFive.seven_le_localBound` and `five_le_chromaticNumber` lose their floor hypothesis to
`seven_le_localBound_of_kloosterman` and `standingFloor_five`.

**Inhabitant of the hypothesis.** `KloostermanBound` is satisfiable at small fields
(`kloostermanBound_of_card_le_five`); at the fields the floor reads it is Weil's theorem, not in the kernel.
-/

namespace HadwigerNelson.StandingFive

/-- The floor is monotone in the number of colours. -/
theorem targetFloor_mono {n n' Q : ℕ} (h : n ≤ n') (hf : TargetFloor n' Q) : TargetFloor n Q := by
  intro k _ _ σ hσ hne hcard
  exact le_trans (by exact_mod_cast h) (hf k σ hσ hne hcard)

theorem standingFloor_mono {n n' : ℕ} (h : n ≤ n') (hf : StandingFloor n') : StandingFloor n :=
  ⟨targetFloor_mono h hf.1, fun Q hQ4 hQ => targetFloor_mono h (hf.2 Q hQ4 hQ)⟩

/-- **The finite-target floor at seven**, over Weil's bound for Kloosterman sums at the fields of `q ≡ 3 (mod 4)`,
`q ≥ 347` elements. -/
theorem standingFloor_seven
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F % 4 = 3 → 347 ≤ Fintype.card F →
      KloostermanBound F) :
    StandingFloor 7 :=
  ⟨Floor128.targetFloor_seven_128, fun Q hQ4 hQ =>
    targetFloor_seven_of_kloosterman hQ4 (by omega) fun F _ _ _ hF => hK F (by rw [hF]; exact hQ4) (by rw [hF]; exact hQ)⟩

/-- The floor at five, the form `five_le_chromaticNumber` reads. -/
theorem standingFloor_five
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F % 4 = 3 → 347 ≤ Fintype.card F →
      KloostermanBound F) :
    StandingFloor 5 :=
  standingFloor_mono (by norm_num) (standingFloor_seven hK)

/-- **"so `L(F) ≥ 7`"**, over Weil's bound alone (and `StandingFive`'s own leaves). -/
theorem seven_le_localBound_of_kloosterman
    (hK : ∀ (F : Type) [Field F] [Fintype F] [DecidableEq F], Fintype.card F % 4 = 3 → 347 ≤ Fintype.card F →
      KloostermanBound F) :
    7 ≤ SpectralChain.localBound standingField :=
  seven_le_localBound (standingFloor_seven hK)

/-! ## Spec -/

-- `targetFloor_mono` at the bottom: any floor gives the floor at zero.
example (Q : ℕ) (h : TargetFloor 7 Q) : TargetFloor 0 Q := targetFloor_mono (Nat.zero_le 7) h

end HadwigerNelson.StandingFive
