import OAI.Geometry.PlaneColoring.States
import OAI.Geometry.PlaneColoring.AngularBoundary
-- FS132-I2 (generated): level one at the RELEASE's pin.
universe u

namespace FS132I2
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
open Meta in
/-- The same print with every INSTANCE argument and every PROOF argument written `_`: an argument is erased when the
applied function's own signature, at this pin, takes it instance-implicitly (`[inst : C α]`) or at a type that is a
proposition. What is left is what the term says with the choice of instances and the proofs of side conditions set
aside. Free variables print as their position in the local context (`@n`). -/
partial def dumpE (e : Expr) : MetaM String := do
  match e with
  | .mdata _ e => dumpE e
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    let info ← getFunInfoNArgs f args.size
    let mut s ← dumpE f
    for i in [0:args.size] do
      let erase := match info.paramInfo[i]? with
        | some pi => pi.binderInfo.isInstImplicit || pi.isProp
        | none => false
      if erase then s := s!"({s} _)" else s := s!"({s} {← dumpE args[i]!})"
    return s
  | .lam n t b i => do
    let ts ← dumpE t
    withLocalDecl n i t fun x => do
      return s!"(lam.{bi i} {n.eraseMacroScopes} {ts} {← dumpE (b.instantiate1 x)})"
  | .forallE n t b i => do
    let ts ← dumpE t
    withLocalDecl n i t fun x => do
      return s!"(pi.{bi i} {n.eraseMacroScopes} {ts} {← dumpE (b.instantiate1 x)})"
  | .letE n t v b _ => do
    let ts ← dumpE t
    let vs ← dumpE v
    withLetDecl n t v fun x => do
      return s!"(let {n.eraseMacroScopes} {ts} {vs} {← dumpE (b.instantiate1 x)})"
  | .fvar id => do return s!"@{(← id.getDecl).index}"
  | .proj s i e => do return s!"(proj {s} {i} {← dumpE e})"
  | e => return dump e
/-- A name from its print; `PRIVATE|module|name` is the private name `name` of `module`. -/
def toName (s : String) : Name :=
  match s.splitOn "|" with
  | ["PRIVATE", m, n] => mkPrivateNameCore m.toName n.toName
  | _ => s.toName
def kindOf : ConstantInfo → String
  | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom" | .opaqueInfo _ => "opaque"
  | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec" | .quotInfo _ => "quot"
/-- One declaration: its kind, universe parameters, stored type, and (for a definition) stored value; then every
constant the type and the value name, each with the module that declares it. `label` is what the line is filed under. -/
def report (label : String) (s : String) : CoreM Unit := do
  let env ← getEnv
  let n := toName s
  match env.find? n with
  | none => IO.println s!"DUMP {label} : ABSENT"
  | some ci =>
    IO.println s!"DUMP {label} : {kindOf ci} levels={ci.levelParams}"
    IO.println s!"DUMP   type  = {dump ci.type}"
    IO.println s!"DUMP   etype = {← (dumpE ci.type).run'}"
    let mut used := ci.type.getUsedConstants
    if let .defnInfo d := ci then
      IO.println s!"DUMP   value = {dump d.value}"
      IO.println s!"DUMP   evalue= {← (dumpE d.value).run'}"
      used := used ++ d.value.getUsedConstants
    for c in (used.qsort Name.lt).toList.eraseDups do
      let m := match env.getModuleIdxFor? c with
        | some i => toString env.header.moduleNames[i.toNat]!
        | none => "(this file)"
      IO.println s!"USES {label} : {c} @ {m}"
/-- Level one: one constant as the kernel holds it at this pin — kind, universe parameters, type, and what fixes its
meaning one step down (a definition's value; an inductive type's constructors with their types). -/
def level1 (label : String) (s : String) : CoreM Unit := do
  let env ← getEnv
  let n := toName s
  match env.find? n with
  | none => IO.println s!"L1 {label} | ABSENT"
  | some ci =>
    let m := match env.getModuleIdxFor? n with
      | some i => toString env.header.moduleNames[i.toNat]!
      | none => "(this file)"
    let body ← match ci with
      | .defnInfo d => pure s!"def | value = {dump d.value}"
      | .inductInfo v => do
          let mut s := s!"inductive params={v.numParams} indices={v.numIndices} |"
          for c in v.ctors do
            let some cc := env.find? c | pure ()
            s := s ++ s!" ctor {c} : {dump cc.type} ;"
          pure s
      | ci => pure s!"{kindOf ci} |"
    IO.println s!"L1 {label} | levels={ci.levelParams} | type = {dump ci.type} | {body}"
    IO.println s!"L1MOD {label} @ {m}"
def runAll (xs : List (String × String)) : CoreM Unit := do
  for (l, s) in xs do report l s
  IO.println s!"DONE {xs.length}"
def runLevel1 (xs : List (String × String)) : CoreM Unit := do
  for (l, s) in xs do level1 l s
  IO.println s!"DONE {xs.length}"
end FS132I2

#eval FS132I2.runLevel1 [("AEMeasurable", "AEMeasurable"),
  ("AddCircle", "AddCircle"),
  ("AddCircle.haarAddCircle", "AddCircle.haarAddCircle"),
  ("AddCircle.toCircle", "AddCircle.toCircle"),
  ("AddSubgroup", "AddSubgroup"),
  ("AddSubgroup.zmultiples", "AddSubgroup.zmultiples"),
  ("And", "And"),
  ("Bool", "Bool"),
  ("Bool.false", "Bool.false"),
  ("Bool.not", "Bool.not"),
  ("Bool.true", "Bool.true"),
  ("CompleteSpace", "CompleteSpace"),
  ("Complex", "Complex"),
  ("Complex.ofReal", "Complex.ofReal"),
  ("DFunLike.coe", "DFunLike.coe"),
  ("Disjoint", "Disjoint"),
  ("ENNReal", "ENNReal"),
  ("Eq", "Eq"),
  ("Exists.choose", "Exists.choose"),
  ("False", "False"),
  ("Filter.Eventually", "Filter.Eventually"),
  ("Filter.EventuallyLE", "Filter.EventuallyLE"),
  ("Filter.EventuallySubset", "Filter.EventuallySubset"),
  ("Filter.Tendsto", "Filter.Tendsto"),
  ("Fin", "Fin"),
  ("Finset", "Finset"),
  ("Finset.card", "Finset.card"),
  ("Finset.filter", "Finset.filter"),
  ("Finset.univ", "Finset.univ"),
  ("HAdd.hAdd", "HAdd.hAdd"),
  ("HDiv.hDiv", "HDiv.hDiv"),
  ("HMul.hMul", "HMul.hMul"),
  ("HasQuotient.Quotient", "HasQuotient.Quotient"),
  ("InnerProductSpace", "InnerProductSpace"),
  ("InnerProductSpace.toDual", "InnerProductSpace.toDual"),
  ("Inter.inter", "Inter.inter"),
  ("LE.le", "LE.le"),
  ("LT.lt", "LT.lt"),
  ("LinearEquiv", "LinearEquiv"),
  ("LinearIsometryEquiv", "LinearIsometryEquiv"),
  ("LinearIsometryEquiv.symm", "LinearIsometryEquiv.symm"),
  ("Measurable", "Measurable"),
  ("MeasurableSet", "MeasurableSet"),
  ("MeasurableSpace", "MeasurableSpace"),
  ("MeasureTheory.AEEqFun", "MeasureTheory.AEEqFun"),
  ("MeasureTheory.AEEqFun.cast", "MeasureTheory.AEEqFun.cast"),
  ("MeasureTheory.Lp", "MeasureTheory.Lp"),
  ("MeasureTheory.Measure", "MeasureTheory.Measure"),
  ("MeasureTheory.Measure.prod", "MeasureTheory.Measure.prod"),
  ("MeasureTheory.Measure.restrict", "MeasureTheory.Measure.restrict"),
  ("MeasureTheory.Measure.support", "MeasureTheory.Measure.support"),
  ("MeasureTheory.MeasureSpace.toMeasurableSpace", "MeasureTheory.MeasureSpace.toMeasurableSpace"),
  ("MeasureTheory.MeasureSpace.volume", "MeasureTheory.MeasureSpace.volume"),
  ("MeasureTheory.MemLp.toLp", "MeasureTheory.MemLp.toLp"),
  ("MeasureTheory.ae", "MeasureTheory.ae"),
  ("Membership.mem", "Membership.mem"),
  ("Metric.closedBall", "Metric.closedBall"),
  ("Nat", "Nat"),
  ("Ne", "Ne"),
  ("Norm.norm", "Norm.norm"),
  ("NormedAddCommGroup", "NormedAddCommGroup"),
  ("Not", "Not"),
  ("OfNat.ofNat", "OfNat.ofNat"),
  ("Prod", "Prod"),
  ("Prod.fst", "Prod.fst"),
  ("Prod.mk", "Prod.mk"),
  ("Prod.snd", "Prod.snd"),
  ("QuotientAddGroup.measurableSpace", "QuotientAddGroup.measurableSpace"),
  ("QuotientAddGroup.mk", "QuotientAddGroup.mk"),
  ("Real", "Real"),
  ("Real.pi", "Real.pi"),
  ("RingHom.id", "RingHom.id"),
  ("SDiff.sdiff", "SDiff.sdiff"),
  ("Set", "Set"),
  ("Set.Countable", "Set.Countable"),
  ("Set.Ioi", "Set.Ioi"),
  ("Set.domRestrict", "Set.domRestrict"),
  ("Set.iUnion", "Set.iUnion"),
  ("Set.ofPred", "Set.ofPred"),
  ("Set.preimage", "Set.preimage"),
  ("StrongDual", "StrongDual"),
  ("StrongDual.toWeakDual", "StrongDual.toWeakDual"),
  ("Submonoid", "Submonoid"),
  ("Submonoid.unitSphere", "Submonoid.unitSphere"),
  ("Subtype", "Subtype"),
  ("Subtype.mk", "Subtype.mk"),
  ("Subtype.val", "Subtype.val"),
  ("Union.union", "Union.union"),
  ("WeakDual", "WeakDual"),
  ("WeakDual.toStrongDual", "WeakDual.toStrongDual"),
  ("closure", "closure"),
  ("ite", "ite"),
  ("nhds", "nhds"),
  ("nhdsWithin", "nhdsWithin"),
  ("starRingEnd", "starRingEnd")]

-- UNFOLDED, checked by the kernel at the release's pin: `Filter.EventuallySubset l s t` is `Filter.EventuallyLE l s t` at `Prop`, by definition.
example {α : Type u} (l : Filter α) (s t : Set α) :
    Filter.EventuallySubset l s t = @Filter.EventuallyLE α Prop Prop.le l s t := rfl
example {α : Type u} [MeasurableSpace α] (μ : MeasureTheory.Measure α) (s t : Set α) :
    (s ≤ᵐ[μ] t) = @Filter.EventuallyLE α Prop Prop.le (MeasureTheory.ae μ) s t := rfl
