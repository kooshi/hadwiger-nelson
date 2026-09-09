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

## What about the INSTANTIATIONS of a generic carrier? Measured, and blocked — read this before
## trying it, because the idea is right and the mechanism is not available.

Vacuity is really a property of an *instantiation*: a parametric theorem is not vacuous, but a
*call site* that instantiates it at an empty carrier proves nothing. So the sharp version of this
check would walk proof terms, find every application of a colouring lemma, instantiate its carrier
at the actual arguments, and probe THAT — recursively, since a generic lemma may be reached
through another generic one. It would turn `generic` from "unanalysable" into "analysed at every
place it is actually used".

**It cannot be done from a script, and the reason is not a design choice.** Measured 2026-09-09
over this library: of **3,307 theorems, `ConstantInfo.value?` is available for 0**; of 2,708
definitions, for all 2,708. Lean does not retain theorem bodies in the importable environment, so
an imported proof term simply is not there to walk. A first attempt returned "0 concrete carriers
at 56 application sites", and that number was a measurement of the instrument rather than of the
library — `G21` in this project's own vocabulary, caught by pointing the instrument at
`core9_plane`, whose proof it could not see at all.

Two further facts bound what is lost, both measured the same day:

* the whole library mentions only **13 distinct concrete carriers** — the plane at 4, 5, 6 and 9
  colours, the finite planes at 3 and 11, the 9- and 122-point cores, de Grey's 1581, the
  `{1,2}` two-distance plane, and three spec models;
* **none of them appears only inside a proof**: every one occurs in some statement, which this
  check already scans.

So the upside here is small and the cost is not: doing it properly means instrumenting the BUILD
— a hook that fires as each theorem is elaborated, when the proof term is in hand, writing what it
finds into a persistent environment extension — rather than adding a post-hoc script. That is a
real option and it is the only one; it is recorded here so the next person to have this good idea
starts from the blocker instead of rediscovering it.

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

/-- The verdicts. Five, and the shape mirrors `scripts/axioms.sh` deliberately.

That gate does not treat a `native_decide` purchase as a failure — it treats it as *expected, by
design*, **declared per use with its reason in the declaration's own docstring**, and listed under
its own banner. Vacuity is the same epistemic situation, so it gets the same vocabulary:

* `witnessed` — an inhabitant is proved. The `CLEAN` analogue.
* `declared`  — the domain is provably empty **and the declaration says so, with a reason**. The
                `PURCHASED` analogue: not a defect, but never silent. Sometimes emptiness IS the
                content (`vacuous_of_plane_four_coloring` is nothing else); sometimes a statement
                is known vacuous and retained under this project's never-delete rule.
* `vacuous`   — provably empty and **undeclared**. The `core9_plane` bug. Always a failure, and
                unlike `unknown` it can never be baselined: a suppression list that can hide this
                is the thing this whole file exists to prevent.
* `stale`     — the docstring claims emptiness that is **not proved**. This is what separates a
                declaration from a `# noqa`: "empty on purpose" is a verifiable claim, so it is
                verified, and an annotation that outlives its truth fails the gate.
* `generic`   — the carrier mentions a bound variable: an arbitrary graph, an arbitrary colour
                count. **No inhabitant witness can exist**, because the claim is parametric — not
                every graph is `k`-colourable, and a theorem quantified over all of them is not
                vacuous, it is *conditionally applicable*, and vacuity is then a property of each
                instantiation, which is the caller's obligation and not this theorem's. Reported
                and counted so it is never silent, but **never baselined**: 223 of the first run's
                238 `unknown`s were this, and asking a shrink-only list to absorb entries that can
                never be resolved is the same lifecycle confusion that put `VACUOUS` in the
                baseline in the first version of this file. Twice, in one file, is enough.
* `unknown`   — a CONCRETE carrier — a specific named object — with no proved inhabitant. The only
                state the baseline may hold, and the only one anybody can actually discharge.
                Fifteen of them, and `core122_pigeonhole` is one: independently flagged by the
                2026-09-09 vacuity audit as resting on a premise nothing in the library
                establishes (`plans/STUB-consolidation-remainder.md` §1). Two different methods
                pointing at one declaration is the best evidence this check works. -/
inductive Verdict | vacuous | declared | stale | witnessed | generic | unknown
  deriving BEq, Inhabited

def Verdict.tag : Verdict → String
  | .vacuous => "VACUOUS" | .declared => "DECLARED" | .stale => "STALE"
  | .witnessed => "WITNESSED" | .generic => "GENERIC" | .unknown => "UNKNOWN"

/-- The marker a declaration uses to say its emptiness is deliberate. It lives in the DOCSTRING,
where `CLAUDE.md` § Trust ledger already requires a `native_decide` purchase to be named — same
rule, same place, so a reader meets the justification at the declaration rather than in a side
file they will never open. -/
def marker : String := "VACUITY DECLARED:"

/-- The reason a declaration gives, if it gives one: the rest of the marker's line. -/
def reasonIn? (doc : String) : Option String :=
  match doc.splitOn marker with
  | _ :: rest :: _ => some (((rest.splitOn "\n").headD "").trim)
  | _ => none

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
  let mut rows : Array (Name × Verdict × String) := #[]
  for (n, ci) in env.constants.toList do
    if n.isInternal || !isOurs env n then continue
    let carriers ← try carriersOf ci.type catch _ => pure #[]
    for τ in carriers do
      -- Probe FIRST, always: a carrier that is demonstrably empty must be reported as such even
      -- when it is generic, so classification can never let a real vacuity escape. `generic` is
      -- only ever a refinement of an INCONCLUSIVE result.
      let probed ← probe ev τ
      let raw := if probed == .unknown && (← instantiateMVars τ).hasFVar then .generic else probed
      -- The declaration is CHECKED against the probe, never merely trusted.
      let reason := (← findDocString? env n).bind reasonIn?
      let (v, r) := match raw, reason with
        | .vacuous, some r => (Verdict.declared, r)
        | .vacuous, none   => (Verdict.vacuous, "")
        | _,        some r => (Verdict.stale, r)
        | v,        none   => (v, "")
      trace[vacuity] "{n} : {Verdict.tag v}"
      rows := rows.push (n, v, r)
  let count (v : Verdict) := rows.filter (·.2.1 == v) |>.size
  logInfo m!"=== VACUITY AUDIT ==="
  -- Declared emptiness gets its own banner with its reasons, the way the axiom audit prints its
  -- purchases: the point is that every deliberate case is READABLE IN ONE PLACE and challengeable.
  logInfo m!"=== DECLARED ==="
  for (n, v, r) in rows do
    if v == .declared then logInfo m!"DECLARED {n} :: {r}"
  -- Only these reach the gate. `generic` is counted in the totals and deliberately absent here:
  -- it is not work anyone can do, so it must not sit in a list whose target is zero.
  logInfo m!"=== FLAGGED ==="
  for (n, v, _) in rows do
    if v == .vacuous || v == .stale || v == .unknown then logInfo m!"{Verdict.tag v} {n}"
  logInfo m!"=== TOTALS === sites={rows.size} vacuous={count .vacuous} stale={count .stale} declared={count .declared} witnessed={count .witnessed} generic={count .generic} unknown={count .unknown}"

end VacuityAudit

#eval VacuityAudit.audit
