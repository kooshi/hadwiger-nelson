import Proofs.HadwigerNelson.Rigidity.ChainAtTA

namespace HadwigerNelson.Rigidity

open MeasureTheory SimpleGraph SpectralChain SpectralInputs NumberField

open scoped Pointwise ENNReal

noncomputable section

variable (F : Subfield ℝ)

theorem noRamifiedStableDyadic_of_tca' [NumberField F] (h : TCA F) : NoRamifiedStableDyadic F := by
  intro P _ hram
  obtain ⟨c, hc, hb⟩ := h P
  obtain ⟨C⟩ := colorable_two_levelTarget_one_of_isRamified hram
  -- a colour class is independent
  have hind : ∀ (i : Fin 2) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ 1)), (∀ x ∈ s, C x = i) →
      (levelTarget P 1).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ 1)) := by
    intro i s hs x hx y hy _ hadj
    exact C.valid hadj ((hs x hx).trans (hs y hy).symm)
  rcases finite_or_infinite (𝓞 (fieldI F) ⧸ P.P ^ 1) with hQ | hQ
  · -- the two colour classes cover the residue field, so one holds at least half of it
    classical
    haveI := Fintype.ofFinite (𝓞 (fieldI F) ⧸ P.P ^ 1)
    set s0 := Finset.univ.filter fun x : 𝓞 (fieldI F) ⧸ P.P ^ 1 => C x = 0
    set s1 := Finset.univ.filter fun x : 𝓞 (fieldI F) ⧸ P.P ^ 1 => ¬ C x = 0
    have hsum : s0.card + s1.card = Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by
      rw [Finset.card_filter_add_card_filter_not, Finset.card_univ, Nat.card_eq_fintype_card]
    have h0 := hb 1 le_rfl s0 (hind 0 s0 fun x hx => (Finset.mem_filter.mp hx).2)
    have h1 := hb 1 le_rfl s1 (hind 1 s1 fun x hx => by
      have hx0 := (Finset.mem_filter.mp hx).2
      have : ∀ j : Fin 2, ¬ j = 0 → j = 1 := by decide
      exact this _ hx0)
    have hpos : (0 : ℝ) < Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by exact_mod_cast Nat.card_pos
    have hsumR : (s0.card : ℝ) + s1.card = Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by exact_mod_cast hsum
    have hlt : c * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) < 1 / 4 * Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
      mul_lt_mul_of_pos_right hc hpos
    linarith
  · -- an infinite quotient has `Nat.card` zero, and a single point is independent
    have h0 := hb 1 le_rfl {0} (by
      rw [Finset.coe_singleton]
      exact Set.pairwise_singleton _ _)
    rw [Nat.card_eq_zero_of_infinite, Finset.card_singleton] at h0
    norm_num at h0

end

end HadwigerNelson.Rigidity
