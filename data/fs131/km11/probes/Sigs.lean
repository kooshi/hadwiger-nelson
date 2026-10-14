import Proofs.HadwigerNelson.Rigidity.APlus
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods := [`Proofs.HadwigerNelson.Rigidity.SpectralSubspace, `Proofs.HadwigerNelson.Rigidity.TraceSplit,
    `Proofs.HadwigerNelson.Rigidity.APlus]
  let mut out : Array (String × String) := #[]
  for (n, ci) in env.constants.map₁.toList do
    if let some idx := env.getModuleIdxFor? n then
      let m := env.header.moduleNames[idx.toNat]!
      if mods.contains m && !n.isInternalDetail then
        let kind := match ci with
          | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom" | _ => "other"
        let ty ← liftTermElabM <| Meta.ppExpr ci.type
        out := out.push (s!"{m.getString!} {kind} {n}", s!"{ty}")
  for (h, t) in out.qsort (fun a b => a.1 < b.1) do
    IO.println s!"{h} :\n  {t}"
#print axioms HadwigerNelson.Rigidity.aPlusOfR88
#print axioms HadwigerNelson.Rigidity.aplus_model
#print axioms HadwigerNelson.Rigidity.spectral_contChars_null_of_orthogonal
#print axioms HadwigerNelson.Rigidity.IsSpectralMeasureOf.unique
#print axioms HadwigerNelson.Rigidity.three_mul_tetra_add_one
