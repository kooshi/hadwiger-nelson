import Proofs

/-!
# Axiom audit — the trust receipt

The de Bruijn criterion made a standing check: everything shipped reduces to what the kernel
verified plus what we explicitly chose to trust. One `#print axioms` line per public theorem on the
milestone's surface.

Run it through the gate script, which reads the banners below and fails on a purchase in the wrong
section:

```
./scripts/axioms.sh
```

or by hand with `lake env lean scripts/Axioms.lean`.

## The three sections, and why the banners are printed rather than commented

A native purchase shows up as **one long name in the middle of a wall of text** — at v4.32.0
`native_decide` mints a per-declaration axiom, `foo._native.native_decide.ax_1_1`, and
`Lean.ofReduceBool` never appears at all. Eyeballing that difference across twenty lines is exactly
the check that silently stops being run. So the file prints machine-readable banners, the audit
splits on them, and the rule is mechanical — **every axiom a record carries must be one its section
allows** (`scripts/axioms.sh` checks each record's list as a set, FS131-T3):

* **CLEAN** — nothing but `propext`, `Classical.choice`, `Quot.sound`: a subset of the standard three,
  the empty set included. Any other axiom here fails the gate, and the failure says which kind it is:
  a native purchase, a declared import (the record belongs under IMPORTED), `sorryAx`, or an axiom
  nobody declared.
* **PURCHASED** — these carry a native-evaluation axiom *by design*. Each corresponds to a
  declaration whose docstring opens with "**Trust purchase: native evaluation.**"
  (`grep -rn "Trust purchase" Proofs/` is the source-side ledger), and to an entry in
  `ARCHITECTURE.md` § 5. A record here with no native axiom is a stale entry and fails; besides the
  standard three and its native axioms it may carry only declared imports. `sorryAx` still fails here.
* **IMPORTED** — these rest on a **declared outside theorem**: an `axiom` named by an
  `AxiomAudit.declareImport` line in that section, the one list of them, each with the four items of
  `LEAN.md` § Assumptions. A record here may carry the standard three and declared imports, nothing
  else, and must carry at least one declared import. How a wave declares one is written beside the
  banner, which comes first, just above CLEAN.

Two more kinds of line are printed, and neither is a record: `DECLARED IMPORT <name>` from each
`declareImport`, and, from `AxiomAudit.libraryAxioms` — the file's last command — every `axiom` the
library declares (`LIBRARY SUMMARY …`, `LIBRARY AXIOM <name>`), so an axiom whose consumers this file
never audits still reaches the gate, which fails on any library axiom that is not declared.

**Every axiom is printed by its full name** (`set_option pp.fullNames true`, below). `#print axioms`
renders an axiom with `MessageData.ofConstName`, which shortens it against the open namespaces, and
this file opens `HadwigerNelson`: without the option, `HadwigerNelson.Plane.falconer_lemma2_nonempty`
prints as `Plane.falconer_lemma2_nonempty`, and the declared list and the records would spell one
axiom two ways.

`moserSpindle_valid` and `deGrey_valid` are the ones to watch in the clean section: both rest on
kernel *reduction* rather than on a written proof, and both stay inside the standard axiom set.
`deGrey_valid` is 7877 exact identities decided in 158 chunks — the geometry half of `χ(ℝ²) ≥ 5`,
bought with no native evaluation at all.
-/

open HadwigerNelson

set_option pp.fullNames true

/-! ## The audit's own instruments (FS131-T3)

`declareImport` is the one list of imported outside theorems; `libraryAxioms` lists every `axiom` the
library declares. Both print fixed-prefix lines that `scripts/axioms.sh` parses, and both refuse loudly
rather than print less: a refusal is an elaboration error, and the gate fails on an audit that does not
elaborate. -/

namespace AxiomAudit

open Lean Elab Command

/-- `n` is declared in the library — a module under `Proofs` — or in this file. The second clause
serves the planted controls of `scripts/axioms.sh --self-test`; the audit itself declares no axiom. -/
def inScope (env : Environment) (n : Name) : Bool :=
  match env.getModuleIdxFor? n with
  | none => true
  | some i => match env.allImportedModuleNames[i.toNat]? with
    | some m => (`Proofs).isPrefixOf m
    | none => false

/-- A native-evaluation auxiliary: `native_decide` mints `foo._native.native_decide.ax_N_M` per use.
These are accounted for by the PURCHASED section and the "**Trust purchase:**" docstrings, not by the
import list. -/
def isNativeAux (n : Name) : Bool :=
  n.components.contains `_native

/-- A bibliography key in this project's form — capitalized letters, a four-digit year, at most one
lower-case letter: `Falconer1981`, `ShelahSoifer2003b` — the key `LEAN.md` § Assumptions item 1 asks an
imported theorem's docstring to name. -/
def isBibKey (k : String) : Bool :=
  let cs := k.toList
  let letters := cs.takeWhile Char.isAlpha
  let rest := cs.drop letters.length
  let digits := rest.takeWhile Char.isDigit
  let tail := rest.drop digits.length
  (cs.head?.map Char.isUpper).getD false && digits.length == 4 &&
    (tail.isEmpty || (tail.length == 1 && tail.all Char.isLower))

/-- Some bracketed span of `doc` is a bibliography key (`isBibKey`). -/
def hasBibKey (doc : String) : Bool :=
  ((doc.splitOn "[").drop 1).any fun piece =>
    match piece.splitOn "]" with
    | k :: _ :: _ => isBibKey k
    | _ => false

example : isBibKey "Falconer1981" ∧ isBibKey "ShelahSoifer2003b" ∧ ¬ isBibKey "Falconer" ∧
    ¬ isBibKey "falconer1981" ∧ ¬ isBibKey "Falconer1981bc" := by decide

-- `String.splitOn` does not reduce in the kernel, so these two are evaluated, not decided.
#guard hasBibKey "`[Falconer1981]` Lemma 2 (i), p. 185"
#guard !hasBibKey "Lemma 2 [i], p. 185"

/-- **Declare an imported outside theorem to the gate.** This is the one list of them; the procedure is
beside the IMPORTED banner, at the end of this file. Refuses — so the audit does not elaborate and the
gate fails — unless `n` is an `axiom` declared in the library whose docstring names a bibliography key
(`LEAN.md` § Assumptions item 1). Prints `DECLARED IMPORT <full name>`. Called as
`#eval AxiomAudit.declareImport ``Full.Name`: the double backtick elaborates only if the constant
exists, so a mistyped declaration cannot read as an empty one. -/
def declareImport (n : Name) : CommandElabM Unit := do
  let env ← getEnv
  let some ci := env.find? n | throwError "declareImport: unknown constant {n}"
  unless ci.isAxiom do
    throwError "declareImport: {n} is not an `axiom`; only an axiom is an imported outside theorem"
  unless inScope env n do
    throwError "declareImport: {n} is not declared in the library (a module under `Proofs`); \
      an axiom of a dependency is not ours to declare"
  let some doc ← findDocString? env n
    | throwError "declareImport: {n} has no docstring; LEAN.md § Assumptions item 1 asks it to name \
        its bibliography key, section and page"
  unless hasBibKey doc do
    throwError "declareImport: {n}'s docstring names no bibliography key of the form [Author2024]; \
      LEAN.md § Assumptions item 1"
  logInfo m!"DECLARED IMPORT {n}"

/-- **Every `axiom` the library declares**, except the native-evaluation auxiliaries: a count line
`LIBRARY SUMMARY axioms=N native=M` (`M` counts the auxiliaries left out), then `LIBRARY AXIOM <full
name>` per axiom, sorted. `scripts/axioms.sh` fails on a listed axiom that no `declareImport` names, and
on a count that disagrees with the lines. It must stay the file's last command: an axiom declared after
it is not seen. -/
def libraryAxioms : CommandElabM Unit := do
  let env ← getEnv
  let (own, native) := env.constants.fold (init := ((#[] : Array Name), (0 : Nat))) fun acc n ci =>
    if ci.isAxiom && inScope env n then
      if isNativeAux n then (acc.1, acc.2 + 1) else (acc.1.push n, acc.2)
    else acc
  let own := own.qsort (fun a b => a.toString < b.toString)
  logInfo m!"LIBRARY SUMMARY axioms={own.size} native={native}"
  for n in own do
    logInfo m!"LIBRARY AXIOM {n}"

end AxiomAudit

#eval IO.println "=== IMPORTED ==="

/-! ## IMPORTED — records resting on a declared outside theorem (FS131-T3, 2026-10-04)

A record here may carry the standard three and **declared imports**, nothing else, and must carry at
least one declared import: a record with none belongs under CLEAN (`stale-import`). A declared import
is an `axiom` named by an `AxiomAudit.declareImport` line in this section — the one list of them. Of the
four items `LEAN.md` § Assumptions requires of it, the gate checks two: its docstring names a
bibliography key (item 1; `declareImport` refuses otherwise) and `ARCHITECTURE.md` § Trust names it in
backticks (item 4; `arch-missing`). Any other axiom fails wherever it appears — under CLEAN, here,
under PURCHASED — and so does any axiom the library declares without a `declareImport` line, audited or
not (`undeclared-library-axiom`, from `libraryAxioms`, the file's last command). The library
declares three imports at present: wave 10's `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, FS131-K10c), with
the records below; FS-132's `Outside.OAI158.no_proper_five_coloring` (`[OAIMath2026]` family 158, FS132-I1), with six
(one of them FS-124's radius clause, `Plane/RadiusOutside`); and, on the five-colour chain's line, FS-131's
`Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3, FS131-KN3; declared to the audit at the
chain's join, FS131-IJN1). Its first, wave 2's `falconer_lemma2_nonempty`, is a theorem since FS131-IF1 (FS131-L10B's
join), and FS-132's second, `Outside.OAI158.proper_to_borel_weak`, since the port of its proof (FS-131, FS131-IPD1): its
twelve records are under CLEAN.

**Why this section comes first.** The gate reads the sections in any order, but two things do not move:
PURCHASED stays last, because `tools/check_architecture.py` reads every `#print axioms` after its banner
as a purchase; and the waves append their CLEAN records just above the PURCHASED banner, so a section
placed there would meet every landing's merge in the same lines.

**How a wave declares an import, at its landing** (written for wave 2's `falconer_lemma2_nonempty`, since
proved; the same for any later one): (1) check the four items of `LEAN.md` § Assumptions are done — the docstring
names its bibliography key, section and page; the statement is read back against the paper in the
planner's record; a model of its hypotheses sits in the same file; and `ARCHITECTURE.md` § Trust has its
row, naming the axiom in backticks — `` `Plane.falconer_lemma2_nonempty` `` or the full name (the gate
accepts the name with or without its leading `HadwigerNelson.`); (2) add one line below this comment,
the FULL name after a double backtick:

```
#eval AxiomAudit.declareImport ``HadwigerNelson.Plane.falconer_lemma2_nonempty
```

(3) move every record whose axioms include it from CLEAN to below that line, above the CLEAN banner: run
`./scripts/axioms.sh`, and each record still under CLEAN that carries the import fails as
`import-in-clean`, naming itself. For wave 2 at `fs131-w2` `59976a11` these are `falconer_reduction`,
`le_chiM_of_falconerFan`, `exists_mem_falconerE` and `fan_tip_ae_mem` (`data/fs131/t3/wave_dryrun.sh`,
run in the wave's worktree before merging, lists them for any later state); (4) run
`./scripts/axioms.sh --self-test`, then `./scripts/axioms.sh`, and read the digest: it lists the declared
imports and the IMPORTED records; the clean count falls by exactly the records moved, the imported count
rises by the same, and nothing else moves; draft `CLAUDE.md` § Trust ledger's sentence with the new
counts for Keryx. A mistyped name does not elaborate (the double backtick resolves it); an import
declared that no audited record carries fails as `stale-declaration`. -/

#eval AxiomAudit.declareImport ``HadwigerNelson.StandingFive.kloosterman_bound

-- FS131-K10c: wave 10's records resting on `kloosterman_bound` (`[Weil1948]` p. 207; TC1-STANDING-FIVE's floor)
#print axioms HadwigerNelson.StandingFive.kloostermanBound_of_ringChar_ne_two
#print axioms HadwigerNelson.StandingFive.targetFloor_seven_weil
#print axioms HadwigerNelson.StandingFive.targetFloor_six_weil
#print axioms HadwigerNelson.StandingFive.circle_sum_le_weil
#print axioms HadwigerNelson.StandingFive.standingFloor_seven_weil
#print axioms HadwigerNelson.StandingFive.standingFloor_five_weil
#print axioms HadwigerNelson.StandingFive.seven_le_localBound_weil
#print axioms HadwigerNelson.StandingFive.five_le_chromaticNumber_weil
-- FS131-LJ1: the three-colour criterion's records resting on `kloosterman_bound` (claims NF4, clause (b) toward the prime and row 99's lower half;
-- the bound is read at one place, `targetFloor_four_weil`) — `Arith/ThreeColourCriterion` 5 (the leaves' proofs FS131-IN1's)
#print axioms HadwigerNelson.ThreeColourCriterion.exists_maximal_card_nine
#print axioms HadwigerNelson.ThreeColourCriterion.exists_maximal_card_nine_of_colorable_three
#print axioms HadwigerNelson.ThreeColourCriterion.exists_maximal_of_torsion
#print axioms HadwigerNelson.ThreeColourCriterion.exists_normOne_zero_of_card_ne_nine
#print axioms HadwigerNelson.ThreeColourCriterion.targetFloor_four_weil
-- FS131-LJ1: … and `Arith/ThreeFourColours` 7 (clause (b) in both forms, row 99 in four, one model; FS131-KJ1's)
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_eq_localBound_of_le_four
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_eq_three_iff
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_le_three_iff
#print axioms HadwigerNelson.ThreeFourColours.colorable_three_planeOver_iff
#print axioms HadwigerNelson.ThreeFourColours.exists_maximal_card_nine_sqrt_three
#print axioms HadwigerNelson.ThreeFourColours.localBound_le_chromaticNumber_of_le_four
#print axioms HadwigerNelson.ThreeFourColours.localBound_le_chromaticNumber_or_four_le
-- FS131-LGT1 (IMPORTED, on `StandingFive.kloosterman_bound`): the chain's modules (`Rigidity/*` but the link's two, `Outside/OAI015*`, `Plane/WindowDensity`, `Plane/MOneBound`, `Instances/SqrtFortySevenFive`, `Instances/SqrtClassValues`; FS131-KN3 … FS131-IJN1, joined by FS131-LCH1) — 15
#print axioms HadwigerNelson.SqrtClassValues.five_le_localBound_sqrt143
#print axioms HadwigerNelson.SqrtClassValues.five_le_localBound_sqrt3_sqrt5
#print axioms HadwigerNelson.SqrtFortySeven.five_le_localBound_sqrt47
#print axioms HadwigerNelson.Rigidity.exists_uniform_tail
#print axioms HadwigerNelson.Rigidity.ratioAtMost_of_five_le_chromaticNumber
#print axioms HadwigerNelson.Rigidity.ratioAtMost_of_two_notMem
#print axioms HadwigerNelson.Rigidity.tca_of_five_le_localBound
#print axioms HadwigerNelson.Rigidity.tca_uniform
#print axioms HadwigerNelson.Rigidity.Counting.count_of_oneAvoidingDensityBound
#print axioms HadwigerNelson.Rigidity.Counting.false_of_slice
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_of_isSquare
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_of_two_notMem
#print axioms HadwigerNelson.Rigidity.five_le_localBound_of_isSquare
#print axioms HadwigerNelson.Rigidity.five_le_localBound_of_isSquare_class
#print axioms HadwigerNelson.Rigidity.tca_iff_five_le_localBound
-- FS131-LGT1 (IMPORTED, on `StandingFive.kloosterman_bound`): the certificate link (`Arith/FibreShareIneq`, `Rigidity/CertLink`, `Rigidity/CertLinkModels`; FS131-IKL1, its drafts applied by FS131-LCH1) — 3
#print axioms HadwigerNelson.CertLink.card_le_of_fibreShareBound_model
#print axioms HadwigerNelson.CertLink.exists_addEquiv_zmod_sqrt_three
#print axioms HadwigerNelson.CertLink.exists_stablePrime_sqrt_three
-- FS131-ICO2 (IMPORTED, on `StandingFive.kloosterman_bound`): the collapse's thickness by Weil's bound (`Collapse/Thick`, `Collapse/Headline`) and the approved edit D-E2 (`Rigidity/ClassRatio`) — 6
#print axioms HadwigerNelson.Collapse.thick_deGrey
#print axioms HadwigerNelson.Collapse.thick_sqrt635087
#print axioms HadwigerNelson.Collapse.thickAt_weil
#print axioms HadwigerNelson.Collapse.thick_of_card
#print axioms HadwigerNelson.Collapse.thick_of_forall_thickAt
#print axioms HadwigerNelson.Rigidity.norm_charSum_le_weil
-- FS131-IQP3 (IMPORTED, on `StandingFive.kloosterman_bound`): the p-adic plane's Weil form (`PadicPlane/Tower`, `PadicPlane/Values`; planned by FS131-KPA1, proved by FS131-IQP1 and FS131-IQP3) — 6
#print axioms HadwigerNelson.PadicPlane.charSum_unitCircle_ge_weil
#print axioms HadwigerNelson.PadicPlane.towerRatio_weil
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_three
#print axioms HadwigerNelson.PadicPlane.le_borelChromaticNumber_padicPlane
#print axioms HadwigerNelson.PadicPlane.not_exists_bound_borelChromaticNumber_padicPlane
#print axioms HadwigerNelson.PadicPlane.one_add_div_le_of_borelColoring
-- FS131-ICS1 (IMPORTED, on `StandingFive.kloosterman_bound`): CLS in full and ℚ(√23, ∛2)'s local bound (`Rigidity/FourColourPlaces`, `Instances/SqrtTwentyThreeCbrtTwo`; planned by FS131-KCS1) — 9
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.five_le_localBound_sqrt23_cbrt2
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.localBound_sqrt23_cbrt2_eq_five
#print axioms HadwigerNelson.Rigidity.colorable_four_levelTarget_one_iff
#print axioms HadwigerNelson.Rigidity.exists_ratioAtMost_lt_quarter_iff
#print axioms HadwigerNelson.Rigidity.exists_ratioAtMost_of_not_isFourColourPlace
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_levelTarget_one_iff
#print axioms HadwigerNelson.Rigidity.five_le_localBoundAllLevels_iff
#print axioms HadwigerNelson.Rigidity.five_le_localBound_iff
#print axioms HadwigerNelson.Rigidity.tca_iff_forall_not_isFourColourPlace

-- FS131-IFR1 (IMPORTED, on `StandingFive.kloosterman_bound`): the model at `k = 7` (`Collapse/Headline`, the coordinator's ruling 3, inventory item 1021) — 1
#print axioms HadwigerNelson.Collapse.exists_model_seven

#eval AxiomAudit.declareImport ``HadwigerNelson.Outside.OAI158.no_proper_five_coloring

-- FS132-I1: the records resting on `no_proper_five_coloring` (`[OAIMath2026]` family 158, `Five.lean:124`)
#print axioms HadwigerNelson.Outside.OAI158.not_colorable_five
#print axioms HadwigerNelson.Outside.OAI158.six_le_chromaticNumber_plane
#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_six_or_seven
#print axioms HadwigerNelson.Outside.OAI158.six_le_chiM0
#print axioms HadwigerNelson.Outside.OAI158.chiM0_six_or_seven
-- FS124-I1: the radius clause's record resting on `no_proper_five_coloring` (C124-RADIUS-FIVE, `Plane/RadiusOutside`)
#print axioms HadwigerNelson.Plane.radius_five
-- FS131-ICO2 (IMPORTED, on `no_proper_five_coloring`, with `positive_entropy_rigidity` and `kloosterman_bound`): the collapse's six-or-seven corollary (`Collapse/Headline`) — 1
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087_six_or_seven

-- FS131-IFR1 (IMPORTED, on `no_proper_five_coloring`, with `positive_entropy_rigidity` and `kloosterman_bound`): item 1005's splits (`Collapse/Headline`) and the finite triangle-free six-chromatic graph (`Collapse/Density/Headline`) — 3
#print axioms HadwigerNelson.Collapse.exists_finite_triangleFree_six_chromatic
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087_le_seven
#print axioms HadwigerNelson.Collapse.six_le_chromaticNumber_planeOver_sqrt635087

#eval AxiomAudit.declareImport ``HadwigerNelson.Rigidity.positive_entropy_rigidity

-- FS131-IJN1: the records resting on `Rigidity.positive_entropy_rigidity` (`[EinsiedlerLindenstrauss2022]` Thm 1.3;
-- the four items: plans/FS131-KN3-chain-plan.md § 5.3, plans/FS131-KN6-chain-first-layer.md § Stage 6, plans/FS131-KN7-chain-next.md
-- § 3.3) — every public declaration of the five-colour chain's branch `fs131-wj` that rests on it and on no `sorryAx`
#print axioms HadwigerNelson.Rigidity.positive_entropy_rigidity_of_polishSpace
#print axioms HadwigerNelson.Rigidity.haar_or_zero_entropy
#print axioms HadwigerNelson.Rigidity.isHaarFourier_or_ksEntropy_eq_zero
#print axioms HadwigerNelson.Rigidity.ksEntropy_eq_zero_of_not_smul_le
#print axioms HadwigerNelson.Rigidity.entropySplit_of_admissiblePair
#print axioms HadwigerNelson.Rigidity.entropySplit
#print axioms HadwigerNelson.Rigidity.mrPlus
#print axioms HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber_closed
-- FS131-LGT1 (IMPORTED, on `Rigidity.positive_entropy_rigidity`): the chain's modules (`Rigidity/*` but the link's two, `Outside/OAI015*`, `Plane/WindowDensity`, `Plane/MOneBound`, `Instances/SqrtFortySevenFive`, `Instances/SqrtClassValues`; FS131-KN3 … FS131-IJN1, joined by FS131-LCH1) — 8
#print axioms HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt143_eq_five
#print axioms HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt311_eq_five
#print axioms HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt335_eq_five
#print axioms HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt3_sqrt5_eq_five
#print axioms HadwigerNelson.SqrtClassValues.five_le_chromaticNumber_planeOver_sqrt167
#print axioms HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five
#print axioms HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound
-- FS131-IL5 (IMPORTED, on `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`, through the headline): the main clause through five as one theorem (`Rigidity/MainClauseFive`) — 2
#print axioms HadwigerNelson.Rigidity.chromaticNumber_planeOver_eq_localBound_of_le_five
#print axioms HadwigerNelson.Rigidity.min_chromaticNumber_five_eq_min_localBound_five
-- FS131-ICO2 (IMPORTED, on `Rigidity.positive_entropy_rigidity`, three of them on `StandingFive.kloosterman_bound` too): the collapse (`Collapse/Dichotomy`, `Collapse/Slice`, `Collapse/Headline`) — 8
#print axioms HadwigerNelson.Collapse.exists_invColouring_TA
#print axioms HadwigerNelson.Collapse.not_isSPWitness
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_deGrey
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_eq_plane_of_forall_thickAt
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_eq_plane_of_thick
#print axioms HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087
#print axioms HadwigerNelson.Collapse.chromaticNumber_plane_le_of_thick
#print axioms HadwigerNelson.Collapse.exists_slice_of_colorable
-- FS131-ICS1 (IMPORTED, on `Rigidity.positive_entropy_rigidity` and `StandingFive.kloosterman_bound`, through the headline): five colours by field and by class — the quadratic dichotomy and the family (`Instances/SqrtFiveClass`), ℚ(√23, ∛2) and ℚ(√23) (`Instances/SqrtTwentyThreeCbrtTwo`), the two readings of `L` (`Rigidity/FourColourPlaces`); planned by FS131-KCS1 — 7
#print axioms HadwigerNelson.SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five
#print axioms HadwigerNelson.SqrtFiveClass.five_le_chromaticNumber_planeOver_sqrt_iff
#print axioms HadwigerNelson.SqrtFiveClass.five_le_localBound_sqrt_iff
#print axioms HadwigerNelson.SqrtFiveClass.localBound_sqrt_eq_five
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.chromaticNumber_planeOver_sqrt23_cbrt2_eq_five
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.localBound_sqrt23_eq_four
#print axioms HadwigerNelson.Rigidity.min_localBoundAllLevels_five

-- FS131-IFR1 (IMPORTED, on `Rigidity.positive_entropy_rigidity`, six of them on `StandingFive.kloosterman_bound` too): the density form of the collapse (`Collapse/Density/Upper`, `Collapse/Density/Headline`) — 17
#print axioms HadwigerNelson.Collapse.IndepLaw.density_le_notThick
#print axioms HadwigerNelson.Collapse.exists_triangleFree_ratio_lt
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_deGrey
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_iSup_density
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_localRatio
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_mOne_of_thick
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_plane_of_thick
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_sqrt635087
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_deGrey
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_eq
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_eq_plane_of_thick
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_sqrt635087
#print axioms HadwigerNelson.Collapse.inv_le_localRatio_of_colorable
#print axioms HadwigerNelson.Collapse.IndepLaw.density_le_localRatio
#print axioms HadwigerNelson.Collapse.IndepLaw.density_le_max_of_unramified
#print axioms HadwigerNelson.Collapse.exists_indepLaw_TA
#print axioms HadwigerNelson.Collapse.integral_condOne_mul_eq_zero

#eval IO.println "=== CLEAN ==="

/-! ## M01 — the reduction and its API -/

#print axioms lt_chromaticNumber_iff_not_colorable
#print axioms add_one_le_chromaticNumber_iff_not_colorable
#print axioms lt_chromaticNumber_unitDistance
#print axioms add_one_le_chromaticNumber_unitDistance
#print axioms chromaticNumber_unitDistance_congr

-- M44, the limit lemma: approximate drawings in a compact region force the exact bound.
#print axioms exists_unitDistance_drawing_of_approx
#print axioms add_one_le_chromaticNumber_unitDistance_of_approx
#print axioms add_one_le_chromaticNumber_unitDistance_of_bounded_family
#print axioms seven_le_chromaticNumber_plane_of_bounded_family
#print axioms three_le_chromaticNumber_complex_of_exact_triangle
#print axioms three_le_chromaticNumber_complex_of_shrinking_triangles
#print axioms collapsed_drawing_satisfies_one_tolerance
#print axioms collapsed_drawing_fails_below_one
#print axioms add_one_le_chromaticNumber_unitDistance_edgeList

-- M45, the arity of a colour compulsion: a partial colouring that does not extend, and how few
-- vertices one needs. `compels_two_eq`/`compels_two_ne` are the statement that arity two IS the
-- repository's existing `Separated`/`Forces`; `arityFloor_le_of_degree` is the theorem that four
-- flat pair campaigns were asking below a bound that was always available.
#print axioms samePattern_two
#print axioms Realizes.congr
#print axioms realizes_iff_extends
#print axioms realizes_iff_exists
#print axioms compels_two_eq
#print axioms compels_two_ne
#print axioms Separated.compels
#print axioms Forces.compels
#print axioms arityFloor_le_of_compels
#print axioms le_arityFloor_iff
#print axioms arityFloor_eq_zero_iff
#print axioms two_le_arityFloor
#print axioms compels_of_fan
#print axioms compels_rainbow_of_neighbors
#print axioms arityFloor_le_of_degree
#print axioms AritySpec.p5cols_proper
#print axioms AritySpec.p5_no_pair_compulsion
#print axioms AritySpec.p5_compels_rainbow
#print axioms AritySpec.p5_arityFloor
#print axioms AritySpec.tri_arityFloor
#print axioms AritySpec.k4_arityFloor_zero

-- M48 — how a compulsion travels between graphs, and the six-colour programme's exact requirement.
-- `arityFloor_le_of_embedding` is the LADDER theorem (growing a graph can only LOWER its floor —
-- the bigger graph is on the left), which is what makes a closure-ladder measurement mean anything.
-- `Separated.comap` is the missing dual of `Forcer.Forces.comap`, and `Separated.plane` transports
-- a finite gadget's virtual edge to the whole plane. `not_colorable_five_of_forced_pairs` is the
-- correction this milestone makes to its own record: `hexShell_plane5` is DISJUNCTIVE, so
-- chi(R^2) >= 6 needs a virtual edge at sqrt3 AND one at distance 2, never one at either.
#print axioms Realizes.comap
#print axioms PartialColoring.map
#print axioms Compels.map
#print axioms arityFloor_le_of_embedding
#print axioms Separated.comap
#print axioms exists_isometry_map_pair
#print axioms forced_pair_of_forced
#print axioms Separated.plane
#print axioms not_colorable_five_of_forced_pairs
#print axioms six_le_chromaticNumber_plane_of_forced_pairs

-- M49 — the distance graph of a set of forbidden distances, homogeneity made relation-generic
-- over it, and the spindle as a theorem: `not_colorable_of_forced_equal` (forced-equal at any
-- d >= 1/2 refutes k-colourability, homogeneity ∘ a d–d–1 triangle), the gadget→Forces bridge, and
-- ONE DEFECT SUFFICES (`add_one_le_chromaticNumber_unitDistance_of_one_defect`: a (k+1)-chromatic
-- plane graph with a single non-unit edge already bounds chi(R^2)). The spec re-proves the Moser
-- bound through the abstract lemma from the rhombus alone.
#print axioms unitDistance_eq_distanceGraph_singleton
#print axioms chromaticNumber_unitDistance_le_distanceGraph
#print axioms add_one_le_chromaticNumber_distanceGraph_edgeList
#print axioms exists_mono_pair_of_not_colorable_two_distance
#print axioms not_colorable_unitDistance_of_forced_distinct
#print axioms UDCert.pairsAt_sound_sq
#print axioms UDCert.adj_dist_mem
#print axioms transport_pair
#print axioms Separated.planeIn
#print axioms Forces.planeIn
-- P3 (consolidation 2026-09-09): the same transport off ℂ, over any metric space, with the
-- existence of the isometry as a hypothesis; plus the two ways to discharge it.
#print axioms HadwigerNelson.transport_pair_of_isometry
#print axioms HadwigerNelson.isometry_affine
#print axioms HadwigerNelson.exists_isometry_map_pair_of_mapsTo
#print axioms HadwigerNelson.Separated.transport
#print axioms HadwigerNelson.Forces.transport
#print axioms HadwigerNelson.quarterTurn_mapsTo
#print axioms HadwigerNelson.distanceGraph_induce
#print axioms HadwigerNelson.unitDistance_induce
#print axioms exists_dist_eq_and_dist_eq_one
#print axioms not_exists_dist_eq_and_dist_eq_one_of_lt_half
#print axioms not_colorable_of_forced_equal
#print axioms add_one_le_chromaticNumber_of_forced_equal
#print axioms forces_of_gadget
#print axioms forces_of_not_colorable_append_single
#print axioms add_one_le_chromaticNumber_unitDistance_of_forces
#print axioms add_one_le_chromaticNumber_unitDistance_of_one_defect
#print axioms rhombus_forces_of_gadget
#print axioms four_le_chromaticNumber_plane_of_rhombus
#print axioms four_le_chromaticNumber_plane_of_rhombus_defect
#print axioms seven_le_chromaticNumber_hexShell_distances
-- M50: the partner lattice's depth-one completeness (PartnerLattice.lean)
#print axioms HadwigerNelson.Glue.eq_gluePoint_of_unit_pair
#print axioms HadwigerNelson.Glue.finite_two_unit_neighbors
-- P3 (consolidation 2026-09-09): the same, at arbitrary radii.
#print axioms HadwigerNelson.Glue.eq_gluePoint_of_dist_pair
-- M51: the spare-colour lemma, both polarities + contrapositives (SpareColour.lean)
#print axioms HadwigerNelson.not_forces_of_colorable
#print axioms HadwigerNelson.not_separated_of_colorable
#print axioms HadwigerNelson.Forces.not_colorable
#print axioms HadwigerNelson.Separated.not_colorable
-- M54: the critical-set localization theorem (CriticalSet.lean) — the isolating lemma, both polarities
-- and the fan form, the spare-colour re-derivation's engine, the degree bound, the three plane corollaries
#print axioms HadwigerNelson.exists_coloring_isolating_of_mem_criticalSet
#print axioms HadwigerNelson.not_forces_of_mem_criticalSet
#print axioms HadwigerNelson.not_separated_of_mem_criticalSet
#print axioms HadwigerNelson.not_fan_of_mem_criticalSet
#print axioms HadwigerNelson.criticalSet_subset_of_fan
#print axioms HadwigerNelson.criticalSet_subset_inter_neighborSet_of_forces
#print axioms HadwigerNelson.criticalSet_subset_union_neighborSet_of_separated
#print axioms HadwigerNelson.not_mem_criticalSet_of_forces
#print axioms HadwigerNelson.criticalSet_eq_univ_of_colorable
#print axioms HadwigerNelson.encard_criticalSet_le_degree_of_forces
#print axioms HadwigerNelson.eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces
#print axioms HadwigerNelson.criticalSet_eq_empty_of_forces_of_two_lt_dist
-- P3 (consolidation 2026-09-09): the two-distance and metric-space generalizations of the
-- previous two lines. The counting bound below them does NOT generalize — see the module.
#print axioms HadwigerNelson.eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in
#print axioms HadwigerNelson.criticalSet_eq_empty_of_forces_of_two_mul_lt_dist
#print axioms HadwigerNelson.encard_criticalSet_le_two_of_forces
-- M55: absorption (Absorb.lean) — the extension principle, the repaint carrier, hub / matching /
-- greedy / symmetric-copy absorption, the degree instance, the red's finite heart
#print axioms HadwigerNelson.Extends.forces_iff
#print axioms HadwigerNelson.Extends.separated_iff
#print axioms HadwigerNelson.Extends.not_forces_of_colorable
#print axioms HadwigerNelson.Extends.not_separated_of_colorable
#print axioms HadwigerNelson.extends_of_repaint
#print axioms HadwigerNelson.extends_of_hubs
#print axioms HadwigerNelson.extends_of_hub_matching
#print axioms HadwigerNelson.extends_of_matching
#print axioms HadwigerNelson.extends_of_extensionOrder
#print axioms HadwigerNelson.extends_compl_singleton_of_degree_le
#print axioms HadwigerNelson.extends_symCopy
#print axioms HadwigerNelson.k33_lists_refuse
-- M51: the entropy floor K4 — a k-colourable graph has ≥ 2^⌈n/k⌉ (k+1)-colourings (EntropyFloor.lean)
#print axioms HadwigerNelson.two_pow_le_card_coloring
#print axioms HadwigerNelson.spareColorings_eq_last_iff
#print axioms HadwigerNelson.not_colorable_of_card_coloring_lt
-- M52: the copy construction — the spindle rotation, the self-chord law, the copy union (Copy.lean)
#print axioms HadwigerNelson.Copy.spindleRot_two
#print axioms HadwigerNelson.Copy.spindleRot_sqrt3
#print axioms HadwigerNelson.Copy.normSq_spindleRot
#print axioms HadwigerNelson.Copy.norm_one_sub_spindleRot
#print axioms HadwigerNelson.Copy.dist_self_rotAbout
#print axioms HadwigerNelson.Copy.isometry_rotAbout
#print axioms HadwigerNelson.Copy.self_chord_iff
#print axioms HadwigerNelson.Copy.le_copyUnion_comap_inl
#print axioms HadwigerNelson.Copy.le_copyUnion_comap_inr
#print axioms HadwigerNelson.Copy.copyUnion_adj_inl_inr
#print axioms HadwigerNelson.Copy.chromaticNumber_copyUnion_le
-- M56: additive colourings (Additive.lean) — an additive colouring is a colouring, its two refutations
-- in the Forces/Separated vocabulary, and the divisibility lemma (L1) at any exponent and at the exponent
#print axioms HadwigerNelson.additiveColoring
#print axioms HadwigerNelson.additiveColoring_apply
#print axioms HadwigerNelson.not_forces_of_addMonoidHom
#print axioms HadwigerNelson.not_separated_of_addMonoidHom
#print axioms HadwigerNelson.addMonoidHom_apply_eq_of_sub_eq_nsmul
#print axioms HadwigerNelson.addMonoidHom_apply_eq_of_sub_eq_exponent_nsmul
#print axioms HadwigerNelson.parity_grid
-- M57: additive rigidity (AdditiveRigid.lean) — the reduction theorem (all colourings additive ⟹ kΛ-pairs forced),
-- its plane corollaries, the bridge from homs, the spec (the unit path at 2 ⟹ χ ≥ 3) and the two reds
#print axioms HadwigerNelson.isAdditive_of_addMonoidHom
#print axioms HadwigerNelson.isAdditive_additiveColoring
#print axioms HadwigerNelson.IsAdditive.apply_eq
#print axioms HadwigerNelson.forces_of_additivelyRigid
#print axioms HadwigerNelson.add_one_le_chromaticNumber_unitDistance_of_additivelyRigid
#print axioms HadwigerNelson.six_le_chromaticNumber_plane_of_additivelyRigid
#print axioms HadwigerNelson.pathGraph_additivelyRigid
#print axioms HadwigerNelson.three_le_chromaticNumber_plane_of_pathGraph
#print axioms HadwigerNelson.cycleGraph_six_not_additivelyRigid
#print axioms HadwigerNelson.pathGraph_not_additivelyRigid_three
-- M58: the finite-plane bound (UnitQuadrance.lean, Instances/FinitePlane11.lean) — the reduction of a valid
-- certificate through a ring hom out of a subring of the tower, χ(UD(F_11,2)) = 5 and χ(Heule-510) = 5 exactly,
-- the floor at 131 through the whole tower
#print axioms HadwigerNelson.unitQuadrance_adj
#print axioms HadwigerNelson.UDCert.drawing_adj
#print axioms HadwigerNelson.UDCert.colorable_of_unitQuadrance
#print axioms HadwigerNelson.UDCert.add_one_le_chromaticNumber_unitQuadrance
#print axioms HadwigerNelson.heule510_coordsIn_sevenFree
#print axioms HadwigerNelson.finitePlane11_colorable_five
#print axioms HadwigerNelson.finitePlane11_not_colorable_four
#print axioms HadwigerNelson.chromaticNumber_finitePlane11
#print axioms HadwigerNelson.heule510_colorable_five
#print axioms HadwigerNelson.chromaticNumber_heule510
#print axioms HadwigerNelson.five_le_chromaticNumber_finitePlane131


/-! ## M01 — the model of the hypotheses, and χ ≥ 3 -/

#print axioms trianglePoints_dist
#print axioms not_colorable_two_top_fin_three
#print axioms edgeGraph_triangleEdges_eq_top
#print axioms three_le_chromaticNumber_unitDistance_complex
#print axioms three_le_chromaticNumber_unitDistance_complex'
#print axioms three_le_chromaticNumber_plane

/-! ## M02 — the exact-arithmetic tower and the certificate bridge -/

#print axioms Q4.eval
#print axioms eval_distSq
#print axioms dist_toPlane_eq_one
#print axioms UDCert.validOn_iff
#print axioms UDCert.valid_of_chunks
#print axioms UDCert.valid_sound
#print axioms UDCert.add_one_le_chromaticNumber_of_valid
#print axioms moserSpindle_valid

/-! ## M03 — the SAT bridge

None of these evaluates a certificate; they are theorems *about* `Unsat` hypotheses, so they are
clean regardless of how the hypothesis was obtained. -/

#print axioms exists_sat_coloringCNF
#print axioms not_colorable_of_unsat
#print axioms cubeOf_mem_allCubes
#print axioms exists_sat_coloringCNF_cube
#print axioms not_colorable_of_cubes
#print axioms colorable_iff_exists
#print axioms not_colorable_edgeGraph_iff
#print axioms unsat_of_check
#print axioms chromaticNumber_plane_eq_complex
#print axioms UDCert.add_one_le_chromaticNumber_plane_of_valid
#print axioms UDCert.add_one_le_chromaticNumber_plane_of_unsat
#print axioms UDCert.add_one_le_chromaticNumber_plane_of_cubes

/-! ## M03 — the spindle's brute-force route, and the headline -/

#print axioms moserSpindle_not_colorable_three
#print axioms moserSpindle_colorable_four
#print axioms exists_sat_coloringCNF_four
#print axioms moserSpindleCubes_eq
#print axioms four_le_chromaticNumber_plane

/-! ## M04 — de Grey's 1581 vertices, certified

`deGrey_valid` is the milestone: 7877 edges, each an exact identity in `ℚ(√3,√5,√7,√11)`, decided
by kernel reduction in 158 chunks. Nothing here is native — the whole geometry half of `χ(ℝ²) ≥ 5`
stays inside the standard axiom set, and `deGrey_bound_of_not_colorable` shows what a fifth colour
would still cost: one hypothesis, no geometry. -/

#print axioms UDCert.validOn_flatten
#print axioms UDCert.badEdges_eq_nil_iff
#print axioms deGrey_valid
#print axioms deGrey_unit_distances
#print axioms deGrey_bound_of_not_colorable

/-! ## M05 — the kernel-runnable refutation checker

The point of the milestone is that these are in the **clean** section. `maskCheck_sound` is the only
route from a checked certificate to unsatisfiability, and both of its hypotheses are closed `Bool`s
the kernel decides — so a refutation costs no axiom beyond the standard three, where M03's route
below buys one per declaration. -/

#print axioms LitSet.any_ofClause_iff
#print axioms LitSet.entails_zero_iff_unsat
#print axioms propagate_conflict_sound
#print axioms propagate_prop_sound
#print axioms justified_of_agreesWithCNF
#print axioms rup_sound
#print axioms runActions_sound
#print axioms runStream_sound
#print axioms maskCheck_sound

/-! ## M06 — χ(ℝ²) ≥ 5

**The milestone, and the project's headline.** `chromaticNumber_plane_ge_five` must appear in the
*clean* section: the whole point of M05 was that a refutation of de Grey's graph costs no axiom beyond
the standard three, and this is where that is either true or not.

`deGreyRot_not_colorable_four` is the claim no human can check by inspection — it quantifies over `4^1581`
assignments — so it is the one where a native-evaluation axiom would matter most. It is clean. -/

#print axioms edgeGraph_adj_mono
#print axioms valid_comp_of_injective
#print axioms exists_perm_apply_eq
#print axioms not_pinned
#print axioms runSegment_sound
#print axioms justified_of_segment
#print axioms unsat_of_segment
#print axioms deGrey_halfA_subset
#print axioms deGreyRot_valid
#print axioms deGrey_rotation
#print axioms deGrey_adj_cross
#print axioms halfA_unsat
#print axioms deGreyRot_not_colorable_four
#print axioms chromaticNumber_plane_ge_five

/-! ## M09 — the gadget algebra, and de Grey's second copy derived

The milestone's whole claim is that half B's certificate was redundant. `deGrey_rotation` above is
what replaced it, and it must be clean: it is 791 exact identities the kernel decides, and a native
purchase there would move the construction's central fact out of the kernel's reach.

`Motion.distSq_eq` and `UDCert.validOn_map_of_motion` carry the geometry of every placed copy; the
`Gadget` combinators carry the colouring properties. Both are the instrument M11 runs on. -/

#print axioms exists_perm_comp_eq
#print axioms not_colorable_of_gadget
#print axioms Gadget.ofUnsat
#print axioms Gadget.transport
#print axioms Gadget.edge
#print axioms Motion.distSq_eq
#print axioms UDCert.validOn_of_subset
#print axioms UDCert.validOn_map_of_motion
#print axioms deGreyPhiNat_inj
#print axioms deGreyMotion_maps
#print axioms deGreyRot_validOn_rotated

/-! ## M10 — the fractional chromatic number, and `χ_f(ℝ²) ≥ 65/18`

The fractional bound is a *lower* bound on an infimum, so it says something only because it
quantifies over every fractional colouring — and `C5_fractional` is what shows the definition is not
secretly the ordinary chromatic number, by pinning a value that is not an integer.

`coreSpindle_noHeavy` is this milestone's uninspectable claim: no independent set of 63 points
weighs more than 72, over `10⁹`-odd sets. It must be clean, and so must
`four_le_chromaticNumber_plane_fractional`, which re-derives M03's rung from the fractional bound
alone. -/

#print axioms SimpleGraph.le_fractionalChromaticNumber_iff
#print axioms SimpleGraph.FractionalColorable.fractionalChromaticNumber_le
#print axioms SimpleGraph.fractionalChromaticNumber_mono_of_hom
#print axioms SimpleGraph.le_fractionalChromaticNumber_of_weights
#print axioms SimpleGraph.le_fractionalChromaticNumber_of_indepNum
#print axioms SimpleGraph.not_colorable_of_lt_fractionalChromaticNumber
#print axioms HadwigerNelson.FractionalSpec.C5_fractional
#print axioms HadwigerNelson.nbrMask_and_two_pow_eq_zero
#print axioms HadwigerNelson.noHeavy_sound
#print axioms HadwigerNelson.le_fractionalChromaticNumber_unitDistance_edgeList
#print axioms HadwigerNelson.coreSpindle_valid
#print axioms HadwigerNelson.coreSpindle_slots
#print axioms HadwigerNelson.coreSpindle_noHeavy
#print axioms HadwigerNelson.coreSpindle_unit_distances
#print axioms HadwigerNelson.findHeavy_isNone
#print axioms HadwigerNelson.fractionalChromaticNumber_plane_ge
#print axioms HadwigerNelson.four_le_chromaticNumber_plane_fractional

/-! ## M07 — two smaller witnesses, on the same infrastructure

The same theorem from two graphs that share no vertex, no edge and no certificate with de Grey's, so
that a fault in the encoding or the checker would have to be one that certifies three unrelated
graphs. Both go through `not_colorable_of_gadget` — one refutation and the pinned triangle's own
three edges, composed. -/

#print axioms halfA_table_refuses_halfB_cnf
#print axioms deGrey_forcing_alone_admits
#print axioms heule510_valid
#print axioms heule510_unit_distances
#print axioms heule510_unsat
#print axioms heule510_not_colorable_four
#print axioms chromaticNumber_plane_ge_five_510
#print axioms heule553_valid
#print axioms heule553_unit_distances
#print axioms heule553_unsat
#print axioms heule553_not_colorable_four
#print axioms chromaticNumber_plane_ge_five_553

/-! ## M11 — the search instrument

Two rewrites and one new module, and the audit is where their reach is stated.

`exists_mem_canonPatterns` is what makes the terminal check exhaustive while enumerating a fraction
of the colourings: every colouring of the ports matches a listed one. If it were unsound, every
`not_colorable_of_gadget` above it would be too — which is the whole of `Gadget`'s conclusion, on
all three witnesses.

`Motion.distSq_image` and `UDCert.validOn_map_of_scaling` are the pair that make a placed copy free.
They are checked here because a copy placed by them is asserted *nowhere else*: there is no
per-vertex identity to inspect, which is exactly what makes them worth auditing.

`Gadget.ofExhaustion` produces a gadget with no solver and no certificate anywhere, so it is the one
producer whose trust is entirely the kernel's. -/

#print axioms exists_mem_canonPatterns
#print axioms samePattern_iff
#print axioms Gadget.ofExhaustion
#print axioms rhombusGadget
#print axioms Motion.maps_iff
#print axioms Motion.distSq_image
#print axioms Motion.distSq_rescale
#print axioms Motion.maps_trans
#print axioms UDCert.validOn_map_of_scaling

/-! ## M12 — many placed copies, and the first five-colour question

`Assembly` is the layer that makes a candidate built as an orbit cheap: every copy's coordinates are
*derived* from the base and a motion rather than emitted, so there is no per-vertex identity to
inspect and nothing to audit but these theorems. `validOn_copiedEdges` is the one that certifies a
copy's whole edge list without reducing a single distance, and `adj_embed` is its combinatorial twin —
together they are why a placed copy is free in both halves rather than only the cheap one.

`mycielski47_colorable_six` is the control that keeps the five-colour claim honest: an *existence*
statement, the opposite direction from everything else in this project, so a refutation that was
silently about the wrong colour count cannot pass unnoticed.

`mycielski47_not_colorable_five` is the headline: the first statement in this project about
*five*-colourings, resting on a kernel-checked certificate of 387,065 propagation steps. It is
audited here rather than trusted, and its axiom list is the whole claim — a native purchase would
show up in it, and none does. -/

#print axioms Assembly.distSq_place
#print axioms Assembly.verts_embed
#print axioms Assembly.validOn_copiedEdges
#print axioms Assembly.valid_of_cross
#print axioms Assembly.adj_embed
#print axioms Mycielski.pinned_unsat
#print axioms mycielski47_not_colorable_five
#print axioms mycielski47_colorable_six

/-! ## M13 — a forced pair, and the spindle that closes it

The argument both known rungs of this problem share, stated once for any graph and any number of
colours. `not_colorable_of_spindled_forcer` is the whole of it: a configuration whose every
`k`-colouring paints `p` and `q` alike, placed twice sharing `p` with the images of `q` adjacent, has
no `k`-colouring. `not_colorable_spindleEdges` is the form a search's output arrives in, where the
assembled graph is *constructed* rather than given, so neither placement has to be searched for.

Two producers audited beside them, because a property with one producer is a property one bug wide:
`Forces.of_edges` exhausts the colourings and `Forces.of_gadget` reads a certificate through the
gadget algebra. `moserSpindle_not_colorable_three_spindled` is the payoff at spec scale — rung A's
witness re-derived by deciding a four-vertex rhombus and placing it twice, rather than deciding all
seven vertices. It is a *fourth* independent route to a theorem this project already had three of,
which is exactly the kind of redundancy that catches a wrong statement. -/

#print axioms Forces.comap
#print axioms Forces.mono
#print axioms Forces.map
#print axioms not_colorable_of_spindled_forcer
#print axioms Forces.of_edges
#print axioms Forces.of_gadget
#print axioms Forces.of_unsat
#print axioms edgeHom
#print axioms not_colorable_spindleEdges
#print axioms rhombus_forces
#print axioms moserSpindle_not_colorable_three_spindled
#print axioms spindleFromRhombi_not_colorable_three

/-! ## M14 — fans, the disjunctive forcer

`Forces` is the width-one case of `Fan`, so these are the statements a search above rung B lands on
before it has narrowed to a forced pair. Nothing here evaluates anything natively. -/

#print axioms Fan
#print axioms Separated
#print axioms Separated.of_adj
#print axioms not_colorable_of_fan
#print axioms not_colorable_of_fan_nil
#print axioms fan_singleton_iff
#print axioms Fan.narrow
#print axioms Fan.widen
#print axioms Fan.mono
#print axioms Fan.comap
#print axioms Fan.map
#print axioms not_colorable_of_spindled_fan
#print axioms fanEdges
#print axioms Fan.of_not_colorable
#print axioms Fan.of_unsat
#print axioms fan_iff_not_colorable
#print axioms Fan.of_edges

/-! ## M15 — a fan is one removable vertex, and the certified negative

The correspondence, its fan-facing corollaries, the packed certificate, and the two witnesses whose
every vertex is now proved necessary. The last two are the milestone's headline: no five-colour fan
sits anywhere in either graph, so the route that produced χ ≥ 5 has nothing here to start from. -/

#print axioms exists_isolating_of_colorable_delete
#print axioms colorable_delete_of_exists_isolating
#print axioms colorable_delete_iff_exists_isolating
#print axioms not_fan_of_colorable_delete
#print axioms not_forces_of_colorable_delete
#print axioms not_fan_of_vertex_critical
#print axioms fan_univ_of_not_colorable_delete
#print axioms fan_univ_iff
#print axioms delete_edgeGraph
#print axioms unpackColor
#print axioms properOffPivot
#print axioms criticalFrom
#print axioms criticalFrom_append
#print axioms criticalFrom_append_of
#print axioms everyVertexCritical
#print axioms colorable_delete_of_packed
#print axioms forall_colorable_delete_of_packed
#print axioms no_fan_of_packed
#print axioms heule510_criticality
#print axioms heule510_vertex_critical
#print axioms heule510_no_five_fan
#print axioms heule553_criticality
#print axioms heule553_vertex_critical
#print axioms heule553_no_five_fan

/-! ## M16 — no fan in de Grey's graph is narrow, certified against real distances

The interval instrument (exact `Q4` values compared as reals, from decidable generator bounds),
the narrow-fan certificate checker with its soundness bridge, and the four headline negatives —
one per pivot that carries a five-colour fan at all. The closing move needs a fan confined to one
real distance; these say the only four known fans offer it nothing. -/

#print axioms Ival.mem_ofInt
#print axioms Ival.Mem.scaleUp
#print axioms Ival.Mem.add
#print axioms Ival.Mem.mul
#print axioms mem_sqrt
#print axioms Adjoin.approx
#print axioms Adjoin.mem_approx
#print axioms Q4.approx
#print axioms Q4.mem_approx
#print axioms sepIvals
#print axioms sepChain
#print axioms eval_lt_of_hi_lt_lo
#print axioms pairwise_lt_of_sepChain
#print axioms pairwise_ne_of_sepChain
#print axioms index_eq_of_eval_eq
#print axioms unpackNat
#print axioms unpackZ
#print axioms unpackQ4
#print axioms properColouring
#print axioms exists_coloring_of_proper
#print axioms NarrowCert.checkVertex
#print axioms NarrowCert.check
#print axioms NarrowCert.eval_distSq_eq_of_dist_eq
#print axioms NarrowCert.sound
#print axioms NarrowCert.vertexFault_none_iff
#print axioms NarrowCert.firstFault_none_iff_check
#print axioms deGreyNarrow630_check
#print axioms deGrey_no_narrow_fan_630
#print axioms deGreyNarrow633_check
#print axioms deGrey_no_narrow_fan_633
#print axioms deGreyNarrow1420_check
#print axioms deGrey_no_narrow_fan_1420
#print axioms deGreyNarrow1423_check
#print axioms deGrey_no_narrow_fan_1423

/-! ## M17 — deletion never creates a fan

The pruning corollaries the hunt's growth-only design rests on: list inclusion lifts to the graph
order, a fan lifts with it, and — contrapositively — a separating colouring restricts to every
sub-candidate. -/

#print axioms edgeGraph_mono
#print axioms Fan.of_subset
#print axioms not_fan_of_subset

/-! ## M18 — the 120° class

The plane-level structure behind the resisting histogram: the chord bound, the triangle
identity, the 120° closure, "no class confines alone" (with its greedy-colouring engine), and
the coverage⟺fan reduction that turns confinement into a measurable gradient. -/

#print axioms SimpleGraph.colorable_of_degree_lt
#print axioms eq_or_eq_or_eq_of_dist_eq
#print axioms dist_sq_centroid_unit_triangle
#print axioms eq_centroid_of_dist_eq
#print axioms exists_unit_triangle_iff
#print axioms omega3_cube
#print axioms rot3_rot3_rot3
#print axioms dist_rot3_self
#print axioms rot3_unit_triangle
#print axioms not_fan_of_colorable_of_edges_within
#print axioms degree_classOnlyGraph_le_two
#print axioms not_fan_classOnlyGraph
#print axioms Fan.of_coverage
#print axioms fan_iff_coverage
#print axioms three_le_card_of_triangle_mem

/-! ## M19 — the two-circle theorem, the coverage ratchet, the balanced witness

The local ceiling (every unit-distance graph on a 120°-pivot's two circles is 3-colourable,
via the seam rotation's infinite order), the monotonicity that makes minCov a ratchet, and
the kernel-checked balanced 5-colouring of de Grey's graph (the density-obstruction
negative). The witness facts are `decide +kernel` — no native evaluation anywhere. -/

#print axioms TwoCircle.seam_pow_ne_one
#print axioms TwoCircle.zeta6_zpow_eq_one_iff
#print axioms TwoCircle.ratio_of_unit_chord
#print axioms TwoCircle.ratio_of_sqrt3_chord
#print axioms TwoCircle.ratio_of_cross_chord
#print axioms TwoCircle.label_unique
#print axioms TwoCircle.colorable_three_induce
#print axioms TwoCircle.colorable_three_comap
#print axioms CoverAtLeast.anti
#print axioms CoverAtLeast.mono_subset
#print axioms CoverAtLeast.mono_edges
#print axioms fan_iff_coverAtLeast
#print axioms CoverAtLeast.of_triangle_mem
#print axioms balancedColorRaw_lt
#print axioms balancedColorRaw_proper
#print axioms balancedColoring_counts
#print axioms deGrey_balanced

/-! ## M20 — the 120° compulsion, the one-pivot cap, the strip automaton

The first independent-set compulsion (an outer 120°-triple is never monochromatic under
three colours — the seam-image unit triangle refuses), the exact chromatic number of one
pivot's whole system ({p} ∪ both circles = 4), and the tube's colouring theory with the
window-extension theorem. All finite parts are `decide +kernel` against literal tables —
no native evaluation anywhere. -/

#print axioms Compulsion.no_mono_outer_triple
#print axioms Compulsion.concentric_not_colorable_three
#print axioms Compulsion.concentric_colorable_four
#print axioms Compulsion.chromaticNumber_concentric
#print axioms Compulsion.seamRatio_mul_sqrt3
#print axioms Strip.hexTable_complete
#print axioms Strip.rainTable_complete
#print axioms Strip.nonMonoB_of_avoids_rain
#print axioms Strip.mono_avoids_no_rainbow
#print axioms Strip.avoid_card
#print axioms Strip.twostep_card
#print axioms Strip.window_extends

/-! ## M21 — coupled circle systems: the unit-distance pivot pair

The reflection package (`reflAcross`, the pair's one symmetry — an involutive isometry
fixing both pivots), the interlock, the four gluing classifications (each circle-pair
intersection is exactly {a point, its mirror}, witnessed by the strip's own operators),
and the superset-quantified lower bound (any set containing one pivot's system needs
four colours). Pure geometry over ℂ — no tables, no native evaluation. -/

#print axioms Coupled.reflAcross_pivot_left
#print axioms Coupled.reflAcross_pivot_right
#print axioms Coupled.reflAcross_swap
#print axioms Coupled.reflAcross_reflAcross
#print axioms Coupled.dist_reflAcross
#print axioms Coupled.reflAcross_mem_sphere_left
#print axioms Coupled.reflAcross_mem_sphere_right
#print axioms Coupled.seamImage_interlock
#print axioms Coupled.outer_inter_outer
#print axioms Coupled.outer_inter_inner
#print axioms Coupled.inner_inter_outer
#print axioms Coupled.inner_inter_inner
#print axioms Coupled.four_le_chromaticNumber_of_system_subset
#print axioms Coupled.four_le_chromaticNumber_pairSystem

/-! ## M22 — the general gluing classification

`reflAxis` (the mirror across an arbitrary axis — ratio conjugation, collapsing to
M21's `reflAcross` at unit axis), the general classification (two distinct centres
under the annulus condition meet in exactly the glue point and its mirror; empty
outside), and the nine-step near-cycle (`ζ₆·σ⁹` is within chord 1/50 of 1 and is
not 1 — the first certified near-relation). Pure geometry over ℂ — no tables, no
native evaluation. -/

#print axioms Glue.reflAxis_pivot_left
#print axioms Glue.reflAxis_pivot_right
#print axioms Glue.reflAxis_reflAxis
#print axioms Glue.dist_reflAxis
#print axioms Glue.reflAxis_mem_sphere_left
#print axioms Glue.reflAxis_mem_sphere_right
#print axioms Glue.reflAxis_eq_reflAcross
#print axioms Glue.sphere_inter_sphere
#print axioms Glue.sphere_inter_sphere_eq_empty_of_far
#print axioms Glue.sphere_inter_sphere_eq_empty_of_nested
#print axioms Glue.zeta6_mul_seam_pow_nine_ne_one
#print axioms Glue.normSq_zeta6_mul_seam_pow_nine_sub_one_lt

/-! ## M23 — the pivot triangle and the metapivot system

The self-gluing cycle, the centroid as triple glue point, the three no-new-points
metapivot couplings, the ten-point sharing theorem with its count, the chord
classifications (outer–outer rigidity, inner–inner Möbius), the translation
coupling, the loop identities (hex parallelogram; the rotation hexagon — generic
in the rotation AND the three points — with its seam instance), and the zpow
closure backbone. Pure geometry over ℂ. -/

#print axioms Triangle.dist_pivot_01
#print axioms Triangle.dist_pivot_02
#print axioms Triangle.dist_pivot_12
#print axioms Triangle.dist_centroid_0
#print axioms Triangle.dist_centroid_1
#print axioms Triangle.dist_centroid_2
#print axioms Triangle.hexStep_cycle_01
#print axioms Triangle.hexStep_cycle_12
#print axioms Triangle.hexStep_cycle_20
#print axioms Triangle.outer_inter_outer_eq_third
#print axioms Triangle.centroid_glue_01
#print axioms Triangle.centroid_glue_12
#print axioms Triangle.centroid_glue_20
#print axioms Triangle.outer_inter_metaInner
#print axioms Triangle.inner_inter_metaOuter
#print axioms Triangle.inner_inter_metaInner
#print axioms Triangle.system_inter_system
#print axioms Triangle.ncard_system_inter_system
#print axioms Triangle.unit_chord_outer_outer
#print axioms Triangle.unit_chord_inner_inner
#print axioms Triangle.outer_partner_pair
#print axioms Triangle.mem_sphere_translate
#print axioms Triangle.dist_translate
#print axioms Triangle.one_sub_zeta6
#print axioms Triangle.hexStep_matching
#print axioms Triangle.hexStep_hexStep_eq_rot3_centroid
#print axioms Triangle.hexStep_triple_flip
#print axioms Triangle.hex_parallelogram
#print axioms Triangle.rot_hexagon
#print axioms Triangle.seam_hexagon
#print axioms Triangle.zeta6_zpow_mul_seam_zpow_eq_one_iff
#print axioms Triangle.rotAbout_zeta6
#print axioms Triangle.rotAbout_seamRatio
#print axioms Triangle.rotAbout_omega3

/-! ## M24 — the matched ladder pair: completeness theorems and the unconditional χ = 4

The countable two-pivot ladder with every chord family fixed by theorems rather than a
census window. The completeness core runs in `ℤ[ζ₆, π]`, `π = √3·σ`: parity separation
on `√3 ∉ ℚ(ζ₆, π)`, coordinate congruences modulo three, and the `piCoeff` recurrence.
The headline is `Ladder.chromaticNumber_ladderPair`. -/

#print axioms Ladder.word_eq_one_iff
#print axioms Ladder.word_inj
#print axioms Ladder.cross_dist
#print axioms Ladder.intra_dist
#print axioms Ladder.oo_complete
#print axioms Ladder.ii_chord_iff
#print axioms Ladder.oi_chord_iff
#print axioms Ladder.intra_outer_complete
#print axioms Ladder.intra_inner_complete
#print axioms Ladder.intra_seam_complete
#print axioms Ladder.outerPt_inj
#print axioms Ladder.innerPt_inj
#print axioms Ladder.outer_ne_inner
#print axioms Ladder.fusion_oo
#print axioms Ladder.fusion_oi
#print axioms Ladder.fusion_io
#print axioms Ladder.fusion_ii
#print axioms Ladder.sqrt_indep
#print axioms Ladder.piC_pow_coeff
#print axioms Ladder.piCoeff_norm
#print axioms Ladder.sqrt3_pow_mul_word
#print axioms Ladder.eq_zero_of_add_sqrt3_mul
#print axioms Ladder.inRing_coords_zero
#print axioms Ladder.normBranch_cleared
#print axioms Ladder.normBranch_parity
#print axioms Ladder.normBranch_even
#print axioms Ladder.normBranch_odd_large
#print axioms Ladder.normBranch_odd_one
#print axioms Ladder.normBranch_odd_mixed
#print axioms Ladder.normBranch_cleared_neg
#print axioms Ladder.normBranch_parity_neg
#print axioms Ladder.normBranch_even_neg
#print axioms Ladder.normBranch_odd_neg
#print axioms Ladder.ii_norm_complete
#print axioms Ladder.ii_norm_bound
#print axioms Ladder.oi_complete
#print axioms Ladder.ladderColor_valid
#print axioms Ladder.colorable_four_ladder
#print axioms Ladder.witness_not_colorable_three
#print axioms Ladder.not_colorable_three_ladder
#print axioms Ladder.chromaticNumber_ladderPair

/-! ## M25 — the four-ladder object (the pivot triangle's ladders plus the metapivot's own)

The headline is `MetaLadder.chromaticNumber_fourLadder`. -/

#print axioms MetaLadder.sqrt3_mul_zeta12
#print axioms MetaLadder.meta_axis_dirs
#print axioms MetaLadder.metaInner_hub
#print axioms MetaLadder.outerPt_hexRot
#print axioms MetaLadder.outerPt_affine
#print axioms MetaLadder.web_transport_rot
#print axioms MetaLadder.web_transport_rot_meta
#print axioms MetaLadder.ladderSet_subset_fourLadder
#print axioms MetaLadder.bridge_oo
#print axioms MetaLadder.bridge_oi
#print axioms MetaLadder.bridge_io
#print axioms MetaLadder.bridge_ii
#print axioms MetaLadder.fusion_bridge_oo
#print axioms MetaLadder.fusion_bridge_oi
#print axioms MetaLadder.fusion_bridge_io
#print axioms MetaLadder.fusion_bridge_ii
#print axioms MetaLadder.hexTrace_coords
#print axioms MetaLadder.meta_oo_complete
#print axioms MetaLadder.meta_oi_complete
#print axioms MetaLadder.meta_io_complete
#print axioms MetaLadder.meta_ii_complete
#print axioms MetaLadder.meta_fusion_oo
#print axioms MetaLadder.meta_fusion_oi
#print axioms MetaLadder.meta_fusion_io
#print axioms MetaLadder.meta_fusion_ii
#print axioms MetaLadder.metaColor_valid
#print axioms MetaLadder.colorable_four_fourLadder
#print axioms MetaLadder.not_colorable_three_fourLadder
#print axioms MetaLadder.chromaticNumber_fourLadder

/-! ## M26 — the hexagram (six pivots about the metapivot, every ladder, all unit chords)

The headline is `Hexagram.chromaticNumber_hexagram`. -/

#print axioms Hexagram.hexPivot_eq
#print axioms Hexagram.dist_hexPivot
#print axioms Hexagram.fourLadder_subset_hexagram
#print axioms Hexagram.rot6_hexPivot
#print axioms Hexagram.hex_master
#print axioms Hexagram.bridge_adj
#print axioms Hexagram.bridge_opp
#print axioms Hexagram.adj_oo_empty
#print axioms Hexagram.adj_oi_complete
#print axioms Hexagram.adj_io_complete
#print axioms Hexagram.adj_ii_complete
#print axioms Hexagram.adj_fusion_oo
#print axioms Hexagram.adj_fusion_oi
#print axioms Hexagram.adj_fusion_io
#print axioms Hexagram.adj_fusion_ii
#print axioms Hexagram.opp_oo_complete
#print axioms Hexagram.opp_oi_empty
#print axioms Hexagram.opp_io_empty
#print axioms Hexagram.opp_ii_empty
#print axioms Hexagram.opp_fusion_oo
#print axioms Hexagram.opp_fusion_oi
#print axioms Hexagram.opp_fusion_io
#print axioms Hexagram.opp_fusion_ii
#print axioms Hexagram.hexMeta_oo_complete
#print axioms Hexagram.hexMeta_oi_complete
#print axioms Hexagram.hexMeta_io_complete
#print axioms Hexagram.hexMeta_ii_complete
#print axioms Hexagram.hexMeta_fusion_oo
#print axioms Hexagram.hexMeta_fusion_oi
#print axioms Hexagram.hexMeta_fusion_io
#print axioms Hexagram.hexMeta_fusion_ii
#print axioms Hexagram.unit_oo_complete
#print axioms Hexagram.hexColTab_equivariant
#print axioms Hexagram.hexMetaColTab_equivariant
#print axioms Hexagram.hexColor_valid
#print axioms Hexagram.colorable_four_hexagram
#print axioms Hexagram.not_colorable_three_hexagram
#print axioms Hexagram.chromaticNumber_hexagram

/-! ## M30 — the field wall

The kernel-checked citation for the field-jump thesis: the Moser spindle's twist rotation is a
word in the seam group (`ρ·σ² = −1`, i.e. `ρ = ζ₆³σ⁻²`), so the classical 4-forcers are native
to ⟨ζ₆, σ⟩ while the 5-forcers need √5 and √7. -/

#print axioms FieldWall.normSq_moserTwist
#print axioms FieldWall.moserTwist_mul_seam_sq
#print axioms FieldWall.moserTwist_eq_zeta6_cube_mul_seam_inv_sq

/-! ## M32 — the quadrature kill (the 2-adic engine's first theorems)

The block-split arithmetic one field up: `sqrt5_indep` by mod-5 descent (one ZMod-5 kernel
decide + strong induction), the `sqrt15_split` workhorse, the flat eight-term independence,
the geometric quadrature law (M31's G12, ρ₁₅ instance), and the distance-2 pair's tangency
anchor. -/

#print axioms Quadrature.sqrt5_indep
#print axioms Quadrature.sqrt15_split
#print axioms Quadrature.sqrt_indep₈
#print axioms Quadrature.normSq_rho15
#print axioms Quadrature.quadrature_rho15
#print axioms Quadrature.pair_tangency

/-! ## M34 — Act One as kernel theorems

The pigeonhole bridge (class avoidance = colourability of the augmented graph), the
criticality factorization A1 (unconditional), and the two pigeonhole carriers: the
nine-point √3-pair core (two transmuter forcings composed, no search) and the 122-point
distance-2 core (an LRAT certificate on the augmented list, replayed by the kernel), each
with its plane-level corollary — no proper 4-colouring of the plane avoids monochromatic
pairs at distance √3, nor at distance 2. -/

#print axioms mono_pair_of_not_colorable_append
#print axioms not_colorable_iff_covers
#print axioms UDCert.pairsAt_sound
#print axioms core9_pigeonhole
#print axioms core9_plane
#print axioms core9_pairs_complete
#print axioms core9_colorable_three
#print axioms core9_colorable_four
#print axioms core122_unsat
#print axioms core122_pigeonhole
#print axioms core122_plane
#print axioms core122_pairs_complete
#print axioms core122_coordsIn_seamFree
#print axioms core122_colorable_four
-- FS-27 section 1: Theorem B delivered to certificates. The general layer, whose only
-- consumer today is core122_colorable_four above.
#print axioms Q4.eval_mem_seamField
#print axioms UDCert.point_mem_seamPlane
#print axioms UDCert.colorable_four_of_seamFree

-- M59: the finite-plane lift (Lift.lean) — colourings pull back along an injective image (χ(H) ≤ χ(G) when
-- H ≤ G.map f), the plane composite for a lifted (k+1)-forcer, the first-order obstruction (a stress with a
-- nonzero pairing refutes every lift x₀ + π • y in any ring with π² = 0), and its certificate consumer at ZMod (p²).
#print axioms HadwigerNelson.chromaticNumber_le_of_le_map
#print axioms HadwigerNelson.UDCert.add_one_le_chromaticNumber_plane_of_lift
#print axioms HadwigerNelson.stressPairing_eq_zero_of_lift
#print axioms HadwigerNelson.not_exists_lift_of_stressPairing_ne_zero
#print axioms HadwigerNelson.UDCert.stressPairing_eq_zero_of_drawing
-- the first instance (Instances/LiftObstruction131.lean): the 1581's merged image at 131 is not a shadow — a 48-edge
-- witness stress with pairing 7205 ≠ 0 in ZMod (131²); and the plane's clique number pinned at 11 and 19
#print axioms HadwigerNelson.merged131_no_lift
#print axioms HadwigerNelson.merged131_no_drawing
#print axioms HadwigerNelson.finitePlane11_triangle
#print axioms HadwigerNelson.finitePlane19_triangle_free
-- the second instance (Instances/LiftObstruction11.lean): the 5-critical core of UD(F_11,2) is not a shadow (a 12-edge witness, pairing 33)
#print axioms HadwigerNelson.core11_no_lift
-- the third instance (Instances/LiftObstruction19.lean): the 5-critical core of the triangle-free plane at 19 (138 vertices) is not a shadow (a 29-edge witness, pairing 342)
#print axioms HadwigerNelson.core19_no_lift

-- M61: local–global tightness (LocalGlobal.lean, Instances/LocalGlobal19.lean) — the periodic quotient (an
-- additive hom whose kernel misses the connection set is a Cayley hom; a table proper along the projected
-- circle colours the plane periodically: χ(UD(F_19,2)) ≤ 5 by a 19-entry table); the counting bound
-- card ≤ χ·α; no isotropic vectors mod p ≡ 3 (4); the spindle radicand √(4d−1) forces √−1 into any
-- residue field where d vanishes, so a pair forced equal at k colours, drawn in a ring holding its spindle
-- radicand, has no reduction to a k-forces-free plane (the mechanism of tightness); the 3-plane forces-free
-- by two tables; the rhombus at 3 as the model; the instance at 11.
#print axioms addCayleyMap
#print axioms unitQuadrance_colorable_of_quotient
#print axioms Forces.eq_of_forall_exists_not_periodic
#print axioms card_le_mul_of_colorable
#print axioms card_le_chromaticNumber_mul_indepNum
#print axioms sq_add_sq_eq_zero_iff
#print axioms quadrance_eq_zero_iff
#print axioms isSquare_neg_one_of_spindle_radicand
#print axioms no_ringHom_of_spindle_radicand
#print axioms Forces.no_hom_of_spindle_radicand
#print axioms Forces.isEmpty_ringHom_of_spindle_radicand
#print axioms finitePlane19_colorable_five
#print axioms chromaticNumber_finitePlane19_le_five
#print axioms indepNum_finitePlane19_ge
#print axioms finitePlane11_colorable_six_periodic
#print axioms finitePlane3_forces_iff
#print axioms rhombus_spindle_no_hom_3
#print axioms Forces.isEmpty_ringHom_of_spindle_radicand_11

-- M60: the five-colour residue obstruction (ResidueObstruction.lean, Instances/ResidueObstruction11.lean) —
-- compulsions map forward along homomorphisms; a Cayley graph coloured by one aperiodic table forces no pair
-- and by one table coinciding at non-edges separates only edges (arity floor ≥ 3); the quadrance of a drawn
-- difference is the residue of the stored squared distance; at 11: the sealing plane is pairwise free at
-- five colours (floor in {3,4,5}), and no √7-free certificate with 11 ∤ D separates a √3- or distance-2
-- pair or forces a distance-5 pair equal at five colours. The law also holds at a rational squared distance
-- s/t (only s ≢ 0 is needed), which answers Polymath16's 5/3 question for every such certificate.
#print axioms Forces.image
#print axioms forces_iff_eq_of_aperiodic
#print axioms separated_iff_adj_of_coincides
#print axioms three_le_arityFloor_of_aperiodic_coincides
#print axioms UDCert.drawing_quad
#print axioms UDCert.not_separated_of_distSq
#print axioms finitePlane11_forces_iff
#print axioms finitePlane11_separated_iff
#print axioms three_le_arityFloor_finitePlane11
#print axioms arityFloor_finitePlane11_le_five
#print axioms UDCert.not_separated_sqrt3_11
#print axioms UDCert.not_separated_two_11
#print axioms UDCert.not_forces_five_11
#print axioms UDCert.drawing_quad_of_distSq_ratio
#print axioms UDCert.not_forces_of_distSq_ratio
#print axioms UDCert.not_separated_of_distSq_ratio
#print axioms UDCert.pairsAtRatio_sound
#print axioms UDCert.not_forces_of_pairsAtRatio_11
#print axioms UDCert.not_separated_of_pairsAtRatio_11
#print axioms UDCert.not_forces_five_thirds_11
#print axioms UDCert.not_separated_five_thirds_11
#print axioms heule510_pairsAtRatio_five_thirds

-- M35: the clique face of the bridge and the hexagonal-shell pigeonhole
#print axioms mono_pair_of_clique
#print axioms hexShell_pigeonhole
#print axioms hexShell_plane5
#print axioms hexShell_plane6
#print axioms hexShell_p3_complete
#print axioms hexShell_p4_complete

-- M35: the brick certificate machinery and the first certified upper bound
#print axioms Brick.sound
#print axioms Brick.colorable
#print axioms Brick.avoids
#print axioms Brick.colorQ_eq
#print axioms plane_colorable_nine
#print axioms nine_avoids_sqrt_three_halves

-- FS-24 G4 + G7b (2026-09-09) — statements moved to the level their proofs occupy. Kept as ONE
-- block rather than filed next to each milestone's section, because this pass touches three
-- milestones' surfaces at once and a single contiguous region is what makes the receipt readable.
-- Every name the record cited before this pass still appears above with its old statement; these
-- are the additions.
-- The pigeonhole over an arbitrary set of forbidden distances, and the discharge map that makes
-- the one-gadget forms instances of the two-gadget one rather than copies of its argument:
#print axioms coloring_ne_of_dist_mem
#print axioms hexShell_planeIn
#print axioms hexShell_plane
-- The single conditional theorem, and the two shapes with one distance already an edge:
#print axioms not_colorable_distanceGraph_of_forced_pairs
#print axioms not_colorable_distanceGraph_of_forced_sqrt3
#print axioms not_colorable_distanceGraph_of_forced_two
-- The plane, colour-generic — and the k = 6 reading, which is chi(R^2) >= 7 conditional on two
-- six-colour gadgets, a sentence this repository could not previously write:
#print axioms not_colorable_of_forced_pairs
#print axioms add_one_le_chromaticNumber_plane_of_forced_pairs
#print axioms not_colorable_six_of_forced_pairs
#print axioms seven_le_chromaticNumber_plane_of_forced_pairs
-- The two-distance dial's target: chi(R^2; {1,2}) >= 6 from a single sqrt3 gadget.
#print axioms six_le_chromaticNumber_oneTwo_of_forced_sqrt3
-- G7b: a brick certificate colours a distance graph, and the nine-colour avoider as one theorem.
#print axioms Brick.colorable_distanceGraph
#print axioms Brick.chromaticNumber_distanceGraph_le
#print axioms Brick.colorable_avoiding
#print axioms plane_colorable_nine_avoiding_sqrt_three_halves
#print axioms chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine

-- M36: the boundary-tight sharpening and the classical upper bound
#print axioms Brick.check_pos
#print axioms Brick.sq_lt_of_abs_lt
#print axioms Brick.lt_sq_of_abs_lt
#print axioms Brick.le_sq_of_abs_lt
#print axioms plane_colorable_seven
#print axioms chromaticNumber_plane_le_seven
#print axioms chromaticNumber_plane_interval

-- M37: the coset bound
#print axioms Coset.seven_le_hexQi
#print axioms Coset.shell_rainbow
#print axioms Coset.seven_values
#print axioms Coset.seven_le_card
#print axioms Coset.exists_proper_coset_colouring
#print axioms Coset.coset_chromatic_eq_seven
-- M38: the coarse-cell bound, with no homomorphism hypothesis
#print axioms Coset.exists_unit_pair
#print axioms Coset.seven_labels_of_cell_constant
#print axioms Coset.seven_le_card_of_cell_constant
#print axioms Coset.cell_chromatic_eq_seven
#print axioms Coset.eight_le_card_of_cell_constant
#print axioms Coset.seven_le_card_fine
-- M42: the gap atlas, kernel side — the windows, the coset impossibility, the 23-core
#print axioms Coset.seven_le_card_shell4
#print axioms Coset.twelve_le_card_of_cell_constant
#print axioms Coset.exists_kernel_vector
#print axioms Coset.no_coset_seven_on_gap
#print axioms core23_unsat
#print axioms core23_not_colorable_six
#print axioms core23_colorable_seven
#print axioms Coset.seven_le_card_gap

/-! ## B1 — Theorem B in the kernel: `χ(ℚ(√3, √11)²) = 4`

The residue colouring of the plane over the seam field, the theorem that halted the M53 descent.
The headline, its subset form, the exact chromatic number, the two spare-colour consequences, and
the pieces a reader checks the model against: the colouring's properness, its distance-2
degeneracy, `den`'s injectivity, the descent, and the spindle's eleven unit distances. -/

#print axioms four_colorable_of_seam_field
#print axioms colorable_four_of_subset_seamPlane
#print axioms chromaticNumber_seamPlane
#print axioms four_le_chromaticNumber_seamPlane
#print axioms not_forces_five_of_subset_seamPlane
#print axioms not_separated_five_of_subset_seamPlane
#print axioms FieldWall4.residueColouring_ne_of_dist_one
#print axioms FieldWall4.residueColouring_eq_of_dist_two
#print axioms FieldWall4.den_injective
#print axioms FieldWall4.exists_mul_onePlusI
#print axioms FieldWall4.mem_oddDenom_of_unit
#print axioms FieldWall4.psi_comp_conj
#print axioms FieldWall4.spindleOrd_norm
#print axioms FieldWall4.spindlePt_dist
#print axioms FieldWall4.den_rho9

/-! ## Palette independence (2026-09-09) — `Palette.lean`

`Forces` and `Separated` quantify over `Fin k`; a caller who builds a colouring valued in a group or
a residue field needs them to speak about that palette too, and these say they do. -/

#print axioms Forces.eq_of_equiv
#print axioms Forces.eq_of_card
#print axioms Forces.of_equiv
#print axioms not_forces_of_coloring_ne
#print axioms Separated.ne_of_equiv
#print axioms Separated.ne_of_card
#print axioms Separated.of_equiv
#print axioms not_separated_of_coloring_eq

/-! ## A — Theorem A in the kernel: the residue colouring in general

The argument of B1 with the field removed. `colorable_of_residue` is the whole theorem — a graph
drawn in an abelian group whose edge differences lie in a subgroup and are nonzero under a
homomorphism out of it. Then the two arithmetic layers (a norm-one element of a σ-stable subring is
a unit of it, so its residue is nonzero; a σ-stable valuation subring contains every norm-one
element), the ring and valuation forms, and the plane forms — of which `FieldWall4`'s headline is
now an instance. `colorable_unitQuadrance_of_residue` is the same theorem over the coordinate group
of an arbitrary commutative ring, which is what makes "this does not need `ℂ`" checkable. -/

#print axioms cosetResidue_apply_of_mem
#print axioms cosetResidue_sub
#print axioms cosetResidue_eq_iff
#print axioms colorable_of_residue
#print axioms isUnit_of_mem_normOne
#print axioms map_ne_zero_of_mem_normOne
#print axioms normOne_subset
#print axioms normOne_subset_valuationSubring
#print axioms colorable_of_normOne
#print axioms conj_mem_valuationSubringAtPrime
#print axioms colorable_of_valuationSubring
#print axioms sub_mem_normOne_conj_iff
#print axioms colorable_unitDistance_of_residue
#print axioms colorable_unitDistance_induce_of_residue
#print axioms conjOn_conjOn
#print axioms colorable_unitDistance_induce_of_valuationSubring
#print axioms colorable_unitQuadrance_of_residue
#print axioms normOneColoring
#print axioms cosetResidue_eq_iff_map
#print axioms cosetResidue_ne_of_mem_normOne
#print axioms map_mul_eq_zero_iff_of_isUnit
#print axioms map_mul_normOne_eq_zero_iff
#print axioms map_mul_conj_eq_zero_iff
#print axioms not_forces_of_map_ne_zero
#print axioms not_separated_of_map_eq_zero
#print axioms div_mem_normOne
#print axioms map_eq_zero_iff_of_mul_conj_eq
#print axioms FieldWall4.conj_mem_oddDenom
#print axioms FieldWall4.psiA_eq

/-! ## The mascot obstruction (2026-09-09) — the recipe's threshold, sharp in both directions -/

#print axioms card_le_of_forces
#print axioms colorable_of_not_adj
#print axioms isNClique_of_forces_of_card
#print axioms isNClique_image
#print axioms not_forces_of_drawing
#print axioms no_four_unit_points
#print axioms no_isNClique_four
#print axioms no_isNClique_of_four_le
#print axioms not_forces_of_unit_drawing
#print axioms not_forces_five_points
#print axioms rhombusDraw_injective
#print axioms rhombusDraw_unit
#print axioms exists_forces_of_unit_drawing_three

/-! ## The 2-adic law of four-colour compulsions (2026-09-09) — `ValuationLaw.lean`

Which distances can carry a compulsion at four colours over `K = ℚ(√3, √11)`, and the correction
that comes with it: at four colours the *plane*-level form of such a statement is vacuous. -/

#print axioms FieldWall4.oddDenom_subset_seamPlane
#print axioms FieldWall4.seamPlane_realMul
#print axioms FieldWall4.sub_mem_oddDenom_of_dist
#print axioms FieldWall4.residueColouring_eq_iff_sub
#print axioms FieldWall4.residueColouring_eq_iff_psiA_zero
#print axioms FieldWall4.psiA_conj
#print axioms FieldWall4.normSq_mem_oddDenom
#print axioms FieldWall4.psiA_eq_zero_iff_normSq
#print axioms FieldWall4.residueColouring_eq_iff_normSq
#print axioms FieldWall4.not_forces_of_sub
#print axioms FieldWall4.not_separated_of_sub
#print axioms FieldWall4.psiA_onePlusI
#print axioms FieldWall4.psiA_ker_stable
#print axioms FieldWall4.sub_mem_oddDenom_of_adj
#print axioms FieldWall4.sub_mem_normOne_of_adj
#print axioms FieldWall4.seamResidueColouring
#print axioms FieldWall4.seamColouring
#print axioms FieldWall4.residueColouring_eq_of_forces
#print axioms FieldWall4.residueColouring_ne_of_separated
#print axioms FieldWall4.not_forces_of_residue_ne_zero
#print axioms FieldWall4.not_separated_of_residue_eq_zero
#print axioms FieldWall4.den_ordSqrt3
#print axioms FieldWall4.den_ordSqrt33
#print axioms FieldWall4.not_forces_dist_sqrt_three
#print axioms FieldWall4.not_separated_dist_two
#print axioms FieldWall4.not_separated_dist_eight_thirds
#print axioms FieldWall4.not_separated_dist_eight_over_sqrt_three
#print axioms FieldWall4.not_forces_dist_three
#print axioms FieldWall4.not_forces_dist_seven_thirds
#print axioms FieldWall4.not_forces_dist_five_thirds
#print axioms FieldWall4.not_forces_dist_one_third
#print axioms FieldWall4.not_forces_dist_sqrt_eleven_thirds
#print axioms isEmpty_coloring_plane_four
#print axioms vacuous_of_plane_four_coloring

/-! ## P4 (FS-24 G3 + FS-25 E1) — the spindle theorems off `ZMod`, and the planes' forced-pair-freedom

`LocalGlobal.lean` §Spindle now has a field-level form of every theorem that was stated at `ZMod p`
under `p % 4 = 3` (the old names are kept and are audited above, unchanged), and
`PlaneRotation.lean` proves that a finite Euclidean plane at any prime `≡ 3 (mod 4)` has no forced
pair at any colour count it admits — replacing the four measured instances of ledger row 55, which
`Instances/PlaneFreedom.lean` re-derives. -/

#print axioms sq_add_sq_eq_zero_iff_of_not_isSquare_neg_one
#print axioms quadrance_eq_zero_iff_of_not_isSquare_neg_one
#print axioms no_ringHom_of_spindle_radicand_of_not_isSquare_neg_one
#print axioms Forces.no_hom_of_spindle_radicand_of_not_isSquare_neg_one
#print axioms Forces.isEmpty_ringHom_of_spindle_radicand_of_not_isSquare_neg_one

#print axioms quadrance_rotMap
#print axioms exists_smul_quarterTurn_eq
#print axioms periodic_zmod_smul
#print axioms not_periodic_quarterTurn
#print axioms finitePlane_forces_iff
#print axioms finitePlane_forces_eq
#print axioms Forces.no_hom_of_spindle_radicand_of_colorable
#print axioms Forces.isEmpty_ringHom_of_spindle_radicand_of_colorable

#print axioms finitePlane3_colorable_three
#print axioms finitePlane3_not_colorable_two
#print axioms finitePlane7_colorable_four
#print axioms finitePlane3_forces_eq
#print axioms finitePlane7_forces_eq
#print axioms finitePlane11_forces_eq
#print axioms finitePlane19_forces_eq

/-! ## FS-36 — two colours from inertia, and the 2-adic splitting of multiquadratic fields

`TwoColourResidue`: Theorem A's two-colour case in its ring, valuation and plane forms, the colouring as data, and
the Gaussian-integer model. `SquareClass`: the plane over a real subfield, square classes and their 2-adic images,
the Galois connection between class groups and real fields, the splitting, the field-level decomposition, and de
Grey's field worked. -/

#print axioms exists_addMonoidHom_zmod_two_apply_one_ne_zero
#print axioms map_mul_self_eq_one_of_mem_normOne_of_conj_eq
#print axioms map_eq_one_of_mem_normOne_of_conj_eq
#print axioms normOneColoringTwo
#print axioms colorable_two_of_normOne_of_conj_eq
#print axioms colorable_two_of_valuationSubring_of_conj_eq
#print axioms colorable_two_unitDistance_induce_of_valuationSubring
#print axioms colorable_two_cycleGraph_four_of_gaussResidue

#print axioms four_le_chromaticNumber_planeOver
#print axioms SquareClass.inf_comap_sup_inf_comap_eq
#print axioms SquareClass.isSquare_of_sqClass_eq_zero
#print axioms SquareClass.exists_sqClass_eq
#print axioms SquareClass.le_inf_spanThreeTwo_sup_inf_spanThreeTen
#print axioms SquareClass.inf_comap_spanThreeTwo_sup_inf_comap_spanThreeTen
#print axioms SquareClass.minusOne_not_mem_map_inf_comap
#print axioms SquareClass.map_twoAdic_classesOfRadicands_le_iff
#print axioms SquareClass.sqrt_mem_iff_of_sqClass_eq
#print axioms SquareClass.sqrt_mem_of_mul_eq_sq_mul
#print axioms SquareClass.gc_fieldOfClasses_classesOfField
#print axioms SquareClass.fieldOfRadicands_eq_fieldOfClasses
#print axioms SquareClass.fieldOfClasses_eq_sup
#print axioms SquareClass.seamField_le_fieldOfClasses_inf_comap
#print axioms SquareClass.fieldOfClasses_inf_comap_le_fieldOfRadicands
#print axioms SquareClass.fieldOfRadicands_le_sup
#print axioms SquareClass.four_le_chromaticNumber_planeOver_fieldOfClasses_inf_comap
#print axioms SquareClass.multiquadratic_decomposition
#print axioms SquareClass.fieldOfRadicands_deGrey_le_sup
#print axioms SquareClass.map_twoAdic_deGreyTwo_le
#print axioms SquareClass.map_twoAdic_deGreyTen_le

#print axioms Q4.eval_mem_of_mem_sevenFree
#print axioms UDCert.point_mem_planeOver_of_sevenFree
#print axioms UDCert.chromaticNumber_le_planeOver_of_sevenFree
#print axioms map_twoAdic_fourteen_le
#print axioms map_twoAdic_seventy_le
#print axioms sqrt_five_mem_fourteen_sup_seventy
#print axioms five_le_chromaticNumber_planeOver_fourteen_sup_seventy

/-! ## FS-38 — the fan gap: a free colour at the image kills every pair compulsion through it

`FanGap.lean`: the gap, slackness, the shared gap and fusability; the repaint over an independent set and its three
uses (the pair theorem, the arity-`k` fan filter, the double repaint); both hereditary properties and their hom forms;
the Cayley transports; the base-edge transport and the ring-hom corollaries for every commutative ring; the general
arity-3 floor; and the three controls that refute the weakened statements. `Instances/FanGap11.lean`: the two tables'
`decide`s, `Slack` and `PairwiseFusable` at `11`, both `iff`s for every graph mapping into the plane, the tower
`ZMod (11 ^ m)`, the completions `ℤ_[11]` and `Adjoin 11 ℤ_[11]`, the certificate forms and Heule-510.
`Instances/FanGap19.lean`: the derived properness of the kernel's own 19-colouring, its gap, `Slack` and the
forces half at `19` (no virtual-edge half — FS-38 §S8 decision 10). -/

#print axioms FanGap.comap
#print axioms exists_fanGap_iff_not_coverAtLeast
#print axioms pullbackRepaint
#print axioms pullbackRepaint_apply_of_mem
#print axioms pullbackRepaint_apply_of_not_mem
#print axioms repaintAt
#print axioms repaintAt_apply_self
#print axioms repaintAt_apply_of_ne
#print axioms not_forces_of_fanGap
#print axioms not_fan_of_fanGap
#print axioms not_separated_of_sharedGap
#print axioms not_separated_of_fusable
#print axioms Fan.image
#print axioms Slack.of_hom
#print axioms Slack.forces_eq
#print axioms Slack.forces_iff
#print axioms Slack.forces_eq_of_hom
#print axioms Slack.forces_iff_of_hom
#print axioms Fusable.of_hom
#print axioms fusable_of_not_separated
#print axioms PairwiseFusable.of_hom
#print axioms PairwiseFusable.separated_iff_adj
#print axioms PairwiseFusable.separated_iff_adj_of_hom
#print axioms three_le_arityFloor_of_forces_eq_of_separated_adj
#print axioms FanGap.translate
#print axioms slack_addCayley_of_fanGap
#print axioms fusable_of_hom_to_base
#print axioms Slack.unitQuadrance_of_ringHom
#print axioms PairwiseFusable.unitQuadrance_of_ringHom
#print axioms unitQuadrance_forces_eq_of_ringHom
#print axioms unitQuadrance_exists_hom_to_base
#print axioms unitQuadrance_fusable_of_sharedGap_base
#print axioms UDCert.forces_eq_of_slack
#print axioms UDCert.separated_iff_adj_of_fusable

-- The controls: each derives `False` from a weakened statement, so a hypothesis the plan calls
-- load-bearing is certified to be load-bearing rather than merely used.
#print axioms not_forces_of_fanGap_needs_ne
#print axioms fanGap_needs_ne_own_colour
#print axioms not_separated_of_sharedGap_needs_nonadjacent

#print axioms finitePlane11_fanGap
#print axioms finitePlane11_not_fanGap_zero
#print axioms finitePlane11_slack
#print axioms finitePlane11_doubleGap_proper
#print axioms finitePlane11DoubleGapColoring
#print axioms finitePlane11_sharedGap
#print axioms finitePlane11_sharedGap_corrupt_refused
#print axioms finitePlane11_pairwiseFusable
#print axioms forces_eq_of_hom_finitePlane11
#print axioms forces_iff_of_hom_finitePlane11
#print axioms separated_iff_adj_of_hom_finitePlane11
#print axioms zmodPow11_forces_eq
#print axioms padicInt11_forces_eq
#print axioms padicInt11_separated_iff_adj
#print axioms adjoin11PadicRes
#print axioms adjoin11_padicInt11_forces_eq
#print axioms UDCert.forces_eq_11
#print axioms UDCert.separated_iff_adj_11
#print axioms heule510_forces_eq
#print axioms heule510_forces_iff
#print axioms heule510_separated_iff_adj
#print axioms three_le_arityFloor_heule510
#print axioms heule510_residue_zero_eq_475

#print axioms finitePlane19QuotColouring_proper
#print axioms finitePlane19QuotColoring
#print axioms finitePlane19_fanGap
#print axioms finitePlane19_not_fanGap_zero
#print axioms finitePlane19_slack
#print axioms forces_eq_of_hom_finitePlane19
#print axioms zmodPow19_forces_eq
#print axioms padicInt19_forces_eq

/-! ### FS-38 phase K3 — the 2-adic tower, levels four and five

`TwoAdicTower.lean`: the ring-free level, the two Eisenstein forms and their invariances, the circle counts,
multiplication by `ω` and the level maps as graph homomorphisms, and level one as a gapless `K₄`.
`Instances/TwoAdicFour.lean`: the five tables' properness through the circle literal, the cover, and pairwise
freeness. `Instances/TwoAdicFive.lean`: the certificate's indexing checked against the graph, the pinned triangle
checked against the edge list, the LRAT-backed refusal, and the forcing law. The clause table and its segment
(`twoAdicFive_agrees`, `twoAdicFive_unsat`) are the pipeline's two kernel-decided `Bool`s; nothing here is native. -/

#print axioms twoAdicCircle_four_card
#print axioms twoAdicCircle_five_card
#print axioms castDown_dbl
#print axioms two_pow_succ_eq_zero
#print axioms normForm_twoAdicOmega
#print axioms normForm_twoAdicConj
#print axioms normForm_twoAdicLevelMap
#print axioms twoAdicLevelMap_ne_zero_of_mem_circle
#print axioms twoAdicOmegaHom
#print axioms twoAdicLevelHom
#print axioms twoAdicPlane_one_no_fanGap
#print axioms no_hom_twoAdicPlane_one_to_zero

#print axioms mem_twoAdicCircleFour_iff
#print axioms proper_of_shift_ne
#print axioms twoAdicFourTables_proper
#print axioms twoAdicFourTables_cover
#print axioms twoAdicFour_forces_iff

#print axioms twoAdicFiveColouring
#print axioms twoAdicFiveDelta_mem_ker
#print axioms twoAdicFive_ker_eq
#print axioms twoAdicFiveEdges_adj
#print axioms twoAdicFiveHom
#print axioms twoAdicFive_agrees
#print axioms twoAdicFive_unsat
#print axioms twoAdicFiveEdgeGraph_not_colorable
#print axioms twoAdicFive_not_colorable_with_edge
#print axioms twoAdicFive_forces_delta
#print axioms twoAdicFive_forces_of_ker
#print axioms twoAdicFive_not_forces_of_ne
#print axioms twoAdicFive_forces_iff
#print axioms twoAdicFive_forces_iff'
#print axioms twoAdicFive_not_slack
#print axioms twoAdicFour_not_slack

/-! ## FS-50 phase D' — the consumer of a certified independence-number bound

`add_one_le_chromaticNumber_of_indepNum_le` turns "no independent set exceeds `a` points" into
"more than `k` colours are needed" whenever `k * a` is short of the vertex count. Its three
instances name the finite Euclidean planes FS-50 measures; only the one at `11` has its hypothesis
held, and by an exact rational certificate checked OUTSIDE the kernel
(`data/fs50/cert-p11-N29.json`, `plans/FS50-certificate-soundness.md`), so nothing here buys any
trust that these lines do not show. -/

#print axioms add_one_le_chromaticNumber_of_indepNum_le
-- FS-53 K2: its lemma API — a colouring and an independence bound meeting in one statement.
#print axioms chromaticNumber_eq_succ_of_colorable_of_indepNum_le
#print axioms seven_le_chromaticNumber_finitePlane83_of_indepNum_le
#print axioms six_le_chromaticNumber_finitePlane23_of_indepNum_le
#print axioms five_le_chromaticNumber_finitePlane11_of_indepNum_le
#print axioms six_mul_lt_card_finitePlane83
#print axioms five_mul_lt_card_finitePlane23
#print axioms four_mul_lt_card_finitePlane11

/-! ## FS-53 phase K1 — the packed Cayley colouring certificate

An upper bound on a finite Euclidean plane's chromatic number as one `Bool` the kernel evaluates.
`Cert.sound` is the whole trust surface: it turns a passing `check` into a `Colorable`, once,
generically over an identifier arithmetic `IdArith R`, so the plane a certificate speaks about is
the one its arithmetic names and never another. `colorable_finitePlane23_eight` is the first
kernel-checked upper bound at a member of FS-53's eight-member window, and it is `decide +kernel`
throughout — no native evaluation is bought anywhere in this module, which is the point of the
packing. `colorable_finitePlane3` is the same pipeline on a plane small enough to read by hand. -/

#print axioms CayleyCert.Cert.sound
#print axioms CayleyCert.Cert.covers_iff
#print axioms CayleyCert.IdArith.nverts_eq_card
#print axioms CayleyCert.IdArith.zmod
#print axioms CayleyCert.toId_lt
#print axioms CayleyCert.ofId_toId
#print axioms CayleyCert.toId_ofId
#print axioms CayleyCert.toId_add
#print axioms CayleyCert.mem_unitCircle_iff
#print axioms CayleyCert.colorable_finitePlane3
#print axioms CayleyCert.colorable_finitePlane23_eight

/-! ## FS-58 phase D — the 3-adic barrier

For `d ≡ 2 (mod 3)` the plane over `ℚ(√d)`, held as `Adjoin d ℚ × Adjoin d ℚ`, restricted to its 3-integral
directions, is 3-colourable: Theorem A with the linear rule `a + b + c mod 3`, nonzero on every 3-integral unit
vector because the eight-point circle of `𝔽₉²` misses its kernel. The finite facts are `decide` and
`decide +kernel`; no native evaluation is bought. `kappa_vanishingVectorThree` is the adversary showing the
congruence is used, `integralDirectionPlane_adj_diamond167` the inhabitant showing the graph has edges. -/

#print axioms ThreeAdicBarrier.toZModThree_apply
#print axioms ThreeAdicBarrier.kappa_apply
#print axioms ThreeAdicBarrier.circle_kappa_ne_zero
#print axioms ThreeAdicBarrier.unit_reduce
#print axioms ThreeAdicBarrier.kappa_ne_zero
#print axioms ThreeAdicBarrier.vanishingVectorThree_mem
#print axioms ThreeAdicBarrier.vanishingVectorThree_unit
#print axioms ThreeAdicBarrier.kappa_vanishingVectorThree
#print axioms ThreeAdicBarrier.colorable_three_integralDirectionPlane
#print axioms ThreeAdicBarrier.integralDirectionPlane_adj_diamond167

/-! ## FS-58 phase D2 — the plane over `ℚ(√11)` needs four colours

A 204-point unit-distance graph in `ℚ(√11)²` with no proper 3-colouring (`data/fs58/witness-11/`), through the
existing certificate pipeline: the geometry by `decide +kernel` over `Q4` at scale 150, the coordinates in `ℤ[√11]`
by `decide +kernel`, and the CaDiCaL refutation replayed by the mask checker. No native evaluation is bought.
`eleven204_colorable_four` is the control that the graph is not refuted at every colour count. -/

#print axioms eleven204_valid
#print axioms eleven204_agrees
#print axioms eleven204_unsat
#print axioms Q4.eval_mem_of_mem_elevenOnly
#print axioms UDCert.point_mem_planeOver
#print axioms UDCert.chromaticNumber_le_planeOver
#print axioms eleven204_coordsIn_elevenOnly
#print axioms eleven204_not_colorable_three
#print axioms eleven204_colour_proper
#print axioms eleven204_colorable_four
#print axioms four_le_chromaticNumber_eleven204
#print axioms sqrt_eleven_mem_fieldOfRadicands_eleven
#print axioms four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem
#print axioms four_le_chromaticNumber_planeOver_eleven

/-! ## FS-66 — the residue tower at level two

`χ(UD(ℤ/121, 2)) = 5`: at the prime 11 the residue ceiling does not drop from level one to level two.
The lower half replays an LRAT refutation of an 883-point subgraph through the M05 pipeline, so the
solver's word is nowhere in the axiom list; the upper half is level one's verified colouring pulled
back along `ZMod.castHom` and buys nothing at all. **No native evaluation.** -/

#print axioms ZMod.natCast_add_self_sub_mod
#print axioms unitQuadrance_colorable_of_ringHom
#print axioms chromaticNumber_unitQuadrance_zmod_le_of_dvd
#print axioms unitQuadrance_adj_iff_quadrance
#print axioms unitPairNat_eq_true_iff
#print axioms zmod121FourEdges_all_ok
#print axioms zmod121FourEdges_adj
#print axioms zmod121Four_agrees
#print axioms zmod121Four_unsat
#print axioms zmod121FourEdgeGraph_not_colorable
#print axioms unitQuadrance_zmod121_not_colorable_four
#print axioms unitQuadrance_zmod121_colorable_five
#print axioms chromaticNumber_unitQuadrance_zmod121
#print axioms chromaticNumber_unitQuadrance_zmod121_eq_finitePlane11

/-! ## FS-73 phase P5 — Kempe swaps, the voltage certificate, compactness, and the normal form `P ≤ F`

`Kempe.lean`: the Kempe swap and its properness; the escape certificate `VoltageEscape` (FS-70 T10) with its lift's
Kempe closure, its monotonicity in `V`, and the named inhabitant `voltageEscapeZ`; the fan-gap closure (T6); the
additive Kempe screen (T2); compactness R1 by `Finset.rado_selection`; the forced group `F` and the H1 group `P` as
infima of period groups, with their membership bridges; residual finiteness of finitely generated abelian groups in
the form R3 consumes (through a character into `ℚ/ℤ`); and R3's escape direction. `InheritanceQuestion` is a
`Prop`, stated and not claimed. **No native evaluation.** -/

#print axioms kempeClosed_empty
#print axioms kempeClosed_twoColour
#print axioms kempeSwap
#print axioms kempeSwap_apply_of_mem
#print axioms kempeSwap_apply_of_notMem
#print axioms kempeSwap_ne_of_mem_of_notMem
#print axioms not_forces_of_kempeClosed
#print axioms exists_coloring_ne_of_forall_finset
#print axioms forces_iff_exists_finite
#print axioms VoltageEscape.zero_mem_lift
#print axioms VoltageEscape.enlarge
#print axioms VoltageEscape.add_mem_lift_iff
#print axioms VoltageEscape.kempeClosed
#print axioms not_forces_of_voltageEscape
#print axioms forces_iff_of_quotient_fanGap
#print axioms not_forces_of_additiveKempe
#print axioms periods
#print axioms mem_periods
#print axioms mem_forcedSubgroup
#print axioms periods_le_periods_comap_translate
#print axioms mem_periodicForcedSubgroup
#print axioms ker_le_periods_comap
#print axioms isPeriodic_comap
#print axioms periodic_kempeSwap
#print axioms exists_finiteIndex_between_notMem
#print axioms notMem_periodicForcedSubgroup_of_ne
#print axioms forcedSubgroup_le_periodicForcedSubgroup
#print axioms notMem_periodicForcedSubgroup_of_voltageEscape
#print axioms inheritanceQuestion_iff
#print axioms voltageEscapeZ

/-! ## FS-45 — the chain theorem (J14)

A forced pair chained along unit vectors summing to `1/δ` refuses its colour count; its first instance, `χ(ℚ(√2,√3)²) ≥ 4`
with no Moser spindle; the 18-vertex object by the gadget algebra; and `χ(K(√7)²) ≥ 5` conditional on `G4`. No solver,
no native evaluation. -/

#print axioms HadwigerNelson.Chain.not_colorable_chain
#print axioms HadwigerNelson.Chain.add_one_le_chromaticNumber_induce_of_chain
#print axioms HadwigerNelson.Chain.add_one_le_chromaticNumber_unitDistance_of_chain
#print axioms HadwigerNelson.Chain.add_one_le_chromaticNumber_planeOver_of_chain
#print axioms HadwigerNelson.Chain.spindle_of_chain
#print axioms HadwigerNelson.Chain.norm_eq_one_of_sq
#print axioms HadwigerNelson.Chain.rhombus_unit_of
#print axioms HadwigerNelson.SqrtTwoThree.sixUnits_sum
#print axioms HadwigerNelson.SqrtTwoThree.sum_sixUnits
#print axioms HadwigerNelson.SqrtTwoThree.delta_mul_one_add_omegaBar
#print axioms HadwigerNelson.SqrtTwoThree.one_add_v_add_conj
#print axioms HadwigerNelson.SqrtTwoThree.four_le_chromaticNumber_planeOver_two_three
#print axioms HadwigerNelson.SqrtTwoThree.eighteen_not_colorable_three
#print axioms HadwigerNelson.SqrtTwoThree.eighteen_colorable_four
#print axioms HadwigerNelson.SevenConditional.sum_eightUnits
#print axioms HadwigerNelson.SevenConditional.five_le_chromaticNumber_planeOver_seven_of_G4

/-! ## FS-39 route C — transcendence is free (J15)

`χ(F(t)²) = χ(F²)` for every field in which `−1` is not a square, for every formally real field, and over `ℝ` for `t`
transcendental over `F`, by the place `t = 0` and one valuation lemma. No solver, no native evaluation. -/

#print axioms HadwigerNelson.RouteC.planeOverIso
#print axioms HadwigerNelson.RouteC.chromaticNumber_eq_of_iso
#print axioms HadwigerNelson.RouteC.chromaticNumber_planeOver_eq
#print axioms HadwigerNelson.RouteC.unitQuadrance_colorable_of_subring
#print axioms HadwigerNelson.RouteC.mem_valuationSubring_of_sq_add_sq_eq_one
#print axioms HadwigerNelson.RouteC.one_add_sq_ne_zero
#print axioms HadwigerNelson.RouteC.unitQuadrance_colorable_of_valuationSubring
#print axioms HadwigerNelson.RouteC.evalZero_eq_zero_of_mem_maximalIdeal
#print axioms HadwigerNelson.RouteC.inv_mem_zeroIntegral_of_not_mem
#print axioms HadwigerNelson.RouteC.chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero
#print axioms HadwigerNelson.RouteC.chromaticNumber_unitQuadrance_ratFunc
#print axioms HadwigerNelson.RouteC.chromaticNumber_unitQuadrance_ratFunc_rat
#print axioms HadwigerNelson.RouteC.chromaticNumber_unitQuadrance_eq_of_ringEquiv
#print axioms HadwigerNelson.RouteC.one_add_sq_ne_zero_of_subfield
#print axioms HadwigerNelson.RouteC.le_adjoinTranscendental
#print axioms HadwigerNelson.RouteC.mem_adjoinTranscendental_self
#print axioms HadwigerNelson.RouteC.chromaticNumber_planeOver_adjoin_transcendental_eq
#print axioms HadwigerNelson.RouteC.transcendental_liouvilleNumber_bot
#print axioms HadwigerNelson.RouteC.chromaticNumber_planeOver_liouville

/-! ## FS-47 — prime inversion, valuation form (J16)

`1/n ∈ ℤ[U]` iff no conjugation-stable valuation subring has `n` in its maximal ideal (Chevalley's domination and row 57's
integrality); the plane's unit-vector ring and its sums of unit vectors; the chain theorem in ring form; the 2-adic wall broken
over `K(√7)`. The number-field reading (stable valuation subrings = stable primes) is row 57's gap. No solver, no native
evaluation. -/

#print axioms HadwigerNelson.UnitRing.normOne_subset_iff_stable
#print axioms HadwigerNelson.UnitRing.inv_mem_iff_forall_valuationSubring
#print axioms HadwigerNelson.UnitRing.inv_natCast_mem_unitRing_iff
#print axioms HadwigerNelson.UnitRing.inv_natCast_mem_unitRing_iff_not_mem_nonunits
#print axioms HadwigerNelson.UnitRing.inv_two_mem_unitRing_iff
#print axioms HadwigerNelson.UnitRing.coe_mem_unitRingOver_iff
#print axioms HadwigerNelson.UnitRing.inv_natCast_mem_unitRingOver_iff
#print axioms HadwigerNelson.UnitRing.exists_sum_eq_of_mem_unitRingOver
#print axioms HadwigerNelson.UnitRing.add_one_le_chromaticNumber_planeOver_of_inv_mem_unitRingOver
#print axioms HadwigerNelson.UnitRing.inv_five_mem_unitRing_conj
#print axioms HadwigerNelson.SevenUnitRing.inv_two_mem_unitRingOver_seven
#print axioms HadwigerNelson.SevenUnitRing.three_div_eight_mem_unitRingOver_seven
#print axioms HadwigerNelson.SevenUnitRing.wall_broken_seven

/-! ## FS-87 target 1 — the stripe lemma (J16)

Every proper four-colouring of the triangular lattice with no monochromatic √3-triangle is striped (FS85-V2-T5,
`[Parts2020hv]` §3): the wheel facts by a complete kernel check of one wheel's `4⁷` colourings, propagation along a line, line
to line, and the rotation by `ζ₆`. The class-mod-2 colouring inhabits the hypotheses; a proper three-colouring shows NT₀ cannot
be dropped. No solver, no native evaluation. -/

#print axioms HadwigerNelson.Stripe.wheel_all
#print axioms HadwigerNelson.Stripe.wheelFacts
#print axioms HadwigerNelson.Stripe.wheel
#print axioms HadwigerNelson.Stripe.typeP_line
#print axioms HadwigerNelson.Stripe.striped_of_line
#print axioms HadwigerNelson.Stripe.rot_rim
#print axioms HadwigerNelson.Stripe.proper_comp_rot
#print axioms HadwigerNelson.Stripe.nt0_comp_rot
#print axioms HadwigerNelson.Stripe.typeP_comp_rot
#print axioms HadwigerNelson.Stripe.striped_of_comp_rot
#print axioms HadwigerNelson.Stripe.striped_of_proper_nt0
#print axioms HadwigerNelson.Stripe.proper_modTwo
#print axioms HadwigerNelson.Stripe.nt0_modTwo
#print axioms HadwigerNelson.Stripe.proper_threeCol
#print axioms HadwigerNelson.Stripe.not_striped_threeCol

/-! ## FS-39 phases B0–B1 and C — the bridge, conditional on real algebraic descent; `ℝ` and the real algebraic numbers
real closed (J17K)

`RealAlgebraicDescent` (Tarski; Artin–Lang) is a named hypothesis, true and unproved here; every theorem assuming it is
suffixed `_of_descent`. Its two controls: the one-variable case proved, the rational twin refuted. The two `IsRealClosed`
instances are Mathlib's TODO, upstream candidates. -/

#print axioms HadwigerNelson.Bridge.realAlgebraicDescent_one
#print axioms HadwigerNelson.Bridge.not_rationalDescent
#print axioms HadwigerNelson.Bridge.RealAlgebraicDescent.of_finite
#print axioms HadwigerNelson.Bridge.numberField_adjoinReal
#print axioms HadwigerNelson.Bridge.exists_numberField_drawing_of_descent
#print axioms HadwigerNelson.Bridge.iSup_numberField_le_chromaticNumber_plane
#print axioms HadwigerNelson.Bridge.chromaticNumber_plane_eq_iSup_numberField_of_descent
#print axioms HadwigerNelson.Bridge.exists_numberField_chromaticNumber_eq_plane_of_descent
#print axioms HadwigerNelson.Bridge.numberField_sup
#print axioms HadwigerNelson.Bridge.chromaticNumber_plane_ne_six_iff_of_descent
#print axioms Polynomial.exists_isRoot_of_odd_natDegree_real
#print axioms Real.isRealClosed
#print axioms algebraicClosure.isRealClosed
#print axioms isRealClosed_algebraicClosure_rat_real
#print axioms IsSumSq.map
#print axioms IsSemireal.of_ringHom

/-! ## FS-39 phase C — Lemma NP (no rational parametrisation of `y² = x³ − x`) and C3's one-variable form (J17K2)

NP over every field with `2 ≠ 0`, through Mathlib's Fermat–Catalan theorem at signature `(4, 4, 2)`; its two controls (the
genus-0 twin `a² − 1` is false, NP is false in characteristic 2); C3: `2 + L` and `√((2 + L)³ − (2 + L))` never both lie in
`F(t)` for `F` algebraic over `ℚ`; C3⁺: that field embeds in no purely transcendental tower over such an `F`. -/

#print axioms HadwigerNelson.NoParam.exists_eq_C_mul_sq_of_mul_eq_sq
#print axioms HadwigerNelson.NoParam.natDegree_eq_zero_of_mul_mul_sub_eq_sq
#print axioms HadwigerNelson.NoParam.exists_algebraMap_eq_of_sq_eq
#print axioms HadwigerNelson.NoParam.not_isSquare_cube_sub_self
#print axioms HadwigerNelson.NoParam.not_isSquare_cube_sub_self_of_charZero
#print axioms HadwigerNelson.NoParam.mem_range_C_of_sq_eq_cube_sub_self
#print axioms HadwigerNelson.NoParam.twin_not_mem_range_C
#print axioms HadwigerNelson.NoParam.isSquare_twin_sq_sub_one
#print axioms HadwigerNelson.NoParam.X_sq_not_mem_range_C
#print axioms HadwigerNelson.NoParam.isSquare_cube_sub_self_X_sq_zmod_two
#print axioms HadwigerNelson.NoParam.not_mem_adjoinTranscendental_of_sq_eq
#print axioms HadwigerNelson.NoParam.transcendental_two_add_liouvilleNumber
#print axioms HadwigerNelson.NoParam.not_mem_adjoinTranscendental_liouville
#print axioms HadwigerNelson.NoParam.sqrt_not_mem_adjoinTranscendental_bot_liouville
#print axioms HadwigerNelson.NoParam.mem_of_isPureTower
#print axioms HadwigerNelson.NoParam.not_forall_mem_isPureTower
#print axioms HadwigerNelson.NoParam.isPureTower_bot_liouville
#print axioms HadwigerNelson.NoParam.not_forall_mem_adjoinTranscendental_bot_liouville

/-! ## FS-75 (job J52K) — the three-colour criterion's ⟹ in winding form, relation-branching certificates, and
`χ(ℚ(√167)²) ≥ 4`

`ThreeColour.lean`: a colouring proper along `s` carries a winding (leaf 1). `ThetaCert.lean`: a passing certificate
leaves no winding (leaf 2). `ThetaPlane.lean`: the lattice in the plane over a real field holding `√d`, and the consumer.
`Instances/SqrtOneSixSeven.lean`: the 1,050-leaf certificate checked by `decide +kernel` and the headline. No finite
graph; **no native evaluation.** -/

#print axioms HadwigerNelson.ThreeColour.step_mem
#print axioms HadwigerNelson.ThreeColour.step_cast
#print axioms HadwigerNelson.ThreeColour.height_append
#print axioms HadwigerNelson.ThreeColour.height_cast
#print axioms HadwigerNelson.ThreeColour.height_bounds
#print axioms HadwigerNelson.ThreeColour.step_square
#print axioms HadwigerNelson.ThreeColour.height_perm
#print axioms HadwigerNelson.ThreeColour.wsum_append
#print axioms HadwigerNelson.ThreeColour.wsum_flatMap
#print axioms HadwigerNelson.ThreeColour.wsum_word
#print axioms HadwigerNelson.ThreeColour.length_word
#print axioms HadwigerNelson.ThreeColour.count_word
#print axioms HadwigerNelson.ThreeColour.word_add_perm
#print axioms HadwigerNelson.ThreeColour.height_add_gen
#print axioms HadwigerNelson.ThreeColour.wind_add_gen
#print axioms HadwigerNelson.ThreeColour.wind_shift
#print axioms HadwigerNelson.ThreeColour.wind_add_diag
#print axioms HadwigerNelson.ThreeColour.wind_add
#print axioms HadwigerNelson.ThreeColour.wind_cast
#print axioms HadwigerNelson.ThreeColour.minRise_le_wind
#print axioms HadwigerNelson.ThreeColour.wind_eq_of_sub_eq
#print axioms HadwigerNelson.ThreeColour.wsum_word_add
#print axioms HadwigerNelson.ThreeColour.wsum_word_posPart
#print axioms HadwigerNelson.ThreeColour.nonempty_winding
#print axioms HadwigerNelson.ThreeColour.nonempty_winding_of_colorable
#print axioms HadwigerNelson.ThreeColour.properAlong_one_two
#print axioms HadwigerNelson.ThreeColour.nonempty_winding_one_two
#print axioms HadwigerNelson.ThetaCert.getD_induction
#print axioms HadwigerNelson.ThetaCert.getD_addL
#print axioms HadwigerNelson.ThetaCert.getD_smulL
#print axioms HadwigerNelson.ThetaCert.length_addL_le
#print axioms HadwigerNelson.ThetaCert.length_smulL
#print axioms HadwigerNelson.ThetaCert.vecOf_nil
#print axioms HadwigerNelson.ThetaCert.vecOf_addL
#print axioms HadwigerNelson.ThetaCert.vecOf_smulL
#print axioms HadwigerNelson.ThetaCert.minRiseL_eq
#print axioms HadwigerNelson.ThetaCert.sum_getD_lincomb
#print axioms HadwigerNelson.ThetaCert.relMap_vecOf
#print axioms HadwigerNelson.ThetaCert.Soundness.eval_zero
#print axioms HadwigerNelson.ThetaCert.Soundness.eval_add
#print axioms HadwigerNelson.ThetaCert.Soundness.eval_smul
#print axioms HadwigerNelson.ThetaCert.Soundness.minRise_le_eval
#print axioms HadwigerNelson.ThetaCert.Soundness.holds_dflt
#print axioms HadwigerNelson.ThetaCert.Soundness.holds_cite
#print axioms HadwigerNelson.ThetaCert.Soundness.leaf_bound
#print axioms HadwigerNelson.ThetaCert.Soundness.leafOk_sound
#print axioms HadwigerNelson.ThetaCert.Soundness.mem_eqRun
#print axioms HadwigerNelson.ThetaCert.Soundness.exists_holds_childCons
#print axioms HadwigerNelson.ThetaCert.Soundness.checkTree_sound
#print axioms HadwigerNelson.ThetaCert.Soundness.checkKids_sound
#print axioms HadwigerNelson.ThetaCert.Cert.isEmpty_winding
#print axioms HadwigerNelson.ThetaCert.Cert.not_properAlong
#print axioms HadwigerNelson.ThetaCert.tinyK4_isEmpty_winding
#print axioms HadwigerNelson.ThetaPlane.iota_re
#print axioms HadwigerNelson.ThetaPlane.iota_im
#print axioms HadwigerNelson.ThetaPlane.iota_mem
#print axioms HadwigerNelson.ThetaPlane.norm_iota
#print axioms HadwigerNelson.ThetaPlane.properAlong_of_colorable
#print axioms HadwigerNelson.ThetaPlane.four_le_chromaticNumber_of_cert
#print axioms HadwigerNelson.Sqrt167.cert_units
#print axioms HadwigerNelson.Sqrt167.cert_check
#print axioms HadwigerNelson.four_le_chromaticNumber_planeOver_sqrt167
#print axioms HadwigerNelson.four_le_chromaticNumber_planeOver_of_sqrt167_mem

/-! ## FS-100 (jobs X11K, X11K2, X11K3) — `χ(ℚ(√47)²) ≤ 5` unconditional, and the sorry-free part of SP-Cor's chain

`Instances/SqrtFortySeven.lean`: Theorem A at 11 by an elementary descent. `SpectralChain.lean`: node M and node L0 over
the interface, measurability on `R̂`, and the local bound `L(F)` with Mathlib's number-field API. No native evaluation. -/

#print axioms HadwigerNelson.SqrtFortySeven.coords_unique
#print axioms HadwigerNelson.SqrtFortySeven.norm_eq_zero
#print axioms HadwigerNelson.SqrtFortySeven.f47_le_q47
#print axioms HadwigerNelson.SqrtFortySeven.div_mem_z11
#print axioms HadwigerNelson.SqrtFortySeven.forty_seven_eq
#print axioms HadwigerNelson.SqrtFortySeven.sq_add_sq_eq_zero_mod11
#print axioms HadwigerNelson.SqrtFortySeven.zmod_key
#print axioms HadwigerNelson.SqrtFortySeven.eleven_dvd
#print axioms HadwigerNelson.SqrtFortySeven.int_descent
#print axioms HadwigerNelson.SqrtFortySeven.rat_descent
#print axioms HadwigerNelson.SqrtFortySeven.unit_mem_A
#print axioms HadwigerNelson.SqrtFortySeven.exists_residue11
#print axioms HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five
#print axioms HadwigerNelson.SpectralChain.unitVectors_subset_unitRing
#print axioms HadwigerNelson.SpectralChain.Interface.mr_of_pe2_efPlus
#print axioms HadwigerNelson.SpectralChain.x4_nonempty_of_colorable
#print axioms HadwigerNelson.SpectralChain.measurable_eval
#print axioms HadwigerNelson.SpectralChain.measurable_rot
#print axioms HadwigerNelson.SpectralChain.mem_fieldI
#print axioms HadwigerNelson.SpectralChain.fieldI_conj
#print axioms HadwigerNelson.SpectralChain.toFieldI_surjective
#print axioms HadwigerNelson.SpectralChain.StablePrime.le_comap
#print axioms HadwigerNelson.SpectralChain.tetra_eq
#print axioms HadwigerNelson.SpectralChain.tetra_comm
#print axioms HadwigerNelson.SpectralChain.abs_tetra_le
#print axioms HadwigerNelson.SpectralChain.corr_sub
#print axioms HadwigerNelson.SpectralChain.posDef_corr
#print axioms HadwigerNelson.SpectralChain.rotInv_of_isTraceSpectral
#print axioms HadwigerNelson.SpectralChain.X4_eq_iInter
#print axioms HadwigerNelson.SpectralChain.setOf_pair_eq
#print axioms HadwigerNelson.SpectralChain.isClosed_X4
#print axioms HadwigerNelson.SpectralChain.measurableSet_X4
#print axioms HadwigerNelson.SpectralChain.shift_mem_X4
#print axioms HadwigerNelson.SpectralChain.rot_mem_X4
#print axioms HadwigerNelson.SpectralChain.exists_invariantColouring
#print axioms HadwigerNelson.SpectralChain.countable_unitRing
#print axioms HadwigerNelson.SpectralChain.Interface.x4_eq_empty
#print axioms HadwigerNelson.SpectralChain.Interface.five_le_chromaticNumber
#print axioms HadwigerNelson.SpectralChain.min_localBound_five_le_chromaticNumber
#print axioms HadwigerNelson.SpectralChain.min_localBound_five_le_chromaticNumber_of_totallyReal
#print axioms HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound
#print axioms HadwigerNelson.SqrtFortySeven.countable_F47

/-! ## FS-131 (job FS131-K1) — the foundation of the regularity wall's plane

`Plane/Basic.lean`, `Plane/UnitPairs.lean`, `Plane/AeColouring.lean`, `Plane/ArcMap.lean`: directions and ring points,
sets with null unit pairs and density points, measurable colourings proper at almost every unit pair and `χ_m⁰`, arc maps
(valid maps and fragments, tiles, `P_cl`, Siamese pairs, simplicity). Definitions and their spec lemmas; no backlog row.
No native evaluation. -/

#print axioms HadwigerNelson.Plane.norm_e
#print axioms HadwigerNelson.Plane.e_eq
#print axioms HadwigerNelson.Plane.e_add
#print axioms HadwigerNelson.Plane.e_add_two_pi
#print axioms HadwigerNelson.Plane.dist_ringPt
#print axioms HadwigerNelson.Plane.ringPt_mem_sphere
#print axioms HadwigerNelson.Plane.unitPairSet_mono
#print axioms HadwigerNelson.Plane.UnitPairsNull.mono
#print axioms HadwigerNelson.Plane.unitPairsNull_of_dist_lt_one
#print axioms HadwigerNelson.Plane.not_unitPairsNull_ball_two
#print axioms HadwigerNelson.Plane.densityRatio_univ
#print axioms HadwigerNelson.Plane.chiM0_le
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_of_arcs_empty
#print axioms HadwigerNelson.Plane.ArcMap.const_interiorPts
#print axioms HadwigerNelson.Plane.im_eq_zero_of_mem_segment
#print axioms HadwigerNelson.Plane.mem_segment_of_im_eq_zero
#print axioms HadwigerNelson.Plane.halfDisc_arcs_union
#print axioms HadwigerNelson.Plane.halfDisc_mem_interiorPts
#print axioms HadwigerNelson.Plane.halfDisc_I_mul_mem
#print axioms HadwigerNelson.Plane.halfDisc_component_upper
#print axioms HadwigerNelson.Plane.halfDisc_component_lower

/-! ## FS-131 wave 1 — the plane's sets with null unit pairs, chords, Falconer fans (skeleton until its implementer lands it) -/

#print axioms HadwigerNelson.Plane.dist_ne_one_of_mem_densitySet
#print axioms HadwigerNelson.Plane.AeColouring.dist_ne_one
#print axioms HadwigerNelson.Plane.upperDensityAt_pos_of_mem_densitySet
#print axioms HadwigerNelson.Plane.hullset
#print axioms HadwigerNelson.Plane.hullset_of_isCompact
#print axioms HadwigerNelson.Plane.hull2
#print axioms HadwigerNelson.Plane.dist_ne_one_of_mem_interior_densitySet
#print axioms HadwigerNelson.Plane.subset_densitySet_of_isOpen
#print axioms HadwigerNelson.Plane.dist_ne_one_of_mem_of_mem_closure
#print axioms HadwigerNelson.Plane.dist_lt_one_of_isPreconnected
#print axioms HadwigerNelson.Plane.dist_lt_one_of_forall_dist_ne_one
#print axioms HadwigerNelson.Plane.dist_lt_one_of_chain
#print axioms HadwigerNelson.Plane.dist_lt_one_of_closure_inter_nonempty
#print axioms HadwigerNelson.Plane.phi_univ
#print axioms HadwigerNelson.Plane.unitPairsNull_iff_ae_phi_eq_zero
#print axioms HadwigerNelson.Plane.isMUA_iff_ae_phi_pos
#print axioms HadwigerNelson.Plane.isMUA_iff_ae_eq
#print axioms HadwigerNelson.Plane.ringPt_sub_ringPt
#print axioms HadwigerNelson.Plane.dist_ringPt_ringPt
#print axioms HadwigerNelson.Plane.dist_ringPt_ringPt_cmp_one
#print axioms HadwigerNelson.Plane.twoCirc_identity
#print axioms HadwigerNelson.Plane.twoCirc_cmp_one
#print axioms HadwigerNelson.Plane.exists_sign_of_equilateral
#print axioms HadwigerNelson.Plane.xcorner
#print axioms HadwigerNelson.Arith.noAffine
#print axioms HadwigerNelson.Arith.rhombus_falconerFan
#print axioms HadwigerNelson.Arith.falconerFan_hom
#print axioms HadwigerNelson.Arith.falconerFan_chromaticNumber
#print axioms HadwigerNelson.SpernerGrid.exists_rainbowCell
#print axioms HadwigerNelson.LebesgueCovering.exists_mem_inter_three
#print axioms HadwigerNelson.LebesgueCovering.lebesgue_covering_rect'
#print axioms HadwigerNelson.LebesgueCovering.lebesgue_covering_rect
#print axioms HadwigerNelson.LebesgueCovering.closedSquare_eq_reProdIm
#print axioms HadwigerNelson.LebesgueCovering.lebesgue_covering_square
#print axioms HadwigerNelson.LebesgueCovering.quadrant_hypotheses

/-! ## FS-131 wave 3 (job FS131-K3) — the foundation: the local geometry of an arc map, the ring vocabulary, RINGBAND's circle colourings -/

#print axioms HadwigerNelson.Plane.Arc.isCompact_carrier
#print axioms HadwigerNelson.Plane.Arc.isClosed_carrier
#print axioms HadwigerNelson.Plane.coneAt_mono
#print axioms HadwigerNelson.Plane.mem_coneAt_add_two_pi
#print axioms HadwigerNelson.Plane.mem_closure_of_mem_coneAt
#print axioms HadwigerNelson.Plane.germ_mono
#print axioms HadwigerNelson.Plane.GermIn.mono
#print axioms HadwigerNelson.Plane.GermIn.inter
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_subset_dom
#print axioms HadwigerNelson.Plane.ArcMap.continuousOn_col
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_region
#print axioms HadwigerNelson.Plane.ArcMap.region_subset_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.subset_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.isOpen
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.isPreconnected
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.nonempty
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.col_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.tileOf
#print axioms HadwigerNelson.Plane.ArcMap.TileOf.subset_region
#print axioms HadwigerNelson.Plane.ArcMap.mem_coloursAt_of_tileOf
#print axioms HadwigerNelson.Plane.im_eq_zero_of_mem_segment_neg
#print axioms HadwigerNelson.Plane.mem_segment_neg_of_im_eq_zero
#print axioms HadwigerNelson.Plane.re_eq_zero_of_mem_segment_neg_I
#print axioms HadwigerNelson.Plane.halfPlane2_mem_interiorPts
#print axioms HadwigerNelson.Plane.halfPlane2_im_eq_zero_of_mem_Γ
#print axioms HadwigerNelson.Plane.exists_sin_ne_zero_of_lt
#print axioms HadwigerNelson.Plane.halfPlane2_not_isRingArc
#print axioms HadwigerNelson.Plane.halfPlane2_isChangePoint
#print axioms HadwigerNelson.Plane.quadRing_mem_interiorPts
#print axioms HadwigerNelson.Plane.quadRing_ringPt_mem_Γ
#print axioms HadwigerNelson.Plane.quadRing_col_first
#print axioms HadwigerNelson.Plane.eventually_first_quadrant
#print axioms HadwigerNelson.Plane.quadRing_first_mem_region
#print axioms HadwigerNelson.Plane.dist_scale_e
#print axioms HadwigerNelson.Plane.quadRing_isRingArc
#print axioms HadwigerNelson.Plane.quadRing_coloursAt_zero
#print axioms HadwigerNelson.Plane.quadRing_isQArc
#print axioms HadwigerNelson.Plane.upperDensityAt_empty
#print axioms HadwigerNelson.Plane.upperDensityAt_univ
#print axioms HadwigerNelson.Plane.const_ball_isTile_iff
#print axioms HadwigerNelson.Plane.cellIndex_eventually_eq
#print axioms HadwigerNelson.Plane.cellIndex_jump
#print axioms HadwigerNelson.Plane.cellIndex_six
#print axioms HadwigerNelson.Plane.cellIndex_nine

/-! ## FS-131 wave 3 (job FS131-K3b) — the skeleton: local structure, SIXFRAG, tiles, the ring, the lens, RINGBAND (landed sorry-free by FS131-I3h) -/

#print axioms HadwigerNelson.Plane.norm_div_norm_sub_le
#print axioms HadwigerNelson.Plane.Icc_subset_angleIcc
#print axioms HadwigerNelson.Plane.Ioo_subset_angleIoo
#print axioms HadwigerNelson.Plane.Arc.finite_inter_sphere_or_eq_circ
#print axioms HadwigerNelson.Plane.volume_segment_eq_zero
#print axioms HadwigerNelson.Plane.Arc.volume_carrier
#print axioms HadwigerNelson.Plane.ArcMap.covers_one_iff
#print axioms HadwigerNelson.Plane.ArcMap.finite_ringΓ_off_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.dense_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.finite_ray_inter_sphere
#print axioms HadwigerNelson.Plane.ArcMap.subsingleton_ray_inter_segment
#print axioms HadwigerNelson.Plane.ArcMap.exists_ray_in_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_tile
#print axioms HadwigerNelson.Plane.ArcMap.finite_tiles_near
#print axioms HadwigerNelson.Plane.ArcMap.mem_coloursAt_iff_exists_tileOf
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_region_eq_biUnion
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_coneAt_region
#print axioms HadwigerNelson.Plane.ArcMap.germ_dichotomy
#print axioms HadwigerNelson.Plane.ArcMap.Simple.coneAt_eq_angleIcc
#print axioms HadwigerNelson.Plane.sixArcs_nondegenerate
#print axioms HadwigerNelson.Plane.sixArcs_locallyFinite
#print axioms HadwigerNelson.Plane.sixCol_locallyConstant
#print axioms HadwigerNelson.Plane.sixFrag
#print axioms HadwigerNelson.Plane.sixFrag_valid
#print axioms HadwigerNelson.Plane.sixFrag_nonSiamese
#print axioms HadwigerNelson.Plane.sixFrag_covers
#print axioms HadwigerNelson.Plane.sixFrag_coloursAt_zero
#print axioms HadwigerNelson.Plane.sixFrag_sphere_subset_Γ
#print axioms HadwigerNelson.Plane.sixFrag_isQArc
#print axioms HadwigerNelson.Plane.sixFrag_isRingArc
#print axioms HadwigerNelson.Plane.ArcMap.Valid.unitPairsNull_region
#print axioms HadwigerNelson.Plane.ArcMap.ne1_region
#print axioms HadwigerNelson.Plane.ArcMap.Valid.dist_lt_or_gt_of_isPreconnected
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.closure_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.dist_lt_one
#print axioms HadwigerNelson.Plane.ArcMap.unitNear_or_unitFar
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.unitNear_self
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.dist_le_one_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.UnitNear.dist_le_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.UnitFar.one_le_dist_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.unitNear_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.unitFar_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.NonSiamese.eq_of_unitNear
#print axioms HadwigerNelson.Plane.ArcMap.unitNear_iff_of_mem_closure_inter
#print axioms HadwigerNelson.Plane.ArcMap.cluster
#print axioms HadwigerNelson.Plane.ArcMap.Valid.wholeRestrict
#print axioms HadwigerNelson.Plane.ArcMap.wholeRestrict_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.wholeRestrict_covers
#print axioms HadwigerNelson.Plane.ArcMap.isTile_wholeRestrict_iff
#print axioms HadwigerNelson.Plane.ArcMap.isTile_wholeRestrict_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.NonSiamese.wholeRestrict
#print axioms HadwigerNelson.Plane.ArcMap.Simple.wholeRestrict
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_closure_wholeRestrict_of_inner
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_closure_wholeRestrict_R₂
#print axioms HadwigerNelson.Plane.ArcMap.Valid.false_of_crossing
#print axioms HadwigerNelson.Plane.ArcMap.isPreconnected_germ
#print axioms HadwigerNelson.Plane.ArcMap.dist_ringPt_shift_cmp
#print axioms HadwigerNelson.Plane.ArcMap.norm_add_sq_eq
#print axioms HadwigerNelson.Plane.ArcMap.cone_expand
#print axioms HadwigerNelson.Plane.ArcMap.dist_ringPt_germ_le
#print axioms HadwigerNelson.Plane.ArcMap.Valid.cone_re_nonneg_of_germ
#print axioms HadwigerNelson.Plane.ArcMap.Valid.cone_re_nonpos_of_germ
#print axioms HadwigerNelson.Plane.ArcMap.e_pi
#print axioms HadwigerNelson.Plane.ArcMap.re_e_mul_conj_e
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_sub_ringPt_minus_third
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_sub_ringPt_plus_third
#print axioms HadwigerNelson.Plane.ArcMap.not_germIn_closure_rotate
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_coloursAt_of_mem_sphere
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_ringD
#print axioms HadwigerNelson.Plane.ArcMap.mem_interiorPts_of_notMem_Γ
#print axioms HadwigerNelson.Plane.ArcMap.col_eq_of_mem_closure_region
#print axioms HadwigerNelson.Plane.ArcMap.ringD_subset_Γ
#print axioms HadwigerNelson.Plane.ArcMap.finite_ringD_off_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.germR_vMinus
#print axioms HadwigerNelson.Plane.ArcMap.germR_vPlus
#print axioms HadwigerNelson.Plane.ArcMap.germR_uMinus
#print axioms HadwigerNelson.Plane.ArcMap.germR_uPlus
#print axioms HadwigerNelson.Plane.ArcMap.GermIn.exists_mem_sphere
#print axioms HadwigerNelson.Plane.ArcMap.IsChangePoint.not_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.IsChangePoint.ncard_add_two_le
#print axioms HadwigerNelson.Plane.ArcMap.germS_absent
#print axioms HadwigerNelson.Plane.ArcMap.germS_inward
#print axioms HadwigerNelson.Plane.ArcMap.germS_outward
#print axioms HadwigerNelson.Plane.ArcMap.germS_four
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_mem_closure_germ
#print axioms HadwigerNelson.Plane.ArcMap.onQArc_of_germOnQ
#print axioms HadwigerNelson.Plane.ArcMap.ringQPrimeS
#print axioms HadwigerNelson.Plane.ArcMap.qfree4
#print axioms HadwigerNelson.Plane.ArcMap.fiveRing_no_changePoint
#print axioms HadwigerNelson.Plane.ArcMap.fiveRing_finite_off_Q
#print axioms HadwigerNelson.Plane.ArcMap.fiveRing_length
#print axioms HadwigerNelson.Plane.ArcMap.fiveRing_no_hub
#print axioms HadwigerNelson.Plane.ArcMap.sixQ_sphere_subset_Γ
#print axioms HadwigerNelson.Plane.ArcMap.sixQ_sides
#print axioms HadwigerNelson.Plane.ArcMap.sixQ_isQArc
#print axioms HadwigerNelson.Plane.ArcMap.sixQ_inhabited
#print axioms HadwigerNelson.Plane.ArcMap.touchW
#print axioms HadwigerNelson.Plane.ArcMap.echo_unique
#print axioms HadwigerNelson.Plane.ArcMap.echo_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.echo
#print axioms HadwigerNelson.Plane.ArcMap.side_ball_subset_closure
#print axioms HadwigerNelson.Plane.ArcMap.norm_sub_sq_eq
#print axioms HadwigerNelson.Plane.ArcMap.norm_sq_sub_radial
#print axioms HadwigerNelson.Plane.ArcMap.re_mul_conj_e_bound
#print axioms HadwigerNelson.Plane.ArcMap.Valid.cos_nonneg_of_radial_inner
#print axioms HadwigerNelson.Plane.ArcMap.outer_near_arith
#print axioms HadwigerNelson.Plane.ArcMap.outer_far_arith
#print axioms HadwigerNelson.Plane.ArcMap.Valid.cos_nonpos_of_radial_outer
#print axioms HadwigerNelson.Plane.ArcMap.mem_angleIcc_of_cos_nonneg
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.radial_inner
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.radial_outer
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_angleIcc_angleIoo_of_le
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_angleIcc_angleIoo_of_le'
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_cone_inner
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_cone_outer
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_sideCone_inner
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_sideCone_outer
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_sideCone_other
#print axioms HadwigerNelson.Plane.ArcMap.four_of_bothKind
#print axioms HadwigerNelson.Plane.ArcMap.four_of_bothKind_simple
#print axioms HadwigerNelson.Plane.ArcMap.flank_cone
#print axioms HadwigerNelson.Plane.ArcMap.flank_edge_exists
#print axioms HadwigerNelson.Plane.ArcMap.flank_initialPieces
#print axioms HadwigerNelson.Plane.ArcMap.flank
#print axioms HadwigerNelson.Plane.exit_lens
#print axioms HadwigerNelson.Plane.exit_lens_row
#print axioms HadwigerNelson.Plane.CircleColouring.exists_lift
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_i
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_ii
#print axioms HadwigerNelson.Plane.CircleColouring.W_eq
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_iii
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_iv
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_v
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_vi_periodic
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_vi_noJump
#print axioms HadwigerNelson.Plane.CircleColouring.exists_swap_of_abs_W_le_one
#print axioms HadwigerNelson.Plane.CircleColouring.W_mod_six
#print axioms HadwigerNelson.Plane.CircleColouring.exists_pair_of_abs_W_le_two
#print axioms HadwigerNelson.Plane.ArcMap.e_injOn_Ico
#print axioms HadwigerNelson.Plane.ArcMap.ring_finite_S
#print axioms HadwigerNelson.Plane.ArcMap.ring_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.ring_proper
#print axioms HadwigerNelson.Plane.ArcMap.ringCircleColouring
#print axioms HadwigerNelson.Plane.ArcMap.exists_swap_of_ring

/-! ## FS-131 Woodall's chain (job FS131-W) — the foundation: collars about a unit circle, the picture at a point, Woodall's normal forms -/

#print axioms HadwigerNelson.Plane.angleIcc_zero_two_pi
#print axioms HadwigerNelson.Plane.coneAt_univ
#print axioms HadwigerNelson.Plane.ArcMap.const_sectorsAt
#print axioms HadwigerNelson.Plane.ArcMap.sectorsAt_one_colour

/-! ## FS-131 Woodall's chain (job FS131-W, re-planned by FS131-W2) — the skeleton: Townsend's π/3 lemma, Woodall's step-4 lemma, maps need six over arc maps (sorry until the chain's implementer lands it; no open leaf: FS131-E1's E1-NO45 replaces steps 7–8 and step 5's equality case) -/

#print axioms HadwigerNelson.Plane.isOpen_annSector
#print axioms HadwigerNelson.Plane.isPreconnected_annSector
#print axioms HadwigerNelson.Plane.isOpen_collar
#print axioms HadwigerNelson.Plane.collar_subset_collar
#print axioms HadwigerNelson.Plane.exists_collar_of_collarAt
#print axioms HadwigerNelson.Plane.exists_unit_pair_collar
#print axioms HadwigerNelson.Plane.exists_changePt
#print axioms HadwigerNelson.Plane.sphere_meets_of_collarAt
#print axioms HadwigerNelson.Plane.woodall_step4
#print axioms HadwigerNelson.Plane.not_woodall_step4_two_thirds
#print axioms HadwigerNelson.Plane.townsend_lemma
#print axioms HadwigerNelson.Plane.collarAt_shadow_outer
#print axioms HadwigerNelson.Plane.collarAt_shadow_inner
#print axioms HadwigerNelson.Plane.ArcMap.col_not_mem_of_mem_shadow
#print axioms HadwigerNelson.Plane.ArcMap.subset_closure_of_subset_shadow
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.coloursAt_eq
#print axioms HadwigerNelson.Plane.ArcMap.step5_lt
#print axioms HadwigerNelson.Plane.ArcMap.aeMap6_merged
#print axioms HadwigerNelson.Plane.ArcMap.step6
#print axioms HadwigerNelson.Plane.ArcMap.aeMap6_normal
#print axioms HadwigerNelson.Plane.ArcMap.aeMap6
#print axioms HadwigerNelson.Plane.ArcMap.aeMap6_of_condition5
#print axioms HadwigerNelson.Plane.woodall_thm6

/-! ## FS-131 Woodall's chain (job FS131-W2) — FS131-E1's lemmas: E1-SEE, E1-RAY, E1-CROSS, E1-COVER, E1-BAD (corrected, robust), the refined second-order lemma, E1-NO45 (sorry until the chain's implementer lands them) -/

#print axioms HadwigerNelson.Plane.dist_le_one_of_subset_closure
#print axioms HadwigerNelson.Plane.exists_mem_collar_of_dist_lt
#print axioms HadwigerNelson.Plane.exists_Ioo_avoiding
#print axioms HadwigerNelson.Plane.mem_coneAt_annSector
#print axioms HadwigerNelson.Plane.collarAt_shadow_of_parabola
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_coloursAt_of_dist_eq_one
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_coloursAt_of_collarAt
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_shadow_inner_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_shadow_outer_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.not_mem_range_of_crossesAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_side_colours_of_not_crossesAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_closure_colour_of_arc
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.false_of_ncard_le_two_on_arc
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.exists_mem_Ico
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.not_mem_coloursAt_of_mem_Ioo
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.exists_parabola_region
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.exists_normal_collarAt
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.absent_at_normal
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.exists_two_absent
#print axioms HadwigerNelson.Plane.ArcMap.false_of_four_le_sectors

-- FS131-IW: the supporting lemmas of the implementer (children of the leaves above; no statement of the skeleton changed)
#print axioms HadwigerNelson.Plane.eq_add_norm_mul_e
#print axioms HadwigerNelson.Plane.eventually_abs_arg_lt
#print axioms HadwigerNelson.Plane.eventually_norm_sub_mem
#print axioms HadwigerNelson.Plane.Rim.radii_mono
#print axioms HadwigerNelson.Plane.mem_collar_iff
#print axioms HadwigerNelson.Plane.exists_pos_le_finset
#print axioms HadwigerNelson.Plane.dist_polar_pair
#print axioms HadwigerNelson.Plane.exists_chord_angle
#print axioms HadwigerNelson.Plane.false_of_dense_unit_pair
#print axioms HadwigerNelson.Plane.norm_sq_mul_e_add_e
#print axioms HadwigerNelson.Plane.dot_eq
#print axioms HadwigerNelson.Plane.dot_sub_left
#print axioms HadwigerNelson.Plane.dot_sub_right
#print axioms HadwigerNelson.Plane.dot_real_mul_left
#print axioms HadwigerNelson.Plane.norm_sub_real_mul_e_sq
#print axioms HadwigerNelson.Plane.mem_shadow_of_preconnected
#print axioms HadwigerNelson.Plane.dot_cone_bound
#print axioms HadwigerNelson.Plane.isPreconnected_collar
#print axioms HadwigerNelson.Plane.eventually_collarAt
#print axioms HadwigerNelson.Plane.CollarAt.interior
#print axioms HadwigerNelson.Plane.false_of_changePt_landing
#print axioms HadwigerNelson.Plane.exists_changePt_band
#print axioms HadwigerNelson.Plane.false_of_collars_closed
#print axioms HadwigerNelson.Plane.finite_bad_radii
#print axioms HadwigerNelson.Plane.dist_sq_polar_one
#print axioms HadwigerNelson.Plane.dist_sq_polar_polar
#print axioms HadwigerNelson.Plane.norm_sq_fromFrame_sub
#print axioms HadwigerNelson.Plane.e_add_two_pi_mul_int
#print axioms HadwigerNelson.Plane.one_sub_e_two_mul
#print axioms HadwigerNelson.Plane.one_sub_e_neg_two_mul
#print axioms HadwigerNelson.Plane.CollarAt.mono
#print axioms HadwigerNelson.Plane.shadow_mono
#print axioms HadwigerNelson.Plane.CollarAt.inter
#print axioms HadwigerNelson.Plane.prev_succ
#print axioms HadwigerNelson.Plane.d_prev_succ
#print axioms HadwigerNelson.Plane.eq_of_edge_mem_angleIcc
#print axioms HadwigerNelson.Plane.finite_roots_quartic
#print axioms HadwigerNelson.Plane.fromFrame_re
#print axioms HadwigerNelson.Plane.fromFrame_im
#print axioms HadwigerNelson.Plane.Arc.finite_inter_parabola
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.eq_of_edge_mem_angleIcc
#print axioms HadwigerNelson.Plane.sum_width_aux
#print axioms HadwigerNelson.Plane.sum_width
#print axioms HadwigerNelson.Plane.width_eq_pi_unique
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_shadow_of_mem_region
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_interiorPts_of_isOpen
#print axioms HadwigerNelson.Plane.ArcMap.exists_near_sphere_sides
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_inside_of_colour
#print axioms HadwigerNelson.Plane.ArcMap.exists_inside_colour
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.exists_prev_dir
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_prev_inner
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_prev_outer
#print axioms HadwigerNelson.Plane.ArcMap.exists_cur_dir
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_cur_inner
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_cur_outer
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_nonempty_of_mem_closure_region
#print axioms HadwigerNelson.Plane.finRotate_ne_symm

/-! ## FS-131 Woodall's chain (job FS131-IWb) — the connected piece (a cone direction of a colour class is one of a tile's), steps 5 and 6, the picture -/

#print axioms HadwigerNelson.Plane.ArcMap.exists_preconnected_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.collarAt_shadow_inner_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.collarAt_shadow_outer_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.mem_coneAt_of_mem_Icc
#print axioms HadwigerNelson.Plane.collarAt_setOf_forall_mem
#print axioms HadwigerNelson.Plane.CollarAt.of_abs_sub_lt
#print axioms HadwigerNelson.Plane.false_of_cos_eq_zero_on_Icc
#print axioms HadwigerNelson.Plane.exists_eq_add_half_pi_of_cos_eq_zero
#print axioms HadwigerNelson.Plane.cos_neg_of_pi_div_two_lt_of_lt_three_pi_div_two
#print axioms HadwigerNelson.Plane.ArcMap.Valid.region_dist_ne_one
#print axioms HadwigerNelson.Plane.ArcMap.exists_two_cover_of_three_le_card
#print axioms HadwigerNelson.Plane.ArcMap.collarAt_closure_of_forall_shadow
#print axioms HadwigerNelson.Plane.ArcMap.SectorsAt.collarAt_opposite

/-! ## FS-131 Woodall's chain (job FS131-W3) — the ∃-forms' inhabitants (two and three colours), the phantom adversary (FS131-E3 § 4.1; NiceAt.normal private, inventory item 167 (b); sorry at four inhabitant leaves until the chain's implementer lands them) -/

#print axioms HadwigerNelson.Plane.ArcMap.threeCol_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_valid
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_sectorsAt
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_phantom
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_ncard_coloursAt_le_two
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_niceAt
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_woodallMerged
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_woodallNormal
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_not_forall_merged
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_not_forall_normal
#print axioms HadwigerNelson.Plane.halfDisc_sectorsAt
#print axioms HadwigerNelson.Plane.halfDisc_niceAt

/-! ## FS-131 Woodall's chain (job FS131-IWc) — the inhabitants' children: polar coordinates about `0`, the cone of an open sector at its apex, the regions of `threeSectorDisc` and `halfDisc` -/

#print axioms HadwigerNelson.Plane.norm_real_mul_e
#print axioms HadwigerNelson.Plane.closure_annSector_subset
#print axioms HadwigerNelson.Plane.eq_of_e_eq_of_mem_Ioc
#print axioms HadwigerNelson.Plane.coneAt_annSector_eq
#print axioms HadwigerNelson.Plane.eq_norm_mul_e_pi_add_arg
#print axioms HadwigerNelson.Plane.pi_add_arg_neg_mem
#print axioms HadwigerNelson.Plane.pi_add_arg_neg_eq
#print axioms HadwigerNelson.Plane.mem_annSector_zero_iff
#print axioms HadwigerNelson.Plane.mem_segment_half_iff
#print axioms HadwigerNelson.Plane.polar_inj
#print axioms HadwigerNelson.Plane.e_ne_e_of_lt
#print axioms HadwigerNelson.Plane.ArcMap.mem_threeCuts_iff
#print axioms HadwigerNelson.Plane.ArcMap.threeCol_eq_iff
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_region
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_region_zero
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_region_one
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_region_two
#print axioms HadwigerNelson.Plane.ArcMap.angleIcc_subset_angleIcc

/-! ## FS-131 Woodall's merge (job FS131-W3) — step 3 localized: E3-W, recolouring, the merge at a wedge, locality, the local data, E3-NICE, E3-BALL (sorry until the chain's implementer lands them) -/

#print axioms HadwigerNelson.Plane.clear_wedge
#print axioms HadwigerNelson.Plane.annSector_subset_ball
#print axioms HadwigerNelson.Plane.annSector_mono_r₂
#print axioms HadwigerNelson.Plane.mem_segment_ray
#print axioms HadwigerNelson.Plane.mem_annSector_union_of_ne
#print axioms HadwigerNelson.Plane.disjoint_annSector_wedges
#print axioms HadwigerNelson.Plane.wedgeArcs_subset_polar
#print axioms HadwigerNelson.Plane.polar_notMem
#print axioms HadwigerNelson.Plane.annSector_notMem_wedgeArcs
#print axioms HadwigerNelson.Plane.wedgeArcs_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_annSector_subset
#print axioms HadwigerNelson.Plane.ArcMap.recolour_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_recolour_subset
#print axioms HadwigerNelson.Plane.ArcMap.recolour_valid
#print axioms HadwigerNelson.Plane.ArcMap.recolour_condition5
#print axioms HadwigerNelson.Plane.ArcMap.recolour_region_diff
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_valid
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_condition5
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_region_diff
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_congr
#print axioms HadwigerNelson.Plane.ArcMap.niceAt_congr
#print axioms HadwigerNelson.Plane.ArcMap.exists_dirColourAt
#print axioms HadwigerNelson.Plane.ArcMap.ncard_coloursAt_le_two_of_sides
#print axioms HadwigerNelson.Plane.ArcMap.mem_curveAt_one_iff
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.ncard_coloursAt_le_two
#print axioms HadwigerNelson.Plane.ArcMap.finite_three_le_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.niceAt_of_dirColourAt
#print axioms HadwigerNelson.Plane.ArcMap.dirColourAt_wedgeMerge
#print axioms HadwigerNelson.Plane.ArcMap.mem_coneAt_inter_annSector
#print axioms HadwigerNelson.Plane.ArcMap.mem_angleIcc_iff_e
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_angleIcc
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_wedgeMerge_of_notMem
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_mem_coneAt_wedgeMerge
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_mem_coneAt_wedgeMerge_of_subset
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_niceAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_at
#print axioms HadwigerNelson.Plane.ArcMap.exists_woodallMerged

/-! ## FS-131 Woodall's merge (job FS131-IWd) — the picture from the local data (side colours, runs, horns), the crossings a merge creates, E3-NICE's measure -/

#print axioms HadwigerNelson.Plane.offDirs_add_int
#print axioms HadwigerNelson.Plane.exists_offDirs_punctured
#print axioms HadwigerNelson.Plane.exists_offDirs_Ioo
#print axioms HadwigerNelson.Plane.mem_closure_offDirs_Ioo
#print axioms HadwigerNelson.Plane.finRotate_val
#print axioms HadwigerNelson.Plane.isoRad_pos
#print axioms HadwigerNelson.Plane.offDirs_of_isoRad
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.eq_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.eq_of_near
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.eq_add_int
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.eq_of_Ioo
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.eq_rightCol
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.eq_leftCol
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.rightCol_eq_of
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.leftCol_eq_of
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.rightCol_of_offDirs
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.rightCol_add_int
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.leftCol_add_int
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.rightCol_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.leftCol_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.not_offDirs_of_ne
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.const_of_noChange
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.noChange_of_const
#print axioms HadwigerNelson.Plane.dot_real_mul_right
#print axioms HadwigerNelson.Plane.eq_of_cos_sub_eq_zero
#print axioms HadwigerNelson.Plane.exists_mem_Ioo_of_cos_pos
#print axioms HadwigerNelson.Plane.cos_pos_arc
#print axioms HadwigerNelson.Plane.exists_sign_near
#print axioms HadwigerNelson.Plane.coneAt_subset_halfPlane
#print axioms HadwigerNelson.Plane.norm_add_sq_dot
#print axioms HadwigerNelson.Plane.ArcMap.niceAt_of_crossing
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.exists_sides
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_crossing
#print axioms HadwigerNelson.Plane.ArcMap.DirColourAt.exists_merge_dirs

/-! ## FS-131 Woodall's chain (job FS131-WL1) — the plane-map model (QA2-1): the brick map's T-junctions, its pictures, Woodall's normal form on the plane, Condition 5; the adversaries off the domain -/

#print axioms HadwigerNelson.Plane.ArcMap.coneAt_region_of_sectors
#print axioms HadwigerNelson.Plane.ArcMap.niceAt_of_injective
#print axioms HadwigerNelson.Plane.brickCellCol_ne
#print axioms HadwigerNelson.Plane.polar_re_im
#print axioms HadwigerNelson.Plane.sevenBrickMap_mem_region_of_cell
#print axioms HadwigerNelson.Plane.exists_polar_Ioc
#print axioms HadwigerNelson.Plane.tUpCols_injective
#print axioms HadwigerNelson.Plane.tDownCols_injective
#print axioms HadwigerNelson.Plane.tUpDirs_lt
#print axioms HadwigerNelson.Plane.tDownDirs_lt
#print axioms HadwigerNelson.Plane.tUpDirs_ge
#print axioms HadwigerNelson.Plane.tDownDirs_ge
#print axioms HadwigerNelson.Plane.brickCorner_mem_arcs
#print axioms HadwigerNelson.Plane.tUp_sub
#print axioms HadwigerNelson.Plane.tDown_sub
#print axioms HadwigerNelson.Plane.tUp_cov
#print axioms HadwigerNelson.Plane.tDown_cov
#print axioms HadwigerNelson.Plane.sevenBrickMap_sectorsAt_tUp
#print axioms HadwigerNelson.Plane.sevenBrickMap_sectorsAt_tDown
#print axioms HadwigerNelson.Plane.isClosed_brickClosedCell
#print axioms HadwigerNelson.Plane.sevenBrickMap_mem_coloursAt
#print axioms HadwigerNelson.Plane.brickClosedCell_same_row
#print axioms HadwigerNelson.Plane.brickClosedCell_rows
#print axioms HadwigerNelson.Plane.tJunction_of_pair
#print axioms HadwigerNelson.Plane.tJunction_of_three
#print axioms HadwigerNelson.Plane.sevenBrickMap_tJunction
#print axioms HadwigerNelson.Plane.sevenBrickMap_condition5
#print axioms HadwigerNelson.Plane.sevenBrickMap_woodallNormal
#print axioms HadwigerNelson.Plane.sevenBrickMap_woodallMerged
#print axioms HadwigerNelson.Plane.sevenBrickMap_woodallModel
#print axioms HadwigerNelson.Plane.sevenBrickMap_thm6Model
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_not_sectorsAt_one
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_not_niceAt_one
#print axioms HadwigerNelson.Plane.ArcMap.zero_mem_threeCuts
#print axioms HadwigerNelson.Plane.ArcMap.puncturedThreeSectorDisc_region
#print axioms HadwigerNelson.Plane.ArcMap.puncturedThreeSectorDisc_coloursAt_zero
#print axioms HadwigerNelson.Plane.ArcMap.puncturedThreeSectorDisc_not_woodallMerged
#print axioms HadwigerNelson.Plane.ArcMap.puncturedThreeSectorDisc_not_woodallNormal


/-! ## FS-131 wave 3 (job FS131-I3b) — the implementer's added children (every one a theorem the rows rest on) -/

#print axioms HadwigerNelson.Plane.sixArcs_finite
#print axioms HadwigerNelson.Plane.dist_polar_sq
#print axioms HadwigerNelson.Plane.arg_polar
#print axioms HadwigerNelson.Plane.norm_polar
#print axioms HadwigerNelson.Plane.norm_e_add_e_sq
#print axioms HadwigerNelson.Plane.one_le_norm_e_add_e
#print axioms HadwigerNelson.Plane.sixFrag_mem_interiorPts
#print axioms HadwigerNelson.Plane.sixCol_sector
#print axioms HadwigerNelson.Plane.zero_mem_closure_region
#print axioms HadwigerNelson.Plane.norm_e_sub_e_sq
#print axioms HadwigerNelson.Plane.no_int_lens
#print axioms HadwigerNelson.Plane.no_int_radial
#print axioms HadwigerNelson.Plane.norm_e_sub_lens_ne
#print axioms HadwigerNelson.Plane.sin_eq_zero_of_mem_radial
#print axioms HadwigerNelson.Plane.e_notMem_lens_union
#print axioms HadwigerNelson.Plane.dist_polar_same
#print axioms HadwigerNelson.Plane.sixCol_inner_zero
#print axioms HadwigerNelson.Plane.sixCol_outer_two
#print axioms HadwigerNelson.Plane.CircleColouring.mem_S_add_int
#print axioms HadwigerNelson.Plane.CircleColouring.S_inter_Icc_finite
#print axioms HadwigerNelson.Plane.CircleColouring.eventually_notMem_S
#print axioms HadwigerNelson.Plane.CircleColouring.eventually_notMem_S_lt
#print axioms HadwigerNelson.Plane.CircleColouring.eventually_notMem_S_gt
#print axioms HadwigerNelson.Plane.CircleColouring.const_on_Ioo
#print axioms HadwigerNelson.Plane.CircleColouring.const_of_local
#print axioms HadwigerNelson.Plane.CircleColouring.exists_good_near
#print axioms HadwigerNelson.Plane.CircleColouring.Good.notMem
#print axioms HadwigerNelson.Plane.CircleColouring.Good.hex_notMem
#print axioms HadwigerNelson.Plane.CircleColouring.exists_left_const
#print axioms HadwigerNelson.Plane.CircleColouring.exists_right_const
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.exists_sides
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.Sides.unique
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.Sides.vals
#print axioms HadwigerNelson.Plane.CircleColouring.LeftVal.unique
#print axioms HadwigerNelson.Plane.CircleColouring.RightVal.unique
#print axioms HadwigerNelson.Plane.CircleColouring.eventually_lt_add
#print axioms HadwigerNelson.Plane.CircleColouring.eventually_gt_add
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.Sides.periodic
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.W_eq_aux
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.D0_mod_ne
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.D_eq_D0
#print axioms HadwigerNelson.Plane.CircleColouring.step_cast
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.D_mod_ne_good
#print axioms HadwigerNelson.Plane.CircleColouring.Lift.hex_summary
#print axioms HadwigerNelson.Plane.CircleColouring.liftB_fin
#print axioms HadwigerNelson.Plane.CircleColouring.liftB_add
#print axioms HadwigerNelson.Plane.CircleColouring.liftB_of_le
#print axioms HadwigerNelson.Plane.CircleColouring.liftA_sub
#print axioms HadwigerNelson.Plane.CircleColouring.liftB_empty
#print axioms HadwigerNelson.Plane.CircleColouring.liftB_single
#print axioms HadwigerNelson.Plane.CircleColouring.D_eq_sub
#print axioms HadwigerNelson.Plane.CircleColouring.hex_near
#print axioms HadwigerNelson.Plane.CircleColouring.m_eq_near
#print axioms HadwigerNelson.Plane.CircleColouring.h_eq_of_m_eq
#print axioms HadwigerNelson.Plane.CircleColouring.m_eq_m0
#print axioms HadwigerNelson.Plane.CircleColouring.D0_near
#print axioms HadwigerNelson.Plane.CircleColouring.m0_const
#print axioms HadwigerNelson.Plane.CircleColouring.exists_M
#print axioms HadwigerNelson.Plane.CircleColouring.D0_eq
#print axioms HadwigerNelson.Plane.CircleColouring.exists_T0_left
#print axioms HadwigerNelson.Plane.CircleColouring.exists_T0_right
#print axioms HadwigerNelson.Plane.CircleColouring.hbig_of_noPair
#print axioms HadwigerNelson.Plane.CircleColouring.hbig_of_noSwap
#print axioms HadwigerNelson.Plane.CircleColouring.J_eq_of_rho
#print axioms HadwigerNelson.Plane.CircleColouring.rho_const
#print axioms HadwigerNelson.Plane.CircleColouring.jump_ne_of_mem
#print axioms HadwigerNelson.Plane.CircleColouring.mem_of_jump_ne
#print axioms HadwigerNelson.Plane.CircleColouring.inv_of_J_eq
#print axioms HadwigerNelson.Plane.CircleColouring.hSum_shift
#print axioms HadwigerNelson.Plane.CircleColouring.ringband_iii'

/-! ## FS-131 wave 3 (job FS131-I3c) — the implementer's added children and the rows' leaves -/

#print axioms HadwigerNelson.Plane.mem_arcs_rot
#print axioms HadwigerNelson.Plane.rot_mem_interiorPts
#print axioms HadwigerNelson.Plane.sixPair_gg
#print axioms HadwigerNelson.Plane.sixPair_ss
#print axioms HadwigerNelson.Plane.sixPair_gRe
#print axioms HadwigerNelson.Plane.sixPair_qg
#print axioms HadwigerNelson.Plane.sixPair_qf
#print axioms HadwigerNelson.Plane.sixPair_qq
#print axioms HadwigerNelson.Plane.sixPair_sg
#print axioms HadwigerNelson.Plane.sixPair_sq
#print axioms HadwigerNelson.Plane.sixPair_gg'
#print axioms HadwigerNelson.Plane.dist_lt_one_iff_arg
#print axioms HadwigerNelson.Plane.one_lt_dist_iff_arg
#print axioms HadwigerNelson.Plane.floor_arg_bounds
#print axioms HadwigerNelson.Plane.sixCol_zero_cases
#print axioms HadwigerNelson.Plane.dist_sq_re_im
#print axioms HadwigerNelson.Plane.e_re_im
#print axioms HadwigerNelson.Plane.cos_five_pi_div_six
#print axioms HadwigerNelson.Plane.sin_five_pi_div_six
#print axioms HadwigerNelson.Plane.dist_e_neg_five_pi_div_six_sq
#print axioms HadwigerNelson.Plane.dist_e_neg_pi_div_two_sq
#print axioms HadwigerNelson.Plane.dist_e_pi_div_two_sq
#print axioms HadwigerNelson.Plane.sixPieceS_coords
#print axioms HadwigerNelson.Plane.sixPieceQ_coords
#print axioms HadwigerNelson.Plane.sixPieceG_coords
#print axioms HadwigerNelson.Plane.one_lt_dist_of_sq
#print axioms HadwigerNelson.Plane.dist_sq_polar
#print axioms HadwigerNelson.Plane.sixPieceS_diam
#print axioms HadwigerNelson.Plane.sixPieceS_sixPieceQ
#print axioms HadwigerNelson.Plane.sixPieceS_sixPieceG
#print axioms HadwigerNelson.Plane.sixPieceQ_sixPieceG
#print axioms HadwigerNelson.Plane.sixPieceG_near
#print axioms HadwigerNelson.Plane.sixPieceG_diam
#print axioms HadwigerNelson.Plane.dist_ne_one_of_isOpen
#print axioms HadwigerNelson.Plane.sixLensQ0_diam
#print axioms HadwigerNelson.Plane.sixPieceQ_ne_one
#print axioms HadwigerNelson.Plane.sixFrag_valid_zero
#print axioms HadwigerNelson.Plane.sixCol_rot_to_zero
#print axioms HadwigerNelson.Plane.e_add_e_eq
#print axioms HadwigerNelson.Plane.exists_int_arg_eq
#print axioms HadwigerNelson.Plane.sixArcs_polar
#print axioms HadwigerNelson.Plane.int_lt_of_mul_pi_lt
#print axioms HadwigerNelson.Plane.sixPieceQ_interior
#print axioms HadwigerNelson.Plane.sixPieceG_interior
#print axioms HadwigerNelson.Plane.isPreconnected_polarBand
#print axioms HadwigerNelson.Plane.mem_polarBand
#print axioms HadwigerNelson.Plane.polarBand_bounds
#print axioms HadwigerNelson.Plane.sixPieceS_connected
#print axioms HadwigerNelson.Plane.sixPieceQ_connected
#print axioms HadwigerNelson.Plane.sixGAngles_ordConnected
#print axioms HadwigerNelson.Plane.sixPieceG_connected
#print axioms HadwigerNelson.Plane.sixFrag_connected_of_zero
#print axioms HadwigerNelson.Plane.ArcMap.changePoint_germs
#print axioms HadwigerNelson.Plane.ArcMap.tile_subset_closedBall_of_cone
#print axioms HadwigerNelson.Plane.ArcMap.outward_of_cone
#print axioms HadwigerNelson.Plane.ArcMap.changePoint_germs_out
#print axioms HadwigerNelson.Plane.ArcMap.exists_near_of_mem_closure_isOpen
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_closure_of_four_germs
#print axioms HadwigerNelson.Plane.ArcMap.exists_germ_interior
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.ringArc_subset_closure
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.eq_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.germ_absent_class
#print axioms HadwigerNelson.Plane.ArcMap.mem_ringArc_of_germIn
#print axioms HadwigerNelson.Plane.ArcMap.IsJordanDomain.local_connected
#print axioms HadwigerNelson.Plane.e_mul_e_sub_pi
#print axioms HadwigerNelson.Plane.mul_e_of_arg
#print axioms HadwigerNelson.Plane.arg_side
#print axioms HadwigerNelson.Plane.arg_near
#print axioms HadwigerNelson.Plane.exists_shift_Ico
#print axioms HadwigerNelson.Plane.periodic_int
#print axioms HadwigerNelson.Plane.exists_angleIcc_of_no_gap
#print axioms HadwigerNelson.Plane.isClosed_coneAt
#print axioms HadwigerNelson.Plane.mem_coneAt_of_mem_isOpen
#print axioms HadwigerNelson.Plane.coneAt_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.IsJordanDomain.coneAt_eq_angleIcc
#print axioms HadwigerNelson.Plane.ArcMap.e_third_eq
#print axioms HadwigerNelson.Plane.ArcMap.Valid.not_mem_closure_of_side
#print axioms HadwigerNelson.Plane.ArcMap.dist_ringPt_third
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.not_mem_closure_third
#print axioms HadwigerNelson.Plane.ArcMap.carries_absent
#print axioms HadwigerNelson.Plane.ArcMap.subsingleton_e_eq
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_regularAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_regular_germ
#print axioms HadwigerNelson.Plane.ArcMap.finite_not_regular
#print axioms HadwigerNelson.Plane.ArcMap.absent_subsingleton
#print axioms HadwigerNelson.Plane.ArcMap.exists_regular_pair
#print axioms HadwigerNelson.Plane.ArcMap.qOpen_subset
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_qOpen
#print axioms HadwigerNelson.Plane.ArcMap.qOpen_periodic
#print axioms HadwigerNelson.Plane.ArcMap.qOpen_of_regular
#print axioms HadwigerNelson.Plane.arcLength_apply
#print axioms HadwigerNelson.Plane.arcLength_preimage_add_periodic
#print axioms HadwigerNelson.Plane.ArcMap.mem_angleIcc_of_cos_nonneg_single
#print axioms HadwigerNelson.Plane.ArcMap.cos_nonneg_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.e_sigma_half
#print axioms HadwigerNelson.Plane.ArcMap.initialPiece_cases
#print axioms HadwigerNelson.Plane.ArcMap.sq_norm_pieceB
#print axioms HadwigerNelson.Plane.ArcMap.sq_norm_pieceB'
#print axioms HadwigerNelson.Plane.carrier_circ_unit
#print axioms HadwigerNelson.Plane.Arc.OnRing.carrier_subset_sphere
#print axioms HadwigerNelson.Plane.continuous_polarPt
#print axioms HadwigerNelson.Plane.norm_polarPt_sub
#print axioms HadwigerNelson.Plane.dist_polarPt_ringPt_le
#print axioms HadwigerNelson.Plane.abs_norm_sub_one_le
#print axioms HadwigerNelson.Plane.polar_nbhd
#print axioms HadwigerNelson.Plane.e_eq_e_iff
#print axioms HadwigerNelson.Plane.exists_mem_Icc_e_eq
#print axioms HadwigerNelson.Plane.e_ne_one
#print axioms HadwigerNelson.Plane.dist_ringPt_side_le
#print axioms HadwigerNelson.Plane.dist_lt_of_mem_germ
#print axioms HadwigerNelson.Plane.ringPt_notMem_germ
#print axioms HadwigerNelson.Plane.isPreconnected_germ
#print axioms HadwigerNelson.Plane.sideInterval
#print axioms HadwigerNelson.Plane.exists_germ_subset_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_finite
#print axioms HadwigerNelson.Plane.ArcMap.finite_nonring_inter_sphere
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_onRing
#print axioms HadwigerNelson.Plane.ArcMap.exists_sides_nbhd
#print axioms HadwigerNelson.Plane.ArcMap.sides_const
#print axioms HadwigerNelson.Plane.lens_stepA
#print axioms HadwigerNelson.Plane.lens_stepB
#print axioms HadwigerNelson.Plane.re_e
#print axioms HadwigerNelson.Plane.im_e
#print axioms HadwigerNelson.Plane.sq_norm_eq
#print axioms HadwigerNelson.Plane.e_mul_conj_e
#print axioms HadwigerNelson.Plane.conj_e
#print axioms HadwigerNelson.Plane.lens_core
#print axioms HadwigerNelson.Plane.deriv_nonneg_of_leftmax
#print axioms HadwigerNelson.Plane.re_conj_mul_nonneg_of_exit
#print axioms HadwigerNelson.Plane.im_leftNormal_mul_conj

#print axioms HadwigerNelson.Plane.coneAt_biUnion_finite
#print axioms HadwigerNelson.Plane.coneAt_inter_ball
#print axioms HadwigerNelson.Plane.mem_curveAt_scale
#print axioms HadwigerNelson.Plane.farther_out
#print axioms HadwigerNelson.Plane.circle_step_real
#print axioms HadwigerNelson.Plane.farther_in
#print axioms HadwigerNelson.Plane.exists_farther
#print axioms HadwigerNelson.Plane.re_mul_conj_eq
#print axioms HadwigerNelson.Plane.sq_re_im_ne
#print axioms HadwigerNelson.Plane.eq_of_re_im
#print axioms HadwigerNelson.Plane.perp_circle
#print axioms HadwigerNelson.Plane.curve_inter
#print axioms HadwigerNelson.Plane.curveAt_eq_of_same
#print axioms HadwigerNelson.Plane.Arc.curveData_kappa
#print axioms HadwigerNelson.Plane.Arc.curveData_ne
#print axioms HadwigerNelson.Plane.Arc.carrier_subset_curve
#print axioms HadwigerNelson.Plane.exists_notMem_curveAt
#print axioms HadwigerNelson.Plane.finite_perp_circle
#print axioms HadwigerNelson.Plane.finite_curve_inter_sphere
#print axioms HadwigerNelson.Plane.finite_image_of_locConst
#print axioms HadwigerNelson.Plane.ArcMap.exists_goodAt
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.subset_of_preconnected
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.exists_local_curve
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.not_tile_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.continuous_spherePt
#print axioms HadwigerNelson.Plane.ArcMap.norm_spherePt_sub
#print axioms HadwigerNelson.Plane.ArcMap.spherePt_mem_sphere
#print axioms HadwigerNelson.Plane.ArcMap.injOn_spherePt
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.finite_tiles_sphere
#print axioms HadwigerNelson.Plane.ArcMap.region_inter_ball_subset
#print axioms HadwigerNelson.Plane.invC_invC
#print axioms HadwigerNelson.Plane.invC_re
#print axioms HadwigerNelson.Plane.invC_im
#print axioms HadwigerNelson.Plane.invC_ne_zero
#print axioms HadwigerNelson.Plane.continuousOn_invC
#print axioms HadwigerNelson.Plane.rotD_eq
#print axioms HadwigerNelson.Plane.normSq_rotD
#print axioms HadwigerNelson.Plane.rotD_ne_zero_iff
#print axioms HadwigerNelson.Plane.mem_Rgn_iff
#print axioms HadwigerNelson.Plane.levD_eq
#print axioms HadwigerNelson.Plane.isPreconnected_Rgn_lev
#print axioms HadwigerNelson.Plane.conj_mul_self_e
#print axioms HadwigerNelson.Plane.exists_mem_Rgn_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ray_mem_Rgn
#print axioms HadwigerNelson.Plane.mem_curveAt_iff_rot
#print axioms HadwigerNelson.Plane.nontang_avoid
#print axioms HadwigerNelson.Plane.Rgn_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.exists_wedge
#print axioms HadwigerNelson.Plane.countable_e_preimage
#print axioms HadwigerNelson.Plane.countable_tang_dirs
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.exists_generic_dir
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_interiors_disjoint
#print axioms HadwigerNelson.Plane.e_sub_eq
#print axioms HadwigerNelson.Plane.tang_circ
#print axioms HadwigerNelson.Plane.e_mul_sign
#print axioms HadwigerNelson.Plane.rotD_circ
#print axioms HadwigerNelson.Plane.circ_mem_Rgn
#print axioms HadwigerNelson.Plane.sin_half_ge
#print axioms HadwigerNelson.Plane.circ_gap_aux
#print axioms HadwigerNelson.Plane.circ_gap_false
#print axioms HadwigerNelson.Plane.circ_initialPiece
#print axioms HadwigerNelson.Plane.seg_initialPiece
#print axioms HadwigerNelson.Plane.Arc.exists_initialPiece_of_approach
#print axioms HadwigerNelson.Plane.mem_Rgn_lev_of_Kinv
#print axioms HadwigerNelson.Plane.Rgn_mono
#print axioms HadwigerNelson.Plane.isOpen_Rgn
#print axioms HadwigerNelson.Plane.Arc.InitialPiece.subset_carrier
#print axioms HadwigerNelson.Plane.conj_ne_zero_of_norm
#print axioms HadwigerNelson.Plane.u_conj_u
#print axioms HadwigerNelson.Plane.levD_eq_of_mem_curve
#print axioms HadwigerNelson.Plane.mem_levCurve
#print axioms HadwigerNelson.Plane.isClosed_curveAt
#print axioms HadwigerNelson.Plane.exists_pt_off_levels
#print axioms HadwigerNelson.Plane.ArcMap.exists_initialPiece_of_cone
#print axioms HadwigerNelson.Plane.e_add_int_mul_two_pi
#print axioms HadwigerNelson.Plane.inSixLens_add_six
#print axioms HadwigerNelson.Plane.dist_polar_lt_one_iff
#print axioms HadwigerNelson.Plane.dist_polar_eq_one_iff
#print axioms HadwigerNelson.Plane.eq_norm_mul_e_arg
#print axioms HadwigerNelson.Plane.exists_int_abs_lt_of_half_lt_cos
#print axioms HadwigerNelson.Plane.sixRound_of_lens
#print axioms HadwigerNelson.Plane.sixCol_of_lens
#print axioms HadwigerNelson.Plane.e_pi_div_six
#print axioms HadwigerNelson.Plane.e_neg_pi_div_six
#print axioms HadwigerNelson.Plane.re_nonneg_aux
#print axioms HadwigerNelson.Plane.lens_boundary_core
#print axioms HadwigerNelson.Plane.exists_fin_six_rep
#print axioms HadwigerNelson.Plane.mem_arcs_side₁
#print axioms HadwigerNelson.Plane.mem_arcs_side₂
#print axioms HadwigerNelson.Plane.e_zero
#print axioms HadwigerNelson.Plane.dist_rot
#print axioms HadwigerNelson.Plane.mem_arcs_of_lens_boundary₁
#print axioms HadwigerNelson.Plane.mem_arcs_of_lens_boundary₂
#print axioms HadwigerNelson.Plane.mem_arcs_of_norm_eq_one
#print axioms HadwigerNelson.Plane.mem_arcs_radial
#print axioms HadwigerNelson.Plane.inSixLens_reduce
#print axioms HadwigerNelson.Plane.exists_one_lt_dist_of_not_lens
#print axioms HadwigerNelson.Plane.eventually_floor_arg
#print axioms HadwigerNelson.Plane.e_ne_zero'
#print axioms HadwigerNelson.Plane.dist_rot_left
#print axioms HadwigerNelson.Plane.exists_int_of_e_eq_e
#print axioms HadwigerNelson.Plane.arg_rot
#print axioms HadwigerNelson.Plane.inSixLens_rot
#print axioms HadwigerNelson.Plane.sixCol_rot
#print axioms HadwigerNelson.Plane.ArcMap.exists_lift_of_Icc_subset_angleIcc
#print axioms HadwigerNelson.Plane.ArcMap.cone_region_tile
#print axioms HadwigerNelson.Plane.ArcMap.overlap_false
#print axioms HadwigerNelson.Plane.ArcMap.disj_lifts
#print axioms HadwigerNelson.Plane.ArcMap.add_notMem_angleIcc
#print axioms HadwigerNelson.Plane.ArcMap.sub_notMem_angleIcc

/-! ## FS-131 wave 2's foundation (job FS131-K2) — covers, partial colourings and the suprema, CP colourings

`Plane/Cover.lean`, `Plane/Suprema.lean`, `Plane/CPColouring.lean`: families of classes (admissible and maximal covers,
selections, saturation), the inhabitant `sq9`, upper density and the four suprema `µ_k`, slack and tightness, CP
colourings and `χ_CP`. Definitions and their spec lemmas; no backlog row. No native evaluation. -/

#print axioms HadwigerNelson.Plane.AeColouring.measurableSet_cls
#print axioms HadwigerNelson.Plane.AeColouring.iUnion_cls
#print axioms HadwigerNelson.Plane.AeColouring.pairwise_disjoint_cls
#print axioms HadwigerNelson.Plane.AeColouring.isAeCover
#print axioms HadwigerNelson.Plane.measurable_sq9Col
#print axioms HadwigerNelson.Plane.abs_sub_lt_half_or_one_lt_of_sq9Index_eq
#print axioms HadwigerNelson.Plane.sq9Col_ne_of_dist_eq_one
#print axioms HadwigerNelson.Plane.sq9
#print axioms HadwigerNelson.Plane.volume_ball_ne_zero
#print axioms HadwigerNelson.Plane.upperDensity_univ
#print axioms HadwigerNelson.Plane.upperDensity_empty
#print axioms HadwigerNelson.Plane.AeColouring.isPartialColouring
#print axioms HadwigerNelson.Plane.one_le_muZero
#print axioms HadwigerNelson.Plane.upperDensity_ball_one
#print axioms HadwigerNelson.Plane.measurable_shiftCol
#print axioms HadwigerNelson.Plane.measurable_rotCol
#print axioms HadwigerNelson.Plane.chiCP_le

/-! ## FS-131 wave 2 — covers, suprema, the equivalence, Falconer's reduction, place homomorphisms (skeleton until its implementer lands it) -/

#print axioms HadwigerNelson.Plane.AeColouring.exists_fill
#print axioms HadwigerNelson.Plane.AeColouring.exists_isMaximalCover
#print axioms HadwigerNelson.Plane.IsMaximalCover.interior_union_unitShadow
#print axioms HadwigerNelson.Plane.IsAdmissible.exists_aeColouring
#print axioms HadwigerNelson.Plane.isMaximalCover_iff
#print axioms HadwigerNelson.Plane.IsRegularMUA.interior_eq_compl_unitShadow
#print axioms HadwigerNelson.Plane.IsRegularMUA.component_side
#print axioms HadwigerNelson.Plane.IsMaximalCover.enclosing_or_exterior
#print axioms HadwigerNelson.Plane.IsMaximalCover.curvatureLeOne
#print axioms HadwigerNelson.Plane.IsMaximalCover.semiconcaveWith
#print axioms HadwigerNelson.Plane.AeColouring.exists_grundy
#print axioms HadwigerNelson.Plane.AeColouring.exists_tight
#print axioms HadwigerNelson.Plane.exists_tight_iff_chiM0_le
#print axioms HadwigerNelson.Plane.tendsto_mu
#print axioms HadwigerNelson.Plane.tendsto_muTile
#print axioms HadwigerNelson.Plane.tendsto_muPer
#print axioms HadwigerNelson.Plane.chiM0_le_chiCP
#print axioms HadwigerNelson.Plane.chiM0_le_iff_muZero_eq_one
#print axioms HadwigerNelson.Plane.chiM0_le_iff_chiCP_le
#print axioms HadwigerNelson.Plane.muZero_eq_one_iff_tendsto
#print axioms HadwigerNelson.Plane.chiM0_le_iff_periodic
#print axioms HadwigerNelson.Plane.seven_le_chiM0_iff
#print axioms HadwigerNelson.Plane.exists_bandNull_aeCover_of_mu_eq_one
#print axioms HadwigerNelson.Plane.forall_mu_six_lt_one_iff
#print axioms HadwigerNelson.Plane.keptAt_band
#print axioms HadwigerNelson.Plane.CPColouring.tendsto_not_kept
#print axioms HadwigerNelson.Plane.exists_not_uniform_kept
#print axioms HadwigerNelson.Plane.face
#print axioms HadwigerNelson.Plane.face_densitySet
#print axioms HadwigerNelson.Plane.exists_face_fails
#print axioms HadwigerNelson.Plane.nonempty_cpColouring_nine
#print axioms HadwigerNelson.Plane.CPColouring.exists_discrete_forcedSet
#print axioms HadwigerNelson.Plane.CPColouring.forcedSet_eq_zero
#print axioms HadwigerNelson.Plane.twoCircle_preimage_null
#print axioms HadwigerNelson.Plane.falconer_lemma1
#print axioms HadwigerNelson.Plane.chromaticNumber_plane_le_chiM0
#print axioms HadwigerNelson.Plane.chiM0_le_of_fragments
#print axioms HadwigerNelson.Plane.chromaticNumber_plane_le_six_of_fragments
#print axioms HadwigerNelson.Plane.sq9_tight_saturated
#print axioms HadwigerNelson.Plane.tri
#print axioms HadwigerNelson.Plane.triCoord
#print axioms HadwigerNelson.Plane.triQ
#print axioms HadwigerNelson.Plane.triCoord_add_mul
#print axioms HadwigerNelson.Plane.normSq_add_mul
#print axioms HadwigerNelson.Plane.r7UpCol
#print axioms HadwigerNelson.Plane.r7DownCol
#print axioms HadwigerNelson.Plane.r7ColTri
#print axioms HadwigerNelson.Plane.r7Col
#print axioms HadwigerNelson.Plane.r7Cls
#print axioms HadwigerNelson.Plane.r7Col_add_mul
#print axioms HadwigerNelson.Plane.r7_aeColouring
#print axioms HadwigerNelson.Plane.r7_not_bandNull
#print axioms HadwigerNelson.Plane.r7Cls_saturated
#print axioms HadwigerNelson.Plane.exists_r7
#print axioms HadwigerNelson.Plane.r7_boundary
#print axioms HadwigerNelson.Plane.r7Cls_isMaximalCover
#print axioms HadwigerNelson.Plane.r7_lowerGraph
#print axioms HadwigerNelson.Plane.not_semiconcaveWith_one_lowerArc
#print axioms HadwigerNelson.Plane.not_forall_semiconcaveWith_one
#print axioms HadwigerNelson.Plane.disc7Centre
#print axioms HadwigerNelson.Plane.disc7Col
#print axioms HadwigerNelson.Plane.disc7
#print axioms HadwigerNelson.Plane.disc7_isMaximalCover
#print axioms HadwigerNelson.Plane.disc7_isRegularMUA
#print axioms HadwigerNelson.Plane.disc7_lens
#print axioms HadwigerNelson.Plane.disc7_upperDensity
#print axioms HadwigerNelson.Plane.disc7_sum_upperDensity
#print axioms HadwigerNelson.Plane.IsMUA.add_normal_mem_essSupport
#print axioms HadwigerNelson.Plane.band_excludes_horn
#print axioms HadwigerNelson.Plane.le_one_of_band_unitFree
#print axioms HadwigerNelson.Plane.vesica_apex
#print axioms HadwigerNelson.Plane.vesica_apex_exact
#print axioms HadwigerNelson.Plane.hcL
#print axioms HadwigerNelson.Plane.hcFace
#print axioms HadwigerNelson.Plane.hcUpC
#print axioms HadwigerNelson.Plane.hcDownC
#print axioms HadwigerNelson.Plane.hcUpTri
#print axioms HadwigerNelson.Plane.hcDownTri
#print axioms HadwigerNelson.Plane.hcFrame
#print axioms HadwigerNelson.Plane.hcFrameS
#print axioms HadwigerNelson.Plane.hcFrameT
#print axioms HadwigerNelson.Plane.hcUp
#print axioms HadwigerNelson.Plane.hcBandTop
#print axioms HadwigerNelson.Plane.hcBand
#print axioms HadwigerNelson.Plane.hcSet
#print axioms HadwigerNelson.Plane.G1Bounds
#print axioms HadwigerNelson.Plane.hcGap
#print axioms HadwigerNelson.Plane.g1Bounds_hcGap
#print axioms HadwigerNelson.Plane.hcZ0
#print axioms HadwigerNelson.Plane.hcZ0_spec
#print axioms HadwigerNelson.Plane.hc_isRegularMUA
#print axioms HadwigerNelson.Plane.hc_band_components
#print axioms HadwigerNelson.Plane.fatR
#print axioms HadwigerNelson.Plane.fatZ
#print axioms HadwigerNelson.Plane.fatZ_spec
#print axioms HadwigerNelson.Plane.exists_isMUA_ae_le
#print axioms HadwigerNelson.Plane.hc_irreg
#print axioms HadwigerNelson.Plane.not_forall_isRegularMUA
#print axioms HadwigerNelson.Plane.not_forall_fix_converse
#print axioms HadwigerNelson.Arith.exists_placeHom
#print axioms HadwigerNelson.Arith.noAffine_fields
#print axioms HadwigerNelson.Arith.falconerFan_five_field
#print axioms HadwigerNelson.Arith.falconerFan_five_placeHom
#print axioms HadwigerNelson.Arith.not_falconerFan_five_of_fanGap
#print axioms HadwigerNelson.Arith.falconerFan_five_mem_eight
#print axioms HadwigerNelson.Arith.falconerFan_five_mem_P
#print axioms HadwigerNelson.Arith.sqrt3_local_of_congr
#print axioms HadwigerNelson.Arith.sqrt3_local
#print axioms HadwigerNelson.Arith.sqrt3_dyadic

/-! ## FS-131 wave 2 — children stated by the implementer (FS131-I2) -/

#print axioms HadwigerNelson.Plane.volume_prod_shift_null
#print axioms HadwigerNelson.Plane.UnitPairsNull.congr_ae
#print axioms HadwigerNelson.Plane.exists_ae_maximal
#print axioms HadwigerNelson.Plane.essSupport_eq_support
#print axioms HadwigerNelson.Plane.isClosed_essSupport
#print axioms HadwigerNelson.Plane.volume_diff_essSupport
#print axioms HadwigerNelson.Plane.essSupport_mono_ae
#print axioms HadwigerNelson.Plane.exists_annulus_subset_compl
#print axioms HadwigerNelson.Plane.IsMUA.interior_union_unitShadow
#print axioms HadwigerNelson.Plane.ae_restrict_mem_densitySet
#print axioms HadwigerNelson.Plane.volume_diff_densitySet
#print axioms HadwigerNelson.Plane.upperDensityAt_eq_zero_of_null
#print axioms HadwigerNelson.Plane.essSupport_eq_closure_densitySet
#print axioms HadwigerNelson.Plane.subset_densitySet_of_isOpen_ae_subset
#print axioms HadwigerNelson.Plane.upperDensity_le_one
#print axioms HadwigerNelson.Plane.mu_le_one
#print axioms HadwigerNelson.Plane.antitone_mu
#print axioms HadwigerNelson.Plane.muZero_le_one


/-! ## FS-131 wave 2 — children stated by FS131-I2b -/

#print axioms HadwigerNelson.Plane.preimage_inter_null_of_invertible_deriv
#print axioms HadwigerNelson.Plane.hasDerivAt_e
#print axioms HadwigerNelson.Plane.contDiff_e
#print axioms HadwigerNelson.Plane.contDiff_twoCircleMap
#print axioms HadwigerNelson.Plane.hasFDerivAt_twoCircleMap
#print axioms HadwigerNelson.Plane.twoCircleDeriv_injective
#print axioms HadwigerNelson.Plane.volume_sinZero_null
#print axioms HadwigerNelson.Plane.self_eq_norm_mul_e_arg
#print axioms HadwigerNelson.Plane.slice_slice_null
#print axioms HadwigerNelson.Plane.CPColouring.law_shift
#print axioms HadwigerNelson.Plane.CPColouring.measurableSet_eq
#print axioms HadwigerNelson.Plane.CPColouring.law_eq_translate
#print axioms HadwigerNelson.Plane.CPColouring.law_ne_triangle
#print axioms HadwigerNelson.Plane.CPColouring.law_ne_eq
#print axioms HadwigerNelson.Plane.CPColouring.isClosed_forcedSet
#print axioms HadwigerNelson.Plane.CPColouring.law_eq_one_iff
#print axioms HadwigerNelson.Plane.exists_pos_forall_norm_lt_eq_zero
#print axioms HadwigerNelson.Plane.AeColouring.volume_badAngles_null
#print axioms HadwigerNelson.Plane.AeColouring.exists_motion
#print axioms HadwigerNelson.Plane.IsMaximalCover.enclosing_or_exterior_contact

#print axioms HadwigerNelson.Plane.disc7_nbr
#print axioms HadwigerNelson.Plane.lens_pos
#print axioms HadwigerNelson.Plane.norm_tri_sub
#print axioms HadwigerNelson.Plane.unitPairsNull_of_bandFree
#print axioms HadwigerNelson.Plane.upperDensityAt_pos_of_halfBox
#print axioms HadwigerNelson.Plane.bandNull_of_bandFree
#print axioms HadwigerNelson.Plane.voronov11_of_forall_mu_lt
#print axioms HadwigerNelson.Plane.mu_lt_of_voronov11
#print axioms HadwigerNelson.Plane.sq9Index_periodic
#print axioms HadwigerNelson.Plane.cIdx
#print axioms HadwigerNelson.Plane.cIdx_coe
#print axioms HadwigerNelson.Plane.torPt_add
#print axioms HadwigerNelson.Plane.torCol_coe
#print axioms HadwigerNelson.Plane.torCol_pt_add
#print axioms HadwigerNelson.Plane.exists_coe_eq
#print axioms HadwigerNelson.Plane.measurable_cIdx
#print axioms HadwigerNelson.Plane.measurable_torCol
#print axioms HadwigerNelson.Plane.torField
#print axioms HadwigerNelson.Plane.measurable_torField
#print axioms HadwigerNelson.Plane.torField_shift
#print axioms HadwigerNelson.Plane.volume_tor_univ
#print axioms HadwigerNelson.Plane.cpLaw
#print axioms HadwigerNelson.Plane.cpLaw_apply
#print axioms HadwigerNelson.Plane.cpLaw_map_shift
#print axioms HadwigerNelson.Plane.vol_tor_shift
#print axioms HadwigerNelson.Plane.halfPts
#print axioms HadwigerNelson.Plane.volume_halfPts
#print axioms HadwigerNelson.Plane.sq9Index_eventually
#print axioms HadwigerNelson.Plane.isProbabilityMeasure_cpLaw
#print axioms HadwigerNelson.Plane.torField_eq
#print axioms HadwigerNelson.Plane.cpLaw_proper
#print axioms HadwigerNelson.Plane.torChange
#print axioms HadwigerNelson.Plane.measurableSet_torChange
#print axioms HadwigerNelson.Plane.tendsto_volume_torChange
#print axioms HadwigerNelson.Plane.cpLaw_tendsto
#print axioms HadwigerNelson.Plane.r7ColTri_zero
#print axioms HadwigerNelson.Plane.triCoord_frame
#print axioms HadwigerNelson.Plane.r7ColTri_four
#print axioms HadwigerNelson.Plane.triQ_far_gt
#print axioms HadwigerNelson.Plane.triQ_frame
#print axioms HadwigerNelson.Plane.second_order_of_local_max
#print axioms HadwigerNelson.Plane.touch_conditions
#print axioms HadwigerNelson.Plane.dist_frame
#print axioms HadwigerNelson.Plane.exists_frame_coords
#print axioms HadwigerNelson.Plane.le_zero_of_forall_small
#print axioms HadwigerNelson.Plane.ge_zero_of_forall_small
#print axioms HadwigerNelson.Plane.continuous_frameMap
#print axioms HadwigerNelson.Plane.abs_deriv_le_of_touch_below
#print axioms HadwigerNelson.Plane.semiconcave_pos
#print axioms HadwigerNelson.Plane.sq9Col_of_floor
#print axioms HadwigerNelson.Plane.sq9_not_bandNull
#print axioms HadwigerNelson.Plane.sq9_tight


-- FS131-K2c: wave 2 children (sorry until the implementer closes them)
#print axioms HadwigerNelson.Plane.CPColouring.law_ne_shift
#print axioms HadwigerNelson.Plane.essClosure_subset_essSupport
#print axioms HadwigerNelson.Plane.volume_densitySet_diff
#print axioms HadwigerNelson.Plane.arcLength_ball_ge
#print axioms HadwigerNelson.Plane.arcLength_sub_ball_le
#print axioms HadwigerNelson.Plane.arcLength_bigBall_ge
#print axioms HadwigerNelson.Plane.pairs_le_of_arc
#print axioms HadwigerNelson.Plane.twoBall_pairs_ge
#print axioms HadwigerNelson.Plane.essClosure_dist_ne_one_of_mem_densitySet
#print axioms HadwigerNelson.Plane.measurableSet_densitySet
#print axioms HadwigerNelson.Plane.exists_ne_mem_essClosure
#print axioms HadwigerNelson.Plane.bandNull_iff_iccPairNull
#print axioms HadwigerNelson.Plane.IccPairNull.mono
#print axioms HadwigerNelson.Plane.IccPairNull.union
#print axioms HadwigerNelson.Plane.volume_prod_dist_eq_null
#print axioms HadwigerNelson.Plane.iccPairNull_of_forall_lt
#print axioms HadwigerNelson.Plane.unitPairsNull_iff_pairMass
#print axioms HadwigerNelson.Plane.continuous_pairMass
#print axioms HadwigerNelson.Plane.ae_pairMass_eq_zero
#print axioms HadwigerNelson.Plane.pairMass_eq_zero_of_iccPairNull
#print axioms HadwigerNelson.Plane.iccPairNull_preimage_mul
#print axioms HadwigerNelson.Plane.AeColouring.exists_rescale
#print axioms HadwigerNelson.Plane.AeColouring.exists_pos_not_iccPairNull
#print axioms HadwigerNelson.Plane.bandNull_unitPairsNull
#print axioms HadwigerNelson.Plane.mu_le_muZero
#print axioms HadwigerNelson.Plane.muTile_le_mu
#print axioms HadwigerNelson.Plane.muPer_le_muTile
#print axioms HadwigerNelson.Plane.exists_squareWin_dense
#print axioms HadwigerNelson.Plane.ae_eventually_keptAt
#print axioms HadwigerNelson.Plane.keptAt_of_dist_le
#print axioms HadwigerNelson.Plane.isPeriodicSet_periodize
#print axioms HadwigerNelson.Plane.measurableSet_periodize
#print axioms HadwigerNelson.Plane.isGridUnion_periodize
#print axioms HadwigerNelson.Plane.bandFree_periodize
#print axioms HadwigerNelson.Plane.disjoint_periodize
#print axioms HadwigerNelson.Plane.iUnion_periodize
#print axioms HadwigerNelson.Plane.upperDensity_of_periodic
#print axioms HadwigerNelson.Plane.upperDensity_periodize
#print axioms HadwigerNelson.Plane.exists_tiled_kept
#print axioms HadwigerNelson.Plane.eventually_le_muPer
#print axioms HadwigerNelson.Plane.keptAt_band_le_half
#print axioms HadwigerNelson.Plane.not_keptAt_of_half_lt
#print axioms HadwigerNelson.Plane.CPColouring.exists_unif
#print axioms HadwigerNelson.Plane.dist_gridPoint_lt
#print axioms HadwigerNelson.Plane.measurable_eval_gridPoint
#print axioms HadwigerNelson.Plane.CPColouring.exists_modification
#print axioms HadwigerNelson.Plane.CPColouring.ae_unitPairsNull_of_modification
#print axioms HadwigerNelson.Plane.CPColouring.lintegral_ball_ne
#print axioms HadwigerNelson.Plane.exists_weakStar_subseq
#print axioms HadwigerNelson.Plane.convForm_tendsto
#print axioms HadwigerNelson.Plane.exists_twoCircle_density
#print axioms HadwigerNelson.Plane.integral_circleAvg_sq
#print axioms HadwigerNelson.Plane.unitForm_tendsto
#print axioms HadwigerNelson.Plane.exists_translates_small_hole
#print axioms HadwigerNelson.Plane.ae_sum_eq_one_of_weakStar
#print axioms HadwigerNelson.Plane.exists_selection
#print axioms HadwigerNelson.Plane.bandNull_preimage_add
#print axioms HadwigerNelson.Plane.unitPairsNull_preimage_add
#print axioms HadwigerNelson.Plane.exists_faceFailClass_noUnitPairs
#print axioms HadwigerNelson.Plane.exists_aeColouring_of_noUnitPairs
#print axioms HadwigerNelson.Plane.measurableSet_faceFailClass
#print axioms HadwigerNelson.Plane.add_e_mem_essSupport_faceFailClass
#print axioms HadwigerNelson.Plane.not_unitPairsNull_of_circles_meet
#print axioms HadwigerNelson.Plane.isOpen_halfBox
#print axioms HadwigerNelson.Plane.isOpen_farBox
#print axioms HadwigerNelson.Plane.circles_meet_halfBox
#print axioms HadwigerNelson.Plane.circles_meet_boxes_at_normal
#print axioms HadwigerNelson.Arith.x2x1_separable_irreducible_iff
#print axioms HadwigerNelson.Arith.card_quot_eq_two_pow
#print axioms HadwigerNelson.Arith.exists_span_four_eq
#print axioms HadwigerNelson.Arith.exists_sq_sub_three_mem_pow
#print axioms HadwigerNelson.Arith.exists_dyadic_coeffs
#print axioms HadwigerNelson.Arith.exists_root_quadratic
#print axioms HadwigerNelson.Arith.minpoly_eq_of_root
#print axioms HadwigerNelson.Arith.comap_conductor_sup_eq_top
#print axioms HadwigerNelson.Arith.dyadicConclusion_of_minpoly
#print axioms HadwigerNelson.Arith.dyadicConclusion_of_coeffs
#print axioms HadwigerNelson.Plane.upperHalfPlane_falconer_hyp
#print axioms HadwigerNelson.Plane.densitySet_dist_ne_one
#print axioms HadwigerNelson.Plane.two_classes_of_mem_falconerE
#print axioms HadwigerNelson.Plane.dist_circle_rotate
#print axioms HadwigerNelson.Plane.not_rotate_ae_eq_compl
#print axioms HadwigerNelson.Plane.falconer_lemma4
-- FS131-IF1: `[Falconer1981]` Lemma 2 (i) proved (`Plane/MetricalBoundary`); the axiom `falconer_lemma2_nonempty` is a theorem,
-- and the four records that rested on it moved here from IMPORTED
#print axioms HadwigerNelson.Plane.measure_inter_closedBall_le_add
#print axioms HadwigerNelson.Plane.tendsto_measure_closedBall_sub
#print axioms HadwigerNelson.Plane.continuous_measure_inter_closedBall
#print axioms HadwigerNelson.Plane.measure_inter_closedBall_div_add_compl
#print axioms HadwigerNelson.Plane.measure_compl_inter_closedBall_div_eq_half
#print axioms HadwigerNelson.Plane.exists_mem_ball_tendsto_ratio
#print axioms HadwigerNelson.Plane.measure_inter_ball_ne_zero_of_ratio_eq_half
#print axioms HadwigerNelson.Plane.exists_closedBall_ratio_eq_half
#print axioms HadwigerNelson.Plane.exists_closedBall_subset_ratio_eq_half
#print axioms HadwigerNelson.Plane.exists_closedBall_ratio_eq_half_of_measure_ne_zero
#print axioms HadwigerNelson.Plane.exists_nested_closedBalls_ratio_eq_half
#print axioms HadwigerNelson.Plane.ratio_two_mul_ge
#print axioms HadwigerNelson.Plane.exists_ratio_ge_and_compl_ge
#print axioms HadwigerNelson.Plane.not_tendsto_ratio_compl_of_ratio_ge
#print axioms HadwigerNelson.Plane.exists_not_tendsto_ratio_and_compl
#print axioms HadwigerNelson.Plane.falconer_lemma2_nonempty
#print axioms HadwigerNelson.Plane.falconer_reduction
#print axioms HadwigerNelson.Plane.le_chiM_of_falconerFan
#print axioms HadwigerNelson.Plane.exists_mem_falconerE
#print axioms HadwigerNelson.Plane.fan_tip_ae_mem
#print axioms HadwigerNelson.Plane.exists_isMaxIn
#print axioms HadwigerNelson.Plane.isMaxIn_maxIn
#print axioms HadwigerNelson.Plane.grundyTaken_eq
#print axioms HadwigerNelson.Plane.grundyCls_isMaxIn
#print axioms HadwigerNelson.Plane.essSupport_subset_unitShadow_of_isMaxIn
#print axioms HadwigerNelson.Plane.ArcMap.measurableSet_region_inter
#print axioms HadwigerNelson.Plane.ArcMap.volume_ball_diff_region
#print axioms HadwigerNelson.Plane.ArcMap.bandFree_region
#print axioms HadwigerNelson.Plane.muZero_eq_one_of_fragments

-- FS131-K2d: wave 2 children (sorry until the implementer closes them; the orbit and slack facts proved)
#print axioms HadwigerNelson.Arith.pureTranscendental_zero
#print axioms HadwigerNelson.Arith.pureTranscendental_succ
#print axioms HadwigerNelson.Arith.algebraicIndependent_init_and_transcendental_last
#print axioms HadwigerNelson.Arith.exists_valuationSubring_localization
#print axioms HadwigerNelson.Arith.exists_residue_localization
#print axioms HadwigerNelson.Arith.placeHom_base
#print axioms HadwigerNelson.Arith.placeHom_step
#print axioms HadwigerNelson.Arith.exists_isPlaceHom
#print axioms HadwigerNelson.Arith.exists_hom_of_isPlaceHom
#print axioms HadwigerNelson.Arith.chromaticNumber_planeOver_pureTranscendental_eq
#print axioms HadwigerNelson.Arith.nonempty_ringEquiv_zmod_of_card
#print axioms HadwigerNelson.Arith.exists_hom_finitePlane_of_card
#print axioms HadwigerNelson.Arith.slack_complete
#print axioms HadwigerNelson.Arith.exists_hom_slack
#print axioms HadwigerNelson.Arith.forall_const_of_hom_slack
#print axioms HadwigerNelson.Arith.not_falconerFan_of_colorable
#print axioms HadwigerNelson.Arith.sub_mem_of_connected
#print axioms HadwigerNelson.Arith.exists_hom_apex
#print axioms HadwigerNelson.Arith.tip_eq_zero_of_tipFree
#print axioms HadwigerNelson.Arith.not_falconerFan_five_of_hom_slack
#print axioms HadwigerNelson.finitePlane7QuotColouring_proper
#print axioms HadwigerNelson.finitePlane7_fanGap
#print axioms HadwigerNelson.finitePlane7_not_fanGap_zero
#print axioms HadwigerNelson.finitePlane7_slack
#print axioms HadwigerNelson.gamma11_orbit
#print axioms HadwigerNelson.gamma19_orbit
#print axioms HadwigerNelson.tipFree_of_orbit
#print axioms HadwigerNelson.finitePlane11_tipFree
#print axioms HadwigerNelson.finitePlane19_tipFree
#print axioms HadwigerNelson.Plane.SaturatedPos.saturated
#print axioms HadwigerNelson.Plane.sq9_essClosure_subset
#print axioms HadwigerNelson.Plane.sq9Sq_subset_essClosure
#print axioms HadwigerNelson.Plane.sq9_mem_edge_of_not_mem_densitySet
#print axioms HadwigerNelson.Plane.sq9_partner
#print axioms HadwigerNelson.Plane.measurable_r7Col
#print axioms HadwigerNelson.Plane.r7Col_mem_tile
#print axioms HadwigerNelson.Plane.r7UpCol_ne_r7DownCol
#print axioms HadwigerNelson.Plane.r7Up_unitPair
#print axioms HadwigerNelson.Plane.r7Up_sep
#print axioms HadwigerNelson.Plane.r7Down_dist_ne_one
#print axioms HadwigerNelson.Plane.r7_unitPair_mem_sphere
#print axioms HadwigerNelson.Plane.unitPairsNull_of_unitPair_mem
#print axioms HadwigerNelson.Plane.volume_iUnion_sphere_tri
#print axioms HadwigerNelson.Plane.measurableSet_r7Cls
#print axioms HadwigerNelson.Plane.r7_boundary_lattice
#print axioms HadwigerNelson.Plane.r7_boundary_offLattice
#print axioms HadwigerNelson.Plane.r7_phi_pos_up
#print axioms HadwigerNelson.Plane.r7_phi_pos_down
#print axioms HadwigerNelson.Plane.measurableSet_disc7
#print axioms HadwigerNelson.Plane.disc7Col_eq_dist_ge
#print axioms HadwigerNelson.Plane.disc7_unitPair_mem_sphere
#print axioms HadwigerNelson.Plane.disc7_cover
#print axioms HadwigerNelson.Plane.disc7_colour_near
#print axioms HadwigerNelson.Plane.phi_closedBall_pos
#print axioms HadwigerNelson.Plane.disc7_isMUA
#print axioms HadwigerNelson.Plane.essSupport_disc7
#print axioms HadwigerNelson.Plane.volume_frontier_disc7
#print axioms HadwigerNelson.Plane.disc7_periodic
#print axioms HadwigerNelson.Plane.volume_disc7_cell
#print axioms HadwigerNelson.Plane.disc7_linearIndependent
#print axioms HadwigerNelson.Plane.IsMUA.exists_shadow_point
#print axioms HadwigerNelson.Plane.circle_meets_halfBox_of_ne
#print axioms HadwigerNelson.Plane.hcGap_eq_of_gap
#print axioms HadwigerNelson.Plane.differentiable_hcGap
#print axioms HadwigerNelson.Plane.hcGap_bounds
#print axioms HadwigerNelson.Plane.hcGap_lowerParabola
#print axioms HadwigerNelson.Plane.dist_hcFrame
#print axioms HadwigerNelson.Plane.hcFrame_coords
#print axioms HadwigerNelson.Plane.hcUpTri_frame
#print axioms HadwigerNelson.Plane.hcUp_slivers
#print axioms HadwigerNelson.Plane.hcBandTop_bounds
#print axioms HadwigerNelson.Plane.lt_hcBandTop_iff
#print axioms HadwigerNelson.Plane.continuousOn_hcBandTop
#print axioms HadwigerNelson.Plane.isClosed_hcSet
#print axioms HadwigerNelson.Plane.closure_interior_hcSet
#print axioms HadwigerNelson.Plane.volume_frontier_hcSet
#print axioms HadwigerNelson.Plane.hc_band_dist_lt_one
#print axioms HadwigerNelson.Plane.hc_unitAvoiding
#print axioms HadwigerNelson.Plane.exists_near_hcFace
#print axioms HadwigerNelson.Plane.hc_sausage_cover
#print axioms HadwigerNelson.Plane.hc_lemmaNL
#print axioms HadwigerNelson.Plane.hc_exclusion
#print axioms HadwigerNelson.Plane.hc_ae_phi_pos
#print axioms HadwigerNelson.Plane.subset_compl_unitShadow_closure
#print axioms HadwigerNelson.Plane.essSupport_of_isOpen
#print axioms HadwigerNelson.Plane.hcBand_component_iff
#print axioms HadwigerNelson.Plane.hc_free_pos
#print axioms HadwigerNelson.Plane.hc_free_subset_nowhereDense
#print axioms HadwigerNelson.Plane.frontier_essSupport_pos
-- FS131-I2e: wave 2 proved children and leaves
#print axioms HadwigerNelson.Plane.densityRatio_add_compl
#print axioms HadwigerNelson.Plane.densitySet_disjoint_compl
#print axioms HadwigerNelson.Plane.arcLength_eq_window
#print axioms HadwigerNelson.Plane.arcLength_ge_of_Ioo
#print axioms HadwigerNelson.Plane.arcLength_le_of_subset_Ioo
#print axioms HadwigerNelson.Plane.norm_sq_e_sub
#print axioms HadwigerNelson.Plane.measurableSet_angles
#print axioms HadwigerNelson.Plane.pairs_eq_lintegral
#print axioms HadwigerNelson.Plane.tendsto_densityRatio_of_notMem_essClosure
#print axioms HadwigerNelson.Plane.volume_ball_ofReal
#print axioms HadwigerNelson.Plane.ae_eq_densitySet
#print axioms HadwigerNelson.Plane.keptBall_of_le
#print axioms HadwigerNelson.Plane.arcLength_pos_of_isOpen
#print axioms HadwigerNelson.Plane.e_mul_e_neg
#print axioms HadwigerNelson.Plane.isOpen_rotImage
#print axioms HadwigerNelson.Plane.convex_combo_mem
#print axioms HadwigerNelson.Plane.exists_circle_point_halfBox
#print axioms HadwigerNelson.Plane.exists_frame_sides
#print axioms HadwigerNelson.Plane.frame_coords
#print axioms HadwigerNelson.Plane.exists_far_point
#print axioms HadwigerNelson.Plane.exists_phi_of_dist_eq_one
#print axioms HadwigerNelson.Plane.norm_sq_re_im
#print axioms HadwigerNelson.Plane.dist_framePt_sq
#print axioms HadwigerNelson.Plane.unitPairsNull_iUnion_of_monotone
#print axioms HadwigerNelson.Plane.measurableSet_grundyS
#print axioms HadwigerNelson.Plane.unitPairsNull_grundyS
#print axioms HadwigerNelson.Plane.measurableSet_grundyTaken
#print axioms HadwigerNelson.Plane.isOpen_faceQ
#print axioms HadwigerNelson.Plane.sq_lt_of_abs_lt'
#print axioms HadwigerNelson.Plane.abs_sub_lt_of_abs_lt
#print axioms HadwigerNelson.Plane.real_no_unit
#print axioms HadwigerNelson.Plane.frame_dist_sq
#print axioms HadwigerNelson.Plane.mem_faceFailClass_iff

-- FS131-I2f: children added by the sixth wave-2 implementer
#print axioms HadwigerNelson.Plane.upperDensityAt_pos_of_balls
#print axioms HadwigerNelson.Plane.sq9_openSq_subset
#print axioms HadwigerNelson.Plane.triQ_cover_tri
#print axioms HadwigerNelson.Plane.tri_cover
#print axioms HadwigerNelson.Plane.isClosed_disc7

-- FS131-I2g: children added by the seventh wave-2 implementer
#print axioms HadwigerNelson.Arith.ideal_le_of_mul_le
#print axioms HadwigerNelson.Plane.volume_closedBall_ofReal
#print axioms HadwigerNelson.Plane.densityRatio_le_of_unit_dist
#print axioms HadwigerNelson.Plane.tendsto_mul_nhdsGT
#print axioms HadwigerNelson.Plane.tendsto_densityRatio_compl_of_mem
#print axioms HadwigerNelson.Plane.mem_densitySet_of_tendsto_compl
#print axioms HadwigerNelson.Plane.measurable_densityRatio_centre
#print axioms HadwigerNelson.Plane.densitySet_iff_rat
#print axioms HadwigerNelson.Plane.sum_densityRatio_eq_one
#print axioms HadwigerNelson.Plane.exists_mem_essClosure_of_cover
#print axioms HadwigerNelson.Plane.densityRatio_le_one
#print axioms HadwigerNelson.Plane.densitySet_mono
#print axioms HadwigerNelson.Plane.exists_unit_pair_of_conull
#print axioms HadwigerNelson.Plane.ae_arcLength_shift
#print axioms HadwigerNelson.Plane.densitySet_disjoint
#print axioms HadwigerNelson.Plane.unitPairsNull_of_no_unit_pair
#print axioms HadwigerNelson.Plane.dist_add_e_mul
#print axioms HadwigerNelson.Plane.shift_re
#print axioms HadwigerNelson.Plane.shift_im
#print axioms HadwigerNelson.Arith.exists_powerBasis_of_root
#print axioms HadwigerNelson.Arith.exists_coords_of_quadratic

-- FS131-I2h: children added by the eighth wave-2 implementer
#print axioms HadwigerNelson.Arith.three_dvd_two_pow_sub_one_iff
#print axioms HadwigerNelson.Plane.measurableSet_squareWin
#print axioms HadwigerNelson.Plane.volume_squareWin
#print axioms HadwigerNelson.Plane.volume_ball_div_volume_ball
#print axioms HadwigerNelson.Plane.tendsto_sq_add_div
#print axioms HadwigerNelson.Plane.upperDensity_of_tiling
#print axioms HadwigerNelson.Plane.parallelogram_tiling

-- FS131-I2i: children added by the ninth wave-2 implementer
#print axioms HadwigerNelson.Plane.CPColouring.law_ge_ball_ne_le
#print axioms HadwigerNelson.Plane.volume_floor_emod_le
#print axioms HadwigerNelson.Plane.volume_floor_mul_emod_le
#print axioms HadwigerNelson.Plane.measurable_stripeIdx
#print axioms HadwigerNelson.Plane.volume_box_stripe_le
#print axioms HadwigerNelson.Plane.measurable_stripeCol
#print axioms HadwigerNelson.Plane.stripeCol_ne_of_dist_eq_one
#print axioms HadwigerNelson.Plane.tendsto_measure_inter_of_symmDiff
#print axioms HadwigerNelson.Plane.arcLength_eq_volume_Ioo
#print axioms HadwigerNelson.Plane.lintegral_Ioo_angle_le

-- FS131-I2j: children added by the tenth wave-2 implementer
#print axioms HadwigerNelson.Plane.exists_ball_diff_le_avg
#print axioms HadwigerNelson.Plane.conv_props
#print axioms HadwigerNelson.Plane.exists_L2_weak_subseq
#print axioms HadwigerNelson.Plane.ae_arcLength_null

-- FS131-I2k: children added by the eleventh wave-2 implementer
#print axioms HadwigerNelson.Plane.hcGap_exists_gap
#print axioms HadwigerNelson.Plane.hasDerivAt_hcGap_of_gap
#print axioms HadwigerNelson.Plane.abs_hcGap_le_sq
#print axioms HadwigerNelson.Plane.hasDerivAt_hcGap_of_mem
#print axioms HadwigerNelson.Plane.abs_deriv_hcGap_le
#print axioms HadwigerNelson.Plane.abs_deriv_hcGap_sub_le

-- FS131-I2l: children added by the twelfth wave-2 implementer
#print axioms HadwigerNelson.Plane.triQ_nonneg
#print axioms HadwigerNelson.Plane.triQ_le_add
#print axioms HadwigerNelson.Plane.tri_eq
#print axioms HadwigerNelson.Plane.dist_add_mul
#print axioms HadwigerNelson.Plane.triCoord_spec
#print axioms HadwigerNelson.Plane.dist_eq_triQ
#print axioms HadwigerNelson.Plane.triCoord_tri
#print axioms HadwigerNelson.Plane.dist_tri
#print axioms HadwigerNelson.Plane.reuleaux_aux
#print axioms HadwigerNelson.Plane.reuleaux_unitPair
#print axioms HadwigerNelson.Plane.dist_eq_one_of_three
#print axioms HadwigerNelson.Plane.triCoord_combo
#print axioms HadwigerNelson.Plane.triCoord_mem_downTri
#print axioms HadwigerNelson.Plane.sqrt_triQ_add_le
#print axioms HadwigerNelson.Plane.triQ_neg
#print axioms HadwigerNelson.Plane.r7Down_coords
#print axioms HadwigerNelson.Plane.continuous_triCoord
#print axioms HadwigerNelson.Plane.r7ColTri_of_cell
#print axioms HadwigerNelson.Plane.mem_essSupport_of_isOpen
#print axioms HadwigerNelson.Plane.sqrt_three_sq_lt
#print axioms HadwigerNelson.Plane.isOpen_r7UpOpen
#print axioms HadwigerNelson.Plane.isOpen_r7DownOpen
#print axioms HadwigerNelson.Plane.r7UpOpen_subset
#print axioms HadwigerNelson.Plane.r7DownOpen_subset
#print axioms HadwigerNelson.Plane.mem_closure_r7UpOpen
#print axioms HadwigerNelson.Plane.mem_closure_r7DownOpen
#print axioms HadwigerNelson.Plane.mem_essSupport_of_mem_closure
#print axioms HadwigerNelson.Plane.r7Up_vertex_mem_essSupport
#print axioms HadwigerNelson.Plane.r7Down_cusp_mem_essSupport
#print axioms HadwigerNelson.Plane.r7_down_mem_essSupport
#print axioms HadwigerNelson.Plane.not_mem_essClosure_of_eventually
#print axioms HadwigerNelson.Plane.triQ_tangent
#print axioms HadwigerNelson.Plane.r7_local
#print axioms HadwigerNelson.Plane.r7_far_vertex
#print axioms HadwigerNelson.Plane.phi_pos_of_mem_open
#print axioms HadwigerNelson.Plane.phi_pos_of_star
#print axioms HadwigerNelson.Plane.r7UpOpen_star
#print axioms HadwigerNelson.Plane.triQ_star
#print axioms HadwigerNelson.Plane.r7DownOpen_star
#print axioms HadwigerNelson.Plane.triQ_downTri_le
#print axioms HadwigerNelson.Plane.dist_tri_ne_one
#print axioms HadwigerNelson.Plane.one_le_dist_of_two
#print axioms HadwigerNelson.Plane.dist_tri_two
#print axioms HadwigerNelson.Plane.phi_pos_up_witness
#print axioms HadwigerNelson.Plane.phi_pos_down_witness

-- FS131-I2m: children added by the thirteenth wave-2 implementer
#print axioms HadwigerNelson.Plane.hc_w_explicit
#print axioms HadwigerNelson.Plane.hcFrame_explicit
#print axioms HadwigerNelson.Plane.hcFrame_hcFrameST
#print axioms HadwigerNelson.Plane.dist_eq_hcFrame
#print axioms HadwigerNelson.Plane.abs_sub_hcFrameT_le
#print axioms HadwigerNelson.Plane.abs_sub_hcFrameS_le
#print axioms HadwigerNelson.Plane.continuous_hcFrameS
#print axioms HadwigerNelson.Plane.continuous_hcFrameT
#print axioms HadwigerNelson.Plane.continuous_hcFrame
#print axioms HadwigerNelson.Plane.continuous_hcFrame_t
#print axioms HadwigerNelson.Plane.continuous_hcFrame_s
#print axioms HadwigerNelson.Plane.hcFrame_other
#print axioms HadwigerNelson.Plane.hcUpTri_vertices
#print axioms HadwigerNelson.Plane.mem_hcUpTri_iff
#print axioms HadwigerNelson.Plane.isCompact_hcUpTri
#print axioms HadwigerNelson.Plane.isCompact_hcUp
#print axioms HadwigerNelson.Plane.hcUp_frame
#print axioms HadwigerNelson.Plane.hcUp_nonempty
#print axioms HadwigerNelson.Plane.sub_le_infDist_hcUp
#print axioms HadwigerNelson.Plane.dist_hcUp_le_of_le
#print axioms HadwigerNelson.Plane.dist_hcUp_lt_of_lt
#print axioms HadwigerNelson.Plane.infDist_hcUp_antitone
#print axioms HadwigerNelson.Plane.infDist_hcUp_strictAnti
#print axioms HadwigerNelson.Plane.hcBandTop_set
#print axioms HadwigerNelson.Plane.hcBandTop_spec
#print axioms HadwigerNelson.Plane.infDist_le_half_sub_abs
#print axioms HadwigerNelson.Plane.e_pi_div_three_sq
#print axioms HadwigerNelson.Plane.hc_w_omega
#print axioms HadwigerNelson.Plane.hcFace_eq_tri
#print axioms HadwigerNelson.Plane.hcSet_eq_iUnion
#print axioms HadwigerNelson.Plane.hcCentre_eq
#print axioms HadwigerNelson.Plane.int_triQ_lt_three
#print axioms HadwigerNelson.Plane.hcC_near
#print axioms HadwigerNelson.Plane.hcDownC_dn
#print axioms HadwigerNelson.Plane.mem_hcDownTri_iff
#print axioms HadwigerNelson.Plane.hcFrame_dn
#print axioms HadwigerNelson.Plane.hcUpTri_subset_ball
#print axioms HadwigerNelson.Plane.hcDownTri_subset_ball
#print axioms HadwigerNelson.Plane.one_div_sqrt_three_le
#print axioms HadwigerNelson.Plane.closure_hcBand_subset_ball
#print axioms HadwigerNelson.Plane.hcBlock_subset_ball
#print axioms HadwigerNelson.Plane.one_le_hcFrameT_of_mem_closure_band
#print axioms HadwigerNelson.Plane.one_le_dist_hcUp_band
#print axioms HadwigerNelson.Plane.one_le_dist_hcDown_band
#print axioms HadwigerNelson.Plane.hcFlank_sep
#print axioms HadwigerNelson.Plane.hcBlock_sep
#print axioms HadwigerNelson.Plane.volume_graph_eq_zero
#print axioms HadwigerNelson.Plane.hcC_offsets
#print axioms HadwigerNelson.Plane.hcBlock_locallyFinite
#print axioms HadwigerNelson.Plane.isCompact_hcDownTri
#print axioms HadwigerNelson.Plane.isClosed_hcBlock
#print axioms HadwigerNelson.Plane.ball_subset_hcUpTri
#print axioms HadwigerNelson.Plane.ball_subset_hcDownTri
#print axioms HadwigerNelson.Plane.isOpen_hcBand
#print axioms HadwigerNelson.Plane.isOpen_hcUpO
#print axioms HadwigerNelson.Plane.hcUpO_subset
#print axioms HadwigerNelson.Plane.hcFrame_shrink
#print axioms HadwigerNelson.Plane.hcUp_subset_closure_hcUpO
#print axioms HadwigerNelson.Plane.hcFrame_shift
#print axioms HadwigerNelson.Plane.isBounded_hcFrame_box
#print axioms HadwigerNelson.Plane.volume_hcFrame_graph
#print axioms HadwigerNelson.Plane.volume_hcFrame_line
#print axioms HadwigerNelson.Plane.volume_frontier_hcUp
#print axioms HadwigerNelson.Plane.volume_frontier_closure_hcBand
#print axioms HadwigerNelson.Plane.volume_frontier_hcBlock
#print axioms HadwigerNelson.Plane.dist_le_one_of_sq
#print axioms HadwigerNelson.Plane.dist_le_one_of_mem_hcUpTri
#print axioms HadwigerNelson.Plane.dist_le_one_of_mem_hcDownTri
#print axioms HadwigerNelson.Plane.dist_le_one_of_mem_closure_band
#print axioms HadwigerNelson.Plane.hcBlock_dist_le_one

-- FS131-I2n: children added by the fourteenth wave-2 implementer
#print axioms HadwigerNelson.Plane.mem_hcUpTri_iff_frame
#print axioms HadwigerNelson.Plane.mem_hcDownTri_iff_frame
#print axioms HadwigerNelson.Plane.hcUpC_around
#print axioms HadwigerNelson.Plane.hcFrame_face
#print axioms HadwigerNelson.Plane.sqrt3_mul_abs_le
#print axioms HadwigerNelson.Plane.hc_face_cone
#print axioms HadwigerNelson.Plane.hc_cone_tri_aux
#print axioms HadwigerNelson.Plane.hc_cone_cover
#print axioms HadwigerNelson.Plane.hc_cover
#print axioms HadwigerNelson.Plane.hcFrame_mem_hcUpTri
#print axioms HadwigerNelson.Plane.hcFrame_mem_hcDownTri
#print axioms HadwigerNelson.Plane.hcFrame_mem_hcSeg
#print axioms HadwigerNelson.Plane.abs_half_sign
#print axioms HadwigerNelson.Plane.hc_lemmaNL_band
#print axioms HadwigerNelson.Plane.hc_lemmaNL_lt
#print axioms HadwigerNelson.Plane.exists_dist_eq_one_of_star
#print axioms HadwigerNelson.Plane.G1Bounds.sub_le
#print axioms HadwigerNelson.Plane.hcUpO_star
#print axioms HadwigerNelson.Plane.mem_hcN0_of_frame
#print axioms HadwigerNelson.Plane.volume_hcNframe
#print axioms HadwigerNelson.Plane.volume_hcN0
#print axioms HadwigerNelson.Plane.volume_hcKZ
#print axioms HadwigerNelson.Plane.hcFrame_mem_closure_band
#print axioms HadwigerNelson.Plane.hcKZ_subset
#print axioms HadwigerNelson.Plane.isClosed_unitShadow
#print axioms HadwigerNelson.Plane.dist_hcFrame_right
#print axioms HadwigerNelson.Plane.hcFrame_combo
#print axioms HadwigerNelson.Plane.hcBlock_subset_hcSet
#print axioms HadwigerNelson.Plane.hcUpO_subset_interior
#print axioms HadwigerNelson.Plane.hcBand_subset_interior
#print axioms HadwigerNelson.Plane.interior_hcDownTri_subset
#print axioms HadwigerNelson.Plane.G1Bounds.eq_zero_of_mem
#print axioms HadwigerNelson.Plane.hcFrame_corner_mem_hcUp
#print axioms HadwigerNelson.Plane.hcFrame_apex_mem_hcUp
#print axioms HadwigerNelson.Plane.hc_seg_exclusion
#print axioms HadwigerNelson.Plane.hc_c0
#print axioms HadwigerNelson.Plane.hc_c0_end
#print axioms HadwigerNelson.Plane.hc_c0_end'
#print axioms HadwigerNelson.Plane.hc_se_lift
#print axioms HadwigerNelson.Plane.hcDownTri_interior_star
#print axioms HadwigerNelson.Plane.hc_se_slab
#print axioms HadwigerNelson.Plane.hc_se_corner
#print axioms HadwigerNelson.Plane.hc_se_up
#print axioms HadwigerNelson.Plane.hc_se_face
#print axioms HadwigerNelson.Plane.hc_strict_exclusion
#print axioms HadwigerNelson.Plane.hcDownTri_one_neg_one
#print axioms HadwigerNelson.Plane.hcFrame_dn000_others
#print axioms HadwigerNelson.Plane.hc_free_near
#print axioms HadwigerNelson.Plane.closure_hcBand_subset_frame
#print axioms HadwigerNelson.Plane.hc_free_arc
#print axioms HadwigerNelson.Plane.countable_setOf_add_e_eq
#print axioms HadwigerNelson.Plane.hc_free_mem
#print axioms HadwigerNelson.Plane.exists_density_point
#print axioms HadwigerNelson.Plane.hc_free_slice
#print axioms HadwigerNelson.Plane.measurableSet_hcFreeParam
#print axioms HadwigerNelson.Plane.hc_free_param_pos
#print axioms HadwigerNelson.Plane.measurePreserving_hcFrame000
#print axioms HadwigerNelson.Plane.hc_free_numeric

/-! ## FS-131 (job FS131-I3i) — the sector structure at a point (`localSectors`), the separated interval, and the cusp-free
four-colour clause (`four_of_bothKind_simple`, recorded above, now without `hnc`) -/

#print axioms HadwigerNelson.Plane.branchPt_eq
#print axioms HadwigerNelson.Plane.germDir_zero
#print axioms HadwigerNelson.Plane.germDir_add_two_pi
#print axioms HadwigerNelson.Plane.continuous_germDir
#print axioms HadwigerNelson.Plane.continuous_branchPt
#print axioms HadwigerNelson.Plane.norm_mul_e
#print axioms HadwigerNelson.Plane.norm_branchPt_sub
#print axioms HadwigerNelson.Plane.polar_eq_iff
#print axioms HadwigerNelson.Plane.eq_polar_arg
#print axioms HadwigerNelson.Plane.e_add_int_mul
#print axioms HadwigerNelson.Plane.eq_polar_local
#print axioms HadwigerNelson.Plane.continuousAt_arg_div
#print axioms HadwigerNelson.Plane.arg_div_self
#print axioms HadwigerNelson.Plane.sq_norm_e_sub_e
#print axioms HadwigerNelson.Plane.BranchGerms.sector_eq
#print axioms HadwigerNelson.Plane.BranchGerms.atRadius_nextβ
#print axioms HadwigerNelson.Plane.BranchGerms.nextDir_eq
#print axioms HadwigerNelson.Plane.BranchGerms.continuous_dir
#print axioms HadwigerNelson.Plane.BranchGerms.continuous_nextDir
#print axioms HadwigerNelson.Plane.BranchGerms.Sorted.mono
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.le_add
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.le_of_le
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.le_two_pi
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.nextβ_le
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.zero_le
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.nextβ_le_add
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.nextβ_le_of_lt
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.disjoint
#print axioms HadwigerNelson.Plane.BranchGerms.exists_angle
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.not_mem_angleIoo
#print axioms HadwigerNelson.Plane.BranchGerms.e_nextDir
#print axioms HadwigerNelson.Plane.BranchGerms.nextDir_of_next_eq
#print axioms HadwigerNelson.Plane.BranchGerms.nextκ_eq
#print axioms HadwigerNelson.Plane.BranchGerms.dir_lt_nextDir
#print axioms HadwigerNelson.Plane.BranchGerms.atRadius_mono
#print axioms HadwigerNelson.Plane.BranchGerms.mem_sector_iff
#print axioms HadwigerNelson.Plane.BranchGerms.sector_mono
#print axioms HadwigerNelson.Plane.BranchGerms.sector_subset_ball
#print axioms HadwigerNelson.Plane.BranchGerms.sector_disjoint
#print axioms HadwigerNelson.Plane.BranchGerms.isOpen_sector
#print axioms HadwigerNelson.Plane.BranchGerms.isPreconnected_sector
#print axioms HadwigerNelson.Plane.BranchGerms.mem_coneAt_of_ray
#print axioms HadwigerNelson.Plane.BranchGerms.coneAt_sector
#print axioms HadwigerNelson.Plane.curveGerm_fst_mem
#print axioms HadwigerNelson.Plane.e_toIcoMod_add
#print axioms HadwigerNelson.Plane.branchPt_curveGerm
#print axioms HadwigerNelson.Plane.mul_e_mul_conj
#print axioms HadwigerNelson.Plane.branchPt_curveGerm_mem
#print axioms HadwigerNelson.Plane.exists_eq_branchPt_curveGerm
#print axioms HadwigerNelson.Plane.exists_germDir_ne
#print axioms HadwigerNelson.Plane.Arc.finite_ends
#print axioms HadwigerNelson.Plane.Arc.eventually_mem_carrier
#print axioms HadwigerNelson.Plane.Arc.exists_near
#print axioms HadwigerNelson.Plane.Arc.branch_mem_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.isSectorChart_of
#print axioms HadwigerNelson.Plane.localSectors
#print axioms HadwigerNelson.Plane.localSectors_disj
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.eq_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.sector_subset_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.sector_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_tile_inter_ball
#print axioms HadwigerNelson.Plane.ArcMap.Simple.coneAt_eq_angleIcc_sep
#print axioms HadwigerNelson.Plane.halfDisc_sectorChart

/-! ## FS-131 wave 4 (job FS131-K4) — the foundation: valid maps at a point (frames, horns, sectors, contacts, shadows, the moves) -/

#print axioms HadwigerNelson.Plane.ArcMap.const_isSector_ball
#print axioms HadwigerNelson.Plane.ArcMap.const_not_isSector_far
#print axioms HadwigerNelson.Plane.ArcMap.unitArcPlane_not_condition5

/-! ## FS-131 wave 4 (job FS131-K4) — the skeleton: stuck chains, contacts and the local moves, the unit-arc calculus (sorry until wave 4's implementer lands it) -/

#print axioms HadwigerNelson.Plane.n4_fin
#print axioms HadwigerNelson.Plane.curvUp_curvDown
#print axioms HadwigerNelson.Plane.ray_chain
#print axioms HadwigerNelson.Plane.exists_oneSided_chain
#print axioms HadwigerNelson.Plane.rayLower_pencil
#print axioms HadwigerNelson.Plane.shadow_farSide_above
#print axioms HadwigerNelson.Plane.shadow_farSide_below
#print axioms HadwigerNelson.Plane.ArcMap.contact_inType_or_outType
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_subset_allowedCone
#print axioms HadwigerNelson.Plane.ArcMap.clear_of_subset_interior_allowedCone
#print axioms HadwigerNelson.Plane.lens_dist_lt_one_of_up
#print axioms HadwigerNelson.Plane.lune_dist_le_of_up
#print axioms HadwigerNelson.Plane.ArcMap.woodallCone
#print axioms HadwigerNelson.Plane.ArcMap.woodallCone_strict
#print axioms HadwigerNelson.Plane.ArcMap.flank_shadows
#print axioms HadwigerNelson.Plane.ArcMap.shaveAvailable_of_not_doublyShadowed
#print axioms HadwigerNelson.Plane.ArcMap.exists_shave
#print axioms HadwigerNelson.Plane.ArcMap.exists_rayMerge
#print axioms HadwigerNelson.Plane.ArcMap.exists_merge
#print axioms HadwigerNelson.Plane.ArcMap.stuck_structure
#print axioms HadwigerNelson.Plane.ArcMap.stuck_chain
#print axioms HadwigerNelson.Plane.ArcMap.lock
#print axioms HadwigerNelson.Plane.ArcMap.n2_sign
#print axioms HadwigerNelson.Plane.ArcMap.l60_le
#print axioms HadwigerNelson.Plane.ArcMap.noBoth

/-! ## FS-131 wave 4 (job FS131-K4b) — the skeleton continued: FS106-L, FS106-TS-T, the brick map of the plane (sorry until wave 4's implementer lands it; `lebesgue_covering_square` is an outside theorem whose disposition is owed) -/

#print axioms HadwigerNelson.Plane.lemmaL
#print axioms HadwigerNelson.Plane.not_lemmaL_of_not_mem
#print axioms HadwigerNelson.Plane.lebesgue_covering_square
#print axioms HadwigerNelson.Plane.AeProperRegions.exists_three_le_multicolour
#print axioms HadwigerNelson.Plane.AeProperRegions.exists_three_le_multicolour_lt_one
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_eq_multicolour
#print axioms HadwigerNelson.Plane.ArcMap.region_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.dense_iUnion_region
#print axioms HadwigerNelson.Plane.ArcMap.toAeProperRegions
#print axioms HadwigerNelson.Plane.ArcMap.ts_t
#print axioms HadwigerNelson.Plane.ArcMap.exists_hasDegree_of_mem_dom
#print axioms HadwigerNelson.Plane.ArcMap.ts_t_trichromatic
#print axioms HadwigerNelson.Plane.ArcMap.ts_t_degree_three
#print axioms HadwigerNelson.Plane.sevenBrickArcs_nondegenerate
#print axioms HadwigerNelson.Plane.sevenBrickArcs_locallyFinite
#print axioms HadwigerNelson.Plane.sevenBrick_color_locallyConstant
#print axioms HadwigerNelson.Plane.sevenBrickMap
#print axioms HadwigerNelson.Plane.sevenBrickMap_isPlaneMap
#print axioms HadwigerNelson.Plane.sevenBrickMap_valid
#print axioms HadwigerNelson.Plane.sevenBrickRegions
#print axioms HadwigerNelson.Plane.instIsEmptyAeProperRegionsZero
#print axioms HadwigerNelson.Plane.instIsEmptyAeProperRegionsOne

/-! ## FS-131 wave 4 (job FS131-K4b) — the base's steps with unit arcs and the bowtie fragment (sorry until wave 4's implementer lands it) -/

#print axioms HadwigerNelson.Plane.const_univ_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.pair_i
#print axioms HadwigerNelson.Plane.ArcMap.pair_ii
#print axioms HadwigerNelson.Plane.ArcMap.pair_P'
#print axioms HadwigerNelson.Plane.ArcMap.fail_leavingCentre
#print axioms HadwigerNelson.Plane.ArcMap.fail_colours
#print axioms HadwigerNelson.Plane.ArcMap.anti
#print axioms HadwigerNelson.Plane.bowtieArcs_nondegenerate
#print axioms HadwigerNelson.Plane.bowtieArcs_locallyFinite
#print axioms HadwigerNelson.Plane.bowtieCol_locallyConstant
#print axioms HadwigerNelson.Plane.bowtie
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_valid
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_mem_dom
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_coloursAt_zero
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_isHorn
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_flanks
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_doublyShadowed
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_inType
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_neighbours
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_isStuck
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_isStuck_I
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_isHorn_I_axis
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_terminalOn
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_unitArcEnds

/-! ## FS-131 wave 4 (job FS131-K4c) — the unit-arc items: U1's shadow, L60-EQ and L60-REAL, N2-ENV and the bends, ISO, FLANK, FLANK-Q, A4SIX, NB4P (sorry until wave 4's implementer lands it) -/

#print axioms HadwigerNelson.Plane.ArcMap.u1_shadow
#print axioms HadwigerNelson.Plane.ArcMap.l60_eq_inner
#print axioms HadwigerNelson.Plane.ArcMap.l60_eq_outer
#print axioms HadwigerNelson.Plane.ArcMap.l60_eq_corners
#print axioms HadwigerNelson.Plane.ArcMap.l60_eq_third
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_l60Dom
#print axioms HadwigerNelson.Plane.ArcMap.l60Arcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.l60Col_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.l60Frag
#print axioms HadwigerNelson.Plane.ArcMap.l60_real
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_toward
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_away
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_near
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_near_away
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_whole
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_isoDom
#print axioms HadwigerNelson.Plane.ArcMap.isoCol_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.isoFrag
#print axioms HadwigerNelson.Plane.ArcMap.iso
#print axioms HadwigerNelson.Plane.ArcMap.inType_shadows_horn
#print axioms HadwigerNelson.Plane.ArcMap.flank_siamese_of_inType
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_upper
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_lower
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_both
#print axioms HadwigerNelson.Plane.ArcMap.a4six
#print axioms HadwigerNelson.Plane.ArcMap.nb4p
#print axioms HadwigerNelson.Plane.ArcMap.flank_incomplete_bowtie

/-! ## FS-131 wave 4 (job FS131-I4) — the implementer's added children and proved leaves -/

#print axioms HadwigerNelson.Plane.cos_sub_cos_le_sub
#print axioms HadwigerNelson.Plane.abs_le_of_cos_le
#print axioms HadwigerNelson.Plane.abs_lt_of_cos_lt
#print axioms HadwigerNelson.Plane.polar_toward
#print axioms HadwigerNelson.Plane.polar_toward_strict
#print axioms HadwigerNelson.Plane.polar_away
#print axioms HadwigerNelson.Plane.polar_away_strict
#print axioms HadwigerNelson.Plane.carrier_circ_arccos
#print axioms HadwigerNelson.Plane.norm_frameDir
#print axioms HadwigerNelson.Plane.eq_polar_frameDir
#print axioms HadwigerNelson.Plane.dist_sq_sub_dir
#print axioms HadwigerNelson.Plane.dist_sq_add_dir
#print axioms HadwigerNelson.Plane.re_frameDir_ringPt
#print axioms HadwigerNelson.Plane.min_add_sub_eq
#print axioms HadwigerNelson.Plane.dist_polar_ringPt
#print axioms HadwigerNelson.Plane.le_on_Icc_of_Ioo
#print axioms HadwigerNelson.Plane.ge_on_Icc_of_Ioo
#print axioms HadwigerNelson.Plane.toward_polar
#print axioms HadwigerNelson.Plane.toward_polar_strict
#print axioms HadwigerNelson.Plane.dist_polar_polar_sq
#print axioms HadwigerNelson.Plane.toward_pairs
#print axioms HadwigerNelson.Plane.re_frameDir_sub_dir
#print axioms HadwigerNelson.Plane.toward_carrier
#print axioms HadwigerNelson.Plane.re_frameDir_add_dir
#print axioms HadwigerNelson.Plane.away_polar
#print axioms HadwigerNelson.Plane.away_polar_strict
#print axioms HadwigerNelson.Plane.away_carrier
#print axioms HadwigerNelson.Plane.one_add_le_two_cos
#print axioms HadwigerNelson.Plane.away_mem_lens
#print axioms HadwigerNelson.Plane.ArcMap.carrier_circ_one
#print axioms HadwigerNelson.Plane.ArcMap.cutArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.cutArcs_subset
#print axioms HadwigerNelson.Plane.ArcMap.finite_cut_pieces
#print axioms HadwigerNelson.Plane.ArcMap.cutArcs_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_mem_openArc_iff
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_piece_openArc
#print axioms HadwigerNelson.Plane.ArcMap.mem_cut_of_mem_circ
#print axioms HadwigerNelson.Plane.ArcMap.mem_cutArcs_iff
#print axioms HadwigerNelson.Plane.ArcMap.exists_kept_of_mem_openArc
#print axioms HadwigerNelson.Plane.ArcMap.eventually_not_mem_arcs
#print axioms HadwigerNelson.Plane.ArcMap.bendArcs_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.bendCol_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.bendCol_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.bend_hlc
#print axioms HadwigerNelson.Plane.ArcMap.bendMap_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.bendMap_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.bendMap_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.bendMap_valid
#print axioms HadwigerNelson.Plane.ArcMap.bendMap_region
#print axioms HadwigerNelson.Plane.ArcMap.bendMap_not_onRingArc
#print axioms HadwigerNelson.Plane.ArcMap.mem_thickening_ringArc_of_polar
#print axioms HadwigerNelson.Plane.ArcMap.toward_clear
#print axioms HadwigerNelson.Plane.ArcMap.away_clear
#print axioms HadwigerNelson.Plane.ArcMap.away_lens_clear
#print axioms HadwigerNelson.Plane.ArcMap.away_pairs
#print axioms HadwigerNelson.Plane.ArcMap.away_circle_facts
#print axioms HadwigerNelson.Plane.cos_int_mul_third_pos
#print axioms HadwigerNelson.Plane.cos_int_mul_third_neg
#print axioms HadwigerNelson.Plane.exists_opposite_cos_third
#print axioms HadwigerNelson.Plane.sq_norm_e_add_e
#print axioms HadwigerNelson.Plane.e_add_third_add_e_sub_third
#print axioms HadwigerNelson.Plane.ArcMap.germ_rotate_third
#print axioms HadwigerNelson.Plane.ArcMap.straddlers_third
#print axioms HadwigerNelson.Plane.sq_norm_two_e_sub
#print axioms HadwigerNelson.Plane.r2Cross_spec
#print axioms HadwigerNelson.Plane.continuousAt_r2Cross_one
#print axioms HadwigerNelson.Plane.r2Cross_one
#print axioms HadwigerNelson.Plane.Arc.finite_inter_sphere_two_or_subset
#print axioms HadwigerNelson.Plane.ArcMap.eventually_arcs_on_sphere_two
#print axioms HadwigerNelson.Plane.ArcMap.exists_polarBox_subset_region
#print axioms HadwigerNelson.Plane.ArcMap.mem_shadow_of_crossing
#print axioms HadwigerNelson.Plane.normalPt_sub_add_eq_fromFrame
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.isRingArc_lower
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_lower_shadow
#print axioms HadwigerNelson.Plane.normalPt_add_eq_fromFrame
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.isRingArc_upper
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_upper_shadow
#print axioms HadwigerNelson.Plane.eq_midpoint_of_dist
#print axioms HadwigerNelson.Plane.finite_sphere_inter_sphere_half
#print axioms HadwigerNelson.Plane.exists_mem_Ioo_ringPt_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_region_of_pseudo
#print axioms HadwigerNelson.Plane.ArcMap.finite_not_stripHolds
#print axioms HadwigerNelson.Plane.ArcMap.pair_i_of_transversal
#print axioms HadwigerNelson.Plane.ArcMap.stripHolds_of_two_branches
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_isRingArc_of_along
#print axioms HadwigerNelson.Plane.ArcMap.exists_along_of_side
#print axioms HadwigerNelson.Plane.ArcMap.exists_colour_near
#print axioms HadwigerNelson.Plane.ArcMap.closure_sector_subset_of_side
#print axioms HadwigerNelson.Plane.ArcMap.exists_side_germs_of_transversal
#print axioms HadwigerNelson.Plane.ArcMap.half_colour_or_bothKind
#print axioms HadwigerNelson.Plane.BranchGerms.mem_closure_sector_of_lt
#print axioms HadwigerNelson.Plane.BranchGerms.fin3_adj
#print axioms HadwigerNelson.Plane.sq_dist_branchPt
#print axioms HadwigerNelson.Plane.germ_circle_real
#print axioms HadwigerNelson.Plane.germ_eq_of_two_on_circle
#print axioms HadwigerNelson.Plane.branchPt_two_sin
#print axioms HadwigerNelson.Plane.ArcMap.IsCubicTrichromatic.chart
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_ball_branch
#print axioms HadwigerNelson.Plane.ArcMap.exists_branch_on_circle_of_not_stripHolds
#print axioms HadwigerNelson.Plane.ArcMap.exists_shift_avoiding
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_Γ_inter_sphere
#print axioms HadwigerNelson.Plane.ArcMap.countable_ringPt_preimage
#print axioms HadwigerNelson.Plane.ArcMap.exists_coveringPoint_of_window
#print axioms HadwigerNelson.Plane.ArcMap.outside_segment_real
#print axioms HadwigerNelson.Plane.ArcMap.outside_segment
#print axioms HadwigerNelson.Plane.ArcMap.dist_ringPt_radial
#print axioms HadwigerNelson.Plane.ArcMap.dist_radial_centre
#print axioms HadwigerNelson.Plane.ArcMap.isRingArc_of_clean
#print axioms HadwigerNelson.Plane.ArcMap.carrier_circ_subset_sphere
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_subset_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.exists_clean_subArc
#print axioms HadwigerNelson.Plane.ArcMap.exists_isRingArc_of_subset_Γ
#print axioms HadwigerNelson.Plane.ArcMap.dist_ringPt_ringPt_le
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_arg_sub
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_col_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.IsCubicTrichromatic.not_hasRepeatedColour
#print axioms HadwigerNelson.Plane.ArcMap.angleIcc_half_turn
#print axioms HadwigerNelson.Plane.ArcMap.norm_rot_sub
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_eq_rot
#print axioms HadwigerNelson.Plane.ArcMap.mem_ringArc_of_lens
#print axioms HadwigerNelson.Plane.ArcMap.l60_cap_mem_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.l60_cap_general
#print axioms HadwigerNelson.Plane.ArcMap.dist_le_one_of_touch
#print axioms HadwigerNelson.Plane.ArcMap.l60_tile_dist_ne_one
#print axioms HadwigerNelson.Plane.ArcMap.l60_side_tile
#print axioms HadwigerNelson.Plane.ArcMap.cos_nonpos_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.mem_angleIcc_of_two_cos
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_ringArc_diff_finite
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_subset_Γ_of_finite
#print axioms HadwigerNelson.Plane.ArcMap.ringArcsWithin_of_Γ_subset
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_sector_of_mem_coneAt_region
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_region_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_away_height
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_away_core
#print axioms HadwigerNelson.Plane.ArcMap.eq_polar_of_frameX_pos
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_away_end
#print axioms HadwigerNelson.Plane.ArcMap.sin_add_sin_sub_sin_ge
#print axioms HadwigerNelson.Plane.ArcMap.sin_mul_e_add_sin_mul_e
#print axioms HadwigerNelson.Plane.ArcMap.lens_dot_ge
#print axioms HadwigerNelson.Plane.ArcMap.sq_norm_sub_ofReal_mul_e
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_near_core
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_near_away_core
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_data
#print axioms HadwigerNelson.Plane.ArcMap.toward_dir45
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_toward_beside
#print axioms HadwigerNelson.Plane.ArcMap.n2_env_toward_core
#print axioms HadwigerNelson.Plane.ArcMap.frame_polar_add
#print axioms HadwigerNelson.Plane.ArcMap.exists_dir_of_within
#print axioms HadwigerNelson.Plane.ArcMap.reul_bound_real
#print axioms HadwigerNelson.Plane.ArcMap.norm_sub_le_one_of_cone
#print axioms HadwigerNelson.Plane.ArcMap.eq_cramer
#print axioms HadwigerNelson.Plane.ArcMap.dist_le_one_of_mem_reul
#print axioms HadwigerNelson.Plane.ArcMap.dist_lt_one_of_mem_reul
#print axioms HadwigerNelson.Plane.ArcMap.norm_e_pi_div_three_sub_one
#print axioms HadwigerNelson.Plane.ArcMap.l60_interior_lens
#print axioms HadwigerNelson.Plane.ArcMap.l60_cap_mem_ball
#print axioms HadwigerNelson.Plane.ArcMap.l60_interior_cases
#print axioms HadwigerNelson.Plane.ArcMap.l60Frag_valid
#print axioms HadwigerNelson.Plane.ArcMap.l60_openLens_subset_dom
#print axioms HadwigerNelson.Plane.ArcMap.l60_closure_subset_region
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_l60_subset_dom
#print axioms HadwigerNelson.Plane.ArcMap.l60Frag_isRingArc
#print axioms HadwigerNelson.Plane.ArcMap.mem_carrier_circ_of_arg
#print axioms HadwigerNelson.Plane.ArcMap.abs_le_pi_div_three_of_cos
#print axioms HadwigerNelson.Plane.ArcMap.two_pi_div_three_le_abs_of_cos
#print axioms HadwigerNelson.Plane.ArcMap.cos_arg_sub
#print axioms HadwigerNelson.Plane.ArcMap.sq_norm_sub_eq
#print axioms HadwigerNelson.Plane.ArcMap.e_pi_div_three_re_im
#print axioms HadwigerNelson.Plane.ArcMap.mem_carrier_circ_full
#print axioms HadwigerNelson.Plane.ArcMap.mem_l60_arc0
#print axioms HadwigerNelson.Plane.ArcMap.mem_l60_arc1
#print axioms HadwigerNelson.Plane.ArcMap.mem_l60_arc2
#print axioms HadwigerNelson.Plane.ArcMap.rayParam_circ
#print axioms HadwigerNelson.Plane.ArcMap.tanBelow_tanAbove_false
#print axioms HadwigerNelson.Plane.ArcMap.frame_ray
#print axioms HadwigerNelson.Plane.ArcMap.eventually_ray_not_mem_hornSet
#print axioms HadwigerNelson.Plane.ArcMap.eventually_not_two_rays_hornSet
#print axioms HadwigerNelson.Plane.ArcMap.eq_e_of_ray_subset_hornSet
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.subset
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.nonempty
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.subset_of_isPreconnected
#print axioms HadwigerNelson.Plane.ArcMap.ray_mem_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.disjoint_of_rays
#print axioms HadwigerNelson.Plane.ArcMap.HasSectors.eq
#print axioms HadwigerNelson.Plane.ArcMap.HasSectors.eq_zero_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.ray_coords
#print axioms HadwigerNelson.Plane.ArcMap.im_pt_mul_conj_pt
#print axioms HadwigerNelson.Plane.ArcMap.norm_ray_sub_lt_one
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_isHorn_I
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_isHorn_negI
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_hornSet_zero
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_hasSectors_zero_two
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_tileOf_one
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_outType_one
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_merge_zero
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_ray_zero
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_flank_colour
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_not_shave_zero
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_hasSectors_le_one
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_terminal_pm_I
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_hasSectors_of_tiles
#print axioms HadwigerNelson.Plane.ArcMap.convex_halfPlane
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtieArcs_near_I
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtieArcs_near_negI
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_of_mem_CN_CS
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_of_mem_XY
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_hasSectors_of_four_tiles
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_of_ray
#print axioms HadwigerNelson.Plane.ArcMap.convex_bowtie_tiles
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_partition_I
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_partition_negI
#print axioms HadwigerNelson.Plane.ArcMap.subset_closure_of_diff_subset
#print axioms HadwigerNelson.Plane.ArcMap.interior_sphere_union_lines
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_dom_end_pp
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_dom_end_np
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_dom_end_pn
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_dom_end_nn
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_arc_ends
#print axioms HadwigerNelson.Plane.mem_segment_of_coords
#print axioms HadwigerNelson.Plane.mem_bowtieArcs_seg
#print axioms HadwigerNelson.Plane.mem_bowtieArcN_of
#print axioms HadwigerNelson.Plane.mem_bowtieArcS_of
#print axioms HadwigerNelson.Plane.norm_sub_I_sq
#print axioms HadwigerNelson.Plane.norm_add_I_sq
#print axioms HadwigerNelson.Plane.closure_bowtieG_subset
#print axioms HadwigerNelson.Plane.closure_bowtieH_subset
#print axioms HadwigerNelson.Plane.closure_bowtieC_subset
#print axioms HadwigerNelson.Plane.closure_bowtieCN_subset
#print axioms HadwigerNelson.Plane.closure_bowtieCS_subset
#print axioms HadwigerNelson.Plane.bowtieX_closure_cases
#print axioms HadwigerNelson.Plane.bowtieY_closure_cases
#print axioms HadwigerNelson.Plane.closure_bowtieX_one_subset
#print axioms HadwigerNelson.Plane.closure_bowtieX_neg_one_subset
#print axioms HadwigerNelson.Plane.closure_bowtieY_one_subset
#print axioms HadwigerNelson.Plane.closure_bowtieY_neg_one_subset
#print axioms HadwigerNelson.Plane.eventually_mem_iff_of_closure_subset
#print axioms HadwigerNelson.Plane.bowtieCol_eq_of_iff
#print axioms HadwigerNelson.Plane.isOpen_bowtieG
#print axioms HadwigerNelson.Plane.isOpen_bowtieH
#print axioms HadwigerNelson.Plane.isOpen_bowtieC
#print axioms HadwigerNelson.Plane.isOpen_bowtieCN
#print axioms HadwigerNelson.Plane.isOpen_bowtieCS
#print axioms HadwigerNelson.Plane.isOpen_bowtieX
#print axioms HadwigerNelson.Plane.isOpen_bowtieY
#print axioms HadwigerNelson.Plane.ArcMap.sq_coords_of_dist_eq_one
#print axioms HadwigerNelson.Plane.ArcMap.dist_lt_one_of_mem_bowtieG
#print axioms HadwigerNelson.Plane.ArcMap.conj_mem_bowtieG_of_mem_bowtieH
#print axioms HadwigerNelson.Plane.ArcMap.dist_lt_one_of_mem_bowtieH
#print axioms HadwigerNelson.Plane.ArcMap.conj_mem_bowtieC
#print axioms HadwigerNelson.Plane.ArcMap.conj_mem_bowtieCN_of_mem_bowtieCS
#print axioms HadwigerNelson.Plane.ArcMap.one_lt_of_mem_bowtieC_CN
#print axioms HadwigerNelson.Plane.ArcMap.sq_ne_one_of_bowtie_one
#print axioms HadwigerNelson.Plane.ArcMap.sq_ne_one_of_bowtie_XY
#print axioms HadwigerNelson.Plane.ArcMap.closure_bowtieZ_subset
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_interiorPts_cases
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_cases
#print axioms HadwigerNelson.Plane.ArcMap.coords_of_mem_segment
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_bowtieArcs_near_I
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_bowtieArcs_near_negI
#print axioms HadwigerNelson.Plane.ArcMap.subset_bowtie_dom
#print axioms HadwigerNelson.Plane.ArcMap.bowtieG_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.bowtieH_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtie_region_zero
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtie_region_two
#print axioms HadwigerNelson.Plane.ArcMap.I_mem_closure_bowtie_region
#print axioms HadwigerNelson.Plane.ArcMap.mem_shadow_bowtie_region_zero
#print axioms HadwigerNelson.Plane.ArcMap.mem_shadow_bowtie_region_two
#print axioms HadwigerNelson.Plane.ArcMap.interior_line_eq_empty
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_line
#print axioms HadwigerNelson.Plane.ArcMap.dense_compl_four_lines
#print axioms HadwigerNelson.Plane.ArcMap.subset_bowtieTiles
#print axioms HadwigerNelson.Plane.ArcMap.ball_I_subset_closure_bowtieTiles
#print axioms HadwigerNelson.Plane.ArcMap.ball_negI_subset_closure_bowtieTiles
#print axioms HadwigerNelson.Plane.ArcMap.e_pi_add_pi_div_two
#print axioms HadwigerNelson.Plane.ArcMap.norm_ge_of_mem_segment_far
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtieArc_N
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtieArc_S
#print axioms HadwigerNelson.Plane.ArcMap.mem_bowtieArcs_iff_of_norm_lt
#print axioms HadwigerNelson.Plane.ArcMap.cuspPiece_subset_bowtie
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_of_mem_G
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_of_mem_C
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_of_mem_H
#print axioms HadwigerNelson.Plane.ArcMap.bowtieCol_cuspPiece
#print axioms HadwigerNelson.Plane.ArcMap.ball_subset_bowtie_dom
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_partition
#print axioms HadwigerNelson.Plane.ArcMap.hornSet_cusp_pi_eq
#print axioms HadwigerNelson.Plane.ArcMap.bowtie_isSector_cuspPiece
#print axioms HadwigerNelson.Plane.ArcMap.cuspPiece_subset_bowtie_region
#print axioms HadwigerNelson.Plane.ArcMap.cuspPiece_data
#print axioms HadwigerNelson.Plane.sq_norm_one_add_mul_e_sub_one
#print axioms HadwigerNelson.Plane.re_lt_one_of_norm_eq_one
#print axioms HadwigerNelson.Plane.norm_e_sub_one_le
#print axioms HadwigerNelson.Plane.exists_e_outside
#print axioms HadwigerNelson.Plane.exists_e_inside
#print axioms HadwigerNelson.Plane.ArcMap.Valid.dist_ne_one_of_isOpen_subset_closure
#print axioms HadwigerNelson.Plane.ArcMap.unit_circle_turn
#print axioms HadwigerNelson.Plane.ArcMap.carrier_circ_full
#print axioms HadwigerNelson.Plane.ArcMap.norm_sub_I_sq_add
#print axioms HadwigerNelson.Plane.ArcMap.cuspFrag_mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.cuspFrag_valid
#print axioms HadwigerNelson.Plane.ArcMap.hornSet_cusp_iff
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_hornSet_cusp
#print axioms HadwigerNelson.Plane.ArcMap.isPreconnected_hornSet_cusp
#print axioms HadwigerNelson.Plane.ArcMap.mem_cuspPiece_one
#print axioms HadwigerNelson.Plane.ArcMap.cuspFrag_partition
#print axioms HadwigerNelson.Plane.ArcMap.cuspFrag_isHorn
#print axioms HadwigerNelson.Plane.not_mem_sevenBrickArcs
#print axioms HadwigerNelson.Plane.mem_sevenBrickArcs_of_bottom
#print axioms HadwigerNelson.Plane.mem_sevenBrickArcs_of_left
#print axioms HadwigerNelson.Plane.mem_brickCornerSector_iUnion
#print axioms HadwigerNelson.Plane.brickCornerSector_subset_ball
#print axioms HadwigerNelson.Plane.abs_re_im_lt_of_mem_ball
#print axioms HadwigerNelson.Plane.sevenBrick_corner_interior
#print axioms HadwigerNelson.Plane.brickCornerPt_mem
#print axioms HadwigerNelson.Plane.sevenBrick_corner_hasDegree
#print axioms HadwigerNelson.Plane.sevenBrick_color_eq
#print axioms HadwigerNelson.Plane.sevenBrick_corner_col
#print axioms HadwigerNelson.Plane.sevenBrick_corner_coloursAt
#print axioms HadwigerNelson.Plane.sevenBrick_corner_isCubicTrichromatic
#print axioms HadwigerNelson.Plane.sevenBrick_corner_mIn
#print axioms HadwigerNelson.Plane.connectedComponentIn_eq_of_iUnion
#print axioms HadwigerNelson.Plane.frame_polar
#print axioms HadwigerNelson.Plane.tanHeight_polar
#print axioms HadwigerNelson.Plane.half_curv_mem_Icc
#print axioms HadwigerNelson.Plane.sectorBetween_eq_hornSet
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.mem_closure_sector
#print axioms HadwigerNelson.Plane.ArcMap.isSector_iff_of_partition
#print axioms HadwigerNelson.Plane.ArcMap.injective_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.encard_sectors_of_partition
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.isSector_iff
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.isSector_iff_of_zero
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.encard_sectors
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.ncard_coloursAt_le
#print axioms HadwigerNelson.Plane.ArcMap.exists_hasDegree_of_chart
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_ball_self
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.curv_next
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.isSector_cone_or_horn
#print axioms HadwigerNelson.Plane.ArcMap.isJordanDomain_of_convex
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_halfDiscUpper
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_halfDiscLower
#print axioms HadwigerNelson.Plane.ArcMap.convex_halfDiscUpper
#print axioms HadwigerNelson.Plane.ArcMap.convex_halfDiscLower
#print axioms HadwigerNelson.Plane.ArcMap.halfDisc_interiorPts_eq
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_halfDiscPiece
#print axioms HadwigerNelson.Plane.ArcMap.convex_halfDiscPiece
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_halfDiscPiece
#print axioms HadwigerNelson.Plane.ArcMap.halfDisc_component
#print axioms HadwigerNelson.Plane.ArcMap.halfDisc_isTile
#print axioms HadwigerNelson.Plane.ArcMap.halfDiscUpper_mem
#print axioms HadwigerNelson.Plane.ArcMap.halfDiscLower_mem
#print axioms HadwigerNelson.Plane.ArcMap.halfDisc_two_tiles
#print axioms HadwigerNelson.Plane.ArcMap.halfDisc_simple
#print axioms HadwigerNelson.Plane.exists_dir_dot_neg
#print axioms HadwigerNelson.Plane.ArcMap.exists_tile_cone_dot_neg
#print axioms HadwigerNelson.Plane.ArcMap.mem_isoArc_of_norm_one
#print axioms HadwigerNelson.Plane.ArcMap.two_lt_norm_of_mem_isoY
#print axioms HadwigerNelson.Plane.ArcMap.norm_bounds_of_mem_ball_one
#print axioms HadwigerNelson.Plane.ArcMap.isoFrag_col_eq_zero_iff
#print axioms HadwigerNelson.Plane.ArcMap.norm_eq_one_of_mem_isoFrag_arcs
#print axioms HadwigerNelson.Plane.ArcMap.mem_isoFrag_dom
#print axioms HadwigerNelson.Plane.ArcMap.isoFrag_region_one
#print axioms HadwigerNelson.Plane.n4_fin_u_nonpos
#print axioms HadwigerNelson.Plane.rayLower_neg
#print axioms HadwigerNelson.Plane.rayLower_eq_curvDown
#print axioms HadwigerNelson.Plane.frameX_add_smul
#print axioms HadwigerNelson.Plane.rayPt_continuousAt
#print axioms HadwigerNelson.Plane.dist_rayPt
#print axioms HadwigerNelson.Plane.dist_rayPt_center
#print axioms HadwigerNelson.Plane.frameX_rayPt
#print axioms HadwigerNelson.Plane.norm_C_sub_z
#print axioms HadwigerNelson.Plane.shadow_inside
#print axioms HadwigerNelson.Plane.shadow_outside
#print axioms HadwigerNelson.Plane.dot_div_ofReal
#print axioms HadwigerNelson.Plane.norm_sub_sq_eq_dot
#print axioms HadwigerNelson.Plane.abs_dot_le
#print axioms HadwigerNelson.Plane.dot_sub
#print axioms HadwigerNelson.Plane.dot_nonneg_of_coneAt_subset
#print axioms HadwigerNelson.Plane.dot_nonpos_of_coneAt_subset
#print axioms HadwigerNelson.Plane.frameX_fromFrame
#print axioms HadwigerNelson.Plane.frameY_fromFrame
#print axioms HadwigerNelson.Plane.tanHeight_hornPt
#print axioms HadwigerNelson.Plane.eventually_hornPt_pos
#print axioms HadwigerNelson.Plane.eventually_hornPt_neg
#print axioms HadwigerNelson.Plane.exists_mem_hornSet_aboveBelow
#print axioms HadwigerNelson.Plane.brickCorner_re
#print axioms HadwigerNelson.Plane.brickCorner_im
#print axioms HadwigerNelson.Plane.eventually_floor_eq
#print axioms HadwigerNelson.Plane.sevenBrick_h
#print axioms HadwigerNelson.Plane.sevenBrick_w
#print axioms HadwigerNelson.Plane.sevenBrick_s
#print axioms HadwigerNelson.Plane.ArcMap.Valid.of_agreesOff
#print axioms HadwigerNelson.Plane.e_add_pi_div_two
#print axioms HadwigerNelson.Plane.frame_normSq
#print axioms HadwigerNelson.Plane.sq_dist_normalPt
#print axioms HadwigerNelson.Plane.sq_dist_N
#print axioms HadwigerNelson.Plane.sq_dist_S
#print axioms HadwigerNelson.Plane.lt_iff_sq_lt_sq'
#print axioms HadwigerNelson.Plane.tanAbove_one_iff
#print axioms HadwigerNelson.Plane.tanBelow_one_iff
#print axioms HadwigerNelson.Plane.tanAbove_neg_one_iff
#print axioms HadwigerNelson.Plane.tanBelow_neg_one_iff
#print axioms HadwigerNelson.Plane.tanHeight_eq_of_ne_zero
#print axioms HadwigerNelson.Plane.tanAbove_iff_of_pos
#print axioms HadwigerNelson.Plane.tanBelow_iff_of_pos
#print axioms HadwigerNelson.Plane.conj_e_mul_e
#print axioms HadwigerNelson.Plane.frameX_sub
#print axioms HadwigerNelson.Plane.frameY_sub
#print axioms HadwigerNelson.Plane.sq_dist_frame
#print axioms HadwigerNelson.Plane.frameX_add_normal
#print axioms HadwigerNelson.Plane.frameY_add_normal
#print axioms HadwigerNelson.Plane.frameX_self
#print axioms HadwigerNelson.Plane.frameY_self
#print axioms HadwigerNelson.Plane.frameX_N
#print axioms HadwigerNelson.Plane.frameY_N
#print axioms HadwigerNelson.Plane.frameX_S
#print axioms HadwigerNelson.Plane.frameY_S
#print axioms HadwigerNelson.Plane.tanAbove_iff_of_neg
#print axioms HadwigerNelson.Plane.tanBelow_iff_of_neg
#print axioms HadwigerNelson.Plane.inv_curvUp
#print axioms HadwigerNelson.Plane.inv_curvDown
#print axioms HadwigerNelson.Plane.frameX_base_N
#print axioms HadwigerNelson.Plane.frameY_base_N
#print axioms HadwigerNelson.Plane.frameX_base_S
#print axioms HadwigerNelson.Plane.frameY_base_S
#print axioms HadwigerNelson.Plane.frameX_normalPt
#print axioms HadwigerNelson.Plane.inv_curvDown_eq

/-! ## FS-131 wave 5 (job FS131-K5) — the foundation: stuck runs, F(M) and R(M), modifications, terminal maps, Row134BaseUA -/

#print axioms HadwigerNelson.Plane.ArcMap.zero_mem_stuckRun_iff
#print axioms HadwigerNelson.Plane.ArcMap.mem_stuckRun_of_between
#print axioms HadwigerNelson.Plane.ArcMap.isChainVertex_of_mem_stuckRun
#print axioms HadwigerNelson.Plane.ArcMap.mem_stuckRun_add_pi
#print axioms HadwigerNelson.Plane.ArcMap.IsModification.refl
#print axioms HadwigerNelson.Plane.ArcMap.IsModification.trans
#print axioms HadwigerNelson.Plane.const_coloursAt_subset
#print axioms HadwigerNelson.Plane.const_qrOnly

/-! ## FS-131 wave 5 (job FS131-K5) — the skeleton: M*, the chains' ends, density (sorry until wave 5's implementer lands it) -/

#print axioms HadwigerNelson.Plane.ArcMap.stuck_structure_ua
#print axioms HadwigerNelson.Plane.ArcMap.exists_red
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminal
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_upper_of_qrOnly
#print axioms HadwigerNelson.Plane.ArcMap.flankQ_lower_of_qrOnly
#print axioms HadwigerNelson.Plane.ArcMap.cv_l0
#print axioms HadwigerNelson.Plane.ArcMap.cv_hd_main
#print axioms HadwigerNelson.Plane.ArcMap.cv_hd
#print axioms HadwigerNelson.Plane.ArcMap.cv_class
#print axioms HadwigerNelson.Plane.ArcMap.y3_end_needs
#print axioms HadwigerNelson.Plane.ArcMap.c_ends
#print axioms HadwigerNelson.Plane.ArcMap.c_double
#print axioms HadwigerNelson.Plane.ArcMap.n3_end_chain
#print axioms HadwigerNelson.Plane.ArcMap.disc1ts
#print axioms HadwigerNelson.Plane.ArcMap.disc1ts_degree
#print axioms HadwigerNelson.Plane.ArcMap.disc1_local
#print axioms HadwigerNelson.Plane.ArcMap.cor3
#print axioms HadwigerNelson.Plane.ArcMap.n3_base
#print axioms HadwigerNelson.Plane.ArcMap.localDense
#print axioms HadwigerNelson.Plane.ArcMap.dense3
#print axioms HadwigerNelson.Plane.ArcMap.cv_exists
#print axioms HadwigerNelson.Plane.sevenBrickMap_isTerminalMap
#print axioms HadwigerNelson.Plane.ArcMap.row134BaseUA
#print axioms HadwigerNelson.Plane.not_row134BaseUA_seven

/-! ## FS-131 wave 5 (job FS131-KB) — the base's skeleton: row134BaseUA's leaves (BaseWalk) (sorry until the base's implementer lands it) -/

#print axioms HadwigerNelson.Plane.CircleColouring.reduce
#print axioms HadwigerNelson.Plane.CircleColouring.select
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.cubic_of_three
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.pseudo_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.pseudo_ncard_le_two
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.pseudo_finite
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.exists_pseudoCircle
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.retArc_partner
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.retArcs_finite
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.retArcs_nested
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.exists_endpoint
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.exists_eleventh
#print axioms HadwigerNelson.Plane.ArcMap.endpoint_dist_ge
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.vin_antipodal
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.eleventh_antipodal
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.cor3_base
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.l3_base
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.hex_base
#print axioms HadwigerNelson.Plane.ArcMap.eleventh_type

/-! ## FS-131 wave 5 (job FS131-K5b) — the skeleton's last three rows: ROTHEX, BV-HEX (HexRing), CVB-THOM (MapGraph) (sorry until wave 5's implementer lands it) -/

#print axioms HadwigerNelson.Plane.Side.sign_flip
#print axioms HadwigerNelson.Plane.ArcMap.rot_noThird
#print axioms HadwigerNelson.Plane.ArcMap.rot_out
#print axioms HadwigerNelson.Plane.ArcMap.rot_in
#print axioms HadwigerNelson.Plane.ArcMap.hex_regular
#print axioms HadwigerNelson.Plane.ArcMap.p17_ua
#print axioms HadwigerNelson.Plane.ArcMap.bv_hex
#print axioms HadwigerNelson.Plane.ArcMap.bv_l3
#print axioms HadwigerNelson.Plane.ArcMap.linkage_dot_ne_zero
#print axioms HadwigerNelson.Plane.ArcMap.bv_nd
#print axioms HadwigerNelson.Plane.ArcMap.bv_nd1
#print axioms HadwigerNelson.Thomassen.lemma1
#print axioms HadwigerNelson.Thomassen.triLattice_hyps
#print axioms HadwigerNelson.Plane.ArcMap.cvb_thom_reduced
#print axioms HadwigerNelson.Plane.ArcMap.cvb_thom
#print axioms HadwigerNelson.Plane.ArcMap.cvb_pinch_connected
#print axioms HadwigerNelson.Plane.ArcMap.cvb_hole_disconnected
#print axioms HadwigerNelson.Plane.exists_holed_valid_fragment

/-! ## FS-131 wave 5 (job FS131-I5) — wave 5's first implementer: FS131-E4's repair (b) and its children, the implementer's added children -/

#print axioms HadwigerNelson.Plane.ArcMap.Unenclosed.unenclosedC
#print axioms HadwigerNelson.Plane.ArcMap.exists_preBend
#print axioms HadwigerNelson.Plane.ArcMap.exists_unenclosed_or_bad
#print axioms HadwigerNelson.Plane.ArcMap.isCubicTrichromatic_of_three_of_noRep
#print axioms HadwigerNelson.Thomassen.triLattice_adj

/-! ## FS-131 wave 5 (job FS131-I5c) — wave 5's third implementer: the brick infrastructure, the seven-colour inhabitants -/

#print axioms HadwigerNelson.Plane.mem_brickCell
#print axioms HadwigerNelson.Plane.isOpen_brickCell
#print axioms HadwigerNelson.Plane.convex_brickCell
#print axioms HadwigerNelson.Plane.closure_brickCell
#print axioms HadwigerNelson.Plane.mem_closure_brickCell
#print axioms HadwigerNelson.Plane.brickCell_eq_of_mem
#print axioms HadwigerNelson.Plane.disjoint_brickCell
#print axioms HadwigerNelson.Plane.brickCell_eq_of_mem_closure
#print axioms HadwigerNelson.Plane.sevenBrick_floor_bounds
#print axioms HadwigerNelson.Plane.sevenBrick_mem_interiorPts
#print axioms HadwigerNelson.Plane.sevenBrick_grid_of_not_mem
#print axioms HadwigerNelson.Plane.sevenBrick_grid_of_not_mem_interiorPts
#print axioms HadwigerNelson.Plane.sevenBrick_col_val
#print axioms HadwigerNelson.Plane.sevenBrick_dvd_of_col_eq
#print axioms HadwigerNelson.Plane.brickCell_pair
#print axioms HadwigerNelson.Plane.brickCell_eq_of_closure
#print axioms HadwigerNelson.Plane.sevenBrick_interiorPts_inter_ball
#print axioms HadwigerNelson.Plane.sevenBrick_component
#print axioms HadwigerNelson.Plane.sevenBrick_isSector_iff
#print axioms HadwigerNelson.Plane.sevenBrick_sector_data
#print axioms HadwigerNelson.Plane.sevenBrick_sectorsOf_subsingleton
#print axioms HadwigerNelson.Plane.sevenBrick_encard_sectorsOf_le
#print axioms HadwigerNelson.Plane.sevenBrick_not_hasRepeatedColour
#print axioms HadwigerNelson.Plane.sevenBrick_not_mergeAvailable
#print axioms HadwigerNelson.Plane.sevenBrick_isTile_iff
#print axioms HadwigerNelson.Plane.encard_brickCellsAt_le
#print axioms HadwigerNelson.Plane.sevenBrick_encard_sectors_le
#print axioms HadwigerNelson.Plane.sevenBrick_ncard_coloursAt_le
#print axioms HadwigerNelson.Plane.countable_setOf_sin_eq
#print axioms HadwigerNelson.Plane.countable_setOf_cos_eq
#print axioms HadwigerNelson.Plane.countable_circle_grid
#print axioms HadwigerNelson.Plane.branchPt_re_im
#print axioms HadwigerNelson.Plane.sevenBrick_branch_false
#print axioms HadwigerNelson.Plane.sevenBrick_not_isHorn
#print axioms HadwigerNelson.Plane.sevenBrick_ringArc_not_subset
#print axioms HadwigerNelson.Plane.sevenBrick_not_isRingArc
#print axioms HadwigerNelson.Plane.isPreconnected_compl_reProdIm_Icc
#print axioms HadwigerNelson.Plane.sevenBrick_not_isBounded_component
#print axioms HadwigerNelson.Plane.sevenBrick_unenclosedC
#print axioms HadwigerNelson.Plane.sevenBrick_baseHyp
#print axioms HadwigerNelson.Plane.sevenBrick_noInertNear
#print axioms HadwigerNelson.Plane.ArcMap.dist_le_one_of_mem_region
#print axioms HadwigerNelson.Plane.ArcMap.antipodal_aux
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_dist_le_one_antipodal
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_region_ne
#print axioms HadwigerNelson.Plane.ArcMap.exists_tileOf_of_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.antipodal_neg
#print axioms HadwigerNelson.Plane.ArcMap.exists_near_far_antipodal
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_coloursAt_of_tile_dist
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.exists_dist_eq_one
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_unique
#print axioms HadwigerNelson.Plane.ArcMap.pseudo_ncard_ne_one_of_change
#print axioms HadwigerNelson.Plane.ArcMap.germ_sub_two_pi
#print axioms HadwigerNelson.Plane.ArcMap.woodallCone_isHorn_ua
#print axioms HadwigerNelson.Plane.ArcMap.stuck_horns_ua
#print axioms HadwigerNelson.Plane.ArcMap.stuck_flanks_ua

/-! ## FS-131 wave 5 (job FS131-I5d) — wave 5's fourth implementer: `n3_end` (moved from wave 4's `BaseSteps`, inventory item 289), the unit-arc flank lemmas -/

#print axioms HadwigerNelson.Plane.ArcMap.n3_end
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_angleIcc_add_pi
#print axioms HadwigerNelson.Plane.ArcMap.shadow_of_not_shave
#print axioms HadwigerNelson.Plane.ArcMap.not_outType_N_of_flankAbove_one
#print axioms HadwigerNelson.Plane.ArcMap.not_outType_S_of_flankBelow_neg_one
#print axioms HadwigerNelson.Plane.ArcMap.srcG_of_shadow
#print axioms HadwigerNelson.Plane.ArcMap.srcH_of_shadow
#print axioms HadwigerNelson.Plane.ArcMap.dot_nonneg_of_srcG
#print axioms HadwigerNelson.Plane.ArcMap.dot_nonpos_of_srcH
#print axioms HadwigerNelson.Plane.ArcMap.region_near_of_inType
#print axioms HadwigerNelson.Plane.ArcMap.dist_N_S
#print axioms HadwigerNelson.Plane.ArcMap.region_far_S_of_srcG
#print axioms HadwigerNelson.Plane.ArcMap.region_far_N_of_srcH
#print axioms HadwigerNelson.Plane.ArcMap.flank_ne_of_shadows
#print axioms HadwigerNelson.Plane.ArcMap.exists_isRingArc_of_onRingArc
#print axioms HadwigerNelson.Plane.ArcMap.hasSectors_one_of_contacts
#print axioms HadwigerNelson.Plane.ArcMap.S_add_eq_fromFrame
#print axioms HadwigerNelson.Plane.ArcMap.fromFrame_normSq_aux
#print axioms HadwigerNelson.Plane.ArcMap.horn_radial_N
#print axioms HadwigerNelson.Plane.ArcMap.horn_radial_S
#print axioms HadwigerNelson.Plane.ArcMap.not_antipodal_coneAt_N_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.not_antipodal_coneAt_S_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.horn_poles_contact
#print axioms HadwigerNelson.Plane.ArcMap.abs_le_norm_e_sub_one
#print axioms HadwigerNelson.Plane.ArcMap.sphere_near_mem_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.coloursAt_eq
#print axioms HadwigerNelson.Plane.ArcMap.chainVertex_antipodal
#print axioms HadwigerNelson.Plane.ArcMap.IsFlankAbove.unique
#print axioms HadwigerNelson.Plane.ArcMap.horn_bounds_of_noMerge
#print axioms HadwigerNelson.Plane.ArcMap.n3_end_of_not_inType

/-! ## FS-131 wave 5 (job FS131-I5e) — wave 5's fifth implementer: `cor3` moved upstream (`Plane/ValidMap/Cor3`), its local form, `|c′| ≤ 2` -/

#print axioms HadwigerNelson.Plane.ArcMap.cor3_local
#print axioms HadwigerNelson.Plane.ArcMap.GermPseudo.mem_pseudoColours
#print axioms HadwigerNelson.Plane.ArcMap.pseudo_ncard_le_two_of_baseHyp

/-! ## FS-131 wave 5 (job FS131-I5f) — wave 5's sixth implementer: `cor3_local` proved (the crossing read through cones), the base's ring lemmas and the walk -/

#print axioms HadwigerNelson.Plane.ArcMap.e_arg_of_norm_eq_one
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.disjoint_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_ringArc_of_sides
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_coneAt_region_inter
#print axioms HadwigerNelson.Plane.ArcMap.mem_coneAt_inter_ball_of_re_neg
#print axioms HadwigerNelson.Plane.ArcMap.mem_coneAt_diff_closedBall_of_re_pos
#print axioms HadwigerNelson.Plane.ArcMap.exists_near_tangent
#print axioms HadwigerNelson.Plane.ArcMap.exists_tangent_colour
#print axioms HadwigerNelson.Plane.ArcMap.cor3_half
#print axioms HadwigerNelson.Plane.ArcMap.cor3_at
#print axioms HadwigerNelson.Plane.ArcMap.exists_crossings
#print axioms HadwigerNelson.Plane.CircleColouring.mem_S_of_ne
#print axioms HadwigerNelson.Plane.CircleColouring.leftVal_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.germ_add_int_mul
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_add_int_mul
#print axioms HadwigerNelson.Plane.ArcMap.IsRetArc.add_int_mul
#print axioms HadwigerNelson.Plane.ArcMap.IsRetArc.exists_Ico
#print axioms HadwigerNelson.Plane.ArcMap.exists_eq_of_absent
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.removable
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.exists_endpoint_third
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.third_ne
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.false
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_cw_iff
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_ccw_iff
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.exists_germPseudo

/-! ## FS-131 wave 5 (job FS131-I5b) — wave 5's second implementer: Lemma 1's children, the holed fragment -/

#print axioms HadwigerNelson.Thomassen.LocallyHamiltonian.exists_two_common
#print axioms HadwigerNelson.Thomassen.exists_eq_of_steps_up
#print axioms HadwigerNelson.Thomassen.exists_eq_of_steps
#print axioms HadwigerNelson.Thomassen.LocallyHamiltonian.two_mid
#print axioms HadwigerNelson.Plane.norm_side_of_isPreconnected
#print axioms HadwigerNelson.Plane.mem_carrier_circ_of_norm
#print axioms HadwigerNelson.Plane.norm_of_mem_carrier_circ
#print axioms HadwigerNelson.Plane.norm_of_mem_carrier_radial
#print axioms HadwigerNelson.Plane.mem_carrier_radial
#print axioms HadwigerNelson.Plane.norm_of_mem_holedArcs
#print axioms HadwigerNelson.Plane.holed_off_arcs
#print axioms HadwigerNelson.Plane.dist_lt_one_of_same_quadrant
#print axioms HadwigerNelson.Plane.holedFrag_valid
#print axioms HadwigerNelson.Plane.isPreconnected_holedAnnulus

/-! ## FS-131 wave 5 (job FS131-KP) — the planar infrastructure: plane topology, map topology, the seven planar leaves' children (sorry until the planar implementer lands them) -/

#print axioms HadwigerNelson.Plane.isPreconnected_inter_of_union_eq_univ
#print axioms HadwigerNelson.Plane.isPreconnected_compl_connectedComponentIn
#print axioms HadwigerNelson.Plane.isPreconnected_frontier_connectedComponentIn
#print axioms HadwigerNelson.Plane.exists_inter_of_finite_closed_cover
#print axioms HadwigerNelson.Plane.isBounded_connectedComponentIn_of_frontier_subset
#print axioms HadwigerNelson.Plane.connectedComponentIn_eq_of_not_isBounded
#print axioms HadwigerNelson.Plane.isPreconnected_compl_closedBall
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved
#print axioms HadwigerNelson.Plane.ringArc_cases
#print axioms HadwigerNelson.Plane.not_isHoleOf_chain
#print axioms HadwigerNelson.Plane.isHoleOf_cluster
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.subset_compl_closure
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.subset_or_subset_of_separated
#print axioms HadwigerNelson.Plane.ArcMap.exists_tile_inter_of_isOpen
#print axioms HadwigerNelson.Plane.ArcMap.exists_tile_mem_closure_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.mem_of_touch_closed
#print axioms HadwigerNelson.Plane.ArcMap.finite_tiles_closure_inter
#print axioms HadwigerNelson.Plane.ArcMap.exists_outermost
#print axioms HadwigerNelson.Plane.ArcMap.exists_rim_vertex
#print axioms HadwigerNelson.Plane.ArcMap.isCubicTrichromatic_of_three_tiles
#print axioms HadwigerNelson.Plane.ArcMap.unenclosed_of_rim_vertex
#print axioms HadwigerNelson.Plane.ArcMap.tileOf_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.exists_eleventh_of
#print axioms HadwigerNelson.Plane.ArcMap.exists_far_end
#print axioms HadwigerNelson.Plane.ArcMap.GermPseudo.eq_of_cw
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_connected
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_infinite
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_rings
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_oneInf
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_planarLike
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.retArcs_not_interleaved
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.retArcs_not_abut
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.endpoint_of_far_end
#print axioms HadwigerNelson.Thomassen.reduced_props_of_planarLike
-- FS131-IP1's added children
#print axioms HadwigerNelson.Plane.eq_of_intValued_of_isPreconnected
#print axioms HadwigerNelson.Plane.inter_frontier_nonempty_of_isPreconnected
#print axioms HadwigerNelson.Plane.frontier_connectedComponentIn_subset
#print axioms HadwigerNelson.Plane.compl_closedBall_subset_connectedComponentIn
#print axioms HadwigerNelson.Plane.ringArc_add_two_pi_mul
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_closure_of_mem_closure_biUnion
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_outerDom
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.closure_subset_closedBall_zero
#print axioms HadwigerNelson.Plane.ArcMap.exists_not_mem_closedBall_zero
#print axioms HadwigerNelson.Plane.ArcMap.outerDom_eq_connectedComponentIn
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_sector_subset_tile
#print axioms HadwigerNelson.Plane.ArcMap.hasRepeatedColour_of_two_tiles
-- FS131-IP2's added children
#print axioms HadwigerNelson.Plane.BranchGerms.eventually_dir_lt_nextDir
#print axioms HadwigerNelson.Plane.BranchGerms.dir_lt_dir
#print axioms HadwigerNelson.Plane.BranchGerms.dir_le_dir
#print axioms HadwigerNelson.Plane.BranchGerms.dir_lt_dir_zero_add
#print axioms HadwigerNelson.Plane.BranchGerms.exists_far_side
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_sector_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_two_tiles
#print axioms HadwigerNelson.Plane.ArcMap.compl_outerDom_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.outerDom_subset_of_encloses
#print axioms HadwigerNelson.Plane.ArcMap.not_encloses_of_hull_eq
#print axioms HadwigerNelson.Plane.BranchGerms.branchPt_mem_closure_sector
#print axioms HadwigerNelson.Plane.BranchGerms.eq_or_next_eq_of_mem_closure_sector
#print axioms HadwigerNelson.Plane.ArcMap.exists_isRingArc_of_touch
-- FS131-IP3's added children (`Plane/CurveGraph`, the boundary graph BG; `MapTopology` § D's star at a two-colour point)
#print axioms HadwigerNelson.Plane.line_eq_span
#print axioms HadwigerNelson.Plane.line_inter_sphere_two
#print axioms HadwigerNelson.Plane.IsCurve.eq_of_three
#print axioms HadwigerNelson.Plane.IsCurve.three_mem_ball
#print axioms HadwigerNelson.Plane.IsCurve.eq_of_inter_ball_subset
#print axioms HadwigerNelson.Plane.line_param_inj
#print axioms HadwigerNelson.Plane.circle_param_injOn
#print axioms HadwigerNelson.Plane.IsCurve.exists_param
#print axioms HadwigerNelson.Plane.star_local_ray
#print axioms HadwigerNelson.Plane.HasCurveStar.isRegularAt
#print axioms HadwigerNelson.Plane.finite_nonRegular
#print axioms HadwigerNelson.Plane.isOpen_setOf_agree
#print axioms HadwigerNelson.Plane.port_pair
#print axioms HadwigerNelson.Plane.even_sum_deg
#print axioms HadwigerNelson.Plane.exists_finset_even_sum_deg
#print axioms HadwigerNelson.Plane.isCurve_curveAt
#print axioms HadwigerNelson.Plane.e_arg_mul_e
#print axioms HadwigerNelson.Plane.exists_curveGerm_eq
#print axioms HadwigerNelson.Plane.branch_locally_curve
#print axioms HadwigerNelson.Plane.hasCurveStar_of_branch
#print axioms HadwigerNelson.Plane.HasCurveStar.connectedComponentIn
#print axioms HadwigerNelson.Plane.IsCurve.exists_two_mem_sphere
#print axioms HadwigerNelson.Plane.not_isRegularAt_of_hasCurveStar_one
#print axioms HadwigerNelson.Plane.halfLine_hasCurveStar
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.col_eq_of_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.col_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.hasRepeatedColour_of_col_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.eq_two
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.inter_closure_two
#print axioms HadwigerNelson.Plane.ArcMap.hasCurveStar_of_branches
#print axioms HadwigerNelson.Plane.ArcMap.fin_two_eq_of_ne
#print axioms HadwigerNelson.Plane.ArcMap.exists_inner_branch
-- FS131-IP4's added children (`MapTopology` § E, one-sidedness: the orientation step; `BaseWalk`'s `orient_pair`)
#print axioms HadwigerNelson.Plane.ringPt_eq_polarPt
#print axioms HadwigerNelson.Plane.polarPt_ne_of_sub
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved_radius
#print axioms HadwigerNelson.Plane.orient_aux
#print axioms HadwigerNelson.Plane.orient
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.sector_subset_tile_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.tile_side
#print axioms HadwigerNelson.Plane.ArcMap.germ_side
#print axioms HadwigerNelson.Plane.ArcMap.TileOf.eq_colour
#print axioms HadwigerNelson.Plane.ArcMap.GermPseudo.congr_e
#print axioms HadwigerNelson.Plane.ArcMap.GermPseudo.eq_of_same
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.orient_pair
#print axioms HadwigerNelson.Plane.hasCurveStar_zero
#print axioms HadwigerNelson.Plane.exists_annular_out
#print axioms HadwigerNelson.Plane.exists_annular_in
#print axioms HadwigerNelson.Plane.subset_or_subset_of_closed
#print axioms HadwigerNelson.Plane.side_contra
#print axioms HadwigerNelson.Plane.branch_side
#print axioms HadwigerNelson.Plane.exists_Ico_ringPt
#print axioms HadwigerNelson.Plane.disjoint_closedBall_of_isOpen
#print axioms HadwigerNelson.Plane.BranchGerms.shared_germ3
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.tile_inter_ball_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.mem_closure_some_sector
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_subset_near
#print axioms HadwigerNelson.Plane.ArcMap.germ_side_cw
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_of_side
#print axioms HadwigerNelson.Plane.ArcMap.inner_star
#print axioms HadwigerNelson.Plane.ArcMap.circ_local
#print axioms HadwigerNelson.Plane.ArcMap.BaseCtx.colours_sub
-- FS131-IP5's added children (`MapGraph`: holes and filled tiles, nesting, every tile in an outer fill)
#print axioms HadwigerNelson.Plane.ArcMap.IsHoleOf.isOpen
#print axioms HadwigerNelson.Plane.ArcMap.IsHoleOf.isOpen_diff
#print axioms HadwigerNelson.Plane.ArcMap.IsHoleOf.connectedComponentIn_subset
#print axioms HadwigerNelson.Plane.ArcMap.IsHoleOf.subset_compl_outerDom
#print axioms HadwigerNelson.Plane.ArcMap.fill_subset_compl_outerDom
#print axioms HadwigerNelson.Plane.ArcMap.subset_fill
#print axioms HadwigerNelson.Plane.ArcMap.closure_fill_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.encloses_of_subset_hole
#print axioms HadwigerNelson.Plane.ArcMap.hole_subset_hole
#print axioms HadwigerNelson.Plane.ArcMap.fill_subset_hole
#print axioms HadwigerNelson.Plane.ArcMap.exists_outer_fill
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_reachable_of_inter
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_reachable_of_subset
#print axioms HadwigerNelson.Plane.ArcMap.eq_or_subset_hole_of_inter
#print axioms HadwigerNelson.Plane.ArcMap.subset_fill_of_inter
#print axioms HadwigerNelson.Plane.ArcMap.IsOuterTile.disjoint_closure_fill
#print axioms HadwigerNelson.Plane.ArcMap.reachable_offTwo_of_inter
#print axioms HadwigerNelson.Plane.ArcMap.subset_compl_of_inter_compl
#print axioms HadwigerNelson.Plane.ArcMap.subset_compl_of_mem_offTwo
#print axioms HadwigerNelson.Plane.ArcMap.exists_outer_fill_offTwo
#print axioms HadwigerNelson.Plane.ArcMap.offTwo_infinite
#print axioms HadwigerNelson.Plane.ArcMap.exists_far_component
#print axioms HadwigerNelson.Plane.ArcMap.isHoleOf_inter_of_split
#print axioms HadwigerNelson.Plane.ArcMap.not_split_aux
#print axioms HadwigerNelson.Plane.ArcMap.isPreconnected_closure_union_aux
#print axioms HadwigerNelson.Plane.ArcMap.not_isHoleOf_union
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_closure_sUnion_holes
#print axioms HadwigerNelson.Plane.ArcMap.not_isHoleOf_closure_fill
#print axioms HadwigerNelson.Plane.ArcMap.isPreconnected_closure_fill
#print axioms HadwigerNelson.Plane.ArcMap.mem_of_touch_closed_of_not_isHoleOf
#print axioms HadwigerNelson.Plane.ArcMap.isBounded_closure_fill
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_offTwo_connected
#print axioms HadwigerNelson.Plane.mem_closure_of_path
#print axioms HadwigerNelson.Plane.eventually_path_mem
#print axioms HadwigerNelson.Plane.mem_disc_minus_iff
#print axioms HadwigerNelson.Plane.mem_closure_disc_minus
#print axioms HadwigerNelson.Plane.mem_closure_disc_minus_tangent
#print axioms HadwigerNelson.Plane.sq_norm_sub_ofReal
#print axioms HadwigerNelson.Plane.norm_le_iff_sq
#print axioms HadwigerNelson.Plane.compl_closure_disc_minus_subset
#print axioms HadwigerNelson.Plane.closure_disc_minus_subset
#print axioms HadwigerNelson.Plane.sq_facts
#print axioms HadwigerNelson.Plane.ArcMap.getElem?_flatMap_replicate_four
#print axioms HadwigerNelson.Plane.ArcMap.length_flatMap_replicate_four
#print axioms HadwigerNelson.Plane.ArcMap.isRing_flatMap_replicate_four
#print axioms HadwigerNelson.Plane.ArcMap.twiceApart_flatMap_replicate_four
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_ringList
-- FS131-RL1's children (the boundary walk)
#print axioms HadwigerNelson.Plane.isPreconnected_diff_ball
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved_exterior
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_adj_iff
#print axioms HadwigerNelson.Plane.ArcMap.IsBoundaryWalk.cons
#print axioms HadwigerNelson.Plane.ArcMap.IsBoundaryWalk.sep
#print axioms HadwigerNelson.Plane.ArcMap.IsBoundaryWalk.isRing
#print axioms HadwigerNelson.Plane.ArcMap.exists_boundaryWalk
-- FS131-RW1's children (WALK: the frontier of a filled tile)
#print axioms HadwigerNelson.Plane.ArcMap.frontier_closure_fill_subset
#print axioms HadwigerNelson.Plane.ArcMap.isPreconnected_frontier_closure_fill
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.subset_fill_or_subset_compl
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.isOpen_fill
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_tile_superset
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.near_branch
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_chart_pos
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_branch_iff
#print axioms HadwigerNelson.Plane.ArcMap.branchPt_ne_of_ne
#print axioms HadwigerNelson.Plane.ArcMap.hasCurveStar_of_branches_finset
#print axioms HadwigerNelson.Plane.ArcMap.even_card_filter_ne_next
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_inter_ball
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_hasCurveStar
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.gamma_inter_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.eq_two_of_isRegularAt
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_exists_ray
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_isRegularAt
#print axioms HadwigerNelson.Plane.ArcMap.finite_frontier_fill_nonRegular
#print axioms HadwigerNelson.Plane.ArcMap.BasedTrail.append
#print axioms HadwigerNelson.Plane.ArcMap.BasedTrail.exists_start
#print axioms HadwigerNelson.Plane.ArcMap.BasedTrail.insert
#print axioms HadwigerNelson.Plane.ArcMap.exists_vertex_involution
#print axioms HadwigerNelson.Plane.ArcMap.minimalPeriod_perm_pos
#print axioms HadwigerNelson.Plane.ArcMap.pow_minimalPeriod_apply
#print axioms HadwigerNelson.Plane.ArcMap.mem_orbList
#print axioms HadwigerNelson.Plane.ArcMap.nodup_orbList
#print axioms HadwigerNelson.Plane.ArcMap.orbList_closed
#print axioms HadwigerNelson.Plane.ArcMap.pow_mem_of_closed
#print axioms HadwigerNelson.Plane.ArcMap.basedTrail_orbList
#print axioms HadwigerNelson.Plane.ArcMap.pow_sigma_pow
#print axioms HadwigerNelson.Plane.ArcMap.sigma_ne_pow
#print axioms HadwigerNelson.Plane.ArcMap.exists_euler

-- FS131-RW2's children (WALK: the port graph of a filled tile's frontier, its edges, the Euler circuit's assembly)
#print axioms HadwigerNelson.Plane.port_arc
#print axioms HadwigerNelson.Plane.ArcMap.ray_piece
#print axioms HadwigerNelson.Plane.ArcMap.isPreconnected_inter_ball_of_hasCurveStar
#print axioms HadwigerNelson.Plane.ArcMap.exists_Ioo_of_preimage_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsPortGraph.exists_shared_vertex
#print axioms HadwigerNelson.Plane.ArcMap.exists_isPortGraph
#print axioms HadwigerNelson.Plane.ArcMap.subset_of_isPreconnected_of_locally
#print axioms HadwigerNelson.Plane.ArcMap.nonempty_frontier_closure_fill
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_hasCurveStar_pos
#print axioms HadwigerNelson.Plane.ArcMap.closure_inter_subset_frontier_fill
#print axioms HadwigerNelson.Plane.ArcMap.isOuterTile_of_closure_inter
#print axioms HadwigerNelson.Plane.ArcMap.nextDir_two
#print axioms HadwigerNelson.Plane.ArcMap.sector_inter_sphere
#print axioms HadwigerNelson.Plane.ArcMap.frontier_fill_regular_local
#print axioms HadwigerNelson.Plane.ArcMap.exists_edgeOf
#print axioms HadwigerNelson.Plane.ArcMap.BasedTrail.map
#print axioms HadwigerNelson.Plane.ArcMap.BasedTrail.insert_all
#print axioms HadwigerNelson.Plane.ArcMap.isBoundaryWalk_of_trail
-- FS131-RS1's children (SEP: the repeated tile separates)
#print axioms HadwigerNelson.Plane.mod_prev_succ
#print axioms HadwigerNelson.Plane.isPreconnected_biUnion_Icc_mod
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved_exterior_of_isClosed
#print axioms HadwigerNelson.Plane.isPreconnected_union_insert_diff_ball
#print axioms HadwigerNelson.Plane.ArcMap.exists_isClosed_of_reachable_offTwo
#print axioms HadwigerNelson.Plane.ArcMap.IsEdgeOf.disjoint_closure_ball
#print axioms HadwigerNelson.Plane.ArcMap.mod_succ_prev
#print axioms HadwigerNelson.Plane.ArcMap.IsBoundaryWalk.exists_piece

/-! ## FS-131 wave 4 (job FS131-I4c) — the implementer's added children (FS106-L's geometric step and sweeps; TS-T's regions) -/

#print axioms HadwigerNelson.Plane.dot_e_e
#print axioms HadwigerNelson.Plane.dot_ofReal_mul
#print axioms HadwigerNelson.Plane.dot_add_left
#print axioms HadwigerNelson.Plane.abs_dot_e_le
#print axioms HadwigerNelson.Plane.dist_add_e_sq
#print axioms HadwigerNelson.Plane.exists_dist_add_e_eq_one
#print axioms HadwigerNelson.Plane.exists_double_unit_circle
#print axioms HadwigerNelson.Plane.isOpen_shadow
#print axioms HadwigerNelson.Plane.disjoint_shadow
#print axioms HadwigerNelson.Plane.shadow_subset_closure_shadow
#print axioms HadwigerNelson.Plane.AeProperRegions.unitPairsNull_cls
#print axioms HadwigerNelson.Plane.AeProperRegions.IsRegion.subset
#print axioms HadwigerNelson.Plane.AeProperRegions.IsRegion.isPreconnected
#print axioms HadwigerNelson.Plane.AeProperRegions.IsRegion.chain_step
#print axioms HadwigerNelson.Plane.AeProperRegions.IsRegion.dist_lt_one

/-! ## FS-131 wave 4, `Contact` (job FS131-IC1) — the implementer's added children and proved leaves -/

#print axioms HadwigerNelson.Plane.tanHeight_anti
#print axioms HadwigerNelson.Plane.hornSet_mono
#print axioms HadwigerNelson.Plane.dot_comm'
#print axioms HadwigerNelson.Plane.dot_self_eq
#print axioms HadwigerNelson.Plane.sq_norm_sub_add_smul
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_tiles_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.tileOf_component
#print axioms HadwigerNelson.Plane.hornSet_congr
#print axioms HadwigerNelson.Plane.tanHeight_branchPt
#print axioms HadwigerNelson.Plane.frameX_branchPt_pos
#print axioms HadwigerNelson.Plane.branchPt_mem_hornSet
#print axioms HadwigerNelson.Plane.exists_small_s
#print axioms HadwigerNelson.Plane.sin_zero_of_two
#print axioms HadwigerNelson.Plane.e_eq_or_of_sin_sub_eq_zero
#print axioms HadwigerNelson.Plane.dot_neg_right
#print axioms HadwigerNelson.Plane.e_add_pi'
#print axioms HadwigerNelson.Plane.dot_e_eq_frameX
#print axioms HadwigerNelson.Plane.dot_e_add_pi_div_two_eq_frameY
#print axioms HadwigerNelson.Plane.interior_nonempty_of_not_mem
#print axioms HadwigerNelson.Plane.curv_le_one_of_avoid
#print axioms HadwigerNelson.Plane.neg_one_le_curv_of_avoid
#print axioms HadwigerNelson.Plane.continuous_branchPt_curv
#print axioms HadwigerNelson.Plane.branchPt_mem_closure_hornSet_upper
#print axioms HadwigerNelson.Plane.branchPt_mem_closure_hornSet_lower
#print axioms HadwigerNelson.Plane.dist_branchPt_one
#print axioms HadwigerNelson.Plane.dist_branchPt_neg_one
#print axioms HadwigerNelson.Plane.ArcMap.inType_iff
#print axioms HadwigerNelson.Plane.ArcMap.outType_iff
#print axioms HadwigerNelson.Plane.ArcMap.not_inType_both
#print axioms HadwigerNelson.Plane.ArcMap.woodall_contacts
#print axioms HadwigerNelson.Plane.ArcMap.sector_subset_tile
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.horn_of_cone_sin
#print axioms HadwigerNelson.Plane.ArcMap.one_le_dist_of_outType
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_interiorPts_of_mem_closure_sector
#print axioms HadwigerNelson.Plane.ArcMap.false_of_branch_on_sphere

/-! ## FS-131 wave 4, `Contact` (job FS131-IC2) — the second implementer's added children and proved leaves -/

#print axioms HadwigerNelson.Plane.ArcMap.shaveAvailable_of_adjacent_horns
#print axioms HadwigerNelson.Plane.mem_coneAt_hornSet
#print axioms HadwigerNelson.Plane.e_eq_of_mem_coneAt_hornSet
#print axioms HadwigerNelson.Plane.dot_neg_left
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.congr
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.eventually_subset_region
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.mem_coneAt_region
#print axioms HadwigerNelson.Plane.ArcMap.exists_hasSectors
#print axioms HadwigerNelson.Plane.ArcMap.e_eq_or_of_two_horns
#print axioms HadwigerNelson.Plane.ArcMap.covers_of_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.stuck_neighbour
#print axioms HadwigerNelson.Plane.ArcMap.stuck_flip
#print axioms HadwigerNelson.Plane.ArcMap.stuck_step

/-! ## FS-131 wave 4, `Contact` (job FS131-IC3) — the third implementer's added children and proved leaves -/

#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.index_of_isSector_hornSet
#print axioms HadwigerNelson.Plane.ArcMap.woodallCone_isHorn
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.eq_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.horn_unique_of_stuck
#print axioms HadwigerNelson.Plane.ArcMap.stuck_horns
#print axioms HadwigerNelson.Plane.abs_frameX_sub_le
#print axioms HadwigerNelson.Plane.abs_frameY_le_norm
#print axioms HadwigerNelson.Plane.abs_frameY_le_of_mem_hornSet
#print axioms HadwigerNelson.Plane.half_norm_le_frameX
#print axioms HadwigerNelson.Plane.dist_push_up_lt_one
#print axioms HadwigerNelson.Plane.dist_push_down_lt_one
#print axioms HadwigerNelson.Plane.hornSet_mono_radius
#print axioms HadwigerNelson.Plane.abs_le_sq_of_near_axis
#print axioms HadwigerNelson.Plane.exists_push_up
#print axioms HadwigerNelson.Plane.exists_push_down
#print axioms HadwigerNelson.Plane.ArcMap.false_of_pole
#print axioms HadwigerNelson.Plane.ArcMap.IsFlankAbove.mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.IsFlankBelow.mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.horn_not_shadowed_near_N
#print axioms HadwigerNelson.Plane.ArcMap.horn_not_shadowed_near_S
#print axioms HadwigerNelson.Plane.ArcMap.dot_e_sub_eq_frameX
#print axioms HadwigerNelson.Plane.ArcMap.shadow_ineq_in
#print axioms HadwigerNelson.Plane.ArcMap.shadow_ineq_out
#print axioms HadwigerNelson.Plane.ArcMap.norm_pos_of_frameX_pos
#print axioms HadwigerNelson.Plane.ArcMap.eq_N_or_S_of_frameX_eq_zero
#print axioms HadwigerNelson.Plane.ArcMap.shadow_local_contact
#print axioms HadwigerNelson.Plane.ArcMap.shadow_source_near_poles
#print axioms HadwigerNelson.Plane.ArcMap.horn_shadow_near_S
#print axioms HadwigerNelson.Plane.ArcMap.horn_shadow_near_N
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_hornSet_near
#print axioms HadwigerNelson.Plane.ArcMap.outType_S_of_shadow
#print axioms HadwigerNelson.Plane.ArcMap.outType_N_of_shadow
#print axioms HadwigerNelson.Plane.not_tanBelow_branchPt
#print axioms HadwigerNelson.Plane.not_tanAbove_branchPt
#print axioms HadwigerNelson.Plane.hornSet_curv_eq
#print axioms HadwigerNelson.Plane.e_add_pi_ne
#print axioms HadwigerNelson.Plane.exists_abs_arcsin_lt
#print axioms HadwigerNelson.Plane.abs_half_lt
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.exists_chart_index
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_col
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_flank_after
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_flank_before
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.exists_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.IsHorn.exists_flankBelow

/-! ## FS-131 wave 4, `Contact` (job FS131-IC4) — the fourth implementer's added children and proved leaves -/

#print axioms HadwigerNelson.Plane.flank_back_aux
#print axioms HadwigerNelson.Plane.flank_higher_aux
#print axioms HadwigerNelson.Plane.sin_lt_of_cos_pos
#print axioms HadwigerNelson.Plane.lt_sin_of_cos_pos
#print axioms HadwigerNelson.Plane.flank_half_le_aux
#print axioms HadwigerNelson.Plane.abs_frameY_of_horn_le
#print axioms HadwigerNelson.Plane.flank_lt_one_aux
#print axioms HadwigerNelson.Plane.ArcMap.outType_S_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.sector_subset_tile
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_lift_lower
#print axioms HadwigerNelson.Plane.BranchGerms.frameY_lt_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_horn_before
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.mem_shadow_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_next_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.sector_shadow_S
#print axioms HadwigerNelson.Plane.ArcMap.shadow_of_tangent_sector_S
#print axioms HadwigerNelson.Plane.ArcMap.flank_shadow_g
#print axioms HadwigerNelson.Plane.ArcMap.outType_N_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_lift_upper
#print axioms HadwigerNelson.Plane.BranchGerms.lt_frameY_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_horn_after
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.sector_shadow_N
#print axioms HadwigerNelson.Plane.ArcMap.shadow_of_tangent_sector_N
#print axioms HadwigerNelson.Plane.ArcMap.flank_shadow_h

/-! ## FS-131 wave 4, `Contact` (job FS131-IC5) — the fifth implementer's added children and proved leaves -/

#print axioms HadwigerNelson.Plane.ArcMap.flank_shadow_g_chart
#print axioms HadwigerNelson.Plane.ArcMap.flank_shadow_h_chart
#print axioms HadwigerNelson.Plane.BranchGerms.exists_mem_angleIcc
#print axioms HadwigerNelson.Plane.frameX_add_pi
#print axioms HadwigerNelson.Plane.sub_e_add_pi_add
#print axioms HadwigerNelson.Plane.add_e_add_pi_add
#print axioms HadwigerNelson.Plane.curvDown_lt_curvDown
#print axioms HadwigerNelson.Plane.curvUp_lt_curvUp
#print axioms HadwigerNelson.Plane.sin_nonpos_of_not_mem_angleIoo
#print axioms HadwigerNelson.Plane.exists_dist_lt_one_of_coneAt
#print axioms HadwigerNelson.Plane.BranchGerms.branchPt_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.subset_region
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.col_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_sector_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.eventually_one_le_sectorsOf
#print axioms HadwigerNelson.Plane.ArcMap.exists_tile_dir
#print axioms HadwigerNelson.Plane.ArcMap.false_of_all_outType
#print axioms HadwigerNelson.Plane.ArcMap.region_far_of_outType
#print axioms HadwigerNelson.Plane.ArcMap.eventually_col_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.outType_N_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.outType_S_of_flankBelow
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.neg_one_lt_of_outType_N
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.lt_one_of_outType_S
#print axioms HadwigerNelson.Plane.ArcMap.IsFlankAbove.congr
#print axioms HadwigerNelson.Plane.ArcMap.IsFlankBelow.congr
#print axioms HadwigerNelson.Plane.ArcMap.DoublyShadowed.congr
#print axioms HadwigerNelson.Plane.ArcMap.false_of_third_point
#print axioms HadwigerNelson.Plane.ArcMap.flank_ne_of_doublyShadowed
#print axioms HadwigerNelson.Plane.ArcMap.stuck_pole_N
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_of_three_colours
#print axioms HadwigerNelson.Plane.ArcMap.add_e_ne_sub_e
#print axioms HadwigerNelson.Plane.ArcMap.stuck_structure_flanks

/-! ## FS-131 wave 5 (job FS131-I5g) — wave 5's seventh implementer: the base's circle-abstract leaves (`reduce`, `select`), `l3_base`, the hexagonal ring -/

#print axioms HadwigerNelson.Plane.CircleColouring.reduce_leftVal_add_int_mul
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_rightVal_add_int_mul
#print axioms HadwigerNelson.Plane.CircleColouring.Removable.add_int_mul
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_nearOnly
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_exists_max
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_left_uncov
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_right_uncov
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_zmod3
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_partner_noChange
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_leftVal_ne
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_vals_of_const
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_locConst
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_proper_off
#print axioms HadwigerNelson.Plane.CircleColouring.reduce_int_eq_zero
#print axioms HadwigerNelson.Plane.CircleColouring.select_bdd
#print axioms HadwigerNelson.Plane.CircleColouring.select_firstPassage
#print axioms HadwigerNelson.Plane.CircleColouring.select_unique
#print axioms HadwigerNelson.Plane.CircleColouring.select_lt
#print axioms HadwigerNelson.Plane.CircleColouring.select_window
#print axioms HadwigerNelson.Plane.CircleColouring.select_window'
#print axioms HadwigerNelson.Plane.CircleColouring.select_chord
#print axioms HadwigerNelson.Plane.CircleColouring.select_residue
#print axioms HadwigerNelson.Plane.CircleColouring.select_core
#print axioms HadwigerNelson.Plane.CircleColouring.link_side_right
#print axioms HadwigerNelson.Plane.CircleColouring.link_side_left
#print axioms HadwigerNelson.Plane.CircleColouring.link_val_right
#print axioms HadwigerNelson.Plane.CircleColouring.link_val_left
#print axioms HadwigerNelson.Plane.CircleColouring.link_path
#print axioms HadwigerNelson.Plane.CircleColouring.link_relabel
#print axioms HadwigerNelson.Plane.CircleColouring.link_periodic_finite
#print axioms HadwigerNelson.Plane.ArcMap.link_cos_fibre
#print axioms HadwigerNelson.Plane.ArcMap.link_circles_rep
#print axioms HadwigerNelson.Plane.ArcMap.link_circles_two
#print axioms HadwigerNelson.Plane.ArcMap.link_circles_finite
#print axioms HadwigerNelson.Plane.ArcMap.link_norm_e_sub_sq
#print axioms HadwigerNelson.Plane.ArcMap.link_cos_eq_of_ringPt
#print axioms HadwigerNelson.Plane.ArcMap.link_fibres
#print axioms HadwigerNelson.Plane.ArcMap.link_turn
#print axioms HadwigerNelson.Plane.ArcMap.link_flip
#print axioms HadwigerNelson.Plane.ArcMap.link_dist_ringPt_sq
#print axioms HadwigerNelson.Plane.ArcMap.link_partners
#print axioms HadwigerNelson.Plane.ArcMap.link_one_lt_two
#print axioms HadwigerNelson.Plane.ArcMap.exists_linkage
-- FS131-I5j (stage 31): `coneAt_of_cubic`, the hexagon count, BV-HEX's steps
#print axioms HadwigerNelson.Plane.ArcMap.hex_int_core
#print axioms HadwigerNelson.Plane.ArcMap.hex_int_noAdj
#print axioms HadwigerNelson.Plane.ArcMap.exists_halfTurn_of_cos_nonpos
#print axioms HadwigerNelson.Plane.ArcMap.eq_floor_of_floor_eq_ceil
#print axioms HadwigerNelson.Plane.ArcMap.hex_real_core
#print axioms HadwigerNelson.Plane.ArcMap.angleIcc_add_int_mul
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_of_cubic
#print axioms HadwigerNelson.Plane.ArcMap.hex_cones_of_serve
#print axioms HadwigerNelson.Plane.ArcMap.subset_closure_region_of_isOpen
#print axioms HadwigerNelson.Plane.ArcMap.Valid.cone_re_nonneg_of_preconnected
#print axioms HadwigerNelson.Plane.ArcMap.GermPseudo.germIn_closure
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_add_two_pi
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_add_two_pi'
#print axioms HadwigerNelson.Plane.ArcMap.hex_side
#print axioms HadwigerNelson.Plane.ArcMap.dist_eFrame
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_frame
#print axioms HadwigerNelson.Plane.ArcMap.e_hex_re_im
#print axioms HadwigerNelson.Plane.ArcMap.hex_point
#print axioms HadwigerNelson.Plane.ArcMap.hex_adjacent
#print axioms HadwigerNelson.Plane.ArcMap.dist_radial_hex
-- FS131-I5m (stage 35): `rot_in`'s children, BV-HEX's steps mirrored inward
#print axioms HadwigerNelson.Plane.ArcMap.hex_side_far
#print axioms HadwigerNelson.Plane.ArcMap.Valid.cone_re_nonpos_of_preconnected
#print axioms HadwigerNelson.Plane.ArcMap.dist_radial_hex_in
#print axioms HadwigerNelson.Plane.ArcMap.hex_point_in
-- FS131-I5m (stage 36): `bv_nd`'s children, BV-ND steps 2–4
#print axioms HadwigerNelson.Plane.ArcMap.sq_dist_germ
#print axioms HadwigerNelson.Plane.ArcMap.germ_dist_cmp_one
#print axioms HadwigerNelson.Plane.ArcMap.exists_chart_of_noRep
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_sector_of_region
#print axioms HadwigerNelson.Plane.ArcMap.BranchGerms.next_adj
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_shared
#print axioms HadwigerNelson.Plane.ArcMap.Valid.pair_le
#print axioms HadwigerNelson.Plane.ArcMap.Valid.pair_ge
#print axioms HadwigerNelson.Plane.ArcMap.tangent_pair_ne_one
-- FS131-I5m (stage 37): the linkage to first order, children for `bv_l3`
#print axioms HadwigerNelson.Plane.ArcMap.dot_ringPt_sub
#print axioms HadwigerNelson.Plane.ArcMap.linkage_first_order
#print axioms HadwigerNelson.Plane.ArcMap.half_le_sin
#print axioms HadwigerNelson.Plane.ArcMap.linkage_cmp
#print axioms HadwigerNelson.Plane.ArcMap.linkage_end
-- FS131-I5o (stage 40): FS106-TS-T on a square inside a fragment, children of `disc1_local`
#print axioms HadwigerNelson.Plane.IsRegOf.subset
#print axioms HadwigerNelson.Plane.IsRegOf.isPreconnected
#print axioms HadwigerNelson.Plane.IsRegOf.chain_step
#print axioms HadwigerNelson.Plane.IsRegOf.dist_lt_one
#print axioms HadwigerNelson.Plane.exists_three_le_multicolour_square
#print axioms HadwigerNelson.Plane.ArcMap.exists_three_le_coloursAt_square
#print axioms HadwigerNelson.Plane.ArcMap.closedSquare_subset_closedBall
-- FS131-KB2 (stage 44): the collar bend, `exists_preBend`'s child (sorry until constructed)
#print axioms HadwigerNelson.Plane.ArcMap.bend_toward_collar
-- FS131-KB2 (stage 45): `exists_preBend`'s iteration — the measure's children (sorry but the last) and the step
#print axioms HadwigerNelson.Plane.ArcMap.finite_maxRingArcs
#print axioms HadwigerNelson.Plane.exists_shift_of_ringArc_subset
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.shift
#print axioms HadwigerNelson.Plane.ArcMap.exists_maxRingArc
#print axioms HadwigerNelson.Plane.ArcMap.hfree_of_baseHyp
#print axioms HadwigerNelson.Plane.ArcMap.ncard_coloursAt_le_two_of_mem_openArc
#print axioms HadwigerNelson.Plane.ArcMap.maxRingArcs_subset_of_bend
#print axioms HadwigerNelson.Plane.ArcMap.unenclosedC_of_homeomorph
#print axioms HadwigerNelson.Plane.ArcMap.exists_preBend_step
#print axioms HadwigerNelson.Plane.ArcMap.not_hasRepeatedColour_of_mem_interiorPts
-- FS131-KP2: the collar bend laid out as children (`Plane/ValidMap/RadialPush`, `Pushforward`, `BendCollar`; sorry but the marked few)
#print axioms HadwigerNelson.Plane.push1_mid
#print axioms HadwigerNelson.Plane.push1_of_not_mem
#print axioms HadwigerNelson.Plane.push1_push1
#print axioms HadwigerNelson.Plane.push1_image_Ico
#print axioms HadwigerNelson.Plane.push1_image_Ioc
#print axioms HadwigerNelson.Plane.pushInv_pushFun
#print axioms HadwigerNelson.Plane.pushFun_pushInv
#print axioms HadwigerNelson.Plane.continuous_pushFun
#print axioms HadwigerNelson.Plane.continuous_pushInv
#print axioms HadwigerNelson.Plane.pushHomeo_polar
#print axioms HadwigerNelson.Plane.pushHomeo_eq_self
#print axioms HadwigerNelson.Plane.pushHomeo_image_polarSet
#print axioms HadwigerNelson.Plane.tangRad_zero
#print axioms HadwigerNelson.Plane.tangRad_spec
#print axioms HadwigerNelson.Plane.tangRad_lt_one
#print axioms HadwigerNelson.Plane.one_lt_tangRad
#print axioms HadwigerNelson.Plane.tangRad_lt_tangRad
#print axioms HadwigerNelson.Plane.one_sub_tangRad_le
#print axioms HadwigerNelson.Plane.tangRad_sub_one_le
#print axioms HadwigerNelson.Plane.pushProfiles_collar
#print axioms HadwigerNelson.Plane.one_sub_lensProf_le
#print axioms HadwigerNelson.Plane.collarArcs_carrier
#print axioms HadwigerNelson.Plane.dist_lt_one_of_mem_polarSet
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_Γ
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_mem_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_col_apply
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_region
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_charts
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFit
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.kin_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.kout_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.pushProfiles
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_eq_self
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_ringPt
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_fix_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_image_dom
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.collarArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.collarArcs_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.collarArcs_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_valid
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.degree_openArc
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_lensCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hasRepeatedColour
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_R3
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.side_ne_inner_of_mem_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_inert
-- FS131-CG1: lane G's supporting lemmas (`Plane/ValidMap/RadialPush`: the radial push, the tangent circles, the lens boundary; `Plane/ValidMap/CollarMap`: the collar's map)
#print axioms HadwigerNelson.Plane.tent_nonneg
#print axioms HadwigerNelson.Plane.tent_of_le_left
#print axioms HadwigerNelson.Plane.tent_le_one
#print axioms HadwigerNelson.Plane.tent_of_le_mid
#print axioms HadwigerNelson.Plane.tent_of_mid_le
#print axioms HadwigerNelson.Plane.push1_of_le_mid
#print axioms HadwigerNelson.Plane.push1_of_mid_le
#print axioms HadwigerNelson.Plane.push1_self
#print axioms HadwigerNelson.Plane.push1_mem_Ico
#print axioms HadwigerNelson.Plane.push1_mem_Ioc
#print axioms HadwigerNelson.Plane.PushProfiles.cases
#print axioms HadwigerNelson.Plane.PushProfiles.a_pos
#print axioms HadwigerNelson.Plane.PushProfiles.exists_a_ge
#print axioms HadwigerNelson.Plane.polarAngle_mem
#print axioms HadwigerNelson.Plane.eq_polar_polarAngle
#print axioms HadwigerNelson.Plane.polarAngle_polar
#print axioms HadwigerNelson.Plane.abs_sub_bisector_le
#print axioms HadwigerNelson.Plane.mem_window_of_mem_Icc
#print axioms HadwigerNelson.Plane.radialMap_id
#print axioms HadwigerNelson.Plane.pushFun_eq_radialMap
#print axioms HadwigerNelson.Plane.pushInv_eq_radialMap
#print axioms HadwigerNelson.Plane.radialMap_center
#print axioms HadwigerNelson.Plane.radialMap_polar
#print axioms HadwigerNelson.Plane.radialMap_eq_self
#print axioms HadwigerNelson.Plane.radialMap_radialMap
#print axioms HadwigerNelson.Plane.push1_zero
#print axioms HadwigerNelson.Plane.push1_pos
#print axioms HadwigerNelson.Plane.PushProfiles.push1_zero
#print axioms HadwigerNelson.Plane.PushProfiles.push1_pos
#print axioms HadwigerNelson.Plane.PushProfiles.push1_push1
#print axioms HadwigerNelson.Plane.radialMap_push1_eq
#print axioms HadwigerNelson.Plane.continuous_radialMap_push1
#print axioms HadwigerNelson.Plane.tangRad_quad
#print axioms HadwigerNelson.Plane.tangRad_pos
#print axioms HadwigerNelson.Plane.le_tangRad_iff
#print axioms HadwigerNelson.Plane.tangRad_le_iff
#print axioms HadwigerNelson.Plane.lt_tangRad_iff
#print axioms HadwigerNelson.Plane.tangRad_root
#print axioms HadwigerNelson.Plane.cos_lt_one_of_abs
#print axioms HadwigerNelson.Plane.continuous_tangRad
#print axioms HadwigerNelson.Plane.tangRad_identity
#print axioms HadwigerNelson.Plane.tangRad_anti
#print axioms HadwigerNelson.Plane.eq_of_tangentCircle
#print axioms HadwigerNelson.Plane.germ_tangentCircle
#print axioms HadwigerNelson.Plane.polar_tangentCircle
#print axioms HadwigerNelson.Plane.norm_tangRad_sub_one_le
#print axioms HadwigerNelson.Plane.tangentArc_image
#print axioms HadwigerNelson.Plane.collarMid_eq
#print axioms HadwigerNelson.Plane.dist_collarMid_left
#print axioms HadwigerNelson.Plane.dist_collarMid_right
#print axioms HadwigerNelson.Plane.norm_tangRad_sub_one_pos
#print axioms HadwigerNelson.Plane.polarSet_mono
#print axioms HadwigerNelson.Plane.polar_inj_window
#print axioms HadwigerNelson.Plane.polar_not_mem_polarSet
#print axioms HadwigerNelson.Plane.ringPt_not_mem_openArc
#print axioms HadwigerNelson.Plane.push1_mem_Ioo
#print axioms HadwigerNelson.Plane.pushHomeo_symm_polar
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lensCurve_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.ringPt_mem_lensCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.not_kept
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_image_Γ

/-! ## FS-131 wave 5 (job FS131-IX1) — the crossing lemma's children (`inter_nonempty_of_interleaved` itself is in FS131-KP's block) -/

#print axioms HadwigerNelson.Plane.arg_one_sub_e
#print axioms HadwigerNelson.Plane.arg_one_sub_e_of_neg
#print axioms HadwigerNelson.Plane.re_pos_of_mem_closedBall
#print axioms HadwigerNelson.Plane.ringPt_sub_ringPt_mul_e_neg
#print axioms HadwigerNelson.Plane.im_sub_eq_arg_sub
#print axioms HadwigerNelson.Plane.exists_eq_of_interleaved_paths
#print axioms HadwigerNelson.Plane.continuous_discRetract
#print axioms HadwigerNelson.Plane.discRetract_mem
#print axioms HadwigerNelson.Plane.discRetract_of_mem
#print axioms HadwigerNelson.Plane.dist_discRetract_le
#print axioms HadwigerNelson.Plane.isPreconnected_thickening
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved_of_isClosed_left

/-! ## FS-131 wave 5 (job FS131-IT1) — T-GRAPH: the reachability layer, the inhabitant of `PlanarLike`, the reduction's children; F-SEP (sorry until the planar chain lands it) -/

#print axioms HadwigerNelson.Thomassen.ReachIn.refl
#print axioms HadwigerNelson.Thomassen.ReachIn.symm
#print axioms HadwigerNelson.Thomassen.ReachIn.trans
#print axioms HadwigerNelson.Thomassen.ReachIn.of_adj
#print axioms HadwigerNelson.Thomassen.ReachIn.mono
#print axioms HadwigerNelson.Thomassen.ReachIn.left_mem
#print axioms HadwigerNelson.Thomassen.ReachIn.right_mem
#print axioms HadwigerNelson.Thomassen.reachIn_of_mem_support
#print axioms HadwigerNelson.Thomassen.mem_of_reachIn_of_closed
#print axioms HadwigerNelson.Thomassen.exists_exit
#print axioms HadwigerNelson.Thomassen.reachable_induce_iff
#print axioms HadwigerNelson.Thomassen.compIn_eq_of_reachIn
#print axioms HadwigerNelson.Thomassen.supp_finite_iff
#print axioms HadwigerNelson.Thomassen.mem_twoSepInterior_iff
#print axioms HadwigerNelson.Thomassen.connected_induce_iff'
#print axioms HadwigerNelson.Thomassen.triLattice_reachIn
#print axioms HadwigerNelson.Thomassen.triLattice_offTwo_infinite
#print axioms HadwigerNelson.Thomassen.triLattice_twoSepInterior
#print axioms HadwigerNelson.Thomassen.triRing_isRing
#print axioms HadwigerNelson.Thomassen.triLattice_planarLike
#print axioms HadwigerNelson.Thomassen.NoInterleave.sublist
#print axioms HadwigerNelson.Thomassen.collapse_sublist
#print axioms HadwigerNelson.Thomassen.mem_collapse
#print axioms HadwigerNelson.Thomassen.head?_collapse
#print axioms HadwigerNelson.Thomassen.getLast?_collapse
#print axioms HadwigerNelson.Thomassen.isChain_collapse
#print axioms HadwigerNelson.Thomassen.exists_cycle_of_chain
#print axioms HadwigerNelson.Thomassen.exists_cycle_of_cyclic
#print axioms HadwigerNelson.Thomassen.offTwo_comm
#print axioms HadwigerNelson.Thomassen.twoSepInterior_comm
#print axioms HadwigerNelson.Thomassen.twoSepInterior_subset_offTwo
#print axioms HadwigerNelson.Thomassen.mem_twoSepInterior_of_reachIn
#print axioms HadwigerNelson.Thomassen.mem_twoSepInterior_or_of_adj
#print axioms HadwigerNelson.Thomassen.PlanarLike.offTwo_infinite
#print axioms HadwigerNelson.Thomassen.PlanarLike.reachIn_of_adj_adj
#print axioms HadwigerNelson.Thomassen.PlanarLike.reachIn_ne
#print axioms HadwigerNelson.Thomassen.PlanarLike.twoSepInterior_self
#print axioms HadwigerNelson.Thomassen.PlanarLike.ne_of_mem_twoSepInterior
#print axioms HadwigerNelson.Thomassen.PlanarLike.adj_of_mem_twoSepInterior
#print axioms HadwigerNelson.Thomassen.PlanarLike.exists_adj_left
#print axioms HadwigerNelson.Thomassen.PlanarLike.exists_adj_right
#print axioms HadwigerNelson.Thomassen.PlanarLike.twoSepInterior_finite
#print axioms HadwigerNelson.Thomassen.PlanarLike.twoSepInterior_subset
#print axioms HadwigerNelson.Thomassen.PlanarLike.eq_or_eq_of_mem
#print axioms HadwigerNelson.Thomassen.PlanarLike.eq_of_mem_maximal
#print axioms HadwigerNelson.Thomassen.PlanarLike.exists_maximal_above
#print axioms HadwigerNelson.Thomassen.PlanarLike.not_mem_twoSepInterior
#print axioms HadwigerNelson.Thomassen.mem_reducedVerts_of_maximal
#print axioms HadwigerNelson.Thomassen.exists_maximal_of_not_mem
#print axioms HadwigerNelson.Thomassen.exists_reducedVerts_mem_twoSepInterior
#print axioms HadwigerNelson.Thomassen.exists_eq_of_cross_up
#print axioms HadwigerNelson.Thomassen.exists_eq_of_cross_down
#print axioms HadwigerNelson.Thomassen.PlanarLike.exists_adj
#print axioms HadwigerNelson.Thomassen.PlanarLike.reduced_locallyFinite
#print axioms HadwigerNelson.Thomassen.PlanarLike.reducedVerts_infinite
#print axioms HadwigerNelson.Thomassen.PlanarLike.reduced_connected
#print axioms HadwigerNelson.Thomassen.PlanarLike.eq_of_mem_twoSepInterior_of_mem_reducedVerts
#print axioms HadwigerNelson.Thomassen.PlanarLike.exists_adj_mem_reducedVerts_ne
#print axioms HadwigerNelson.Thomassen.PlanarLike.reduced_locallyHamiltonian
#print axioms HadwigerNelson.Thomassen.ladder_adj
#print axioms HadwigerNelson.Thomassen.ladder_climb
#print axioms HadwigerNelson.Thomassen.ladder_descend
#print axioms HadwigerNelson.Thomassen.ladder_reachIn
#print axioms HadwigerNelson.Thomassen.ladder_connected
#print axioms HadwigerNelson.Thomassen.ladder_below_closed
#print axioms HadwigerNelson.Thomassen.ladder_below_finite
#print axioms HadwigerNelson.Thomassen.ladder_mem_twoSepInterior
#print axioms HadwigerNelson.Thomassen.ladder_offTwo_infinite
#print axioms HadwigerNelson.Thomassen.ladder_ring_zero
#print axioms HadwigerNelson.Thomassen.ladder_ring_succ
#print axioms HadwigerNelson.Thomassen.ladder_not_isMaximalTwoSep
#print axioms HadwigerNelson.Thomassen.ladder_reducedVerts
#print axioms HadwigerNelson.Thomassen.ladder_adversary
#print axioms HadwigerNelson.Plane.ArcMap.filledGraph_finSep

/-! ## FS-131 wave 4, `Moves` (job FS131-IM1) — the three moves under `Contact`'s statements, and their children -/

#print axioms HadwigerNelson.Plane.ArcMap.exists_shave_aux
#print axioms HadwigerNelson.Plane.ArcMap.exists_rayMerge_aux
#print axioms HadwigerNelson.Plane.ArcMap.exists_merge_aux
#print axioms HadwigerNelson.Plane.e_sub_e_two_mul
#print axioms HadwigerNelson.Plane.branchPt_eq_circle
#print axioms HadwigerNelson.Plane.abs_half_le_one
#print axioms HadwigerNelson.Plane.carrier_germArc
#print axioms HadwigerNelson.Plane.germArc_nondegenerate
#print axioms HadwigerNelson.Plane.germArc_isUnitArc_iff
#print axioms HadwigerNelson.Plane.ArcMap.isClear_of_mem_closure

-- FS131-IM2: the moves' machinery (the chart near its point, the outer pieces, the surgery, the generic move, the cut)
#print axioms HadwigerNelson.Plane.BranchGerms.Sorted.κ_ne
#print axioms HadwigerNelson.Plane.exists_germDir_ne_of_ne
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.eventually_ord
#print axioms HadwigerNelson.Plane.BranchGerms.mem_closure_sector
#print axioms HadwigerNelson.Plane.BranchGerms.next_injective
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_subset_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_mem_Γ
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branchPt_eq
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_branchPt_eq
#print axioms HadwigerNelson.Plane.BranchGerms.closure_sector_cases
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.eq_or_next_eq_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.eq_of_mem_closure_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.coloursAt_subset_image
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.ncard_coloursAt_le_two
#print axioms HadwigerNelson.Plane.Arc.continuous_pt
#print axioms HadwigerNelson.Plane.Arc.carrier_eq_image
#print axioms HadwigerNelson.Plane.Arc.carrier_sub
#print axioms HadwigerNelson.Plane.Arc.nondegenerate_sub
#print axioms HadwigerNelson.Plane.Arc.param_spec
#print axioms HadwigerNelson.Plane.Arc.finite_outer
#print axioms HadwigerNelson.Plane.norm_e_sub_e_eq
#print axioms HadwigerNelson.Plane.le_abs_sin_iff
#print axioms HadwigerNelson.Plane.abs_sin_le_of
#print axioms HadwigerNelson.Plane.Arc.outer_spec
#print axioms HadwigerNelson.Plane.ArcMap.finite_arcs_through
#print axioms HadwigerNelson.Plane.ArcMap.trimArcs_spec
#print axioms HadwigerNelson.Plane.ArcMap.trimArcs_disjoint_ball
#print axioms HadwigerNelson.Plane.ArcMap.surgery_mem_arcs_iff_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.surgery_mem_arcs_iff_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.surgery_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.surgery_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.surgery_condition5
#print axioms HadwigerNelson.Plane.ArcMap.surgery_hlc_of
#print axioms HadwigerNelson.Plane.isOpen_hornSet
#print axioms HadwigerNelson.Plane.isPreconnected_hornSet
#print axioms HadwigerNelson.Plane.hornSet_eq_empty
#print axioms HadwigerNelson.Plane.eq_branchPt_of_tanHeight_eq_zero
#print axioms HadwigerNelson.Plane.ArcMap.isClear_col
#print axioms HadwigerNelson.Plane.ArcMap.encard_sectorsOf_of_partition
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.encard_sectorsOf
#print axioms HadwigerNelson.Plane.ArcMap.finite_inter_sphere_of_subset_Γ
#print axioms HadwigerNelson.Plane.carrier_circ_full'
#print axioms HadwigerNelson.Plane.BranchGerms.e_nextβ
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branchPt_mem_sector_after
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branchPt_mem_sector_before
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.col_eq_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.col_eq_of_flankBelow
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_mem_closure_sector_after
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.branchPt_mem_closure_sector_before
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_ball_subset_of_branchPt
#print axioms HadwigerNelson.Plane.ArcMap.exists_near
#print axioms HadwigerNelson.Plane.ArcMap.Near.eventually_small
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_dom
#print axioms HadwigerNelson.Plane.ArcMap.Near.Small.lt_r₀
#print axioms HadwigerNelson.Plane.ArcMap.Near.Small.mem_Ioc
#print axioms HadwigerNelson.Plane.ArcMap.Near.Small.curv
#print axioms HadwigerNelson.Plane.ArcMap.Near.hcol₀
#print axioms HadwigerNelson.Plane.ArcMap.Near.carrier_germ
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_carrier_germ_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_Γ
#print axioms HadwigerNelson.Plane.ArcMap.Near.circ_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.Near.newArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.Near.newArcs_finite
#print axioms HadwigerNelson.Plane.ArcMap.Near.newArcs_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.Near.sphere_subset_newArcs
#print axioms HadwigerNelson.Plane.ArcMap.Near.germ_subset_Γ
#print axioms HadwigerNelson.Plane.ArcMap.Near.newArcs_unit
#print axioms HadwigerNelson.Plane.ArcMap.Near.newArcs_condition5
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_newArcs_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_dom
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_col
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_move_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_move_interiorPts_iff_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.not_mem_move_interiorPts_of_sphere
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_condition5
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_valid
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_coloursAt_self
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_coloursAt_sphere
#print axioms HadwigerNelson.Plane.ArcMap.Near.cutCol_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.cutCol_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.norm_of_mem_cutSet
#print axioms HadwigerNelson.Plane.ArcMap.Near.cutSet_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.Near.ne_of_mem_cutSet
#print axioms HadwigerNelson.Plane.ArcMap.Near.not_mem_interiorPts_of_mem_cutSet
#print axioms HadwigerNelson.Plane.ArcMap.Near.cutSet_subset_closure
#print axioms HadwigerNelson.Plane.ArcMap.Near.closure_cutSet_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_interiorPts_or_cutSet
#print axioms HadwigerNelson.Plane.ArcMap.Near.cut_hlc
#print axioms HadwigerNelson.Plane.ArcMap.Near.cut_hasSectors
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_cut

-- FS131-IM3: SHAVE's children (Moves)
#print axioms HadwigerNelson.Plane.BranchGerms.ne_next_of_nextβ_eq
#print axioms HadwigerNelson.Plane.ArcMap.Near.horn_index
#print axioms HadwigerNelson.Plane.ArcMap.Near.encard_col_eq
#print axioms HadwigerNelson.Plane.ArcMap.exists_shave_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.exists_shave_of_flankBelow
#print axioms HadwigerNelson.Plane.Arc.finite_inter_sphere_of_not_isUnitArc
#print axioms HadwigerNelson.Plane.mem_germArc_iff_of_mem_hornSet
#print axioms HadwigerNelson.Plane.mem_shaveArcs_carrier
#print axioms HadwigerNelson.Plane.shaveArcs_finite
#print axioms HadwigerNelson.Plane.shaveArcs_nondegenerate
#print axioms HadwigerNelson.Plane.shaveArcs_not_isUnitArc
#print axioms HadwigerNelson.Plane.shaveArcs_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.shaveCol_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.shaveCol_of_above
#print axioms HadwigerNelson.Plane.ArcMap.shaveCol_of_not_above
#print axioms HadwigerNelson.Plane.ArcMap.shaveCol_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.not_mem_interiorPts_self
#print axioms HadwigerNelson.Plane.ArcMap.Near.shave_mem_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.coloursAt_subset_of_mem_closure_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.shave_hasSectors
#print axioms HadwigerNelson.Plane.ArcMap.Near.shave_hlc
#print axioms HadwigerNelson.Plane.ArcMap.exists_shave_recolour

-- FS131-IM3: MERGE-RAY's children (Moves)
#print axioms HadwigerNelson.Plane.RayGap.frameX_fromFrame
#print axioms HadwigerNelson.Plane.RayGap.frameY_fromFrame
#print axioms HadwigerNelson.Plane.RayGap.sq_dist_fromFrame
#print axioms HadwigerNelson.Plane.RayGap.tanHeight_parab
#print axioms HadwigerNelson.Plane.RayGap.exists_parab_mem_hornSet
#print axioms HadwigerNelson.Plane.RayGap.exists_same_side
#print axioms HadwigerNelson.Plane.RayGap.sq_lt_one
#print axioms HadwigerNelson.Plane.RayGap.one_lt_sq
#print axioms HadwigerNelson.Plane.RayGap.lt_of_sq_add_sq_lt
#print axioms HadwigerNelson.Plane.RayGap.sq_lt_of_sq_add_sq_lt
#print axioms HadwigerNelson.Plane.RayGap.abs_le_sq_of_gap
#print axioms HadwigerNelson.Plane.RayGap.sq_le_pow_four_of_abs_le
#print axioms HadwigerNelson.Plane.RayGap.parab_below
#print axioms HadwigerNelson.Plane.RayGap.parab_above
#print axioms HadwigerNelson.Plane.RayGap.vertical_identity
#print axioms HadwigerNelson.Plane.RayGap.not_both_inside
#print axioms HadwigerNelson.Plane.RayGap.trapped_of_both_outside
#print axioms HadwigerNelson.Plane.RayGap.abs_half_mul_sq_le
#print axioms HadwigerNelson.Plane.RayGap.abeam_inside
#print axioms HadwigerNelson.Plane.RayGap.abs_abeam_height
#print axioms HadwigerNelson.Plane.RayGap.abeam_identity
#print axioms HadwigerNelson.Plane.RayGap.abeam_contra
#print axioms HadwigerNelson.Plane.ArcMap.side_of_preconnected
#print axioms HadwigerNelson.Plane.ArcMap.hornSet_subset_region
#print axioms HadwigerNelson.Plane.ArcMap.ray_clear
#print axioms HadwigerNelson.Plane.branchPt_congr_dir
#print axioms HadwigerNelson.Plane.RayGap.eq_of_mem_closure_hornSet
#print axioms HadwigerNelson.Plane.RayGap.curv_le_of_hornSet_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_subset_hornSet_of_meets
#print axioms HadwigerNelson.Plane.ArcMap.Near.horn_of_sector_subset_hornSet
#print axioms HadwigerNelson.Plane.RayGap.mem_hornSet_cases
#print axioms HadwigerNelson.Plane.ArcMap.rayCol_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.rayCol_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.abs_curv_le
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.curv_lt
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.gap_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.branchPt_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.off_keep_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.mem_keep₀
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.mem_keep₄
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.sector_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.ne
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.hasSectors
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.hlc
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.exists_merge
#print axioms HadwigerNelson.Plane.ArcMap.exists_rayMerge_of_clear

/-! ## FS-131 wave 4, `MergeMove` (job FS131-IMM1) — MERGE's children -/
-- FS131-IMM1
#print axioms HadwigerNelson.Plane.ArcMap.dist_ne_one_of_isOpen_isClear
#print axioms HadwigerNelson.Plane.ArcMap.add_mem_allowedCone
#print axioms HadwigerNelson.Plane.ArcMap.smul_mem_allowedCone
#print axioms HadwigerNelson.Plane.ArcMap.clear_of_push
#print axioms HadwigerNelson.Plane.dot_e_eq_cos_sin
#print axioms HadwigerNelson.Plane.norm_sub_smul_e_sq
#print axioms HadwigerNelson.Plane.push_alg
#print axioms HadwigerNelson.Plane.ArcMap.push_contacts_of_mem_allowedCone
#print axioms HadwigerNelson.Plane.tanHeight_hgt
#print axioms HadwigerNelson.Plane.abs_hgt_le
#print axioms HadwigerNelson.Plane.sign_sub_hgt
#print axioms HadwigerNelson.Plane.e_add_sigma_pi_div_two
#print axioms HadwigerNelson.Plane.sigma_tanHeight_nonneg
#print axioms HadwigerNelson.Plane.push_decomp
#print axioms HadwigerNelson.Plane.ArcMap.clear_near_end
-- FS131-IMM2
#print axioms HadwigerNelson.Plane.BranchGerms.idx_zero
#print axioms HadwigerNelson.Plane.BranchGerms.turns_zero
#print axioms HadwigerNelson.Plane.BranchGerms.lift_zero
#print axioms HadwigerNelson.Plane.BranchGerms.next_idx
#print axioms HadwigerNelson.Plane.BranchGerms.turns_succ
#print axioms HadwigerNelson.Plane.BranchGerms.lift_succ
#print axioms HadwigerNelson.Plane.BranchGerms.lift_succ'
#print axioms HadwigerNelson.Plane.BranchGerms.κ_idx_succ
#print axioms HadwigerNelson.Plane.BranchGerms.e_lift
#print axioms HadwigerNelson.Plane.BranchGerms.liftDir_eq
#print axioms HadwigerNelson.Plane.BranchGerms.liftDir_succ
#print axioms HadwigerNelson.Plane.BranchGerms.branchPt_idx
#print axioms HadwigerNelson.Plane.BranchGerms.mem_sector_idx
#print axioms HadwigerNelson.Plane.BranchGerms.liftDir_lt_succ
#print axioms HadwigerNelson.Plane.BranchGerms.liftDir_mono
#print axioms HadwigerNelson.Plane.BranchGerms.lift_mono
#print axioms HadwigerNelson.Plane.BranchGerms.idx_add_n
#print axioms HadwigerNelson.Plane.BranchGerms.turns_add_n
#print axioms HadwigerNelson.Plane.BranchGerms.lift_add_n
#print axioms HadwigerNelson.Plane.BranchGerms.exists_idx_eq
#print axioms HadwigerNelson.Plane.BranchGerms.idx_ne
#print axioms HadwigerNelson.Plane.cross_e_e
#print axioms HadwigerNelson.Plane.cone_smul_mem_interior
#print axioms HadwigerNelson.Plane.cone_add_mem_interior
#print axioms HadwigerNelson.Plane.cone_eq_univ_of_zero_mem_interior
#print axioms HadwigerNelson.Plane.cone_mem_interior_of_arc
#print axioms HadwigerNelson.Plane.cone_half_plane
#print axioms HadwigerNelson.Plane.cone_mem_interior_of_between
#print axioms HadwigerNelson.Plane.cone_side
#print axioms HadwigerNelson.Plane.gap_assemble
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_tile_of_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.pos_of_hasSectors
#print axioms HadwigerNelson.Plane.ArcMap.Near.e_mem_allowedCone_of_col
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_lift
#print axioms HadwigerNelson.Plane.ArcMap.Near.base_before
#print axioms HadwigerNelson.Plane.ArcMap.Near.base_after
#print axioms HadwigerNelson.Plane.ArcMap.Near.gap_clear
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_gap
-- FS131-IMM3
#print axioms HadwigerNelson.Plane.BranchGerms.mem_gapGerm
#print axioms HadwigerNelson.Plane.BranchGerms.mem_gapSec
#print axioms HadwigerNelson.Plane.BranchGerms.exists_rep
#print axioms HadwigerNelson.Plane.BranchGerms.idx_inj
#print axioms HadwigerNelson.Plane.BranchGerms.idx_mem_gapGerm_iff
#print axioms HadwigerNelson.Plane.BranchGerms.idx_mem_gapSec_iff
#print axioms HadwigerNelson.Plane.BranchGerms.phantom_idx_succ_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.Small.half
#print axioms HadwigerNelson.Plane.ArcMap.Near.Small.mono
#print axioms HadwigerNelson.Plane.ArcMap.Near.dist_branchPt
#print axioms HadwigerNelson.Plane.ArcMap.Near.outer_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_outer
#print axioms HadwigerNelson.Plane.ArcMap.Near.norm_of_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_sector_of_lt
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_mono
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_subset_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.Near.not_mem_branch_of_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.Near.eq_of_mem_branch
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_not_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_gapSet_of_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_mem_gapSet_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeCol_of_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeCol_branchPt
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeCol_of_not_mem
#print axioms HadwigerNelson.Plane.BranchGerms.liftDir_add_n
#print axioms HadwigerNelson.Plane.ArcMap.Near.carrier_rimArc
#print axioms HadwigerNelson.Plane.ArcMap.Near.rimArc_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_mergeArcs
#print axioms HadwigerNelson.Plane.ArcMap.Near.germ_half_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.outer_subset_germ
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeArcs_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.germ_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeArcs_finite
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeArcs_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeArcs_unit
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeArcs_condition5
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_next_eq
#print axioms HadwigerNelson.Plane.ArcMap.Near.ball_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.v_mem_mergeArcs
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_mem_mergeArcs_inner
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_mem_mergeArcs_outer
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_mergeArcs_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.liftDir_gap_germ
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_dir_of_mem_gapSec
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_rim_mem_trimArcs
#print axioms HadwigerNelson.Plane.ArcMap.Near.gap_sides
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_hlc
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeCol_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_mergeArcs_inner
#print axioms HadwigerNelson.Plane.ArcMap.Near.gap_sides_idx
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_chain
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_subset_chain
#print axioms HadwigerNelson.Plane.ArcMap.Near.isPreconnected_chain
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_merge_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_interiorPts_of_merge_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_condition5
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_coloursAt_self
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_valid
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_hasSectors
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_coloursAt_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_ncard_coloursAt_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_not_hasRepeatedColour_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_allowedCone
-- FS131-IMM4
#print axioms HadwigerNelson.Plane.tanHeight_combo
#print axioms HadwigerNelson.Plane.side_ineq
#print axioms HadwigerNelson.Plane.isPreconnected_side_plane
#print axioms HadwigerNelson.Plane.frame_mul_e
#print axioms HadwigerNelson.Plane.isPreconnected_side
#print axioms HadwigerNelson.Plane.isPreconnected_of_two_sides
#print axioms HadwigerNelson.Plane.ArcMap.Near.sides_preconnected
#print axioms HadwigerNelson.Plane.ArcMap.encard_sectorsOf_le_one
#print axioms HadwigerNelson.Plane.ArcMap.Near.norm_of_mem_rimArc
#print axioms HadwigerNelson.Plane.ArcMap.Near.mergeCol_of_mem_sector_out
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_merge_interiorPts_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_mem_merge_interiorPts_iff
#print axioms HadwigerNelson.Plane.exists_step_of_strictMono
#print axioms HadwigerNelson.Plane.ArcMap.finite_tiles_ball_of_goodAt
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.mem_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.Near.gapSec_of_mem_rimArc
#print axioms HadwigerNelson.Plane.ArcMap.Near.chain_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.Near.isOpen_chain
#print axioms HadwigerNelson.Plane.ArcMap.Near.isClear_chain
#print axioms HadwigerNelson.Plane.ArcMap.Near.closure_gapSet_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_region_of_region
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_region_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.closure_merge_region
#print axioms HadwigerNelson.Plane.ArcMap.Near.chain_subset_merge_region
#print axioms HadwigerNelson.Plane.ArcMap.Near.v_mem_closure_merge_tile
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_exists_tile
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_tile_split
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_tile_cover
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_isContact_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_inType_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.merge_outType_iff

/-! ## FS-131 wave 5 (job FS131-I5h) — the `Terminal` implementer: FS131-E5's lemmas SH and SEP (`Plane/ValidMap/HornShadow`) -/

#print axioms HadwigerNelson.Plane.frameY_add_pi
#print axioms HadwigerNelson.Plane.tanAbove_add_pi_iff
#print axioms HadwigerNelson.Plane.tanBelow_add_pi_iff
#print axioms HadwigerNelson.Plane.neg_curvDown_neg
#print axioms HadwigerNelson.Plane.e_add_pi_add_pi
#print axioms HadwigerNelson.Plane.dist_eq_dist_of_frame
#print axioms HadwigerNelson.Plane.tanAbove_S_of_dist_le_one
#print axioms HadwigerNelson.Plane.tanBelow_N_of_dist_le_one
#print axioms HadwigerNelson.Plane.shadow_hornSet_subset_S
#print axioms HadwigerNelson.Plane.shadow_hornSet_add_pi_subset_S
#print axioms HadwigerNelson.Plane.shadow_hornSet_subset_N
#print axioms HadwigerNelson.Plane.shadow_hornSet_add_pi_subset_N
#print axioms HadwigerNelson.Plane.exists_drop_height
#print axioms HadwigerNelson.Plane.exists_near_hornSet_of_partner
#print axioms HadwigerNelson.Plane.mem_shadow_hornSet_S
#print axioms HadwigerNelson.Plane.mem_shadow_hornSet_add_pi_S
#print axioms HadwigerNelson.Plane.mem_shadow_hornSet_N
#print axioms HadwigerNelson.Plane.mem_shadow_hornSet_add_pi_N
#print axioms HadwigerNelson.Plane.lt_of_tanAbove_tanBelow
#print axioms HadwigerNelson.Plane.TanAbove.mono
#print axioms HadwigerNelson.Plane.TanBelow.mono
#print axioms HadwigerNelson.Plane.sep_S
#print axioms HadwigerNelson.Plane.sep_add_pi_S
#print axioms HadwigerNelson.Plane.sep_N
#print axioms HadwigerNelson.Plane.sep_add_pi_N
-- FS131-I5i (extending this block): the witnesses at the antipode, the cones at `S′`, NB3-END item 2 (`HornShadow`, `Terminal`)
#print axioms HadwigerNelson.Plane.witness_dir_aux1
#print axioms HadwigerNelson.Plane.witness_dir_aux2
#print axioms HadwigerNelson.Plane.witness_dir_aux3
#print axioms HadwigerNelson.Plane.witness_dir_real
#print axioms HadwigerNelson.Plane.dirDist_sq_frame
#print axioms HadwigerNelson.Plane.witness_dir_pt
#print axioms HadwigerNelson.Plane.angle_pinch_false
#print axioms HadwigerNelson.Plane.coneAt_subset_of_far
#print axioms HadwigerNelson.Plane.exists_witness_dir
#print axioms HadwigerNelson.Plane.int_eq_one_of_real
#print axioms HadwigerNelson.Plane.int_eq_zero_of_real
#print axioms HadwigerNelson.Plane.abs_half_lt_one
#print axioms HadwigerNelson.Plane.angleIcc_eq_lower_half
#print axioms HadwigerNelson.Plane.angle_pinch
#print axioms HadwigerNelson.Plane.ArcMap.witness_near_S_upper
#print axioms HadwigerNelson.Plane.ArcMap.witness_near_S_lower
#print axioms HadwigerNelson.Plane.ArcMap.far_of_outType_chart
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_S_subset_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_N_subset_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.nextκ_le_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.tanBelow_of_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.exists_tanAbove_of_sector
#print axioms HadwigerNelson.Plane.ArcMap.exists_horn_add_pi_of_stuck
#print axioms HadwigerNelson.Plane.ArcMap.flank_two_sectors_at_S
#print axioms HadwigerNelson.Plane.ArcMap.n3_end_four_colours
#print axioms HadwigerNelson.Plane.ArcMap.n3_end_bothKind
-- FS131-I5k (extending this block): NB3-END items 3–5 (`Terminal`)
#print axioms HadwigerNelson.Plane.ringPt_S_sub_eq_fromFrame
#print axioms HadwigerNelson.Plane.isPreconnected_hornSet_of_abs_le
#print axioms HadwigerNelson.Plane.not_mem_angleIcc_S_self
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_sectorsOf_of_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_horn_of_mem_coneAt_of_stuck
#print axioms HadwigerNelson.Plane.ArcMap.not_outType_v_of_flankBelow_neg_one
#print axioms HadwigerNelson.Plane.ArcMap.isStuck_of_hasRepeatedColour
#print axioms HadwigerNelson.Plane.ArcMap.flank_coneAt_S
#print axioms HadwigerNelson.Plane.angle_pinch_ends
#print axioms HadwigerNelson.Plane.not_mem_angleIcc_S_add
#print axioms HadwigerNelson.Plane.ArcMap.κ_le_of_disjoint_end
#print axioms HadwigerNelson.Plane.ArcMap.tanBelow_of_mem_sector_end
#print axioms HadwigerNelson.Plane.ArcMap.exists_tanAbove_of_sector_end
#print axioms HadwigerNelson.Plane.ArcMap.IsFlankBelow.unique
#print axioms HadwigerNelson.Plane.ArcMap.flank_two_sectors_at_S_gen
-- FS131-I5l (extending this block): CV-HD's arrows, the turned frame, C-ENDS's run propagation, CV-EXISTS's chain step (`Terminal`)
#print axioms HadwigerNelson.Plane.ArcMap.upper_bounds_of_inType_N
#print axioms HadwigerNelson.Plane.ArcMap.stuck_turned_frame
#print axioms HadwigerNelson.Plane.ArcMap.cv_hd_main_inType
#print axioms HadwigerNelson.Plane.ArcMap.IsQArc.add_int_mul
#print axioms HadwigerNelson.Plane.ArcMap.StuckAlong.congr
#print axioms HadwigerNelson.Plane.ArcMap.stuck_structure_at_axis
#print axioms HadwigerNelson.Plane.ArcMap.stuckAlong_of_run
#print axioms HadwigerNelson.Plane.ArcMap.stuckAlong_of_mem_stuckRun
#print axioms HadwigerNelson.Plane.ArcMap.four_or_stuck_of_chainVertex
#print axioms HadwigerNelson.Plane.ArcMap.chainVertex_neighbours_of_noFour
#print axioms HadwigerNelson.Plane.ArcMap.stuckRun_eq_univ_of_noFour
#print axioms HadwigerNelson.Plane.ArcMap.dot_eq_zero_of_antipodal_contact
#print axioms HadwigerNelson.Plane.ArcMap.mergeAvailable_of_not_mem_pole
#print axioms HadwigerNelson.Plane.ArcMap.lower_flank_horns_at_N
-- FS131-I5n (extending this block): CV-HD's branch `G_N` — U1 for a flank (`HornShadow`), angles and germ order, chart sector counts (`Terminal`)
#print axioms HadwigerNelson.Plane.ArcMap.flank_radial_N
#print axioms HadwigerNelson.Plane.ArcMap.flank_radial_S
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_N_subset_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_S_subset_of_flankBelow
#print axioms HadwigerNelson.Plane.mem_coneAt_of_e_eq
#print axioms HadwigerNelson.Plane.not_mem_angleIcc_of_gap
#print axioms HadwigerNelson.Plane.mem_angleIoo_of_e_ne
#print axioms HadwigerNelson.Plane.mem_angleIoo_half
#print axioms HadwigerNelson.Plane.BranchGerms.exists_succ
#print axioms HadwigerNelson.Plane.BranchGerms.exists_pred
#print axioms HadwigerNelson.Plane.BranchGerms.Mono.false_of_full
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.card_le_encard_sectorsOf
#print axioms HadwigerNelson.Plane.ArcMap.mergeAvailable_of_two_sectors
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_index_of_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.lower_flank_horns_at_N_of
#print axioms HadwigerNelson.Plane.ArcMap.seven_colours_at_N
#print axioms HadwigerNelson.Plane.ArcMap.y3_end_needs_of_not_mem
#print axioms HadwigerNelson.Plane.cos_pos_of_mem_angleIoo
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.isFlankAbove_of_col
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.isFlankBelow_of_col
#print axioms HadwigerNelson.Plane.ArcMap.flank_two_sectors_at_S_of_flanks
#print axioms HadwigerNelson.Plane.ArcMap.not_inType_S_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.not_inType_N_of_flankBelow
#print axioms HadwigerNelson.Plane.ArcMap.horns_of_two_sectors_at

-- FS131-KL1 (the limit planner): `Plane/ValidMap/Limit`, `Plane/ValidMap/Procedure`, and N2-TERM's clause children in `Terminal`
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.refl
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.mono
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.const
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.dom_eq
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.exists_stab
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.not_mem_U_of_stab_le
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.frozen
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limitArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limitArcs_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limitCol_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limit
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.eventually_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limit_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limit_valid
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limit_isModification
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_eq_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.onRingArc_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.mergeAvailable_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.rayAvailable_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.shaveAvailable_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.qrAt_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limit_isTerminalMap
#print axioms HadwigerNelson.Plane.ArcMap.not_available_of_not_isSite
#print axioms HadwigerNelson.Plane.ArcMap.IsClean.eventually_not_isSite
#print axioms HadwigerNelson.Plane.ArcMap.exists_clean
#print axioms HadwigerNelson.Plane.ArcMap.badCount_eq_zero_iff
#print axioms HadwigerNelson.Plane.ArcMap.badCount_lt_top
#print axioms HadwigerNelson.Plane.ArcMap.treatPts_inter_finite
#print axioms HadwigerNelson.Plane.ArcMap.mergeAvailable_of_bothKind
#print axioms HadwigerNelson.Plane.ArcMap.exists_vertexStep
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcStep
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminalSeq
#print axioms HadwigerNelson.Plane.ArcMap.exists_terminalMap
#print axioms HadwigerNelson.Plane.ArcMap.terminal_vertices
#print axioms HadwigerNelson.Plane.ArcMap.run_ends
#print axioms HadwigerNelson.Plane.BranchGerms.horn_cases_four
#print axioms HadwigerNelson.Plane.ArcMap.horn_flanks_of_isChainVertex
#print axioms HadwigerNelson.Plane.ArcMap.hornBoundsQR_of_isChainVertex
#print axioms HadwigerNelson.Plane.ArcMap.run_hornBoundsQR
#print axioms HadwigerNelson.Plane.ArcMap.stuckRun_ne_univ

-- FS131-IL1 (lane A of the limit): `Plane/ValidMap/Limit`'s supporting lemmas (locality, the limit's agreement, sites)
#print axioms HadwigerNelson.Plane.ArcMap.finite_arcs_inter_compact
#print axioms HadwigerNelson.Plane.ArcMap.mem_Γ_iff
#print axioms HadwigerNelson.Plane.ArcMap.AgreesOff.symm
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_iff_of_inter_eq
#print axioms HadwigerNelson.Plane.ArcMap.region_inter_eq_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_inter_eq_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_region_inter_iff
#print axioms HadwigerNelson.Plane.ArcMap.isSector_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.sectorsOf_eq_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.eventually_ball_subset
#print axioms HadwigerNelson.Plane.ArcMap.hasSectors_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.hasRepeatedColour_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.hornSet_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.isHorn_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.subset_region_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isFlankAbove_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isFlankBelow_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isClear_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isTile_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.tileOf_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.inType_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.allowedCone_eq_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isRingArc_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isQArc_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.isR2Arc_iff_of_agreesOn
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.arc_origin
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.agree_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.col_eq_limitCol
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.exists_disjoint_of_isCompact
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limitArcs_inter_eq
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.eventually_mem_limitInterior_iff
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.agreesOn_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.exists_agreesOn_ball
#print axioms HadwigerNelson.Plane.ArcMap.interior_coneAt_hornSet_eq_empty
#print axioms HadwigerNelson.Plane.ArcMap.germ_eq_curveGerm_of_goodAt
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_of_goodAt
#print axioms HadwigerNelson.Plane.Arc.curve_eq_of_mem

-- FS131-IL2 (lane A of the limit, continued): the clean map (`Plane/ValidMap/Limit`), the finiteness lemmas and the both-kind lemma
-- (`Plane/ValidMap/Procedure`)
#print axioms HadwigerNelson.Plane.Arc.isCompact_params
#print axioms HadwigerNelson.Plane.Arc.ordConnected_params
#print axioms HadwigerNelson.Plane.Arc.finite_pt_eq
#print axioms HadwigerNelson.Plane.isClosed_ordConnectedComponent
#print axioms HadwigerNelson.Plane.ordConnectedComponent_eq_Icc
#print axioms HadwigerNelson.Plane.eventually_finite_components
#print axioms HadwigerNelson.Plane.isPreconnected_ball_diff_singleton
#print axioms HadwigerNelson.Plane.halfDiscMono_essSet
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.eventually_coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_eq_singleton_of_interior
#print axioms HadwigerNelson.Plane.ArcMap.essSet_subset_Γ
#print axioms HadwigerNelson.Plane.ArcMap.exists_coloursAt_eq_singleton
#print axioms HadwigerNelson.Plane.ArcMap.eventually_coloursAt_eq_singleton
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_dom_diff_essSet
#print axioms HadwigerNelson.Plane.ArcMap.notMem_essSet_of_isolated
#print axioms HadwigerNelson.Plane.ArcMap.germs_le_two_of_goodAt
#print axioms HadwigerNelson.Plane.ArcMap.eventually_essSet_iff_of_goodAt
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_essParams
#print axioms HadwigerNelson.Plane.ArcMap.essComp_eq_Icc
#print axioms HadwigerNelson.Plane.ArcMap.cleanArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.essParams_eventually_iff
#print axioms HadwigerNelson.Plane.ArcMap.eventually_clean_near
#print axioms HadwigerNelson.Plane.ArcMap.cleanArcs_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.essSet_subset_cleanArcs
#print axioms HadwigerNelson.Plane.ArcMap.dom_inter_cleanArcs
#print axioms HadwigerNelson.Plane.ArcMap.cleanCol_eq
#print axioms HadwigerNelson.Plane.ArcMap.clean_Γ
#print axioms HadwigerNelson.Plane.ArcMap.clean_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.region_subset_clean_region
#print axioms HadwigerNelson.Plane.ArcMap.clean_region_subset_closure
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_clean
#print axioms HadwigerNelson.Plane.ArcMap.clean_valid
#print axioms HadwigerNelson.Plane.ArcMap.clean_isClean
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_add_int
#print axioms HadwigerNelson.Plane.ArcMap.radiusTwoArc_add_int
#print axioms HadwigerNelson.Plane.ArcMap.isRingArc_add_int
#print axioms HadwigerNelson.Plane.ArcMap.isQArc_add_int
#print axioms HadwigerNelson.Plane.ArcMap.isR2Arc_add_int
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.mono
#print axioms HadwigerNelson.Plane.ArcMap.mem_Ioo_or_of_overlap
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.union
#print axioms HadwigerNelson.Plane.ArcMap.IsQArc.of_subarc
#print axioms HadwigerNelson.Plane.ArcMap.IsR2Arc.of_subarc
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_Γ_of_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.exists_isMaxRingArc
#print axioms HadwigerNelson.Plane.ArcMap.IsMaxRingArc.not_regularAt
#print axioms HadwigerNelson.Plane.ArcMap.finite_sites_inter_compact
#print axioms HadwigerNelson.Plane.ArcMap.infinite_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.finite_centres_inter_compact

/-! ## FS-131, `OpenMove` (jobs FS131-IO1, IO2, IO3) — OPEN, the fifth move -/
-- FS131-IO1
#print axioms HadwigerNelson.Plane.ArcMap.HasHornCount.eq
#print axioms HadwigerNelson.Plane.ne_hornSet_of_interior_coneAt
#print axioms HadwigerNelson.Plane.exists_small_arcsin
#print axioms HadwigerNelson.Plane.ArcMap.Near.col_mem_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_openConfig_up
#print axioms HadwigerNelson.Plane.BranchGerms.idx_idx
#print axioms HadwigerNelson.Plane.BranchGerms.turns_idx
#print axioms HadwigerNelson.Plane.BranchGerms.liftDir_idx
#print axioms HadwigerNelson.Plane.BranchGerms.lift_idx
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_openConfig_down
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_openConfig
#print axioms HadwigerNelson.Plane.BranchGerms.openWedge_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.Near.openRay_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.Near.openRay_nondegenerate
#print axioms HadwigerNelson.Plane.BranchGerms.openRim_subset_sphere
#print axioms HadwigerNelson.Plane.ArcMap.Near.openRim_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.Near.openArcs_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.Near.openArcs_finite
#print axioms HadwigerNelson.Plane.ArcMap.Near.openArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_hlc
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_condition5
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_valid
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_coloursAt_self
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_degree_horns
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_allowedCone
#print axioms HadwigerNelson.Plane.ArcMap.exists_open
-- FS131-IO2
#print axioms HadwigerNelson.Plane.BranchGerms.mem_openWedge
#print axioms HadwigerNelson.Plane.BranchGerms.mem_openPiece
#print axioms HadwigerNelson.Plane.BranchGerms.mem_openRest
#print axioms HadwigerNelson.Plane.isOpen_sectorBetween
#print axioms HadwigerNelson.Plane.polar_eq_of_abs_lt
#print axioms HadwigerNelson.Plane.BranchGerms.isOpen_openWedge
#print axioms HadwigerNelson.Plane.BranchGerms.isOpen_openPiece
#print axioms HadwigerNelson.Plane.BranchGerms.isOpen_openRest
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_openRay
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_openRim
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.two_le
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.liftDir_succ_lt
#print axioms HadwigerNelson.Plane.ArcMap.Near.openWedge_subset_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_openPiece_of_Icc
#print axioms HadwigerNelson.Plane.ArcMap.Near.openWedge_subset_openPiece
#print axioms HadwigerNelson.Plane.ArcMap.Near.disjoint_openWedge_openRest
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_rayPos_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.openCol_of_mem_openPiece
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.isClear_of_Icc
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.isClear_of_mem_openWedge
#print axioms HadwigerNelson.Plane.ArcMap.Near.openCol_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.openCol_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.v_mem_openArcs
#print axioms HadwigerNelson.Plane.mem_sectorBetween_of_lt
#print axioms HadwigerNelson.Plane.isPreconnected_sectorBetween
#print axioms HadwigerNelson.Plane.Ioo_subset_coneAt_sectorBetween
#print axioms HadwigerNelson.Plane.ArcMap.Near.eq_of_mem_openRay
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.window
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.mem_openPiece_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.mem_openRest_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.exists_other
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.exists_germ_off
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.not_mem_openArcs
#print axioms HadwigerNelson.Plane.ArcMap.Near.sector_eq_hornSet_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.hasHornCount_chart
#print axioms HadwigerNelson.Plane.ArcMap.isSector_iff_of_partition'
#print axioms HadwigerNelson.Plane.ArcMap.injOn_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.Near.openSectors_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.idx_facts
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.cone_piece_rest
#print axioms HadwigerNelson.Plane.ArcMap.Near.facts_of_cone
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.isPreconnected_piece_rest
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.disjoint_piece_rest
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.disjoint_piece_other
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.horn_subset_piece
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.mem_piece_of_Icc
#print axioms HadwigerNelson.Plane.BranchGerms.mem_openPiece_of_lt
#print axioms HadwigerNelson.Plane.BranchGerms.mem_openRest_of_lt
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.rest_subset_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.disjoint_openSectors
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.openSectors_facts
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_open_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_interiorPts_of_open_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_open_interiorPts_of_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_partition
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_open_interiorPts_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.Near.branchPt_mem_open_interiorPts_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.openCol_of_mem_sector_out
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_coloursAt_rim
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_not_hasRepeatedColour_rim
-- FS131-IO3
#print axioms HadwigerNelson.Plane.closure_sectorBetween_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.closure_gapSet_subset_gapSet
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.exists_clearSet
#print axioms HadwigerNelson.Plane.ArcMap.Near.OpenConfig.v_mem_closure_region
#print axioms HadwigerNelson.Plane.ArcMap.Near.mem_open_interiorPts_of_sector_off
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_region_of_region
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_region_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_region_subset
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_isContact_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_exists_tile
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_tile_split
#print axioms HadwigerNelson.Plane.ArcMap.Near.v_mem_closure_open_tile
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_tile_cover
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_inType_iff
#print axioms HadwigerNelson.Plane.ArcMap.Near.open_outType_iff

/-! ## FS131-IR1 — the procedure's run (`Plane/ValidMap/Procedure`): `exists_terminalSeq` over the two steps; E6-CONE (`FlankUA`) -/

#print axioms HadwigerNelson.Plane.ArcMap.horn_bounds_of_interior_empty
#print axioms HadwigerNelson.Plane.ArcMap.eventually_ball_subset_compl
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_iff_of_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.isSite_iff_of_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.badCount_eq_of_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.exists_hasHornCount
#print axioms HadwigerNelson.Plane.ArcMap.pot_eq
#print axioms HadwigerNelson.Plane.ArcMap.finite_strict_of_antitone_off
#print axioms HadwigerNelson.Plane.ArcMap.ProcInv.mem_treatPts_of_todo
#print axioms HadwigerNelson.Plane.ArcMap.ProcStep.refl
#print axioms HadwigerNelson.Plane.ArcMap.isCompact_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.dist_of_mem_cthickening_ringArc
#print axioms HadwigerNelson.Plane.ArcMap.exists_procStep
#print axioms HadwigerNelson.Plane.ArcMap.ProcRun.finite_vert
#print axioms HadwigerNelson.Plane.ArcMap.ProcRun.finite_colChange
#print axioms HadwigerNelson.Plane.ArcMap.ProcRun.finite_arc
#print axioms HadwigerNelson.Plane.ArcMap.ProcRun.finite_acted
#print axioms HadwigerNelson.Plane.ArcMap.ProcRun.locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.ProcRun.eventually_not_todo
#print axioms HadwigerNelson.Plane.const_treatPts

-- FS131-IR1, stage 16: cleaning a step (`cleanKeep`, `LocalStep.cleanKeep`)
#print axioms HadwigerNelson.Plane.Arc.exists_params_eq_Icc
#print axioms HadwigerNelson.Plane.ordConnectedComponent_Icc
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_Γ
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_col
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_col_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_region
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_cleanKeep
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_valid
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_isClean
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_isModification
#print axioms HadwigerNelson.Plane.ArcMap.essParams_eq_params_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.cleanKeep
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.exists_clean

-- FS131-IR1, stage 17: a surgery is a local step; the invariant's inhabitant
#print axioms HadwigerNelson.Plane.ArcMap.surgery_localStep
#print axioms HadwigerNelson.Plane.ArcMap.surgery_cleanKeep_localStep
#print axioms HadwigerNelson.Plane.ArcMap.ProcInv.refl

/-! ## FS131-IR2 — the vertex step's children (`Plane/ValidMap/Procedure`): the potential under a step, the points of a step's disc -/

-- FS131-IR2, stage 19: comparing the sectors of two maps at a point (the potential under a step)
#print axioms HadwigerNelson.Plane.BranchGerms.next_ne_self
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.eq_of_inter_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.encard_le_of_forall_exists_subset
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.hornSet_of_subset
#print axioms HadwigerNelson.Plane.ArcMap.encard_sectors_le_aux
#print axioms HadwigerNelson.Plane.ArcMap.pot_le_of_sectors
#print axioms HadwigerNelson.Plane.ArcMap.pot_lt_of_sectors
#print axioms HadwigerNelson.Plane.ArcMap.exists_isSector_subset
#print axioms HadwigerNelson.Plane.ArcMap.exists_isSector_ne_subset
#print axioms HadwigerNelson.Plane.ArcMap.pot_lt_of_interior
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_subset_cleanKeep
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_pot_le
#print axioms HadwigerNelson.Plane.ArcMap.hasRepeatedColour_of_cleanKeep
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_cleanKeep

-- FS131-IR2, stage 20: the points of a step's disc (germs on branches with distinct directions; clean maps); the cases' helpers
#print axioms HadwigerNelson.Plane.ArcMap.Near.col_ne_next_of_isClean
#print axioms HadwigerNelson.Plane.ArcMap.Near.two_le_of_isClean
#print axioms HadwigerNelson.Plane.ArcMap.not_hasRepeatedColour_of_degree_le_three
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_zero_of_germs
#print axioms HadwigerNelson.Plane.ArcMap.one_le_of_isHorn
#print axioms HadwigerNelson.Plane.ArcMap.two_le_of_isHorn_of_isHorn

-- FS131-IR2, stage 21: a point on one curve
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_of_hasHornCount_zero
#print axioms HadwigerNelson.Plane.e_curveGerm_ne
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_of_curve
#print axioms HadwigerNelson.Plane.curveAt_rebase
#print axioms HadwigerNelson.Plane.exists_curveAt_of_branch

-- FS131-IS1: `stuckRun_ne_univ`'s children — N4-SHADOW's two inequalities (`Plane/ValidMap/HornShadow`), the chain's colours and bounds
-- and the recursion (`Plane/ValidMap/Terminal`); `stuckRun_ne_univ` itself is recorded with KL1's block above
#print axioms HadwigerNelson.Plane.ArcMap.le_curvDown_of_flankBelow_of_horn
#print axioms HadwigerNelson.Plane.ArcMap.curvUp_le_of_horn_of_flankAbove
#print axioms HadwigerNelson.Plane.ArcMap.horn_colour_eq_of_isChainVertex
#print axioms HadwigerNelson.Plane.ArcMap.eq_horn_colour_of_two_sectors
#print axioms HadwigerNelson.Plane.ArcMap.horn_upper_ne_one
#print axioms HadwigerNelson.Plane.ArcMap.horn_lower_ne_neg_one
#print axioms HadwigerNelson.Plane.ArcMap.shadow_recursion

/-! ## FS131-IR3 — the vertex step's four cases (`Plane/ValidMap/Procedure`): the two-curve kit, then one block per case -/

-- FS131-IR3, stage 24: a point on two curves; the points of a move's disc in one statement; MERGE-RAY's case
#print axioms HadwigerNelson.Plane.e_arg_sub_ne
#print axioms HadwigerNelson.Plane.im_ne_zero_of_far
#print axioms HadwigerNelson.Plane.mem_curveAt_of_dist_eq
#print axioms HadwigerNelson.Plane.ArcMap.cleanKeep_Γ_subset
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_cleanKeep_Γ_of_const
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_of_two_curves
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_of_rim_junction
#print axioms HadwigerNelson.Plane.ArcMap.not_isSite_of_branches
#print axioms HadwigerNelson.Plane.exists_branchPt_near_lt
#print axioms HadwigerNelson.Plane.exists_branchPt_near_gt
#print axioms HadwigerNelson.Plane.ArcMap.Near.not_isSite_of_chart
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_rim_mem_sector
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_rim_mem_sector_before
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_not_mem_cleanKeep_Γ
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_Γ_cases
#print axioms HadwigerNelson.Plane.ArcMap.Near.RayConfig.exists_step
#print axioms HadwigerNelson.Plane.ArcMap.exists_rayStep

-- FS131-IR3, stage 25: the assembly the four cases share; SHAVE's case
#print axioms HadwigerNelson.Plane.subset_connectedComponentIn_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.mem_cleanKeep_interiorPts_of_const
#print axioms HadwigerNelson.Plane.ArcMap.surgery_step
#print axioms HadwigerNelson.Plane.ArcMap.Near.move_step
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_shaveStep_aux
#print axioms HadwigerNelson.Plane.ArcMap.exists_shaveStep

-- FS131-IR3, stage 26: MERGE's case
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_mergeStep_aux
#print axioms HadwigerNelson.Plane.ArcMap.exists_mergeStep

-- FS131-IR3, stage 27: OPEN's case; with it the vertex step (`exists_vertexStep`, recorded in an earlier block above) rests on no open case
#print axioms HadwigerNelson.Plane.ArcMap.Near.exists_openStep_aux
#print axioms HadwigerNelson.Plane.ArcMap.exists_openStep

-- FS131-CC1: lane C of the collar bend — `Pushforward`'s supporting lemmas (the two-germ chart on a circle), and lane C's new children
#print axioms HadwigerNelson.Plane.ArcMap.HasDegree.unique
#print axioms HadwigerNelson.Plane.ArcMap.HasDegree.iff_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.not_hasRepeatedColour_of_zero
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.hasRepeatedColour_iff
#print axioms HadwigerNelson.Plane.ArcMap.curveAt_one_sub_eq_sphere
#print axioms HadwigerNelson.Plane.ArcMap.branchPt_congr
#print axioms HadwigerNelson.Plane.ArcMap.circleGerms_nextβ_zero
#print axioms HadwigerNelson.Plane.ArcMap.circleGerms_nextβ_one
#print axioms HadwigerNelson.Plane.ArcMap.circleGerms_nextκ_zero
#print axioms HadwigerNelson.Plane.ArcMap.circleGerms_nextκ_one
#print axioms HadwigerNelson.Plane.ArcMap.circleGerms_mem_sector_zero
#print axioms HadwigerNelson.Plane.ArcMap.circleGerms_mem_sector_one
#print axioms HadwigerNelson.Plane.ArcMap.isSectorChart_circle
#print axioms HadwigerNelson.Plane.ArcMap.exists_two_le_encard_fin_two_iff
#print axioms HadwigerNelson.Plane.ArcMap.degree_of_circle
#print axioms HadwigerNelson.Plane.ArcMap.exists_sphere_inter_ball_subset_openArc
#print axioms HadwigerNelson.Plane.ArcMap.isCompact_polarSet_Icc
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_not_mem_openArc_of_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lensProf_le_one
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.isClosed_closedLens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lens_subset_closedLens
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_region_inter_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.isClosed_collarK
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_and_repeated

-- FS131-CC2: lane C of the collar bend, continued — germ counts carried by a homeomorphism (`Pushforward`), the collar in an end's frame
#print axioms HadwigerNelson.Plane.ArcMap.exists_subset_of_isPreconnected_iUnion
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_injective_of_homeo
#print axioms HadwigerNelson.Plane.ArcMap.hasDegree_iff_of_homeo
#print axioms HadwigerNelson.Plane.ArcMap.pushforward_hasDegree
#print axioms HadwigerNelson.Plane.ArcMap.collarK_frame
#print axioms HadwigerNelson.Plane.ArcMap.side_core_pos
#print axioms HadwigerNelson.Plane.ArcMap.side_core_neg
#print axioms HadwigerNelson.Plane.ArcMap.crescent_Y
#print axioms HadwigerNelson.Plane.ArcMap.side_core
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.exists_one_side
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.homeo_mem_collarK
#print axioms HadwigerNelson.Plane.ArcMap.collarK_thin
#print axioms HadwigerNelson.Plane.ArcMap.exists_lens_clear
#print axioms HadwigerNelson.Plane.ArcMap.exists_pos_forall_le
#print axioms HadwigerNelson.Plane.ArcMap.branch_transversal
#print axioms HadwigerNelson.Plane.ArcMap.branch_tangent
#print axioms HadwigerNelson.Plane.ArcMap.exists_end_free
#print axioms HadwigerNelson.Plane.ArcMap.exists_collar_free
#print axioms HadwigerNelson.Plane.ArcMap.quarter_lt_chord
#print axioms HadwigerNelson.Plane.ArcMap.collarModel

/-! ## FS-131 wave 5 (job FS131-I5q) — `exists_preBend`'s last three children proved (their records are in the FS131-KB2 block above); helpers -/

#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_ringArc_notMem
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_ringArc_subset_sphere
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.sides_eq_of_ringPt_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.not_regularAt_of_max

-- FS131-I5q (stage 58): `bv_l3` moved to `BaseWalk` and proved (its record is in the FS131-K5b block above); `l3_base` and `bv_l3` over `l3_core`
#print axioms HadwigerNelson.Plane.ArcMap.l3_core
#print axioms HadwigerNelson.Plane.ArcMap.bv_l3_dbl
#print axioms HadwigerNelson.Plane.ArcMap.not_onRingArc_of_finite
#print axioms HadwigerNelson.Plane.ArcMap.ringCircle_val_germ
#print axioms HadwigerNelson.Plane.ArcMap.ringCircle_noSwap
#print axioms HadwigerNelson.Plane.ArcMap.eq_or_eq_neg_of_dot_I_mul_e
#print axioms HadwigerNelson.Plane.CircleColouring.link_bad_finite
#print axioms HadwigerNelson.Plane.CircleColouring.link_val_right_side
#print axioms HadwigerNelson.Plane.CircleColouring.link_val_left_side

/-! ## FS-131 wave 5 (job FS131-IA1) — the bends in the form the arc step reads (`Plane/ValidMap/BendStep`)

The last two records — the horn clause for the collar bend, and the away bend in collar form — were this module's open children;
both are proved (FS131-BA2; FS131-BA1, BA2, BA3 over FS131-KA1's plan). -/

#print axioms HadwigerNelson.Plane.ArcMap.Γ_eq_of_degree_clause
#print axioms HadwigerNelson.Plane.ArcMap.r2_notMem_region
#print axioms HadwigerNelson.Plane.ArcMap.radiusTwoArc_inter_dom_subset_Γ
#print axioms HadwigerNelson.Plane.ArcMap.radiusTwoArc_disjoint_openArc
#print axioms HadwigerNelson.Plane.ArcMap.isR2Arc_of_fixed
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.free_of_isClean
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_isClean
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_isR2Arc
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_degree_le
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_hornCount_le
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_part

/-! ## FS-131 wave 5 (job FS131-IA2) — the arc step from the clauses a bend exports (`Plane/ValidMap/ArcStep`)

The last two records are the toward collar bend's instance of the interface; its horn clause is `CollarFit.map_hornCount_le`
(`BendStep`), proved by FS131-BA2. -/

#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.coloursAt_openArc
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.sides_ne_of_isClean
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.degree_openArc
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.disjoint_openArc_of_ne
#print axioms HadwigerNelson.Plane.ArcMap.exists_hasHornCount_isHorn_iff
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcStep_radius
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.dom_eq
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.dist_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.symm_cases
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.coloursAt_of_notMem
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.coloursAt_centre
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.isClean
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.localStep
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.isModification
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.fixed_or_gain
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.coloursAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.degree_le
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.isSite
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.isQArc_of
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.isR2Arc_of
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.isR2Arc_left
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.maxBad
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.maxBad_centre
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.maxBad_other
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.arcStep
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.ringArc_subset_collarK
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.lensSet_subset_collarK
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.map_localStep
#print axioms HadwigerNelson.Plane.ArcMap.ArcBend.of_away
#print axioms HadwigerNelson.Plane.ArcMap.CollarFit.arcBend
#print axioms HadwigerNelson.Plane.ArcMap.exists_arcBend_toward

/-! ## FS-131 wave 5 (job FS131-KA1) — the away bend as FS131-KA1 laid it out (`Plane/ValidMap/BendAway`, `LensOut`, `HornChart`, `CollarMapOut`, `R2Cap`, `BendGap`)

The plan's children and the three theorems proved from them (`bend_away_gap`, `bend_away_subdiv`, `CollarFitOut.pushOutProfiles`;
`bend_away_part` is in FS131-IA1's block above). Every record is proved: lanes G and D by FS131-BA1, lanes C and H by FS131-BA2,
`CollarFitOut.map_R1` and `map_R2` by FS131-BA3 (their helpers are in those jobs' blocks below). -/

#print axioms HadwigerNelson.Plane.R2Subdiv.lt
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.union
#print axioms HadwigerNelson.Plane.claim_e
#print axioms HadwigerNelson.Plane.end_cap
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.hasHornCount
#print axioms HadwigerNelson.Plane.ArcMap.collarOutArcs_locallyFinite
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_gap
#print axioms HadwigerNelson.Plane.ArcMap.bend_away_subdiv
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.pushOutProfiles
#print axioms HadwigerNelson.Plane.R2Subdiv.of_local
#print axioms HadwigerNelson.Plane.ArcMap.LocalStep.of_cutArcs
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.idle
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.next
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.join
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.contact_of_onRingArc
#print axioms HadwigerNelson.Plane.pushOutHomeo
#print axioms HadwigerNelson.Plane.pushOutHomeo_polar
#print axioms HadwigerNelson.Plane.pushOutHomeo_symm_polar
#print axioms HadwigerNelson.Plane.pushOutHomeo_eq_self
#print axioms HadwigerNelson.Plane.pushOutProfiles_collar
#print axioms HadwigerNelson.Plane.collarOutArcs_carrier
#print axioms HadwigerNelson.Plane.dist_lt_one_of_thin
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_iff_of_agree
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_zero_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_zero_of_two_spheres
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_iff_of_germ_swap
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.homeo_image_dom
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.collarOutArcs_nondegenerate
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.collarOutArcs_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_lens
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_agreesOff
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_valid
#print axioms HadwigerNelson.Plane.ArcMap.exists_r2_crescent_free
#print axioms HadwigerNelson.Plane.ArcMap.r2_side_dichotomy
#print axioms HadwigerNelson.Plane.ArcMap.exists_r2Subdiv
#print axioms HadwigerNelson.Plane.ArcMap.exists_lensOut_clear
#print axioms HadwigerNelson.Plane.ArcMap.exists_collarFitOut
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_ringArcsWithin
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R1
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_R2
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_localStep
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.map_hornCount_le
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.awayBend

/-! ## FS-131 wave 5 (job FS131-M7) — the join of wave 5's lines; the arc step proved from the bends (`Plane/ValidMap/Procedure`)

One new declaration: `IsMaxRingArc.meet` (FS131-IA1's W5, FS131-IA2's proof), on which `exists_arcStep`'s proof reads the maximality
of the bent arc. `exists_arcStep` itself has its record above (once); it rests, through `bend_away_part` and
`exists_arcBend_toward`, on the six bend modules (`BendAway`, `LensOut`, `CollarMapOut`, `R2Cap`, `HornChart`, `BendGap`) and on
`BendStep`'s `CollarFit.map_hornCount_le`, all proved since FS131-L5 merged `fs131-w5z`. Moved by the join, in FS131-IA2's block
above: `CollarFit.map_localStep` reads `Plane/ValidMap/BendAway`'s `LocalStep.of_cutArcs` (its proof stood in `ArcStep` on
`fs131-w5y`; inventory item 448 (a)). -/

#print axioms HadwigerNelson.Plane.ArcMap.IsMaxRingArc.meet

/-! ## FS-131 wave 5 (job FS131-RP1) — the remedy pass: the ruled statement tidies, the statements that stood under several names

One new declaration: `collarModel_hyps` (`Plane/ValidMap/BendCollar`; FS131-QA4's QA4-C1), the hypotheses of `exists_collarFit` and
of `bend_toward_collar` at once on `l60Frag`'s sub-arc — `collarModel`'s old body; `collarModel` is now `exists_collarFit` at it.
Statements changed, each ruled, their records above: `nb4p` (441 (a)), `bend_toward_collar` (419 (d), 427 (a)), `exists_rayStep`,
`exists_shaveStep` (450 (c)), `placeHom_step`, `falconerFan_five_placeHom` and the definition `DyadicSqrt3Conclusion` (419 (a)).
Moved, names and records unchanged: `conj_e`, `sq_norm_eq` (`Plane/Chord` → `Plane/Basic`), `HasDegree.unique` (`Pushforward` →
`Plane/ValidMap/Basic`). Removed with their records, each a second name for a statement kept (rulings 434 (d), 459 (c)):
`sq_norm_re_im`, `ArcMap.sq_norm_eq_re_im`, `ArcMap.norm_sq_eq_re_im` (kept: `sq_norm_eq`); `SixFragment`'s `conj_e` (the name
that stood twice); `HasDegree.eq` (kept: `HasDegree.unique`); `coloursAt_eq_of_mem_interiorPts` (kept:
`coloursAt_eq_singleton_of_interior`); `ArcMap.dist_sq_re_im` (kept: `dist_sq_re_im`); `ringArc_add_int_mul` (kept:
`ringArc_add_two_pi_mul`); `ringPt_add_int_mul` (kept: `ringPt_add_int`); `IsRingArc.union_of_overlap` (kept: `IsRingArc.union`);
`finite_arcs_meeting_compact` (kept: `finite_arcs_inter_compact`). -/

#print axioms HadwigerNelson.Plane.ArcMap.collarModel_hyps

/-! ## FS-131 wave 5 (job FS131-BA1) — the outward bend's lens, map and composition (`Plane/ValidMap/LensOut`, `CollarMapOut`, `BendAway`)

Lanes G and D of FS131-KA1's plan are proved: the twenty leaves of those three modules listed in FS131-KA1's block above (from
`R2Subdiv.of_local` to `CollarFitOut.map_valid`, `CollarFitOut.pushOutProfiles` with them) no longer rest on `sorryAx`. This block holds
the helpers the proofs added — the outward push's profile lemmas, the two real inequalities under `dist_lt_one_of_thin`, the mirrors
for `R > 1` of the tangent circle's lemmas, the mirrors of `CollarMap`'s collar lemmas for `CollarFitOut`, and what the composition
reads of one bend. -/

#print axioms HadwigerNelson.Plane.PushOutProfiles.cases
#print axioms HadwigerNelson.Plane.PushOutProfiles.toward
#print axioms HadwigerNelson.Plane.PushOutProfiles.a_pos
#print axioms HadwigerNelson.Plane.PushOutProfiles.push1_zero
#print axioms HadwigerNelson.Plane.PushOutProfiles.push1_pos
#print axioms HadwigerNelson.Plane.PushOutProfiles.push1_push1
#print axioms HadwigerNelson.Plane.two_sin_half_le_of_gap
#print axioms HadwigerNelson.Plane.sq_div_two_lt_sin
#print axioms HadwigerNelson.Plane.tangRad_mono
#print axioms HadwigerNelson.Plane.tangRad_mul_cos_anti
#print axioms HadwigerNelson.Plane.tangentArc_image_out
#print axioms HadwigerNelson.Plane.collarOutMid_eq
#print axioms HadwigerNelson.Plane.dist_collarOutMid_left
#print axioms HadwigerNelson.Plane.dist_collarOutMid_right
#print axioms HadwigerNelson.Plane.outerProf_le_left
#print axioms HadwigerNelson.Plane.outerProf_le_right
#print axioms HadwigerNelson.Plane.dist_lt_one_of_mem_lensOutSet
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.mem_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.kin_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.kout_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.homeo_eq_self
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.homeo_ringPt
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.homeo_fix_Γ
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.lensOutCurve_subset
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.ringPt_mem_lensOutCurve
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.not_kept
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.homeo_image_Γ
#print axioms HadwigerNelson.Plane.ringPt_inj_of_abs_sub_lt
#print axioms HadwigerNelson.Plane.ArcMap.AgreesOff.mem_Γ_iff_of_notMem
#print axioms HadwigerNelson.Plane.ArcMap.AgreesOff.mem_region_iff_of_notMem
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.dist_centre
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.closure_region_iff
#print axioms HadwigerNelson.Plane.ArcMap.AwayBend.ringPt_notMem

/-! ## FS-131 wave 5 (job FS131-BA2) — the away bend's lanes C and H: new helper declarations (`Plane/ValidMap/HornChart`, `R2Cap`, `BendGap`)

The children themselves are in FS131-KA1's block above; these are the helpers this job minted. All proved. -/

#print axioms HadwigerNelson.Plane.ArcMap.branch_frequently_mem_sphere
#print axioms HadwigerNelson.Plane.ArcMap.branch_curv_eq_of_two_spheres
#print axioms HadwigerNelson.Plane.ArcMap.germ_eq_of_frequently_branchPt_eq
#print axioms HadwigerNelson.Plane.conj_e_mul_e'
#print axioms HadwigerNelson.Plane.r2_frame
#print axioms HadwigerNelson.Plane.r2_coords
#print axioms HadwigerNelson.Plane.r2_dist_sq
#print axioms HadwigerNelson.Plane.r2_dist_sq_base
#print axioms HadwigerNelson.Plane.r2_dist_sq_center
#print axioms HadwigerNelson.Plane.r2X_eq
#print axioms HadwigerNelson.Plane.r2_coords_r2
#print axioms HadwigerNelson.Plane.continuous_r2X
#print axioms HadwigerNelson.Plane.continuous_r2Y
#print axioms HadwigerNelson.Plane.isOpen_r2Side
#print axioms HadwigerNelson.Plane.two_lt_dist_iff
#print axioms HadwigerNelson.Plane.dist_lt_of_mem_r2Crescent
#print axioms HadwigerNelson.Plane.isPreconnected_r2Crescent
#print axioms HadwigerNelson.Plane.r2pt_mem_r2Side
#print axioms HadwigerNelson.Plane.mem_closure_dist_gt
#print axioms HadwigerNelson.Plane.under_point
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.exists_inner_ball
#print axioms HadwigerNelson.Plane.r2Y_eq
#print axioms HadwigerNelson.Plane.r2X_polar
#print axioms HadwigerNelson.Plane.r2_dist_sq_pair
#print axioms HadwigerNelson.Plane.tangRad_neg
#print axioms HadwigerNelson.Plane.dist_lt_of_lt_tangRad
#print axioms HadwigerNelson.Plane.lens_end_far
#print axioms HadwigerNelson.Plane.two_le_dist_of_far
#print axioms HadwigerNelson.Plane.eq_ringPt_of_mem_tangentCircle
#print axioms HadwigerNelson.Plane.im_ne_zero_of_two_spheres
#print axioms HadwigerNelson.Plane.branchPt_end_frame
#print axioms HadwigerNelson.Plane.e_sign_mul
#print axioms HadwigerNelson.Plane.dist_branchPt_end
#print axioms HadwigerNelson.Plane.branchPt_end_polar
#print axioms HadwigerNelson.Plane.branchPt_end_unit
#print axioms HadwigerNelson.Plane.lt_of_sin_lt_sin
#print axioms HadwigerNelson.Plane.inv_between
#print axioms HadwigerNelson.Plane.exists_collar_end_radius
#print axioms HadwigerNelson.Plane.ArcMap.branch_between_notMem_Γ
#print axioms HadwigerNelson.Plane.ArcMap.collar_end_Γ
#print axioms HadwigerNelson.Plane.ArcMap.hasHornCount_iff_collar_end
#print axioms HadwigerNelson.Plane.ArcMap.hornCount_le_of_collarBend
#print axioms HadwigerNelson.Plane.ArcMap.tangRad_sub_one_le_mul
#print axioms HadwigerNelson.Plane.ArcMap.neg_two_lt_r2Y
#print axioms HadwigerNelson.Plane.ArcMap.lens_far_end
#print axioms HadwigerNelson.Plane.ArcMap.exists_gap_cap
#print axioms HadwigerNelson.Plane.ArcMap.exists_gap_middle_far
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.lensOutSet_subset_collar
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.ringArc_subset_collar
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.collar_isClosed
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.collar_inter_sphere
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.homeo_maps_collar
-- FS131-BA2 block end

/-! ## FS-131 wave 5 (job FS131-BA3) — the outward bend's last two children: new helper declarations (`Plane/ValidMap/BendGap`)

`CollarFitOut.map_R1` and `CollarFitOut.map_R2` themselves are in FS131-KA1's block above; these are the helpers this job minted
(the mirrors of `CollarFit.exists_one_side`, the closed lens, `sides_end`, `sides_eq`). All proved. -/
#print axioms HadwigerNelson.Plane.ArcMap.collarK_one_side
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.one_le_outerProf
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.isClosed_closedLensOut
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.lensOut_subset_closedLensOut
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.sides_end
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.sides_eq
#print axioms HadwigerNelson.Plane.ArcMap.CollarFitOut.ringPt_notMem_map_Γ
-- FS131-BA3 block end

/-! ## FS-131 wave 5 (job FS131-L5) — the landing: one record the wave's blocks lacked

`LocalSeq.limit_dom` (`Plane/ValidMap/Limit`; `@[simp]`, by `rfl`) was the one hand-written theorem of wave 5 with no record:
found by reading the kernel's list of the landing library's theorems against this file (`tools/fs131_l5_records.py`). Removed
by this job with its record: `ringPt_ne_of_abs_sub_lt` (`BaseDense`; kept: `ringPt_inj_of_abs_sub_lt`, `BendAway`). -/

#print axioms HadwigerNelson.Plane.ArcMap.LocalSeq.limit_dom

/-! ## FS-131, the example maps (jobs FS131-KM1, MA1, MB1, MB2; landed by FS131-MC1): `Plane/Models/{Paint, Moves, Stuck, Bends}` -/
-- FS131-KM1: the construction (Paint) — proved in the skeleton
#print axioms HadwigerNelson.Plane.ArcMap.relabel_region
#print axioms HadwigerNelson.Plane.ArcMap.relabel_region_eq_empty
#print axioms HadwigerNelson.Plane.ArcMap.relabel_valid
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_paint
#print axioms HadwigerNelson.Plane.ArcMap.region_paint
#print axioms HadwigerNelson.Plane.ArcMap.paint_valid
#print axioms HadwigerNelson.Plane.ArcMap.paint_condition5
#print axioms HadwigerNelson.Plane.brickBase_valid
#print axioms HadwigerNelson.Plane.brickBase_condition5
#print axioms HadwigerNelson.Plane.brickBase_region_spare
-- FS131-KM1: the construction (Paint) — leaves
#print axioms HadwigerNelson.Plane.brickBase_mem_interiorPts
#print axioms HadwigerNelson.Plane.brickBase_col_eq
#print axioms HadwigerNelson.Plane.brickBase_col_zero
#print axioms HadwigerNelson.Plane.tangentDisc_subset_ball
#print axioms HadwigerNelson.Plane.frontier_hornSet_subset
#print axioms HadwigerNelson.Plane.isPreconnected_fanRest
#print axioms HadwigerNelson.Plane.ball_diff_fan
#print axioms HadwigerNelson.Plane.isSector_fan_iff
-- FS131-KM1: the four moves' models (Moves)
#print axioms HadwigerNelson.Plane.hornModel_shave
#print axioms HadwigerNelson.Plane.hornModel_open
#print axioms HadwigerNelson.Plane.hornModel_hasHornCount
#print axioms HadwigerNelson.Plane.hornModel_contact
#print axioms HadwigerNelson.Plane.hornModel_shaveAvailable
#print axioms HadwigerNelson.Plane.hornModel_holedTile
#print axioms HadwigerNelson.Plane.twoHornModel_rayMerge
#print axioms HadwigerNelson.Plane.twoHornModel_merge
#print axioms HadwigerNelson.Plane.twoHornModel_available
-- FS131-KM1: the stuck vertex and the doubly shadowed band (Stuck)
#print axioms HadwigerNelson.Plane.stuckModel_hyps
#print axioms HadwigerNelson.Plane.stuckModel_contacts
#print axioms HadwigerNelson.Plane.stuckModel_flanks
#print axioms HadwigerNelson.Plane.shadowModel_flank_ne
-- FS131-KM1: the bends (Bends)
#print axioms HadwigerNelson.Plane.cuspFrag_bend_away
#print axioms HadwigerNelson.Plane.cuspFrag_bend_toward
#print axioms HadwigerNelson.Plane.awayModel_hyps
#print axioms HadwigerNelson.Plane.awayModel_r2Contacts

/-! ## FS-131, the example maps, half A (job FS131-MA1) — `Plane/Models/Paint`'s leaves proved, and the two models of the four local moves (`Plane/Models/Moves`). Records the FS131-KM1 block above already lists are not repeated here. -/
-- FS131-MA1: the construction (Paint) — the leaves KM1's block does not list, and the fan's partition
#print axioms HadwigerNelson.Plane.norm_plantDir
#print axioms HadwigerNelson.Plane.hornArcs_nondegenerate
#print axioms HadwigerNelson.Plane.hornArcs_carrier_subset
#print axioms HadwigerNelson.Plane.isOpen_fanRest
#print axioms HadwigerNelson.Plane.fanRest_ne_hornSet
#print axioms HadwigerNelson.Plane.iUnion_fanPiece
#print axioms HadwigerNelson.Plane.fanPiece_data
#print axioms HadwigerNelson.Plane.encard_sectors_fan
#print axioms HadwigerNelson.Plane.encard_horns_fan
#print axioms HadwigerNelson.Plane.ArcMap.region_paint_of_region_eq_empty
#print axioms HadwigerNelson.Plane.ArcMap.region_paint_subset
#print axioms HadwigerNelson.Plane.ArcMap.allowedCone_tangent
#print axioms HadwigerNelson.Plane.ArcMap.tangent_contact_cone
-- FS131-MA1: the four moves' models (Moves) — the leaves KM1's block does not list, and the two class lemmas
#print axioms HadwigerNelson.Plane.hornModel_valid
#print axioms HadwigerNelson.Plane.hornModel_region_seven
#print axioms HadwigerNelson.Plane.hornModel_isHorn
#print axioms HadwigerNelson.Plane.hornModel_hasSectors
#print axioms HadwigerNelson.Plane.hornModel_hasDegree
#print axioms HadwigerNelson.Plane.hornModel_flanks
#print axioms HadwigerNelson.Plane.hornModel_clear
#print axioms HadwigerNelson.Plane.hornModel_cone
#print axioms HadwigerNelson.Plane.hornModel_allowedCone
#print axioms HadwigerNelson.Plane.twoHornModel_valid
#print axioms HadwigerNelson.Plane.twoHornModel_region_seven
#print axioms HadwigerNelson.Plane.twoHornModel_isHorn
#print axioms HadwigerNelson.Plane.twoHornModel_hasSectors
#print axioms HadwigerNelson.Plane.twoHornModel_cone
#print axioms HadwigerNelson.Plane.twoHornModel_allowedCone
#print axioms HadwigerNelson.Plane.twoHornModel_hasDegree
#print axioms HadwigerNelson.Plane.twoHornModel_hasHornCount

/-! ## FS-131, the example maps, half B (job FS131-MB1) — the leaves of `Plane/Models/{Stuck, Bends}` proved; the model theorems themselves are in FS131-KM1's block above -/
-- FS131-MB1: the cusp fragment's ring arc (Bends) — reads nothing of `Paint`
#print axioms HadwigerNelson.Plane.cuspFrag_isRingArc
#print axioms HadwigerNelson.Plane.cuspFrag_coloursAt_I
#print axioms HadwigerNelson.Plane.cuspFrag_radiusTwo_disjoint
-- FS131-MB1: the stuck vertex (Stuck) — `stuckModel_hyps`, `_contacts`, `_flanks` are in FS131-KM1's block; what reads the partition at the
-- vertex rests on `Paint`'s leaf `brickBase_mem_interiorPts` until implementer A's branch joins
#print axioms HadwigerNelson.Plane.stuckArcs_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_stuckW_subset
#print axioms HadwigerNelson.Plane.stuckCol_locallyConstant
#print axioms HadwigerNelson.Plane.stuckModel_no_unit_pair
#print axioms HadwigerNelson.Plane.stuckModel_valid
#print axioms HadwigerNelson.Plane.stuckModel_partition
#print axioms HadwigerNelson.Plane.stuckModel_coloursAt
#print axioms HadwigerNelson.Plane.stuckModel_hasSectors
#print axioms HadwigerNelson.Plane.stuckModel_isHorn
#print axioms HadwigerNelson.Plane.stuckModel_horn_cases
#print axioms HadwigerNelson.Plane.stuckModel_shadow
#print axioms HadwigerNelson.Plane.stuckModel_not_mergeAvailable
#print axioms HadwigerNelson.Plane.stuckModel_not_rayAvailable
#print axioms HadwigerNelson.Plane.stuckModel_not_shaveAvailable
#print axioms HadwigerNelson.Plane.stuckModel_isStuck

/-! ## FS-131, the example maps, half B continued (job FS131-MB2) — `shadowModel`'s leaves (`Plane/Models/Stuck`) and `awayModel`'s (`Plane/Models/Bends`) proved; the model theorems `shadowModel_flank_ne`, `awayModel_hyps` are in FS131-KM1's block above -/
-- FS131-MB2: the doubly shadowed band (Stuck)
#print axioms HadwigerNelson.Plane.shadowArcs_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_shadowW_subset
#print axioms HadwigerNelson.Plane.shadowCol_locallyConstant
#print axioms HadwigerNelson.Plane.shadowModel_not_mem_arcs
#print axioms HadwigerNelson.Plane.shadowModel_mem_region
#print axioms HadwigerNelson.Plane.shadowModel_flank_source
#print axioms HadwigerNelson.Plane.shadowModel_no_unit_pair
#print axioms HadwigerNelson.Plane.shadowModel_valid
#print axioms HadwigerNelson.Plane.shadowModel_not_isUnitArc
#print axioms HadwigerNelson.Plane.shadowModel_condition5
#print axioms HadwigerNelson.Plane.shadowModel_flanks
#print axioms HadwigerNelson.Plane.shadowModel_witness_real
#print axioms HadwigerNelson.Plane.shadowModel_shadow
#print axioms HadwigerNelson.Plane.shadowModel_doublyShadowed
-- FS131-MB2: the outward bend's plane map (Bends) — `awayModel_hyps` and `awayModel_r2Contacts` are in FS131-KM1's block
#print axioms HadwigerNelson.Plane.awayArcs_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_awayW_subset
#print axioms HadwigerNelson.Plane.awayModel_no_unit_pair
#print axioms HadwigerNelson.Plane.awayModel_region_seven
#print axioms HadwigerNelson.Plane.awayModel_brick
#print axioms HadwigerNelson.Plane.awayModel_approach_real
#print axioms HadwigerNelson.Plane.awayModel_centre_brick
#print axioms HadwigerNelson.Plane.awayModel_coloursAt
#print axioms HadwigerNelson.Plane.awayModel_bend_toward

/-! ## FS-131, the example maps (job FS131-MC1) — the landing: the lane's theorems the four jobs' blocks did not list, and
`Plane/Models/Applied` (the landed theorems applied to the models). Found by reading the files; checked against the kernel's own
list by `tools/fs131_l5_records.py`. -/
-- Plane/Models/Applied
#print axioms HadwigerNelson.Plane.hornModel_isSite
#print axioms HadwigerNelson.Plane.twoHornModel_isSite
#print axioms HadwigerNelson.Plane.hornModel_hole_disconnected
#print axioms HadwigerNelson.Plane.stuckModel_ncard
#print axioms HadwigerNelson.Plane.stuckModel_isChainVertex
#print axioms HadwigerNelson.Plane.stuckModel_isHorn_pi
#print axioms HadwigerNelson.Plane.stuckModel_not_mem_interiorPts
#print axioms HadwigerNelson.Plane.stuckModel_interior_allowedCone
#print axioms HadwigerNelson.Plane.stuckModel_contacts_frame
#print axioms HadwigerNelson.Plane.stuckModel_horn_shadows
#print axioms HadwigerNelson.Plane.awayModel_radiusTwoArc_subset
#print axioms HadwigerNelson.Plane.awayModel_gap
#print axioms HadwigerNelson.Plane.awayModel_isRingArc_gap
#print axioms HadwigerNelson.Plane.awayModel_bend_away_part
#print axioms HadwigerNelson.Plane.awayModel_bend_away_whole
-- Plane/Models/Bends
#print axioms HadwigerNelson.Plane.cuspArc_sin
#print axioms HadwigerNelson.Plane.cuspArc_pt
#print axioms HadwigerNelson.Plane.cuspArc_mem
#print axioms HadwigerNelson.Plane.cuspFrag_closure_region_subset
#print axioms HadwigerNelson.Plane.awayModel_P_coords
#print axioms HadwigerNelson.Plane.awayModel_dist_sq
#print axioms HadwigerNelson.Plane.awayModel_circPt
#print axioms HadwigerNelson.Plane.awayModel_mem_circ
#print axioms HadwigerNelson.Plane.awayModel_arcs_subset
#print axioms HadwigerNelson.Plane.awayModel_isOpen_rect
#print axioms HadwigerNelson.Plane.awayModel_closure_rect
#print axioms HadwigerNelson.Plane.awayModel_frontier_rect
#print axioms HadwigerNelson.Plane.awayModel_wall_mem
#print axioms HadwigerNelson.Plane.awayModel_mem_awayW
#print axioms HadwigerNelson.Plane.awayModel_rect_subset
#print axioms HadwigerNelson.Plane.awayModel_rect_dist
#print axioms HadwigerNelson.Plane.awayModel_not_mem_arcs
#print axioms HadwigerNelson.Plane.awayArcs_finite
#print axioms HadwigerNelson.Plane.awayModel_isPlaneMap
#print axioms HadwigerNelson.Plane.awayModel_trig
#print axioms HadwigerNelson.Plane.awayModel_ringPt_mem
-- Plane/Models/Moves
#print axioms HadwigerNelson.Plane.hornB_nondegenerate
#print axioms HadwigerNelson.Plane.hornB_finite
#print axioms HadwigerNelson.Plane.frontier_hornW_subset
#print axioms HadwigerNelson.Plane.hornModel_isPlaneMap
#print axioms HadwigerNelson.Plane.hornModel_covers
#print axioms HadwigerNelson.Plane.hornModel_eq_paint
#print axioms HadwigerNelson.Plane.hornFan_strictMono
#print axioms HadwigerNelson.Plane.hornFan_bound
#print axioms HadwigerNelson.Plane.hornB_inter_ball
#print axioms HadwigerNelson.Plane.hornModel_interiorPts_inter_ball
#print axioms HadwigerNelson.Plane.hornModel_isSector_iff
#print axioms HadwigerNelson.Plane.hornW_disjoint_hornB
#print axioms HadwigerNelson.Plane.hornW_subset_interiorPts
#print axioms HadwigerNelson.Plane.hornModel_col_of_mem
#print axioms HadwigerNelson.Plane.hornModel_col_of_not_mem
#print axioms HadwigerNelson.Plane.hornModel_horn_subset_col
#print axioms HadwigerNelson.Plane.hornModel_fanRest_subset_region
#print axioms HadwigerNelson.Plane.hornW_subset
#print axioms HadwigerNelson.Plane.hornModel_tangent
#print axioms HadwigerNelson.Plane.hornModel_contact_cone
#print axioms HadwigerNelson.Plane.holedTile_eq
#print axioms HadwigerNelson.Plane.isOpen_holedTile
#print axioms HadwigerNelson.Plane.closure_holedTile_subset
#print axioms HadwigerNelson.Plane.holedTile_subset_interiorPts
#print axioms HadwigerNelson.Plane.mem_holedTile_of_mem_closure
#print axioms HadwigerNelson.Plane.holedTile_base_mem
#print axioms HadwigerNelson.Plane.isPreconnected_holedTile
#print axioms HadwigerNelson.Plane.twoHornB_nondegenerate
#print axioms HadwigerNelson.Plane.twoHornB_finite
#print axioms HadwigerNelson.Plane.frontier_twoHornW_subset
#print axioms HadwigerNelson.Plane.twoHornModel_isPlaneMap
#print axioms HadwigerNelson.Plane.twoHornModel_covers
#print axioms HadwigerNelson.Plane.twoHornModel_eq_paint
#print axioms HadwigerNelson.Plane.twoHornFan_strictMono
#print axioms HadwigerNelson.Plane.twoHornFan_bound
#print axioms HadwigerNelson.Plane.twoHornB_inter_ball
#print axioms HadwigerNelson.Plane.twoHornModel_interiorPts_inter_ball
#print axioms HadwigerNelson.Plane.twoHornModel_isSector_iff
#print axioms HadwigerNelson.Plane.twoHornW_disjoint_twoHornB
#print axioms HadwigerNelson.Plane.twoHornW_subset_interiorPts
#print axioms HadwigerNelson.Plane.twoHornModel_col_of_mem
#print axioms HadwigerNelson.Plane.twoHornModel_col_of_not_mem
#print axioms HadwigerNelson.Plane.twoHornModel_horns_subset_col
#print axioms HadwigerNelson.Plane.twoHornModel_rest_gap_subset_col
#print axioms HadwigerNelson.Plane.twoHornW_subset
#print axioms HadwigerNelson.Plane.twoHornModel_tangent
-- Plane/Models/Paint
#print axioms HadwigerNelson.Plane.ArcMap.relabel_interiorPts
#print axioms HadwigerNelson.Plane.ArcMap.relabel_Γ
#print axioms HadwigerNelson.Plane.ArcMap.relabel_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.relabel_condition5
#print axioms HadwigerNelson.Plane.ArcMap.paint_isPlaneMap
#print axioms HadwigerNelson.Plane.ArcMap.paint_col_of_mem
#print axioms HadwigerNelson.Plane.ArcMap.paint_col_of_not_mem
#print axioms HadwigerNelson.Plane.ArcMap.isClear_paint_of_mem_region
#print axioms HadwigerNelson.Plane.ArcMap.interiorPts_paint_inter_ball
#print axioms HadwigerNelson.Plane.brickBase_isPlaneMap
#print axioms HadwigerNelson.Plane.mem_brickCell_of_coords
#print axioms HadwigerNelson.Plane.brickBase_col_val
#print axioms HadwigerNelson.Plane.dist_sq_coords
#print axioms HadwigerNelson.Plane.plantPt_re
#print axioms HadwigerNelson.Plane.plantPt_im
#print axioms HadwigerNelson.Plane.plantDir_re
#print axioms HadwigerNelson.Plane.plantDir_im
#print axioms HadwigerNelson.Plane.tangentCentre_re
#print axioms HadwigerNelson.Plane.tangentCentre_im
#print axioms HadwigerNelson.Plane.dist_tangentCentre
#print axioms HadwigerNelson.Plane.hornArcs_finite
#print axioms HadwigerNelson.Plane.closure_hornSet_subset
#print axioms HadwigerNelson.Plane.tanHeight_zero_left
#print axioms HadwigerNelson.Plane.half_le_one_sub
#print axioms HadwigerNelson.Plane.abs_frameY_le
#print axioms HadwigerNelson.Plane.eq_of_frame_eq_zero
#print axioms HadwigerNelson.Plane.self_mem_carrier_germArc
#print axioms HadwigerNelson.Plane.mem_carrier_germArc_of_tanHeight_eq_zero
#print axioms HadwigerNelson.Plane.frameX_combo
#print axioms HadwigerNelson.Plane.convex_frameX_neg
#print axioms HadwigerNelson.Plane.dist_fromFrame_lt
#print axioms HadwigerNelson.Plane.exists_sign_change
#print axioms HadwigerNelson.Plane.frame_of_mem_carrier_germArc
#print axioms HadwigerNelson.Plane.fan_tanHeight_of_mem_hornSet
#print axioms HadwigerNelson.Plane.Ioo_subset_coneAt_fanRest
#print axioms HadwigerNelson.Plane.interior_coneAt_fanRest_nonempty
#print axioms HadwigerNelson.Plane.frameX_zero
#print axioms HadwigerNelson.Plane.frameY_zero
#print axioms HadwigerNelson.Plane.abs_re_sub_le_dist
#print axioms HadwigerNelson.Plane.abs_im_sub_le_dist
#print axioms HadwigerNelson.Plane.mem_hornArcs_carrier_iff_of_mem_ball
#print axioms HadwigerNelson.Plane.disjoint_hornSet_carrier_germArc
#print axioms HadwigerNelson.Plane.disjoint_hornSet_hornArcs
#print axioms HadwigerNelson.Plane.disjoint_fanRest_hornSet
#print axioms HadwigerNelson.Plane.disjoint_hornSet_hornSet
#print axioms HadwigerNelson.Plane.fanPiece_mono_radius
#print axioms HadwigerNelson.Plane.fanPiece_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsSector.false_of_col
#print axioms HadwigerNelson.Plane.plantBall_subset_brick
#print axioms HadwigerNelson.Plane.brickBase_mem_interiorPts_zero
#print axioms HadwigerNelson.Plane.plantBall_subset_interiorPts
#print axioms HadwigerNelson.Plane.plantBall_subset_region_zero
#print axioms HadwigerNelson.Plane.tangentBrick_subset_interiorPts
#print axioms HadwigerNelson.Plane.re_add_mul_I
#print axioms HadwigerNelson.Plane.im_add_mul_I
#print axioms HadwigerNelson.Plane.mk_mem_tangentBrick
#print axioms HadwigerNelson.Plane.closedBall_tangentCentre_subset_tangentBrick
#print axioms HadwigerNelson.Plane.tangentDisc_subset_interiorPts
#print axioms HadwigerNelson.Plane.isOpen_tangentBrick
#print axioms HadwigerNelson.Plane.convex_tangentBrick
#print axioms HadwigerNelson.Plane.closure_tangentBrick_subset
#print axioms HadwigerNelson.Plane.mem_tangentBrick_of_mem_interiorPts
#print axioms HadwigerNelson.Plane.tangentDisc_far
#print axioms HadwigerNelson.Plane.tangentDisc_subset_closedBall
#print axioms HadwigerNelson.Plane.disjoint_tangentDisc_sphere
#print axioms HadwigerNelson.Plane.disjoint_plantBall_tangent
#print axioms HadwigerNelson.Plane.hornSet_subset_plantBall
#print axioms HadwigerNelson.Plane.tangentCircle_carrier
#print axioms HadwigerNelson.Plane.tangentCircle_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_tangentDisc
#print axioms HadwigerNelson.Plane.horn_ineq
#print axioms HadwigerNelson.Plane.dist_tangentCentre_le_of_mem_hornSet
#print axioms HadwigerNelson.Plane.dist_lt_one_of_hornZone
#print axioms HadwigerNelson.Plane.closure_inter_sphere_subset
#print axioms HadwigerNelson.Plane.halfPlane_plantDir
-- Plane/Models/Stuck
#print axioms HadwigerNelson.Plane.stuckModel_plant_coords
#print axioms HadwigerNelson.Plane.stuckModel_abs_coords_le
#print axioms HadwigerNelson.Plane.stuckModel_carrier_circ
#print axioms HadwigerNelson.Plane.stuckModel_corners
#print axioms HadwigerNelson.Plane.stuckModel_mem_seg_iff
#print axioms HadwigerNelson.Plane.stuckModel_mem_poleSqArcs_iff
#print axioms HadwigerNelson.Plane.stuckModel_poleSqArcs_subset
#print axioms HadwigerNelson.Plane.stuckModel_mem_poleSq
#print axioms HadwigerNelson.Plane.stuckModel_isOpen_poleSq
#print axioms HadwigerNelson.Plane.stuckModel_poleSq_diag
#print axioms HadwigerNelson.Plane.stuckModel_frames
#print axioms HadwigerNelson.Plane.stuckModel_poles
#print axioms HadwigerNelson.Plane.stuckModel_germ_subset
#print axioms HadwigerNelson.Plane.stuckModel_mem_germ_of_dist
#print axioms HadwigerNelson.Plane.stuckModel_arcs_union
#print axioms HadwigerNelson.Plane.stuckModel_pieces
#print axioms HadwigerNelson.Plane.stuckModel_mem_arcs_ball_iff
#print axioms HadwigerNelson.Plane.stuckModel_mem_arcs_sq_iff
#print axioms HadwigerNelson.Plane.stuckModel_eventually_lt_iff
#print axioms HadwigerNelson.Plane.stuckModel_sq_disjoint
#print axioms HadwigerNelson.Plane.stuckArcs_finite
#print axioms HadwigerNelson.Plane.stuckModel_isPlaneMap
#print axioms HadwigerNelson.Plane.stuckModel_covers
#print axioms HadwigerNelson.Plane.stuckModel_stuckW_subset
#print axioms HadwigerNelson.Plane.stuckModel_interiorPts_eq
#print axioms HadwigerNelson.Plane.stuckModel_col_eq
#print axioms HadwigerNelson.Plane.stuckModel_mem_region_of
#print axioms HadwigerNelson.Plane.stuckModel_region_subset
#print axioms HadwigerNelson.Plane.stuckModel_stuckCol_ball
#print axioms HadwigerNelson.Plane.stuckModel_stuckCol_sqN
#print axioms HadwigerNelson.Plane.stuckModel_stuckCol_sqS
#print axioms HadwigerNelson.Plane.stuckModel_stuckCol_spare
#print axioms HadwigerNelson.Plane.stuckModel_mem_piece
#print axioms HadwigerNelson.Plane.stuckModel_norms
#print axioms HadwigerNelson.Plane.stuckModel_piece_cases
#print axioms HadwigerNelson.Plane.stuckModelPiece_data
#print axioms HadwigerNelson.Plane.stuckModel_piece_col
#print axioms HadwigerNelson.Plane.stuckModel_piece_subset_region
#print axioms HadwigerNelson.Plane.stuckModel_piece_hornSet
#print axioms HadwigerNelson.Plane.stuckModel_sectorsOf_encard
#print axioms HadwigerNelson.Plane.stuckModel_dist_pole_lt
#print axioms HadwigerNelson.Plane.stuckModel_near_real
#print axioms HadwigerNelson.Plane.stuckModel_near_real'
#print axioms HadwigerNelson.Plane.stuckModel_far_real
#print axioms HadwigerNelson.Plane.stuckModel_far_real'
#print axioms HadwigerNelson.Plane.stuckModel_unit_pair_ball
#print axioms HadwigerNelson.Plane.stuckModel_wedges
#print axioms HadwigerNelson.Plane.stuckModel_pole_rays
#print axioms HadwigerNelson.Plane.stuckModel_dist_vertex_sq
#print axioms HadwigerNelson.Plane.stuckModel_wedge_dist
#print axioms HadwigerNelson.Plane.stuckModel_tile_subset_sq
#print axioms HadwigerNelson.Plane.stuckModel_hasSectors_two
#print axioms HadwigerNelson.Plane.stuckModel_lens_ne_hornSet
#print axioms HadwigerNelson.Plane.stuckModel_radial
#print axioms HadwigerNelson.Plane.stuckModel_radial_sq
#print axioms HadwigerNelson.Plane.shadowModel_mem_hornArcs
#print axioms HadwigerNelson.Plane.shadowModel_hornSet_not_mem_hornArcs
#print axioms HadwigerNelson.Plane.shadowModel_dists
#print axioms HadwigerNelson.Plane.shadowModel_disjoint
#print axioms HadwigerNelson.Plane.shadowModel_isOpen
#print axioms HadwigerNelson.Plane.shadowModel_shadowCol
#print axioms HadwigerNelson.Plane.shadowArcs_finite
#print axioms HadwigerNelson.Plane.shadowModel_isPlaneMap
#print axioms HadwigerNelson.Plane.shadowModel_shadowW_subset
#print axioms HadwigerNelson.Plane.shadowModel_tanHeight
#print axioms HadwigerNelson.Plane.shadowModel_apart

/-! ## FS-131 wave 10 (job FS131-K10) — the arithmetic rows: the leaves the planner proved -/
-- FS131-K10
#print axioms HadwigerNelson.CharacterColouring.int_eq_zero_of_forall_pow_dvd
#print axioms HadwigerNelson.CharacterColouring.mem_archimedean_of_layers
#print axioms HadwigerNelson.CharacterColouring.mem_torsionBy_sup_archimedean_of_nsmul
#print axioms HadwigerNelson.CharacterColouring.gluing
#print axioms HadwigerNelson.CharacterColouring.inv_five_mem_Qring
#print axioms HadwigerNelson.CharacterColouring.gluing_field
#print axioms HadwigerNelson.CharacterColouring.gluing_iff_uniform
#print axioms HadwigerNelson.CharacterColouring.gluing_iff_of_orderBound
#print axioms HadwigerNelson.CharacterColouring.cl2
#print axioms HadwigerNelson.CharacterColouring.half_mem_bandSet
#print axioms HadwigerNelson.CharacterColouring.half_mem_torsionBy
#print axioms HadwigerNelson.SpectralInputs.sp_only_if
#print axioms HadwigerNelson.SpectralInputs.sp_only_if_interface
#print axioms HadwigerNelson.SpectralInputs.contVec_id
#print axioms HadwigerNelson.SpectralInputs.bochnerOn_bot
#print axioms HadwigerNelson.StationaryRatio.StationarySet.empty_aeIndependent
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio
#print axioms HadwigerNelson.StandingFive.K_le
#print axioms HadwigerNelson.StandingFive.targetFloor_zero

/-! ## FS-131 wave 10 (job FS131-I10A) — the spectral inputs and the character colouring's last leaf -/
-- FS131-I10A
#print axioms HadwigerNelson.SpectralInputs.mem_factorSets_iff
#print axioms HadwigerNelson.SpectralInputs.isClosed_contVec
#print axioms HadwigerNelson.SpectralInputs.lipschitz_comp_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.iUnion_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.measurableSet_factorSigma_iff
#print axioms HadwigerNelson.SpectralInputs.setOf_lt_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.contVec_eq_lpMeas
#print axioms HadwigerNelson.SpectralInputs.measurableSet_preimage_factorSigma
#print axioms HadwigerNelson.SpectralInputs.condExpL2_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.condExpL2_eq_self_iff
#print axioms HadwigerNelson.SpectralInputs.inner_sub_condExpL2_eq_zero
#print axioms HadwigerNelson.SpectralInputs.measurable_selection
#print axioms HadwigerNelson.SpectralInputs.ae_mem_condSupport
#print axioms HadwigerNelson.SpectralInputs.ae_condLaw_mul_eq_zero
#print axioms HadwigerNelson.SpectralInputs.si4
#print axioms HadwigerNelson.SpectralInputs.condExp_comp_measurePreserving
#print axioms HadwigerNelson.SpectralInputs.si4_equivariant
#print axioms HadwigerNelson.SpectralInputs.posDef_fourier
#print axioms HadwigerNelson.SpectralInputs.ext_of_fourier
#print axioms HadwigerNelson.SpectralInputs.posDef_delta
#print axioms HadwigerNelson.SpectralInputs.exists_isHaarFourier
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.integral_eq
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_mulRight
#print axioms HadwigerNelson.SpectralInputs.mul_mem_contChars_iff
#print axioms HadwigerNelson.SpectralInputs.contChars_haar_null
#print axioms HadwigerNelson.SpectralInputs.rot_negOne_apply
#print axioms HadwigerNelson.SpectralInputs.sp_if
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_add
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_zero
#print axioms HadwigerNelson.SpectralInputs.norm_comp_sub_sq
#print axioms HadwigerNelson.SpectralInputs.spectral_carried_iff
#print axioms HadwigerNelson.CharacterColouring.exists_ratLinear_extension
#print axioms HadwigerNelson.CharacterColouring.mem_archimedean_unitRing_iff

/-! ## FS-131 wave 10 (job FS131-I10B) — the stationary ratio: X25B-P, X25B-PZ, X25B-L1 (each at the class its proof
reads: the `_of_symm` / `_of_shrink` twins were folded into the rows at the join, FS131-L10A, ruling 507 (a)), the toolkit,
and the models (`StationarySet.parity`, `cantorLevel`) -/
-- FS131-I10B
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_mul
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le
#print axioms HadwigerNelson.StationaryRatio.ratio_prod_le_iSup_levels
#print axioms HadwigerNelson.StationaryRatio.ae_neg_iff
#print axioms HadwigerNelson.StationaryRatio.ratio_le_one
#print axioms HadwigerNelson.StationaryRatio.ratio_mul_le
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_add_apply
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_zero_apply
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_neg_T
#print axioms HadwigerNelson.StationaryRatio.StationarySet.T_T_neg
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_T_apply
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_T_comp
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_T_left
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_T_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.notMem_nb_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.nb_mono
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurableSet_nb
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_nb_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prod_null_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prod_apply_corr
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurable_corr
#print axioms HadwigerNelson.StationaryRatio.StationarySet.aeIndependent_iff
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_max_ratio
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measurableSet_majority
#print axioms HadwigerNelson.StationaryRatio.StationarySet.ae_majority
#print axioms HadwigerNelson.StationaryRatio.StationarySet.measure_le_majority_add
#print axioms HadwigerNelson.StationaryRatio.cosetAverage_apply
#print axioms HadwigerNelson.StationaryRatio.cosetAverage.instIsProbabilityMeasure
#print axioms HadwigerNelson.StationaryRatio.cosetAverage_compl
#print axioms HadwigerNelson.StationaryRatio.ae_mem_cosetAverage
#print axioms HadwigerNelson.StationaryRatio.cosetAverage_preimage_add
#print axioms HadwigerNelson.StationaryRatio.lintegral_prod_conv_cosetAverage
#print axioms HadwigerNelson.StationaryRatio.tendsto_measure_symmDiff_shift
#print axioms HadwigerNelson.StationaryRatio.StationarySet.prob_le_ratio_level_add
#print axioms HadwigerNelson.StationaryRatio.ratio_dirac_le
#print axioms HadwigerNelson.StationaryRatio.StationarySet.parity_prob
#print axioms HadwigerNelson.StationaryRatio.StationarySet.parity_aeIndependent
#print axioms HadwigerNelson.StationaryRatio.map_neg_dirac_one
#print axioms HadwigerNelson.StationaryRatio.ratio_dirac_one_zmod_two
#print axioms HadwigerNelson.StationaryRatio.mem_cantorLevel
#print axioms HadwigerNelson.StationaryRatio.cantorLevel_antitone
#print axioms HadwigerNelson.StationaryRatio.exists_cantorLevel_subset
#print axioms HadwigerNelson.StationaryRatio.StationarySet.nb
#print axioms HadwigerNelson.StationaryRatio.StationarySet.pull
#print axioms HadwigerNelson.StationaryRatio.StationarySet.couple
#print axioms HadwigerNelson.StationaryRatio.StationarySet.majority
#print axioms HadwigerNelson.StationaryRatio.StationarySet.parity
#print axioms HadwigerNelson.StationaryRatio.cantorLevel

/-! ## FS-131 wave 10 (job FS131-I10C) — the standing-five field: the leaves of `Arith/StandingFive` -/
-- FS131-I10C
#print axioms HadwigerNelson.StandingFive.g_eta
#print axioms HadwigerNelson.StandingFive.dvd_of_pow_pow_eq
#print axioms HadwigerNelson.StandingFive.fourteen_dvd_of_char_two
#print axioms HadwigerNelson.StandingFive.usableBelow_347
#print axioms HadwigerNelson.StandingFive.card_ge_of_usable
#print axioms HadwigerNelson.StandingFive.card_fixed_of_involution
#print axioms HadwigerNelson.StandingFive.finrank_standingField_le
#print axioms HadwigerNelson.StandingFive.im_eq_zero_of_aeval_gPoly
#print axioms HadwigerNelson.StandingFive.numberField_standingField
#print axioms HadwigerNelson.StandingFive.isTotallyReal_standingField
#print axioms HadwigerNelson.StandingFive.usable_card_ge
#print axioms HadwigerNelson.StandingFive.no_small_usable
#print axioms HadwigerNelson.StandingFive.two_sq_ne_of_isIntegral
#print axioms HadwigerNelson.StandingFive.fourteen_dvd_inertiaDeg
#print axioms HadwigerNelson.StandingFive.two_le_ramificationIdx
#print axioms HadwigerNelson.StandingFive.exists_two_primes
#print axioms HadwigerNelson.StandingFive.dyadic_summary
#print axioms HadwigerNelson.StandingFive.finrank_standingField
#print axioms HadwigerNelson.StandingFive.finrank_E7_and_K
#print axioms HadwigerNelson.StandingFive.minpoly_eta
#print axioms HadwigerNelson.StandingFive.irreducible_gPoly
#print axioms HadwigerNelson.StandingFive.cev_hvec
#print axioms HadwigerNelson.StandingFive.ncard_primes_above_two
#print axioms HadwigerNelson.StandingFive.comap_conj_of_two_mem
#print axioms HadwigerNelson.StandingFive.card_quotient_of_two_mem
#print axioms HadwigerNelson.StandingFive.exists_stablePrime_two
#print axioms HadwigerNelson.StandingFive.exists_conjO_sub_notMem
#print axioms HadwigerNelson.StandingFive.stablePrime_card
#print axioms HadwigerNelson.StandingFive.le_localBound
#print axioms HadwigerNelson.StandingFive.seven_le_localBound
#print axioms HadwigerNelson.StandingFive.five_le_chromaticNumber

/-! ## FS-131 wave 10's first pass (job FS131-L10A) — the landing: the theorems of `Arith/{CharacterColouring, SpectralInputs,
StationaryRatio, StandingFive}` that the planner's and the three implementers' blocks did not list. Read from the kernel's own
list of the library's theorems (`data/fs131/l5/count-modules.lean`), by `tools/fs131_l10a_register.py`; checked by
`tools/fs131_l5_records.py`. -/
-- Arith/CharacterColouring
#print axioms HadwigerNelson.CharacterColouring.coe_inclusion_subring
#print axioms HadwigerNelson.CharacterColouring.coe_smul_unitRing
#print axioms HadwigerNelson.CharacterColouring.exists_mem_torsionBy_of_mem_torsion
#print axioms HadwigerNelson.CharacterColouring.half_one
#print axioms HadwigerNelson.CharacterColouring.mem_archimedean
#print axioms HadwigerNelson.CharacterColouring.mem_torsionBy
#print axioms HadwigerNelson.CharacterColouring.mk1_apply
#print axioms HadwigerNelson.CharacterColouring.torsionBy_le_torsion
#print axioms HadwigerNelson.CharacterColouring.unitRingToFieldI_injective
#print axioms HadwigerNelson.CharacterColouring.unitRing_mono
#print axioms HadwigerNelson.CharacterColouring.unitVectors_mono
-- Arith/SpectralInputs
#print axioms HadwigerNelson.SpectralInputs.abs_clamp_sub_le
#print axioms HadwigerNelson.SpectralInputs.add_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.aestronglyMeasurable_of_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.clamp_zero
#print axioms HadwigerNelson.SpectralInputs.coe_char_sub
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_compLp
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_comp_apply
#print axioms HadwigerNelson.SpectralInputs.compMeasurePreserving_congr
#print axioms HadwigerNelson.SpectralInputs.compl_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.condLaw_le_one
#print axioms HadwigerNelson.SpectralInputs.condLaw_nonneg
#print axioms HadwigerNelson.SpectralInputs.const_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.empty_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.factorSigma_le
#print axioms HadwigerNelson.SpectralInputs.indicatorConstLp_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.indicatorConstLp_mem_contVec_iff
#print axioms HadwigerNelson.SpectralInputs.integrable_colourIndicator
#print axioms HadwigerNelson.SpectralInputs.integrable_evalChar
#print axioms HadwigerNelson.SpectralInputs.integral_evalChar_map_mulRight
#print axioms HadwigerNelson.SpectralInputs.integral_evalChar_zero
#print axioms HadwigerNelson.SpectralInputs.integral_mul_comp_eq_inner
#print axioms HadwigerNelson.SpectralInputs.lipschitzWith_clamp
#print axioms HadwigerNelson.SpectralInputs.measurableSet_condLaw_pos
#print axioms HadwigerNelson.SpectralInputs.measurableSet_condSupport_eq
#print axioms HadwigerNelson.SpectralInputs.measurable_condLaw
#print axioms HadwigerNelson.SpectralInputs.measurable_evalChar
#print axioms HadwigerNelson.SpectralInputs.measurable_mulDual
#print axioms HadwigerNelson.SpectralInputs.measurable_mulRight
#print axioms HadwigerNelson.SpectralInputs.measurable_mul_char
#print axioms HadwigerNelson.SpectralInputs.measurable_of_evalChar
#print axioms HadwigerNelson.SpectralInputs.measure_condLaw_nonpos_inter
#print axioms HadwigerNelson.SpectralInputs.mem_condSupport
#print axioms HadwigerNelson.SpectralInputs.mem_contVec_of_aestronglyMeasurable
#print axioms HadwigerNelson.SpectralInputs.mulDual_apply
#print axioms HadwigerNelson.SpectralInputs.neg_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.norm_comp_indicator_sub
#print axioms HadwigerNelson.SpectralInputs.norm_indicatorConstLp_two
#print axioms HadwigerNelson.SpectralInputs.rot_apply
#print axioms HadwigerNelson.SpectralInputs.rot_comp_mulDual
#print axioms HadwigerNelson.SpectralInputs.rot_mul
#print axioms HadwigerNelson.SpectralInputs.sub_mem_contVec
#print axioms HadwigerNelson.SpectralInputs.tendsto_sqrt_toReal_iff
#print axioms HadwigerNelson.SpectralInputs.union_mem_factorSets
-- Arith/StandingFive
#print axioms HadwigerNelson.StandingFive.E7_le
#print axioms HadwigerNelson.StandingFive.aeval_etaF
#print axioms HadwigerNelson.StandingFive.aeval_etaI
#print axioms HadwigerNelson.StandingFive.aeval_gPoly
#print axioms HadwigerNelson.StandingFive.aeval_gPoly_map
#print axioms HadwigerNelson.StandingFive.aeval_up_etaI
#print axioms HadwigerNelson.StandingFive.anyBelow_of
#print axioms HadwigerNelson.StandingFive.card_quot_eq_two_pow
#print axioms HadwigerNelson.StandingFive.cev_add
#print axioms HadwigerNelson.StandingFive.cev_cconv
#print axioms HadwigerNelson.StandingFive.cev_cdelta
#print axioms HadwigerNelson.StandingFive.chi29_add
#print axioms HadwigerNelson.StandingFive.chi29_eq
#print axioms HadwigerNelson.StandingFive.chi29_zero
#print axioms HadwigerNelson.StandingFive.closure_eq_adjoin
#print axioms HadwigerNelson.StandingFive.conjO_conjO
#print axioms HadwigerNelson.StandingFive.conjO_iO
#print axioms HadwigerNelson.StandingFive.conjO_omO
#print axioms HadwigerNelson.StandingFive.conjO_up
#print axioms HadwigerNelson.StandingFive.conjOn_iL
#print axioms HadwigerNelson.StandingFive.conjOn_toL
#print axioms HadwigerNelson.StandingFive.eta_mem
#print axioms HadwigerNelson.StandingFive.exists_natCast_of_pow_eq
#print axioms HadwigerNelson.StandingFive.exists_root_gPoly_of_sign
#print axioms HadwigerNelson.StandingFive.finrank_closure
#print axioms HadwigerNelson.StandingFive.finrank_fieldI_le
#print axioms HadwigerNelson.StandingFive.finrank_simple_le
#print axioms HadwigerNelson.StandingFive.finrank_standingIF_le
#print axioms HadwigerNelson.StandingFive.gPoly_monic
#print axioms HadwigerNelson.StandingFive.gPoly_natDegree
#print axioms HadwigerNelson.StandingFive.horner1
#print axioms HadwigerNelson.StandingFive.horner2
#print axioms HadwigerNelson.StandingFive.horner3
#print axioms HadwigerNelson.StandingFive.horner4
#print axioms HadwigerNelson.StandingFive.horner5
#print axioms HadwigerNelson.StandingFive.horner6
#print axioms HadwigerNelson.StandingFive.horner7
#print axioms HadwigerNelson.StandingFive.iL_sq
#print axioms HadwigerNelson.StandingFive.iO_sq
#print axioms HadwigerNelson.StandingFive.instFiniteDimensionalStandingIF
#print axioms HadwigerNelson.StandingFive.instNumberFieldStanding
#print axioms HadwigerNelson.StandingFive.isIntegral_eta
#print axioms HadwigerNelson.StandingFive.isIntegral_of_aeval_gPoly
#print axioms HadwigerNelson.StandingFive.isIntegral_of_sq_add
#print axioms HadwigerNelson.StandingFive.isIntegral_sqrt_eleven
#print axioms HadwigerNelson.StandingFive.isIntegral_sqrt_three
#print axioms HadwigerNelson.StandingFive.isTotallyReal_aux
#print axioms HadwigerNelson.StandingFive.liesOver_two
#print axioms HadwigerNelson.StandingFive.mem_primesOver_two_iff
#print axioms HadwigerNelson.StandingFive.mod_four_of_pow
#print axioms HadwigerNelson.StandingFive.omL_rel
#print axioms HadwigerNelson.StandingFive.omO_rel
#print axioms HadwigerNelson.StandingFive.pow_char_eq_of_sq_natCast
#print axioms HadwigerNelson.StandingFive.pow_mod_four_ne
#print axioms HadwigerNelson.StandingFive.pow_natCard
#print axioms HadwigerNelson.StandingFive.s11F_sq
#print axioms HadwigerNelson.StandingFive.s11I_sq
#print axioms HadwigerNelson.StandingFive.s3F_sq
#print axioms HadwigerNelson.StandingFive.s3I_sq
#print axioms HadwigerNelson.StandingFive.span_two_ne_top
#print axioms HadwigerNelson.StandingFive.sq_mod_four_ne
#print axioms HadwigerNelson.StandingFive.sqrt_eleven_mem
#print axioms HadwigerNelson.StandingFive.sqrt_three_mem
#print axioms HadwigerNelson.StandingFive.squaresBelow_11
#print axioms HadwigerNelson.StandingFive.standingField_eq
#print axioms HadwigerNelson.StandingFive.sum_chi29
#print axioms HadwigerNelson.StandingFive.thetaF_rel
#print axioms HadwigerNelson.StandingFive.thetaI_rel
#print axioms HadwigerNelson.StandingFive.toStandingIF_injective
#print axioms HadwigerNelson.StandingFive.twentyeight_le
#print axioms HadwigerNelson.StandingFive.twoZ_ne_bot
#print axioms HadwigerNelson.StandingFive.up_s11I_sq
#print axioms HadwigerNelson.StandingFive.up_s3I_sq
#print axioms HadwigerNelson.StandingFive.up_thetaI_mul


/-! ## FS131-K6 — wave 6 (saturated colourings): the foundation, and the leaves the planner proved (the skeleton's `sorry` leaves are listed by wave 6's implementer as it proves them) -/
#print axioms HadwigerNelson.Plane.AeColouring.isOpen_openPart
#print axioms HadwigerNelson.Plane.AeColouring.openPart_subset_densitySet
#print axioms HadwigerNelson.Plane.sqColA_ne_sqColB
#print axioms HadwigerNelson.Plane.sq9Col_near_edge
#print axioms HadwigerNelson.Plane.sq9_hasTwoDiscsAt
#print axioms HadwigerNelson.Plane.IsMUA.exists_ball_ae_subset
#print axioms HadwigerNelson.Plane.saturated_of_forall_isMUA
#print axioms HadwigerNelson.Plane.AeColouring.saturated_of_idomatic
#print axioms HadwigerNelson.Plane.half_dichotomy
#print axioms HadwigerNelson.Plane.dist_le_one_of_mem_closure
#print axioms HadwigerNelson.Plane.erosion_diam
#print axioms HadwigerNelson.Plane.erosion_diam_cot
#print axioms HadwigerNelson.Plane.essSupport_eq_closure_of_isOpen
#print axioms HadwigerNelson.Plane.bound_iff
#print axioms HadwigerNelson.Plane.gmap_i
#print axioms HadwigerNelson.Plane.gmap_ii
/-! ## FS131-K6b — wave 6's second planning pass: the foundation restated over two sets and a family (the first pass's `TwoColourAt` lines are replaced by these), the fan, and the leaves this pass proved -/
#print axioms HadwigerNelson.Plane.H2On.volume_pos
#print axioms HadwigerNelson.Plane.TwoColourOn.nonempty
#print axioms HadwigerNelson.Plane.TwoColourOn.symm
#print axioms HadwigerNelson.Plane.TwoColourNhd.ne
#print axioms HadwigerNelson.Plane.TwoColourNhd.symm
#print axioms HadwigerNelson.Plane.TwoColourNhd.radius_pos
#print axioms HadwigerNelson.Plane.AeColouring.twoColourNhd_of_h1
#print axioms HadwigerNelson.Plane.interfaceSet_subset_essBdry
#print axioms HadwigerNelson.Plane.disjoint_interfaceSet_singularSet
#print axioms HadwigerNelson.Plane.exists_twoColourNhd_of_mem_interfaceSet
#print axioms HadwigerNelson.Plane.not_isCuspAt_of_mem_interfaceSet
#print axioms HadwigerNelson.Plane.cuspSet_subset_singularSet
#print axioms HadwigerNelson.Plane.Saturated.saturatedOn
#print axioms HadwigerNelson.Plane.saturatedOn_univ
#print axioms HadwigerNelson.Plane.SaturatedOn.mono
#print axioms HadwigerNelson.Plane.hasTwoDiscsAt_comm
#print axioms HadwigerNelson.Plane.isTangentAt_comm
#print axioms HadwigerNelson.Plane.sq9_twoColourNhd
#print axioms HadwigerNelson.Plane.dist_polarPt
#print axioms HadwigerNelson.Plane.polarPt_re
#print axioms HadwigerNelson.Plane.polarPt_im
#print axioms HadwigerNelson.Plane.polarGraph_subset
#print axioms HadwigerNelson.Plane.polarRegion_subset
#print axioms HadwigerNelson.Plane.notMem_essClosure_of_mem_densitySet
#print axioms HadwigerNelson.Plane.AeColouring.twoColourNhd_of_halves
#print axioms HadwigerNelson.Plane.AeColouring.SingLocallyFinite.exists_ball_subset
#print axioms HadwigerNelson.Plane.AeColouring.Fan.branch_subset
#print axioms HadwigerNelson.Plane.AeColouring.Fan.branch_subset_interfaceSet
#print axioms HadwigerNelson.Plane.AeColouring.Fan.φ_lt_cyclicNext
#print axioms HadwigerNelson.Plane.AeColouring.Fan.tendsto_cyclicNext
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dir_le_nextDir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.hasSector_or_hasHorn
#print axioms HadwigerNelson.Plane.sq9Col_near_vertex
#print axioms HadwigerNelson.Plane.sq9_essClosure_of_quad
#print axioms HadwigerNelson.Plane.sq9_essSupport_near_vertex
#print axioms HadwigerNelson.Plane.sq9_not_isCuspAt_near_vertex
#print axioms HadwigerNelson.Plane.sq9_mem_essBdry_of_re
#print axioms HadwigerNelson.Plane.sq9_mem_essBdry_of_im
#print axioms HadwigerNelson.Plane.sq9_axis_of_mem_essBdry
#print axioms HadwigerNelson.Plane.sq9_twoColourNhd_of_re
#print axioms HadwigerNelson.Plane.sq9_twoColourNhd_of_im
#print axioms HadwigerNelson.Plane.sq9_singular_near_vertex
#print axioms HadwigerNelson.Plane.sqVertex_mem_singularSet
#print axioms HadwigerNelson.Plane.sq9_bdry_near_vertex
#print axioms HadwigerNelson.Plane.sq9_region_near_vertex
#print axioms HadwigerNelson.Plane.sq9Fan
#print axioms HadwigerNelson.Plane.sq9Fan_dir_lt_nextDir
#print axioms HadwigerNelson.Plane.sq9Fan_hasSector
#print axioms HadwigerNelson.Plane.sq9Fan_not_hasHorn
#print axioms HadwigerNelson.Plane.isUnitCurve_segment
#print axioms HadwigerNelson.Plane.IsUnitCurve.mono
#print axioms HadwigerNelson.Plane.norm_sub_le_of_discs
#print axioms HadwigerNelson.Plane.sq9_isolatedAt
/-! ## FS131-I6C — wave 6's bridge, line C: the leaves of `Plane/Saturated/Curve` (unit-speed curves with 1-Lipschitz tangent angle), then of `Plane/Saturated/LocalGraph`, with the implementer's children -/
#print axioms HadwigerNelson.Plane.IsUnitCurve.hasDerivWithinAt_re_mul
#print axioms HadwigerNelson.Plane.IsUnitCurve.hasDerivWithinAt_norm_sq
#print axioms HadwigerNelson.Plane.IsUnitCurve.abs_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_add_sin_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.chord
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_le_inner
#print axioms HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist
#print axioms HadwigerNelson.Plane.IsUnitCurve.norm_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.one_le_dist_of_sign
#print axioms HadwigerNelson.Plane.IsUnitCurve.one_le_dist
#print axioms HadwigerNelson.Plane.isUnitCurve_circle
#print axioms HadwigerNelson.Plane.two_sin_le_norm_e_sub_e
#print axioms HadwigerNelson.Plane.lt_mul_of_two_sin_le
#print axioms HadwigerNelson.Plane.le_add_of_chord
#print axioms HadwigerNelson.Plane.lipschitzOnWith_of_chord
#print axioms HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist_of_le_pi
#print axioms HadwigerNelson.Plane.AeColouring.notMem_essBdry_of_mem_densitySet
#print axioms HadwigerNelson.Plane.AeColouring.exists_densitySet_of_notMem
#print axioms HadwigerNelson.Plane.AeColouring.isOpen_setOf_forall_notMem_essSupport
#print axioms HadwigerNelson.Plane.AeColouring.mem_densitySet_of_forall_notMem_essSupport
#print axioms HadwigerNelson.Plane.AeColouring.ae_one_colour_of_isConnected
#print axioms HadwigerNelson.Plane.AeColouring.closure_essBdry_subset
#print axioms HadwigerNelson.Plane.lens_ineq_real
#print axioms HadwigerNelson.Plane.lens_point_real
#print axioms HadwigerNelson.Plane.exists_lens_point_far
#print axioms HadwigerNelson.Plane.exists_lens_point
#print axioms HadwigerNelson.Plane.TwoColourOn.false_of_mem_inter
#print axioms HadwigerNelson.Plane.TwoColourOn.notMem_essClosure_of_mem_densitySet
#print axioms HadwigerNelson.Plane.TwoColourOn.mem_interior_densitySet_of_notMem
#print axioms HadwigerNelson.Plane.TwoColourOn.mem_interior_densitySet_or
#print axioms HadwigerNelson.Plane.exists_arclength_inverse
#print axioms HadwigerNelson.Plane.hasDerivAt_of_sq_bound
#print axioms HadwigerNelson.Plane.abs_le_of_two_disc_bound
#print axioms HadwigerNelson.Plane.hasDerivAt_of_two_disc_bound
#print axioms HadwigerNelson.Plane.abs_inner_le_of_one_le
#print axioms HadwigerNelson.Plane.im_ge_of_norm_sub_I_le
#print axioms HadwigerNelson.Plane.e_neg_arcsin_re
#print axioms HadwigerNelson.Plane.exists_unit_curve_of_two_discs
#print axioms HadwigerNelson.Plane.isConnected_graph_side
#print axioms HadwigerNelson.Plane.interior_densitySet_inter_ae_le
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.subset_interior_densitySet
#print axioms HadwigerNelson.Plane.TwoColourOn.exists_mem_essBoundary_of_continuous
#print axioms HadwigerNelson.Plane.TwoColourOn.ae_le_of_isPreconnected
#print axioms HadwigerNelson.Plane.sq9_not_isCuspAt_near_edge
#print axioms HadwigerNelson.Plane.sqEdgePt_mem_essBoundary
-- entered at the join (FS131-L6A): proved over `Pinch`'s `c11_discs` and `TwoColourOn.essBoundary_inter_eq`
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.one_le_norm_sub
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.norm_sub_le
#print axioms HadwigerNelson.Plane.HasTwoDiscsAt.normal_unique
#print axioms HadwigerNelson.Plane.local_graph
#print axioms HadwigerNelson.Plane.AeColouring.local_graph
#print axioms HadwigerNelson.Plane.sq9_exists_isInterfaceChart
/-! ## FS131-I6E — wave 6's bridge: what every fan carries (`Plane/Saturated/FanBridge`, the five `Fan` lemmas) — the two leaves that read no saturation (`Fan.two_le_n`, `Fan.col_ne`) and the children of the five that rest on no open leaf of another line; the fourteen records proved over `gamma`, `IsUnitCurve.exists_polarGraph` and `Pinch`'s leaves are the block's last section, entered at the join (FS131-L6A) -/
#print axioms HadwigerNelson.Plane.AeColouring.Fan.two_le_n
#print axioms HadwigerNelson.Plane.AeColouring.Fan.col_ne
#print axioms HadwigerNelson.Plane.AeColouring.Fan.col_ne_aux
#print axioms HadwigerNelson.Plane.fanAngle
#print axioms HadwigerNelson.Plane.polarPt_dist_fanAngle
#print axioms HadwigerNelson.Plane.fanAngle_polarPt
#print axioms HadwigerNelson.Plane.continuousAt_fanAngle
#print axioms HadwigerNelson.Plane.image_polarPt_mem_nhds
#print axioms HadwigerNelson.Plane.isOpen_setOf_polar_lt
#print axioms HadwigerNelson.Plane.polarRegion_eq_image
#print axioms HadwigerNelson.Plane.polarPt_add_two_pi
#print axioms HadwigerNelson.Plane.polarRegion_mono
#print axioms HadwigerNelson.Plane.mem_closure_polarRegion
#print axioms HadwigerNelson.Plane.volume_essBoundary
#print axioms HadwigerNelson.Plane.AeColouring.volume_essBdry
#print axioms HadwigerNelson.Plane.isConnected_ball_diff_singleton
#print axioms HadwigerNelson.Plane.AeColouring.Fan.continuousOn_cyclicNext
#print axioms HadwigerNelson.Plane.AeColouring.Fan.isOpen_cell
#print axioms HadwigerNelson.Plane.AeColouring.Fan.isPreconnected_polarRegion_of_le
#print axioms HadwigerNelson.Plane.AeColouring.Fan.isPreconnected_cell
#print axioms HadwigerNelson.Plane.AeColouring.Fan.cell_subset_densitySet
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_ray_subset_cell
#print axioms HadwigerNelson.Plane.AeColouring.Fan.mem_closure_polarRegion_of_le
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_lower_of_pred
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_isOpen_subset_cells
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_isOpen_ae_two_colours
#print axioms HadwigerNelson.Plane.IsUnitCurve.reverse
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_add
#print axioms HadwigerNelson.Plane.re_e_mul_conj_I_mul_e
#print axioms HadwigerNelson.Plane.re_e_mul_conj_e_eq_cos
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_add_I
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_sub_I
#print axioms HadwigerNelson.Plane.eq_I_mul_or_eq_neg_of_re_eq_zero
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_polarPt_add_I
#print axioms HadwigerNelson.Plane.eventually_dist_polarPt_lt_one
#print axioms HadwigerNelson.Plane.AeColouring.eq_or_eq_of_mem_essClosure
#print axioms HadwigerNelson.Plane.AeColouring.Fan.eq_add_or_eq_sub_of_dist_eq_one
#print axioms HadwigerNelson.Plane.false_of_inside_of_outside
#print axioms HadwigerNelson.Plane.in_in_or_out_out
#print axioms HadwigerNelson.Plane.add_ofReal_one_mul
#print axioms HadwigerNelson.Plane.add_ofReal_neg_one_mul
#print axioms HadwigerNelson.Plane.dist_sq_polarPt_add_sign
#print axioms HadwigerNelson.Plane.two_mul_sin_le_of_one_le_dist
#print axioms HadwigerNelson.Plane.le_two_mul_sin_of_dist_le_one
#print axioms HadwigerNelson.Plane.eventually_sin_add_mul_gt
#print axioms HadwigerNelson.Plane.horn_of_sin_constraints
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dir_mono
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dir_le_dir_add_two_pi
#print axioms HadwigerNelson.Plane.AeColouring.Fan.nextDir_le_dir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.nextDir_le_dir_add_two_pi
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_pred_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_succ_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_side
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_side_next
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_side_dir
-- entered at the join (FS131-L6A): proved over `gamma`, `IsUnitCurve.exists_polarGraph` and `Pinch`'s leaves
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_unitCurve_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_twoColourNhd_branch
#print axioms HadwigerNelson.Plane.AeColouring.Fan.dist_eq_one_of_common_contact
#print axioms HadwigerNelson.Plane.AeColouring.Fan.contacts_of_no_common
#print axioms HadwigerNelson.Plane.AeColouring.Fan.branch_outside_discs
#print axioms HadwigerNelson.Plane.AeColouring.Fan.branch_contacts
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_contact_nextDir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.exists_contact_dir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_constraints
#print axioms HadwigerNelson.Plane.AeColouring.Fan.horn_false
#print axioms HadwigerNelson.Plane.AeColouring.Fan.false_of_horn_next
#print axioms HadwigerNelson.Plane.AeColouring.Fan.false_of_horn_dir
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_alone
#print axioms HadwigerNelson.Plane.AeColouring.Fan.sector_unique
/-! ## FS131-I6D — wave 6, the bridge's existence half: the curve lemmas, the continuation, GAMMA, BETA, ALPHA (re-read at the join, FS131-L6A: nothing beneath them is open) -/
#print axioms HadwigerNelson.Plane.IsUnitCurve.affine
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_abs_le_dist
#print axioms HadwigerNelson.Plane.IsUnitCurve.dist_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.injOn_of_abs_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.abs_sub_lt_of_dist_lt_one
#print axioms HadwigerNelson.Plane.isUnitCurve_angleCurve
#print axioms HadwigerNelson.Plane.IsUnitCurve.eqOn_angleCurve
#print axioms HadwigerNelson.Plane.eq_affine_of_sin_bounds
#print axioms HadwigerNelson.Plane.IsUnitCurve.reparam
#print axioms HadwigerNelson.Plane.IsUnitCurve.exists_polar_angle
#print axioms HadwigerNelson.Plane.IsArcOf.eqOn
#print axioms HadwigerNelson.Plane.ArcSetting.exists_max_arc
#print axioms HadwigerNelson.Plane.IsArcOf.left_end_notMem
#print axioms HadwigerNelson.Plane.IsArcOf.right_end_notMem
#print axioms HadwigerNelson.Plane.ArcSetting.exists_component_arc
#print axioms HadwigerNelson.Plane.AeColouring.arcSetting_of_isolated
#print axioms HadwigerNelson.Plane.AeColouring.exists_arc_of_isolated
#print axioms HadwigerNelson.Plane.AeColouring.exists_polarGraph_of_isolated
#print axioms HadwigerNelson.Plane.AeColouring.finite_components_of_isolated
#print axioms HadwigerNelson.Plane.AeColouring.gamma
#print axioms HadwigerNelson.Plane.IsUnitCurve.exists_polarGraph
#print axioms HadwigerNelson.Plane.AeColouring.beta
#print axioms HadwigerNelson.Plane.AeColouring.alpha
#print axioms HadwigerNelson.Plane.isOpen_polarRegion
#print axioms HadwigerNelson.Plane.isPreconnected_polarRegion
#print axioms HadwigerNelson.Plane.exists_ordered_lifts
#print axioms HadwigerNelson.Plane.polarRegion_disjoint_polarGraph
#print axioms HadwigerNelson.Plane.AeColouring.exists_fan_of_isolated
#print axioms HadwigerNelson.Plane.AeColouring.Fan.finite_arcs_meeting_ball
#print axioms HadwigerNelson.Plane.AeColouring.regJLiteral_of_locallyFinite
#print axioms HadwigerNelson.Plane.AeColouring.finite_arcs_of_bounded
#print axioms HadwigerNelson.Plane.AeColouring.fan_of_isolated
#print axioms HadwigerNelson.Plane.AeColouring.regJFan_of_saturated
#print axioms HadwigerNelson.Plane.AeColouring.regJLiteral_of_saturated
#print axioms HadwigerNelson.Plane.AeColouring.finite_arcs_of_isBounded
#print axioms HadwigerNelson.Plane.sq9_not_isCuspAt
#print axioms HadwigerNelson.Plane.sq9_twoColourNhd_of_re_grid
#print axioms HadwigerNelson.Plane.sq9_twoColourNhd_of_im_grid
#print axioms HadwigerNelson.Plane.sq9_singularSet_subset_grid
#print axioms HadwigerNelson.Plane.sq9_singLocallyFinite
#print axioms HadwigerNelson.Plane.sq9_regJFan
/-! ## FS131-I6A — wave 6, `Plane/Saturated/Pinch`: the leaves the first implementer proved, and its helpers -/
#print axioms HadwigerNelson.Plane.norm_sq_mul_sub_of_norm_eq_one
#print axioms HadwigerNelson.Plane.dist_add_mul_lt_one
#print axioms HadwigerNelson.Plane.one_lt_dist_add_mul
#print axioms HadwigerNelson.Plane.exists_add_mul_mem_of_isOpen
#print axioms HadwigerNelson.Plane.real_inner_lt_one_of_ne
#print axioms HadwigerNelson.Plane.neg_one_lt_real_inner_of_ne_neg
#print axioms HadwigerNelson.Plane.subset_of_isOpen_ae_le_isClosed
#print axioms HadwigerNelson.Plane.pinch_not_in_in
#print axioms HadwigerNelson.Plane.isSplitAt_of_in_out
#print axioms HadwigerNelson.Plane.hasTwoDiscsAt_of_out_out
#print axioms HadwigerNelson.Plane.pinch
#print axioms HadwigerNelson.Plane.densityRatio_add_of_cover
#print axioms HadwigerNelson.Plane.TwoColourOn.essBoundary_inter_subset
#print axioms HadwigerNelson.Plane.TwoColourOn.essBoundary_inter_eq
#print axioms HadwigerNelson.Plane.IsSplitAt.hasTwoDiscsAt
#print axioms HadwigerNelson.Plane.c11_discs
#print axioms HadwigerNelson.Plane.densityRatio_eventuallyEq_of_ae_eq_inter
#print axioms HadwigerNelson.Plane.essBoundary_inter_congr
#print axioms HadwigerNelson.Plane.mem_essBoundary_of_balls
#print axioms HadwigerNelson.Plane.exists_ball_subset_ball_of_mem_sphere
#print axioms HadwigerNelson.Plane.exists_ball_subset_compl_closedBall_of_mem_sphere
#print axioms HadwigerNelson.Plane.essBoundary_ball_one
#print axioms HadwigerNelson.Plane.essBoundary_compl_closedBall_one
#print axioms HadwigerNelson.Plane.c11_split
#print axioms HadwigerNelson.Plane.half_sq_norm_le_inner_of_mem_closedBall
#print axioms HadwigerNelson.Plane.inner_le_half_sq_norm_of_notMem_ball
#print axioms HadwigerNelson.Plane.volume_halfPlane_inter_closedBall_le
#print axioms HadwigerNelson.Plane.volume_shifted_halfPlane_inter_closedBall_le
#print axioms HadwigerNelson.Plane.densityRatio_le_of_subset_halfPlane
#print axioms HadwigerNelson.Plane.tendsto_ofReal_one_add_sq_div_two
#print axioms HadwigerNelson.Plane.half_upperDensity
#print axioms HadwigerNelson.Plane.sq9_isTangentAt
#print axioms HadwigerNelson.Plane.dist_sqEdgePt_add_one
#print axioms HadwigerNelson.Plane.isSplitAt_ball_compl_closedBall
#print axioms HadwigerNelson.Plane.pinch_interface
#print axioms HadwigerNelson.Plane.c11_discs_interface
#print axioms HadwigerNelson.Plane.TwoColourNhd.mem_essBoundary
/-! ## FS131-I6B — wave 6: `MapColouring`'s leaf `sat_inP` (FS121-C1-SAT) with its helpers (`Plane/Saturated/MapEdge`) and its model (`Plane/Saturated/Sq9Map`) -/
#print axioms HadwigerNelson.Plane.MapEdge.densityRatio_congr_ae
#print axioms HadwigerNelson.Plane.MapEdge.essBoundary_congr_ae
#print axioms HadwigerNelson.Plane.MapEdge.essSupport_congr_ae
#print axioms HadwigerNelson.Plane.MapEdge.notMem_densitySet_of_disjoint
#print axioms HadwigerNelson.Plane.MapEdge.mem_ball_iff_sq
#print axioms HadwigerNelson.Plane.MapEdge.push_real
#print axioms HadwigerNelson.Plane.MapEdge.convex_halfDisc
#print axioms HadwigerNelson.Plane.MapEdge.isPreconnected_puncturedBall
#print axioms HadwigerNelson.Plane.mem_curveAt_iff_curveSide
#print axioms HadwigerNelson.Plane.curveSide_eq
#print axioms HadwigerNelson.Plane.curveSide_rebase
#print axioms HadwigerNelson.Plane.normSq_rebase
#print axioms HadwigerNelson.Plane.continuous_curveSide
#print axioms HadwigerNelson.Plane.convex_curveSide_neg
#print axioms HadwigerNelson.Plane.exists_segment_curveSide_pos
#print axioms HadwigerNelson.Plane.isPreconnected_curveSide_pos
#print axioms HadwigerNelson.Plane.isPreconnected_curveSide_neg
#print axioms HadwigerNelson.Plane.curveSide_neg_of_mem_ball
#print axioms HadwigerNelson.Plane.curveSide_pos_of_mem_ball
#print axioms HadwigerNelson.Plane.ArcMap.subset_region_of_isPreconnected
#print axioms HadwigerNelson.Plane.ArcMap.isOpen_interiorPts_diff_region
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_region
#print axioms HadwigerNelson.Plane.ArcMap.mem_essBoundary_region_of_curve
#print axioms HadwigerNelson.Plane.ArcMap.exists_mem_essBoundary_region
#print axioms HadwigerNelson.Plane.mem_sq9Arcs
#print axioms HadwigerNelson.Plane.mem_sq9_bottom
#print axioms HadwigerNelson.Plane.mem_sq9_left
#print axioms HadwigerNelson.Plane.mem_sq9Grid_iff
#print axioms HadwigerNelson.Plane.sq9Arcs_nondegenerate
#print axioms HadwigerNelson.Plane.sq9Arcs_locallyFinite
#print axioms HadwigerNelson.Plane.sq9Col_locallyConstant
#print axioms HadwigerNelson.Plane.sq9Map_isPlaneMap
#print axioms HadwigerNelson.Plane.mem_sq9Map_interiorPts
#print axioms HadwigerNelson.Plane.volume_sq9Grid
#print axioms HadwigerNelson.Plane.sq9Map_region_ae
#print axioms HadwigerNelson.Plane.sqEdge_mem_interiorPts
#print axioms HadwigerNelson.Plane.sqEdge_left_subset_region
#print axioms HadwigerNelson.Plane.sqEdge_right_subset_region
#print axioms HadwigerNelson.Plane.sqEdgePt_mem_closure_regions
#print axioms HadwigerNelson.Plane.sqEdge_ball_subset_closure_regions
#print axioms HadwigerNelson.Plane.ArcMap.bound_of_saturatedOn
#print axioms HadwigerNelson.Plane.sat_bound_of_mem_closure
#print axioms HadwigerNelson.Plane.sat_inP
#print axioms HadwigerNelson.Plane.sat_noPar
#print axioms HadwigerNelson.Plane.sq9Map_separatesAt
#print axioms HadwigerNelson.Plane.sq9Map_sat_model
/-! ## FS131-L6A — wave 6's first landing: the theorems of `Plane/Saturated/*` that the planners' and the five implementers'
blocks did not list. Read from the kernel's own list of the library's theorems (`data/fs131/l5/count-modules.lean`), by
`tools/fs131_l6a_register.py`; checked by `tools/fs131_l5_records.py`. -/
-- Plane/Saturated/ArcContinuation
#print axioms HadwigerNelson.Plane.ArcSetting.chart_abs_le
#print axioms HadwigerNelson.Plane.ArcSetting.exists_arc
#print axioms HadwigerNelson.Plane.ArcSetting.exists_reparam
#print axioms HadwigerNelson.Plane.HasArcChart.mem
#print axioms HadwigerNelson.Plane.IsArcOf.abs_sub_lt
#print axioms HadwigerNelson.Plane.IsArcOf.bounds
#print axioms HadwigerNelson.Plane.IsArcOf.length_le
#print axioms HadwigerNelson.Plane.IsArcOf.mem
#print axioms HadwigerNelson.Plane.IsArcOf.reverse
#print axioms HadwigerNelson.Plane.IsUnitCurve.angle_of_reparam
#print axioms HadwigerNelson.Plane.exists_Icc_subset_of_mem_nhds
-- Plane/Saturated/Basic
#print axioms HadwigerNelson.Plane.dist_sqEdgePt
#print axioms HadwigerNelson.Plane.sq9_h2_of_side
#print axioms HadwigerNelson.Plane.sqEdgePt_mem_ball
#print axioms HadwigerNelson.Plane.sqEdgePt_mem_closure_half
#print axioms HadwigerNelson.Plane.sqEdge_coords
#print axioms HadwigerNelson.Plane.sqEdge_side_of_disc
#print axioms HadwigerNelson.Plane.volume_sqEdge_line
-- Plane/Saturated/CurveArc
#print axioms HadwigerNelson.Plane.IsUnitCurve.abs_angle_sub_le
#print axioms HadwigerNelson.Plane.IsUnitCurve.continuousOn
#print axioms HadwigerNelson.Plane.IsUnitCurve.sin_le_dist
#print axioms HadwigerNelson.Plane.angleCurve_zero
#print axioms HadwigerNelson.Plane.eq_add_of_sin_bounds
#print axioms HadwigerNelson.Plane.hasDerivAt_angleCurve
-- Plane/Saturated/Fan
#print axioms HadwigerNelson.Plane.AeColouring.RegJFan.singLocallyFinite
#print axioms HadwigerNelson.Plane.AeColouring.RegJLiteral.singLocallyFinite
#print axioms HadwigerNelson.Plane.cyclicNext_of_lt
#print axioms HadwigerNelson.Plane.cyclicNext_of_not_lt
-- Plane/Saturated/FanArcs
#print axioms HadwigerNelson.Plane.AeColouring.hasArcChart
#print axioms HadwigerNelson.Plane.AeColouring.polarGraph_of_curve_from_center
#print axioms HadwigerNelson.Plane.ArcSetting.exists_open_subset_component
#print axioms HadwigerNelson.Plane.eq_or_mem_sphere_of_notMem
-- Plane/Saturated/FanBridge
#print axioms HadwigerNelson.Plane.AeColouring.regJFan_iff_singLocallyFinite
-- Plane/Saturated/FanBuild
#print axioms HadwigerNelson.Plane.isPreconnected_polarGraph
#print axioms HadwigerNelson.Plane.polarGraph_sub_int
#print axioms HadwigerNelson.Plane.polarPt_add_int
#print axioms HadwigerNelson.Plane.polarPt_eq_polarPt
#print axioms HadwigerNelson.Plane.polarPt_norm_arg
#print axioms HadwigerNelson.Plane.polarRegion_nonempty
-- Plane/Saturated/FanExamples
#print axioms HadwigerNelson.Plane.abs_re_im_sub_lt_of_mem_ball
#print axioms HadwigerNelson.Plane.cos_sin_quarter_turn
#print axioms HadwigerNelson.Plane.cyclicNext_sq9Fanφ
#print axioms HadwigerNelson.Plane.isClosed_sq9Sq
#print axioms HadwigerNelson.Plane.sq9_essSupport_subset_sq
#print axioms HadwigerNelson.Plane.sq9_mem_essBdry_of_quads
#print axioms HadwigerNelson.Plane.sq9_polarGraph_eq
#print axioms HadwigerNelson.Plane.sq9_pred_ne
#print axioms HadwigerNelson.Plane.sqQuad_inj
#print axioms HadwigerNelson.Plane.sqSg_decide_mul_nonneg
#print axioms HadwigerNelson.Plane.sqVertex_coords
#print axioms HadwigerNelson.Plane.volume_sqVertex_hline
#print axioms HadwigerNelson.Plane.volume_sqVertex_vline


/-! ## FS-131 wave 10 (job FS131-K10b) — the second planning pass: the ratio bound, the factor action, the floors' certificate -/
-- FS131-K10b (sorry-free declarations only; the compositions over open leaves are left for the landing's audit)
#print axioms HadwigerNelson.SpectralInputs.comap_factorSigma_eq
#print axioms HadwigerNelson.SpectralInputs.comap_factorSigma_eq_of_action
#print axioms HadwigerNelson.SpectralInputs.si4_equivariant_factorSigma
#print axioms HadwigerNelson.SpectralInputs.preimage_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.comap_factorSigma_le
#print axioms HadwigerNelson.RatioBound.sum_fourier_sq_mul_charSum_eq_zero
#print axioms HadwigerNelson.RatioBound.sum_fourier_sq
#print axioms HadwigerNelson.RatioBound.card_mul_le_of_indep
#print axioms HadwigerNelson.RatioBound.le_chromaticNumber_of_charSum
#print axioms HadwigerNelson.StandingFive.kloostermanBound_of_card_le_five
#print axioms HadwigerNelson.StandingFive.targetFloor_mono
#print axioms HadwigerNelson.StandingFive.standingFloor_mono
#print axioms HadwigerNelson.Floor128.clmul_P_qBig
#print axioms HadwigerNelson.Floor128.bezout4
#print axioms HadwigerNelson.Floor128.bezout128
#print axioms HadwigerNelson.Floor128.order_checks
#print axioms HadwigerNelson.Floor128.counts_ok
#print axioms HadwigerNelson.GapSeven.gamma_proper
#print axioms HadwigerNelson.GapSeven.gapped_iff
#print axioms HadwigerNelson.GapSeven.gapped_eq_three
#print axioms HadwigerNelson.GapSeven.zbar_iff
#print axioms HadwigerNelson.GapSeven.zbar_indep
#print axioms HadwigerNelson.GapSeven.supp_disjoint
#print axioms HadwigerNelson.GapSeven.exists_adjacent_gapped
#print axioms HadwigerNelson.GapSeven.card_edges
/-! ## FS-131 wave 10 (job FS131-I10D) — the planes' floor: the norm-one target, and the completion of a circle sum to a Kloosterman sum -/
-- FS131-I10D
#print axioms HadwigerNelson.StandingFive.involution_eq_pow
#print axioms HadwigerNelson.StandingFive.card_filter_pow_eq_one
#print axioms HadwigerNelson.StandingFive.card_normOne
#print axioms HadwigerNelson.StandingFive.targetFloor_of_charSum
#print axioms HadwigerNelson.StandingFive.sum_addChar_mul_left
#print axioms HadwigerNelson.StandingFive.sum_eq_zero_add_sum_units
#print axioms HadwigerNelson.StandingFive.sum_units_addChar_mul
#print axioms HadwigerNelson.StandingFive.sum_addChar_mul_sq
#print axioms HadwigerNelson.StandingFive.sum_quadratic_eq
#print axioms HadwigerNelson.StandingFive.sum_plane_quadratic
#print axioms HadwigerNelson.StandingFive.circle_sum_eq_kloosterman
#print axioms HadwigerNelson.StandingFive.circle_sum_le_of_ne
#print axioms HadwigerNelson.StandingFive.circle_sum_le
#print axioms HadwigerNelson.StandingFive.circle_sum_zero_of_isotropic
#print axioms HadwigerNelson.StandingFive.two_sqrt_lt_circle_sum_zero
#print axioms HadwigerNelson.StandingFive.exists_ringHom_pow
#print axioms HadwigerNelson.StandingFive.card_filter_pow_eq_self
#print axioms HadwigerNelson.StandingFive.exists_mulShift_eq
#print axioms HadwigerNelson.StandingFive.normOne_charSum_ge
#print axioms HadwigerNelson.StandingFive.targetFloor_seven_of_kloosterman
/-! ## FS-131 wave 10 (job FS131-I10E) — the floor at 128: the bridge from the certificate to the character sums of the norm-one target -/
-- FS131-I10E (`Floor128`: the bridge's helpers, the leaf `charSum_128_ge`, and the two floors proved over it)
#print axioms HadwigerNelson.Floor128.ev_zero
#print axioms HadwigerNelson.Floor128.ev_eq
#print axioms HadwigerNelson.Floor128.ev_one
#print axioms HadwigerNelson.Floor128.ev_two_mul
#print axioms HadwigerNelson.Floor128.ev_shiftLeft_one
#print axioms HadwigerNelson.Floor128.ev_two_pow
#print axioms HadwigerNelson.Floor128.ev_two
#print axioms HadwigerNelson.Floor128.map_ev
#print axioms HadwigerNelson.Floor128.coeff_ev_X
#print axioms HadwigerNelson.Floor128.ev_xor
#print axioms HadwigerNelson.Floor128.ev_clmul
#print axioms HadwigerNelson.Floor128.ev_step
#print axioms HadwigerNelson.Floor128.ev_iterate_step
#print axioms HadwigerNelson.Floor128.qBig_lt
#print axioms HadwigerNelson.Floor128.qBig_testBit_one
#print axioms HadwigerNelson.Floor128.charP_two
#print axioms HadwigerNelson.Floor128.exists_root
#print axioms HadwigerNelson.Floor128.step_lt
#print axioms HadwigerNelson.Floor128.step_ne_zero
#print axioms HadwigerNelson.Floor128.pass_fst
#print axioms HadwigerNelson.Floor128.pass_snd
#print axioms HadwigerNelson.Floor128.iterate_step_lt
#print axioms HadwigerNelson.Floor128.iterate_step_ne_zero
#print axioms HadwigerNelson.Floor128.iterate_step_period
#print axioms HadwigerNelson.Floor128.eq_of_dvd_of_not_dvd
#print axioms HadwigerNelson.Floor128.minimalPeriod_step
#print axioms HadwigerNelson.Floor128.iterate_step_injOn
#print axioms HadwigerNelson.Floor128.exists_iterate_step_eq
#print axioms HadwigerNelson.Floor128.digit_sum
#print axioms HadwigerNelson.Floor128.sum_range_mul_eq
#print axioms HadwigerNelson.Floor128.pass_class
#print axioms HadwigerNelson.Floor128.class_le
#print axioms HadwigerNelson.Floor128.root_pow_eq_one
#print axioms HadwigerNelson.Floor128.ev_ne_zero
#print axioms HadwigerNelson.Floor128.ev_inj
#print axioms HadwigerNelson.Floor128.root_pow_inj
#print axioms HadwigerNelson.Floor128.exists_code
#print axioms HadwigerNelson.Floor128.exists_root_pow_eq
#print axioms HadwigerNelson.Floor128.normOne_eq_image
#print axioms HadwigerNelson.Floor128.exists_addChar
#print axioms HadwigerNelson.Floor128.charSum_128_ge
#print axioms HadwigerNelson.Floor128.targetFloor_eight_128
#print axioms HadwigerNelson.Floor128.targetFloor_seven_128
/-! ## FS-131 wave 10 (job FS131-I10F) — the second pass's three measure-theoretic files: the majority vote, the product's factor, the `NegCircle` model -/
-- FS131-I10F (sorry-free declarations only)
#print axioms HadwigerNelson.MajorityVote.eq_of_lt_two_mul_card_filter
#print axioms HadwigerNelson.MajorityVote.lt_two_mul_card_filter_of_bad
#print axioms HadwigerNelson.MajorityVote.measure_half_le_sum_indicator_le
#print axioms HadwigerNelson.MajorityVote.measurableSet_lt_two_mul_card_filter
#print axioms HadwigerNelson.MajorityVote.exists_measurable_selector
#print axioms HadwigerNelson.MajorityVote.ae_eq_measurable_of_majority
#print axioms HadwigerNelson.SpectralInputs.mem_factorSets_of_ae_eq
#print axioms HadwigerNelson.SpectralInputs.measureReal_prod_eq_integral_section
#print axioms HadwigerNelson.SpectralInputs.measurable_measureReal_section
#print axioms HadwigerNelson.SpectralInputs.integrable_measureReal_section
#print axioms HadwigerNelson.SpectralInputs.integrable_section_var
#print axioms HadwigerNelson.SpectralInputs.measureReal_mul_one_sub_le_symmDiff
#print axioms HadwigerNelson.SpectralInputs.integral_section_var_le_add
#print axioms HadwigerNelson.SpectralInputs.exists_fst_preimage_of_integral_section_var_eq_zero
#print axioms HadwigerNelson.SpectralInputs.measurable_cylMap
#print axioms HadwigerNelson.SpectralInputs.exists_cyl_of_subset
#print axioms HadwigerNelson.SpectralInputs.univ_mem_cylSets
#print axioms HadwigerNelson.SpectralInputs.isSetRing_cylSets
#print axioms HadwigerNelson.SpectralInputs.generateFrom_cylSets
#print axioms HadwigerNelson.SpectralInputs.integral_section_var_le_symmDiff_shift
#print axioms HadwigerNelson.SpectralInputs.exists_fst_preimage_ae_eq_of_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.fibre_mem_factorSets
#print axioms HadwigerNelson.SpectralInputs.exists_measurableSet_prodFactorSigma_ae_eq
#print axioms HadwigerNelson.SpectralInputs.contVec_prod_eq
#print axioms HadwigerNelson.SpectralInputs.two_dvd_of_sq_add_sq_eq_four_mul
#print axioms HadwigerNelson.SpectralInputs.re_im_of_mul_intCast_eq
#print axioms HadwigerNelson.SpectralInputs.exists_odd_rep_of_unitVector
#print axioms HadwigerNelson.SpectralInputs.exists_odd_rep_of_mem_unitRing
#print axioms HadwigerNelson.SpectralInputs.intCast_zmod_two_of_odd
#print axioms HadwigerNelson.SpectralInputs.parity_rep_unique
#print axioms HadwigerNelson.SpectralInputs.exists_parityHom
#print axioms HadwigerNelson.SpectralInputs.exists_signChar
#print axioms HadwigerNelson.SpectralInputs.negCircle_trivial_bot
#print axioms HadwigerNelson.SpectralInputs.countable_bot_subfield_real
#print axioms HadwigerNelson.SpectralInputs.sp_if_hypotheses_trivial_bot
#print axioms HadwigerNelson.SpectralInputs.measurePreserving_shift_infinitePi
#print axioms HadwigerNelson.SpectralInputs.contVec_prod_eq_coin
/-! ## FS-131 wave 10 (job FS131-K10c) — the third planning pass: around the import (the page's form against `KloostermanBound`, the model), no axiom -/
-- FS131-K10c
#print axioms HadwigerNelson.StandingFive.sum_units_eq_sum_ne_zero
#print axioms HadwigerNelson.StandingFive.four_mul_mul_ne_zero_iff
#print axioms HadwigerNelson.StandingFive.kloosterman_page_of_kloostermanBound
#print axioms HadwigerNelson.StandingFive.kloosterman_bound_model
#print axioms HadwigerNelson.StandingFive.ringChar_ne_two_of_card_mod_four
#print axioms HadwigerNelson.StandingFive.targetFloor_six_of_kloosterman
/-! ## FS-131 wave 10's second landing (job FS131-L10B) — the theorems of the wave's eleven new modules that the planners' and
the implementers' blocks did not list. Read from the kernel's own list of the library's theorems
(`data/fs131/l5/count-modules.lean`), by `tools/fs131_l10b_register.py`; checked by `tools/fs131_l5_records.py`. -/
-- Arith/ProductFactor
#print axioms HadwigerNelson.SpectralInputs.measurePreserving_prodMap₃
-- Arith/RatioBound
#print axioms HadwigerNelson.RatioBound.fourier_sq_mul_charSum
-- Arith/TargetFloors
#print axioms HadwigerNelson.StandingFive.seven_le_localBound_of_kloosterman
#print axioms HadwigerNelson.StandingFive.standingFloor_five
#print axioms HadwigerNelson.StandingFive.standingFloor_seven
/-! ## FS132-I1 — the import of `[OAIMath2026]` family 158 (`Outside/OAI158`): around the two axioms, no axiom — the
release's definitions in this library's vocabulary, the measure bridge, the models -/
-- FS132-I1
#print axioms HadwigerNelson.Outside.OAI158.properColoring_iff_colorable
#print axioms HadwigerNelson.Outside.OAI158.direction_coe
#print axioms HadwigerNelson.Outside.OAI158.map_coe_arcLength
#print axioms HadwigerNelson.Outside.OAI158.map_prodMap_coe
#print axioms HadwigerNelson.Outside.OAI158.weakColoring_iff_unitPairsNull
#print axioms HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_weak
#print axioms HadwigerNelson.Outside.OAI158.weakColoring_of_aeColouring
#print axioms HadwigerNelson.Outside.OAI158.exists_weakColoring_iff_nonempty_aeColouring
#print axioms HadwigerNelson.Outside.OAI158.exists_properColoring_seven
#print axioms HadwigerNelson.Outside.OAI158.proper_to_borel_weak_model
#print axioms HadwigerNelson.Outside.OAI158.anglePeriodPositive
#print axioms HadwigerNelson.Outside.OAI158.angularMeasure.instIsProbabilityMeasure


/-! ## FS131-K7 — FS-131 wave 7's planner: `Plane/SimpleOn`, "simple" on a set (the class a fragment's argument reads;
inventory item 508). Waves 8 and 9 merge the commit that adds this block. -/
-- FS131-K7: Plane/SimpleOn
#print axioms HadwigerNelson.Plane.ArcMap.Simple.simpleOn
#print axioms HadwigerNelson.Plane.ArcMap.simpleOn_univ
#print axioms HadwigerNelson.Plane.ArcMap.SimpleOn.mono
#print axioms HadwigerNelson.Plane.ArcMap.simpleOn_ball_iff
#print axioms HadwigerNelson.Plane.ArcMap.SimpleOn.coneAt_eq_angleIcc
#print axioms HadwigerNelson.Plane.ArcMap.SimpleOn.coneAt_eq_angleIcc_sep
#print axioms HadwigerNelson.Plane.halfDisc_simpleOn
#print axioms HadwigerNelson.Plane.ArcMap.not_simpleOn_of_not_jordan
-- FS131-K7 block end (Plane/SimpleOn)
/-! ## FS131-K8 — FS-131 wave 8's planner: the ring calculus (`Plane/RingCalculus/Basic`, `Star`, `Empty`). The foundation
and the rows proved at the planning pass; the `sorry` leaves (`star_recip`, `star_anti`, and `Empty`'s eight) join this block as
their implementers close them. -/
-- FS131-K8: Plane/RingCalculus/Basic
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_inter_eq
#print axioms HadwigerNelson.Plane.ArcMap.NonSiamese.tile_eq_of_dist_lt
#print axioms HadwigerNelson.Plane.ArcMap.NonSiamese.tile_eq_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_tipColours_outerTileColours
#print axioms HadwigerNelson.Plane.ArcMap.isTip_comm
#print axioms HadwigerNelson.Plane.ArcMap.tipColours_comm
#print axioms HadwigerNelson.Plane.ArcMap.mem_outerTileColours_iff
#print axioms HadwigerNelson.Plane.ArcMap.cos_nonpos_of_coneAt_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_subset_of_subset_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_subset_of_disjoint_ball
#print axioms HadwigerNelson.Plane.ArcMap.inter_ball_nonempty_of_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_not_mem_closedBall_of_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.inter_ball_nonempty_of_inward_cone
#print axioms HadwigerNelson.Plane.ArcMap.IsTip.coneAt_subset
#print axioms HadwigerNelson.Plane.ArcMap.isHub_iff
#print axioms HadwigerNelson.Plane.ArcMap.GammaFreeRing.qFreeRing
#print axioms HadwigerNelson.Plane.ArcMap.QFreeRing.isHub
#print axioms HadwigerNelson.Plane.GermIn.ringPt_mem_closure
#print axioms HadwigerNelson.Plane.halfPlane2_gammaFreeRing
-- FS131-K8: Plane/RingCalculus/Star (the proved rows: FS116-RING-GERM in tile form, FS116-N2-STAR)
#print axioms HadwigerNelson.Plane.ArcMap.ringGerm_inward
#print axioms HadwigerNelson.Plane.ArcMap.ringGerm_outward
#print axioms HadwigerNelson.Plane.ArcMap.star_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.star_absent
#print axioms HadwigerNelson.Plane.ArcMap.star_outer_cone
#print axioms HadwigerNelson.Plane.ArcMap.star_flank
#print axioms HadwigerNelson.Plane.ArcMap.star_flank_interior
#print axioms HadwigerNelson.Plane.ArcMap.star_tip_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.star_outer_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_ringPt_add_pi
-- FS131-K8: Plane/RingCalculus/Empty (the proved row: FS116-V6-ANTI, class-free)
#print axioms HadwigerNelson.Plane.ArcMap.v6_anti
-- FS131-K8 block end (Plane/RingCalculus)
/-! ## FS131-I8A — FS-131 wave 8's first implementer: the route to `emptyNS` (`Plane/RingCalculus/Empty` and the helper
modules `HubCount`, `TilesAt`, `SoleTip`, `RingColour`). -/
-- FS131-I8A: Plane/RingCalculus/HubCount (FS116-V6-COUNT's count: the kernel table, by `decide +kernel`)
#print axioms HadwigerNelson.Plane.V6Count.allZ_iff
#print axioms HadwigerNelson.Plane.V6Count.anyZ_iff
#print axioms HadwigerNelson.Plane.V6Count.allF_iff
#print axioms HadwigerNelson.Plane.V6Count.anyF_iff
#print axioms HadwigerNelson.Plane.V6Count.stmtB_sound
#print axioms HadwigerNelson.Plane.V6Count.table
#print axioms HadwigerNelson.Plane.V6Count.sub_one_not_cons
#print axioms HadwigerNelson.Plane.V6Count.mem_shapes_single
#print axioms HadwigerNelson.Plane.V6Count.mem_shapes_double
#print axioms HadwigerNelson.Plane.V6Count.exists_shape
#print axioms HadwigerNelson.Plane.V6Count.count
#print axioms HadwigerNelson.Plane.V6Count.countModel_hyps
#print axioms HadwigerNelson.Plane.V6Count.doublesB_sound
#print axioms HadwigerNelson.Plane.V6Count.doublesTable
#print axioms HadwigerNelson.Plane.V6Count.twoDoubles
-- FS131-I8A: Plane/RingCalculus/TilesAt
#print axioms HadwigerNelson.Plane.exists_fin_surj_of_card_le
#print axioms HadwigerNelson.Plane.ArcMap.exists_fin_tileAt
#print axioms HadwigerNelson.Plane.isPreconnected_sphere_complex
#print axioms HadwigerNelson.Plane.ArcMap.finite_tileAt
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_tileAt
#print axioms HadwigerNelson.Plane.ArcMap.TileAt.inter_sphere_nonempty
#print axioms HadwigerNelson.Plane.ArcMap.sphere_subset_iUnion_closure_tileAt
-- FS131-I8A: Plane/RingCalculus/SoleTip (FS116-V6-HUG and FS129-MR1-DOUBLETIP at the class the argument reads)
#print axioms HadwigerNelson.Plane.mem_closure_diff_closedBall
#print axioms HadwigerNelson.Plane.ArcMap.germ_Icc_subset_closure
#print axioms HadwigerNelson.Plane.ArcMap.Valid.dist_le_one_of_near_germ
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_subset_closure_region_of_sole_tip
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_ringPt_third_sub
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_ringPt_third_sub_two
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_ringPt_two_thirds
#print axioms HadwigerNelson.Plane.ArcMap.not_sole_tip_of_adjacent_changePoints
-- FS131-I8A: Plane/RingCalculus/RingColour
#print axioms HadwigerNelson.Plane.ArcMap.germIn_of_mem_isOpen
#print axioms HadwigerNelson.Plane.ArcMap.germIn_region_unique
#print axioms HadwigerNelson.Plane.ArcMap.GammaFreeRing.exists_germIn
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_coloursAt_of_germIn
#print axioms HadwigerNelson.Plane.ArcMap.GammaFreeRing.exists_absent_pair
#print axioms HadwigerNelson.Plane.ArcMap.germCol_eq
#print axioms HadwigerNelson.Plane.ArcMap.germCol_right
#print axioms HadwigerNelson.Plane.ArcMap.germCol_left
#print axioms HadwigerNelson.Plane.ArcMap.germCol_const
#print axioms HadwigerNelson.Plane.ArcMap.germCol_rotate_ne
#print axioms HadwigerNelson.Plane.ArcMap.exists_isChangePoint_iff
#print axioms HadwigerNelson.Plane.ArcMap.germCol_change_rotate
#print axioms HadwigerNelson.Plane.ArcMap.germCol_change_int
#print axioms HadwigerNelson.Plane.ArcMap.exists_germCol_change
#print axioms HadwigerNelson.Plane.ArcMap.exists_third_change
#print axioms HadwigerNelson.Plane.halfPlane2_covers
-- FS131-I8A: Plane/RingCalculus/Empty (the leaves closed)
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_sixth_congr
#print axioms HadwigerNelson.Plane.ArcMap.exists_int_of_three_dist_le_one
#print axioms HadwigerNelson.Plane.ArcMap.not_double_two_classes
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_mem_of_sixth
#print axioms HadwigerNelson.Plane.ArcMap.sixth_cons_of_mem_closure
#print axioms HadwigerNelson.Plane.ArcMap.exists_two_double_tiles
#print axioms HadwigerNelson.Plane.ArcMap.fin_four_three_pairs
#print axioms HadwigerNelson.Plane.ArcMap.GammaFreeRing.changePoint_gap
#print axioms HadwigerNelson.Plane.ArcMap.v6_hubs
#print axioms HadwigerNelson.Plane.ArcMap.v6_hug
#print axioms HadwigerNelson.Plane.ArcMap.emptyNS
#print axioms HadwigerNelson.Plane.ArcMap.v6_hubs_vacuous
#print axioms HadwigerNelson.Plane.ArcMap.v6_hug_vacuous
#print axioms HadwigerNelson.Plane.ArcMap.doubleTip
#print axioms HadwigerNelson.Plane.ArcMap.intCast_zmod_six_of_half_le_cos
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_sixth_dist_le_one
#print axioms HadwigerNelson.Plane.ArcMap.v6_count
#print axioms HadwigerNelson.Plane.ArcMap.exists_ne_mem_closure_inter_of_split
-- FS131-I8A: Plane/RingCalculus/Star (FS116-N2-RECIP)
#print axioms HadwigerNelson.Plane.ArcMap.exists_tileOf_of_germIn
#print axioms HadwigerNelson.Plane.ArcMap.star_recip
-- FS131-I8A block end
/-! ## FS131-K8b — FS-131 wave 8's second planner: the semi-hub rows (`Plane/RingCalculus/SemiHub`, `SemiHubPlaces`). The
declarations with no `sorry` beneath them, all in `SemiHub`; `ringArc_dist_le_one`, `germPair_swap` (`SemiHub`),
`crossed_tip_zeroAngle` and `transferQC` (`SemiHubPlaces`) are proved from stated leaves and join this block when those
leaves close. -/
-- FS131-K8b: Plane/RingCalculus/SemiHub
#print axioms HadwigerNelson.Plane.ArcMap.IsEdgeDir.symm
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.isEdgeDir₁₂
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.isEdgeDir₂₃
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.isEdgeDir₃₄
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.angleIcc_subset_cone₂
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.angleIcc_subset_cone₄
#print axioms HadwigerNelson.Plane.ArcMap.isSemiHub_iff_qSide
#print axioms HadwigerNelson.Plane.ArcMap.isFullSemiHub_iff_qSide
#print axioms HadwigerNelson.Plane.ArcMap.qcol_cw
#print axioms HadwigerNelson.Plane.ArcMap.qcol_ccw
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.not_mem_closure_of_not_subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.germIn_closure
#print axioms HadwigerNelson.Plane.ArcMap.GermOnQWith.germIn_closure
#print axioms HadwigerNelson.Plane.ArcMap.germOnQ_bar_uPlus
#print axioms HadwigerNelson.Plane.ArcMap.germOnQ_bar_vMinus
#print axioms HadwigerNelson.Plane.ArcMap.germOnQ_bar_uMinus
#print axioms HadwigerNelson.Plane.ArcMap.germOnQ_bar_vPlus
#print axioms HadwigerNelson.Plane.ArcMap.closure_inter_subset_sphere
-- FS131-K8b block end
/-! ## FS131-I8B — FS-131 wave 8's join: the lemmas `Plane/RingCalculus/SemiHub` and `SemiHubPlaces` share
(`Plane/RingCalculus/StarChart`), and FS116-N2-ANTI (`Plane/RingCalculus/Star`). -/
-- FS131-I8B: Plane/RingCalculus/StarChart
#print axioms HadwigerNelson.Plane.exists_int_of_angleIcc_subset
#print axioms HadwigerNelson.Plane.int_eq_zero_of_two_pi_mul_lt
#print axioms HadwigerNelson.Plane.int_eq_zero_of_abs_two_pi_mul_lt
#print axioms HadwigerNelson.Plane.segment_eq_image_ray
#print axioms HadwigerNelson.Plane.Arc.InitialPiece.exists_param
#print axioms HadwigerNelson.Plane.branchPt_mem_Rgn
#print axioms HadwigerNelson.Plane.branchPt_curveGerm_add
#print axioms HadwigerNelson.Plane.not_both_mem_Rgn_curveGerm
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_tile_of_near
#print axioms HadwigerNelson.Plane.ArcMap.ncard_tileAt_eq
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.tileAt_equiv
#print axioms HadwigerNelson.Plane.ArcMap.exists_sectorChart_tileAt
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_branch_of_isPreconnected
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_initialPiece_branch
#print axioms HadwigerNelson.Plane.ArcMap.IsSectorChart.exists_initialPiece_between
#print axioms HadwigerNelson.Plane.ArcMap.exists_initialPiece_of_ncard_le_three
-- FS131-I8B: Plane/RingCalculus/Star (FS116-N2-ANTI, at the ruled statement)
#print axioms HadwigerNelson.Plane.ArcMap.mem_coneAt_add_int_mul_two_pi
#print axioms HadwigerNelson.Plane.ArcMap.false_of_antipodal_gaps
#print axioms HadwigerNelson.Plane.ArcMap.star_anti_ne
#print axioms HadwigerNelson.Plane.ArcMap.star_anti_count
#print axioms HadwigerNelson.Plane.ArcMap.star_anti
-- FS131-I8B block end
/-! ## FS131-I8C — FS-131 wave 8's semi-hub rows, first module (`Plane/RingCalculus/SemiHub`): the planner's leaves as they
close, their helpers, and the declarations the planner proved from those leaves. -/
-- FS131-I8C: Plane/RingCalculus/SemiHub (FS116-V5-QCOL, FS116-N3-PAIR, FS116-N3-CONE (a))
#print axioms HadwigerNelson.Plane.ArcMap.qcol_inner_tile
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.exists_sub_of_germIn
#print axioms HadwigerNelson.Plane.ArcMap.GermOnQWith.exists_isRingArc_ccw
#print axioms HadwigerNelson.Plane.ArcMap.GermOnQWith.exists_isRingArc_cw
#print axioms HadwigerNelson.Plane.ArcMap.exists_far_of_germPair
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_dist_le_one
#print axioms HadwigerNelson.Plane.ArcMap.qcol_not_one_arc
#print axioms HadwigerNelson.Plane.ArcMap.germPair_inner_ne
#print axioms HadwigerNelson.Plane.ArcMap.germPair_swap
#print axioms HadwigerNelson.Plane.ArcMap.germIn_closure_tile_of_near
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_ball_of_far_germ
#print axioms HadwigerNelson.Plane.ArcMap.ringTile_uMinus
#print axioms HadwigerNelson.Plane.ArcMap.ringTile_vMinus
#print axioms HadwigerNelson.Plane.ArcMap.ringTile_vPlus
#print axioms HadwigerNelson.Plane.ArcMap.ringTile_uPlus
-- FS131-I8C: helpers that read no map
#print axioms HadwigerNelson.Plane.two_pi_mul_int_le_of_neg
#print axioms HadwigerNelson.Plane.two_pi_le_mul_int_of_pos
#print axioms HadwigerNelson.Plane.BranchGerms.nextβ_four
-- FS131-I8C: Plane/RingCalculus/SemiHub (FS116-N3-CONE (c), FS116-N3-STAR2, FS116-V5-DICHO)
#print axioms HadwigerNelson.Plane.ArcMap.isRingArc_of_edge
#print axioms HadwigerNelson.Plane.ArcMap.simpleOn_not_hasRepeatedColour
#print axioms HadwigerNelson.Plane.ArcMap.four_le_of_bothKind
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.rotate
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.shift
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.exists_first
#print axioms HadwigerNelson.Plane.ArcMap.IsStar4.opposite_of_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.exists_isStar4
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_star
#print axioms HadwigerNelson.Plane.ArcMap.fullSemiHub_star_crossed
#print axioms HadwigerNelson.Plane.ArcMap.fullSemiHub_star_parallel
#print axioms HadwigerNelson.Plane.ArcMap.fullSemiHub_star_parallel_T
#print axioms HadwigerNelson.Plane.ArcMap.ringArc_pair_eq_or_disjoint
#print axioms HadwigerNelson.Plane.ArcMap.germPair_dicho
-- FS131-I8C: the class of the shared lemmas, inhabited (`halfDisc` at `0`)
#print axioms HadwigerNelson.Plane.halfDisc_valid
#print axioms HadwigerNelson.Plane.halfDisc_nonSiamese
#print axioms HadwigerNelson.Plane.halfDisc_ncard_coloursAt_zero
-- FS131-I8C block end
/-! ## FS131-I8D — FS-131 wave 8's second implementer of the semi-hub rows: `Plane/RingCalculus/SemiHubPlaces`
(FS116-N3-CROSS, FS116-N3-SEMI) and FS129-SR3-OUTERADJ. Until the wave's join each record here that cites a statement of
`Plane/RingCalculus/SemiHub` rested on that module's open leaves; since the join (job FS131-L8A) none does
(`tools/fs131_i8d_axioms.py`: 29 on the standard three, none resting). -/
-- FS131-I8D: Plane/RingCalculus/SemiHubPlaces
#print axioms HadwigerNelson.Plane.ArcMap.crossed_star_data
#print axioms HadwigerNelson.Plane.ArcMap.crossed_no_tip
#print axioms HadwigerNelson.Plane.ArcMap.crossed_tip_zeroAngle
#print axioms HadwigerNelson.Plane.ArcMap.crossed_outer
#print axioms HadwigerNelson.Plane.ArcMap.crossed_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.crossed_four
#print axioms HadwigerNelson.Plane.e_add_sub_e_sub
#print axioms HadwigerNelson.Plane.GermIn.tangent_mem_coneAt
#print axioms HadwigerNelson.Plane.ArcMap.crossed_changePoint
#print axioms HadwigerNelson.Plane.ArcMap.crossed_not_germOnQ_inside
#print axioms HadwigerNelson.Plane.ArcMap.crossed_semiHub
#print axioms HadwigerNelson.Plane.ArcMap.ringPt_ringPt_four_thirds
#print axioms HadwigerNelson.Plane.ArcMap.IsRingArc.inner_ne_outer
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_ncard_eq_four
#print axioms HadwigerNelson.Plane.ArcMap.eq_triple_of_ncard_le_three
#print axioms HadwigerNelson.Plane.ArcMap.disjoint_ball_of_far_witness
#print axioms HadwigerNelson.Plane.ArcMap.mem_closure_of_coneAt_toward
#print axioms HadwigerNelson.Plane.ArcMap.semiHub_edge
#print axioms HadwigerNelson.Plane.ArcMap.semiHub_places_O
#print axioms HadwigerNelson.Plane.ArcMap.semiHub_places_T
#print axioms HadwigerNelson.Plane.ArcMap.semiHub_places
#print axioms HadwigerNelson.Plane.ArcMap.transferQC
-- FS131-I8D: Plane/RingCalculus/OuterAdj, and the leaf of Plane/RingCalculus/Empty
#print axioms HadwigerNelson.Plane.norm_e_add_e_sub_e_sq
#print axioms HadwigerNelson.Plane.one_lt_norm_e_add_e_sub_e
#print axioms HadwigerNelson.Plane.ArcMap.Valid.dist_le_one_of_near_germ_closure
#print axioms HadwigerNelson.Plane.ArcMap.not_germOnQ_of_germIn_region
#print axioms HadwigerNelson.Plane.ArcMap.exists_ball_subset_closure_of_sole_outer
#print axioms HadwigerNelson.Plane.ArcMap.not_sole_outer_of_adjacent_changePoints
#print axioms HadwigerNelson.Plane.ArcMap.outerAdj
-- FS131-I8D block end
/-! ## FS131-L8A — FS-131 wave 8's first landing: the theorems of the wave's modules that the planners' and the
implementers' blocks did not list. Read from the kernel's own list of the library's theorems
(`data/fs131/l5/count-modules.lean`), by `tools/fs131_l8a_register.py`; checked by `tools/fs131_l10b_records.py`. -/
-- Plane/RingCalculus/Basic
#print axioms HadwigerNelson.Plane.ArcMap.GammaFreeRing.not_isRingArc
#print axioms HadwigerNelson.Plane.ArcMap.GermOnQWith.germOnQ
#print axioms HadwigerNelson.Plane.ArcMap.IsFullSemiHub.isSemiHub
#print axioms HadwigerNelson.Plane.ArcMap.IsHub.not_isSemiHub
#print axioms HadwigerNelson.Plane.ArcMap.IsOuterTileAt.not_isTip
#print axioms HadwigerNelson.Plane.ArcMap.IsTip.tileAt
#print axioms HadwigerNelson.Plane.ArcMap.QFreeRing.not_germOnQ
#print axioms HadwigerNelson.Plane.ArcMap.SemiKind.O.sizeOf_spec
#print axioms HadwigerNelson.Plane.ArcMap.SemiKind.T.sizeOf_spec
#print axioms HadwigerNelson.Plane.ArcMap.SemiKind.ofNat_ctorIdx
#print axioms HadwigerNelson.Plane.ArcMap.TileAt.subset_ball
#print axioms HadwigerNelson.Plane.ArcMap.outerTileColours_subset
#print axioms HadwigerNelson.Plane.ArcMap.tipColours_subset
-- FS131-L8A block end
/-! ## FS124-I1 — FS-124's radius clause (planned by FS124-K1): `Plane/WeakColouringOn`, `Plane/Radius`, and the three theorems
of `Plane/RadiusOutside` that use no import. The module's other five records rest on a declared outside theorem and are under
IMPORTED: `radius_five` on `no_proper_five_coloring`; `exists_isWeakColouringOn_of_colorable`, `radius_down`,
`colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball` on `proper_to_borel_weak`. `radius_up` and
`exists_radius_of_not_colorable` below are the halves of the two join theorems that need no import. -/
-- FS124-I1: Plane/WeakColouringOn
#print axioms HadwigerNelson.Plane.rigidMotion_apply_zero
#print axioms HadwigerNelson.Plane.rigidMotion_apply_one
#print axioms HadwigerNelson.Plane.rigidMotion_zero
#print axioms HadwigerNelson.Plane.rigidMotion_translation
#print axioms HadwigerNelson.Plane.dist_rigidMotion
#print axioms HadwigerNelson.Plane.continuous_rigidMotion
#print axioms HadwigerNelson.Plane.continuous_rigidMotion_apply
#print axioms HadwigerNelson.Plane.rigidMotion_add_two_pi
#print axioms HadwigerNelson.Plane.rigidMotion_motionMul
#print axioms HadwigerNelson.Plane.exists_rigidMotion_edge
#print axioms HadwigerNelson.Plane.measurePreserving_motionMul_right
#print axioms HadwigerNelson.Plane.measurePreserving_motionMul_left
#print axioms HadwigerNelson.Plane.prod_arcLength_eq_restrict
#print axioms HadwigerNelson.Plane.prod_arcLength_eq_zero_iff_volume
#print axioms HadwigerNelson.Plane.mem_monoPairSet_iff_rigidMotion
#print axioms HadwigerNelson.Plane.monoPairSet_eq_iUnion
#print axioms HadwigerNelson.Plane.mem_monoPairSet_of_e_eq
#print axioms HadwigerNelson.Plane.aeProperOn_iff_unitPairsNull
#print axioms HadwigerNelson.Plane.aeProperOn_iff_ae
#print axioms HadwigerNelson.Plane.aeProperOn_iff_volume
#print axioms HadwigerNelson.Plane.monoPairSet_mono
#print axioms HadwigerNelson.Plane.AeProperOn.mono
#print axioms HadwigerNelson.Plane.aeProperOn_congr
#print axioms HadwigerNelson.Plane.aeProperOn_of_proper
#print axioms HadwigerNelson.Plane.aeProperOn_of_proper_off_null
#print axioms HadwigerNelson.Plane.AeProperOn.comp_rigidMotion
#print axioms HadwigerNelson.Plane.isWeakColouringOn_univ_iff
#print axioms HadwigerNelson.Plane.AeColouring.isWeakColouringOn
#print axioms HadwigerNelson.Plane.IsWeakColouringOn.exists_aeColouring
#print axioms HadwigerNelson.Plane.IsWeakColouringOn.mono
#print axioms HadwigerNelson.Plane.IsWeakColouringOn.comp_rigidMotion
#print axioms HadwigerNelson.Plane.exists_isWeakColouringOn_ball_iff
#print axioms HadwigerNelson.Plane.exists_isWeakColouringOn_iff_subtype
-- FS124-I1: Plane/Radius
#print axioms HadwigerNelson.Plane.exists_isWeakColouringOn_seven
#print axioms HadwigerNelson.Plane.AeProperOn.ae_rigidMotion_edge
#print axioms HadwigerNelson.Plane.AeProperOn.ae_rigidMotion
#print axioms HadwigerNelson.Plane.AeProperOn.ae_rigidMotion_arcLength
#print axioms HadwigerNelson.Plane.aeProperOn_iff_ae_rigidMotion
#print axioms HadwigerNelson.Plane.isOpen_setOf_mapsTo_rigidMotion
#print axioms HadwigerNelson.Plane.AeProperOn.exists_rigidMotion
#print axioms HadwigerNelson.Plane.colorable_induce_of_forall_ne
#print axioms HadwigerNelson.Plane.AeProperOn.colorable_induce
#print axioms HadwigerNelson.Plane.radius_graph
#print axioms HadwigerNelson.Plane.radius_countable
#print axioms HadwigerNelson.Plane.colorable_plane_of_forall_finite
#print axioms HadwigerNelson.Plane.colorable_induce_of_forall_aeProperOn_ball
#print axioms HadwigerNelson.Plane.colorable_plane_of_forall_aeProperOn_ball
#print axioms HadwigerNelson.Plane.exists_radius_of_not_colorable
#print axioms HadwigerNelson.Plane.radius_up
-- FS124-I1: Plane/RadiusOutside (the three with no import)
#print axioms HadwigerNelson.Plane.isWeakColouringOn_univ_iff_weakColoring
#print axioms HadwigerNelson.Plane.exists_isWeakColouringOn_univ_iff
#print axioms HadwigerNelson.Plane.exists_radius_no_weak_four
-- FS124-I1 block end

/-! ## FS132-I2 — the port of `[OAIMath2026]` family 158: the lemmas FS-132's first theorem stands on (`Outside/OAI158CircleMaps` … `OAI158States`,
`OAI158AngularBoundary`), generated by `tools/fs132_i2_port.py --axioms-block`; no axiom, no outside theorem -/
-- FS132-I2
-- Outside/OAI158CircleMaps
#print axioms HadwigerNelson.Outside.OAI158.RealPlane
#print axioms HadwigerNelson.Outside.OAI158.circleSum
#print axioms HadwigerNelson.Outside.OAI158.circleSumDeriv
#print axioms HadwigerNelson.Outside.OAI158.circleSum_strict
#print axioms HadwigerNelson.Outside.OAI158.circleSum_continuous
#print axioms HadwigerNelson.Outside.OAI158.circleSumDeriv_injective
#print axioms HadwigerNelson.Outside.OAI158.circleSumDerivEquiv
#print axioms HadwigerNelson.Outside.OAI158.circleSum_local_antilipschitz
#print axioms HadwigerNelson.Outside.OAI158.realDirection_lipschitz
#print axioms HadwigerNelson.Outside.OAI158.circleInverseHomeo
#print axioms HadwigerNelson.Outside.OAI158.circleInverse
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_measurable
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_eq
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_at
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_continuousAt
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_strict
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_right
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_regular
#print axioms HadwigerNelson.Outside.OAI158.triangular_injective
#print axioms HadwigerNelson.Outside.OAI158.triangular_surjective
#print axioms HadwigerNelson.Outside.OAI158.strict_fiber_uniform_antilipschitz
#print axioms HadwigerNelson.Outside.OAI158.CircleParameter
#print axioms HadwigerNelson.Outside.OAI158.CircleJet
#print axioms HadwigerNelson.Outside.OAI158.jetCenter
#print axioms HadwigerNelson.Outside.OAI158.jetRadius
#print axioms HadwigerNelson.Outside.OAI158.jetAngle
#print axioms HadwigerNelson.Outside.OAI158.circleTarget
#print axioms HadwigerNelson.Outside.OAI158.circleTargetDeriv
#print axioms HadwigerNelson.Outside.OAI158.circleTarget_strict
#print axioms HadwigerNelson.Outside.OAI158.circleTarget_continuous
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint
#print axioms HadwigerNelson.Outside.OAI158.circleEndpointDeriv
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint_measurable
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint_strict
#print axioms HadwigerNelson.Outside.OAI158.inverse_tangent_first_ne
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint_fiber_ne
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint_uniform
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint_good_neighborhood
#print axioms HadwigerNelson.Outside.OAI158.angleChart
#print axioms HadwigerNelson.Outside.OAI158.angleChartMeasure
#print axioms HadwigerNelson.Outside.OAI158.angleChartMeas_le
#print axioms HadwigerNelson.Outside.OAI158.instIsFiniteMeasureRealPlaneAngleChartMeasure
#print axioms HadwigerNelson.Outside.OAI158.angleChart_preserving
#print axioms HadwigerNelson.Outside.OAI158.angleChart_measure
#print axioms HadwigerNelson.Outside.OAI158.integral_angular_eq_chart
#print axioms HadwigerNelson.Outside.OAI158.direction_realPlane
#print axioms HadwigerNelson.Outside.OAI158.circleSum_chart
#print axioms HadwigerNelson.Outside.OAI158.volume_preimage_bound
#print axioms HadwigerNelson.Outside.OAI158.map_restrict_volume_le
#print axioms HadwigerNelson.Outside.OAI158.antilipschitz_small_perturbation
#print axioms HadwigerNelson.Outside.OAI158.realDirection_norm_le
#print axioms HadwigerNelson.Outside.OAI158.circleSum_decompose
#print axioms HadwigerNelson.Outside.OAI158.circleSum_norm_le
#print axioms HadwigerNelson.Outside.OAI158.circleSum_perturb_identity
#print axioms HadwigerNelson.Outside.OAI158.circleSum_parameter_tendsto
#print axioms HadwigerNelson.Outside.OAI158.circleSum_eventual_image
#print axioms HadwigerNelson.Outside.OAI158.circleSum_limit_image
#print axioms HadwigerNelson.Outside.OAI158.circleSum_eventual_antilipschitz
#print axioms HadwigerNelson.Outside.OAI158.circleSum_limit_antilipschitz
#print axioms HadwigerNelson.Outside.OAI158.measure_null_of_locally_null_on_conull
#print axioms HadwigerNelson.Outside.OAI158.circleSum_regular_ae
#print axioms HadwigerNelson.Outside.OAI158.circleSum_preimage_null
#print axioms HadwigerNelson.Outside.OAI158.circleSum_quasiMeasurePreserving
-- Outside/OAI158Expansion
#print axioms HadwigerNelson.Outside.OAI158.line_volume_preimage_bound
#print axioms HadwigerNelson.Outside.OAI158.line_map_restrict_volume_le
#print axioms HadwigerNelson.Outside.OAI158.integrable_comp_of_map_le
#print axioms HadwigerNelson.Outside.OAI158.integral_norm_comp_le
#print axioms HadwigerNelson.Outside.OAI158.tendsto_integral_norm_comp_sub
#print axioms HadwigerNelson.Outside.OAI158.tendsto_integral_norm_comp_sub_eventual
#print axioms HadwigerNelson.Outside.OAI158.line_antilipschitz_qmp
#print axioms HadwigerNelson.Outside.OAI158.line_indicator_pullback_L1
-- Outside/OAI158CircleTransport
#print axioms HadwigerNelson.Outside.OAI158.tendsto_integral_of_local_cover
#print axioms HadwigerNelson.Outside.OAI158.bounded_difference_integrable
#print axioms HadwigerNelson.Outside.OAI158.circleSum_tendsto_L1
#print axioms HadwigerNelson.Outside.OAI158.angularSum_measurable
#print axioms HadwigerNelson.Outside.OAI158.angularSum_chart
#print axioms HadwigerNelson.Outside.OAI158.angularSum_quasiMeasurePreserving
#print axioms HadwigerNelson.Outside.OAI158.angularSum_tendsto_L1
#print axioms HadwigerNelson.Outside.OAI158.samplingParameter
#print axioms HadwigerNelson.Outside.OAI158.samplingParameter_tendsto
#print axioms HadwigerNelson.Outside.OAI158.circleTarget_sampling
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_sampling
-- Outside/OAI158PaletteDensity
#print axioms HadwigerNelson.Outside.OAI158.weak_strong_disjoint
#print axioms HadwigerNelson.Outside.OAI158.colorIndicator
#print axioms HadwigerNelson.Outside.OAI158.colorIndicator_measurable
#print axioms HadwigerNelson.Outside.OAI158.colorIndicator_bounds
#print axioms HadwigerNelson.Outside.OAI158.sample_pair_disjoint
#print axioms HadwigerNelson.Outside.OAI158.trace_pair_disjoint
#print axioms HadwigerNelson.Outside.OAI158.palette_first_exclusion
#print axioms HadwigerNelson.Outside.OAI158.palette_second_exclusion
#print axioms HadwigerNelson.Outside.OAI158.palette_transfer_pair
#print axioms HadwigerNelson.Outside.OAI158.angleMk_quasiMeasurePreserving
#print axioms HadwigerNelson.Outside.OAI158.anglePair_quasiMeasurePreserving
#print axioms HadwigerNelson.Outside.OAI158.FlatDensityZero
#print axioms HadwigerNelson.Outside.OAI158.LineDensityZero
#print axioms HadwigerNelson.Outside.OAI158.volume_image_bound
#print axioms HadwigerNelson.Outside.OAI158.flatDensityZero_prod
#print axioms HadwigerNelson.Outside.OAI158.tendsto_pos_mul_nhdsWithin
#print axioms HadwigerNelson.Outside.OAI158.FlatDensityZero.image
#print axioms HadwigerNelson.Outside.OAI158.FlatDensityZero.of_locally_le
#print axioms HadwigerNelson.Outside.OAI158.FlatDensityZero.transport
#print axioms HadwigerNelson.Outside.OAI158.circleSum_one_lipschitz
#print axioms HadwigerNelson.Outside.OAI158.circleSum_densityZero
#print axioms HadwigerNelson.Outside.OAI158.complex_ball_flat_ball
#print axioms HadwigerNelson.Outside.OAI158.flat_to_complex_densityZero
#print axioms HadwigerNelson.Outside.OAI158.ae_lineDensityZero_compl
#print axioms HadwigerNelson.Outside.OAI158.liftPalette_measurable
#print axioms HadwigerNelson.Outside.OAI158.palette_spatial_densityZero
#print axioms HadwigerNelson.Outside.OAI158.palette_spatial_not_densityOne
#print axioms HadwigerNelson.Outside.OAI158.palette_sample_branch_exclusion
-- Outside/OAI158PaletteTransport
#print axioms HadwigerNelson.Outside.OAI158.angleRep_preserving
#print axioms HadwigerNelson.Outside.OAI158.weak_lift_Ioc
#print axioms HadwigerNelson.Outside.OAI158.weak_restrict
#print axioms HadwigerNelson.Outside.OAI158.weak_lift_set
#print axioms HadwigerNelson.Outside.OAI158.weak_strong_disjoint_single
#print axioms HadwigerNelson.Outside.OAI158.weak_strong_disjoint_single_eventual
#print axioms HadwigerNelson.Outside.OAI158.palette_trace_branch
#print axioms HadwigerNelson.Outside.OAI158.palette_branch_local
#print axioms HadwigerNelson.Outside.OAI158.circleInverse_left
#print axioms HadwigerNelson.Outside.OAI158.circleEndpoint_eventuallyEq
#print axioms HadwigerNelson.Outside.OAI158.ae_of_locally_ae
#print axioms HadwigerNelson.Outside.OAI158.ae_restrict_of_locally_ae
#print axioms HadwigerNelson.Outside.OAI158.palette_transport_real
#print axioms HadwigerNelson.Outside.OAI158.sin_sixty_ne
#print axioms HadwigerNelson.Outside.OAI158.sin_twice_sixty_ne
#print axioms HadwigerNelson.Outside.OAI158.sixty_sum
#print axioms HadwigerNelson.Outside.OAI158.ae_angular_of_ae_line
#print axioms HadwigerNelson.Outside.OAI158.palette_sixty_real
#print axioms HadwigerNelson.Outside.OAI158.palette_sixty
#print axioms HadwigerNelson.Outside.OAI158.palette_sixty_disjoint
-- Outside/OAI158BinaryPalettes
#print axioms HadwigerNelson.Outside.OAI158.triangleAngle
#print axioms HadwigerNelson.Outside.OAI158.triangleAngle_cos
#print axioms HadwigerNelson.Outside.OAI158.triangleAngle_pos
#print axioms HadwigerNelson.Outside.OAI158.triangleAngle_lt_pi
#print axioms HadwigerNelson.Outside.OAI158.triangleAngle_ratio_irrational
#print axioms HadwigerNelson.Outside.OAI158.triangle_rotation_ergodic
#print axioms HadwigerNelson.Outside.OAI158.equal_triangleAngle_positive
#print axioms HadwigerNelson.Outside.OAI158.circle_exp_sub_norm_sq
#print axioms HadwigerNelson.Outside.OAI158.sourceTriangle
#print axioms HadwigerNelson.Outside.OAI158.sourceTriangle_eq
#print axioms HadwigerNelson.Outside.OAI158.sourceTriangle_pair
-- Outside/OAI158States
#print axioms HadwigerNelson.Outside.OAI158.LineDensityZero.mono_ae
#print axioms HadwigerNelson.Outside.OAI158.DensityZero
#print axioms HadwigerNelson.Outside.OAI158.DensityZero.union
#print axioms HadwigerNelson.Outside.OAI158.densityZero_empty
#print axioms HadwigerNelson.Outside.OAI158.DensityZero.biUnion_finset
#print axioms HadwigerNelson.Outside.OAI158.DensityZero.compl
#print axioms HadwigerNelson.Outside.OAI158.state_densityZero
#print axioms HadwigerNelson.Outside.OAI158.angularSum_swap
#print axioms HadwigerNelson.Outside.OAI158.states_densityOne
#print axioms HadwigerNelson.Outside.OAI158.DensityOne.compl
#print axioms HadwigerNelson.Outside.OAI158.DensityOne.inter
#print axioms HadwigerNelson.Outside.OAI158.DensityOne.measure_ne_zero
#print axioms HadwigerNelson.Outside.OAI158.densityOne_univ
#print axioms HadwigerNelson.Outside.OAI158.DensityOne.iInter
#print axioms HadwigerNelson.Outside.OAI158.finite_density_realization
#print axioms HadwigerNelson.Outside.OAI158.two_label_triangle_impossible
#print axioms HadwigerNelson.Outside.OAI158.bool_flip_two
#print axioms HadwigerNelson.Outside.OAI158.bool_flip_three
#print axioms HadwigerNelson.Outside.OAI158.bool_flip_even
#print axioms HadwigerNelson.Outside.OAI158.triangleAngle_nonparallel
#print axioms HadwigerNelson.Outside.OAI158.two_state_impossible
-- Outside/OAI158AngularBoundary
#print axioms HadwigerNelson.Outside.OAI158.mem_spatialSupport_ae
-- FS132-I2: end of the block

/-! ## FS132-I3 — the first night's exclusion (C132-M-ORBIT): the step lemma (M8, Lemma S) and the shift's calculus
(M7). Two modules of `Plane/SixRing`, every theorem of each; no colouring in either, and nothing outside. -/
-- FS132-I3
-- Plane/SixRing/StepLemma
#print axioms HadwigerNelson.SixRing.ae_mem_imp_isDensityPt
#print axioms HadwigerNelson.SixRing.IsDensityPt.mono
#print axioms HadwigerNelson.SixRing.isDensityPt_of_mem_nhds
#print axioms HadwigerNelson.SixRing.IsDensityPt.eventually_lt
#print axioms HadwigerNelson.SixRing.IsDensityPt.eventually_compl_le
#print axioms HadwigerNelson.SixRing.IsDensityPt.eventually_lt_Ioo
#print axioms HadwigerNelson.SixRing.IsDensityPt.not_compl
#print axioms HadwigerNelson.SixRing.exists_step_or_density_triple
#print axioms HadwigerNelson.SixRing.exists_window
#print axioms HadwigerNelson.SixRing.exists_shiftMap
#print axioms HadwigerNelson.SixRing.volume_le_mul_volume_image
#print axioms HadwigerNelson.SixRing.exists_density_pair
#print axioms HadwigerNelson.SixRing.volume_pattern_pos
#print axioms HadwigerNelson.SixRing.noDoubleChange_compl
#print axioms HadwigerNelson.SixRing.density_triple_false
#print axioms HadwigerNelson.SixRing.step_lemma
#print axioms HadwigerNelson.SixRing.change_Iio
#print axioms HadwigerNelson.SixRing.step_at_of_change
#print axioms HadwigerNelson.SixRing.volume_change_pairs_pos
-- Plane/SixRing/Shift
#print axioms HadwigerNelson.SixRing.ringRadius_eq
#print axioms HadwigerNelson.SixRing.ringRadius_mem
#print axioms HadwigerNelson.SixRing.shift_comm
#print axioms HadwigerNelson.SixRing.shift_zero_right
#print axioms HadwigerNelson.SixRing.shift_zero_left
#print axioms HadwigerNelson.SixRing.norm_sq_polar_sub
#print axioms HadwigerNelson.SixRing.shiftCos_mem
#print axioms HadwigerNelson.SixRing.shift_sign_identity
#print axioms HadwigerNelson.SixRing.dist_chart_chart_shift
#print axioms HadwigerNelson.SixRing.shift_pos
#print axioms HadwigerNelson.SixRing.exists_shift_lipschitz
#print axioms HadwigerNelson.SixRing.measurable_shift
#print axioms HadwigerNelson.SixRing.exists_shiftBounds
-- FS132-I3 block end

/-! ## FS132-I4 — the join of the port under the exclusion's skeleton: the leaves on the ported lemmas (`Plane/SixRing/State`, `Excl`), the null sets
through the chart and the kill (`ChartMeasure`, `Kill`), their helpers (`NullSets`); and the two-pair ring, complete at the join. No axiom, no outside
theorem; and, under the brief's Amendment 2, the chart's geometry and the tips (`Chart`, `Tips`), with the assembly that the
leaves complete (`Kill.chart_step_false`, `Orbit`). `data/fs132/i4/axioms/check.out` is the print of each -/
-- FS132-I4
-- Plane/SixRing/NullSets
#print axioms HadwigerNelson.SixRing.shear_measurePreserving
#print axioms HadwigerNelson.SixRing.quasiMeasurePreserving_triple_fst
#print axioms HadwigerNelson.SixRing.quasiMeasurePreserving_triple_snd
#print axioms HadwigerNelson.SixRing.quasiMeasurePreserving_triple_add
#print axioms HadwigerNelson.SixRing.change_of_ae_flip
#print axioms HadwigerNelson.SixRing.exists_inter_pos_of_ae_union
#print axioms HadwigerNelson.SixRing.volume_preimage_inter_le_hausdorff
#print axioms HadwigerNelson.SixRing.lipschitzWith_add_e
#print axioms HadwigerNelson.SixRing.hausdorffMeasure_add_e_image_eq_zero
#print axioms HadwigerNelson.SixRing.exists_mem_Ioo_of_ae
#print axioms HadwigerNelson.SixRing.exists_pos_forall_le
-- Plane/SixRing/Excl
#print axioms HadwigerNelson.SixRing.ae_real_of_ae_angles
#print axioms HadwigerNelson.SixRing.volume_liftPalette_ne_zero
#print axioms HadwigerNelson.SixRing.exists_change_of_ae_outside
-- Plane/SixRing/ChartMeasure
#print axioms HadwigerNelson.SixRing.chartAngles_quasiMeasurePreserving
#print axioms HadwigerNelson.SixRing.chart_quasiMeasurePreserving
#print axioms HadwigerNelson.SixRing.shear_quasiMeasurePreserving
#print axioms HadwigerNelson.SixRing.ae_ne_of_not_isTip
#print axioms HadwigerNelson.SixRing.ringRadius_sub_ge
#print axioms HadwigerNelson.SixRing.ringRadius_pos
#print axioms HadwigerNelson.SixRing.volume_partner_direction_eq_zero
#print axioms HadwigerNelson.SixRing.unitPair_chart_ae
-- Plane/SixRing/State
#print axioms HadwigerNelson.SixRing.measurableSet_liftPalette
#print axioms HadwigerNelson.SixRing.OutsideOrbit.ae_mem_or
#print axioms HadwigerNelson.SixRing.OutsideOrbit.ae_add_mem_or
#print axioms HadwigerNelson.SixRing.OutsideOrbit.ae_iff_not
#print axioms HadwigerNelson.SixRing.OutsideOrbit.ae_flip
#print axioms HadwigerNelson.SixRing.OutsideOrbit.change_at
#print axioms HadwigerNelson.SixRing.OutsideOrbit.chart_avoids
#print axioms HadwigerNelson.SixRing.ae_chart_colour_mem
#print axioms HadwigerNelson.SixRing.exists_tip
#print axioms HadwigerNelson.SixRing.OutsideOrbit.hubColours
#print axioms HadwigerNelson.SixRing.OutsideOrbit.hubColours_flip
-- Plane/SixRing/Kill
#print axioms HadwigerNelson.SixRing.HubColours.swap
#print axioms HadwigerNelson.SixRing.HubColours.shift_back
#print axioms HadwigerNelson.SixRing.HubColours.ae_partner
#print axioms HadwigerNelson.SixRing.no_double_change
#print axioms HadwigerNelson.SixRing.step_kill_left
#print axioms HadwigerNelson.SixRing.step_kill
-- Plane/SixRing/TwoPairs (FS132-K2's proofs; sorry-free since the join: the ported `two_state_impossible` and `ae_real_of_ae_angles`)
#print axioms HadwigerNelson.SixRing.no_alternating_groups
#print axioms HadwigerNelson.SixRing.no_alternating_pairs
-- Plane/SixRing/Chart (Amendment 2)
#print axioms HadwigerNelson.SixRing.chart_eq_polar
#print axioms HadwigerNelson.SixRing.chart_zero
#print axioms HadwigerNelson.SixRing.chart_hub
#print axioms HadwigerNelson.SixRing.dist_chart_centre
#print axioms HadwigerNelson.SixRing.dist_chart_lt_one
#print axioms HadwigerNelson.SixRing.continuous_chart
#print axioms HadwigerNelson.SixRing.chart_eq_angularSum
#print axioms HadwigerNelson.SixRing.dist_hub
#print axioms HadwigerNelson.SixRing.hub_add_three
#print axioms HadwigerNelson.SixRing.hub_axes
#print axioms HadwigerNelson.SixRing.hub_shift
-- Plane/SixRing/Tips (Amendment 2)
#print axioms HadwigerNelson.SixRing.IsTip.dist_le_one
#print axioms HadwigerNelson.SixRing.IsTip.inner_pos
#print axioms HadwigerNelson.SixRing.tip_antipodal
#print axioms HadwigerNelson.SixRing.tip_unique
#print axioms HadwigerNelson.SixRing.adjacent_of_signs_aux
#print axioms HadwigerNelson.SixRing.adjacent_of_signs
#print axioms HadwigerNelson.SixRing.exists_adjacent_tips
#print axioms HadwigerNelson.SixRing.exists_cycle_label
-- Plane/SixRing/Kill and Orbit (FS132-K2's proofs from the leaves: the analytic core and the assembly — C132-M-ORBIT, C132-M-EXCL at the whole plane)
#print axioms HadwigerNelson.SixRing.chart_step_false
#print axioms HadwigerNelson.SixRing.adjacent_tip_false
#print axioms HadwigerNelson.SixRing.straddle_mono
#print axioms HadwigerNelson.SixRing.no_outside_orbit_points
#print axioms HadwigerNelson.SixRing.no_outside_orbit
#print axioms HadwigerNelson.SixRing.not_ae_outside
-- FS132-I4: end of the block

/-! ## FS132-L2 — the landing of FS-132's first theorem: every declaration the landing brings that no block above holds — the palette module's own
(`Outside/OAI158Palette`: definitions and lemmas), the confinement module and the basic module of the exclusion (`Plane/SixRing/Confine`, `Basic`), and three
strays (a definition, a lemma, a structure). Definitions and structures are filed with the theorems, as the port's block files them. No axiom, no
outside theorem: `tools/fs132_l2_records.py` reads every record of the landing's twenty-two modules under CLEAN on a subset of the standard three -/
-- FS132-L2
-- Outside/OAI158Palette — the release's palette chain, ported by FS132-K1 (generated): every definition and lemma of the module
#print axioms HadwigerNelson.Outside.OAI158.DensityOne
#print axioms HadwigerNelson.Outside.OAI158.IsTrace
#print axioms HadwigerNelson.Outside.OAI158.PlaneL2
#print axioms HadwigerNelson.Outside.OAI158.RealL2
#print axioms HadwigerNelson.Outside.OAI158.RealState
#print axioms HadwigerNelson.Outside.OAI158.Straddle
#print axioms HadwigerNelson.Outside.OAI158.TraceVector
#print axioms HadwigerNelson.Outside.OAI158.Traces
#print axioms HadwigerNelson.Outside.OAI158.TransitionEdge
#print axioms HadwigerNelson.Outside.OAI158.Typical
#print axioms HadwigerNelson.Outside.OAI158.TypicalSampling
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.Space
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.continuous_eval
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.instCompactSpaceSpace
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.instMetrizableSpaceSpace
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.ofNorm
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.tendsto_iff
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.value
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.value_eval
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.value_norm
#print axioms HadwigerNelson.Outside.OAI158.WeakBall.value_ofNorm
#print axioms HadwigerNelson.Outside.OAI158.ae_density_actual
#print axioms HadwigerNelson.Outside.OAI158.ae_typicalSampling
#print axioms HadwigerNelson.Outside.OAI158.all_parameters_product_zero
#print axioms HadwigerNelson.Outside.OAI158.angularMeasure.instIsAddHaarMeasure
#print axioms HadwigerNelson.Outside.OAI158.angularSum
#print axioms HadwigerNelson.Outside.OAI158.bounded_test_error
#print axioms HadwigerNelson.Outside.OAI158.correlation_continuous
#print axioms HadwigerNelson.Outside.OAI158.densityOne_disjoint
#print axioms HadwigerNelson.Outside.OAI158.densityOne_translate
#print axioms HadwigerNelson.Outside.OAI158.direction_continuous
#print axioms HadwigerNelson.Outside.OAI158.direction_exists
#print axioms HadwigerNelson.Outside.OAI158.direction_norm
#print axioms HadwigerNelson.Outside.OAI158.direction_real
#print axioms HadwigerNelson.Outside.OAI158.exists_countable_essential_union
#print axioms HadwigerNelson.Outside.OAI158.exists_finite_weak_subseq
#print axioms HadwigerNelson.Outside.OAI158.exists_trace
#print axioms HadwigerNelson.Outside.OAI158.isClosed_traceGraph
#print axioms HadwigerNelson.Outside.OAI158.isCompact_traces
#print axioms HadwigerNelson.Outside.OAI158.liftPalette
#print axioms HadwigerNelson.Outside.OAI158.mem_palette
#print axioms HadwigerNelson.Outside.OAI158.oneL2
#print axioms HadwigerNelson.Outside.OAI158.oneL2_ae
#print axioms HadwigerNelson.Outside.OAI158.palette
#print axioms HadwigerNelson.Outside.OAI158.paletteGenerators
#print axioms HadwigerNelson.Outside.OAI158.paletteGenerators_countable
#print axioms HadwigerNelson.Outside.OAI158.paletteSet
#print axioms HadwigerNelson.Outside.OAI158.paletteSet_measurable
#print axioms HadwigerNelson.Outside.OAI158.paletteSet_minimal
#print axioms HadwigerNelson.Outside.OAI158.palette_nonempty
#print axioms HadwigerNelson.Outside.OAI158.product_zero_of_inner_zero
#print axioms HadwigerNelson.Outside.OAI158.sample
#print axioms HadwigerNelson.Outside.OAI158.sampleCode
#print axioms HadwigerNelson.Outside.OAI158.sampleFn
#print axioms HadwigerNelson.Outside.OAI158.sampleFn_le_one
#print axioms HadwigerNelson.Outside.OAI158.sampleFn_measurable
#print axioms HadwigerNelson.Outside.OAI158.sampleFn_memLp
#print axioms HadwigerNelson.Outside.OAI158.sampleFn_nonneg
#print axioms HadwigerNelson.Outside.OAI158.sampleSet
#print axioms HadwigerNelson.Outside.OAI158.sample_ae
#print axioms HadwigerNelson.Outside.OAI158.sample_norm_le
#print axioms HadwigerNelson.Outside.OAI158.sample_sum
#print axioms HadwigerNelson.Outside.OAI158.sampling_weak_compact
#print axioms HadwigerNelson.Outside.OAI158.shiftL2
#print axioms HadwigerNelson.Outside.OAI158.shiftL2_ae
#print axioms HadwigerNelson.Outside.OAI158.shiftL2_continuous
#print axioms HadwigerNelson.Outside.OAI158.sixty
#print axioms HadwigerNelson.Outside.OAI158.spatialSupport
#print axioms HadwigerNelson.Outside.OAI158.traceCode_tendsto_iff
#print axioms HadwigerNelson.Outside.OAI158.tracePositive
#print axioms HadwigerNelson.Outside.OAI158.tracePositive_le_palette
#print axioms HadwigerNelson.Outside.OAI158.tracePositive_measurable
#print axioms HadwigerNelson.Outside.OAI158.traceValue
#print axioms HadwigerNelson.Outside.OAI158.traceValue_sampleCode
#print axioms HadwigerNelson.Outside.OAI158.trace_bounds
#print axioms HadwigerNelson.Outside.OAI158.trace_limit
#print axioms HadwigerNelson.Outside.OAI158.trace_of_realization
#print axioms HadwigerNelson.Outside.OAI158.trace_realization
#print axioms HadwigerNelson.Outside.OAI158.trace_realization_weakStar
#print axioms HadwigerNelson.Outside.OAI158.transitionRatio
#print axioms HadwigerNelson.Outside.OAI158.transitionSet
#print axioms HadwigerNelson.Outside.OAI158.truncatedClass
#print axioms HadwigerNelson.Outside.OAI158.truncatedClass_finite
#print axioms HadwigerNelson.Outside.OAI158.truncatedClass_measurable
#print axioms HadwigerNelson.Outside.OAI158.truncatedVector
#print axioms HadwigerNelson.Outside.OAI158.truncatedVector_ae
#print axioms HadwigerNelson.Outside.OAI158.weakHilbert
#print axioms HadwigerNelson.Outside.OAI158.weakHilbert_apply
#print axioms HadwigerNelson.Outside.OAI158.weak_L2_to_weakStar
#print axioms HadwigerNelson.Outside.OAI158.weak_all_directions
#print axioms HadwigerNelson.Outside.OAI158.weak_density_proper
#print axioms HadwigerNelson.Outside.OAI158.weak_limit_le_one
#print axioms HadwigerNelson.Outside.OAI158.weak_limit_nonneg
#print axioms HadwigerNelson.Outside.OAI158.weak_limit_sum
-- Plane/SixRing/Confine — C132-CONFINE (FS132-K1)
#print axioms HadwigerNelson.SixRing.confine
#print axioms HadwigerNelson.SixRing.confine_of_disjoint
#print axioms HadwigerNelson.SixRing.inner_nonneg_of_subset_closedBall
#print axioms HadwigerNelson.SixRing.inner_nonpos_of_disjoint_ball
#print axioms HadwigerNelson.SixRing.mem_straddle_iff_min_max
#print axioms HadwigerNelson.SixRing.subset_closedBall_of_dist_lt
-- Plane/SixRing/Basic — the exclusion's definitions and their models (FS132-K2)
#print axioms HadwigerNelson.SixRing.HubColours
#print axioms HadwigerNelson.SixRing.HubColours.mono
#print axioms HadwigerNelson.SixRing.IsTip
#print axioms HadwigerNelson.SixRing.NoDoubleChange
#print axioms HadwigerNelson.SixRing.OutsideOrbit
#print axioms HadwigerNelson.SixRing.ShiftBounds
#print axioms HadwigerNelson.SixRing.ShiftBounds.mono
#print axioms HadwigerNelson.SixRing.chart
#print axioms HadwigerNelson.SixRing.hub
#print axioms HadwigerNelson.SixRing.ringRadius
#print axioms HadwigerNelson.SixRing.shift
#print axioms HadwigerNelson.SixRing.shiftBounds_model
-- Plane/SixRing/StepLemma — the one definition of the step lemma's module (its theorems are FS132-I3's block)
#print axioms HadwigerNelson.SixRing.IsDensityPt
-- Plane/SixRing/State — the one lemma of the palettes' module that FS132-I4's block does not hold
#print axioms HadwigerNelson.SixRing.mem_liftPalette
-- Plane/SixRing/Orbit — the structure of the four-set hypothesis (its theorems are FS132-I4's block)
#print axioms HadwigerNelson.SixRing.FourCycleStraddle
-- Plane/SixRing/Orbit — the ring form over four points (C132-WIT-EXCL), added at the landing by the brief's Amendment 1
#print axioms HadwigerNelson.SixRing.not_ae_outside_points
-- FS132-L2: end of the block

/-! ## FS124-L1 — the landing of FS-124's radius clause: the declarations of its three modules that FS124-I1's block does not hold — the four
definitions and the structure of `Plane/WeakColouringOn`. Definitions and structures are filed with the theorems, as FS132-L2's block files them.
`tools/fs124_l1_records.py` reads every declaration of the three modules as the kernel lists it: one record each, the five under IMPORTED each on
the standard three and exactly its one declared outside theorem, every other under CLEAN on a subset of the standard three -/
-- FS124-L1
#print axioms HadwigerNelson.Plane.rigidMotion
#print axioms HadwigerNelson.Plane.motionMul
#print axioms HadwigerNelson.Plane.monoPairSet
#print axioms HadwigerNelson.Plane.AeProperOn
#print axioms HadwigerNelson.Plane.IsWeakColouringOn
-- FS124-L1: end of the block

/-! ## FS124-L2 — the landing of FS-124's second module: what an open piece of one label forces one unit away (C124-SHADOW-OPEN, -TYPE,
-CENTRE-HALF, -CENTRE, -STRADDLE: `Plane/CircleCrossing`, `Plane/OnePiece`), what a close complementary pair forces at a common unit point
(C124-FORCED-PIECES, -LONE, -BOTH, -FOUR: `Plane/ThreePiece`, `Plane/ClosePair`), the witnesses of those statements' hypotheses
(`Plane/ClosePairWitness`, `Plane/ClosePairModel`), the three-arcs lemma (`Plane/ThreeArcs`) and the claim list's sector point over it
(`Plane/SectorPoint`).  Planned by FS124-K2 and FS124-K3, proved by FS124-I2, -I3, -I4 and -I5.  Every declaration a person typed in the
eight modules has one record here — theorems, definitions and structures, as FS124-L1's block and FS132-L2's file theirs — and every
record is CLEAN: none of the eight modules reads a declared outside theorem.  `tools/fs124_l2_records.py` reads the kernel's list of the
eight modules against the audit's log: one record each, under CLEAN, on a subset of the standard three. -/
-- FS124-L2 block: FS-124's second module, the eight modules of the landing — 405 records (340 theorems, 56 definitions, 9 structures and inductive types), every
-- declaration a person typed, one line each (the kernel's list: data/fs124/l2/decls.lean; this block is
-- `tools/fs124_l2_records.py DECLS --block`).  Statements FS124-K2's and FS124-K3's; proofs FS124-I2's
-- (CircleCrossing, OnePiece), FS124-I3's (ThreePiece, ClosePair), FS124-I4's (ClosePairWitness,
-- ClosePairModel, SectorPoint) and FS124-I5's (ThreeArcs); the bridge's two lines FS124-K3's.  Every record
-- CLEAN: no declared outside theorem is read by any of the eight modules.
-- FS124-L2: Plane/CircleCrossing (38)
#print axioms HadwigerNelson.Plane.CircleSide
#print axioms HadwigerNelson.Plane.CircleSide.abs_sign
#print axioms HadwigerNelson.Plane.CircleSide.ball_antipode_subset_outside
#print axioms HadwigerNelson.Plane.CircleSide.disjoint_region_flip
#print axioms HadwigerNelson.Plane.CircleSide.flip
#print axioms HadwigerNelson.Plane.CircleSide.flip_flip
#print axioms HadwigerNelson.Plane.CircleSide.flip_inside
#print axioms HadwigerNelson.Plane.CircleSide.flip_outside
#print axioms HadwigerNelson.Plane.CircleSide.isOpen_region
#print axioms HadwigerNelson.Plane.CircleSide.mem_region_comm
#print axioms HadwigerNelson.Plane.CircleSide.mem_region_iff
#print axioms HadwigerNelson.Plane.CircleSide.mem_region_inside
#print axioms HadwigerNelson.Plane.CircleSide.mem_region_or_of_dist_ne
#print axioms HadwigerNelson.Plane.CircleSide.mem_region_outside
#print axioms HadwigerNelson.Plane.CircleSide.region
#print axioms HadwigerNelson.Plane.CircleSide.sign
#print axioms HadwigerNelson.Plane.CircleSide.sign_eq
#print axioms HadwigerNelson.Plane.CrossAt
#print axioms HadwigerNelson.Plane.CrossAt.abs_inner_lt_one
#print axioms HadwigerNelson.Plane.CrossAt.antipode
#print axioms HadwigerNelson.Plane.CrossAt.exists_mem_quadrant
#print axioms HadwigerNelson.Plane.CrossAt.exists_mem_sphere_inside
#print axioms HadwigerNelson.Plane.CrossAt.exists_mem_sphere_region
#print axioms HadwigerNelson.Plane.CrossAt.quadPt_mem_region_left
#print axioms HadwigerNelson.Plane.CrossAt.quadPt_mem_region_right
#print axioms HadwigerNelson.Plane.CrossAt.symm
#print axioms HadwigerNelson.Plane.CrossAt.volume_quadrant_pos
#print axioms HadwigerNelson.Plane.abs_real_inner_lt_one
#print axioms HadwigerNelson.Plane.crossAt_of_dist_lt_two
#print axioms HadwigerNelson.Plane.crossAt_zero_one_add_I
#print axioms HadwigerNelson.Plane.dist_quadPt_le
#print axioms HadwigerNelson.Plane.exists_ball_inter_spheres_subset
#print axioms HadwigerNelson.Plane.exists_convex_subset_region
#print axioms HadwigerNelson.Plane.exists_dist_ne_of_isOpen
#print axioms HadwigerNelson.Plane.instDecidableEqCircleSide
#print axioms HadwigerNelson.Plane.norm_sq_quadrant
#print axioms HadwigerNelson.Plane.quadPt
#print axioms HadwigerNelson.Plane.quadrant_sign_pos
-- FS124-L2: Plane/OnePiece (60)
#print axioms HadwigerNelson.Plane.AeProperOn.ae_ne_of_ae_region
#print axioms HadwigerNelson.Plane.AeProperOn.ae_unitShadow_ne
#print axioms HadwigerNelson.Plane.CrossingAt
#print axioms HadwigerNelson.Plane.InnerAt
#print axioms HadwigerNelson.Plane.InnerAt.closure_inter_closure_subset
#print axioms HadwigerNelson.Plane.IsPieceAt
#print axioms HadwigerNelson.Plane.IsPieceAt.ae_ne_of_crossingAt
#print axioms HadwigerNelson.Plane.IsPieceAt.ae_ne_region
#print axioms HadwigerNelson.Plane.IsPieceAt.ae_unitShadow_ne
#print axioms HadwigerNelson.Plane.IsPieceAt.disjoint
#print axioms HadwigerNelson.Plane.IsPieceAt.innerAt_self
#print axioms HadwigerNelson.Plane.IsPieceAt.inter_eq_empty
#print axioms HadwigerNelson.Plane.IsPieceAt.isConnected
#print axioms HadwigerNelson.Plane.IsPieceAt.nonempty
#print axioms HadwigerNelson.Plane.IsTight
#print axioms HadwigerNelson.Plane.IsTight.ae_ne_centre
#print axioms HadwigerNelson.Plane.IsTight.ae_ne_straddle
#print axioms HadwigerNelson.Plane.IsTightWith
#print axioms HadwigerNelson.Plane.IsTightWith.ae_innerCollar
#print axioms HadwigerNelson.Plane.IsTightWith.ae_outerCollar
#print axioms HadwigerNelson.Plane.IsTightWith.mem
#print axioms HadwigerNelson.Plane.IsTightWith.mono
#print axioms HadwigerNelson.Plane.OnSide
#print axioms HadwigerNelson.Plane.OnSide.subset_region
#print axioms HadwigerNelson.Plane.OuterAt
#print axioms HadwigerNelson.Plane.centre_half
#print axioms HadwigerNelson.Plane.crossingAt_iff
#print axioms HadwigerNelson.Plane.eq_empty_of_isOpen_of_ae
#print axioms HadwigerNelson.Plane.innerAt_or_outerAt_or_crossingAt
#print axioms HadwigerNelson.Plane.innerCollar
#print axioms HadwigerNelson.Plane.isOpen_innerCollar
#print axioms HadwigerNelson.Plane.isOpen_outerCollar
#print axioms HadwigerNelson.Plane.isOpen_tightModelDom
#print axioms HadwigerNelson.Plane.isOpen_unitShadow
#print axioms HadwigerNelson.Plane.isTight_of_ae_of_isOpen
#print axioms HadwigerNelson.Plane.isTight_tightModel
#print axioms HadwigerNelson.Plane.isWeakColouringOn_tightModel
#print axioms HadwigerNelson.Plane.measurable_tightModel
#print axioms HadwigerNelson.Plane.mem_unitShadow_iff_exists_e
#print axioms HadwigerNelson.Plane.mem_unitShadow_of_isPreconnected
#print axioms HadwigerNelson.Plane.not_innerAt_and_outerAt
#print axioms HadwigerNelson.Plane.not_innerAt_iff
#print axioms HadwigerNelson.Plane.not_onSide_iff
#print axioms HadwigerNelson.Plane.not_outerAt_iff
#print axioms HadwigerNelson.Plane.onSide_inside
#print axioms HadwigerNelson.Plane.onSide_of_subset_region
#print axioms HadwigerNelson.Plane.onSide_outside
#print axioms HadwigerNelson.Plane.outerCollar
#print axioms HadwigerNelson.Plane.piece_type
#print axioms HadwigerNelson.Plane.shadow_open
#print axioms HadwigerNelson.Plane.tightModel
#print axioms HadwigerNelson.Plane.tightModelDom
#print axioms HadwigerNelson.Plane.tightModel_eq_two_of_mem
#print axioms HadwigerNelson.Plane.tightModel_far
#print axioms HadwigerNelson.Plane.tightModel_ne_two_of_lt
#print axioms HadwigerNelson.Plane.tightModel_ne_two_of_mem
#print axioms HadwigerNelson.Plane.tightModel_of_not_lt
#print axioms HadwigerNelson.Plane.tight_centre
#print axioms HadwigerNelson.Plane.tight_straddle
#print axioms HadwigerNelson.Plane.unitShadow_mono
-- FS124-L2: Plane/ThreePiece (72)
#print axioms HadwigerNelson.Plane.HasUnitArcFrom
#print axioms HadwigerNelson.Plane.HasUnitArcFrom.mem
#print axioms HadwigerNelson.Plane.HasUnitArcFrom.mem_closure_diff
#print axioms HadwigerNelson.Plane.IsThreePiecePoint
#print axioms HadwigerNelson.Plane.ThreePiece
#print axioms HadwigerNelson.Plane.ThreePiece.HasArcEdges
#print axioms HadwigerNelson.Plane.ThreePiece.HasArcEdges.isFull
#print axioms HadwigerNelson.Plane.ThreePiece.IsFull
#print axioms HadwigerNelson.Plane.ThreePiece.OneOfEach
#print axioms HadwigerNelson.Plane.ThreePiece.OneOfEach.eq_of_innerAt
#print axioms HadwigerNelson.Plane.ThreePiece.OneOfEach.eq_of_outerAt
#print axioms HadwigerNelson.Plane.ThreePiece.OneOfEach.separatesAt
#print axioms HadwigerNelson.Plane.ThreePiece.Saves
#print axioms HadwigerNelson.Plane.ThreePiece.SeparatesAt
#print axioms HadwigerNelson.Plane.ThreePiece.ae_label_of_forall_onSide
#print axioms HadwigerNelson.Plane.ThreePiece.ae_mem_piece
#print axioms HadwigerNelson.Plane.ThreePiece.disjoint_piece
#print axioms HadwigerNelson.Plane.ThreePiece.edge
#print axioms HadwigerNelson.Plane.ThreePiece.edge_comm
#print axioms HadwigerNelson.Plane.ThreePiece.edge_subset_sphere
#print axioms HadwigerNelson.Plane.ThreePiece.hasUnitArcFrom_of_arc_subset_sphere
#print axioms HadwigerNelson.Plane.ThreePiece.isConnected_piece
#print axioms HadwigerNelson.Plane.ThreePiece.isPieceAt
#print axioms HadwigerNelson.Plane.ThreePiece.mem
#print axioms HadwigerNelson.Plane.ThreePiece.mem_edge
#print axioms HadwigerNelson.Plane.ThreePiece.not_separatesAt_iff
#print axioms HadwigerNelson.Plane.combo_lt
#print axioms HadwigerNelson.Plane.convex_petalSet_one
#print axioms HadwigerNelson.Plane.convex_petalSet_two
#print axioms HadwigerNelson.Plane.convex_sectorSet
#print axioms HadwigerNelson.Plane.convex_setOf_abs_re_lt_mul_im
#print axioms HadwigerNelson.Plane.convex_setOf_lt_mul_re
#print axioms HadwigerNelson.Plane.exists_arc_of_ray_subset
#print axioms HadwigerNelson.Plane.fin_three_cases
#print axioms HadwigerNelson.Plane.isOpen_petalSet
#print axioms HadwigerNelson.Plane.isOpen_sectorSet
#print axioms HadwigerNelson.Plane.isPreconnected_petalSea
#print axioms HadwigerNelson.Plane.isWeakColouringOn_ball_quarter
#print axioms HadwigerNelson.Plane.measurable_petalCol
#print axioms HadwigerNelson.Plane.measurable_sectorCol
#print axioms HadwigerNelson.Plane.mem_ball_zero_of_abs_re_add_abs_im_lt
#print axioms HadwigerNelson.Plane.mem_ball_zero_of_sq_lt
#print axioms HadwigerNelson.Plane.mem_closure_inter_ball
#print axioms HadwigerNelson.Plane.mem_closure_of_forall_add_ofReal_mul_mem
#print axioms HadwigerNelson.Plane.mem_closure_sectorSet_one
#print axioms HadwigerNelson.Plane.mem_closure_sectorSet_two
#print axioms HadwigerNelson.Plane.mem_closure_sectorSet_zero
#print axioms HadwigerNelson.Plane.mem_petalSet_one
#print axioms HadwigerNelson.Plane.mem_petalSet_two
#print axioms HadwigerNelson.Plane.mem_petalSet_zero
#print axioms HadwigerNelson.Plane.mem_sectorPoint_edge
#print axioms HadwigerNelson.Plane.mem_sectorSet_one
#print axioms HadwigerNelson.Plane.mem_sectorSet_two
#print axioms HadwigerNelson.Plane.mem_sectorSet_zero
#print axioms HadwigerNelson.Plane.ofReal_mul_mem_ball_quarter
#print axioms HadwigerNelson.Plane.petalCol
#print axioms HadwigerNelson.Plane.petalCol_of_mem
#print axioms HadwigerNelson.Plane.petalPoint
#print axioms HadwigerNelson.Plane.petalPoint_edge
#print axioms HadwigerNelson.Plane.petalPoint_not_isFull
#print axioms HadwigerNelson.Plane.petalSet
#print axioms HadwigerNelson.Plane.sectorCol
#print axioms HadwigerNelson.Plane.sectorCol_of_mem
#print axioms HadwigerNelson.Plane.sectorPoint
#print axioms HadwigerNelson.Plane.sectorPoint_hasArcEdges
#print axioms HadwigerNelson.Plane.sectorPoint_isFull
#print axioms HadwigerNelson.Plane.sectorSet
#print axioms HadwigerNelson.Plane.volume_ball_diff_iUnion_petalSet
#print axioms HadwigerNelson.Plane.volume_ball_diff_iUnion_sectorSet
#print axioms HadwigerNelson.Plane.volume_setOf_re_im_eq
#print axioms HadwigerNelson.Plane.zero_mem_closure_petalSet
#print axioms HadwigerNelson.Plane.zero_mem_closure_sectorSet
-- FS124-L2: Plane/ClosePair (35)
#print axioms HadwigerNelson.Plane.ClosePair
#print axioms HadwigerNelson.Plane.ClosePair.crossAt
#print axioms HadwigerNelson.Plane.ClosePair.exists_label_eq
#print axioms HadwigerNelson.Plane.ClosePair.label_mem_presentAt_of_isFull_right
#print axioms HadwigerNelson.Plane.ClosePair.lone_of_cover
#print axioms HadwigerNelson.Plane.ClosePair.ncard_inner_outer
#print axioms HadwigerNelson.Plane.ClosePair.presentAt_eq
#print axioms HadwigerNelson.Plane.ClosePair.separatesAt_or
#print axioms HadwigerNelson.Plane.ClosePair.separatesAt_right_of_isFull
#print axioms HadwigerNelson.Plane.ClosePair.symm
#print axioms HadwigerNelson.Plane.IsCommonUnitPoint
#print axioms HadwigerNelson.Plane.IsCommonUnitPoint.symm
#print axioms HadwigerNelson.Plane.IsTight.closure_inter_closure_eq
#print axioms HadwigerNelson.Plane.ThreePiece.HasArcEdges.saves_of_separatesAt
#print axioms HadwigerNelson.Plane.ThreePiece.exists_ne_not_onSide_of_ae_side
#print axioms HadwigerNelson.Plane.ThreePiece.exists_second_unit_point_of_ae_side
#print axioms HadwigerNelson.Plane.ThreePiece.not_isFull_of_ae_side
#print axioms HadwigerNelson.Plane.ae_label_left_of_forall_not_onSide
#print axioms HadwigerNelson.Plane.ae_onSide_of_label
#print axioms HadwigerNelson.Plane.closePair_both_saved
#print axioms HadwigerNelson.Plane.closePair_both_separate
#print axioms HadwigerNelson.Plane.closePair_forced_pieces
#print axioms HadwigerNelson.Plane.closePair_four
#print axioms HadwigerNelson.Plane.closePair_lone
#print axioms HadwigerNelson.Plane.exists_inner_outer_of_cover
#print axioms HadwigerNelson.Plane.exists_isCommonUnitPoint
#print axioms HadwigerNelson.Plane.exists_isTight_of_ae_side
#print axioms HadwigerNelson.Plane.exists_onSide_of_cover
#print axioms HadwigerNelson.Plane.exists_perm_fin_three
#print axioms HadwigerNelson.Plane.mem_presentAt_iff
#print axioms HadwigerNelson.Plane.mem_presentAt_of_ae_eq
#print axioms HadwigerNelson.Plane.not_mem_presentAt_iff
#print axioms HadwigerNelson.Plane.not_mem_presentAt_of_ae_ne
#print axioms HadwigerNelson.Plane.presentAt
#print axioms HadwigerNelson.Plane.presentAt_nonempty
-- FS124-L2: Plane/ClosePairWitness (136)
#print axioms HadwigerNelson.Plane.ThreePiece.ArcCut
#print axioms HadwigerNelson.Plane.ThreePiece.ArcCut.of_image
#print axioms HadwigerNelson.Plane.ThreePiece.ArcCut.sector
#print axioms HadwigerNelson.Plane.ThreePiece.HasArcEdges.of_image
#print axioms HadwigerNelson.Plane.ThreePiece.arcCut_of_radii
#print axioms HadwigerNelson.Plane.ThreePiece.edge_eq_image
#print axioms HadwigerNelson.Plane.ThreePiece.exists_eq_connectedComponentIn
#print axioms HadwigerNelson.Plane.ThreePiece.oneOfEach_iff_of_image
#print axioms HadwigerNelson.Plane.ThreePiece.separatesAt_iff_of_image
#print axioms HadwigerNelson.Plane.ThreePiece.transport
#print axioms HadwigerNelson.Plane.ThreePiece.transport_label
#print axioms HadwigerNelson.Plane.ThreePiece.transport_nbhd
#print axioms HadwigerNelson.Plane.ThreePiece.transport_piece
#print axioms HadwigerNelson.Plane.abs_re_sub_one_im_of_mem_ball_one
#print axioms HadwigerNelson.Plane.continuous_splitArc
#print axioms HadwigerNelson.Plane.dist_le_one_iff
#print axioms HadwigerNelson.Plane.dist_lt_one_iff
#print axioms HadwigerNelson.Plane.dist_one_add_I_zero_lt_two
#print axioms HadwigerNelson.Plane.dist_one_sub_I_one_add_I
#print axioms HadwigerNelson.Plane.dist_one_sub_I_zero_lt_two
#print axioms HadwigerNelson.Plane.dist_planeMotion
#print axioms HadwigerNelson.Plane.dist_planeMotion_symm
#print axioms HadwigerNelson.Plane.dist_splitArc_one
#print axioms HadwigerNelson.Plane.dist_splitArc_zero
#print axioms HadwigerNelson.Plane.dist_sq_eq
#print axioms HadwigerNelson.Plane.dist_zero_sq_eq
#print axioms HadwigerNelson.Plane.half_le_dist_one_add_I_one
#print axioms HadwigerNelson.Plane.half_le_dist_one_add_I_zero
#print axioms HadwigerNelson.Plane.half_le_dist_one_sub_I_one
#print axioms HadwigerNelson.Plane.half_le_dist_one_sub_I_zero
#print axioms HadwigerNelson.Plane.innerAt_image_iff
#print axioms HadwigerNelson.Plane.isCommonUnitPoint_zero_one_add_I
#print axioms HadwigerNelson.Plane.isCommonUnitPoint_zero_one_sub_I
#print axioms HadwigerNelson.Plane.isOpen_splitSet
#print axioms HadwigerNelson.Plane.isOpen_threeDisc
#print axioms HadwigerNelson.Plane.isPreconnected_splitOuter
#print axioms HadwigerNelson.Plane.isWeakColouringOn_loneCol
#print axioms HadwigerNelson.Plane.isWeakColouringOn_pairCol
#print axioms HadwigerNelson.Plane.isWeakColouringOn_sevenCol
#print axioms HadwigerNelson.Plane.isWeakColouringOn_squareCol
#print axioms HadwigerNelson.Plane.labHi
#print axioms HadwigerNelson.Plane.labHi_injective
#print axioms HadwigerNelson.Plane.labLo
#print axioms HadwigerNelson.Plane.labLo_injective
#print axioms HadwigerNelson.Plane.labLo_ne_labHi
#print axioms HadwigerNelson.Plane.loneCol
#print axioms HadwigerNelson.Plane.lonePair
#print axioms HadwigerNelson.Plane.lonePair_right_not_separatesAt
#print axioms HadwigerNelson.Plane.loneW
#print axioms HadwigerNelson.Plane.measurable_splitCol
#print axioms HadwigerNelson.Plane.measurable_squareW
#print axioms HadwigerNelson.Plane.measurable_threeDiscCol
#print axioms HadwigerNelson.Plane.measurePreserving_planeMotion_symm
#print axioms HadwigerNelson.Plane.mem_closure_splitSet_one
#print axioms HadwigerNelson.Plane.mem_closure_splitSet_two
#print axioms HadwigerNelson.Plane.mem_closure_splitSet_zero
#print axioms HadwigerNelson.Plane.mem_splitPoint_edge
#print axioms HadwigerNelson.Plane.mem_splitSet_one
#print axioms HadwigerNelson.Plane.mem_splitSet_two
#print axioms HadwigerNelson.Plane.mem_splitSet_zero
#print axioms HadwigerNelson.Plane.norm_sectorDir
#print axioms HadwigerNelson.Plane.one_le_dist_iff
#print axioms HadwigerNelson.Plane.one_lt_dist_iff
#print axioms HadwigerNelson.Plane.one_lt_dist_of_dist_lt_one
#print axioms HadwigerNelson.Plane.one_mem_threeDisc
#print axioms HadwigerNelson.Plane.outerAt_image_iff
#print axioms HadwigerNelson.Plane.pairCol
#print axioms HadwigerNelson.Plane.petalCol_eq_one
#print axioms HadwigerNelson.Plane.petalCol_eq_two
#print axioms HadwigerNelson.Plane.petal_inner_lt
#print axioms HadwigerNelson.Plane.petal_outer_gt
#print axioms HadwigerNelson.Plane.planeMotion
#print axioms HadwigerNelson.Plane.planeMotion_apply
#print axioms HadwigerNelson.Plane.planeMotion_mem_ball
#print axioms HadwigerNelson.Plane.planeMotion_symm_apply
#print axioms HadwigerNelson.Plane.planeMotion_symm_mem_ball
#print axioms HadwigerNelson.Plane.quarterTurn_one
#print axioms HadwigerNelson.Plane.quarterTurn_symm_one
#print axioms HadwigerNelson.Plane.quarterTurn_symm_right
#print axioms HadwigerNelson.Plane.quarterTurn_symm_zero
#print axioms HadwigerNelson.Plane.re_im_of_mem_ball_one
#print axioms HadwigerNelson.Plane.re_im_of_mem_ball_zero
#print axioms HadwigerNelson.Plane.sectorDir
#print axioms HadwigerNelson.Plane.sectorPoint_arcCut
#print axioms HadwigerNelson.Plane.sectorPoint_not_separatesAt_neg_I
#print axioms HadwigerNelson.Plane.sectorPoint_not_separatesAt_one
#print axioms HadwigerNelson.Plane.sevenCol
#print axioms HadwigerNelson.Plane.sevenPair
#print axioms HadwigerNelson.Plane.sevenPair_left_not_separatesAt
#print axioms HadwigerNelson.Plane.sevenPair_right_not_separatesAt
#print axioms HadwigerNelson.Plane.splitArc
#print axioms HadwigerNelson.Plane.splitArc_im_nonpos
#print axioms HadwigerNelson.Plane.splitArc_mem_edge
#print axioms HadwigerNelson.Plane.splitArc_sq
#print axioms HadwigerNelson.Plane.splitCol
#print axioms HadwigerNelson.Plane.splitCol_eq_one
#print axioms HadwigerNelson.Plane.splitCol_eq_zero
#print axioms HadwigerNelson.Plane.splitCol_of_mem
#print axioms HadwigerNelson.Plane.splitPoint
#print axioms HadwigerNelson.Plane.splitPoint_arcCut
#print axioms HadwigerNelson.Plane.splitPoint_hasArcEdges
#print axioms HadwigerNelson.Plane.splitPoint_oneOfEach
#print axioms HadwigerNelson.Plane.splitRadius
#print axioms HadwigerNelson.Plane.splitSet
#print axioms HadwigerNelson.Plane.split_inner_dist_lt
#print axioms HadwigerNelson.Plane.split_inner_lt
#print axioms HadwigerNelson.Plane.split_outer_dist_gt
#print axioms HadwigerNelson.Plane.split_outer_gt
#print axioms HadwigerNelson.Plane.sq_lt_of_mem_ball_zero
#print axioms HadwigerNelson.Plane.sqrt_two_div_two_sq
#print axioms HadwigerNelson.Plane.squareCol
#print axioms HadwigerNelson.Plane.squarePair
#print axioms HadwigerNelson.Plane.squarePair_left_arcCut
#print axioms HadwigerNelson.Plane.squarePair_left_hasArcEdges
#print axioms HadwigerNelson.Plane.squarePair_left_oneOfEach
#print axioms HadwigerNelson.Plane.squarePair_right_arcCut
#print axioms HadwigerNelson.Plane.squarePair_right_hasArcEdges
#print axioms HadwigerNelson.Plane.squarePair_right_oneOfEach
#print axioms HadwigerNelson.Plane.squareW
#print axioms HadwigerNelson.Plane.threeDisc
#print axioms HadwigerNelson.Plane.threeDiscCol
#print axioms HadwigerNelson.Plane.threeDiscCol_of_mem_one
#print axioms HadwigerNelson.Plane.threeDiscCol_of_mem_right
#print axioms HadwigerNelson.Plane.threeDiscCol_of_mem_zero
#print axioms HadwigerNelson.Plane.threeDiscPair
#print axioms HadwigerNelson.Plane.threeDiscPair_left_hasArcEdges
#print axioms HadwigerNelson.Plane.threeDiscPair_left_oneOfEach_iff
#print axioms HadwigerNelson.Plane.threeDiscPair_left_piece
#print axioms HadwigerNelson.Plane.threeDiscPair_left_separatesAt_iff
#print axioms HadwigerNelson.Plane.threeDiscPair_right_hasArcEdges
#print axioms HadwigerNelson.Plane.threeDiscPair_right_oneOfEach_iff
#print axioms HadwigerNelson.Plane.threeDiscPair_right_piece
#print axioms HadwigerNelson.Plane.threeDiscPair_right_separatesAt_iff
#print axioms HadwigerNelson.Plane.threeDisc_aeProperOn
#print axioms HadwigerNelson.Plane.volume_ball_diff_iUnion_splitSet
#print axioms HadwigerNelson.Plane.zero_mem_closure_splitSet
-- FS124-L2: Plane/ClosePairModel (3)
#print axioms HadwigerNelson.Plane.exists_closePair_full
#print axioms HadwigerNelson.Plane.exists_closePair_not_separatesAt
#print axioms HadwigerNelson.Plane.exists_closePair_seven_not_separatesAt
-- FS124-L2: Plane/ThreeArcs (55)
#print axioms HadwigerNelson.Plane.IsTriod
#print axioms HadwigerNelson.Plane.IsTriod.apply_mem_ball
#print axioms HadwigerNelson.Plane.IsTriod.apply_mem_closedBall
#print axioms HadwigerNelson.Plane.IsTriod.apply_one_eq_polarPt
#print axioms HadwigerNelson.Plane.IsTriod.apply_one_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.apply_one_ne
#print axioms HadwigerNelson.Plane.IsTriod.eq_apply_one_of_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.eq_one_of_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.exists_rimOrder
#print axioms HadwigerNelson.Plane.IsTriod.isPreconnected_iUnion_range
#print axioms HadwigerNelson.Plane.IsTriod.isPreconnected_image_Icc
#print axioms HadwigerNelson.Plane.IsTriod.isPreconnected_range_union_range
#print axioms HadwigerNelson.Plane.IsTriod.notMem_iUnion_range_of_mem_Ioo
#print axioms HadwigerNelson.Plane.IsTriod.not_mem_closure_both_sides
#print axioms HadwigerNelson.Plane.IsTriod.polarPt_mem_sphere
#print axioms HadwigerNelson.Plane.IsTriod.range_subset_of_isPreconnected
#print axioms HadwigerNelson.Plane.IsTriodCut
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_inter_closure_inter_ball
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_inter_closure_subset
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_inter_nonempty
#print axioms HadwigerNelson.Plane.IsTriodCut.closure_piece_subset_closedBall
#print axioms HadwigerNelson.Plane.IsTriodCut.disjoint_iUnion_range
#print axioms HadwigerNelson.Plane.IsTriodCut.disjoint_range_union_range
#print axioms HadwigerNelson.Plane.IsTriodCut.eq_of_mem_of_mem_closure
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_arc
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_forall_rimArc
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_mem_piece
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_opposite
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_range_subset
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_rimPieces
#print axioms HadwigerNelson.Plane.IsTriodCut.exists_unique_mem_closure
#print axioms HadwigerNelson.Plane.IsTriodCut.isPreconnected_closure_inter
#print axioms HadwigerNelson.Plane.IsTriodCut.mem_closure
#print axioms HadwigerNelson.Plane.IsTriodCut.mem_diff_of_mem
#print axioms HadwigerNelson.Plane.IsTriodCut.ne_of_rimOrder
#print axioms HadwigerNelson.Plane.IsTriodCut.piece_subset_ball
#print axioms HadwigerNelson.Plane.IsTriodCut.rimPiece_spec
#print axioms HadwigerNelson.Plane.RimOrder
#print axioms HadwigerNelson.Plane.RimOrder.eq_or
#print axioms HadwigerNelson.Plane.RimOrder.rotate
#print axioms HadwigerNelson.Plane.ballRetract
#print axioms HadwigerNelson.Plane.ballRetract_mem
#print axioms HadwigerNelson.Plane.ballRetract_of_mem
#print axioms HadwigerNelson.Plane.ballRetract_of_mem_segment
#print axioms HadwigerNelson.Plane.ballRetract_one
#print axioms HadwigerNelson.Plane.continuous_ballRetract
#print axioms HadwigerNelson.Plane.exists_arc_range_subset_inter
#print axioms HadwigerNelson.Plane.exists_ne_ne_fin_three
#print axioms HadwigerNelson.Plane.fin_three_add_one_ne
#print axioms HadwigerNelson.Plane.fin_three_eq_or_of_ne
#print axioms HadwigerNelson.Plane.isClosed_iUnion_range_arc
#print axioms HadwigerNelson.Plane.isPreconnected_inter_halves
#print axioms HadwigerNelson.Plane.isPreconnected_inter_of_union_eq_closedBall
#print axioms HadwigerNelson.Plane.isPreconnected_preimage_ballRetract
#print axioms HadwigerNelson.Plane.polarPt_add_turn
-- FS124-L2: Plane/SectorPoint (6)
#print axioms HadwigerNelson.Plane.ThreePiece.IsSector
#print axioms HadwigerNelson.Plane.ThreePiece.IsSector.hasArcEdges
#print axioms HadwigerNelson.Plane.ThreePiece.IsSector.isFull
#print axioms HadwigerNelson.Plane.closePair_both_saved_of_isSector
#print axioms HadwigerNelson.Plane.exists_closePair_sector
#print axioms HadwigerNelson.Plane.sectorPoint_isSector
-- FS124-L2 block end

/-! ## FS131-LC1 — the landing of FS-131's measurable number (claims NF3): `Plane/LebesgueNumber`, FS131-KC1's module — `[Davies2026]`
Lemma B.1 (p. 44) formalized with its printed proof, the density-point step, `Plane.chiLebesgue` (the Lebesgue-measurable chromatic
number of the plane) and `chiM0 = chiLebesgue`.  The mathematics is other people's; statements and proofs are FS131-KC1's.  Every
declaration a person typed in the module has one record — theorems and definitions, as the last three landings' blocks file theirs:
thirty-one here, under CLEAN, and the three that rest on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`
(`colorable_iff_exists_nullMeasurable_proper`, `chromaticNumber_plane_eq_chiLebesgue`, `chromaticNumber_euclidean_plane_eq_chiLebesgue`)
under IMPORTED, above.  `data/fs131/lc1/records.py` reads the kernel's list of the module against the audit's log: one record each, the
three under IMPORTED on the standard three and exactly that one import, every other under CLEAN on a subset of the standard three. -/
-- FS131-LC1 block: `Plane/LebesgueNumber` — 31 records (28 theorems, 3 definitions), every
-- declaration a person typed that rests on no declared outside theorem, one line each (the kernel's list:
-- data/fs131/lc1/decls.lean; this block is `data/fs131/lc1/records.py DECLS --block`).  Statements and proofs
-- FS131-KC1's.  The module's other three declarations are under IMPORTED, on `proper_to_borel_weak`.
#print axioms HadwigerNelson.HasDensityOneAt
#print axioms HadwigerNelson.HasDensityOneAt.inter
#print axioms HadwigerNelson.HasDensityOneAt.nonempty
#print axioms HadwigerNelson.Plane.AeColouring.col_eq_of_mem_core
#print axioms HadwigerNelson.Plane.AeColouring.core
#print axioms HadwigerNelson.Plane.AeColouring.core_dist_ne_one
#print axioms HadwigerNelson.Plane.AeColouring.measurableSet_core
#print axioms HadwigerNelson.Plane.AeColouring.volume_compl_iUnion_core
#print axioms HadwigerNelson.Plane.chiLebesgue
#print axioms HadwigerNelson.Plane.chiLebesgue_le
#print axioms HadwigerNelson.Plane.chiLebesgue_le_chiM
#print axioms HadwigerNelson.Plane.chiLebesgue_le_chiM0
#print axioms HadwigerNelson.Plane.chiM0_eq_chiLebesgue
#print axioms HadwigerNelson.Plane.chiM0_le_chiLebesgue
#print axioms HadwigerNelson.Plane.chromaticNumber_plane_le_chiLebesgue
#print axioms HadwigerNelson.Plane.davies_lemma_B1
#print axioms HadwigerNelson.Plane.exists_aeColouring_of_nullMeasurable_proper
#print axioms HadwigerNelson.Plane.exists_proper_of_aeColouring
#print axioms HadwigerNelson.Plane.exists_proper_of_nullMeasurable_weak
#print axioms HadwigerNelson.Plane.mem_densitySet_iff_hasDensityOneAt
#print axioms HadwigerNelson.Plane.nonempty_aeColouring_iff_exists_nullMeasurable_proper
#print axioms HadwigerNelson.Plane.nullMeasurable_iff_forall_fibre
#print axioms HadwigerNelson.ae_hasDensityOneAt_fibre
#print axioms HadwigerNelson.davies_lemma_B1_euclidean
#print axioms HadwigerNelson.exists_nullMeasurable_selector
#print axioms HadwigerNelson.exists_proper_ae_eq_of_proper_on_conull
#print axioms HadwigerNelson.exists_proper_nullMeasurable_of_avoiding_cover
#print axioms HadwigerNelson.exists_translate_mem
#print axioms HadwigerNelson.hasDensityOneAt_congr_ae
#print axioms HadwigerNelson.hasDensityOneAt_preimage_add_right
#print axioms HadwigerNelson.hasDensityOneAt_univ
-- FS131-LC1 block end

/-! ## FS131-LU1 — FS-131's first number-field module, the residue upper half and the values it closes (NF1; statements FS131-KN2's)

Fifty-two records: every public declaration a person typed in `Arith/UpperHalf`, `Arith/QuadraticPrime` and `Instances/UpperHalfValues`,
in each file's order — theorems and definitions, as the last four landings' blocks file theirs (the kernel's list:
`data/fs131/lu1/decls.lean`; the lines are FS131-IV1's block, `data/fs131/iv1/audit-block.txt`, made from the compiled modules).  The
files' sixteen private helpers are not nameable here; each is read by a record below.  **Every record under CLEAN**: none of the three
modules reads a declared outside theorem.  One of them takes declared hypotheses — `chromaticNumber_eq_localBound_of_chain`, the chain's
headline with its hypothesis `hUpper` discharged: its nine other hypotheses are the assumptions step's (`scripts/Assumptions.lean`), and
they do not show here.  `data/fs131/lu1/lu1_records.py` reads the kernel's list of the three modules against the audit's log: one record
each, under CLEAN, on exactly the standard three; over the whole log the records under IMPORTED are the twenty-six the last landing left. -/
-- FS131-LU1 block: `Arith/UpperHalf` — 30 records (27 theorems, 3 definitions); the twelve leaves' proofs FS131-IU1's
#print axioms HadwigerNelson.UpperHalf.nonempty_hom_unitQuadrance
#print axioms HadwigerNelson.UpperHalf.nonempty_hom_finitePlane
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_unitQuadrance
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_finitePlane
#print axioms HadwigerNelson.UpperHalf.colorable_planeOver_of_finitePlane
#print axioms HadwigerNelson.SpectralChain.StablePrime.heightOne
#print axioms HadwigerNelson.UpperHalf.heightOne_asIdeal
#print axioms HadwigerNelson.SpectralChain.StablePrime.localRing
#print axioms HadwigerNelson.UpperHalf.mem_localRing
#print axioms HadwigerNelson.UpperHalf.coe_conjO
#print axioms HadwigerNelson.UpperHalf.conjO_conjO
#print axioms HadwigerNelson.UpperHalf.conjO_mem_iff
#print axioms HadwigerNelson.UpperHalf.conj_mem_localRing
#print axioms HadwigerNelson.UpperHalf.mem_localRing_of_mul_conj_eq_one
#print axioms HadwigerNelson.UpperHalf.isUnit_mk_pow
#print axioms HadwigerNelson.SpectralChain.StablePrime.residue
#print axioms HadwigerNelson.UpperHalf.residue_algebraMap
#print axioms HadwigerNelson.UpperHalf.residue_div
#print axioms HadwigerNelson.UpperHalf.residue_conj
#print axioms HadwigerNelson.UpperHalf.coe_mem_nonunits_localRing_iff
#print axioms HadwigerNelson.UpperHalf.localRing_ne_top
#print axioms HadwigerNelson.UpperHalf.exists_hom_levelTarget
#print axioms HadwigerNelson.UpperHalf.nonempty_hom_levelTarget_one
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_levelTarget
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_localBound
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
#print axioms HadwigerNelson.UpperHalf.two_mem_of_conj_trivial
#print axioms HadwigerNelson.UpperHalf.colorable_two_planeOver_of_ramified
#print axioms HadwigerNelson.UpperHalf.exists_stablePrime_of_valuationSubring
#print axioms HadwigerNelson.UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime
-- FS131-LU1 block: `Arith/QuadraticPrime` — 13 records (12 theorems and the `Prop`-valued instance); the nine leaves' proofs FS131-IQ1's
#print axioms HadwigerNelson.QuadraticPrime.isIntegral_sqrt_natCast
#print axioms HadwigerNelson.QuadraticPrime.fieldOfRadicands_eq_adjoin
#print axioms HadwigerNelson.QuadraticPrime.numberField_fieldOfRadicands
#print axioms HadwigerNelson.QuadraticPrime.instNumberFieldFieldOfRadicands
#print axioms HadwigerNelson.QuadraticPrime.isMaximal_ker_and_card
#print axioms HadwigerNelson.QuadraticPrime.exists_ringHom_zmod_of_padic
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_of_padic
#print axioms HadwigerNelson.QuadraticPrime.exists_padicInt_sq_eq
#print axioms HadwigerNelson.QuadraticPrime.nonempty_ringHom_padic
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_eq
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_eq_sqrt
#print axioms HadwigerNelson.QuadraticPrime.nonempty_ringHom_zmod_of_ramified_sqrt
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_eq_of_ramified
-- FS131-LU1 block: `Instances/UpperHalfValues` — 9 records (8 theorems and the `Prop`-valued instance); the three leaves' proofs FS131-IV1's
#print axioms HadwigerNelson.UpperHalf.colorable_planeOver_fieldOfRadicands
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_eleven
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime
#print axioms HadwigerNelson.UpperHalf.numberField_bot
#print axioms HadwigerNelson.UpperHalf.instNumberFieldBot
#print axioms HadwigerNelson.UpperHalf.two_le_chromaticNumber_planeOver
#print axioms HadwigerNelson.UpperHalf.exists_stablePrime_rat
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_rat
-- FS131-LU1 block end

/-! ## FS131-LJ1 — the three-and-four-colours line (claims NF4 with NF1; statements FS131-KN4's, passes FS131-KN5; joined by FS131-KJ1)

Ninety-six records: every public declaration a person typed in `Arith/ThreeColourCharacter`, `Arith/TorsionExtraction`,
`Arith/ThreeColourCriterion`, `Arith/DyadicQuadratic`, `Arith/ThreeFourColours` and `Instances/UpperHalfCorollaries` — 94 theorems and 2
definitions (the kernel's list: `data/fs131/lj1/decls.lean`; the lines are FS131-KJ1's block, `data/fs131/kj1/audit-block.txt`, made from
the compiled modules).  The files' private helpers are not nameable here; each is read by a record of the block.  **Eighty-four here,
under CLEAN; twelve under IMPORTED, above**, each on the standard three and exactly one declared outside theorem,
`StandingFive.kloosterman_bound` (Weil's bound) — five of `Arith/ThreeColourCriterion` and seven of `Arith/ThreeFourColours`: the direction
of the three-colour criterion from a colouring to the prime, and row 99's lower half.  Clause (a)'s table, clause (c) and the lower bound
of four are under CLEAN.  `data/fs131/lj1/lj1_records.py` reads the kernel's list of the six modules against the audit's log: one record
each, the twelve under IMPORTED on the standard three and exactly that import, every other under CLEAN on a subset of the standard three. -/
-- FS131-LJ1 block: `Arith/ThreeColourCharacter` — 11 records under CLEAN (the eight leaves' proofs FS131-IC1's, two statements FS131-KJ1's)
#print axioms HadwigerNelson.ThreeColour.Winding.exists_box_point
#print axioms HadwigerNelson.ThreeColourCharacter.bandSet_nonempty_of_finite
#print axioms HadwigerNelson.ThreeColourCharacter.bandSet_three_nonempty_of_proper
#print axioms HadwigerNelson.ThreeColourCharacter.bandSet_three_nonempty_zmod_five
#print axioms HadwigerNelson.ThreeColourCharacter.exists_character_of_box_point
#print axioms HadwigerNelson.ThreeColourCharacter.exists_character_of_properAlong
#print axioms HadwigerNelson.ThreeColourCharacter.exists_character_one_two
#print axioms HadwigerNelson.ThreeColourCharacter.exists_int_vector_of_forall_neg
#print axioms HadwigerNelson.ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable
#print axioms HadwigerNelson.ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable_unitRing
#print axioms HadwigerNelson.ThreeColourCharacter.isClosed_band
-- FS131-LJ1 block: `Arith/TorsionExtraction` — 20 records under CLEAN (19 theorems and the definition `inv5`; the ten leaves' proofs FS131-IT1's, two statements FS131-KJ1's)
#print axioms HadwigerNelson.TorsionExtraction.chromaticNumber_planeOver_ne_three_of_inv_three_mem
#print axioms HadwigerNelson.TorsionExtraction.coe_inv5
#print axioms HadwigerNelson.TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty
#print axioms HadwigerNelson.TorsionExtraction.colorable_two_of_fieldBandSet_three_nonempty
#print axioms HadwigerNelson.TorsionExtraction.colorable_two_of_inv_three_mem
#print axioms HadwigerNelson.TorsionExtraction.exists_torsion_mem_fieldBandSet
#print axioms HadwigerNelson.TorsionExtraction.exists_zmod_hom_of_mem_torsionBy
#print axioms HadwigerNelson.TorsionExtraction.fieldBandSet_three_eq_empty_of_sqrt_mem
#print axioms HadwigerNelson.TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands
#print axioms HadwigerNelson.TorsionExtraction.four_le_chromaticNumber_planeOver_of_inv_three_mem
#print axioms HadwigerNelson.TorsionExtraction.four_le_chromaticNumber_planeOver_of_sqrt_mem
#print axioms HadwigerNelson.TorsionExtraction.inv5
#print axioms HadwigerNelson.TorsionExtraction.inv_natCast_mem_unitRing_of_sqrt_mem
#print axioms HadwigerNelson.TorsionExtraction.inv_three_mem_unitRing_of_sqrt_mem
#print axioms HadwigerNelson.TorsionExtraction.layer_dichotomy
#print axioms HadwigerNelson.TorsionExtraction.layer_step
#print axioms HadwigerNelson.TorsionExtraction.mem_fieldBandSet_two_of_inv_three_mem
#print axioms HadwigerNelson.TorsionExtraction.not_colorable_two_of_sqrt_mem
#print axioms HadwigerNelson.TorsionExtraction.tendsto_layer
#print axioms HadwigerNelson.TorsionExtraction.three_le_chromaticNumber_planeOver_of_sqrt_mem
-- FS131-LJ1 block: `Arith/ThreeColourCriterion` — 12 records under CLEAN (11 theorems and the definition `conjR`; the leaves' proofs FS131-IN1's; its other five records are under IMPORTED)
#print axioms HadwigerNelson.ThreeColourCriterion.coe_conjR
#print axioms HadwigerNelson.ThreeColourCriterion.comap_conjR_eq
#print axioms HadwigerNelson.ThreeColourCriterion.conjR
#print axioms HadwigerNelson.ThreeColourCriterion.conjR_conjR
#print axioms HadwigerNelson.ThreeColourCriterion.conj_mem_unitRing
#print axioms HadwigerNelson.ThreeColourCriterion.eq_zero_of_forall_normOne_eq
#print axioms HadwigerNelson.ThreeColourCriterion.exists_maximal_conj_trivial
#print axioms HadwigerNelson.ThreeColourCriterion.exists_maximal_conj_trivial_of_colorable_two
#print axioms HadwigerNelson.ThreeColourCriterion.exists_mul_conj_inv_eq_of_mul_conj_eq_one
#print axioms HadwigerNelson.ThreeColourCriterion.exists_unitSet_mul_conjR_eq
#print axioms HadwigerNelson.ThreeColourCriterion.fieldBandSet_two_nonempty_of_conj_trivial
#print axioms HadwigerNelson.ThreeColourCriterion.finite_quotient_span_natCast
-- FS131-LJ1 block: `Arith/DyadicQuadratic` — 13 records under CLEAN (the ten leaves' proofs FS131-ID1's, two statements FS131-KJ1's)
#print axioms HadwigerNelson.DyadicQuadratic.colorable_four_planeOver_sqrt
#print axioms HadwigerNelson.DyadicQuadratic.colorable_planeOver_of_addMonoidHom
#print axioms HadwigerNelson.DyadicQuadratic.colorable_two_planeOver_sqrt
#print axioms HadwigerNelson.DyadicQuadratic.colorable_two_planeOver_sqrt_of_mod_four
#print axioms HadwigerNelson.DyadicQuadratic.dyadic_shape_one_mod_four
#print axioms HadwigerNelson.DyadicQuadratic.dyadic_shape_three_mod_eight
#print axioms HadwigerNelson.DyadicQuadratic.dyadic_shape_two_mod_four
#print axioms HadwigerNelson.DyadicQuadratic.exists_addMonoidHom_one_mod_four
#print axioms HadwigerNelson.DyadicQuadratic.exists_addMonoidHom_three_mod_eight
#print axioms HadwigerNelson.DyadicQuadratic.exists_addMonoidHom_two_mod_four
#print axioms HadwigerNelson.DyadicQuadratic.exists_int_solution_of_mem_unitVectors
#print axioms HadwigerNelson.DyadicQuadratic.exists_rat_add_mul_sqrt_eq
#print axioms HadwigerNelson.DyadicQuadratic.mod_four_of_squarefree
-- FS131-LJ1 block: `Arith/ThreeFourColours` — 24 records under CLEAN (the joining module, FS131-KJ1's; its other seven records are under IMPORTED)
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_dyadic
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_three_of_mod
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_eq_two
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_table
#print axioms HadwigerNelson.ThreeFourColours.chromaticNumber_planeOver_sqrt_three
#print axioms HadwigerNelson.ThreeFourColours.colorable_four_planeOver_sqrt_of_seven
#print axioms HadwigerNelson.ThreeFourColours.colorable_three_of_card_three
#print axioms HadwigerNelson.ThreeFourColours.colorable_three_planeOver_sqrt
#print axioms HadwigerNelson.ThreeFourColours.exists_maximal_card_three_of_card_nine
#print axioms HadwigerNelson.ThreeFourColours.exists_maximal_card_three_of_stablePrime_card_nine
#print axioms HadwigerNelson.ThreeFourColours.exists_maximal_conj_trivial_sqrt_two
#print axioms HadwigerNelson.ThreeFourColours.exists_stablePrime_card_four_sqrt
#print axioms HadwigerNelson.ThreeFourColours.exists_stablePrime_card_nine
#print axioms HadwigerNelson.ThreeFourColours.exists_stablePrime_conj_trivial
#print axioms HadwigerNelson.ThreeFourColours.exists_stablePrime_of_maximal
#print axioms HadwigerNelson.ThreeFourColours.exists_stablePrime_ramified_sqrt
#print axioms HadwigerNelson.ThreeFourColours.exists_unitSet_residue_eq
#print axioms HadwigerNelson.ThreeFourColours.fieldBandSet_three_nonempty_sqrt_three
#print axioms HadwigerNelson.ThreeFourColours.levelTarget_colorable_three_of_card_nine
#print axioms HadwigerNelson.ThreeFourColours.levelTarget_colorable_two_of_ramified
-- FS131-LJ1 block: `Instances/UpperHalfCorollaries` — 4 records under CLEAN (FS131-KJ1's)
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_eq_two_of_localBound_le_two
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt_247_le_five
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt_five_le_five
#print axioms HadwigerNelson.UpperHalf.two_notMem_stablePrime_seven
-- FS131-LJ1 block end

/-! ## FS131-IPD1 — the port of `[OAIMath2026]`'s transfer proof: the transfer is a theorem, and the 31 ported modules

`Outside.OAI158.proper_to_borel_weak` is the release's theorem, its proof ported (`Outside/OAI158BorelTransfer`, FS-131, the port
of `plans/FS131-KO1-port-plan.md`): its `declareImport` is gone, and the twelve records that rested on it are here, under CLEAN,
with their comment lines (five of them now in `Outside/OAI158Collapse`, moved there by the switch). Under them, the 1422 records of
the 31 ported modules, generated by `tools/fs131_ko1_port.py --axioms-block` (every copied declaration, instances and the instances
a `deriving` clause declares included; the one private declaration in a `section` that opens it). No axiom, no outside theorem. -/
-- FS132-I1: the records resting on `proper_to_borel_weak` (`[OAIMath2026]` family 158, `BorelTransfer.lean:436–437`); the last is FS132-L1's
#print axioms HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_colorable
#print axioms HadwigerNelson.Outside.OAI158.colorable_iff_nonempty_aeColouring
#print axioms HadwigerNelson.Outside.OAI158.chiM0_le_chromaticNumber_plane
#print axioms HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
#print axioms HadwigerNelson.Outside.OAI158.seven_le_chromaticNumber_plane_iff
-- FS124-I1: the radius clause's records resting on `proper_to_borel_weak` (C124-RADIUS-DOWN and the join with -UP, `Plane/RadiusOutside`)
#print axioms HadwigerNelson.Plane.exists_isWeakColouringOn_of_colorable
#print axioms HadwigerNelson.Plane.radius_down
#print axioms HadwigerNelson.Plane.colorable_iff_forall_ball
#print axioms HadwigerNelson.Plane.seven_le_chromaticNumber_plane_iff_exists_ball
-- FS131-KC1: the measurable number's records resting on `proper_to_borel_weak` (claim NF3-PLANE, `Plane/LebesgueNumber`; landed by FS131-LC1)
#print axioms HadwigerNelson.Plane.colorable_iff_exists_nullMeasurable_proper
#print axioms HadwigerNelson.Plane.chromaticNumber_plane_eq_chiLebesgue
#print axioms HadwigerNelson.Plane.chromaticNumber_euclidean_plane_eq_chiLebesgue
-- FS131-IPD1 block: the 31 ported modules (generated)
-- Outside/OAI158Basic: 112 records (16 instances, 2 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Spectral.E
#print axioms HadwigerNelson.Outside.OAI158.Spectral.K
#print axioms HadwigerNelson.Outside.OAI158.Spectral.K_pow_surjective
#print axioms HadwigerNelson.Outside.OAI158.Spectral.K_rootable
#print axioms HadwigerNelson.Outside.OAI158.Spectral.finite_image_trivial
#print axioms HadwigerNelson.Outside.OAI158.Spectral.DiscreteE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instCommGroupDiscreteE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instTopologicalSpaceDiscreteE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instDiscreteTopologyDiscreteE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instIsTopologicalGroupDiscreteE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.D
#print axioms HadwigerNelson.Outside.OAI158.Spectral.E_countable
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instCountableDiscreteE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instSecondCountableTopologyD
#print axioms HadwigerNelson.Outside.OAI158.Spectral.embed
#print axioms HadwigerNelson.Outside.OAI158.Spectral.embed_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.embed_mul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_add
#print axioms HadwigerNelson.Outside.OAI158.Spectral.jHom
#print axioms HadwigerNelson.Outside.OAI158.Spectral.C
#print axioms HadwigerNelson.Outside.OAI158.Spectral.continuous_j
#print axioms HadwigerNelson.Outside.OAI158.Spectral.fixed_of_finite_orbit
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMeasurableSpaceD
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instBorelSpaceD
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measurableSet_C
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scaleE
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_mul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_add
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_j
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_mem_C
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_mem_C_iff
#print axioms HadwigerNelson.Outside.OAI158.Spectral.fixed_of_positive_fiber
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_mul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalarHom
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMulActionSubtypeCircleMemSubgroupKD
#print axioms HadwigerNelson.Outside.OAI158.Spectral.Cosets
#print axioms HadwigerNelson.Outside.OAI158.Spectral.cosetScalar
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMulActionSubtypeCircleMemSubgroupKCosets
#print axioms HadwigerNelson.Outside.OAI158.Spectral.quotient_equivariant
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measurableSet_coset
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_neg
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_sub
#print axioms HadwigerNelson.Outside.OAI158.Spectral.minusOne
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_minusOne
#print axioms HadwigerNelson.Outside.OAI158.Spectral.coset_fixed_minusOne
#print axioms HadwigerNelson.Outside.OAI158.Spectral.IsWild
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_coset_null
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_div_mem_null
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_independent_difference
#print axioms HadwigerNelson.Outside.OAI158.Spectral.continuous_scalar
#print axioms HadwigerNelson.Outside.OAI158.Spectral.frequency_zero_of_rational_tests
#print axioms HadwigerNelson.Outside.OAI158.Spectral.imagUnit
#print axioms HadwigerNelson.Outside.OAI158.Spectral.coe_imagUnit
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_eq_one_iff
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_neg
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_sub
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_injective
#print axioms HadwigerNelson.Outside.OAI158.Spectral.j_measurableEmbedding
#print axioms HadwigerNelson.Outside.OAI158.Spectral.algebraic_complex_iff_coordinates
#print axioms HadwigerNelson.Outside.OAI158.Spectral.real_character
#print axioms HadwigerNelson.Outside.OAI158.Spectral.F
#print axioms HadwigerNelson.Outside.OAI158.Spectral.dense_F
#print axioms HadwigerNelson.Outside.OAI158.Spectral.algebraic_real_character
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ofF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.coe_ofF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.DiscreteF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instCommGroupDiscreteF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instTopologicalSpaceDiscreteF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instDiscreteTopologyDiscreteF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instIsTopologicalGroupDiscreteF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.DF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMeasurableSpaceDF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instBorelSpaceDF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.embedF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.embedF_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.embedF_mul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.jF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.jF_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.CF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.continuous_jF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measurableSet_CF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineHom
#print axioms HadwigerNelson.Outside.OAI158.Spectral.restrictLine
#print axioms HadwigerNelson.Outside.OAI158.Spectral.continuous_restrictLine
#print axioms HadwigerNelson.Outside.OAI158.Spectral.L
#print axioms HadwigerNelson.Outside.OAI158.Spectral.mem_L_iff
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measurableSet_L
#print axioms HadwigerNelson.Outside.OAI158.Spectral.reF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.imF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.coe_reF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.coe_imF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.reF_add_imF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.line_add
#print axioms HadwigerNelson.Outside.OAI158.Spectral.line_mul_real
#print axioms HadwigerNelson.Outside.OAI158.Spectral.line_sub
#print axioms HadwigerNelson.Outside.OAI158.Spectral.orthogonal_lines
#print axioms HadwigerNelson.Outside.OAI158.Spectral.line_one_and_nonreal
#print axioms HadwigerNelson.Outside.OAI158.Spectral.scalar_line
#print axioms HadwigerNelson.Outside.OAI158.Spectral.independent_lines
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_inv
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_ne_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.real_rotation_square
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotated_directions_independent
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_line_null
-- Outside/OAI158InvariantMean: 134 records (3 instances, 1 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.instDecidableEq_proofs
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift_comm
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift_sub
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift_smul
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shift_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_sub
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_smul
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_const
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_nonneg
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_telescope
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.single_coboundary_norm
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_sub
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_smul
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_const
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_nonneg
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cube_coboundary_norm
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.approx
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.approx_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.averagingUF
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.averagingUF_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.approx_has_limit
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.tendsto_approx
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_smul
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_const
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_nonneg
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.eventually_mem
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.tendsto_index
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.tendsto_boundary
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.meanCLM
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.meanCLM_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.realPart
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.imagPart
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.realPart_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.imagPart_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmean
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmean_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmean_smul
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.realPart_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.imagPart_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmean_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmeanCLM
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmeanCLM_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmean_const
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cshift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cshift_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.cmean_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circlePull
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circlePull_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circlePull_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circleMean
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circleMean_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circleIntegral
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circleIntegral_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circleMean_fourier_nonzero
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.circleMean_eq_integral
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.AF
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.PeriodGroup
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.instAddCommGroupPeriodGroup
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.instTopologicalSpacePeriodGroup
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.instDiscreteTopologyPeriodGroup
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodMk
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.fieldCircle
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.fieldCircle_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodMap
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodMap_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodMap_half_period
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.ordinary_mean_integral
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_mono
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.mean_abs_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.normFn
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.normFn_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.pairing
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.pairing_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.pairing_mean_bound
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.pairingMean
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_pair
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_norm_bound
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_sub
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_map
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodSum
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodSum_periodic
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodLift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodLift_mk
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.period_term_zero
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodSum_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodBCF
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.period_summable
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodSum_add
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodSum_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodBCF_mk
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.periodBCF_norm_le
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralComplex
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_nonneg
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_mono
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_pair
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_norm_bound
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_shift
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_sub
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_map
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.compact_local_summable
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.ordinaryPeriod
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.ordinaryPeriod_apply
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralComplex_ordinary
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralComplex_re
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_ordinary
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_congr
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.shifted_support
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.smoothed_support
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.smoothed_bound
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.smoothedVector
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.smoothed_translation_bound
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.smoothed_tendsto
-- Outside/OAI158NumberFields: 43 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.minpoly_reverse_eval_ne_zero
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.reciprocal_denominator
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.polyLinear
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.coeff_polyLinear
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.polyLinear_add
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.polyLinear_monomial
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.eval_polyLinear
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.polyLinear_eq_zero_iff
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_annihilation
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.linearFraction_polynomials
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.rational_functions_avoid
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.finite_hyperplanes_avoid
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.realSlice
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.asN
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.coe_asN
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.iN
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.coe_iN
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.iN_sq
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_den_ne
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.realCayley
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_real_norm
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_functional_escape
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.realLine
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.realLine_zero
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.realLine_one
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_line_polynomials
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_finite_avoid
#print axioms HadwigerNelson.Outside.OAI158.GeneralPosition.General
#print axioms HadwigerNelson.Outside.OAI158.GeneralPosition.exists_general
#print axioms HadwigerNelson.Outside.OAI158.GeneralPosition.General.spans
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatingSet
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_I
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_real
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_imag
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_contains
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_conj
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_re_closed
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_im_closed
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.generatedField_finite
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.finrank_ge_two
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.cayley_subspaces_avoid
#print axioms HadwigerNelson.Outside.OAI158.AlgebraicCayley.numberField_general_position
-- Outside/OAI158PhaseEncoding: 24 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.phases
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.elem
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.encoding
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.phasePolynomial
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.card_phases
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.elem_zero
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.elem_eq_sum
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.continuous_encoding
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.polynomial_expansion
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.eval_at_phase
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.eval_expansion
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.eval_difference
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.eval_difference_bound
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.close_encoding_each_phase
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.fromPowers
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.measurable_fromPowers
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.newton_elem
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.filtered_antidiagonal_sum
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.fromPowers_eq_elem
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.kernelEncoding
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.measurable_kernelEncoding
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.moments_uniform_list
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.kernelEncoding_eq_encoding
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.exists_encoding_bound
-- Outside/OAI158SmallArcs: 19 records (2 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.phaseSum
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.pow_sub_one_bound
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.phaseSum_sub_bound
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.phaseSum_lower
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.phase_energy
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.pow_mul_conj_pow
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.integrable_pair
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.pair_moment_bound
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.phase_energy_integral_bound
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.integrable_energy
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.small_arc_bound
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.instMeasurableSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.instBorelSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.SmallArc.exists_small_arc_constants
#print axioms HadwigerNelson.Outside.OAI158.SampledAtoms.measurable_atom_mass
#print axioms HadwigerNelson.Outside.OAI158.SampledAtoms.ae_sampled_positive_atom
#print axioms HadwigerNelson.Outside.OAI158.SampledAtoms.uniform_list_positive_atoms
#print axioms HadwigerNelson.Outside.OAI158.SampledAtoms.in_list_of_positive_atom
#print axioms HadwigerNelson.Outside.OAI158.SampledAtoms.ae_sampled_list
-- Outside/OAI158Amenability: 48 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Amenable.shift
#print axioms HadwigerNelson.Outside.OAI158.Amenable.shift_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.mono
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.abs_le
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.exists_lt
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.normFn
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.normFn_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.pairing
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.pairing_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.pairing_bound
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.pairingMap
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_pair
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_norm_le
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_add
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_smul
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_shift
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_map
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.squareNorm
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.squareNorm_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.jensen
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.cross
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.cross_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.cross_comm
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.squareNorm_add
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.squareNorm_shift
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.correlation
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.correlation_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.correlation_add
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.correlation_zero
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.correlation_shift
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_eq_zero_of_correlation_nonpos
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.orbit
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.orbit_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_orbit_invariant
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_orbit_pair_fixed
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_orbit_eq_zero
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.linear
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.linear_add
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.linear_zero
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.action
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.action_apply
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.action_add
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.coe_action
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.ae_eq_const_of_fixed
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.inner_fixed_zero
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.vector_orbit_zero
-- Outside/OAI158Centers: 95 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Location.Ambient
#print axioms HadwigerNelson.Outside.OAI158.Location.lift
#print axioms HadwigerNelson.Outside.OAI158.Location.lift_fst
#print axioms HadwigerNelson.Outside.OAI158.Location.lift_snd
#print axioms HadwigerNelson.Outside.OAI158.Location.lift_ne_zero
#print axioms HadwigerNelson.Outside.OAI158.Location.norm_lift
#print axioms HadwigerNelson.Outside.OAI158.Location.lift_sub
#print axioms HadwigerNelson.Outside.OAI158.Location.norm_lift_sub
#print axioms HadwigerNelson.Outside.OAI158.Location.lift_affine
#print axioms HadwigerNelson.Outside.OAI158.Location.not_sameRay_smul_lift
#print axioms HadwigerNelson.Outside.OAI158.Location.strictConvex_norm_lift
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel
#print axioms HadwigerNelson.Outside.OAI158.Location.objective
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_formula
#print axioms HadwigerNelson.Outside.OAI158.Location.continuous_kernel
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_bound
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_diff_bound
#print axioms HadwigerNelson.Outside.OAI158.Location.integrable_kernel
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_zero
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_lipschitz
#print axioms HadwigerNelson.Outside.OAI158.Location.continuous_objective
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_strict_convex
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_strict_convex
#print axioms HadwigerNelson.Outside.OAI158.Location.norm_lift_le
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_lower
#print axioms HadwigerNelson.Outside.OAI158.Location.exists_ball_mass
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_lower
#print axioms HadwigerNelson.Outside.OAI158.Location.linear_norm_coercive
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_coercive
#print axioms HadwigerNelson.Outside.OAI158.Location.exists_unique_minimizer
#print axioms HadwigerNelson.Outside.OAI158.Location.center
#print axioms HadwigerNelson.Outside.OAI158.Location.center_minimizes
#print axioms HadwigerNelson.Outside.OAI158.Location.center_unique
#print axioms HadwigerNelson.Outside.OAI158.Location.universalKernel
#print axioms HadwigerNelson.Outside.OAI158.Location.measurable_objective
#print axioms HadwigerNelson.Outside.OAI158.Location.denseSeq_inf_eq_min
#print axioms HadwigerNelson.Outside.OAI158.Location.minValue
#print axioms HadwigerNelson.Outside.OAI158.Location.measurable_minValue
#print axioms HadwigerNelson.Outside.OAI158.Location.minValue_eq
#print axioms HadwigerNelson.Outside.OAI158.Location.exists_min_on_closed
#print axioms HadwigerNelson.Outside.OAI158.Location.measurable_center
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_translate
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_translate
#print axioms HadwigerNelson.Outside.OAI158.Location.center_translate
#print axioms HadwigerNelson.Outside.OAI158.Location.kernel_orthogonal
#print axioms HadwigerNelson.Outside.OAI158.Location.objective_orthogonal
#print axioms HadwigerNelson.Outside.OAI158.Location.center_orthogonal
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j_zero
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j_add
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j_neg
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j_sub
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j_injective
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.ordinary
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.mem_ordinary_iff
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.range_j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurableSet_ordinary
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.coordinate
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_coordinate
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.coordinate_j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.j_coordinate
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.coset
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurableSet_coset
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyMeasure
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyMeasure_apply
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyMeasure_univ
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.parameterKernel
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.parameterKernel_markov
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_frequencyMeasure
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_mass
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyLaw
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyLaw_measure
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_frequencyLaw
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.coset_mul_j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.coordinate_div_j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyMeasure_shift
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyLaw_shift
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_center
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_mem_coset
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_mul_j
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_eq_of_mem_coset
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.quotient_center
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_eq_iff
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_mem_ordinary_iff
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.preimage_center_singleton
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.measurable_center_fixed
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.equiv_mem_ordinary_iff
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.preimage_coset_equiv
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.coordinate_equiv
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyMeasure_equiv
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.frequencyLaw_equiv
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_equivariant
-- Outside/OAI158Characters: 42 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.abs_arg_exp_le
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.abs_arg_pow_le
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.frequency
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.frequency_abs_mono
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.exp_frequency_div
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.frequency_exp_previous
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.frequency_stabilizes
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.chord_bound
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.geom_sum_chord_bound
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.average_deviation
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.deviation
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.deviation_bound
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.deviation_measurable
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.deviation_integrable
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.frequency_tail_bound
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.dyadic_tail_bound
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.dyadic_frequencies_ae_bounded
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.dyadic_frequencies_ae_stable
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.ordinary_of_stable
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.F
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.dyadicApprox
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.dyadicApprox_error
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.dyadicApprox_tendsto
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.circle_sq_dist
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.coeff
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.coeff_zero
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.coeff_small
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_nat_dyadic
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_int_dyadic
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_dyadic_coherent
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.character_ae_dyadic
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_sub
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_sq_distance
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_sq_integrable
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_sq_integral
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.character_tendstoInMeasure
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.F_countable
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.char_dyadicApprox_eq
#print axioms HadwigerNelson.Outside.OAI158.ContinuousCharacters.character_ae_ordinary
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineCharacter
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineCharacter_measurable
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_continuous_coefficient_zero
-- Outside/OAI158PhaseCollision: 23 records (4 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.instDecidableEq_proofs
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.instDecidableEq_proofs_1
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.repeatedPairs
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.sameBin_card
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.sameBin_card_eq
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.repeated_bin_lower_bound
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.closePairs
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.close_pair_lower_bound
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.normalized_close_pair_lower_bound
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.average_cover_forces_collision
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.goodFraction
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.goodFraction_eq_sum
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.measurable_goodFraction
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.goodFraction_nonneg
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.goodFraction_le_one
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.integrable_goodFraction
#print axioms HadwigerNelson.Outside.OAI158.AverageErrors.average_goodFraction
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.average_exists_cover_forces_collision
#print axioms HadwigerNelson.Outside.OAI158.PhaseCollision.circle_product_dist
#print axioms HadwigerNelson.Outside.OAI158.EncodedCollision.instMeasurableSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.EncodedCollision.instBorelSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.EncodedCollision.collision_from_close_encodings
#print axioms HadwigerNelson.Outside.OAI158.EncodedCollision.collision_from_measurable_encodings
-- Outside/OAI158Selections: 22 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.GeneralPosition.spanning_selection
#print axioms HadwigerNelson.Outside.OAI158.Arithmetic.common_denominator
#print axioms HadwigerNelson.Outside.OAI158.Arithmetic.uniform_integral_representations
#print axioms HadwigerNelson.Outside.OAI158.Arithmetic.span_mult_rep
#print axioms HadwigerNelson.Outside.OAI158.Arithmetic.uniform_selection
#print axioms HadwigerNelson.Outside.OAI158.Arithmetic.real_sum_bound
#print axioms HadwigerNelson.Outside.OAI158.Arithmetic.selection_transverse
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.Good
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.good_mono
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.good_zero
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.good_diff
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.add_residues
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.input_residue
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.list_residue
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.list_cap
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.signedList
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.signedList_length
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.signedList_sum
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.signedList_mem
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.integer_list
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.integer_cap
#print axioms HadwigerNelson.Outside.OAI158.CappedResidues.integer_abs_cap
-- Outside/OAI158RelativeCenters: 42 records (4 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.UniformFibers.finite_uniform_fibers
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.finite_uniform_centers
#print axioms HadwigerNelson.Outside.OAI158.CosetCenter.Embedding.center_law_ordinary
#print axioms HadwigerNelson.Outside.OAI158.ErgodicSupport.ae_eq_const_of_invariant
#print axioms HadwigerNelson.Outside.OAI158.KernelSupport.compProd_map_base
#print axioms HadwigerNelson.Outside.OAI158.KernelSupport.condDistrib_comp_equiv
#print axioms HadwigerNelson.Outside.OAI158.KernelSupport.condDistrib_equivariant
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.probabilityKernel
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.measurable_probabilityKernel
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.cosetMass
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.measurable_cosetMass
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.differenceLaw
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.differenceLaw_ordinary
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.sampledMass_integral
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.positive_mass_finite_centers
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.sampledMass_invariant
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerMap
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.measurable_centerMap
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerMap_mem_ordinary_iff
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerMap_law_ordinary
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerMap_equivariant
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.dependentMapKernel_apply
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.compProd_dependentMap
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerKernel
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.measurable_fiberCenter
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerKernel_markov
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerKernel_apply
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.condDistrib_centerMap
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.centerKernel_comp_map
#print axioms HadwigerNelson.Outside.OAI158.RelativeCenters.finite_center_reduction
#print axioms HadwigerNelson.Outside.OAI158.Spectral.dualStandardBorelSpace
#print axioms HadwigerNelson.Outside.OAI158.Spectral.dualMulDistribAction
#print axioms HadwigerNelson.Outside.OAI158.Spectral.dualMeasurableConstSMul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryEmbedding
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryEmbedding_j
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryEmbedding_ordinary
#print axioms HadwigerNelson.Outside.OAI158.Spectral.frequencyIsometry
#print axioms HadwigerNelson.Outside.OAI158.Spectral.frequencyRotation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.frequencyRotation_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.action_ordinaryEmbedding
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_map_of_equivariant
#print axioms HadwigerNelson.Outside.OAI158.Spectral.exact_finite_center_reduction
-- Outside/OAI158Multipliers: 30 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mul_memLp
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mul
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mul_ae
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mul_norm
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mulIsometry
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mul_inverse
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.mulEquiv
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight_measurable
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight_finite
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight_ac
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight_inner
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight_eq_zero_iff
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.norm_mul_sub_sq
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.lp_norm_sq_integral
#print axioms HadwigerNelson.Outside.OAI158.LpMultiplier.weight_deviation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineU
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineU_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineU_ae
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineU_add
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineU_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.weighted_coeff
#print axioms HadwigerNelson.Outside.OAI158.Spectral.strong_vector_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_smoothed_zero
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakMean_complex
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weakIntegral_complex
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineFourier
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineFourier_norm_le
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineFourier_inner
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_line_average_zero
-- Outside/OAI158ConditionalSelection: 19 records (2 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.GoodFiber.exists_lt_on_conull
#print axioms HadwigerNelson.Outside.OAI158.GoodFiber.fraction_lower_bound
#print axioms HadwigerNelson.Outside.OAI158.GoodFiber.simultaneous_good_fiber
#print axioms HadwigerNelson.Outside.OAI158.GoodFiber.large_common_bin
#print axioms HadwigerNelson.Outside.OAI158.Approximation.dist_sq_four_points
#print axioms HadwigerNelson.Outside.OAI158.Approximation.integrated_distance_bound
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.comp_identity_fiber
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.ae_fiber_of_ae
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.map_identity_fiber
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.ae_in_own_fiber
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.integral_fiber
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.integrable_ae_fiber
#print axioms HadwigerNelson.Outside.OAI158.ConditionalFiber.integrable_fiber_integral
#print axioms HadwigerNelson.Outside.OAI158.FiniteModule.instMeasurableSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.FiniteModule.instBorelSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.FiniteModule.common_fiber_contradiction
#print axioms HadwigerNelson.Outside.OAI158.FiniteBins.compact_bins
#print axioms HadwigerNelson.Outside.OAI158.FiniteBins.linear_combination_dist_bound
#print axioms HadwigerNelson.Outside.OAI158.FiniteBins.bounded_coefficient_bins
-- Outside/OAI158FourierTests: 16 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_congr
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_mul
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.integralReal_sum
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.weighted_bound
#print axioms HadwigerNelson.Outside.OAI158.InvariantMean.exists_small_nonnegative_tests
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineFourier_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineFourier_re_le_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_line_average_re_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.exists_positive_window
#print axioms HadwigerNelson.Outside.OAI158.Spectral.exists_small_wild_parameter
#print axioms HadwigerNelson.Outside.OAI158.DifferenceFourier.differenceLaw
#print axioms HadwigerNelson.Outside.OAI158.DifferenceFourier.differenceLaw_probability
#print axioms HadwigerNelson.Outside.OAI158.DifferenceFourier.coe_character_div
#print axioms HadwigerNelson.Outside.OAI158.DifferenceFourier.independent_coefficient
#print axioms HadwigerNelson.Outside.OAI158.DifferenceFourier.difference_coefficient
#print axioms HadwigerNelson.Outside.OAI158.DifferenceFourier.difference_coefficient_nonneg
-- Outside/OAI158ConditionalSpectrum: 36 records (7 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Spectral.dualPolishSpace
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMeasurableSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instBorelSpaceCircle_proofs
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval
#print axioms HadwigerNelson.Outside.OAI158.Spectral.continuous_eval
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measurable_eval
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measurable_eval_coe
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_add
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_neg
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_sub
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_nat_mul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_scalar
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_smul_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.lineFourier_eq
#print axioms HadwigerNelson.Outside.OAI158.Spectral.predecessor_moment_sq
#print axioms HadwigerNelson.Outside.OAI158.Spectral.integrable_predecessor_moment_sq
#print axioms HadwigerNelson.Outside.OAI158.Spectral.real_algebraic_sum_two_rotations
#print axioms HadwigerNelson.Outside.OAI158.PhaseEncoding.kernelEncoding_covariance
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMeasurableSpaceCircle_proofs_1
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instBorelSpaceCircle_proofs_1
#print axioms HadwigerNelson.Outside.OAI158.Spectral.MomentTest
#print axioms HadwigerNelson.Outside.OAI158.Spectral.momentArgument
#print axioms HadwigerNelson.Outside.OAI158.Spectral.momentArgument_ne_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.momentTest_nonempty
#print axioms HadwigerNelson.Outside.OAI158.Spectral.exists_simultaneous_moment_parameter
#print axioms HadwigerNelson.Outside.OAI158.Spectral.eval_dist
#print axioms HadwigerNelson.Outside.OAI158.Spectral.pair_collision_upper
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMeasurableSpaceCircle_proofs_2
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instBorelSpaceCircle_proofs_2
#print axioms HadwigerNelson.Outside.OAI158.Spectral.FiniteEncodingApproximationAt
#print axioms HadwigerNelson.Outside.OAI158.Spectral.FiniteEncodingApproximation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.two_array_norm_bound
#print axioms HadwigerNelson.Outside.OAI158.Spectral.simultaneous_test_budget
#print axioms HadwigerNelson.Outside.OAI158.Spectral.finite_uniform_precision_contradiction
#print axioms HadwigerNelson.Outside.OAI158.Spectral.finite_uniform_successor_contradiction
-- Outside/OAI158Approximation: 14 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.UniformEnumeration.list_of_uniform_atoms
#print axioms HadwigerNelson.Outside.OAI158.UniformEnumeration.constant_uniform_lists
#print axioms HadwigerNelson.Outside.OAI158.DifferenceInvariant.differenceLaw
#print axioms HadwigerNelson.Outside.OAI158.DifferenceInvariant.invariant
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.Scalar
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.Vector
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.pi_dist_sq_le_sum
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.vector_of_scalar
#print axioms HadwigerNelson.Outside.OAI158.KernelSupport.factor_smul_preserving
#print axioms HadwigerNelson.Outside.OAI158.Spectral.relative_difference_invariant
#print axioms HadwigerNelson.Outside.OAI158.Spectral.finite_encoding_approximation_of_compact
#print axioms HadwigerNelson.Outside.OAI158.Spectral.relative_singularity_successor
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.At
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.lift_at
-- Outside/OAI158ConditionalLimits: 21 records (2 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.LimitDensity.clip
#print axioms HadwigerNelson.Outside.OAI158.LimitDensity.clip_bound
#print axioms HadwigerNelson.Outside.OAI158.LimitDensity.clip_eq
#print axioms HadwigerNelson.Outside.OAI158.LimitDensity.continuous_clip
#print axioms HadwigerNelson.Outside.OAI158.LimitDensity.bounded_vector_approximation
#print axioms HadwigerNelson.Outside.OAI158.LimitDensity.generated_factor_approximation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.bounded_phase_encoding
#print axioms HadwigerNelson.Outside.OAI158.Spectral.finite_encoding_at_of_approximation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.relative_singularity_limit
#print axioms HadwigerNelson.Outside.OAI158.ConditionalBase.condDistrib_given_const
#print axioms HadwigerNelson.Outside.OAI158.ConditionalBase.prod_given_const
#print axioms HadwigerNelson.Outside.OAI158.Spectral.relative_singularity_base
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instMeasurableSpaceCircle_proofs_3
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instBorelSpaceCircle_proofs_3
#print axioms HadwigerNelson.Outside.OAI158.Spectral.AmbientEncodingAt
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ambient_uniform_precision_contradiction
#print axioms HadwigerNelson.Outside.OAI158.CompactApproximation.scalar_identity
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ambient_encoding_of_at
#print axioms HadwigerNelson.Outside.OAI158.Spectral.relative_singularity_approximation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.UniversalGood
#print axioms HadwigerNelson.Outside.OAI158.Spectral.universalGood_of_factor
-- Outside/OAI158Kernels: 34 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.norm_integral_sq
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.fiberMean
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.measurable_fiberMean
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.fiberMean_bound
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.fiberMean_l2_bound
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.kernel_apply_error_bound
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.Code
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.code
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.measurable_code
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.pairCode
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.measurable_pairCode
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.pairCode_mono
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.pairCode_generates
#print axioms HadwigerNelson.Outside.OAI158.RectangleDensity.bounded_rectangles
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.bounded_range_approximation
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.applyKernel
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.applyKernel_covariance
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.norm_sq_le_sub
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.exists_nonzero_image
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.measurable_applyKernel
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.applyKernel_bound
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.exists_invariant_set
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.indicator_not_constant
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.row_constant
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.centered_kernel
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_eq_mixture
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_swap
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_probability
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.conditional_covariance
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_preserving
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_invariant
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.image_conditional_mean_zero
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.nonzero_not_factorizable
-- Outside/OAI158BoundedFunctions: 51 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.algebra
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Func
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.instCoeFunFuncForallComplex
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.measurable
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.norm_le_bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.ext
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.add_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mul_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.sub_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.zero_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.one_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.smul_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.real_smul_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.bmConj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conj_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.comp
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.comp_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.memLp
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.lp
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.coe_lp
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.lp_congr
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.lp_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.lp_smul
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_ae
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_eq_iff
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_l2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.inner_l2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_norm_mul_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_norm_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integrable
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integrable_norm_sq
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.norm_l2_sq
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expect
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expect_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expect_bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expect_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expect_smul
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expectLinear
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.expect_conj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_integral
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_integral
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_pullout
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_lift
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_congr
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_norm_l2_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_eq_condexp
-- Outside/OAI158Functions: 32 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.At
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.Compact
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.at_of_finite
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.module_bound
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.dist_sq_add
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.dist_sq_chain
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_const
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_conj
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_add
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_mul
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_of_l2_approximation
#print axioms HadwigerNelson.Outside.OAI158.Quantize.finite_measurable_choice
#print axioms HadwigerNelson.Outside.OAI158.Quantize.compact_quantization
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.combination_dist
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_lipschitz
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_of_bounded_pointwise_limit
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_closed_preimage
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_neg
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.indicator_one_bound
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_compl
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_union
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_iUnion
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compactSigma
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compactSigma_le
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.measurable_compactSigma
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_simple
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_of_measurable_compactSigma
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_base
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_shift
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.measurable_shift_compactSigma
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.measurable_base_compactSigma
#print axioms HadwigerNelson.Outside.OAI158.CompactFunctions.compact_descend
-- Outside/OAI158Factors: 65 records (9 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.equiv
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instInhabited
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instTopologicalSpace
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instMeasurableSpace
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instBorelSpace
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instPolishSpaceOfCountable
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.ext
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.continuous_val
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.continuous_mk
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.measurable_val
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.measurable_mk
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instMulAction
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.smul_val
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instContinuousConstSMul
#print axioms HadwigerNelson.Outside.OAI158.OrbitSpace.instMeasurableConstSMul
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.orbit
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.measurable_orbit
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.orbit_equivariant
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.extend
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.measurable_extend
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.extend_equivariant
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.orbit_one
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.measurable_extend_compactSigma
#print axioms HadwigerNelson.Outside.OAI158.OrbitFactor.compact_orbit_extension
#print axioms HadwigerNelson.Outside.OAI158.KernelCompact.compact_applyKernel
#print axioms HadwigerNelson.Outside.OAI158.CompactTower.strict_compact_successor
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.scalar
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.scalar_measurable
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.scalar_injective
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.scalar_embedding
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.scalar_bound
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.encode
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.encode_measurable
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.encode_equivariant
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.encode_bound
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.decode
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.decode_measurable
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.decode_encode
#print axioms HadwigerNelson.Outside.OAI158.FactorCode.encode_as_comp
#print axioms HadwigerNelson.Outside.OAI158.FactorLp.space
#print axioms HadwigerNelson.Outside.OAI158.FactorLp.isClosed
#print axioms HadwigerNelson.Outside.OAI158.FactorLp.exists_rep
#print axioms HadwigerNelson.Outside.OAI158.FactorLp.mem_of_rep
#print axioms HadwigerNelson.Outside.OAI158.FactorLp.le_of_factor
#print axioms HadwigerNelson.Outside.OAI158.FactorLp.factor_of_le
#print axioms HadwigerNelson.Outside.OAI158.CountableApprox.truncate
#print axioms HadwigerNelson.Outside.OAI158.CountableApprox.truncate_measurable
#print axioms HadwigerNelson.Outside.OAI158.CountableApprox.truncate_mono
#print axioms HadwigerNelson.Outside.OAI158.CountableApprox.truncate_generate
#print axioms HadwigerNelson.Outside.OAI158.CountableApprox.bounded_approximation
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.joint
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.code
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.joint_measurable
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.code_measurable
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.code_equivariant
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.le_code
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.joint_equivariant
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.finite_upper
#print axioms HadwigerNelson.Outside.OAI158.ChainJoin.approximation
#print axioms HadwigerNelson.Outside.OAI158.SeparableZorn.countable_cover
#print axioms HadwigerNelson.Outside.OAI158.SeparableZorn.exists_maximal
#print axioms HadwigerNelson.Outside.OAI158.CodedMax.Model
#print axioms HadwigerNelson.Outside.OAI158.CodedMax.instPreorderModel
#print axioms HadwigerNelson.Outside.OAI158.CodedMax.exists_maximal
-- Outside/OAI158RelativeProducts: 70 records (4 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_probability_add
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.conditional_covariance_add
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_preserving_add
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_invariant_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.projectCLM
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.projectCLM_l2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.norm_project_l2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_mul
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_conj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_sub
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_sub
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_comp
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_project
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.center_project_l2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_pullout
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_mul_lift
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_lift
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.project_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.familyAlgebra
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.instCoeFunFamilyForallFunc
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.familyRealModule
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.norm_le_bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.ext
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.add_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.mul_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.sub_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.zero_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.one_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.real_smul_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.complex_smul_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.prod_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.const
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.const_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.bmConj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.conj_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.toL2
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.toL2_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.l2Linear
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.avg
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.avg_pair
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.avg_congr_ae
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.orbit
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.orbit_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.orbit_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.orbit_sub
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor_mul
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor_conj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_law
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_tensor
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_tensor_self
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.inner_tensor
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Koopman.vector_orbit_hom_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.product_measurable_vadd
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.pairSequence
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.pairSequence_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.pair_mean_sq_zero
#print axioms HadwigerNelson.Outside.OAI158.AlgebraReplacement.mixed_prod
#print axioms HadwigerNelson.Outside.OAI158.AlgebraReplacement.linear_prod_replace
#print axioms HadwigerNelson.Outside.OAI158.AlgebraReplacement.add_prod_replace
-- Outside/OAI158Separability: 53 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_real
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.norm_mean_zero_of_square
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_inner
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.inner_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_mul_norm_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.func_prod_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conj_conj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conj_mul
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conj_prod
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.comp_prod
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_prod
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.act_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.prod_orbit_correlation
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.prod_shift_erase
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.l2_inner_mul
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.correlation_product
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.norm_l2_conj
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.inner_replace_project
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.inner_project_bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.avg_project_bound
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.prod_act_project_lift
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.PairVanishing
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.pairVanishing_of_ergodic
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Admissible
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Admissible.erase_diff
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.avg_product_zero_of_pair
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_nonneg
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_mono
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_congr
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_add_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_neg
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_sub_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_mul_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_const
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_add_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_mul_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_sum_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.meanNorm_eq_zero_of_approx
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.conditional
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.conditional_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.conditional_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.conditional_sub
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_add_left
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_add_right
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_mul_project_act
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_center
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_mean_zero
-- Outside/OAI158Stationary: 23 records (4 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.inner
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.inner_norm
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.outer
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.inner_add
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.inner_smul
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.outer_add
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.outer_smul
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average_add
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average_smul
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average_mono
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average_const
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average_translation
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.average_rotation
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.functional
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.measure
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.instIsFiniteMeasureMeasure
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.instRegularMeasure
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.integral
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.instIsProbabilityMeasureMeasure
#print axioms HadwigerNelson.Outside.OAI158.StationaryMean.preserving_of_average
#print axioms HadwigerNelson.Outside.OAI158.Spectral.K_countable
#print axioms HadwigerNelson.Outside.OAI158.Spectral.exists_terminal_factor
-- Outside/OAI158AlgebraModels: 38 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_sub_left
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_sub_right
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_norm_left
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_norm_right
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.meanNorm_zero_of_dense
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_zero_of_dense
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.graph_mixture
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.map_mixture
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.square_fiber
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.law_map_base
#print axioms HadwigerNelson.Outside.OAI158.RelativeProduct.conditional_square
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_tensor
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.factor_preserving
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_tensor
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_tensor_mean_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.FiniteTensor
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.FiniteTensor.zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.FiniteTensor.sum
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.func_sum_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.codeCell
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor_code_finite
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.finiteTensor_dense
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.pairVanishing_of_covariance
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.square_equivariant
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.covariance_finiteTensor_mean_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.square_pairVanishing
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.square_tensor_centered
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.tensor_prod
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.centered_conditional_mean_zero
#print axioms HadwigerNelson.Outside.OAI158.AlgebraReplacement.prod_sub_prod
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.conditional_sum
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_multiple_mean_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.scaleHom
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.scaleHom_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.scaleHom_add
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.scaleHom_sub
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.shifted_admissible
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_integer_multiple_mean_zero
-- Outside/OAI158Representations: 88 records (11 instances, 1 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Spectral.Rot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instAddCommGroupRot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instTopologicalSpaceRot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instDiscreteTopologyRot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotMul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.mulRot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotMul_mulRot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.mulRot_rotMul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotAction
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rot_vadd
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotMeasurable
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotInvariant
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rotErgodic
#print axioms HadwigerNelson.Outside.OAI158.Spectral.rot_zsmul_surjective
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.Proper
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.Space
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.closed_proper
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.instCompactSpaceSpace
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.trans
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotate
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.trans_apply
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotate_apply
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.trans_continuous
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotate_continuous
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.trans_zero
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.trans_add
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotate_one
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotate_mul
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.covariance
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.transHomeo
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotateHomeo
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.Trans
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.tr
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.ro
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.measure
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.instIsProbabilityMeasureSpaceMeasure
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.trans_preserving
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotate_preserving
#print axioms HadwigerNelson.Outside.OAI158.Koopman.isometry
#print axioms HadwigerNelson.Outside.OAI158.Koopman.unitary
#print axioms HadwigerNelson.Outside.OAI158.Koopman.unitary_apply
#print axioms HadwigerNelson.Outside.OAI158.Koopman.nonlinear_commute
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.op
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.op_zero
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.op_add
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.op_comm
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.norm_op
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.dist_op
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.space
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.mem_space
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.isClosed_space
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.instCompleteSpaceSubtypeMemSubmoduleComplexSpace
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.op_mem
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.orbit_continuous
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.Hilbert
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.translation
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotation
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.translation_apply
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotation_apply
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.representation
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.op_apply
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.rotation_covariance
#print axioms HadwigerNelson.Outside.OAI158.projection_fixed_of_contraction
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.nonlinear_mem
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.clamp
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.clamp_lipschitz
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.clamp_zero
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.clamp_range
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.clamp_eq
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.projection_range
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.covariance_mem
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.projection_covariance_fixed
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.op_orthogonal
#print axioms HadwigerNelson.Outside.OAI158.ContinuousVectors.projection_coefficient
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.realCM
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.realCM_apply
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.realCM_add
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.realCM_sub
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.realCM_smul
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.realCM_one
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.real_nonneg
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.functional
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.measure
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.instIsFiniteMeasureMeasure
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.instRegularMeasure
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.integral_real
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.integral_complex
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.measure_univ
-- Outside/OAI158Energy: 49 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.approxAt
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.approx_norm_le
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.approx_has_limit
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.meanAt
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.tendsto_approx
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.mean_add
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.mean_smul
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.mean_const
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.mean_nonneg
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.mean_norm_le
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.mean_shift
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.meanCLM
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.meanCLM_apply
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.toMean
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.instDecidableEq_proofs
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.cubeSupport
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.cube_le_of_support
#print axioms HadwigerNelson.Outside.OAI158.MovingMean.syndetic_of_all_means
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.energy
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.energy_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.energy_mean_eq_of_meanNorm_zero
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.Family.avg_const
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.normSquare
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.normSquare_apply
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.integral_normSquare
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.inner_normSquare
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.avg_orbit_const
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.pair_energy_mean
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.energy_two_orbits
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.two_orbit_energy_mean
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.factor_ergodic
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_pair_energy
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_integer_pair_energy
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.conditional_integer_triple_energy
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.norm_char
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_add
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_neg
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_act
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_nonneg
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projected_char_bound
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_le_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.differenceFourier_projectedMass
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_rotation
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_radial
-- Outside/OAI158SpectralMeasure: 56 records (3 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.inner_toLp
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.vectorLinear
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.norm_toLp
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicMap
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicMap_toLp
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.norm_cyclicMap
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicIsometry
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLp
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLp_ae
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLpLinear
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLp_norm_le
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLpCLM
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLpCLM_ae
#print axioms HadwigerNelson.Outside.OAI158.BoundedMeasurable.mulLp_l2
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.algebra
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.algebra_closed
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.adjoin_comm
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.algebra_commRing
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.algebra_commCStar
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.generator
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.generator_one
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.generator_mul
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.generator_unitary
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.Spectrum
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.character
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.character_apply
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.character_continuous
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.calculus
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.evaluation
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.calculus_evaluation
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.boundedCM
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.boundedCM_apply
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.boundedCM_toLp
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.mulCM_toLp
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicMap_mul
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicMap_one
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicMap_inner
#print axioms HadwigerNelson.Outside.OAI158.VectorMeasure.cyclicMap_pair_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryIndicator
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryIndicator_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinary_eval_continuous
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinary_difference_tendsto
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryVector
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ordinaryVector_continuous
#print axioms HadwigerNelson.Outside.OAI158.Spectral.measure_ordinary_zero_of_orthogonal
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.evaluation_one
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.evaluation_mul
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.star_evaluation
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.evaluationHom
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.evaluation_span_dense
#print axioms HadwigerNelson.Outside.OAI158.CompactIntegral.integrableCM
#print axioms HadwigerNelson.Outside.OAI158.CompactIntegral.linear
#print axioms HadwigerNelson.Outside.OAI158.CompactIntegral.norm_le
#print axioms HadwigerNelson.Outside.OAI158.CompactIntegral.clm
#print axioms HadwigerNelson.Outside.OAI158.CompactIntegral.apply_clm
#print axioms HadwigerNelson.Outside.OAI158.CommutingSpectral.measure_eq_of_fourier
-- Outside/OAI158RadialEnergy: 28 records (0 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Spectral.equal_moduli_quadratic
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_pair_mean
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_scale_two
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_scale_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_two_term
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_three_term
#print axioms HadwigerNelson.Outside.OAI158.Spectral.quadratic_mass_inequality
#print axioms HadwigerNelson.Outside.OAI158.Spectral.sqrtF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.sqrtF_sq
#print axioms HadwigerNelson.Outside.OAI158.Spectral.norm_ofF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.massReal
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_neg
#print axioms HadwigerNelson.Outside.OAI158.Spectral.massReal_abs
#print axioms HadwigerNelson.Outside.OAI158.Spectral.massReal_difference
#print axioms HadwigerNelson.Outside.OAI158.Spectral.reF_sum
#print axioms HadwigerNelson.Outside.OAI158.Spectral.reF_zsmul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.reF_nsmul
#print axioms HadwigerNelson.Outside.OAI158.Spectral.selected_mass_bound
#print axioms HadwigerNelson.Outside.OAI158.Spectral.circle_realPart
#print axioms HadwigerNelson.Outside.OAI158.Spectral.cover_mass_positive
#print axioms HadwigerNelson.Outside.OAI158.Spectral.kCoeff_scale_neg_one
#print axioms HadwigerNelson.Outside.OAI158.Spectral.char_symmetric
#print axioms HadwigerNelson.Outside.OAI158.Spectral.radiusFamily
#print axioms HadwigerNelson.Outside.OAI158.Spectral.radiusFamily_apply
#print axioms HadwigerNelson.Outside.OAI158.Spectral.radiusFamily_mean
#print axioms HadwigerNelson.Outside.OAI158.Spectral.radius_syndetic
#print axioms HadwigerNelson.Outside.OAI158.Spectral.radial_positive_near_zero
#print axioms HadwigerNelson.Outside.OAI158.Spectral.massReal_vanish
-- Outside/OAI158Ergodicity: 41 records (1 instances, 0 derived instances, 0 private)
#print axioms HadwigerNelson.Outside.OAI158.Spectral.normF
#print axioms HadwigerNelson.Outside.OAI158.Spectral.normF_coe
#print axioms HadwigerNelson.Outside.OAI158.Spectral.normF_pos
#print axioms HadwigerNelson.Outside.OAI158.Spectral.projectedMass_vanish
#print axioms HadwigerNelson.Outside.OAI158.Spectral.fourier_vanish_of_terminal
#print axioms HadwigerNelson.Outside.OAI158.Spectral.ergodic_wild_fourier
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.vector_mem_closedConvexHull
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.apply
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.norm_le
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.of_mem_convexHull
#print axioms HadwigerNelson.Outside.OAI158.Amenable.Mean.exists_finite_approx
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.bm
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.bm_apply
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.bm_bound
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.l2_bm
#print axioms HadwigerNelson.Outside.OAI158.InvariantSequence.limit
#print axioms HadwigerNelson.Outside.OAI158.InvariantSequence.limit_measurable
#print axioms HadwigerNelson.Outside.OAI158.InvariantSequence.limit_fixed
#print axioms HadwigerNelson.Outside.OAI158.InvariantSequence.exists_averages
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.setIntegral_bm
#print axioms HadwigerNelson.Outside.OAI158.ConvexAverage.setIntegral_of_limit
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.testSet
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.measurable_testSet
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.testSet_union
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.pi_testSet
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.generate_testSet
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.test
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.test_apply
#print axioms HadwigerNelson.Outside.OAI158.ErgodicCriterion.ergodic_of_test_limits
#print axioms HadwigerNelson.Outside.OAI158.InvariantDecomposition.code
#print axioms HadwigerNelson.Outside.OAI158.InvariantDecomposition.code_measurable
#print axioms HadwigerNelson.Outside.OAI158.InvariantDecomposition.code_fixed
#print axioms HadwigerNelson.Outside.OAI158.InvariantDecomposition.fiber_invariant
#print axioms HadwigerNelson.Outside.OAI158.InvariantDecomposition.fiber_ergodic
#print axioms HadwigerNelson.Outside.OAI158.Spectral.instCountableRot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.smul_ergodic_of_rot
#print axioms HadwigerNelson.Outside.OAI158.Spectral.wild_fourier
#print axioms HadwigerNelson.Outside.OAI158.Spectral.finite_wild_fourier
#print axioms HadwigerNelson.Outside.OAI158.Spectral.vectorMeasure_invariant
#print axioms HadwigerNelson.Outside.OAI158.Spectral.residual_fourier
-- Outside/OAI158BorelTransfer: 54 records (1 instances, 0 derived instances, 1 private)
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.colorValue
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.color_memLp
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.colorVector
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.color_ae
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.color_rotation_fixed
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.color_unit_correlation
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.continuous_complete
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.projected
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.projected_range
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.projected_rotation_fixed
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.projected_unit_correlation
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.oneVector
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.one_ae
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.one_fixed
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.one_continuous
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.color_sum
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.projected_sum
#print axioms HadwigerNelson.Outside.OAI158.Spectral.dense_E
#print axioms HadwigerNelson.Outside.OAI158.Spectral.algebraic_norm
#print axioms HadwigerNelson.Outside.OAI158.Spectral.orbit_uniformContinuous
#print axioms HadwigerNelson.Outside.OAI158.Spectral.orbitExtension
#print axioms HadwigerNelson.Outside.OAI158.Spectral.orbitExtension_continuous
#print axioms HadwigerNelson.Outside.OAI158.Spectral.orbitExtension_eq
#print axioms HadwigerNelson.Outside.OAI158.Spectral.orbitExtension_inner
#print axioms HadwigerNelson.Outside.OAI158.Spectral.normalized_algebraic
#print axioms HadwigerNelson.Outside.OAI158.Spectral.circle_closed_induction
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.projected_continuous
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.fieldVector
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.fieldVector_continuous
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.fieldVector_algebraic
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.fieldVector_sum
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.fieldVector_range
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.fieldVector_unit_correlation
#print axioms HadwigerNelson.Outside.OAI158.dense_approx
#print axioms HadwigerNelson.Outside.OAI158.approxIndex
#print axioms HadwigerNelson.Outside.OAI158.index_measurable
#print axioms HadwigerNelson.Outside.OAI158.index_bound
#print axioms HadwigerNelson.Outside.OAI158.approxField
#print axioms HadwigerNelson.Outside.OAI158.approxField_measurable
#print axioms HadwigerNelson.Outside.OAI158.approxField_tendsto
#print axioms HadwigerNelson.Outside.OAI158.measurableField
#print axioms HadwigerNelson.Outside.OAI158.measurableField_measurable
#print axioms HadwigerNelson.Outside.OAI158.exists_measurable_field
#print axioms HadwigerNelson.Outside.OAI158.positive_orthogonal
#print axioms HadwigerNelson.Outside.OAI158.LabelModel.exists_label_field
#print axioms HadwigerNelson.Outside.OAI158.positiveSupport
#print axioms HadwigerNelson.Outside.OAI158.positiveSupport_measurable
#print axioms HadwigerNelson.Outside.OAI158.positiveSelect
#print axioms HadwigerNelson.Outside.OAI158.positiveSelect_measurable
#print axioms HadwigerNelson.Outside.OAI158.positiveSelect_pos
#print axioms HadwigerNelson.Outside.OAI158.sample_field
#print axioms HadwigerNelson.Outside.OAI158.proper_to_borel_weak
#print axioms HadwigerNelson.Outside.OAI158.proper_to_weak
section
open private HadwigerNelson.Outside.OAI158.pickSupport from Proofs.HadwigerNelson.Outside.OAI158BorelTransfer
#print axioms HadwigerNelson.Outside.OAI158.pickSupport
end
-- FS131-IPD1 block end

/-! ## FS133-LD1 — the landing of FS-133, the one-class transfer (claims K1): the density equality, `Outside/OAI158Rigidity` and `Plane/OneClass`

`α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` and the labelling claim both ways
(FS133-K1's statements; FS133-IA1, -IB1, -IB2, -ICD1 and -IPQ1's proofs).  The module first rested on
`Outside.OAI158.Spectral.residual_fourier` declared as an axiom over six copied definitions; at this landing the copies and
the axiom are gone, the port's theorem of that name is read (`Outside/OAI158Ergodicity`; its record is in FS131-IPD1's
generated block above, with the six definitions'), and every record below is on the standard three or fewer.  One record per
theorem and definition a person typed, as FS133-K1's plan (§ 5.5) and FS133-ICD1's list file them — structures included, their
generated fields, recursors and constructors not; private helpers not.  Fourteen of them rested on the declared theorem before
the join (the plan's § 5.5 IMPORTED list); `tools/fs133_ld1_records.py` reads the audit's log against `data/fs133/ld1/records.txt`. -/
-- FS133-LD1 block: `Outside/OAI158Rigidity` — 2 records (2 theorems); one of them (`residual_fourier_cross`) rested on the declared `residual_fourier` before the join
#print axioms HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_cross
#print axioms HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_model
-- FS133-LD1 block: `Plane/OneClass/SectionDensity` — 9 records (8 theorems, 1 definition or structure)
#print axioms HadwigerNelson.Plane.exists_mem_le_sectionDensity
#print axioms HadwigerNelson.Plane.le_lintegral_sectionDensity
#print axioms HadwigerNelson.Plane.measurable_sectionDensity
#print axioms HadwigerNelson.Plane.measure_le_sectionDensity_pos
#print axioms HadwigerNelson.Plane.ofReal_integral_le_measure_pos
#print axioms HadwigerNelson.Plane.sectionDensity
#print axioms HadwigerNelson.Plane.sectionDensity_empty
#print axioms HadwigerNelson.Plane.sectionDensity_setOf_pos
#print axioms HadwigerNelson.Plane.sectionDensity_univ
-- FS133-LD1 block: `Plane/OneClass/Defs` — 28 records (19 theorems, 9 definitions and structures)
#print axioms HadwigerNelson.OneClass.countable_algPlane
#print axioms SimpleGraph.finIndepRatio
#print axioms SimpleGraph.le_finIndepRatio_iff
#print axioms SimpleGraph.finIndepRatio_le_of_forall_card_le
#print axioms SimpleGraph.finIndepRatio_le_one
#print axioms SimpleGraph.finIndepRatio_le_of_embedding
#print axioms SimpleGraph.inv_le_finIndepRatio_of_colorable
#print axioms SimpleGraph.inv_finIndepRatio_le_iSup_fractionalChromaticNumber
#print axioms HadwigerNelson.Plane.mOne
#print axioms HadwigerNelson.Plane.isIndepSet_unitDistance_iff
#print axioms HadwigerNelson.Plane.upperDensity_le_mOne
#print axioms HadwigerNelson.Plane.mOne_le_iff
#print axioms HadwigerNelson.Plane.mOne_le_one
#print axioms HadwigerNelson.Plane.isIndepSet_ball_half
#print axioms HadwigerNelson.Plane.mOne_eq_iSup_nullMeasurableSet
#print axioms HadwigerNelson.Plane.minIndepNum
#print axioms HadwigerNelson.Plane.minIndepNum_one
#print axioms HadwigerNelson.OneClass.algPlaneEmbedding
#print axioms HadwigerNelson.OneClass.shiftLab
#print axioms HadwigerNelson.OneClass.turnLab
#print axioms HadwigerNelson.OneClass.IsShiftInvariantLaw
#print axioms HadwigerNelson.OneClass.IsInvariantLaw
#print axioms HadwigerNelson.OneClass.IsPlaneSystem
#print axioms HadwigerNelson.OneClass.IsInvariantLaw.isPlaneSystem
#print axioms HadwigerNelson.OneClass.isInvariantLaw_dirac
#print axioms HadwigerNelson.Plane.upperDensity_congr_ae
#print axioms SimpleGraph.card_le_indepNum_induce
#print axioms SimpleGraph.exists_indep_card_eq_indepNum
-- FS133-LD1 block: `Plane/OneClass/InvariantLaw` — 9 records (9 theorems)
#print axioms HadwigerNelson.OneClass.exists_foelner_finset
#print axioms HadwigerNelson.OneClass.exists_invariant_of_closed
#print axioms HadwigerNelson.OneClass.exists_isInvariantLaw
#print axioms HadwigerNelson.OneClass.exists_isInvariantLaw_unitDistance
#print axioms HadwigerNelson.OneClass.exists_shiftInvariant_of_foelner
#print axioms HadwigerNelson.OneClass.exists_turnInvariant
#print axioms HadwigerNelson.OneClass.norm_kCoeff_mul
#print axioms HadwigerNelson.OneClass.unitDistance_algPlane_eq_circulantGraph
#print axioms HadwigerNelson.OneClass.IsShiftInvariantLaw.measure_origin_le
-- FS133-LD1 block: `Plane/OneClass/Field` — 1 record (1 theorem), which rested on the declared `residual_fourier` before the join
#print axioms HadwigerNelson.OneClass.exists_field
-- FS133-LD1 block: `Plane/OneClass/Algebraic` — 9 records (9 theorems); 6 of them rested on the declared `residual_fourier` before the join
#print axioms HadwigerNelson.OneClass.exists_measurable_indep_of_field
#print axioms HadwigerNelson.OneClass.IsInvariantLaw.measure_origin_le_mOne
#print axioms HadwigerNelson.OneClass.mOne_le_finIndepRatio
#print axioms HadwigerNelson.OneClass.finIndepRatio_algPlane_le_mOne
#print axioms HadwigerNelson.OneClass.finIndepRatio_plane_eq_mOne
#print axioms HadwigerNelson.OneClass.finIndepRatio_algPlane_eq_mOne
#print axioms HadwigerNelson.OneClass.one_seventh_le_mOne
#print axioms HadwigerNelson.OneClass.tendsto_minIndepNum_div_finIndepRatio
#print axioms HadwigerNelson.OneClass.tendsto_minIndepNum_div
-- FS133-LD1 block: `Plane/OneClass/Fractional` — 7 records (7 theorems); 3 of them rested on the declared `residual_fourier` before the join
#print axioms HadwigerNelson.OneClass.exists_periodic_indep
#print axioms HadwigerNelson.OneClass.exists_fold_cover
#print axioms HadwigerNelson.OneClass.fractionalChromaticNumber_plane_le
#print axioms HadwigerNelson.OneClass.fractionalChromaticNumber_induce_le
#print axioms HadwigerNelson.OneClass.fractionalChromaticNumber_plane
#print axioms HadwigerNelson.OneClass.iSup_fractionalChromaticNumber_plane
#print axioms HadwigerNelson.OneClass.fractionalChromaticNumber_algPlane
-- FS133-LD1 block: `Plane/OneClass/Pair` — 12 records (8 theorems, 4 definitions and structures); 3 of them rested on the declared `residual_fourier` before the join
#print axioms HadwigerNelson.OneClass.AdmissibleOn
#print axioms HadwigerNelson.OneClass.AdmissibleAe
#print axioms HadwigerNelson.OneClass.IsAlgPattern
#print axioms HadwigerNelson.OneClass.colourPattern
#print axioms HadwigerNelson.OneClass.admissibleOn_colourPattern_iff
#print axioms HadwigerNelson.OneClass.isAlgPattern_colourPattern
#print axioms HadwigerNelson.OneClass.exists_admissible_colourPattern_seven
#print axioms HadwigerNelson.OneClass.AdmissibleOn.mono
#print axioms HadwigerNelson.OneClass.exists_measurable_admissibleAe
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_of_ae
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_ae
#print axioms HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_algPlane
-- FS133-LD1 block end

/-! ## FS131-LDB1 — the landing of the density bound: `[AmbrusEtAl2023]` Theorem 1, `Plane.OneAvoidingDensityBound`

Every Lebesgue-measurable planar set with no two points at distance one has upper density at most `0.2470`
(`HadwigerNelson.Plane.oneAvoidingDensityBound`, `Plane/DensityBound/Theorem`), proved from the paper's certificate with no
periodic reduction and no Bessel citation (FS131-KDB1's statements; FS131-IDB1, -IDB2 and -IDB3's proofs).  The three blocks
below are the three implementers' drafts, filed unchanged and in landing order: FS131-IDB1's (its record § 5.3,
`data/fs131/idb1/audit-block.txt`, 264 records), FS131-IDB2's (§ 5.3, `data/fs131/idb2/audit-block.txt`, 41 records, `Plane.mOne` replaced by the ruled bridge
`Plane.mOne_eq_iSup_bandFree`: the brief's Amendment deleted this line's `mOne`) and
FS131-IDB3's (D1, `data/fs131/idb3/audit-block.txt`, 418 records) — each the public constants of its modules as the kernel
stores them, inductive types, constructors and recursors left out (their structures' other generated declarations kept, as
the drafts list them), the 847 cell theorems and 847 cell definitions of `Cells/Part00`–`Part45` read through their parts'
`segNN_ok`, whose proofs name every one.  Every record is under CLEAN: none of the 83 modules reads a declared outside
theorem.  `tools/fs131_ldb1_records.py` reads the audit's log against the kernel's list of the 83 modules
(`data/fs131/ldb1/lean/Coverage.lean`): every public constant a record or reached from one. -/
-- FS131-IDB1 block: `Plane/DensityBound/Bessel` — 16 records (13 theorems, 3 definitions)
#print axioms HadwigerNelson.DensityBound.J0
#print axioms HadwigerNelson.DensityBound.antitoneOn_norm_Jc
#print axioms HadwigerNelson.DensityBound.continuous_J1
#print axioms HadwigerNelson.DensityBound.circleAverage_exp_inner
#print axioms HadwigerNelson.DensityBound.abs_J1_le_one
#print axioms HadwigerNelson.DensityBound.hasDerivAt_J1
#print axioms HadwigerNelson.DensityBound.continuous_J0
#print axioms HadwigerNelson.DensityBound.J0_zero
#print axioms HadwigerNelson.DensityBound.J1
#print axioms HadwigerNelson.DensityBound.hasDerivAt_J0
#print axioms HadwigerNelson.DensityBound.J1_zero
#print axioms HadwigerNelson.DensityBound.Jc
#print axioms HadwigerNelson.DensityBound.J0_eq_integral
#print axioms HadwigerNelson.DensityBound.J1_eq_integral
#print axioms HadwigerNelson.DensityBound.abs_J0_le_one
#print axioms HadwigerNelson.DensityBound.abs_J0_sub_le
-- FS131-IDB1 block: `Plane/DensityBound/BesselDefect` — 5 records (4 theorems, 1 definitions)
#print axioms HadwigerNelson.DensityBound.besselField
#print axioms HadwigerNelson.DensityBound.norm_Jc_sub_le_of_defect
#print axioms HadwigerNelson.DensityBound.abs_J0_sub_re_le
#print axioms HadwigerNelson.DensityBound.hasDerivAt_Jc
#print axioms HadwigerNelson.DensityBound.abs_J0_le_of_le
-- FS131-IDB1 block: `Plane/DensityBound/BesselCheck` — 105 records (12 theorems, 93 definitions)
#print axioms HadwigerNelson.DensityBound.BesselCert.termOk
#print axioms HadwigerNelson.DensityBound.BesselCert.decode
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.mk.inj
#print axioms HadwigerNelson.DensityBound.BesselCert.dL
#print axioms HadwigerNelson.DensityBound.BesselCert.H71
#print axioms HadwigerNelson.DensityBound.BesselCert.absL
#print axioms HadwigerNelson.DensityBound.BesselCert.coreOf
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.w
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.exit
#print axioms HadwigerNelson.DensityBound.BesselCert.affX
#print axioms HadwigerNelson.DensityBound.BesselCert.pw
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.mk.injEq
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.R0
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.mk.inj
#print axioms HadwigerNelson.DensityBound.BesselCert.derivAux
#print axioms HadwigerNelson.DensityBound.BesselCert.addL
#print axioms HadwigerNelson.DensityBound.BesselCert.AllOk
#print axioms HadwigerNelson.DensityBound.BesselCert.cdiv
#print axioms HadwigerNelson.DensityBound.BesselCert.St.r
#print axioms HadwigerNelson.DensityBound.BesselCert.tailCheck
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.recOn
#print axioms HadwigerNelson.DensityBound.BesselCert.St.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.q
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.err
#print axioms HadwigerNelson.DensityBound.BesselCert.cellCheck
#print axioms HadwigerNelson.DensityBound.BesselCert.St.casesOn
#print axioms HadwigerNelson.DensityBound.BesselCert.rnd
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.recOn
#print axioms HadwigerNelson.DensityBound.BesselCert.instDecidableCellOk
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.mk.inj
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.TN
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.recOn
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.mk.injEq
#print axioms HadwigerNelson.DensityBound.BesselCert.St.ctorIdx
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.BesselCert.St.noConfusionType
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.WS
#print axioms HadwigerNelson.DensityBound.BesselCert.S
#print axioms HadwigerNelson.DensityBound.BesselCert.instDecidableEqSt.decEq
#print axioms HadwigerNelson.DensityBound.BesselCert.initStates
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.mk.injEq
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.t0
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.ctorIdx
#print axioms HadwigerNelson.DensityBound.BesselCert.evZ
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.smulL
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.casesOn
#print axioms HadwigerNelson.DensityBound.BesselCert.F216
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.entry
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.ctorIdx
#print axioms HadwigerNelson.DensityBound.BesselCert.core
#print axioms HadwigerNelson.DensityBound.BesselCert.F72
#print axioms HadwigerNelson.DensityBound.BesselCert.St.mk.inj
#print axioms HadwigerNelson.DensityBound.BesselCert.instDecidableEqSt
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.casesOn
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.termsOut
#print axioms HadwigerNelson.DensityBound.BesselCert.T2
#print axioms HadwigerNelson.DensityBound.BesselCert.instReprSt
#print axioms HadwigerNelson.DensityBound.BesselCert.taylorAux
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.casesOn
#print axioms HadwigerNelson.DensityBound.BesselCert.CellOk
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.P1
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.ctorIdx
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.noConfusionType
#print axioms HadwigerNelson.DensityBound.BesselCert.St.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.w1N
#print axioms HadwigerNelson.DensityBound.BesselCert.chainExit
#print axioms HadwigerNelson.DensityBound.BesselCert.taylor
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.P0
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.noConfusionType
#print axioms HadwigerNelson.DensityBound.BesselCert.St.mk.injEq
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.R1
#print axioms HadwigerNelson.DensityBound.BesselCert.instReprSt.repr
#print axioms HadwigerNelson.DensityBound.BesselCert.quadOk
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.N
#print axioms HadwigerNelson.DensityBound.BesselCert.powScale
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.BesselCert.xList
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.Linked
#print axioms HadwigerNelson.DensityBound.BesselCert.tailSum
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.ok
#print axioms HadwigerNelson.DensityBound.BesselCert.St.m0
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.Ws
#print axioms HadwigerNelson.DensityBound.BesselCert.Core.noConfusionType
#print axioms HadwigerNelson.DensityBound.BesselCert.St.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.St.m1
#print axioms HadwigerNelson.DensityBound.BesselCert.K
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.TD
#print axioms HadwigerNelson.DensityBound.BesselCert.termNext
#print axioms HadwigerNelson.DensityBound.BesselCert.St.recOn
#print axioms HadwigerNelson.DensityBound.BesselCert.Wh
#print axioms HadwigerNelson.DensityBound.BesselCert.evF
#print axioms HadwigerNelson.DensityBound.BesselCert.SC
#print axioms HadwigerNelson.DensityBound.BesselCert.shiftL
#print axioms HadwigerNelson.DensityBound.BesselCert.Params.Ds
#print axioms HadwigerNelson.DensityBound.BesselCert.F144
#print axioms HadwigerNelson.DensityBound.BesselCert.CellSpec.noConfusion
#print axioms HadwigerNelson.DensityBound.BesselCert.chainEnd
#print axioms HadwigerNelson.DensityBound.BesselCert.decodeAux
#print axioms HadwigerNelson.DensityBound.BesselCert.homogL
-- FS131-IDB1 block: `Plane/DensityBound/BesselCert` — 83 records (77 theorems, 6 definitions)
#print axioms HadwigerNelson.DensityBound.BesselCert.core_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.S_real
#print axioms HadwigerNelson.DensityBound.BesselCert.abs_ev_le
#print axioms HadwigerNelson.DensityBound.BesselCert.evF_zero
#print axioms HadwigerNelson.DensityBound.BesselCert.termsOut_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.cast_Wh
#print axioms HadwigerNelson.DensityBound.BesselCert.chain_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.defect_re
#print axioms HadwigerNelson.DensityBound.BesselCert.cast_natAbs_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.termsOut_cons
#print axioms HadwigerNelson.DensityBound.BesselCert.Close
#print axioms HadwigerNelson.DensityBound.BesselCert.AllOk.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.ev.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.derivAux.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.addL.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.mul_ev_le_cdiv
#print axioms HadwigerNelson.DensityBound.BesselCert.chainExit.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.term_le_of_close
#print axioms HadwigerNelson.DensityBound.BesselCert.allOk_append
#print axioms HadwigerNelson.DensityBound.BesselCert.ev
#print axioms HadwigerNelson.DensityBound.BesselCert.evF.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.Wh.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.shiftL.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.pp
#print axioms HadwigerNelson.DensityBound.BesselCert.cast_evZ
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_smulL
#print axioms HadwigerNelson.DensityBound.BesselCert.abs_J0_tail
#print axioms HadwigerNelson.DensityBound.BesselCert.evF_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_nil
#print axioms HadwigerNelson.DensityBound.BesselCert.jsum
#print axioms HadwigerNelson.DensityBound.BesselCert.pw_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.defect_im_mul
#print axioms HadwigerNelson.DensityBound.BesselCert.pw.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.affX.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.St.Valid
#print axioms HadwigerNelson.DensityBound.BesselCert.close_self
#print axioms HadwigerNelson.DensityBound.BesselCert.mul_ev_le_cdiv'
#print axioms HadwigerNelson.DensityBound.BesselCert.tailSum_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.tailSum.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.coreOf_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.besselField_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.defect_im_zero
#print axioms HadwigerNelson.DensityBound.BesselCert.Linked.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.covering_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.valid_iff
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_derivAux_succ
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_homogL
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_absL_nonneg
#print axioms HadwigerNelson.DensityBound.BesselCert.smulL.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.pw_pos
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_eq_Wh_div
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_affX
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_cons
#print axioms HadwigerNelson.DensityBound.BesselCert.tailCheck_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.StatesValid
#print axioms HadwigerNelson.DensityBound.BesselCert.SC_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.hasDerivAt_pp
#print axioms HadwigerNelson.DensityBound.BesselCert.statesValid_init
#print axioms HadwigerNelson.DensityBound.BesselCert.jsum.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.SC_pos
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_dL_cons
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_addL
#print axioms HadwigerNelson.DensityBound.BesselCert.absL.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.abs_div_sub_le_cdiv
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_split
#print axioms HadwigerNelson.DensityBound.BesselCert.T2_pos
#print axioms HadwigerNelson.DensityBound.BesselCert.cellCheck_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.quadOk_sound
#print axioms HadwigerNelson.DensityBound.BesselCert.hasDerivAt_ev
#print axioms HadwigerNelson.DensityBound.BesselCert.defect_im
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_shiftL
#print axioms HadwigerNelson.DensityBound.BesselCert.ev_powScale
#print axioms HadwigerNelson.DensityBound.BesselCert.jsum_eq_sum
#print axioms HadwigerNelson.DensityBound.BesselCert.le_cdiv
#print axioms HadwigerNelson.DensityBound.BesselCert.powScale.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.homogL.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.chainEnd.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.evZ.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.K_eq
#print axioms HadwigerNelson.DensityBound.BesselCert.K_pos
#print axioms HadwigerNelson.DensityBound.BesselCert.S_pos
#print axioms HadwigerNelson.DensityBound.BesselCert.termsOut.eq_def
#print axioms HadwigerNelson.DensityBound.BesselCert.defect_bound
-- FS131-IDB1 block: the generated `Plane/DensityBound/Cells/*` — 55 records (51 theorems, 4 definitions): `P23`, each part's `segNN_ok` (which reads every cell theorem of its part), and `Covering`'s
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.P23
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg00_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg01_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg02_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg03_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg04_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg05_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg06_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg07_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg08_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg09_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg10_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg11_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg12_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg13_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg14_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg15_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg16_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg17_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg18_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg19_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg20_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg21_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg22_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg23_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg24_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg25_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg26_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg27_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg28_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg29_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg30_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg31_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg32_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg33_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg34_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg35_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg36_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg37_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg38_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg39_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg40_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg41_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg42_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg43_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg44_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.seg45_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.allCells_ok
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.code0_init
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.allCells_tail
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.allCells_linked
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.phiApprox_ge
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.allCells
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.code0
#print axioms HadwigerNelson.DensityBound.BesselCert.Cells.us23
-- FS131-IDB1 block end
-- FS131-IDB2 block: `Plane/DensityBound/Autocorr`, `Pattern`, `Window` and `Plane/OneAvoidingDensity` — 41 records, in stored order (FS131-IDB2 § 5.3; `mOne` replaced by the bridge, the brief's Amendment)
#print axioms HadwigerNelson.DensityBound.autocorr
#print axioms HadwigerNelson.DensityBound.autocorr_eq_zero_of_norm_eq_one
#print axioms HadwigerNelson.DensityBound.continuous_autocorr
#print axioms HadwigerNelson.DensityBound.circleAvg_autocorr_zero
#print axioms HadwigerNelson.DensityBound.sum_circleAvg_autocorr_nonneg
#print axioms HadwigerNelson.DensityBound.circleAvg_autocorr_one
#print axioms HadwigerNelson.DensityBound.DualCert.casesOn
#print axioms HadwigerNelson.DensityBound.DualCert.noConfusion
#print axioms HadwigerNelson.DensityBound.DualCert.w1
#print axioms HadwigerNelson.DensityBound.DualCert.Valid.casesOn
#print axioms HadwigerNelson.DensityBound.DualCert.phi
#print axioms HadwigerNelson.DensityBound.DualCert.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.DualCert.wc
#print axioms HadwigerNelson.DensityBound.DualCert.w2
#print axioms HadwigerNelson.DensityBound.DualCert.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.trivialCert
#print axioms HadwigerNelson.DensityBound.trivialCert_valid
#print axioms HadwigerNelson.DensityBound.DualCert.mk.injEq
#print axioms HadwigerNelson.DensityBound.DualCert.recOn
#print axioms HadwigerNelson.DensityBound.DualCert.L
#print axioms HadwigerNelson.DensityBound.DualCert.window_bound
#print axioms HadwigerNelson.DensityBound.DualCert.mk.inj
#print axioms HadwigerNelson.DensityBound.DualCert.Congruent
#print axioms HadwigerNelson.DensityBound.DualCert.Valid.bound_nonneg
#print axioms HadwigerNelson.DensityBound.DualCert.Valid.recOn
#print axioms HadwigerNelson.DensityBound.DualCert.noConfusionType
#print axioms HadwigerNelson.DensityBound.DualCert.bound
#print axioms HadwigerNelson.DensityBound.DualCert.IsIndep
#print axioms HadwigerNelson.DensityBound.DualCert.ctorIdx
#print axioms HadwigerNelson.DensityBound.DualCert.Valid.cong
#print axioms HadwigerNelson.DensityBound.DualCert.X
#print axioms HadwigerNelson.DensityBound.DualCert.Valid.atoms
#print axioms HadwigerNelson.DensityBound.DualCert.window_le
#print axioms HadwigerNelson.DensityBound.DualCert.oneAvoidingDensityBound_of
#print axioms HadwigerNelson.DensityBound.DualCert.limsup_le
#print axioms HadwigerNelson.Plane.oneAvoidingDensityBound_model
#print axioms HadwigerNelson.Plane.OneAvoidingDensityBound
#print axioms HadwigerNelson.Plane.mOne_le_of_oneAvoidingDensityBound
#print axioms HadwigerNelson.Plane.upperDensity_le_of_oneAvoidingDensityBound
-- the brief's Amendment (2026-10-14): this module's `def mOne` is deleted (`main`'s, `Plane/OneClass/Defs`, is audited in
-- FS133-LD1's block above), and the ruled bridge takes its place
#print axioms HadwigerNelson.Plane.mOne_eq_iSup_bandFree
#print axioms HadwigerNelson.Plane.mOne_lt_quarter
-- FS131-IDB2 block end
-- FS131-IDB3 block: the certificate's 27 modules, `Plane/DensityBound/X23Check` … `Theorem` — 418 records, in stored order (FS131-IDB3 D1); `HadwigerNelson.Plane.oneAvoidingDensityBound` among them
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.noConfusion
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.K
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.X23Check.collect
#print axioms HadwigerNelson.DensityBound.X23Check.C4.cond
#print axioms HadwigerNelson.DensityBound.X23Check.inGroup
#print axioms HadwigerNelson.DensityBound.X23Check.highMul
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.ctorIdx
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.beq
#print axioms HadwigerNelson.DensityBound.X23Check.C4.noConfusionType
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.u3
#print axioms HadwigerNelson.DensityBound.X23Check.termOk
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.l3
#print axioms HadwigerNelson.DensityBound.X23Check.S64
#print axioms HadwigerNelson.DensityBound.X23Check.rowOk
#print axioms HadwigerNelson.DensityBound.X23Check.adjOk
#print axioms HadwigerNelson.DensityBound.X23Check.C4.re
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.casesOn
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.mk.injEq
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.neg
#print axioms HadwigerNelson.DensityBound.X23Check.C4.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.X23Check.C4.sub
#print axioms HadwigerNelson.DensityBound.X23Check.digits
#print axioms HadwigerNelson.DensityBound.X23Check.groupsOf
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.l11
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.l33
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.add
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.noConfusionType
#print axioms HadwigerNelson.DensityBound.X23Check.oneGroup
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.mk.inj
#print axioms HadwigerNelson.DensityBound.X23Check.rowB
#print axioms HadwigerNelson.DensityBound.X23Check.distsOk
#print axioms HadwigerNelson.DensityBound.X23Check.corrOk
#print axioms HadwigerNelson.DensityBound.X23Check.dg
#print axioms HadwigerNelson.DensityBound.X23Check.sdg
#print axioms HadwigerNelson.DensityBound.X23Check.distOk
#print axioms HadwigerNelson.DensityBound.X23Check.pack
#print axioms HadwigerNelson.DensityBound.X23Check.evHi
#print axioms HadwigerNelson.DensityBound.X23Check.C4.normSq
#print axioms HadwigerNelson.DensityBound.X23Check.C4.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.X23Check.rowN
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.noConfusionType
#print axioms HadwigerNelson.DensityBound.X23Check.C4.conj
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.ok
#print axioms HadwigerNelson.DensityBound.X23Check.rowTerms
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.u11
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.a
#print axioms HadwigerNelson.DensityBound.X23Check.q4At
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.ctorIdx
#print axioms HadwigerNelson.DensityBound.X23Check.sqd
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.mk.noConfusion
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.sub
#print axioms HadwigerNelson.DensityBound.X23Check.C4.mk.inj
#print axioms HadwigerNelson.DensityBound.X23Check.rowJ
#print axioms HadwigerNelson.DensityBound.X23Check.C4.add
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.casesOn
#print axioms HadwigerNelson.DensityBound.X23Check.C4.recOn
#print axioms HadwigerNelson.DensityBound.X23Check.OFFS
#print axioms HadwigerNelson.DensityBound.X23Check.subtreeOk
#print axioms HadwigerNelson.DensityBound.X23Check.B72
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.ofInt
#print axioms HadwigerNelson.DensityBound.X23Check.tval
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.smul
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.mul
#print axioms HadwigerNelson.DensityBound.X23Check.C4.noConfusion
#print axioms HadwigerNelson.DensityBound.X23Check.termsOk
#print axioms HadwigerNelson.DensityBound.X23Check.w2Term
#print axioms HadwigerNelson.DensityBound.X23Check.C4.mk.injEq
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.b
#print axioms HadwigerNelson.DensityBound.X23Check.addGroup
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.d
#print axioms HadwigerNelson.DensityBound.X23Check.decSt
#print axioms HadwigerNelson.DensityBound.X23Check.c4At
#print axioms HadwigerNelson.DensityBound.X23Check.M23
#print axioms HadwigerNelson.DensityBound.X23Check.rowC
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.mk.inj
#print axioms HadwigerNelson.DensityBound.X23Check.rowM
#print axioms HadwigerNelson.DensityBound.X23Check.final
#print axioms HadwigerNelson.DensityBound.X23Check.C4.beq
#print axioms HadwigerNelson.DensityBound.X23Check.C4.ctorIdx
#print axioms HadwigerNelson.DensityBound.X23Check.C4.im
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.recOn
#print axioms HadwigerNelson.DensityBound.X23Check.packSt
#print axioms HadwigerNelson.DensityBound.X23Check.rowI
#print axioms HadwigerNelson.DensityBound.X23Check.terms
#print axioms HadwigerNelson.DensityBound.X23Check.C4.mul
#print axioms HadwigerNelson.DensityBound.X23Check.rowV
#print axioms HadwigerNelson.DensityBound.X23Check.C4.smul
#print axioms HadwigerNelson.DensityBound.X23Check.OFF
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.noConfusion
#print axioms HadwigerNelson.DensityBound.X23Check.rowU
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.c
#print axioms HadwigerNelson.DensityBound.X23Check.C4.casesOn
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.recOn
#print axioms HadwigerNelson.DensityBound.X23Check.evLo
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.mk.sizeOf_spec
#print axioms HadwigerNelson.DensityBound.X23Check.Encl.u33
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.mk.injEq
#print axioms HadwigerNelson.DensityBound.X23Check.lowMul
#print axioms HadwigerNelson.DensityBound.X23Check.pt
#print axioms HadwigerNelson.DensityBound.X23Check.maskL
#print axioms HadwigerNelson.DensityBound.X23Check.dfsG
#print axioms HadwigerNelson.DensityBound.X23Check.wc05
#print axioms HadwigerNelson.DensityBound.X23Check.wc07
#print axioms HadwigerNelson.DensityBound.X23Check.encl_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr15
#print axioms HadwigerNelson.DensityBound.X23Check.wc02
#print axioms HadwigerNelson.DensityBound.X23Check.fr16
#print axioms HadwigerNelson.DensityBound.X23Check.fr93
#print axioms HadwigerNelson.DensityBound.X23Check.fr61
#print axioms HadwigerNelson.DensityBound.X23Check.wc00
#print axioms HadwigerNelson.DensityBound.X23Check.fr101
#print axioms HadwigerNelson.DensityBound.X23Check.fr28
#print axioms HadwigerNelson.DensityBound.X23Check.fr26
#print axioms HadwigerNelson.DensityBound.X23Check.w0N
#print axioms HadwigerNelson.DensityBound.X23Check.wcR
#print axioms HadwigerNelson.DensityBound.X23Check.fr25
#print axioms HadwigerNelson.DensityBound.X23Check.fr76
#print axioms HadwigerNelson.DensityBound.X23Check.fr50
#print axioms HadwigerNelson.DensityBound.X23Check.fr89
#print axioms HadwigerNelson.DensityBound.X23Check.frontier_rt
#print axioms HadwigerNelson.DensityBound.X23Check.KF
#print axioms HadwigerNelson.DensityBound.X23Check.adj_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr09
#print axioms HadwigerNelson.DensityBound.X23Check.fr99
#print axioms HadwigerNelson.DensityBound.X23Check.fr92
#print axioms HadwigerNelson.DensityBound.X23Check.fr20
#print axioms HadwigerNelson.DensityBound.X23Check.fr54
#print axioms HadwigerNelson.DensityBound.X23Check.fr65
#print axioms HadwigerNelson.DensityBound.X23Check.wc06
#print axioms HadwigerNelson.DensityBound.X23Check.fr46
#print axioms HadwigerNelson.DensityBound.X23Check.boundN
#print axioms HadwigerNelson.DensityBound.X23Check.wc03
#print axioms HadwigerNelson.DensityBound.X23Check.fr35
#print axioms HadwigerNelson.DensityBound.X23Check.fr44
#print axioms HadwigerNelson.DensityBound.X23Check.fr97
#print axioms HadwigerNelson.DensityBound.X23Check.fr96
#print axioms HadwigerNelson.DensityBound.X23Check.fr27
#print axioms HadwigerNelson.DensityBound.X23Check.fr10
#print axioms HadwigerNelson.DensityBound.X23Check.groups_eq
#print axioms HadwigerNelson.DensityBound.X23Check.fr57
#print axioms HadwigerNelson.DensityBound.X23Check.fr86
#print axioms HadwigerNelson.DensityBound.X23Check.fr87
#print axioms HadwigerNelson.DensityBound.X23Check.fr58
#print axioms HadwigerNelson.DensityBound.X23Check.fr17
#print axioms HadwigerNelson.DensityBound.X23Check.fr62
#print axioms HadwigerNelson.DensityBound.X23Check.fr47
#print axioms HadwigerNelson.DensityBound.X23Check.wc04
#print axioms HadwigerNelson.DensityBound.X23Check.fr70
#print axioms HadwigerNelson.DensityBound.X23Check.fr31
#print axioms HadwigerNelson.DensityBound.X23Check.fr19
#print axioms HadwigerNelson.DensityBound.X23Check.fr29
#print axioms HadwigerNelson.DensityBound.X23Check.fr71
#print axioms HadwigerNelson.DensityBound.X23Check.fr01
#print axioms HadwigerNelson.DensityBound.X23Check.fr40
#print axioms HadwigerNelson.DensityBound.X23Check.wc01
#print axioms HadwigerNelson.DensityBound.X23Check.fr91
#print axioms HadwigerNelson.DensityBound.X23Check.fr100
#print axioms HadwigerNelson.DensityBound.X23Check.fr38
#print axioms HadwigerNelson.DensityBound.X23Check.fr13
#print axioms HadwigerNelson.DensityBound.X23Check.fr59
#print axioms HadwigerNelson.DensityBound.X23Check.fr85
#print axioms HadwigerNelson.DensityBound.X23Check.fr84
#print axioms HadwigerNelson.DensityBound.X23Check.fr42
#print axioms HadwigerNelson.DensityBound.X23Check.fr73
#print axioms HadwigerNelson.DensityBound.X23Check.vertsL
#print axioms HadwigerNelson.DensityBound.X23Check.terms_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr11
#print axioms HadwigerNelson.DensityBound.X23Check.fr83
#print axioms HadwigerNelson.DensityBound.X23Check.fr55
#print axioms HadwigerNelson.DensityBound.X23Check.fr74
#print axioms HadwigerNelson.DensityBound.X23Check.fr43
#print axioms HadwigerNelson.DensityBound.X23Check.fr95
#print axioms HadwigerNelson.DensityBound.X23Check.w1N
#print axioms HadwigerNelson.DensityBound.X23Check.fr69
#print axioms HadwigerNelson.DensityBound.X23Check.fr88
#print axioms HadwigerNelson.DensityBound.X23Check.fr24
#print axioms HadwigerNelson.DensityBound.X23Check.fr77
#print axioms HadwigerNelson.DensityBound.X23Check.fr78
#print axioms HadwigerNelson.DensityBound.X23Check.fr32
#print axioms HadwigerNelson.DensityBound.X23Check.fr39
#print axioms HadwigerNelson.DensityBound.X23Check.fr63
#print axioms HadwigerNelson.DensityBound.X23Check.fr36
#print axioms HadwigerNelson.DensityBound.X23Check.verts_length
#print axioms HadwigerNelson.DensityBound.X23Check.fr67
#print axioms HadwigerNelson.DensityBound.X23Check.fr22
#print axioms HadwigerNelson.DensityBound.X23Check.fr07
#print axioms HadwigerNelson.DensityBound.X23Check.fr48
#print axioms HadwigerNelson.DensityBound.X23Check.fr75
#print axioms HadwigerNelson.DensityBound.X23Check.enclL
#print axioms HadwigerNelson.DensityBound.X23Check.fr08
#print axioms HadwigerNelson.DensityBound.X23Check.fr23
#print axioms HadwigerNelson.DensityBound.X23Check.fr80
#print axioms HadwigerNelson.DensityBound.X23Check.fr94
#print axioms HadwigerNelson.DensityBound.X23Check.fr21
#print axioms HadwigerNelson.DensityBound.X23Check.fr82
#print axioms HadwigerNelson.DensityBound.X23Check.fr51
#print axioms HadwigerNelson.DensityBound.X23Check.fr06
#print axioms HadwigerNelson.DensityBound.X23Check.fr30
#print axioms HadwigerNelson.DensityBound.X23Check.fr14
#print axioms HadwigerNelson.DensityBound.X23Check.frL
#print axioms HadwigerNelson.DensityBound.X23Check.fr66
#print axioms HadwigerNelson.DensityBound.X23Check.fr34
#print axioms HadwigerNelson.DensityBound.X23Check.fr49
#print axioms HadwigerNelson.DensityBound.X23Check.fr04
#print axioms HadwigerNelson.DensityBound.X23Check.fr45
#print axioms HadwigerNelson.DensityBound.X23Check.fr37
#print axioms HadwigerNelson.DensityBound.X23Check.fr53
#print axioms HadwigerNelson.DensityBound.X23Check.fr18
#print axioms HadwigerNelson.DensityBound.X23Check.fr33
#print axioms HadwigerNelson.DensityBound.X23Check.fr00
#print axioms HadwigerNelson.DensityBound.X23Check.fr81
#print axioms HadwigerNelson.DensityBound.X23Check.fr98
#print axioms HadwigerNelson.DensityBound.X23Check.fr64
#print axioms HadwigerNelson.DensityBound.X23Check.ptsL
#print axioms HadwigerNelson.DensityBound.X23Check.fr41
#print axioms HadwigerNelson.DensityBound.X23Check.fr68
#print axioms HadwigerNelson.DensityBound.X23Check.frontier_eq
#print axioms HadwigerNelson.DensityBound.X23Check.fr79
#print axioms HadwigerNelson.DensityBound.X23Check.fr03
#print axioms HadwigerNelson.DensityBound.X23Check.one_group
#print axioms HadwigerNelson.DensityBound.X23Check.fr02
#print axioms HadwigerNelson.DensityBound.X23Check.fr12
#print axioms HadwigerNelson.DensityBound.X23Check.fr05
#print axioms HadwigerNelson.DensityBound.X23Check.fr56
#print axioms HadwigerNelson.DensityBound.X23Check.fr60
#print axioms HadwigerNelson.DensityBound.X23Check.fr102
#print axioms HadwigerNelson.DensityBound.X23Check.fr90
#print axioms HadwigerNelson.DensityBound.X23Check.fr52
#print axioms HadwigerNelson.DensityBound.X23Check.fr72
#print axioms HadwigerNelson.DensityBound.X23Check.w2T
#print axioms HadwigerNelson.DensityBound.X23Check.wc00_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc01_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc02_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc03_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc04_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc05_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc06_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wc07_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr03_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr06_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr00_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr07_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr01_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr02_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr04_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr05_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr10_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr12_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr09_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr08_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr11_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr13_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr14_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr15_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr23_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr18_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr20_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr22_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr16_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr17_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr19_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr21_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr26_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr25_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr31_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr29_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr30_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr24_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr27_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr28_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr39_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr37_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr32_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr33_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr34_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr36_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr35_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr38_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr41_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr44_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr45_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr47_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr40_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr42_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr43_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr46_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr50_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr54_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr55_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr48_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr52_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr53_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr49_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr51_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr62_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr58_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr59_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr56_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr57_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr61_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr60_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr63_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr68_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr70_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr64_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr71_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr69_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr67_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr65_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr66_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr78_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr74_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr72_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr73_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr77_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr75_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr76_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr79_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr83_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr84_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr81_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr87_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr80_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr85_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr82_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr86_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr95_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr91_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr89_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr94_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr90_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr88_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr93_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr92_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr96_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr98_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr102_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr97_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr100_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr99_ok
#print axioms HadwigerNelson.DensityBound.X23Check.fr101_ok
#print axioms HadwigerNelson.DensityBound.X23Check.wcR_ok
#print axioms HadwigerNelson.DensityBound.X23Check.frL_ok
#print axioms HadwigerNelson.DensityBound.X23Check.ev_ofInt
#print axioms HadwigerNelson.DensityBound.X23Check.corrOk.eq_def
#print axioms HadwigerNelson.DensityBound.X23Check.encl_sqrt
#print axioms HadwigerNelson.DensityBound.X23Check.collect.eq_def
#print axioms HadwigerNelson.DensityBound.X23Check.groupsOk_of_getD
#print axioms HadwigerNelson.DensityBound.X23Check.gval_congr
#print axioms HadwigerNelson.DensityBound.X23Check.addGroup.eq_def
#print axioms HadwigerNelson.DensityBound.X23Check.Q4.eq_of_beq
#print axioms HadwigerNelson.DensityBound.X23Check.ev_neg
#print axioms HadwigerNelson.DensityBound.X23Check.forall₂_exists_right
#print axioms HadwigerNelson.DensityBound.X23Check.tot.eq_def
#print axioms HadwigerNelson.DensityBound.X23Check.toC_cond
#print axioms HadwigerNelson.DensityBound.X23Check.testBit_of_inGroup
#print axioms HadwigerNelson.DensityBound.X23Check.Pass
#print axioms HadwigerNelson.DensityBound.X23Check.sum_groups
#print axioms HadwigerNelson.DensityBound.X23Check.lowMul_le
#print axioms HadwigerNelson.DensityBound.X23Check.ev_encl
#print axioms HadwigerNelson.DensityBound.X23Check.collect_sound
#print axioms HadwigerNelson.DensityBound.X23Check.ev
#print axioms HadwigerNelson.DensityBound.X23Check.X23pt
#print axioms HadwigerNelson.DensityBound.X23Check.finsetOf
#print axioms HadwigerNelson.DensityBound.X23Check.dist_of_sqd
#print axioms HadwigerNelson.DensityBound.X23Check.gval
#print axioms HadwigerNelson.DensityBound.X23Check.addGroup_eq
#print axioms HadwigerNelson.DensityBound.X23Check.toC
#print axioms HadwigerNelson.DensityBound.X23Check.maskL_sub_iff
#print axioms HadwigerNelson.DensityBound.X23Check.dfsG_eq_all
#print axioms HadwigerNelson.DensityBound.X23Check.L_eq
#print axioms HadwigerNelson.DensityBound.X23Check.distOk_sound
#print axioms HadwigerNelson.DensityBound.X23Check.GroupsOk
#print axioms HadwigerNelson.DensityBound.X23Check.forall₂_exists_left
#print axioms HadwigerNelson.DensityBound.X23Check.toC_add
#print axioms HadwigerNelson.DensityBound.X23Check.tval_pack
#print axioms HadwigerNelson.DensityBound.X23Check.dfsG_append
#print axioms HadwigerNelson.DensityBound.X23Check.sum_ite_const
#print axioms HadwigerNelson.DensityBound.X23Check.X23_atoms
#print axioms HadwigerNelson.DensityBound.X23Check.testBit_maskOf
#print axioms HadwigerNelson.DensityBound.X23Check.land_eq_self_iff
#print axioms HadwigerNelson.DensityBound.X23Check.testBit_maskL
#print axioms HadwigerNelson.DensityBound.X23Check.ev_smul
#print axioms HadwigerNelson.DensityBound.X23Check.toC_smul
#print axioms HadwigerNelson.DensityBound.X23Check.gval_eq_zero
#print axioms HadwigerNelson.DensityBound.X23_valid
#print axioms HadwigerNelson.DensityBound.X23Check.terms_ok'
#print axioms HadwigerNelson.DensityBound.X23Check.atoms_dfs
#print axioms HadwigerNelson.DensityBound.X23Check.congruent_of_rowOk
#print axioms HadwigerNelson.DensityBound.X23Check.dist_of_adj
#print axioms HadwigerNelson.DensityBound.X23Check.pass_of_getD
#print axioms HadwigerNelson.DensityBound.X23Check.le_highMul
#print axioms HadwigerNelson.DensityBound.X23Check.toC_mul
#print axioms HadwigerNelson.DensityBound.X23Check.ev_add
#print axioms HadwigerNelson.DensityBound.X23Check.ev_sub
#print axioms HadwigerNelson.DensityBound.X23w0
#print axioms HadwigerNelson.DensityBound.X23Check.testBit_maskOf_iff
#print axioms HadwigerNelson.DensityBound.X23Check.maskOf
#print axioms HadwigerNelson.DensityBound.X23Check.normSq_toC
#print axioms HadwigerNelson.DensityBound.X23Check.maskL.eq_def
#print axioms HadwigerNelson.DensityBound.X23Check.dfsG.eq_def
#print axioms HadwigerNelson.DensityBound.X23Check.C4.eq_of_beq
#print axioms HadwigerNelson.DensityBound.X23Check.tot_eq
#print axioms HadwigerNelson.DensityBound.X23
#print axioms HadwigerNelson.DensityBound.X23Check.tot
#print axioms HadwigerNelson.DensityBound.X23Check.mem_finsetOf
#print axioms HadwigerNelson.DensityBound.X23Check.ev_mul
#print axioms HadwigerNelson.DensityBound.X23Check.toC_sub
#print axioms HadwigerNelson.DensityBound.X23Check.distsOk.eq_def
#print axioms HadwigerNelson.DensityBound.dists_ok
#print axioms HadwigerNelson.DensityBound.X23Check.forall₂_of_distsOk
#print axioms HadwigerNelson.DensityBound.X23_close
#print axioms HadwigerNelson.DensityBound.X23dists
#print axioms HadwigerNelson.DensityBound.X23_ratio
#print axioms HadwigerNelson.DensityBound.X23_phi
#print axioms HadwigerNelson.Plane.oneAvoidingDensityBound
-- FS131-IDB3 block end

/-! ## FS-131 (job FS131-LCH1) — the five-colour chain's landing, part 1: the records `main`'s modules gained

`Plane/MOneBound`'s two corollaries (`m₁(ℝ²) ≤ 0.2470`, `m₁(ℝ²) < 1/4`, no hypothesis); the eleven helpers of
`Plane/OneClass/InvariantLaw` made public (one copy, read by `Rigidity/InvariantMeasure`); `UpperHalf.exists_I_integer`
made public (read by `Rigidity/SqrtClassFive`). The chain's own block is part 2's (`plans/FS131-LCH1-join.md`,
§ Drafts for part 2). -/

-- FS131-LCH1 block: 14 records (2 + 11 + 1), each expected on a subset of the standard three
#print axioms HadwigerNelson.Plane.mOne_le_0_2470
#print axioms HadwigerNelson.Plane.mOne_lt_one_quarter
#print axioms HadwigerNelson.OneClass.avgMeasure
#print axioms HadwigerNelson.OneClass.avgMeasure_apply
#print axioms HadwigerNelson.OneClass.isProbabilityMeasure_avgMeasure
#print axioms HadwigerNelson.OneClass.avgMeasure_map
#print axioms HadwigerNelson.OneClass.integral_avgMeasure
#print axioms HadwigerNelson.OneClass.map_eq_of_tendsto
#print axioms HadwigerNelson.OneClass.map_eq_of_tendsto_of_eventually
#print axioms HadwigerNelson.OneClass.measure_compl_eq_zero_of_tendsto
#print axioms HadwigerNelson.OneClass.isClosed_setOf_of_tendsto
#print axioms HadwigerNelson.OneClass.exists_fixed_of_average
#print axioms HadwigerNelson.OneClass.exists_common_fixed
#print axioms HadwigerNelson.UpperHalf.exists_I_integer
-- FS131-LCH1 block end

/-! ## FS131-LGT1 — the five-colour chain's landing, part 3: every public theorem and definition of the 148 modules
the landing brings or changes that no block above holds, classed from the kernel's print
(`data/fs131/lgt1/axioms-all.txt`, by `tools/fs131_lgt1_audit_block.py`): the chain (FS131-KN3 … FS131-IJN1, joined
by FS131-LCH1), the certificate link (FS131-IKL1), M13's dyadic line (FS131-ICM3, FS131-ICM4), the bound at p = 11
and p = 19 (FS131-IKC1 … FS131-IKC4), and the records of main's four changed modules that no landing had listed
(`Instances/SqrtFortySeven`'s field, coordinates and reduction). The records on a declared import are under
IMPORTED. -/

-- FS131-LGT1 (CLEAN): the chain's modules (`Rigidity/*` but the link's two, `Outside/OAI015*`, `Plane/WindowDensity`, `Plane/MOneBound`, `Instances/SqrtFortySevenFive`, `Instances/SqrtClassValues`; FS131-KN3 … FS131-IJN1, joined by FS131-LCH1) — 860
#print axioms HadwigerNelson.SqrtClassValues.chromaticNumber_planeOver_sqrt143_le_five
#print axioms HadwigerNelson.SqrtClassValues.isSquare_radicand
#print axioms HadwigerNelson.SqrtFortySeven.exists_stablePrime_eleven
#print axioms HadwigerNelson.SqrtFortySeven.finrank_fieldI_F47_le
#print axioms HadwigerNelson.SqrtFortySeven.isSquare_fortySeven
#print axioms HadwigerNelson.SqrtFortySeven.numberField_F47
#print axioms HadwigerNelson.SqrtFortySeven.stablePrime_card_sqrt47
#print axioms HadwigerNelson.Outside.OAI015.actionInvariantSigma
#print axioms HadwigerNelson.Outside.OAI015.actionInvariantSigma_le
#print axioms HadwigerNelson.Outside.OAI015.action_ergodic_decomposition
#print axioms HadwigerNelson.Outside.OAI015.condExpKernel_ae_constant
#print axioms HadwigerNelson.Outside.OAI015.condExpKernel_invariant
#print axioms HadwigerNelson.Outside.OAI015.ergodicSMul_of_orbit_indicator_limits
#print axioms HadwigerNelson.Outside.OAI015.exists_convex_orbit_approximants
#print axioms HadwigerNelson.Outside.OAI015.exists_invariant_orbit_average_limit
#print axioms HadwigerNelson.Outside.OAI015.exists_pointwise_invariant_representative
#print axioms HadwigerNelson.Outside.OAI015.fixedPoint_mem_closed_convex_orbit
#print axioms HadwigerNelson.Outside.OAI015.invariant_kernel_decomposition
#print axioms HadwigerNelson.Outside.OAI015.invariant_set_independent_of_orbit_indicator_limit
#print axioms HadwigerNelson.Outside.OAI015.lp_convex_orbit_representative
#print axioms HadwigerNelson.Outside.OAI015.measurable_actionInvariantSigma
#print axioms HadwigerNelson.Outside.OAI015.orbitConvexHull
#print axioms HadwigerNelson.Outside.OAI015.orbitConvexHull_aeSetIntegral
#print axioms HadwigerNelson.Outside.OAI015.orbitConvexHull_integral
#print axioms HadwigerNelson.Outside.OAI015.orbitConvexHull_interval
#print axioms HadwigerNelson.Outside.OAI015.orbitConvexHull_measurable
#print axioms HadwigerNelson.Outside.OAI015.orbitConvexHull_setIntegral
#print axioms MeasurableSpace.countableGeneratingSet.congr_simp
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_chain
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_coarsening_le
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_comp_preserving
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_conditioning_le
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_eq_integral
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_eq_sum
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_injective
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_le
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_nonneg
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_pair_le
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_pair_pair_le
#print axioms HadwigerNelson.Outside.OAI015.conditionalObservationEntropy_tendsto_zero
#print axioms HadwigerNelson.Outside.OAI015.conditionalOrbitEntropy_le
#print axioms HadwigerNelson.Outside.OAI015.conditionalOrbitEntropy_one
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_fst_le
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_joint_decomposition
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_joint_mass_le
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_mass_decomposition
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_mul
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_submodular
#print axioms HadwigerNelson.Outside.OAI015.measureEntropy_eq_iSup_generating
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability_ae_eq_condExp
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability_ae_sum
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability_le_one
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability_nonneg
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability_sum
#print axioms HadwigerNelson.Outside.OAI015.observationConditionalProbability_tendsto
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate_le_add_conditional
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_assoc
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_injective
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_le_add_conditional
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_submodular
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_swap
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_unique
#print axioms HadwigerNelson.Outside.OAI015.observationPair_measurable_fiber
#print axioms HadwigerNelson.Outside.OAI015.observationSigma
#print axioms HadwigerNelson.Outside.OAI015.observationSigma_le
#print axioms HadwigerNelson.Outside.OAI015.observation_values_ae_eq_condExp
#print axioms HadwigerNelson.Outside.OAI015.orbitName_one
#print axioms HadwigerNelson.Outside.OAI015.setIntegral_eq_of_observation_atoms
#print axioms HadwigerNelson.Outside.OAI015.setIntegral_observationConditionalProbability
#print axioms HadwigerNelson.Outside.OAI015.stronglyMeasurable_observation_values
#print axioms HadwigerNelson.Outside.OAI015.ae_uniform_small_occupation_of_decreasing
#print axioms HadwigerNelson.Outside.OAI015.birkhoffSum_le_positiveRunningSum
#print axioms HadwigerNelson.Outside.OAI015.excessiveOccupation
#print axioms HadwigerNelson.Outside.OAI015.excessiveOccupation_measure_bound
#print axioms HadwigerNelson.Outside.OAI015.excessiveOccupation_mono
#print axioms HadwigerNelson.Outside.OAI015.finite_hopf_maximal
#print axioms HadwigerNelson.Outside.OAI015.integrable_positiveRunningSum
#print axioms HadwigerNelson.Outside.OAI015.measurableSet_excessiveOccupation
#print axioms HadwigerNelson.Outside.OAI015.measurable_positiveRunningSum
#print axioms HadwigerNelson.Outside.OAI015.measurable_visitCount
#print axioms HadwigerNelson.Outside.OAI015.positiveRunningSum
#print axioms HadwigerNelson.Outside.OAI015.positiveRunningSum.eq_def
#print axioms HadwigerNelson.Outside.OAI015.positiveRunningSum_mono
#print axioms HadwigerNelson.Outside.OAI015.positiveRunningSum_nonneg
#print axioms HadwigerNelson.Outside.OAI015.visitCount
#print axioms HadwigerNelson.Outside.OAI015.visitCount_cast
#print axioms HadwigerNelson.Outside.OAI015.visitCount_mono
#print axioms HadwigerNelson.Outside.OAI015.ae_nonnull_fiber
#print axioms HadwigerNelson.Outside.OAI015.continuous_finiteShannon
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_mixture_bounds
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_mixture_joint
#print axioms HadwigerNelson.Outside.OAI015.finite_measurable_small_fibers
#print axioms HadwigerNelson.Outside.OAI015.integrable_finite_values
#print axioms HadwigerNelson.Outside.OAI015.integrable_kernel_entropy
#print axioms HadwigerNelson.Outside.OAI015.integrable_kernel_real
#print axioms HadwigerNelson.Outside.OAI015.integral_finite_values
#print axioms HadwigerNelson.Outside.OAI015.kernelCell
#print axioms HadwigerNelson.Outside.OAI015.kernelCell_preserving
#print axioms HadwigerNelson.Outside.OAI015.kernelCell_probability
#print axioms HadwigerNelson.Outside.OAI015.kernelCell_real
#print axioms HadwigerNelson.Outside.OAI015.kernelCell_real_close
#print axioms HadwigerNelson.Outside.OAI015.kernel_comp_real
#print axioms HadwigerNelson.Outside.OAI015.kernel_entropyRate_le_block
#print axioms HadwigerNelson.Outside.OAI015.kernel_entropy_finite_approx
#print axioms HadwigerNelson.Outside.OAI015.kernel_finite_cells
#print axioms HadwigerNelson.Outside.OAI015.kernel_mixture_preserving
#print axioms HadwigerNelson.Outside.OAI015.measurable_kernel_entropy
#print axioms HadwigerNelson.Outside.OAI015.measurable_kernel_real
#print axioms HadwigerNelson.Outside.OAI015.measureEntropy_kernel_zero
#print axioms HadwigerNelson.Outside.OAI015.negMulLog_sum_le
#print axioms HadwigerNelson.Outside.OAI015.normalized_orbit_entropy_le
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate_eq_zero_of_measureEntropy
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate_finite_mixture
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate_le_block
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate_nonneg
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_finite_mixture_bounds
#print axioms HadwigerNelson.Outside.OAI015.weighted_kernelCell
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_joint_le
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_le_cross
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_le_log_card
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_nonneg
#print axioms HadwigerNelson.Outside.OAI015.finiteShannon_split_lower
#print axioms HadwigerNelson.Outside.OAI015.measureEntropy
#print axioms HadwigerNelson.Outside.OAI015.measureEntropy_lower_of_good_atoms
#print axioms HadwigerNelson.Outside.OAI015.negMulLog_le_cross
#print axioms HadwigerNelson.Outside.OAI015.negMulLog_lower_of_le_exp
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate
#print axioms HadwigerNelson.Outside.OAI015.observationEntropyRate_lower_of_good_atoms
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_comp_preserving
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_equiv
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_joint_le
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_lower_of_good_atoms
#print axioms HadwigerNelson.Outside.OAI015.observationEntropy_nonneg
#print axioms HadwigerNelson.Outside.OAI015.observation_distribution_sum
#print axioms HadwigerNelson.Outside.OAI015.observation_joint_row
#print axioms HadwigerNelson.Outside.OAI015.orbitEntropy_subadditive
#print axioms HadwigerNelson.Outside.OAI015.orbitName
#print axioms HadwigerNelson.Outside.OAI015.orbitName_add
#print axioms HadwigerNelson.Outside.OAI015.orbitName_measurable_fiber
#print axioms HadwigerNelson.Outside.OAI015.sum_good_observation_masses
#print axioms HadwigerNelson.Outside.OAI015.tendsto_observationEntropyRate
#print axioms Subadditive.lim.congr_simp
#print axioms HadwigerNelson.Plane.NRWindow
#print axioms HadwigerNelson.Plane.densitySet_bandFree
#print axioms HadwigerNelson.Plane.essNbhd
#print axioms HadwigerNelson.Plane.exists_nrWindow
#print axioms HadwigerNelson.Plane.exists_periodic_near_mOne
#print axioms HadwigerNelson.Plane.measurableSet_essNbhd
#print axioms HadwigerNelson.Plane.unitPairsNull_diff_essNbhd_union
#print axioms HadwigerNelson.Plane.volume_inter_sq_le
#print axioms HadwigerNelson.Rigidity.EqualAtUnits
#print axioms HadwigerNelson.Rigidity.aPlusOfR88
#print axioms HadwigerNelson.Rigidity.aplus_model
#print axioms HadwigerNelson.Rigidity.colourRot
#print axioms HadwigerNelson.Rigidity.comap_colourRot_colourFactor
#print axioms HadwigerNelson.Rigidity.equalAtUnits_of_not_neg
#print axioms HadwigerNelson.Rigidity.factorColouring
#print axioms HadwigerNelson.Rigidity.factorColouring.congr_simp
#print axioms HadwigerNelson.Rigidity.factorColouring_mem_X4
#print axioms HadwigerNelson.Rigidity.factorColouring_rot_ae
#print axioms HadwigerNelson.Rigidity.factorColouring_shift_ae
#print axioms HadwigerNelson.Rigidity.factorLaw
#print axioms HadwigerNelson.Rigidity.factorLaw_carried
#print axioms HadwigerNelson.Rigidity.factorLaw_isProb
#print axioms HadwigerNelson.Rigidity.factorLaw_rot_inv
#print axioms HadwigerNelson.Rigidity.factorLaw_shift_inv
#print axioms HadwigerNelson.Rigidity.factorLaw_trace_null
#print axioms HadwigerNelson.Rigidity.integral_condLaw_mul_eq_zero_of_adj
#print axioms HadwigerNelson.Rigidity.measurable_colourRot
#print axioms HadwigerNelson.Rigidity.measurable_factorColouring
#print axioms HadwigerNelson.Rigidity.measurable_factorColouring_apply
#print axioms HadwigerNelson.Rigidity.minSel
#print axioms HadwigerNelson.Rigidity.minSel_mem
#print axioms HadwigerNelson.Rigidity.nonempty_invariantColouring_bot
#print axioms HadwigerNelson.Rigidity.numberField_bot
#print axioms HadwigerNelson.Rigidity.tendsto_mul_nhds_tauPrime
#print axioms HadwigerNelson.SpectralChain.InvariantColouring.measurePreserving_rot
#print axioms HadwigerNelson.Rigidity.exists_residueHom_unramified
#print axioms HadwigerNelson.Rigidity.exists_unitPair
#print axioms HadwigerNelson.Rigidity.dualAnnihilator
#print axioms HadwigerNelson.Rigidity.dualAnnihilator_antitone
#print axioms HadwigerNelson.Rigidity.dualAnnihilator_bot
#print axioms HadwigerNelson.Rigidity.dualCoannihilator
#print axioms HadwigerNelson.Rigidity.dualCoannihilator_antitone
#print axioms HadwigerNelson.Rigidity.dualCoannihilator_bot
#print axioms HadwigerNelson.Rigidity.dualCoannihilator_dualAnnihilator_dualCoannihilator
#print axioms HadwigerNelson.Rigidity.dualCoannihilator_top
#print axioms HadwigerNelson.Rigidity.dualCoannihilator_topologicalClosure
#print axioms HadwigerNelson.Rigidity.finite_dualAnnihilator
#print axioms HadwigerNelson.Rigidity.gc_dualAnnihilator
#print axioms HadwigerNelson.Rigidity.isClosed_dualAnnihilator
#print axioms HadwigerNelson.Rigidity.isClosed_setOf_apply_eq_one
#print axioms HadwigerNelson.Rigidity.le_dualAnnihilator_dualCoannihilator
#print axioms HadwigerNelson.Rigidity.le_dualAnnihilator_iff
#print axioms HadwigerNelson.Rigidity.le_dualCoannihilator_dualAnnihilator
#print axioms HadwigerNelson.Rigidity.mem_dualAnnihilator
#print axioms HadwigerNelson.Rigidity.mem_dualCoannihilator
#print axioms HadwigerNelson.Rigidity.archimedean_support
#print axioms HadwigerNelson.Rigidity.bochnerOn_tauPrime
#print axioms HadwigerNelson.Rigidity.exists_twisted_parts
#print axioms HadwigerNelson.Rigidity.finite_quotient_nsmul
#print axioms HadwigerNelson.Rigidity.EntropySplit
#print axioms HadwigerNelson.Rigidity.EntropySplitEvery
#print axioms HadwigerNelson.Rigidity.IsDyadic
#print axioms HadwigerNelson.Rigidity.IsRamified
#print axioms HadwigerNelson.Rigidity.IsRamified.isDyadic
#print axioms HadwigerNelson.Rigidity.MRPlus
#print axioms HadwigerNelson.Rigidity.NoRamifiedStableDyadic
#print axioms HadwigerNelson.Rigidity.TA
#print axioms HadwigerNelson.Rigidity.ZeroEntropyCarried
#print axioms HadwigerNelson.Rigidity.archChars
#print axioms HadwigerNelson.Rigidity.chainInterface
#print axioms HadwigerNelson.Rigidity.colorable_two_levelTarget_one_of_isRamified
#print axioms HadwigerNelson.Rigidity.entropySplit_of_every
#print axioms HadwigerNelson.Rigidity.exists_nonTorsion_unitVector
#print axioms HadwigerNelson.Rigidity.exists_rat_coords
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_of_mrPlus
#print axioms HadwigerNelson.Rigidity.interface_mr_iff
#print axioms HadwigerNelson.Rigidity.measurableSet_TA
#print axioms HadwigerNelson.Rigidity.mem_torsion_mul_arch_iff
#print axioms HadwigerNelson.Rigidity.min_localBound_five_le_chromaticNumber_of_closed
#print axioms HadwigerNelson.Rigidity.mrPlus_of_split_of_carried
#print axioms HadwigerNelson.Rigidity.noRamifiedStableDyadic_iff
#print axioms HadwigerNelson.Rigidity.noRamifiedStableDyadic_of_tca
#print axioms HadwigerNelson.Rigidity.noRamifiedStableDyadic_of_three_le_localBound
#print axioms HadwigerNelson.Rigidity.one_mem_TA
#print axioms HadwigerNelson.Rigidity.rotInv_dirac_one
#print axioms HadwigerNelson.Rigidity.rot_preimage_TA
#print axioms HadwigerNelson.Rigidity.torsionChars
#print axioms HadwigerNelson.Rigidity.zeroEntropyCarried_model
#print axioms HadwigerNelson.CertLink.exists_fibreShareBound_nineteen
#print axioms HadwigerNelson.Rigidity.RatioAtMost
#print axioms HadwigerNelson.Rigidity.henselCount_of_two_notMem
#print axioms HadwigerNelson.Rigidity.newCharBound_of_two_notMem
#print axioms HadwigerNelson.Rigidity.tca_iff
#print axioms HadwigerNelson.Rigidity.TA_subset_contChars
#print axioms HadwigerNelson.Rigidity.archContinuousAt_pow_of_mem_contChars
#print axioms HadwigerNelson.Rigidity.archHom
#print axioms HadwigerNelson.Rigidity.archHom.congr_simp
#print axioms HadwigerNelson.Rigidity.archTop
#print axioms HadwigerNelson.Rigidity.archTop_eq
#print axioms HadwigerNelson.Rigidity.contChars_subset_TA
#print axioms HadwigerNelson.Rigidity.contChars_tauPrime
#print axioms HadwigerNelson.Rigidity.eventually_archTop
#print axioms HadwigerNelson.Rigidity.exists_nsmul_mem_of_mem_nhds_profTop
#print axioms HadwigerNelson.Rigidity.fivePow
#print axioms HadwigerNelson.Rigidity.inv_five_mem
#print axioms HadwigerNelson.Rigidity.isCountablyGenerated_nhds_tauPrime
#print axioms HadwigerNelson.Rigidity.isTopologicalAddGroup_tauPrime
#print axioms HadwigerNelson.Rigidity.mem_archChars_of_continuousAt
#print axioms HadwigerNelson.Rigidity.mem_nhds_profTop
#print axioms HadwigerNelson.Rigidity.norm_archHom_nsmul
#print axioms HadwigerNelson.Rigidity.nsmul_fivePow
#print axioms HadwigerNelson.Rigidity.profTop
#print axioms HadwigerNelson.Rigidity.tauPrime
#print axioms HadwigerNelson.Rigidity.Counting.G
#print axioms HadwigerNelson.Rigidity.Counting.K
#print axioms HadwigerNelson.Rigidity.Counting.Kgrp
#print axioms HadwigerNelson.Rigidity.Counting.continuous_proj
#print axioms HadwigerNelson.Rigidity.Counting.denseRange_ιG
#print axioms HadwigerNelson.Rigidity.Counting.haarK
#print axioms HadwigerNelson.Rigidity.Counting.haarK_proj_preimage
#print axioms HadwigerNelson.Rigidity.Counting.hasBasis_nhds_zero_K
#print axioms HadwigerNelson.Rigidity.Counting.instBorelSpaceK
#print axioms HadwigerNelson.Rigidity.Counting.instCompactSpaceK
#print axioms HadwigerNelson.Rigidity.Counting.instDiscreteTopologyLev
#print axioms HadwigerNelson.Rigidity.Counting.instIsAddLeftInvariantKHaarK
#print axioms HadwigerNelson.Rigidity.Counting.instIsProbabilityMeasureKHaarK
#print axioms HadwigerNelson.Rigidity.Counting.instMeasurableSpaceK
#print axioms HadwigerNelson.Rigidity.Counting.instSecondCountableTopologyK
#print axioms HadwigerNelson.Rigidity.Counting.instSecondCountableTopologyLev
#print axioms HadwigerNelson.Rigidity.Counting.instTopologicalSpaceLev
#print axioms HadwigerNelson.Rigidity.Counting.mem_closure_ιG
#print axioms HadwigerNelson.Rigidity.Counting.proj
#print axioms HadwigerNelson.Rigidity.Counting.proj_eq_zero_of_le
#print axioms HadwigerNelson.Rigidity.Counting.proj_ιK
#print axioms HadwigerNelson.Rigidity.Counting.range_proj
#print axioms HadwigerNelson.Rigidity.Counting.tendsto_haarK_bad
#print axioms HadwigerNelson.Rigidity.Counting.unitVectorsR
#print axioms HadwigerNelson.Rigidity.Counting.ιAll
#print axioms HadwigerNelson.Rigidity.Counting.ιG
#print axioms HadwigerNelson.Rigidity.Counting.ιK
#print axioms HadwigerNelson.Rigidity.Counting.instFintypeSubtypeLevMemAddSubgroupToAddSubgroupRangeComplexSubringUnitRingLevR
#print axioms HadwigerNelson.Rigidity.Counting.levelRows
#print axioms HadwigerNelson.Rigidity.Counting.measurableSet_levelRows
#print axioms HadwigerNelson.Rigidity.Counting.rowsEdgeNull_levelRows
#print axioms HadwigerNelson.Rigidity.Counting.tendsto_bad
#print axioms HadwigerNelson.Rigidity.Counting.volume_colour_le
#print axioms HadwigerNelson.Rigidity.Counting.Lev.congr_simp
#print axioms HadwigerNelson.Rigidity.Counting.SliceEdgeNull
#print axioms HadwigerNelson.Rigidity.Counting.comap_ιG_le_nhds_tauPrime
#print axioms HadwigerNelson.Rigidity.Counting.exists_extension
#print axioms HadwigerNelson.Rigidity.Counting.exists_slice
#print axioms HadwigerNelson.Rigidity.Counting.measure_ne_eq
#print axioms HadwigerNelson.Rigidity.Counting.tendsto_measure_ne
#print axioms HadwigerNelson.Rigidity.Counting.exists_invariantColouring_rat
#print axioms HadwigerNelson.Rigidity.Counting.not_r88TCA_rat
#print axioms HadwigerNelson.Rigidity.Counting.ratColouring
#print axioms HadwigerNelson.Rigidity.Counting.Lev
#print axioms HadwigerNelson.Rigidity.Counting.exists_level_mem_nsmul
#print axioms HadwigerNelson.Rigidity.Counting.exists_mem_nsmul_of_resR_eq_zero
#print axioms HadwigerNelson.Rigidity.Counting.exists_normOneL_residue
#print axioms HadwigerNelson.Rigidity.Counting.exists_normOneL_residues
#print axioms HadwigerNelson.Rigidity.Counting.exists_unitRing_of_normOneL
#print axioms HadwigerNelson.Rigidity.Counting.finite_quot
#print axioms HadwigerNelson.Rigidity.Counting.image_levR_unitVectors
#print axioms HadwigerNelson.Rigidity.Counting.instCommRingLev
#print axioms HadwigerNelson.Rigidity.Counting.instFiniteLev
#print axioms HadwigerNelson.Rigidity.Counting.isIndepSet_levelTarget_iff
#print axioms HadwigerNelson.Rigidity.Counting.levR
#print axioms HadwigerNelson.Rigidity.Counting.level
#print axioms HadwigerNelson.Rigidity.Counting.mem_level
#print axioms HadwigerNelson.Rigidity.Counting.neg_mem_normOneQ
#print axioms HadwigerNelson.Rigidity.Counting.normOneLev
#print axioms HadwigerNelson.Rigidity.Counting.normOneQ
#print axioms HadwigerNelson.Rigidity.Counting.ofUnitRing_mem_localRing
#print axioms HadwigerNelson.Rigidity.Counting.ratioLe_levR_range
#print axioms HadwigerNelson.Rigidity.Counting.ratioLe_normOneQ
#print axioms HadwigerNelson.Rigidity.Counting.ratio_unramified_of_tca
#print axioms HadwigerNelson.Rigidity.Counting.resR
#print axioms HadwigerNelson.Rigidity.Counting.resR_eq_zero_of_le
#print axioms HadwigerNelson.Rigidity.Counting.stablePrime_injective
#print axioms HadwigerNelson.Rigidity.Counting.toLocal
#print axioms HadwigerNelson.Rigidity.Counting.Delta
#print axioms HadwigerNelson.Rigidity.Counting.Delta_circle_mem_closure
#print axioms HadwigerNelson.Rigidity.Counting.Delta_circle_mul_mem_closure_pow
#print axioms HadwigerNelson.Rigidity.Counting.Delta_ratCast
#print axioms HadwigerNelson.Rigidity.Counting.iL
#print axioms HadwigerNelson.Rigidity.Counting.mem_closure_pow
#print axioms HadwigerNelson.Rigidity.Counting.mem_normOneL_iff
#print axioms HadwigerNelson.Rigidity.Counting.mul_mem_normOneL
#print axioms HadwigerNelson.Rigidity.Counting.normOneL
#print axioms HadwigerNelson.Rigidity.Counting.pow_mem_normOneL
#print axioms HadwigerNelson.Rigidity.connectedSpace_dual
#print axioms HadwigerNelson.Rigidity.exists_pow_eq
#print axioms HadwigerNelson.Rigidity.not_connectedSpace_dual_zmod_two
#print axioms HadwigerNelson.Rigidity.surjective_compAddMonoidHom
#print axioms HadwigerNelson.Rigidity.borelSpace_dual
#print axioms HadwigerNelson.Rigidity.compactSpace_dual
#print axioms HadwigerNelson.Rigidity.continuous_evalChar
#print axioms HadwigerNelson.Rigidity.dualHaar
#print axioms HadwigerNelson.Rigidity.dualHaar.congr_simp
#print axioms HadwigerNelson.Rigidity.dualHaar_fourier_zero
#print axioms HadwigerNelson.Rigidity.dualTopologicalSpace
#print axioms HadwigerNelson.Rigidity.exists_apply_ne_one
#print axioms HadwigerNelson.Rigidity.exists_isHaarFourier_of_countable
#print axioms HadwigerNelson.Rigidity.isClosedEmbedding_coe
#print axioms HadwigerNelson.Rigidity.isHaarFourier_dualHaar
#print axioms HadwigerNelson.Rigidity.isHaarFourier_iff
#print axioms HadwigerNelson.Rigidity.isHaarMeasure_dualHaar
#print axioms HadwigerNelson.Rigidity.isProbabilityMeasure_dualHaar
#print axioms HadwigerNelson.Rigidity.isTopologicalGroup_dual
#print axioms HadwigerNelson.Rigidity.measure_eq_of_fourier
#print axioms HadwigerNelson.Rigidity.polishSpace_dual
#print axioms HadwigerNelson.Rigidity.secondCountableTopology_dual
#print axioms HadwigerNelson.Rigidity.standardBorelSpace_dual
#print axioms HadwigerNelson.Rigidity.t2Space_dual
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_dual
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_dual_eq
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_mul_right
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.map_mul_right_eq
#print axioms HadwigerNelson.Rigidity.Duality.exists_mem_dualCoannihilator_graphSubgroup
#print axioms HadwigerNelson.Rigidity.Duality.extendByPow
#print axioms HadwigerNelson.Rigidity.Duality.extendByPow_apply
#print axioms HadwigerNelson.Rigidity.Duality.graphSubgroup
#print axioms HadwigerNelson.Rigidity.Duality.isClosed_graphSubgroup
#print axioms HadwigerNelson.Rigidity.additiveDualDualEquiv
#print axioms HadwigerNelson.Rigidity.additiveDualDualEquiv_apply
#print axioms HadwigerNelson.Rigidity.dualAnnihilator_dualCoannihilator
#print axioms HadwigerNelson.Rigidity.dualAnnihilator_dualCoannihilator_of_isClosed
#print axioms HadwigerNelson.Rigidity.dualDualEquiv
#print axioms HadwigerNelson.Rigidity.dualDualEquiv_apply
#print axioms HadwigerNelson.Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot
#print axioms HadwigerNelson.Rigidity.eq_top_of_isClosed_of_dualCoannihilator_eq_bot'
#print axioms HadwigerNelson.Rigidity.evalDualHom
#print axioms HadwigerNelson.Rigidity.evalDualHom_apply
#print axioms HadwigerNelson.Rigidity.evalDualHom_injective
#print axioms HadwigerNelson.Rigidity.evalDualHom_surjective
#print axioms HadwigerNelson.Rigidity.blockEntropy
#print axioms HadwigerNelson.Rigidity.blockEntropy_eq_observationEntropy
#print axioms HadwigerNelson.Rigidity.blockEntropy_nonneg
#print axioms HadwigerNelson.Rigidity.blockEntropy_one
#print axioms HadwigerNelson.Rigidity.blockEntropy_zero_measure
#print axioms HadwigerNelson.Rigidity.exists_blockEntropy_le_mul
#print axioms HadwigerNelson.Rigidity.ksEntropy
#print axioms HadwigerNelson.Rigidity.ksEntropyOn
#print axioms HadwigerNelson.Rigidity.ksEntropyOn_le_ksEntropy
#print axioms HadwigerNelson.Rigidity.ksEntropyOn_mono
#print axioms HadwigerNelson.Rigidity.ksEntropyOn_self
#print axioms HadwigerNelson.Rigidity.ksEntropy_bind_eq_zero
#print axioms HadwigerNelson.Rigidity.ksEntropy_dirac
#print axioms HadwigerNelson.Rigidity.ksEntropy_eq_iSup_ksEntropyOn
#print axioms HadwigerNelson.Rigidity.ksEntropy_eq_measureEntropy
#print axioms HadwigerNelson.Rigidity.ksEntropy_eq_zero_iff
#print axioms HadwigerNelson.Rigidity.ksEntropy_id
#print axioms HadwigerNelson.Rigidity.ksEntropy_map
#print axioms HadwigerNelson.Rigidity.ksEntropy_zero_measure
#print axioms HadwigerNelson.Rigidity.measurableSet_nameCell
#print axioms HadwigerNelson.Rigidity.mem_nameCell
#print axioms HadwigerNelson.Rigidity.mem_nameCell_self
#print axioms HadwigerNelson.Rigidity.nameCell
#print axioms HadwigerNelson.Rigidity.nameCell_eq_orbitName_fibre
#print axioms HadwigerNelson.Rigidity.nameCell_zero
#print axioms HadwigerNelson.Rigidity.partitionEntropy
#print axioms HadwigerNelson.Rigidity.partitionEntropy_eq_ofReal_observationEntropyRate
#print axioms HadwigerNelson.Rigidity.partitionEntropy_le
#print axioms HadwigerNelson.Rigidity.partitionEntropy_le_ksEntropy
#print axioms HadwigerNelson.Rigidity.partitionEntropy_le_ksEntropyOn
#print axioms HadwigerNelson.Rigidity.partitionEntropy_le_liminf
#print axioms HadwigerNelson.Rigidity.tendsto_blockEntropy_div
#print axioms HadwigerNelson.Rigidity.blockEntropy_iterate
#print axioms HadwigerNelson.Rigidity.blockLabel
#print axioms HadwigerNelson.Rigidity.exists_pattern_names_le
#print axioms HadwigerNelson.Rigidity.exists_sectionPartition
#print axioms HadwigerNelson.Rigidity.finFour_fibre_model
#print axioms HadwigerNelson.Rigidity.ksEntropy_eq_zero_iff_of_finite
#print axioms HadwigerNelson.Rigidity.ksEntropy_eq_zero_of_iterate
#print axioms HadwigerNelson.Rigidity.ksEntropy_finite_mixture_eq_zero
#print axioms HadwigerNelson.Rigidity.measurable_blockLabel
#print axioms HadwigerNelson.Rigidity.observationEntropy_comp_le
#print axioms HadwigerNelson.Rigidity.condExpKernel_ergodicDecomposition
#print axioms HadwigerNelson.Rigidity.haarSet
#print axioms HadwigerNelson.Rigidity.invariantSigma
#print axioms HadwigerNelson.Rigidity.invariantSigma_le
#print axioms HadwigerNelson.Rigidity.measure_haarSet_eq_zero
#print axioms HadwigerNelson.Rigidity.not_smul_dualHaar_le_dirac_one
#print axioms HadwigerNelson.Rigidity.rotInv_sub_maxMultiple
#print axioms HadwigerNelson.Rigidity.RatioLe
#print axioms HadwigerNelson.Rigidity.SIndep
#print axioms HadwigerNelson.Rigidity.card_le_mul_card_closedNbhd
#print axioms HadwigerNelson.Rigidity.closedNbhd
#print axioms HadwigerNelson.Rigidity.closedNbhd.congr_simp
#print axioms HadwigerNelson.Rigidity.ratioLe_one
#print axioms HadwigerNelson.Rigidity.ratioLe_pi
#print axioms HadwigerNelson.Rigidity.ratioLe_prod
#print axioms HadwigerNelson.Rigidity.ratioLe_subgroup
#print axioms HadwigerNelson.Rigidity.Collision.a₁
#print axioms HadwigerNelson.Rigidity.Collision.a₂
#print axioms HadwigerNelson.Rigidity.Collision.box₁
#print axioms HadwigerNelson.Rigidity.Collision.box₂
#print axioms HadwigerNelson.Rigidity.Collision.b₁
#print axioms HadwigerNelson.Rigidity.Collision.b₂
#print axioms HadwigerNelson.Rigidity.Collision.casesOn
#print axioms HadwigerNelson.Rigidity.Collision.ctorIdx
#print axioms HadwigerNelson.Rigidity.Collision.eq
#print axioms HadwigerNelson.Rigidity.Collision.mem_Λ
#print axioms HadwigerNelson.Rigidity.Collision.mem₁
#print axioms HadwigerNelson.Rigidity.Collision.mem₂
#print axioms HadwigerNelson.Rigidity.Collision.mk.inj
#print axioms HadwigerNelson.Rigidity.Collision.mk.injEq
#print axioms HadwigerNelson.Rigidity.Collision.mk.noConfusion
#print axioms HadwigerNelson.Rigidity.Collision.mk.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.Collision.mul_sub_point
#print axioms HadwigerNelson.Rigidity.Collision.ne
#print axioms HadwigerNelson.Rigidity.Collision.noConfusion
#print axioms HadwigerNelson.Rigidity.Collision.noConfusionType
#print axioms HadwigerNelson.Rigidity.Collision.point
#print axioms HadwigerNelson.Rigidity.Collision.point_eq
#print axioms HadwigerNelson.Rigidity.Collision.recOn
#print axioms HadwigerNelson.Rigidity.Collision.size_sub_point_le
#print axioms HadwigerNelson.Rigidity.Collision.y
#print axioms HadwigerNelson.Rigidity.Collision.ℓ
#print axioms HadwigerNelson.Rigidity.Collision.ℓ_eq_ofUnitRing
#print axioms HadwigerNelson.Rigidity.Collision.ℓ_ne_zero
#print axioms HadwigerNelson.Rigidity.TateModel.exists_collision
#print axioms HadwigerNelson.Rigidity.TateModel.exists_point_of_heavy
#print axioms HadwigerNelson.Rigidity.TateModel.leafSet
#print axioms HadwigerNelson.Rigidity.TateModel.measurableSet_leafSet
#print axioms HadwigerNelson.Rigidity.TateModel.measure_leafSet_compl_eq_zero
#print axioms HadwigerNelson.Rigidity.heavyExponent
#print axioms HadwigerNelson.Rigidity.heavyExponent_pos
#print axioms HadwigerNelson.Rigidity.scaleHeight
#print axioms HadwigerNelson.Rigidity.scaleHeight_three_mul_sq
#print axioms HadwigerNelson.Rigidity.scaleThin
#print axioms HadwigerNelson.Rigidity.le_maxMultiple
#print axioms HadwigerNelson.Rigidity.map_sub_maxMultiple
#print axioms HadwigerNelson.Rigidity.maxMultiple
#print axioms HadwigerNelson.Rigidity.maxMultiple_le_measure_univ
#print axioms HadwigerNelson.Rigidity.maxMultiple_self
#print axioms HadwigerNelson.Rigidity.maxMultiple_smul_le
#print axioms HadwigerNelson.Rigidity.not_smul_le_sub_maxMultiple
#print axioms HadwigerNelson.Rigidity.smul_le_iff_le_maxMultiple
#print axioms HadwigerNelson.Rigidity.sub_maxMultiple_add
#print axioms HadwigerNelson.Rigidity.bochnerHerglotz_of_countable
#print axioms HadwigerNelson.Rigidity.exists_almostInvariant_weights
#print axioms HadwigerNelson.Rigidity.exists_fejer_measures
#print axioms HadwigerNelson.Rigidity.exists_fourier_eq_of_tendsto
#print axioms HadwigerNelson.Rigidity.exists_rotInvariant_of_shiftInvariant
#print axioms HadwigerNelson.Rigidity.exists_shiftInvariant_on
#print axioms HadwigerNelson.Rigidity.invariantMeasureOnClosed_of_countable
#print axioms HadwigerNelson.Rigidity.absAt_multiplier_arch
#print axioms HadwigerNelson.Rigidity.coe_multiplier
#print axioms HadwigerNelson.Rigidity.multiplier
#print axioms HadwigerNelson.Rigidity.multiplier.congr_simp
#print axioms HadwigerNelson.Rigidity.multiplier_injective
#print axioms HadwigerNelson.Rigidity.multiplier_one
#print axioms HadwigerNelson.Rigidity.splitHeight_multiplier_le
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.mulR
#print axioms HadwigerNelson.Rigidity.IsPiece.casesOn
#print axioms HadwigerNelson.Rigidity.IsPiece.fg
#print axioms HadwigerNelson.Rigidity.IsPiece.fullRank
#print axioms HadwigerNelson.Rigidity.IsPiece.mulR_mem
#print axioms HadwigerNelson.Rigidity.IsPiece.recOn
#print axioms HadwigerNelson.Rigidity.PieceDual
#print axioms HadwigerNelson.Rigidity.PieceDual.continuous_dualMap
#print axioms HadwigerNelson.Rigidity.PieceDual.dualMap
#print axioms HadwigerNelson.Rigidity.PieceDual.dualMap_apply
#print axioms HadwigerNelson.Rigidity.PieceDual.dualMap_comp
#print axioms HadwigerNelson.Rigidity.PieceDual.dualMap_id
#print axioms HadwigerNelson.Rigidity.PieceDual.instAddCommGroup
#print axioms HadwigerNelson.Rigidity.PieceDual.instBorelSpaceOfCountable
#print axioms HadwigerNelson.Rigidity.PieceDual.instIsTopologicalAddGroup
#print axioms HadwigerNelson.Rigidity.PieceDual.instMeasurableSpace
#print axioms HadwigerNelson.Rigidity.PieceDual.instPolishSpaceOfCountable
#print axioms HadwigerNelson.Rigidity.PieceDual.instTopologicalSpace
#print axioms HadwigerNelson.Rigidity.PieceDual.ofChar
#print axioms HadwigerNelson.Rigidity.exists_pieceChain
#print axioms HadwigerNelson.Rigidity.integral_eq_zero_of_isAddHaarMeasure
#print axioms HadwigerNelson.Rigidity.isErgodicOn_map_toPiece
#print axioms HadwigerNelson.Rigidity.isPiece_closure_one
#print axioms HadwigerNelson.Rigidity.isSolenoid_pieceDual
#print axioms HadwigerNelson.Rigidity.isTotallyIrreducible_pieceAction
#print axioms HadwigerNelson.Rigidity.ksEntropy_rot_eq_iSup
#print axioms HadwigerNelson.Rigidity.measurable_toPiece
#print axioms HadwigerNelson.Rigidity.not_isVirtuallyCyclic_pieceAction
#print axioms HadwigerNelson.Rigidity.pieceAction
#print axioms HadwigerNelson.Rigidity.pieceMul
#print axioms HadwigerNelson.Rigidity.pieceMul_add
#print axioms HadwigerNelson.Rigidity.pieceMul_zero
#print axioms HadwigerNelson.Rigidity.toPiece
#print axioms HadwigerNelson.Rigidity.toPiece_rot
#print axioms HadwigerNelson.Rigidity.TateModel.IsGap
#print axioms HadwigerNelson.Rigidity.TateModel.exists_isGap
#print axioms HadwigerNelson.Rigidity.WPlace.absAt
#print axioms HadwigerNelson.Rigidity.WPlace.absAt.congr_simp
#print axioms HadwigerNelson.Rigidity.WPlace.absAt_eq_zero
#print axioms HadwigerNelson.Rigidity.WPlace.absAt_mul
#print axioms HadwigerNelson.Rigidity.WPlace.absAt_natCast_le_one
#print axioms HadwigerNelson.Rigidity.WPlace.absAt_nonneg
#print axioms HadwigerNelson.Rigidity.WPlace.arch.elim
#print axioms HadwigerNelson.Rigidity.WPlace.arch.inj
#print axioms HadwigerNelson.Rigidity.WPlace.arch.injEq
#print axioms HadwigerNelson.Rigidity.WPlace.arch.noConfusion
#print axioms HadwigerNelson.Rigidity.WPlace.arch.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.WPlace.casesOn
#print axioms HadwigerNelson.Rigidity.WPlace.continuous_size
#print axioms HadwigerNelson.Rigidity.WPlace.ctorElim
#print axioms HadwigerNelson.Rigidity.WPlace.ctorElimType
#print axioms HadwigerNelson.Rigidity.WPlace.ctorIdx
#print axioms HadwigerNelson.Rigidity.WPlace.noConfusion
#print axioms HadwigerNelson.Rigidity.WPlace.noConfusionType
#print axioms HadwigerNelson.Rigidity.WPlace.recOn
#print axioms HadwigerNelson.Rigidity.WPlace.size
#print axioms HadwigerNelson.Rigidity.WPlace.size_add_le
#print axioms HadwigerNelson.Rigidity.WPlace.size_add_le_max
#print axioms HadwigerNelson.Rigidity.WPlace.size_le_one_iff
#print axioms HadwigerNelson.Rigidity.WPlace.size_neg
#print axioms HadwigerNelson.Rigidity.WPlace.size_nonneg
#print axioms HadwigerNelson.Rigidity.WPlace.size_toSAdele
#print axioms HadwigerNelson.Rigidity.WPlace.size_toSAdele_mul
#print axioms HadwigerNelson.Rigidity.WPlace.split.elim
#print axioms HadwigerNelson.Rigidity.WPlace.split.inj
#print axioms HadwigerNelson.Rigidity.WPlace.split.injEq
#print axioms HadwigerNelson.Rigidity.WPlace.split.noConfusion
#print axioms HadwigerNelson.Rigidity.WPlace.split.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.absAt_le_splitHeight
#print axioms HadwigerNelson.Rigidity.countable_fieldI
#print axioms HadwigerNelson.Rigidity.countable_splitPlace
#print axioms HadwigerNelson.Rigidity.eq_zero_of_toSAdele_mem_hyperplane
#print axioms HadwigerNelson.Rigidity.exists_finset_absAt_le_one
#print axioms HadwigerNelson.Rigidity.exists_one_lt_absAt
#print axioms HadwigerNelson.Rigidity.exists_unitVector_absAt_lt_one
#print axioms HadwigerNelson.Rigidity.hyperplane
#print axioms HadwigerNelson.Rigidity.isClosed_hyperplane
#print axioms HadwigerNelson.Rigidity.ofUnitRing_mem_stableIntegers
#print axioms HadwigerNelson.Rigidity.one_le_prod_absAt_of_mem_stableIntegers
#print axioms HadwigerNelson.Rigidity.one_le_splitHeight
#print axioms HadwigerNelson.Rigidity.splitHeight
#print axioms HadwigerNelson.Rigidity.splitHeight_eq_prod
#print axioms HadwigerNelson.Rigidity.toSAdele_mul_mem_hyperplane
#print axioms HadwigerNelson.Rigidity.unitL_eq_ofUnitRing
#print axioms HadwigerNelson.Rigidity.RowsEdgeNull
#print axioms HadwigerNelson.Rigidity.ae_disjoint_touched
#print axioms HadwigerNelson.Rigidity.ae_sIndep_social
#print axioms HadwigerNelson.Rigidity.lonely
#print axioms HadwigerNelson.Rigidity.measurableSet_lonely
#print axioms HadwigerNelson.Rigidity.social
#print axioms HadwigerNelson.Rigidity.sum_volume_inter_sq_le
#print axioms HadwigerNelson.Rigidity.touched
#print axioms HadwigerNelson.Rigidity.unitPairsNull_lonely
#print axioms HadwigerNelson.Rigidity.ZdAction.IsTotallyIrreducible.isIrreducible
#print axioms HadwigerNelson.Rigidity.ZdAction.coe_nsmul
#print axioms HadwigerNelson.Rigidity.ZdAction.eq_of_isErgodicOn_of_invariant_component
#print axioms HadwigerNelson.Rigidity.ZdAction.invariantComponent_model
#print axioms HadwigerNelson.Rigidity.ZdAction.map_eq_of_isAddHaarMeasure
#print axioms HadwigerNelson.Rigidity.ZdAction.mulTwoThree
#print axioms HadwigerNelson.Rigidity.ZdAction.mulTwoThree_model
#print axioms HadwigerNelson.Rigidity.ZdAction.noVirtuallyCyclicFactors_of_isIrreducible
#print axioms HadwigerNelson.Rigidity.ZdAction.two_le_of_not_isVirtuallyCyclic
#print axioms HadwigerNelson.Rigidity.finTwo_haar_model
#print axioms HadwigerNelson.Rigidity.isAddHaarMeasure_of_add_invariant
#print axioms HadwigerNelson.Rigidity.positive_entropy_rigidity_model
#print axioms HadwigerNelson.Rigidity.dense_mixedEmbedding_nsmul_unitRing
#print axioms HadwigerNelson.Rigidity.exists_mul_stableIntegers_le
#print axioms HadwigerNelson.Rigidity.mem_stableIntegers
#print axioms HadwigerNelson.Rigidity.stableIntegers
#print axioms HadwigerNelson.Rigidity.unitRing_le_stableIntegers
#print axioms HadwigerNelson.SpectralChain.StablePrime.localRing.congr_simp
#print axioms HadwigerNelson.Rigidity.IsSolenoid.casesOn
#print axioms HadwigerNelson.Rigidity.IsSolenoid.compactSpace
#print axioms HadwigerNelson.Rigidity.IsSolenoid.connectedSpace
#print axioms HadwigerNelson.Rigidity.IsSolenoid.dual_embeds
#print axioms HadwigerNelson.Rigidity.IsSolenoid.isTopologicalAddGroup
#print axioms HadwigerNelson.Rigidity.IsSolenoid.recOn
#print axioms HadwigerNelson.Rigidity.IsSolenoid.t2Space
#print axioms HadwigerNelson.Rigidity.ZdAction.InvariantOn
#print axioms HadwigerNelson.Rigidity.ZdAction.IsErgodicOn
#print axioms HadwigerNelson.Rigidity.ZdAction.IsIrreducible
#print axioms HadwigerNelson.Rigidity.ZdAction.IsTotallyIrreducible
#print axioms HadwigerNelson.Rigidity.ZdAction.IsVirtuallyCyclic
#print axioms HadwigerNelson.Rigidity.ZdAction.IsVirtuallyCyclicMod
#print axioms HadwigerNelson.Rigidity.ZdAction.NoVirtuallyCyclicFactors
#print axioms HadwigerNelson.Rigidity.ZdAction.casesOn
#print axioms HadwigerNelson.Rigidity.ZdAction.continuous'
#print axioms HadwigerNelson.Rigidity.ZdAction.ctorIdx
#print axioms HadwigerNelson.Rigidity.ZdAction.instCoeFunForallForallFinIntAddMonoidHom
#print axioms HadwigerNelson.Rigidity.ZdAction.isVirtuallyCyclicMod_bot
#print axioms HadwigerNelson.Rigidity.ZdAction.map_add'
#print axioms HadwigerNelson.Rigidity.ZdAction.map_zero'
#print axioms HadwigerNelson.Rigidity.ZdAction.mk.inj
#print axioms HadwigerNelson.Rigidity.ZdAction.mk.injEq
#print axioms HadwigerNelson.Rigidity.ZdAction.mk.noConfusion
#print axioms HadwigerNelson.Rigidity.ZdAction.mk.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.ZdAction.noConfusion
#print axioms HadwigerNelson.Rigidity.ZdAction.noConfusionType
#print axioms HadwigerNelson.Rigidity.ZdAction.recOn
#print axioms HadwigerNelson.Rigidity.ZdAction.toFun
#print axioms HadwigerNelson.Rigidity.ZdAction.trivial
#print axioms HadwigerNelson.Rigidity.isSolenoid_unit
#print axioms HadwigerNelson.Rigidity.trivialAction_isErgodicOn
#print axioms HadwigerNelson.Rigidity.trivialAction_noVirtuallyCyclicFactors
#print axioms HadwigerNelson.Rigidity.ZdAction.IsErgodicOn.null_or_conull_of_ae_invariant
#print axioms HadwigerNelson.Rigidity.IsSpectralMeasureOf.add_of_orthogonal
#print axioms HadwigerNelson.Rigidity.IsSpectralMeasureOf.unique
#print axioms HadwigerNelson.Rigidity.comp_koopmanSum
#print axioms HadwigerNelson.Rigidity.comp_mem_contVec
#print axioms HadwigerNelson.Rigidity.exists_isSpectralMeasureOf
#print axioms HadwigerNelson.Rigidity.exists_spectral_vector
#print axioms HadwigerNelson.Rigidity.exists_trigPoly_tendsto
#print axioms HadwigerNelson.Rigidity.gram_sum_eq
#print axioms HadwigerNelson.Rigidity.inner_comp_eq_inner_comp_neg
#print axioms HadwigerNelson.Rigidity.inner_koopmanSum_re
#print axioms HadwigerNelson.Rigidity.isSpectralMeasureOf_condExpL2
#print axioms HadwigerNelson.Rigidity.koopmanSum
#print axioms HadwigerNelson.Rigidity.koopmanSum.congr_simp
#print axioms HadwigerNelson.Rigidity.norm_sq_koopmanSum_re_add_im
#print axioms HadwigerNelson.Rigidity.posDef_koopman
#print axioms HadwigerNelson.Rigidity.spectral_contChars_null_of_orthogonal
#print axioms HadwigerNelson.Rigidity.spectral_null_model
#print axioms HadwigerNelson.Rigidity.spectral_null_of_orthogonal
#print axioms HadwigerNelson.Rigidity.trigPoly
#print axioms MeasureTheory.Lp.compMeasurePreservingₗ.congr_simp
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_of_ratioAtMost
#print axioms HadwigerNelson.Rigidity.five_le_localBound_of_tca
#print axioms HadwigerNelson.Rigidity.stablePrime_card_of_two_notMem
#print axioms HadwigerNelson.Rigidity.two_notMem_of_isSquare
#print axioms HadwigerNelson.Rigidity.integral_subgroupHaar_eq
#print axioms HadwigerNelson.Rigidity.integral_subgroupHaar_of_mem
#print axioms HadwigerNelson.Rigidity.integral_subgroupHaar_of_not_mem
#print axioms HadwigerNelson.Rigidity.isProbabilityMeasure_subgroupHaar
#print axioms HadwigerNelson.Rigidity.subgroupHaar
#print axioms HadwigerNelson.Rigidity.subgroupHaar_bot
#print axioms HadwigerNelson.Rigidity.subgroupHaar_compl
#print axioms HadwigerNelson.Rigidity.subgroupHaar_pos
#print axioms HadwigerNelson.Rigidity.archTrace
#print axioms HadwigerNelson.Rigidity.archTrace_mixedEmbedding
#print axioms HadwigerNelson.Rigidity.archTrace_mixedEmbedding_one
#print axioms HadwigerNelson.Rigidity.exists_eq_mixedEmbedding_of_archTrace_int
#print axioms HadwigerNelson.Rigidity.IsApprox
#print axioms HadwigerNelson.Rigidity.continuous_tateChar
#print axioms HadwigerNelson.Rigidity.continuous_tatePi
#print axioms HadwigerNelson.Rigidity.exists_int_trace_sub_of_isApprox
#print axioms HadwigerNelson.Rigidity.exists_isApprox
#print axioms HadwigerNelson.Rigidity.mem_stableIntegers_iff_valuation
#print axioms HadwigerNelson.Rigidity.tateChar
#print axioms HadwigerNelson.Rigidity.tateCharFun
#print axioms HadwigerNelson.Rigidity.tateCharFun_add
#print axioms HadwigerNelson.Rigidity.tateCharFun_eq
#print axioms HadwigerNelson.Rigidity.tateCharFun_zero
#print axioms HadwigerNelson.Rigidity.tateChar_of_integral
#print axioms HadwigerNelson.Rigidity.tateChar_toSAdele_of_mem
#print axioms HadwigerNelson.Rigidity.tatePi
#print axioms HadwigerNelson.Rigidity.tatePi_apply
#print axioms HadwigerNelson.Rigidity.tatePi_arch_mem
#print axioms HadwigerNelson.Rigidity.tatePi_toSAdele_of_mem
#print axioms HadwigerNelson.Rigidity.tatePi_unit_mul
#print axioms HadwigerNelson.Rigidity.exists_tateModel
#print axioms HadwigerNelson.Rigidity.eq_zero_of_mem_oAnn
#print axioms HadwigerNelson.Rigidity.exists_eq_mixedEmbedding_of_mem_oAnn
#print axioms HadwigerNelson.Rigidity.exists_nat_forall_mem_oAnn
#print axioms HadwigerNelson.Rigidity.oAnn
#print axioms HadwigerNelson.Rigidity.surjective_tatePi
#print axioms HadwigerNelson.Rigidity.tatePi_eq_one_forall_imp
#print axioms HadwigerNelson.Rigidity.tatePi_exists_isCompact
#print axioms HadwigerNelson.Rigidity.tatePi_exists_nat_mul_mem
#print axioms HadwigerNelson.Rigidity.tatePi_ker_subset
#print axioms HadwigerNelson.Rigidity.compactSpace_adicCompletionIntegers
#print axioms HadwigerNelson.Rigidity.exists_approx_completion
#print axioms HadwigerNelson.Rigidity.exists_int_trace_of_integral
#print axioms HadwigerNelson.Rigidity.exists_nat_mul_integral_of_trace_int
#print axioms HadwigerNelson.Rigidity.exists_trace_not_int_away
#print axioms HadwigerNelson.Rigidity.exists_valuation_le_one_away
#print axioms HadwigerNelson.Rigidity.IsStablePlace
#print axioms HadwigerNelson.Rigidity.SAdeleRing
#print axioms HadwigerNelson.Rigidity.SplitAdeleRing
#print axioms HadwigerNelson.Rigidity.SplitPlace
#print axioms HadwigerNelson.Rigidity.TateModel.arch_mem
#print axioms HadwigerNelson.Rigidity.TateModel.casesOn
#print axioms HadwigerNelson.Rigidity.TateModel.continuous_π
#print axioms HadwigerNelson.Rigidity.TateModel.ctorIdx
#print axioms HadwigerNelson.Rigidity.TateModel.exists_isCompact
#print axioms HadwigerNelson.Rigidity.TateModel.exists_nat_mul_mem
#print axioms HadwigerNelson.Rigidity.TateModel.isOpenMap
#print axioms HadwigerNelson.Rigidity.TateModel.ker_eq
#print axioms HadwigerNelson.Rigidity.TateModel.ker_subset
#print axioms HadwigerNelson.Rigidity.TateModel.mem_TA
#print axioms HadwigerNelson.Rigidity.TateModel.mem_Λ
#print axioms HadwigerNelson.Rigidity.TateModel.mk.inj
#print axioms HadwigerNelson.Rigidity.TateModel.mk.injEq
#print axioms HadwigerNelson.Rigidity.TateModel.mk.noConfusion
#print axioms HadwigerNelson.Rigidity.TateModel.mk.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.TateModel.mul_mem_Λ
#print axioms HadwigerNelson.Rigidity.TateModel.noConfusion
#print axioms HadwigerNelson.Rigidity.TateModel.noConfusionType
#print axioms HadwigerNelson.Rigidity.TateModel.recOn
#print axioms HadwigerNelson.Rigidity.TateModel.sigmaCompactSpace
#print axioms HadwigerNelson.Rigidity.TateModel.stableIntegers_le
#print axioms HadwigerNelson.Rigidity.TateModel.surjective_π
#print axioms HadwigerNelson.Rigidity.TateModel.toSAdele_mem_torsionChars
#print axioms HadwigerNelson.Rigidity.TateModel.Λ
#print axioms HadwigerNelson.Rigidity.TateModel.π
#print axioms HadwigerNelson.Rigidity.TateModel.π_eq_π_iff
#print axioms HadwigerNelson.Rigidity.TateModel.π_unit_mul
#print axioms HadwigerNelson.Rigidity.ofUnitRing
#print axioms HadwigerNelson.Rigidity.splitAdeleRing_isOpen_integers
#print axioms HadwigerNelson.Rigidity.toSAdele
#print axioms HadwigerNelson.Rigidity.toSplitAdele
#print axioms HadwigerNelson.Rigidity.unitL
#print axioms HadwigerNelson.Rigidity.SAdeleRing.congr_simp
#print axioms HadwigerNelson.Rigidity.TateModel.congr_simp
#print axioms HadwigerNelson.Rigidity.TateModel.exists_box_partition
#print axioms HadwigerNelson.Rigidity.TateModel.exists_orbit_box
#print axioms HadwigerNelson.Rigidity.TateModel.iterate_rot_π
#print axioms HadwigerNelson.Rigidity.TateModel.measurableSet_image
#print axioms HadwigerNelson.Rigidity.TateModel.nameCell_subset
#print axioms HadwigerNelson.Rigidity.TateModel.thinBox_heavy
#print axioms HadwigerNelson.Rigidity.box
#print axioms HadwigerNelson.Rigidity.closedBox
#print axioms HadwigerNelson.Rigidity.closedThinBox
#print axioms HadwigerNelson.Rigidity.exists_delta_of_one_lt
#print axioms HadwigerNelson.Rigidity.exists_eps_lt
#print axioms HadwigerNelson.Rigidity.exists_heavy_nameCells
#print axioms HadwigerNelson.Rigidity.isClosed_closedThinBox
#print axioms HadwigerNelson.Rigidity.isOpen_box
#print axioms HadwigerNelson.Rigidity.size_le_of_mem_box
#print axioms HadwigerNelson.Rigidity.splitHeight.congr_simp
#print axioms HadwigerNelson.Rigidity.sub_mem_box
#print axioms HadwigerNelson.Rigidity.thinBox
#print axioms HadwigerNelson.Rigidity.thinBox_mono
#print axioms HadwigerNelson.Rigidity.thinBox_subset_closedThinBox
#print axioms HadwigerNelson.Rigidity.zero_mem_box
#print axioms HadwigerNelson.Rigidity.colourCond
#print axioms HadwigerNelson.Rigidity.colourCond_ae_eq_condLaw
#print axioms HadwigerNelson.Rigidity.colourFactor
#print axioms HadwigerNelson.Rigidity.colourFactor.congr_simp
#print axioms HadwigerNelson.Rigidity.colourInd
#print axioms HadwigerNelson.Rigidity.colourShift
#print axioms HadwigerNelson.Rigidity.colourShift_add
#print axioms HadwigerNelson.Rigidity.colourShift_zero
#print axioms HadwigerNelson.Rigidity.condLaw_comp_colourShift
#print axioms HadwigerNelson.Rigidity.inner_colourInd_comp_unit
#print axioms HadwigerNelson.Rigidity.integral_colourCond_mul_comp
#print axioms HadwigerNelson.Rigidity.integral_colourInd_mul_comp
#print axioms HadwigerNelson.Rigidity.integral_condLaw_mul_nonneg
#print axioms HadwigerNelson.Rigidity.measurable_colourShift
#print axioms HadwigerNelson.Rigidity.setIntegral_compl_TA_re
#print axioms HadwigerNelson.Rigidity.setIntegral_compl_TA_re_nonpos
#print axioms HadwigerNelson.Rigidity.setIntegral_compl_TA_rot
#print axioms HadwigerNelson.Rigidity.three_mul_tetra_add_one
#print axioms HadwigerNelson.Rigidity.trace_decomp
#print axioms HadwigerNelson.SpectralChain.InvariantColouring.measurePreserving_shift
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.casesOn
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.ctorIdx
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.generates
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.injective
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.mem_subgroup
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.mk.inj
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.mk.injEq
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.mk.noConfusion
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.mk.sizeOf_spec
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.noConfusion
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.noConfusionType
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.ofPow
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.recOn
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.subgroup
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.u
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.u_nonTorsion
#print axioms HadwigerNelson.Rigidity.AdmissiblePair.w
#print axioms HadwigerNelson.Rigidity.coe_toUnitVector
#print axioms HadwigerNelson.Rigidity.countable_unitCircle
#print axioms HadwigerNelson.Rigidity.countable_unitRing_of_numberField
#print axioms HadwigerNelson.Rigidity.exists_admissiblePair
#print axioms HadwigerNelson.Rigidity.instMulActionDual
#print axioms HadwigerNelson.Rigidity.measurableConstSMul_dual
#print axioms HadwigerNelson.Rigidity.mem_unitCircle
#print axioms HadwigerNelson.Rigidity.rotInv_iff
#print axioms HadwigerNelson.Rigidity.smul_def
#print axioms HadwigerNelson.Rigidity.toUnitVector
#print axioms HadwigerNelson.Rigidity.unitCircle
#print axioms HadwigerNelson.Rigidity.unitCircleEquiv
#print axioms HadwigerNelson.Rigidity.uvRing_toUnitVector_mul
#print axioms HadwigerNelson.Rigidity.uvRing_toUnitVector_one
#print axioms HadwigerNelson.Rigidity.zpowHom
#print axioms HadwigerNelson.SpectralInputs.IsHaarFourier.rotInv
#print axioms HadwigerNelson.Rigidity.TateModel.eq_of_π_add_eq
#print axioms HadwigerNelson.Rigidity.TateModel.iterate_rot_not_mem_shell
#print axioms HadwigerNelson.Rigidity.TateModel.leafSet_subset
#print axioms HadwigerNelson.Rigidity.TateModel.measurableSet_shell
#print axioms HadwigerNelson.Rigidity.TateModel.measure_compl_TA_eq_zero
#print axioms HadwigerNelson.Rigidity.TateModel.measure_shell_eq_zero
#print axioms HadwigerNelson.Rigidity.TateModel.shell
#print axioms HadwigerNelson.Rigidity.exists_absAt_eq_norm
#print axioms HadwigerNelson.Rigidity.zeroEntropyCarried_of_tateModel
#print axioms HadwigerNelson.Rigidity.zeroEntropyCarried
#print axioms HadwigerNelson.Rigidity.IsBadStart
#print axioms HadwigerNelson.Rigidity.badStarts
#print axioms HadwigerNelson.Rigidity.badStarts_nameOf_le_visits
#print axioms HadwigerNelson.Rigidity.card_words_badStarts_le
#print axioms HadwigerNelson.Rigidity.exists_forall_exp_le_measureReal_nameCell
#print axioms HadwigerNelson.Rigidity.heavyNames
#print axioms HadwigerNelson.Rigidity.instDecidablePredNatIsBadStartOfDecidableEq
#print axioms HadwigerNelson.Rigidity.measurable_nameOf
#print axioms HadwigerNelson.Rigidity.measureReal_lightCells_le
#print axioms HadwigerNelson.Rigidity.measure_frequentVisits_le
#print axioms HadwigerNelson.Rigidity.mem_heavyNames
#print axioms HadwigerNelson.Rigidity.mem_nameCell_iff_nameOf
#print axioms HadwigerNelson.Rigidity.mem_nameCell_nameOf
#print axioms HadwigerNelson.Rigidity.mul_card_heavyNames_le
#print axioms HadwigerNelson.Rigidity.mul_measureReal_light_le_blockEntropy
#print axioms HadwigerNelson.Rigidity.nameOf
#print axioms HadwigerNelson.Rigidity.nameOf_apply
#print axioms HadwigerNelson.Rigidity.rpow_mul_exp_le_exp
#print axioms HadwigerNelson.Rigidity.visits
#print axioms HadwigerNelson.Rigidity.wordBlock
#print axioms HadwigerNelson.Rigidity.wordBlock_nameOf
#print axioms HadwigerNelson.Rigidity.zeroEntropyNames_model
-- FS131-LGT1 (CLEAN): the certificate link (`Arith/FibreShareIneq`, `Rigidity/CertLink`, `Rigidity/CertLinkModels`; FS131-IKL1, its drafts applied by FS131-LCH1) — 25
#print axioms HadwigerNelson.FibreShare.card_fibre_mul
#print axioms HadwigerNelson.FibreShare.exists_eq_compAddMonoidHom
#print axioms HadwigerNelson.FibreShare.fibreCount
#print axioms HadwigerNelson.FibreShare.fibreCount.congr_simp
#print axioms HadwigerNelson.FibreShare.fibreShare_le
#print axioms HadwigerNelson.FibreShare.fibreShare_le_model
#print axioms HadwigerNelson.FibreShare.sum_weighted_sq
#print axioms HadwigerNelson.FibreShare.sum_weighted_sq_mul_charSum
#print axioms HadwigerNelson.CertLink.FibreShareBound
#print axioms HadwigerNelson.CertLink.HenselCount
#print axioms HadwigerNelson.CertLink.NewCharBound
#print axioms HadwigerNelson.CertLink.card_le_of_fibreShareBound
#print axioms HadwigerNelson.CertLink.exists_addEquiv_zmod
#print axioms HadwigerNelson.CertLink.fibreShareBound_eleven
#print axioms HadwigerNelson.CertLink.finite_quotient_pow
#print axioms HadwigerNelson.CertLink.normOneSet
#print axioms HadwigerNelson.CertLink.ratioAtMost_cert_link
#print axioms HadwigerNelson.CertLink.ratioAtMost_eleven
#print axioms HadwigerNelson.CertLink.ratioAtMost_nineteen
#print axioms HadwigerNelson.CertLink.toLevelOne
#print axioms HadwigerNelson.CertLink.toLevelOne_mem_normOneSet
#print axioms HadwigerNelson.CertLink.toLevelOne_mk
#print axioms HadwigerNelson.CertLink.toLevelOne_surjective
#print axioms HadwigerNelson.CertLink.zero_notMem_normOneSet
#print axioms HadwigerNelson.CertLink.fibreShareBound_three
-- FS131-LGT1 (CLEAN): M13's dyadic line (`Arith/CircleCos`, `Arith/BinaryField`, `Arith/DyadicCerts`; FS131-ICM3, FS131-ICM4) — 96
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.casesOn
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.deg
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.first
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.one_le
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.period
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.pos
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.recOn
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.testBit_deg
#print axioms HadwigerNelson.BinaryField.IsPrimitiveCode.testBit_gt
#print axioms HadwigerNelson.BinaryField.charP_two_of_card
#print axioms HadwigerNelson.BinaryField.charSum_ge_of_classes
#print axioms HadwigerNelson.BinaryField.colorable_four_of_check
#print axioms HadwigerNelson.BinaryField.colourCheck
#print axioms HadwigerNelson.BinaryField.ev_inj
#print axioms HadwigerNelson.BinaryField.ev_iterate_step
#print axioms HadwigerNelson.BinaryField.ev_ne_zero
#print axioms HadwigerNelson.BinaryField.ev_step
#print axioms HadwigerNelson.BinaryField.exists_addChar
#print axioms HadwigerNelson.BinaryField.exists_code
#print axioms HadwigerNelson.BinaryField.exists_code_fun
#print axioms HadwigerNelson.BinaryField.exists_ev_iterate_step
#print axioms HadwigerNelson.BinaryField.exists_iterate_step_eq
#print axioms HadwigerNelson.BinaryField.exists_root
#print axioms HadwigerNelson.BinaryField.exists_root_pow_eq
#print axioms HadwigerNelson.BinaryField.isPrimitiveCode_of_check
#print axioms HadwigerNelson.BinaryField.iterate_step_injOn
#print axioms HadwigerNelson.BinaryField.iterate_step_lt
#print axioms HadwigerNelson.BinaryField.iterate_step_ne_zero
#print axioms HadwigerNelson.BinaryField.minimalPeriod_step
#print axioms HadwigerNelson.BinaryField.normOne_eq_image
#print axioms HadwigerNelson.BinaryField.orbitOk
#print axioms HadwigerNelson.BinaryField.orbitOk.eq_def
#print axioms HadwigerNelson.BinaryField.orbitOk_iff
#print axioms HadwigerNelson.BinaryField.pass
#print axioms HadwigerNelson.BinaryField.pass.eq_def
#print axioms HadwigerNelson.BinaryField.pass_class
#print axioms HadwigerNelson.BinaryField.pass_snd
#print axioms HadwigerNelson.BinaryField.primCheck
#print axioms HadwigerNelson.BinaryField.root_pow_eq_one
#print axioms HadwigerNelson.BinaryField.root_pow_inj
#print axioms HadwigerNelson.BinaryField.sq_facts
#print axioms HadwigerNelson.BinaryField.step
#print axioms HadwigerNelson.BinaryField.step_lt
#print axioms HadwigerNelson.BinaryField.step_zero
#print axioms HadwigerNelson.CircleCos.check23
#print axioms HadwigerNelson.CircleCos.check31
#print axioms HadwigerNelson.CircleCos.circ23
#print axioms HadwigerNelson.CircleCos.circ23_eq
#print axioms HadwigerNelson.CircleCos.circ23_nodup
#print axioms HadwigerNelson.CircleCos.circ31
#print axioms HadwigerNelson.CircleCos.circ31_eq
#print axioms HadwigerNelson.CircleCos.circ31_nodup
#print axioms HadwigerNelson.CircleCos.circCheck
#print axioms HadwigerNelson.CircleCos.circCheck_sound
#print axioms HadwigerNelson.CircleCos.circleCos_ge
#print axioms HadwigerNelson.CircleCos.circleCos_of_check
#print axioms HadwigerNelson.CircleCos.cosArg
#print axioms HadwigerNelson.CircleCos.cosLow
#print axioms HadwigerNelson.CircleCos.cosLow_le_cos
#print axioms HadwigerNelson.CircleCos.piLo
#print axioms HadwigerNelson.CircleCos.piLo_lt_pi
#print axioms HadwigerNelson.CircleCos.pi_lt_piLo_add
#print axioms HadwigerNelson.CircleCos.reIPow
#print axioms HadwigerNelson.CircleCos.re_I_pow
#print axioms HadwigerNelson.CircleCos.sum_circle_eq
#print axioms HadwigerNelson.CircleCos.tab23
#print axioms HadwigerNelson.CircleCos.tab23_ok
#print axioms HadwigerNelson.CircleCos.tab31
#print axioms HadwigerNelson.CircleCos.tab31_ok
#print axioms HadwigerNelson.CircleCos.taylorCos
#print axioms HadwigerNelson.CircleCos.taylorCos_sub_le_cos
#print axioms HadwigerNelson.DyadicCerts.B64
#print axioms HadwigerNelson.DyadicCerts.E16
#print axioms HadwigerNelson.DyadicCerts.E32
#print axioms HadwigerNelson.DyadicCerts.E4
#print axioms HadwigerNelson.DyadicCerts.E8
#print axioms HadwigerNelson.DyadicCerts.P10
#print axioms HadwigerNelson.DyadicCerts.P12
#print axioms HadwigerNelson.DyadicCerts.P4
#print axioms HadwigerNelson.DyadicCerts.P6
#print axioms HadwigerNelson.DyadicCerts.P8
#print axioms HadwigerNelson.DyadicCerts.charSum_64_ge
#print axioms HadwigerNelson.DyadicCerts.class64_le
#print axioms HadwigerNelson.DyadicCerts.colorable_four_two_pow
#print axioms HadwigerNelson.DyadicCerts.colour16
#print axioms HadwigerNelson.DyadicCerts.colour32
#print axioms HadwigerNelson.DyadicCerts.colour4
#print axioms HadwigerNelson.DyadicCerts.colour8
#print axioms HadwigerNelson.DyadicCerts.counts64
#print axioms HadwigerNelson.DyadicCerts.counts64_ok
#print axioms HadwigerNelson.DyadicCerts.countsOk64
#print axioms HadwigerNelson.DyadicCerts.prim10
#print axioms HadwigerNelson.DyadicCerts.prim12
#print axioms HadwigerNelson.DyadicCerts.prim4
#print axioms HadwigerNelson.DyadicCerts.prim6
#print axioms HadwigerNelson.DyadicCerts.prim8
-- FS131-LGT1 (CLEAN): the bound at p = 11 and p = 19 (`Arith/FibreCert*`, 81 modules; FS131-IKC1 … FS131-IKC4) — 405
#print axioms HadwigerNelson.FibreCert.Blk.casesOn
#print axioms HadwigerNelson.FibreCert.Blk.ctorIdx
#print axioms HadwigerNelson.FibreCert.Blk.m
#print axioms HadwigerNelson.FibreCert.Blk.mk.inj
#print axioms HadwigerNelson.FibreCert.Blk.mk.injEq
#print axioms HadwigerNelson.FibreCert.Blk.mk.noConfusion
#print axioms HadwigerNelson.FibreCert.Blk.mk.sizeOf_spec
#print axioms HadwigerNelson.FibreCert.Blk.mrows
#print axioms HadwigerNelson.FibreCert.Blk.noConfusion
#print axioms HadwigerNelson.FibreCert.Blk.noConfusionType
#print axioms HadwigerNelson.FibreCert.Blk.pairCoefs
#print axioms HadwigerNelson.FibreCert.Blk.per
#print axioms HadwigerNelson.FibreCert.Blk.recOn
#print axioms HadwigerNelson.FibreCert.Blk.rest
#print axioms HadwigerNelson.FibreCert.Blk.row0
#print axioms HadwigerNelson.FibreCert.Blk.sb
#print axioms HadwigerNelson.FibreCert.Blk.tri
#print axioms HadwigerNelson.FibreCert.Blk.wB
#print axioms HadwigerNelson.FibreCert.Blk.wm
#print axioms HadwigerNelson.FibreCert.Blk.wr
#print axioms HadwigerNelson.FibreCert.Blk.wts
#print axioms HadwigerNelson.FibreCert.Cert.blocks1
#print axioms HadwigerNelson.FibreCert.Cert.blocksq
#print axioms HadwigerNelson.FibreCert.Cert.casesOn
#print axioms HadwigerNelson.FibreCert.Cert.ctorIdx
#print axioms HadwigerNelson.FibreCert.Cert.ds
#print axioms HadwigerNelson.FibreCert.Cert.k1
#print axioms HadwigerNelson.FibreCert.Cert.kb
#print axioms HadwigerNelson.FibreCert.Cert.keys
#print axioms HadwigerNelson.FibreCert.Cert.ko
#print axioms HadwigerNelson.FibreCert.Cert.kp
#print axioms HadwigerNelson.FibreCert.Cert.kq
#print axioms HadwigerNelson.FibreCert.Cert.kr
#print axioms HadwigerNelson.FibreCert.Cert.kw
#print axioms HadwigerNelson.FibreCert.Cert.lb
#print axioms HadwigerNelson.FibreCert.Cert.mk.inj
#print axioms HadwigerNelson.FibreCert.Cert.mk.injEq
#print axioms HadwigerNelson.FibreCert.Cert.mk.noConfusion
#print axioms HadwigerNelson.FibreCert.Cert.mk.sizeOf_spec
#print axioms HadwigerNelson.FibreCert.Cert.noConfusion
#print axioms HadwigerNelson.FibreCert.Cert.noConfusionType
#print axioms HadwigerNelson.FibreCert.Cert.nrows
#print axioms HadwigerNelson.FibreCert.Cert.nseg
#print axioms HadwigerNelson.FibreCert.Cert.ops
#print axioms HadwigerNelson.FibreCert.Cert.orbits
#print axioms HadwigerNelson.FibreCert.Cert.orows
#print axioms HadwigerNelson.FibreCert.Cert.p
#print axioms HadwigerNelson.FibreCert.Cert.p1
#print axioms HadwigerNelson.FibreCert.Cert.per1
#print axioms HadwigerNelson.FibreCert.Cert.pero
#print axioms HadwigerNelson.FibreCert.Cert.perq
#print axioms HadwigerNelson.FibreCert.Cert.perr
#print axioms HadwigerNelson.FibreCert.Cert.qt
#print axioms HadwigerNelson.FibreCert.Cert.recOn
#print axioms HadwigerNelson.FibreCert.Cert.reps
#print axioms HadwigerNelson.FibreCert.Cert.rows
#print axioms HadwigerNelson.FibreCert.Cert.scale
#print axioms HadwigerNelson.FibreCert.Cert.tnu
#print axioms HadwigerNelson.FibreCert.Cert.unum
#print axioms HadwigerNelson.FibreCert.Cert.w
#print axioms HadwigerNelson.FibreCert.Cert.wc
#print axioms HadwigerNelson.FibreCert.Cert.weights
#print axioms HadwigerNelson.FibreCert.Cert.wf
#print axioms HadwigerNelson.FibreCert.ORow
#print axioms HadwigerNelson.FibreCert.Op.a
#print axioms HadwigerNelson.FibreCert.Op.b
#print axioms HadwigerNelson.FibreCert.Op.casesOn
#print axioms HadwigerNelson.FibreCert.Op.ctorIdx
#print axioms HadwigerNelson.FibreCert.Op.mk.inj
#print axioms HadwigerNelson.FibreCert.Op.mk.injEq
#print axioms HadwigerNelson.FibreCert.Op.mk.noConfusion
#print axioms HadwigerNelson.FibreCert.Op.mk.sizeOf_spec
#print axioms HadwigerNelson.FibreCert.Op.mono
#print axioms HadwigerNelson.FibreCert.Op.noConfusion
#print axioms HadwigerNelson.FibreCert.Op.noConfusionType
#print axioms HadwigerNelson.FibreCert.Op.recOn
#print axioms HadwigerNelson.FibreCert.Op.t
#print axioms HadwigerNelson.FibreCert.Op.vn
#print axioms HadwigerNelson.FibreCert.Op.vp
#print axioms HadwigerNelson.FibreCert.P1St
#print axioms HadwigerNelson.FibreCert.Rd.casesOn
#print axioms HadwigerNelson.FibreCert.Rd.ctorIdx
#print axioms HadwigerNelson.FibreCert.Rd.cur
#print axioms HadwigerNelson.FibreCert.Rd.left
#print axioms HadwigerNelson.FibreCert.Rd.mk.inj
#print axioms HadwigerNelson.FibreCert.Rd.mk.injEq
#print axioms HadwigerNelson.FibreCert.Rd.mk.noConfusion
#print axioms HadwigerNelson.FibreCert.Rd.mk.sizeOf_spec
#print axioms HadwigerNelson.FibreCert.Rd.noConfusion
#print axioms HadwigerNelson.FibreCert.Rd.noConfusionType
#print axioms HadwigerNelson.FibreCert.Rd.read
#print axioms HadwigerNelson.FibreCert.Rd.readK
#print axioms HadwigerNelson.FibreCert.Rd.recOn
#print axioms HadwigerNelson.FibreCert.Rd.rest
#print axioms HadwigerNelson.FibreCert.St.casesOn
#print axioms HadwigerNelson.FibreCert.St.ctorIdx
#print axioms HadwigerNelson.FibreCert.St.leaves
#print axioms HadwigerNelson.FibreCert.St.mk.inj
#print axioms HadwigerNelson.FibreCert.St.mk.injEq
#print axioms HadwigerNelson.FibreCert.St.mk.noConfusion
#print axioms HadwigerNelson.FibreCert.St.mk.sizeOf_spec
#print axioms HadwigerNelson.FibreCert.St.noConfusion
#print axioms HadwigerNelson.FibreCert.St.noConfusionType
#print axioms HadwigerNelson.FibreCert.St.ok
#print axioms HadwigerNelson.FibreCert.St.op
#print axioms HadwigerNelson.FibreCert.St.op1
#print axioms HadwigerNelson.FibreCert.St.rd
#print axioms HadwigerNelson.FibreCert.St.recOn
#print axioms HadwigerNelson.FibreCert.St.tot
#print axioms HadwigerNelson.FibreCert.addP
#print axioms HadwigerNelson.FibreCert.autoc
#print axioms HadwigerNelson.FibreCert.bag
#print axioms HadwigerNelson.FibreCert.bagMap
#print axioms HadwigerNelson.FibreCert.bget
#print axioms HadwigerNelson.FibreCert.bmem
#print axioms HadwigerNelson.FibreCert.bmod
#print axioms HadwigerNelson.FibreCert.boxOps
#print axioms HadwigerNelson.FibreCert.btab
#print axioms HadwigerNelson.FibreCert.bucket16
#print axioms HadwigerNelson.FibreCert.certOK
#print axioms HadwigerNelson.FibreCert.cval
#print axioms HadwigerNelson.FibreCert.digit
#print axioms HadwigerNelson.FibreCert.dotP
#print axioms HadwigerNelson.FibreCert.fC
#print axioms HadwigerNelson.FibreCert.fD
#print axioms HadwigerNelson.FibreCert.fE
#print axioms HadwigerNelson.FibreCert.fImg
#print axioms HadwigerNelson.FibreCert.fKey
#print axioms HadwigerNelson.FibreCert.fLeaf
#print axioms HadwigerNelson.FibreCert.fO
#print axioms HadwigerNelson.FibreCert.fR
#print axioms HadwigerNelson.FibreCert.fSeg
#print axioms HadwigerNelson.FibreCert.fSlot
#print axioms HadwigerNelson.FibreCert.fval
#print axioms HadwigerNelson.FibreCert.fwit
#print axioms HadwigerNelson.FibreCert.gList
#print axioms HadwigerNelson.FibreCert.globalOK
#print axioms HadwigerNelson.FibreCert.gmap
#print axioms HadwigerNelson.FibreCert.isUnit
#print axioms HadwigerNelson.FibreCert.kap
#print axioms HadwigerNelson.FibreCert.kappa
#print axioms HadwigerNelson.FibreCert.kblock
#print axioms HadwigerNelson.FibreCert.kmax
#print axioms HadwigerNelson.FibreCert.krow
#print axioms HadwigerNelson.FibreCert.ktable
#print axioms HadwigerNelson.FibreCert.leafAdd
#print axioms HadwigerNelson.FibreCert.lenU
#print axioms HadwigerNelson.FibreCert.lowBits
#print axioms HadwigerNelson.FibreCert.mkP
#print axioms HadwigerNelson.FibreCert.nonneg
#print axioms HadwigerNelson.FibreCert.opGood
#print axioms HadwigerNelson.FibreCert.opI
#print axioms HadwigerNelson.FibreCert.opList
#print axioms HadwigerNelson.FibreCert.opsO1
#print axioms HadwigerNelson.FibreCert.opsO2
#print axioms HadwigerNelson.FibreCert.opsO3
#print axioms HadwigerNelson.FibreCert.opsO4
#print axioms HadwigerNelson.FibreCert.opsO5
#print axioms HadwigerNelson.FibreCert.orbRows
#print axioms HadwigerNelson.FibreCert.orowsOK
#print axioms HadwigerNelson.FibreCert.p1step
#print axioms HadwigerNelson.FibreCert.phase1
#print axioms HadwigerNelson.FibreCert.psdAll
#print axioms HadwigerNelson.FibreCert.psdCheck
#print axioms HadwigerNelson.FibreCert.qcoefs
#print axioms HadwigerNelson.FibreCert.qmonos
#print axioms HadwigerNelson.FibreCert.readN
#print axioms HadwigerNelson.FibreCert.repPairs
#print axioms HadwigerNelson.FibreCert.rowList
#print axioms HadwigerNelson.FibreCert.sList
#print axioms HadwigerNelson.FibreCert.segAll
#print axioms HadwigerNelson.FibreCert.segCheck
#print axioms HadwigerNelson.FibreCert.sfield
#print axioms HadwigerNelson.FibreCert.sigma
#print axioms HadwigerNelson.FibreCert.slotKey
#print axioms HadwigerNelson.FibreCert.subP
#print axioms HadwigerNelson.FibreCert.symRows
#print axioms HadwigerNelson.FibreCert.triGet
#print axioms HadwigerNelson.FibreCert.wtab
#print axioms HadwigerNelson.FibreCert.cert11
#print axioms HadwigerNelson.FibreCert.cert11_nseg
#print axioms HadwigerNelson.FibreCert.cert11_ok
#print axioms HadwigerNelson.FibreCert.cert11_p
#print axioms HadwigerNelson.FibreCert.cert11_scale
#print axioms HadwigerNelson.FibreCert.cert11_unum
#print axioms HadwigerNelson.FibreCertSound.card_le_eleven
#print axioms HadwigerNelson.FibreCertSound.model_eleven
#print axioms HadwigerNelson.FibreCertSound.sum_le_eleven
#print axioms HadwigerNelson.FibreCert.cert11_global
#print axioms HadwigerNelson.FibreCert.cert11_psd
#print axioms HadwigerNelson.FibreCert.cert11_seg0
#print axioms HadwigerNelson.FibreCert.cert11_seg1
#print axioms HadwigerNelson.FibreCert.cert11_seg2
#print axioms HadwigerNelson.FibreCert.cert11_seg3
#print axioms HadwigerNelson.FibreCert.cert11_seg4
#print axioms HadwigerNelson.FibreCert.cert11_seg5
#print axioms HadwigerNelson.FibreCert.cert11_seg6
#print axioms HadwigerNelson.FibreCert.cert11_seg7
#print axioms HadwigerNelson.FibreCert.cert19
#print axioms HadwigerNelson.FibreCert.cert19kt
#print axioms HadwigerNelson.FibreCert.cert19b0
#print axioms HadwigerNelson.FibreCert.cert19b1
#print axioms HadwigerNelson.FibreCert.cert19b10
#print axioms HadwigerNelson.FibreCert.cert19b11
#print axioms HadwigerNelson.FibreCert.cert19b12
#print axioms HadwigerNelson.FibreCert.cert19b13
#print axioms HadwigerNelson.FibreCert.cert19b14
#print axioms HadwigerNelson.FibreCert.cert19b15
#print axioms HadwigerNelson.FibreCert.cert19b16
#print axioms HadwigerNelson.FibreCert.cert19b17
#print axioms HadwigerNelson.FibreCert.cert19b18
#print axioms HadwigerNelson.FibreCert.cert19b2
#print axioms HadwigerNelson.FibreCert.cert19b3
#print axioms HadwigerNelson.FibreCert.cert19b4
#print axioms HadwigerNelson.FibreCert.cert19b5
#print axioms HadwigerNelson.FibreCert.cert19b6
#print axioms HadwigerNelson.FibreCert.cert19b7
#print axioms HadwigerNelson.FibreCert.cert19b8
#print axioms HadwigerNelson.FibreCert.cert19b9
#print axioms HadwigerNelson.FibreCert.cert19_global
#print axioms HadwigerNelson.FibreCert.cert19_nseg
#print axioms HadwigerNelson.FibreCert.cert19_ok
#print axioms HadwigerNelson.FibreCert.cert19_p
#print axioms HadwigerNelson.FibreCert.cert19_phase1
#print axioms HadwigerNelson.FibreCert.cert19_scale
#print axioms HadwigerNelson.FibreCert.cert19_unum
#print axioms HadwigerNelson.FibreCert.ktable_cert19
#print axioms HadwigerNelson.FibreCertSound.bound_nineteen_lt_quarter
#print axioms HadwigerNelson.FibreCertSound.card_div_lt_quarter_nineteen
#print axioms HadwigerNelson.FibreCertSound.card_le_nineteen
#print axioms HadwigerNelson.FibreCertSound.model_nineteen
#print axioms HadwigerNelson.FibreCertSound.sum_le_nineteen
#print axioms HadwigerNelson.FibreCert.cert19_p1c0
#print axioms HadwigerNelson.FibreCert.cert19p1s0
#print axioms HadwigerNelson.FibreCert.cert19_p1c1
#print axioms HadwigerNelson.FibreCert.cert19_p1c2
#print axioms HadwigerNelson.FibreCert.cert19_p1c3
#print axioms HadwigerNelson.FibreCert.cert19_p1c4
#print axioms HadwigerNelson.FibreCert.cert19_p1c5
#print axioms HadwigerNelson.FibreCert.cert19_p1c6
#print axioms HadwigerNelson.FibreCert.cert19_p1c7
#print axioms HadwigerNelson.FibreCert.cert19_globalP
#print axioms HadwigerNelson.FibreCert.cert19kt0
#print axioms HadwigerNelson.FibreCert.cert19kt1
#print axioms HadwigerNelson.FibreCert.cert19kt2
#print axioms HadwigerNelson.FibreCert.cert19kt3
#print axioms HadwigerNelson.FibreCert.cert19kt4
#print axioms HadwigerNelson.FibreCert.cert19kt5
#print axioms HadwigerNelson.FibreCert.cert19kt6
#print axioms HadwigerNelson.FibreCert.cert19kt7
#print axioms HadwigerNelson.FibreCert.cert19_kt0_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt1_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt2_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt3_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt4_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt5_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt6_ok
#print axioms HadwigerNelson.FibreCert.cert19_kt7_ok
#print axioms HadwigerNelson.FibreCert.cert19p1b1
#print axioms HadwigerNelson.FibreCert.cert19p1s1
#print axioms HadwigerNelson.FibreCert.cert19p1b2
#print axioms HadwigerNelson.FibreCert.cert19p1s2
#print axioms HadwigerNelson.FibreCert.cert19p1b3
#print axioms HadwigerNelson.FibreCert.cert19p1s3
#print axioms HadwigerNelson.FibreCert.cert19p1b4
#print axioms HadwigerNelson.FibreCert.cert19p1s4
#print axioms HadwigerNelson.FibreCert.cert19p1b5
#print axioms HadwigerNelson.FibreCert.cert19p1s5
#print axioms HadwigerNelson.FibreCert.cert19p1b6
#print axioms HadwigerNelson.FibreCert.cert19p1s6
#print axioms HadwigerNelson.FibreCert.cert19p1b7
#print axioms HadwigerNelson.FibreCert.cert19p1s7
#print axioms HadwigerNelson.FibreCert.cert19p1b8
#print axioms HadwigerNelson.FibreCert.cert19p1s8
#print axioms HadwigerNelson.FibreCert.cert19_psd0
#print axioms HadwigerNelson.FibreCert.cert19_psd1
#print axioms HadwigerNelson.FibreCert.cert19_psd2
#print axioms HadwigerNelson.FibreCert.cert19_psd3
#print axioms HadwigerNelson.FibreCert.cert19_psd4
#print axioms HadwigerNelson.FibreCert.cert19_psd5
#print axioms HadwigerNelson.FibreCert.cert19_psd6
#print axioms HadwigerNelson.FibreCert.cert19_psd7
#print axioms HadwigerNelson.FibreCert.cert19_psd8
#print axioms HadwigerNelson.FibreCert.cert19_psd9
#print axioms HadwigerNelson.FibreCert.cert19_psd10
#print axioms HadwigerNelson.FibreCert.cert19_psd11
#print axioms HadwigerNelson.FibreCert.cert19_psd12
#print axioms HadwigerNelson.FibreCert.cert19_psd13
#print axioms HadwigerNelson.FibreCert.cert19_psd14
#print axioms HadwigerNelson.FibreCert.cert19_psd15
#print axioms HadwigerNelson.FibreCert.cert19_psd16
#print axioms HadwigerNelson.FibreCert.cert19_psd17
#print axioms HadwigerNelson.FibreCert.cert19_psd18
#print axioms HadwigerNelson.FibreCert.cert19_psdq0
#print axioms HadwigerNelson.FibreCert.cert19q0
#print axioms HadwigerNelson.FibreCert.cert19_seg0
#print axioms HadwigerNelson.FibreCert.cert19_seg1
#print axioms HadwigerNelson.FibreCert.cert19_seg2
#print axioms HadwigerNelson.FibreCert.cert19_seg3
#print axioms HadwigerNelson.FibreCert.cert3
#print axioms HadwigerNelson.FibreCert.cert3_ok
#print axioms HadwigerNelson.FibreCert.St.op_zero
#print axioms HadwigerNelson.FibreCert.beq_zero_false
#print axioms HadwigerNelson.FibreCert.bucketEq
#print axioms HadwigerNelson.FibreCert.bucketEq.eq_def
#print axioms HadwigerNelson.FibreCert.bucketEq_eq
#print axioms HadwigerNelson.FibreCert.bucketsEq
#print axioms HadwigerNelson.FibreCert.bucketsEq.eq_def
#print axioms HadwigerNelson.FibreCert.bucketsEq_eq
#print axioms HadwigerNelson.FibreCert.coefFrom
#print axioms HadwigerNelson.FibreCert.coefFrom_eq
#print axioms HadwigerNelson.FibreCert.cond_addN
#print axioms HadwigerNelson.FibreCert.cond_addP
#print axioms HadwigerNelson.FibreCert.cond_bnd
#print axioms HadwigerNelson.FibreCert.digit_zero
#print axioms HadwigerNelson.FibreCert.entEq
#print axioms HadwigerNelson.FibreCert.entEq_eq
#print axioms HadwigerNelson.FibreCert.eq_flatten_of_pieces
#print axioms HadwigerNelson.FibreCert.fold_chunk
#print axioms HadwigerNelson.FibreCert.fold_drop_chunk
#print axioms HadwigerNelson.FibreCert.fold_drop_chunkF
#print axioms HadwigerNelson.FibreCert.fold_p1stepZ_rd_co
#print axioms HadwigerNelson.FibreCert.foldl_O3
#print axioms HadwigerNelson.FibreCert.foldl_O4
#print axioms HadwigerNelson.FibreCert.foldl_append_zero
#print axioms HadwigerNelson.FibreCert.foldl_op_zero
#print axioms HadwigerNelson.FibreCert.foldl_zero_add
#print axioms HadwigerNelson.FibreCert.foldl_zero_add'
#print axioms HadwigerNelson.FibreCert.globalOKK
#print axioms HadwigerNelson.FibreCert.globalOKKZ
#print axioms HadwigerNelson.FibreCert.globalOKKZ_eq
#print axioms HadwigerNelson.FibreCert.globalOKKZ_eq_P
#print axioms HadwigerNelson.FibreCert.globalOKP
#print axioms HadwigerNelson.FibreCert.globalOK_eq_K
#print axioms HadwigerNelson.FibreCert.izero
#print axioms HadwigerNelson.FibreCert.izero_eq
#print axioms HadwigerNelson.FibreCert.izero_iff
#print axioms HadwigerNelson.FibreCert.izero_mul_mult
#print axioms HadwigerNelson.FibreCert.ktEq
#print axioms HadwigerNelson.FibreCert.ktEq.eq_def
#print axioms HadwigerNelson.FibreCert.ktEq_eq
#print axioms HadwigerNelson.FibreCert.natsEq
#print axioms HadwigerNelson.FibreCert.natsEq.eq_def
#print axioms HadwigerNelson.FibreCert.natsEq_eq
#print axioms HadwigerNelson.FibreCert.opListZ
#print axioms HadwigerNelson.FibreCert.opsO3Z
#print axioms HadwigerNelson.FibreCert.opsO4Z
#print axioms HadwigerNelson.FibreCert.orowEq
#print axioms HadwigerNelson.FibreCert.orowEq_eq
#print axioms HadwigerNelson.FibreCert.orowsOKK
#print axioms HadwigerNelson.FibreCert.orowsOKKZ
#print axioms HadwigerNelson.FibreCert.p1At
#print axioms HadwigerNelson.FibreCert.p1AtF
#print axioms HadwigerNelson.FibreCert.p1AtF_eq
#print axioms HadwigerNelson.FibreCert.p1CoreEq
#print axioms HadwigerNelson.FibreCert.p1bndF
#print axioms HadwigerNelson.FibreCert.p1coefs
#print axioms HadwigerNelson.FibreCert.p1entF
#print axioms HadwigerNelson.FibreCert.p1goodF
#print axioms HadwigerNelson.FibreCert.p1img
#print axioms HadwigerNelson.FibreCert.p1incN
#print axioms HadwigerNelson.FibreCert.p1incP
#print axioms HadwigerNelson.FibreCert.p1mult
#print axioms HadwigerNelson.FibreCert.p1rd
#print axioms HadwigerNelson.FibreCert.p1rhoF
#print axioms HadwigerNelson.FibreCert.p1stepF
#print axioms HadwigerNelson.FibreCert.p1stepF_eq
#print axioms HadwigerNelson.FibreCert.p1stepZ
#print axioms HadwigerNelson.FibreCert.p1stepZ_eq
#print axioms HadwigerNelson.FibreCert.p1zero
#print axioms HadwigerNelson.FibreCert.p1zero_eq
#print axioms HadwigerNelson.FibreCert.pairCoefs_eq
#print axioms HadwigerNelson.FibreCert.phase1K
#print axioms HadwigerNelson.FibreCert.phase1KZ
#print axioms HadwigerNelson.FibreCert.rdAt
#print axioms HadwigerNelson.FibreCert.readIter
#print axioms HadwigerNelson.FibreCert.readIter_add
#print axioms HadwigerNelson.FibreCert.readIter_eq_rdAt
#print axioms HadwigerNelson.FibreCert.readIter_qj
#print axioms HadwigerNelson.FibreCert.readIter_read
#print axioms HadwigerNelson.FibreCert.readK_add
#print axioms HadwigerNelson.FibreCert.readK_len
#print axioms HadwigerNelson.FibreCert.readK_snd
#print axioms HadwigerNelson.FibreCert.read_inside
#print axioms HadwigerNelson.FibreCert.read_next
#print axioms HadwigerNelson.FibreCert.rowsCount
#print axioms HadwigerNelson.FibreCert.rowsCount.eq_def
#print axioms HadwigerNelson.FibreCert.rowsCount_eq_triCount
#print axioms HadwigerNelson.FibreCert.rowsEq
#print axioms HadwigerNelson.FibreCert.rowsEq.eq_def
#print axioms HadwigerNelson.FibreCert.rowsEq_eq
#print axioms HadwigerNelson.FibreCert.rows_flatten
#print axioms HadwigerNelson.FibreCert.segCheckZ
#print axioms HadwigerNelson.FibreCert.segCheck_eq_Z
#print axioms HadwigerNelson.FibreCert.triCount
#print axioms HadwigerNelson.FibreCert.two_mul_rowsCount
#print axioms HadwigerNelson.FibreCert.boxOps.eq_def
#print axioms HadwigerNelson.FibreCertSound.V
#print axioms HadwigerNelson.FibreCertSound.card_le_of_certOK
#print axioms HadwigerNelson.FibreCertSound.model
#print axioms HadwigerNelson.FibreCertSound.qform
#print axioms HadwigerNelson.FibreCertSound.qform.congr_simp
#print axioms HadwigerNelson.FibreCertSound.sum_le_of_certOK
#print axioms HadwigerNelson.FibreCertSound.unitCircle
#print axioms HadwigerNelson.FibreCertSound.unitCircle.congr_simp
-- FS131-LGT1 (CLEAN): main's four modules the join changed (`Arith/ThreeFourColours`, `Arith/UpperHalf`, `Instances/SqrtFortySeven`, `Plane/OneClass/InvariantLaw`) — 27
#print axioms HadwigerNelson.SqrtFortySeven.A
#print axioms HadwigerNelson.SqrtFortySeven.F47
#print axioms HadwigerNelson.SqrtFortySeven.IsElevenIntegral
#print axioms HadwigerNelson.SqrtFortySeven.coe_eq
#print axioms HadwigerNelson.SqrtFortySeven.coords_add
#print axioms HadwigerNelson.SqrtFortySeven.coords_mul
#print axioms HadwigerNelson.SqrtFortySeven.coords_neg
#print axioms HadwigerNelson.SqrtFortySeven.coords_of_eq
#print axioms HadwigerNelson.SqrtFortySeven.coords_one
#print axioms HadwigerNelson.SqrtFortySeven.coords_sqrt47
#print axioms HadwigerNelson.SqrtFortySeven.coords_zero
#print axioms HadwigerNelson.SqrtFortySeven.im47
#print axioms HadwigerNelson.SqrtFortySeven.imA
#print axioms HadwigerNelson.SqrtFortySeven.instFactPrimeOfNatNat_proofs
#print axioms HadwigerNelson.SqrtFortySeven.irrational_s
#print axioms HadwigerNelson.SqrtFortySeven.mem_A
#print axioms HadwigerNelson.SqrtFortySeven.mem_q47_of_mem
#print axioms HadwigerNelson.SqrtFortySeven.phi
#print axioms HadwigerNelson.SqrtFortySeven.q47
#print axioms HadwigerNelson.SqrtFortySeven.re47
#print axioms HadwigerNelson.SqrtFortySeven.reA
#print axioms HadwigerNelson.SqrtFortySeven.red
#print axioms HadwigerNelson.SqrtFortySeven.s
#print axioms HadwigerNelson.SqrtFortySeven.s_mul_s
#print axioms HadwigerNelson.SqrtFortySeven.sqrt47_mem
#print axioms HadwigerNelson.SqrtFortySeven.sqrt47_mem_A
#print axioms HadwigerNelson.SqrtFortySeven.z11
-- FS131-LGT1 block end

/-! ## FS131-IL5 — the main clause through five as one theorem (`Rigidity/MainClauseFive`): its model at `ℚ`. The
module's two theorems rest on the headline's declared imports and are under IMPORTED. -/

#print axioms HadwigerNelson.Rigidity.localBound_bot_le_two

/-! ## FS131-ICO2 — the collapse (`Collapse/Thick` … `Collapse/Headline`) and the approved edit D-E1 (`Arith/FloorPlanes`):
every public record of the nine modules on the standard three or fewer, from the kernel's print
(`data/fs131/ico2/axioms-all.txt`, `data/fs131/ico2/audit_block.py`). The records on declared imports are under IMPORTED. -/

#print axioms HadwigerNelson.StandingFive.KloostermanBound
#print axioms HadwigerNelson.StandingFive.norm_normOne_charSum_le
#print axioms HadwigerNelson.Collapse.InvColouring.carried
#print axioms HadwigerNelson.Collapse.InvColouring.casesOn
#print axioms HadwigerNelson.Collapse.InvColouring.ctorIdx
#print axioms HadwigerNelson.Collapse.InvColouring.isProb
#print axioms HadwigerNelson.Collapse.InvColouring.mk.inj
#print axioms HadwigerNelson.Collapse.InvColouring.mk.injEq
#print axioms HadwigerNelson.Collapse.InvColouring.mk.noConfusion
#print axioms HadwigerNelson.Collapse.InvColouring.mk.sizeOf_spec
#print axioms HadwigerNelson.Collapse.InvColouring.noConfusion
#print axioms HadwigerNelson.Collapse.InvColouring.noConfusionType
#print axioms HadwigerNelson.Collapse.InvColouring.recOn
#print axioms HadwigerNelson.Collapse.InvColouring.rot_inv
#print axioms HadwigerNelson.Collapse.InvColouring.shift_inv
#print axioms HadwigerNelson.Collapse.InvColouring.μ
#print axioms HadwigerNelson.Collapse.Xk
#print axioms HadwigerNelson.Collapse.Xk_one_eq_empty
#print axioms HadwigerNelson.Collapse.exists_invColouring
#print axioms HadwigerNelson.Collapse.isClosed_Xk
#print axioms HadwigerNelson.Collapse.measurableSet_Xk
#print axioms HadwigerNelson.Collapse.nonempty_invColouring_bot
#print axioms HadwigerNelson.Collapse.nonempty_invColouring_of_colorable
#print axioms HadwigerNelson.Collapse.rot_mem_Xk
#print axioms HadwigerNelson.Collapse.shift_mem_Xk
#print axioms HadwigerNelson.Collapse.xk_nonempty_of_colorable
#print axioms HadwigerNelson.Collapse.EqualAtUnitsK
#print axioms HadwigerNelson.Collapse.InvColouring.measurePreserving_shift
#print axioms HadwigerNelson.Collapse.IsColourSpectral
#print axioms HadwigerNelson.Collapse.IsColourSpectral.integral_unit
#print axioms HadwigerNelson.Collapse.IsColourSpectral.rotInv
#print axioms HadwigerNelson.Collapse.IsSPWitness
#print axioms HadwigerNelson.Collapse.colourShiftK
#print axioms HadwigerNelson.Collapse.colourShiftK_add
#print axioms HadwigerNelson.Collapse.condLawK
#print axioms HadwigerNelson.Collapse.equalAtUnitsK_of_not_neg
#print axioms HadwigerNelson.Collapse.exists_factorLawK
#print axioms HadwigerNelson.Collapse.exists_isColourSpectral
#print axioms HadwigerNelson.Collapse.factorK
#print axioms HadwigerNelson.Collapse.factorK.congr_simp
#print axioms HadwigerNelson.Collapse.integral_condLawK_mul_nonneg
#print axioms HadwigerNelson.Collapse.measurable_colourShiftK
#print axioms HadwigerNelson.Collapse.not_isSPWitness_of_mrPlus
#print axioms HadwigerNelson.Collapse.rotInv_restrict_compl_TA
#print axioms HadwigerNelson.Collapse.setIntegral_compl_TA_re_k
#print axioms HadwigerNelson.Collapse.setIntegral_compl_TA_rot_k
#print axioms HadwigerNelson.Collapse.F635087
#print axioms HadwigerNelson.Collapse.FdG
#print axioms HadwigerNelson.Collapse.isSquare_635087
#print axioms HadwigerNelson.Collapse.isSquare_deGrey
#print axioms HadwigerNelson.Collapse.le_of_isSquare_635087
#print axioms HadwigerNelson.Collapse.le_of_isSquare_deGrey
#print axioms HadwigerNelson.Collapse.not_colorable_one_planeOver
#print axioms HadwigerNelson.Collapse.not_thick_bot
#print axioms HadwigerNelson.Collapse.stablePrime_deGrey
#print axioms HadwigerNelson.Collapse.stablePrime_sqrt635087
#print axioms HadwigerNelson.Collapse.weil_103_lt_fifth
#print axioms HadwigerNelson.Collapse.weil_131_lt_fifth
#print axioms HadwigerNelson.Collapse.finite_mixing
#print axioms HadwigerNelson.Collapse.levelFill
#print axioms HadwigerNelson.Collapse.levelResid
#print axioms HadwigerNelson.Collapse.levelResid_nonneg
#print axioms HadwigerNelson.Collapse.mixing_K
#print axioms HadwigerNelson.Collapse.mixing_at_level
#print axioms HadwigerNelson.Collapse.not_both_ge_of_mixing
#print axioms HadwigerNelson.Collapse.tendsto_levelResid
#print axioms HadwigerNelson.Rigidity.Counting.K.congr_simp
#print axioms HadwigerNelson.Collapse.ae_slice_edge
#print axioms HadwigerNelson.Collapse.exists_aeColouring_of_slice
#print axioms HadwigerNelson.Collapse.fibreMass
#print axioms HadwigerNelson.Collapse.le_fibreMass_selCol
#print axioms HadwigerNelson.Collapse.measurable_fibreMass
#print axioms HadwigerNelson.Collapse.measurable_selCol
#print axioms HadwigerNelson.Collapse.not_both_heavy
#print axioms HadwigerNelson.Collapse.selCol
#print axioms HadwigerNelson.Collapse.sum_fibreMass
#print axioms HadwigerNelson.Collapse.unitPairsNull_selCol
#print axioms HadwigerNelson.Collapse.SliceEdgeNullK
#print axioms HadwigerNelson.Collapse.exists_extension_k
#print axioms HadwigerNelson.Collapse.exists_slice_k
#print axioms HadwigerNelson.Collapse.measure_ne_eq_k
#print axioms HadwigerNelson.Collapse.tendsto_measure_ne_k
#print axioms HadwigerNelson.Collapse.LevImg
#print axioms HadwigerNelson.Collapse.Thick
#print axioms HadwigerNelson.Collapse.ThickAt
#print axioms HadwigerNelson.Collapse.ThickAt.mono
#print axioms HadwigerNelson.Collapse.exists_addChar_extend
#print axioms HadwigerNelson.Collapse.finite_levU
#print axioms HadwigerNelson.Collapse.image_levR_unitVectors_of_unramified
#print axioms HadwigerNelson.Collapse.levU
#print axioms HadwigerNelson.Collapse.levU_nonempty
#print axioms HadwigerNelson.Collapse.levelThick
#print axioms HadwigerNelson.Collapse.norm_sum_piFinset_le
#print axioms HadwigerNelson.Collapse.not_isRamified_of_thickAt
#print axioms HadwigerNelson.Collapse.thickAt_one
#print axioms HadwigerNelson.Collapse.weil_const_anti

/-! ## FS131-IQP3 — the p-adic plane (`PadicPlane/Basic` … `PadicPlane/Values`, planned by FS131-KPA1, proved by FS131-IQP1
and FS131-IQP3; FS-66's certificate at 7, `Arith/FibreCert7`, `FibreCert7Check`, `FibreCert7Bound`): every public record of the
eight modules on the standard three or fewer, from the kernel's print (`data/fs131/iqp3/axioms-all.txt`,
`data/fs131/iqp3/audit_block.py`). The six records on Weil's bound are under IMPORTED. -/

#print axioms HadwigerNelson.FibreCert.cert7
#print axioms HadwigerNelson.FibreCert.cert7_nseg
#print axioms HadwigerNelson.FibreCert.cert7_ok
#print axioms HadwigerNelson.FibreCert.cert7_p
#print axioms HadwigerNelson.FibreCert.cert7_scale
#print axioms HadwigerNelson.FibreCert.cert7_unum
#print axioms HadwigerNelson.FibreCertSound.model_seven
#print axioms HadwigerNelson.FibreCertSound.sum_le_seven
#print axioms HadwigerNelson.FibreCert.cert7_global
#print axioms HadwigerNelson.FibreCert.cert7_psd
#print axioms HadwigerNelson.FibreCert.cert7_seg0
#print axioms HadwigerNelson.PadicPlane.TowerRatio
#print axioms HadwigerNelson.PadicPlane.TowerRatio.mono
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_le_of_coloring
#print axioms HadwigerNelson.PadicPlane.chromaticNumber_le_borelChromaticNumber
#print axioms HadwigerNelson.PadicPlane.le_borelChromaticNumber
#print axioms HadwigerNelson.PadicPlane.norm_le_one_of_sq_add_sq_eq_one
#print axioms HadwigerNelson.PadicPlane.not_colorable_of_towerRatio
#print axioms HadwigerNelson.PadicPlane.padicPlane
#print axioms HadwigerNelson.PadicPlane.towerRatio_one
#print axioms HadwigerNelson.PadicPlane.exists_level_haar_bad_le
#print axioms HadwigerNelson.PadicPlane.exists_unitVector_lift
#print axioms HadwigerNelson.PadicPlane.haar
#print axioms HadwigerNelson.PadicPlane.haar_le_of_towerRatio
#print axioms HadwigerNelson.PadicPlane.haar_res_fibre
#print axioms HadwigerNelson.PadicPlane.haar_univ
#print axioms HadwigerNelson.PadicPlane.instBorelSpacePadicInt
#print axioms HadwigerNelson.PadicPlane.instMeasurableSpacePadicInt
#print axioms HadwigerNelson.PadicPlane.isIndepSet_wellFilled
#print axioms HadwigerNelson.PadicPlane.isOpen_res_fibre
#print axioms HadwigerNelson.PadicPlane.le_borelChromaticNumber_of_towerRatio
#print axioms HadwigerNelson.PadicPlane.one_le_mul_of_borelColoring
#print axioms HadwigerNelson.PadicPlane.res
#print axioms HadwigerNelson.PadicPlane.res_apply
#print axioms HadwigerNelson.PadicPlane.res_surjective
#print axioms HadwigerNelson.PadicPlane.charSum_levelOne_of_unitCircle
#print axioms HadwigerNelson.PadicPlane.exists_levelEmbedding
#print axioms HadwigerNelson.PadicPlane.exists_stablePrime_above
#print axioms HadwigerNelson.PadicPlane.ratioAtMost_of_charSum_levelOne
#print axioms HadwigerNelson.PadicPlane.towerRatio_of_charSum
#print axioms HadwigerNelson.PadicPlane.towerRatio_of_fibreShareBound
#print axioms HadwigerNelson.PadicPlane.towerRatio_of_ratioAtMost
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_le_chromaticNumber
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_le_of_colorable
#print axioms HadwigerNelson.PadicPlane.exists_borelColoring_of_colorable
#print axioms HadwigerNelson.PadicPlane.exists_residueMap
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_eleven
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_nineteen
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_seven
#print axioms HadwigerNelson.PadicPlane.borelChromaticNumber_padicPlane_twentyThree_le_eight
#print axioms HadwigerNelson.PadicPlane.factPrimeEleven
#print axioms HadwigerNelson.PadicPlane.factPrimeNineteen
#print axioms HadwigerNelson.PadicPlane.factPrimeSeven
#print axioms HadwigerNelson.PadicPlane.factPrimeThree
#print axioms HadwigerNelson.PadicPlane.factPrimeTwentyThree
#print axioms HadwigerNelson.PadicPlane.fibreShareBound_seven
#print axioms HadwigerNelson.PadicPlane.five_le_borelChromaticNumber_padicPlane_twentyThree
#print axioms HadwigerNelson.PadicPlane.le_borelChromaticNumber_of_charSum
#print axioms HadwigerNelson.PadicPlane.unitQuadrance_zmod_eleven_pow_not_colorable_four
#print axioms HadwigerNelson.PadicPlane.unitQuadrance_zmod_nineteen_pow_not_colorable_four
#print axioms HadwigerNelson.PadicPlane.unitQuadrance_zmod_seven_pow_not_colorable_three

/-! ## FS131-ICT3 — three colours on abelian Cayley graphs (`CayleyThree/Circular`, `Fibre`, `Density`; ledger row 79;
planner FS131-KTC1, implementers FS131-ICT1 to FS131-ICT3): every public record of the three modules, each on the standard
three or fewer, from the kernel's print (`data/fs131/ict3/axioms-all.txt`, `tools/fs131_ict2_audit_block.py`). -/

#print axioms HadwigerNelson.CayleyThree.circular
#print axioms HadwigerNelson.CayleyThree.circularColoring
#print axioms HadwigerNelson.CayleyThree.circular_add_ne
#print axioms HadwigerNelson.CayleyThree.coe_rep01
#print axioms HadwigerNelson.CayleyThree.colorable_three_iff_bandSet_nonempty
#print axioms HadwigerNelson.CayleyThree.colorable_three_iff_exists_isPeriodic
#print axioms HadwigerNelson.CayleyThree.colorable_three_iff_of_fg_torsionFree
#print axioms HadwigerNelson.CayleyThree.colorable_three_rat
#print axioms HadwigerNelson.CayleyThree.coloring_add_ne
#print axioms HadwigerNelson.CayleyThree.exists_rat_solution_near
#print axioms HadwigerNelson.CayleyThree.exists_torsion_mem_bandSet
#print axioms HadwigerNelson.CayleyThree.finiteIndex_ker_of_nsmul_eq_zero
#print axioms HadwigerNelson.CayleyThree.ker_le_periods_circularColoring
#print axioms HadwigerNelson.CayleyThree.not_isPeriodic_rat
#print axioms HadwigerNelson.CayleyThree.rep01
#print axioms HadwigerNelson.CayleyThree.rep01_coe
#print axioms HadwigerNelson.CayleyThree.rep01_mem
#print axioms HadwigerNelson.CayleyThree.abs_le_l1
#print axioms HadwigerNelson.CayleyThree.abs_mcshane_add_single_sub
#print axioms HadwigerNelson.CayleyThree.coloringOneTwo
#print axioms HadwigerNelson.CayleyThree.coloring_mem_closure_isPeriodic
#print axioms HadwigerNelson.CayleyThree.even_l1_sub_sum
#print axioms HadwigerNelson.CayleyThree.exists_isPeriodic_eqOn
#print axioms HadwigerNelson.CayleyThree.exists_isPeriodic_eqOn_of_fg_torsionFree
#print axioms HadwigerNelson.CayleyThree.exists_lt_l1_of_sub_nsmul_mem
#print axioms HadwigerNelson.CayleyThree.exists_periodic_properAlong_eqOn
#print axioms HadwigerNelson.CayleyThree.forcedSubgroup_finiteIndex_iff_finite
#print axioms HadwigerNelson.CayleyThree.heightWinding.congr_simp
#print axioms HadwigerNelson.CayleyThree.inheritanceQuestion_three
#print axioms HadwigerNelson.CayleyThree.l1_add_le
#print axioms HadwigerNelson.CayleyThree.l1_neg
#print axioms HadwigerNelson.CayleyThree.l1_nonneg
#print axioms HadwigerNelson.CayleyThree.l1_single_one
#print axioms HadwigerNelson.CayleyThree.l1_sub_le
#print axioms HadwigerNelson.CayleyThree.mcshane
#print axioms HadwigerNelson.CayleyThree.mcshane_add
#print axioms HadwigerNelson.CayleyThree.mcshane_eq_of_consistent
#print axioms HadwigerNelson.CayleyThree.mcshane_le
#print axioms HadwigerNelson.CayleyThree.mcshane_mem
#print axioms HadwigerNelson.CayleyThree.mcshane_model
#print axioms HadwigerNelson.CayleyThree.periodicForcedSubgroup_three_eq_forcedSubgroup
#print axioms HadwigerNelson.CayleyThree.IsTight
#print axioms HadwigerNelson.CayleyThree.abs_pmHeight_sub_le
#print axioms HadwigerNelson.CayleyThree.convex_fibre
#print axioms HadwigerNelson.CayleyThree.even_pmHeight_sub_sum
#print axioms HadwigerNelson.CayleyThree.exists_affine_of_forall_three_nsmul
#print axioms HadwigerNelson.CayleyThree.exists_le_mul_of_imp_eq_zero
#print axioms HadwigerNelson.CayleyThree.exists_mem_fibre_gt
#print axioms HadwigerNelson.CayleyThree.exists_mem_fibre_lt
#print axioms HadwigerNelson.CayleyThree.exists_mem_pi_Icc_of_forall_int
#print axioms HadwigerNelson.CayleyThree.exists_rat_mem_fibre_relint
#print axioms HadwigerNelson.CayleyThree.exists_slack_bound
#print axioms HadwigerNelson.CayleyThree.fibre
#print axioms HadwigerNelson.CayleyThree.fibre_coord_of_isTight
#print axioms HadwigerNelson.CayleyThree.fibre_nonempty
#print axioms HadwigerNelson.CayleyThree.heightWinding
#print axioms HadwigerNelson.CayleyThree.heightWinding_apply
#print axioms HadwigerNelson.CayleyThree.height_word_single
#print axioms HadwigerNelson.CayleyThree.isTight_flip_iff
#print axioms HadwigerNelson.CayleyThree.isTight_one_two
#print axioms HadwigerNelson.CayleyThree.l1
#print axioms HadwigerNelson.CayleyThree.liftHeight
#print axioms HadwigerNelson.CayleyThree.liftHeight_add_ker
#print axioms HadwigerNelson.CayleyThree.liftHeight_add_of_relMap_eq_zero
#print axioms HadwigerNelson.CayleyThree.liftHeight_add_single
#print axioms HadwigerNelson.CayleyThree.liftHeight_cast
#print axioms HadwigerNelson.CayleyThree.liftHeight_eq_of_sub
#print axioms HadwigerNelson.CayleyThree.liftHeight_of_relMap_eq_zero
#print axioms HadwigerNelson.CayleyThree.mem_fibre_flip_iff
#print axioms HadwigerNelson.CayleyThree.pmHeight
#print axioms HadwigerNelson.CayleyThree.pmHeight_add_ker
#print axioms HadwigerNelson.CayleyThree.pmHeight_add_single
#print axioms HadwigerNelson.CayleyThree.pmHeight_cast
#print axioms HadwigerNelson.CayleyThree.relMap_eq_wsum
#print axioms HadwigerNelson.CayleyThree.relMap_single
#print axioms HadwigerNelson.CayleyThree.step_eq_one_of_isTight
#print axioms HadwigerNelson.CayleyThree.step_eq_two_of_isTight
#print axioms HadwigerNelson.CayleyThree.surjective_relMap_iff
#print axioms HadwigerNelson.CayleyThree.three_dvd_liftHeight
#print axioms HadwigerNelson.CayleyThree.tightSet
#print axioms HadwigerNelson.ThreeColour.Winding.flip

/-! ## FS131-ICS1 — five colours by field and by class (`Rigidity/FourColourPlaces`, `Arith/StableAboveUsable`,
`Instances/SqrtFiveClass`, `Instances/SqrtTwentyThreeCbrtTwo`, planned by FS131-KCS1, proved by FS131-ICS1; and the ruled
`Rigidity/ClassRatio` edit, items 1027 and 1029: three lemmas made public, one added): every public record of the five
modules on the standard three or fewer, from the kernel's print (`data/fs131/ics1/axioms-all.txt`,
`data/fs131/ics1/audit_block.py`). The sixteen records on declared imports are under IMPORTED. -/

#print axioms HadwigerNelson.UpperHalf.exists_stablePrime_card_eq_sq
#print axioms HadwigerNelson.UpperHalf.localBound_le_finitePlane
#print axioms HadwigerNelson.UpperHalf.localBound_le_unitQuadrance
#print axioms HadwigerNelson.UpperHalf.nonempty_hom_levelTarget_one_unitQuadrance
#print axioms HadwigerNelson.SqrtFiveClass.colorable_five_planeOver_sqrt
#print axioms HadwigerNelson.SqrtFiveClass.exists_maximal_card_eq_of_isSquare
#print axioms HadwigerNelson.SqrtFiveClass.localBound_sqrt_le_five
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.F23
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.card_ne_sq_of_pow_eq
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.cbrtTwo
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.cbrtTwo_pow_three
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.exists_cube_two
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.exists_usablePrime_eleven_F23
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.instNumberFieldSubtypeRealMemSubfieldF23
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.isSquare_twentyThree
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.nonempty_ringHom_padic_eleven_F23
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.not_isTotallyReal_F23
#print axioms HadwigerNelson.SqrtTwentyThreeCbrtTwo.numberField_F23
#print axioms HadwigerNelson.Rigidity.chromaticNumber_le_four_dyadic
#print axioms HadwigerNelson.Rigidity.chromaticNumber_le_four_of_small
#print axioms HadwigerNelson.Rigidity.exists_card_two_pow_sq
#print axioms HadwigerNelson.Rigidity.ratioAtMost_dyadic_of_six_le
#print axioms HadwigerNelson.Rigidity.IsFourColourPlace
#print axioms HadwigerNelson.Rigidity.chromaticNumber_planeOver_le_localBoundAllLevels
#print axioms HadwigerNelson.Rigidity.colorable_four_levelTarget_one_of_isFourColourPlace
#print axioms HadwigerNelson.Rigidity.exists_isFourColourPlace_rat
#print axioms HadwigerNelson.Rigidity.five_le_chromaticNumber_levelTarget_of_ratioAtMost
#print axioms HadwigerNelson.Rigidity.localBoundAllLevels
#print axioms HadwigerNelson.Rigidity.localBoundAllLevels_le_localBound

/-! ## FS131-IFR1 — the density form of the collapse (`Collapse/Density/Defs`, `Upper`, `Headline`, `Plane/TriangularPacking`;
planned by FS131-KFR1, proved by FS131-IFR1), the ruled moves into `Collapse/Headline` and `Rigidity.ratioAtMost_of_charBound`
made public: every public record of the six modules on the standard three or fewer, from the kernel's print
(`data/fs131/ifr1/axioms-all.txt`, `tools/fs131_ifr1_audit_block.py`). The records on declared imports are under IMPORTED. -/

#print axioms HadwigerNelson.Collapse.IndepLaw.carried
#print axioms HadwigerNelson.Collapse.IndepLaw.casesOn
#print axioms HadwigerNelson.Collapse.IndepLaw.ctorIdx
#print axioms HadwigerNelson.Collapse.IndepLaw.density
#print axioms HadwigerNelson.Collapse.IndepLaw.isProb
#print axioms HadwigerNelson.Collapse.IndepLaw.mk.inj
#print axioms HadwigerNelson.Collapse.IndepLaw.mk.injEq
#print axioms HadwigerNelson.Collapse.IndepLaw.mk.noConfusion
#print axioms HadwigerNelson.Collapse.IndepLaw.mk.sizeOf_spec
#print axioms HadwigerNelson.Collapse.IndepLaw.noConfusion
#print axioms HadwigerNelson.Collapse.IndepLaw.noConfusionType
#print axioms HadwigerNelson.Collapse.IndepLaw.recOn
#print axioms HadwigerNelson.Collapse.IndepLaw.rot_inv
#print axioms HadwigerNelson.Collapse.IndepLaw.shift_inv
#print axioms HadwigerNelson.Collapse.IndepLaw.μ
#print axioms HadwigerNelson.Collapse.IndepSets
#print axioms HadwigerNelson.Collapse.SetEdgeNull
#print axioms HadwigerNelson.Collapse.card_div_le_finIndepRatio_of_hom
#print axioms HadwigerNelson.Collapse.card_div_le_stableRatio
#print axioms HadwigerNelson.Collapse.disc7_le_mOne
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_le_half
#print axioms HadwigerNelson.Collapse.half_le_stableRatio_of_isRamified
#print axioms HadwigerNelson.Collapse.isClosed_indepSets
#print axioms HadwigerNelson.Collapse.levelTarget_adj_add
#print axioms HadwigerNelson.Collapse.localRatio
#print axioms HadwigerNelson.Collapse.localRatio_le_finIndepRatio
#print axioms HadwigerNelson.Collapse.localRatio_le_iff
#print axioms HadwigerNelson.Collapse.mOne_le_finIndepRatio_planeOver
#print axioms HadwigerNelson.Collapse.mOne_le_localRatio
#print axioms HadwigerNelson.Collapse.measurableSet_indepSets
#print axioms HadwigerNelson.Collapse.nonempty_indepLaw
#print axioms HadwigerNelson.Collapse.ratioAtMost_of_stableRatio_le
#print axioms HadwigerNelson.Collapse.ratioAtMost_of_thickAt
#print axioms HadwigerNelson.Collapse.setEdgeNull_empty
#print axioms HadwigerNelson.Collapse.sixth_lt_mOne
#print axioms HadwigerNelson.Collapse.stableRatio
#print axioms HadwigerNelson.Collapse.stableRatio_le_finIndepRatio
#print axioms HadwigerNelson.Collapse.stableRatio_le_localRatio
#print axioms HadwigerNelson.Collapse.stableRatio_le_of_ratioAtMost
#print axioms HadwigerNelson.Collapse.stableRatio_le_of_thickAt
#print axioms HadwigerNelson.Collapse.stableRatio_le_one
#print axioms HadwigerNelson.Collapse.cliqueFree_three_planeOver_of_sqrt_three_notMem
#print axioms HadwigerNelson.Collapse.fractionalChromaticNumber_le_card_div
#print axioms HadwigerNelson.Collapse.inv_localRatio_lt_five
#print axioms HadwigerNelson.Collapse.le_volume_selection
#print axioms HadwigerNelson.Collapse.localRatio_eq_mOne_of_thick
#print axioms HadwigerNelson.Collapse.sqrt_three_notMem_F635087
#print axioms HadwigerNelson.Collapse.IndepLaw.density_le_finIndepRatio
#print axioms HadwigerNelson.Collapse.IndepLaw.measurePreserving_shift
#print axioms HadwigerNelson.Collapse.IsIndicatorSpectral
#print axioms HadwigerNelson.Collapse.IsIndicatorSpectral.integral_unit
#print axioms HadwigerNelson.Collapse.IsIndicatorSpectral.rotInv
#print axioms HadwigerNelson.Collapse.cayR
#print axioms HadwigerNelson.Collapse.condOne
#print axioms HadwigerNelson.Collapse.condOne.congr_simp
#print axioms HadwigerNelson.Collapse.exists_extension_one
#print axioms HadwigerNelson.Collapse.exists_indepLaw
#print axioms HadwigerNelson.Collapse.exists_isIndicatorSpectral
#print axioms HadwigerNelson.Collapse.exists_slice_set
#print axioms HadwigerNelson.Collapse.exists_window_bound
#print axioms HadwigerNelson.Collapse.factorOne
#print axioms HadwigerNelson.Collapse.finIndepRatio_planeOver_le_cayR
#print axioms HadwigerNelson.Collapse.indShift
#print axioms HadwigerNelson.Collapse.ratioLe_levR_range_of_unramified
#print axioms HadwigerNelson.Collapse.rowsEdgeNull_levelRows_set
#print axioms HadwigerNelson.Collapse.setCol
#print axioms HadwigerNelson.Collapse.setIntegral_compl_TA_re_one
#print axioms HadwigerNelson.Collapse.tendsto_measure_ne_one
#print axioms HadwigerNelson.Collapse.F7
#print axioms HadwigerNelson.Collapse.d7
#print axioms HadwigerNelson.Collapse.stablePrime_F7
#print axioms HadwigerNelson.Collapse.weil_142_lt_sixth
#print axioms HadwigerNelson.Plane.fifth_lt_mOne
#print axioms HadwigerNelson.Plane.isIndepSet_triPacking
#print axioms HadwigerNelson.Plane.linearIndependent_triLattice
#print axioms HadwigerNelson.Plane.measurableSet_triPacking
#print axioms HadwigerNelson.Plane.pi_div_le_mOne
#print axioms HadwigerNelson.Plane.triCentre
#print axioms HadwigerNelson.Plane.triCentre_sub
#print axioms HadwigerNelson.Plane.triPacking
#print axioms HadwigerNelson.Plane.triPacking_periodic
#print axioms HadwigerNelson.Plane.two_le_dist_triCentre
#print axioms HadwigerNelson.Plane.upperDensity_triPacking
#print axioms HadwigerNelson.Plane.zero_mem_triPacking
#print axioms HadwigerNelson.Rigidity.ratioAtMost_of_charBound

/-! ## FS131-IRU1 — the ring of unit vectors (`Rigidity/NormOneGen`, `UnitRingEq`, `UsablePrime`, `PlaneComponents`,
`Instances/UnitRingModels`; ledger rows 100 and 105; planner FS131-KRU1, implementer FS131-IRU1), and the three lemmas of
`Rigidity/AdmissiblePrime` made public by ruling (inventory item 1044): every public record not already filed, each on the
standard three or fewer, from the kernel's print (`data/fs131/iru1/axioms-all.txt`, `tools/fs131_iru1_audit_block.py`). -/

#print axioms HadwigerNelson.UnitRingModels.exists_stablePrime_three_not_isRamified
#print axioms HadwigerNelson.UnitRingModels.noRamifiedStableDyadic_sqrt47
#print axioms HadwigerNelson.UnitRingModels.stableIntegers_sqrt47_ne_top
#print axioms HadwigerNelson.UnitRingModels.unitRing_eq_stableIntegers_sqrt47
#print axioms HadwigerNelson.Rigidity.exists_dvd_of_dvd_exponent
#print axioms HadwigerNelson.Rigidity.exists_integral_primitive
#print axioms HadwigerNelson.Rigidity.nonempty_residueHom
#print axioms HadwigerNelson.Rigidity.cayley_mul_conj_eq_one
#print axioms HadwigerNelson.Rigidity.closure_normOne_eq_top
#print axioms HadwigerNelson.Rigidity.exists_fixed_add_mul
#print axioms HadwigerNelson.Rigidity.exists_model_galoisField
#print axioms HadwigerNelson.Rigidity.inv_mem_of_finite
#print axioms HadwigerNelson.Rigidity.mem_closure_normOne_of_fixed
#print axioms HadwigerNelson.Rigidity.connected_or_infinite_planeOver
#print axioms HadwigerNelson.Rigidity.connected_planeOver_iff_isEmpty_stablePrime
#print axioms HadwigerNelson.Rigidity.connected_planeOver_iff_subset
#print axioms HadwigerNelson.Rigidity.infinite_connectedComponent_planeOver
#print axioms HadwigerNelson.Rigidity.infinite_connectedComponent_planeOver_of_not_mem
#print axioms HadwigerNelson.Rigidity.infinite_connectedComponent_planeOver_of_stablePrime
#print axioms HadwigerNelson.Rigidity.not_connected_planeOver
#print axioms HadwigerNelson.Rigidity.reachable_add_sum
#print axioms HadwigerNelson.Rigidity.reachable_iff_sub_mem_unitRingOver
#print axioms HadwigerNelson.Rigidity.div_natCast_mem_localRing
#print axioms HadwigerNelson.Rigidity.exists_eq_add_mul_of_mem_stableIntegers
#print axioms HadwigerNelson.Rigidity.exists_two_pow_mul_mem_unitRing
#print axioms HadwigerNelson.Rigidity.isUnit_add_mk_of_conj_eq
#print axioms HadwigerNelson.Rigidity.isUnit_mk_sub_conj
#print axioms HadwigerNelson.Rigidity.natCast_notMem_pow_absNorm
#print axioms HadwigerNelson.Rigidity.normOne_subset_range_resPi
#print axioms HadwigerNelson.Rigidity.not_isRamified_of_odd_mem
#print axioms HadwigerNelson.Rigidity.resPi
#print axioms HadwigerNelson.Rigidity.resPi_apply
#print axioms HadwigerNelson.Rigidity.resPi_surjective
#print axioms HadwigerNelson.Rigidity.unitRing_eq_stableIntegers
#print axioms HadwigerNelson.Rigidity.dvd_scaleRoots_eval_sub_pow
#print axioms HadwigerNelson.Rigidity.exists_Ioo_aeval_neg
#print axioms HadwigerNelson.Rigidity.exists_dvd_eval_of_dvd_scaleRoots_eval
#print axioms HadwigerNelson.Rigidity.exists_isUsablePrime
#print axioms HadwigerNelson.Rigidity.exists_one_add_mul_div_pow_mem_Ioo
#print axioms HadwigerNelson.Rigidity.exists_prime_mod_four_eq_three_dvd
#print axioms HadwigerNelson.Rigidity.exists_prime_three_mod_four_dvd_eval
#print axioms HadwigerNelson.Rigidity.exists_stablePrime_natCast_mem
#print axioms HadwigerNelson.Rigidity.localBound_lt_top
#print axioms HadwigerNelson.Rigidity.nonempty_stablePrime
#print axioms HadwigerNelson.Rigidity.scaleRoots_eval_eq

/-! ## FS131-IRF1 — rational four-space at four colours (`RationalFour/Basic`, `Order`, `Compulsion`, `Forbid`; the
compulsion law, `[Johnson2006]` p. 212's question, the structure clause and `[KubickiLehelMorayne2002]` Thm 4.3's rigidity;
planner FS131-KFS1, implementer FS131-IRF1): every public record, each on the standard three, from the kernel's print
(`data/fs131/irf1/axioms-all.txt`, `data/fs131/irf1/audit_block.py`). -/

#print axioms HadwigerNelson.RationalFour.nonempty_iso_unitDistance
#print axioms HadwigerNelson.RationalFour.onePlusI
#print axioms HadwigerNelson.RationalFour.quatGraph
#print axioms HadwigerNelson.RationalFour.quatGraph_adj
#print axioms HadwigerNelson.RationalFour.quatIso
#print axioms HadwigerNelson.RationalFour.ratFourGraph
#print axioms HadwigerNelson.RationalFour.ratFourGraph_adj
#print axioms HadwigerNelson.RationalFour.ratPoints
#print axioms HadwigerNelson.RationalFour.sqDist
#print axioms HadwigerNelson.RationalFour.sqDist4
#print axioms HadwigerNelson.RationalFour.sqDist4_comm
#print axioms HadwigerNelson.RationalFour.sqDist_comm
#print axioms HadwigerNelson.RationalFour.sqDist_self
#print axioms HadwigerNelson.RationalFour.sqDist_toQuat
#print axioms HadwigerNelson.RationalFour.toQuat
#print axioms HadwigerNelson.RationalFour.unitSphere
#print axioms HadwigerNelson.RationalFour.val
#print axioms HadwigerNelson.RationalFour.coloring_eq_of_eqOn_isOpen
#print axioms HadwigerNelson.RationalFour.coloring_eq_of_forall_tetra
#print axioms HadwigerNelson.RationalFour.coloring_eq_of_mem_pr
#print axioms HadwigerNelson.RationalFour.coloring_eq_of_one_le_padicValRat
#print axioms HadwigerNelson.RationalFour.coloring_eq_of_sqDist_two
#print axioms HadwigerNelson.RationalFour.coloring_ne_of_mem_comp_of_notMem_pr
#print axioms HadwigerNelson.RationalFour.coloring_ne_of_padicValRat_eq_zero
#print axioms HadwigerNelson.RationalFour.exists_coloring_eq_and_ne_iff
#print axioms HadwigerNelson.RationalFour.exists_equiv_coloring_add_eq_residue
#print axioms HadwigerNelson.RationalFour.exists_quatColoring_eq_and_ne_iff
#print axioms HadwigerNelson.RationalFour.exists_residueCol_eq_and_ne
#print axioms HadwigerNelson.RationalFour.forall_coloring_eq_iff
#print axioms HadwigerNelson.RationalFour.forall_coloring_ne_iff
#print axioms HadwigerNelson.RationalFour.forall_quatColoring_eq_iff
#print axioms HadwigerNelson.RationalFour.forall_quatColoring_ne_iff
#print axioms HadwigerNelson.RationalFour.nonempty_coloring
#print axioms HadwigerNelson.RationalFour.nonempty_ratFourGraph_coloring
#print axioms HadwigerNelson.RationalFour.residue
#print axioms HadwigerNelson.RationalFour.residueCol
#print axioms HadwigerNelson.RationalFour.residueCol_eq_imp
#print axioms HadwigerNelson.RationalFour.residueCol_ne_of_adj
#print axioms HadwigerNelson.RationalFour.residueColouring
#print axioms HadwigerNelson.RationalFour.coloring_forbids_of_odd
#print axioms HadwigerNelson.RationalFour.exists_coloring_forbidding_iff
#print axioms HadwigerNelson.RationalFour.exists_coloring_forbidding_iff_padicValRat
#print axioms HadwigerNelson.RationalFour.exists_sqDist4_eq
#print axioms HadwigerNelson.RationalFour.padicValRat_eq_zero_iff_odd
#print axioms HadwigerNelson.RationalFour.comp
#print axioms HadwigerNelson.RationalFour.existsUnique_tetra_sub_mem_pr
#print axioms HadwigerNelson.RationalFour.hur
#print axioms HadwigerNelson.RationalFour.hur'
#print axioms HadwigerNelson.RationalFour.inv_odd_mem_comp
#print axioms HadwigerNelson.RationalFour.inv_prime_mem_comp
#print axioms HadwigerNelson.RationalFour.mem_comp_iff
#print axioms HadwigerNelson.RationalFour.mem_pr_iff
#print axioms HadwigerNelson.RationalFour.mul_mem_comp
#print axioms HadwigerNelson.RationalFour.one_le_val_div_odd
#print axioms HadwigerNelson.RationalFour.ord
#print axioms HadwigerNelson.RationalFour.pr
#print axioms HadwigerNelson.RationalFour.pr_le_comp
#print axioms HadwigerNelson.RationalFour.sqDist_tetra
#print axioms HadwigerNelson.RationalFour.tetra
#print axioms HadwigerNelson.RationalFour.unitSphere_subset_comp
#print axioms HadwigerNelson.RationalFour.zero_le_val_add
#print axioms HadwigerNelson.RationalFour.zero_le_val_iff
#print axioms HadwigerNelson.RationalFour.zero_le_val_neg

/-! ## FS131-ISF1 — the fractional chromatic number over ℚ(√3, √11) (`Instances/SeamFractional` and the 51 `Plane/G27/`
modules: `χ_f(ℚ(√3, √11)²) = 4`, `[MatolcsiEtAl2025]`'s certificate for `G27` checked by the kernel; planner FS131-KFS1 Part B,
implementer FS131-ISF1, gated by FS131-ISF2): every public record, each on the standard three or fewer, from the kernel's
print (`data/fs131/isf2/axioms-all.txt`, `tools/fs131_isf2_audit_block.py`). -/

#print axioms HadwigerNelson.Instances.SeamFractional.IndepLaw.density_le_quarter_seamField
#print axioms HadwigerNelson.Instances.SeamFractional.finIndepRatio_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.finIndepRatio_seamPlane_le
#print axioms HadwigerNelson.Instances.SeamFractional.fractionalChromaticNumber_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.iSup_fractionalChromaticNumber_seamPlane
#print axioms HadwigerNelson.Instances.SeamFractional.instNumberFieldSubtypeRealMemSubfieldSeamField
#print axioms HadwigerNelson.Instances.SeamFractional.numberField_seamField
#print axioms HadwigerNelson.G27.SegsOk.eq_def
#print axioms HadwigerNelson.G27.good000
#print axioms HadwigerNelson.G27.good001
#print axioms HadwigerNelson.G27.good002
#print axioms HadwigerNelson.G27.good003
#print axioms HadwigerNelson.G27.good004
#print axioms HadwigerNelson.G27.good005
#print axioms HadwigerNelson.G27.good_root
#print axioms HadwigerNelson.G27.root_sorted
#print axioms HadwigerNelson.G27.segC
#print axioms HadwigerNelson.G27.segR
#print axioms HadwigerNelson.G27.segS
#print axioms HadwigerNelson.G27.segs_ok
#print axioms HadwigerNelson.G27.cert_bound
#print axioms HadwigerNelson.G27.coefsAll
#print axioms HadwigerNelson.G27.density_le_quarter
#print axioms HadwigerNelson.G27.rowsAll
#print axioms HadwigerNelson.G27.rowsAll_fit
#print axioms HadwigerNelson.G27.rowsAll_ok
#print axioms HadwigerNelson.G27.val_expand_eq_root
#print axioms HadwigerNelson.G27.FUEL
#print axioms HadwigerNelson.G27.M27
#print axioms HadwigerNelson.G27.OFFC
#print axioms HadwigerNelson.G27.adjOk
#print axioms HadwigerNelson.G27.cf
#print axioms HadwigerNelson.G27.collectR
#print axioms HadwigerNelson.G27.cpkOk
#print axioms HadwigerNelson.G27.dfsR
#print axioms HadwigerNelson.G27.eqL
#print axioms HadwigerNelson.G27.eqLL
#print axioms HadwigerNelson.G27.expand
#print axioms HadwigerNelson.G27.goodB
#print axioms HadwigerNelson.G27.keepIn
#print axioms HadwigerNelson.G27.key
#print axioms HadwigerNelson.G27.leafOk
#print axioms HadwigerNelson.G27.mergePairs
#print axioms HadwigerNelson.G27.mergeR
#print axioms HadwigerNelson.G27.pathFrom
#print axioms HadwigerNelson.G27.pathsOk
#print axioms HadwigerNelson.G27.rowTerms
#print axioms HadwigerNelson.G27.rowsFit
#print axioms HadwigerNelson.G27.rowsTerms
#print axioms HadwigerNelson.G27.shiftIn
#print axioms HadwigerNelson.G27.singSumOk
#print axioms HadwigerNelson.G27.singTerms
#print axioms HadwigerNelson.G27.sortR
#print axioms HadwigerNelson.G27.sortRounds
#print axioms HadwigerNelson.G27.splitOk
#print axioms HadwigerNelson.G27.stateL
#print axioms HadwigerNelson.G27.stepIn
#print axioms HadwigerNelson.G27.stepOut
#print axioms HadwigerNelson.G27.val
#print axioms HadwigerNelson.G27.val0
#print axioms HadwigerNelson.G27.wfB
#print axioms HadwigerNelson.G27.gp000x02_ok
#print axioms HadwigerNelson.G27.gp000x03_ok
#print axioms HadwigerNelson.G27.gp000x05_ok
#print axioms HadwigerNelson.G27.gp000x07_ok
#print axioms HadwigerNelson.G27.gp001x01_ok
#print axioms HadwigerNelson.G27.gp001x02_ok
#print axioms HadwigerNelson.G27.sp000_ok
#print axioms HadwigerNelson.G27.gp001x03_ok
#print axioms HadwigerNelson.G27.gp001x04_ok
#print axioms HadwigerNelson.G27.gp001x05_ok
#print axioms HadwigerNelson.G27.gp001x06_ok
#print axioms HadwigerNelson.G27.gp001x07_ok
#print axioms HadwigerNelson.G27.gp001x08_ok
#print axioms HadwigerNelson.G27.gp001x09_ok
#print axioms HadwigerNelson.G27.gp001x10_ok
#print axioms HadwigerNelson.G27.sp001_ok
#print axioms HadwigerNelson.G27.gp002x00_ok
#print axioms HadwigerNelson.G27.gp002x01_ok
#print axioms HadwigerNelson.G27.gp003x00_ok
#print axioms HadwigerNelson.G27.gp003x01_ok
#print axioms HadwigerNelson.G27.sp002_ok
#print axioms HadwigerNelson.G27.gp004x00_ok
#print axioms HadwigerNelson.G27.gp004x01_ok
#print axioms HadwigerNelson.G27.sp003_ok
#print axioms HadwigerNelson.G27.sp004_ok
#print axioms HadwigerNelson.G27.gp005x00_ok
#print axioms HadwigerNelson.G27.gp005x01_ok
#print axioms HadwigerNelson.G27.sp005_ok
#print axioms HadwigerNelson.G27.Dn
#print axioms HadwigerNelson.G27.Dn_pos
#print axioms HadwigerNelson.G27.adjL
#print axioms HadwigerNelson.G27.adj_ok
#print axioms HadwigerNelson.G27.origin_ok
#print axioms HadwigerNelson.G27.pathsL
#print axioms HadwigerNelson.G27.paths_ok
#print axioms HadwigerNelson.G27.ptsL
#print axioms HadwigerNelson.G27.singL
#print axioms HadwigerNelson.G27.sing_ok
#print axioms HadwigerNelson.G27.wf_ok
#print axioms HadwigerNelson.G27.adjL_length
#print axioms HadwigerNelson.G27.adj_bit
#print axioms HadwigerNelson.G27.allIn
#print axioms HadwigerNelson.G27.allIn_congr
#print axioms HadwigerNelson.G27.c4_eq_of_beq
#print axioms HadwigerNelson.G27.cf_add_mul
#print axioms HadwigerNelson.G27.coe_conjR
#print axioms HadwigerNelson.G27.coe_xR
#print axioms HadwigerNelson.G27.conjR
#print axioms HadwigerNelson.G27.conjR_affine
#print axioms HadwigerNelson.G27.conjR_conjR
#print axioms HadwigerNelson.G27.conj_indep
#print axioms HadwigerNelson.G27.conj_mem_unitRing
#print axioms HadwigerNelson.G27.density_le_of_cert
#print axioms HadwigerNelson.G27.div12_mem
#print axioms HadwigerNelson.G27.ev
#print axioms HadwigerNelson.G27.ev_add
#print axioms HadwigerNelson.G27.ev_mem
#print axioms HadwigerNelson.G27.ev_mul
#print axioms HadwigerNelson.G27.ev_neg
#print axioms HadwigerNelson.G27.ev_ofInt
#print axioms HadwigerNelson.G27.ev_smul
#print axioms HadwigerNelson.G27.ev_sub
#print axioms HadwigerNelson.G27.expect_le
#print axioms HadwigerNelson.G27.indepFrom_mk
#print axioms HadwigerNelson.G27.indepFrom_of_getD
#print axioms HadwigerNelson.G27.indicator_allIn_conj
#print axioms HadwigerNelson.G27.integral_terms
#print axioms HadwigerNelson.G27.map_xR_of_forall₂
#print axioms HadwigerNelson.G27.maskL_lt
#print axioms HadwigerNelson.G27.measurableSet_allIn
#print axioms HadwigerNelson.G27.measure_allIn_affine
#print axioms HadwigerNelson.G27.mem_allIn_map_conj
#print axioms HadwigerNelson.G27.mem_allIn_ptsOf
#print axioms HadwigerNelson.G27.mem_ptsOf
#print axioms HadwigerNelson.G27.mk
#print axioms HadwigerNelson.G27.mk_lt
#print axioms HadwigerNelson.G27.normSq_toC
#print axioms HadwigerNelson.G27.pathFrom.eq_def
#print axioms HadwigerNelson.G27.phi
#print axioms HadwigerNelson.G27.phi_affine
#print axioms HadwigerNelson.G27.phi_congr
#print axioms HadwigerNelson.G27.phi_conj
#print axioms HadwigerNelson.G27.phi_point
#print axioms HadwigerNelson.G27.phi_zero
#print axioms HadwigerNelson.G27.ptsOf
#print axioms HadwigerNelson.G27.ptsOf_mask
#print axioms HadwigerNelson.G27.q4_eq_of_beq
#print axioms HadwigerNelson.G27.row_corr
#print axioms HadwigerNelson.G27.row_phi
#print axioms HadwigerNelson.G27.rowsTerms_phi
#print axioms HadwigerNelson.G27.singTerms.eq_def
#print axioms HadwigerNelson.G27.singTerms_phi
#print axioms HadwigerNelson.G27.testBit_maskL
#print axioms HadwigerNelson.G27.testBit_mk
#print axioms HadwigerNelson.G27.toC
#print axioms HadwigerNelson.G27.toC_add
#print axioms HadwigerNelson.G27.toC_cond
#print axioms HadwigerNelson.G27.toC_mem
#print axioms HadwigerNelson.G27.toC_mul
#print axioms HadwigerNelson.G27.toC_smul
#print axioms HadwigerNelson.G27.toC_sub
#print axioms HadwigerNelson.G27.tv_mk
#print axioms HadwigerNelson.G27.uConj
#print axioms HadwigerNelson.G27.uOne
#print axioms HadwigerNelson.G27.unit_of_sqd
#print axioms HadwigerNelson.G27.val_mk
#print axioms HadwigerNelson.G27.xR
#print axioms HadwigerNelson.G27.xpt
#print axioms HadwigerNelson.G27.xpt_mem
#print axioms HadwigerNelson.G27.xpt_mem_of_path
#print axioms HadwigerNelson.G27.xpt_plane
#print axioms HadwigerNelson.G27.xpt_zero
#print axioms HadwigerNelson.G27.rootL
#print axioms HadwigerNelson.G27.rootL0
#print axioms HadwigerNelson.G27.rootL1
#print axioms HadwigerNelson.G27.rootL2
#print axioms HadwigerNelson.G27.rootL3
#print axioms HadwigerNelson.G27.rootSt
#print axioms HadwigerNelson.G27.root_ok
#print axioms HadwigerNelson.G27.coefs00
#print axioms HadwigerNelson.G27.rows00
#print axioms HadwigerNelson.G27.rows00_fit
#print axioms HadwigerNelson.G27.rows00_ok0
#print axioms HadwigerNelson.G27.rows00_ok1
#print axioms HadwigerNelson.G27.rows00_sort
#print axioms HadwigerNelson.G27.sorted00
#print axioms HadwigerNelson.G27.coefs01
#print axioms HadwigerNelson.G27.rows01
#print axioms HadwigerNelson.G27.rows01_fit
#print axioms HadwigerNelson.G27.rows01_ok0
#print axioms HadwigerNelson.G27.rows01_ok1
#print axioms HadwigerNelson.G27.rows01_sort
#print axioms HadwigerNelson.G27.sorted01
#print axioms HadwigerNelson.G27.coefs02
#print axioms HadwigerNelson.G27.rows02
#print axioms HadwigerNelson.G27.rows02_fit
#print axioms HadwigerNelson.G27.rows02_ok0
#print axioms HadwigerNelson.G27.rows02_ok1
#print axioms HadwigerNelson.G27.rows02_sort
#print axioms HadwigerNelson.G27.sorted02
#print axioms HadwigerNelson.G27.coefs03
#print axioms HadwigerNelson.G27.rows03
#print axioms HadwigerNelson.G27.rows03_fit
#print axioms HadwigerNelson.G27.rows03_ok0
#print axioms HadwigerNelson.G27.rows03_ok1
#print axioms HadwigerNelson.G27.rows03_sort
#print axioms HadwigerNelson.G27.sorted03
#print axioms HadwigerNelson.G27.coefs04
#print axioms HadwigerNelson.G27.rows04
#print axioms HadwigerNelson.G27.rows04_fit
#print axioms HadwigerNelson.G27.rows04_ok0
#print axioms HadwigerNelson.G27.rows04_ok1
#print axioms HadwigerNelson.G27.rows04_sort
#print axioms HadwigerNelson.G27.sorted04
#print axioms HadwigerNelson.G27.coefs05
#print axioms HadwigerNelson.G27.rows05
#print axioms HadwigerNelson.G27.rows05_fit
#print axioms HadwigerNelson.G27.rows05_ok0
#print axioms HadwigerNelson.G27.rows05_ok1
#print axioms HadwigerNelson.G27.rows05_sort
#print axioms HadwigerNelson.G27.sorted05
#print axioms HadwigerNelson.G27.coefs06
#print axioms HadwigerNelson.G27.rows06
#print axioms HadwigerNelson.G27.rows06_fit
#print axioms HadwigerNelson.G27.rows06_ok0
#print axioms HadwigerNelson.G27.rows06_ok1
#print axioms HadwigerNelson.G27.rows06_sort
#print axioms HadwigerNelson.G27.sorted06
#print axioms HadwigerNelson.G27.coefs07
#print axioms HadwigerNelson.G27.rows07
#print axioms HadwigerNelson.G27.rows07_fit
#print axioms HadwigerNelson.G27.rows07_ok0
#print axioms HadwigerNelson.G27.rows07_ok1
#print axioms HadwigerNelson.G27.rows07_sort
#print axioms HadwigerNelson.G27.sorted07
#print axioms HadwigerNelson.G27.coefs08
#print axioms HadwigerNelson.G27.rows08
#print axioms HadwigerNelson.G27.rows08_fit
#print axioms HadwigerNelson.G27.rows08_ok0
#print axioms HadwigerNelson.G27.rows08_ok1
#print axioms HadwigerNelson.G27.rows08_sort
#print axioms HadwigerNelson.G27.sorted08
#print axioms HadwigerNelson.G27.coefs09
#print axioms HadwigerNelson.G27.rows09
#print axioms HadwigerNelson.G27.rows09_fit
#print axioms HadwigerNelson.G27.rows09_ok0
#print axioms HadwigerNelson.G27.rows09_ok1
#print axioms HadwigerNelson.G27.rows09_sort
#print axioms HadwigerNelson.G27.sorted09
#print axioms HadwigerNelson.G27.coefs10
#print axioms HadwigerNelson.G27.rows10
#print axioms HadwigerNelson.G27.rows10_fit
#print axioms HadwigerNelson.G27.rows10_ok0
#print axioms HadwigerNelson.G27.rows10_ok1
#print axioms HadwigerNelson.G27.rows10_sort
#print axioms HadwigerNelson.G27.sorted10
#print axioms HadwigerNelson.G27.coefs11
#print axioms HadwigerNelson.G27.rows11
#print axioms HadwigerNelson.G27.rows11_fit
#print axioms HadwigerNelson.G27.rows11_ok0
#print axioms HadwigerNelson.G27.rows11_ok1
#print axioms HadwigerNelson.G27.rows11_sort
#print axioms HadwigerNelson.G27.sorted11
#print axioms HadwigerNelson.G27.coefs12
#print axioms HadwigerNelson.G27.rows12
#print axioms HadwigerNelson.G27.rows12_fit
#print axioms HadwigerNelson.G27.rows12_ok0
#print axioms HadwigerNelson.G27.rows12_ok1
#print axioms HadwigerNelson.G27.rows12_sort
#print axioms HadwigerNelson.G27.sorted12
#print axioms HadwigerNelson.G27.coefs13
#print axioms HadwigerNelson.G27.rows13
#print axioms HadwigerNelson.G27.rows13_fit
#print axioms HadwigerNelson.G27.rows13_ok0
#print axioms HadwigerNelson.G27.rows13_ok1
#print axioms HadwigerNelson.G27.rows13_sort
#print axioms HadwigerNelson.G27.sorted13
#print axioms HadwigerNelson.G27.coefs14
#print axioms HadwigerNelson.G27.rows14
#print axioms HadwigerNelson.G27.rows14_fit
#print axioms HadwigerNelson.G27.rows14_ok0
#print axioms HadwigerNelson.G27.rows14_ok1
#print axioms HadwigerNelson.G27.rows14_sort
#print axioms HadwigerNelson.G27.sorted14
#print axioms HadwigerNelson.G27.coefs15
#print axioms HadwigerNelson.G27.rows15
#print axioms HadwigerNelson.G27.rows15_fit
#print axioms HadwigerNelson.G27.rows15_ok0
#print axioms HadwigerNelson.G27.rows15_ok1
#print axioms HadwigerNelson.G27.rows15_sort
#print axioms HadwigerNelson.G27.sorted15
#print axioms HadwigerNelson.G27.coefs16
#print axioms HadwigerNelson.G27.rows16
#print axioms HadwigerNelson.G27.rows16_fit
#print axioms HadwigerNelson.G27.rows16_ok0
#print axioms HadwigerNelson.G27.rows16_ok1
#print axioms HadwigerNelson.G27.rows16_sort
#print axioms HadwigerNelson.G27.sorted16
#print axioms HadwigerNelson.G27.coefs17
#print axioms HadwigerNelson.G27.rows17
#print axioms HadwigerNelson.G27.rows17_fit
#print axioms HadwigerNelson.G27.rows17_ok0
#print axioms HadwigerNelson.G27.rows17_ok1
#print axioms HadwigerNelson.G27.rows17_sort
#print axioms HadwigerNelson.G27.sorted17
#print axioms HadwigerNelson.G27.coefs18
#print axioms HadwigerNelson.G27.rows18
#print axioms HadwigerNelson.G27.rows18_fit
#print axioms HadwigerNelson.G27.rows18_ok0
#print axioms HadwigerNelson.G27.rows18_ok1
#print axioms HadwigerNelson.G27.rows18_sort
#print axioms HadwigerNelson.G27.sorted18
#print axioms HadwigerNelson.G27.coefs19
#print axioms HadwigerNelson.G27.rows19
#print axioms HadwigerNelson.G27.rows19_fit
#print axioms HadwigerNelson.G27.rows19_ok0
#print axioms HadwigerNelson.G27.rows19_ok1
#print axioms HadwigerNelson.G27.rows19_sort
#print axioms HadwigerNelson.G27.sorted19
#print axioms HadwigerNelson.G27.coefs20
#print axioms HadwigerNelson.G27.rows20
#print axioms HadwigerNelson.G27.rows20_fit
#print axioms HadwigerNelson.G27.rows20_ok0
#print axioms HadwigerNelson.G27.rows20_ok1
#print axioms HadwigerNelson.G27.rows20_sort
#print axioms HadwigerNelson.G27.sorted20
#print axioms HadwigerNelson.G27.coefs21
#print axioms HadwigerNelson.G27.rows21
#print axioms HadwigerNelson.G27.rows21_fit
#print axioms HadwigerNelson.G27.rows21_ok0
#print axioms HadwigerNelson.G27.rows21_ok1
#print axioms HadwigerNelson.G27.rows21_sort
#print axioms HadwigerNelson.G27.sorted21
#print axioms HadwigerNelson.G27.coefs22
#print axioms HadwigerNelson.G27.rows22
#print axioms HadwigerNelson.G27.rows22_fit
#print axioms HadwigerNelson.G27.rows22_ok0
#print axioms HadwigerNelson.G27.rows22_ok1
#print axioms HadwigerNelson.G27.rows22_sort
#print axioms HadwigerNelson.G27.sorted22
#print axioms HadwigerNelson.G27.coefs23
#print axioms HadwigerNelson.G27.rows23
#print axioms HadwigerNelson.G27.rows23_fit
#print axioms HadwigerNelson.G27.rows23_ok0
#print axioms HadwigerNelson.G27.rows23_ok1
#print axioms HadwigerNelson.G27.rows23_sort
#print axioms HadwigerNelson.G27.sorted23
#print axioms HadwigerNelson.G27.coefs24
#print axioms HadwigerNelson.G27.rows24
#print axioms HadwigerNelson.G27.rows24_fit
#print axioms HadwigerNelson.G27.rows24_ok0
#print axioms HadwigerNelson.G27.rows24_ok1
#print axioms HadwigerNelson.G27.rows24_sort
#print axioms HadwigerNelson.G27.sorted24
#print axioms HadwigerNelson.G27.coefs25
#print axioms HadwigerNelson.G27.rows25
#print axioms HadwigerNelson.G27.rows25_fit
#print axioms HadwigerNelson.G27.rows25_ok0
#print axioms HadwigerNelson.G27.rows25_ok1
#print axioms HadwigerNelson.G27.rows25_sort
#print axioms HadwigerNelson.G27.sorted25
#print axioms HadwigerNelson.G27.coefs26
#print axioms HadwigerNelson.G27.rows26
#print axioms HadwigerNelson.G27.rows26_fit
#print axioms HadwigerNelson.G27.rows26_ok0
#print axioms HadwigerNelson.G27.rows26_ok1
#print axioms HadwigerNelson.G27.rows26_sort
#print axioms HadwigerNelson.G27.sorted26
#print axioms HadwigerNelson.G27.coefs27
#print axioms HadwigerNelson.G27.rows27
#print axioms HadwigerNelson.G27.rows27_fit
#print axioms HadwigerNelson.G27.rows27_ok0
#print axioms HadwigerNelson.G27.rows27_ok1
#print axioms HadwigerNelson.G27.rows27_sort
#print axioms HadwigerNelson.G27.sorted27
#print axioms HadwigerNelson.G27.coefs28
#print axioms HadwigerNelson.G27.rows28
#print axioms HadwigerNelson.G27.rows28_fit
#print axioms HadwigerNelson.G27.rows28_ok0
#print axioms HadwigerNelson.G27.rows28_ok1
#print axioms HadwigerNelson.G27.rows28_sort
#print axioms HadwigerNelson.G27.sorted28
#print axioms HadwigerNelson.G27.IndepFrom
#print axioms HadwigerNelson.G27.M27_eq
#print axioms HadwigerNelson.G27.SegsOk
#print axioms HadwigerNelson.G27.WfAdj
#print axioms HadwigerNelson.G27.all_append_true
#print axioms HadwigerNelson.G27.all_singleton_true
#print axioms HadwigerNelson.G27.beq_land_false
#print axioms HadwigerNelson.G27.beq_land_true
#print axioms HadwigerNelson.G27.collectR_cons
#print axioms HadwigerNelson.G27.collectR_nil
#print axioms HadwigerNelson.G27.dfsR_append
#print axioms HadwigerNelson.G27.dfsR_cons
#print axioms HadwigerNelson.G27.dfsR_eq_all
#print axioms HadwigerNelson.G27.dfsR_nil
#print axioms HadwigerNelson.G27.dfsR_sound
#print axioms HadwigerNelson.G27.div_add_mul
#print axioms HadwigerNelson.G27.div_xor
#print axioms HadwigerNelson.G27.eqL.eq_def
#print axioms HadwigerNelson.G27.eqLL.eq_def
#print axioms HadwigerNelson.G27.eqLL_eq
#print axioms HadwigerNelson.G27.eqL_eq
#print axioms HadwigerNelson.G27.goodB_of_split
#print axioms HadwigerNelson.G27.goodB_root
#print axioms HadwigerNelson.G27.keepIn_cons
#print axioms HadwigerNelson.G27.key_add_mul
#print axioms HadwigerNelson.G27.key_xor
#print axioms HadwigerNelson.G27.land_eq_zero_iff
#print axioms HadwigerNelson.G27.land_key
#print axioms HadwigerNelson.G27.land_self_iff
#print axioms HadwigerNelson.G27.land_two_pow_eq_zero
#print axioms HadwigerNelson.G27.mergePairs.eq_def
#print axioms HadwigerNelson.G27.mergeR_succ_cons_cons
#print axioms HadwigerNelson.G27.mergeR_succ_cons_nil
#print axioms HadwigerNelson.G27.mergeR_succ_nil
#print axioms HadwigerNelson.G27.mergeR_zero
#print axioms HadwigerNelson.G27.or_eq_zero_iff'
#print axioms HadwigerNelson.G27.rowsFit.eq_def
#print axioms HadwigerNelson.G27.rowsFit_append
#print axioms HadwigerNelson.G27.rowsFit_length
#print axioms HadwigerNelson.G27.rowsTerms.eq_def
#print axioms HadwigerNelson.G27.rowsTerms_append
#print axioms HadwigerNelson.G27.segsOk_spec
#print axioms HadwigerNelson.G27.shiftIn_cons
#print axioms HadwigerNelson.G27.sortRounds.eq_def
#print axioms HadwigerNelson.G27.stepOut_cons
#print axioms HadwigerNelson.G27.stepOut_nil
#print axioms HadwigerNelson.G27.sum_val_mergePairs
#print axioms HadwigerNelson.G27.testBit_key
#print axioms HadwigerNelson.G27.testBit_of_land_two_pow
#print axioms HadwigerNelson.G27.testBit_of_lt_M27
#print axioms HadwigerNelson.G27.tv
#print axioms HadwigerNelson.G27.tv_combine
#print axioms HadwigerNelson.G27.tv_eq_zero_of_land
#print axioms HadwigerNelson.G27.tv_of_key_eq
#print axioms HadwigerNelson.G27.tv_zero
#print axioms HadwigerNelson.G27.two_pow_lt_M27
#print axioms HadwigerNelson.G27.val0_eq
#print axioms HadwigerNelson.G27.val_append
#print axioms HadwigerNelson.G27.val_cons
#print axioms HadwigerNelson.G27.val_flatten
#print axioms HadwigerNelson.G27.val_mergeR
#print axioms HadwigerNelson.G27.val_nil
#print axioms HadwigerNelson.G27.val_shift_keep
#print axioms HadwigerNelson.G27.val_sortR
#print axioms HadwigerNelson.G27.val_sortRounds
#print axioms HadwigerNelson.G27.val_stepIn
#print axioms HadwigerNelson.G27.val_stepOut
#print axioms HadwigerNelson.G27.wfAdj_of_wfB
#print axioms HadwigerNelson.G27.wfB.eq_def
#print axioms HadwigerNelson.G27.gp000x02
#print axioms HadwigerNelson.G27.gp000x03
#print axioms HadwigerNelson.G27.gp000x05
#print axioms HadwigerNelson.G27.gp000x07
#print axioms HadwigerNelson.G27.out000
#print axioms HadwigerNelson.G27.st001
#print axioms HadwigerNelson.G27.st003
#print axioms HadwigerNelson.G27.st004
#print axioms HadwigerNelson.G27.st005
#print axioms HadwigerNelson.G27.gp001x01
#print axioms HadwigerNelson.G27.gp001x02
#print axioms HadwigerNelson.G27.gp001x03
#print axioms HadwigerNelson.G27.gp001x04
#print axioms HadwigerNelson.G27.gp001x05
#print axioms HadwigerNelson.G27.gp001x06
#print axioms HadwigerNelson.G27.gp001x07
#print axioms HadwigerNelson.G27.gp001x08
#print axioms HadwigerNelson.G27.gp001x09
#print axioms HadwigerNelson.G27.gp001x10
#print axioms HadwigerNelson.G27.out001
#print axioms HadwigerNelson.G27.st002
#print axioms HadwigerNelson.G27.gp002x00
#print axioms HadwigerNelson.G27.gp002x01
#print axioms HadwigerNelson.G27.out002
#print axioms HadwigerNelson.G27.gp003x00
#print axioms HadwigerNelson.G27.gp003x01
#print axioms HadwigerNelson.G27.out003
#print axioms HadwigerNelson.G27.gp004x00
#print axioms HadwigerNelson.G27.gp004x01
#print axioms HadwigerNelson.G27.out004
#print axioms HadwigerNelson.G27.gp005x00
#print axioms HadwigerNelson.G27.gp005x01
#print axioms HadwigerNelson.G27.out005

#eval IO.println "=== PURCHASED ==="

/-! ## M03 — the certificate routes

Each of these evaluates `LRAT.check` by `native_decide`, which is the only thing that can evaluate
it (see `Sat/Lrat.lean`). The bound they reach is the same one `four_le_chromaticNumber_plane`
reaches above without them — which is the point of proving it twice. -/

#print axioms moserSpindle_cnf_unsat
#print axioms moserSpindle_not_colorable_three_lrat
#print axioms moserSpindleCubes_unsat
#print axioms moserSpindle_not_colorable_three_cubes
#print axioms four_le_chromaticNumber_plane_certified

#eval AxiomAudit.libraryAxioms
