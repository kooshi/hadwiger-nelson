import Proofs.HadwigerNelson.Plane.DensityBound.Theorem
/-!
FS131-LDB1 — does the audit's block for the density bound cover every public constant of its 83 modules?

Reads the block's record names from `data/fs131/ldb1/axioms-block.txt` (every `#print axioms <name>` line; run from the
worktree's root), and from the modules' own compiled data every constant of the 83 modules (`Plane/DensityBound/*`,
`Cells/*`, `Plane/OneAvoidingDensity`). From the records it follows every constant their stored types and values name —
internal ones included (private helpers, `_proof_n`, `match_n`), only within the 83 modules — and prints:

  MODULES <n>            the modules read (must be 83)
  CONSTANTS <n> PUBLIC <p>   all constants of those modules, and the ones that are not internal names
  RECORDS <r> ABSENT <a>     the block's records, and those that are no constant of the 83 modules
  ABSENT <name>          one line per absent record
  REACHED <n>            public constants that are not records and are named, directly or through others, by one
  UNREACHED <kind> <name>    one line per public constant that is neither a record nor reached: its axioms are audited
                         by no record
  PLANT-UNREACHED <kind> <name>  the same rule run with FS131-IDB3's 418 records taken out of the list (the names of
                         `data/fs131/idb3/audit-block.txt`): each of them must appear here, since nothing of
                         FS131-IDB1's or FS131-IDB2's modules names lane X's (the coverage's negative control)

`collectAxioms` is transitive, so a constant reached from a record has its axioms inside that record's printed list.
Reader: `tools/fs131_ldb1_records.py --coverage`.
-/
open Lean Elab Command

namespace FS131LDB1Coverage

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def wanted (m : Name) : Bool :=
  (`Proofs.HadwigerNelson.Plane.DensityBound).isPrefixOf m || m == `Proofs.HadwigerNelson.Plane.OneAvoidingDensity

def used (ci : ConstantInfo) : Array Name :=
  let fromType := ci.type.getUsedConstants
  let fromRest : Array Name := match ci with
    | .thmInfo v => v.value.getUsedConstants
    | .defnInfo v => v.value.getUsedConstants
    | .opaqueInfo v => v.value.getUsedConstants
    | .inductInfo v => v.ctors.toArray
    | .ctorInfo v => #[v.induct]
    | .recInfo v => v.all.toArray
    | _ => #[]
  fromType ++ fromRest

/-- Every constant of the 83 modules reached from `roots` (the roots included). -/
def reach (env : Environment) (mine : NameSet) (roots : Array Name) : NameSet := Id.run do
  let mut seen : NameSet := {}
  let mut stack := roots
  while h : stack.size > 0 do
    let n := stack.back
    stack := stack.pop
    if seen.contains n then continue
    seen := seen.insert n
    if let some ci := env.find? n then
      for m in used ci do
        if mine.contains m && !seen.contains m then stack := stack.push m
  return seen

def run : CommandElabM Unit := do
  let env ← getEnv
  let text ← IO.FS.readFile "data/fs131/ldb1/axioms-block.txt"
  let records : Array Name := (text.splitOn "\n").toArray.filterMap fun ln =>
    if ln.startsWith "#print axioms " then some ((ln.drop 14).trimAscii.toString.toName) else none
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut mine : NameSet := {}
  let mut pub : Array (Name × String) := #[]
  let mut nmods := 0
  let mut nconst := 0
  for i in [0:mods.size] do
    unless wanted mods[i]! do continue
    nmods := nmods + 1
    for ci in data[i]!.constants do
      nconst := nconst + 1
      mine := mine.insert ci.name
      unless ci.name.isInternalDetail do pub := pub.push (ci.name, kindOf ci)
  IO.println s!"MODULES {nmods}"
  IO.println s!"CONSTANTS {nconst} PUBLIC {pub.size}"
  let absent := records.filter (fun r => !mine.contains r)
  IO.println s!"RECORDS {records.size} ABSENT {absent.size}"
  for r in absent do IO.println s!"ABSENT {r}"
  let recSet : NameSet := records.foldl (fun s r => s.insert r) {}
  let seen := reach env mine records
  let mut nreached := 0
  for (n, k) in pub do
    if recSet.contains n then continue
    if seen.contains n then nreached := nreached + 1
    else IO.println s!"UNREACHED {k} {n}"
  IO.println s!"REACHED {nreached}"
  -- The control: the same rule with lane X's records taken out.
  let laneX ← IO.FS.readFile "data/fs131/idb3/audit-block.txt"
  let laneXSet : NameSet := (laneX.splitOn "\n").foldl
    (fun s ln => if ln.trimAscii.isEmpty then s else s.insert ln.trimAscii.toString.toName) {}
  IO.println s!"CONTROL-REMOVED {laneXSet.size}"
  let planted := records.filter (fun r => !laneXSet.contains r)
  let pSet : NameSet := planted.foldl (fun s r => s.insert r) {}
  let pSeen := reach env mine planted
  for (n, k) in pub do
    unless pSet.contains n || pSeen.contains n do IO.println s!"PLANT-UNREACHED {k} {n}"
  IO.println "END"

#eval run

end FS131LDB1Coverage
