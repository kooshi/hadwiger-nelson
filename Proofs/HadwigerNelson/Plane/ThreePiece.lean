import Proofs.HadwigerNelson.Plane.OnePiece
import Mathlib.Topology.UnitInterval

/-!
# Three-piece points: decompositions, edges, separation, fullness, sector points (FS-124, second module)

The definitions of `data/fs124/claims-K2.md` ("Definitions, stated once") that C124-FORCED-PIECES, -LONE, -BOTH and
-FOUR are stated over (`Plane/ClosePair`; plan: `plans/FS124-kernel-plan-2.md`).

* `ThreePiece U c x` — **a decomposition at a three-piece point `x`** of a colouring `c` of `U`: a neighbourhood `N`
  of `x` inside `U` and three open preconnected sets `P 0`, `P 1`, `P 2 ⊆ N`, each with `x` in its closure and one
  label almost everywhere, the three labels distinct, with `N ∖ (P 0 ∪ P 1 ∪ P 2)` null. A **three-piece point** is a
  point with a decomposition (`IsThreePiecePoint`). Each piece is a piece at `x` in the sense of `Plane/OnePiece`
  (`ThreePiece.isPieceAt`), so the pieces are non-empty, connected and pairwise disjoint (`disjoint_piece`).
  That `c` is a weak colouring of `U` is a hypothesis of the theorems, not a field: the definition reads `c` through
  the three labels only.
* `D.edge i j = cl (P i) ∩ cl (P j) ∩ N` — the edges; `D.SeparatesAt w` — an inner and an outer piece at `w`;
  `D.OneOfEach w σ` — exactly one inner, one outer and one crossing piece, named by a permutation `σ` of the pieces;
  `D.IsFull` — `x` is a limit of points other than `x` of every edge; `D.Saves w` — some edge contains an arc of the
  unit circle about `w` with an end at `x` (`HasUnitArcFrom`); `D.HasArcEdges` — every edge contains an arc from `x`
  (an injective continuous image of `[0, 1]` starting at `x`). An arc-edged decomposition is full
  (`ThreePiece.HasArcEdges.isFull`). The claim list's **sector point** — the pieces are the three components of a
  disc about `x` cut along three arcs from `x` to its rim — is `ThreePiece.IsSector` in `Plane/SectorPoint`; that a
  sector point has arc edges is the θ-curve fact of plane topology, one leaf of that module, and nothing here or in
  `Plane/ClosePair` reads it.

**The two kinds of model** (the claim list distinguishes them, and C124-LONE and C124-BOTH turn on it):
* **an ordinary three-sector point** — `sectorPoint`: at `0`, the three sectors cut by the rays along `1`, `i` and
  `−1 − i`, in the disc of radius `1/4`. Each edge is a radius: it has arc edges by construction
  (`sectorPoint_hasArcEdges`), hence it is full.
* **a three-piece point by the letter only** — `petalPoint`: at `0`, two triangular petals `|Im z| < ± Re z < 1/8` and
  the rest of the disc of radius `1/4`, which is connected around their far sides. The closures of the two petals meet
  at `0` only: it is **not full** (`petalPoint_not_isFull`). This is the claim list's bowtie whose two sectors of one
  label are joined inside the neighbourhood.
Both are colourings of a disc of radius `1/4`, which holds no unit pair, so each is a weak colouring of it.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric Topology

variable {α : Type*} {k : ℕ}

/-! ## The decomposition -/

/-- **A decomposition at a three-piece point `x`** of a colouring `c` of `U` (`data/fs124/claims-K2.md`): "a point x
of U with a neighbourhood that is, up to a null set, the union of three connected open sets, each with x in its
closure and one label almost everywhere, the three labels distinct"; "a decomposition at a three-piece point x is a
choice of the neighbourhood N and the three disjoint connected open sets P_0, P_1, P_2 of the definition". -/
structure ThreePiece (U : Set ℂ) (c : ℂ → α) (x : ℂ) where
  /-- The neighbourhood `N`: any neighbourhood of `x` inside `U` that is the union of the pieces up to a null set
  (it need not be open). -/
  nbhd : Set ℂ
  /-- The three pieces. -/
  piece : Fin 3 → Set ℂ
  /-- Their labels. -/
  label : Fin 3 → α
  /-- `N` is a neighbourhood of `x`. -/
  nbhd_mem : nbhd ∈ 𝓝 x
  /-- `N` lies in `U`. -/
  nbhd_subset : nbhd ⊆ U
  /-- The pieces lie in `N`. -/
  piece_subset : ∀ i, piece i ⊆ nbhd
  /-- The pieces are open. -/
  isOpen_piece : ∀ i, IsOpen (piece i)
  /-- The pieces are preconnected (and non-empty, by the next field: connected). -/
  isPreconnected_piece : ∀ i, IsPreconnected (piece i)
  /-- `x` is in the closure of each piece. -/
  mem_closure_piece : ∀ i, x ∈ closure (piece i)
  /-- Each piece has one label almost everywhere. -/
  ae_label : ∀ i, ∀ᵐ z, z ∈ piece i → c z = label i
  /-- The three labels are distinct. -/
  label_injective : Function.Injective label
  /-- `N` is the union of the pieces up to a null set. -/
  null_diff : volume (nbhd \ ⋃ i, piece i) = 0

/-- `x` is a **three-piece point** of the colouring `c` of `U`: it has a decomposition. -/
def IsThreePiecePoint (U : Set ℂ) (c : ℂ → α) (x : ℂ) : Prop := Nonempty (ThreePiece U c x)

/-- `E` **contains an arc of the unit circle about `w` with an end at `x`**: for a turning sense `s = ±1` and some
`δ > 0`, the points `w + (x − w) e(s t)`, `0 ≤ t ≤ δ`, are in `E`. (For `x` on the unit circle about `w` these are the
points of that circle from `x`, turning by up to `δ`.) -/
def HasUnitArcFrom (E : Set ℂ) (w x : ℂ) : Prop :=
  ∃ s : ℝ, (s = 1 ∨ s = -1) ∧ ∃ δ > 0, ∀ t ∈ Icc (0 : ℝ) δ, w + (x - w) * e (s * t) ∈ E

/-- An arc of the unit circle from `x` contains `x`. -/
theorem HasUnitArcFrom.mem {E : Set ℂ} {w x : ℂ} (h : HasUnitArcFrom E w x) : x ∈ E := by
  obtain ⟨s, -, δ, hδ, h⟩ := h
  have h0 := h 0 ⟨le_rfl, hδ.le⟩
  simpa [e] using h0

/-- A point `x` with an arc of a circle from it inside `E` is a limit of points of `E` other than `x`, when `x` is
not the centre. -/
theorem HasUnitArcFrom.mem_closure_diff {E : Set ℂ} {w x : ℂ} (h : HasUnitArcFrom E w x) (hne : x ≠ w) :
    x ∈ closure (E \ {x}) := by
  obtain ⟨s, hs, δ, hδ, h⟩ := h
  rw [Metric.mem_closure_iff]
  intro ε hε
  -- the arc is continuous in the angle and starts at `x`
  have hcont : Continuous fun t : ℝ => w + (x - w) * e (s * t) :=
    continuous_const.add (continuous_const.mul (continuous_e.comp (continuous_const.mul continuous_id)))
  have hstart : w + (x - w) * e (s * 0) = x := by simp [e]
  obtain ⟨δ', hδ', hclose⟩ := Metric.continuous_iff.mp hcont 0 ε hε
  have ht0 : 0 < min δ (min (δ' / 2) 1) := lt_min hδ (lt_min (by positivity) one_pos)
  have ht1 : min δ (min (δ' / 2) 1) ≤ 1 := (min_le_right _ _).trans (min_le_right _ _)
  have ht2 : min δ (min (δ' / 2) 1) ≤ δ' / 2 := (min_le_right _ _).trans (min_le_left _ _)
  set t := min δ (min (δ' / 2) 1) with htdef
  refine ⟨w + (x - w) * e (s * t), ⟨h t ⟨ht0.le, min_le_left _ _⟩, ?_⟩, ?_⟩
  · -- the point of the arc at a small positive angle is not `x`
    intro heq
    rw [mem_singleton_iff] at heq
    have h1 : (x - w) * e (s * t) = (x - w) * 1 := by linear_combination heq
    have h2 : e (s * t) = 1 := mul_left_cancel₀ (sub_ne_zero.mpr hne) h1
    have h3 : Real.cos (s * t) = 1 := by
      have := congrArg Complex.re h2
      rw [e_eq] at this
      simpa only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im, Complex.I_re, Complex.I_im,
        Complex.one_re, mul_zero, mul_one, sub_self, zero_mul, add_zero, sub_zero] using this
    have hpi := Real.pi_gt_three
    have h4 : s * t = 0 := by
      refine (Real.cos_eq_one_iff_of_lt_of_lt ?_ ?_).mp h3
      · rcases hs with rfl | rfl <;> linarith
      · rcases hs with rfl | rfl <;> linarith
    rcases hs with rfl | rfl <;> linarith
  · have h5 := hclose t (by rw [Real.dist_eq, sub_zero, abs_of_pos ht0]; linarith)
    rw [hstart] at h5
    rw [dist_comm]
    exact h5

namespace ThreePiece

variable {U : Set ℂ} {c : ℂ → α} {x : ℂ}

/-- Each piece of a decomposition is a piece at `x`. -/
theorem isPieceAt (D : ThreePiece U c x) (i : Fin 3) : IsPieceAt U c x (D.piece i) (D.label i) := by
  exact ⟨D.isOpen_piece i, D.isPreconnected_piece i, (D.piece_subset i).trans D.nbhd_subset, D.mem_closure_piece i,
    D.ae_label i⟩

/-- A three-piece point is a point of `U`. -/
theorem mem (D : ThreePiece U c x) : x ∈ U := by
  exact D.nbhd_subset (mem_of_mem_nhds D.nbhd_mem)

/-- The pieces are connected. -/
theorem isConnected_piece (D : ThreePiece U c x) (i : Fin 3) : IsConnected (D.piece i) := by
  exact (D.isPieceAt i).isConnected

/-- The pieces are pairwise disjoint. -/
theorem disjoint_piece (D : ThreePiece U c x) {i j : Fin 3} (h : i ≠ j) : Disjoint (D.piece i) (D.piece j) := by
  exact (D.isPieceAt i).disjoint (D.isPieceAt j) (D.label_injective.ne h)

/-- Almost every point of the neighbourhood is in a piece. -/
theorem ae_mem_piece (D : ThreePiece U c x) : ∀ᵐ z, z ∈ D.nbhd → ∃ i, z ∈ D.piece i := by
  filter_upwards [measure_eq_zero_iff_ae_notMem.mp D.null_diff] with z hz hzN
  by_contra hcon
  exact hz ⟨hzN, fun hmem => hcon (mem_iUnion.mp hmem)⟩

/-- **The cover, read on one side of a circle**: if every piece other than `j` is on the closed side `σ` of the unit
circle about `w`, almost every point of the neighbourhood strictly on the other side has the label of `j`. -/
theorem ae_label_of_forall_onSide (D : ThreePiece U c x) {w : ℂ} {σ : CircleSide} {j : Fin 3}
    (h : ∀ i, i ≠ j → OnSide σ (D.piece i) w) : ∀ᵐ z, z ∈ D.nbhd → z ∈ σ.flip.region w → c z = D.label j := by
  filter_upwards [D.ae_mem_piece, ae_all_iff.2 D.ae_label] with z hz hlab hzN hzσ
  obtain ⟨i, hi⟩ := hz hzN
  by_cases hij : i = j
  · rw [← hij]
    exact hlab i hi
  · exact absurd hzσ (Set.disjoint_left.mp (σ.disjoint_region_flip w) ((h i hij).subset_region (D.isOpen_piece i) hi))

/-- The edge of the pieces `i` and `j`: `cl (P i) ∩ cl (P j) ∩ N`. -/
def edge (D : ThreePiece U c x) (i j : Fin 3) : Set ℂ := closure (D.piece i) ∩ closure (D.piece j) ∩ D.nbhd

/-- The point is on every edge. -/
theorem mem_edge (D : ThreePiece U c x) (i j : Fin 3) : x ∈ D.edge i j := by
  exact ⟨⟨D.mem_closure_piece i, D.mem_closure_piece j⟩, mem_of_mem_nhds D.nbhd_mem⟩

/-- The edge does not depend on the order of the two pieces. -/
theorem edge_comm (D : ThreePiece U c x) (i j : Fin 3) : D.edge i j = D.edge j i := by
  rw [edge, edge, inter_comm (closure (D.piece i))]

/-- `x` **separates at `w`** for this decomposition: it has an inner and an outer piece there. -/
def SeparatesAt (D : ThreePiece U c x) (w : ℂ) : Prop :=
  ∃ i j, InnerAt (D.piece i) w ∧ OuterAt (D.piece j) w

/-- The edge of an inner and an outer piece lies on the unit circle. -/
theorem edge_subset_sphere (D : ThreePiece U c x) {w : ℂ} {i j : Fin 3} (hi : InnerAt (D.piece i) w)
    (hj : OuterAt (D.piece j) w) : D.edge i j ⊆ sphere w 1 := by
  exact fun _ hy => hi.closure_inter_closure_subset hj hy.1

/-- Not separating: one of the two closed sides of the circle holds no piece. -/
theorem not_separatesAt_iff (D : ThreePiece U c x) (w : ℂ) :
    ¬ D.SeparatesAt w ↔ ∃ τ : CircleSide, ∀ i, ¬ OnSide τ (D.piece i) w := by
  constructor
  · intro h
    by_contra hcon
    push Not at hcon
    obtain ⟨i, hi⟩ := hcon .inside
    obtain ⟨j, hj⟩ := hcon .outside
    exact h ⟨i, j, onSide_inside.mp hi, onSide_outside.mp hj⟩
  · rintro ⟨τ, hτ⟩ ⟨i, j, hi, hj⟩
    cases τ
    · exact hτ i (onSide_inside.mpr hi)
    · exact hτ j (onSide_outside.mpr hj)

/-- **Exactly one inner, one outer and one crossing piece at `w`**, named by a permutation of the pieces: `σ 0` is
inner, `σ 1` outer, `σ 2` crossing. (Each piece is exactly one of the three kinds, `not_innerAt_and_outerAt`, and
`σ` is a bijection: one of each.) -/
def OneOfEach (D : ThreePiece U c x) (w : ℂ) (σ : Equiv.Perm (Fin 3)) : Prop :=
  InnerAt (D.piece (σ 0)) w ∧ OuterAt (D.piece (σ 1)) w ∧ CrossingAt (D.piece (σ 2)) w

/-- One of each: the inner piece is the only inner one. -/
theorem OneOfEach.eq_of_innerAt (D : ThreePiece U c x) {w : ℂ} {σ : Equiv.Perm (Fin 3)} (h : D.OneOfEach w σ)
    {i : Fin 3} (hi : InnerAt (D.piece i) w) : i = σ 0 := by
  obtain ⟨k, rfl⟩ := σ.surjective i
  have hk : ∀ k : Fin 3, k = 0 ∨ k = 1 ∨ k = 2 := by decide
  rcases hk k with rfl | rfl | rfl
  · rfl
  · exact absurd ⟨hi, h.2.1⟩ (not_innerAt_and_outerAt (D.isOpen_piece _) (D.isConnected_piece _).nonempty w)
  · exact absurd hi h.2.2.1

/-- One of each: the outer piece is the only outer one. -/
theorem OneOfEach.eq_of_outerAt (D : ThreePiece U c x) {w : ℂ} {σ : Equiv.Perm (Fin 3)} (h : D.OneOfEach w σ)
    {i : Fin 3} (hi : OuterAt (D.piece i) w) : i = σ 1 := by
  obtain ⟨k, rfl⟩ := σ.surjective i
  have hk : ∀ k : Fin 3, k = 0 ∨ k = 1 ∨ k = 2 := by decide
  rcases hk k with rfl | rfl | rfl
  · exact absurd ⟨h.1, hi⟩ (not_innerAt_and_outerAt (D.isOpen_piece _) (D.isConnected_piece _).nonempty w)
  · rfl
  · exact absurd hi h.2.2.2

/-- One of each separates. -/
theorem OneOfEach.separatesAt (D : ThreePiece U c x) {w : ℂ} {σ : Equiv.Perm (Fin 3)} (h : D.OneOfEach w σ) :
    D.SeparatesAt w := by
  exact ⟨σ 0, σ 1, h.1, h.2.1⟩

/-- The decomposition is **full**: for every two of its pieces, `x` is a limit of points other than `x` of their
edge. -/
def IsFull (D : ThreePiece U c x) : Prop := ∀ i j, i ≠ j → x ∈ closure (D.edge i j \ {x})

/-- `x` **saves `w`** for this decomposition: some edge contains an arc of the unit circle about `w` with an end at
`x`. -/
def Saves (D : ThreePiece U c x) (w : ℂ) : Prop := ∃ i j, i ≠ j ∧ HasUnitArcFrom (D.edge i j) w x

/-- The decomposition has **arc edges**: every edge contains an arc from `x` — an injective continuous image of
`[0, 1]` that starts at `x`. (What the second clause of C124-BOTH reads of a sector point.) -/
def HasArcEdges (D : ThreePiece U c x) : Prop :=
  ∀ i j, i ≠ j → ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = x ∧ range γ ⊆ D.edge i j

/-- An arc-edged decomposition is full: the points of an arc from `x` other than `x` tend to `x`. -/
theorem HasArcEdges.isFull {D : ThreePiece U c x} (h : D.HasArcEdges) : D.IsFull := by
  intro i j hij
  obtain ⟨γ, hinj, hγ0, hγ⟩ := h i j hij
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨δ, hδ, hclose⟩ := Metric.continuous_iff.mp γ.continuous 0 ε hε
  have ht0 : 0 < min (δ / 2) 1 := lt_min (by positivity) one_pos
  have hle : min (δ / 2) 1 ≤ δ / 2 := min_le_left _ _
  have hne : (⟨min (δ / 2) 1, ht0.le, min_le_right _ _⟩ : unitInterval) ≠ 0 := by
    intro heq
    have := congrArg Subtype.val heq
    simp only [Set.Icc.coe_zero] at this
    linarith
  refine ⟨γ ⟨min (δ / 2) 1, ht0.le, min_le_right _ _⟩, ⟨hγ ⟨_, rfl⟩, fun heq => hne (hinj ?_)⟩, ?_⟩
  · rw [mem_singleton_iff] at heq
    rw [heq, hγ0]
  · rw [dist_comm, ← hγ0]
    refine hclose _ ?_
    rw [Subtype.dist_eq, Real.dist_eq]
    simp only [Set.Icc.coe_zero, sub_zero]
    rw [abs_of_pos ht0]
    linarith

/-- An arc from a point `x` of the unit circle about `w`, lying on that circle, contains an arc of the circle with an
end at `x`: a connected subset of a circle holding two points holds one of the two arcs between them. -/
theorem hasUnitArcFrom_of_arc_subset_sphere {E : Set ℂ} {w : ℂ} (γ : C(unitInterval, ℂ))
    (hinj : Function.Injective γ) (hx : γ 0 = x) (hE : range γ ⊆ E) (hsph : range γ ⊆ sphere w 1) :
    HasUnitArcFrom E w x := by
  -- the arc as a function on the line, constant beyond its two ends
  obtain ⟨Γ, hΓdef⟩ : ∃ Γ : ℝ → ℂ, ∀ t, Γ t = γ (Set.projIcc 0 1 zero_le_one t) := ⟨_, fun _ => rfl⟩
  have hΓc : Continuous Γ := by
    rw [funext hΓdef]
    exact γ.continuous.comp continuous_projIcc
  have hΓ0 : Γ 0 = x := by
    rw [hΓdef, Set.projIcc_left, ← hx]
    rfl
  have hΓr : ∀ t, Γ t ∈ range γ := fun t => ⟨_, (hΓdef t).symm⟩
  have hxw : ‖x - w‖ = 1 := by
    have := hsph ⟨0, hx⟩
    rwa [mem_sphere, dist_eq_norm] at this
  have hxw0 : x - w ≠ 0 := fun h => by
    rw [h, norm_zero] at hxw
    exact zero_ne_one hxw
  -- its direction from `w`, relative to the direction of `x`: a point of the unit circle, `1` at the start
  obtain ⟨φ, hφdef⟩ : ∃ φ : ℝ → ℂ, ∀ t, φ t = (Γ t - w) / (x - w) := ⟨_, fun _ => rfl⟩
  have hφc : Continuous φ := by
    rw [funext hφdef]
    exact (hΓc.sub continuous_const).div_const _
  have hφ0 : φ 0 = 1 := by rw [hφdef, hΓ0, div_self hxw0]
  have hφn : ∀ t, ‖φ t‖ = 1 := by
    intro t
    have := hsph (hΓr t)
    rw [mem_sphere, dist_eq_norm] at this
    rw [hφdef, norm_div, this, hxw, div_one]
  have hφe : ∀ t, φ t = e (Complex.arg (φ t)) := by
    intro t
    have := Complex.norm_mul_exp_arg_mul_I (φ t)
    rw [hφn t, Complex.ofReal_one, one_mul] at this
    rw [e, this]
  have hΓφ : ∀ t, Γ t = w + (x - w) * φ t := by
    intro t
    have h1 : (x - w) * ((Γ t - w) / (x - w)) = Γ t - w := by field_simp
    rw [hφdef, h1]
    ring
  -- a stretch `[0, u₀]` on which the direction stays off the negative real axis, so that its argument is continuous
  obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp (Complex.isOpen_slitPlane.preimage hφc) 0
    (by rw [mem_preimage, hφ0]; exact Complex.one_mem_slitPlane)
  have hu₀pos : 0 < min (r / 2) 1 := lt_min (by positivity) one_pos
  have hu₀le : min (r / 2) 1 ≤ r / 2 := min_le_left _ _
  have hu₀1 : min (r / 2) 1 ≤ 1 := min_le_right _ _
  set u₀ := min (r / 2) 1 with hu₀
  have hcont : ContinuousOn (fun t => Complex.arg (φ t)) (uIcc 0 u₀) := by
    intro t ht
    rw [uIcc_of_le hu₀pos.le] at ht
    have hts : φ t ∈ Complex.slitPlane := hball (by
      rw [mem_ball, Real.dist_eq, sub_zero, abs_of_nonneg ht.1]
      linarith [ht.2])
    exact ((Complex.continuousAt_arg hts).comp hφc.continuousAt).continuousWithinAt
  have hivt : uIcc (Complex.arg (φ 0)) (Complex.arg (φ u₀)) ⊆ (fun t => Complex.arg (φ t)) '' uIcc 0 u₀ :=
    intermediate_value_uIcc hcont
  rw [hφ0, Complex.arg_one] at hivt
  -- the argument at `u₀` is not `0`: the arc is injective
  have hθ₀ne : Complex.arg (φ u₀) ≠ 0 := by
    intro h0
    have h1 : φ u₀ = 1 := by
      rw [hφe u₀, h0]
      simp [e]
    have h2 : Γ u₀ = Γ 0 := by rw [hΓφ u₀, hΓφ 0, h1, hφ0]
    rw [hΓdef, hΓdef] at h2
    have h3 := hinj h2
    rw [Set.projIcc_of_mem zero_le_one ⟨hu₀pos.le, hu₀1⟩, Set.projIcc_left] at h3
    exact hu₀pos.ne' (congrArg Subtype.val h3)
  set θ₀ := Complex.arg (φ u₀) with hθ₀
  -- the turning sense is the sign of that argument, the length its absolute value
  refine ⟨if 0 < θ₀ then 1 else -1, by split_ifs <;> simp, |θ₀|, abs_pos.mpr hθ₀ne, fun t ht => ?_⟩
  have hmem : (if 0 < θ₀ then (1 : ℝ) else -1) * t ∈ uIcc 0 θ₀ := by
    rw [mem_uIcc]
    split_ifs with hpos
    · left
      rw [abs_of_pos hpos] at ht
      exact ⟨by linarith [ht.1], by linarith [ht.2]⟩
    · right
      have hneg : θ₀ < 0 := lt_of_le_of_ne (not_lt.mp hpos) hθ₀ne
      rw [abs_of_neg hneg] at ht
      exact ⟨by linarith [ht.2], by linarith [ht.1]⟩
  obtain ⟨u, -, hu⟩ := hivt hmem
  have hu' : Complex.arg (φ u) = (if 0 < θ₀ then (1 : ℝ) else -1) * t := hu
  have hpt : w + (x - w) * e ((if 0 < θ₀ then (1 : ℝ) else -1) * t) = Γ u := by
    rw [hΓφ u, hφe u, hu']
  rw [hpt]
  exact hE (hΓr u)

end ThreePiece

/-! ## An ordinary three-sector point -/

/-- The sector colouring: `0` on the open first quadrant, `1` between the rays along `i` and `−1 − i`, `2`
elsewhere. -/
noncomputable def sectorCol (z : ℂ) : Fin 3 :=
  if 0 < z.re ∧ 0 < z.im then 0 else if z.re < 0 ∧ z.re < z.im then 1 else 2

/-- The three open sectors cut by the rays along `1`, `i` and `−1 − i`. -/
def sectorSet : Fin 3 → Set ℂ
  | 0 => {z | 0 < z.re ∧ 0 < z.im}
  | 1 => {z | z.re < 0 ∧ z.re < z.im}
  | 2 => {z | z.im < 0 ∧ z.im < z.re}

/-- The sector colouring is measurable. -/
theorem measurable_sectorCol : Measurable sectorCol := by
  sorry

/-- A disc of radius `1/4` holds no unit pair: every measurable colouring is a weak colouring of it. -/
theorem isWeakColouringOn_ball_quarter {c : ℂ → Fin k} (hc : Measurable c) (p : ℂ) :
    IsWeakColouringOn (ball p (1 / 4)) c := by
  sorry

/-- **An ordinary three-sector point**: the decomposition of the disc of radius `1/4` about `0` into the three
sectors. -/
noncomputable def sectorPoint : ThreePiece (ball (0 : ℂ) (1 / 4)) sectorCol 0 where
  nbhd := ball 0 (1 / 4)
  piece i := sectorSet i ∩ ball 0 (1 / 4)
  label i := i
  nbhd_mem := by sorry
  nbhd_subset := by sorry
  piece_subset := by sorry
  isOpen_piece := by sorry
  isPreconnected_piece := by sorry
  mem_closure_piece := by sorry
  ae_label := by sorry
  label_injective := by sorry
  null_diff := by sorry

/-- The ordinary three-sector point has arc edges: the edge of two sectors holds the radius between them. -/
theorem sectorPoint_hasArcEdges : sectorPoint.HasArcEdges := by
  sorry

/-- The ordinary three-sector point is full. -/
theorem sectorPoint_isFull : sectorPoint.IsFull :=
  sectorPoint_hasArcEdges.isFull

/-! ## A three-piece point by the letter only -/

/-- The petal colouring: `1` on the right petal `|Im z| < Re z < 1/8`, `2` on the left petal `|Im z| < −Re z < 1/8`,
`0` elsewhere. -/
noncomputable def petalCol (z : ℂ) : Fin 3 :=
  if |z.im| < z.re ∧ z.re < 1 / 8 then 1 else if |z.im| < -z.re ∧ -z.re < 1 / 8 then 2 else 0

/-- The two petals and the sea around them. -/
def petalSet : Fin 3 → Set ℂ
  | 0 => {z | |z.re| < |z.im| ∨ 1 / 8 < |z.re|}
  | 1 => {z | |z.im| < z.re ∧ z.re < 1 / 8}
  | 2 => {z | |z.im| < -z.re ∧ -z.re < 1 / 8}

/-- The petal colouring is measurable. -/
theorem measurable_petalCol : Measurable petalCol := by
  sorry

/-- **A three-piece point by the letter**: two petals at `0` and the sea, in the disc of radius `1/4`. The sea is
connected: its upper and lower wedges `|Re z| < ± Im z` meet its right and left caps `1/8 < ± Re z` inside the
disc. -/
noncomputable def petalPoint : ThreePiece (ball (0 : ℂ) (1 / 4)) petalCol 0 where
  nbhd := ball 0 (1 / 4)
  piece i := petalSet i ∩ ball 0 (1 / 4)
  label i := i
  nbhd_mem := by sorry
  nbhd_subset := by sorry
  piece_subset := by sorry
  isOpen_piece := by sorry
  isPreconnected_piece := by sorry
  mem_closure_piece := by sorry
  ae_label := by sorry
  label_injective := by sorry
  null_diff := by sorry

/-- The closures of the two petals meet at `0` only: the edge of the pieces `1` and `2` is the point. -/
theorem petalPoint_edge : petalPoint.edge 1 2 = {0} := by
  sorry

/-- **A three-piece point by the letter is not full.** -/
theorem petalPoint_not_isFull : ¬ petalPoint.IsFull := by
  sorry

/-! ## Spec examples -/

/-- Both models are three-piece points of weak colourings. -/
example : IsThreePiecePoint (ball (0 : ℂ) (1 / 4)) sectorCol 0 ∧ IsThreePiecePoint (ball (0 : ℂ) (1 / 4)) petalCol 0 :=
  ⟨⟨sectorPoint⟩, ⟨petalPoint⟩⟩

/-- The sector point's pieces at the unit point `w = −i` of `0`: the first quadrant is outer (it lies above the real
axis, and the disc about `−i` below it). -/
example : OuterAt (sectorPoint.piece 0) (-I) := by
  sorry

/-- The sector point's piece `2`, between the rays along `−1 − i` and `1`, is crossing at `w = −i`: it holds the
start of the ray along `−i`, inside the unit circle about `−i`, and points near the ray along `1`, outside it. -/
example : CrossingAt (sectorPoint.piece 2) (-I) := by
  sorry

/-- **Adversary** for `HasUnitArcFrom`: a single point holds no arc of the unit circle about `0` from `1`. -/
example : ¬ HasUnitArcFrom ({1} : Set ℂ) 0 1 := by
  sorry

/-- The unit circle about `0` holds an arc from `1`. -/
example : HasUnitArcFrom (sphere (0 : ℂ) 1) 0 1 := by
  sorry

end HadwigerNelson.Plane
