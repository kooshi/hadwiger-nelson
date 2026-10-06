import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk
import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar

/-!
# Row 134's base with unit arcs, and the density rows that rest on it

Moved from `Plane/ValidMap/Dense` by job FS131-KB (statements unchanged), downstream of the walk's leaves (`Plane/ValidMap/BaseWalk`):
`row134BaseUA` (the walk's assembly, `plans/FS131-w5base-kernel-plan.md` § 4) and its consumers FS112-N3-BASE (`n3_base`),
FS129-OR1-LOCALDENSE (`localDense`), FS112-N3-DENSE3 (`dense3`), FS114-CV-EXISTS (`cv_exists`).

FS131-E4's repair (b) (inventory item 227, `plans/FS131-E4-derivation.md` § 5.2): `Row134BaseUA` and `n3_base` carry `UnenclosedC u`; the
pre-bend keeps it (`exists_preBend`, E4-BEND-UN); `localDense` chooses its vertex by E4-OUTERMOST (`exists_unenclosed_or_bad`) in place of
FS112-DISC1's, so `localDense`, `dense3` and `cv_exists` keep their statements.

The walk's assembly (job FS131-I5f) is `BaseCtx.false`, with its glue before it: change points of a circle colouring (`mem_S_of_ne`), the
`2π`-periodicity of returning arcs (`IsRetArc.exists_Ico`, in `Plane/ValidMap/BaseWalk`), the removability of returning arcs (`BaseCtx.removable`), an endpoint's
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

/-- A closed arc of a circle inside a shorter-than-a-turn arc of it lies there in one lift: shifting the outer arc's ends by a
multiple of `2π` makes the parameter intervals nested. -/
theorem exists_shift_of_ringArc_subset {P : ℂ} {a b s t : ℝ} (hab : a ≤ b) (hlen : t - s < 2 * π)
    (h : ringArc P a b ⊆ ringArc P s t) : ∃ n : ℤ, s + 2 * π * n ≤ a ∧ b ≤ t + 2 * π * n := by
  have hπ := Real.pi_pos
  have lift : ∀ φ ∈ Icc a b, ∃ m : ℤ, φ + 2 * π * m ∈ Icc s t := by
    intro φ hφ
    obtain ⟨ψ, hψ, he⟩ := h ⟨φ, hφ, rfl⟩
    have he' : e ψ = e φ := by simpa [ringPt] using he
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp he'
    exact ⟨m, by rw [show φ + 2 * π * m = ψ by rw [hm]; ring]; exact hψ⟩
  obtain ⟨m, hm⟩ := lift a ⟨le_rfl, hab⟩
  refine ⟨-m, by push_cast; linarith [hm.1], ?_⟩
  by_contra hb
  push Not at hb
  push_cast at hb
  set δ := (2 * π - (t - s)) / 2 with hδ
  have hδ0 : 0 < δ := by rw [hδ]; linarith
  set φ := min b (t - 2 * π * m + δ) with hφ
  have hφ1 : t - 2 * π * m < φ := lt_min (by linarith) (by linarith)
  have hφ2 : φ ≤ t - 2 * π * m + δ := min_le_right _ _
  have hφa : a ≤ φ := by linarith [hm.2]
  obtain ⟨m', hm'⟩ := lift φ ⟨hφa, min_le_left _ _⟩
  -- `φ + 2π m' ∈ [s, t]` and `φ + 2π m ∈ (t, t + δ]`
  have h1 : t < φ + 2 * π * m := by linarith
  have h2 : φ + 2 * π * m ≤ t + δ := by linarith
  have hlt : (m' : ℝ) < m := by
    by_contra hge; push Not at hge
    have := mul_le_mul_of_nonneg_left hge (by linarith : (0 : ℝ) ≤ 2 * π)
    linarith [hm'.2]
  have hle : (m' : ℝ) ≤ m - 1 := by
    have : m' ≤ m - 1 := by exact_mod_cast (show m' < m by exact_mod_cast hlt) |> Int.le_sub_one_of_lt
    exact_mod_cast this
  have := mul_le_mul_of_nonneg_left hle (by linarith : (0 : ℝ) ≤ 2 * π)
  linarith [hm'.1]

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

/-! ## `exists_preBend`'s iteration (job FS131-KB2; `plans/FS131-I5-implementation.md` § 41.3): the measure, its children, one bend -/

/-- **The maximal constant-sided unit arcs centred in `B̄(u, 1)`**, as sets — `exists_preBend`'s measure (record § 41.3). A set of
positive length on a unit circle determines its centre, and its interior points their side colours, so counting sets counts arcs. -/
def maxRingArcs (F : ArcMap k) (u : ℂ) : Set (Set ℂ) :=
  {S | ∃ P ∈ closedBall u 1, ∃ θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' ∧ S = ringArc P θ₁ θ₂ ∧
    ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' → ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂}

/-- A map with no arcs has no maximal unit arc (the measure's spec example). -/
example (u : ℂ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).maxRingArcs u = ∅ := by
  refine eq_empty_of_forall_notMem fun S hS => ?_
  obtain ⟨P, -, θ₁, θ₂, c, c', hA, -⟩ := hS
  have h := hA.2.1 ⟨θ₁, ⟨le_rfl, hA.1.le⟩, rfl⟩
  simp [Γ, ArcMap.const] at h

/-! ### Helpers for the three children FS131-I5q proved: arcs of one unit circle, their ends, the arcs near a compact set -/

/-- Ring points at angles less than a turn apart differ. -/
theorem ringPt_ne_of_abs_sub_lt (p : ℂ) {s t : ℝ} (h0 : s ≠ t) (h : |s - t| < 2 * π) : ringPt p s ≠ ringPt p t := by
  intro he
  have he' : e s = e t := by simpa [ringPt] using he
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he'
  have hπ := Real.pi_pos
  have h1 : |(n : ℝ)| * (2 * π) < 2 * π := by
    have : s - t = n * (2 * π) := by linarith
    rw [this, abs_mul, abs_of_pos (by positivity : 0 < 2 * π)] at h
    exact h
  have hn0 : n = 0 := by
    by_contra hne
    have : (1 : ℝ) ≤ |(n : ℝ)| := by
      have : (1 : ℤ) ≤ |n| := Int.one_le_abs hne
      exact_mod_cast this
    nlinarith
  rw [hn0] at hn
  exact h0 (by simpa using hn)

/-- A closed sub-arc of positive length of a unit circle has a point off any finite set. -/
theorem exists_mem_ringArc_notMem (p : ℂ) {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂) {C : Set ℂ} (hC : C.Finite) :
    ∃ y ∈ ringArc p θ₁ θ₂, y ∉ C := by
  have h := mem_closure_ringArc_diff_finite h12 hC (y := ringPt p θ₁) ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
  obtain ⟨y, hy⟩ := closure_nonempty_iff.mp ⟨_, h⟩
  exact ⟨y, hy.1, hy.2⟩

/-- **A unit circle is fixed by any of its arcs of positive length**: an arc of `ω(Q)` inside `ω(P)` has `Q = P`. -/
theorem eq_of_ringArc_subset_sphere {Q P : ℂ} {s t : ℝ} (hst : s < t) (h : ringArc Q s t ⊆ sphere P 1) : Q = P := by
  have hπ := Real.pi_pos
  set t' := min t (s + 1) with ht'
  have hst' : s < t' := lt_min hst (by linarith)
  have hnd : (Arc.circ Q 1 s t').Nondegenerate := ⟨one_pos, hst', (min_le_right _ _).trans (by linarith [Real.pi_gt_three])⟩
  have hcar : (Arc.circ Q 1 s t').carrier = ringArc Q s t' := by
    simp [Arc.carrier, ringArc, ringPt]
  rcases Arc.finite_inter_sphere_or_eq_circ _ hnd P with hfin | ⟨θ₀, θ₁, heq⟩
  · exfalso
    obtain ⟨y, hy, hyC⟩ := exists_mem_ringArc_notMem Q hst' hfin
    refine hyC ⟨hcar ▸ hy, h ?_⟩
    obtain ⟨θ, hθ, rfl⟩ := hy
    exact ⟨θ, ⟨hθ.1, hθ.2.trans (min_le_left _ _)⟩, rfl⟩
  · exact (Arc.circ.inj heq).1

/-- **Finitely many arcs meet a compact part of the domain** (local finiteness and compactness). `GENERIC`. -/
theorem finite_arcs_meeting_compact (F : ArcMap k) {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {a | a ∈ F.arcs ∧ (a.carrier ∩ K).Nonempty}.Finite := by
  choose! t ht hfin using F.locallyFinite
  obtain ⟨S, hSK, hcov⟩ := hK.elim_nhds_subcover t fun y hy => ht y (hKd hy)
  refine (S.finite_toSet.biUnion fun y hy => hfin y (hKd (hSK y hy))).subset ?_
  rintro a ⟨ha, z, hza, hzK⟩
  obtain ⟨y, hyS, hzy⟩ := mem_iUnion₂.mp (hcov hzK)
  exact mem_iUnion₂.mpr ⟨y, hyS, ha, z, hza, hzy⟩

/-- A ring arc read in another lift: shifting both ends by a multiple of `2π` keeps it. -/
theorem IsRingArc.shift {P : ℂ} {s t : ℝ} {c c' : Fin k} (hA : F.IsRingArc P s t c c') (n : ℤ) :
    F.IsRingArc P (s + 2 * π * n) (t + 2 * π * n) c c' := by
  refine ⟨by linarith [hA.1], by rw [ringArc_add_two_pi_mul]; exact hA.2.1, fun θ hθ => ?_⟩
  have h := hA.2.2 (θ - 2 * π * n) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  have hr : ringPt P (θ - 2 * π * n) = ringPt P θ := by
    rw [show θ - 2 * π * n = θ + 2 * π * ((-n : ℤ) : ℝ) by push_cast; ring, ringPt_add_int_mul]
  rwa [hr] at h

/-- Two arcs of one unit circle with constant sides that share an interior point have the same sides. `GENERIC`. -/
theorem IsRingArc.sides_eq_of_ringPt_eq {p : ℂ} {a b a' b' : ℝ} {c c' d d' : Fin k} (h : F.IsRingArc p a b c c')
    (h' : F.IsRingArc p a' b' d d') {t t' : ℝ} (ht : t ∈ Ioo a b) (ht' : t' ∈ Ioo a' b') (he : ringPt p t = ringPt p t') :
    c = d ∧ c' = d' := by
  have h1 := h.2.2 t ht
  have h2 := h'.2.2 t' ht'
  rw [he] at h1
  exact ⟨singleton_eq_singleton_iff.mp (h1.1.symm.trans h2.1), singleton_eq_singleton_iff.mp (h1.2.symm.trans h2.2)⟩

/-- Two arcs of one unit circle with the same constant sides whose parameter intervals overlap join into one. `GENERIC`. -/
theorem IsRingArc.union_of_overlap {p : ℂ} {a b a' b' : ℝ} {c c' : Fin k} (h : F.IsRingArc p a b c c')
    (h' : F.IsRingArc p a' b' c c') (hov : max a a' < min b b') : F.IsRingArc p (min a a') (max b b') c c' := by
  obtain ⟨⟨h1, h3⟩, h2, h4⟩ : (a < b ∧ a' < b) ∧ a < b' ∧ a' < b' := by
    simpa only [max_lt_iff, lt_min_iff] using hov
  refine ⟨lt_of_le_of_lt (min_le_left _ _) (lt_of_lt_of_le h1 (le_max_left _ _)), ?_, fun θ hθ => ?_⟩
  · rintro _ ⟨θ, hθ, rfl⟩
    have hl := min_le_iff.mp hθ.1
    have hr := le_max_iff.mp hθ.2
    by_cases hin : θ ∈ Icc a b
    · exact h.2.1 ⟨θ, hin, rfl⟩
    · refine h'.2.1 ⟨θ, ?_, rfl⟩
      rw [mem_Icc, not_and_or, not_le, not_le] at hin
      rcases hin with hin | hin
      · exact ⟨by rcases hl with hl | hl <;> [linarith; exact hl], by linarith⟩
      · exact ⟨by linarith, by rcases hr with hr | hr <;> [linarith; exact hr]⟩
  · have hl := min_lt_iff.mp hθ.1
    have hr := lt_max_iff.mp hθ.2
    by_cases hin : θ ∈ Ioo a b
    · exact h.2.2 θ hin
    · refine h'.2.2 θ ?_
      rw [mem_Ioo, not_and_or, not_lt, not_lt] at hin
      rcases hin with hin | hin
      · exact ⟨by rcases hl with hl | hl <;> [linarith; exact hl], by linarith⟩
      · exact ⟨by linarith, by rcases hr with hr | hr <;> [linarith; exact hr]⟩

/-- **The ends of a maximal arc are irregular angles**: at a regular end the arc would continue past it with the same sides
(`RegularAt`, `IsRingArc.union_of_overlap`), and an arc of at most `60°` (`l60_le`) is not the set of a longer one. `GENERIC`. -/
theorem IsRingArc.not_regularAt_of_max (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hmax : ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' →
      ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂) :
    ¬ F.RegularAt P θ₁ ∧ ¬ F.RegularAt P θ₂ := by
  have hπ := Real.pi_pos
  have h12 : θ₁ < θ₂ := hA.1
  -- a regular angle of the closed arc is interior to an arc with the same sides, and the union is the arc itself
  have key : ∀ θ ∈ Icc θ₁ θ₂, F.RegularAt P θ → ∃ a b, a < θ ∧ θ < b ∧ F.IsRingArc P (min θ₁ a) (max θ₂ b) c c' ∧
      ringArc P (min θ₁ a) (max θ₂ b) = ringArc P θ₁ θ₂ := by
    rintro θ hθ (hΓ | ⟨φ₁, φ₂, d, d', hD, φ, hφ, heφ⟩)
    · exact absurd (hA.2.1 ⟨θ, hθ, rfl⟩) hΓ
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp heφ
    have hD' := hD.shift (-n)
    set a := φ₁ + 2 * π * ((-n : ℤ) : ℝ) with ha
    set b := φ₂ + 2 * π * ((-n : ℤ) : ℝ) with hb
    have haθ : a < θ := by rw [ha]; push_cast; linarith [hφ.1]
    have hθb : θ < b := by rw [hb]; push_cast; linarith [hφ.2]
    have hov : max θ₁ a < min θ₂ b := by
      rw [max_lt_iff, lt_min_iff, lt_min_iff]
      exact ⟨⟨h12, lt_of_le_of_lt hθ.1 hθb⟩, lt_of_lt_of_le haθ hθ.2, haθ.trans hθb⟩
    obtain ⟨t, ht, ht'⟩ : ∃ t, t ∈ Ioo θ₁ θ₂ ∧ t ∈ Ioo a b := by
      refine ⟨(max θ₁ a + min θ₂ b) / 2, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;>
        linarith [le_max_left θ₁ a, le_max_right θ₁ a, min_le_left θ₂ b, min_le_right θ₂ b]
    obtain ⟨rfl, rfl⟩ := hA.sides_eq_of_ringPt_eq hD' ht ht' rfl
    have hU := hA.union_of_overlap hD' hov
    refine ⟨a, b, haθ, hθb, hU, hmax _ _ ?_ hU⟩
    rintro _ ⟨ψ, hψ, rfl⟩
    exact ⟨ψ, ⟨(min_le_left _ _).trans hψ.1, hψ.2.trans (le_max_left _ _)⟩, rfl⟩
  constructor
  · intro hreg
    obtain ⟨a, b, haθ, hθb, hU, heq⟩ := key θ₁ ⟨le_rfl, h12.le⟩ hreg
    have hl := l60_le hF hU
    have hmem : ringPt P (min θ₁ a) ∈ ringArc P θ₁ θ₂ := by
      rw [← heq]; exact ⟨_, ⟨le_rfl, hU.1.le⟩, rfl⟩
    obtain ⟨ψ, hψ, hψe⟩ := hmem
    have hmin : min θ₁ a = a := min_eq_right haθ.le
    refine ringPt_ne_of_abs_sub_lt P (s := ψ) (t := min θ₁ a) (by rw [hmin]; linarith [hψ.1]) ?_ hψe
    rw [abs_of_pos (by rw [hmin]; linarith [hψ.1])]
    linarith [hψ.2, le_max_left θ₂ b]
  · intro hreg
    obtain ⟨a, b, haθ, hθb, hU, heq⟩ := key θ₂ ⟨h12.le, le_rfl⟩ hreg
    have hl := l60_le hF hU
    have hmem : ringPt P (max θ₂ b) ∈ ringArc P θ₁ θ₂ := by
      rw [← heq]; exact ⟨_, ⟨hU.1.le, le_rfl⟩, rfl⟩
    obtain ⟨ψ, hψ, hψe⟩ := hmem
    have hmaxb : max θ₂ b = b := max_eq_right hθb.le
    refine ringPt_ne_of_abs_sub_lt P (s := max θ₂ b) (t := ψ) (by rw [hmaxb]; linarith [hψ.2]) ?_ hψe.symm
    rw [abs_of_pos (by rw [hmaxb]; linarith [hψ.2])]
    linarith [hψ.1, min_le_left θ₁ a]

/-- **Finitely many maximal arcs** (record § 41.3's finiteness child): in a valid fragment covering `B̄(u, 2)` the maximal constant-sided
unit arcs centred in `B̄(u, 1)` are finitely many. Their centres are centres of the finitely many arcs meeting `B̄(u, 2)` that are unit
circles (`finite_arcs_meeting_compact`, `Arc.finite_inter_sphere_or_eq_circ`: a unit arc of positive length lies on no other curve); about
one centre, a maximal arc read in the lift that starts in `[0, 2π)` ends at two irregular angles of the ring below `4π`
(`IsRingArc.not_regularAt_of_max`, `l60_le`), finitely many (`finite_not_regular`). `GENERIC`. -/
theorem finite_maxRingArcs (hF : F.Valid) {u : ℂ} (hu : F.Covers u 2) : (F.maxRingArcs u).Finite := by
  have hπ := Real.pi_pos
  -- the arcs meeting `B̄(u, 2)`, and the centres of the unit circles among them
  set 𝒜 : Set Arc := {a | a ∈ F.arcs ∧ (a.carrier ∩ closedBall u 2).Nonempty} with h𝒜def
  have h𝒜 : 𝒜.Finite := F.finite_arcs_meeting_compact (isCompact_closedBall u 2) hu
  set 𝒞 : Set ℂ := ⋃ a ∈ 𝒜, {v | ∃ θ₀ θ₁, a = Arc.circ v 1 θ₀ θ₁} with h𝒞def
  have h𝒞 : 𝒞.Finite := by
    refine h𝒜.biUnion fun a _ => Set.Subsingleton.finite ?_
    rintro v ⟨θ₀, θ₁, rfl⟩ w ⟨θ₀', θ₁', h⟩
    exact (Arc.circ.inj h).1
  -- the irregular angles of each centre's ring
  set Z : ℂ → Set ℝ := fun P => {θ | θ ∈ Icc 0 (4 * π) ∧ ¬ F.RegularAt P θ} with hZdef
  have hcov : ∀ P ∈ closedBall u 1, F.Covers P 1 := by
    intro P hP z hz
    apply hu
    rw [mem_closedBall] at hP hz ⊢
    linarith [dist_triangle z P u]
  have hZ : ∀ P ∈ closedBall u 1, (Z P).Finite := fun P hP => finite_not_regular (hcov P hP) (4 * π)
  refine ((h𝒞.inter_of_left (closedBall u 1)).biUnion fun P hP =>
    ((hZ P hP.2).prod (hZ P hP.2)).image fun q : ℝ × ℝ => ringArc P q.1 q.2).subset ?_
  rintro S ⟨P, hP, θ₁, θ₂, c, c', hA, rfl, hmax⟩
  have h12 := hA.1
  -- the centre is one of the circles' centres
  have hP𝒞 : P ∈ 𝒞 := by
    by_contra hno
    simp only [h𝒞def, mem_iUnion, not_exists] at hno
    have hC : (⋃ a ∈ 𝒜, a.carrier ∩ sphere P 1).Finite := by
      refine h𝒜.biUnion fun a ha => ?_
      rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) P with h | ⟨θ₀, θ₁', rfl⟩
      · exact h
      · exact absurd ⟨θ₀, θ₁', rfl⟩ (hno _ ha)
    obtain ⟨y, hy, hyC⟩ := exists_mem_ringArc_notMem P h12 hC
    apply hyC
    obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp (hA.2.1 hy).2
    obtain ⟨θ, -, rfl⟩ := hy
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, _, hya, hcov P hP |> fun _ => by
      rw [mem_closedBall] at hP ⊢
      have := dist_ringPt P θ
      linarith [dist_triangle (ringPt P θ) P u]⟩, hya, ringPt_mem_sphere P θ⟩
  -- the arc read in the lift that starts in `[0, 2π)`
  set n := ⌊θ₁ / (2 * π)⌋ with hn
  have h2π : 0 < 2 * π := by positivity
  have hn1 : (n : ℝ) ≤ θ₁ / (2 * π) := Int.floor_le _
  have hn2 : θ₁ / (2 * π) < n + 1 := Int.lt_floor_add_one _
  have hA' := hA.shift (-n)
  set φ₁ := θ₁ + 2 * π * ((-n : ℤ) : ℝ) with hφ₁
  set φ₂ := θ₂ + 2 * π * ((-n : ℤ) : ℝ) with hφ₂
  have hlo : 0 ≤ φ₁ := by
    rw [hφ₁]; push_cast
    have := (le_div_iff₀ h2π).mp hn1
    linarith
  have hhi : φ₁ < 2 * π := by
    rw [hφ₁]; push_cast
    have := (div_lt_iff₀ h2π).mp hn2
    linarith
  have heq : ringArc P φ₁ φ₂ = ringArc P θ₁ θ₂ := ringArc_add_two_pi_mul P θ₁ θ₂ (-n)
  have hl := l60_le hF hA'
  obtain ⟨hr1, hr2⟩ := hA'.not_regularAt_of_max hF (by rw [heq]; exact hmax)
  refine mem_iUnion₂.mpr ⟨P, ⟨hP𝒞, hP⟩, (φ₁, φ₂), ⟨⟨⟨hlo, by linarith⟩, hr1⟩, ⟨by linarith [hA'.1], by linarith⟩, hr2⟩, heq⟩

/-- **Every unit arc centred in `B̄(u, 1)` lies in a maximal one with its sides** (record § 41.3): the arcs of `ω(P)` with sides `c, c'`
containing it, of length at most `π/3` (`l60_le`), have an infimum and a supremum of ends, and the closed arc between them lies in `Γ`
(closed in the domain, which holds `B̄(u, 2)`) with the same sides at its interior points. `GENERIC`. -/
theorem exists_maxRingArc (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hP : P ∈ closedBall u 1) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∃ a b, ringArc P θ₁ θ₂ ⊆ ringArc P a b ∧ F.IsRingArc P a b c c' ∧
      ∀ θ₁' θ₂', ringArc P a b ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' → ringArc P θ₁' θ₂' = ringArc P a b := by
  have hπ := Real.pi_pos
  have h12 := hA.1
  -- the lifts of ring arcs with these sides containing `[θ₁, θ₂]`: their left and right ends
  set L : Set ℝ := {s | ∃ t, F.IsRingArc P s t c c' ∧ s ≤ θ₁ ∧ θ₂ ≤ t} with hL
  set R : Set ℝ := {t | ∃ s, F.IsRingArc P s t c c' ∧ s ≤ θ₁ ∧ θ₂ ≤ t} with hR
  have hLne : L.Nonempty := ⟨θ₁, θ₂, hA, le_rfl, le_rfl⟩
  have hRne : R.Nonempty := ⟨θ₂, θ₁, hA, le_rfl, le_rfl⟩
  have hLbdd : BddBelow L := ⟨θ₂ - π / 3, fun s ⟨t, hst, _, ht⟩ => by have := l60_le hF hst; linarith⟩
  have hRbdd : BddAbove R := ⟨θ₁ + π / 3, fun t ⟨s, hst, hs, _⟩ => by have := l60_le hF hst; linarith⟩
  set a := sInf L with ha
  set b := sSup R with hb
  have haθ : a ≤ θ₁ := csInf_le hLbdd ⟨θ₂, hA, le_rfl, le_rfl⟩
  have hbθ : θ₂ ≤ b := le_csSup hRbdd ⟨θ₁, hA, le_rfl, le_rfl⟩
  have hab : a < b := by linarith
  -- every interior parameter lies inside one member
  have hin : ∀ φ ∈ Ioo a b, ∃ s t, F.IsRingArc P s t c c' ∧ φ ∈ Ioo s t := by
    intro φ hφ
    by_cases h1 : φ ≤ θ₁
    · obtain ⟨s, ⟨t, hst, hs, ht⟩, hsφ⟩ := exists_lt_of_csInf_lt hLne hφ.1
      exact ⟨s, t, hst, hsφ, by linarith⟩
    by_cases h2 : θ₂ ≤ φ
    · obtain ⟨t, ⟨s, hst, hs, ht⟩, htφ⟩ := exists_lt_of_lt_csSup hRne hφ.2
      exact ⟨s, t, hst, by linarith, htφ⟩
    push Not at h1 h2
    exact ⟨θ₁, θ₂, hA, h1, h2⟩
  have hdom : ringArc P a b ⊆ F.dom := by
    rintro _ ⟨φ, -, rfl⟩
    apply hu
    rw [mem_closedBall] at hP ⊢
    have : dist (ringPt P φ) P = 1 := by simp [ringPt, dist_eq_norm, norm_e]
    linarith [dist_triangle (ringPt P φ) P u]
  have hAab : F.IsRingArc P a b c c' := by
    refine ⟨hab, ringArc_subset_Γ_of_finite hab hdom (toFinite {ringPt P a, ringPt P b}) ?_, fun φ hφ => ?_⟩
    · rintro _ ⟨⟨φ, hφ, rfl⟩, hne⟩
      have hφ' : φ ∈ Ioo a b := ⟨lt_of_le_of_ne hφ.1 (fun h => hne (by rw [← h]; exact mem_insert _ _)),
        lt_of_le_of_ne hφ.2 (fun h => hne (by rw [h]; exact mem_insert_of_mem _ (mem_singleton _)))⟩
      obtain ⟨s, t, hst, hφst⟩ := hin φ hφ'
      exact hst.2.1 ⟨φ, Ioo_subset_Icc_self hφst, rfl⟩
    · obtain ⟨s, t, hst, hφst⟩ := hin φ hφ
      exact hst.2.2 φ hφst
  refine ⟨a, b, ?_, hAab, fun θ₁' θ₂' hsub hA' => ?_⟩
  · rintro _ ⟨φ, hφ, rfl⟩
    exact ⟨φ, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, rfl⟩
  · have hl' := l60_le hF hA'
    obtain ⟨n, hn1, hn2⟩ := exists_shift_of_ringArc_subset hab.le (by linarith) hsub
    have hsh := hA'.shift n
    have hmemL : θ₁' + 2 * π * n ∈ L := ⟨θ₂' + 2 * π * n, hsh, by linarith, by linarith⟩
    have hmemR : θ₂' + 2 * π * n ∈ R := ⟨θ₁' + 2 * π * n, hsh, by linarith, by linarith⟩
    have e1 : θ₁' + 2 * π * n = a := le_antisymm hn1 (csInf_le hLbdd hmemL)
    have e2 : θ₂' + 2 * π * n = b := le_antisymm (le_csSup hRbdd hmemR) hn2
    rw [← ringArc_add_two_pi_mul P θ₁' θ₂' n, e1, e2]

/-- **An interior point of a unit arc carries at most its two side colours**: near it the arc's circle lies in `Γ`, so each colour class
approaches it from inside or from outside the circle. `GENERIC`. -/
theorem ncard_coloursAt_le_two_of_mem_openArc {P : ℂ} {θ₁ θ₂ θ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hθ : θ ∈ Ioo θ₁ θ₂) : (F.coloursAt (ringPt P θ)).ncard ≤ 2 := by
  obtain ⟨hin, hout⟩ := hA.2.2 θ hθ
  have hsub : F.coloursAt (ringPt P θ) ⊆ {c, c'} := by
    intro j hj
    -- a point of the class on `ω(P)` is a closure point of its part inside: the class is open there
    have hcov : F.region j ⊆ closure (F.region j ∩ ball P 1) ∪ (F.region j \ closedBall P 1) := by
      intro y hy
      rcases lt_trichotomy (dist y P) 1 with h | h | h
      · exact Or.inl (subset_closure ⟨hy, h⟩)
      · have hyc : y ∈ closure (ball P 1) := by rw [closure_ball P one_ne_zero, mem_closedBall]; exact h.le
        exact Or.inl ((F.isOpen_region j).inter_closure ⟨hy, hyc⟩)
      · exact Or.inr ⟨hy, fun h' => by rw [mem_closedBall] at h'; linarith⟩
    have hj' := closure_mono hcov hj
    rw [closure_union, closure_closure] at hj'
    rcases hj' with h | h
    · have : j ∈ F.innerColours P (ringPt P θ) := h
      rw [hin] at this; exact Or.inl this
    · have : j ∈ F.outerColours P (ringPt P θ) := h
      rw [hout] at this; exact Or.inr this
  calc (F.coloursAt (ringPt P θ)).ncard ≤ ({c, c'} : Set (Fin k)).ncard := Set.ncard_le_ncard hsub (Set.toFinite _)
    _ ≤ ({c'} : Set (Fin k)).ncard + 1 := Set.ncard_insert_le c {c'}
    _ = 2 := by rw [Set.ncard_singleton]

/-- **`hfree` from the base's hypothesis** (record § 41.2 item 4, inventory item 365 (2)): near each interior point `x` of a unit arc
centred in `B̄(u, 1)` — so `x ∈ B̄(u, 2)` — `Γ` is the arc's circle. `BaseHyp u` gives a chart at `x` whose sectors have distinct colours
(`exists_chart_of_noRep`), all carried at `x`, which carries at most the arc's two side colours
(`ncard_coloursAt_le_two_of_mem_openArc`): at most two germs. The two points of the arc at each small distance `s` from `x` lie on two
different branches, so the branches are the circle's. `hF` is idle. `GENERIC`. -/
theorem hfree_of_baseHyp (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hH : F.BaseHyp u) (hP : P ∈ closedBall u 1)
    {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1 := by
  intro θ hθ
  have _ := hF -- idle: the chart and `BaseHyp u` suffice; validity is not read
  have hπ := Real.pi_gt_three
  set x := ringPt P θ with hx
  have hxΓ : x ∈ F.Γ := hA.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  have hxB : x ∈ closedBall u 2 := by
    rw [mem_closedBall] at hP ⊢
    have := dist_ringPt P θ
    linarith [dist_triangle x P u]
  have hxbad : x ∉ F.fourSet ∪ F.repSet := fun h => Set.disjoint_left.mp hH hxB h
  obtain ⟨r₀, n, G, hC, -, -, f, hf, hsec⟩ := exists_chart_of_noRep (hu hxB) hxbad
  -- at most two germs: the sectors' colours are distinct colours at `x`, which carries at most two
  have hn2 : n ≤ 2 := by
    have hmem : ∀ i, f i ∈ F.coloursAt x := fun i =>
      closure_mono (hsec i) (hC.mem_closure_sector ⟨hC.pos, le_rfl⟩ i)
    have h2 : (F.coloursAt x).ncard ≤ 2 := ncard_coloursAt_le_two_of_mem_openArc hA hθ
    have hcard : (Finset.univ.image f).card = n := by
      rw [Finset.card_image_of_injective _ hf, Finset.card_univ, Fintype.card_fin]
    have hsub : (↑(Finset.univ.image f) : Set (Fin k)) ⊆ F.coloursAt x := by
      intro c hc; simp only [Finset.coe_image, Finset.coe_univ, image_univ, mem_range] at hc
      obtain ⟨i, rfl⟩ := hc; exact hmem i
    have := Set.ncard_le_ncard hsub (Set.toFinite _)
    rw [Set.ncard_coe_finset, hcard] at this
    omega
  -- a point of `Γ` near `x`, off `x`, is a branch point at its distance from `x`
  have hbr : ∀ z ∈ F.Γ, z ≠ x → dist z x < r₀ → ∃ l, z = branchPt x (G.β l) (G.κ l) (dist z x) := by
    intro z hz hzx hd
    have hmem : z ∈ (F.Γ ∩ ball x r₀) \ {x} := ⟨⟨hz, hd⟩, hzx⟩
    rw [hC.branches] at hmem
    obtain ⟨l, s, hs, rfl⟩ := mem_iUnion.mp hmem
    exact ⟨l, by rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]⟩
  set δ := min (min (θ - θ₁) (θ₂ - θ)) 1 with hδ
  have hδ0 : 0 < δ := lt_min (lt_min (by linarith [hθ.1]) (by linarith [hθ.2])) one_pos
  have hδ1 : δ ≤ 1 := min_le_right _ _
  have hδa : δ ≤ θ - θ₁ := (min_le_left _ _).trans (min_le_left _ _)
  have hδb : δ ≤ θ₂ - θ := (min_le_left _ _).trans (min_le_right _ _)
  have hsin : 0 < Real.sin (δ / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  refine ⟨min r₀ (2 * Real.sin (δ / 2)), lt_min hC.pos (by linarith), ?_⟩
  rintro z ⟨hz, hzb⟩
  by_cases hzx : z = x
  · rw [hzx]; exact ringPt_mem_sphere P θ
  rw [mem_ball] at hzb
  set s := dist z x with hs
  have hs0 : 0 < s := dist_pos.mpr hzx
  have hsr : s < r₀ := lt_of_lt_of_le hzb (min_le_left _ _)
  have hsδ : s / 2 < Real.sin (δ / 2) := by linarith [lt_of_lt_of_le hzb (min_le_right r₀ (2 * Real.sin (δ / 2)))]
  -- the two points of `ω(P)` at distance `s` from `x`
  set t := 2 * Real.arcsin (s / 2) with ht
  have ht0 : 0 < t := by
    have := Real.arcsin_pos.mpr (by linarith : 0 < s / 2)
    linarith
  have htδ : t < δ := by
    have h1 : Real.arcsin (s / 2) < Real.arcsin (Real.sin (δ / 2)) :=
      Real.arcsin_lt_arcsin (by linarith) hsδ (Real.sin_le_one _)
    rw [Real.arcsin_sin (by linarith) (by linarith)] at h1
    linarith
  have hsin_t : 2 * Real.sin (t / 2) = s := by
    rw [ht, show 2 * Real.arcsin (s / 2) / 2 = Real.arcsin (s / 2) by ring,
      Real.sin_arcsin (by linarith) (by linarith [Real.sin_le_one (δ / 2)])]
    ring
  have hdist : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → dist (ringPt P (θ + σ * t)) x = s := by
    intro σ hσ
    have habs : |θ + σ * t - θ| = t := by
      rcases hσ with rfl | rfl <;> simp [abs_of_pos ht0]
    rw [hx, dist_ringPt_ringPt P (by rw [habs]; linarith), habs, hsin_t]
  have hΓ : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ringPt P (θ + σ * t) ∈ F.Γ := by
    intro σ hσ
    refine hA.2.1 ⟨_, ?_, rfl⟩
    rcases hσ with rfl | rfl <;> constructor <;> linarith
  have hne : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → ringPt P (θ + σ * t) ≠ x := fun σ hσ h => by
    have := hdist σ hσ; rw [h, dist_self] at this; linarith
  obtain ⟨i, hi⟩ := hbr _ (hΓ 1 (Or.inl rfl)) (hne 1 (Or.inl rfl)) (by rw [hdist 1 (Or.inl rfl)]; exact hsr)
  obtain ⟨j, hj⟩ := hbr _ (hΓ (-1) (Or.inr rfl)) (hne (-1) (Or.inr rfl)) (by rw [hdist (-1) (Or.inr rfl)]; exact hsr)
  rw [hdist 1 (Or.inl rfl)] at hi
  rw [hdist (-1) (Or.inr rfl)] at hj
  have hij : i ≠ j := by
    rintro rfl
    refine ringPt_ne_of_abs_sub_lt P (s := θ + 1 * t) (t := θ + -1 * t) (by linarith) ?_ (hi.trans hj.symm)
    rw [abs_of_pos (by linarith)]; linarith
  obtain ⟨l, hl⟩ := hbr z hz hzx hsr
  have hlij : l = i ∨ l = j := by
    have h1 := l.isLt; have h2 := i.isLt; have h3 := j.isLt
    have h4 : (i : ℕ) ≠ j := fun h => hij (Fin.ext h)
    rcases (by omega : (l : ℕ) = i ∨ (l : ℕ) = j) with h | h
    · exact Or.inl (Fin.ext h)
    · exact Or.inr (Fin.ext h)
  rcases hlij with rfl | rfl
  · rw [hl, ← hi]; exact ringPt_mem_sphere P _
  · rw [hl, ← hj]; exact ringPt_mem_sphere P _

/-- **An interior point has no repeated colour**: near it the one sector is a ball. `GENERIC`. -/
theorem not_hasRepeatedColour_of_mem_interiorPts {x : ℂ} (hx : x ∈ F.interiorPts) : ¬ F.HasRepeatedColour x := by
  rintro ⟨c, hc⟩
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts x hx
  obtain ⟨r, h2, hr⟩ := (hc.and (Ioo_mem_nhdsGT hr₀)).exists
  have hU : F.interiorPts ∩ ball x r = ball x r := inter_eq_right.mpr ((ball_subset_ball hr.2.le).trans hball)
  have hsub : F.sectorsOf x r c ⊆ {ball x r} := by
    rintro S ⟨⟨y, hy, rfl, -⟩, -⟩
    rw [mem_singleton_iff, hU]
    rw [hU] at hy
    exact Subset.antisymm (connectedComponentIn_subset _ _)
      ((convex_ball x r).isPreconnected.subset_connectedComponentIn hy subset_rfl)
  have h1 := (Set.encard_le_encard hsub).trans_eq (encard_singleton _)
  have : (2 : ℕ∞) ≤ 1 := h2.trans h1
  exact absurd this (by norm_num)

/-- **The measure drops by the bent arc** (record § 41.3): a maximal arc `β` of the bent map `M` is one of `F`'s (R1), inside a maximal
`γ` of `F` (`exists_maxRingArc`). The open arcs of `γ` and of the bent arc `α` are disjoint: at a common point `hfree` puts a short arc of
`γ`'s circle on `α`'s, so the centres agree (`eq_of_ringArc_subset_sphere`), the sides agree there, and two maximal arcs with the same sides
that overlap are one (`IsRingArc.union_of_overlap`) — then `β ⊆ α` would put a point of the open bent arc on a unit arc of `M`, against R3. So
`γ` is an arc of `M` (R2), `β = γ` by `β`'s maximality in `M`, and `β ≠ α` by R3. `hM`, `hMu` are idle. `GENERIC`. -/
theorem maxRingArcs_subset_of_bend (hF : F.Valid) {M : ArcMap k} (hM : M.Valid) {u P : ℂ} (hu : F.Covers u 2)
    (hMu : M.Covers u 2) (hP : P ∈ closedBall u 1) {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hmax : ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' →
      ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1)
    (hR1 : ∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d')
    (hR2 : ∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
      M.IsRingArc Q a b d d')
    (hR3 : ∀ θ ∈ Ioo θ₁ θ₂, ¬ M.OnRingArc P (ringPt P θ)) :
    M.maxRingArcs u ⊆ F.maxRingArcs u \ {ringArc P θ₁ θ₂} := by
  have _ := hM -- idle: R1–R3 carry all that is read of `M`
  have _ := hMu -- idle, as `hM`
  rintro S ⟨Q, hQ, a, b, d, d', hB, rfl, hBmax⟩
  have hBF := hR1 Q a b d d' hB
  obtain ⟨a', b', hsub, hG, hGmax⟩ := exists_maxRingArc hF hu hQ hBF
  -- the open arc of `F`'s maximal arc through `β` misses the bent arc's
  have hdisj : Disjoint (ringPt Q '' Ioo a' b') (ringPt P '' Ioo θ₁ θ₂) := by
    rw [Set.disjoint_left]
    rintro x ⟨ψ, hψ, rfl⟩ ⟨θ, hθ, hx⟩
    obtain ⟨r, hr, hfr⟩ := hfree θ hθ
    -- the centres agree: a short arc of `ω(Q)` about the common point lies on `ω(P)`
    have hQP : Q = P := by
      set δ := min (min (ψ - a') (b' - ψ)) (r / 2) with hδ
      have hδ0 : 0 < δ := lt_min (lt_min (by linarith [hψ.1]) (by linarith [hψ.2])) (by linarith)
      have hδa : δ ≤ ψ - a' := (min_le_left _ _).trans (min_le_left _ _)
      have hδb : δ ≤ b' - ψ := (min_le_left _ _).trans (min_le_right _ _)
      have hδr : δ ≤ r / 2 := min_le_right _ _
      refine eq_of_ringArc_subset_sphere (s := ψ - δ) (t := ψ + δ) (by linarith) ?_
      rintro _ ⟨φ, hφ, rfl⟩
      refine hfr ⟨hG.2.1 ⟨φ, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, rfl⟩, ?_⟩
      rw [hx, mem_ball]
      calc dist (ringPt Q φ) (ringPt Q ψ) ≤ |φ - ψ| := dist_ringPt_ringPt_le Q φ ψ
        _ ≤ δ := by rw [abs_le]; constructor <;> linarith [hφ.1, hφ.2]
        _ < r := by linarith
    subst hQP
    -- the same sides, and so one maximal arc
    obtain ⟨rfl, rfl⟩ := hG.sides_eq_of_ringPt_eq hA hψ hθ hx.symm
    have he : e ψ = e θ := by simpa [ringPt] using hx.symm
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
    have hA' := hA.shift n
    have hov : max a' (θ₁ + 2 * π * n) < min b' (θ₂ + 2 * π * n) := by
      rw [max_lt_iff, lt_min_iff, lt_min_iff]
      exact ⟨⟨hG.1, by linarith [hψ.1, hθ.2]⟩, by linarith [hψ.2, hθ.1], by linarith [hA.1]⟩
    have hU := hG.union_of_overlap hA' hov
    have e1 := hGmax _ _ (by
      rintro _ ⟨φ, hφ, rfl⟩
      exact ⟨φ, ⟨(min_le_left _ _).trans hφ.1, hφ.2.trans (le_max_left _ _)⟩, rfl⟩) hU
    have e2 := hmax _ _ (by
      rw [← ringArc_add_two_pi_mul Q θ₁ θ₂ n]
      rintro _ ⟨φ, hφ, rfl⟩
      exact ⟨φ, ⟨(min_le_right _ _).trans hφ.1, hφ.2.trans (le_max_right _ _)⟩, rfl⟩) hU
    have hβα : ringArc Q a b ⊆ ringArc Q θ₁ θ₂ := by rw [← e2, e1]; exact hsub
    -- a point of `β` inside the open bent arc lies on a unit arc of `M` about `P`: against R3
    obtain ⟨y, hyβ, hyC⟩ := exists_mem_ringArc_notMem Q hB.1 (toFinite {ringPt Q θ₁, ringPt Q θ₂})
    obtain ⟨φ, hφ, rfl⟩ := hβα hyβ
    have hφ' : φ ∈ Ioo θ₁ θ₂ :=
      ⟨lt_of_le_of_ne hφ.1 fun h => hyC (by rw [← h]; exact mem_insert _ _),
        lt_of_le_of_ne hφ.2 fun h => hyC (by rw [h]; exact mem_insert_of_mem _ (mem_singleton _))⟩
    exact hR3 φ hφ' ⟨a, b, hB.1, hyβ, hB.2.1⟩
  have hGM := hR2 Q a' b' d d' hG hdisj
  have heq := hBmax a' b' hsub hGM
  refine ⟨⟨Q, hQ, a', b', d, d', hG, heq.symm, hGmax⟩, fun hS => ?_⟩
  rw [mem_singleton_iff] at hS
  have hmid : (θ₁ + θ₂) / 2 ∈ Ioo θ₁ θ₂ := ⟨by linarith [hA.1], by linarith [hA.1]⟩
  exact hR3 _ hmid ⟨θ₁, θ₂, hA.1, ⟨_, Ioo_subset_Icc_self hmid, rfl⟩, hS ▸ hB.2.1⟩

/-- **`UnenclosedC` is carried by a homeomorphism of the plane that is the identity off a bounded set and fixes `u`** (E4-BEND-UN's
argument): the bent map's tiles are the images of `F`'s, closures and complements are carried, and boundedness is kept. `GENERIC`. -/
theorem unenclosedC_of_homeomorph {M : ArcMap k} {h : ℂ ≃ₜ ℂ} {u : ℂ} {K : Set ℂ} (hK : Bornology.IsBounded K)
    (hhK : ∀ z ∉ K, h z = z) (hu : h u = u)
    (hint : ∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z))
    (hcol : ∀ z, M.coloursAt (h z) = F.coloursAt z) (hE : F.UnenclosedC u) : M.UnenclosedC u := by
  have hpre : h ⁻¹' M.interiorPts = F.interiorPts := Set.ext fun z => (hint z).1
  -- preimages of components, and of bounded sets
  have hcc : ∀ (A : Set ℂ) (y : ℂ), y ∈ A →
      h ⁻¹' connectedComponentIn A y = connectedComponentIn (h ⁻¹' A) (h.symm y) := by
    intro A y hy
    have := h.symm.image_connectedComponentIn hy
    rwa [h.image_symm] at this
  have hbdd : ∀ C : Set ℂ, Bornology.IsBounded C → Bornology.IsBounded (h ⁻¹' C) := by
    intro C hC
    refine (hK.closure.union hC).subset fun z hz => ?_
    by_cases hzK : z ∈ closure K
    · exact Or.inl hzK
    · exact Or.inr (by rw [← hhK z fun h' => hzK (subset_closure h')]; exact hz)
  have htile : ∀ S, M.IsTile S → F.IsTile (h ⁻¹' S) := by
    rintro S ⟨x, hx, rfl⟩
    exact ⟨h.symm x, (hint _).1.mp (by rw [h.apply_symm_apply]; exact hx), by rw [hcc _ _ hx, hpre]⟩
  intro c hc T S hT hS huS y hy
  have hc' : c ∈ F.coloursAt u := by rw [← hcol u, hu]; exact hc
  have hT₀ : F.TileOf c (h ⁻¹' T) := by
    refine ⟨htile T hT.1, fun z hz => ?_⟩
    have hzI : z ∈ F.interiorPts := (htile T hT.1).subset_interiorPts hz
    have h1 : M.col (h z) = c := hT.2 hz
    rw [mem_preimage, mem_singleton_iff, ← (hint z).2 hzI, h1]
  have hu₀ : u ∈ closure (h ⁻¹' S) := by rw [← h.preimage_closure, mem_preimage, hu]; exact huS
  have hy₀ : h.symm y ∈ h ⁻¹' S \ closure (h ⁻¹' T) := by
    rw [← h.preimage_closure]
    exact ⟨by rw [mem_preimage, h.apply_symm_apply]; exact hy.1, by rw [mem_preimage, h.apply_symm_apply]; exact hy.2⟩
  intro hb
  apply hE c hc' _ _ hT₀ (htile S hS) hu₀ _ hy₀
  have := hbdd _ hb
  rwa [hcc (closure T)ᶜ y hy.2, preimage_compl, h.preimage_closure] at this

/-- **One pre-bend** (record § 41.3's step): if an inert unit arc is centred within `1` of `u`, its maximal extension `α` is bent toward
its centre by `bend_toward_collar` (with `hfree` from `BaseHyp u` and `hlen` from `l60_le`); the bent map keeps every hypothesis of
`exists_preBend` (`h` fixes `u`, which lies on `Γ` off `α°`; a point moved into `B̄(u, 2)` was an interior point) and has strictly fewer
maximal arcs centred in `B̄(u, 1)`. A step inside a refutation: no model expected. -/
theorem exists_preBend_step (hF : F.Valid) {u : ℂ} (hu2 : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
    (hE : F.UnenclosedC u) (hI : ¬ F.NoInertNear u) :
    ∃ M : ArcMap k, M.Valid ∧ M.Covers u 2 ∧ M.IsCubicTrichromatic u ∧ M.BaseHyp u ∧ M.UnenclosedC u ∧
      M.maxRingArcs u ⊂ F.maxRingArcs u := by
  classical
  simp only [NoInertNear, not_forall, not_not, exists_prop] at hI
  obtain ⟨P, hP, θ₁, θ₂, c, c', hA, -, hc'⟩ := hI
  obtain ⟨a, b, -, hA', hmax⟩ := exists_maxRingArc hF hu2 hP hA
  have hfree := hfree_of_baseHyp hF hu2 hH hP hA'
  have hlen : b - a < 2 * π := by have := l60_le hF hA'; linarith [Real.pi_pos]
  have hαd : ringArc P a b ⊆ F.dom := fun z hz => (hA'.2.1 hz).1
  have hαc : IsCompact (ringArc P a b) := isCompact_Icc.image (by unfold ringPt e; fun_prop)
  obtain ⟨ε, hε, hεd⟩ := hαc.exists_thickening_subset_open F.isOpen_dom hαd
  obtain ⟨M, h, hMv, hdom, hsupp, hfix, hint, hcol, hdeg, hrep, hR1, hR2, hR3, -⟩ :=
    bend_toward_collar hF hA' hc' hlen hmax hfree hε
  have hMcov : M.Covers u 2 := by rw [Covers, hdom]; exact hu2
  -- `u` lies on `Γ` (three colours), off the open arc (two colours there): `h` fixes it
  have hud : u ∈ F.dom := hu2 (mem_closedBall_self (by norm_num))
  have huΓ : u ∈ F.Γ := by
    by_contra hΓ
    have hI' : u ∈ F.interiorPts := ⟨hud, fun h' => hΓ ⟨hud, h'⟩⟩
    have h3 := hu.2
    rw [coloursAt_eq_of_mem_interiorPts hI', Set.ncard_singleton] at h3
    omega
  have huα : u ∉ ringPt P '' Ioo a b := by
    rintro ⟨θ, hθ, hθu⟩
    have h2 := ncard_coloursAt_le_two_of_mem_openArc hA' hθ
    rw [hθu] at h2
    have h3 := hu.2
    omega
  have hhu : h u = u := hfix u huΓ huα
  have hMu : M.IsCubicTrichromatic u := by
    have h1 := (hdeg u 3).mpr hu.1
    have h2 := hcol u
    rw [hhu] at h1 h2
    exact ⟨h1, h2 ▸ hu.2⟩
  have hMH : M.BaseHyp u := by
    rw [BaseHyp, Set.disjoint_left]
    intro z hz hzbad
    have hzw : h (h.symm z) = z := h.apply_symm_apply z
    have hcw : M.coloursAt z = F.coloursAt (h.symm z) := by rw [← hcol (h.symm z), hzw]
    have hrw : M.HasRepeatedColour z ↔ F.HasRepeatedColour (h.symm z) := by rw [← hrep (h.symm z), hzw]
    by_cases hwB : h.symm z ∈ closedBall u 2
    · have hwd : h.symm z ∈ F.dom := hu2 hwB
      refine Set.disjoint_left.mp hH hwB ?_
      rcases hzbad with ⟨-, h4⟩ | ⟨-, hr⟩
      · exact Or.inl ⟨hwd, hcw ▸ h4⟩
      · exact Or.inr ⟨hwd, hrw.mp hr⟩
    · -- a moved point: an interior point of `F`
      have hmoved : h (h.symm z) ≠ h.symm z := fun heq => hwB (by rw [← heq, hzw]; exact hz)
      have hwt : h.symm z ∈ thickening ε (ringArc P a b) := by
        by_contra hc; exact hmoved (hsupp _ hc)
      have hwd : h.symm z ∈ F.dom := hεd hwt
      have hwI : h.symm z ∈ F.interiorPts := by
        refine ⟨hwd, fun hwa => ?_⟩
        by_cases hwα : h.symm z ∈ ringPt P '' Ioo a b
        · obtain ⟨θ, -, hθ⟩ := hwα
          apply hwB
          rw [← hθ, mem_closedBall]
          have h1 : dist (ringPt P θ) P = 1 := by simp [ringPt, dist_eq_norm]
          have := dist_triangle (ringPt P θ) P u
          rw [mem_closedBall] at hP
          linarith
        · exact hmoved (hfix _ ⟨hwd, hwa⟩ hwα)
      rcases hzbad with ⟨-, h4⟩ | ⟨-, hr⟩
      · rw [hcw, coloursAt_eq_of_mem_interiorPts hwI, Set.ncard_singleton] at h4; omega
      · exact not_hasRepeatedColour_of_mem_interiorPts hwI (hrw.mp hr)
  have hME : M.UnenclosedC u :=
    unenclosedC_of_homeomorph hαc.isBounded.thickening (fun z hz => hsupp z hz) hhu hint hcol hE
  have hαmax : ringArc P a b ∈ F.maxRingArcs u := ⟨P, hP, a, b, c, c', hA', rfl, hmax⟩
  have hsub := maxRingArcs_subset_of_bend hF hMv hu2 hMcov hP hA' hmax hfree hR1 hR2 hR3
  exact ⟨M, hMv, hMcov, hMu, hMH, hME, hsub.trans_ssubset (Set.sdiff_singleton_ssubset.mpr hαmax)⟩

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
  classical
  -- strong induction on the number of maximal unit arcs centred in `B̄(u, 1)` (finite: `finite_maxRingArcs`)
  have key : ∀ n, ∀ G : ArcMap 6, (G.maxRingArcs u).ncard = n → G.Valid → G.Covers u 2 → G.IsCubicTrichromatic u →
      G.BaseHyp u → G.UnenclosedC u → ∃ M : ArcMap 6, M.Valid ∧ M.Covers u 2 ∧ M.IsCubicTrichromatic u ∧ M.BaseHyp u ∧
        M.NoInertNear u ∧ M.UnenclosedC u := by
    intro n
    induction n using Nat.strong_induction_on with
    | _ n ih =>
      intro G hn hG hG2 hGu hGH hGE
      by_cases hI : G.NoInertNear u
      · exact ⟨G, hG, hG2, hGu, hGH, hI, hGE⟩
      obtain ⟨M, hM, hM2, hMu, hMH, hME, hlt⟩ := exists_preBend_step hG hG2 hGu hGH hGE hI
      exact ih _ (hn ▸ Set.ncard_lt_ncard hlt (finite_maxRingArcs hG hG2)) M rfl hM hM2 hMu hMH hME
  exact key _ F rfl hF hu2 hu hH hE

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
  by_cases hbad : ∃ y ∈ closedBall x 1, y ∈ F.fourSet ∪ F.repSet
  · exact Or.inl hbad
  right
  push Not at hbad
  obtain ⟨T, hT, -, hhull, hno⟩ := exists_outermost hF hρ hx
  have hdom : (outerDom T)ᶜ ⊆ F.dom := hhull.trans ((closedBall_subset_closedBall (by linarith)).trans hx)
  obtain ⟨X, Y, v, hX, hY, hXY, hXo, hYo, hvfr, hvT, hvX, hvY⟩ := exists_rim_vertex hF hT hdom hno
  -- the rim lies in the hull (`outerDom T` is open: a union of components of an open set)
  have hvx : v ∈ closedBall x 1 :=
    hhull fun hv => ((isOpen_outerDom T).inter_frontier_eq.subset ⟨hv, hvfr⟩ : v ∈ (∅ : Set ℂ))
  have hvd : v ∈ F.dom := hx (closedBall_subset_closedBall (by linarith) hvx)
  -- `T` misses its outer domain
  have hTX : T ≠ X := fun h => by
    obtain ⟨w, hw⟩ := hX.nonempty
    exact (hXo hw).1 (subset_closure (h.symm ▸ hw : w ∈ T))
  have hTY : T ≠ Y := fun h => by
    obtain ⟨w, hw⟩ := hY.nonempty
    exact (hYo hw).1 (subset_closure (h.symm ▸ hw : w ∈ T))
  have hcub := isCubicTrichromatic_of_three_tiles hvd hT hX hY hTX hTY hXY hvT hvX hvY (hbad v hvx)
  exact ⟨v, hvx, hcub, unenclosed_of_rim_vertex hvd hT hX hY hXY hXo hYo hvT hvX hvY hcub hno⟩

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
