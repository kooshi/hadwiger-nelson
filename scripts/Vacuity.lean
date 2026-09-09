/-
# The vacuity audit — a theorem can pass every gate this project has and still say nothing

`WORKFLOW.md`'s gate checks that the library elaborates, holds no `sorry`, buys no undeclared
trust, and lints clean. **None of those detects a `∀` over an empty domain.**

On 2026-09-09 a theorem held since M34 — *"no proper 4-colouring of the plane avoids a
monochromatic pair at distance `√3`"* — turned out to be VACUOUS: this repository's own rung B
(`χ(ℝ²) ≥ 5`) makes `(unitDistance ℂ).Coloring (Fin 4)` an empty type. The statement was true,
kernel-checked, axiom-clean, and empty. It was noticed four weeks later, by someone trying to
*use* it, and a live argument had been resting on it. `CLAUDE.md` § Grokkings records it as
`G30`'s fifth failure mode, with the mechanical rule: *every theorem whose hypothesis is a
structure ships with a named inhabitant.*

**This file is that rule, run by the machine instead of by memory.**

## What it can and cannot do

Deciding whether a hypothesis is satisfiable is as hard as theorem proving, so no check decides
vacuity. This one does not try. It **flips the burden and asks for evidence** — exactly the move
`scripts/Axioms.lean` already makes, which verifies no proof and instead requires every trust
purchase to be *declared*, failing on an undeclared one.

So every carrier type gets one of three verdicts, and the third is the important one:

* `VACUOUS`   — `IsEmpty τ` was synthesized. The theorem says nothing. **Sound**: a proof of
                emptiness is a proof of emptiness.
* `WITNESSED` — `Nonempty τ` was synthesized. The theorem has content.
* `UNKNOWN`   — neither. **Reported and counted, never silent.**

`UNKNOWN` must stay loud because this repository has twice shipped a gate that failed open — the
M03 ledger comparison that did not exist, and the M04 `set -e` abort that produced no output and
read as a pass. A vacuity check that says nothing when it cannot decide is that bug a third time.

## Two shapes, because the trap has two forms

* **Shape A** — a binder `(C : G.Coloring α)`. The `core9_plane` shape.
* **Shape B** — a `Forces` / `Separated` / `Fan` claim. `Forces G k p q` is *by definition*
  `∀ C : G.Coloring (Fin k), C p = C q`, so it is **vacuously true whenever `G` refuses `k`
  colours** — the sharper trap `plans/STUB-vacuity-and-record-integrity.md` §A2 names, and the
  one no reader sees in the statement. The probe is on `G.Coloring (Fin k)` either way.

## What it deliberately does NOT flag

Vacuity is not always a defect. `Instances/HexShell.lean`'s consumers assume a colouring **in
order to refute it** — `not_colorable_five_of_forced_pairs` concludes `¬ Colorable 5` — and
assuming a structure in order to derive a contradiction is the one shape vacuity cannot damage:
emptiness there is the conclusion, not a hidden hypothesis. Such sites are `VACUOUS` by this
check and belong in the baseline with that reason, which is why the baseline carries prose.

And the sharpest near-miss of the 2026-09-09 consolidation would still slip through: package P3's
subplan had hypotheses that were *trivially satisfiable*, so the conclusion had no content. That
is neither emptiness nor a dead hypothesis, and no mechanical check finds it. A modeling pass did.
-/
import Proofs

open Lean Lean.Meta Lean.Elab Lean.Elab.Command

namespace VacuityAudit

initialize registerTraceClass `vacuity

/-- **The detector.** If the domain is empty every property of it holds, so a goal closable by
this term is a statement with no content. It is the general form of `Instances/Interval.lean`'s
`vacuous_of_plane_four_coloring`, which is this same fact pinned at the plane and four colours. -/
theorem vacuous_of_isEmpty {X : Sort*} [IsEmpty X] (P : X → Prop) : ∀ x, P x :=
  fun x => (IsEmpty.false x).elim

/-- Three outcomes, never two. -/
inductive Verdict | vacuous | witnessed | unknown
  deriving BEq, Inhabited

def Verdict.tag : Verdict → String
  | .vacuous => "VACUOUS" | .witnessed => "WITNESSED" | .unknown => "UNKNOWN"

/-- Is this declaration one of ours, rather than Mathlib's or core's? -/
def isOurs (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | some idx =>
    match env.header.moduleNames[idx.toNat]? with
    | some m => (`Proofs.HadwigerNelson).isPrefixOf m || m == `Proofs
    | none => false
  | none => false

/-- **The evidence the library already holds.**

`SimpleGraph.Colorable G n` is *definitionally* `Nonempty (G.Coloring (Fin n))`, so every
unconditional `Colorable` theorem in this repository is already a non-vacuity witness and every
`IsEmpty (… Coloring …)` theorem is already a vacuity proof. Neither is an `instance`, so instance
search alone finds nothing — which is why the first run of this audit returned 249 `UNKNOWN` and
zero verdicts, including on `core9_plane`, the declaration that motivated the whole check.

So the audit collects that evidence from the environment rather than asking anyone to tag it.
Only **unconditional** witnesses count: a theorem with real hypotheses is a conditional claim, and
"someone could probably discharge those" is precisely the social argument the kernel replaces. -/
structure Evidence where
  empties   : Array Expr := #[]
  witnesses : Array Expr := #[]

/-- Collect every unconditional `IsEmpty τ` and `Colorable G k` this library proves. -/
def gather (env : Environment) : MetaM Evidence := do
  let mut ev : Evidence := {}
  for (n, ci) in env.constants.toList do
    if n.isInternal || !isOurs env n then continue
    let some τ ← (try forallTelescopeReducing ci.type fun xs concl => do
        -- only instance-implicit binders may remain: anything else is a real hypothesis
        for x in xs do
          if !(← x.fvarId!.getDecl).binderInfo.isInstImplicit then return none
        pure (some concl)
      catch _ => pure none) | continue
    if τ.hasLooseBVars then continue
    match τ.getAppFn.constName? with
    | some ``IsEmpty =>
      if let some c := τ.getAppArgs[0]? then
        if !c.hasLooseBVars then ev := { ev with empties := ev.empties.push c }
    | some ``SimpleGraph.Colorable =>
      let a := τ.getAppArgs
      if h : 2 < a.size then
        if !a[1]!.hasLooseBVars && !a[2]!.hasLooseBVars then
          ev := { ev with witnesses := ev.witnesses.push (← mkAppM ``SimpleGraph.Coloring #[a[1]!, ← mkAppM ``Fin #[a[2]!]]) }
    | _ => pure ()
  return ev

/-- Does `τ` match any collected piece of evidence? Compared under `withNewMCtxDepth` inside
`withoutModifyingState`, so a probe can never leak an assignment into the next one. -/
def matchesAny (τ : Expr) (cands : Array Expr) : MetaM Bool :=
  cands.anyM fun c => withoutModifyingState <| withNewMCtxDepth <| (try isDefEq τ c catch _ => pure false)

/-- Ask whether `τ` is provably empty, provably inhabited, or neither.

The third answer is the point. A carrier this check cannot decide is reported and counted, never
passed over in silence — this repository has twice shipped a gate that failed open. -/
def probe (ev : Evidence) (τ : Expr) : MetaM Verdict := do
  if ← matchesAny τ ev.empties then return .vacuous
  if ← matchesAny τ ev.witnesses then return .witnessed
  -- instance search as a fallback, for carriers whose inhabitedness is structural
  let synth (head : Name) : MetaM Bool := do
    try
      match ← synthInstance? (← mkAppM head #[τ]) with
      | some _ => pure true | none => pure false
    catch _ => pure false
  if ← synth ``IsEmpty then return .vacuous
  if ← synth ``Nonempty then return .witnessed
  return .unknown

/-- The carrier a declaration's binder or claim is really about.

Shape A: the binder's own type, when it is a `SimpleGraph.Coloring`.
Shape B: `Forces G k _ _` / `Separated G k _ _` / `Fan G k _ _` — rebuilt as `G.Coloring (Fin k)`,
because that is the type the definition quantifies over and therefore the type whose emptiness
makes the claim vacuous. -/
def carrierOf? (e : Expr) : MetaM (Option Expr) := do
  let fn := e.getAppFn
  let args := e.getAppArgs
  match fn.constName? with
  | some ``SimpleGraph.Coloring => return some e
  | some n =>
    if n == ``HadwigerNelson.Forces || n == ``HadwigerNelson.Separated || n == ``HadwigerNelson.Fan then
      -- ⟨V, G, k, …⟩ — V implicit at 0, G at 1, k at 2, for all three.
      if 2 < args.size then
        let G := args[1]!
        let k := args[2]!
        if G.hasLooseBVars || k.hasLooseBVars then return none
        return some (← mkAppM ``SimpleGraph.Coloring #[G, ← mkAppM ``Fin #[k]])
      else return none
    else return none
  | none => return none

/-- Every carrier a declaration's statement commits to: each binder's type, plus the conclusion. -/
def carriersOf (type : Expr) : MetaM (Array Expr) :=
  forallTelescopeReducing type fun xs concl => do
    let mut out := #[]
    for x in xs do
      if let some τ ← carrierOf? (← inferType x) then out := out.push τ
    if let some τ ← carrierOf? concl then out := out.push τ
    return out.filter (!·.hasLooseBVars)

/-- Run the audit and print one line per (declaration, carrier). Machine-readable by design:
`scripts/vacuity.sh` parses these lines, so the format is a contract. -/
def audit : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let ev ← gather env
  logInfo m!"evidence: {ev.empties.size} emptiness proof(s), {ev.witnesses.size} colourability witness(es)"
  let mut rows : Array (Name × Verdict) := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal || !isOurs env n then continue
    let carriers ← try carriersOf ci.type catch _ => pure #[]
    for τ in carriers do
      let v ← probe ev τ
      trace[vacuity] "{n} : {Verdict.tag v}"
      rows := rows.push (n, v)
  let count (v : Verdict) := rows.filter (·.2 == v) |>.size
  logInfo m!"=== VACUITY AUDIT ==="
  for (n, v) in rows do
    if v != .witnessed then logInfo m!"{Verdict.tag v} {n}"
  logInfo m!"=== TOTALS === sites={rows.size} vacuous={count .vacuous} witnessed={count .witnessed} unknown={count .unknown}"

end VacuityAudit

#eval VacuityAudit.audit
