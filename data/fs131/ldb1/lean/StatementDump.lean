import Proofs.HadwigerNelson.Plane.DensityBound.Theorem
/-!
FS131-LDB1 (FS131-IDB3's dumper, the import and the module count changed, and a by-name section for the constant the ruling moved) — every constant of every module of the density bound (`Plane/DensityBound/*`, `Cells/*`,
`Plane/OneAvoidingDensity`) as the kernel holds it, read from the modules' own compiled data (after FS131-IDB2's dump; the
value is printed by hash only, the cell literals being megabytes):

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL]
  TYPE <hash> <the stored type>
  VALUE <hash>                         (definitions only)

Every module under `Proofs.HadwigerNelson.Plane.DensityBound` that the environment holds is dumped, with
`Plane.OneAvoidingDensity`; fewer than 56 such modules (4 Bessel modules, `Cells/Data`, 46 parts, `Cells/Covering`, `Autocorr`, `Pattern`, `Window`, `Plane/OneAvoidingDensity`) is an error, never a short dump. Reader:
`tools/fs131_idb3_statement_diff.py`.
-/
open Lean Elab Command

namespace FS131LDB1Dump

def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

def wanted (m : Name) : Bool :=
  (`Proofs.HadwigerNelson.Plane.DensityBound).isPrefixOf m || m == `Proofs.HadwigerNelson.Plane.OneAvoidingDensity

def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  let mut count : Nat := 0
  for i in [0:mods.size] do
    let m := mods[i]!
    unless wanted m do continue
    count := count + 1
    let d := data[i]!
    IO.println s!"## MODULE {m} constants={d.constants.size}"
    for ci in d.constants do
      let n := ci.name
      let flag := if n.isInternalDetail then " INTERNAL" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash}"
      | _ => pure ()
  IO.println s!"## MODULES {count}"
  if count != 83 then throwError "{count} modules of the density bound are imported, not 83"
  -- By name, wherever it is declared: the constant the coordinator's ruling moved (the brief's Amendment, 2026-10-14):
  -- this line's `def mOne` deleted, `main`'s (`Plane/OneClass/Defs`) read in its place.
  for n in [`HadwigerNelson.Plane.mOne] do
    match env.find? n with
    | none => IO.println s!"## BYNAME {n} ABSENT"
    | some ci =>
      let m := (env.getModuleIdxFor? n).map (mods[·]!)
      IO.println s!"## BYNAME {n} module={m.getD `none} kind={kindOf ci}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v => IO.println s!"VALUE {v.value.hash}"
      | _ => pure ()

#eval run

end FS131LDB1Dump
