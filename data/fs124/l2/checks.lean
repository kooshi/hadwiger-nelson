import Proofs
/-!
FS124-L2 — the definitions and the theorems the landing is for, as the kernel holds them, with their axioms, for the
reading aloud; and the models of the hypotheses, as terms — each a model of every hypothesis of one theorem at once,
with the theorem run on it.  Iteration file, run by the gate's runner after the build
(`lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs124/l2/checks.lean`); never a library module,
and nothing here is a theorem of the library.
-/
open HadwigerNelson HadwigerNelson.Plane Metric Set MeasureTheory Complex Topology
set_option pp.funBinderTypes true
set_option pp.numericTypes true
set_option pp.fullNames true

-- § 1  the definitions, as stored
#print HadwigerNelson.Plane.CircleSide
#print HadwigerNelson.Plane.CircleSide.region
#print HadwigerNelson.Plane.InnerAt
#print HadwigerNelson.Plane.OuterAt
#print HadwigerNelson.Plane.CrossingAt
#print HadwigerNelson.Plane.IsPieceAt
#print HadwigerNelson.Plane.IsTightWith
#print HadwigerNelson.Plane.IsTight
#print HadwigerNelson.Plane.ThreePiece
#print HadwigerNelson.Plane.ThreePiece.edge
#print HadwigerNelson.Plane.ThreePiece.SeparatesAt
#print HadwigerNelson.Plane.ThreePiece.OneOfEach
#print HadwigerNelson.Plane.ThreePiece.IsFull
#print HadwigerNelson.Plane.HasUnitArcFrom
#print HadwigerNelson.Plane.ThreePiece.Saves
#print HadwigerNelson.Plane.ThreePiece.HasArcEdges
#print HadwigerNelson.Plane.ThreePiece.IsSector
#print HadwigerNelson.Plane.ClosePair
#print HadwigerNelson.Plane.IsCommonUnitPoint
#print HadwigerNelson.Plane.presentAt
#print HadwigerNelson.Plane.IsTriod
#print HadwigerNelson.Plane.IsTriodCut

-- § 2  the statements, as stored
#check @shadow_open
#check @piece_type
#check @centre_half
#check @tight_centre
#check @tight_straddle
#check @closePair_forced_pieces
#check @closePair_lone
#check @closePair_both_separate
#check @closePair_both_saved
#check @closePair_four
#check @closePair_both_saved_of_isSector
#check @ThreePiece.IsSector.hasArcEdges
#check @ThreePiece.IsSector.isFull
#check @IsTriodCut.exists_opposite
#check @IsTriodCut.exists_arc
#check @exists_closePair_not_separatesAt
#check @exists_closePair_full
#check @exists_closePair_sector
#check @exists_closePair_seven_not_separatesAt
#check @sectorPoint_isSector
#check @ClosePair.separatesAt_or
#check @ClosePair.exists_label_eq
#check @isWeakColouringOn_tightModel
#check @isTight_tightModel

-- § 3  their axioms
#print axioms shadow_open
#print axioms piece_type
#print axioms centre_half
#print axioms tight_centre
#print axioms tight_straddle
#print axioms closePair_forced_pieces
#print axioms closePair_lone
#print axioms closePair_both_separate
#print axioms closePair_both_saved
#print axioms closePair_four
#print axioms closePair_both_saved_of_isSector
#print axioms ThreePiece.IsSector.hasArcEdges
#print axioms ThreePiece.IsSector.isFull
#print axioms IsTriodCut.exists_opposite
#print axioms IsTriodCut.exists_arc
#print axioms exists_closePair_not_separatesAt
#print axioms exists_closePair_full
#print axioms exists_closePair_sector
#print axioms exists_closePair_seven_not_separatesAt
#print axioms sectorPoint_isSector

namespace FS124L2

-- § 4  the models, as terms

/-- The three-arcs lemma's hypothesis is inhabited: the data of the three-sector point's `IsSector` is an
`IsTriodCut` — the same construction as the bridge's two lines, on the model. -/
theorem model_triodCut :
    ∃ (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)), IsTriodCut (0 : ℂ) r J sectorPoint.piece := by
  obtain ⟨r, hr, J, h1, h2, h3, h4, h5, -, h7⟩ := sectorPoint_isSector
  exact ⟨r, J, ⟨hr, h1, h2, h3, h4, h5⟩, sectorPoint.isOpen_piece, sectorPoint.isPreconnected_piece,
    fun _ _ hab => sectorPoint.disjoint_piece hab, h7⟩

/-- … and on it the three-arcs lemma's conclusion holds: every two sectors share an arc from `0`. -/
theorem model_triodCut_arc {i j : Fin 3} (hij : i ≠ j) :
    ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧
      range γ ⊆ closure (sectorPoint.piece i) ∩ closure (sectorPoint.piece j) ∩ ball (0 : ℂ) (1 / 8) := by
  obtain ⟨r, J, h⟩ := model_triodCut
  exact h.exists_arc (ball_mem_nhds _ (by norm_num)) hij

/-- Every hypothesis of `closePair_forced_pieces` and `closePair_lone` at once, on one object, with the conclusion
of `closePair_lone` drawn on it. -/
theorem model_lone :
    ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ ¬ C.right.SeparatesAt w ∧
        ∃ σ : Equiv.Perm (Fin 3), C.left.OneOfEach w σ := by
  obtain ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hy⟩ := exists_closePair_not_separatesAt
  obtain ⟨σ, hσ, -⟩ := closePair_lone hU hc C hw hwu hy
  exact ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hy, σ, hσ⟩

/-- Every hypothesis of `closePair_both_saved_of_isSector` at once, with its conclusion drawn: on the unit-square
witness both members are sector points and both save the common unit point. -/
theorem model_sector :
    ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ C.left.IsSector ∧ C.right.IsSector ∧
        C.left.Saves w ∧ C.right.Saves w := by
  obtain ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hsx, hsy⟩ := exists_closePair_sector
  exact ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hsx, hsy, closePair_both_saved_of_isSector hU hc C hw hwu hsx hsy⟩

/-- A sector point in the claim list's words is full and arc-edged (the bridge and its corollary, on the model). -/
theorem model_sector_full : sectorPoint.IsFull ∧ sectorPoint.HasArcEdges :=
  ⟨sectorPoint_isSector.isFull, sectorPoint_isSector.hasArcEdges⟩

/-- The one-piece statements' class is inhabited with a tight pair, and `tight_centre` runs on it. -/
theorem model_tight :
    IsOpen tightModelDom ∧ IsWeakColouringOn tightModelDom tightModel ∧ IsTight tightModelDom tightModel 0 1 0 1 ∧
      ∃ η > 0, (∀ᵐ w, w ∈ ball (0 : ℂ) η → 1 < dist w 1 → tightModel w ≠ 0) ∧
        ∀ᵐ w, w ∈ ball (0 : ℂ) η → dist w 1 < 1 → tightModel w ≠ 1 :=
  ⟨isOpen_tightModelDom, isWeakColouringOn_tightModel, isTight_tightModel,
    tight_centre isOpen_tightModelDom isWeakColouringOn_tightModel (Or.inl (Or.inl (mem_ball_self (by norm_num))))
      isTight_tightModel⟩

end FS124L2

#print axioms FS124L2.model_triodCut
#print axioms FS124L2.model_triodCut_arc
#print axioms FS124L2.model_lone
#print axioms FS124L2.model_sector
#print axioms FS124L2.model_sector_full
#print axioms FS124L2.model_tight
