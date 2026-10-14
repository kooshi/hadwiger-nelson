import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
-- FS133-IB2: every constant stored in the compiled data of `Defs` and `InvariantLaw`, by name (generated ones
-- included), so that a constant generated in a module for a declaration of another module (`f.eq_1` of an
-- upstream `f`, `LEAN.md` § Searching — Lean, FS131-IC1) is seen.
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods := env.header.moduleNames
  for m in [`Proofs.HadwigerNelson.Plane.OneClass.Defs, `Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw] do
    let some i := mods.findIdx? (· == m) | throwError "module {m} is not imported"
    let d := env.header.moduleData[i]!
    IO.println s!"## MODULE {m} {d.constants.size}"
    for n in (d.constants.map (·.name)).qsort Name.lt do
      IO.println s!"CONST {n}"
