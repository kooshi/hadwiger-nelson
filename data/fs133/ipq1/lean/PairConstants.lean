import Proofs.HadwigerNelson.Plane.OneClass.Pair
/-! FS133-IPQ1 — every constant compiled into `Plane/OneClass/Pair`'s `.olean`, by name (generated ones included):
the check for a constant under no declaration of the file (a `f.eq_1` or `congr_simp` made on demand). -/
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let some i := env.header.moduleNames.findIdx? (· == `Proofs.HadwigerNelson.Plane.OneClass.Pair)
    | throwError "Pair not imported"
  let names := (env.header.moduleData[i]!.constants.map (·.name)).qsort Name.lt
  for n in names do IO.println s!"CONST {n}"
  IO.println s!"DONE {names.size}"
