import Proofs.HadwigerNelson.Arith.DyadicQuadratic
/-! FS131-ID1 — a strengthening the skeleton's statement does not need, checked so that the report can say it at its
grade: `colorable_two_planeOver_sqrt` asks `Squarefree m` and `m % 4 ≠ 3`; **`m % 4 = 1 ∨ m % 4 = 2` is enough** (a
square `m ≡ 1 (mod 4)` gives `ℚ(√m) = ℚ ⊆ ℚ(√2)`), and squarefree with `m % 4 ≠ 3` implies it.  Never part of the
library; run after the build: `lake env lean data/fs131/id1/probes/two_colour_wider.lean`. -/
open HadwigerNelson HadwigerNelson.SpectralChain HadwigerNelson.SquareClass HadwigerNelson.DyadicQuadratic SimpleGraph

namespace FS131ID1Probe

/-- The wider form: no squarefreeness. -/
theorem colorable_two_planeOver_sqrt_of_mod_four {m : ℕ} (h : m % 4 = 1 ∨ m % 4 = 2) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 2 := by
  have key : ∀ {k : ℕ}, (∃ (Λ : AddSubgroup ℂ) (ψ : Λ →+ ZMod 2),
      ∀ u ∈ unitVectors (fieldOfRadicands {k}), ∃ hu : u ∈ Λ, ψ ⟨u, hu⟩ ≠ 0) →
      ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {k}))).Colorable 2 := by
    rintro k ⟨Λ, ψ, h⟩
    have hcol := colorable_planeOver_of_addMonoidHom ψ h
    rwa [Nat.card_zmod] at hcol
  rcases h with h1 | h2
  · by_cases hsq : IsSquare m
    · obtain ⟨r, rfl⟩ := hsq
      have hle : fieldOfRadicands {r * r} ≤ fieldOfRadicands {2} := by
        refine Subfield.closure_le.mpr ?_
        rintro x ⟨d, hd, rfl⟩
        rw [Set.mem_singleton_iff] at hd
        subst hd
        simp only [Nat.cast_mul, Real.sqrt_mul_self (Nat.cast_nonneg r)]
        exact natCast_mem _ r
      have hsub : planeOver (fieldOfRadicands {r * r}) ⊆ planeOver (fieldOfRadicands {2}) :=
        fun z hz => ⟨hle hz.1, hle hz.2⟩
      exact SimpleGraph.Colorable.of_hom (SimpleGraph.induceHomOfLE _ hsub).toHom
        (key (exists_addMonoidHom_two_mod_four (by norm_num)))
    · exact key (exists_addMonoidHom_one_mod_four h1 hsq)
  · exact key (exists_addMonoidHom_two_mod_four h2)

/-- The skeleton's hypotheses imply the wider one. -/
theorem mod_four_of_squarefree {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) : m % 4 = 1 ∨ m % 4 = 2 := by
  have h0 : m % 4 ≠ 0 := fun h0 => absurd (Nat.isUnit_iff.mp (hm 2 ⟨m / 4, by omega⟩)) (by norm_num)
  omega

/-- The wider form holds where the skeleton's does not apply: `m = 9` (not squarefree), `m = 18`. -/
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {9}))).Colorable 2 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {18}))).Colorable 2 :=
  ⟨colorable_two_planeOver_sqrt_of_mod_four (by norm_num), colorable_two_planeOver_sqrt_of_mod_four (by norm_num)⟩

end FS131ID1Probe
#print axioms FS131ID1Probe.colorable_two_planeOver_sqrt_of_mod_four
#print axioms FS131ID1Probe.mod_four_of_squarefree
