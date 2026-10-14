import OAI.MeasureTheory.CompactFactors.Amenability
import OAI.Analysis.PlaneSpectrum.NumberFields
import OAI.Analysis.PlaneSpectrum.Selections
import OAI.MeasureTheory.CompactFactors.Centers
import OAI.MeasureTheory.CompactFactors.RelativeCenters
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
  ("AddGroup", "AddGroup"),
  ("AddHom.mk", "AddHom.mk"),
  ("AddMonoidAlgebra.coeff", "AddMonoidAlgebra.coeff"),
  ("AddMonoidAlgebra.ofCoeff", "AddMonoidAlgebra.ofCoeff"),
  ("AddRightMono", "AddRightMono"),
  ("AddSemigroup", "AddSemigroup"),
  ("AddSemigroupAction", "AddSemigroupAction"),
  ("AddSubgroup", "AddSubgroup"),
  ("AddSubgroupClass", "AddSubgroupClass"),
  ("Algebra", "Algebra"),
  ("Algebra.algebraMap", "Algebra.algebraMap"),
  ("And", "And"),
  ("BorelSpace", "BorelSpace"),
  ("BoundedContinuousFunction", "BoundedContinuousFunction"),
  ("BoundedContinuousFunction.compContinuous", "BoundedContinuousFunction.compContinuous"),
  ("BoundedContinuousFunction.const", "BoundedContinuousFunction.const"),
  ("BoundedContinuousFunction.ofNormedAddCommGroup", "BoundedContinuousFunction.ofNormedAddCommGroup"),
  ("BoundedMul", "BoundedMul"),
  ("CharZero", "CharZero"),
  ("Circle", "Circle"),
  ("CommGroup", "CommGroup"),
  ("CompleteSpace", "CompleteSpace"),
  ("Complex", "Complex"),
  ("Complex.I", "Complex.I"),
  ("Complex.im", "Complex.im"),
  ("Complex.measurableSpace", "Complex.measurableSpace"),
  ("Complex.ofReal", "Complex.ofReal"),
  ("Complex.ofRealHom", "Complex.ofRealHom"),
  ("Complex.re", "Complex.re"),
  ("Continuous", "Continuous"),
  ("ContinuousAdd", "ContinuousAdd"),
  ("ContinuousConstSMul", "ContinuousConstSMul"),
  ("ContinuousLinearMap", "ContinuousLinearMap"),
  ("ContinuousLinearMap.compLeftContinuousBounded", "ContinuousLinearMap.compLeftContinuousBounded"),
  ("ContinuousMap.mk", "ContinuousMap.mk"),
  ("ContinuousMul", "ContinuousMul"),
  ("DFunLike.coe", "DFunLike.coe"),
  ("DecidableEq", "DecidableEq"),
  ("DiscreteTopology", "DiscreteTopology"),
  ("ENNReal", "ENNReal"),
  ("Eq", "Eq"),
  ("Eq.ndrec", "Eq.ndrec"),
  ("Equiv", "Equiv"),
  ("ErgodicSMul", "ErgodicSMul"),
  ("ErgodicVAdd", "ErgodicVAdd"),
  ("Exists", "Exists"),
  ("Exists.choose", "Exists.choose"),
  ("ExistsUnique", "ExistsUnique"),
  ("False", "False"),
  ("Field", "Field"),
  ("Filter.Eventually", "Filter.Eventually"),
  ("Filter.EventuallyEq", "Filter.EventuallyEq"),
  ("Filter.EventuallySubset", "Filter.EventuallySubset"),
  ("Filter.Tendsto", "Filter.Tendsto"),
  ("Filter.atTop", "Filter.atTop"),
  ("Filter.cocompact", "Filter.cocompact"),
  ("Fin", "Fin"),
  ("FiniteDimensional", "FiniteDimensional"),
  ("Finset", "Finset"),
  ("Finset.Nonempty", "Finset.Nonempty"),
  ("Finset.card", "Finset.card"),
  ("Finset.filter", "Finset.filter"),
  ("Finset.image", "Finset.image"),
  ("Finset.sum", "Finset.sum"),
  ("Finset.univ", "Finset.univ"),
  ("Finsupp.mapRange", "Finsupp.mapRange"),
  ("Fintype", "Fintype"),
  ("Function.Injective", "Function.Injective"),
  ("Function.comp", "Function.comp"),
  ("Function.extend", "Function.extend"),
  ("Group", "Group"),
  ("HAdd.hAdd", "HAdd.hAdd"),
  ("HDiv.hDiv", "HDiv.hDiv"),
  ("HEq", "HEq"),
  ("HMul.hMul", "HMul.hMul"),
  ("HPow.hPow", "HPow.hPow"),
  ("HSMul.hSMul", "HSMul.hSMul"),
  ("HSub.hSub", "HSub.hSub"),
  ("HVAdd.hVAdd", "HVAdd.hVAdd"),
  ("HasQuotient.Quotient", "HasQuotient.Quotient"),
  ("Iff", "Iff"),
  ("Inner.inner", "Inner.inner"),
  ("InnerProductSpace", "InnerProductSpace"),
  ("InnerProductSpace.toDual", "InnerProductSpace.toDual"),
  ("Insert.insert", "Insert.insert"),
  ("Int", "Int"),
  ("Int.casesOn", "Int.casesOn"),
  ("Int.cast", "Int.cast"),
  ("Int.natAbs", "Int.natAbs"),
  ("Int.negSucc", "Int.negSucc"),
  ("Int.ofNat", "Int.ofNat"),
  ("Inter.inter", "Inter.inter"),
  ("IntermediateField", "IntermediateField"),
  ("IntermediateField.adjoin", "IntermediateField.adjoin"),
  ("IntermediateField.toSubfield", "IntermediateField.toSubfield"),
  ("Inv.inv", "Inv.inv"),
  ("IsAlgebraic", "IsAlgebraic"),
  ("IsBoundedSMul", "IsBoundedSMul"),
  ("IsClosed", "IsClosed"),
  ("IsStrictOrderedRing", "IsStrictOrderedRing"),
  ("IsTopologicalAddGroup", "IsTopologicalAddGroup"),
  ("LE", "LE"),
  ("LE.le", "LE.le"),
  ("LT.lt", "LT.lt"),
  ("LinearIndepOn", "LinearIndepOn"),
  ("LinearIsometry", "LinearIsometry"),
  ("LinearIsometry.mk", "LinearIsometry.mk"),
  ("LinearIsometry.toLinearIsometryEquiv", "LinearIsometry.toLinearIsometryEquiv"),
  ("LinearIsometryEquiv", "LinearIsometryEquiv"),
  ("LinearIsometryEquiv.ofSurjective", "LinearIsometryEquiv.ofSurjective"),
  ("LinearIsometryEquiv.symm", "LinearIsometryEquiv.symm"),
  ("LinearMap", "LinearMap"),
  ("LinearMap.mk", "LinearMap.mk"),
  ("LinearMap.mkContinuous", "LinearMap.mkContinuous"),
  ("LinearOrder", "LinearOrder"),
  ("LipschitzWith", "LipschitzWith"),
  ("List", "List"),
  ("List.length", "List.length"),
  ("List.replicate", "List.replicate"),
  ("List.sum", "List.sum"),
  ("Measurable", "Measurable"),
  ("MeasurableConstSMul", "MeasurableConstSMul"),
  ("MeasurableConstVAdd", "MeasurableConstVAdd"),
  ("MeasurableEmbedding", "MeasurableEmbedding"),
  ("MeasurableEquiv", "MeasurableEquiv"),
  ("MeasurableEquiv.symm", "MeasurableEquiv.symm"),
  ("MeasurableInv", "MeasurableInv"),
  ("MeasurableMul₂", "MeasurableMul₂"),
  ("MeasurableSet", "MeasurableSet"),
  ("MeasurableSingletonClass", "MeasurableSingletonClass"),
  ("MeasurableSpace", "MeasurableSpace"),
  ("MeasurableSpace.CountablySeparated", "MeasurableSpace.CountablySeparated"),
  ("MeasureTheory.AEEqFun", "MeasureTheory.AEEqFun"),
  ("MeasureTheory.AEEqFun.cast", "MeasureTheory.AEEqFun.cast"),
  ("MeasureTheory.Integrable", "MeasureTheory.Integrable"),
  ("MeasureTheory.IsFiniteMeasure", "MeasureTheory.IsFiniteMeasure"),
  ("MeasureTheory.IsProbabilityMeasure", "MeasureTheory.IsProbabilityMeasure"),
  ("MeasureTheory.Lp", "MeasureTheory.Lp"),
  ("MeasureTheory.Lp.compMeasurePreservingₗᵢ", "MeasureTheory.Lp.compMeasurePreservingₗᵢ"),
  ("MeasureTheory.Measure", "MeasureTheory.Measure"),
  ("MeasureTheory.Measure.bind", "MeasureTheory.Measure.bind"),
  ("MeasureTheory.Measure.compProd", "MeasureTheory.Measure.compProd"),
  ("MeasureTheory.Measure.dirac", "MeasureTheory.Measure.dirac"),
  ("MeasureTheory.Measure.map", "MeasureTheory.Measure.map"),
  ("MeasureTheory.Measure.real", "MeasureTheory.Measure.real"),
  ("MeasureTheory.Measure.restrict", "MeasureTheory.Measure.restrict"),
  ("MeasureTheory.MeasurePreserving", "MeasureTheory.MeasurePreserving"),
  ("MeasureTheory.ProbabilityMeasure", "MeasureTheory.ProbabilityMeasure"),
  ("MeasureTheory.ProbabilityMeasure.map", "MeasureTheory.ProbabilityMeasure.map"),
  ("MeasureTheory.ProbabilityMeasure.toMeasure", "MeasureTheory.ProbabilityMeasure.toMeasure"),
  ("MeasureTheory.SFinite", "MeasureTheory.SFinite"),
  ("MeasureTheory.SMulInvariantMeasure", "MeasureTheory.SMulInvariantMeasure"),
  ("MeasureTheory.VAddInvariantMeasure", "MeasureTheory.VAddInvariantMeasure"),
  ("MeasureTheory.ae", "MeasureTheory.ae"),
  ("MeasureTheory.integral", "MeasureTheory.integral"),
  ("MeasureTheory.lintegral", "MeasureTheory.lintegral"),
  ("Membership.mem", "Membership.mem"),
  ("Metric.closedBall", "Metric.closedBall"),
  ("Module", "Module"),
  ("Module.finrank", "Module.finrank"),
  ("MonoidHom", "MonoidHom"),
  ("MonoidHom.mk", "MonoidHom.mk"),
  ("MonoidHom.range", "MonoidHom.range"),
  ("MulAction", "MulAction"),
  ("MulDistribMulAction", "MulDistribMulAction"),
  ("MulDistribMulAction.mk", "MulDistribMulAction.mk"),
  ("MulEquiv", "MulEquiv"),
  ("Multiplicative", "Multiplicative"),
  ("Multiplicative.ofAdd", "Multiplicative.ofAdd"),
  ("NNReal", "NNReal"),
  ("Nat", "Nat"),
  ("Nat.AtLeastTwo", "Nat.AtLeastTwo"),
  ("Nat.cast", "Nat.cast"),
  ("Ne", "Ne"),
  ("Neg.neg", "Neg.neg"),
  ("Nonempty", "Nonempty"),
  ("Norm.norm", "Norm.norm"),
  ("NormedAddCommGroup", "NormedAddCommGroup"),
  ("Not", "Not"),
  ("OfNat.ofNat", "OfNat.ofNat"),
  ("OneHom.mk", "OneHom.mk"),
  ("OneMemClass", "OneMemClass"),
  ("Or", "Or"),
  ("Polynomial", "Polynomial"),
  ("Polynomial.C", "Polynomial.C"),
  ("Polynomial.X", "Polynomial.X"),
  ("Polynomial.coeff", "Polynomial.coeff"),
  ("Polynomial.eval", "Polynomial.eval"),
  ("Polynomial.map", "Polynomial.map"),
  ("Polynomial.monomial", "Polynomial.monomial"),
  ("Polynomial.ofFinsupp", "Polynomial.ofFinsupp"),
  ("Polynomial.reverse", "Polynomial.reverse"),
  ("Polynomial.toFinsupp", "Polynomial.toFinsupp"),
  ("ProbabilityTheory.IsMarkovKernel", "ProbabilityTheory.IsMarkovKernel"),
  ("ProbabilityTheory.IsSFiniteKernel", "ProbabilityTheory.IsSFiniteKernel"),
  ("ProbabilityTheory.Kernel", "ProbabilityTheory.Kernel"),
  ("ProbabilityTheory.Kernel.comap", "ProbabilityTheory.Kernel.comap"),
  ("ProbabilityTheory.Kernel.id", "ProbabilityTheory.Kernel.id"),
  ("ProbabilityTheory.Kernel.map", "ProbabilityTheory.Kernel.map"),
  ("ProbabilityTheory.Kernel.mk", "ProbabilityTheory.Kernel.mk"),
  ("ProbabilityTheory.Kernel.prod", "ProbabilityTheory.Kernel.prod"),
  ("ProbabilityTheory.cond", "ProbabilityTheory.cond"),
  ("ProbabilityTheory.condDistrib", "ProbabilityTheory.condDistrib"),
  ("Prod", "Prod"),
  ("Prod.fst", "Prod.fst"),
  ("Prod.instMeasurableSpace", "Prod.instMeasurableSpace"),
  ("Prod.map", "Prod.map"),
  ("Prod.mk", "Prod.mk"),
  ("Prod.snd", "Prod.snd"),
  ("PseudoMetricSpace", "PseudoMetricSpace"),
  ("QuotientGroup.mk", "QuotientGroup.mk"),
  ("Rat", "Rat"),
  ("Rat.commSemiring", "Rat.commSemiring"),
  ("Real", "Real"),
  ("Real.sqrt", "Real.sqrt"),
  ("RingHom", "RingHom"),
  ("RingHom.id", "RingHom.id"),
  ("RingHom.mk", "RingHom.mk"),
  ("RingHomInvPair", "RingHomInvPair"),
  ("RingHomIsometric", "RingHomIsometric"),
  ("SMul", "SMul"),
  ("SMulCommClass", "SMulCommClass"),
  ("SameRay", "SameRay"),
  ("Set", "Set"),
  ("Set.Ico", "Set.Ico"),
  ("Set.Nonempty", "Set.Nonempty"),
  ("Set.ofPred", "Set.ofPred"),
  ("Set.preimage", "Set.preimage"),
  ("Set.range", "Set.range"),
  ("Set.univ", "Set.univ"),
  ("SetLike.coe", "SetLike.coe"),
  ("Singleton.singleton", "Singleton.singleton"),
  ("StandardBorelSpace", "StandardBorelSpace"),
  ("StrictConvexOn", "StrictConvexOn"),
  ("StrongDual", "StrongDual"),
  ("Subfield", "Subfield"),
  ("Subfield.comap", "Subfield.comap"),
  ("Subgroup", "Subgroup"),
  ("SubgroupClass", "SubgroupClass"),
  ("Submodule", "Submodule"),
  ("Submodule.span", "Submodule.span"),
  ("Submonoid", "Submonoid"),
  ("Submonoid.unitSphere", "Submonoid.unitSphere"),
  ("SubmonoidClass", "SubmonoidClass"),
  ("SubsemiringClass", "SubsemiringClass"),
  ("Subtype", "Subtype"),
  ("Subtype.mk", "Subtype.mk"),
  ("Subtype.val", "Subtype.val"),
  ("Top.top", "Top.top"),
  ("TopologicalSpace", "TopologicalSpace"),
  ("TopologicalSpace.SeparableSpace", "TopologicalSpace.SeparableSpace"),
  ("TopologicalSpace.denseSeq", "TopologicalSpace.denseSeq"),
  ("Union.union", "Union.union"),
  ("WithLp", "WithLp"),
  ("WithLp.fst", "WithLp.fst"),
  ("WithLp.snd", "WithLp.snd"),
  ("WithLp.toLp", "WithLp.toLp"),
  ("abs", "abs"),
  ("dite", "dite"),
  ("iInf", "iInf"),
  ("id", "id"),
  ("ite", "ite"),
  ("minpoly", "minpoly"),
  ("starRingEnd", "starRingEnd")]
