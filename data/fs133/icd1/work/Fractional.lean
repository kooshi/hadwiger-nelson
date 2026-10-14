import Proofs.HadwigerNelson.Plane.OneClass.Algebraic

/-!
# The fractional chromatic number of the plane is `1 / m₁(ℝ²)` (FS-133)

The derivation's entries C133-CHIF and C133-ONE, second line (`plans/FS133-E1-derivation.md`, stage 5):
`χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1 / m₁(ℝ²)`. `SimpleGraph.fractionalChromaticNumber` (`Fractional.lean`) is the
infimum of `n / b` over the `b`-fold colourings with `n` colours — `[Johnson1996fcn]`'s form; `[MatolcsiEtAl2025]`
p. 4's (finitely many independent sets with real weights) is the same number, by rounding the weights up to
rationals, and that is not proved here. `χ_f,0` is the supremum over the finite point sets.

* `exists_periodic_indep` — periodisation (the first half of C133-PER);
* `exists_fold_cover` — the regularisation, the grid squares and the count;
* `fractionalChromaticNumber_plane_le` — **C133-CHIF**: `χ_f(ℝ²) ≤ 1 / m₁(ℝ²)`;
* the three equalities.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral SimpleGraph

/-- **Periodisation** (C133-PER, first half): below `m₁(ℝ²)` there is a Borel set with no two points at distance
one that is periodic under `L ℤ²` for an integer `L ≥ 1`, of density more than `c` — its part in one period square
has measure more than `c L²`. -/
theorem exists_periodic_indep {c : ℝ≥0∞} (hc : c < mOne) :
    ∃ (A : Set ℂ) (L : ℕ), 0 < L ∧ MeasurableSet A ∧ (unitDistance ℂ).IsIndepSet A ∧
      IsPeriodicSet (L : ℝ) A ∧
      c * ENNReal.ofReal ((L : ℝ) ^ 2) < volume (A ∩ {z : ℂ | z.re ∈ Ico 0 (L : ℝ) ∧ z.im ∈ Ico 0 (L : ℝ)}) := by
  -- a Borel independent set of upper density above `c`, and two reals between
  obtain ⟨A₀, hA₀⟩ := lt_iSup_iff.1 hc
  obtain ⟨hA₀m, hA₀'⟩ := lt_iSup_iff.1 hA₀
  obtain ⟨hA₀i, hA₀d⟩ := lt_iSup_iff.1 hA₀'
  obtain ⟨b, hb0, hcb, hbA⟩ := ENNReal.lt_iff_exists_real_btwn.1 hA₀d
  obtain ⟨a, ha0, hca, hab⟩ := ENNReal.lt_iff_exists_real_btwn.1 hcb
  have hab' : a < b := (ENNReal.ofReal_lt_ofReal_iff_of_nonneg ha0).1 hab
  -- a window of integer side `ℓ`, so large that cutting the copies `2` apart costs less than `b − a`
  set ℓ : ℕ := ⌈8 * a / (b - a)⌉₊ + 1 with hℓdef
  have hℓ : 0 < ℓ := Nat.succ_pos _
  have hℓr : (1 : ℝ) ≤ ℓ := by exact_mod_cast hℓ
  have hℓc : 8 * a ≤ (b - a) * ℓ := by
    have h1 : 8 * a / (b - a) ≤ ℓ := by
      rw [hℓdef]; push_cast; linarith [Nat.le_ceil (8 * a / (b - a))]
    rw [div_le_iff₀ (by linarith)] at h1
    linarith
  have hℓa : a * ((ℓ : ℝ) + 2) ^ 2 ≤ b * (ℓ : ℝ) ^ 2 := by nlinarith
  obtain ⟨p, q, hW⟩ := exists_squareWin_dense hA₀m hbA ℓ hℓ
  set z : ℂ := ((ℓ * p : ℝ) : ℂ) + ((ℓ * q : ℝ) : ℂ) * Complex.I with hz
  -- the window's part of `A₀`, moved to `1 + i`, and its copies at period `ℓ + 2`
  set w : ℂ := z - (1 + Complex.I) with hw
  set T : Set ℂ := (fun x => x + w) ⁻¹' (A₀ ∩ squareWin z ℓ) with hT
  have hTm : MeasurableSet T := measurable_add_const w (hA₀m.inter (measurableSet_squareWin z ℓ))
  have hTw : T ⊆ squareWin (1 + Complex.I) ℓ := by
    intro x hx
    obtain ⟨-, h1, h2, h3, h4⟩ := hx
    simp only [hw, Complex.add_re, Complex.sub_re, Complex.add_im, Complex.sub_im, Complex.one_re,
      Complex.one_im, Complex.I_re, Complex.I_im] at h1 h2 h3 h4
    refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im,
      Complex.I_re, Complex.I_im] <;> linarith
  have hTb : BandFree T 0 := by
    intro x hx y hy
    have hd : dist x y ≠ 1 := by
      rw [← dist_add_right x y w]
      exact (isIndepSet_unitDistance_iff.1 hA₀i) _ hx.1 _ hy.1
    rcases lt_or_gt_of_ne hd with h | h
    · left; linarith
    · right; linarith
  have hL : (((ℓ + 2 : ℕ)) : ℝ) = (ℓ : ℝ) + 2 := by push_cast; ring
  refine ⟨periodize T ((ℓ : ℝ) + 2), ℓ + 2, by omega, measurableSet_periodize hTm _, ?_, ?_, ?_⟩
  · refine isIndepSet_unitDistance_iff.2 fun x hx y hy => ?_
    rcases bandFree_periodize hTw zero_lt_one hTb x hx y hy with h | h
    · linarith
    · linarith
  · rw [hL]
    exact isPeriodicSet_periodize T _
  · -- the copy at the origin lies in the period square
    have hsub : T ⊆ periodize T ((ℓ : ℝ) + 2) ∩
        {z : ℂ | z.re ∈ Ico 0 (((ℓ + 2 : ℕ)) : ℝ) ∧ z.im ∈ Ico 0 (((ℓ + 2 : ℕ)) : ℝ)} := by
      intro x hx
      refine ⟨⟨0, 0, by simpa using hx⟩, ?_⟩
      obtain ⟨h1, h2, h3, h4⟩ := hTw hx
      simp only [Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, Complex.I_re,
        Complex.I_im] at h1 h2 h3 h4
      rw [hL]
      exact ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩⟩
    have hvT : volume T = volume (A₀ ∩ squareWin z ℓ) := measure_preimage_add_right _ _ _
    have hpos : (0 : ℝ) < (((ℓ + 2 : ℕ)) : ℝ) ^ 2 := by positivity
    calc c * ENNReal.ofReal ((((ℓ + 2 : ℕ)) : ℝ) ^ 2) < ENNReal.ofReal a * ENNReal.ofReal ((((ℓ + 2 : ℕ)) : ℝ) ^ 2) :=
          by rw [mul_comm c, mul_comm (ENNReal.ofReal a)]
             exact ENNReal.mul_lt_mul_right (ENNReal.ofReal_pos.2 hpos).ne' ENNReal.ofReal_ne_top hca
      _ = ENNReal.ofReal (a * ((ℓ : ℝ) + 2) ^ 2) := by rw [← ENNReal.ofReal_mul ha0, hL]
      _ ≤ ENNReal.ofReal (b * (ℓ : ℝ) ^ 2) := ENNReal.ofReal_le_ofReal hℓa
      _ ≤ volume (A₀ ∩ squareWin z ℓ) := hW
      _ = volume T := hvT.symm
      _ ≤ _ := measure_mono hsub

/-- **Finitely many translates covering every point equally often** (C133-CHIF's open regularisation, grid squares
and count): below `m₁(ℝ²)` there are `N` sets with no two points at distance one such that every point of the plane
lies in at least `b` of them, with `b ≥ c N` and `b > 0`. -/
theorem exists_fold_cover {c : ℝ≥0∞} (hc : c < mOne) :
    ∃ (N b : ℕ) (U : Fin N → Set ℂ), 0 < b ∧ c * N ≤ b ∧ (∀ j, (unitDistance ℂ).IsIndepSet (U j)) ∧
      ∀ x : ℂ, b ≤ {j | x ∈ U j}.ncard := by
  sorry

/-- **C133-CHIF**: `χ_f(ℝ²) ≤ 1 / m₁(ℝ²)`. Needs no outside theorem. -/
theorem fractionalChromaticNumber_plane_le : (unitDistance ℂ).fractionalChromaticNumber ≤ mOne⁻¹ := by
  classical
  -- below `m₁`, the fold cover is a `b`-fold colouring with `N` colours, `N / b ≤ c⁻¹`
  have key : ∀ c : ℝ≥0∞, c < mOne → (unitDistance ℂ).fractionalChromaticNumber ≤ c⁻¹ := by
    intro c hc
    obtain ⟨N, b, U, hb, hcb, hU, hcov⟩ := exists_fold_cover hc
    have hcol : (unitDistance ℂ).FractionalColorable b N := by
      refine ⟨fun x => Finset.univ.filter fun j => x ∈ U j, fun x => ?_, fun x y hxy => ?_⟩
      · have hset : ((Finset.univ.filter fun j => x ∈ U j : Finset (Fin N)) : Set (Fin N)) = {j | x ∈ U j} := by
          ext j
          simp
        rw [← Set.ncard_coe_finset, hset]
        exact hcov x
      · rw [Finset.disjoint_left]
        intro j hx hy
        exact (isIndepSet_unitDistance_iff.1 (hU j)) x (Finset.mem_filter.1 hx).2 y (Finset.mem_filter.1 hy).2
          (unitDistance_adj.1 hxy)
    refine (hcol.fractionalChromaticNumber_le hb).trans ?_
    have hb0 : (b : ℝ≥0∞) ≠ 0 := by exact_mod_cast hb.ne'
    rcases eq_or_ne c 0 with rfl | hc0
    · simp
    · rw [ENNReal.div_le_iff hb0 (ENNReal.natCast_ne_top _), ← ENNReal.div_eq_inv_mul,
        ENNReal.le_div_iff_mul_le (Or.inl hc0) (Or.inl (ne_top_of_lt hc)), mul_comm]
      exact hcb
  by_contra hcon
  push Not at hcon
  have h1 : (unitDistance ℂ).fractionalChromaticNumber⁻¹ < mOne := ENNReal.inv_lt_iff_inv_lt.2 hcon
  obtain ⟨c, hc1, hc2⟩ := exists_between h1
  have h2 := key c hc2
  have h3 : c⁻¹ < (unitDistance ℂ).fractionalChromaticNumber := ENNReal.inv_lt_iff_inv_lt.2 hc1
  exact absurd h2 (not_le.2 h3)

/-- The fractional chromatic number of an induced subgraph is at most the graph's. -/
theorem fractionalChromaticNumber_induce_le {V : Type*} (G : SimpleGraph V) (S : Set V) :
    (G.induce S).fractionalChromaticNumber ≤ G.fractionalChromaticNumber :=
  fractionalChromaticNumber_mono_of_hom (Embedding.induce S).toHom

/-- **C133-ONE, second line, the plane**: `χ_f(ℝ²) = 1 / m₁(ℝ²)`. Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem fractionalChromaticNumber_plane : (unitDistance ℂ).fractionalChromaticNumber = mOne⁻¹ := by
  refine le_antisymm fractionalChromaticNumber_plane_le ?_
  rw [← finIndepRatio_plane_eq_mOne]
  exact (inv_finIndepRatio_le_iSup_fractionalChromaticNumber _).trans
    (iSup_le fun S => fractionalChromaticNumber_induce_le _ _)

/-- **C133-ONE, second line, finite point sets**: `χ_f,0(ℝ²) = 1 / m₁(ℝ²)` — the supremum of the fractional
chromatic numbers of the finite unit-distance graphs of the plane. Rests on `Spectral.residual_fourier`. -/
theorem iSup_fractionalChromaticNumber_plane :
    (⨆ S : Finset ℂ, ((unitDistance ℂ).induce (S : Set ℂ)).fractionalChromaticNumber) = mOne⁻¹ := by
  refine le_antisymm ?_ ?_
  · exact (iSup_le fun S => fractionalChromaticNumber_induce_le _ _).trans fractionalChromaticNumber_plane_le
  · rw [← finIndepRatio_plane_eq_mOne]
    exact inv_finIndepRatio_le_iSup_fractionalChromaticNumber _

/-- **C133-ONE, second line, the algebraic plane**: `χ_f(𝒜²) = 1 / m₁(ℝ²)`. Rests on
`Spectral.residual_fourier`. -/
theorem fractionalChromaticNumber_algPlane : (unitDistance E).fractionalChromaticNumber = mOne⁻¹ := by
  refine le_antisymm ?_ ?_
  · exact (fractionalChromaticNumber_mono_of_hom algPlaneEmbedding.toHom).trans fractionalChromaticNumber_plane_le
  · rw [← finIndepRatio_algPlane_eq_mOne]
    exact (inv_finIndepRatio_le_iSup_fractionalChromaticNumber _).trans
      (iSup_le fun S => fractionalChromaticNumber_induce_le _ _)

end HadwigerNelson.OneClass
