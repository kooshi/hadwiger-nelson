import Proofs
/-! FS131-LGT1 — the stored types of the six declarations of the landed modules the vacuity scan skips as refutations, of
its one new GENERIC site, and of its one new WITNESS (data/fs131/lgt1/vacdiff-1.txt). -/
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  for n in [``HadwigerNelson.Rigidity.noRamifiedStableDyadic_of_tca,
            ``HadwigerNelson.Rigidity.noRamifiedStableDyadic_of_three_le_localBound,
            ``HadwigerNelson.Rigidity.Counting.count_of_oneAvoidingDensityBound,
            ``HadwigerNelson.Rigidity.Counting.false_of_slice,
            ``HadwigerNelson.Rigidity.ZdAction.noVirtuallyCyclicFactors_of_isIrreducible,
            ``HadwigerNelson.Rigidity.trivialAction_noVirtuallyCyclicFactors,
            ``HadwigerNelson.Rigidity.nonempty_invariantColouring_bot,
            ``HadwigerNelson.Rigidity.NoRamifiedStableDyadic,
            ``HadwigerNelson.Rigidity.ZdAction.NoVirtuallyCyclicFactors,
            ``HadwigerNelson.SpectralChain.Interface.Count,
            `SimpleGraph.Coloring.colorClass.eq_1] do
    let some ci := env.find? n | logInfo m!"MISSING {n}"
    let mod := match env.getModuleIdxFor? n with
      | some i => (env.header.moduleNames[i.toNat]!).toString | none => "?"
    let v : MessageData := match ci with
      | .defnInfo d => m!"\n  := {d.value}" | _ => m!""
    logInfo m!"{n} ({mod}) : {ci.type}{v}"
