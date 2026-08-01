import Proofs.HadwigerNelson.Forcer

/-!
# Why a spindled candidate was refused

`not_colorable_spindleEdges` takes three checkable side conditions, and during a search all three
fail far more often than they hold — that is what searching is. When one does fail, `decide` says
only that it failed, which names nothing.

This module says which. It is `#eval`-only and nothing imports it, so it can be rewritten for the
cost of one file — the same arrangement `AssemblyDiagnose` has, and for the same reason: prose in a
module a certificate imports is a decision about hours.

    #eval spindleReport demoA demoB rhombus 0 3
-/

namespace HadwigerNelson

variable {n N : ℕ}

/-- The edges a placement flattens to a single point, with the vertex they land on.

A placement must be injective **on the forcer's edges** — two adjacent points landing together is a
loop, and a loop is not an edge, so the copy is not a copy. This is what `not_colorable_spindleEdges`
checks per edge, reported rather than merely refused. -/
def collapsedEdges (φ : Fin n → Fin N) (E : List (Fin n × Fin n)) :
    List ((Fin n × Fin n) × Fin N) :=
  E.filterMap fun e => if e.1 ≠ e.2 ∧ φ e.1 = φ e.2 then some (e, φ e.1) else none

/-- Everything the closing lemma needs, checked and rendered in one line.

Reports the **first** thing wrong, because a candidate with two faults is not more interesting than
one with a single fault — and reports the shape of the candidate when nothing is wrong, so a passing
run still says what it passed on. -/
def spindleReport (φ ψ : Fin n → Fin N) (E : List (Fin n × Fin n)) (p q : Fin n) : String :=
  -- `match` rather than `head!`: a report that returned a junk vertex when the list was empty
  -- would name an innocent edge, which is worse than saying nothing.
  let firstCollapse (name : String) : List ((Fin n × Fin n) × Fin N) → Option String
    | [] => none
    | (e, v) :: rest =>
        some s!"copy {name} collapses {rest.length + 1} of {E.length} edges, \
first {e} onto vertex {v}"
  if φ p ≠ ψ p then
    s!"the copies do not share the pivot: vertex {p} lands at {φ p} in copy A and {ψ p} in copy B"
  else if φ q = ψ q then
    s!"the partners coincide at {φ q}, so there is no joining edge — pick a pivot–partner pair the \
spindle actually separates"
  else match firstCollapse "A" (collapsedEdges φ E) with
    | some m => m
    | none => match firstCollapse "B" (collapsedEdges ψ E) with
      | some m => m
      | none => s!"placements OK: 2 copies of {E.length} edges sharing vertex {φ p}, \
joined {(φ q, ψ q)}"

-- **What this cannot tell you.** That the pair really is forced is the one claim no rendering
-- settles — it is `Forces.of_edges (by decide +kernel)` at a size the kernel can exhaust, and
-- `Forces.of_gadget` from a SAT certificate above it. A report that said "forced" would be a check
-- that reports what it cannot run, which is how two gates here have failed open.

/-! ## Spec — both directions, pinned

A diagnostic that renders nothing when it cannot run is worse than none, so the passing case is
pinned as tightly as the failing ones. -/

/-- The two placements that make the Moser spindle, repeated here rather than imported: this module
sits below `Instances/` and must not depend on it. -/
def demoA : Fin 4 → Fin 7 := ![0, 1, 2, 3]

/-- The second placement, sharing the pivot `0`. -/
def demoB : Fin 4 → Fin 7 := ![0, 4, 5, 6]

/-- A placement that flattens the rhombus's far corners onto each other. -/
def demoCollapse : Fin 4 → Fin 7 := ![0, 4, 4, 6]

/-- A placement that does not share the pivot. -/
def demoUnshared : Fin 4 → Fin 7 := ![6, 4, 5, 3]

/-- info: "placements OK: 2 copies of 5 edges sharing vertex 0, joined (3, 6)" -/
#guard_msgs in
#eval spindleReport demoA demoB rhombus 0 3

/-- info: "the copies do not share the pivot: vertex 0 lands at 0 in copy A and 6 in copy B" -/
#guard_msgs in
#eval spindleReport demoA demoUnshared rhombus 0 3

/-- info: "the partners coincide at 3, so there is no joining edge — pick a pivot–partner pair the spindle actually separates" -/
#guard_msgs in
#eval spindleReport demoA demoA rhombus 0 3

/-- info: "copy B collapses 1 of 5 edges, first (1, 2) onto vertex 4" -/
#guard_msgs in
#eval spindleReport demoA demoCollapse rhombus 0 3

/-- info: [] -/
#guard_msgs in
#eval collapsedEdges demoA rhombus

/-- info: [((1, 2), 4)] -/
#guard_msgs in
#eval collapsedEdges demoCollapse rhombus

end HadwigerNelson
