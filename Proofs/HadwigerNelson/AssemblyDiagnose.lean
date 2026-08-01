import Proofs.HadwigerNelson.Assembly

/-!
# What an assembly says on the failing day

`Assembly.valid_of_cross` takes `hcross : (A.cert cross).ValidOn cross = true`, and during a search
that hypothesis is **false far more often than it is true** — proposing seams is what searching is.
Today a caller who gets it wrong sees `decide` decline to reduce a `Bool`, which names nothing.

`UDCert.badEdges` already answers "which edges failed and what distance did they actually have", and
`UDCert.badEdges_eq_nil_iff` ties it to `Valid` so the diagnostic cannot drift from the verdict. What
it cannot do is speak the caller's language: an assembled certificate is indexed by
`Fin (copies * n)`, and **a searcher holds a copy number and a base vertex**, never a flat index.
Handing back `(1407, 22)` when the answer is "copy 3's vertex 12 to copy 0's vertex 4" is the
author's indexing crossing the wire in place of the user's question.

Everything here is `#eval`-only and lives downstream of `Assembly` on purpose: diagnostics get
rewritten, and this is the one file that can be rewritten for the price of itself. Nothing in
`Assembly.lean` imports it, so no certificate ever pays for a word of it.
-/

namespace HadwigerNelson

namespace Assembly

variable {n : ℕ} (A : Assembly n)

/-- Split a flat assembled index back into the copy and the base vertex it came from — the inverse of
`Assembly.embed`, which is `finProdFinEquiv` and therefore has one. -/
def unembed (v : Fin (A.places.length * n)) : Fin A.places.length × Fin n :=
  finProdFinEquiv.symm v

/-- `unembed` really does invert `embed`. Stated so the diagnostic below cannot quietly report the
wrong copy — a renderer that mislabels which copy failed is worse than no renderer. -/
theorem unembed_embed (i : Fin A.places.length) (v : Fin n) : A.unembed (A.embed i v) = (i, v) := by
  simp [unembed, embed]

/-- **The seams that are not unit distances**, in the caller's vocabulary: for each failing pair, the
copy and base vertex of each end, the squared distance actually found, and the squared distance a
unit edge would have had.

Read the last two together — a seam that is off by a factor is a denominator mistake, and a seam that
is off by a little is a wrong point. -/
def badSeams (cross : List (Fin (A.places.length * n) × Fin (A.places.length * n))) :
    List (((Fin A.places.length × Fin n) × (Fin A.places.length × Fin n)) × Q4 × Q4) :=
  ((A.cert cross).badEdges.filter fun r => r.1 ∈ cross).map fun r =>
    ((A.unembed r.1.1, A.unembed r.1.2), r.2, (A.cert cross).denomSq)

/-- **The whole verdict in one line**, for a caller who wants to know *whether* before *why*. -/
def seamReport (cross : List (Fin (A.places.length * n) × Fin (A.places.length * n))) : String :=
  let bad := A.badSeams cross
  if bad.isEmpty then
    s!"all {cross.length} seams are unit distances; {A.places.length} copies, " ++
      s!"{A.copiedEdges.length} copied edges free"
  else
    s!"{bad.length} of {cross.length} seams are NOT unit distances — " ++
      s!"#eval to see which: (copy, vertex) pairs with the squared distance found"

end Assembly

/-! ## Spec — the renderer is the product, so it is pinned

A diagnostic that reports nothing when it cannot run is the failure this project has had twice. Both
directions are pinned below: a good assembly reports zero bad seams, a broken one names the copy. -/

section Spec

/-- **A seam that really is one.** Two copies of a unit edge — one left in place, one rotated about
the origin by the `3–4–5` rotation — joined by claiming copy 0's far end is a unit from copy 1's
shared end. It is: both are a unit from the origin and the rotation takes one to the other. Four
vertices and three edges, a genuine unit-distance graph that no generator emitted. -/
def demoSeam : List (Fin (demoAssembly.places.length * 2) × Fin (demoAssembly.places.length * 2)) :=
  [(demoAssembly.embed ⟨0, by decide⟩ 1, demoAssembly.embed ⟨1, by decide⟩ 0)]

/-- **A seam that is not.** The same two copies, joined at the *wrong* end — exactly the mistake a
search makes when it proposes a pair the geometry does not support. -/
def demoBadSeam : List (Fin (demoAssembly.places.length * 2) × Fin (demoAssembly.places.length * 2)) :=
  [(demoAssembly.embed ⟨0, by decide⟩ 1, demoAssembly.embed ⟨1, by decide⟩ 1)]

/-- info: "all 0 seams are unit distances; 2 copies, 2 copied edges free" -/
#guard_msgs in
#eval demoAssembly.seamReport []

/-- info: "all 1 seams are unit distances; 2 copies, 2 copied edges free" -/
#guard_msgs in
#eval demoAssembly.seamReport demoSeam

/-- info: "1 of 1 seams are NOT unit distances — #eval to see which: (copy, vertex) pairs with the squared distance found" -/
#guard_msgs in
#eval demoAssembly.seamReport demoBadSeam

-- The failing seam, named by copy and base vertex rather than by flat index, with the squared
-- distance found beside the one a unit edge would have had.
/-- info: [(((0, 1), 1, 1), 12500, 15625)] -/
#guard_msgs in
#eval (demoAssembly.badSeams demoBadSeam).map fun r => (r.1, r.2.1, r.2.2)

-- And the good seam has nothing to report, which is the partner that must stay empty.
/-- info: [] -/
#guard_msgs in
#eval (demoAssembly.badSeams demoSeam).map fun r => (r.1, r.2.1, r.2.2)

/-- **The assembled graph with its seam is a valid certificate** — three edges, two of them free. -/
example : (demoAssembly.cert demoSeam).Valid = true :=
  demoAssembly.valid_of_cross demoSeam (by decide +kernel) (by decide +kernel)

end Spec

end HadwigerNelson
