import Proofs.HadwigerNelson.TwoAdicTower
import Proofs.HadwigerNelson.FanGap

/-!
# Level four of the 2-adic tower is pairwise free at four colours

`P₄ = Cay(O/𝔓⁴, S₄)`, 256 vertices, degree 24. **No single 4-colouring of `P₄` is aperiodic** (every one is periodic
under one of the three depth-2 elements `2√3·{1, ω, 1 + ω}`; measured 2026-09-13), so pairwise freeness is decided by a
**list** of five tables (`data/fs38/p4-tables.json`, found by SAT): each is proper (`decide`), and for every nonzero
difference `d` some table is not `d`-periodic (`decide`, 255 × 5 × 256 lookups). `Forces.eq_of_forall_exists_not_periodic`
then gives `Forces (twoAdicPlane 4) 4 x y ↔ x = y`.

**What this bounds** (FS-38 §S4): a K-fabric drawn into `P₄` — the hand step [hand 2] — cannot force a four-colour pair
of `𝔓`-depth `≤ 3` (distances `2`, `2/√3`, `2√3`, …), the mechanism behind M53's zeros at depth 2. It says nothing about
depth `≥ 4`, where `P₅` forces (`Instances/TwoAdicFive.lean`) and the record's fabric is measured free at depth 4.
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-- Table 1 of five, indexed `a b c d` for `((a, b), (c, d))`. Untrusted data; the theorems below are the check. -/
def twoAdicFourTable₁ : Fin 4 → Fin 4 → Fin 4 → Fin 4 → Fin 4 :=
  ![![![![0,1,0,1], ![0,1,0,1], ![0,1,0,1], ![0,1,0,1]], ![![1,0,1,0], ![1,0,1,0], ![1,0,1,0], ![1,0,1,0]], ![![0,1,0,1], ![0,1,0,1], ![0,1,0,1], ![0,1,0,1]], ![![1,0,1,0], ![1,0,1,0], ![1,0,1,0], ![1,0,1,0]]],
   ![![![2,3,2,3], ![2,3,2,3], ![2,3,2,3], ![2,3,2,3]], ![![3,2,3,2], ![3,2,3,2], ![3,2,3,2], ![3,2,3,2]], ![![2,3,2,3], ![2,3,2,3], ![2,3,2,3], ![2,3,2,3]], ![![3,2,3,2], ![3,2,3,2], ![3,2,3,2], ![3,2,3,2]]],
   ![![![1,0,1,0], ![1,0,1,0], ![1,0,1,0], ![1,0,1,0]], ![![0,1,0,1], ![0,1,0,1], ![0,1,0,1], ![0,1,0,1]], ![![1,0,1,0], ![1,0,1,0], ![1,0,1,0], ![1,0,1,0]], ![![0,1,0,1], ![0,1,0,1], ![0,1,0,1], ![0,1,0,1]]],
   ![![![3,2,3,2], ![3,2,3,2], ![3,2,3,2], ![3,2,3,2]], ![![2,3,2,3], ![2,3,2,3], ![2,3,2,3], ![2,3,2,3]], ![![3,2,3,2], ![3,2,3,2], ![3,2,3,2], ![3,2,3,2]], ![![2,3,2,3], ![2,3,2,3], ![2,3,2,3], ![2,3,2,3]]]]

/-- Table 2 of five, same indexing. -/
def twoAdicFourTable₂ : Fin 4 → Fin 4 → Fin 4 → Fin 4 → Fin 4 :=
  ![![![![0,0,1,1], ![0,0,1,1], ![0,0,1,1], ![0,0,1,1]], ![![2,2,3,3], ![2,2,3,3], ![2,2,3,3], ![2,2,3,3]], ![![1,1,0,0], ![1,1,0,0], ![1,1,0,0], ![1,1,0,0]], ![![3,3,2,2], ![3,3,2,2], ![3,3,2,2], ![3,3,2,2]]],
   ![![![1,1,0,0], ![1,1,0,0], ![1,1,0,0], ![1,1,0,0]], ![![3,3,2,2], ![3,3,2,2], ![3,3,2,2], ![3,3,2,2]], ![![0,0,1,1], ![0,0,1,1], ![0,0,1,1], ![0,0,1,1]], ![![2,2,3,3], ![2,2,3,3], ![2,2,3,3], ![2,2,3,3]]],
   ![![![0,0,1,1], ![0,0,1,1], ![0,0,1,1], ![0,0,1,1]], ![![2,2,3,3], ![2,2,3,3], ![2,2,3,3], ![2,2,3,3]], ![![1,1,0,0], ![1,1,0,0], ![1,1,0,0], ![1,1,0,0]], ![![3,3,2,2], ![3,3,2,2], ![3,3,2,2], ![3,3,2,2]]],
   ![![![1,1,0,0], ![1,1,0,0], ![1,1,0,0], ![1,1,0,0]], ![![3,3,2,2], ![3,3,2,2], ![3,3,2,2], ![3,3,2,2]], ![![0,0,1,1], ![0,0,1,1], ![0,0,1,1], ![0,0,1,1]], ![![2,2,3,3], ![2,2,3,3], ![2,2,3,3], ![2,2,3,3]]]]

/-- Table 3 of five, same indexing. -/
def twoAdicFourTable₃ : Fin 4 → Fin 4 → Fin 4 → Fin 4 → Fin 4 :=
  ![![![![1,1,1,1], ![0,0,0,0], ![1,1,1,1], ![0,0,0,0]], ![![0,0,0,0], ![1,1,1,1], ![0,0,0,0], ![1,1,1,1]], ![![1,1,1,1], ![0,0,0,0], ![1,1,1,1], ![0,0,0,0]], ![![0,0,0,0], ![1,1,1,1], ![0,0,0,0], ![1,1,1,1]]],
   ![![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]], ![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]]],
   ![![![1,1,1,1], ![0,0,0,0], ![1,1,1,1], ![0,0,0,0]], ![![0,0,0,0], ![1,1,1,1], ![0,0,0,0], ![1,1,1,1]], ![![1,1,1,1], ![0,0,0,0], ![1,1,1,1], ![0,0,0,0]], ![![0,0,0,0], ![1,1,1,1], ![0,0,0,0], ![1,1,1,1]]],
   ![![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]], ![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]]]]

/-- Table 4 of five, same indexing. -/
def twoAdicFourTable₄ : Fin 4 → Fin 4 → Fin 4 → Fin 4 → Fin 4 :=
  ![![![![0,0,0,0], ![0,0,0,0], ![1,1,1,1], ![1,1,1,1]], ![![1,1,1,1], ![1,1,1,1], ![0,0,0,0], ![0,0,0,0]], ![![0,0,0,0], ![0,0,0,0], ![1,1,1,1], ![1,1,1,1]], ![![1,1,1,1], ![1,1,1,1], ![0,0,0,0], ![0,0,0,0]]],
   ![![![2,2,2,2], ![2,2,2,2], ![3,3,3,3], ![3,3,3,3]], ![![3,3,3,3], ![3,3,3,3], ![2,2,2,2], ![2,2,2,2]], ![![2,2,2,2], ![2,2,2,2], ![3,3,3,3], ![3,3,3,3]], ![![3,3,3,3], ![3,3,3,3], ![2,2,2,2], ![2,2,2,2]]],
   ![![![1,1,1,1], ![1,1,1,1], ![0,0,0,0], ![0,0,0,0]], ![![0,0,0,0], ![0,0,0,0], ![1,1,1,1], ![1,1,1,1]], ![![1,1,1,1], ![1,1,1,1], ![0,0,0,0], ![0,0,0,0]], ![![0,0,0,0], ![0,0,0,0], ![1,1,1,1], ![1,1,1,1]]],
   ![![![3,3,3,3], ![3,3,3,3], ![2,2,2,2], ![2,2,2,2]], ![![2,2,2,2], ![2,2,2,2], ![3,3,3,3], ![3,3,3,3]], ![![3,3,3,3], ![3,3,3,3], ![2,2,2,2], ![2,2,2,2]], ![![2,2,2,2], ![2,2,2,2], ![3,3,3,3], ![3,3,3,3]]]]

/-- Table 5 of five, same indexing. -/
def twoAdicFourTable₅ : Fin 4 → Fin 4 → Fin 4 → Fin 4 → Fin 4 :=
  ![![![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![1,1,1,1], ![0,1,0,0], ![1,1,1,1], ![0,0,0,1]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]], ![![0,0,1,0], ![1,1,1,1], ![1,0,0,0], ![1,1,1,1]]],
   ![![![1,1,0,1], ![0,0,0,0], ![0,1,1,1], ![0,0,0,0]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]], ![![0,0,0,0], ![1,0,1,1], ![0,0,0,0], ![1,1,1,0]], ![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]]],
   ![![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]], ![![0,0,1,0], ![1,1,1,1], ![1,0,0,0], ![1,1,1,1]], ![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![1,1,1,1], ![0,1,0,0], ![1,1,1,1], ![0,0,0,1]]],
   ![![![0,0,0,0], ![1,0,1,1], ![0,0,0,0], ![1,1,1,0]], ![![3,3,3,3], ![2,2,2,2], ![3,3,3,3], ![2,2,2,2]], ![![1,1,0,1], ![0,0,0,0], ![0,1,1,1], ![0,0,0,0]], ![![2,2,2,2], ![3,3,3,3], ![2,2,2,2], ![3,3,3,3]]]]

/-- The five tables as functions on the level, one name each so a per-table fact can be stated. -/
def twoAdicFourCol₁ : TwoAdicLevel 4 → Fin 4 := fun z => twoAdicFourTable₁ z.1.1 z.1.2 z.2.1 z.2.2
/-- Table 2 as a function on the level. -/
def twoAdicFourCol₂ : TwoAdicLevel 4 → Fin 4 := fun z => twoAdicFourTable₂ z.1.1 z.1.2 z.2.1 z.2.2
/-- Table 3 as a function on the level. -/
def twoAdicFourCol₃ : TwoAdicLevel 4 → Fin 4 := fun z => twoAdicFourTable₃ z.1.1 z.1.2 z.2.1 z.2.2
/-- Table 4 as a function on the level. -/
def twoAdicFourCol₄ : TwoAdicLevel 4 → Fin 4 := fun z => twoAdicFourTable₄ z.1.1 z.1.2 z.2.1 z.2.2
/-- Table 5 as a function on the level. -/
def twoAdicFourCol₅ : TwoAdicLevel 4 → Fin 4 := fun z => twoAdicFourTable₅ z.1.1 z.1.2 z.2.1 z.2.2

/-- The five tables as functions on the level. -/
def twoAdicFourTables : List (TwoAdicLevel 4 → Fin 4) :=
  [twoAdicFourCol₁, twoAdicFourCol₂, twoAdicFourCol₃, twoAdicFourCol₄, twoAdicFourCol₅]

#guard twoAdicFourTable₁ 0 0 0 0 = 0
#guard twoAdicFourTable₁ 1 0 0 0 = 2

/-- **The 24 points of `S₄`, as a literal.** Properness stated over `Adj` directly is 65,536 pairs each evaluating the
norm form twice — measured at **2 min 08 s per table** in the kernel, so 11 minutes for the five. Through the
connection set it is 256 × 24 shifts per table with no form evaluation at all (`M04`'s rule: emit the table as a
literal, never let the kernel build it). The list is untrusted; `mem_twoAdicCircleFour_iff` is the check, and it
re-derives membership from `normForm` at all 256 points. -/
def twoAdicCircleFour : List (TwoAdicLevel 4) :=
  [((0, 1), (0, 0)), ((0, 1), (0, 2)), ((0, 3), (0, 0)), ((0, 3), (0, 2)),
   ((1, 0), (0, 0)), ((1, 0), (2, 0)), ((1, 1), (0, 0)), ((1, 1), (2, 2)),
   ((1, 2), (1, 2)), ((1, 2), (3, 2)), ((1, 3), (1, 3)), ((1, 3), (3, 1)),
   ((2, 1), (2, 1)), ((2, 1), (2, 3)), ((2, 3), (2, 1)), ((2, 3), (2, 3)),
   ((3, 0), (0, 0)), ((3, 0), (2, 0)), ((3, 1), (1, 3)), ((3, 1), (3, 1)),
   ((3, 2), (1, 2)), ((3, 2), (3, 2)), ((3, 3), (0, 0)), ((3, 3), (2, 2))]

/-- **The literal really is the circle** — both directions, at every one of the 256 points. -/
theorem mem_twoAdicCircleFour_iff (z : TwoAdicLevel 4) : z ∈ twoAdicCircleFour ↔ z ∈ twoAdicCircle 4 := by
  revert z; decide +kernel

/-- Properness from the connection set: a colouring that differs across every circle shift is proper on the Cayley
graph. The bridge `addCayley_adj` crosses, in both directions of the connection set's disjunction. -/
theorem proper_of_shift_ne {col : TwoAdicLevel 4 → Fin 4}
    (h : ∀ z : TwoAdicLevel 4, ∀ s ∈ twoAdicCircleFour, col (z + s) ≠ col z)
    {u v : TwoAdicLevel 4} (hadj : (twoAdicPlane 4).Adj u v) : col u ≠ col v := by
  rw [twoAdicPlane, addCayley_adj] at hadj
  rcases hadj.2 with hs | hs
  · have hne := h u (-u + v) ((mem_twoAdicCircleFour_iff _).mpr hs)
    rw [show u + (-u + v) = v by abel] at hne
    exact hne.symm
  · have hne := h v (-v + u) ((mem_twoAdicCircleFour_iff _).mpr hs)
    rw [show v + (-v + u) = u by abel] at hne
    exact hne

/-- Table 1 differs across every circle shift. -/
theorem twoAdicFourCol₁_shift : ∀ z : TwoAdicLevel 4, ∀ s ∈ twoAdicCircleFour,
    twoAdicFourCol₁ (z + s) ≠ twoAdicFourCol₁ z := by decide +kernel

/-- Table 2 differs across every circle shift. -/
theorem twoAdicFourCol₂_shift : ∀ z : TwoAdicLevel 4, ∀ s ∈ twoAdicCircleFour,
    twoAdicFourCol₂ (z + s) ≠ twoAdicFourCol₂ z := by decide +kernel

/-- Table 3 differs across every circle shift. -/
theorem twoAdicFourCol₃_shift : ∀ z : TwoAdicLevel 4, ∀ s ∈ twoAdicCircleFour,
    twoAdicFourCol₃ (z + s) ≠ twoAdicFourCol₃ z := by decide +kernel

/-- Table 4 differs across every circle shift. -/
theorem twoAdicFourCol₄_shift : ∀ z : TwoAdicLevel 4, ∀ s ∈ twoAdicCircleFour,
    twoAdicFourCol₄ (z + s) ≠ twoAdicFourCol₄ z := by decide +kernel

/-- Table 5 differs across every circle shift. -/
theorem twoAdicFourCol₅_shift : ∀ z : TwoAdicLevel 4, ∀ s ∈ twoAdicCircleFour,
    twoAdicFourCol₅ (z + s) ≠ twoAdicFourCol₅ z := by decide +kernel

/-- Every table is proper on `P₄`. -/
theorem twoAdicFourTables_proper :
    ∀ col ∈ twoAdicFourTables, ∀ {u v : TwoAdicLevel 4}, (twoAdicPlane 4).Adj u v → col u ≠ col v := by
  intro col hmem u v hadj
  simp only [twoAdicFourTables, List.mem_cons, List.not_mem_nil, or_false] at hmem
  rcases hmem with rfl | rfl | rfl | rfl | rfl
  exacts [proper_of_shift_ne twoAdicFourCol₁_shift hadj, proper_of_shift_ne twoAdicFourCol₂_shift hadj,
    proper_of_shift_ne twoAdicFourCol₃_shift hadj, proper_of_shift_ne twoAdicFourCol₄_shift hadj,
    proper_of_shift_ne twoAdicFourCol₅_shift hadj]

/-- **The cover**: every nonzero difference is a non-period of some table. -/
theorem twoAdicFourTables_cover :
    ∀ d : TwoAdicLevel 4, d ≠ 0 → ∃ col ∈ twoAdicFourTables, ¬ Function.Periodic col d := by
  decide +kernel

/-- **Level four is pairwise free at four colours.** -/
theorem twoAdicFour_forces_iff {x y : TwoAdicLevel 4} : Forces (twoAdicPlane 4) 4 x y ↔ x = y := by
  refine ⟨fun hf => Forces.eq_of_forall_exists_not_periodic ?_ hf, fun h _C => by rw [h]⟩
  intro d hd
  obtain ⟨col, hmem, hper⟩ := twoAdicFourTables_cover d hd
  exact ⟨SimpleGraph.Coloring.mk col (twoAdicFourTables_proper col hmem), hper⟩

-- Level four has no gap either — but that is a corollary of level FIVE's forced pair (a gap at level 4 pulls back
-- along the level map to level 5, one gap makes the Cayley graph slack, and slackness contradicts the forced pair), so
-- it is stated downstream, in `Instances/TwoAdicFive.lean` (`twoAdicFour_not_slack`), where its only proof lives.

end HadwigerNelson
