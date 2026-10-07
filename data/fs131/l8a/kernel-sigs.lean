import Proofs
/-!
FS131-L8A — every theorem of the twelve modules this landing brings (the eleven of `Plane/RingCalculus/` and wave 7's foundation
`Plane/SimpleOn`), as the kernel holds it (the brief's step 5;
inventory item 556: a section `variable` enters a theorem only if its statement mentions it, so a file's reader can see a
hypothesis the kernel's statement lacks). FS131-L10B's `data/fs131/l10b/kernel-sigs.lean` with the module list replaced and no
extra head; the printer below is that file's, unchanged. The reader is `tools/fs131_l10b_kernelsig.py`.

For every theorem and axiom of the modules in `waveModules` (hand-written or not: the reader filters) prints

  @@ <THM|AXIOM|DEF|OTHER> <module> <full name>
  SIG <the signature as `#check` prints it, on one line>
  BINDER <explicit|implicit|strict|inst> <prop|data> <binder name> : <its type, on one line>     (one per `∀` of the stored type)
  CONCL <what is left after every `∀`, on one line>

from the constant's stored type — the statement the kernel checked, whatever the file's text shows. Read-only.
Run from the worktree with a built library:  lake env lean data/fs131/l8a/kernel-sigs.lean > data/fs131/l8a/kernel-sigs.out
-/
open Lean Meta Elab Command

namespace L10BSig

def waveModules : List Name := [
  `Proofs.HadwigerNelson.Plane.RingCalculus.Basic,
  `Proofs.HadwigerNelson.Plane.RingCalculus.Star,
  `Proofs.HadwigerNelson.Plane.RingCalculus.Empty,
  `Proofs.HadwigerNelson.Plane.RingCalculus.HubCount,
  `Proofs.HadwigerNelson.Plane.RingCalculus.TilesAt,
  `Proofs.HadwigerNelson.Plane.RingCalculus.SoleTip,
  `Proofs.HadwigerNelson.Plane.RingCalculus.RingColour,
  `Proofs.HadwigerNelson.Plane.RingCalculus.StarChart,
  `Proofs.HadwigerNelson.Plane.RingCalculus.SemiHub,
  `Proofs.HadwigerNelson.Plane.RingCalculus.SemiHubPlaces,
  `Proofs.HadwigerNelson.Plane.RingCalculus.OuterAdj,
  `Proofs.HadwigerNelson.Plane.SimpleOn]

/-- No head outside the twelve modules: the line changed no module that `main` holds. -/
def extraHeads : List Name := []

def oneLine (f : Format) : String :=
  let s := f.pretty 1000000
  String.intercalate " " ((s.splitOn "\n").map String.trim)

def show1 (m : Name) (n : Name) : MetaM Unit := do
  let ci ← getConstInfo n
  let kind := match ci with
    | .thmInfo _ => "THM" | .axiomInfo _ => "AXIOM" | .defnInfo _ => "DEF" | _ => "OTHER"
  IO.println s!"@@ {kind} {m} {n}"
  let sig ← PrettyPrinter.ppSignature n
  IO.println s!"SIG {oneLine sig.fmt}"
  forallTelescope ci.type fun xs concl => do
    for x in xs do
      let d ← x.fvarId!.getDecl
      let t ← inferType x
      let isP ← isProp t
      let bi := match d.binderInfo with
        | .default => "explicit" | .implicit => "implicit" | .strictImplicit => "strict" | .instImplicit => "inst"
      IO.println s!"BINDER {bi} {if isP then "prop" else "data"} {d.userName} : {oneLine (← ppExpr t)}"
    IO.println s!"CONCL {oneLine (← ppExpr concl)}"

def run : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let mut rows : Array (Name × Name) := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal then continue
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    unless waveModules.contains m do continue
    match ci with
    | .thmInfo _ | .axiomInfo _ => rows := rows.push (m, n)
    | _ => pure ()
  IO.println "=== L10B KERNEL SIGNATURES ==="
  for (m, n) in rows.qsort (fun a b => a.1.toString < b.1.toString || (a.1 == b.1 && a.2.toString < b.2.toString)) do
    show1 m n
  for n in extraHeads do
    let some idx := env.getModuleIdxFor? n | throwError "not an imported constant: {n}"
    let some m := env.header.moduleNames[idx.toNat]? | throwError "no module for {n}"
    show1 m n
  IO.println s!"TOTAL wave={rows.size} extra={extraHeads.length}"
  IO.println "=== END ==="

end L10BSig

#eval L10BSig.run
