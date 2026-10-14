import OAI.MeasureTheory.CompactFactors.Approximation
import OAI.MeasureTheory.CompactFactors.ConditionalLimits
import OAI.MeasureTheory.CompactFactors.Kernels
import OAI.MeasureTheory.CompactFactors.BoundedFunctions
import OAI.MeasureTheory.CompactFactors.Functions
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

#eval FS132I2.runLevel1 [("AddHom.mk", "AddHom.mk"),
  ("AddSubgroup", "AddSubgroup"),
  ("AddSubmonoidClass", "AddSubmonoidClass"),
  ("Algebra.algebraMap", "Algebra.algebraMap"),
  ("And", "And"),
  ("Bool", "Bool"),
  ("Bool.false", "Bool.false"),
  ("Bool.true", "Bool.true"),
  ("BorelSpace", "BorelSpace"),
  ("Circle", "Circle"),
  ("CoeFun", "CoeFun"),
  ("CoeFun.mk", "CoeFun.mk"),
  ("CommGroup", "CommGroup"),
  ("Compl.compl", "Compl.compl"),
  ("Complex", "Complex"),
  ("Complex.instCommSemiring", "Complex.instCommSemiring"),
  ("Complex.re", "Complex.re"),
  ("Continuous", "Continuous"),
  ("ContinuousAdd", "ContinuousAdd"),
  ("DFunLike.coe", "DFunLike.coe"),
  ("Dist.dist", "Dist.dist"),
  ("ENNReal", "ENNReal"),
  ("EmptyCollection.emptyCollection", "EmptyCollection.emptyCollection"),
  ("Eq", "Eq"),
  ("ErgodicSMul", "ErgodicSMul"),
  ("Exists", "Exists"),
  ("Exists.casesOn", "Exists.casesOn"),
  ("Exists.choose", "Exists.choose"),
  ("False", "False"),
  ("Filter.Eventually", "Filter.Eventually"),
  ("Filter.EventuallyConst", "Filter.EventuallyConst"),
  ("Filter.EventuallyEq", "Filter.EventuallyEq"),
  ("Filter.EventuallySubset", "Filter.EventuallySubset"),
  ("Filter.Tendsto", "Filter.Tendsto"),
  ("Filter.atTop", "Filter.atTop"),
  ("Fin", "Fin"),
  ("Fin.val", "Fin.val"),
  ("Finset", "Finset"),
  ("Finset.Nonempty", "Finset.Nonempty"),
  ("Finset.card", "Finset.card"),
  ("Finset.sum", "Finset.sum"),
  ("Finset.univ", "Finset.univ"),
  ("Fintype", "Fintype"),
  ("Function.comp", "Function.comp"),
  ("Group", "Group"),
  ("HAdd.hAdd", "HAdd.hAdd"),
  ("HDiv.hDiv", "HDiv.hDiv"),
  ("HMul.hMul", "HMul.hMul"),
  ("HPow.hPow", "HPow.hPow"),
  ("HSMul.hSMul", "HSMul.hSMul"),
  ("HSub.hSub", "HSub.hSub"),
  ("Iff", "Iff"),
  ("Inner.inner", "Inner.inner"),
  ("Inter.inter", "Inter.inter"),
  ("IntermediateField", "IntermediateField"),
  ("Inv.inv", "Inv.inv"),
  ("IsBoundedSMul", "IsBoundedSMul"),
  ("IsClosed", "IsClosed"),
  ("IsCompact", "IsCompact"),
  ("IsTopologicalAddGroup", "IsTopologicalAddGroup"),
  ("LE.le", "LE.le"),
  ("LT.lt", "LT.lt"),
  ("LinearMap", "LinearMap"),
  ("LinearMap.mk", "LinearMap.mk"),
  ("LipschitzWith", "LipschitzWith"),
  ("Max.max", "Max.max"),
  ("Measurable", "Measurable"),
  ("MeasurableConstSMul", "MeasurableConstSMul"),
  ("MeasurableInv", "MeasurableInv"),
  ("MeasurableMul₂", "MeasurableMul₂"),
  ("MeasurableSet", "MeasurableSet"),
  ("MeasurableSingletonClass", "MeasurableSingletonClass"),
  ("MeasurableSpace", "MeasurableSpace"),
  ("MeasurableSpace.CountablyGenerated", "MeasurableSpace.CountablyGenerated"),
  ("MeasurableSpace.comap", "MeasurableSpace.comap"),
  ("MeasurableSpace.mk", "MeasurableSpace.mk"),
  ("MeasurableSpace.natGeneratingSequence", "MeasurableSpace.natGeneratingSequence"),
  ("MeasureTheory.AEEqFun", "MeasureTheory.AEEqFun"),
  ("MeasureTheory.AEEqFun.cast", "MeasureTheory.AEEqFun.cast"),
  ("MeasureTheory.Filtration", "MeasureTheory.Filtration"),
  ("MeasureTheory.Integrable", "MeasureTheory.Integrable"),
  ("MeasureTheory.IsFiniteMeasure", "MeasureTheory.IsFiniteMeasure"),
  ("MeasureTheory.IsProbabilityMeasure", "MeasureTheory.IsProbabilityMeasure"),
  ("MeasureTheory.Lp", "MeasureTheory.Lp"),
  ("MeasureTheory.Measure", "MeasureTheory.Measure"),
  ("MeasureTheory.Measure.bind", "MeasureTheory.Measure.bind"),
  ("MeasureTheory.Measure.compProd", "MeasureTheory.Measure.compProd"),
  ("MeasureTheory.Measure.dirac", "MeasureTheory.Measure.dirac"),
  ("MeasureTheory.Measure.map", "MeasureTheory.Measure.map"),
  ("MeasureTheory.Measure.prod", "MeasureTheory.Measure.prod"),
  ("MeasureTheory.Measure.real", "MeasureTheory.Measure.real"),
  ("MeasureTheory.MeasurePreserving", "MeasureTheory.MeasurePreserving"),
  ("MeasureTheory.MemLp", "MeasureTheory.MemLp"),
  ("MeasureTheory.MemLp.toLp", "MeasureTheory.MemLp.toLp"),
  ("MeasureTheory.SMulInvariantMeasure", "MeasureTheory.SMulInvariantMeasure"),
  ("MeasureTheory.SimpleFunc", "MeasureTheory.SimpleFunc"),
  ("MeasureTheory.ae", "MeasureTheory.ae"),
  ("MeasureTheory.condExp", "MeasureTheory.condExp"),
  ("MeasureTheory.integral", "MeasureTheory.integral"),
  ("Membership.mem", "Membership.mem"),
  ("Metric.ball", "Metric.ball"),
  ("MetricSpace", "MetricSpace"),
  ("Min.min", "Min.min"),
  ("Monoid", "Monoid"),
  ("MonoidHom", "MonoidHom"),
  ("Monotone", "Monotone"),
  ("MulAction", "MulAction"),
  ("NNReal", "NNReal"),
  ("NNReal.toReal", "NNReal.toReal"),
  ("Nat", "Nat"),
  ("Nat.AtLeastTwo", "Nat.AtLeastTwo"),
  ("Nat.cast", "Nat.cast"),
  ("Neg.neg", "Neg.neg"),
  ("Nonempty", "Nonempty"),
  ("Norm.norm", "Norm.norm"),
  ("Not", "Not"),
  ("OfNat.ofNat", "OfNat.ofNat"),
  ("ProbabilityTheory.IsMarkovKernel", "ProbabilityTheory.IsMarkovKernel"),
  ("ProbabilityTheory.IsSFiniteKernel", "ProbabilityTheory.IsSFiniteKernel"),
  ("ProbabilityTheory.Kernel", "ProbabilityTheory.Kernel"),
  ("ProbabilityTheory.Kernel.comap", "ProbabilityTheory.Kernel.comap"),
  ("ProbabilityTheory.Kernel.prod", "ProbabilityTheory.Kernel.prod"),
  ("ProbabilityTheory.condDistrib", "ProbabilityTheory.condDistrib"),
  ("Prod", "Prod"),
  ("Prod.fst", "Prod.fst"),
  ("Prod.instMeasurableSpace", "Prod.instMeasurableSpace"),
  ("Prod.mk", "Prod.mk"),
  ("Prod.snd", "Prod.snd"),
  ("Prod.swap", "Prod.swap"),
  ("PseudoMetricSpace", "PseudoMetricSpace"),
  ("Rat", "Rat"),
  ("Real", "Real"),
  ("RingHom", "RingHom"),
  ("RingHom.id", "RingHom.id"),
  ("SMul", "SMul"),
  ("SecondCountableTopology", "SecondCountableTopology"),
  ("SeminormedAddCommGroup", "SeminormedAddCommGroup"),
  ("Set", "Set"),
  ("Set.iUnion", "Set.iUnion"),
  ("Set.indicator", "Set.indicator"),
  ("Set.ofPred", "Set.ofPred"),
  ("Set.preimage", "Set.preimage"),
  ("SetLike.coe", "SetLike.coe"),
  ("Singleton.singleton", "Singleton.singleton"),
  ("StandardBorelSpace", "StandardBorelSpace"),
  ("Star.star", "Star.star"),
  ("Subalgebra", "Subalgebra"),
  ("Subalgebra.mk", "Subalgebra.mk"),
  ("Subgroup", "Subgroup"),
  ("Submonoid", "Submonoid"),
  ("Submonoid.mk", "Submonoid.mk"),
  ("Submonoid.unitSphere", "Submonoid.unitSphere"),
  ("SubmonoidClass", "SubmonoidClass"),
  ("Subsemigroup.mk", "Subsemigroup.mk"),
  ("Subsemiring.mk", "Subsemiring.mk"),
  ("Subtype", "Subtype"),
  ("Subtype.mk", "Subtype.mk"),
  ("Subtype.val", "Subtype.val"),
  ("Union.union", "Union.union"),
  ("abs", "abs"),
  ("borel", "borel"),
  ("iSup", "iSup"),
  ("id", "id"),
  ("inferInstance", "inferInstance"),
  ("ite", "ite"),
  ("nhds", "nhds")]
