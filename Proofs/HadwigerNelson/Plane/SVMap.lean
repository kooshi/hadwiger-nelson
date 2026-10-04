import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Instances.Seven
import Proofs.HadwigerNelson.Topology.LebesgueCovering

/-!
# Almost-everywhere-proper maps, region-only: lemma (L) and TS-T (FS-106)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 7), the two rows FS131-W (Woodall's chain: FS106-WO, FS106-TW, FS106-AE-MAP6,
inventory ruling 54) branches from. Both rows are **region-only** (`plans/FS106-derivation.md`'s header: "a step that reads no colour at
a boundary point"), so both are stated over open colour classes, never over a map's boundaries:

* **FS106-L** (`lemmaL`): in a two-coloured open set `W` (`W ⊆ cl (A ∪ B)`, `A`, `B` open, no two points of one class at distance
  exactly `1`), a point `b ∈ W` with both colours arbitrarily near has its unit circle outside `W`. `b ∈ W` cannot be dropped
  (`not_lemmaL_of_not_mem`: a counterexample with `b` on the frontier of `W`).
* **The regions of an almost-everywhere-proper map** (`AeProperRegions k`, D-AEMAP read region-only): `k` open colour classes, no two
  points of one class at distance `1`, dense union, finitely many components of the classes near every point (S–V's Condition 3). The
  **multicolour** (`multicolour`, D-VMC and S–V's Definition 2) is the set of colours whose class has the point in its closure; its
  `ncard` is the chromaticity. A valid map of the plane gives one (`ArcMap.toAeProperRegions`), and `ArcMap.coloursAt` is its
  multicolour by definition.
* **FS106-TS-T**: a point of chromaticity `≥ 3` within `1/√2 + ε` of every point
  (`AeProperRegions.exists_three_le_multicolour`, SB's route through **Lebesgue's covering theorem** for the square,
  `lebesgue_covering_square` — held in the kernel by FS131-LEB, `Topology/LebesgueCovering`) and within `1` (TS's form); for arc maps (`ArcMap.ts_t`), a point of chromaticity `≥ 3` has degree `≥ 3` (`ArcMap.exists_hasDegree_of_mem_dom`), at most
  three colours everywhere (S–V Lemma 2's conclusion under Condition 5, not a backlog row) makes it trichromatic, and Condition 6
  (`ArcMap.Condition6`) of degree `3`.
* **The inhabitant**: `sevenBrickMap`, the brick seven-colouring of `Instances/Seven` (M36) as an arc map of the plane, valid.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## FS106-L -/

/-- **FS106-L** (lemma (L), `plans/FS106-V-verification.md` V3 stage 1, region-only): in a two-coloured open set `W` with no
monochrome unit — `W ⊆ cl (A ∪ B)` for open classes `A`, `B`, no two points of one class at distance exactly `1` — a two-colour
change point `b` of `W` (a point of `W` with both colours arbitrarily near) has its unit circle outside `W`. (Disjointness of `A` and
`B` is not read.) -/
theorem lemmaL {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hW : IsOpen W) (hWAB : W ⊆ closure (A ∪ B))
    (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {b : ℂ} (hbW : b ∈ W)
    (hbA : b ∈ closure A) (hbB : b ∈ closure B) : Disjoint (sphere b 1) W := by
  sorry

/-- **Adversary for FS106-L's reading**: the change point must lie in `W`. With `b = 0` on the frontier of `W`, `A` a thin cone at
`0` pointing away from `1` together with the part of `B(1, r)` outside `B̄(0, 1)`, and `B` the opposite cone together with the part of
`B(1, r)` inside, both classes avoid the unit distance, `0 ∈ cl A ∩ cl B`, and `1 ∈ ω(0) ∩ W`. -/
theorem not_lemmaL_of_not_mem :
    ¬ ∀ (A B W : Set ℂ) (b : ℂ), IsOpen A → IsOpen B → IsOpen W → W ⊆ closure (A ∪ B) →
      (∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) → (∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) → b ∈ closure A → b ∈ closure B →
      Disjoint (sphere b 1) W := by
  intro h
  have hdist : ∀ x y : ℂ, dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    intro x y
    rw [Complex.dist_eq, Complex.sq_norm, Complex.normSq_apply]; simp; ring
  have hne : ∀ x y : ℂ, (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 ≠ 1 → dist x y ≠ 1 := by
    intro x y hxy hd; apply hxy; rw [← hdist, hd]; norm_num
  have hlt : ∀ x y : ℂ, (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 → dist x y ≠ 1 := by
    intro x y hxy; exact hne x y hxy.ne
  have hgt : ∀ x y : ℂ, 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 → dist x y ≠ 1 := by
    intro x y hxy; exact hne x y hxy.ne'
  -- the sets
  set A0 : Set ℂ := {z | z.re < 0 ∧ 2 * |z.im| < -z.re ∧ z.re ^ 2 + z.im ^ 2 < 1 / 16} with hA0
  set B0 : Set ℂ := {z | 0 < z.re ∧ 2 * |z.im| < z.re ∧ z.re ^ 2 + z.im ^ 2 < 1 / 16} with hB0
  set A1 : Set ℂ := {z | (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100 ∧ 1 < z.re ^ 2 + z.im ^ 2} with hA1
  set B1 : Set ℂ := {z | (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100 ∧ z.re ^ 2 + z.im ^ 2 < 1} with hB1
  set W : Set ℂ := {z | (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100} with hW
  have lt_open : ∀ f g : ℂ → ℝ, Continuous f → Continuous g → IsOpen {z : ℂ | f z < g z} :=
    fun f g hf hg => isOpen_lt hf hg
  have cre : Continuous fun z : ℂ => z.re := Complex.continuous_re
  have cim : Continuous fun z : ℂ => z.im := Complex.continuous_im
  have cq : Continuous fun z : ℂ => z.re ^ 2 + z.im ^ 2 := by fun_prop
  have cd : Continuous fun z : ℂ => (z.re - 1) ^ 2 + z.im ^ 2 := by fun_prop
  have cabs : Continuous fun z : ℂ => 2 * |z.im| := by fun_prop
  have cneg : Continuous fun z : ℂ => -z.re := by fun_prop
  have cc : ∀ c : ℝ, Continuous fun _ : ℂ => c := fun c => continuous_const
  have oA0 : IsOpen A0 := (lt_open _ _ cre (cc 0)).inter ((lt_open _ _ cabs cneg).inter (lt_open _ _ cq (cc _)))
  have oB0 : IsOpen B0 := (lt_open _ _ (cc 0) cre).inter ((lt_open _ _ cabs cre).inter (lt_open _ _ cq (cc _)))
  have oA1 : IsOpen A1 := (lt_open _ _ cd (cc _)).inter (lt_open _ _ (cc 1) cq)
  have oB1 : IsOpen B1 := (lt_open _ _ cd (cc _)).inter (lt_open _ _ cq (cc 1))
  have oW : IsOpen W := lt_open _ _ cd (cc _)
  -- unit-freeness
  have uA0 : ∀ x ∈ A0, ∀ y ∈ A0, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2, hy3⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uB0 : ∀ x ∈ B0, ∀ y ∈ B0, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2, hy3⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uA1 : ∀ x ∈ A1, ∀ y ∈ A1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2⟩ y ⟨hy1, hy2⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re - 2), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uB1 : ∀ x ∈ B1, ∀ y ∈ B1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2⟩ y ⟨hy1, hy2⟩
    apply hlt
    nlinarith [sq_nonneg (x.re + y.re - 2), sq_nonneg (x.im + y.im), sq_nonneg (x.re - y.re), sq_nonneg (x.im - y.im)]
  have uA01 : ∀ x ∈ A0, ∀ y ∈ A1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2⟩
    apply hgt
    have hyre : 9 / 10 < y.re := by nlinarith [sq_nonneg y.im]
    have hyim : |y.im| < 1 / 10 := by
      rw [abs_lt]; constructor <;> nlinarith [sq_nonneg (y.re - 1), sq_nonneg y.im]
    have hxim := abs_nonneg x.im
    have hcross : y.re * x.re + y.im * x.im ≤ 0 := by
      have h1 : y.im * x.im ≤ |y.im| * |x.im| := by
        calc y.im * x.im ≤ |y.im * x.im| := le_abs_self _
          _ = _ := abs_mul _ _
      have h2 : |y.im| * |x.im| ≤ (1 / 10) * (-x.re / 2) := by
        apply mul_le_mul hyim.le (by linarith) (abs_nonneg _) (by norm_num)
      nlinarith
    nlinarith [sq_nonneg x.re, sq_nonneg x.im]
  have uB01 : ∀ x ∈ B0, ∀ y ∈ B1, dist x y ≠ 1 := by
    rintro x ⟨hx1, hx2, hx3⟩ y ⟨hy1, hy2⟩
    apply hlt
    have hyre : 9 / 10 < y.re := by nlinarith [sq_nonneg y.im]
    have hyim : |y.im| < 1 / 10 := by
      rw [abs_lt]; constructor <;> nlinarith [sq_nonneg (y.re - 1), sq_nonneg y.im]
    have hcross : (17 / 20) * x.re ≤ y.re * x.re + y.im * x.im := by
      have h1 : -(|y.im| * |x.im|) ≤ y.im * x.im := by
        calc -(|y.im| * |x.im|) = -|y.im * x.im| := by rw [abs_mul]
          _ ≤ _ := neg_abs_le _
      have h2 : |y.im| * |x.im| ≤ (1 / 10) * (x.re / 2) := by
        apply mul_le_mul hyim.le (by linarith) (abs_nonneg _) (by norm_num)
      nlinarith
    have hxre : x.re < 1 / 4 := by nlinarith [sq_nonneg x.im]
    have hxsq : x.re ^ 2 + x.im ^ 2 ≤ (5 / 4) * x.re ^ 2 := by
      have : x.im ^ 2 ≤ (x.re / 2) ^ 2 := by
        have := abs_nonneg x.im
        nlinarith [sq_abs x.im]
      nlinarith
    nlinarith [sq_nonneg x.re, mul_pos hx1 hx1]
  have hAu : ∀ x ∈ A0 ∪ A1, ∀ y ∈ A0 ∪ A1, dist x y ≠ 1 := by
    rintro x (hx | hx) y (hy | hy)
    · exact uA0 x hx y hy
    · exact uA01 x hx y hy
    · rw [dist_comm]; exact uA01 y hy x hx
    · exact uA1 x hx y hy
  have hBu : ∀ x ∈ B0 ∪ B1, ∀ y ∈ B0 ∪ B1, dist x y ≠ 1 := by
    rintro x (hx | hx) y (hy | hy)
    · exact uB0 x hx y hy
    · exact uB01 x hx y hy
    · rw [dist_comm]; exact uB01 y hy x hx
    · exact uB1 x hx y hy
  -- the change point
  have h0A : (0 : ℂ) ∈ closure (A0 ∪ A1) := by
    refine Metric.mem_closure_iff.2 fun δ hδ => ?_
    set t : ℝ := min (δ / 2) (1 / 8) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 8 := min_le_right _ _
    have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    refine ⟨((-t : ℝ) : ℂ), Or.inl ⟨by simpa using ht0, by simpa using ht0, by simp; nlinarith⟩, ?_⟩
    rw [dist_zero_left, Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos ht0]; exact htδ
  have h0B : (0 : ℂ) ∈ closure (B0 ∪ B1) := by
    refine Metric.mem_closure_iff.2 fun δ hδ => ?_
    set t : ℝ := min (δ / 2) (1 / 8) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 8 := min_le_right _ _
    have htδ : t < δ := lt_of_le_of_lt (min_le_left _ _) (by linarith)
    refine ⟨((t : ℝ) : ℂ), Or.inl ⟨by simpa using ht0, by simpa using ht0, by simp; nlinarith⟩, ?_⟩
    rw [dist_zero_left, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; exact htδ
  -- W lies in the closure
  have hWcl : W ⊆ closure ((A0 ∪ A1) ∪ (B0 ∪ B1)) := by
    intro z hz
    have hzW : (z.re - 1) ^ 2 + z.im ^ 2 < 1 / 100 := hz
    by_cases hq : z.re ^ 2 + z.im ^ 2 = 1
    · refine Metric.mem_closure_iff.2 fun δ hδ => ?_
      obtain ⟨d, hd⟩ : ∃ d : ℝ, d = (z.re - 1) ^ 2 + z.im ^ 2 := ⟨_, rfl⟩
      rw [← hd] at hzW
      obtain ⟨t, ht⟩ : ∃ t : ℝ, t = min (δ / 4) ((1 / 100 - d) / 4) := ⟨_, rfl⟩
      have ht0 : 0 < t := by rw [ht]; exact lt_min (by linarith) (by linarith)
      have ht1 : t ≤ (1 / 100 - d) / 4 := by rw [ht]; exact min_le_right _ _
      have ht2 : t ≤ δ / 4 := by rw [ht]; exact min_le_left _ _
      have hd0 : 0 ≤ d := by rw [hd]; positivity
      refine ⟨((1 + t : ℝ) : ℂ) * z, Or.inl (Or.inr ⟨?_, ?_⟩), ?_⟩
      · simp only [Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero]
        have h1 : ((1 + t) * z.re - 1) ^ 2 + ((1 + t) * z.im) ^ 2 = (1 + t) * d + t ^ 2 := by
          rw [hd]; linear_combination (t * (1 + t)) * hq
        have h2 : t * (d + t) ≤ t * 1 := mul_le_mul_of_nonneg_left (by linarith) ht0.le
        rw [h1]; nlinarith
      · simp only [Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero, add_zero]
        have h1 : ((1 + t) * z.re) ^ 2 + ((1 + t) * z.im) ^ 2 = (1 + t) ^ 2 := by linear_combination (1 + t) ^ 2 * hq
        rw [h1]; nlinarith
      · rw [dist_eq_norm, show z - ((1 + t : ℝ) : ℂ) * z = -((t : ℂ) * z) by push_cast; ring, norm_neg, norm_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
        have hz1 : ‖z‖ = 1 := by
          have : ‖z‖ ^ 2 = 1 := by rw [Complex.sq_norm, Complex.normSq_apply]; linarith
          nlinarith [norm_nonneg z]
        rw [hz1]; linarith
    · apply subset_closure
      rcases lt_or_gt_of_ne hq with h | h
      · exact Or.inr (Or.inr ⟨hzW, h⟩)
      · exact Or.inl (Or.inr ⟨hzW, h⟩)
  have := h (A0 ∪ A1) (B0 ∪ B1) W 0 (oA0.union oA1) (oB0.union oB1) oW hWcl hAu hBu h0A h0B
  refine Set.disjoint_left.1 this (show (1 : ℂ) ∈ sphere (0 : ℂ) 1 by simp) ?_
  show ((1 : ℂ).re - 1) ^ 2 + (1 : ℂ).im ^ 2 < 1 / 100
  simp

/-! ## The regions of an almost-everywhere-proper map, and the multicolour -/

/-- **The multicolour** of `x` for the colour classes `S` (D-VMC; S–V's Definition 2, "the set of colors assigned to the regions
whose closure contains `u`"): the colours whose class has `x` in its closure. Its `ncard` is the chromaticity of `x`. -/
def multicolour {k : ℕ} (S : Fin k → Set ℂ) (x : ℂ) : Set (Fin k) := {j | x ∈ closure (S j)}

/-- **The regions of an almost-everywhere-proper map-type colouring** (D-AEMAP, region-only): `k` open colour classes (each the union
of the open regions of one colour), no two points of one class at distance exactly `1`, whose union is dense (every point lies in the
closure of a region), with finitely many connected components of the classes meeting a neighbourhood of each point (S–V's
Condition 3, read on regions). Boundaries and vertices are never read. -/
structure AeProperRegions (k : ℕ) where
  /-- The colour classes: the union of the open regions of each colour. -/
  cls : Fin k → Set ℂ
  /-- Each class is open. -/
  isOpen_cls : ∀ j, IsOpen (cls j)
  /-- Almost-everywhere-properness: no two points of one class at distance exactly `1`. -/
  dist_ne_one : ∀ j, ∀ x ∈ cls j, ∀ y ∈ cls j, dist x y ≠ 1
  /-- Every point lies in the closure of a region. -/
  dense : Dense (⋃ j, cls j)
  /-- Finitely many regions (components of the classes) meet a neighbourhood of each point. -/
  locallyFinite : ∀ x, ∃ t ∈ 𝓝 x,
    {C : Set ℂ | ∃ j, ∃ y ∈ cls j, C = connectedComponentIn (cls j) y ∧ (C ∩ t).Nonempty}.Finite

/-- The multicolour reads the closures of the classes: with classes `B(0, 1)` and `B(2, 1)`, both colours are at `1`. -/
example : multicolour (![ball (0 : ℂ) 1, ball 2 1] : Fin 2 → Set ℂ) 1 = univ := by
  ext j
  simp only [multicolour, mem_setOf_eq, mem_univ, iff_true]
  fin_cases j
  · show (1 : ℂ) ∈ closure (ball 0 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp
  · show (1 : ℂ) ∈ closure (ball 2 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_comm, dist_eq_norm]; norm_num

/-- **Adversary**: a point outside every closure has empty multicolour. -/
example : multicolour (![ball (0 : ℂ) 1, ball 2 1] : Fin 2 → Set ℂ) (5 * I) = ∅ := by
  ext j
  simp only [multicolour, mem_setOf_eq, mem_empty_iff_false, iff_false]
  fin_cases j
  · show (5 * I : ℂ) ∉ closure (ball 0 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp
  · show (5 * I : ℂ) ∉ closure (ball 2 1)
    rw [closure_ball _ one_ne_zero, mem_closedBall, dist_eq_norm]
    have : ‖(5 * I - 2 : ℂ)‖ ^ 2 = 29 := by
      rw [← Complex.normSq_eq_norm_sq]; simp [Complex.normSq_apply]; norm_num
    nlinarith [norm_nonneg (5 * I - 2 : ℂ)]

/-! ## Lebesgue's covering theorem for the square (an outside theorem) -/

/-- The closed axis-parallel square `[c.re, c.re + s] × [c.im, c.im + s]`. -/
def closedSquare (c : ℂ) (s : ℝ) : Set ℂ := {z | c.re ≤ z.re ∧ z.re ≤ c.re + s ∧ c.im ≤ z.im ∧ z.im ≤ c.im + s}

/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely many closed sets none of
which meets two opposite sides, some point of the square lies in three of them. `[HurewiczWallman1948]` Thm IV 2, p. 42 (the
`n`-cube, `n + 1` sets); SB's step 6 (`plans/FS106-SB-verification.md` § 2.5). Proved in the kernel by FS131-LEB
(`HadwigerNelson.LebesgueCovering.lebesgue_covering_square`, `Topology/LebesgueCovering`, through Sperner's lemma on the grid). -/
theorem lebesgue_covering_square {m : ℕ} (c : ℂ) {s : ℝ} (hs : 0 < s) (F : Fin m → Set ℂ) (hF : ∀ i, IsClosed (F i))
    (hcov : closedSquare c s ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.re = c.re) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.re = c.re + s))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.im = c.im) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.im = c.im + s)) :
    ∃ z ∈ closedSquare c s, ∃ i j l : Fin m, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l :=
  LebesgueCovering.lebesgue_covering_square c hs F hF hcov hLR hBT

/-! ## FS106-TS-T, region-only -/

namespace AeProperRegions

variable {k : ℕ} (R : AeProperRegions k)

/-- **FS106-TS-T** (SB's form, `plans/FS106-SB-verification.md` § 2.5): every point `z` of an almost-everywhere-proper map has a point
of chromaticity at least `3` within `1/√2 + ε`, for every `ε > 0`. -/
theorem exists_three_le_multicolour (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ 3 ≤ (multicolour R.cls x).ncard := by
  sorry

/-- **FS106-TS-T** in TS's form (`plans/FS106-TS-derivation.md` § 2.4): a point of chromaticity at least `3` within distance `1`
(strictly). -/
theorem exists_three_le_multicolour_lt_one (z : ℂ) : ∃ x, dist x z < 1 ∧ 3 ≤ (multicolour R.cls x).ncard := by
  obtain ⟨x, hx, h3⟩ := R.exists_three_le_multicolour z (ε := 1 / 5) (by norm_num)
  refine ⟨x, lt_of_lt_of_le hx ?_, h3⟩
  have h54 : 5 / 4 ≤ Real.sqrt 2 := by
    nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num), Real.sqrt_nonneg 2]
  have hs : (0 : ℝ) < Real.sqrt 2 := by linarith
  have : 1 / Real.sqrt 2 ≤ 4 / 5 := by rw [div_le_iff₀ hs]; linarith
  linarith

end AeProperRegions

/-! ## FS106-TS-T for arc maps, with Conditions 5 and 6 -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- The colours at a point are the multicolour of the colour classes (by definition). -/
theorem coloursAt_eq_multicolour (x : ℂ) : F.coloursAt x = multicolour F.region x := rfl

variable {F}

/-- In a map of the plane, finitely many tiles meet a neighbourhood of each point, and the components of a colour class are its
tiles — so the regions are locally finite (wave 3's `finite_tiles_near`). -/
theorem region_locallyFinite (hP : F.IsPlaneMap) (x : ℂ) : ∃ t ∈ 𝓝 x,
    {C : Set ℂ | ∃ j, ∃ y ∈ F.region j, C = connectedComponentIn (F.region j) y ∧ (C ∩ t).Nonempty}.Finite := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near (hP ▸ mem_univ x)
  refine ⟨ball x r, ball_mem_nhds x hr, hfin.subset ?_⟩
  rintro C ⟨j, y, hy, rfl, hne⟩
  have hT : F.IsTile (connectedComponentIn F.interiorPts y) := ⟨y, hy.1, rfl⟩
  have hEq : connectedComponentIn (F.region j) y = connectedComponentIn F.interiorPts y := by
    refine le_antisymm (connectedComponentIn_mono y (F.region_subset_interiorPts j)) ?_
    refine hT.isPreconnected.subset_connectedComponentIn (mem_connectedComponentIn hy.1) ?_
    intro z hz
    refine ⟨hT.subset_interiorPts hz, ?_⟩
    have := hT.col_eq hz (mem_connectedComponentIn hy.1)
    rw [mem_preimage, this, hy.2]
    rfl
  rw [hEq] at hne ⊢
  exact ⟨hT, hne⟩

/-- In a map of the plane the colour classes have dense union (wave 3's `dense_interiorPts`). -/
theorem dense_iUnion_region (hP : F.IsPlaneMap) : Dense (⋃ j, F.region j) := by
  have hU : (⋃ j, F.region j) = F.interiorPts := by
    ext z
    simp only [mem_iUnion]
    constructor
    · rintro ⟨j, hj⟩; exact hj.1
    · intro hz; exact ⟨F.col z, hz, rfl⟩
  rw [hU, dense_iff_closure_eq, eq_univ_iff_forall]
  intro x
  exact F.dense_interiorPts (hP ▸ mem_univ x)

/-- **A valid map of the plane gives the regions of an almost-everywhere-proper map**: its colour classes. -/
noncomputable def toAeProperRegions (hF : F.Valid) (hP : F.IsPlaneMap) : AeProperRegions k where
  cls := F.region
  isOpen_cls := F.isOpen_region
  dist_ne_one := fun j x hx y hy hxy => hF x hx.1 y hy.1 hxy (by rw [hx.2, hy.2])
  dense := dense_iUnion_region hP
  locallyFinite := region_locallyFinite hP

/-- **FS106-TS-T for a valid map of the plane**: a point of at least three colours within `1/√2 + ε` of every point. -/
theorem ts_t (hF : F.Valid) (hP : F.IsPlaneMap) (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ 3 ≤ (F.coloursAt x).ncard :=
  (F.toAeProperRegions hF hP).exists_three_le_multicolour z hε

/-- **TS-T's vertex step**: a point of the domain has a finite degree, at least its number of colours (each colour at the point
contributes a sector). So a point of chromaticity `≥ 3` is a vertex of degree `≥ 3`. -/
theorem exists_hasDegree_of_mem_dom {x : ℂ} (hx : x ∈ F.dom) : ∃ n, (F.coloursAt x).ncard ≤ n ∧ F.HasDegree x n := by
  sorry

/-- **FS106-TS-T, Condition 5's clause**, over its conclusion: where every point carries at most three colours (S–V Lemma 2 almost
everywhere under Condition 5 — SB § 2.1 A5, not a backlog row; for arc maps FS110-NB-4's conclusion, as inventory ruling 53 states
FS110-N4-STUCK), the point TS-T finds is trichromatic, of degree at least `3`. -/
theorem ts_t_trichromatic (hF : F.Valid) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) (z : ℂ) {ε : ℝ}
    (hε : 0 < ε) : ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ (F.coloursAt x).ncard = 3 ∧ ∃ n, 3 ≤ n ∧ F.HasDegree x n := by
  obtain ⟨x, hx, h3x⟩ := ts_t hF hP z hε
  have heq : (F.coloursAt x).ncard = 3 := le_antisymm (h3 x) h3x
  obtain ⟨n, hn, hdeg⟩ := exists_hasDegree_of_mem_dom (F := F) (hP ▸ mem_univ x)
  exact ⟨x, hx, heq, n, heq ▸ hn, hdeg⟩

/-- **FS106-TS-T, Condition 6's clause** (closing S–V Lemma 4 (a) under Conditions 5–6): with at most three colours everywhere and
Condition 6, the point TS-T finds is a trichromatic vertex of degree exactly `3`. -/
theorem ts_t_degree_three (hF : F.Valid) (hP : F.IsPlaneMap) (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) (h6 : F.Condition6)
    (z : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ x, dist x z < 1 / Real.sqrt 2 + ε ∧ (F.coloursAt x).ncard = 3 ∧ F.HasDegree x 3 := by
  obtain ⟨x, hx, heq, n, hn, hdeg⟩ := ts_t_trichromatic hF hP h3 z hε
  have hn3 : n ≤ 3 := h6 x n heq hdeg
  have : n = 3 := le_antisymm hn3 hn
  exact ⟨x, hx, heq, this ▸ hdeg⟩

end ArcMap

/-! ## The inhabitant: the brick seven-colouring as an arc map of the plane -/

/-- The lower-left corner `((2/5) r + (4/5) c, (3/5) r)` of the cell `(c, r)` of `sevenBrick` (`Instances/Seven`). -/
noncomputable def brickCorner (c r : ℤ) : ℂ := ((2 / 5 * r + 4 / 5 * c : ℝ) : ℂ) + ((3 / 5 * r : ℝ) : ℂ) * I

/-- The cell edges of `sevenBrick`: each cell's bottom edge and left edge. -/
noncomputable def sevenBrickArcs : Set Arc :=
  ⋃ c : ℤ, ⋃ r : ℤ, {Arc.seg (brickCorner c r) (brickCorner (c + 1) r),
    Arc.seg (brickCorner c r) (brickCorner c r + ((3 / 5 : ℝ) : ℂ) * I)}

/-- Every cell edge has positive length. -/
theorem sevenBrickArcs_nondegenerate : ∀ a ∈ sevenBrickArcs, a.Nondegenerate := by
  intro a ha
  simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
  obtain ⟨c, r, rfl | rfl⟩ := ha
  · intro h
    have := congrArg Complex.re h
    simp only [brickCorner, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im, Complex.I_re,
      Complex.I_im, mul_zero, sub_zero, zero_mul, add_zero, Int.cast_add, Int.cast_one] at this
    linarith
  · intro h
    have := congrArg Complex.im h
    simp [brickCorner] at this

/-- The real part of the cell corner. -/
theorem brickCorner_re (c r : ℤ) : (brickCorner c r).re = 2 / 5 * r + 4 / 5 * c := by
  simp [brickCorner]

/-- The imaginary part of the cell corner. -/
theorem brickCorner_im (c r : ℤ) : (brickCorner c r).im = 3 / 5 * r := by
  simp [brickCorner]

/-- The floor is locally constant at a non-integer. -/
theorem eventually_floor_eq {t : ℝ} (ht : ∀ n : ℤ, t ≠ n) : ∀ᶠ u in 𝓝 t, ⌊u⌋ = ⌊t⌋ := by
  have h1 : (⌊t⌋ : ℝ) < t := lt_of_le_of_ne (Int.floor_le t) (Ne.symm (ht _))
  have h2 : t < ⌊t⌋ + 1 := Int.lt_floor_add_one t
  filter_upwards [Ioo_mem_nhds h1 h2] with u hu
  rw [Int.floor_eq_iff]; exact ⟨hu.1.le, hu.2⟩

/-- The brick height as a real number. -/
theorem sevenBrick_h : ((sevenBrick.h : ℚ) : ℝ) = 3 / 5 := by
  simp [sevenBrick, cosetBrick]

/-- The brick width as a real number. -/
theorem sevenBrick_w : ((sevenBrick.w : ℚ) : ℝ) = 4 / 5 := by
  simp [sevenBrick, cosetBrick]

/-- The brick shear as a real number. -/
theorem sevenBrick_s : ((sevenBrick.s : ℚ) : ℝ) = 2 / 5 := by
  simp [sevenBrick, cosetBrick]

/-- Finitely many cell edges meet a neighbourhood of each point. -/
theorem sevenBrickArcs_locallyFinite : ∀ x ∈ (univ : Set ℂ), ∃ t ∈ 𝓝 x,
    {a | a ∈ sevenBrickArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x _
  refine ⟨ball x 1, ball_mem_nhds x one_pos, ?_⟩
  obtain ⟨B, hB⟩ := exists_nat_gt (|x.im| * 5 / 3 + 3)
  obtain ⟨C, hC⟩ := exists_nat_gt (|x.re| * 5 / 4 + 2 * B + 5)
  let box : Set (ℤ × ℤ) := Icc (-(C : ℤ), -(B : ℤ)) ((C : ℤ), (B : ℤ))
  have hbox : box.Finite := Set.finite_Icc _ _
  let f : ℤ × ℤ × Bool → Arc := fun q =>
    if q.2.2 then Arc.seg (brickCorner q.1 q.2.1) (brickCorner (q.1 + 1) q.2.1)
    else Arc.seg (brickCorner q.1 q.2.1) (brickCorner q.1 q.2.1 + ((3 / 5 : ℝ) : ℂ) * I)
  have hfin : (((fun q : ℤ × ℤ => (q.1, q.2, true)) '' box) ∪ ((fun q : ℤ × ℤ => (q.1, q.2, false)) '' box)).Finite :=
    (hbox.image _).union (hbox.image _)
  refine (hfin.image f).subset ?_
  rintro a ⟨ha, p, hpa, hpx⟩
  rw [mem_ball] at hpx
  have hpx' : |p.re - x.re| < 1 ∧ |p.im - x.im| < 1 := by
    have h1 := Complex.abs_re_le_norm (p - x)
    have h2 := Complex.abs_im_le_norm (p - x)
    rw [← dist_eq_norm] at h1 h2
    exact ⟨by simpa using h1.trans_lt hpx, by simpa using h2.trans_lt hpx⟩
  simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff] at ha
  obtain ⟨c, r, rfl | rfl⟩ := ha
  · -- bottom edge
    obtain ⟨s, hs, hp⟩ : ∃ s ∈ Icc (0 : ℝ) 1, p = brickCorner c r + (s : ℂ) * (brickCorner (c + 1) r - brickCorner c r) := by
      rw [Arc.carrier, segment_eq_image'] at hpa
      obtain ⟨s, hs, hsp⟩ := hpa
      exact ⟨s, hs, by rw [← hsp]; simp [Complex.real_smul]⟩
    have him : p.im = 3 / 5 * r := by
      rw [hp]; simp [brickCorner]
    have hre : p.re = 2 / 5 * r + 4 / 5 * c + s * (4 / 5) := by
      rw [hp, Complex.add_re, Complex.re_ofReal_mul, Complex.sub_re, brickCorner_re, brickCorner_re]
      push_cast; ring
    have hs0 := hs.1; have hs1 := hs.2
    obtain ⟨hx1, hx2⟩ := abs_lt.mp hpx'.1
    obtain ⟨hy1, hy2⟩ := abs_lt.mp hpx'.2
    have hxa := neg_abs_le x.re; have hxb := le_abs_self x.re
    have hya := neg_abs_le x.im; have hyb := le_abs_self x.im
    have hr1 : (r : ℝ) < B := by rw [him] at hy2; linarith
    have hr2 : -(B : ℝ) < r := by rw [him] at hy1; linarith
    have hc1 : (c : ℝ) < C := by rw [hre] at hx2; linarith
    have hc2 : -(C : ℝ) < c := by rw [hre] at hx1; linarith
    have hrB : r ∈ Icc (-(B : ℤ)) B := ⟨by exact_mod_cast hr2.le, by exact_mod_cast hr1.le⟩
    have hcC : c ∈ Icc (-(C : ℤ)) C := ⟨by exact_mod_cast hc2.le, by exact_mod_cast hc1.le⟩
    refine ⟨(c, r, true), Or.inl ⟨(c, r), ⟨⟨hcC.1, hrB.1⟩, ⟨hcC.2, hrB.2⟩⟩, rfl⟩, ?_⟩
    simp [f]
  · -- left edge
    obtain ⟨s, hs, hp⟩ : ∃ s ∈ Icc (0 : ℝ) 1, p = brickCorner c r + (s : ℂ) * (((3 / 5 : ℝ) : ℂ) * I) := by
      rw [Arc.carrier, segment_eq_image'] at hpa
      obtain ⟨s, hs, hsp⟩ := hpa
      exact ⟨s, hs, by rw [← hsp]; simp [Complex.real_smul]⟩
    have him : p.im = 3 / 5 * r + s * (3 / 5) := by
      rw [hp, Complex.add_im, brickCorner_im]
      simp
    have hre : p.re = 2 / 5 * r + 4 / 5 * c := by
      rw [hp, Complex.add_re, brickCorner_re]
      simp
    have hs0 := hs.1; have hs1 := hs.2
    obtain ⟨hx1, hx2⟩ := abs_lt.mp hpx'.1
    obtain ⟨hy1, hy2⟩ := abs_lt.mp hpx'.2
    have hxa := neg_abs_le x.re; have hxb := le_abs_self x.re
    have hya := neg_abs_le x.im; have hyb := le_abs_self x.im
    have hr1 : (r : ℝ) < B := by rw [him] at hy2; linarith
    have hr2 : -(B : ℝ) < r := by rw [him] at hy1; linarith
    have hc1 : (c : ℝ) < C := by rw [hre] at hx2; linarith
    have hc2 : -(C : ℝ) < c := by rw [hre] at hx1; linarith
    have hrB : r ∈ Icc (-(B : ℤ)) B := ⟨by exact_mod_cast hr2.le, by exact_mod_cast hr1.le⟩
    have hcC : c ∈ Icc (-(C : ℤ)) C := ⟨by exact_mod_cast hc2.le, by exact_mod_cast hc1.le⟩
    refine ⟨(c, r, false), Or.inr ⟨(c, r), ⟨⟨hcC.1, hrB.1⟩, ⟨hcC.2, hrB.2⟩⟩, rfl⟩, ?_⟩
    simp [f]

/-- The brick colour is locally constant off the cell edges. -/
theorem sevenBrick_color_locallyConstant : ∀ x ∈ (univ : Set ℂ), x ∉ ⋃ a ∈ sevenBrickArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, sevenBrick.color y = sevenBrick.color x := by
  intro x _ hx
  have hrow : ∀ n : ℤ, x.im / (3 / 5 : ℝ) ≠ n := by
    intro n hn
    have him : x.im = 3 / 5 * n := by field_simp at hn; linarith
    set c : ℤ := ⌊(x.re - 2 / 5 * n) / (4 / 5)⌋ with hc
    have h0 : (c : ℝ) ≤ (x.re - 2 / 5 * n) / (4 / 5) := Int.floor_le _
    have h1 : (x.re - 2 / 5 * n) / (4 / 5) < c + 1 := Int.lt_floor_add_one _
    refine hx (mem_iUnion₂.mpr ⟨Arc.seg (brickCorner c n) (brickCorner (c + 1) n), ?_, ?_⟩)
    · simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]
      exact ⟨c, n, Or.inl rfl⟩
    · rw [Arc.carrier, segment_eq_image']
      refine ⟨(x.re - 2 / 5 * n - 4 / 5 * c) / (4 / 5), ⟨?_, ?_⟩, ?_⟩
      · rw [le_div_iff₀ (by norm_num)]; rw [div_lt_iff₀ (by norm_num)] at h1; rw [le_div_iff₀ (by norm_num)] at h0; linarith
      · rw [div_le_one (by norm_num)]; rw [div_lt_iff₀ (by norm_num)] at h1; linarith
      · apply Complex.ext
        · simp only [Complex.add_re, Complex.smul_re, Complex.sub_re, smul_eq_mul, brickCorner_re]
          push_cast; field_simp; ring
        · simp only [Complex.add_im, Complex.smul_im, Complex.sub_im, smul_eq_mul, brickCorner_im]
          rw [him]; ring
  have hrowE : ∀ᶠ y in 𝓝 x, sevenBrick.row y = sevenBrick.row x := by
    have hcont : Tendsto (fun y : ℂ => y.im / (3 / 5 : ℝ)) (𝓝 x) (𝓝 (x.im / (3 / 5 : ℝ))) :=
      ((Complex.continuous_im.div_const _).tendsto x)
    filter_upwards [hcont.eventually (eventually_floor_eq hrow)] with y hy
    unfold Brick.row; rw [sevenBrick_h]; exact hy
  set r := sevenBrick.row x with hr
  have hrr : (r : ℝ) < x.im / (3 / 5) ∧ x.im / (3 / 5) < r + 1 := by
    have h1 : (r : ℝ) ≤ x.im / (3 / 5) := by rw [hr]; unfold Brick.row; rw [sevenBrick_h]; exact Int.floor_le _
    have h2 : x.im / (3 / 5) < r + 1 := by rw [hr]; unfold Brick.row; rw [sevenBrick_h]; exact Int.lt_floor_add_one _
    exact ⟨lt_of_le_of_ne h1 (fun h => hrow r h.symm), h2⟩
  have hcol : ∀ n : ℤ, (x.re - 2 / 5 * r) / (4 / 5) ≠ n := by
    intro n hn
    have hre : x.re = 2 / 5 * r + 4 / 5 * n := by field_simp at hn; linarith
    obtain ⟨hr1, hr2⟩ := hrr
    rw [lt_div_iff₀ (by norm_num)] at hr1; rw [div_lt_iff₀ (by norm_num)] at hr2
    refine hx (mem_iUnion₂.mpr ⟨Arc.seg (brickCorner n r) (brickCorner n r + ((3 / 5 : ℝ) : ℂ) * I), ?_, ?_⟩)
    · simp only [sevenBrickArcs, mem_iUnion, mem_insert_iff, mem_singleton_iff]
      exact ⟨n, r, Or.inr rfl⟩
    · rw [Arc.carrier, segment_eq_image']
      refine ⟨(x.im - 3 / 5 * r) / (3 / 5), ⟨?_, ?_⟩, ?_⟩
      · exact div_nonneg (by linarith) (by norm_num)
      · rw [div_le_one (by norm_num)]; linarith
      · apply Complex.ext
        · simp only [Complex.add_re, Complex.sub_re, Complex.smul_re, smul_eq_mul, brickCorner_re, Complex.mul_re, Complex.ofReal_re,
            Complex.ofReal_im, Complex.I_re, Complex.I_im]
          rw [hre]; ring
        · simp only [Complex.add_im, Complex.sub_im, Complex.smul_im, smul_eq_mul, brickCorner_im, Complex.mul_im, Complex.ofReal_re,
            Complex.ofReal_im, Complex.I_re, Complex.I_im]
          field_simp; ring
  have hcolE : ∀ᶠ y in 𝓝 x, ⌊(y.re - 2 / 5 * (r : ℝ)) / (4 / 5)⌋ = ⌊(x.re - 2 / 5 * (r : ℝ)) / (4 / 5)⌋ := by
    have hcont : Tendsto (fun y : ℂ => (y.re - 2 / 5 * (r : ℝ)) / (4 / 5)) (𝓝 x) (𝓝 ((x.re - 2 / 5 * (r : ℝ)) / (4 / 5))) :=
      (((Complex.continuous_re.sub continuous_const).div_const _).tendsto x)
    exact hcont.eventually (eventually_floor_eq hcol)
  filter_upwards [hrowE, hcolE] with y hy1 hy2
  have hcy : sevenBrick.col y = sevenBrick.col x := by
    unfold Brick.col
    rw [hy1, sevenBrick_s, sevenBrick_w]
    exact hy2
  unfold Brick.color
  rw [hcy, hy1]

/-- **The brick seven-colouring as an arc map of the plane** — the inhabitant of "a valid map of the plane". -/
noncomputable def sevenBrickMap : ArcMap 7 where
  dom := univ
  isOpen_dom := isOpen_univ
  arcs := sevenBrickArcs
  nondegenerate := sevenBrickArcs_nondegenerate
  locallyFinite := sevenBrickArcs_locallyFinite
  col := sevenBrick.color
  locallyConstant := sevenBrick_color_locallyConstant

/-- `sevenBrickMap` is a map of the plane. -/
theorem sevenBrickMap_isPlaneMap : sevenBrickMap.IsPlaneMap := rfl

/-- `sevenBrickMap` is valid: the brick colouring is proper at every unit pair (`Brick.avoids`, M36). -/
theorem sevenBrickMap_valid : sevenBrickMap.Valid := fun x _ y _ hxy =>
  sevenBrick.avoids (List.mem_singleton.mpr rfl) sevenBrick_check (by rw [hxy]; simp)

/-- The regions of an almost-everywhere-proper map exist: `sevenBrickMap`'s (the inhabitant of `AeProperRegions`). -/
noncomputable def sevenBrickRegions : AeProperRegions 7 :=
  sevenBrickMap.toAeProperRegions sevenBrickMap_valid sevenBrickMap_isPlaneMap

end HadwigerNelson.Plane
