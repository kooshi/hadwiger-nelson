
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  for n in [`HadwigerNelson.Outside.OAI158.ContinuousVectors.projection_coefficient,
            `HadwigerNelson.Outside.OAI158.Spectral.orbitExtension_inner] do
    let some ci := env.find? n | throwError "absent"
    IO.println s!"RAW {n} {ci.type}"
