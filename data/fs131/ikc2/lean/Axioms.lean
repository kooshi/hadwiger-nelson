import Proofs.HadwigerNelson.Arith.FibreCertSound
/-!
FS131-IKC2 (copied from FS131-IKC1) — the axioms of every public declaration of `Arith/FibreCert`, `Arith/FibreCert3` and
`Arith/FibreCertSound`, read from the built library: one line `AX <name> : <axioms>` per constant stored in the
modules' compiled data that is neither internal nor private (`Name.isInternalDetail`, `isPrivateName`), and one line
`PRIVATE <name> : <axioms>` per private theorem of `Arith/FibreCertSound` (the proof's helpers). The planted
record `FS131IKC2Axioms.planted` (a `sorry`) must read `sorryAx`: a print that cannot show it is no print.

  lake env lean data/fs131/ikc2/lean/Axioms.lean
-/
open Lean Elab Command

namespace FS131IKC2Axioms

theorem planted : (1 : Nat) = 2 := by sorry

def modules : List Name :=
  [`Proofs.HadwigerNelson.Arith.FibreCert, `Proofs.HadwigerNelson.Arith.FibreCert3,
    `Proofs.HadwigerNelson.Arith.FibreCertSound]

def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut n := 0
  for m in modules do
    let some i := mods.findIdx? (· == m) | throwError "module {m} is not imported"
    for ci in data[i]!.constants do
      let nm := ci.name
      if isPrivateName nm then
        if m == `Proofs.HadwigerNelson.Arith.FibreCertSound && ci matches .thmInfo _ then
          let axs ← liftCoreM (Lean.collectAxioms nm)
          IO.println s!"PRIVATE {(privateToUserName? nm).getD nm} : {axs.toList}"
        continue
      if nm.isInternalDetail then continue
      let axs ← liftCoreM (Lean.collectAxioms nm)
      IO.println s!"AX {nm} : {axs.toList}"
      n := n + 1
  let axs ← liftCoreM (Lean.collectAxioms ``planted)
  IO.println s!"PLANTED {``planted} : {axs.toList}"
  IO.println s!"COUNT {n}"

#eval run

end FS131IKC2Axioms
