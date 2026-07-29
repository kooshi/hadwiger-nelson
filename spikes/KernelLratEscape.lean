import Std.Tactic.BVDecide.LRAT.Checker
open Std.Sat Std.Tactic.BVDecide.LRAT Std.Tactic.BVDecide.LRAT.Internal

set_option maxHeartbeats 2000000
set_option maxRecDepth 100000

/-! A genuine multi-step RUP refutation driven through core's GENERIC `lratChecker` (structurally
recursive over `List (Action β α)`), bypassing `DefaultClause.ofArray` and so bypassing the
`Std.HashMap` that makes the shipped entry point unreducible.

  c1 = (x ∨ y)   c2 = (x ∨ ¬y)   c3 = (¬x ∨ y)   c4 = (¬x ∨ ¬y)   -- unsatisfiable
Derive (x) from c1,c2; derive (¬x) from c3,c4; then the empty clause from those two. -/

abbrev V3 := PosFin 3
abbrev xv : V3 := ⟨1, by omega⟩
abbrev yv : V3 := ⟨2, by omega⟩

def c1 : DefaultClause 3 := { clause := [(xv, true),  (yv, true)] }
def c2 : DefaultClause 3 := { clause := [(xv, true),  (yv, false)] }
def c3 : DefaultClause 3 := { clause := [(xv, false), (yv, true)] }
def c4 : DefaultClause 3 := { clause := [(xv, false), (yv, false)] }
def uX  : DefaultClause 3 := DefaultClause.unit (xv, true)
def uNX : DefaultClause 3 := DefaultClause.unit (xv, false)

def F : DefaultFormula 3 := DefaultFormula.ofArray #[none, some c1, some c2, some c3, some c4]

def prf : List (Action (DefaultClause 3) V3) :=
  [ .addRup 5 uX  #[1, 2],
    .addRup 6 uNX #[3, 4],
    .addEmpty 7 #[5, 6] ]

#eval lratChecker F prf

/-- THE DECISIVE QUESTION: does the KERNEL reduce it? -/
theorem escape : lratChecker F prf = .success := by decide +kernel

/-- ...and does core's axiom-clean soundness theorem then apply? -/
theorem escape_unsat : Unsatisfiable V3 F :=
  lratCheckerSound F (DefaultFormula.readyForRupAdd_ofArray _)
    (DefaultFormula.readyForRatAdd_ofArray _) prf
    (by
      intro a ha
      -- `prf` contains no `.addRat`, and `WellFormedAction` is `True` on every other constructor.
      simp only [prf, List.mem_cons, List.not_mem_nil, or_false] at ha
      rcases ha with rfl | rfl | rfl <;> trivial)
    escape

#print axioms escape
#print axioms escape_unsat
