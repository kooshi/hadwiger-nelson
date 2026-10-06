import Proofs.HadwigerNelson.Plane.RingCalculus.Star
import Proofs.HadwigerNelson.Plane.RingCalculus.HubCount
import Proofs.HadwigerNelson.Plane.RingCalculus.TilesAt
import Proofs.HadwigerNelson.Plane.RingCalculus.SoleTip
import Proofs.HadwigerNelson.Plane.RingCalculus.RingColour
import Mathlib.Data.ZMod.Basic

/-!
# The ring calculus: the Γ-free class is empty (FS116-V6's route), adjacent hubs

Wave 8's third module (`plans/FS131-w8-kernel-plan.md`, Stages 2 and 4; job FS131-K8).

**FS129-SR3-EMPTY-NS** (`emptyNS`, carrying FS116-Y4-EMPTY and FS116-Y4-OBST): no valid non-Siamese six-coloured fragment
on a closed disc of radius above 1 about a vertex `p` of at least four colours has a ring carrying no arc of `Γ`. Its
proof is FS116-V6's route (`plans/FS116-V6-verification.md` § 2.2), which never reads *simple*:

| step | declaration | class it is stated at | state |
|---|---|---|---|
| V6-RING (two colours absent, four tiles) | `qfree4`, `germS_absent` (`Plane/RingGerm`); `GammaFreeRing.exists_absent_pair` (`…/RingColour`); `exists_fin_tileAt` (`…/TilesAt`) | landed; the Γ-free class; any valid non-Siamese map | proved |
| V6-GERM, V6-TIP (every change point has a tip) | `germR_*` (`Plane/RingGerm`); `star_tip_nonempty` (`…/Star`) | landed; any change point with a free tip pair | proved |
| V6-WIN (the ring's two colours, the sixth-of-a-turn swap, constancy between change points) | `Plane/RingCalculus/RingColour` | any ring every germ of which lies in one colour class | proved |
| FS116-V6-HUBS (`m = 1`) | `v6_hubs`, from `GammaFreeRing.changePoint_gap` | the Γ-free class | proved |
| FS116-V6-HUBS (a tile tips at most two, consecutive) | `IsTile.dist_le_one_of_mem_closure` (`Plane/Tiles`), `ringPt_sixth_dist_le_one`, `sixth_cons_of_mem_closure` | any valid map; pure trigonometry | proved |
| FS116-V6-ANTI | `v6_anti` | any valid map, any two antipodal ring points | proved |
| FS116-V6-HUG | `v6_hug`, from `not_sole_tip_of_adjacent_changePoints` (`…/SoleTip`) | stated at the Γ-free class; the proof reads any two adjacent change points of a vertex of at least four colours with at most two absent | proved |
| FS116-V6-COUNT, the count | `v6_count`, from `V6Count.count` (`…/HubCount`, a certified computation) | finite combinatorics, no map | proved |
| FS116-V6-COUNT, the last step | `exists_ne_mem_closure_inter_of_split`, from `…/TilesAt` | any map, any point of the domain | proved |
| the composition | `emptyNS` | the Γ-free class | proved |

**How `m = 1` is proved** (`GammaFreeRing.changePoint_gap`; the count of FS116-V6-HUBS alone gives only `m ≤ 2`). Two change
points less than a sixth of a turn apart have a third in the window (`exists_third_change`: constancy between change
points, twice). The three classes of change points — within a class a sixth of a turn apart — are each covered by the four
tiles of `p`, so each class has two tiles holding two consecutive points of it (`exists_two_double_tiles`, on
`V6Count.twoDoubles`), and no tile is so in two classes (`not_double_two_classes`: four ring points pairwise within `1`):
six tiles among four (`fin_four_three_pairs`).

**The last step is not the row's.** FS116-V6-COUNT ends on the cyclic order of four sectors at `p` (*simple*), and
FS129-SR3 reads it on sectors without simplicity. Here it is a connectedness statement with no sectors and no cyclic
order: the closures of the tiles of `p` cover a small circle about `p`; if those tiles are split into two non-empty
groups, the two groups' closures are closed sets covering the connected circle, so a tile of one group and a tile of the
other share a closure point other than `p` (`exists_ne_mem_closure_inter_of_split`) — against `v6_anti`, by which a tipper
of `y_k` and a tipper of `y_(k+3)` share no closure point but `p`.

**Vacuity.** `v6_hubs` and `v6_hug` are stated over the Γ-free class, which `emptyNS` proves empty: each is a step of that
proof and carries the gate's line in its docstring, and beside `emptyNS` stands a refutation of each one's exact hypotheses
(`v6_hubs_vacuous`, `v6_hug_vacuous`), so the marker is a kernel fact whatever the scan reads. `v6_anti`, `ringPt_sixth_dist_le_one`, `v6_count` and
`exists_ne_mem_closure_inter_of_split` are stated at the classes their arguments read, none of them empty: `v6_count` has
72 configurations meeting its hypotheses (`tools/fs131_k8_count.py`, exact, with a fault that fires).

**Inhabitant of `emptyNS`'s hypotheses at a parameter the refutation leaves alive**: FS111-W-SQ9's lattice vertex at
`k = 9` — valid, non-Siamese, four colours at the vertex, its ring carrying twelve points of `Γ` and no arc
(`plans/FS116-V6-verification.md` § 2.2, control `v6-sq9`); five colours are absent there, where the refutation needs at
most two. **The Lean model is owed**: the map exists as `sq9Map : ArcMap 9` (`Plane/Saturated/Sq9Map`, wave 6, with
`IsPlaneMap` proved), and five facts about it are not yet proved — `Valid`, `NonSiamese`, `Covers` at a lattice vertex,
four colours at that vertex, and `GammaFreeRing` there (a later job's, on a line holding both waves; inventory items
525 (c), 530).

**FS129-SR3-OUTERADJ** (`outerAdj`, carrying FS116-V6-ADJ; open) and **FS129-MR1-DOUBLETIP** (`doubleTip`; proved) are
stated for the wider ring classes they serve, with adjacent change points whose far germs lie off (Q) arcs; their
hypotheses' satisfiability is the open (Q)-ring question of FS-124 (no held fragment has two adjacent change points of this
kind). `doubleTip` is proved from `not_sole_tip_of_adjacent_changePoints` (`…/SoleTip`), which reads neither *simple* nor
the far germs.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS116-V6-ANTI, class-free -/

/-- **FS116-V6-ANTI** (any valid map; any two antipodal points of `ω(p)`): a tile with `y = r(ψ)` in its closure and a
tile with `y* = r(ψ + 180°)` in its closure have no common closure point but `p` — their closures lie in
`B̄(y, 1) ∩ B̄(y*, 1) = {p}`. So a tile tipping `y_k` and a tile tipping `y_(k+3)` share no edge at `p`. -/
theorem v6_anti (hF : F.Valid) {p : ℂ} {ψ : ℝ} {T T' : Set ℂ} (hT : F.IsTile T) (hT' : F.IsTile T')
    (hy : ringPt p ψ ∈ closure T) (hy' : ringPt p (ψ + π) ∈ closure T') : closure T ∩ closure T' ⊆ {p} := by
  rintro z ⟨hz, hz'⟩
  have h1 := mem_closedBall.mp (hT.closure_subset_closedBall hF hy hz)
  have h2 := mem_closedBall.mp (hT'.closure_subset_closedBall hF hy' hz')
  rw [dist_eq_norm] at h1 h2
  have e1 : z - ringPt p ψ = (z - p) - e ψ := by simp only [ringPt]; ring
  have e2 : z - ringPt p (ψ + π) = (z - p) + e ψ := by simp only [ringPt, e_add_pi]; ring
  rw [e1] at h1
  rw [e2] at h2
  have h4 : (e ψ).re ^ 2 + (e ψ).im ^ 2 = 1 := by rw [re_e, im_e]; exact Real.cos_sq_add_sin_sq ψ
  have hpl : ‖(z - p) - e ψ‖ ^ 2 + ‖(z - p) + e ψ‖ ^ 2 = 2 * ‖z - p‖ ^ 2 + 2 := by
    simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.add_re,
      Complex.add_im]
    linear_combination 2 * h4
  have a1 : ‖(z - p) - e ψ‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg ((z - p) - e ψ)]
  have a2 : ‖(z - p) + e ψ‖ ^ 2 ≤ 1 := by nlinarith [norm_nonneg ((z - p) + e ψ)]
  have hw0 : ‖z - p‖ ≤ 0 := by nlinarith [norm_nonneg (z - p)]
  exact mem_singleton_iff.mpr (sub_eq_zero.mp (norm_le_zero_iff.mp hw0))

/-! ## FS116-V6-HUBS -/

/-- `cos(d·60°) ≥ 1/2` for an integer `d` only when `d ≡ 0, ±1 (mod 6)`: the six values are `1, ½, −½, −1, −½, ½`. -/
theorem intCast_zmod_six_of_half_le_cos {d : ℤ} (h : 1 / 2 ≤ Real.cos (d * (π / 3))) :
    (d : ZMod 6) = 0 ∨ (d : ZMod 6) = 1 ∨ (d : ZMod 6) = -1 := by
  have hd : d = d % 6 + 6 * (d / 6) := (Int.emod_add_mul_ediv d 6).symm
  have h0 : 0 ≤ d % 6 := Int.emod_nonneg d (by norm_num)
  have h6 : d % 6 < 6 := Int.emod_lt_of_pos d (by norm_num)
  have hc : Real.cos (d * (π / 3)) = Real.cos (((d % 6 : ℤ) : ℝ) * (π / 3)) := by
    have : (d : ℝ) * (π / 3) = ((d % 6 : ℤ) : ℝ) * (π / 3) + ((d / 6 : ℤ) : ℝ) * (2 * π) := by
      conv_lhs => rw [hd]
      push_cast
      ring
    rw [this, Real.cos_add_int_mul_two_pi]
  have hz : (d : ZMod 6) = ((d % 6 : ℤ) : ZMod 6) := (ZMod.intCast_mod d 6).symm
  rw [hc] at h
  rw [hz]
  generalize d % 6 = r at h0 h6 h
  interval_cases r
  · left; rfl
  · right; left; rfl
  · exfalso
    have : Real.cos (((2 : ℤ) : ℝ) * (π / 3)) = -(1 / 2) := by
      rw [show ((2 : ℤ) : ℝ) * (π / 3) = π - π / 3 by push_cast; ring, Real.cos_pi_sub, Real.cos_pi_div_three]
    linarith
  · exfalso
    have : Real.cos (((3 : ℤ) : ℝ) * (π / 3)) = -1 := by
      rw [show ((3 : ℤ) : ℝ) * (π / 3) = π by push_cast; ring, Real.cos_pi]
    linarith
  · exfalso
    have : Real.cos (((4 : ℤ) : ℝ) * (π / 3)) = -(1 / 2) := by
      rw [show ((4 : ℤ) : ℝ) * (π / 3) = π / 3 + π by push_cast; ring, Real.cos_add_pi, Real.cos_pi_div_three]
    linarith
  · right; right; rfl

/-- Two points of `ω(p)` a multiple of `60°` apart are within distance `1` only when the multiple is `0` or `±1` modulo
`6` (the others are `√3` or `2` apart). With `IsTile.dist_le_one_of_mem_closure`: a tile tips at most two of the points
`r(ψ₀ + 60°k)`, and two only if consecutive (FS116-V6-HUBS, second clause; any valid map). -/
theorem ringPt_sixth_dist_le_one {p : ℂ} {ψ₀ : ℝ} {n m : ℤ}
    (h : dist (ringPt p (ψ₀ + n * (π / 3))) (ringPt p (ψ₀ + m * (π / 3))) ≤ 1) :
    ((n - m : ℤ) : ZMod 6) = 0 ∨ ((n - m : ℤ) : ZMod 6) = 1 ∨ ((n - m : ℤ) : ZMod 6) = -1 := by
  apply intCast_zmod_six_of_half_le_cos
  have hsq : dist (ringPt p (ψ₀ + n * (π / 3))) (ringPt p (ψ₀ + m * (π / 3))) ^ 2 =
      2 - 2 * Real.cos (((n - m : ℤ) : ℝ) * (π / 3)) := by
    rw [dist_eq_norm, show ringPt p (ψ₀ + n * (π / 3)) - ringPt p (ψ₀ + m * (π / 3)) =
      e (ψ₀ + n * (π / 3)) - e (ψ₀ + m * (π / 3)) by simp only [ringPt]; ring, sq_norm_e_sub_e]
    congr 3
    push_cast
    ring
  have h2 : dist (ringPt p (ψ₀ + n * (π / 3))) (ringPt p (ψ₀ + m * (π / 3))) ^ 2 ≤ 1 := by
    nlinarith [dist_nonneg (x := ringPt p (ψ₀ + n * (π / 3))) (y := ringPt p (ψ₀ + m * (π / 3)))]
  linarith

/-- **Inhabitant** of `ringPt_sixth_dist_le_one`'s hypothesis: consecutive sixths of a ring are exactly `1` apart. -/
example : dist (ringPt 0 (0 + ((1 : ℤ) : ℝ) * (π / 3))) (ringPt 0 (0 + ((0 : ℤ) : ℝ) * (π / 3))) ≤ 1 := by
  rw [dist_comm, show (0 : ℝ) + ((1 : ℤ) : ℝ) * (π / 3) = 0 + ((0 : ℤ) : ℝ) * (π / 3) + 1 * (π / 3) by push_cast; ring]
  exact (dist_ringPt_third 0 _ 1 (Or.inl rfl)).le

/-- **Adversary**: sixths two apart are farther than `1` — the lemma itself refutes the bound, `2 ≠ 0, ±1` in `ℤ/6`. -/
example : ¬ dist (ringPt 0 (0 + ((2 : ℤ) : ℝ) * (π / 3))) (ringPt 0 (0 + ((0 : ℤ) : ℝ) * (π / 3))) ≤ 1 := fun h => by
  have h' := ringPt_sixth_dist_le_one h
  revert h'
  decide

/-- Ring points at sixths of a turn whose indices agree modulo `6` are one point. -/
theorem ringPt_sixth_congr (p : ℂ) (ψ : ℝ) {n m : ℤ} (h : (n : ZMod 6) = (m : ZMod 6)) :
    ringPt p (ψ + n * (π / 3)) = ringPt p (ψ + m * (π / 3)) := by
  obtain ⟨q, hq⟩ := (ZMod.intCast_eq_intCast_iff_dvd_sub n m 6).mp h
  have hm : (m : ℝ) = n + 6 * q := by
    have := congrArg (Int.cast : ℤ → ℝ) hq
    push_cast at this
    linarith
  simp only [ringPt]
  rw [hm, show ψ + ((n : ℝ) + 6 * q) * (π / 3) = ψ + n * (π / 3) + 2 * π * q by ring, e_add_int_mul]

/-- Two chords of a ring: if `r(α + 60°)` is within `1` of `r(β)` and `r(α)` within `1` of `r(β + 60°)`, then
`r(α) = r(β)` (`cos δ = cos(δ + 60°) + cos(δ − 60°) ≥ 1` for `δ = α − β`). -/
theorem exists_int_of_three_dist_le_one {p : ℂ} {α β : ℝ}
    (h2 : dist (ringPt p (α + π / 3)) (ringPt p β) ≤ 1) (h3 : dist (ringPt p α) (ringPt p (β + π / 3)) ≤ 1) :
    ∃ q : ℤ, (q : ℝ) * (2 * π) = α - β := by
  have key : ∀ a b : ℝ, dist (ringPt p a) (ringPt p b) ≤ 1 → 1 / 2 ≤ Real.cos (a - b) := by
    intro a b h
    have hsq : dist (ringPt p a) (ringPt p b) ^ 2 = 2 - 2 * Real.cos (a - b) := by
      rw [dist_eq_norm, show ringPt p a - ringPt p b = e a - e b by simp only [ringPt]; ring, sq_norm_e_sub_e]
    nlinarith [dist_nonneg (x := ringPt p a) (y := ringPt p b)]
  have c2 := key _ _ h2
  have c3 := key _ _ h3
  rw [show α + π / 3 - β = (α - β) + π / 3 by ring, Real.cos_add, Real.cos_pi_div_three] at c2
  rw [show α - (β + π / 3) = (α - β) - π / 3 by ring, Real.cos_sub, Real.cos_pi_div_three] at c3
  exact (Real.cos_eq_one_iff _).mp (le_antisymm (Real.cos_le_one _) (by linarith))

/-- **No tile tips two consecutive points of each of two classes** of ring points a sixth of a turn apart, when the
classes' base angles differ by less than a sixth of a turn: the four points would be pairwise within `1`. -/
theorem not_double_two_classes (hF : F.Valid) {p : ℂ} {T : Set ℂ} (hT : F.IsTile T) {α β : ℝ} (hαβ : α < β)
    (hβα : β < α + π / 3) {n m : ℤ} (h1 : ringPt p (α + n * (π / 3)) ∈ closure T)
    (h2 : ringPt p (α + n * (π / 3) + π / 3) ∈ closure T) (h3 : ringPt p (β + m * (π / 3)) ∈ closure T)
    (h4 : ringPt p (β + m * (π / 3) + π / 3) ∈ closure T) : False := by
  have d := hT.dist_le_one_of_mem_closure hF
  obtain ⟨q, hq⟩ := exists_int_of_three_dist_le_one (d _ h2 _ h3) (d _ h1 _ h4)
  have hj : β - α = ((n - m - 6 * q : ℤ) : ℝ) * (π / 3) := by
    push_cast
    linear_combination hq
  have hπ3 : 0 < π / 3 := by positivity
  have h0 : (0 : ℝ) < ((n - m - 6 * q : ℤ) : ℝ) := by
    by_contra h
    have := mul_nonpos_of_nonpos_of_nonneg (not_lt.mp h) hπ3.le
    linarith
  have h1' : ((n - m - 6 * q : ℤ) : ℝ) < 1 := by
    by_contra h
    have := le_mul_of_one_le_left hπ3.le (not_lt.mp h)
    linarith
  have a0 : (0 : ℤ) < n - m - 6 * q := by exact_mod_cast h0
  have a1 : n - m - 6 * q < 1 := by exact_mod_cast h1'
  omega

/-- A ring point at a sixth of a turn, named by its index modulo `6`, is the point at any integer of that class. -/
theorem ringPt_mem_of_sixth {p : ℂ} {α : ℝ} {S : Set ℂ} {a : ZMod 6}
    (h : ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (α + n * (π / 3)) ∈ S) {m : ℤ} (hm : (m : ZMod 6) = a) :
    ringPt p (α + m * (π / 3)) ∈ S := by
  obtain ⟨n, hn, hS⟩ := h
  rwa [ringPt_sixth_congr p α (hm.trans hn.symm)]

/-- **A tile holds only equal or consecutive sixths of a ring** (FS116-V6-HUBS, second clause, in the form the counts
read: hubs indexed by `ℤ/6`). -/
theorem sixth_cons_of_mem_closure (hF : F.Valid) {p : ℂ} {α : ℝ} {T : Set ℂ} (hT : F.IsTile T) {a b : ZMod 6}
    (ha : ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (α + n * (π / 3)) ∈ closure T)
    (hb : ∃ n : ℤ, (n : ZMod 6) = b ∧ ringPt p (α + n * (π / 3)) ∈ closure T) : b = a ∨ b = a + 1 ∨ b = a - 1 := by
  obtain ⟨n, rfl, hn⟩ := ha
  obtain ⟨m, rfl, hm⟩ := hb
  have h := ringPt_sixth_dist_le_one (hT.dist_le_one_of_mem_closure hF _ hm _ hn)
  push_cast at h
  rcases h with h | h | h
  · exact Or.inl (by linear_combination h)
  · exact Or.inr (Or.inl (by linear_combination h))
  · exact Or.inr (Or.inr (by linear_combination h))

/-- **A class of ring points a sixth of a turn apart, each in the closure of one of four tiles, has two double tiles**:
two distinct tiles each holding two consecutive points of the class (`V6Count.twoDoubles`, with
`ringPt_sixth_dist_le_one`). -/
theorem exists_two_double_tiles (hF : F.Valid) {p : ℂ} {tile : Fin 4 → Set ℂ} (htile : ∀ i, F.IsTile (tile i)) {α : ℝ}
    (hcov : ∀ n : ℤ, ∃ i, ringPt p (α + n * (π / 3)) ∈ closure (tile i)) :
    ∃ i j, i ≠ j ∧
      (∃ n : ℤ, ringPt p (α + n * (π / 3)) ∈ closure (tile i) ∧ ringPt p (α + n * (π / 3) + π / 3) ∈ closure (tile i)) ∧
      ∃ n : ℤ, ringPt p (α + n * (π / 3)) ∈ closure (tile j) ∧ ringPt p (α + n * (π / 3) + π / 3) ∈ closure (tile j) := by
  have hcover : ∀ a : ZMod 6, ∃ i, ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (α + n * (π / 3)) ∈ closure (tile i) := by
    intro a
    obtain ⟨n, rfl⟩ := ZMod.intCast_surjective a
    obtain ⟨i, hi⟩ := hcov n
    exact ⟨i, n, rfl, hi⟩
  have step : ∀ i, (∃ a : ZMod 6, (∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (α + n * (π / 3)) ∈ closure (tile i)) ∧
      ∃ n : ℤ, (n : ZMod 6) = a + 1 ∧ ringPt p (α + n * (π / 3)) ∈ closure (tile i)) →
      ∃ n : ℤ, ringPt p (α + n * (π / 3)) ∈ closure (tile i) ∧ ringPt p (α + n * (π / 3) + π / 3) ∈ closure (tile i) := by
    rintro i ⟨a, ⟨n, rfl, hn⟩, h2⟩
    refine ⟨n, hn, ?_⟩
    have := ringPt_mem_of_sixth h2 (m := n + 1) (by push_cast; rfl)
    rwa [show α + ((n + 1 : ℤ) : ℝ) * (π / 3) = α + n * (π / 3) + π / 3 by push_cast; ring] at this
  obtain ⟨i, j, hij, hi, hj⟩ := V6Count.twoDoubles
    (fun i a => ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (α + n * (π / 3)) ∈ closure (tile i))
    (fun i _ _ ha hb => sixth_cons_of_mem_closure hF (htile i) ha hb) hcover
  exact ⟨i, j, hij, step i hi, step j hj⟩

/-- Three pairwise exclusive properties of four things cannot each hold of two of them. -/
theorem fin_four_three_pairs {P Q R : Fin 4 → Prop} (hPQ : ∀ i, P i → Q i → False) (hPR : ∀ i, P i → R i → False)
    (hQR : ∀ i, Q i → R i → False) (hP : ∃ i j, i ≠ j ∧ P i ∧ P j) (hQ : ∃ i j, i ≠ j ∧ Q i ∧ Q j)
    (hR : ∃ i j, i ≠ j ∧ R i ∧ R j) : False := by
  classical
  obtain ⟨i₁, i₂, h12, p1, p2⟩ := hP
  obtain ⟨i₃, i₄, h34, q1, q2⟩ := hQ
  obtain ⟨i₅, i₆, h56, r1, r2⟩ := hR
  have cA : 2 ≤ (Finset.univ.filter P).card :=
    Finset.one_lt_card.mpr ⟨i₁, by simp [p1], i₂, by simp [p2], h12⟩
  have cB : 2 ≤ (Finset.univ.filter Q).card :=
    Finset.one_lt_card.mpr ⟨i₃, by simp [q1], i₄, by simp [q2], h34⟩
  have cC : 2 ≤ (Finset.univ.filter R).card :=
    Finset.one_lt_card.mpr ⟨i₅, by simp [r1], i₆, by simp [r2], h56⟩
  have dAB : Disjoint (Finset.univ.filter P) (Finset.univ.filter Q) :=
    Finset.disjoint_left.mpr fun i hi hi' => hPQ i (by simpa using hi) (by simpa using hi')
  have dABC : Disjoint (Finset.univ.filter P ∪ Finset.univ.filter Q) (Finset.univ.filter R) :=
    Finset.disjoint_union_left.mpr ⟨Finset.disjoint_left.mpr fun i hi hi' => hPR i (by simpa using hi) (by simpa using hi'),
      Finset.disjoint_left.mpr fun i hi hi' => hQR i (by simpa using hi) (by simpa using hi')⟩
  have hc := Finset.card_le_univ (Finset.univ.filter P ∪ Finset.univ.filter Q ∪ Finset.univ.filter R)
  rw [Finset.card_union_of_disjoint dABC, Finset.card_union_of_disjoint dAB, Fintype.card_fin] at hc
  omega

/-- **No two change points of a Γ-free ring are less than a sixth of a turn apart** (H7; FS116-V6-HUBS, `m = 1`, without
*simple*). Two such have a third in the window (`exists_third_change`); the three classes of change points, a sixth of a
turn apart within each, are covered by the four tiles of `p` (every change point has a tip, `star_tip_nonempty`), so
each class has two double tiles (`exists_two_double_tiles`), and no tile is double in two classes
(`not_double_two_classes`): six tiles among four. (The count of FS116-V6-HUBS alone gives only `m ≤ 2`; the third
change point is the colour argument.) -/
theorem GammaFreeRing.changePoint_gap {p : ℂ} (hΓ : F.GammaFreeRing p) (hF : F.Valid) (hN : F.NonSiamese)
    (hp : F.Covers p 1) (hn4 : (F.coloursAt p).ncard = 4) (hk : k ≤ 6) {κ : ℝ → Side → Fin k}
    (hκ : ∀ θ s, GermIn p θ s (F.region (κ θ s))) {X X' : Fin k} (hr : ∀ θ s, κ θ s = X ∨ κ θ s = X') {ψ₁ ψ₂ : ℝ}
    (h₁ : κ ψ₁ .ccw ≠ κ ψ₁ .cw) (h₂ : κ ψ₂ .ccw ≠ κ ψ₂ .cw) (h12 : ψ₁ < ψ₂) (hlt : ψ₂ < ψ₁ + π / 3) : False := by
  obtain ⟨ψ₃, hψ₃, hne, h₃⟩ := exists_third_change hF hκ hr h₁ h₂ h12 hlt
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  obtain ⟨tile, htile, hsurj⟩ := exists_fin_tileAt hF hN hpd hn4.le
  have hcov : ∀ ψ, κ ψ .ccw ≠ κ ψ .cw → ∀ n : ℤ, ∃ i, ringPt p (ψ + n * (π / 3)) ∈ closure (tile i) := by
    intro ψ hψ n
    obtain ⟨Xc, Xc', hy⟩ := (exists_isChangePoint_iff hp hκ _).mpr ((germCol_change_int hF hκ hr ψ n).mpr hψ)
    obtain ⟨c, T, -, hT⟩ := star_tip_nonempty hF hN hp (by omega) (by omega) hy
      ⟨hΓ.qFreeRing.not_germOnQ _ _, hΓ.qFreeRing.not_germOnQ _ _⟩
    obtain ⟨i, rfl⟩ := hsurj T ⟨hT.1, hT.2.1⟩
    exact ⟨i, hT.2.2⟩
  have hT : ∀ i, F.IsTile (tile i) := fun i => (htile i).1
  refine fin_four_three_pairs
    (P := fun i => ∃ n : ℤ, ringPt p (ψ₁ + n * (π / 3)) ∈ closure (tile i) ∧
      ringPt p (ψ₁ + n * (π / 3) + π / 3) ∈ closure (tile i))
    (Q := fun i => ∃ n : ℤ, ringPt p (ψ₂ + n * (π / 3)) ∈ closure (tile i) ∧
      ringPt p (ψ₂ + n * (π / 3) + π / 3) ∈ closure (tile i))
    (R := fun i => ∃ n : ℤ, ringPt p (ψ₃ + n * (π / 3)) ∈ closure (tile i) ∧
      ringPt p (ψ₃ + n * (π / 3) + π / 3) ∈ closure (tile i))
    ?_ ?_ ?_ (exists_two_double_tiles hF hT (hcov ψ₁ h₁)) (exists_two_double_tiles hF hT (hcov ψ₂ h₂))
    (exists_two_double_tiles hF hT (hcov ψ₃ h₃))
  · rintro i ⟨n, a1, a2⟩ ⟨m, b1, b2⟩
    exact not_double_two_classes hF (hT i) h12 hlt a1 a2 b1 b2
  · rintro i ⟨n, a1, a2⟩ ⟨m, b1, b2⟩
    exact not_double_two_classes hF (hT i) hψ₃.1 hψ₃.2 a1 a2 b1 b2
  · rintro i ⟨n, a1, a2⟩ ⟨m, b1, b2⟩
    rcases lt_or_gt_of_ne hne with h | h
    · exact not_double_two_classes hF (hT i) h (by linarith [hψ₃.1]) b1 b2 a1 a2
    · exact not_double_two_classes hF (hT i) h (by linarith [hψ₃.2]) a1 a2 b1 b2

/-- **FS116-V6-HUBS**, `m = 1` (without *simple*): in a valid non-Siamese six-coloured fragment on a closed disc of radius
above 1 about a vertex `p` of at least four colours whose ring carries no arc of `Γ`, the change points of the ring are
the six points `r(ψ₀ + 60°k)`.

VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation and is consumed
nowhere else. -/
theorem v6_hubs {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) :
    ∃ ψ₀ : ℝ, ∀ ψ : ℝ, (∃ X X', F.IsChangePoint p ψ X X') ↔ ∃ n : ℤ, ψ = ψ₀ + n * (π / 3) := by
  obtain ⟨X, X', -, hc⟩ := hΓ.exists_absent_pair hF hp h4 (by omega)
  have hn4 : (F.coloursAt p).ncard = 4 := by
    have := qfree4 hF hp h4 hΓ.qFreeRing
    omega
  choose κ hκ using fun θ s => hΓ.exists_germIn hp θ s
  have hr : ∀ θ s, κ θ s = X ∨ κ θ s = X' := fun θ s => by
    have hmem : κ θ s ∈ (F.coloursAt p)ᶜ := not_mem_coloursAt_of_germIn hF (hκ θ s)
    rw [hc] at hmem
    exact hmem
  obtain ⟨ψ₀, hψ₀⟩ := exists_germCol_change hF hκ
  refine ⟨ψ₀, fun ψ => ?_⟩
  rw [exists_isChangePoint_iff hp hκ]
  constructor
  · intro hψ
    have hπ3 : 0 < π / 3 := by positivity
    refine ⟨⌊(ψ - ψ₀) / (π / 3)⌋, ?_⟩
    have hfl := Int.floor_le ((ψ - ψ₀) / (π / 3))
    have hlt := Int.lt_floor_add_one ((ψ - ψ₀) / (π / 3))
    rw [le_div_iff₀ hπ3] at hfl
    rw [div_lt_iff₀ hπ3] at hlt
    by_contra hne
    exact hΓ.changePoint_gap hF hN hp hn4 le_rfl hκ hr
      ((germCol_change_int hF hκ hr ψ₀ ⌊(ψ - ψ₀) / (π / 3)⌋).mpr hψ₀) hψ
      (lt_of_le_of_ne (by linarith) fun h => hne h.symm) (by linarith)
  · rintro ⟨n, rfl⟩
    exact (germCol_change_int hF hκ hr ψ₀ n).mpr hψ₀

/-! ## FS116-V6-HUG -/

/-- **FS116-V6-HUG** (without *simple*, with its own colour step V6-GERM): in the Γ-free class, no tile of `p` tips two
adjacent change points `y = r(ψ)` and `y' = r(ψ + 60°)` while being the only tip at each.

VACUITY DECLARED: the class is empty (`emptyNS`, FS129-SR3-EMPTY-NS); this is a step of that refutation. Outside the
Γ-free class the statement to use is `doubleTip`. (The proof reads no Γ-free ring: it is
`not_sole_tip_of_adjacent_changePoints`, `Plane/RingCalculus/SoleTip`, which `emptyNS` consumes.) -/
theorem v6_hug {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) {ψ : ℝ} {X X' Y Y' : Fin 6}
    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y') {T : Set ℂ}
    (hT : F.IsTip p (ringPt p ψ) T) (hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False := by
  -- the argument reads no Γ-free ring: `not_sole_tip_of_adjacent_changePoints` (`Plane/RingCalculus/SoleTip`)
  have _ := hΓ
  exact not_sole_tip_of_adjacent_changePoints hF hN hp h4 (by omega) hy hy' hT hT' h1 h2

/-! ## FS116-V6-COUNT -/

/-- **FS116-V6-COUNT**, the count, as finite combinatorics: four tiles, six hubs in cyclic order; every hub has a tip; a
tile tips only hubs that are equal or consecutive; no tile tips two consecutive hubs while being the only tip at each.
Then two antipodal hubs `a`, `a + 3` have exactly two tips each, every tile tips one of them and not the other, and every
tile tips exactly two hubs (`M = 4`, `s = 2`).

Not vacuous: 72 configurations meet the hypotheses, and all satisfy the conclusion (`tools/fs131_k8_count.py`). -/
theorem v6_count (tip : Fin 4 → ZMod 6 → Prop) (hcover : ∀ a, ∃ i, tip i a)
    (hcons : ∀ i a b, tip i a → tip i b → b = a ∨ b = a + 1 ∨ b = a - 1)
    (hhug : ∀ i a, tip i a → tip i (a + 1) → (∃ j, j ≠ i ∧ tip j a) ∨ ∃ j, j ≠ i ∧ tip j (a + 1)) :
    ∃ a : ZMod 6, (∀ i, tip i a ∨ tip i (a + 3)) ∧ (∀ i, ¬ (tip i a ∧ tip i (a + 3))) ∧
      (∃ i j, i ≠ j ∧ ∀ l, tip l a ↔ l = i ∨ l = j) ∧ (∃ i j, i ≠ j ∧ ∀ l, tip l (a + 3) ↔ l = i ∨ l = j) ∧
      ∀ i, ∃ b, tip i b ∧ tip i (b + 1) :=
  V6Count.count tip hcons hcover hhug

/-- **FS116-V6-COUNT**, the last step, without sectors: at a point `p` of the domain, if the tiles of `p` are split into
two non-empty groups, some tile of one group and some tile of the other have a common closure point other than `p` (the
groups' closures are closed sets covering a small circle about `p`, which is connected). -/
theorem exists_ne_mem_closure_inter_of_split {p : ℂ} (hp : p ∈ F.dom) {A B : Set (Set ℂ)}
    (hAB : ∀ T, F.TileAt p T → T ∈ A ∨ T ∈ B) (hA : ∃ T ∈ A, F.TileAt p T) (hB : ∃ T ∈ B, F.TileAt p T) :
    ∃ T ∈ A, ∃ T' ∈ B, F.TileAt p T ∧ F.TileAt p T' ∧ ∃ z, z ≠ p ∧ z ∈ closure T ∩ closure T' := by
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hp
  obtain ⟨ρ₁, hρ₁, hdom, hnear⟩ := exists_ball_tileAt hp
  have hρpos : 0 < min ρ₀ ρ₁ / 2 := by
    have := lt_min hG.pos hρ₁
    linarith
  have hρlt0 : min ρ₀ ρ₁ / 2 < ρ₀ := by
    have := min_le_left ρ₀ ρ₁
    linarith [hG.pos]
  have hρlt1 : min ρ₀ ρ₁ / 2 < ρ₁ := by
    have := min_le_right ρ₀ ρ₁
    linarith
  have hfin := finite_tileAt hp
  have hCA : IsClosed (⋃ T ∈ {T | T ∈ A ∧ F.TileAt p T}, closure T) :=
    (hfin.subset fun T hT => hT.2).isClosed_biUnion fun T _ => isClosed_closure
  have hCB : IsClosed (⋃ T ∈ {T | T ∈ B ∧ F.TileAt p T}, closure T) :=
    (hfin.subset fun T hT => hT.2).isClosed_biUnion fun T _ => isClosed_closure
  have hcov : sphere p (min ρ₀ ρ₁ / 2) ⊆
      (⋃ T ∈ {T | T ∈ A ∧ F.TileAt p T}, closure T) ∪ ⋃ T ∈ {T | T ∈ B ∧ F.TileAt p T}, closure T := by
    intro z hz
    obtain ⟨T, hTp, hzT⟩ := mem_iUnion₂.mp (sphere_subset_iUnion_closure_tileAt hdom hnear hρlt1 hz)
    rcases hAB T hTp with h | h
    · exact Or.inl (mem_iUnion₂.mpr ⟨T, ⟨h, hTp⟩, hzT⟩)
    · exact Or.inr (mem_iUnion₂.mpr ⟨T, ⟨h, hTp⟩, hzT⟩)
  obtain ⟨TA, hTA, hTAp⟩ := hA
  obtain ⟨TB, hTB, hTBp⟩ := hB
  obtain ⟨zA, hzA, hzAS⟩ := hTAp.inter_sphere_nonempty hG hρpos hρlt0
  obtain ⟨zB, hzB, hzBS⟩ := hTBp.inter_sphere_nonempty hG hρpos hρlt0
  obtain ⟨z, hzS, hzCA, hzCB⟩ := isPreconnected_closed_iff.mp (isPreconnected_sphere_complex p _) _ _ hCA hCB hcov
    ⟨zA, hzAS, mem_iUnion₂.mpr ⟨TA, ⟨hTA, hTAp⟩, subset_closure hzA⟩⟩
    ⟨zB, hzBS, mem_iUnion₂.mpr ⟨TB, ⟨hTB, hTBp⟩, subset_closure hzB⟩⟩
  obtain ⟨T, ⟨hTA', hTp⟩, hzT⟩ := mem_iUnion₂.mp hzCA
  obtain ⟨T', ⟨hTB', hTp'⟩, hzT'⟩ := mem_iUnion₂.mp hzCB
  refine ⟨T, hTA', T', hTB', hTp, hTp', z, ?_, hzT, hzT'⟩
  rintro rfl
  rw [mem_sphere, dist_self] at hzS
  linarith

/-- **Inhabitant of the split lemma's hypotheses** (`halfPlane2` at its change point `r(0) = 1`, a point of two tiles;
the lemma reads no validity): split the tiles of that point into those of colour `1` and the others — both groups are
non-empty, and the lemma gives two of them a common closure point other than the point. -/
example : ∃ T, halfPlane2.TileOf 1 T ∧ ∃ T', ¬ halfPlane2.TileOf 1 T' ∧ halfPlane2.TileAt (ringPt 0 0) T ∧
    halfPlane2.TileAt (ringPt 0 0) T' ∧ ∃ z, z ≠ ringPt 0 0 ∧ z ∈ closure T ∩ closure T' := by
  have hy := halfPlane2_isChangePoint
  have hpd : ringPt (0 : ℂ) 0 ∈ halfPlane2.dom := hy.1.1
  obtain ⟨T1, hT1, hp1⟩ := (halfPlane2.mem_coloursAt_iff_exists_tileOf hpd).mp hy.2.2.1.ringPt_mem_closure
  obtain ⟨T0, hT0, hp0⟩ := (halfPlane2.mem_coloursAt_iff_exists_tileOf hpd).mp hy.2.2.2.ringPt_mem_closure
  have hne : ¬ halfPlane2.TileOf 1 T0 := fun h => by
    obtain ⟨z, hz⟩ := hT0.1.nonempty
    exact absurd ((hT0.2 hz).symm.trans (h.2 hz)) (by decide)
  obtain ⟨T, hT, T', hT', hTp, hTp', hz⟩ := exists_ne_mem_closure_inter_of_split hpd
    (A := {T | halfPlane2.TileOf 1 T}) (B := {T | ¬ halfPlane2.TileOf 1 T}) (fun T _ => em _)
    ⟨T1, hT1, hT1.1, hp1⟩ ⟨T0, hne, hT0.1, hp0⟩
  exact ⟨T, hT, T', hT', hTp, hTp', hz⟩

/-! ## FS129-SR3-EMPTY-NS -/

/-- **FS129-SR3-EMPTY-NS** (carrying FS116-Y4-EMPTY and FS116-Y4-OBST): no valid non-Siamese six-coloured fragment on a
closed disc of radius above 1 about a vertex `p` of at least four colours has a ring carrying no arc of `Γ`.

A refutation. Its hypotheses hold together at nine colours on FS111-W-SQ9's lattice vertex (module docstring), where five
colours are absent. **The Lean model is owed**: the map is `sq9Map : ArcMap 9` (`Plane/Saturated/Sq9Map`, wave 6); the
facts owed about it are `Valid`, `NonSiamese`, `Covers` at a lattice vertex, four colours there, and `GammaFreeRing`
there. -/
theorem emptyNS {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) : False := by
  obtain ⟨ψ₀, hψ₀⟩ := v6_hubs hF hN hp h4 hΓ
  have hn4 : (F.coloursAt p).ncard = 4 := by
    have := qfree4 hF hp h4 hΓ.qFreeRing
    omega
  have hpd : p ∈ F.dom := hp (mem_closedBall_self zero_le_one)
  obtain ⟨tile, htile, hsurj⟩ := exists_fin_tileAt hF hN hpd hn4.le
  -- every hub is a change point, and has a tip among the four tiles
  have hch : ∀ n : ℤ, ∃ X X', F.IsChangePoint p (ψ₀ + n * (π / 3)) X X' := fun n => (hψ₀ _).mpr ⟨n, rfl⟩
  have hcover : ∀ a : ZMod 6, ∃ i, ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (ψ₀ + n * (π / 3)) ∈ closure (tile i) := by
    intro a
    obtain ⟨n, rfl⟩ := ZMod.intCast_surjective a
    obtain ⟨X, X', hy⟩ := hch n
    obtain ⟨c, T, -, hT⟩ := star_tip_nonempty hF hN hp h4 (by omega) hy
      ⟨hΓ.qFreeRing.not_germOnQ _ _, hΓ.qFreeRing.not_germOnQ _ _⟩
    obtain ⟨i, rfl⟩ := hsurj T ⟨hT.1, hT.2.1⟩
    exact ⟨i, n, rfl, hT.2.2⟩
  -- FS116-V6-HUG, in the count's form
  have hhug : ∀ i (a : ZMod 6),
      (∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (ψ₀ + n * (π / 3)) ∈ closure (tile i)) →
      (∃ n : ℤ, (n : ZMod 6) = a + 1 ∧ ringPt p (ψ₀ + n * (π / 3)) ∈ closure (tile i)) →
      (∃ j, j ≠ i ∧ ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (ψ₀ + n * (π / 3)) ∈ closure (tile j)) ∨
        ∃ j, j ≠ i ∧ ∃ n : ℤ, (n : ZMod 6) = a + 1 ∧ ringPt p (ψ₀ + n * (π / 3)) ∈ closure (tile j) := by
    rintro i a ⟨n, rfl, hn⟩ h2
    have e1 : ψ₀ + ((n + 1 : ℤ) : ℝ) * (π / 3) = ψ₀ + n * (π / 3) + π / 3 := by push_cast; ring
    have hn' : ringPt p (ψ₀ + n * (π / 3) + π / 3) ∈ closure (tile i) := by
      have := ringPt_mem_of_sixth h2 (m := n + 1) (by push_cast; rfl)
      rwa [e1] at this
    by_contra hcon
    push Not at hcon
    obtain ⟨X, X', hy⟩ := hch n
    obtain ⟨Y, Y', hy'⟩ := hch (n + 1)
    rw [e1] at hy'
    refine v6_hug hF hN hp h4 hΓ hy hy' (T := tile i) ⟨(htile i).1, (htile i).2, hn⟩ ⟨(htile i).1, (htile i).2, hn'⟩
      (fun S hS => ?_) fun S hS => ?_
    · obtain ⟨j, rfl⟩ := hsurj S ⟨hS.1, hS.2.1⟩
      by_contra hji
      exact hcon.1 j (fun h => hji (h ▸ rfl)) n rfl hS.2.2
    · obtain ⟨j, rfl⟩ := hsurj S ⟨hS.1, hS.2.1⟩
      by_contra hji
      refine hcon.2 j (fun h => hji (h ▸ rfl)) (n + 1) (by push_cast; rfl) ?_
      rw [e1]
      exact hS.2.2
  -- the count: two antipodal hubs between them are tipped by every tile of `p`
  obtain ⟨a, hor, -⟩ := v6_count
    (fun i a => ∃ n : ℤ, (n : ZMod 6) = a ∧ ringPt p (ψ₀ + n * (π / 3)) ∈ closure (tile i)) hcover
    (fun i _ _ ha hb => sixth_cons_of_mem_closure hF (htile i).1 ha hb) hhug
  obtain ⟨n, rfl⟩ := ZMod.intCast_surjective a
  have e3 : ψ₀ + ((n + 3 : ℤ) : ℝ) * (π / 3) = ψ₀ + n * (π / 3) + π := by push_cast; ring
  -- split the tiles of `p` into tippers of the hub and tippers of its antipode; two of them share a closure point
  -- other than `p` (`exists_ne_mem_closure_inter_of_split`), against FS116-V6-ANTI
  obtain ⟨T, hTA, T', hT'B, hTp, hT'p, z, hzp, hz⟩ := exists_ne_mem_closure_inter_of_split hpd
    (A := {T | ringPt p (ψ₀ + n * (π / 3)) ∈ closure T}) (B := {T | ringPt p (ψ₀ + n * (π / 3) + π) ∈ closure T})
    (fun T hT => by
      obtain ⟨i, rfl⟩ := hsurj T hT
      rcases hor i with h | h
      · exact Or.inl (ringPt_mem_of_sixth h rfl)
      · refine Or.inr ?_
        have := ringPt_mem_of_sixth h (m := n + 3) (by push_cast; rfl)
        rwa [e3] at this)
    (by
      obtain ⟨i, h⟩ := hcover (n : ZMod 6)
      exact ⟨tile i, ringPt_mem_of_sixth h rfl, htile i⟩)
    (by
      obtain ⟨i, h⟩ := hcover ((n : ZMod 6) + 3)
      refine ⟨tile i, ?_, htile i⟩
      have := ringPt_mem_of_sixth h (m := n + 3) (by push_cast; rfl)
      rwa [e3] at this)
  exact hzp (v6_anti hF hTp.1 hT'p.1 hTA hT'B hz)

/-! ## The vacuity markers, as kernel facts (ruling, inventory item 518) -/

/-- **The marker on `v6_hubs` is a fact**: its exact hypotheses are refuted — they are `emptyNS`'s. -/
theorem v6_hubs_vacuous {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) : False :=
  emptyNS hF hN hp h4 hΓ

/-- **The marker on `v6_hug` is a fact**: its exact hypotheses are refuted by the emptiness theorem alone, whatever the
change points and the tile (`v6_hug` reaches the same `False` by its own argument, which `emptyNS` consumes). -/
theorem v6_hug_vacuous {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hΓ : F.GammaFreeRing p) {ψ : ℝ} {X X' Y Y' : Fin 6}
    (_hy : F.IsChangePoint p ψ X X') (_hy' : F.IsChangePoint p (ψ + π / 3) Y Y') {T : Set ℂ}
    (_hT : F.IsTip p (ringPt p ψ) T) (_hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (_h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (_h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False :=
  emptyNS hF hN hp h4 hΓ

/-! ## FS129-SR3-OUTERADJ and FS129-MR1-DOUBLETIP: adjacent change points -/

/-- **FS129-SR3-OUTERADJ** (carrying FS116-V6-ADJ): in a valid non-Siamese six-coloured fragment on a closed disc of radius
above 1 about a vertex `p` of at least four colours, let `y = r(ψ)` and `y' = r(ψ + 60°)` be change points of the ring such
that neither the germ just counter-clockwise of `r(ψ − 60°)` nor the germ just clockwise of `r(ψ + 120°)` lies on a (Q)
arc. Then no colour is at once the only outer colour at `y` and the only outer colour at `y'` ("the only colour carried
at `y` by a tile that is not a tile of `p`" is read as `O_y = {c}`: the ring's own two colours are carried there by tiles
that are not tiles of `p`, and are not colours of `p`).

The hypotheses' satisfiability is open (two adjacent change points with free outer pairs: FS-124's (Q)-ring question; on a
Γ-free ring there is none, `emptyNS`). -/
theorem outerAdj {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) {ψ : ℝ} {X X' Y Y' : Fin 6} (hy : F.IsChangePoint p ψ X X')
    (hy' : F.IsChangePoint p (ψ + π / 3) Y Y') (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw)
    (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .cw) (c : Fin 6) :
    ¬ (F.outerTileColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π / 3)) = {c}) := by
  sorry

/-- **FS129-MR1-DOUBLETIP**: in a valid non-Siamese six-coloured fragment, simple on `B̄(p, 1)`, on a closed disc of radius
above 1 about a vertex `p` of at least four colours, let `y = r(ψ)` and `y' = r(ψ + 60°)` be change points of the ring
such that neither the germ just clockwise of `r(ψ − 60°)` nor the germ just counter-clockwise of `r(ψ + 120°)` lies on a
(Q) arc. Then no tile of `p` is at once the only tip at `y` and the only tip at `y'`.

The hypotheses' satisfiability is open (FS-124's (Q)-ring question; on a Γ-free ring there is none, `emptyNS`).

Proved from `not_sole_tip_of_adjacent_changePoints` (`Plane/RingCalculus/SoleTip`), which reads neither *simple* (`hS`) nor
the two germs (`hv`, `hu`): the statement holds at the wider class, and keeps its three hypotheses as filed. -/
theorem doubleTip {F : ArcMap 6} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
    (hS : F.SimpleOn (closedBall p 1)) (h4 : 4 ≤ (F.coloursAt p).ncard) {ψ : ℝ} {X X' Y Y' : Fin 6}
    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y')
    (hv : ¬ F.GermOnQ p (ψ - π / 3) .cw) (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .ccw) {T : Set ℂ}
    (hT : F.IsTip p (ringPt p ψ) T) (hT' : F.IsTip p (ringPt p (ψ + π / 3)) T)
    (h1 : ∀ S, F.IsTip p (ringPt p ψ) S → S = T) (h2 : ∀ S, F.IsTip p (ringPt p (ψ + π / 3)) S → S = T) :
    False := by
  -- the argument reads neither *simple* nor the two far germs: `not_sole_tip_of_adjacent_changePoints`
  -- (`Plane/RingCalculus/SoleTip`); the three hypotheses stay in the statement (the coordinator's ruling, FS131-I8A)
  have _ := hS
  have _ := hv
  have _ := hu
  exact not_sole_tip_of_adjacent_changePoints hF hN hp h4 (by omega) hy hy' hT hT' h1 h2

end ArcMap

end HadwigerNelson.Plane
