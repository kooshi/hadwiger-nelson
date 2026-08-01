import Proofs.HadwigerNelson.Critical

/-! # Why a criticality certificate was refused

`decide +kernel` on a false `Bool` says only that it is false. A certificate has one row per vertex
— 510 of them for Heule's witness, 1581 for de Grey's — so "false" names nothing a person can act
on. This module turns it into a sentence.

Nothing imports this file, deliberately. `Critical.lean` sits under every generated chunk module, so
editing a docstring there re-checks all of them; editing this one costs this one file. That is the
same placement M07 gave `Sat/Diagnose.lean` and M13 `ForcerDiagnose.lean`, for the same measured
reason.

To point it at a real certificate, import the witness's `Critical` module in a scratch file and

    #eval diagnose heule510.edges 2 4 heule510Criticality 510

Every message below is pinned with `#guard_msgs`, so the rendered text is under test rather than
under review.
-/

namespace HadwigerNelson

/-- The first row whose colouring is not proper off its pivot, with the edge that broke it and the
colour its two endpoints share.

Returns `(pivot, i, j, colour)`. Searching *forwards* is deliberate: the first failure is the one a
re-solve should target, and a certificate usually fails because one pivot's solve went wrong rather
than because the whole file is wrong. -/
def firstBadRow {n : ℕ} (E : List (Fin n × Fin n)) (bits k : ℕ) (cs : List ℕ) :
    Option (ℕ × ℕ × ℕ × ℕ) :=
  cs.zipIdx.findSome? fun (c, p) =>
    (E.find? fun e => !(e.1.val == p || e.2.val == p ||
        unpackColor bits k c e.1.val != unpackColor bits k c e.2.val)).map fun e =>
      (p, e.1.val, e.2.val, unpackColor bits k c e.1.val)

/-- What is wrong with this certificate, in one sentence.

The two failures are reported **separately** and the length is checked first, because they call for
different repairs: a short list means the emitter stopped early and some pivot was never certified,
while a bad row means a pivot was certified wrongly. Collapsing them into "the certificate is
invalid" would leave the reader to guess which. -/
def diagnose {n : ℕ} (E : List (Fin n × Fin n)) (bits k : ℕ) (cs : List ℕ) (vertices : ℕ) :
    String :=
  if cs.length ≠ vertices then
    s!"certificate has {cs.length} rows for a {vertices}-vertex graph: " ++
    (if cs.length < vertices then
       s!"pivots {cs.length}–{vertices - 1} were never certified. The emitter stopped early; " ++
       "it is built to refuse rather than write a short file, so this file was not written by it."
     else "there are more rows than vertices, so the rows and the pivots are out of step.")
  else match firstBadRow E bits k cs with
    | some (p, i, j, colour) =>
        s!"row {p} of {vertices} is not a colouring of the graph with vertex {p} removed: " ++
        s!"edge ({i}, {j}) has colour {colour} at both ends, and neither end is {p}. " ++
        s!"Re-solve pivot {p}."
    | none => s!"{vertices} rows, every one a proper {k}-colouring off its own pivot."

/-! ## The messages, pinned

Each rendering is exercised on `rhombus` — `[(0,1), (0,2), (1,2), (1,3), (2,3)]` — where the packed
colouring `16` reads as `0 ↦ 0, 1 ↦ 0, 2 ↦ 1, 3 ↦ 0` and is proper only off pivot 1. -/

-- A row filed against the wrong pivot: the colouring for pivot 1 offered as pivot 0's.
/-- info: "row 0 of 4 is not a colouring of the graph with vertex 0 removed: edge (1, 3) has colour 0 at both ends, and neither end is 0. Re-solve pivot 0." -/
#guard_msgs in
#eval diagnose rhombus 2 2 [16, 16, 16, 16] 4

-- A certificate that stops early. Named as a different repair from a bad row, because it is one.
/-- info: "certificate has 2 rows for a 4-vertex graph: pivots 2–3 were never certified. The emitter stopped early; it is built to refuse rather than write a short file, so this file was not written by it." -/
#guard_msgs in
#eval diagnose rhombus 2 2 [16, 16] 4

-- More rows than vertices: the rows and the pivots are out of step, which is neither of the above.
/-- info: "certificate has 5 rows for a 4-vertex graph: there are more rows than vertices, so the rows and the pivots are out of step." -/
#guard_msgs in
#eval diagnose rhombus 2 2 [16, 16, 16, 16, 16] 4

-- And the case that must render too, or the diagnostic is one that can only say "no": a certificate
-- with nothing wrong with it. `triangleAndPoint` is a triangle plus an isolated point, so pivot 3
-- needs all three colours and the other three pivots need two.
/-- info: "4 rows, every one a proper 3-colouring off its own pivot." -/
#guard_msgs in
#eval diagnose triangleAndPoint 2 3 [16, 16, 4, 36] 4

end HadwigerNelson
