import Proofs.HadwigerNelson.Plane.ValidMap.BendStep

/-!
# The arc step from the clauses a bend exports (FS131-IA2)

`exists_arcStep` (`Plane/ValidMap/Procedure`) bends one maximal bad unit arc `α = r([θ₁, θ₂])` of `ω(P)` off its circle: toward `P` when
the outer colour is not carried at `P` (the collar bend, `CollarFit`), away from `P` when the inner colour is not (`bend_away_part`).
This module proves the step's clauses **once, over the clauses a bend exports** (`ArcBend`), upstream of `Procedure`
(`plans/FS131-arcstep-implementation.md`, FS131-IA2's stages):

* **The interface** `ArcBend F M h K P θ₁ θ₂ c c' g ε`: the bent map `M`, the homeomorphism `h`, the collar `K`, the gaining colour `g`
  — the weakest clauses the step reads. The toward collar bend supplies it with `g = c'` (`CollarFit.arcBend`), the away bend's
  conclusion with `g = c` (`ArcBend.of_away`).
* **The step's clauses from the interface** (`ArcBend.arcStep`): the bent map is valid and clean, a local step on the closed
  `ε`-neighbourhood of the arc, a modification, creates no site, raises no degree at a point off the collar or on the closed arc and no
  horn count anywhere, and adds no colour at such a point.
* **The two count clauses at the ring-arc level** (`ArcBend.maxBad`, `maxBad_centre`, `maxBad_other`): a maximal bad unit arc of the bent
  map is one of `F`, with its open arc off `α°`. `IsMaxRingArc` and `badCount` are `Procedure`'s, downstream: the maximality is read
  here in its unfolded form, and what `Procedure` adds is the point-set form of `α`'s maximality (a ring arc about `P` meeting `α°` has
  `α`'s sides and lies in `α`) and the `encard` step.
* **Owed lemmas of FS131-IA1's work list**: the colours, degree and repeated colour at a point of an open ring arc
  (`IsRingArc.coloursAt_openArc`, `IsRingArc.degree_openArc`); a unit arc about another centre misses the open arc
  (`IsRingArc.disjoint_openArc_of_ne`, W4); a horn at a point iff its horn count is at least `1` (`exists_hasHornCount_isHorn_iff`, W6);
  the step's radius (`exists_arcStep_radius`); the local step of a cut (`LocalStep.of_cutArcs`, W1 and W2 as one statement, FS131-KA1's
  text).

**Models.** `ArcBend`: the collar bend of `l60Frag` at `collarModel` (the spec example at the end), which rests on the open child
`CollarFit.map_hornCount_le` (`BendStep`). No Lean model is named for a clean map carrying a ring arc (the hypothesis `hc` with `ring`),
as in `BendStep`'s header: an open gate item, owed with the arc step's model (inventory ruling 427 (d)).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The interface: what the arc step reads from a bend -/

/-- **The clauses the arc step reads from a bend** of the unit arc `α = r([θ₁, θ₂])` of `ω(P)`, sides `c` (inner) and `c'` (outer): a
bent map `M`, a homeomorphism `h` of the plane and a collar `K` within `ε` of the arc and inside the domain, meeting `Γ` only on the
arc, with `g`, one of the two side colours, the colour that gains. `M` is valid and a local step on `K`; `h` is the identity off `K`,
fixes `Γ` off the open arc, carries interior points to interior points, the colours at each point, degrees forward and repeated
colours back; no horn count rises; no unit arc is created (`ringArcsWithin`), the constant-sided unit arcs of `M` are `F`'s (`R1`) and
`F`'s whose open arc misses `α°` survive (`R2`); each interior point of `α` is fixed or becomes an interior point of colour `g`
(`gain`); and an interior point of `α` still on a unit arc of `M` about `P` has the (R2) kind — outer colour at `P`, inner colour not,
and its radius-2 point in the closure of the inner colour's class (`left`).

Neither the collar's compactness nor `h K ⊆ K` is read by the step. Inhabitants: `CollarFit.arcBend` (the toward collar bend, `g = c'`,
where `left` is vacuous) and `ArcBend.of_away` (the away bend's conclusion, `g = c`). -/
structure ArcBend (F M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' g : Fin k) (ε : ℝ) : Prop where
  /-- The arc is a constant-sided unit arc of `F`. -/
  ring : F.IsRingArc P θ₁ θ₂ c c'
  /-- The gaining colour is a side colour. -/
  side : g = c ∨ g = c'
  /-- The bent map is valid. -/
  valid : M.Valid
  /-- The collar lies within `ε` of the arc. -/
  sub_thick : K ⊆ thickening ε (ringArc P θ₁ θ₂)
  /-- The collar lies in the domain. -/
  sub_dom : K ⊆ F.dom
  /-- The collar meets `Γ` only on the arc. -/
  free : F.Γ ∩ K ⊆ ringArc P θ₁ θ₂
  /-- The bend is a local step on the collar. -/
  step : LocalStep F M K
  /-- The homeomorphism is the identity off the collar. -/
  fix_off : ∀ z ∉ K, h z = z
  /-- It fixes `Γ` off the open arc. -/
  fix_Γ : ∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z
  /-- It carries interior points to interior points. -/
  interior : ∀ z ∈ F.interiorPts, h z ∈ M.interiorPts
  /-- It carries the colours at each point. -/
  coloursAt : ∀ z, M.coloursAt (h z) = F.coloursAt z
  /-- It carries degrees. -/
  degree : ∀ z n, F.HasDegree z n → M.HasDegree (h z) n
  /-- A repeated colour of the bent map comes from one of `F`. -/
  repeated : ∀ z, M.HasRepeatedColour (h z) → F.HasRepeatedColour z
  /-- No horn count rises. -/
  horn : ∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j'
  /-- No unit arc is created. -/
  ringArcsWithin : M.RingArcsWithin F
  /-- R1: a constant-sided unit arc of the bent map is one of `F`, with the same sides. -/
  R1 : ∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d'
  /-- R2: a constant-sided unit arc of `F` whose open arc misses `α°` survives. -/
  R2 : ∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) → M.IsRingArc Q a b d d'
  /-- An interior point of the arc is fixed, or becomes an interior point of the gaining colour. -/
  gain : ∀ θ ∈ Ioo θ₁ θ₂, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region g
  /-- What is left of `α°` on a unit arc of the bent map about `P` has the (R2) kind. -/
  left : ∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) →
    c' ∈ F.coloursAt P ∧ c ∉ F.coloursAt P ∧ P + 2 * e θ ∈ closure (F.region c)

/-! ## A constant-sided unit arc at its interior points -/

section RingArc

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}

/-- **The colours at an interior point of a constant-sided unit arc are its two sides**: near the point `ω(P)` lies in `Γ`, so a class
reaches the point from inside `ω(P)` or from outside. -/
theorem IsRingArc.coloursAt_openArc (hA : F.IsRingArc P θ₁ θ₂ c c') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    F.coloursAt (ringPt P θ) = {c, c'} := by
  obtain ⟨hin, hout⟩ := hA.2.2 θ hθ
  apply Subset.antisymm
  · intro j hj
    obtain ⟨δ, hδ, hsph⟩ := exists_sphere_inter_ball_subset_openArc (p := P) hθ
    have h1 : ringPt P θ ∈ closure (ball (ringPt P θ) δ ∩ F.region j) :=
      isOpen_ball.inter_closure ⟨mem_ball_self hδ, hj⟩
    have h2 : ball (ringPt P θ) δ ∩ F.region j ⊆ (F.region j ∩ ball P 1) ∪ (F.region j \ closedBall P 1) := by
      rintro y ⟨hyb, hyj⟩
      rcases lt_trichotomy (dist y P) 1 with hlt | heq | hgt
      · exact Or.inl ⟨hyj, mem_ball.mpr hlt⟩
      · exfalso
        obtain ⟨t, ht, rfl⟩ := hsph ⟨mem_sphere.mpr heq, hyb⟩
        exact hyj.1.2 (hA.2.1 ⟨t, Ioo_subset_Icc_self ht, rfl⟩).2
      · exact Or.inr ⟨hyj, fun h => absurd (mem_closedBall.mp h) (not_le.mpr hgt)⟩
    have h3 := closure_mono h2 h1
    rw [closure_union] at h3
    rcases h3 with h3 | h3
    · have : j ∈ F.innerColours P (ringPt P θ) := h3
      rw [hin] at this
      exact Or.inl this
    · have : j ∈ F.outerColours P (ringPt P θ) := h3
      rw [hout] at this
      exact Or.inr this
  · rintro j (rfl | rfl)
    · have : j ∈ F.innerColours P (ringPt P θ) := by rw [hin]; rfl
      exact closure_mono inter_subset_left this
    · have : j ∈ F.outerColours P (ringPt P θ) := by rw [hout]; rfl
      exact closure_mono sdiff_subset this

/-- **In a clean map the two sides of a unit arc differ** (an interior point of the arc carries at least two colours). -/
theorem IsRingArc.sides_ne_of_isClean (hc : F.IsClean) (hA : F.IsRingArc P θ₁ θ₂ c c') : c ≠ c' := by
  intro hcc
  obtain ⟨θ, hθ⟩ := nonempty_Ioo.mpr hA.1
  have h2 := hc _ (hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩)
  rw [hA.coloursAt_openArc hθ, hcc] at h2
  simp at h2

/-- **`F` at an interior point of a constant-sided unit arc near which `Γ` is `ω(P)`**: degree `2`, and a repeated colour exactly when
the two sides agree (`degree_of_circle`; `CollarFit.degree_openArc` is this at a collar's arc). -/
theorem IsRingArc.degree_openArc (hA : F.IsRingArc P θ₁ θ₂ c c') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂)
    (hfree : ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) :
    (∀ n, F.HasDegree (ringPt P θ) n ↔ n = 2) ∧ (F.HasRepeatedColour (ringPt P θ) ↔ c = c') := by
  obtain ⟨r₁, hr₁, hfr⟩ := hfree
  have hvΓ : ringPt P θ ∈ F.Γ := hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  obtain ⟨r₂, hr₂, hdom⟩ := Metric.isOpen_iff.mp F.isOpen_dom _ hvΓ.1
  obtain ⟨r₃, hr₃, hsph⟩ := exists_sphere_inter_ball_subset_openArc (p := P) hθ
  set r₀ := min (min r₁ r₂) (min r₃ 1) with hr₀
  have h0 : 0 < r₀ := lt_min (lt_min hr₁ hr₂) (lt_min hr₃ one_pos)
  have h1 : r₀ ≤ r₁ := (min_le_left _ _).trans (min_le_left _ _)
  have h2 : r₀ ≤ r₂ := (min_le_left _ _).trans (min_le_right _ _)
  have h3 : r₀ ≤ r₃ := (min_le_right _ _).trans (min_le_left _ _)
  have h4 : r₀ ≤ 1 := (min_le_right _ _).trans (min_le_right _ _)
  refine degree_of_circle (q := P) (φ := θ) one_pos (by simp [ringPt]) h0 (by linarith) ((ball_subset_ball h2).trans hdom) ?_
    (fun d hd => ?_) (fun d hd => ?_)
  · apply Subset.antisymm
    · rintro z ⟨hzΓ, hzb⟩
      exact ⟨hfr ⟨hzΓ, ball_subset_ball h1 hzb⟩, hzb⟩
    · rintro z ⟨hzs, hzb⟩
      obtain ⟨t, ht, rfl⟩ := hsph ⟨hzs, ball_subset_ball h3 hzb⟩
      exact ⟨hA.2.1 ⟨t, Ioo_subset_Icc_self ht, rfl⟩, hzb⟩
  · have : d ∈ F.innerColours P (ringPt P θ) := hd
    rw [(hA.2.2 θ hθ).1] at this
    exact this
  · have : d ∈ F.outerColours P (ringPt P θ) := hd
    rw [(hA.2.2 θ hθ).2] at this
    exact this

/-- **A unit arc about another centre misses the open arc** (FS131-IA1's W4): near an interior point of `α` with `Γ` free there, `Γ`
lies on `ω(P)`, which a unit circle about `Q ≠ P` meets in finitely many points. -/
theorem IsRingArc.disjoint_openArc_of_ne (hF : F.Valid) {Q : ℂ} {a b : ℝ} {d d' : Fin k} (hQP : Q ≠ P)
    (hD : F.IsRingArc Q a b d d') (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) :
    Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) := by
  rw [Set.disjoint_left]
  rintro w ⟨β, hβ, rfl⟩ ⟨θ, hθ, hwθ⟩
  obtain ⟨r, hr, hfr⟩ := hfree θ hθ
  have hℓ := l60_le hF hD
  have hπ := Real.pi_pos
  have hcont : Continuous (ringPt Q) := continuous_const.add continuous_e
  have hO : IsOpen (ringPt Q ⁻¹' ball (ringPt P θ) r) := isOpen_ball.preimage hcont
  have hβO : β ∈ ringPt Q ⁻¹' ball (ringPt P θ) r := by
    show ringPt Q β ∈ ball (ringPt P θ) r
    rw [hwθ]; exact mem_ball_self hr
  obtain ⟨η, hη, hball⟩ := Metric.isOpen_iff.mp hO β hβO
  have hlt : max a (β - η) < min b (β + η) := by
    rw [max_lt_iff, lt_min_iff, lt_min_iff]
    exact ⟨⟨hD.1, by linarith [hβ.1]⟩, ⟨by linarith [hβ.2], by linarith⟩⟩
  have hJ : (Ioo (max a (β - η)) (min b (β + η))).Infinite := Ioo_infinite hlt
  have hmemI : ∀ t ∈ Ioo (max a (β - η)) (min b (β + η)), t ∈ Icc a b := fun t ht =>
    ⟨(le_max_left _ _).trans ht.1.le, ht.2.le.trans (min_le_left _ _)⟩
  have hsub : ringPt Q '' Ioo (max a (β - η)) (min b (β + η)) ⊆ (Arc.circ Q 1 a b).carrier ∩ sphere P 1 := by
    rintro _ ⟨t, ht, rfl⟩
    have hta := hmemI t ht
    have htη : t ∈ ball β η := by
      rw [Real.ball_eq_Ioo]
      exact ⟨(le_max_right _ _).trans_lt ht.1, ht.2.trans_le (min_le_right _ _)⟩
    have htb : ringPt Q t ∈ ball (ringPt P θ) r := hball htη
    have htΓ : ringPt Q t ∈ F.Γ := hD.2.1 ⟨t, hta, rfl⟩
    refine ⟨?_, hfr ⟨htΓ, htb⟩⟩
    rw [carrier_circ_one]
    exact ⟨t, hta, rfl⟩
  have hfin : ((Arc.circ Q 1 a b).carrier ∩ sphere P 1).Finite := by
    rcases (Arc.circ Q 1 a b).finite_inter_sphere_or_eq_circ ⟨one_pos, hD.1, by linarith⟩ P with h | ⟨θ₀, θ₁', h⟩
    · exact h
    · exact absurd (Arc.circ.inj h).1 hQP
  have hinj : InjOn (ringPt Q) (Ioo (max a (β - η)) (min b (β + η))) := by
    intro s hs t ht hst
    have he : e s = e t := by
      simp only [ringPt] at hst
      exact add_left_cancel hst
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
    have hs' := hmemI s hs
    have ht' := hmemI t ht
    have hn0 : n = 0 := by
      by_contra hne
      rcases lt_or_gt_of_ne hne with hneg | hpos
      · have : (n : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt hneg
        nlinarith [hs'.1, hs'.2, ht'.1, ht'.2]
      · have : (1 : ℝ) ≤ n := by exact_mod_cast hpos
        nlinarith [hs'.1, hs'.2, ht'.1, ht'.2]
    rw [hn0] at hn
    simpa using hn
  exact (hJ.image hinj) (hfin.subset hsub)

end RingArc

/-! ## Horns and the horn count (W6) -/

/-- **A horn at a point iff its horn count is at least `1`** (FS131-IA1's W6), with the count's existence: at a point of the domain the
horn count exists, and it is at least `1` exactly when some horn has its tip there (at a chart, `Near.hasHornCount_chart`: the count is
the number of consecutive germs sharing a direction, and such a pair bounds a horn). -/
theorem exists_hasHornCount_isHorn_iff {v : ℂ} (hv : v ∈ F.dom) :
    ∃ j, F.HasHornCount v j ∧ ((∃ α κ₁ κ₂ c, F.IsHorn v α κ₁ κ₂ c) ↔ 1 ≤ j) := by
  obtain ⟨X⟩ := exists_near hv
  -- a horn gives a positive count
  have hpos : ∀ j, F.HasHornCount v j → (∃ α κ₁ κ₂ c, F.IsHorn v α κ₁ κ₂ c) → 1 ≤ j := by
    rintro j hj ⟨α, κ₁, κ₂, c, hκ, hH⟩
    obtain ⟨r, hr, hS, -⟩ := (hj.and hH).exists
    have h1 : (1 : ℕ∞) ≤ ({S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}).encard :=
      Set.one_le_encard_iff_nonempty.mpr ⟨_, hS, α, κ₁, κ₂, hκ, rfl⟩
    rw [hr] at h1
    exact_mod_cast h1
  rcases Nat.eq_zero_or_pos X.n with hn | hn
  · have h0 : F.HasHornCount v 0 := by
      filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
      rw [Nat.cast_zero, encard_eq_zero, eq_empty_iff_forall_notMem]
      rintro S ⟨hS, α, κ₁, κ₂, -, rfl⟩
      have hball := (X.hC.isSector_iff_of_zero hn hr).mp hS
      have hv' : v ∈ hornSet v α κ₁ κ₂ r := hball ▸ mem_ball_self hr.1
      have := hv'.2.1
      simp [frameX] at this
    exact ⟨0, h0, fun hH => hpos 0 h0 hH, fun h => absurd h (by norm_num)⟩
  · refine ⟨_, X.hasHornCount_chart hn, hpos _ (X.hasHornCount_chart hn), fun h1 => ?_⟩
    have hne : {i : Fin X.n | X.G.β i = X.G.nextβ i}.Nonempty := by
      rw [← Set.ncard_pos]; omega
    obtain ⟨i, hi⟩ := hne
    have hi' : X.G.β i = X.G.nextβ i := hi
    have hκ : X.G.κ i < X.G.nextκ i := by
      rcases X.hC.sorted.2 i with hlt | ⟨-, hκ⟩
      · exact absurd hi' hlt.ne
      · exact hκ
    refine ⟨X.G.β i, X.G.κ i, X.G.nextκ i, X.col i, hκ, ?_⟩
    filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
    have hsec : X.G.sector v r i = hornSet v (X.G.β i) (X.G.κ i) (X.G.nextκ i) r := by
      have h1 : |X.G.κ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (X.hC.curv i).le
      have h2 : |X.G.nextκ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (X.hC.curv_next i).le
      show sectorBetween v (X.G.β i) (X.G.κ i) (X.G.nextβ i) (X.G.nextκ i) r = _
      rw [← hi']
      exact sectorBetween_eq_hornSet v _ _ _ r h1 h2
    rw [← hsec]
    exact ⟨(X.hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, fun z hz => (X.hcol i r hr hz).2⟩

/-! ## The step's radius -/

/-- **The arc step's radius**: for a locally finite set `T` and a bound `δ`, a radius `ε < δ`, `ε < 1`, with every point of `T` in the
closed `ε`-neighbourhood of the arc on the arc. -/
theorem exists_arcStep_radius {T : Set ℂ} (hT : ∀ K, IsCompact K → (K ∩ T).Finite) (P : ℂ) (θ₁ θ₂ : ℝ) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ε, 0 < ε ∧ ε < δ ∧ ε < 1 ∧ cthickening ε (ringArc P θ₁ θ₂) ∩ T ⊆ ringArc P θ₁ θ₂ := by
  have hα : IsCompact (ringArc P θ₁ θ₂) := isCompact_Icc.image (continuous_const.add continuous_e)
  have hfin : ((cthickening 1 (ringArc P θ₁ θ₂) ∩ T) \ ringArc P θ₁ θ₂).Finite :=
    (hT _ hα.cthickening).subset sdiff_subset
  obtain ⟨η, hη, hηd⟩ := (disjoint_sdiff_right (s := ringArc P θ₁ θ₂)
    (t := cthickening 1 (ringArc P θ₁ θ₂) ∩ T)).exists_cthickenings hα hfin.isClosed
  refine ⟨min (min η (δ / 2)) (1 / 2), by positivity, ?_, ?_, ?_⟩
  · exact lt_of_le_of_lt ((min_le_left _ _).trans (min_le_right _ _)) (by linarith)
  · exact lt_of_le_of_lt (min_le_right _ _) (by norm_num)
  · rintro x ⟨hxc, hxT⟩
    by_contra hxα
    have hx1 : x ∈ cthickening 1 (ringArc P θ₁ θ₂) :=
      cthickening_mono ((min_le_right _ _).trans (by norm_num)) _ hxc
    have hxη : x ∈ cthickening η (ringArc P θ₁ θ₂) :=
      cthickening_mono ((min_le_left _ _).trans (min_le_left _ _)) _ hxc
    exact Set.disjoint_left.mp hηd hxη (self_subset_cthickening _ ⟨⟨hx1, hxT⟩, hxα⟩)

/-! ## The step's clauses from the interface -/

namespace ArcBend

variable {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ : ℝ} {c c' g : Fin k} {ε : ℝ}

/-- The bent map has `F`'s domain. -/
theorem dom_eq (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) : M.dom = F.dom := hB.step.agreesOff.1.symm

/-- A point of the collar is at distance between `1 − ε` and `1 + ε` from `P`. -/
theorem dist_of_mem (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {z : ℂ} (hz : z ∈ K) : 1 - ε < dist z P ∧ dist z P < 1 + ε := by
  obtain ⟨_, ⟨θ, -, rfl⟩, hd⟩ := mem_thickening_iff.mp (hB.sub_thick hz)
  have h1 := dist_triangle z (ringPt P θ) P
  have h2 := dist_triangle (ringPt P θ) z P
  rw [dist_ringPt] at h1 h2
  rw [dist_comm (ringPt P θ) z] at h2
  exact ⟨by linarith, by linarith⟩

/-- **The place of a preimage**: a point is fixed, or its preimage is an interior point of `F` in the collar or an interior point of
the arc. -/
theorem symm_cases (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (x : ℂ) :
    h.symm x = x ∨ h.symm x ∈ F.interiorPts ∨ ∃ θ ∈ Ioo θ₁ θ₂, h.symm x = ringPt P θ := by
  have hx : h (h.symm x) = x := h.apply_symm_apply x
  by_cases hK : h.symm x ∈ K
  · by_cases hI : h.symm x ∈ F.interiorPts
    · exact Or.inr (Or.inl hI)
    · have hΓ : h.symm x ∈ F.Γ := (F.mem_Γ_iff).mpr ⟨hB.sub_dom hK, hI⟩
      by_cases hO : h.symm x ∈ ringPt P '' Ioo θ₁ θ₂
      · obtain ⟨θ, hθ, hθx⟩ := hO
        exact Or.inr (Or.inr ⟨θ, hθ, hθx.symm⟩)
      · left
        have := hB.fix_Γ _ hΓ hO
        rw [hx] at this
        exact this.symm
  · left
    have := hB.fix_off _ hK
    rw [hx] at this
    exact this.symm

/-- The colours at a point off the collar are kept. -/
theorem coloursAt_of_notMem (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {x : ℂ} (hx : x ∉ K) : M.coloursAt x = F.coloursAt x := by
  have := hB.coloursAt x
  rwa [hB.fix_off x hx] at this

/-- **The colours at the centre are kept** (`ε ≤ 1`: the centre is off the collar). -/
theorem coloursAt_centre (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hε : ε ≤ 1) : M.coloursAt P = F.coloursAt P := by
  refine hB.coloursAt_of_notMem fun hPK => ?_
  have := (hB.dist_of_mem hPK).1
  rw [dist_self] at this
  linarith

/-- **The bent map of a clean map is clean**: a point of its `Γ` is the image of a point of `F`'s, with the same colours. -/
theorem isClean (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) : M.IsClean := by
  intro x hx
  have hxx : h (h.symm x) = x := h.apply_symm_apply x
  have hzΓ : h.symm x ∈ F.Γ := by
    refine (F.mem_Γ_iff).mpr ⟨?_, fun hI => ?_⟩
    · by_cases hK : h.symm x ∈ K
      · exact hB.sub_dom hK
      · have := hB.fix_off _ hK
        rw [hxx] at this
        rw [← this, ← hB.dom_eq]
        exact hx.1
    · have := hB.interior _ hI
      rw [hxx] at this
      exact ((M.mem_Γ_iff).mp hx).2 this
  have := hB.coloursAt (h.symm x)
  rw [hxx] at this
  rw [this]
  exact hc _ hzΓ

/-- **The bend is a local step on the closed `ε`-neighbourhood of the arc.** -/
theorem localStep (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) : LocalStep F M (cthickening ε (ringArc P θ₁ θ₂)) :=
  hB.step.mono (hB.sub_thick.trans (thickening_subset_cthickening _ _))

/-- **The bent map is a modification of `F`**: a point of at least four colours in it is fixed (a moved point's preimage is interior,
one colour, or on the open arc, two). -/
theorem isModification (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) : F.IsModification M := by
  refine ⟨hB.dom_eq, hB.ringArcsWithin, fun x h4 => ?_⟩
  have hxx : h (h.symm x) = x := h.apply_symm_apply x
  have hcol : M.coloursAt x = F.coloursAt (h.symm x) := by
    have := hB.coloursAt (h.symm x)
    rwa [hxx] at this
  rcases hB.symm_cases x with hfix | hI | ⟨θ, hθ, hz⟩
  · rw [hfix] at hcol
    exact hcol.subset
  · exfalso
    rw [hcol, coloursAt_eq_singleton_of_interior hI, Set.ncard_singleton] at h4
    omega
  · exfalso
    rw [hcol, hz, hB.ring.coloursAt_openArc hθ] at h4
    have := Set.ncard_insert_le c ({c'} : Set (Fin k))
    rw [Set.ncard_singleton] at this
    omega

/-- **A point off the collar or on the closed arc is fixed, or an interior point of the arc turned to the gaining colour.** -/
theorem fixed_or_gain (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {x : ℂ} (hx : x ∉ K ∨ x ∈ ringArc P θ₁ θ₂) :
    h x = x ∨ ∃ θ ∈ Ioo θ₁ θ₂, x = ringPt P θ ∧ ringPt P θ ∈ M.region g := by
  rcases hx with hx | hx
  · exact Or.inl (hB.fix_off x hx)
  · by_cases hO : x ∈ ringPt P '' Ioo θ₁ θ₂
    · obtain ⟨θ, hθ, rfl⟩ := hO
      exact (hB.gain θ hθ).imp id fun hg => ⟨θ, hθ, rfl, hg⟩
    · exact Or.inl (hB.fix_Γ x (hB.ring.2.1 hx) hO)

/-- **No colour is added at a point off the collar or on the closed arc**: such a point is fixed, or an interior point of the arc
turned to the gaining colour, a side colour of the arc there. -/
theorem coloursAt_subset (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {x : ℂ} (hx : x ∉ K ∨ x ∈ ringArc P θ₁ θ₂) :
    M.coloursAt x ⊆ F.coloursAt x := by
  rcases hB.fixed_or_gain hx with hfix | ⟨θ, hθ, rfl, hg⟩
  · have := hB.coloursAt x
    rw [hfix] at this
    exact this.subset
  · rw [coloursAt_eq_singleton_of_interior hg.1, singleton_subset_iff, hB.ring.coloursAt_openArc hθ]
    have hcol : M.col (ringPt P θ) = g := hg.2
    rw [hcol]
    rcases hB.side with hs | hs
    · exact Or.inl hs
    · exact Or.inr hs

/-- **No degree rises at a point off the collar or on the closed arc** (the repaired degree clause of `exists_arcStep`, where it is
read): a fixed point keeps its degree; an interior point of the arc turned to the gaining colour falls to degree `1`. -/
theorem degree_le (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) {x : ℂ} (hx : x ∉ K ∨ x ∈ ringArc P θ₁ θ₂) {m : ℕ}
    (hm : F.HasDegree x m) : ∃ m' ≤ m, M.HasDegree x m' := by
  rcases hB.fixed_or_gain hx with hfix | ⟨θ, hθ, rfl, hg⟩
  · refine ⟨m, le_rfl, ?_⟩
    have := hB.degree x m hm
    rwa [hfix] at this
  · refine ⟨1, ?_, (hasDegree_iff_of_mem_interiorPts hg.1 1).mpr rfl⟩
    have hm2 : m = 2 := ((hB.ring.degree_openArc hθ (hB.ring.free_of_isClean hc θ hθ)).1 m).mp hm
    omega

/-- **No site is created**: a repeated colour of the bent map sits at a fixed point (a moved point's preimage is interior, or on the
open arc, whose two sides differ in a clean map); a horn of the bent map gives horn count at least `1` there, so in `F` too (`horn`),
so a horn of `F` (`exists_hasHornCount_isHorn_iff`). -/
theorem isSite (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) {x : ℂ} (hx : M.IsSite x) : F.IsSite x := by
  obtain ⟨hxd, hrep | ⟨α, κ₁, κ₂, c₀, hH⟩⟩ := hx
  · have hxF : x ∈ F.dom := by rw [← hB.dom_eq]; exact hxd
    refine ⟨hxF, Or.inl ?_⟩
    have hxx : h (h.symm x) = x := h.apply_symm_apply x
    have hrepF : F.HasRepeatedColour (h.symm x) := hB.repeated _ (by rw [hxx]; exact hrep)
    rcases hB.symm_cases x with hfix | hI | ⟨θ, hθ, hz⟩
    · rwa [hfix] at hrepF
    · exfalso
      obtain ⟨r₀, m, Gm, hC⟩ := localSectors F hI.1
      have hm : m = 0 := by
        by_contra hm
        exact hI.2 (hC.mem_Γ.mpr (Nat.pos_of_ne_zero hm)).2
      exact hC.not_hasRepeatedColour_of_zero hm hrepF
    · exfalso
      rw [hz] at hrepF
      exact hB.ring.sides_ne_of_isClean hc
        ((hB.ring.degree_openArc hθ (hB.ring.free_of_isClean hc θ hθ)).2.mp hrepF)
  · have hxF : x ∈ F.dom := by rw [← hB.dom_eq]; exact hxd
    refine ⟨hxF, Or.inr ?_⟩
    obtain ⟨j, hj, hiff⟩ := exists_hasHornCount_isHorn_iff hxF
    obtain ⟨j', hj', hjM⟩ := hB.horn x j hj
    obtain ⟨jM, hjM', hiffM⟩ := exists_hasHornCount_isHorn_iff hxd
    have h1 : 1 ≤ jM := hiffM.mp ⟨α, κ₁, κ₂, c₀, hH⟩
    have h2 : jM = j' := hjM'.eq hjM
    exact hiff.mpr (by omega)

/-- **(Q) is kept** at a centre whose colours are kept, for an arc whose open arc misses `α°`. -/
theorem isQArc_of (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) {Q : ℂ} {a b : ℝ} (hQ : F.IsQArc Q a b)
    (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) (hcol : M.coloursAt Q = F.coloursAt Q) : M.IsQArc Q a b := by
  obtain ⟨d, d', hD, h1, h2, h4⟩ := hQ
  exact ⟨d, d', hB.R2 _ _ _ _ _ hD hd, by rw [hcol]; exact h1, by rw [hcol]; exact h2, by rw [hcol]; exact h4⟩

/-- **(R2) is kept** at a centre whose colours are kept, for an arc whose open arc misses `α°` (question (5), `isR2Arc_of_fixed`). -/
theorem isR2Arc_of (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) {Q : ℂ} {a b : ℝ} (hR : F.IsR2Arc Q a b)
    (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) (hcol : M.coloursAt Q = F.coloursAt Q) : M.IsR2Arc Q a b := by
  exact isR2Arc_of_fixed hF hB.sub_dom hB.fix_off hB.fix_Γ hB.coloursAt (hB.ring.free_of_isClean hc)
    (fun _ _ hD => hB.R2 _ _ _ _ _ hD hd) hcol hR

/-- **What is left of the arc is (R2)** (FS131-IA1's W7): a unit arc of the bent map about `P` with `α`'s sides whose open arc lies in
`α°` is an (R2) arc of the bent map (`left` at each interior angle; the ends by closedness; the radius-2 points are off the collar). -/
theorem isR2Arc_left (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hε : ε ≤ 1) {a b : ℝ} (hM : M.IsRingArc P a b c c')
    (hsub : ringPt P '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂) : M.IsR2Arc P a b := by
  have hcont : Continuous fun t : ℝ => P + 2 * e t := continuous_const.add (continuous_const.mul continuous_e)
  have hon : ∀ t ∈ Ioo a b, ∀ θ, ringPt P θ = ringPt P t → M.OnRingArc P (ringPt P θ) := fun t ht θ hθt =>
    ⟨a, b, hM.1, by rw [hθt]; exact ⟨t, Ioo_subset_Icc_self ht, rfl⟩, hM.2.1⟩
  have hIoo : (fun t : ℝ => P + 2 * e t) '' Ioo a b ⊆ closure (M.region c) := by
    rintro _ ⟨t, ht, rfl⟩
    obtain ⟨θ, hθ, hθt⟩ := hsub ⟨t, ht, rfl⟩
    have he : e θ = e t := by
      simp only [ringPt] at hθt
      exact add_left_cancel hθt
    have h3 := (hB.left θ hθ (hon t ht θ hθt)).2.2
    rw [he] at h3
    have hnK : P + 2 * e t ∉ K := fun hK => by
      have h := (hB.dist_of_mem hK).2
      have hd : dist (P + 2 * e t) P = 2 := by simp [dist_eq_norm]
      rw [hd] at h
      linarith
    have hmem : c ∈ M.coloursAt (P + 2 * e t) := by
      rw [hB.coloursAt_of_notMem hnK]; exact h3
    exact hmem
  obtain ⟨t₀, ht₀⟩ := nonempty_Ioo.mpr hM.1
  obtain ⟨θ₀, hθ₀, hθt₀⟩ := hsub ⟨t₀, ht₀, rfl⟩
  obtain ⟨hc', hcn, -⟩ := hB.left θ₀ hθ₀ (hon t₀ ht₀ θ₀ hθt₀)
  have hcolP := hB.coloursAt_centre hε
  refine ⟨c, c', hM, by rw [hcolP]; exact hc', by rw [hcolP]; exact hcn, ?_⟩
  calc radiusTwoArc P a b = (fun t : ℝ => P + 2 * e t) '' closure (Ioo a b) := by
        rw [closure_Ioo hM.1.ne]; rfl
    _ ⊆ closure ((fun t : ℝ => P + 2 * e t) '' Ioo a b) := image_closure_subset_closure_image hcont
    _ ⊆ closure (closure (M.region c)) := closure_mono hIoo
    _ = closure (M.region c) := closure_closure

/-- **A maximal bad unit arc of the bent map is one of `F`, off `α°`** — the two count clauses of `exists_arcStep` at the ring-arc
level. `Q` is a centre whose colours are kept; `hmeet` says that a unit arc of `F` about `Q` whose open arc meets `α°` is centred at
`P`, has `α`'s sides and lies in `α` (for `Q ≠ P` no such arc exists, `IsRingArc.disjoint_openArc_of_ne`; for `Q = P` it is `α`'s
maximality, read on point sets — `Procedure`'s `IsMaxRingArc` with `IsRingArc.union`). An arc of the bent map about `Q`, maximal among
its unit arcs with the same sides (`IsMaxRingArc`'s last clause, unfolded) and neither (Q) nor (R2), has its open arc off `α°`, and is
such an arc of `F`. -/
theorem maxBad (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) (hε : ε ≤ 1) {Q : ℂ}
    (hcol : M.coloursAt Q = F.coloursAt Q)
    (hmeet : ∀ a b d d', F.IsRingArc Q a b d d' → ¬ Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
      Q = P ∧ (d = c ∧ d' = c') ∧ ringPt Q '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂)
    {a b : ℝ} {d d' : Fin k} (hM : M.IsRingArc Q a b d d')
    (hmax : ∀ a' b', a' ≤ a → b ≤ b' → M.IsRingArc Q a' b' d d' → a' = a ∧ b' = b)
    (hQ : ¬ M.IsQArc Q a b) (hR : ¬ M.IsR2Arc Q a b) :
    Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) ∧ F.IsRingArc Q a b d d' ∧
      (∀ a' b', a' ≤ a → b ≤ b' → F.IsRingArc Q a' b' d d' → a' = a ∧ b' = b) ∧ ¬ F.IsQArc Q a b ∧ ¬ F.IsR2Arc Q a b := by
  have hFD : F.IsRingArc Q a b d d' := hB.R1 _ _ _ _ _ hM
  have hdisj : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) := by
    by_contra hnd
    obtain ⟨hQP, ⟨hdc, hdc'⟩, hsub⟩ := hmeet a b d d' hFD hnd
    subst hQP hdc hdc'
    exact hR (hB.isR2Arc_left hε hM hsub)
  refine ⟨hdisj, hFD, fun a' b' ha hb hD' => ?_, fun hQF => hQ (hB.isQArc_of hQF hdisj hcol),
    fun hRF => hR (hB.isR2Arc_of hF hc hRF hdisj hcol)⟩
  refine hmax a' b' ha hb (hB.R2 _ _ _ _ _ hD' ?_)
  by_contra hnd
  obtain ⟨-, -, hsub⟩ := hmeet a' b' d d' hD' hnd
  obtain ⟨t, ht⟩ := nonempty_Ioo.mpr hM.1
  have ht' : t ∈ Ioo a' b' := ⟨lt_of_le_of_lt ha ht.1, lt_of_lt_of_le ht.2 hb⟩
  exact Set.disjoint_left.mp hdisj ⟨t, ht, rfl⟩ (hsub ⟨t, ht', rfl⟩)

/-- **The count clause at the centre**, at the ring-arc level: given `α`'s maximality on point sets (`hmeet`), a maximal bad unit arc of
the bent map about `P` is a maximal bad unit arc of `F` about `P` whose open arc misses `α°` — so it is not `α`. -/
theorem maxBad_centre (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) (hε : ε ≤ 1)
    (hmeet : ∀ a b d d', F.IsRingArc P a b d d' → ¬ Disjoint (ringPt P '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
      (d = c ∧ d' = c') ∧ ringPt P '' Ioo a b ⊆ ringPt P '' Ioo θ₁ θ₂)
    {a b : ℝ} {d d' : Fin k} (hM : M.IsRingArc P a b d d')
    (hmax : ∀ a' b', a' ≤ a → b ≤ b' → M.IsRingArc P a' b' d d' → a' = a ∧ b' = b)
    (hQ : ¬ M.IsQArc P a b) (hR : ¬ M.IsR2Arc P a b) :
    Disjoint (ringPt P '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) ∧ F.IsRingArc P a b d d' ∧
      (∀ a' b', a' ≤ a → b ≤ b' → F.IsRingArc P a' b' d d' → a' = a ∧ b' = b) ∧ ¬ F.IsQArc P a b ∧ ¬ F.IsR2Arc P a b :=
  hB.maxBad hF hc hε (hB.coloursAt_centre hε) (fun a b d d' hD hnd => ⟨rfl, hmeet a b d d' hD hnd⟩) hM hmax hQ hR

/-- **The count clause at another centre**, at the ring-arc level: at `Q ≠ P` whose colours are kept, a maximal bad unit arc of the bent
map about `Q` is a maximal bad unit arc of `F` about `Q`. -/
theorem maxBad_other (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hF : F.Valid) (hc : F.IsClean) (hε : ε ≤ 1) {Q : ℂ} (hQP : Q ≠ P)
    (hcol : M.coloursAt Q = F.coloursAt Q) {a b : ℝ} {d d' : Fin k} (hM : M.IsRingArc Q a b d d')
    (hmax : ∀ a' b', a' ≤ a → b ≤ b' → M.IsRingArc Q a' b' d d' → a' = a ∧ b' = b)
    (hQ : ¬ M.IsQArc Q a b) (hR : ¬ M.IsR2Arc Q a b) :
    F.IsRingArc Q a b d d' ∧ (∀ a' b', a' ≤ a → b ≤ b' → F.IsRingArc Q a' b' d d' → a' = a ∧ b' = b) ∧
      ¬ F.IsQArc Q a b ∧ ¬ F.IsR2Arc Q a b :=
  (hB.maxBad hF hc hε hcol (fun _ _ _ _ hD hnd =>
    absurd (hD.disjoint_openArc_of_ne hF hQP (hB.ring.free_of_isClean hc)) hnd) hM hmax hQ hR).2

/-- **The arc step's clauses from a bend**, but for the two counts (`maxBad_centre`, `maxBad_other`): for a clean valid map, a bend
within `ε < 1` of the arc and a set `T` whose points in the closed `ε`-neighbourhood of the arc lie on the arc, the bent map is valid
and clean, a local step on that neighbourhood, a modification of `F`; it creates no site, raises no degree at a point of `T` and no horn
count anywhere, adds no colour at a point of `T`, and keeps the colours at the centre. -/
theorem arcStep (hB : ArcBend F M h K P θ₁ θ₂ c c' g ε) (hc : F.IsClean) (hε : ε ≤ 1) {T : Set ℂ}
    (hT : cthickening ε (ringArc P θ₁ θ₂) ∩ T ⊆ ringArc P θ₁ θ₂) :
    M.Valid ∧ M.IsClean ∧ LocalStep F M (cthickening ε (ringArc P θ₁ θ₂)) ∧ F.IsModification M ∧
      (∀ x, M.IsSite x → F.IsSite x) ∧ (∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, M.HasDegree x m') ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j') ∧ (∀ Q ∈ T, M.coloursAt Q ⊆ F.coloursAt Q) ∧
      M.coloursAt P = F.coloursAt P := by
  have hsubK : ∀ x ∈ T, x ∉ K ∨ x ∈ ringArc P θ₁ θ₂ := fun x hxT => by
    by_cases hxK : x ∈ K
    · exact Or.inr (hT ⟨thickening_subset_cthickening _ _ (hB.sub_thick hxK), hxT⟩)
    · exact Or.inl hxK
  exact ⟨hB.valid, hB.isClean hc, hB.localStep, hB.isModification, fun x hx => hB.isSite hc hx,
    fun x hx m hm => hB.degree_le hc (hsubK x hx) hm, hB.horn, fun Q hQ => hB.coloursAt_subset (hsubK Q hQ),
    hB.coloursAt_centre hε⟩

end ArcBend

/-! ## The local step of a cut (W1 and W2; FS131-KA1's statement) -/

/-- **A map whose arcs are `F`'s cut at the open arc, with new arcs inside `K`, is a local step on `K`** (FS131-KA1's
`LocalStep.of_cutArcs`, stated here with its signature — at the merge the two are one statement, in `BendAway`; FS131-IA1's W1 and W2):
an arc of `F` missing `K` misses the closed arc, so it is in the cut whole; a piece of the cut that is no arc of `F` lies in an arc of
`F` through an end of the arc, a point of `K`. -/
theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
    (hag : M.AgreesOff F K) (harcs : M.arcs = F.cutArcs P θ₁ θ₂ ∪ S) (hS : ∀ a ∈ S, a.carrier ⊆ K)
    (hK : ringArc P θ₁ θ₂ ⊆ K) : LocalStep F M K := by
  have hπ := Real.pi_pos
  have h2π : 0 < 2 * π := by positivity
  have hturn : ∀ (t : ℝ) (m : ℤ), ringPt P (t + m * (2 * π)) = ringPt P t := fun t m => by
    rw [ringPt, ringPt, show t + (m : ℝ) * (2 * π) = t + 2 * π * m by ring, e_add_int_mul]
  refine ⟨hag, fun a ha hd => ?_, fun b hb hbF => ?_⟩
  · rw [harcs]
    left
    by_cases hne : ∀ θa θb, a ≠ .circ P 1 θa θb
    · exact Or.inl ⟨ha, hne⟩
    · push Not at hne
      obtain ⟨θa, θb, rfl⟩ := hne
      obtain ⟨-, hab, -⟩ := F.nondegenerate _ ha
      right
      obtain ⟨m, hm⟩ : ∃ m : ℤ, m = ⌊(θa - θ₂) / (2 * π)⌋ := ⟨_, rfl⟩
      have hm1 : (m : ℝ) * (2 * π) ≤ θa - θ₂ := by
        have := Int.floor_le ((θa - θ₂) / (2 * π))
        rw [← hm] at this
        rwa [le_div_iff₀ h2π] at this
      have hm2 : θa - θ₂ < ((m : ℝ) + 1) * (2 * π) := by
        have := Int.lt_floor_add_one ((θa - θ₂) / (2 * π))
        rw [← hm] at this
        rwa [div_lt_iff₀ h2π] at this
      have hlo : cutLo θ₂ θa m = θa := max_eq_left (by linarith)
      have hhi : cutHi θ₁ θb m = θb := by
        refine min_eq_left ?_
        by_contra hlt
        push Not at hlt
        -- otherwise the arc holds a point of the closed arc, a point of `K`
        have ht1 : max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) ≤ θb := max_le hab.le hlt.le
        have ht2 : max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) ≤ θ₂ + ((m : ℝ) + 1) * (2 * π) :=
          max_le (by linarith) (by linarith)
        have ht3 : θ₁ + ((m : ℝ) + 1) * (2 * π) ≤ max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) := le_max_right _ _
        have hmem : ringPt P (max θa (θ₁ + ((m : ℝ) + 1) * (2 * π))) ∈ (Arc.circ P 1 θa θb).carrier := by
          rw [carrier_circ_one]
          exact ⟨_, ⟨le_max_left _ _, ht1⟩, rfl⟩
        have hK' : ringPt P (max θa (θ₁ + ((m : ℝ) + 1) * (2 * π))) ∈ K := by
          have := hturn (max θa (θ₁ + ((m : ℝ) + 1) * (2 * π)) - ((m + 1 : ℤ) : ℝ) * (2 * π)) (m + 1)
          rw [sub_add_cancel] at this
          rw [this]
          refine hK ⟨_, ⟨?_, ?_⟩, rfl⟩
          · push_cast; linarith
          · push_cast; linarith
        exact Set.disjoint_left.mp hd hmem hK'
      exact ⟨θa, θb, ha, m, by rw [hlo, hhi]; exact hab, by rw [hlo, hhi]⟩
  · rw [harcs] at hb
    rcases hb with hb | hb
    · rcases hb with ⟨hb, -⟩ | ⟨θa, θb, ha, m, hlt, rfl⟩
      · exact absurd hb hbF
      · right
        refine ⟨_, ha, ?_, ?_⟩
        · have hne : cutLo θ₂ θa m ≠ θa ∨ cutHi θ₁ θb m ≠ θb := by
            by_contra hcon
            push Not at hcon
            rw [hcon.1, hcon.2] at hbF
            exact hbF ha
          have hlo : θa ≤ cutLo θ₂ θa m := le_max_left _ _
          have hhi : cutHi θ₁ θb m ≤ θb := min_le_left _ _
          rcases hne with hne | hne
          · have hlo' : cutLo θ₂ θa m = θ₂ + m * (2 * π) := by
              rcases max_choice θa (θ₂ + m * (2 * π)) with h | h
              · exact absurd h hne
              · exact h
            refine ⟨ringPt P θ₂, ?_, hK ⟨θ₂, ⟨h12.le, le_rfl⟩, rfl⟩⟩
            rw [carrier_circ_one, ← hturn θ₂ m]
            exact ⟨_, ⟨by rw [← hlo']; exact hlo, by rw [← hlo']; linarith⟩, rfl⟩
          · have hhi' : cutHi θ₁ θb m = θ₁ + (m + 1) * (2 * π) := by
              rcases min_choice θb (θ₁ + (m + 1) * (2 * π)) with h | h
              · exact absurd h hne
              · exact h
            refine ⟨ringPt P θ₁, ?_, hK ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩⟩
            have hθ₁ := hturn θ₁ (m + 1)
            rw [carrier_circ_one, ← hθ₁]
            refine ⟨_, ⟨?_, ?_⟩, rfl⟩
            · push_cast; rw [← hhi']; linarith
            · push_cast; rw [← hhi']; exact hhi
        · rw [carrier_circ_one, carrier_circ_one]
          exact image_mono (Icc_subset_Icc (le_max_left _ _) (min_le_left _ _))
    · exact Or.inl (hS b hb)

/-! ## The toward collar bend supplies the interface -/

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- The closed arc lies in the collar. -/
theorem CollarFit.ringArc_subset_collarK (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    ringArc P θ₁ θ₂ ⊆ collarK P θ₁ θ₂ R' R'' := by
  rintro _ ⟨θ, hθ, rfl⟩
  refine ⟨θ, hθ, 1, ?_, by simp [ringPt]⟩
  rcases hfit.pushProfiles.cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, -, h3⟩
  · exact ⟨by linarith, h3.le⟩
  · exact ⟨h1.le, h3.ge⟩

/-- The lens lies in the collar (FS131-IA1's W3). -/
theorem CollarFit.lensSet_subset_collarK (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    lensSet P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R'' := by
  refine polarSet_mono Ioo_subset_Icc_self fun θ hθ t ht => ?_
  obtain ⟨-, h1, -, h3⟩ := hfit.pushProfiles.inside θ hθ
  exact ⟨by linarith [ht.1], by linarith [ht.2]⟩

/-- **The collar bend is a local step on the collar** (`LocalStep.of_cutArcs`: its arcs are the cut's and the lens boundary's two). -/
theorem CollarFit.map_localStep (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    LocalStep F hfit.map (collarK P θ₁ θ₂ R' R'') := by
  have hR : 1 / 2 < R := by linarith [hfit.params.1, hfit.params.2.1]
  have hβ := collarArcs_carrier (P := P) hR hfit.params.2.2.1 hfit.ring.1 hfit.short
  refine LocalStep.of_cutArcs (S := {collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R}) hfit.ring.1 ?_ rfl ?_
    hfit.ringArc_subset_collarK
  · exact ⟨hfit.map_agreesOff.1, fun z hz => hfit.map_agreesOff.2 z fun hzU =>
      hz (hzU.elim (fun h => hfit.lensSet_subset_collarK h) (fun h => hfit.lensCurve_subset h))⟩
  · intro a ha
    rcases ha with rfl | ha
    · exact (subset_union_left.trans hβ.subset).trans hfit.lensCurve_subset
    · rw [mem_singleton_iff] at ha
      subst ha
      exact (subset_union_right.trans hβ.subset).trans hfit.lensCurve_subset

/-- **The toward collar bend supplies the interface**, the outer colour gaining: `left` is vacuous (R3, `CollarFit.map_R3`). It rests
on the open child `CollarFit.map_hornCount_le` (`BendStep`) for `horn`. -/
theorem CollarFit.arcBend (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    ArcBend F hfit.map hfit.homeo (collarK P θ₁ θ₂ R' R'') P θ₁ θ₂ c c' c' ε := by
  refine ⟨hfit.ring, Or.inr rfl, hfit.map_valid hF, hfit.sub_thick, hfit.sub_dom, hfit.free, hfit.map_localStep,
    fun z hz => (hfit.homeo_eq_self hz).1, fun z hz hzO => hfit.homeo_fix_Γ hz hzO,
    fun z hz => (pushforward_mem_interiorPts_iff z).mpr hz, fun z => pushforward_coloursAt z,
    fun z n hn => (hfit.map_hasDegree hF z n).mpr hn, fun z hz => (hfit.map_hasRepeatedColour hF z).mp hz,
    fun x j hj => hfit.map_hornCount_le hF hj, hfit.map_ringArcsWithin, fun Q a b d d' hD => hfit.map_R1 hF hD,
    fun Q a b d d' hD hd => hfit.map_R2 hF hD hd, fun θ hθ => Or.inr ?_, fun θ hθ hon => absurd hon (hfit.map_R3 hθ)⟩
  have hL : ringPt P θ ∈ lensSet P θ₁ θ₂ R :=
    ⟨θ, hθ, 1, ⟨(hfit.pushProfiles.inside θ hθ).2.2.1, le_rfl⟩, by simp [ringPt]⟩
  exact ⟨(hfit.map_lens hL).1, (hfit.map_lens hL).2⟩

/-- **The toward bend, in the arc step's form**: a constant-sided unit arc of a valid map whose outer colour is not carried at its
centre, with `Γ` free near its interior points, has for every `ε > 0` a bend within `ε` satisfying the interface, the outer colour
gaining (`exists_collarFit`, `CollarFit.arcBend`). -/
theorem exists_arcBend_toward (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ), ArcBend F M h K P θ₁ θ₂ c c' c' ε := by
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFit hF hA hout hfree hε
  exact ⟨hfit.map, hfit.homeo, collarK P θ₁ θ₂ R' R'', hfit.arcBend hF⟩

end Collar

/-! ## The away bend's conclusion supplies the interface -/

/-- **The away bend's conclusion supplies the interface**, the inner colour gaining: the clauses of `bend_away_part`'s conclusion
(`BendStep`; its horn clause in the arc step's form, inventory ruling 438 (b)) for a map `M`, a homeomorphism `h` and a collar `K`,
at an arc of a plane map whose outer colour is carried at the centre and whose inner colour is not. `left` is the last clause read at
the angle itself (FS131-IA1's W7 starts here). -/
theorem ArcBend.of_away {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {K : Set ℂ} {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε : ℝ}
    (hP : F.IsPlaneMap) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P) (hout : c' ∈ F.coloursAt P)
    (hM : M.Valid ∧ IsCompact K ∧ K ⊆ thickening ε (ringArc P θ₁ θ₂) ∧
      F.Γ ∩ K ⊆ ringArc P θ₁ θ₂ ∧ LocalStep F M K ∧
      (∀ z ∉ K, h z = z) ∧ (∀ z ∈ K, h z ∈ K) ∧
      (∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z) ∧
      (∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)) ∧
      (∀ z, M.coloursAt (h z) = F.coloursAt z) ∧
      (∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n) ∧
      (∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) ∧
      (∀ x j, F.HasHornCount x j → ∃ j' ≤ j, M.HasHornCount x j') ∧
      M.RingArcsWithin F ∧
      (∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d') ∧
      (∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
        M.IsRingArc Q a b d d') ∧
      (∀ θ ∈ Ioo θ₁ θ₂, h (ringPt P θ) = ringPt P θ ∨ ringPt P θ ∈ M.region c) ∧
      (∀ θ ∈ Ioo θ₁ θ₂, M.OnRingArc P (ringPt P θ) →
        ∃ a b, a < b ∧ θ ∈ Icc a b ∧ Icc a b ⊆ F.r2Contacts P θ₁ θ₂ c)) :
    ArcBend F M h K P θ₁ θ₂ c c' c ε := by
  obtain ⟨hV, -, hKε, hfree, hstep, hfix, -, hfixΓ, hint, hcol, hdeg, hrep, hhorn, hraw, hR1, hR2, hgain, hleft⟩ := hM
  refine ⟨hA, Or.inl rfl, hV, hKε, fun z _ => by rw [hP]; trivial, hfree, hstep, hfix, hfixΓ,
    fun z hz => (hint z).1.mpr hz, hcol, fun z n hn => (hdeg z n).mpr hn, fun z hz => (hrep z).mp hz, hhorn, hraw, hR1, hR2,
    hgain, fun θ hθ hon => ?_⟩
  obtain ⟨a, b, -, hθab, hsub⟩ := hleft θ hθ hon
  exact ⟨hout, hin, (hsub hθab).2⟩

/-! ## Spec examples -/

/-- The interface at a model: the collar bend of `l60Frag` (`collarModel`: the arc `r([π/8, 5π/24])` of `ω(0)`, sides `0` and `1`)
satisfies it for every `ε`, the outer colour `1` gaining. (It rests on `CollarFit.map_hornCount_le`, open.) -/
example {ε : ℝ} (hε : 0 < ε) :
    ∃ (R' R'' : ℝ) (M : ArcMap 4) (h : ℂ ≃ₜ ℂ), ArcBend l60Frag M h (collarK 0 (π / 8) (5 * π / 24) R' R'') 0 (π / 8) (5 * π / 24) 0 1 1 ε := by
  obtain ⟨R', R, R'', hfit⟩ := collarModel hε
  exact ⟨R', R'', hfit.map, hfit.homeo, hfit.arcBend l60Frag_valid⟩

end ArcMap

end HadwigerNelson.Plane
