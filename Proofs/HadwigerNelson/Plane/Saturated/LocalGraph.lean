import Proofs.HadwigerNelson.Plane.Saturated.Pinch
import Proofs.HadwigerNelson.Plane.Saturated.Curve
import Proofs.HadwigerNelson.Plane.Saturated.Fan

/-!
# The local structure off the singular set (FS-131 wave 6: FS131-E8-LOCAL, FS131-E8-DELTA)

`plans/FS131-E8-derivation.md` §§ 3.1, 3.5 ([hand], one mind, until this module lands), at the class each argument
reads (`plans/FS131-w6-kernel-plan.md` § 11):

* **FS131-E8-DELTA** — `ae_one_colour_of_isConnected`: a connected open set meeting no essential boundary and no cusp
  is almost everywhere of one colour.
* `closure_essBdry_subset` — the closure of the essential boundary lies in the essential boundary and the cusps
  (§ 3.1 (0); FS121-V5-OFF; no saturation); `notMem_essBdry_of_mem_densitySet`. With `local_graph` these are
  FS121-V5-LOC (i), (ii).
* `IsInterfaceChart A B N y Q γ ψ h` — in the open set `Q ∋ y` the common essential boundary of `A`, `B` is the
  injective unit-speed curve `γ` of curvature at most `1` through `y`, with the two tangent unit discs at each of its
  points (normal `i e(ψ s)` into `B`) and one set on each side.
* **FS131-E8-LOCAL** — `local_graph`: for two sets on a two-colour open set `N` and an open `U ⊆ N` with no cusp of
  either, saturated at its essential boundary points, every essential boundary point of `U` has a chart inside `U`.
  This is **FS111-M-C11 (ii)** with the hypothesis "no cusp in the neighbourhood" (the deriver's erratum), and
  FS111-W-NOBEND (no corner: `γ` is `C¹`; curvature at most `1`: `ψ` is 1-Lipschitz). `AeColouring.local_graph` is
  its form at an essential boundary point of a colouring off `Σ` — FS121-V5-LOC (ii).

**The singular set is not read by `local_graph`**: its hypotheses are `TwoColourOn A B N` and "no cusp in `U`", so the
frozen centred-ball `Σ` serves (ruling, inventory item 495).

**Inhabitant.** `sq9` at `sqEdgePt`, `N = U = B(sqEdgePt, 1/8)`: `sq9_twoColourNhd`, saturated by
`sq9_tight_saturated`; that no cusp lies in the ball is owed with `local_graph`'s proof (the model of
`sq9_not_isCuspAt_near_vertex`, `Plane/Saturated/FanExamples`); the chart is the segment `s ↦ sqEdgePt + i s`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## FS131-E8-DELTA and the closure of the essential boundary -/

/-- A density point of a class of a colouring is no essential boundary point of the colouring. -/
theorem AeColouring.notMem_essBdry_of_mem_densitySet (c : AeColouring k) {j : Fin k} {x : ℂ}
    (hx : x ∈ densitySet (c.cls j)) : x ∉ c.essBdry := by
  intro hmem
  obtain ⟨i, hi⟩ := mem_iUnion.1 hmem
  by_cases hij : i = j
  · subst hij
    exact hi.2 hx
  · exact notMem_essClosure_of_mem_densitySet (c.measurableSet_cls j) (c.pairwise_disjoint_cls (Ne.symm hij)) hx hi.1

/-- Off the essential boundary and the cusps, a point is a density point of one class and outside the support of
every other (FS131-E8 § 3.5's first three sentences). -/
theorem AeColouring.exists_densitySet_of_notMem (c : AeColouring k) {x : ℂ} (hb : x ∉ c.essBdry)
    (hcusp : x ∉ cuspSet c.cls) : ∃ j, x ∈ densitySet (c.cls j) ∧ ∀ i, i ≠ j → x ∉ essSupport (c.cls i) := by
  obtain ⟨j, hj⟩ := exists_mem_essClosure_of_cover c.measurableSet_cls c.pairwise_disjoint_cls c.iUnion_cls x
  have hjd : x ∈ densitySet (c.cls j) := by
    by_contra hnd
    exact hb (mem_iUnion.2 ⟨j, hj, hnd⟩)
  refine ⟨j, hjd, fun i hij hsupp => hcusp ⟨i, hsupp, ?_⟩⟩
  exact notMem_essClosure_of_mem_densitySet (c.measurableSet_cls j) (c.pairwise_disjoint_cls (Ne.symm hij)) hjd

/-- The points outside the support of every class but `j` form an open set. -/
theorem AeColouring.isOpen_setOf_forall_notMem_essSupport (c : AeColouring k) (j : Fin k) :
    IsOpen {y : ℂ | ∀ i, i ≠ j → y ∉ essSupport (c.cls i)} := by
  have h : {y : ℂ | ∀ i, i ≠ j → y ∉ essSupport (c.cls i)} = ⋂ i, ⋂ (_ : i ≠ j), (essSupport (c.cls i))ᶜ := by
    ext y; simp
  rw [h]
  exact isOpen_iInter_of_finite fun i => isOpen_iInter_of_finite fun _ => (isClosed_essSupport _).isOpen_compl

/-- A point outside the support of every class but `j` is a density point of the class `j`: that class alone has
positive upper density there, and an essential boundary point of it would see a second class. -/
theorem AeColouring.mem_densitySet_of_forall_notMem_essSupport (c : AeColouring k) {j : Fin k} {y : ℂ}
    (h : ∀ i, i ≠ j → y ∉ essSupport (c.cls i)) : y ∈ densitySet (c.cls j) := by
  obtain ⟨b, hb⟩ := exists_mem_essClosure_of_cover c.measurableSet_cls c.pairwise_disjoint_cls c.iUnion_cls y
  have hbj : b = j := by
    by_contra hne
    exact h b hne (essClosure_subset_essSupport _ hb)
  subst hbj
  by_contra hnd
  obtain ⟨b', hb'ne, hb'⟩ := exists_ne_mem_essClosure c.measurableSet_cls c.pairwise_disjoint_cls c.iUnion_cls
    (show y ∈ essBoundary (c.cls b) from ⟨hb, hnd⟩)
  exact h b' hb'ne (essClosure_subset_essSupport _ hb')

/-- **FS131-E8-DELTA.** In a measurable colouring, a connected open set that meets the essential boundary of no class
and holds no cusp of any class is almost everywhere of one colour. Unit pairs and saturation are not read. -/
theorem AeColouring.ae_one_colour_of_isConnected (c : AeColouring k) {W : Set ℂ} (hW : IsOpen W)
    (hWc : IsConnected W) (hb : Disjoint W c.essBdry) (hcusp : Disjoint W (cuspSet c.cls)) :
    ∃ j, (W : Set ℂ) ≤ᵐ[volume] c.cls j := by
  -- `hW` is not read: the sets `{y | ∀ i ≠ j, y ∉ supp (cls i)}` are open in the plane, pairwise disjoint, and cover
  -- `W`, so a connected `W`, open or not, lies in one of them (FS131-I6C, a generalization; the statement is fixed).
  have _ := hW
  obtain ⟨x₀, hx₀⟩ := hWc.nonempty
  obtain ⟨j, -, hj⟩ := c.exists_densitySet_of_notMem (disjoint_left.1 hb hx₀) (disjoint_left.1 hcusp hx₀)
  refine ⟨j, ?_⟩
  have hsub : W ⊆ {y : ℂ | ∀ i, i ≠ j → y ∉ essSupport (c.cls i)} := by
    refine IsPreconnected.subset_left_of_subset_union (c.isOpen_setOf_forall_notMem_essSupport j)
      (isOpen_iUnion fun j' => isOpen_iUnion fun (_ : j' ≠ j) => c.isOpen_setOf_forall_notMem_essSupport j')
      ?_ ?_ ⟨x₀, hx₀, hj⟩ hWc.isPreconnected
    · rw [disjoint_left]
      intro y hy hy'
      simp only [mem_iUnion] at hy'
      obtain ⟨j', hj'j, hy'⟩ := hy'
      exact densitySet_disjoint (c.measurableSet_cls j) (c.pairwise_disjoint_cls (Ne.symm hj'j))
        (c.mem_densitySet_of_forall_notMem_essSupport hy) (c.mem_densitySet_of_forall_notMem_essSupport hy')
    · intro y hy
      obtain ⟨j', -, hj'⟩ := c.exists_densitySet_of_notMem (disjoint_left.1 hb hy) (disjoint_left.1 hcusp hy)
      by_cases hjj : j' = j
      · subst hjj; exact Or.inl hj'
      · exact Or.inr (mem_iUnion.2 ⟨j', mem_iUnion.2 ⟨hjj, hj'⟩⟩)
  rw [ae_le_set]
  exact measure_mono_null
    (sdiff_subset_sdiff_left fun y hy => c.mem_densitySet_of_forall_notMem_essSupport (hsub hy))
    (volume_densitySet_diff (c.measurableSet_cls j))

/-- **The closure of the essential boundary lies in the essential boundary and the cusps** (FS131-E8 § 3.1 (0);
FS121-V5-OFF; FS121-V5-LOC (i): `cl 𝓘 ∖ Σ ⊆ 𝓘`, since the cusps lie in `Σ`). No saturation. -/
theorem AeColouring.closure_essBdry_subset (c : AeColouring k) : closure c.essBdry ⊆ c.essBdry ∪ cuspSet c.cls := by
  intro x hx
  by_contra hnot
  rw [mem_union, not_or] at hnot
  obtain ⟨j, -, hj⟩ := c.exists_densitySet_of_notMem hnot.1 hnot.2
  obtain ⟨y, hy, hyb⟩ := mem_closure_iff.1 hx _ (c.isOpen_setOf_forall_notMem_essSupport j) hj
  exact c.notMem_essBdry_of_mem_densitySet (c.mem_densitySet_of_forall_notMem_essSupport hy) hyb

/-! ## The chart, and FS131-E8-LOCAL -/

/-- **A chart of the common essential boundary of `A` and `B` at `y`**: in the open set `Q ∋ y`, `Q ⊆ N`, the
essential boundary of `A` is the image of the injective unit-speed curve `γ` of curvature at most `1` on `(−h, h)`,
`γ 0 = y`; every point of it carries the two tangent unit discs with normal `i e(ψ s)` into `B`; and `Q` off the
curve is two connected open sets, one almost everywhere in `A`, the other in `B`. -/
structure IsInterfaceChart (A B N : Set ℂ) (y : ℂ) (Q : Set ℂ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ) (h : ℝ) : Prop where
  /-- The half-length is positive. -/
  pos : 0 < h
  /-- The chart's domain is open. -/
  isOpen : IsOpen Q
  /-- The point lies in it. -/
  mem : y ∈ Q
  /-- It lies in the two-colour open set. -/
  subset : Q ⊆ N
  /-- The curve has unit speed and curvature at most `1`. -/
  curve : IsUnitCurve γ ψ (Ioo (-h) h)
  /-- The curve passes through `y` at `0`. -/
  zero : γ 0 = y
  /-- The curve does not meet itself. -/
  injOn : InjOn γ (Ioo (-h) h)
  /-- In `Q` the essential boundary of `A` is the curve. -/
  bdry : essBoundary A ∩ Q = γ '' Ioo (-h) h
  /-- The two tangent unit discs at every point of the curve, the normal `i e(ψ s)` into `B`. -/
  discs : ∀ s ∈ Ioo (-h) h, HasTwoDiscsAt A B N (γ s) (I * e (ψ s))
  /-- Off the curve, `Q` is two connected open sets, one almost everywhere in `A` and one in `B`. -/
  sides : ∃ Qa Qb : Set ℂ, IsOpen Qa ∧ IsOpen Qb ∧ IsConnected Qa ∧ IsConnected Qb ∧
    Q \ γ '' Ioo (-h) h = Qa ∪ Qb ∧ (Qa : Set ℂ) ≤ᵐ[volume] A ∧ (Qb : Set ℂ) ≤ᵐ[volume] B

/-! ### Children of `local_graph` (FS131-I6C): two sets on a two-colour open set

`plans/FS131-E8-derivation.md` § 3.1 (1)–(3) and the erratum under FS131-E8-LOCAL, at the class each step reads. -/

/-- **An open subset of a two-colour open set is not almost everywhere in both sets**: a point of `N` lies in no two
open sets, one almost everywhere in `A` within `N` and one in `B`. (This is where `TwoColourOn.disj` is read.) -/
theorem TwoColourOn.false_of_mem_inter {A B N : Set ℂ} (h : TwoColourOn A B N) {O₁ O₂ : Set ℂ} (hO₁ : IsOpen O₁)
    (hO₂ : IsOpen O₂) (h1 : (O₁ ∩ N : Set ℂ) ≤ᵐ[volume] A) (h2 : (O₂ ∩ N : Set ℂ) ≤ᵐ[volume] B) {p : ℂ}
    (hpN : p ∈ N) (hp1 : p ∈ O₁) (hp2 : p ∈ O₂) : False := by
  have hpos : 0 < volume (O₁ ∩ O₂ ∩ N) :=
    ((hO₁.inter hO₂).inter h.isOpen).measure_pos volume ⟨p, ⟨hp1, hp2⟩, hpN⟩
  have hle : (O₁ ∩ O₂ ∩ N : Set ℂ) ≤ᵐ[volume] (A ∩ B ∩ N : Set ℂ) := by
    filter_upwards [h1, h2] with z hzA hzB hz
    exact ⟨⟨hzA ⟨hz.1.1, hz.2⟩, hzB ⟨hz.1.2, hz.2⟩⟩, hz.2⟩
  have := measure_mono_ae hle
  rw [h.disj] at this
  exact absurd hpos (not_lt.2 this)

/-- In a two-colour open set, a density point of `A` is outside the essential closure of `B`: near it `B` lies in the
complement of `A` up to the null overlap. -/
theorem TwoColourOn.notMem_essClosure_of_mem_densitySet {A B N : Set ℂ} (hA : MeasurableSet A)
    (h : TwoColourOn A B N) {x : ℂ} (hxN : x ∈ N) (hx : x ∈ densitySet A) : x ∉ essClosure B := by
  have h0 := tendsto_densityRatio_compl_of_mem hA hx
  obtain ⟨r₀, hr₀, hsub⟩ := Metric.isOpen_iff.1 h.isOpen x hxN
  have hle : ∀ᶠ r in 𝓝[>] (0 : ℝ), densityRatio B x r ≤ densityRatio Aᶜ x r := by
    filter_upwards [Ioo_mem_nhdsGT hr₀] with r hr
    refine ENNReal.div_le_div_right ?_ _
    have hcb : closedBall x r ⊆ N := (closedBall_subset_ball hr.2).trans hsub
    have hsubset : B ∩ closedBall x r ⊆ (Aᶜ ∩ closedBall x r) ∪ (A ∩ B ∩ N) := by
      rintro z ⟨hzB, hzc⟩
      by_cases hzA : z ∈ A
      · exact Or.inr ⟨⟨hzA, hzB⟩, hcb hzc⟩
      · exact Or.inl ⟨hzA, hzc⟩
    calc volume (B ∩ closedBall x r) ≤ volume ((Aᶜ ∩ closedBall x r) ∪ (A ∩ B ∩ N)) := measure_mono hsubset
      _ ≤ volume (Aᶜ ∩ closedBall x r) + volume (A ∩ B ∩ N) := measure_union_le _ _
      _ = volume (Aᶜ ∩ closedBall x r) := by rw [h.disj, add_zero]
  have h1 : upperDensityAt B x ≤ 0 := by
    rw [upperDensityAt, ← h0.limsup_eq]
    exact limsup_le_limsup hle
  intro hB
  exact lt_irrefl _ (lt_of_lt_of_le hB h1)

/-- In a two-colour open set, a point outside the support of `B` is interior to the density set of `A`: `B` is null
near it, so a ball about it is almost everywhere in `A`. Only `cover` is read. -/
theorem TwoColourOn.mem_interior_densitySet_of_notMem {A B N : Set ℂ} (h : TwoColourOn A B N) {x : ℂ}
    (hxN : x ∈ N) (hx : x ∉ essSupport B) : x ∈ interior (densitySet A) := by
  obtain ⟨r₀, hr₀, hsub⟩ := Metric.isOpen_iff.1 h.isOpen x hxN
  simp only [essSupport, mem_setOf_eq, not_forall, not_lt, nonpos_iff_eq_zero] at hx
  obtain ⟨r, hr, hnull⟩ := hx
  have hsubN : ball x (min r r₀) ⊆ N := (ball_subset_ball (min_le_right _ _)).trans hsub
  have hae : (ball x (min r r₀) : Set ℂ) ≤ᵐ[volume] A := by
    rw [ae_le_set]
    refine measure_mono_null (t := (N \ (A ∪ B)) ∪ (B ∩ ball x r)) ?_
      (measure_union_null (ae_le_set.1 h.cover) hnull)
    rintro z ⟨hz, hzA⟩
    by_cases hzB : z ∈ B
    · exact Or.inr ⟨hzB, ball_subset_ball (min_le_left _ _) hz⟩
    · exact Or.inl ⟨hsubN hz, fun hu => hu.elim hzA hzB⟩
  exact mem_interior.2 ⟨_, subset_densitySet_of_isOpen_ae_subset isOpen_ball hae, isOpen_ball,
    mem_ball_self (lt_min hr hr₀)⟩

/-- **Off the essential boundary and the cusps, a point of a two-colour open set is interior to one of the two
density sets** (FS131-E8 § 3.1 (1): `N = O_a ⊔ O_b ⊔ Z`). -/
theorem TwoColourOn.mem_interior_densitySet_or {A B N : Set ℂ} (hA : MeasurableSet A) (h : TwoColourOn A B N)
    {x : ℂ} (hxN : x ∈ N) (hcA : ¬ IsCuspAt A x) (hcB : ¬ IsCuspAt B x) (hx : x ∉ essBoundary A) :
    x ∈ interior (densitySet A) ∨ x ∈ interior (densitySet B) := by
  by_cases hd : x ∈ densitySet A
  · exact Or.inl (h.mem_interior_densitySet_of_notMem hxN fun hs =>
      hcB ⟨hs, h.notMem_essClosure_of_mem_densitySet hA hxN hd⟩)
  · exact Or.inr (h.symm.mem_interior_densitySet_of_notMem hxN fun hs => hcA ⟨hs, fun hc => hx ⟨hc, hd⟩⟩)

/-- **FS131-E8 § 3.1 (3)(b), set form**: a point of the common essential boundary in `N` lies in neither of the two
open unit discs at another point. -/
theorem HasTwoDiscsAt.one_le_norm_sub {A B N : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : TwoColourOn A B N) {x ν x' : ℂ} (hd : HasTwoDiscsAt A B N x ν) (hx' : x' ∈ essBoundary A ∩ N) :
    1 ≤ ‖x' - (x + ν)‖ ∧ 1 ≤ ‖x' - (x - ν)‖ := by
  have hxB : x' ∈ essBoundary B := ((h.essBoundary_inter_eq hA hB).subset hx').1
  constructor
  · by_contra hlt
    rw [not_le, ← dist_eq_norm, ← mem_ball] at hlt
    exact hxB.2 (subset_densitySet_of_isOpen_ae_subset (isOpen_ball.inter h.isOpen) hd.2.1 ⟨hlt, hx'.2⟩)
  · by_contra hlt
    rw [not_le, ← dist_eq_norm, ← mem_ball] at hlt
    exact hx'.1.2 (subset_densitySet_of_isOpen_ae_subset (isOpen_ball.inter h.isOpen) hd.2.2 ⟨hlt, hx'.2⟩)

/-- **The normal of the two discs is 1-Lipschitz on the common essential boundary** (FS131-E8 § 3.1 (3)(c) and the
erratum under FS131-E8-LOCAL, in one statement, sharp): for two essential boundary points `x`, `x'` of `N` with their
two discs, `‖ν − ν'‖ ≤ ‖x − x'‖` as soon as the closed ball of radius `τ ≥ 4 ‖x − x'‖` about `x` lies in `N`. Otherwise
`exists_lens_point` puts a point of `N` in two opposite open discs, almost everywhere of both sets. -/
theorem HasTwoDiscsAt.norm_sub_le {A B N : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : TwoColourOn A B N) {x x' ν ν' : ℂ} (hd : HasTwoDiscsAt A B N x ν) (hd' : HasTwoDiscsAt A B N x' ν')
    (hx : x ∈ essBoundary A ∩ N) (hx' : x' ∈ essBoundary A ∩ N) {τ : ℝ} (hτ : 0 < τ) (hball : closedBall x τ ⊆ N)
    (hδ : 4 * ‖x - x'‖ ≤ τ) : ‖ν - ν'‖ ≤ ‖x - x'‖ := by
  by_contra hlt
  rw [not_le] at hlt
  obtain ⟨p, hp, hcase⟩ := exists_lens_point hd.1 hd'.1 (hd.one_le_norm_sub hA hB h hx').1
    (hd'.one_le_norm_sub hA hB h hx).2 hτ hδ hlt
  have hpN : p ∈ N := hball (by rwa [mem_closedBall, dist_eq_norm])
  rcases hcase with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact h.symm.false_of_mem_inter isOpen_ball isOpen_ball hd'.2.1 hd.2.2 hpN
      (by rwa [mem_ball, dist_eq_norm]) (by rwa [mem_ball, dist_eq_norm])
  · exact h.symm.false_of_mem_inter isOpen_ball isOpen_ball hd.2.1 hd'.2.2 hpN
      (by rwa [mem_ball, dist_eq_norm]) (by rwa [mem_ball, dist_eq_norm])

/-- The normal of the two discs at an essential boundary point of `N` is unique. -/
theorem HasTwoDiscsAt.normal_unique {A B N : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : TwoColourOn A B N) {x ν ν' : ℂ} (hd : HasTwoDiscsAt A B N x ν) (hd' : HasTwoDiscsAt A B N x ν')
    (hx : x ∈ essBoundary A ∩ N) : ν = ν' := by
  obtain ⟨r, hr, hsub⟩ := Metric.isOpen_iff.1 h.isOpen x hx.2
  have := hd.norm_sub_le hA hB h hd' hx hx (half_pos hr) ((closedBall_subset_ball (half_lt_self hr)).trans hsub)
    (by rw [sub_self, norm_zero, mul_zero]; exact (half_pos hr).le)
  rw [sub_self, norm_zero] at this
  exact sub_eq_zero.1 (norm_le_zero_iff.1 this)

/-! ### Children of `local_graph` (FS131-I6C): the arclength reparametrization (no measure, no colouring) -/

/-- **The arclength reparametrization** (FS131-I6C; Mathlib has none): for a continuous speed `σ ≥ 1` on `[−h, h]`,
the inverse `V` of the arclength `u ↦ ∫₀^u σ` is defined on a symmetric interval `(−ℓ, ℓ)`, maps it increasingly onto
an interval `(a, b)` about `0` inside `[−h, h]`, and has derivative `1/σ (V s)`. (The integrand is `σ` clamped to
`[−h, h]`, so the arclength is an order isomorphism of the line and its inverse is continuous for free.) -/
theorem exists_arclength_inverse {σ : ℝ → ℝ} {h : ℝ} (hh : 0 < h) (hσc : ContinuousOn σ (Icc (-h) h))
    (hσ1 : ∀ u ∈ Icc (-h) h, 1 ≤ σ u) :
    ∃ (ℓ : ℝ) (V : ℝ → ℝ) (a b : ℝ), 0 < ℓ ∧ -h ≤ a ∧ a < 0 ∧ 0 < b ∧ b ≤ h ∧ V 0 = 0 ∧
      StrictMonoOn V (Ioo (-ℓ) ℓ) ∧ V '' Ioo (-ℓ) ℓ = Ioo a b ∧ ∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt V (σ (V s))⁻¹ s := by
  have hclamp : ∀ u : ℝ, max (-h) (min h u) ∈ Icc (-h) h := fun u =>
    ⟨le_max_left _ _, max_le (by linarith) (min_le_left _ _)⟩
  set σ' : ℝ → ℝ := fun u => σ (max (-h) (min h u)) with hσ'
  have hc : Continuous σ' := hσc.comp_continuous (by fun_prop) hclamp
  have h1 : ∀ u, 1 ≤ σ' u := fun u => hσ1 _ (hclamp u)
  have heq : ∀ u ∈ Icc (-h) h, σ' u = σ u := fun u hu => by
    simp only [hσ', min_eq_right hu.2, max_eq_right hu.1]
  set S : ℝ → ℝ := fun u => ∫ t in (0 : ℝ)..u, σ' t with hS
  have hSd : ∀ u, HasDerivAt S (σ' u) u := fun u => (hc.integral_hasStrictDerivAt 0 u).hasDerivAt
  have hS0 : S 0 = 0 := by simp [hS]
  have hmono : StrictMono S := strictMono_of_deriv_pos fun u => by
    rw [(hSd u).deriv]; linarith [h1 u]
  have hDd : ∀ u, HasDerivAt (fun u => S u - u) (σ' u - 1) u := fun u => (hSd u).sub (hasDerivAt_id' u)
  have hD : Monotone fun u => S u - u :=
    monotone_of_deriv_nonneg (fun u => (hDd u).differentiableAt) fun u => by
      rw [(hDd u).deriv]; linarith [h1 u]
  have hge : ∀ u, 0 ≤ u → u ≤ S u := fun u hu => by
    have h2 : S 0 - 0 ≤ S u - u := hD hu
    linarith
  have hle : ∀ u, u ≤ 0 → S u ≤ u := fun u hu => by
    have h2 : S u - u ≤ S 0 - 0 := hD hu
    linarith
  have hsurj : Function.Surjective S :=
    (continuous_iff_continuousAt.2 fun u => (hSd u).continuousAt).surjective
      (tendsto_atTop_mono' atTop ((eventually_ge_atTop 0).mono fun u hu => hge u hu) tendsto_id)
      (tendsto_atBot_mono' atBot ((eventually_le_atBot 0).mono fun u hu => hle u hu) tendsto_id)
  set E : ℝ ≃o ℝ := hmono.orderIsoOfSurjective S hsurj with hE
  have hES : ∀ u, E u = S u := fun u => rfl
  have hV0 : E.symm 0 = 0 := E.symm_apply_eq.2 hS0.symm
  set ℓ : ℝ := min (S h) (-S (-h)) with hℓ
  have hℓ0 : 0 < ℓ := lt_min (lt_of_lt_of_le hh (hge h hh.le)) (by linarith [hle (-h) (by linarith)])
  have ha : -h ≤ E.symm (-ℓ) := by
    rw [← E.symm_apply_apply (-h)]
    exact E.symm.monotone (by rw [hES]; linarith [min_le_right (S h) (-S (-h))])
  have hb : E.symm ℓ ≤ h := by
    rw [← E.symm_apply_apply h]
    exact E.symm.monotone (by rw [hES]; exact min_le_left _ _)
  refine ⟨ℓ, E.symm, E.symm (-ℓ), E.symm ℓ, hℓ0, ha, ?_, ?_, hb, hV0, E.symm.strictMono.strictMonoOn _,
    E.symm.image_Ioo _ _, fun s hs => ?_⟩
  · rw [← hV0]; exact E.symm.strictMono (by linarith)
  · rw [← hV0]; exact E.symm.strictMono hℓ0
  · have hmem : E.symm s ∈ Icc (-h) h :=
      ⟨ha.trans (E.symm.monotone hs.1.le), (E.symm.monotone hs.2.le).trans hb⟩
    rw [← heq _ hmem]
    exact HasDerivAt.of_local_left_inverse E.symm.continuous.continuousAt (hSd (E.symm s))
      (by linarith [h1 (E.symm s)]) (Eventually.of_forall fun t => E.apply_symm_apply t)

/-- **FS131-E8-LOCAL** (FS111-M-C11 (ii) with "no cusp in the neighbourhood"; FS111-W-NOBEND), at the class its
argument reads: `A`, `B` measurable with null unit pairs on a two-colour open set `N`; `U ⊆ N` open, with no cusp of
`A` or of `B`, each essential boundary point of `U` a contact point of the set it bounds. Then every essential boundary
point `y` of `U` has a chart inside `U`. No colouring, no third class and no singular set is read; the chart's size
is not bounded below (it shrinks toward the cusps and the edge of `U`). -/
theorem local_graph {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
    (hBn : UnitPairsNull B) (h : TwoColourOn A B N) {U : Set ℂ} (hU : IsOpen U) (hUN : U ⊆ N)
    (hcusp : ∀ x ∈ U, ¬ IsCuspAt A x ∧ ¬ IsCuspAt B x) (hsatA : ∀ x ∈ essBoundary A ∩ U, IsContactFor A x)
    (hsatB : ∀ x ∈ essBoundary B ∩ U, IsContactFor B x) {y : ℂ} (hy : y ∈ essBoundary A ∩ U) :
    ∃ Q γ ψ h', Q ⊆ U ∧ IsInterfaceChart A B N y Q γ ψ h' := by
  sorry

/-- **FS131-E8-LOCAL for a colouring** (FS121-V5-LOC (ii)): if the open set `U` holds no singular point and the
colouring is saturated on `U`, every essential boundary point `y` of `U` has a two-colour ball centred at it and a
chart inside `U`. -/
theorem AeColouring.local_graph (c : AeColouring k) {U : Set ℂ} (hU : IsOpen U) (hS : Disjoint U c.singularSet)
    (hsat : SaturatedOn c.cls U) {y : ℂ} (hy : y ∈ c.essBdry ∩ U) :
    ∃ ρ a b Q γ ψ h, TwoColourNhd c.cls (ball y ρ) a b ∧ Q ⊆ U ∧
      IsInterfaceChart (c.cls a) (c.cls b) (ball y ρ) y Q γ ψ h := by
  have hyS : y ∉ c.singularSet := disjoint_left.1 hS hy.2
  obtain ⟨ρ, a, b, hN⟩ := exists_twoColourNhd_of_mem_interfaceSet (C := c.cls) ⟨hy.1, hyS⟩
  have hyN : y ∈ ball y ρ := mem_ball_self hN.radius_pos
  have hya := (hN.mem_essBoundary c.measurableSet_cls hyN hy.1).1
  obtain ⟨Q, γ, ψ, h, hQ, hchart⟩ := Plane.local_graph (c.measurableSet_cls a) (c.unitPairsNull a)
    (c.measurableSet_cls b) (c.unitPairsNull b) hN.two (hU.inter isOpen_ball) inter_subset_right
    (fun x hx => ⟨fun hc => disjoint_left.1 hS hx.1 (cuspSet_subset_singularSet _ ⟨a, hc⟩),
      fun hc => disjoint_left.1 hS hx.1 (cuspSet_subset_singularSet _ ⟨b, hc⟩)⟩)
    (fun x hx => hsat a x ⟨hx.1, hx.2.1⟩) (fun x hx => hsat b x ⟨hx.1, hx.2.1⟩)
    (show y ∈ essBoundary (c.cls a) ∩ (U ∩ ball y ρ) from ⟨hya, hy.2, hyN⟩)
  exact ⟨ρ, a, b, Q, γ, ψ, h, hN, hQ.trans inter_subset_left, hchart⟩

end HadwigerNelson.Plane
