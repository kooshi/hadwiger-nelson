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

/-- **OPEN's new arcs**: MERGE's for the gap `s, 0, b` (the germs off the gap out to `ρ/2`, the non-phantom germs' pieces between
`ρ/2` and `ρ`, the rim arc across the gap's sectors), the ray, and the rim arc across the wedge. -/
noncomputable def openArcs {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Set Arc :=
  G.mergeArcs v col s 0 b ρ ∪ {openRay v ψ ρ, G.openRim v up s b ψ ρ}

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
  refine ⟨b, X.G.lift p b + ψ₁, ρc, ⟨hb1, hbn, hρc0, hρcs, ?_, ?_, ?_, ?_, ?_⟩⟩
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
  refine ⟨s, b, X.G.lift s 1 - ψ₁, ρc, ⟨hb1, hbn, hρc0, hρcs, hcusp_s, hcb, hlone', ?_, ?_⟩⟩
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

/-- **OPEN's colouring is locally constant** off the trimmed arcs and the new arcs. -/
theorem open_hlc {c : Fin k} {up : Bool} {ψ ρc ρ ρ' : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h' : X.Small ρ')
    (hρρ' : ρ < ρ') (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
      ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x := by
  sorry

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

/-! ## OPEN's clauses -/

section Surgery

variable {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ}
  {hA : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate} {hAf : (X.G.openArcs v X.col up s b ψ ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
    ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x}

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
  sorry

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
