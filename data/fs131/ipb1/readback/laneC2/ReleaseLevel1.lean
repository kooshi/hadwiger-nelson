import OAI.MeasureTheory.CompactFactors.Factors
import OAI.MeasureTheory.CompactFactors.RelativeProducts
import OAI.MeasureTheory.CompactFactors.Separability
import OAI.MeasureTheory.CompactFactors.Stationary
import OAI.MeasureTheory.CompactFactors.AlgebraModels
-- FS131-IPA1 (generated): level one at the RELEASE's pin.
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

#eval FS132I2.runLevel1 [("AddAction", "AddAction"),
  ("AddCommGroup", "AddCommGroup"),
  ("AddCommMonoid", "AddCommMonoid"),
  ("AddGroup", "AddGroup"),
  ("AddHom.mk", "AddHom.mk"),
  ("AddMonoidHom", "AddMonoidHom"),
  ("AddMonoidHom.id", "AddMonoidHom.id"),
  ("AddSemigroup", "AddSemigroup"),
  ("AddSemigroupAction", "AddSemigroupAction"),
  ("AddSubgroup", "AddSubgroup"),
  ("AddSubgroupClass", "AddSubgroupClass"),
  ("AddSubmonoidClass", "AddSubmonoidClass"),
  ("Algebra.algebraMap", "Algebra.algebraMap"),
  ("And", "And"),
  ("BorelSpace", "BorelSpace"),
  ("BoundedAdd", "BoundedAdd"),
  ("BoundedContinuousFunction", "BoundedContinuousFunction"),
  ("BoundedContinuousFunction.ofNormedAddCommGroup", "BoundedContinuousFunction.ofNormedAddCommGroup"),
  ("Circle", "Circle"),
  ("CoeFun", "CoeFun"),
  ("CoeFun.mk", "CoeFun.mk"),
  ("CommRing", "CommRing"),
  ("CompactSpace", "CompactSpace"),
  ("CompactlySupportedContinuousMap", "CompactlySupportedContinuousMap"),
  ("CompactlySupportedContinuousMap.toContinuousMap", "CompactlySupportedContinuousMap.toContinuousMap"),
  ("CompleteSpace", "CompleteSpace"),
  ("Complex", "Complex"),
  ("Complex.instCommSemiring", "Complex.instCommSemiring"),
  ("Complex.ofReal", "Complex.ofReal"),
  ("Complex.re", "Complex.re"),
  ("Continuous", "Continuous"),
  ("ContinuousAdd", "ContinuousAdd"),
  ("ContinuousConstSMul", "ContinuousConstSMul"),
  ("ContinuousLinearMap", "ContinuousLinearMap"),
  ("ContinuousLinearMap.comp", "ContinuousLinearMap.comp"),
  ("ContinuousMap", "ContinuousMap"),
  ("ContinuousMap.comp", "ContinuousMap.comp"),
  ("ContinuousMap.const", "ContinuousMap.const"),
  ("ContinuousMap.mk", "ContinuousMap.mk"),
  ("Countable", "Countable"),
  ("DFunLike.coe", "DFunLike.coe"),
  ("DecidableEq", "DecidableEq"),
  ("DecidablePred", "DecidablePred"),
  ("DiscreteTopology", "DiscreteTopology"),
  ("Dist.dist", "Dist.dist"),
  ("ENNReal", "ENNReal"),
  ("EmptyCollection.emptyCollection", "EmptyCollection.emptyCollection"),
  ("Eq", "Eq"),
  ("Eq.ndrec", "Eq.ndrec"),
  ("Equiv", "Equiv"),
  ("Equiv.mk", "Equiv.mk"),
  ("Equiv.topologicalSpace", "Equiv.topologicalSpace"),
  ("ErgodicSMul", "ErgodicSMul"),
  ("ErgodicVAdd", "ErgodicVAdd"),
  ("Exists", "Exists"),
  ("Exists.choose", "Exists.choose"),
  ("False", "False"),
  ("Filter.Eventually", "Filter.Eventually"),
  ("Filter.EventuallyEq", "Filter.EventuallyEq"),
  ("Filter.EventuallySubset", "Filter.EventuallySubset"),
  ("Fin", "Fin"),
  ("Fin.val", "Fin.val"),
  ("Finset", "Finset"),
  ("Finset.card", "Finset.card"),
  ("Finset.erase", "Finset.erase"),
  ("Finset.filter", "Finset.filter"),
  ("Finset.powerset", "Finset.powerset"),
  ("Finset.prod", "Finset.prod"),
  ("Finset.sum", "Finset.sum"),
  ("Function.Injective", "Function.Injective"),
  ("Function.Surjective", "Function.Surjective"),
  ("Function.comp", "Function.comp"),
  ("Group", "Group"),
  ("HAdd.hAdd", "HAdd.hAdd"),
  ("HEq", "HEq"),
  ("HMul.hMul", "HMul.hMul"),
  ("HPow.hPow", "HPow.hPow"),
  ("HSMul.hSMul", "HSMul.hSMul"),
  ("HSub.hSub", "HSub.hSub"),
  ("HVAdd.hVAdd", "HVAdd.hVAdd"),
  ("Homeomorph", "Homeomorph"),
  ("Iff", "Iff"),
  ("Inhabited", "Inhabited"),
  ("Inhabited.mk", "Inhabited.mk"),
  ("Inner.inner", "Inner.inner"),
  ("InnerProductSpace", "InnerProductSpace"),
  ("Int", "Int"),
  ("IsBoundedSMul", "IsBoundedSMul"),
  ("IsClosed", "IsClosed"),
  ("IsMax", "IsMax"),
  ("IsTopologicalAddGroup", "IsTopologicalAddGroup"),
  ("LE.le", "LE.le"),
  ("LT.lt", "LT.lt"),
  ("LinearIsometryEquiv", "LinearIsometryEquiv"),
  ("LinearMap", "LinearMap"),
  ("LinearMap.mk", "LinearMap.mk"),
  ("LocallyCompactSpace", "LocallyCompactSpace"),
  ("Measurable", "Measurable"),
  ("MeasurableConstSMul", "MeasurableConstSMul"),
  ("MeasurableConstVAdd", "MeasurableConstVAdd"),
  ("MeasurableEmbedding", "MeasurableEmbedding"),
  ("MeasurableEmbedding.invFun", "MeasurableEmbedding.invFun"),
  ("MeasurableSpace", "MeasurableSpace"),
  ("MeasurableSpace.CountablyGenerated", "MeasurableSpace.CountablyGenerated"),
  ("MeasurableSpace.CountablySeparated", "MeasurableSpace.CountablySeparated"),
  ("MeasurableSpace.comap", "MeasurableSpace.comap"),
  ("MeasurableSpace.pi", "MeasurableSpace.pi"),
  ("MeasureTheory.AEEqFun", "MeasureTheory.AEEqFun"),
  ("MeasureTheory.AEEqFun.cast", "MeasureTheory.AEEqFun.cast"),
  ("MeasureTheory.Integrable", "MeasureTheory.Integrable"),
  ("MeasureTheory.IsFiniteMeasure", "MeasureTheory.IsFiniteMeasure"),
  ("MeasureTheory.IsProbabilityMeasure", "MeasureTheory.IsProbabilityMeasure"),
  ("MeasureTheory.Lp", "MeasureTheory.Lp"),
  ("MeasureTheory.Measure", "MeasureTheory.Measure"),
  ("MeasureTheory.Measure.Regular", "MeasureTheory.Measure.Regular"),
  ("MeasureTheory.Measure.bind", "MeasureTheory.Measure.bind"),
  ("MeasureTheory.Measure.compProd", "MeasureTheory.Measure.compProd"),
  ("MeasureTheory.Measure.map", "MeasureTheory.Measure.map"),
  ("MeasureTheory.Measure.prod", "MeasureTheory.Measure.prod"),
  ("MeasureTheory.MeasurePreserving", "MeasureTheory.MeasurePreserving"),
  ("MeasureTheory.SFinite", "MeasureTheory.SFinite"),
  ("MeasureTheory.VAddInvariantMeasure", "MeasureTheory.VAddInvariantMeasure"),
  ("MeasureTheory.ae", "MeasureTheory.ae"),
  ("MeasureTheory.condExpL2", "MeasureTheory.condExpL2"),
  ("MeasureTheory.embeddingReal", "MeasureTheory.embeddingReal"),
  ("MeasureTheory.integral", "MeasureTheory.integral"),
  ("MeasureTheory.lpMeas", "MeasureTheory.lpMeas"),
  ("Membership.mem", "Membership.mem"),
  ("Module", "Module"),
  ("Module.complexToReal", "Module.complexToReal"),
  ("Monoid", "Monoid"),
  ("Monotone", "Monotone"),
  ("MulAction", "MulAction"),
  ("MulAction.mk", "MulAction.mk"),
  ("NNReal", "NNReal"),
  ("NNReal.toReal", "NNReal.toReal"),
  ("Nat", "Nat"),
  ("Nat.AtLeastTwo", "Nat.AtLeastTwo"),
  ("Ne", "Ne"),
  ("Neg.neg", "Neg.neg"),
  ("Nonempty", "Nonempty"),
  ("Norm.norm", "Norm.norm"),
  ("NormedAddCommGroup", "NormedAddCommGroup"),
  ("NormedSpace", "NormedSpace"),
  ("Not", "Not"),
  ("OfNat.ofNat", "OfNat.ofNat"),
  ("Or", "Or"),
  ("PUnit.instMeasurableSpace", "PUnit.instMeasurableSpace"),
  ("PolishSpace", "PolishSpace"),
  ("PositiveLinearMap", "PositiveLinearMap"),
  ("PositiveLinearMap.mk", "PositiveLinearMap.mk"),
  ("Preorder", "Preorder"),
  ("Preorder.mk", "Preorder.mk"),
  ("ProbabilityTheory.IsMarkovKernel", "ProbabilityTheory.IsMarkovKernel"),
  ("ProbabilityTheory.Kernel", "ProbabilityTheory.Kernel"),
  ("ProbabilityTheory.Kernel.comap", "ProbabilityTheory.Kernel.comap"),
  ("ProbabilityTheory.Kernel.comp", "ProbabilityTheory.Kernel.comp"),
  ("ProbabilityTheory.Kernel.const", "ProbabilityTheory.Kernel.const"),
  ("ProbabilityTheory.Kernel.prod", "ProbabilityTheory.Kernel.prod"),
  ("ProbabilityTheory.condDistrib", "ProbabilityTheory.condDistrib"),
  ("Prod", "Prod"),
  ("Prod.fst", "Prod.fst"),
  ("Prod.instMeasurableSpace", "Prod.instMeasurableSpace"),
  ("Prod.mk", "Prod.mk"),
  ("Prod.snd", "Prod.snd"),
  ("Real", "Real"),
  ("Real.arctan", "Real.arctan"),
  ("RealRMK.rieszMeasure", "RealRMK.rieszMeasure"),
  ("RingHom", "RingHom"),
  ("RingHom.id", "RingHom.id"),
  ("SDiff.sdiff", "SDiff.sdiff"),
  ("SecondCountableTopology", "SecondCountableTopology"),
  ("Semiring", "Semiring"),
  ("Set", "Set"),
  ("Set.Elem", "Set.Elem"),
  ("Set.InjOn", "Set.InjOn"),
  ("Set.Nonempty", "Set.Nonempty"),
  ("Set.ofPred", "Set.ofPred"),
  ("SetLike.coe", "SetLike.coe"),
  ("StandardBorelSpace", "StandardBorelSpace"),
  ("Subalgebra", "Subalgebra"),
  ("Subalgebra.mk", "Subalgebra.mk"),
  ("Subgroup", "Subgroup"),
  ("Submodule", "Submodule"),
  ("Submodule.subtypeL", "Submodule.subtypeL"),
  ("Submonoid.mk", "Submonoid.mk"),
  ("Subsemigroup.mk", "Subsemigroup.mk"),
  ("Subsemiring.mk", "Subsemiring.mk"),
  ("Subtype", "Subtype"),
  ("Subtype.mk", "Subtype.mk"),
  ("Subtype.val", "Subtype.val"),
  ("T2Space", "T2Space"),
  ("TopologicalSpace", "TopologicalSpace"),
  ("Unit", "Unit"),
  ("Unit.unit", "Unit.unit"),
  ("abs", "abs"),
  ("borel", "borel"),
  ("iSup", "iSup"),
  ("id", "id"),
  ("inferInstance", "inferInstance"),
  ("ite", "ite")]

-- FS131-IPB1, EQSET: checked by the kernel at the RELEASE's pin — `Filter.EventuallyEqSet l s t` is
-- `Filter.EventuallyEq l s t` at `Prop`, by definition (a set is `α → Prop`).
example {α : Type u} (l : Filter α) (s t : Set α) :
    Filter.EventuallyEqSet l s t = @Filter.EventuallyEq α Prop l s t := rfl
example {α : Type u} [MeasurableSpace α] (μ : MeasureTheory.Measure α) (s t : Set α) :
    (s =ᵐ[μ] t) = @Filter.EventuallyEq α Prop (MeasureTheory.ae μ) s t := rfl
-- its control: a different right-hand side must be refused (`s` and `tᶜ`); the error is expected, read in the log
example {α : Type u} (l : Filter α) (s t : Set α) :
    Filter.EventuallyEqSet l s t = @Filter.EventuallyEq α Prop l s tᶜ := rfl
