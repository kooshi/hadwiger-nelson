import Proofs
/-! FS131-ISF2: the vacuity scan's `declarations=` and `refutations-skipped=` read for the 52 modules of this landing
(`data/fs131/isf2/modules.txt`). For every constant a module stores whose name is not `isInternal` (the scan's own filter),
print `SCANNED <module> <kind> <name> [RECORD] [REFUTATION]`: RECORD when the audit's printer files it (a public theorem or
definition whose name is not `isInternalDetail`), REFUTATION by the scan's own test (`scripts/Vacuity.lean`'s
`isRefutation`, copied: the reducing telescope ends in `False` and the stated conclusion is not a `¬`/`≠`). Read-only.
Run from the worktree root: lake env lean data/fs131/isf2/lean/ScanCount.lean > data/fs131/isf2/scan-count.txt -/
namespace FS131ISF2ScanCount
open Lean Elab Command Meta

def isNegationConcl (concl : Expr) : Bool := concl.isAppOf ``Not || concl.isAppOf ``Ne

def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let text ← IO.FS.readFile "data/fs131/isf2/modules.txt"
  let modules : List Name := (text.splitOn "\n").filterMap fun s =>
    let t := s.trimAscii.toString
    if t.isEmpty then none else some t.toName
  let mut total := 0
  let mut refs := 0
  for m in modules do
    let some i := mods.findIdx? (· == m) | throwError "module {m} is not imported"
    for ci in data[i]!.constants do
      let n := ci.name
      if n.isInternal then continue
      total := total + 1
      let isDecl := match ci with | .thmInfo _ => true | .defnInfo _ => true | _ => false
      let user := (privateToUserName? n).getD n
      let rec_ := isDecl && (privateToUserName? n).isNone && !user.isInternalDetail
      let r ← liftTermElabM <| (try isRefutation ci.type catch _ => pure false)
      if r then refs := refs + 1
      IO.println s!"SCANNED {m} {kindOf ci} {n}{if rec_ then " RECORD" else ""}{if r then " REFUTATION" else ""}"
  IO.println s!"SCANNED-COUNT {total} REFUTATIONS {refs}"

#eval run

end FS131ISF2ScanCount
