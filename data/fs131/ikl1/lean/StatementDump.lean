import Proofs.HadwigerNelson.Rigidity.CountModels
import Proofs.HadwigerNelson.Arith.FibreCert11Bound
/-!
FS131-IKL1 — every constant of the named modules, as the kernel holds it: read-only (FS131-ICM3's dumper, with the
module list read from the environment).

For each constant stored in the compiled data of each module named in `IKL1_DUMP_MODULES` (comma-separated full module
names; `env.header.moduleData`: what the module's own `.olean` holds), prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw: every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  PP <the stored type, pretty-printed with full names>                   (for reading; not compared)

the same format as `data/fs131/icm3/lean/StatementDump.lean`. A module that is not imported is an error, never an empty
dump; an empty module list is an error. Output goes to the file named by `IKL1_DUMP_OUT`.
-/
open Lean Elab Command Meta

namespace FS131IKL1Dump

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def run : CommandElabM Unit := do
  let env ← getEnv
  let some out ← (IO.getEnv "IKL1_DUMP_OUT") | throwError "IKL1_DUMP_OUT is not set"
  let some ms ← (IO.getEnv "IKL1_DUMP_MODULES") | throwError "IKL1_DUMP_MODULES is not set"
  let modules : List Name := (ms.splitOn ",").filter (· ≠ "") |>.map String.toName
  if modules.isEmpty then throwError "IKL1_DUMP_MODULES names no module"
  let h ← IO.FS.Handle.mk out IO.FS.Mode.write
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut total := 0
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := data[i]!
    h.putStrLn s!"## MODULE {m} constants={d.constants.size}"
    total := total + d.constants.size
    for ci in d.constants do
      let n := ci.name
      let flag := if n.isInternalDetail then " INTERNAL" else ""
      h.putStrLn s!"@@ {kindOf ci} {n}{flag}"
      h.putStrLn s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => h.putStrLn s!"VALUE {v.value.hash} {v.value}"
      | _ => pure ()
      let pp ← liftTermElabM do
        withOptions (fun o => o.setBool `pp.fullNames true) do
          return toString (← ppExpr ci.type)
      h.putStrLn s!"PP {pp.replace "\n" " "}"
  h.putStrLn s!"## TOTAL {total}"
  h.flush

#eval run

end FS131IKL1Dump
