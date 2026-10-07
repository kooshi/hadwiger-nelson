import Proofs
/-!
FS132-L2 — every constant of the landing's modules as the kernel holds it, for the registrations: one line
`L2DECL <THM|DEF|IND|AX|OTHER> <written|aux> <GEN|-> <module> <name>` per constant whose module is one of the landing's
(`Proofs.HadwigerNelson.Plane.SixRing.*`, and `Proofs.HadwigerNelson.Outside.OAI158<Suffix>` with a non-empty suffix —
the import module `Outside.OAI158` itself is `main`'s).  `written`: the constant has a declaration range of its own,
which is what a declaration typed in a source file has and what the elaborator's auxiliaries (`match_1`, `_proof_1`,
`eq_1`, …) have not.  `GEN`: machine-written API of a structure or inductive (constructor, recursor, projection,
`noConfusion`), as `data/fs131/l5/count-modules.lean` marks it.  Internal names are skipped, as the gate's scans skip
them.  Read-only.  Run from a worktree with a built library:  lake env lean data/fs132/l2/decls.lean
-/
open Lean Meta Elab Command

namespace L2Decls

def landingModule (m : Name) : Bool :=
  (`Proofs.HadwigerNelson.Plane.SixRing).isPrefixOf m ||
  (match m with
   | .str p s => p == `Proofs.HadwigerNelson.Outside && s.startsWith "OAI158" && s != "OAI158"
   | _ => false)

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
    lines := lines.push (s!"{m} {n}", s!"L2DECL {kind} {written} {gen} {m} {n}")
  logInfo m!"=== L2 DECLS ==="
  for (m, c) in mods.toArray.qsort (fun a b => a.1.toString < b.1.toString) do
    logInfo m!"L2MODULE {m} constants={c}"
  for (_, l) in lines.qsort (fun a b => a.1 < b.1) do
    logInfo m!"{l}"
  logInfo m!"L2TOTAL modules={mods.size} constants={lines.size}"
  logInfo m!"=== END ==="

end L2Decls

#eval L2Decls.run
