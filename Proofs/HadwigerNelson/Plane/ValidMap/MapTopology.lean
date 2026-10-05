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
  sorry

/-- **Three distinct tiles at a good point make it cubic trichromatic** (E4-OUTERMOST step 4; E4-RIM step 5): no repeated colour gives three
colours, no fourth colour gives exactly three, then `isCubicTrichromatic_of_three_of_noRep`. -/
theorem isCubicTrichromatic_of_three_tiles {v : ℂ} (hv : v ∈ F.dom) {A B C : Set ℂ} (hA : F.IsTile A) (hB : F.IsTile B)
    (hC : F.IsTile C) (hAB : A ≠ B) (hAC : A ≠ C) (hBC : B ≠ C) (hvA : v ∈ closure A) (hvB : v ∈ closure B) (hvC : v ∈ closure C)
    (hgood : v ∉ F.fourSet ∪ F.repSet) : F.IsCubicTrichromatic v := by
  sorry

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
  sorry

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
  sorry

end ArcMap

/-- **Two short arcs of one circle** (`retArcs_nested`'s case split): arcs `[s, t]`, `[s', t']` shorter than `60°` are disjoint, nested,
interleaved (one end of each strictly inside the other, modulo `2π`), or abut (an end of one is an end of the other and they are not
nested). -/
theorem ringArc_cases (u : ℂ) {s t s' t' : ℝ} (hst : s < t) (hst' : t < s + π / 3) (hs't' : s' < t') (hs't'' : t' < s' + π / 3) :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t ∨
      (∃ n : ℤ, (s < s' + 2 * π * n ∧ s' + 2 * π * n < t ∧ t < t' + 2 * π * n) ∨
        (s' + 2 * π * n < s ∧ s < t' + 2 * π * n ∧ t' + 2 * π * n < t)) ∨
      ringPt u t = ringPt u s' ∨ ringPt u t' = ringPt u s := by
  sorry

end HadwigerNelson.Plane
