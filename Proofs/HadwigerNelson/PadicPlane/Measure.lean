import Proofs.HadwigerNelson.PadicPlane.Basic
import Mathlib.MeasureTheory.Measure.Haar.Basic
import Mathlib.NumberTheory.Padics.Hensel

/-!
# The measure step: a Borel colouring of the p-adic plane needs at least `1/c` colours (FS131-KPA1, proved by FS131-IQP1)

**Read aloud.** `ℤ_p²` carries its Borel σ-algebra (scoped here: Mathlib declares none on `ℤ_[p]`) and its Haar probability
`haar p`. `res p k : ℤ_p² → (ℤ/p^k)²` reduces both coordinates modulo `p^k`; its fibres are the cosets of `p^k ℤ_p²`, each
of measure `p^{−2k}`.

* `exists_unitVector_lift` — **Hensel**: every unit vector of `(ℤ/p^k)²` is the residue of a unit vector of `ℤ_p²` (`p` odd).
* `isIndepSet_wellFilled` — **the well-filled cosets are independent**: if `I ⊆ ℤ_p²` is measurable and independent in
  `unitQuadrance ℤ_[p]`, the level-`k` residues whose coset `I` fills to more than half form an independent set of
  `UD(ℤ/p^k, 2)`. (Two adjacent ones `C`, `C' = C + s` with `s` a unit vector lifted by Hensel: `I ∩ C` and `(I ∩ C') − s`
  are two subsets of `C` of measure above `μ(C)/2`, so they meet, at `x` with `x, x + s ∈ I`.) One lift, no Fubini.
* `haar_le_of_towerRatio` — **a measurable independent set holds at most the tower ratio**: `TowerRatio p c` gives
  `haar p I ≤ c`. (The badly filled points of `I` have measure tending to `0` with `k` — a compact set inside `I` and an
  open set outside, finitely many cosets between, Haar being regular (`exists_level_haar_bad_le`, after
  `Rigidity/CountCompletion`'s `tendsto_haarK_bad`) — and the well-filled cosets number at most `c · p^{2k}`.) No density
  theorem, no martingale, no Fourier analysis on `ℚ_p`.
* `one_le_mul_of_borelColoring`, `le_borelChromaticNumber_of_towerRatio` — **the Borel bound**: a proper colouring of the
  p-adic plane with `k` Borel classes has `1 ≤ k·c`, so `⌈1/c⌉ ≤ χ_Bor`. The classes meet `ℤ_p²` in measurable independent
  sets covering a set of measure `1`.

**Not claimed:** anything about a colouring whose classes are not Borel, or about the plain chromatic number.

**Models.** `TowerRatio p 1` (`towerRatio_one`) satisfies the hypotheses of every theorem here; with it the conclusions are
`haar p I ≤ 1` and `1 ≤ k`. A measurable independent set: the empty set, or any single point (no unit vector is `0`). A
Borel colouring of the p-adic plane, the one binder the vacuity scan reads here (`col`, `GENERIC` in `k`): at `p = 3`,
`k = 3`, `PadicPlane/Upper.exists_borelColoring_of_colorable` with `finitePlane3_colorable_three`, so the hypotheses of
`one_le_mul_of_borelColoring` hold together at `p = 3`, `k = 3`, `c = 1`. At `k` below `⌈1/c⌉` the binder is empty: that is
the theorem.
-/

namespace HadwigerNelson.PadicPlane

open MeasureTheory SimpleGraph Topology
open scoped ENNReal

variable (p : ℕ) [Fact p.Prime]

/-- The Borel σ-algebra of `ℤ_[p]` (Mathlib declares no measurable structure on it). Scoped. -/
noncomputable scoped instance instMeasurableSpacePadicInt : MeasurableSpace ℤ_[p] := borel ℤ_[p]

scoped instance instBorelSpacePadicInt : BorelSpace ℤ_[p] := ⟨rfl⟩

/-- **The Haar probability of `ℤ_p²`**, normalized on the whole compact group. -/
noncomputable def haar : Measure (ℤ_[p] × ℤ_[p]) := Measure.addHaarMeasure ⊤

/-- `haar p` is a Haar measure (read through the definition; no instance is declared on `haar`). -/
private theorem isAddHaarMeasure_haar : (haar p).IsAddHaarMeasure := Measure.isAddHaarMeasure_addHaarMeasure _

/-- **The level-`k` residue** `ℤ_p² → (ℤ/p^k)²`, coordinatewise. -/
noncomputable def res (k : ℕ) : ℤ_[p] × ℤ_[p] →+ ZMod (p ^ k) × ZMod (p ^ k) :=
  (PadicInt.toZModPow k).toAddMonoidHom.prodMap (PadicInt.toZModPow k).toAddMonoidHom

theorem res_apply (k : ℕ) (x : ℤ_[p] × ℤ_[p]) :
    res p k x = (PadicInt.toZModPow k x.1, PadicInt.toZModPow k x.2) := rfl

/-- Spec: the residue of `(1, 0)` at level `k` is `(1, 0)`. -/
example (k : ℕ) : res p k (1, 0) = (1, 0) := by simp [res_apply]

/-- Every residue is the residue of a point of `ℤ_p²` (`toZModPow` sends the natural number `x.val` to `x`). -/
theorem res_surjective (k : ℕ) : Function.Surjective (res p k) := by
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k (Fact.out : p.Prime).ne_zero⟩
  rintro ⟨a, b⟩
  refine ⟨((a.val : ℤ_[p]), (b.val : ℤ_[p])), ?_⟩
  rw [res_apply, map_natCast, map_natCast, ZMod.natCast_zmod_val, ZMod.natCast_zmod_val]

/-- **Two points share their level-`j` residue exactly when they are within `p^{−j}`** (the kernel of `toZModPow j` is
the ball `‖x‖ ≤ p^{−j}`, in each coordinate of the product's sup metric). -/
private theorem res_eq_iff_dist_le (j : ℕ) (x y : ℤ_[p] × ℤ_[p]) :
    res p j y = res p j x ↔ dist y x ≤ (p : ℝ) ^ (-(j : ℤ)) := by
  rw [res_apply, res_apply, Prod.ext_iff, Prod.dist_eq, max_le_iff, dist_eq_norm, dist_eq_norm]
  simp only
  rw [← RingHom.sub_mem_ker_iff, ← RingHom.sub_mem_ker_iff, PadicInt.ker_toZModPow,
    ← PadicInt.norm_le_pow_iff_mem_span_pow, ← PadicInt.norm_le_pow_iff_mem_span_pow]

/-- Residues at a level determine the residues at every lower level. -/
private theorem res_eq_of_le {j k : ℕ} (hjk : j ≤ k) {y z : ℤ_[p] × ℤ_[p]} (h : res p k y = res p k z) :
    res p j y = res p j z := by
  rw [res_apply, res_apply, Prod.ext_iff] at h ⊢
  dsimp only at h ⊢
  refine ⟨?_, ?_⟩
  · rw [← PadicInt.cast_toZModPow j k hjk y.1, h.1, PadicInt.cast_toZModPow j k hjk z.1]
  · rw [← PadicInt.cast_toZModPow j k hjk y.2, h.2, PadicInt.cast_toZModPow j k hjk z.2]

/-- The cosets of `p^k ℤ_p²` are open (the kernel of `toZModPow k` is the ball `‖x‖ ≤ p^{−k}`). -/
theorem isOpen_res_fibre (k : ℕ) (x : ZMod (p ^ k) × ZMod (p ^ k)) : IsOpen (res p k ⁻¹' {x}) := by
  rw [Metric.isOpen_iff]
  intro y hy
  refine ⟨(p : ℝ) ^ (-(k : ℤ)), zpow_pos (Nat.cast_pos.2 (Fact.out : p.Prime).pos) _, fun z hz => ?_⟩
  rw [Set.mem_preimage, Set.mem_singleton_iff] at hy ⊢
  rw [← hy]
  exact (res_eq_iff_dist_le p k y z).2 (Metric.mem_ball.1 hz).le

theorem haar_univ : haar p Set.univ = 1 := by
  rw [haar, ← TopologicalSpace.PositiveCompacts.coe_top, Measure.addHaarMeasure_self]

/-- **Every level-`k` coset has measure `p^{−2k}`**: the `p^{2k}` cosets are translates of one another and cover `ℤ_p²`. -/
theorem haar_res_fibre (k : ℕ) (x : ZMod (p ^ k) × ZMod (p ^ k)) :
    haar p (res p k ⁻¹' {x}) = ((p : ℝ≥0∞) ^ (2 * k))⁻¹ := by
  classical
  haveI := isAddHaarMeasure_haar p
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k (Fact.out : p.Prime).ne_zero⟩
  have hmeas : ∀ y, MeasurableSet (res p k ⁻¹' {y}) := fun y => (isOpen_res_fibre p k y).measurableSet
  -- every fibre is a translate of the fibre over `0`
  have htr : ∀ y, haar p (res p k ⁻¹' {y}) = haar p (res p k ⁻¹' {0}) := by
    intro y
    obtain ⟨z, hz⟩ := res_surjective p k y
    have e : res p k ⁻¹' {y} = (fun h => -z + h) ⁻¹' (res p k ⁻¹' {0}) := by
      ext w
      simp only [Set.mem_preimage, Set.mem_singleton_iff, map_add, map_neg, hz]
      constructor
      · intro hw; rw [hw, neg_add_cancel]
      · intro hw; linear_combination hw
    rw [e, measure_preimage_add]
  have hsum := sum_measure_preimage_singleton (μ := haar p)
    (Finset.univ : Finset (ZMod (p ^ k) × ZMod (p ^ k))) (fun y _ => hmeas y)
  rw [Finset.coe_univ, Set.preimage_univ, haar_univ, Finset.sum_congr rfl fun y _ => htr y, Finset.sum_const,
    Finset.card_univ, Fintype.card_prod, ZMod.card, nsmul_eq_mul] at hsum
  rw [htr x]
  have e : (((p ^ k * p ^ k : ℕ) : ℝ≥0∞)) = (p : ℝ≥0∞) ^ (2 * k) := by push_cast; ring
  rw [e, mul_comm] at hsum
  exact ENNReal.eq_inv_of_mul_eq_one_left hsum

/-- **Hensel**: at an odd prime every unit vector of `(ℤ/p^k)²` is the residue of a unit vector of `ℤ_p²`. (One coordinate
of a residue unit vector is a unit; fix the other and solve `X² = 1 − a²` by `hensels_lemma`; the root is congruent to the
residue modulo `p^k` because `X + x₀` is a unit.) -/
theorem exists_unitVector_lift (hp : p ≠ 2) (k : ℕ) {t : ZMod (p ^ k) × ZMod (p ^ k)}
    (ht : t.1 ^ 2 + t.2 ^ 2 = 1) : ∃ s : ℤ_[p] × ℤ_[p], s.1 ^ 2 + s.2 ^ 2 = 1 ∧ res p k s = t := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · refine ⟨(1, 0), by ring, ?_⟩
    haveI : Subsingleton (ZMod (p ^ 0)) := by rw [pow_zero]; infer_instance
    exact Prod.ext (Subsingleton.elim _ _) (Subsingleton.elim _ _)
  have hpr : p.Prime := Fact.out
  -- the case of a second coordinate with a non-zero residue modulo `p`
  suffices H : ∀ t : ZMod (p ^ k) × ZMod (p ^ k), t.1 ^ 2 + t.2 ^ 2 = 1 →
      ZMod.castHom (pow_dvd_pow p hk) (ZMod (p ^ 1)) t.2 ≠ 0 →
      ∃ s : ℤ_[p] × ℤ_[p], s.1 ^ 2 + s.2 ^ 2 = 1 ∧ res p k s = t by
    by_cases h2 : ZMod.castHom (pow_dvd_pow p hk) (ZMod (p ^ 1)) t.2 = 0
    · have h1 : ZMod.castHom (pow_dvd_pow p hk) (ZMod (p ^ 1)) t.1 ≠ 0 := by
        intro h1
        have h := congrArg (ZMod.castHom (pow_dvd_pow p hk) (ZMod (p ^ 1))) ht
        rw [map_add, map_pow, map_pow, h1, h2, map_one] at h
        haveI : Fact (1 < p ^ 1) := ⟨by rw [pow_one]; exact hpr.one_lt⟩
        simp at h
      obtain ⟨s, hs1, hs⟩ := H (t.2, t.1) (by rw [add_comm]; exact ht) h1
      refine ⟨(s.2, s.1), by rw [add_comm]; exact hs1, ?_⟩
      rw [res_apply] at hs ⊢
      exact Prod.ext (congrArg Prod.snd hs) (congrArg Prod.fst hs)
    · exact H t ht h2
  intro t ht h2
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k hpr.ne_zero⟩
  set a : ℤ_[p] := ((t.1.val : ℕ) : ℤ_[p]) with hadef
  set b₀ : ℤ_[p] := ((t.2.val : ℕ) : ℤ_[p]) with hbdef
  have ha : PadicInt.toZModPow k a = t.1 := by rw [hadef, map_natCast, ZMod.natCast_zmod_val]
  have hb : PadicInt.toZModPow k b₀ = t.2 := by rw [hbdef, map_natCast, ZMod.natCast_zmod_val]
  -- an integer with a non-zero residue at level one has norm one
  have hunit : ∀ x : ℤ_[p], PadicInt.toZModPow 1 x ≠ 0 → ‖x‖ = 1 := by
    intro x hx
    refine le_antisymm (PadicInt.norm_le_one x) (not_lt.1 fun hlt => hx ?_)
    rw [← RingHom.mem_ker, PadicInt.ker_toZModPow, pow_one, Ideal.mem_span_singleton]
    exact (PadicInt.norm_lt_one_iff_dvd x).1 hlt
  have hb1 : ‖b₀‖ = 1 := hunit b₀ (by
    rw [← PadicInt.cast_toZModPow 1 k hk, hb, ← ZMod.castHom_apply (h := pow_dvd_pow p hk)]
    exact h2)
  have h21 : ‖(2 : ℤ_[p])‖ = 1 := hunit 2 (by
    rw [map_ofNat]
    intro h
    have h' : ((2 : ℕ) : ZMod (p ^ 1)) = 0 := by exact_mod_cast h
    rw [ZMod.natCast_eq_zero_iff, pow_one] at h'
    exact hp ((Nat.prime_dvd_prime_iff_eq hpr Nat.prime_two).1 h'))
  -- the defect `a² + b₀² − 1` vanishes modulo `p^k`
  have hδ : a ^ 2 + b₀ ^ 2 - 1 ∈ Ideal.span {(p : ℤ_[p]) ^ k} := by
    rw [← PadicInt.ker_toZModPow, RingHom.mem_ker, map_sub, map_add, map_pow, map_pow, ha, hb, ht, map_one, sub_self]
  have hδn : ‖a ^ 2 + b₀ ^ 2 - 1‖ < 1 :=
    ((PadicInt.norm_le_pow_iff_mem_span_pow _ k).2 hδ).trans_lt
      (zpow_lt_one_of_neg₀ (by exact_mod_cast hpr.one_lt) (by omega))
  -- Hensel for `X² − (1 − a²)` at `b₀`
  set F : Polynomial ℤ_[p] := Polynomial.X ^ 2 - Polynomial.C (1 - a ^ 2) with hFdef
  have hF : ∀ z : ℤ_[p], Polynomial.aeval z F = z ^ 2 - (1 - a ^ 2) := fun z => by simp [hFdef]
  have hF' : ∀ z : ℤ_[p], Polynomial.aeval z (Polynomial.derivative F) = 2 * z := fun z => by
    rw [hFdef, Polynomial.derivative_sub, Polynomial.derivative_X_sq, Polynomial.derivative_C, sub_zero, map_mul,
      Polynomial.aeval_C, Polynomial.aeval_X]
    rfl
  have hd : ‖Polynomial.aeval b₀ (Polynomial.derivative F)‖ = 1 := by rw [hF', norm_mul, h21, hb1, one_mul]
  obtain ⟨z, hz, hzb, -, -⟩ := hensels_lemma (F := F) (a := b₀) (by
    rw [hd, one_pow, hF]
    convert hδn using 2
    ring)
  rw [hF] at hz
  rw [hd] at hzb
  -- `z + b₀` is a unit, so `z ≡ b₀` modulo `p^k`
  have hzb' : ‖z + b₀‖ = 1 := by
    have e : z + b₀ = 2 * b₀ + (z - b₀) := by ring
    have h2b : ‖2 * b₀‖ = 1 := by rw [norm_mul, h21, hb1, one_mul]
    rw [e, PadicInt.norm_add_eq_max_of_ne (by rw [h2b]; exact hzb.ne'), h2b]
    exact max_eq_left hzb.le
  obtain ⟨u, hu⟩ := PadicInt.isUnit_iff.2 hzb'
  have hzk : z - b₀ ∈ Ideal.span {(p : ℤ_[p]) ^ k} := by
    have hm : (z - b₀) * ↑u = -(a ^ 2 + b₀ ^ 2 - 1) := by rw [hu]; linear_combination hz
    have e : z - b₀ = -(a ^ 2 + b₀ ^ 2 - 1) * ↑u⁻¹ := by
      rw [← hm, mul_assoc, Units.mul_inv, mul_one]
    rw [e]
    exact Ideal.mul_mem_right _ _ ((Ideal.neg_mem_iff _).2 hδ)
  refine ⟨(a, z), by linear_combination hz, ?_⟩
  rw [res_apply]
  refine Prod.ext ha ?_
  show PadicInt.toZModPow k z = t.2
  rw [← hb, ← sub_eq_zero, ← map_sub, ← RingHom.mem_ker, PadicInt.ker_toZModPow]
  exact hzk

/-- **The well-filled cosets of a measurable independent set are independent**: the level-`k` residues `x` whose coset `I`
fills to more than half form an independent set of `UD(ℤ/p^k, 2)`. -/
theorem isIndepSet_wellFilled (hp : p ≠ 2) {I : Set (ℤ_[p] × ℤ_[p])} (hI : MeasurableSet I)
    (hind : (unitQuadrance ℤ_[p]).IsIndepSet I) (k : ℕ) :
    (unitQuadrance (ZMod (p ^ k))).IsIndepSet
      {x | haar p (res p k ⁻¹' {x}) < 2 * haar p (I ∩ res p k ⁻¹' {x})} := by
  intro x hx y hy hxy hadj
  haveI := isAddHaarMeasure_haar p
  have hx' : haar p (res p k ⁻¹' {x}) < 2 * haar p (I ∩ res p k ⁻¹' {x}) := hx
  have hy' : haar p (res p k ⁻¹' {y}) < 2 * haar p (I ∩ res p k ⁻¹' {y}) := hy
  obtain ⟨-, hxy1⟩ := unitQuadrance_adj.1 hadj
  -- lift the unit vector `t = y − x` by Hensel
  have ht : (y - x).1 ^ 2 + (y - x).2 ^ 2 = 1 := by
    simp only [Prod.fst_sub, Prod.snd_sub]
    linear_combination hxy1
  obtain ⟨s, hs1, hs⟩ := exists_unitVector_lift p hp k ht
  have hCm : ∀ r, MeasurableSet (res p k ⁻¹' {r}) := fun r => (isOpen_res_fibre p k r).measurableSet
  -- `(I ∩ C_y) − s` lies in `C_x` and has the measure of `I ∩ C_y`
  set B := (fun z => s + z) ⁻¹' (I ∩ res p k ⁻¹' {y}) with hBdef
  have hBC : B ⊆ res p k ⁻¹' {x} := by
    intro z hz
    have h1 : res p k (s + z) = y := hz.2
    rw [map_add, hs] at h1
    show res p k z = x
    linear_combination h1
  have hBm : MeasurableSet B := (hI.inter (hCm y)).preimage (measurable_const_add s)
  have hμB : haar p B = haar p (I ∩ res p k ⁻¹' {y}) := measure_preimage_add _ _ _
  have hCxy : haar p (res p k ⁻¹' {x}) = haar p (res p k ⁻¹' {y}) := by rw [haar_res_fibre, haar_res_fibre]
  -- two subsets of `C_x`, each above half of it, meet
  have hlt : haar p (res p k ⁻¹' {x}) < haar p (I ∩ res p k ⁻¹' {x}) + haar p B := by
    rw [hμB]
    by_contra hcon
    push Not at hcon
    have h1 : haar p (res p k ⁻¹' {x}) + haar p (res p k ⁻¹' {x}) <
        2 * haar p (I ∩ res p k ⁻¹' {x}) + 2 * haar p (I ∩ res p k ⁻¹' {y}) :=
      ENNReal.add_lt_add hx' (by rw [hCxy]; exact hy')
    have h2 : 2 * haar p (I ∩ res p k ⁻¹' {x}) + 2 * haar p (I ∩ res p k ⁻¹' {y}) ≤
        haar p (res p k ⁻¹' {x}) + haar p (res p k ⁻¹' {x}) := by
      rw [← mul_add, ← two_mul]
      exact mul_le_mul_right hcon 2
    exact lt_irrefl _ (h1.trans_le h2)
  obtain ⟨z, hzA, hzB⟩ := nonempty_inter_of_measure_lt_add (haar p) hBm Set.inter_subset_right hBC hlt
  -- `z` and `s + z` are adjacent points of `I`
  have hadj' : (unitQuadrance ℤ_[p]).Adj z (s + z) := by
    rw [unitQuadrance_adj]
    refine ⟨fun h => ?_, ?_⟩
    · have hs0 : s = 0 := by
        have h' := congrArg (· - z) h
        simp only [sub_self, add_sub_cancel_right] at h'
        exact h'.symm
      rw [hs0] at hs1
      simp at hs1
    · simp only [Prod.fst_add, Prod.snd_add]
      linear_combination hs1
  exact hind hzA.1 hzB.1 (unitQuadrance_adj.1 hadj').1 hadj'

/-- **The badly filled points of `I` against a union `Z` of level-`k` cosets**: they have measure at most
`μ(I \ Z) + μ(Z \ I)`. (In a badly filled coset `C ⊆ Z`, `μ(I ∩ C) ≤ μ(C)/2 ≤ μ(C \ I)`.) -/
private theorem haar_bad_le {I Z : Set (ℤ_[p] × ℤ_[p])} (hI : MeasurableSet I) {k : ℕ}
    (hsat : ∀ y z, res p k y = res p k z → y ∈ Z → z ∈ Z) :
    haar p {y | y ∈ I ∧ 2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})} ≤
      haar p (I \ Z) + haar p (Z \ I) := by
  classical
  haveI := isAddHaarMeasure_haar p
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k (Fact.out : p.Prime).ne_zero⟩
  have hCm : ∀ r, MeasurableSet (res p k ⁻¹' {r}) := fun r => (isOpen_res_fibre p k r).measurableSet
  set T := Finset.univ.filter (fun r : ZMod (p ^ k) × ZMod (p ^ k) => res p k ⁻¹' {r} ⊆ Z ∧
    2 * haar p (I ∩ res p k ⁻¹' {r}) ≤ haar p (res p k ⁻¹' {r})) with hT
  have hsub : {y | y ∈ I ∧ 2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})} ⊆
      (I \ Z) ∪ ⋃ r ∈ T, I ∩ res p k ⁻¹' {r} := by
    rintro y ⟨hyI, hyb⟩
    by_cases hyZ : y ∈ Z
    · refine Or.inr (Set.mem_iUnion₂.2 ⟨res p k y, ?_, hyI, rfl⟩)
      rw [hT, Finset.mem_filter]
      exact ⟨Finset.mem_univ _, fun z hz => hsat y z (Set.mem_singleton_iff.1 hz).symm hyZ, hyb⟩
    · exact Or.inl ⟨hyI, hyZ⟩
  have hdisj : (↑T : Set (ZMod (p ^ k) × ZMod (p ^ k))).PairwiseDisjoint fun r => res p k ⁻¹' {r} \ I := by
    intro r _ r' _ hrr'
    refine Set.disjoint_left.2 fun z hz hz' => hrr' ?_
    exact (Set.mem_singleton_iff.1 hz.1).symm.trans (Set.mem_singleton_iff.1 hz'.1)
  have hle : ∀ r ∈ T, haar p (I ∩ res p k ⁻¹' {r}) ≤ haar p (res p k ⁻¹' {r} \ I) := by
    intro r hr
    rw [hT, Finset.mem_filter] at hr
    have h1 := measure_inter_add_sdiff (μ := haar p) (res p k ⁻¹' {r}) hI
    have h2 := hr.2.2
    rw [← h1, Set.inter_comm, two_mul] at h2
    rw [Set.inter_comm]
    exact (ENNReal.add_le_add_iff_left (measure_ne_top _ _)).1 h2
  calc haar p {y | y ∈ I ∧ 2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})}
      ≤ haar p ((I \ Z) ∪ ⋃ r ∈ T, I ∩ res p k ⁻¹' {r}) := measure_mono hsub
    _ ≤ haar p (I \ Z) + haar p (⋃ r ∈ T, I ∩ res p k ⁻¹' {r}) := measure_union_le _ _
    _ ≤ haar p (I \ Z) + ∑ r ∈ T, haar p (I ∩ res p k ⁻¹' {r}) := add_le_add le_rfl (measure_biUnion_finset_le _ _)
    _ ≤ haar p (I \ Z) + ∑ r ∈ T, haar p (res p k ⁻¹' {r} \ I) := add_le_add le_rfl (Finset.sum_le_sum hle)
    _ = haar p (I \ Z) + haar p (⋃ r ∈ T, res p k ⁻¹' {r} \ I) := by
        rw [measure_biUnion_finset hdisj fun r _ => (hCm r).diff hI]
    _ ≤ haar p (I \ Z) + haar p (Z \ I) := add_le_add le_rfl (measure_mono (Set.iUnion₂_subset fun r hr =>
        Set.sdiff_subset_sdiff_left (Finset.mem_filter.1 hr).2.1))

/-- **Density along cosets** (after `Rigidity/CountCompletion.tendsto_haarK_bad`): the points of a measurable `I` whose
level-`k` coset `I` fills to at most half have measure at most `ε` from some level on. -/
theorem exists_level_haar_bad_le {I : Set (ℤ_[p] × ℤ_[p])} (hI : MeasurableSet I) {ε : ℝ≥0∞} (hε : 0 < ε) :
    ∃ k₀ : ℕ, ∀ k, k₀ ≤ k → haar p {y | y ∈ I ∧
      2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})} ≤ ε := by
  classical
  haveI := isAddHaarMeasure_haar p
  have hε2 : ε / 2 ≠ 0 := (ENNReal.half_pos hε.ne').ne'
  -- regularity of Haar: a compact set inside `I` and an open set outside, each within `ε/2`
  obtain ⟨K, hKI, hK, hIK⟩ := hI.exists_isCompact_sdiff_lt (measure_ne_top (haar p) I) hε2
  obtain ⟨U, hIU, hU, -, hUI⟩ := hI.exists_isOpen_sdiff_lt (measure_ne_top (haar p) I) hε2
  -- each point of `U` has a whole coset inside `U`
  have hp1 : (1 : ℝ) < p := by exact_mod_cast (Fact.out : p.Prime).one_lt
  have hlev : ∀ x ∈ U, ∃ j : ℕ, res p j ⁻¹' {res p j x} ⊆ U := by
    intro x hx
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.1 hU x hx
    obtain ⟨j, hj⟩ := exists_pow_lt_of_lt_one hδ (inv_lt_one_of_one_lt₀ hp1)
    refine ⟨j, fun y hy => hball ?_⟩
    rw [Metric.mem_ball]
    have hd := (res_eq_iff_dist_le p j x y).1 (Set.mem_singleton_iff.1 hy)
    rw [zpow_neg, zpow_natCast, ← inv_pow] at hd
    exact hd.trans_lt hj
  choose! jx hjx using hlev
  -- finitely many of those cosets cover `K`; their union `Z` is saturated from the largest level on
  obtain ⟨t, htK, hcov⟩ := hK.elim_nhds_subcover (fun x => res p (jx x) ⁻¹' {res p (jx x) x})
    (fun x _ => (isOpen_res_fibre p _ _).mem_nhds rfl)
  have hZU : (⋃ x ∈ t, res p (jx x) ⁻¹' {res p (jx x) x}) ⊆ U :=
    Set.iUnion₂_subset fun x hx => hjx x (hIU (hKI (htK x hx)))
  refine ⟨t.sup jx, fun k hk => ?_⟩
  have hsat : ∀ y z, res p k y = res p k z → y ∈ (⋃ x ∈ t, res p (jx x) ⁻¹' {res p (jx x) x}) →
      z ∈ (⋃ x ∈ t, res p (jx x) ⁻¹' {res p (jx x) x}) := by
    intro y z hyz hy
    rw [Set.mem_iUnion₂] at hy ⊢
    obtain ⟨x, hx, hyx⟩ := hy
    refine ⟨x, hx, ?_⟩
    rw [Set.mem_preimage, Set.mem_singleton_iff] at hyx ⊢
    rw [← hyx]
    exact (res_eq_of_le p ((Finset.le_sup hx).trans hk) hyz).symm
  calc _ ≤ haar p (I \ ⋃ x ∈ t, res p (jx x) ⁻¹' {res p (jx x) x}) +
        haar p ((⋃ x ∈ t, res p (jx x) ⁻¹' {res p (jx x) x}) \ I) := haar_bad_le p hI hsat
    _ ≤ haar p (I \ K) + haar p (U \ I) :=
        add_le_add (measure_mono (Set.sdiff_subset_sdiff_right hcov)) (measure_mono (Set.sdiff_subset_sdiff_left hZU))
    _ ≤ ε / 2 + ε / 2 := add_le_add hIK.le hUI.le
    _ = ε := ENNReal.add_halves ε

/-- **A measurable independent set of `ℤ_p²` holds at most the tower ratio.** -/
theorem haar_le_of_towerRatio (hp : p ≠ 2) {c : ℝ} (hc : TowerRatio p c) {I : Set (ℤ_[p] × ℤ_[p])}
    (hI : MeasurableSet I) (hind : (unitQuadrance ℤ_[p]).IsIndepSet I) : haar p I ≤ ENNReal.ofReal c := by
  classical
  have hpR : (0 : ℝ) < p := Nat.cast_pos.2 (Fact.out : p.Prime).pos
  refine ENNReal.le_of_forall_pos_le_add fun ε hε _ => ?_
  obtain ⟨k₀, hk₀⟩ := exists_level_haar_bad_le p hI (ε := ε) (ENNReal.coe_pos.2 hε)
  set k := max k₀ 1 with hkdef
  haveI : NeZero (p ^ k) := ⟨pow_ne_zero k (Fact.out : p.Prime).ne_zero⟩
  -- the well-filled residues: an independent set of the level, so at most `c·p^{2k}` of them
  set J := Finset.univ.filter fun x : ZMod (p ^ k) × ZMod (p ^ k) =>
    haar p (res p k ⁻¹' {x}) < 2 * haar p (I ∩ res p k ⁻¹' {x}) with hJdef
  have hJind : (unitQuadrance (ZMod (p ^ k))).IsIndepSet (J : Set (ZMod (p ^ k) × ZMod (p ^ k))) := by
    have h := isIndepSet_wellFilled p hp hI hind k
    have e : (J : Set (ZMod (p ^ k) × ZMod (p ^ k))) =
        {x | haar p (res p k ⁻¹' {x}) < 2 * haar p (I ∩ res p k ⁻¹' {x})} := by
      ext x
      simp [hJdef]
    rw [e]
    exact h
  have hJc : (J.card : ℝ) ≤ c * (p : ℝ) ^ (2 * k) := hc k (le_max_right _ _) J hJind
  -- every point of `I` is badly filled or in a well-filled coset
  have hsplit : I ⊆ {y | y ∈ I ∧ 2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})} ∪
      ⋃ x ∈ J, res p k ⁻¹' {x} := by
    intro y hy
    by_cases hb : 2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤ haar p (res p k ⁻¹' {res p k y})
    · exact Or.inl ⟨hy, hb⟩
    · exact Or.inr (Set.mem_iUnion₂.2 ⟨res p k y, Finset.mem_filter.2 ⟨Finset.mem_univ _, not_le.1 hb⟩, rfl⟩)
  have hgood : haar p (⋃ x ∈ J, res p k ⁻¹' {x}) ≤ ENNReal.ofReal c := by
    calc haar p (⋃ x ∈ J, res p k ⁻¹' {x}) ≤ ∑ x ∈ J, haar p (res p k ⁻¹' {x}) := measure_biUnion_finset_le _ _
      _ = (J.card : ℝ≥0∞) * ((p : ℝ≥0∞) ^ (2 * k))⁻¹ := by
          rw [Finset.sum_congr rfl fun x _ => haar_res_fibre p k x, Finset.sum_const, nsmul_eq_mul]
      _ = ENNReal.ofReal ((J.card : ℝ) / (p : ℝ) ^ (2 * k)) := by
          rw [ENNReal.ofReal_div_of_pos (pow_pos hpR _), ENNReal.ofReal_natCast, ENNReal.ofReal_pow hpR.le,
            ENNReal.ofReal_natCast, div_eq_mul_inv]
      _ ≤ ENNReal.ofReal c := ENNReal.ofReal_le_ofReal ((div_le_iff₀ (pow_pos hpR _)).2 hJc)
  calc haar p I ≤ haar p ({y | y ∈ I ∧ 2 * haar p (I ∩ res p k ⁻¹' {res p k y}) ≤
        haar p (res p k ⁻¹' {res p k y})} ∪ ⋃ x ∈ J, res p k ⁻¹' {x}) := measure_mono hsplit
    _ ≤ (ε : ℝ≥0∞) + ENNReal.ofReal c := (measure_union_le _ _).trans (add_le_add (hk₀ k (le_max_left _ _)) hgood)
    _ = ENNReal.ofReal c + ε := add_comm _ _

/-- **A Borel colouring of the p-adic plane with `k` colours has `1 ≤ k·c`** for every tower ratio `c`. -/
theorem one_le_mul_of_borelColoring (hp : p ≠ 2) {c : ℝ} (hc : TowerRatio p c) {k : ℕ}
    (col : (padicPlane p).Coloring (Fin k))
    (hcol : ∀ i, MeasurableSet[borel (ℚ_[p] × ℚ_[p])] (⇑col ⁻¹' {i})) : 1 ≤ (k : ℝ) * c := by
  classical
  -- the inclusion `ℤ_p² → ℚ_p²` is continuous, so Borel classes pull back to measurable sets
  set ι : ℤ_[p] × ℤ_[p] → ℚ_[p] × ℚ_[p] := ⇑(unitQuadrance.map (PadicInt.Coe.ringHom (p := p))) with hιdef
  have hιapp : ∀ z, ι z = ((z.1 : ℚ_[p]), (z.2 : ℚ_[p])) := fun _ => rfl
  have hcont : Continuous ι := by
    have e : ι = Prod.map (fun a : ℤ_[p] => (a : ℚ_[p])) (fun a : ℤ_[p] => (a : ℚ_[p])) := funext hιapp
    rw [e]
    exact continuous_subtype_val.prodMap continuous_subtype_val
  have hmeas : @Measurable _ _ _ (borel (ℚ_[p] × ℚ_[p])) ι :=
    measurable_generateFrom fun t ht => (ht.preimage hcont).measurableSet
  have hIm : ∀ i, MeasurableSet (ι ⁻¹' (⇑col ⁻¹' {i})) := fun i => hmeas (hcol i)
  have hIind : ∀ i, (unitQuadrance ℤ_[p]).IsIndepSet (ι ⁻¹' (⇑col ⁻¹' {i})) := by
    intro i y hy z hz _ hadj
    have hadj' : (padicPlane p).Adj (ι y) (ι z) := (unitQuadrance.map (PadicInt.Coe.ringHom (p := p))).map_adj hadj
    have hy' : col (ι y) = i := hy
    have hz' : col (ι z) = i := hz
    exact col.valid hadj' (hy'.trans hz'.symm)
  have hcover : (Set.univ : Set (ℤ_[p] × ℤ_[p])) ⊆ ⋃ i, ι ⁻¹' (⇑col ⁻¹' {i}) := fun y _ =>
    Set.mem_iUnion.2 ⟨col (ι y), rfl⟩
  have h1 : (1 : ℝ≥0∞) ≤ (k : ℝ≥0∞) * ENNReal.ofReal c := by
    calc (1 : ℝ≥0∞) = haar p Set.univ := (haar_univ p).symm
      _ ≤ haar p (⋃ i, ι ⁻¹' (⇑col ⁻¹' {i})) := measure_mono hcover
      _ ≤ ∑ i, haar p (ι ⁻¹' (⇑col ⁻¹' {i})) := measure_iUnion_fintype_le _ _
      _ ≤ ∑ _i : Fin k, ENNReal.ofReal c :=
          Finset.sum_le_sum fun i _ => haar_le_of_towerRatio p hp hc (hIm i) (hIind i)
      _ = (k : ℝ≥0∞) * ENNReal.ofReal c := by rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [← ENNReal.ofReal_natCast, ← ENNReal.ofReal_mul (Nat.cast_nonneg _)] at h1
  exact ENNReal.one_le_ofReal.1 h1

/-- **The Borel chromatic number of the p-adic plane is at least `⌈1/c⌉`** for every positive tower ratio `c`. -/
theorem le_borelChromaticNumber_of_towerRatio (hp : p ≠ 2) {c : ℝ} (hc : TowerRatio p c) (hc0 : 0 < c) :
    ((⌈1 / c⌉₊ : ℕ) : ℕ∞) ≤ borelChromaticNumber (padicPlane p) := by
  refine le_borelChromaticNumber fun k ⟨col, hcol⟩ => ?_
  have h := one_le_mul_of_borelColoring p hp hc col hcol
  have hk : 1 / c ≤ k := by
    rw [div_le_iff₀ hc0]
    linarith
  exact_mod_cast Nat.ceil_le.2 hk

end HadwigerNelson.PadicPlane
