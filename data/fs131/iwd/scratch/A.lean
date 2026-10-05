import Proofs.HadwigerNelson.Plane.Woodall.Merge

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `OffDirs` is `2π`-periodic. -/
theorem offDirs_add_int {D : Finset ℝ} {φ : ℝ} (m : ℤ) : OffDirs D (φ + 2 * π * m) ↔ OffDirs D φ := by
  constructor
  · intro h δ hδ n hn
    exact h δ hδ (n + m) (by rw [hn]; push_cast; ring)
  · intro h δ hδ n hn
    exact h δ hδ (n - m) (by push_cast; linarith)

/-- **The directions of `D` are isolated mod `2π`**: near any angle every other angle is off `D`. -/
theorem exists_offDirs_punctured (D : Finset ℝ) (β : ℝ) : ∃ t > 0, ∀ φ, φ ≠ β → |φ - β| < t → OffDirs D φ := by
  classical
  have hp : (0 : ℝ) < 2 * π := by positivity
  set P : Finset ℝ := (D.image (toIcoMod hp (β - π))).erase β with hP
  obtain ⟨t, ht, hball⟩ := Metric.isOpen_iff.mp P.finite_toSet.isClosed.isOpen_compl β (by simp [hP])
  refine ⟨min t π, lt_min ht Real.pi_pos, fun φ hφ hφt δ hδ m hm => ?_⟩
  have h1 : |φ - β| < t := hφt.trans_le (min_le_left _ _)
  have h2 := abs_lt.mp (hφt.trans_le (min_le_right _ _))
  have hφP : φ ∈ P := by
    refine Finset.mem_erase.mpr ⟨hφ, Finset.mem_image.mpr ⟨δ, hδ, ?_⟩⟩
    rw [toIcoMod_eq_iff]
    refine ⟨⟨by linarith, by linarith⟩, -m, ?_⟩
    rw [hm, zsmul_eq_mul]; push_cast; ring
  exact hball (by rw [mem_ball, Real.dist_eq]; exact h1) (Finset.mem_coe.mpr hφP)

/-- Every open interval holds a direction off `D`. -/
theorem exists_offDirs_Ioo (D : Finset ℝ) {a b : ℝ} (hab : a < b) : ∃ φ ∈ Ioo a b, OffDirs D φ := by
  obtain ⟨t, ht, h⟩ := exists_offDirs_punctured D a
  have hu0 : 0 < min t (b - a) := lt_min ht (by linarith)
  have hu1 := min_le_left t (b - a)
  have hu2 := min_le_right t (b - a)
  refine ⟨a + min t (b - a) / 2, ⟨by linarith, by linarith⟩, h _ (by intro h'; linarith) ?_⟩
  rw [abs_of_pos (by linarith)]; linarith

/-- Every point of a closed interval is a limit of directions off `D` inside the open interval. -/
theorem mem_closure_offDirs_Ioo (D : Finset ℝ) {a b y : ℝ} (hab : a < b) (hy : y ∈ Icc a b) :
    y ∈ closure {φ | φ ∈ Ioo a b ∧ OffDirs D φ} := by
  obtain ⟨t, ht, h⟩ := exists_offDirs_punctured D y
  rw [Metric.mem_closure_iff]
  intro ε hε
  rcases lt_or_eq_of_le hy.2 with hyb | hyb
  · have hu0 : 0 < min (min t ε) (b - y) := lt_min (lt_min ht hε) (by linarith)
    have hu1 := min_le_left (min t ε) (b - y)
    have hu2 := min_le_right (min t ε) (b - y)
    have hu3 := min_le_left t ε
    have hu4 := min_le_right t ε
    refine ⟨y + min (min t ε) (b - y) / 2, ⟨⟨by linarith [hy.1], by linarith⟩, h _ (by intro h'; linarith) ?_⟩, ?_⟩
    · rw [abs_of_pos (by linarith)]; linarith
    · rw [Real.dist_eq, abs_of_neg (by linarith)]; linarith
  · have hu0 : 0 < min (min t ε) (b - a) := lt_min (lt_min ht hε) (by linarith)
    have hu1 := min_le_left (min t ε) (b - a)
    have hu2 := min_le_right (min t ε) (b - a)
    have hu3 := min_le_left t ε
    have hu4 := min_le_right t ε
    refine ⟨y - min (min t ε) (b - a) / 2, ⟨⟨by linarith, by linarith⟩, h _ (by intro h'; linarith) ?_⟩, ?_⟩
    · rw [abs_of_neg (by linarith)]; linarith
    · rw [Real.dist_eq, abs_of_pos (by linarith)]; linarith

/-- The rotation of `Fin n` in values: `i ↦ i + 1`, and the last to `0`. -/
theorem finRotate_val {n : ℕ} (i : Fin n) : ((finRotate n i : Fin n) : ℕ) = if (i : ℕ) + 1 < n then (i : ℕ) + 1 else 0 := by
  cases n with
  | zero => exact i.elim0
  | succ m =>
    rw [coe_finRotate]
    by_cases h : i = Fin.last m
    · subst h; simp
    · have : (i : ℕ) < m := Fin.val_lt_last h
      rw [if_neg h, if_pos (by omega)]

/-- A radius about `β` inside which every other angle is off `D` (`exists_offDirs_punctured`). -/
noncomputable def isoRad (D : Finset ℝ) (β : ℝ) : ℝ := Classical.choose (exists_offDirs_punctured D β)

theorem isoRad_pos (D : Finset ℝ) (β : ℝ) : 0 < isoRad D β := (Classical.choose_spec (exists_offDirs_punctured D β)).1

theorem offDirs_of_isoRad {D : Finset ℝ} {β φ : ℝ} (h : φ ≠ β) (h' : |φ - β| < isoRad D β) : OffDirs D φ :=
  (Classical.choose_spec (exists_offDirs_punctured D β)).2 φ h h'

/-- The colour just counter-clockwise of the direction `β`, read off `σ`. -/
noncomputable def rightCol {k : ℕ} (D : Finset ℝ) (σ : ℝ → Fin k) (β : ℝ) : Fin k := σ (β + isoRad D β / 2)

/-- The colour just clockwise of the direction `β`, read off `σ`. -/
noncomputable def leftCol {k : ℕ} (D : Finset ℝ) (σ : ℝ → Fin k) (β : ℝ) : Fin k := σ (β - isoRad D β / 2)

namespace ArcMap

variable {k : ℕ} {F : ArcMap k} {v : ℂ} {D : Finset ℝ} {σ : ℝ → Fin k}

/-- Off `D`, a direction is in the cone of its own colour's class. -/
theorem DirColourAt.mem_coneAt (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) :
    φ ∈ coneAt (F.region (σ φ)) v := by
  obtain ⟨r, hr, hsub⟩ := hD φ hφ
  exact coneAt_mono hsub v (mem_coneAt_annSector v hr ⟨by linarith, by linarith⟩)

/-- Off `D`, only the direction's own colour approaches along it. -/
theorem DirColourAt.eq_of_mem_coneAt (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) {j : Fin k}
    (h : φ ∈ coneAt (F.region j) v) : j = σ φ := by
  obtain ⟨r, hr, hsub⟩ := hD φ hφ
  obtain ⟨z, ⟨hzj, hzA⟩, -⟩ := mem_coneAt_inter_annSector h hr hr 1 one_pos
  have h1 : F.col z = j := hzj.2
  have h2 : F.col z = σ φ := (hsub hzA).2
  exact h1.symm.trans h2

/-- The colour is locally constant off `D`. -/
theorem DirColourAt.eq_of_near (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) :
    ∃ r > 0, ∀ ψ, |ψ - φ| < r → OffDirs D ψ → σ ψ = σ φ := by
  obtain ⟨r, hr, hsub⟩ := hD φ hφ
  refine ⟨r, hr, fun ψ hψ hψD => (hD.eq_of_mem_coneAt hψD ?_).symm⟩
  have := abs_lt.mp hψ
  exact coneAt_mono hsub v (mem_coneAt_annSector v hr ⟨by linarith, by linarith⟩)

/-- The colour is `2π`-periodic off `D`. -/
theorem DirColourAt.eq_add_int (hD : F.DirColourAt v D σ) {φ : ℝ} (hφ : OffDirs D φ) (m : ℤ) :
    σ (φ + 2 * π * m) = σ φ :=
  (hD.eq_of_mem_coneAt ((offDirs_add_int m).mpr hφ)
    ((periodic_int (fun _ => mem_coneAt_add_two_pi) φ m).mpr (hD.mem_coneAt hφ))).symm

/-- The colour is constant on an open interval of directions off `D`. -/
theorem DirColourAt.eq_of_Ioo (hD : F.DirColourAt v D σ) {a b : ℝ} (hab : ∀ φ ∈ Ioo a b, OffDirs D φ) {φ ψ : ℝ}
    (hφ : φ ∈ Ioo a b) (hψ : ψ ∈ Ioo a b) : σ φ = σ ψ := by
  refine isPreconnected_Ioo.constant (fun x hx => ?_) hφ hψ
  obtain ⟨r, hr, h⟩ := hD.eq_of_near (hab x hx)
  refine (tendsto_nhds_of_eventually_eq ?_ : Tendsto σ (𝓝[Ioo a b] x) (𝓝 (σ x)))
  filter_upwards [nhdsWithin_le_nhds (Metric.ball_mem_nhds x hr), self_mem_nhdsWithin] with y hy hyI
  exact h y (by rw [mem_ball, Real.dist_eq] at hy; exact hy) (hab y hyI)

/-- Just counter-clockwise of `β` the colour is `rightCol`. -/
theorem DirColourAt.eq_rightCol (hD : F.DirColourAt v D σ) {β φ : ℝ} (hφ : φ ∈ Ioo β (β + isoRad D β)) :
    σ φ = rightCol D σ β := by
  have hoff : ∀ ψ ∈ Ioo β (β + isoRad D β), OffDirs D ψ := fun ψ hψ =>
    offDirs_of_isoRad (ne_of_gt hψ.1) (by rw [abs_of_pos (by linarith [hψ.1])]; linarith [hψ.2])
  have := isoRad_pos D β
  exact hD.eq_of_Ioo hoff hφ ⟨by linarith, by linarith⟩

/-- Just clockwise of `β` the colour is `leftCol`. -/
theorem DirColourAt.eq_leftCol (hD : F.DirColourAt v D σ) {β φ : ℝ} (hφ : φ ∈ Ioo (β - isoRad D β) β) :
    σ φ = leftCol D σ β := by
  have hoff : ∀ ψ ∈ Ioo (β - isoRad D β) β, OffDirs D ψ := fun ψ hψ =>
    offDirs_of_isoRad (ne_of_lt hψ.2) (by rw [abs_of_neg (by linarith [hψ.2])]; linarith [hψ.1])
  have := isoRad_pos D β
  exact hD.eq_of_Ioo hoff hφ ⟨by linarith, by linarith⟩

/-- `rightCol` is the colour of any right half-neighbourhood. -/
theorem DirColourAt.rightCol_eq_of (hD : F.DirColourAt v D σ) {β t : ℝ} {c : Fin k} (ht : 0 < t)
    (h : ∀ φ ∈ Ioo β (β + t), OffDirs D φ → σ φ = c) : rightCol D σ β = c := by
  have h0 := lt_min ht (isoRad_pos D β)
  obtain ⟨φ, hφ, hφD⟩ := exists_offDirs_Ioo D (show β < β + min t (isoRad D β) by linarith)
  rw [← hD.eq_rightCol ⟨hφ.1, hφ.2.trans_le (by linarith [min_le_right t (isoRad D β)])⟩]
  exact h φ ⟨hφ.1, hφ.2.trans_le (by linarith [min_le_left t (isoRad D β)])⟩ hφD

/-- `leftCol` is the colour of any left half-neighbourhood. -/
theorem DirColourAt.leftCol_eq_of (hD : F.DirColourAt v D σ) {β t : ℝ} {c : Fin k} (ht : 0 < t)
    (h : ∀ φ ∈ Ioo (β - t) β, OffDirs D φ → σ φ = c) : leftCol D σ β = c := by
  have h0 := lt_min ht (isoRad_pos D β)
  obtain ⟨φ, hφ, hφD⟩ := exists_offDirs_Ioo D (show β - min t (isoRad D β) < β by linarith)
  rw [← hD.eq_leftCol ⟨(by linarith [min_le_right t (isoRad D β)] : β - isoRad D β ≤ β - min t (isoRad D β)).trans_lt hφ.1, hφ.2⟩]
  exact h φ ⟨(by linarith [min_le_left t (isoRad D β)] : β - t ≤ β - min t (isoRad D β)).trans_lt hφ.1, hφ.2⟩ hφD

/-- Off `D` both side colours are the colour itself. -/
theorem DirColourAt.rightCol_of_offDirs (hD : F.DirColourAt v D σ) {β : ℝ} (hβ : OffDirs D β) :
    rightCol D σ β = σ β ∧ leftCol D σ β = σ β := by
  have hoff : ∀ ψ ∈ Ioo (β - isoRad D β) (β + isoRad D β), OffDirs D ψ := fun ψ hψ => by
    by_cases h : ψ = β
    · rw [h]; exact hβ
    · exact offDirs_of_isoRad h (abs_lt.mpr ⟨by linarith [hψ.1], by linarith [hψ.2]⟩)
  have := isoRad_pos D β
  exact ⟨hD.eq_of_Ioo hoff ⟨by linarith, by linarith⟩ ⟨by linarith, by linarith⟩,
    hD.eq_of_Ioo hoff ⟨by linarith, by linarith⟩ ⟨by linarith, by linarith⟩⟩

/-- `rightCol` is `2π`-periodic. -/
theorem DirColourAt.rightCol_add_int (hD : F.DirColourAt v D σ) (β : ℝ) (m : ℤ) :
    rightCol D σ (β + 2 * π * m) = rightCol D σ β := by
  refine hD.rightCol_eq_of (isoRad_pos D β) fun φ hφ hφD => ?_
  have h1 : φ - 2 * π * m ∈ Ioo β (β + isoRad D β) := ⟨by linarith [hφ.1], by linarith [hφ.2]⟩
  have h2 : OffDirs D (φ - 2 * π * m) := (offDirs_add_int m).mp (by rwa [sub_add_cancel])
  have h3 := hD.eq_add_int h2 m
  rw [sub_add_cancel] at h3
  rw [h3]; exact hD.eq_rightCol h1

/-- `leftCol` is `2π`-periodic. -/
theorem DirColourAt.leftCol_add_int (hD : F.DirColourAt v D σ) (β : ℝ) (m : ℤ) :
    leftCol D σ (β + 2 * π * m) = leftCol D σ β := by
  refine hD.leftCol_eq_of (isoRad_pos D β) fun φ hφ hφD => ?_
  have h1 : φ - 2 * π * m ∈ Ioo (β - isoRad D β) β := ⟨by linarith [hφ.1], by linarith [hφ.2]⟩
  have h2 : OffDirs D (φ - 2 * π * m) := (offDirs_add_int m).mp (by rwa [sub_add_cancel])
  have h3 := hD.eq_add_int h2 m
  rw [sub_add_cancel] at h3
  rw [h3]; exact hD.eq_leftCol h1

/-- The right colour approaches along `β`. -/
theorem DirColourAt.rightCol_mem_coneAt (hD : F.DirColourAt v D σ) (β : ℝ) :
    β ∈ coneAt (F.region (rightCol D σ β)) v := by
  have hI : Ioo β (β + isoRad D β) ⊆ coneAt (F.region (rightCol D σ β)) v := fun φ hφ => by
    have hφD : OffDirs D φ := offDirs_of_isoRad (ne_of_gt hφ.1) (by rw [abs_of_pos (by linarith [hφ.1])]; linarith [hφ.2])
    rw [← hD.eq_rightCol hφ]; exact hD.mem_coneAt hφD
  have := isoRad_pos D β
  exact closure_minimal hI (isClosed_coneAt _ _) (by rw [closure_Ioo (ne_of_lt (by linarith))]; exact ⟨le_rfl, by linarith⟩)

/-- The left colour approaches along `β`. -/
theorem DirColourAt.leftCol_mem_coneAt (hD : F.DirColourAt v D σ) (β : ℝ) :
    β ∈ coneAt (F.region (leftCol D σ β)) v := by
  have hI : Ioo (β - isoRad D β) β ⊆ coneAt (F.region (leftCol D σ β)) v := fun φ hφ => by
    have hφD : OffDirs D φ := offDirs_of_isoRad (ne_of_lt hφ.2) (by rw [abs_of_neg (by linarith [hφ.2])]; linarith [hφ.1])
    rw [← hD.eq_leftCol hφ]; exact hD.mem_coneAt hφD
  have := isoRad_pos D β
  exact closure_minimal hI (isClosed_coneAt _ _) (by rw [closure_Ioo (ne_of_lt (by linarith))]; exact ⟨by linarith, le_rfl⟩)

/-- A change of colour happens only at a direction of `D` (mod `2π`). -/
theorem DirColourAt.not_offDirs_of_ne (hD : F.DirColourAt v D σ) {β : ℝ} (h : leftCol D σ β ≠ rightCol D σ β) :
    ¬ OffDirs D β := fun hβ => h (by rw [(hD.rightCol_of_offDirs hβ).1, (hD.rightCol_of_offDirs hβ).2])

/-- **Between two directions with no change of colour strictly between, the colour is constant.** -/
theorem DirColourAt.const_of_noChange (hD : F.DirColourAt v D σ) {a b : ℝ} (hab : a < b)
    (hno : ∀ y ∈ Ioo a b, leftCol D σ y = rightCol D σ y) :
    rightCol D σ a = leftCol D σ b ∧ ∀ y ∈ Ioo a b, OffDirs D y → σ y = rightCol D σ a := by
  have hloc : ∀ y ∈ Ioo a b, ∀ z, |z - y| < isoRad D y → rightCol D σ z = rightCol D σ y := by
    intro y hy z hz
    by_cases hzy : z = y
    · rw [hzy]
    have hzD : OffDirs D z := offDirs_of_isoRad hzy hz
    rw [(hD.rightCol_of_offDirs hzD).1]
    rcases lt_or_gt_of_ne hzy with h | h
    · rw [← hno y hy]; exact hD.eq_leftCol ⟨by linarith [(abs_lt.mp hz).1], h⟩
    · exact hD.eq_rightCol ⟨h, by linarith [(abs_lt.mp hz).2]⟩
  have hconst : ∀ y ∈ Ioo a b, ∀ z ∈ Ioo a b, rightCol D σ y = rightCol D σ z := fun y hy z hz => by
    refine isPreconnected_Ioo.constant (fun x hx => ?_) hy hz
    refine (tendsto_nhds_of_eventually_eq ?_ : Tendsto (rightCol D σ) (𝓝[Ioo a b] x) (𝓝 (rightCol D σ x)))
    filter_upwards [nhdsWithin_le_nhds (Metric.ball_mem_nhds x (isoRad_pos D x))] with z hz
    exact hloc x hx z (by rw [mem_ball, Real.dist_eq] at hz; exact hz)
  have ha := isoRad_pos D a
  have hb := isoRad_pos D b
  have hu1 := min_le_left (isoRad D a) (b - a)
  have hu2 := min_le_right (isoRad D a) (b - a)
  have hu3 := min_le_left (isoRad D b) (b - a)
  have hu4 := min_le_right (isoRad D b) (b - a)
  have hu5 : 0 < min (isoRad D a) (b - a) := lt_min ha (by linarith)
  have hu6 : 0 < min (isoRad D b) (b - a) := lt_min hb (by linarith)
  set y₁ := a + min (isoRad D a) (b - a) / 2 with hy₁
  set y₂ := b - min (isoRad D b) (b - a) / 2 with hy₂
  have hy₁I : y₁ ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have hy₂I : y₂ ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have hy₁D : OffDirs D y₁ := offDirs_of_isoRad (β := a) (by linarith) (by rw [abs_of_pos (by linarith)]; linarith)
  have hy₂D : OffDirs D y₂ := offDirs_of_isoRad (β := b) (by linarith) (by rw [abs_of_neg (by linarith)]; linarith)
  have e1 : rightCol D σ a = rightCol D σ y₁ := by
    rw [(hD.rightCol_of_offDirs hy₁D).1]; exact (hD.eq_rightCol ⟨by linarith, by linarith⟩).symm
  have e2 : leftCol D σ b = rightCol D σ y₂ := by
    rw [(hD.rightCol_of_offDirs hy₂D).1]; exact (hD.eq_leftCol ⟨by linarith, by linarith⟩).symm
  refine ⟨by rw [e1, e2]; exact hconst _ hy₁I _ hy₂I, fun y hy hyD => ?_⟩
  rw [e1, ← (hD.rightCol_of_offDirs hyD).1]; exact hconst _ hy _ hy₁I

/-- A colour constant on an interval leaves no change of colour inside it. -/
theorem DirColourAt.noChange_of_const (hD : F.DirColourAt v D σ) {a b y : ℝ} {c : Fin k} (hy : y ∈ Ioo a b)
    (h : ∀ φ ∈ Ioo a b, OffDirs D φ → σ φ = c) : leftCol D σ y = rightCol D σ y := by
  rw [hD.leftCol_eq_of (sub_pos.mpr hy.1) (fun φ hφ hφD => h φ ⟨by linarith [hφ.1], hφ.2.trans hy.2⟩ hφD),
    hD.rightCol_eq_of (sub_pos.mpr hy.2) (fun φ hφ hφD => h φ ⟨hy.1.trans hφ.1, by linarith [hφ.2]⟩ hφD)]

/-- **The `NiceAt` picture from the local data** (E3-NICE's last paragraph). -/
theorem niceAt_of_dirColourAt' {v : ℂ} (hv : v ∈ F.dom) {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ)
    (hrun : ∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁))
    (hpoke : ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (F.region j) v →
      (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c)
    (h3 : 3 ≤ (F.coloursAt v).ncard) : F.NiceAt v := by
  classical
  have _ := h3
  have hπ := Real.pi_pos
  have hp : (0 : ℝ) < 2 * π := by positivity
  -- at a direction with no change of colour, only the run's colour approaches `v` (`hpoke`, at every direction)
  have hnc : ∀ β (j : Fin k), leftCol D σ β = rightCol D σ β → β ∈ coneAt (F.region j) v → j = rightCol D σ β := by
    intro β j hLR hj
    by_cases hβ : OffDirs D β
    · rw [hD.eq_of_mem_coneAt hβ hj, (hD.rightCol_of_offDirs hβ).1]
    · simp only [OffDirs, not_forall, not_not] at hβ
      obtain ⟨δ, hδ, m, rfl⟩ := hβ
      refine hpoke δ hδ j _ ((periodic_int (fun _ => mem_coneAt_add_two_pi) δ m).mp hj)
        ⟨isoRad D (δ + 2 * π * m), isoRad_pos _ _, fun φ hφ hφD => ?_⟩
      rw [← hD.eq_add_int hφD m]
      rcases lt_trichotomy (φ + 2 * π * m) (δ + 2 * π * m) with h | h | h
      · rw [← hLR]; exact hD.eq_leftCol ⟨by linarith [hφ.1], h⟩
      · exact absurd (show φ = δ + 2 * π * ((0 : ℤ) : ℝ) by push_cast; linarith) (hφD δ hδ 0)
      · exact hD.eq_rightCol ⟨h, by linarith [hφ.2]⟩
  -- a window `[θ₀, θ₀ + 2π)` starting off `D`, and the directions of `D` in it
  obtain ⟨θ₀, -, hθ₀⟩ := exists_offDirs_Ioo D zero_lt_one
  obtain ⟨Pw, hPw⟩ : ∃ Pw : Finset ℝ, ∀ y, y ∈ Pw ↔ y ∈ Ico θ₀ (θ₀ + 2 * π) ∧ ¬ OffDirs D y := by
    refine ⟨D.image (toIcoMod hp θ₀), fun y => ⟨fun hy => ?_, fun ⟨hy1, hy2⟩ => ?_⟩⟩
    · obtain ⟨δ, hδ, rfl⟩ := Finset.mem_image.mp hy
      refine ⟨toIcoMod_mem_Ico hp θ₀ δ, fun h => h δ hδ (-toIcoDiv hp θ₀ δ) ?_⟩
      rw [← self_sub_toIcoDiv_zsmul, zsmul_eq_mul]; push_cast; ring
    · simp only [OffDirs, not_forall, not_not] at hy2
      obtain ⟨δ, hδ, m, hm⟩ := hy2
      refine Finset.mem_image.mpr ⟨δ, hδ, ?_⟩
      rw [toIcoMod_eq_iff]
      exact ⟨hy1, -m, by rw [hm, zsmul_eq_mul]; push_cast; ring⟩
  have hPw_win : ∀ y ∈ Pw, y ∈ Ioo θ₀ (θ₀ + 2 * π) := fun y hy => by
    obtain ⟨h1, h2⟩ := (hPw y).mp hy
    exact ⟨lt_of_le_of_ne h1.1 fun h => h2 (h ▸ hθ₀), h1.2⟩
  -- the horn colours at a direction
  obtain ⟨Hs, hHs⟩ : ∃ Hs : ℝ → Finset (Fin k), ∀ q j, j ∈ Hs q ↔
      (q ∈ coneAt (F.region j) v ∧ j ≠ leftCol D σ q ∧ j ≠ rightCol D σ q) :=
    ⟨fun q => Finset.univ.filter fun j => q ∈ coneAt (F.region j) v ∧ j ≠ leftCol D σ q ∧ j ≠ rightCol D σ q,
      fun q j => by simp⟩
  have hHs_ne : ∀ q (j : Fin k), j ∈ Hs q → j ≠ leftCol D σ q ∧ j ≠ rightCol D σ q := fun q j h =>
    ⟨((hHs q j).mp h).2.1, ((hHs q j).mp h).2.2⟩
  -- the sectors as (direction, rank): rank `j < k` a horn of colour `j`, rank `k` the run starting there
  obtain ⟨S0, hS0mem⟩ : ∃ S0 : Finset (ℝ × ℕ), ∀ p, p ∈ S0 ↔ p.1 ∈ Pw ∧
      ((p.2 < k ∧ ∃ j ∈ Hs p.1, (j : ℕ) = p.2) ∨ (p.2 = k ∧ leftCol D σ p.1 ≠ rightCol D σ p.1)) := by
    refine ⟨(Pw ×ˢ Finset.range (k + 1)).filter fun p =>
      (p.2 < k ∧ ∃ j ∈ Hs p.1, (j : ℕ) = p.2) ∨ (p.2 = k ∧ leftCol D σ p.1 ≠ rightCol D σ p.1), fun p => ?_⟩
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_range]
    constructor
    · rintro ⟨⟨h1, -⟩, h2⟩; exact ⟨h1, h2⟩
    · rintro ⟨h1, h2⟩
      refine ⟨⟨h1, ?_⟩, h2⟩
      rcases h2 with ⟨h, -⟩ | ⟨h, -⟩ <;> omega
  have hch : ∀ p ∈ S0, leftCol D σ p.1 ≠ rightCol D σ p.1 := by
    intro p hp
    rcases ((hS0mem p).mp hp).2 with ⟨-, j, hj, -⟩ | ⟨-, h⟩
    · intro hLR
      exact (hHs_ne _ _ hj).2 (hnc _ _ hLR ((hHs _ _).mp hj).1)
    · exact h
  have hrun_mem : ∀ p ∈ S0, (p.1, k) ∈ S0 := fun p hp =>
    (hS0mem _).mpr ⟨((hS0mem p).mp hp).1, Or.inr ⟨rfl, hch p hp⟩⟩
  have hrank : ∀ p ∈ S0, p.2 ≤ k := fun p hp => by
    rcases ((hS0mem p).mp hp).2 with ⟨h, -⟩ | ⟨h, -⟩ <;> omega
  by_cases hS : S0 = ∅
  · -- no change of colour anywhere: one run, one sector
    have hno : ∀ y, leftCol D σ y = rightCol D σ y := by
      intro y
      by_contra hy
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ y
      have hy' : leftCol D σ (y + 2 * π * m) ≠ rightCol D σ (y + 2 * π * m) := by
        rwa [hD.leftCol_add_int, hD.rightCol_add_int]
      have := (hS0mem (y + 2 * π * m, k)).mpr ⟨(hPw _).mpr ⟨hm, hD.not_offDirs_of_ne hy'⟩, Or.inr ⟨rfl, hy'⟩⟩
      rw [hS] at this; simp at this
    have hconst := hD.const_of_noChange (show θ₀ - 2 * π < θ₀ + 2 * π by linarith) fun y _ => hno y
    have hσ : ∀ φ, OffDirs D φ → σ φ = σ θ₀ := by
      intro φ hφ
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ φ
      rw [← hD.eq_add_int hφ m, hconst.2 _ ⟨by linarith [hm.1], hm.2⟩ ((offDirs_add_int m).mpr hφ),
        ← hconst.2 θ₀ ⟨by linarith, by linarith⟩ hθ₀]
    have hRc : ∀ β, rightCol D σ β = σ θ₀ := fun β => by
      obtain ⟨φ, hφ, hφD⟩ := exists_offDirs_Ioo D (show β < β + isoRad D β by linarith [isoRad_pos D β])
      rw [← hD.eq_rightCol hφ]; exact hσ φ hφD
    have hall : angleIcc θ₀ (θ₀ + 2 * π) = univ := eq_univ_of_forall fun β => by
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ β
      exact mem_iUnion.mpr ⟨-m, by push_cast; constructor <;> linarith [hm.1, hm.2]⟩
    refine ⟨1, ![θ₀, θ₀ + 2 * π], fun _ => σ θ₀, ⟨one_pos, fun a b hab => ?_, by simp, fun h => by omega, hv, fun j => ?_⟩,
      fun i j hij => absurd (Subsingleton.elim i j) hij, fun i hi => ?_⟩
    · fin_cases a <;> fin_cases b <;> simp at hab ⊢
      linarith
    · ext β
      simp only [mem_iUnion, mem_setOf_eq, exists_prop]
      by_cases h : σ θ₀ = j
      · subst h
        refine ⟨fun _ => ⟨0, rfl, ?_⟩, fun _ => by rw [← hRc β]; exact hD.rightCol_mem_coneAt β⟩
        show β ∈ angleIcc θ₀ (θ₀ + 2 * π)
        rw [hall]; trivial
      · exact ⟨fun hβ => absurd ((hnc β j (hno β) hβ).trans (hRc β)).symm h, fun ⟨_, h', _⟩ => absurd h' h⟩
    · fin_cases i
      have : θ₀ = θ₀ + 2 * π := hi
      linarith
  -- sort the sectors
  obtain ⟨n, pf, hn0, hpfS, hS0pf, hpflt⟩ : ∃ (n : ℕ) (pf : Fin n → ℝ × ℕ), 0 < n ∧ (∀ i, pf i ∈ S0) ∧
      (∀ p ∈ S0, ∃ i, pf i = p) ∧
      ∀ i j, i < j ↔ ((pf i).1 < (pf j).1 ∨ ((pf i).1 = (pf j).1 ∧ (pf i).2 < (pf j).2)) := by
    set S : Finset (Lex (ℝ × ℕ)) := S0.map toLex.toEmbedding with hSdef
    set f := S.orderEmbOfFin rfl
    refine ⟨S.card, fun i => ofLex (f i), ?_, fun i => ?_, fun p hp => ?_, fun i j => ?_⟩
    · exact Finset.card_pos.mpr ((Finset.nonempty_iff_ne_empty.mpr hS).map)
    · obtain ⟨p, hp, hpf⟩ := Finset.mem_map.mp (S.orderEmbOfFin_mem rfl i)
      show ofLex (f i) ∈ S0
      rw [← hpf]; exact hp
    · have h1 : toLex p ∈ (S : Set (Lex (ℝ × ℕ))) := by rw [hSdef, Finset.coe_map]; exact ⟨p, hp, rfl⟩
      rw [← Finset.range_orderEmbOfFin S rfl] at h1
      obtain ⟨i, hi⟩ := h1
      exact ⟨i, by show ofLex (f i) = p; rw [hi]; rfl⟩
    · show i < j ↔ (ofLex (f i)).1 < (ofLex (f j)).1 ∨ ((ofLex (f i)).1 = (ofLex (f j)).1 ∧ (ofLex (f i)).2 < (ofLex (f j)).2)
      rw [← Prod.Lex.lt_iff]; exact f.lt_iff_lt.symm
  have hle : ∀ i j : Fin n, i ≤ j → (pf i).1 ≤ (pf j).1 := fun i j h => by
    rcases eq_or_lt_of_le h with rfl | h
    · exact le_rfl
    · rcases (hpflt i j).mp h with h' | h'
      · exact h'.le
      · exact h'.1.le
  have hinj : ∀ i j : Fin n, pf i = pf j → i = j := fun i j h => by
    by_contra hne
    rcases lt_or_gt_of_ne hne with h' | h'
    · rcases (hpflt i j).mp h' with h'' | h''
      · rw [h] at h''; exact lt_irrefl _ h''
      · rw [h] at h''; exact lt_irrefl _ h''.2
    · rcases (hpflt j i).mp h' with h'' | h''
      · rw [h] at h''; exact lt_irrefl _ h''
      · rw [h] at h''; exact lt_irrefl _ h''.2
  have hq_win : ∀ i, (pf i).1 ∈ Ioo θ₀ (θ₀ + 2 * π) := fun i => hPw_win _ ((hS0mem _).mp (hpfS i)).1
  obtain ⟨d, hdc, hds1, hds2, hlast, hmono⟩ : ∃ d : Fin (n + 1) → ℝ, (∀ i : Fin n, d i.castSucc = (pf i).1) ∧
      (∀ (i : Fin n) (h : (i : ℕ) + 1 < n), d i.succ = (pf ⟨i + 1, h⟩).1) ∧
      (∀ i : Fin n, ¬ (i : ℕ) + 1 < n → d i.succ = (pf ⟨0, hn0⟩).1 + 2 * π) ∧
      d (Fin.last n) = d 0 + 2 * π ∧ Monotone d := by
    refine ⟨fun i => if h : (i : ℕ) < n then (pf ⟨i, h⟩).1 else (pf ⟨0, hn0⟩).1 + 2 * π, fun i => ?_, fun i h => ?_,
      fun i h => ?_, ?_, fun a b hab => ?_⟩
    · simp [i.isLt]
    · simp [h]
    · simp [h]
    · simp [hn0]
    · simp only
      split_ifs with h1 h2 h2
      · exact hle _ _ (Fin.le_def.mpr (Fin.le_def.mp hab))
      · linarith [(hq_win ⟨a, h1⟩).2, (hq_win ⟨0, hn0⟩).1]
      · exact absurd ((Fin.le_def.mp hab).trans_lt h2) h1
      · exact le_rfl
  obtain ⟨c, hc_horn, hc_run⟩ : ∃ c : Fin n → Fin k, (∀ i (h : (pf i).2 < k), c i = ⟨(pf i).2, h⟩) ∧
      (∀ i, (pf i).2 = k → c i = rightCol D σ (pf i).1) :=
    ⟨fun i => if h : (pf i).2 < k then ⟨(pf i).2, h⟩ else rightCol D σ (pf i).1, fun i h => dif_pos h,
      fun i h => dif_neg (by omega)⟩
  have hfr_succ : ∀ (i : Fin n) (h : (i : ℕ) + 1 < n), finRotate n i = ⟨i + 1, h⟩ := fun i h =>
    Fin.ext (by rw [finRotate_val, if_pos h])
  have hfr_last : ∀ i : Fin n, ¬ (i : ℕ) + 1 < n → finRotate n i = ⟨0, hn0⟩ := fun i h =>
    Fin.ext (by rw [finRotate_val, if_neg h])
  have hhornHs : ∀ (i : Fin n) (h : (pf i).2 < k), (⟨(pf i).2, h⟩ : Fin k) ∈ Hs (pf i).1 := by
    intro i h
    rcases ((hS0mem _).mp (hpfS i)).2 with ⟨-, j, hj, hjv⟩ | ⟨h', -⟩
    · have : j = ⟨(pf i).2, h⟩ := Fin.ext hjv
      rwa [← this]
    · omega
  -- after a horn comes the next sector at the same direction
  have hnext_horn : ∀ i : Fin n, (pf i).2 < k →
      ∃ h : (i : ℕ) + 1 < n, (pf ⟨i + 1, h⟩).1 = (pf i).1 ∧ (pf i).2 < (pf ⟨i + 1, h⟩).2 := by
    intro i hik
    obtain ⟨i', hi'⟩ := hS0pf _ (hrun_mem _ (hpfS i))
    have hii' : i < i' := (hpflt i i').mpr (Or.inr ⟨by rw [hi'], by rw [hi']; exact hik⟩)
    have h : (i : ℕ) + 1 < n := by have := i'.isLt; have : (i : ℕ) < i' := hii'; omega
    refine ⟨h, ?_⟩
    have h1 : i < ⟨i + 1, h⟩ := Fin.lt_def.mpr (by show (i : ℕ) < i + 1; omega)
    have h2 : (⟨i + 1, h⟩ : Fin n) ≤ i' := Fin.le_def.mpr (by show (i : ℕ) + 1 ≤ i'; have : (i : ℕ) < i' := hii'; omega)
    have e1 := hle _ _ h2
    rw [hi'] at e1; dsimp only at e1
    rcases (hpflt _ _).mp h1 with h3 | h3
    · linarith
    · exact ⟨h3.1.symm, h3.2⟩
  have hhorn_eq : ∀ i : Fin n, (pf i).2 < k → d i.succ = d i.castSucc := fun i hik => by
    obtain ⟨h, h1, -⟩ := hnext_horn i hik
    rw [hds1 i h, hdc, h1]
  -- a run reaches the next change of colour, and none lies inside it
  have harc : ∀ i : Fin n, (pf i).2 = k →
      (pf i).1 < d i.succ ∧ ∀ y ∈ Ioo (pf i).1 (d i.succ), leftCol D σ y = rightCol D σ y := by
    intro i hik
    by_cases h : (i : ℕ) + 1 < n
    · rw [hds1 i h]
      have h1 : i < ⟨i + 1, h⟩ := Fin.lt_def.mpr (by show (i : ℕ) < i + 1; omega)
      have hlt : (pf i).1 < (pf ⟨i + 1, h⟩).1 := by
        rcases (hpflt _ _).mp h1 with h3 | h3
        · exact h3
        · have := hrank _ (hpfS ⟨i + 1, h⟩); omega
      refine ⟨hlt, fun y hy => ?_⟩
      by_contra hne
      have hyP : y ∈ Pw := (hPw y).mpr ⟨⟨by linarith [(hq_win i).1, hy.1], by linarith [(hq_win ⟨i + 1, h⟩).2, hy.2]⟩,
        hD.not_offDirs_of_ne hne⟩
      obtain ⟨i'', hi''⟩ := hS0pf (y, k) ((hS0mem (y, k)).mpr ⟨hyP, Or.inr ⟨rfl, hne⟩⟩)
      have a1 : i < i'' := (hpflt _ _).mpr (Or.inl (by rw [hi'']; exact hy.1))
      have a2 : i'' < ⟨i + 1, h⟩ := (hpflt _ _).mpr (Or.inl (by rw [hi'']; exact hy.2))
      simp only [Fin.lt_def] at a1 a2; omega
    · rw [hds2 i h]
      refine ⟨by linarith [(hq_win i).2, (hq_win ⟨0, hn0⟩).1], fun y hy => ?_⟩
      by_contra hne
      by_cases hy2 : y < θ₀ + 2 * π
      · have hyP : y ∈ Pw := (hPw y).mpr ⟨⟨by linarith [(hq_win i).1, hy.1], hy2⟩, hD.not_offDirs_of_ne hne⟩
        obtain ⟨i'', hi''⟩ := hS0pf (y, k) ((hS0mem (y, k)).mpr ⟨hyP, Or.inr ⟨rfl, hne⟩⟩)
        have a1 : i < i'' := (hpflt _ _).mpr (Or.inl (by rw [hi'']; exact hy.1))
        have := Fin.lt_def.mp a1; have := i''.isLt; omega
      · have hne' : leftCol D σ (y + 2 * π * ((-1 : ℤ) : ℝ)) ≠ rightCol D σ (y + 2 * π * ((-1 : ℤ) : ℝ)) := by
          rwa [hD.leftCol_add_int, hD.rightCol_add_int]
        have hyP : y + 2 * π * ((-1 : ℤ) : ℝ) ∈ Pw := (hPw _).mpr ⟨⟨by push_cast; linarith,
          by push_cast; linarith [(hq_win ⟨0, hn0⟩).2, hy.2]⟩, hD.not_offDirs_of_ne hne'⟩
        obtain ⟨i'', hi''⟩ := hS0pf (y + 2 * π * ((-1 : ℤ) : ℝ), k) ((hS0mem (y + 2 * π * ((-1 : ℤ) : ℝ), k)).mpr ⟨hyP, Or.inr ⟨rfl, hne'⟩⟩)
        have a1 := hle ⟨0, hn0⟩ i'' (Fin.le_def.mpr (Nat.zero_le _))
        rw [hi''] at a1; dsimp only at a1; push_cast at a1; linarith [hy.2]
  have hrun_col : ∀ i : Fin n, (pf i).2 = k → ∀ y, (pf i).1 ≤ y → y < d i.succ →
      rightCol D σ y = rightCol D σ (pf i).1 := by
    intro i hik y hy1 hy2
    rcases eq_or_lt_of_le hy1 with h | h
    · rw [h]
    · obtain ⟨hlt, hno⟩ := harc i hik
      exact hD.rightCol_eq_of (sub_pos.mpr hy2) fun φ hφ hφD =>
        (hD.const_of_noChange hlt hno).2 φ ⟨h.trans hφ.1, by linarith [hφ.2]⟩ hφD
  have harc_col : ∀ i : Fin n, (pf i).2 = k → rightCol D σ (pf i).1 = leftCol D σ (pf (finRotate n i)).1 := by
    intro i hik
    obtain ⟨hlt, hno⟩ := harc i hik
    rw [(hD.const_of_noChange hlt hno).1]
    by_cases h : (i : ℕ) + 1 < n
    · rw [hds1 i h, hfr_succ i h]
    · rw [hds2 i h, hfr_last i h, show (pf ⟨0, hn0⟩).1 + 2 * π = (pf ⟨0, hn0⟩).1 + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring,
        hD.leftCol_add_int]
  have hchsucc : ∀ i : Fin n, leftCol D σ (d i.succ) ≠ rightCol D σ (d i.succ) := by
    intro i
    by_cases h : (i : ℕ) + 1 < n
    · rw [hds1 i h]; exact hch _ (hpfS _)
    · rw [hds2 i h, show (pf ⟨0, hn0⟩).1 + 2 * π = (pf ⟨0, hn0⟩).1 + 2 * π * ((1 : ℤ) : ℝ) by push_cast; ring,
        hD.leftCol_add_int, hD.rightCol_add_int]
      exact hch _ (hpfS _)
  -- every direction lies in a run (half-open on the right)
  have hloc : ∀ y, ∃ i : Fin n, (pf i).2 = k ∧ ∃ m : ℤ, (pf i).1 ≤ y + 2 * π * m ∧ y + 2 * π * m < d i.succ := by
    intro y
    obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ y
    by_cases hA : ∃ i : Fin n, (pf i).2 = k ∧ (pf i).1 ≤ y + 2 * π * m
    · obtain ⟨i, hi, himax⟩ := (Finset.univ.filter fun i : Fin n => (pf i).2 = k ∧ (pf i).1 ≤ y + 2 * π * m).exists_max_image
        (fun i => (pf i).1) (by obtain ⟨i, hi⟩ := hA; exact ⟨i, by simp [hi]⟩)
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hi himax
      refine ⟨i, hi.1, m, hi.2, ?_⟩
      by_cases h : (i : ℕ) + 1 < n
      · rw [hds1 i h]
        by_contra hle'
        push Not at hle'
        obtain ⟨i'', hi''⟩ := hS0pf _ (hrun_mem _ (hpfS ⟨i + 1, h⟩))
        have h1 := himax i'' ⟨by rw [hi''], by rw [hi'']; exact hle'⟩
        have h2 := (harc i hi.1).1
        rw [hds1 i h] at h2
        rw [hi''] at h1; dsimp only at h1; linarith
      · rw [hds2 i h]; linarith [(hq_win ⟨0, hn0⟩).1, hm.2]
    · push Not at hA
      have hlt0 : y + 2 * π * m < (pf ⟨0, hn0⟩).1 := by
        obtain ⟨i0, hi0⟩ := hS0pf _ (hrun_mem _ (hpfS ⟨0, hn0⟩))
        have := hA i0 (by rw [hi0])
        rw [hi0] at this; exact this
      have hil : n - 1 < n := by omega
      have hilk : (pf ⟨n - 1, hil⟩).2 = k := by
        obtain ⟨i'', hi''⟩ := hS0pf _ (hrun_mem _ (hpfS ⟨n - 1, hil⟩))
        have h1 : i'' ≤ ⟨n - 1, hil⟩ := Fin.le_def.mpr (by have := i''.isLt; show (i'' : ℕ) ≤ n - 1; omega)
        rcases eq_or_lt_of_le h1 with h | h
        · rw [← h, hi'']
        · rcases (hpflt _ _).mp h with h' | h'
          · rw [hi''] at h'; dsimp only at h'; linarith
          · rw [hi''] at h'; have := h'.2; have := hrank _ (hpfS ⟨n - 1, hil⟩); dsimp only at *; omega
      refine ⟨⟨n - 1, hil⟩, hilk, m + 1, ?_, ?_⟩
      · push_cast; linarith [(hq_win ⟨n - 1, hil⟩).2, hm.1]
      · rw [hds2 _ (by show ¬ (n - 1 + 1 < n); omega)]; push_cast; linarith
  -- the cone clause
  have hcone : ∀ j : Fin k, coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ) := by
    intro j
    apply Subset.antisymm
    · intro β hβ
      simp only [mem_iUnion, mem_setOf_eq, exists_prop]
      by_cases hjR : j = rightCol D σ β
      · obtain ⟨i, hik, m, hm1, hm2⟩ := hloc β
        refine ⟨i, ?_, mem_iUnion.mpr ⟨-m, ?_⟩⟩
        · rw [hc_run i hik, ← hrun_col i hik _ hm1 hm2, hD.rightCol_add_int, hjR]
        · rw [hdc]; push_cast; constructor <;> linarith
      by_cases hjL : j = leftCol D σ β
      · have ht := isoRad_pos D β
        have hφ₀ : OffDirs D (β - isoRad D β / 2) :=
          offDirs_of_isoRad (β := β) (by linarith) (by rw [abs_of_neg (by linarith)]; linarith)
        have hL₀ : leftCol D σ β = rightCol D σ (β - isoRad D β / 2) := by
          rw [(hD.rightCol_of_offDirs hφ₀).1]; exact (hD.eq_leftCol ⟨by linarith, by linarith⟩).symm
        obtain ⟨i, hik, m, hm1, hm2⟩ := hloc (β - isoRad D β / 2)
        have hm3 : β + 2 * π * m ≤ d i.succ := by
          by_contra hlt
          push Not at hlt
          apply hchsucc i
          have hoff : OffDirs D (d i.succ + 2 * π * ((-m : ℤ) : ℝ)) :=
            offDirs_of_isoRad (β := β) (by push_cast; linarith) (by rw [abs_lt]; push_cast; constructor <;> linarith)
          have h' := hD.rightCol_of_offDirs ((offDirs_add_int (-m)).mp hoff)
          rw [h'.1, h'.2]
        refine ⟨i, ?_, mem_iUnion.mpr ⟨-m, ?_⟩⟩
        · rw [hc_run i hik, ← hrun_col i hik _ hm1 hm2, hD.rightCol_add_int, hjL, hL₀]
        · rw [hdc]; push_cast; constructor <;> linarith
      -- a horn at `β`
      have hchβ : leftCol D σ β ≠ rightCol D σ β := fun h => hjR (hnc β j h hβ)
      obtain ⟨m, hm⟩ := exists_shift_Ico θ₀ β
      have hβP : β + 2 * π * m ∈ Pw :=
        (hPw _).mpr ⟨hm, hD.not_offDirs_of_ne (by rwa [hD.leftCol_add_int, hD.rightCol_add_int])⟩
      have hjH : j ∈ Hs (β + 2 * π * m) := (hHs _ _).mpr ⟨(periodic_int (fun _ => mem_coneAt_add_two_pi) β m).mpr hβ,
        by rwa [hD.leftCol_add_int], by rwa [hD.rightCol_add_int]⟩
      obtain ⟨i, hi⟩ := hS0pf (β + 2 * π * m, j) ((hS0mem _).mpr ⟨hβP, Or.inl ⟨j.isLt, j, hjH, rfl⟩⟩)
      have hik : (pf i).2 < k := by rw [hi]; exact j.isLt
      refine ⟨i, ?_, mem_iUnion.mpr ⟨-m, ?_⟩⟩
      · rw [hc_horn i hik]; exact Fin.ext (show (pf i).2 = (j : ℕ) by rw [hi])
      · rw [hhorn_eq i hik, hdc, hi]; dsimp only; push_cast; constructor <;> linarith
    · intro β hβ
      simp only [mem_iUnion, mem_setOf_eq, exists_prop] at hβ
      obtain ⟨i, hci, hβ⟩ := hβ
      obtain ⟨m, hm⟩ := mem_iUnion.mp hβ
      rcases lt_or_eq_of_le (hrank _ (hpfS i)) with hik | hik
      · rw [hhorn_eq i hik, hdc] at hm
        have hβq : β = (pf i).1 + 2 * π * m := le_antisymm hm.2 hm.1
        rw [hβq, periodic_int (fun _ => mem_coneAt_add_two_pi), ← hci, hc_horn i hik]
        exact ((hHs _ _).mp (hhornHs i hik)).1
      · rw [← hci, hc_run i hik]
        obtain ⟨hlt, hno⟩ := harc i hik
        have hIcc : Icc (pf i).1 (d i.succ) ⊆ coneAt (F.region (rightCol D σ (pf i).1)) v := by
          intro y hy
          refine closure_minimal (fun φ hφ => ?_) (isClosed_coneAt _ _) (mem_closure_offDirs_Ioo D hlt hy)
          rw [← (hD.const_of_noChange hlt hno).2 φ hφ.1 hφ.2]; exact hD.mem_coneAt hφ.2
        rw [hdc] at hm
        have h1 := hIcc (show β - 2 * π * m ∈ Icc _ _ from ⟨by linarith [hm.1], by linarith [hm.2]⟩)
        rwa [show β - 2 * π * m = β + 2 * π * ((-m : ℤ) : ℝ) by push_cast; ring,
          periodic_int (fun _ => mem_coneAt_add_two_pi)] at h1
  -- adjacent sectors have different colours
  have hadj : ∀ i : Fin n, c i ≠ c (finRotate n i) := by
    intro i
    rcases lt_or_eq_of_le (hrank _ (hpfS i)) with hik | hik
    · obtain ⟨h, h1, h2⟩ := hnext_horn i hik
      rw [hfr_succ i h, hc_horn i hik]
      rcases lt_or_eq_of_le (hrank _ (hpfS ⟨i + 1, h⟩)) with h3 | h3
      · rw [hc_horn _ h3]; intro he; have h4 : (pf i).2 = (pf ⟨i + 1, h⟩).2 := congrArg Fin.val he; omega
      · rw [hc_run _ h3, h1]; exact (hHs_ne _ _ (hhornHs i hik)).2
    · rw [hc_run i hik, harc_col i hik]
      rcases lt_or_eq_of_le (hrank _ (hpfS (finRotate n i))) with h3 | h3
      · rw [hc_horn _ h3]; exact (hHs_ne _ _ (hhornHs _ h3)).1.symm
      · rw [hc_run _ h3]; exact hch _ (hpfS _)
  -- two runs never share a colour (`hrun`)
  have hruns : ∀ i j : Fin n, (pf i).2 = k → (pf j).2 = k → (pf i).1 < (pf j).1 →
      rightCol D σ (pf i).1 ≠ rightCol D σ (pf j).1 := by
    intro i j hik hjk hij hR
    obtain ⟨hi1, hi2⟩ := harc i hik
    obtain ⟨hj1, hj2⟩ := harc j hjk
    have hci := (hD.const_of_noChange hi1 hi2).2
    have hcj := (hD.const_of_noChange hj1 hj2).2
    obtain ⟨φ₁, hφ₁, hφ₁D⟩ := exists_offDirs_Ioo D hi1
    obtain ⟨φ₂, hφ₂, hφ₂D⟩ := exists_offDirs_Ioo D hj1
    have hlt : i < j := (hpflt i j).mpr (Or.inl hij)
    have hsi : d i.succ ≤ (pf j).1 := by
      have h : (i : ℕ) + 1 < n := by have := j.isLt; have : (i : ℕ) < j := hlt; omega
      rw [hds1 i h]
      exact hle _ _ (Fin.le_def.mpr (by show (i : ℕ) + 1 ≤ j; have : (i : ℕ) < j := hlt; omega))
    have hsj : d j.succ ≤ (pf i).1 + 2 * π := by
      by_cases h : (j : ℕ) + 1 < n
      · rw [hds1 j h]; linarith [(hq_win ⟨j + 1, h⟩).2, (hq_win i).1]
      · rw [hds2 j h]; linarith [hle ⟨0, hn0⟩ i (Fin.le_def.mpr (Nat.zero_le _))]
    have hσ : σ φ₁ = σ φ₂ := by rw [hci φ₁ hφ₁ hφ₁D, hcj φ₂ hφ₂ hφ₂D, hR]
    rcases hrun φ₁ φ₂ hφ₁D hφ₂D (by linarith [hφ₁.2, hφ₂.1]) (by linarith [hφ₂.2, hφ₁.1]) hσ with h | h
    · exact hchsucc i (hD.noChange_of_const ⟨hφ₁.2, by linarith [hφ₂.1]⟩ h)
    · exact hchsucc j (hD.noChange_of_const ⟨hφ₂.2, by linarith [hφ₁.1]⟩ h)
  refine ⟨n, d, c, ⟨hn0, hmono, hlast, fun _ => hadj, hv, hcone⟩, fun i j hij hcij => ?_, fun i hi => ?_⟩
  · -- positive sectors have distinct colours
    rcases lt_or_eq_of_le (hrank _ (hpfS i)) with hik | hik
    · exact Or.inl (hhorn_eq i hik).symm
    rcases lt_or_eq_of_le (hrank _ (hpfS j)) with hjk | hjk
    · exact Or.inr (hhorn_eq j hjk).symm
    exfalso
    rw [hc_run i hik, hc_run j hjk] at hcij
    have hne : (pf i).1 ≠ (pf j).1 := fun h => hij (hinj i j (Prod.ext h (hik.trans hjk.symm)))
    rcases lt_or_gt_of_ne hne with h | h
    · exact hruns i j hik hjk h hcij
    · exact hruns j i hjk hik h hcij.symm
  · -- a horn sits between distinct colours
    have hik : (pf i).2 < k := by
      rcases lt_or_eq_of_le (hrank _ (hpfS i)) with h | h
      · exact h
      · exact absurd hi (ne_of_lt (by rw [hdc]; exact (harc i h).1))
    obtain ⟨h, h1, h2⟩ := hnext_horn i hik
    obtain ⟨j, hji⟩ : ∃ j, finRotate n j = i := ⟨(finRotate n).symm i, Equiv.apply_symm_apply _ _⟩
    have hjs : (finRotate n).symm i = j := by rw [← hji, Equiv.symm_apply_apply]
    rw [hjs, hfr_succ i h]
    have hnext : (c ⟨i + 1, h⟩ ∈ Hs (pf i).1 ∧ (pf i).2 < (c ⟨i + 1, h⟩ : ℕ)) ∨ c ⟨i + 1, h⟩ = rightCol D σ (pf i).1 := by
      rcases lt_or_eq_of_le (hrank _ (hpfS ⟨i + 1, h⟩)) with h3 | h3
      · left; rw [hc_horn _ h3]; exact ⟨h1 ▸ hhornHs _ h3, h2⟩
      · right; rw [hc_run _ h3, h1]
    have hprev : (c j ∈ Hs (pf i).1 ∧ (c j : ℕ) < (pf i).2) ∨ c j = leftCol D σ (pf i).1 := by
      rcases lt_or_eq_of_le (hrank _ (hpfS j)) with h3 | h3
      · left
        obtain ⟨h', h1', h2'⟩ := hnext_horn j h3
        have hj1 : (⟨j + 1, h'⟩ : Fin n) = i := by rw [← hji, hfr_succ j h']
        rw [hj1] at h1' h2'
        rw [hc_horn _ h3]; exact ⟨h1' ▸ hhornHs _ h3, h2'⟩
      · right; rw [hc_run _ h3, harc_col j h3, hji]
    rcases hprev with ⟨hp1, hp2⟩ | hp <;> rcases hnext with ⟨hn1, hn2⟩ | hn
    · intro he; rw [he] at hp2; omega
    · rw [hn]; exact (hHs_ne _ _ hp1).2
    · rw [hp]; exact (hHs_ne _ _ hn1).1.symm
    · rw [hp, hn]; exact hch _ (hpfS i)

end ArcMap

end HadwigerNelson.Plane
