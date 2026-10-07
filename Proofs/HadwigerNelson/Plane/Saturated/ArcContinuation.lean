import Proofs.HadwigerNelson.Plane.Saturated.CurveArc

/-!
# A set that is locally one curve: its components are arcs (FS-131 wave 6, FS131-I6D; the proof of FS131-E8-GAMMA)

`plans/FS131-E8-derivation.md` § 3.2, by its kernel note ("the classification of one-manifolds is not needed"), with no
colouring and no measure (`plans/FS131-I6D-implementation.md`):

* `HasArcChart E p` — near `p` the set `E` is the image of one unit-speed curve of curvature at most `1` through `p`.
* `ArcSetting E U` — `E` lies in the open set `U` of diameter below `1`, is relatively closed in it, and has a chart
  at each of its points. (For a colouring: the essential boundary in a punctured disc of radius at most `1/2` with no
  singular point — `AeColouring.arcSetting_of_isolated`, `Plane/Saturated/FanArcs`, which with `sq9_isolatedAt`
  supplies the inhabitant of every theorem here that takes an `ArcSetting`.)
* `IsArcOf E y ψ₀ a b γ ψ` — a unit-speed curve on the whole line through `y` at `0`, with tangent angle `ψ₀` there,
  whose piece over `(a, b)` lies in `E`.
* `IsArcOf.eqOn` — two arcs through `y` with one tangent angle there agree on their common interval;
  `ArcSetting.exists_max_arc` — the longest one; `IsArcOf.left_end_notMem`, `.right_end_notMem` — its ends are not in
  `U`.
* **`ArcSetting.exists_component_arc`** — the connected component of `E` through `y` is the image of an open interval
  of length at most `π/2` under a unit-speed curve of curvature at most `1` whose two ends lie outside `U`.
-/

namespace HadwigerNelson.Plane

open Complex Set Filter Topology Metric

/-- **A chart of `E` at `p`**: in an open set about `p` the set `E` is the image of an open interval under a
unit-speed curve of curvature at most `1` through `p`. -/
def HasArcChart (E : Set ℂ) (p : ℂ) : Prop :=
  ∃ (Q : Set ℂ) (χ : ℝ → ℂ) (ψχ : ℝ → ℝ) (h : ℝ), IsOpen Q ∧ p ∈ Q ∧ 0 < h ∧
    IsUnitCurve χ ψχ (Ioo (-h) h) ∧ χ 0 = p ∧ E ∩ Q = χ '' Ioo (-h) h

/-- Spec: a set with a chart at `p` contains `p`. -/
theorem HasArcChart.mem {E : Set ℂ} {p : ℂ} (h : HasArcChart E p) : p ∈ E := by
  obtain ⟨Q, χ, ψχ, hh, -, -, hh0, -, hχ0, hEQ⟩ := h
  have : p ∈ E ∩ Q := by rw [hEQ, ← hχ0]; exact mem_image_of_mem χ ⟨by linarith, hh0⟩
  exact this.1

/-- **The setting of the continuation**: `E` lies in the open set `U` of diameter below `1`, is relatively closed in
`U`, and has a chart at each of its points. -/
structure ArcSetting (E U : Set ℂ) : Prop where
  /-- `U` is open. -/
  isOpen : IsOpen U
  /-- Two points of `U` are less than `1` apart. -/
  diam : ∀ p ∈ U, ∀ q ∈ U, dist p q < 1
  /-- `E` lies in `U`. -/
  sub : E ⊆ U
  /-- `E` is relatively closed in `U`. -/
  closed : closure E ∩ U ⊆ E
  /-- `E` has a chart at each of its points. -/
  chart : ∀ p ∈ E, HasArcChart E p

/-- **An arc of `E` through `y`** with tangent angle `ψ₀` there: a unit-speed curve of curvature at most `1` on the
whole line, at `y` at the parameter `0`, whose piece over `(a, b) ∋ 0` lies in `E`. -/
structure IsArcOf (E : Set ℂ) (y : ℂ) (ψ₀ a b : ℝ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ) : Prop where
  /-- The interval begins before `0`. -/
  neg : a < 0
  /-- The interval ends after `0`. -/
  pos : 0 < b
  /-- The curve has unit speed and curvature at most `1`. -/
  curve : IsUnitCurve γ ψ univ
  /-- The curve is at `y` at `0`. -/
  zero : γ 0 = y
  /-- Its tangent angle at `0` is `ψ₀`. -/
  angle : ψ 0 = ψ₀
  /-- Its piece over `(a, b)` lies in `E`. -/
  sub : γ '' Ioo a b ⊆ E

/-- Spec: an arc of `E` through `y` passes through a point of `E`. -/
theorem IsArcOf.mem {E : Set ℂ} {y : ℂ} {ψ₀ a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (h : IsArcOf E y ψ₀ a b γ ψ) : y ∈ E :=
  h.zero ▸ h.sub (mem_image_of_mem γ ⟨h.neg, h.pos⟩)

/-- A neighbourhood of a parameter holds a closed interval about it of half-length at most `π/4`. -/
theorem exists_Icc_subset_of_mem_nhds {O : Set ℝ} {s₀ : ℝ} (hO : O ∈ 𝓝 s₀) :
    ∃ δ > 0, δ ≤ Real.pi / 4 ∧ Icc (s₀ - δ) (s₀ + δ) ⊆ O := by
  obtain ⟨r, hr, hsub⟩ := Metric.mem_nhds_iff.1 hO
  have hπ := Real.pi_pos
  refine ⟨min (r / 2) (Real.pi / 4), lt_min (half_pos hr) (by positivity), min_le_right _ _, fun s hs => hsub ?_⟩
  have h1 := min_le_left (r / 2) (Real.pi / 4)
  rw [mem_ball, Real.dist_eq, abs_lt]
  constructor <;> linarith [hs.1, hs.2]

/-- The tangent of a curve that runs along a chart: `γ s = χ (ε s + c)` near `s` gives `γ' s = ε χ' (ε s + c)`. -/
theorem IsUnitCurve.angle_of_reparam {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (hγ : IsUnitCurve γ ψ univ) {χ : ℝ → ℂ} {ψχ : ℝ → ℝ}
    {h : ℝ} (hχ : IsUnitCurve χ ψχ (Ioo (-h) h)) {ε c a b : ℝ}
    (hre : ∀ s ∈ Icc a b, ε * s + c ∈ Ioo (-h) h ∧ γ s = χ (ε * s + c)) {s : ℝ} (hs : s ∈ Ioo a b) :
    e (ψ s) = ε • e (ψχ (ε * s + c)) := by
  have hmem := (hre s (Ioo_subset_Icc_self hs)).1
  have d1 : HasDerivAt γ (e (ψ s)) s := (hγ.hasDeriv s (mem_univ _)).hasDerivAt univ_mem
  have d2 : HasDerivAt χ (e (ψχ (ε * s + c))) (ε * s + c) :=
    (hχ.hasDeriv _ hmem).hasDerivAt (Ioo_mem_nhds hmem.1 hmem.2)
  have d3 : HasDerivAt (fun s : ℝ => ε * s + c) ε s := by
    simpa using ((hasDerivAt_id s).const_mul ε).add_const c
  have d4 : HasDerivAt (χ ∘ fun s : ℝ => ε * s + c) (ε • e (ψχ (ε * s + c))) s := d2.scomp s d3
  have heq : γ =ᶠ[𝓝 s] χ ∘ fun s : ℝ => ε * s + c := by
    filter_upwards [Icc_mem_nhds hs.1 hs.2] with t ht using (hre t ht).2
  exact d1.unique (d4.congr_of_eventuallyEq heq)

section Continuation

variable {E U : Set ℂ} {y : ℂ} {ψ₀ : ℝ}

/-- A chart of the setting has parameters at most `π/2` apart. -/
theorem ArcSetting.chart_abs_le (S : ArcSetting E U) {Q : Set ℂ} {χ : ℝ → ℂ} {ψχ : ℝ → ℝ} {h : ℝ}
    (hχ : IsUnitCurve χ ψχ (Ioo (-h) h)) (hEQ : E ∩ Q = χ '' Ioo (-h) h) :
    ∀ s ∈ Ioo (-h) h, ∀ u ∈ Ioo (-h) h, |s - u| ≤ Real.pi / 2 := by
  have hU : ∀ s ∈ Ioo (-h) h, χ s ∈ U := fun s hs => by
    have : χ s ∈ E ∩ Q := by rw [hEQ]; exact mem_image_of_mem χ hs
    exact S.sub this.1
  exact fun s hs u hu =>
    (hχ.abs_sub_lt_of_dist_lt_one ordConnected_Ioo (fun s hs u hu => S.diam _ (hU s hs) _ (hU u hu)) hs hu).le

/-- A piece of a curve inside a chart's open set is the chart, up to `±s + c`. -/
theorem ArcSetting.exists_reparam (S : ArcSetting E U) {Q : Set ℂ} {χ : ℝ → ℂ} {ψχ : ℝ → ℝ} {h : ℝ}
    (hχ : IsUnitCurve χ ψχ (Ioo (-h) h)) (hEQ : E ∩ Q = χ '' Ioo (-h) h) {γ : ℝ → ℂ} {ψ : ℝ → ℝ}
    (hγ : IsUnitCurve γ ψ univ) {a b : ℝ} (hab : a ≤ b) (hlen : b - a ≤ Real.pi / 2)
    (hsub : γ '' Icc a b ⊆ E ∩ Q) :
    ∃ ε c : ℝ, (ε = 1 ∨ ε = -1) ∧ ∀ s ∈ Icc a b, ε * s + c ∈ Ioo (-h) h ∧ γ s = χ (ε * s + c) :=
  hχ.reparam ordConnected_Ioo (S.chart_abs_le hχ hEQ) hab hlen (hγ.mono (subset_univ _)) (hEQ ▸ hsub)

/-- Two parameters of an arc's interval are less than `π/2` apart. -/
theorem IsArcOf.abs_sub_lt (S : ArcSetting E U) {a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (h : IsArcOf E y ψ₀ a b γ ψ)
    {s u : ℝ} (hs : s ∈ Ioo a b) (hu : u ∈ Ioo a b) : |s - u| < Real.pi / 2 :=
  (h.curve.mono (subset_univ (Ioo a b))).abs_sub_lt_of_dist_lt_one ordConnected_Ioo
    (fun _ hs _ hu => S.diam _ (S.sub (h.sub (mem_image_of_mem _ hs))) _ (S.sub (h.sub (mem_image_of_mem _ hu))))
    hs hu

/-- An arc's interval lies in `[-π/2, π/2]`. -/
theorem IsArcOf.bounds (S : ArcSetting E U) {a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (h : IsArcOf E y ψ₀ a b γ ψ) :
    -(Real.pi / 2) ≤ a ∧ b ≤ Real.pi / 2 := by
  have h0 : (0 : ℝ) ∈ Ioo a b := ⟨h.neg, h.pos⟩
  have hπ := Real.pi_pos
  constructor
  · by_contra hlt
    rw [not_le] at hlt
    have := h.abs_sub_lt S (s := -(Real.pi / 2)) ⟨hlt, by linarith [h.pos]⟩ h0
    rw [sub_zero, abs_neg, abs_of_pos (by positivity)] at this
    exact lt_irrefl _ this
  · by_contra hlt
    rw [not_le] at hlt
    have := h.abs_sub_lt S (s := Real.pi / 2) ⟨by linarith [h.neg], hlt⟩ h0
    rw [sub_zero, abs_of_pos (by positivity)] at this
    exact lt_irrefl _ this

/-- An arc's interval has length at most `π/2`. -/
theorem IsArcOf.length_le (S : ArcSetting E U) {a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (h : IsArcOf E y ψ₀ a b γ ψ) :
    b - a ≤ Real.pi / 2 := by
  by_contra hlt
  rw [not_le] at hlt
  have hab : a < b := h.neg.trans h.pos
  have := h.abs_sub_lt S (s := b - (b - a - Real.pi / 2) / 2) (u := a + (b - a - Real.pi / 2) / 2)
    ⟨by linarith [Real.pi_pos], by linarith⟩ ⟨by linarith, by linarith [Real.pi_pos]⟩
  rw [show b - (b - a - Real.pi / 2) / 2 - (a + (b - a - Real.pi / 2) / 2) = Real.pi / 2 by ring,
    abs_of_pos (by positivity)] at this
  exact lt_irrefl _ this

/-- **Two arcs of `E` through `y` with one tangent angle there agree on their common interval**, curve and angle. -/
theorem IsArcOf.eqOn (S : ArcSetting E U) {a₁ b₁ a₂ b₂ : ℝ} {γ₁ γ₂ : ℝ → ℂ} {ψ₁ ψ₂ : ℝ → ℝ}
    (h₁ : IsArcOf E y ψ₀ a₁ b₁ γ₁ ψ₁) (h₂ : IsArcOf E y ψ₀ a₂ b₂ γ₂ ψ₂) :
    EqOn γ₁ γ₂ (Ioo (max a₁ a₂) (min b₁ b₂)) ∧ EqOn ψ₁ ψ₂ (Ioo (max a₁ a₂) (min b₁ b₂)) := by
  set J : Set ℝ := Ioo (max a₁ a₂) (min b₁ b₂) with hJ
  have hJ1 : J ⊆ Ioo a₁ b₁ := Ioo_subset_Ioo (le_max_left _ _) (min_le_left _ _)
  have hJ2 : J ⊆ Ioo a₂ b₂ := Ioo_subset_Ioo (le_max_right _ _) (min_le_right _ _)
  have c1 : Continuous γ₁ := continuousOn_univ.1 h₁.curve.continuousOn
  have c2 : Continuous γ₂ := continuousOn_univ.1 h₂.curve.continuousOn
  have d1 : Continuous ψ₁ := continuousOn_univ.1 h₁.curve.lip.continuousOn
  have d2 : Continuous ψ₂ := continuousOn_univ.1 h₂.curve.lip.continuousOn
  set u : Set ℝ := {s | s ∈ J ∧ γ₁ s = γ₂ s ∧ e (ψ₁ s) = e (ψ₂ s)} with hu
  set v : Set ℝ := {s | γ₁ s ≠ γ₂ s} ∪ {s | e (ψ₁ s) ≠ e (ψ₂ s)} with hv
  have hvo : IsOpen v := (isOpen_ne_fun c1 c2).union (isOpen_ne_fun (continuous_e.comp d1) (continuous_e.comp d2))
  have h0J : (0 : ℝ) ∈ J := ⟨max_lt h₁.neg h₂.neg, lt_min h₁.pos h₂.pos⟩
  have huo : IsOpen u := by
    refine isOpen_iff_mem_nhds.2 fun s₀ hs₀ => ?_
    obtain ⟨hsJ, hγeq, heeq⟩ := hs₀
    have hpE : γ₁ s₀ ∈ E := h₁.sub (mem_image_of_mem _ (hJ1 hsJ))
    obtain ⟨Q, χ, ψχ, hh, hQo, hpQ, hh0, hχ, hχ0, hEQ⟩ := S.chart _ hpE
    have hinj := hχ.injOn_of_abs_le ordConnected_Ioo (S.chart_abs_le hχ hEQ)
    have hO : J ∩ γ₁ ⁻¹' Q ∩ γ₂ ⁻¹' Q ∈ 𝓝 s₀ :=
      inter_mem (inter_mem (isOpen_Ioo.mem_nhds hsJ) (c1.continuousAt.preimage_mem_nhds (hQo.mem_nhds hpQ)))
        (c2.continuousAt.preimage_mem_nhds (hQo.mem_nhds (hγeq ▸ hpQ)))
    obtain ⟨δ, hδ, hδπ, hδsub⟩ := exists_Icc_subset_of_mem_nhds hO
    have hlen : s₀ + δ - (s₀ - δ) ≤ Real.pi / 2 := by linarith
    have hab : s₀ - δ ≤ s₀ + δ := by linarith
    obtain ⟨ε₁, k₁, -, hre₁⟩ := S.exists_reparam hχ hEQ h₁.curve hab hlen (by
      rintro _ ⟨s, hs, rfl⟩
      exact ⟨h₁.sub (mem_image_of_mem _ (hJ1 (hδsub hs).1.1)), (hδsub hs).1.2⟩)
    obtain ⟨ε₂, k₂, -, hre₂⟩ := S.exists_reparam hχ hEQ h₂.curve hab hlen (by
      rintro _ ⟨s, hs, rfl⟩
      exact ⟨h₂.sub (mem_image_of_mem _ (hJ2 (hδsub hs).1.1)), (hδsub hs).2⟩)
    have hs₀I : s₀ ∈ Ioo (s₀ - δ) (s₀ + δ) := ⟨by linarith, by linarith⟩
    have hs₀c := Ioo_subset_Icc_self hs₀I
    have ht : ε₁ * s₀ + k₁ = ε₂ * s₀ + k₂ :=
      hinj (hre₁ s₀ hs₀c).1 (hre₂ s₀ hs₀c).1 (by rw [← (hre₁ s₀ hs₀c).2, ← (hre₂ s₀ hs₀c).2, hγeq])
    have T1 := h₁.curve.angle_of_reparam hχ hre₁ hs₀I
    have T2 := h₂.curve.angle_of_reparam hχ hre₂ hs₀I
    have hε : ε₁ = ε₂ := by
      rw [heeq, T2, ht] at T1
      exact (smul_left_injective ℝ (e_ne_zero _) T1).symm
    have hk : k₁ = k₂ := by rw [hε] at ht; linarith
    refine mem_of_superset (Ioo_mem_nhds hs₀I.1 hs₀I.2) fun s hs => ?_
    have hsc := Ioo_subset_Icc_self hs
    refine ⟨(hδsub hsc).1.1, ?_, ?_⟩
    · rw [(hre₁ s hsc).2, (hre₂ s hsc).2, hε, hk]
    · rw [h₁.curve.angle_of_reparam hχ hre₁ hs, h₂.curve.angle_of_reparam hχ hre₂ hs, hε, hk]
  have hJu : J ⊆ u := by
    refine isPreconnected_Ioo.subset_left_of_subset_union huo hvo ?_ (fun s hs => ?_)
      ⟨0, h0J, h0J, by rw [h₁.zero, h₂.zero], by rw [h₁.angle, h₂.angle]⟩
    · rw [Set.disjoint_left]
      rintro s ⟨-, e1, e2⟩ (hne | hne)
      · exact hne e1
      · exact hne e2
    · by_cases e1 : γ₁ s = γ₂ s
      · by_cases e2 : e (ψ₁ s) = e (ψ₂ s)
        · exact Or.inl ⟨hs, e1, e2⟩
        · exact Or.inr (Or.inr e2)
      · exact Or.inr (Or.inl e1)
  refine ⟨fun s hs => (hJu hs).2.1, fun s hs => ?_⟩
  obtain ⟨n, hn⟩ := e_eq_e_iff.1 (hJu hs).2.2
  have b1 := h₁.curve.abs_angle_sub_le (mem_univ s) (mem_univ 0)
  have b2 := h₂.curve.abs_angle_sub_le (mem_univ 0) (mem_univ s)
  rw [h₁.angle] at b1
  rw [h₂.angle] at b2
  have b3 := h₁.abs_sub_lt S (hJ1 hs) (hJ1 h0J)
  rw [abs_sub_comm 0 s] at b2
  have b4 := abs_sub_le (ψ₁ s) ψ₀ (ψ₂ s)
  have hπ := Real.pi_pos
  have b5 : |(n : ℝ) * (2 * Real.pi)| < 2 * Real.pi := by
    have : (n : ℝ) * (2 * Real.pi) = ψ₁ s - ψ₂ s := by linarith
    rw [this]; linarith
  rw [abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 * Real.pi)] at b5
  have b6 : |(n : ℝ)| < 1 := by
    by_contra hge
    rw [not_lt] at hge
    nlinarith
  have hn0 : n = 0 := by
    have : |n| < 1 := by exact_mod_cast b6
    exact Int.abs_lt_one_iff.1 this
  rw [hn, hn0]; simp

/-- **The longest arc of `E` through `y` with a given tangent angle there.** -/
theorem ArcSetting.exists_max_arc (S : ArcSetting E U) (hne : ∃ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ) :
    ∃ A B Γ Ψ, IsArcOf E y ψ₀ A B Γ Ψ ∧ ∀ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ → A ≤ a ∧ b ≤ B := by
  obtain ⟨a₀, b₀, γ₀, ψ₀', h₀⟩ := hne
  set Sa : Set ℝ := {a | ∃ b γ ψ, IsArcOf E y ψ₀ a b γ ψ} with hSa
  set Sb : Set ℝ := {b | ∃ a γ ψ, IsArcOf E y ψ₀ a b γ ψ} with hSb
  have hSa' : BddBelow Sa := ⟨-(Real.pi / 2), fun a ⟨b, γ, ψ, h⟩ => (h.bounds S).1⟩
  have hSb' : BddAbove Sb := ⟨Real.pi / 2, fun b ⟨a, γ, ψ, h⟩ => (h.bounds S).2⟩
  have hAa : ∀ {a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ}, IsArcOf E y ψ₀ a b γ ψ → sInf Sa ≤ a :=
    fun h => csInf_le hSa' ⟨_, _, _, h⟩
  have hbB : ∀ {a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ}, IsArcOf E y ψ₀ a b γ ψ → b ≤ sSup Sb :=
    fun h => le_csSup hSb' ⟨_, _, _, h⟩
  have hA0 : sInf Sa < 0 := (hAa h₀).trans_lt h₀.neg
  have hB0 : 0 < sSup Sb := h₀.pos.trans_le (hbB h₀)
  have hcov : ∀ s ∈ Ioo (sInf Sa) (sSup Sb), ∃ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ ∧ s ∈ Ioo a b := by
    intro s hs
    rcases le_or_gt 0 s with h0 | h0
    · obtain ⟨b, ⟨a, γ, ψ, h⟩, hb⟩ := exists_lt_of_lt_csSup (⟨b₀, a₀, γ₀, ψ₀', h₀⟩ : Sb.Nonempty) hs.2
      exact ⟨a, b, γ, ψ, h, h.neg.trans_le h0, hb⟩
    · obtain ⟨a, ⟨b, γ, ψ, h⟩, ha⟩ := exists_lt_of_csInf_lt (⟨a₀, b₀, γ₀, ψ₀', h₀⟩ : Sa.Nonempty) hs.1
      exact ⟨a, b, γ, ψ, h, ha, h0.trans h.pos⟩
  have hex : ∀ s : ℝ, ∃ v : ℝ, ∀ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ → s ∈ Ioo a b → ψ s = v := by
    intro s
    by_cases hs : ∃ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ ∧ s ∈ Ioo a b
    · obtain ⟨a, b, γ, ψ, h, hsab⟩ := hs
      exact ⟨ψ s, fun a' b' γ' ψ' h' hs' => (h'.eqOn S h).2 ⟨max_lt hs'.1 hsab.1, lt_min hs'.2 hsab.2⟩⟩
    · exact ⟨0, fun a b γ ψ h hsab => absurd ⟨a, b, γ, ψ, h, hsab⟩ hs⟩
  choose Ψ₀ hΨ₀ using hex
  have key : ∀ {s u : ℝ}, s ∈ Ioo (sInf Sa) (sSup Sb) → u ∈ Ioo (sInf Sa) (sSup Sb) → s ≤ u →
      |Ψ₀ s - Ψ₀ u| ≤ |s - u| := by
    intro s u hs hu hsu
    obtain ⟨a, b, γ, ψ, h, hsab⟩ := hcov s hs
    obtain ⟨a', b', γ', ψ', h', huab⟩ := hcov u hu
    rcases le_or_gt 0 s with h0 | h0
    · have hs' : s ∈ Ioo a' b' := ⟨h'.neg.trans_le h0, hsu.trans_lt huab.2⟩
      rw [← hΨ₀ s _ _ _ _ h' hs', ← hΨ₀ u _ _ _ _ h' huab]
      exact h'.curve.abs_angle_sub_le (mem_univ _) (mem_univ _)
    · rcases le_or_gt u 0 with h1 | h1
      · have hu' : u ∈ Ioo a b := ⟨hsab.1.trans_le hsu, h1.trans_lt h.pos⟩
        rw [← hΨ₀ s _ _ _ _ h hsab, ← hΨ₀ u _ _ _ _ h hu']
        exact h.curve.abs_angle_sub_le (mem_univ _) (mem_univ _)
      · rw [← hΨ₀ s _ _ _ _ h hsab, ← hΨ₀ u _ _ _ _ h' huab]
        have e1 := h.curve.abs_angle_sub_le (mem_univ s) (mem_univ 0)
        have e2 := h'.curve.abs_angle_sub_le (mem_univ 0) (mem_univ u)
        rw [h.angle, sub_zero, abs_of_neg h0] at e1
        rw [h'.angle, zero_sub, abs_neg, abs_of_pos h1] at e2
        rw [abs_of_nonpos (by linarith : s - u ≤ 0)]
        have := abs_sub_le (ψ s) ψ₀ (ψ' u)
        linarith
  have hlip : LipschitzOnWith 1 Ψ₀ (Ioo (sInf Sa) (sSup Sb)) := by
    refine LipschitzOnWith.of_dist_le_mul fun s hs u hu => ?_
    rw [NNReal.coe_one, one_mul, Real.dist_eq, Real.dist_eq]
    rcases le_total s u with h | h
    · exact key hs hu h
    · rw [abs_sub_comm, abs_sub_comm s]; exact key hu hs h
  obtain ⟨Ψ, hΨ, hΨeq⟩ := hlip.extend_real
  refine ⟨sInf Sa, sSup Sb, angleCurve y Ψ, Ψ,
    ⟨hA0, hB0, isUnitCurve_angleCurve y hΨ univ, angleCurve_zero _ _, ?_, ?_⟩, fun a b γ ψ h => ⟨hAa h, hbB h⟩⟩
  · rw [← hΨeq ⟨hA0, hB0⟩]
    exact (hΨ₀ 0 _ _ _ _ h₀ ⟨h₀.neg, h₀.pos⟩).symm.trans h₀.angle
  · rintro _ ⟨s, hs, rfl⟩
    obtain ⟨a, b, γ, ψ, h, hsab⟩ := hcov s hs
    have hsubI : Ioo a b ⊆ Ioo (sInf Sa) (sSup Sb) := Ioo_subset_Ioo (hAa h) (hbB h)
    have heq : EqOn ψ Ψ (Ioo a b) := fun t ht => (hΨ₀ t _ _ _ _ h ht).trans (hΨeq (hsubI ht))
    have h1 := (h.curve.mono (subset_univ (Ioo a b))).eqOn_angleCurve hΨ heq ⟨h.neg, h.pos⟩ hsab
    rw [h.zero] at h1
    rw [← h1]
    exact h.sub (mem_image_of_mem _ hsab)

/-- **The left end of the longest arc is not in `U`**: there it would be a point of `E`, and its chart would
lengthen the arc. -/
theorem IsArcOf.left_end_notMem (S : ArcSetting E U) {A B : ℝ} {Γ : ℝ → ℂ} {Ψ : ℝ → ℝ}
    (h : IsArcOf E y ψ₀ A B Γ Ψ) (hmax : ∀ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ → A ≤ a) : Γ A ∉ U := by
  intro hAU
  have hΓc : Continuous Γ := continuousOn_univ.1 h.curve.continuousOn
  have hΨc : Continuous Ψ := continuousOn_univ.1 h.curve.lip.continuousOn
  have hAB : A < B := h.neg.trans h.pos
  have hpE : Γ A ∈ E := by
    refine S.closed ⟨?_, hAU⟩
    have hA : A ∈ closure (Ioo A B) := by rw [closure_Ioo hAB.ne]; exact left_mem_Icc.2 hAB.le
    exact closure_mono h.sub (mem_closure_image hΓc.continuousAt hA)
  obtain ⟨Q, χ, ψχ, hh, hQo, hpQ, hh0, hχ, hχ0, hEQ⟩ := S.chart _ hpE
  have hinj := hχ.injOn_of_abs_le ordConnected_Ioo (S.chart_abs_le hχ hEQ)
  have hO : Iio (0 : ℝ) ∩ Γ ⁻¹' Q ∈ 𝓝 A :=
    inter_mem (isOpen_Iio.mem_nhds h.neg) (hΓc.continuousAt.preimage_mem_nhds (hQo.mem_nhds hpQ))
  obtain ⟨δ, hδ, hδπ, hδsub⟩ := exists_Icc_subset_of_mem_nhds hO
  have hπ := Real.pi_pos
  have hδ0 : A + δ < 0 := (hδsub ⟨by linarith, le_rfl⟩).1
  have hsub : Γ '' Icc A (A + δ) ⊆ E ∩ Q := by
    rintro _ ⟨s, hs, rfl⟩
    have hsO := hδsub ⟨by linarith [hs.1], hs.2⟩
    refine ⟨?_, hsO.2⟩
    rcases hs.1.eq_or_lt with rfl | hlt
    · exact hpE
    · exact h.sub (mem_image_of_mem _ ⟨hlt, (hsO.1 : s < 0).trans h.pos⟩)
  obtain ⟨ε, c, hε, hre⟩ := S.exists_reparam hχ hEQ h.curve (by linarith : A ≤ A + δ) (by linarith) hsub
  have hA_mem : A ∈ Icc A (A + δ) := ⟨le_rfl, by linarith⟩
  have h0mem : (0 : ℝ) ∈ Ioo (-hh) hh := ⟨by linarith, hh0⟩
  have hc0 : ε * A + c = 0 := hinj (hre A hA_mem).1 h0mem (by rw [← (hre A hA_mem).2, hχ0])
  have hT : ∀ s ∈ Ioo A (A + δ), e (Ψ s) = ε • e (ψχ (ε * s + c)) := fun s hs =>
    h.curve.angle_of_reparam hχ hre hs
  have hTA : e (Ψ A) = ε • e (ψχ 0) := by
    have l1 : Tendsto (fun s => e (Ψ s)) (𝓝[>] A) (𝓝 (e (Ψ A))) :=
      ((continuous_e.comp hΨc).tendsto A).mono_left nhdsWithin_le_nhds
    have l2 : Tendsto (fun s => ε • e (ψχ (ε * s + c))) (𝓝[>] A) (𝓝 (ε • e (ψχ 0))) := by
      have hψc : ContinuousAt ψχ 0 := hχ.lip.continuousOn.continuousAt (Ioo_mem_nhds h0mem.1 h0mem.2)
      have haff : Tendsto (fun s : ℝ => ε * s + c) (𝓝 A) (𝓝 0) := by
        have h1 : Continuous fun s : ℝ => ε * s + c := by fun_prop
        have h2 := h1.tendsto A
        rwa [hc0] at h2
      exact (((continuous_e.continuousAt.comp hψc).tendsto.comp haff).const_smul ε).mono_left nhdsWithin_le_nhds
    refine tendsto_nhds_unique (l1.congr' ?_) l2
    filter_upwards [Ioo_mem_nhdsGT (by linarith : A < A + δ)] with s hs using hT s hs
  have hκ : e (Ψ A - ψχ 0) = (ε : ℂ) := by
    rw [e_sub_eq, hTA, smul_mul_assoc, e_mul_conj_e, Complex.real_smul, mul_one]
  have hpar : ∀ s : ℝ, ε * s + c = ε * (s - A) := fun s => by linear_combination hc0
  have habs : ∀ s : ℝ, |ε * s + c| = |s - A| := fun s => by
    rw [hpar, abs_mul]
    rcases hε with rfl | rfl <;> simp
  have hin : ∀ s : ℝ, A - hh < s → s ≤ A → ε * s + c ∈ Ioo (-hh) hh := fun s h1 h2 => by
    rw [mem_Ioo, ← abs_lt, habs, abs_of_nonpos (by linarith)]; linarith
  -- the new angle: the chart's before `A`, the arc's from `A` on
  set θ' : ℝ → ℝ := fun s => if A ≤ s then Ψ s else ψχ (ε * s + c) + (Ψ A - ψχ 0) with hθ'
  have key : ∀ {s u : ℝ}, s ∈ Ioo (A - hh) B → u ∈ Ioo (A - hh) B → s ≤ u → |θ' s - θ' u| ≤ |s - u| := by
    intro s u hs hu hsu
    by_cases h1 : A ≤ s
    · have h2 : A ≤ u := h1.trans hsu
      simp only [hθ', if_pos h1, if_pos h2]
      exact h.curve.abs_angle_sub_le (mem_univ _) (mem_univ _)
    · rw [not_le] at h1
      by_cases h2 : A ≤ u
      · simp only [hθ', if_neg (not_le.2 h1), if_pos h2]
        have e1 := hχ.abs_angle_sub_le (hin s hs.1 h1.le) h0mem
        rw [sub_zero, habs, abs_of_neg (by linarith : s - A < 0)] at e1
        have e2 := h.curve.abs_angle_sub_le (mem_univ A) (mem_univ u)
        rw [abs_of_nonpos (by linarith : A - u ≤ 0)] at e2
        rw [abs_of_nonpos (by linarith : s - u ≤ 0)]
        have e3 := abs_sub_le (ψχ (ε * s + c) + (Ψ A - ψχ 0)) (Ψ A) (Ψ u)
        rw [show ψχ (ε * s + c) + (Ψ A - ψχ 0) - Ψ A = ψχ (ε * s + c) - ψχ 0 by ring] at e3
        linarith
      · rw [not_le] at h2
        simp only [hθ', if_neg (not_le.2 h1), if_neg (not_le.2 h2)]
        have e1 := hχ.abs_angle_sub_le (hin s hs.1 h1.le) (hin u hu.1 h2.le)
        rw [show ε * s + c - (ε * u + c) = (ε * s + c) - (ε * u + c) by ring] at e1
        have e2 : |ε * s + c - (ε * u + c)| = |s - u| := by
          rw [show ε * s + c - (ε * u + c) = ε * (s - u) by ring, abs_mul]
          rcases hε with rfl | rfl <;> simp
        rw [e2] at e1
        rw [show ψχ (ε * s + c) + (Ψ A - ψχ 0) - (ψχ (ε * u + c) + (Ψ A - ψχ 0)) =
          ψχ (ε * s + c) - ψχ (ε * u + c) by ring]
        exact e1
  have hlip : LipschitzOnWith 1 θ' (Ioo (A - hh) B) := by
    refine LipschitzOnWith.of_dist_le_mul fun s hs u hu => ?_
    rw [NNReal.coe_one, one_mul, Real.dist_eq, Real.dist_eq]
    rcases le_total s u with h1 | h1
    · exact key hs hu h1
    · rw [abs_sub_comm, abs_sub_comm s]; exact key hu hs h1
  obtain ⟨θ, hθ, hθeq⟩ := hlip.extend_real
  have hθAB : EqOn Ψ θ (Ioo A B) := fun t ht => by
    rw [← hθeq ⟨by linarith [ht.1], ht.2⟩]
    simp only [hθ', if_pos ht.1.le]
  have hΓeq := (h.curve.mono (subset_univ (Ioo A B))).eqOn_angleCurve hθ hθAB ⟨h.neg, h.pos⟩
  rw [h.zero] at hΓeq
  have hmemχ : ∀ s ∈ Ioo (A - hh) (A + δ), ε * s + c ∈ Ioo (-hh) hh := fun s hs => by
    rcases le_or_gt s A with h1 | h1
    · exact hin s hs.1 h1
    · exact (hre s ⟨h1.le, hs.2.le⟩).1
  have hχeq : EqOn (angleCurve y θ) (fun s => χ (ε * s + c)) (Ioo (A - hh) (A + δ)) := by
    have dχ : ∀ s ∈ Ioo (A - hh) (A + δ), HasDerivAt (fun s : ℝ => χ (ε * s + c)) (ε • e (ψχ (ε * s + c))) s := by
      intro s hs
      have hm := hmemχ s hs
      have d2 : HasDerivAt χ (e (ψχ (ε * s + c))) (ε * s + c) :=
        (hχ.hasDeriv _ hm).hasDerivAt (Ioo_mem_nhds hm.1 hm.2)
      have d3 : HasDerivAt (fun s : ℝ => ε * s + c) ε s := by
        simpa using ((hasDerivAt_id s).const_mul ε).add_const c
      exact d2.scomp s d3
    have hx₀ : A + δ / 2 ∈ Ioo (A - hh) (A + δ) := ⟨by linarith, by linarith⟩
    refine isOpen_Ioo.eqOn_of_deriv_eq isPreconnected_Ioo
      (fun s _ => (hasDerivAt_angleCurve y hθ s).differentiableAt.differentiableWithinAt)
      (fun s hs => (dχ s hs).differentiableAt.differentiableWithinAt) (fun s hs => ?_) hx₀ ?_
    · rw [(hasDerivAt_angleCurve y hθ s).deriv, (dχ s hs).deriv, ← hθeq ⟨hs.1, by linarith [hs.2, h.pos]⟩]
      by_cases h1 : A ≤ s
      · simp only [hθ', if_pos h1]
        rcases h1.eq_or_lt with rfl | h2
        · rw [hTA, hc0]
        · exact hT s ⟨h2, hs.2⟩
      · simp only [hθ', if_neg h1]
        rw [e_add, hκ, Complex.real_smul, mul_comm]
    · rw [← hΓeq ⟨by linarith, by linarith [h.pos]⟩]
      exact (hre _ ⟨by linarith, by linarith⟩).2
  have hnew : IsArcOf E y ψ₀ (A - hh) B (angleCurve y θ) θ := by
    refine ⟨by linarith [h.neg], h.pos, isUnitCurve_angleCurve y hθ univ, angleCurve_zero _ _, ?_, ?_⟩
    · rw [← hθeq ⟨by linarith [h.neg], h.pos⟩]
      simp only [hθ', if_pos h.neg.le]
      exact h.angle
    · rintro _ ⟨s, hs, rfl⟩
      rcases lt_or_ge s (A + δ) with h1 | h1
      · rw [hχeq ⟨hs.1, h1⟩]
        have : χ (ε * s + c) ∈ E ∩ Q := by rw [hEQ]; exact mem_image_of_mem χ (hmemχ s ⟨hs.1, h1⟩)
        exact this.1
      · rw [← hΓeq ⟨by linarith, hs.2⟩]
        exact h.sub (mem_image_of_mem _ ⟨by linarith, hs.2⟩)
  have := hmax _ _ _ _ hnew
  linarith

/-- An arc run backward is an arc, with the opposite tangent angle (`e κ = -1`). -/
theorem IsArcOf.reverse {a b : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ} (h : IsArcOf E y ψ₀ a b γ ψ) {κ : ℝ} (hκ : e κ = -1) :
    IsArcOf E y (ψ₀ + κ) (-b) (-a) (fun s => γ (-1 * s + 0)) (fun s => ψ (-1 * s + 0) + κ) := by
  refine ⟨by linarith [h.pos], by linarith [h.neg], ?_, by simp [h.zero], by simp [h.angle], ?_⟩
  · exact (h.curve.affine (Or.inr rfl) 0 κ (by rw [hκ]; simp)).mono fun s _ => mem_univ _
  · rintro _ ⟨s, hs, rfl⟩
    exact h.sub ⟨-1 * s + 0, ⟨by linarith [hs.2], by linarith [hs.1]⟩, rfl⟩

/-- **The right end of the longest arc is not in `U`.** -/
theorem IsArcOf.right_end_notMem (S : ArcSetting E U) {A B : ℝ} {Γ : ℝ → ℂ} {Ψ : ℝ → ℝ}
    (h : IsArcOf E y ψ₀ A B Γ Ψ) (hmax : ∀ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ → b ≤ B) : Γ B ∉ U := by
  have hκ : e Real.pi = -1 := by rw [e_eq]; simp
  have hκ' : e (-Real.pi) = -1 := by rw [e_neg]; simp
  have h1 := (h.reverse hκ).left_end_notMem S fun a b γ ψ h' => by
    have h'' := h'.reverse hκ'
    rw [show ψ₀ + Real.pi + -Real.pi = ψ₀ by ring] at h''
    have := hmax _ _ _ _ h''
    linarith
  simpa using h1

/-- Every point of `E` lies on an arc of `E`. -/
theorem ArcSetting.exists_arc (S : ArcSetting E U) (hy : y ∈ E) : ∃ ψ₀ a b γ ψ, IsArcOf E y ψ₀ a b γ ψ := by
  obtain ⟨Q, χ, ψχ, hh, hQo, hpQ, hh0, hχ, hχ0, hEQ⟩ := S.chart y hy
  obtain ⟨θ, hθ, hθeq⟩ := hχ.lip.extend_real
  have h0 : (0 : ℝ) ∈ Ioo (-hh) hh := ⟨by linarith, hh0⟩
  have heq := hχ.eqOn_angleCurve hθ hθeq h0
  rw [hχ0] at heq
  refine ⟨θ 0, -hh, hh, angleCurve y θ, θ, by linarith, hh0, isUnitCurve_angleCurve y hθ univ,
    angleCurve_zero _ _, rfl, ?_⟩
  rintro _ ⟨s, hs, rfl⟩
  rw [← heq hs]
  have : χ s ∈ E ∩ Q := by rw [hEQ]; exact mem_image_of_mem _ hs
  exact this.1

/-- **The component of `E` through `y` is an arc** (FS131-E8-GAMMA without the colouring): the image of an open
interval `(A, B) ∋ 0` of length at most `π/2` under a unit-speed curve of curvature at most `1` on the whole line, at
`y` at `0`, whose two ends are not in `U`. -/
theorem ArcSetting.exists_component_arc (S : ArcSetting E U) (hy : y ∈ E) :
    ∃ (A B : ℝ) (Γ : ℝ → ℂ) (Ψ : ℝ → ℝ), A < 0 ∧ 0 < B ∧ B - A ≤ Real.pi / 2 ∧ IsUnitCurve Γ Ψ univ ∧ Γ 0 = y ∧
      connectedComponentIn E y = Γ '' Ioo A B ∧ Γ A ∉ U ∧ Γ B ∉ U := by
  obtain ⟨ψ₀, hne⟩ := S.exists_arc hy
  obtain ⟨A, B, Γ, Ψ, harc, hmax⟩ := S.exists_max_arc hne
  have hendA := harc.left_end_notMem S fun a b γ ψ h => (hmax a b γ ψ h).1
  have hendB := harc.right_end_notMem S fun a b γ ψ h => (hmax a b γ ψ h).2
  refine ⟨A, B, Γ, Ψ, harc.neg, harc.pos, harc.length_le S, harc.curve, harc.zero, ?_, hendA, hendB⟩
  have hΓc : Continuous Γ := continuousOn_univ.1 harc.curve.continuousOn
  have hπ := Real.pi_pos
  -- the arc is open in `E`
  have hloc : ∀ s₀ ∈ Ioo A B, ∃ W : Set ℂ, IsOpen W ∧ Γ s₀ ∈ W ∧ E ∩ W ⊆ Γ '' Ioo A B := by
    intro s₀ hs₀
    have hpE : Γ s₀ ∈ E := harc.sub (mem_image_of_mem _ hs₀)
    obtain ⟨Q, χ, ψχ, hh, hQo, hpQ, hh0, hχ, hχ0, hEQ⟩ := S.chart _ hpE
    have hlenχ := S.chart_abs_le hχ hEQ
    have hinj := hχ.injOn_of_abs_le ordConnected_Ioo hlenχ
    have h0mem : (0 : ℝ) ∈ Ioo (-hh) hh := ⟨by linarith, hh0⟩
    have hO : Ioo A B ∩ Γ ⁻¹' Q ∈ 𝓝 s₀ :=
      inter_mem (isOpen_Ioo.mem_nhds hs₀) (hΓc.continuousAt.preimage_mem_nhds (hQo.mem_nhds hpQ))
    obtain ⟨δ, hδ, hδπ, hδsub⟩ := exists_Icc_subset_of_mem_nhds hO
    obtain ⟨ε, c, hε, hre⟩ := S.exists_reparam hχ hEQ harc.curve (by linarith : s₀ - δ ≤ s₀ + δ) (by linarith)
      (by
        rintro _ ⟨s, hs, rfl⟩
        exact ⟨harc.sub (mem_image_of_mem _ (hδsub hs).1), (hδsub hs).2⟩)
    have hs₀c : s₀ ∈ Icc (s₀ - δ) (s₀ + δ) := ⟨by linarith, by linarith⟩
    have hc0 : ε * s₀ + c = 0 := hinj (hre s₀ hs₀c).1 h0mem (by rw [← (hre s₀ hs₀c).2, hχ0])
    have hε2 : ε * ε = 1 := by rcases hε with rfl | rfl <;> norm_num
    have hsin : 0 < Real.sin δ := Real.sin_pos_of_pos_of_lt_pi hδ (by linarith)
    refine ⟨Q ∩ ball (Γ s₀) (Real.sin δ), hQo.inter isOpen_ball, ⟨hpQ, mem_ball_self hsin⟩, ?_⟩
    rintro q ⟨hqE, hqQ, hqb⟩
    have hq : q ∈ χ '' Ioo (-hh) hh := by rw [← hEQ]; exact ⟨hqE, hqQ⟩
    obtain ⟨t, ht, rfl⟩ := hq
    have h1 := hχ.sin_abs_le_dist ordConnected_Ioo h0mem ht (hlenχ t ht 0 h0mem)
    rw [sub_zero, hχ0] at h1
    rw [mem_ball] at hqb
    have htδ : |t| < δ := by
      by_contra hge
      rw [not_lt] at hge
      have h2 := hlenχ t ht 0 h0mem
      rw [sub_zero] at h2
      have := Real.sin_le_sin_of_le_of_le_pi_div_two (by linarith) h2 hge
      linarith
    have hεt : |ε * t| = |t| := by rw [abs_mul]; rcases hε with rfl | rfl <;> simp
    rw [← hεt, abs_lt] at htδ
    have hsmem : s₀ + ε * t ∈ Icc (s₀ - δ) (s₀ + δ) := ⟨by linarith [htδ.1], by linarith [htδ.2]⟩
    have hpar : ε * (s₀ + ε * t) + c = t := by linear_combination t * hε2 + hc0
    refine ⟨s₀ + ε * t, (hδsub hsmem).1, ?_⟩
    rw [(hre _ hsmem).2, hpar]
  choose! W hWo hWmem hWsub using hloc
  have hVE : Γ '' Ioo A B ⊆ E := harc.sub
  apply subset_antisymm
  · intro q hq
    have hKE : connectedComponentIn E y ⊆ E := connectedComponentIn_subset E y
    have hpre : IsPreconnected (connectedComponentIn E y) := isPreconnected_connectedComponentIn
    by_contra hqV
    set u : Set ℂ := ⋃ s ∈ Ioo A B, W s with hu
    set v : Set ℂ := (Γ '' Icc A B)ᶜ with hv
    have huo : IsOpen u := isOpen_biUnion fun s hs => hWo s hs
    have hvo : IsOpen v := (isCompact_Icc.image hΓc).isClosed.isOpen_compl
    have hVu : Γ '' Ioo A B ⊆ u := by
      rintro _ ⟨s, hs, rfl⟩
      exact mem_biUnion hs (hWmem s hs)
    have huV : E ∩ u ⊆ Γ '' Ioo A B := by
      rintro p ⟨hpE, hpu⟩
      obtain ⟨s, hs, hps⟩ := mem_iUnion₂.1 hpu
      exact hWsub s hs ⟨hpE, hps⟩
    have hIcc : ∀ p ∈ E, p ∈ Γ '' Icc A B → p ∈ Γ '' Ioo A B := by
      rintro p hpE ⟨s, hs, rfl⟩
      have hsA : s ≠ A := fun h => hendA (h ▸ S.sub hpE)
      have hsB : s ≠ B := fun h => hendB (h ▸ S.sub hpE)
      exact ⟨s, ⟨lt_of_le_of_ne hs.1 (Ne.symm hsA), lt_of_le_of_ne hs.2 hsB⟩, rfl⟩
    have hcover : connectedComponentIn E y ⊆ u ∪ v := by
      intro p hp
      by_cases hpV : p ∈ Γ '' Icc A B
      · exact Or.inl (hVu (hIcc p (hKE hp) hpV))
      · exact Or.inr hpV
    have hy' : y ∈ connectedComponentIn E y := mem_connectedComponentIn hy
    obtain ⟨p, hpK, hpu, hpv⟩ := hpre u v huo hvo hcover
      ⟨y, hy', hVu ⟨0, ⟨harc.neg, harc.pos⟩, harc.zero⟩⟩ ⟨q, hq, fun hqI => hqV (hIcc q (hKE hq) hqI)⟩
    exact hpv (image_mono Ioo_subset_Icc_self (huV ⟨hKE hpK, hpu⟩))
  · exact (isPreconnected_Ioo.image Γ hΓc.continuousOn).subset_connectedComponentIn
      ⟨0, ⟨harc.neg, harc.pos⟩, harc.zero⟩ hVE

end Continuation

end HadwigerNelson.Plane
