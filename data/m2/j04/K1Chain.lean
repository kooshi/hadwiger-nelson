import Proofs.HadwigerNelson.Forcer
import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.OneDefect

/-!
# K1 skeleton (J04 → J14): the chain theorem, FS-45 D1–D3

The skeleton J14 inherits. `sorry` at every leaf not closed by J04's two-leaf pricing. Statements are the plan's §S (K1).
`autoImplicit` is switched off here because `lake env lean` does not apply the lakefile's options.
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace Chain

open SimpleGraph Complex

/-! ## The chain drawing -/

/-- The chain's `n`-th junction point, `δ·(u₀ + ⋯ + u_{n−1})`; copy `j` starts at `junction δ u j`. -/
noncomputable def junction {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) (n : ℕ) : ℂ :=
  δ * ∑ i : Fin m with i.val < n, u i

/-- Copy `j` of the forcer's drawing `q`, its marked vertex `a` placed at junction `j` and turned by `u j`. -/
noncomputable def chainDrawing {ι : Type*} {m : ℕ} (q : ι → ℂ) (a : ι) (δ : ℂ) (u : Fin m → ℂ) :
    Fin m × ι → ℂ :=
  fun p => junction δ u p.1 + u p.1 * (q p.2 - q a)

/-- The chain's point set. The union is the unit-distance graph **induced on this set**, so the points two
consecutive copies share are one vertex — a `comap` union (as `Copy.copyUnion`) would keep them apart. -/
def chainPoints {ι : Type*} {m : ℕ} (q : ι → ℂ) (a : ι) (δ : ℂ) (u : Fin m → ℂ) : Set ℂ :=
  Set.range (chainDrawing q a δ u)

/-! ## Leaf 1 (priced by J04): consecutive junctions differ by `δ·u j` -/

theorem junction_zero {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) : junction δ u 0 = 0 := by
  simp [junction]

theorem junction_succ {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) (j : Fin m) :
    junction δ u (j.val + 1) = junction δ u j.val + δ * u j := by
  unfold junction
  rw [← mul_add]
  congr 1
  have hsplit : (Finset.univ.filter fun i : Fin m => i.val < j.val + 1) =
      insert j (Finset.univ.filter fun i : Fin m => i.val < j.val) := by
    ext i
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert]
    constructor
    · intro h
      rcases Nat.lt_succ_iff_lt_or_eq.mp h with h | h
      · exact Or.inr h
      · exact Or.inl (Fin.ext h)
    · rintro (rfl | h) <;> omega
  rw [hsplit, Finset.sum_insert (by simp), add_comm]

theorem junction_last {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) : junction δ u m = δ * ∑ j, u j := by
  unfold junction
  congr 1
  exact Finset.sum_congr (Finset.filter_true_of_mem fun i _ => i.isLt) fun _ _ => rfl

/-- The far end of copy `j` is the start of copy `j + 1`. -/
theorem chainDrawing_b {ι : Type*} {m : ℕ} (q : ι → ℂ) {a b : ι} (u : Fin m → ℂ) (j : Fin m) :
    chainDrawing q a (q b - q a) u (j, b) = junction (q b - q a) u (j.val + 1) := by
  simp only [chainDrawing, junction_succ]
  ring

/-! ## Leaf 2 (priced by J04): each copy maps into the chain graph -/

/-- Copy `j` as a graph homomorphism from the forcer into the chain graph. -/
noncomputable def copyHom {ι : Type*} {G : SimpleGraph ι} {m : ℕ} (q : ι → ℂ)
    (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) (a : ι) (δ : ℂ) (u : Fin m → ℂ)
    (hu : ∀ j, ‖u j‖ = 1) (j : Fin m) :
    G →g (unitDistance ℂ).induce (chainPoints q a δ u) where
  toFun z := ⟨chainDrawing q a δ u (j, z), (j, z), rfl⟩
  map_rel' {x y} hxy := by
    simp only [SimpleGraph.comap_adj, Function.Embedding.coe_subtype, unitDistance_adj, chainDrawing,
      dist_eq_norm]
    have : junction δ u j + u j * (q x - q a) - (junction δ u j + u j * (q y - q a)) =
        u j * (q x - q y) := by ring
    rw [this, norm_mul, hu j, one_mul, ← dist_eq_norm]
    exact hq x y hxy

/-! ## The chain theorem (J14) -/

/-- **The chain theorem, finite form** (GPT Astra's Theorem 4.1, `plans/STUB-chain-theorem.md` D1): a forcer at
`k` colours with marked pair `a, b`, and unit vectors `u j` with `(q b − q a)·Σ u j = 1`, chained copy after copy
from `0` to `1`: the induced unit-distance graph on the chain's points is not `k`-colourable. -/
theorem not_colorable_chain {ι : Type*} {G : SimpleGraph ι} {k m : ℕ} (q : ι → ℂ)
    (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) {a b : ι} (hf : Forces G k a b)
    (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (hsum : (q b - q a) * ∑ j, u j = 1) :
    ¬ ((unitDistance ℂ).induce (chainPoints q a (q b - q a) u)).Colorable k := by
  sorry

/-- The closure lemma the field form needs: `planeOver F` is a subring of `ℂ`. -/
def planeOverSubring (F : Subfield ℝ) : Subring ℂ where
  carrier := planeOver F
  mul_mem' := sorry
  one_mem' := sorry
  add_mem' := sorry
  zero_mem' := sorry
  neg_mem' := sorry

/-- **The chain theorem, field form**: the same hypotheses with the forcer drawn in `F²` and the unit vectors in
`F(i)` give `χ(F²) ≥ k + 1`. -/
theorem add_one_le_chromaticNumber_planeOver_of_chain {F : Subfield ℝ} {ι : Type*} {G : SimpleGraph ι}
    {k m : ℕ} (q : ι → ℂ) (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) (hqF : ∀ z, q z ∈ planeOver F)
    {a b : ι} (hf : Forces G k a b) (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (huF : ∀ j, u j ∈ planeOver F)
    (hsum : (q b - q a) * ∑ j, u j = 1) :
    ((k + 1 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  sorry

/-! ## The ℚ(√2,√3) instance (J14, D2) -/

/-- The rhombus in the reference's orientation: `0, 1, ω, 1 + ω` with `ω = (1 + i√3)/2`; forced pair `(0, 3)`,
`δ = 1 + ω`. Indices match `Gadget.rhombus`. -/
noncomputable def rhombusX : Fin 4 → ℂ :=
  ![0, 1, ⟨1 / 2, Real.sqrt 3 / 2⟩, ⟨3 / 2, Real.sqrt 3 / 2⟩]

theorem rhombusX_unit (x y : Fin 4) (hxy : (edgeGraph 4 rhombus).Adj x y) :
    dist (rhombusX x) (rhombusX y) = 1 := by
  sorry

/-- The six multipliers of `plans/ASTRA-2026-09-14-derivation.md` T6: `1, ω̄, v, vω̄, v̄, v̄ω̄`,
`v = (−1 + 2i√2)/3`. -/
noncomputable def sixUnits : Fin 6 → ℂ := sorry

theorem sixUnits_norm (j : Fin 6) : ‖sixUnits j‖ = 1 := sorry

theorem sixUnits_sum : (rhombusX 3 - rhombusX 0) * ∑ j, sixUnits j = 1 := sorry

/-- **`χ(ℚ(√2,√3)²) ≥ 4`** from six chained rhombi, with no Moser spindle in the field. -/
theorem four_le_chromaticNumber_planeOver_two_three :
    4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {2, 3}))).chromaticNumber := by
  sorry

/-- The 18-vertex, 33-edge edge list (`reference/ChatGPT-local-global-tightness-conjecture/example_qsqrt2_qsqrt3.json`). -/
def eighteenEdges : List (Fin 18 × Fin 18) :=
  [(0, 1), (0, 2), (1, 2), (1, 3), (1, 4), (1, 16), (1, 17), (2, 3), (3, 4), (3, 5), (4, 5), (4, 6), (5, 6),
   (6, 7), (6, 8), (7, 8), (7, 9), (7, 10), (8, 9), (9, 10), (9, 11), (10, 11), (10, 12), (11, 12), (12, 13),
   (12, 14), (13, 14), (13, 15), (13, 16), (14, 15), (15, 16), (15, 17), (16, 17)]

#guard eighteenEdges.length = 33

/-- **The second oracle**: the 18-vertex edge list refuses three colours by the gadget algebra (six transported
rhombus gadgets and the edge `0—1` over the seven chain ports), by `decide` — no solver. -/
theorem eighteen_not_colorable_three : ¬ (edgeGraph 18 eighteenEdges).Colorable 3 := by
  sorry

/-- The positive control: four colours suffice (the reference's colouring). -/
theorem eighteen_colorable_four : (edgeGraph 18 eighteenEdges).Colorable 4 := by
  sorry

/-! ## The `K(√7)` five-level, conditional on `G₄` (J14, D3's statement; its input is post-ban) -/

/-- `G₄`, named: a finite unit-distance graph drawn in `K²` whose marked points differ by `8/3` and are forced equal at
four colours. Measured (M56's 588-core, one solver refusal, no proof log); prior art Harder, Polymath16, 2018. -/
def G4 : Prop :=
  ∃ (n : ℕ) (E : List (Fin n × Fin n)) (q : Fin n → ℂ) (a b : Fin n),
    (∀ x y, (edgeGraph n E).Adj x y → dist (q x) (q y) = 1) ∧
    (∀ z, q z ∈ planeOver FieldWall4.seamField) ∧ q b - q a = 8 / 3 ∧ Forces (edgeGraph n E) 4 a b

/-- **`χ(K(√7)²) ≥ 5`, given `G₄`**: eight chained copies along `w³, w̄³, −w², −w², −w², −w̄², −w̄², −w̄²`,
`w = (−3 + i√7)/4`, which sum to `3/8`. VACUITY DECLARED: `G₄` has no kernel proof this week (its certificate needs a
solver run, banned to 2026-10-01); row 45's spare-colour lemma is why it is not trivially false. -/
theorem five_le_chromaticNumber_planeOver_seven_of_G4 (h : G4) :
    5 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {3, 7, 11}))).chromaticNumber := by
  sorry

end Chain
end HadwigerNelson
