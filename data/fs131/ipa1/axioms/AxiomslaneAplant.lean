import Proofs.HadwigerNelson.Outside.OAI158Basic
import Proofs.HadwigerNelson.Outside.OAI158InvariantMean
import Proofs.HadwigerNelson.Outside.OAI158SmallArcs
import Proofs.HadwigerNelson.Outside.OAI158PhaseEncoding
import Proofs.HadwigerNelson.Outside.OAI158Characters
import Proofs.HadwigerNelson.Outside.OAI158PhaseCollision
import Proofs.HadwigerNelson.Outside.OAI158Multipliers
import Proofs.HadwigerNelson.Outside.OAI158ConditionalSelection
import Proofs.HadwigerNelson.Outside.OAI158FourierTests
import Proofs.HadwigerNelson.Outside.OAI158ConditionalSpectrum
import PlantSorry

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mods : Array Name := #[`Proofs.HadwigerNelson.Outside.OAI158Basic, `Proofs.HadwigerNelson.Outside.OAI158InvariantMean, `Proofs.HadwigerNelson.Outside.OAI158SmallArcs, `Proofs.HadwigerNelson.Outside.OAI158PhaseEncoding, `Proofs.HadwigerNelson.Outside.OAI158Characters, `Proofs.HadwigerNelson.Outside.OAI158PhaseCollision, `Proofs.HadwigerNelson.Outside.OAI158Multipliers, `Proofs.HadwigerNelson.Outside.OAI158ConditionalSelection, `Proofs.HadwigerNelson.Outside.OAI158FourierTests, `Proofs.HadwigerNelson.Outside.OAI158ConditionalSpectrum, `PlantSorry]
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
