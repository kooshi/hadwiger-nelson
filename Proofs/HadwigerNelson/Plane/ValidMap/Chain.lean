import Proofs.HadwigerNelson.Plane.ValidMap.Basic

/-!
# Wave 5's foundation: stuck runs along a normal line, `F(M)` and `R(M)`, modifications, terminal maps, `Row134BaseUA`

Over wave 4's `Plane/ValidMap/Basic` (`plans/FS131-w5-kernel-plan.md` § 2). The vocabulary of FS-112's close and FS-114's
composition (`plans/FS112-derivation.md`'s header; `data/fs114/claims.md` § 0), point-set over `ArcMap`:

* **A stuck vertex along `e α`** (`StuckAlong v α`): stuck, with a colour of two or more sectors having a horn along `e α` — the
  axis whose normal `n = e (α + π/2)` carries the vertex's chain (FS-110's N4 frame).
* **A chain vertex** (`IsChainVertex v`): stuck, with at most three colours — "stuck" as FS112-N2-TERM's trichotomy uses it (every
  vertex of `M*` is cubic, an NB4P exception with at least four colours, or stuck), and N4-STUCK's hypothesis at the vertex.
* **The stuck run** (`stuckRun v α`): the indices `j ∈ ℤ` such that every `v + i n` with `i` between `0` and `j` is a chain vertex —
  the stuck chain through `v` along its normal line, as a set of consecutive integers. It is empty when `v` is not stuck,
  `univ` for a bi-infinite chain; `j` is an upper end when `j ∈ run` and `j + 1 ∉ run`, and "the point one step beyond" it is
  `v + (j + 1) n`. A neighbour that is a chain vertex along another axis continues the run: an end is where being a chain vertex
  fails (FS112-C-ENDS reads the end so).
* **`F(M)`, `R(M)`** (`fourSet`, `repSet`): the points of the domain carrying at least four colours, a repeated colour.
* **(Q)/(R2) only** (`QROnly`): every arc of `Γ` on a unit circle with constant sides is (Q) or (R2) — FS112-N2-RED's
  conclusion, FS112-N2-TERM's clause 1. **A terminal valid map** (`IsTerminalMap`): valid, of the plane, `Terminal` (no
  MERGE, MERGE-RAY or SHAVE anywhere) and `QROnly` — the class every `M*` is in, and the reading of "a terminal valid map" in
  FS112-C-DOUBLE, -C-ENDS and FS114-CV-HD.
* **A modification** (`IsModification M F`): the same domain, no unit arc created (`RingArcsWithin`), and every point of at
  least four colours in `M` carrying those colours in `F` — what the consumers of `M*` read of "a valid modification by the
  moves" (FS114-CV-EXISTS: "a modification creating no unit arc keeps a four-colour vertex's colours at the vertex in the map
  itself"). Reflexive and transitive.
* **The base's hypothesis** (`BaseHyp u`): the closed disc of radius `2` about `u` holds no point of `F(M) ∪ R(M)`; and
  **no inert unit arc centred within `1`** (`NoInertNear u`), the state after FS112-N3-BASE's pre-bend.
* **`Row134BaseUA`**: wave 5's intermediate `Prop` (inventory item 197) — row 134's base at a cubic trichromatic vertex, read on a valid
  six-coloured fragment covering `B̄(u, 2)`, unit arcs allowed, after the inert pre-bend: `BaseHyp u` is impossible. It is **proved in
  wave 5** (`row134BaseUA`, `Plane/ValidMap/Dense`: FS112-N3-BASE's walk), over the pieces of `[SokolovVoronov2025]` the walk uses by
  statement, which are the only named outside hypotheses.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## Stuck vertices along an axis, and the stuck run -/

/-- **`v` is stuck along `e α`**: `v` is stuck, and a colour with two or more sectors at `v` has a horn along `e α` (its chain runs
along the normal `n = e (α + π/2)`). -/
def StuckAlong (v : ℂ) (α : ℝ) : Prop :=
  F.IsStuck v ∧ ∃ c n κ₁ κ₂, 2 ≤ n ∧ F.HasSectors v c n ∧ F.IsHorn v α κ₁ κ₂ c

/-- **A chain vertex**: stuck, with at most three colours (the "stuck" of FS112-N2-TERM's trichotomy). -/
def IsChainVertex (v : ℂ) : Prop := F.IsStuck v ∧ (F.coloursAt v).ncard ≤ 3

/-- **The stuck run** through `v` along the normal line of `e α`: the `j ∈ ℤ` such that `v + i n` is a chain vertex for every `i`
between `0` and `j` (`n = e (α + π/2)`). -/
def stuckRun (v : ℂ) (α : ℝ) : Set ℤ :=
  {j | ∀ i : ℤ, min 0 j ≤ i → i ≤ max 0 j → F.IsChainVertex (v + (i : ℂ) * e (α + π / 2))}

/-- `F(M)`: the points of the domain carrying at least four colours. -/
def fourSet : Set ℂ := {x | x ∈ F.dom ∧ 4 ≤ (F.coloursAt x).ncard}

/-- `R(M)`: the points of the domain carrying a repeated colour. -/
def repSet : Set ℂ := {x | x ∈ F.dom ∧ F.HasRepeatedColour x}

/-! ## (Q)/(R2) only, terminal maps, modifications -/

/-- **Every unit arc is (Q) or (R2)**: every arc of `Γ` on a unit circle with constant sides is a (Q) arc or an (R2) arc
(FS112-N2-RED's conclusion; FS112-N2-TERM's clause 1). -/
def QROnly : Prop :=
  ∀ P θ₁ θ₂ c c', F.IsRingArc P θ₁ θ₂ c c' → F.IsQArc P θ₁ θ₂ ∨ F.IsR2Arc P θ₁ θ₂

/-- **A terminal valid map** (the class of FS112-N2-TERM's `M*`): valid, of the plane, no MERGE, MERGE-RAY or SHAVE available at any
point, and every unit arc (Q) or (R2). -/
def IsTerminalMap : Prop := F.Valid ∧ F.IsPlaneMap ∧ F.Terminal ∧ F.QROnly

/-- **`M` is a modification of `F`**: the same domain, no unit arc created, and every point carrying at least four colours in `M`
carries those colours in `F`. -/
structure IsModification (M : ArcMap k) : Prop where
  /-- The same domain. -/
  dom_eq : M.dom = F.dom
  /-- No unit arc created. -/
  ringArcsWithin : M.RingArcsWithin F
  /-- A point of at least four colours in `M` carries them in `F`. -/
  coloursAt_subset : ∀ x, 4 ≤ (M.coloursAt x).ncard → M.coloursAt x ⊆ F.coloursAt x

/-! ## The base's hypothesis, and `Row134BaseUA` -/

/-- **The base's hypothesis at `u`** (FS112-N3-BASE): the closed disc of radius `2` about `u` holds no vertex of at least four
colours and none with a repeated colour. -/
def BaseHyp (u : ℂ) : Prop := Disjoint (closedBall u 2) (F.fourSet ∪ F.repSet)

/-- **No inert unit arc centred within `1` of `u`** (the state after FS112-N3-BASE's pre-bend: "inert unit arcs centred within 1 of `u`
first bent toward their centres"). -/
def NoInertNear (u : ℂ) : Prop := ∀ P ∈ closedBall u 1, ∀ θ₁ θ₂, ¬ F.Inert P θ₁ θ₂

end ArcMap

/-- **`Row134BaseUA`** — wave 5's intermediate statement of row 134's base with unit arcs (inventory items 196–197; not an outside
hypothesis): **in a valid six-coloured fragment covering `B̄(u, 2)`, a cubic trichromatic vertex `u` with no point of `F(M) ∪ R(M)` in
`B̄(u, 2)` and no inert unit arc centred within `1` of `u` does not exist.** Proved in wave 5 as `row134BaseUA` (`Plane/ValidMap/Dense`):
FS112-N3-BASE's walk — `[SokolovVoronov2025]` Cor. 1's argument as FS-110 repaired it (FS110-CB, -CD, -CE, CUSP-BASE) with each use of
Condition 5 replaced by the walked steps (FS112-N3-PAIRS, -N3-FAIL, -N3-ANTI, -N3-NOBOTH, -N3-COR3, -ROTHEX, FS114-BV-HEX); the pieces of
the paper the walk uses by statement enter that theorem as named outside `Prop`s. It spends six colours: its seven-colour form is false
(`not_row134BaseUA_seven`). -/
def Row134BaseUA : Prop :=
  ∀ (F : ArcMap 6) (u : ℂ), F.Valid → F.Covers u 2 → F.IsCubicTrichromatic u → F.BaseHyp u → F.NoInertNear u → False

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The run's shape -/

/-- `0` lies in the run exactly when `v` is a chain vertex. -/
theorem zero_mem_stuckRun_iff {v : ℂ} {α : ℝ} : 0 ∈ F.stuckRun v α ↔ F.IsChainVertex v := by
  constructor
  · intro h
    simpa using h 0 (by simp) (by simp)
  · intro h i hi1 hi2
    have : i = 0 := by simp at hi1 hi2; omega
    subst this
    simpa using h

/-- The run is order-convex and contains `0` when nonempty: an index between `0` and a member is a member. -/
theorem mem_stuckRun_of_between {v : ℂ} {α : ℝ} {j i : ℤ} (hj : j ∈ F.stuckRun v α) (h1 : min 0 j ≤ i)
    (h2 : i ≤ max 0 j) : i ∈ F.stuckRun v α := by
  intro i' h1' h2'
  apply hj i'
  · have : min 0 j ≤ min 0 i := le_min (min_le_left _ _) h1
    exact this.trans h1'
  · have : max 0 i ≤ max 0 j := max_le (le_max_left _ _) h2
    exact h2'.trans this

/-- Every member of the run is a chain vertex of the normal line. -/
theorem isChainVertex_of_mem_stuckRun {v : ℂ} {α : ℝ} {j : ℤ} (hj : j ∈ F.stuckRun v α) :
    F.IsChainVertex (v + (j : ℂ) * e (α + π / 2)) :=
  hj j (min_le_right _ _) (le_max_right _ _)

/-- Reversing the axis reverses the run: `j ∈ run(α + π) ↔ −j ∈ run(α)` (the normal `n` changes sign). -/
theorem mem_stuckRun_add_pi {v : ℂ} {α : ℝ} {j : ℤ} : j ∈ F.stuckRun v (α + π) ↔ -j ∈ F.stuckRun v α := by
  have hn : e (α + π + π / 2) = -e (α + π / 2) := by
    rw [show α + π + π / 2 = (α + π / 2) + π by ring, e_add_pi]
  have key : ∀ i : ℤ, v + (i : ℂ) * e (α + π + π / 2) = v + ((-i : ℤ) : ℂ) * e (α + π / 2) := by
    intro i; rw [hn]; push_cast; ring
  constructor
  · intro h i h1 h2
    have := h (-i) (by simp only [min_def, max_def] at h1 h2 ⊢; split_ifs at h1 h2 ⊢ <;> omega)
      (by simp only [min_def, max_def] at h1 h2 ⊢; split_ifs at h1 h2 ⊢ <;> omega)
    rwa [key, neg_neg] at this
  · intro h i h1 h2
    rw [key]
    exact h (-i) (by simp only [min_def, max_def] at h1 h2 ⊢; split_ifs at h1 h2 ⊢ <;> omega)
      (by simp only [min_def, max_def] at h1 h2 ⊢; split_ifs at h1 h2 ⊢ <;> omega)

/-! ## Modifications: reflexive and transitive -/

/-- Every map is a modification of itself (the inhabitant of `IsModification`, every clause exercised). -/
theorem IsModification.refl (F : ArcMap k) : F.IsModification F :=
  ⟨rfl, fun _ _ h => h, fun _ _ => le_rfl⟩

/-- Modifications compose. -/
theorem IsModification.trans {M M' : ArcMap k} (h₁ : F.IsModification M) (h₂ : M.IsModification M') :
    F.IsModification M' where
  dom_eq := h₂.dom_eq.trans h₁.dom_eq
  ringArcsWithin := fun p x hx => h₁.ringArcsWithin p x (h₂.ringArcsWithin p x hx)
  coloursAt_subset := fun x hx => by
    have h2 := h₂.coloursAt_subset x hx
    have hM : 4 ≤ (M.coloursAt x).ncard := hx.trans (Set.ncard_le_ncard h2 (Set.toFinite _))
    exact h2.trans (h₁.coloursAt_subset x hM)

end ArcMap

/-! ### Spec examples -/

section Spec

open ArcMap

/-- On the one-colour map of the plane every point carries at most the one colour. -/
theorem const_coloursAt_subset (j : Fin 2) (x : ℂ) : (ArcMap.const univ isOpen_univ j).coloursAt x ⊆ {j} := by
  intro j' hj'
  by_contra hne
  have hempty : (ArcMap.const univ isOpen_univ j).region j' = ∅ := by
    ext z
    simp only [ArcMap.region, mem_inter_iff, mem_preimage, mem_singleton_iff, mem_empty_iff_false, iff_false, not_and]
    intro _ hz
    exact hne (hz ▸ rfl)
  have : x ∈ closure (∅ : Set ℂ) := by
    have h := hj'
    simp only [ArcMap.coloursAt, mem_setOf_eq] at h
    rwa [hempty] at h
  simp at this

/-- `F(M)` of the one-colour plane is empty (a spec example for `fourSet`). -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).fourSet = ∅ := by
  ext x
  simp only [ArcMap.fourSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and, not_le]
  intro _
  have := Set.ncard_le_ncard (const_coloursAt_subset j x) (Set.toFinite _)
  rw [Set.ncard_singleton] at this
  omega

/-- `R(M)` is the domain's repeated-colour points (a spec example for `repSet`). -/
example {k : ℕ} (F : ArcMap k) (x : ℂ) : x ∈ F.repSet ↔ x ∈ F.dom ∧ F.HasRepeatedColour x := Iff.rfl

/-- The one-colour plane has no arc of `Γ` on any unit circle, so it is (Q)/(R2) only (an inhabitant of `QROnly`; a spec example). -/
theorem const_qrOnly (j : Fin 2) : (ArcMap.const univ isOpen_univ j).QROnly := by
  intro P θ₁ θ₂ c c' h
  exfalso
  obtain ⟨h12, hsub, -⟩ := h
  have hmem : ringPt P θ₁ ∈ ringArc P θ₁ θ₂ := ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
  have := hsub hmem
  simp [ArcMap.Γ, ArcMap.const] at this

/-- The base's hypothesis unfolds to the disjointness of `B̄(u, 2)` from `F(M) ∪ R(M)` (a spec example for `BaseHyp`). -/
example {k : ℕ} (F : ArcMap k) (u : ℂ) : F.BaseHyp u ↔ ∀ x ∈ closedBall u 2, x ∉ F.fourSet ∧ x ∉ F.repSet := by
  simp only [ArcMap.BaseHyp, Set.disjoint_left, mem_union, not_or]

/-- The one-colour plane has no inert arc anywhere (a spec example for `NoInertNear`). -/
example (j : Fin 2) (u : ℂ) : (ArcMap.const univ isOpen_univ j).NoInertNear u := by
  rintro P - θ₁ θ₂ ⟨c, c', ⟨h12, hsub, -⟩, -, -⟩
  have hmem : ringPt P θ₁ ∈ ringArc P θ₁ θ₂ := ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩
  have := hsub hmem
  simp [ArcMap.Γ, ArcMap.const] at this

/-- A point that is not a chain vertex has an empty run (a spec example for `stuckRun`). -/
example {k : ℕ} (F : ArcMap k) (v : ℂ) (α : ℝ) (h : ¬ F.IsChainVertex v) : F.stuckRun v α = ∅ := by
  ext j
  simp only [mem_empty_iff_false, iff_false]
  intro hj
  exact h (zero_mem_stuckRun_iff.mp (mem_stuckRun_of_between hj (min_le_left _ _) (le_max_left _ _)))

end Spec

end HadwigerNelson.Plane
