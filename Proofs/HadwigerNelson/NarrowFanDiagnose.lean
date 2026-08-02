import Proofs.HadwigerNelson.NarrowFan

/-! # Which datum of a narrow-fan certificate is wrong — the `#eval` surface

A failed `decide +kernel` over a 1,581-vertex certificate prints an unprintable term (the
fault table in `Sat/MaskCheck.lean` has the row: `[Error pretty printing: maximum recursion
depth has been reached]` is the *renderer* dying, not the check). This module is what to run
instead:

    #eval (deGreyNarrow630.firstFault deGrey.verts deGrey.edges).map NarrowFault.report

Nothing imports this file, so it is rewritable for the cost of one module — the M07 placement —
and `firstFault_none_iff_check` below is what makes running it more than suggestive: the fault
walk and the kernel's `Bool` are two independent evaluators, and without that theorem their
agreement would be a coincidence between definitions that merely look alike (M04's arrangement).
-/

namespace HadwigerNelson

/-- The first thing wrong with a narrow-fan certificate, carrying the data a person fixes it
with: vertex numbers, class indices, and decoded tower values — never raw packed integers. -/
inductive NarrowFault where
  /-- A generator bound fails its squaring check. -/
  | badBounds
  /-- Adjacent class values at positions `i, i+1` whose intervals overlap — out of order, equal,
  or under-precise bounds. Carries both decoded values. -/
  | notSeparated (i : ℕ) (a b : Q4)
  /-- No colourings at all — the empty-partner case of the headline would be unwitnessed. -/
  | noColourings
  /-- Colouring `i` paints both ends of the listed edge `e` alike. -/
  | improperColouring (i : ℕ) (e : ℕ × ℕ)
  /-- Vertex `v`'s class id `i` is out of range of the class table. -/
  | classUnresolved (v i : ℕ)
  /-- Vertex `v`'s exact squared distance to the pivot is not what its class holds. Carries the
  distance found and the class value bound, both decoded. -/
  | wrongValue (v : ℕ) (found bound : Q4)
  /-- Class `i`'s hint `j` is out of range of the colouring list. -/
  | hintUnresolved (v i j : ℕ)
  /-- The hinted colouring `j` paints vertex `v` like the pivot — the separation that class
  promised does not hold at this vertex. -/
  | notSeparating (v j : ℕ)
  /-- A stage's guard failed but its locator found no culprit — impossible unless this module
  has drifted from `NarrowFan.lean`; report it as a bug here, never as a certificate fault. -/
  | unlocated
  deriving Repr, DecidableEq

/-- The fault as a sentence, in the vocabulary of the person holding it. -/
def NarrowFault.report : NarrowFault → String
  | .badBounds => "a square-root bound fails its squaring check"
  | .notSeparated i a b =>
      s!"class values {i} and {i + 1} are not separated at this precision: " ++
      s!"{repr a} vs {repr b} — reorder them, or tighten the bounds"
  | .noColourings => "the certificate carries no colourings at all"
  | .improperColouring i e =>
      s!"colouring {i} paints both ends of edge {e} alike"
  | .classUnresolved v i => s!"vertex {v} names class {i}, which is out of range"
  | .wrongValue v found bound =>
      s!"vertex {v}: squared distance to the pivot is {repr found}, " ++
      s!"but its class holds {repr bound}"
  | .hintUnresolved v i j =>
      s!"vertex {v}'s class {i} hints colouring {j}, which is out of range"
  | .notSeparating v j =>
      s!"colouring {j} paints vertex {v} like the pivot"
  | .unlocated =>
      "a check stage failed but its locator found no culprit — a NarrowFanDiagnose bug"

/-- The first overlap in an interval chain, position-indexed — `sepIvals`'s failure, named. -/
def firstOverlap : List Ival → ℕ → Option ℕ
  | [], _ => none
  | [_], _ => none
  | a :: b :: t, i => if a.hi < b.lo then firstOverlap (b :: t) (i + 1) else some i

private theorem firstOverlap_none_iff (l : List Ival) (i : ℕ) :
    firstOverlap l i = none ↔ sepIvals l = true := by
  induction l generalizing i with
  | nil => simp [firstOverlap, sepIvals]
  | cons a t ih =>
    cases t with
    | nil => simp [firstOverlap, sepIvals]
    | cons b t' =>
      rw [firstOverlap, sepIvals]
      by_cases hab : a.hi < b.lo <;> simp [hab, ih]

namespace NarrowCert

variable {n : ℕ}

/-- The per-vertex fault, mirroring `checkVertex` stage by stage. -/
def vertexFault (c : NarrowCert n) (verts : Fin n → Pt) (v : Fin n) : Option NarrowFault :=
  let i := unpackNat c.idBits c.classIds v.val
  match c.classVals[i]? with
  | none => some (.classUnresolved v.val i)
  | some d =>
    if (verts v).distSq (verts c.pivot) ≠ unpackQ4 c.valBits d then
      some (.wrongValue v.val ((verts v).distSq (verts c.pivot)) (unpackQ4 c.valBits d))
    else
      let j := unpackNat c.hintBits c.hints i
      match c.colourings[j]? with
      | none => some (.hintUnresolved v.val i j)
      | some col =>
        if unpackColor c.bits c.k col v.val = unpackColor c.bits c.k col c.pivot.val then
          some (.notSeparating v.val j)
        else none

theorem vertexFault_none_iff (c : NarrowCert n) (verts : Fin n → Pt) (v : Fin n) :
    c.vertexFault verts v = none ↔ c.checkVertex verts v = true := by
  rw [vertexFault, checkVertex]
  rcases h1 : c.classVals[unpackNat c.idBits c.classIds v.val]? with - | d
  · simp
  · rcases h3 : c.colourings[unpackNat c.hintBits c.hints
        (unpackNat c.idBits c.classIds v.val)]? with - | col
    · by_cases h2 : (verts v).distSq (verts c.pivot) = unpackQ4 c.valBits d <;>
        simp [h2, h3]
    · by_cases h2 : (verts v).distSq (verts c.pivot) = unpackQ4 c.valBits d <;>
        by_cases h4 : unpackColor c.bits c.k col v.val
            = unpackColor c.bits c.k col c.pivot.val <;>
        simp [h2, h3, h4]

/-- **The first fault in the whole certificate.** Every stage is guarded by *exactly the conjunct
`check` tests* — the locator inside a failing branch only names the culprit — which is what makes
`firstFault_none_iff_check` a case analysis instead of a proof, and drift between the two
structurally impossible at the stage level. A locator that cannot find its stage's culprit
reports `.unlocated` rather than pretending, which is a bug report about this module. -/
def firstFault (c : NarrowCert n) (verts : Fin n → Pt) (E : List (Fin n × Fin n)) :
    Option NarrowFault :=
  let decoded := c.classVals.map (unpackQ4 c.valBits)
  if !c.bounds.Ok then some .badBounds
  else if !sepChain c.bounds decoded then
    let i := (firstOverlap (decoded.map (Q4.approx c.bounds)) 0).getD 0
    some (.notSeparated i (decoded[i]?.getD 0) (decoded[i + 1]?.getD 0))
  else if c.colourings.isEmpty then some .noColourings
  else if !c.colourings.all (properColouring E c.bits c.k) then
    some ((c.colourings.zipIdx.findSome? fun ci =>
      (E.find? fun e => e.1 != e.2 &&
        unpackColor c.bits c.k ci.1 e.1.val == unpackColor c.bits c.k ci.1 e.2.val).map
        fun e => NarrowFault.improperColouring ci.2 (e.1.val, e.2.val)).getD .unlocated)
  else if !(List.finRange n).all (fun v => v == c.pivot || c.checkVertex verts v) then
    some (((List.finRange n).findSome? fun v =>
      if v = c.pivot then none else c.vertexFault verts v).getD .unlocated)
  else none

/-- **The diagnostic's promise, proved**: no fault is *exactly* a passing check. `firstFault`
runs compiled and `check` in the kernel — two independent evaluators — and this is the theorem
without which their agreement would be a coincidence between definitions that look alike. -/
theorem firstFault_none_iff_check (c : NarrowCert n) (verts : Fin n → Pt)
    (E : List (Fin n × Fin n)) :
    c.firstFault verts E = none ↔ c.check verts E = true := by
  rw [firstFault, check]
  by_cases h1 : c.bounds.Ok <;>
    by_cases h2 : sepChain c.bounds (c.classVals.map (unpackQ4 c.valBits)) <;>
    by_cases h3 : c.colourings.isEmpty <;>
    by_cases h4 : c.colourings.all (properColouring E c.bits c.k) <;>
    by_cases h5 : (List.finRange n).all (fun v => v == c.pivot || c.checkVertex verts v) <;>
    simp [h1, h2, h3, h4, h5]

end NarrowCert

/-! ## Specification — the rendered text is the product

The same three collinear points as `NarrowFan.lean`'s spec, with one mutation per fault
constructor; the *sentences* are pinned, because the sentence is what a person holding a failed
build reads. -/

private def dVerts : Fin 3 → Pt := ![⟨0, 0⟩, ⟨1, 0⟩, ⟨2, 0⟩]

private def dEdges : List (Fin 3 × Fin 3) := [(0, 1)]

private def dCert : NarrowCert 3 where
  pivot := 0
  k := 3
  bits := 2
  idBits := 1
  hintBits := 1
  bounds := .coarse
  valBits := 8
  classVals := [2, 8]
  classIds := 0 + 0 * 2 + 1 * 4
  hints := 0
  colourings := [0 + 1 * 4 + 1 * 16]

-- Agreement with the checker, exercised on the passing instance…
#guard dCert.firstFault dVerts dEdges = none
#guard dCert.check dVerts dEdges

/-- info: some "colouring 0 paints both ends of edge (0, 1) alike" -/
#guard_msgs in
#eval (({ dCert with colourings := [0 + 0 * 4 + 1 * 16] } : NarrowCert 3).firstFault
  dVerts dEdges).map NarrowFault.report

/-- info: some "class values 0 and 1 are not separated at this precision: 4 vs 1 — reorder them, or tighten the bounds" -/
#guard_msgs in
#eval (({ dCert with classVals := [8, 2] } : NarrowCert 3).firstFault
  dVerts dEdges).map NarrowFault.report

/-- info: some "vertex 1: squared distance to the pivot is 1, but its class holds 4" -/
#guard_msgs in
#eval (({ dCert with classIds := 0 + 1 * 2 + 1 * 4 } : NarrowCert 3).firstFault
  dVerts dEdges).map NarrowFault.report

/-- info: some "colouring 0 paints vertex 2 like the pivot" -/
#guard_msgs in
#eval (({ dCert with colourings := [0 + 1 * 4 + 0 * 16] } : NarrowCert 3).firstFault
  dVerts dEdges).map NarrowFault.report

/-- info: some "vertex 1's class 0 hints colouring 1, which is out of range" -/
#guard_msgs in
#eval (({ dCert with hints := 1 + 1 * 2 } : NarrowCert 3).firstFault
  dVerts dEdges).map NarrowFault.report

/-- info: some "the certificate carries no colourings at all" -/
#guard_msgs in
#eval (({ dCert with colourings := [] } : NarrowCert 3).firstFault
  dVerts dEdges).map NarrowFault.report

/-- info: some "a square-root bound fails its squaring check" -/
#guard_msgs in
#eval (({ dCert with bounds := ⟨10, ⟨20, 30⟩, ⟨22, 23⟩, ⟨26, 27⟩, ⟨33, 34⟩⟩ } :
  NarrowCert 3).firstFault dVerts dEdges).map NarrowFault.report

/-- **Why `sound` demands `pivot ∉ Q`**: the pivot fans itself trivially — `Fan G k p [p]` holds
in every colourable graph — so without the hypothesis a checked certificate would "refute" a true
fan. The adversarial member `Fan.lean` admits on purpose, exercised against this module's own
spec instance. -/
example : Fan (edgeGraph 3 dEdges) 3 0 [0] := Fan.of_edges (by decide +kernel)

end HadwigerNelson
