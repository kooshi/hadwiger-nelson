import Proofs.HadwigerNelson.Plane.Saturated.Pinch
import Proofs.HadwigerNelson.Plane.Saturated.Curve
import Proofs.HadwigerNelson.Plane.Saturated.Fan

/-!
# The local structure off the singular set (FS-131 wave 6: FS131-E8-LOCAL, FS131-E8-DELTA)

`plans/FS131-E8-derivation.md` §§ 3.1, 3.5 (kernel-checked in this module), at the class each argument
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
`sq9_tight_saturated`, no cusp in the ball by `sq9_not_isCuspAt_near_edge`, the point an essential boundary point by
`sqEdgePt_mem_essBoundary` — every hypothesis of `local_graph` at once, in `sq9_exists_isInterfaceChart`; the chart is
the segment `s ↦ sqEdgePt + i s`. The same object serves the children: `sq9_twoColourNhd.two` for `TwoColourOn`,
`sq9_hasTwoDiscsAt` for `HasTwoDiscsAt`; `exists_unit_curve_of_two_discs` is applied to it inside `local_graph`.

**Proofs** (FS131-I6C): no `sorry` in this module; `local_graph` rests on two theorems of `Plane/Saturated/Pinch`
(`c11_discs`, `TwoColourOn.essBoundary_inter_eq`). The route is E8 § 3.1 with the dated erratum under FS131-E8-LOCAL:
the lens point (`exists_lens_point`, `Plane/Saturated/Curve`), the normal 1-Lipschitz (`HasTwoDiscsAt.norm_sub_le`), the
graph theorem in graph coordinates with no measure (`exists_unit_curve_of_two_discs`, over `exists_arclength_inverse`),
existence on the normal segments (`TwoColourOn.exists_mem_essBoundary_of_continuous`), the two sides
(`isConnected_graph_side`, `TwoColourOn.ae_le_of_isPreconnected`).
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

/-! ### Children of `local_graph` (FS131-I6C): the graph theorem (FS131-E8 § 3.1 (4) in graph coordinates; no measure) -/

/-- A function within `K (u − u₀)²` of the line of slope `c` through `(u₀, g u₀)`, near `u₀`, has derivative `c`
there. -/
theorem hasDerivAt_of_sq_bound {g : ℝ → ℝ} {u₀ c K ε : ℝ} (hε : 0 < ε)
    (hb : ∀ u, |u - u₀| < ε → |g u - g u₀ - c * (u - u₀)| ≤ K * (u - u₀) ^ 2) : HasDerivAt g c u₀ := by
  rw [hasDerivAt_iff_isLittleO_nhds_zero, Asymptotics.isLittleO_iff]
  intro c' hc'
  have hK : 0 < |K| + 1 := by positivity
  have hδ : 0 < min ε (c' / (|K| + 1)) := lt_min hε (div_pos hc' hK)
  filter_upwards [Metric.ball_mem_nhds (0 : ℝ) hδ] with t ht
  rw [mem_ball, dist_zero_right, Real.norm_eq_abs, lt_min_iff] at ht
  have h1 := hb (u₀ + t) (by rw [add_sub_cancel_left]; exact ht.1)
  rw [add_sub_cancel_left] at h1
  have h2 : |t| * (|K| + 1) < c' := (lt_div_iff₀ hK).1 ht.2
  rw [Real.norm_eq_abs, Real.norm_eq_abs, smul_eq_mul, mul_comm t c]
  have h3 : K * t ^ 2 ≤ |K| * (|t| * |t|) := by
    rw [← pow_two, sq_abs]
    exact mul_le_mul_of_nonneg_right (le_abs_self K) (sq_nonneg _)
  nlinarith [abs_nonneg t, abs_nonneg K, mul_nonneg (abs_nonneg t) (abs_nonneg K)]

/-- The two-disc inequality in graph coordinates gives a Lipschitz bound. -/
theorem abs_le_of_two_disc_bound {a b n₁ n₂ : ℝ} (hn₁ : |n₁| ≤ 1) (hn₂ : 1 / 2 ≤ n₂) (ha : |a| ≤ 1)
    (hb : |b| ≤ 1 / 2) (h : |n₁ * a + n₂ * b| ≤ (a ^ 2 + b ^ 2) / 2) : |b| ≤ 6 * |a| := by
  have h1 : n₂ * |b| ≤ |n₁| * |a| + (a ^ 2 + b ^ 2) / 2 := by
    have := abs_sub_abs_le_abs_sub (n₂ * b) (-(n₁ * a))
    rw [sub_neg_eq_add, add_comm, abs_mul, abs_neg, abs_mul, abs_of_pos (by linarith : (0 : ℝ) < n₂)] at this
    linarith
  have h2 : a ^ 2 = |a| * |a| := by rw [← pow_two, sq_abs]
  have h3 : b ^ 2 = |b| * |b| := by rw [← pow_two, sq_abs]
  nlinarith [abs_nonneg a, abs_nonneg b, abs_nonneg n₁, mul_nonneg (abs_nonneg a) (abs_nonneg n₁)]

/-- The two-disc inequality in graph coordinates gives the derivative of the graph: `g′ = −n₁/n₂`. -/
theorem hasDerivAt_of_two_disc_bound {g : ℝ → ℝ} {u₀ n₁ n₂ ε : ℝ} (hε : 0 < ε) (hn₁ : |n₁| ≤ 1)
    (hn₂ : 1 / 2 ≤ n₂) (hg : ∀ u, |u - u₀| < ε → |g u - g u₀| ≤ 1 / 2)
    (hb : ∀ u, |u - u₀| < ε →
      |n₁ * (u - u₀) + n₂ * (g u - g u₀)| ≤ ((u - u₀) ^ 2 + (g u - g u₀) ^ 2) / 2) :
    HasDerivAt g (-n₁ / n₂) u₀ := by
  have hn₂0 : 0 < n₂ := by linarith
  refine hasDerivAt_of_sq_bound (K := 37) (lt_min hε one_pos) fun u hu => ?_
  rw [lt_min_iff] at hu
  have hL := abs_le_of_two_disc_bound hn₁ hn₂ hu.2.le (hg u hu.1) (hb u hu.1)
  have h1 := hb u hu.1
  have h2 : g u - g u₀ - -n₁ / n₂ * (u - u₀) = (n₁ * (u - u₀) + n₂ * (g u - g u₀)) / n₂ := by
    field_simp; ring
  rw [h2, abs_div, abs_of_pos hn₂0, div_le_iff₀ hn₂0]
  have h3 : (g u - g u₀) ^ 2 ≤ 36 * (u - u₀) ^ 2 := by
    rw [← sq_abs (g u - g u₀), ← sq_abs (u - u₀)]
    nlinarith [abs_nonneg (g u - g u₀), abs_nonneg (u - u₀)]
  nlinarith [sq_nonneg (u - u₀)]

/-- The two-disc condition in coordinates: a point `d` outside the open unit discs about `±n` (a unit vector) has
`|⟨d, n⟩| ≤ ‖d‖²/2`. -/
theorem abs_inner_le_of_one_le {d n : ℂ} (hn : ‖n‖ = 1) (h1 : 1 ≤ ‖d - n‖) (h2 : 1 ≤ ‖d + n‖) :
    |d.re * n.re + d.im * n.im| ≤ (d.re ^ 2 + d.im ^ 2) / 2 := by
  have a := one_le_pow₀ (n := 2) h1
  have b := one_le_pow₀ (n := 2) h2
  have c : n.re ^ 2 + n.im ^ 2 = 1 := by rw [← sq_norm_eq, hn, one_pow]
  rw [sq_norm_eq, Complex.sub_re, Complex.sub_im] at a
  rw [sq_norm_eq, Complex.add_re, Complex.add_im] at b
  rw [abs_le]
  constructor <;> nlinarith

/-- A unit vector within `r` of `i` has imaginary part at least `1 − r²/2`. -/
theorem im_ge_of_norm_sub_I_le {n : ℂ} {r : ℝ} (hn : ‖n‖ = 1) (h : ‖n - I‖ ≤ r) : 1 - r ^ 2 / 2 ≤ n.im := by
  have c : n.re ^ 2 + n.im ^ 2 = 1 := by rw [← sq_norm_eq, hn, one_pow]
  have h2 : ‖n - I‖ ^ 2 ≤ r ^ 2 := pow_le_pow_left₀ (norm_nonneg _) h 2
  rw [sq_norm_eq, Complex.sub_re, Complex.sub_im, Complex.I_re, Complex.I_im] at h2
  nlinarith

/-- For a unit vector `N` with non-negative imaginary part, `e (−arcsin (re N)) = im N − (re N) i`: the tangent whose
normal is `N`. -/
theorem e_neg_arcsin_re {N : ℂ} (hN : ‖N‖ = 1) (him : 0 ≤ N.im) :
    e (-Real.arcsin N.re) = (N.im : ℂ) - (N.re : ℂ) * I := by
  have c : N.re ^ 2 + N.im ^ 2 = 1 := by rw [← sq_norm_eq, hN, one_pow]
  have h1 : -1 ≤ N.re := by nlinarith [sq_nonneg N.im]
  have h2 : N.re ≤ 1 := by nlinarith [sq_nonneg N.im]
  have h3 : 1 - N.re ^ 2 = N.im ^ 2 := by linarith
  rw [e_neg, Real.cos_arcsin, Real.sin_arcsin h1 h2, h3, Real.sqrt_sq him]

/-- **The graph theorem** (FS131-E8 § 3.1 (4), in graph coordinates; no measure, no colouring). Let `Zf` be a set with
a field `n` of unit normals at its points near `0`, such that near `0`: each point of `Zf` is outside the two open unit
discs about `z ± n z` at every other point `z` (§ 3.1 (3)(b)); `n` is 1-Lipschitz on `Zf` (the erratum's bound);
`0 ∈ Zf` with `n 0 = i`; and every vertical segment over `|u| < h` meets `Zf` at height at most `h`. Then `Zf`, in a
rectangle `(a, b) × (−h, h)`, is the image of an injective unit-speed curve `ζ` on `(−ℓ, ℓ)` with `ζ 0 = 0`, whose
tangent angle `φ` is 1-Lipschitz and whose normal `i e(φ s)` is `n (ζ s)`; and it is the graph of a continuous
`g`, `|g| < h/2`, over `(a, b)`. (Uniqueness on vertical segments, `|g u| ≤ u²`, `g′ = −n₁/n₂`,
`exists_arclength_inverse`, `lipschitzOnWith_of_chord`.) -/
theorem exists_unit_curve_of_two_discs {Zf : Set ℂ} {n : ℂ → ℂ} {h : ℝ} (hh : 0 < h) (hh1 : h ≤ 1 / 16)
    (hn : ∀ z ∈ Zf, ‖z‖ < 2 * h → ‖n z‖ = 1)
    (hb : ∀ z ∈ Zf, ∀ z' ∈ Zf, ‖z‖ < 2 * h → ‖z'‖ < 2 * h → 1 ≤ ‖z' - (z + n z)‖ ∧ 1 ≤ ‖z' - (z - n z)‖)
    (hc : ∀ z ∈ Zf, ∀ z' ∈ Zf, ‖z‖ < 2 * h → ‖z'‖ < 2 * h → ‖n z - n z'‖ ≤ ‖z - z'‖)
    (h0 : (0 : ℂ) ∈ Zf) (hn0 : n 0 = I)
    (hex : ∀ u : ℝ, |u| < h → ∃ v : ℝ, |v| ≤ h ∧ (u : ℂ) + v * I ∈ Zf) :
    ∃ (ℓ a b : ℝ) (ζ : ℝ → ℂ) (φ g : ℝ → ℝ), 0 < ℓ ∧ -h < a ∧ a < 0 ∧ 0 < b ∧ b < h ∧ ζ 0 = 0 ∧
      (∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt ζ (e (φ s)) s ∧ I * e (φ s) = n (ζ s)) ∧
      LipschitzOnWith 1 φ (Ioo (-ℓ) ℓ) ∧ InjOn ζ (Ioo (-ℓ) ℓ) ∧
      ζ '' Ioo (-ℓ) ℓ = Zf ∩ (Ioo a b ×ℂ Ioo (-h) h) ∧
      ContinuousOn g (Ioo a b) ∧ (∀ u ∈ Ioo a b, |g u| < h / 2) ∧
      ∀ z ∈ Ioo a b ×ℂ Ioo (-h) h, z ∈ Zf ↔ z.im = g z.re := by
  have hre : ∀ u v : ℝ, ((u : ℂ) + v * I).re = u := fun u v => by simp
  have him : ∀ u v : ℝ, ((u : ℂ) + v * I).im = v := fun u v => by simp
  have hnorm : ∀ z : ℂ, |z.re| < h → |z.im| ≤ h → ‖z‖ < 2 * h := fun z hu hv =>
    lt_of_le_of_lt (Complex.norm_le_abs_re_add_abs_im z) (by linarith)
  have hsmall : ∀ u v : ℝ, |u| < h → |v| ≤ h → ‖(u : ℂ) + v * I‖ < 2 * h := fun u v hu hv =>
    hnorm _ (by rwa [hre]) (by rwa [him])
  have h00 : ‖(0 : ℂ)‖ < 2 * h := by rw [norm_zero]; linarith
  -- the normal near `0`
  have himn : ∀ z ∈ Zf, ‖z‖ < 2 * h → 1 / 2 ≤ (n z).im ∧ |(n z).re| ≤ 1 ∧ (n z).im ≤ 1 := by
    intro z hz hzs
    have h1 := hc z hz 0 h0 hzs h00
    rw [hn0, sub_zero] at h1
    have h2 := im_ge_of_norm_sub_I_le (hn z hz hzs) h1
    have h3 := Complex.abs_re_le_norm (n z)
    have h4 := Complex.im_le_norm (n z)
    rw [hn z hz hzs] at h3 h4
    refine ⟨?_, h3, h4⟩
    nlinarith [norm_nonneg z]
  -- § 3.1 (3)(b) in coordinates
  have hA : ∀ z ∈ Zf, ∀ z' ∈ Zf, ‖z‖ < 2 * h → ‖z'‖ < 2 * h →
      |(n z).re * (z'.re - z.re) + (n z).im * (z'.im - z.im)| ≤
        ((z'.re - z.re) ^ 2 + (z'.im - z.im) ^ 2) / 2 := by
    intro z hz z' hz' hzs hzs'
    obtain ⟨h1, h2⟩ := hb z hz z' hz' hzs hzs'
    have e1 : z' - (z + n z) = z' - z - n z := by ring
    have e2 : z' - (z - n z) = z' - z + n z := by ring
    rw [e1] at h1
    rw [e2] at h2
    have h3 := abs_inner_le_of_one_le (hn z hz hzs) h1 h2
    simp only [Complex.sub_re, Complex.sub_im] at h3
    rwa [mul_comm (z'.re - z.re), mul_comm (z'.im - z.im)] at h3
  -- uniqueness on vertical segments
  have huniq : ∀ z ∈ Zf, ∀ z' ∈ Zf, z.re = z'.re → |z.re| < h → |z.im| ≤ h → |z'.im| ≤ h → z.im = z'.im := by
    intro z hz z' hz' hre' hu hv hv'
    have hzs := hnorm z hu hv
    have hzs' := hnorm z' (hre' ▸ hu) hv'
    have key := hA z hz z' hz' hzs hzs'
    rw [hre', sub_self, mul_zero, zero_add, abs_mul, abs_of_pos (by linarith [(himn z hz hzs).1] : 0 < (n z).im)]
      at key
    have him' := (himn z hz hzs).1
    by_contra hne
    have hpos : 0 < |z'.im - z.im| := abs_pos.2 (sub_ne_zero.2 (Ne.symm hne))
    have hd : |z'.im - z.im| ≤ 2 * h := by
      rw [abs_le] at hv hv' ⊢
      constructor <;> linarith
    have hsq : (z'.im - z.im) ^ 2 = |z'.im - z.im| * |z'.im - z.im| := by rw [← pow_two, sq_abs]
    nlinarith
  -- the graph function
  have hex' : ∀ u : ℝ, ∃ v : ℝ, |u| < h → |v| ≤ h ∧ (u : ℂ) + v * I ∈ Zf := fun u => by
    by_cases hu : |u| < h
    · obtain ⟨v, hv⟩ := hex u hu
      exact ⟨v, fun _ => hv⟩
    · exact ⟨0, fun h' => absurd h' hu⟩
  choose g hg using hex'
  have hG2 : ∀ z ∈ Zf, |z.re| < h → |z.im| ≤ h → z.im = g z.re := by
    intro z hz hu hv
    have := huniq z hz _ (hg z.re hu).2 (by rw [hre]) hu hv (by rw [him]; exact (hg z.re hu).1)
    rwa [him] at this
  have hG3 : ∀ u, |u| < h → |g u| ≤ u ^ 2 := by
    intro u hu
    have key := hA 0 h0 _ (hg u hu).2 h00 (hsmall u (g u) hu (hg u hu).1)
    rw [hn0] at key
    simp only [hre, him, Complex.zero_re, Complex.zero_im, sub_zero, Complex.I_re, Complex.I_im, zero_mul, one_mul,
      zero_add] at key
    have h1 := (hg u hu).1
    have hsq : g u ^ 2 = |g u| * |g u| := by rw [← pow_two, sq_abs]
    nlinarith [abs_nonneg (g u)]
  have hgh : ∀ u, |u| < h → |g u| < h / 2 := fun u hu => by
    have h1 := hG3 u hu
    have h2 : u ^ 2 = |u| * |u| := by rw [← pow_two, sq_abs]
    nlinarith [abs_nonneg u]
  have hlt : ∀ u u₀ : ℝ, |u₀| < h → |u - u₀| < h - |u₀| → |u| < h := fun u u₀ _ hu => by
    have := abs_sub_abs_le_abs_sub u u₀
    linarith
  have hgg : ∀ u u', |u| < h → |u'| < h → |g u' - g u| ≤ 1 / 2 := fun u u' hu hu' => by
    have h1 := hgh u hu
    have h2 := hgh u' hu'
    rw [abs_lt] at h1 h2
    rw [abs_le]
    constructor <;> linarith
  have hgd : ∀ u₀, |u₀| < h → HasDerivAt g (-(n ((u₀ : ℂ) + g u₀ * I)).re / (n ((u₀ : ℂ) + g u₀ * I)).im) u₀ := by
    intro u₀ hu₀
    have hz₀ := (hg u₀ hu₀).2
    have hs₀ := hsmall u₀ (g u₀) hu₀ (hg u₀ hu₀).1
    obtain ⟨i1, i2, -⟩ := himn _ hz₀ hs₀
    refine hasDerivAt_of_two_disc_bound (sub_pos.2 hu₀) i2 i1 (fun u hu => hgg u₀ u hu₀ (hlt u u₀ hu₀ hu))
      (fun u hu => ?_)
    have hu' := hlt u u₀ hu₀ hu
    have key := hA _ hz₀ _ (hg u hu').2 hs₀ (hsmall u (g u) hu' (hg u hu').1)
    simpa only [hre, him] using key
  have hglip : ∀ u u', |u| < h → |u'| < h → |g u' - g u| ≤ 6 * |u' - u| := by
    intro u u' hu hu'
    have hs := hsmall u (g u) hu (hg u hu).1
    obtain ⟨i1, i2, -⟩ := himn _ (hg u hu).2 hs
    have key := hA _ (hg u hu).2 _ (hg u' hu').2 hs (hsmall u' (g u') hu' (hg u' hu').1)
    simp only [hre, him] at key
    refine abs_le_of_two_disc_bound i2 i1 ?_ (hgg u u' hu hu') key
    rw [abs_lt] at hu hu'
    rw [abs_le]
    constructor <;> linarith
  have hNlip : ∀ u u', |u| < h → |u'| < h →
      ‖n ((u : ℂ) + g u * I) - n ((u' : ℂ) + g u' * I)‖ ≤ 7 * |u - u'| := by
    intro u u' hu hu'
    have h1 := hc _ (hg u hu).2 _ (hg u' hu').2 (hsmall u (g u) hu (hg u hu).1)
      (hsmall u' (g u') hu' (hg u' hu').1)
    have e1 : (u : ℂ) + g u * I - ((u' : ℂ) + g u' * I) = ((u - u' : ℝ) : ℂ) + ((g u - g u' : ℝ) : ℂ) * I := by
      push_cast; ring
    have h2 := Complex.norm_le_abs_re_add_abs_im ((u : ℂ) + g u * I - ((u' : ℂ) + g u' * I))
    rw [e1, hre, him] at h2
    rw [e1] at h1
    have h3 := hglip u' u hu' hu
    linarith
  have hNc : ContinuousOn (fun u : ℝ => n ((u : ℂ) + g u * I)) (Ioo (-h) h) :=
    LipschitzOnWith.continuousOn (K := 7) (LipschitzOnWith.of_dist_le_mul fun u hu u' hu' => by
      simpa [dist_eq_norm, Real.dist_eq] using hNlip u u' (abs_lt.2 hu) (abs_lt.2 hu'))
  -- the arclength parameter
  have hmem : ∀ u ∈ Icc (-(h / 2)) (h / 2), |u| < h := fun u hu => by
    rw [abs_lt]; constructor <;> linarith [hu.1, hu.2]
  have hσc : ContinuousOn (fun u : ℝ => ((n ((u : ℂ) + g u * I)).im)⁻¹) (Icc (-(h / 2)) (h / 2)) := by
    refine ContinuousOn.inv₀ ((Complex.continuous_im.comp_continuousOn hNc).mono fun u hu => abs_lt.1 (hmem u hu))
      fun u hu => ?_
    have := (himn _ (hg u (hmem u hu)).2 (hsmall u (g u) (hmem u hu) (hg u (hmem u hu)).1)).1
    exact ne_of_gt (by linarith)
  have hσ1 : ∀ u ∈ Icc (-(h / 2)) (h / 2), 1 ≤ ((n ((u : ℂ) + g u * I)).im)⁻¹ := fun u hu => by
    obtain ⟨i1, -, i3⟩ := himn _ (hg u (hmem u hu)).2 (hsmall u (g u) (hmem u hu) (hg u (hmem u hu)).1)
    exact (one_le_inv₀ (by linarith)).2 i3
  obtain ⟨ℓ, V, a, b, hℓ, ha, ha0, hb0, hbh, hV0, hVmono, hVimg, hVd⟩ :=
    exists_arclength_inverse (half_pos hh) hσc hσ1
  have hVab : ∀ s ∈ Ioo (-ℓ) ℓ, V s ∈ Ioo a b := fun s hs => hVimg ▸ mem_image_of_mem V hs
  have habh : ∀ u ∈ Ioo a b, |u| < h := fun u hu => by
    rw [abs_lt]; constructor <;> linarith [hu.1, hu.2]
  have hVh : ∀ s ∈ Ioo (-ℓ) ℓ, |V s| < h := fun s hs => habh _ (hVab s hs)
  have hζZ : ∀ s ∈ Ioo (-ℓ) ℓ, (V s : ℂ) + g (V s) * I ∈ Zf ∧ ‖(V s : ℂ) + g (V s) * I‖ < 2 * h := fun s hs =>
    ⟨(hg _ (hVh s hs)).2, hsmall _ _ (hVh s hs) (hg _ (hVh s hs)).1⟩
  have hg0 : g 0 = 0 := by
    have := hG3 0 (by rw [abs_zero]; exact hh)
    rw [zero_pow two_ne_zero] at this
    exact abs_eq_zero.1 (le_antisymm this (abs_nonneg _))
  -- the tangent and its angle
  have hIe : ∀ s ∈ Ioo (-ℓ) ℓ,
      I * e (-Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re) = n ((V s : ℂ) + g (V s) * I) := by
    intro s hs
    obtain ⟨hz, hzs⟩ := hζZ s hs
    rw [e_neg_arcsin_re (hn _ hz hzs) (by linarith [(himn _ hz hzs).1])]
    apply Complex.ext <;> simp
  have hζd : ∀ s ∈ Ioo (-ℓ) ℓ, HasDerivAt (fun s => (V s : ℂ) + g (V s) * I)
      (e (-Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re)) s := by
    intro s hs
    obtain ⟨hz, hzs⟩ := hζZ s hs
    obtain ⟨i1, -, -⟩ := himn _ hz hzs
    have hV := hVd s hs
    rw [inv_inv] at hV
    have hgV := (hgd (V s) (hVh s hs)).comp s hV
    have hd := hV.ofReal_comp.add (hgV.ofReal_comp.mul_const I)
    refine hd.congr_deriv ?_
    have hr : -(n ((V s : ℂ) + g (V s) * I)).re / (n ((V s : ℂ) + g (V s) * I)).im *
        (n ((V s : ℂ) + g (V s) * I)).im = -(n ((V s : ℂ) + g (V s) * I)).re :=
      div_mul_cancel₀ _ (ne_of_gt (by linarith))
    rw [e_neg_arcsin_re (hn _ hz hzs) (by linarith), hr]
    push_cast
    ring
  have hζlip : ∀ s ∈ Ioo (-ℓ) ℓ, ∀ s' ∈ Ioo (-ℓ) ℓ,
      ‖((V s : ℂ) + g (V s) * I) - ((V s' : ℂ) + g (V s') * I)‖ ≤ |s - s'| := by
    intro s hs s' hs'
    have := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le (f := fun s => (V s : ℂ) + g (V s) * I)
      (fun x hx => (hζd x hx).hasDerivWithinAt) (fun x _ => (norm_e _).le) (convex_Ioo (-ℓ) ℓ) hs' hs
    simpa [Real.norm_eq_abs] using this
  have hVc : ContinuousOn V (Ioo (-ℓ) ℓ) := fun s hs => (hVd s hs).continuousAt.continuousWithinAt
  have hφc : ContinuousOn (fun s => -Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re) (Ioo (-ℓ) ℓ) := by
    have h1 : ContinuousOn (fun s => n ((V s : ℂ) + g (V s) * I)) (Ioo (-ℓ) ℓ) :=
      hNc.comp hVc fun s hs => abs_lt.1 (hVh s hs)
    exact (Real.continuous_arcsin.comp_continuousOn (Complex.continuous_re.comp_continuousOn h1)).neg
  have hφlip : LipschitzOnWith 1 (fun s => -Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re) (Ioo (-ℓ) ℓ) :=
    lipschitzOnWith_of_chord ordConnected_Ioo hφc fun s hs s' hs' => by
      have e1 : ∀ p q : ℂ, ‖p - q‖ = ‖I * p - I * q‖ := fun p q => by
        rw [← mul_sub, norm_mul, Complex.norm_I, one_mul]
      rw [e1, hIe s hs, hIe s' hs']
      exact (hc _ (hζZ s hs).1 _ (hζZ s' hs').1 (hζZ s hs).2 (hζZ s' hs').2).trans (hζlip s hs s' hs')
  refine ⟨ℓ, a, b, fun s => (V s : ℂ) + g (V s) * I, fun s => -Real.arcsin (n ((V s : ℂ) + g (V s) * I)).re, g,
    hℓ, by linarith, ha0, hb0, by linarith, ?_, fun s hs => ⟨hζd s hs, hIe s hs⟩, hφlip, ?_, ?_, ?_,
    fun u hu => hgh u (habh u hu), ?_⟩
  · simp [hV0, hg0]
  · intro s hs s' hs' heq
    have h1 := congrArg Complex.re heq
    simp only [hre] at h1
    exact hVmono.injOn hs hs' h1
  · ext z
    constructor
    · rintro ⟨s, hs, rfl⟩
      refine ⟨(hζZ s hs).1, ?_⟩
      rw [Complex.mem_reProdIm, hre, him]
      have h1 := hgh _ (hVh s hs)
      rw [abs_lt] at h1
      exact ⟨hVab s hs, by linarith, by linarith⟩
    · rintro ⟨hz, hzbox⟩
      rw [Complex.mem_reProdIm] at hzbox
      have hu := habh _ hzbox.1
      obtain ⟨s, hs, hVs⟩ : z.re ∈ V '' Ioo (-ℓ) ℓ := hVimg ▸ hzbox.1
      refine ⟨s, hs, ?_⟩
      apply Complex.ext
      · rw [hre, hVs]
      · rw [him, hVs, hG2 z hz hu (abs_lt.2 hzbox.2).le]
  · exact fun u hu => (hgd u (habh u hu)).continuousAt.continuousWithinAt
  · intro z hzbox
    rw [Complex.mem_reProdIm] at hzbox
    have hu := habh _ hzbox.1
    refine ⟨fun hz => hG2 z hz hu (abs_lt.2 hzbox.2).le, fun hzg => ?_⟩
    have h1 := (hg z.re hu).2
    rwa [← hzg, Complex.re_add_im] at h1

/-! ### Children of `local_graph` (FS131-I6C): the two sides, and the essential boundary on a path -/

/-- The part of the rectangle `(a, b) × (−h, h)` strictly above (`σ = 1`) or strictly below (`σ = −1`) the graph of a
function `g` with `|g| < h/2` is connected: every point is joined, inside it, to the point over the middle at height
`σ · 3h/4` by a vertical and a horizontal segment. -/
theorem isConnected_graph_side {a b h σ : ℝ} {g : ℝ → ℝ} (hab : a < b) (hh : 0 < h) (hσ : σ = 1 ∨ σ = -1)
    (hg : ∀ u ∈ Ioo a b, |g u| < h / 2) :
    IsConnected {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h) h ∧ 0 < σ * (z.im - g z.re)} := by
  have hmid : (a + b) / 2 ∈ Ioo a b := ⟨by linarith, by linarith⟩
  have key : ∀ u v : ℝ, u ∈ Ioo a b → v ∈ Ioo (-h) h → 0 < σ * (v - g u) →
      (u : ℂ) + (v : ℂ) * I ∈ {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h) h ∧ 0 < σ * (z.im - g z.re)} := by
    intro u v hu hv hpos
    refine ⟨?_, ?_⟩
    · rw [Complex.mem_reProdIm]; simpa using ⟨hu, hv⟩
    · simpa using hpos
  have hanchor : ∀ u ∈ Ioo a b, σ * (3 * h / 4) ∈ Ioo (-h) h ∧ 0 < σ * (σ * (3 * h / 4) - g u) := by
    intro u hu
    have h1 := hg u hu
    rw [abs_lt] at h1
    rcases hσ with rfl | rfl
    · exact ⟨⟨by linarith, by linarith⟩, by linarith⟩
    · exact ⟨⟨by linarith, by linarith⟩, by linarith⟩
  refine ⟨⟨_, key _ _ hmid (hanchor _ hmid).1 (hanchor _ hmid).2⟩,
    isPreconnected_of_forall ((((a + b) / 2 : ℝ) : ℂ) + ((σ * (3 * h / 4) : ℝ) : ℂ) * I) fun z hz => ?_⟩
  obtain ⟨hzbox, hzpos⟩ := hz
  rw [Complex.mem_reProdIm] at hzbox
  refine ⟨(fun v : ℝ => (z.re : ℂ) + (v : ℂ) * I) '' uIcc z.im (σ * (3 * h / 4)) ∪
      (fun u : ℝ => (u : ℂ) + ((σ * (3 * h / 4) : ℝ) : ℂ) * I) '' uIcc z.re ((a + b) / 2), ?_, ?_, ?_, ?_⟩
  · rintro w (⟨v, hv, rfl⟩ | ⟨u, hu, rfl⟩)
    · have h1 := hg z.re hzbox.1
      rw [abs_lt] at h1
      rw [mem_uIcc] at hv
      refine key _ _ hzbox.1 ?_ ?_
      · rcases hσ with rfl | rfl <;> rcases hv with hv | hv <;>
          exact ⟨by linarith [hzbox.2.1, hzbox.2.2], by linarith [hzbox.2.1, hzbox.2.2]⟩
      · rcases hσ with rfl | rfl <;> rcases hv with hv | hv <;> linarith
    · have hu' : u ∈ Ioo a b := by
        rw [mem_uIcc] at hu
        rcases hu with hu | hu
        · exact ⟨lt_of_lt_of_le hzbox.1.1 hu.1, lt_of_le_of_lt hu.2 hmid.2⟩
        · exact ⟨lt_of_lt_of_le hmid.1 hu.1, lt_of_le_of_lt hu.2 hzbox.1.2⟩
      exact key _ _ hu' (hanchor u hu').1 (hanchor u hu').2
  · exact Or.inr ⟨(a + b) / 2, right_mem_uIcc, rfl⟩
  · exact Or.inl ⟨z.im, left_mem_uIcc, Complex.re_add_im z⟩
  · exact IsPreconnected.union ((z.re : ℂ) + ((σ * (3 * h / 4) : ℝ) : ℂ) * I) ⟨_, right_mem_uIcc, rfl⟩
      ⟨_, left_mem_uIcc, rfl⟩ (isPreconnected_uIcc.image _ (Continuous.continuousOn (by fun_prop)))
      (isPreconnected_uIcc.image _ (Continuous.continuousOn (by fun_prop)))

/-- The interior of the density set of a measurable set is almost everywhere inside the set. -/
theorem interior_densitySet_inter_ae_le {A : Set ℂ} (hA : MeasurableSet A) (N : Set ℂ) :
    (interior (densitySet A) ∩ N : Set ℂ) ≤ᵐ[volume] A := by
  rw [ae_le_set]
  exact measure_mono_null (show (interior (densitySet A) ∩ N) \ A ⊆ densitySet A \ A from
    fun z hz => ⟨interior_subset hz.1.1, hz.2⟩) (volume_densitySet_diff hA)

/-- The two open unit discs of `HasTwoDiscsAt`, within the open `N`, lie in the interiors of the two density sets. -/
theorem HasTwoDiscsAt.subset_interior_densitySet {A B N : Set ℂ} (hN : IsOpen N) {x ν : ℂ}
    (hd : HasTwoDiscsAt A B N x ν) :
    ball (x + ν) 1 ∩ N ⊆ interior (densitySet B) ∧ ball (x - ν) 1 ∩ N ⊆ interior (densitySet A) :=
  ⟨interior_maximal (subset_densitySet_of_isOpen_ae_subset (isOpen_ball.inter hN) hd.2.1) (isOpen_ball.inter hN),
    interior_maximal (subset_densitySet_of_isOpen_ae_subset (isOpen_ball.inter hN) hd.2.2) (isOpen_ball.inter hN)⟩

/-- **Existence on a path** (FS131-E8 § 3.1 (4), *Existence*): a path in a two-colour open set, with no cusp on it,
from the interior of `S̃_A` to the interior of `S̃_B`, passes through the essential boundary — an interval is not the
union of two disjoint non-empty relatively open sets. -/
theorem TwoColourOn.exists_mem_essBoundary_of_continuous {A B N : Set ℂ} (hA : MeasurableSet A)
    (hB : MeasurableSet B) (h : TwoColourOn A B N) {c : ℝ → ℂ} (hc : Continuous c) {α β : ℝ} (hαβ : α ≤ β)
    (hcN : ∀ v ∈ Icc α β, c v ∈ N) (hcusp : ∀ v ∈ Icc α β, ¬ IsCuspAt A (c v) ∧ ¬ IsCuspAt B (c v))
    (hα : c α ∈ interior (densitySet A)) (hβ : c β ∈ interior (densitySet B)) :
    ∃ v ∈ Icc α β, c v ∈ essBoundary A := by
  by_contra hno
  push Not at hno
  have hcover : Icc α β ⊆ c ⁻¹' interior (densitySet A) ∪ c ⁻¹' interior (densitySet B) := fun v hv =>
    h.mem_interior_densitySet_or hA (hcN v hv) (hcusp v hv).1 (hcusp v hv).2 (hno v hv)
  obtain ⟨v, hv, hvA, hvB⟩ := isPreconnected_Icc (c ⁻¹' interior (densitySet A)) (c ⁻¹' interior (densitySet B))
    (isOpen_interior.preimage hc) (isOpen_interior.preimage hc) hcover ⟨α, left_mem_Icc.2 hαβ, hα⟩
    ⟨β, right_mem_Icc.2 hαβ, hβ⟩
  exact h.false_of_mem_inter isOpen_interior isOpen_interior (interior_densitySet_inter_ae_le hA N)
    (interior_densitySet_inter_ae_le hB N) (hcN v hv) hvA hvB

/-- **A side is of one colour** (FS131-E8 § 3.1 (4), *Sides*): a preconnected subset of a two-colour open set, off
the essential boundary and the cusps, with one point interior to `S̃_B`, is almost everywhere in `B`. -/
theorem TwoColourOn.ae_le_of_isPreconnected {A B N T : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : TwoColourOn A B N) (hT : IsPreconnected T) (hTN : T ⊆ N)
    (hcusp : ∀ x ∈ T, ¬ IsCuspAt A x ∧ ¬ IsCuspAt B x) (hTb : ∀ x ∈ T, x ∉ essBoundary A) {p : ℂ} (hpT : p ∈ T)
    (hp : p ∈ interior (densitySet B)) : (T : Set ℂ) ≤ᵐ[volume] B := by
  have hsub : T ⊆ interior (densitySet B) ∩ N := by
    refine IsPreconnected.subset_left_of_subset_union (u := interior (densitySet B) ∩ N)
      (v := interior (densitySet A) ∩ N) (isOpen_interior.inter h.isOpen) (isOpen_interior.inter h.isOpen) ?_ ?_
      ⟨p, hpT, hp, hTN hpT⟩ hT
    · rw [disjoint_left]
      rintro z ⟨hzB, hzN⟩ ⟨hzA, -⟩
      exact h.false_of_mem_inter isOpen_interior isOpen_interior (interior_densitySet_inter_ae_le hA N)
        (interior_densitySet_inter_ae_le hB N) hzN hzA hzB
    · intro z hz
      rcases h.mem_interior_densitySet_or hA (hTN hz) (hcusp z hz).1 (hcusp z hz).2 (hTb z hz) with hz' | hz'
      · exact Or.inr ⟨hz', hTN hz⟩
      · exact Or.inl ⟨hz', hTN hz⟩
  rw [ae_le_set]
  exact measure_mono_null (show T \ B ⊆ densitySet B \ B from
    fun z hz => ⟨interior_subset (hsub hz.1).1, hz.2⟩) (volume_densitySet_diff hB)

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
  obtain ⟨hyA, hyU⟩ := hy
  have hkey := h.essBoundary_inter_eq hA hB
  -- the two discs at every essential boundary point of `U` (FS111-M-C11 (i), in the one `N`)
  have hdisc : ∀ x, ∃ ν, x ∈ essBoundary A ∩ U → HasTwoDiscsAt A B N x ν := fun x => by
    by_cases hx : x ∈ essBoundary A ∩ U
    · obtain ⟨ν, hν⟩ := c11_discs hA hAn hB hBn h (hUN hx.2) (hsatA x hx)
        (hsatB x ⟨(hkey.subset ⟨hx.1, hUN hx.2⟩).1, hx.2⟩)
      exact ⟨ν, fun _ => hν⟩
    · exact ⟨0, fun hx' => absurd hx' hx⟩
  choose ν hν using hdisc
  obtain ⟨ρ, hρ, hρU⟩ := Metric.isOpen_iff.1 hU y hyU
  set h₁ : ℝ := min ρ 1 / 32 with hh₁
  have hh : 0 < h₁ := div_pos (lt_min hρ one_pos) (by norm_num)
  have hh1 : h₁ ≤ 1 / 16 := by rw [hh₁]; linarith [min_le_right ρ 1]
  have hhρ : 32 * h₁ ≤ ρ := by rw [hh₁]; linarith [min_le_left ρ 1]
  have hν₀ := hν y ⟨hyA, hyU⟩
  -- the frame at `y`: tangent `τ₀`, normal `i τ₀ = ν y`
  set τ₀ : ℂ := -I * ν y with hτ₀
  have hτ : ‖τ₀‖ = 1 := by rw [hτ₀, norm_mul, norm_neg, Complex.norm_I, one_mul, hν₀.1]
  have hIτ : I * τ₀ = ν y := by rw [hτ₀, ← mul_assoc, mul_neg, Complex.I_mul_I, neg_neg, one_mul]
  have hconj : τ₀ * (starRingEnd ℂ) τ₀ = 1 := by
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hτ]; simp
  have hnc : ‖(starRingEnd ℂ) τ₀‖ = 1 := by rw [RCLike.norm_conj, hτ]
  have hmulτ : ∀ w : ℂ, ‖w * τ₀‖ = ‖w‖ := fun w => by rw [norm_mul, hτ, mul_one]
  set Φ : ℂ → ℂ := fun z => y + z * τ₀ with hΦ
  set Ψ : ℂ → ℂ := fun p => (p - y) * (starRingEnd ℂ) τ₀ with hΨ
  have hΦΨ : ∀ p, Φ (Ψ p) = p := fun p => by
    simp only [hΦ, hΨ]; rw [mul_assoc, mul_comm ((starRingEnd ℂ) τ₀), hconj, mul_one]; ring
  have hΨΦ : ∀ z, Ψ (Φ z) = z := fun z => by
    simp only [hΦ, hΨ]; rw [add_sub_cancel_left, mul_assoc, hconj, mul_one]
  have hΦnorm : ∀ z w : ℂ, ‖Φ z - Φ w‖ = ‖z - w‖ := fun z w => by
    have e1 : Φ z - Φ w = (z - w) * τ₀ := by simp only [hΦ]; ring
    rw [e1, norm_mul, hτ, mul_one]
  have hΦy : Φ 0 = y := by simp only [hΦ]; ring
  have hΦdist : ∀ z : ℂ, dist (Φ z) y = ‖z‖ := fun z => by
    have := hΦnorm z 0
    rwa [hΦy, sub_zero, ← dist_eq_norm] at this
  have hΦU : ∀ z : ℂ, ‖z‖ < ρ → Φ z ∈ U := fun z hz => hρU (by rw [mem_ball, hΦdist]; exact hz)
  have hΦc : Continuous Φ := by simp only [hΦ]; fun_prop
  have hΨc : Continuous Ψ := by simp only [hΨ]; fun_prop
  have htop : ∀ u v : ℝ, u ^ 2 + (v - 1) ^ 2 < 1 → Φ ((u : ℂ) + (v : ℂ) * I) ∈ ball (y + ν y) 1 := by
    intro u v hlt
    have e1 : Φ ((u : ℂ) + (v : ℂ) * I) - (y + ν y) = ((u : ℂ) + ((v - 1 : ℝ) : ℂ) * I) * τ₀ := by
      rw [← hIτ]; simp only [hΦ]; push_cast; ring
    rw [mem_ball, dist_eq_norm, e1, norm_mul, hτ, mul_one, ← sq_lt_one_iff₀ (norm_nonneg _), sq_norm_eq]
    simpa using hlt
  have hbot : ∀ u v : ℝ, u ^ 2 + (v + 1) ^ 2 < 1 → Φ ((u : ℂ) + (v : ℂ) * I) ∈ ball (y - ν y) 1 := by
    intro u v hlt
    have e1 : Φ ((u : ℂ) + (v : ℂ) * I) - (y - ν y) = ((u : ℂ) + ((v + 1 : ℝ) : ℂ) * I) * τ₀ := by
      rw [← hIτ]; simp only [hΦ]; push_cast; ring
    rw [mem_ball, dist_eq_norm, e1, norm_mul, hτ, mul_one, ← sq_lt_one_iff₀ (norm_nonneg _), sq_norm_eq]
    simpa using hlt
  have hsm : ∀ u v : ℝ, |u| < h₁ → |v| ≤ h₁ → ‖(u : ℂ) + (v : ℂ) * I‖ < 2 * h₁ := fun u v hu hv => by
    have := Complex.norm_le_abs_re_add_abs_im ((u : ℂ) + (v : ℂ) * I)
    simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, mul_zero, Complex.ofReal_im,
      Complex.I_im, mul_one, sub_self, add_zero, Complex.add_im, Complex.mul_im, zero_add] at this
    linarith
  -- the essential boundary and its normal in graph coordinates
  set Zf : Set ℂ := {z | Φ z ∈ essBoundary A ∩ U} with hZf
  set n : ℂ → ℂ := fun z => ν (Φ z) * (starRingEnd ℂ) τ₀ with hn
  have hnτ : ∀ z, n z * τ₀ = ν (Φ z) := fun z => by
    simp only [hn]; rw [mul_assoc, mul_comm ((starRingEnd ℂ) τ₀), hconj, mul_one]
  have hZd : ∀ z ∈ Zf, HasTwoDiscsAt A B N (Φ z) (n z * τ₀) := fun z hz => by rw [hnτ]; exact hν _ hz
  have hZN : ∀ z ∈ Zf, Φ z ∈ essBoundary A ∩ N := fun z hz => ⟨hz.1, hUN hz.2⟩
  -- existence on the normal segments
  have hex : ∀ u : ℝ, |u| < h₁ → ∃ v : ℝ, |v| ≤ h₁ ∧ (u : ℂ) + v * I ∈ Zf := by
    intro u hu
    have hcU : ∀ v ∈ Icc (-h₁) h₁, Φ ((u : ℂ) + (v : ℂ) * I) ∈ U := fun v hv =>
      hΦU _ (by linarith [hsm u v hu (abs_le.2 hv)])
    have hu2 : u ^ 2 < h₁ ^ 2 := by
      rw [← sq_abs u]; exact pow_lt_pow_left₀ hu (abs_nonneg u) two_ne_zero
    obtain ⟨v, hv, hvb⟩ := h.exists_mem_essBoundary_of_continuous hA hB
      (c := fun v : ℝ => Φ ((u : ℂ) + (v : ℂ) * I)) (hΦc.comp (by fun_prop)) (by linarith : -h₁ ≤ h₁)
      (fun v hv => hUN (hcU v hv)) (fun v hv => hcusp _ (hcU v hv))
      ((hν₀.subset_interior_densitySet h.isOpen).2
        ⟨hbot u (-h₁) (by nlinarith), hUN (hcU _ (left_mem_Icc.2 (by linarith)))⟩)
      ((hν₀.subset_interior_densitySet h.isOpen).1
        ⟨htop u h₁ (by nlinarith), hUN (hcU _ (right_mem_Icc.2 (by linarith)))⟩)
    exact ⟨v, abs_le.2 hv, hvb, hcU v hv⟩
  -- the graph theorem
  obtain ⟨ℓ, a, b, ζ, φ, g, hℓ, hah, ha0, hb0, hbh, hζ0, hζd, hφlip, hζinj, hζimg, hgc, hgh, hgraph⟩ :=
    exists_unit_curve_of_two_discs (Zf := Zf) (n := n) hh hh1
      (fun z hz _ => by simp only [hn]; rw [norm_mul, hnc, mul_one]; exact (hν _ hz).1)
      (fun z hz z' hz' _ _ => by
        have h1 := (hZd z hz).one_le_norm_sub hA hB h (hZN z' hz')
        have e1 : Φ z' - (Φ z + n z * τ₀) = (z' - (z + n z)) * τ₀ := by simp only [hΦ]; ring
        have e2 : Φ z' - (Φ z - n z * τ₀) = (z' - (z - n z)) * τ₀ := by simp only [hΦ]; ring
        rwa [e1, e2, hmulτ, hmulτ] at h1)
      (fun z hz z' hz' hzs hzs' => by
        have h1 := (hZd z hz).norm_sub_le hA hB h (hZd z' hz') (hZN z hz) (hZN z' hz') (τ := 16 * h₁)
          (by positivity)
          (fun p hp => hUN (hρU (by
            rw [mem_closedBall] at hp
            rw [mem_ball]
            have := dist_triangle p (Φ z) y
            rw [hΦdist] at this
            linarith)))
          (by
            rw [hΦnorm]
            have := norm_sub_le z z'
            linarith)
        rwa [← sub_mul, hmulτ, hΦnorm] at h1)
      (by simp only [hZf, mem_setOf_eq, hΦy]; exact ⟨hyA, hyU⟩)
      (by simp only [hn, hΦy]; rw [← hIτ, mul_assoc, hconj, mul_one])
      hex
  obtain ⟨θ₀, hθ₀⟩ : ∃ θ₀ : ℝ, e θ₀ = τ₀ := ⟨Complex.arg τ₀, by
    have := Complex.norm_mul_exp_arg_mul_I τ₀
    rwa [hτ, Complex.ofReal_one, one_mul] at this⟩
  -- the chart
  have hboxs : ∀ z ∈ Ioo a b ×ℂ Ioo (-h₁) h₁, ‖z‖ < 2 * h₁ := fun z hz => by
    rw [Complex.mem_reProdIm] at hz
    have := Complex.norm_le_abs_re_add_abs_im z
    have h1 : |z.re| < h₁ := abs_lt.2 ⟨by linarith [hz.1.1], by linarith [hz.1.2]⟩
    have h2 : |z.im| < h₁ := abs_lt.2 hz.2
    linarith
  have hQU : Ψ ⁻¹' (Ioo a b ×ℂ Ioo (-h₁) h₁) ⊆ U := fun p hp => by
    rw [← hΦΨ p]; exact hΦU _ (by linarith [hboxs _ hp])
  have hζmem : ∀ s ∈ Ioo (-ℓ) ℓ, ζ s ∈ Zf ∩ (Ioo a b ×ℂ Ioo (-h₁) h₁) := fun s hs =>
    hζimg ▸ mem_image_of_mem ζ hs
  have hpre : ∀ R : Set ℂ, Ψ ⁻¹' R = Φ '' R := fun R => by
    ext p
    exact ⟨fun hp => ⟨Ψ p, hp, hΦΨ p⟩, by rintro ⟨z, hz, rfl⟩; show Ψ (Φ z) ∈ R; rwa [hΨΦ]⟩
  have hcurve : ∀ p, Ψ p ∈ Ioo a b ×ℂ Ioo (-h₁) h₁ →
      (p ∈ (fun s => Φ (ζ s)) '' Ioo (-ℓ) ℓ ↔ (Ψ p).im = g (Ψ p).re) := by
    intro p hp
    constructor
    · rintro ⟨s, hs, rfl⟩
      show (Ψ (Φ (ζ s))).im = g (Ψ (Φ (ζ s))).re
      rw [hΨΦ]
      exact (hgraph _ (hζmem s hs).2).1 (hζmem s hs).1
    · intro heq
      have hz : Ψ p ∈ Zf ∩ (Ioo a b ×ℂ Ioo (-h₁) h₁) := ⟨(hgraph _ hp).2 heq, hp⟩
      rw [← hζimg] at hz
      obtain ⟨s, hs, hsz⟩ := hz
      exact ⟨s, hs, by show Φ (ζ s) = p; rw [hsz, hΦΨ]⟩
  have hbdry : essBoundary A ∩ Ψ ⁻¹' (Ioo a b ×ℂ Ioo (-h₁) h₁) = (fun s => Φ (ζ s)) '' Ioo (-ℓ) ℓ := by
    ext p
    constructor
    · rintro ⟨hpA, hpbox⟩
      refine (hcurve p hpbox).2 ((hgraph _ hpbox).1 ?_)
      show Φ (Ψ p) ∈ essBoundary A ∩ U
      rw [hΦΨ]; exact ⟨hpA, hQU hpbox⟩
    · rintro ⟨s, hs, rfl⟩
      exact ⟨(hζmem s hs).1.1, by
        show Ψ (Φ (ζ s)) ∈ Ioo a b ×ℂ Ioo (-h₁) h₁
        rw [hΨΦ]; exact (hζmem s hs).2⟩
  have hopen : ∀ σ : ℝ, IsOpen (Ψ ⁻¹' {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h₁) h₁ ∧ 0 < σ * (z.im - g z.re)}) :=
    fun σ => by
      refine IsOpen.preimage hΨc ?_
      have hcont : ContinuousOn (fun z : ℂ => σ * (z.im - g z.re)) (Ioo a b ×ℂ Ioo (-h₁) h₁) :=
        continuousOn_const.mul (Complex.continuous_im.continuousOn.sub
          (hgc.comp Complex.continuous_re.continuousOn fun z hz => (Complex.mem_reProdIm.1 hz).1))
      exact hcont.isOpen_inter_preimage (isOpen_Ioo.reProdIm isOpen_Ioo) isOpen_Ioi
  have hconn : ∀ σ : ℝ, σ = 1 ∨ σ = -1 →
      IsConnected (Ψ ⁻¹' {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h₁) h₁ ∧ 0 < σ * (z.im - g z.re)}) := fun σ hσ => by
    rw [hpre]
    exact (isConnected_graph_side (ha0.trans hb0) hh hσ hgh).image Φ hΦc.continuousOn
  have hsideU : ∀ σ : ℝ, Ψ ⁻¹' {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h₁) h₁ ∧ 0 < σ * (z.im - g z.re)} ⊆
      Ψ ⁻¹' (Ioo a b ×ℂ Ioo (-h₁) h₁) := fun σ p hp => hp.1
  have hsideb : ∀ σ : ℝ, ∀ p ∈ Ψ ⁻¹' {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h₁) h₁ ∧ 0 < σ * (z.im - g z.re)},
      p ∉ essBoundary A := fun σ p hp hpA => by
    have h1 := (hcurve p hp.1).1 (hbdry ▸ (⟨hpA, hp.1⟩ : p ∈ essBoundary A ∩ Ψ ⁻¹' (Ioo a b ×ℂ Ioo (-h₁) h₁)))
    have h2 : 0 < σ * ((Ψ p).im - g (Ψ p).re) := hp.2
    rw [h1, sub_self, mul_zero] at h2
    exact lt_irrefl _ h2
  have hg0 := hgh 0 ⟨ha0, hb0⟩
  rw [abs_lt] at hg0
  have hanchor : ∀ σ : ℝ, σ = 1 ∨ σ = -1 → Φ (((0 : ℝ) : ℂ) + ((σ * (3 * h₁ / 4) : ℝ) : ℂ) * I) ∈
      Ψ ⁻¹' {z : ℂ | z ∈ Ioo a b ×ℂ Ioo (-h₁) h₁ ∧ 0 < σ * (z.im - g z.re)} := fun σ hσ => by
    rw [mem_preimage, hΨΦ]
    refine ⟨?_, ?_⟩
    · rw [Complex.mem_reProdIm]
      rcases hσ with rfl | rfl <;> simp <;> exact ⟨⟨ha0, hb0⟩, by linarith, by linarith⟩
    · rcases hσ with rfl | rfl <;> simp <;> linarith
  refine ⟨Ψ ⁻¹' (Ioo a b ×ℂ Ioo (-h₁) h₁), fun s => Φ (ζ s), fun s => θ₀ + φ s, ℓ, hQU,
    hℓ, (isOpen_Ioo.reProdIm isOpen_Ioo).preimage hΨc, ?_, hQU.trans hUN, ⟨fun s hs => ?_, ?_⟩, ?_, ?_, hbdry,
    fun s hs => ?_, ?_⟩
  · show Ψ y ∈ Ioo a b ×ℂ Ioo (-h₁) h₁
    have : Ψ y = 0 := by simp only [hΨ]; rw [sub_self, zero_mul]
    rw [this, Complex.mem_reProdIm]
    exact ⟨⟨ha0, hb0⟩, by simp only [Complex.zero_im]; exact ⟨by linarith, hh⟩⟩
  · have h1 := (((hζd s hs).1.mul_const τ₀).const_add y).hasDerivWithinAt (s := Ioo (-ℓ) ℓ)
    rw [e_add, hθ₀, mul_comm]
    exact h1
  · rw [lipschitzOnWith_iff_dist_le_mul] at hφlip ⊢
    intro s hs s' hs'
    simpa using hφlip s hs s' hs'
  · show Φ (ζ 0) = y
    rw [hζ0, hΦy]
  · intro s hs s' hs' heq
    refine hζinj hs hs' ?_
    rw [← hΨΦ (ζ s), ← hΨΦ (ζ s')]
    exact congrArg Ψ heq
  · show HasTwoDiscsAt A B N (Φ (ζ s)) (I * e (θ₀ + φ s))
    have e1 : I * e (θ₀ + φ s) = n (ζ s) * τ₀ := by rw [← (hζd s hs).2, e_add, hθ₀]; ring
    rw [e1]
    exact hZd _ (hζmem s hs).1
  · refine ⟨_, _, hopen (-1) , hopen 1, hconn (-1) (Or.inr rfl), hconn 1 (Or.inl rfl), ?_, ?_, ?_⟩
    · ext p
      constructor
      · rintro ⟨hpbox, hpc⟩
        have hne : (Ψ p).im ≠ g (Ψ p).re := fun heq => hpc ((hcurve p hpbox).2 heq)
        rcases lt_or_gt_of_ne hne with hlt | hgt
        · exact Or.inl ⟨hpbox, by linarith⟩
        · exact Or.inr ⟨hpbox, by linarith⟩
      · rintro (hp | hp)
        · refine ⟨hp.1, fun hc => ?_⟩
          have h1 := (hcurve p hp.1).1 hc
          have h2 : 0 < (-1 : ℝ) * ((Ψ p).im - g (Ψ p).re) := hp.2
          rw [h1] at h2; linarith
        · refine ⟨hp.1, fun hc => ?_⟩
          have h1 := (hcurve p hp.1).1 hc
          have h2 : 0 < (1 : ℝ) * ((Ψ p).im - g (Ψ p).re) := hp.2
          rw [h1] at h2; linarith
    · refine h.symm.ae_le_of_isPreconnected hB hA (hconn (-1) (Or.inr rfl)).isPreconnected
        ((hsideU (-1)).trans (hQU.trans hUN)) (fun x hx => (hcusp x (hQU (hsideU (-1) hx))).symm)
        (fun x hx hxB => hsideb (-1) x hx (hkey.superset ⟨hxB, hUN (hQU (hsideU (-1) hx))⟩).1)
        (hanchor (-1) (Or.inr rfl)) ?_
      refine (hν₀.subset_interior_densitySet h.isOpen).2 ⟨?_, hUN (hQU (hsideU (-1) (hanchor (-1) (Or.inr rfl))))⟩
      have := hbot 0 (-1 * (3 * h₁ / 4)) (by nlinarith)
      simpa using this
    · refine h.ae_le_of_isPreconnected hA hB (hconn 1 (Or.inl rfl)).isPreconnected
        ((hsideU 1).trans (hQU.trans hUN)) (fun x hx => hcusp x (hQU (hsideU 1 hx)))
        (fun x hx => hsideb 1 x hx) (hanchor 1 (Or.inl rfl)) ?_
      refine (hν₀.subset_interior_densitySet h.isOpen).1 ⟨?_, hUN (hQU (hsideU 1 (hanchor 1 (Or.inl rfl))))⟩
      have := htop 0 (1 * (3 * h₁ / 4)) (by nlinarith)
      simpa using this

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

/-! ## The inhabitant of `local_graph`: `sq9` at the edge point -/

/-- **No cusp of the two classes in the edge ball of `sq9`** (owed by `local_graph`'s inhabitant note): on its own
closed side a class has positive upper density (`sq9Sq_subset_essClosure`), and strictly on the other side it is
absent near the point. -/
theorem sq9_not_isCuspAt_near_edge {x : ℂ} (hx : x ∈ ball sqEdgePt (1 / 8)) :
    ¬ IsCuspAt (sq9.cls sqColA) x ∧ ¬ IsCuspAt (sq9.cls sqColB) x := by
  obtain ⟨hre, him⟩ := sqEdge_coords hx
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  have hfar : ∀ (col : Fin 9) (s : ℝ),
      (∀ z ∈ ball sqEdgePt (1 / 8), 0 < s * (z.re - 1 / 2) → sq9Col z ≠ col) → (s = 1 ∨ s = -1) →
      0 < s * (x.re - 1 / 2) → x ∉ essSupport (sq9.cls col) := by
    intro col s hcol hs hpos hsupp
    have hxd : dist x sqEdgePt < 1 / 8 := hx
    have hr : 0 < min (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt) := lt_min hpos (by linarith)
    have hempty : sq9.cls col ∩ ball x (min (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt)) = ∅ := by
      ext z
      simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
      intro hzc hz
      rw [mem_ball] at hz
      have hzb : z ∈ ball sqEdgePt (1 / 8) := by
        rw [mem_ball]
        linarith [dist_triangle z x sqEdgePt, min_le_right (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt)]
      refine hcol z hzb ?_ hzc
      have h5 := Complex.abs_re_le_norm (z - x)
      rw [← dist_eq_norm, Complex.sub_re, abs_le] at h5
      have h6 := min_le_left (s * (x.re - 1 / 2)) (1 / 8 - dist x sqEdgePt)
      rcases hs with rfl | rfl <;> linarith [h5.1, h5.2]
    have := hsupp _ hr
    rw [hempty, measure_empty] at this
    exact lt_irrefl _ this
  constructor
  · rintro ⟨hs, hn⟩
    rcases le_or_gt x.re (1 / 2) with hle | hgt
    · refine hn ?_
      have := sq9Sq_subset_essClosure 0 0 (show x ∈ sq9Sq 0 0 from
        ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩)
      simpa [sqColA] using this
    · exact hfar sqColA 1 (fun z hz hpos => by
        rw [sq9Col_near_edge hz, if_neg (by linarith)]; exact sqColA_ne_sqColB.symm) (Or.inl rfl) (by linarith) hs
  · rintro ⟨hs, hn⟩
    rcases le_or_gt (1 / 2) x.re with hle | hgt
    · refine hn ?_
      have := sq9Sq_subset_essClosure 1 0 (show x ∈ sq9Sq 1 0 from
        ⟨by push_cast; linarith, by push_cast; linarith, by push_cast; linarith, by push_cast; linarith⟩)
      simpa [sqColB] using this
    · exact hfar sqColB (-1) (fun z hz hpos => by
        rw [sq9Col_near_edge hz, if_pos (by linarith)]; exact sqColA_ne_sqColB) (Or.inr rfl) (by linarith) hs

/-- The edge point is an essential boundary point of the left-hand class: both squares have positive upper density
there. -/
theorem sqEdgePt_mem_essBoundary : sqEdgePt ∈ essBoundary (sq9.cls sqColA) := by
  have hA : sqEdgePt ∈ essClosure (sq9.cls sqColA) := by
    have := sq9Sq_subset_essClosure 0 0 (show sqEdgePt ∈ sq9Sq 0 0 from by
      refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [sqEdgePt])
    simpa [sqColA] using this
  have hB : sqEdgePt ∈ essClosure (sq9.cls sqColB) := by
    have := sq9Sq_subset_essClosure 1 0 (show sqEdgePt ∈ sq9Sq 1 0 from by
      refine ⟨?_, ?_, ?_, ?_⟩ <;> norm_num [sqEdgePt])
    simpa [sqColB] using this
  exact ⟨hA, fun hd => notMem_essClosure_of_mem_densitySet (sq9.measurableSet_cls _)
    (sq9.pairwise_disjoint_cls sqColA_ne_sqColB) hd hB⟩

/-- **Inhabitant of `local_graph`**: `sq9` at the edge point, `N = U = B(sqEdgePt, 1/8)` — every hypothesis at
once (`sq9_twoColourNhd`, no cusp in the ball, saturated by `sq9_tight_saturated`), so the theorem gives a chart of the
edge there. -/
theorem sq9_exists_isInterfaceChart : ∃ Q γ ψ h', Q ⊆ ball sqEdgePt (1 / 8) ∧
    IsInterfaceChart (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt Q γ ψ h' :=
  local_graph (sq9.measurableSet_cls _) (sq9.unitPairsNull _) (sq9.measurableSet_cls _) (sq9.unitPairsNull _)
    sq9_twoColourNhd.two isOpen_ball Subset.rfl (fun _ hx => sq9_not_isCuspAt_near_edge hx)
    (fun x hx => sq9_tight_saturated.2.1 _ x hx.1) (fun x hx => sq9_tight_saturated.2.1 _ x hx.1)
    ⟨sqEdgePt_mem_essBoundary, sqEdgePt_mem_ball⟩

end HadwigerNelson.Plane
