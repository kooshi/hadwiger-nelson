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

/-! Private helpers for the fold cover: lattice points, the grid squares a periodized set is a union of, and the
count of the translates of a periodic union of grid squares that hold a point. -/

/-- The point `(a h, b h)` of the plane. -/
private noncomputable def latPt (h a b : ℝ) : ℂ := ((a * h : ℝ) : ℂ) + ((b * h : ℝ) : ℂ) * Complex.I

private theorem latPt_re (h a b : ℝ) : (latPt h a b).re = a * h := by simp [latPt]

private theorem latPt_im (h a b : ℝ) : (latPt h a b).im = b * h := by simp [latPt]

/-- In a union of `h`-grid squares, membership depends only on the square. -/
private theorem mem_iff_of_floor_eq {h : ℝ} {V : Set ℂ} (hV : IsGridUnion h V) {y z : ℂ}
    (hre : ⌊y.re / h⌋ = ⌊z.re / h⌋) (him : ⌊y.im / h⌋ = ⌊z.im / h⌋) : y ∈ V ↔ z ∈ V :=
  ⟨fun hy => hV y hy ⟨hre.symm, him.symm⟩, fun hz => hV z hz ⟨hre, him⟩⟩

private theorem floor_latPt_re {h : ℝ} (hh : 0 < h) (A B : ℤ) : ⌊(latPt h A B).re / h⌋ = A := by
  rw [latPt_re, mul_div_assoc, div_self hh.ne', mul_one, Int.floor_intCast]

private theorem floor_latPt_im {h : ℝ} (hh : 0 < h) (A B : ℤ) : ⌊(latPt h A B).im / h⌋ = B := by
  rw [latPt_im, mul_div_assoc, div_self hh.ne', mul_one, Int.floor_intCast]

/-- A periodized set is invariant under the lattice shifts. -/
private theorem add_mem_periodize_iff {T : Set ℂ} {L : ℝ} (x : ℂ) (m n : ℤ) :
    x + latPt L m n ∈ periodize T L ↔ x ∈ periodize T L := by
  constructor
  · rintro ⟨m', n', h⟩
    exact ⟨m' - m, n' - n, by convert h using 1; simp only [latPt]; push_cast; ring⟩
  · rintro ⟨m', n', h⟩
    exact ⟨m' + m, n' + n, by convert h using 1; simp only [latPt]; push_cast; ring⟩

/-- A periodized union of `h`-grid squares at period `K h` holds a point exactly when it holds the corner of the
point's square reduced modulo `K`. -/
private theorem mem_periodize_iff_corner {T : Set ℂ} {h : ℝ} {K : ℕ} [NeZero K] (A B : ℤ) :
    latPt h A B ∈ periodize T (K * h) ↔
      latPt h (((A : ZMod K).val : ℕ) : ℝ) (((B : ZMod K).val : ℕ) : ℝ) ∈ periodize T (K * h) := by
  have hA : ((((A : ZMod K).val : ℕ) : ℤ) : ℝ) = ((A % (K : ℤ) : ℤ) : ℝ) := by rw [ZMod.val_intCast]
  have hB : ((((B : ZMod K).val : ℕ) : ℤ) : ℝ) = ((B % (K : ℤ) : ℤ) : ℝ) := by rw [ZMod.val_intCast]
  push_cast at hA hB
  rw [hA, hB]
  have hAe : (A : ℝ) = ((A % (K : ℤ) : ℤ) : ℝ) + ((A / (K : ℤ) : ℤ) : ℝ) * K := by
    exact_mod_cast (show A = A % (K : ℤ) + A / (K : ℤ) * K from (Int.emod_add_ediv_mul A K).symm)
  have hBe : (B : ℝ) = ((B % (K : ℤ) : ℤ) : ℝ) + ((B / (K : ℤ) : ℤ) : ℝ) * K := by
    exact_mod_cast (show B = B % (K : ℤ) + B / (K : ℤ) * K from (Int.emod_add_ediv_mul B K).symm)
  have he : latPt h A B = latPt h ((A % (K : ℤ) : ℤ) : ℝ) ((B % (K : ℤ) : ℤ) : ℝ) +
      latPt ((K : ℝ) * h) ((A / (K : ℤ) : ℤ) : ℝ) ((B / (K : ℤ) : ℤ) : ℝ) := by
    apply Complex.ext <;> simp only [Complex.add_re, Complex.add_im, latPt_re, latPt_im]
    · rw [hAe]; ring
    · rw [hBe]; ring
  rw [he, add_mem_periodize_iff]

/-- A point's translate by the lattice point `(i h, j h)` lies in the periodized set exactly when the corner indexed by
`(⌊x/h⌋ − i, ⌊y/h⌋ − j)` modulo `K` does. -/
private theorem sub_mem_iff {T : Set ℂ} {h : ℝ} (hh : 0 < h) {K : ℕ} [NeZero K]
    (hV : IsGridUnion h (periodize T (K * h))) (x : ℂ) (p : ZMod K × ZMod K) :
    x - latPt h p.1.val p.2.val ∈ periodize T (K * h) ↔
      latPt h ((((⌊x.re / h⌋ : ℤ) : ZMod K) - p.1).val : ℝ) ((((⌊x.im / h⌋ : ℤ) : ZMod K) - p.2).val : ℝ) ∈
        periodize T (K * h) := by
  have h1 : ⌊(x - latPt h p.1.val p.2.val).re / h⌋ = ⌊x.re / h⌋ - (p.1.val : ℤ) := by
    rw [Complex.sub_re, latPt_re, sub_div, mul_div_assoc, div_self hh.ne', mul_one, Int.floor_sub_natCast]
  have h2 : ⌊(x - latPt h p.1.val p.2.val).im / h⌋ = ⌊x.im / h⌋ - (p.2.val : ℤ) := by
    rw [Complex.sub_im, latPt_im, sub_div, mul_div_assoc, div_self hh.ne', mul_one, Int.floor_sub_natCast]
  rw [mem_iff_of_floor_eq hV (z := latPt h (⌊x.re / h⌋ - (p.1.val : ℤ) : ℤ) (⌊x.im / h⌋ - (p.2.val : ℤ) : ℤ))
    (by rw [h1, floor_latPt_re hh]) (by rw [h2, floor_latPt_im hh]), mem_periodize_iff_corner]
  have e1 : (((⌊x.re / h⌋ - (p.1.val : ℤ) : ℤ)) : ZMod K) = ((⌊x.re / h⌋ : ℤ) : ZMod K) - p.1 := by
    push_cast; rw [ZMod.natCast_zmod_val]
  have e2 : (((⌊x.im / h⌋ - (p.2.val : ℤ) : ℤ)) : ZMod K) = ((⌊x.im / h⌋ : ℤ) : ZMod K) - p.2 := by
    push_cast; rw [ZMod.natCast_zmod_val]
  rw [e1, e2]

open Classical in
/-- **The count**: every point of the plane lies in the same number of the `K²` translates of a periodized union of
`h`-grid squares at period `K h` by the lattice points `(i h, j h)` — the number of corners of a period it holds. -/
private theorem card_sub_mem {T : Set ℂ} {h : ℝ} (hh : 0 < h) {K : ℕ} [NeZero K]
    (hV : IsGridUnion h (periodize T (K * h))) (x : ℂ) :
    (Finset.univ.filter fun p : ZMod K × ZMod K => x - latPt h p.1.val p.2.val ∈ periodize T (K * h)).card =
      (Finset.univ.filter fun p : ZMod K × ZMod K => latPt h p.1.val p.2.val ∈ periodize T (K * h)).card := by
  set s : ZMod K × ZMod K := (((⌊x.re / h⌋ : ℤ) : ZMod K), ((⌊x.im / h⌋ : ℤ) : ZMod K)) with hs
  refine Finset.card_nbij' (fun p => s - p) (fun p => s - p) ?_ ?_ ?_ ?_
  · intro p hp
    simp only [Finset.coe_filter, Finset.mem_univ, true_and, mem_setOf_eq] at hp ⊢
    exact (sub_mem_iff hh hV x p).1 hp
  · intro p hp
    simp only [Finset.coe_filter, Finset.mem_univ, true_and, mem_setOf_eq] at hp ⊢
    refine (sub_mem_iff hh hV x (s - p)).2 ?_
    simpa [hs] using hp
  · intro p _
    simp
  · intro p _
    simp

open Classical in
/-- **The volume**: a union of `h`-grid squares inside a window of `N₀ × N₀` squares, `N₀ < K`, has area at most
`h²` times the number of corners of a period its periodization at `K h` holds. -/
private theorem volume_le_card_corners {T : Set ℂ} {h : ℝ} (hh : 0 < h) {K : ℕ} [NeZero K]
    (hT : IsGridUnion h T) {P Q : ℤ} {N₀ : ℕ} (hN₀ : N₀ < K)
    (hTw : T ⊆ squareWin (latPt h P Q) (N₀ * h)) :
    volume T ≤ (Finset.univ.filter fun p : ZMod K × ZMod K =>
      latPt h p.1.val p.2.val ∈ periodize T (K * h)).card * ENNReal.ofReal (h ^ 2) := by
  classical
  set Cs : Finset (ℤ × ℤ) := ((Finset.Ico P (P + N₀)) ×ˢ (Finset.Ico Q (Q + N₀))).filter
    fun AB => latPt h AB.1 AB.2 ∈ T with hCs
  have hcover : T ⊆ ⋃ AB ∈ Cs, squareWin (latPt h AB.1 AB.2) h := by
    intro y hy
    obtain ⟨w1, w2, w3, w4⟩ := hTw hy
    rw [latPt_re] at w1 w2
    rw [latPt_im] at w3 w4
    have hre : P ≤ ⌊y.re / h⌋ ∧ ⌊y.re / h⌋ < P + N₀ := by
      constructor
      · rw [Int.le_floor, le_div_iff₀ hh]; exact w1
      · rw [Int.floor_lt, div_lt_iff₀ hh]; push_cast; linarith
    have him : Q ≤ ⌊y.im / h⌋ ∧ ⌊y.im / h⌋ < Q + N₀ := by
      constructor
      · rw [Int.le_floor, le_div_iff₀ hh]; exact w3
      · rw [Int.floor_lt, div_lt_iff₀ hh]; push_cast; linarith
    have hmem : latPt h (⌊y.re / h⌋ : ℤ) (⌊y.im / h⌋ : ℤ) ∈ T :=
      (mem_iff_of_floor_eq hT (floor_latPt_re hh _ _).symm (floor_latPt_im hh _ _).symm).1 hy
    refine mem_iUnion₂.2 ⟨(⌊y.re / h⌋, ⌊y.im / h⌋), ?_, ?_⟩
    · simp only [hCs, Finset.mem_filter, Finset.mem_product, Finset.mem_Ico]
      exact ⟨⟨hre, him⟩, hmem⟩
    · have a1 := Int.floor_le (y.re / h)
      have a2 := Int.lt_floor_add_one (y.re / h)
      have a3 := Int.floor_le (y.im / h)
      have a4 := Int.lt_floor_add_one (y.im / h)
      rw [le_div_iff₀ hh] at a1 a3
      rw [div_lt_iff₀ hh] at a2 a4
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [latPt_re, latPt_im] <;> linarith
  have hcard : Cs.card ≤ (Finset.univ.filter fun p : ZMod K × ZMod K =>
      latPt h p.1.val p.2.val ∈ periodize T (K * h)).card := by
    refine Finset.card_le_card_of_injOn (fun AB => ((AB.1 : ZMod K), (AB.2 : ZMod K))) ?_ ?_
    · intro AB hAB
      simp only [hCs, Finset.coe_filter, Finset.mem_product, Finset.mem_Ico, mem_setOf_eq] at hAB
      simp only [Finset.coe_filter, Finset.mem_univ, true_and, mem_setOf_eq]
      exact (mem_periodize_iff_corner (T := T) (h := h) (K := K) AB.1 AB.2).1 ⟨0, 0, by simpa using hAB.2⟩
    · intro AB hAB AB' hAB' heq
      simp only [hCs, Finset.coe_filter, Finset.mem_product, Finset.mem_Ico, mem_setOf_eq] at hAB hAB'
      simp only [Prod.mk.injEq] at heq
      have k1 := (ZMod.intCast_eq_intCast_iff_dvd_sub _ _ _).1 heq.1
      have k2 := (ZMod.intCast_eq_intCast_iff_dvd_sub _ _ _).1 heq.2
      have hK : (N₀ : ℤ) < K := by exact_mod_cast hN₀
      have z1 := Int.eq_zero_of_abs_lt_dvd k1 (abs_lt.2 ⟨by omega, by omega⟩)
      have z2 := Int.eq_zero_of_abs_lt_dvd k2 (abs_lt.2 ⟨by omega, by omega⟩)
      exact Prod.ext (by omega) (by omega)
  calc volume T ≤ volume (⋃ AB ∈ Cs, squareWin (latPt h AB.1 AB.2) h) := measure_mono hcover
    _ ≤ ∑ AB ∈ Cs, volume (squareWin (latPt h AB.1 AB.2) h) := measure_biUnion_finset_le _ _
    _ = Cs.card * ENNReal.ofReal (h ^ 2) := by
        rw [Finset.sum_congr rfl fun AB _ => volume_squareWin _ hh.le, Finset.sum_const, nsmul_eq_mul]
    _ ≤ _ := by gcongr

/-- **Finitely many translates covering every point equally often** (C133-CHIF's open regularisation, grid squares
and count): below `m₁(ℝ²)` there are `N` sets with no two points at distance one such that every point of the plane
lies in at least `b` of them, with `b ≥ c N` and `b > 0`. -/
theorem exists_fold_cover {c : ℝ≥0∞} (hc : c < mOne) :
    ∃ (N b : ℕ) (U : Fin N → Set ℂ), 0 < b ∧ c * N ≤ b ∧ (∀ j, (unitDistance ℂ).IsIndepSet (U j)) ∧
      ∀ x : ℂ, b ≤ {j | x ∈ U j}.ncard := by
  classical
  -- a Borel independent set of upper density above `c` (its unit pairs are empty), and reals `a < b` between
  obtain ⟨A, hA⟩ := lt_iSup_iff.1 hc
  obtain ⟨hAm, hA'⟩ := lt_iSup_iff.1 hA
  obtain ⟨hAi, hAd⟩ := lt_iSup_iff.1 hA'
  have hAn : UnitPairsNull A := by
    have h0 : unitPairSet A = ∅ := by
      ext q
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro h1 h2
      exact (isIndepSet_unitDistance_iff.1 hAi) _ h1 _ h2 (by rw [dist_eq_norm]; simp)
    rw [UnitPairsNull, h0, measure_empty]
  obtain ⟨b, hb0, hcb, hbA⟩ := ENNReal.lt_iff_exists_real_btwn.1 hAd
  obtain ⟨a, ha0, hca, hab⟩ := ENNReal.lt_iff_exists_real_btwn.1 hcb
  have hab' : a < b := (ENNReal.ofReal_lt_ofReal_iff_of_nonneg ha0).1 hab
  set cm := (a + b) / 2 with hcm
  -- the window's side (as in `Plane.eventually_le_muPer`)
  set ℓ : ℕ := ⌈8 * a / (cm - a)⌉₊ + 1 with hℓdef
  have hℓ : 0 < ℓ := Nat.succ_pos _
  have hℓr : (1 : ℝ) ≤ ℓ := by exact_mod_cast hℓ
  have hℓc : 8 * a ≤ (cm - a) * ℓ := by
    have h1 : 8 * a / (cm - a) ≤ ℓ := by
      rw [hℓdef]; push_cast; linarith [Nat.le_ceil (8 * a / (cm - a))]
    rw [div_le_iff₀ (by rw [hcm]; linarith)] at h1
    linarith
  have hℓa : a * ((ℓ : ℝ) + 2) ^ 2 ≤ cm * (ℓ : ℝ) ^ 2 := by nlinarith
  obtain ⟨p, q, hW⟩ := exists_squareWin_dense hAm hbA ℓ hℓ
  set W := squareWin (((ℓ * p : ℝ) : ℂ) + ((ℓ * q : ℝ) : ℂ) * Complex.I) ℓ with hWdef
  -- almost every point of `A` is eventually kept
  set η : ℝ := 1 / 20 with hη
  have hη0 : 0 < η := by norm_num
  have hae : ∀ᵐ x ∂volume, x ∈ A → ∀ᶠ ε in 𝓝[>] (0 : ℝ), KeptAt A (η / 2) ε x :=
    (ae_restrict_iff' hAm).1 (ae_eventually_keptAt hAm (by positivity))
  set G : ℕ → Set ℂ := fun n => {x | x ∈ A ∩ W ∧ ∀ ε ∈ Ioo (0 : ℝ) (1 / ((n : ℝ) + 1)), KeptAt A (η / 2) ε x}
    with hG
  have hGmono : Monotone G := by
    intro n m hnm x ⟨hx, hk⟩
    refine ⟨hx, fun ε hε => hk ε ⟨hε.1, hε.2.trans_le ?_⟩⟩
    have : (n : ℝ) ≤ m := by exact_mod_cast hnm
    exact one_div_le_one_div_of_le (by positivity) (by linarith)
  have hSW : volume (A ∩ W) ≤ volume (⋃ n, G n) := by
    refine measure_mono_ae ?_
    filter_upwards [hae] with x hx hxSW
    obtain ⟨t, ht, hts⟩ := (nhdsGT_basis (0 : ℝ)).eventually_iff.1 (hx hxSW.1)
    obtain ⟨n, hn⟩ := exists_nat_one_div_lt ht
    exact mem_iUnion.2 ⟨n, hxSW, fun ε hε => hts ⟨hε.1, hε.2.trans hn⟩⟩
  rw [hGmono.measure_iUnion] at hSW
  have hcb' : ENNReal.ofReal (cm * (ℓ : ℝ) ^ 2) < volume (A ∩ W) := by
    refine lt_of_lt_of_le ?_ hW
    have : (0 : ℝ) < (ℓ : ℝ) ^ 2 := by positivity
    rw [ENNReal.ofReal_lt_ofReal_iff (mul_pos (by linarith) this)]
    nlinarith
  obtain ⟨n, hn⟩ := lt_iSup_iff.1 (hcb'.trans_le hSW)
  -- the scale and the pixel
  set ε₀ : ℝ := 1 / (2 * ((n : ℝ) + 1)) with hε₀
  have hε₀0 : 0 < ε₀ := by positivity
  have hε₀n : ε₀ < 1 / ((n : ℝ) + 1) := by
    rw [hε₀]; exact one_div_lt_one_div_of_lt (by positivity) (by linarith [(by positivity : (0 : ℝ) ≤ n)])
  have hε₀1 : ε₀ < 1 := by
    refine hε₀n.trans_le ?_
    rw [div_le_one (by positivity)]; linarith [(by positivity : (0 : ℝ) ≤ n)]
  set M : ℕ := ⌈12 * √2 / (η * ε₀)⌉₊ + 1 with hMdef
  have hM : (0 : ℝ) < M := by positivity
  have hMh : (1 / (M : ℝ)) * √2 ≤ η * ε₀ / 12 := by
    have h1 : 12 * √2 / (η * ε₀) ≤ M := by
      rw [hMdef]; push_cast; linarith [Nat.le_ceil (12 * √2 / (η * ε₀))]
    rw [div_le_iff₀ (by positivity)] at h1
    rw [one_div_mul_eq_div, div_le_iff₀ hM]
    calc √2 = 12 * √2 / 12 := by ring
      _ ≤ (M * (η * ε₀)) / 12 := by gcongr
      _ = η * ε₀ / 12 * (M : ℝ) := by ring
  have hh : (0 : ℝ) < 1 / (M : ℝ) := one_div_pos.2 hM
  obtain ⟨T, -, hTg, hTw, hTk, hTc⟩ := exists_tiled_kept (C := fun _ : Fin 1 => A) hh hMh hη0.le (by norm_num)
    hε₀0 ((ℓ : ℤ) * M * p) ((ℓ : ℤ) * M * q) (ℓ * M)
  have hTw0 := hTw 0
  have e1 : ((((ℓ : ℤ) * M * p : ℤ) : ℝ) * (1 / (M : ℝ))) = (ℓ : ℝ) * p := by push_cast; field_simp
  have e2 : ((((ℓ : ℤ) * M * q : ℤ) : ℝ) * (1 / (M : ℝ))) = (ℓ : ℝ) * q := by push_cast; field_simp
  have e3 : (((ℓ * M : ℕ) : ℝ) * (1 / (M : ℝ))) = (ℓ : ℝ) := by push_cast; field_simp
  rw [e1, e2, e3] at hTw hTc
  -- the kept squares are band-free, so their copies at period `ℓ + 2` hold no two points at distance one
  have hπ : η < 1 / (1 + 4 * Real.pi) := by
    rw [hη, div_lt_div_iff₀ (by norm_num) (by positivity)]
    linarith [Real.pi_lt_four]
  have hTb : BandFree (T 0) ε₀ := fun x hx y hy =>
    keptAt_band hAm hAn hη0.le hπ hε₀0 (hTk 0 hx) (hTk 0 hy)
  set K : ℕ := (ℓ + 2) * M with hKdef
  haveI : NeZero K := ⟨by positivity⟩
  have hKh : (K : ℝ) * (1 / (M : ℝ)) = (ℓ : ℝ) + 2 := by rw [hKdef]; push_cast; field_simp
  set V := periodize (T 0) ((K : ℝ) * (1 / (M : ℝ))) with hV
  have hVg : IsGridUnion (1 / (M : ℝ)) V := isGridUnion_periodize hh (hTg 0)
  have hVi : ∀ x ∈ V, ∀ y ∈ V, dist x y ≠ 1 := by
    intro x hx y hy
    rw [hV, hKh] at hx hy
    rcases bandFree_periodize (hTw 0) hε₀1 hTb x hx y hy with h1 | h1
    · linarith
    · linarith
  -- the count of translates, and the area of the kept squares
  set n' := (Finset.univ.filter fun p : ZMod K × ZMod K =>
    latPt (1 / (M : ℝ)) p.1.val p.2.val ∈ V).card with hn'
  have hN₀ : ℓ * M < K := by rw [hKdef]; nlinarith
  have hvol : volume (T 0) ≤ n' * ENNReal.ofReal ((1 / (M : ℝ)) ^ 2) :=
    volume_le_card_corners hh (hTg 0) hN₀ (P := (ℓ : ℤ) * M * p) (Q := (ℓ : ℤ) * M * q) hTw0
  have hGT : G n ⊆ T 0 := by
    rintro x ⟨⟨-, hxW⟩, hk⟩
    obtain ⟨j, hj⟩ := mem_iUnion.1 (hTc ⟨hxW, mem_iUnion.2 ⟨0, hk ε₀ ⟨hε₀0, hε₀n⟩⟩⟩)
    rwa [Subsingleton.elim j 0] at hj
  -- `a K² < n'`
  have hreal : a * (K : ℝ) ^ 2 < n' := by
    have h1 : ENNReal.ofReal (cm * (ℓ : ℝ) ^ 2) < ENNReal.ofReal (n' * (1 / (M : ℝ)) ^ 2) := by
      calc ENNReal.ofReal (cm * (ℓ : ℝ) ^ 2) < volume (G n) := hn
        _ ≤ volume (T 0) := measure_mono hGT
        _ ≤ n' * ENNReal.ofReal ((1 / (M : ℝ)) ^ 2) := hvol
        _ = ENNReal.ofReal (n' * (1 / (M : ℝ)) ^ 2) := by
            rw [ENNReal.ofReal_mul (Nat.cast_nonneg _), ENNReal.ofReal_natCast]
    have h2 := (ENNReal.ofReal_lt_ofReal_iff'.1 h1).1
    have h3 : cm * (ℓ : ℝ) ^ 2 * (M : ℝ) ^ 2 < n' := by
      have := mul_lt_mul_of_pos_right h2 (by positivity : (0 : ℝ) < (M : ℝ) ^ 2)
      rwa [mul_assoc (n' : ℝ), ← mul_pow, one_div_mul_cancel hM.ne', one_pow, mul_one] at this
    have h4 : (K : ℝ) = ((ℓ : ℝ) + 2) * M := by rw [hKdef]; push_cast; ring
    rw [h4]
    nlinarith [mul_le_mul_of_nonneg_right hℓa (by positivity : (0 : ℝ) ≤ (M : ℝ) ^ 2)]
  have hn'pos : 0 < n' := by
    have : (0 : ℝ) < n' := lt_of_le_of_lt (by positivity) hreal
    exact_mod_cast this
  -- the translates, indexed by `Fin (K²)`
  set e := (Fintype.equivFin (ZMod K × ZMod K)).symm with he
  refine ⟨Fintype.card (ZMod K × ZMod K), n',
    fun j => {x | x - latPt (1 / (M : ℝ)) (e j).1.val (e j).2.val ∈ V}, hn'pos, ?_, ?_, ?_⟩
  · -- `c K² ≤ n'`
    rw [Fintype.card_prod, ZMod.card]
    calc c * ((K * K : ℕ) : ℝ≥0∞) ≤ ENNReal.ofReal a * ((K * K : ℕ) : ℝ≥0∞) := by gcongr
      _ = ENNReal.ofReal (a * (K : ℝ) ^ 2) := by
          rw [ENNReal.ofReal_mul ha0, ← ENNReal.ofReal_natCast]; push_cast; ring_nf
      _ ≤ ENNReal.ofReal (n' : ℝ) := ENNReal.ofReal_le_ofReal hreal.le
      _ = n' := ENNReal.ofReal_natCast _
  · -- each translate holds no two points at distance one
    intro j
    refine isIndepSet_unitDistance_iff.2 fun x hx y hy hxy => hVi _ hx _ hy ?_
    rw [dist_sub_right]
    exact hxy
  · -- every point lies in `n'` of them
    intro x
    have hset : {j | x ∈ (fun j => {x | x - latPt (1 / (M : ℝ)) (e j).1.val (e j).2.val ∈ V}) j} =
        ((Finset.univ.filter fun j : Fin (Fintype.card (ZMod K × ZMod K)) =>
          x - latPt (1 / (M : ℝ)) (e j).1.val (e j).2.val ∈ V : Finset _) : Set _) := by
      ext j
      simp
    have hc' := card_sub_mem hh hVg x
    rw [← hV] at hc'
    rw [hset, Set.ncard_coe_finset, hn', ← hc']
    refine (Finset.card_nbij' (fun j => e j) (fun p => e.symm p) ?_ ?_ ?_ ?_).symm.le
    · intro j hj
      simpa using hj
    · intro p hp
      simpa using hp
    · intro j _
      simp
    · intro p _
      simp

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

/-- **C133-ONE, second line, the plane**: `χ_f(ℝ²) = 1 / m₁(ℝ²)`. Rests on `[OAIMath2026]`'s ported theorem
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
