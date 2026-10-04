import Proofs.HadwigerNelson.Plane.MaximalCover
import Proofs.HadwigerNelson.Plane.Slack
import Mathlib.Analysis.Convex.Hull
import Mathlib.Analysis.Convex.Measure
import Mathlib.Topology.MetricSpace.HausdorffDistance
import Mathlib.Data.Rat.Denumerable
import Mathlib.Data.Rat.Floor

/-!
# The example colourings, covers and classes (FS-131 wave 2)

Rows: **FS111-W-SQ9**, **FS111-M-R7**, **FS111-M2-DISC7**, **FS111-M3-BAND**, **FS111-M3-HC**, **FS111-M3-IRREG**,
**FS111-M3-FIXCONV**. Plan: `plans/FS131-w2-kernel-plan.md` §§ 4, 7. Every object is defined by formula, sorry-free; the rows'
content is in the theorems.

* **The triangular lattice** `tri m n = m + n ω`, `ω = e(π/3)`, carries all three periodic objects: R7's tiles sit on it, DISC7's
  centres are `(√3/2) · tri`, HC's face centres `L√3 e(π/6) · tri`.
* **R7** (`plans/FS111-M-regularity.md` § 2.4) is a colouring, given in lattice coordinates `z = a + b ω`: the rhombus cell
  `(⌊a⌋, ⌊b⌋)` splits into the up triangle `u + v ≤ 1` and the down triangle; a point is in the Reuleaux triangle `U(m, n)` iff
  it is within `1` of all three of its vertices, and inside the cell's down triangle only the far vertex can fail — so the colour is
  read from three quadratic tests `|w|² = a² + ab + b²` against the far vertices `λ`, `λ + 2`, `λ + 2ω`.
* **DISC7** (`plans/FS111-M2-regularity.md` § 1.6) is a cover with overlaps: a family of unions of closed discs.
* **HC** (`plans/FS111-M3-finiteness.md` § 1.6) is one class, parametrized by a gap function `g`: down triangles, up triangles
  cut by the graph `t = 2 + g(s)` in each of their three edge frames, the bands `{|s| < 1/2, 1 < t < ℓ(s)}` and the face discs.
  `G1Bounds Z g` is (G1) as the proofs read it; `hcGap Z` is § 1.6's formula; `fatZ` is a closed nowhere dense set of positive
  length containing `±1/2` (the complement of small intervals about an enumeration of `ℚ`), the fat set FS111-M3-IRREG needs.

FS111-W-SQ9's colouring is by **closed** squares; `sq9` (`Plane/Cover`) uses half-open squares, which differ from it on the
null grid only, and tightness and saturation read densities alone, so they are the same statements.
-/

namespace HadwigerNelson.Plane

open Complex Real Set MeasureTheory Filter Topology Metric

/-! ## FS111-W-SQ9 -/

/-- `sq9`'s colour on a square, read from the floors. -/
theorem sq9Col_of_floor {z : ℂ} {n m : ℤ} (h1 : ⌊2 * z.re⌋ = n) (h2 : ⌊2 * z.im⌋ = m) :
    sq9Col z = finProdFinEquiv ((n : ZMod 3), (m : ZMod 3)) := by
  simp only [sq9Col, sq9Index, h1, h2]

/-- Squares `(0,0)` and `(3,0)` hold non-null pairs at distances in `[1 − ε, 1 + ε]`, for every `ε > 0`. -/
theorem sq9_not_bandNull {ε : ℝ} (hε : 0 < ε) : ∃ j, ¬ BandNull (sq9.cls j) ε := by
  refine ⟨finProdFinEquiv ((0 : ZMod 3), (0 : ZMod 3)), fun hN => ?_⟩
  set U1 : Set ℂ := {z | 0 < z.re ∧ z.re < 1 / 2 ∧ 0 < z.im ∧ z.im < 1 / 2} with hU1
  set U2 : Set ℂ := {z | 3 / 2 < z.re ∧ z.re < 2 ∧ 0 < z.im ∧ z.im < 1 / 2} with hU2
  have hU1o : IsOpen U1 :=
    (isOpen_lt continuous_const Complex.continuous_re).inter ((isOpen_lt Complex.continuous_re continuous_const).inter
      ((isOpen_lt continuous_const Complex.continuous_im).inter (isOpen_lt Complex.continuous_im continuous_const)))
  have hU2o : IsOpen U2 :=
    (isOpen_lt continuous_const Complex.continuous_re).inter ((isOpen_lt Complex.continuous_re continuous_const).inter
      ((isOpen_lt continuous_const Complex.continuous_im).inter (isOpen_lt Complex.continuous_im continuous_const)))
  have hU1c : U1 ⊆ sq9.cls (finProdFinEquiv ((0 : ZMod 3), (0 : ZMod 3))) := by
    intro z hz
    show sq9Col z = _
    rw [sq9Col_of_floor (n := 0) (m := 0) (Int.floor_eq_zero_iff.2 ⟨by linarith [hz.1], by linarith [hz.2.1]⟩)
      (Int.floor_eq_zero_iff.2 ⟨by linarith [hz.2.2.1], by linarith [hz.2.2.2]⟩)]
    simp
  have hU2c : U2 ⊆ sq9.cls (finProdFinEquiv ((0 : ZMod 3), (0 : ZMod 3))) := by
    intro z hz
    show sq9Col z = _
    have h1 : ⌊2 * z.re⌋ = 3 := Int.floor_eq_iff.2 ⟨by push_cast; linarith [hz.1], by push_cast; linarith [hz.2.1]⟩
    rw [sq9Col_of_floor (n := 3) (m := 0) h1
      (Int.floor_eq_zero_iff.2 ⟨by linarith [hz.2.2.1], by linarith [hz.2.2.2]⟩)]
    have : ((3 : ℤ) : ZMod 3) = 0 := by decide
    rw [this]; simp
  set ε' : ℝ := min ε (1 / 10) with hε'
  have hε'0 : 0 < ε' := lt_min hε (by norm_num)
  have hε'1 : ε' ≤ ε := min_le_left _ _
  have hε'2 : ε' ≤ 1 / 10 := min_le_right _ _
  set x0 : ℂ := ⟨1 / 2 - ε' / 8, 1 / 4⟩
  set y0 : ℂ := ⟨3 / 2 + ε' / 8, 1 / 4⟩
  have hx0 : x0 ∈ U1 := ⟨by simp [x0]; linarith, by simp [x0]; linarith, by norm_num [x0], by norm_num [x0]⟩
  have hy0 : y0 ∈ U2 := ⟨by simp [y0]; linarith, by simp [y0]; linarith, by norm_num [y0], by norm_num [y0]⟩
  have hd : dist x0 y0 = 1 + ε' / 4 := by
    rw [Complex.dist_eq_re_im]
    simp only [x0, y0]
    rw [show (1 / 2 - ε' / 8 - (3 / 2 + ε' / 8)) ^ 2 + ((1 : ℝ) / 4 - 1 / 4) ^ 2 = (1 + ε' / 4) ^ 2 by ring]
    exact Real.sqrt_sq (by linarith)
  set P : Set (ℂ × ℂ) := {q | q.1 ∈ U1 ∧ q.2 ∈ U2 ∧ 1 - ε' < dist q.1 q.2 ∧ dist q.1 q.2 < 1 + ε'} with hP
  have hPo : IsOpen P := by
    refine IsOpen.inter (hU1o.preimage continuous_fst) (IsOpen.inter (hU2o.preimage continuous_snd)
      (IsOpen.inter (isOpen_lt continuous_const (continuous_fst.dist continuous_snd))
        (isOpen_lt (continuous_fst.dist continuous_snd) continuous_const)))
  have hPn : (x0, y0) ∈ P := ⟨hx0, hy0, by rw [hd]; linarith, by rw [hd]; linarith⟩
  have hsub : P ⊆ bandPairSet (sq9.cls (finProdFinEquiv ((0 : ZMod 3), (0 : ZMod 3)))) ε := by
    intro q hq
    exact ⟨hU1c hq.1, hU2c hq.2.1, by linarith [hq.2.2.1], by linarith [hq.2.2.2]⟩
  have hpos : 0 < (volume.prod volume) P := hPo.measure_pos _ ⟨_, hPn⟩
  exact hpos.ne' (measure_mono_null hsub hN)

/-- **FS111-W-SQ9**, tightness. -/
theorem sq9_tight : sq9.Tight := fun ε hε hs => by
  obtain ⟨j, hj⟩ := sq9_not_bandNull hε
  exact hj (hs j)

/-! ### FS131-K2d: children of `sq9_saturated_both` (plan § 16) -/

/-- The closed square `[n/2, (n+1)/2] × [m/2, (m+1)/2]` of `sq9`'s grid. -/
def sq9Sq (n m : ℤ) : Set ℂ :=
  {z | (n : ℝ) / 2 ≤ z.re ∧ z.re ≤ ((n : ℝ) + 1) / 2 ∧ (m : ℝ) / 2 ≤ z.im ∧ z.im ≤ ((m : ℝ) + 1) / 2}

/-- **A ball of a quarter radius inside `closedBall x r`, a.e. inside `A`, at every small radius**: then `A` has positive upper
density at `x` (the density ratio is at least `1/16`). A child of `sq9Sq_subset_essClosure` (FS131-I2f). -/
theorem upperDensityAt_pos_of_balls {A : Set ℂ} {x : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (h : ∀ r, 0 < r → r < r₀ → ∃ c, ball c (r / 4) ⊆ closedBall x r ∧ volume (ball c (r / 4) \ A) = 0) :
    0 < upperDensityAt A x := by
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), (1 / 16 : ENNReal) ≤ densityRatio A x r := by
    filter_upwards [Ioo_mem_nhdsGT hr₀] with r hr
    obtain ⟨c, hcl, h4⟩ := h r hr.1 hr.2
    have hmeas : volume (ball c (r / 4)) ≤ volume (A ∩ closedBall x r) := by
      calc volume (ball c (r / 4)) ≤ volume (ball c (r / 4) ∩ A) + volume (ball c (r / 4) \ A) :=
            measure_le_inter_add_sdiff _ _ _
        _ = volume (ball c (r / 4) ∩ A) := by rw [h4, add_zero]
        _ ≤ volume (A ∩ closedBall x r) := measure_mono fun w hw => ⟨hw.2, hcl hw.1⟩
    unfold densityRatio
    refine (ENNReal.le_div_iff_mul_le (Or.inl (measure_closedBall_pos volume x hr.1).ne')
      (Or.inl measure_closedBall_lt_top.ne)).2 ?_
    refine le_trans ?_ hmeas
    rw [Complex.volume_ball, Complex.volume_closedBall]
    have h4 : ENNReal.ofReal (r / 4) = ENNReal.ofReal r / 4 := by
      rw [ENNReal.ofReal_div_of_pos (by norm_num)]; simp
    rw [h4, div_eq_mul_inv (ENNReal.ofReal r), mul_pow, ← ENNReal.inv_pow]
    have h16 : (4 : ENNReal) ^ 2 = 16 := by norm_num
    rw [h16, one_div]
    refine le_of_eq ?_
    ring
  exact lt_of_lt_of_le (by norm_num) (le_limsup_of_frequently_le hev.frequently)

/-- The open square inside `sq9Sq n m` is inside the square's class (FS131-I2f). -/
theorem sq9_openSq_subset {n m : ℤ} {w : ℂ} (h1 : (n : ℝ) / 2 < w.re) (h2 : w.re < ((n : ℝ) + 1) / 2)
    (h3 : (m : ℝ) / 2 < w.im) (h4 : w.im < ((m : ℝ) + 1) / 2) :
    w ∈ sq9.cls (finProdFinEquiv ((n : ZMod 3), (m : ZMod 3))) := by
  show sq9Col w = _
  exact sq9Col_of_floor (Int.floor_eq_iff.2 ⟨by linarith, by linarith⟩) (Int.floor_eq_iff.2 ⟨by linarith, by linarith⟩)

/-- Saturation with positive-density partners implies saturation (`essClosure ⊆ essSupport = closure Ã`). -/
theorem SaturatedPos.saturated {k : ℕ} {C : Fin k → Set ℂ} (h : SaturatedPos C) : Saturated C := by
  intro j x hx
  obtain ⟨y, hy, hxy⟩ := h j x hx
  exact ⟨y, by rw [← essSupport_eq_closure_densitySet]; exact essClosure_subset_essSupport _ hy, hxy⟩

/-- A point of positive upper density of a class lies in a closed square of that class (the closed squares of one colour are a
locally finite closed family containing the class). -/
theorem sq9_essClosure_subset {j : Fin 9} {x : ℂ} (hx : x ∈ essClosure (sq9.cls j)) :
    ∃ n m : ℤ, finProdFinEquiv ((n : ZMod 3), (m : ZMod 3)) = j ∧ x ∈ sq9Sq n m := by
  by_contra hno
  simp only [not_exists, not_and] at hno
  let f : ℤ × ℤ → Set ℂ := fun p => if finProdFinEquiv ((p.1 : ZMod 3), (p.2 : ZMod 3)) = j then sq9Sq p.1 p.2 else ∅
  have hclosed : ∀ p, IsClosed (f p) := by
    intro p
    simp only [f]
    split_ifs
    · exact (isClosed_le continuous_const Complex.continuous_re).inter ((isClosed_le Complex.continuous_re continuous_const).inter
        ((isClosed_le continuous_const Complex.continuous_im).inter (isClosed_le Complex.continuous_im continuous_const)))
    · exact isClosed_empty
  have hlf : LocallyFinite f := by
    intro z
    refine ⟨ball z (1 / 4), ball_mem_nhds z (by norm_num), ?_⟩
    refine (Set.finite_Icc (⌊2 * z.re⌋ - 1, ⌊2 * z.im⌋ - 1) (⌊2 * z.re⌋ + 1, ⌊2 * z.im⌋ + 1)).subset ?_
    rintro ⟨p, q⟩ ⟨w, hwf, hw⟩
    simp only [f] at hwf
    split_ifs at hwf with hc
    · obtain ⟨w1, w2, w3, w4⟩ := hwf
      rw [mem_ball] at hw
      have hre : |w.re - z.re| < 1 / 4 := lt_of_le_of_lt (by
        have := Complex.abs_re_le_norm (w - z); simpa [dist_eq_norm] using this) hw
      have him : |w.im - z.im| < 1 / 4 := lt_of_le_of_lt (by
        have := Complex.abs_im_le_norm (w - z); simpa [dist_eq_norm] using this) hw
      rw [abs_lt] at hre him
      have f1 := Int.floor_le (2 * z.re)
      have f2 := Int.lt_floor_add_one (2 * z.re)
      have f3 := Int.floor_le (2 * z.im)
      have f4 := Int.lt_floor_add_one (2 * z.im)
      have k1 : (p : ℝ) < ⌊2 * z.re⌋ + 2 := by linarith
      have k2 : (⌊2 * z.re⌋ : ℝ) - 2 < p := by linarith
      have k3 : (q : ℝ) < ⌊2 * z.im⌋ + 2 := by linarith
      have k4 : (⌊2 * z.im⌋ : ℝ) - 2 < q := by linarith
      have l1 : p < ⌊2 * z.re⌋ + 2 := by exact_mod_cast k1
      have l2 : ⌊2 * z.re⌋ - 2 < p := by exact_mod_cast k2
      have l3 : q < ⌊2 * z.im⌋ + 2 := by exact_mod_cast k3
      have l4 : ⌊2 * z.im⌋ - 2 < q := by exact_mod_cast k4
      exact ⟨⟨by omega, by omega⟩, ⟨by omega, by omega⟩⟩
    · exact hwf.elim
  have hS : IsClosed (⋃ p, f p) := hlf.isClosed_iUnion hclosed
  have hxS : x ∉ ⋃ p, f p := by
    simp only [mem_iUnion, not_exists]
    intro p hp
    simp only [f] at hp
    split_ifs at hp with hc
    · exact hno p.1 p.2 hc hp
    · exact hp
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.1 hS.isOpen_compl x hxS
  have h0 : upperDensityAt (sq9.cls j) x = 0 := by
    refine upperDensityAt_eq_zero_of_null (r₀ := r₀ / 2) (by positivity) fun r hr hrr => ?_
    refine measure_mono_null (t := ∅) (fun z hz => ?_) measure_empty
    obtain ⟨hzj, hzb⟩ := hz
    have hzS : z ∈ ⋃ p, f p := by
      refine mem_iUnion.2 ⟨(⌊2 * z.re⌋, ⌊2 * z.im⌋), ?_⟩
      have hcol : finProdFinEquiv (((⌊2 * z.re⌋ : ℤ) : ZMod 3), ((⌊2 * z.im⌋ : ℤ) : ZMod 3)) = j := by
        rw [← sq9Col_of_floor rfl rfl]; exact hzj
      simp only [f, hcol, if_true]
      refine ⟨?_, ?_, ?_, ?_⟩
      · have := Int.floor_le (2 * z.re); linarith
      · have := Int.lt_floor_add_one (2 * z.re); linarith
      · have := Int.floor_le (2 * z.im); linarith
      · have := Int.lt_floor_add_one (2 * z.im); linarith
    exact hball (by rw [mem_ball]; rw [mem_closedBall] at hzb; linarith) hzS
  exact (ne_of_gt hx) h0

/-- Every point of a closed square has positive upper density for the square's class (a corner sub-square of side `r/√2`). -/
theorem sq9Sq_subset_essClosure (n m : ℤ) :
    sq9Sq n m ⊆ essClosure (sq9.cls (finProdFinEquiv ((n : ZMod 3), (m : ZMod 3)))) := by
  intro x hx
  obtain ⟨hx1, hx2, hx3, hx4⟩ := hx
  refine upperDensityAt_pos_of_balls (r₀ := 1 / 2) (by norm_num) fun r hr hr2 => ?_
  set a : ℝ := if x.re ≤ (2 * n + 1) / 4 then x.re + r / 4 else x.re - r / 4 with ha
  set b : ℝ := if x.im ≤ (2 * m + 1) / 4 then x.im + r / 4 else x.im - r / 4 with hb
  have hal : (n : ℝ) / 2 ≤ a - r / 4 ∧ a + r / 4 ≤ ((n : ℝ) + 1) / 2 := by
    rw [ha]; split_ifs with h <;> constructor <;> linarith
  have hbl : (m : ℝ) / 2 ≤ b - r / 4 ∧ b + r / 4 ≤ ((m : ℝ) + 1) / 2 := by
    rw [hb]; split_ifs with h <;> constructor <;> linarith
  have hda : |a - x.re| = r / 4 := by rw [ha]; split_ifs <;> simp [abs_of_pos, hr, abs_of_neg]
  have hdb : |b - x.im| = r / 4 := by rw [hb]; split_ifs <;> simp [abs_of_pos, hr, abs_of_neg]
  refine ⟨⟨a, b⟩, fun w hw => ?_, ?_⟩
  · rw [mem_ball] at hw
    rw [mem_closedBall]
    have hcx : dist (⟨a, b⟩ : ℂ) x ≤ r / 2 := by
      rw [Complex.dist_eq_re_im]
      refine Real.sqrt_le_iff.2 ⟨by linarith, ?_⟩
      have e1 : ((⟨a, b⟩ : ℂ).re - x.re) ^ 2 = (r / 4) ^ 2 := by rw [← hda, sq_abs]
      have e2 : ((⟨a, b⟩ : ℂ).im - x.im) ^ 2 = (r / 4) ^ 2 := by rw [← hdb, sq_abs]
      rw [e1, e2]; nlinarith
    linarith [dist_triangle w ⟨a, b⟩ x]
  · refine measure_mono_null (t := ∅) (fun w hw => ?_) measure_empty
    obtain ⟨hw, hwA⟩ := hw
    rw [mem_ball] at hw
    have hre : |w.re - a| < r / 4 := lt_of_le_of_lt (by
      have := Complex.abs_re_le_norm (w - ⟨a, b⟩); simpa [dist_eq_norm] using this) hw
    have him : |w.im - b| < r / 4 := lt_of_le_of_lt (by
      have := Complex.abs_im_le_norm (w - ⟨a, b⟩); simpa [dist_eq_norm] using this) hw
    rw [abs_lt] at hre him
    exact hwA (sq9_openSq_subset (by linarith) (by linarith) (by linarith) (by linarith))

/-- A point of a closed square that is not a density point of its class lies on an edge (the open square is a.e. inside). -/
theorem sq9_mem_edge_of_not_mem_densitySet {n m : ℤ} {x : ℂ} (hx : x ∈ sq9Sq n m)
    (hd : x ∉ densitySet (sq9.cls (finProdFinEquiv ((n : ZMod 3), (m : ZMod 3))))) :
    x.re = n / 2 ∨ x.re = (n + 1) / 2 ∨ x.im = m / 2 ∨ x.im = (m + 1) / 2 := by
  by_contra hne
  simp only [not_or] at hne
  obtain ⟨h1, h2, h3, h4⟩ := hne
  obtain ⟨hx1, hx2, hx3, hx4⟩ := hx
  let U : Set ℂ := {w | (n : ℝ) / 2 < w.re ∧ w.re < ((n : ℝ) + 1) / 2 ∧ (m : ℝ) / 2 < w.im ∧ w.im < ((m : ℝ) + 1) / 2}
  have hU : IsOpen U :=
    (isOpen_lt continuous_const Complex.continuous_re).inter ((isOpen_lt Complex.continuous_re continuous_const).inter
      ((isOpen_lt continuous_const Complex.continuous_im).inter (isOpen_lt Complex.continuous_im continuous_const)))
  have hxU : x ∈ U := ⟨lt_of_le_of_ne hx1 (Ne.symm h1), lt_of_le_of_ne hx2 h2, lt_of_le_of_ne hx3 (Ne.symm h3),
    lt_of_le_of_ne hx4 h4⟩
  exact hd (subset_densitySet_of_isOpen_ae_subset hU
    (Eventually.of_forall fun w hw => sq9_openSq_subset hw.1 hw.2.1 hw.2.2.1 hw.2.2.2) hxU)

/-- **W's ladder**: a point on an edge of a closed square is at distance exactly `1` from a point of a closed square of the same
colour (`x ∓ 1` on the facing edge of the square three steps across, or `x ∓ i`). -/
theorem sq9_partner {n m : ℤ} {x : ℂ} (hx : x ∈ sq9Sq n m)
    (he : x.re = n / 2 ∨ x.re = (n + 1) / 2 ∨ x.im = m / 2 ∨ x.im = (m + 1) / 2) :
    ∃ (y : ℂ) (n' m' : ℤ), dist x y = 1 ∧ (n' : ZMod 3) = n ∧ (m' : ZMod 3) = m ∧ y ∈ sq9Sq n' m' := by
  have h3 : ((3 : ℤ) : ZMod 3) = 0 := by decide
  obtain ⟨hx1, hx2, hx3, hx4⟩ := hx
  rcases he with h | h | h | h
  · refine ⟨x - 1, n - 3, m, by simp, by rw [Int.cast_sub, h3, sub_zero], rfl, ?_⟩
    refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> linarith
  · refine ⟨x + 1, n + 3, m, by simp, by rw [Int.cast_add, h3, add_zero], rfl, ?_⟩
    refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> linarith
  · refine ⟨x - I, n, m - 3, by simp, rfl, by rw [Int.cast_sub, h3, sub_zero], ?_⟩
    refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> linarith
  · refine ⟨x + I, n, m + 3, by simp, rfl, by rw [Int.cast_add, h3, add_zero], ?_⟩
    refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> linarith

/-- **FS111-W-SQ9**, saturation clauses (the remaining leaf of `sq9_tight_saturated`): every essential boundary point of a class
lies on an edge of one of its squares, and the facing same-class square's edge is at distance exactly `1`. -/
theorem sq9_saturated_both : Saturated sq9.cls ∧ SaturatedPos sq9.cls := by
  have hpos : SaturatedPos sq9.cls := by
    intro j x hx
    obtain ⟨n, m, hj, hxs⟩ := sq9_essClosure_subset hx.1
    subst hj
    obtain ⟨y, n', m', hd, hn, hm, hy⟩ := sq9_partner hxs (sq9_mem_edge_of_not_mem_densitySet hxs hx.2)
    refine ⟨y, ?_, hd⟩
    have := sq9Sq_subset_essClosure n' m' hy
    rwa [hn, hm] at this
  exact ⟨hpos.saturated, hpos⟩

/-- **FS111-W-SQ9**: the half-square nine-colouring is a.e.-proper (it is `sq9 : AeColouring 9`), tight, saturated, and
saturated with positive-density partners. -/
theorem sq9_tight_saturated : sq9.Tight ∧ Saturated sq9.cls ∧ SaturatedPos sq9.cls :=
  ⟨sq9_tight, sq9_saturated_both⟩

/-! ## The triangular lattice -/

/-- The point `m + n ω` of the unit triangular lattice `Λ = ℤ[ω]`, `ω = e(π/3)`. -/
noncomputable def tri (m n : ℤ) : ℂ := m + n * e (π / 3)

/-- Lattice coordinates: `z = a + b ω` with `(a, b) = triCoord z`. -/
noncomputable def triCoord (z : ℂ) : ℝ × ℝ := (z.re - z.im / √3, 2 * z.im / √3)

/-- The squared norm of `a + b ω`. -/
def triQ (a b : ℝ) : ℝ := a ^ 2 + a * b + b ^ 2

/-- `e (π/3) = 1/2 + (√3/2) i`. -/
theorem e_pi_div_three : e (π / 3) = (1 / 2 : ℂ) + ((√3 / 2 : ℝ) : ℂ) * I := by
  rw [e_eq, Real.cos_pi_div_three, Real.sin_pi_div_three]; push_cast; ring

/-- `triCoord` inverts `(a, b) ↦ a + b ω`. -/
theorem triCoord_add_mul (a b : ℝ) : triCoord ((a : ℂ) + b * e (π / 3)) = (a, b) := by
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  rw [e_pi_div_three, triCoord]
  simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, add_im, mul_im, Prod.mk.injEq]
  norm_num
  constructor <;> field_simp
  ring

/-- `‖a + b ω‖² = a² + ab + b²`. -/
theorem normSq_add_mul (a b : ℝ) : normSq ((a : ℂ) + b * e (π / 3)) = triQ a b := by
  rw [e_pi_div_three, normSq_apply, triQ]
  simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, add_im, mul_im]
  have : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  norm_num
  nlinarith [this]

/-! ## FS111-M-R7: the Reuleaux seven-colouring -/

/-- The up tile `U(m, n)`'s colour: the coset of `λ = m + nω` mod `2Λ`, `2(m mod 2) + (n mod 2)`. -/
def r7UpCol (m n : ℤ) : Fin 7 := ⟨2 * (m % 2).toNat + (n % 2).toNat, by omega⟩

/-- The down tile `D(m, n)`'s colour: `4 + ((m − n) mod 3)`, the coset of `λ` mod `M = {m ≡ n (mod 3)}`. -/
def r7DownCol (m n : ℤ) : Fin 7 := ⟨4 + ((m - n) % 3).toNat, by omega⟩

/-- R7 in lattice coordinates. In the cell `(m, n) = (⌊a⌋, ⌊b⌋)` with fractional part `(u, v)`: within `1` of `λ` is `U(m, n)`
(which holds on the whole up triangle `u + v ≤ 1`), within `1` of `λ + 2` is `U(m + 1, n)`'s bulge, within `1` of `λ + 2ω` is
`U(m, n + 1)`'s bulge, and the rest is the cusped down tile `D(m, n)`. -/
noncomputable def r7ColTri (a b : ℝ) : Fin 7 :=
  let m := ⌊a⌋
  let n := ⌊b⌋
  let u := a - m
  let v := b - n
  if triQ u v ≤ 1 then r7UpCol m n
  else if triQ (u - 2) v ≤ 1 then r7UpCol (m + 1) n
  else if triQ u (v - 2) ≤ 1 then r7UpCol m (n + 1)
  else r7DownCol m n

/-- **R7**, the colouring of the plane (`[Polymath16threads]` thread 4; `plans/FS111-M-regularity.md` § 2.4). -/
noncomputable def r7Col (z : ℂ) : Fin 7 := r7ColTri (triCoord z).1 (triCoord z).2

/-- R7's classes, as a family. -/
def r7Cls (j : Fin 7) : Set ℂ := r7Col ⁻¹' {j}

/-- R7 at a point given in lattice coordinates. -/
theorem r7Col_add_mul (a b : ℝ) : r7Col ((a : ℂ) + b * e (π / 3)) = r7ColTri a b := by
  rw [r7Col, triCoord_add_mul]

/-! ### Spec examples (each fails if a colour, a test or a centre drifts) -/

/-- The centroid of `U(0, 0)` has colour `0`. -/
example : r7ColTri (1 / 3) (1 / 3) = 0 := by
  norm_num [r7ColTri, triQ, r7UpCol]

/-- The centroid of `D(0, 0)` has colour `4`. -/
example : r7ColTri (2 / 3) (2 / 3) = 4 := by
  norm_num [r7ColTri, triQ, r7DownCol]; rfl

/-- A point of the down half of cell `(0, 0)` inside `U(0, 0)`'s bulge has `U(0, 0)`'s colour (the Reuleaux test). -/
example : r7ColTri (11 / 20) (11 / 20) = 0 := by
  norm_num [r7ColTri, triQ, r7UpCol]

/-- `U(1, 0)` has colour `2` and `D(1, 0)` colour `5`. -/
example : r7ColTri (4 / 3) (1 / 3) = 2 ∧ r7ColTri (5 / 3) (2 / 3) = 5 := by
  constructor <;> norm_num [r7ColTri, triQ, r7UpCol, r7DownCol] <;> rfl

/-- A point in the cusp of `D(0, 0)` at the vertex `1`, outside both bulges by a hair, has the down colour. -/
example : r7ColTri (99 / 100) (1 / 50) = 4 := by
  norm_num [r7ColTri, triQ, r7DownCol]; rfl

/-! ### The row -/

/-! ### FS131-K2d: children of R7's leaves (plan § 16) -/

/-- The up tile `U(m, n)`: the Reuleaux triangle on `λ, λ + 1, λ + ω`, `λ = tri m n`. -/
def r7Up (m n : ℤ) : Set ℂ := closedBall (tri m n) 1 ∩ closedBall (tri (m + 1) n) 1 ∩ closedBall (tri m (n + 1)) 1

/-- The down tile `D(m, n)`: the cell's down triangle (vertices `λ + 1, λ + ω, λ + 1 + ω`) outside the three bulges (more than
`1` from `λ`, `λ + 2`, `λ + 2ω`). -/
def r7Down (m n : ℤ) : Set ℂ :=
  {z | z ∈ convexHull ℝ {tri (m + 1) n, tri m (n + 1), tri (m + 1) (n + 1)} ∧ 1 < dist z (tri m n) ∧
    1 < dist z (tri (m + 2) n) ∧ 1 < dist z (tri m (n + 2))}

/-- R7 is measurable (floors into a countable type and three quadratic tests). -/
theorem measurable_r7Col : Measurable r7Col := by
  have hfl1 : Measurable fun p : ℝ × ℝ => ⌊p.1⌋ := Int.measurable_floor.comp measurable_fst
  have hfl2 : Measurable fun p : ℝ × ℝ => ⌊p.2⌋ := Int.measurable_floor.comp measurable_snd
  have hcast : Measurable fun n : ℤ => (n : ℝ) := measurable_of_countable _
  have hu : Measurable fun p : ℝ × ℝ => p.1 - (⌊p.1⌋ : ℝ) := measurable_fst.sub (hcast.comp hfl1)
  have hv : Measurable fun p : ℝ × ℝ => p.2 - (⌊p.2⌋ : ℝ) := measurable_snd.sub (hcast.comp hfl2)
  have hdisc : ∀ f : ℤ × ℤ → Fin 7, Measurable fun p : ℝ × ℝ => f (⌊p.1⌋, ⌊p.2⌋) := fun f =>
    (measurable_of_countable f).comp (hfl1.prodMk hfl2)
  have hq : ∀ (x y : ℝ), Measurable fun p : ℝ × ℝ => triQ (p.1 - (⌊p.1⌋ : ℝ) + x) (p.2 - (⌊p.2⌋ : ℝ) + y) := by
    intro x y; unfold triQ; fun_prop
  have hT : Measurable fun p : ℝ × ℝ => r7ColTri p.1 p.2 := by
    simp only [r7ColTri]
    refine Measurable.ite ?_ (hdisc fun mn => r7UpCol mn.1 mn.2) (Measurable.ite ?_ (hdisc fun mn => r7UpCol (mn.1 + 1) mn.2)
      (Measurable.ite ?_ (hdisc fun mn => r7UpCol mn.1 (mn.2 + 1)) (hdisc fun mn => r7DownCol mn.1 mn.2)))
    · simpa using measurableSet_le (hq 0 0) measurable_const
    · simpa [sub_eq_add_neg] using measurableSet_le (hq (-2) 0) measurable_const
    · simpa [sub_eq_add_neg] using measurableSet_le (hq 0 (-2)) measurable_const
  have hc : Continuous triCoord := by unfold triCoord; fun_prop
  exact hT.comp hc.measurable

/-- Every point lies in an up tile of its colour (colours `< 4`) or a down tile of its colour (colours `≥ 4`). -/
theorem r7Col_mem_tile (z : ℂ) :
    (∃ m n : ℤ, z ∈ r7Up m n ∧ r7Col z = r7UpCol m n) ∨ ∃ m n : ℤ, z ∈ r7Down m n ∧ r7Col z = r7DownCol m n := by
  have hcol : r7Col z = r7ColTri (triCoord z).1 (triCoord z).2 := rfl
  set a := (triCoord z).1 with ha
  set b := (triCoord z).2 with hb
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  have hz : (a : ℂ) + b * e (π / 3) = z := by
    rw [e_pi_div_three]
    apply Complex.ext
    · simp [ha, hb, triCoord]; field_simp; ring
    · simp [ha, hb, triCoord]; field_simp
  set m := ⌊a⌋ with hm
  set n := ⌊b⌋ with hn
  have hu0 : 0 ≤ a - m := Int.fract_nonneg a
  have hu1 : a - m < 1 := Int.fract_lt_one a
  have hv0 : 0 ≤ b - n := Int.fract_nonneg b
  have hv1 : b - n < 1 := Int.fract_lt_one b
  set u := a - m with hu
  set v := b - n with hv
  have hD : ∀ (P Q p q : ℤ), P = m + p → Q = n + q → dist z (tri P Q) = √(triQ (u - p) (v - q)) := by
    rintro P Q p q rfl rfl
    have e1 : z - tri (m + p) (n + q) = ((u - p : ℝ) : ℂ) + ((v - q : ℝ) : ℂ) * e (π / 3) := by
      rw [← hz, tri, hu, hv]; push_cast; ring
    rw [dist_eq_norm, e1, Complex.norm_def, normSq_add_mul]
  have hin : ∀ (P Q p q : ℤ), P = m + p → Q = n + q → triQ (u - p) (v - q) ≤ 1 → z ∈ closedBall (tri P Q) 1 := by
    intro P Q p q hP hQ h
    rw [mem_closedBall, hD P Q p q hP hQ]; exact (Real.sqrt_le_sqrt h).trans_eq Real.sqrt_one
  have hout : ∀ (P Q p q : ℤ), P = m + p → Q = n + q → 1 < triQ (u - p) (v - q) → 1 < dist z (tri P Q) := by
    intro P Q p q hP hQ h
    rw [hD P Q p q hP hQ]; exact (Real.lt_sqrt zero_le_one).2 (by rw [one_pow]; exact h)
  have P1 : triQ (u - 1) v ≤ 1 := by
    unfold triQ; nlinarith [mul_nonneg hu0 (by linarith : (0 : ℝ) ≤ 2 - u - v), mul_nonneg hv0 (by linarith : (0 : ℝ) ≤ 1 - v)]
  have P2 : triQ u (v - 1) ≤ 1 := by
    unfold triQ; nlinarith [mul_nonneg hv0 (by linarith : (0 : ℝ) ≤ 2 - u - v), mul_nonneg hu0 (by linarith : (0 : ℝ) ≤ 1 - u)]
  simp only [r7ColTri] at hcol
  by_cases h1 : triQ u v ≤ 1
  · rw [if_pos h1] at hcol
    refine Or.inl ⟨m, n, ⟨⟨hin m n 0 0 (by ring) (by ring) (by simpa using h1),
      hin (m + 1) n 1 0 (by ring) (by ring) (by simpa using P1)⟩,
      hin m (n + 1) 0 1 (by ring) (by ring) (by simpa using P2)⟩, hcol⟩
  rw [if_neg h1] at hcol
  by_cases h2 : triQ (u - 2) v ≤ 1
  · rw [if_pos h2] at hcol
    have P3 : triQ (u - 1) (v - 1) ≤ 1 := by unfold triQ at h2 ⊢; nlinarith
    refine Or.inl ⟨m + 1, n, ⟨⟨hin (m + 1) n 1 0 (by ring) (by ring) (by simpa using P1),
      hin (m + 1 + 1) n 2 0 (by ring) (by ring) (by simpa using h2)⟩,
      hin (m + 1) (n + 1) 1 1 (by ring) (by ring) (by simpa using P3)⟩, hcol⟩
  rw [if_neg h2] at hcol
  by_cases h3' : triQ u (v - 2) ≤ 1
  · rw [if_pos h3'] at hcol
    have P4 : triQ (u - 1) (v - 1) ≤ 1 := by unfold triQ at h3' ⊢; nlinarith
    refine Or.inl ⟨m, n + 1, ⟨⟨hin m (n + 1) 0 1 (by ring) (by ring) (by simpa using P2),
      hin (m + 1) (n + 1) 1 1 (by ring) (by ring) (by simpa using P4)⟩,
      hin m (n + 1 + 1) 0 2 (by ring) (by ring) (by simpa using h3')⟩, hcol⟩
  rw [if_neg h3'] at hcol
  have P5 : 1 < u + v := by
    by_contra h; push Not at h
    exact h1 (by unfold triQ; nlinarith [mul_nonneg hu0 hv0])
  refine Or.inr ⟨m, n, ⟨?_, hout m n 0 0 (by ring) (by ring) (by simpa using not_le.1 h1),
    hout (m + 2) n 2 0 (by ring) (by ring) (by simpa using not_le.1 h2),
    hout m (n + 2) 0 2 (by ring) (by ring) (by simpa using not_le.1 h3')⟩, hcol⟩
  -- the down triangle, as a convex combination of its vertices
  have hmem := (convex_convexHull ℝ ({tri (m + 1) n, tri m (n + 1), tri (m + 1) (n + 1)} : Set ℂ)).sum_mem
    (t := Finset.univ) (w := ![1 - v, 1 - u, u + v - 1]) (z := ![tri (m + 1) n, tri m (n + 1), tri (m + 1) (n + 1)])
    (fun i _ => by fin_cases i <;> simp <;> linarith)
    (by simp [Fin.sum_univ_three]; ring)
    (fun i _ => by fin_cases i <;> simp <;> exact subset_convexHull ℝ _ (by simp))
  convert hmem using 1
  simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.vecHead,
    Matrix.vecTail, Function.comp, Fin.succ_zero_eq_one, Complex.real_smul]
  rw [← hz, tri, tri, tri, hu, hv]
  push_cast
  ring

/-- Up colours are `< 4`, down colours `≥ 4`: an up tile and a down tile never share a colour. -/
theorem r7UpCol_ne_r7DownCol (m n m' n' : ℤ) : r7UpCol m n ≠ r7DownCol m' n' := by
  intro h
  have := congrArg Fin.val h
  simp only [r7UpCol, r7DownCol] at this
  omega

/-! ### Lattice coordinates and Reuleaux's diameter (FS131-I2l: children of R7's three tile lemmas) -/

/-- `triQ` is nonnegative (half the sum of the squares of `a`, `b`, `a + b`). -/
theorem triQ_nonneg (a b : ℝ) : 0 ≤ triQ a b := by
  unfold triQ; nlinarith [sq_nonneg (a + b), sq_nonneg a, sq_nonneg b]

/-- `triQ` is monotone on the nonnegative quadrant. -/
theorem triQ_le_add {P Q R S : ℝ} (hP : 0 ≤ P) (hQ : 0 ≤ Q) (hR : 0 ≤ R) (hS : 0 ≤ S) :
    triQ P Q ≤ triQ (P + R) (Q + S) := by
  unfold triQ; nlinarith [mul_nonneg hP hR, mul_nonneg hQ hS, mul_nonneg hP hS, mul_nonneg hQ hR, mul_nonneg hR hS,
    sq_nonneg R, sq_nonneg S]

/-- `tri` with real casts. -/
theorem tri_eq (p q : ℤ) : tri p q = (((p : ℝ) : ℂ)) + (((q : ℝ) : ℂ)) * e (π / 3) := by
  simp only [tri, Complex.ofReal_intCast]

/-- Distance in lattice coordinates. -/
theorem dist_add_mul (a b a' b' : ℝ) :
    dist ((a : ℂ) + b * e (π / 3)) ((a' : ℂ) + b' * e (π / 3)) = √(triQ (a - a') (b - b')) := by
  rw [dist_eq_norm, show ((a : ℂ) + b * e (π / 3)) - ((a' : ℂ) + b' * e (π / 3)) =
    ((a - a' : ℝ) : ℂ) + ((b - b' : ℝ) : ℂ) * e (π / 3) by push_cast; ring, Complex.norm_def, normSq_add_mul]

/-- `triCoord` recovers the point. -/
theorem triCoord_spec (z : ℂ) : (((triCoord z).1 : ℝ) : ℂ) + (((triCoord z).2 : ℝ) : ℂ) * e (π / 3) = z := by
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  rw [e_pi_div_three]
  apply Complex.ext
  · simp [triCoord]; field_simp; ring
  · simp [triCoord]; field_simp

/-- Distance read in lattice coordinates. -/
theorem dist_eq_triQ (z w : ℂ) :
    dist z w = √(triQ ((triCoord z).1 - (triCoord w).1) ((triCoord z).2 - (triCoord w).2)) := by
  conv_lhs => rw [← triCoord_spec z, ← triCoord_spec w]
  exact dist_add_mul _ _ _ _

/-- The lattice coordinates of a lattice point. -/
theorem triCoord_tri (p q : ℤ) : triCoord (tri p q) = ((p : ℝ), (q : ℝ)) := by
  rw [tri_eq, triCoord_add_mul]

/-- Distance between lattice points. -/
theorem dist_tri (p q p' q' : ℤ) : dist (tri p q) (tri p' q') = √(triQ ((p : ℝ) - p') ((q : ℝ) - q')) := by
  rw [tri_eq, tri_eq, dist_add_mul]

/-- The real core of `reuleaux_unitPair`: two points of the lens `{|w| < 1, |w − 1| ≤ 1}` on one closed side of the axis are
less than `1` apart. -/
theorem reuleaux_aux {a₁ b₁ a₂ b₂ : ℝ} (h1 : a₁ ^ 2 + b₁ ^ 2 < 1) (h1' : (a₁ - 1) ^ 2 + b₁ ^ 2 ≤ 1)
    (h2 : a₂ ^ 2 + b₂ ^ 2 < 1) (h2' : (a₂ - 1) ^ 2 + b₂ ^ 2 ≤ 1) (hb : 0 ≤ b₁ * b₂)
    (h : (a₁ - a₂) ^ 2 + (b₁ - b₂) ^ 2 = 1) : False := by
  wlog ha : a₁ ≤ a₂ generalizing a₁ b₁ a₂ b₂
  · exact this h2 h2' h1 h1' (by linarith [mul_comm b₁ b₂]) (by linarith [h]) (le_of_not_ge ha)
  have ha1 : 0 ≤ a₁ := by nlinarith [sq_nonneg b₁, sq_nonneg a₁]
  have ha2 : a₂ < 1 := by nlinarith [sq_nonneg b₂]
  have key : ∀ c d : ℝ, 0 ≤ c * d → c ^ 2 ≤ d ^ 2 → c ^ 2 ≤ c * d := by
    intro c d hcd hcd'
    have hab : |c| ≤ |d| := sq_le_sq.1 hcd'
    have h3 : c ^ 2 = |c| * |c| := by rw [abs_mul_abs_self]; ring
    have h4 : c * d = |c| * |d| := by rw [← abs_mul, abs_of_nonneg hcd]
    rw [h3, h4]; exact mul_le_mul_of_nonneg_left hab (abs_nonneg _)
  rcases le_total (b₁ ^ 2) (b₂ ^ 2) with hb' | hb'
  · have e1 := key b₁ b₂ hb hb'
    nlinarith [mul_nonneg ha1 (by linarith : (0 : ℝ) ≤ 2 * a₂ - a₁)]
  · have e1 := key b₂ b₁ (by linarith [mul_comm b₁ b₂]) hb'
    nlinarith [mul_pos (sub_pos.2 ha2) (by linarith : (0 : ℝ) < 1 + a₂ - 2 * a₁)]

/-- **Reuleaux's diameter**: two points within `1` of the three vertices of a unit equilateral triangle at distance `1` put the
first on a unit circle about a vertex. (In the frame `w = conj(y − x)(· − x)` every vertex lies in the lens `|w| ≤ 1`,
`|w − 1| ≤ 1`; two vertices on one side of the axis would be less than `1` apart.) -/
theorem reuleaux_unitPair {x y V₁ V₂ V₃ : ℂ} (h12 : dist V₁ V₂ = 1) (h13 : dist V₁ V₃ = 1) (h23 : dist V₂ V₃ = 1)
    (hx₁ : dist x V₁ ≤ 1) (hx₂ : dist x V₂ ≤ 1) (hx₃ : dist x V₃ ≤ 1)
    (hy₁ : dist y V₁ ≤ 1) (hy₂ : dist y V₂ ≤ 1) (hy₃ : dist y V₃ ≤ 1) (hxy : dist x y = 1) :
    dist x V₁ = 1 ∨ dist x V₂ = 1 ∨ dist x V₃ = 1 := by
  by_contra hne
  push Not at hne
  obtain ⟨n1, n2, n3⟩ := hne
  set u := y - x with hu
  have hu1 : normSq u = 1 := by
    rw [← Complex.sq_norm, hu, ← dist_eq_norm, dist_comm, hxy, one_pow]
  have hcu : (starRingEnd ℂ) u * u = 1 := by rw [← normSq_eq_conj_mul_self, hu1, ofReal_one]
  set w : ℂ → ℂ := fun V => (starRingEnd ℂ) u * (V - x) with hw
  have hnw : ∀ z : ℂ, normSq ((starRingEnd ℂ) u * z) = normSq z := fun z => by
    rw [normSq_mul, normSq_conj, hu1, one_mul]
  have hdsq : ∀ a b : ℂ, normSq (a - b) = dist a b ^ 2 := fun a b => by rw [← Complex.sq_norm, dist_eq_norm]
  have key : ∀ V, dist x V < 1 → dist y V ≤ 1 →
      (w V).re ^ 2 + (w V).im ^ 2 < 1 ∧ ((w V).re - 1) ^ 2 + (w V).im ^ 2 ≤ 1 := by
    intro V hxV hyV
    have e1 : (w V).re ^ 2 + (w V).im ^ 2 = dist x V ^ 2 := by
      rw [show (w V).re ^ 2 + (w V).im ^ 2 = normSq (w V) by rw [normSq_apply]; ring, hw, hnw, ← neg_sub, normSq_neg, hdsq]
    have e2 : ((w V).re - 1) ^ 2 + (w V).im ^ 2 = dist y V ^ 2 := by
      have : w V - 1 = (starRingEnd ℂ) u * (V - y) := by
        rw [hw]; simp only; rw [← hcu, hu]; ring
      rw [show ((w V).re - 1) ^ 2 + (w V).im ^ 2 = normSq (w V - 1) by rw [normSq_apply]; simp; ring, this, hnw,
        ← neg_sub, normSq_neg, hdsq]
    refine ⟨?_, ?_⟩
    · rw [e1]; nlinarith [dist_nonneg (x := x) (y := V)]
    · rw [e2]; nlinarith [dist_nonneg (x := y) (y := V)]
  have key2 : ∀ V V', dist V V' = 1 → ((w V).re - (w V').re) ^ 2 + ((w V).im - (w V').im) ^ 2 = 1 := by
    intro V V' h
    have : w V - w V' = (starRingEnd ℂ) u * (V - V') := by rw [hw]; ring
    rw [show ((w V).re - (w V').re) ^ 2 + ((w V).im - (w V').im) ^ 2 = normSq (w V - w V') by rw [normSq_apply]; simp; ring,
      this, hnw, hdsq, h, one_pow]
  obtain ⟨k1, k1'⟩ := key V₁ (lt_of_le_of_ne hx₁ n1) hy₁
  obtain ⟨k2, k2'⟩ := key V₂ (lt_of_le_of_ne hx₂ n2) hy₂
  obtain ⟨k3, k3'⟩ := key V₃ (lt_of_le_of_ne hx₃ n3) hy₃
  rcases le_or_gt 0 ((w V₁).im * (w V₂).im) with h | h
  · exact reuleaux_aux k1 k1' k2 k2' h (key2 _ _ h12)
  rcases le_or_gt 0 ((w V₁).im * (w V₃).im) with h' | h'
  · exact reuleaux_aux k1 k1' k3 k3' h' (key2 _ _ h13)
  have h'' : 0 ≤ (w V₂).im * (w V₃).im := by
    have hp : 0 < (w V₁).im ^ 2 * ((w V₂).im * (w V₃).im) := by nlinarith [mul_pos_of_neg_of_neg h h']
    exact (pos_of_mul_pos_right hp (sq_nonneg _)).le
  exact reuleaux_aux k2 k2' k3 k3' h'' (key2 _ _ h23)

/-- Three unit steps along a line: a point within `1` of both ends of a segment of length `3`, and at distance `1` from a point
within `1` of the far end, is at distance exactly `1` from the near end. -/
theorem dist_eq_one_of_three {x y W W' : ℂ} (hW : dist W W' = 3) (hx : dist x W ≤ 1) (hy : dist y W' ≤ 1)
    (hxy : dist x y = 1) : dist x W = 1 := by
  have := dist_triangle4 W x y W'
  rw [dist_comm W x] at this
  linarith

/-- `triCoord` is linear. -/
theorem triCoord_combo (x y : ℂ) (a b : ℝ) :
    triCoord (a • x + b • y) = (a * (triCoord x).1 + b * (triCoord y).1, a * (triCoord x).2 + b * (triCoord y).2) := by
  simp only [triCoord, Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul, Prod.mk.injEq]
  constructor <;> ring

/-- The down triangle of the cell `(m, n)` in lattice coordinates: `a ≤ m + 1`, `b ≤ n + 1`, `a + b ≥ m + n + 1`. -/
theorem triCoord_mem_downTri {m n : ℤ} {z : ℂ}
    (hz : z ∈ convexHull ℝ {tri (m + 1) n, tri m (n + 1), tri (m + 1) (n + 1)}) :
    (triCoord z).1 ≤ m + 1 ∧ (triCoord z).2 ≤ n + 1 ∧ (m : ℝ) + n + 1 ≤ (triCoord z).1 + (triCoord z).2 := by
  refine convexHull_min (t := {z : ℂ | (triCoord z).1 ≤ m + 1 ∧ (triCoord z).2 ≤ n + 1 ∧
    (m : ℝ) + n + 1 ≤ (triCoord z).1 + (triCoord z).2}) ?_ ?_ hz
  · intro w hw
    simp only [mem_insert_iff, mem_singleton_iff] at hw
    rcases hw with rfl | rfl | rfl <;> simp only [mem_setOf_eq, triCoord_tri] <;> push_cast <;>
      refine ⟨by linarith, by linarith, by linarith⟩
  · intro x hx y hy a b ha hb hab
    simp only [mem_setOf_eq, triCoord_combo] at hx hy ⊢
    obtain ⟨hx1, hx2, hx3⟩ := hx
    obtain ⟨hy1, hy2, hy3⟩ := hy
    obtain rfl : b = 1 - a := by linarith
    refine ⟨?_, ?_, ?_⟩ <;> nlinarith [mul_le_mul_of_nonneg_left hx1 ha, mul_le_mul_of_nonneg_left hy1 hb,
      mul_le_mul_of_nonneg_left hx2 ha, mul_le_mul_of_nonneg_left hy2 hb, mul_le_mul_of_nonneg_left hx3 ha,
      mul_le_mul_of_nonneg_left hy3 hb]

/-- The norm `√triQ` is subadditive. -/
theorem sqrt_triQ_add_le (a b c d : ℝ) : √(triQ (a + c) (b + d)) ≤ √(triQ a b) + √(triQ c d) := by
  have h1 := dist_add_mul (a + c) (b + d) 0 0
  have h2 := dist_add_mul a b 0 0
  have h3 := dist_add_mul c d 0 0
  simp only [sub_zero, ofReal_zero, zero_mul, add_zero, dist_zero_right] at h1 h2 h3
  rw [← h1, ← h2, ← h3, show ((a + c : ℝ) : ℂ) + ((b + d : ℝ) : ℂ) * e (π / 3) =
    ((a : ℂ) + b * e (π / 3)) + ((c : ℂ) + d * e (π / 3)) by push_cast; ring]
  exact norm_add_le _ _

theorem triQ_neg (a b : ℝ) : triQ (-a) (-b) = triQ a b := by unfold triQ; ring

/-- A down tile in lattice coordinates, with its three bulge tests. -/
theorem r7Down_coords {m n : ℤ} {z : ℂ} (hz : z ∈ r7Down m n) :
    (triCoord z).1 - m ≤ 1 ∧ (triCoord z).2 - n ≤ 1 ∧ 1 ≤ (triCoord z).1 - m + ((triCoord z).2 - n) ∧
      1 < triQ ((triCoord z).1 - m) ((triCoord z).2 - n) ∧ 1 < triQ ((triCoord z).1 - m - 2) ((triCoord z).2 - n) ∧
      1 < triQ ((triCoord z).1 - m) ((triCoord z).2 - n - 2) := by
  obtain ⟨hT, h1, h2, h3⟩ := hz
  obtain ⟨t1, t2, t3⟩ := triCoord_mem_downTri hT
  rw [dist_eq_triQ, triCoord_tri, Real.lt_sqrt zero_le_one, one_pow] at h1 h2 h3
  push_cast at h1 h2 h3
  refine ⟨by linarith, by linarith, by linarith, h1, by convert h2 using 2; ring, by convert h3 using 2; ring⟩

/-- **Within one up tile** a unit pair has a vertex at one end and the opposite arc at the other, so `x` is at distance `1` from
a lattice point. -/
theorem r7Up_unitPair {m n : ℤ} {x y : ℂ} (hx : x ∈ r7Up m n) (hy : y ∈ r7Up m n) (hxy : dist x y = 1) :
    ∃ m' n' : ℤ, dist x (tri m' n') = 1 := by
  obtain ⟨⟨hx1, hx2⟩, hx3⟩ := hx
  obtain ⟨⟨hy1, hy2⟩, hy3⟩ := hy
  rw [mem_closedBall] at hx1 hx2 hx3 hy1 hy2 hy3
  have d12 : dist (tri m n) (tri (m + 1) n) = 1 := by rw [dist_tri]; push_cast; norm_num [triQ]
  have d13 : dist (tri m n) (tri m (n + 1)) = 1 := by rw [dist_tri]; push_cast; norm_num [triQ]
  have d23 : dist (tri (m + 1) n) (tri m (n + 1)) = 1 := by rw [dist_tri]; push_cast; norm_num [triQ]
  rcases reuleaux_unitPair d12 d13 d23 hx1 hx2 hx3 hy1 hy2 hy3 hxy with h | h | h
  · exact ⟨_, _, h⟩
  · exact ⟨_, _, h⟩
  · exact ⟨_, _, h⟩

/-- **Two up tiles of one colour** (`λ' − λ ∈ 2Λ ∖ 0`) meet the unit distance only at a pair of lattice points (a half-plane
separation along the offset; offsets of length `> 2` are too far). -/
theorem r7Up_sep {m n m' n' : ℤ} (hne : (m, n) ≠ (m', n')) (hc : r7UpCol m n = r7UpCol m' n') {x y : ℂ}
    (hx : x ∈ r7Up m n) (hy : y ∈ r7Up m' n') (hxy : dist x y = 1) : ∃ m'' n'' : ℤ, dist x (tri m'' n'') = 1 := by
  have hc' := congrArg Fin.val hc
  simp only [r7UpCol] at hc'
  obtain ⟨p, rfl⟩ : ∃ p, m' = m + 2 * p := ⟨(m' - m) / 2, by omega⟩
  obtain ⟨q, rfl⟩ : ∃ q, n' = n + 2 * q := ⟨(n' - n) / 2, by omega⟩
  obtain ⟨⟨hx1, hx2⟩, hx3⟩ := hx
  obtain ⟨⟨hy1, hy2⟩, hy3⟩ := hy
  rw [mem_closedBall] at hx1 hx2 hx3 hy1 hy2 hy3
  have hpq : (p, q) ≠ (0, 0) := fun h => hne (by simp only [Prod.mk.injEq] at h ⊢; omega)
  by_cases hfar : 3 ≤ p * p + p * q + q * q
  · exfalso
    have hd : 3 < dist (tri m n) (tri (m + 2 * p) (n + 2 * q)) := by
      rw [dist_tri, Real.lt_sqrt (by norm_num)]
      have : (3 : ℝ) ≤ (p : ℝ) * p + p * q + q * q := by exact_mod_cast hfar
      unfold triQ; push_cast; nlinarith
    have := dist_triangle4 (tri m n) x y (tri (m + 2 * p) (n + 2 * q))
    rw [dist_comm (tri m n) x] at this
    linarith
  push Not at hfar
  have hq : -1 ≤ q ∧ q ≤ 1 := by constructor <;> nlinarith [sq_nonneg (2 * p + q)]
  have hp : -1 ≤ p ∧ p ≤ 1 := by constructor <;> nlinarith [sq_nonneg (2 * q + p)]
  have d3 : ∀ a b c d : ℤ, (c - a, d - b) ∈ ({(3, 0), (0, 3), (-3, 0), (0, -3), (3, -3), (-3, 3)} : Set (ℤ × ℤ)) →
      dist (tri a b) (tri c d) = 3 := by
    intro a b c d h
    rw [dist_tri, show (3 : ℝ) = √9 by rw [show (9 : ℝ) = 3 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
    congr 1
    simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq] at h
    rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ <;>
    · have e1 : ((a : ℝ) - c) = -((c - a : ℤ) : ℝ) := by push_cast; ring
      have e2 : ((b : ℝ) - d) = -((d - b : ℤ) : ℝ) := by push_cast; ring
      rw [e1, e2, h1, h2]; norm_num [triQ]
  obtain ⟨hp1, hp2⟩ := hp
  obtain ⟨hq1, hq2⟩ := hq
  interval_cases p <;> interval_cases q <;> simp only [ne_eq, Prod.mk.injEq, not_true_eq_false, and_self] at hpq <;>
    norm_num at hfar
  · exact ⟨_, _, dist_eq_one_of_three (d3 _ _ _ _ (by simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega))
      hx2 hy1 hxy⟩
  · exact ⟨_, _, dist_eq_one_of_three (d3 _ _ _ _ (by simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega))
      hx2 hy3 hxy⟩
  · exact ⟨_, _, dist_eq_one_of_three (d3 _ _ _ _ (by simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega))
      hx3 hy1 hxy⟩
  · exact ⟨_, _, dist_eq_one_of_three (d3 _ _ _ _ (by simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega))
      hx1 hy3 hxy⟩
  · exact ⟨_, _, dist_eq_one_of_three (d3 _ _ _ _ (by simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega))
      hx3 hy2 hxy⟩
  · exact ⟨_, _, dist_eq_one_of_three (d3 _ _ _ _ (by simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega))
      hx1 hy2 hxy⟩

/-- **Down tiles carry no unit pair of one colour**: within a tile (inside a unit triangle, vertices excluded) and across tiles
of one colour (`λ' − λ ∈ M ∖ 0`, the bulges keep them apart). -/
theorem r7Down_dist_ne_one {m n m' n' : ℤ} (hc : r7DownCol m n = r7DownCol m' n') {x y : ℂ} (hx : x ∈ r7Down m n)
    (hy : y ∈ r7Down m' n') : dist x y ≠ 1 := by
  have hc' := congrArg Fin.val hc
  simp only [r7DownCol] at hc'
  obtain ⟨p, rfl⟩ : ∃ p, m' = m + p := ⟨m' - m, by ring⟩
  obtain ⟨q, rfl⟩ : ∃ q, n' = n + q := ⟨n' - n, by ring⟩
  have hpq : (p - q) % 3 = 0 := by omega
  obtain ⟨hu1, hv1, huv, ex1, ex2, ex3⟩ := r7Down_coords hx
  obtain ⟨hu1', hv1', huv', ey1, ey2, ey3⟩ := r7Down_coords hy
  rw [dist_eq_triQ]
  intro h
  push_cast at hu1' hv1' huv' ey1 ey2 ey3
  set u := (triCoord x).1 - m with hu
  set v := (triCoord x).2 - n with hv
  set u' := (triCoord y).1 - (m + p) with hu'
  set v' := (triCoord y).2 - (n + q) with hv'
  have hX : (triCoord x).1 - (triCoord y).1 = u - u' - p := by rw [hu, hu']; ring
  have hY : (triCoord x).2 - (triCoord y).2 = v - v' - q := by rw [hv, hv']; ring
  rw [hX, hY] at h
  have hsq : triQ (u - u' - p) (v - v' - q) = 1 := by
    have := congrArg (· ^ 2) h
    simp only [one_pow] at this
    rwa [Real.sq_sqrt (triQ_nonneg _ _)] at this
  clear_value u v u' v'
  -- the centroid bound
  have hcen : ∀ a b : ℝ, a ≤ 1 → b ≤ 1 → 1 ≤ a + b → √(triQ (a - 2 / 3) (b - 2 / 3)) < 0.6 := by
    intro a b ha hb hab
    rw [Real.sqrt_lt' (by norm_num)]
    unfold triQ
    nlinarith [mul_nonneg (sub_nonneg.2 ha) (sub_nonneg.2 hb), mul_nonneg (sub_nonneg.2 ha) (sub_nonneg.2 hab),
      mul_nonneg (sub_nonneg.2 hb) (sub_nonneg.2 hab)]
  by_cases hfar : 5 ≤ p * p + p * q + q * q
  · have hfar' : (5 : ℝ) ≤ triQ (p : ℝ) q := by
      have : (5 : ℝ) ≤ (p : ℝ) * p + p * q + q * q := by exact_mod_cast hfar
      unfold triQ; nlinarith
    have e1 := sqrt_triQ_add_le (u - u' - p) (v - v' - q) ((u' - 2 / 3) + -(u - 2 / 3)) ((v' - 2 / 3) + -(v - 2 / 3))
    have e2 := sqrt_triQ_add_le (u' - 2 / 3) (v' - 2 / 3) (-(u - 2 / 3)) (-(v - 2 / 3))
    rw [triQ_neg] at e2
    rw [show u - u' - p + ((u' - 2 / 3) + -(u - 2 / 3)) = -p by ring,
      show v - v' - q + ((v' - 2 / 3) + -(v - 2 / 3)) = -q by ring, triQ_neg, h] at e1
    have e3 := hcen u v hu1 hv1 huv
    have e4 := hcen u' v' hu1' hv1' huv'
    have e5 : √5 ≤ √(triQ (p : ℝ) q) := Real.sqrt_le_sqrt hfar'
    have e6 : (2.2 : ℝ) < √5 := by rw [Real.lt_sqrt (by norm_num)]; norm_num
    linarith
  push Not at hfar
  have hq : -2 ≤ q ∧ q ≤ 2 := by constructor <;> nlinarith [sq_nonneg (2 * p + q)]
  have hp : -2 ≤ p ∧ p ≤ 2 := by constructor <;> nlinarith [sq_nonneg (2 * q + p)]
  obtain ⟨hp1, hp2⟩ := hp
  obtain ⟨hq1, hq2⟩ := hq
  have hu0 : 0 ≤ u := by linarith
  have hv0 : 0 ≤ v := by linarith
  have hu0' : 0 ≤ u' := by linarith
  have hv0' : 0 ≤ v' := by linarith
  interval_cases p <;> interval_cases q <;> (try norm_num at hpq) <;> (try norm_num at hfar)
  all_goals push_cast at hsq
  · -- (−2, 1): `y`'s second test, the frame `(1, 1 − ω)`
    have k1 : triQ (u - u' - -2) (v - v' - 1) = triQ ((2 - u' - v') + (u + v - 1)) (v' + (1 - v)) := by unfold triQ; ring
    have k2 : triQ (2 - u' - v') v' = triQ (u' - 2) v' := by unfold triQ; ring
    have := triQ_le_add (P := 2 - u' - v') (Q := v') (R := u + v - 1) (S := 1 - v) (by linarith) hv0' (by linarith)
      (by linarith)
    linarith
  · -- (−1, −1): `x`'s first test
    have k1 : triQ (u - u' - -1) (v - v' - -1) = triQ (u + (1 - u')) (v + (1 - v')) := by unfold triQ; ring
    have := triQ_le_add (P := u) (Q := v) (R := 1 - u') (S := 1 - v') hu0 hv0 (by linarith) (by linarith)
    linarith
  · -- (−1, 2): `x`'s third test, the frame `(ω, ω − 1)`
    have k1 : triQ (u - u' - -1) (v - v' - 2) = triQ (u + (1 - u')) ((2 - u - v) + (u' + v' - 1)) := by unfold triQ; ring
    have k2 : triQ u (2 - u - v) = triQ u (v - 2) := by unfold triQ; ring
    have := triQ_le_add (P := u) (Q := 2 - u - v) (R := 1 - u') (S := u' + v' - 1) hu0 (by linarith) (by linarith)
      (by linarith)
    linarith
  · -- (0, 0): within one tile only two vertices are `1` apart, and the tests exclude every vertex
    have key : 2 - 2 * triQ (u - u' - 0) (v - v' - 0) = 2 * ((1 - v) * (1 - v') + (1 - u) * (1 - u') +
        (u + v - 1) * (u' + v' - 1)) + ((1 - v) * v + (1 - u) * u + (u + v - 1) * (2 - u - v)) +
        ((1 - v') * v' + (1 - u') * u' + (u' + v' - 1) * (2 - u' - v')) := by unfold triQ; ring
    rw [hsq] at key
    have n1 := mul_nonneg (sub_nonneg.2 hv1) (sub_nonneg.2 hv1')
    have n2 := mul_nonneg (sub_nonneg.2 hu1) (sub_nonneg.2 hu1')
    have n3 := mul_nonneg (sub_nonneg.2 huv) (sub_nonneg.2 huv')
    have n4 := mul_nonneg (sub_nonneg.2 hv1) hv0
    have n5 := mul_nonneg (sub_nonneg.2 hu1) hu0
    have n6 := mul_nonneg (sub_nonneg.2 huv) (by linarith : (0 : ℝ) ≤ 2 - u - v)
    have n7 := mul_nonneg (sub_nonneg.2 hv1') hv0'
    have n8 := mul_nonneg (sub_nonneg.2 hu1') hu0'
    have n9 := mul_nonneg (sub_nonneg.2 huv') (by linarith : (0 : ℝ) ≤ 2 - u' - v')
    have hv01 : (1 - v) * v = 0 := by linarith
    have hu01 : (1 - u) * u = 0 := by linarith
    rcases mul_eq_zero.1 hv01 with hv' | hv' <;> rcases mul_eq_zero.1 hu01 with hu' | hu'
    · have e1 : u = 1 := by linarith
      have e2 : v = 1 := by linarith
      rw [e1, e2] at ex2; norm_num [triQ] at ex2
    · have e2 : v = 1 := by linarith
      rw [hu', e2] at ex1; norm_num [triQ] at ex1
    · have e1 : u = 1 := by linarith
      rw [e1, hv'] at ex1; norm_num [triQ] at ex1
    · linarith
  · -- (1, −2): `y`'s third test
    have k1 : triQ (u - u' - 1) (v - v' - -2) = triQ (u' + (1 - u)) ((2 - u' - v') + (u + v - 1)) := by unfold triQ; ring
    have k2 : triQ u' (2 - u' - v') = triQ u' (v' - 2) := by unfold triQ; ring
    have := triQ_le_add (P := u') (Q := 2 - u' - v') (R := 1 - u) (S := u + v - 1) hu0' (by linarith) (by linarith)
      (by linarith)
    linarith
  · -- (1, 1): `y`'s first test
    have k1 : triQ (u - u' - 1) (v - v' - 1) = triQ (u' + (1 - u)) (v' + (1 - v)) := by unfold triQ; ring
    have := triQ_le_add (P := u') (Q := v') (R := 1 - u) (S := 1 - v) hu0' hv0' (by linarith) (by linarith)
    linarith
  · -- (2, −1): `x`'s second test
    have k1 : triQ (u - u' - 2) (v - v' - -1) = triQ ((2 - u - v) + (u' + v' - 1)) (v + (1 - v')) := by unfold triQ; ring
    have k2 : triQ (2 - u - v) v = triQ (u - 2) v := by unfold triQ; ring
    have := triQ_le_add (P := 2 - u - v) (Q := v) (R := u' + v' - 1) (S := 1 - v') (by linarith) hv0 (by linarith)
      (by linarith)
    linarith

/-- **Same-colour unit pairs of R7 start on a unit circle about a lattice point** (the case table, assembled). -/
theorem r7_unitPair_mem_sphere {x y : ℂ} (hxy : dist x y = 1) (hc : r7Col x = r7Col y) :
    ∃ m n : ℤ, dist x (tri m n) = 1 := by
  rcases r7Col_mem_tile x with ⟨m, n, hx, hcx⟩ | ⟨m, n, hx, hcx⟩ <;>
    rcases r7Col_mem_tile y with ⟨m', n', hy, hcy⟩ | ⟨m', n', hy, hcy⟩
  · by_cases h : (m, n) = (m', n')
    · obtain ⟨rfl, rfl⟩ := Prod.mk.inj h
      exact r7Up_unitPair hx hy hxy
    · exact r7Up_sep h (hcx.symm.trans (hc.trans hcy)) hx hy hxy
  · exact absurd (hcx.symm.trans (hc.trans hcy)) (r7UpCol_ne_r7DownCol _ _ _ _)
  · exact absurd (hcy.symm.trans (hc.symm.trans hcx)) (r7UpCol_ne_r7DownCol _ _ _ _)
  · exact absurd hxy (r7Down_dist_ne_one (hcx.symm.trans (hc.trans hcy)) hx hy)

/-- A measurable set whose unit pairs all start in a null set has null unit pairs (`unitPairSet A ⊆ N ×ˢ univ`). -/
theorem unitPairsNull_of_unitPair_mem {A N : Set ℂ} (hN : volume N = 0)
    (h : ∀ x ∈ A, ∀ y ∈ A, dist x y = 1 → x ∈ N) : UnitPairsNull A := by
  have hsub : unitPairSet A ⊆ N ×ˢ univ := by
    rintro ⟨x, θ⟩ ⟨hx, hy⟩
    refine ⟨h x hx _ hy ?_, mem_univ _⟩
    rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
  unfold UnitPairsNull
  refine measure_mono_null hsub ?_
  rw [Measure.prod_prod, hN, zero_mul]

/-- The unit circles about the lattice points are null together (`MeasureTheory.Measure.addHaar_sphere`, countable union). -/
theorem volume_iUnion_sphere_tri : volume (⋃ (m : ℤ) (n : ℤ), sphere (tri m n) 1) = 0 := by
  exact measure_iUnion_null fun m => measure_iUnion_null fun n => Measure.addHaar_sphere volume _ _

/-- **FS111-M-R7**, a.e.-properness: R7 is a measurable seven-colouring with null monochromatic unit pairs. -/
theorem r7_aeColouring : ∃ c : AeColouring 7, c.col = r7Col := by
  refine ⟨⟨r7Col, measurable_r7Col, fun j => ?_⟩, rfl⟩
  refine unitPairsNull_of_unitPair_mem volume_iUnion_sphere_tri fun x hx y hy hxy => ?_
  obtain ⟨m, n, h⟩ := r7_unitPair_mem_sphere hxy (hx.trans hy.symm)
  exact mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, by rw [mem_sphere]; exact h⟩⟩

/-- Inside the open cell `(0, 0)` and the open unit disc, R7's colour is `0` (`U(0, 0)`). -/
theorem r7ColTri_zero {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (ha1 : a < 1) (hb1 : b < 1) (hq : triQ a b ≤ 1) :
    r7ColTri a b = 0 := by
  have h1 : ⌊a⌋ = 0 := Int.floor_eq_zero_iff.2 ⟨ha.le, ha1⟩
  have h2 : ⌊b⌋ = 0 := Int.floor_eq_zero_iff.2 ⟨hb.le, hb1⟩
  unfold r7ColTri
  simp only [h1, h2, Int.cast_zero, sub_zero]
  rw [if_pos hq]
  rfl

/-- **FS111-M-R7**, tightness: at every `ε > 0` some class has non-null pairs at distances in `[1 − ε, 1 + ε]` (the
within-contacts of every up tile, vertex to opposite arc). -/
theorem r7_not_bandNull {ε : ℝ} (hε : 0 < ε) : ∃ j, ¬ BandNull (r7Cls j) ε := by
  refine ⟨0, fun hN => ?_⟩
  set W : Set ℂ := {z | 0 < (triCoord z).1 ∧ 0 < (triCoord z).2 ∧ (triCoord z).1 < 1 ∧ (triCoord z).2 < 1 ∧
    triQ (triCoord z).1 (triCoord z).2 < 1} with hW
  have hWo : IsOpen W := by
    have hc : Continuous triCoord := by
      unfold triCoord
      fun_prop
    have h1 : Continuous fun z => (triCoord z).1 := hc.fst
    have h2 : Continuous fun z => (triCoord z).2 := hc.snd
    have hq : Continuous fun z => triQ (triCoord z).1 (triCoord z).2 := by
      unfold triQ; fun_prop
    refine IsOpen.inter (isOpen_lt continuous_const h1) (IsOpen.inter (isOpen_lt continuous_const h2)
      (IsOpen.inter (isOpen_lt h1 continuous_const) (IsOpen.inter (isOpen_lt h2 continuous_const)
        (isOpen_lt hq continuous_const))))
  have hWc : W ⊆ r7Cls 0 := by
    intro z hz
    obtain ⟨h1, h2, h3, h4, h5⟩ := hz
    show r7Col z = 0
    exact r7ColTri_zero h1 h2 h3 h4 h5.le
  set ε' : ℝ := min ε (1 / 10) with hε'
  have hε'0 : 0 < ε' := lt_min hε (by norm_num)
  have hε'1 : ε' ≤ ε := min_le_left _ _
  have hε'2 : ε' ≤ 1 / 10 := min_le_right _ _
  set x0 : ℂ := ((ε' / 4 : ℝ) : ℂ) * e (π / 6)
  set y0 : ℂ := ((1 - ε' / 4 : ℝ) : ℂ) * e (π / 6)
  have hcoord : ∀ ρ : ℝ, triCoord (((ρ : ℝ) : ℂ) * e (π / 6)) = (ρ / √3, ρ / √3) := by
    intro ρ
    have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
    have h3p : (0:ℝ) < √3 := by positivity
    rw [e_eq, Real.cos_pi_div_six, Real.sin_pi_div_six, triCoord]
    simp only [mul_re, ofReal_re, add_re, ofReal_im, I_re, I_im, mul_im, add_im]
    norm_num
    constructor <;> (field_simp; try rw [h3]; try ring)
  have hx0 : x0 ∈ W := by
    have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
    have h3p : (0:ℝ) < √3 := by positivity
    have h3q : (1:ℝ) < √3 := by nlinarith [h3, h3p]
    show 0 < (triCoord x0).1 ∧ _
    rw [hcoord]
    simp only [triQ]
    refine ⟨by positivity, by positivity, ?_, ?_, ?_⟩
    · rw [div_lt_one h3p]; linarith
    · rw [div_lt_one h3p]; linarith
    · have : (ε' / 4 / √3) ^ 2 * 3 = (ε' / 4) ^ 2 := by rw [div_pow, h3]; ring
      nlinarith [this, sq_nonneg (ε' / 4 / √3)]
  have hy0 : y0 ∈ W := by
    have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
    have h3p : (0:ℝ) < √3 := by positivity
    have h3q : (1:ℝ) < √3 := by nlinarith [h3, h3p]
    show 0 < (triCoord y0).1 ∧ _
    rw [hcoord]
    simp only [triQ]
    have hpos : 0 < 1 - ε' / 4 := by linarith
    refine ⟨by positivity, by positivity, ?_, ?_, ?_⟩
    · rw [div_lt_one h3p]; linarith
    · rw [div_lt_one h3p]; linarith
    · have : ((1 - ε' / 4) / √3) ^ 2 * 3 = (1 - ε' / 4) ^ 2 := by rw [div_pow, h3]; ring
      nlinarith [this, sq_nonneg ((1 - ε' / 4) / √3)]
  have hd : dist x0 y0 = 1 - ε' / 2 := by
    have : x0 - y0 = ((ε' / 4 - (1 - ε' / 4) : ℝ) : ℂ) * e (π / 6) := by simp only [x0, y0]; push_cast; ring
    rw [dist_eq_norm, this, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [abs_of_neg (by linarith)]; ring
  set P : Set (ℂ × ℂ) := {q | q.1 ∈ W ∧ q.2 ∈ W ∧ 1 - ε' < dist q.1 q.2 ∧ dist q.1 q.2 < 1 + ε'} with hP
  have hPo : IsOpen P := by
    refine IsOpen.inter (hWo.preimage continuous_fst) (IsOpen.inter (hWo.preimage continuous_snd)
      (IsOpen.inter (isOpen_lt continuous_const (continuous_fst.dist continuous_snd))
        (isOpen_lt (continuous_fst.dist continuous_snd) continuous_const)))
  have hPn : (x0, y0) ∈ P := ⟨hx0, hy0, by rw [hd]; linarith, by rw [hd]; linarith⟩
  have hsub : P ⊆ bandPairSet (r7Cls 0) ε := by
    intro q hq
    exact ⟨hWc hq.1, hWc hq.2.1, by linarith [hq.2.2.1], by linarith [hq.2.2.2]⟩
  have hpos : 0 < (volume.prod volume) P := hPo.measure_pos _ ⟨_, hPn⟩
  exact hpos.ne' (measure_mono_null hsub hN)

/-- R7's classes are measurable. -/
theorem measurableSet_r7Cls (j : Fin 7) : MeasurableSet (r7Cls j) := measurable_r7Col (measurableSet_singleton j)

/-! ### R7's boundaries and maximality (FS131-I2l: children of `r7_boundary_lattice`, `r7_boundary_offLattice`,
`r7_phi_pos_up`, `r7_phi_pos_down`) -/

/-- `triCoord` is continuous. -/
theorem continuous_triCoord : Continuous triCoord := by unfold triCoord; fun_prop

/-- R7 inside the cell `(p, q)`: the three tests, read against the cell's corner. -/
theorem r7ColTri_of_cell {a b : ℝ} {p q : ℤ} (h1 : (p : ℝ) ≤ a) (h2 : a < p + 1) (h3 : (q : ℝ) ≤ b) (h4 : b < q + 1) :
    r7ColTri a b = if triQ (a - p) (b - q) ≤ 1 then r7UpCol p q else if triQ (a - p - 2) (b - q) ≤ 1 then r7UpCol (p + 1) q
      else if triQ (a - p) (b - q - 2) ≤ 1 then r7UpCol p (q + 1) else r7DownCol p q := by
  have e1 : ⌊a⌋ = p := Int.floor_eq_iff.2 ⟨h1, h2⟩
  have e2 : ⌊b⌋ = q := Int.floor_eq_iff.2 ⟨h3, h4⟩
  simp only [r7ColTri, e1, e2]

/-- A point is in the support of a set containing an open set that comes arbitrarily close to it. -/
theorem mem_essSupport_of_isOpen {S O : Set ℂ} {Q : ℂ} (hO : IsOpen O) (hOS : O ⊆ S)
    (h : ∀ r > 0, ∃ z ∈ O, dist z Q < r) : Q ∈ essSupport S := by
  intro r hr
  obtain ⟨z, hzO, hz⟩ := h r hr
  exact lt_of_lt_of_le ((hO.inter isOpen_ball).measure_pos volume ⟨z, hzO, by rw [mem_ball]; exact hz⟩)
    (measure_mono (inter_subset_inter_left _ hOS))

/-- `√(3 s²) < r` for `0 < s ≤ r/2`. -/
theorem sqrt_three_sq_lt {r s : ℝ} (hr : 0 < r) (hs : 0 < s) (hsr : s ≤ r / 2) : √(3 * s ^ 2) < r := by
  rw [Real.sqrt_lt' hr]; nlinarith

/-- The open up triangle of the cell `(p, q)`: lattice offsets `u, v > 0`, `u + v < 1`. -/
def r7UpOpen (p q : ℤ) : Set ℂ :=
  {z | 0 < (triCoord z).1 - p ∧ 0 < (triCoord z).2 - q ∧ (triCoord z).1 - p + ((triCoord z).2 - q) < 1}

/-- The open down tile of the cell `(p, q)`: lattice offsets in `(0, 1)²` outside the three closed bulge discs. -/
def r7DownOpen (p q : ℤ) : Set ℂ :=
  {z | 0 < (triCoord z).1 - p ∧ (triCoord z).1 - p < 1 ∧ 0 < (triCoord z).2 - q ∧ (triCoord z).2 - q < 1 ∧
    1 < triQ ((triCoord z).1 - p) ((triCoord z).2 - q) ∧ 1 < triQ ((triCoord z).1 - p - 2) ((triCoord z).2 - q) ∧
    1 < triQ ((triCoord z).1 - p) ((triCoord z).2 - q - 2)}

/-- The centroid of the up triangle `(0, 0)` is in `r7UpOpen 0 0`, the vertex `0` is not. -/
example : ((1 / 3 : ℝ) : ℂ) + ((1 / 3 : ℝ) : ℂ) * e (π / 3) ∈ r7UpOpen 0 0 ∧ (0 : ℂ) ∉ r7UpOpen 0 0 := by
  refine ⟨?_, fun h => ?_⟩
  · simp only [r7UpOpen, mem_setOf_eq, triCoord_add_mul]; norm_num
  · have := h.1; simp [triCoord] at this

/-- The centroid of the down triangle `(0, 0)` is in `r7DownOpen 0 0`; the centroid of the up triangle is not. -/
example : ((2 / 3 : ℝ) : ℂ) + ((2 / 3 : ℝ) : ℂ) * e (π / 3) ∈ r7DownOpen 0 0 ∧
    ((1 / 3 : ℝ) : ℂ) + ((1 / 3 : ℝ) : ℂ) * e (π / 3) ∉ r7DownOpen 0 0 := by
  refine ⟨?_, fun h => ?_⟩
  · simp only [r7DownOpen, mem_setOf_eq, triCoord_add_mul]; norm_num [triQ]
  · have := h.2.2.2.2.1; simp only [triCoord_add_mul] at this; norm_num [triQ] at this

theorem isOpen_r7UpOpen (p q : ℤ) : IsOpen (r7UpOpen p q) := by
  have f1 : Continuous fun z : ℂ => (triCoord z).1 - (p : ℝ) := continuous_triCoord.fst.sub continuous_const
  have f2 : Continuous fun z : ℂ => (triCoord z).2 - (q : ℝ) := continuous_triCoord.snd.sub continuous_const
  exact (isOpen_lt continuous_const f1).inter ((isOpen_lt continuous_const f2).inter (isOpen_lt (f1.add f2) continuous_const))

theorem isOpen_r7DownOpen (p q : ℤ) : IsOpen (r7DownOpen p q) := by
  have f1 : Continuous fun z : ℂ => (triCoord z).1 - (p : ℝ) := continuous_triCoord.fst.sub continuous_const
  have f2 : Continuous fun z : ℂ => (triCoord z).2 - (q : ℝ) := continuous_triCoord.snd.sub continuous_const
  have hT := continuous_triCoord
  have g1 : Continuous fun z : ℂ => triQ ((triCoord z).1 - p) ((triCoord z).2 - q) := by unfold triQ; fun_prop
  have g2 : Continuous fun z : ℂ => triQ ((triCoord z).1 - p - 2) ((triCoord z).2 - q) := by unfold triQ; fun_prop
  have g3 : Continuous fun z : ℂ => triQ ((triCoord z).1 - p) ((triCoord z).2 - q - 2) := by unfold triQ; fun_prop
  exact (isOpen_lt continuous_const f1).inter ((isOpen_lt f1 continuous_const).inter ((isOpen_lt continuous_const f2).inter
    ((isOpen_lt f2 continuous_const).inter ((isOpen_lt continuous_const g1).inter ((isOpen_lt continuous_const g2).inter
      (isOpen_lt continuous_const g3))))))

/-- The open up triangle has the up tile's colour (the first test holds: `triQ u v ≤ (u + v)² < 1`). -/
theorem r7UpOpen_subset (p q : ℤ) : r7UpOpen p q ⊆ r7Cls (r7UpCol p q) := by
  intro z hz
  obtain ⟨h1, h2, h3⟩ := hz
  show r7ColTri (triCoord z).1 (triCoord z).2 = r7UpCol p q
  rw [r7ColTri_of_cell (p := p) (q := q) (by linarith) (by linarith) (by linarith) (by linarith), if_pos]
  unfold triQ; nlinarith

/-- The open down tile has the down tile's colour (all three tests fail). -/
theorem r7DownOpen_subset (p q : ℤ) : r7DownOpen p q ⊆ r7Cls (r7DownCol p q) := by
  intro z hz
  obtain ⟨h1, h2, h3, h4, h5, h6, h7⟩ := hz
  show r7ColTri (triCoord z).1 (triCoord z).2 = r7DownCol p q
  rw [r7ColTri_of_cell (p := p) (q := q) (by linarith) (by linarith) (by linarith) (by linarith), if_neg (not_le.2 h5),
    if_neg (not_le.2 h6), if_neg (not_le.2 h7)]

/-- The three vertices of the up triangle are in the closure of `r7UpOpen`. -/
theorem mem_closure_r7UpOpen (p q : ℤ) {Q : ℂ} (hQ : Q = tri p q ∨ Q = tri (p + 1) q ∨ Q = tri p (q + 1)) :
    Q ∈ closure (r7UpOpen p q) := by
  rw [Metric.mem_closure_iff]
  intro r hr
  set s := min (r / 2) (1 / 4) with hsdef
  have hs0 : 0 < s := lt_min (half_pos hr) (by norm_num)
  have hs1 : s ≤ r / 2 := min_le_left _ _
  have hs2 : s ≤ 1 / 4 := min_le_right _ _
  have hd := sqrt_three_sq_lt hr hs0 hs1
  rcases hQ with rfl | rfl | rfl
  · refine ⟨((p + s : ℝ) : ℂ) + ((q + s : ℝ) : ℂ) * e (π / 3), ?_, ?_⟩
    · simp only [r7UpOpen, mem_setOf_eq, triCoord_add_mul]; refine ⟨by linarith, by linarith, by linarith⟩
    · rw [tri_eq, dist_add_mul]; convert hd using 2; unfold triQ; ring
  · refine ⟨((p + 1 - 2 * s : ℝ) : ℂ) + ((q + s : ℝ) : ℂ) * e (π / 3), ?_, ?_⟩
    · simp only [r7UpOpen, mem_setOf_eq, triCoord_add_mul]; refine ⟨by linarith, by linarith, by linarith⟩
    · rw [tri_eq, dist_add_mul]; convert hd using 2; push_cast; unfold triQ; ring
  · refine ⟨((p + s : ℝ) : ℂ) + ((q + 1 - 2 * s : ℝ) : ℂ) * e (π / 3), ?_, ?_⟩
    · simp only [r7UpOpen, mem_setOf_eq, triCoord_add_mul]; refine ⟨by linarith, by linarith, by linarith⟩
    · rw [tri_eq, dist_add_mul]; convert hd using 2; push_cast; unfold triQ; ring

/-- The three cusps of the down tile are in the closure of `r7DownOpen` (each reached along its horn). -/
theorem mem_closure_r7DownOpen (p q : ℤ) {Q : ℂ}
    (hQ : Q = tri (p + 1) q ∨ Q = tri p (q + 1) ∨ Q = tri (p + 1) (q + 1)) : Q ∈ closure (r7DownOpen p q) := by
  rw [Metric.mem_closure_iff]
  intro r hr
  set s := min (r / 2) (1 / 4) with hsdef
  have hs0 : 0 < s := lt_min (half_pos hr) (by norm_num)
  have hs1 : s ≤ r / 2 := min_le_left _ _
  have hs2 : s ≤ 1 / 4 := min_le_right _ _
  have hd := sqrt_three_sq_lt hr hs0 hs1
  rcases hQ with rfl | rfl | rfl
  · refine ⟨((p + (1 - s) : ℝ) : ℂ) + ((q + 2 * s : ℝ) : ℂ) * e (π / 3), ?_, ?_⟩
    · simp only [r7DownOpen, mem_setOf_eq, triCoord_add_mul, add_sub_cancel_left]
      refine ⟨by linarith, by linarith, by linarith, by linarith, ?_, ?_, ?_⟩ <;> unfold triQ <;> nlinarith
    · rw [tri_eq, dist_add_mul]; convert hd using 2; push_cast; unfold triQ; ring
  · refine ⟨((p + 2 * s : ℝ) : ℂ) + ((q + (1 - s) : ℝ) : ℂ) * e (π / 3), ?_, ?_⟩
    · simp only [r7DownOpen, mem_setOf_eq, triCoord_add_mul, add_sub_cancel_left]
      refine ⟨by linarith, by linarith, by linarith, by linarith, ?_, ?_, ?_⟩ <;> unfold triQ <;> nlinarith
    · rw [tri_eq, dist_add_mul]; convert hd using 2; push_cast; unfold triQ; ring
  · refine ⟨((p + (1 - s) : ℝ) : ℂ) + ((q + (1 - s) : ℝ) : ℂ) * e (π / 3), ?_, ?_⟩
    · simp only [r7DownOpen, mem_setOf_eq, triCoord_add_mul, add_sub_cancel_left]
      refine ⟨by linarith, by linarith, by linarith, by linarith, ?_, ?_, ?_⟩ <;> unfold triQ <;> nlinarith
    · rw [tri_eq, dist_add_mul]; convert hd using 2; push_cast; unfold triQ; ring

/-- A point of the closure of an open subset is in the support. -/
theorem mem_essSupport_of_mem_closure {S O : Set ℂ} {Q : ℂ} (hO : IsOpen O) (hOS : O ⊆ S) (hQ : Q ∈ closure O) :
    Q ∈ essSupport S :=
  mem_essSupport_of_isOpen hO hOS fun r hr => by
    obtain ⟨z, hz, hd⟩ := Metric.mem_closure_iff.1 hQ r hr
    exact ⟨z, hz, by rw [dist_comm]; exact hd⟩

/-- **A vertex of an up tile is in the support of the tile's colour.** -/
theorem r7Up_vertex_mem_essSupport (p q : ℤ) {Q : ℂ} (hQ : Q = tri p q ∨ Q = tri (p + 1) q ∨ Q = tri p (q + 1)) :
    Q ∈ essSupport (r7Cls (r7UpCol p q)) :=
  mem_essSupport_of_mem_closure (isOpen_r7UpOpen p q) (r7UpOpen_subset p q) (mem_closure_r7UpOpen p q hQ)

/-- **A cusp of a down tile is in the support of the tile's colour.** -/
theorem r7Down_cusp_mem_essSupport (p q : ℤ) {Q : ℂ}
    (hQ : Q = tri (p + 1) q ∨ Q = tri p (q + 1) ∨ Q = tri (p + 1) (q + 1)) : Q ∈ essSupport (r7Cls (r7DownCol p q)) :=
  mem_essSupport_of_mem_closure (isOpen_r7DownOpen p q) (r7DownOpen_subset p q) (mem_closure_r7DownOpen p q hQ)

/-- **Every down colour is in the support at every lattice point** (the three down tiles cusped there carry the three down
colours). -/
theorem r7_down_mem_essSupport (P R : ℤ) {d : Fin 7} (hd : 4 ≤ d.val) : tri P R ∈ essSupport (r7Cls d) := by
  have : d = r7DownCol (P - 1) R ∨ d = r7DownCol P (R - 1) ∨ d = r7DownCol (P - 1) (R - 1) := by
    simp only [Fin.ext_iff, r7DownCol]; omega
  rcases this with rfl | rfl | rfl
  · exact r7Down_cusp_mem_essSupport _ _ (Or.inl (by rw [sub_add_cancel]))
  · exact r7Down_cusp_mem_essSupport _ _ (Or.inr (Or.inl (by rw [sub_add_cancel])))
  · exact r7Down_cusp_mem_essSupport _ _ (Or.inr (Or.inr (by rw [sub_add_cancel, sub_add_cancel])))

/-- A point near which a set is absent is not in its essential closure. -/
theorem not_mem_essClosure_of_eventually {S : Set ℂ} {x : ℂ} (h : ∀ᶠ z in 𝓝 x, z ∉ S) : x ∉ essClosure S := by
  obtain ⟨r, hr, hball⟩ := Metric.eventually_nhds_iff_ball.1 h
  intro hx
  have : upperDensityAt S x = 0 := upperDensityAt_eq_zero_of_null (half_pos hr) fun ρ _ hρr => by
    rw [show S ∩ closedBall x ρ = ∅ from eq_empty_of_forall_notMem fun z hz =>
      hball z (by rw [mem_ball]; exact lt_of_le_of_lt (mem_closedBall.1 hz.2) (by linarith)) hz.1]
    exact measure_empty
  exact hx.ne' this

/-- The tangency of the three bulge circles at the cell's corners, as the case analysis reads it: on the open cell, the first
circle misses the other two discs and the second misses the third. -/
theorem triQ_tangent {u v : ℝ} (hu0 : 0 < u) (hu1 : u < 1) (hv1 : v < 1) :
    (triQ u v = 1 → 1 < triQ (u - 2) v ∧ 1 < triQ u (v - 2)) ∧ (triQ (u - 2) v = 1 → 1 < triQ u (v - 2)) := by
  refine ⟨fun h => ⟨?_, ?_⟩, fun h => ?_⟩
  · by_contra hc
    push Not at hc
    have h1 : 0 ≤ v - (2 - 2 * u) := by unfold triQ at h hc; nlinarith
    unfold triQ at h
    nlinarith [mul_nonneg h1 (by linarith : (0 : ℝ) ≤ u + v + (2 - 2 * u)), mul_pos (sub_pos.2 hu1) (sub_pos.2 hu1)]
  · by_contra hc
    push Not at hc
    have h1 : 0 ≤ u - (2 - 2 * v) := by unfold triQ at h hc; nlinarith
    unfold triQ at h
    nlinarith [mul_nonneg h1 (by linarith : (0 : ℝ) ≤ u + v + (2 - 2 * v)), mul_pos (sub_pos.2 hv1) (sub_pos.2 hv1)]
  · have e : triQ u (v - 2) = triQ (u - 2) v + 2 * (u - v) := by unfold triQ; ring
    rw [e, h]
    by_contra hc
    push Not at hc
    unfold triQ at h
    nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ v - u) (by linarith : (0 : ℝ) ≤ 4 - u - 2 * v),
      mul_pos (sub_pos.2 hv1) (sub_pos.2 hv1)]

/-- **R7 off the lattice, locally**: near a point that is not a lattice point at most two colours occur, and when two do, the
point is on a unit circle about a lattice point in the support of both (the arc of an up tile facing a down tile). -/
theorem r7_local {x : ℂ} (hx : ∀ m n : ℤ, x ≠ tri m n) : ∃ c₁ c₂ : Fin 7,
    (∀ᶠ z in 𝓝 x, r7Col z = c₁ ∨ r7Col z = c₂) ∧
      (c₁ = c₂ ∨ ∃ m n : ℤ, dist x (tri m n) = 1 ∧ tri m n ∈ essSupport (r7Cls c₁) ∧ tri m n ∈ essSupport (r7Cls c₂)) := by
  set A := (triCoord x).1 with hA
  set B := (triCoord x).2 with hB
  set m := ⌊A⌋ with hm
  set n := ⌊B⌋ with hn
  have hm0 : (m : ℝ) ≤ A := Int.floor_le A
  have hm1 : A < m + 1 := Int.lt_floor_add_one A
  have hn0 : (n : ℝ) ≤ B := Int.floor_le B
  have hn1 : B < n + 1 := Int.lt_floor_add_one B
  have hc1 : Continuous fun z => (triCoord z).1 := continuous_triCoord.fst
  have hc2 : Continuous fun z => (triCoord z).2 := continuous_triCoord.snd
  have hq : ∀ α β : ℝ, Continuous fun z => triQ ((triCoord z).1 - α) ((triCoord z).2 - β) := by
    intro α β; have := continuous_triCoord; unfold triQ; fun_prop
  have evl : ∀ f : ℂ → ℝ, Continuous f → ∀ c, f x < c → ∀ᶠ z in 𝓝 x, f z < c := fun f hf c h =>
    hf.continuousAt (Iio_mem_nhds h)
  have evg : ∀ f : ℂ → ℝ, Continuous f → ∀ c, c < f x → ∀ᶠ z in 𝓝 x, c < f z := fun f hf c h =>
    hf.continuousAt (Ioi_mem_nhds h)
  have hxc : x = ((A : ℝ) : ℂ) + ((B : ℝ) : ℂ) * e (π / 3) := (triCoord_spec x).symm
  have hdist : ∀ p q : ℤ, dist x (tri p q) = √(triQ (A - p) (B - q)) := fun p q => by
    rw [hxc, tri_eq, dist_add_mul]
  by_cases hAm : A = m
  · -- on the lattice line `a = m`: one colour, `U(m, n)`'s
    have hBn : (n : ℝ) < B := lt_of_le_of_ne hn0 fun h => hx m n (by rw [hxc, tri_eq, ← hAm, ← h])
    refine ⟨r7UpCol m n, r7UpCol m n, ?_, Or.inl rfl⟩
    have t1 : triQ (A - m) (B - n) < 1 := by rw [hAm, sub_self]; unfold triQ; nlinarith
    have t2 : 1 < triQ (A - (m - 1)) (B - n) := by rw [hAm]; unfold triQ; nlinarith
    have t3 : triQ (A - (m - 1 + 2)) (B - n) < 1 := by rw [hAm]; unfold triQ; nlinarith
    filter_upwards [evg _ hc1 (m - 1) (by linarith), evl _ hc1 (m + 1) (by linarith), evg _ hc2 n hBn,
      evl _ hc2 (n + 1) hn1, evl _ (hq m n) 1 t1, evg _ (hq (m - 1) n) 1 t2, evl _ (hq (m - 1 + 2) n) 1 t3]
      with z z1 z2 z3 z4 z5 z6 z7
    left
    show r7ColTri (triCoord z).1 (triCoord z).2 = _
    by_cases hz : (m : ℝ) ≤ (triCoord z).1
    · rw [r7ColTri_of_cell (p := m) (q := n) hz z2 z3.le z4, if_pos z5.le]
    · push Not at hz
      rw [r7ColTri_of_cell (p := m - 1) (q := n) (by push_cast; linarith) (by push_cast; linarith) z3.le z4]
      push_cast
      rw [if_neg (not_le.2 z6), if_pos (by unfold triQ at z7 ⊢; linarith), sub_add_cancel]
  by_cases hBn : B = n
  · -- on the lattice line `b = n`: one colour, `U(m, n)`'s
    have hAm' : (m : ℝ) < A := lt_of_le_of_ne hm0 (Ne.symm hAm)
    refine ⟨r7UpCol m n, r7UpCol m n, ?_, Or.inl rfl⟩
    have t1 : triQ (A - m) (B - n) < 1 := by rw [hBn, sub_self]; unfold triQ; nlinarith
    have t2 : 1 < triQ (A - m) (B - (n - 1)) := by rw [hBn]; unfold triQ; nlinarith
    have t3 : 1 < triQ (A - (m + 2)) (B - (n - 1)) := by rw [hBn]; unfold triQ; nlinarith
    have t4 : triQ (A - m) (B - (n - 1 + 2)) < 1 := by rw [hBn]; unfold triQ; nlinarith
    filter_upwards [evg _ hc1 m hAm', evl _ hc1 (m + 1) hm1, evg _ hc2 (n - 1) (by linarith),
      evl _ hc2 (n + 1) hn1, evl _ (hq m n) 1 t1, evg _ (hq m (n - 1)) 1 t2, evg _ (hq (m + 2) (n - 1)) 1 t3,
      evl _ (hq m (n - 1 + 2)) 1 t4]
      with z z1 z2 z3 z4 z5 z6 z7 z8
    left
    show r7ColTri (triCoord z).1 (triCoord z).2 = _
    by_cases hz : (n : ℝ) ≤ (triCoord z).2
    · rw [r7ColTri_of_cell (p := m) (q := n) z1.le z2 hz z4, if_pos z5.le]
    · push Not at hz
      rw [r7ColTri_of_cell (p := m) (q := n - 1) z1.le z2 (by push_cast; linarith) (by push_cast; linarith)]
      push_cast
      rw [if_neg (not_le.2 z6), if_neg (not_le.2 (by unfold triQ at z7 ⊢; linarith)),
        if_pos (by unfold triQ at z8 ⊢; linarith), sub_add_cancel]
  -- the open cell
  have hAm' : (m : ℝ) < A := lt_of_le_of_ne hm0 (Ne.symm hAm)
  have hBn' : (n : ℝ) < B := lt_of_le_of_ne hn0 (Ne.symm hBn)
  obtain ⟨T1, T3⟩ := triQ_tangent (u := A - m) (v := B - n) (by linarith) (by linarith) (by linarith)
  have cell : ∀ᶠ z in 𝓝 x, (m : ℝ) ≤ (triCoord z).1 ∧ (triCoord z).1 < m + 1 ∧ (n : ℝ) ≤ (triCoord z).2 ∧
      (triCoord z).2 < n + 1 := by
    filter_upwards [evg _ hc1 m hAm', evl _ hc1 (m + 1) hm1, evg _ hc2 n hBn', evl _ hc2 (n + 1) hn1] with z z1 z2 z3 z4
    exact ⟨z1.le, z2, z3.le, z4⟩
  have hcol : ∀ z, (m : ℝ) ≤ (triCoord z).1 ∧ (triCoord z).1 < m + 1 ∧ (n : ℝ) ≤ (triCoord z).2 ∧ (triCoord z).2 < n + 1 →
      r7Col z = if triQ ((triCoord z).1 - m) ((triCoord z).2 - n) ≤ 1 then r7UpCol m n
        else if triQ ((triCoord z).1 - (m + 2)) ((triCoord z).2 - n) ≤ 1 then r7UpCol (m + 1) n
        else if triQ ((triCoord z).1 - m) ((triCoord z).2 - (n + 2)) ≤ 1 then r7UpCol m (n + 1) else r7DownCol m n := by
    rintro z ⟨z1, z2, z3, z4⟩
    show r7ColTri _ _ = _
    rw [r7ColTri_of_cell z1 z2 z3 z4]
    simp only [show ∀ a : ℝ, a - m - 2 = a - (m + 2) from fun a => by ring,
      show ∀ b : ℝ, b - n - 2 = b - (n + 2) from fun b => by ring]
  have e2 : triQ (A - m - 2) (B - n) = triQ (A - (m + 2)) (B - n) := by ring_nf
  have e3 : triQ (A - m) (B - n - 2) = triQ (A - m) (B - (n + 2)) := by ring_nf
  have hup : ∀ (p q : ℤ) (Q : ℂ), (Q = tri p q ∨ Q = tri (p + 1) q ∨ Q = tri p (q + 1)) →
      Q ∈ essSupport (r7Cls (r7UpCol p q)) := fun p q Q hQ => r7Up_vertex_mem_essSupport p q hQ
  have hdn : ∀ p q : ℤ, tri p q ∈ essSupport (r7Cls (r7DownCol m n)) := fun p q =>
    r7_down_mem_essSupport p q (by simp [r7DownCol])
  rcases lt_trichotomy (triQ (A - m) (B - n)) 1 with h1 | h1 | h1
  · refine ⟨r7UpCol m n, r7UpCol m n, ?_, Or.inl rfl⟩
    filter_upwards [cell, evl _ (hq m n) 1 h1] with z z1 z2
    left; rw [hcol z z1, if_pos z2.le]
  · obtain ⟨g2, g3⟩ := T1 h1
    refine ⟨r7UpCol m n, r7DownCol m n, ?_, Or.inr ⟨m, n, by rw [hdist, h1, Real.sqrt_one], hup m n _ (Or.inl rfl), hdn m n⟩⟩
    filter_upwards [cell, evg _ (hq (m + 2) n) 1 (by rw [← e2]; exact g2), evg _ (hq m (n + 2)) 1 (by rw [← e3]; exact g3)]
      with z z1 z2 z3
    rw [hcol z z1]
    split_ifs
    · left; rfl
    · exact absurd ‹_› (not_le.2 z2)
    · exact absurd ‹_› (not_le.2 z3)
    · right; rfl
  rcases lt_trichotomy (triQ (A - m - 2) (B - n)) 1 with h2 | h2 | h2
  · refine ⟨r7UpCol (m + 1) n, r7UpCol (m + 1) n, ?_, Or.inl rfl⟩
    filter_upwards [cell, evg _ (hq m n) 1 h1, evl _ (hq (m + 2) n) 1 (by rw [← e2]; exact h2)] with z z1 z2 z3
    left; rw [hcol z z1, if_neg (not_le.2 z2), if_pos z3.le]
  · have g3 := T3 h2
    refine ⟨r7UpCol (m + 1) n, r7DownCol m n, ?_, Or.inr ⟨m + 2, n, by rw [hdist]; push_cast; rw [← e2, h2, Real.sqrt_one],
      hup (m + 1) n _ (Or.inr (Or.inl (by congr 1; ring))), hdn _ _⟩⟩
    filter_upwards [cell, evg _ (hq m n) 1 h1, evg _ (hq m (n + 2)) 1 (by rw [← e3]; exact g3)] with z z1 z2 z3
    rw [hcol z z1, if_neg (not_le.2 z2)]
    split_ifs
    · left; rfl
    · exact absurd ‹_› (not_le.2 z3)
    · right; rfl
  rcases lt_trichotomy (triQ (A - m) (B - n - 2)) 1 with h3 | h3 | h3
  · refine ⟨r7UpCol m (n + 1), r7UpCol m (n + 1), ?_, Or.inl rfl⟩
    filter_upwards [cell, evg _ (hq m n) 1 h1, evg _ (hq (m + 2) n) 1 (by rw [← e2]; exact h2),
      evl _ (hq m (n + 2)) 1 (by rw [← e3]; exact h3)] with z z1 z2 z3 z4
    left; rw [hcol z z1, if_neg (not_le.2 z2), if_neg (not_le.2 z3), if_pos z4.le]
  · refine ⟨r7UpCol m (n + 1), r7DownCol m n, ?_, Or.inr ⟨m, n + 2, by rw [hdist]; push_cast; rw [← e3, h3, Real.sqrt_one],
      hup m (n + 1) _ (Or.inr (Or.inr (by congr 1; ring))), hdn _ _⟩⟩
    filter_upwards [cell, evg _ (hq m n) 1 h1, evg _ (hq (m + 2) n) 1 (by rw [← e2]; exact h2)] with z z1 z2 z3
    rw [hcol z z1, if_neg (not_le.2 z2), if_neg (not_le.2 z3)]
    split_ifs
    · left; rfl
    · right; rfl
  · refine ⟨r7DownCol m n, r7DownCol m n, ?_, Or.inl rfl⟩
    filter_upwards [cell, evg _ (hq m n) 1 h1, evg _ (hq (m + 2) n) 1 (by rw [← e2]; exact h2),
      evg _ (hq m (n + 2)) 1 (by rw [← e3]; exact h3)] with z z1 z2 z3 z4
    left; rw [hcol z z1, if_neg (not_le.2 z2), if_neg (not_le.2 z3), if_neg (not_le.2 z4)]

/-- **The colour absent at a lattice point**: an up tile of `λ₀ + 1 + ω`'s colour (mod `2Λ`) stays more than `7/10` from `λ₀`
(one of its vertices is at distance at least `√3`). -/
theorem r7_far_vertex {m n p q : ℤ} (hc : r7UpCol p q = r7UpCol (m + 1) (n + 1)) {z : ℂ} (hz : z ∈ r7Up p q) :
    7 / 10 < dist z (tri m n) := by
  have hc' := congrArg Fin.val hc
  simp only [r7UpCol] at hc'
  obtain ⟨⟨hz1, hz2⟩, hz3⟩ := hz
  rw [mem_closedBall] at hz1 hz2 hz3
  have h3 : (1.7 : ℝ) < √3 := by rw [Real.lt_sqrt (by norm_num)]; norm_num
  have key : ∀ V : ℂ, dist z V ≤ 1 → √3 ≤ dist V (tri m n) → 7 / 10 < dist z (tri m n) := by
    intro V hzV hV
    have := dist_triangle V z (tri m n)
    rw [dist_comm V z] at this
    linarith
  obtain ⟨P, hP⟩ : ∃ P, p = m + P := ⟨p - m, by ring⟩
  obtain ⟨Q, hQ⟩ : ∃ Q, q = n + Q := ⟨q - n, by ring⟩
  subst hP hQ
  have hPo : P % 2 = 1 := by omega
  have hQo : Q % 2 = 1 := by omega
  have hd : ∀ a b : ℤ, 3 ≤ a * a + a * b + b * b → √3 ≤ dist (tri (m + a) (n + b)) (tri m n) := by
    intro a b hab
    rw [dist_tri]
    apply Real.sqrt_le_sqrt
    have : (3 : ℝ) ≤ (a : ℝ) * a + a * b + b * b := by exact_mod_cast hab
    push_cast; unfold triQ; nlinarith
  by_cases hfar : 3 ≤ P * P + P * Q + Q * Q
  · exact key _ hz1 (hd P Q hfar)
  push Not at hfar
  have hQb : -1 ≤ Q ∧ Q ≤ 1 := by constructor <;> nlinarith [sq_nonneg (2 * P + Q)]
  have hPb : -1 ≤ P ∧ P ≤ 1 := by constructor <;> nlinarith [sq_nonneg (2 * Q + P)]
  obtain ⟨hP1, hP2⟩ := hPb
  obtain ⟨hQ1, hQ2⟩ := hQb
  interval_cases P <;> interval_cases Q <;> (try norm_num at hPo) <;> (try norm_num at hQo) <;> (try norm_num at hfar)
  · -- (P, Q) = (−1, 1): the vertex `λ + ω` is at offset `(−1, 2)`
    exact key _ hz3 (by rw [show n + 1 + 1 = n + 2 by ring]; exact hd (-1) 2 (by norm_num))
  · -- (P, Q) = (1, −1): the vertex `λ + 1` is at offset `(2, −1)`
    exact key _ hz2 (by rw [show m + 1 + 1 = m + 2 by ring]; exact hd 2 (-1) (by norm_num))

/-- **A point at distance `1` inside an open part of `A` gives `φ_A > 0`** (an open arc of directions lands in it). -/
theorem phi_pos_of_mem_open {A O : Set ℂ} (hA : MeasurableSet A) (hO : IsOpen O) (hOA : O ⊆ A) {p q : ℂ} (hq : q ∈ O)
    (hpq : dist p q = 1) : 0 < phi A p := by
  set α : ℝ := Complex.arg (q - p)
  have hα : p + e α = q := by
    have h := self_eq_norm_mul_e_arg (q - p)
    rw [← dist_eq_norm, dist_comm, hpq, ofReal_one, one_mul] at h
    rw [← h]; ring
  have hopen : IsOpen {θ : ℝ | p + e θ ∈ O} := hO.preimage (continuous_const.add continuous_e)
  obtain ⟨ε₀, hε₀, hball⟩ := Metric.isOpen_iff.1 hopen α (by simp only [mem_setOf_eq]; rw [hα]; exact hq)
  set ε := min ε₀ Real.pi
  have hε : 0 < ε := lt_min hε₀ Real.pi_pos
  have hS : MeasurableSet {θ : ℝ | p + e θ ∈ A} := hA.preimage (continuous_const.add continuous_e).measurable
  have hper : ∀ θ, θ + 2 * Real.pi ∈ {θ : ℝ | p + e θ ∈ A} ↔ θ ∈ {θ : ℝ | p + e θ ∈ A} := by
    intro θ; simp only [mem_setOf_eq, e_add_two_pi]
  have hsub : Ioo (α - ε) (α + ε) ⊆ {θ : ℝ | p + e θ ∈ A} := by
    intro θ hθ
    have : θ ∈ ball α ε₀ := by
      rw [Real.ball_eq_Ioo]; exact ⟨by linarith [hθ.1, min_le_left ε₀ Real.pi], by linarith [hθ.2, min_le_left ε₀ Real.pi]⟩
    exact hOA (hball this)
  exact lt_of_lt_of_le (ENNReal.ofReal_pos.2 (by linarith)) (arcLength_ge_of_Ioo hS hper (min_le_right _ _) hsub)

/-- **`φ_A > 0` from a star-shaped open part of `A` reaching both inside and outside the unit circle about `p`** (the
intermediate value theorem along the two segments through the star's centre). -/
theorem phi_pos_of_star {A O : Set ℂ} (hA : MeasurableSet A) (hO : IsOpen O) (hOA : O ⊆ A) {c : ℂ}
    (hstar : ∀ z ∈ O, ∀ t : ℝ, 0 ≤ t → t ≤ 1 → (1 - t) • c + t • z ∈ O) {p P₁ P₂ : ℂ} (h₁ : P₁ ∈ closure O)
    (h₂ : P₂ ∈ closure O) (hd₁ : dist p P₁ < 1) (hd₂ : 1 < dist p P₂) : 0 < phi A p := by
  obtain ⟨a, haO, ha⟩ := Metric.mem_closure_iff.1 h₁ (1 - dist p P₁) (by linarith)
  obtain ⟨b, hbO, hb⟩ := Metric.mem_closure_iff.1 h₂ (dist p P₂ - 1) (by linarith)
  have hpa : dist p a < 1 := by linarith [dist_triangle p P₁ a]
  have hpb : 1 < dist p b := by linarith [dist_triangle p b P₂, dist_comm b P₂]
  have seg : ∀ z ∈ O, (dist p c ≤ 1 ∧ 1 ≤ dist p z) ∨ (dist p z ≤ 1 ∧ 1 ≤ dist p c) → ∃ q ∈ O, dist p q = 1 := by
    intro z hz hcase
    set f : ℝ → ℝ := fun t => dist p ((1 - t) • c + t • z) with hf
    have hfc : Continuous f := by
      apply continuous_const.dist
      exact ((continuous_const.sub continuous_id).smul continuous_const).add (continuous_id.smul continuous_const)
    have hf0 : f 0 = dist p c := by simp [hf]
    have hf1 : f 1 = dist p z := by simp [hf]
    have hmem : (1 : ℝ) ∈ f '' Icc 0 1 := by
      rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact intermediate_value_Icc zero_le_one hfc.continuousOn ⟨by rw [hf0]; exact h1, by rw [hf1]; exact h2⟩
      · exact intermediate_value_Icc' zero_le_one hfc.continuousOn ⟨by rw [hf1]; exact h1, by rw [hf0]; exact h2⟩
    obtain ⟨t, ⟨ht0, ht1⟩, hft⟩ := hmem
    exact ⟨_, hstar z hz t ht0 ht1, hft⟩
  obtain ⟨q, hqO, hq⟩ : ∃ q ∈ O, dist p q = 1 := by
    rcases le_total (dist p c) 1 with h | h
    · exact seg b hbO (Or.inl ⟨h, hpb.le⟩)
    · exact seg a haO (Or.inr ⟨hpa.le, h⟩)
  exact phi_pos_of_mem_open hA hO hOA hqO hq

/-- The open up triangle is star-shaped (convex) about its centroid. -/
theorem r7UpOpen_star (p q : ℤ) : (((p : ℝ) + 1 / 3 : ℝ) : ℂ) + (((q : ℝ) + 1 / 3 : ℝ) : ℂ) * e (π / 3) ∈ r7UpOpen p q ∧
    ∀ z ∈ r7UpOpen p q, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
      (1 - t) • ((((p : ℝ) + 1 / 3 : ℝ) : ℂ) + (((q : ℝ) + 1 / 3 : ℝ) : ℂ) * e (π / 3)) + t • z ∈ r7UpOpen p q := by
  refine ⟨?_, fun z hz t ht0 ht1 => ?_⟩
  · simp only [r7UpOpen, mem_setOf_eq, triCoord_add_mul]; norm_num
  · obtain ⟨h1, h2, h3⟩ := hz
    simp only [r7UpOpen, mem_setOf_eq, triCoord_combo, triCoord_add_mul]
    refine ⟨by nlinarith, by nlinarith, by nlinarith⟩

/-- The convexity estimate behind the down tile's star shape: from a centre at `triQ`-distance `√(4/3)` from a disc centre,
the segment to a point outside the unit disc and within `√(1/3)` of the centre stays outside. -/
theorem triQ_star {a b c d t : ℝ} (ht0 : 0 ≤ t) (ht1 : t ≤ 1) (hc : triQ a c = 4 / 3) (hbd : 1 < triQ b d)
    (hg : triQ (b - a) (d - c) ≤ 1 / 3) : 1 < triQ ((1 - t) * a + t * b) ((1 - t) * c + t * d) := by
  have key : triQ ((1 - t) * a + t * b) ((1 - t) * c + t * d) =
      (1 - t) * triQ a c + t * triQ b d - t * (1 - t) * triQ (b - a) (d - c) := by unfold triQ; ring
  rw [key, hc]
  rcases eq_or_lt_of_le ht1 with rfl | h
  · simp; exact hbd
  · nlinarith [mul_nonneg ht0 (sub_nonneg.2 ht1), mul_nonneg (mul_nonneg ht0 (sub_nonneg.2 ht1)) (sub_nonneg.2 hg),
      mul_pos (sub_pos.2 h) (sub_pos.2 h), mul_nonneg ht0 (sub_nonneg.2 hbd.le)]

/-- The open down tile is star-shaped about its centroid. -/
theorem r7DownOpen_star (p q : ℤ) :
    (((p : ℝ) + 2 / 3 : ℝ) : ℂ) + (((q : ℝ) + 2 / 3 : ℝ) : ℂ) * e (π / 3) ∈ r7DownOpen p q ∧
    ∀ z ∈ r7DownOpen p q, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
      (1 - t) • ((((p : ℝ) + 2 / 3 : ℝ) : ℂ) + (((q : ℝ) + 2 / 3 : ℝ) : ℂ) * e (π / 3)) + t • z ∈ r7DownOpen p q := by
  refine ⟨?_, fun z hz t ht0 ht1 => ?_⟩
  · simp only [r7DownOpen, mem_setOf_eq, triCoord_add_mul]; norm_num [triQ]
  · obtain ⟨h1, h2, h3, h4, h5, h6, h7⟩ := hz
    set u := (triCoord z).1 - p with hu
    set v := (triCoord z).2 - q with hv
    have huv : 1 ≤ u + v := by
      by_contra hc; push Not at hc; unfold triQ at h5; nlinarith
    have hg : triQ (u - 2 / 3) (v - 2 / 3) ≤ 1 / 3 := by
      unfold triQ
      nlinarith [mul_nonneg (sub_nonneg.2 h2.le) (sub_nonneg.2 h4.le), mul_nonneg (sub_nonneg.2 h2.le) (sub_nonneg.2 huv),
        mul_nonneg (sub_nonneg.2 h4.le) (sub_nonneg.2 huv)]
    simp only [r7DownOpen, mem_setOf_eq, triCoord_combo, triCoord_add_mul]
    have e1 : (1 - t) * ((p : ℝ) + 2 / 3) + t * (triCoord z).1 - p = (1 - t) * (2 / 3) + t * u := by rw [hu]; ring
    have e2 : (1 - t) * ((q : ℝ) + 2 / 3) + t * (triCoord z).2 - q = (1 - t) * (2 / 3) + t * v := by rw [hv]; ring
    rw [e1, e2]
    refine ⟨by nlinarith, by nlinarith, by nlinarith, by nlinarith, ?_, ?_, ?_⟩
    · exact triQ_star ht0 ht1 (by norm_num [triQ]) h5 hg
    · have := triQ_star (a := 2 / 3 - 2) (b := u - 2) (c := 2 / 3) (d := v) ht0 ht1 (by norm_num [triQ]) h6
        (by convert hg using 2; ring)
      convert this using 2; ring
    · have := triQ_star (a := 2 / 3) (b := u) (c := 2 / 3 - 2) (d := v - 2) ht0 ht1 (by norm_num [triQ]) h7
        (by convert hg using 2; ring)
      convert this using 2; ring

/-- In a down triangle every vertex is within `1`: the squared distances to the vertices `λ + 1`, `λ + ω`, `λ + 1 + ω`. -/
theorem triQ_downTri_le {u v : ℝ} (hu : u ≤ 1) (hv : v ≤ 1) (huv : 1 ≤ u + v) :
    triQ (u - 1) v ≤ 1 ∧ triQ u (v - 1) ≤ 1 ∧ triQ (u - 1) (v - 1) ≤ 1 := by
  unfold triQ
  refine ⟨?_, ?_, ?_⟩
  · nlinarith [mul_nonneg (sub_nonneg.2 hu) (by linarith : (0 : ℝ) ≤ u + v - 1), mul_nonneg (sub_nonneg.2 hv) (by linarith : (0 : ℝ) ≤ 1 + v)]
  · nlinarith [mul_nonneg (sub_nonneg.2 hv) (by linarith : (0 : ℝ) ≤ u + v - 1), mul_nonneg (sub_nonneg.2 hu) (by linarith : (0 : ℝ) ≤ 1 + u)]
  · nlinarith [mul_nonneg (sub_nonneg.2 hu) (sub_nonneg.2 hv), mul_nonneg (sub_nonneg.2 hu) (by linarith : (0 : ℝ) ≤ u + v - 1),
      mul_nonneg (sub_nonneg.2 hv) (by linarith : (0 : ℝ) ≤ u + v - 1)]

/-- Off the unit circles about lattice points, `≤ 1` is `< 1` and `≥ 1` is `> 1`. -/
theorem dist_tri_ne_one {p : ℂ} (hp : p ∉ ⋃ (m : ℤ) (n : ℤ), sphere (tri m n) 1) (m n : ℤ) : dist p (tri m n) ≠ 1 :=
  fun h => hp (mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_sphere.2 h⟩⟩)

/-- Antipodal lattice points: a point within `1` of `V` is at least `1` from `W` when `|V − W| = 2`. -/
theorem one_le_dist_of_two {p V W : ℂ} (hVW : dist V W = 2) (hp : dist p V ≤ 1) : 1 ≤ dist p W := by
  have := dist_triangle V p W
  rw [dist_comm V p] at this
  linarith

theorem dist_tri_two (a b c d : ℤ) (h : (c - a, d - b) ∈ ({(2, 0), (0, 2), (2, -2), (-2, 0), (0, -2), (-2, 2)} : Set (ℤ × ℤ))) :
    dist (tri a b) (tri c d) = 2 := by
  rw [dist_tri, show (2 : ℝ) = √4 by rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
  congr 1
  simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq] at h
  have e1 : ((a : ℝ) - c) = -((c - a : ℤ) : ℝ) := by push_cast; ring
  have e2 : ((b : ℝ) - d) = -((d - b : ℤ) : ℝ) := by push_cast; ring
  rcases h with ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ | ⟨h1, h2⟩ <;>
    (rw [e1, e2, h1, h2]; norm_num [triQ])

/-- The witness step for an up colour: two vertices of an up triangle of that colour, one inside and one outside the unit
circle about `p`. -/
theorem phi_pos_up_witness {j : Fin 7} (a b : ℤ) (hj : j = r7UpCol a b) {p P₁ P₂ : ℂ}
    (h₁ : P₁ = tri a b ∨ P₁ = tri (a + 1) b ∨ P₁ = tri a (b + 1)) (h₂ : P₂ = tri a b ∨ P₂ = tri (a + 1) b ∨ P₂ = tri a (b + 1))
    (hd₁ : dist p P₁ < 1) (hd₂ : 1 < dist p P₂) : 0 < phi (r7Cls j) p := by
  subst hj
  exact phi_pos_of_star (measurableSet_r7Cls _) (isOpen_r7UpOpen a b) (r7UpOpen_subset a b) (r7UpOpen_star a b).2
    (mem_closure_r7UpOpen a b h₁) (mem_closure_r7UpOpen a b h₂) hd₁ hd₂

/-- The witness step for a down colour: two cusps of a down tile of that colour, one inside and one outside the unit circle
about `p`. -/
theorem phi_pos_down_witness {j : Fin 7} (a b : ℤ) (hj : j = r7DownCol a b) {p P₁ P₂ : ℂ}
    (h₁ : P₁ = tri (a + 1) b ∨ P₁ = tri a (b + 1) ∨ P₁ = tri (a + 1) (b + 1))
    (h₂ : P₂ = tri (a + 1) b ∨ P₂ = tri a (b + 1) ∨ P₂ = tri (a + 1) (b + 1))
    (hd₁ : dist p P₁ < 1) (hd₂ : 1 < dist p P₂) : 0 < phi (r7Cls j) p := by
  subst hj
  exact phi_pos_of_star (measurableSet_r7Cls _) (isOpen_r7DownOpen a b) (r7DownOpen_subset a b) (r7DownOpen_star a b).2
    (mem_closure_r7DownOpen a b h₁) (mem_closure_r7DownOpen a b h₂) hd₁ hd₂

/-- **R7's boundary at a lattice point**: of the classes with positive upper density at `tri m n` (only its three up colours —
the cusps have density `0`), every two have a common centre at distance `1` in both supports (`λ₀ + 1`, `λ₀ + ω`, `λ₀ + ω − 1`). -/
theorem r7_boundary_lattice {m n : ℤ} {a b : Fin 7} (hab : a ≠ b) (ha : tri m n ∈ essClosure (r7Cls a))
    (hb : tri m n ∈ essClosure (r7Cls b)) :
    ∃ m' n' : ℤ, dist (tri m n) (tri m' n') = 1 ∧ tri m' n' ∈ essSupport (r7Cls a) ∧ tri m' n' ∈ essSupport (r7Cls b) := by
  have _ := hab -- idle: the pair need not be distinct for the conclusion
  set c7 := r7UpCol (m + 1) (n + 1) with hc7
  have hfar : ∀ᶠ z in 𝓝 (tri m n), z ∉ r7Cls c7 := by
    filter_upwards [ball_mem_nhds (tri m n) (by norm_num : (0 : ℝ) < 7 / 10)] with z hz hzc
    have hzc' : r7Col z = c7 := hzc
    rw [mem_ball] at hz
    rcases r7Col_mem_tile z with ⟨p, q, hzU, hcz⟩ | ⟨p, q, hzD, hcz⟩
    · linarith [r7_far_vertex (hcz.symm.trans hzc') hzU]
    · exact r7UpCol_ne_r7DownCol _ _ _ _ (hzc'.symm.trans hcz)
  have hna : a ≠ c7 := fun h => not_mem_essClosure_of_eventually (h ▸ hfar) ha
  have hnb : b ≠ c7 := fun h => not_mem_essClosure_of_eventually (h ▸ hfar) hb
  set c0 := r7UpCol m n with hc0
  set c1 := r7UpCol (m + 1) n with hc1
  set c2 := r7UpCol m (n + 1) with hc2
  have hcls : ∀ d : Fin 7, d ≠ c7 → d = c0 ∨ d = c1 ∨ d = c2 ∨ 4 ≤ d.val := by
    intro d hd
    simp only [hc0, hc1, hc2, hc7, Fin.ext_iff, r7UpCol, ne_eq] at hd ⊢
    omega
  have h01 : c0 ≠ c1 := by simp only [hc0, hc1, ne_eq, Fin.ext_iff, r7UpCol]; omega
  have h02 : c0 ≠ c2 := by simp only [hc0, hc2, ne_eq, Fin.ext_iff, r7UpCol]; omega
  have h12 : c1 ≠ c2 := by simp only [hc1, hc2, ne_eq, Fin.ext_iff, r7UpCol]; omega
  have hdown : ∀ (P R : ℤ) (d : Fin 7), 4 ≤ d.val → tri P R ∈ essSupport (r7Cls d) := fun P R d hd =>
    r7_down_mem_essSupport P R hd
  have S1 : ∀ d, d = c0 ∨ d = c1 ∨ 4 ≤ d.val → tri (m + 1) n ∈ essSupport (r7Cls d) := by
    rintro d (rfl | rfl | hd)
    · exact r7Up_vertex_mem_essSupport m n (Or.inr (Or.inl rfl))
    · exact r7Up_vertex_mem_essSupport (m + 1) n (Or.inl rfl)
    · exact hdown _ _ d hd
  have S2 : ∀ d, d = c0 ∨ d = c2 ∨ 4 ≤ d.val → tri m (n + 1) ∈ essSupport (r7Cls d) := by
    rintro d (rfl | rfl | hd)
    · exact r7Up_vertex_mem_essSupport m n (Or.inr (Or.inr rfl))
    · exact r7Up_vertex_mem_essSupport m (n + 1) (Or.inl rfl)
    · exact hdown _ _ d hd
  have S3 : ∀ d, d = c1 ∨ d = c2 ∨ 4 ≤ d.val → tri (m - 1) (n + 1) ∈ essSupport (r7Cls d) := by
    rintro d (rfl | rfl | hd)
    · have e : r7UpCol (m + 1) n = r7UpCol (m - 1) n := by simp only [Fin.ext_iff, r7UpCol]; omega
      rw [hc1, e]; exact r7Up_vertex_mem_essSupport (m - 1) n (Or.inr (Or.inr rfl))
    · have e : r7UpCol m (n + 1) = r7UpCol (m - 2) (n + 1) := by simp only [Fin.ext_iff, r7UpCol]; omega
      rw [hc2, e]; exact r7Up_vertex_mem_essSupport (m - 2) (n + 1) (Or.inr (Or.inl (by congr 1; ring)))
    · exact hdown _ _ d hd
  have d1 : dist (tri m n) (tri (m + 1) n) = 1 := by rw [dist_tri]; push_cast; norm_num [triQ]
  have d2 : dist (tri m n) (tri m (n + 1)) = 1 := by rw [dist_tri]; push_cast; norm_num [triQ]
  have d3 : dist (tri m n) (tri (m - 1) (n + 1)) = 1 := by rw [dist_tri]; push_cast; norm_num [triQ]
  rcases hcls a hna with ha' | ha' | ha' | ha' <;> rcases hcls b hnb with hb' | hb' | hb' | hb'
  all_goals first
    | exact ⟨_, _, d1, S1 a (by tauto), S1 b (by tauto)⟩
    | exact ⟨_, _, d2, S2 a (by tauto), S2 b (by tauto)⟩
    | exact ⟨_, _, d3, S3 a (by tauto), S3 b (by tauto)⟩

/-- **R7's boundary off the lattice**: two classes meet only on an arc of an up tile facing a down tile, centred at a vertex `v`
of the up tile; `v` is in the up colour's support (a vertex) and in the down colour's (the cusp of that colour at `v`, by
M-R7-FORCE's coset computation: `D(m − 1, n − 1)` for the arc about `λ`, `D(m − 1, n + 1)` for the arc about `λ + ω`). -/
theorem r7_boundary_offLattice {x : ℂ} (hx : ∀ m n : ℤ, x ≠ tri m n) {a b : Fin 7} (hab : a ≠ b)
    (ha : x ∈ essClosure (r7Cls a)) (hb : x ∈ essClosure (r7Cls b)) :
    ∃ m n : ℤ, dist x (tri m n) = 1 ∧ tri m n ∈ essSupport (r7Cls a) ∧ tri m n ∈ essSupport (r7Cls b) := by
  obtain ⟨c₁, c₂, hev, hc⟩ := r7_local hx
  have hmem : ∀ d, x ∈ essClosure (r7Cls d) → d = c₁ ∨ d = c₂ := by
    intro d hd
    by_contra hne
    push Not at hne
    refine not_mem_essClosure_of_eventually ?_ hd
    filter_upwards [hev] with z hz hzd
    have : r7Col z = d := hzd
    rcases hz with h | h <;> [exact hne.1 (this.symm.trans h); exact hne.2 (this.symm.trans h)]
  rcases hmem a ha with rfl | rfl <;> rcases hmem b hb with rfl | rfl
  · exact absurd rfl hab
  · rcases hc with h | ⟨m, n, h1, h2, h3⟩
    · exact absurd h hab
    · exact ⟨m, n, h1, h2, h3⟩
  · rcases hc with h | ⟨m, n, h1, h2, h3⟩
    · exact absurd h.symm hab
    · exact ⟨m, n, h1, h3, h2⟩
  · exact absurd rfl hab

/-- **R7's classes are maximal, up colours**: for almost every point off an up class, the unit circle about it crosses an open
disc inside a tile of that colour (one period, finitely many explicit witness discs). -/
theorem r7_phi_pos_up {j : Fin 7} (hj : j.val < 4) : ∀ᵐ p ∂(volume.restrict (r7Cls j)ᶜ), 0 < phi (r7Cls j) p := by
  rw [ae_restrict_iff' (measurableSet_r7Cls j).compl]
  filter_upwards [measure_eq_zero_iff_ae_notMem.mp volume_iUnion_sphere_tri] with p hN hpj
  have hne : r7Col p ≠ j := hpj
  have hd := dist_tri_ne_one hN
  have two : ∀ a b c d : ℤ, (c - a = 2 ∧ d - b = 0) ∨ (c - a = 0 ∧ d - b = 2) ∨ (c - a = 2 ∧ d - b = -2) ∨
      (c - a = -2 ∧ d - b = 0) ∨ (c - a = 0 ∧ d - b = -2) ∨ (c - a = -2 ∧ d - b = 2) →
      dist p (tri a b) ≤ 1 → 1 < dist p (tri c d) := fun a b c d h hp =>
    lt_of_le_of_ne (one_le_dist_of_two (dist_tri_two a b c d (by
      simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega)) hp) (Ne.symm (hd c d))
  rcases r7Col_mem_tile p with ⟨m, n, hU, hc⟩ | ⟨m, n, hD, hc⟩
  · obtain ⟨⟨hx1, hx2⟩, hx3⟩ := hU
    rw [mem_closedBall] at hx1 hx2 hx3
    rw [hc] at hne
    have hj' : j = r7UpCol (m + 1) n ∨ j = r7UpCol m (n + 1) ∨ j = r7UpCol (m + 1) (n - 1) := by
      simp only [ne_eq, Fin.ext_iff, r7UpCol] at hne hj ⊢; omega
    rcases hj' with h | h | h
    · exact phi_pos_up_witness (m + 1) n h (Or.inl rfl) (Or.inr (Or.inl (show tri (m + 2) n = _ by congr 1; ring)))
        (lt_of_le_of_ne hx2 (hd _ _)) (two m n (m + 2) n (by omega) hx1)
    · exact phi_pos_up_witness m (n + 1) h (Or.inl rfl) (Or.inr (Or.inr (show tri m (n + 2) = _ by congr 1; ring)))
        (lt_of_le_of_ne hx3 (hd _ _)) (two m n m (n + 2) (by omega) hx1)
    · exact phi_pos_up_witness (m + 1) (n - 1) h (Or.inr (Or.inr (show tri (m + 1) n = _ by congr 1; ring)))
        (Or.inr (Or.inl (show tri (m + 2) (n - 1) = _ by congr 1; ring)))
        (lt_of_le_of_ne hx2 (hd _ _)) (two m (n + 1) (m + 2) (n - 1) (by omega) hx3)
  · obtain ⟨hu1, hv1, huv, ex1, ex2, ex3⟩ := r7Down_coords hD
    obtain ⟨k1, k2, k3⟩ := triQ_downTri_le hu1 hv1 huv
    have hdist : ∀ a b : ℤ, dist p (tri a b) = √(triQ ((triCoord p).1 - a) ((triCoord p).2 - b)) := fun a b => by
      rw [dist_eq_triQ, triCoord_tri]
    have lt1 : ∀ a b : ℤ, ∀ α β : ℝ, (a : ℝ) = m + α → (b : ℝ) = n + β →
        triQ ((triCoord p).1 - m - α) ((triCoord p).2 - n - β) ≤ 1 → dist p (tri a b) < 1 := by
      intro a b α β ha hb h
      refine lt_of_le_of_ne ?_ (hd a b)
      rw [hdist, Real.sqrt_le_one, ha, hb]; convert h using 2 <;> ring
    have gt1 : ∀ a b : ℤ, ∀ α β : ℝ, (a : ℝ) = m + α → (b : ℝ) = n + β →
        1 < triQ ((triCoord p).1 - m - α) ((triCoord p).2 - n - β) → 1 < dist p (tri a b) := by
      intro a b α β ha hb h
      rw [hdist, Real.lt_sqrt zero_le_one, one_pow, ha, hb]; convert h using 2 <;> ring
    have hj' : j = r7UpCol m n ∨ j = r7UpCol (m + 1) n ∨ j = r7UpCol m (n + 1) ∨ j = r7UpCol (m + 1) (n + 1) := by
      simp only [Fin.ext_iff, r7UpCol] at hj ⊢; omega
    rcases hj' with h | h | h | h
    · exact phi_pos_up_witness m n h (Or.inr (Or.inl rfl)) (Or.inl rfl)
        (lt1 _ _ 1 0 (by push_cast; ring) (by ring) (by simpa using k1)) (gt1 _ _ 0 0 (by ring) (by ring) (by simpa using ex1))
    · exact phi_pos_up_witness (m + 1) n h (Or.inl rfl) (Or.inr (Or.inl (show tri (m + 2) n = _ by congr 1; ring)))
        (lt1 _ _ 1 0 (by push_cast; ring) (by ring) (by simpa using k1)) (gt1 _ _ 2 0 (by push_cast; ring) (by ring)
          (by simpa using ex2))
    · exact phi_pos_up_witness m (n + 1) h (Or.inl rfl) (Or.inr (Or.inr (show tri m (n + 2) = _ by congr 1; ring)))
        (lt1 _ _ 0 1 (by ring) (by push_cast; ring) (by simpa using k2)) (gt1 _ _ 0 2 (by ring) (by push_cast; ring)
          (by simpa using ex3))
    · have k4 : 1 < triQ ((triCoord p).1 - m - 2) ((triCoord p).2 - n - 1) := by
        have : 1 ≤ triQ ((triCoord p).1 - m - 2) ((triCoord p).2 - n - 1) := by
          unfold triQ; nlinarith [mul_nonneg (by linarith : (0 : ℝ) ≤ 1 - ((triCoord p).1 - m))
            (by linarith : (0 : ℝ) ≤ 3 - ((triCoord p).1 - m)), mul_nonneg (by linarith : (0 : ℝ) ≤ 2 - ((triCoord p).1 - m))
            (by linarith : (0 : ℝ) ≤ 1 - ((triCoord p).2 - n)), sq_nonneg (1 - ((triCoord p).2 - n))]
        refine lt_of_le_of_ne this fun h => hd (m + 2) (n + 1) ?_
        rw [hdist, ← Real.sqrt_one]; congr 1; rw [h]; push_cast; ring_nf
      exact phi_pos_up_witness (m + 1) (n + 1) h (Or.inl rfl) (Or.inr (Or.inl (show tri (m + 2) (n + 1) = _ by congr 1; ring)))
        (lt1 _ _ 1 1 (by push_cast; ring) (by push_cast; ring) (by simpa using k3)) (gt1 _ _ 2 1 (by push_cast; ring)
          (by push_cast; ring) k4)

/-- **R7's classes are maximal, down colours.** -/
theorem r7_phi_pos_down {j : Fin 7} (hj : 4 ≤ j.val) : ∀ᵐ p ∂(volume.restrict (r7Cls j)ᶜ), 0 < phi (r7Cls j) p := by
  rw [ae_restrict_iff' (measurableSet_r7Cls j).compl]
  filter_upwards [measure_eq_zero_iff_ae_notMem.mp volume_iUnion_sphere_tri] with p hN hpj
  have hne : r7Col p ≠ j := hpj
  have hd := dist_tri_ne_one hN
  have two : ∀ a b c d : ℤ, (c - a = 2 ∧ d - b = 0) ∨ (c - a = 0 ∧ d - b = 2) ∨ (c - a = 2 ∧ d - b = -2) ∨
      (c - a = -2 ∧ d - b = 0) ∨ (c - a = 0 ∧ d - b = -2) ∨ (c - a = -2 ∧ d - b = 2) →
      dist p (tri a b) ≤ 1 → 1 < dist p (tri c d) := fun a b c d h hp =>
    lt_of_le_of_ne (one_le_dist_of_two (dist_tri_two a b c d (by
      simp only [mem_insert_iff, mem_singleton_iff, Prod.mk.injEq]; omega)) hp) (Ne.symm (hd c d))
  rcases r7Col_mem_tile p with ⟨m, n, hU, hc⟩ | ⟨m, n, hD, hc⟩
  · obtain ⟨⟨hx1, hx2⟩, hx3⟩ := hU
    rw [mem_closedBall] at hx1 hx2 hx3
    have hj' : j = r7DownCol (m - 1) (n - 1) ∨ j = r7DownCol (m - 1) (n + 1) ∨ j = r7DownCol (m + 1) (n - 1) := by
      simp only [Fin.ext_iff, r7DownCol] at hj ⊢; omega
    rcases hj' with h | h | h
    · exact phi_pos_down_witness (m - 1) (n - 1) h (Or.inr (Or.inr (show tri m n = _ by congr 1 <;> ring)))
        (Or.inr (Or.inl (show tri (m - 1) n = _ by congr 1; ring)))
        (lt_of_le_of_ne hx1 (hd _ _)) (two (m + 1) n (m - 1) n (by omega) hx2)
    · exact phi_pos_down_witness (m - 1) (n + 1) h (Or.inl (show tri m (n + 1) = _ by congr 1; ring))
        (Or.inr (Or.inr (show tri m (n + 2) = _ by congr 1 <;> ring)))
        (lt_of_le_of_ne hx3 (hd _ _)) (two m n m (n + 2) (by omega) hx1)
    · exact phi_pos_down_witness (m + 1) (n - 1) h (Or.inr (Or.inl (show tri (m + 1) n = _ by congr 1; ring)))
        (Or.inr (Or.inr (show tri (m + 2) n = _ by congr 1 <;> ring)))
        (lt_of_le_of_ne hx2 (hd _ _)) (two m n (m + 2) n (by omega) hx1)
  · rw [hc] at hne
    obtain ⟨hu1, hv1, huv, ex1, ex2, ex3⟩ := r7Down_coords hD
    obtain ⟨k1, k2, k3⟩ := triQ_downTri_le hu1 hv1 huv
    have hdist : ∀ a b : ℤ, dist p (tri a b) = √(triQ ((triCoord p).1 - a) ((triCoord p).2 - b)) := fun a b => by
      rw [dist_eq_triQ, triCoord_tri]
    have lt1 : ∀ a b : ℤ, ∀ α β : ℝ, (a : ℝ) = m + α → (b : ℝ) = n + β →
        triQ ((triCoord p).1 - m - α) ((triCoord p).2 - n - β) ≤ 1 → dist p (tri a b) < 1 := by
      intro a b α β ha hb h
      refine lt_of_le_of_ne ?_ (hd a b)
      rw [hdist, Real.sqrt_le_one, ha, hb]; convert h using 2 <;> ring
    have gt1 : ∀ a b : ℤ, ∀ α β : ℝ, (a : ℝ) = m + α → (b : ℝ) = n + β →
        1 < triQ ((triCoord p).1 - m - α) ((triCoord p).2 - n - β) → 1 < dist p (tri a b) := by
      intro a b α β ha hb h
      rw [hdist, Real.lt_sqrt zero_le_one, one_pow, ha, hb]; convert h using 2 <;> ring
    have hj' : j = r7DownCol (m + 1) n ∨ j = r7DownCol m (n + 1) := by
      simp only [ne_eq, Fin.ext_iff, r7DownCol] at hne hj ⊢; omega
    rcases hj' with h | h
    · exact phi_pos_down_witness (m + 1) n h (Or.inr (Or.inl rfl)) (Or.inl (show tri (m + 2) n = _ by congr 1; ring))
        (lt1 _ _ 1 1 (by push_cast; ring) (by push_cast; ring) (by simpa using k3))
        (gt1 _ _ 2 0 (by push_cast; ring) (by ring) (by simpa using ex2))
    · exact phi_pos_down_witness m (n + 1) h (Or.inl rfl) (Or.inr (Or.inl (show tri m (n + 2) = _ by congr 1; ring)))
        (lt1 _ _ 1 1 (by push_cast; ring) (by push_cast; ring) (by simpa using k3))
        (gt1 _ _ 0 2 (by ring) (by push_cast; ring) (by simpa using ex3))

/-- **FS111-M-R7**, last clause: every boundary is a unit arc centred at a lattice point carrying both its side colours — a point
in the essential closure of two classes is at distance exactly `1` from a lattice point in the support of both. -/
theorem r7_boundary {x : ℂ} {a b : Fin 7} (hab : a ≠ b) (ha : x ∈ essClosure (r7Cls a))
    (hb : x ∈ essClosure (r7Cls b)) :
    ∃ m n : ℤ, dist x (tri m n) = 1 ∧ tri m n ∈ essSupport (r7Cls a) ∧ tri m n ∈ essSupport (r7Cls b) := by
  by_cases hl : ∃ m n : ℤ, x = tri m n
  · obtain ⟨m, n, rfl⟩ := hl
    exact r7_boundary_lattice hab ha hb
  · push Not at hl
    exact r7_boundary_offLattice hl hab ha hb

/-- **FS111-M-R7**, saturation: every essential boundary point of a class is a contact point of that class. -/
theorem r7Cls_saturated : Saturated r7Cls := by
  intro j x hx
  have hd : Pairwise (Function.onFun Disjoint r7Cls) := fun i i' hii' => Disjoint.preimage _ (disjoint_singleton.2 hii')
  have hcov : ⋃ i, r7Cls i = univ := eq_univ_of_forall fun z => mem_iUnion.2 ⟨r7Col z, rfl⟩
  obtain ⟨b, hb, hxb⟩ := exists_ne_mem_essClosure measurableSet_r7Cls hd hcov hx
  obtain ⟨m, n, h1, h2, -⟩ := r7_boundary (Ne.symm hb) hx.1 hxb
  exact ⟨tri m n, by rw [← essSupport_eq_closure_densitySet]; exact h2, h1⟩

/-- **FS111-M-R7**, first three clauses: R7 is a.e.-proper, tight and saturated. -/
theorem exists_r7 : ∃ c : AeColouring 7, c.col = r7Col ∧ c.Tight ∧ Saturated c.cls := by
  obtain ⟨c, hc⟩ := r7_aeColouring
  have hcls : c.cls = r7Cls := by funext j; simp [AeColouring.cls, r7Cls, hc]
  refine ⟨c, hc, fun ε hε hs => ?_, hcls ▸ r7Cls_saturated⟩
  obtain ⟨j, hj⟩ := r7_not_bandNull hε
  exact hj (hcls ▸ hs j)

/-! ### R7 against FS111-M-COVER-SC's literal second clause (ruling: `plans/FS131-close-inventory.md` items 18–19) -/

/-- R7's classes are a maximal admissible cover (FS111-VMW-R7-MAX's last clause; not a backlog row, formalized here as the
counterexample's other half). -/
theorem r7Cls_isMaximalCover : IsMaximalCover r7Cls := by
  obtain ⟨c, hc⟩ := r7_aeColouring
  have hnull : ∀ j, UnitPairsNull (r7Cls j) := fun j => by
    have := c.unitPairsNull j
    rwa [show c.col ⁻¹' {j} = r7Cls j by simp [r7Cls, hc]] at this
  refine (isMaximalCover_iff measurableSet_r7Cls).2 ⟨fun j => ?_, Eventually.of_forall fun z => ⟨r7Col z, rfl⟩⟩
  refine (isMUA_iff_ae_phi_pos (measurableSet_r7Cls j) (hnull j)).2 ?_
  rcases lt_or_ge j.val 4 with h | h
  · exact r7_phi_pos_up h
  · exact r7_phi_pos_down h

/-! ### Children of `r7_lowerGraph`: R7 in the frame `(e(π/6), 2π/3)` -/

/-- The lattice coordinates of the frame point `e (π/6) + e (2π/3)(s + t i)`. -/
theorem triCoord_frame (s t : ℝ) :
    triCoord (e (π / 6) + e (2 * π / 3) * ((s : ℂ) + t * I)) = ((1 - t) / √3 - s, (1 - t) / √3 + s) := by
  have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3p : (0:ℝ) < √3 := by positivity
  have hc : Real.cos (2 * π / 3) = -1 / 2 := by
    rw [show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]; norm_num
  have hs : Real.sin (2 * π / 3) = √3 / 2 := by
    rw [show 2 * π / 3 = π - π / 3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  rw [e_eq, e_eq, hc, hs, Real.cos_pi_div_six, Real.sin_pi_div_six, triCoord]
  simp only [mul_re, ofReal_re, add_re, ofReal_im, I_re, I_im, mul_im, add_im]
  norm_num
  constructor <;> (field_simp; first | ring1 | linear_combination (1 - t) * h3)

/-- In the open cell `(0, 0)`, outside the unit discs about `0`, `2`, `2ω` (lattice norm), R7 has the down colour `4`. -/
theorem r7ColTri_four {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (ha1 : a < 1) (hb1 : b < 1) (h1 : 1 < triQ a b)
    (h2 : 1 < triQ (a - 2) b) (h3 : 1 < triQ a (b - 2)) : r7ColTri a b = 4 := by
  have e1 : ⌊a⌋ = 0 := Int.floor_eq_zero_iff.2 ⟨ha.le, ha1⟩
  have e2 : ⌊b⌋ = 0 := Int.floor_eq_zero_iff.2 ⟨hb.le, hb1⟩
  unfold r7ColTri
  simp only [e1, e2, Int.cast_zero, sub_zero]
  rw [if_neg (not_le.2 h1), if_neg (not_le.2 h2), if_neg (not_le.2 h3)]
  rfl

/-- Points of the box `(0.35, 0.51) × (0.65, 0.81)` are at lattice norm more than `1` from `2` and from `2ω`. -/
theorem triQ_far_gt {a b : ℝ} (ha : 0.35 < a) (ha' : a < 0.51) (hb : 0.65 < b) (hb' : b < 0.81) :
    1 < triQ (a - 2) b ∧ 1 < triQ a (b - 2) := by
  unfold triQ
  constructor <;> nlinarith [mul_pos (sub_pos.2 ha) (sub_pos.2 hb), mul_pos (sub_pos.2 ha') (sub_pos.2 hb')]

/-- The lattice norm along the frame: `triQ (r − s) (r + s) = ρ² + s²` when `r = ρ/√3`. -/
theorem triQ_frame {r s ρ : ℝ} (hr : r = ρ / √3) : triQ (r - s) (r + s) = ρ ^ 2 + s ^ 2 := by
  have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have : r ^ 2 * 3 = ρ ^ 2 := by rw [hr, div_pow, h3]; ring
  unfold triQ; nlinarith [this]

/-- Near the midpoint `e(π/6)` of the arc of `U(0, 0)` opposite `0`, the down class `4` lies below the lower unit arc
`t = 1 − √(1 − s²)` in the frame `(e(π/6), 2π/3)` (the disc about `0` above it). -/
theorem r7_lowerGraph : ∃ δ, IsLowerGraphOf (r7Cls 4) (e (π / 6)) (2 * π / 3) (Ioo (1 / 10) (1 / 5))
    (fun s => 1 - √(1 - s ^ 2)) δ := by
  have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3p : (0:ℝ) < √3 := by positivity
  have h3a : (1.73:ℝ) < √3 := by nlinarith
  have h3b : √3 < (1.74:ℝ) := by nlinarith
  have hcont : Continuous triCoord := by unfold triCoord; fun_prop
  have h1c : Continuous fun z => (triCoord z).1 := hcont.fst
  have h2c : Continuous fun z => (triCoord z).2 := hcont.snd
  set W4 : Set ℂ := {z | 0 < (triCoord z).1 ∧ 0 < (triCoord z).2 ∧ (triCoord z).1 < 1 ∧ (triCoord z).2 < 1 ∧
    1 < triQ (triCoord z).1 (triCoord z).2 ∧ 1 < triQ ((triCoord z).1 - 2) (triCoord z).2 ∧
    1 < triQ (triCoord z).1 ((triCoord z).2 - 2)} with hW4
  have hW4o : IsOpen W4 := by
    have q1 : Continuous fun z => triQ (triCoord z).1 (triCoord z).2 := by unfold triQ; fun_prop
    have q2 : Continuous fun z => triQ ((triCoord z).1 - 2) (triCoord z).2 := by unfold triQ; fun_prop
    have q3 : Continuous fun z => triQ (triCoord z).1 ((triCoord z).2 - 2) := by unfold triQ; fun_prop
    exact IsOpen.inter (isOpen_lt continuous_const h1c) (IsOpen.inter (isOpen_lt continuous_const h2c)
      (IsOpen.inter (isOpen_lt h1c continuous_const) (IsOpen.inter (isOpen_lt h2c continuous_const)
        (IsOpen.inter (isOpen_lt continuous_const q1) (IsOpen.inter (isOpen_lt continuous_const q2)
          (isOpen_lt continuous_const q3))))))
  have hW4c : W4 ⊆ r7Cls 4 := by
    intro z ⟨h1, h2, h3, h4, h5, h6, h7⟩
    show r7Col z = 4
    exact r7ColTri_four h1 h2 h3 h4 h5 h6 h7
  set W0 : Set ℂ := {z | 0 < (triCoord z).1 ∧ 0 < (triCoord z).2 ∧ (triCoord z).1 < 1 ∧ (triCoord z).2 < 1 ∧
    triQ (triCoord z).1 (triCoord z).2 < 1} with hW0
  have hW0o : IsOpen W0 := by
    have q1 : Continuous fun z => triQ (triCoord z).1 (triCoord z).2 := by unfold triQ; fun_prop
    exact IsOpen.inter (isOpen_lt continuous_const h1c) (IsOpen.inter (isOpen_lt continuous_const h2c)
      (IsOpen.inter (isOpen_lt h1c continuous_const) (IsOpen.inter (isOpen_lt h2c continuous_const)
        (isOpen_lt q1 continuous_const))))
  have hW0c : W0 ⊆ r7Cls 0 := by
    intro z ⟨h1, h2, h3, h4, h5⟩
    show r7Col z = 0
    exact r7ColTri_zero h1 h2 h3 h4 h5.le
  refine ⟨1 / 20, by norm_num, fun s hs t => ⟨fun ht1 ht2 => ?_, fun ht1 ht2 => ?_⟩⟩
  · obtain ⟨hs1, hs2⟩ := hs
    simp only at ht1 ht2
    set q := √(1 - s ^ 2) with hq
    have hq2 : q ^ 2 = 1 - s ^ 2 := Real.sq_sqrt (by nlinarith)
    have hq0 : 0 ≤ q := Real.sqrt_nonneg _
    have hq97 : 0.97 < q := by nlinarith
    have hq1 : q < 1 := by nlinarith
    have hρ1 : q < 1 - t := by linarith
    have hρ2 : 1 - t < q + 1 / 20 := by linarith
    have hz : triCoord (e (π / 6) + e (2 * π / 3) * ((s : ℂ) + t * I)) = ((1 - t) / √3 - s, (1 - t) / √3 + s) :=
      triCoord_frame s t
    have hmem : e (π / 6) + e (2 * π / 3) * ((s : ℂ) + t * I) ∈ W4 := by
      show 0 < (triCoord _).1 ∧ _
      rw [hz]
      have hr1 : 0.55 < (1 - t) / √3 := by rw [lt_div_iff₀ h3p]; nlinarith
      have hr2 : (1 - t) / √3 < 0.61 := by rw [div_lt_iff₀ h3p]; nlinarith
      have hf := triQ_far_gt (a := (1 - t) / √3 - s) (b := (1 - t) / √3 + s) (by linarith) (by linarith)
        (by linarith) (by linarith)
      have hQ := triQ_frame (r := (1 - t) / √3) (s := s) (ρ := 1 - t) rfl
      refine ⟨by linarith, by linarith, by linarith, by linarith, ?_, hf.1, hf.2⟩
      simp only
      rw [hQ]; nlinarith
    exact subset_densitySet_of_isOpen_ae_subset hW4o (Eventually.of_forall fun z hz => hW4c hz) hmem
  · obtain ⟨hs1, hs2⟩ := hs
    simp only at ht1 ht2
    set q := √(1 - s ^ 2) with hq
    have hq2 : q ^ 2 = 1 - s ^ 2 := Real.sq_sqrt (by nlinarith)
    have hq0 : 0 ≤ q := Real.sqrt_nonneg _
    have hq97 : 0.97 < q := by nlinarith
    have hq1 : q < 1 := by nlinarith
    have hρ1 : 1 - t < q := by linarith
    have hρ2 : q - 1 / 20 < 1 - t := by linarith
    have hz : triCoord (e (π / 6) + e (2 * π / 3) * ((s : ℂ) + t * I)) = ((1 - t) / √3 - s, (1 - t) / √3 + s) :=
      triCoord_frame s t
    have hmem : e (π / 6) + e (2 * π / 3) * ((s : ℂ) + t * I) ∈ W0 := by
      show 0 < (triCoord _).1 ∧ _
      rw [hz]
      have hr1 : 0.5 < (1 - t) / √3 := by rw [lt_div_iff₀ h3p]; nlinarith
      have hr2 : (1 - t) / √3 < 0.6 := by rw [div_lt_iff₀ h3p]; nlinarith
      have hQ := triQ_frame (r := (1 - t) / √3) (s := s) (ρ := 1 - t) rfl
      refine ⟨by linarith, by linarith, by linarith, by linarith, ?_⟩
      simp only
      rw [hQ]; nlinarith
    intro hsupp
    obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hW0o _ hmem
    have := hsupp r hr
    have hsub : r7Cls 4 ∩ ball (e (π / 6) + e (2 * π / 3) * ((s : ℂ) + t * I)) r ⊆ ∅ := by
      intro w ⟨hw4, hwb⟩
      have h0 : w ∈ r7Cls 0 := hW0c (hball hwb)
      have : (0 : Fin 7) = 4 := h0.symm.trans hw4
      exact absurd this (by decide)
    exact absurd (measure_mono_null hsub measure_empty) this.ne'

/-- The lower unit arc is not semiconcave with constant `1` away from its bottom (its second derivative is `(1 − s²)^{−3/2} > 1`). -/
theorem not_semiconcaveWith_one_lowerArc :
    ¬ SemiconcaveWith 1 (fun s : ℝ => 1 - √(1 - s ^ 2)) (Ioo (1 / 10) (1 / 5)) := by
  intro h
  have h1 := h (3 / 20) (1 / 25) ⟨by norm_num, by norm_num⟩ ⟨by norm_num, by norm_num⟩ ⟨by norm_num, by norm_num⟩
  simp only at h1
  have hA : √(1 - (3 / 20 + 1 / 25 : ℝ) ^ 2) ≤ 9817841 / 10000000 :=
    Real.sqrt_le_iff.2 ⟨by norm_num, by norm_num⟩
  have hB : √(1 - (3 / 20 - 1 / 25 : ℝ) ^ 2) ≤ 2484829 / 2500000 :=
    Real.sqrt_le_iff.2 ⟨by norm_num, by norm_num⟩
  have hC : 9886859 / 10000000 ≤ √(1 - (3 / 20 : ℝ) ^ 2) :=
    Real.le_sqrt_of_sq_le (by norm_num)
  nlinarith [hA, hB, hC]

/-- **The literal second clause of FS111-M-COVER-SC is false** (the statement defect of inventory item 18), on R7: some maximal
cover has a class whose boundary is locally the graph of a continuous function, the class below it, that is not semiconcave
with constant `1`. -/
theorem not_forall_semiconcaveWith_one :
    ¬ ∀ (k : ℕ) (C : Fin k → Set ℂ), IsMaximalCover C → ∀ (a : Fin k) (z₀ : ℂ) (θ δ α β : ℝ) (u : ℝ → ℝ),
      ContinuousOn u (Ioo α β) → IsLowerGraphOf (C a) z₀ θ (Ioo α β) u δ → SemiconcaveWith 1 u (Ioo α β) := by
  intro h
  obtain ⟨δ, hδ⟩ := r7_lowerGraph
  refine not_semiconcaveWith_one_lowerArc (h 7 r7Cls r7Cls_isMaximalCover 4 _ _ δ _ _ _ ?_ hδ)
  exact (continuous_const.sub (continuous_const.sub (continuous_id.pow 2)).sqrt).continuousOn

/-! ## FS111-M2-DISC7: the disc seven-cover -/

/-- DISC7's centres, the hexagon centres `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4) = (√3/2)(m + nω)`. -/
noncomputable def disc7Centre (m n : ℤ) : ℂ := ((√3 / 2 : ℝ) : ℂ) * tri m n

/-- The hexagonal seven-colouring's colour of the hexagon at `c(m, n)`: `(m + 3n) mod 7`. -/
def disc7Col (m n : ℤ) : Fin 7 := ⟨((m + 3 * n) % 7).toNat, by omega⟩

/-- **DISC7**: class `a` is the union of the closed discs of radius `1/2` about the centres of colour `a`. -/
def disc7 (a : Fin 7) : Set ℂ := ⋃ (m : ℤ) (n : ℤ) (_ : disc7Col m n = a), closedBall (disc7Centre m n) (1 / 2)

/-! ### Spec examples -/

/-- The colour lattice: `c(1, 2)` has colour `0`, like the origin, at distance `√21/2` (DISC7's same-colour minimum). -/
example : disc7Col 1 2 = disc7Col 0 0 ∧ dist (disc7Centre 1 2) (disc7Centre 0 0) = √21 / 2 := by
  refine ⟨rfl, ?_⟩
  have h : disc7Centre 1 2 - disc7Centre 0 0 =
      ((√3 / 2 : ℝ) : ℂ) * (((1 : ℝ) : ℂ) + ((2 : ℝ) : ℂ) * e (π / 3)) := by
    simp only [disc7Centre, tri]; push_cast; ring
  rw [dist_eq_norm, h, norm_mul, norm_real, Real.norm_eq_abs, abs_of_pos (by positivity), Complex.norm_def,
    normSq_add_mul, triQ, show (1 : ℝ) ^ 2 + 1 * 2 + 2 ^ 2 = 7 by norm_num, show (21 : ℝ) = 3 * 7 by norm_num,
    Real.sqrt_mul (by norm_num)]
  ring

/-- **Adversary**: neighbouring hexagons get different colours. -/
example : disc7Col 1 0 ≠ disc7Col 0 0 ∧ disc7Col 0 1 ≠ disc7Col 0 0 ∧ disc7Col 1 (-1) ≠ disc7Col 0 0 := by decide

/-- The origin lies in class `0`. -/
example : (0 : ℂ) ∈ disc7 0 :=
  mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨rfl, by simp [disc7Centre, tri]⟩⟩⟩

/-! ### FS131-K2d: children of DISC7's leaves (plan § 16) -/

/-- **The triangular lattice's covering radius is `1/√3`**, on the lower triangle: one of its three vertices is within `1/√3`
(the Voronoi split `2u + v ≤ 1`, `u + 2v ≤ 1`). A child of `disc7_cover` (FS131-I2f). -/
theorem triQ_cover_tri {u v : ℝ} (hu : 0 ≤ u) (hv : 0 ≤ v) (huv : u + v ≤ 1) :
    triQ u v ≤ 1 / 3 ∨ triQ (u - 1) v ≤ 1 / 3 ∨ triQ u (v - 1) ≤ 1 / 3 := by
  unfold triQ
  by_cases h0 : 2 * u + v ≤ 1 ∧ u + 2 * v ≤ 1
  · left
    nlinarith [mul_nonneg (sub_nonneg.2 h0.1) hu, mul_nonneg (sub_nonneg.2 h0.2) hv]
  · by_cases huv' : v ≤ u
    · right; left
      have h1 : 1 ≤ 2 * u + v := by
        by_contra h; push Not at h; exact h0 ⟨h.le, by linarith⟩
      nlinarith [mul_nonneg (sub_nonneg.2 h1) (sub_nonneg.2 huv'), mul_nonneg (sub_nonneg.2 huv) hv,
        mul_nonneg (sub_nonneg.2 h1) hv, mul_nonneg (sub_nonneg.2 huv) (sub_nonneg.2 huv'),
        mul_nonneg (sub_nonneg.2 h1) (sub_nonneg.2 huv)]
    · right; right
      push Not at huv'
      have h1 : 1 ≤ u + 2 * v := by
        by_contra h; push Not at h; exact h0 ⟨by linarith, h.le⟩
      nlinarith [mul_nonneg (sub_nonneg.2 h1) (sub_nonneg.2 huv'.le), mul_nonneg (sub_nonneg.2 huv) hu,
        mul_nonneg (sub_nonneg.2 h1) hu, mul_nonneg (sub_nonneg.2 huv) (sub_nonneg.2 huv'.le),
        mul_nonneg (sub_nonneg.2 h1) (sub_nonneg.2 huv)]

/-- **Every point is within `1/√3` of the unit triangular lattice** (FS131-I2f). -/
theorem tri_cover (z : ℂ) : ∃ p q : ℤ, normSq (z - tri p q) ≤ 1 / 3 := by
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  set u₀ : ℝ := z.re - z.im / √3
  set v₀ : ℝ := 2 * z.im / √3
  have hz : ∀ p q : ℤ, z - tri p q = ((u₀ - p : ℝ) : ℂ) + ((v₀ - q : ℝ) : ℂ) * e (π / 3) := by
    intro p q
    rw [tri, e_pi_div_three]
    apply Complex.ext <;> simp [u₀, v₀] <;> field_simp
    ring_nf
  have key : ∀ p q : ℤ, triQ (u₀ - p) (v₀ - q) ≤ 1 / 3 → ∃ p q : ℤ, normSq (z - tri p q) ≤ 1 / 3 :=
    fun p q h => ⟨p, q, by rw [hz, normSq_add_mul]; exact h⟩
  have fu := Int.floor_le u₀
  have fu' := Int.lt_floor_add_one u₀
  have fv := Int.floor_le v₀
  have fv' := Int.lt_floor_add_one v₀
  set u := u₀ - ⌊u₀⌋
  set v := v₀ - ⌊v₀⌋
  by_cases hs : u + v ≤ 1
  · rcases triQ_cover_tri (by linarith) (by linarith) hs with h | h | h
    · exact key ⌊u₀⌋ ⌊v₀⌋ h
    · exact key (⌊u₀⌋ + 1) ⌊v₀⌋ (by push_cast; convert h using 2; ring)
    · exact key ⌊u₀⌋ (⌊v₀⌋ + 1) (by push_cast; convert h using 2; ring)
  · push Not at hs
    have hsym : ∀ a b : ℝ, triQ (-a) (-b) = triQ a b := fun a b => by unfold triQ; ring
    rcases triQ_cover_tri (u := 1 - u) (v := 1 - v) (by linarith) (by linarith) (by linarith) with h | h | h
    · exact key (⌊u₀⌋ + 1) (⌊v₀⌋ + 1) (by rw [← hsym]; push_cast; convert h using 2 <;> ring)
    · exact key ⌊u₀⌋ (⌊v₀⌋ + 1) (by rw [← hsym]; push_cast; convert h using 2 <;> ring)
    · exact key (⌊u₀⌋ + 1) ⌊v₀⌋ (by rw [← hsym]; push_cast; convert h using 2 <;> ring)

/-- DISC7's classes are measurable. -/
theorem measurableSet_disc7 (a : Fin 7) : MeasurableSet (disc7 a) := by
  refine MeasurableSet.iUnion fun m => MeasurableSet.iUnion fun n => MeasurableSet.iUnion fun _ => ?_
  exact measurableSet_closedBall

/-- Same-colour centres are at least `√21/2` apart (`triQ ≥ 7` on the index-7 sublattice `{m + 3n ≡ 0 (mod 7)}`). -/
theorem disc7Col_eq_dist_ge {m n m' n' : ℤ} (hc : disc7Col m n = disc7Col m' n') (hne : (m, n) ≠ (m', n')) :
    √21 / 2 ≤ dist (disc7Centre m n) (disc7Centre m' n') := by
  set a : ℤ := m - m'
  set b : ℤ := n - n'
  have hab : a ≠ 0 ∨ b ≠ 0 := by
    by_contra h; push Not at h; exact hne (Prod.ext (by omega) (by omega))
  have hmod : (a + 3 * b) % 7 = 0 := by
    have h := congrArg Fin.val hc
    simp only [disc7Col] at h
    omega
  obtain ⟨t, ht⟩ : ∃ t, a + 3 * b = 7 * t := ⟨(a + 3 * b) / 7, by omega⟩
  have hQ : a * a + a * b + b * b = 7 * (7 * t * t - 5 * t * b + b * b) := by
    have : a = 7 * t - 3 * b := by omega
    rw [this]; ring
  have hpos : 0 < a * a + a * b + b * b := by
    rcases hab with h | h
    · nlinarith [sq_nonneg (2 * a + b), sq_nonneg b, mul_self_pos.2 h]
    · nlinarith [sq_nonneg (2 * a + b), sq_nonneg b, mul_self_pos.2 h]
  have h7 : 7 ≤ a * a + a * b + b * b := by omega
  have h7r : (7 : ℝ) ≤ triQ a b := by
    unfold triQ; exact_mod_cast (show (7 : ℤ) ≤ a ^ 2 + a * b + b ^ 2 by nlinarith)
  have hd : disc7Centre m n - disc7Centre m' n' = ((√3 / 2 : ℝ) : ℂ) * (((a : ℝ) : ℂ) + ((b : ℝ) : ℂ) * e (π / 3)) := by
    simp only [disc7Centre, tri, a, b]; push_cast; ring
  have hn2 : dist (disc7Centre m n) (disc7Centre m' n') ^ 2 = 3 / 4 * triQ a b := by
    rw [dist_eq_norm, hd, norm_mul, mul_pow, Complex.norm_real, Real.norm_eq_abs, sq_abs, Complex.sq_norm,
      normSq_add_mul, div_pow, Real.sq_sqrt (by norm_num)]
    ring
  rw [div_le_iff₀ (by norm_num : (0 : ℝ) < 2)]
  have h21 : √21 ^ 2 = (21 : ℝ) := Real.sq_sqrt (by norm_num)
  nlinarith [dist_nonneg (x := disc7Centre m n) (y := disc7Centre m' n'), Real.sqrt_nonneg 21,
    sq_nonneg (dist (disc7Centre m n) (disc7Centre m' n') * 2 - √21)]

/-- **DISC7's classes have null unit pairs**: inside one disc of radius `1/2` only antipodal boundary pairs are at distance `1`,
and two discs of one colour are more than `√21/2 − 1 > 1` apart; so every unit pair starts on a boundary circle. -/
theorem disc7_unitPair_mem_sphere {a : Fin 7} {x y : ℂ} (hx : x ∈ disc7 a) (hy : y ∈ disc7 a) (hxy : dist x y = 1) :
    ∃ m n : ℤ, dist x (disc7Centre m n) = 1 / 2 := by
  simp only [disc7, mem_iUnion, mem_closedBall] at hx hy
  obtain ⟨m, n, hc, hx⟩ := hx
  obtain ⟨m', n', hc', hy⟩ := hy
  by_cases h : (m, n) = (m', n')
  · obtain ⟨rfl, rfl⟩ := Prod.mk.inj h
    refine ⟨m, n, le_antisymm hx ?_⟩
    have := dist_triangle x (disc7Centre m n) y
    rw [dist_comm (disc7Centre m n) y] at this
    linarith
  · have hge := disc7Col_eq_dist_ge (hc.trans hc'.symm) h
    have h21 : (2 : ℝ) < √21 / 2 := by
      rw [lt_div_iff₀ (by norm_num), Real.lt_sqrt (by norm_num)]; norm_num
    have := dist_triangle (disc7Centre m n) x (disc7Centre m' n')
    have := dist_triangle x y (disc7Centre m' n')
    rw [dist_comm] at hx
    linarith

/-- The discs cover the plane (the centre lattice's covering radius is `1/2`). -/
theorem disc7_cover (z : ℂ) : ∃ m n : ℤ, dist z (disc7Centre m n) ≤ 1 / 2 := by
  have h3 : (√3 / 2 : ℝ) ≠ 0 := by positivity
  obtain ⟨p, q, h⟩ := tri_cover (z / ((√3 / 2 : ℝ) : ℂ))
  refine ⟨p, q, ?_⟩
  have e1 : z - disc7Centre p q = ((√3 / 2 : ℝ) : ℂ) * (z / ((√3 / 2 : ℝ) : ℂ) - tri p q) := by
    rw [disc7Centre]; field_simp
  rw [dist_eq_norm, e1, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
  have hn : ‖z / ((√3 / 2 : ℝ) : ℂ) - tri p q‖ ^ 2 ≤ 1 / 3 := by rw [Complex.sq_norm]; exact h
  have hs : (√3 / 2) ^ 2 = (3 / 4 : ℝ) := by rw [div_pow, Real.sq_sqrt (by norm_num)]; norm_num
  nlinarith [norm_nonneg (z / ((√3 / 2 : ℝ) : ℂ) - tri p q), Real.sqrt_nonneg 3,
    sq_nonneg (√3 / 2 * ‖z / ((√3 / 2 : ℝ) : ℂ) - tri p q‖ - 1 / 2)]

/-- Every point is within `√7/2` of a centre of each colour (the colour lattice's covering radius). -/
theorem disc7_colour_near (a : Fin 7) (z : ℂ) : ∃ m n : ℤ, disc7Col m n = a ∧ dist z (disc7Centre m n) ≤ √7 / 2 := by
  set μ : ℂ := tri 1 2 with hμ
  have hω : e (π / 3) ^ 2 = e (π / 3) - 1 := by
    rw [e_pi_div_three]
    apply Complex.ext <;> simp [sq] <;> ring_nf
    norm_num [Real.sq_sqrt]
  have hμn : normSq μ = 7 := by
    rw [hμ, tri, show ((1 : ℤ) : ℂ) = ((1 : ℝ) : ℂ) by simp, show ((2 : ℤ) : ℂ) = ((2 : ℝ) : ℂ) by simp,
      normSq_add_mul]
    unfold triQ; norm_num
  have hμ0 : μ ≠ 0 := by intro h; rw [h, map_zero] at hμn; norm_num at hμn
  set c : ℂ := ((√3 / 2 : ℝ) : ℂ) * μ with hc
  have hc0 : c ≠ 0 := mul_ne_zero (by norm_num) hμ0
  obtain ⟨p, q, hpq⟩ := tri_cover ((z - disc7Centre a.val 0) / c)
  refine ⟨a.val + p - 2 * q, 2 * p + 3 * q, ?_, ?_⟩
  · apply Fin.ext
    simp only [disc7Col]
    omega
  · have hcen : disc7Centre (a.val + p - 2 * q) (2 * p + 3 * q) = disc7Centre a.val 0 + c * tri p q := by
      simp only [disc7Centre, hc, hμ, tri]
      push_cast
      linear_combination (-((√3 : ℝ) : ℂ) * (q : ℂ)) * hω
    have e1 : z - disc7Centre (a.val + p - 2 * q) (2 * p + 3 * q) = c * ((z - disc7Centre a.val 0) / c - tri p q) := by
      rw [hcen]; field_simp; ring
    rw [dist_eq_norm, e1, norm_mul]
    have hcn : ‖c‖ ^ 2 = 21 / 4 := by
      rw [hc, norm_mul, mul_pow, Complex.sq_norm μ, hμn, Complex.norm_real, Real.norm_eq_abs, sq_abs, div_pow,
        Real.sq_sqrt (by norm_num)]
      norm_num
    have hn : ‖(z - disc7Centre a.val 0) / c - tri p q‖ ^ 2 ≤ 1 / 3 := by rw [Complex.sq_norm]; exact hpq
    have h7 : √7 ^ 2 = (7 : ℝ) := Real.sq_sqrt (by norm_num)
    have hprod : (‖c‖ * ‖(z - disc7Centre a.val 0) / c - tri p q‖) ^ 2 ≤ (√7 / 2) ^ 2 := by
      rw [mul_pow, hcn, div_pow, h7]; nlinarith
    exact (pow_le_pow_iff_left₀ (by positivity) (by positivity) (by norm_num)).1 hprod

/-- The unit circle about `p` crosses a closed disc of radius `1/2` at distance in `(1/2, 3/2)` in an arc of positive length. -/
theorem phi_closedBall_pos {p c : ℂ} (h1 : 1 / 2 < dist p c) (h2 : dist p c < 3 / 2) :
    0 < phi (closedBall c (1 / 2)) p := by
  set d : ℂ := c - p with hd
  set α : ℝ := Complex.arg d
  have hdn : ‖d‖ = dist p c := by rw [hd, dist_comm, dist_eq_norm]
  have hα : dist (p + e α) c < 1 / 2 := by
    have h := self_eq_norm_mul_e_arg d
    have : p + e α - c = e α * (1 - (‖d‖ : ℂ)) := by
      have hc' : c = p + d := by rw [hd]; ring
      rw [hc', show p + e α - (p + d) = e α - d by ring]
      conv_lhs => rw [h]
      ring
    rw [dist_eq_norm, this, norm_mul, norm_e, one_mul, show (1 : ℂ) - (‖d‖ : ℂ) = ((1 - ‖d‖ : ℝ) : ℂ) by push_cast; ring,
      Complex.norm_real, Real.norm_eq_abs, hdn, abs_lt]
    constructor <;> linarith
  have hopen : IsOpen {θ : ℝ | dist (p + e θ) c < 1 / 2} :=
    isOpen_lt ((continuous_const.add continuous_e).dist continuous_const) continuous_const
  obtain ⟨ε₀, hε₀, hball⟩ := Metric.isOpen_iff.1 hopen α hα
  set ε := min ε₀ Real.pi
  have hε : 0 < ε := lt_min hε₀ Real.pi_pos
  have hS : MeasurableSet {θ : ℝ | p + e θ ∈ closedBall c (1 / 2)} :=
    (isClosed_closedBall.preimage (continuous_const.add continuous_e)).measurableSet
  have hper : ∀ θ, θ + 2 * Real.pi ∈ {θ : ℝ | p + e θ ∈ closedBall c (1 / 2)} ↔
      θ ∈ {θ : ℝ | p + e θ ∈ closedBall c (1 / 2)} := by
    intro θ; simp only [mem_setOf_eq, e_add_two_pi]
  have hsub : Ioo (α - ε) (α + ε) ⊆ {θ : ℝ | p + e θ ∈ closedBall c (1 / 2)} := by
    intro θ hθ
    have : θ ∈ ball α ε₀ := by
      rw [Real.ball_eq_Ioo]; exact ⟨by linarith [hθ.1, min_le_left ε₀ Real.pi], by linarith [hθ.2, min_le_left ε₀ Real.pi]⟩
    exact mem_closedBall.2 (hball this).le
  have := arcLength_ge_of_Ioo hS hper (min_le_right _ _) hsub
  exact lt_of_lt_of_le (ENNReal.ofReal_pos.2 (by linarith)) this

/-- DISC7's classes are MUA sets (null unit pairs; `φ > 0` off the class, since `√7/2 < 3/2`). -/
theorem disc7_isMUA (a : Fin 7) : IsMUA (disc7 a) := by
  have hN : volume (⋃ (m : ℤ) (n : ℤ), sphere (disc7Centre m n) (1 / 2)) = 0 :=
    measure_iUnion_null fun m => measure_iUnion_null fun n => Measure.addHaar_sphere volume _ _
  have hnull : UnitPairsNull (disc7 a) := unitPairsNull_of_unitPair_mem hN fun x hx y hy hxy => by
    obtain ⟨m, n, h⟩ := disc7_unitPair_mem_sphere hx hy hxy
    exact mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_sphere.2 h⟩⟩
  refine (isMUA_iff_ae_phi_pos (measurableSet_disc7 a) hnull).2 ?_
  refine ae_restrict_of_forall_mem (measurableSet_disc7 a).compl fun p hp => ?_
  obtain ⟨m, n, hc, hd⟩ := disc7_colour_near a p
  have h7 : √7 / 2 < 3 / 2 := by
    rw [div_lt_div_iff_of_pos_right (by norm_num), Real.sqrt_lt' (by norm_num)]; norm_num
  have h1 : 1 / 2 < dist p (disc7Centre m n) := by
    by_contra h
    exact hp (mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨hc, mem_closedBall.2 (not_lt.1 h)⟩⟩⟩)
  refine lt_of_lt_of_le (phi_closedBall_pos h1 (lt_of_le_of_lt hd h7)) ?_
  refine measure_mono fun θ hθ => ?_
  exact mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨hc, hθ⟩⟩⟩

/-- **A class is closed**: its discs are a locally finite family (a ball of radius `1` meets the discs of the centres whose lattice
coordinates lie in a bounded box). A child of `essSupport_disc7` and `volume_frontier_disc7` (FS131-I2f). -/
theorem isClosed_disc7 (a : Fin 7) : IsClosed (disc7 a) := by
  let f : ℤ × ℤ → Set ℂ := fun q => if disc7Col q.1 q.2 = a then closedBall (disc7Centre q.1 q.2) (1 / 2) else ∅
  have hU : disc7 a = ⋃ q, f q := by
    ext x
    simp only [disc7, f, mem_iUnion, Prod.exists]
    constructor
    · rintro ⟨m, n, hc, hx⟩; exact ⟨m, n, by rw [if_pos hc]; exact hx⟩
    · rintro ⟨m, n, hx⟩
      split_ifs at hx with hc
      · exact ⟨m, n, hc, hx⟩
      · exact hx.elim
  rw [hU]
  refine LocallyFinite.isClosed_iUnion (fun z => ?_) (fun q => ?_)
  · refine ⟨ball z 1, ball_mem_nhds z one_pos, ?_⟩
    refine (Set.finite_Icc (⌊2 * z.re / √3 - 2 * z.im / 3⌋ - 5, ⌊4 * z.im / 3⌋ - 3)
      (⌊2 * z.re / √3 - 2 * z.im / 3⌋ + 5, ⌊4 * z.im / 3⌋ + 3)).subset ?_
    rintro ⟨m, n⟩ ⟨w, hwf, hw⟩
    simp only [f] at hwf
    split_ifs at hwf with hc
    · rw [mem_closedBall] at hwf
      rw [mem_ball] at hw
      have hd : dist (disc7Centre m n) z < 3 / 2 := by linarith [dist_triangle (disc7Centre m n) w z, dist_comm w (disc7Centre m n)]
      have hre : |(disc7Centre m n).re - z.re| < 3 / 2 := lt_of_le_of_lt (by
        have := Complex.abs_re_le_norm (disc7Centre m n - z); simpa [dist_eq_norm] using this) hd
      have him : |(disc7Centre m n).im - z.im| < 3 / 2 := lt_of_le_of_lt (by
        have := Complex.abs_im_le_norm (disc7Centre m n - z); simpa [dist_eq_norm] using this) hd
      have h3 : (0 : ℝ) < √3 := by positivity
      have h3s : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
      have hcre : (disc7Centre m n).re = √3 / 2 * (m + n / 2) := by
        simp [disc7Centre, tri, e_pi_div_three]; ring
      have hcim : (disc7Centre m n).im = 3 / 4 * n := by
        simp [disc7Centre, tri, e_pi_div_three]; ring_nf; rw [Real.sq_sqrt (by norm_num)]; ring
      rw [hcre, abs_lt] at hre
      rw [hcim, abs_lt] at him
      have hn1 : (n : ℝ) < 4 * z.im / 3 + 2 := by linarith
      have hn2 : 4 * z.im / 3 - 2 < (n : ℝ) := by linarith
      have hm1 : (m : ℝ) < 2 * z.re / √3 - 2 * z.im / 3 + 4 := by
        rw [div_eq_mul_inv, ← sub_neg]
        have : (m : ℝ) - (2 * z.re * (√3)⁻¹ - 2 * z.im / 3 + 4) =
            ((√3 / 2 * (m + n / 2) - z.re) * 2 / √3) - n / 2 + 2 * z.im / 3 - 4 := by field_simp; ring
        rw [this]
        have : (√3 / 2 * (m + n / 2) - z.re) * 2 / √3 < 3 / √3 := by
          rw [div_lt_div_iff_of_pos_right h3]; linarith
        have h33 : 3 / √3 = √3 := by field_simp; linarith
        nlinarith [Real.sqrt_lt' (show (0:ℝ) < 2 by norm_num) |>.2 (show (3:ℝ) < 2 ^ 2 by norm_num)]
      have hm2 : 2 * z.re / √3 - 2 * z.im / 3 - 4 < (m : ℝ) := by
        rw [div_eq_mul_inv]
        have : (m : ℝ) - (2 * z.re * (√3)⁻¹ - 2 * z.im / 3 - 4) =
            ((√3 / 2 * (m + n / 2) - z.re) * 2 / √3) - n / 2 + 2 * z.im / 3 + 4 := by field_simp; ring
        rw [← sub_pos, this]
        have : -(3 / √3) < (√3 / 2 * (m + n / 2) - z.re) * 2 / √3 := by
          rw [← neg_div, div_lt_div_iff_of_pos_right h3]; linarith
        have h33 : 3 / √3 = √3 := by field_simp; linarith
        nlinarith [Real.sqrt_lt' (show (0:ℝ) < 2 by norm_num) |>.2 (show (3:ℝ) < 2 ^ 2 by norm_num)]
      have f1 := Int.floor_le (2 * z.re / √3 - 2 * z.im / 3)
      have f2 := Int.lt_floor_add_one (2 * z.re / √3 - 2 * z.im / 3)
      have f3 := Int.floor_le (4 * z.im / 3)
      have f4 := Int.lt_floor_add_one (4 * z.im / 3)
      have l1 : m < ⌊2 * z.re / √3 - 2 * z.im / 3⌋ + 5 := by exact_mod_cast (show (m : ℝ) < (⌊2 * z.re / √3 - 2 * z.im / 3⌋ : ℝ) + 5 by linarith)
      have l2 : ⌊2 * z.re / √3 - 2 * z.im / 3⌋ - 5 < m := by exact_mod_cast (show (⌊2 * z.re / √3 - 2 * z.im / 3⌋ : ℝ) - 5 < (m : ℝ) by linarith)
      have l3 : n < ⌊4 * z.im / 3⌋ + 3 := by exact_mod_cast (show (n : ℝ) < (⌊4 * z.im / 3⌋ : ℝ) + 3 by linarith)
      have l4 : ⌊4 * z.im / 3⌋ - 3 < n := by exact_mod_cast (show (⌊4 * z.im / 3⌋ : ℝ) - 3 < (n : ℝ) by linarith)
      exact ⟨⟨by omega, by omega⟩, ⟨by omega, by omega⟩⟩
    · exact hwf.elim
  · simp only [f]; split_ifs
    · exact isClosed_closedBall
    · exact isClosed_empty

/-- A union of closed discs of radius `1/2` about a discrete lattice coset is its own support. -/
theorem essSupport_disc7 (a : Fin 7) : essSupport (disc7 a) = disc7 a := by
  apply subset_antisymm
  · intro x hx
    rw [← (isClosed_disc7 a).closure_eq, Metric.mem_closure_iff]
    intro r hr
    obtain ⟨y, hy⟩ := nonempty_of_measure_ne_zero (hx r hr).ne'
    exact ⟨y, hy.1, by rw [dist_comm]; exact mem_ball.1 hy.2⟩
  · intro x hx r hr
    obtain ⟨m, n, hc, hxc⟩ : ∃ m n, disc7Col m n = a ∧ x ∈ closedBall (disc7Centre m n) (1 / 2) := by
      simpa [disc7] using hx
    set c := disc7Centre m n
    set l : ℝ := min 1 (r / 2) with hl
    have hl0 : 0 < l := lt_min one_pos (by linarith)
    set y : ℂ := x + (l : ℂ) * (c - x)
    have hxc' : dist x c ≤ 1 / 2 := hxc
    have hsub : ball y (l / 4) ⊆ disc7 a ∩ ball x r := by
      intro w hw
      rw [mem_ball] at hw
      have hyx : dist y x = l * dist x c := by
        simp only [y, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs,
          abs_of_pos hl0]
        rw [norm_sub_rev]
      have hyc : dist y c = (1 - l) * dist x c := by
        have : y - c = ((1 - l : ℝ) : ℂ) * (x - c) := by simp only [y]; push_cast; ring
        rw [dist_eq_norm, this, norm_mul, Complex.norm_real, Real.norm_eq_abs,
          abs_of_nonneg (by linarith [min_le_left 1 (r / 2)]), ← dist_eq_norm]
      refine ⟨mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨hc, mem_closedBall.2 ?_⟩⟩⟩, mem_ball.2 ?_⟩
      · have := dist_triangle w y c
        nlinarith [min_le_left 1 (r / 2), dist_nonneg (x := x) (y := c)]
      · have := dist_triangle w y x
        nlinarith [min_le_right 1 (r / 2), dist_nonneg (x := x) (y := c)]
    exact lt_of_lt_of_le (measure_ball_pos volume y (by positivity)) (measure_mono hsub)

/-- The frontier of a class lies on the boundary circles: null. -/
theorem volume_frontier_disc7 (a : Fin 7) : volume (frontier (disc7 a)) = 0 := by
  have hN : volume (⋃ (m : ℤ) (n : ℤ), sphere (disc7Centre m n) (1 / 2)) = 0 :=
    measure_iUnion_null fun m => measure_iUnion_null fun n => Measure.addHaar_sphere volume _ _
  refine measure_mono_null (fun x hx => ?_) hN
  rw [frontier, (isClosed_disc7 a).closure_eq] at hx
  obtain ⟨hx, hxi⟩ := hx
  obtain ⟨m, n, hc, hxc⟩ : ∃ m n, disc7Col m n = a ∧ x ∈ closedBall (disc7Centre m n) (1 / 2) := by
    simpa [disc7] using hx
  refine mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_sphere.2 (le_antisymm hxc ?_)⟩⟩
  by_contra hlt
  push Not at hlt
  refine hxi (mem_interior.2 ⟨ball (disc7Centre m n) (1 / 2), fun w hw => ?_, isOpen_ball, mem_ball.2 hlt⟩)
  exact mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨hc, ball_subset_closedBall hw⟩⟩⟩

/-- A class is invariant under the colour lattice, spanned by `c(1, 2)` and `c(−3, 1)`. -/
theorem disc7_periodic (a : Fin 7) (x : ℂ) :
    (x + disc7Centre 1 2 ∈ disc7 a ↔ x ∈ disc7 a) ∧ (x + disc7Centre (-3) 1 ∈ disc7 a ↔ x ∈ disc7 a) := by
  have hlin : ∀ m n m' n' : ℤ, disc7Centre (m + m') (n + n') = disc7Centre m n + disc7Centre m' n' := by
    intro m n m' n'; simp only [disc7Centre, tri]; push_cast; ring
  have hcol : ∀ m n p q : ℤ, (p + 3 * q) % 7 = 0 → disc7Col (m + p) (n + q) = disc7Col m n := by
    intro m n p q hpq
    simp only [disc7Col, Fin.ext_iff]
    congr 1
    omega
  have key : ∀ p q : ℤ, (p + 3 * q) % 7 = 0 → ∀ x, x + disc7Centre p q ∈ disc7 a ↔ x ∈ disc7 a := by
    intro p q hpq x
    simp only [disc7, mem_iUnion, mem_closedBall]
    constructor
    · rintro ⟨m, n, hc, hx⟩
      refine ⟨m + -p, n + -q, ?_, ?_⟩
      · rw [hcol m n (-p) (-q) (by omega)]; exact hc
      · rw [hlin, show disc7Centre (-p) (-q) = - disc7Centre p q by simp only [disc7Centre, tri]; push_cast; ring,
          ← dist_add_right x _ (disc7Centre p q)]
        convert hx using 2; ring
    · rintro ⟨m, n, hc, hx⟩
      refine ⟨m + p, n + q, ?_, ?_⟩
      · rw [hcol m n p q hpq]; exact hc
      · rw [hlin, dist_add_right]; exact hx
  exact ⟨key 1 2 (by norm_num) x, key (-3) 1 (by norm_num) x⟩

/-- The colour lattice's generators are independent. -/
theorem disc7_linearIndependent : LinearIndependent ℝ ![disc7Centre 1 2, disc7Centre (-3) 1] := by
  rw [LinearIndependent.pair_iff]
  intro s t hst
  have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3p : (0 : ℝ) < √3 := by positivity
  have hre := congrArg Complex.re hst
  have him := congrArg Complex.im hst
  simp only [disc7Centre, tri, e_pi_div_three, Complex.real_smul, Complex.add_re, Complex.mul_re, Complex.mul_im,
    Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im, Complex.intCast_re,
    Complex.intCast_im, Complex.zero_re, Complex.zero_im] at hre him
  norm_num at hre him
  have ht : t = 0 := by nlinarith [mul_pos h3p h3p]
  subst ht
  constructor
  · nlinarith [mul_pos h3p h3p]
  · rfl

/-- One cell of the colour lattice holds one disc's area `π/4` of the class, in covolume `21√3/8`. -/
theorem volume_disc7_cell (a : Fin 7) :
    volume (disc7 a ∩ {x | ∃ s t : ℝ, s ∈ Ico (0 : ℝ) 1 ∧ t ∈ Ico (0 : ℝ) 1 ∧
        x = s * disc7Centre 1 2 + t * disc7Centre (-3) 1}) = ENNReal.ofReal (π / 4) ∧
      volume {x : ℂ | ∃ s t : ℝ, s ∈ Ico (0 : ℝ) 1 ∧ t ∈ Ico (0 : ℝ) 1 ∧
        x = s * disc7Centre 1 2 + t * disc7Centre (-3) 1} = ENNReal.ofReal (21 * √3 / 8) := by
  set c₁ := disc7Centre 1 2 with hc₁
  set c₂ := disc7Centre (-3) 1 with hc₂
  have h3 : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hc₁re : c₁.re = √3 := by
    simp only [hc₁, disc7Centre, tri, e_pi_div_three, Complex.mul_re, Complex.add_re, Complex.ofReal_re,
      Complex.ofReal_im, Complex.I_re, Complex.I_im, Complex.add_im, Complex.mul_im, Complex.intCast_re,
      Complex.intCast_im]
    norm_num
  have hc₁im : c₁.im = 3 / 2 := by
    simp only [hc₁, disc7Centre, tri, e_pi_div_three, Complex.mul_re, Complex.add_re, Complex.ofReal_re,
      Complex.ofReal_im, Complex.I_re, Complex.I_im, Complex.add_im, Complex.mul_im, Complex.intCast_re,
      Complex.intCast_im]
    norm_num; nlinarith [h3]
  have hc₂re : c₂.re = -(5 * √3 / 4) := by
    simp only [hc₂, disc7Centre, tri, e_pi_div_three, Complex.mul_re, Complex.add_re, Complex.ofReal_re,
      Complex.ofReal_im, Complex.I_re, Complex.I_im, Complex.add_im, Complex.mul_im, Complex.intCast_re,
      Complex.intCast_im]
    norm_num; ring
  have hc₂im : c₂.im = 3 / 4 := by
    simp only [hc₂, disc7Centre, tri, e_pi_div_three, Complex.mul_re, Complex.add_re, Complex.ofReal_re,
      Complex.ofReal_im, Complex.I_re, Complex.I_im, Complex.add_im, Complex.mul_im, Complex.intCast_re,
      Complex.intCast_im]
    norm_num; nlinarith [h3]
  have hP : {x : ℂ | ∃ s t : ℝ, s ∈ Ico (0 : ℝ) 1 ∧ t ∈ Ico (0 : ℝ) 1 ∧ x = s * c₁ + t * c₂} = parallelogram c₁ c₂ := rfl
  rw [hP]
  obtain ⟨hDm, -, -, hcov, hdisj⟩ := parallelogram_tiling disc7_linearIndependent
  refine ⟨?_, ?_⟩
  · -- one disc's area per cell
    set c₀ := disc7Centre (a.val : ℤ) 0 with hc₀
    set g := latticePt c₁ c₂ with hg
    have hlin : ∀ p q : ℤ, g (p, q) = disc7Centre (p - 3 * q) (2 * p + q) := by
      intro p q
      simp only [hg, latticePt, hc₁, hc₂, disc7Centre, tri]; push_cast; ring
    have hlin' : ∀ m n m' n' : ℤ, disc7Centre (m - m') (n - n') = disc7Centre m n - disc7Centre m' n' := by
      intro m n m' n'; simp only [disc7Centre, tri]; push_cast; ring
    have hunion : disc7 a = ⋃ pq : ℤ × ℤ, closedBall (c₀ - g pq) (1 / 2) := by
      ext x
      simp only [disc7, mem_iUnion]
      constructor
      · rintro ⟨m, n, hc, hx⟩
        have hmod : (m + 3 * n) % 7 = (a.val : ℤ) := by
          have := congrArg Fin.val hc
          simp only [disc7Col] at this
          have h0 : 0 ≤ (m + 3 * n) % 7 := Int.emod_nonneg _ (by norm_num)
          omega
        set p : ℤ := -(((m - a.val) + 3 * n) / 7) with hp
        refine ⟨(p, -n - 2 * p), ?_⟩
        have hpq : c₀ - g (p, -n - 2 * p) = disc7Centre m n := by
          rw [hlin, hc₀, ← hlin']
          congr 1 <;> omega
        rw [hpq]; exact hx
      · rintro ⟨⟨p, q⟩, hx⟩
        refine ⟨a.val - (p - 3 * q), 0 - (2 * p + q), ?_, ?_⟩
        · ext
          simp only [disc7Col]
          have : ((a.val : ℤ) - (p - 3 * q) + 3 * (0 - (2 * p + q))) % 7 = (a.val : ℤ) := by
            have := a.isLt; omega
          rw [this]; simp
        · rw [hlin', ← hlin, ← hc₀]; exact hx
    have hB : ∀ pq, (fun x => x + -g pq) ⁻¹' (closedBall (c₀ - g pq) (1 / 2) ∩ parallelogram c₁ c₂) =
        closedBall c₀ (1 / 2) ∩ {x | x - g pq ∈ parallelogram c₁ c₂} := by
      intro pq; ext x
      simp only [mem_preimage, mem_inter_iff, mem_closedBall, mem_setOf_eq, ← sub_eq_add_neg, dist_sub_right]
    have hdisjB : Pairwise (Function.onFun Disjoint fun pq : ℤ × ℤ => closedBall (c₀ - g pq) (1 / 2)) := by
      intro pq pq' hne
      refine Set.disjoint_left.2 fun x hx hx' => ?_
      rw [mem_closedBall] at hx hx'
      have hd : dist (c₀ - g pq) (c₀ - g pq') ≤ 1 := by
        calc _ ≤ dist (c₀ - g pq) x + dist x (c₀ - g pq') := dist_triangle _ _ _
          _ ≤ 1 / 2 + 1 / 2 := by rw [dist_comm]; exact add_le_add hx hx'
          _ = 1 := by norm_num
      obtain ⟨p, q⟩ := pq
      obtain ⟨p', q'⟩ := pq'
      rw [hlin, hlin, hc₀, ← hlin', ← hlin'] at hd
      have hcol : disc7Col (a.val - (p - 3 * q)) (0 - (2 * p + q)) = disc7Col (a.val - (p' - 3 * q')) (0 - (2 * p' + q')) := by
        simp only [disc7Col, Fin.ext_iff]; congr 1; omega
      have hne' : ((a.val : ℤ) - (p - 3 * q), (0 : ℤ) - (2 * p + q)) ≠ (a.val - (p' - 3 * q'), 0 - (2 * p' + q')) := by
        intro h
        apply hne
        simp only [Prod.mk.injEq] at h ⊢
        omega
      have := disc7Col_eq_dist_ge hcol hne'
      have h21 : (2 : ℝ) < √21 := by
        rw [show (2 : ℝ) = √4 by rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]]
        exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
      linarith
    rw [hunion, iUnion_inter, measure_iUnion (fun pq pq' hne => (hdisjB hne).mono inter_subset_left inter_subset_left)
      (fun pq => measurableSet_closedBall.inter hDm)]
    have hterm : ∀ pq, volume (closedBall (c₀ - g pq) (1 / 2) ∩ parallelogram c₁ c₂) =
        volume (closedBall c₀ (1 / 2) ∩ {x | x - g pq ∈ parallelogram c₁ c₂}) := by
      intro pq; rw [← hB, measure_preimage_add_right]
    rw [tsum_congr hterm]
    have hU := measure_iUnion (μ := volume)
      (f := fun pq => closedBall c₀ (1 / 2) ∩ {x | x - g pq ∈ parallelogram c₁ c₂})
      (fun pq pq' hne => Set.disjoint_left.2 fun x hx hx' => hne (hdisj pq pq' x hx.2 hx'.2))
      (fun pq => measurableSet_closedBall.inter ((measurable_id.sub_const _) hDm))
    rw [← hU, ← inter_iUnion]
    have hcovU : (⋃ pq, {x | x - g pq ∈ parallelogram c₁ c₂}) = univ :=
      eq_univ_of_forall fun x => mem_iUnion.2 (hcov x)
    rw [hcovU, inter_univ, volume_closedBall_ofReal]
    · congr 1; ring
    · norm_num
  · -- the covolume
    set f : ℂ →ₗ[ℝ] ℂ := Complex.reLm.smulRight c₁ + Complex.imLm.smulRight c₂ with hf
    have hfz : ∀ z : ℂ, f z = (z.re : ℂ) * c₁ + (z.im : ℂ) * c₂ := by
      intro z; simp [hf, Complex.real_smul]
    have himg : parallelogram c₁ c₂ = f '' squareWin 0 1 := by
      ext x
      constructor
      · rintro ⟨s, t, hs, ht, rfl⟩
        refine ⟨(s : ℂ) + (t : ℂ) * I, ?_, ?_⟩
        · simp only [squareWin, mem_setOf_eq]; simp; exact ⟨hs.1, hs.2, ht.1, ht.2⟩
        · rw [hfz]; simp
      · rintro ⟨z, ⟨h1, h2, h3, h4⟩, rfl⟩
        simp only [Complex.zero_re, Complex.zero_im, zero_add] at h1 h2 h3 h4
        exact ⟨z.re, z.im, ⟨h1, h2⟩, ⟨h3, h4⟩, hfz z⟩
    have hdet : LinearMap.det f = 21 * √3 / 8 := by
      rw [← LinearMap.det_toMatrix Complex.basisOneI, Matrix.det_fin_two]
      simp only [LinearMap.toMatrix_apply, Complex.coe_basisOneI_repr, Complex.coe_basisOneI, hfz]
      simp [hc₁re, hc₁im, hc₂re, hc₂im]
      ring
    rw [himg, MeasureTheory.Measure.addHaar_image_linearMap, volume_squareWin 0 zero_le_one, hdet]
    rw [abs_of_pos (by positivity), one_pow, ENNReal.ofReal_one, mul_one]

/-! ### The row -/

/-- **FS111-M2-DISC7**, first clause: the discs form a maximal admissible seven-cover. -/
theorem disc7_isMaximalCover : IsMaximalCover disc7 := by
  refine (isMaximalCover_iff measurableSet_disc7).2 ⟨disc7_isMUA, Eventually.of_forall fun z => ?_⟩
  obtain ⟨m, n, h⟩ := disc7_cover z
  exact ⟨disc7Col m n, mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨rfl, h⟩⟩⟩⟩

/-- **FS111-M2-DISC7**: its classes are regular. -/
theorem disc7_isRegularMUA (a : Fin 7) : IsRegularMUA (disc7 a) := by
  refine ⟨disc7_isMUA a, ?_, ?_⟩
  · rw [essSupport_disc7, sdiff_self, measure_empty]
  · rw [essSupport_disc7]; exact volume_frontier_disc7 a

/-- Every other colour is a lattice neighbour's colour (differences `±1, ±2, ±3`). -/
theorem disc7_nbr : ∀ a b : Fin 7, a ≠ b → ∃ d ∈ ([(1,0),(0,1),(-1,0),(0,-1),(1,-1),(-1,1)] : List (ℤ×ℤ)),
    disc7Col ((a.val : ℤ) + d.1) d.2 = b := by decide +kernel

/-- Two closed discs of radius `1/2` with centres within `9/10` overlap in positive measure. -/
theorem lens_pos {p q : ℂ} (h : dist p q ≤ 9 / 10) : 0 < volume (closedBall p (1 / 2) ∩ closedBall q (1 / 2)) := by
  set M : ℂ := (p + q) / 2
  have hp : dist M p ≤ 9 / 20 := by
    have : M - p = (q - p) / 2 := by simp only [M]; ring
    rw [dist_eq_norm, this, norm_div, ← dist_eq_norm, dist_comm]; simp; linarith
  have hq : dist M q ≤ 9 / 20 := by
    have : M - q = (p - q) / 2 := by simp only [M]; ring
    rw [dist_eq_norm, this, norm_div, ← dist_eq_norm]; simp; linarith [dist_comm p q]
  refine lt_of_lt_of_le (measure_ball_pos volume M (by norm_num : (0:ℝ) < 1 / 20)) (measure_mono ?_)
  intro w hw
  rw [mem_ball] at hw
  refine ⟨?_, ?_⟩ <;> rw [mem_closedBall]
  · linarith [dist_triangle w M p]
  · linarith [dist_triangle w M q]

/-- A unit lattice step moves `tri` by distance `1`. -/
theorem norm_tri_sub (m n d1 d2 : ℤ) (h : triQ d1 d2 = 1) : dist (tri (m + d1) (n + d2)) (tri m n) = 1 := by
  have : tri (m + d1) (n + d2) - tri m n = (((d1 : ℝ) : ℂ) + ((d2 : ℝ) : ℂ) * e (π / 3)) := by
    simp only [tri]; push_cast; ring
  rw [dist_eq_norm, this, Complex.norm_def, normSq_add_mul, h]; simp

/-- **FS111-M2-DISC7**: the overlaps (lenses) have positive measure — every two classes meet in positive measure (each disc meets
one disc of every other colour: the six neighbouring colour differences are `±1, ±2, ±3`). -/
theorem disc7_lens {a b : Fin 7} (hab : a ≠ b) : 0 < volume (disc7 a ∩ disc7 b) := by
  obtain ⟨d, hd, hcol⟩ := disc7_nbr a b hab
  have hq : triQ (d.1 : ℝ) (d.2 : ℝ) = 1 := by
    simp only [List.mem_cons, List.not_mem_nil, or_false] at hd
    rcases hd with rfl | rfl | rfl | rfl | rfl | rfl <;> norm_num [triQ]
  have hdist : dist (disc7Centre ((a.val : ℤ) + d.1) d.2) (disc7Centre a.val 0) ≤ 9 / 10 := by
    have h1 : disc7Centre ((a.val : ℤ) + d.1) d.2 - disc7Centre a.val 0 =
        ((√3 / 2 : ℝ) : ℂ) * (tri ((a.val : ℤ) + d.1) (0 + d.2) - tri a.val 0) := by
      simp only [disc7Centre]; ring_nf
    rw [dist_eq_norm, h1, norm_mul, ← dist_eq_norm, zero_add]
    have := norm_tri_sub a.val 0 d.1 d.2 (by exact_mod_cast hq)
    rw [zero_add] at this
    rw [this, norm_real, Real.norm_eq_abs, abs_of_pos (by positivity), mul_one]
    have : √3 ≤ 9 / 5 := Real.sqrt_le_iff.2 ⟨by norm_num, by norm_num⟩
    linarith
  have hca0 : ∀ x : Fin 7, disc7Col (x.val : ℤ) 0 = x := by decide +kernel
  have hca := hca0 a
  refine lt_of_lt_of_le (lens_pos (p := disc7Centre a.val 0) (by rw [dist_comm]; exact hdist)) (measure_mono ?_)
  intro w ⟨hw1, hw2⟩
  refine ⟨?_, ?_⟩
  · exact mem_iUnion.2 ⟨_, mem_iUnion.2 ⟨_, mem_iUnion.2 ⟨hca, hw1⟩⟩⟩
  · exact mem_iUnion.2 ⟨_, mem_iUnion.2 ⟨_, mem_iUnion.2 ⟨hcol, hw2⟩⟩⟩

/-- **FS111-M2-DISC7**: each class has density `2π/(21√3)`. -/
theorem disc7_upperDensity (a : Fin 7) : upperDensity (disc7 a) = ENNReal.ofReal (2 * π / (21 * √3)) := by
  rw [upperDensity_of_periodic disc7_linearIndependent (measurableSet_disc7 a) (disc7_periodic a),
    (volume_disc7_cell a).1, (volume_disc7_cell a).2, ← ENNReal.ofReal_div_of_pos (by positivity)]
  congr 1
  field_simp
  ring

/-- **FS111-M2-DISC7**: the seven densities sum to Kershner's thinnest-covering density `2π/(3√3)` (the value; that it is the
thinnest covering density by equal discs is `[Kershner1939]`'s theorem and is not stated). -/
theorem disc7_sum_upperDensity : ∑ a, upperDensity (disc7 a) = ENNReal.ofReal (2 * π / (3 * √3)) := by
  simp only [disc7_upperDensity, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [show ((7 : ℕ) : ENNReal) = ENNReal.ofReal 7 by simp, ← ENNReal.ofReal_mul (by norm_num)]
  congr 1
  field_simp
  ring

/-! ## FS111-M3-BAND: what a flat side needs -/

/-! ### FS131-K2d: children of `IsMUA.add_normal_mem_essSupport` (plan § 16) -/

/-- Points just beyond `m` along the normal, outside the support, are at distance `1` from the support (SATC (ii) for one MUA
set, `IsMUA.interior_union_unitShadow`). -/
theorem IsMUA.exists_shadow_point {A : Set ℂ} (hA : IsMUA A) {z : ℂ} (hz : z ∉ essSupport A) :
    ∃ y ∈ essSupport A, dist z y = 1 := by
  have hz' : z ∈ interior (essSupport A) ∪ unitShadow (essSupport A) := by
    rw [hA.interior_union_unitShadow]; exact mem_univ z
  rcases hz' with h | h
  · exact absurd (interior_subset h) hz
  · exact h

/-- **The unit circle about any point at distance `1` from `m`, other than `m + e θ`, enters the open half-box behind `m`.** -/
theorem circle_meets_halfBox_of_ne {m y : ℂ} {θ ε : ℝ} (hε : 0 < ε) (hy : dist m y = 1) (hne : y ≠ m + e θ) :
    ∃ z ∈ halfBox m θ ε, dist z y = 1 := by
  have he0 : e θ ≠ 0 := by
    intro h; have := norm_e θ; rw [h, norm_zero] at this; exact zero_ne_one this
  set w : ℂ := (y - m) / e θ with hw
  have hyw : y = m + e θ * w := by rw [hw]; field_simp; ring
  have hwn : w.re ^ 2 + w.im ^ 2 = 1 := by
    have h1 : ‖w‖ = 1 := by rw [hw, norm_div, norm_e, div_one, ← dist_eq_norm, dist_comm]; exact hy
    have h2 := Complex.sq_norm w
    rw [h1, Complex.normSq_apply] at h2
    nlinarith [h2]
  set σ := w.re with hσ
  set ρ := w.im with hρ
  have hw1 : ¬ (σ = 1 ∧ ρ = 0) := by
    rintro ⟨h1, h2⟩
    apply hne
    rw [hyw, show w = 1 from Complex.ext (by simpa using h1) (by simpa using h2), mul_one]
  have hσ1 : σ ≤ 1 := by nlinarith [sq_nonneg ρ, sq_nonneg (σ - 1)]
  have hσ1' : -1 ≤ σ := by nlinarith [sq_nonneg ρ, sq_nonneg (σ + 1)]
  obtain ⟨k, hkε, hneg⟩ : ∃ k : ℝ, |k| ≤ ε / 8 ∧ σ * k ^ 2 + ρ * k < 0 := by
    rcases lt_trichotomy ρ 0 with hρ0 | hρ0 | hρ0
    · set κ := min (ε / 8) (-ρ / 2) with hκ
      have hκ0 : 0 < κ := lt_min (by linarith) (by linarith)
      have hκ1 : κ ≤ -ρ / 2 := min_le_right _ _
      refine ⟨κ, by rw [abs_of_pos hκ0]; exact min_le_left _ _, ?_⟩
      nlinarith
    · have hσm : σ = -1 := by
        rw [hρ0] at hwn
        have : (σ - 1) * (σ + 1) = 0 := by linear_combination hwn
        rcases mul_eq_zero.1 this with h | h
        · exact absurd ⟨by linarith, hρ0⟩ hw1
        · linarith
      refine ⟨ε / 8, by rw [abs_of_pos (by linarith)], ?_⟩
      rw [hσm, hρ0]; nlinarith
    · set κ := min (ε / 8) (ρ / 2) with hκ
      have hκ0 : 0 < κ := lt_min (by linarith) (by linarith)
      have hκ1 : κ ≤ ρ / 2 := min_le_right _ _
      refine ⟨-κ, by rw [abs_neg, abs_of_pos hκ0]; exact min_le_left _ _, ?_⟩
      nlinarith
  set D : ℝ := 1 + k ^ 2 with hD
  have hD0 : 0 < D := by positivity
  set q : ℂ := ⟨2 * (σ * k ^ 2 + ρ * k) / D, 2 * (ρ * k ^ 2 - σ * k) / D⟩ with hq
  have hqre : q.re = 2 * (σ * k ^ 2 + ρ * k) / D := rfl
  have hqim : q.im = 2 * (ρ * k ^ 2 - σ * k) / D := rfl
  have hqn : (q.re ^ 2 + q.im ^ 2) * D = 4 * k ^ 2 := by
    rw [hqre, hqim]; field_simp; rw [hD]; linear_combination (4 * k ^ 2 * (1 + k ^ 2)) * hwn
  have hqb : q.re ^ 2 + q.im ^ 2 ≤ 4 * k ^ 2 := by nlinarith [sq_nonneg q.re, sq_nonneg q.im, sq_nonneg k]
  have hk2 : 4 * k ^ 2 < ε ^ 2 := by
    have : k ^ 2 ≤ (ε / 8) ^ 2 := by rw [← sq_abs]; exact pow_le_pow_left₀ (abs_nonneg k) hkε 2
    nlinarith
  refine ⟨m + e θ * q, ⟨-q.re, q.im, ?_, ?_, ?_, ?_⟩, ?_⟩
  · rw [hqre, neg_pos]; exact div_neg_of_neg_of_pos (by linarith) hD0
  · have := abs_lt_of_sq_lt_sq (show q.re ^ 2 < ε ^ 2 by nlinarith [sq_nonneg q.im]) hε.le
    linarith [neg_abs_le q.re]
  · exact abs_lt_of_sq_lt_sq (show q.im ^ 2 < ε ^ 2 by nlinarith [sq_nonneg q.re]) hε.le
  · congr 2; apply Complex.ext <;> simp
  · have hq1 : q.re - σ = (σ * (k ^ 2 - 1) + 2 * ρ * k) / D := by rw [hqre]; field_simp; ring
    have hq2 : q.im - ρ = (ρ * (k ^ 2 - 1) - 2 * σ * k) / D := by rw [hqim]; field_simp; ring
    have hnum : (σ * (k ^ 2 - 1) + 2 * ρ * k) ^ 2 + (ρ * (k ^ 2 - 1) - 2 * σ * k) ^ 2 = D ^ 2 := by
      rw [hD]; linear_combination (1 + k ^ 2) ^ 2 * hwn
    have hs : (q - w).re ^ 2 + (q - w).im ^ 2 = 1 := by
      rw [Complex.sub_re, Complex.sub_im, ← hσ, ← hρ, hq1, hq2, div_pow, div_pow, ← add_div, hnum,
        div_self (pow_ne_zero 2 hD0.ne')]
    have hn : ‖q - w‖ = 1 := by
      have h2 := Complex.sq_norm (q - w)
      rw [Complex.normSq_apply] at h2
      have h3 : ‖q - w‖ ^ 2 = 1 := by rw [h2]; linear_combination hs
      have h4 := norm_nonneg (q - w)
      nlinarith [sq_nonneg (‖q - w‖ - 1), sq_nonneg (‖q - w‖ + 1)]
    rw [hyw, dist_eq_norm, show m + e θ * q - (m + e θ * w) = e θ * (q - w) by ring, norm_mul, norm_e, one_mul, hn]

/-- **FS111-M3-BAND**, first clause, at the class its argument reads (wider; `plans/FS131-w2-kernel-plan.md` § 7): at a point `m`
of the boundary of a MUA set's support where the set fills the half-box behind `m` (in direction `−e θ`) and the support misses
the normal ray just beyond, the point `m + e θ` at distance exactly `1` along the outer normal is in the support. Applied at
every point of a flat side, it puts the class's material at distance `1` over the whole side, its middle half included; no
block, diameter bound or regularity is read. -/
theorem IsMUA.add_normal_mem_essSupport {A : Set ℂ} (hA : IsMUA A) {m : ℂ} {θ ε δ : ℝ} (hε : 0 < ε) (hδ : 0 < δ)
    (hin : volume (halfBox m θ ε \ A) = 0) (hout : ∀ τ : ℝ, 0 < τ → τ < δ → m + τ * e θ ∉ essSupport A) :
    m + e θ ∈ essSupport A := by
  -- points `z k` on the normal ray, their shadow points `y k` in the support
  set z : ℕ → ℂ := fun k => m + ((δ / (k + 2) : ℝ) : ℂ) * e θ with hz
  have hzpos : ∀ k : ℕ, 0 < δ / ((k : ℝ) + 2) := fun k => div_pos hδ (by positivity)
  have hzlt : ∀ k : ℕ, δ / ((k : ℝ) + 2) < δ := fun k =>
    (div_lt_iff₀ (by positivity)).2 (by nlinarith [show (0 : ℝ) ≤ k from Nat.cast_nonneg k])
  have hsh : ∀ k, ∃ y ∈ essSupport A, dist (z k) y = 1 := fun k =>
    hA.exists_shadow_point (hout _ (hzpos k) (hzlt k))
  choose y hyS hyd using hsh
  have hzm : ∀ k, dist (z k) m ≤ δ := by
    intro k
    rw [hz, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (hzpos k)]
    exact (hzlt k).le
  have hyB : ∀ k, y k ∈ closedBall m (δ + 1) := by
    intro k
    rw [mem_closedBall]
    calc dist (y k) m ≤ dist (y k) (z k) + dist (z k) m := dist_triangle _ _ _
      _ ≤ 1 + δ := by rw [dist_comm, hyd k]; linarith [hzm k]
      _ = δ + 1 := by ring
  obtain ⟨ys, -, φ, hφ, hlim⟩ := (isCompact_closedBall m (δ + 1)).tendsto_subseq hyB
  have hysS : ys ∈ essSupport A :=
    (isClosed_essSupport A).mem_of_tendsto hlim (Eventually.of_forall fun k => hyS (φ k))
  have hzlim : Tendsto (fun k => z (φ k)) atTop (𝓝 m) := by
    have h0 : Tendsto (fun k : ℕ => δ / ((k : ℝ) + 2)) atTop (𝓝 0) := by
      have := (tendsto_one_div_add_atTop_nhds_zero_nat).const_mul δ
      rw [mul_zero] at this
      refine squeeze_zero (fun k => (hzpos k).le) (fun k => ?_) this
      rw [mul_one_div]
      exact div_le_div_of_nonneg_left hδ.le (by positivity) (by linarith)
    have h1 : Tendsto z atTop (𝓝 m) := by
      have : Tendsto (fun k : ℕ => m + ((δ / ((k : ℝ) + 2) : ℝ) : ℂ) * e θ) atTop (𝓝 (m + ((0 : ℝ) : ℂ) * e θ)) :=
        tendsto_const_nhds.add ((Complex.continuous_ofReal.tendsto 0).comp h0 |>.mul tendsto_const_nhds)
      rw [Complex.ofReal_zero, zero_mul, add_zero] at this
      exact this
    exact h1.comp hφ.tendsto_atTop
  have hdist : dist m ys = 1 := by
    have h := (hzlim.dist hlim).congr fun k => hyd (φ k)
    exact tendsto_nhds_unique h tendsto_const_nhds
  by_contra hns
  have hne : ys ≠ m + e θ := fun h => hns (h ▸ hysS)
  obtain ⟨w, hw, hwd⟩ := circle_meets_halfBox_of_ne hε hdist hne
  have hint : w ∈ interior (densitySet A) :=
    interior_maximal (subset_densitySet_of_isOpen_ae_subset (isOpen_halfBox m θ ε)
      (ae_le_set.2 hin)) (isOpen_halfBox m θ ε) hw
  rw [essSupport_eq_closure_densitySet] at hysS
  exact dist_ne_one_of_mem_interior_densitySet hA.1 hA.2.1 hint hysS hwd

/-- **FS111-M3-BAND**, second clause, its horn half: a band of length `ℓ` (its base segment `[p, p + ℓd]`) excludes the point at
offset `(x, w)` in its frame (`x` along the band past `p`, `w` across) iff the circle about it meets the segment, which past the
band's end (`x > ℓ`) is iff `x − √(1 − w²)` lies in `[0, ℓ]` — a window of horn offsets `x − ℓ` of length exactly `ℓ`. -/
theorem band_excludes_horn {p d : ℂ} (hd : ‖d‖ = 1) {ℓ x w : ℝ} (hℓ : 0 ≤ ℓ) (hx : ℓ < x) (hw : |w| ≤ 1) :
    (∃ y ∈ segment ℝ p (p + ℓ * d), dist (p + (x + w * I) * d) y = 1) ↔
      0 ≤ x - √(1 - w ^ 2) ∧ x - √(1 - w ^ 2) ≤ ℓ := by
  have key : ∀ s : ℝ, dist (p + (x + w * I) * d) (p + s * d) = √((x - s) ^ 2 + w ^ 2) := by
    intro s
    have : p + (x + w * I) * d - (p + s * d) = (((x - s : ℝ) : ℂ) + w * I) * d := by push_cast; ring
    rw [dist_eq_norm, this, norm_mul, hd, mul_one, Complex.norm_add_mul_I]
  have hseg : ∀ y, y ∈ segment ℝ p (p + ℓ * d) ↔ ∃ s ∈ Icc 0 ℓ, y = p + s * d := by
    intro y
    rw [segment_eq_image']
    constructor
    · rintro ⟨θ, ⟨h0, h1⟩, rfl⟩
      refine ⟨θ * ℓ, ⟨mul_nonneg h0 hℓ, by nlinarith⟩, ?_⟩
      simp only [add_sub_cancel_left, real_smul]; push_cast; ring
    · rintro ⟨s, ⟨h0, h1⟩, rfl⟩
      rcases hℓ.eq_or_lt with h | h
      · refine ⟨0, ⟨le_rfl, zero_le_one⟩, ?_⟩
        have : s = 0 := by linarith
        subst this; simp
      · refine ⟨s / ℓ, ⟨div_nonneg h0 hℓ, (div_le_one h).2 h1⟩, ?_⟩
        have hl : (ℓ : ℂ) ≠ 0 := by exact_mod_cast h.ne'
        simp only [add_sub_cancel_left, real_smul]; push_cast; field_simp
  have hw2 : 0 ≤ 1 - w ^ 2 := by nlinarith [abs_le.1 hw, sq_abs w]
  constructor
  · rintro ⟨y, hy, hd1⟩
    obtain ⟨s, ⟨h0, h1⟩, rfl⟩ := (hseg y).1 hy
    rw [key] at hd1
    have h2 : (x - s) ^ 2 + w ^ 2 = 1 := by
      have := Real.sqrt_eq_iff_mul_self_eq (by positivity) (by norm_num : (0 : ℝ) ≤ 1) |>.1 hd1
      nlinarith
    have h3 : x - s = √(1 - w ^ 2) := by
      have hpos : 0 < x - s := by linarith
      rw [eq_comm, Real.sqrt_eq_iff_mul_self_eq hw2 hpos.le]
      nlinarith
    constructor <;> linarith
  · rintro ⟨h0, h1⟩
    refine ⟨p + (x - √(1 - w ^ 2) : ℝ) * d, (hseg _).2 ⟨_, ⟨h0, h1⟩, rfl⟩, ?_⟩
    rw [key]
    have : x - (x - √(1 - w ^ 2)) = √(1 - w ^ 2) := by ring
    rw [this, Real.sq_sqrt hw2]; simp

/-- **FS111-M3-BAND**, second clause, its length half: a band of length `ℓ` whose points are pairwise at distances other than
`1` has `ℓ ≤ 1`. -/
theorem le_one_of_band_unitFree {p d : ℂ} (hd : ‖d‖ = 1) {ℓ : ℝ} {S : Set ℂ} (hS : ∀ s ∈ Ioo 0 ℓ, p + s * d ∈ S)
    (hfree : ∀ x ∈ S, ∀ y ∈ S, dist x y ≠ 1) : ℓ ≤ 1 := by
  by_contra hℓ
  push Not at hℓ
  have h1 := hS ((ℓ - 1) / 2) ⟨by linarith, by linarith⟩
  have h2 := hS ((ℓ + 1) / 2) ⟨by linarith, by linarith⟩
  refine hfree _ h1 _ h2 ?_
  rw [dist_eq_norm, show p + (((ℓ - 1) / 2 : ℝ) : ℂ) * d - (p + (((ℓ + 1) / 2 : ℝ) : ℂ) * d) = -d by push_cast; ring,
    norm_neg, hd]

/-- **FS111-M3-BAND**, third clause, its tight half (the frame of `plans/FS111-M3-finiteness.md` § 1.6: the side
`[−1/2, 1/2] × {0}`, the band's ends `(±1/2, 1)`): the apex at depth `√3/2` excludes the lower half of the band's vesica
(`|z − apex| ≥ 1`), with equality at exactly one point, `(0, 1 − √3/2)`. -/
theorem vesica_apex :
    (∀ z : ℂ, dist z (-1 / 2 + I) ≤ 1 → dist z (1 / 2 + I) ≤ 1 → z.im ≤ 1 → 1 ≤ dist z (-(√3 / 2 : ℝ) * I)) ∧
      {z : ℂ | dist z (-1 / 2 + I) ≤ 1 ∧ dist z (1 / 2 + I) ≤ 1 ∧ z.im ≤ 1 ∧ dist z (-(√3 / 2 : ℝ) * I) = 1} =
        {((1 - √3 / 2 : ℝ) : ℂ) * I} := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  have hd1 : ∀ z : ℂ, dist z (-1 / 2 + I) = √((z.re + 1 / 2) ^ 2 + (z.im - 1) ^ 2) := fun z => by
    rw [Complex.dist_eq_re_im]; congr 1; simp; ring
  have hd2 : ∀ z : ℂ, dist z (1 / 2 + I) = √((z.re - 1 / 2) ^ 2 + (z.im - 1) ^ 2) := fun z => by
    rw [Complex.dist_eq_re_im]; congr 1; simp
  have hd3 : ∀ z : ℂ, dist z (-(√3 / 2 : ℝ) * I) = √(z.re ^ 2 + (z.im + √3 / 2) ^ 2) := fun z => by
    rw [Complex.dist_eq_re_im]; congr 1; simp
  -- the two constraints force `t = 1 - im ≤ √3/2`
  have key : ∀ z : ℂ, dist z (-1 / 2 + I) ≤ 1 → dist z (1 / 2 + I) ≤ 1 → z.im ≤ 1 →
      1 - z.im ≤ √3 / 2 ∧ 1 ≤ z.re ^ 2 + (z.im + √3 / 2) ^ 2 ∧
        (z.re ^ 2 + (z.im + √3 / 2) ^ 2 = 1 → z.re = 0 ∧ z.im = 1 - √3 / 2) := by
    intro z a b c
    rw [hd1, Real.sqrt_le_iff] at a
    rw [hd2, Real.sqrt_le_iff] at b
    obtain ⟨-, a⟩ := a
    obtain ⟨-, b⟩ := b
    have hsum : z.re ^ 2 + (z.im - 1) ^ 2 ≤ 3 / 4 := by nlinarith
    have ht : 1 - z.im ≤ √3 / 2 := by
      by_contra hcon
      push Not at hcon
      nlinarith [sq_nonneg z.re]
    refine ⟨ht, ?_, fun heq => ?_⟩
    · nlinarith [sq_nonneg z.re]
    · have hre : z.re = 0 := by nlinarith [sq_nonneg z.re, sq_nonneg (1 - z.im - √3 / 2)]
      refine ⟨hre, ?_⟩
      nlinarith [sq_nonneg z.re, sq_nonneg (1 - z.im - √3 / 2)]
  refine ⟨fun z a b c => ?_, ?_⟩
  · obtain ⟨-, h1, -⟩ := key z a b c
    rw [hd3]; exact Real.le_sqrt_of_sq_le (by nlinarith)
  · ext z
    simp only [mem_setOf_eq, mem_singleton_iff]
    constructor
    · rintro ⟨a, b, c, d⟩
      rw [hd3] at d
      have d' : z.re ^ 2 + (z.im + √3 / 2) ^ 2 = 1 := by
        have := Real.sqrt_eq_iff_mul_self_eq (by positivity) (by norm_num : (0 : ℝ) ≤ 1) |>.1 d
        nlinarith
      obtain ⟨-, -, h3'⟩ := key z a b c
      obtain ⟨hre, him⟩ := h3' d'
      apply Complex.ext <;> simp [hre, him]
    · rintro rfl
      refine ⟨?_, ?_, ?_, ?_⟩
      · rw [hd1, Real.sqrt_le_iff]; refine ⟨by norm_num, ?_⟩; simp; nlinarith
      · rw [hd2, Real.sqrt_le_iff]; refine ⟨by norm_num, ?_⟩; simp; nlinarith
      · simp; linarith
      · rw [hd3, Real.sqrt_eq_iff_mul_self_eq (by positivity) (by norm_num : (0 : ℝ) ≤ 1)]
        simp

/-- **FS111-M3-BAND**, third clause, its exact half: an apex at any smaller depth `0 ≤ h < √3/2` fails to exclude some point of the
open vesica below the band. -/
theorem vesica_apex_exact {h : ℝ} (h0 : 0 ≤ h) (hh : h < √3 / 2) :
    ∃ z : ℂ, dist z (-1 / 2 + I) < 1 ∧ dist z (1 / 2 + I) < 1 ∧ z.im < 1 ∧ dist z (-(h : ℂ) * I) < 1 := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  set η : ℝ := (√3 / 2 - h) / 2 with hη
  have hη0 : 0 < η := by rw [hη]; linarith
  have hη1 : η ≤ √3 / 4 := by rw [hη]; linarith
  refine ⟨((1 - √3 / 2 + η : ℝ) : ℂ) * I, ?_, ?_, ?_, ?_⟩
  · rw [Complex.dist_eq_re_im, Real.sqrt_lt' one_pos]; simp; nlinarith
  · rw [Complex.dist_eq_re_im, Real.sqrt_lt' one_pos]; simp; nlinarith
  · simp; linarith
  · rw [Complex.dist_eq_re_im, Real.sqrt_lt' one_pos]; simp
    rw [abs_lt]; constructor <;> nlinarith

/-! ## FS111-M3-HC: the honeycomb class -/

/-- `L = 2 + √3/3`, the honeycomb's edge (twice the inradius `√3/6`, plus `2`). -/
noncomputable def hcL : ℝ := 2 + √3 / 3

/-- The face centres: the triangular lattice spanned by `L(3/2, √3/2) = L√3 e(π/6)` and `L(0, √3) = L√3 e(π/6) ω`. -/
noncomputable def hcFace (m n : ℤ) : ℂ := ((hcL * √3 : ℝ) : ℂ) * e (π / 6) * tri m n

/-- The up centroids `O + L` (one coset of the face lattice); their triangles' vertices point along `e(π/3), e(π), e(5π/3)`. -/
noncomputable def hcUpC (m n : ℤ) : ℂ := hcFace m n + hcL

/-- The down centroids `O + L e(π/3)`; their triangles' vertices point along `e(0), e(2π/3), e(4π/3)`. -/
noncomputable def hcDownC (m n : ℤ) : ℂ := hcFace m n + hcL * e (π / 3)

/-- The up triangle of side `1` (circumradius `1/√3`) at `hcUpC m n`, its vertices pointing at its three face centres. -/
noncomputable def hcUpTri (m n : ℤ) : Set ℂ :=
  convexHull ℝ {hcUpC m n + e (π / 3) / √3, hcUpC m n + e π / √3, hcUpC m n + e (5 * π / 3) / √3}

/-- The down triangle of side `1` at `hcDownC m n`. -/
noncomputable def hcDownTri (m n : ℤ) : Set ℂ :=
  convexHull ℝ {hcDownC m n + e 0 / √3, hcDownC m n + e (2 * π / 3) / √3, hcDownC m n + e (4 * π / 3) / √3}

/-- The frame of the edge from the up centroid `C = hcUpC m n` in direction `w = e(2πj/3)` to its down neighbour `C + Lw`:
`(s, t) ↦ C + ((L − √3/6 − t) − s i) w`. The down triangle's facing side is `t = 0`, the segment `σ_e` is `t = 1`, the up
triangle's facing side is `t = 2`, all for `|s| ≤ 1/2`. -/
noncomputable def hcFrame (m n : ℤ) (j : Fin 3) (s t : ℝ) : ℂ :=
  hcUpC m n + (((hcL - √3 / 6 - t : ℝ) : ℂ) - s * I) * e (2 * π * (j : ℕ) / 3)

/-- The frame coordinate `s` of a point. -/
noncomputable def hcFrameS (m n : ℤ) (j : Fin 3) (z : ℂ) : ℝ := -((z - hcUpC m n) / e (2 * π * (j : ℕ) / 3)).im

/-- The frame coordinate `t` of a point. -/
noncomputable def hcFrameT (m n : ℤ) (j : Fin 3) (z : ℂ) : ℝ :=
  hcL - √3 / 6 - ((z - hcUpC m n) / e (2 * π * (j : ℕ) / 3)).re

/-- The up triangle cut by the gap function: `U = {z ∈ T_up : t ≥ 2 + g(s)` in each of its three edge frames`}`. -/
def hcUp (g : ℝ → ℝ) (m n : ℤ) : Set ℂ :=
  {z | z ∈ hcUpTri m n ∧ ∀ j : Fin 3, 2 + g (hcFrameS m n j z) ≤ hcFrameT m n j z}

/-- `ℓ(s) = inf {t : d_U(s, t) ≤ 1}`, the lower unit parallel of `U` in the edge's frame. -/
noncomputable def hcBandTop (g : ℝ → ℝ) (m n : ℤ) (j : Fin 3) (s : ℝ) : ℝ :=
  sInf {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1}

/-- The band `Λ_e = {(s, t) : |s| < 1/2, 1 < t < ℓ(s)}`. -/
def hcBand (g : ℝ → ℝ) (m n : ℤ) (j : Fin 3) : Set ℂ :=
  {z | ∃ s t : ℝ, |s| < 1 / 2 ∧ 1 < t ∧ t < hcBandTop g m n j s ∧ z = hcFrame m n j s t}

/-- **HC**: the down triangles, the cut up triangles, the closed bands and the face discs of radius `1/2`. -/
def hcSet (g : ℝ → ℝ) : Set ℂ :=
  (⋃ (m : ℤ) (n : ℤ), hcDownTri m n) ∪ (⋃ (m : ℤ) (n : ℤ), hcUp g m n) ∪
    (⋃ (m : ℤ) (n : ℤ) (j : Fin 3), closure (hcBand g m n j)) ∪ ⋃ (m : ℤ) (n : ℤ), closedBall (hcFace m n) (1 / 2)

/-- **(G1)**, as the proofs of FS111-M3-HC and FS111-M3-IRREG read it (`plans/FS111-M3-finiteness.md` § 2.2): on `[−1/2, 1/2]`,
`0 ≤ g ≤ dist(·, Z)²/4`, `|g′| ≤ dist(·, Z)/2`, `g ≤ 1/64`, `|g′| ≤ 1/8`, `g > 0` off `Z`, and the lower-parabola bound
`g(s) ≥ g(σ) + g′(σ)(s − σ) − (s − σ)²/4` — the only use of the derivation's `|g″| ≤ 1/2`, stated in its place (wider). -/
def G1Bounds (Z : Set ℝ) (g : ℝ → ℝ) : Prop :=
  Differentiable ℝ g ∧
    (∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), 0 ≤ g s ∧ g s ≤ infDist s Z ^ 2 / 4 ∧ |deriv g s| ≤ infDist s Z / 2 ∧
      g s ≤ 1 / 64 ∧ |deriv g s| ≤ 1 / 8) ∧
    (∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), s ∉ Z → 0 < g s) ∧
    ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), ∀ σ ∈ Icc (-1 / 2 : ℝ) (1 / 2), g σ + deriv g σ * (s - σ) - (s - σ) ^ 2 / 4 ≤ g s

open scoped Classical in
/-- § 1.6's gap function: `(s − a)²(b − s)²/4` on each gap `(a, b)` of `Z` in `[−1/2, 1/2]`, and `0` elsewhere. -/
noncomputable def hcGap (Z : Set ℝ) (s : ℝ) : ℝ :=
  if s ∈ Icc (-1 / 2 : ℝ) (1 / 2) ∧ s ∉ Z then (s - sSup (Z ∩ Iic s)) ^ 2 * (sInf (Z ∩ Ici s) - s) ^ 2 / 4 else 0

/-! ### Spec examples -/

/-- The face lattice's spacing is `L√3 = 2√3 + 1`. -/
example : dist (hcFace 1 0) (hcFace 0 0) = 2 * √3 + 1 := by
  have h3 : (√3 : ℝ) * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  rw [dist_eq_norm, hcFace, hcFace, tri, tri]
  simp only [Int.cast_one, Int.cast_zero, zero_mul, add_zero, mul_zero, sub_zero, mul_one, norm_mul, norm_e,
    norm_real, Real.norm_eq_abs]
  rw [abs_of_pos (by unfold hcL; positivity), abs_of_pos (by positivity)]
  unfold hcL; nlinarith [h3]

/-- The up triangle's vertex toward its face centre `O` is at distance `L − 1/√3 = 2` from `O`. -/
example (m n : ℤ) : dist (hcUpC m n + e π / √3) (hcFace m n) = 2 := by
  have he : e π = -1 := by simp [e, Complex.exp_pi_mul_I]
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  rw [hcUpC, he, dist_eq_norm, show hcFace m n + (hcL : ℂ) + -1 / (√3 : ℂ) - hcFace m n = ((hcL - 1 / √3 : ℝ) : ℂ) by
    push_cast; ring, norm_real, Real.norm_eq_abs]
  unfold hcL
  rw [show (2 : ℝ) + √3 / 3 - 1 / √3 = 2 by field_simp; ring_nf; rw [Real.sq_sqrt (by norm_num)]; ring]
  norm_num

/-- The two facing sides of an edge are `2` apart along the frame's `t` axis. -/
example (m n : ℤ) (j : Fin 3) : dist (hcFrame m n j 0 2) (hcFrame m n j 0 0) = 2 := by
  rw [dist_eq_norm, hcFrame, hcFrame, add_sub_add_left_eq_sub, ← sub_mul, norm_mul, norm_e]
  push_cast
  ring_nf
  simp

/-- The face disc at the origin is in HC, for every gap function. -/
example (g : ℝ → ℝ) : (0 : ℂ) ∈ hcSet g :=
  Or.inr (mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨0, by simp [hcFace, tri]⟩⟩)

/-! ### The row -/

/-! ### FS131-K2d: children of `g1Bounds_hcGap` (plan § 16) -/

/-- On a gap `(a, b)` of `Z` (`a, b ∈ Z`, no point of `Z` strictly between), `hcGap Z` is `(s − a)²(b − s)²/4`. -/
theorem hcGap_eq_of_gap {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) {a b s : ℝ} (ha : a ∈ Z)
    (hb : b ∈ Z) (hab : ∀ z ∈ Z, z ∉ Ioo a b) (hs : s ∈ Ioo a b) : hcGap Z s = (s - a) ^ 2 * (b - s) ^ 2 / 4 := by
  have _ := hZc -- idle: the gap's ends are given
  have hsZ : s ∉ Z := fun h => hab s h hs
  have hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨(hZs ha).1.trans hs.1.le, hs.2.le.trans (hZs hb).2⟩
  have h1 : sSup (Z ∩ Iic s) = a := by
    refine IsGreatest.csSup_eq ⟨⟨ha, hs.1.le⟩, fun z hz => ?_⟩
    by_contra h
    exact hab z hz.1 ⟨lt_of_not_ge h, lt_of_le_of_lt hz.2 hs.2⟩
  have h2 : sInf (Z ∩ Ici s) = b := by
    refine IsLeast.csInf_eq ⟨⟨hb, hs.2.le⟩, fun z hz => ?_⟩
    by_contra h
    exact hab z hz.1 ⟨lt_of_lt_of_le hs.1 hz.2, lt_of_not_ge h⟩
  rw [hcGap, if_pos ⟨hsI, hsZ⟩, h1, h2]

/-- Every point of `[−1/2, 1/2]` off `Z` lies in a gap of `Z`. -/
theorem hcGap_exists_gap {Z : Set ℝ} (hZc : IsClosed Z) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {s : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) (hsZ : s ∉ Z) :
    ∃ a b, a ∈ Z ∧ b ∈ Z ∧ (∀ z ∈ Z, z ∉ Ioo a b) ∧ s ∈ Ioo a b := by
  have hA : sSup (Z ∩ Iic s) ∈ Z ∩ Iic s :=
    (hZc.inter (isClosed_Iic (a := s))).csSup_mem ⟨_, hl, hs.1⟩ (bddAbove_Iic.mono inter_subset_right)
  have hB : sInf (Z ∩ Ici s) ∈ Z ∩ Ici s :=
    (hZc.inter (isClosed_Ici (a := s))).csInf_mem ⟨_, hr, hs.2⟩ (bddBelow_Ici.mono inter_subset_right)
  refine ⟨_, _, hA.1, hB.1, fun z hz hzI => ?_, ⟨lt_of_le_of_ne hA.2 fun h => hsZ (h ▸ hA.1),
    lt_of_le_of_ne hB.2 fun h => hsZ (h.symm ▸ hB.1)⟩⟩
  rcases le_total z s with h | h
  · exact absurd (le_csSup (bddAbove_Iic.mono inter_subset_right) ⟨hz, h⟩) (not_le.2 hzI.1)
  · exact absurd (csInf_le (bddBelow_Ici.mono inter_subset_right) ⟨hz, h⟩) (not_le.2 hzI.2)

/-- On a gap, `hcGap Z` has the polynomial's derivative `(s − a)(b − s)(a + b − 2s)/2`. -/
theorem hasDerivAt_hcGap_of_gap {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) {a b s : ℝ}
    (ha : a ∈ Z) (hb : b ∈ Z) (hab : ∀ z ∈ Z, z ∉ Ioo a b) (hs : s ∈ Ioo a b) :
    HasDerivAt (hcGap Z) ((s - a) * (b - s) * (a + b - 2 * s) / 2) s := by
  have hp : HasDerivAt (fun t : ℝ => (t - a) ^ 2 * (b - t) ^ 2 / 4) ((s - a) * (b - s) * (a + b - 2 * s) / 2) s := by
    have hq : HasDerivAt (fun t : ℝ => (t - a) * (b - t)) (1 * (b - s) + (s - a) * (-1)) s :=
      ((hasDerivAt_id' s).sub_const a).mul ((hasDerivAt_id' s).const_sub b)
    have hf : (fun t : ℝ => (t - a) ^ 2 * (b - t) ^ 2 / 4) = fun t => (t - a) * (b - t) * ((t - a) * (b - t)) / 4 := by
      funext t; ring
    rw [hf]
    exact ((hq.mul hq).div_const 4).congr_deriv (by ring)
  refine hp.congr_of_eventuallyEq ?_
  filter_upwards [Ioo_mem_nhds hs.1 hs.2] with t ht
  exact hcGap_eq_of_gap hZc hZs ha hb hab ht

/-- Near a point `z` of `Z`, `|hcGap Z t| ≤ (t − z)²/4` (gaps have width at most `1`). -/
theorem abs_hcGap_le_sq {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {z : ℝ} (hz : z ∈ Z) (t : ℝ) : |hcGap Z t| ≤ (t - z) ^ 2 / 4 := by
  by_cases ht : t ∈ Icc (-1 / 2 : ℝ) (1 / 2) ∧ t ∉ Z
  · obtain ⟨a, b, ha, hb, hab, hta⟩ := hcGap_exists_gap hZc hl hr ht.1 ht.2
    rw [hcGap_eq_of_gap hZc hZs ha hb hab hta]
    have hb1 := (hZs hb).2
    have ha1 := (hZs ha).1
    rw [abs_of_nonneg (by positivity)]
    have hzab := hab z hz
    rw [mem_Ioo, not_and_or, not_lt, not_lt] at hzab
    rcases hzab with h | h
    · have e1 : (t - a) ^ 2 ≤ (t - z) ^ 2 := by nlinarith [hta.1]
      have e2 : (b - t) ^ 2 ≤ 1 := by nlinarith [hta.1, hta.2]
      have := mul_le_mul e1 e2 (sq_nonneg _) (sq_nonneg _)
      linarith
    · have e1 : (b - t) ^ 2 ≤ (t - z) ^ 2 := by nlinarith [hta.2]
      have e2 : (t - a) ^ 2 ≤ 1 := by nlinarith [hta.1, hta.2]
      have := mul_le_mul e2 e1 (sq_nonneg _) zero_le_one
      linarith
  · rw [hcGap, if_neg ht, abs_zero]; positivity

/-- At a point of `Z`, `hcGap Z` has derivative `0`. -/
theorem hasDerivAt_hcGap_of_mem {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2))
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {z : ℝ} (hz : z ∈ Z) : HasDerivAt (hcGap Z) 0 z := by
  rw [hasDerivAt_iff_isLittleO_nhds_zero]
  have h0 : hcGap Z z = 0 := by rw [hcGap, if_neg (fun h => h.2 hz)]
  refine Asymptotics.IsBigO.trans_isLittleO (g := fun h : ℝ => h ^ 2) ?_ (Asymptotics.isLittleO_pow_id one_lt_two)
  refine Asymptotics.IsBigO.of_bound (1 / 4) (Eventually.of_forall fun h => ?_)
  rw [h0, smul_zero, sub_zero, sub_zero, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg (sq_nonneg h)]
  have := abs_hcGap_le_sq hZc hZs hl hr hz (z + h)
  rw [add_sub_cancel_left] at this
  linarith

/-- `hcGap Z` is differentiable on `ℝ`, with `|g′| ≤ dist(·, Z)/2` on `[−1/2, 1/2]` (`g′ = 0` on `Z` because `g ≤ dist²/4`). -/
theorem differentiable_hcGap {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) :
    Differentiable ℝ (hcGap Z) ∧ ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), |deriv (hcGap Z) s| ≤ infDist s Z / 2 := by
  have hne : Z.Nonempty := ⟨_, hl⟩
  refine ⟨fun s => ?_, fun s hs => ?_⟩
  · by_cases hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)
    · by_cases hsZ : s ∈ Z
      · exact (hasDerivAt_hcGap_of_mem hZc hZs hl hr hsZ).differentiableAt
      · obtain ⟨a, b, ha, hb, hab, hsab⟩ := hcGap_exists_gap hZc hl hr hsI hsZ
        exact (hasDerivAt_hcGap_of_gap hZc hZs ha hb hab hsab).differentiableAt
    · have hU : (Icc (-1 / 2 : ℝ) (1 / 2))ᶜ ∈ 𝓝 s := isClosed_Icc.isOpen_compl.mem_nhds hsI
      refine ((hasDerivAt_const s (0 : ℝ)).congr_of_eventuallyEq ?_).differentiableAt
      filter_upwards [hU] with t ht
      rw [hcGap, if_neg fun h => ht h.1]
  · by_cases hsZ : s ∈ Z
    · rw [(hasDerivAt_hcGap_of_mem hZc hZs hl hr hsZ).deriv, abs_zero]
      exact div_nonneg infDist_nonneg two_pos.le
    · obtain ⟨a, b, ha, hb, hab, hsab⟩ := hcGap_exists_gap hZc hl hr hs hsZ
      rw [(hasDerivAt_hcGap_of_gap hZc hZs ha hb hab hsab).deriv]
      have ha1 := (hZs ha).1
      have hb1 := (hZs hb).2
      have hx : 0 < s - a := by linarith [hsab.1]
      have hy : 0 < b - s := by linarith [hsab.2]
      have hdist : min (s - a) (b - s) ≤ infDist s Z := by
        refine (le_infDist hne).2 fun z hz => ?_
        have hzab := hab z hz
        rw [mem_Ioo, not_and_or, not_lt, not_lt] at hzab
        rw [Real.dist_eq]
        rcases hzab with h | h
        · exact (min_le_left _ _).trans (by rw [abs_of_nonneg (by linarith)]; linarith)
        · exact (min_le_right _ _).trans (by rw [abs_of_nonpos (by linarith)]; linarith)
      refine le_trans ?_ (div_le_div_of_nonneg_right hdist two_pos.le)
      rw [abs_div, abs_two, abs_mul, abs_mul, abs_of_pos hx, abs_of_pos hy]
      have hc : |a + b - 2 * s| ≤ 1 := abs_le.2 ⟨by linarith, by linarith⟩
      rcases le_total (s - a) (b - s) with h | h
      · rw [min_eq_left h]
        have : (b - s) * |a + b - 2 * s| ≤ 1 := by
          have := mul_le_mul (show b - s ≤ 1 by linarith) hc (abs_nonneg _) zero_le_one
          linarith
        have := mul_le_mul_of_nonneg_left this hx.le
        rw [div_le_div_iff_of_pos_right two_pos]
        nlinarith
      · rw [min_eq_right h]
        have : (s - a) * |a + b - 2 * s| ≤ 1 := by
          have := mul_le_mul (show s - a ≤ 1 by linarith) hc (abs_nonneg _) zero_le_one
          linarith
        have := mul_le_mul_of_nonneg_left this hy.le
        rw [div_le_div_iff_of_pos_right two_pos]
        nlinarith

/-- (G1)'s pointwise bounds on `[−1/2, 1/2]`: `0 ≤ g ≤ dist²/4`, `g ≤ 1/64`, `|g′| ≤ 1/8`, `g > 0` off `Z` (gaps have width
`≤ 1`). -/
theorem hcGap_bounds {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) :
    ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), 0 ≤ hcGap Z s ∧ hcGap Z s ≤ infDist s Z ^ 2 / 4 ∧ hcGap Z s ≤ 1 / 64 ∧
      |deriv (hcGap Z) s| ≤ 1 / 8 ∧ (s ∉ Z → 0 < hcGap Z s) := by
  intro s hs
  have hne : Z.Nonempty := ⟨_, hl⟩
  by_cases hsZ : s ∈ Z
  · have h0 : hcGap Z s = 0 := by rw [hcGap, if_neg (fun h => h.2 hsZ)]
    rw [h0, infDist_zero_of_mem hsZ, (hasDerivAt_hcGap_of_mem hZc hZs hl hr hsZ).deriv]
    exact ⟨le_rfl, by norm_num, by norm_num, by norm_num, fun h => absurd hsZ h⟩
  · obtain ⟨a, b, ha, hb, hab, hsab⟩ := hcGap_exists_gap hZc hl hr hs hsZ
    rw [hcGap_eq_of_gap hZc hZs ha hb hab hsab, (hasDerivAt_hcGap_of_gap hZc hZs ha hb hab hsab).deriv]
    have ha1 := (hZs ha).1
    have hb1 := (hZs hb).2
    have hx : 0 < s - a := by linarith [hsab.1]
    have hy : 0 < b - s := by linarith [hsab.2]
    have hdist : min (s - a) (b - s) ≤ infDist s Z := by
      refine (le_infDist hne).2 fun z hz => ?_
      have hzab := hab z hz
      rw [mem_Ioo, not_and_or, not_lt, not_lt] at hzab
      rw [Real.dist_eq]
      rcases hzab with h | h
      · exact (min_le_left _ _).trans (by rw [abs_of_nonneg (by linarith)]; linarith)
      · exact (min_le_right _ _).trans (by rw [abs_of_nonpos (by linarith)]; linarith)
    have hm0 : 0 ≤ (s - a) * (b - s) := by positivity
    have h4 : (s - a) * (b - s) ≤ 1 / 4 := by nlinarith [sq_nonneg ((s - a) - (b - s))]
    refine ⟨by positivity, ?_, ?_, ?_, fun _ => by positivity⟩
    · have hm : (s - a) * (b - s) ≤ min (s - a) (b - s) := by
        rcases le_total (s - a) (b - s) with h | h
        · rw [min_eq_left h]; nlinarith [mul_le_mul_of_nonneg_left (show b - s ≤ 1 by linarith) hx.le]
        · rw [min_eq_right h]; nlinarith [mul_le_mul_of_nonneg_left (show s - a ≤ 1 by linarith) hy.le]
      have := pow_le_pow_left₀ hm0 (hm.trans hdist) 2
      have e : (s - a) ^ 2 * (b - s) ^ 2 = ((s - a) * (b - s)) ^ 2 := by ring
      rw [e]; linarith
    · have := mul_le_mul h4 h4 hm0 (by norm_num)
      have e : (s - a) ^ 2 * (b - s) ^ 2 = ((s - a) * (b - s)) * ((s - a) * (b - s)) := by ring
      rw [e]; linarith
    · rw [abs_div, abs_two, abs_mul, abs_mul, abs_of_pos hx, abs_of_pos hy]
      have hc : |a + b - 2 * s| ≤ 1 := abs_le.2 ⟨by linarith, by linarith⟩
      have := mul_le_mul h4 hc (abs_nonneg _) (by norm_num)
      linarith

/-- `|g′(t)| ≤ |t − z|/2` for `t ∈ [−1/2, 1/2]` and `z ∈ Z`. -/
theorem abs_deriv_hcGap_le {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {t z : ℝ} (ht : t ∈ Icc (-1 / 2 : ℝ) (1 / 2)) (hz : z ∈ Z) :
    |deriv (hcGap Z) t| ≤ |t - z| / 2 := by
  by_cases htZ : t ∈ Z
  · rw [(hasDerivAt_hcGap_of_mem hZc hZs hl hr htZ).deriv, abs_zero]; positivity
  · obtain ⟨a, b, ha, hb, hab, htab⟩ := hcGap_exists_gap hZc hl hr ht htZ
    rw [(hasDerivAt_hcGap_of_gap hZc hZs ha hb hab htab).deriv]
    have ha1 := (hZs ha).1
    have hb1 := (hZs hb).2
    have hx : 0 < t - a := by linarith [htab.1]
    have hy : 0 < b - t := by linarith [htab.2]
    have hc : |a + b - 2 * t| ≤ 1 := abs_le.2 ⟨by linarith, by linarith⟩
    have hzab := hab z hz
    rw [mem_Ioo, not_and_or, not_lt, not_lt] at hzab
    rw [abs_div, abs_two, abs_mul, abs_mul, abs_of_pos hx, abs_of_pos hy, div_le_div_iff_of_pos_right two_pos]
    rcases hzab with h | h
    · have h1 : (b - t) * |a + b - 2 * t| ≤ 1 := by
        have := mul_le_mul (show b - t ≤ 1 by linarith) hc (abs_nonneg _) zero_le_one; linarith
      have h2 : t - a ≤ |t - z| := by rw [abs_of_nonneg (by linarith)]; linarith
      nlinarith [mul_le_mul_of_nonneg_left h1 hx.le]
    · have h1 : (t - a) * |a + b - 2 * t| ≤ 1 := by
        have := mul_le_mul (show t - a ≤ 1 by linarith) hc (abs_nonneg _) zero_le_one; linarith
      have h2 : b - t ≤ |t - z| := by rw [abs_of_nonpos (by linarith)]; linarith
      nlinarith [mul_le_mul_of_nonneg_left h1 hy.le]

/-- `g′` is `1/2`-Lipschitz on `[−1/2, 1/2]`: on one gap `|g″| ≤ 1/2`, across a point of `Z` the two bounds add. -/
theorem abs_deriv_hcGap_sub_le {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2))
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {s σ : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2))
    (hσ : σ ∈ Icc (-1 / 2 : ℝ) (1 / 2)) : |deriv (hcGap Z) s - deriv (hcGap Z) σ| ≤ |s - σ| / 2 := by
  wlog hle : σ ≤ s generalizing s σ
  · have := this hσ hs (le_of_not_ge hle); rwa [abs_sub_comm, abs_sub_comm σ] at this
  by_cases hz : ∃ z ∈ Z, z ∈ Icc σ s
  · obtain ⟨z, hz, hzI⟩ := hz
    have h1 := abs_deriv_hcGap_le hZc hZs hl hr hs hz
    have h2 := abs_deriv_hcGap_le hZc hZs hl hr hσ hz
    rw [abs_of_nonneg (sub_nonneg.2 hzI.2)] at h1
    rw [abs_of_nonpos (sub_nonpos.2 hzI.1)] at h2
    rw [abs_of_nonneg (sub_nonneg.2 hle)]
    calc _ ≤ |deriv (hcGap Z) s| + |deriv (hcGap Z) σ| := abs_sub _ _
      _ ≤ _ := by linarith
  · push Not at hz
    have hsZ : s ∉ Z := fun h => hz s h ⟨hle, le_rfl⟩
    obtain ⟨a, b, ha, hb, hab, hsab⟩ := hcGap_exists_gap hZc hl hr hs hsZ
    have hσab : σ ∈ Ioo a b := ⟨lt_of_not_ge fun h => hz a ha ⟨h, hsab.1.le⟩, lt_of_le_of_lt hle hsab.2⟩
    rw [(hasDerivAt_hcGap_of_gap hZc hZs ha hb hab hsab).deriv,
      (hasDerivAt_hcGap_of_gap hZc hZs ha hb hab hσab).deriv]
    have ha1 := (hZs ha).1
    have hb1 := (hZs hb).2
    have hpoly : ∀ u v w : ℝ, 0 ≤ u → u ≤ w → 0 ≤ v → v ≤ w → w ≤ 1 →
        |w ^ 2 - 3 * (u + v) * w + 2 * (u ^ 2 + u * v + v ^ 2)| ≤ 1 := by
      intro u v w hu huw hv hvw hw1
      rw [abs_le]; constructor
      · nlinarith [sq_nonneg (w - u - v), sq_nonneg (u - v), mul_nonneg (le_trans hu huw) (sub_nonneg.2 hw1)]
      · nlinarith [mul_nonneg hu (sub_nonneg.2 huw), mul_nonneg hv (sub_nonneg.2 hvw), mul_nonneg hu (sub_nonneg.2 hvw),
          mul_nonneg hv (sub_nonneg.2 huw), mul_nonneg (le_trans hu huw) (sub_nonneg.2 hw1)]
    have key : (s - a) * (b - s) * (a + b - 2 * s) / 2 - (σ - a) * (b - σ) * (a + b - 2 * σ) / 2 =
        (s - σ) * ((b - a) ^ 2 - 3 * ((s - a) + (σ - a)) * (b - a) +
          2 * ((s - a) ^ 2 + (s - a) * (σ - a) + (σ - a) ^ 2)) / 2 := by ring
    rw [key, abs_div, abs_two, abs_mul, div_le_div_iff_of_pos_right two_pos]
    have hf := hpoly (s - a) (σ - a) (b - a) (by linarith [hsab.1]) (by linarith [hsab.2]) (by linarith [hσab.1])
      (by linarith [hσab.2]) (by linarith)
    calc |s - σ| * _ ≤ |s - σ| * 1 := mul_le_mul_of_nonneg_left hf (abs_nonneg _)
      _ = |s - σ| := mul_one _

/-- The lower-parabola bound: `g′` is `1/2`-Lipschitz on `[−1/2, 1/2]` (`|g″| ≤ 1/2` on gaps, `g′ = 0` on `Z`), then Taylor. -/
theorem hcGap_lowerParabola {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) :
    ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), ∀ σ ∈ Icc (-1 / 2 : ℝ) (1 / 2),
      hcGap Z σ + deriv (hcGap Z) σ * (s - σ) - (s - σ) ^ 2 / 4 ≤ hcGap Z s := by
  intro s hs σ hσ
  have hd := (differentiable_hcGap hZc hZs hl hr).1
  set g := hcGap Z with hg
  set h : ℝ → ℝ := fun t => g t - g σ - deriv g σ * (t - σ) + (t - σ) * (t - σ) / 4 with hh
  have hhd : ∀ t, HasDerivAt h (deriv g t - deriv g σ + (t - σ) / 2) t := by
    intro t
    have h1 := ((hd t).hasDerivAt.sub_const (g σ)).sub (((hasDerivAt_id' t).sub_const σ).const_mul (deriv g σ))
    have h2 := (((hasDerivAt_id' t).sub_const σ).mul ((hasDerivAt_id' t).sub_const σ)).div_const 4
    exact (h1.add h2).congr_deriv (by ring)
  have hcont : Continuous h := continuous_iff_continuousAt.2 fun t => (hhd t).continuousAt
  have hdiff : Differentiable ℝ h := fun t => (hhd t).differentiableAt
  have hσ0 : h σ = 0 := by simp only [hh]; ring
  have hlip := fun t (ht : t ∈ Icc (-1 / 2 : ℝ) (1 / 2)) => abs_deriv_hcGap_sub_le hZc hZs hl hr ht hσ
  have hfin : 0 ≤ h s := by
    rcases le_total σ s with hle | hle
    · have hmono : MonotoneOn h (Icc σ (1 / 2)) := by
        refine monotoneOn_of_deriv_nonneg (convex_Icc _ _) hcont.continuousOn hdiff.differentiableOn fun x hx => ?_
        rw [interior_Icc] at hx
        rw [(hhd x).deriv]
        have := hlip x ⟨by linarith [hσ.1, hx.1], hx.2.le⟩
        rw [abs_of_nonneg (by linarith [hx.1] : (0 : ℝ) ≤ x - σ)] at this
        linarith [(abs_le.1 this).1]
      have := hmono ⟨le_rfl, hσ.2⟩ ⟨hle, hs.2⟩ hle
      linarith
    · have hanti : AntitoneOn h (Icc (-1 / 2) σ) := by
        refine antitoneOn_of_deriv_nonpos (convex_Icc _ _) hcont.continuousOn hdiff.differentiableOn fun x hx => ?_
        rw [interior_Icc] at hx
        rw [(hhd x).deriv]
        have := hlip x ⟨hx.1.le, by linarith [hσ.2, hx.2]⟩
        rw [abs_of_nonpos (by linarith [hx.2] : x - σ ≤ 0)] at this
        linarith [(abs_le.1 this).2]
      have := hanti ⟨hs.1, hle⟩ ⟨hσ.1, le_rfl⟩ hle
      linarith
  have e : (s - σ) ^ 2 = (s - σ) * (s - σ) := sq _
  simp only [hh] at hfin
  rw [e]; linarith

/-- `(G1)` holds for § 1.6's formula on every closed `Z ⊆ [−1/2, 1/2]` holding `±1/2` (the gaps have width at most `1`). -/
theorem g1Bounds_hcGap {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) : G1Bounds Z (hcGap Z) := by
  obtain ⟨hd, hd'⟩ := differentiable_hcGap hZc hZs hl hr
  have hb := hcGap_bounds hZc hZs hl hr
  refine ⟨hd, fun s hs => ⟨(hb s hs).1, (hb s hs).2.1, hd' s hs, (hb s hs).2.2.1, (hb s hs).2.2.2.1⟩,
    fun s hs hsZ => (hb s hs).2.2.2.2 hsZ, hcGap_lowerParabola hZc hZs hl hr⟩

/-! ### FS131-K2d: children of HC's and IRREG's leaves (plan § 17; `plans/FS111-M3-finiteness.md` §§ 2.2–2.4, 4.2)

Every child is stated with `interior Z = ∅` where § 4.2 (1) says nullity is unused, so IRREG reuses it; nullity enters only in
`hc_ae_phi_pos`. -/

/-- The segment `σ_e = [−1/2, 1/2] × {1}` of an edge, in its frame. -/
def hcSeg (m n : ℤ) (j : Fin 3) : Set ℂ := (fun s => hcFrame m n j s 1) '' Icc (-1 / 2) (1 / 2)

/-- The edge frame is an isometry from `ℝ²`. -/
theorem dist_hcFrame (m n : ℤ) (j : Fin 3) (s t s' t' : ℝ) :
    dist (hcFrame m n j s t) (hcFrame m n j s' t') = √((s - s') ^ 2 + (t - t') ^ 2) := by
  rw [dist_eq_norm, hcFrame, hcFrame, add_sub_add_left_eq_sub, ← sub_mul, norm_mul, norm_e, mul_one]
  have : ((hcL - √3 / 6 - t : ℝ) : ℂ) - (s : ℂ) * I - (((hcL - √3 / 6 - t' : ℝ) : ℂ) - (s' : ℂ) * I) =
      ((t' - t : ℝ) : ℂ) + ((-(s - s') : ℝ) : ℂ) * I := by push_cast; ring
  rw [this, Complex.norm_add_mul_I]
  congr 1; ring

/-- `hcFrameS`, `hcFrameT` invert the frame. -/
theorem hcFrame_coords (m n : ℤ) (j : Fin 3) (s t : ℝ) :
    hcFrameS m n j (hcFrame m n j s t) = s ∧ hcFrameT m n j (hcFrame m n j s t) = t := by
  have he : e (2 * π * ((j : ℕ) : ℝ) / 3) ≠ 0 := by
    intro h; have := norm_e (2 * π * ((j : ℕ) : ℝ) / 3); rw [h, norm_zero] at this; norm_num at this
  have hq : (hcFrame m n j s t - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) =
      ((hcL - √3 / 6 - t : ℝ) : ℂ) - (s : ℂ) * I := by
    rw [hcFrame, add_sub_cancel_left, mul_div_assoc, div_self he, mul_one]
  refine ⟨?_, ?_⟩
  · rw [hcFrameS, hq]; simp
  · rw [hcFrameT, hq]; simp

/-- The up triangle in each of its edge frames: `|s| ≤ 1/2`, `2 ≤ t ≤ 2 + √3/2`. -/
theorem hcUpTri_frame {m n : ℤ} {z : ℂ} (hz : z ∈ hcUpTri m n) (j : Fin 3) :
    |hcFrameS m n j z| ≤ 1 / 2 ∧ 2 ≤ hcFrameT m n j z ∧ hcFrameT m n j z ≤ 2 + √3 / 2 := by
  set φ : ℝ := 2 * π * ((j : ℕ) : ℝ) / 3 with hφ
  have hw0 : e φ ≠ 0 := by
    intro h; have := norm_e φ; rw [h, norm_zero] at this; norm_num at this
  have h3 : (√3 : ℝ) * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : (0 : ℝ) < √3 := by positivity
  -- the frame is affine
  set S : Set ℂ := {z | |hcFrameS m n j z| ≤ 1 / 2 ∧ 2 ≤ hcFrameT m n j z ∧ hcFrameT m n j z ≤ 2 + √3 / 2} with hS
  have haff : ∀ x y : ℂ, ∀ a b : ℝ, a + b = 1 →
      (a • x + b • y - hcUpC m n) / e φ = (a : ℂ) * ((x - hcUpC m n) / e φ) + (b : ℂ) * ((y - hcUpC m n) / e φ) := by
    intro x y a b hab
    have hab' : (a : ℂ) + b = 1 := by exact_mod_cast hab
    have h : (a : ℂ) * x + b * y - hcUpC m n = a * (x - hcUpC m n) + b * (y - hcUpC m n) := by
      linear_combination (hcUpC m n) * hab'
    rw [Complex.real_smul, Complex.real_smul, h, add_div, mul_div_assoc, mul_div_assoc]
  have hconv : Convex ℝ S := by
    intro x hx y hy a b ha hb hab
    have hS' : hcFrameS m n j (a • x + b • y) = a * hcFrameS m n j x + b * hcFrameS m n j y := by
      simp only [hcFrameS]
      rw [haff x y a b hab, Complex.add_im, Complex.im_ofReal_mul, Complex.im_ofReal_mul]; ring
    have hT' : hcFrameT m n j (a • x + b • y) = a * hcFrameT m n j x + b * hcFrameT m n j y := by
      simp only [hcFrameT]
      rw [haff x y a b hab, Complex.add_re, Complex.re_ofReal_mul, Complex.re_ofReal_mul]
      linear_combination (hcL - √3 / 6) * hab.symm
    refine ⟨?_, ?_, ?_⟩
    · rw [hS']
      calc |a * hcFrameS m n j x + b * hcFrameS m n j y| ≤ a * |hcFrameS m n j x| + b * |hcFrameS m n j y| := by
            refine (abs_add_le _ _).trans ?_
            rw [abs_mul, abs_mul, abs_of_nonneg ha, abs_of_nonneg hb]
        _ ≤ a * (1 / 2) + b * (1 / 2) := by gcongr; exacts [hx.1, hy.1]
        _ = 1 / 2 := by rw [← add_mul, hab, one_mul]
    · rw [hT']; nlinarith [hx.2.1, hy.2.1]
    · rw [hT']; nlinarith [hx.2.2, hy.2.2]
  -- the three vertices
  have hq : ∀ θ : ℝ, (hcUpC m n + e θ / √3 - hcUpC m n) / e φ = e (θ - φ) / √3 := by
    intro θ
    rw [add_sub_cancel_left, show e θ = e (θ - φ) * e φ by rw [← e_add, sub_add_cancel]]
    field_simp
  have hgood : ∀ θ u : ℝ, e (θ - φ) = e u → |Real.sin u| ≤ √3 / 2 → -1 ≤ Real.cos u → Real.cos u ≤ 1 / 2 →
      hcUpC m n + e θ / √3 ∈ S := by
    intro θ u hu hs hc1 hc2
    have hre : ((hcUpC m n + e θ / √3 - hcUpC m n) / e φ).re = Real.cos u / √3 := by
      rw [hq, hu, Complex.div_ofReal_re, e_eq]; simp [Complex.cos_ofReal_re, Complex.sin_ofReal_re]
    have him : ((hcUpC m n + e θ / √3 - hcUpC m n) / e φ).im = Real.sin u / √3 := by
      rw [hq, hu, Complex.div_ofReal_im, e_eq]; simp [Complex.sin_ofReal_re]
    refine ⟨?_, ?_, ?_⟩
    · rw [hcFrameS, him, abs_neg, abs_div, abs_of_pos h3p, div_le_iff₀ h3p]; nlinarith
    · rw [hcFrameT, hre, hcL]
      have : Real.cos u / √3 ≤ √3 / 6 := by rw [div_le_iff₀ h3p]; nlinarith
      nlinarith
    · rw [hcFrameT, hre, hcL]
      have : -(√3 / 3) ≤ Real.cos u / √3 := by rw [le_div_iff₀ h3p]; nlinarith
      nlinarith
  have hA : ∀ u : ℝ, u = π / 3 → |Real.sin u| ≤ √3 / 2 ∧ -1 ≤ Real.cos u ∧ Real.cos u ≤ 1 / 2 := by
    rintro u rfl; rw [Real.sin_pi_div_three, Real.cos_pi_div_three, abs_of_pos (by positivity)]; norm_num
  have hB : ∀ u : ℝ, u = -(π / 3) → |Real.sin u| ≤ √3 / 2 ∧ -1 ≤ Real.cos u ∧ Real.cos u ≤ 1 / 2 := by
    rintro u rfl; rw [Real.sin_neg, Real.cos_neg, Real.sin_pi_div_three, Real.cos_pi_div_three, abs_neg,
      abs_of_pos (by positivity)]; norm_num
  have hC : ∀ u : ℝ, u = π → |Real.sin u| ≤ √3 / 2 ∧ -1 ≤ Real.cos u ∧ Real.cos u ≤ 1 / 2 := by
    rintro u rfl; rw [Real.sin_pi, Real.cos_pi, abs_zero]; exact ⟨by positivity, by norm_num, by norm_num⟩
  have hsub : {hcUpC m n + e (π / 3) / √3, hcUpC m n + e π / √3, hcUpC m n + e (5 * π / 3) / √3} ⊆ S := by
    have he2 : ∀ x y : ℝ, x = y + 2 * π → e x = e y := fun x y h => by rw [h, e_add_two_pi]
    have he3 : ∀ x y : ℝ, x + 2 * π = y → e x = e y := fun x y h => by rw [← e_add_two_pi x, h]
    have hj : (j : ℕ) = 0 ∨ (j : ℕ) = 1 ∨ (j : ℕ) = 2 := by omega
    intro x hx
    simp only [mem_insert_iff, mem_singleton_iff] at hx
    rcases hj with hj | hj | hj <;> simp only [hj, Nat.cast_zero, Nat.cast_one, Nat.cast_ofNat] at hφ <;>
      rcases hx with rfl | rfl | rfl
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hA _ rfl).1 (hA _ rfl).2.1 (hA _ rfl).2.2
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hC _ rfl).1 (hC _ rfl).2.1 (hC _ rfl).2.2
    · exact hgood _ _ (he2 _ (-(π / 3)) (by rw [hφ]; ring)) (hB _ rfl).1 (hB _ rfl).2.1 (hB _ rfl).2.2
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hB _ rfl).1 (hB _ rfl).2.1 (hB _ rfl).2.2
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hA _ rfl).1 (hA _ rfl).2.1 (hA _ rfl).2.2
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hC _ rfl).1 (hC _ rfl).2.1 (hC _ rfl).2.2
    · exact hgood _ _ (he3 _ π (by rw [hφ]; ring)) (hC _ rfl).1 (hC _ rfl).2.1 (hC _ rfl).2.2
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hB _ rfl).1 (hB _ rfl).2.1 (hB _ rfl).2.2
    · exact hgood _ _ (by congr 1; rw [hφ]; ring) (hA _ rfl).1 (hA _ rfl).2.1 (hA _ rfl).2.2
  exact convexHull_min hsub hconv hz

/-- The edge directions `w_j = e(2πj/3)` explicitly. -/
theorem hc_w_explicit (j : Fin 3) :
    e (2 * π * ((j : ℕ) : ℝ) / 3) = ![(1 : ℂ), -1 / 2 + ((√3 / 2 : ℝ) : ℂ) * I, -1 / 2 - ((√3 / 2 : ℝ) : ℂ) * I] j := by
  fin_cases j
  · simp [e]
  · simp only [Fin.mk_one, Fin.isValue, Matrix.cons_val_one, Nat.cast_one, mul_one]
    rw [e_eq, show 2 * π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.sin_pi_sub, Real.cos_pi_div_three,
      Real.sin_pi_div_three]
    push_cast; ring
  · simp only [Fin.reduceFinMk, Matrix.cons_val, Nat.cast_ofNat]
    rw [e_eq, show 2 * π * 2 / 3 = π / 3 + π by ring, Real.cos_add_pi, Real.sin_add_pi, Real.cos_pi_div_three,
      Real.sin_pi_div_three]
    push_cast; ring

/-- The three edge frames of an up centroid in Cartesian coordinates `(a, b) = z − C`. -/
theorem hcFrame_explicit (m n : ℤ) (z : ℂ) :
    (hcFrameT m n 0 z = 2 + √3 / 6 - (z - hcUpC m n).re ∧ hcFrameS m n 0 z = -(z - hcUpC m n).im) ∧
    (hcFrameT m n 1 z = 2 + √3 / 6 + (z - hcUpC m n).re / 2 - √3 / 2 * (z - hcUpC m n).im ∧
      hcFrameS m n 1 z = √3 / 2 * (z - hcUpC m n).re + (z - hcUpC m n).im / 2) ∧
    (hcFrameT m n 2 z = 2 + √3 / 6 + (z - hcUpC m n).re / 2 + √3 / 2 * (z - hcUpC m n).im ∧
      hcFrameS m n 2 z = -(√3 / 2 * (z - hcUpC m n).re) + (z - hcUpC m n).im / 2) := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have hL : hcL - √3 / 6 = 2 + √3 / 6 := by unfold hcL; ring
  set a := (z - hcUpC m n).re
  set b := (z - hcUpC m n).im
  have hz : z - hcUpC m n = (a : ℂ) + (b : ℂ) * I := (Complex.re_add_im _).symm
  -- division by a unit complex number `w` is multiplication by its conjugate
  have hdiv : ∀ c d : ℝ, c * c + d * d = 1 → (z - hcUpC m n) / ((c : ℂ) + (d : ℂ) * I) =
      ((a * c + b * d : ℝ) : ℂ) + ((b * c - a * d : ℝ) : ℂ) * I := by
    intro c d hcd
    have hne : (c : ℂ) + (d : ℂ) * I ≠ 0 := by
      intro h
      have h1 := congrArg Complex.re h
      have h2 := congrArg Complex.im h
      simp at h1 h2
      rw [h1, h2] at hcd; norm_num at hcd
    rw [div_eq_iff hne, hz]
    apply Complex.ext
    · simp; linear_combination (-a) * hcd
    · simp; linear_combination (-b) * hcd
  have e0 : e (2 * π * (((0 : Fin 3) : ℕ) : ℝ) / 3) = 1 := by rw [hc_w_explicit]; simp
  have e1 : e (2 * π * (((1 : Fin 3) : ℕ) : ℝ) / 3) = (((-1 / 2 : ℝ)) : ℂ) + ((√3 / 2 : ℝ) : ℂ) * I := by
    rw [hc_w_explicit]; simp
  have e2 : e (2 * π * (((2 : Fin 3) : ℕ) : ℝ) / 3) = (((-1 / 2 : ℝ)) : ℂ) + ((-(√3 / 2) : ℝ) : ℂ) * I := by
    rw [hc_w_explicit]; simp; ring
  have c1 : (-1 / 2 : ℝ) * (-1 / 2) + √3 / 2 * (√3 / 2) = 1 := by nlinarith
  have c2 : (-1 / 2 : ℝ) * (-1 / 2) + -(√3 / 2) * -(√3 / 2) = 1 := by nlinarith
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · simp only [hcFrameT, e0, div_one, hL]; rfl
  · simp only [hcFrameS, e0, div_one]; rfl
  · simp only [hcFrameT, e1]; rw [hdiv _ _ c1, hL]; simp; ring
  · simp only [hcFrameS, e1]; rw [hdiv _ _ c1]; simp; ring
  · simp only [hcFrameT, e2]; rw [hdiv _ _ c2, hL]; simp; ring
  · simp only [hcFrameS, e2]; rw [hdiv _ _ c2]; simp; ring

/-- The frame inverts its coordinates. -/
theorem hcFrame_hcFrameST (m n : ℤ) (j : Fin 3) (z : ℂ) :
    hcFrame m n j (hcFrameS m n j z) (hcFrameT m n j z) = z := by
  have he : e (2 * π * ((j : ℕ) : ℝ) / 3) ≠ 0 := by
    intro h; have := norm_e (2 * π * ((j : ℕ) : ℝ) / 3); rw [h, norm_zero] at this; norm_num at this
  have hq : ((hcL - √3 / 6 - hcFrameT m n j z : ℝ) : ℂ) - (hcFrameS m n j z : ℂ) * I =
      (z - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) := by
    simp only [hcFrameT, hcFrameS]
    apply Complex.ext <;> simp
  rw [hcFrame, hq, div_mul_cancel₀ _ he, add_sub_cancel]

/-- Distance in an edge frame. -/
theorem dist_eq_hcFrame (m n : ℤ) (j : Fin 3) (z z' : ℂ) :
    dist z z' = √((hcFrameS m n j z - hcFrameS m n j z') ^ 2 + (hcFrameT m n j z - hcFrameT m n j z') ^ 2) := by
  conv_lhs => rw [← hcFrame_hcFrameST m n j z, ← hcFrame_hcFrameST m n j z']
  exact dist_hcFrame _ _ _ _ _ _ _

/-- The frame's `t` difference is at most the distance. -/
theorem abs_sub_hcFrameT_le (m n : ℤ) (j : Fin 3) (z z' : ℂ) :
    |hcFrameT m n j z - hcFrameT m n j z'| ≤ dist z z' := by
  rw [dist_eq_hcFrame m n j]
  exact Real.abs_le_sqrt (by nlinarith [sq_nonneg (hcFrameS m n j z - hcFrameS m n j z')])

/-- The frame's `s` difference is at most the distance. -/
theorem abs_sub_hcFrameS_le (m n : ℤ) (j : Fin 3) (z z' : ℂ) :
    |hcFrameS m n j z - hcFrameS m n j z'| ≤ dist z z' := by
  rw [dist_eq_hcFrame m n j]
  exact Real.abs_le_sqrt (by nlinarith [sq_nonneg (hcFrameT m n j z - hcFrameT m n j z')])

/-- The frame coordinate `s` is continuous. -/
theorem continuous_hcFrameS (m n : ℤ) (j : Fin 3) : Continuous (hcFrameS m n j) := by
  unfold hcFrameS; fun_prop

/-- The frame coordinate `t` is continuous. -/
theorem continuous_hcFrameT (m n : ℤ) (j : Fin 3) : Continuous (hcFrameT m n j) := by
  unfold hcFrameT; fun_prop

/-- The frame map is continuous. -/
theorem continuous_hcFrame (m n : ℤ) (j : Fin 3) : Continuous fun p : ℝ × ℝ => hcFrame m n j p.1 p.2 := by
  unfold hcFrame; fun_prop

/-- The frame map is continuous in `t`. -/
theorem continuous_hcFrame_t (m n : ℤ) (j : Fin 3) (s : ℝ) : Continuous fun t : ℝ => hcFrame m n j s t := by
  unfold hcFrame; fun_prop

/-- The frame map is continuous in `s`. -/
theorem continuous_hcFrame_s (m n : ℤ) (j : Fin 3) (t : ℝ) : Continuous fun s : ℝ => hcFrame m n j s t := by
  unfold hcFrame; fun_prop

/-- Two frames at one up centroid differ by a rotation of `±2π/3`. -/
theorem hcFrame_other (m n : ℤ) {j k : Fin 3} (hjk : j ≠ k) (z : ℂ) : ∃ ε : ℝ, (ε = 1 ∨ ε = -1) ∧
    hcFrameT m n k z = 2 + √3 / 6 + (2 + √3 / 6 - hcFrameT m n j z) / 2 - ε * (√3 / 2) * hcFrameS m n j z ∧
    hcFrameS m n k z = -(ε * (√3 / 2) * (2 + √3 / 6 - hcFrameT m n j z)) - hcFrameS m n j z / 2 := by
  have h3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  obtain ⟨⟨T0, S0⟩, ⟨T1, S1⟩, ⟨T2, S2⟩⟩ := hcFrame_explicit m n z
  fin_cases j <;> fin_cases k <;> simp at hjk <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue]
  · exact ⟨-1, Or.inr rfl, by rw [T1, T0, S0]; ring, by rw [S1, S0, T0]; ring⟩
  · exact ⟨1, Or.inl rfl, by rw [T2, T0, S0]; ring, by rw [S2, S0, T0]; ring⟩
  · refine ⟨1, Or.inl rfl, ?_, ?_⟩
    · rw [T0, T1, S1]; ring_nf; rw [h3]; ring
    · rw [S0, T1, S1]; ring_nf; rw [h3]; ring
  · refine ⟨-1, Or.inr rfl, ?_, ?_⟩
    · rw [T2, T1, S1]; ring_nf; rw [h3]; ring
    · rw [S2, T1, S1]; ring_nf; rw [h3]; ring
  · refine ⟨-1, Or.inr rfl, ?_, ?_⟩
    · rw [T0, T2, S2]; ring_nf; rw [h3]; ring
    · rw [S0, T2, S2]; ring_nf; rw [h3]; ring
  · refine ⟨1, Or.inl rfl, ?_, ?_⟩
    · rw [T1, T2, S2]; ring_nf; rw [h3]; ring
    · rw [S1, T2, S2]; ring_nf; rw [h3]; ring

/-- The up triangle's vertices relative to its centroid, in Cartesian form. -/
theorem hcUpTri_vertices :
    e (π / 3) / √3 = ((√3 / 6 : ℝ) : ℂ) + ((1 / 2 : ℝ) : ℂ) * I ∧ e π / √3 = ((-(√3 / 3) : ℝ) : ℂ) ∧
      e (5 * π / 3) / √3 = ((√3 / 6 : ℝ) : ℂ) + ((-(1 / 2) : ℝ) : ℂ) * I := by
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  have h3' : (√3 : ℂ) ≠ 0 := by exact_mod_cast h3
  have hs : √3 * √3 = (3 : ℝ) := Real.mul_self_sqrt (by norm_num)
  refine ⟨?_, ?_, ?_⟩
  · rw [e_eq, Real.cos_pi_div_three, Real.sin_pi_div_three, div_eq_iff h3']
    apply Complex.ext <;> simp <;> nlinarith
  · rw [e_eq, Real.cos_pi, Real.sin_pi, div_eq_iff h3']
    apply Complex.ext <;> simp; nlinarith
  · rw [e_eq, show 5 * π / 3 = 2 * π - π / 3 by ring, Real.cos_two_pi_sub, Real.sin_two_pi_sub, Real.cos_pi_div_three,
      Real.sin_pi_div_three, div_eq_iff h3']
    apply Complex.ext <;> simp <;> nlinarith

/-- **The up triangle is the intersection of its three inner half-planes** `t ≥ 2`. -/
theorem mem_hcUpTri_iff {m n : ℤ} {z : ℂ} : z ∈ hcUpTri m n ↔ ∀ k : Fin 3, 2 ≤ hcFrameT m n k z := by
  refine ⟨fun hz k => (hcUpTri_frame hz k).2.1, fun h => ?_⟩
  have hs : √3 * √3 = (3 : ℝ) := Real.mul_self_sqrt (by norm_num)
  obtain ⟨⟨T0, -⟩, ⟨T1, -⟩, ⟨T2, -⟩⟩ := hcFrame_explicit m n z
  have h0 := h 0
  have h1 := h 1
  have h2 := h 2
  rw [T0] at h0
  rw [T1] at h1
  rw [T2] at h2
  set a := (z - hcUpC m n).re
  set b := (z - hcUpC m n).im
  have hz : z = hcUpC m n + ((a : ℂ) + (b : ℂ) * I) := by rw [Complex.re_add_im]; ring
  obtain ⟨v1, v2, v3⟩ := hcUpTri_vertices
  have l0 : 0 ≤ 1 / 3 + √3 / 3 * a + b := by
    rw [show 1 / 3 + √3 / 3 * a + b = 2 * √3 / 3 * (√3 / 6 + a / 2 + √3 / 2 * b) by
      linear_combination (-(1 / 9) - b / 3) * hs]
    exact mul_nonneg (by positivity) (by linarith)
  have l1 : 0 ≤ 1 / 3 - 2 * √3 / 3 * a := by
    rw [show 1 / 3 - 2 * √3 / 3 * a = 2 * √3 / 3 * (√3 / 6 - a) by linear_combination (-(1 / 9)) * hs]
    exact mul_nonneg (by positivity) (by linarith)
  have l2 : 0 ≤ 1 / 3 + √3 / 3 * a - b := by
    rw [show 1 / 3 + √3 / 3 * a - b = 2 * √3 / 3 * (√3 / 6 + a / 2 - √3 / 2 * b) by
      linear_combination (-(1 / 9) + b / 3) * hs]
    exact mul_nonneg (by positivity) (by linarith)
  have hmem := (convex_convexHull ℝ ({hcUpC m n + e (π / 3) / √3, hcUpC m n + e π / √3,
      hcUpC m n + e (5 * π / 3) / √3} : Set ℂ)).sum_mem (t := Finset.univ)
    (w := ![1 / 3 + √3 / 3 * a + b, 1 / 3 - 2 * √3 / 3 * a, 1 / 3 + √3 / 3 * a - b])
    (z := ![hcUpC m n + e (π / 3) / √3, hcUpC m n + e π / √3, hcUpC m n + e (5 * π / 3) / √3])
    (fun i _ => by fin_cases i <;> simp <;> linarith)
    (by simp [Fin.sum_univ_three]; ring)
    (fun i _ => by fin_cases i <;> simp <;> exact subset_convexHull ℝ _ (by simp))
  unfold hcUpTri
  convert hmem using 1
  simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two, Matrix.vecHead,
    Matrix.vecTail, Function.comp, Fin.succ_zero_eq_one, Complex.real_smul]
  rw [v1, v2, v3]
  conv_lhs => rw [hz]
  apply Complex.ext <;> simp <;> nlinarith [hs]

/-- **(G2)**: the graph `t = 2 + g(s)`, `|s| ≤ 1/2`, of every side lies in `U` (the three slivers are disjoint and miss the other
sides' curves: `g ≤ (1/2 − |s|)²/4` against the corner distance `0.8 (1/2 − |s|)`). -/
theorem hcUp_slivers {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) :
    hcFrame m n j s (2 + g s) ∈ hcUp g m n := by
  have _ := hZc; have _ := hZs; have _ := hZi
  obtain ⟨-, hb, -, -⟩ := hg
  have h3 : √3 * √3 = (3 : ℝ) := Real.mul_self_sqrt (by norm_num)
  have h3l : (1.7 : ℝ) < √3 := by nlinarith [Real.sqrt_nonneg 3]
  have h3u : √3 < (1.75 : ℝ) := by nlinarith [Real.sqrt_nonneg 3]
  obtain ⟨hPS, hPT⟩ := hcFrame_coords m n j s (2 + g s)
  obtain ⟨g0, gZ, -, g64, -⟩ := hb s hs
  have key : ∀ k : Fin 3, 2 + g (hcFrameS m n k (hcFrame m n j s (2 + g s))) ≤ hcFrameT m n k (hcFrame m n j s (2 + g s)) ∧
      2 ≤ hcFrameT m n k (hcFrame m n j s (2 + g s)) := by
    intro k
    by_cases hk : k = j
    · subst hk; rw [hPS, hPT]; exact ⟨le_rfl, by linarith⟩
    obtain ⟨ε, hε, hT, hS⟩ := hcFrame_other m n (Ne.symm hk) (hcFrame m n j s (2 + g s))
    rw [hPS, hPT] at hT hS
    set τ := g s
    have hεε : ε * ε = 1 := by rcases hε with rfl | rfl <;> norm_num
    have hεa : |ε| = 1 := by rcases hε with rfl | rfl <;> norm_num
    -- `u = 1/2 − ε s` is the distance from `s` to the end `ε/2 ∈ Z`
    set u := 1 / 2 - ε * s with hu
    have hεs : |ε * s| ≤ 1 / 2 := by rw [abs_mul, hεa, one_mul, abs_le]; exact ⟨by linarith [hs.1], by linarith [hs.2]⟩
    have hu0 : 0 ≤ u := by rw [hu]; linarith [le_abs_self (ε * s)]
    have hu1 : u ≤ 1 := by rw [hu]; linarith [neg_abs_le (ε * s)]
    have hend : ∀ σ : ℝ, σ = 1 ∨ σ = -1 → σ / 2 ∈ Z := by
      rintro σ (rfl | rfl)
      · simpa using hr
      · simpa [neg_div] using hl
    have hτu : τ ≤ u ^ 2 / 4 := by
      have hd : infDist s Z ≤ u := by
        refine (infDist_le_dist_of_mem (hend ε hε)).trans_eq ?_
        rw [Real.dist_eq, show s - ε / 2 = ε * (ε * s - 1 / 2) by linear_combination (-s) * hεε + 0 * hεε, abs_mul, hεa,
          one_mul, abs_sub_comm, abs_of_nonneg hu0]
      refine gZ.trans ?_
      have := infDist_nonneg (x := s) (s := Z)
      nlinarith
    -- the other frame's coordinates: `t − 2 = (√3 u − τ)/2`, `s = ε (a − 1/2)` with `a = u/2 + (√3/2) τ`
    set α := u / 2 + √3 / 2 * τ with hα
    have hSk : hcFrameS m n k (hcFrame m n j s (2 + g s)) = ε * (α - 1 / 2) := by
      rw [hS, hα, hu]; linear_combination (-ε / 12) * h3 + (s / 2) * hεε
    have hTk : hcFrameT m n k (hcFrame m n j s (2 + g s)) = 2 + (√3 * u - τ) / 2 := by
      rw [hT, hu]; ring
    have hα0 : 0 ≤ α := by rw [hα]; positivity
    have hu2 : u ^ 2 ≤ u := by nlinarith
    have hτ4 : τ ≤ u / 4 := by linarith
    have hs3τ : √3 * τ ≤ 1.75 * (u / 4) := by
      calc √3 * τ ≤ √3 * (u / 4) := mul_le_mul_of_nonneg_left hτ4 (Real.sqrt_nonneg 3)
        _ ≤ 1.75 * (u / 4) := mul_le_mul_of_nonneg_right h3u.le (by linarith)
    have hs3u : 1.7 * u ≤ √3 * u := mul_le_mul_of_nonneg_right h3l.le hu0
    have hαu : α ≤ u := by rw [hα]; linarith
    have hSk' : hcFrameS m n k (hcFrame m n j s (2 + g s)) ∈ Icc (-1 / 2 : ℝ) (1 / 2) := by
      rw [hSk]
      have : |ε * (α - 1 / 2)| ≤ 1 / 2 := by rw [abs_mul, hεa, one_mul, abs_le]; constructor <;> linarith
      exact ⟨by linarith [neg_abs_le (ε * (α - 1 / 2))], by linarith [le_abs_self (ε * (α - 1 / 2))]⟩
    obtain ⟨gk0, gkZ, -, -, -⟩ := hb _ hSk'
    have hdk : infDist (hcFrameS m n k (hcFrame m n j s (2 + g s))) Z ≤ α := by
      refine (infDist_le_dist_of_mem (hend (-ε) (by rcases hε with rfl | rfl <;> norm_num))).trans_eq ?_
      rw [hSk, Real.dist_eq, show ε * (α - 1 / 2) - -ε / 2 = ε * α by ring, abs_mul, hεa, one_mul, abs_of_nonneg hα0]
    have hgk : g (hcFrameS m n k (hcFrame m n j s (2 + g s))) ≤ α ^ 2 / 4 := by
      refine gkZ.trans ?_
      have := infDist_nonneg (x := hcFrameS m n k (hcFrame m n j s (2 + g s))) (s := Z)
      nlinarith
    have hα2 : α ^ 2 ≤ u ^ 2 := pow_le_pow_left₀ hα0 hαu 2
    rw [hTk]
    constructor
    · linarith
    · linarith
  exact ⟨mem_hcUpTri_iff.2 fun k => (key k).2, fun k => (key k).1⟩

/-- The up triangle is compact. -/
theorem isCompact_hcUpTri (m n : ℤ) : IsCompact (hcUpTri m n) := by
  unfold hcUpTri
  exact Set.Finite.isCompact_convexHull (𝕜 := ℝ) (Set.Finite.insert _ (Set.Finite.insert _ (Set.finite_singleton _)))

/-- `U` is compact (closed inside the up triangle; `g` is continuous). -/
theorem isCompact_hcUp {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) : IsCompact (hcUp g m n) := by
  have hgc : Continuous g := hg.1.continuous
  refine (isCompact_hcUpTri m n).of_isClosed_subset ?_ fun z hz => hz.1
  have : hcUp g m n = hcUpTri m n ∩ ⋂ k : Fin 3, {z | 2 + g (hcFrameS m n k z) ≤ hcFrameT m n k z} := by
    ext z; simp [hcUp]
  rw [this]
  exact (isCompact_hcUpTri m n).isClosed.inter (isClosed_iInter fun k =>
    isClosed_le (continuous_const.add (hgc.comp (continuous_hcFrameS m n k))) (continuous_hcFrameT m n k))

/-- Every point of `U` has `t ≥ 2 + g(s) ≥ 2` and `|s| ≤ 1/2` in each edge frame. -/
theorem hcUp_frame {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {u : ℂ} (hu : u ∈ hcUp g m n) (j : Fin 3) :
    hcFrameS m n j u ∈ Icc (-1 / 2 : ℝ) (1 / 2) ∧ 2 + g (hcFrameS m n j u) ≤ hcFrameT m n j u ∧ 2 ≤ hcFrameT m n j u := by
  obtain ⟨h1, -, -⟩ := hcUpTri_frame hu.1 j
  have hS : hcFrameS m n j u ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le (hcFrameS m n j u)],
    by linarith [le_abs_self (hcFrameS m n j u)]⟩
  have := (hg.2.1 _ hS).1
  exact ⟨hS, hu.2 j, by linarith [hu.2 j]⟩

/-- `U` is nonempty: it holds the point `(0, 2 + g 0)` of every frame. -/
theorem hcUp_nonempty {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) : (hcUp g m n).Nonempty :=
  ⟨_, hcUp_slivers hZc hZs hZi hl hr hg m n 0 (s := 0) ⟨by norm_num, by norm_num⟩⟩

/-- Below `t = 2` the distance to `U` is at least `2 − t`. -/
theorem sub_le_infDist_hcUp {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} (hne : (hcUp g m n).Nonempty)
    (j : Fin 3) (s t : ℝ) : 2 - t ≤ infDist (hcFrame m n j s t) (hcUp g m n) := by
  refine (le_infDist hne).2 fun u hu => ?_
  have h := abs_sub_hcFrameT_le m n j u (hcFrame m n j s t)
  rw [(hcFrame_coords m n j s t).2, dist_comm] at h
  linarith [(hcUp_frame hg hu j).2.2, le_abs_self (hcFrameT m n j u - t)]

/-- On the vertical line of `s`, below `t = 2`, a lower point is farther from every point of `U`. -/
theorem dist_hcUp_le_of_le {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {u : ℂ} (hu : u ∈ hcUp g m n)
    (j : Fin 3) (s : ℝ) {t₁ t₂ : ℝ} (h12 : t₁ ≤ t₂) (h2 : t₂ ≤ 2) :
    dist (hcFrame m n j s t₂) u ≤ dist (hcFrame m n j s t₁) u := by
  have hT := (hcUp_frame hg hu j).2.2
  rw [dist_eq_hcFrame m n j, dist_eq_hcFrame m n j, (hcFrame_coords m n j s t₁).1, (hcFrame_coords m n j s t₁).2,
    (hcFrame_coords m n j s t₂).1, (hcFrame_coords m n j s t₂).2]
  exact Real.sqrt_le_sqrt (by nlinarith)

/-- The same, strictly. -/
theorem dist_hcUp_lt_of_lt {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {u : ℂ} (hu : u ∈ hcUp g m n)
    (j : Fin 3) (s : ℝ) {t₁ t₂ : ℝ} (h12 : t₁ < t₂) (h2 : t₂ ≤ 2) :
    dist (hcFrame m n j s t₂) u < dist (hcFrame m n j s t₁) u := by
  have hT := (hcUp_frame hg hu j).2.2
  rw [dist_eq_hcFrame m n j, dist_eq_hcFrame m n j, (hcFrame_coords m n j s t₁).1, (hcFrame_coords m n j s t₁).2,
    (hcFrame_coords m n j s t₂).1, (hcFrame_coords m n j s t₂).2]
  exact Real.sqrt_lt_sqrt (by positivity) (by nlinarith)

/-- `d_U` is antitone in `t` below `2`. -/
theorem infDist_hcUp_antitone {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} (hne : (hcUp g m n).Nonempty)
    (j : Fin 3) (s : ℝ) {t₁ t₂ : ℝ} (h12 : t₁ ≤ t₂) (h2 : t₂ ≤ 2) :
    infDist (hcFrame m n j s t₂) (hcUp g m n) ≤ infDist (hcFrame m n j s t₁) (hcUp g m n) :=
  (le_infDist hne).2 fun _ hu => (infDist_le_dist_of_mem hu).trans (dist_hcUp_le_of_le hg hu j s h12 h2)

/-- `d_U` is strictly decreasing in `t` below `2`. -/
theorem infDist_hcUp_strictAnti {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} (hne : (hcUp g m n).Nonempty)
    (j : Fin 3) (s : ℝ) {t₁ t₂ : ℝ} (h12 : t₁ < t₂) (h2 : t₂ ≤ 2) :
    infDist (hcFrame m n j s t₂) (hcUp g m n) < infDist (hcFrame m n j s t₁) (hcUp g m n) := by
  obtain ⟨u, hu, hd⟩ := (isCompact_hcUp hg m n).exists_infDist_eq_dist hne (hcFrame m n j s t₁)
  rw [hd]
  exact (infDist_le_dist_of_mem hu).trans_lt (dist_hcUp_lt_of_lt hg hu j s h12 h2)

/-- The set `{t : d_U(s, t) ≤ 1}` whose infimum is `ℓ(s)`: closed, bounded below by `1`, holding `1 + g(s)`. -/
theorem hcBandTop_set {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ}
    (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) :
    IsClosed {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1} ∧ 1 + g s ∈ {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1} ∧
      ∀ t ∈ {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1}, 1 ≤ t := by
  have hne := hcUp_nonempty hZc hZs hZi hl hr hg m n
  refine ⟨isClosed_le ((continuous_infDist_pt _).comp (continuous_hcFrame_t m n j s)) continuous_const,
    ?_, fun t ht => ?_⟩
  · refine (infDist_le_dist_of_mem (hcUp_slivers hZc hZs hZi hl hr hg m n j hs)).trans (le_of_eq ?_)
    rw [dist_hcFrame, show 1 + g s - (2 + g s) = -1 by ring]; simp
  · by_contra h
    have := sub_le_infDist_hcUp hg hne j s t
    simp only [mem_setOf_eq] at ht
    linarith

/-- `ℓ(s)` lies in its set: `d_U(s, ℓ(s)) ≤ 1`, and `1 ≤ ℓ(s) ≤ 1 + g(s)`. -/
theorem hcBandTop_spec {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ}
    (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) :
    infDist (hcFrame m n j s (hcBandTop g m n j s)) (hcUp g m n) ≤ 1 ∧ 1 ≤ hcBandTop g m n j s ∧
      hcBandTop g m n j s ≤ 1 + g s := by
  obtain ⟨hcl, hmem, hlow⟩ := hcBandTop_set hZc hZs hZi hl hr hg m n j hs
  have hbdd : BddBelow {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1} := ⟨1, hlow⟩
  exact ⟨hcl.csInf_mem ⟨_, hmem⟩ hbdd, le_csInf ⟨_, hmem⟩ hlow, csInf_le hbdd hmem⟩

/-- **(G3)**, bounds: `1 ≤ ℓ ≤ 1 + g`, and `ℓ(s) = 1` iff `s ∈ Z`. -/
theorem hcBandTop_bounds {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) :
    1 ≤ hcBandTop g m n j s ∧ hcBandTop g m n j s ≤ 1 + g s ∧ (hcBandTop g m n j s = 1 ↔ s ∈ Z) := by
  obtain ⟨hin, h1, hg1⟩ := hcBandTop_spec hZc hZs hZi hl hr hg m n j hs
  refine ⟨h1, hg1, ⟨fun heq => ?_, fun hsZ => ?_⟩⟩
  · by_contra hsZ
    have hpos := hg.2.2.1 s hs hsZ
    rw [heq] at hin
    obtain ⟨u, hu, hd⟩ := (isCompact_hcUp hg m n).exists_infDist_eq_dist (hcUp_nonempty hZc hZs hZi hl hr hg m n)
      (hcFrame m n j s 1)
    rw [hd, dist_eq_hcFrame m n j, (hcFrame_coords m n j s 1).1, (hcFrame_coords m n j s 1).2] at hin
    obtain ⟨hS, hT, hT2⟩ := hcUp_frame hg hu j
    have hsq : (s - hcFrameS m n j u) ^ 2 + (1 - hcFrameT m n j u) ^ 2 ≤ 1 := by
      have := Real.sqrt_le_one.mp hin
      nlinarith [Real.sq_sqrt (show 0 ≤ (s - hcFrameS m n j u) ^ 2 + (1 - hcFrameT m n j u) ^ 2 by positivity)]
    have hTu : hcFrameT m n j u ≤ 2 := by nlinarith [sq_nonneg (s - hcFrameS m n j u)]
    have hSu : hcFrameS m n j u = s := by nlinarith [sq_nonneg (s - hcFrameS m n j u)]
    rw [hSu] at hT
    linarith
  · have hg0 : g s = 0 := by
      have h := (hg.2.1 s hs)
      rw [infDist_zero_of_mem hsZ] at h
      linarith [h.1, h.2.1]
    rw [hg0] at hg1
    linarith

/-- **(G3)**, the band below `t = 2` is exactly where `d_U > 1` (`d_U` strictly decreasing in `t` there). -/
theorem lt_hcBandTop_iff {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s t : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) (ht : t < 2) :
    t < hcBandTop g m n j s ↔ 1 < infDist (hcFrame m n j s t) (hcUp g m n) := by
  obtain ⟨hcl, hmem, hlow⟩ := hcBandTop_set hZc hZs hZi hl hr hg m n j hs
  have hbdd : BddBelow {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1} := ⟨1, hlow⟩
  obtain ⟨hin, -, -⟩ := hcBandTop_spec hZc hZs hZi hl hr hg m n j hs
  constructor
  · intro h
    by_contra h'
    exact absurd (csInf_le hbdd (show t ∈ {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1} from not_lt.1 h'))
      (not_le.2 h)
  · intro h
    by_contra h'
    have := infDist_hcUp_antitone hg (hcUp_nonempty hZc hZs hZi hl hr hg m n) j s (not_lt.1 h') ht.le
    linarith

/-- **(G3)**, continuity of `ℓ`. -/
theorem continuousOn_hcBandTop {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    ContinuousOn (hcBandTop g m n j) (Icc (-1 / 2 : ℝ) (1 / 2)) := by
  have hne := hcUp_nonempty hZc hZs hZi hl hr hg m n
  set d : ℝ → ℝ → ℝ := fun s t => infDist (hcFrame m n j s t) (hcUp g m n) with hd
  -- `d` is `1`-Lipschitz in `s`
  have hlip : ∀ s s' t, |d s t - d s' t| ≤ |s - s'| := by
    intro s s' t
    have h : dist (hcFrame m n j s t) (hcFrame m n j s' t) = |s - s'| := by
      rw [dist_hcFrame]; simp [Real.sqrt_sq_eq_abs]
    rw [abs_le]; constructor
    · have := infDist_le_infDist_add_dist (x := hcFrame m n j s' t) (y := hcFrame m n j s t) (s := hcUp g m n)
      rw [dist_comm, h] at this; simp only [hd]; linarith
    · have := infDist_le_infDist_add_dist (x := hcFrame m n j s t) (y := hcFrame m n j s' t) (s := hcUp g m n)
      rw [h] at this; simp only [hd]; linarith
  intro s₀ hs₀
  rw [Metric.continuousWithinAt_iff]
  intro ε hε
  obtain ⟨hin₀, h1₀, hg₀⟩ := hcBandTop_spec hZc hZs hZi hl hr hg m n j hs₀
  have hg64 := (hg.2.1 s₀ hs₀).2.2.2.1
  set ℓ₀ := hcBandTop g m n j s₀
  set ε' := min ε (1 / 2) / 2 with hε'
  have hε'0 : 0 < ε' := by positivity
  have hε'1 : ε' < ε := by rw [hε']; linarith [min_le_left ε (1 / 2)]
  have hε'2 : ε' ≤ 1 / 4 := by rw [hε']; linarith [min_le_right ε (1 / 2)]
  have hlo : 1 < d s₀ (ℓ₀ - ε') :=
    (lt_hcBandTop_iff hZc hZs hZi hl hr hg m n j hs₀ (by linarith)).1 (by linarith)
  have hhi : d s₀ (ℓ₀ + ε') < 1 :=
    (infDist_hcUp_strictAnti hg hne j s₀ (by linarith : ℓ₀ < ℓ₀ + ε') (by linarith)).trans_le hin₀
  refine ⟨min (d s₀ (ℓ₀ - ε') - 1) (1 - d s₀ (ℓ₀ + ε')), lt_min (by linarith) (by linarith), fun s hs hss => ?_⟩
  rw [Real.dist_eq] at hss ⊢
  have hδ1 := (lt_min_iff.1 hss).1
  have hδ2 := (lt_min_iff.1 hss).2
  have a1 := hlip s s₀ (ℓ₀ - ε')
  have a2 := hlip s s₀ (ℓ₀ + ε')
  have hlo' : 1 < d s (ℓ₀ - ε') := by rw [abs_le] at a1; linarith [a1.1]
  have hhi' : d s (ℓ₀ + ε') < 1 := by rw [abs_le] at a2; linarith [a2.2]
  obtain ⟨-, hlow⟩ := (hcBandTop_set hZc hZs hZi hl hr hg m n j hs).2
  have hup : hcBandTop g m n j s ≤ ℓ₀ + ε' := csInf_le ⟨1, hlow⟩ (show ℓ₀ + ε' ∈ {t | d s t ≤ 1} from hhi'.le)
  have hdown : ℓ₀ - ε' < hcBandTop g m n j s :=
    (lt_hcBandTop_iff hZc hZs hZi hl hr hg m n j hs (by linarith)).2 hlo'
  rw [abs_lt]; constructor <;> linarith

/-- `ω = e(π/3)` satisfies `ω² = ω − 1`. -/
theorem e_pi_div_three_sq : e (π / 3) ^ 2 = e (π / 3) - 1 := by
  have hs : √3 * √3 = (3 : ℝ) := Real.mul_self_sqrt (by norm_num)
  rw [e_pi_div_three]
  apply Complex.ext <;> simp [sq] <;> nlinarith [hs]

/-- The edge directions in terms of `ω = e(π/3)`: `w₀ = 1`, `w₁ = ω − 1`, `w₂ = −ω`. -/
theorem hc_w_omega :
    e (2 * π * (((0 : Fin 3) : ℕ) : ℝ) / 3) = 1 ∧ e (2 * π * (((1 : Fin 3) : ℕ) : ℝ) / 3) = e (π / 3) - 1 ∧
      e (2 * π * (((2 : Fin 3) : ℕ) : ℝ) / 3) = -e (π / 3) := by
  refine ⟨by rw [hc_w_explicit]; simp, ?_, ?_⟩
  · rw [hc_w_explicit, e_pi_div_three]; simp; ring
  · rw [hc_w_explicit, e_pi_div_three]; simp; ring

/-- The face centres on the lattice `(L/2)·tri`: `face(m, n) = (L/2)·tri(2(m − n), 2(m + 2n))`. -/
theorem hcFace_eq_tri (m n : ℤ) : hcFace m n = ((hcL / 2 : ℝ) : ℂ) * tri (2 * (m - n)) (2 * (m + 2 * n)) := by
  have hω := e_pi_div_three_sq
  have h6 : ((hcL * √3 : ℝ) : ℂ) * e (π / 6) = (hcL : ℂ) * (1 + e (π / 3)) := by
    have hs : √3 * √3 = (3 : ℝ) := Real.mul_self_sqrt (by norm_num)
    rw [e_eq, e_pi_div_three, Real.cos_pi_div_six, Real.sin_pi_div_six]
    apply Complex.ext
    · simp; linear_combination (hcL / 2) * hs
    · simp; ring
  rw [hcFace, h6, tri, tri]
  push_cast
  linear_combination (hcL : ℂ) * n * hω

/-- HC's blocks, cell by cell: `0` the down triangle, `1` the cut up triangle, `2, 3, 4` the closed bands of the three edges,
`5` the face disc. -/
def hcBlock (g : ℝ → ℝ) (m n : ℤ) (k : Fin 6) : Set ℂ :=
  ![hcDownTri m n, hcUp g m n, closure (hcBand g m n 0), closure (hcBand g m n 1), closure (hcBand g m n 2),
    closedBall (hcFace m n) (1 / 2)] k

example (g : ℝ → ℝ) : hcBlock g 0 0 5 = closedBall (hcFace 0 0) (1 / 2) ∧ hcBlock g 0 0 1 = hcUp g 0 0 := ⟨rfl, rfl⟩

/-- HC is the union of its blocks. -/
theorem hcSet_eq_iUnion (g : ℝ → ℝ) : hcSet g = ⋃ p : ℤ × ℤ × Fin 6, hcBlock g p.1 p.2.1 p.2.2 := by
  ext z
  simp only [hcSet, mem_union, mem_iUnion, Prod.exists]
  constructor
  · rintro (((⟨m, n, h⟩ | ⟨m, n, h⟩) | ⟨m, n, j, h⟩) | ⟨m, n, h⟩)
    · exact ⟨m, n, 0, h⟩
    · exact ⟨m, n, 1, h⟩
    · fin_cases j
      · exact ⟨m, n, 2, h⟩
      · exact ⟨m, n, 3, h⟩
      · exact ⟨m, n, 4, h⟩
    · exact ⟨m, n, 5, h⟩
  · rintro ⟨m, n, k, h⟩
    fin_cases k
    · exact Or.inl (Or.inl (Or.inl ⟨m, n, h⟩))
    · exact Or.inl (Or.inl (Or.inr ⟨m, n, h⟩))
    · exact Or.inl (Or.inr ⟨m, n, 0, h⟩)
    · exact Or.inl (Or.inr ⟨m, n, 1, h⟩)
    · exact Or.inl (Or.inr ⟨m, n, 2, h⟩)
    · exact Or.inr ⟨m, n, h⟩

/-- The blocks' centres in lattice coordinates (units of `L/2`): first coordinate. -/
def hcCA (m n : ℤ) (k : Fin 6) : ℤ := 2 * (m - n) + ![0, 2, 3, 1, 2, 0] k

/-- The blocks' centres in lattice coordinates (units of `L/2`): second coordinate. -/
def hcCB (m n : ℤ) (k : Fin 6) : ℤ := 2 * (m + 2 * n) + ![2, 0, 0, 1, -1, 0] k

example : hcCA 1 0 2 = 5 ∧ hcCB 0 1 4 = 3 ∧ hcCA 0 0 5 = 0 := by decide

/-- A block's centre: the centroid, the edge midpoint, or the face centre. -/
noncomputable def hcCentre (m n : ℤ) (k : Fin 6) : ℂ := ((hcL / 2 : ℝ) : ℂ) * tri (hcCA m n k) (hcCB m n k)

example : hcCentre 0 0 5 = 0 := by simp [hcCentre, hcCA, hcCB, tri]

/-- The centres, kind by kind. -/
theorem hcCentre_eq (m n : ℤ) :
    hcCentre m n 0 = hcDownC m n ∧ hcCentre m n 1 = hcUpC m n ∧ hcCentre m n 2 = hcFrame m n 0 0 1 ∧
      hcCentre m n 3 = hcFrame m n 1 0 1 ∧ hcCentre m n 4 = hcFrame m n 2 0 1 ∧ hcCentre m n 5 = hcFace m n := by
  obtain ⟨w0, w1, w2⟩ := hc_w_omega
  have hL2 : hcL - √3 / 6 - 1 = hcL / 2 := by unfold hcL; ring
  have hF := hcFace_eq_tri m n
  simp only [hcCentre, hcCA, hcCB, hcDownC, hcUpC, hcFrame, hF, tri, hL2]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> (try simp only [w0, w1, w2]) <;> push_cast <;> (try simp) <;> ring

/-- The integer points with `a² + ab + b² < 3`: the origin and the six units. -/
theorem int_triQ_lt_three {a b : ℤ} (h : a ^ 2 + a * b + b ^ 2 < 3) :
    (a = 0 ∧ b = 0) ∨ (a = 1 ∧ b = 0) ∨ (a = -1 ∧ b = 0) ∨ (a = 0 ∧ b = 1) ∨ (a = 0 ∧ b = -1) ∨ (a = 1 ∧ b = -1) ∨
      (a = -1 ∧ b = 1) := by
  have hb1 : b ≤ 1 := by nlinarith [sq_nonneg (2 * a + b)]
  have hb2 : -1 ≤ b := by nlinarith [sq_nonneg (2 * a + b)]
  have ha1 : a ≤ 1 := by nlinarith [sq_nonneg (2 * b + a)]
  have ha2 : -1 ≤ a := by nlinarith [sq_nonneg (2 * b + a)]
  interval_cases a <;> interval_cases b <;> simp_all

/-- The flanking pairs: an up triangle with its own three bands, and a band with the down triangle across its edge. -/
def hcFlank (m n : ℤ) (k : Fin 6) (m' n' : ℤ) (k' : Fin 6) : Prop :=
  (k = 1 ∧ m' = m ∧ n' = n ∧ (k' = 2 ∨ k' = 3 ∨ k' = 4)) ∨
    (k = 0 ∧ ((k' = 2 ∧ m = m' + 1 ∧ n = n' - 1) ∨ (k' = 3 ∧ m = m' ∧ n = n') ∨ (k' = 4 ∧ m = m' ∧ n = n' - 1)))

example : hcFlank 0 0 1 0 0 2 ∧ hcFlank 1 (-1) 0 0 0 2 ∧ ¬ hcFlank 0 0 5 0 0 2 := by unfold hcFlank; decide

/-- Two blocks whose centres are nearer than `(L/2)√3` are one block or a flanking pair. -/
theorem hcC_near {m n m' n' : ℤ} {k k' : Fin 6}
    (h : (hcCA m n k - hcCA m' n' k') ^ 2 + (hcCA m n k - hcCA m' n' k') * (hcCB m n k - hcCB m' n' k') +
      (hcCB m n k - hcCB m' n' k') ^ 2 < 3) :
    (m = m' ∧ n = n' ∧ k = k') ∨ hcFlank m n k m' n' k' ∨ hcFlank m' n' k' m n k := by
  have h7 := int_triQ_lt_three h
  fin_cases k <;> fin_cases k' <;> simp [hcCA, hcCB, hcFlank] at h7 ⊢ <;> omega

/-- The cell of the down triangle across edge `j` of the up triangle `(m, n)`. -/
def hcDn (m n : ℤ) (j : Fin 3) : ℤ × ℤ := ![(m + 1, n - 1), (m, n), (m, n - 1)] j

example : hcDn 0 0 0 = (1, -1) ∧ hcDn 0 0 1 = (0, 0) ∧ hcDn 0 0 2 = (0, -1) := by decide

/-- The down centroid across edge `j` is `C + L w_j`. -/
theorem hcDownC_dn (m n : ℤ) (j : Fin 3) :
    hcDownC (hcDn m n j).1 (hcDn m n j).2 = hcUpC m n + hcL * e (2 * π * ((j : ℕ) : ℝ) / 3) := by
  obtain ⟨w0, w1, w2⟩ := hc_w_omega
  have hw : e (2 * π * ((j : ℕ) : ℝ) / 3) = ![1, e (π / 3) - 1, -e (π / 3)] j := by
    fin_cases j
    · exact w0
    · exact w1
    · exact w2
  rw [hw]
  fin_cases j <;> simp only [hcDn, hcDownC, hcUpC, hcFace_eq_tri, tri, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk,
    Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val] <;> push_cast <;> ring

/-- The down triangle is the point reflection of the up triangle of its cell through the midpoint of their centroids. -/
theorem mem_hcDownTri_iff {a b : ℤ} {z : ℂ} : z ∈ hcDownTri a b ↔ hcUpC a b + hcDownC a b - z ∈ hcUpTri a b := by
  have e5 : e (5 * π / 3) = -e (2 * π / 3) := by
    rw [show 5 * π / 3 = 2 * π / 3 + π by ring, e_add, show e π = -1 by rw [e_eq, Real.cos_pi, Real.sin_pi]; simp]; ring
  have e4 : e (4 * π / 3) = -e (π / 3) := by
    rw [show 4 * π / 3 = π / 3 + π by ring, e_add, show e π = -1 by rw [e_eq, Real.cos_pi, Real.sin_pi]; simp]; ring
  have epi : e π = -e 0 := by rw [e_eq, e_eq, Real.cos_pi, Real.sin_pi, Real.cos_zero, Real.sin_zero]; simp
  set C := hcUpC a b
  set D := hcDownC a b
  have hconv : ∀ T : Set ℂ, Convex ℝ T → Convex ℝ {z | C + D - z ∈ T} := by
    intro T hT x hx y hy u v hu hv huv
    have huv' : (u : ℂ) + v = 1 := by exact_mod_cast huv
    have h : C + D - (u • x + v • y) = u • (C + D - x) + v • (C + D - y) := by
      simp only [Complex.real_smul]; linear_combination (-(C + D)) * huv'
    simp only [mem_setOf_eq, h]
    exact hT hx hy hu hv huv
  have hdown : ∀ w ∈ hcUpTri a b, C + D - w ∈ hcDownTri a b := by
    intro w hw
    refine convexHull_min (t := {w | C + D - w ∈ hcDownTri a b}) ?_ (hconv _ (convex_convexHull ℝ _)) hw
    intro v hv
    simp only [mem_insert_iff, mem_singleton_iff] at hv
    simp only [mem_setOf_eq, hcDownTri]
    rcases hv with rfl | rfl | rfl
    · rw [show C + D - (C + e (π / 3) / √3) = D + e (4 * π / 3) / √3 by rw [e4]; ring]
      exact subset_convexHull ℝ _ (by simp [D])
    · rw [show C + D - (C + e π / √3) = D + e 0 / √3 by rw [epi]; ring]
      exact subset_convexHull ℝ _ (by simp [D])
    · rw [show C + D - (C + e (5 * π / 3) / √3) = D + e (2 * π / 3) / √3 by rw [e5]; ring]
      exact subset_convexHull ℝ _ (by simp [D])
  constructor
  · intro hz
    refine convexHull_min (t := {z | C + D - z ∈ hcUpTri a b}) ?_ (hconv _ (convex_convexHull ℝ _)) hz
    intro v hv
    simp only [mem_insert_iff, mem_singleton_iff] at hv
    simp only [mem_setOf_eq, hcUpTri]
    rcases hv with rfl | rfl | rfl
    · rw [show C + D - (D + e 0 / √3) = C + e π / √3 by rw [epi]; ring]
      exact subset_convexHull ℝ _ (by simp [C])
    · rw [show C + D - (D + e (2 * π / 3) / √3) = C + e (5 * π / 3) / √3 by rw [e5]; ring]
      exact subset_convexHull ℝ _ (by simp [C])
    · rw [show C + D - (D + e (4 * π / 3) / √3) = C + e (π / 3) / √3 by rw [e4]; ring]
      exact subset_convexHull ℝ _ (by simp [C])
  · intro hz
    have := hdown _ hz
    rwa [show C + D - (C + D - z) = z by ring] at this

/-- The frame of edge `j` read through the reflection: `t = 2 − t′`, `s = −s′` in the frame of the down cell's up triangle. -/
theorem hcFrame_dn (m n : ℤ) (j : Fin 3) (z : ℂ) :
    hcFrameT m n j z = 2 - hcFrameT (hcDn m n j).1 (hcDn m n j).2 j
        (hcUpC (hcDn m n j).1 (hcDn m n j).2 + hcDownC (hcDn m n j).1 (hcDn m n j).2 - z) ∧
      hcFrameS m n j z = -hcFrameS (hcDn m n j).1 (hcDn m n j).2 j
        (hcUpC (hcDn m n j).1 (hcDn m n j).2 + hcDownC (hcDn m n j).1 (hcDn m n j).2 - z) := by
  have hw : e (2 * π * ((j : ℕ) : ℝ) / 3) ≠ 0 := by
    intro h; have := norm_e (2 * π * ((j : ℕ) : ℝ) / 3); rw [h, norm_zero] at this; norm_num at this
  have hD := hcDownC_dn m n j
  have hq : (hcUpC (hcDn m n j).1 (hcDn m n j).2 + hcDownC (hcDn m n j).1 (hcDn m n j).2 - z -
      hcUpC (hcDn m n j).1 (hcDn m n j).2) / e (2 * π * ((j : ℕ) : ℝ) / 3) =
      (hcL : ℂ) - (z - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) := by
    rw [hD]; field_simp; ring
  have hL : hcL - √3 / 6 + (hcL - √3 / 6) - hcL = 2 := by unfold hcL; ring
  constructor
  · simp only [hcFrameT]; rw [hq]; simp; linarith
  · simp only [hcFrameS]; rw [hq]; simp

/-- The up triangle lies within `1/√3` of its centroid. -/
theorem hcUpTri_subset_ball (m n : ℤ) : hcUpTri m n ⊆ closedBall (hcUpC m n) (1 / √3) := by
  refine convexHull_min ?_ (convex_closedBall _ _)
  intro v hv
  simp only [mem_insert_iff, mem_singleton_iff] at hv
  rcases hv with rfl | rfl | rfl <;>
    simp [dist_eq_norm, Complex.norm_real, abs_of_pos (Real.sqrt_pos.2 (show (0 : ℝ) < 3 by norm_num))]

/-- The down triangle lies within `1/√3` of its centroid. -/
theorem hcDownTri_subset_ball (m n : ℤ) : hcDownTri m n ⊆ closedBall (hcDownC m n) (1 / √3) := by
  refine convexHull_min ?_ (convex_closedBall _ _)
  intro v hv
  simp only [mem_insert_iff, mem_singleton_iff] at hv
  rcases hv with rfl | rfl | rfl <;>
    simp [dist_eq_norm, Complex.norm_real, abs_of_pos (Real.sqrt_pos.2 (show (0 : ℝ) < 3 by norm_num))]

/-- `1/√3 ≤ 3/5`. -/
theorem one_div_sqrt_three_le : 1 / √3 ≤ (3 / 5 : ℝ) := by
  rw [div_le_iff₀ (Real.sqrt_pos.2 (by norm_num))]
  nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num), Real.sqrt_nonneg 3]

/-- A closed band lies within `3/5` of its edge's midpoint. -/
theorem closure_hcBand_subset_ball {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    closure (hcBand g m n j) ⊆ closedBall (hcFrame m n j 0 1) (3 / 5) := by
  refine closure_minimal ?_ isClosed_closedBall
  rintro _ ⟨s, t, hs, ht, ht', rfl⟩
  have hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
  have hb := (hcBandTop_bounds hZc hZs hZi hl hr hg m n j hsI).2.1
  have hg64 := (hg.2.1 s hsI).2.2.2.1
  rw [mem_closedBall, dist_hcFrame, Real.sqrt_le_left (by norm_num)]
  have : s ^ 2 ≤ 1 / 4 := by nlinarith [abs_nonneg s, sq_abs s]
  nlinarith

/-- Every block lies within `3/5` of its centre. -/
theorem hcBlock_subset_ball {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (k : Fin 6) :
    hcBlock g m n k ⊆ closedBall (hcCentre m n k) (3 / 5) := by
  obtain ⟨c0, c1, c2, c3, c4, c5⟩ := hcCentre_eq m n
  have h35 := one_div_sqrt_three_le
  fin_cases k <;> simp only [hcBlock, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val, Fin.isValue]
  · rw [c0]; exact (hcDownTri_subset_ball m n).trans (closedBall_subset_closedBall h35)
  · rw [c1]; exact fun z hz => closedBall_subset_closedBall h35 (hcUpTri_subset_ball m n hz.1)
  · rw [c2]; exact closure_hcBand_subset_ball hZc hZs hZi hl hr hg m n 0
  · rw [c3]; exact closure_hcBand_subset_ball hZc hZs hZi hl hr hg m n 1
  · rw [c4]; exact closure_hcBand_subset_ball hZc hZs hZi hl hr hg m n 2
  · rw [c5]; exact closedBall_subset_closedBall (by norm_num)

/-- A closed band lies on the far side `t ≥ 1` of its segment. -/
theorem one_le_hcFrameT_of_mem_closure_band {g : ℝ → ℝ} {m n : ℤ} {j : Fin 3} {q : ℂ} (hq : q ∈ closure (hcBand g m n j)) :
    1 ≤ hcFrameT m n j q := by
  refine closure_minimal (s := hcBand g m n j) (t := {q | 1 ≤ hcFrameT m n j q}) ?_
    (isClosed_le continuous_const (continuous_hcFrameT m n j)) hq
  rintro _ ⟨s, t, -, ht, -, rfl⟩
  simp only [mem_setOf_eq, (hcFrame_coords m n j s t).2]; exact ht.le

/-- **A flanking pair, up**: `U` and each of its own closed bands are `1` apart. -/
theorem one_le_dist_hcUp_band {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {j : Fin 3} {u q : ℂ}
    (hu : u ∈ hcUp g m n) (hq : q ∈ closure (hcBand g m n j)) : 1 ≤ dist u q := by
  have hsub : hcBand g m n j ⊆ {q | 1 ≤ infDist q (hcUp g m n)} := by
    rintro _ ⟨s, t, hs, ht, ht', rfl⟩
    have hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
    have hb := (hcBandTop_bounds hZc hZs hZi hl hr hg m n j hsI).2.1
    have hg64 := (hg.2.1 s hsI).2.2.2.1
    exact ((lt_hcBandTop_iff hZc hZs hZi hl hr hg m n j hsI (by linarith)).1 ht').le
  have := closure_minimal hsub (isClosed_le continuous_const (continuous_infDist_pt _)) hq
  rw [dist_comm]
  exact this.trans (infDist_le_dist_of_mem hu)

/-- **A flanking pair, down**: the down triangle across an edge lies in `t ≤ 0` of its frame, so it is `1` from the closed band. -/
theorem one_le_dist_hcDown_band {g : ℝ → ℝ} {m n : ℤ} {j : Fin 3} {z q : ℂ}
    (hz : z ∈ hcDownTri (hcDn m n j).1 (hcDn m n j).2) (hq : q ∈ closure (hcBand g m n j)) : 1 ≤ dist z q := by
  have hT : hcFrameT m n j z ≤ 0 := by
    rw [(hcFrame_dn m n j z).1]
    have := (hcUpTri_frame (mem_hcDownTri_iff.1 hz) j).2.1
    linarith
  have h1 := one_le_hcFrameT_of_mem_closure_band hq
  have := abs_sub_hcFrameT_le m n j q z
  rw [dist_comm]
  linarith [le_abs_self (hcFrameT m n j q - hcFrameT m n j z)]

/-- A flanking pair of blocks is `1` apart. -/
theorem hcFlank_sep {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n m' n' : ℤ} {k k' : Fin 6}
    (hfl : hcFlank m n k m' n' k') {p q : ℂ} (hp : p ∈ hcBlock g m n k) (hq : q ∈ hcBlock g m' n' k') : 1 ≤ dist p q := by
  rcases hfl with ⟨rfl, rfl, rfl, hk'⟩ | ⟨rfl, hk'⟩
  · rcases hk' with rfl | rfl | rfl
    · exact one_le_dist_hcUp_band hZc hZs hZi hl hr hg (j := 0) hp hq
    · exact one_le_dist_hcUp_band hZc hZs hZi hl hr hg (j := 1) hp hq
    · exact one_le_dist_hcUp_band hZc hZs hZi hl hr hg (j := 2) hp hq
  · rcases hk' with ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩
    · exact one_le_dist_hcDown_band (m := m') (n := n') (j := 0) hp hq
    · exact one_le_dist_hcDown_band (m := m) (n := n) (j := 1) hp hq
    · exact one_le_dist_hcDown_band (m := m) (n := n') (j := 2) hp hq

/-- **Distinct blocks are at distance at least `1`** (the block-distance table: far centres by the lattice, the flanking pairs
by the frames). -/
theorem hcBlock_sep {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n m' n' : ℤ} {k k' : Fin 6}
    (hne : ¬ (m = m' ∧ n = n' ∧ k = k')) {p q : ℂ} (hp : p ∈ hcBlock g m n k) (hq : q ∈ hcBlock g m' n' k') :
    1 ≤ dist p q := by
  by_cases hQ : (hcCA m n k - hcCA m' n' k') ^ 2 + (hcCA m n k - hcCA m' n' k') * (hcCB m n k - hcCB m' n' k') +
      (hcCB m n k - hcCB m' n' k') ^ 2 < 3
  · rcases hcC_near hQ with heq | hfl | hfl
    · exact absurd heq hne
    · exact hcFlank_sep hZc hZs hZi hl hr hg hfl hp hq
    · rw [dist_comm]; exact hcFlank_sep hZc hZs hZi hl hr hg hfl hq hp
  · push Not at hQ
    have hL0 : 0 < hcL / 2 := by unfold hcL; positivity
    have hcc : dist (hcCentre m n k) (hcCentre m' n' k') =
        hcL / 2 * √(triQ ((hcCA m n k : ℝ) - hcCA m' n' k') ((hcCB m n k : ℝ) - hcCB m' n' k')) := by
      rw [hcCentre, hcCentre, dist_eq_norm, ← mul_sub, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hL0,
        ← dist_eq_norm, dist_tri]
    have hQr : (3 : ℝ) ≤ triQ ((hcCA m n k : ℝ) - hcCA m' n' k') ((hcCB m n k : ℝ) - hcCB m' n' k') := by
      have : (((hcCA m n k - hcCA m' n' k') ^ 2 + (hcCA m n k - hcCA m' n' k') * (hcCB m n k - hcCB m' n' k') +
          (hcCB m n k - hcCB m' n' k') ^ 2 : ℤ) : ℝ) =
          triQ ((hcCA m n k : ℝ) - hcCA m' n' k') ((hcCB m n k : ℝ) - hcCB m' n' k') := by
        unfold triQ; push_cast; ring
      rw [← this]; exact_mod_cast hQ
    have hsq := Real.sqrt_le_sqrt hQr
    have hp' := hcBlock_subset_ball hZc hZs hZi hl hr hg m n k hp
    have hq' := hcBlock_subset_ball hZc hZs hZi hl hr hg m' n' k' hq
    rw [mem_closedBall] at hp' hq'
    have htri := dist_triangle4 (hcCentre m n k) p q (hcCentre m' n' k')
    rw [dist_comm (hcCentre m n k) p] at htri
    have h3 : (1.7 : ℝ) ≤ √3 := by nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num), Real.sqrt_nonneg 3]
    have hL : hcL / 2 * √3 = √3 + 1 / 2 := by
      unfold hcL; have := Real.mul_self_sqrt (show (0 : ℝ) ≤ 3 by norm_num); nlinarith
    have : hcL / 2 * √3 ≤ dist (hcCentre m n k) (hcCentre m' n' k') := by
      rw [hcc]; exact mul_le_mul_of_nonneg_left hsq hL0.le
    linarith

/-- **A graph in sheared coordinates is null**: if `φ` moves by `c` and `ψ` stays put under translation by `c • v`, the bounded
pieces of `{φ = f ∘ ψ}` are bounded, and `f` is continuous, then `{φ = f ∘ ψ}` is null (its translates by `v/(k+1)` are
disjoint and lie in one bounded set). -/
theorem volume_graph_eq_zero {φ ψ : ℂ → ℝ} (hφ : Continuous φ) (hψ : Continuous ψ) {v : ℂ}
    (hv : ∀ z : ℂ, ∀ c : ℝ, φ (z + (c : ℂ) * v) = φ z + c ∧ ψ (z + (c : ℂ) * v) = ψ z)
    (hb : ∀ K M : ℝ, Bornology.IsBounded {z | |φ z| ≤ K ∧ |ψ z| ≤ M}) {f : ℝ → ℝ} (hf : Continuous f) :
    volume {z | φ z = f (ψ z)} = 0 := by
  have hG : {z | φ z = f (ψ z)} = ⋃ M : ℕ, {z | φ z = f (ψ z) ∧ |ψ z| ≤ M} := by
    ext z; simp only [mem_setOf_eq, mem_iUnion]
    exact ⟨fun h => ⟨⌈|ψ z|⌉₊, h, Nat.le_ceil _⟩, fun ⟨_, h, _⟩ => h⟩
  rw [hG]
  refine measure_iUnion_null fun M => ?_
  set G := {z | φ z = f (ψ z) ∧ |ψ z| ≤ M} with hGd
  obtain ⟨K, hK⟩ := (isCompact_Icc (a := -(M : ℝ)) (b := M)).exists_bound_of_continuousOn hf.continuousOn
  -- the translates `H c = {z | z - c v ∈ G}`
  set c : ℕ → ℝ := fun k => -(1 / ((k : ℝ) + 1)) with hc
  set H : ℕ → Set ℂ := fun k => (fun z => z + ((c k : ℝ) : ℂ) * v) ⁻¹' G with hH
  have hmemH : ∀ k z, z ∈ H k ↔ φ z - 1 / (k + 1 : ℝ) = f (ψ z) ∧ |ψ z| ≤ M := by
    intro k z
    simp only [hH, mem_preimage, hGd, mem_setOf_eq]
    rw [(hv z (c k)).1, (hv z (c k)).2]
    simp only [hc]
    constructor <;> rintro ⟨h1, h2⟩ <;> exact ⟨by linarith, h2⟩
  have hGm : MeasurableSet G := (isClosed_eq hφ (hf.comp hψ)).inter (isClosed_le (continuous_abs.comp hψ) continuous_const)
    |>.measurableSet
  have hHm : ∀ k, MeasurableSet (H k) := fun k => hGm.preimage (by fun_prop)
  have hHvol : ∀ k, volume (H k) = volume G := fun k => measure_preimage_add_right _ _ _
  have hdisj : Pairwise (Function.onFun Disjoint H) := by
    intro k k' hkk'
    refine Set.disjoint_left.2 fun z hz hz' => hkk' ?_
    rw [hmemH] at hz hz'
    have h : 1 / (k + 1 : ℝ) = 1 / (k' + 1 : ℝ) := by linarith [hz.1, hz'.1]
    have := (div_eq_div_iff (by positivity) (by positivity)).1 h
    exact_mod_cast (by linarith : (k : ℝ) = k')
  have hsub : (⋃ k, H k) ⊆ {z | |φ z| ≤ K + 1 ∧ |ψ z| ≤ M} := by
    intro z hz
    obtain ⟨k, hk⟩ := mem_iUnion.1 hz
    rw [hmemH] at hk
    have hfK := hK (ψ z) ⟨by linarith [neg_abs_le (ψ z), hk.2], by linarith [le_abs_self (ψ z), hk.2]⟩
    have h1 : 0 < 1 / (k + 1 : ℝ) := by positivity
    have h2 : 1 / (k + 1 : ℝ) ≤ 1 := by rw [div_le_one (by positivity)]; linarith [(k.cast_nonneg : (0 : ℝ) ≤ k)]
    refine ⟨?_, hk.2⟩
    rw [Real.norm_eq_abs] at hfK
    rw [abs_le] at hfK ⊢
    constructor <;> linarith [hk.1]
  have hfin : volume (⋃ k, H k) < ⊤ := (measure_mono hsub).trans_lt ((hb (K + 1) M).measure_lt_top)
  rw [measure_iUnion hdisj hHm] at hfin
  simp only [hHvol] at hfin
  by_contra h0
  rw [ENNReal.tsum_const_eq_top_of_ne_zero h0] at hfin
  exact lt_irrefl _ hfin

/-- The lattice offsets of a block's centre from its face: `A − 2(m − n) ∈ [0, 3]`, `B − 2(m + 2n) ∈ [−1, 2]`. -/
theorem hcC_offsets (m n : ℤ) (k : Fin 6) : 0 ≤ hcCA m n k - 2 * (m - n) ∧ hcCA m n k - 2 * (m - n) ≤ 3 ∧
    -1 ≤ hcCB m n k - 2 * (m + 2 * n) ∧ hcCB m n k - 2 * (m + 2 * n) ≤ 2 := by
  fin_cases k <;> simp [hcCA, hcCB]

/-- **HC's blocks form a locally finite family** (the centres lie on a lattice; the blocks have radius `3/5`). -/
theorem hcBlock_locallyFinite {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    LocallyFinite (fun p : ℤ × ℤ × Fin 6 => hcBlock g p.1 p.2.1 p.2.2) := by
  intro z
  refine ⟨ball z 1, ball_mem_nhds z one_pos, ?_⟩
  have hL0 : 0 < hcL / 2 := by unfold hcL; positivity
  have hL1 : 1 ≤ hcL / 2 := by unfold hcL; have := Real.sqrt_nonneg 3; linarith
  set w := z / ((hcL / 2 : ℝ) : ℂ) with hw
  set x := (triCoord w).1
  set y := (triCoord w).2
  refine Set.Finite.subset ((Set.finite_Icc (⌊(2 * x + y) / 6⌋ - 3) (⌈(2 * x + y) / 6⌉ + 3)).prod
    ((Set.finite_Icc (⌊(y - x) / 6⌋ - 3) (⌈(y - x) / 6⌉ + 3)).prod Set.finite_univ)) ?_
  rintro ⟨m, n, k⟩ ⟨q, hq1, hq2⟩
  have hq := hcBlock_subset_ball hZc hZs hZi hl hr hg m n k hq1
  rw [mem_closedBall] at hq
  rw [mem_ball] at hq2
  have hcz : dist (hcCentre m n k) z < 8 / 5 := by
    have := dist_triangle (hcCentre m n k) q z
    rw [dist_comm (hcCentre m n k) q] at this
    linarith
  have hscale : dist (hcCentre m n k) z = hcL / 2 * dist (tri (hcCA m n k) (hcCB m n k)) w := by
    have hne : ((hcL / 2 : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hL0.ne'
    rw [hcCentre, dist_eq_norm, dist_eq_norm, show ((hcL / 2 : ℝ) : ℂ) * tri (hcCA m n k) (hcCB m n k) - z =
      ((hcL / 2 : ℝ) : ℂ) * (tri (hcCA m n k) (hcCB m n k) - w) by rw [hw, mul_sub, mul_div_cancel₀ _ hne],
      norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hL0]
  have hd : dist (tri (hcCA m n k) (hcCB m n k)) w < 8 / 5 := by
    have h0 := dist_nonneg (x := tri (hcCA m n k) (hcCB m n k)) (y := w)
    rw [hscale] at hcz
    nlinarith
  rw [dist_eq_triQ, triCoord_tri] at hd
  have hT : triQ ((hcCA m n k : ℝ) - x) ((hcCB m n k : ℝ) - y) < 64 / 25 := by
    have h := (Real.sqrt_lt' (by norm_num)).1 hd
    nlinarith
  unfold triQ at hT
  have hA : |(hcCA m n k : ℝ) - x| < 2 := by
    rw [abs_lt]; constructor <;> nlinarith [sq_nonneg (2 * ((hcCB m n k : ℝ) - y) + ((hcCA m n k : ℝ) - x))]
  have hB : |(hcCB m n k : ℝ) - y| < 2 := by
    rw [abs_lt]; constructor <;> nlinarith [sq_nonneg (2 * ((hcCA m n k : ℝ) - x) + ((hcCB m n k : ℝ) - y))]
  obtain ⟨o1, o2, o3, o4⟩ := hcC_offsets m n k
  have r1 : (0 : ℝ) ≤ hcCA m n k - 2 * (m - n) := by exact_mod_cast o1
  have r2 : (hcCA m n k : ℝ) - 2 * (m - n) ≤ 3 := by exact_mod_cast o2
  have r3 : (-1 : ℝ) ≤ hcCB m n k - 2 * (m + 2 * n) := by exact_mod_cast o3
  have r4 : (hcCB m n k : ℝ) - 2 * (m + 2 * n) ≤ 2 := by exact_mod_cast o4
  rw [abs_lt] at hA hB
  have hm1 : (2 * x + y) / 6 < m + 3 := by linarith [hA.1, hA.2, hB.1, hB.2]
  have hm2 : (m : ℝ) < (2 * x + y) / 6 + 3 := by linarith [hA.1, hA.2, hB.1, hB.2]
  have hn1 : (y - x) / 6 < n + 3 := by linarith [hA.1, hA.2, hB.1, hB.2]
  have hn2 : (n : ℝ) < (y - x) / 6 + 3 := by linarith [hA.1, hA.2, hB.1, hB.2]
  simp only [Set.mem_prod, Set.mem_Icc, Set.mem_univ, and_true]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · have := Int.floor_le ((2 * x + y) / 6)
    have : ((⌊(2 * x + y) / 6⌋ - 3 : ℤ) : ℝ) < m := by push_cast; linarith
    exact_mod_cast this.le
  · have := Int.le_ceil ((2 * x + y) / 6)
    have : (m : ℝ) < ((⌈(2 * x + y) / 6⌉ + 3 : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast this.le
  · have := Int.floor_le ((y - x) / 6)
    have : ((⌊(y - x) / 6⌋ - 3 : ℤ) : ℝ) < n := by push_cast; linarith
    exact_mod_cast this.le
  · have := Int.le_ceil ((y - x) / 6)
    have : (n : ℝ) < ((⌈(y - x) / 6⌉ + 3 : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast this.le

/-- The down triangle is compact. -/
theorem isCompact_hcDownTri (m n : ℤ) : IsCompact (hcDownTri m n) := by
  unfold hcDownTri
  exact Set.Finite.isCompact_convexHull (𝕜 := ℝ) (Set.Finite.insert _ (Set.Finite.insert _ (Set.finite_singleton _)))

/-- Every block is closed. -/
theorem isClosed_hcBlock {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (k : Fin 6) : IsClosed (hcBlock g m n k) := by
  fin_cases k
  · exact (isCompact_hcDownTri m n).isClosed
  · exact (isCompact_hcUp hg m n).isClosed
  · exact isClosed_closure
  · exact isClosed_closure
  · exact isClosed_closure
  · exact isClosed_closedBall

/-- HC is closed (a locally finite union of closed blocks). -/
theorem isClosed_hcSet {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : IsClosed (hcSet g) := by
  rw [hcSet_eq_iUnion]
  exact (hcBlock_locallyFinite hZc hZs hZi hl hr hg).isClosed_iUnion fun p => isClosed_hcBlock hg _ _ _

/-- The open ball of radius `1/4` about the up centroid lies in the up triangle. -/
theorem ball_subset_hcUpTri (m n : ℤ) : ball (hcUpC m n) (1 / 4) ⊆ hcUpTri m n := by
  intro w hw
  rw [mem_ball, dist_eq_norm] at hw
  refine mem_hcUpTri_iff.2 fun k => ?_
  have hre : ((w - hcUpC m n) / e (2 * π * ((k : ℕ) : ℝ) / 3)).re ≤ 1 / 4 := by
    refine (Complex.re_le_norm _).trans ?_
    rw [norm_div, norm_e, div_one]; exact hw.le
  have : (1.7 : ℝ) < √3 := by nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num), Real.sqrt_nonneg 3]
  simp only [hcFrameT]; unfold hcL; linarith

/-- The open ball of radius `1/4` about the down centroid lies in the down triangle. -/
theorem ball_subset_hcDownTri (m n : ℤ) : ball (hcDownC m n) (1 / 4) ⊆ hcDownTri m n := by
  intro w hw
  refine mem_hcDownTri_iff.2 (ball_subset_hcUpTri m n ?_)
  rw [mem_ball, dist_eq_norm, show hcUpC m n + hcDownC m n - w - hcUpC m n = -(w - hcDownC m n) by ring, norm_neg,
    ← dist_eq_norm]
  exact hw

/-- A band is open. -/
theorem isOpen_hcBand {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    IsOpen (hcBand g m n j) := by
  have heq : hcBand g m n j = {z | |hcFrameS m n j z| < 1 / 2} ∩
      (fun z => (hcFrameT m n j z, hcBandTop g m n j (hcFrameS m n j z))) ⁻¹' {p : ℝ × ℝ | 1 < p.1 ∧ p.1 < p.2} := by
    ext z
    constructor
    · rintro ⟨s, t, hs, ht, ht', rfl⟩
      simp only [mem_inter_iff, mem_setOf_eq, mem_preimage, (hcFrame_coords m n j s t).1, (hcFrame_coords m n j s t).2]
      exact ⟨hs, ht, ht'⟩
    · rintro ⟨hs, ht, ht'⟩
      exact ⟨_, _, hs, ht, ht', (hcFrame_hcFrameST m n j z).symm⟩
  rw [heq]
  refine ContinuousOn.isOpen_inter_preimage ?_ (isOpen_lt (continuous_abs.comp (continuous_hcFrameS m n j))
    continuous_const) ((isOpen_lt continuous_const continuous_fst).inter (isOpen_lt continuous_fst continuous_snd))
  refine (continuous_hcFrameT m n j).continuousOn.prodMk ?_
  refine (continuousOn_hcBandTop hZc hZs hZi hl hr hg m n j).comp (continuous_hcFrameS m n j).continuousOn ?_
  intro z hz
  have hz' : |hcFrameS m n j z| < 1 / 2 := hz
  exact ⟨by linarith [neg_abs_le (hcFrameS m n j z)], by linarith [le_abs_self (hcFrameS m n j z)]⟩

/-- `U`'s strict part `U°`: inside the three half-planes, strictly above the three graphs. -/
def hcUpO (g : ℝ → ℝ) (m n : ℤ) : Set ℂ :=
  {z | ∀ k : Fin 3, 2 < hcFrameT m n k z ∧ 2 + g (hcFrameS m n k z) < hcFrameT m n k z}

example (g : ℝ → ℝ) (z : ℂ) (h : z ∈ hcUpO g 0 0) : 2 < hcFrameT 0 0 2 z ∧ 2 + g (hcFrameS 0 0 1 z) < hcFrameT 0 0 1 z :=
  ⟨(h 2).1, (h 1).2⟩

/-- `U°` is open. -/
theorem isOpen_hcUpO {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) : IsOpen (hcUpO g m n) := by
  have : hcUpO g m n = ⋂ k : Fin 3, ({z | 2 < hcFrameT m n k z} ∩ {z | 2 + g (hcFrameS m n k z) < hcFrameT m n k z}) := by
    ext z; simp [hcUpO, forall_and]
  rw [this]
  exact isOpen_iInter_of_finite fun k => (isOpen_lt continuous_const (continuous_hcFrameT m n k)).inter
    (isOpen_lt (continuous_const.add (hg.1.continuous.comp (continuous_hcFrameS m n k))) (continuous_hcFrameT m n k))

/-- `U° ⊆ U`. -/
theorem hcUpO_subset {g : ℝ → ℝ} (m n : ℤ) : hcUpO g m n ⊆ hcUp g m n :=
  fun _ hz => ⟨mem_hcUpTri_iff.2 fun k => (hz k).1.le, fun k => (hz k).2.le⟩

/-- Shrinking toward the centroid scales the frame coordinates: `t ↦ (1 − ε) t + ε c₀`, `s ↦ (1 − ε) s`. -/
theorem hcFrame_shrink (m n : ℤ) (k : Fin 3) (z : ℂ) (ε : ℝ) :
    hcFrameT m n k (z + (ε : ℂ) * (hcUpC m n - z)) = (1 - ε) * hcFrameT m n k z + ε * (hcL - √3 / 6) ∧
      hcFrameS m n k (z + (ε : ℂ) * (hcUpC m n - z)) = (1 - ε) * hcFrameS m n k z := by
  have h : (z + (ε : ℂ) * (hcUpC m n - z) - hcUpC m n) / e (2 * π * ((k : ℕ) : ℝ) / 3) =
      ((1 - ε : ℝ) : ℂ) * ((z - hcUpC m n) / e (2 * π * ((k : ℕ) : ℝ) / 3)) := by push_cast; ring
  constructor
  · simp only [hcFrameT]; rw [h, Complex.re_ofReal_mul]; ring
  · simp only [hcFrameS]; rw [h, Complex.im_ofReal_mul]; ring

/-- **`U` is the closure of `U°`** (shrink toward the centroid; `|g′| ≤ 1/8`). -/
theorem hcUp_subset_closure_hcUpO {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) :
    hcUp g m n ⊆ closure (hcUpO g m n) := by
  intro z hz
  have h3 : (1.7 : ℝ) < √3 := by nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num), Real.sqrt_nonneg 3]
  have hc0 : hcL - √3 / 6 = 2 + √3 / 6 := by unfold hcL; ring
  -- `g` moves by at most `|Δs|/8` on `[−1/2, 1/2]`
  have hlip : ∀ x ∈ Icc (-1 / 2 : ℝ) (1 / 2), ∀ y ∈ Icc (-1 / 2 : ℝ) (1 / 2), g y - g x ≤ |y - x| / 8 := by
    intro x hx y hy
    have := Convex.norm_image_sub_le_of_norm_deriv_le (fun u _ => hg.1 u) (fun u hu => (hg.2.1 u hu).2.2.2.2)
      (convex_Icc _ _) hx hy
    rw [Real.norm_eq_abs, Real.norm_eq_abs] at this
    linarith [le_abs_self (g y - g x)]
  have hin : ∀ ε ∈ Ioo (0 : ℝ) 1, z + (ε : ℂ) * (hcUpC m n - z) ∈ hcUpO g m n := by
    intro ε hε k
    obtain ⟨hT, hS⟩ := hcFrame_shrink m n k z ε
    obtain ⟨hSI, hgk, h2⟩ := hcUp_frame hg hz k
    rw [hT, hS, hc0]
    have hSI' : (1 - ε) * hcFrameS m n k z ∈ Icc (-1 / 2 : ℝ) (1 / 2) := by
      constructor <;> nlinarith [hSI.1, hSI.2, hε.1, hε.2]
    have hl := hlip _ hSI _ hSI'
    have habs : |(1 - ε) * hcFrameS m n k z - hcFrameS m n k z| ≤ ε / 2 := by
      rw [show (1 - ε) * hcFrameS m n k z - hcFrameS m n k z = -(ε * hcFrameS m n k z) by ring, abs_neg, abs_mul,
        abs_of_pos hε.1]
      have : |hcFrameS m n k z| ≤ 1 / 2 := abs_le.2 ⟨by linarith [hSI.1], hSI.2⟩
      nlinarith [hε.1]
    have hg64 := (hg.2.1 _ hSI).2.2.2.1
    constructor
    · nlinarith [hε.1, hε.2]
    · nlinarith [hε.1, hε.2]
  have htend : Tendsto (fun ε : ℝ => z + (ε : ℂ) * (hcUpC m n - z)) (𝓝[>] 0) (𝓝 z) := by
    have : Tendsto (fun ε : ℝ => z + (ε : ℂ) * (hcUpC m n - z)) (𝓝 0) (𝓝 (z + ((0 : ℝ) : ℂ) * (hcUpC m n - z))) :=
      (by fun_prop : Continuous fun ε : ℝ => z + (ε : ℂ) * (hcUpC m n - z)).tendsto 0
    simp only [Complex.ofReal_zero, zero_mul, add_zero] at this
    exact this.mono_left nhdsWithin_le_nhds
  refine mem_closure_of_tendsto htend ?_
  filter_upwards [Ioo_mem_nhdsGT (show (0 : ℝ) < 1 by norm_num)] with ε hε using hin ε hε

/-- HC is the closure of its interior (each block is; `Z` has empty interior, so `σ_e ⊆ cl Λ_e`). -/
theorem closure_interior_hcSet {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : closure (interior (hcSet g)) = hcSet g := by
  refine Subset.antisymm (closure_minimal interior_subset (isClosed_hcSet hZc hZs hZi hl hr hg)) ?_
  have hsub : ∀ m n k, hcBlock g m n k ⊆ hcSet g := fun m n k => by
    rw [hcSet_eq_iUnion]; exact subset_iUnion_of_subset (m, n, k) le_rfl
  have hopen : ∀ {O : Set ℂ}, IsOpen O → O ⊆ hcSet g → closure O ⊆ closure (interior (hcSet g)) :=
    fun hO hOs => closure_mono (interior_maximal hOs hO)
  intro z hz
  rw [hcSet_eq_iUnion, mem_iUnion] at hz
  obtain ⟨⟨m, n, k⟩, hz⟩ := hz
  fin_cases k
  · have hz0 : z ∈ hcDownTri m n := hz
    have hne : (interior (hcDownTri m n)).Nonempty :=
      ⟨hcDownC m n, interior_maximal (ball_subset_hcDownTri m n) isOpen_ball (mem_ball_self (by norm_num))⟩
    have hcl : closure (interior (hcDownTri m n)) = closure (hcDownTri m n) :=
      (show Convex ℝ (hcDownTri m n) from convex_convexHull ℝ _).closure_interior_eq_closure_of_nonempty_interior hne
    have hz' : z ∈ closure (interior (hcDownTri m n)) := by rw [hcl]; exact subset_closure hz0
    exact closure_mono (interior_mono (hsub m n 0)) hz'
  · exact hopen (isOpen_hcUpO hg m n) ((hcUpO_subset m n).trans (hsub m n 1)) (hcUp_subset_closure_hcUpO hg m n hz)
  · exact hopen (isOpen_hcBand hZc hZs hZi hl hr hg m n 0) (subset_closure.trans (hsub m n 2)) hz
  · exact hopen (isOpen_hcBand hZc hZs hZi hl hr hg m n 1) (subset_closure.trans (hsub m n 3)) hz
  · exact hopen (isOpen_hcBand hZc hZs hZi hl hr hg m n 2) (subset_closure.trans (hsub m n 4)) hz
  · refine hopen isOpen_ball (ball_subset_closedBall.trans (hsub m n 5)) ?_
    rw [closure_ball _ (by norm_num : (1 / 2 : ℝ) ≠ 0)]; exact hz

/-- Translating along `−w` moves `t` by `c`; along `−iw` moves `s` by `c`. -/
theorem hcFrame_shift (m n : ℤ) (j : Fin 3) (z : ℂ) (c : ℝ) :
    (hcFrameT m n j (z + (c : ℂ) * (-e (2 * π * ((j : ℕ) : ℝ) / 3))) = hcFrameT m n j z + c ∧
      hcFrameS m n j (z + (c : ℂ) * (-e (2 * π * ((j : ℕ) : ℝ) / 3))) = hcFrameS m n j z) ∧
    (hcFrameS m n j (z + (c : ℂ) * (-(I * e (2 * π * ((j : ℕ) : ℝ) / 3)))) = hcFrameS m n j z + c ∧
      hcFrameT m n j (z + (c : ℂ) * (-(I * e (2 * π * ((j : ℕ) : ℝ) / 3)))) = hcFrameT m n j z) := by
  have hw : e (2 * π * ((j : ℕ) : ℝ) / 3) ≠ 0 := by
    intro h; have := norm_e (2 * π * ((j : ℕ) : ℝ) / 3); rw [h, norm_zero] at this; norm_num at this
  have h1 : (z + (c : ℂ) * (-e (2 * π * ((j : ℕ) : ℝ) / 3)) - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) =
      (z - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) - c := by field_simp; ring
  have h2 : (z + (c : ℂ) * (-(I * e (2 * π * ((j : ℕ) : ℝ) / 3))) - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) =
      (z - hcUpC m n) / e (2 * π * ((j : ℕ) : ℝ) / 3) - c * I := by field_simp; ring
  refine ⟨⟨?_, ?_⟩, ?_, ?_⟩
  · simp only [hcFrameT]; rw [h1]; simp; ring
  · simp only [hcFrameS]; rw [h1]; simp
  · simp only [hcFrameS]; rw [h2]; simp; ring
  · simp only [hcFrameT]; rw [h2]; simp

/-- Frame boxes are bounded. -/
theorem isBounded_hcFrame_box (m n : ℤ) (j : Fin 3) (K M : ℝ) :
    Bornology.IsBounded {z | |hcFrameT m n j z| ≤ K ∧ |hcFrameS m n j z| ≤ M} := by
  refine (isBounded_closedBall (x := hcFrame m n j 0 0) (r := M + K)).subset fun z hz => ?_
  rw [mem_closedBall, dist_eq_hcFrame m n j, (hcFrame_coords m n j 0 0).1, (hcFrame_coords m n j 0 0).2, sub_zero,
    sub_zero]
  obtain ⟨h1, h2⟩ := hz
  refine Real.sqrt_le_iff.2 ⟨by linarith [abs_nonneg (hcFrameT m n j z), abs_nonneg (hcFrameS m n j z)], ?_⟩
  nlinarith [sq_abs (hcFrameS m n j z), sq_abs (hcFrameT m n j z), abs_nonneg (hcFrameS m n j z),
    abs_nonneg (hcFrameT m n j z)]

/-- A graph `t = f(s)` in an edge frame is null. -/
theorem volume_hcFrame_graph (m n : ℤ) (j : Fin 3) {f : ℝ → ℝ} (hf : Continuous f) :
    volume {z | hcFrameT m n j z = f (hcFrameS m n j z)} = 0 :=
  volume_graph_eq_zero (continuous_hcFrameT m n j) (continuous_hcFrameS m n j)
    (fun z c => (hcFrame_shift m n j z c).1) (fun K M => isBounded_hcFrame_box m n j K M) hf

/-- A line `s = c` in an edge frame is null. -/
theorem volume_hcFrame_line (m n : ℤ) (j : Fin 3) (c : ℝ) : volume {z | hcFrameS m n j z = c} = 0 := by
  have := volume_graph_eq_zero (φ := hcFrameS m n j) (ψ := hcFrameT m n j) (continuous_hcFrameS m n j)
    (continuous_hcFrameT m n j) (fun z c => (hcFrame_shift m n j z c).2)
    (fun K M => by simpa only [and_comm] using isBounded_hcFrame_box m n j M K) (f := fun _ => c) continuous_const
  exact this

/-- `U`'s frontier is null: the triangle's sides and the three graphs. -/
theorem volume_frontier_hcUp {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) : volume (frontier (hcUp g m n)) = 0 := by
  have hgc : Continuous g := hg.1.continuous
  set A : Fin 3 → Set ℂ := fun k => {z | 2 + g (hcFrameS m n k z) ≤ hcFrameT m n k z}
  have heq : hcUp g m n = hcUpTri m n ∩ (A 0 ∩ (A 1 ∩ A 2)) := by
    ext z; simp only [hcUp, mem_inter_iff, mem_setOf_eq, A]
    constructor
    · rintro ⟨h, hk⟩; exact ⟨h, hk 0, hk 1, hk 2⟩
    · rintro ⟨h, h0, h1, h2⟩; exact ⟨h, fun k => by fin_cases k <;> assumption⟩
  have hfr : ∀ k, frontier (A k) ⊆ {z | hcFrameT m n k z = (fun s => 2 + g s) (hcFrameS m n k z)} := fun k =>
    (frontier_le_subset_eq (continuous_const.add (hgc.comp (continuous_hcFrameS m n k))) (continuous_hcFrameT m n k)).trans
      fun z hz => (hz : _ = _).symm
  have hnull : ∀ k, volume (frontier (A k)) = 0 := fun k =>
    measure_mono_null (hfr k) (volume_hcFrame_graph m n k (continuous_const.add hgc))
  have hinter : ∀ s t : Set ℂ, frontier (s ∩ t) ⊆ frontier s ∪ frontier t := fun s t =>
    (frontier_inter_subset s t).trans (union_subset_union inter_subset_left inter_subset_right)
  rw [heq]
  refine measure_mono_null ((hinter _ _).trans (union_subset_union le_rfl ((hinter _ _).trans
    (union_subset_union le_rfl (hinter _ _))))) ?_
  refine measure_union_null ((show Convex ℝ (hcUpTri m n) from convex_convexHull ℝ _).addHaar_frontier (μ := volume))
    (measure_union_null (hnull 0) (measure_union_null (hnull 1) (hnull 2)))

/-- A closed band's frontier is null: two segments' lines, the line `t = 1` and the graph of `ℓ`. -/
theorem volume_frontier_closure_hcBand {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2))
    (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ)
    (j : Fin 3) : volume (frontier (closure (hcBand g m n j))) = 0 := by
  set clamp : ℝ → ℝ := fun s => max (-1 / 2) (min s (1 / 2)) with hclamp
  have hcl : Continuous clamp := continuous_const.max (continuous_id.min continuous_const)
  have hclI : ∀ s, clamp s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := fun s => ⟨le_max_left _ _, max_le (by norm_num) (min_le_right _ _)⟩
  set ℓ' : ℝ → ℝ := fun s => hcBandTop g m n j (clamp s) with hℓ'
  have hℓc : Continuous ℓ' :=
    (continuousOn_hcBandTop hZc hZs hZi hl hr hg m n j).comp_continuous hcl hclI
  have hcl_id : ∀ s, |s| ≤ 1 / 2 → clamp s = s := fun s hs => by
    simp only [hclamp]; rw [min_eq_left (abs_le.1 hs).2, max_eq_right (by linarith [(abs_le.1 hs).1])]
  set C := {z | |hcFrameS m n j z| ≤ 1 / 2 ∧ 1 ≤ hcFrameT m n j z ∧ hcFrameT m n j z ≤ ℓ' (hcFrameS m n j z)}
  have hC : IsClosed C := (isClosed_le (continuous_abs.comp (continuous_hcFrameS m n j)) continuous_const).inter
    ((isClosed_le continuous_const (continuous_hcFrameT m n j)).inter
      (isClosed_le (continuous_hcFrameT m n j) (hℓc.comp (continuous_hcFrameS m n j))))
  have hbC : hcBand g m n j ⊆ C := by
    rintro _ ⟨s, t, hs, ht, ht', rfl⟩
    simp only [C, mem_setOf_eq, (hcFrame_coords m n j s t).1, (hcFrame_coords m n j s t).2, hℓ', hcl_id s hs.le]
    exact ⟨hs.le, ht.le, ht'.le⟩
  have hopen := isOpen_hcBand hZc hZs hZi hl hr hg m n j
  have hsub : frontier (closure (hcBand g m n j)) ⊆ {z | hcFrameS m n j z = 1 / 2} ∪ {z | hcFrameS m n j z = -1 / 2} ∪
      {z | hcFrameT m n j z = (fun _ => (1 : ℝ)) (hcFrameS m n j z)} ∪ {z | hcFrameT m n j z = ℓ' (hcFrameS m n j z)} := by
    intro z hz
    have hz1 := frontier_closure_subset hz
    rw [hopen.frontier_eq] at hz1
    obtain ⟨hzc, hzb⟩ := hz1
    obtain ⟨h1, h2, h3⟩ := closure_minimal hbC hC hzc
    by_cases hs : |hcFrameS m n j z| = 1 / 2
    · rcases abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 2) |>.1 hs with h | h
      · exact Or.inl (Or.inl (Or.inl h))
      · exact Or.inl (Or.inl (Or.inr (show hcFrameS m n j z = -1 / 2 by rw [h]; norm_num)))
    have hs' : |hcFrameS m n j z| < 1 / 2 := lt_of_le_of_ne h1 hs
    by_cases ht : hcFrameT m n j z = 1
    · exact Or.inl (Or.inr ht)
    refine Or.inr ?_
    simp only [mem_setOf_eq]
    refine le_antisymm h3 (not_lt.1 fun hlt => hzb ⟨_, _, hs', lt_of_le_of_ne h2 (Ne.symm ht), ?_,
      (hcFrame_hcFrameST m n j z).symm⟩)
    simpa only [hℓ', hcl_id _ hs'.le] using hlt
  refine measure_mono_null hsub (measure_union_null (measure_union_null (measure_union_null ?_ ?_) ?_) ?_)
  · exact volume_hcFrame_line m n j _
  · exact volume_hcFrame_line m n j _
  · exact volume_hcFrame_graph m n j continuous_const
  · exact volume_hcFrame_graph m n j hℓc

/-- Every block's frontier is null. -/
theorem volume_frontier_hcBlock {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (k : Fin 6) :
    volume (frontier (hcBlock g m n k)) = 0 := by
  fin_cases k
  · exact (show Convex ℝ (hcDownTri m n) from convex_convexHull ℝ _).addHaar_frontier (μ := volume)
  · exact volume_frontier_hcUp hg m n
  · exact volume_frontier_closure_hcBand hZc hZs hZi hl hr hg m n 0
  · exact volume_frontier_closure_hcBand hZc hZs hZi hl hr hg m n 1
  · exact volume_frontier_closure_hcBand hZc hZs hZi hl hr hg m n 2
  · exact (convex_closedBall _ _).addHaar_frontier (μ := volume)

/-- HC's frontier is null: segments, circles and graphs of continuous functions, locally finitely many. -/
theorem volume_frontier_hcSet {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : volume (frontier (hcSet g)) = 0 := by
  rw [hcSet_eq_iUnion]
  have hlf := hcBlock_locallyFinite hZc hZs hZi hl hr hg
  have hsub : frontier (⋃ p : ℤ × ℤ × Fin 6, hcBlock g p.1 p.2.1 p.2.2) ⊆
      ⋃ p : ℤ × ℤ × Fin 6, frontier (hcBlock g p.1 p.2.1 p.2.2) := by
    intro z hz
    obtain ⟨hzc, hzi⟩ := hz
    rw [hlf.closure_iUnion, mem_iUnion] at hzc
    obtain ⟨p, hp⟩ := hzc
    exact mem_iUnion.2 ⟨p, hp, fun hi => hzi (interior_mono (subset_iUnion (fun p : ℤ × ℤ × Fin 6 =>
      hcBlock g p.1 p.2.1 p.2.2) p) hi)⟩
  exact measure_mono_null hsub (measure_iUnion_null fun p => volume_frontier_hcBlock hZc hZs hZi hl hr hg _ _ _)

/-- The distance from `s ∈ [−1/2, 1/2]` to `Z ∋ ±1/2` is at most `1/2 − |s|`. -/
theorem infDist_le_half_sub_abs {Z : Set ℝ} (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {s : ℝ}
    (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) : infDist s Z ≤ 1 / 2 - |s| := by
  rcases le_total 0 s with h | h
  · refine (infDist_le_dist_of_mem hr).trans_eq ?_
    rw [Real.dist_eq, abs_of_nonneg h, abs_of_nonpos (by linarith [hs.2])]; ring
  · refine (infDist_le_dist_of_mem hl).trans_eq ?_
    rw [Real.dist_eq, abs_of_nonpos h, abs_of_nonneg (by linarith [hs.1])]; ring

/-- **The band has diameter `< 1`**: it thins to `0` quadratically at both ends (§ 2.3: `|z₁ − z₂|² < 1 − σ + σ² ≤ 1`). -/
theorem hc_band_dist_lt_one {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {x y : ℂ} (hx : x ∈ hcBand g m n j) (hy : y ∈ hcBand g m n j) :
    dist x y < 1 := by
  obtain ⟨s₁, t₁, hs₁, ht₁, ht₁', rfl⟩ := hx
  obtain ⟨s₂, t₂, hs₂, ht₂, ht₂', rfl⟩ := hy
  wlog h12 : s₁ ≤ s₂ generalizing s₁ t₁ s₂ t₂
  · rw [dist_comm]; exact this s₂ t₂ hs₂ ht₂ ht₂' s₁ t₁ hs₁ ht₁ ht₁' (le_of_not_ge h12)
  have hI : ∀ s : ℝ, |s| < 1 / 2 → s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := fun s hs =>
    ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
  have b1 := (hcBandTop_bounds hZc hZs hZi hl hr hg m n j (hI s₁ hs₁)).2.1
  have b2 := (hcBandTop_bounds hZc hZs hZi hl hr hg m n j (hI s₂ hs₂)).2.1
  have g1 := (hg.2.1 s₁ (hI s₁ hs₁)).2.1
  have g2 := (hg.2.1 s₂ (hI s₂ hs₂)).2.1
  obtain ⟨u₁, hu₁d⟩ : ∃ u, u = s₁ + 1 / 2 := ⟨_, rfl⟩
  obtain ⟨u₂, hu₂d⟩ : ∃ u, u = 1 / 2 - s₂ := ⟨_, rfl⟩
  have hu₁ : 0 < u₁ := by rw [hu₁d]; linarith [neg_abs_le s₁]
  have hu₂ : 0 < u₂ := by rw [hu₂d]; linarith [le_abs_self s₂]
  have d1 : infDist s₁ Z ≤ u₁ :=
    (infDist_le_dist_of_mem hl).trans_eq (by rw [Real.dist_eq, abs_of_pos (by linarith), hu₁d]; ring)
  have d2 : infDist s₂ Z ≤ u₂ :=
    (infDist_le_dist_of_mem hr).trans_eq (by rw [Real.dist_eq, abs_of_neg (by linarith), hu₂d]; ring)
  have i1 := infDist_nonneg (x := s₁) (s := Z)
  have i2 := infDist_nonneg (x := s₂) (s := Z)
  obtain ⟨σ, hσ⟩ : ∃ σ, σ = u₁ + u₂ := ⟨_, rfl⟩
  have hσ1 : σ ≤ 1 := by rw [hσ, hu₁d, hu₂d]; linarith
  have hσ0 : 0 < σ := by rw [hσ]; positivity
  -- `|t₁ − t₂| < σ²/4`
  have e1 : g s₁ ≤ σ ^ 2 / 4 := g1.trans (by nlinarith)
  have e2 : g s₂ ≤ σ ^ 2 / 4 := g2.trans (by nlinarith)
  have ht : |t₁ - t₂| < σ ^ 2 / 4 := by rw [abs_lt]; constructor <;> linarith
  have ht2 : (t₁ - t₂) ^ 2 < (σ ^ 2 / 4) ^ 2 := by
    rw [← sq_abs]; exact pow_lt_pow_left₀ ht (abs_nonneg _) two_ne_zero
  have hσ4 : (σ ^ 2 / 4) ^ 2 ≤ σ := by
    have : σ ^ 3 ≤ 1 := pow_le_one₀ hσ0.le hσ1
    nlinarith
  rw [dist_hcFrame, Real.sqrt_lt' one_pos]
  have hs : s₁ - s₂ = σ - 1 := by rw [hσ, hu₁d, hu₂d]; ring
  rw [hs]
  nlinarith

/-- The distance bound from the Cartesian form. -/
theorem dist_le_one_of_sq {z w : ℂ} (h : (z - w).re ^ 2 + (z - w).im ^ 2 ≤ 1) : dist z w ≤ 1 := by
  rw [dist_eq_norm, Complex.norm_def, Real.sqrt_le_one, Complex.normSq_apply]; nlinarith

/-- The up triangle has diameter `1`. -/
theorem dist_le_one_of_mem_hcUpTri {m n : ℤ} {p q : ℂ} (hp : p ∈ hcUpTri m n) (hq : q ∈ hcUpTri m n) : dist p q ≤ 1 := by
  refine (dist_le_diam_of_mem (isCompact_hcUpTri m n).isBounded hp hq).trans ?_
  unfold hcUpTri
  rw [convexHull_diam]
  refine diam_le_of_forall_dist_le zero_le_one ?_
  obtain ⟨v1, v2, v3⟩ := hcUpTri_vertices
  have hs : √3 * √3 = (3 : ℝ) := Real.mul_self_sqrt (by norm_num)
  intro x hx y hy
  simp only [mem_insert_iff, mem_singleton_iff] at hx hy
  rcases hx with rfl | rfl | rfl <;> rcases hy with rfl | rfl | rfl <;> refine dist_le_one_of_sq ?_ <;>
    simp only [add_sub_add_left_eq_sub, v1, v2, v3] <;> simp <;> nlinarith

/-- The down triangle has diameter `1`. -/
theorem dist_le_one_of_mem_hcDownTri {m n : ℤ} {p q : ℂ} (hp : p ∈ hcDownTri m n) (hq : q ∈ hcDownTri m n) :
    dist p q ≤ 1 := by
  have := dist_le_one_of_mem_hcUpTri (mem_hcDownTri_iff.1 hp) (mem_hcDownTri_iff.1 hq)
  rwa [dist_sub_left] at this

/-- A closed band has diameter at most `1`. -/
theorem dist_le_one_of_mem_closure_band {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2))
    (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ}
    {j : Fin 3} {p q : ℂ} (hp : p ∈ closure (hcBand g m n j)) (hq : q ∈ closure (hcBand g m n j)) : dist p q ≤ 1 := by
  have h1 : ∀ y ∈ hcBand g m n j, ∀ x ∈ closure (hcBand g m n j), dist x y ≤ 1 := by
    intro y hy x hx
    exact closure_minimal (fun x' hx' => (hc_band_dist_lt_one hZc hZs hZi hl hr hg m n j hx' hy).le)
      (isClosed_le (continuous_id.dist continuous_const) continuous_const) hx
  exact closure_minimal (fun y hy => h1 y hy p hp) (isClosed_le (continuous_const.dist continuous_id) continuous_const) hq

/-- **Every block has diameter at most `1`.** -/
theorem hcBlock_dist_le_one {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {k : Fin 6} {p q : ℂ}
    (hp : p ∈ hcBlock g m n k) (hq : q ∈ hcBlock g m n k) : dist p q ≤ 1 := by
  fin_cases k
  · exact dist_le_one_of_mem_hcDownTri hp hq
  · exact dist_le_one_of_mem_hcUpTri (hp : p ∈ hcUp g m n).1 (hq : q ∈ hcUp g m n).1
  · exact dist_le_one_of_mem_closure_band hZc hZs hZi hl hr hg (j := 0) hp hq
  · exact dist_le_one_of_mem_closure_band hZc hZs hZi hl hr hg (j := 1) hp hq
  · exact dist_le_one_of_mem_closure_band hZc hZs hZi hl hr hg (j := 2) hp hq
  · have h1 : dist p (hcFace m n) ≤ 1 / 2 := hp
    have h2 : dist q (hcFace m n) ≤ 1 / 2 := hq
    linarith [dist_triangle_right p q (hcFace m n)]

/-- **§ 2.3, unit-avoiding**: no two points of `int HC` are at distance `1` — the block-distance table H1 (exact in `ℚ(√3)`, one
period), the band within `1/64` of `σ_e`, the flanking pairs (`Λ_e ⊆ {t > 1}`, `d_U > 1` on `Λ_e`), diameters. **Split at
implementation** into the table and the flanking pairs. -/
theorem hc_unitAvoiding {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : ∀ x ∈ interior (hcSet g), ∀ y ∈ interior (hcSet g), dist x y ≠ 1 := by
  intro x hx y hy hxy
  have hxH := interior_subset hx
  have hyH := interior_subset hy
  obtain ⟨r, hr0, hball⟩ := Metric.isOpen_iff.1 isOpen_interior x hx
  set ε := min (r / 2) (1 / 2) with hε
  have hε0 : 0 < ε := lt_min (by linarith) (by norm_num)
  have hεr : ε < r := lt_of_le_of_lt (min_le_left _ _) (by linarith)
  have hε1 : ε < 1 := lt_of_le_of_lt (min_le_right _ _) (by norm_num)
  set v := y - x
  have hv : ‖v‖ = 1 := by rw [← dist_eq_norm, dist_comm, hxy]
  set p := x + (ε : ℂ) * v
  set q := x - (ε : ℂ) * v
  have hpx : dist p x = ε := by
    simp only [p, dist_eq_norm, add_sub_cancel_left, norm_mul, hv, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hε0, mul_one]
  have hqx : dist q x = ε := by
    simp only [q, dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_mul, hv, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos hε0, mul_one]
  have hpy : dist p y = 1 - ε := by
    have : p - y = ((ε - 1 : ℝ) : ℂ) * v := by simp only [p, v]; push_cast; ring
    rw [dist_eq_norm, this, norm_mul, hv, Complex.norm_real, Real.norm_eq_abs, abs_of_neg (by linarith)]; ring
  have hqy : dist q y = 1 + ε := by
    have : q - y = ((-(1 + ε)) : ℝ) * v := by simp only [q, v]; push_cast; ring
    rw [dist_eq_norm, this, norm_mul, hv, Complex.norm_real, Real.norm_eq_abs, abs_of_neg (by linarith)]; ring
  have hpH : p ∈ hcSet g := interior_subset (hball (by rw [mem_ball, hpx]; exact hεr))
  have hqH : q ∈ hcSet g := interior_subset (hball (by rw [mem_ball, hqx]; exact hεr))
  rw [hcSet_eq_iUnion, mem_iUnion] at hxH hyH hpH hqH
  obtain ⟨⟨mx, nx, kx⟩, hbx⟩ := hxH
  obtain ⟨⟨my, ny, ky⟩, hby⟩ := hyH
  obtain ⟨⟨mp, np, kp⟩, hbp⟩ := hpH
  obtain ⟨⟨mq, nq, kq⟩, hbq⟩ := hqH
  have same : ∀ {a b : ℂ} {m n m' n' : ℤ} {k k' : Fin 6}, a ∈ hcBlock g m n k → b ∈ hcBlock g m' n' k' → dist a b < 1 →
      m = m' ∧ n = n' ∧ k = k' := fun ha hb hab => by
    by_contra hne; exact absurd (hcBlock_sep hZc hZs hZi hl hr hg hne ha hb) (not_le.2 hab)
  obtain ⟨rfl, rfl, rfl⟩ := same hbp hbx (by rw [hpx]; exact hε1)
  obtain ⟨rfl, rfl, rfl⟩ := same hbp hby (by rw [hpy]; linarith)
  obtain ⟨rfl, rfl, rfl⟩ := same hbq hbx (by rw [hqx]; exact hε1)
  have := hcBlock_dist_le_one hZc hZs hZi hl hr hg hbq hby
  rw [hqy] at this
  linarith

/-- Every point is within `L` of a face centre (the face lattice's covering radius). -/
theorem exists_near_hcFace (z : ℂ) : ∃ m n : ℤ, dist z (hcFace m n) ≤ hcL := by
  have hL : 0 < hcL := by unfold hcL; positivity
  set c : ℂ := ((hcL * √3 : ℝ) : ℂ) * e (π / 6) with hc
  have hcn : ‖c‖ = hcL * √3 := by
    rw [hc, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity)]
  have hc0 : c ≠ 0 := by
    intro h; rw [h, norm_zero] at hcn; nlinarith [Real.sqrt_pos.2 (show (0 : ℝ) < 3 by norm_num)]
  obtain ⟨p, q, h⟩ := tri_cover (z / c)
  refine ⟨p, q, ?_⟩
  have e1 : z - hcFace p q = c * (z / c - tri p q) := by rw [hcFace, mul_sub, mul_div_cancel₀ _ hc0]
  rw [dist_eq_norm, e1, norm_mul, hcn]
  have hs : (√3) ^ 2 = (3 : ℝ) := Real.sq_sqrt (by norm_num)
  have hn : ‖z / c - tri p q‖ ^ 2 ≤ 1 / 3 := by rw [Complex.sq_norm]; exact h
  have hx2 : (√3 * ‖z / c - tri p q‖) ^ 2 ≤ 1 := by rw [mul_pow, hs]; linarith
  have hx : √3 * ‖z / c - tri p q‖ ≤ 1 := (pow_le_one_iff_of_nonneg (by positivity) two_ne_zero).1 hx2
  calc hcL * √3 * ‖z / c - tri p q‖ = hcL * (√3 * ‖z / c - tri p q‖) := by ring
    _ ≤ hcL * 1 := mul_le_mul_of_nonneg_left hx hL.le
    _ = hcL := mul_one _

/-- **The up triangle in one edge frame**: `t ≥ 2` and `√3 |s| ≤ 2 + √3/2 − t`. -/
theorem mem_hcUpTri_iff_frame {m n : ℤ} (j : Fin 3) {z : ℂ} :
    z ∈ hcUpTri m n ↔ 2 ≤ hcFrameT m n j z ∧ √3 * |hcFrameS m n j z| ≤ 2 + √3 / 2 - hcFrameT m n j z := by
  have h3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  rw [mem_hcUpTri_iff, Fin.forall_fin_succ, Fin.forall_fin_succ, Fin.forall_fin_one]
  obtain ⟨⟨T0, S0⟩, ⟨T1, S1⟩, ⟨T2, S2⟩⟩ := hcFrame_explicit m n z
  simp only [Fin.succ_zero_eq_one, Fin.succ_one_eq_two]
  rw [T0, T1, T2]
  have key : ∀ x c : ℝ, √3 * |x| ≤ c ↔ √3 * x ≤ c ∧ -(√3 * x) ≤ c := fun x c => by
    constructor
    · intro h; exact ⟨by nlinarith [le_abs_self x], by nlinarith [neg_abs_le x]⟩
    · rintro ⟨h1, h2⟩; rcases abs_cases x with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> linarith
  fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue]
  · rw [T0, S0, key]
    constructor
    · rintro ⟨h0, h1, h2⟩; refine ⟨h0, ⟨?_, ?_⟩⟩ <;> nlinarith
    · rintro ⟨h0, h1, h2⟩; refine ⟨h0, ?_, ?_⟩ <;> nlinarith
  · rw [T1, S1, key]
    constructor
    · rintro ⟨h0, h1, h2⟩; refine ⟨h1, ⟨?_, ?_⟩⟩ <;> nlinarith
    · rintro ⟨h1, h2, h3'⟩; refine ⟨?_, h1, ?_⟩ <;> nlinarith
  · rw [T2, S2, key]
    constructor
    · rintro ⟨h0, h1, h2⟩; refine ⟨h2, ⟨?_, ?_⟩⟩ <;> nlinarith
    · rintro ⟨h2, h4, h5⟩; refine ⟨?_, ?_, h2⟩ <;> nlinarith

/-- **The down triangle across edge `j`, in that edge's frame**: `t ≤ 0` and `√3 |s| ≤ √3/2 + t`. -/
theorem mem_hcDownTri_iff_frame {m n : ℤ} (j : Fin 3) {z : ℂ} :
    z ∈ hcDownTri (hcDn m n j).1 (hcDn m n j).2 ↔ hcFrameT m n j z ≤ 0 ∧ √3 * |hcFrameS m n j z| ≤ √3 / 2 + hcFrameT m n j z := by
  rw [mem_hcDownTri_iff, mem_hcUpTri_iff_frame j, (hcFrame_dn m n j z).1, (hcFrame_dn m n j z).2, abs_neg]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨by linarith, by linarith⟩
  · rintro ⟨h1, h2⟩; exact ⟨by linarith, by linarith⟩

/-- The up centroids around a face centre: `O + L`, `O + L e(2π/3)`, `O + L e(4π/3)`. -/
theorem hcUpC_around (m n : ℤ) :
    hcUpC m n = hcFace m n + ((hcL : ℝ) : ℂ) ∧
      hcUpC (m - 1) (n + 1) = hcFace m n + ((-(hcL / 2) : ℝ) : ℂ) + ((hcL * √3 / 2 : ℝ) : ℂ) * I ∧
      hcUpC (m - 1) n = hcFace m n + ((-(hcL / 2) : ℝ) : ℂ) + ((-(hcL * √3 / 2)) : ℝ) * I := by
  have hω := e_pi_div_three
  refine ⟨rfl, ?_, ?_⟩
  · rw [hcUpC, hcFace_eq_tri, hcFace_eq_tri, tri, tri, hω]
    push_cast
    ring
  · rw [hcUpC, hcFace_eq_tri, hcFace_eq_tri, tri, tri, hω]
    push_cast
    ring

/-- **The six edge frames around a face**, in Cartesian coordinates `(x, y) = z − O`: the edges `(m, n, 1)` (at 30°),
`(m − 1, n + 1, 0)` (90°), `(m − 1, n + 1, 2)` (150°), `(m − 1, n, 1)` (210°), `(m − 1, n, 0)` (270°), `(m, n, 2)` (330°). -/
theorem hcFrame_face (m n : ℤ) (z : ℂ) :
    (hcFrameT m n 1 z = 1 + (z - hcFace m n).re / 2 - √3 / 2 * (z - hcFace m n).im ∧
      hcFrameS m n 1 z = √3 / 2 * (z - hcFace m n).re + (z - hcFace m n).im / 2 - (√3 + 1 / 2)) ∧
    (hcFrameT m n 2 z = 1 + (z - hcFace m n).re / 2 + √3 / 2 * (z - hcFace m n).im ∧
      hcFrameS m n 2 z = -(√3 / 2 * (z - hcFace m n).re) + (z - hcFace m n).im / 2 + (√3 + 1 / 2)) ∧
    (hcFrameT (m - 1) (n + 1) 0 z = 1 - (z - hcFace m n).re ∧
      hcFrameS (m - 1) (n + 1) 0 z = -(z - hcFace m n).im + (√3 + 1 / 2)) ∧
    (hcFrameT (m - 1) (n + 1) 2 z = 1 + (z - hcFace m n).re / 2 + √3 / 2 * (z - hcFace m n).im ∧
      hcFrameS (m - 1) (n + 1) 2 z = -(√3 / 2 * (z - hcFace m n).re) + (z - hcFace m n).im / 2 - (√3 + 1 / 2)) ∧
    (hcFrameT (m - 1) n 1 z = 1 + (z - hcFace m n).re / 2 - √3 / 2 * (z - hcFace m n).im ∧
      hcFrameS (m - 1) n 1 z = √3 / 2 * (z - hcFace m n).re + (z - hcFace m n).im / 2 + (√3 + 1 / 2)) ∧
    (hcFrameT (m - 1) n 0 z = 1 - (z - hcFace m n).re ∧
      hcFrameS (m - 1) n 0 z = -(z - hcFace m n).im - (√3 + 1 / 2)) := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  obtain ⟨o1, o2, o3⟩ := hcUpC_around m n
  set x := (z - hcFace m n).re
  set y := (z - hcFace m n).im
  have r1 : (z - hcUpC m n).re = x - hcL ∧ (z - hcUpC m n).im = y := by
    rw [o1]; constructor <;> simp [x, y]; ring
  have r2 : (z - hcUpC (m - 1) (n + 1)).re = x + hcL / 2 ∧ (z - hcUpC (m - 1) (n + 1)).im = y - hcL * √3 / 2 := by
    rw [o2]; constructor <;> simp [x, y] <;> ring
  have r3 : (z - hcUpC (m - 1) n).re = x + hcL / 2 ∧ (z - hcUpC (m - 1) n).im = y + hcL * √3 / 2 := by
    rw [o3]; constructor <;> simp [x, y] <;> ring
  obtain ⟨-, ⟨T1, S1⟩, ⟨T2, S2⟩⟩ := hcFrame_explicit m n z
  obtain ⟨⟨T0', S0'⟩, -, ⟨T2', S2'⟩⟩ := hcFrame_explicit (m - 1) (n + 1) z
  obtain ⟨⟨T0'', S0''⟩, ⟨T1'', S1''⟩, -⟩ := hcFrame_explicit (m - 1) n z
  simp only [r1.1, r1.2] at T1 S1 T2 S2
  simp only [r2.1, r2.2] at T0' S0' T2' S2'
  simp only [r3.1, r3.2] at T0'' S0'' T1'' S1''
  unfold hcL at *
  have h3' : √3 * √3 * √3 = 3 * √3 := by rw [h3]
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · rw [T1]; linarith
  · rw [S1]; linarith
  · rw [T2]; linarith
  · rw [S2]; linarith
  · rw [T0']; linarith
  · rw [S0']; linarith
  · rw [T2']; linarith
  · rw [S2']; linarith
  · rw [T1'']; linarith
  · rw [S1'']; linarith
  · rw [T0'']; linarith
  · rw [S0'']; linarith

/-- `√3 |v| ≤ u` from its two linear halves. -/
theorem sqrt3_mul_abs_le {v u : ℝ} (h1 : √3 * v ≤ u) (h2 : -(√3 * v) ≤ u) : √3 * |v| ≤ u := by
  rcases abs_cases v with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> linarith

/-- **The six cones about a face**: every point lies in the 60° cone about one of the six edge directions at its face
centre, read in that edge's frame (`O = (ε(√3 + 1/2), 1)`, the cone `√3 |t − 1| ≤ √3 + 1/2 − ε s`). -/
theorem hc_face_cone (m n : ℤ) (z : ℂ) : ∃ (m' n' : ℤ) (j : Fin 3) (ε : ℝ), (ε = 1 ∨ ε = -1) ∧
    hcFrame m' n' j (ε * (√3 + 1 / 2)) 1 = hcFace m n ∧
    √3 * |hcFrameT m' n' j z - 1| ≤ √3 + 1 / 2 - ε * hcFrameS m' n' j z := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  obtain ⟨⟨T1, S1⟩, ⟨T2, S2⟩, ⟨T3, S3⟩, ⟨T4, S4⟩, ⟨T5, S5⟩, ⟨T6, S6⟩⟩ := hcFrame_face m n z
  obtain ⟨⟨O1, P1⟩, ⟨O2, P2⟩, ⟨O3, P3⟩, ⟨O4, P4⟩, ⟨O5, P5⟩, ⟨O6, P6⟩⟩ := hcFrame_face m n (hcFace m n)
  simp only [sub_self, zero_re, zero_im, zero_div, mul_zero, add_zero, sub_zero, neg_zero, zero_add] at O1 P1 O2 P2 O3 P3 O4 P4 O5 P5 O6 P6
  have face : ∀ {a b : ℤ} {k : Fin 3} {ε : ℝ}, hcFrameS a b k (hcFace m n) = ε * (√3 + 1 / 2) →
      hcFrameT a b k (hcFace m n) = 1 → hcFrame a b k (ε * (√3 + 1 / 2)) 1 = hcFace m n := by
    intro a b k ε hs ht
    rw [← hs, ← ht]; exact hcFrame_hcFrameST a b k _
  set x := (z - hcFace m n).re
  set y := (z - hcFace m n).im
  have hx3 : √3 * (√3 * x) = 3 * x := by rw [← mul_assoc, h3]
  have hy3 : √3 * (√3 * y) = 3 * y := by rw [← mul_assoc, h3]
  clear_value x y
  rcases le_or_gt 0 y with hy | hy
  · rcases le_or_gt y (√3 * x) with hx | hx
    · refine ⟨m, n, 1, -1, Or.inr rfl, face (by rw [P1]; ring) O1, ?_⟩
      rw [T1, S1]; apply sqrt3_mul_abs_le <;> linarith
    · rcases le_or_gt (-y) (√3 * x) with hx' | hx'
      · refine ⟨m - 1, n + 1, 0, 1, Or.inl rfl, face (by rw [P3]; ring) O3, ?_⟩
        rw [T3, S3]; apply sqrt3_mul_abs_le <;> linarith
      · refine ⟨m - 1, n + 1, 2, -1, Or.inr rfl, face (by rw [P4]; ring) O4, ?_⟩
        rw [T4, S4]; apply sqrt3_mul_abs_le <;> linarith
  · rcases le_or_gt 0 (√3 * x + y) with hx | hx
    · refine ⟨m, n, 2, 1, Or.inl rfl, face (by rw [P2]; ring) O2, ?_⟩
      rw [T2, S2]; apply sqrt3_mul_abs_le <;> linarith
    · rcases le_or_gt (√3 * x) y with hx' | hx'
      · refine ⟨m - 1, n, 1, 1, Or.inl rfl, face (by rw [P5]; ring) O5, ?_⟩
        rw [T5, S5]; apply sqrt3_mul_abs_le <;> linarith
      · refine ⟨m - 1, n, 0, -1, Or.inr rfl, face (by rw [P6]; ring) O6, ?_⟩
        rw [T6, S6]; apply sqrt3_mul_abs_le <;> linarith

/-- The real inequality behind the cone's triangle cases: in the cone `√3 a ≤ u` within `L` of the face, beyond the band
(`a > 1`), the point is inside the triangle (`√3 |c − u| ≤ 1 + √3/2 − a`, `c = √3 + 1/2`). -/
theorem hc_cone_tri_aux {u a : ℝ} (hcone : √3 * a ≤ u) (hL : u ^ 2 + a ^ 2 ≤ hcL ^ 2) (ha : 1 < a) :
    √3 * |√3 + 1 / 2 - u| ≤ 1 + √3 / 2 - a := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  have h17 : (1.7 : ℝ) < √3 := by nlinarith
  have h18 : √3 < 1.8 := by nlinarith
  have hu : 3 * a ≤ √3 * u := by nlinarith
  have hL2 : hcL ^ 2 = 13 / 3 + 4 * √3 / 3 := by unfold hcL; ring_nf; rw [Real.sq_sqrt (by norm_num)]; ring
  have h2 : √3 * u + a ≤ 4 + √3 := by
    nlinarith [sq_nonneg (u - √3 * a), sq_nonneg (√3 * u + a - (4 + √3))]
  apply sqrt3_mul_abs_le <;> nlinarith

/-- **B1 in a cone**: inside the 60° cone of an edge about a face, within `L` of the face, a point is within `3/2` of the
face, in the up or the down triangle, in the edge's slab `|s| ≤ 1/2, 0 ≤ t ≤ 2`, or strictly within `1` of a near corner
`(ε/2, τ)`, `τ ∈ {0, 1, 2}` (a vertex of a triangle or an end of the segment), on the face's side `ε s > 1/2`. -/
theorem hc_cone_cover {m n : ℤ} {j : Fin 3} {ε : ℝ} (hε : ε = 1 ∨ ε = -1) {z : ℂ}
    (hcone : √3 * |hcFrameT m n j z - 1| ≤ √3 + 1 / 2 - ε * hcFrameS m n j z)
    (hL : dist z (hcFrame m n j (ε * (√3 + 1 / 2)) 1) ≤ hcL) :
    dist z (hcFrame m n j (ε * (√3 + 1 / 2)) 1) ≤ 3 / 2 ∨ z ∈ hcUpTri m n ∨
      z ∈ hcDownTri (hcDn m n j).1 (hcDn m n j).2 ∨
      (|hcFrameS m n j z| ≤ 1 / 2 ∧ 0 ≤ hcFrameT m n j z ∧ hcFrameT m n j z ≤ 2) ∨
      (1 / 2 < ε * hcFrameS m n j z ∧ ∃ τ : ℝ, (τ = 0 ∨ τ = 1 ∨ τ = 2) ∧ dist z (hcFrame m n j (ε / 2) τ) < 1) := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  have h17 : (1.7 : ℝ) < √3 := by nlinarith
  have h18 : √3 < 1.8 := by nlinarith
  have hε2 : ε * ε = 1 := by rcases hε with rfl | rfl <;> norm_num
  have hdist : ∀ a b : ℝ, dist z (hcFrame m n j a b) = √((hcFrameS m n j z - a) ^ 2 + (hcFrameT m n j z - b) ^ 2) := by
    intro a b
    rw [dist_eq_hcFrame m n j, (hcFrame_coords m n j a b).1, (hcFrame_coords m n j a b).2]
  rw [hdist] at hL ⊢
  set s := hcFrameS m n j z with hs
  set t := hcFrameT m n j z with ht
  set u := √3 + 1 / 2 - ε * s with hu
  have hsu : (s - ε * (√3 + 1 / 2)) ^ 2 = u ^ 2 := by
    have : s - ε * (√3 + 1 / 2) = -ε * u := by rw [hu]; linear_combination (-s) * hε2
    rw [this]; linear_combination u ^ 2 * hε2
  rw [hsu] at hL ⊢
  have hL0 : 0 ≤ hcL := by unfold hcL; positivity
  have hL2 : u ^ 2 + (t - 1) ^ 2 ≤ hcL ^ 2 := by
    have := (Real.sqrt_le_left hL0).1 hL; linarith
  have hu0 : 0 ≤ u := le_trans (by positivity) hcone
  have hv3 : 3 * (t - 1) ^ 2 ≤ u ^ 2 := by
    have h1 : (√3 * |t - 1|) ^ 2 ≤ u ^ 2 := pow_le_pow_left₀ (by positivity) hcone 2
    rw [mul_pow, Real.sq_sqrt (by norm_num), sq_abs] at h1; exact h1
  rcases le_or_gt (u ^ 2 + (t - 1) ^ 2) (9 / 4) with hd | hd
  · left
    exact Real.sqrt_le_iff.2 ⟨by norm_num, by linarith⟩
  have hu1 : 27 / 16 < u ^ 2 := by linarith
  have hLu : u ≤ hcL := (pow_le_pow_iff_left₀ hu0 hL0 two_ne_zero).1 (by nlinarith [sq_nonneg (t - 1)])
  have hLv : hcL < √3 + 1 := by unfold hcL; linarith
  have hu3 : 3 * √3 / 4 < u := by
    by_contra h
    push Not at h
    have := pow_le_pow_left₀ hu0 h 2
    rw [div_pow, mul_pow, Real.sq_sqrt (by norm_num)] at this
    linarith
  rcases le_or_gt |t - 1| 1 with hv | hv
  · rcases le_or_gt |s| (1 / 2) with hs1 | hs1
    · right; right; right; left
      exact ⟨hs1, by linarith [neg_abs_le (t - 1)], by linarith [le_abs_self (t - 1)]⟩
    · right; right; right; right
      have hes : |ε * s| = |s| := by rw [abs_mul]; rcases hε with rfl | rfl <;> simp
      have hes1 : 1 / 2 < ε * s := by
        rcases abs_cases (ε * s) with ⟨h, -⟩ | ⟨h, -⟩
        · rw [← hes, h] at hs1; exact hs1
        · rw [← hes, h] at hs1; linarith
      refine ⟨hes1, ?_⟩
      have hw : (s - ε / 2) ^ 2 < 3 / 16 := by
        have e1 : (s - ε / 2) ^ 2 = (√3 - u) ^ 2 := by
          rw [hu]; linear_combination (1 / 4 - s ^ 2) * hε2
        have hp : 0 ≤ √3 - u := by linarith
        have hl : √3 - u < √3 / 4 := by linarith
        rw [e1]
        have := pow_lt_pow_left₀ hl hp two_ne_zero
        rw [div_pow, Real.sq_sqrt (by norm_num)] at this
        linarith
      have key : ∀ τ : ℝ, -(1 / 2) ≤ t - τ → t - τ ≤ 1 / 2 → dist z (hcFrame m n j (ε / 2) τ) < 1 := by
        intro τ h1 h2
        have := sq_le_sq' h1 h2
        rw [hdist]
        exact (Real.sqrt_lt' one_pos).2 (by linarith)
      obtain ⟨hv1, hv2⟩ := abs_le.1 hv
      rcases le_or_gt (t - 1) (-1 / 2) with h1 | h1
      · exact ⟨0, Or.inl rfl, key 0 (by linarith) (by linarith)⟩
      · rcases le_or_gt (t - 1) (1 / 2) with h2 | h2
        · exact ⟨1, Or.inr (Or.inl rfl), key 1 (by linarith) (by linarith)⟩
        · exact ⟨2, Or.inr (Or.inr rfl), key 2 (by linarith) (by linarith)⟩
  · have hes : |s| = |√3 + 1 / 2 - u| := by
      rw [hu, show √3 + 1 / 2 - (√3 + 1 / 2 - ε * s) = ε * s by ring, abs_mul]
      rcases hε with rfl | rfl <;> simp
    have hcone' : √3 * |t - 1| ≤ u := hcone
    have hL' : u ^ 2 + |t - 1| ^ 2 ≤ hcL ^ 2 := by rw [sq_abs]; exact hL2
    have htri := hc_cone_tri_aux hcone' hL' hv
    rw [← hes] at htri
    rcases abs_cases (t - 1) with ⟨h, h'⟩ | ⟨h, h'⟩
    · right; left
      rw [h] at htri hv
      exact (mem_hcUpTri_iff_frame j).2 ⟨by linarith, by linarith⟩
    · right; right; left
      rw [h] at htri hv
      exact (mem_hcDownTri_iff_frame j).2 ⟨by linarith, by linarith⟩

/-- **B1, refined**: every point is within `3/2` of a face centre, or in an up or a down triangle, or in an edge's slab
`|s| ≤ 1/2, 0 ≤ t ≤ 2`, or strictly within `1` of a corner `(ε/2, τ)` of an edge's frame on the side `ε s > 1/2`. -/
theorem hc_cover (z : ℂ) : (∃ m n : ℤ, dist z (hcFace m n) ≤ 3 / 2) ∨ ∃ (m n : ℤ) (j : Fin 3),
    z ∈ hcUpTri m n ∨ z ∈ hcDownTri (hcDn m n j).1 (hcDn m n j).2 ∨
      (|hcFrameS m n j z| ≤ 1 / 2 ∧ 0 ≤ hcFrameT m n j z ∧ hcFrameT m n j z ≤ 2) ∨
      ∃ ε : ℝ, (ε = 1 ∨ ε = -1) ∧ 1 / 2 < ε * hcFrameS m n j z ∧
        ∃ τ : ℝ, (τ = 0 ∨ τ = 1 ∨ τ = 2) ∧ dist z (hcFrame m n j (ε / 2) τ) < 1 := by
  obtain ⟨m, n, hO⟩ := exists_near_hcFace z
  obtain ⟨m', n', j, ε, hε, hface, hcone⟩ := hc_face_cone m n z
  rw [← hface] at hO
  rcases hc_cone_cover hε hcone hO with h | h | h | h | ⟨h1, h2⟩
  · exact Or.inl ⟨m, n, hface ▸ h⟩
  · exact Or.inr ⟨m', n', j, Or.inl h⟩
  · exact Or.inr ⟨m', n', j, Or.inr (Or.inl h)⟩
  · exact Or.inr ⟨m', n', j, Or.inr (Or.inr (Or.inl h))⟩
  · exact Or.inr ⟨m', n', j, Or.inr (Or.inr (Or.inr ⟨ε, hε, h1, h2⟩))⟩

/-- The up triangle's side `t = 2`, `|s| ≤ 1/2`, in each of its frames. -/
theorem hcFrame_mem_hcUpTri {m n : ℤ} (j : Fin 3) {s : ℝ} (hs : |s| ≤ 1 / 2) : hcFrame m n j s 2 ∈ hcUpTri m n := by
  rw [mem_hcUpTri_iff_frame j, (hcFrame_coords m n j s 2).1, (hcFrame_coords m n j s 2).2]
  exact ⟨le_rfl, by nlinarith [Real.sqrt_nonneg 3]⟩

/-- The down triangle's side `t = 0`, `|s| ≤ 1/2`, in the frame of the edge it faces. -/
theorem hcFrame_mem_hcDownTri {m n : ℤ} (j : Fin 3) {s : ℝ} (hs : |s| ≤ 1 / 2) :
    hcFrame m n j s 0 ∈ hcDownTri (hcDn m n j).1 (hcDn m n j).2 := by
  rw [mem_hcDownTri_iff_frame j, (hcFrame_coords m n j s 0).1, (hcFrame_coords m n j s 0).2]
  exact ⟨le_rfl, by nlinarith [Real.sqrt_nonneg 3]⟩

/-- The segment's points in its frame. -/
theorem hcFrame_mem_hcSeg {m n : ℤ} (j : Fin 3) {s : ℝ} (hs : |s| ≤ 1 / 2) : hcFrame m n j s 1 ∈ hcSeg m n j :=
  ⟨s, ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩, rfl⟩

/-- `|ε/2| = 1/2` for `ε = ±1`. -/
theorem abs_half_sign {ε : ℝ} (hε : ε = 1 ∨ ε = -1) : |ε / 2| = 1 / 2 := by
  rcases hε with rfl | rfl <;> norm_num

/-- **B1, the sausage cover (flat skeleton)**: every point is within `1` of a flat triangle or a segment, or within `3/2` of a face
centre — the fundamental triangle `O C M` with H3's quadrilateral `Q ⊆ B̄(v, 1) ∪ B̄(e, 1)`, carried around each face by the 60°
rotations (`exists_near_hcFace`). -/
theorem hc_sausage_cover (z : ℂ) :
    (∃ m n : ℤ, infDist z (hcDownTri m n) ≤ 1) ∨ (∃ m n : ℤ, infDist z (hcUpTri m n) ≤ 1) ∨
      (∃ (m n : ℤ) (j : Fin 3), infDist z (hcSeg m n j) ≤ 1) ∨ ∃ m n : ℤ, dist z (hcFace m n) ≤ 3 / 2 := by
  rcases hc_cover z with ⟨m, n, h⟩ | ⟨m, n, j, h | h | h | ⟨ε, hε, -, τ, hτ, hd⟩⟩
  · exact Or.inr (Or.inr (Or.inr ⟨m, n, h⟩))
  · exact Or.inr (Or.inl ⟨m, n, by rw [infDist_zero_of_mem h]; exact zero_le_one⟩)
  · exact Or.inl ⟨_, _, by rw [infDist_zero_of_mem h]; exact zero_le_one⟩
  · refine Or.inr (Or.inr (Or.inl ⟨m, n, j, ?_⟩))
    obtain ⟨hs, ht0, ht2⟩ := h
    refine (infDist_le_dist_of_mem (hcFrame_mem_hcSeg j hs)).trans ?_
    rw [dist_eq_hcFrame m n j, (hcFrame_coords m n j _ 1).1, (hcFrame_coords m n j _ 1).2, sub_self]
    refine Real.sqrt_le_iff.2 ⟨zero_le_one, ?_⟩
    nlinarith
  · have hs := (abs_half_sign hε).le
    rcases hτ with rfl | rfl | rfl
    · exact Or.inl ⟨_, _, (infDist_le_dist_of_mem (hcFrame_mem_hcDownTri j hs)).trans hd.le⟩
    · exact Or.inr (Or.inr (Or.inl ⟨m, n, j, (infDist_le_dist_of_mem (hcFrame_mem_hcSeg j hs)).trans hd.le⟩))
    · exact Or.inr (Or.inl ⟨m, n, (infDist_le_dist_of_mem (hcFrame_mem_hcUpTri j hs)).trans hd.le⟩)

/-- **Lemma NL, the band points**: for `|s| < 1/2` and `2 < t′ < 2 + g(s)`, the point `(s, t′) + ν`, `ν` the unit normal
`(g′(s), −1)/√(1 + g′(s)²)` of the graph at `s`, lies in the band (the exterior disc of radius `5/4`, H5's constants). -/
theorem hc_lemmaNL_band {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ} (hs : |s| < 1 / 2) :
    ∀ t', 2 < t' → t' < 2 + g s →
      hcFrame m n j (s + deriv g s / √(1 + deriv g s ^ 2)) (t' - 1 / √(1 + deriv g s ^ 2)) ∈ hcBand g m n j := by
  have hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
  obtain ⟨-, gZ, ga, g64, ga8⟩ := hg.2.1 s hsI
  have hne := hcUp_nonempty hZc hZs hZi hl hr hg m n
  set a := deriv g s
  set N := √(1 + a ^ 2) with hN
  have hN2 : N ^ 2 = 1 + a ^ 2 := Real.sq_sqrt (by positivity)
  have hN1 : 1 ≤ N := by rw [hN]; exact Real.one_le_sqrt.2 (by nlinarith)
  have hNu : N ≤ 65 / 64 := by
    have ha2 : a ^ 2 ≤ 1 / 64 := by rw [← sq_abs]; nlinarith [abs_nonneg a]
    nlinarith
  have hN0 : 0 < N := by linarith
  -- the exterior disc about `c = (s, 2 + g s) + R ν`
  set c := hcFrame m n j (s + 5 / 4 * a / N) (2 + g s - 5 / 4 / N) with hc
  have hext : ∀ w ∈ hcUp g m n, 5 / 4 ≤ dist w c := by
    intro w hw
    obtain ⟨hSw, hTw, -⟩ := hcUp_frame hg hw j
    have hpar := hg.2.2.2 (hcFrameS m n j w) hSw s hsI
    rw [dist_eq_hcFrame m n j, hc, (hcFrame_coords m n j _ _).1, (hcFrame_coords m n j _ _).2]
    refine Real.le_sqrt_of_sq_le ?_
    set X := hcFrameS m n j w - s
    set Y := hcFrameT m n j w - 2 - g s
    have hq : -(X ^ 2 / 4) ≤ Y - a * X := by
      simp only [X, Y]; linarith
    -- `dist² − R² = X² + Y² + 2R(Y − aX)/N`
    have key : (hcFrameS m n j w - (s + 5 / 4 * a / N)) ^ 2 + (hcFrameT m n j w - (2 + g s - 5 / 4 / N)) ^ 2 - (5 / 4) ^ 2 =
        X ^ 2 + Y ^ 2 + 2 * (5 / 4) * (Y - a * X) / N := by
      simp only [X, Y]; field_simp; rw [hN2]; ring
    have hpos : 0 ≤ X ^ 2 + Y ^ 2 + 2 * (5 / 4) * (Y - a * X) / N := by
      rw [add_div' _ _ _ hN0.ne', le_div_iff₀ hN0, zero_mul]
      have h1 := mul_le_mul_of_nonneg_right hN1 (add_nonneg (sq_nonneg X) (sq_nonneg Y))
      nlinarith [sq_nonneg X, sq_nonneg Y]
    linarith
  -- the band points `p(t') = (s, t') + ν`, `2 < t' < 2 + g s`
  set P : ℝ → ℂ := fun t' => hcFrame m n j (s + a / N) (t' - 1 / N) with hP
  have hPband : ∀ t', 2 < t' → t' < 2 + g s → P t' ∈ hcBand g m n j := by
    intro t' h2 hgt
    have hη : 0 < 2 + g s - t' := by linarith
    have hsa : |s + a / N| < 1 / 2 := by
      have h1 : |a / N| ≤ |a| := by
        rw [abs_div, abs_of_pos hN0]; exact div_le_self (abs_nonneg a) hN1
      have h2 : |a| ≤ (1 / 2 - |s|) / 2 := ga.trans (by linarith [infDist_le_half_sub_abs hl hr hsI])
      linarith [abs_add_le s (a / N)]
    have hsaI : s + a / N ∈ Icc (-1 / 2 : ℝ) (1 / 2) :=
      ⟨by linarith [neg_abs_le (s + a / N)], by linarith [le_abs_self (s + a / N)]⟩
    have hinvN : 64 / 65 ≤ 1 / N := by rw [le_div_iff₀ hN0]; nlinarith
    have hinvN1 : 1 / N ≤ 1 := by rw [div_le_one hN0]; exact hN1
    have htop : t' - 1 / N < 2 := by linarith
    refine ⟨s + a / N, t' - 1 / N, hsa, by linarith, ?_, rfl⟩
    refine (lt_hcBandTop_iff hZc hZs hZi hl hr hg m n j hsaI htop).2 ?_
    obtain ⟨w, hw, hd⟩ := (isCompact_hcUp hg m n).exists_infDist_eq_dist hne (P t')
    rw [hd]
    have hpc : dist (P t') c < 1 / 4 := by
      show dist (hcFrame m n j (s + a / N) (t' - 1 / N)) (hcFrame m n j (s + 5 / 4 * a / N) (2 + g s - 5 / 4 / N)) < 1 / 4
      rw [dist_hcFrame, Real.sqrt_lt' (by norm_num)]
      have e : (s + a / N - (s + 5 / 4 * a / N)) ^ 2 + (t' - 1 / N - (2 + g s - 5 / 4 / N)) ^ 2 =
          1 / 16 - (2 + g s - t') / (2 * N) + (2 + g s - t') ^ 2 := by
        have e1 : (s + a / N - (s + 5 / 4 * a / N)) ^ 2 + (t' - 1 / N - (2 + g s - 5 / 4 / N)) ^ 2 =
            (1 + a ^ 2) / (16 * N ^ 2) - (2 + g s - t') / (2 * N) + (2 + g s - t') ^ 2 := by
          field_simp; ring
        rw [e1, ← hN2]; field_simp
      rw [e]
      have : (2 + g s - t') ^ 2 < (2 + g s - t') / (2 * N) := by
        rw [lt_div_iff₀ (by positivity)]; nlinarith
      linarith
    have h4 := hext w hw
    have h3 := dist_triangle w (P t') c
    rw [dist_comm w (P t')] at h3
    linarith
  exact hPband

/-- **Lemma NL**: a sliver point `(s, t)`, `2 < t ≤ 2 + g(s)`, is at distance `1` from a point of `cl Λ_e` (of `Λ_e` when
`t < 2 + g(s)`) — the exterior disc of radius `5/4`, H5's constants. -/
theorem hc_lemmaNL {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s t : ℝ} (hs : |s| < 1 / 2) (ht : 2 < t) (htg : t ≤ 2 + g s) :
    ∃ p ∈ closure (hcBand g m n j), dist (hcFrame m n j s t) p = 1 := by
  have hband := hc_lemmaNL_band hZc hZs hZi hl hr hg m n j hs
  set a := deriv g s
  set N := √(1 + a ^ 2) with hN
  have hN2 : N ^ 2 = 1 + a ^ 2 := Real.sq_sqrt (by positivity)
  have hN0 : 0 < N := Real.sqrt_pos.2 (by positivity)
  set P : ℝ → ℂ := fun t' => hcFrame m n j (s + a / N) (t' - 1 / N) with hP
  have hPz : ∀ t', dist (hcFrame m n j s t') (P t') = 1 := by
    intro t'
    show dist (hcFrame m n j s t') (hcFrame m n j (s + a / N) (t' - 1 / N)) = 1
    rw [dist_hcFrame, Real.sqrt_eq_one]
    field_simp; rw [hN2]; ring
  rcases lt_or_eq_of_le htg with hlt | heq
  · exact ⟨P t, subset_closure (hband t ht hlt), hPz t⟩
  · refine ⟨P t, ?_, hPz t⟩
    have hcont : Continuous P := by rw [hP]; exact continuous_hcFrame_t m n j _ |>.comp (by fun_prop)
    have htend : Tendsto P (𝓝[<] t) (𝓝 (P t)) := hcont.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
    refine mem_closure_of_tendsto htend ?_
    filter_upwards [Ioo_mem_nhdsLT ht] with t' ht'
    exact hband t' ht'.1 (by rw [← heq]; exact ht'.2)

/-- **Lemma NL, strictly inside the sliver**: for `2 < t < 2 + g(s)` the unit circle about `(s, t)` meets the open band. -/
theorem hc_lemmaNL_lt {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s t : ℝ} (hs : |s| < 1 / 2) (ht : 2 < t) (htg : t < 2 + g s) :
    ∃ p ∈ hcBand g m n j, dist (hcFrame m n j s t) p = 1 := by
  refine ⟨_, hc_lemmaNL_band hZc hZs hZi hl hr hg m n j hs t ht htg, ?_⟩
  have hN2 : √(1 + deriv g s ^ 2) ^ 2 = 1 + deriv g s ^ 2 := Real.sq_sqrt (by positivity)
  have hN0 : 0 < √(1 + deriv g s ^ 2) := Real.sqrt_pos.2 (by positivity)
  rw [dist_hcFrame, Real.sqrt_eq_one]
  field_simp; rw [hN2]; ring

/-- **The intermediate value theorem on a star-shaped set**: a set star-shaped about some point whose closure reaches both inside
and outside the unit circle about `p` meets that circle. -/
theorem exists_dist_eq_one_of_star {O : Set ℂ} {c : ℂ}
    (hstar : ∀ z ∈ O, ∀ t : ℝ, 0 ≤ t → t ≤ 1 → (1 - t) • c + t • z ∈ O) {p P₁ P₂ : ℂ} (h₁ : P₁ ∈ closure O)
    (h₂ : P₂ ∈ closure O) (hd₁ : dist p P₁ < 1) (hd₂ : 1 < dist p P₂) : ∃ q ∈ O, dist p q = 1 := by
  obtain ⟨a, haO, ha⟩ := Metric.mem_closure_iff.1 h₁ (1 - dist p P₁) (by linarith)
  obtain ⟨b, hbO, hb⟩ := Metric.mem_closure_iff.1 h₂ (dist p P₂ - 1) (by linarith)
  have hpa : dist p a < 1 := by linarith [dist_triangle p P₁ a]
  have hpb : 1 < dist p b := by linarith [dist_triangle p b P₂, dist_comm b P₂]
  have seg : ∀ z ∈ O, (dist p c ≤ 1 ∧ 1 ≤ dist p z) ∨ (dist p z ≤ 1 ∧ 1 ≤ dist p c) → ∃ q ∈ O, dist p q = 1 := by
    intro z hz hcase
    set f : ℝ → ℝ := fun t => dist p ((1 - t) • c + t • z) with hf
    have hfc : Continuous f := by
      apply continuous_const.dist
      exact ((continuous_const.sub continuous_id).smul continuous_const).add (continuous_id.smul continuous_const)
    have hf0 : f 0 = dist p c := by simp [hf]
    have hf1 : f 1 = dist p z := by simp [hf]
    have hmem : (1 : ℝ) ∈ f '' Icc 0 1 := by
      rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact intermediate_value_Icc zero_le_one hfc.continuousOn ⟨by rw [hf0]; exact h1, by rw [hf1]; exact h2⟩
      · exact intermediate_value_Icc' zero_le_one hfc.continuousOn ⟨by rw [hf1]; exact h1, by rw [hf0]; exact h2⟩
    obtain ⟨t, ⟨ht0, ht1⟩, hft⟩ := hmem
    exact ⟨_, hstar z hz t ht0 ht1, hft⟩
  rcases le_total (dist p c) 1 with h | h
  · exact seg b hbO (Or.inl ⟨h, hpb.le⟩)
  · exact seg a haO (Or.inr ⟨hpa.le, h⟩)

/-- `g` moves by at most `|Δs|/8` on `[−1/2, 1/2]` (G1). -/
theorem G1Bounds.sub_le {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) {x y : ℝ} (hx : x ∈ Icc (-1 / 2 : ℝ) (1 / 2))
    (hy : y ∈ Icc (-1 / 2 : ℝ) (1 / 2)) : g y - g x ≤ |y - x| / 8 := by
  have := Convex.norm_image_sub_le_of_norm_deriv_le (fun u _ => hg.1 u) (fun u hu => (hg.2.1 u hu).2.2.2.2)
    (convex_Icc _ _) hx hy
  rw [Real.norm_eq_abs, Real.norm_eq_abs] at this
  linarith [le_abs_self (g y - g x)]

/-- **`U°` is star-shaped about the up centroid** (shrinking scales `s` and moves `t` toward `2 + √3/6`; `|g′| ≤ 1/8`). -/
theorem hcUpO_star {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) :
    ∀ z ∈ hcUpO g m n, ∀ t : ℝ, 0 ≤ t → t ≤ 1 → (1 - t) • hcUpC m n + t • z ∈ hcUpO g m n := by
  intro z hz t ht0 ht1 k
  have h3 : (1.7 : ℝ) < √3 := by nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num), Real.sqrt_nonneg 3]
  have hc0 : hcL - √3 / 6 = 2 + √3 / 6 := by unfold hcL; ring
  have he : (1 - t) • hcUpC m n + t • z = z + ((1 - t : ℝ) : ℂ) * (hcUpC m n - z) := by
    simp only [Complex.real_smul]; push_cast; ring
  rw [he]
  obtain ⟨hT, hS⟩ := hcFrame_shrink m n k z (1 - t)
  obtain ⟨hSI, -, -⟩ := hcUp_frame hg (hcUpO_subset m n hz) k
  obtain ⟨h2, hg2⟩ := hz k
  rw [hT, hS, hc0]
  set S := hcFrameS m n k z
  set T := hcFrameT m n k z
  have hSI' : (1 - (1 - t)) * S ∈ Icc (-1 / 2 : ℝ) (1 / 2) := by
    constructor <;> nlinarith [hSI.1, hSI.2]
  have hl := hg.sub_le hSI hSI'
  have habs : |(1 - (1 - t)) * S - S| ≤ (1 - t) / 2 := by
    rw [show (1 - (1 - t)) * S - S = -((1 - t) * S) by ring, abs_neg, abs_mul, abs_of_nonneg (by linarith)]
    have : |S| ≤ 1 / 2 := abs_le.2 ⟨by linarith [hSI.1], hSI.2⟩
    nlinarith
  have hg64 := (hg.2.1 _ hSI).2.2.2.1
  have hg0 := (hg.2.1 _ hSI).1
  rcases eq_or_lt_of_le ht0 with rfl | htp
  · have e1 : (1 - (1 - (0 : ℝ))) * T + (1 - 0) * (2 + √3 / 6) = 2 + √3 / 6 := by ring
    have e2 : (1 - (1 - (0 : ℝ))) * S = 0 := by ring
    rw [e1, e2]
    have := (hg.2.1 0 ⟨by norm_num, by norm_num⟩).2.2.2.1
    constructor <;> linarith
  · constructor
    · nlinarith [mul_pos htp (show 0 < T - 2 by linarith)]
    · nlinarith [mul_pos htp (show 0 < T - 2 - g S by linarith)]

/-- The corners of an edge frame met by § 2.4's strict exclusion: the ends of the facing sides and of the segment, and the
two apexes. -/
noncomputable def hcCorner : Fin 8 → ℝ × ℝ :=
  ![(1 / 2, 0), (-1 / 2, 0), (1 / 2, 1), (-1 / 2, 1), (1 / 2, 2), (-1 / 2, 2), (0, -(√3 / 2)), (0, 2 + √3 / 2)]

example : hcCorner 6 = (0, -(√3 / 2)) ∧ hcCorner 3 = (-1 / 2, 1) := ⟨rfl, rfl⟩

/-- **The exceptional set of one edge frame** (§ 2.4, almost everywhere): the frame lines `t ∈ {0, 1, 2}` and `s = ±1/2`, the
graph of `ℓ`, the unit circles about the corners, and the frontiers of the two triangles and of `U` — a null set. -/
def hcNframe (g : ℝ → ℝ) (m n : ℤ) (j : Fin 3) : Set ℂ :=
  {z | hcFrameT m n j z = 0 ∨ hcFrameT m n j z = 1 ∨ hcFrameT m n j z = 2 ∨ hcFrameS m n j z = 1 / 2 ∨
      hcFrameS m n j z = -1 / 2} ∪
    {z | |hcFrameS m n j z| < 1 / 2 ∧ hcFrameT m n j z = hcBandTop g m n j (hcFrameS m n j z)} ∪
    {z | ∃ i : Fin 8, dist z (hcFrame m n j (hcCorner i).1 (hcCorner i).2) = 1} ∪
    (frontier (hcUpTri m n) ∪ frontier (hcDownTri (hcDn m n j).1 (hcDn m n j).2) ∪ frontier (hcUp g m n))

/-- **§ 2.4's exceptional set**: the circles of radius `1/2` and `3/2` about the face centres, and every edge frame's
exceptional set. -/
def hcN0 (g : ℝ → ℝ) : Set ℂ :=
  (⋃ (m : ℤ) (n : ℤ), (sphere (hcFace m n) (1 / 2) ∪ sphere (hcFace m n) (3 / 2))) ∪
    ⋃ (m : ℤ) (n : ℤ) (j : Fin 3), hcNframe g m n j

/-- **`K_Z`**: the unit circles about the points `(c, 1)`, `c ∈ Z`, of every segment. -/
def hcKZ (Z : Set ℝ) : Set ℂ := ⋃ (m : ℤ) (n : ℤ) (j : Fin 3), {z | ∃ c ∈ Z, dist z (hcFrame m n j c 1) = 1}

/-- A frame's exceptional set lies in `N₀`. -/
theorem mem_hcN0_of_frame {g : ℝ → ℝ} {m n : ℤ} {j : Fin 3} {z : ℂ} (h : z ∈ hcNframe g m n j) : z ∈ hcN0 g :=
  Or.inr (mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨j, h⟩⟩⟩)

example (g : ℝ → ℝ) {z : ℂ} (h : hcFrameT 0 0 0 z = 1) : z ∈ hcN0 g :=
  mem_hcN0_of_frame (j := 0) (Or.inl (Or.inl (Or.inl (Or.inr (Or.inl h)))))

example (Z : Set ℝ) (h : (0 : ℝ) ∈ Z) : hcFrame 0 0 0 0 1 + 1 ∈ hcKZ Z :=
  mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨0, ⟨0, h, by simp [dist_eq_norm]⟩⟩⟩⟩

/-- A frame's exceptional set is null. -/
theorem volume_hcNframe {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    volume (hcNframe g m n j) = 0 := by
  have hA : volume {z | hcFrameT m n j z = 0 ∨ hcFrameT m n j z = 1 ∨ hcFrameT m n j z = 2 ∨ hcFrameS m n j z = 1 / 2 ∨
      hcFrameS m n j z = -1 / 2} = 0 := by
    have : {z | hcFrameT m n j z = 0 ∨ hcFrameT m n j z = 1 ∨ hcFrameT m n j z = 2 ∨ hcFrameS m n j z = 1 / 2 ∨
        hcFrameS m n j z = -1 / 2} = {z | hcFrameT m n j z = (fun _ => (0 : ℝ)) (hcFrameS m n j z)} ∪
        {z | hcFrameT m n j z = (fun _ => (1 : ℝ)) (hcFrameS m n j z)} ∪
        {z | hcFrameT m n j z = (fun _ => (2 : ℝ)) (hcFrameS m n j z)} ∪ {z | hcFrameS m n j z = 1 / 2} ∪
        {z | hcFrameS m n j z = -1 / 2} := by
      ext z; simp only [mem_setOf_eq, mem_union, or_assoc]
    rw [this]
    exact measure_union_null (measure_union_null (measure_union_null (measure_union_null
      (volume_hcFrame_graph m n j continuous_const) (volume_hcFrame_graph m n j continuous_const))
      (volume_hcFrame_graph m n j continuous_const)) (volume_hcFrame_line m n j _)) (volume_hcFrame_line m n j _)
  have hB : volume {z | |hcFrameS m n j z| < 1 / 2 ∧ hcFrameT m n j z = hcBandTop g m n j (hcFrameS m n j z)} = 0 := by
    have hh : (-1 / 2 : ℝ) ≤ 1 / 2 := by norm_num
    set F : ℝ → ℝ := fun s => hcBandTop g m n j (projIcc (-1 / 2) (1 / 2) hh s) with hF
    have hFc : Continuous F :=
      (continuousOn_hcBandTop hZc hZs hZi hl hr hg m n j).comp_continuous (continuous_subtype_val.comp continuous_projIcc)
        fun s => (projIcc (-1 / 2) (1 / 2) hh s).2
    refine measure_mono_null (fun z hz => ?_) (volume_hcFrame_graph m n j hFc)
    obtain ⟨hs, ht⟩ := hz
    show hcFrameT m n j z = F (hcFrameS m n j z)
    rw [hF, ht]
    simp only
    rw [projIcc_of_mem hh ⟨by linarith [neg_abs_le (hcFrameS m n j z)], by linarith [le_abs_self (hcFrameS m n j z)]⟩]
  have hC : volume {z | ∃ i : Fin 8, dist z (hcFrame m n j (hcCorner i).1 (hcCorner i).2) = 1} = 0 := by
    have : {z | ∃ i : Fin 8, dist z (hcFrame m n j (hcCorner i).1 (hcCorner i).2) = 1} =
        ⋃ i : Fin 8, sphere (hcFrame m n j (hcCorner i).1 (hcCorner i).2) 1 := by
      ext z; simp only [mem_setOf_eq, mem_iUnion, mem_sphere]
    rw [this]
    exact measure_iUnion_null fun i => Measure.addHaar_sphere volume _ _
  have hD : volume (frontier (hcUpTri m n)) = 0 :=
    (show Convex ℝ (hcUpTri m n) from convex_convexHull ℝ _).addHaar_frontier (μ := volume)
  have hE : volume (frontier (hcDownTri (hcDn m n j).1 (hcDn m n j).2)) = 0 :=
    (show Convex ℝ (hcDownTri (hcDn m n j).1 (hcDn m n j).2) from convex_convexHull ℝ _).addHaar_frontier (μ := volume)
  exact measure_union_null (measure_union_null (measure_union_null hA hB) hC)
    (measure_union_null (measure_union_null hD hE) (volume_frontier_hcUp hg m n))

/-- **`N₀` is null** — it does not depend on the size of `Z`. -/
theorem volume_hcN0 {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : volume (hcN0 g) = 0 :=
  measure_union_null (measure_iUnion_null fun _ => measure_iUnion_null fun _ =>
      measure_union_null (Measure.addHaar_sphere volume _ _) (Measure.addHaar_sphere volume _ _))
    (measure_iUnion_null fun m => measure_iUnion_null fun n => measure_iUnion_null fun j =>
      volume_hcNframe hZc hZs hZi hl hr hg m n j)

/-- **`K_Z` is null when `Z` is** (a smooth image of `Z × ℝ`). -/
theorem volume_hcKZ {Z : Set ℝ} (hZm : MeasurableSet Z) (hZ0 : volume Z = 0) : volume (hcKZ Z) = 0 := by
  refine measure_iUnion_null fun m => measure_iUnion_null fun n => measure_iUnion_null fun j => ?_
  set f : ℂ → ℂ := fun w => hcFrame m n j w.re 1 + e w.im with hf
  set S : Set ℂ := {w | w.re ∈ Z} with hS
  have hS0 : volume S = 0 := by
    have : S = Complex.measurableEquivRealProd ⁻¹' (Z ×ˢ univ) := by ext w; simp [hS]
    rw [this, Complex.volume_preserving_equiv_real_prod.measure_preimage (hZm.prod MeasurableSet.univ).nullMeasurableSet,
      Measure.volume_eq_prod, Measure.prod_prod, hZ0, zero_mul]
  have hfd : DifferentiableOn ℝ f S := by
    refine Differentiable.differentiableOn ?_
    rw [hf]; unfold hcFrame e; fun_prop
  refine measure_mono_null (fun z hz => ?_) (addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero volume hfd hS0)
  obtain ⟨c, hc, hd⟩ := hz
  refine ⟨⟨c, Complex.arg (z - hcFrame m n j c 1)⟩, hc, ?_⟩
  have h := self_eq_norm_mul_e_arg (z - hcFrame m n j c 1)
  rw [← dist_eq_norm, hd, ofReal_one, one_mul] at h
  simp only [hf]
  rw [← h]; ring

/-- The segment lies in the closed band (`Z` has empty interior; the band is open over every gap). -/
theorem hcFrame_mem_closure_band {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {c : ℝ}
    (hc : c ∈ Icc (-1 / 2 : ℝ) (1 / 2)) : hcFrame m n j c 1 ∈ closure (hcBand g m n j) := by
  rw [Metric.mem_closure_iff]
  intro δ hδ
  set a := max (c - δ / 2) (-1 / 2)
  set b := min (c + δ / 2) (1 / 2)
  have hab : a < b := max_lt (lt_min (by linarith) (by linarith [hc.2])) (lt_min (by linarith [hc.1]) (by norm_num))
  have hnot : ¬ Ioo a b ⊆ Z := by
    intro h
    have := interior_maximal h isOpen_Ioo
    rw [hZi] at this
    exact (nonempty_Ioo.2 hab).ne_empty (subset_empty_iff.1 this)
  obtain ⟨s', ⟨hs'a, hs'b⟩, hs'Z⟩ := not_subset.1 hnot
  have ha1 : c - δ / 2 ≤ a := le_max_left _ _
  have ha2 : -1 / 2 ≤ a := le_max_right _ _
  have hb1 : b ≤ c + δ / 2 := min_le_left _ _
  have hb2 : b ≤ 1 / 2 := min_le_right _ _
  have hs'1 : |s'| < 1 / 2 := abs_lt.2 ⟨by linarith, by linarith⟩
  have hsI : s' ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith, by linarith⟩
  have hb := hcBandTop_bounds hZc hZs hZi hl hr hg m n j hsI
  have hℓ : 1 < hcBandTop g m n j s' := lt_of_le_of_ne hb.1 fun h => hs'Z (hb.2.2.1 h.symm)
  set η := min (δ / 2) ((hcBandTop g m n j s' - 1) / 2)
  have hη0 : 0 < η := lt_min (by linarith) (by linarith)
  have hη1 : η ≤ δ / 2 := min_le_left _ _
  have hη2 : η ≤ (hcBandTop g m n j s' - 1) / 2 := min_le_right _ _
  refine ⟨hcFrame m n j s' (1 + η), ⟨s', 1 + η, hs'1, by linarith, by linarith, rfl⟩, ?_⟩
  rw [dist_hcFrame, Real.sqrt_lt' hδ]
  have h1 : (c - s') ^ 2 < (δ / 2) ^ 2 := sq_lt_sq' (by linarith) (by linarith)
  have h2 : (1 - (1 + η)) ^ 2 ≤ (δ / 2) ^ 2 := by
    rw [show 1 - (1 + η) = -η by ring, neg_sq]; exact pow_le_pow_left₀ hη0.le hη1 2
  nlinarith

/-- **`K_Z` lies in HC's unit shadow** (`Z ⊆ σ`'s parameter interval, `σ ⊆ cl Λ`). -/
theorem hcKZ_subset {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : hcKZ Z ⊆ unitShadow (hcSet g) := by
  intro z hz
  simp only [hcKZ, mem_iUnion] at hz
  obtain ⟨m, n, j, c, hc, hd⟩ := hz
  refine ⟨hcFrame m n j c 1, ?_, hd⟩
  have := hcFrame_mem_closure_band hZc hZs hZi hl hr hg m n j (hZs hc)
  rw [hcSet_eq_iUnion, mem_iUnion]
  fin_cases j
  · exact ⟨(m, n, 2), this⟩
  · exact ⟨(m, n, 3), this⟩
  · exact ⟨(m, n, 4), this⟩

open scoped Pointwise in

/-- **The unit shadow of a closed set is closed** (`F + S¹`, closed plus compact). -/
theorem isClosed_unitShadow {F : Set ℂ} (hF : IsClosed F) : IsClosed (unitShadow F) := by
  have : unitShadow F = sphere (0 : ℂ) 1 + F := by
    ext z
    simp only [unitShadow, mem_setOf_eq, Set.mem_add, mem_sphere_iff_norm, sub_zero]
    constructor
    · rintro ⟨y, hy, hd⟩; exact ⟨z - y, by rw [← dist_eq_norm]; exact hd, y, hy, by ring⟩
    · rintro ⟨a, ha, y, hy, rfl⟩; exact ⟨y, hy, by rw [dist_eq_norm, add_sub_cancel_right]; exact ha⟩
  rw [this]
  exact hF.add_left_of_isCompact (isCompact_sphere 0 1)

/-- Distance to a frame point, in frame coordinates. -/
theorem dist_hcFrame_right (m n : ℤ) (j : Fin 3) (z : ℂ) (a b : ℝ) :
    dist z (hcFrame m n j a b) = √((hcFrameS m n j z - a) ^ 2 + (hcFrameT m n j z - b) ^ 2) := by
  rw [dist_eq_hcFrame m n j, (hcFrame_coords m n j a b).1, (hcFrame_coords m n j a b).2]

/-- The frame map is affine. -/
theorem hcFrame_combo (m n : ℤ) (j : Fin 3) (a b c d l : ℝ) :
    (1 - l) • hcFrame m n j a b + l • hcFrame m n j c d = hcFrame m n j ((1 - l) * a + l * c) ((1 - l) * b + l * d) := by
  simp only [hcFrame, Complex.real_smul]; push_cast; ring

/-- Each block lies in HC. -/
theorem hcBlock_subset_hcSet (g : ℝ → ℝ) (m n : ℤ) (k : Fin 6) : hcBlock g m n k ⊆ hcSet g := by
  rw [hcSet_eq_iUnion]; exact subset_iUnion_of_subset (m, n, k) le_rfl

/-- `U°` lies in `int HC`. -/
theorem hcUpO_subset_interior {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) :
    hcUpO g m n ⊆ interior (hcSet g) :=
  interior_maximal ((hcUpO_subset m n).trans (hcBlock_subset_hcSet g m n 1)) (isOpen_hcUpO hg m n)

/-- The band lies in `int HC`. -/
theorem hcBand_subset_interior {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    hcBand g m n j ⊆ interior (hcSet g) := by
  refine interior_maximal (subset_closure.trans ?_) (isOpen_hcBand hZc hZs hZi hl hr hg m n j)
  fin_cases j
  · exact hcBlock_subset_hcSet g m n 2
  · exact hcBlock_subset_hcSet g m n 3
  · exact hcBlock_subset_hcSet g m n 4

/-- The interior of a down triangle lies in `int HC`. -/
theorem interior_hcDownTri_subset (g : ℝ → ℝ) (a b : ℤ) : interior (hcDownTri a b) ⊆ interior (hcSet g) :=
  interior_mono (hcBlock_subset_hcSet g a b 0)

/-- `g` vanishes at `±1/2`. -/
theorem G1Bounds.eq_zero_of_mem {Z : Set ℝ} {g : ℝ → ℝ} (hg : G1Bounds Z g) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) {s : ℝ}
    (hs : s ∈ Z) : g s = 0 := by
  have h := hg.2.1 s (hZs hs)
  rw [infDist_zero_of_mem hs] at h
  linarith [h.1, h.2.1]

/-- The corners `(±1/2, 2)` of an up triangle lie in `U`. -/
theorem hcFrame_corner_mem_hcUp {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ}
    (hs : |s| = 1 / 2) : hcFrame m n j s 2 ∈ hcUp g m n := by
  have hsZ : s ∈ Z := by rcases abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 2) |>.1 hs with rfl | rfl; exacts [hr, by convert hl using 1; ring]
  have h := hcUp_slivers hZc hZs hZi hl hr hg m n j (hZs hsZ)
  rwa [hg.eq_zero_of_mem hZs hsZ, add_zero] at h

/-- The apex `(0, 2 + √3/2)` of an up triangle lies in `U` (in the other two frames it is a corner `(±1/2, 2)`). -/
theorem hcFrame_apex_mem_hcUp {Z : Set ℝ} (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z)
    {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    hcFrame m n j 0 (2 + √3 / 2) ∈ hcUp g m n := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h17 : (1.7 : ℝ) < √3 := by nlinarith [Real.sqrt_nonneg 3]
  refine ⟨(mem_hcUpTri_iff_frame j).2 ?_, fun k => ?_⟩
  · rw [(hcFrame_coords m n j _ _).1, (hcFrame_coords m n j _ _).2]; exact ⟨by linarith, by simp⟩
  · by_cases hjk : j = k
    · subst hjk
      rw [(hcFrame_coords m n j _ _).1, (hcFrame_coords m n j _ _).2]
      have := (hg.2.1 0 ⟨by norm_num, by norm_num⟩).2.2.2.1
      linarith
    · obtain ⟨ε, hε, hT, hS⟩ := hcFrame_other m n hjk (hcFrame m n j 0 (2 + √3 / 2))
      rw [(hcFrame_coords m n j _ _).1, (hcFrame_coords m n j _ _).2] at hT hS
      have hS' : |hcFrameS m n k (hcFrame m n j 0 (2 + √3 / 2))| = 1 / 2 := by
        rw [hS]; rcases hε with rfl | rfl
        · rw [show -(1 * (√3 / 2) * (2 + √3 / 6 - (2 + √3 / 2))) - 0 / 2 = 1 / 2 by linear_combination (1 / 6) * h3]
          norm_num
        · rw [show -(-1 * (√3 / 2) * (2 + √3 / 6 - (2 + √3 / 2))) - 0 / 2 = -(1 / 2) by linear_combination (-1 / 6) * h3]
          norm_num
      have hsZ : hcFrameS m n k (hcFrame m n j 0 (2 + √3 / 2)) ∈ Z := by
        rcases abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 2) |>.1 hS' with h | h
        · rw [h]; exact hr
        · rw [h]; convert hl using 1; ring
      rw [hg.eq_zero_of_mem hZs hsZ, hT]
      linarith

/-- **The segment's exclusion, strictly** (§ 2.4, `E°_σ ∖ N_e`): if the unit circle about `z` has a point of `σ` strictly inside and
an end of `σ` strictly outside, then `z` lies on a frame line `t ∈ {0, 1, 2}`, or on a unit circle about a point of `Z × {1}`,
or the circle meets the open band (the secant crosses `σ` at `(s′, 1)`, `s′ ∉ Z`, into `t > 1`, where it runs below `ℓ`). -/
theorem hc_seg_exclusion {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {j : Fin 3} {z : ℂ}
    {s₁ s₂ : ℝ} (hs₁ : |s₁| ≤ 1 / 2) (hs₂ : |s₂| = 1 / 2) (hd₁ : dist z (hcFrame m n j s₁ 1) < 1)
    (hd₂ : 1 < dist z (hcFrame m n j s₂ 1)) :
    z ∈ hcNframe g m n j ∨ z ∈ hcKZ Z ∨ ∃ y ∈ hcBand g m n j, dist z y = 1 := by
  set s := hcFrameS m n j z with hs
  set t := hcFrameT m n j z with ht
  by_cases hline : t = 0 ∨ t = 1 ∨ t = 2
  · left
    refine Or.inl (Or.inl (Or.inl ?_))
    rcases hline with h | h | h
    · exact Or.inl h
    · exact Or.inr (Or.inl h)
    · exact Or.inr (Or.inr (Or.inl h))
  push Not at hline
  obtain ⟨ht0, ht1, ht2⟩ := hline
  -- the crossing point `s′`
  set f : ℝ → ℝ := fun u => dist z (hcFrame m n j u 1) with hf
  have hfc : Continuous f := continuous_const.dist (continuous_hcFrame_s m n j 1)
  obtain ⟨s', hs'I, hs'f⟩ : ∃ s' ∈ uIcc s₁ s₂, f s' = 1 :=
    intermediate_value_uIcc hfc.continuousOn (mem_uIcc.2 (Or.inl ⟨hd₁.le, hd₂.le⟩))
  have hs'1 : s' ≠ s₁ := fun h => by rw [h] at hs'f; exact absurd hs'f (ne_of_lt hd₁)
  have hs'2 : s' ≠ s₂ := fun h => by rw [h] at hs'f; exact absurd hs'f (ne_of_gt hd₂)
  have hs'a : |s'| < 1 / 2 := by
    obtain ⟨h1, h2⟩ := abs_le.1 hs₁
    rcases abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 2) |>.1 hs₂ with h | h <;> subst h
    · rw [uIcc_of_le h2] at hs'I
      exact abs_lt.2 ⟨by linarith [hs'I.1, lt_of_le_of_ne hs'I.1 (Ne.symm hs'1)], lt_of_le_of_ne hs'I.2 hs'2⟩
    · rw [uIcc_of_ge h1] at hs'I
      exact abs_lt.2 ⟨lt_of_le_of_ne hs'I.1 (Ne.symm hs'2), by linarith [lt_of_le_of_ne hs'I.2 hs'1]⟩
  have hs'I' : s' ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s'], by linarith [le_abs_self s']⟩
  by_cases hZ : s' ∈ Z
  · exact Or.inr (Or.inl (mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, mem_iUnion.2 ⟨j, ⟨s', hZ, hs'f⟩⟩⟩⟩))
  right; right
  -- the band holds a box over `s′`
  have hb := hcBandTop_bounds hZc hZs hZi hl hr hg m n j hs'I'
  have hℓ : 1 < hcBandTop g m n j s' := lt_of_le_of_ne hb.1 fun h => hZ (hb.2.2.1 h.symm)
  have hca : ContinuousAt (hcBandTop g m n j) s' :=
    (continuousOn_hcBandTop hZc hZs hZi hl hr hg m n j).continuousAt
      (Icc_mem_nhds (by linarith [neg_abs_le s']) (by linarith [le_abs_self s']))
  obtain ⟨δ, hδ, hδℓ⟩ := Metric.continuousAt_iff.1 hca ((hcBandTop g m n j s' - 1) / 2) (by linarith)
  set η := min δ (min ((hcBandTop g m n j s' - 1) / 2) (1 / 2 - |s'|)) with hη
  have hη0 : 0 < η := lt_min hδ (lt_min (by linarith) (by linarith))
  have hηδ : η ≤ δ := min_le_left _ _
  have hηℓ : η ≤ (hcBandTop g m n j s' - 1) / 2 := (min_le_right _ _).trans (min_le_left _ _)
  have hηs : η ≤ 1 / 2 - |s'| := (min_le_right _ _).trans (min_le_right _ _)
  set R : Set ℂ := {w | ∃ u v : ℝ, |u - s'| < η ∧ 1 < v ∧ v < 1 + η ∧ w = hcFrame m n j u v} with hR
  have hRband : R ⊆ hcBand g m n j := by
    rintro _ ⟨u, v, hu, hv1, hv2, rfl⟩
    have hu' : dist u s' < δ := by rw [Real.dist_eq]; linarith
    have := hδℓ hu'
    rw [Real.dist_eq, abs_lt] at this
    refine ⟨u, v, ?_, hv1, by linarith [this.1], rfl⟩
    have := abs_sub_abs_le_abs_sub u s'
    linarith
  have hstar : ∀ w ∈ R, ∀ l : ℝ, 0 ≤ l → l ≤ 1 → (1 - l) • hcFrame m n j s' (1 + η / 2) + l • w ∈ R := by
    rintro _ ⟨u, v, hu, hv1, hv2, rfl⟩ l hl0 hl1
    rw [hcFrame_combo]
    refine ⟨_, _, ?_, by nlinarith, by nlinarith, rfl⟩
    rw [show (1 - l) * s' + l * u - s' = l * (u - s') by ring, abs_mul, abs_of_nonneg hl0]
    rcases eq_or_lt_of_le hl0 with rfl | hlp
    · simpa using hη0
    · nlinarith [abs_nonneg (u - s')]
  have hcl : ∀ h : ℝ, |h| < η → hcFrame m n j (s' + h) 1 ∈ closure R := by
    intro h hh
    rw [Metric.mem_closure_iff]
    intro ε hε
    refine ⟨hcFrame m n j (s' + h) (1 + min ε η / 2), ⟨s' + h, _, by simpa using hh,
      by linarith [lt_min hε hη0], by linarith [min_le_right ε η], rfl⟩, ?_⟩
    rw [dist_hcFrame, Real.sqrt_lt' hε]
    have := min_le_left ε η
    nlinarith [lt_min hε hη0]
  -- the crossing is transversal (`t ∉ {0, 2}`): points of `σ` on either side of `s′`
  have hf' : (s - s') ^ 2 + (t - 1) ^ 2 = 1 := by
    have := hs'f
    simp only [hf, dist_hcFrame_right] at this
    rw [Real.sqrt_eq_one] at this; exact this
  have hd0 : s - s' ≠ 0 := by
    intro h
    rw [h] at hf'
    have : (t - 2) * t = 0 := by nlinarith
    rcases mul_eq_zero.1 this with h'' | h''
    · exact ht2 (by linarith)
    · exact ht0 h''
  have hd1 : |s - s'| ≤ 1 := by
    have : (s - s') ^ 2 ≤ 1 := by nlinarith [sq_nonneg (t - 1)]
    exact abs_le.2 ⟨by nlinarith, by nlinarith⟩
  set κ := min 1 (η / 2) with hκ
  have hκ0 : 0 < κ := lt_min one_pos (by linarith)
  have hκ1 : κ ≤ 1 := min_le_left _ _
  have hκη : κ ≤ η / 2 := min_le_right _ _
  have hκh : |κ * (s - s')| < η := by
    rw [abs_mul, abs_of_pos hκ0]; nlinarith [abs_nonneg (s - s')]
  have hκh' : |-(κ * (s - s'))| < η := by rwa [abs_neg]
  have hds : 0 < (s - s') ^ 2 := by positivity
  have e1 : (s - (s' + κ * (s - s'))) ^ 2 + (t - 1) ^ 2 = 1 - κ * (2 - κ) * (s - s') ^ 2 := by
    linear_combination hf'
  have e2 : (s - (s' + -(κ * (s - s')))) ^ 2 + (t - 1) ^ 2 = 1 + κ * (2 + κ) * (s - s') ^ 2 := by
    linear_combination hf'
  have p1 : 0 < κ * (2 - κ) * (s - s') ^ 2 := mul_pos (mul_pos hκ0 (by linarith)) hds
  have p2 : 0 < κ * (2 + κ) * (s - s') ^ 2 := mul_pos (mul_pos hκ0 (by linarith)) hds
  obtain ⟨q, hqR, hq⟩ := exists_dist_eq_one_of_star hstar (hcl _ hκh) (hcl _ hκh')
    (by rw [dist_hcFrame_right, Real.sqrt_lt' one_pos, e1]; linarith)
    (by rw [dist_hcFrame_right, Real.lt_sqrt (by norm_num), e2]; linarith)
  exact ⟨q, hRband hqR, hq⟩

/-- (C0) in frame coordinates: the down apex excludes the lower half of the closed vesica of `σ`'s ends. -/
theorem hc_c0 {s t : ℝ} (h1 : (s + 1 / 2) ^ 2 + (t - 1) ^ 2 ≤ 1) (h2 : (s - 1 / 2) ^ 2 + (t - 1) ^ 2 ≤ 1) (ht : t ≤ 1) :
    1 ≤ s ^ 2 + (t + √3 / 2) ^ 2 := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  have hsum : s ^ 2 + (t - 1) ^ 2 ≤ 3 / 4 := by nlinarith
  have ht' : 1 - t ≤ √3 / 2 := by
    by_contra hcon
    push Not at hcon
    nlinarith [sq_nonneg s]
  nlinarith [sq_nonneg s]

/-- A point at distance less than `1` from the down apex and on the band's near side has an end of `σ` beyond `1`. -/
theorem hc_c0_end (m n : ℤ) (j : Fin 3) {z : ℂ} (ht : hcFrameT m n j z ≤ 1)
    (h : dist z (hcFrame m n j 0 (-(√3 / 2))) < 1) :
    1 < dist z (hcFrame m n j (1 / 2) 1) ∨ 1 < dist z (hcFrame m n j (-1 / 2) 1) := by
  rw [dist_hcFrame_right, Real.sqrt_lt' one_pos] at h
  rw [dist_hcFrame_right, dist_hcFrame_right, Real.lt_sqrt (by norm_num), Real.lt_sqrt (by norm_num)]
  by_contra hcon
  push Not at hcon
  have := hc_c0 (s := hcFrameS m n j z) (t := hcFrameT m n j z) (by linarith [hcon.2]) (by linarith [hcon.1]) ht
  linarith

/-- The mirror: at distance less than `1` from the up apex, on the band's far side. -/
theorem hc_c0_end' (m n : ℤ) (j : Fin 3) {z : ℂ} (ht : 1 ≤ hcFrameT m n j z)
    (h : dist z (hcFrame m n j 0 (2 + √3 / 2)) < 1) :
    1 < dist z (hcFrame m n j (1 / 2) 1) ∨ 1 < dist z (hcFrame m n j (-1 / 2) 1) := by
  rw [dist_hcFrame_right, Real.sqrt_lt' one_pos] at h
  rw [dist_hcFrame_right, dist_hcFrame_right, Real.lt_sqrt (by norm_num), Real.lt_sqrt (by norm_num)]
  by_contra hcon
  push Not at hcon
  have := hc_c0 (s := hcFrameS m n j z) (t := 2 - hcFrameT m n j z) (by nlinarith [hcon.2]) (by nlinarith [hcon.1])
    (by linarith)
  nlinarith

/-- The strict exclusion's conclusion, lifted from one frame. -/
theorem hc_se_lift {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {j : Fin 3} {z : ℂ}
    (h : z ∈ hcNframe g m n j ∨ z ∈ hcKZ Z ∨ ∃ y ∈ hcBand g m n j, dist z y = 1) :
    z ∈ hcN0 g ∨ z ∈ hcKZ Z ∨ ∃ y ∈ interior (hcSet g), dist z y = 1 := by
  rcases h with h | h | ⟨y, hy, hd⟩
  · exact Or.inl (mem_hcN0_of_frame h)
  · exact Or.inr (Or.inl h)
  · exact Or.inr (Or.inr ⟨y, hcBand_subset_interior hZc hZs hZi hl hr hg m n j hy, hd⟩)

/-- The interior of a down triangle is star-shaped about its centroid, and its closure is the triangle. -/
theorem hcDownTri_interior_star (a b : ℤ) :
    (∀ z ∈ interior (hcDownTri a b), ∀ l : ℝ, 0 ≤ l → l ≤ 1 → (1 - l) • hcDownC a b + l • z ∈ interior (hcDownTri a b)) ∧
      closure (interior (hcDownTri a b)) = hcDownTri a b := by
  have hc : hcDownC a b ∈ interior (hcDownTri a b) :=
    interior_maximal (ball_subset_hcDownTri a b) isOpen_ball (mem_ball_self (by norm_num))
  have hconv : Convex ℝ (interior (hcDownTri a b)) := (convex_convexHull ℝ _).interior
  refine ⟨fun z hz l hl0 hl1 => hconv hc hz (by linarith) hl0 (by ring), ?_⟩
  rw [(show Convex ℝ (hcDownTri a b) from convex_convexHull ℝ _).closure_interior_eq_closure_of_nonempty_interior ⟨_, hc⟩,
    (isCompact_hcDownTri a b).isClosed.closure_eq]

/-- **The slab's exclusion, strictly** (§ 2.4, cases 3–5 in the edge's slab `|s| ≤ 1/2, 0 ≤ t ≤ 2`). -/
theorem hc_se_slab {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {j : Fin 3} {z : ℂ}
    (hz : z ∉ interior (hcSet g)) (hs : |hcFrameS m n j z| ≤ 1 / 2) (ht0 : 0 ≤ hcFrameT m n j z)
    (ht2 : hcFrameT m n j z ≤ 2) : z ∈ hcN0 g ∨ z ∈ hcKZ Z ∨ ∃ y ∈ interior (hcSet g), dist z y = 1 := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h17 : (1.7 : ℝ) < √3 := by nlinarith [Real.sqrt_nonneg 3]
  set s := hcFrameS m n j z with hsdef
  set t := hcFrameT m n j z with htdef
  have hzst : hcFrame m n j s t = z := hcFrame_hcFrameST m n j z
  by_cases hline : t = 0 ∨ t = 1 ∨ t = 2 ∨ s = 1 / 2 ∨ s = -1 / 2
  · exact Or.inl (mem_hcN0_of_frame (j := j) (Or.inl (Or.inl (Or.inl hline))))
  push Not at hline
  obtain ⟨h0, h1, h2, hs1, hs2⟩ := hline
  have htpos : 0 < t := lt_of_le_of_ne ht0 (Ne.symm h0)
  have hs' : |s| < 1 / 2 := by
    refine lt_of_le_of_ne hs fun h => ?_
    rcases abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 2) |>.1 h with h | h
    · exact hs1 h
    · exact hs2 (by rw [h]; ring)
  have hdσ : dist z (hcFrame m n j s 1) = |t - 1| := by
    rw [dist_hcFrame_right, sub_self, sq, zero_mul, zero_add, Real.sqrt_sq_eq_abs]
  rcases lt_or_gt_of_ne h1 with htl | htg
  · -- below `σ`: the down triangle, or `σ`
    rcases lt_trichotomy (dist z (hcFrame m n j 0 (-(√3 / 2)))) 1 with h | h | h
    · have hend := hc_c0_end m n j htl.le h
      refine hc_se_lift (m := m) (n := n) (j := j) hZc hZs hZi hl hr hg ?_
      have hd1 : dist z (hcFrame m n j s 1) < 1 := by rw [hdσ, abs_of_neg (by linarith)]; linarith
      rcases hend with he | he
      · exact hc_seg_exclusion hZc hZs hZi hl hr hg hs (by norm_num) hd1 he
      · exact hc_seg_exclusion hZc hZs hZi hl hr hg hs (by norm_num) hd1 he
    · exact Or.inl (mem_hcN0_of_frame (j := j) (Or.inl (Or.inr ⟨6, h⟩)))
    · obtain ⟨hstar, hcl⟩ := hcDownTri_interior_star (hcDn m n j).1 (hcDn m n j).2
      have hP1 : hcFrame m n j s 0 ∈ closure (interior (hcDownTri (hcDn m n j).1 (hcDn m n j).2)) := by
        rw [hcl]; exact hcFrame_mem_hcDownTri j hs
      have hP2 : hcFrame m n j 0 (-(√3 / 2)) ∈ closure (interior (hcDownTri (hcDn m n j).1 (hcDn m n j).2)) := by
        rw [hcl, mem_hcDownTri_iff_frame j, (hcFrame_coords m n j _ _).1, (hcFrame_coords m n j _ _).2]
        exact ⟨by linarith [Real.sqrt_nonneg 3], by simp⟩
      have hd1 : dist z (hcFrame m n j s 0) < 1 := by
        rw [dist_hcFrame_right, sub_self, sq, zero_mul, zero_add, sub_zero, Real.sqrt_sq_eq_abs, abs_of_nonneg ht0]
        exact htl
      obtain ⟨y, hy, hd⟩ := exists_dist_eq_one_of_star hstar hP1 hP2 hd1 h
      exact Or.inr (Or.inr ⟨y, interior_hcDownTri_subset g _ _ hy, hd⟩)
  · -- above `σ`: the band, its top, or `U`
    have hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
    have ht2' : t < 2 := lt_of_le_of_ne ht2 h2
    rcases lt_trichotomy t (hcBandTop g m n j s) with hb | hb | hb
    · exact absurd (hcBand_subset_interior hZc hZs hZi hl hr hg m n j ⟨s, t, hs', htg, hb, hzst.symm⟩) hz
    · exact Or.inl (mem_hcN0_of_frame (j := j) (Or.inl (Or.inl (Or.inr ⟨hs', hb⟩))))
    · have hne := hcUp_nonempty hZc hZs hZi hl hr hg m n
      have hdU : infDist z (hcUp g m n) < 1 := by
        have hl1 : hcBandTop g m n j s < (hcBandTop g m n j s + t) / 2 := by linarith
        have hl2 : (hcBandTop g m n j s + t) / 2 < t := by linarith
        have h1' : infDist (hcFrame m n j s ((hcBandTop g m n j s + t) / 2)) (hcUp g m n) ≤ 1 := by
          by_contra hc
          push Not at hc
          have := (lt_hcBandTop_iff hZc hZs hZi hl hr hg m n j hsI (by linarith)).2 hc
          linarith
        have := infDist_hcUp_strictAnti hg hne j s (t₁ := (hcBandTop g m n j s + t) / 2) (t₂ := t) hl2 ht2
        rw [hzst] at this
        linarith
      rcases lt_trichotomy (dist z (hcFrame m n j 0 (2 + √3 / 2))) 1 with h | h | h
      · have hend := hc_c0_end' m n j htg.le h
        refine hc_se_lift (m := m) (n := n) (j := j) hZc hZs hZi hl hr hg ?_
        have hd1 : dist z (hcFrame m n j s 1) < 1 := by rw [hdσ, abs_of_pos (by linarith)]; linarith
        rcases hend with he | he
        · exact hc_seg_exclusion hZc hZs hZi hl hr hg hs (by norm_num) hd1 he
        · exact hc_seg_exclusion hZc hZs hZi hl hr hg hs (by norm_num) hd1 he
      · exact Or.inl (mem_hcN0_of_frame (j := j) (Or.inl (Or.inr ⟨7, h⟩)))
      · obtain ⟨u, hu, hdu⟩ := (isCompact_hcUp hg m n).exists_infDist_eq_dist hne z
        obtain ⟨y, hy, hd⟩ := exists_dist_eq_one_of_star (hcUpO_star hg m n) (hcUp_subset_closure_hcUpO hg m n hu)
          (hcUp_subset_closure_hcUpO hg m n (hcFrame_apex_mem_hcUp hZs hl hr hg m n j)) (hdu ▸ hdU) h
        exact Or.inr (Or.inr ⟨y, hcUpO_subset_interior hg m n hy, hd⟩)

/-- **The corners' exclusion, strictly** (B1's near corners: the far corner of the same side is beyond `1`). -/
theorem hc_se_corner {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {j : Fin 3} {z : ℂ}
    {ε : ℝ} (hε : ε = 1 ∨ ε = -1) (hεs : 1 / 2 < ε * hcFrameS m n j z) {τ : ℝ} (hτ : τ = 0 ∨ τ = 1 ∨ τ = 2)
    (hd : dist z (hcFrame m n j (ε / 2) τ) < 1) : z ∈ hcN0 g ∨ z ∈ hcKZ Z ∨ ∃ y ∈ interior (hcSet g), dist z y = 1 := by
  have hε2 : ε * ε = 1 := by rcases hε with rfl | rfl <;> norm_num
  have hfar : 1 < dist z (hcFrame m n j (-ε / 2) τ) := by
    rw [dist_hcFrame_right, Real.lt_sqrt (by norm_num)]
    have : (hcFrameS m n j z - -ε / 2) ^ 2 = (ε * hcFrameS m n j z + 1 / 2) ^ 2 := by
      linear_combination (1 / 4 - hcFrameS m n j z ^ 2) * hε2
    nlinarith [sq_nonneg (hcFrameS m n j z - τ), sq_nonneg (hcFrameT m n j z - τ)]
  have hs1 : |ε / 2| = 1 / 2 := abs_half_sign hε
  have hs2 : |-ε / 2| = 1 / 2 := by rw [neg_div, abs_neg]; exact hs1
  rcases hτ with rfl | rfl | rfl
  · obtain ⟨hstar, hcl⟩ := hcDownTri_interior_star (hcDn m n j).1 (hcDn m n j).2
    obtain ⟨y, hy, hd'⟩ := exists_dist_eq_one_of_star hstar (by rw [hcl]; exact hcFrame_mem_hcDownTri j hs1.le)
      (by rw [hcl]; exact hcFrame_mem_hcDownTri j hs2.le) hd hfar
    exact Or.inr (Or.inr ⟨y, interior_hcDownTri_subset g _ _ hy, hd'⟩)
  · exact hc_se_lift hZc hZs hZi hl hr hg (hc_seg_exclusion hZc hZs hZi hl hr hg hs1.le hs2 hd hfar)
  · obtain ⟨y, hy, hd'⟩ := exists_dist_eq_one_of_star (hcUpO_star hg m n)
      (hcUp_subset_closure_hcUpO hg m n (hcFrame_corner_mem_hcUp hZc hZs hZi hl hr hg m n j hs1))
      (hcUp_subset_closure_hcUpO hg m n (hcFrame_corner_mem_hcUp hZc hZs hZi hl hr hg m n j hs2)) hd hfar
    exact Or.inr (Or.inr ⟨y, hcUpO_subset_interior hg m n hy, hd'⟩)

/-- **The up triangle's exclusion, strictly**: on `U`'s or the triangle's frontier, on a side line, or in a sliver (Lemma NL). -/
theorem hc_se_up {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {m n : ℤ} {z : ℂ}
    (hz : z ∉ interior (hcSet g)) (hT : z ∈ hcUpTri m n) :
    z ∈ hcN0 g ∨ z ∈ hcKZ Z ∨ ∃ y ∈ interior (hcSet g), dist z y = 1 := by
  by_cases hU : z ∈ hcUp g m n
  · refine Or.inl (mem_hcN0_of_frame (m := m) (n := n) (j := 0) (Or.inr (Or.inr ?_)))
    rw [(isCompact_hcUp hg m n).isClosed.frontier_eq]
    exact ⟨hU, fun hi => hz (interior_mono (hcBlock_subset_hcSet g m n 1) hi)⟩
  have : ∃ k : Fin 3, hcFrameT m n k z < 2 + g (hcFrameS m n k z) := by
    by_contra h
    push Not at h
    exact hU ⟨hT, h⟩
  obtain ⟨k, hk⟩ := this
  obtain ⟨hSk, hTk, -⟩ := hcUpTri_frame hT k
  by_cases h2 : hcFrameT m n k z = 2
  · exact Or.inl (mem_hcN0_of_frame (j := k) (Or.inl (Or.inl (Or.inl (Or.inr (Or.inr (Or.inl h2)))))))
  have h2' : 2 < hcFrameT m n k z := lt_of_le_of_ne hTk (Ne.symm h2)
  have hs' : |hcFrameS m n k z| < 1 / 2 := by
    refine lt_of_le_of_ne hSk fun h => ?_
    have hsZ : hcFrameS m n k z ∈ Z := by
      rcases abs_eq (by norm_num : (0 : ℝ) ≤ 1 / 2) |>.1 h with h' | h'
      · rw [h']; exact hr
      · rw [h']; convert hl using 1; ring
    rw [hg.eq_zero_of_mem hZs hsZ] at hk
    linarith
  obtain ⟨p, hp, hd⟩ := hc_lemmaNL_lt hZc hZs hZi hl hr hg m n k hs' h2' hk
  rw [hcFrame_hcFrameST] at hd
  exact Or.inr (Or.inr ⟨p, hcBand_subset_interior hZc hZs hZi hl hr hg m n k hp, hd⟩)

/-- **The face disc's exclusion, strictly**: within `3/2` of a face centre and outside `int HC`, the radial point. -/
theorem hc_se_face {Z : Set ℝ} {g : ℝ → ℝ} {m n : ℤ} {z : ℂ} (hz : z ∉ interior (hcSet g)) (h : dist z (hcFace m n) ≤ 3 / 2) :
    z ∈ hcN0 g ∨ z ∈ hcKZ Z ∨ ∃ y ∈ interior (hcSet g), dist z y = 1 := by
  have hball : ball (hcFace m n) (1 / 2) ⊆ interior (hcSet g) :=
    interior_maximal (ball_subset_closedBall.trans (hcBlock_subset_hcSet g m n 5)) isOpen_ball
  set d := dist z (hcFace m n) with hd
  have hface : ∀ r : ℝ, d = r → (r = 1 / 2 ∨ r = 3 / 2) → z ∈ hcN0 g := by
    rintro r hr (rfl | rfl)
    · exact Or.inl (mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, Or.inl (by rw [mem_sphere]; exact hr)⟩⟩)
    · exact Or.inl (mem_iUnion.2 ⟨m, mem_iUnion.2 ⟨n, Or.inr (by rw [mem_sphere]; exact hr)⟩⟩)
  rcases lt_trichotomy d (1 / 2) with h1 | h1 | h1
  · exact absurd (hball (by rw [mem_ball]; exact h1)) hz
  · exact Or.inl (hface _ h1 (Or.inl rfl))
  rcases eq_or_lt_of_le h with h2 | h2
  · exact Or.inl (hface _ h2 (Or.inr rfl))
  right; right
  have hd0 : 0 < d := by linarith
  refine ⟨z + ((1 / d : ℝ) : ℂ) * (hcFace m n - z), hball ?_, ?_⟩
  · rw [mem_ball, dist_eq_norm, show z + ((1 / d : ℝ) : ℂ) * (hcFace m n - z) - hcFace m n =
      ((1 - 1 / d : ℝ) : ℂ) * (z - hcFace m n) by push_cast; ring, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      ← dist_eq_norm, ← hd]
    have : |1 - 1 / d| * d = |d - 1| := by
      rw [← abs_of_pos hd0, ← abs_mul, abs_of_pos hd0]; congr 1; field_simp
    rw [this, abs_lt]; constructor <;> linarith
  · rw [dist_eq_norm, show z - (z + ((1 / d : ℝ) : ℂ) * (hcFace m n - z)) = ((1 / d : ℝ) : ℂ) * (z - hcFace m n) by ring,
      norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by positivity), ← dist_eq_norm, ← hd]
    field_simp

/-- **B2 strictly — the strict exclusion** (§ 2.4): every point outside `int HC` lies in the null set `N₀`, or on a unit circle
about a point of `Z × {1}` of some segment, or at distance `1` from a point of `int HC`. -/
theorem hc_strict_exclusion {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {z : ℂ}
    (hz : z ∉ interior (hcSet g)) : z ∈ hcN0 g ∨ z ∈ hcKZ Z ∨ ∃ y ∈ interior (hcSet g), dist z y = 1 := by
  rcases hc_cover z with ⟨m, n, h⟩ | ⟨m, n, j, h | h | ⟨hs, ht0, ht2⟩ | ⟨ε, hε, hεs, τ, hτ, hd⟩⟩
  · exact hc_se_face hz h
  · exact hc_se_up hZc hZs hZi hl hr hg hz h
  · refine Or.inl (mem_hcN0_of_frame (m := m) (n := n) (j := j) (Or.inr (Or.inl (Or.inr ?_))))
    rw [(isCompact_hcDownTri _ _).isClosed.frontier_eq]
    exact ⟨h, fun hi => hz (interior_hcDownTri_subset g _ _ hi)⟩
  · exact hc_se_slab hZc hZs hZi hl hr hg hz hs ht0 ht2
  · exact hc_se_corner hZc hZs hZi hl hr hg hε hεs hτ hd

/-- **B2, the exclusion**: every point outside `int HC` is at distance `1` from HC — B1's cases with (C0) (`vesica_apex` in the
edge frame, through `dist_hcFrame`), (G3) and Lemma NL. -/
theorem hc_exclusion {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {z : ℂ} (hz : z ∉ interior (hcSet g)) : z ∈ unitShadow (hcSet g) := by
  have hN := volume_hcN0 hZc hZs hZi hl hr hg
  have hsub : (hcSet g)ᶜ \ hcN0 g ⊆ unitShadow (hcSet g) := by
    rintro w ⟨hw, hwN⟩
    rcases hc_strict_exclusion hZc hZs hZi hl hr hg (fun hi => hw (interior_subset hi)) with h | h | ⟨y, hy, hd⟩
    · exact absurd h hwN
    · exact hcKZ_subset hZc hZs hZi hl hr hg h
    · exact ⟨y, interior_subset hy, hd⟩
  have hcl : z ∈ closure ((hcSet g)ᶜ \ hcN0 g) := by
    rw [Metric.mem_closure_iff]
    intro δ hδ
    have hz' : z ∈ closure (hcSet g)ᶜ := by rw [closure_compl]; exact hz
    obtain ⟨w, hw, hwd⟩ := Metric.mem_closure_iff.1 hz' δ hδ
    have hU : IsOpen ((hcSet g)ᶜ ∩ ball z δ) :=
      (isClosed_hcSet hZc hZs hZi hl hr hg).isOpen_compl.inter isOpen_ball
    have hpos : 0 < volume ((hcSet g)ᶜ ∩ ball z δ) := hU.measure_pos volume ⟨w, hw, by rw [mem_ball, dist_comm]; exact hwd⟩
    have : ¬ (hcSet g)ᶜ ∩ ball z δ ⊆ hcN0 g := fun h => by
      rw [measure_mono_null h hN] at hpos; exact lt_irrefl _ hpos
    obtain ⟨v, ⟨hv, hvb⟩, hvN⟩ := not_subset.1 this
    exact ⟨v, ⟨hv, hvN⟩, by rw [mem_ball, dist_comm] at hvb; exact hvb⟩
  exact closure_minimal hsub (isClosed_unitShadow (isClosed_hcSet hZc hZs hZi hl hr hg)) hcl

/-- **§ 2.4, almost everywhere**: with `Z` null, almost every point off `int HC` has `φ > 0` — the exclusion inequalities strict off
null level sets, `N_e = (Z × {1} + S¹) ∪ T₁(e±)` null, and `E°`-points see an open arc of a block's interior. -/
theorem hc_ae_phi_pos {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (hZ0 : volume Z = 0) :
    ∀ᵐ z ∂(volume.restrict (interior (hcSet g))ᶜ), 0 < phi (interior (hcSet g)) z := by
  have hnull : volume (hcN0 g ∪ hcKZ Z) = 0 :=
    measure_union_null (volume_hcN0 hZc hZs hZi hl hr hg) (volume_hcKZ hZc.measurableSet hZ0)
  have hae : ∀ᵐ z ∂volume, z ∉ hcN0 g ∪ hcKZ Z := measure_eq_zero_iff_ae_notMem.1 hnull
  rw [ae_restrict_iff' isOpen_interior.isClosed_compl.measurableSet]
  filter_upwards [hae] with z hzN hz
  rcases hc_strict_exclusion hZc hZs hZi hl hr hg hz with h | h | ⟨y, hy, hd⟩
  · exact absurd (Or.inl h) hzN
  · exact absurd (Or.inr h) hzN
  · exact phi_pos_of_mem_open isOpen_interior.measurableSet isOpen_interior subset_rfl hy hd

/-- An open set with no two points at distance `1` meets no unit circle about its closure (perturb the far end into the set). -/
theorem subset_compl_unitShadow_closure {U : Set ℂ} (hU : IsOpen U) (h : ∀ x ∈ U, ∀ y ∈ U, dist x y ≠ 1) :
    U ⊆ (unitShadow (closure U))ᶜ := by
  rintro x hx ⟨y, hy, hxy⟩
  obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.mp hU x hx
  obtain ⟨w, hwU, hwy⟩ := Metric.mem_closure_iff.1 hy (min δ (1 / 2)) (lt_min hδ (by norm_num))
  have hwy' : dist y w < δ := lt_of_lt_of_le hwy (min_le_left _ _)
  have hwy2 : dist y w < 1 / 2 := lt_of_lt_of_le hwy (min_le_right _ _)
  set d := dist x w with hd
  have hd1 : |d - 1| < δ := by
    have h1 := dist_triangle x y w
    have h2 := dist_triangle x w y
    rw [dist_comm w y] at h2
    rw [abs_lt]; constructor <;> linarith
  have hd0 : 0 < d := by
    have h2 := dist_triangle x w y
    rw [dist_comm w y] at h2
    linarith
  set x' : ℂ := w + ((1 / d : ℝ) : ℂ) * (x - w) with hx'
  have hx'w : dist x' w = 1 := by
    rw [dist_eq_norm, hx', add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity), ← dist_eq_norm, ← hd]
    field_simp
  have hx'x : dist x' x < δ := by
    have : x' - x = ((1 / d - 1 : ℝ) : ℂ) * (x - w) := by rw [hx']; push_cast; ring
    rw [dist_eq_norm, this, norm_mul, Complex.norm_real, Real.norm_eq_abs, ← dist_eq_norm, ← hd]
    have : |1 / d - 1| * d = |d - 1| := by
      have e : (1 / d - 1) * d = -(d - 1) := by field_simp; ring
      rw [← abs_neg (d - 1), ← e, abs_mul, abs_of_pos hd0]
    linarith
  exact h x' (hball (by rw [mem_ball]; exact hx'x)) w hwU hx'w

/-- The support of an open set is its closure. -/
theorem essSupport_of_isOpen {U : Set ℂ} (hU : IsOpen U) : essSupport U = closure U := by
  ext x
  constructor
  · intro hx
    rw [Metric.mem_closure_iff]
    intro r hr
    obtain ⟨y, hyU, hyb⟩ := nonempty_of_measure_ne_zero (hx r hr).ne'
    refine ⟨y, hyU, ?_⟩
    rw [mem_ball, dist_comm] at hyb
    exact hyb
  · intro hx r hr
    obtain ⟨y, hyU, hd⟩ := Metric.mem_closure_iff.1 hx r hr
    have hyb : y ∈ ball x r := by rw [mem_ball, dist_comm]; exact hd
    exact (hU.inter isOpen_ball).measure_pos volume ⟨y, hyU, hyb⟩

/-- The band over one gap is connected and separated from the bands over other gaps (§ 2.2 (G3): vertical fibres over a
connected base; an empty fibre at each point of `Z`). -/
theorem hcBand_component_iff {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s₁ t₁ s₂ t₂ : ℝ} (h₁ : hcFrame m n j s₁ t₁ ∈ hcBand g m n j)
    (h₂ : hcFrame m n j s₂ t₂ ∈ hcBand g m n j) :
    (∃ S ⊆ hcBand g m n j, IsPreconnected S ∧ hcFrame m n j s₁ t₁ ∈ S ∧ hcFrame m n j s₂ t₂ ∈ S) ↔
      Disjoint (uIcc s₁ s₂) Z := by
  -- band points: their frame coordinates
  have hcoord : ∀ x ∈ hcBand g m n j, |hcFrameS m n j x| < 1 / 2 ∧ 1 < hcFrameT m n j x ∧
      hcFrameT m n j x < hcBandTop g m n j (hcFrameS m n j x) := by
    rintro x ⟨s, t, hs, ht, ht', rfl⟩
    rw [(hcFrame_coords m n j s t).1, (hcFrame_coords m n j s t).2]; exact ⟨hs, ht, ht'⟩
  obtain ⟨hs₁, ht₁, ht₁'⟩ := hcoord _ h₁
  obtain ⟨hs₂, ht₂, ht₂'⟩ := hcoord _ h₂
  simp only [(hcFrame_coords m n j s₁ t₁).1, (hcFrame_coords m n j s₁ t₁).2] at hs₁ ht₁ ht₁'
  simp only [(hcFrame_coords m n j s₂ t₂).1, (hcFrame_coords m n j s₂ t₂).2] at hs₂ ht₂ ht₂'
  have hI : ∀ s : ℝ, |s| < 1 / 2 → s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := fun s hs =>
    ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
  have hnotZ : ∀ x ∈ hcBand g m n j, hcFrameS m n j x ∉ Z := by
    intro x hx hxZ
    obtain ⟨hs, ht, ht'⟩ := hcoord x hx
    rw [((hcBandTop_bounds hZc hZs hZi hl hr hg m n j (hI _ hs)).2.2).2 hxZ] at ht'
    linarith
  -- the interval between `s₁` and `s₂` lies in `(−1/2, 1/2)`
  have huI : ∀ s ∈ uIcc s₁ s₂, |s| < 1 / 2 := by
    intro s hs
    rcases le_total s₁ s₂ with h | h
    · rw [uIcc_of_le h] at hs
      rw [abs_lt]; constructor <;> linarith [hs.1, hs.2, neg_abs_le s₁, le_abs_self s₂]
    · rw [uIcc_of_ge h] at hs
      rw [abs_lt]; constructor <;> linarith [hs.1, hs.2, neg_abs_le s₂, le_abs_self s₁]
  constructor
  · rintro ⟨S, hSB, hSc, hx, hy⟩
    rw [Set.disjoint_left]
    intro c hc hcZ
    have hc1 : c ≠ s₁ := fun h => hnotZ _ h₁ (by rw [(hcFrame_coords m n j s₁ t₁).1, ← h]; exact hcZ)
    have hc2 : c ≠ s₂ := fun h => hnotZ _ h₂ (by rw [(hcFrame_coords m n j s₂ t₂).1, ← h]; exact hcZ)
    -- the line `s = c` misses the band and separates the two points
    have hsep := hSc {x | hcFrameS m n j x < c} {x | c < hcFrameS m n j x}
      (isOpen_lt (continuous_hcFrameS m n j) continuous_const) (isOpen_lt continuous_const (continuous_hcFrameS m n j))
    have hcover : S ⊆ {x | hcFrameS m n j x < c} ∪ {x | c < hcFrameS m n j x} := by
      intro x hxS
      have hne : hcFrameS m n j x ≠ c := fun h => hnotZ x (hSB hxS) (h ▸ hcZ)
      rcases lt_or_gt_of_ne hne with h | h
      · exact Or.inl h
      · exact Or.inr h
    rcases le_total s₁ s₂ with h | h
    · rw [uIcc_of_le h] at hc
      have := hsep hcover ⟨_, hx, by simp only [mem_setOf_eq, (hcFrame_coords m n j s₁ t₁).1]; exact lt_of_le_of_ne hc.1 (Ne.symm hc1)⟩
        ⟨_, hy, by simp only [mem_setOf_eq, (hcFrame_coords m n j s₂ t₂).1]; exact lt_of_le_of_ne hc.2 hc2⟩
      obtain ⟨x, -, h1, h2⟩ := this
      simp only [mem_setOf_eq] at h1 h2
      exact lt_asymm h1 h2
    · rw [uIcc_of_ge h] at hc
      have := hsep hcover ⟨_, hy, by simp only [mem_setOf_eq, (hcFrame_coords m n j s₂ t₂).1]; exact lt_of_le_of_ne hc.1 (Ne.symm hc2)⟩
        ⟨_, hx, by simp only [mem_setOf_eq, (hcFrame_coords m n j s₁ t₁).1]; exact lt_of_le_of_ne hc.2 hc1⟩
      obtain ⟨x, -, h1, h2⟩ := this
      simp only [mem_setOf_eq] at h1 h2
      exact lt_asymm h1 h2
  · intro hdisj
    -- `ℓ > 1` over the interval
    have hℓ : ∀ s ∈ uIcc s₁ s₂, 1 < hcBandTop g m n j s := by
      intro s hs
      have hb := hcBandTop_bounds hZc hZs hZi hl hr hg m n j (hI s (huI s hs))
      refine lt_of_le_of_ne hb.1 fun h => ?_
      exact Set.disjoint_left.1 hdisj hs (hb.2.2.1 h.symm)
    have hcont : ContinuousOn (hcBandTop g m n j) (uIcc s₁ s₂) :=
      (continuousOn_hcBandTop hZc hZs hZi hl hr hg m n j).mono fun s hs => hI s (huI s hs)
    set F : ℝ × ℝ → ℝ × ℝ := fun p => (p.1, 1 + p.2 * (hcBandTop g m n j p.1 - 1)) with hF
    have hFc : ContinuousOn F (uIcc s₁ s₂ ×ˢ Ioo 0 1) := by
      refine ContinuousOn.prodMk continuousOn_fst ?_
      refine continuousOn_const.add (continuousOn_snd.mul ?_)
      exact (hcont.comp continuousOn_fst fun p hp => hp.1).sub continuousOn_const
    have hφc : ContinuousOn ((fun q : ℝ × ℝ => hcFrame m n j q.1 q.2) ∘ F) (uIcc s₁ s₂ ×ˢ Ioo 0 1) :=
      (continuous_hcFrame m n j).comp_continuousOn hFc
    refine ⟨((fun q : ℝ × ℝ => hcFrame m n j q.1 q.2) ∘ F) '' (uIcc s₁ s₂ ×ˢ Ioo 0 1), ?_,
      (isPreconnected_uIcc.prod isPreconnected_Ioo).image _ hφc, ?_, ?_⟩
    · rintro _ ⟨⟨s, μ⟩, ⟨hs, hμ⟩, rfl⟩
      have h1 := hℓ s hs
      refine ⟨s, 1 + μ * (hcBandTop g m n j s - 1), huI s hs, ?_, ?_, rfl⟩
      · nlinarith [hμ.1]
      · nlinarith [hμ.2]
    · have h1 := hℓ s₁ left_mem_uIcc
      refine ⟨(s₁, (t₁ - 1) / (hcBandTop g m n j s₁ - 1)), ⟨left_mem_uIcc, ?_, ?_⟩, ?_⟩
      · exact div_pos (by linarith) (by linarith)
      · rw [div_lt_one (by linarith)]; linarith
      · show hcFrame m n j s₁ (1 + (t₁ - 1) / (hcBandTop g m n j s₁ - 1) * (hcBandTop g m n j s₁ - 1)) = _
        have hne : hcBandTop g m n j s₁ - 1 ≠ 0 := by linarith
        congr 1; field_simp; ring
    · have h1 := hℓ s₂ right_mem_uIcc
      refine ⟨(s₂, (t₂ - 1) / (hcBandTop g m n j s₂ - 1)), ⟨right_mem_uIcc, ?_, ?_⟩, ?_⟩
      · exact div_pos (by linarith) (by linarith)
      · rw [div_lt_one (by linarith)]; linarith
      · show hcFrame m n j s₂ (1 + (t₂ - 1) / (hcBandTop g m n j s₂ - 1) * (hcBandTop g m n j s₂ - 1)) = _
        have hne : hcBandTop g m n j s₂ - 1 ≠ 0 := by linarith
        congr 1; field_simp; ring

/-- The down triangle across edge `(0, 0, 0)` in that edge's frame: the convex hull of `(0, −√3/2)`, `(−1/2, 0)`, `(1/2, 0)`. -/
theorem hcDownTri_one_neg_one :
    hcDownTri 1 (-1) = convexHull ℝ {hcFrame 0 0 0 0 (-(√3 / 2)), hcFrame 0 0 0 (-1 / 2) 0, hcFrame 0 0 0 (1 / 2) 0} := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : (√3 : ℝ) ≠ 0 := by positivity
  have h3c : (√3 : ℂ) ≠ 0 := by exact_mod_cast h3p
  have hD : hcDownC 1 (-1) = hcUpC 0 0 + hcL := by
    have := hcDownC_dn 0 0 0
    rw [hc_w_omega.1, mul_one] at this
    exact this
  have hw0 : e (2 * π * (((0 : Fin 3) : ℕ) : ℝ) / 3) = 1 := hc_w_omega.1
  have e0 : e 0 = 1 := by simp [e]
  have e2 : e (2 * π / 3) = ((-1 / 2 : ℝ) : ℂ) + ((√3 / 2 : ℝ) : ℂ) * I := by
    have := hc_w_explicit 1
    simp only [Fin.isValue, Fin.val_one, Nat.cast_one, mul_one, Matrix.cons_val_one, Matrix.cons_val_zero] at this
    rw [this]; push_cast; ring
  have e4 : e (4 * π / 3) = ((-1 / 2 : ℝ) : ℂ) + ((-(√3 / 2) : ℝ) : ℂ) * I := by
    have := hc_w_explicit 2
    simp only [Fin.isValue, Matrix.cons_val] at this
    have h2 : (((2 : Fin 3) : ℕ) : ℝ) = 2 := by norm_num
    rw [show 4 * π / 3 = 2 * π * (((2 : Fin 3) : ℕ) : ℝ) / 3 by rw [h2]; ring, this]; push_cast; ring
  unfold hcDownTri
  congr 1
  simp only [hcFrame, hw0, mul_one, hD, e0, e2, e4]
  have v1 : hcUpC 0 0 + ↑hcL + 1 / ↑√3 = hcUpC 0 0 + (↑(hcL - √3 / 6 - -(√3 / 2)) - ↑(0 : ℝ) * I) := by
    push_cast; field_simp; ring_nf; rw [show (√3 : ℂ) ^ 2 = 3 by norm_cast; exact Real.sq_sqrt (by norm_num)]; ring
  have v2 : hcUpC 0 0 + ↑hcL + (↑(-1 / 2 : ℝ) + ↑(√3 / 2) * I) / ↑√3 =
      hcUpC 0 0 + (↑(hcL - √3 / 6 - 0) - ↑(-1 / 2 : ℝ) * I) := by
    push_cast; field_simp; ring_nf; rw [show (√3 : ℂ) ^ 2 = 3 by norm_cast; exact Real.sq_sqrt (by norm_num)]; ring
  have v3 : hcUpC 0 0 + ↑hcL + (↑(-1 / 2 : ℝ) + ↑(-(√3 / 2)) * I) / ↑√3 =
      hcUpC 0 0 + (↑(hcL - √3 / 6 - 0) - ↑(1 / 2 : ℝ) * I) := by
    push_cast; field_simp; ring_nf; rw [show (√3 : ℂ) ^ 2 = 3 by norm_cast; exact Real.sq_sqrt (by norm_num)]; ring
  rw [v1, v2, v3]

/-- The frames of the down triangle `(1, −1)`'s other two edges, read in the frame of edge `(0, 0, 0)`:
`t = −t₀/2 − √3/4 ± (√3/2) s₀` — negative on the slab `|s₀| < 1/2`, `t₀ > 0`. -/
theorem hcFrame_dn000_others (z : ℂ) :
    hcFrameT 1 (-1) 1 z = -(hcFrameT 0 0 0 z) / 2 - √3 / 4 + √3 / 2 * hcFrameS 0 0 0 z ∧
      hcFrameT 1 0 2 z = -(hcFrameT 0 0 0 z) / 2 - √3 / 4 - √3 / 2 * hcFrameS 0 0 0 z := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3' : √3 * √3 * √3 = 3 * √3 := by rw [h3]
  obtain ⟨⟨A1, -⟩, -, ⟨A3, B3⟩, -⟩ := hcFrame_face 1 (-1) z
  obtain ⟨-, ⟨C2, -⟩, -, -, -, ⟨C6, D6⟩⟩ := hcFrame_face 1 0 z
  norm_num at A3 B3 C6 D6
  simp only [Complex.sub_re, Complex.sub_im] at A1 C2
  constructor
  · rw [A1, A3, B3]; linarith
  · rw [C2, C6, D6]; linarith

/-- **Near the down triangle's facing side, only two blocks are within `1`**: for `z = (s, t)` in the frame of edge `(0, 0, 0)`,
`|s| < 1/2`, `0 < t < 1/20`, every point of HC within `1` of `z` is in the down triangle `(1, −1)` or in the closed band of the
edge — the far blocks are beyond `(L/2)√3 − 3/5 − 0.61 > 1`, and the other two bands of the triangle lie at `t ≥ 1` in frames
where `z` has `t < 0`. -/
theorem hc_free_near {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {s t : ℝ} (hs : |s| < 1 / 2)
    (ht0 : 0 < t) (ht : t < 1 / 20) {w : ℂ} (hw : w ∈ hcSet g) (hd : dist (hcFrame 0 0 0 s t) w ≤ 1) :
    w ∈ hcDownTri 1 (-1) ∨ w ∈ closure (hcBand g 0 0 0) := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h17 : (1.7 : ℝ) < √3 := by nlinarith [Real.sqrt_nonneg 3]
  have h18 : √3 < 1.8 := by nlinarith [Real.sqrt_nonneg 3]
  set z := hcFrame 0 0 0 s t with hz
  have hzs : hcFrameS 0 0 0 z = s := (hcFrame_coords 0 0 0 s t).1
  have hzt : hcFrameT 0 0 0 z = t := (hcFrame_coords 0 0 0 s t).2
  rw [hcSet_eq_iUnion, mem_iUnion] at hw
  obtain ⟨⟨m', n', k'⟩, hwB⟩ := hw
  -- a band of the triangle's other edges: `z` is at `t < 0` in its frame
  have hother : ∀ {a b : ℤ} {k : Fin 3}, hcFrameT a b k z < 0 → w ∈ closure (hcBand g a b k) → False := by
    intro a b k hzk hwk
    have h1 := one_le_hcFrameT_of_mem_closure_band hwk
    have h2 := abs_sub_hcFrameT_le a b k w z
    rw [dist_comm] at h2
    linarith [le_abs_self (hcFrameT a b k w - hcFrameT a b k z)]
  obtain ⟨O1, O2⟩ := hcFrame_dn000_others z
  rw [hzs, hzt] at O1 O2
  have hsa := abs_lt.1 hs
  by_cases hQ : (hcCA 1 (-1) 0 - hcCA m' n' k') ^ 2 + (hcCA 1 (-1) 0 - hcCA m' n' k') * (hcCB 1 (-1) 0 - hcCB m' n' k') +
      (hcCB 1 (-1) 0 - hcCB m' n' k') ^ 2 < 3
  · rcases hcC_near hQ with ⟨rfl, rfl, rfl⟩ | hfl | hfl
    · exact Or.inl hwB
    · unfold hcFlank at hfl
      rcases hfl with ⟨h, -⟩ | ⟨-, ⟨rfl, h1, h2⟩ | ⟨rfl, h1, h2⟩ | ⟨rfl, h1, h2⟩⟩
      · exact absurd h (by decide)
      · obtain rfl : m' = 0 := by omega
        obtain rfl : n' = 0 := by omega
        exact Or.inr hwB
      · subst h1; subst h2
        exact (hother (k := 1) (by rw [O1]; nlinarith) hwB).elim
      · subst h1
        obtain rfl : n' = 0 := by omega
        exact (hother (k := 2) (by rw [O2]; nlinarith) hwB).elim
    · unfold hcFlank at hfl
      rcases hfl with ⟨-, -, -, h⟩ | ⟨-, h⟩
      · rcases h with h | h | h <;> exact absurd h (by decide)
      · rcases h with ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩ <;> exact absurd h (by decide)
  · exfalso
    push Not at hQ
    have hL0 : 0 < hcL / 2 := by unfold hcL; positivity
    have hcc : dist (hcCentre 1 (-1) 0) (hcCentre m' n' k') =
        hcL / 2 * √(triQ ((hcCA 1 (-1) 0 : ℝ) - hcCA m' n' k') ((hcCB 1 (-1) 0 : ℝ) - hcCB m' n' k')) := by
      rw [hcCentre, hcCentre, dist_eq_norm, ← mul_sub, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hL0,
        ← dist_eq_norm, dist_tri]
    have hQr : (3 : ℝ) ≤ triQ ((hcCA 1 (-1) 0 : ℝ) - hcCA m' n' k') ((hcCB 1 (-1) 0 : ℝ) - hcCB m' n' k') := by
      have : (((hcCA 1 (-1) 0 - hcCA m' n' k') ^ 2 + (hcCA 1 (-1) 0 - hcCA m' n' k') * (hcCB 1 (-1) 0 - hcCB m' n' k') +
          (hcCB 1 (-1) 0 - hcCB m' n' k') ^ 2 : ℤ) : ℝ) =
          triQ ((hcCA 1 (-1) 0 : ℝ) - hcCA m' n' k') ((hcCB 1 (-1) 0 : ℝ) - hcCB m' n' k') := by
        unfold triQ; push_cast; ring
      rw [← this]; exact_mod_cast hQ
    have hsq := Real.sqrt_le_sqrt hQr
    have hq' := hcBlock_subset_ball hZc hZs hZi hl hr hg m' n' k' hwB
    rw [mem_closedBall] at hq'
    have hL : hcL / 2 * √3 = √3 + 1 / 2 := by unfold hcL; nlinarith
    have hfar : √3 + 1 / 2 ≤ dist (hcCentre 1 (-1) 0) (hcCentre m' n' k') := by
      rw [hcc, ← hL]; exact mul_le_mul_of_nonneg_left hsq hL0.le
    -- `z` is within `0.61` of the triangle's centre `(0, −√3/6)`
    have hC : hcCentre 1 (-1) 0 = hcFrame 0 0 0 0 (-(√3 / 6)) := by
      rw [(hcCentre_eq 1 (-1)).1]
      have := hcDownC_dn 0 0 0
      rw [hc_w_omega.1, mul_one] at this
      change hcDownC 1 (-1) = _ at this
      rw [this, hcFrame, hc_w_omega.1, mul_one]
      push_cast; ring
    have hzc : dist z (hcCentre 1 (-1) 0) < 61 / 100 := by
      rw [hC, dist_hcFrame_right, hzs, hzt, Real.sqrt_lt' (by norm_num)]
      have : s ^ 2 < 1 / 4 := by nlinarith
      nlinarith
    have htri := dist_triangle4 (hcCentre 1 (-1) 0) z w (hcCentre m' n' k')
    rw [dist_comm (hcCentre 1 (-1) 0) z] at htri
    have h173 : (1.73 : ℝ) < √3 := by nlinarith [Real.sqrt_nonneg 3]
    linarith

/-- The closed band lies in `|s| ≤ 1/2`, `t ≤ 1 + g(s)` of its frame. -/
theorem closure_hcBand_subset_frame {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    closure (hcBand g m n j) ⊆ {w | |hcFrameS m n j w| ≤ 1 / 2 ∧ hcFrameT m n j w ≤ 1 + g (hcFrameS m n j w)} := by
  refine closure_minimal ?_ ((isClosed_le (continuous_abs.comp (continuous_hcFrameS m n j)) continuous_const).inter
    (isClosed_le (continuous_hcFrameT m n j) (continuous_const.add (hg.1.continuous.comp (continuous_hcFrameS m n j)))))
  rintro _ ⟨s, t, hs, ht, ht', rfl⟩
  rw [mem_setOf_eq, (hcFrame_coords m n j s t).1, (hcFrame_coords m n j s t).2]
  have hsI : s ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s], by linarith [le_abs_self s]⟩
  exact ⟨hs.le, by linarith [(hcBandTop_bounds hZc hZs hZi hl hr hg m n j hsI).2.1]⟩

/-- **The arc passes above the band** (FS111-M3 § 4.2 (1)): for `0 < t < 1` and `r² = 2t − t²` with both crossings `s ± r` in `Z`,
the only points of the closed band on the unit circle about `(s, t)` are the crossings `(s ± r, 1)` — between them the circle's
height above `1` is at least `t·d/r` (concavity), the band's at most `d²/4` (G1), `d` the distance to the nearer crossing. -/
theorem hc_free_arc {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {s t ρ : ℝ} (ht0 : 0 < t) (ht1 : t < 1)
    (hρ0 : 0 < ρ) (hρ : ρ ^ 2 = 2 * t - t ^ 2) (hZ1 : s - ρ ∈ Z) (hZ2 : s + ρ ∈ Z) {w : ℂ}
    (hw : w ∈ closure (hcBand g 0 0 0)) (hd : dist (hcFrame 0 0 0 s t) w = 1) :
    w = hcFrame 0 0 0 (s - ρ) 1 ∨ w = hcFrame 0 0 0 (s + ρ) 1 := by
  obtain ⟨hws, hwt⟩ := closure_hcBand_subset_frame hZc hZs hZi hl hr hg 0 0 0 hw
  have hw1 := one_le_hcFrameT_of_mem_closure_band hw
  have hwe := hcFrame_hcFrameST 0 0 0 w
  set s' := hcFrameS 0 0 0 w
  set t' := hcFrameT 0 0 0 w
  have hdist : (s - s') ^ 2 + (t - t') ^ 2 = 1 := by
    rw [dist_eq_hcFrame 0 0 0, (hcFrame_coords 0 0 0 s t).1, (hcFrame_coords 0 0 0 s t).2, Real.sqrt_eq_one] at hd
    exact hd
  have hs'I : s' ∈ Icc (-1 / 2 : ℝ) (1 / 2) := ⟨by linarith [neg_abs_le s'], by linarith [le_abs_self s']⟩
  set u := |s' - s| with hu
  have hu0 : 0 ≤ u := abs_nonneg _
  have hu2 : u ^ 2 = (s' - s) ^ 2 := sq_abs _
  have htt : 1 - t ≤ t' - t := by linarith
  have hu_le : u ≤ ρ := by
    refine (pow_le_pow_iff_left₀ hu0 hρ0.le two_ne_zero).1 ?_
    nlinarith
  have hkey : 1 - t * u / ρ ≤ t' - t := by
    by_contra h
    push Not at h
    have hq : t * u / ρ ≤ t := by
      rw [div_le_iff₀ hρ0]; nlinarith
    have h1 : (t' - t) ^ 2 < (1 - t * u / ρ) ^ 2 := pow_lt_pow_left₀ h (by linarith) two_ne_zero
    have e1 : (1 - t * u / ρ) ^ 2 * ρ ^ 2 = (ρ - t * u) ^ 2 := by field_simp
    have h2 : (t' - t) ^ 2 * ρ ^ 2 < (ρ - t * u) ^ 2 := by rw [← e1]; exact mul_lt_mul_of_pos_right h1 (by positivity)
    have h3 : (t' - t) ^ 2 = 1 - u ^ 2 := by nlinarith
    rw [h3] at h2
    nlinarith [mul_nonneg hu0 (sub_nonneg.2 hu_le), mul_pos ht0 hρ0]
  have hinf : infDist s' Z ≤ ρ - u := by
    rcases le_total s s' with h | h
    · have hu' : u = s' - s := abs_of_nonneg (sub_nonneg.2 h)
      refine (infDist_le_dist_of_mem hZ2).trans (le_of_eq ?_)
      rw [Real.dist_eq, abs_of_nonpos (by linarith), hu']; ring
    · have hu' : u = s - s' := by rw [hu, abs_sub_comm]; exact abs_of_nonneg (sub_nonneg.2 h)
      refine (infDist_le_dist_of_mem hZ1).trans (le_of_eq ?_)
      rw [Real.dist_eq, abs_of_nonneg (by linarith), hu']; ring
  have hg1 := (hg.2.1 s' hs'I).2.1
  have hinf0 : 0 ≤ infDist s' Z := infDist_nonneg
  have hg2 : g s' ≤ (ρ - u) ^ 2 / 4 := by
    have := pow_le_pow_left₀ hinf0 hinf 2
    linarith
  have hfin : (ρ - u) * (4 * t - ρ * (ρ - u)) ≤ 0 := by
    have : t * (ρ - u) / ρ ≤ (ρ - u) ^ 2 / 4 := by
      have : t * (ρ - u) / ρ = t - t * u / ρ := by field_simp
      rw [this]; linarith
    rw [div_le_iff₀ hρ0] at this
    nlinarith
  have hρu : u = ρ := by
    by_contra hne
    have hlt : u < ρ := lt_of_le_of_ne hu_le hne
    have : 0 < 4 * t - ρ * (ρ - u) := by nlinarith [mul_le_mul_of_nonneg_left (show ρ - u ≤ ρ by linarith) hρ0.le]
    nlinarith [mul_pos (sub_pos.2 hlt) this]
  have ht'1 : t' = 1 := by
    have h3 : (t' - t) ^ 2 = (1 - t) ^ 2 := by nlinarith
    have := (pow_left_inj₀ (by linarith) (by linarith) two_ne_zero).1 h3
    linarith
  rw [← hwe, ht'1]
  rcases abs_cases (s' - s) with ⟨h, -⟩ | ⟨h, -⟩
  · right; congr 1; linarith
  · left; congr 1; linarith

/-- The directions in which the unit circle about `z` reaches a given point form a countable set (`θ₀ + 2πℤ`). -/
theorem countable_setOf_add_e_eq (z P : ℂ) : {θ : ℝ | z + e θ = P}.Countable := by
  rcases eq_empty_or_nonempty {θ : ℝ | z + e θ = P} with h | ⟨θ₀, hθ₀⟩
  · rw [h]; exact countable_empty
  refine (countable_range fun n : ℤ => θ₀ + n * (2 * π)).mono fun θ hθ => ?_
  have he : e θ = e θ₀ := by
    have h1 : z + e θ = P := hθ
    have h2 : z + e θ₀ = P := hθ₀
    linear_combination h1 - h2
  obtain ⟨n, hn⟩ := Complex.exp_eq_exp_iff_exists_int.1 he
  refine ⟨n, ?_⟩
  have := congrArg Complex.im hn
  simp at this
  linarith

/-- **A free point** (FS111-M3 § 4.2 (1)): with both crossings `s ± ρ` in `Z` and the down triangle strictly inside the unit circle,
the point `(s, t)` of edge `(0, 0, 0)`'s frame is outside HC and its unit circle meets `int HC` in no arc (only at the two
crossings, if anywhere). -/
theorem hc_free_mem {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {s t ρ : ℝ} (hs : |s| < 1 / 2)
    (ht0 : 0 < t) (ht : t < 1 / 20) (hρ0 : 0 < ρ) (hρ : ρ ^ 2 = 2 * t - t ^ 2) (hZ1 : s - ρ ∈ Z) (hZ2 : s + ρ ∈ Z)
    (hv1 : (s - 1 / 2) ^ 2 + t ^ 2 < 1) (hv2 : (s + 1 / 2) ^ 2 + t ^ 2 < 1) (hv3 : s ^ 2 + (t + √3 / 2) ^ 2 < 1) :
    hcFrame 0 0 0 s t ∈ {z | z ∉ hcSet g ∧ phi (interior (hcSet g)) z = 0} := by
  set z := hcFrame 0 0 0 s t with hz
  have hzt : hcFrameT 0 0 0 z = t := (hcFrame_coords 0 0 0 s t).2
  have hT : hcDownTri 1 (-1) ⊆ ball z 1 := by
    rw [hcDownTri_one_neg_one]
    refine convexHull_min ?_ (convex_ball z 1)
    have key : ∀ a b : ℝ, (a - s) ^ 2 + (b - t) ^ 2 < 1 → hcFrame 0 0 0 a b ∈ ball z 1 := by
      intro a b h
      rw [mem_ball, dist_hcFrame]; exact (Real.sqrt_lt' one_pos).2 (by linarith)
    intro v hv
    simp only [mem_insert_iff, mem_singleton_iff] at hv
    rcases hv with rfl | rfl | rfl
    · exact key _ _ (by nlinarith)
    · exact key _ _ (by nlinarith)
    · exact key _ _ (by nlinarith)
  constructor
  · intro hzH
    rcases hc_free_near hZc hZs hZi hl hr hg hs ht0 ht hzH (by rw [dist_self]; exact zero_le_one) with h | h
    · change z ∈ hcDownTri (hcDn 0 0 0).1 (hcDn 0 0 0).2 at h
      have := ((mem_hcDownTri_iff_frame 0).1 h).1
      linarith
    · have := one_le_hcFrameT_of_mem_closure_band h
      linarith
  · have hsub : {θ : ℝ | z + e θ ∈ interior (hcSet g)} ⊆
        {θ : ℝ | z + e θ = hcFrame 0 0 0 (s - ρ) 1} ∪ {θ : ℝ | z + e θ = hcFrame 0 0 0 (s + ρ) 1} := by
      intro θ hθ
      have hd : dist z (z + e θ) = 1 := by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
      rcases hc_free_near hZc hZs hZi hl hr hg hs ht0 ht (interior_subset hθ) hd.le with h | h
      · have := hT h
        rw [mem_ball, dist_comm, hd] at this
        exact absurd this (lt_irrefl _)
      · exact hc_free_arc hZc hZs hZi hl hr hg ht0 (by linarith) hρ0 hρ hZ1 hZ2 h hd
    refine le_antisymm ?_ (by positivity)
    calc phi (interior (hcSet g)) z ≤ volume ({θ : ℝ | z + e θ = hcFrame 0 0 0 (s - ρ) 1} ∪
          {θ : ℝ | z + e θ = hcFrame 0 0 0 (s + ρ) 1}) :=
        (measure_mono hsub).trans (Measure.restrict_le_self _)
      _ = 0 := ((countable_setOf_add_e_eq _ _).union (countable_setOf_add_e_eq _ _)).measure_zero volume

/-- **A Lebesgue density point of `Z` inside `(−1/2, 1/2)`**: near it, `Z` misses at most an eighth of each small closed ball. -/
theorem exists_density_point {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZpos : 0 < volume Z) :
    ∃ p ∈ Z, |p| < 1 / 2 ∧ ∃ ρ₀ > 0, ∀ ρ, 0 < ρ → ρ < ρ₀ → volume (closedBall p ρ \ Z) ≤ ENNReal.ofReal (ρ / 4) := by
  set Z' := Z ∩ Ioo (-1 / 2 : ℝ) (1 / 2) with hZ'
  have hZ'm : MeasurableSet Z' := hZc.measurableSet.inter measurableSet_Ioo
  have hZ'pos : 0 < volume Z' := by
    have hsub : Z ⊆ Z' ∪ {-1 / 2, 1 / 2} := by
      intro x hx
      by_cases h1 : x = -1 / 2
      · exact Or.inr (Or.inl h1)
      by_cases h2 : x = 1 / 2
      · exact Or.inr (Or.inr h2)
      exact Or.inl ⟨hx, lt_of_le_of_ne (hZs hx).1 (Ne.symm h1), lt_of_le_of_ne (hZs hx).2 h2⟩
    have h0 : volume ({-1 / 2, 1 / 2} : Set ℝ) = 0 := ((finite_singleton _).insert _).measure_zero _
    have := (measure_mono hsub).trans (measure_union_le (μ := volume) Z' ({-1 / 2, 1 / 2} : Set ℝ))
    rw [h0, add_zero] at this
    exact lt_of_lt_of_le hZpos this
  have hae := Besicovitch.ae_tendsto_measure_inter_div (volume : Measure ℝ) Z
  have hae' := ae_restrict_of_ae_restrict_of_subset (inter_subset_left : Z' ⊆ Z) hae
  have hmem : ∀ᵐ x ∂volume.restrict Z', x ∈ Z' := ae_restrict_mem hZ'm
  haveI : (ae (volume.restrict Z')).NeBot := ae_neBot.2 (by rw [Ne, Measure.restrict_eq_zero]; exact hZ'pos.ne')
  obtain ⟨p, hp, ⟨hpZ, hpI⟩⟩ := (hae'.and hmem).exists
  refine ⟨p, hpZ, abs_lt.2 ⟨by linarith [hpI.1], hpI.2⟩, ?_⟩
  have hev := hp.eventually (lt_mem_nhds (show (7 / 8 : ENNReal) < 1 by
    rw [ENNReal.div_lt_iff (by norm_num) (by norm_num)]; norm_num))
  obtain ⟨ρ₀, hρ₀, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.1 hev
  refine ⟨ρ₀, hρ₀, fun ρ hρ0 hρ => ?_⟩
  have hr := hsub ⟨hρ0, hρ⟩
  simp only [mem_setOf_eq] at hr
  rw [Real.volume_closedBall] at hr
  have hB : (ENNReal.ofReal (2 * ρ)) ≠ 0 := by simp; linarith
  rw [ENNReal.lt_div_iff_mul_lt (Or.inl hB) (Or.inl ENNReal.ofReal_ne_top)] at hr
  have h78 : (7 / 8 : ENNReal) * ENNReal.ofReal (2 * ρ) = ENNReal.ofReal (7 * ρ / 4) := by
    rw [show (7 / 8 : ENNReal) = ENNReal.ofReal (7 / 8) by
      rw [ENNReal.ofReal_div_of_pos (by norm_num)]; simp, ← ENNReal.ofReal_mul (by norm_num)]
    congr 1; ring
  rw [h78] at hr
  have hsum := measure_sdiff_add_inter (μ := volume) (closedBall p ρ) hZc.measurableSet
  rw [Real.volume_closedBall, inter_comm] at hsum
  by_contra hcon
  push Not at hcon
  have := ENNReal.add_lt_add hcon hr
  rw [hsum, ← ENNReal.ofReal_add (by linarith) (by linarith)] at this
  exact absurd this (by rw [show ρ / 4 + 7 * ρ / 4 = 2 * ρ by ring]; exact lt_irrefl _)

/-- **The slice**: near a density point, `{s : |s − p| < h, s ∓ ρ ∈ Z}` has measure at least `h` for every `0 < ρ < h` (each
translate of `Z` misses at most `h/2` of the interval). -/
theorem hc_free_slice {Z : Set ℝ} {p h ρ : ℝ} (hh : 0 < h) (hρ0 : 0 ≤ ρ) (hρh : ρ < h)
    (hdens : volume (closedBall p (2 * h) \ Z) ≤ ENNReal.ofReal (h / 2)) :
    ENNReal.ofReal h ≤ volume {s : ℝ | |s - p| < h ∧ s - ρ ∈ Z ∧ s + ρ ∈ Z} := by
  set I := Ioo (p - h) (p + h)
  have hI : volume I = ENNReal.ofReal (2 * h) := by rw [Real.volume_Ioo]; congr 1; ring
  have h1 : volume (I ∩ {s | s - ρ ∉ Z}) ≤ ENNReal.ofReal (h / 2) := by
    refine le_trans (measure_mono (t := (fun s => s + (-ρ)) ⁻¹' (closedBall p (2 * h) \ Z)) ?_) ?_
    · rintro s ⟨⟨hs1, hs2⟩, hsZ⟩
      refine ⟨?_, by simpa [sub_eq_add_neg] using hsZ⟩
      rw [mem_closedBall, Real.dist_eq, abs_le]; constructor <;> linarith
    · rw [measure_preimage_add_right]; exact hdens
  have h2 : volume (I ∩ {s | s + ρ ∉ Z}) ≤ ENNReal.ofReal (h / 2) := by
    refine le_trans (measure_mono (t := (fun s => s + ρ) ⁻¹' (closedBall p (2 * h) \ Z)) ?_) ?_
    · rintro s ⟨⟨hs1, hs2⟩, hsZ⟩
      refine ⟨?_, hsZ⟩
      rw [mem_closedBall, Real.dist_eq, abs_le]; constructor <;> linarith
    · rw [measure_preimage_add_right]; exact hdens
  have hcov : I ⊆ {s : ℝ | |s - p| < h ∧ s - ρ ∈ Z ∧ s + ρ ∈ Z} ∪ (I ∩ {s | s - ρ ∉ Z}) ∪ (I ∩ {s | s + ρ ∉ Z}) := by
    intro s hs
    by_cases ha : s - ρ ∈ Z
    · by_cases hb : s + ρ ∈ Z
      · exact Or.inl (Or.inl ⟨abs_lt.2 ⟨by linarith [hs.1], by linarith [hs.2]⟩, ha, hb⟩)
      · exact Or.inr ⟨hs, hb⟩
    · exact Or.inl (Or.inr ⟨hs, ha⟩)
  have hle := (measure_mono (μ := volume) hcov).trans ((measure_union_le (μ := volume) _ _).trans
    (add_le_add (measure_union_le (μ := volume) _ _) le_rfl))
  rw [hI] at hle
  have hle' : ENNReal.ofReal h + (ENNReal.ofReal (h / 2) + ENNReal.ofReal (h / 2)) ≤
      volume {s : ℝ | |s - p| < h ∧ s - ρ ∈ Z ∧ s + ρ ∈ Z} + (ENNReal.ofReal (h / 2) + ENNReal.ofReal (h / 2)) := by
    rw [← ENNReal.ofReal_add (by linarith) (by linarith), ← ENNReal.ofReal_add (by linarith) (by linarith),
      show h + (h / 2 + h / 2) = 2 * h by ring]
    calc ENNReal.ofReal (2 * h) ≤ _ := hle
      _ ≤ _ := by
        rw [add_assoc]
        exact add_le_add le_rfl ((add_le_add h1 h2).trans (ENNReal.ofReal_add (by linarith) (by linarith)).symm.le)
  exact (ENNReal.add_le_add_iff_right (by simp)).1 hle'

/-- The parameter set of free points is measurable. -/
theorem measurableSet_hcFreeParam {Z : Set ℝ} (hZc : IsClosed Z) (p h t₁ : ℝ) :
    MeasurableSet {q : ℝ × ℝ | |q.1 - p| < h ∧ 0 < q.2 ∧ q.2 < t₁ ∧ q.1 - √(2 * q.2 - q.2 ^ 2) ∈ Z ∧
      q.1 + √(2 * q.2 - q.2 ^ 2) ∈ Z} := by
  have hr : Continuous fun q : ℝ × ℝ => √(2 * q.2 - q.2 ^ 2) := Real.continuous_sqrt.comp (by fun_prop)
  refine (measurableSet_lt (continuous_abs.comp (continuous_fst.sub continuous_const)).measurable measurable_const).inter
    ((measurableSet_lt measurable_const measurable_snd).inter ((measurableSet_lt measurable_snd measurable_const).inter
    ((hZc.preimage (continuous_fst.sub hr)).measurableSet.inter (hZc.preimage (continuous_fst.add hr)).measurableSet)))

/-- The parameter set of free points: `|s − p| < h`, `0 < t < t₁`, both crossings `s ∓ √(2t − t²)` in `Z`. -/
theorem hc_free_param_pos {Z : Set ℝ} (hZc : IsClosed Z) {p h t₁ : ℝ} (hh : 0 < h) (ht₁ : 0 < t₁) (ht₁h : t₁ ≤ h ^ 2 / 2)
    (ht₁1 : t₁ ≤ 1) (hdens : volume (closedBall p (2 * h) \ Z) ≤ ENNReal.ofReal (h / 2)) :
    0 < volume {q : ℝ × ℝ | |q.1 - p| < h ∧ 0 < q.2 ∧ q.2 < t₁ ∧ q.1 - √(2 * q.2 - q.2 ^ 2) ∈ Z ∧
      q.1 + √(2 * q.2 - q.2 ^ 2) ∈ Z} := by
  set A := {q : ℝ × ℝ | |q.1 - p| < h ∧ 0 < q.2 ∧ q.2 < t₁ ∧ q.1 - √(2 * q.2 - q.2 ^ 2) ∈ Z ∧
      q.1 + √(2 * q.2 - q.2 ^ 2) ∈ Z} with hA
  have hAm : MeasurableSet A := measurableSet_hcFreeParam hZc p h t₁
  rw [Measure.volume_eq_prod, Measure.prod_apply_symm hAm]
  have hslice : ∀ y ∈ Ioo 0 t₁, ENNReal.ofReal h ≤ volume ((fun x => (x, y)) ⁻¹' A) := by
    intro y hy
    have hr2 : 0 ≤ 2 * y - y ^ 2 := by nlinarith [hy.1, hy.2]
    have hr : √(2 * y - y ^ 2) < h := by
      rw [Real.sqrt_lt' hh]; nlinarith [hy.1, hy.2]
    refine (hc_free_slice hh (Real.sqrt_nonneg _) hr hdens).trans (measure_mono ?_)
    rintro x ⟨h1, h2, h3⟩
    exact ⟨h1, hy.1, hy.2, h2, h3⟩
  calc (0 : ENNReal) < ENNReal.ofReal h * volume (Ioo 0 t₁) := by
        rw [Real.volume_Ioo]; exact ENNReal.mul_pos (by simp [hh]) (by simp [ht₁])
    _ = ∫⁻ y, (Ioo 0 t₁).indicator (fun _ => ENNReal.ofReal h) y := (lintegral_indicator_const measurableSet_Ioo _).symm
    _ ≤ ∫⁻ y, volume ((fun x => (x, y)) ⁻¹' A) := by
        refine lintegral_mono fun y => ?_
        by_cases hy : y ∈ Ioo 0 t₁
        · rw [indicator_of_mem hy]; exact hslice y hy
        · rw [indicator_of_notMem hy]; positivity

/-- The frame of edge `(0, 0, 0)` read as coordinates is measure-preserving (`w₀ = 1`: a reflection, a swap, a translation). -/
theorem measurePreserving_hcFrame000 :
    MeasurePreserving (fun z : ℂ => (hcFrameS 0 0 0 z, hcFrameT 0 0 0 z)) volume volume := by
  set C := hcUpC 0 0
  set K := hcL - √3 / 6 + C.re
  have hfun : (fun z : ℂ => (hcFrameS 0 0 0 z, hcFrameT 0 0 0 z)) =
      (Prod.swap ∘ Prod.map (fun x : ℝ => K - x) (fun y : ℝ => C.im - y)) ∘ Complex.measurableEquivRealProd := by
    funext z
    simp only [hcFrameS, hcFrameT, hc_w_omega.1, div_one, Function.comp_apply, Prod.map_apply, Prod.swap_prod_mk,
      Complex.measurableEquivRealProd_apply, Complex.sub_re, Complex.sub_im, K]
    ext <;> simp only <;> ring
  rw [hfun]
  refine MeasurePreserving.comp ?_ Complex.volume_preserving_equiv_real_prod
  rw [Measure.volume_eq_prod]
  exact (Measure.measurePreserving_swap).comp ((volume.measurePreserving_sub_left K).prod
    (volume.measurePreserving_sub_left C.im))

/-- The numeric conditions on a free point near a density point `p`, with margin `m = (1/2 − |p|)/2`. -/
theorem hc_free_numeric {s t m : ℝ} (hm : 0 < m) (hm4 : m ≤ 1 / 4) (hs : |s| < 1 / 2 - m) (ht0 : 0 < t) (ht : t < m / 4) :
    (s - 1 / 2) ^ 2 + t ^ 2 < 1 ∧ (s + 1 / 2) ^ 2 + t ^ 2 < 1 ∧ s ^ 2 + (t + √3 / 2) ^ 2 < 1 := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h18 : √3 < 1.8 := by nlinarith [Real.sqrt_nonneg 3]
  have h17 : (1.7 : ℝ) < √3 := by nlinarith [Real.sqrt_nonneg 3]
  obtain ⟨hs1, hs2⟩ := abs_lt.1 hs
  have ht2 : t ^ 2 < m ^ 2 / 16 := by nlinarith
  refine ⟨by nlinarith, by nlinarith, ?_⟩
  have hs3 : s ^ 2 < (1 / 2 - m) ^ 2 := by nlinarith
  nlinarith

/-- **IRREG (1), `|E| > 0`**: with `Z` of positive length, the bulge points whose unit circle crosses `t = 1` at two points of
`Z` see no point of `int HC` (the arc passes above the band: `t·d/r > d²/4`), and they have positive measure (density points of
`Z × Z` through the local diffeomorphism `(s, t) ↦ (s + r, s − r)`). -/
theorem hc_free_pos {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (hZpos : 0 < volume Z) :
    0 < volume {z | z ∉ hcSet g ∧ phi (interior (hcSet g)) z = 0} := by
  obtain ⟨p, -, hp, ρ₀, hρ₀, hdens⟩ := exists_density_point hZc hZs hZpos
  set m₀ := (1 / 2 - |p|) / 2 with hm₀def
  have hm₀ : 0 < m₀ := by rw [hm₀def]; linarith
  have hm₀4 : m₀ ≤ 1 / 4 := by rw [hm₀def]; linarith [abs_nonneg p]
  set h := min (ρ₀ / 4) m₀ with hhdef
  have hh : 0 < h := lt_min (by linarith) hm₀
  have hhm : h ≤ m₀ := min_le_right _ _
  have hhρ : h ≤ ρ₀ / 4 := min_le_left _ _
  have hd := hdens (2 * h) (by linarith) (by linarith)
  rw [show 2 * h / 4 = h / 2 by ring] at hd
  set t₁ := min (1 / 20) (min (m₀ / 4) (h ^ 2 / 2)) with ht₁def
  have ht₁ : 0 < t₁ := lt_min (by norm_num) (lt_min (by linarith) (by positivity))
  have ht₁a : t₁ ≤ 1 / 20 := min_le_left _ _
  have ht₁b : t₁ ≤ m₀ / 4 := (min_le_right _ _).trans (min_le_left _ _)
  have ht₁c : t₁ ≤ h ^ 2 / 2 := (min_le_right _ _).trans (min_le_right _ _)
  have hA := hc_free_param_pos hZc hh ht₁ ht₁c (by linarith) hd
  set A := {q : ℝ × ℝ | |q.1 - p| < h ∧ 0 < q.2 ∧ q.2 < t₁ ∧ q.1 - √(2 * q.2 - q.2 ^ 2) ∈ Z ∧
      q.1 + √(2 * q.2 - q.2 ^ 2) ∈ Z}
  refine lt_of_lt_of_le hA ?_
  calc volume A = volume ((fun z : ℂ => (hcFrameS 0 0 0 z, hcFrameT 0 0 0 z)) ⁻¹' A) :=
        (measurePreserving_hcFrame000.measure_preimage (measurableSet_hcFreeParam hZc p h t₁).nullMeasurableSet).symm
    _ ≤ _ := by
        refine measure_mono fun z hz => ?_
        obtain ⟨h1, h2, h3, h4, h5⟩ := hz
        set s := hcFrameS 0 0 0 z
        set t := hcFrameT 0 0 0 z
        have hs : |s| < 1 / 2 - m₀ := by
          have := abs_sub_abs_le_abs_sub s p
          rw [hm₀def] at hhm ⊢; linarith
        have hr2 : 0 < 2 * t - t ^ 2 := by nlinarith
        obtain ⟨hv1, hv2, hv3⟩ := hc_free_numeric hm₀ hm₀4 hs h2 (by linarith)
        have := hc_free_mem hZc hZs hZi hl hr hg (by linarith [abs_nonneg s] : |s| < 1 / 2) h2 (by linarith)
          (Real.sqrt_pos.2 hr2) (Real.sq_sqrt hr2.le) h4 h5 hv1 hv2 hv3
        rwa [hcFrame_hcFrameST] at this

/-- **IRREG (2)**: the free points lie in a closed nowhere dense set (null level sets, flat side lines, the circles about `σ_e`'s
ends, and `K_e = ⋃_{c ∈ Z} T₁((c, 1))`, nowhere dense by Baire on `(Z − ρ) ∪ (Z + ρ)`). -/
theorem hc_free_subset_nowhereDense {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    ∃ K : Set ℂ, IsClosed K ∧ interior K = ∅ ∧ {z | z ∉ hcSet g ∧ phi (interior (hcSet g)) z = 0} ⊆ K := by
  set A := interior (hcSet g) with hA
  have hAo : IsOpen A := isOpen_interior
  refine ⟨{z | ∀ θ : ℝ, z + e θ ∉ A} ∩ Aᶜ, ?_, ?_, ?_⟩
  · refine IsClosed.inter ?_ hAo.isClosed_compl
    have : {z | ∀ θ : ℝ, z + e θ ∉ A} = ⋂ θ : ℝ, (fun z => z + e θ) ⁻¹' Aᶜ := by ext; simp
    rw [this]
    exact isClosed_iInter fun θ => hAo.isClosed_compl.preimage (continuous_id.add continuous_const)
  · refine eq_empty_iff_forall_notMem.2 fun z hz => ?_
    obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.1 isOpen_interior z hz
    have hzK := interior_subset hz
    obtain ⟨y, hyH, hzy⟩ := hc_exclusion hZc hZs hZi hl hr hg hzK.2
    rw [← closure_interior_hcSet hZc hZs hZi hl hr hg] at hyH
    obtain ⟨w, hwA, hwy⟩ := Metric.mem_closure_iff.1 hyH (min δ (1 / 2)) (lt_min hδ (by norm_num))
    have hwy' : dist y w < δ := lt_of_lt_of_le hwy (min_le_left _ _)
    have hwy2 : dist y w < 1 / 2 := lt_of_lt_of_le hwy (min_le_right _ _)
    set d := dist z w with hd
    have hd1 : |d - 1| < δ := by
      have h1 := dist_triangle z y w
      have h2 := dist_triangle z w y
      rw [dist_comm w y] at h2
      rw [abs_lt]; constructor <;> linarith
    have hd0 : 0 < d := by
      have h2 := dist_triangle z w y
      rw [dist_comm w y] at h2
      linarith
    set z' : ℂ := w + ((1 / d : ℝ) : ℂ) * (z - w) with hz'
    have hz'w : dist z' w = 1 := by
      rw [dist_eq_norm, hz', add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos (by positivity), ← dist_eq_norm, ← hd]
      field_simp
    have hz'z : dist z' z < δ := by
      have : z' - z = ((1 / d - 1 : ℝ) : ℂ) * (z - w) := by rw [hz']; push_cast; ring
      rw [dist_eq_norm, this, norm_mul, Complex.norm_real, Real.norm_eq_abs, ← dist_eq_norm, ← hd]
      have : |1 / d - 1| * d = |d - 1| := by
        have e : (1 / d - 1) * d = -(d - 1) := by field_simp; ring
        rw [← abs_neg (d - 1), ← e, abs_mul, abs_of_pos hd0]
      linarith
    have hK := interior_subset (hball (by rw [mem_ball]; exact hz'z))
    have hα : z' + e (Complex.arg (w - z')) = w := by
      have h := self_eq_norm_mul_e_arg (w - z')
      rw [← dist_eq_norm, dist_comm, hz'w, ofReal_one, one_mul] at h
      rw [← h]; ring
    exact hK.1 (Complex.arg (w - z')) (by rw [hα]; exact hwA)
  · rintro z ⟨hzH, hphi⟩
    refine ⟨fun θ hθ => ?_, fun hzA => hzH (interior_subset hzA)⟩
    have hd : dist z (z + e θ) = 1 := by
      rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    have := phi_pos_of_mem_open hAo.measurableSet hAo subset_rfl hθ hd
    rw [hphi] at this
    exact lt_irrefl _ this

/-- **IRREG (3), general**: a set `A′` whose part outside a closed `F` has positive measure and lies a.e. in a closed nowhere
dense `K` has a support whose frontier has positive measure (density points of `A′ ∖ F` are boundary points of `supp A′`). -/
theorem frontier_essSupport_pos {A' F K : Set ℂ} (hF : IsClosed F) (hK : IsClosed K) (hKi : interior K = ∅)
    (hS : 0 < volume (A' \ F)) (hsub : A' \ F ≤ᵐ[volume] K) : 0 < volume (frontier (essSupport A')) := by
  have hnull : volume ((A' \ F) \ K) = 0 := ae_le_set.1 hsub
  have hfr : (essSupport A' ∩ K) \ F ⊆ frontier (essSupport A') := by
    rintro x ⟨⟨hxS, -⟩, hxF⟩
    rw [(isClosed_essSupport A').frontier_eq]
    refine ⟨hxS, fun hint => ?_⟩
    set U := interior (essSupport A') ∩ Fᶜ with hU
    have hUo : IsOpen U := isOpen_interior.inter hF.isOpen_compl
    have hUK : U ⊆ K := by
      intro y hy
      by_contra hyK
      obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.1 (hUo.inter hK.isOpen_compl) y ⟨hy, hyK⟩
      have h0 : volume (A' ∩ ball y r) = 0 := by
        refine measure_mono_null (fun w hw => ?_) hnull
        have := hball hw.2
        exact ⟨⟨hw.1, this.1.2⟩, this.2⟩
      have hpos := (interior_subset hy.1 : y ∈ essSupport A') r hr
      rw [h0] at hpos
      exact lt_irrefl _ hpos
    have : x ∈ interior K := interior_maximal hUK hUo ⟨hint, hxF⟩
    rw [hKi] at this; exact this
  have hae : A' \ F ≤ᵐ[volume] ((essSupport A' ∩ K) \ F : Set ℂ) := by
    have h1 : volume ((A' \ F) \ essSupport A') = 0 :=
      measure_mono_null (show (A' \ F) \ essSupport A' ⊆ A' \ essSupport A' from fun w hw => ⟨hw.1.1, hw.2⟩)
        (volume_diff_essSupport A')
    rw [ae_le_set]
    refine measure_mono_null (fun w hw => ?_) (measure_union_null h1 hnull)
    by_cases hw' : w ∈ essSupport A'
    · exact Or.inr ⟨hw.1, fun hk => hw.2 ⟨⟨hw', hk⟩, hw.1.2⟩⟩
    · exact Or.inl ⟨hw.1, hw'⟩
  exact lt_of_lt_of_le hS ((measure_mono_ae hae).trans (measure_mono hfr))

/-- HC₀'s zero set `Z = {−1/2, 1/2}` (every band one lens). -/
def hcZ0 : Set ℝ := {-1 / 2, 1 / 2}

/-- **A model of FS111-M3-HC's hypotheses**: HC₀ — `Z = {±1/2}` with § 1.6's gap function. -/
theorem hcZ0_spec : IsClosed hcZ0 ∧ hcZ0 ⊆ Icc (-1 / 2) (1 / 2) ∧ volume hcZ0 = 0 ∧ (-1 / 2 : ℝ) ∈ hcZ0 ∧
    (1 / 2 : ℝ) ∈ hcZ0 ∧ G1Bounds hcZ0 (hcGap hcZ0) := by
  have hf : hcZ0.Finite := (Set.finite_singleton _).insert _
  have hc : IsClosed hcZ0 := hf.isClosed
  have hs : hcZ0 ⊆ Icc (-1 / 2) (1 / 2) := by
    rintro x (rfl | rfl) <;> norm_num
  have hl : (-1 / 2 : ℝ) ∈ hcZ0 := Or.inl rfl
  have hr : (1 / 2 : ℝ) ∈ hcZ0 := Or.inr rfl
  exact ⟨hc, hs, hf.measure_zero _, hl, hr, g1Bounds_hcGap hc hs hl hr⟩

/-- **FS111-M3-HC**, first clause: for every closed null `Z ⊆ [−1/2, 1/2]` holding `±1/2` and every gap function with (G1)'s
bounds, `int HC` is a regular MUA set with support `HC`, and HC satisfies FS111-M2-FIX: `int HC = ℝ² ∖ (HC + S¹)`. -/
theorem hc_isRegularMUA {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZ0 : volume Z = 0)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    IsRegularMUA (interior (hcSet g)) ∧ essSupport (interior (hcSet g)) = hcSet g ∧
      interior (hcSet g) = (unitShadow (hcSet g))ᶜ := by
  have hZi : interior Z = ∅ := Measure.interior_eq_empty_of_null hZ0
  have hAo : IsOpen (interior (hcSet g)) := isOpen_interior
  have hav := hc_unitAvoiding hZc hZs hZi hl hr hg
  have hnull : UnitPairsNull (interior (hcSet g)) := by
    have : unitPairSet (interior (hcSet g)) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro hx hy
      exact hav _ hy _ hx (by rw [dist_eq_norm, add_sub_cancel_left, norm_e])
    rw [UnitPairsNull, this, measure_empty]
  have hMUA : IsMUA (interior (hcSet g)) :=
    (isMUA_iff_ae_phi_pos hAo.measurableSet hnull).2 (hc_ae_phi_pos hZc hZs hZi hl hr hg hZ0)
  have hci := closure_interior_hcSet hZc hZs hZi hl hr hg
  have hsupp : essSupport (interior (hcSet g)) = hcSet g := by rw [essSupport_of_isOpen hAo, hci]
  have hcl := isClosed_hcSet hZc hZs hZi hl hr hg
  have hfr := volume_frontier_hcSet hZc hZs hZi hl hr hg
  refine ⟨⟨hMUA, ?_, ?_⟩, hsupp, ?_⟩
  · rw [hsupp]
    refine measure_mono_null (fun z hz => ?_) hfr
    rw [hcl.frontier_eq]; exact hz
  · rw [hsupp]; exact hfr
  · apply Subset.antisymm
    · have := subset_compl_unitShadow_closure hAo hav
      rwa [hci] at this
    · intro z hz
      by_contra hzA
      exact hz (hc_exclusion hZc hZs hZi hl hr hg hzA)

/-- **FS111-M3-HC**, second clause, at every `Z` (wider: the row says "with `Z` a Cantor set"; the argument reads only that `g`
vanishes exactly on `Z`): each band has one component per gap — two of its points lie in one component iff no point of `Z` lies
between their `s` coordinates. With `Z` the Cantor set (HC_K), infinitely many. -/
theorem hc_band_components {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZ0 : volume Z = 0)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3)
    {s₁ t₁ s₂ t₂ : ℝ} (hs₁ : |s₁| < 1 / 2) (ht₁ : 1 < t₁) (ht₁' : t₁ < hcBandTop g m n j s₁) (hs₂ : |s₂| < 1 / 2)
    (ht₂ : 1 < t₂) (ht₂' : t₂ < hcBandTop g m n j s₂) :
    connectedComponentIn (hcBand g m n j) (hcFrame m n j s₁ t₁) =
        connectedComponentIn (hcBand g m n j) (hcFrame m n j s₂ t₂) ↔ Disjoint (uIcc s₁ s₂) Z := by
  have hZi : interior Z = ∅ := Measure.interior_eq_empty_of_null hZ0
  have h₁ : hcFrame m n j s₁ t₁ ∈ hcBand g m n j := ⟨s₁, t₁, hs₁, ht₁, ht₁', rfl⟩
  have h₂ : hcFrame m n j s₂ t₂ ∈ hcBand g m n j := ⟨s₂, t₂, hs₂, ht₂, ht₂', rfl⟩
  rw [← hcBand_component_iff hZc hZs hZi hl hr hg m n j h₁ h₂]
  constructor
  · intro h
    refine ⟨_, connectedComponentIn_subset _ _, isPreconnected_connectedComponentIn, mem_connectedComponentIn h₁, ?_⟩
    rw [h]; exact mem_connectedComponentIn h₂
  · rintro ⟨S, hSF, hSc, hx, hy⟩
    exact connectedComponentIn_eq (hSc.subset_connectedComponentIn hx hSF hy)

/-! ## FS111-M3-IRREG and FS111-M3-FIXCONV: a fat pinch -/

/-- The radius removed about the `n`-th rational `q`: `min (4^{−(n+2)}) (dist(q, {±1/2})/2)`, so `±1/2` survive. -/
noncomputable def fatR (n : ℕ) : ℝ :=
  let q : ℝ := (Denumerable.ofNat ℚ n : ℚ)
  min ((1 / 4) ^ (n + 2)) (min |q - 1 / 2| |q + 1 / 2| / 2)

/-- **A fat nowhere dense set**: `[−1/2, 1/2]` minus the open intervals of radius `fatR n` about the rationals — closed, with
empty interior (the rationals are dense), of length at least `5/6`, holding `±1/2`. -/
noncomputable def fatZ : Set ℝ :=
  Icc (-1 / 2) (1 / 2) \ ⋃ n : ℕ, ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n)

/-- `fatZ` is what FS111-M3-IRREG needs. -/
theorem fatZ_spec : IsClosed fatZ ∧ fatZ ⊆ Icc (-1 / 2) (1 / 2) ∧ interior fatZ = ∅ ∧ 0 < volume fatZ ∧
    (-1 / 2 : ℝ) ∈ fatZ ∧ (1 / 2 : ℝ) ∈ fatZ := by
  have hR0 : ∀ n, 0 ≤ fatR n := fun n => by
    unfold fatR
    refine le_min (by positivity) (by positivity)
  have hRle : ∀ n, fatR n ≤ (1 / 4) ^ (n + 2) := fun n => min_le_left _ _
  have hRq1 : ∀ n, fatR n ≤ |((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2| := fun n => by
    unfold fatR
    refine (min_le_right _ _).trans ?_
    have := min_le_left |((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2| |((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2|
    have := abs_nonneg (((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2)
    linarith
  have hRq2 : ∀ n, fatR n ≤ |((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2| := fun n => by
    unfold fatR
    refine (min_le_right _ _).trans ?_
    have := min_le_right |((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2| |((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2|
    have := abs_nonneg (((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2)
    linarith
  have hends : ∀ a : ℝ, (a = 1 / 2 ∨ a = -1 / 2) → a ∈ fatZ := by
    intro a ha
    refine ⟨by rcases ha with rfl | rfl <;> norm_num, ?_⟩
    simp only [mem_iUnion, mem_ball, not_exists, not_lt]
    intro n
    rcases ha with rfl | rfl
    · rw [Real.dist_eq, abs_sub_comm]; exact hRq1 n
    · rw [Real.dist_eq, abs_sub_comm]
      have := hRq2 n
      rwa [show ((Denumerable.ofNat ℚ n : ℚ) : ℝ) - -1 / 2 = ((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2 by ring]
  refine ⟨isClosed_Icc.sdiff (isOpen_iUnion fun _ => isOpen_ball), sdiff_subset, ?_, ?_,
    hends _ (Or.inr rfl), hends _ (Or.inl rfl)⟩
  · refine eq_empty_of_forall_notMem fun x hx => ?_
    obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.1 (mem_interior_iff_mem_nhds.1 hx)
    have hV : IsOpen (ball x ε \ {1 / 2, -1 / 2}) :=
      isOpen_ball.sdiff (Set.toFinite _).isClosed
    have hne : (ball x ε \ {1 / 2, -1 / 2}).Nonempty := by
      have hinf : (Ioo (x - ε) (x + ε)).Infinite := Set.Ioo_infinite (by linarith)
      obtain ⟨y, hy1, hy2⟩ := (hinf.sdiff (Set.toFinite ({1 / 2, -1 / 2} : Set ℝ))).nonempty
      exact ⟨y, by rw [mem_ball, Real.dist_eq, abs_lt]; constructor <;> linarith [hy1.1, hy1.2], hy2⟩
    obtain ⟨q, hq⟩ := Rat.denseRange_cast.exists_mem_open hV hne
    obtain ⟨n, hn⟩ : ∃ n : ℕ, (Denumerable.ofNat ℚ n : ℚ) = q := ⟨Denumerable.eqv ℚ q, (Denumerable.eqv ℚ).symm_apply_apply q⟩
    have hq1 : (q : ℝ) ≠ 1 / 2 := fun h => hq.2 (Or.inl h)
    have hq2 : (q : ℝ) ≠ -1 / 2 := fun h => hq.2 (Or.inr h)
    have hR : 0 < fatR n := by
      unfold fatR
      simp only [hn]
      have a1 : 0 < |(q : ℝ) - 1 / 2| := abs_pos.2 (sub_ne_zero.2 hq1)
      have a2 : 0 < |(q : ℝ) + 1 / 2| := abs_pos.2 fun h => hq2 (by linarith)
      exact lt_min (by positivity) (div_pos (lt_min a1 a2) two_pos)
    have hqF : (q : ℝ) ∈ fatZ := hball hq.1
    exact hqF.2 (mem_iUnion.2 ⟨n, by rw [hn]; exact mem_ball_self hR⟩)
  · have hU : volume (⋃ n : ℕ, ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n)) ≤ ENNReal.ofReal (1 / 6) := by
      refine (measure_iUnion_le _).trans ?_
      have hg : HasSum (fun n : ℕ => 2 * (1 / 4 : ℝ) ^ (n + 2)) (1 / 6) := by
        have := (hasSum_geometric_of_lt_one (r := (1 / 4 : ℝ)) (by norm_num) (by norm_num)).mul_left (2 * (1 / 4) ^ 2)
        have e : (fun n : ℕ => 2 * (1 / 4 : ℝ) ^ (n + 2)) = fun n : ℕ => 2 * (1 / 4) ^ 2 * (1 / 4) ^ n := by
          funext n; ring
        have e2 : (2 * (1 / 4 : ℝ) ^ 2 * (1 - 1 / 4)⁻¹) = 1 / 6 := by norm_num
        rw [e, ← e2]; exact this
      calc ∑' n : ℕ, volume (ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n))
          ≤ ∑' n : ℕ, ENNReal.ofReal (2 * (1 / 4 : ℝ) ^ (n + 2)) := by
            refine ENNReal.tsum_le_tsum fun n => ?_
            rw [Real.volume_ball]
            exact ENNReal.ofReal_le_ofReal (by linarith [hRle n])
        _ = ENNReal.ofReal (1 / 6) := by
            rw [← ENNReal.ofReal_tsum_of_nonneg (fun n => by positivity) hg.summable, hg.tsum_eq]
    have hI : volume (Icc (-1 / 2 : ℝ) (1 / 2)) = 1 := by
      rw [Real.volume_Icc]; norm_num
    have h1 : volume (Icc (-1 / 2 : ℝ) (1 / 2)) - volume (⋃ n : ℕ, ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n))
        ≤ volume fatZ := le_measure_sdiff
    have h2 : 0 < (1 : ENNReal) - ENNReal.ofReal (1 / 6) := by
      rw [tsub_pos_iff_lt]
      exact (ENNReal.ofReal_lt_one.2 (by norm_num))
    refine lt_of_lt_of_le ?_ h1
    rw [hI]
    exact lt_of_lt_of_le h2 (tsub_le_tsub le_rfl hU)

/-- `fatZ` is closed (spec, sorry-free). -/
example : IsClosed fatZ := isClosed_Icc.sdiff (isOpen_iUnion fun _ => isOpen_ball)

/-- **FS111-M3-IRREG**, at the class its argument reads (wider: any closed `Z ⊆ [−1/2, 1/2]` with empty interior and positive
length holding `±1/2`, any `g` with (G1)'s bounds; the row's Smith–Volterra–Cantor `Z_f` is one): `A = int HC(g)` is
unit-avoiding (no two points at distance `1`), regular (`cl A = HC`, `|HC ∖ A| = 0`, `|∂HC| = 0`) and satisfies the shadow
identity, but is not a MUA set, and every MUA set containing it up to null sets has a boundary of its support of positive
measure. -/
theorem hc_irreg {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hZpos : 0 < volume Z) (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    (∀ x ∈ interior (hcSet g), ∀ y ∈ interior (hcSet g), dist x y ≠ 1) ∧ closure (interior (hcSet g)) = hcSet g ∧
      volume (hcSet g \ interior (hcSet g)) = 0 ∧ volume (frontier (hcSet g)) = 0 ∧
      interior (hcSet g) = (unitShadow (hcSet g))ᶜ ∧ ¬ IsMUA (interior (hcSet g)) ∧
      ∀ A' : Set ℂ, IsMUA A' → interior (hcSet g) ≤ᵐ[volume] A' → 0 < volume (frontier (essSupport A')) := by
  have hAo : IsOpen (interior (hcSet g)) := isOpen_interior
  have hAm : MeasurableSet (interior (hcSet g)) := hAo.measurableSet
  have hav := hc_unitAvoiding hZc hZs hZi hl hr hg
  have hci := closure_interior_hcSet hZc hZs hZi hl hr hg
  have hcl := isClosed_hcSet hZc hZs hZi hl hr hg
  have hfr := volume_frontier_hcSet hZc hZs hZi hl hr hg
  have hdiff : volume (hcSet g \ interior (hcSet g)) = 0 := by rw [← hcl.frontier_eq]; exact hfr
  have hnullA : UnitPairsNull (interior (hcSet g)) := by
    have : unitPairSet (interior (hcSet g)) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro hx hy
      exact hav _ hy _ hx (by rw [dist_eq_norm, add_sub_cancel_left, norm_e])
    rw [UnitPairsNull, this, measure_empty]
  have hshadow : interior (hcSet g) = (unitShadow (hcSet g))ᶜ := by
    apply Subset.antisymm
    · have := subset_compl_unitShadow_closure hAo hav
      rwa [hci] at this
    · intro z hz
      by_contra hzA
      exact hz (hc_exclusion hZc hZs hZi hl hr hg hzA)
  have hEpos := hc_free_pos hZc hZs hZi hl hr hg hZpos
  have hnotMUA : ¬ IsMUA (interior (hcSet g)) := by
    intro hM
    have h := (isMUA_iff_ae_phi_pos hAm hnullA).1 hM
    rw [ae_iff, Measure.restrict_apply' hAm.compl] at h
    have hsub : {z | z ∉ hcSet g ∧ phi (interior (hcSet g)) z = 0} ⊆
        {p | ¬ 0 < phi (interior (hcSet g)) p} ∩ (interior (hcSet g))ᶜ := by
      intro z hz
      refine ⟨?_, fun hzA => hz.1 (interior_subset hzA)⟩
      simp only [mem_setOf_eq, not_lt, nonpos_iff_eq_zero]; exact hz.2
    exact hEpos.ne' (measure_mono_null hsub h)
  refine ⟨hav, hci, hdiff, hfr, hshadow, hnotMUA, fun A' hA' hle => ?_⟩
  obtain ⟨K, hKc, hKi, hEK⟩ := hc_free_subset_nowhereDense hZc hZs hZi hl hr hg
  have hA'm := hA'.1
  have hphi' : ∀ᵐ z ∂volume, z ∈ A' → phi A' z = 0 :=
    (ae_restrict_iff' hA'm).1 ((unitPairsNull_iff_ae_phi_eq_zero hA'm).1 hA'.2.1)
  have hsub0 : volume (interior (hcSet g) \ A') = 0 := ae_le_set.1 hle
  have hphiA : ∀ᵐ z ∂volume, phi (interior (hcSet g)) z ≤ phi A' z := by
    filter_upwards [ae_arcLength_null (hAm.diff hA'm) hsub0] with z hz
    calc phi (interior (hcSet g)) z ≤ arcLength ({θ | z + e θ ∈ A'} ∪ {θ | z + e θ ∈ interior (hcSet g) \ A'}) :=
          measure_mono fun θ hθ => by
            by_cases h : z + e θ ∈ A'
            · exact Or.inl h
            · exact Or.inr ⟨hθ, h⟩
      _ ≤ phi A' z := (measure_union_le _ _).trans_eq (by rw [hz, add_zero]; rfl)
  have hA'E : A' \ hcSet g ≤ᵐ[volume] K := by
    filter_upwards [hphi', hphiA] with z h1 h2
    intro hz
    exact hEK ⟨hz.2, le_antisymm (h2.trans (h1 hz.1).le) zero_le⟩
  have hpos : 0 < volume (A' \ hcSet g) := by
    refine pos_iff_ne_zero.2 fun h0 => hnotMUA ?_
    have hA'A : A' ≤ᵐ[volume] interior (hcSet g) := by
      rw [ae_le_set]
      refine measure_mono_null (fun z hz => ?_) (measure_union_null h0 hdiff)
      by_cases h : z ∈ hcSet g
      · exact Or.inr ⟨h, hz.2⟩
      · exact Or.inl ⟨hz.1, h⟩
    exact ⟨hAm, hnullA, fun B hB hBn hAB => (hA'.2.2 B hB hBn (hA'A.trans hAB)).trans hA'A⟩
  exact frontier_essSupport_pos hcl hKc hKi hpos hA'E

/-- **FS111-M3-IRREG**, its conclusion: "every MUA set is regular" (MUA-REG-U) is false. -/
theorem not_forall_isRegularMUA : ¬ ∀ A : Set ℂ, IsMUA A → IsRegularMUA A := by
  intro h
  obtain ⟨hc, hs, hi, hpos, hl, hr⟩ := fatZ_spec
  obtain ⟨h1, -, -, -, -, -, h7⟩ := hc_irreg hc hs hi hpos hl hr (g1Bounds_hcGap hc hs hl hr)
  have hmeas : MeasurableSet (interior (hcSet (hcGap fatZ))) := isOpen_interior.measurableSet
  have hnull : UnitPairsNull (interior (hcSet (hcGap fatZ))) := by
    have : unitPairSet (interior (hcSet (hcGap fatZ))) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro hx hy
      exact h1 _ hy _ hx (by rw [dist_eq_norm, add_sub_cancel_left, norm_e])
    rw [UnitPairsNull, this, measure_empty]
  obtain ⟨A', hA', hle⟩ := exists_isMUA_ae_le hmeas hnull
  exact (h7 A' hA' hle).ne' (h A' hA').2.2

/-- **FS111-M3-FIXCONV**: the converse of FS111-M2-FIX fails — a closed regular set (`cl int F = F`, `|∂F| = 0`) whose interior
has null unit pairs and satisfies `int F = ℝ² ∖ (F + S¹)` need not have a maximal interior (`F = HC(g)` over `fatZ`). -/
theorem not_forall_fix_converse :
    ¬ ∀ F : Set ℂ, IsClosed F → closure (interior F) = F → volume (frontier F) = 0 → UnitPairsNull (interior F) →
      interior F = (unitShadow F)ᶜ → IsMUA (interior F) := by
  intro h
  obtain ⟨hc, hs, hi, hpos, hl, hr⟩ := fatZ_spec
  obtain ⟨h1, h2, -, h4, h5, h6, -⟩ := hc_irreg hc hs hi hpos hl hr (g1Bounds_hcGap hc hs hl hr)
  refine h6 (h _ ?_ h2 h4 ?_ h5)
  · rw [← h2]; exact isClosed_closure
  · have : unitPairSet (interior (hcSet (hcGap fatZ))) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro hx hy
      exact h1 _ hy _ hx (by rw [dist_eq_norm, add_sub_cancel_left, norm_e])
    rw [UnitPairsNull, this, measure_empty]

end HadwigerNelson.Plane
