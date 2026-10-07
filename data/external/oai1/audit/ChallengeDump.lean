import ComparatorChallenges.EuclideanFiveColor
-- EXT-OAI1: the challenge's two declarations as the kernel holds them, in the challenge's own environment (Mathlib only).
namespace Audit
/-- A canonical print of a universe level. -/
partial def dumpLevel : Lean.Level → String
  | .zero => "0"
  | .succ l => s!"(S {dumpLevel l})"
  | .max a b => s!"(max {dumpLevel a} {dumpLevel b})"
  | .imax a b => s!"(imax {dumpLevel a} {dumpLevel b})"
  | .param n => s!"(p {n})"
  | .mvar _ => "(lmvar)"
def bi : Lean.BinderInfo → String
  | .default => "d" | .implicit => "i" | .strictImplicit => "s" | .instImplicit => "c"
/-- A canonical print of a term as the kernel holds it: de Bruijn indices, full constant names with their
universe arguments, every implicit and instance argument, and NO bound-variable names. Two terms print alike
exactly when they are equal up to the names of bound variables (and metadata). -/
partial def dump : Lean.Expr → String
  | .bvar i => s!"#{i}"
  | .fvar _ => "(fvar)"
  | .mvar _ => "(mvar)"
  | .sort l => s!"(Sort {dumpLevel l})"
  | .const n ls => s!"(c {n} [{String.intercalate "," (ls.map dumpLevel)}])"
  | .app f a => s!"({dump f} {dump a})"
  | .lam _ t b i => s!"(lam.{bi i} {dump t} {dump b})"
  | .forallE _ t b i => s!"(pi.{bi i} {dump t} {dump b})"
  | .letE _ t v b _ => s!"(let {dump t} {dump v} {dump b})"
  | .lit (.natVal n) => s!"(nat {n})"
  | .lit (.strVal s) => s!"(str {s.quote})"
  | .mdata _ e => dump e
  | .proj s i e => s!"(proj {s} {i} {dump e})"
def report (n : Lean.Name) : Lean.CoreM Unit := do
  let env ← Lean.getEnv
  match env.find? n with
  | none => IO.println s!"DUMP {n} : ABSENT"
  | some ci =>
    let kind := match ci with
      | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom"
      | .opaqueInfo _ => "opaque" | _ => "other"
    IO.println s!"DUMP {n} : {kind} levels={ci.levelParams}"
    IO.println s!"DUMP   type  = {dump ci.type}"
    if let .defnInfo d := ci then IO.println s!"DUMP   value = {dump d.value}"
end Audit
#eval Audit.report `OAI.EuclideanFiveColor.ProperColoring
#eval Audit.report `OAI.EuclideanFiveColor.no_proper_five_coloring
