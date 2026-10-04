import Proofs.HadwigerNelson.Plane.MaximalCover
import Proofs.HadwigerNelson.Plane.Slack
import Mathlib.Analysis.Convex.Hull
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
  sorry

/-- Up colours are `< 4`, down colours `≥ 4`: an up tile and a down tile never share a colour. -/
theorem r7UpCol_ne_r7DownCol (m n m' n' : ℤ) : r7UpCol m n ≠ r7DownCol m' n' := by
  intro h
  have := congrArg Fin.val h
  simp only [r7UpCol, r7DownCol] at this
  omega

/-- **Within one up tile** a unit pair has a vertex at one end and the opposite arc at the other, so `x` is at distance `1` from
a lattice point. -/
theorem r7Up_unitPair {m n : ℤ} {x y : ℂ} (hx : x ∈ r7Up m n) (hy : y ∈ r7Up m n) (hxy : dist x y = 1) :
    ∃ m' n' : ℤ, dist x (tri m' n') = 1 := by
  sorry

/-- **Two up tiles of one colour** (`λ' − λ ∈ 2Λ ∖ 0`) meet the unit distance only at a pair of lattice points (a half-plane
separation along the offset; offsets of length `> 2` are too far). -/
theorem r7Up_sep {m n m' n' : ℤ} (hne : (m, n) ≠ (m', n')) (hc : r7UpCol m n = r7UpCol m' n') {x y : ℂ}
    (hx : x ∈ r7Up m n) (hy : y ∈ r7Up m' n') (hxy : dist x y = 1) : ∃ m'' n'' : ℤ, dist x (tri m'' n'') = 1 := by
  sorry

/-- **Down tiles carry no unit pair of one colour**: within a tile (inside a unit triangle, vertices excluded) and across tiles
of one colour (`λ' − λ ∈ M ∖ 0`, the bulges keep them apart). -/
theorem r7Down_dist_ne_one {m n m' n' : ℤ} (hc : r7DownCol m n = r7DownCol m' n') {x y : ℂ} (hx : x ∈ r7Down m n)
    (hy : y ∈ r7Down m' n') : dist x y ≠ 1 := by
  sorry

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

/-- **R7's boundary at a lattice point**: of the classes with positive upper density at `tri m n` (only its three up colours —
the cusps have density `0`), every two have a common centre at distance `1` in both supports (`λ₀ + 1`, `λ₀ + ω`, `λ₀ + ω − 1`). -/
theorem r7_boundary_lattice {m n : ℤ} {a b : Fin 7} (hab : a ≠ b) (ha : tri m n ∈ essClosure (r7Cls a))
    (hb : tri m n ∈ essClosure (r7Cls b)) :
    ∃ m' n' : ℤ, dist (tri m n) (tri m' n') = 1 ∧ tri m' n' ∈ essSupport (r7Cls a) ∧ tri m' n' ∈ essSupport (r7Cls b) := by
  sorry

/-- **R7's boundary off the lattice**: two classes meet only on an arc of an up tile facing a down tile, centred at a vertex `v`
of the up tile; `v` is in the up colour's support (a vertex) and in the down colour's (the cusp of that colour at `v`, by
M-R7-FORCE's coset computation: `D(m − 1, n − 1)` for the arc about `λ`, `D(m − 1, n + 1)` for the arc about `λ + ω`). -/
theorem r7_boundary_offLattice {x : ℂ} (hx : ∀ m n : ℤ, x ≠ tri m n) {a b : Fin 7} (hab : a ≠ b)
    (ha : x ∈ essClosure (r7Cls a)) (hb : x ∈ essClosure (r7Cls b)) :
    ∃ m n : ℤ, dist x (tri m n) = 1 ∧ tri m n ∈ essSupport (r7Cls a) ∧ tri m n ∈ essSupport (r7Cls b) := by
  sorry

/-- **R7's classes are maximal, up colours**: for almost every point off an up class, the unit circle about it crosses an open
disc inside a tile of that colour (one period, finitely many explicit witness discs). -/
theorem r7_phi_pos_up {j : Fin 7} (hj : j.val < 4) : ∀ᵐ p ∂(volume.restrict (r7Cls j)ᶜ), 0 < phi (r7Cls j) p := by
  sorry

/-- **R7's classes are maximal, down colours.** -/
theorem r7_phi_pos_down {j : Fin 7} (hj : 4 ≤ j.val) : ∀ᵐ p ∂(volume.restrict (r7Cls j)ᶜ), 0 < phi (r7Cls j) p := by
  sorry

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

theorem r7ColTri_four {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (ha1 : a < 1) (hb1 : b < 1) (h1 : 1 < triQ a b)
    (h2 : 1 < triQ (a - 2) b) (h3 : 1 < triQ a (b - 2)) : r7ColTri a b = 4 := by
  have e1 : ⌊a⌋ = 0 := Int.floor_eq_zero_iff.2 ⟨ha.le, ha1⟩
  have e2 : ⌊b⌋ = 0 := Int.floor_eq_zero_iff.2 ⟨hb.le, hb1⟩
  unfold r7ColTri
  simp only [e1, e2, Int.cast_zero, sub_zero]
  rw [if_neg (not_le.2 h1), if_neg (not_le.2 h2), if_neg (not_le.2 h3)]
  rfl

theorem triQ_far_gt {a b : ℝ} (ha : 0.35 < a) (ha' : a < 0.51) (hb : 0.65 < b) (hb' : b < 0.81) :
    1 < triQ (a - 2) b ∧ 1 < triQ a (b - 2) := by
  unfold triQ
  constructor <;> nlinarith [mul_pos (sub_pos.2 ha) (sub_pos.2 hb), mul_pos (sub_pos.2 ha') (sub_pos.2 hb')]

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
  sorry

/-- `hcGap Z` is differentiable on `ℝ`, with `|g′| ≤ dist(·, Z)/2` on `[−1/2, 1/2]` (`g′ = 0` on `Z` because `g ≤ dist²/4`). -/
theorem differentiable_hcGap {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) :
    Differentiable ℝ (hcGap Z) ∧ ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), |deriv (hcGap Z) s| ≤ infDist s Z / 2 := by
  sorry

/-- (G1)'s pointwise bounds on `[−1/2, 1/2]`: `0 ≤ g ≤ dist²/4`, `g ≤ 1/64`, `|g′| ≤ 1/8`, `g > 0` off `Z` (gaps have width
`≤ 1`). -/
theorem hcGap_bounds {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) :
    ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), 0 ≤ hcGap Z s ∧ hcGap Z s ≤ infDist s Z ^ 2 / 4 ∧ hcGap Z s ≤ 1 / 64 ∧
      |deriv (hcGap Z) s| ≤ 1 / 8 ∧ (s ∉ Z → 0 < hcGap Z s) := by
  sorry

/-- The lower-parabola bound: `g′` is `1/2`-Lipschitz on `[−1/2, 1/2]` (`|g″| ≤ 1/2` on gaps, `g′ = 0` on `Z`), then Taylor. -/
theorem hcGap_lowerParabola {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) :
    ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), ∀ σ ∈ Icc (-1 / 2 : ℝ) (1 / 2),
      hcGap Z σ + deriv (hcGap Z) σ * (s - σ) - (s - σ) ^ 2 / 4 ≤ hcGap Z s := by
  sorry

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
  sorry

/-- **(G2)**: the graph `t = 2 + g(s)`, `|s| ≤ 1/2`, of every side lies in `U` (the three slivers are disjoint and miss the other
sides' curves: `g ≤ (1/2 − |s|)²/4` against the corner distance `0.8 (1/2 − |s|)`). -/
theorem hcUp_slivers {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) :
    hcFrame m n j s (2 + g s) ∈ hcUp g m n := by
  sorry

/-- **(G3)**, bounds: `1 ≤ ℓ ≤ 1 + g`, and `ℓ(s) = 1` iff `s ∈ Z`. -/
theorem hcBandTop_bounds {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) :
    1 ≤ hcBandTop g m n j s ∧ hcBandTop g m n j s ≤ 1 + g s ∧ (hcBandTop g m n j s = 1 ↔ s ∈ Z) := by
  sorry

/-- **(G3)**, the band below `t = 2` is exactly where `d_U > 1` (`d_U` strictly decreasing in `t` there). -/
theorem lt_hcBandTop_iff {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s t : ℝ} (hs : s ∈ Icc (-1 / 2 : ℝ) (1 / 2)) (ht : t < 2) :
    t < hcBandTop g m n j s ↔ 1 < infDist (hcFrame m n j s t) (hcUp g m n) := by
  sorry

/-- **(G3)**, continuity of `ℓ`. -/
theorem continuousOn_hcBandTop {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) :
    ContinuousOn (hcBandTop g m n j) (Icc (-1 / 2 : ℝ) (1 / 2)) := by
  sorry

/-- HC is closed (a locally finite union of closed blocks). -/
theorem isClosed_hcSet {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : IsClosed (hcSet g) := by
  sorry

/-- HC is the closure of its interior (each block is; `Z` has empty interior, so `σ_e ⊆ cl Λ_e`). -/
theorem closure_interior_hcSet {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : closure (interior (hcSet g)) = hcSet g := by
  sorry

/-- HC's frontier is null: segments, circles and graphs of continuous functions, locally finitely many. -/
theorem volume_frontier_hcSet {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : volume (frontier (hcSet g)) = 0 := by
  sorry

/-- **The band has diameter `< 1`**: it thins to `0` quadratically at both ends (§ 2.3: `|z₁ − z₂|² < 1 − σ + σ² ≤ 1`). -/
theorem hc_band_dist_lt_one {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {x y : ℂ} (hx : x ∈ hcBand g m n j) (hy : y ∈ hcBand g m n j) :
    dist x y < 1 := by
  sorry

/-- **§ 2.3, unit-avoiding**: no two points of `int HC` are at distance `1` — the block-distance table H1 (exact in `ℚ(√3)`, one
period), the band within `1/64` of `σ_e`, the flanking pairs (`Λ_e ⊆ {t > 1}`, `d_U > 1` on `Λ_e`), diameters. **Split at
implementation** into the table and the flanking pairs. -/
theorem hc_unitAvoiding {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) : ∀ x ∈ interior (hcSet g), ∀ y ∈ interior (hcSet g), dist x y ≠ 1 := by
  sorry

/-- Every point is within `L` of a face centre (the face lattice's covering radius). -/
theorem exists_near_hcFace (z : ℂ) : ∃ m n : ℤ, dist z (hcFace m n) ≤ hcL := by
  sorry

/-- **B1, the sausage cover (flat skeleton)**: every point is within `1` of a flat triangle or a segment, or within `3/2` of a face
centre — the fundamental triangle `O C M` with H3's quadrilateral `Q ⊆ B̄(v, 1) ∪ B̄(e, 1)`, carried around each face by the 60°
rotations (`exists_near_hcFace`). -/
theorem hc_sausage_cover (z : ℂ) :
    (∃ m n : ℤ, infDist z (hcDownTri m n) ≤ 1) ∨ (∃ m n : ℤ, infDist z (hcUpTri m n) ≤ 1) ∨
      (∃ (m n : ℤ) (j : Fin 3), infDist z (hcSeg m n j) ≤ 1) ∨ ∃ m n : ℤ, dist z (hcFace m n) ≤ 3 / 2 := by
  sorry

/-- **Lemma NL**: a sliver point `(s, t)`, `2 < t ≤ 2 + g(s)`, is at distance `1` from a point of `cl Λ_e` (of `Λ_e` when
`t < 2 + g(s)`) — the exterior disc of radius `5/4`, H5's constants. -/
theorem hc_lemmaNL {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3) {s t : ℝ} (hs : |s| < 1 / 2) (ht : 2 < t) (htg : t ≤ 2 + g s) :
    ∃ p ∈ closure (hcBand g m n j), dist (hcFrame m n j s t) p = 1 := by
  sorry

/-- **B2, the exclusion**: every point outside `int HC` is at distance `1` from HC — B1's cases with (C0) (`vesica_apex` in the
edge frame, through `dist_hcFrame`), (G3) and Lemma NL. -/
theorem hc_exclusion {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) {z : ℂ} (hz : z ∉ interior (hcSet g)) : z ∈ unitShadow (hcSet g) := by
  sorry

/-- **§ 2.4, almost everywhere**: with `Z` null, almost every point off `int HC` has `φ > 0` — the exclusion inequalities strict off
null level sets, `N_e = (Z × {1} + S¹) ∪ T₁(e±)` null, and `E°`-points see an open arc of a block's interior. -/
theorem hc_ae_phi_pos {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (hZ0 : volume Z = 0) :
    ∀ᵐ z ∂(volume.restrict (interior (hcSet g))ᶜ), 0 < phi (interior (hcSet g)) z := by
  sorry

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
  sorry

/-- **IRREG (1), `|E| > 0`**: with `Z` of positive length, the bulge points whose unit circle crosses `t = 1` at two points of
`Z` see no point of `int HC` (the arc passes above the band: `t·d/r > d²/4`), and they have positive measure (density points of
`Z × Z` through the local diffeomorphism `(s, t) ↦ (s + r, s − r)`). -/
theorem hc_free_pos {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (hZpos : 0 < volume Z) :
    0 < volume {z | z ∉ hcSet g ∧ phi (interior (hcSet g)) z = 0} := by
  sorry

/-- **IRREG (2)**: the free points lie in a closed nowhere dense set (null level sets, flat side lines, the circles about `σ_e`'s
ends, and `K_e = ⋃_{c ∈ Z} T₁((c, 1))`, nowhere dense by Baire on `(Z − ρ) ∪ (Z + ρ)`). -/
theorem hc_free_subset_nowhereDense {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    ∃ K : Set ℂ, IsClosed K ∧ interior K = ∅ ∧ {z | z ∉ hcSet g ∧ phi (interior (hcSet g)) z = 0} ⊆ K := by
  sorry

/-- **IRREG (3), general**: a set `A′` whose part outside a closed `F` has positive measure and lies a.e. in a closed nowhere
dense `K` has a support whose frontier has positive measure (density points of `A′ ∖ F` are boundary points of `supp A′`). -/
theorem frontier_essSupport_pos {A' F K : Set ℂ} (hF : IsClosed F) (hK : IsClosed K) (hKi : interior K = ∅)
    (hS : 0 < volume (A' \ F)) (hsub : A' \ F ≤ᵐ[volume] K) : 0 < volume (frontier (essSupport A')) := by
  sorry

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
  sorry

/-- **FS111-M3-HC**, second clause, at every `Z` (wider: the row says "with `Z` a Cantor set"; the argument reads only that `g`
vanishes exactly on `Z`): each band has one component per gap — two of its points lie in one component iff no point of `Z` lies
between their `s` coordinates. With `Z` the Cantor set (HC_K), infinitely many. -/
theorem hc_band_components {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZ0 : volume Z = 0)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3)
    {s₁ t₁ s₂ t₂ : ℝ} (hs₁ : |s₁| < 1 / 2) (ht₁ : 1 < t₁) (ht₁' : t₁ < hcBandTop g m n j s₁) (hs₂ : |s₂| < 1 / 2)
    (ht₂ : 1 < t₂) (ht₂' : t₂ < hcBandTop g m n j s₂) :
    connectedComponentIn (hcBand g m n j) (hcFrame m n j s₁ t₁) =
        connectedComponentIn (hcBand g m n j) (hcFrame m n j s₂ t₂) ↔ Disjoint (uIcc s₁ s₂) Z := by
  sorry

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
  sorry

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
