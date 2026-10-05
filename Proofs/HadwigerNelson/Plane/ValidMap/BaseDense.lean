import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk

/-!
# Row 134's base with unit arcs, and the density rows that rest on it

Moved from `Plane/ValidMap/Dense` by job FS131-KB (statements unchanged), downstream of the walk's leaves (`Plane/ValidMap/BaseWalk`):
`row134BaseUA` (the walk's assembly, `plans/FS131-w5base-kernel-plan.md` § 4) and its consumers FS112-N3-BASE (`n3_base`),
FS129-OR1-LOCALDENSE (`localDense`), FS112-N3-DENSE3 (`dense3`), FS114-CV-EXISTS (`cv_exists`).

FS131-E4's repair (b) (inventory item 227, `plans/FS131-E4-derivation.md` § 5.2): `Row134BaseUA` and `n3_base` carry `UnenclosedC u`; the
pre-bend keeps it (`exists_preBend`, E4-BEND-UN); `localDense` chooses its vertex by E4-OUTERMOST (`exists_unenclosed_or_bad`) in place of
FS112-DISC1's, so `localDense`, `dense3` and `cv_exists` keep their statements.

The walk's assembly (job FS131-I5f) is `BaseCtx.false`, with its glue before it: change points of a circle colouring (`mem_S_of_ne`), the
`2π`-periodicity of germs and returning arcs (`IsRetArc.exists_Ico`), the removability of returning arcs (`BaseCtx.removable`), an endpoint's
third colour (`BaseCtx.exists_endpoint_third`) and Lemma 4's distinctness (`BaseCtx.third_ne`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The walk's assembly: glue between the leaves -/

namespace CircleColouring

variable (C : CircleColouring)

/-- A point with different one-sided values is a change point (off the change set the colouring is locally constant). -/
theorem mem_S_of_ne {x : ℝ} {v w : ZMod 3} (hv : C.LeftVal x v) (hw : C.RightVal x w) (hvw : v ≠ w) : x ∈ C.S := by
  by_contra hx
  have hc := C.locallyConstant x hx
  obtain ⟨θ, h1, h2⟩ := (hv.and (hc.filter_mono nhdsWithin_le_nhds)).exists
  obtain ⟨θ', h1', h2'⟩ := (hw.and (hc.filter_mono nhdsWithin_le_nhds)).exists
  exact hvw (h1.symm.trans (h2.trans (h2'.symm.trans h1')))

/-- Off the change set the colouring takes its own value on the left. -/
theorem leftVal_of_not_mem {x : ℝ} (hx : x ∉ C.S) : C.LeftVal x (C.c x) :=
  (C.locallyConstant x hx).filter_mono nhdsWithin_le_nhds

end CircleColouring

namespace ArcMap

variable {F : ArcMap 6} {u : ℂ}

/-- Germs read angles modulo `2π`. -/
theorem germ_add_int_mul (p : ℂ) (θ : ℝ) (m : ℤ) (s : Side) (δ : ℝ) : germ p (θ + 2 * π * m) s δ = germ p θ s δ := by
  unfold germ
  congr 1
  funext t
  simp only [ringPt]
  rw [show θ + 2 * π * m + s.sign * t = (θ + s.sign * t) + 2 * π * m by ring, e_add_int_mul]

/-- Ring points read angles modulo `2π`. -/
theorem ringPt_add_int_mul (p : ℂ) (θ : ℝ) (m : ℤ) : ringPt p (θ + 2 * π * m) = ringPt p θ := by
  simp only [ringPt, e_add_int_mul]

/-- A germ's pseudo-colour reads its angle modulo `2π`. -/
theorem germPseudo_add_int_mul {k : ℕ} {F : ArcMap k} {p : ℂ} {θ : ℝ} (m : ℤ) {s : Side} {a : Fin k} :
    F.GermPseudo p (θ + 2 * π * m) s a ↔ F.GermPseudo p θ s a := by
  simp only [GermPseudo, GermIn, germ_add_int_mul]

/-- Closed ring arcs read their angles modulo `2π`. -/
theorem ringArc_add_int_mul (p : ℂ) (s t : ℝ) (m : ℤ) : ringArc p (s + 2 * π * m) (t + 2 * π * m) = ringArc p s t := by
  ext z
  constructor
  · rintro ⟨θ, hθ, rfl⟩
    refine ⟨θ - 2 * π * m, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ?_⟩
    rw [← ringPt_add_int_mul p (θ - 2 * π * m) m, sub_add_cancel]
  · rintro ⟨θ, hθ, rfl⟩
    exact ⟨θ + 2 * π * m, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ringPt_add_int_mul p θ m⟩

/-- Returning arcs read their angles modulo `2π`. -/
theorem IsRetArc.add_int_mul {k : ℕ} {F : ArcMap k} {p : ℂ} {s t : ℝ} (h : F.IsRetArc p s t) (m : ℤ) :
    F.IsRetArc p (s + 2 * π * m) (t + 2 * π * m) := by
  obtain ⟨hst, hst', a, c, hac, h1, h2, h3, h4, T₁, T₂, hT₁, hT₂, K, hK, hsK, htK, hKsub⟩ := h
  refine ⟨by linarith, by linarith, a, c, hac, (germPseudo_add_int_mul m).mpr h1, (germPseudo_add_int_mul m).mpr h2,
    (germPseudo_add_int_mul m).mpr h3, (germPseudo_add_int_mul m).mpr h4, T₁, T₂, hT₁, hT₂, K, hK, ?_, ?_, hKsub⟩
  · rw [ringPt_add_int_mul]; exact hsK
  · rw [ringPt_add_int_mul]; exact htK

/-- Every returning arc is a translate by a multiple of `2π` of one starting in `[0, 2π)`. -/
theorem IsRetArc.exists_Ico {k : ℕ} {F : ArcMap k} {p : ℂ} {s t : ℝ} (h : F.IsRetArc p s t) :
    ∃ m : ℤ, s + 2 * π * m ∈ Ico 0 (2 * π) ∧ F.IsRetArc p (s + 2 * π * m) (t + 2 * π * m) := by
  have hπ := Real.pi_pos
  refine ⟨-⌊s / (2 * π)⌋, ⟨?_, ?_⟩, h.add_int_mul _⟩
  · have h1 := Int.floor_le (s / (2 * π))
    have h2 : (⌊s / (2 * π)⌋ : ℝ) * (2 * π) ≤ s := by rwa [le_div_iff₀ (by positivity)] at h1
    push_cast; nlinarith
  · have h1 := Int.lt_floor_add_one (s / (2 * π))
    have h2 : s < ((⌊s / (2 * π)⌋ : ℝ) + 1) * (2 * π) := by rwa [div_lt_iff₀ (by positivity)] at h1
    push_cast; nlinarith


/-- The pseudo-colouring's injection `g` of `ℤ/3` into the colours absent at `u` is onto them (three of each). -/
theorem exists_eq_of_absent {k : ℕ} {F : ArcMap k} {u : ℂ} (hu : (F.coloursAt u).ncard = 3) (hk : Nat.card (Fin k) = 6)
    {g : ZMod 3 → Fin k} (hg : Function.Injective g) (hgu : ∀ v, g v ∉ F.coloursAt u) {j : Fin k} (hj : j ∉ F.coloursAt u) :
    ∃ v, g v = j := by
  have hsub : range g ⊆ (F.coloursAt u)ᶜ := by rintro _ ⟨v, rfl⟩; exact hgu v
  have hcard : (F.coloursAt u)ᶜ.ncard ≤ (range g).ncard := by
    rw [Set.ncard_compl, hk, hu, Set.ncard_range_of_injective hg, Nat.card_eq_fintype_card, ZMod.card]
  have heq := Set.eq_of_subset_of_ncard_le hsub hcard
  have : j ∈ range g := heq ▸ hj
  exact this

/-- **A returning arc is removable** for the pseudo-colouring's circle colouring (FS110-CD Lemma R step 3, `BaseCtx.retArc_partner`, read
through the bridge `exists_pseudoCircle` gives). -/
theorem BaseCtx.removable (B : F.BaseCtx u) {C : CircleColouring} {g : ZMod 3 → Fin 6} (hg : Function.Injective g)
    (hgu : ∀ v, g v ∉ F.coloursAt u) (hL : ∀ θ v, C.LeftVal θ v ↔ F.GermPseudo u θ .cw (g v))
    (hR : ∀ θ v, C.RightVal θ v ↔ F.GermPseudo u θ .ccw (g v)) {s t : ℝ} (h : F.IsRetArc u s t) : C.Removable s t := by
  obtain ⟨hst, hst', a, c, hac, ha, hc, hc', ha', -⟩ := id h
  have hk : Nat.card (Fin 6) = 6 := by simp
  obtain ⟨v, rfl⟩ := exists_eq_of_absent B.cubic.2 hk hg hgu ha.mem_pseudoColours.2
  obtain ⟨w, rfl⟩ := exists_eq_of_absent B.cubic.2 hk hg hgu hc.mem_pseudoColours.2
  have hvw : v ≠ w := fun h => hac (h ▸ rfl)
  have h1 := (hL s v).mpr ha
  have h2 := (hR s w).mpr hc
  have h3 := (hL t w).mpr hc'
  have h4 := (hR t v).mpr ha'
  refine ⟨hst, hst', C.mem_S_of_ne h1 h2 hvw, C.mem_S_of_ne h3 h4 hvw.symm, v, w, hvw, h1, h2, h3, h4, ?_⟩
  intro x hx y hy hyS
  have hpart := B.retArc_partner h hx ha hc y hy
  have hy' := (hL y (C.c y)).mp (C.leftVal_of_not_mem hyS)
  have hmem := hy'.mem_pseudoColours
  exact ⟨fun h' => hpart.1 (h' ▸ hmem), fun h' => hpart.2 (h' ▸ hmem)⟩

/-- **The endpoint of a change point and its third colour** (the walk's step from the selection to Lemma 4's count): a change point
`r(x)` of the pseudo-colouring of `ω(u)` with the absent pair `{a, b}` on its two sides, outside every returning arc, has an endpoint `p`
(`BaseCtx.exists_endpoint`) in `B̄(u, 1)`, inside `B(u, 1)` or V-in, carrying `a`, `b` and one colour `t` of `u` — not the third absent
colour, else `p` would be complementary to `u` within `1` of it (`BaseCtx.cor3_base`) — and an `a`-tile whose closure holds `r(x)` and `p`. -/
theorem BaseCtx.exists_endpoint_third (B : F.BaseCtx u) {x : ℝ} {a b : Fin 6} (hab : a ≠ b) (hau : a ∉ F.coloursAt u)
    (hbu : b ∉ F.coloursAt u)
    (hgerm : (F.GermPseudo u x .cw a ∧ F.GermPseudo u x .ccw b) ∨ (F.GermPseudo u x .cw b ∧ F.GermPseudo u x .ccw a))
    (hout : ∀ s t, F.IsRetArc u s t → ringPt u x ∉ ringArc u s t) :
    ∃ p t, p ∈ closedBall u 1 ∧ (p ∈ ball u 1 ∨ F.VIn u p) ∧ t ∈ F.coloursAt u ∧
      F.coloursAt p = insert t {a, b} ∧ ∃ T, F.TileOf a T ∧ ringPt u x ∈ closure T ∧ p ∈ closure T := by
  obtain ⟨p, hp3, hpin, T, hT, hxT, hpT, hbp⟩ : ∃ p, (F.coloursAt p).ncard = 3 ∧ (p ∈ ball u 1 ∨ F.VIn u p) ∧ ∃ T, F.TileOf a T ∧
      ringPt u x ∈ closure T ∧ p ∈ closure T ∧ b ∈ F.coloursAt p := by
    rcases hgerm with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · obtain ⟨p, hp3, hpin, T₁, T₂, hT₁, hT₂, hx₁, -, hp₁, hp₂⟩ := B.exists_endpoint hab h1 (Or.inl h2) hout
      exact ⟨p, hp3, hpin, T₁, hT₁, hx₁, hp₁, mem_coloursAt_of_tileOf hT₂ hp₂⟩
    · obtain ⟨p, hp3, hpin, T₁, T₂, hT₁, hT₂, -, hx₂, hp₁, hp₂⟩ := B.exists_endpoint hab.symm h1 (Or.inl h2) hout
      exact ⟨p, hp3, hpin, T₂, hT₂, hx₂, hp₂, mem_coloursAt_of_tileOf hT₁ hp₁⟩
  have hap : a ∈ F.coloursAt p := mem_coloursAt_of_tileOf hT hpT
  have hpu : p ∈ closedBall u 1 := by
    rcases hpin with h | h
    · exact ball_subset_closedBall h
    · rw [mem_closedBall]; exact h.1.le
  obtain ⟨t, htp, htu⟩ : ∃ t ∈ F.coloursAt p, t ∈ F.coloursAt u := by
    by_contra hno
    push Not at hno
    have hdis : Disjoint (F.coloursAt u) (F.coloursAt p) := Set.disjoint_left.mpr fun j hju hjp => hno j hjp hju
    have h2 := B.cor3_base (mem_closedBall_self zero_le_one) hpu B.cubic
      (B.cubic_of_three (closedBall_subset_closedBall (by norm_num) hpu) hp3) hdis
    rw [mem_closedBall, dist_comm] at hpu
    linarith
  have hta : t ≠ a := fun h => hau (h ▸ htu)
  have htb : t ≠ b := fun h => hbu (h ▸ htu)
  have hsub : insert t ({a, b} : Set (Fin 6)) ⊆ F.coloursAt p := by
    simp only [insert_subset_iff, singleton_subset_iff]; exact ⟨htp, hap, hbp⟩
  have hcard : (insert t ({a, b} : Set (Fin 6))).ncard = 3 := by
    rw [Set.ncard_insert_of_notMem (by simp only [mem_insert_iff, mem_singleton_iff, not_or]; exact ⟨hta, htb⟩),
      Set.ncard_pair hab]
  exact ⟨p, t, hpu, hpin, htu, (Set.eq_of_subset_of_ncard_le hsub (by rw [hp3, hcard])).symm, T, hT, hxT, hpT⟩

/-- **Two endpoints of one pair have different colours of `u`** (FS110-CB D5's count; `[SokolovVoronov2025]` Lemma 4): two endpoints of
one absent pair `{a, b}` with one multicolour, reached through `a`-tiles from points more than `1` apart, would be at distance in `[1, 2]`
(`endpoint_dist_ge`), not `1` (`pair_P'`), not `2` (`BaseCtx.vin_antipodal`: two antipodal V-in points of one colour of `u`), so in
`(1, 2)`, against Lemma 3 (`BaseCtx.l3_base`). -/
theorem BaseCtx.third_ne (B : F.BaseCtx u) {a b t : Fin 6} (hab : a ≠ b) (hau : a ∉ F.coloursAt u) (hbu : b ∉ F.coloursAt u)
    (htu : t ∈ F.coloursAt u) {X X' p p' : ℂ} (hp : p ∈ closedBall u 1) (hp' : p' ∈ closedBall u 1)
    (hpin : p ∈ ball u 1 ∨ F.VIn u p) (hpin' : p' ∈ ball u 1 ∨ F.VIn u p')
    (hcp : F.coloursAt p = insert t {a, b}) (hcp' : F.coloursAt p' = insert t {a, b})
    {T T' : Set ℂ} (hT : F.TileOf a T) (hT' : F.TileOf a T') (hX : X ∈ closure T) (hX' : X' ∈ closure T')
    (hpT : p ∈ closure T) (hpT' : p' ∈ closure T') (hXX : 1 < dist X X') : False := by
  have hta : t ≠ a := fun h => hau (h ▸ htu)
  have htb : t ≠ b := fun h => hbu (h ▸ htu)
  have h3 : (insert t ({a, b} : Set (Fin 6))).ncard = 3 := by
    rw [Set.ncard_insert_of_notMem (by simp only [mem_insert_iff, mem_singleton_iff, not_or]; exact ⟨hta, htb⟩),
      Set.ncard_pair hab]
  have hc2 : ∀ {z : ℂ}, z ∈ closedBall u 1 → z ∈ closedBall u 2 := fun hz => closedBall_subset_closedBall (by norm_num) hz
  have hcub := B.cubic_of_three (hc2 hp) (by rw [hcp, h3])
  have hcub' := B.cubic_of_three (hc2 hp') (by rw [hcp', h3])
  have hge := endpoint_dist_ge B.valid hT hT' hX hX' hpT hpT' hXX
  have hne1 := pair_P' B.valid hcub hcub' (B.covers (hc2 hp)) (B.covers (hc2 hp')) (hcp.trans hcp'.symm)
  -- the only colour of `u` at `p` is `t`
  have honly : ∀ {z : ℂ}, F.coloursAt z = insert t {a, b} → ∀ j ∈ F.coloursAt u, j ∈ F.coloursAt z → j = t := by
    intro z hz j hju hjz
    rw [hz] at hjz
    rcases hjz with h | h | h
    · exact h
    · exact absurd (h ▸ hju) hau
    · exact absurd ((mem_singleton_iff.mp h) ▸ hju) hbu
  have hne2 : dist p p' ≠ 2 := by
    intro h2
    rcases hpin with hpb | hpv
    · have := dist_triangle p u p'
      rw [mem_ball] at hpb; rw [mem_closedBall, dist_comm] at hp'; linarith
    rcases hpin' with hpb' | hpv'
    · have := dist_triangle p u p'
      rw [mem_ball, dist_comm] at hpb'; rw [mem_closedBall] at hp; linarith
    obtain ⟨hpu, i, hiu, Ti, hTi, hpTi, hTiu⟩ := hpv
    obtain ⟨hpu', i', hiu', Ti', hTi', hpTi', hTiu'⟩ := hpv'
    have hi : i = t := honly hcp i hiu (mem_coloursAt_of_tileOf hTi hpTi)
    have hi' : i' = t := honly hcp' i' hiu' (mem_coloursAt_of_tileOf hTi' hpTi')
    subst hi hi'
    exact B.vin_antipodal hiu hpu hpu' ⟨Ti, hTi, hpTi, hTiu⟩ ⟨Ti', hTi', hpTi', hTiu'⟩ h2
  have hle : dist p p' ≤ 2 := by
    have := dist_triangle p u p'
    rw [mem_closedBall] at hp hp'; rw [dist_comm] at hp'; linarith
  exact B.l3_base hp hp' hcub hcub' (hcp.trans hcp'.symm) (lt_of_le_of_ne hge (Ne.symm hne1))
    (lt_of_le_of_ne hle hne2)

/-- **The walk, assembled** (FS112-N3-BASE; `Row134BaseUA`'s proof, KB's plan § 4 leaf F1): no base context exists. The pseudo-colouring of
`ω(u)` is a circle colouring with no swap point (`exists_pseudoCircle`); its returning arcs are removable and nest or are disjoint
(`removable`, `retArcs_finite`, `retArcs_nested`), so `reduce` leaves a colouring with no swap point whose change points are the original's,
outside every returning arc; `select` gives the hexagon — a `HexRing` of the map (`rot_noThird`), refuted by `p17_ua` — or, for each absent
pair, three change points pairwise more than `1` apart, whose endpoints (`exists_endpoint_third`) carry three different colours of `u`
(`third_ne`); the eleventh point's complement is then one endpoint's type (`eleventh_type`), a complementary pair within `2`
(`cor3_base`) and at distance `2` only antipodally on `ω(u)`, which `eleventh_antipodal` excludes. -/
theorem BaseCtx.false (B : F.BaseCtx u) : False := by
  classical
  obtain ⟨C, g, hg, hgu, hL, hR, -, hns⟩ := B.exists_pseudoCircle (mem_closedBall_self zero_le_one) B.cubic
  have hk : Nat.card (Fin 6) = 6 := by simp
  set 𝓙 : Set (ℝ × ℝ) := {q | q.1 ∈ Ico 0 (2 * π) ∧ F.IsRetArc u q.1 q.2} with h𝓙
  have hringArc : ∀ s t, ringArc u s t = (fun z => u + z) '' (e '' Icc s t) := fun s t => by
    rw [Set.image_image]; rfl
  have hnest : ∀ q ∈ 𝓙, ∀ q' ∈ 𝓙, Disjoint (e '' Icc q.1 q.2) (e '' Icc q'.1 q'.2) ∨ e '' Icc q.1 q.2 ⊆ e '' Icc q'.1 q'.2 ∨
      e '' Icc q'.1 q'.2 ⊆ e '' Icc q.1 q.2 := by
    intro q hq q' hq'
    have hinj : Function.Injective (fun z : ℂ => u + z) := add_right_injective u
    rcases B.retArcs_nested hq.2 hq'.2 with h | h | h
    · left
      rw [hringArc, hringArc] at h
      exact Set.disjoint_left.mpr fun z hz hz' => Set.disjoint_left.mp h (mem_image_of_mem _ hz) (mem_image_of_mem _ hz')
    · right; left
      rw [hringArc, hringArc, Set.image_subset_image_iff hinj] at h; exact h
    · right; right
      rw [hringArc, hringArc, Set.image_subset_image_iff hinj] at h; exact h
  obtain ⟨C', hns', hC'⟩ := C.reduce hns 𝓙 B.retArcs_finite (fun q hq => B.removable hg hgu hL hR hq.2) hnest
  -- at a change point of `C′`: the map's germs, and no returning arc
  have hgerm : ∀ x ∈ C'.S, ∀ v, (C'.LeftVal x v → F.GermPseudo u x .cw (g v)) ∧ (C'.RightVal x v → F.GermPseudo u x .ccw (g v)) := by
    intro x hx v
    obtain ⟨-, -, hval⟩ := hC' x hx
    exact ⟨fun h => (hL x v).mp ((hval v).1.mp h), fun h => (hR x v).mp ((hval v).2.mp h)⟩
  have hout : ∀ x ∈ C'.S, ∀ s t, F.IsRetArc u s t → ringPt u x ∉ ringArc u s t := by
    intro x hx s t hst hmem
    obtain ⟨-, hnot, -⟩ := hC' x hx
    obtain ⟨m, hm, hst'⟩ := hst.exists_Ico
    rw [← ringArc_add_int_mul u s t m] at hmem
    obtain ⟨θ, hθ, hθx⟩ := hmem
    have he : e θ = e x := by simpa [ringPt] using hθx
    exact hnot (s + 2 * π * m, t + 2 * π * m) ⟨hm, hst'⟩ ⟨θ, hθ, he⟩
  rcases C'.select hns' with ⟨ψ, b, hb, hhex⟩ | hsel
  · -- the hexagon: a `HexRing` of the map, against Prop. 17 with unit arcs
    refine p17_ua B.valid B.covers B.cubic B.hyp (ψ := ψ) (b := g ∘ b) ⟨hg.comp hb, fun j hj => ?_⟩
    obtain ⟨hl, hr⟩ := hhex j hj
    have hne : b j ≠ b (j + 1) := by
      refine hb.ne fun h => ?_
      have h' : (1 : ZMod 3) = 0 := by linear_combination -h
      exact absurd h' (by decide)
    have hx := C'.mem_S_of_ne hl hr hne
    have h1 := (hgerm _ hx _).1 hl
    have h2 := (hgerm _ hx _).2 hr
    exact ⟨rot_noThird B.valid B.covers B.cubic B.hyp (hg.ne hne) h1 h2, h1, h2⟩
  · -- three endpoints per absent pair, with three different colours of `u`
    have hpair : ∀ P : Finset (Fin 6), ∃ (t : Fin 3 → Fin 6) (p : Fin 3 → ℂ), P ⊆ (F.coloursAt u).toFinsetᶜ → P.card = 2 →
        Function.Injective t ∧ ∀ i, t i ∈ (F.coloursAt u).toFinset ∧ p i ∈ closedBall u 1 ∧ (p i ∈ ball u 1 ∨ F.VIn u (p i)) ∧
          F.coloursAt (p i) = ↑(insert (t i) P) := by
      intro P
      by_cases hP : P ⊆ (F.coloursAt u).toFinsetᶜ ∧ P.card = 2
      · obtain ⟨hPU, hP2⟩ := hP
        obtain ⟨a, c, hac, rfl⟩ := Finset.card_eq_two.mp hP2
        have hau : a ∉ F.coloursAt u := by
          have := hPU (Finset.mem_insert_self a {c}); simpa using this
        have hcu : c ∉ F.coloursAt u := by
          have := hPU (Finset.mem_insert_of_mem (Finset.mem_singleton_self c)); simpa using this
        obtain ⟨v, rfl⟩ := exists_eq_of_absent B.cubic.2 hk hg hgu hau
        obtain ⟨w, rfl⟩ := exists_eq_of_absent B.cubic.2 hk hg hgu hcu
        have hvw : v ≠ w := fun h => hac (h ▸ rfl)
        obtain ⟨x, hxc, hxd⟩ := hsel v w hvw
        have hend : ∀ i, ∃ p t, p ∈ closedBall u 1 ∧ (p ∈ ball u 1 ∨ F.VIn u p) ∧ t ∈ F.coloursAt u ∧
            F.coloursAt p = insert t {g v, g w} ∧ ∃ T, F.TileOf (g v) T ∧ ringPt u (x i) ∈ closure T ∧ p ∈ closure T := by
          intro i
          obtain ⟨hxS, hlr⟩ := hxc i
          refine B.exists_endpoint_third hac hau hcu ?_ (hout _ hxS)
          rcases hlr with ⟨h1, h2⟩ | ⟨h1, h2⟩
          · exact Or.inl ⟨(hgerm _ hxS _).1 h1, (hgerm _ hxS _).2 h2⟩
          · exact Or.inr ⟨(hgerm _ hxS _).1 h1, (hgerm _ hxS _).2 h2⟩
        choose p t hpu hpin htu hcp T hT hxT hpT using hend
        refine ⟨t, p, fun _ _ => ⟨fun i j hij => ?_, fun i => ⟨by simpa using htu i, hpu i, hpin i, ?_⟩⟩⟩
        · by_contra hne
          have hd : 1 < dist (ringPt u (x i)) (ringPt u (x j)) := by
            rw [dist_eq_norm, show ringPt u (x i) - ringPt u (x j) = e (x i) - e (x j) by simp only [ringPt]; ring]
            exact hxd i j hne
          exact B.third_ne hac hau hcu (htu i) (hpu i) (hpu j) (hpin i) (hpin j) (hcp i) (hij ▸ hcp j) (hT i) (hT j) (hxT i) (hxT j)
            (hpT i) (hpT j) hd
        · rw [hcp i]; push_cast; rfl
      · exact ⟨fun _ => 0, fun _ => 0, fun h1 h2 => absurd ⟨h1, h2⟩ hP⟩
    choose tf pf hf using hpair
    -- the eleventh point, and its complementary endpoint
    obtain ⟨q, hq, hq3, hq2, hqT⟩ := B.exists_eleventh
    have hU : (F.coloursAt u).toFinset.card = 3 := by rw [← Set.ncard_eq_toFinset_card', B.cubic.2]
    have hQ : (F.coloursAt q).toFinset.card = 3 := by rw [← Set.ncard_eq_toFinset_card', hq3]
    have hQU : ((F.coloursAt q).toFinset ∩ (F.coloursAt u).toFinset).card = 2 := by
      rw [← Set.toFinset_inter, ← Set.ncard_eq_toFinset_card', hq2]
    obtain ⟨P, hPU, hP2, i, hQc⟩ := eleventh_type hU hQ hQU tf fun P hPU hP2 =>
      ⟨(hf P hPU hP2).1, fun i => ((hf P hPU hP2).2 i).1⟩
    obtain ⟨-, hpu, hpin, hcp⟩ := (hf P hPU hP2).2 i
    set p := pf P i
    have hcpq : F.coloursAt p = (F.coloursAt q)ᶜ := by
      rw [hcp, ← hQc, Finset.coe_compl, Set.coe_toFinset]
    have hdis : Disjoint (F.coloursAt q) (F.coloursAt p) := by rw [hcpq]; exact disjoint_compl_right
    have hc2 : ∀ {z : ℂ}, z ∈ closedBall u 1 → z ∈ closedBall u 2 := fun hz => closedBall_subset_closedBall (by norm_num) hz
    have hp3 : (F.coloursAt p).ncard = 3 := by
      rw [hcpq, Set.ncard_compl, hk, hq3]
    have h2 := B.cor3_base hq hpu (B.cubic_of_three (hc2 hq) hq3) (B.cubic_of_three (hc2 hpu) hp3) hdis
    rw [mem_closedBall] at hq hpu
    have htri := dist_triangle q u p
    rw [dist_comm u p] at htri
    have hqu : dist q u = 1 := by linarith
    have hpu' : dist p u = 1 := by linarith
    have hqp : dist q p = 2 := by linarith
    rcases hpin with hpb | hpv
    · rw [mem_ball] at hpb; linarith
    · exact B.eleventh_antipodal hqu hqT hq2 hpv hdis hqp

end ArcMap

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS112-N3-BASE, FS129-OR1-LOCALDENSE, FS112-N3-DENSE3 -/

/-- **The walk's assembly: row 134's base with unit arcs** (`Row134BaseUA`; FS112-N3-BASE's table, `plans/FS112-N-proof.md` stage N3-3,
NB3 § 1.4 steps 1–12; the leaves are `Plane/ValidMap/BaseWalk`'s, the assembly `plans/FS131-w5base-kernel-plan.md` § 4 leaf F1). Given the
base's context at `u`: the pseudo-colouring of `ω(u)` as a circle colouring (`exists_pseudoCircle`); the returning arcs removed (`reduce` over
`retArc_partner`, `retArcs_finite`, `retArcs_nested`); the selection (`select`) — its hexagon refuted by `hex_base`, else three change points per
absent pair, pairwise more than `1` apart, each with an endpoint (`exists_endpoint`); the eleventh point (`exists_eleventh`, from
`BaseCtx.unenclosed` by FS131-E4's E4-RIM); the count (`eleventh_type`) yields two endpoints with one multicolour or the eleventh point and a complementary endpoint; the first are
at distance in `[1, 2]` (`endpoint_dist_ge`, `vin_antipodal`) and not `1` (`pair_P'`), so `l3_base` refutes them; the second are at distance
below `2` (`eleventh_antipodal`), so `cor3_base` refutes them. No piece of `[SokolovVoronov2025]` enters by statement (plan § 2.1): the
eleventh point's sentence (p. 28) is proved from `UnenclosedC u` (E4-RIM). A refutation's engine: no model expected (`not_row134BaseUA_seven` shows six colours are
spent). -/
theorem row134BaseUA : Row134BaseUA := fun _ _ hF h2 hu hH hI hE => BaseCtx.false ⟨hF, h2, hu, hH, hI, hE⟩

/-- **The inert pre-bend** (FS112-N3-BASE's first step, NB3 § 1.4 step 4; FS112-N2-BENDS' toward bend; FS131-E4 E4-BEND-UN for the last
conjunct): the inert unit arcs centred within `1` of `u` — finitely many, by local finiteness on `B̄(u, 2)` — are bent toward their centres, each
lens inside a collar of its arc in the inner tile, and the bends iterated until none is left. The result is a valid fragment covering `B̄(u, 2)` in
which `u` is still cubic trichromatic, `B̄(u, 2)` still holds no point of `F(M) ∪ R(M)` (no point gains a colour or a sector), no inert unit arc is
centred within `1` of `u`, and no tile of a colour of `u` encloses a tile at `u` (each bend is induced by a homeomorphism of the plane fixing `u`,
E4-BEND-UN). A child of `n3_base` (KB's plan § 2.3, the strengthened-bend child it owes; E4 § 5.2's "the pre-bend keeps `UnenclosedC u`"). A step
inside a refutation: no model expected. -/
theorem exists_preBend {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hu2 : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
    (hE : F.UnenclosedC u) :
    ∃ M : ArcMap 6, M.Valid ∧ M.Covers u 2 ∧ M.IsCubicTrichromatic u ∧ M.BaseHyp u ∧ M.NoInertNear u ∧ M.UnenclosedC u := by
  sorry

/-- **FS112-N3-BASE** (caution C116: a regrade only), **with FS131-E4's hypothesis** (repair (b), inventory item 227): in a valid six-coloured
fragment covering `B̄(u, 2)`, a cubic trichromatic vertex `u` whose disc `B̄(u, 2)` holds no vertex of at least four colours and none with a
repeated colour, and no tile of a colour of which encloses a tile at `u` (`UnenclosedC u`, E4-N3BASE-UN), does not exist — "row 134's base refutes
the map near `u`", after the inert unit arcs centred within `1` of `u` are bent toward their centres (the proof: the pre-bend, `exists_preBend`,
then the walk, `row134BaseUA`). Stated on fragments (FS129-OR1-LOCALDENSE's reading: the base reads `B̄(u, 2)` alone). Without `UnenclosedC u`
the walk's eleventh point is open (E4-Q1, E4-Q2). A refutation: no model expected. -/
theorem n3_base {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hu2 : F.Covers u 2)
    (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u) (hE : F.UnenclosedC u) : False := by
  obtain ⟨M, hM, hM2, hMu, hMH, hMI, hME⟩ := exists_preBend hF hu2 hu hH hE
  exact row134BaseUA M u hM hM2 hMu hMH hMI hME

/-- **The outermost tile's rim** (FS131-E4 E4-OUTERMOST): within `1` of any point of a valid fragment there is a bad point, or a cubic trichromatic
vertex that no tile encloses. Any `k`. The argument (`plans/FS131-E4-derivation.md` § Argument for E4-OUTERMOST): tiles have diameter at most `1`,
so their hulls do; enclosure strictly grows hulls, so from a tile at `x` the chain of enclosing tiles stops inside `B̄(x, 1)` at a tile `T*` that no
tile encloses; the frontier of `T*`'s outer domain is connected (unicoherence of the plane) and borders two tiles of that domain, which meet it at a
common point `v`, cubic trichromatic and un-enclosed. A step of `localDense`'s proof (it replaces FS112-DISC1's vertex); its consumers are
refutations, and a model at seven colours is `sevenBrickMap` (a corner within `1` of any point). -/
theorem exists_unenclosed_or_bad {k : ℕ} {F : ArcMap k} (hF : F.Valid) {x : ℂ} {ρ : ℝ} (hρ : 0 < ρ)
    (hx : closedBall x (1 + ρ) ⊆ F.dom) :
    (∃ y ∈ closedBall x 1, y ∈ F.fourSet ∪ F.repSet) ∨ ∃ v ∈ closedBall x 1, F.IsCubicTrichromatic v ∧ F.Unenclosed v := by
  sorry

/-- **FS129-OR1-LOCALDENSE**: every valid six-coloured fragment on a closed disc `B̄(x, 3)` has, in `B̄(x, 3)`, a
vertex of at least four colours or a vertex with a repeated colour. The proof is FS131-E4's (E4-LOCALDENSE): `exists_unenclosed_or_bad` (with
`ρ = 2`) gives a bad point in `B̄(x, 1)` or an un-enclosed cubic trichromatic `v ∈ B̄(x, 1)`, and `n3_base` at `v` reads `B̄(v, 2) ⊆ B̄(x, 3)`.
No model held (no valid six-coloured fragment on a disc of radius `3` is known — the row's own model line); `GENERIC`. -/
theorem localDense {F : ArcMap 6} (hF : F.Valid) {x : ℂ} (hx : F.Covers x 3) :
    ∃ y ∈ closedBall x 3, y ∈ F.fourSet ∪ F.repSet := by
  have hx3 : closedBall x (1 + 2) ⊆ F.dom := by norm_num; exact hx
  rcases exists_unenclosed_or_bad hF (by norm_num : (0 : ℝ) < 2) hx3 with ⟨y, hy, hbad⟩ | ⟨v, hv, hcub, hun⟩
  · exact ⟨y, closedBall_subset_closedBall (by norm_num) hy, hbad⟩
  · have hsub : closedBall v 2 ⊆ closedBall x 3 := by
      intro z hz
      rw [mem_closedBall] at hz hv ⊢
      linarith [dist_triangle z v x]
    by_contra hno
    push Not at hno
    exact n3_base hF (hsub.trans hx) hcub (Set.disjoint_left.mpr fun z hz hzb => hno z (hsub hz) hzb) hun.unenclosedC

/-- **FS112-N3-DENSE3**: every closed disc of radius `3` of every valid six-coloured map of the plane holds a vertex of
at least four colours or a vertex with a repeated colour (`localDense` on the plane). No valid six-map of the plane is known (`GENERIC`). -/
theorem dense3 {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) :
    ∃ y ∈ closedBall x 3, y ∈ F.fourSet ∪ F.repSet :=
  localDense hF (fun z _ => hP ▸ mem_univ z)

/-! ## FS114-CV-EXISTS -/

/-- **FS114-CV-EXISTS**: every valid six-coloured map of the plane has a vertex of at least four colours, in the map
itself. The proof (FS114-CVB's route, `plans/FS114-CVB-verification.md` § 1.4) passes through `M*` (`exists_terminal`): with no such
vertex, `dense3` on `M*` gives a stuck vertex whose run is bi-infinite, against N4-FIN (`n4_fin`); a four-colour vertex of `M*` carries
its colours in the map (`IsModification.coloursAt_subset`). It uses neither CV-HD nor C-ENDS, and no strict bound (FS114-L60-WALK: over
`l60_le`). No valid six-map of the plane is known (`GENERIC`). -/
theorem cv_exists {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
    ∃ x, 4 ≤ (F.coloursAt x).ncard := by
  sorry

end ArcMap

end HadwigerNelson.Plane
