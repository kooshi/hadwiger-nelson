import Proofs.HadwigerNelson.Plane.ThreePiece

/-!
# A close complementary pair of three-piece points, at a common unit point (FS-124, second module)

Claims **C124-FORCED-PIECES**, **C124-LONE**, **C124-BOTH** and **C124-FOUR** of `data/fs124/claims-K2.md` (plan:
`plans/FS124-kernel-plan-2.md`). Nothing here rests on a declared outside theorem.

* `ClosePair U c x y` — a close complementary pair: decompositions at `x` and at `y`, `x ≠ y`, `dist x y < 2`, and no
  label of `x` a label of `y`. `IsCommonUnitPoint x y w` — `w` at distance `1` from both; at such a point the unit
  circles about `x` and `y` cross (`ClosePair.crossAt`), so they cut every disc about `w` into four regions of
  positive measure (`Plane/CircleCrossing`).
* `presentAt U c w` — the labels present at `w`: those whose class in `U` has `w` in its closed essential support
  (`essSupport`, `Plane/UnitPairs`).

**Where the number six is spent** — in one line, `ClosePair.exists_label_eq`: with six labels, every label is the
label of a piece of `x` or of a piece of `y`. Every theorem here is proved from that sentence as a hypothesis
(`hcover`) for `AeProperOn` at any label type — `exists_onSide_of_cover`, `ClosePair.separatesAt_or`,
`ClosePair.lone_of_cover`, `ClosePair.separatesAt_right_of_isFull`, `ClosePair.presentAt_eq` — and the claim list's
statements are the corollaries at `Fin 6`. With seven labels `hcover` fails, and `closePair_forced_pieces` is false
(`exists_closePair_seven_not_separatesAt`, `Plane/ClosePairModel`).

The mechanism, with no cover hypothesis (`ae_onSide_of_label`, the type of finitely many pieces at once): near `w`,
almost every point on the side `σ` of the unit circle about `x` that carries the label of a piece of `x` has that
piece on the closed side `σ` of the unit circle about `w`. With the cover: each of the four regions cut near `w` by
the unit circles about `x` and `y` has positive measure, so for each choice of sides `(σ, τ)` there is a piece of `x`
on the closed side `σ` of `S(w)` or a piece of `y` on the closed side `τ` of `S(w)` (`exists_onSide_of_cover`).
C124-FORCED-PIECES is that sentence at the two sides a non-separating pair would leave empty. When one side of
`S(y)` near `w` is filled by two labels of `x` — one inside `S(x)`, one outside — a second unit point `w' ≠ w` of
`x` is the far end of a tight pair, and the two pieces meet at `x` only
(`ThreePiece.exists_second_unit_point_of_ae_side`): this is C124-LONE's last clause, and it is what fullness
excludes in C124-BOTH and C124-FOUR.

**Inhabitants** (`Plane/ClosePairModel`): `exists_closePair_not_separatesAt` — a close complementary pair of a weak
six-colouring with a common unit point at which one member does not separate (the hypotheses of `closePair_forced_pieces` and
`closePair_lone` at once); `exists_closePair_full` — one with both members arc-edged, hence full, each with one inner, one
outer and one crossing piece (the hypotheses of `closePair_both_separate`, `closePair_both_saved` and `closePair_four` at once).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric Topology

variable {α : Type*} {k : ℕ}

/-! ## Labels present at a point -/

/-- **The labels present at `w`**: "a label is present at a point when the point lies in the closed essential support
of its class" — the class of `i` in `U` is `U ∩ c ⁻¹' {i}`. -/
def presentAt (U : Set ℂ) (c : ℂ → α) (w : ℂ) : Set α := {i | w ∈ essSupport (U ∩ c ⁻¹' {i})}

/-- Present: every disc about the point meets the class in positive measure. -/
theorem mem_presentAt_iff {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} :
    i ∈ presentAt U c w ↔ ∀ r > 0, 0 < volume (U ∩ c ⁻¹' {i} ∩ ball w r) := by
  sorry

/-- A label almost nowhere on a disc about `w` is not present at `w`. -/
theorem not_mem_presentAt_of_ae_ne {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} {η : ℝ} (hη : 0 < η)
    (h : ∀ᵐ z, z ∈ ball w η → c z ≠ i) : i ∉ presentAt U c w := by
  sorry

/-- Not present: the label is almost nowhere on `U` in some disc about the point. -/
theorem not_mem_presentAt_iff {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} :
    i ∉ presentAt U c w ↔ ∃ η > 0, ∀ᵐ z, z ∈ U → z ∈ ball w η → c z ≠ i := by
  sorry

/-- A label carried almost everywhere by a subset of `U` that has positive measure in every disc about `w` is present
at `w`. -/
theorem mem_presentAt_of_ae_eq {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} {V : Set ℂ} (hVU : V ⊆ U)
    (hi : ∀ᵐ z, z ∈ V → c z = i) (hpos : ∀ r > 0, 0 < volume (V ∩ ball w r)) : i ∈ presentAt U c w := by
  sorry

/-- At a point of an open set, some label is present (finitely many labels). -/
theorem presentAt_nonempty [Finite α] {U : Set ℂ} (hU : IsOpen U) (c : ℂ → α) {w : ℂ} (hw : w ∈ U) :
    (presentAt U c w).Nonempty := by
  sorry

/-! ## Close complementary pairs -/

/-- **A close complementary pair** (`data/fs124/claims-K2.md`): "two three-piece points x, y with 0 < |x − y| < 2
whose six labels are distinct", each with a decomposition. -/
structure ClosePair (U : Set ℂ) (c : ℂ → α) (x y : ℂ) where
  /-- The decomposition at `x`. -/
  left : ThreePiece U c x
  /-- The decomposition at `y`. -/
  right : ThreePiece U c y
  /-- `0 < |x − y|`. -/
  ne : x ≠ y
  /-- `|x − y| < 2`. -/
  dist_lt : dist x y < 2
  /-- No label of `x` is a label of `y` (with the injectivity of each: the six labels are distinct). -/
  label_ne : ∀ i j, left.label i ≠ right.label j

/-- `w` is a **common unit point** of `x` and `y`: `|w − x| = |w − y| = 1`. -/
def IsCommonUnitPoint (x y w : ℂ) : Prop := dist w x = 1 ∧ dist w y = 1

/-- A common unit point of `x` and `y` is one of `y` and `x`. -/
theorem IsCommonUnitPoint.symm {x y w : ℂ} (h : IsCommonUnitPoint x y w) : IsCommonUnitPoint y x w := by
  sorry

/-- "Its common unit points are the two points `w` with `|w − x| = |w − y| = 1`": for `0 < |x − y| < 2` there are
exactly two. -/
theorem exists_isCommonUnitPoint {x y : ℂ} (hne : x ≠ y) (hlt : dist x y < 2) :
    ∃ w₁ w₂ : ℂ, w₁ ≠ w₂ ∧ ∀ w, IsCommonUnitPoint x y w ↔ w = w₁ ∨ w = w₂ := by
  sorry

namespace ClosePair

variable {U : Set ℂ} {c : ℂ → α} {x y w : ℂ}

/-- The pair in the other order. -/
def symm (C : ClosePair U c x y) : ClosePair U c y x where
  left := C.right
  right := C.left
  ne := C.ne.symm
  dist_lt := by rw [dist_comm]; exact C.dist_lt
  label_ne i j := (C.label_ne j i).symm

/-- At a common unit point the unit circles about the two members cross. -/
theorem crossAt (C : ClosePair U c x y) (hw : IsCommonUnitPoint x y w) : CrossAt x y w := by
  sorry

/-- **Where six is spent**: with six labels, every label is the label of a piece of `x` or of a piece of `y` — six
distinct labels among six. -/
theorem exists_label_eq {c : ℂ → Fin 6} (C : ClosePair U c x y) (ℓ : Fin 6) :
    (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ := by
  sorry

end ClosePair

/-! ## The four regions at a common unit point -/

/-- **The type of finitely many pieces at once** (no cover hypothesis): let `P i` be finitely many pieces at `x` with
labels `a i`. Then near `w`, almost every point on a side `σ` of the unit circle about `x` that carries the label
`a i` has the piece `P i` on the closed side `σ` of the unit circle about `w`. (`IsPieceAt.ae_ne_region` for each
piece and each side, the least of finitely many radii.) -/
theorem ae_onSide_of_label {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x w : ℂ} (hw : w ∈ U)
    {ι : Type*} [Finite ι] {P : ι → Set ℂ} {a : ι → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → ∀ (σ : CircleSide) (i : ι), z ∈ σ.region x → c z = a i → OnSide σ (P i) w := by
  sorry

/-- **The quadrant lemma**: let `P i` be pieces at `x` with labels `a i` and `Q j` pieces at `y` with labels `b j`,
every label being one of them, and let the unit circles about `x` and `y` cross at `w ∈ U`. Then each of the four
regions needs a piece: for every choice of sides there is a piece of `x` on the closed side `σ` of the unit circle
about `w`, or a piece of `y` on the closed side `τ` of it. (The region on the side `σ` of `S(x)` and `τ` of `S(y)`
has positive measure in every disc about `w`, `CrossAt.volume_quadrant_pos`, and almost every point of it has some
label.) -/
theorem exists_onSide_of_cover {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x y w : ℂ}
    (hcross : CrossAt x y w) (hw : w ∈ U) {ι κ : Type*} [Finite ι] [Finite κ] {P : ι → Set ℂ} {a : ι → α}
    {Q : κ → Set ℂ} {b : κ → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) (hQ : ∀ j, IsPieceAt U c y (Q j) (b j))
    (hcover : ∀ ℓ : α, (∃ i, a i = ℓ) ∨ ∃ j, b j = ℓ) (σ τ : CircleSide) :
    (∃ i, OnSide σ (P i) w) ∨ ∃ j, OnSide τ (Q j) w := by
  sorry

/-- **One of the two points has an inner and an outer piece** (C124-FORCED-PIECES for any two finite families of
pieces whose labels are all the labels): otherwise one closed side of `S(w)` holds no piece of `x` and one holds no
piece of `y`, against the quadrant lemma at those two sides. -/
theorem exists_inner_outer_of_cover {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x y w : ℂ}
    (hcross : CrossAt x y w) (hw : w ∈ U) {ι κ : Type*} [Finite ι] [Finite κ] {P : ι → Set ℂ} {a : ι → α}
    {Q : κ → Set ℂ} {b : κ → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) (hQ : ∀ j, IsPieceAt U c y (Q j) (b j))
    (hcover : ∀ ℓ : α, (∃ i, a i = ℓ) ∨ ∃ j, b j = ℓ) :
    ((∃ i, InnerAt (P i) w) ∧ ∃ i, OuterAt (P i) w) ∨ ((∃ j, InnerAt (Q j) w) ∧ ∃ j, OuterAt (Q j) w) := by
  sorry

/-- **A side of `S(y)` with no piece of `y` belongs to `x`**: if no piece of `y` is on the closed side `τ` of the unit
circle about `w`, then near `w`, on the side `τ` of the unit circle about `y`, almost every point on a side `σ` of
the unit circle about `x` has the label of a piece of `x` that is on the closed side `σ` of the unit circle about
`w`. -/
theorem ae_label_left_of_forall_not_onSide {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x y w : ℂ} (hw : w ∈ U) {ι κ : Type*} [Finite ι] [Finite κ] {P : ι → Set ℂ} {a : ι → α} {Q : κ → Set ℂ}
    {b : κ → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) (hQ : ∀ j, IsPieceAt U c y (Q j) (b j))
    (hcover : ∀ ℓ : α, (∃ i, a i = ℓ) ∨ ∃ j, b j = ℓ) {τ : CircleSide} (hτ : ∀ j, ¬ OnSide τ (Q j) w) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → ∀ σ : CircleSide, z ∈ σ.region x →
      ∃ i, OnSide σ (P i) w ∧ c z = a i := by
  sorry

/-! ## One side of a circle filled by two labels: a second unit point -/

/-- **A tight pair on one side**: let the unit circles about `x` and `y` cross at `w ∈ U`. If near `w`, on the side
`τ` of the unit circle about `y`, almost every point has the label `a` inside the unit circle about `x` and `b`
outside it, then for a point `w' ≠ w` of the unit circle about `x`, as near `w` as wished, the pair `(x, w')` is
tight for `(a, b)`. No hypothesis on the colouring. -/
theorem exists_isTight_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) {x y w : ℂ} (hcross : CrossAt x y w)
    (hw : w ∈ U) {a b : α} (hab : a ≠ b) {τ : CircleSide} {η : ℝ} (hη : 0 < η)
    (hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = a)
    (hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = b) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ w' ∈ sphere x 1, w' ≠ w ∧ dist w' w < ρ ∧ IsTight U c x w' a b := by
  sorry

/-- **Two unit points confine two pieces to opposite lenses**: let `A`, `B` be pieces at `x ∈ U` with labels `a`,
`b`, `A` inner and `B` outer at `w`, and let `(x, w')` be tight for `(a, b)` with `w' ≠ w`. Then inside a disc about
`x`, `A` lies in both closed unit discs, `B` is disjoint from both open unit discs, and their closures meet at `x`
only. (C124-CENTRE at the centre `x` with the far end `w'`; two different unit circles through `x` meet near `x` at
`x` only.) -/
theorem IsTight.closure_inter_closure_eq {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x w w' : ℂ} (hx : x ∈ U) (hwx : dist w x = 1) (hne : w' ≠ w) {A B : Set ℂ} {a b : α}
    (hA : IsPieceAt U c x A a) (hB : IsPieceAt U c x B b) (hAi : InnerAt A w) (hBo : OuterAt B w)
    (ht : IsTight U c x w' a b) :
    ∃ η' > 0, A ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
      Disjoint (B ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧ closure A ∩ closure B ∩ ball x η' = {x} := by
  sorry

/-- **The second unit point** (the last clause of C124-LONE, for two pieces of one decomposition): let the unit
circles about `x` and `y` cross at `w ∈ U`, and let the piece `i` of `D` be inner and the piece `j` outer at `w`. If
near `w`, on a side `τ` of the unit circle about `y`, almost every point has the label of `i` inside the unit circle
about `x` and the label of `j` outside it, there are a point `w' ≠ w` of the unit circle about `x` and `η' > 0` such
that inside `ball x η'` the piece `i` lies in both closed unit discs, the piece `j` is disjoint from both open unit
discs, and their closures meet at `x` only. -/
theorem ThreePiece.exists_second_unit_point_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U)
    (hc : AeProperOn U c) {x y w : ℂ} (D : ThreePiece U c x) (hcross : CrossAt x y w) (hw : w ∈ U) {i j : Fin 3}
    (hi : InnerAt (D.piece i) w) (hj : OuterAt (D.piece j) w) {τ : CircleSide} {η : ℝ} (hη : 0 < η)
    (hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = D.label i)
    (hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = D.label j) :
    ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
      D.piece i ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
        Disjoint (D.piece j ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
        closure (D.piece i) ∩ closure (D.piece j) ∩ ball x η' = {x} := by
  sorry

/-- **A filled side defeats fullness**: under the hypotheses of `ThreePiece.exists_second_unit_point_of_ae_side` the
edge of the pieces `i` and `j` is the point `x` near `x`, so the decomposition is not full. -/
theorem ThreePiece.not_isFull_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x y w : ℂ} (D : ThreePiece U c x) (hcross : CrossAt x y w) (hw : w ∈ U) {i j : Fin 3}
    (hi : InnerAt (D.piece i) w) (hj : OuterAt (D.piece j) w) {τ : CircleSide} {η : ℝ} (hη : 0 < η)
    (hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = D.label i)
    (hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = D.label j) : ¬ D.IsFull := by
  sorry

/-- **One label cannot fill a side that the cover gives to it alone**: let `D` be a decomposition at `x`, the unit
circles about `x` and `y` crossing at `w ∈ U`. If near `w`, on a side `τ` of `S(y)`, almost every point on the side
`σ.flip` of `S(x)` has the label of the piece `j`, then some other piece is not on the closed side `σ` of `S(w)`.
(Otherwise the cover gives the side `σ.flip` of `S(w)` near `x` to the label of `j`,
`ThreePiece.ae_label_of_forall_onSide`; for a point `w' ≠ w` of `S(x)` near `w` on that side of `S(y)`,
`AeProperOn.ae_ne_of_ae_region` at the centre `x` with the far end `w'` takes that label off the side `σ` of `S(w')`
near `x`; and the circles `S(w)`, `S(w')` cross at `x`, so the region on the side `σ.flip` of the first and `σ` of
the second has positive measure there.) -/
theorem ThreePiece.exists_ne_not_onSide_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x y w : ℂ} (D : ThreePiece U c x) (hcross : CrossAt x y w) (hw : w ∈ U) {j : Fin 3} {σ τ : CircleSide} {η : ℝ}
    (hη : 0 < η) (hfill : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → z ∈ σ.flip.region x → c z = D.label j) :
    ∃ i, i ≠ j ∧ ¬ OnSide σ (D.piece i) w := by
  sorry

/-! ## The four statements at any label type, from the cover hypothesis -/

namespace ClosePair

variable {U : Set ℂ} {c : ℂ → α} {x y w : ℂ}

/-- C124-FORCED-PIECES from the cover hypothesis: one member separates. -/
theorem separatesAt_or (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) :
    C.left.SeparatesAt w ∨ C.right.SeparatesAt w := by
  sorry

/-- C124-LONE from the cover hypothesis. -/
theorem lone_of_cover (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hy : ¬ C.right.SeparatesAt w) :
    ∃ σ : Equiv.Perm (Fin 3), C.left.OneOfEach w σ ∧
      (∃ τ : CircleSide, ∃ η > 0,
        (∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)) ∧
          ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = C.left.label (σ 1)) ∧
      ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
        C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
          Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
          closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x} := by
  sorry

/-- **A full member makes the other member separate** (the finer form of C124-BOTH's first clause): if `y` does not
separate at `w`, the inner and the outer piece of `x` meet at `x` only (`lone_of_cover`), so `x` is not full. -/
theorem separatesAt_right_of_isFull (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hfx : C.left.IsFull) :
    C.right.SeparatesAt w := by
  sorry

/-- **A full member keeps the other member's inner and outer labels present**: let each member have one inner, one
outer and one crossing piece at `w`, and let `y` be full. Then the labels of the inner and of the outer piece of `x`
are present at `w`. (If one of them were absent near `w`, its side of `S(x)` would be filled by the inner label of
`y` inside `S(y)` and the outer label of `y` outside it: `ThreePiece.not_isFull_of_ae_side` at `y`.) -/
theorem label_mem_presentAt_of_isFull_right (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y)
    (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hfy : C.right.IsFull)
    {σ τ : Equiv.Perm (Fin 3)} (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    C.left.label (σ 0) ∈ presentAt U c w ∧ C.left.label (σ 1) ∈ presentAt U c w := by
  sorry

/-- C124-FOUR from the cover hypothesis: the crossing labels are almost nowhere near `w`
(`IsPieceAt.ae_ne_of_crossingAt`), every other label is one of the four, and each of the four is present
(`label_mem_presentAt_of_isFull_right`, for the pair and for the pair in the other order). -/
theorem presentAt_eq (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hfx : C.left.IsFull)
    (hfy : C.right.IsFull) {σ τ : Equiv.Perm (Fin 3)} (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} := by
  sorry

/-- The two inner and the two outer labels are four different labels. -/
theorem ncard_inner_outer (C : ClosePair U c x y) (σ τ : Equiv.Perm (Fin 3)) :
    ({C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} : Set α).ncard = 4 := by
  sorry

end ClosePair

/-! ## The claims, at six colours -/

/-- **C124-FORCED-PIECES** (`data/fs124/claims-K2.md`): "Let c be a weak six-colouring of U, (x, y) a close
complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in
U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from
the open unit disc about w; the edge of those two pieces lies on S(w)."

Clause by clause: `hU`, `hc`; `C` (the pair with its two decompositions); `hw`, `hwu`; the disjunction is
"x or y separates" with its two pieces `i` (inner) and `j` (outer) named, and their edge on the unit circle. **The
number six is spent in `ClosePair.exists_label_eq`**, and nowhere else: `ClosePair.separatesAt_or` is the statement at
any label type whose labels are all carried by the six pieces. The cover clause of the two decompositions
(`null_diff`) is not read. Inhabitant of the hypotheses: `exists_closePair_not_separatesAt`
(`Plane/ClosePairModel`). -/
theorem closePair_forced_pieces {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) :
    (∃ i j, InnerAt (C.left.piece i) w ∧ OuterAt (C.left.piece j) w ∧ C.left.edge i j ⊆ sphere w 1) ∨
      ∃ i j, InnerAt (C.right.piece i) w ∧ OuterAt (C.right.piece j) w ∧ C.right.edge i j ⊆ sphere w 1 := by
  sorry

/-- **C124-LONE** (`data/fs124/claims-K2.md`): "In the setting of C124-FORCED-PIECES suppose y does not separate at
w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner
and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the
label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and
η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from
B(w, 1) ∪ B(w′, 1), and their closures meet at x only."

Clause by clause: `σ` names the inner piece `σ 0`, the outer piece `σ 1` and the crossing piece `σ 2`
(`ThreePiece.OneOfEach`: one of each, since `σ` is a bijection and the three kinds exclude one another); `a`, `b` are
`C.left.label (σ 0)`, `C.left.label (σ 1)`; `τ` is the side of `S(y)`; `w'`, `η'` and the three conclusions inside
`ball x η'`. The number six is spent in `ClosePair.exists_label_eq` only (`ClosePair.lone_of_cover`). Inhabitant of
the hypotheses: `exists_closePair_not_separatesAt` (`Plane/ClosePairModel`). -/
theorem closePair_lone {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w)
    (hy : ¬ C.right.SeparatesAt w) :
    ∃ σ : Equiv.Perm (Fin 3), C.left.OneOfEach w σ ∧
      (∃ τ : CircleSide, ∃ η > 0,
        (∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)) ∧
          ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = C.left.label (σ 1)) ∧
      ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
        C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
          Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
          closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x} := by
  sorry

/-- **C124-BOTH**, first clause (`data/fs124/claims-K2.md`): "In the setting of C124-FORCED-PIECES, if x and y are
full, both separate at w."

Each member's fullness makes the **other** member separate (`ClosePair.separatesAt_right_of_isFull`). Inhabitant of
the hypotheses: `exists_closePair_full` (`Plane/ClosePairModel`). -/
theorem closePair_both_separate {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) (hfx : C.left.IsFull)
    (hfy : C.right.IsFull) : C.left.SeparatesAt w ∧ C.right.SeparatesAt w := by
  sorry

/-- **C124-BOTH**, second clause (`data/fs124/claims-K2.md`): "If they are sector points, each has an edge that
contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector
points is saved by one member alone."

**Stated for what the clause reads of a sector point**: a decomposition with arc edges (`ThreePiece.HasArcEdges` —
every edge contains an arc from the point). `D.Saves w`: some edge contains an arc of the unit circle about `w` with
an end at the point. An arc-edged member is full, so both separate (`closePair_both_separate`); the edge of the inner and the
outer piece lies on `S(w)` and contains an arc from the point, and an arc on a circle from a point contains an arc of
the circle from it (`ThreePiece.hasUnitArcFrom_of_arc_subset_sphere`). The clause in the claim list's own words, for
its sector points, is `closePair_both_saved_of_isSector` (`Plane/SectorPoint`), over one fact of plane topology that is a leaf
there. Inhabitant of the hypotheses: `exists_closePair_full` (`Plane/ClosePairModel`), whose members' edges are arcs
of unit circles by construction. -/
theorem closePair_both_saved {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) (hax : C.left.HasArcEdges)
    (hay : C.right.HasArcEdges) : C.left.Saves w ∧ C.right.Saves w := by
  sorry

/-- **C124-FOUR** (`data/fs124/claims-K2.md`): "In the setting of C124-FORCED-PIECES let x and y be full, each with
exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w:
those of the two inner and the two outer pieces."

The labels present at `w` are the set of the four named labels, and that set has four elements. The number six is
spent in `ClosePair.exists_label_eq` only (`ClosePair.presentAt_eq`). Inhabitant of the hypotheses:
`exists_closePair_full` (`Plane/ClosePairModel`). -/
theorem closePair_four {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) (hfx : C.left.IsFull)
    (hfy : C.right.IsFull) {σ τ : Equiv.Perm (Fin 3)} (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} ∧
      (presentAt U c w).ncard = 4 := by
  sorry

/-! ## Spec examples -/

/-- **Adversary** for the definition of a close pair: no point is a close pair with itself. -/
example (U : Set ℂ) (c : ℂ → α) (x : ℂ) : IsEmpty (ClosePair U c x x) :=
  ⟨fun C => C.ne rfl⟩

/-- The common unit points of `0` and `1 − i` are `1` and `−i`. -/
example : IsCommonUnitPoint (0 : ℂ) (1 - I) 1 ∧ IsCommonUnitPoint (0 : ℂ) (1 - I) (-I) := by
  sorry

/-- **Adversary**: `2` is not a common unit point of `0` and `1 − i`. -/
example : ¬ IsCommonUnitPoint (0 : ℂ) (1 - I) 2 := by
  sorry

/-- `presentAt` on a constant colouring: the one label is present at every point of an open set, and no other. -/
example {U : Set ℂ} (hU : IsOpen U) {w : ℂ} (hw : w ∈ U) : presentAt U (fun _ => (0 : Fin 2)) w = {0} := by
  sorry

end HadwigerNelson.Plane
