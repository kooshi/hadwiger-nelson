import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
/-! FS131-IN1L — which stored constants of `Rigidity/ZeroEntropyNames` use `badStarts.congr_simp` (read-only). -/
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let some i := env.header.moduleNames.findIdx? (· == `Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames)
    | throwError "not imported"
  for ci in env.header.moduleData[i]!.constants do
    let val : Option Expr := match ci with
      | .thmInfo v => some v.value | .defnInfo v => some v.value | _ => none
    let used := ci.type.getUsedConstants ++ (val.map (·.getUsedConstants)).getD #[]
    if used.contains `HadwigerNelson.Rigidity.badStarts.congr_simp then
      IO.println s!"USES {ci.name}"
  IO.println "DONE"
