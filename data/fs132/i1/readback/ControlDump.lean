import Proofs.HadwigerNelson.Instances.Interval
import Proofs.HadwigerNelson.Plane.YesLimit
import Proofs.HadwigerNelson.Plane.CoverExamples
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
/-! FS132-I1 — A CONTROL for `tools/fs132_i1_readback.py`, never a module and imported by nothing. Under the module's
own imports and namespace, six of the eight declarations are ALTERED in one place each and two are left as the
release has them. The comparator must read the six DIFFERENT and the two IDENTICAL against the release's print.
The two `axiom`s here are controls: the first is this library's own theorem (four colours), the second is the
release's statement with its `[NeZero k]` binder dropped. -/
open MeasureTheory
namespace HadwigerNelson.Outside.OAI158
/-- ALTERED: `dist x y` for the norm of the difference (equal, and another term). -/
def ProperColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  ∀ x y : ℂ, dist x y = 1 → c x ≠ c y
/-- as the release has it -/
scoped instance anglePeriodPositive : Fact (0 < 2*Real.pi) := ⟨by positivity⟩
/-- as the release has it -/
abbrev Angles := AddCircle (2*Real.pi)
/-- ALTERED: the circle's own volume, of mass `2π`, for the normalized Haar measure. -/
noncomputable def angularMeasure : Measure Angles := volume
/-- ALTERED: the angle negated. -/
noncomputable def direction (t : Angles) : ℂ := AddCircle.toCircle (-t)
/-- ALTERED: `Measurable c` for `AEMeasurable c volume`. -/
def WeakColoring (k : ℕ) (c : ℂ → Fin k) : Prop :=
  Measurable c ∧ ∀ᵐ p ∂(volume : Measure ℂ).prod angularMeasure,
    c p.1 ≠ c (p.1+direction p.2)
/-- ALTERED: four colours for five. -/
axiom no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 4, ProperColoring 4 c
/-- ALTERED: the binder `[NeZero k]` dropped. -/
axiom proper_to_borel_weak {k : ℕ} {c : ℂ → Fin k} (hc : ProperColoring k c) :
    ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d
end HadwigerNelson.Outside.OAI158
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
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.ProperColoring
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.anglePeriodPositive
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.Angles
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.angularMeasure
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.direction
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.WeakColoring
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.no_proper_five_coloring
#eval FS132I1.report `HadwigerNelson.Outside.OAI158.proper_to_borel_weak
