import OAI.Geometry.PlaneColoring.Five
/-! FS133-K1 — the release side of the read-back: the rigidity statement in its Hilbert-space form and the
definitions it names, as the release's kernel stores them; and the cone of each candidate, by module. -/
namespace FS132I1
open Lean
/-- A canonical print of a universe level. -/
partial def dumpLevel : Level → String
  | .zero => "0"
  | .succ l => s!"(S {dumpLevel l})"
  | .max a b => s!"(max {dumpLevel a} {dumpLevel b})"
  | .imax a b => s!"(imax {dumpLevel a} {dumpLevel b})"
  | .param n => s!"(p {n})"
  | .mvar _ => "(lmvar)"
def bi : BinderInfo → String
  | .default => "d" | .implicit => "i" | .strictImplicit => "s" | .instImplicit => "c"
/-- A canonical print of a term as the kernel holds it: de Bruijn indices, full constant names with their universe
arguments, every implicit and instance argument, binder kinds AND binder names (macro scopes erased). Two terms print
alike exactly when they are the same term up to metadata. (The audit's `DumpBody.lean.inc` printed no binder names;
this one does, so a renamed binder is a difference too.) -/
partial def dump : Expr → String
  | .bvar i => s!"#{i}"
  | .fvar _ => "(fvar)"
  | .mvar _ => "(mvar)"
  | .sort l => s!"(Sort {dumpLevel l})"
  | .const n ls => s!"(c {n} [{String.intercalate "," (ls.map dumpLevel)}])"
  | .app f a => s!"({dump f} {dump a})"
  | .lam n t b i => s!"(lam.{bi i} {n.eraseMacroScopes} {dump t} {dump b})"
  | .forallE n t b i => s!"(pi.{bi i} {n.eraseMacroScopes} {dump t} {dump b})"
  | .letE n t v b _ => s!"(let {n.eraseMacroScopes} {dump t} {dump v} {dump b})"
  | .lit (.natVal n) => s!"(nat {n})"
  | .lit (.strVal s) => s!"(str {s.quote})"
  | .mdata _ e => dump e
  | .proj s i e => s!"(proj {s} {i} {dump e})"
/-- One declaration: its kind, universe parameters, stored type, and (for a definition) stored value; then every
constant the type and the value name, each with the module that declares it. -/
def report (n : Name) : CoreM Unit := do
  let env ← getEnv
  match env.find? n with
  | none => IO.println s!"DUMP {n} : ABSENT"
  | some ci =>
    let kind := match ci with
      | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom"
      | .opaqueInfo _ => "opaque" | _ => "other"
    IO.println s!"DUMP {n} : {kind} levels={ci.levelParams}"
    IO.println s!"DUMP   type  = {dump ci.type}"
    let mut used := ci.type.getUsedConstants
    if let .defnInfo d := ci then
      IO.println s!"DUMP   value = {dump d.value}"
      used := used ++ d.value.getUsedConstants
    let names := (used.qsort Name.lt).toList.eraseDups
    for c in names do
      let m := match env.getModuleIdxFor? c with
        | some i => toString env.header.moduleNames[i.toNat]!
        | none => "(this file)"
      IO.println s!"USES {n} : {c} @ {m}"
end FS132I1
open Lean Elab Command in
#eval show CommandElabM Unit from liftCoreM do
  for n in [``OAI.PlaneFiveColor.Spectral.E, ``OAI.PlaneFiveColor.Spectral.K, ``OAI.PlaneFiveColor.Spectral.DiscreteE,
      ``OAI.PlaneFiveColor.Spectral.instCommGroupDiscreteE, ``OAI.PlaneFiveColor.Spectral.kCoeff, ``OAI.EuclideanFiveColor.ContinuousVectors.op,
      ``OAI.EuclideanFiveColor.ContinuousVectors.space, ``OAI.PlaneFiveColor.Spectral.residual_fourier,
      ``OAI.PlaneFiveColor.Spectral.wild_fourier] do
    FS132I1.report n
open Lean in
def oaiClosure (env : Environment) (root : Name) : NameSet × Std.HashMap Name Nat := Id.run do
  let modOf (n : Name) : Option Name := (env.getModuleIdxFor? n).bind fun i => env.header.moduleNames[i.toNat]?
  let isOAI (n : Name) : Bool := match modOf n with | some m => (`OAI).isPrefixOf m | none => false
  let mut seen : NameSet := {}
  let mut stack : Array Name := #[root]
  while !stack.isEmpty do
    let n := stack.back!
    stack := stack.pop
    if seen.contains n then continue
    seen := seen.insert n
    if let some ci := env.find? n then
      let used := ci.type.getUsedConstants ++ (match ci.value? (allowOpaque := true) with | some v => v.getUsedConstants | none => #[])
      for u in used do
        if !seen.contains u && isOAI u then stack := stack.push u
  let mut per : Std.HashMap Name Nat := {}
  for n in seen.toList do
    if let some m := modOf n then per := per.insert m (per.getD m 0 + 1)
  return (seen, per)
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  for root in [``OAI.PlaneFiveColor.Spectral.residual_fourier, ``OAI.PlaneFiveColor.Spectral.wild_fourier,
      ``OAI.EuclideanFiveColor.exists_measurable_field, ``OAI.PlaneFiveColor.Spectral.orbitExtension_inner,
      ``OAI.EuclideanFiveColor.ContinuousVectors.projection_range, ``OAI.EuclideanFiveColor.ContinuousVectors.projection_covariance_fixed,
      ``OAI.EuclideanFiveColor.ContinuousVectors.projection_coefficient, ``OAI.EuclideanFiveColor.positive_orthogonal,
      ``OAI.PlaneFiveColor.Spectral.circle_closed_induction, ``OAI.EuclideanFiveColor.Koopman.nonlinear_commute,
      ``OAI.PlaneFiveColor.LabelModel.fieldVector_unit_correlation, ``OAI.PlaneFiveColor.LabelModel.exists_label_field] do
    let (seen, per) := oaiClosure env root
    let mods := per.toList.map (fun (m, k) => s!"{(m.toString.replace "OAI.Geometry.PlaneColoring." "PC.").replace "OAI.Analysis.PlaneSpectrum." "PS." |>.replace "OAI.MeasureTheory.CompactFactors." "CF."}:{k}")
    IO.println s!"PIECE {root} : decls={seen.size} modules={per.size} :: {String.intercalate " " (mods.toArray.qsort (· < ·)).toList}"
