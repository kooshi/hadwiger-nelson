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
`data/fs124/i1/statements-before.txt`. Stage 2 prints the same from the build after the last leaf and compares
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

## Stage 3 — SAVED (FS124-I1): the audit block, and the checks of the brief's step 4

**`scripts/Axioms.lean`, a block headed "FS124-I1"** (68 lines added, none changed): under the IMPORTED banner, after
FS132-I1's records, `radius_five` beneath a line naming `no_proper_five_coloring`, and
`exists_isWeakColouringOn_of_colorable`, `radius_down`, `colorable_iff_forall_ball`,
`seven_le_chromaticNumber_plane_iff_exists_ball` beneath a line naming `proper_to_borel_weak`; above the PURCHASED
banner, after FS131-L8A's block, the other 52 theorems in the files' order. 57 records: every hand-written theorem of
the three modules once.

**The audit on this branch** — `scripts/slot.py --mem 16 --cpus 2 -- ./scripts/axioms.sh`, exit 0:
`axioms: OK — 6585 clean, 20 axiom-free, 23 imported, 5 declared purchase(s)` (`data/fs124/i1/logs/axioms-sh.txt`);
6,633 records. Against the branch's base (6533 clean, 18 imported, 6,576 records): **clean +52, imported +5, records
+57**, nothing else moved; the digest reads the recorded count as stale, as it must until the front page is refiled.
The imports' consumers: `no_proper_five_coloring` 5 → 6, `proper_to_borel_weak` 5 → 9. Control, on the block itself:
`radius_five`'s line and `radius_up`'s exchanged (an imported record under CLEAN, a clean one under IMPORTED) —
exit 1, `FAIL import-in-clean 'HadwigerNelson.Plane.radius_five' …` and `FAIL stale-import
'HadwigerNelson.Plane.radius_up' …`, two checks failed (`data/fs124/i1/logs/axioms-sh-control.txt`); the file put back
from its copy (`sha256sum -c`: OK) and the audit run again, so the saved `latest` run is the true one.

**`tools/check_architecture.py`**: exit 0, `RESULT: PASS` (`data/fs124/i1/logs/check-architecture.txt`). No module was
added and no import changed, so the map's three rows (the planner's) stand.

**`./scripts/dupnames.sh`** under the slot (`--mem 12`): exit 0 — `dupnames: OK — no name is declared by two modules
(23 generated on demand, listed above)`; 1,847 of the package's modules scanned against 1,847 source files
(`data/fs124/i1/logs/dupnames.txt`). None of the 23 generated names has a copy in the three modules (the full log names
neither `WeakColouringOn` nor `Plane.Radius`).

**The guarded lint** — `scripts/slot.py --mem 8 --cpus 2 -- lake lint --no-build -- --no-build --trace`: exit 0,
`-- Linting passed for Proofs.`, 14 linters started and 14 `(2/2) Passed!` (`data/fs124/i1/logs/lint.txt`).
**No control was run on `lake lint` itself**: a planted fault in a module needs two more builds (plant, restore). In
its place, the one linter that bears on the brief's step 3 was asked directly: `data/fs124/i1/lean/UnusedArgs.lean`
runs Batteries' `unusedArguments` test on each theorem of the three modules by name and prints a line per theorem
visited — **63 visited, 63 `ok`** — and on two theorems declared in that file: the one with a hypothesis its proof
does not read is reported (`1 unused argument: argument 2: (hU : IsOpen U)`), its partner is not
(`data/fs124/i1/logs/unused-args.txt`).

**The assumptions step, run to read what the landing must add (nothing written)** —
`./scripts/assumptions.sh` under the slot: exit 1 on exactly five `unlisted-consumer` rows, the five records above
(`RESTS <import> <theorem>`, absent from `scripts/assumptions-ledger.txt`), and no other failure: `fails=0` among the
decided hypotheses; `rests` 18 → 23 and the other eight counts unchanged
(`data/fs124/i1/logs/assumptions-sh.txt`). So, as the planner's § 3.5 expected: **no line is owed to
`scripts/Assumptions.lean`** — neither `AeProperOn` nor `IsWeakColouringOn` is read as an undeclared former (each is
concluded by theorems with no assumption: `aeProperOn_of_proper`, `AeColouring.isWeakColouringOn`), and no hypothesis
of the 57 statements is closed. The landing's `--write-ledger` adds the five rows.

## Stage 4 — SAVED (FS124-I1): the four statements read aloud, the scan of the statements, the price, the drafts

### 4.1 Read aloud

Each statement below is the stored one, every binder's type shown (`data/fs124/i1/lean/ReadAloud.lean`, output
`data/fs124/i1/read-aloud-signatures.txt`), read against the claim's words.

**`radius_up`** against

> **C124-RADIUS-UP** — statement: For every integer k ≥ 1: if for every R > 0 the open disc of radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a proper k-colouring, and χ(ℝ²) ≤ k.
> — source: data/fs124/claims-K1.md

```
@radius_up : ∀ {k : ℕ},
  (∀ R > (0 : ℝ), ∃ (c : ℂ → Fin k), IsWeakColouringOn (Metric.ball (0 : ℂ) R) c) →
    (∀ (V : Set ℂ), V.Finite → (SimpleGraph.induce V (unitDistance ℂ)).Colorable k) ∧
      (unitDistance ℂ).chromaticNumber ≤ ↑k
```

Aloud: *for every natural number `k`: if for every real `R > 0` there is a measurable function from the plane to `k`
labels whose monochromatic unit pairs with both ends in the open disc of radius `R` about `0` are a null set of pairs
(point, direction), then the graph on every finite set of points of the plane, with an edge wherever two of them are
at distance 1, has a proper colouring with `k` colours, and the chromatic number of the plane's unit-distance graph is
at most `k`.*

- "every integer k ≥ 1" — `{k : ℕ}` with no `1 ≤ k`: there is no `c : ℂ → Fin 0`, so at `k = 0` the hypothesis fails
  at every `R` and the statement says nothing; the claim's range is all the statement says.
- "the open disc of radius R about the origin" — `Metric.ball (0 : ℂ) R`, `R > 0`.
- "has a weak measurable k-colouring" — `∃ c : ℂ → Fin k, IsWeakColouringOn (ball 0 R) c`: `c` measurable, and
  `(volume ⊗ arcLength) {(x, θ) | x ∈ U ∧ x + e θ ∈ U ∧ c x = c (x + e θ)} = 0`. The list's own words — "a measurable
  map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z` of `U` and a unit vector
  `u` with `z + u` in `U`" — are `aeProperOn_iff_ae` for the second clause, and for a map on `U` itself
  `exists_isWeakColouringOn_iff_subtype` (a disc is measurable; `k ≥ 1` there is `[NeZero k]`). Both are now proved.
- "every finite unit-distance graph in the plane has a proper k-colouring" — the graph on a finite `V` with *all* its
  unit pairs as edges is `k`-colourable; a finite unit-distance graph drawn on those points is a subgraph of it.
- "χ(ℝ²) ≤ k" — `(unitDistance ℂ).chromaticNumber ≤ (k : ℕ∞)`, the number `chromaticNumber_plane_eq_complex` equates
  with row 33's over `EuclideanSpace ℝ (Fin 2)`.
- Not said, as the list's not-claimed line asks: no radius, no converse, nothing about whether the hypothesis holds at
  six. **No import**: the standard three, as printed. The file's `example` runs it on R7 and gets `χ(ℝ²) ≤ 7`.

**`radius_down`** against

> **C124-RADIUS-DOWN** — statement: For every integer k ≥ 1: if χ(ℝ²) ≤ k, every open set of the plane has a weak measurable k-colouring.
> — source: data/fs124/claims-K1.md

```
@radius_down : ∀ {k : ℕ},
  (unitDistance ℂ).chromaticNumber ≤ ↑k → ∀ (U : Set ℂ), IsOpen U → ∃ (c : ℂ → Fin k), IsWeakColouringOn U c
```

Aloud: *for every natural number `k`: if the chromatic number of the plane's unit-distance graph is at most `k`, then
every open set `U` of the plane has a measurable function from the plane to `k` labels whose monochromatic unit pairs
inside `U` are null.* Word for word. "k ≥ 1" is no hypothesis because `χ(ℝ²) ≤ 0` is false. The proof gives more than
is said — one colouring for every set, open or not (`exists_isWeakColouringOn_of_colorable`) — and the statement keeps
the claim's "open". **It rests on `Outside.OAI158.proper_to_borel_weak`** and the standard three, as printed, and the
list's not-claimed line says so: "anything without that import". The file's `example` runs it at `k = 7`.

**`colorable_iff_forall_ball`** — the join, not a line of the claim list (kept by the coordinator's ruling; `main`'s
copy of the list names it in its dated line):

```
@colorable_iff_forall_ball : ∀ {k : ℕ},
  (unitDistance ℂ).Colorable k ↔ ∀ R > (0 : ℝ), ∃ (c : ℂ → Fin k), IsWeakColouringOn (Metric.ball (0 : ℂ) R) c
```

Aloud: *for every `k`, the plane has a proper `k`-colouring exactly when every open disc about the origin has a weak
`k`-colouring.* `→` is C124-RADIUS-DOWN at the discs, **on the import**; `←` is C124-RADIUS-UP, **with no import**
(Stage 2's table: each half printed apart).

**`seven_le_chromaticNumber_plane_iff_exists_ball`** against the brief's sentence — "`7 ≤ χ(ℝ²)` if and only if some
disc about the origin has no weak six-colouring" (`data/fs124/briefs/FS124-I1-radius.md` § Why this job):

```
seven_le_chromaticNumber_plane_iff_exists_ball : (7 : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber ↔
  ∃ R > (0 : ℝ), ¬∃ (c : ℂ → Fin (6 : ℕ)), IsWeakColouringOn (Metric.ball (0 : ℂ) R) c
```

Aloud: *the plane's unit-distance graph needs at least seven colours exactly when there is a radius `R > 0` such that
no measurable function from the plane to six labels has its monochromatic unit pairs inside the open disc of radius
`R` about `0` null.* No binder, no hypothesis. With row 33's `χ(ℝ²) ≤ 7` the left side is `χ(ℝ²) = 7`. "About the
origin" costs nothing: `exists_isWeakColouringOn_ball_iff` moves a disc to any centre.

**Which half needs the import, as its docstring says — and as the kernel prints.**
- `→`, *seven gives a disc with no weak six-colouring*: the contrapositive of C124-RADIUS-UP,
  `exists_radius_of_not_colorable` at `k = 6`. **No import** — proved apart, it prints `[propext, Classical.choice,
  Quot.sound]`. It also says more than this half: at that radius no disc at any centre has even a non-measurable
  six-colouring proper at almost every unit pair.
- `←`, *a disc with no weak six-colouring gives seven*: the contrapositive of C124-RADIUS-DOWN. **On
  `Outside.OAI158.proper_to_borel_weak`** — proved apart, it prints the standard three and that axiom.
  `no_proper_five_coloring` is not used by either half.

So for the milestone's consumers: **an exclusion on one disc reaches `χ(ℝ²) = 7` only through the release's transfer;
weak six-colourings of every disc reach `χ(ℝ²) ≤ 6` on this library's own three axioms.** The docstring's sentence is
the proof's shape: the theorem is proved half by half from the two lemmas it names.

### 4.2 The statements under the vacuity scan (run to read; the landing's to gate)

`./scripts/vacuity.sh` under the slot: exit 0, `vacuity: OK` — `declarations=14923 refutations-skipped=215 sites=1448`,
`vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2` (`data/fs124/i1/logs/vacuity-sh.txt`). Against the
recorded counts: declarations +78, sites +1, generic +1, nothing else. **Reconciled**: the scan's own count by module
(`data/fs131/l5/count-modules.lean`, its three lines and total in `data/fs124/i1/logs/count-three-modules.txt`) gives
`Plane/WeakColouringOn` 50, `Plane/Radius` 16, `Plane/RadiusOutside` 12 — 78 — and total 14923. The one new site is
`AeColouring.isWeakColouringOn :: AeColouring k`, read GENERIC: a binder over colourings of the plane at a free `k`
(inhabited at seven and nine: `r7_aeColouring`, `sq9`). No statement of the three modules is a refutation the scan
skips, and none takes a structure whose carrier an import empties — the planner's § 3.5 warning stands for *later*
theorems: one that assumes a weak **five**-colouring of a large disc assumes nothing, given `radius_five`.

### 4.3 The price, as measured

| measured | value | what it measures |
|---|---|---|
| leaves proved | 49 of 49 (27 + 14 + 8) | by count; with the planner's eight, 57 of 57 |
| lines of proof | 204 added (111 + 60 + 33) for 49 `sorry` lines removed | `git diff --numstat` over the three files; the plan said about 185 |
| longest proofs | `measurePreserving_motionMul_left` 14 lines, `aeProperOn_of_proper_off_null` 13 | the plan's bound was 15 |
| attempts | one retry on one leaf; 48 leaves as first written | § Stage 2, departure 1 |
| iteration runs | about nine of `lean` on one file, 2–3 s each | against the overlay; not evidence |
| builds under the slot | 2: as given (2 s, nothing to build), proved (8m40s, 4 modules) | the walk over 476 batches, not the modules |
| other runs under the slot | `dupnames` 1, `lake lint` 1, `axioms.sh` 3 (one planted), `assumptions.sh` 1, `vacuity.sh` 1, the module count 1 | each under a minute but the vacuity scan (about two) |
| wall clock, launch to this stage | about half an hour, 9 minutes of it the build | 14:42 to 15:13 UTC, the reading included |

The planner priced it at "well under an hour of work and two or three builds"; it took one build that compiled anything,
and about half the hour.

### 4.4 What this job ran of the gate, and what it did not

Ran, on this branch as it stands: the build; the `sorry` scan; `scripts/axioms.sh` with a planted control on the
block; `scripts/dupnames.sh`; `tools/check_architecture.py`; the guarded lint; `scripts/assumptions.sh` and
`scripts/vacuity.sh`, each once, to read counts for the drafts below. **Not run**: any `--self-test` (axioms, dupnames,
assumptions, vacuity), `--write-ledger`, `lean4checker`, `regen-check`; nothing on the joined tree, which is where the
landing's gate counts. The brief keeps the full gate for the landing.

## Drafts for the front page

*Each names its slot. Counts are measured on `fs124-wk1` (cut from `main` at `596100d4`), where the recorded base is
`main`'s current one (6533 clean, 18 imported; `rests=18`; `declarations=14845`). If the landing now in flight moves
`main`'s base, the deltas are what transfers: **clean +52, imported +5, records +57; `rests` +5; declarations +78,
sites +1, generic +1.***

1. **`CLAUDE.md` § Trust ledger**, replacing "the current audit reads 6533 clean and 5 declared purchases, and 18
   imported (and 20 axiom-free; 6,576 records at the landing of FS-132's import, FS132-L1, 2026-10-07)":
   "the current audit reads 6585 clean and 5 declared purchases, and 23 imported (and 20 axiom-free; 6,633 records at
   the landing of FS-124's radius clause, 2026-10-07)". In the next sentence, "`Outside.OAI158.no_proper_five_coloring`
   … with five, and `Outside.OAI158.proper_to_borel_weak` … with five" becomes "with six" and "with nine"; "no record
   rests on two of the three" stays true (checked: no record of the 57 carries both).
2. **`CLAUDE.md` § Trust ledger**, the nine counts: `rests=18` becomes `rests=23`, and "with eighteen theorems resting
   on them" becomes "twenty-three"; the other eight are unchanged. No hypothesis is added, in either form.
3. **`CLAUDE.md` § The gate**, the vacuity counts: `declarations=14923 refutations-skipped=215 sites=1448`,
   `vacuous=0 stale=0 declared=3 witnessed=38 generic=1405 unknown=2`. The baseline's two entries are unchanged.
4. **`CLAUDE.md` § Where the problem stands**, after the sentence on `seven_le_chromaticNumber_plane_iff` — the
   planner's draft (`plans/FS124-kernel-plan.md` § 4.4, first item) stands word for word; each of its claims about
   axioms is now a printed line (Stage 2).
5. **`LEDGER.md`, a new row** (none holds the radius clause: `rg C124-RADIUS LEDGER.md` on `main` finds nothing; the
   number is Keryx's): "**A weak colouring of one open set colours every finite unit-distance graph inside it, by
   almost every rigid motion; so the plane's chromatic number is read on discs** [kernel]. For `c` proper at almost
   every unit pair of an open `U` — no measurability — and a countable `V`, almost every rigid motion gives different
   labels to every two points of `V` at distance 1 that it carries into `U` (`Plane.AeProperOn.ae_rigidMotion`); with
   compact closure carried into `U`, one motion does (`Plane.AeProperOn.exists_rigidMotion`). C124-RADIUS-GRAPH
   `Plane.radius_graph`, -COUNTABLE `Plane.radius_countable`, -UP `Plane.radius_up` (weak `k`-colourings of every disc
   about `0` give `χ(ℝ²) ≤ k`; any centres, any regularity: `Plane.colorable_plane_of_forall_aeProperOn_ball`), each
   on the standard three axioms. On the declared outside theorem `Outside.OAI158.proper_to_borel_weak`: -DOWN
   `Plane.radius_down`, and the join `Plane.colorable_iff_forall_ball`,
   `Plane.seven_le_chromaticNumber_plane_iff_exists_ball` — `7 ≤ χ(ℝ²)` exactly when some open disc about `0` has no
   weak six-colouring; *seven gives such a disc* needs no import (`Plane.exists_radius_of_not_colorable`), *such a
   disc gives seven* needs that one. On `Outside.OAI158.no_proper_five_coloring`: -FIVE `Plane.radius_five`; its
   sentence at four colours with no import, `Plane.exists_radius_no_weak_four`. `Proofs/HadwigerNelson/Plane/`
   `WeakColouringOn`, `Radius`, `RadiusOutside`; FS-124 (FS124-E1 derived, FS124-K1 planned, FS124-I1 proved)."
   Assumptions, by name: none in hypothesis form; the two axioms above, each for the records named.
6. **`CLAUDE.md` § Frontier, "Last filed"** — once the landing's gate passes: "the landing of FS-124's radius clause
   (FS124-I1: `Plane/WeakColouringOn`, `Plane/Radius`, `Plane/RadiusOutside` through the gate — the plane is
   `k`-colourable exactly when every disc about the origin has a weak `k`-colouring, `7 ≤ χ(ℝ²)` exactly when one disc
   has no weak six-colouring; the first three claims on the standard three axioms, the join on
   `proper_to_borel_weak`)".
7. **The Proof Atlas**, grade changes at the landing: C124-RADIUS-GRAPH, -COUNTABLE, -UP from derived to [kernel]
   (standard three); C124-RADIUS-DOWN to [kernel] on the declared outside theorem `proper_to_borel_weak`;
   C124-RADIUS-FIVE to [kernel] on `no_proper_five_coloring`. On this branch today, not on `main`.
8. **`ARCHITECTURE.md` § 5 Trust**, the third column of the two rows of `Outside/OAI158`'s axioms: to
   `no_proper_five_coloring`'s records add `Plane.radius_five`; to `proper_to_borel_weak`'s add
   `Plane.exists_isWeakColouringOn_of_colorable`, `Plane.radius_down`, `Plane.colorable_iff_forall_ball`,
   `Plane.seven_le_chromaticNumber_plane_iff_exists_ball`. The three module rows (the planner's) need only their job
   tag widened: "(job FS124-K1)" to "(planned by FS124-K1, proved by FS124-I1)".
9. **`scripts/Axioms.lean`**, the IMPORTED section's prose, "with five and five (the fifth on the transfer is
   FS132-L1's)": "with six and nine (the fifth on the transfer is FS132-L1's; one and four are FS124-I1's)". Not
   changed by this job: it is outside the block.
10. **`scripts/assumptions-ledger.txt`**: `./scripts/assumptions.sh --write-ledger` adds five rows —
    `RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Plane.radius_five` and
    `RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak` with each of
    `HadwigerNelson.Plane.colorable_iff_forall_ball`, `…exists_isWeakColouringOn_of_colorable`, `…radius_down`,
    `…seven_le_chromaticNumber_plane_iff_exists_ball` — and its header's `rests=18` becomes `rests=23`.
    **`scripts/Assumptions.lean`: no line.**
11. **`scripts/vacuity-baseline.txt`**, the header's counts: as in draft 3.
12. **`LEAN.md` § Searching — Lean**, one line: "A `#check` under `import Mathlib` shows that a name exists at the pin,
    not that a module can see it: check a route's names under the module's own imports. `rotation`
    (`Mathlib.Analysis.Complex.Isometry`) is outside `Plane/AeColouring`'s closure; multiplication by a unit complex
    number is a real-linear isometry with no new import as `⟨(LinearEquiv.smulOfUnit (Units.mk0 a ha)).restrictScalars
    ℝ, _⟩`, and `LinearIsometryEquiv.measurePreserving` is in the closure (FS124-I1)." The planner's two `LEAN.md`
    drafts (its § 4.4) stand: `QuasiMeasurePreserving.preimage_null` carried every null-set step here with no
    measurability asked.
