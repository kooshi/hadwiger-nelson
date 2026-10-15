import Proofs.HadwigerNelson.Plane.WindowDensity
import Proofs.HadwigerNelson.Rigidity.PlaneZhang
import Proofs.HadwigerNelson.Rigidity.CountExtension
/-!
FS131-ICL1 — every constant of this job's three modules, as the kernel holds it: read-only (after FS124-I2's dumper).

For each constant stored in the compiled data of `Plane/WindowDensity`, `Rigidity/PlaneZhang` and `Rigidity/CountExtension`
(`env.header.moduleData`: what the module's own `.olean` holds, whatever the file's text shows), prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw: every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  PP <the stored type, pretty-printed with full names>                   (for reading; not compared)

`INTERNAL` marks a name Lean generates (`Name.isInternalDetail`: `_proof_n`, `match_n`, `eq_1`, private names, …).
A module that is not imported is an error, never an empty dump. Output goes to the file named by `ICL1_DUMP_OUT`.
The reader is `tools/fs131_icl1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131ICL1Dump

def modules : List Name :=
  [`Proofs.HadwigerNelson.Plane.WindowDensity, `Proofs.HadwigerNelson.Rigidity.PlaneZhang,
   `Proofs.HadwigerNelson.Rigidity.CountExtension]

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def run : CommandElabM Unit := do
  let env ← getEnv
  let some out ← (IO.getEnv "ICL1_DUMP_OUT") | throwError "ICL1_DUMP_OUT is not set"
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

end FS131ICL1Dump
