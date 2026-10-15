import Proofs.HadwigerNelson.Arith.FibreCert11Bound
import Proofs.HadwigerNelson.Arith.FibreCert19Bound
/-!
FS131-IKC4 (copied from FS131-IKC3, itself FS131-IKC2's) — the axioms of every public declaration of `Arith/FibreCert`, `Arith/FibreCert3`,
`Arith/FibreCertSound` FS131-IKC3's `Arith/FibreCert11*` modules, and this job's `Arith/FibreCertFast` and sixty-five `Arith/FibreCert19*`
modules, read from the built library: one line `AX <name> : <axioms>` per constant stored in the
modules' compiled data that is neither internal nor private (`Name.isInternalDetail`, `isPrivateName`), and one line
`PRIVATE <name> : <axioms>` per private theorem of `Arith/FibreCertSound` and `Arith/FibreCertFast` (the proofs' helpers). The planted
record `FS131IKC4Axioms.planted` (a `sorry`) must read `sorryAx`: a print that cannot show it is no print.

  lake env lean data/fs131/ikc4/lean/Axioms.lean
-/
open Lean Elab Command

namespace FS131IKC4Axioms

theorem planted : (1 : Nat) = 2 := by sorry

def modules : List Name :=
  [`Proofs.HadwigerNelson.Arith.FibreCert, `Proofs.HadwigerNelson.Arith.FibreCert3,
    `Proofs.HadwigerNelson.Arith.FibreCertSound, `Proofs.HadwigerNelson.Arith.FibreCert11] ++
  ([0, 1, 2, 3, 4, 5, 6, 7].map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert11Seg{k}") ++
  [`Proofs.HadwigerNelson.Arith.FibreCert11Global, `Proofs.HadwigerNelson.Arith.FibreCert11Psd,
    `Proofs.HadwigerNelson.Arith.FibreCert11Bound, `Proofs.HadwigerNelson.Arith.FibreCertFast,
    `Proofs.HadwigerNelson.Arith.FibreCert19] ++
  ((List.range 19).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19B{k}") ++
  [`Proofs.HadwigerNelson.Arith.FibreCert19Q0] ++
  ((List.range 8).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19K{k}") ++
  ((List.range 8).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19P{k + 1}") ++
  ((List.range 4).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19Kt{k}") ++
  ((List.range 8).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19C{k}") ++
  [`Proofs.HadwigerNelson.Arith.FibreCert19Global] ++
  ((List.range 4).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19Seg{k}") ++
  ((List.range 10).map fun k => Name.mkStr `Proofs.HadwigerNelson.Arith s!"FibreCert19Psd{k}") ++
  [`Proofs.HadwigerNelson.Arith.FibreCert19Bound]

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
        if (m == `Proofs.HadwigerNelson.Arith.FibreCertSound || m == `Proofs.HadwigerNelson.Arith.FibreCertFast) && ci matches .thmInfo _ then
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

end FS131IKC4Axioms
