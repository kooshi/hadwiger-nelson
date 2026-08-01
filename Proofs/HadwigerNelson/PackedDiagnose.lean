import Proofs.HadwigerNelson.Packed

/-!
# Reading a failed geometry check — the diagnostics, in their own module

`DiffWitness.Certifies` returns one `Bool` over four walks — for de Grey, 1,581 vertex packings, 133
difference packings, 133 squared lengths and 7,877 edge/key pairs — and the kernel can only say no.
Everything here says *which*, runs compiled rather than kernel-reduced, and appears in no proof.

## Why this is a separate module

`Packed.lean` sits upstream of every generated geometry module. Lake's traces are content-based, so
changing any byte of it — including a comment — re-checks all of them. Diagnostics exist to be read
and therefore to be rewritten, so they live here, downstream, where a better sentence costs one file.

That rule was learned the expensive way at M07, where a one-line improvement to a diagnostic message
queued a re-check of 27.8 hours of kernel work.

## What to run when `Certifies` comes back false

```lean
#eval myDiffs.faultReport myTable myCert     -- one line, naming the culprit
#eval myDiffs.firstFault myTable myCert      -- the same answer as data, for a caller that matches
```

`firstFault_isNone` proves the two agree with the checker: no fault is *exactly* a passing check.
Without that theorem their agreement would be a coincidence about two definitions that merely look
alike, and a reader who saw `none` would still not know what had been established.

## What the report does not print

A packed value is a 300-digit integer. `packWrong` *carries* both integers, so a caller matching on
the fault can have them; the rendered sentence does not print them, because at that width they are
the whole truth in the implementation's vocabulary and useless to the person holding the error. What
that person needs is the index and the likely cause, which is what the sentence gives.
-/

namespace HadwigerNelson

/-- What went wrong, as data.

`which` is `"vertex"` or `"difference"` — the two tables `Certifies` walks the same way, so they
share the constructors rather than doubling them. -/
inductive DiffFault where
  /-- The packed table is not the point table's shape, so an index means two different things. -/
  | shape (which : String)
  /-- A leaf is outside the bound the packing needs to be injective. -/
  | tooLarge (which : String) (i : ℕ) (bound : Int)
  /-- The packed table disagrees with the point it is supposed to pack. -/
  | packWrong (which : String) (i : ℕ) (held wanted : Int)
  /-- A difference does not have the squared length a unit edge must have. -/
  | normWrong (k : ℕ) (found wanted : Q4)
  /-- An edge's endpoints do not differ by the difference its key names. -/
  | edgeWrong (pos i j k : ℕ)
  /-- The edge list and the key list ran out at different times. -/
  | keysLength (pos : ℕ)
deriving Repr

namespace DiffWitness

variable {n : ℕ}

/-- The first fault in a point table walked against its packing, or `none`.

Mirrors `packOk` case for case — including which comparison happens first — so the two cannot
disagree about *whether* there is a fault. `firstFault_isNone` is that claim, proved. -/
def packFault (b : Int) (which : String) : PtTable → IntTable → ℕ → Option DiffFault
  | .leaf p, .leaf v, i =>
      if !Packable.bounded b p then some (.tooLarge which i b)
      else if v == Packable.pack p then none
      else some (.packWrong which i v (Packable.pack p))
  | .node m l r, .node m' l' r', i =>
      if m == m' then (packFault b which l l' i).or (packFault b which r r' (i + m))
      else some (.shape which)
  | _, _, _ => some (.shape which)

/-- The first difference whose squared length is wrong, or `none`. -/
def normsFault (target : Q4) : PtTable → ℕ → Option DiffFault
  | .leaf v, k => if v.normSq == target then none else some (.normWrong k v.normSq target)
  | .node m l r, k => (normsFault target l k).or (normsFault target r (k + m))

/-- The first edge whose endpoints do not differ by the difference its key names, or `none`. A
length disagreement is `keysLength`, never a silent truncation. -/
def edgesFault (w : DiffWitness n) : ℕ → List (Fin n × Fin n) → List ℕ → Option DiffFault
  | _, [], [] => none
  | pos, e :: es, k :: ks =>
      if w.packedV.get e.1.val - w.packedV.get e.2.val == w.packedD.get k then
        edgesFault w (pos + 1) es ks
      else some (.edgeWrong pos e.1.val e.2.val k)
  | pos, _, _ => some (.keysLength pos)

/-- **The first thing to `#eval` when `Certifies` comes back false**, as data.

The four walks in the order `Certifies` runs them, so the fault reported is the one a reader would
find first by hand. -/
def firstFault (w : DiffWitness n) (t : PtTable) (c : UDCert n) : Option DiffFault :=
  (packFault vertexBound "vertex" t w.packedV 0).or <|
    (packFault (2 * vertexBound) "difference" w.diffs w.packedD 0).or <|
      (normsFault c.denomSq w.diffs 0).or (w.edgesFault 0 c.edges w.keys)

/-! ### The diagnostic's promise, proved

Each walk finds a fault exactly when its checker fails. Stated as a `Bool` equation rather than an
`↔` because that is the form the composition needs, and because it is the form the induction proves
without a case split. -/

theorem packFault_isNone (b : Int) (which : String) :
    ∀ (t : PtTable) (u : IntTable) (i : ℕ), (packFault b which t u i).isNone = packOk b t u := by
  intro t
  induction t with
  | leaf p =>
      intro u i; cases u with
      | leaf v =>
          by_cases h : Packable.bounded b p
          · by_cases h2 : v = Packable.pack p <;> simp [packFault, packOk, h, h2]
          · simp [packFault, packOk, h]
      | node _ _ _ => simp [packFault, packOk]
  | node m l r ihl ihr =>
      intro u i; cases u with
      | leaf v => simp [packFault, packOk]
      | node m' l' r' =>
          by_cases h : m = m' <;>
            simp [packFault, packOk, h, Option.isNone_or, ihl, ihr, Bool.and_assoc]

theorem normsFault_isNone (target : Q4) :
    ∀ (t : PtTable) (k : ℕ), (normsFault target t k).isNone = normsOk target t := by
  intro t
  induction t with
  | leaf v => intro k; by_cases h : v.normSq = target <;> simp [normsFault, normsOk, h]
  | node m l r ihl ihr => intro k; simp [normsFault, normsOk, Option.isNone_or, ihl, ihr]

theorem edgesFault_isNone (w : DiffWitness n) :
    ∀ (pos : ℕ) (es : List (Fin n × Fin n)) (ks : List ℕ),
      (w.edgesFault pos es ks).isNone = w.edgesOk es ks := by
  intro pos es
  induction es generalizing pos with
  | nil => intro ks; cases ks <;> simp [edgesFault, edgesOk]
  | cons e es ih =>
      intro ks; cases ks with
      | nil => simp [edgesFault, edgesOk]
      | cons k ks =>
          by_cases h : w.packedV.get e.1.val - w.packedV.get e.2.val = w.packedD.get k <;>
            simp [edgesFault, edgesOk, h, ih]

/-- **No fault is exactly a passing check.** What makes `#eval w.faultReport t c` more than
suggestive: `Certifies` is settled by kernel reduction and `firstFault` by the compiler, so they are
two independent evaluators, and this is why their agreement is not a coincidence. -/
theorem firstFault_isNone (w : DiffWitness n) (t : PtTable) (c : UDCert n) :
    (w.firstFault t c).isNone = w.Certifies t c := by
  simp only [firstFault, Certifies, Option.isNone_or, packFault_isNone, normsFault_isNone,
    edgesFault_isNone, Bool.and_assoc]

/-- The same statement in the direction a reader of `#eval` relies on. -/
theorem firstFault_eq_none_iff (w : DiffWitness n) (t : PtTable) (c : UDCert n) :
    w.firstFault t c = none ↔ w.Certifies t c = true := by
  rw [← Option.isNone_iff_eq_none, firstFault_isNone]

end DiffWitness

/-! ### The sentence -/

/-- The fault as one line, in the vocabulary of the person reading it.

Deliberately silent about the packed integers a `packWrong` carries: they are three hundred digits
each, and the reader's next move is to regenerate or to check the lane convention, not to compare
them by eye. -/
def DiffFault.report : DiffFault → String
  | .shape which =>
      s!"the {which} table and its packing are different shapes — the packed table must be split at \
         the same pivots as the point table"
  | .tooLarge which i bound =>
      s!"{which} {i} has a coordinate leaf larger than {bound}, which is the bound that makes the \
         packing injective"
  | .packWrong which i _ _ =>
      s!"{which} {i}: the packed table does not hold this point's packing — regenerate, or check the \
         lane convention against the ruler constant in Packed.lean"
  | .normWrong k found wanted =>
      s!"difference {k} has squared length {repr found}, not {repr wanted} — this pair is not one \
         unit apart"
  | .edgeWrong pos i j k =>
      s!"edge {pos} joins {i} and {j}, which do not differ by difference {k}"
  | .keysLength pos =>
      s!"the edge list and the key list disagree in length, at position {pos} — every edge needs \
         exactly one key, in edge order"

namespace DiffWitness

variable {n : ℕ}

/-- **What to `#eval` the moment `Certifies` comes back false**, in one line and in English. -/
def faultReport (w : DiffWitness n) (t : PtTable) (c : UDCert n) : String :=
  match w.firstFault t c with
  | none => "the witness certifies the geometry"
  | some f => f.report

end DiffWitness

/-! ## Spec

The report is the surface a person actually meets when a certificate fails, so the *rendered text* is
pinned here rather than left to drift. Each line below is a deliberate break of the two-point fixture
in `Packed.lean`, and each must render as the sentence that names it. -/

section Spec

private def pairTable : PtTable := .node 1 (.leaf ⟨0, 0⟩) (.leaf ⟨1, 0⟩)

private def pairCert : UDCert 2 where
  verts := pairTable.toVerts
  edges := [(0, 1)]
  denom := 1

private def pairDiffs : DiffWitness 2 where
  packedV := .node 1 (.leaf (Packable.pack (⟨0, 0⟩ : Pt))) (.leaf (Packable.pack (⟨1, 0⟩ : Pt)))
  diffs := .leaf ⟨-1, 0⟩
  packedD := .leaf (Packable.pack (⟨-1, 0⟩ : Pt))
  keys := [0]

/-- info: "the witness certifies the geometry" -/
#guard_msgs in #eval pairDiffs.faultReport pairTable pairCert

/-- info: "vertex 1: the packed table does not hold this point's packing — regenerate, or check the lane convention against the ruler constant in Packed.lean" -/
#guard_msgs in
#eval ({ pairDiffs with
          packedV := .node 1 (.leaf (Packable.pack (⟨0, 0⟩ : Pt))) (.leaf 0) } :
        DiffWitness 2).faultReport pairTable pairCert

/-- info: "the vertex table and its packing are different shapes — the packed table must be split at the same pivots as the point table" -/
#guard_msgs in
#eval ({ pairDiffs with packedV := .leaf 0 } : DiffWitness 2).faultReport pairTable pairCert

/-- info: "the edge list and the key list disagree in length, at position 0 — every edge needs exactly one key, in edge order" -/
#guard_msgs in
#eval ({ pairDiffs with keys := [] } : DiffWitness 2).faultReport pairTable pairCert

/-- info: "difference 1 has squared length 4, not 1 — this pair is not one unit apart" -/
#guard_msgs in
#eval ({ pairDiffs with
          diffs := .node 1 (.leaf ⟨-1, 0⟩) (.leaf ⟨-2, 0⟩)
          packedD := .node 1 (.leaf (Packable.pack (⟨-1, 0⟩ : Pt)))
                             (.leaf (Packable.pack (⟨-2, 0⟩ : Pt)))
          keys := [1] } : DiffWitness 2).faultReport pairTable pairCert

/-! The key control needs a *unit-length* wrong difference, or the norms walk catches it first and
the edge walk is never reached — which is what the line above shows. `(0,-1)` is one unit long and
is not this edge's difference. -/

/-- info: "edge 0 joins 0 and 1, which do not differ by difference 1" -/
#guard_msgs in
#eval ({ pairDiffs with
          diffs := .node 1 (.leaf ⟨-1, 0⟩) (.leaf ⟨0, -1⟩)
          packedD := .node 1 (.leaf (Packable.pack (⟨-1, 0⟩ : Pt)))
                             (.leaf (Packable.pack (⟨0, -1⟩ : Pt)))
          keys := [1] } : DiffWitness 2).faultReport pairTable pairCert

end Spec

end HadwigerNelson
