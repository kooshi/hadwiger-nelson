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

/-! ## Tools for the two models -/

/-- Every element of `Fin 3` is `0`, `1` or `2`. -/
theorem fin_three_cases (k : Fin 3) : k = 0 ∨ k = 1 ∨ k = 2 := by
  revert k
  decide

/-- A point `p` with `p + s e` in `S` for every small `s > 0` is in the closure of `S`. -/
theorem mem_closure_of_forall_add_ofReal_mul_mem {S : Set ℂ} {p d : ℂ} {r : ℝ} (hr : 0 < r)
    (h : ∀ s : ℝ, 0 < s → s < r → p + (s : ℂ) * d ∈ S) : p ∈ closure S := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hcont : Continuous fun s : ℝ => p + (s : ℂ) * d :=
    continuous_const.add (Complex.continuous_ofReal.mul continuous_const)
  obtain ⟨δ, hδ, hclose⟩ := Metric.continuous_iff.mp hcont 0 ε hε
  have hs0 : 0 < min (δ / 2) (r / 2) := lt_min (by positivity) (by positivity)
  have h1 : min (δ / 2) (r / 2) ≤ δ / 2 := min_le_left _ _
  have h2 : min (δ / 2) (r / 2) ≤ r / 2 := min_le_right _ _
  refine ⟨_, h _ hs0 (by linarith), ?_⟩
  have h3 := hclose (min (δ / 2) (r / 2)) (by rw [Real.dist_eq, sub_zero, abs_of_pos hs0]; linarith)
  rw [Complex.ofReal_zero, zero_mul, add_zero, dist_comm] at h3
  exact h3

/-- A point of an open disc that is in the closure of `S` is in the closure of the part of `S` in the disc. -/
theorem mem_closure_inter_ball {S : Set ℂ} {p c : ℂ} {r : ℝ} (hp : p ∈ ball c r) (h : p ∈ closure S) :
    p ∈ closure (S ∩ ball c r) := by
  rw [inter_comm]
  exact isOpen_ball.inter_closure ⟨hp, h⟩

/-- A point whose real and imaginary parts are small in absolute value is in a disc about `0`. -/
theorem mem_ball_zero_of_abs_re_add_abs_im_lt {z : ℂ} {r : ℝ} (h : |z.re| + |z.im| < r) : z ∈ ball (0 : ℂ) r := by
  rw [mem_ball, dist_zero_right]
  exact lt_of_le_of_lt (Complex.norm_le_abs_re_add_abs_im z) h

/-- A point the sum of the squares of whose real and imaginary parts is below `r²` is in the disc of radius `r`
about `0`. -/
theorem mem_ball_zero_of_sq_lt {z : ℂ} {r : ℝ} (hr : 0 ≤ r) (h : z.re ^ 2 + z.im ^ 2 < r ^ 2) :
    z ∈ ball (0 : ℂ) r := by
  rw [mem_ball, dist_zero_right]
  by_contra hc
  have h1 : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    ring
  have h2 := pow_le_pow_left₀ hr (not_lt.mp hc) 2
  linarith

/-- The points `t d`, `0 ≤ t ≤ 1`, of a short radius lie in the disc of radius `1/4` about `0`. -/
theorem ofReal_mul_mem_ball_quarter {d : ℂ} (hd : |d.re| + |d.im| < 1 / 4) {t : ℝ} (ht0 : 0 ≤ t) (ht1 : t ≤ 1) :
    (t : ℂ) * d ∈ ball (0 : ℂ) (1 / 4) := by
  refine mem_ball_zero_of_abs_re_add_abs_im_lt ?_
  rw [Complex.re_ofReal_mul, Complex.im_ofReal_mul, abs_mul, abs_mul, abs_of_nonneg ht0]
  have := mul_le_mul_of_nonneg_right ht1 (add_nonneg (abs_nonneg d.re) (abs_nonneg d.im))
  linarith

/-- **A line of the plane is null**: the kernel of a non-zero real-linear form, translated. -/
theorem volume_setOf_re_im_eq {a b : ℝ} (hab : a ≠ 0 ∨ b ≠ 0) (c : ℝ) :
    volume {z : ℂ | a * z.re + b * z.im = c} = 0 := by
  obtain ⟨f, hf⟩ : ∃ f : ℂ →ₗ[ℝ] ℝ, ∀ z, f z = a * z.re + b * z.im :=
    ⟨a • Complex.reLm + b • Complex.imLm, fun z => by simp⟩
  have hv : f ⟨a, b⟩ ≠ 0 := by
    rw [hf]
    show a * a + b * b ≠ 0
    rcases hab with h | h
    · have := mul_self_pos.mpr h
      have := mul_self_nonneg b
      linarith
    · have := mul_self_pos.mpr h
      have := mul_self_nonneg a
      linarith
  have hker : volume (LinearMap.ker f : Set ℂ) = 0 :=
    Measure.addHaar_submodule volume _ fun htop => hv (LinearMap.mem_ker.mp (htop ▸ Submodule.mem_top))
  have hpre : {z : ℂ | a * z.re + b * z.im = c} =
      (fun z => z - (c / f ⟨a, b⟩) • (⟨a, b⟩ : ℂ)) ⁻¹' (LinearMap.ker f : Set ℂ) := by
    ext z
    rw [mem_setOf_eq, mem_preimage, SetLike.mem_coe, LinearMap.mem_ker, map_sub, map_smul, smul_eq_mul,
      div_mul_cancel₀ _ hv, sub_eq_zero, hf z]
  rw [hpre]
  exact (measurePreserving_sub_right volume _).quasiMeasurePreserving.preimage_null hker

/-- A positive combination of two strict inequalities. -/
theorem combo_lt {s t u₁ v₁ u₂ v₂ : ℝ} (hs : 0 < s) (ht : 0 < t) (h₁ : u₁ < v₁) (h₂ : u₂ < v₂) :
    s * u₁ + t * u₂ < s * v₁ + t * v₂ :=
  add_lt_add (mul_lt_mul_of_pos_left h₁ hs) (mul_lt_mul_of_pos_left h₂ ht)

/-- **A straight arc from `0`**: if `d ≠ 0` and the points `t d`, `0 ≤ t ≤ 1`, lie in `E`, then `E` contains an arc
from `0`. -/
theorem exists_arc_of_ray_subset {E : Set ℂ} {d : ℂ} (hd : d ≠ 0) (h : ∀ t : ℝ, 0 ≤ t → t ≤ 1 → (t : ℂ) * d ∈ E) :
    ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ E := by
  refine ⟨⟨fun t => ((t : ℝ) : ℂ) * d,
    (Complex.continuous_ofReal.comp continuous_subtype_val).mul continuous_const⟩, ?_, ?_, ?_⟩
  · intro s t hst
    exact Subtype.ext (Complex.ofReal_injective (mul_right_cancel₀ hd hst))
  · show (((0 : unitInterval) : ℝ) : ℂ) * d = 0
    simp
  · rintro _ ⟨t, rfl⟩
    exact h t t.2.1 t.2.2

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
  refine Measurable.ite ?_ measurable_const (Measurable.ite ?_ measurable_const measurable_const)
  · exact ((isOpen_lt continuous_const Complex.continuous_re).inter
      (isOpen_lt continuous_const Complex.continuous_im)).measurableSet
  · exact ((isOpen_lt Complex.continuous_re continuous_const).inter
      (isOpen_lt Complex.continuous_re Complex.continuous_im)).measurableSet

/-- A disc of radius `1/4` holds no unit pair: every measurable colouring is a weak colouring of it. -/
theorem isWeakColouringOn_ball_quarter {c : ℂ → Fin k} (hc : Measurable c) (p : ℂ) :
    IsWeakColouringOn (ball p (1 / 4)) c := by
  refine ⟨hc, aeProperOn_of_proper fun x hx y hy hxy => ?_⟩
  exfalso
  have := dist_triangle_right x y p
  rw [mem_ball] at hx hy
  linarith

/-- The sector `0`: the open first quadrant. -/
theorem mem_sectorSet_zero {z : ℂ} : z ∈ sectorSet 0 ↔ 0 < z.re ∧ 0 < z.im := Iff.rfl

/-- The sector `1`: between the rays along `i` and `−1 − i`. -/
theorem mem_sectorSet_one {z : ℂ} : z ∈ sectorSet 1 ↔ z.re < 0 ∧ z.re < z.im := Iff.rfl

/-- The sector `2`: between the rays along `−1 − i` and `1`. -/
theorem mem_sectorSet_two {z : ℂ} : z ∈ sectorSet 2 ↔ z.im < 0 ∧ z.im < z.re := Iff.rfl

/-- The sectors are open. -/
theorem isOpen_sectorSet (i : Fin 3) : IsOpen (sectorSet i) := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact (isOpen_lt continuous_const Complex.continuous_re).inter (isOpen_lt continuous_const Complex.continuous_im)
  · exact (isOpen_lt Complex.continuous_re continuous_const).inter
      (isOpen_lt Complex.continuous_re Complex.continuous_im)
  · exact (isOpen_lt Complex.continuous_im continuous_const).inter
      (isOpen_lt Complex.continuous_im Complex.continuous_re)

/-- The sectors are convex: each is cut by two open half-planes. -/
theorem convex_sectorSet (i : Fin 3) : Convex ℝ (sectorSet i) := by
  rw [convex_iff_forall_pos]
  rcases fin_three_cases i with rfl | rfl | rfl
  · rintro p ⟨hp1, hp2⟩ q ⟨hq1, hq2⟩ s t hs ht -
    rw [mem_sectorSet_zero]
    simp only [Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul]
    exact ⟨by linarith [combo_lt hs ht hp1 hq1], by linarith [combo_lt hs ht hp2 hq2]⟩
  · rintro p ⟨hp1, hp2⟩ q ⟨hq1, hq2⟩ s t hs ht -
    rw [mem_sectorSet_one]
    simp only [Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul]
    exact ⟨by linarith [combo_lt hs ht hp1 hq1], by linarith [combo_lt hs ht hp2 hq2]⟩
  · rintro p ⟨hp1, hp2⟩ q ⟨hq1, hq2⟩ s t hs ht -
    rw [mem_sectorSet_two]
    simp only [Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul]
    exact ⟨by linarith [combo_lt hs ht hp1 hq1], by linarith [combo_lt hs ht hp2 hq2]⟩

/-- The sector colouring has the label `i` on the sector `i`. -/
theorem sectorCol_of_mem {i : Fin 3} {z : ℂ} (h : z ∈ sectorSet i) : sectorCol z = i := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · rw [sectorCol, if_pos (mem_sectorSet_zero.mp h)]
  · obtain ⟨h1, h2⟩ := mem_sectorSet_one.mp h
    rw [sectorCol, if_neg (fun h' => by linarith [h'.1]), if_pos ⟨h1, h2⟩]
  · obtain ⟨h1, h2⟩ := mem_sectorSet_two.mp h
    rw [sectorCol, if_neg (fun h' => by linarith [h'.2]), if_neg (fun h' => by linarith [h'.2])]

/-- A point of the closed first quadrant is in the closure of the sector `0`. -/
theorem mem_closure_sectorSet_zero {p : ℂ} (h1 : 0 ≤ p.re) (h2 : 0 ≤ p.im) : p ∈ closure (sectorSet 0) := by
  refine mem_closure_of_forall_add_ofReal_mul_mem (d := 1 + I) one_pos fun s hs _ => mem_sectorSet_zero.mpr ?_
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im]
  constructor <;> linarith

/-- A point with `re ≤ 0` and `re ≤ im` is in the closure of the sector `1`. -/
theorem mem_closure_sectorSet_one {p : ℂ} (h1 : p.re ≤ 0) (h2 : p.re ≤ p.im) : p ∈ closure (sectorSet 1) := by
  refine mem_closure_of_forall_add_ofReal_mul_mem (d := -1 + I) one_pos fun s hs _ => mem_sectorSet_one.mpr ?_
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.neg_re, Complex.neg_im, Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im]
  constructor <;> linarith

/-- A point with `im ≤ 0` and `im ≤ re` is in the closure of the sector `2`. -/
theorem mem_closure_sectorSet_two {p : ℂ} (h1 : p.im ≤ 0) (h2 : p.im ≤ p.re) : p ∈ closure (sectorSet 2) := by
  refine mem_closure_of_forall_add_ofReal_mul_mem (d := 1 - I) one_pos fun s hs _ => mem_sectorSet_two.mpr ?_
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im]
  constructor <;> linarith

/-- `0` is in the closure of each sector. -/
theorem zero_mem_closure_sectorSet (i : Fin 3) : (0 : ℂ) ∈ closure (sectorSet i) := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact mem_closure_sectorSet_zero (by simp) (by simp)
  · exact mem_closure_sectorSet_one (by simp) (by simp)
  · exact mem_closure_sectorSet_two (by simp) (by simp)

/-- The disc of radius `1/4` about `0` is the union of the three sectors up to a null set: what is left lies on the
three lines `re = 0`, `im = 0` and `re = im`. -/
theorem volume_ball_diff_iUnion_sectorSet :
    volume (ball (0 : ℂ) (1 / 4) \ ⋃ i, sectorSet i ∩ ball (0 : ℂ) (1 / 4)) = 0 := by
  refine measure_mono_null (fun z hz => ?_) (measure_union_null (measure_union_null
    (volume_setOf_re_im_eq (a := 1) (b := 0) (Or.inl one_ne_zero) 0)
    (volume_setOf_re_im_eq (a := 0) (b := 1) (Or.inr one_ne_zero) 0))
    (volume_setOf_re_im_eq (a := 1) (b := -1) (Or.inl one_ne_zero) 0))
  obtain ⟨hzb, hzn⟩ := hz
  have hn : ∀ i, z ∉ sectorSet i := fun i hi => hzn (mem_iUnion.mpr ⟨i, hi, hzb⟩)
  have h0 := hn 0
  have h1 := hn 1
  have h2 := hn 2
  rw [mem_sectorSet_zero] at h0
  rw [mem_sectorSet_one] at h1
  rw [mem_sectorSet_two] at h2
  rcases lt_trichotomy z.re 0 with hre | hre | hre
  · rcases lt_trichotomy z.re z.im with h | h | h
    · exact absurd ⟨hre, h⟩ h1
    · exact Or.inr (by show (1 : ℝ) * z.re + -1 * z.im = 0; linarith)
    · exact absurd ⟨by linarith, h⟩ h2
  · exact Or.inl (Or.inl (by show (1 : ℝ) * z.re + 0 * z.im = 0; linarith))
  · rcases lt_trichotomy z.im 0 with him | him | him
    · exact absurd ⟨him, by linarith⟩ h2
    · exact Or.inl (Or.inr (by show (0 : ℝ) * z.re + 1 * z.im = 0; linarith))
    · exact absurd ⟨hre, him⟩ h0

/-- **An ordinary three-sector point**: the decomposition of the disc of radius `1/4` about `0` into the three
sectors. -/
noncomputable def sectorPoint : ThreePiece (ball (0 : ℂ) (1 / 4)) sectorCol 0 where
  nbhd := ball 0 (1 / 4)
  piece i := sectorSet i ∩ ball 0 (1 / 4)
  label i := i
  nbhd_mem := by exact ball_mem_nhds 0 (by norm_num)
  nbhd_subset := by exact Subset.rfl
  piece_subset := by exact fun _ => inter_subset_right
  isOpen_piece := by exact fun i => (isOpen_sectorSet i).inter isOpen_ball
  isPreconnected_piece := by exact fun i => ((convex_sectorSet i).inter (convex_ball 0 (1 / 4))).isPreconnected
  mem_closure_piece := by
    exact fun i => mem_closure_inter_ball (mem_ball_self (by norm_num)) (zero_mem_closure_sectorSet i)
  ae_label := by exact fun i => Filter.Eventually.of_forall fun z hz => sectorCol_of_mem hz.1
  label_injective := by exact fun _ _ h => h
  null_diff := by exact volume_ball_diff_iUnion_sectorSet

/-- A point of the disc in the closures of two sectors is on their edge. -/
theorem mem_sectorPoint_edge {i j : Fin 3} {p : ℂ} (hp : p ∈ ball (0 : ℂ) (1 / 4)) (hi : p ∈ closure (sectorSet i))
    (hj : p ∈ closure (sectorSet j)) : p ∈ sectorPoint.edge i j :=
  ⟨⟨mem_closure_inter_ball hp hi, mem_closure_inter_ball hp hj⟩, hp⟩

/-- The ordinary three-sector point has arc edges: the edge of two sectors holds the radius between them. -/
theorem sectorPoint_hasArcEdges : sectorPoint.HasArcEdges := by
  have hre : ∀ t a b : ℝ, ((t : ℂ) * (⟨a, b⟩ : ℂ)).re = t * a := fun t a b => by simp
  have him : ∀ t a b : ℝ, ((t : ℂ) * (⟨a, b⟩ : ℂ)).im = t * b := fun t a b => by simp
  -- the radius along `i`, between the sectors `0` and `1`
  have h01 : ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ sectorPoint.edge 0 1 := by
    refine exists_arc_of_ray_subset (d := ⟨0, 1 / 16⟩)
      (fun h => by have := congrArg Complex.im h; norm_num at this) fun t ht0 ht1 => ?_
    refine mem_sectorPoint_edge (ofReal_mul_mem_ball_quarter (by norm_num) ht0 ht1)
      (mem_closure_sectorSet_zero ?_ ?_) (mem_closure_sectorSet_one ?_ ?_)
    all_goals simp only [hre, him]
    all_goals linarith
  -- the radius along `1`, between the sectors `0` and `2`
  have h02 : ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ sectorPoint.edge 0 2 := by
    refine exists_arc_of_ray_subset (d := ⟨1 / 16, 0⟩)
      (fun h => by have := congrArg Complex.re h; norm_num at this) fun t ht0 ht1 => ?_
    refine mem_sectorPoint_edge (ofReal_mul_mem_ball_quarter (by norm_num) ht0 ht1)
      (mem_closure_sectorSet_zero ?_ ?_) (mem_closure_sectorSet_two ?_ ?_)
    all_goals simp only [hre, him]
    all_goals linarith
  -- the radius along `−1 − i`, between the sectors `1` and `2`
  have h12 : ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ sectorPoint.edge 1 2 := by
    refine exists_arc_of_ray_subset (d := ⟨-(1 / 16), -(1 / 16)⟩)
      (fun h => by have := congrArg Complex.re h; norm_num at this) fun t ht0 ht1 => ?_
    refine mem_sectorPoint_edge (ofReal_mul_mem_ball_quarter (by norm_num) ht0 ht1)
      (mem_closure_sectorSet_one ?_ ?_) (mem_closure_sectorSet_two ?_ ?_)
    all_goals simp only [hre, him]
    all_goals linarith
  intro i j hij
  rcases fin_three_cases i with rfl | rfl | rfl <;> rcases fin_three_cases j with rfl | rfl | rfl
  · exact absurd rfl hij
  · exact h01
  · exact h02
  · rw [ThreePiece.edge_comm]; exact h01
  · exact absurd rfl hij
  · exact h12
  · rw [ThreePiece.edge_comm]; exact h02
  · rw [ThreePiece.edge_comm]; exact h12
  · exact absurd rfl hij

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
  refine Measurable.ite ?_ measurable_const (Measurable.ite ?_ measurable_const measurable_const)
  · exact ((isOpen_lt Complex.continuous_im.abs Complex.continuous_re).inter
      (isOpen_lt Complex.continuous_re continuous_const)).measurableSet
  · exact ((isOpen_lt Complex.continuous_im.abs Complex.continuous_re.neg).inter
      (isOpen_lt Complex.continuous_re.neg continuous_const)).measurableSet

/-- The sea: off the two closed petals. -/
theorem mem_petalSet_zero {z : ℂ} : z ∈ petalSet 0 ↔ |z.re| < |z.im| ∨ 1 / 8 < |z.re| := Iff.rfl

/-- The right petal. -/
theorem mem_petalSet_one {z : ℂ} : z ∈ petalSet 1 ↔ |z.im| < z.re ∧ z.re < 1 / 8 := Iff.rfl

/-- The left petal. -/
theorem mem_petalSet_two {z : ℂ} : z ∈ petalSet 2 ↔ |z.im| < -z.re ∧ -z.re < 1 / 8 := Iff.rfl

/-- The petals and the sea are open. -/
theorem isOpen_petalSet (i : Fin 3) : IsOpen (petalSet i) := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact (isOpen_lt Complex.continuous_re.abs Complex.continuous_im.abs).union
      (isOpen_lt continuous_const Complex.continuous_re.abs)
  · exact (isOpen_lt Complex.continuous_im.abs Complex.continuous_re).inter
      (isOpen_lt Complex.continuous_re continuous_const)
  · exact (isOpen_lt Complex.continuous_im.abs Complex.continuous_re.neg).inter
      (isOpen_lt Complex.continuous_re.neg continuous_const)

/-- The petal colouring has the label `i` on the set `i`. -/
theorem petalCol_of_mem {i : Fin 3} {z : ℂ} (h : z ∈ petalSet i) : petalCol z = i := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · have h' := mem_petalSet_zero.mp h
    have hn1 : ¬ (|z.im| < z.re ∧ z.re < 1 / 8) := by
      rintro ⟨h1, h2⟩
      have h0 := abs_nonneg z.im
      rw [abs_of_pos (lt_of_le_of_lt h0 h1)] at h'
      rcases h' with h3 | h3 <;> linarith
    have hn2 : ¬ (|z.im| < -z.re ∧ -z.re < 1 / 8) := by
      rintro ⟨h1, h2⟩
      have h0 := abs_nonneg z.im
      rw [abs_of_neg (by linarith)] at h'
      rcases h' with h3 | h3 <;> linarith
    rw [petalCol, if_neg hn1, if_neg hn2]
  · rw [petalCol, if_pos (mem_petalSet_one.mp h)]
  · obtain ⟨h1, h2⟩ := mem_petalSet_two.mp h
    rw [petalCol, if_neg (fun h' => by linarith [h'.1, abs_nonneg z.im]), if_pos ⟨h1, h2⟩]

/-- The right petal is convex. -/
theorem convex_petalSet_one : Convex ℝ (petalSet 1) := by
  rw [convex_iff_forall_pos]
  intro p hp q hq s t hs ht hst
  rw [mem_petalSet_one, abs_lt] at hp hq ⊢
  obtain ⟨⟨hp1, hp2⟩, hp3⟩ := hp
  obtain ⟨⟨hq1, hq2⟩, hq3⟩ := hq
  simp only [Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul]
  have e3 := combo_lt hs ht hp3 hq3
  exact ⟨⟨by linarith [combo_lt hs ht hp1 hq1], by linarith [combo_lt hs ht hp2 hq2]⟩, by nlinarith⟩

/-- The left petal is convex. -/
theorem convex_petalSet_two : Convex ℝ (petalSet 2) := by
  rw [convex_iff_forall_pos]
  intro p hp q hq s t hs ht hst
  rw [mem_petalSet_two, abs_lt] at hp hq ⊢
  obtain ⟨⟨hp1, hp2⟩, hp3⟩ := hp
  obtain ⟨⟨hq1, hq2⟩, hq3⟩ := hq
  simp only [Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul]
  have e3 := combo_lt hs ht hp3 hq3
  exact ⟨⟨by linarith [combo_lt hs ht hp1 hq1], by linarith [combo_lt hs ht hp2 hq2]⟩, by nlinarith⟩

/-- A wedge `|a Re z| < b Im z`-style region cut by two open half-planes through `0` is convex: the upper wedge
`|Re z| < Im z` and the lower wedge `|Re z| < −Im z`, by the sign `ε = ±1`. -/
theorem convex_setOf_abs_re_lt_mul_im {ε : ℝ} : Convex ℝ {z : ℂ | |z.re| < ε * z.im} := by
  rw [convex_iff_forall_pos]
  intro p hp q hq s t hs ht hst
  rw [mem_setOf_eq, abs_lt] at hp hq ⊢
  obtain ⟨hp1, hp2⟩ := hp
  obtain ⟨hq1, hq2⟩ := hq
  simp only [Complex.add_re, Complex.add_im, Complex.smul_re, Complex.smul_im, smul_eq_mul]
  exact ⟨by linarith [combo_lt hs ht hp1 hq1], by linarith [combo_lt hs ht hp2 hq2]⟩

/-- A cap `1/8 < ε Re z` is convex: the right cap and the left cap, by the sign `ε = ±1`. -/
theorem convex_setOf_lt_mul_re {ε : ℝ} : Convex ℝ {z : ℂ | 1 / 8 < ε * z.re} := by
  rw [convex_iff_forall_pos]
  intro p hp q hq s t hs ht hst
  rw [mem_setOf_eq] at hp hq ⊢
  simp only [Complex.add_re, Complex.smul_re, smul_eq_mul]
  have e := combo_lt hs ht hp hq
  nlinarith

/-- **The sea is connected inside the disc**: it is the union of the upper and the lower wedge and the right and the
left cap, each convex in the disc; the upper wedge meets both caps and the right cap meets the lower wedge. -/
theorem isPreconnected_petalSea : IsPreconnected (petalSet 0 ∩ ball (0 : ℂ) (1 / 4)) := by
  have hB := convex_ball (0 : ℂ) (1 / 4)
  have hW₁ : IsPreconnected ({z : ℂ | |z.re| < 1 * z.im} ∩ ball (0 : ℂ) (1 / 4)) :=
    (convex_setOf_abs_re_lt_mul_im.inter hB).isPreconnected
  have hW₂ : IsPreconnected ({z : ℂ | |z.re| < -1 * z.im} ∩ ball (0 : ℂ) (1 / 4)) :=
    (convex_setOf_abs_re_lt_mul_im.inter hB).isPreconnected
  have hC₁ : IsPreconnected ({z : ℂ | 1 / 8 < 1 * z.re} ∩ ball (0 : ℂ) (1 / 4)) :=
    (convex_setOf_lt_mul_re.inter hB).isPreconnected
  have hC₂ : IsPreconnected ({z : ℂ | 1 / 8 < -1 * z.re} ∩ ball (0 : ℂ) (1 / 4)) :=
    (convex_setOf_lt_mul_re.inter hB).isPreconnected
  -- three points of the disc: in the upper wedge and the right cap, in the right cap and the lower wedge, in the
  -- upper wedge and the left cap
  have hb : ∀ a b : ℝ, a ^ 2 + b ^ 2 < (1 / 4) ^ 2 → (⟨a, b⟩ : ℂ) ∈ ball (0 : ℂ) (1 / 4) := fun a b h =>
    mem_ball_zero_of_sq_lt (by norm_num) h
  have h1 := hW₁.union (⟨13 / 100, 14 / 100⟩ : ℂ)
    ⟨by show |(13 / 100 : ℝ)| < 1 * (14 / 100); rw [abs_of_pos] <;> norm_num, hb _ _ (by norm_num)⟩
    ⟨by show (1 / 8 : ℝ) < 1 * (13 / 100); norm_num, hb _ _ (by norm_num)⟩ hC₁
  have h2 := h1.union (⟨13 / 100, -(14 / 100)⟩ : ℂ)
    (Or.inr ⟨by show (1 / 8 : ℝ) < 1 * (13 / 100); norm_num, hb _ _ (by norm_num)⟩)
    ⟨by show |(13 / 100 : ℝ)| < -1 * -(14 / 100); rw [abs_of_pos] <;> norm_num, hb _ _ (by norm_num)⟩ hW₂
  have h3 := h2.union (⟨-(13 / 100), 14 / 100⟩ : ℂ)
    (Or.inl (Or.inl ⟨by show |(-(13 / 100) : ℝ)| < 1 * (14 / 100); rw [abs_of_neg] <;> norm_num,
      hb _ _ (by norm_num)⟩))
    ⟨by show (1 / 8 : ℝ) < -1 * -(13 / 100); norm_num, hb _ _ (by norm_num)⟩ hC₂
  have heq : petalSet 0 ∩ ball (0 : ℂ) (1 / 4) =
      {z : ℂ | |z.re| < 1 * z.im} ∩ ball (0 : ℂ) (1 / 4) ∪ {z : ℂ | 1 / 8 < 1 * z.re} ∩ ball (0 : ℂ) (1 / 4) ∪
        {z : ℂ | |z.re| < -1 * z.im} ∩ ball (0 : ℂ) (1 / 4) ∪ {z : ℂ | 1 / 8 < -1 * z.re} ∩ ball (0 : ℂ) (1 / 4) := by
    ext z
    simp only [mem_inter_iff, mem_union, mem_setOf_eq, mem_petalSet_zero, lt_abs, one_mul, neg_one_mul]
    tauto
  rw [heq]
  exact h3

/-- `0` is in the closure of each of the three sets. -/
theorem zero_mem_closure_petalSet (i : Fin 3) : (0 : ℂ) ∈ closure (petalSet i) := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · refine mem_closure_of_forall_add_ofReal_mul_mem (d := I) one_pos fun s hs _ => mem_petalSet_zero.mpr (Or.inl ?_)
    simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
      Complex.zero_re, Complex.zero_im, Complex.I_re, Complex.I_im, mul_zero, mul_one, sub_self, zero_add, add_zero,
      zero_mul, abs_zero]
    exact abs_pos.mpr hs.ne'
  · refine mem_closure_of_forall_add_ofReal_mul_mem (d := 1) (r := 1 / 8) (by norm_num) fun s hs hs' =>
      mem_petalSet_one.mpr ?_
    simp only [zero_add, mul_one, Complex.ofReal_re, Complex.ofReal_im, abs_zero]
    exact ⟨hs, hs'⟩
  · refine mem_closure_of_forall_add_ofReal_mul_mem (d := -1) (r := 1 / 8) (by norm_num) fun s hs hs' =>
      mem_petalSet_two.mpr ?_
    simp only [zero_add, mul_neg, mul_one, Complex.neg_re, Complex.neg_im, Complex.ofReal_re, Complex.ofReal_im,
      neg_zero, abs_zero, neg_neg]
    exact ⟨hs, hs'⟩

/-- The disc of radius `1/4` about `0` is the union of the two petals and the sea up to a null set: what is left
lies on the four lines `re = ± im` and `re = ± 1/8`. -/
theorem volume_ball_diff_iUnion_petalSet :
    volume (ball (0 : ℂ) (1 / 4) \ ⋃ i, petalSet i ∩ ball (0 : ℂ) (1 / 4)) = 0 := by
  refine measure_mono_null (fun z hz => ?_) (measure_union_null (measure_union_null (measure_union_null
    (volume_setOf_re_im_eq (a := 1) (b := -1) (Or.inl one_ne_zero) 0)
    (volume_setOf_re_im_eq (a := 1) (b := 1) (Or.inl one_ne_zero) 0))
    (volume_setOf_re_im_eq (a := 1) (b := 0) (Or.inl one_ne_zero) (1 / 8)))
    (volume_setOf_re_im_eq (a := 1) (b := 0) (Or.inl one_ne_zero) (-(1 / 8))))
  obtain ⟨hzb, hzn⟩ := hz
  have hn : ∀ i, z ∉ petalSet i := fun i hi => hzn (mem_iUnion.mpr ⟨i, hi, hzb⟩)
  have h0 := hn 0
  have h1 := hn 1
  have h2 := hn 2
  rw [mem_petalSet_zero, not_or, not_lt, not_lt] at h0
  rw [mem_petalSet_one] at h1
  rw [mem_petalSet_two] at h2
  obtain ⟨h0a, h0b⟩ := h0
  by_contra hcon
  simp only [mem_union, mem_setOf_eq, not_or] at hcon
  obtain ⟨⟨⟨c1, c2⟩, c3⟩, c4⟩ := hcon
  have d1 : z.re ≠ z.im := fun h => c1 (by rw [h]; ring)
  have d2 : z.re ≠ -z.im := fun h => c2 (by rw [h]; ring)
  have d3 : z.re ≠ 1 / 8 := fun h => c3 (by rw [h]; ring)
  have d4 : z.re ≠ -(1 / 8) := fun h => c4 (by rw [h]; ring)
  rcases lt_trichotomy z.re 0 with hre | hre | hre
  · -- left of the axis: in the left petal
    rw [abs_of_neg hre] at h0a h0b
    refine h2 ⟨?_, lt_of_le_of_ne h0b fun h => d4 (by linarith)⟩
    rcases abs_cases z.im with ⟨hi, -⟩ | ⟨hi, -⟩
    · rw [hi] at h0a ⊢
      exact lt_of_le_of_ne h0a fun h => d2 (by linarith)
    · rw [hi] at h0a ⊢
      exact lt_of_le_of_ne h0a fun h => d1 (by linarith)
  · rw [hre, abs_zero] at h0a
    exact d1 (by rw [hre, abs_eq_zero.mp (le_antisymm h0a (abs_nonneg _))])
  · -- right of the axis: in the right petal
    rw [abs_of_pos hre] at h0a h0b
    refine h1 ⟨?_, lt_of_le_of_ne h0b d3⟩
    rcases abs_cases z.im with ⟨hi, -⟩ | ⟨hi, -⟩
    · rw [hi] at h0a ⊢
      exact lt_of_le_of_ne h0a fun h => d1 (by linarith)
    · rw [hi] at h0a ⊢
      exact lt_of_le_of_ne h0a fun h => d2 (by linarith)

/-- **A three-piece point by the letter**: two petals at `0` and the sea, in the disc of radius `1/4`. The sea is
connected: its upper and lower wedges `|Re z| < ± Im z` meet its right and left caps `1/8 < ± Re z` inside the
disc. -/
noncomputable def petalPoint : ThreePiece (ball (0 : ℂ) (1 / 4)) petalCol 0 where
  nbhd := ball 0 (1 / 4)
  piece i := petalSet i ∩ ball 0 (1 / 4)
  label i := i
  nbhd_mem := by exact ball_mem_nhds 0 (by norm_num)
  nbhd_subset := by exact Subset.rfl
  piece_subset := by exact fun _ => inter_subset_right
  isOpen_piece := by exact fun i => (isOpen_petalSet i).inter isOpen_ball
  isPreconnected_piece := by
    intro i
    rcases fin_three_cases i with rfl | rfl | rfl
    · exact isPreconnected_petalSea
    · exact (convex_petalSet_one.inter (convex_ball 0 (1 / 4))).isPreconnected
    · exact (convex_petalSet_two.inter (convex_ball 0 (1 / 4))).isPreconnected
  mem_closure_piece := by
    exact fun i => mem_closure_inter_ball (mem_ball_self (by norm_num)) (zero_mem_closure_petalSet i)
  ae_label := by exact fun i => Filter.Eventually.of_forall fun z hz => petalCol_of_mem hz.1
  label_injective := by exact fun _ _ h => h
  null_diff := by exact volume_ball_diff_iUnion_petalSet

/-- The closures of the two petals meet at `0` only: the edge of the pieces `1` and `2` is the point. -/
theorem petalPoint_edge : petalPoint.edge 1 2 = {0} := by
  refine Subset.antisymm ?_ (singleton_subset_iff.mpr (petalPoint.mem_edge 1 2))
  rintro z ⟨⟨h1, h2⟩, -⟩
  have hc1 : IsClosed {z : ℂ | |z.im| ≤ z.re} := isClosed_le Complex.continuous_im.abs Complex.continuous_re
  have hc2 : IsClosed {z : ℂ | |z.im| ≤ -z.re} := isClosed_le Complex.continuous_im.abs Complex.continuous_re.neg
  have h1' : |z.im| ≤ z.re := closure_minimal (fun y hy => (mem_petalSet_one.mp hy.1).1.le) hc1 h1
  have h2' : |z.im| ≤ -z.re := closure_minimal (fun y hy => (mem_petalSet_two.mp hy.1).1.le) hc2 h2
  have h0 := abs_nonneg z.im
  have hre : z.re = 0 := by linarith
  have him : z.im = 0 := abs_eq_zero.mp (le_antisymm (by linarith) h0)
  exact mem_singleton_iff.mpr (Complex.ext (by simpa using hre) (by simpa using him))

/-- **A three-piece point by the letter is not full.** -/
theorem petalPoint_not_isFull : ¬ petalPoint.IsFull := by
  intro h
  have h12 := h 1 2 (by decide)
  rw [petalPoint_edge, diff_self, closure_empty] at h12
  exact h12

/-! ## Spec examples -/

/-- Both models are three-piece points of weak colourings. -/
example : IsThreePiecePoint (ball (0 : ℂ) (1 / 4)) sectorCol 0 ∧ IsThreePiecePoint (ball (0 : ℂ) (1 / 4)) petalCol 0 :=
  ⟨⟨sectorPoint⟩, ⟨petalPoint⟩⟩

/-- The sector point's pieces at the unit point `w = −i` of `0`: the first quadrant is outer (it lies above the real
axis, and the disc about `−i` below it). -/
example : OuterAt (sectorPoint.piece 0) (-I) := by
  refine Set.disjoint_left.mpr fun z hz hb => ?_
  have hz2 : 0 < z.im := (mem_sectorSet_zero.mp hz.1).2
  have h1 := Complex.abs_im_le_norm (z - -I)
  rw [mem_ball, dist_eq_norm] at hb
  have h2 : (z - -I).im = z.im + 1 := by simp
  rw [h2, abs_of_pos (by linarith)] at h1
  linarith

/-- The sector point's piece `2`, between the rays along `−1 − i` and `1`, is crossing at `w = −i`: it holds the
start of the ray along `−i`, inside the unit circle about `−i`, and points near the ray along `1`, outside it. -/
example : CrossingAt (sectorPoint.piece 2) (-I) := by
  rw [crossingAt_iff]
  have hsq : ∀ a b : ℝ, ‖(⟨a, b⟩ : ℂ) - -I‖ ^ 2 = a ^ 2 + (b + 1) ^ 2 := fun a b => by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp
    ring
  constructor
  · -- the point `−i/8`
    refine ⟨⟨0, -(1 / 8)⟩, ⟨mem_sectorSet_two.mpr ⟨by show (-(1 / 8) : ℝ) < 0; norm_num,
      by show (-(1 / 8) : ℝ) < 0; norm_num⟩, mem_ball_zero_of_sq_lt (by norm_num) (by norm_num)⟩, ?_⟩
    rw [dist_eq_norm]
    have h := hsq 0 (-(1 / 8))
    have h0 := norm_nonneg ((⟨0, -(1 / 8)⟩ : ℂ) - -I)
    nlinarith
  · -- the point `1/5 − i/100`
    refine ⟨⟨1 / 5, -(1 / 100)⟩, ⟨mem_sectorSet_two.mpr ⟨by show (-(1 / 100) : ℝ) < 0; norm_num,
      by show (-(1 / 100) : ℝ) < 1 / 5; norm_num⟩, mem_ball_zero_of_sq_lt (by norm_num) (by norm_num)⟩, ?_⟩
    rw [dist_eq_norm]
    have h := hsq (1 / 5) (-(1 / 100))
    have h0 := norm_nonneg ((⟨1 / 5, -(1 / 100)⟩ : ℂ) - -I)
    nlinarith

/-- **Adversary** for `HasUnitArcFrom`: a single point holds no arc of the unit circle about `0` from `1`. -/
example : ¬ HasUnitArcFrom ({1} : Set ℂ) 0 1 := by
  intro h
  have h1 := h.mem_closure_diff one_ne_zero
  rw [diff_self, closure_empty] at h1
  exact h1

/-- The unit circle about `0` holds an arc from `1`. -/
example : HasUnitArcFrom (sphere (0 : ℂ) 1) 0 1 := by
  refine ⟨1, Or.inl rfl, 1, one_pos, fun t _ => ?_⟩
  rw [mem_sphere, dist_zero_right, zero_add, sub_zero, one_mul, norm_e]

end HadwigerNelson.Plane
