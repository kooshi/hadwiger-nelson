import Proofs
/-!
FS131-LCH1 — the ruled statement changes, undone by the kernel's own term surgery on the joined tree's stored types, so
that each can be compared by hash (`Expr.hash`, which reads no binder name) with the type dumped before any edit:
* **DROPPED** — the binders the integrations dropped, put back: `hOA : Plane.OneAvoidingDensityBound` (and, in the
  headline, `hRow99`, whose type is `ThreeFourColours.localBound_le_chromaticNumber_of_le_four`'s at the same `F` and
  instance), inserted after the leading binders the statement kept;
* **RENAMED** — the stored types of `Plane/OneClass/InvariantLaw` and `Rigidity/InvariantMeasure` that name one of the
  eleven helpers made public, with each public name replaced by the private name the module saw before
  (`InvariantLaw`'s own private copy, or M3's).
Prints `READD <name> <hash>` per constant; a control prints the same surgery with a wrong domain (`True`) as `CONTROL`.
Run: `lake env lean data/fs131/lch1/lean/ReAdd.lean > data/fs131/lch1/readd.txt`.
-/
open Lean Meta Elab Command

namespace FS131LCH1ReAdd

def helpers : List String := ["avgMeasure", "avgMeasure_apply", "isProbabilityMeasure_avgMeasure", "avgMeasure_map",
  "integral_avgMeasure", "map_eq_of_tendsto", "map_eq_of_tendsto_of_eventually", "measure_compl_eq_zero_of_tendsto",
  "isClosed_setOf_of_tendsto", "exists_fixed_of_average", "exists_common_fixed"]

def privName (mod : Name) (n : Name) : Name := Name.mkNum (`_private ++ mod) 0 ++ n

/-- Insert non-dependent binders with domains `doms xs` after the first `k` binders of `t`. -/
def insertAfter (t : Expr) (k : Nat) (doms : Array Expr → MetaM (List Expr)) : MetaM Expr :=
  forallBoundedTelescope t k fun xs body => do
    let ds ← doms xs
    let body' ← ds.foldrM (fun d b => mkArrow d b) body
    mkForallFVars xs body'

def typeOf (n : Name) : MetaM Expr := do
  let some ci := (← getEnv).find? n | throwError "unknown {n}"
  pure ci.type

def run : MetaM Unit := do
  let oab := mkConst ``HadwigerNelson.Plane.OneAvoidingDensityBound
  let row99 ← typeOf ``HadwigerNelson.ThreeFourColours.localBound_le_chromaticNumber_of_le_four
  -- the headline: two binders after `F` and the instance
  let h ← typeOf ``HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber
  let e ← insertAfter h 2 fun xs => do pure [oab, ← instantiateForall row99 xs]
  IO.println s!"READD HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber {e.hash}"
  let c ← insertAfter h 2 fun xs => do pure [mkConst ``True, ← instantiateForall row99 xs]
  IO.println s!"CONTROL HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber {c.hash}"
  -- one `hOA` binder, after `k` kept binders
  let ones : List (Name × Nat) := [
    (``HadwigerNelson.Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound, 2),
    (``HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five, 0),
    (``HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five, 0),
    (``HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt311_eq_five, 0),
    (``HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt335_eq_five, 0),
    (``HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt3_sqrt5_eq_five, 0),
    (``HadwigerNelson.SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167, 0)]
  for (n, k) in ones do
    let t ← typeOf n
    let e ← insertAfter t k fun _ => pure [oab]
    IO.println s!"READD {n} {e.hash}"
    let c ← insertAfter t k fun _ => pure [mkConst ``True]
    IO.println s!"CONTROL {n} {c.hash}"
  -- the renamed helpers, read back under the private names each module saw before
  let env ← getEnv
  let lawMod := `Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
  let m3Mod := `Proofs.HadwigerNelson.Rigidity.InvariantMeasure
  let pubs : List Name := helpers.map fun s => `HadwigerNelson.OneClass ++ s.toName
  -- a public helper's name, or an internal constant under it (`avgMeasure._proof_1`, `avgMeasure.eq_1`)
  let underPub (n : Name) : Bool := pubs.any (·.isPrefixOf n)
  for (mod, newPrefix) in [(lawMod, `HadwigerNelson.OneClass), (m3Mod, `HadwigerNelson.Rigidity)] do
    let some idx := env.header.moduleNames.findIdx? (· == mod) | throwError "module {mod} not imported"
    let back (n : Name) : Name := privName mod (n.replacePrefix `HadwigerNelson.OneClass newPrefix)
    let rn (e : Expr) : Expr := e.replace fun x => match x with
      | .const n us => if underPub n then some (mkConst (back n) us) else none
      | _ => none
    for ci in env.header.moduleData[idx]!.constants do
      if ci.type.getUsedConstants.any underPub then
        IO.println s!"READD {ci.name} {(rn ci.type).hash}"
      if let .defnInfo v := ci then
        if v.value.getUsedConstants.any underPub then
          IO.println s!"READD {ci.name}:value {(rn v.value).hash}"

#eval run

end FS131LCH1ReAdd
