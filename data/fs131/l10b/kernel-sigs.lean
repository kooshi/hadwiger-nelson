import Proofs
/-!
FS131-L10B — every head of wave 10's second landing, as the kernel holds it (the brief's step 4; inventory item 556: a section
`variable` enters a theorem only if its statement mentions it, so a file's reader can see a hypothesis the kernel's statement lacks).

For every theorem and axiom of the modules in `waveModules` (hand-written or not: the reader filters), and for each name in
`extraHeads` (heads of modules landed earlier whose docstrings this landing touches, or that the brief names), prints

  @@ <THM|AXIOM|DEF|OTHER> <module> <full name>
  SIG <the signature as `#check` prints it, on one line>
  BINDER <explicit|implicit|strict|inst> <prop|data> <binder name> : <its type, on one line>     (one per `∀` of the stored type)
  CONCL <what is left after every `∀`, on one line>

from the constant's stored type — the statement the kernel checked, whatever the file's text shows. A name in `extraHeads` that
is not a constant fails elaboration (the double backtick), so a misspelt head is loud. Read-only.
Run from a worktree with a built library:  lake env lean data/fs131/l10b/kernel-sigs.lean > data/fs131/l10b/kernel-sigs.out
The reader is `tools/fs131_l10b_kernelsig.py`.
-/
open Lean Meta Elab Command

namespace L10BSig

def waveModules : List Name := [
  `Proofs.HadwigerNelson.Arith.FactorAction,
  `Proofs.HadwigerNelson.Arith.Floor128,
  `Proofs.HadwigerNelson.Arith.FloorPlanes,
  `Proofs.HadwigerNelson.Arith.GapSeven,
  `Proofs.HadwigerNelson.Arith.MajorityVote,
  `Proofs.HadwigerNelson.Arith.NegCircleModel,
  `Proofs.HadwigerNelson.Arith.NormOneTarget,
  `Proofs.HadwigerNelson.Arith.ProductFactor,
  `Proofs.HadwigerNelson.Arith.RatioBound,
  `Proofs.HadwigerNelson.Arith.TargetFloors,
  `Proofs.HadwigerNelson.Arith.WeilKloosterman,
  `Proofs.HadwigerNelson.Plane.MetricalBoundary]

/-- Heads outside the wave's new modules: the Falconer line's five in `Plane/FalconerReduction`; the landed heads whose
docstrings this landing corrects (`SpectralInputs`), the instance made global and the hypothesis forms kept (`StandingFive`). -/
def extraHeads : List Name := [
  ``HadwigerNelson.Plane.falconer_lemma2_nonempty,
  ``HadwigerNelson.Plane.falconer_reduction,
  ``HadwigerNelson.Plane.le_chiM_of_falconerFan,
  ``HadwigerNelson.Plane.exists_mem_falconerE,
  ``HadwigerNelson.Plane.fan_tip_ae_mem,
  ``HadwigerNelson.SpectralInputs.sp_if,
  ``HadwigerNelson.SpectralInputs.si4,
  ``HadwigerNelson.SpectralInputs.si4_equivariant,
  ``HadwigerNelson.SpectralInputs.spectral_carried_iff,
  ``HadwigerNelson.SpectralInputs.contChars_haar_null,
  ``HadwigerNelson.StandingFive.numberField_standingField,
  ``HadwigerNelson.StandingFive.instNumberFieldStanding,
  ``HadwigerNelson.StandingFive.seven_le_localBound,
  ``HadwigerNelson.StandingFive.five_le_chromaticNumber,
  ``HadwigerNelson.StandingFive.usable_card_ge,
  ``HadwigerNelson.StandingFive.no_small_usable]

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
