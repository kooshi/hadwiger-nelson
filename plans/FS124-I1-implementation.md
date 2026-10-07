# FS-124 — the radius clause in the kernel: the implementation (job FS124-I1)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I1-radius.md` (on `main`). The planner's record:
`plans/FS124-kernel-plan.md`. Claim list: `data/fs124/claims-K1.md`. Branch `fs124-wk1`, taken at `28a82429`. Working
files: `data/fs124/i1/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

On branch `fs124-wk1` (nothing here is on `main`): the 57 theorems of the three modules of the radius clause, with no `sorry`.
49 are this job's; eight were proved by the planner (marked), one of which, `AeProperOn.ae_rigidMotion_edge`, waited on a
leaf of this job and is a theorem only now. Each line is read from the build's own print (`data/fs124/i1/axioms-print.txt`,
checked by `data/fs124/i1/axioms_check.py`, Stage 2): "the standard three" is `[propext, Classical.choice, Quot.sound]`.
The five claims: C124-RADIUS-GRAPH is `radius_graph`, -COUNTABLE `radius_countable`, -UP `radius_up`, -DOWN `radius_down`,
-FIVE `radius_five`; the join is `colorable_iff_forall_ball` and `seven_le_chromaticNumber_plane_iff_exists_ball`.

**`Plane/WeakColouringOn`** (`Proofs/HadwigerNelson/Plane/WeakColouringOn.lean`; 33 theorems, 27 proved by this job):

- `rigidMotion_apply_zero` — [kernel]; axioms: the standard three
- `rigidMotion_apply_one` — [kernel]; axioms: the standard three
- `rigidMotion_zero` — [kernel]; axioms: the standard three
- `rigidMotion_translation` — [kernel]; axioms: the standard three
- `dist_rigidMotion` — [kernel]; axioms: the standard three
- `continuous_rigidMotion` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `continuous_rigidMotion_apply` — [kernel]; axioms: the standard three
- `rigidMotion_add_two_pi` — [kernel]; axioms: the standard three
- `rigidMotion_motionMul` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `exists_rigidMotion_edge` — [kernel]; axioms: the standard three
- `measurePreserving_motionMul_right` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `measurePreserving_motionMul_left` — [kernel]; axioms: the standard three
- `prod_arcLength_eq_restrict` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `prod_arcLength_eq_zero_iff_volume` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `mem_monoPairSet_iff_rigidMotion` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `monoPairSet_eq_iUnion` — [kernel]; axioms: the standard three
- `mem_monoPairSet_of_e_eq` — [kernel]; axioms: the standard three
- `aeProperOn_iff_unitPairsNull` — [kernel]; axioms: the standard three
- `aeProperOn_iff_ae` — [kernel]; axioms: the standard three
- `aeProperOn_iff_volume` — [kernel]; axioms: the standard three
- `monoPairSet_mono` — [kernel]; axioms: the standard three
- `AeProperOn.mono` — [kernel]; axioms: the standard three
- `aeProperOn_congr` — [kernel]; axioms: the standard three
- `aeProperOn_of_proper` — [kernel]; axioms: the standard three
- `aeProperOn_of_proper_off_null` — [kernel]; axioms: the standard three
- `AeProperOn.comp_rigidMotion` — [kernel]; axioms: the standard three
- `isWeakColouringOn_univ_iff` — [kernel]; axioms: the standard three
- `AeColouring.isWeakColouringOn` — [kernel]; axioms: the standard three
- `IsWeakColouringOn.exists_aeColouring` — [kernel]; axioms: the standard three
- `IsWeakColouringOn.mono` — [kernel]; axioms: the standard three
- `IsWeakColouringOn.comp_rigidMotion` — [kernel]; axioms: the standard three
- `exists_isWeakColouringOn_ball_iff` — [kernel]; axioms: the standard three
- `exists_isWeakColouringOn_iff_subtype` — [kernel]; axioms: the standard three

**`Plane/Radius`** (`Proofs/HadwigerNelson/Plane/Radius.lean`; 16 theorems, 14 proved by this job):

- `exists_isWeakColouringOn_seven` — [kernel]; axioms: the standard three
- `AeProperOn.ae_rigidMotion_edge` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `AeProperOn.ae_rigidMotion` — [kernel]; axioms: the standard three
- `AeProperOn.ae_rigidMotion_arcLength` — [kernel]; axioms: the standard three
- `aeProperOn_iff_ae_rigidMotion` — [kernel]; axioms: the standard three
- `isOpen_setOf_mapsTo_rigidMotion` — [kernel]; axioms: the standard three (proved by the planner, FS124-K1)
- `AeProperOn.exists_rigidMotion` — [kernel]; axioms: the standard three
- `colorable_induce_of_forall_ne` — [kernel]; axioms: the standard three
- `AeProperOn.colorable_induce` — [kernel]; axioms: the standard three
- `radius_graph` — [kernel]; axioms: the standard three
- `radius_countable` — [kernel]; axioms: the standard three
- `colorable_plane_of_forall_finite` — [kernel]; axioms: the standard three
- `colorable_induce_of_forall_aeProperOn_ball` — [kernel]; axioms: the standard three
- `colorable_plane_of_forall_aeProperOn_ball` — [kernel]; axioms: the standard three
- `exists_radius_of_not_colorable` — [kernel]; axioms: the standard three
- `radius_up` — [kernel]; axioms: the standard three

**`Plane/RadiusOutside`** (`Proofs/HadwigerNelson/Plane/RadiusOutside.lean`; 8 theorems, 8 proved by this job):

- `isWeakColouringOn_univ_iff_weakColoring` — [kernel]; axioms: the standard three
- `exists_isWeakColouringOn_univ_iff` — [kernel]; axioms: the standard three
- `exists_isWeakColouringOn_of_colorable` — [kernel] on a declared outside theorem; axioms: the standard three and `Outside.OAI158.proper_to_borel_weak`
- `radius_down` — [kernel] on a declared outside theorem; axioms: the standard three and `Outside.OAI158.proper_to_borel_weak`
- `radius_five` — [kernel] on a declared outside theorem; axioms: the standard three and `Outside.OAI158.no_proper_five_coloring`
- `exists_radius_no_weak_four` — [kernel]; axioms: the standard three
- `colorable_iff_forall_ball` — [kernel] on a declared outside theorem; axioms: the standard three and `Outside.OAI158.proper_to_borel_weak`
- `seven_le_chromaticNumber_plane_iff_exists_ball` — [kernel] on a declared outside theorem; axioms: the standard three and `Outside.OAI158.proper_to_borel_weak`

## Stage 1 — SAVED (FS124-I1): the readback, the build as given, the statements as stored

**The brief's quotations against their sources.** `data/fs124/i1/readback.py <brief>` (the planner's reader, copied
and changed in two places: the path is the first token after `— source:`, since this brief writes `<path> Stage 5`;
a relative path is resolved in the main working tree, where the brief lives) takes every quoted block with its
`— source:` line and looks for it, whitespace-normalized, in the file named: **15 of 15 found**, exit 0
(`data/fs124/i1/logs/readback.txt`) — Kooshi's two passages; the three claims' first lines; `AeProperOn`; the seven
theorem heads; the planner's two sentences. Control: `--control` swaps the case of one letter in each quotation and
must find none — it found none of the fifteen, exit 0 (`data/fs124/i1/logs/readback-control.txt`).

**One difference between the two copies of the claim list, not in any statement**: `main`'s
`data/fs124/claims-K1.md` carries a dated line at its end (2026-10-07, 14:44 UTC, the planner's draft filed, with the
two join theorems named) that this branch's copy does not; the five statements and their not-claimed lines are
identical in the two (`diff`: the one hunk is that line).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; `data/fs124/claims-K1.md`; the planner's record, all five stages; the three modules with their
docstrings; `Plane/AeColouring`, `Plane/UnitPairs`; of `Plane/Basic` the definitions of `e` and `arcLength` and their
lemmas; of `Outside/OAI158` lines 150–354 (the bridge and the forms this library cites); of `Plane/YesLimit` the proof
of `chromaticNumber_plane_le_chiM0`; `UnitDistance`'s `unitDistance_adj` and
`add_one_le_chromaticNumber_iff_not_colorable`; the planner's `checks1.lean`, `checks2.lean`.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0 —
`build: OK — all 1847 modules already up to date, nothing built, 3 module(s) with warnings, 2s`; **49** lines
`declaration uses sorry` (27 in `Plane/WeakColouringOn`, 14 in `Plane/Radius`, 8 in `Plane/RadiusOutside`) and no
other warning (`data/fs124/i1/logs/build-0-as-given.log`).

**The statements as the kernel stores them, before any change.** `data/fs124/i1/lean/Statements.lean` prints, for
every constant the three modules declare, its kind, its full name, `Expr.hash` of its stored type, `Expr.hash` of its
value where it is a definition, and the type pretty-printed: 74 constants (64 theorems — the 57 leaves and seven the
elaborator generates — 7 definitions, the structure with its constructor and recursor), in
`data/fs124/i1/statements-before.txt`. Stage 3 prints the same from the build after the last leaf and compares
(`data/fs124/i1/statements_check.py`): "no statement changed" is then a check on stored terms, not on the files' text.

**The iteration instrument** (never evidence): `data/fs124/i1/iter.sh <file> [keep]` elaborates one file against an
overlay of this worktree's build (`build/fs124-i1-olean`, ignored by git; a symlink copy of the library, with the
edited modules' object files written over their links — the link is removed first, so the build is never written
through). Options as the lakefile's: `autoImplicit`, `relaxedAutoImplicit` off, `linter.missingDocs` on. Control: a
copy of `Plane/Radius` with one argument of `radius_graph`'s last line replaced (`hmaps hv` for `hmaps hw`) is
reported at its line with exit 1; the file itself exits 0.

## Stage 2 — SAVED (FS124-I1): the three modules proved, through the build

**The 49 leaves are proved**; no statement, definition, docstring or import of the three modules is changed, and no
declaration is added. Build under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`): exit 0 — `build: OK — 476 of 476 batches, 4 module(s) rebuilt, 0 module(s) with warnings, 8m40s`;
no `declaration uses sorry` line and no warning of any kind (`data/fs124/i1/logs/build-1-proved.log`); `grep sorry` over
the three files finds nothing.

**One build for the three modules, not one after each** (the brief's step 2 asks a build after each module): all 49
leaves had gone through at iteration level — 27, then 14, then 8, each file elaborated against the one before it in the
overlay — before the first build was due, so a build per module would have compiled the same three files three times and
held a 40 GiB slot for three walks of nine minutes while two other agents build. The one build is the evidence for each
module. A decision of mine, said here and in the report.

**No statement changed — checked on the stored terms.** `data/fs124/i1/lean/Statements.lean`, run against the build
before the job and after it (`statements-before.txt`, `statements-after.txt`); `data/fs124/i1/statements_check.py`
compares them row by row: **72 of 72 identical** — 62 theorems (the 57 leaves, the structure's two projections, three
equation lemmas of the definitions), the 7 definitions with their value hashes, the structure, its constructor and its
recursor — exit 0 (`data/fs124/i1/logs/statements-check.txt`). Not compared: two `_simp_` auxiliaries of the planner's
proof of `ae_rigidMotion_edge` (generated inside a proof; present and unchanged). Seventeen names are new, every one
generated by the elaborator inside a proof (`._simp_N_M`, `.match_N_M`, and `AeProperOn.eq_1`, the equation lemma that
`rw [AeProperOn]` asks for): no hand-written declaration was added. Control (`--control`): one digit of one theorem's
type hash changed and one definition's row removed, in a copy of the second print — both reported, nothing else, exit 0
(`data/fs124/i1/logs/statements-control.txt`).

**The axioms of every theorem of the three modules** (`data/fs124/i1/lean/AxiomsPrint.lean`, generated from the second
statements print so that none is left out — 63 `#print axioms` lines: the 57, the two projections, four equation
lemmas; output `data/fs124/i1/axioms-print.txt`). `data/fs124/i1/axioms_check.py check`, each record as a set against
the planner's § 3.5: **58 on the standard three and nothing else; four on the standard three and
`Outside.OAI158.proper_to_borel_weak` and nothing else** (`exists_isWeakColouringOn_of_colorable`, `radius_down`,
`colorable_iff_forall_ball`, `seven_le_chromaticNumber_plane_iff_exists_ball`); **one on the standard three and
`Outside.OAI158.no_proper_five_coloring` and nothing else** (`radius_five`); no record on both; 0 failures, exit 0
(`data/fs124/i1/logs/axioms-check.txt`). The two join theorems, as printed:

```
'HadwigerNelson.Plane.colorable_iff_forall_ball' depends on axioms: [propext,
 Classical.choice,
 Quot.sound,
 HadwigerNelson.Outside.OAI158.proper_to_borel_weak]
'HadwigerNelson.Plane.seven_le_chromaticNumber_plane_iff_exists_ball' depends on axioms: [propext,
 Classical.choice,
 Quot.sound,
 HadwigerNelson.Outside.OAI158.proper_to_borel_weak]
```

Control (`data/fs124/i1/lean/AxiomsControl.lean`, outside the library): three planted theorems — one proved by `sorry`
and expected clean; C124-RADIUS-FIVE's sentence proved from `radius_five` and expected clean; one resting on both
imports and expected on the transfer alone — and a clean partner. `axioms_check.py control` reported the three, each by
name with the axiom it should not carry, and passed the partner; exit 0 (`data/fs124/i1/logs/axioms-control.txt`).

**Which half of each join theorem rests on the import — printed, not only said** (`data/fs124/i1/lean/Halves.lean`,
outside the library: each half proved from the lemma the docstring names; `data/fs124/i1/halves-print.txt`):

| half | proved from | axioms as printed |
|---|---|---|
| weak colourings of every disc about `0` ⟹ the plane is `k`-colourable | `radius_up` | the standard three |
| the plane is `k`-colourable ⟹ every disc about `0` has a weak `k`-colouring | `radius_down` | the standard three and `proper_to_borel_weak` |
| `7 ≤ χ(ℝ²)` ⟹ some disc about `0` has no weak six-colouring | `exists_radius_of_not_colorable` | the standard three |
| some disc about `0` has no weak six-colouring ⟹ `7 ≤ χ(ℝ²)` | `radius_down` | the standard three and `proper_to_borel_weak` |

That the last half *needs* the import is a fact about this proof, not a theorem: the kernel says what a proof uses, never
what every proof must.

**Routes: the planner's § 3.2, leaf by leaf, with three departures.**

1. `measurePreserving_motionMul_left` — the planned route names Mathlib's `rotation (Circle.exp q.2)`. That constant
   lives in `Mathlib.Analysis.Complex.Isometry`, which is **not in the import closure of `Plane/WeakColouringOn`** (the
   planner's `#check` ran under `import Mathlib`): `Unknown identifier rotation`. I did not add the import — which
   instance a term is elaborated with depends on the imports (`LEAN.md` § Searching, on `volume : Measure ℂ`), so an
   import added to the module of the definition can move the stored statements with no change of text. Multiplication by
   `e θ` is instead built on the spot as a real-linear isometry of the plane (`LinearEquiv.smulOfUnit` at the unit
   `e θ`, `restrictScalars ℝ`, norm preserved by `norm_mul`, `norm_e`), and `LinearIsometryEquiv.measurePreserving`
   — which is in the closure — finishes. Five lines inside the proof; no declaration. Searched first, by shape: this
   library (`rg MeasurePreserving` over `Proofs/`: no rotation of the plane; `AeColouring.exists_motion` avoids one by
   taking almost every angle first) and Mathlib (`MeasurePreserving` with `Circle`, `rotation`, `unitary`, `Complex`:
   nothing but `rotation` itself).
2. `aeProperOn_of_proper_off_null` — planned to return to `arcLength` by `prod_arcLength_eq_restrict` and
   `Measure.restrict_le_self`; proved through `aeProperOn_iff_volume`, the leaf just above it that says the same. The
   rest is the plan's: the monochromatic pairs lie in `N ×ˢ univ ∪ (motionMul · (1, 0)) ⁻¹' (N ×ˢ univ)`.
3. `seven_le_chromaticNumber_plane_iff_exists_ball` — planned as a rewrite by `colorable_iff_forall_ball` and `push Not`;
   proved half by half instead, `→` from `exists_radius_of_not_colorable` and `←` from `radius_down`, so that the proof
   reads as its docstring does. `colorable_iff_forall_ball` likewise: `→` is `radius_down`, `←` is `radius_up`.

Every other leaf is the plan's route with the plan's names. **Attempts**: one retry (departure 1); every other leaf
elaborated as first written.

**Hypotheses: none unused, three idle clauses — the planner's § 2.4, confirmed by the proofs.** No binder of any of the
57 statements is unread by its proof. What a proof does not read: (a) the `measurable` field of `IsWeakColouringOn` in
`radius_graph`, `radius_countable` and `radius_up` — each uses `hc.aeProperOn` alone (generalization 1); (b) the
premise `IsOpen U` inside `radius_down`'s conclusion — the colouring serves every set, as its docstring says
(generalization 4); (c) `V`-membership of the two points in `AeProperOn.ae_rigidMotion`'s pair-by-pair step, which is
`ae_ball_iff`'s shape and not a hypothesis of the statement. Nothing is dropped: the statements are fixed.
