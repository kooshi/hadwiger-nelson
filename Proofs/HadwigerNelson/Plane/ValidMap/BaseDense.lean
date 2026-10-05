import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk

/-!
# Row 134's base with unit arcs, and the density rows that rest on it

Moved from `Plane/ValidMap/Dense` by job FS131-KB (statements unchanged), downstream of the walk's leaves (`Plane/ValidMap/BaseWalk`):
`row134BaseUA` (the walk's assembly, `plans/FS131-w5base-kernel-plan.md` § 4) and its consumers FS112-N3-BASE (`n3_base`),
FS129-OR1-LOCALDENSE (`localDense`), FS112-N3-DENSE3 (`dense3`), FS114-CV-EXISTS (`cv_exists`).

FS131-E4's repair (b) (inventory item 227, `plans/FS131-E4-derivation.md` § 5.2): `Row134BaseUA` and `n3_base` carry `UnenclosedC u`; the
pre-bend keeps it (`exists_preBend`, E4-BEND-UN); `localDense` chooses its vertex by E4-OUTERMOST (`exists_unenclosed_or_bad`) in place of
FS112-DISC1's, so `localDense`, `dense3` and `cv_exists` keep their statements.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

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
theorem row134BaseUA : Row134BaseUA := by
  sorry

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
