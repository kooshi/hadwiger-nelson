import Proofs.HadwigerNelson.Plane.Woodall.Basic
import Proofs.HadwigerNelson.Plane.SVMap

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The plane-map model (FS131-QA2's QA2-1): the brick map in Woodall's normal form on the whole plane -/

namespace ArcMap

variable {k : ℕ}

/-- **The cone clause of a picture from sectors** (region-only): if each open sector `annSector v 0 ρ (d i) (d (i+1))` lies in the class
of colour `c i`, and every interior point near `v` lies in one of them, the cone of each colour class at `v` is the union of its closed
angular intervals. -/
theorem coneAt_region_of_sectors (F : ArcMap k) {v : ℂ} {ρ : ℝ} (hρ : 0 < ρ) {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (hd : ∀ i : Fin n, d i.castSucc < d i.succ) (hsub : ∀ i : Fin n, annSector v 0 ρ (d i.castSucc) (d i.succ) ⊆ F.region (c i))
    (hcov : ∀ z ∈ F.interiorPts, z ∈ ball v ρ → ∃ i : Fin n, z ∈ annSector v 0 ρ (d i.castSucc) (d i.succ)) (j : Fin k) :
    coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ) := by
  apply Subset.antisymm
  · intro β hβ
    have hsub' : F.region j ∩ ball v ρ ⊆ ⋃ i ∈ {i : Fin n | c i = j}, annSector v 0 ρ (d i.castSucc) (d i.succ) := by
      rintro z ⟨hz, hzb⟩
      obtain ⟨i, hi⟩ := hcov z hz.1 hzb
      have hci : F.col z = c i := (hsub i hi).2
      have hj : F.col z = j := hz.2
      exact mem_iUnion₂.mpr ⟨i, show c i = j from hci ▸ hj, hi⟩
    obtain ⟨i, hi, hβi⟩ := coneAt_biUnion_finite (Set.toFinite _) _ (coneAt_mono hsub' v (coneAt_inter_ball hρ hβ))
    rw [coneAt_annSector_eq v hρ (hd i)] at hβi
    exact mem_iUnion₂.mpr ⟨i, hi, hβi⟩
  · intro β hβ
    obtain ⟨i, hi, hβi⟩ := mem_iUnion₂.mp hβ
    have hi : c i = j := hi
    rw [← coneAt_annSector_eq v hρ (hd i)] at hβi
    exact coneAt_mono (hi ▸ hsub i) v hβi

/-- A picture with distinct colours and positive angles is `NiceAt` (no colour repeats, no horn). -/
theorem niceAt_of_injective {F : ArcMap k} {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hc : Function.Injective c) (hd : ∀ i : Fin n, d i.castSucc < d i.succ) : F.NiceAt v :=
  ⟨n, d, c, h, fun _ _ hij hcij => absurd (hc hcij) hij, fun i hi => absurd hi (hd i).ne⟩

end ArcMap

/-- The colour of the brick cell `(c, r)` (column `c` of row `r`) of `sevenBrick`. -/
def brickCellCol (c r : ℤ) : Fin 7 := sevenBrick.table (zmodIdx 7 (by norm_num) c) (zmodIdx 7 (by norm_num) r)

/-- Two cells whose indices `c + 3r` differ by a non-multiple of `7` carry different colours (`table i j = i + 3j mod 7`). -/
theorem brickCellCol_ne {c r c' r' : ℤ} (h : ¬ (7 : ℤ) ∣ (c + 3 * r) - (c' + 3 * r')) : brickCellCol c r ≠ brickCellCol c' r' := by
  intro heq
  have := congrArg Fin.val heq
  simp only [brickCellCol, sevenBrick, cosetBrick, zmodIdx] at this
  omega

/-- The polar point `v + s e(θ)` in coordinates. -/
theorem polar_re_im (v : ℂ) (s θ : ℝ) :
    (v + (s : ℂ) * e θ).re = v.re + s * Real.cos θ ∧ (v + (s : ℂ) * e θ).im = v.im + s * Real.sin θ := by
  rw [e_eq]
  constructor <;> simp [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, -Complex.ofReal_cos, -Complex.ofReal_sin]

/-- **A point strictly inside the brick cell `(c, r)` is an interior point of colour `brickCellCol c r`.** -/
theorem sevenBrickMap_mem_region_of_cell {z : ℂ} {c r : ℤ} (h1 : 3 / 5 * (r : ℝ) < z.im) (h2 : z.im < 3 / 5 * r + 3 / 5)
    (h3 : 2 / 5 * (r : ℝ) + 4 / 5 * c < z.re) (h4 : z.re < 2 / 5 * r + 4 / 5 * c + 4 / 5) :
    z ∈ sevenBrickMap.region (brickCellCol c r) := by
  have hfl : ⌊z.im / (3 / 5)⌋ = r := by
    rw [Int.floor_eq_iff]; constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith
    · rw [div_lt_iff₀ (by norm_num)]; linarith
  have hcl : ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋ = c := by
    rw [Int.floor_eq_iff]; constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith
    · rw [div_lt_iff₀ (by norm_num)]; linarith
  refine ⟨⟨mem_univ z, not_mem_sevenBrickArcs (fun n hn => ?_) (fun n hn => ?_)⟩, ?_⟩
  · have h5 : (r : ℝ) < n := by linarith
    have h6 : (n : ℝ) < r + 1 := by linarith
    have h5' : r < n := by exact_mod_cast h5
    have h6' : n < r + 1 := by exact_mod_cast h6
    omega
  · rw [hfl] at hn
    have h5 : (c : ℝ) < n := by linarith
    have h6 : (n : ℝ) < c + 1 := by linarith
    have h5' : c < n := by exact_mod_cast h5
    have h6' : n < c + 1 := by exact_mod_cast h6
    omega
  · show sevenBrickMap.col z = brickCellCol c r
    exact sevenBrick_color_eq hfl hcl

/-- A point near `v` other than `v` in polar form about `v`, with its angle in `(0, 2π]`. -/
theorem exists_polar_Ioc {v z : ℂ} {ρ : ℝ} (hz : z ∈ ball v ρ) (hne : z ≠ v) :
    ∃ s θ : ℝ, 0 < s ∧ s < ρ ∧ θ ∈ Ioc 0 (2 * π) ∧ z = v + (s : ℂ) * e θ := by
  refine ⟨‖z - v‖, π + Complex.arg (-(z - v)), norm_pos_iff.mpr (sub_ne_zero.mpr hne), ?_, pi_add_arg_neg_mem _, ?_⟩
  · rw [mem_ball, dist_eq_norm] at hz; exact hz
  · have := eq_norm_mul_e_pi_add_arg (z - v)
    linear_combination this

/-! ### The T-junctions of the brick map

The brick map's cells are the rectangles `[2/5 r + 4/5 c, 2/5 r + 4/5 (c + 1)] × [3/5 r, 3/5 (r + 1)]`. Its points of three colours are the
**upward T-junctions** `brickCorner c r` (the lower left corner of the cell `(c, r)`: cells `(c, r)`, `(c − 1, r)` above, `(c, r − 1)` below)
and the **downward T-junctions** `brickCorner c r − 2/5` (the upper left corner of the cell `(c, r − 1)`: cell `(c − 1, r)` above, cells
`(c − 1, r − 1)`, `(c, r − 1)` below); each has angles `π/2, π/2, π` and three distinct colours. -/

/-- The directions of the upward T-junction's sectors: upper right, upper left, lower. -/
noncomputable def tUpDirs : Fin 4 → ℝ := ![0, π / 2, π, 2 * π]

/-- The colours of the upward T-junction `brickCorner c r`'s sectors. -/
def tUpCols (c r : ℤ) : Fin 3 → Fin 7 := ![brickCellCol c r, brickCellCol (c - 1) r, brickCellCol c (r - 1)]

/-- The directions of the downward T-junction's sectors: upper, lower left, lower right. -/
noncomputable def tDownDirs : Fin 4 → ℝ := ![0, π, 3 * π / 2, 2 * π]

/-- The colours of the downward T-junction `brickCorner c r − 2/5`'s sectors. -/
def tDownCols (c r : ℤ) : Fin 3 → Fin 7 := ![brickCellCol (c - 1) r, brickCellCol (c - 1) (r - 1), brickCellCol c (r - 1)]

theorem tUpCols_injective (c r : ℤ) : Function.Injective (tUpCols c r) := by
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp [tUpCols] at hij ⊢ <;> exact absurd hij (brickCellCol_ne (by omega))

theorem tDownCols_injective (c r : ℤ) : Function.Injective (tDownCols c r) := by
  intro i j hij
  fin_cases i <;> fin_cases j <;> simp [tDownCols] at hij ⊢ <;> exact absurd hij (brickCellCol_ne (by omega))

theorem tUpDirs_lt (i : Fin 3) : tUpDirs i.castSucc < tUpDirs i.succ := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tUpDirs] <;> linarith

theorem tDownDirs_lt (i : Fin 3) : tDownDirs i.castSucc < tDownDirs i.succ := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tDownDirs] <;> linarith

theorem tUpDirs_ge (i : Fin 3) : π / 3 ≤ tUpDirs i.succ - tUpDirs i.castSucc := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tUpDirs] <;> linarith

theorem tDownDirs_ge (i : Fin 3) : π / 3 ≤ tDownDirs i.succ - tDownDirs i.castSucc := by
  have hπ := Real.pi_pos
  fin_cases i <;> simp [tDownDirs] <;> linarith

/-- The brick corner `brickCorner c r` lies on a cell edge. -/
theorem brickCorner_mem_arcs (c r : ℤ) : brickCorner c r ∈ ⋃ a ∈ sevenBrickArcs, a.carrier :=
  mem_sevenBrickArcs_of_bottom (by rw [brickCorner_im]) (by rw [brickCorner_re]) (by rw [brickCorner_re]; linarith)

/-- **The upward T-junction's sectors lie in their cells.** -/
theorem tUp_sub (c r : ℤ) (i : Fin 3) :
    annSector (brickCorner c r) 0 (1 / 5) (tUpDirs i.castSucc) (tUpDirs i.succ) ⊆ sevenBrickMap.region (tUpCols c r i) := by
  have hπ := Real.pi_pos
  rintro z ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  simp only at hs hθ ⊢
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r) s θ
  rw [brickCorner_re] at hre
  rw [brickCorner_im] at him
  have hc1 := Real.abs_cos_le_one θ
  have hs1 := Real.abs_sin_le_one θ
  have hsc : |s * Real.cos θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.cos θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hc1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  have hss : |s * Real.sin θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.sin θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hs1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  obtain ⟨hsc1, hsc2⟩ := abs_lt.mp hsc
  obtain ⟨hss1, hss2⟩ := abs_lt.mp hss
  fin_cases i <;> simp [tUpDirs] at hθ <;> simp only [tUpCols, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.cons_val_two]
  · have hcos : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by linarith, hθ.2⟩
    have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 (by linarith)
    have : 0 < s * Real.cos θ := mul_pos hs.1 hcos
    have : 0 < s * Real.sin θ := mul_pos hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by linarith) (by linarith) (by linarith) (by linarith)
  · have hcos : Real.cos θ < 0 := Real.cos_neg_of_pi_div_two_lt_of_lt hθ.1 (by linarith)
    have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi (by linarith) hθ.2
    have : s * Real.cos θ < 0 := mul_neg_of_pos_of_neg hs.1 hcos
    have : 0 < s * Real.sin θ := mul_pos hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by linarith) (by linarith) (by push_cast; linarith) (by push_cast; linarith)
  · have hsin : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    have : s * Real.sin θ < 0 := mul_neg_of_pos_of_neg hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)

/-- **The downward T-junction's sectors lie in their cells.** -/
theorem tDown_sub (c r : ℤ) (i : Fin 3) :
    annSector (brickCorner c r - 2 / 5) 0 (1 / 5) (tDownDirs i.castSucc) (tDownDirs i.succ) ⊆
      sevenBrickMap.region (tDownCols c r i) := by
  have hπ := Real.pi_pos
  rintro z ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  simp only at hs hθ ⊢
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r - 2 / 5) s θ
  have hvre : (brickCorner c r - 2 / 5).re = 2 / 5 * r + 4 / 5 * c - 2 / 5 := by
    rw [Complex.sub_re, brickCorner_re]; norm_num
  have hvim : (brickCorner c r - 2 / 5).im = 3 / 5 * r := by
    rw [Complex.sub_im, brickCorner_im]; norm_num
  rw [hvre] at hre
  rw [hvim] at him
  have hc1 := Real.abs_cos_le_one θ
  have hs1 := Real.abs_sin_le_one θ
  have hsc : |s * Real.cos θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.cos θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hc1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  have hss : |s * Real.sin θ| < 1 / 5 := by
    rw [abs_mul, abs_of_pos hs.1]
    calc s * |Real.sin θ| ≤ s * 1 := mul_le_mul_of_nonneg_left hs1 hs.1.le
      _ < 1 / 5 := by linarith [hs.2]
  obtain ⟨hsc1, hsc2⟩ := abs_lt.mp hsc
  obtain ⟨hss1, hss2⟩ := abs_lt.mp hss
  fin_cases i <;> simp [tDownDirs] at hθ <;> simp only [tDownCols, Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.cons_val_two]
  · have hsin : 0 < Real.sin θ := Real.sin_pos_of_pos_of_lt_pi hθ.1 hθ.2
    have : 0 < s * Real.sin θ := mul_pos hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by linarith) (by linarith) (by push_cast; linarith) (by push_cast; linarith)
  · have hcos : Real.cos θ < 0 := Real.cos_neg_of_pi_div_two_lt_of_lt (by linarith) (by linarith)
    have hsin : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    have : s * Real.cos θ < 0 := mul_neg_of_pos_of_neg hs.1 hcos
    have : s * Real.sin θ < 0 := mul_neg_of_pos_of_neg hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)
  · have hcos : 0 < Real.cos θ := by
      rw [← Real.cos_sub_two_pi]; exact Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
    have hsin : Real.sin θ < 0 := by
      rw [← Real.sin_sub_two_pi]; exact Real.sin_neg_of_neg_of_neg_pi_lt (by linarith) (by linarith)
    have : 0 < s * Real.cos θ := mul_pos hs.1 hcos
    have : s * Real.sin θ < 0 := mul_neg_of_pos_of_neg hs.1 hsin
    exact sevenBrickMap_mem_region_of_cell (by push_cast; linarith) (by push_cast; linarith) (by push_cast; linarith)
      (by push_cast; linarith)

/-- **Every interior point near an upward T-junction lies in one of its three sectors** (the angles `π/2`, `π`, `2π` are cell edges). -/
theorem tUp_cov (c r : ℤ) : ∀ z ∈ sevenBrickMap.interiorPts, z ∈ ball (brickCorner c r) (1 / 5) →
    ∃ i : Fin 3, z ∈ annSector (brickCorner c r) 0 (1 / 5) (tUpDirs i.castSucc) (tUpDirs i.succ) := by
  have hπ := Real.pi_pos
  intro z hz hzb
  have hne : z ≠ brickCorner c r := fun h => hz.2 (h ▸ brickCorner_mem_arcs c r)
  obtain ⟨s, θ, hs0, hsρ, hθ, rfl⟩ := exists_polar_Ioc hzb hne
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r) s θ
  rw [brickCorner_re] at hre
  rw [brickCorner_im] at him
  have hmem : ∀ a b : ℝ, θ ∈ Ioo a b → brickCorner c r + (s : ℂ) * e θ ∈ annSector (brickCorner c r) 0 (1 / 5) a b :=
    fun a b hab => ⟨(s, θ), ⟨⟨hs0, hsρ⟩, hab⟩, rfl⟩
  have harc : brickCorner c r + (s : ℂ) * e θ ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := hz.2
  rcases lt_trichotomy θ (π / 2) with h1 | h1 | h1
  · exact ⟨0, hmem _ _ (by simp [tUpDirs]; exact ⟨hθ.1, h1⟩)⟩
  · exfalso; apply harc
    subst h1
    simp only [Real.cos_pi_div_two, Real.sin_pi_div_two, mul_zero, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_left (c := c) (r := r) (by linarith) (by rw [him]; linarith)
      (by rw [him]; linarith)
  rcases lt_trichotomy θ π with h2 | h2 | h2
  · exact ⟨1, hmem _ _ (by simp [tUpDirs]; exact ⟨h1, h2⟩)⟩
  · exfalso; apply harc
    subst h2
    simp only [Real.cos_pi, Real.sin_pi, mul_zero, mul_neg, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) (by linarith) (by rw [hre]; push_cast; linarith)
      (by rw [hre]; push_cast; linarith)
  rcases lt_or_eq_of_le hθ.2 with h3 | h3
  · exact ⟨2, hmem _ _ (by simp [tUpDirs]; exact ⟨h2, h3⟩)⟩
  · exfalso; apply harc
    subst h3
    simp only [Real.cos_two_pi, Real.sin_two_pi, mul_zero, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c) (r := r) (by linarith) (by rw [hre]; linarith)
      (by rw [hre]; linarith)

/-- **Every interior point near a downward T-junction lies in one of its three sectors** (the angles `π`, `3π/2`, `2π` are cell edges). -/
theorem tDown_cov (c r : ℤ) : ∀ z ∈ sevenBrickMap.interiorPts, z ∈ ball (brickCorner c r - 2 / 5) (1 / 5) →
    ∃ i : Fin 3, z ∈ annSector (brickCorner c r - 2 / 5) 0 (1 / 5) (tDownDirs i.castSucc) (tDownDirs i.succ) := by
  have hπ := Real.pi_pos
  intro z hz hzb
  have hvre : (brickCorner c r - 2 / 5).re = 2 / 5 * r + 4 / 5 * c - 2 / 5 := by
    rw [Complex.sub_re, brickCorner_re]; norm_num
  have hvim : (brickCorner c r - 2 / 5).im = 3 / 5 * r := by
    rw [Complex.sub_im, brickCorner_im]; norm_num
  have hv : brickCorner c r - 2 / 5 ∈ ⋃ a ∈ sevenBrickArcs, a.carrier :=
    mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) hvim (by rw [hvre]; push_cast; linarith) (by rw [hvre]; push_cast; linarith)
  have hne : z ≠ brickCorner c r - 2 / 5 := fun h => hz.2 (h ▸ hv)
  obtain ⟨s, θ, hs0, hsρ, hθ, rfl⟩ := exists_polar_Ioc hzb hne
  obtain ⟨hre, him⟩ := polar_re_im (brickCorner c r - 2 / 5) s θ
  rw [hvre] at hre
  rw [hvim] at him
  have hmem : ∀ a b : ℝ, θ ∈ Ioo a b →
      brickCorner c r - 2 / 5 + (s : ℂ) * e θ ∈ annSector (brickCorner c r - 2 / 5) 0 (1 / 5) a b :=
    fun a b hab => ⟨(s, θ), ⟨⟨hs0, hsρ⟩, hab⟩, rfl⟩
  have harc : brickCorner c r - 2 / 5 + (s : ℂ) * e θ ∉ ⋃ a ∈ sevenBrickArcs, a.carrier := hz.2
  rcases lt_trichotomy θ π with h1 | h1 | h1
  · exact ⟨0, hmem _ _ (by simp [tDownDirs]; exact ⟨hθ.1, h1⟩)⟩
  · exfalso; apply harc
    subst h1
    simp only [Real.cos_pi, Real.sin_pi, mul_zero, mul_neg, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) (by linarith) (by rw [hre]; push_cast; linarith)
      (by rw [hre]; push_cast; linarith)
  have hc32 : Real.cos (3 * π / 2) = 0 := by
    rw [show 3 * π / 2 = π / 2 + π by ring, Real.cos_add_pi, Real.cos_pi_div_two, neg_zero]
  have hs32 : Real.sin (3 * π / 2) = -1 := by
    rw [show 3 * π / 2 = π / 2 + π by ring, Real.sin_add_pi, Real.sin_pi_div_two]
  rcases lt_trichotomy θ (3 * π / 2) with h2 | h2 | h2
  · exact ⟨1, hmem _ _ (by simp [tDownDirs]; exact ⟨h1, h2⟩)⟩
  · exfalso; apply harc
    subst h2
    simp only [hc32, hs32, mul_zero, mul_neg, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_left (c := c) (r := r - 1) (by rw [hre]; push_cast; ring) (by rw [him]; push_cast; linarith)
      (by rw [him]; push_cast; linarith)
  rcases lt_or_eq_of_le hθ.2 with h3 | h3
  · exact ⟨2, hmem _ _ (by simp [tDownDirs]; exact ⟨h2, h3⟩)⟩
  · exfalso; apply harc
    subst h3
    simp only [Real.cos_two_pi, Real.sin_two_pi, mul_zero, mul_one, add_zero] at hre him
    exact mem_sevenBrickArcs_of_bottom (c := c - 1) (r := r) (by linarith) (by rw [hre]; push_cast; linarith)
      (by rw [hre]; push_cast; linarith)

/-- **Woodall's picture at an upward T-junction**: three sectors (angles `π/2, π/2, π`), colours `brickCellCol c r`,
`brickCellCol (c − 1) r`, `brickCellCol c (r − 1)`. -/
theorem sevenBrickMap_sectorsAt_tUp (c r : ℤ) : sevenBrickMap.SectorsAt (brickCorner c r) 3 tUpDirs (tUpCols c r) := by
  have hπ := Real.pi_pos
  refine ⟨by norm_num, ?_, by simp [tUpDirs], fun _ i => (tUpCols_injective c r).ne (by fin_cases i <;> decide), mem_univ _,
    sevenBrickMap.coneAt_region_of_sectors (by norm_num) tUpDirs_lt (tUp_sub c r) (tUp_cov c r)⟩
  rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp [tUpDirs] <;> linarith

/-- **Woodall's picture at a downward T-junction**: three sectors (angles `π, π/2, π/2`), colours `brickCellCol (c − 1) r`,
`brickCellCol (c − 1) (r − 1)`, `brickCellCol c (r − 1)`. -/
theorem sevenBrickMap_sectorsAt_tDown (c r : ℤ) :
    sevenBrickMap.SectorsAt (brickCorner c r - 2 / 5) 3 tDownDirs (tDownCols c r) := by
  have hπ := Real.pi_pos
  refine ⟨by norm_num, ?_, by simp [tDownDirs], fun _ i => (tDownCols_injective c r).ne (by fin_cases i <;> decide), mem_univ _,
    sevenBrickMap.coneAt_region_of_sectors (by norm_num) tDownDirs_lt (tDown_sub c r) (tDown_cov c r)⟩
  rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp [tDownDirs] <;> linarith

/-! ### The points of three colours are the T-junctions -/

/-- The closed brick cell `(c, r)`: the rectangle `[2/5 r + 4/5 c, 2/5 r + 4/5 (c + 1)] × [3/5 r, 3/5 (r + 1)]`. -/
def brickClosedCell (c r : ℤ) : Set ℂ :=
  {z | 3 / 5 * (r : ℝ) ≤ z.im ∧ z.im ≤ 3 / 5 * r + 3 / 5 ∧ 2 / 5 * (r : ℝ) + 4 / 5 * c ≤ z.re ∧ z.re ≤ 2 / 5 * r + 4 / 5 * c + 4 / 5}

theorem isClosed_brickClosedCell (c r : ℤ) : IsClosed (brickClosedCell c r) := by
  have h1 : IsClosed {z : ℂ | 3 / 5 * (r : ℝ) ≤ z.im} := isClosed_le continuous_const Complex.continuous_im
  have h2 : IsClosed {z : ℂ | z.im ≤ 3 / 5 * r + 3 / 5} := isClosed_le Complex.continuous_im continuous_const
  have h3 : IsClosed {z : ℂ | 2 / 5 * (r : ℝ) + 4 / 5 * c ≤ z.re} := isClosed_le continuous_const Complex.continuous_re
  have h4 : IsClosed {z : ℂ | z.re ≤ 2 / 5 * r + 4 / 5 * c + 4 / 5} := isClosed_le Complex.continuous_re continuous_const
  exact h1.inter (h2.inter (h3.inter h4))

/-- **Every colour at a point is the colour of a closed cell through it**: near `z` the class of colour `j` lies in the finitely many
closed cells of colour `j` within a row and a column of `z`'s cell. -/
theorem sevenBrickMap_mem_coloursAt {z : ℂ} {j : Fin 7} (hj : j ∈ sevenBrickMap.coloursAt z) :
    ∃ c r : ℤ, brickCellCol c r = j ∧ z ∈ brickClosedCell c r := by
  set R := ⌊z.im / (3 / 5)⌋ with hR
  set C := ⌊(z.re - 2 / 5 * R) / (4 / 5)⌋ with hC
  have hR' := Int.floor_eq_iff.mp hR.symm
  have hC' := Int.floor_eq_iff.mp hC.symm
  rw [le_div_iff₀ (by norm_num), div_lt_iff₀ (by norm_num)] at hR' hC'
  let N : Set (ℤ × ℤ) := {X | X.1 ∈ Icc (C - 1) (C + 1) ∧ X.2 ∈ Icc (R - 1) (R + 1) ∧ brickCellCol X.1 X.2 = j}
  have hN : N.Finite := ((Set.finite_Icc (C - 1) (C + 1)).prod (Set.finite_Icc (R - 1) (R + 1))).subset
    (fun X hX => ⟨hX.1, hX.2.1⟩)
  have hsub : sevenBrickMap.region j ∩ ball z (1 / 10) ⊆ ⋃ X ∈ N, brickClosedCell X.1 X.2 := by
    rintro w ⟨hw, hwb⟩
    set Rw := ⌊w.im / (3 / 5)⌋ with hRw
    set Cw := ⌊(w.re - 2 / 5 * Rw) / (4 / 5)⌋ with hCw
    have hRw' := Int.floor_eq_iff.mp hRw.symm
    have hCw' := Int.floor_eq_iff.mp hCw.symm
    rw [le_div_iff₀ (by norm_num), div_lt_iff₀ (by norm_num)] at hRw' hCw'
    have hcol : sevenBrickMap.col w = brickCellCol Cw Rw := sevenBrick_color_eq hRw.symm hCw.symm
    have hd : ‖w - z‖ < 1 / 10 := by rw [← dist_eq_norm]; exact hwb
    have hre := (abs_lt.mp ((Complex.abs_re_le_norm (w - z)).trans_lt hd))
    have him := (abs_lt.mp ((Complex.abs_im_le_norm (w - z)).trans_lt hd))
    rw [Complex.sub_re] at hre
    rw [Complex.sub_im] at him
    have hr1 : (Rw : ℝ) < R + 2 := by linarith
    have hr2 : (R : ℝ) - 2 < Rw := by linarith
    have hr1' : Rw < R + 2 := by exact_mod_cast hr1
    have hr2' : R - 2 < Rw := by exact_mod_cast hr2
    have hrw1 : (Rw : ℝ) ≤ R + 1 := by exact_mod_cast (show Rw ≤ R + 1 by omega)
    have hrw2 : (R : ℝ) - 1 ≤ Rw := by exact_mod_cast (show R - 1 ≤ Rw by omega)
    have hc1 : (Cw : ℝ) < C + 2 := by linarith
    have hc2 : (C : ℝ) - 2 < Cw := by linarith
    have hc1' : Cw < C + 2 := by exact_mod_cast hc1
    have hc2' : C - 2 < Cw := by exact_mod_cast hc2
    refine mem_iUnion₂.mpr ⟨(Cw, Rw), ⟨⟨by omega, by omega⟩, ⟨by omega, by omega⟩, ?_⟩, ?_⟩
    · rw [← hcol]; exact hw.2
    · exact ⟨by linarith, by linarith, by linarith, by linarith⟩
  have hz : z ∈ closure (sevenBrickMap.region j ∩ ball z (1 / 10)) := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨b, hb, hzb⟩ := Metric.mem_closure_iff.mp hj (min ε (1 / 10)) (lt_min hε (by norm_num))
    exact ⟨b, ⟨hb, by rw [mem_ball, dist_comm]; exact hzb.trans_le (min_le_right _ _)⟩, hzb.trans_le (min_le_left _ _)⟩
  have hz' := closure_mono hsub hz
  rw [hN.closure_biUnion] at hz'
  obtain ⟨X, hX, hzX⟩ := mem_iUnion₂.mp hz'
  rw [(isClosed_brickClosedCell _ _).closure_eq] at hzX
  exact ⟨X.1, X.2, hX.2.2, hzX⟩

/-- Two closed cells of one row through a point: the columns are adjacent and the point is on the edge between them. -/
theorem brickClosedCell_same_row {z : ℂ} {a b r : ℤ} (ha : z ∈ brickClosedCell a r) (hb : z ∈ brickClosedCell b r) (hab : a < b) :
    b = a + 1 ∧ z.re = 2 / 5 * r + 4 / 5 * b := by
  obtain ⟨-, -, ha3, ha4⟩ := ha
  obtain ⟨-, -, hb3, hb4⟩ := hb
  have h : (b : ℝ) ≤ a + 1 := by linarith
  have h' : b ≤ a + 1 := by exact_mod_cast h
  have hb1 : b = a + 1 := by omega
  refine ⟨hb1, ?_⟩
  have : (b : ℝ) = a + 1 := by exact_mod_cast hb1
  linarith

/-- Two closed cells of different rows through a point: the rows are adjacent and the point is on the line between them. -/
theorem brickClosedCell_rows {z : ℂ} {a b r r' : ℤ} (ha : z ∈ brickClosedCell a r) (hb : z ∈ brickClosedCell b r') (hrr : r < r') :
    r' = r + 1 ∧ z.im = 3 / 5 * r' := by
  obtain ⟨ha1, ha2, -, -⟩ := ha
  obtain ⟨hb1, hb2, -, -⟩ := hb
  have h : (r' : ℝ) ≤ r + 1 := by linarith
  have h' : r' ≤ r + 1 := by exact_mod_cast h
  have hr1 : r' = r + 1 := by omega
  refine ⟨hr1, ?_⟩
  have : (r' : ℝ) = r + 1 := by exact_mod_cast hr1
  linarith

/-- Two closed cells of one row through `z` and a third of another row: `z` is a T-junction. -/
theorem tJunction_of_pair {z : ℂ} {a b r c' r' : ℤ} (ha : z ∈ brickClosedCell a r) (hb : z ∈ brickClosedCell b r) (hab : a < b)
    (hc : z ∈ brickClosedCell c' r') (hr : r' ≠ r) : ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
  obtain ⟨-, hre⟩ := brickClosedCell_same_row ha hb hab
  rcases lt_or_gt_of_ne hr with h | h
  · -- the third cell below: `z` is the upward T-junction `brickCorner b r`
    obtain ⟨-, him⟩ := brickClosedCell_rows hc ha h
    refine ⟨b, r, Or.inl (Complex.ext ?_ ?_)⟩
    · rw [hre, brickCorner_re]
    · rw [him, brickCorner_im]
  · -- the third cell above: `z` is the downward T-junction `brickCorner b (r + 1) − 2/5`
    obtain ⟨hr1, him⟩ := brickClosedCell_rows ha hc h
    refine ⟨b, r', Or.inr (Complex.ext ?_ ?_)⟩
    · rw [Complex.sub_re, hre, brickCorner_re, hr1]; push_cast; norm_num; ring
    · rw [Complex.sub_im, him, brickCorner_im]; norm_num

/-- Three distinct closed cells through `z`: `z` is a T-junction. -/
theorem tJunction_of_three {z : ℂ} {c₁ r₁ c₂ r₂ c₃ r₃ : ℤ} (h₁ : z ∈ brickClosedCell c₁ r₁) (h₂ : z ∈ brickClosedCell c₂ r₂)
    (h₃ : z ∈ brickClosedCell c₃ r₃) (h12 : (c₁, r₁) ≠ (c₂, r₂)) (h13 : (c₁, r₁) ≠ (c₃, r₃)) (h23 : (c₂, r₂) ≠ (c₃, r₃)) :
    ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
  -- two cells of one row (rows lie within one of each other), and the third, of another row
  have hrow : ∀ {a b r r' : ℤ}, z ∈ brickClosedCell a r → z ∈ brickClosedCell b r' → r ≤ r' + 1 := by
    intro a b r r' ha hb
    have h : (r : ℝ) ≤ r' + 1 := by linarith [ha.1, hb.2.1]
    exact_mod_cast h
  have hcol : ∀ {a b r : ℤ}, z ∈ brickClosedCell a r → z ∈ brickClosedCell b r → a ≤ b + 1 := by
    intro a b r ha hb
    have h : (a : ℝ) ≤ b + 1 := by linarith [ha.2.2.1, hb.2.2.2]
    exact_mod_cast h
  have pair : ∀ {a b r c' r' : ℤ}, z ∈ brickClosedCell a r → z ∈ brickClosedCell b r → a ≠ b → z ∈ brickClosedCell c' r' →
      (r' = r → c' ≠ a ∧ c' ≠ b) → ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
    intro a b r c' r' ha hb hab hc hdist
    have hr : r' ≠ r := by
      rintro rfl
      obtain ⟨h1, h2⟩ := hdist rfl
      have := hcol ha hb; have := hcol hb ha; have := hcol hc ha; have := hcol ha hc; have := hcol hc hb; have := hcol hb hc
      omega
    rcases lt_or_gt_of_ne hab with h | h
    · exact tJunction_of_pair ha hb h hc hr
    · exact tJunction_of_pair hb ha h hc hr
  by_cases e12 : r₁ = r₂
  · subst e12
    exact pair h₁ h₂ (fun h => h12 (by rw [h])) h₃ (fun h => ⟨fun h' => h13 (by rw [h, h']), fun h' => h23 (by rw [h, h'])⟩)
  by_cases e13 : r₁ = r₃
  · subst e13
    exact pair h₁ h₃ (fun h => h13 (by rw [h])) h₂ (fun h => ⟨fun h' => h12 (by rw [h, h']), fun h' => h23 (by rw [h, h'])⟩)
  by_cases e23 : r₂ = r₃
  · subst e23
    exact pair h₂ h₃ (fun h => h23 (by rw [h])) h₁ (fun h => ⟨fun h' => h12 (by rw [h, h']), fun h' => h13 (by rw [h, h'])⟩)
  exfalso
  have := hrow h₁ h₂; have := hrow h₂ h₁; have := hrow h₁ h₃; have := hrow h₃ h₁; have := hrow h₂ h₃; have := hrow h₃ h₂
  omega

/-- **The points of three or more colours of the brick map are its T-junctions.** -/
theorem sevenBrickMap_tJunction {z : ℂ} (hz : 3 ≤ (sevenBrickMap.coloursAt z).ncard) :
    ∃ c r : ℤ, z = brickCorner c r ∨ z = brickCorner c r - 2 / 5 := by
  obtain ⟨a, ha, b, hb, d, hd, hab, had, hbd⟩ := (Set.two_lt_ncard (Set.toFinite _)).mp hz
  obtain ⟨c₁, r₁, hc₁, h₁⟩ := sevenBrickMap_mem_coloursAt ha
  obtain ⟨c₂, r₂, hc₂, h₂⟩ := sevenBrickMap_mem_coloursAt hb
  obtain ⟨c₃, r₃, hc₃, h₃⟩ := sevenBrickMap_mem_coloursAt hd
  refine tJunction_of_three h₁ h₂ h₃ ?_ ?_ ?_ <;> intro h <;> simp only [Prod.mk.injEq] at h <;> obtain ⟨rfl, rfl⟩ := h
  · exact hab (hc₁.symm.trans hc₂)
  · exact had (hc₁.symm.trans hc₃)
  · exact hbd (hc₂.symm.trans hc₃)

/-! ### The model -/

/-- **QA2-1's plane-map model: the brick map is in Woodall's normal form on the whole plane.** Every point of `sevenBrickMap` (valid, a
map of the plane, seven colours) carrying three or more colours is a T-junction (`sevenBrickMap_tJunction`), whose picture has three
distinct colours and angles `π/2, π/2, π` (`sevenBrickMap_sectorsAt_tUp`, `sevenBrickMap_sectorsAt_tDown`). -/
theorem sevenBrickMap_woodallNormal : sevenBrickMap.WoodallNormal univ := by
  intro v _ hv
  obtain ⟨c, r, rfl | rfl⟩ := sevenBrickMap_tJunction hv
  · exact ⟨3, tUpDirs, tUpCols c r, sevenBrickMap_sectorsAt_tUp c r, tUpCols_injective c r, tUpDirs_ge⟩
  · exact ⟨3, tDownDirs, tDownCols c r, sevenBrickMap_sectorsAt_tDown c r, tDownCols_injective c r, tDownDirs_ge⟩

/-- **QA2-1's plane-map model, merged form**: every point of `sevenBrickMap` of three or more colours is `NiceAt`. -/
theorem sevenBrickMap_woodallMerged : sevenBrickMap.WoodallMerged univ := by
  intro v _ hv
  obtain ⟨c, r, rfl | rfl⟩ := sevenBrickMap_tJunction hv
  · exact ArcMap.niceAt_of_injective (sevenBrickMap_sectorsAt_tUp c r) (tUpCols_injective c r) tUpDirs_lt
  · exact ArcMap.niceAt_of_injective (sevenBrickMap_sectorsAt_tDown c r) (tDownCols_injective c r) tDownDirs_lt

/-- **The model of Woodall's chain's hypotheses on a plane map** (FS131-QA2's QA2-1; `LEAN.md` § The gate's inhabitant rule): at `k = 7`,
a parameter `aeMap6`'s refutation (`k ≤ 5`) leaves alive, `sevenBrickMap` is valid, a map of the plane, in Woodall's normal form and merged
on the whole plane (so on `closedBall 0 3`, the set `aeMap6_normal` and `aeMap6_merged` read), and the normal form is exercised: the
corner `0` carries three colours. -/
theorem sevenBrickMap_woodallModel :
    sevenBrickMap.Valid ∧ sevenBrickMap.IsPlaneMap ∧ sevenBrickMap.WoodallNormal univ ∧ sevenBrickMap.WoodallMerged univ ∧
      (sevenBrickMap.coloursAt 0).ncard = 3 := by
  refine ⟨sevenBrickMap_valid, sevenBrickMap_isPlaneMap, sevenBrickMap_woodallNormal, sevenBrickMap_woodallMerged, ?_⟩
  rw [sevenBrick_corner_coloursAt, ncard_insert_of_notMem (by decide), ncard_insert_of_notMem (by decide), ncard_singleton]

end HadwigerNelson.Plane
