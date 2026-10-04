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

## The law it implements — one law, not two shapes

**A statement is vacuous exactly when some `∀`-binder of it has an empty domain.** Everything
else follows from where the binder sits, and the position is what the first version of this file
got wrong.

* A binder `(C : G.Coloring α)` is the `core9_plane` shape. Its carrier is itself.
* A binder `(h : Forces G k p q)` is **not** that shape. `Forces G k p q` is
  `∀ C : G.Coloring (Fin k), C p = C q`, so an empty `Coloring` makes the hypothesis **true and
  free**: the theorem then asserts its conclusion outright, which is an *overclaim* — a true thing
  that means less than the sentence around it claims — and not a vacuity. Its carrier is
  `Forces G k p q` itself, refuted by the library's own `not_forces_*` theorems.
* A `Forces` **conclusion** needs no rule: `forallTelescopeReducing` unfolds it and hands back the
  binder `C : G.Coloring (Fin k)`, which is the first case.

The first version special-cased `Forces`/`Separated`/`Fan` into `G.Coloring (Fin k)` wherever they
appeared. Measured 2026-09-09: **all 127 of their occurrences reach the carrier extractor as
binders**, so that arm never once fired where it was right and always fired where it asked the
wrong question. The dual defect — *emptiness at positive polarity, i.e. inside a hypothesis* — is
real, is Phase C of `plans/STUB-vacuity-coverage.md`, and needs a different technique
(hypothesis mutation); this file does not attempt it and says so.

## A refutation is skipped, structurally

A declaration whose conclusion is `False` says *these cannot all hold*: its binders are **meant**
to be jointly unsatisfiable. `isEmpty_coloring_plane_four` is the example — a proof that the plane
has no four-colouring, whose only binder is a four-colouring of the plane. Flagging it would be
flagging a theorem for its own content. One structural rule, and it replaces two ad-hoc
mechanisms the extension first grew: a set of "providers" threaded through the evidence so a
refutation was not audited against the emptiness it proves, and the baseline's prose exemption for
statements consumed in order to refute. It does **not** blind the check to the case that motivated
it — `core9_plane` concludes an `∃`, not `False`, and is still flagged. Verified, not assumed.

## The controls, and why they could not be run until 2026-09-09

`CLAUDE.md` § "Make the gate fail, and watch it fail" requires the negative control at every
milestone. This gate's could not be run at all: `isOurs` could not see declarations made in the
file being elaborated, so a planted control was invisible and testing meant editing a library
module and rebuilding; and once that was fixed, the first control that ran came back with a
clean-looking **wrong answer**, because `lake env lean` does not apply the lakefile's
`autoImplicit := false` and the control's `pathGraph` silently auto-bound to a fresh variable,
making it a different, generic statement. Both are repaired at the top of this file, and
`scripts/vacuity.sh --self-test` plants seven controls — including the load-bearing one, the same
family at an instantiation nothing refutes, which must come back `UNKNOWN` and never `VACUOUS`.

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

-- `lake env lean` does NOT apply the lakefile's options, so `autoImplicit := false` is not in
-- force here (CLAUDE.md § Toolchain). Without these two lines a planted control's `pathGraph`
-- auto-binds to a fresh variable, the control silently becomes a DIFFERENT statement, and the
-- run returns a clean-looking wrong answer. Measured, 2026-09-09.
set_option autoImplicit false
set_option relaxedAutoImplicit false

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
  | _ :: rest :: _ => some (((rest.splitOn "\n").headD "").trimAscii.copy)
  | _ => none

/-- Is this declaration one of ours, rather than Mathlib's or core's? -/
def isOurs (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | some idx =>
    match env.header.moduleNames[idx.toNat]? with
    | some m => (`Proofs.HadwigerNelson).isPrefixOf m || m == `Proofs
    | none => false
  -- No module index means the declaration was made in the file being elaborated RIGHT NOW.
  -- Those are ours too, and saying so is what makes a planted control a one-file operation
  -- instead of a library edit plus a full rebuild. Without it the gate cannot see its own
  -- controls at all, which is how `CLAUDE.md` § "Make the gate fail" went unenforced here.
  -- The audit's OWN declarations are the exception: they are the instrument, not the library, and
  -- counting them made `declarations=` move whenever this file was edited — measured 2026-09-11, when
  -- adding the report's `Row` structure moved it by 20 with the library unchanged. The planted
  -- controls live in `HadwigerNelson`, so they stay visible.
  | none => !(`VacuityAudit).isPrefixOf n

/-- **The named carrier families.** A *named* list, never "every `Prop` binder": measured
2026-09-09, `HadwigerNelson.Justified` alone owns **1,426** binder sites (the LRAT watermark
induction, inhabited by construction), and the algebraic carriers — `Q4`, `Pt`, `Ival`,
`ClauseTable`, … — add some eight hundred more that are always inhabited. The signal drowns.

Two exclusions are worth their reasons, because both look like obvious additions:

* **`UDCert`, `Gadget`, `Brick` are absent on purpose.** They are `structure`s — records of lists
  and integers — so "does one exist" is answered by writing one down. The live question for a
  certificate is *validity*, and `UDCert.Valid : UDCert n → Bool` is an equation `decide` settles.
  Adding them buys ~100 parametric lines and ~37 lines that are the constructions themselves.
* **`Forces`, `Separated` and `Fan` ARE here**, and that is a correction. They used to be
  special-cased into `G.Coloring (Fin k)` at every occurrence; see `carrierOf?` for why that is
  the right move at a conclusion and the wrong question at a binder.

**The Lean backlog's plane vocabulary (`Proofs/HadwigerNelson/Plane/`), decided structure by structure
(FS131-T1, 2026-10-04):**

* **`Plane.AeColouring` is IN.** It is a structure, but not a record of data: `AeColouring k` is the
  measurable analogue of `(unitDistance ℂ).Coloring (Fin k)`, a *type whose emptiness is a theorem*
  (`IsEmpty (AeColouring 1)`, and the bounds to come), so a binder `(c : AeColouring 1)` is exactly the
  `core9_plane` shape. Before this entry the scan was blind to it: a planted
  `theorem (c : AeColouring 1) (x : ℂ) : x = x` raised no site (FS131-I1; reproduced by FS131-T1). A
  theorem over `AeColouring k` at a variable `k` reads `GENERIC`; at `k = 0, 1` it reads `VACUOUS`
  (undeclared) or `DECLARED`; at a concrete `k` nothing refutes it reads `UNKNOWN` until a witness
  (`def c : AeColouring 9`, or `Nonempty`) is proved.
* **`Plane.ArcMap.Valid`, `ArcMap.NonSiamese`, `ArcMap.Simple` are IN**, as `Prop` carriers like `Forces`:
  a hypothesis `(h : F.Valid)` about a CONCRETE map is the shape that can be refuted
  (`¬ (ArcMap.const univ _ 0).Valid`), and `Valid` is the content of "a valid fragment". At a variable `F`
  they read `GENERIC`, which is correct: the objects whose joint existence is the open question
  (`∃ F : ArcMap 6, F.IsPlaneMap ∧ F.Valid`) are a conjunction ACROSS binders, which this per-binder scan
  cannot see, and no check here decides it. Entering them buys the concrete-map case and nothing more.
* **OUT, with reasons.** `ArcMap k`, `Arc`: data — the lists, sets and a locally-finite proof that `UDCert`
  is (`ArcMap.const`, `halfDisc` are the inhabitants, written down); tracking the bare type would flag every
  statement at `ArcMap 0`'s emptiness (a function into `Fin 0`), which is no one's content.
  `Covers`, `IsPlaneMap`, `IsTile`, `Siamese`, `IsJordanDomain`, `coloursAt`: facts about the domain or its
  tiles, satisfiable by `const`, never the hidden hypothesis. `UnitPairsNull`, `IsMUA`: predicates of a SET
  variable, `GENERIC` at every site, with no refutation theorem of the `¬ P` shape to collect; they would add
  lines and no signal.

**How a later wave registers its carriers.** A new structure or predicate that a theorem may take as a
hypothesis gets a line in the list above, by this procedure: (1) decide it IN or OUT and write the decision with
its reason, in the `UDCert` / `AeColouring` style — IN iff "does one exist" is a theorem rather than a
construction, or the predicate can be refuted at a concrete instance; (2) if IN, add its FULL name, namespace
included (e.g. `HadwigerNelson.Plane.AeCover`), to `trackedProps` below; (3) plant controls in
`scripts/vacuity-controls.lean` — an empty instance reading `VACUOUS`, a variable instance reading `GENERIC`,
and for a family whose concrete carrier nothing refutes, one reading `UNKNOWN` — and add their `expect` lines to
`scripts/vacuity.sh --self-test`; (4) run `./scripts/vacuity.sh --self-test`, then `./scripts/vacuity.sh`, and
explain every change in `sites` and in the verdict counts against the previous run. A mistyped name is tracked
by NOTHING and raises no error — step (3)'s control is what catches that. -/
def trackedProps : List Name :=
  [`HadwigerNelson.Forces, `HadwigerNelson.Separated, `HadwigerNelson.Fan,
   `HadwigerNelson.AdditivelyRigid, `HadwigerNelson.Extends, `HadwigerNelson.IsStress,
   `HadwigerNelson.IsLift, `HadwigerNelson.Aperiodic, `HadwigerNelson.CoincidesAtNonedges,
   `HadwigerNelson.IsAdditive, `HadwigerNelson.Compels, `HadwigerNelson.Realizes,
   `HadwigerNelson.MonoPair, `HadwigerNelson.CoverAtLeast, `HadwigerNelson.UDCert.CoordsIn,
   -- the Lean backlog's plane vocabulary (FS131-T1)
   `HadwigerNelson.Plane.AeColouring, `HadwigerNelson.Plane.ArcMap.Valid,
   `HadwigerNelson.Plane.ArcMap.NonSiamese, `HadwigerNelson.Plane.ArcMap.Simple]

/-- A carrier or a statement as one line of text, for the report. Called where its binders are still in
scope: outside the telescope a generic carrier's variables print as `_fvar.N`, whose numbering shifts
whenever the library changes, so two runs could not be compared row for row. Never throws — a carrier
that will not print is still audited and still reported. -/
def showCarrier (τ : Expr) : MetaM String := do
  try
    return ((← ppExpr τ).pretty 1000000).replace "\n" " "
  catch _ =>
    return "<did not pretty-print>"

/-- **The evidence the library already holds.**

`SimpleGraph.Colorable G n` is *definitionally* `Nonempty (G.Coloring (Fin n))`, so every
unconditional `Colorable` theorem in this repository is already a non-vacuity witness and every
`IsEmpty (… Coloring …)` theorem is already a vacuity proof. Neither is an `instance`, so instance
search alone finds nothing — which is why the first run of this audit returned 249 `UNKNOWN` and
zero verdicts, including on `core9_plane`, the declaration that motivated the whole check.

So the audit collects that evidence from the environment rather than asking anyone to tag it.
Only **unconditional** witnesses count: a theorem with real hypotheses is a conditional claim, and
"someone could probably discharge those" is precisely the social argument the kernel replaces.

Each piece is kept with the declaration that supplied it and its statement as text, so the report can
say which theorem decided a verdict. -/
structure Evidence where
  empties   : Array (Name × Expr × String) := #[]
  witnesses : Array (Name × Expr × String) := #[]

/-- **One relation, several recognizers.** Every rule below collects a declaration whose type is
*definitionally* `Nonempty τ` or `IsEmpty τ`:

* `IsEmpty α`            — itself;
* `¬ P`                  — `IsEmpty P`, for a tracked `P`;
* `Colorable G k`        — `Nonempty (G.Coloring (Fin k))`, the definitional fact this whole
                           check turns on, and the reason instance search alone finds nothing;
* `Nonempty α`           — itself;
* a constant `c : τ` whose type IS a carrier — `Nonempty τ` by `⟨c⟩`. A `def` of a colouring
                           (`hexColoring`, `pathColoring3`) is the most direct witness there is,
                           and the check used to flag those very definitions as unresolved.

Only **unconditional** declarations count: one with real hypotheses is a conditional claim, and
"someone could probably discharge those" is the social argument the kernel replaces. -/
def gather (env : Environment) : MetaM Evidence := do
  let mut ev : Evidence := {}
  for (n, ci) in env.constants.toList do
    if n.isInternal || !isOurs env n then continue
    -- A refutation `¬ P` is emptiness evidence for `P`, and it must be read WITHOUT reducing:
    -- `Not P` IS `P → False`, so a reducing telescope eats the arrow, the evidence is lost, AND
    -- the refutation becomes one more site carrying a hypothesis nothing satisfies — the
    -- emptiness proof flagged by the very emptiness it proves.
    let refuted : Option (Expr × String) ← (try forallTelescope ci.type fun xs concl => do
        for x in xs do
          if !(← x.fvarId!.getDecl).binderInfo.isInstImplicit then return none
        let some p := (if concl.getAppFn.constName? == some ``Not then concl.getAppArgs[0]? else none)
          | return none
        -- its statement as text, taken here, where the binders still have names
        return some (p, ← showCarrier p)
      catch _ => pure none)
    if let some (p, shown) := refuted then
      if !p.hasLooseBVars then
        if let some h := p.getAppFn.constName? then
          if trackedProps.contains h then
            ev := { ev with empties := ev.empties.push (n, p, shown) }
            continue
    let found : Option (Expr × String) ← (try forallTelescopeReducing ci.type fun xs concl => do
        -- only instance-implicit binders may remain: anything else is a real hypothesis
        for x in xs do
          if !(← x.fvarId!.getDecl).binderInfo.isInstImplicit then return none
        -- the statement as text, for the report, and only for the shapes that can be evidence
        let evidential := match concl.getAppFn.constName? with
          | some h => h == ``IsEmpty || h == ``Nonempty || h == ``SimpleGraph.Colorable ||
              h == ``SimpleGraph.Coloring || trackedProps.contains h
          | none => false
        let shown ← if evidential then showCarrier concl else pure ""
        return some (concl, shown)
      catch _ => pure none)
    let some (τ, shown) := found | continue
    if τ.hasLooseBVars then continue
    match τ.getAppFn.constName? with
    | some ``IsEmpty =>
      if let some c := τ.getAppArgs[0]? then
        if !c.hasLooseBVars then ev := { ev with empties := ev.empties.push (n, c, shown) }
    | some ``Nonempty =>
      if let some c := τ.getAppArgs[0]? then
        if !c.hasLooseBVars then ev := { ev with witnesses := ev.witnesses.push (n, c, shown) }
    | some ``SimpleGraph.Colorable =>
      let a := τ.getAppArgs
      if 2 < a.size then
        if !a[1]!.hasLooseBVars && !a[2]!.hasLooseBVars then
          let c ← mkAppM ``SimpleGraph.Coloring #[a[1]!, ← mkAppM ``Fin #[a[2]!]]
          ev := { ev with witnesses := ev.witnesses.push (n, c, shown) }
    | some ``SimpleGraph.Coloring =>
      -- `def c : G.Coloring (Fin k)` — the inhabitant, stated as a definition.
      ev := { ev with witnesses := ev.witnesses.push (n, τ, shown) }
    | some h =>
      if trackedProps.contains h then ev := { ev with witnesses := ev.witnesses.push (n, τ, shown) }
    | none => pure ()
  return ev

/-- The first collected piece of evidence `τ` matches, named by the declaration that supplied it.
Compared under `withNewMCtxDepth` inside `withoutModifyingState`, so a probe can never leak an
assignment into the next one. -/
def firstMatch? (τ : Expr) (cands : Array (Name × Expr × String)) : MetaM (Option Name) := do
  for (n, c, _) in cands do
    let hit ← withoutModifyingState <| withNewMCtxDepth <| (try isDefEq τ c catch _ => pure false)
    if hit then return some n
  return none

/-- Ask whether `τ` is provably empty, provably inhabited, or neither — and say what decided it: the
declaration whose statement matched, or `instance search`.

The third answer is the point. A carrier this check cannot decide is reported and counted, never
passed over in silence — this repository has twice shipped a gate that failed open. -/
def probe (ev : Evidence) (τ : Expr) : MetaM (Verdict × String) := do
  if let some n ← firstMatch? τ ev.empties then return (.vacuous, toString n)
  if let some n ← firstMatch? τ ev.witnesses then return (.witnessed, toString n)
  -- instance search as a fallback, for carriers whose inhabitedness is structural
  let synth (head : Name) : MetaM Bool := do
    try
      match ← synthInstance? (← mkAppM head #[τ]) with
      | some _ => pure true | none => pure false
    catch _ => pure false
  if ← synth ``IsEmpty then return (.vacuous, "instance search")
  if ← synth ``Nonempty then return (.witnessed, "instance search")
  return (.unknown, "")

/-- **The carrier a binder commits to — taken as it stands, never unfolded.**

The law this implements, and it is one law rather than two: *a statement is vacuous exactly when
some `∀`-binder of it has an empty domain.* Everything else follows from where the binder sits.

* A binder `(C : G.Coloring α)` is the `core9_plane` shape. Carrier: itself.
* A binder `(h : Forces G k p q)` is **not** that shape, and unfolding it is the wrong question.
  `Forces G k p q` is `∀ C : G.Coloring (Fin k), C p = C q`, so an empty `Coloring` makes the
  hypothesis **true and free** — the theorem then says its conclusion outright, which is an
  *overclaim* and not a vacuity. The carrier is `Forces G k p q` itself, refuted by the library's
  own `not_forces_*` theorems.
* A `Forces` **conclusion** needs no rule here at all: `forallTelescopeReducing` unfolds it and
  hands back the binder `C : G.Coloring (Fin k)`, which is the first case (verified on
  `rhombus_forces`, 2026-09-09). Measured the same day: all 127 `Forces`/`Separated`/`Fan`
  occurrences reach this function as **binders**, so the old rebuild-as-`Coloring` arm never once
  fired where it was right and always fired where it was wrong.

**Known limit, stated rather than chased:** a carrier reachable only *inside* a data structure —
`Set (G.Coloring (Fin 4))`, a structure field — is out of scope. This reads `∀`-binders. -/
def carrierOf? (e : Expr) : MetaM (Option Expr) := do
  match e.getAppFn.constName? with
  | some ``SimpleGraph.Coloring => return some e
  | some n => return if trackedProps.contains n then some e else none
  | none => return none

/-- Every carrier a declaration's statement commits to: each binder's type, plus the conclusion.

**A refutation is skipped, structurally.** A declaration whose conclusion is `False` says *these
cannot all hold*: its binders are **meant** to be jointly unsatisfiable, so flagging one for
emptiness is flagging the theorem for its own content. `isEmpty_coloring_plane_four` is the
example — a proof that the plane has no four-colouring, whose only binder is a four-colouring of
the plane. This one rule replaces two ad-hoc mechanisms: a `providers` set threaded through the
evidence, and the baseline's prose exemption for statements "consumed in order to refute".

It does **not** blind the check to the case that motivated it: `core9_plane` concludes an `∃`,
not `False`, and is still flagged. Verified, not assumed. -/
def carriersOf (type : Expr) : MetaM (Array (Expr × String)) :=
  forallTelescopeReducing type fun xs concl => do
    if concl.isConstOf ``False then return #[]
    let mut out : Array Expr := #[]
    for x in xs do
      if let some τ ← carrierOf? (← inferType x) then out := out.push τ
    if let some τ ← carrierOf? concl then out := out.push τ
    -- Each carrier's text is taken HERE, inside the telescope, where its binders still have names.
    (out.filter (!·.hasLooseBVars)).mapM fun τ => do return (τ, ← showCarrier τ)

/-- **Is this declaration generated by a `structure` or `inductive` command?** Constructors, recursors,
`casesOn`, `noConfusion`, `ctorIdx` and field projections are machine-written API of a type, not statements
anyone chose: each of them concludes (or binds) the tracked structure at a variable index, so a tracked
structure of ours would add a dozen `GENERIC` rows — measured on `AeColouring` by FS131-T1: 12 of the first
run's 13 new rows were these. They are still COUNTED in `declarations=`, and
skipped only where a site would be made. A declaration the author wrote — a `def c : AeColouring 9`, a
theorem — is never one of these and is always audited. -/
def isGeneratedDecl (env : Environment) (n : Name) (ci : ConstantInfo) : Bool :=
  (match ci with | .ctorInfo _ | .recInfo _ => true | _ => false) ||
  isAuxRecursor env n || isNoConfusion env n || (env.getProjectionFnInfo? n).isSome ||
  (match n with | .str _ s => s == "ctorIdx" || s == "noConfusionType" | _ => false)

/-- One audited site: a declaration, one carrier its statement commits to, and the verdict on it. -/
structure Row where
  decl    : Name
  verdict : Verdict
  /-- the `VACUITY DECLARED:` reason, when the declaration's docstring gives one -/
  reason  : String
  /-- the carrier as one line, printed where its binders are in scope -/
  carrier : String
  /-- what decided a `witnessed` or `vacuous` probe: a declaration's name, or `instance search` -/
  source  : String

/-- Run the audit and print its report. Machine-readable by design — `scripts/vacuity.sh` and
`scripts/gate_report.py` parse these lines, so the format is a contract:

* `evidence: …`; `=== DECLARED ===` rows `DECLARED <decl> :: <reason>`; `=== FLAGGED ===` rows
  `<VACUOUS|STALE|UNKNOWN> <decl>` — the rows the gate decides on;
* `=== EVIDENCE ===` rows `EVIDENCE <EMPTY|WITNESS> <decl> :: <statement>` — every piece of evidence
  gathered, by the declaration that supplied it;
* `=== SITES ===` rows `SITE <verdict> <decl> :: <carrier>`, ending ` [by <source>]` when evidence or
  instance search decided the probe — every site, all six verdicts. The gate reads none of these; they
  exist so that nothing the scan decided is lost, and a run can be compared with the last one row for row;
* `=== SCANNED ===` and `=== TOTALS ===` — the accounting, whose silent drift is this gate's own failure
  mode. -/
def audit : CommandElabM Unit := liftTermElabM do
  let env ← getEnv
  let ev ← gather env
  logInfo m!"evidence: {ev.empties.size} emptiness proof(s), {ev.witnesses.size} colourability witness(es)"
  let mut rows : Array Row := #[]
  let mut scanned : Nat := 0
  let mut refutations : Nat := 0
  let mut untelescoped : Nat := 0
  for (n, ci) in env.constants.toList do
    if n.isInternal || !isOurs env n then continue
    scanned := scanned + 1
    if ← (try forallTelescopeReducing ci.type fun _ c => pure (c.isConstOf ``False) catch _ => pure false) then
      refutations := refutations + 1
    if isGeneratedDecl env n ci then continue
    -- A declaration whose type cannot be telescoped is NOT silently skipped (review 2026-09-13): it is
    -- counted and named, and `vacuity.sh` fails on a nonzero count — a check that cannot run fails loud.
    let carriers ← try carriersOf ci.type catch e => do
      logWarning m!"UNTELESCOPED {n}: carriersOf failed ({e.toMessageData}); declaration not classified"
      untelescoped := untelescoped + 1
      pure #[]
    for (τ, shown) in carriers do
      -- Probe FIRST, always: a carrier that is demonstrably empty must be reported as such even
      -- when it is generic, so classification can never let a real vacuity escape. `generic` is
      -- only ever a refinement of an INCONCLUSIVE result.
      let (probed, source) ← probe ev τ
      let raw := if probed == .unknown && (← instantiateMVars τ).hasFVar then .generic else probed
      -- The declaration is CHECKED against the probe, never merely trusted.
      let reason := (← findDocString? env n).bind reasonIn?
      let (v, r) := match raw, reason with
        | .vacuous, some r => (Verdict.declared, r)
        | .vacuous, none   => (Verdict.vacuous, "")
        | _,        some r => (Verdict.stale, r)
        | v,        none   => (v, "")
      trace[vacuity] "{n} : {Verdict.tag v}"
      rows := rows.push { decl := n, verdict := v, reason := r, carrier := shown, source := source }
  let count (v : Verdict) := rows.filter (·.verdict == v) |>.size
  logInfo m!"=== VACUITY AUDIT ==="
  -- Declared emptiness gets its own banner with its reasons, the way the axiom audit prints its
  -- purchases: the point is that every deliberate case is READABLE IN ONE PLACE and challengeable.
  logInfo m!"=== DECLARED ==="
  for row in rows do
    if row.verdict == .declared then logInfo m!"DECLARED {row.decl} :: {row.reason}"
  -- Only these reach the gate. `generic` is counted in the totals and deliberately absent here:
  -- it is not work anyone can do, so it must not sit in a list whose target is zero.
  logInfo m!"=== FLAGGED ==="
  for row in rows do
    if row.verdict == .vacuous || row.verdict == .stale || row.verdict == .unknown then
      logInfo m!"{row.verdict.tag} {row.decl}"
  -- Everything else the scan decided, so that no question it already answered — which theorem
  -- witnesses a site, which sites are generic, which are new since the last run — needs a second scan.
  logInfo m!"=== EVIDENCE ==="
  for (d, _, s) in ev.empties do logInfo m!"EVIDENCE EMPTY {d} :: {s}"
  for (d, _, s) in ev.witnesses do logInfo m!"EVIDENCE WITNESS {d} :: {s}"
  logInfo m!"=== SITES ==="
  for row in rows do
    let decidedBy := if row.source.isEmpty then "" else s!" [by {row.source}]"
    logInfo m!"SITE {row.verdict.tag} {row.decl} :: {row.carrier}{decidedBy}"
  -- Accounting, because an unexplained change in the site count is exactly the failure mode
  -- `D1` was: a silently disabled arm that still printed a plausible report.
  logInfo m!"=== SCANNED === declarations={scanned} refutations-skipped={refutations}"
  logInfo m!"=== TOTALS === sites={rows.size} vacuous={count .vacuous} stale={count .stale} declared={count .declared} witnessed={count .witnessed} generic={count .generic} unknown={count .unknown} untelescoped={untelescoped}"

end VacuityAudit

#eval VacuityAudit.audit
