import OAI.Geometry.PlaneColoring.BorelTransfer
-- FS133-IA1: the one cone constant that is a generated auxiliary of a declaration that is not ported, as the
-- release's kernel stores it (run at the release's pin).  (A first version called `ConstantInfo.value!`, which
-- panics on a theorem at v4.34.1 and aborted the run under LEAN_ABORT_ON_PANIC; the value is read by cases here.)
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let n := `OAI.PlaneFiveColor.LabelModel.projected._proof_1
  let some ci := env.find? n | throwError "absent: {n}"
  match ci with
  | .thmInfo v =>
    IO.println s!"AUX {n} : theorem levels={v.levelParams}"
    IO.println s!"AUX   type  = {v.type}"
    IO.println s!"AUX   value = {v.value}"
  | .defnInfo v =>
    IO.println s!"AUX {n} : def"
    IO.println s!"AUX   type  = {v.type}"
    IO.println s!"AUX   value = {v.value}"
  | _ => IO.println s!"AUX {n} : other  type = {ci.type}"
#print axioms OAI.PlaneFiveColor.LabelModel.projected._proof_1
