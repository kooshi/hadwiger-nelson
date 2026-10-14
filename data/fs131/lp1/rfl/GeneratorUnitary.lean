import Proofs.HadwigerNelson.Outside.OAI158SpectralMeasure
/-!
FS131-LP1, the coordinator's item 807 ruling 1: `CommutingSpectral.generator_unitary`'s stored statement takes the
`Monoid` of `↥(algebra U)` (the argument of `unitary`) through `SubmonoidClass.toMonoid` at the release's pin and through
the ported instance `algebra_commRing` here. This file checks at this pin, in the kernel, that the two instance terms
agree by `rfl` (`monoid_paths_agree`), and so the two statements (`statement_paths_agree`); and it prints, with the
read-back's own dumper (FS132-I2's `report`), the statement written with the release's instance path
(`release_form`) and as this pin elaborates it (`here_form`), for `tools/fs131_lp1_instance_evidence.py` to compare with
the stored types in lane D's two prints. Its planted control is `GeneratorUnitaryPlant.lean`.
-/

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

noncomputable section
open scoped ComplexConjugate IsMulCommutative
namespace FS131LP1
open HadwigerNelson.Outside.OAI158.CommutingSpectral
variable {G H : Type*} [CommGroup G]
  [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
  (U : G →* unitary (H →L[ℂ] H))
/-- The release's instance path and this pin's, as instance terms: equal by `rfl`, so the kernel decides it. -/
theorem monoid_paths_agree :
    (SubmonoidClass.toMonoid (algebra U) : Monoid (algebra U)) = (inferInstance : Monoid (algebra U)) := rfl
/-- The statement with the release's instance path is the stored statement, by `rfl`. -/
theorem statement_paths_agree (g : G) :
    (generator U g ∈ @unitary (algebra U) (SubmonoidClass.toMonoid (algebra U)) _) =
      (generator U g ∈ unitary (algebra U)) := rfl
/-- `generator_unitary` written with the release's instance path (its proof is the ported lemma, accepted through
`monoid_paths_agree`'s definitional equality). -/
theorem release_form (g : G) : generator U g ∈ @unitary (algebra U) (SubmonoidClass.toMonoid (algebra U)) _ :=
  generator_unitary U g
/-- `generator_unitary` as this pin elaborates its text. -/
theorem here_form (g : G) : generator U g ∈ unitary (algebra U) := generator_unitary U g
end FS131LP1
end

#eval FS132I2.runAll [("§.release_form", "FS131LP1.release_form"), ("§.here_form", "FS131LP1.here_form"), ("§.monoid_paths_agree", "FS131LP1.monoid_paths_agree")]
