import Proofs.HadwigerNelson.Rigidity.PositiveEntropy

/-! FS131-KN7 (Amendment 1): every constant of the compiled module `Rigidity/PositiveEntropy` — its kind, its name and
its stored type with every implicit and instance argument shown (and a definition's value) — one line per constant,
sorted by name. Run before the repair and after it; `tools/fs131_kn7_dump_diff.py` compares the two prints. -/

set_option pp.explicit true
set_option pp.universes true
set_option pp.fullNames true
set_option pp.proofs true
set_option pp.oneline false

open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let some idx := env.getModuleIdx? `Proofs.HadwigerNelson.Rigidity.PositiveEntropy | throwError "module not found"
  let names := (env.header.moduleData[idx.toNat]!).constNames
  let names := names.qsort (fun a b => a.toString < b.toString)
  logInfo m!"DUMP constants={names.size}"
  for n in names do
    let some ci := env.find? n | throwError "absent {n}"
    let kind := match ci with
      | .axiomInfo _ => "axiom" | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .opaqueInfo _ => "opaque"
      | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec" | .quotInfo _ => "quot"
    let tyS := (← liftTermElabM <| Meta.ppExpr ci.type).pretty 100000
    let valS ← match ci with
      | .defnInfo d => do pure s!" := {(← liftTermElabM <| Meta.ppExpr d.value).pretty 100000}"
      | _ => pure ""
    logInfo m!"DUMP {kind} {n} : {tyS.replace "\n" " "}{valS.replace "\n" " "}"
