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
not (`undeclared-library-axiom`, from `libraryAxioms`, the file's last command). `main` declares no
import yet, so this section is empty there.

**Why this section comes first.** The gate reads the sections in any order, but two things do not move:
PURCHASED stays last, because `tools/check_architecture.py` reads every `#print axioms` after its banner
as a purchase; and the waves append their CLEAN records just above the PURCHASED banner, so a section
placed there would meet every landing's merge in the same lines.

**How a wave declares an import, at its landing** (written for wave 2's `falconer_lemma2_nonempty`; the
same for any later one): (1) check the four items of `LEAN.md` § Assumptions are done — the docstring
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
#print axioms HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_eq_five_of_chain

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
#print axioms HadwigerNelson.Plane.sq_norm_re_im
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

/-! ## FS-131 wave 4 (job FS131-K4b) — the base's steps with unit arcs and the bowtie fragment (sorry until wave 4's implementer lands it) -/

#print axioms HadwigerNelson.Plane.const_univ_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.pair_i
#print axioms HadwigerNelson.Plane.ArcMap.pair_ii
#print axioms HadwigerNelson.Plane.ArcMap.pair_P'
#print axioms HadwigerNelson.Plane.ArcMap.fail_leavingCentre
#print axioms HadwigerNelson.Plane.ArcMap.fail_colours
#print axioms HadwigerNelson.Plane.ArcMap.anti
#print axioms HadwigerNelson.Plane.ArcMap.n3_end
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
#print axioms HadwigerNelson.Plane.ArcMap.bend_away
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
#print axioms HadwigerNelson.Plane.ArcMap.sq_norm_eq_re_im
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
#print axioms HadwigerNelson.Plane.frameX_framePt
#print axioms HadwigerNelson.Plane.frameY_framePt
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
#print axioms HadwigerNelson.Plane.ArcMap.dist_sq_re_im
#print axioms HadwigerNelson.Plane.ArcMap.antipodal_neg
#print axioms HadwigerNelson.Plane.ArcMap.exists_near_far_antipodal
#print axioms HadwigerNelson.Plane.ArcMap.not_mem_coloursAt_of_tile_dist
#print axioms HadwigerNelson.Plane.ArcMap.IsTile.exists_dist_eq_one
#print axioms HadwigerNelson.Plane.ArcMap.germPseudo_unique

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
