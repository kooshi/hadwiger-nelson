import Proofs.HadwigerNelson.Plane.ValidMap.HexRing
import Proofs.HadwigerNelson.Plane.Tiles
import Proofs.HadwigerNelson.Plane.PlaneTopology

/-!
# The plane topology of a map: tiles in complementary components, the outermost tile, the rim, the common boundary of two tiles

The map-level half of wave 5's planar infrastructure (job FS131-KP, `plans/FS131-planar-kernel-plan.md` § 3), over `Plane/PlaneTopology`
(unicoherence and its corollaries) and `Plane/LocalStructure` (`finite_tiles_near`, `dense_interiorPts`, `mem_closure_tile`, sector charts).
Upstream of `MapGraph` (the `cvb_*` leaves), `BaseWalk` (`retArcs_nested`, `exists_endpoint`, `exists_eleventh`) and `BaseDense`
(`exists_unenclosed_or_bad`).

* **A — tiles and complementary components**: a tile other than `T` lies in `(cl T)ᶜ`, on one side of any separation; every open set of the
  domain meets a tile; a closure point of an open set is a closure point of a tile meeting it; inside an open preconnected set the tiles are
  chained by touching closures (`mem_of_touch_closed`); finitely many tiles have closures meeting a compact set.
* **B — the outer domain and the outermost tile** (FS131-E4 E4-OUTERMOST): `outerDom T`, `EnclosesTile`; the outermost tile in `B̄(x, 1)`;
  two outer tiles meeting on its rim; the rim vertex cubic trichromatic and un-enclosed.
* **C — the rim of `u`'s component** (FS131-E4 E4-RIM, the eleventh point): Lemma H(a); the tiles of `u`'s colours meeting `B(u, 1)`; the
  assembly `exists_eleventh_of`.
* **D — the common boundary of two tiles in a disc, and arcs of a circle**: `exists_far_end` (the handshake on the finite boundary graph),
  `ringArc_cases` (two short arcs of one circle are disjoint, nested, interleaved, or abut).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## A — tiles and complementary components -/

/-- A tile other than `T` lies off `T`'s closure (it is open and disjoint from `T`). -/
theorem IsTile.subset_compl_closure {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T') (hne : T' ≠ T) : T' ⊆ (closure T)ᶜ := by
  have hdisj : Disjoint T' T := by
    rw [Set.disjoint_left]
    intro w hw' hw
    exact hne (hT'.eq_of_mem hT hw' hw)
  exact (hdisj.closure_right hT'.isOpen).subset_compl_right

/-- A tile inside the union of two sets with disjoint closures lies inside one of them (it is preconnected). -/
theorem IsTile.subset_or_subset_of_separated {T A B : Set ℂ} (hT : F.IsTile T) (hsep : Disjoint (closure A) (closure B))
    (hcov : T ⊆ A ∪ B) : T ⊆ A ∨ T ⊆ B := by
  by_contra h
  push Not at h
  obtain ⟨⟨a, haT, haA⟩, ⟨b, hbT, hbB⟩⟩ : (T ∩ Aᶜ).Nonempty ∧ (T ∩ Bᶜ).Nonempty :=
    ⟨Set.not_subset.mp h.1 |>.imp fun x hx => ⟨hx.1, hx.2⟩, Set.not_subset.mp h.2 |>.imp fun x hx => ⟨hx.1, hx.2⟩⟩
  have hbA : b ∈ closure A := subset_closure ((hcov hbT).resolve_right hbB)
  have haB : a ∈ closure B := subset_closure ((hcov haT).resolve_left haA)
  obtain ⟨w, -, hwA, hwB⟩ := isPreconnected_closed_iff.mp hT.isPreconnected _ _ isClosed_closure isClosed_closure
    (fun x hx => (hcov hx).imp (fun h => subset_closure h) (fun h => subset_closure h)) ⟨b, hbT, hbA⟩ ⟨a, haT, haB⟩
  exact Set.disjoint_left.mp hsep hwA hwB

/-- Every nonempty open subset of the domain meets a tile (`dense_interiorPts`). -/
theorem exists_tile_inter_of_isOpen {U : Set ℂ} (hU : IsOpen U) (hUd : U ⊆ F.dom) (hne : U.Nonempty) :
    ∃ T, F.IsTile T ∧ (T ∩ U).Nonempty := by
  obtain ⟨z, hz⟩ := hne
  obtain ⟨w, hwU, hw⟩ := mem_closure_iff.mp (F.dense_interiorPts (hUd hz)) U hU hz
  exact ⟨connectedComponentIn F.interiorPts w, ⟨w, hw, rfl⟩, w, mem_connectedComponentIn hw, hwU⟩

/-- **Tile closures are locally finite**: a closure point in the domain of the union of the closures of any family of tiles is a closure
point of one of them (`finite_tiles_near`: near `z` only finitely many tiles, and a tile missing `B(z, r)` has its closure missing it). -/
theorem exists_mem_closure_of_mem_closure_biUnion {S : Set (Set ℂ)} (hS : ∀ T ∈ S, F.IsTile T) {z : ℂ} (hz : z ∈ F.dom)
    (hzS : z ∈ closure (⋃ T ∈ S, closure T)) : ∃ T ∈ S, z ∈ closure T := by
  obtain ⟨r, hr, hfin⟩ := F.finite_tiles_near hz
  by_contra hno
  push Not at hno
  have hfin' : {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}.Finite := hfin.subset fun T hT => ⟨hS T hT.1, hT.2⟩
  have hcl : IsClosed (⋃ T ∈ {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}, closure T) :=
    hfin'.isClosed_biUnion fun _ _ => isClosed_closure
  have hzn : z ∉ ⋃ T ∈ {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}, closure T := by
    simp only [mem_iUnion₂]
    rintro ⟨T, hT, hzT⟩
    exact hno T hT.1 hzT
  have hnhds : ball z r ∩ (⋃ T ∈ {T | T ∈ S ∧ (T ∩ ball z r).Nonempty}, closure T)ᶜ ∈ 𝓝 z :=
    inter_mem (ball_mem_nhds z hr) (hcl.isOpen_compl.mem_nhds hzn)
  obtain ⟨w, ⟨hwb, hwn⟩, hwS⟩ := mem_closure_iff_nhds.mp hzS _ hnhds
  obtain ⟨T, hT, hwT⟩ := mem_iUnion₂.mp hwS
  by_cases hTb : (T ∩ ball z r).Nonempty
  · exact hwn (mem_iUnion₂.mpr ⟨T, ⟨hT, hTb⟩, hwT⟩)
  · exact hTb ((closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwT, hwb⟩)

/-- **A closure point of an open set is a closure point of a tile meeting it** (`finite_tiles_near`: near `z` finitely many tiles, whose
closures' union is closed and holds the interior points of `U` near `z`). -/
theorem exists_tile_mem_closure_of_mem_closure {U : Set ℂ} (hU : IsOpen U) {z : ℂ} (hz : z ∈ F.dom) (hzU : z ∈ closure U) :
    ∃ T, F.IsTile T ∧ (T ∩ U).Nonempty ∧ z ∈ closure T := by
  set S := {T | F.IsTile T ∧ (T ∩ U).Nonempty} with hSdef
  have hz' : z ∈ closure (⋃ T ∈ S, closure T) := by
    refine closure_mono (biUnion_mono subset_rfl fun _ _ => subset_closure) ?_
    rw [_root_.mem_closure_iff]
    intro o ho hzo
    obtain ⟨w, ⟨hwo, hwd⟩, hwU⟩ := _root_.mem_closure_iff.mp hzU _ (ho.inter F.isOpen_dom) ⟨hzo, hz⟩
    obtain ⟨T, hT, v, hvT, ⟨hvo, -⟩, hvU⟩ := exists_tile_inter_of_isOpen ((ho.inter F.isOpen_dom).inter hU)
      (fun x hx => hx.1.2) ⟨w, ⟨hwo, hwd⟩, hwU⟩
    exact ⟨v, hvo, mem_iUnion₂.mpr ⟨T, ⟨hT, v, hvT, hvU⟩, hvT⟩⟩
  obtain ⟨T, ⟨hT, hTU⟩, hzT⟩ := exists_mem_closure_of_mem_closure_biUnion (fun T hT => hT.1) hz hz'
  exact ⟨T, hT, hTU, hzT⟩

/-- **Inside an open preconnected set the tiles are chained by touching closures**: if every tile meeting `U` lies in `U`, a nonempty set
`P` of tiles in `U`, closed under passing to a tile in `U` whose closure meets a member's, holds every tile in `U`. (The closures of the tiles
of `P` and of the others cover `U` by locally finite, hence relatively closed, unions, and meet nowhere in `U`.) -/
theorem mem_of_touch_closed {U : Set ℂ} (hU : IsOpen U) (hUc : IsPreconnected U) (hUd : U ⊆ F.dom)
    (hin : ∀ T, F.IsTile T → (T ∩ U).Nonempty → T ⊆ U) (P : Set (Set ℂ)) (hP : ∀ T ∈ P, F.IsTile T ∧ T ⊆ U) (hne : P.Nonempty)
    (hcl : ∀ T ∈ P, ∀ T', F.IsTile T' → T' ⊆ U → (closure T ∩ closure T').Nonempty → T' ∈ P) :
    ∀ T, F.IsTile T → T ⊆ U → T ∈ P := by
  intro T₀ hT₀ hT₀U
  by_contra hT₀P
  set X := ⋃ T ∈ P, closure T with hX
  set Q := {T | F.IsTile T ∧ T ⊆ U ∧ T ∉ P} with hQ
  set Y := ⋃ T ∈ Q, closure T with hY
  -- a point of `U` in the closure of `X` (of `Y`) is in the closure of a tile of `P` (of `Q`)
  have hXc : ∀ z ∈ U, z ∈ closure X → ∃ T ∈ P, z ∈ closure T := fun z hzU hz =>
    exists_mem_closure_of_mem_closure_biUnion (fun T hT => (hP T hT).1) (hUd hzU) hz
  have hYc : ∀ z ∈ U, z ∈ closure Y → ∃ T ∈ Q, z ∈ closure T := fun z hzU hz =>
    exists_mem_closure_of_mem_closure_biUnion (fun T hT => hT.1) (hUd hzU) hz
  -- every point of `U` is in the closure of a tile inside `U`
  have hcov : U ⊆ closure X ∪ closure Y := by
    intro z hzU
    obtain ⟨T, hT, hzT⟩ := F.mem_closure_tile (hUd hzU)
    have hTU : T ⊆ U := hin T hT (by
      rw [inter_comm]; exact (closure_inter_open_nonempty_iff hU).mp ⟨z, hzT, hzU⟩ |>.mono (by
        rintro x ⟨h1, h2⟩; exact ⟨h2, h1⟩))
    by_cases hTP : T ∈ P
    · exact Or.inl (subset_closure (mem_iUnion₂.mpr ⟨T, hTP, hzT⟩))
    · exact Or.inr (subset_closure (mem_iUnion₂.mpr ⟨T, ⟨hT, hTU, hTP⟩, hzT⟩))
  obtain ⟨T₁, hT₁⟩ := hne
  obtain ⟨x₁, hx₁⟩ := (hP T₁ hT₁).1.nonempty
  obtain ⟨x₀, hx₀⟩ := hT₀.nonempty
  obtain ⟨z, hzU, hzX, hzY⟩ := isPreconnected_closed_iff.mp hUc _ _ isClosed_closure isClosed_closure hcov
    ⟨x₁, (hP T₁ hT₁).2 hx₁, subset_closure (mem_iUnion₂.mpr ⟨T₁, hT₁, subset_closure hx₁⟩)⟩
    ⟨x₀, hT₀U hx₀, subset_closure (mem_iUnion₂.mpr ⟨T₀, ⟨hT₀, hT₀U, hT₀P⟩, subset_closure hx₀⟩)⟩
  obtain ⟨T, hTP, hzT⟩ := hXc z hzU hzX
  obtain ⟨T', ⟨hT', hT'U, hT'P⟩, hzT'⟩ := hYc z hzU hzY
  exact hT'P (hcl T hTP T' hT' hT'U ⟨z, hzT, hzT'⟩)

/-- **Finitely many tiles have closures meeting a compact subset of the domain** (`finite_tiles_near` and a finite subcover). -/
theorem finite_tiles_closure_inter {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {T | F.IsTile T ∧ (closure T ∩ K).Nonempty}.Finite := by
  choose! r hr hfin using fun z (hz : z ∈ K) => F.finite_tiles_near (hKd hz)
  obtain ⟨t, htK, hcov⟩ := hK.elim_nhds_subcover (fun z => ball z (r z)) fun z hz => ball_mem_nhds z (hr z hz)
  refine (t.finite_toSet.biUnion fun z hz => hfin z (htK z hz)).subset ?_
  rintro T ⟨hT, w, hwT, hwK⟩
  obtain ⟨z, hz, hwz⟩ := mem_iUnion₂.mp (hcov hwK)
  exact mem_iUnion₂.mpr ⟨z, hz, hT, (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨w, hwT, hwz⟩⟩

/-! ## B — the outer domain and the outermost tile (FS131-E4 E4-OUTERMOST) -/

/-- **The outer domain** of `T`: the points off `cl T` in an unbounded component of `(cl T)ᶜ` (for a tile of a valid map, `cl T` is bounded
and this is the one unbounded component, `isPreconnected_compl_closedBall`). Its complement is `T`'s hull. -/
def outerDom (T : Set ℂ) : Set ℂ := {z | z ∉ closure T ∧ ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z)}

/-- **`T` encloses `S`**: some point of `S` off `cl T` lies in a bounded component of `(cl T)ᶜ` (`Unenclosed v` says no tile encloses a tile
at `v`). -/
def EnclosesTile (T S : Set ℂ) : Prop := ∃ y ∈ S \ closure T, Bornology.IsBounded (connectedComponentIn (closure T)ᶜ y)

/-- The outer domain is open: with each point it holds the point's component of `(cl T)ᶜ`. -/
theorem isOpen_outerDom (T : Set ℂ) : IsOpen (outerDom T) := by
  rw [isOpen_iff_forall_mem_open]
  intro z hz
  refine ⟨connectedComponentIn (closure T)ᶜ z, fun w hw => ⟨connectedComponentIn_subset _ _ hw, ?_⟩,
    isClosed_closure.isOpen_compl.connectedComponentIn, mem_connectedComponentIn hz.1⟩
  rw [← connectedComponentIn_eq hw]
  exact hz.2

/-- A tile's closure lies in `B̄(0, ‖x‖ + 1)` for any point `x` of the tile (`IsTile.closure_subset_closedBall`). -/
theorem IsTile.closure_subset_closedBall_zero (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hx : x ∈ T) :
    closure T ⊆ closedBall 0 (‖x‖ + 1) := by
  intro z hz
  have := hT.closure_subset_closedBall hF (subset_closure hx) hz
  rw [mem_closedBall, dist_zero_right]; rw [mem_closedBall] at this
  linarith [norm_le_norm_add_norm_sub' z x, dist_eq_norm z x]

/-- A point outside `B̄(0, R)`. -/
theorem exists_not_mem_closedBall_zero (R : ℝ) : ∃ z : ℂ, z ∉ closedBall (0 : ℂ) R :=
  ⟨((|R| + 1 : ℝ) : ℂ), by
    rw [mem_closedBall, dist_zero_right, Complex.norm_real, Real.norm_of_nonneg (by positivity), not_le]
    linarith [le_abs_self R]⟩

/-- **The outer domain of a set with bounded closure is one complementary component**: the one through any point outside a disc holding
the closure. -/
theorem outerDom_eq_connectedComponentIn {T : Set ℂ} {R : ℝ} (hTR : closure T ⊆ closedBall 0 R) {z₀ : ℂ}
    (hz₀ : z₀ ∉ closedBall (0 : ℂ) R) : outerDom T = connectedComponentIn (closure T)ᶜ z₀ := by
  have hsub : (closedBall (0 : ℂ) R)ᶜ ⊆ connectedComponentIn (closure T)ᶜ z₀ :=
    (isPreconnected_compl_closedBall 0 R).subset_connectedComponentIn hz₀ (compl_subset_compl.mpr hTR)
  have hunb : ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z₀) := by
    intro hb
    obtain ⟨R', hR'⟩ := hb.subset_closedBall 0
    obtain ⟨w, hw⟩ := exists_not_mem_closedBall_zero (max R R')
    exact hw (closedBall_subset_closedBall (le_max_right _ _) (hR' (hsub fun h =>
      hw (closedBall_subset_closedBall (le_max_left _ _) h))))
  have hbd : Bornology.IsBounded (closure T) := isBounded_closedBall.subset hTR
  ext z
  constructor
  · rintro ⟨hzT, hz⟩
    rw [← connectedComponentIn_eq_of_not_isBounded hbd hz hunb]
    exact mem_connectedComponentIn hzT
  · intro hz
    exact ⟨connectedComponentIn_subset _ _ hz, by rw [← connectedComponentIn_eq hz]; exact hunb⟩

/-- **The outermost tile** (E4-OUTERMOST steps 1–2): in a valid map covering `B̄(x, 1 + ρ)`, some tile `T*` has `x` in its hull, its hull in
`B̄(x, 1)`, and no tile enclosing it. (A tile has diameter at most `1`, its hull lies in the convex hull of its closure; enclosure strictly
grows hulls; the chain from a tile at `x` stays among the finitely many tiles meeting `B̄(x, 1)`.) -/
theorem exists_outermost (hF : F.Valid) {x : ℂ} {ρ : ℝ} (hρ : 0 < ρ) (hx : closedBall x (1 + ρ) ⊆ F.dom) :
    ∃ T, F.IsTile T ∧ x ∉ outerDom T ∧ (outerDom T)ᶜ ⊆ closedBall x 1 ∧ ∀ T', F.IsTile T' → ¬ EnclosesTile T' T := by
  sorry

/-- **Two outer tiles meet on the rim of an un-enclosed tile** (E4-OUTERMOST step 3): the rim `Φ* = frontier (outerDom T*)` is preconnected
(`isPreconnected_frontier_connectedComponentIn`) and lies in the closures of the tiles of `outerDom T*` touching it, finitely many; were there
one, `T*` would lie in a bounded component of the complement of its closure (`isBounded_connectedComponentIn_of_frontier_subset`), against
`hno`; so two meet at a point `v` of `Φ* ⊆ cl T*` (`exists_inter_of_finite_closed_cover`). -/
theorem exists_rim_vertex (hF : F.Valid) {T : Set ℂ} (hT : F.IsTile T) (hdom : (outerDom T)ᶜ ⊆ F.dom)
    (hno : ∀ T', F.IsTile T' → ¬ EnclosesTile T' T) :
    ∃ X Y v, F.IsTile X ∧ F.IsTile Y ∧ X ≠ Y ∧ X ⊆ outerDom T ∧ Y ⊆ outerDom T ∧ v ∈ frontier (outerDom T) ∧
      v ∈ closure T ∧ v ∈ closure X ∧ v ∈ closure Y := by
  obtain ⟨x, hx⟩ := hT.nonempty
  have hTR := hT.closure_subset_closedBall_zero hF hx
  obtain ⟨z₀, hz₀⟩ := exists_not_mem_closedBall_zero (‖x‖ + 1)
  have hW := outerDom_eq_connectedComponentIn hTR hz₀
  set W := outerDom T with hWdef
  have hcl : IsClosed (closure T) := isClosed_closure
  have hWo : IsOpen W := by rw [hW]; exact hcl.isOpen_compl.connectedComponentIn
  set Φ := frontier W with hΦ
  -- the rim: preconnected, inside `cl T`, compact, nonempty
  have hΦpre : IsPreconnected Φ := by
    rw [hΦ, hW]; exact isPreconnected_frontier_connectedComponentIn hcl hT.isPreconnected.closure z₀
  have hΦT : Φ ⊆ closure T := by
    rw [hΦ, hW]; intro v hv; simpa using frontier_connectedComponentIn_subset hcl.isOpen_compl z₀ hv
  have hΦc : IsCompact Φ := (isCompact_closedBall 0 (‖x‖ + 1)).of_isClosed_subset isClosed_frontier (hΦT.trans hTR)
  have hΦd : Φ ⊆ F.dom := fun v hv => hdom (fun hvW => (hWo.inter_frontier_eq.subset ⟨hvW, hv⟩ : v ∈ (∅ : Set ℂ)))
  have hz₀W : z₀ ∈ W := by rw [hW]; exact mem_connectedComponentIn (fun h => hz₀ (hTR h))
  have hΦne : Φ.Nonempty := by
    rw [hΦ, nonempty_frontier_iff]
    refine ⟨⟨z₀, hz₀W⟩, fun h => ?_⟩
    exact (h ▸ mem_univ x : x ∈ W).1 (subset_closure hx)
  -- a tile meeting `W` lies in `W`
  have hinW : ∀ X, F.IsTile X → (X ∩ W).Nonempty → X ⊆ W := by
    rintro X hX ⟨w, hwX, hwW⟩
    have hXT : X ≠ T := by rintro rfl; exact hwW.1 (subset_closure hwX)
    rw [hW] at hwW ⊢
    rw [connectedComponentIn_eq hwW]
    exact hX.isPreconnected.subset_connectedComponentIn hwX (IsTile.subset_compl_closure hT hX hXT)
  -- the tiles of `W` touching the rim: finitely many, covering it
  set s := {X | F.IsTile X ∧ X ⊆ W ∧ (closure X ∩ Φ).Nonempty} with hs
  have hsfin : s.Finite := (finite_tiles_closure_inter hΦc hΦd).subset fun X hX => ⟨hX.1, hX.2.2⟩
  have hcov : Φ ⊆ ⋃ X ∈ s, closure X := by
    intro v hv
    obtain ⟨X, hX, hXW, hvX⟩ := exists_tile_mem_closure_of_mem_closure hWo (hΦd hv) hv.1
    exact mem_iUnion₂.mpr ⟨X, ⟨hX, hinW X hX hXW, v, hvX, hv⟩, hvX⟩
  -- two of them: one alone would enclose `T` (the last exit)
  obtain ⟨v₀, hv₀⟩ := hΦne
  obtain ⟨X, hXs, hv₀X⟩ := mem_iUnion₂.mp (hcov hv₀)
  obtain ⟨Y, hYs, hXY⟩ : ∃ Y ∈ s, X ≠ Y := by
    by_contra hall
    push Not at hall
    -- the rim lies in `cl X`
    have hΦX : Φ ⊆ closure X := by
      intro v hv
      obtain ⟨Y, hYs, hvY⟩ := mem_iUnion₂.mp (hcov hv)
      rwa [← hall Y hYs] at hvY
    have hXT : X ≠ T := by
      rintro rfl
      obtain ⟨w, hw⟩ := hXs.1.nonempty
      exact (hXs.2.1 hw).1 (subset_closure hw)
    have hxX : x ∉ closure X := by
      intro h
      obtain ⟨w, hw, hwx⟩ := (closure_inter_open_nonempty_iff hT.isOpen).mp ⟨x, h, hx⟩
      exact Set.disjoint_left.mp (Set.disjoint_left.mpr fun a ha haT =>
        hXT (hXs.1.eq_of_mem hT ha haT)) hw hwx
    apply hno X hXs.1
    refine ⟨x, ⟨hx, hxX⟩, ?_⟩
    have hbd : Bornology.IsBounded (closure T) := isBounded_closedBall.subset hTR
    have hunb : ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ z₀) := by
      rw [← hW]; intro hb
      exact hz₀W.2 (by rw [← connectedComponentIn_eq (by rw [← hW]; exact hz₀W)]; rw [hW] at hb; exact hb)
    exact isBounded_connectedComponentIn_of_frontier_subset hcl hbd isClosed_closure hunb
      (by rw [← hW]; exact hΦX) (by rw [← hW]; exact fun h => h.1 (subset_closure hx)) hxX
  obtain ⟨X', hX's, Y', hY's, hne, v, ⟨hvΦ, hvX'⟩, hvY'⟩ :=
    exists_inter_of_finite_closed_cover hΦpre hsfin (fun X => closure X) (fun _ _ => isClosed_closure) hcov hXs hYs hXY
      ⟨v₀, hv₀, hv₀X⟩ (by obtain ⟨w, hw1, hw2⟩ := hYs.2.2; exact ⟨w, hw2, hw1⟩)
  exact ⟨X', Y', v, hX's.1, hY's.1, hne, hX's.2.1, hY's.2.1, hvΦ, hΦT hvΦ, hvX', hvY'⟩

/-- **A tile at a chart's point holds a sector of every small radius**: if `v ∈ cl A` and `v`'s chart has germs, then for every `r ∈ (0, r₀]`
some sector of radius `r` lies in `A` (a sector meeting `A` is preconnected inside the interior points, so inside `A`'s component). -/
theorem IsSectorChart.exists_sector_subset_tile {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : 0 < n) {r : ℝ} (hr : r ∈ Ioc 0 r₀) {A : Set ℂ} (hA : F.IsTile A) (hvA : v ∈ closure A) : ∃ i, G.sector v r i ⊆ A := by
  obtain ⟨w, hwA, hwb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hr.1⟩
  have hw : w ∈ ball v r ∩ F.interiorPts := ⟨hwb, hA.subset_interiorPts hwA⟩
  rw [hC.cover r hr hn] at hw
  obtain ⟨i, hi⟩ := mem_iUnion.mp hw
  refine ⟨i, ?_⟩
  obtain ⟨x, hx, rfl⟩ := hA
  rw [connectedComponentIn_eq hwA]
  exact (hC.isPreconnected r hr i).subset_connectedComponentIn hi (hC.sector_subset_interiorPts hn hr i)

/-- **Two tiles of one colour at a point give it a repeated colour**: each holds a sector of every small radius, and the two sectors differ. -/
theorem hasRepeatedColour_of_two_tiles {v : ℂ} (hv : v ∈ F.dom) {A B : Set ℂ} {c : Fin k} (hA : F.TileOf c A)
    (hB : F.TileOf c B) (hAB : A ≠ B) (hvA : v ∈ closure A) (hvB : v ∈ closure B) : F.HasRepeatedColour v := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  have hn : 0 < n := by
    by_contra h0
    have hball := hC.empty (by omega)
    obtain ⟨a, haA, hab⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvA, mem_ball_self hC.pos⟩
    obtain ⟨b, hbB, hbb⟩ := (closure_inter_open_nonempty_iff isOpen_ball).mp ⟨v, hvB, mem_ball_self hC.pos⟩
    have h1 : ball v r₀ ⊆ A := by
      obtain ⟨x, hx, hAx⟩ := hA.1
      rw [hAx, connectedComponentIn_eq (hAx ▸ haA)]
      exact (convex_ball v r₀).isPreconnected.subset_connectedComponentIn hab hball
    exact hAB (hA.1.eq_of_mem hB.1 (h1 hbb) hbB)
  refine ⟨c, ?_⟩
  filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
  obtain ⟨i, hi⟩ := hC.exists_sector_subset_tile hn hr hA.1 hvA
  obtain ⟨j, hj⟩ := hC.exists_sector_subset_tile hn hr hB.1 hvB
  have hne : G.sector v r i ≠ G.sector v r j := by
    intro h
    obtain ⟨w, hw⟩ := hC.sector_nonempty hr i
    exact hAB (hA.1.eq_of_mem hB.1 (hi hw) (hj (h ▸ hw)))
  have hSi : G.sector v r i ∈ F.sectorsOf v r c := ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, hi.trans hA.2⟩
  have hSj : G.sector v r j ∈ F.sectorsOf v r c := ⟨(hC.isSector_iff hn hr).mpr ⟨j, rfl⟩, hj.trans hB.2⟩
  calc (2 : ℕ∞) = ({G.sector v r i, G.sector v r j} : Set (Set ℂ)).encard := (Set.encard_pair hne).symm
    _ ≤ (F.sectorsOf v r c).encard := Set.encard_le_encard (insert_subset_iff.mpr ⟨hSi, singleton_subset_iff.mpr hSj⟩)

/-- **Three distinct tiles at a good point make it cubic trichromatic** (E4-OUTERMOST step 4; E4-RIM step 5): no repeated colour gives three
colours, no fourth colour gives exactly three, then `isCubicTrichromatic_of_three_of_noRep`. -/
theorem isCubicTrichromatic_of_three_tiles {v : ℂ} (hv : v ∈ F.dom) {A B C : Set ℂ} (hA : F.IsTile A) (hB : F.IsTile B)
    (hC : F.IsTile C) (hAB : A ≠ B) (hAC : A ≠ C) (hBC : B ≠ C) (hvA : v ∈ closure A) (hvB : v ∈ closure B) (hvC : v ∈ closure C)
    (hgood : v ∉ F.fourSet ∪ F.repSet) : F.IsCubicTrichromatic v := by
  have hnr : ¬ F.HasRepeatedColour v := fun h => hgood (Or.inr ⟨hv, h⟩)
  -- each tile has one colour, carried at `v`
  have hcol : ∀ {P}, F.IsTile P → v ∈ closure P → ∃ c, F.TileOf c P ∧ c ∈ F.coloursAt v := by
    intro P hP hvP
    obtain ⟨p, hp⟩ := hP.nonempty
    refine ⟨F.col p, hP.tileOf hp, ?_⟩
    show v ∈ closure (F.region (F.col p))
    have hsub : P ⊆ F.region (F.col p) := fun z hz => ⟨hP.subset_interiorPts hz, (hP.tileOf hp).2 hz⟩
    exact closure_mono hsub hvP
  obtain ⟨a, ha, hav⟩ := hcol hA hvA
  obtain ⟨b, hb, hbv⟩ := hcol hB hvB
  obtain ⟨c, hc, hcv⟩ := hcol hC hvC
  -- distinct tiles at `v` have distinct colours (else a repeated colour)
  have hdist : ∀ {P Q : Set ℂ} {p q : Fin k}, F.TileOf p P → F.TileOf q Q → P ≠ Q → v ∈ closure P → v ∈ closure Q → p ≠ q := by
    rintro P Q p q hP hQ hPQ hvP hvQ rfl
    exact hnr (hasRepeatedColour_of_two_tiles hv hP hQ hPQ hvP hvQ)
  have hab := hdist ha hb hAB hvA hvB
  have hac := hdist ha hc hAC hvA hvC
  have hbc := hdist hb hc hBC hvB hvC
  have h3 : (F.coloursAt v).ncard = 3 := by
    have hge : 3 ≤ (F.coloursAt v).ncard := by
      have : ({a, b, c} : Set (Fin k)).ncard = 3 := Set.ncard_eq_three.mpr ⟨a, b, c, hab, hac, hbc, rfl⟩
      rw [← this]
      exact Set.ncard_le_ncard (insert_subset_iff.mpr ⟨hav, insert_subset_iff.mpr ⟨hbv, singleton_subset_iff.mpr hcv⟩⟩)
        (Set.toFinite _)
    have hle : (F.coloursAt v).ncard < 4 := by
      by_contra h
      push Not at h
      exact hgood (Or.inl ⟨hv, h⟩)
    omega
  exact isCubicTrichromatic_of_three_of_noRep hv h3 hnr

/-- **The rim vertex is un-enclosed** (E4-OUTERMOST step 5): its three tiles are `T*` (enclosed by none), and two tiles of `T*`'s outer
domain, each of which a bounded complementary component of a tile's closure would carry together with `T*` (a small disc about `v`, or the
sectors of `T*` and the tile at `v` with the arc between them, connects them off that closure). -/
theorem unenclosed_of_rim_vertex {T X Y : Set ℂ} {v : ℂ} (hv : v ∈ F.dom) (hT : F.IsTile T) (hX : F.IsTile X) (hY : F.IsTile Y)
    (hXY : X ≠ Y) (hXo : X ⊆ outerDom T) (hYo : Y ⊆ outerDom T) (hvT : v ∈ closure T) (hvX : v ∈ closure X) (hvY : v ∈ closure Y)
    (hcub : F.IsCubicTrichromatic v) (hno : ∀ T', F.IsTile T' → ¬ EnclosesTile T' T) : F.Unenclosed v := by
  sorry

/-! ## C — the rim of `u`'s component (FS131-E4 E4-RIM: the eleventh point) -/

/-- **Lemma H(a)** (E4-RIM step 1, FS110-CD Lemma H): in a valid map, a tile of a colour `j` whose `j`-tile `S` holds `u` in its closure, if it
meets `B(u, 1)`, lies in `B(u, 1)` (`S × T` is connected, carries no distance `1`, and holds a pair closer than `1`). Any `k`. -/
theorem tileOf_subset_ball (hF : F.Valid) {u : ℂ} {j : Fin k} {S T : Set ℂ} (hS : F.TileOf j S) (huS : u ∈ closure S)
    (hT : F.TileOf j T) (hTb : (T ∩ ball u 1).Nonempty) : T ⊆ ball u 1 := by
  -- no pair of the two tiles is at distance `1` (one colour, validity)
  have hne : ∀ s ∈ S, ∀ t ∈ T, dist s t ≠ 1 := fun s hs t ht h1 =>
    hF s (hS.1.subset_interiorPts hs) t (hT.1.subset_interiorPts ht) h1 (by rw [hS.2 hs, hT.2 ht])
  obtain ⟨t₀, ht₀T, ht₀u⟩ := hTb
  rw [mem_ball] at ht₀u
  -- a pair near `(u, t₀)` is closer than `1`
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp huS (1 - dist t₀ u) (by linarith)
  have hnear : dist s₀ t₀ < 1 := by
    have := dist_triangle s₀ u t₀
    rw [dist_comm u t₀, dist_comm s₀ u] at this
    linarith
  -- so every pair is closer than `1` (the distances over the connected `S × T` form an interval missing `1`)
  have hpre : IsPreconnected ((fun q : ℂ × ℂ => dist q.1 q.2) '' (S ×ˢ T)) :=
    (hS.1.isPreconnected.prod hT.1.isPreconnected).image _ (continuous_fst.dist continuous_snd).continuousOn
  have hall : ∀ q ∈ S ×ˢ T, dist q.1 q.2 ≤ 1 := by
    rintro ⟨s, t⟩ ⟨hs, ht⟩
    by_contra hlt
    push Not at hlt
    obtain ⟨q, hq, hq1⟩ := hpre.Icc_subset ⟨(s₀, t₀), ⟨hs₀, ht₀T⟩, rfl⟩ ⟨(s, t), ⟨hs, ht⟩, rfl⟩ ⟨hnear.le, hlt.le⟩
    exact hne q.1 hq.1 q.2 hq.2 hq1
  -- on the closure of `S`, so `dist u t ≤ 1` on `T`; `T` open makes it strict
  have hcl : closure (S ×ˢ T) ⊆ {q : ℂ × ℂ | dist q.1 q.2 ≤ 1} :=
    closure_minimal hall (isClosed_le (continuous_fst.dist continuous_snd) continuous_const)
  rw [closure_prod_eq] at hcl
  have hle : ∀ t ∈ T, dist t u ≤ 1 := fun t ht => by
    rw [dist_comm]; exact hcl (show (u, t) ∈ closure S ×ˢ closure T from ⟨huS, subset_closure ht⟩)
  intro t ht
  rw [mem_ball]
  refine lt_of_le_of_ne (hle t ht) fun h1 => ?_
  -- a point of `T` just beyond `t`, away from `u`, would be farther than `1`
  obtain ⟨ε, hε, hεT⟩ := Metric.isOpen_iff.mp hT.1.isOpen t ht
  set t' := t + ((ε / 2 : ℝ) : ℂ) * (t - u) with ht'
  have ht'T : t' ∈ T := hεT (by
    rw [mem_ball, ht', dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith),
      ← dist_eq_norm, h1]
    linarith)
  have : dist t' u = (1 + ε / 2) * dist t u := by
    rw [ht', dist_eq_norm, dist_eq_norm, show t + ((ε / 2 : ℝ) : ℂ) * (t - u) - u = ((1 + ε / 2 : ℝ) : ℂ) * (t - u) by
      push_cast; ring, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  have := hle t' ht'T
  rw [‹dist t' u = _›, h1] at this
  linarith

/-- **The eleventh point** (FS131-E4 E4-RIM, all five steps; `BaseCtx.exists_eleventh`'s content with the context's fields as hypotheses).
`R*` is the component of `u` in the union of the closures of the tiles of `u`'s colours meeting `B(u, 1)` (finitely many); its tiles lie in
`B(u, 1)` (`tileOf_subset_ball`) and every tile of `u`'s colours touching it is one of them (N3-NOBOTH, `noBoth`, at a touching point on
`ω(u)`); the frontier of `R*`'s outer domain is preconnected and meets two of its tiles (one alone would enclose `u`'s other tiles, against
`UnenclosedC u`: `isBounded_connectedComponentIn_of_frontier_subset`); two meet there (`exists_inter_of_finite_closed_cover`) at `q`; a tile at
`q` meets the outer domain and has no colour of `u`; no fourth colour. -/
theorem exists_eleventh_of {F : ArcMap 6} {u : ℂ} (hF : F.Valid) (hcov : F.Covers u 2) (hu : F.IsCubicTrichromatic u)
    (hH : F.BaseHyp u) (hE : F.UnenclosedC u) :
    ∃ q ∈ closedBall u 1, (F.coloursAt q).ncard = 3 ∧ (F.coloursAt q ∩ F.coloursAt u).ncard = 2 ∧
      ∀ j ∈ F.coloursAt q ∩ F.coloursAt u, ∀ T, F.TileOf j T → q ∈ closure T → T ⊆ ball u 1 := by
  sorry

/-! ## D — the common boundary of two tiles in a disc; arcs of one circle -/

/-- **The `a|c` boundary from a change point has a far end** (the planar parity step of Prop. 19(b), FS110-CD Lemma E): at a change point
`r(θ)` of the pseudo-colouring of `ω(u)` from `a` (clockwise) to `c` (counter-clockwise), the `a`-tile `T₁` and the `c`-tile `T₂` there have,
in the component of `r(θ)` in `cl T₁ ∩ cl T₂ ∩ B̄(u, 1)`, a point with a third colour (possibly `r(θ)` itself) or a second point of `ω(u)`.
(`r(θ)` itself may carry three colours — germs along in-contact arcs of `ω(u)` with a colour of `u` inside, the `a|c` branch leaving
outward, the component `{r(θ)}`; then `r(θ)` is V-in, an endpoint: the obligation pass's correction, plan § 4.) Planned over the
finite boundary graph of `F` in `B̄(u, 1)` (vertices: arc ends, crossings, points on `ω(u)`; edges: arc pieces), whose `T₁|T₂` subgraph has
degree `2` at every two-colour point of `B(u, 1)` (two sectors, no repeated colour under H) and, when `r(θ)` has two colours, degree `1`
there (one branch enters the disc: the germ change), so
the handshake lemma (`SimpleGraph.even_card_odd_degree_vertices`) gives a second odd vertex in `r(θ)`'s component. -/
theorem exists_far_end {F : ArcMap 6} {u : ℂ} (hF : F.Valid) (hcov : F.Covers u 2) (hH : F.BaseHyp u) {θ : ℝ} {a c : Fin 6}
    (hac : a ≠ c) (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .ccw c) :
    ∃ T₁ T₂, F.TileOf a T₁ ∧ F.TileOf c T₂ ∧ ringPt u θ ∈ closure T₁ ∧ ringPt u θ ∈ closure T₂ ∧
      ∃ q ∈ connectedComponentIn (closure T₁ ∩ closure T₂ ∩ closedBall u 1) (ringPt u θ),
        (F.coloursAt q).ncard = 3 ∨ (q ≠ ringPt u θ ∧ dist q u = 1) := by
  sorry

/-- A germ has one pseudo-colour: the clockwise germ at `r(θ)` cannot have pseudo-colours `a` and `c ≠ a` (the dead disjunct of
`exists_endpoint`'s `hc`, QA3 § 2.4 e). -/
theorem GermPseudo.eq_of_cw {u : ℂ} {θ : ℝ} {a c : Fin k} (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .cw c) : a = c := by
  obtain ⟨δ₁, hδ₁, h₁⟩ := ha
  obtain ⟨δ₂, hδ₂, h₂⟩ := hc
  have hδ : 0 < min δ₁ δ₂ := lt_min hδ₁ hδ₂
  obtain ⟨z, hz⟩ : (germ u θ .cw (min δ₁ δ₂)).Nonempty :=
    ⟨_, mem_image_of_mem _ (show min δ₁ δ₂ / 2 ∈ Ioo 0 (min δ₁ δ₂) from ⟨by linarith, by linarith⟩)⟩
  have e₁ : F.pseudoColours u z = {a} := h₁ (germ_mono (min_le_left _ _) hz)
  have e₂ : F.pseudoColours u z = {c} := h₂ (germ_mono (min_le_right _ _) hz)
  exact Set.singleton_eq_singleton_iff.mp (e₁.symm.trans e₂)

end ArcMap

/-- An arc of `ω(u)` is unchanged by shifting both ends by a multiple of `2π`. -/
theorem ringArc_add_two_pi_mul (u : ℂ) (s t : ℝ) (n : ℤ) :
    ringArc u (s + 2 * π * n) (t + 2 * π * n) = ringArc u s t := by
  unfold ringArc
  rw [← Set.image_add_const_Icc, Set.image_image]
  congr 1
  ext θ
  simp only [ringPt, e_add_int_mul]

/-- **Two short arcs of one circle** (`retArcs_nested`'s case split): arcs `[s, t]`, `[s', t']` shorter than `60°` are disjoint, nested,
interleaved (one end of each strictly inside the other, modulo `2π`), or abut (an end of one is an end of the other and they are not
nested). -/
theorem ringArc_cases (u : ℂ) {s t s' t' : ℝ} (hst : s < t) (hst' : t < s + π / 3) (hs't' : s' < t') (hs't'' : t' < s' + π / 3) :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t ∨
      (∃ n : ℤ, (s < s' + 2 * π * n ∧ s' + 2 * π * n < t ∧ t < t' + 2 * π * n) ∨
        (s' + 2 * π * n < s ∧ s < t' + 2 * π * n ∧ t' + 2 * π * n < t)) ∨
      ringPt u t = ringPt u s' ∨ ringPt u t' = ringPt u s := by
  have hπ := Real.pi_pos
  -- shift the second arc to start within `π` of `s`
  set n : ℤ := ⌊(s - s' + π) / (2 * π)⌋ with hn
  have hn1 : (n : ℝ) ≤ (s - s' + π) / (2 * π) := Int.floor_le _
  have hn2 : (s - s' + π) / (2 * π) < n + 1 := Int.lt_floor_add_one _
  rw [le_div_iff₀ (by positivity)] at hn1
  rw [div_lt_iff₀ (by positivity)] at hn2
  set σ := s' + 2 * π * n with hσ
  set τ := t' + 2 * π * n with hτ
  have hσ1 : s - π < σ := by rw [hσ]; nlinarith
  have hσ2 : σ ≤ s + π := by rw [hσ]; nlinarith
  have hστ : σ < τ := by rw [hσ, hτ]; linarith
  have hστ' : τ < σ + π / 3 := by rw [hσ, hτ]; linarith
  have hA : ringArc u s' t' = ringArc u σ τ := (ringArc_add_two_pi_mul u s' t' n).symm
  have hrt' : ringPt u t' = ringPt u τ := by simp only [ringPt, hτ, e_add_int_mul]
  have hrs' : ringPt u s' = ringPt u σ := by simp only [ringPt, hσ, e_add_int_mul]
  -- real intervals that miss each other give arcs that miss each other
  have hdisj : (τ < s ∨ t < σ) → Disjoint (ringArc u s t) (ringArc u s' t') := by
    intro h
    rw [hA, Set.disjoint_left]
    rintro z ⟨θ, hθ, rfl⟩ ⟨φ, hφ, hφθ⟩
    simp only [ringPt, add_right_inj] at hφθ
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp hφθ
    have hm0 : m = 0 := by
      have h1 : (m * (2 * π) : ℝ) < 2 * π := by linarith [hθ.1, hθ.2, hφ.1, hφ.2]
      have h2 : -(2 * π) < (m * (2 * π) : ℝ) := by linarith [hθ.1, hθ.2, hφ.1, hφ.2]
      have h1' : (m : ℝ) < 1 := by nlinarith
      have h2' : (-1 : ℝ) < m := by nlinarith
      have : m < 1 := by exact_mod_cast h1'
      have : -1 < m := by exact_mod_cast h2'
      omega
    rw [hm0] at hm
    simp at hm
    rcases h with h | h
    · linarith [hθ.1, hφ.2]
    · linarith [hθ.2, hφ.1]
  rcases lt_trichotomy τ s with h1 | h1 | h1
  · exact Or.inl (hdisj (Or.inl h1))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (by rw [hrt', h1])))))
  rcases lt_trichotomy t σ with h2 | h2 | h2
  · exact Or.inl (hdisj (Or.inr h2))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (by rw [hrs', h2])))))
  rw [hA]
  rcases le_or_gt σ s with h3 | h3
  · rcases le_or_gt t τ with h4 | h4
    · exact Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h3 h4)))
    · rcases eq_or_lt_of_le h3 with h5 | h5
      · exact Or.inr (Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h5.ge h4.le))))
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨n, Or.inr ⟨h5, h1, h4⟩⟩)))
  · rcases le_or_gt τ t with h4 | h4
    · exact Or.inr (Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h3.le h4))))
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨n, Or.inl ⟨h3, h2, h4⟩⟩)))

end HadwigerNelson.Plane
