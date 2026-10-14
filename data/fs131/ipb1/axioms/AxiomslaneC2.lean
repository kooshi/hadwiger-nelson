import Proofs.HadwigerNelson.Outside.OAI158Factors
import Proofs.HadwigerNelson.Outside.OAI158RelativeProducts
import Proofs.HadwigerNelson.Outside.OAI158Separability
import Proofs.HadwigerNelson.Outside.OAI158Stationary
import Proofs.HadwigerNelson.Outside.OAI158AlgebraModels

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI158Factors, `Proofs.HadwigerNelson.Outside.OAI158RelativeProducts, `Proofs.HadwigerNelson.Outside.OAI158Separability, `Proofs.HadwigerNelson.Outside.OAI158Stationary, `Proofs.HadwigerNelson.Outside.OAI158AlgebraModels]
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
