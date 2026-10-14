import Proofs.HadwigerNelson.Arith.TorsionExtraction
open Lean Elab Command in
run_cmd do
  let env ← getEnv
  let n := `HadwigerNelson.TorsionExtraction.exists_zmod_hom_of_mem_torsionBy
  let some ci := env.find? n | throwError "not found"
  IO.println s!"kind thm: {ci matches .thmInfo _}; value?: {ci.value?.isSome}; module idx: {(env.getModuleIdxFor? n).map (·.toNat)}"
  IO.println s!"used in value: {(ci.value?.map (·.getUsedConstants)).getD #[]}"
  let ax ← liftCoreM <| collectAxioms n
  IO.println s!"axioms: {ax}"
