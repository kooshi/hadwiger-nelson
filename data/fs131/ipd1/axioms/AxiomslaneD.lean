import Proofs.HadwigerNelson.Outside.OAI158Representations
import Proofs.HadwigerNelson.Outside.OAI158Energy
import Proofs.HadwigerNelson.Outside.OAI158SpectralMeasure
import Proofs.HadwigerNelson.Outside.OAI158RadialEnergy
import Proofs.HadwigerNelson.Outside.OAI158Ergodicity
import Proofs.HadwigerNelson.Outside.OAI158BorelTransfer
import Proofs.HadwigerNelson.Outside.OAI158Collapse

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI158Representations, `Proofs.HadwigerNelson.Outside.OAI158Energy, `Proofs.HadwigerNelson.Outside.OAI158SpectralMeasure, `Proofs.HadwigerNelson.Outside.OAI158RadialEnergy, `Proofs.HadwigerNelson.Outside.OAI158Ergodicity, `Proofs.HadwigerNelson.Outside.OAI158BorelTransfer, `Proofs.HadwigerNelson.Outside.OAI158Collapse]
  let std : Array Name := #[``propext, ``Classical.choice, ``Quot.sound]
  let mut n := 0
  let mut clean := 0
  let mut bad := 0
  for (c, _) in env.constants.map₁.toList do
    let some idx := env.getModuleIdxFor? c | continue
    let m := env.header.moduleNames[idx.toNat]!
    unless mods.contains m do continue
    let axs ← liftCoreM (collectAxioms c)
    n := n + 1
    if axs.all (std.contains ·) then clean := clean + 1
    else
      bad := bad + 1
      IO.println s!"NOTCLEAN {m} {c} {axs}"
  IO.println s!"SUMMARY constants={n} clean={clean} other={bad}"
