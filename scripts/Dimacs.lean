import Proofs

/-!
# DIMACS emission — the formula the proof will check, handed to the solver

CaDiCaL must be given *the same formula* Lean will later check the certificate against. The only way
to guarantee that is to not write it twice: this script prints DIMACS by calling `Std.Sat.CNF.dimacs`
on `coloringCNF` itself, the very definition `not_colorable_of_unsat` reasons about. Nothing here
re-implements the encoding, and nothing outside Lean ever authors a clause.

Run it through the driver, which also invokes the solver:

```
./tools/solve.sh
```

or by hand with `lake env lean scripts/Dimacs.lean` from the repository root.

## The ordering contract

A cube's certificate is filed by **index**, and the index is a position in `moserSpindleCubes` — the
literal list that `not_colorable_of_cubes` quantifies over. This script and `scripts/EmitLrat.lean`
both walk that same list, so neither can disagree with the other or with the theorem: the enumeration
exists in one place (`allCubes`), is pinned to a literal by one `rfl` (`moserSpindleCubes_eq`), and
is consumed by index everywhere else.

Each file also carries its cube in a DIMACS comment, so a `.cnf` on disk says which obligation it
belongs to without reference to this script.

If a certificate ever does end up on the wrong cube, `#eval badCubes …` (see `Sat/Lrat.lean`) names
the index; this contract is what makes that index meaningful.
-/

open Std.Sat HadwigerNelson

/-- Where the intermediate `.cnf` and `.lrat` files live. Git-ignored: they are reproducible from
this script and are never reviewed by hand — the artifact under review is the certificate that
lands in `Instances/SpindleLrat.lean`, and Lean re-checks that against the formula regardless. -/
def satDir : System.FilePath := "build" / "sat"

/-- One DIMACS file, with a comment line recording what it is. -/
def emitCnf (name : String) (note : String) (f : CNF Nat) : IO Unit := do
  let path := satDir / (name ++ ".cnf")
  IO.FS.writeFile path (s!"c {note}\n" ++ CNF.dimacs f)
  IO.println s!"  {path}  ({f.clauses.size} clauses)  {note}"

/-- The whole emission: the monolithic instance for route B, then one file per cube for route C. -/
def emitAll : IO Unit := do
  IO.FS.createDirAll satDir
  IO.println "Moser spindle, 3 colours — DIMACS from the Lean encoding:"
  emitCnf "spindle" "route B: coloringCNF 3 7 moserSpindleEdges"
    (coloringCNF 3 7 moserSpindleEdges)
  for (cb, i) in moserSpindleCubes.zipIdx do
    emitCnf s!"spindle-cube-{i}" s!"route C: cube {i} of {moserSpindleCubes.length} = {cb}"
      (coloringCNF 3 7 moserSpindleEdges ++ cubeCNF 3 7 cb)

#eval emitAll
