import Proofs.HadwigerNelson.Outside.OAI158Transfer
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  match env.find? `HadwigerNelson.Outside.OAI158.Koopman.isometry._proof_1 with
  | some ci => IO.println s!"AUX HadwigerNelson.Outside.OAI158.Koopman.isometry._proof_1 : {ci.type}"
  | none => IO.println "AUX HadwigerNelson.Outside.OAI158.Koopman.isometry._proof_1 : ABSENT"
  match env.find? `HadwigerNelson.Outside.OAI158.Koopman.isometry._proof_2 with
  | some ci => IO.println s!"AUX HadwigerNelson.Outside.OAI158.Koopman.isometry._proof_2 : {ci.type}"
  | none => IO.println "AUX HadwigerNelson.Outside.OAI158.Koopman.isometry._proof_2 : ABSENT"
