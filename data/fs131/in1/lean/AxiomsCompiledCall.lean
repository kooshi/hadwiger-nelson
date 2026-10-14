open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let m := `Proofs.HadwigerNelson.Arith.ThreeColourCriterion
  let some i := env.header.moduleNames.findIdx? (· == m) | throwError "module {m} is not imported"
  FS131IN1Axioms.run (env.header.moduleData[i]!.constants.map (·.name))
