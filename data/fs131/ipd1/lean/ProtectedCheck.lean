import Proofs
/-!
FS131-IPD1, the protected-declaration check of plans/FS131-KO1-port-plan.md § 4.3: every constant of the port's 31
generated modules that a stored term of a module of ours names — every constant of every non-generated module
downstream of the port (its stored type, and a definition's or theorem's stored value), read from the compiled
library. One line per (constant of ours, ported constant named, where: type | value).
-/
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let gen : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI158AlgebraModels, `Proofs.HadwigerNelson.Outside.OAI158Amenability, `Proofs.HadwigerNelson.Outside.OAI158Approximation, `Proofs.HadwigerNelson.Outside.OAI158Basic, `Proofs.HadwigerNelson.Outside.OAI158BorelTransfer, `Proofs.HadwigerNelson.Outside.OAI158BoundedFunctions, `Proofs.HadwigerNelson.Outside.OAI158Centers, `Proofs.HadwigerNelson.Outside.OAI158Characters, `Proofs.HadwigerNelson.Outside.OAI158ConditionalLimits, `Proofs.HadwigerNelson.Outside.OAI158ConditionalSelection, `Proofs.HadwigerNelson.Outside.OAI158ConditionalSpectrum, `Proofs.HadwigerNelson.Outside.OAI158Energy, `Proofs.HadwigerNelson.Outside.OAI158Ergodicity, `Proofs.HadwigerNelson.Outside.OAI158Factors, `Proofs.HadwigerNelson.Outside.OAI158FourierTests, `Proofs.HadwigerNelson.Outside.OAI158Functions, `Proofs.HadwigerNelson.Outside.OAI158InvariantMean, `Proofs.HadwigerNelson.Outside.OAI158Kernels, `Proofs.HadwigerNelson.Outside.OAI158Multipliers, `Proofs.HadwigerNelson.Outside.OAI158NumberFields, `Proofs.HadwigerNelson.Outside.OAI158PhaseCollision, `Proofs.HadwigerNelson.Outside.OAI158PhaseEncoding, `Proofs.HadwigerNelson.Outside.OAI158RadialEnergy, `Proofs.HadwigerNelson.Outside.OAI158RelativeCenters, `Proofs.HadwigerNelson.Outside.OAI158RelativeProducts, `Proofs.HadwigerNelson.Outside.OAI158Representations, `Proofs.HadwigerNelson.Outside.OAI158Selections, `Proofs.HadwigerNelson.Outside.OAI158Separability, `Proofs.HadwigerNelson.Outside.OAI158SmallArcs, `Proofs.HadwigerNelson.Outside.OAI158SpectralMeasure, `Proofs.HadwigerNelson.Outside.OAI158Stationary]
  let ours : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI158Collapse, `Proofs.HadwigerNelson.Plane.LebesgueNumber, `Proofs.HadwigerNelson.Plane.RadiusOutside]
  let mods := env.header.moduleNames
  let modOf (c : Name) : Option Name := (env.getModuleIdxFor? c).map fun i => mods[i.toNat]!
  let mut n := 0
  for m in ours do
    let some i := mods.findIdx? (· == m) | throwError "{m} is not imported"
    for ci in env.header.moduleData[i]!.constants do
      let tys := ci.type.getUsedConstants
      let vals := match ci with
        | .defnInfo d => d.value.getUsedConstants
        | .thmInfo t => t.value.getUsedConstants
        | _ => #[]
      for (wh, cs) in [("type", tys), ("value", vals)] do
        for c in cs.qsort Name.lt |>.toList.eraseDups do
          if let some mc := modOf c then
            if gen.contains mc then
              IO.println s!"NAMES {m} {ci.name} {wh} {c} @ {mc}"
              n := n + 1
  IO.println s!"SUMMARY modules={ours.size} lines={n}"
