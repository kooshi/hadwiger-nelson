import Proofs
/-!
FS131-LGT1 — does the audit cover every public constant of the 148 modules the five-colour chain's landing brings or
changes? FS131-LDB1's `Coverage.lean`, its module set read from `data/fs131/lgt1/modules.txt` and its records from every
`#print axioms <name>` line of `scripts/Axioms.lean` (run from the worktree's root). From the records it follows every
constant their stored types and values name — internal ones included — only within the 148 modules, and prints:

  MODULES <n>            the modules read (must be 148)
  CONSTANTS <n> PUBLIC <p>   all constants of those modules, and the ones that are not internal names
  RECORDS <r> ABSENT <a>     the audit's records that are constants of the 148 modules, and those of the block
                         `-- FS131-LGT1` that are no constant of them
  REACHED <n>            public constants that are not records and are named, directly or through others, by one
  UNREACHED <kind> <name>    a public constant that is neither a record nor reached
  PLANT-UNREACHED <kind> <name>  the same rule with the records of the two leaf modules `Rigidity/CertLinkModels` and
                         `Instances/SqrtClassValues` taken out (no module imports either): every public constant of
                         those two modules must appear here (the control; `tools/fs131_lgt1_records.py` checks it)
-/
open Lean Elab Command

namespace FS131LGT1Coverage

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

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
  let mtext ← IO.FS.readFile "data/fs131/lgt1/modules.txt"
  let wantedSet : NameSet := (mtext.splitOn "\n").foldl
    (fun s ln => if ln.trimAscii.isEmpty then s else s.insert ln.trimAscii.toString.toName) {}
  let text ← IO.FS.readFile "scripts/Axioms.lean"
  let allRecords : Array Name := (text.splitOn "\n").toArray.filterMap fun ln =>
    if ln.startsWith "#print axioms " then some ((ln.drop 14).trimAscii.toString.toName) else none
  let blockText := ((text.splitOn "-- FS131-LGT1 block end").head!.splitOn "/-! ## FS131-LGT1").getLast!
  let blockRecs : Array Name := (blockText.splitOn "\n").toArray.filterMap fun ln =>
    if ln.startsWith "#print axioms " then some ((ln.drop 14).trimAscii.toString.toName) else none
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut mine : NameSet := {}
  let mut pub : Array (Name × String) := #[]
  let mut nmods := 0
  let mut nconst := 0
  for i in [0:mods.size] do
    unless wantedSet.contains mods[i]! do continue
    nmods := nmods + 1
    for ci in data[i]!.constants do
      nconst := nconst + 1
      mine := mine.insert ci.name
      unless ci.name.isInternalDetail do pub := pub.push (ci.name, kindOf ci)
  IO.println s!"MODULES {nmods}"
  IO.println s!"CONSTANTS {nconst} PUBLIC {pub.size}"
  let records := allRecords.filter (fun r => mine.contains r)
  let absent := blockRecs.filter (fun r => !mine.contains r)
  IO.println s!"RECORDS {records.size} ABSENT {absent.size} BLOCK {blockRecs.size}"
  for r in absent do IO.println s!"ABSENT {r}"
  let recSet : NameSet := records.foldl (fun s r => s.insert r) {}
  let seen := reach env mine records
  let mut nreached := 0
  for (n, k) in pub do
    if recSet.contains n then continue
    if seen.contains n then nreached := nreached + 1
    else IO.println s!"UNREACHED {k} {n}"
  IO.println s!"REACHED {nreached}"
  -- The control: the same rule with the two leaf modules' records taken out.
  let leafMods : List Name := [`Proofs.HadwigerNelson.Rigidity.CertLinkModels, `Proofs.HadwigerNelson.Instances.SqrtClassValues]
  let mut leaf : NameSet := {}
  for i in [0:mods.size] do
    unless leafMods.contains mods[i]! do continue
    for ci in data[i]!.constants do leaf := leaf.insert ci.name
  IO.println s!"CONTROL-REMOVED {(records.filter (fun r => leaf.contains r)).size}"
  let planted := records.filter (fun r => !leaf.contains r)
  let pSet : NameSet := planted.foldl (fun s r => s.insert r) {}
  let pSeen := reach env mine planted
  for (n, k) in pub do
    unless pSet.contains n || pSeen.contains n do IO.println s!"PLANT-UNREACHED {k} {n}"
  IO.println "END"

#eval run

end FS131LGT1Coverage
