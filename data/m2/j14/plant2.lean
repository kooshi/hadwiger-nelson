import Proofs.HadwigerNelson.Chain

/-!
# `χ(ℚ(√2,√3)²) ≥ 4`, with no Moser spindle in the field (FS-45 D2)

The chain theorem's first instance (`plans/ASTRA-2026-09-14-derivation.md` T6, GPT Astra's construction). The rhombus
`0, 1, ω, 1 + ω` (`ω = (1 + i√3)/2`) forces its far corners equal at three colours, `δ = 1 + ω`. With `v = (−1 + 2i√2)/3`
(`|v| = 1`), the six unit vectors `1, ω̄, v, vω̄, v̄, v̄ω̄` sum to `(1 + ω̄)(1 + v + v̄)`, and `δ(1 + ω̄) = 3`,
`1 + v + v̄ = 1/3`: the product is `1`, so six chained rhombi close on the unit edge `0—1` and the plane over
`ℚ(√2,√3)` needs four colours. The field holds no `√11`, so no Moser spindle.

Beside it, a second oracle on the finite object: the 18-vertex, 33-edge list of
`reference/ChatGPT-local-global-tightness-conjecture/example_qsqrt2_qsqrt3.json` refuses three colours by the gadget
algebra — six rhombus gadgets pulled into it and the edge `0—1`, over the seven chain ports — with no solver; four
colours suffice (the reference's colouring). The list's geometry (that its 33 edges are unit distances over
`ℚ(√2,√3)`) is **not** checked here: the plane bound comes from the chain theorem, which needs no list.

**Not proved here:** the matching upper bound `χ(ℚ(√2,√3)²) ≤ 4` (the dyadic residue colouring, T6's other half).
-/

namespace HadwigerNelson
namespace SqrtTwoThree

open SimpleGraph Chain SquareClass

/-! ## The drawing and the six multipliers -/

/-- The rhombus in the reference's orientation, `0, 1, ω, 1 + ω`; forced pair `(0, 3)`, `δ = 1 + ω`. -/
noncomputable def rhombusX : Fin 4 → ℂ :=
  ![0, 1, ⟨1 / 2, Real.sqrt 3 / 2⟩, ⟨3 / 2, Real.sqrt 3 / 2⟩]

/-- `ω̄ = (1 − i√3)/2`. -/
noncomputable def omegaBar : ℂ := ⟨1 / 2, -(Real.sqrt 3 / 2)⟩

/-- `v = (−1 + 2i√2)/3`, T6's `u`. -/
noncomputable def v : ℂ := ⟨-(1 / 3), 2 * Real.sqrt 2 / 3⟩

/-- The six multipliers `1, ω̄, v, vω̄, v̄, v̄ω̄`, written as the products they are. -/
noncomputable def sixUnits : Fin 6 → ℂ :=
  ![1, omegaBar, v, v * omegaBar, (starRingEnd ℂ) v, (starRingEnd ℂ) v * omegaBar]

theorem sqrt3_sq : Real.sqrt 3 * Real.sqrt 3 = 3 := Real.mul_self_sqrt (by norm_num)
theorem sqrt2_sq : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)

theorem rhombusX_unit : ∀ x y, (edgeGraph 4 rhombus).Adj x y → dist (rhombusX x) (rhombusX y) = 1 := by
  refine rhombus_unit_of ?_ ?_ ?_ ?_ ?_ <;> rw [dist_eq_norm] <;> apply norm_eq_one_of_sq <;>
    simp [rhombusX] <;> first | linear_combination (1 / 4 : ℝ) * sqrt3_sq | ring

theorem norm_omegaBar : ‖omegaBar‖ = 1 :=
  norm_eq_one_of_sq (by simp only [omegaBar]; linear_combination (1 / 4 : ℝ) * sqrt3_sq)

theorem norm_v : ‖v‖ = 1 :=
  norm_eq_one_of_sq (by simp only [v]; linear_combination (4 / 9 : ℝ) * sqrt2_sq)

theorem sixUnits_norm (j : Fin 6) : ‖sixUnits j‖ = 1 := by
  fin_cases j <;> simp [sixUnits, norm_omegaBar, norm_v]

/-- The sum factors: `Σ sixUnits = (1 + ω̄)(1 + v + v̄)`. -/
theorem sum_sixUnits : ∑ j, sixUnits j = (1 + omegaBar) * (1 + v + (starRingEnd ℂ) v) := by
  rw [Fin.sum_univ_six]; simp only [sixUnits]; simp; ring

/-- `δ(1 + ω̄) = 3`. -/
theorem delta_mul_one_add_omegaBar : (rhombusX 3 - rhombusX 0) * (1 + omegaBar) = 3 := by
  apply Complex.ext <;> simp [rhombusX, omegaBar]
  · linear_combination (1 / 4 : ℝ) * sqrt3_sq
  · ring

/-- `1 + v + v̄ = 1/3`. -/
theorem one_add_v_add_conj : 1 + v + (starRingEnd ℂ) v = 1 / 3 := by
  apply Complex.ext <;> simp [v]
  norm_num

/-- **The six-unit identity** `δ(1 + ω̄ + v + vω̄ + v̄ + v̄ω̄) = 1`, by factoring. -/
theorem sixUnits_sum : (rhombusX 3 - rhombusX 0) * ∑ j, sixUnits j = 1 := by
  rw [sum_sixUnits, ← mul_assoc, delta_mul_one_add_omegaBar, one_add_v_add_conj]; norm_num

/-! ## The field -/

/-- `ℚ(√2, √3)`. -/
noncomputable abbrev F23 : Subfield ℝ := fieldOfRadicands {2, 3}

theorem sqrt2_mem : Real.sqrt 2 ∈ F23 := by
  simpa using sqrt_mem_fieldOfRadicands (D := {2, 3}) (d := 2) (by simp)

theorem sqrt3_mem : Real.sqrt 3 ∈ F23 := by
  simpa using sqrt_mem_fieldOfRadicands (D := {2, 3}) (d := 3) (by simp)

theorem rhombusX_mem (z : Fin 4) : rhombusX z ∈ planeOver F23 := by
  have h2 : (2 : ℝ) ∈ F23 := ofNat_mem F23 2
  fin_cases z <;> refine ⟨?_, ?_⟩ <;> simp [rhombusX]
  all_goals first
    | exact F23.inv_mem h2 | exact F23.div_mem F23.one_mem h2 | exact F23.div_mem sqrt3_mem h2
    | exact F23.div_mem (ofNat_mem F23 3) h2

theorem omegaBar_mem : omegaBar ∈ planeOver F23 :=
  ⟨F23.div_mem F23.one_mem (ofNat_mem F23 2), F23.neg_mem (F23.div_mem sqrt3_mem (ofNat_mem F23 2))⟩

theorem v_mem : v ∈ planeOver F23 :=
  ⟨F23.neg_mem (F23.div_mem F23.one_mem (ofNat_mem F23 3)),
    F23.div_mem (F23.mul_mem (ofNat_mem F23 2) sqrt2_mem) (ofNat_mem F23 3)⟩

theorem conj_v_mem : (starRingEnd ℂ) v ∈ planeOver F23 :=
  ⟨by simpa using v_mem.1, by simpa using F23.neg_mem v_mem.2⟩

theorem sixUnits_mem (j : Fin 6) : sixUnits j ∈ planeOver F23 := by
  have hS := planeOverSubring F23
  fin_cases j
  · exact (planeOverSubring F23).one_mem
  · exact omegaBar_mem
  · exact v_mem
  · exact (planeOverSubring F23).mul_mem v_mem omegaBar_mem
  · exact conj_v_mem
  · exact (planeOverSubring F23).mul_mem conj_v_mem omegaBar_mem

/-- **`χ(ℚ(√2,√3)²) ≥ 4`**, from six chained rhombi — the first Moser-free four-chromatic plane in the record
(`√11 ∉ ℚ(√2,√3)`). The kernel proves the lower bound only; the upper bound `≤ 4` is T6's dyadic half, not proved here. -/
theorem four_le_chromaticNumber_planeOver_two_three :
    4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {2, 3}))).chromaticNumber := by
  simpa using add_one_le_chromaticNumber_planeOver_of_chain (F := F23) rhombusX rhombusX_unit rhombusX_mem
    rhombus_forces sixUnits sixUnits_norm sixUnits_mem sixUnits_sum

/-! ## The second oracle: the 18-vertex object, by the gadget algebra -/

/-- The 18-vertex, 33-edge edge list (`reference/ChatGPT-local-global-tightness-conjecture/example_qsqrt2_qsqrt3.json`). -/
def eighteenEdges : List (Fin 18 × Fin 18) :=
  [(0, 1), (0, 2), (1, 2), (1, 3), (1, 4), (1, 16), (1, 17), (2, 3), (3, 4), (3, 5), (4, 5), (4, 6), (5, 6),
   (6, 7), (6, 8), (7, 8), (7, 9), (7, 10), (8, 9), (9, 10), (9, 11), (10, 11), (10, 12), (11, 12), (12, 13),
   (12, 14), (13, 14), (13, 15), (13, 16), (14, 15), (15, 16), (15, 17), (16, 17)]

#guard eighteenEdges.length = 33

/-- **A gadget pulled along a vertex map between different vertex sets.** `Gadget.transport` moves a gadget within one
`Fin n`; this carries one from `Fin n` into `Fin N` — pull the colouring back along `φ`, which sends every edge of `E`
to an edge of `F`. -/
def pullGadget {k n N m : ℕ} {E : List (Fin n × Fin n)} {F : List (Fin N × Fin N)} {p : Fin m → Fin n}
    (φ : Fin n → Fin N) (hφ : ∀ e ∈ E, (edgeGraph N F).Adj (φ e.1) (φ e.2)) (g : Gadget k n m E p) :
    Gadget k N m F (fun i => φ (p i)) where
  admits := g.admits
  sound f hf := g.sound (fun x => f (φ x)) fun i j hij => by
    rcases (edgeGraph_adj.mp hij).2 with hm | hm
    · exact hf _ _ (hφ (i, j) hm)
    · exact fun hc => hf _ _ (hφ (j, i) hm) hc.symm

/-- The six diamonds of the reference, as maps from the rhombus: `[0,1,2,3], [3,4,5,6], …, [15,16,17,1]`. -/
def diamond : Fin 6 → Fin 4 → Fin 18 :=
  ![![0, 1, 2, 3], ![3, 4, 5, 6], ![6, 7, 8, 9], ![9, 10, 11, 12], ![12, 13, 14, 15], ![15, 16, 17, 1]]

/-- The seven chain ports: the junctions `0, 3, 6, 9, 12, 15` and the end `1`. -/
def ports : Fin 7 → Fin 18 := ![0, 3, 6, 9, 12, 15, 1]

theorem diamond_hom : ∀ d, ∀ e ∈ rhombus, (edgeGraph 18 eighteenEdges).Adj (diamond d e.1) (diamond d e.2) := by
  simp only [edgeGraph_adj]; decide

/-- Diamond `d`'s forcing, as a gadget on the seven ports: ports `d` and `d + 1` agree. -/
def diamondGadget (d : Fin 6) : Gadget 3 18 7 eighteenEdges ports :=
  (pullGadget (diamond d) (diamond_hom d) rhombusGadget).widen ![d.castSucc, d.succ]
    (by revert d; decide)

/-- The closing edge `0—1`, between ports `0` and `6`. -/
def closingGadget : Gadget 3 18 7 eighteenEdges ports :=
  Gadget.edge 0 6 (edgeGraph_adj_of_mem (by decide) (by decide))

/-- All seven, composed. -/
def eighteenGadget : Gadget 3 18 7 eighteenEdges ports :=
  List.foldr Gadget.inter Gadget.trivial
    [diamondGadget 0, diamondGadget 1, diamondGadget 3, diamondGadget 4, diamondGadget 5,
     closingGadget]

-- **The closing edge is load-bearing, and the diamonds do chain.** Without it the six diamonds leave exactly one port
-- pattern — all seven ports one colour — so the refusal below is the edge `0—1` against that pattern.
/-- info: [[(0, 0), (3, 0), (6, 0), (9, 0), (12, 0), (15, 0), (1, 0)]] -/
#guard_msgs in
#eval (List.foldr Gadget.inter Gadget.trivial
  [diamondGadget 0, diamondGadget 1, diamondGadget 2, diamondGadget 3, diamondGadget 4, diamondGadget 5]).survivors

/-- **The second oracle**: the 18-vertex list refuses three colours, by the gadget algebra over the seven chain ports
(six pulled rhombus gadgets and the edge `0—1`) and one `decide` over the port partitions — no solver, no certificate. -/
theorem eighteen_not_colorable_three : ¬ (edgeGraph 18 eighteenEdges).Colorable 3 :=
  not_colorable_of_gadget eighteenGadget (by decide +kernel)

/-- The positive control: four colours suffice (the reference's colouring). -/
theorem eighteen_colorable_four : (edgeGraph 18 eighteenEdges).Colorable 4 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 2, 1, 0, 1, 2, 0, 2, 1, 0, 1, 2, 0, 2, 3], by
    simp only [edgeGraph_adj]; decide +kernel⟩

/-! ### The plant, kept

Drop the critical edge `(15, 17)` (diamond 6's edge `0—2`). The refusal must come from the edges and not from the
scaffolding, so both halves are kept: the dropped list is three-colourable (the reference's colouring with vertex 17
recoloured `0`, by hand), and diamond 6's map is no longer a homomorphism into it — which is where the oracle goes red
when the edge is dropped from `eighteenEdges` itself (recorded in `plans/M2-S1K-chain.md`, stage 3). -/

/-- `eighteenEdges` without `(15, 17)`. -/
def plantedEdges : List (Fin 18 × Fin 18) := eighteenEdges.erase (15, 17)

example : plantedEdges.length = 32 := by decide

example : (edgeGraph 18 plantedEdges).Colorable 3 :=
  colorable_iff_exists.mpr ⟨![0, 1, 2, 0, 2, 1, 0, 1, 2, 0, 2, 1, 0, 1, 2, 0, 2, 0], by
    simp only [edgeGraph_adj]; decide +kernel⟩

example : ¬ ∀ e ∈ rhombus, (edgeGraph 18 plantedEdges).Adj (diamond 5 e.1) (diamond 5 e.2) := by
  simp only [edgeGraph_adj]; decide

end SqrtTwoThree
end HadwigerNelson
