import Proofs.HadwigerNelson.Forcer
import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.OneDefect

/-!
# The chain theorem: a forced pair, chained along unit vectors, refuses its colour count

GPT Astra's Theorem 4.1 (`plans/ASTRA-2026-09-14-derivation.md` T5; `CLAUDE.md` G55), FS-45's D1. Let a finite
unit-distance drawing `q` of a graph `G` force its marked pair `a, b` equal at `k` colours, and put `δ = q b − q a`. If
unit vectors `u₀, …, u_{m−1}` satisfy `δ·(u₀ + ⋯ + u_{m−1}) = 1`, place copy `j` of the drawing by
`z ↦ δ·(u₀ + ⋯ + u_{j−1}) + u_j·(z − q a)`. Copy `j`'s far end is copy `j + 1`'s near end, so the forced equalities
chain from `0` to `1`, which are a unit apart: the unit-distance graph **induced on the chain's points** has no
`k`-colouring.

The spindle is the case `m = 2` (`spindle_of_chain`, below): two unit vectors summing to `1/δ` exist exactly when
`|δ| ≥ 1/2`, which is the spindle theorem's threshold.

**The one modeling decision.** The union of the copies is the graph induced on the image set, never a `comap` union
(`Copy.copyUnion`): a `comap` union keeps coincident points as distinct vertices, so copy `j`'s far end and copy
`j + 1`'s near end would be two vertices and the forced equalities would not chain.
-/

namespace HadwigerNelson
namespace Chain

open SimpleGraph

/-! ## The chain drawing -/

/-- The chain's `n`-th junction point, `δ·(u₀ + ⋯ + u_{n−1})`; copy `j` starts at `junction δ u j`. -/
noncomputable def junction {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) (n : ℕ) : ℂ :=
  δ * ∑ i : Fin m with i.val < n, u i

/-- Copy `j` of the forcer's drawing `q`, its marked vertex `a` placed at junction `j` and turned by `u j`. -/
noncomputable def chainDrawing {ι : Type*} {m : ℕ} (q : ι → ℂ) (a : ι) (δ : ℂ) (u : Fin m → ℂ) :
    Fin m × ι → ℂ :=
  fun p => junction δ u p.1 + u p.1 * (q p.2 - q a)

/-- The chain's point set. The chain graph is the unit-distance graph **induced on this set**, so the points two
consecutive copies share are one vertex. -/
def chainPoints {ι : Type*} {m : ℕ} (q : ι → ℂ) (a : ι) (δ : ℂ) (u : Fin m → ℂ) : Set ℂ :=
  Set.range (chainDrawing q a δ u)

theorem junction_zero {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) : junction δ u 0 = 0 := by
  simp [junction]

/-- Consecutive junctions differ by `δ·u j`. -/
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

/-- The last junction is `δ·Σ u`. -/
theorem junction_last {m : ℕ} (δ : ℂ) (u : Fin m → ℂ) : junction δ u m = δ * ∑ j, u j := by
  unfold junction
  congr 1
  exact Finset.sum_congr (Finset.filter_true_of_mem fun i _ => i.isLt) fun _ _ => rfl

/-- The near end of copy `j` is junction `j`. -/
theorem chainDrawing_a {ι : Type*} {m : ℕ} (q : ι → ℂ) (a : ι) (δ : ℂ) (u : Fin m → ℂ) (j : Fin m) :
    chainDrawing q a δ u (j, a) = junction δ u j.val := by
  simp [chainDrawing]

/-- The far end of copy `j` is the start of copy `j + 1`. -/
theorem chainDrawing_b {ι : Type*} {m : ℕ} (q : ι → ℂ) {a b : ι} (u : Fin m → ℂ) (j : Fin m) :
    chainDrawing q a (q b - q a) u (j, b) = junction (q b - q a) u (j.val + 1) := by
  simp only [chainDrawing, junction_succ]
  ring

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

/-! ## The chain theorem -/

/-- **The chain theorem, finite form** (GPT Astra's Theorem 4.1; FS-45 D1). A forcer at `k` colours with marked pair
`a, b`, and unit vectors `u j` with `(q b − q a)·Σ u j = 1`, chained copy after copy from `0` to `1`: the unit-distance
graph induced on the chain's points is not `k`-colourable. No hypothesis on `k`, `m` or the field: `m ≠ 0` follows
from the sum, and a forcer with no `k`-colouring makes the chain uncolourable a fortiori. -/
theorem not_colorable_chain {ι : Type*} {G : SimpleGraph ι} {k m : ℕ} (q : ι → ℂ)
    (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) {a b : ι} (hf : Forces G k a b)
    (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (hsum : (q b - q a) * ∑ j, u j = 1) :
    ¬ ((unitDistance ℂ).induce (chainPoints q a (q b - q a) u)).Colorable k := by
  classical
  rintro ⟨C⟩
  have hm : 0 < m := Nat.pos_of_ne_zero fun hm => by subst hm; simp at hsum
  have h0 : (0 : ℂ) ∈ chainPoints q a (q b - q a) u :=
    ⟨(⟨0, hm⟩, a), by rw [chainDrawing_a, junction_zero]⟩
  have h1 : (1 : ℂ) ∈ chainPoints q a (q b - q a) u :=
    ⟨(⟨m - 1, by omega⟩, b), by rw [chainDrawing_b, Nat.sub_add_cancel hm, junction_last, hsum]⟩
  -- The colouring read on all of `ℂ`, off the chain constant.
  let c : ℂ → Fin k := fun z => if h : z ∈ chainPoints q a (q b - q a) u then C ⟨z, h⟩ else C ⟨0, h0⟩
  have hc : ∀ x : chainPoints q a (q b - q a) u, c x = C x := fun x => by simp [c]
  -- One copy carries the colour of junction `j` to junction `j + 1`.
  have step : ∀ j : Fin m, c (junction (q b - q a) u j.val) = c (junction (q b - q a) u (j.val + 1)) := by
    intro j
    have ha : ((copyHom q hq a (q b - q a) u hu j) a : ℂ) = junction (q b - q a) u j.val :=
      chainDrawing_a q a _ u j
    have hb : ((copyHom q hq a (q b - q a) u hu j) b : ℂ) = junction (q b - q a) u (j.val + 1) :=
      chainDrawing_b q u j
    rw [← ha, ← hb, hc, hc]
    exact hf.comap _ C
  have key : ∀ n, n ≤ m → c (junction (q b - q a) u n) = c 0 := by
    intro n
    induction n with
    | zero => intro _; rw [junction_zero]
    | succ n ih => intro hn; rw [← step ⟨n, hn⟩, ih (by omega)]
  have hend : c 1 = c 0 := by
    rw [← key m le_rfl, junction_last, hsum]
  have hadj : ((unitDistance ℂ).induce (chainPoints q a (q b - q a) u)).Adj ⟨0, h0⟩ ⟨1, h1⟩ := by
    simp
  exact C.valid hadj (by rw [← hc, ← hc]; exact hend.symm)

/-! ## The plane over a subring, and over `F²` -/

/-- The chain's points lie in any subring holding the drawing and the multipliers. -/
theorem chainPoints_subset {ι : Type*} {m : ℕ} {S : Subring ℂ} (q : ι → ℂ) (hqS : ∀ z, q z ∈ S) (a : ι)
    {δ : ℂ} (hδ : δ ∈ S) (u : Fin m → ℂ) (huS : ∀ j, u j ∈ S) :
    chainPoints q a δ u ⊆ S := by
  rintro _ ⟨⟨j, z⟩, rfl⟩
  exact S.add_mem (S.mul_mem hδ (S.sum_mem fun i _ => huS i))
    (S.mul_mem (huS j) (S.sub_mem (hqS z) (hqS a)))

/-- **The chain theorem over a subring of `ℂ`**: with the drawing and the multipliers in `S`, the unit-distance graph on
`S` needs `k + 1` colours. The statement at its proof's level — closure under `+` and `·` is all the field form uses. -/
theorem add_one_le_chromaticNumber_induce_of_chain {S : Subring ℂ} {ι : Type*} {G : SimpleGraph ι} {k m : ℕ}
    (q : ι → ℂ) (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) (hqS : ∀ z, q z ∈ S) {a b : ι}
    (hf : Forces G k a b) (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (huS : ∀ j, u j ∈ S)
    (hsum : (q b - q a) * ∑ j, u j = 1) :
    ((k + 1 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (S : Set ℂ)).chromaticNumber :=
  (add_one_le_chromaticNumber_iff_not_colorable.mpr (not_colorable_chain q hq hf u hu hsum)).trans
    (chromaticNumber_mono_of_hom (SimpleGraph.induceHomOfLE _
      (chainPoints_subset q hqS a (S.sub_mem (hqS b) (hqS a)) u huS)).toHom)

/-- **The chain theorem in the plane**: `χ(ℝ²) ≥ k + 1` — FS-49's host form. -/
theorem add_one_le_chromaticNumber_unitDistance_of_chain {ι : Type*} {G : SimpleGraph ι} {k m : ℕ}
    (q : ι → ℂ) (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) {a b : ι} (hf : Forces G k a b)
    (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (hsum : (q b - q a) * ∑ j, u j = 1) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber :=
  (add_one_le_chromaticNumber_iff_not_colorable.mpr (not_colorable_chain q hq hf u hu hsum)).trans
    (chromaticNumber_mono_of_hom (SimpleGraph.Embedding.induce _).toHom)

/-! ## Drawing helpers the instances share -/

/-- A complex number with `re² + im² = 1` is a unit vector. -/
theorem norm_eq_one_of_sq {z : ℂ} (h : z.re * z.re + z.im * z.im = 1) : ‖z‖ = 1 := by
  rw [Complex.norm_def, Complex.normSq_apply, h, Real.sqrt_one]

/-- A drawing of the rhombus (`Gadget.rhombus`: two triangles on the edge `1—2`, far corners `0, 3`) is a unit drawing
once its five edges have length `1`. -/
theorem rhombus_unit_of {p : Fin 4 → ℂ} (h01 : dist (p 0) (p 1) = 1) (h02 : dist (p 0) (p 2) = 1)
    (h12 : dist (p 1) (p 2) = 1) (h13 : dist (p 1) (p 3) = 1) (h23 : dist (p 2) (p 3) = 1) :
    ∀ x y, (edgeGraph 4 rhombus).Adj x y → dist (p x) (p y) = 1 := by
  intro x y h
  obtain ⟨-, hxy | hxy⟩ := edgeGraph_adj.mp h <;>
    simp only [rhombus, List.mem_cons, Prod.mk.injEq, List.not_mem_nil, or_false] at hxy <;>
    rcases hxy with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;>
    first | assumption | (rw [dist_comm]; assumption)

/-- **The plane over a real subfield is a subring of `ℂ`**: `F²` is closed under complex `+` and `·`. -/
def planeOverSubring (F : Subfield ℝ) : Subring ℂ where
  carrier := planeOver F
  mul_mem' {z w} hz hw := ⟨by simpa using F.sub_mem (F.mul_mem hz.1 hw.1) (F.mul_mem hz.2 hw.2),
    by simpa using F.add_mem (F.mul_mem hz.1 hw.2) (F.mul_mem hz.2 hw.1)⟩
  one_mem' := ⟨by simp [F.one_mem], by simp [F.zero_mem]⟩
  add_mem' {z w} hz hw := ⟨by simpa using F.add_mem hz.1 hw.1, by simpa using F.add_mem hz.2 hw.2⟩
  zero_mem' := ⟨by simp [F.zero_mem], by simp [F.zero_mem]⟩
  neg_mem' {z} hz := ⟨by simpa using F.neg_mem hz.1, by simpa using F.neg_mem hz.2⟩

@[simp] theorem coe_planeOverSubring (F : Subfield ℝ) : (planeOverSubring F : Set ℂ) = planeOver F := rfl

/-- **The chain theorem, field form**: the forcer drawn in `F²` and the unit vectors in `F(i)` give
`χ(F²) ≥ k + 1`. -/
theorem add_one_le_chromaticNumber_planeOver_of_chain {F : Subfield ℝ} {ι : Type*} {G : SimpleGraph ι}
    {k m : ℕ} (q : ι → ℂ) (hq : ∀ x y, G.Adj x y → dist (q x) (q y) = 1) (hqF : ∀ z, q z ∈ planeOver F)
    {a b : ι} (hf : Forces G k a b) (u : Fin m → ℂ) (hu : ∀ j, ‖u j‖ = 1) (huF : ∀ j, u j ∈ planeOver F)
    (hsum : (q b - q a) * ∑ j, u j = 1) :
    ((k + 1 : ℕ) : ℕ∞) ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  add_one_le_chromaticNumber_induce_of_chain (S := planeOverSubring F) q hq hqF hf u hu huF hsum

/-! ## Spec

The definitions on small inputs, and the spindle as the chain's `m = 2` case. -/

-- `junction` sums a prefix: with `δ = 2` and multipliers `1, 3`, the junctions are `0, 2, 8`.
example : junction (2 : ℂ) ![1, 3] 1 = 2 := by
  simp [junction, Finset.sum_filter]
example : junction (2 : ℂ) ![1, 3] 2 = 8 := by
  rw [junction_last, Fin.sum_univ_two]; norm_num

-- `chainDrawing` turns and translates: copy `1` of the segment `0—1` under multipliers `1, i` starts at `δ·1 = 1`.
example : chainDrawing (![0, 1] : Fin 2 → ℂ) 0 1 ![1, Complex.I] (1, 1) = 1 + Complex.I := by
  simp [chainDrawing, junction, Finset.sum_filter]

-- `planeOverSubring` is `planeOver` with closure: `(1 + i)² = 2i` stays in `ℚ²`.
example : (1 + Complex.I) * (1 + Complex.I) ∈ planeOverSubring (⊥ : Subfield ℝ) :=
  (planeOverSubring ⊥).mul_mem ⟨by simp [(⊥ : Subfield ℝ).one_mem], by simp [(⊥ : Subfield ℝ).one_mem]⟩
    ⟨by simp [(⊥ : Subfield ℝ).one_mem], by simp [(⊥ : Subfield ℝ).one_mem]⟩

/-- The Moser rhombus along the real axis: `0`, `(√3 ∓ i)/2`, `√3`; its far corners are `√3` apart. -/
noncomputable def spindleRhombus : Fin 4 → ℂ :=
  ![0, ⟨Real.sqrt 3 / 2, -1 / 2⟩, ⟨Real.sqrt 3 / 2, 1 / 2⟩, ⟨Real.sqrt 3, 0⟩]

/-- The Moser twist `(√3 + i√33)/6`: it and its conjugate sum to `2√3/6 = 1/√3`. -/
noncomputable def moserTwist : ℂ := ⟨Real.sqrt 3 / 6, Real.sqrt 33 / 6⟩

/-- **The spindle is the chain at `m = 2`**: the rhombus forced at three colours, chained along the Moser twist and
its conjugate, gives `χ(ℝ²) ≥ 4` — the Moser spindle, re-derived through the chain theorem. The model of every
hypothesis of `add_one_le_chromaticNumber_unitDistance_of_chain`. -/
theorem spindle_of_chain : 4 ≤ (unitDistance ℂ).chromaticNumber := by
  have h3 : Real.sqrt 3 * Real.sqrt 3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h33 : Real.sqrt 33 * Real.sqrt 33 = 33 := Real.mul_self_sqrt (by norm_num)
  have hunit : ∀ x y, (edgeGraph 4 rhombus).Adj x y → dist (spindleRhombus x) (spindleRhombus y) = 1 := by
    refine rhombus_unit_of ?_ ?_ ?_ ?_ ?_ <;> rw [dist_eq_norm] <;> apply norm_eq_one_of_sq <;>
      simp [spindleRhombus] <;>
      first | linear_combination (1 / 4 : ℝ) * h3 | linear_combination (0 : ℝ) * h3
  have hu : ∀ j, ‖(![moserTwist, (starRingEnd ℂ) moserTwist] : Fin 2 → ℂ) j‖ = 1 := by
    have : ‖moserTwist‖ = 1 := norm_eq_one_of_sq (by
      simp only [moserTwist]; linear_combination (1 / 36 : ℝ) * h3 + (1 / 36 : ℝ) * h33)
    intro j; fin_cases j <;> simp [this]
  have hsum : (spindleRhombus 3 - spindleRhombus 0) *
      ∑ j, (![moserTwist, (starRingEnd ℂ) moserTwist] : Fin 2 → ℂ) j = 1 := by
    apply Complex.ext <;> simp [spindleRhombus, moserTwist, Fin.sum_univ_two]
    linear_combination (1 / 3 : ℝ) * h3
  simpa using add_one_le_chromaticNumber_unitDistance_of_chain spindleRhombus hunit rhombus_forces _ hu hsum

end Chain
end HadwigerNelson
