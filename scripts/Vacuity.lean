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

* **Wave 3's carriers (FS131-I3h, by the procedure below).** **IN**: `ArcMap.IsRingArc`, `ArcMap.IsQArc`,
  `ArcMap.IsChangePoint`, `ArcMap.IsHub` — each refutable at a concrete map (`halfPlane2_not_isRingArc`: `halfPlane2`'s
  ring carries no arc of `Γ`, hence no (Q) arc; `r(90°) = i` is off its `Γ`, so no change point and no hub there), so a
  theorem taking one at an empty instance is a real defect; controls 21–32. **OUT**: `CircleColouring` (existence is a
  construction, `hexColouring`); `CircleColouring.Lift` (`exists_lift` inhabits it for every colouring, so its binder is
  never empty); `IsTile`, `TileOf`, `GermIn` (refutable only at a concrete set, which no theorem fixes: every site is a
  set variable, `GENERIC`); `IsEssBoundary`, `SaturatedAt` (refuting either at a concrete instance is a density
  computation the library makes only inside an `example`; their one consumer, in `Plane/RingGerm`, takes them at a
  variable map; register them when a wave proves such a refutation as a theorem).
* **The sector structure (FS131-I3i, by the procedure below).** **OUT**: `BranchGerms` (data — two angle and two curvature
  functions — written down, `⟨![0, π], ![0, 0]⟩`); `BranchGerms.Sorted`, `BranchGerms.Mono` (predicates of that data, true
  or false by a computation on a written-down instance); `ArcMap.IsSectorChart` — its existence at every point of the
  domain is a theorem (`localSectors`, inhabitant `halfDisc_sectorChart`), and every site takes it at a variable map, germ
  list, point and radius (`IsSectorChart.exists_tile_inter_ball`, `.sector_nonempty`, `.sector_subset_interiorPts`), so it
  reads `GENERIC` everywhere, like `IsTile`; register it when a theorem takes it at a concrete instance or proves a
  refutation `¬ F.IsSectorChart G v r₀` as a theorem.

* **Wave 2's carriers (FS131-I2n, by the procedure below).** **IN**: `Plane.CPColouring` — the `AeColouring` case again, a
  structure whose emptiness is a theorem (`IsEmpty (CPColouring 0)`, `IsEmpty (CPColouring 1)`, both `instance`s, which the evidence
  collector reads as it reads `AeColouring`'s) and whose inhabitant at `9` is a theorem (`nonempty_cpColouring_nine`); controls 33–35.
  `Plane.SemiconcaveWith` — refuted at a concrete instance by a theorem (`not_semiconcaveWith_one_lowerArc`: the lower unit arc is
  not `1`-semiconcave on `(1/10, 1/5)`), so a theorem taking it at a refuted instance is a real defect; controls 36–38. **OUT**,
  each a predicate of a set, family, function or field variable, `GENERIC` at every site, with no `¬ P` theorem at a concrete
  instance: `AeLE`, `IsAdmissible`, `IsAeCover`, `IsMaximalCover`, `IsSelection`, `IsRegularMUA`, `IsFreeFor`, `IsContactFor`,
  `Saturated`, `SaturatedPos`, `BandNull`, `BandFree`, `IsGridUnion`, `IsPeriodicSet`, `IsPartialColouring`, `IsTiled`,
  `IsPeriodic`, `IsLowerGraphOf`, `CurvatureLeOne`, `IsMaxIn`, `KeptAt`, `IccPairNull`, `WeakStarTendsto`, `G1Bounds`,
  `CPColouring.RotationInvariant`, `IsUsablePrime`, `IsPlaceHom`, `NoAffFieldHyp`, `DyadicSqrt3Conclusion`; `AeColouring.Tight`
  and `AeColouring.HasSlack` (positive facts at concrete colourings, `sq9_tight`, `exists_r7`, and no refutation stated as a
  theorem — register them when one is); `PieceH`, `PieceF`, `PieceQ`, `hcFlank` (inequalities between numbers, decided where
  they occur); `Row130M1` and `Voronov11`, closed propositions consumed as named hypotheses — the first an outside hand result
  (`LEAN.md` § Assumptions: it leaves when discharged), the second a form of the open question itself (`forall_mu_six_lt_one_iff`),
  so tracking either would add `UNKNOWN` sites nobody can discharge, which the shrink-only baseline cannot hold. The sets and
  data of `Plane/CoverExamples` (`hcSet`, `hcBand`, `hcN0`, `hcKZ`, `r7Col`, `sq9`, …) are never binder types.

* **Wave 4's carriers (FS131-G4, by the procedure below; the plan's recommendation, `plans/FS131-w4-kernel-plan.md` § 14.3).** **IN**:
  `ArcMap.IsHorn` — refuted at a concrete map by a theorem (`bowtie_not_isHorn_I_axis`: the bowtie has no horn at `i`), inhabited by
  `cuspFrag_isHorn`; controls 39–41. `ArcMap.IsStuck` — refuted at a concrete map (`bowtie_not_isStuck_I`), inhabited at the bowtie's
  centre (`bowtie_isStuck`'s first clause); controls 42–44. `ArcMap.Condition5` — refuted at a concrete map (`unitArcPlane_not_condition5`:
  a unit arc meets `ω(0)` in infinitely many points); controls 45–47. `Plane.AeProperRegions` — the `AeColouring` case again, a structure
  whose emptiness is a theorem (`IsEmpty (AeProperRegions 0)`, `IsEmpty (AeProperRegions 1)`, both `instance`s) and whose inhabitant at `7`
  is a definition (`sevenBrickRegions`); controls 48–50 (inventory items 144 (b), 153). **OUT**: `ArcMap.Terminal`, `ArcMap.TerminalOn` —
  refuting either at a concrete map needs a map with an available move (a colour with two sectors and an open allowed cone, or a horn),
  which no theorem of the library exhibits, and every site takes them at a variable map (`stuck_chain`, `stuck_neighbour`); the objects whose
  existence is the question (a terminal plane map with a stuck vertex) are a conjunction across binders, which this scan cannot see;
  register them when a refutation `¬ X.Terminal` is proved as a theorem. `ArcMap.MergeAvailable`, `RayAvailable`, `ShaveAvailable` (taken
  negated, inside `IsStuck` and `TerminalOn`); `IsFlankAbove`, `IsFlankBelow`, `DoublyShadowed`, `IsContact`, `InType`, `OutType`, `IsSector`,
  `HasSectors`, `HasDegree`, `HasRepeatedColour`, `IsCubicTrichromatic`, `IsClear`, `TanAbove`, `TanBelow` (facts about a point's sectors,
  flanks and contacts, decided where they occur, at a variable map at every site, like `IsSectorChart`); `InContact`, `OutContact`,
  `BothKind`, `Inert`, `IsR2Arc` (an `IsRingArc` with a colour clause: the tracked `IsRingArc` already audits the arc); `Condition6`,
  `InMK` (satisfied by the one-colour plane, Basic's spec examples, with no refutation stated as a theorem); `AgreesOff`, `RingArcsWithin`
  (relations between two maps, reflexive, so never empty at `F' = F`, and conclusions of the moves); `IsCoveringPair` (taken negated);
  `ArcMap.Near` (a chart near a point: data, built where it is used) and `Near.Small`, `Near.RayConfig` (predicates of that data, at a
  variable chart at every site); `IsLeavingCentre`, `StripHolds`, `MIn`, `AeProperRegions.IsRegion` (predicates of a point or a set
  variable, `GENERIC` at every site, with no `¬ P` theorem at a concrete instance).

* **Woodall's carriers (FS131-WL1, by the procedure below).** **IN**: `ArcMap.SectorsAt` — refuted at a concrete instance by a theorem
  (`threeSectorDisc_not_sectorsAt_one`: no picture at `1`, off the disc's domain), inhabited by `threeSectorDisc_sectorsAt`; controls 51–53.
  `ArcMap.NiceAt` — refuted at a concrete point (`threeSectorDisc_not_niceAt_one`), inhabited by `threeSectorDisc_niceAt`; controls 54–56.
  `ArcMap.WoodallMerged` and `ArcMap.WoodallNormal` — refuted at a concrete map (`puncturedThreeSectorDisc_not_woodallMerged`,
  `_not_woodallNormal`: a point of three colours off the domain), inhabited on a map of the plane by `sevenBrickMap_woodallMerged`,
  `sevenBrickMap_woodallNormal` (FS131-QA2's QA2-1); controls 57–59 and 60–62. Every binder site of the two normal forms is a refutation
  (`aeMap6_normal`, `aeMap6_merged`, `false_of_four_le_sectors`), which the scan skips. Both are `∀ v ∈ K, …` by definition, so the reducing
  telescope reads a conclusion `F.WoodallMerged K` through to its `NiceAt v` (a `GENERIC` site) and `gather` collects neither inhabitant as a
  witness: a theorem taking one at a concrete map as a hypothesis would read `UNKNOWN` until a closed `Nonempty (F.WoodallMerged K)` is stated
  (none does today; the emptiness evidence, read unreduced from `¬ P`, is unaffected). **OUT**: `annSector`, `collar`, `Rim`, `Rim.radii`, `wedgeArcs`, `ArcMap.recolour`, `wedgeMerge`, `isoRad`, `rightCol`,
  `leftCol`, `threeCol`, `threeCuts`, `threeSectorDisc`, `puncturedThreeSectorDisc`, `brickCellCol`, `tUpDirs`, `tUpCols`, `tDownDirs`,
  `tDownCols`, `brickClosedCell` (data and sets, written down); `CollarAt`, `ArcMap.CrossesAt`, `ArcMap.DirColourAt`, `OffDirs`
  (predicates of a set, map, finite set or direction variable, `GENERIC` at every site, with no `¬ P` theorem at a concrete instance —
  register them when one is).

* **MERGE's carriers (FS131-ML1, by the procedure below; `Plane/ValidMap/MergeMove`).** **No new carrier IN.** **OUT**:
  `BranchGerms.Phantom` (a germ whose predecessor has its colour: a predicate of a germ list and a colouring, decided by a computation on
  written-down data — both values are spec examples in `MergeMove` — taken as a hypothesis only negated, at a variable chart,
  `branchPt_mem_mergeArcs_outer`); `hgt`, `BranchGerms.idx`, `turns`, `lift`, `liftDir`, `gapGerm`, `gapSec`, `branch`, `gapSet`,
  `mergeCol`, `rimArc`, `mergeArcs`, `Near.chain` (numbers, indices, functions, arcs and sets, written down). Every other hypothesis
  `MergeMove` takes is a carrier decided above: `Valid` and `Condition5` IN — MERGE's 15 sites, 13 on `Valid` and 2 on `Condition5`, all
  `GENERIC` at a variable map, the restored `exists_merge` and `exists_merge_aux` among them — and `Near`, `Near.Small`, `Covers`,
  `HasSectors`, `IsClear`, `IsTile` OUT.

* **OPEN's carriers (FS131-OL1, by the procedure below; `Plane/ValidMap/OpenMove`).** **No new carrier IN.** **OUT**:
  `ArcMap.HasHornCount` (a fact about a point's sectors — for every small radius, exactly `j` of them are horn sets — like `HasSectors` and
  `HasDegree`: decided where it occurs, at a variable map at every site, `HasHornCount.eq`, `Near.hasHornCount_chart`,
  `Near.open_degree_horns`, `exists_open`; both of its spec values are positive `example`s, `HasHornCount 0 0` at the constant map and
  `cuspFrag.HasHornCount 0 2`, and no refutation is stated as a theorem — register it when one is); `Near.OpenConfig` (OPEN's
  configuration at a chart: a `Prop`-valued structure of eleven facts about a chart's written-down germs, colours and radii, taken at a
  variable chart at every site, like `Near.RayConfig`; under OPEN's hypotheses its existence is a theorem, `Near.exists_openConfig`, and no
  theorem refutes it at a concrete chart — register it when one does, or when a theorem takes it at a concrete chart);
  `BranchGerms.hornPos`, `rayPos`, `openWedge`, `openCol`, `openRim`, `openPiece`, `openRest`, `openArcs`, `openRay`, `Near.openSectors`
  (indices, sets, a colouring and arcs, written down). Every other hypothesis `OpenMove` takes is a carrier decided above: `Valid`,
  `IsHorn` and `Condition5` IN — OPEN's 14 sites, 11 on `Valid`, 2 on `IsHorn` (`Near.exists_openConfig`, `exists_open`) and 1 on
  `Condition5` (`Near.open_condition5`), all `GENERIC` at a variable map — and `Near`, `Near.Small`, `Covers`, `HasSectors`, `HasDegree`,
  `IsClear` OUT. `exists_open`'s hypotheses hold together on no map of the library yet (its docstring's inhabitant note: FS131-E6's
  twelve-colour map, at [hand]); that is a conjunction across binders, which this per-binder scan cannot see.

* **Wave 5's carriers (FS131-L5, by the procedure below; the 29 modules of the limit, the procedure, the terminal maps, the bends, the
  base's walk and the planar reduction, `Plane/ValidMap/Limit` to `Thomassen`).** **No new carrier IN.** The wave declares sixty
  hypothesis-formers (every definition, structure and inductive of the `Plane` modules and of `Thomassen` whose type ends in a sort and
  which `main`'s library did not hold, listed by `data/fs131/l5/census.lean` with what the library proves of each): none has an
  unconditional `¬ P …` at a closed instance and none an `IsEmpty` instance — the two shapes `gather` reads as emptiness — so for none
  could step (3)'s `VACUOUS` control be planted, and entering one would add `GENERIC` rows and no signal. **OUT**, by kind:
  - **the base's context**: `ArcMap.BaseCtx` (26 binder sites, `BaseWalk` and `BaseDense`) bundles `Row134BaseUA`'s hypotheses at a
    six-coloured fragment and is **empty at every instance** — `BaseCtx.false`, a refutation over variable `F`, `u`, which this scan
    skips and cannot read as evidence. Every theorem taking it is a step inside that proof by contradiction and says so in its
    docstring ("no model expected", naming `row134BaseUA`), which is what `LEAN.md` § The gate asks of such a step. Tracked, each
    site would read `GENERIC`, which is false of a carrier known empty; it is kept out and the fact is recorded here. Its fields
    `ArcMap.BaseHyp`, `NoInertNear`, `UnenclosedC` are predicates of a point of a variable map, each satisfied on `sevenBrickMap`
    (`sevenBrick_baseHyp`, `sevenBrick_noInertNear`, `sevenBrick_unenclosedC`; `not_row134BaseUA_seven` reads all at once at seven
    colours); `ArcMap.Unenclosed` is the stronger form of the last (`Unenclosed.unenclosedC`). `Row134BaseUA` is a closed
    proposition, proved (`row134BaseUA`), never a binder;
  - **clause packages, `Prop`-valued structures at a variable map at every site**, none refuted at a concrete instance by a theorem —
    register one when it is: `ArcMap.ArcBend` (the arc step's interface; inhabited at `l60Frag`'s collar bend, `ArcStep`'s spec
    example), `ArcMap.AwayBend` (`AwayBend.idle`), `ArcMap.CollarFit` (`collarModel`), `ArcMap.CollarFitOut` (`exists_collarFitOut`,
    under `bend_away_gap`'s hypotheses, whose own model is owed: an open gate item), `ArcMap.LocalStep` and `ArcMap.IsModification`
    (reflexive: `LocalStep.refl`, `IsModification.refl`), `ArcMap.ProcInv`, `ArcMap.ProcStep`, `ArcMap.IsBoundaryWalk`,
    `ArcMap.IsPortGraph`, `Thomassen.PlanarLike` (`triLattice_planarLike`), `PushProfiles`, `PushOutProfiles` (`pushProfiles_collar`,
    `pushOutProfiles_collar`);
  - **data, written down**: `ArcMap.LocalSeq` (`LocalSeq.const`), `ArcMap.ProcRun` (`ProcRun.const`); the inductive `R2Subdiv` (a
    finite subdivision, built by its constructors; `R2Subdiv.below` is its generated auxiliary);
  - **facts about a point, an arc or a tile of a variable map**, decided where they occur, like `HasSectors` and `IsSectorChart`:
    `ArcMap.IsClean`, `IsSite`, `IsChainVertex`, `StuckAlong`, `IsTerminalMap` (inhabited: `sevenBrickMap_isTerminalMap`), `QROnly`,
    `IsMaxRingArc`, `MoveAt`, `Todo`, `HornBoundsQR`, `OnQR2Arc`, `GermPseudo`, `HexRing`, `RingProper`, `DoubleEvent`, `VIn`,
    `IsEndpoint`, `IsRetArc`, `IsHoleOf`, `IsOuterTile`, `IsEdgeOf`, `EnclosesTile`, `BasedTrail`;
  - **predicates of a circle colouring, a set, a point or a graph variable**: `CircleColouring.Removable`, `ChangeWith`, `IsHex`;
    `HasCurveStar`, `IsCurve`, `IsRegularAt`, `IsRegOf`; `Thomassen.IsTwoSep`, `IsMaximalTwoSep`, `IsRing`, `LocallyHamiltonian`,
    `NoInterleave`, `ReachIn`, `TwiceApart`.
  `IsRegularAt`, `IsSite`, `IsHoleOf`, `EnclosesTile` and `IsMaximalTwoSep` are refuted only under hypotheses or over variables
  (nine theorems), which is no evidence to this scan. Every other hypothesis the wave takes is a carrier decided above: its **346 new
  sites** are 194 on `Valid`, 62 on `IsRingArc`, 58 on `IsHorn`, 26 on `IsStuck` and 6 on `IsQArc`, **all `GENERIC`** at a variable map
  (`tools/fs131_l5_vacdiff.py`: no row of `main`'s scan lost, none added to a declaration `main` holds, no new evidence row). A binder
  `(h : F.IsTerminalMap)` raises no site though the definition holds `F.Valid`: the scan reads a binder's head as written. What it
  cannot see, as before: hypothesis sets that hold together on no map of the library — the stuck family, `exists_arcStep`,
  `bend_away_part`, the base's steps — each of which says so in its docstring and is listed as an open gate item at the landing.
* **The example maps' carriers (FS131-MC1, by the procedure below; `Plane/Models/{Paint, Moves, Stuck, Bends, Applied}`).** **No new
  carrier, IN or OUT**: the lane defines maps (`ArcMap.relabel`, `ArcMap.paint`, `brickBase`, `hornModel`, `twoHornModel`, `stuckModel`,
  `shadowModel`, `awayModel`), point sets, arc sets and colourings — no structure and no predicate a theorem may take as a hypothesis —
  so no name is added to `trackedProps` and no control is planted. What this scan reads of the lane (`tools/fs131_l5_vacdiff.py`
  against wave 5's gated scan: no row lost, none added to a declaration `main` held): **five witnesses**, each an unconditional
  theorem at a closed instance and each also a `WITNESSED` site of its own statement — `IsHorn` (`hornModel_isHorn`,
  `stuckModel_isHorn_pi`), `IsStuck` (`stuckModel_isStuck`), `IsRingArc` (`awayModel_isRingArc_gap`, `cuspFrag_isRingArc`) — and
  **two `GENERIC` sites** on `Condition5` (`ArcMap.relabel_condition5`, `ArcMap.paint_condition5`). A statement that is a conjunction
  (`stuckModel_isHorn`, `awayModel_hyps`) or an unconditional `X.Valid` (`hornModel_valid`; none of `main`'s 57 witnesses is one) is
  not read as a witness. The sites those maps inhabit on the landed theorems stay `GENERIC`: a site on a variable map is the caller's
  obligation by this scan's law, and no witness can be registered against it. That each model meets every hypothesis of a theorem at
  once is checked where it can be, by elaboration (`Plane/Models/Applied` applies each theorem to its model), and said in that
  theorem's docstring.

* **Wave 10's first pass (FS131-L10A, by the procedure below; `Arith/{CharacterColouring, SpectralInputs, StationaryRatio,
  StandingFive}`).** The four modules declare ten hypothesis-formers (`data/fs131/l10a/census.lean`, wave 5's census with its scope
  changed, lists them with what the library proves of each): none has an unconditional `¬ P …` or an `IsEmpty` at a closed instance.
  **IN, by ruling** (inventory item 507 (d)): `StationaryRatio.StationarySet` — a stationary random set as a system: a probability
  space, a jointly measurable measure-preserving action of the group, an event. By step (1)'s law alone it would be OUT, like `UDCert`:
  it is a record that exists at every group by construction (`StationarySet.empty G`, one point and the empty event), so no instance of
  it is empty and **step (3)'s `VACUOUS` control cannot be planted** — there is nothing to refute. What entering it buys is the
  inhabitant rule made mechanical for this one structure: a theorem taking `(W : StationarySet G)` at a CONCRETE group reads `UNKNOWN`
  until a closed inhabitant at that group is a declaration (`StationarySet.empty` takes its group as an argument, so `gather` does not
  read it as evidence); at a variable group it reads `GENERIC`, which is every site today. Its inhabitants: `StationarySet.empty`
  (every group; a.e.-independent for every connection measure, `StationarySet.empty_aeIndependent`); `StationarySet.parity`
  (`ZMod 2` on itself, the event `{0}`, `P(B) = 1/2`, a.e.-independent for `δ₁`: `parity_aeIndependent`, `parity_prob` — the one
  closed inhabitant, and the scan's one witness for the family); and, for the other hypotheses of X25B-L1
  (`ratio_prod_le_iSup_levels`), the levels `cantorLevel` of `ℕ → ZMod 2` (`exists_cantorLevel_subset`). Controls 63–65: `GENERIC`
  at a variable group, `WITNESSED` at `ZMod 2` (by `parity`), and `UNKNOWN` at `ℤ` — inhabited (by `empty ℤ`) and proved so by no
  closed declaration: the load-bearing half, the family at an instance the evidence does not reach, which must read `UNKNOWN` and
  never `WITNESSED`. **OUT**, each a predicate with no refutation theorem to collect:
  - `StationarySet.AEIndependent` — a predicate of a system and a connection measure, at a variable system at each of its four sites;
    satisfied by `empty_aeIndependent` at every `ν` and by `parity_aeIndependent`; register it when a theorem refutes it at a closed
    instance;
  - **named hypotheses, closed propositions consumed as such** (`LEAN.md` § Assumptions: each leaves when discharged; the
    `Row130M1` case again): `CharacterColouring.OrderBound` (the band's order bound — ours, FS89-S0A-3 at `k = 4`, J08-11, J08-10 —
    taken at the closed instance `OrderBound (unitSet ⊥) (band 4) 168` by `cl2`) and `StandingFive.StandingFloor` (the finite-target
    floor, G56 — taken at `7` and at `5` by `seven_le_localBound`, `five_le_chromaticNumber`; satisfiable at `0`,
    `targetFloor_zero`), with its clause `StandingFive.TargetFloor` (no site). Tracked, each closed site would read `UNKNOWN` — true
    of a hand result not yet in the kernel, and nothing the shrink-only baseline can hold; they are listed at the landing as the
    hypotheses the theorems rest on;
  - `SpectralInputs.BochnerOn` (a classical hypothesis about a topology; holds at the discrete one, `bochnerOn_bot`, at a variable
    group, which is no evidence to this scan), `SpectralInputs.IsHaarFourier` (a predicate of a measure; satisfiable given
    Herglotz–Bochner, `exists_isHaarFourier`), `SpectralInputs.IsSpectralMeasureOf` (a predicate of a vector and a measure) — at a
    variable instance at every site;
  - `SpectralChain.Interface.MulStable`, `SpectralChain.Interface.NegCircle` — predicates of an interface, each at one site
    (`sp_if`), at a variable interface. `MulStable` holds at `Interface.trivial` (an empty `E`); **`NegCircle` has no Lean model on
    file** (one is planned at `F = ℚ` on the wave's second pass), which `sp_if`'s docstring says and the landing lists as an open
    gate item: a hypothesis set that holds together on no object of the library is a conjunction across binders, which this
    per-binder scan cannot see.

* **Wave 6's first half (FS131-L6A, by the procedure below; the fourteen modules `Plane/Saturated/{Basic, Pinch, MapEdge, Sq9Map,
  MapColouring, Fan, FanExamples, Curve, CurveArc, ArcContinuation, FanArcs, FanBuild, LocalGraph, FanBridge}`).** **No new carrier
  IN.** The modules declare twenty-seven hypothesis-formers (`data/fs131/l6a/census.lean`, wave 5's census with its scope changed,
  lists them with what the library proves of each): none has an unconditional `¬ P …` at a closed instance, none an `IsEmpty`
  instance, and none a binder site at a closed instance — so for none could step (3)'s `VACUOUS` control be planted, and entering
  one would add `GENERIC` rows and no signal. **OUT**, by kind:
  - **the fan** — `AeColouring.Fan` (a `Type`-valued structure: a radius, `n` branches as polar graphs with limit directions, the
    regions' colours, and the proofs; 51 binder sites, each at a variable colouring and point). **This is the one former of the wave
    for which "does one exist" is a theorem rather than a construction** (FS131-E8-FAN, `AeColouring.fan_of_isolated`: at a point
    isolated in `Σ` of a colouring saturated in the punctured disc), so by step (1)'s first clause alone it would be IN, like
    `AeColouring`. It is kept OUT by the law as wave 5 applied it (the coordinator's ruling on FS131-L6A's question, 2026-10-06):
    no theorem of the library refutes a fan at a concrete point, so no `VACUOUS` control can be planted — the `StationarySet` case
    again, and the second instance of "a hypothesis-former whose existence is a theorem, with no `VACUOUS` control plantable".
    Its closed inhabitant: `sq9Fan : sq9.Fan sqVertex` (`Plane/Saturated/FanExamples`), on which the five `Fan` lemmas are run
    (the examples after `Fan.sector_unique`). Register it when a theorem refutes a fan at a closed instance (a colouring with a
    wild point). With it OUT: `Fan.HasSector`, `Fan.HasHorn` (facts about one region of a variable fan);
  - **the regularity hypotheses, predicates of a variable colouring**: `AeColouring.SingLocallyFinite` (`Σ` locally finite; 6
    sites), `AeColouring.RegJFan`, `AeColouring.RegJLiteral` (REG-J′ in its fan form and in its frozen words; one site each),
    `AeColouring.IsolatedAt` (the bridge's setting; 3 sites) — each satisfied at the closed instance `sq9`
    (`sq9_singLocallyFinite`, `sq9_regJFan`, `sq9_isolatedAt` at `sqVertex`), none refuted at one. Whether every honest saturated
    colouring satisfies the first is the open question C121-REGJ; the theorems take it as a hypothesis and say so;
  - **the foundation's predicates of set variables** (`Plane/Saturated/Basic`), `GENERIC` at every site, like `UnitPairsNull` and
    `IsMUA`: `TwoColourOn` (FS111-M-PINCH's hypotheses for two sets on an open set; 16 sites), `TwoColourNhd`, `H1On`, `H2On`,
    `SaturatedOn` (24 sites), `IsCuspAt`, `IsSplitAt`, `HasTwoDiscsAt`, `IsTangentAt` — inhabited together on `sq9` at `sqEdgePt`
    (`sq9_twoColourNhd`, `sq9_hasTwoDiscsAt`, `sq9_isTangentAt`, `sq9_tight_saturated`; `isSplitAt_ball_compl_closedBall` for the
    split type). `IsCuspAt` is refuted over variables only (`sq9_not_isCuspAt`, at every point and colour of `sq9`), which is no
    evidence to this scan;
  - **curves and charts, predicates of function and set variables**: `IsUnitCurve` (a unit-speed curve with 1-Lipschitz tangent
    angle; 33 sites; `isUnitCurve_segment`, `isUnitCurve_circle`), `IsInterfaceChart` (the conclusion of `local_graph`; no binder
    site; `sq9_exists_isInterfaceChart`), `HasArcChart`, `ArcSetting`, `IsArcOf` (FS131-E8-GAMMA's colour-free setting; 1, 12 and 9
    sites; inhabited by `AeColouring.arcSetting_of_isolated` at `sq9_isolatedAt`, as `Plane/Saturated/ArcContinuation`'s module
    docstring says);
  - **the class `𝒫_k`** (`Plane/Saturated/MapColouring`): `SeparatesAt` (`sq9Map_separatesAt`), `InP`, `OnLevel`, `GFin`,
    `GrundyBound` — predicates of a variable family of sets; and **`NoPar`, a named open statement consumed as a hypothesis**
    (C121-NOPAR; `gmap_ii`, `sat_noPar`), proved nowhere and listed at the landing as the hypothesis those two rest on.
  What this scan reads of the wave (`tools/fs131_l5_vacdiff.py` against wave 10's gated scan: no row lost, none added to a
  declaration `main` held, no new evidence row): **96 new sites, every one `GENERIC` on `AeColouring` at a variable number of
  colours** (`Basic` 7, `Fan` 24, `FanArcs` 5, `FanBridge` 46, `FanBuild` 4, `LocalGraph` 7, `MapColouring` 2, `Pinch` 1), and
  **seven refutations skipped** (`pinch_not_in_in`, `sat_noPar`, `TwoColourOn.false_of_mem_inter`, `false_of_inside_of_outside`,
  `Fan.horn_false`, `Fan.false_of_horn_next`, `Fan.false_of_horn_dir`), each a step inside a proof by contradiction or a row whose
  docstring names the model of the hypotheses it does not refute. `sat_noPar` binds `(c : AeColouring 6)` and `(F : ArcMap 6)`;
  being a refutation it raises no site, and its docstring says that the joint satisfiability of its hypotheses at six colours is
  the open question. What it cannot see, as before: hypothesis sets that hold together on no object of the library.
* **Wave 10's second pass, its import, and Falconer's lemma proved (FS131-L10B, by the procedure below; the twelve new modules
  `Arith/{FactorAction, Floor128, FloorPlanes, GapSeven, MajorityVote, NegCircleModel, NormOneTarget, ProductFactor, RatioBound,
  TargetFloors, WeilKloosterman}` and `Plane/MetricalBoundary`).** **No new carrier IN.** The modules declare two
  hypothesis-formers (`data/fs131/l10b/census.lean`, wave 5's census with its scope changed, lists them with what the library
  proves of each): neither has an unconditional `¬ P …` at a closed instance, an `IsEmpty` instance, or a binder site at a closed
  instance — so for neither could step (3)'s `VACUOUS` control be planted. **OUT**:
  - `StandingFive.KloostermanBound F` (`Arith/FloorPlanes`) — Weil's bound for Kloosterman sums at a finite field `F`, the
    hypothesis form the floor's modules were proved over (nine theorems take it, at a variable field or at every field of a given
    cardinality). It is a predicate of a variable field and not a structure; it holds at every field of at most five elements
    (`kloostermanBound_of_card_le_five`, no axiom) and, over the import `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207), at
    every finite field of characteristic not 2 (`kloostermanBound_of_ringChar_ne_two`); nothing in the library refutes it at any
    field. **What it stands for is an outside theorem, which is the axiom audit's to list, not this scan's** (`scripts/Axioms.lean`,
    IMPORTED: the eight records that rest on the import);
  - `GapSeven.Gapped v m` (`Arith/GapSeven`) — a decidable predicate of a vertex of `𝔽₇²` and a colour, inhabited
    (`exists_adjacent_gapped`).
  What this scan reads of the landing (`tools/fs131_l5_vacdiff.py` against wave 6's gated scan): **no site at all** — no row lost,
  none added, no new evidence row; `declarations` rises by the 202 of the twelve modules and no other count moves. None of the
  202 binds a tracked carrier: the wave's theorems are about finite fields, character sums, σ-algebras and measures, and
  `Plane/MetricalBoundary`'s about a null-measurable set of a finite-dimensional normed space; no refutation is added.
  `falconer_lemma2_nonempty`, an axiom until this landing, is a theorem (`Plane/FalconerReduction`, with its model
  `upperHalfPlane_falconer_hyp` in the same file). What the scan cannot see of the landing: that `sp_if`, `si4`,
  `spectral_carried_iff` and `contChars_haar_null` have no model of all their hypotheses that is a declaration free of a named
  classical hypothesis (their docstrings say so), and the eight theorems whose only assumption is the import.
* **Wave 8, the ring calculus (FS131-L8A, by the procedure below; the eleven modules `Plane/RingCalculus/{Basic, Star, Empty,
  HubCount, TilesAt, SoleTip, RingColour, StarChart, SemiHub, SemiHubPlaces, OuterAdj}` and wave 7's foundation
  `Plane/SimpleOn`, which lands with them).** **No new carrier IN.** The modules declare seventeen predicates and one
  enumeration (`data/fs131/l8a/census.lean`, wave 5's census with its scope changed, lists them with what the library proves of
  each): none has an unconditional `¬ P …` at a closed instance, none an `IsEmpty` instance, and none a binder site at a closed
  instance — so for none could step (3)'s `VACUOUS` control be planted, and entering one would add `GENERIC` rows and no signal.
  **OUT**, by kind:
  - **facts about a tile of a variable map** — `ArcMap.TileAt`, `IsTip`, `IsOuterTileAt` (7, 14 and 1 sites), `IsEdgeDir` (1
    site), `ZeroAngleAt` (a set and a point; no site): like `IsTile` and `TileOf`, refutable only at a concrete set, which no
    theorem fixes;
  - **the ring's classes and its germ pairs, predicates of a variable map, point and angle** — `GammaFreeRing` (10 sites),
    `QFreeRing` (2), `TipPairFree` (2), `OuterPairFree` (3), `GermOnQWith` (32), `IsSemiHub` (7), `IsFullSemiHub` (3),
    `IsClosedChangePoint` (no site). `GammaFreeRing` holds at the closed instance `halfPlane2`, `0`
    (`halfPlane2_gammaFreeRing`, two colours), and with it `QFreeRing` and both pairs. **In the class of `emptyNS` — valid,
    non-Siamese, six colours, at least four at `p`, covering the closed unit disc — a Γ-free ring is refuted**
    (FS129-SR3-EMPTY-NS), but that refutation is over variables and across five hypotheses, which is no evidence to this
    per-binder scan. **No Lean term is a semi-hub or a full semi-hub** (held by hand: the strip's `P₀` at `P₂`, the bowtie's
    centre at `top`): an open gate item of the landing, said in each docstring;
  - **the star** — `ArcMap.IsStar4` (a `Prop`-valued structure: the four tiles of `p`, pairwise distinct, their cones four
    consecutive closed intervals; 9 sites, each at a variable map and point). "Does one exist" is a theorem here
    (`exists_isStar4`: at a point of exactly four colours simple for a valid non-Siamese map), so by step (1)'s first clause
    alone it would be IN; it is kept OUT by the law as wave 5 applied it and wave 6 was ruled on (`AeColouring.Fan`): no theorem
    refutes a star at a closed instance, so no `VACUOUS` control can be planted — the third instance of that case. **No Lean
    term is a star** (`quadRing` at `0` is the candidate; owed). Register it when a theorem refutes a star at a closed instance;
  - **`ArcMap.SimpleOn`** (`Plane/SimpleOn`; 34 sites, each at a variable map and set) — *simple* read at the tiles whose
    closures meet a set; implied by the tracked `Simple` (`Simple.simpleOn`) and equal to it over `univ` (`simpleOn_univ`).
    Nothing refutes it at a closed instance, so it is OUT where `Simple` is IN; its closed model is `halfDisc` at `{0}`, inside
    an `example` of `Plane/RingCalculus/SemiHub` that runs `ncard_tileAt_eq`, `exists_sectorChart_tileAt` and
    `exists_initialPiece_of_ncard_le_three` on it. Register it with a theorem `¬ F.SimpleOn S` at a concrete map;
  - **finite data** — `V6Count.CountStmt`, `V6Count.TwoDoubles` (`HubCount`: decidable statements about four tiles and six
    hubs, checked by the kernel's own evaluation; no site), `ArcMap.SemiKind` (an enumeration of two, `O` and `T`).
  What this scan reads of the wave (`tools/fs131_l5_vacdiff.py` against the assumptions step's gated scan: no row lost, none
  added to a declaration `main` held, no new evidence row): **177 new sites, every one `GENERIC` on a carrier tracked since the
  first waves, at a variable map** — `Valid` 82, `NonSiamese` 52, `IsChangePoint` 23, `IsRingArc` 14, `IsHub` 5, `Simple` 1
  (`SemiHub` 64, `SemiHubPlaces` 39, `Star` 27, `Basic` 11, `Empty` 9, `StarChart` 8, `RingColour` 7, `OuterAdj` 6, `SoleTip` 3,
  `TilesAt` 2, `SimpleOn` 1) — and **sixteen refutations skipped**: four rows that conclude `False` (`emptyNS`, `doubleTip`,
  `v6_hug`, `not_sole_tip_of_adjacent_changePoints`), the two kernel facts of joint vacuity (`v6_hubs_vacuous`,
  `v6_hug_vacuous`), six steps inside a proof by contradiction or negative clauses of a row (`GammaFreeRing.changePoint_gap`,
  `not_double_two_classes`, `fin_four_three_pairs`, `qcol_not_one_arc`, `star_anti_ne`, `false_of_antipodal_gaps`), and four
  whose conclusion is a predicate that unfolds to a refutation — `halfPlane2_gammaFreeRing`, `GammaFreeRing.qFreeRing`,
  `halfDisc_valid`, `halfDisc_nonSiamese` (the reducing telescope's known reading of `GammaFreeRing`, `QFreeRing`, `Valid`,
  `NonSiamese`).
  **The marker and joint vacuity.** `v6_hubs` and `v6_hug` are route lemmas over the empty class of `emptyNS`, and both came
  with this scan's marker in their docstrings. `v6_hug` concludes `False`, so it was skipped and its marker never read;
  `v6_hubs` concludes an `∃`, and the scan read its two tracked binders `STALE` — rightly: the marker claims that ONE binder's
  carrier is provably empty, and `F.Valid`, `F.NonSiamese` at a variable map are not. The emptiness is joint, across five
  hypotheses, and is proved (`v6_hubs_vacuous`, `v6_hug_vacuous`: `False` from the exact hypotheses). The marker was taken
  out of both docstrings, which now say the joint vacuity in words and name the theorem that refutes the hypotheses (the
  coordinator's ruling on FS131-L8A's question, 2026-10-06, reversing ruling 518's placement); the two sites read `GENERIC`,
  which is true binder by binder, and `declared` stays 3. **The rule: the marker is for a declaration with one provably empty
  carrier; a route lemma whose hypotheses are jointly unsatisfiable says so in words and names the theorem that refutes
  them.** Honouring a marker on the evidence of such a theorem would be a change to this scan (joint emptiness as evidence),
  filed for the tooling job. What the scan cannot see, as before: hypothesis sets that hold together on no object of the
  library — here the star rows, the semi-hub rows, two change points `60°` apart (`outerAdj`,
  `not_sole_outer_of_adjacent_changePoints`), and `emptyNS`'s class at nine colours, each with no Lean model and each saying
  so in its docstring.
* **FS-132's import of `[OAIMath2026]` family 158 (FS132-L1, by the procedure below; the one module `Outside/OAI158`).**
  **No new carrier IN.** The module declares two hypothesis-formers, the release's own, copied:
  `Outside.OAI158.ProperColoring k c` (a map `c : ℂ → Fin k` giving different colours to every unit pair; a binder of the
  imported `proper_to_borel_weak`) and `Outside.OAI158.WeakColoring k d` (a.e.-measurable and proper at almost every unit
  pair; a binder of `nonempty_aeColouring_of_weak`). **OUT**, both: each is a predicate of a colour count and a FUNCTION,
  and at every site the function is a bound variable — so every site would read `GENERIC`, at a closed count as at a
  variable one, and step (3)'s `VACUOUS` control cannot be planted: a carrier `ProperColoring 4 c` with `c` bound matches
  no closed evidence (the `IsTile` case: refutable only at a concrete function, which no theorem fixes). The emptiness
  that matters is over the count, with the function bound — `∀ c, ¬ ProperColoring 4 c` is this library's own (rung B; an
  `example` of the module), `∀ c, ¬ ProperColoring 5 c` is the import `no_proper_five_coloring` itself, and
  `∀ d, ¬ (Measurable d ∧ WeakColoring 1 d)` is an `example` of the module — which a per-binder scan cannot read. What
  stands in for it is said in the module: the transfer `proper_to_borel_weak` holds at every `k` and is empty of content
  where no proper `k`-colouring exists; its hypothesis is inhabited at `k = 7` (`exists_properColoring_seven`), where its
  conclusion is a theorem with no axiom (`proper_to_borel_weak_model`). `Angles` (a type: the circle of angles),
  `angularMeasure` and `direction` are data, written down.
  What this scan reads of the landing (`tools/fs131_l5_vacdiff.py` against wave 8's gated scan: no row lost, none added
  to a declaration `main` held, no new evidence row): **one new site, `GENERIC`** — `weakColoring_of_aeColouring`, on the
  tracked `AeColouring` at a variable number of colours — and no refutation skipped: `no_proper_five_coloring` and
  `not_colorable_five` are stated negations with no binder, audited and raising no site. No declaration of the module is
  evidence to `gather` (none concludes `IsEmpty`, `Nonempty`, `Colorable`, a `Coloring` or a tracked carrier
  unconditionally), so **no verdict of this scan rests on an import**.
  **What the import changes in what an OLDER statement says, which this scan cannot see.** Given the declared outside
  theorem `Outside.OAI158.no_proper_five_coloring` the plane has no proper five-colouring
  (`Outside.OAI158.not_colorable_five`), so the carrier `(unitDistance ℂ).Coloring (Fin 5)` is empty and `hexShell_plane5`
  — one of the baseline's two entries — is, given that import, the `core9_plane` shape: a statement over an empty domain.
  The scan still reads it `UNKNOWN`: `gather` takes as emptiness evidence an unconditional `IsEmpty τ` or a `¬ P` of a
  tracked `P`, and `¬ (unitDistance ℂ).Colorable 5` is neither; no `IsEmpty` form of it is stated, by ruling (the
  coordinator's, on FS132-L1's question, 2026-10-07). `hexShell_plane5`'s docstring and the baseline's prose say the
  vacuity in words and name the two theorems; `hexShell_plane6` is the open case and is untouched. **The question this
  leaves, filed for the tooling job** (inventory ruling 475 (d)): `gather` does not look at a declaration's axioms, so an
  `IsEmpty` theorem resting on a declared import would be read as evidence like any other and the marker honoured on it —
  "empty, by the kernel on the standard three" and "empty, given a declared outside theorem" would be one count. Whether
  to allow that, and how to print the two apart, is a change in what this gate means.

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
   `HadwigerNelson.Plane.ArcMap.NonSiamese, `HadwigerNelson.Plane.ArcMap.Simple,
   -- wave 3's ring vocabulary (FS131-I3h)
   `HadwigerNelson.Plane.ArcMap.IsRingArc, `HadwigerNelson.Plane.ArcMap.IsQArc,
   `HadwigerNelson.Plane.ArcMap.IsChangePoint, `HadwigerNelson.Plane.ArcMap.IsHub,
   -- wave 2's measurable vocabulary (FS131-I2n)
   `HadwigerNelson.Plane.CPColouring, `HadwigerNelson.Plane.SemiconcaveWith,
   -- wave 4's valid-map vocabulary (FS131-G4)
   `HadwigerNelson.Plane.ArcMap.IsHorn, `HadwigerNelson.Plane.ArcMap.IsStuck,
   `HadwigerNelson.Plane.ArcMap.Condition5, `HadwigerNelson.Plane.AeProperRegions,
   -- Woodall's pictures and normal forms (FS131-WL1)
   `HadwigerNelson.Plane.ArcMap.SectorsAt, `HadwigerNelson.Plane.ArcMap.NiceAt,
   `HadwigerNelson.Plane.ArcMap.WoodallMerged, `HadwigerNelson.Plane.ArcMap.WoodallNormal,
   -- wave 10's stationary systems (FS131-L10A, ruling 507 (d))
   `HadwigerNelson.StationaryRatio.StationarySet]

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

/-- **Is the stated conclusion a negation?** `¬ P` and `a ≠ b`, read as written (no unfolding): `Not` and
`Ne` are the two heads whose definitions are `… → False`, which is how a reducing telescope turns them
into a conclusion `False` (FS131-T2). -/
def isNegationConcl (concl : Expr) : Bool :=
  concl.isAppOf ``Not || concl.isAppOf ``Ne

/-- **The refutation test, matched to the law:** a declaration is a refutation only when its *stated*
conclusion, after its binders, is `False` itself. Two readings differ: the reducing telescope (which sees
through definitions, to find binders hidden behind them) ends in `False`, and the statement as written
does not end in a negation.

* `P → False`, written so, is a refutation: the arrow is a stated hypothesis, meant to be empty.
* `¬ P` and `a ≠ b`, written so, are **not**: they are claims that `P` (that `a = b`) fails, and their
  other binders are ordinary `∀`-binders over a carrier that may be empty. The arrow the reducing
  telescope finds in `Not`/`Ne` is dropped from the carriers (it is the claim's own `P`, whose emptiness
  the theorem proves, and `gather` reads a `¬ P` of tracked `P` as evidence of exactly that), but every
  *stated* binder is audited.
* a name that unfolds to `False` through some other definition keeps the old reading: skipped. -/
def isRefutation (type : Expr) : MetaM Bool :=
  forallTelescopeReducing type fun _ concl =>
    if !concl.isConstOf ``False then pure false
    else forallTelescope type fun _ stated => pure !isNegationConcl stated

/-- Every carrier a declaration's statement commits to: each binder's type, plus the conclusion.

**A refutation is skipped, structurally** — see `isRefutation`: a declaration whose stated conclusion
is `False` says *these cannot all hold*, so its binders are meant to be jointly unsatisfiable, and flagging
one for emptiness is flagging the theorem for its own content. `isEmpty_coloring_plane_four` is the
example — a proof that the plane has no four-colouring, whose only binder is a four-colouring of the
plane. A conclusion `¬ P` or `a ≠ b` is not `False`: its binders are audited like any other's.

It does **not** blind the check to the case that motivated it: `core9_plane` concludes an `∃`,
not `False`, and is still flagged. Verified, not assumed. -/
def carriersOf (type : Expr) : MetaM (Array (Expr × String)) :=
  forallTelescopeReducing type fun xs concl => do
    if ← isRefutation type then return #[]
    -- a stated negation unfolds to one more binder (the `P` of `P → False`): not a hypothesis anyone wrote
    let xs ← if concl.isConstOf ``False && xs.size > 0 then
        (do let stated ← forallTelescope type fun _ c => pure c
            pure (if isNegationConcl stated then xs.pop else xs))
      else pure xs
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
    if ← (try isRefutation ci.type catch _ => pure false) then
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
