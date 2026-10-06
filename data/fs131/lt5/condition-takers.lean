import Proofs
/-!
FS131-LT5, the second reading (the brief's step 5): for each former the assumptions list declares a `.condition`, and for
the two `.premise` theorems, what the library holds of it — read from the stored types, not from the text.

  @@ <former>
  TAKEN <n> : the constants whose statement mentions it in a hypothesis (a binder whose type is a proposition), first eight
  DATA <n>  : those that mention it only in a non-proposition binder or in the conclusion
  CONCL <n> : those whose conclusion mentions it (theorems that produce or refute it), first eight
  BODY <n>  : library definitions whose value mentions it (wrappers and derived predicates), first eight

Read-only. Run from a worktree with a built library:  lake env lean data/fs131/lt5/condition-takers.lean
-/
open Lean Meta Elab Command

def lt5Conditions : List Name := [
  ``HadwigerNelson.SpectralChain.TCA, ``HadwigerNelson.Arith.IsUsablePrime, ``HadwigerNelson.Arith.NoAffFieldHyp,
  ``HadwigerNelson.ExtensionOrder, ``HadwigerNelson.IsLift, ``HadwigerNelson.Plane.AeProperRegions.IsRegion,
  ``HadwigerNelson.Plane.Arc.IsUnitArc, ``HadwigerNelson.Plane.ArcMap.BaseCtx, ``HadwigerNelson.Plane.ArcMap.Condition6,
  ``HadwigerNelson.Plane.ArcMap.CrossesAt, ``HadwigerNelson.Plane.ArcMap.DoubleEvent, ``HadwigerNelson.Plane.ArcMap.HexRing,
  ``HadwigerNelson.Plane.ArcMap.IsEssBoundary, ``HadwigerNelson.Plane.ArcMap.Near.RayConfig,
  ``HadwigerNelson.Plane.ArcMap.OnRingArc, ``HadwigerNelson.Plane.ArcMap.RingProper, ``HadwigerNelson.Plane.ArcMap.SaturatedAt,
  ``HadwigerNelson.Plane.ArcMap.Terminal, ``HadwigerNelson.Plane.ArcMap.Todo, ``HadwigerNelson.Plane.BranchGerms.Sorted,
  ``HadwigerNelson.Plane.CPColouring.RotationInvariant, ``HadwigerNelson.Plane.GrundyBound, ``HadwigerNelson.Plane.H1On,
  ``HadwigerNelson.Plane.InSixLens, ``HadwigerNelson.Plane.IsAdmissible, ``HadwigerNelson.Plane.IsRegOf,
  ``HadwigerNelson.Plane.IsSelection, ``HadwigerNelson.SpectralInputs.IsHaarFourier,
  ``HadwigerNelson.SpectralChain.IsTraceSpectral, ``HadwigerNelson.SpectralInputs.IsSpectralMeasureOf,
  ``HadwigerNelson.SpernerGrid.Rainbow, ``HadwigerNelson.Strip.WindowProper, ``HadwigerNelson.Thomassen.IsTwoSep,
  ``HadwigerNelson.Plane.NoPar, ``HadwigerNelson.StandingFive.StandingFloor, ``HadwigerNelson.StandingFive.KloostermanBound]

def lt5Short (ns : Array Name) : String :=
  String.intercalate ", " ((ns.toList.take 8).map fun n => (n.toString.replace "HadwigerNelson." ""))

-- one `#eval` reads every statement of the library once per former: the default heartbeat budget is for a proof
set_option maxHeartbeats 0 in
#eval show CommandElabM Unit from liftTermElabM do
  let env ← getEnv
  let ours := env.constants.toList.filter fun (n, _) =>
    match (env.getModuleIdxFor? n).bind fun i => env.header.moduleNames[i.toNat]? with
    | some m => (`Proofs).isPrefixOf m && !n.isInternal
    | none => false
  for h in lt5Conditions do
    let mut taken : Array Name := #[]
    let mut data : Array Name := #[]
    let mut concl : Array Name := #[]
    let mut body : Array Name := #[]
    for (n, ci) in ours do
      if n == h then continue
      if ci.type.getUsedConstants.contains h then
        let (inHyp, inConcl) ← forallTelescope ci.type fun xs c => do
          let mut hyp := false
          for x in xs do
            let ty ← instantiateMVars (← inferType x)
            if (← isProp ty) && ty.getUsedConstants.contains h then hyp := true
          pure (hyp, (← instantiateMVars c).getUsedConstants.contains h)
        if inHyp then taken := taken.push n else data := data.push n
        if inConcl then concl := concl.push n
      match ci with
      | .defnInfo v => if v.value.getUsedConstants.contains h && !ci.type.getUsedConstants.contains h then body := body.push n
      | _ => pure ()
    IO.println s!"@@ {h}"
    IO.println s!"  TAKEN {taken.size} : {lt5Short taken}"
    IO.println s!"  DATA {data.size} : {lt5Short data}"
    IO.println s!"  CONCL {concl.size} : {lt5Short concl}"
    IO.println s!"  BODY {body.size} : {lt5Short body}"
  IO.println s!"FORMERS {lt5Conditions.length}"
