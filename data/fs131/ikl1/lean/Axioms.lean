import Proofs.HadwigerNelson.Rigidity.CertLinkModels
/-! FS131-IKL1 — the axioms of every theorem and definition this job's modules store (`env.header.moduleData`), private
ones included, names Lean generates skipped; one line each:

  AXIOMS <public|private> <module> <name> : [axioms, sorted]

then `AXIOMS-COUNT <n>` and, per module, `MODULE <m> records=<k>`. A module not imported is an error. If the environment
variable `IKL1_AXIOMS_PLANT` names a declaration, `sorryAx` is added to that declaration's printed list (the control: the
reader `tools/fs131_ikl1_axioms.py` must report it). -/
namespace FS131IKL1Axioms
open Lean Elab Command

def modules : List Name :=
  [`Proofs.HadwigerNelson.Arith.FibreShareIneq, `Proofs.HadwigerNelson.Rigidity.CertLink,
   `Proofs.HadwigerNelson.Rigidity.CertLinkModels]

def run : CommandElabM Unit := do
  let env ← getEnv
  let plant := (← IO.getEnv "IKL1_AXIOMS_PLANT").getD ""
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut total := 0
  for m in modules do
    let some i := mods.findIdx? (· == m) | throwError "module {m} is not imported"
    let mut k := 0
    for ci in data[i]!.constants do
      let n := ci.name
      let isDecl := match ci with | .thmInfo _ => true | .defnInfo _ => true | _ => false
      if !isDecl then continue
      let user := (privateToUserName? n).getD n
      if user.isInternalDetail then continue
      let ax ← liftCoreM <| collectAxioms n
      let mut axs := (ax.map toString).qsort (· < ·)
      if user.toString == plant then axs := (axs.push "sorryAx").qsort (· < ·)
      let kind := if (privateToUserName? n).isSome then "private" else "public"
      IO.println s!"AXIOMS {kind} {m} {user} : {axs.toList}"
      k := k + 1
    IO.println s!"MODULE {m} records={k}"
    total := total + k
  IO.println s!"AXIOMS-COUNT {total}"

#eval run

end FS131IKL1Axioms
