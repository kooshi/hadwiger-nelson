import Proofs
/-!
FS124-L1 — every constant of the landing's three modules as the kernel holds it, for the registrations (after
`data/fs132/l2/decls.lean`, FS132-L2's, whose two predicates are copied): one line
`L1DECL <THM|DEF|IND|AX|OTHER> <written|aux> <GEN|-> <module> <name>` per constant whose module is
`Proofs.HadwigerNelson.Plane.WeakColouringOn`, `…Plane.Radius` or `…Plane.RadiusOutside`.  `written`: the constant has
a declaration range of its own, which is what a declaration typed in a source file has and what the elaborator's
auxiliaries (`match_1`, `_proof_1`, `eq_1`, …) have not.  `GEN`: machine-written API of a structure or inductive
(constructor, recursor, projection, `noConfusion`).  Internal names are skipped, as the gate's scans skip them.
Read-only.  Run from a worktree with a built library:  lake env lean data/fs124/l1/decls.lean
-/
open Lean Meta Elab Command

namespace L1Decls

def landingModule (m : Name) : Bool :=
  m == `Proofs.HadwigerNelson.Plane.WeakColouringOn || m == `Proofs.HadwigerNelson.Plane.Radius ||
  m == `Proofs.HadwigerNelson.Plane.RadiusOutside

def isGeneratedDecl (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome ||
  (match n with | .str _ s => s == "ctorIdx" || s == "noConfusionType" | _ => false)

def run : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let mut lines : Array (String × String) := #[]
  let mut mods : Std.HashMap Name Nat := {}
  for (n, ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    if !landingModule m then continue
    mods := mods.insert m (mods.getD m 0 + 1)
    let kind := match ci with
      | .thmInfo _ => "THM" | .defnInfo _ => "DEF" | .inductInfo _ => "IND" | .axiomInfo _ => "AX" | _ => "OTHER"
    let written := if (← findDeclarationRanges? n).isSome then "written" else "aux"
    let gen := if isGeneratedDecl env n ci then "GEN" else "-"
    lines := lines.push (s!"{m} {n}", s!"L1DECL {kind} {written} {gen} {m} {n}")
  logInfo m!"=== L1 DECLS ==="
  for (m, c) in mods.toArray.qsort (fun a b => a.1.toString < b.1.toString) do
    logInfo m!"L1MODULE {m} constants={c}"
  for (_, l) in lines.qsort (fun a b => a.1 < b.1) do
    logInfo m!"{l}"
  logInfo m!"L1TOTAL modules={mods.size} constants={lines.size}"
  logInfo m!"=== END ==="

end L1Decls

#eval L1Decls.run
