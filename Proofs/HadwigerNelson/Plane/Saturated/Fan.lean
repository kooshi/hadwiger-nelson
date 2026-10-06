import Proofs.HadwigerNelson.Plane.Saturated.Basic

/-!
# The fan at a singular point; REG-J′ in its two forms (FS-131 wave 6)

`data/fs121/claims.md`, the close's note to § 0: "a disc `B(z, r)` whose only point of Σ is `z`, in which the essential
boundary is the finitely many interface arcs at `z`; every region of the fan is an open set a.e. of one colour; a region
of positive angle has an open arc of directions, a zero-angle region none and one tangent direction."
(`plans/FS131-w6-kernel-plan.md` §§ 6, 10.)

* `polarGraph z r φ`, `polarRegion z r φ ψ`, `cyclicNext φ i` — a branch `{z + t e(φ t) : 0 < t < r}`, the open region
  between two branches, and the branch after `i` counter-clockwise (the first one a turn on, after the last).
* `c.Fan z` — the structure: a radius, `n` branches as polar graphs with limit directions `dir i`, in counter-clockwise
  order; `z` the only possible point of `Σ` in the disc; the essential boundary off `z` exactly the branches; the region
  counter-clockwise of branch `i` almost everywhere of the colour `col i`.
* `F.nextDir i`, `F.HasSector j` (a region of colour `j` of positive angle), `F.HasHorn j` (one of zero angle).
* `c.SingLocallyFinite` (`Σ` is locally finite), `c.arcsAt z`, `c.RegJLiteral` (REG-J′'s frozen words), `c.RegJFan`
  (the fan form every consumer reads).

**What a fan does not carry, and why.** Two facts FS-121's rows read at a branch — it stays outside the two open unit
discs tangent to its limit direction at `z`, and the contacts of its points converge to `z ± i e(dir i)` — hold under
saturation in the punctured disc and fail without it (a polygonal colouring has fans and no curvature bound). They are
theorems about any fan (`Plane/Saturated/FanBridge`: `Fan.branch_outside_discs`, `Fan.branch_contacts`), not fields.

**Under saturation `RegJFan` is equivalent to `SingLocallyFinite`**, by FS131-E8-BRIDGE ([hand], one mind, until
`Plane/Saturated/FanBridge` lands): `regJFan_of_saturated`.

**Inhabitant.** `sq9Fan` (`Plane/Saturated/FanExamples`): `sq9` at the grid vertex `1/2 + i/2`, four branches along
the axes with constant angles, four colours, four sectors of angle `π/2`, no horn.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## Polar graphs and regions -/

/-- The **polar graph** of `φ` about `z` out to `r`: the points `z + t e(φ t)`, `0 < t < r`. -/
def polarGraph (z : ℂ) (r : ℝ) (φ : ℝ → ℝ) : Set ℂ := {w | ∃ t ∈ Ioo 0 r, w = polarPt z t (φ t)}

/-- The open **polar region** between the graphs of `φ` and `ψ` about `z` out to `r`: the points `z + t e θ`,
`0 < t < r`, `φ t < θ < ψ t`. -/
def polarRegion (z : ℂ) (r : ℝ) (φ ψ : ℝ → ℝ) : Set ℂ := {w | ∃ t ∈ Ioo 0 r, ∃ θ ∈ Ioo (φ t) (ψ t), w = polarPt z t θ}

/-- The angle function after `i`, counter-clockwise: the next one, or the first one a turn on after the last. -/
noncomputable def cyclicNext {n : ℕ} (φ : Fin n → ℝ → ℝ) (i : Fin n) (t : ℝ) : ℝ :=
  if h : (i : ℕ) + 1 < n then φ ⟨i + 1, h⟩ t else φ ⟨0, i.pos⟩ t + 2 * Real.pi

/-- A point at polar distance `t ≥ 0` from `z` is at distance `t`. -/
theorem dist_polarPt (z : ℂ) {t : ℝ} (ht : 0 ≤ t) (θ : ℝ) : dist (polarPt z t θ) z = t := by
  rw [dist_eq_norm, norm_polarPt_sub, abs_of_nonneg ht]

/-- The real part of a point in polar form. -/
theorem polarPt_re (p : ℂ) (ρ ψ : ℝ) : (polarPt p ρ ψ).re = p.re + ρ * Real.cos ψ := by
  simp [polarPt, re_e]

/-- The imaginary part of a point in polar form. -/
theorem polarPt_im (p : ℂ) (ρ ψ : ℝ) : (polarPt p ρ ψ).im = p.im + ρ * Real.sin ψ := by
  simp [polarPt, im_e]

/-- Spec: a polar graph out to `r` lies in the punctured disc of radius `r`. -/
theorem polarGraph_subset (z : ℂ) (r : ℝ) (φ : ℝ → ℝ) : polarGraph z r φ ⊆ ball z r \ {z} := by
  rintro w ⟨t, ht, rfl⟩
  refine ⟨by rw [mem_ball, dist_polarPt z ht.1.le]; exact ht.2, fun h => ?_⟩
  have h1 := dist_polarPt z ht.1.le (φ t)
  rw [mem_singleton_iff.1 h, dist_self] at h1
  exact ht.1.ne h1

/-- Spec: a polar region out to `r` lies in the punctured disc of radius `r`. -/
theorem polarRegion_subset (z : ℂ) (r : ℝ) (φ ψ : ℝ → ℝ) : polarRegion z r φ ψ ⊆ ball z r \ {z} := by
  rintro w ⟨t, ht, θ, -, rfl⟩
  refine ⟨by rw [mem_ball, dist_polarPt z ht.1.le]; exact ht.2, fun h => ?_⟩
  have h1 := dist_polarPt z ht.1.le θ
  rw [mem_singleton_iff.1 h, dist_self] at h1
  exact ht.1.ne h1

/-- Spec: before the last branch, the next one. -/
theorem cyclicNext_of_lt {n : ℕ} (φ : Fin n → ℝ → ℝ) {i : Fin n} (h : (i : ℕ) + 1 < n) (t : ℝ) :
    cyclicNext φ i t = φ ⟨i + 1, h⟩ t := by
  rw [cyclicNext, dif_pos h]

/-- Spec: after the last branch comes the first, a turn on. -/
theorem cyclicNext_of_not_lt {n : ℕ} (φ : Fin n → ℝ → ℝ) {i : Fin n} (h : ¬ (i : ℕ) + 1 < n) (t : ℝ) :
    cyclicNext φ i t = φ ⟨0, i.pos⟩ t + 2 * Real.pi := by
  rw [cyclicNext, dif_neg h]

/-! ## Two tools for inhabitants -/

/-- A density point of a measurable set is not in the essential closure of a set disjoint from it. -/
theorem notMem_essClosure_of_mem_densitySet {A B : Set ℂ} (hA : MeasurableSet A) (hAB : Disjoint A B) {x : ℂ}
    (hx : x ∈ densitySet A) : x ∉ essClosure B := by
  have h0 := tendsto_densityRatio_compl_of_mem hA hx
  have hle : ∀ r, densityRatio B x r ≤ densityRatio Aᶜ x r := fun r =>
    ENNReal.div_le_div_right (measure_mono (inter_subset_inter_left _ hAB.subset_compl_left)) _
  have h1 : upperDensityAt B x ≤ 0 := by
    rw [upperDensityAt, ← h0.limsup_eq]
    exact limsup_le_limsup (Eventually.of_forall hle)
  intro hB
  exact lt_irrefl _ (lt_of_lt_of_le hB h1)

/-- **A convex open set cut into two colours** is a two-colour neighbourhood: if `N` is open and convex, `H₁`, `H₂`
are open and convex, `N ∖ (H₁ ∪ H₂)` is null, and the colouring is `a` on `N ∩ H₁` and `b ≠ a` on `N ∩ H₂` (both
non-empty), then (H1), (H2) hold on `N` for `a`, `b`. -/
theorem AeColouring.twoColourNhd_of_halves (c : AeColouring k) {N H₁ H₂ : Set ℂ} (hN : IsOpen N)
    (hNc : Convex ℝ N) (hH₁o : IsOpen H₁) (hH₂o : IsOpen H₂) (hH₁c : Convex ℝ H₁) (hH₂c : Convex ℝ H₂)
    (hne₁ : (N ∩ H₁).Nonempty) (hne₂ : (N ∩ H₂).Nonempty) (hnull : volume (N \ (H₁ ∪ H₂)) = 0) {a b : Fin k}
    (hab : a ≠ b) (h₁ : N ∩ H₁ ⊆ c.cls a) (h₂ : N ∩ H₂ ⊆ c.cls b) : TwoColourNhd c.cls N a b := by
  have key : ∀ {j j' : Fin k} {H H' : Set ℂ}, IsOpen H → Convex ℝ H → (N ∩ H).Nonempty → N ∩ H ⊆ c.cls j →
      N ∩ H' ⊆ c.cls j' → j ≠ j' → volume (N \ (H ∪ H')) = 0 → H2On (c.cls j) N := by
    intro j j' H H' hHo hHc hne hj hj' hjj' hnull'
    refine ⟨N ∩ H, hN.inter hHo, ⟨hne, (hNc.inter hHc).isPreconnected⟩,
      subset_densitySet_of_isOpen_ae_subset (hN.inter hHo) (Eventually.of_forall hj), ?_⟩
    rw [ae_eq_set]
    constructor
    · refine measure_mono_null ?_ hnull'
      rintro z ⟨⟨hzj, hzN⟩, hzn⟩
      refine ⟨hzN, ?_⟩
      rintro (hzH | hzH')
      · exact hzn ⟨hzN, hzH⟩
      · exact hjj' ((show c.col z = j from hzj).symm.trans (show c.col z = j' from hj' ⟨hzN, hzH'⟩))
    · have hempty : (N ∩ H) \ (c.cls j ∩ N) = ∅ :=
        Set.sdiff_eq_empty.2 fun z hz => (⟨hj hz, hz.1⟩ : z ∈ c.cls j ∩ N)
      rw [hempty, measure_empty]
  refine c.twoColourNhd_of_h1 hN hab ?_ (key hH₁o hH₁c hne₁ h₁ h₂ hab hnull)
    (key hH₂o hH₂c hne₂ h₂ h₁ hab.symm (by rwa [union_comm]))
  intro j hja hjb
  refine measure_mono_null ?_ hnull
  rintro z ⟨hzj, hzN⟩
  refine ⟨hzN, ?_⟩
  rintro (hz | hz)
  · exact hja ((show c.col z = j from hzj).symm.trans (show c.col z = a from h₁ ⟨hzN, hz⟩))
  · exact hjb ((show c.col z = j from hzj).symm.trans (show c.col z = b from h₂ ⟨hzN, hz⟩))

namespace AeColouring

/-! ## The singular set locally finite; the frozen words -/

/-- **`Σ` is locally finite**: every point has a ball holding finitely many singular points. (REG-J′'s first clause;
C121-REGJ's open question, FS-127.) -/
def SingLocallyFinite (c : AeColouring k) : Prop := ∀ x : ℂ, ∃ r > 0, (c.singularSet ∩ ball x r).Finite

/-- The **interface arcs meeting `z`**: the connected components of `𝓘` with `z` in their closure. -/
def arcsAt (c : AeColouring k) (z : ℂ) : Set (Set ℂ) :=
  {A | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧ z ∈ closure A}

/-- **REG-J′, the frozen words** (`data/fs111/claims.md` § 6; `data/fs121/claims.md` § 0): `Σ` is locally finite, and
each point of `Σ` meets finitely many interface arcs. Under saturation the second clause follows from the first
(FS131-E8-CLAUSE2). -/
def RegJLiteral (c : AeColouring k) : Prop := c.SingLocallyFinite ∧ ∀ z ∈ c.singularSet, (c.arcsAt z).Finite

/-! ## The fan -/

/-- A **fan** at `z` (`data/fs121/claims.md`, the close's note to § 0): a disc `B(z, r)` whose only possible point of
`Σ` is `z`, in which the essential boundary off `z` is `n` branches, branch `i` the polar graph
`{z + t e(φ i t) : 0 < t < r}` with limit direction `dir i`, in counter-clockwise order; the region counter-clockwise
of branch `i` is almost everywhere of the colour `col i`. -/
structure Fan (c : AeColouring k) (z : ℂ) where
  /-- The radius of the disc. -/
  r : ℝ
  /-- The radius is positive. -/
  r_pos : 0 < r
  /-- The number of branches. -/
  n : ℕ
  /-- The angle of branch `i` at distance `t` from `z`. -/
  φ : Fin n → ℝ → ℝ
  /-- The limit direction of branch `i` at `z` (its end tangent). -/
  dir : Fin n → ℝ
  /-- The colour of the region counter-clockwise of branch `i`. -/
  col : Fin n → Fin k
  /-- Each branch is a continuous polar graph. -/
  cont : ∀ i, ContinuousOn (φ i) (Ioo 0 r)
  /-- Each branch has a limit direction at `z`. -/
  tendsto : ∀ i, Tendsto (φ i) (𝓝[>] 0) (𝓝 (dir i))
  /-- At every distance the branches are in counter-clockwise order. -/
  mono : ∀ t ∈ Ioo 0 r, StrictMono fun i => φ i t
  /-- At every distance the branches lie within one turn. -/
  wrap : ∀ t ∈ Ioo 0 r, ∀ i j, φ i t < φ j t + 2 * Real.pi
  /-- `z` is the only possible singular point of the disc. -/
  singular : c.singularSet ∩ ball z r ⊆ {z}
  /-- The essential boundary in the punctured disc is exactly the branches. -/
  bdry : c.essBdry ∩ (ball z r \ {z}) = ⋃ i, polarGraph z r (φ i)
  /-- The region counter-clockwise of branch `i` is almost everywhere of the colour `col i`. -/
  region : ∀ i, (polarRegion z r (φ i) (cyclicNext φ i) : Set ℂ) ≤ᵐ[volume] c.cls (col i)

/-- **REG-J′, the fan form with end tangents** (the hypothesis wave 6's rows take): `Σ` is locally finite and every
point of `Σ` has a fan. Under saturation equivalent to `Σ` being locally finite, by FS131-E8-BRIDGE. -/
def RegJFan (c : AeColouring k) : Prop := c.SingLocallyFinite ∧ ∀ z ∈ c.singularSet, Nonempty (c.Fan z)

/-- Spec: the fan form's first clause is the frozen words' first clause. -/
theorem RegJFan.singLocallyFinite {c : AeColouring k} (h : c.RegJFan) : c.SingLocallyFinite := h.1

/-- Spec: the frozen words' first clause. -/
theorem RegJLiteral.singLocallyFinite {c : AeColouring k} (h : c.RegJLiteral) : c.SingLocallyFinite := h.1

/-- Spec: where `Σ` is locally finite, every point has a ball holding no singular point but itself. -/
theorem SingLocallyFinite.exists_ball_subset {c : AeColouring k} (h : c.SingLocallyFinite) (z : ℂ) :
    ∃ R > 0, c.singularSet ∩ ball z R ⊆ {z} := by
  obtain ⟨r, hr, hfin⟩ := h z
  have hS : IsClosed ((c.singularSet ∩ ball z r) \ {z}) := (hfin.subset sdiff_subset).isClosed
  have hz' : z ∈ ((c.singularSet ∩ ball z r) \ {z})ᶜ := fun h => h.2 rfl
  obtain ⟨R, hR, hRsub⟩ := Metric.isOpen_iff.1 hS.isOpen_compl z hz'
  refine ⟨min R r, lt_min hR hr, ?_⟩
  rintro y ⟨hyS, hyb⟩
  by_contra hyz
  rw [mem_ball] at hyb
  exact hRsub (by rw [mem_ball]; exact lt_of_lt_of_le hyb (min_le_left _ _))
    ⟨⟨hyS, by rw [mem_ball]; exact lt_of_lt_of_le hyb (min_le_right _ _)⟩, hyz⟩

namespace Fan

variable {c : AeColouring k} {z : ℂ} (F : c.Fan z)

/-- Branch `i` of the fan, as a set. -/
def branch (i : Fin F.n) : Set ℂ := polarGraph z F.r (F.φ i)

/-- The region counter-clockwise of branch `i`, as a set. -/
def cell (i : Fin F.n) : Set ℂ := polarRegion z F.r (F.φ i) (cyclicNext F.φ i)

/-- The limit direction of the branch after `i`, counter-clockwise (the first branch's, a turn on, after the last). -/
noncomputable def nextDir (i : Fin F.n) : ℝ := cyclicNext (fun j _ => F.dir j) i 0

/-- The colour `j` **occupies a sector of positive angle** at `z`: a region of colour `j` between branches of
different limit directions. -/
def HasSector (j : Fin k) : Prop := ∃ i, F.col i = j ∧ F.dir i < F.nextDir i

/-- The colour `j` occupies a **zero-angle region** (a horn) at `z`: one between branches of one limit direction. -/
def HasHorn (j : Fin k) : Prop := ∃ i, F.col i = j ∧ F.dir i = F.nextDir i

/-- Every branch lies in the essential boundary, off `z`, inside the disc. -/
theorem branch_subset (i : Fin F.n) : F.branch i ⊆ c.essBdry ∩ (ball z F.r \ {z}) := by
  rw [F.bdry]
  exact subset_iUnion (fun i => polarGraph z F.r (F.φ i)) i

/-- A point of a branch is an interface point. -/
theorem branch_subset_interfaceSet (i : Fin F.n) : F.branch i ⊆ c.interfaceSet := by
  intro w hw
  obtain ⟨hwb, hwball, hwz⟩ := F.branch_subset i hw
  exact ⟨hwb, fun hS => hwz (F.singular ⟨hS, hwball⟩)⟩

/-- At every distance the next branch counter-clockwise is strictly further round. -/
theorem φ_lt_cyclicNext (i : Fin F.n) {t : ℝ} (ht : t ∈ Ioo 0 F.r) : F.φ i t < cyclicNext F.φ i t := by
  by_cases h : (i : ℕ) + 1 < F.n
  · rw [cyclicNext_of_lt _ h]
    exact F.mono t ht (Fin.lt_def.2 (Nat.lt_succ_self _))
  · rw [cyclicNext_of_not_lt _ h]
    exact F.wrap t ht i _

/-- The next branch's angle tends to the next limit direction. -/
theorem tendsto_cyclicNext (i : Fin F.n) : Tendsto (cyclicNext F.φ i) (𝓝[>] 0) (𝓝 (F.nextDir i)) := by
  by_cases h : (i : ℕ) + 1 < F.n
  · have h1 : cyclicNext F.φ i = F.φ ⟨i + 1, h⟩ := funext fun t => cyclicNext_of_lt _ h t
    rw [h1, nextDir, cyclicNext_of_lt _ h]
    exact F.tendsto _
  · have h1 : cyclicNext F.φ i = fun t => F.φ ⟨0, i.pos⟩ t + 2 * Real.pi := funext fun t => cyclicNext_of_not_lt _ h t
    rw [h1, nextDir, cyclicNext_of_not_lt _ h]
    exact (F.tendsto _).add_const _

/-- The limit directions are in counter-clockwise order, weakly: a region has a non-negative angle. -/
theorem dir_le_nextDir (i : Fin F.n) : F.dir i ≤ F.nextDir i := by
  refine le_of_tendsto_of_tendsto (F.tendsto i) (F.tendsto_cyclicNext i) ?_
  filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht
  exact (F.φ_lt_cyclicNext i ht).le

/-- Spec for `HasSector`, `HasHorn`: every region is a sector of positive angle or a horn. -/
theorem hasSector_or_hasHorn (i : Fin F.n) : F.HasSector (F.col i) ∨ F.HasHorn (F.col i) :=
  (F.dir_le_nextDir i).lt_or_eq.imp (fun h => ⟨i, rfl, h⟩) (fun h => ⟨i, rfl, h⟩)

end Fan

end AeColouring

end HadwigerNelson.Plane
