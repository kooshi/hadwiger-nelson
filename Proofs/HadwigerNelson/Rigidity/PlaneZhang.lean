import Proofs.HadwigerNelson.Plane.WindowDensity
import Proofs.HadwigerNelson.Rigidity.FiniteZhang

/-!
# Zhang's count on the plane times a finite Cayley graph, in a window (FS-131, job FS131-K12A; module M12, block C; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C5: "social and lonely points, essential neighbourhoods,
`p_j ≤ ¼(1 − β_j) + r_X β_j`"; R88-TC-count; `[Zhang2012]` Thm 1.8's counting). A finite additive group `Q` with a symmetric
connection set `S` of ratio at most `r`, and a measurable set of `ℂ × Q` given by its rows `Y q ⊆ ℂ`, whose edges are null:
for every `q` and `s ∈ S`, the pairs `(z, θ)` with `z ∈ Y q` and `z + e^{iθ} ∈ Y (q + s)` form a null set — the edge set of
`UD(ℝ²) ⊗ Cay(Q, S)` met in measure zero. Then in every large square window the rows hold at most the fraction
`max(m₁, r)` of `|Q|·s²`, up to `ε`:

* `lonely Y b` — the points of row `b` whose unit circle meets row `b` in length zero (J28D's `X^{j*}_b`); it has null unit
  pairs (`unitPairsNull_lonely`).
* `social Y z` — the rows `q` with `z ∈ Y q` and positive length of row `q` on the unit circle about `z` (`A^j_x`); for
  almost every `z` it is independent in `Cay(Q, S)` (`ae_sIndep_social`, J28D (i)).
* `touched Y z` — the rows `b` with `z` in the essential neighbourhood of `lonely Y b` (`B^j(x)`); for almost every `z` it
  misses `N[social Y z]` (`ae_disjoint_touched`, J28D (ii′)).
* `sum_volume_inter_sq_le` — **the count**: `|social| ≤ r (|Q| − |touched|)` (finite neighbourhood ratio,
  `card_le_mul_card_closedNbhd`) and `Σ_b |lonely ∩ Q| ≤ m₁ ∫_Q |touched| + ε |Q| s²` (`Plane.NRWindow`, whose scale is
  uniform in the set: `Plane.exists_nrWindow`).

**Models.** Every row empty; or `Q` a single point with `S = ∅` and one row the disc of radius `1/3`.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Set Plane

noncomputable section

variable {Q : Type*} [AddCommGroup Q] [Fintype Q] [DecidableEq Q]

/-- The lonely points of row `b`: in `Y b`, with unit circle meeting `Y b` in length zero. -/
def lonely (Y : Q → Set ℂ) (b : Q) : Set ℂ := {z | z ∈ Y b ∧ phi (Y b) z = 0}

/-- The rows in which `z` is social. -/
def social (Y : Q → Set ℂ) (z : ℂ) : Finset Q := by
  classical exact Finset.univ.filter fun q => z ∈ Y q ∧ phi (Y q) z ≠ 0

/-- The rows `b` with `z` in the essential neighbourhood of `lonely Y b`. -/
def touched (Y : Q → Set ℂ) (z : ℂ) : Finset Q := by
  classical exact Finset.univ.filter fun b => z ∈ essNbhd (lonely Y b)

/-- The edges of `UD(ℝ²) ⊗ Cay(Q, S)` inside the rows are null. -/
def RowsEdgeNull (S : Set Q) (Y : Q → Set ℂ) : Prop :=
  ∀ q, ∀ s ∈ S, (volume.prod arcLength) (pairSet (Y q) (Y (q + s))) = 0

theorem unitPairsNull_lonely {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (b : Q) : UnitPairsNull (lonely Y b) := by
  sorry

theorem measurableSet_lonely {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (b : Q) : MeasurableSet (lonely Y b) := by
  sorry

/-- J28D (i): for almost every `z`, the rows in which `z` is social are independent. -/
theorem ae_sIndep_social {S : Set Q} (hS : ∀ s ∈ S, -s ∈ S) {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q))
    (h : RowsEdgeNull S Y) : ∀ᵐ z ∂volume, SIndep S (social Y z) := by
  sorry

/-- J28D (ii′): for almost every `z`, no touched row lies in the closed neighbourhood of the social rows. -/
theorem ae_disjoint_touched {S : Set Q} (hS : ∀ s ∈ S, -s ∈ S) {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q))
    (h : RowsEdgeNull S Y) : ∀ᵐ z ∂volume, Disjoint (closedNbhd S (social Y z)) (touched Y z) := by
  sorry

/-- **Zhang's count on `UD(ℝ²) ⊗ Cay(Q, S)`, in a window**, at the scale `s₀` of the plane's neighbourhood ratio — so
uniform in `Q`, `S` and the rows. -/
theorem sum_volume_inter_sq_le {S : Set Q} (hS : ∀ s ∈ S, -s ∈ S) {r : ℝ} (hr : RatioLe S r) (hr0 : 0 ≤ r)
    {Y : Q → Set ℂ} (hY : ∀ q, MeasurableSet (Y q)) (h : RowsEdgeNull S Y) {ε s₀ : ℝ} (hN : NRWindow ε s₀) (a : ℂ)
    {s : ℝ} (hs : s₀ ≤ s) : ∑ q, volume.real (Y q ∩ squareWin a s) ≤ (max mOne.toReal r + ε) * Nat.card Q * s ^ 2 := by
  sorry

/-! ## Spec examples -/

/-- Empty rows have null edges. -/
example (S : Set Q) : RowsEdgeNull S (fun _ : Q => (∅ : Set ℂ)) := by
  intro q s _
  simp [pairSet]

end

end HadwigerNelson.Rigidity
