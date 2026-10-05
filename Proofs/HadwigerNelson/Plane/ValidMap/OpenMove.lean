import Proofs.HadwigerNelson.Plane.ValidMap.Contact

/-!
# OPEN at a point: the one-sector wedge-opening (FS131-E6-OPEN; FS131-IO1)

The fifth local move of the terminal procedure (inventory items 382–385; derivation `plans/FS131-E6-derivation.md` § 4.2, E6-OPEN;
record `plans/FS131-IO-implementation.md`). At a lone horn of a colour `c` whose allowed cone `D_c(v)` has non-empty interior,
recolouring with `c` a thin wedge beside the horn, on a side where `D_c(v)` has interior directions, gives a valid map equal to `F`
off a small disc about `v`, creating no unit arc, in which `v` gains no colour, its degree does not rise and it has one horn fewer.
SHAVE cannot take such a horn when its only admissible split is a unit circle (FS131-E6-OCCURS); OPEN can.

* **The horn count** (`HasHornCount`): for every small radius, exactly `j` of the sectors at `v` are horn sets. A horn set's cone at
  `v` is one direction (`e_eq_of_mem_coneAt_hornSet`), so a sector whose cone has interior directions is never one
  (`ne_hornSet_of_interior_coneAt`).
* **The configuration** (`Near.OpenConfig`, `Near.exists_openConfig`): the horn `idx s (hornPos up b)`, the swallowed horns
  between it and the first sector of positive angle `idx s (rayPos up b)` on the side `up` (`σ = +1`) or `¬ up` (`σ = −1`), the
  new ray's direction `ψ` strictly inside that sector, and a radius `ρc` below which the ray stays inside it and every point
  between the horn and the ray is clear for `c` (`cone_side`, `clear_near_end`, as E6-OPEN's steps 1–4).
* **The map** (`BranchGerms.openWedge`, `openCol`, `openRay`, `openRim`, `openArcs`): MERGE's arcs and colouring for the gap
  `s, 0, b` (`mergeArcs`, `mergeCol`), with the wedge of the partial sector between its gap germ and the ray recoloured `c`, the
  ray out to `ρ/2` and the rim arc at `ρ/2` across the wedge added (E6-OPEN's step 5, route (a)).
* **The clauses** (`Near.open_*`) and the assembly `ArcMap.exists_open`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The horn count -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **`v` has exactly `j` horns**: for every small radius, exactly `j` of its sectors are horn sets. -/
def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
  ∀ᶠ r in 𝓝[>] (0 : ℝ), {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard = j

variable {F}

/-- The horn count is unique. -/
theorem HasHornCount.eq {v : ℂ} {j j' : ℕ} (hj : F.HasHornCount v j) (hj' : F.HasHornCount v j') : j = j' := by
  obtain ⟨r, hr⟩ := (hj.and hj').exists
  exact_mod_cast hr.1.symm.trans hr.2

/-- The degree is unique. -/
theorem HasDegree.eq {v : ℂ} {m m' : ℕ} (hm : F.HasDegree v m) (hm' : F.HasDegree v m') : m = m' := by
  obtain ⟨r, hr⟩ := (hm.and hm').exists
  exact_mod_cast hr.1.symm.trans hr.2

end ArcMap

/-- **A set approaching `v` along an open interval of directions is no horn set** (a horn set's directions at `v` are one,
`e_eq_of_mem_coneAt_hornSet`). -/
theorem ne_hornSet_of_interior_coneAt {S : Set ℂ} {v : ℂ} (hS : (interior (coneAt S v)).Nonempty) (α κ₁ κ₂ r : ℝ) :
    S ≠ hornSet v α κ₁ κ₂ r := by
  rintro rfl
  obtain ⟨β₀, hβ₀⟩ := hS
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior β₀ hβ₀
  have hπ := Real.pi_pos
  set δ := min ε π / 2 with hδ
  have hδ0 : 0 < δ := by positivity
  have hδε : δ < ε := by have := min_le_left ε π; linarith
  have hδπ : δ < π := by have := min_le_right ε π; linarith
  have h1 : e β₀ = e α := e_eq_of_mem_coneAt_hornSet (interior_subset hβ₀)
  have h2 : e (β₀ + δ) = e α := e_eq_of_mem_coneAt_hornSet (interior_subset (hball (by
    rw [mem_ball, Real.dist_eq, show β₀ + δ - β₀ = δ by ring, abs_of_pos hδ0]; exact hδε)))
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp (h2.trans h1.symm)
  have hm' : δ = m * (2 * π) := by linarith
  rcases lt_trichotomy m 0 with h | h | h
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt h
    nlinarith
  · rw [h] at hm'; simp at hm'; linarith
  · have : (1 : ℝ) ≤ m := by exact_mod_cast h
    nlinarith

-- spec examples for `HasHornCount`

/-- The constant map of the plane has no horn at any point: its one sector is the ball, which is no horn set. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).HasHornCount 0 0 := by
  filter_upwards [self_mem_nhdsWithin] with r (hr : 0 < r)
  have hI : (ArcMap.const univ isOpen_univ j).interiorPts ∩ ball 0 r = ball 0 r := by
    rw [ArcMap.const_interiorPts, univ_inter]
  have hsec : ∀ S, (ArcMap.const univ isOpen_univ j).IsSector 0 r S → S = ball 0 r := by
    rintro S ⟨x, hx, rfl, -⟩
    rw [hI] at hx ⊢
    exact (convex_ball (0 : ℂ) r).isPreconnected.connectedComponentIn hx
  have hempty : {S | (ArcMap.const univ isOpen_univ j).IsSector 0 r S ∧
      ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet 0 α κ₁ κ₂ r} = ∅ := by
    ext S
    simp only [mem_setOf_eq, mem_empty_iff_false, iff_false, not_and, not_exists]
    intro hS α κ₁ κ₂ _ hSh
    have hball := hsec S hS
    -- the point `−(r/2) e α` is in the ball but behind the horn's axis
    have hz : -(((r / 2 : ℝ) : ℂ) * e α) ∈ ball (0 : ℂ) r := by
      rw [mem_ball, dist_zero_right, norm_neg, norm_mul_e (by linarith)]; linarith
    rw [← hball, hSh] at hz
    have hx := hz.2.1
    simp only [frameX, sub_zero, neg_mul, Complex.neg_re, mul_assoc] at hx
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e] at hx
    simp at hx; linarith
  rw [hempty, encard_empty]; rfl

/-! ## OPEN's map: the wedge, the ray, the rim arc, the colouring -/

/-- **The new ray** out to `ρ/2` at the direction `ψ`. -/
noncomputable def openRay (v : ℂ) (ψ ρ : ℝ) : Arc := .seg v (v + ((ρ / 2 : ℝ) : ℂ) * e ψ)

namespace BranchGerms

/-- The horn's position along the orbit: `0` when the wedge opens on the side `σ = +1` (`up`), `b` when on `σ = −1`. -/
def hornPos (up : Bool) (b : ℕ) : ℕ := if up then 0 else b

/-- The partial sector's position along the orbit: `b` for `up`, `0` otherwise. -/
def rayPos (up : Bool) (b : ℕ) : ℕ := if up then b else 0

variable {n : ℕ} (G : BranchGerms n)

/-- **The wedge** out to `ρ/2`: the part of the partial sector between its gap germ and the ray — for `up`, between germ
`idx s b` and the ray at `ψ`; otherwise between the ray and germ `idx s 1`. -/
def openWedge (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Set ℂ :=
  if up then sectorBetween v (G.lift s b) (G.κ (idx s b)) ψ 0 (ρ / 2)
  else sectorBetween v ψ 0 (G.lift s 1) (G.κ (idx s 1)) (ρ / 2)

/-- **OPEN's colouring**: `c` on the wedge, MERGE's colouring for the gap `s, 0, b` elsewhere (`c` on the gap out to `ρ/2`, the
colour after the germ on a branch out to `ρ`, `Fcol` elsewhere). -/
noncomputable def openCol {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (Fcol : ℂ → Fin k) (up : Bool) (s : Fin n) (b : ℕ)
    (ψ : ℝ) (c : Fin k) (ρ : ℝ) : ℂ → Fin k := fun z => by
  classical
  exact if z ∈ G.openWedge v up s b ψ ρ then c else G.mergeCol v col Fcol s 0 b c ρ z

/-- **The rim arc across the wedge**, at `ρ/2`: from germ `idx s b` to the ray for `up`, from the ray to germ `idx s 1`
otherwise. -/
noncomputable def openRim (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Arc :=
  if up then .circ v (ρ / 2) (G.liftDir s b (ρ / 2)) ψ else .circ v (ρ / 2) ψ (G.liftDir s 1 (ρ / 2))

/-- **The merged piece** out to `r` (FS131-IO2): the new `c`-sector, from the horn's outer germ to the ray — for `up`, between germ
`idx s 0` and the ray; otherwise between the ray and germ `idx s (b + 1)`. -/
def openPiece (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ r : ℝ) : Set ℂ :=
  if up then sectorBetween v (G.lift s 0) (G.κ (idx s 0)) ψ 0 r
  else sectorBetween v ψ 0 (G.lift s (b + 1)) (G.κ (idx s (b + 1))) r

/-- **The rest of the partial sector** out to `r`, beyond the ray: for `up`, between the ray and germ `idx s (b + 1)`; otherwise
between germ `idx s 0` and the ray. -/
def openRest (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ r : ℝ) : Set ℂ :=
  if up then sectorBetween v ψ 0 (G.lift s (b + 1)) (G.κ (idx s (b + 1))) r
  else sectorBetween v (G.lift s 0) (G.κ (idx s 0)) ψ 0 r

/-- **OPEN's new arcs**: MERGE's for the gap `s, 0, b` (the germs off the gap out to `ρ/2`, the non-phantom germs' pieces between
`ρ/2` and `ρ`, the rim arc across the gap's sectors), the ray, and the rim arc across the wedge. -/
noncomputable def openArcs {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Set Arc :=
  G.mergeArcs v col s 0 b ρ ∪ {openRay v ψ ρ, G.openRim v up s b ψ ρ}

/-- The wedge in lifted directions. -/
theorem mem_openWedge {v z : ℂ} {up : Bool} {s : Fin n} {b : ℕ} {ψ ρ : ℝ} :
    z ∈ G.openWedge v up s b ψ ρ ↔ ∃ t ∈ Ioo 0 (ρ / 2), ∃ φ, (if up then G.liftDir s b t < φ ∧ φ < ψ else
      ψ < φ ∧ φ < G.liftDir s 1 t) ∧ z = v + (t : ℂ) * e φ := by
  cases up <;>
  · simp only [openWedge, Bool.false_eq_true, if_true, if_false, sectorBetween, mem_setOf_eq, mem_Ioo, zero_mul, zero_div,
      Real.arcsin_zero, add_zero, liftDir, germDir]

/-- The merged piece in lifted directions. -/
theorem mem_openPiece {v z : ℂ} {up : Bool} {s : Fin n} {b : ℕ} {ψ r : ℝ} :
    z ∈ G.openPiece v up s b ψ r ↔ ∃ t ∈ Ioo 0 r, ∃ φ, (if up then G.liftDir s 0 t < φ ∧ φ < ψ else
      ψ < φ ∧ φ < G.liftDir s (b + 1) t) ∧ z = v + (t : ℂ) * e φ := by
  cases up <;>
  · simp only [openPiece, Bool.false_eq_true, if_true, if_false, sectorBetween, mem_setOf_eq, mem_Ioo, zero_mul, zero_div,
      Real.arcsin_zero, add_zero, liftDir, germDir]

/-- The rest of the partial sector in lifted directions. -/
theorem mem_openRest {v z : ℂ} {up : Bool} {s : Fin n} {b : ℕ} {ψ r : ℝ} :
    z ∈ G.openRest v up s b ψ r ↔ ∃ t ∈ Ioo 0 r, ∃ φ, (if up then ψ < φ ∧ φ < G.liftDir s (b + 1) t else
      G.liftDir s 0 t < φ ∧ φ < ψ) ∧ z = v + (t : ℂ) * e φ := by
  cases up <;>
  · simp only [openRest, Bool.false_eq_true, if_true, if_false, sectorBetween, mem_setOf_eq, mem_Ioo, zero_mul, zero_div,
      Real.arcsin_zero, add_zero, liftDir, germDir]

end BranchGerms

-- spec examples for OPEN's definitions
example : BranchGerms.hornPos true 3 = 0 ∧ BranchGerms.hornPos false 3 = 3 := ⟨rfl, rfl⟩
example : BranchGerms.rayPos true 3 = 3 ∧ BranchGerms.rayPos false 3 = 0 := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ ρ : ℝ) :
    G.openWedge v true s 2 ψ ρ = sectorBetween v (G.lift s 2) (G.κ (BranchGerms.idx s 2)) ψ 0 (ρ / 2) ∧
      G.openWedge v false s 2 ψ ρ = sectorBetween v ψ 0 (G.lift s 1) (G.κ (BranchGerms.idx s 1)) (ρ / 2) :=
  ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (Fcol : ℂ → Fin 2) (s : Fin 3) (ψ : ℝ) (c : Fin 2) (ρ : ℝ) (z : ℂ)
    (hz : z ∈ G.openWedge v true s 2 ψ ρ) : G.openCol v col Fcol true s 2 ψ c ρ z = c := by
  simp [BranchGerms.openCol, hz]
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (Fcol : ℂ → Fin 2) (s : Fin 3) (ψ : ℝ) (c : Fin 2) (ρ : ℝ) (z : ℂ)
    (hz : z ∉ G.openWedge v true s 2 ψ ρ) :
    G.openCol v col Fcol true s 2 ψ c ρ z = G.mergeCol v col Fcol s 0 2 c ρ z := by
  simp [BranchGerms.openCol, hz]
example (v : ℂ) (ψ ρ : ℝ) : openRay v ψ ρ = .seg v (v + ((ρ / 2 : ℝ) : ℂ) * e ψ) := rfl
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ r : ℝ) :
    G.openPiece v true s 2 ψ r = sectorBetween v (G.lift s 0) (G.κ (BranchGerms.idx s 0)) ψ 0 r ∧
      G.openPiece v false s 2 ψ r = sectorBetween v ψ 0 (G.lift s 3) (G.κ (BranchGerms.idx s 3)) r := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ r : ℝ) :
    G.openRest v true s 2 ψ r = sectorBetween v ψ 0 (G.lift s 3) (G.κ (BranchGerms.idx s 3)) r ∧
      G.openRest v false s 2 ψ r = sectorBetween v (G.lift s 0) (G.κ (BranchGerms.idx s 0)) ψ 0 r := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ ρ : ℝ) :
    G.openRim v true s 2 ψ ρ = .circ v (ρ / 2) (G.liftDir s 2 (ρ / 2)) ψ ∧
      G.openRim v false s 2 ψ ρ = .circ v (ρ / 2) ψ (G.liftDir s 1 (ρ / 2)) := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (s : Fin 3) (ψ ρ : ℝ) :
    openRay v ψ ρ ∈ G.openArcs v col true s 2 ψ ρ ∧ G.openRim v true s 2 ψ ρ ∈ G.openArcs v col true s 2 ψ ρ ∧
      G.rimArc v s 0 2 ρ ∈ G.openArcs v col true s 2 ψ ρ :=
  ⟨Or.inr (Or.inl rfl), Or.inr (Or.inr rfl), Or.inl (Or.inr ⟨by omega, rfl⟩)⟩

/-! ## The configuration: the side, the gap, the ray, the clear radius -/

/-- A uniform bound on `arcsin (κ t / 2)` for small `t` and bounded `κ`. -/
theorem exists_small_arcsin (K : ℝ) {d : ℝ} (hd : 0 < d) :
    ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ κ, |κ| ≤ K → |Real.arcsin (κ * t / 2)| < d := by
  obtain ⟨η, hη, harc⟩ := exists_abs_arcsin_lt hd
  refine ⟨η / (|K| + 1), by positivity, fun t ht κ hκ => harc _ ?_⟩
  have hK1 : 0 < |K| + 1 := by positivity
  have ht' : t * (|K| + 1) < η := (lt_div_iff₀ hK1).mp ht.2
  rw [abs_div, abs_mul, abs_of_pos ht.1, abs_two]
  have h1 : |κ| * t ≤ |K| * t := mul_le_mul_of_nonneg_right (hκ.trans (le_abs_self K)) ht.1.le
  nlinarith [ht.1, abs_nonneg K]


namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ}

/-- **OPEN's configuration** at `v` (E6-OPEN's steps 1–4): along the orbit from `s`, the horn `idx s (hornPos up b)` (a cusp,
the only chart sector of colour `c`), the swallowed sectors strictly between `0` and `b`, and the partial sector
`idx s (rayPos up b)` with the ray's direction `ψ` strictly inside it below the radius `ρc`; below `ρc` every point between the
horn's inner germ and the ray (for `up`: from germ `idx s 1` up to `ψ`; otherwise from `ψ` up to germ `idx s b`) is clear for
`c`. -/
structure OpenConfig (X : F.Near v) (c : Fin k) (up : Bool) (s : Fin X.n) (b : ℕ) (ψ ρc : ℝ) : Prop where
  /-- The gap has a germ. -/
  hb1 : 1 ≤ b
  /-- The gap stays within one turn. -/
  hbn : b < X.n
  /-- The clear radius is positive. -/
  hρc : 0 < ρc
  /-- The clear radius is below the ordered radius. -/
  hρcs : ρc ≤ X.s₀
  /-- The horn is a cusp. -/
  cusp : X.G.lift s (BranchGerms.hornPos up b) = X.G.lift s (BranchGerms.hornPos up b + 1)
  /-- The horn has the colour `c`. -/
  col_horn : X.col (BranchGerms.idx s (BranchGerms.hornPos up b)) = c
  /-- It is the only chart sector of colour `c`. -/
  lone : ∀ i, X.col i = c → i = BranchGerms.idx s (BranchGerms.hornPos up b)
  /-- Below `ρc` the ray lies strictly inside the partial sector. -/
  ray : ∀ t ∈ Ioo 0 ρc, X.G.liftDir s (BranchGerms.rayPos up b) t < ψ ∧
    ψ < X.G.liftDir s (BranchGerms.rayPos up b + 1) t
  /-- Below `ρc` every point between the horn's inner germ and the ray is clear for `c`. -/
  clear : ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then X.G.liftDir s 1 t else ψ) ≤ φ →
    φ ≤ (if up then ψ else X.G.liftDir s b t) → F.IsClear c (v + (t : ℂ) * e φ)
  /-- Below `ρc` the clear range reaches past the ray by a margin (so every point of the ray has a clear neighbourhood; FS131-IO2,
  inventory item 393: without it `open_allowedCone` fails when the clear range ends exactly at the ray). -/
  margin : ∃ η > 0, ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then ψ else ψ - η) ≤ φ → φ ≤ (if up then ψ + η else ψ) →
    F.IsClear c (v + (t : ℂ) * e φ)

/-- The colour of a chart sector is carried at `v`. -/
theorem col_mem_coloursAt (X : F.Near v) (i : Fin X.n) : X.col i ∈ F.coloursAt v :=
  closure_mono (X.hcol₀ i) (X.hC.mem_closure_sector X.hs₀ i)

/-- **OPEN's configuration on the side `σ = +1`**: from a lone cusp `p` of colour `c` whose direction is interior to `D_c(v)`
or has a direction of `D_c(v)` on its `+1` side. -/
theorem exists_openConfig_up (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {c : Fin k} {p : Fin X.n}
    (hcusp : X.G.nextβ p = X.G.β p) (hcp : X.col p = c) (hlone : ∀ i, X.col i = c → i = p)
    (hK : e (X.G.β p) ∈ interior (F.allowedCone v c) ∨
      (e (X.G.β p) ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.β p + 1 * ψ) ∈ F.allowedCone v c)) :
    ∃ b ψ ρc, X.OpenConfig c true p b ψ ρc := by
  classical
  have hπ := Real.pi_pos
  have hc : c ∈ F.coloursAt v := hcp ▸ X.col_mem_coloursAt p
  have hM := X.hC.sorted.mono
  have hmono := X.G.lift_mono hM p
  have hl0 : X.G.lift p 0 = X.G.β p := X.G.lift_zero p
  have hl01 : X.G.lift p 1 = X.G.lift p 0 := by
    rw [X.G.lift_succ p 0, BranchGerms.idx_zero, hcusp, sub_self, add_zero]
  -- a sector of positive angle after the horn
  have hex : ∃ m, 1 ≤ m ∧ m < X.n ∧ X.G.lift p m < X.G.lift p (m + 1) := by
    by_contra hne
    push Not at hne
    have hall : ∀ m, 1 ≤ m → m ≤ X.n → X.G.lift p m = X.G.lift p 1 := by
      intro m hm1 hmn
      induction m with
      | zero => omega
      | succ m ih =>
        rcases Nat.eq_zero_or_pos m with rfl | hm0
        · rfl
        · rw [← ih hm0 (by omega)]
          exact (le_antisymm (hne m hm0 (by omega)) (hmono (Nat.le_succ m))).symm.symm
    have h1 := hall X.n (by have := p.pos; omega) le_rfl
    have h2 : X.G.lift p (0 + X.n) = X.G.lift p 0 + 2 * π := X.G.lift_add_n p 0
    rw [zero_add] at h2
    linarith
  set b := Nat.find hex with hbdef
  obtain ⟨hb1, hbn, hjump⟩ := Nat.find_spec hex
  have hcusps : ∀ m, 1 ≤ m → m < b → X.G.lift p m = X.G.lift p (m + 1) := fun m hm1 hmb =>
    le_antisymm (hmono (Nat.le_succ m)) (not_lt.mp fun hlt => Nat.find_min hex hmb ⟨hm1, by omega, hlt⟩)
  have hlb : ∀ m, 1 ≤ m → m ≤ b → X.G.lift p m = X.G.lift p 1 := by
    intro m hm1 hmb
    induction m with
    | zero => omega
    | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm0
      · rfl
      · rw [← ih hm0 (by omega)]; exact (hcusps m hm0 (by omega)).symm
  have hlb' : X.G.lift p b = X.G.lift p 1 := hlb b hb1 le_rfl
  -- the clear wedge at the horn's upper germ
  have hca : X.col (BranchGerms.idx p 0) = c := by rw [BranchGerms.idx_zero]; exact hcp
  have hθ : X.G.lift p (0 + 1) = X.G.β p := by rw [zero_add, hl01, hl0]
  have hK' : e (X.G.lift p (0 + 1)) ∈ interior (F.allowedCone v c) ∨
      (e (X.G.lift p (0 + 1)) ∈ F.allowedCone v c ∧
        ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.lift p (0 + 1) + 1 * ψ) ∈ F.allowedCone v c) := by
    rw [hθ]; exact hK
  obtain ⟨ε, hε, ρ₁, hρ₁, hcl⟩ := clear_near_end hF hv hc (Or.inl rfl) hK' (X.base_before hca)
  simp only [zero_add] at hcl
  set gap := X.G.lift p (b + 1) - X.G.lift p b with hgap
  have hgap0 : 0 < gap := by rw [hgap]; linarith
  set ψ₁ := min ε gap / 2 with hψ₁
  have hψ₁0 : 0 < ψ₁ := by positivity
  have hψ₁ε : ψ₁ ≤ ε / 2 := by have := min_le_left ε gap; rw [hψ₁]; linarith
  have hψ₁g : ψ₁ ≤ gap / 2 := by have := min_le_right ε gap; rw [hψ₁]; linarith
  set Kb := |X.G.κ (BranchGerms.idx p 1)| + |X.G.κ (BranchGerms.idx p b)| + |X.G.κ (BranchGerms.idx p (b + 1))|
  obtain ⟨ρa, hρa, harc⟩ := exists_small_arcsin Kb hψ₁0
  have hK1 : |X.G.κ (BranchGerms.idx p 1)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx p b)); have := abs_nonneg (X.G.κ (BranchGerms.idx p (b + 1))); linarith
  have hKb : |X.G.κ (BranchGerms.idx p b)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx p 1)); have := abs_nonneg (X.G.κ (BranchGerms.idx p (b + 1))); linarith
  have hKb1 : |X.G.κ (BranchGerms.idx p (b + 1))| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx p 1)); have := abs_nonneg (X.G.κ (BranchGerms.idx p b)); linarith
  set ρc := min (min ρ₁ X.s₀) ρa with hρcdef
  have hρc0 : 0 < ρc := lt_min (lt_min hρ₁ X.hs₀.1) hρa
  have hρc1 : ρc ≤ ρ₁ := (min_le_left _ _).trans (min_le_left _ _)
  have hρcs : ρc ≤ X.s₀ := (min_le_left _ _).trans (min_le_right _ _)
  have hρca : ρc ≤ ρa := min_le_right _ _
  refine ⟨b, X.G.lift p b + ψ₁, ρc, ⟨hb1, hbn, hρc0, hρcs, ?_, ?_, ?_, ?_, ?_, ?_⟩⟩
  · show X.G.lift p 0 = X.G.lift p (0 + 1)
    rw [zero_add, hl01]
  · show X.col (BranchGerms.idx p 0) = c
    exact hca
  · intro i hi
    show i = BranchGerms.idx p 0
    rw [BranchGerms.idx_zero]; exact hlone i hi
  · intro t ht
    show X.G.liftDir p b t < X.G.lift p b + ψ₁ ∧ X.G.lift p b + ψ₁ < X.G.liftDir p (b + 1) t
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h1 := harc t hta _ hKb
    have h2 := harc t hta _ hKb1
    unfold BranchGerms.liftDir germDir
    constructor
    · linarith [(abs_lt.mp h1).2]
    · linarith [(abs_lt.mp h2).1]
  · intro t ht φ hφ1 hφ2
    simp only [if_true] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h1 := harc t hta _ hK1
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir p 1 t = germDir (X.G.lift p 1) (X.G.κ (BranchGerms.idx p 1)) t := rfl
      linarith
    · have hφ1' : X.G.lift p 1 - ψ₁ < φ := by
        have : X.G.liftDir p 1 t = X.G.lift p 1 + Real.arcsin (X.G.κ (BranchGerms.idx p 1) * t / 2) := rfl
        linarith [(abs_lt.mp h1).1]
      rw [abs_le]; constructor <;> linarith
  · refine ⟨ψ₁, hψ₁0, fun t ht φ hφ1 hφ2 => ?_⟩
    simp only [if_true] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h1 := harc t hta _ hK1
    have hdir : X.G.liftDir p 1 t = X.G.lift p 1 + Real.arcsin (X.G.κ (BranchGerms.idx p 1) * t / 2) := rfl
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir p 1 t = germDir (X.G.lift p 1) (X.G.κ (BranchGerms.idx p 1)) t := rfl
      linarith [(abs_lt.mp h1).2]
    · rw [abs_le]; constructor <;> linarith


/-! ### Re-basing the orbit -/

theorem _root_.HadwigerNelson.Plane.BranchGerms.idx_idx {n : ℕ} (p : Fin n) (a m : ℕ) :
    BranchGerms.idx (BranchGerms.idx p a) m = BranchGerms.idx p (a + m) := by
  apply Fin.ext
  show ((p.val + a) % n + m) % n = (p.val + (a + m)) % n
  rw [Nat.mod_add_mod, Nat.add_assoc]

theorem _root_.HadwigerNelson.Plane.BranchGerms.turns_idx {n : ℕ} (p : Fin n) (a m : ℕ) :
    BranchGerms.turns (BranchGerms.idx p a) m + (p.val + a) / n = BranchGerms.turns p (a + m) := by
  have hn : 0 < n := p.pos
  show ((p.val + a) % n + m) / n + (p.val + a) / n = (p.val + (a + m)) / n
  have h := Nat.div_add_mod (p.val + a) n
  have : p.val + (a + m) = ((p.val + a) % n + m) + n * ((p.val + a) / n) := by omega
  rw [this, Nat.add_mul_div_left _ _ hn]

theorem _root_.HadwigerNelson.Plane.BranchGerms.liftDir_idx {n : ℕ} (G : BranchGerms n) (p : Fin n) (a m : ℕ) (t : ℝ) :
    G.liftDir (BranchGerms.idx p a) m t = G.liftDir p (a + m) t - 2 * π * (((p.val + a) / n : ℕ) : ℝ) := by
  have h := BranchGerms.turns_idx p a m
  unfold BranchGerms.liftDir BranchGerms.lift germDir
  rw [BranchGerms.idx_idx, ← h]
  push_cast; ring

theorem _root_.HadwigerNelson.Plane.BranchGerms.lift_idx {n : ℕ} (G : BranchGerms n) (p : Fin n) (a m : ℕ) :
    G.lift (BranchGerms.idx p a) m = G.lift p (a + m) - 2 * π * (((p.val + a) / n : ℕ) : ℝ) := by
  have h := G.liftDir_idx p a m 0
  simpa [BranchGerms.liftDir, germDir] using h

/-- **OPEN's configuration on the side `σ = −1`**: from a lone cusp `p` of colour `c` with a direction of `D_c(v)` on its `−1`
side; the orbit starts at the first sector of positive angle before `p`. -/
theorem exists_openConfig_down (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {c : Fin k} {p : Fin X.n}
    (hcusp : X.G.nextβ p = X.G.β p) (hcp : X.col p = c) (hlone : ∀ i, X.col i = c → i = p)
    (hK : e (X.G.β p) ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.β p + -1 * ψ) ∈ F.allowedCone v c) :
    ∃ s b ψ ρc, X.OpenConfig c false s b ψ ρc := by
  classical
  have hπ := Real.pi_pos
  have hc : c ∈ F.coloursAt v := hcp ▸ X.col_mem_coloursAt p
  have hM := X.hC.sorted.mono
  have hmono := X.G.lift_mono hM p
  have hl01 : X.G.lift p 1 = X.G.lift p 0 := by
    rw [X.G.lift_succ p 0, BranchGerms.idx_zero, hcusp, sub_self, add_zero]
  have hpn := p.pos
  -- a sector of positive angle before the horn
  have hex : ∃ m, 1 ≤ m ∧ m < X.n ∧ X.G.lift p (X.n - m) < X.G.lift p (X.n - m + 1) := by
    by_contra hne
    push Not at hne
    have hstep : ∀ j, 1 ≤ j → j < X.n → X.G.lift p (j + 1) = X.G.lift p j := fun j hj1 hjn => by
      have := hne (X.n - j) (by omega) (by omega)
      rw [show X.n - (X.n - j) = j by omega] at this
      exact le_antisymm this (hmono (Nat.le_succ j))
    have hall : ∀ m, 1 ≤ m → m ≤ X.n → X.G.lift p m = X.G.lift p 1 := by
      intro m hm1 hmn
      induction m with
      | zero => omega
      | succ m ih =>
        rcases Nat.eq_zero_or_pos m with rfl | hm0
        · rfl
        · rw [hstep m hm0 (by omega)]; exact ih hm0 (by omega)
    have h1 := hall X.n (by omega) le_rfl
    have h2 : X.G.lift p (0 + X.n) = X.G.lift p 0 + 2 * π := X.G.lift_add_n p 0
    rw [zero_add] at h2
    linarith
  set b := Nat.find hex with hbdef
  obtain ⟨hb1, hbn, hjump⟩ := Nat.find_spec hex
  have hcusps : ∀ m, 1 ≤ m → m < b → X.G.lift p (X.n - m + 1) = X.G.lift p (X.n - m) := fun m hm1 hmb =>
    le_antisymm (not_lt.mp fun hlt => Nat.find_min hex hmb ⟨hm1, by omega, hlt⟩) (hmono (Nat.le_succ _))
  set s := BranchGerms.idx p (X.n - b) with hs
  set C : ℝ := 2 * π * (((p.val + (X.n - b)) / X.n : ℕ) : ℝ) with hC
  have hL : ∀ m, X.G.lift s m = X.G.lift p (X.n - b + m) - C := fun m => X.G.lift_idx p _ m
  have hLD : ∀ m t, X.G.liftDir s m t = X.G.liftDir p (X.n - b + m) t - C := fun m t => X.G.liftDir_idx p _ m t
  have hsb : BranchGerms.idx s b = p := by
    rw [hs, BranchGerms.idx_idx, show X.n - b + b = 0 + X.n by omega, BranchGerms.idx_add_n, BranchGerms.idx_zero]
  -- the lifted facts at `s`
  have hpos0 : X.G.lift s 0 < X.G.lift s 1 := by rw [hL, hL, add_zero]; linarith
  have hcusp_s : X.G.lift s b = X.G.lift s (b + 1) := by
    rw [hL, hL, show X.n - b + b = 0 + X.n by omega, show X.n - b + (b + 1) = 1 + X.n by omega, X.G.lift_add_n,
      X.G.lift_add_n, hl01]
  have hcusps_s : ∀ m, 1 ≤ m → m < b → X.G.lift s m = X.G.lift s (m + 1) := fun m hm1 hmb => by
    rw [hL, hL]
    have := hcusps (b - m) (by omega) (by omega)
    rw [show X.n - (b - m) = X.n - b + m by omega, show X.n - b + m + 1 = X.n - b + (m + 1) by omega] at this
    linarith
  have hl1b : ∀ m, 1 ≤ m → m ≤ b → X.G.lift s m = X.G.lift s 1 := by
    intro m hm1 hmb
    induction m with
    | zero => omega
    | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm0
      · rfl
      · rw [← ih hm0 (by omega)]; exact (hcusps_s m hm0 (by omega)).symm
  have hlb : X.G.lift s b = X.G.lift s 1 := hl1b b hb1 le_rfl
  -- the clear wedge at the horn's lower germ
  have hcb : X.col (BranchGerms.idx s b) = c := by rw [hsb]; exact hcp
  have he : e (X.G.lift s b) = e (X.G.β p) := by rw [X.G.e_lift, hsb]
  have hK' : e (X.G.lift s b) ∈ interior (F.allowedCone v c) ∨
      (e (X.G.lift s b) ∈ F.allowedCone v c ∧
        ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.lift s b + -1 * ψ) ∈ F.allowedCone v c) := by
    right
    obtain ⟨h1, ψ, hψ, hψπ, h2⟩ := hK
    refine ⟨he ▸ h1, ψ, hψ, hψπ, ?_⟩
    rw [e_add, he, ← e_add]; exact h2
  obtain ⟨ε, hε, ρ₁, hρ₁, hcl⟩ := clear_near_end hF hv hc (Or.inr rfl) hK' (X.base_after hcb)
  set gap := X.G.lift s 1 - X.G.lift s 0 with hgap
  have hgap0 : 0 < gap := by rw [hgap]; linarith
  set ψ₁ := min ε gap / 2 with hψ₁
  have hψ₁0 : 0 < ψ₁ := by positivity
  have hψ₁ε : ψ₁ ≤ ε / 2 := by have := min_le_left ε gap; rw [hψ₁]; linarith
  have hψ₁g : ψ₁ ≤ gap / 2 := by have := min_le_right ε gap; rw [hψ₁]; linarith
  set Kb := |X.G.κ (BranchGerms.idx s b)| + |X.G.κ (BranchGerms.idx s 0)| + |X.G.κ (BranchGerms.idx s 1)|
  obtain ⟨ρa, hρa, harc⟩ := exists_small_arcsin Kb hψ₁0
  have hKb : |X.G.κ (BranchGerms.idx s b)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx s 0)); have := abs_nonneg (X.G.κ (BranchGerms.idx s 1)); linarith
  have hK0 : |X.G.κ (BranchGerms.idx s 0)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx s b)); have := abs_nonneg (X.G.κ (BranchGerms.idx s 1)); linarith
  have hK1 : |X.G.κ (BranchGerms.idx s 1)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx s b)); have := abs_nonneg (X.G.κ (BranchGerms.idx s 0)); linarith
  set ρc := min (min ρ₁ X.s₀) ρa with hρcdef
  have hρc0 : 0 < ρc := lt_min (lt_min hρ₁ X.hs₀.1) hρa
  have hρc1 : ρc ≤ ρ₁ := (min_le_left _ _).trans (min_le_left _ _)
  have hρcs : ρc ≤ X.s₀ := (min_le_left _ _).trans (min_le_right _ _)
  have hρca : ρc ≤ ρa := min_le_right _ _
  have hlone' : ∀ i, X.col i = c → i = BranchGerms.idx s b := fun i hi => by rw [hsb]; exact hlone i hi
  refine ⟨s, b, X.G.lift s 1 - ψ₁, ρc, ⟨hb1, hbn, hρc0, hρcs, hcusp_s, hcb, hlone', ?_, ?_, ?_⟩⟩
  · intro t ht
    show X.G.liftDir s 0 t < X.G.lift s 1 - ψ₁ ∧ X.G.lift s 1 - ψ₁ < X.G.liftDir s (0 + 1) t
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h0 := harc t hta _ hK0
    have h1 := harc t hta _ hK1
    rw [zero_add]
    unfold BranchGerms.liftDir germDir
    constructor
    · linarith [(abs_lt.mp h0).2]
    · linarith [(abs_lt.mp h1).1]
  · intro t ht φ hφ1 hφ2
    simp only [Bool.false_eq_true, if_false] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have hb' := harc t hta _ hKb
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir s b t = germDir (X.G.lift s b) (X.G.κ (BranchGerms.idx s b)) t := rfl
      linarith
    · have hφ2' : φ < X.G.lift s b + ψ₁ := by
        have : X.G.liftDir s b t = X.G.lift s b + Real.arcsin (X.G.κ (BranchGerms.idx s b) * t / 2) := rfl
        linarith [(abs_lt.mp hb').2]
      rw [abs_le]; constructor <;> linarith
  · refine ⟨ψ₁, hψ₁0, fun t ht φ hφ1 hφ2 => ?_⟩
    simp only [Bool.false_eq_true, if_false] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have hb' := harc t hta _ hKb
    have hdir : X.G.liftDir s b t = X.G.lift s b + Real.arcsin (X.G.κ (BranchGerms.idx s b) * t / 2) := rfl
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir s b t = germDir (X.G.lift s b) (X.G.κ (BranchGerms.idx s b)) t := rfl
      linarith [(abs_lt.mp hb').1]
    · rw [abs_le]; constructor <;> linarith

/-- **OPEN's configuration exists** at a lone horn whose colour's allowed cone has interior (E6-OPEN's steps 1–4): the horn's
direction is allowed (N3-CONF), `cone_side` gives the side, the first sector of positive angle on that side is the partial
sector, and `clear_near_end` (N3-CLEAR with N3-UP's push) gives the clear wedge, inside which the ray is chosen. -/
theorem exists_openConfig (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ up s b ψ ρc, X.OpenConfig c up s b ψ ρc := by
  obtain ⟨p, -, hnβ, -, -, hcp, -⟩ := X.horn_index hH
  have hn0 : 0 < X.n := p.pos
  have hcnt := X.encard_col_eq hn0 h1
  have hlone : ∀ i, X.col i = c → i = p := by
    obtain ⟨x, hx⟩ := Set.encard_eq_one.mp (by exact_mod_cast hcnt)
    intro i hi
    have h1' : i ∈ ({x} : Set (Fin X.n)) := hx ▸ hi
    have h2' : p ∈ ({x} : Set (Fin X.n)) := hx ▸ hcp
    rw [mem_singleton_iff] at h1' h2'; rw [h1', h2']
  have hθ : e (X.G.β p) ∈ F.allowedCone v c :=
    e_mem_allowedCone_of_col hF hv hcp ⟨le_rfl, X.hC.sorted.mono p⟩
  have hadd : ∀ d ∈ F.allowedCone v c, ∀ d' ∈ F.allowedCone v c, d + d' ∈ F.allowedCone v c :=
    fun d hd d' hd' => add_mem_allowedCone hd hd'
  have hsmul : ∀ d ∈ F.allowedCone v c, ∀ t : ℝ, 0 ≤ t → (t : ℂ) * d ∈ F.allowedCone v c :=
    fun d hd t ht => smul_mem_allowedCone ht hd
  rcases cone_side hadd hsmul hD hθ with hint | ⟨σ, hσ, ψ, hψ, hψπ, hK⟩
  · obtain ⟨b, ψ, ρc, cfg⟩ := exists_openConfig_up hF hv X hnβ hcp hlone (Or.inl hint)
    exact ⟨true, p, b, ψ, ρc, cfg⟩
  · rcases hσ with rfl | rfl
    · obtain ⟨b, ψ, ρc, cfg⟩ := exists_openConfig_up hF hv X hnβ hcp hlone (Or.inr ⟨hθ, ψ, hψ, hψπ, hK⟩)
      exact ⟨true, p, b, ψ, ρc, cfg⟩
    · obtain ⟨s, b, ψ, ρc, cfg⟩ := exists_openConfig_down hF hv X hnβ hcp hlone ⟨hθ, ψ, hψ, hψπ, hK⟩
      exact ⟨false, s, b, ψ, ρc, cfg⟩

/-! ## OPEN's arcs -/

variable {X : F.Near v} {s : Fin X.n} {b : ℕ}

/-- The wedge lies in the ball of radius `ρ/2`. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.openWedge_subset_ball {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool)
    (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : G.openWedge v up s b ψ ρ ⊆ ball v (ρ / 2) := by
  unfold BranchGerms.openWedge
  split_ifs <;>
  · rintro z ⟨t, ht, φ, -, rfl⟩
    rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul_e ht.1.le]; exact ht.2

/-- The ray lies in the closed ball of radius `ρ/2`. -/
theorem openRay_subset_closedBall (v : ℂ) (ψ : ℝ) {ρ : ℝ} (hρ : 0 ≤ ρ) :
    (openRay v ψ ρ).carrier ⊆ closedBall v (ρ / 2) := by
  refine (convex_closedBall v (ρ / 2)).segment_subset (mem_closedBall_self (by linarith)) ?_
  rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul_e (by linarith)]

/-- The ray is non-degenerate. -/
theorem openRay_nondegenerate {v : ℂ} {ψ ρ : ℝ} (hρ : 0 < ρ) : (openRay v ψ ρ).Nondegenerate := by
  show v ≠ v + ((ρ / 2 : ℝ) : ℂ) * e ψ
  intro h
  have : ‖((ρ / 2 : ℝ) : ℂ) * e ψ‖ = 0 := by rw [← add_sub_cancel_left v (((ρ / 2 : ℝ) : ℂ) * e ψ), ← h, sub_self, norm_zero]
  rw [norm_mul_e (by linarith)] at this; linarith

/-- The rim arc across the wedge lies on the circle of radius `ρ/2`. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.openRim_subset_sphere {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool)
    (s : Fin n) (b : ℕ) (ψ : ℝ) {ρ : ℝ} (hρ : 0 ≤ ρ) : (G.openRim v up s b ψ ρ).carrier ⊆ sphere v (ρ / 2) := by
  unfold BranchGerms.openRim
  split_ifs <;>
  · rintro z ⟨θ, -, rfl⟩
    rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul_e (by linarith)]

/-- The rim arc across the wedge is non-degenerate: the ray lies strictly inside the partial sector, within one turn. -/
theorem openRim_nondegenerate {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ)
    (hρc : ρ ≤ ρc) : (X.G.openRim v up s b ψ ρ).Nondegenerate := by
  have hπ := Real.pi_pos
  have ht : ρ / 2 ∈ Ioo 0 ρc := ⟨by linarith [h.1], by linarith [h.1]⟩
  have hts : ρ / 2 ∈ Ioo 0 X.s₀ := ⟨by linarith [h.1], by linarith [h.1, h.2.1]⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  obtain ⟨hlo, hhi⟩ := cfg.ray (ρ / 2) ht
  have hb1 := cfg.hb1
  have hbn := cfg.hbn
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hlo hhi
    unfold BranchGerms.openRim
    simp only [Bool.false_eq_true, if_false]
    refine ⟨by linarith [h.1], hhi, ?_⟩
    have : X.G.liftDir s 1 (ρ / 2) ≤ X.G.liftDir s (0 + X.n) (ρ / 2) := hmono (show 1 ≤ 0 + X.n by omega)
    rw [X.G.liftDir_add_n] at this; linarith
  · simp only [BranchGerms.rayPos, if_true] at hlo hhi
    unfold BranchGerms.openRim
    simp only [if_true]
    refine ⟨by linarith [h.1], hlo, ?_⟩
    have : X.G.liftDir s (b + 1) (ρ / 2) ≤ X.G.liftDir s (b + X.n) (ρ / 2) := hmono (show b + 1 ≤ b + X.n by omega)
    rw [X.G.liftDir_add_n] at this; linarith

/-- OPEN's new arcs are finitely many. -/
theorem openArcs_finite {up : Bool} {ψ : ℝ} (ρ : ℝ) : (X.G.openArcs v X.col up s b ψ ρ).Finite :=
  (mergeArcs_finite ρ).union (toFinite _)

/-- OPEN's new arcs are non-degenerate. -/
theorem openArcs_nondegenerate {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ)
    (hρc : ρ ≤ ρc) : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate := by
  intro A hA
  rcases hA with hA | hA
  · exact mergeArcs_nondegenerate h cfg.hbn A hA
  rcases hA with rfl | rfl
  · exact openRay_nondegenerate h.1
  · exact openRim_nondegenerate cfg h hρc

/-! ### The wedge, the merged piece and the rest of the partial sector (FS131-IO2) -/

/-- **A sector between two germs is open**: near a point of it, the local angle and the distance move continuously (as
`BranchGerms.isOpen_sector`). -/
theorem _root_.HadwigerNelson.Plane.isOpen_sectorBetween (v : ℂ) (β₁ κ₁ β₂ κ₂ r : ℝ) :
    IsOpen (sectorBetween v β₁ κ₁ β₂ κ₂ r) := by
  rw [isOpen_iff_mem_nhds]
  rintro z₀ ⟨s₀, hs₀, φ₀, hφ₀, hz₀⟩
  have hz₀v : z₀ ≠ v := by
    intro h
    have := congrArg (fun z => ‖z - v‖) hz₀
    simp only [h, sub_self, norm_zero, add_sub_cancel_left, norm_mul_e hs₀.1.le] at this
    linarith [hs₀.1]
  set ψ : ℂ → ℝ := fun z => φ₀ + arg ((z - v) / (z₀ - v)) with hψ
  have hψc : ContinuousAt ψ z₀ := continuousAt_const.add (continuousAt_arg_div hz₀v)
  have hψ0 : ψ z₀ = φ₀ := by simp [hψ, arg_div_self hz₀v]
  have hnc : ContinuousAt (fun z : ℂ => ‖z - v‖) z₀ :=
    (continuous_norm.comp (continuous_id.sub continuous_const)).continuousAt
  have hn0 : ‖z₀ - v‖ = s₀ := by rw [hz₀, add_sub_cancel_left, norm_mul_e hs₀.1.le]
  have ev1 : ∀ᶠ z in 𝓝 z₀, ‖z - v‖ ∈ Ioo 0 r :=
    hnc.preimage_mem_nhds (by rw [hn0]; exact Ioo_mem_nhds hs₀.1 hs₀.2)
  have ev2 : ∀ᶠ z in 𝓝 z₀, germDir β₁ κ₁ ‖z - v‖ < ψ z :=
    ContinuousAt.eventually_lt ((continuous_germDir β₁ κ₁).continuousAt.comp hnc) hψc
      (by simp only [hn0, hψ0]; exact hφ₀.1)
  have ev3 : ∀ᶠ z in 𝓝 z₀, ψ z < germDir β₂ κ₂ ‖z - v‖ :=
    ContinuousAt.eventually_lt hψc ((continuous_germDir β₂ κ₂).continuousAt.comp hnc)
      (by simp only [hn0, hψ0]; exact hφ₀.2)
  filter_upwards [ev1, ev2, ev3] with z h1 h2 h3
  exact ⟨‖z - v‖, h1, ψ z, ⟨h2, h3⟩, eq_polar_local hs₀.1 hz₀ z⟩

/-- **Two polar forms of one point** at angles less than a turn apart are one. -/
theorem _root_.HadwigerNelson.Plane.polar_eq_of_abs_lt {v : ℂ} {t t' φ φ' : ℝ} (ht : 0 < t) (ht' : 0 < t')
    (h : v + (t : ℂ) * e φ = v + (t' : ℂ) * e φ') (hφ : t = t' → |φ - φ'| < 2 * π) : t = t' ∧ φ = φ' := by
  obtain ⟨rfl, he⟩ := (polar_eq_iff ht ht').mp h
  refine ⟨rfl, ?_⟩
  have hφ := hφ rfl
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp he
  have hπ := Real.pi_pos
  rw [hm, add_sub_cancel_left, abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 * π)] at hφ
  have h2 : |(m : ℝ)| < 1 := by
    by_contra hc; push Not at hc; nlinarith
  have h3 : m = 0 := Int.abs_lt_one_iff.mp (by exact_mod_cast h2)
  rw [hm, h3]; simp

theorem _root_.HadwigerNelson.Plane.BranchGerms.isOpen_openWedge {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool) (s : Fin n)
    (b : ℕ) (ψ ρ : ℝ) : IsOpen (G.openWedge v up s b ψ ρ) := by
  unfold BranchGerms.openWedge; split_ifs <;> exact isOpen_sectorBetween _ _ _ _ _ _

theorem _root_.HadwigerNelson.Plane.BranchGerms.isOpen_openPiece {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool) (s : Fin n)
    (b : ℕ) (ψ r : ℝ) : IsOpen (G.openPiece v up s b ψ r) := by
  unfold BranchGerms.openPiece; split_ifs <;> exact isOpen_sectorBetween _ _ _ _ _ _

theorem _root_.HadwigerNelson.Plane.BranchGerms.isOpen_openRest {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool) (s : Fin n)
    (b : ℕ) (ψ r : ℝ) : IsOpen (G.openRest v up s b ψ r) := by
  unfold BranchGerms.openRest; split_ifs <;> exact isOpen_sectorBetween _ _ _ _ _ _

/-- A point of the ray out to `ρ/2` lies on the new ray. -/
theorem mem_openRay {ψ ρ t : ℝ} (hρ : 0 < ρ) (ht : t ∈ Icc 0 (ρ / 2)) :
    v + (t : ℂ) * e ψ ∈ (openRay v ψ ρ).carrier := by
  have hρ2 : (0 : ℝ) < ρ / 2 := by linarith
  refine ⟨1 - t / (ρ / 2), t / (ρ / 2), ?_, div_nonneg ht.1 hρ2.le, by ring, ?_⟩
  · rw [sub_nonneg, div_le_one hρ2]; exact ht.2
  · simp only [Complex.real_smul]
    have : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
    push_cast
    field_simp
    ring

/-- A point of the circle of radius `ρ/2` between the wedge's germ and the ray lies on the rim arc across the wedge. -/
theorem mem_openRim {up : Bool} {ψ ρ φ : ℝ}
    (hφ : if up then X.G.liftDir s b (ρ / 2) ≤ φ ∧ φ ≤ ψ else ψ ≤ φ ∧ φ ≤ X.G.liftDir s 1 (ρ / 2)) :
    v + ((ρ / 2 : ℝ) : ℂ) * e φ ∈ (X.G.openRim v up s b ψ ρ).carrier := by
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ
    unfold BranchGerms.openRim; simp only [Bool.false_eq_true, if_false]; exact ⟨φ, hφ, rfl⟩
  · simp only [if_true] at hφ
    unfold BranchGerms.openRim; simp only [if_true]; exact ⟨φ, hφ, rfl⟩

variable {c : Fin k} {up : Bool} {ψ ρc : ℝ}

theorem OpenConfig.two_le (cfg : X.OpenConfig c up s b ψ ρc) : 2 ≤ X.n := by
  have := cfg.hb1; have := cfg.hbn; omega

/-- Below the clear radius the lifted directions increase along the orbit, and gain less than a turn in one step. -/
theorem OpenConfig.liftDir_succ_lt (cfg : X.OpenConfig c up s b ψ ρc) {t : ℝ} (ht : t ∈ Ioo 0 X.s₀) (m : ℕ) :
    X.G.liftDir s (m + 1) t < X.G.liftDir s m t + 2 * π := by
  rw [← X.G.liftDir_add_n s m t]
  exact X.G.liftDir_mono X.hord s ht (show m + 1 < m + X.n by have := cfg.two_le; omega)

/-- **The wedge lies in the partial sector** (the ray lies strictly inside it below the clear radius). -/
theorem openWedge_subset_sector (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    X.G.openWedge v up s b ψ ρ ⊆ X.G.sector v ρ (BranchGerms.idx s (BranchGerms.rayPos up b)) := by
  intro z hz
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hray := cfg.ray t htc
  refine (X.G.mem_sector_idx s _).mpr ⟨t, ⟨ht.1, by linarith [ht.2, h.1]⟩, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ hray ⊢
    exact ⟨hray.1.trans hφ.1, hφ.2⟩
  · simp only [BranchGerms.rayPos, if_true] at hφ hray ⊢
    exact ⟨hφ.1, hφ.2.trans hray.2⟩

/-- **A point at a direction between the gap's end germs, inside `ρ/2`, lies in the merged piece.** -/
theorem mem_openPiece_of_Icc (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc) {t φ : ℝ}
    (ht : t ∈ Ioo 0 (ρ / 2)) (hφ : φ ∈ Icc (X.G.liftDir s 1 t) (X.G.liftDir s b t)) :
    v + (t : ℂ) * e φ ∈ X.G.openPiece v up s b ψ (ρ / 2) := by
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hray := cfg.ray t htc
  refine X.G.mem_openPiece.mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢
    exact ⟨hray.2.trans_le hφ.1, hφ.2.trans_lt (hmono (Nat.lt_succ_self b))⟩
  · simp only [BranchGerms.rayPos, if_true] at hray ⊢
    exact ⟨(hmono Nat.zero_lt_one).trans_le hφ.1, hφ.2.trans_lt hray.1⟩

/-- **The wedge lies in the merged piece.** -/
theorem openWedge_subset_openPiece (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) :
    X.G.openWedge v up s b ψ ρ ⊆ X.G.openPiece v up s b ψ (ρ / 2) := by
  intro z hz
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  refine X.G.mem_openPiece.mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ ⊢
    exact ⟨hφ.1, hφ.2.trans (hmono (show 1 < b + 1 by have := cfg.hb1; omega))⟩
  · simp only [if_true] at hφ ⊢
    exact ⟨(hmono.monotone (Nat.zero_le b)).trans_lt hφ.1, hφ.2⟩

/-- **The wedge misses the rest of the partial sector** (the two lie on the two sides of the ray, within one turn). -/
theorem disjoint_openWedge_openRest (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) :
    Disjoint (X.G.openWedge v up s b ψ ρ) (X.G.openRest v up s b ψ ρ) := by
  rw [Set.disjoint_left]
  intro z hz hz'
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  obtain ⟨t', ht', φ', hφ', he⟩ := X.G.mem_openRest.mp hz'
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hπ := Real.pi_pos
  obtain ⟨rfl, rfl⟩ := polar_eq_of_abs_lt ht.1 ht'.1 he fun htt => by
    subst htt
    cases up
    · simp only [Bool.false_eq_true, if_false] at hφ hφ'
      have h1 := cfg.liftDir_succ_lt hts 0
      rw [zero_add] at h1
      rw [abs_lt]; constructor <;> linarith [hφ.1, hφ.2, hφ'.1, hφ'.2]
    · simp only [if_true] at hφ hφ'
      have h1 := cfg.liftDir_succ_lt hts b
      rw [abs_lt]; constructor <;> linarith [hφ.1, hφ.2, hφ'.1, hφ'.2]
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ hφ'; linarith [hφ.1, hφ'.2]
  · simp only [if_true] at hφ hφ'; linarith [hφ.2, hφ'.1]

/-- **A point of the partial sector inside `B̄(v, ρ/2)`** is in the wedge, on the ray, on the rim arc across the wedge, or in the rest
of the partial sector. -/
theorem sector_rayPos_cases (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) {x : ℂ}
    (hx : x ∈ X.G.sector v ρ (BranchGerms.idx s (BranchGerms.rayPos up b))) (hxr : ‖x - v‖ ≤ ρ / 2) :
    x ∈ X.G.openWedge v up s b ψ ρ ∨ x ∈ (openRay v ψ ρ).carrier ∨ x ∈ (X.G.openRim v up s b ψ ρ).carrier ∨
      x ∈ X.G.openRest v up s b ψ ρ := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := (X.G.mem_sector_idx s _).mp hx
  rw [add_sub_cancel_left, norm_mul_e ht.1.le] at hxr
  rcases lt_trichotomy φ ψ with hlt | rfl | hgt
  · cases up
    · right; right; right
      simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ
      exact X.G.mem_openRest.mpr ⟨t, ht, φ, by simp only [Bool.false_eq_true, if_false]; exact ⟨hφ.1, hlt⟩, rfl⟩
    · simp only [BranchGerms.rayPos, if_true] at hφ
      rcases eq_or_lt_of_le hxr with heq | hlt'
      · right; right; left
        subst heq
        exact mem_openRim (by simp only [if_true]; exact ⟨hφ.1.le, hlt.le⟩)
      · left
        exact X.G.mem_openWedge.mpr ⟨t, ⟨ht.1, hlt'⟩, φ, by simp only [if_true]; exact ⟨hφ.1, hlt⟩, rfl⟩
  · right; left; exact mem_openRay h.1 ⟨ht.1.le, hxr⟩
  · cases up
    · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ
      rcases eq_or_lt_of_le hxr with heq | hlt'
      · right; right; left
        subst heq
        exact mem_openRim (by simp only [Bool.false_eq_true, if_false]; exact ⟨hgt.le, hφ.2.le⟩)
      · left
        exact X.G.mem_openWedge.mpr ⟨t, ⟨ht.1, hlt'⟩, φ, by simp only [Bool.false_eq_true, if_false]; exact ⟨hgt, hφ.2⟩, rfl⟩
    · right; right; right
      simp only [BranchGerms.rayPos, if_true] at hφ
      exact X.G.mem_openRest.mpr ⟨t, ht, φ, by simp only [if_true]; exact ⟨hgt, hφ.2⟩, rfl⟩

/-- **OPEN's colouring is `c` on the merged piece** out to `ρ/2`: its points are in the wedge, on a gap germ, or in the horn or a gap
sector. -/
theorem openCol_of_mem_openPiece (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) {z : ℂ}
    (hz : z ∈ X.G.openPiece v up s b ψ (ρ / 2)) : X.G.openCol v X.col F.col up s b ψ c ρ z = c := by
  classical
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openPiece.mp hz
  have htρ : t ∈ Ioo 0 ρ := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hgerm : ∀ m, 0 < m → m ≤ b →
      X.G.mergeCol v X.col F.col s 0 b c ρ (v + (t : ℂ) * e (X.G.liftDir s m t)) = c := by
    intro m h1 h2
    rw [← X.G.branchPt_idx, mergeCol_branchPt h _ htρ, if_pos ⟨⟨m, h1, h2, rfl⟩, ht.2⟩]
  have hsec : ∀ m, (m = BranchGerms.hornPos up b ∨ (0 < m ∧ m < b)) → ∀ φ, X.G.liftDir s m t < φ →
      φ < X.G.liftDir s (m + 1) t → X.G.mergeCol v X.col F.col s 0 b c ρ (v + (t : ℂ) * e φ) = c := by
    intro m hm φ h1 h2
    have hz : v + (t : ℂ) * e φ ∈ X.G.sector v ρ (BranchGerms.idx s m) :=
      (X.G.mem_sector_idx s m).mpr ⟨t, htρ, φ, ⟨h1, h2⟩, rfl⟩
    rw [mergeCol_of_mem_sector h hz]
    split_ifs with hg
    · rfl
    · rcases hm with rfl | hm
      · exact cfg.col_horn
      · exact absurd ⟨⟨m, hm.1, hm.2, rfl⟩, by rw [add_sub_cancel_left, norm_mul_e ht.1.le]; exact ht.2⟩ hg
  unfold BranchGerms.openCol
  split_ifs with hW
  · rfl
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ
    have h1 : X.G.liftDir s 1 t ≤ φ := by
      by_contra hlt; push Not at hlt
      exact hW (X.G.mem_openWedge.mpr ⟨t, ht, φ, by simp only [Bool.false_eq_true, if_false]; exact ⟨hφ.1, hlt⟩, rfl⟩)
    rcases exists_step_of_strictMono hmono (show 1 ≤ b + 1 by omega) h1 hφ.2.le with he | ⟨m, hm1, hm2, hm3, hm4⟩
    · exact absurd he (ne_of_lt hφ.2)
    · rcases eq_or_lt_of_le hm3 with he | hlt
      · rw [← he]; exact hgerm m (by omega) (by omega)
      · refine hsec m ?_ φ hlt hm4
        rcases eq_or_lt_of_le (show m ≤ b by omega) with rfl | hmb
        · left; rfl
        · right; exact ⟨by omega, hmb⟩
  · simp only [if_true] at hφ
    have h1 : φ ≤ X.G.liftDir s b t := by
      by_contra hlt; push Not at hlt
      exact hW (X.G.mem_openWedge.mpr ⟨t, ht, φ, by simp only [if_true]; exact ⟨hlt, hφ.2⟩, rfl⟩)
    rcases exists_step_of_strictMono hmono (Nat.zero_le b) hφ.1.le h1 with he | ⟨m, hm1, hm2, hm3, hm4⟩
    · rw [he]; exact hgerm b cfg.hb1 le_rfl
    · rcases eq_or_lt_of_le hm3 with he | hlt
      · rcases Nat.eq_zero_or_pos m with rfl | hm0
        · exact absurd he (ne_of_lt hφ.1)
        · rw [← he]; exact hgerm m hm0 (by omega)
      · refine hsec m ?_ φ hlt hm4
        rcases Nat.eq_zero_or_pos m with rfl | hm0
        · left; rfl
        · right; exact ⟨hm0, hm2⟩

/-- **OPEN's colouring is locally constant** off the trimmed arcs and the new arcs. -/
theorem open_hlc {c : Fin k} {up : Bool} {ψ ρc ρ ρ' : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h' : X.Small ρ')
    (hρρ' : ρ < ρ') (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
      ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x := by
  classical
  have hn : 0 < X.n := by have := cfg.hbn; omega
  have hb0 : 0 < b := cfg.hb1
  obtain ⟨-, h2, -⟩ := F.trimArcs_spec X.mem_dom h.1
  intro x hx hxa
  have hxO : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, x ∉ A.carrier := fun A hA hxA' =>
    hxa (mem_iUnion₂.mpr ⟨A, Or.inr hA, hxA'⟩)
  have hxA : x ∉ ⋃ A ∈ X.G.mergeArcs v X.col s 0 b ρ, A.carrier := fun hm => by
    obtain ⟨A, hA, hxA'⟩ := mem_iUnion₂.mp hm; exact hxO A (Or.inl hA) hxA'
  have hxT : x ∉ ⋃ B ∈ F.trimArcs v ρ, B.carrier := fun hm => by
    obtain ⟨B, hB, hxB⟩ := mem_iUnion₂.mp hm; exact hxa (mem_iUnion₂.mpr ⟨B, Or.inl hB, hxB⟩)
  have hxR : x ∉ (openRay v ψ ρ).carrier := hxO _ (Or.inr (Or.inl rfl))
  have hxM : x ∉ (X.G.openRim v up s b ψ ρ).carrier := hxO _ (Or.inr (Or.inr rfl))
  have hoff : ∀ y, y ∉ X.G.openWedge v up s b ψ ρ →
      X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.mergeCol v X.col F.col s 0 b c ρ y := fun y hy => by
    unfold BranchGerms.openCol; rw [if_neg hy]
  by_cases hxP : x ∈ X.G.openPiece v up s b ψ (ρ / 2)
  · -- in the merged piece: `c` throughout
    filter_upwards [(X.G.isOpen_openPiece v up s b ψ (ρ / 2)).mem_nhds hxP] with y hy
    rw [openCol_of_mem_openPiece cfg h hy, openCol_of_mem_openPiece cfg h hxP]
  rcases le_or_gt ‖x - v‖ (ρ / 2) with hxr | hxr
  · -- inside `B̄(v, ρ/2)`, off the piece: a point of a sector off the gap
    have hxv : x ≠ v := fun hxv => hxR (hxv ▸ left_mem_segment ℝ _ _)
    have hxb : x ∈ ball v ρ := by rw [mem_ball, dist_eq_norm]; linarith [h.1]
    rcases ball_cases h hn hxb hxv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · have hig : i ∉ BranchGerms.gapSec s 0 b := by
        intro hig
        obtain ⟨φ, hφ, hxφ⟩ := exists_dir_of_mem_gapSec h hig hi
        rcases eq_or_lt_of_le hxr with heq | hlt
        · have hab' : 0 + 1 < b := by obtain ⟨m, h3, h4, -⟩ := hig; omega
          rw [heq] at hφ hxφ
          exact hxA (hxφ ▸ mem_mergeArcs_rim hab' hφ)
        · rw [zero_add] at hφ
          exact hxP (hxφ ▸ mem_openPiece_of_Icc cfg h hρc ⟨(norm_of_mem_sector hi).1, hlt⟩ hφ)
      have hev : ∀ᶠ y in 𝓝 x, y ∉ X.G.openWedge v up s b ψ ρ := by
        by_cases hir : i = BranchGerms.idx s (BranchGerms.rayPos up b)
        · subst hir
          rcases sector_rayPos_cases cfg h hi hxr with hW | hR | hM | hRest
          · exact absurd (openWedge_subset_openPiece cfg h hW) hxP
          · exact absurd hR hxR
          · exact absurd hM hxM
          · filter_upwards [(X.G.isOpen_openRest v up s b ψ ρ).mem_nhds hRest] with y hy hyW
            exact Set.disjoint_left.mp (disjoint_openWedge_openRest cfg h) hyW hy
        · filter_upwards [(X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi] with y hy hyW
          exact hir (sector_disjoint h hy (openWedge_subset_sector cfg h hρc hyW))
      filter_upwards [hev, (X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi] with y hyW hy
      rw [hoff y hyW, hoff x hev.self_of_nhds, mergeCol_of_mem_sector h hy, mergeCol_of_mem_sector h hi,
        if_neg (fun h1 => hig h1.1), if_neg (fun h1 => hig h1.1)]
    · -- a branch point inside `ρ/2`: on an arc, or in the piece
      exfalso
      rw [norm_branchPt_sub v _ _ ht.1.le] at hxr
      by_cases hjg : j ∈ BranchGerms.gapGerm s 0 b
      · obtain ⟨m, h1, h2', rfl⟩ := hjg
        have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, ht.2.trans h.2.1⟩
        have hφ := liftDir_gap_germ (s := s) hts h1 h2'
        rw [zero_add] at hφ
        rcases eq_or_lt_of_le hxr with heq | hlt
        · rw [X.G.branchPt_idx, heq] at hxA hxM
          rw [heq] at hφ
          by_cases hb1 : 0 + 1 < b
          · exact hxA (mem_mergeArcs_rim hb1 (by rw [zero_add]; exact hφ))
          · have hb : b = 1 := by omega
            have hm : m = 1 := by omega
            subst hb hm
            have hray := cfg.ray (ρ / 2) ⟨h.half.1, by linarith [h.1]⟩
            apply hxM
            refine mem_openRim ?_
            cases up
            · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢
              exact ⟨hray.2.le, le_rfl⟩
            · simp only [BranchGerms.rayPos, if_true] at hray ⊢
              exact ⟨le_rfl, hray.1.le⟩
        · rw [X.G.branchPt_idx] at hxP
          exact hxP (mem_openPiece_of_Icc cfg h hρc ⟨ht.1, hlt⟩ hφ)
      · exact hxA (branchPt_mem_mergeArcs_inner h hjg ⟨ht.1, hxr⟩)
  · -- beyond `ρ/2`: OPEN's colouring is MERGE's, and MERGE's argument
    have hfar : ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.mergeCol v X.col F.col s 0 b c ρ y := by
      filter_upwards [isClosed_closedBall.isOpen_compl.mem_nhds (show x ∉ closedBall v (ρ / 2) by
        rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy
      exact hoff y fun hyW => hy (ball_subset_closedBall (X.G.openWedge_subset_ball v up s b ψ ρ hyW))
    suffices hm : ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s 0 b c ρ y = X.G.mergeCol v X.col F.col s 0 b c ρ x by
      filter_upwards [hfar, hm] with y hy1 hy2
      rw [hy1, hy2, hfar.self_of_nhds]
    rcases lt_trichotomy (dist x v) ρ with hlt | heq | hgt
    · have hxv : x ≠ v := fun hxv => by rw [hxv, sub_self, norm_zero] at hxr; linarith [h.1]
      rcases ball_cases h hn hlt hxv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
      · filter_upwards [(X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi, isClosed_closedBall.isOpen_compl.mem_nhds
          (show x ∉ closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy hyb
        rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
        rw [mergeCol_of_mem_sector h hy, mergeCol_of_mem_sector h hi, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2),
          if_neg (fun h1 => (not_lt.mpr hxr.le) h1.2)]
      · obtain ⟨p, hpj⟩ := exists_next_eq j
        obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ) ⟨h.1, h.2.1.le⟩ (p := p) ht
        rw [hpj] at hball
        have hev : ∀ᶠ y in 𝓝 (branchPt v (X.G.β j) (X.G.κ j) t), y ∈ X.G.sector v ρ p ∪ X.G.sector v ρ j ∪
            branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ := Filter.mem_of_superset (ball_mem_nhds _ hε) hball
        rw [norm_branchPt_sub v _ _ ht.1.le] at hxr
        have hph : BranchGerms.Phantom X.col j := by
          by_contra hph; exact hxA (branchPt_mem_mergeArcs_outer h hph ⟨hxr, ht.2.le⟩)
        have hpc : X.col p = X.col j := by
          obtain ⟨i, hi, hc⟩ := hph; rw [← BranchGerms.next_injective (hi.trans hpj.symm)]; exact hc
        rw [mergeCol_branchPt h j ht, if_neg (fun h1 => (not_lt.mpr hxr.le) h1.2)]
        filter_upwards [hev, isClosed_closedBall.isOpen_compl.mem_nhds (show branchPt v (X.G.β j) (X.G.κ j) t ∉
          closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, norm_branchPt_sub v _ _ ht.1.le, not_le]; exact hxr)]
          with y hy hyb
        rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
        rcases hy with (hy | hy) | ⟨t', ht', rfl⟩
        · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2), hpc]
        · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2)]
        · rw [norm_branchPt_sub v _ _ ht'.1.le] at hyb
          rw [mergeCol_branchPt h j ht', if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2)]
    · -- on the rim: interior to `F`, in one chart sector
      have hxv : x ≠ v := fun hxv => by rw [hxv, dist_self] at heq; linarith [h.1]
      have hxF : x ∈ F.interiorPts := by
        refine ⟨hx, fun hxF => ?_⟩
        have hxr' : x ∈ ball v X.r₀ := by rw [mem_ball, heq]; exact h.lt_r₀
        obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hxv hxr' (fun hI => hI.2 hxF)
        rw [← dist_eq_norm, heq] at hj
        exact hxT (hj ▸ branchPt_rim_mem_trimArcs h' h.1 hρρ' j)
      obtain ⟨i, hi⟩ : ∃ i, x ∈ X.G.sector v ρ' i := by
        have : x ∈ ball v ρ' ∩ F.interiorPts := ⟨by rw [mem_ball, heq]; exact hρρ', hxF⟩
        rw [X.hC.cover ρ' h'.mem_Ioc hn] at this
        exact mem_iUnion.mp this
      filter_upwards [(X.hC.isOpen ρ' h'.mem_Ioc i).mem_nhds hi, isClosed_closedBall.isOpen_compl.mem_nhds
        (show x ∉ closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy hyb
      rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
      rw [mergeCol_of_mem_sector_out h' h hy hyb, mergeCol_of_mem_sector_out h' h hi hxr]
    · -- off the closed ball: `F`'s colouring
      have hxc : x ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
      have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun hF => hxT (h2 ⟨hF, hxc⟩)
      filter_upwards [F.locallyConstant x hx hxF, isClosed_closedBall.isOpen_compl.mem_nhds hxc] with y hy hyc
      rw [mergeCol_of_not_mem h (fun hb => hyc (ball_subset_closedBall hb)),
        mergeCol_of_not_mem h (fun hb => hxc (ball_subset_closedBall hb)), hy]

/-- OPEN's new arcs lie in the closed ball. -/
theorem openArcs_subset_closedBall {up : Bool} {ψ ρ : ℝ} (h : X.Small ρ) :
    ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier ⊆ closedBall v ρ := by
  intro A hA
  rcases hA with hA | hA
  · exact mergeArcs_subset_closedBall h A hA
  rcases hA with rfl | rfl
  · exact (openRay_subset_closedBall v ψ h.1.le).trans (closedBall_subset_closedBall (by linarith [h.1]))
  · exact (X.G.openRim_subset_sphere v up s b ψ h.1.le).trans
      (sphere_subset_closedBall.trans (closedBall_subset_closedBall (by linarith [h.1])))

/-- **The configuration's clear range covers the gap**: below `ρc`, every point at a direction between the gap's end germs is clear
for `c`. -/
theorem OpenConfig.isClear_of_Icc (cfg : X.OpenConfig c up s b ψ ρc) {t φ : ℝ} (ht : t ∈ Ioo 0 ρc)
    (hφ : φ ∈ Icc (X.G.liftDir s 1 t) (X.G.liftDir s b t)) : F.IsClear c (v + (t : ℂ) * e φ) := by
  have hray := cfg.ray t ht
  refine cfg.clear t ht φ ?_ ?_
  · cases up
    · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢; exact hray.2.le.trans hφ.1
    · simp only [if_true]; exact hφ.1
  · cases up
    · simp only [Bool.false_eq_true, if_false]; exact hφ.2
    · simp only [BranchGerms.rayPos, if_true] at hray ⊢; exact hφ.2.trans hray.1.le

/-- **The wedge is clear for `c`.** -/
theorem OpenConfig.isClear_of_mem_openWedge (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc)
    {z : ℂ} (hz : z ∈ X.G.openWedge v up s b ψ ρ) : F.IsClear c z := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  refine cfg.clear t htc φ ?_ ?_
  · cases up
    · simp only [Bool.false_eq_true, if_false] at hφ ⊢; exact hφ.1.le
    · simp only [if_true] at hφ ⊢; exact (hmono cfg.hb1).trans hφ.1.le
  · cases up
    · simp only [Bool.false_eq_true, if_false] at hφ ⊢; exact hφ.2.le.trans (hmono cfg.hb1)
    · simp only [if_true] at hφ ⊢; exact hφ.2.le

/-- OPEN's colour on the wedge is `c`. -/
theorem openCol_of_mem {ρ : ℝ} {Fcol : ℂ → Fin k} {z : ℂ} (hz : z ∈ X.G.openWedge v up s b ψ ρ) :
    X.G.openCol v X.col Fcol up s b ψ c ρ z = c := by
  unfold BranchGerms.openCol; rw [if_pos hz]

/-- Off the wedge OPEN's colour is MERGE's. -/
theorem openCol_of_not_mem {ρ : ℝ} {Fcol : ℂ → Fin k} {z : ℂ} (hz : z ∉ X.G.openWedge v up s b ψ ρ) :
    X.G.openCol v X.col Fcol up s b ψ c ρ z = X.G.mergeCol v X.col Fcol s 0 b c ρ z := by
  unfold BranchGerms.openCol; rw [if_neg hz]

/-- `v` lies on the new ray. -/
theorem v_mem_openArcs {ρ : ℝ} : v ∈ ⋃ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier :=
  mem_iUnion₂.mpr ⟨openRay v ψ ρ, Or.inr (Or.inl rfl), left_mem_segment ℝ _ _⟩

/-! ## OPEN's clauses -/

section Surgery

variable {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ}
  {hA : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate} {hAf : (X.G.openArcs v X.col up s b ψ ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
    ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x}

/-- Inside `B(v, ρ)`, OPEN's interior points are the points off its new arcs. -/
theorem mem_open_interiorPts_iff (h : X.Small ρ) {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts ↔
      z ∉ ⋃ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier := by
  have hzd : z ∈ F.dom := X.hG.subdom (ball_subset_ball h.2.2.1.le hz)
  show z ∈ F.dom \ _ ↔ _
  rw [Set.mem_sdiff, surgery_mem_arcs_iff_of_mem X.hG h.2.2.1 hz]
  exact ⟨fun h1 => h1.2, fun h1 => ⟨hzd, h1⟩⟩

/-- On the rim, OPEN's interior points are `F`'s (a germ's rim point lies on the trimmed arcs). -/
theorem mem_interiorPts_of_open_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') {z : ℂ} (hz : dist z v = ρ)
    (hzI : z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
      hlc).interiorPts) : z ∈ F.interiorPts := by
  refine ⟨hzI.1, fun hzF => ?_⟩
  have hzv : z ≠ v := fun hzv => by rw [hzv, dist_self] at hz; linarith
  have hzr : z ∈ ball v X.r₀ := by rw [mem_ball, hz]; exact hρρ'.trans h'.lt_r₀
  obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hzv hzr (fun hI => hI.2 hzF)
  rw [← dist_eq_norm, hz] at hj
  obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (hj ▸ branchPt_rim_mem_trimArcs h' hρ hρρ' j)
  exact hzI.2 (mem_iUnion₂.mpr ⟨B, Or.inl hB, hzB⟩)

/-- OPEN's map agrees with `F` off the closed disc. -/
theorem open_agreesOff (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).AgreesOff F
      (closedBall v ρ) := by
  refine surgery_agreesOff (fun A hA => openArcs_subset_closedBall h A hA) (fun z hz => ?_)
  have hz' : z ∉ ball v ρ := fun h' => hz (ball_subset_closedBall h')
  have hW : z ∉ X.G.openWedge v up s b ψ ρ := fun h' =>
    hz' (ball_subset_ball (by linarith [h.1]) (X.G.openWedge_subset_ball v up s b ψ ρ h'))
  simp only [BranchGerms.openCol, if_neg hW]
  exact mergeCol_of_not_mem h hz'

/-- OPEN's map creates no unit arc. -/
theorem open_ringArcsWithin (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).RingArcsWithin
      F := by
  refine surgery_ringArcsWithin fun A hA hu => ?_
  rcases hA with hA | hA
  · exact mergeArcs_unit h A hA hu
  rcases hA with rfl | rfl
  · exact absurd hu (by simp [openRay, Arc.IsUnitArc])
  · exfalso
    unfold BranchGerms.openRim at hu
    split_ifs at hu <;> · simp only [Arc.IsUnitArc] at hu; linarith [h.2.2.2]

/-- OPEN's map keeps Condition 5. -/
theorem open_condition5 (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    F.Condition5 →
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).Condition5 := by
  refine surgery_condition5 fun h5 A hA p => ?_
  rcases hA with hA | hA
  · exact mergeArcs_condition5 h cfg.hbn h5 A hA p
  rcases hA with rfl | rfl
  · rcases Arc.finite_inter_sphere_or_eq_circ _ (openRay_nondegenerate (v := v) (ψ := ψ) h.1) p with hf | ⟨θ₀, θ₁, heq⟩
    · exact hf.subset fun z hz => ⟨hz.1.1, hz.2⟩
    · simp [openRay] at heq
  · rcases Arc.finite_inter_sphere_or_eq_circ _ (openRim_nondegenerate cfg h hρc) p with hf | ⟨θ₀, θ₁, heq⟩
    · exact hf.subset fun z hz => ⟨hz.1.1, hz.2⟩
    · exfalso
      unfold BranchGerms.openRim at heq
      split_ifs at heq <;> · simp only [Arc.circ.injEq] at heq; linarith [h.2.2.2, heq.2.1]

/-- **OPEN's map is valid**: every recoloured point is clear for `c` (the configuration's clear wedge), and the disc is small. -/
theorem open_valid (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).Valid := by
  have hregion : ∀ i, ∀ y ∈ F.region i, F.IsClear i y := fun i y hy => by
    have h1 := hy.2; simp only [mem_preimage, mem_singleton_iff] at h1; rw [← h1]; exact isClear_col hF hy.1
  have hn : 0 < X.n := by have := cfg.hbn; omega
  refine Valid.of_agreesOff hF (open_agreesOff h) ?_ ?_
  · rintro z ⟨hzc, hzI⟩
    show F.IsClear (X.G.openCol v X.col F.col up s b ψ c ρ z) z
    rcases (mem_closedBall.mp hzc).lt_or_eq with hlt | heq
    · have hzv : z ≠ v := by
        rintro rfl; exact (mem_open_interiorPts_iff h hlt).mp hzI v_mem_openArcs
      by_cases hzW : z ∈ X.G.openWedge v up s b ψ ρ
      · rw [openCol_of_mem hzW]; exact cfg.isClear_of_mem_openWedge h hρc hzW
      rw [openCol_of_not_mem hzW]
      rcases ball_cases h hn hlt hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
      · rw [mergeCol_of_mem_sector h hi]; split_ifs with hg
        · obtain ⟨φ, hφ, hzφ⟩ := exists_dir_of_mem_gapSec h hg.1 hi
          rw [zero_add] at hφ
          rw [hzφ]; exact cfg.isClear_of_Icc ⟨(norm_of_mem_sector hi).1, by linarith [hg.2, h.1]⟩ hφ
        · exact hregion _ _ (X.hcol i ρ h.mem_Ioc hi)
      · rw [mergeCol_branchPt h j ht]; split_ifs with hg
        · obtain ⟨m, h1, h2, rfl⟩ := hg.1
          have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2
          rw [zero_add] at hφ
          rw [X.G.branchPt_idx]
          exact cfg.isClear_of_Icc ⟨ht.1, by linarith [hg.2, h.1]⟩ hφ
        · exact isClear_of_mem_closure (hregion _) (cutSet_subset_closure h ⟨t, ht, rfl⟩)
    · have hzF := mem_interiorPts_of_open_rim h' hρρ' heq hzI
      have hzb : z ∉ ball v ρ := by rw [mem_ball, heq]; exact lt_irrefl ρ
      rw [openCol_of_not_mem (fun hW => hzb (ball_subset_ball (by linarith [h.1])
        (X.G.openWedge_subset_ball v up s b ψ ρ hW))), mergeCol_of_not_mem h hzb]
      exact isClear_col hF hzF
  · rintro z ⟨hz, -⟩ y ⟨hy, -⟩ hzy
    exfalso
    have := dist_triangle_right z y v
    rw [mem_closedBall] at hz hy
    linarith [h.2.2.2]

/-- **`v` gains no colour**: every colour of the new map near `v` is a chart sector's colour or `c`. -/
theorem open_coloursAt_self (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (_hρc : ρ ≤ ρc) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt v ⊆
      F.coloursAt v := by
  have hcol : ∀ i, X.col i ∈ F.coloursAt v := fun i => X.col_mem_coloursAt i
  have hc : c ∈ F.coloursAt v := cfg.col_horn ▸ hcol _
  have hn : 0 < X.n := by have := cfg.hbn; omega
  intro j hj
  have hj : v ∈ closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
    hlc).region j) := hj
  rw [mem_closure_iff_nhds] at hj
  obtain ⟨z, hzb, hzI, hzj⟩ := hj (ball v ρ) (isOpen_ball.mem_nhds (mem_ball_self h.1))
  have hzj' : X.G.openCol v X.col F.col up s b ψ c ρ z = j := hzj
  have hzv : z ≠ v := by
    intro hzv0
    exact hzI.2 (mem_iUnion₂.mpr ⟨openRay v ψ ρ, Or.inr (Or.inr (Or.inl rfl)), hzv0 ▸ left_mem_segment ℝ _ _⟩)
  rw [← hzj']
  unfold BranchGerms.openCol
  split_ifs
  · exact hc
  · rcases ball_cases h hn hzb hzv with ⟨i, hi⟩ | ⟨j', t, ht, rfl⟩
    · rw [mergeCol_of_mem_sector h hi]; split_ifs
      · exact hc
      · exact hcol i
    · rw [mergeCol_branchPt h j' ht]; split_ifs
      · exact hc
      · exact hcol j'

/-- **The degree does not rise and a horn is lost**: below `ρ/2` the sectors of the new map at `v` are the chart sectors off the
gap, the merged piece (the horn, the swallowed horns and the wedge) and the rest of the partial sector; the last two have
directions on an open interval, so they are no horn sets, while the horn was one. -/
theorem open_degree_horns (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (hρc : ρ ≤ ρc) {m j : ℕ} (hm : F.HasDegree v m) (hj : F.HasHornCount v j) :
    ∃ m' j', m' ≤ m ∧ j' < j ∧
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).HasDegree v m' ∧
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).HasHornCount v
        j' := by
  sorry

/-- **The rim**: near a point of `∂B(v, ρ)` the new map is MERGE's (the wedge, the ray and the rim arc lie inside `B̄(v, ρ/2)`), so
the point carries at most three colours, none repeated. -/
theorem open_rim (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (hρc : ρ ≤ ρc) :
    ∀ x ∈ sphere v ρ,
      ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt
        x).ncard ≤ 3 ∧
      ¬ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).HasRepeatedColour x := by
  sorry

/-- **`D_c(v′)` is unchanged off the disc** (`merge_allowedCone`'s route): the recoloured set's closure lies in `{v}` and an open
set of points clear for `c`, so no contact of `c` moves (`dist_ne_one_of_isOpen_isClear`), and the tiles keep their types. -/
theorem open_allowedCone (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ v' ∉ closedBall v ρ,
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).allowedCone v' c = F.allowedCone v' c := by
  sorry

end Surgery

end Near

variable {k : ℕ} {F : ArcMap k}

/-! ## FS131-E6-OPEN -/

/-- **FS131-E6-OPEN** (FS110 § 2.8's wedge-opening, derived with unit arcs allowed): at a lone `c`-horn (`c` has one sector at
`v`) whose colour's allowed cone `D_c(v)` has non-empty interior, recolouring with `c` a thin wedge beside the horn, on a side
where `D_c(v)` has interior directions, gives a valid map, equal to `F` off a small disc about `v`, creating no unit arc (so
Condition 5 is kept), in which `v` gains no colour, `v`'s degree does not rise and it has at least one horn fewer, the new points
on the rim carry at most three colours with none repeated, and no other point's allowed cone for `c` changes. -/
theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ}
    (hm : F.HasDegree v m) (hj : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧ F'.coloursAt v ⊆ F.coloursAt v ∧
      (∃ m' j', m' ≤ m ∧ j' < j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      (∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x) ∧
      ∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c := by
  classical
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨up, s, b, ψ, ρc, cfg⟩ := Near.exists_openConfig hF hv X hH h1 hD
  obtain ⟨ρ', h'⟩ := X.eventually_small.exists
  have hρ'0 := h'.1
  set ρ := min (min (ρ' / 2) ρc) (δ / 2) with hρdef
  have hρ0 : 0 < ρ := lt_min (lt_min (by linarith) cfg.hρc) (by linarith)
  have hρρ' : ρ < ρ' := ((min_le_left _ _).trans (min_le_left _ _)).trans_lt (by linarith)
  have hρc : ρ ≤ ρc := (min_le_left _ _).trans (min_le_right _ _)
  have hρδ : ρ < δ := (min_le_right _ _).trans_lt (by linarith)
  have h : X.Small ρ := h'.mono hρ0 hρρ'.le
  refine ⟨ρ, hρ0, hρδ, F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) X.mem_dom
    hρ0 (Near.openArcs_nondegenerate cfg h hρc) (Near.openArcs_finite ρ) (Near.open_hlc cfg h' hρρ' h hρc),
    Near.open_valid hF cfg h' hρρ' h hρc, Near.open_agreesOff h, Near.open_ringArcsWithin h, Near.open_condition5 cfg h hρc,
    Near.open_coloursAt_self cfg h hρc, Near.open_degree_horns cfg h' hρρ' h hρc hm hj, Near.open_rim cfg h' hρρ' h hρc,
    Near.open_allowedCone hF cfg h' hρρ' h hρc⟩

end ArcMap

end HadwigerNelson.Plane
