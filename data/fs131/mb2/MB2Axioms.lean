import Proofs.HadwigerNelson.Plane.Models.Stuck
import Proofs.HadwigerNelson.Plane.Models.Bends

/-!
FS131-MB2's receipt, printed by `lake env lean` (iteration evidence; the gate's audit is `scripts/axioms.sh`). The two commands are
FS131-MB1's (`data/fs131/mb/MBAxioms.lean`), copied unchanged; the records are MB1's, kept as a regression, and this job's.

For each record: its axioms, and — because this branch holds `Plane/Models/Paint` with its leaves open (they are
implementer A's) — **which declarations of its dependency closure are themselves proved by `sorry`, with their
modules**. A record whose only such declarations are in `Plane.Models.Paint` is whole in this job's files and will
read the standard three once A's leaves land; one that names a declaration of `Stuck` or `Bends` is not.

The closure is walked through declarations of the `Proofs` library only (Mathlib and core declare no `sorry`).
-/

open Lean Elab Command

namespace MB

/-- The declarations of `Proofs` in the dependency closure of `n` whose own type or value mentions `sorryAx`. -/
partial def walk (env : Environment) (n : Name) : StateM (NameSet × NameSet) Unit := do
  let (seen, _) ← get
  if seen.contains n then return
  modify fun (s, l) => (s.insert n, l)
  let some ci := env.find? n | return
  let inProofs : Bool := match env.getModuleIdxFor? n with
    | some idx => (env.header.moduleNames[idx.toNat]!).getRoot == `Proofs
    | none => true
  if !inProofs then return
  let deps := ci.type.getUsedConstants ++ ((ci.value? (allowOpaque := true)).map (·.getUsedConstants)).getD #[]
  if deps.contains ``sorryAx then modify fun (s, l) => (s, l.insert n)
  for d in deps do walk env d

/-- `#mb_receipt d` prints `d`'s axioms and the `sorry`-proved declarations it rests on, by module. -/
elab "#mb_receipt " id:ident : command => do
  let n ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo id
  let env ← getEnv
  let axs ← liftCoreM <| collectAxioms n
  let ((), (_, leaves)) := (walk env n).run ({}, {})
  let std : List Name := [``propext, ``Classical.choice, ``Quot.sound]
  let extra := axs.toList.filter (fun a => !std.contains a)
  let modOf (m : Name) : String := match env.getModuleIdxFor? m with
    | some idx => toString (env.header.moduleNames[idx.toNat]!)
    | none => "(this file)"
  let rows := leaves.toList.map (fun l => s!"{modOf l}:{l}")
  let rows := rows.toArray.qsort (· < ·) |>.toList
  let verdict :=
    if extra.isEmpty then "STANDARD-THREE"
    else if extra == [``sorryAx] then
      (if leaves.toList.all (fun l => modOf l == "Proofs.HadwigerNelson.Plane.Models.Paint") then "SORRY-VIA-PAINT-ONLY"
       else "SORRY-IN-OWN-FILES")
    else "OTHER-AXIOM"
  logInfo m!"RECORD {n} | {verdict} | axioms: {axs.toList} | sorry leaves ({rows.length}): {rows}"

/-- `#mb_applies d t` says whether the proof term of `d` calls the declaration `t` directly: a model theorem of this lane *is* the landed
theorem applied to the model, and this reads it off the term. -/
elab "#mb_applies " id:ident thm:ident : command => do
  let n ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo id
  let t ← liftCoreM <| realizeGlobalConstNoOverloadWithInfo thm
  let env ← getEnv
  let some ci := env.find? n | throwError "unknown declaration {n}"
  let deps := ((ci.value? (allowOpaque := true)).map (·.getUsedConstants)).getD #[]
  logInfo m!"APPLIES {n} <- {t} | {if deps.contains t then "APPLIED" else "NOT-APPLIED"}"

end MB

-- the model theorems are the landed theorems applied (the third line is the control: the wrong theorem must read NOT-APPLIED)
#mb_applies HadwigerNelson.Plane.cuspFrag_bend_away HadwigerNelson.Plane.ArcMap.bend_away_whole
#mb_applies HadwigerNelson.Plane.cuspFrag_bend_toward HadwigerNelson.Plane.ArcMap.bend_toward
#mb_applies HadwigerNelson.Plane.cuspFrag_bend_away HadwigerNelson.Plane.ArcMap.bend_toward
#mb_applies HadwigerNelson.Plane.shadowModel_flank_ne HadwigerNelson.Plane.ArcMap.flank_ne_of_doublyShadowed

-- FS131-MB1's records (regression)
#mb_receipt HadwigerNelson.Plane.cuspFrag_isRingArc
#mb_receipt HadwigerNelson.Plane.cuspFrag_coloursAt_I
#mb_receipt HadwigerNelson.Plane.cuspFrag_radiusTwo_disjoint
#mb_receipt HadwigerNelson.Plane.cuspFrag_bend_away
#mb_receipt HadwigerNelson.Plane.cuspFrag_bend_toward
#mb_receipt HadwigerNelson.Plane.stuckArcs_nondegenerate
#mb_receipt HadwigerNelson.Plane.stuckArcs_finite
#mb_receipt HadwigerNelson.Plane.frontier_stuckW_subset
#mb_receipt HadwigerNelson.Plane.stuckCol_locallyConstant
#mb_receipt HadwigerNelson.Plane.stuckModel_valid
#mb_receipt HadwigerNelson.Plane.stuckModel_coloursAt
#mb_receipt HadwigerNelson.Plane.stuckModel_hasSectors
#mb_receipt HadwigerNelson.Plane.stuckModel_isHorn
#mb_receipt HadwigerNelson.Plane.stuckModel_flanks
#mb_receipt HadwigerNelson.Plane.stuckModel_contacts
#mb_receipt HadwigerNelson.Plane.stuckModel_not_mergeAvailable
#mb_receipt HadwigerNelson.Plane.stuckModel_not_rayAvailable
#mb_receipt HadwigerNelson.Plane.stuckModel_not_shaveAvailable
#mb_receipt HadwigerNelson.Plane.stuckModel_isStuck
#mb_receipt HadwigerNelson.Plane.stuckModel_hyps
#mb_receipt HadwigerNelson.Plane.stuckModel_terminal
#mb_receipt HadwigerNelson.Plane.stuckModel_no_unit_pair
#mb_receipt HadwigerNelson.Plane.stuckModel_partition
#mb_receipt HadwigerNelson.Plane.stuckModel_horn_cases
#mb_receipt HadwigerNelson.Plane.stuckModel_shadow
-- FS131-MB2: the doubly shadowed band — the seven leaves, the model theorem, the helpers
#mb_receipt HadwigerNelson.Plane.shadowArcs_nondegenerate
#mb_receipt HadwigerNelson.Plane.frontier_shadowW_subset
#mb_receipt HadwigerNelson.Plane.shadowCol_locallyConstant
#mb_receipt HadwigerNelson.Plane.shadowModel_valid
#mb_receipt HadwigerNelson.Plane.shadowModel_condition5
#mb_receipt HadwigerNelson.Plane.shadowModel_flanks
#mb_receipt HadwigerNelson.Plane.shadowModel_doublyShadowed
#mb_receipt HadwigerNelson.Plane.shadowModel_flank_ne
#mb_receipt HadwigerNelson.Plane.shadowModel_mem_hornArcs
#mb_receipt HadwigerNelson.Plane.shadowModel_hornSet_not_mem_hornArcs
#mb_receipt HadwigerNelson.Plane.shadowModel_dists
#mb_receipt HadwigerNelson.Plane.shadowModel_not_mem_arcs
#mb_receipt HadwigerNelson.Plane.shadowModel_disjoint
#mb_receipt HadwigerNelson.Plane.shadowModel_isOpen
#mb_receipt HadwigerNelson.Plane.shadowModel_shadowCol
#mb_receipt HadwigerNelson.Plane.shadowModel_shadowW_subset
#mb_receipt HadwigerNelson.Plane.shadowModel_mem_region
#mb_receipt HadwigerNelson.Plane.shadowModel_tanHeight
#mb_receipt HadwigerNelson.Plane.shadowModel_apart
#mb_receipt HadwigerNelson.Plane.shadowModel_flank_source
#mb_receipt HadwigerNelson.Plane.shadowModel_no_unit_pair
#mb_receipt HadwigerNelson.Plane.shadowModel_not_isUnitArc
#mb_receipt HadwigerNelson.Plane.shadowModel_witness_real
#mb_receipt HadwigerNelson.Plane.shadowModel_shadow
-- the outward bend's plane map
#mb_receipt HadwigerNelson.Plane.awayModel_hyps
#mb_receipt HadwigerNelson.Plane.awayModel_r2Contacts
