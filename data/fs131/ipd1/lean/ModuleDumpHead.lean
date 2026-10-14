/-!
FS131-IPD1 — every constant stored in each named module's own compiled data (`env.header.moduleData`), as the kernel
holds it, for "no stored term moved" (after FS124-L2's `data/fs124/l2/StatementDump.lean`, whose line format it keeps,
with every value given by its hash):

  ## MODULE <module> constants=<n>
  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type, raw>
  VALUE <hash>                         (definitions, theorems, opaques: the stored value's hash)
  LEVELS <the universe parameters>

A module that is not imported is an error, never an empty dump.  The imports and the `#eval` line are appended by
`data/fs131/ipd1/dump-modules.sh`.
-/
open Lean Elab Command

namespace FS131IPD1Dump

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def run (modules : List Name) : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut total := 0
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := data[i]!
    IO.println s!"## MODULE {m} constants={d.constants.size}"
    total := total + d.constants.size
    for ci in d.constants do
      let n := ci.name
      let flag := if n.isInternalDetail then " INTERNAL" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      IO.println s!"LEVELS {ci.levelParams}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash}"
      | .thmInfo v => IO.println s!"VALUE {v.value.hash}"
      | .opaqueInfo v => IO.println s!"VALUE {v.value.hash}"
      | _ => pure ()
  IO.println s!"## SUMMARY modules={modules.length} constants={total}"

end FS131IPD1Dump
