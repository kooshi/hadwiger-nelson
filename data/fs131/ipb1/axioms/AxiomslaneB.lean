import Proofs.HadwigerNelson.Outside.OAI158Amenability
import Proofs.HadwigerNelson.Outside.OAI158NumberFields
import Proofs.HadwigerNelson.Outside.OAI158Selections
import Proofs.HadwigerNelson.Outside.OAI158Centers
import Proofs.HadwigerNelson.Outside.OAI158RelativeCenters

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI158Amenability, `Proofs.HadwigerNelson.Outside.OAI158NumberFields, `Proofs.HadwigerNelson.Outside.OAI158Selections, `Proofs.HadwigerNelson.Outside.OAI158Centers, `Proofs.HadwigerNelson.Outside.OAI158RelativeCenters]
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
