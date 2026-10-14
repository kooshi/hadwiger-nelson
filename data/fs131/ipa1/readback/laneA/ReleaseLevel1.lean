import OAI.Analysis.PlaneSpectrum.Basic
import OAI.Analysis.PlaneSpectrum.InvariantMean
import OAI.Analysis.PlaneSpectrum.SmallArcs
import OAI.Analysis.PlaneSpectrum.PhaseEncoding
import OAI.Analysis.PlaneSpectrum.Characters
import OAI.Analysis.PlaneSpectrum.PhaseCollision
import OAI.Analysis.PlaneSpectrum.Multipliers
import OAI.MeasureTheory.CompactFactors.ConditionalSelection
import OAI.Analysis.PlaneSpectrum.FourierTests
import OAI.Analysis.PlaneSpectrum.ConditionalSpectrum
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

#eval FS132I2.runLevel1 [("AEMeasurable", "AEMeasurable"),
  ("AddCircle", "AddCircle"),
  ("AddCircle.haarAddCircle", "AddCircle.haarAddCircle"),
  ("AddCommGroup", "AddCommGroup"),
  ("AddCommGroup.mk", "AddCommGroup.mk"),
  ("AddCommMonoid", "AddCommMonoid"),
  ("AddCon.mk", "AddCon.mk"),
  ("AddCon.toSetoid", "AddCon.toSetoid"),
  ("AddHom.mk", "AddHom.mk"),
  ("AddMonoid.nsmul_succ._autoParam", "AddMonoid.nsmul_succ._autoParam"),
  ("AddMonoid.nsmul_zero._autoParam", "AddMonoid.nsmul_zero._autoParam"),
  ("AddMonoidHom", "AddMonoidHom"),
  ("AddMonoidHom.comp", "AddMonoidHom.comp"),
  ("AddMonoidHom.ker", "AddMonoidHom.ker"),
  ("AddSubgroup", "AddSubgroup"),
  ("AddSubgroup.Normal", "AddSubgroup.Normal"),
  ("AddSubgroup.zmultiples", "AddSubgroup.zmultiples"),
  ("AddSubgroupClass", "AddSubgroupClass"),
  ("AddSubmonoidClass", "AddSubmonoidClass"),
  ("Additive", "Additive"),
  ("Additive.ofMul", "Additive.ofMul"),
  ("And", "And"),
  ("BorelSpace", "BorelSpace"),
  ("Bot.bot", "Bot.bot"),
  ("BoundedAdd", "BoundedAdd"),
  ("BoundedContinuousFunction", "BoundedContinuousFunction"),
  ("BoundedContinuousFunction.compContinuous", "BoundedContinuousFunction.compContinuous"),
  ("BoundedContinuousFunction.const", "BoundedContinuousFunction.const"),
  ("BoundedContinuousFunction.ofNormedAddCommGroupDiscrete", "BoundedContinuousFunction.ofNormedAddCommGroupDiscrete"),
  ("CharZero", "CharZero"),
  ("Circle", "Circle"),
  ("Circle.exp", "Circle.exp"),
  ("Classical.decEq", "Classical.decEq"),
  ("CommGroup", "CommGroup"),
  ("CommGroup.mk", "CommGroup.mk"),
  ("CompactSpace", "CompactSpace"),
  ("CompleteSpace", "CompleteSpace"),
  ("Complex", "Complex"),
  ("Complex.I", "Complex.I"),
  ("Complex.arg", "Complex.arg"),
  ("Complex.im", "Complex.im"),
  ("Complex.imCLM", "Complex.imCLM"),
  ("Complex.ofReal", "Complex.ofReal"),
  ("Complex.re", "Complex.re"),
  ("Complex.reCLM", "Complex.reCLM"),
  ("Continuous", "Continuous"),
  ("ContinuousAdd", "ContinuousAdd"),
  ("ContinuousAt", "ContinuousAt"),
  ("ContinuousConstSMul", "ContinuousConstSMul"),
  ("ContinuousLinearMap", "ContinuousLinearMap"),
  ("ContinuousLinearMap.comp", "ContinuousLinearMap.comp"),
  ("ContinuousLinearMap.compLeftContinuousBounded", "ContinuousLinearMap.compLeftContinuousBounded"),
  ("ContinuousMap", "ContinuousMap"),
  ("ContinuousMap.addRight", "ContinuousMap.addRight"),
  ("ContinuousMap.comp", "ContinuousMap.comp"),
  ("ContinuousMap.mk", "ContinuousMap.mk"),
  ("ContinuousMap.restrict", "ContinuousMap.restrict"),
  ("ContinuousMonoidHom", "ContinuousMonoidHom"),
  ("ContinuousMonoidHom.comp", "ContinuousMonoidHom.comp"),
  ("ContinuousMonoidHom.mk", "ContinuousMonoidHom.mk"),
  ("ContinuousMonoidHom.toMonoidHom", "ContinuousMonoidHom.toMonoidHom"),
  ("Countable", "Countable"),
  ("DFunLike.coe", "DFunLike.coe"),
  ("DecidableEq", "DecidableEq"),
  ("DecidablePred", "DecidablePred"),
  ("Dense", "Dense"),
  ("DiscreteTopology", "DiscreteTopology"),
  ("Dist.dist", "Dist.dist"),
  ("DistribSMul", "DistribSMul"),
  ("DivInvMonoid.div_eq_mul_inv._autoParam", "DivInvMonoid.div_eq_mul_inv._autoParam"),
  ("DivInvMonoid.zpow_neg'._autoParam", "DivInvMonoid.zpow_neg'._autoParam"),
  ("DivInvMonoid.zpow_succ'._autoParam", "DivInvMonoid.zpow_succ'._autoParam"),
  ("DivInvMonoid.zpow_zero'._autoParam", "DivInvMonoid.zpow_zero'._autoParam"),
  ("DivisionSemiring", "DivisionSemiring"),
  ("ENNReal", "ENNReal"),
  ("ENNReal.ofReal", "ENNReal.ofReal"),
  ("Eq", "Eq"),
  ("Equiv", "Equiv"),
  ("Exists", "Exists"),
  ("Fact", "Fact"),
  ("False", "False"),
  ("Filter", "Filter"),
  ("Filter.Eventually", "Filter.Eventually"),
  ("Filter.EventuallyEq", "Filter.EventuallyEq"),
  ("Filter.EventuallySubset", "Filter.EventuallySubset"),
  ("Filter.NeBot", "Filter.NeBot"),
  ("Filter.Tendsto", "Filter.Tendsto"),
  ("Filter.atTop", "Filter.atTop"),
  ("Filter.limUnder", "Filter.limUnder"),
  ("Fin", "Fin"),
  ("Fin.val", "Fin.val"),
  ("Finite", "Finite"),
  ("Finset", "Finset"),
  ("Finset.HasAntidiagonal.antidiagonal", "Finset.HasAntidiagonal.antidiagonal"),
  ("Finset.Icc", "Finset.Icc"),
  ("Finset.Nonempty", "Finset.Nonempty"),
  ("Finset.card", "Finset.card"),
  ("Finset.diag", "Finset.diag"),
  ("Finset.filter", "Finset.filter"),
  ("Finset.powersetCard", "Finset.powersetCard"),
  ("Finset.prod", "Finset.prod"),
  ("Finset.range", "Finset.range"),
  ("Finset.sum", "Finset.sum"),
  ("Finset.toList", "Finset.toList"),
  ("Finset.univ", "Finset.univ"),
  ("Finset.val", "Finset.val"),
  ("Fintype", "Fintype"),
  ("Fintype.card", "Fintype.card"),
  ("FunLike", "FunLike"),
  ("Function.Injective", "Function.Injective"),
  ("Function.Periodic", "Function.Periodic"),
  ("Function.Periodic.lift", "Function.Periodic.lift"),
  ("Function.Surjective", "Function.Surjective"),
  ("Function.comp", "Function.comp"),
  ("Group", "Group"),
  ("HAdd.hAdd", "HAdd.hAdd"),
  ("HDiv.hDiv", "HDiv.hDiv"),
  ("HMul.hMul", "HMul.hMul"),
  ("HPow.hPow", "HPow.hPow"),
  ("HSMul.hSMul", "HSMul.hSMul"),
  ("HSub.hSub", "HSub.hSub"),
  ("HasQuotient.Quotient", "HasQuotient.Quotient"),
  ("Iff", "Iff"),
  ("Inner.inner", "Inner.inner"),
  ("InnerProductSpace", "InnerProductSpace"),
  ("InnerProductSpace.toDual", "InnerProductSpace.toDual"),
  ("Int", "Int"),
  ("Int.cast", "Int.cast"),
  ("Int.floor", "Int.floor"),
  ("Int.negSucc", "Int.negSucc"),
  ("IntermediateField", "IntermediateField"),
  ("IntermediateField.toSubalgebra", "IntermediateField.toSubalgebra"),
  ("Inv.inv", "Inv.inv"),
  ("InvImage", "InvImage"),
  ("IsAlgebraic", "IsAlgebraic"),
  ("IsBoundedSMul", "IsBoundedSMul"),
  ("IsCompact", "IsCompact"),
  ("IsTopologicalAddGroup", "IsTopologicalAddGroup"),
  ("IsTopologicalGroup", "IsTopologicalGroup"),
  ("LE.le", "LE.le"),
  ("LT.lt", "LT.lt"),
  ("LinearIsometry", "LinearIsometry"),
  ("LinearIsometry.mk", "LinearIsometry.mk"),
  ("LinearIsometryEquiv", "LinearIsometryEquiv"),
  ("LinearIsometryEquiv.ofSurjective", "LinearIsometryEquiv.ofSurjective"),
  ("LinearIsometryEquiv.symm", "LinearIsometryEquiv.symm"),
  ("LinearMap", "LinearMap"),
  ("LinearMap.mk", "LinearMap.mk"),
  ("LinearMap.mkContinuous", "LinearMap.mkContinuous"),
  ("LinearOrder", "LinearOrder"),
  ("List", "List"),
  ("List.below", "List.below"),
  ("List.brecOn", "List.brecOn"),
  ("List.casesOn", "List.casesOn"),
  ("List.cons", "List.cons"),
  ("List.nil", "List.nil"),
  ("LocallyFiniteOrder", "LocallyFiniteOrder"),
  ("Matrix.vecCons", "Matrix.vecCons"),
  ("Matrix.vecEmpty", "Matrix.vecEmpty"),
  ("Measurable", "Measurable"),
  ("MeasurableEmbedding", "MeasurableEmbedding"),
  ("MeasurableEq", "MeasurableEq"),
  ("MeasurableInv", "MeasurableInv"),
  ("MeasurableMul₂", "MeasurableMul₂"),
  ("MeasurableSet", "MeasurableSet"),
  ("MeasurableSingletonClass", "MeasurableSingletonClass"),
  ("MeasurableSpace", "MeasurableSpace"),
  ("MeasureTheory.AEEqFun", "MeasureTheory.AEEqFun"),
  ("MeasureTheory.AEEqFun.cast", "MeasureTheory.AEEqFun.cast"),
  ("MeasureTheory.AEStronglyMeasurable", "MeasureTheory.AEStronglyMeasurable"),
  ("MeasureTheory.Integrable", "MeasureTheory.Integrable"),
  ("MeasureTheory.IsFiniteMeasure", "MeasureTheory.IsFiniteMeasure"),
  ("MeasureTheory.IsProbabilityMeasure", "MeasureTheory.IsProbabilityMeasure"),
  ("MeasureTheory.Lp", "MeasureTheory.Lp"),
  ("MeasureTheory.Lp.const", "MeasureTheory.Lp.const"),
  ("MeasureTheory.Measure", "MeasureTheory.Measure"),
  ("MeasureTheory.Measure.AbsolutelyContinuous", "MeasureTheory.Measure.AbsolutelyContinuous"),
  ("MeasureTheory.Measure.bind", "MeasureTheory.Measure.bind"),
  ("MeasureTheory.Measure.dirac", "MeasureTheory.Measure.dirac"),
  ("MeasureTheory.Measure.map", "MeasureTheory.Measure.map"),
  ("MeasureTheory.Measure.prod", "MeasureTheory.Measure.prod"),
  ("MeasureTheory.Measure.real", "MeasureTheory.Measure.real"),
  ("MeasureTheory.Measure.withDensity", "MeasureTheory.Measure.withDensity"),
  ("MeasureTheory.MeasurePreserving", "MeasureTheory.MeasurePreserving"),
  ("MeasureTheory.MeasureSpace.toMeasurableSpace", "MeasureTheory.MeasureSpace.toMeasurableSpace"),
  ("MeasureTheory.MeasureSpace.volume", "MeasureTheory.MeasureSpace.volume"),
  ("MeasureTheory.MemLp", "MeasureTheory.MemLp"),
  ("MeasureTheory.MemLp.toLp", "MeasureTheory.MemLp.toLp"),
  ("MeasureTheory.OuterMeasureClass", "MeasureTheory.OuterMeasureClass"),
  ("MeasureTheory.TendstoInMeasure", "MeasureTheory.TendstoInMeasure"),
  ("MeasureTheory.ae", "MeasureTheory.ae"),
  ("MeasureTheory.integral", "MeasureTheory.integral"),
  ("Membership.mem", "Membership.mem"),
  ("Min.min", "Min.min"),
  ("Monoid.npow_succ._autoParam", "Monoid.npow_succ._autoParam"),
  ("Monoid.npow_zero._autoParam", "Monoid.npow_zero._autoParam"),
  ("MonoidHom", "MonoidHom"),
  ("MonoidHom.mk", "MonoidHom.mk"),
  ("MonoidHom.range", "MonoidHom.range"),
  ("Monotone", "Monotone"),
  ("MulAction", "MulAction"),
  ("MulAction.mk", "MulAction.mk"),
  ("MulAction.orbit", "MulAction.orbit"),
  ("Multiplicative", "Multiplicative"),
  ("Multiplicative.ofAdd", "Multiplicative.ofAdd"),
  ("Multiplicative.toAdd", "Multiplicative.toAdd"),
  ("Multiset", "Multiset"),
  ("Multiset.card", "Multiset.card"),
  ("Multiset.esymm", "Multiset.esymm"),
  ("Multiset.map", "Multiset.map"),
  ("Nat", "Nat"),
  ("Nat.AtLeastTwo", "Nat.AtLeastTwo"),
  ("Nat.casesOn", "Nat.casesOn"),
  ("Nat.cast", "Nat.cast"),
  ("Nat.succ", "Nat.succ"),
  ("Ne", "Ne"),
  ("Neg.neg", "Neg.neg"),
  ("Nonempty", "Nonempty"),
  ("Norm.norm", "Norm.norm"),
  ("NormMulClass", "NormMulClass"),
  ("NormOneClass", "NormOneClass"),
  ("NormedAddCommGroup", "NormedAddCommGroup"),
  ("NormedSpace", "NormedSpace"),
  ("Not", "Not"),
  ("OfNat.ofNat", "OfNat.ofNat"),
  ("OneHom.mk", "OneHom.mk"),
  ("OneMemClass", "OneMemClass"),
  ("Or", "Or"),
  ("PolishSpace", "PolishSpace"),
  ("Polynomial", "Polynomial"),
  ("Polynomial.C", "Polynomial.C"),
  ("Polynomial.X", "Polynomial.X"),
  ("Polynomial.eval", "Polynomial.eval"),
  ("PontryaginDual", "PontryaginDual"),
  ("Preorder", "Preorder"),
  ("ProbabilityTheory.IsMarkovKernel", "ProbabilityTheory.IsMarkovKernel"),
  ("ProbabilityTheory.IsSFiniteKernel", "ProbabilityTheory.IsSFiniteKernel"),
  ("ProbabilityTheory.Kernel", "ProbabilityTheory.Kernel"),
  ("ProbabilityTheory.Kernel.prod", "ProbabilityTheory.Kernel.prod"),
  ("ProbabilityTheory.condDistrib", "ProbabilityTheory.condDistrib"),
  ("Prod", "Prod"),
  ("Prod.fst", "Prod.fst"),
  ("Prod.instMeasurableSpace", "Prod.instMeasurableSpace"),
  ("Prod.snd", "Prod.snd"),
  ("PseudoMetricSpace", "PseudoMetricSpace"),
  ("Pure.pure", "Pure.pure"),
  ("Quotient.map'", "Quotient.map'"),
  ("Quotient.map₂", "Quotient.map₂"),
  ("Quotient.mk''", "Quotient.mk''"),
  ("QuotientAddGroup.Quotient.addGroup._aux_4", "QuotientAddGroup.Quotient.addGroup._aux_4"),
  ("QuotientAddGroup.Quotient.addGroup._aux_8", "QuotientAddGroup.Quotient.addGroup._aux_8"),
  ("QuotientAddGroup.leftRel", "QuotientAddGroup.leftRel"),
  ("QuotientAddGroup.lift", "QuotientAddGroup.lift"),
  ("QuotientAddGroup.measurableSpace", "QuotientAddGroup.measurableSpace"),
  ("QuotientAddGroup.mk", "QuotientAddGroup.mk"),
  ("QuotientAddGroup.mk'", "QuotientAddGroup.mk'"),
  ("QuotientGroup.map", "QuotientGroup.map"),
  ("QuotientGroup.mk", "QuotientGroup.mk"),
  ("Rat", "Rat"),
  ("Rat.cast", "Rat.cast"),
  ("Real", "Real"),
  ("Real.pi", "Real.pi"),
  ("RingHom", "RingHom"),
  ("RingHom.id", "RingHom.id"),
  ("RingHom.mk", "RingHom.mk"),
  ("RingHom.toAddMonoidHom", "RingHom.toAddMonoidHom"),
  ("RingHomCompTriple", "RingHomCompTriple"),
  ("RingHomInvPair", "RingHomInvPair"),
  ("RingHomIsometric", "RingHomIsometric"),
  ("RootableBy", "RootableBy"),
  ("SMulCommClass", "SMulCommClass"),
  ("SProd.sprod", "SProd.sprod"),
  ("SecondCountableTopology", "SecondCountableTopology"),
  ("Semigroup", "Semigroup"),
  ("SeminormedRing", "SeminormedRing"),
  ("SeparatelyContinuousAdd", "SeparatelyContinuousAdd"),
  ("Set", "Set"),
  ("Set.Elem", "Set.Elem"),
  ("Set.Finite", "Set.Finite"),
  ("Set.ofPred", "Set.ofPred"),
  ("Set.preimage", "Set.preimage"),
  ("Set.range", "Set.range"),
  ("SetLike.coe", "SetLike.coe"),
  ("Setoid", "Setoid"),
  ("Singleton.singleton", "Singleton.singleton"),
  ("StandardBorelSpace", "StandardBorelSpace"),
  ("StrongDual", "StrongDual"),
  ("SubNegMonoid.sub_eq_add_neg._autoParam", "SubNegMonoid.sub_eq_add_neg._autoParam"),
  ("SubNegMonoid.zsmul_neg'._autoParam", "SubNegMonoid.zsmul_neg'._autoParam"),
  ("SubNegMonoid.zsmul_succ'._autoParam", "SubNegMonoid.zsmul_succ'._autoParam"),
  ("SubNegMonoid.zsmul_zero'._autoParam", "SubNegMonoid.zsmul_zero'._autoParam"),
  ("Subalgebra.toSubsemiring", "Subalgebra.toSubsemiring"),
  ("Subgroup", "Subgroup"),
  ("Subgroup.Normal", "Subgroup.Normal"),
  ("Subgroup.mk", "Subgroup.mk"),
  ("SubgroupClass", "SubgroupClass"),
  ("Submonoid", "Submonoid"),
  ("Submonoid.mk", "Submonoid.mk"),
  ("Submonoid.unitSphere", "Submonoid.unitSphere"),
  ("SubmonoidClass", "SubmonoidClass"),
  ("Subsemigroup.mk", "Subsemigroup.mk"),
  ("Subsemiring", "Subsemiring"),
  ("Subsemiring.subtype", "Subsemiring.subtype"),
  ("SubsemiringClass", "SubsemiringClass"),
  ("Subtype", "Subtype"),
  ("Subtype.mk", "Subtype.mk"),
  ("Subtype.val", "Subtype.val"),
  ("Summable", "Summable"),
  ("SummationFilter.unconditional", "SummationFilter.unconditional"),
  ("TopologicalSpace", "TopologicalSpace"),
  ("TopologicalSpace.Compacts", "TopologicalSpace.Compacts"),
  ("True", "True"),
  ("Ultrafilter", "Ultrafilter"),
  ("Ultrafilter.of", "Ultrafilter.of"),
  ("Ultrafilter.toFilter", "Ultrafilter.toFilter"),
  ("UniformContinuous", "UniformContinuous"),
  ("Unit", "Unit"),
  ("Unit.unit", "Unit.unit"),
  ("UnitAddCircle", "UnitAddCircle"),
  ("WellFounded.Nat.fix", "WellFounded.Nat.fix"),
  ("abs", "abs"),
  ("algebraicClosure", "algebraicClosure"),
  ("autoParam", "autoParam"),
  ("borel", "borel"),
  ("fourier", "fourier"),
  ("id", "id"),
  ("innerSL", "innerSL"),
  ("ite", "ite"),
  ("nhds", "nhds"),
  ("rootableByOfPowLeftSurj", "rootableByOfPowLeftSurj"),
  ("starRingEnd", "starRingEnd"),
  ("tsum", "tsum")]
