import OAI.Geometry.PlaneColoring.Five
-- FS132-I1: level one at the RELEASE's pin.
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
namespace FS132I1
open Lean
/-- Level one: one constant the statements name, as the kernel holds it at this pin — kind, universe parameters,
type, and what fixes its meaning one step down (a definition's value; an inductive type's constructors with their
types; nothing for a theorem, whose proof no statement reads). One line, so two pins compare line by line. -/
def level1 (n : Name) : CoreM Unit := do
  let env ← getEnv
  match env.find? n with
  | none => IO.println s!"L1 {n} | ABSENT"
  | some ci =>
    let m := match env.getModuleIdxFor? n with
      | some i => toString env.header.moduleNames[i.toNat]!
      | none => "(this file)"
    let body ← match ci with
      | .defnInfo d => pure s!"def | value = {dump d.value}"
      | .thmInfo _ => pure "theorem |"
      | .axiomInfo _ => pure "axiom |"
      | .opaqueInfo _ => pure "opaque |"
      | .inductInfo v => do
          let mut s := s!"inductive params={v.numParams} indices={v.numIndices} |"
          for c in v.ctors do
            let some cc := env.find? c | pure ()
            s := s ++ s!" ctor {c} : {dump cc.type} ;"
          pure s
      | .ctorInfo _ => pure "ctor |"
      | .recInfo _ => pure "rec |"
      | .quotInfo _ => pure "quot |"
    IO.println s!"L1 {n} | levels={ci.levelParams} | type = {dump ci.type} | {body}"
    IO.println s!"L1MOD {n} @ {m}"
end FS132I1
#eval FS132I1.level1 `AEMeasurable
#eval FS132I1.level1 `AddCircle
#eval FS132I1.level1 `AddCircle.haarAddCircle
#eval FS132I1.level1 `AddCircle.toCircle
#eval FS132I1.level1 `AddCommGroup.toAddGroup
#eval FS132I1.level1 `AddSubgroup.zmultiples
#eval FS132I1.level1 `And
#eval FS132I1.level1 `Circle._proof_1
#eval FS132I1.level1 `Circle._proof_2
#eval FS132I1.level1 `Complex
#eval FS132I1.level1 `Complex.borelSpace
#eval FS132I1.level1 `Complex.instAdd
#eval FS132I1.level1 `Complex.instFiniteDimensionalReal
#eval FS132I1.level1 `Complex.instNorm
#eval FS132I1.level1 `Complex.instNormedAddCommGroup
#eval FS132I1.level1 `Complex.instNormedField
#eval FS132I1.level1 `Complex.instRCLike
#eval FS132I1.level1 `Complex.instSub
#eval FS132I1.level1 `Complex.measurableSpace
#eval FS132I1.level1 `Eq
#eval FS132I1.level1 `Exists
#eval FS132I1.level1 `Fact
#eval FS132I1.level1 `Filter.Eventually
#eval FS132I1.level1 `Fin
#eval FS132I1.level1 `Fin.instMeasurableSpace
#eval FS132I1.level1 `FiniteDimensional.rclike_to_real
#eval FS132I1.level1 `HAdd.hAdd
#eval FS132I1.level1 `HMul.hMul
#eval FS132I1.level1 `HSub.hSub
#eval FS132I1.level1 `LT.lt
#eval FS132I1.level1 `Measurable
#eval FS132I1.level1 `MeasureTheory.Measure
#eval FS132I1.level1 `MeasureTheory.Measure.instFunLike
#eval FS132I1.level1 `MeasureTheory.Measure.prod
#eval FS132I1.level1 `MeasureTheory.MeasureSpace.toMeasurableSpace
#eval FS132I1.level1 `MeasureTheory.MeasureSpace.volume
#eval FS132I1.level1 `MeasureTheory.ae
#eval FS132I1.level1 `Membership.mem
#eval FS132I1.level1 `MulZeroClass.toZero
#eval FS132I1.level1 `MulZeroOneClass.toMulOneClass
#eval FS132I1.level1 `Nat
#eval FS132I1.level1 `Nat.instAtLeastTwoHAddOfNat
#eval FS132I1.level1 `Nat.instMulZeroClass
#eval FS132I1.level1 `Nat.instNeZeroSucc
#eval FS132I1.level1 `Ne
#eval FS132I1.level1 `NeZero
#eval FS132I1.level1 `Norm.norm
#eval FS132I1.level1 `NormedCommRing.toSeminormedCommRing
#eval FS132I1.level1 `NormedField.toNormedCommRing
#eval FS132I1.level1 `Not
#eval FS132I1.level1 `OfNat.ofNat
#eval FS132I1.level1 `One.toOfNat1
#eval FS132I1.level1 `Prod
#eval FS132I1.level1 `Prod.fst
#eval FS132I1.level1 `Prod.instMeasurableSpace
#eval FS132I1.level1 `Prod.snd
#eval FS132I1.level1 `QuotientAddGroup.measurableSpace
#eval FS132I1.level1 `Real
#eval FS132I1.level1 `Real.instAddCommGroup
#eval FS132I1.level1 `Real.instLT
#eval FS132I1.level1 `Real.instMul
#eval FS132I1.level1 `Real.instNatCast
#eval FS132I1.level1 `Real.instOne
#eval FS132I1.level1 `Real.instZero
#eval FS132I1.level1 `Real.measurableSpace
#eval FS132I1.level1 `Real.pi
#eval FS132I1.level1 `Ring.toSemiring
#eval FS132I1.level1 `SeminormedCommRing.toSeminormedRing
#eval FS132I1.level1 `SeminormedRing.toRing
#eval FS132I1.level1 `SetLike.instMembership
#eval FS132I1.level1 `Submonoid
#eval FS132I1.level1 `Submonoid.instSetLike
#eval FS132I1.level1 `Submonoid.unitSphere
#eval FS132I1.level1 `Subtype.val
#eval FS132I1.level1 `Zero.toOfNat0
#eval FS132I1.level1 `instHAdd
#eval FS132I1.level1 `instHMul
#eval FS132I1.level1 `instHSub
#eval FS132I1.level1 `instInnerProductSpaceRealComplex
#eval FS132I1.level1 `instMulZeroOneClassOfSemiring
#eval FS132I1.level1 `instOfNatAtLeastTwo
#eval FS132I1.level1 `instOfNatNat
#eval FS132I1.level1 `measureSpaceOfInnerProductSpace
