import Proofs.HadwigerNelson.Plane.ValidMap.Terminal
import Proofs.HadwigerNelson.Plane.ValidMap.HexRing
import Proofs.HadwigerNelson.Plane.ValidMap.Cor3

/-!
# Density: discs of radius 1 and 3, row 134's base with unit arcs, a four-colour vertex in every valid map

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 3). Rows: **FS129-SR2-DISC1TS** with FS112-DISC1 merged (`disc1ts`,
`disc1ts_degree`; the fragment form FS129-OR1-LOCALDENSE reads, `disc1_local`), **FS112-N3-COR3** (`cor3`, moved upstream to `Plane/ValidMap/Cor3`, inventory item 299 (a)), **FS112-N3-BASE**
(`n3_base`), **FS129-OR1-LOCALDENSE** (`localDense`), **FS112-N3-DENSE3** (`dense3`), **FS114-CV-EXISTS** (`cv_exists`), and the
seven-colour control of `Row134BaseUA` (`not_row134BaseUA_seven`). `Row134BaseUA` (the foundation, `Plane/ValidMap/Chain`) is wave 5's
intermediate statement of the base; `row134BaseUA` and its four consumers moved to `Plane/ValidMap/BaseDense`, downstream of the walk's leaves
(`Plane/ValidMap/BaseWalk`, job FS131-KB). FS112-ROTHEX and FS114-BV-HEX, which the walk reads, are stated in `Plane/ValidMap/HexRing`; FS114-CVB-THOM in `Plane/ValidMap/MapGraph` (plan § 8).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## FS106-TS-T on a square inside a fragment (for `disc1_local`) -/

/-- A **region of a family of classes**: a pair `(j, C)` with `C` a connected component of `cls j` (`AeProperRegions.IsRegion` with
the classes given directly, so that a fragment's classes, which need not fill the plane, can be read). -/
def IsRegOf {k : ℕ} (cls : Fin k → Set ℂ) (q : Fin k × Set ℂ) : Prop := ∃ y ∈ cls q.1, q.2 = connectedComponentIn (cls q.1) y

section IsRegOf

variable {k : ℕ} {cls : Fin k → Set ℂ}

theorem IsRegOf.subset {q : Fin k × Set ℂ} (h : IsRegOf cls q) : q.2 ⊆ cls q.1 := by
  obtain ⟨y, -, hq⟩ := h; rw [hq]; exact connectedComponentIn_subset _ _

theorem IsRegOf.isPreconnected {q : Fin k × Set ℂ} (h : IsRegOf cls q) : IsPreconnected q.2 := by
  obtain ⟨y, -, hq⟩ := h; rw [hq]; exact isPreconnected_connectedComponentIn

/-- A class with no two points at distance exactly `1` has no unit pairs (`AeProperRegions.unitPairsNull_cls`, class by class). -/
theorem unitPairsNull_of_dist_ne_one {W : Set ℂ} (hne : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1) : UnitPairsNull W := by
  have h : unitPairSet W = ∅ := by
    ext q
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro h1 h2
    exact hne _ h1 _ h2 (by rw [dist_self_add_right, norm_e])
  unfold UnitPairsNull
  rw [h, MeasureTheory.measure_empty]

/-- One link of a chain of regions of one colour (`AeProperRegions.IsRegion.chain_step` for a family of classes). -/
theorem IsRegOf.chain_step (hO : ∀ j, IsOpen (cls j)) (hne : ∀ j, ∀ x ∈ cls j, ∀ y ∈ cls j, dist x y ≠ 1) {j : Fin k}
    {C C' : Set ℂ} (h : IsRegOf cls (j, C)) (h' : IsRegOf cls (j, C')) (hmeet : (closure C ∩ closure C').Nonempty) {x : ℂ}
    (hx : x ∈ cls j) (hnear : ∀ s ∈ C, dist x s < 1) : ∀ s ∈ C', dist x s < 1 :=
  Plane.chain_step (hO j) (unitPairsNull_of_dist_ne_one (hne j)) h.subset h'.subset h'.isPreconnected hx hnear hmeet

/-- A region has every two points nearer than `1` (`AeProperRegions.IsRegion.dist_lt_one` for a family of classes). -/
theorem IsRegOf.dist_lt_one (hne : ∀ j, ∀ x ∈ cls j, ∀ y ∈ cls j, dist x y ≠ 1) {q : Fin k × Set ℂ} (h : IsRegOf cls q) :
    ∀ x ∈ q.2, ∀ y ∈ q.2, dist x y < 1 :=
  dist_lt_one_of_forall_dist_ne_one h.isPreconnected fun x hx y hy => hne q.1 x (h.subset hx) y (h.subset hy)

end IsRegOf

/-- Spec: the plane is one region of the one-class family `univ`; the empty set is not a region (a region is a component through a point
of its class). -/
example : IsRegOf (fun _ : Fin 1 => (univ : Set ℂ)) (0, univ) :=
  ⟨0, mem_univ _, by simp [connectedComponentIn_univ, PreconnectedSpace.connectedComponent_eq_univ]⟩

example : ¬ IsRegOf (fun _ : Fin 1 => (univ : Set ℂ)) (0, ∅) := by
  rintro ⟨y, hy, h⟩
  have := mem_connectedComponentIn hy
  rw [← h] at this
  exact this


/-- **FS106-TS-T on a square** (`AeProperRegions.exists_three_le_multicolour`'s argument read on one closed square of side `s > 1`):
open classes with no two points of one class at distance `1`, dense at every point of the square and locally finite there, have a
point of the square in the closures of three classes. The chain classes of regions meeting the square are finitely many closed sets
of diameter at most `1 < s`, so none meets two opposite sides, and Lebesgue's covering theorem puts a point in three of them. Only the
square is read, so the classes may be a fragment's. -/
theorem exists_three_le_multicolour_square {k : ℕ} (cls : Fin k → Set ℂ) (hO : ∀ j, IsOpen (cls j))
    (hne : ∀ j, ∀ x ∈ cls j, ∀ y ∈ cls j, dist x y ≠ 1) {c : ℂ} {s : ℝ} (hs1 : 1 < s)
    (hdense : ∀ p ∈ closedSquare c s, p ∈ closure (⋃ j, cls j))
    (hlf : ∀ x ∈ closedSquare c s, ∃ t ∈ 𝓝 x,
      {C : Set ℂ | ∃ j, ∃ y ∈ cls j, C = connectedComponentIn (cls j) y ∧ (C ∩ t).Nonempty}.Finite) :
    ∃ p ∈ closedSquare c s, 3 ≤ (multicolour cls p).ncard := by
  classical
  have hs : 0 < s := by linarith
  set Q := closedSquare c s with hQ
  have hQclosed : IsClosed Q := by
    have hre := Complex.continuous_re
    have him := Complex.continuous_im
    exact ((isClosed_le continuous_const hre).inter ((isClosed_le hre continuous_const).inter
      ((isClosed_le continuous_const him).inter (isClosed_le him continuous_const))))
  have hQbdd : Bornology.IsBounded Q := by
    refine (Metric.isBounded_closedBall (x := c) (r := 2 * s)).subset fun p hp => ?_
    obtain ⟨h1, h2, h3, h4⟩ := hp
    rw [mem_closedBall, dist_eq_norm]
    have hre : |(p - c).re| ≤ s := by rw [Complex.sub_re, abs_le]; constructor <;> linarith
    have him : |(p - c).im| ≤ s := by rw [Complex.sub_im, abs_le]; constructor <;> linarith
    linarith [Complex.norm_le_abs_re_add_abs_im (p - c)]
  have hQc : IsCompact Q := Metric.isCompact_of_isClosed_isBounded hQclosed hQbdd
  -- a finite open cover of the square by neighbourhoods meeting finitely many regions
  choose t₀ ht₀ htf₀ using hlf
  set t : ℂ → Set ℂ := fun x => if h : x ∈ Q then t₀ x h else univ with ht_def
  have ht : ∀ x ∈ Q, t x ∈ 𝓝 x := fun x hx => by rw [ht_def]; simp only [dif_pos hx]; exact ht₀ x hx
  have htf : ∀ x ∈ Q, {C : Set ℂ | ∃ j, ∃ y ∈ cls j, C = connectedComponentIn (cls j) y ∧ (C ∩ t x).Nonempty}.Finite :=
    fun x hx => by rw [ht_def]; simp only [dif_pos hx]; exact htf₀ x hx
  obtain ⟨u, huQ, hcover⟩ := hQc.elim_nhds_subcover (fun x => interior (t x)) (fun x hx => interior_mem_nhds.mpr (ht x hx))
  set U := ⋃ x ∈ u, interior (t x) with hU
  have hUo : IsOpen U := isOpen_biUnion fun _ _ => isOpen_interior
  -- the regions meeting `U`: finitely many
  set 𝒞 : Set (Fin k × Set ℂ) := {q | IsRegOf cls q ∧ (q.2 ∩ U).Nonempty} with h𝒞
  have h𝒞f : 𝒞.Finite := by
    have hA : (⋃ x ∈ u, {C : Set ℂ | ∃ j, ∃ y ∈ cls j, C = connectedComponentIn (cls j) y ∧ (C ∩ t x).Nonempty}).Finite :=
      u.finite_toSet.biUnion fun x hx => htf x (huQ x hx)
    refine ((Set.finite_univ (α := Fin k)).prod hA).subset ?_
    rintro ⟨j, C⟩ ⟨⟨y, hy, hC⟩, w, hwC, hwU⟩
    simp only [hU, mem_iUnion] at hwU
    obtain ⟨x, hx, hw⟩ := hwU
    refine ⟨mem_univ _, ?_⟩
    simp only [mem_iUnion, mem_setOf_eq]
    exact ⟨x, hx, j, y, hy, hC, w, hwC, interior_subset hw⟩
  haveI : Finite 𝒞 := h𝒞f.to_subtype
  -- the chain relation on those regions, and the closed set of each class
  let r : 𝒞 → 𝒞 → Prop := fun a b => a.1.1 = b.1.1 ∧ (closure a.1.2 ∩ closure b.1.2).Nonempty
  let Fc : 𝒞 → Set ℂ := fun a => ⋃ b ∈ {b : 𝒞 | Relation.EqvGen r a b}, closure b.1.2
  have hcol : ∀ a b, Relation.EqvGen r a b → a.1.1 = b.1.1 := by
    intro a b h
    induction h with
    | rel x y h => exact h.1
    | refl => rfl
    | symm x y _ ih => exact ih.symm
    | trans x y w _ _ ih1 ih2 => exact ih1.trans ih2
  have hFc_eq : ∀ a b, Relation.EqvGen r a b → Fc a = Fc b := by
    intro a b h
    ext p
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop]
    constructor
    · rintro ⟨b', hb', hp⟩; exact ⟨b', Relation.EqvGen.trans _ _ _ (Relation.EqvGen.symm _ _ h) hb', hp⟩
    · rintro ⟨b', hb', hp⟩; exact ⟨b', Relation.EqvGen.trans _ _ _ h hb', hp⟩
  -- along a chain, "within `1` of a whole region" passes from region to region
  have hpass : ∀ a b, Relation.EqvGen r a b → ∀ x ∈ cls a.1.1,
      ((∀ y ∈ a.1.2, dist x y < 1) ↔ ∀ y ∈ b.1.2, dist x y < 1) := by
    intro a b h
    induction h with
    | rel a b h =>
      intro x hx
      have ha : IsRegOf cls (a.1.1, a.1.2) := a.2.1
      have hb : IsRegOf cls (a.1.1, b.1.2) := by rw [h.1]; exact b.2.1
      exact ⟨fun H => ha.chain_step hO hne hb h.2 hx H,
        fun H => hb.chain_step hO hne ha (by rw [inter_comm]; exact h.2) hx H⟩
    | refl => intro x _; exact Iff.rfl
    | symm a b hab ih =>
      intro x hx
      rw [← hcol a b hab] at hx
      exact (ih x hx).symm
    | trans a b w hab _ ih1 ih2 =>
      intro x hx
      have hx' : x ∈ cls b.1.1 := by rw [← hcol a b hab]; exact hx
      exact (ih1 x hx).trans (ih2 x hx')
  have hdiam : ∀ a, ∀ p ∈ Fc a, ∀ q ∈ Fc a, dist p q ≤ 1 := by
    intro a p hp q hq
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop] at hp hq
    obtain ⟨b, hb, hpb⟩ := hp
    obtain ⟨b', hb', hqb'⟩ := hq
    have hbb' : Relation.EqvGen r b b' := Relation.EqvGen.trans _ _ _ (Relation.EqvGen.symm _ _ hb) hb'
    have hnear : ∀ x ∈ b.1.2, ∀ y ∈ b'.1.2, dist x y < 1 := fun x hx =>
      (hpass b b' hbb' x (b.2.1.subset hx)).mp fun y hy => b.2.1.dist_lt_one hne x hx y hy
    have h1 : ∀ x ∈ b.1.2, closure b'.1.2 ⊆ closedBall x 1 := fun x hx =>
      closure_minimal (fun y hy => by rw [mem_closedBall, dist_comm]; exact (hnear x hx y hy).le) isClosed_closedBall
    have h2 : closure b.1.2 ⊆ closedBall q 1 :=
      closure_minimal (fun x hx => by rw [mem_closedBall, dist_comm]; exact h1 x hx hqb') isClosed_closedBall
    have := h2 hpb
    rwa [mem_closedBall] at this
  have hFc_closed : ∀ a, IsClosed (Fc a) := fun a =>
    Set.Finite.isClosed_biUnion (Set.toFinite _) fun _ _ => isClosed_closure
  -- every point of the square lies in the closure of a region meeting `U`
  have hcovFc : ∀ p ∈ Q, ∃ a, p ∈ Fc a := by
    intro p hp
    have hpU : p ∈ U := hcover hp
    set N := interior (t p) ∩ U with hN
    have hNo : IsOpen N := isOpen_interior.inter hUo
    have hpN : p ∈ N := ⟨mem_interior_iff_mem_nhds.mpr (ht p hp), hpU⟩
    set 𝒟 : Set (Fin k × Set ℂ) := {q | IsRegOf cls q ∧ (q.2 ∩ N).Nonempty} with h𝒟
    have h𝒟f : 𝒟.Finite := by
      refine ((Set.finite_univ (α := Fin k)).prod (htf p hp)).subset ?_
      rintro ⟨j, C⟩ ⟨⟨y, hy, hC⟩, w, hwC, hwN⟩
      exact ⟨mem_univ _, j, y, hy, hC, w, hwC, interior_subset hwN.1⟩
    have hsub : N ∩ ⋃ j, cls j ⊆ ⋃ q ∈ 𝒟, q.2 := by
      rintro y ⟨hyN, hy⟩
      obtain ⟨j, hj⟩ := mem_iUnion.mp hy
      refine mem_biUnion (x := (j, connectedComponentIn (cls j) y)) ⟨⟨y, hj, rfl⟩, y, ?_, hyN⟩ ?_ <;>
        exact mem_connectedComponentIn hj
    have hpcl : p ∈ closure (⋃ q ∈ 𝒟, q.2) := closure_mono hsub (hNo.inter_closure ⟨hpN, hdense p hp⟩)
    rw [h𝒟f.closure_biUnion] at hpcl
    obtain ⟨q, ⟨hqR, w, hwq, hwN⟩, hpq⟩ := mem_iUnion₂.mp hpcl
    refine ⟨⟨q, hqR, w, hwq, hwN.2⟩, ?_⟩
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop]
    exact ⟨_, Relation.EqvGen.refl _, hpq⟩
  -- the distinct class sets, enumerated
  obtain ⟨m, ⟨eqv⟩⟩ := Finite.exists_equiv_fin (range Fc)
  set G : Fin m → Set ℂ := fun i => (eqv.symm i).1 with hG
  have hGinj : Function.Injective G := fun i j h => eqv.symm.injective (Subtype.ext h)
  have hGrange : ∀ i, ∃ a, G i = Fc a := fun i => by
    obtain ⟨a, ha⟩ := (eqv.symm i).2; exact ⟨a, ha.symm⟩
  have hGof : ∀ a, ∃ i, G i = Fc a := fun a =>
    ⟨eqv ⟨Fc a, a, rfl⟩, by simp [hG]⟩
  have hside : ∀ i, ∀ p ∈ G i, ∀ q ∈ G i, |p.re - q.re| ≤ 1 ∧ |p.im - q.im| ≤ 1 := by
    intro i p hp q hq
    obtain ⟨a, ha⟩ := hGrange i
    rw [ha] at hp hq
    have hd := hdiam a p hp q hq
    rw [Complex.dist_eq] at hd
    exact ⟨by have := Complex.abs_re_le_norm (p - q); rw [Complex.sub_re] at this; linarith,
      by have := Complex.abs_im_le_norm (p - q); rw [Complex.sub_im] at this; linarith⟩
  obtain ⟨p, hpQ, i, j, l, hij, hil, hjl, hpi, hpj, hpl⟩ := lebesgue_covering_square c hs G
    (fun i => by obtain ⟨a, ha⟩ := hGrange i; rw [ha]; exact hFc_closed a)
    (fun p hp => by
      obtain ⟨a, ha⟩ := hcovFc p hp
      obtain ⟨i, hi⟩ := hGof a
      exact mem_iUnion.mpr ⟨i, hi ▸ ha⟩)
    (fun i ⟨⟨z1, ⟨hz1, _⟩, h1⟩, ⟨z2, ⟨hz2, _⟩, h2⟩⟩ => by
      have := (hside i z1 hz1 z2 hz2).1
      rw [h1, h2, show c.re - (c.re + s) = -s by ring, abs_neg, abs_of_pos hs] at this
      linarith)
    (fun i ⟨⟨z1, ⟨hz1, _⟩, h1⟩, ⟨z2, ⟨hz2, _⟩, h2⟩⟩ => by
      have := (hside i z1 hz1 z2 hz2).2
      rw [h1, h2, show c.im - (c.im + s) = -s by ring, abs_neg, abs_of_pos hs] at this
      linarith)
  refine ⟨p, ?_, ?_⟩
  · exact hpQ
  · -- three classes at `p`, of three colours
    obtain ⟨ai, hai⟩ := hGrange i
    obtain ⟨aj, haj⟩ := hGrange j
    obtain ⟨al, hal⟩ := hGrange l
    rw [hai] at hpi; rw [haj] at hpj; rw [hal] at hpl
    simp only [Fc, mem_iUnion, mem_setOf_eq, exists_prop] at hpi hpj hpl
    obtain ⟨bi, hbi, hpbi⟩ := hpi
    obtain ⟨bj, hbj, hpbj⟩ := hpj
    obtain ⟨bl, hbl, hpbl⟩ := hpl
    have hne : ∀ {i j : Fin m} {ai aj bi bj : 𝒞}, i ≠ j → G i = Fc ai → G j = Fc aj → Relation.EqvGen r ai bi →
        Relation.EqvGen r aj bj → p ∈ closure bi.1.2 → p ∈ closure bj.1.2 → bi.1.1 ≠ bj.1.1 := by
      intro i j ai aj bi bj hij hai haj hbi hbj hpi hpj heq
      apply hij
      apply hGinj
      rw [hai, haj]
      apply hFc_eq
      exact Relation.EqvGen.trans _ _ _ hbi (Relation.EqvGen.trans _ _ _ (Relation.EqvGen.rel _ _ ⟨heq, p, hpi, hpj⟩)
        (Relation.EqvGen.symm _ _ hbj))
    have hm : ∀ b : 𝒞, p ∈ closure b.1.2 → b.1.1 ∈ multicolour cls p := fun b hb =>
      closure_mono b.2.1.subset hb
    have h3 : ({bi.1.1, bj.1.1, bl.1.1} : Set (Fin k)).ncard = 3 :=
      Set.ncard_eq_three.mpr ⟨_, _, _, hne hij hai haj hbi hbj hpbi hpbj, hne hil hai hal hbi hbl hpbi hpbl,
        hne hjl haj hal hbj hbl hpbj hpbl, rfl⟩
    rw [← h3]
    refine Set.ncard_le_ncard ?_ (Set.toFinite _)
    rintro x (rfl | rfl | rfl)
    · exact hm bi hpbi
    · exact hm bj hpbj
    · exact hm bl hpbl


namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS129-SR2-DISC1TS (FS112-DISC1 merged) -/

/-- **FS129-SR2-DISC1TS**, chromaticity form: every closed disc of radius `1` of a valid map of the plane holds a point of at least
three colours — FS106-TS-T's `1/√2 + ε < 1` (`ts_t`). Stronger than FS112-DISC1's "a vertex of degree at least 3" (`disc1ts_degree`).
Inhabitant: `sevenBrickMap` (valid, of the plane). -/
theorem disc1ts (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
  have hs : 1 < Real.sqrt 2 := by
    rw [show (1 : ℝ) = Real.sqrt 1 by simp]; exact Real.sqrt_lt_sqrt (by norm_num) (by norm_num)
  have hε : 0 < 1 - 1 / Real.sqrt 2 := by
    rw [sub_pos, div_lt_one (by linarith)]; exact hs
  obtain ⟨y, hy, h3⟩ := ts_t hF hP x hε
  exact ⟨y, by rw [mem_closedBall]; linarith, h3⟩

/-- **FS112-DISC1** as FS129-SR2-DISC1TS states it: every closed disc of radius `1` of a valid map of the plane contains a vertex of
degree at least `3`. -/
theorem disc1ts_degree (hF : F.Valid) (hP : F.IsPlaneMap) (x : ℂ) :
    ∃ y ∈ closedBall x 1, ∃ n, 3 ≤ n ∧ F.HasDegree y n := by
  obtain ⟨y, hy, h3⟩ := disc1ts hF hP x
  obtain ⟨n, hn, hdeg⟩ := exists_hasDegree_of_mem_dom (F := F) (hP ▸ mem_univ y)
  exact ⟨y, hy, n, h3.trans hn, hdeg⟩

/-- **FS106-TS-T on a square inside a fragment**: a valid map whose domain holds a closed square of side `s > 1` has a point of at least
three colours in it (`exists_three_le_multicolour_square` on the colour classes, dense and locally finite at the domain's points by
`dense_interiorPts` and `finite_tiles_near`). Inhabitant: `sevenBrickMap` (valid, of the plane). -/
theorem exists_three_le_coloursAt_square (hF : F.Valid) {c : ℂ} {s : ℝ} (hs1 : 1 < s) (hQ : closedSquare c s ⊆ F.dom) :
    ∃ p ∈ closedSquare c s, 3 ≤ (F.coloursAt p).ncard := by
  have hU : (⋃ j, F.region j) = F.interiorPts := by
    ext z
    simp only [mem_iUnion]
    constructor
    · rintro ⟨j, hj⟩; exact hj.1
    · intro hz; exact ⟨F.col z, hz, rfl⟩
  refine exists_three_le_multicolour_square F.region F.isOpen_region
    (fun j x hx y hy hxy => hF x hx.1 y hy.1 hxy (by rw [hx.2, hy.2])) hs1
    (fun p hp => by rw [hU]; exact F.dense_interiorPts (hQ hp)) (fun x hx => ?_)
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near (hQ hx)
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

/-- The square of side `6/5` centred at `x` lies in `B̄(x, 1)` (its half-diagonal is `3√2/5 < 1`). -/
theorem closedSquare_subset_closedBall (x : ℂ) :
    closedSquare (x - ((3 / 5 : ℝ) : ℂ) - ((3 / 5 : ℝ) : ℂ) * I) (6 / 5) ⊆ closedBall x 1 := by
  rintro p ⟨h1, h2, h3, h4⟩
  simp only [Complex.sub_re, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im, Complex.mul_re, Complex.mul_im,
    Complex.I_re, Complex.I_im] at h1 h2 h3 h4
  rw [mem_closedBall, Complex.dist_eq]
  have hsq : ‖p - x‖ ^ 2 ≤ 1 := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.sub_re, Complex.sub_im]
    nlinarith
  nlinarith [norm_nonneg (p - x)]

/-- **FS112-DISC1 on a fragment** (FS129-OR1-LOCALDENSE's use: "read on a fragment: its argument nests tiles surrounding `x`, each of
diameter at most 1 and so inside `B̄(x, 1)`"): a valid fragment covering `B̄(x, 1)` has a point of at least three colours in `B̄(x, 1)`.
A supporting lemma (the merged row read at the class LOCALDENSE's argument reads). Inhabitant: `sevenBrickMap`. -/
theorem disc1_local (hF : F.Valid) {x : ℂ} (hx : F.Covers x 1) : ∃ y ∈ closedBall x 1, 3 ≤ (F.coloursAt y).ncard := by
  -- the square of side `6/5` about `x` lies in `B̄(x, 1)`, and TS-T on it gives the point (the route is FS106-TS-T's, read on the
  -- square only, not the nested tiles the docstring's FS129 wording describes)
  obtain ⟨p, hp, h3⟩ := exists_three_le_coloursAt_square hF (by norm_num : (1 : ℝ) < 6 / 5)
    ((closedSquare_subset_closedBall x).trans hx)
  exact ⟨p, closedSquare_subset_closedBall x hp, h3⟩

end ArcMap

/-! ## The seven-colour control: `Row134BaseUA` spends six colours -/

/-- **`Row134BaseUA`'s seven-colour form is false**: the seven-brick map's corner `0` is a cubic trichromatic vertex of a valid
seven-coloured map of the plane with no point of `F(M) ∪ R(M)` in `B̄(0, 2)`, no unit arc anywhere, and no tile enclosing another (its tiles are
open rectangles, whose closures have connected, unbounded complements: `UnenclosedC 0`, FS131-E4's added hypothesis). So the base's six colours
are load-bearing, and the hypothesis is not true for a reason that ignores the colour count. -/
theorem not_row134BaseUA_seven :
    ¬ ∀ (F : ArcMap 7) (u : ℂ), F.Valid → F.Covers u 2 → F.IsCubicTrichromatic u → F.BaseHyp u → F.NoInertNear u →
      F.UnenclosedC u → False := fun h =>
  h sevenBrickMap 0 sevenBrickMap_valid (fun _ _ => mem_univ _) sevenBrick_corner_isCubicTrichromatic (sevenBrick_baseHyp 0)
    (sevenBrick_noInertNear 0) (sevenBrick_unenclosedC 0)

end HadwigerNelson.Plane
