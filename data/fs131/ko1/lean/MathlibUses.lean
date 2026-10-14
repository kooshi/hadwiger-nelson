import OAI.Geometry.PlaneColoring.BorelTransfer
-- FS131-KO1 trial, the pricing instrument (release side): for every constant of the transfer's cone (whole files: every
-- constant of the 31 ported release modules), each constant of Mathlib or core its stored TYPE names (`USE … T`) and
-- each its stored VALUE names (`USE … V`), and every such constant's stored type in FS132-I2's canonical print (`SIG`).
-- The same `SIG` print at this library's pin (`MathlibSigHere.lean`) shows which named constants differ between pins.
open Lean Elab Command
namespace FS131KO1Dump
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
arguments, every implicit and instance argument, binder kinds and binder names (macro scopes erased). Two terms print
alike exactly when they are the same term up to metadata. (FS132-I1's print, `data/fs132/i1/readback/DumpBody.lean.inc`.) -/
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
end FS131KO1Dump

namespace FS131KO1MU
def modOf (env : Environment) (n : Name) : Option Name :=
  match env.getModuleIdxFor? n with
  | some idx => some env.header.moduleNames[idx.toNat]!
  | none => none

def isOAI (env : Environment) (n : Name) : Bool :=
  match modOf env n with
  | some m => (`OAI).isPrefixOf m
  | none => false

def kindOf : ConstantInfo → String
  | .axiomInfo _ => "axiom" | .defnInfo _ => "def" | .thmInfo _ => "theorem" | .opaqueInfo _ => "opaque"
  | .quotInfo _ => "quot" | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec"

def usedOf (ci : ConstantInfo) : Array Name := Id.run do
  let mut s : NameSet := ci.type.getUsedConstantsAsSet
  let v? : Option Expr := match ci with
    | .defnInfo v => some v.value | .thmInfo v => some v.value | .opaqueInfo v => some v.value | _ => none
  if let some v := v? then
    for n in v.getUsedConstantsAsSet do s := s.insert n
  match ci with
  | .inductInfo v => for n in v.ctors do s := s.insert n
  | .ctorInfo v => s := s.insert v.induct
  | .recInfo v => for n in v.all do s := s.insert n
  | _ => pure ()
  return s.toArray

/-- The OAI constants reachable from `root`, and the edges between them. -/
def closure (env : Environment) (root : Name) : NameSet × Array (Name × Name) := Id.run do
  let mut seen : NameSet := {}
  let mut edges : Array (Name × Name) := #[]
  let mut stack : Array Name := #[root]
  seen := seen.insert root
  while !stack.isEmpty do
    let n := stack.back!
    stack := stack.pop
    match env.find? n with
    | none => pure ()
    | some ci =>
      for m in usedOf ci do
        if isOAI env m then
          edges := edges.push (n, m)
          if !seen.contains m then
            seen := seen.insert m
            stack := stack.push m
  return (seen, edges)


def files : List Name := [`OAI.Analysis.PlaneSpectrum.Basic, `OAI.Analysis.PlaneSpectrum.InvariantMean, `OAI.Analysis.PlaneSpectrum.NumberFields, `OAI.Analysis.PlaneSpectrum.PhaseEncoding, `OAI.Analysis.PlaneSpectrum.SmallArcs, `OAI.MeasureTheory.CompactFactors.Amenability, `OAI.MeasureTheory.CompactFactors.Centers, `OAI.Analysis.PlaneSpectrum.Characters, `OAI.Analysis.PlaneSpectrum.PhaseCollision, `OAI.Analysis.PlaneSpectrum.Selections, `OAI.MeasureTheory.CompactFactors.RelativeCenters, `OAI.Analysis.PlaneSpectrum.Multipliers, `OAI.MeasureTheory.CompactFactors.ConditionalSelection, `OAI.Analysis.PlaneSpectrum.FourierTests, `OAI.Analysis.PlaneSpectrum.ConditionalSpectrum, `OAI.MeasureTheory.CompactFactors.Approximation, `OAI.MeasureTheory.CompactFactors.ConditionalLimits, `OAI.MeasureTheory.CompactFactors.Kernels, `OAI.MeasureTheory.CompactFactors.BoundedFunctions, `OAI.MeasureTheory.CompactFactors.Functions, `OAI.MeasureTheory.CompactFactors.Factors, `OAI.MeasureTheory.CompactFactors.RelativeProducts, `OAI.MeasureTheory.CompactFactors.Separability, `OAI.MeasureTheory.CompactFactors.Stationary, `OAI.MeasureTheory.CompactFactors.AlgebraModels, `OAI.Analysis.PlaneSpectrum.Representations, `OAI.Analysis.PlaneSpectrum.Energy, `OAI.Analysis.PlaneSpectrum.SpectralMeasure, `OAI.Analysis.PlaneSpectrum.RadialEnergy, `OAI.Analysis.PlaneSpectrum.Ergodicity, `OAI.Geometry.PlaneColoring.BorelTransfer]

def run : CommandElabM Unit := do
  let env ← getEnv
  let mut sigs : NameSet := {}
  let mut out : Array String := #[]
  for (n, ci) in env.constants.map₁.toList do
    let some m := modOf env n | continue
    unless files.contains m do continue
    let tset := ci.type.getUsedConstantsAsSet
    for c in tset do
      unless isOAI env c do
        out := out.push s!"USE\t{n}\tT\t{c}"; sigs := sigs.insert c
    let v? : Option Expr := match ci with
      | .defnInfo v => some v.value | .thmInfo v => some v.value | _ => none
    if let some v := v? then
      for c in v.getUsedConstantsAsSet do
        unless isOAI env c || tset.contains c do
          out := out.push s!"USE\t{n}\tV\t{c}"; sigs := sigs.insert c
  for l in out.qsort (· < ·) do IO.println l
  for c in sigs.toList.toArray.qsort Name.lt do
    if let some ci := env.find? c then
      IO.println s!"SIG\t{c}\t{FS131KO1Dump.dump ci.type}"
  IO.println s!"SUMMARY uses={out.size} sigs={sigs.size}"

#eval run

end FS131KO1MU
