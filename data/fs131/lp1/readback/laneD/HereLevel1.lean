import Proofs.HadwigerNelson.Outside.OAI158Representations
import Proofs.HadwigerNelson.Outside.OAI158Energy
import Proofs.HadwigerNelson.Outside.OAI158SpectralMeasure
import Proofs.HadwigerNelson.Outside.OAI158RadialEnergy
import Proofs.HadwigerNelson.Outside.OAI158Ergodicity
import Proofs.HadwigerNelson.Outside.OAI158BorelTransfer
-- FS131-IPA1 (generated): level one at THIS library's pin.
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
  ("AddAction.mk", "AddAction.mk"),
  ("AddCommGroup", "AddCommGroup"),
  ("AddCommGroup.mk", "AddCommGroup.mk"),
  ("AddCommMonoid", "AddCommMonoid"),
  ("AddGroup", "AddGroup"),
  ("AddHom.mk", "AddHom.mk"),
  ("AddHom.toFun", "AddHom.toFun"),
  ("AddMonoid.nsmul_succ._autoParam", "AddMonoid.nsmul_succ._autoParam"),
  ("AddMonoid.nsmul_zero._autoParam", "AddMonoid.nsmul_zero._autoParam"),
  ("AddMonoidHom", "AddMonoidHom"),
  ("AddMonoidHomClass", "AddMonoidHomClass"),
  ("AddSemigroup", "AddSemigroup"),
  ("AddSemigroupAction", "AddSemigroupAction"),
  ("AddSubgroup", "AddSubgroup"),
  ("AddSubmonoid.mk", "AddSubmonoid.mk"),
  ("AddSubmonoidClass", "AddSubmonoidClass"),
  ("AddSubsemigroup.mk", "AddSubsemigroup.mk"),
  ("Additive", "Additive"),
  ("Additive.ofMul", "Additive.ofMul"),
  ("Additive.toMul", "Additive.toMul"),
  ("Algebra.algebraMap", "Algebra.algebraMap"),
  ("And", "And"),
  ("BorelSpace", "BorelSpace"),
  ("Bot.bot", "Bot.bot"),
  ("BoundedContinuousFunction", "BoundedContinuousFunction"),
  ("BoundedContinuousFunction.const", "BoundedContinuousFunction.const"),
  ("BoundedContinuousFunction.ofNormedAddCommGroup", "BoundedContinuousFunction.ofNormedAddCommGroup"),
  ("CStarRing", "CStarRing"),
  ("CharZero", "CharZero"),
  ("Circle", "Circle"),
  ("Classical.decEq", "Classical.decEq"),
  ("ClosureOperator", "ClosureOperator"),
  ("CommCStarAlgebra", "CommCStarAlgebra"),
  ("CommCStarAlgebra.mk", "CommCStarAlgebra.mk"),
  ("CommGroup", "CommGroup"),
  ("CommRing", "CommRing"),
  ("CompactSpace", "CompactSpace"),
  ("CompactlySupportedContinuousMap", "CompactlySupportedContinuousMap"),
  ("CompactlySupportedContinuousMap.toContinuousMap", "CompactlySupportedContinuousMap.toContinuousMap"),
  ("CompleteSpace", "CompleteSpace"),
  ("Complex", "Complex"),
  ("Complex.im", "Complex.im"),
  ("Complex.instCommSemiring", "Complex.instCommSemiring"),
  ("Complex.mk", "Complex.mk"),
  ("Complex.ofReal", "Complex.ofReal"),
  ("Complex.re", "Complex.re"),
  ("Continuous", "Continuous"),
  ("ContinuousAdd", "ContinuousAdd"),
  ("ContinuousConstSMul", "ContinuousConstSMul"),
  ("ContinuousLinearMap", "ContinuousLinearMap"),
  ("ContinuousLinearMap.toLinearMap", "ContinuousLinearMap.toLinearMap"),
  ("ContinuousMap", "ContinuousMap"),
  ("ContinuousMap.compStarAlgHom'", "ContinuousMap.compStarAlgHom'"),
  ("ContinuousMap.mk", "ContinuousMap.mk"),
  ("ContinuousMap.toLp", "ContinuousMap.toLp"),
  ("ContinuousMonoidHom.mk", "ContinuousMonoidHom.mk"),
  ("ContinuousMul", "ContinuousMul"),
  ("ContinuousStar", "ContinuousStar"),
  ("Countable", "Countable"),
  ("DFunLike.coe", "DFunLike.coe"),
  ("DecidableEq", "DecidableEq"),
  ("DecidablePred", "DecidablePred"),
  ("Dense", "Dense"),
  ("Dense.extend", "Dense.extend"),
  ("DiscreteTopology", "DiscreteTopology"),
  ("Dist.dist", "Dist.dist"),
  ("ENNReal", "ENNReal"),
  ("ENorm.enorm", "ENorm.enorm"),
  ("Eq", "Eq"),
  ("Eq.ndrec", "Eq.ndrec"),
  ("Equiv", "Equiv"),
  ("Equiv.mk", "Equiv.mk"),
  ("ErgodicSMul", "ErgodicSMul"),
  ("ErgodicVAdd", "ErgodicVAdd"),
  ("Exists", "Exists"),
  ("Exists.choose", "Exists.choose"),
  ("Filter.Eventually", "Filter.Eventually"),
  ("Filter.EventuallyEq", "Filter.EventuallyEq"),
  ("Filter.Tendsto", "Filter.Tendsto"),
  ("Filter.atTop", "Filter.atTop"),
  ("Filter.limUnder", "Filter.limUnder"),
  ("Filter.limsup", "Filter.limsup"),
  ("Fin", "Fin"),
  ("Finset", "Finset"),
  ("Finset.Nonempty", "Finset.Nonempty"),
  ("Finset.biUnion", "Finset.biUnion"),
  ("Finset.filter", "Finset.filter"),
  ("Finset.image", "Finset.image"),
  ("Finset.range", "Finset.range"),
  ("Finset.sum", "Finset.sum"),
  ("Finset.toList", "Finset.toList"),
  ("Finset.univ", "Finset.univ"),
  ("Fintype", "Fintype"),
  ("FunLike", "FunLike"),
  ("Function.Surjective", "Function.Surjective"),
  ("Function.comp", "Function.comp"),
  ("HAdd.hAdd", "HAdd.hAdd"),
  ("HDiv.hDiv", "HDiv.hDiv"),
  ("HEq", "HEq"),
  ("HMul.hMul", "HMul.hMul"),
  ("HPow.hPow", "HPow.hPow"),
  ("HSMul.hSMul", "HSMul.hSMul"),
  ("HSub.hSub", "HSub.hSub"),
  ("HVAdd.hVAdd", "HVAdd.hVAdd"),
  ("Homeomorph", "Homeomorph"),
  ("Homeomorph.mk", "Homeomorph.mk"),
  ("Homeomorph.toMeasurableEquiv", "Homeomorph.toMeasurableEquiv"),
  ("Iff", "Iff"),
  ("Inner.inner", "Inner.inner"),
  ("InnerProductSpace", "InnerProductSpace"),
  ("Int", "Int"),
  ("Int.natAbs", "Int.natAbs"),
  ("Int.negSucc", "Int.negSucc"),
  ("Inter.inter", "Inter.inter"),
  ("IntermediateField", "IntermediateField"),
  ("Inv.inv", "Inv.inv"),
  ("IsAddCommutative", "IsAddCommutative"),
  ("IsAlgebraic", "IsAlgebraic"),
  ("IsBoundedSMul", "IsBoundedSMul"),
  ("IsClosed", "IsClosed"),
  ("IsMulCommutative", "IsMulCommutative"),
  ("IsPiSystem", "IsPiSystem"),
  ("IsScalarTower", "IsScalarTower"),
  ("IsSemitopologicalSemiring", "IsSemitopologicalSemiring"),
  ("IsTopologicalAddGroup", "IsTopologicalAddGroup"),
  ("IsTopologicalSemiring", "IsTopologicalSemiring"),
  ("LE.le", "LE.le"),
  ("LT.lt", "LT.lt"),
  ("LinearEquiv.mk", "LinearEquiv.mk"),
  ("LinearIsometry", "LinearIsometry"),
  ("LinearIsometry.mk", "LinearIsometry.mk"),
  ("LinearIsometry.toLinearMap", "LinearIsometry.toLinearMap"),
  ("LinearIsometryEquiv", "LinearIsometryEquiv"),
  ("LinearIsometryEquiv.mk", "LinearIsometryEquiv.mk"),
  ("LinearMap", "LinearMap"),
  ("LinearMap.extendOfNorm", "LinearMap.extendOfNorm"),
  ("LinearMap.mk", "LinearMap.mk"),
  ("LinearMap.mkContinuous", "LinearMap.mkContinuous"),
  ("LinearMap.toAddHom", "LinearMap.toAddHom"),
  ("LipschitzWith", "LipschitzWith"),
  ("LipschitzWith.compLp", "LipschitzWith.compLp"),
  ("List", "List"),
  ("List.below", "List.below"),
  ("List.brecOn", "List.brecOn"),
  ("List.casesOn", "List.casesOn"),
  ("List.cons", "List.cons"),
  ("List.nil", "List.nil"),
  ("LocallyCompactSpace", "LocallyCompactSpace"),
  ("Max.max", "Max.max"),
  ("Measurable", "Measurable"),
  ("MeasurableConstSMul", "MeasurableConstSMul"),
  ("MeasurableConstVAdd", "MeasurableConstVAdd"),
  ("MeasurableEquiv", "MeasurableEquiv"),
  ("MeasurableEquiv.symm", "MeasurableEquiv.symm"),
  ("MeasurableSet", "MeasurableSet"),
  ("MeasurableSpace", "MeasurableSpace"),
  ("MeasurableSpace.CountablyGenerated", "MeasurableSpace.CountablyGenerated"),
  ("MeasurableSpace.generateFrom", "MeasurableSpace.generateFrom"),
  ("MeasurableSpace.natGeneratingSequence", "MeasurableSpace.natGeneratingSequence"),
  ("MeasureTheory.AEEqFun", "MeasureTheory.AEEqFun"),
  ("MeasureTheory.AEEqFun.cast", "MeasureTheory.AEEqFun.cast"),
  ("MeasureTheory.Integrable", "MeasureTheory.Integrable"),
  ("MeasureTheory.IsFiniteMeasure", "MeasureTheory.IsFiniteMeasure"),
  ("MeasureTheory.IsProbabilityMeasure", "MeasureTheory.IsProbabilityMeasure"),
  ("MeasureTheory.Lp", "MeasureTheory.Lp"),
  ("MeasureTheory.Lp.compMeasurePreserving", "MeasureTheory.Lp.compMeasurePreserving"),
  ("MeasureTheory.Lp.compMeasurePreservingₗᵢ", "MeasureTheory.Lp.compMeasurePreservingₗᵢ"),
  ("MeasureTheory.Measure", "MeasureTheory.Measure"),
  ("MeasureTheory.Measure.Regular", "MeasureTheory.Measure.Regular"),
  ("MeasureTheory.Measure.map", "MeasureTheory.Measure.map"),
  ("MeasureTheory.Measure.prod", "MeasureTheory.Measure.prod"),
  ("MeasureTheory.Measure.real", "MeasureTheory.Measure.real"),
  ("MeasureTheory.Measure.restrict", "MeasureTheory.Measure.restrict"),
  ("MeasureTheory.MeasurePreserving", "MeasureTheory.MeasurePreserving"),
  ("MeasureTheory.MeasureSpace.volume", "MeasureTheory.MeasureSpace.volume"),
  ("MeasureTheory.MemLp", "MeasureTheory.MemLp"),
  ("MeasureTheory.MemLp.toLp", "MeasureTheory.MemLp.toLp"),
  ("MeasureTheory.SFinite", "MeasureTheory.SFinite"),
  ("MeasureTheory.SMulInvariantMeasure", "MeasureTheory.SMulInvariantMeasure"),
  ("MeasureTheory.VAddInvariantMeasure", "MeasureTheory.VAddInvariantMeasure"),
  ("MeasureTheory.ae", "MeasureTheory.ae"),
  ("MeasureTheory.eLpNorm", "MeasureTheory.eLpNorm"),
  ("MeasureTheory.integral", "MeasureTheory.integral"),
  ("Membership.mem", "Membership.mem"),
  ("Min.min", "Min.min"),
  ("Module", "Module"),
  ("MonoidHom", "MonoidHom"),
  ("MonoidHom.mk", "MonoidHom.mk"),
  ("MulAction", "MulAction"),
  ("MulEquiv", "MulEquiv"),
  ("MulEquiv.symm", "MulEquiv.symm"),
  ("Multiplicative", "Multiplicative"),
  ("Multiplicative.ofAdd", "Multiplicative.ofAdd"),
  ("Multiplicative.toAdd", "Multiplicative.toAdd"),
  ("NNReal", "NNReal"),
  ("NNReal.toReal", "NNReal.toReal"),
  ("Nat", "Nat"),
  ("Nat.AtLeastTwo", "Nat.AtLeastTwo"),
  ("Nat.cast", "Nat.cast"),
  ("Nat.find", "Nat.find"),
  ("Nat.succ", "Nat.succ"),
  ("Ne", "Ne"),
  ("NeZero", "NeZero"),
  ("Neg.neg", "Neg.neg"),
  ("NegMemClass", "NegMemClass"),
  ("NonUnitalSubringClass", "NonUnitalSubringClass"),
  ("Nonempty", "Nonempty"),
  ("Norm.norm", "Norm.norm"),
  ("NormedAddCommGroup", "NormedAddCommGroup"),
  ("NormedSpace", "NormedSpace"),
  ("Not", "Not"),
  ("OfNat.ofNat", "OfNat.ofNat"),
  ("OneHom.mk", "OneHom.mk"),
  ("OpensMeasurableSpace", "OpensMeasurableSpace"),
  ("PontryaginDual", "PontryaginDual"),
  ("PositiveLinearMap", "PositiveLinearMap"),
  ("PositiveLinearMap.mk", "PositiveLinearMap.mk"),
  ("Preorder", "Preorder"),
  ("ProbabilityTheory.Kernel", "ProbabilityTheory.Kernel"),
  ("ProbabilityTheory.condDistrib", "ProbabilityTheory.condDistrib"),
  ("Prod", "Prod"),
  ("Prod.fst", "Prod.fst"),
  ("Prod.instMeasurableSpace", "Prod.instMeasurableSpace"),
  ("Prod.mk", "Prod.mk"),
  ("Prod.snd", "Prod.snd"),
  ("Rat", "Rat"),
  ("Real", "Real"),
  ("Real.sqrt", "Real.sqrt"),
  ("RealRMK.rieszMeasure", "RealRMK.rieszMeasure"),
  ("RingHom", "RingHom"),
  ("RingHom.id", "RingHom.id"),
  ("RingHomInvPair", "RingHomInvPair"),
  ("RingHomIsometric", "RingHomIsometric"),
  ("SMulCommClass", "SMulCommClass"),
  ("SMulMemClass", "SMulMemClass"),
  ("SecondCountableTopologyEither", "SecondCountableTopologyEither"),
  ("Semiring", "Semiring"),
  ("Set", "Set"),
  ("Set.Elem", "Set.Elem"),
  ("Set.iInter", "Set.iInter"),
  ("Set.indicator", "Set.indicator"),
  ("Set.ofPred", "setOf"),
  ("Set.preimage", "Set.preimage"),
  ("Set.range", "Set.range"),
  ("Set.univ", "Set.univ"),
  ("SetLike.coe", "SetLike.coe"),
  ("Singleton.singleton", "Singleton.singleton"),
  ("StandardBorelSpace", "StandardBorelSpace"),
  ("Star.star", "Star.star"),
  ("StarAlgEquiv", "StarAlgEquiv"),
  ("StarAlgEquiv.symm", "StarAlgEquiv.symm"),
  ("StarAlgEquiv.toStarAlgHom", "StarAlgEquiv.toStarAlgHom"),
  ("StarAlgHom", "StarAlgHom"),
  ("StarAlgHom.comp", "StarAlgHom.comp"),
  ("StarAlgebra.adjoin", "StarAlgebra.adjoin"),
  ("StarMemClass", "StarMemClass"),
  ("StarModule", "StarModule"),
  ("StarSubalgebra", "StarSubalgebra"),
  ("StarSubalgebra.subtype", "StarSubalgebra.subtype"),
  ("StarSubalgebra.topologicalClosure", "StarSubalgebra.topologicalClosure"),
  ("SubNegMonoid.sub_eq_add_neg._autoParam", "SubNegMonoid.sub_eq_add_neg._autoParam"),
  ("SubNegMonoid.zsmul_neg'._autoParam", "SubNegMonoid.zsmul_neg'._autoParam"),
  ("SubNegMonoid.zsmul_succ'._autoParam", "SubNegMonoid.zsmul_succ'._autoParam"),
  ("SubNegMonoid.zsmul_zero'._autoParam", "SubNegMonoid.zsmul_zero'._autoParam"),
  ("Subalgebra", "Subalgebra"),
  ("Subgroup", "Subgroup"),
  ("Submodule", "Submodule"),
  ("Submodule.HasOrthogonalProjection", "Submodule.HasOrthogonalProjection"),
  ("Submodule.mk", "Submodule.mk"),
  ("Submodule.orthogonal", "Submodule.orthogonal"),
  ("Submodule.span", "Submodule.span"),
  ("Submodule.starProjection", "Submodule.starProjection"),
  ("Submonoid", "Submonoid"),
  ("Submonoid.unitSphere", "Submonoid.unitSphere"),
  ("SubmonoidClass", "SubmonoidClass"),
  ("SubringClass", "SubringClass"),
  ("SubsemiringClass", "SubsemiringClass"),
  ("SubtractionMonoid", "SubtractionMonoid"),
  ("Subtype", "Subtype"),
  ("Subtype.instMeasurableSpace", "Subtype.instMeasurableSpace"),
  ("Subtype.mk", "Subtype.mk"),
  ("Subtype.val", "Subtype.val"),
  ("T2Space", "T2Space"),
  ("TopologicalSpace", "TopologicalSpace"),
  ("TopologicalSpace.SeparableSpace", "TopologicalSpace.SeparableSpace"),
  ("TopologicalSpace.denseSeq", "TopologicalSpace.denseSeq"),
  ("True", "True"),
  ("Ultrafilter.toFilter", "Ultrafilter.toFilter"),
  ("UniformContinuous", "UniformContinuous"),
  ("Union.union", "Union.union"),
  ("Unitary.linearIsometryEquiv", "Unitary.linearIsometryEquiv"),
  ("WeakDual", "WeakDual"),
  ("WeakDual.characterSpace", "WeakDual.characterSpace"),
  ("ZeroMemClass", "ZeroMemClass"),
  ("abs", "abs"),
  ("algebraicClosure", "algebraicClosure"),
  ("autoParam", "autoParam"),
  ("closedConvexHull", "closedConvexHull"),
  ("convexHull", "convexHull"),
  ("dite", "dite"),
  ("gelfandStarTransform", "gelfandStarTransform"),
  ("id", "id"),
  ("inferInstance", "inferInstance"),
  ("ite", "ite"),
  ("nhds", "nhds"),
  ("starRingEnd", "starRingEnd"),
  ("unitary", "unitary")]
