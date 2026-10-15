import Proofs.HadwigerNelson.Rigidity.RingScope
import Proofs.HadwigerNelson.Rigidity.TateModel
import Proofs.HadwigerNelson.Rigidity.TateLocal
import Proofs.HadwigerNelson.Rigidity.TateArch
import Proofs.HadwigerNelson.Rigidity.TateCharacter
import Proofs.HadwigerNelson.Rigidity.TateKernel
import Proofs.HadwigerNelson.Rigidity.TateExists
import Proofs.HadwigerNelson.Rigidity.PlaceSizes
import Proofs.HadwigerNelson.Rigidity.Multipliers
import Proofs.HadwigerNelson.Rigidity.ThinBoxes
import Proofs.HadwigerNelson.Rigidity.GlobalPoint
import Proofs.HadwigerNelson.Rigidity.WanderingShells
import Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed
/-!
FS131-ITT1 — every constant of the thirteen modules this job's edits can reach, as the kernel holds it: read-only.
The six this job writes (`Rigidity/RingScope`, `TateModel`, `TateLocal`, `TateArch`, `TateCharacter`, and `ThinBoxes` for
the move of `TateModel.sigmaCompactSpace` out of it) and every module downstream of them (`TateKernel`, `TateExists`,
`PlaceSizes`, `Multipliers`, `GlobalPoint`, `WanderingShells`, `ZeroEntropyClosed`: an import line added upstream could move
an instance their stored terms name).

For each constant stored in a module's compiled data (`env.header.moduleData`: what the module's own `.olean` holds,
whatever the file's text shows) it prints

  @@ <THM|DEF|AXIOM|IND|CTOR|REC|OPAQUE|QUOT> <full name> [INTERNAL|PRIVATE <user name>] [PROPTYPE]
  TYPE <hash> <the stored type, raw: bound variables by index, every constant by its full name>
  VALUE <hash> <the stored value, raw>                                   (definitions only)
  DATA <hash> <the stored value, every subterm that is a proof erased to `True.intro`>
                                                                         (definitions whose type is not a proposition)

under a line `## MODULE <name> constants=<n>` per module. (FS131-IP23's dumper, `data/fs131/ip23/lean/StatementDump.lean`,
aimed at these thirteen modules.) A module that is not imported is an error, never an empty dump. Run from the worktree
against its compiled library, before the first rebuild and after the last:
  lake env lean data/fs131/itt1/lean/StatementDump.lean > data/fs131/itt1/statements-<when>.txt
The reader is `tools/fs131_itt1_statements.py`.
-/
open Lean Elab Command Meta

namespace FS131ITT1Dump

/-- The thirteen modules. -/
def modules : List Name :=
  [`Proofs.HadwigerNelson.Rigidity.RingScope,
   `Proofs.HadwigerNelson.Rigidity.TateModel,
   `Proofs.HadwigerNelson.Rigidity.TateLocal,
   `Proofs.HadwigerNelson.Rigidity.TateArch,
   `Proofs.HadwigerNelson.Rigidity.TateCharacter,
   `Proofs.HadwigerNelson.Rigidity.TateKernel,
   `Proofs.HadwigerNelson.Rigidity.TateExists,
   `Proofs.HadwigerNelson.Rigidity.PlaceSizes,
   `Proofs.HadwigerNelson.Rigidity.Multipliers,
   `Proofs.HadwigerNelson.Rigidity.ThinBoxes,
   `Proofs.HadwigerNelson.Rigidity.GlobalPoint,
   `Proofs.HadwigerNelson.Rigidity.WanderingShells,
   `Proofs.HadwigerNelson.Rigidity.ZeroEntropyClosed]

/-- The kind of a constant, as the kernel classes it. -/
def kindOf : ConstantInfo → String
  | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | .opaqueInfo _ => "OPAQUE"
  | .inductInfo _ => "IND" | .ctorInfo _ => "CTOR" | .recInfo _ => "REC" | .quotInfo _ => "QUOT"

/-- A definition's value with every subterm that is a proof erased to `True.intro` (see the module docstring). -/
def eraseProofArgs (v : Expr) : MetaM Expr :=
  Meta.transform v (pre := fun e => do
    if e.isSort || e.isConst then return .continue
    if ← (try isProof e catch _ => pure false) then return .done (mkConst ``True.intro) else return .continue)

/-- Print the stored constants of the modules. Reads the environment; writes nothing to it. -/
def run : CommandElabM Unit := do
  let env ← getEnv
  let mods := env.header.moduleNames
  let data := env.header.moduleData
  for m in modules do
    let some i := mods.findIdx? (· == m)
      | throwError "module {m} is not imported: nothing to dump"
    let d := data[i]!
    IO.println s!"## MODULE {m} constants={d.constants.size}"
    for ci in d.constants do
      let n := ci.name
      let flag := match privateToUserName? n with
        | some u => if u.isInternalDetail then " INTERNAL" else s!" PRIVATE {u}"
        | none => if n.isInternalDetail then " INTERNAL" else ""
      let isP ← liftTermElabM <| isProp ci.type
      let pflag := if isP then " PROPTYPE" else ""
      IO.println s!"@@ {kindOf ci} {n}{flag}{pflag}"
      IO.println s!"TYPE {ci.type.hash} {ci.type}"
      match ci with
      | .defnInfo v =>
        IO.println s!"VALUE {v.value.hash} {v.value}"
        unless isP do
          let e ← liftTermElabM <| eraseProofArgs v.value
          IO.println s!"DATA {e.hash} {e}"
      | _ => pure ()

#eval run

end FS131ITT1Dump
