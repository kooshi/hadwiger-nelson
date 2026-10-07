# FS132-I1 — the import of `[OAIMath2026]` family 158: two declared outside theorems, the measure bridge, and the forms this library cites

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I1-import.md` on `main` at `fda06767`.
Branch `fs132-wi1`, cut from `main` at `8386c256`; worktree `.claude/worktrees/fs132-wi1`. Working files: `data/fs132/i1/`.
Tools: `tools/fs132_i1_quotes.py`, `tools/fs132_i1_readback.py`.*

## Theorems this phase proved

Module `Proofs/HadwigerNelson/Outside/OAI158.lean`, namespace `HadwigerNelson.Outside.OAI158`. Axioms as printed from
the built module (`data/fs132/i1/axioms/module.out`, checked as sets by `tools/fs132_i1_axioms.py`); "three" is
`[propext, Classical.choice, Quot.sound]`; H is `no_proper_five_coloring`, T is `proper_to_borel_weak`.

**Declared outside theorems (axioms; `[OAIMath2026]` family 158) — not proved here:**
- `no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c` — H.
- `proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) : ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d` — T.

**Kernel theorems on the three axioms alone** (ten, and two instances):
- `properColoring_iff_colorable` — `(∃ c : ℂ → Fin k, ProperColoring k c) ↔ (unitDistance ℂ).Colorable k`.
- `direction_coe` — `direction (θ : Angles) = Plane.e θ`.
- `map_coe_arcLength` — `Measure.map (fun θ : ℝ => (θ : Angles)) Plane.arcLength = ENNReal.ofReal (2 * Real.pi) • angularMeasure`.
- `map_prodMap_coe` — the same for `volume.prod Plane.arcLength` along `Prod.map id (↑)`.
- **`weakColoring_iff_unitPairsNull`** — for measurable `d`, `WeakColoring k d ↔ ∀ j, Plane.UnitPairsNull (d ⁻¹' {j})`.
- **`nonempty_aeColouring_of_weak`** — the skeleton's leaf, statement unchanged.
- `weakColoring_of_aeColouring` — `(a : Plane.AeColouring k) : WeakColoring k a.col`.
- `exists_weakColoring_iff_nonempty_aeColouring` — `(∃ d, Measurable d ∧ WeakColoring k d) ↔ Nonempty (Plane.AeColouring k)`.
- `exists_properColoring_seven`, `proper_to_borel_weak_model` — the models.
- instances `anglePeriodPositive` (scoped), `angularMeasure.instIsProbabilityMeasure`.

**Kernel theorems on the three axioms and H** (five):
- `not_colorable_five` — `¬ (unitDistance ℂ).Colorable 5`.
- **`six_le_chromaticNumber_plane`** — `6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber`.
- **`chromaticNumber_plane_six_or_seven`** — `6 ≤ χ ∧ χ ≤ 7` for the same `χ`.
- **`six_le_chiM0`** — `6 ≤ Plane.chiM0`.
- `chiM0_six_or_seven` — `6 ≤ Plane.chiM0 ∧ Plane.chiM0 ≤ 7`.

**Kernel theorems on the three axioms and T** (four):
- `nonempty_aeColouring_of_colorable` — `(unitDistance ℂ).Colorable k → Nonempty (Plane.AeColouring k)`.
- `colorable_iff_nonempty_aeColouring` — `(unitDistance ℂ).Colorable k ↔ Nonempty (Plane.AeColouring k)`.
- **`chiM0_le_chromaticNumber_plane`** — `Plane.chiM0 ≤ (unitDistance ℂ).chromaticNumber`.
- **`chromaticNumber_plane_eq_chiM0`** — `(unitDistance ℂ).chromaticNumber = Plane.chiM0`, no hypothesis.

No theorem of the module rests on both imports. No `sorry`, no `native_decide`, exactly two `axiom`s.

## Stage 1 — SAVED (FS132-I1): the readback

### The brief's quotations

`tools/fs132_i1_quotes.py` on the brief (read from `main`'s checkout — the brief was committed after this branch was cut and
is not in the worktree), sources read in the worktree: **24 quotations, 0 mismatches**, exit 0
(`data/fs132/i1/quotes.out`); its self-test plants a changed word, a wrong source and an empty quotation, each **FIRED**
(`data/fs132/i1/quotes-selftest.out`). By source: the skeleton 8, the inventory 4, the release's three files 4, `LEAN.md`
2, `WeilKloosterman.lean` 2, the request file 2, `YesLimit.lean` 1, `Interval.lean` 1.

### What was read

The skeleton whole (`data/external/oai1/audit/ImportSkeleton.lean`, 104 lines); the audit's stages 4, 7, 8 and 5
(`plans/EXT-OAI1-audit.md`); the release's `Coloring.lean` whole (34 lines), `Five.lean` whole (131 lines),
`BorelTransfer.lean` lines 395–451 and every scope line of that file (its `namespace`/`section`/`open`/`variable` lines);
the clone is at `adc7f1241b42e322a6451854ab7e4b4c146bf78a`, tree clean. `plans/STANDING-RULES.md`, `LEAN.md` and
`RUNNING.md` §§ Building, Make the gate fail, in full. Inventory items 573, 596, 614–620.

### The branch as given

`./scripts/build.sh` under `slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`: **exit 0**, "all 1831 modules already up to
date, nothing built, 0 module(s) with warnings" (`data/fs132/i1/build-0-as-given.log`).

### The two axioms against the release's files — by text

| the release, at `adc7f124` | the skeleton | difference |
|---|---|---|
| `Coloring.lean:7–8` `def ProperColoring (k : ℕ) (c : ℂ → Fin k) : Prop := ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y` | lines 19–20 | none |
| `:15` `instance anglePeriodPositive : Fact (0 < 2*Real.pi) := ⟨by positivity⟩` | line 23, `scoped instance` | the word `scoped`: the constant is the same; the instance is in force only where the namespace is open |
| `:16` `abbrev Angles := AddCircle (2*Real.pi)` | line 25 | none |
| `:17` `def angularMeasure : Measure Angles := AddCircle.haarAddCircle` (in a `noncomputable section`) | line 27, `noncomputable def` | the keyword only |
| `:18` `def direction (t : Angles) : ℂ := AddCircle.toCircle t` (same section) | line 29, `noncomputable def` | the keyword only |
| `:27–29` `def WeakColoring (k : ℕ) (c : ℂ → Fin k) : Prop := AEMeasurable c (volume : Measure ℂ) ∧ ∀ᵐ p ∂(volume : Measure ℂ).prod angularMeasure, c p.1 ≠ c (p.1+direction p.2)` | lines 31–33 | none in the text — **one in the elaborated term, below** |
| `Five.lean:124` `theorem no_proper_five_coloring : ¬ ∃ c : ℂ → Fin 5, ProperColoring 5 c` | line 39, `axiom` | the keyword |
| `BorelTransfer.lean:436–437` `lemma proper_to_borel_weak {k : ℕ} [NeZero k] {c : ℂ → Fin k} (hc : ProperColoring k c) : ∃ d : ℂ → Fin k, Measurable d ∧ WeakColoring k d` | lines 43–44, `axiom` | the keyword |

**Scope at the release's two statements.** `Five.lean:88–129` is a `noncomputable section` with `open scoped Classical`,
`open Set Filter Topology MeasureTheory`, and **no `variable`**; `BorelTransfer.lean:433–449` has `open MeasureTheory` and
**no `variable`** (the `variable` lines of that file are in earlier sections, each closed: 11, 73, 130, 204, 251, 316, 340,
372, 403–405). So no section variable can enter either statement. Not copied from `Coloring.lean`, and not needed by any
statement: its two instances on `angularMeasure` (`IsProbabilityMeasure`, `IsAddHaarMeasure`) and its three lemmas on
`direction` (`direction_continuous`, `direction_norm`, `direction_real`).

### The two axioms against the release's theorems — as the kernel holds them, across the two pins

The audit's read-back (`ImportReadback.lean`) was made at the release's pin, inside `import Mathlib`: there the copied text
and the release's constants are equal by `rfl`. It could not see what the same text elaborates to **at this pin under this
library's imports**. This job's instrument does: `data/fs132/i1/readback/DumpBody.lean.inc` prints a declaration as the
kernel stores it (de Bruijn indices, full constant names with universe arguments, every implicit and instance argument,
binder kinds and binder names); `ReleaseDump.lean` runs it at the release's pin on the release's eight constants (Lean
v4.34.1's own binary, `LEAN_PATH` set to the audit's compiled working copy — no `lake`, so nothing is written there:
`find -newer` a marker reads **0 files** under `~/.cache/ext-oai1` and under `~/source/math`), and `SkeletonDump.lean`
runs it at this pin on the skeleton's lines 12–44, copied by script. `tools/fs132_i1_readback.py decls` compares the two
prints with the two namespaces written alike and nothing else normalised (`readback/decls-skeleton.out`):

- **IDENTICAL, term for term**: `ProperColoring`, `anglePeriodPositive`, `Angles`, `angularMeasure`, `direction`, the
  **stored type of `no_proper_five_coloring`** and the **stored type of `proper_to_borel_weak`** (a `theorem` there, an
  `axiom` here). The stored type of T at the release has exactly four binders — `{k : ℕ}`, `[inst : NeZero k]` (the zero of
  `ℕ` through `MulZeroClass.toZero ℕ Nat.instMulZeroClass`), `{c : ℂ → Fin k}`, `(hc : ProperColoring k c)` — and its
  `Measurable` is over `Complex.measurableSpace` and `Fin.instMeasurableSpace k`; H's has none, and its `5` is
  `@OfNat.ofNat ℕ 5 (instOfNatNat 5)`.
- **DIFFERENT — a finding about the skeleton: `WeakColoring`'s stored value.** The measure space of `ℂ` is
  `measureSpaceOfInnerProductSpace ℂ … ‹FiniteDimensional ℝ ℂ› …` at both pins, and the proof of `FiniteDimensional ℝ ℂ`
  passed to it (six occurrences) is `Complex.instFiniteDimensionalReal` at the release and
  `FiniteDimensional.rclike_to_real ℂ Complex.instRCLike` in the skeleton. Substituting that one subterm makes the two
  values identical (checked by script). **Cause, measured**: the skeleton's imports do not reach
  `Mathlib.LinearAlgebra.Complex.FiniteDimensional`, where `Complex.instFiniteDimensionalReal` is declared (the constant
  is absent from the skeleton's environment); with that module imported — in either position, or with `import Mathlib` —
  instance synthesis at this pin returns `Complex.instFiniteDimensionalReal`, as at the release. **What it is worth**:
  `FiniteDimensional ℝ ℂ` is a proposition, so the two terms are definitionally equal by proof irrelevance and the two
  axioms would have meant the same; but the read-back the import owes is symbol against symbol, and it was not.
  **Repair, made in stage 2**: the module imports `Mathlib.LinearAlgebra.Complex.FiniteDimensional`, and the comparison is
  re-run on the built module — eight of eight must read IDENTICAL.

### One step down: the constants the statements name, at the two pins

`Level1Body.lean.inc` prints each of the **83** Mathlib and core constants the eight declarations name (at either pin):
its type, and its value (a definition) or its constructors (an inductive type). `tools/fs132_i1_readback.py level1`
(`readback/level1.out`): all 83 exist at both pins; **69 identical**; **6 identical up to the names of their universe
parameters** (`AddCommGroup.toAddGroup`, `MeasureTheory.Measure`, `MeasureSpace.toMeasurableSpace`, `MeasureSpace.volume`,
`Norm.norm`, `NormedField.toNormedCommRing`); **8 different**, each read:

| constant | what differs | reading |
|---|---|---|
| `Real.instLT`, `Real.instMul`, `Real.instOne`, `Real.instZero` | the private definition each wraps is `_private.Mathlib.Data.Real.Basic.0.Real.lt` here and `_private.Mathlib.Basic.Real.Basic.0.Real.lt` there (and so for `mul`, `one`, `zero`) | the file moved (`Mathlib/Data/Real/Basic.lean` → `Mathlib/Basic/Real/Basic.lean`; 11 of the 83 constants are declared in another module at the other pin, all under this move); a private name carries its file |
| `Filter.Eventually` | its value is `{x \| p x} ∈ f`, with the set-builder `setOf` here and `Set.ofPred` there | a rename: at `v4.34.1`, `Mathlib/Data/Set/Defs.lean:67` `def Set.ofPred {α : Type u} (p : α → Prop) : Set α` and `:70` `alias setOf := Set.ofPred`, deprecated; here `:65` `def setOf {α : Type u} (p : α → Prop) : Set α` |
| `measureSpaceOfInnerProductSpace` (definition) | inside its value, the `Semiring ℝ` handed to `Module.finrank` is reached as `CommSemiring.toSemiring (Semifield.toCommSemiring …)` there and `DivisionSemiring.toSemiring (Semifield.toDivisionSemiring …)` here | two parent paths to one structure — by reading, not by a check; the first difference only was read |
| `Circle._proof_1` (a theorem's type, inside `Circle`) | the same kind of path: `Ring.toSemiring (DivisionRing.toRing …)` there, `DivisionSemiring.toSemiring (DivisionRing.toDivisionSemiring …)` here | as above |
| `Complex.instRCLike` | a path in its value | named only by the skeleton's form before the import above; the module does not name it |

**What this does and does not establish.** One step down, nothing changed its meaning by my reading; two of the eight are
instance paths I read at their first difference and did not prove equal. Below one step — the whole of Mathlib under
`volume`, `Measure.prod`, `ae`, `AddCircle.haarAddCircle`, `AddCircle.toCircle`, the norm of `ℂ` — nothing was compared
term by term. What stands in for it is stage 3's: at this pin the kernel derives the library's own forms from the copied
definitions (`ProperColoring` ⟺ a colouring of `unitDistance ℂ`; `WeakColoring` of a measurable map ⟺ `UnitPairsNull` of
every fibre, over `Plane.e` and `Plane.arcLength`), so what the two axioms say **here** is pinned to objects this library
already reasons with, whatever Mathlib's text below.

## Stage 2 — SAVED (FS132-I1): the module, the leaf, the bridges

### The module, and what changed from the skeleton

`Proofs/HadwigerNelson/Outside/OAI158.lean` — the place and the namespace the audit proposed. Imports:
`Instances/Interval`, `Plane/YesLimit` (N-EASY; the binder `hNEASY` is gone from the two theorems that carried it),
`Plane/CoverExamples` (the model: `r7_aeColouring`), `Mathlib.Analysis.Fourier.AddCircle`, and
`Mathlib.LinearAlgebra.Complex.FiniteDimensional` — the repair of stage 1's finding, with a `--` comment saying why.
Registered: `Proofs.lean`; `ARCHITECTURE.md` (a new § 3.12 with the module's row; two rows and the count sentence in
§ 5 Trust); `scripts/Axioms.lean` (two `declareImport` lines, nine records under IMPORTED, twelve under a block headed
"FS132-I1" above PURCHASED, and the section's prose brought to three imports).

Changed from the skeleton, each by choice:
1. **One import added** (above), so that the stored terms are the release's.
2. **The leaf is a corollary of an equivalence.** `weakColoring_iff_unitPairsNull` is the statement from which the leaf
   is one line, and its converse gives the model with no axiom. The leaf's own statement is the skeleton's, unchanged.
3. **`hNEASY` dropped** from `chromaticNumber_plane_eq_chiM0` and `six_le_chiM0` (the brief's instruction).
4. **Added, each a form a later statement cites**: `not_colorable_five` and `nonempty_aeColouring_of_colorable` (the two
   axioms in this library's words), `colorable_iff_nonempty_aeColouring` (the transfer colour by colour — with N-EASY,
   an equivalence), `chiM0_six_or_seven`, `proper_to_borel_weak_model` (T's hypothesis inhabited where its conclusion
   is a theorem with no axiom — the pattern of `kloosterman_bound_model`), the release's line 19 as a named instance
   (`IsProbabilityMeasure angularMeasure`, which `Measure.prod_smul_right` needs), three `example`s reading H's
   sentence at four colours (this library's theorem), at seven (false) and the weak condition at one colour (empty),
   and four spec examples for the copied definitions.
5. **The axioms' docstrings** follow `kloosterman_bound`'s: the key, the file and line at the commit, the release's
   declaration name, where the read-back is, what the model is, the § Trust line. The skeleton's bare word "external"
   is not in them: the assumptions scan reads that word in a *former's* docstring as "undeclared assumption", and
   `ProperColoring` and `WeakColoring` are formers that are conditions (stage 4's probe).

### The leaf — the route, as proved

For measurable `d : ℂ → Fin k` let `B = {p : ℂ × Angles | d p.1 = d (p.1 + direction p.2)}`, a measurable set, and
`φ = Prod.map id (↑) : ℂ × ℝ → ℂ × Angles`. (i) `direction (θ : Angles) = Plane.e θ` (`direction_coe`:
`AddCircle.toCircle_apply_mk`, `Circle.coe_exp`), so `φ ⁻¹' B = ⋃ j, unitPairSet (d ⁻¹' {j})` **as sets** — an equality,
not the inclusion the plan asked. (ii) `map (↑) arcLength = ofReal (2π) • angularMeasure` (`map_coe_arcLength`:
`AddCircle.measurePreserving_mk` on `Ioc 0 (2π)`, `Ico_ae_eq_Ioc`, `AddCircle.volume_eq_smul_haarAddCircle` — the three
names the audit found by text all exist at the pin with the shapes it expected), hence `map φ (volume.prod arcLength) =
ofReal (2π) • volume.prod angularMeasure` (`Measure.map_prod_map`, `Measure.prod_smul_right`). (iii) So `(volume.prod
arcLength) (⋃ j, unitPairSet (d ⁻¹' {j})) = ofReal (2π) * (volume.prod angularMeasure) B`, and `ofReal (2π) ≠ 0`:
one side is null exactly when the other is; `measure_iUnion_null_iff` splits the union over the `k` colours and
`ae_iff` reads the weak condition as `B` null. 26 lines for the equivalence (statement and proof), 54 with its three
lemmas, docstrings and blank lines counted; the audit priced 60–120. The module is 316 lines. No companion was needed;
every proof elaborated at its first writing.

**The two notions meet as stated.** No null set of the wrong product and no missing measurability: the release's
`WeakColoring` asks `AEMeasurable` and T supplies `Measurable`, which is what `AeColouring` asks; the release's angle
measure is normalized and this library's arc-length has mass `2π`, a constant factor that null sets do not see.
Searched for by shape before proving (inventory item 596): no statement of the tree mentions `AddCircle.haarAddCircle`
or `AddCircle.toCircle` in the `Plane` modules, none maps `arcLength` anywhere, none relates `Colorable` to
`AeColouring`, and none bounds `chiM0` by `7` (`rg`, on `Proofs/`; the lists are in the session, the patterns:
`AddCircle|haarAddCircle|toCircle|Circle\.exp`, `map .*arcLength`, `Colorable.*AeColouring`, `chiM0 ≤`).

### The read-back, on the built module

`ModuleDump.lean` imports the built module and prints its eight declarations; `tools/fs132_i1_readback.py decls`
against the release's print (`readback/decls-module.out`), exit 0:

```
IDENTICAL  ProperColoring: def there, def here; 600 characters of term; 14 constants named
IDENTICAL  anglePeriodPositive: theorem there, theorem here; 652 characters of term; 17 constants named
IDENTICAL  Angles: def there, def here; 365 characters of term; 11 constants named
IDENTICAL  angularMeasure: def there, def here; 982 characters of term; 18 constants named
IDENTICAL  direction: def there, def here; 2254 characters of term; 28 constants named
IDENTICAL  WeakColoring: def there, def here; 4953 characters of term; 45 constants named
IDENTICAL  no_proper_five_coloring: theorem there, axiom here; 375 characters of term; 8 constants named
IDENTICAL  proper_to_borel_weak: theorem there, axiom here; 522 characters of term; 13 constants named
declarations: 8  compared: 8  identical: 8  different: 0 []
READ-BACK IDENTICAL: all 8 declarations, term for term, modulo the namespace
```

**So, of the two axioms: nothing differs.** Types, binders (names and kinds), instances, universe levels, numerals and
the six definitions they stand on are the release's, symbol for symbol; the only differences are the namespace, the
keyword (`axiom` for `theorem`/`lemma`), `scoped` on one instance and `noncomputable` written per definition.

**The instrument's controls.** (a) `--self-test` (`readback/selftest.out`): six faults planted in the print — a changed
instance, a binder kind, a numeral, a missing declaration, a kind, a renamed constant — each **FIRED**; the unplanted
pair passes. (b) A control in Lean (`readback/ControlDump.lean`, `decls-control.out`): under the module's imports and
namespace, six declarations altered in one place each — `dist x y` for `‖x - y‖`; the circle's `volume` for the
normalized Haar measure; the angle negated; `Measurable` for `AEMeasurable`; four colours for five; `[NeZero k]`
dropped — and two left as the release has them: the six read **DIFFERENT**, each at the altered place, and the two
faithful ones **IDENTICAL**. (c) The skeleton itself was the first red: seven identical and one different (stage 1).

**One step down, in the module's environment** (`readback/level1-module.out`): as stage 1 — 83 constants, 69
identical, 6 identical up to universe-parameter names, 8 different (the table of stage 1), none absent.

**What the definitions mean, as one text at both pins.** `readback/SemanticBody.lean.inc` — nine `example`s that name
nothing but the six copied definitions and Mathlib: (1) `‖z‖ = √(re² + im²)`; (2) `ProperColoring k c ↔ ∀ x y,
(x.re − y.re)² + (x.im − y.im)² = 1 → c x ≠ c y`; (3) `volume` on `ℂ` is Lebesgue measure of `ℝ × ℝ`
(`Complex.volume_preserving_equiv_real_prod`); (4) `((2π : ℝ) : Angles) = 0`; (5) `map (↑) (volume.restrict (Ioc 0
(2π))) = ofReal (2π) • angularMeasure`; (6) `direction (θ : Angles) = exp (θ i)`; (7) `Measurable c ↔ ∀ j,
MeasurableSet (c ⁻¹' {j})`; (8) for a.e.-measurable `c`, `WeakColoring k c ↔ (volume.prod angularMeasure) {p | c p.1 =
c (p.1 + direction p.2)} = 0`; (9) the product measure of a rectangle. The same text, unchanged, elaborates **at the
release's pin over the release's constants** (`ReleaseSemantic.lean`, Lean v4.34.1, exit 0, no message) and **at this
pin over the module's** (`ModuleSemantic.lean`, exit 0, no message). This is what stands in for a comparison of
Mathlib below level one: at both pins the copied definitions are characterised by the same nine sentences, down to
`ℝ`, the square root, Lebesgue measure on `ℝ × ℝ`, the exponential and the product measure on rectangles. Not
compared: those five primitives between the tags.

### The bridges, each read aloud against the sentence it will be cited for

`unitDistance V` is this library's graph on a metric space with `Adj x y ↔ dist x y = 1` (`unitDistance_adj`);
`chromaticNumber` is Mathlib's `SimpleGraph.chromaticNumber : ℕ∞`, the least `n` with a proper colouring by `Fin n`,
`⊤` if none; `Plane.chiM0` is the least `k` with an `AeColouring k` — a measurable `ℂ → Fin k` each of whose colour
classes `A` has `(volume ⊗ arcLength) {(x, θ) | x ∈ A ∧ x + e θ ∈ A} = 0`.

- **`six_le_chromaticNumber_plane : 6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber`** — cited for
  "`χ(ℝ²) ≥ 6`". Aloud: colour the points of the Euclidean plane so that no two points exactly one unit apart get the
  same colour; then at least six colours are used. The carrier, the graph and the number are row 33's
  (`chromaticNumber_plane_interval`), so the two statements differ in the numeral alone. ✓
- **`chromaticNumber_plane_six_or_seven`** — cited for "`6 ≤ χ(ℝ²) ≤ 7`", row 33 with its lower end moved. Its
  second half is `chromaticNumber_plane_interval.2`, this library's own; its first half rests on H. ✓
- **`chiM0_le_chromaticNumber_plane : Plane.chiM0 ≤ (unitDistance ℂ).chromaticNumber`** — cited for
  "`χ_m⁰(ℝ²) ≤ χ(ℝ²)`", the half of row 130 held given MR. Aloud: if `k` colours suffice for a colouring of the plane
  with no two points one unit apart alike, then `k` colours suffice for a measurable colouring in which almost every
  unit pair is bichromatic. The plane is `ℂ` here, as in every `Plane` module; `chromaticNumber_plane_eq_complex`
  moves the left side to row 33's carrier. ✓
- **`chromaticNumber_plane_eq_chiM0 : (unitDistance ℂ).chromaticNumber = Plane.chiM0`** — cited for
  "`χ(ℝ²) = χ_m⁰(ℝ²)`, with no hypothesis". It has no binder. On `fs131-w9`, `Plane/Reduction/Basic.lean`:
  `def Row130Collapse : Prop := (unitDistance ℂ).chromaticNumber = chiM0` (read by `git show`, that branch not
  merged) — the same equation in the same orientation, so at that wave's join `Row130Collapse` is
  `chromaticNumber_plane_eq_chiM0` by `Iff.rfl`/`id`. It rests on T and not on H. ✓
- **`six_le_chiM0 : 6 ≤ Plane.chiM0`** — cited for "`6 ≤ χ_m⁰(ℝ²)`" (FS-104's question, answered yes). Aloud: a
  measurable colouring of the plane proper at almost every unit pair uses at least six colours. It rests on H and
  N-EASY, and **not** on T: the transfer is not needed for it. ✓
- `colorable_iff_nonempty_aeColouring` — "the transfer to measurable colourings", colour by colour: for each `k`,
  the plane has a proper `k`-colouring iff it has a measurable `k`-colouring proper at almost every unit pair. ✓
- **The third item, run**: `example : ∃ d : ℂ → Fin 7, Measurable d ∧ WeakColoring 7 d` by `proper_to_borel_weak`
  applied to `exists_properColoring_seven`'s colouring; and `proper_to_borel_weak_model`, the same conclusion with
  no axiom, from `Plane.r7_aeColouring`.

**Which bridges do not need the leaf**: `not_colorable_five`, `six_le_chromaticNumber_plane`,
`chromaticNumber_plane_six_or_seven`, `six_le_chiM0`, `chiM0_six_or_seven` — the five on H; they use
`properColoring_iff_colorable` and N-EASY only. The four on T go through the leaf. The leaf is proved, so the
distinction is for the record.

### Builds

`data/fs132/i1/build-1-module.log`: exit 0, "471 of 471 batches, 2 module(s) rebuilt, 0 module(s) with warnings"
(`Outside.OAI158` 1.8 s, `Proofs` 1.6 s). Two docstrings then gained their inhabitant notes;
`data/fs132/i1/build-2-final.log` is the build of the module as committed (its last lines are quoted in stage 3).

## Stage 3 — SAVED (FS132-I1): the registrations, the probes, the guarded lint

Everything below is on this branch's tree: base `8386c256`, the module as committed in stage 2 (`8bb6ba9d`).
`main` has moved since the cut (67 commits at this writing, wave 8's landing among them); a landing re-runs each
probe on the joined tree, and the counts it files are its own. What transfers is the **difference** this job makes.

| check | command (each under `scripts/slot.py`) | result | saved |
|---|---|---|---|
| the build, as committed | `--mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` | **exit 0** — "471 of 471 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 8m31s" (`Outside.OAI158`, `Proofs`) | `data/fs132/i1/build-2-final.log` |
| the module map | `python3 tools/check_architecture.py` | **exit 0**, `RESULT: PASS`: 295 modules, 295 rows, 0 import mismatches (before the row: exit 1, "missing: ['Outside/OAI158']" — the check's own red, seen) | `arch-0-baseline.out`, `arch-1.out` |
| doubled names | `--mem 16 -- ./scripts/dupnames.sh` | **exit 0** — "no name is declared by two modules (23 generated on demand)"; 1832 modules scanned, 1832 source files; the new module is in none of the 23 | `probes/dupnames.out`, `dupnames-full.log` |
| this block's axioms | `tools/fs132_i1_axioms.py emit` → `lake env lean` → `check` | **exit 0** — 21 records as filed: 12 clean, 5 on H alone, 4 on T alone | `axioms/module.out`, `module.check` |
| — its control, a planted `sorry` | `direction_coe`'s proof replaced by `sorry` in a copy | **FIRED**: the ten records above it refused (`carries sorryAx`), the other eleven pass | `axioms/control-sorry.*` |
| — its control, a wrong filing | `six_le_chiM0` proved through the collapse in a copy | **FIRED**: `six_le_chiM0`, `chiM0_six_or_seven` refused ("filed on no_proper_five_coloring alone; carries [both]"), nineteen pass | `axioms/control-both.*` |
| the axiom audit, once, as a probe | `--mem 24 -- ./scripts/axioms.sh` | **exit 0** — "audited: 6355 records — 6316 clean on the standard axioms, 17 axiom-free, 17 imported, 5 declared purchase(s)"; "declared imports: 3; library axioms other than native auxiliaries: 3, every one declared" | `probes/axioms.out`, `axioms-receipt.log` |
| the assumptions audit, once, as a probe | `--mem 16 -- ./scripts/assumptions.sh` | **exit 1, nine failures, one kind**: `unlisted-consumer` for the nine `RESTS` rows of the two new axioms (the ledger is the landing's file). The scan itself: `fails=0`, `hints=0`; `axioms=3 rests=17 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` | `probes/assumptions.out`, `assumptions-receipt.log` |
| the guarded lint, after the last build | `--mem 8 -- lake lint --no-build -- --no-build --trace` | **exit 0** — "-- Linting passed for Proofs."; 14 linters, 14 "(2/2) Passed!" | `probes/lint.out` |

**The audit accepts two more declared imports.** Against `main`'s recorded counts (6,334 records: 6304 clean, 17
axiom-free, 8 imported, 5 purchases): **+21 records — +12 clean, +9 imported, axiom-free and purchases unmoved**; the
digest's own line: "RECORDED COUNT IS STALE in CLAUDE.md § Trust ledger — update it: 6304 clean → 6316, 8 imported →
17". The receipt prints `DECLARED IMPORT` three times and `LIBRARY SUMMARY axioms=3 native=10`.

**The assumptions scan asks for no line of `scripts/Assumptions.lean`.** Its rows naming the module are the two
`AXIOM … ref=bib:OAIMath2026` rows (theorems=5 and 4) and the nine `RESTS` rows; no `FAIL` of the scan, no `HINT`, no
`SILENT`, no `CONDITION`. `ProperColoring` and `WeakColoring` are formers taken as hypotheses and each is concluded by a
theorem with no assumption (`exists_properColoring_seven`; `weakColoring_of_aeColouring`), which is why the scan does
not ask whether they are assumptions. Against the last landed receipt (`data/fs131/lt5/gate/receipt-assumptions-
landed2.log`): constants 13795 → 13826, theorems 10173 → 10197, formers 303 → 305, hypotheses 17192 → 17198, closed
1473 → 1473, `unseen` 15214 → 15219, **axioms 1 → 3, rests 8 → 17**, every other total unmoved.

**Not run by me** (the landing's, on the joined tree): `./scripts/axioms.sh --self-test`, `./scripts/assumptions.sh
--self-test` and `--write-ledger`, `./scripts/vacuity.sh`, `./scripts/dupnames.sh --self-test`, the whole gate.

**At the join** (a dry run, `git merge-tree origin/main HEAD`, nothing merged): `Proofs.lean` and
`scripts/Axioms.lean` merge by themselves; **`ARCHITECTURE.md` conflicts in one place**, the end of § 3 — `main` added
rows to § 3.11's table where this branch adds § 3.12. Both are kept: `main`'s rows, then § 3.12.

## Drafts for the front page

Counts are this tree's (base `8386c256`); the landing replaces each with the joined tree's, and the differences are:
audit +21 records = +12 clean +9 imported; assumptions `axioms` +2, `rests` +9.

1. **`scripts/Assumptions.lean`, `AssumptionAudit.declared`** — *no line*. **`scripts/assumptions-ledger.txt`** — by
   `./scripts/assumptions.sh --write-ledger`, which adds exactly these nine rows (sorted into place) and rewrites the
   header's count line to the joined tree's nine counts:
   ```
   RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.chiM0_six_or_seven
   RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.chromaticNumber_plane_six_or_seven
   RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.not_colorable_five
   RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.six_le_chiM0
   RESTS HadwigerNelson.Outside.OAI158.no_proper_five_coloring HadwigerNelson.Outside.OAI158.six_le_chromaticNumber_plane
   RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.chiM0_le_chromaticNumber_plane
   RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0
   RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.colorable_iff_nonempty_aeColouring
   RESTS HadwigerNelson.Outside.OAI158.proper_to_borel_weak HadwigerNelson.Outside.OAI158.nonempty_aeColouring_of_colorable
   ```
2. **`CLAUDE.md` § Trust ledger, first paragraph** — *replacing* "the current audit reads 6304 clean and 5 declared
   purchases, and 8 imported (and 17 axiom-free; 6,334 records at wave 10's second landing, FS131-L10B, 2026-10-06)"
   *with* "the current audit reads 6316 clean and 5 declared purchases, and 17 imported (and 17 axiom-free; 6,355
   records at FS-132's import, FS132-I1, 2026-10-07)"; *and replacing* "The library declares one outside axiom,
   `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read against its page by
   two readers — and the eight imported records are the theorems that rest on it;" *with* "The library declares three
   outside axioms: `StandingFive.kloosterman_bound` — Weil's bound for Kloosterman sums, `[Weil1948]` p. 207, read
   against its page by two readers — with eight imported records; and, from `[OAIMath2026]` family 158, a Lean
   development audited here at its own pin, `Outside.OAI158.no_proper_five_coloring` — no map `ℂ → Fin 5` separates
   every unit pair — with five, and `Outside.OAI158.proper_to_borel_weak` — a proper `k`-colouring of the plane gives a
   Borel one proper at almost every unit pair — with four; each of the two is the release's stored statement term for
   term (`tools/fs132_i1_readback.py`);". The sentence "Rung B holds none." stands.
3. **`CLAUDE.md` § Trust ledger, second paragraph** — *replacing* "`axioms=1 rests=8 named=19 inline=16 outside=7
   ours=23 open=5 takes=98 mentions=1` — one outside theorem declared as an axiom, with eight theorems resting on it;"
   *with* "`axioms=3 rests=17 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside
   theorems declared as axioms, with seventeen theorems resting on them;". The rest of the paragraph stands
   (thirty-five hypotheses, 98 pairs, 51 statements: none moved).
4. **`LEAN.md` § Assumptions, item 2 of "An imported theorem carries four things"** — *after* "(`StandingFive.
   kloosterman_bound`, with `kloostermanBound_of_ringChar_ne_two` and `kloosterman_page_of_kloostermanBound`)" *add*:
   "Where the source is itself Lean, copy its definitions, state the axiom over the copies, and compare the stored
   terms across the two pins — every constant, instance, binder and universe level — with a control that fires
   (`Outside.OAI158`; `tools/fs132_i1_readback.py`, on a print made at each pin by one dumper)."
5. **`LEAN.md` § Searching — Lean** — *a new line*: "Which instance a term is elaborated with depends on the imports,
   and equal text can store different terms: `volume : Measure ℂ` takes the proof `Complex.instFiniteDimensionalReal`
   of `FiniteDimensional ℝ ℂ` where `Mathlib.LinearAlgebra.Complex.FiniteDimensional` is imported and
   `FiniteDimensional.rclike_to_real` where it is not — equal by proof irrelevance, not symbol for symbol. A statement
   copied from another library is compared as the kernel stores it, never as text (FS132-I1)."
6. **`LEAN.md` § Trust ledger** — no row changes; its table already has "an `axiom` importing an outside theorem".
7. **`tools/claude_md_fact_audit.py`, `GATE_CHANGES`**, after the last entry — on this tree's counts:
   `(("6304", "5"), ("6316", "5")): "FS-132's import of [OAIMath2026] family 158 (FS132-I1; copy data/fs132/i1/probes/axioms-receipt.log, on fs132-wi1 at 8bb6ba9d): 6,355 records, 6,316 clean, 17 axiom-free, 17 imported, 5 purchases",`
   — at a landing after wave 8 the pair is `(<main's clean count then>, <that + 12>)` and the receipt the landing's.
8. **`ARCHITECTURE.md`** — filed on this branch (§ 3.12; § 5 Trust, two rows, "Three at present").
9. **`LEDGER.md` rows 33 and 130, `BIBLIOGRAPHY.md` `[OAIMath2026]`** — the audit's drafted sentences
   (`plans/EXT-OAI1-audit.md` stage 8, last section) name declarations that now exist exactly as it wrote them:
   `Outside.OAI158.no_proper_five_coloring`, `chromaticNumber_plane_six_or_seven`,
   `Outside.OAI158.chromaticNumber_plane_eq_chiM0`. *To add to row 130's sentence*: "colour by colour:
   `colorable_iff_nonempty_aeColouring`"; *to row 33's*: "and `6 ≤ χ_m⁰(ℝ²) ≤ 7` (`chiM0_six_or_seven`)". *To the
   bibliography row's third cell*: "Imported by FS132-I1 as two declared outside theorems (`Outside/OAI158`); the
   stored statements compared term for term across the pins (`plans/FS132-I1-implementation.md`)."
10. **The grade.** These are not regraded to [kernel]: `6 ≤ χ(ℝ²)` and `χ(ℝ²) = χ_m⁰(ℝ²)` are held **on a declared
    outside theorem each**, kernel-checked from there. What is [kernel] with no import is the dictionary
    (`weakColoring_iff_unitPairsNull`, `properColoring_iff_colorable`) and the models.

## What was checked, and by whom

**By the kernel at this pin (the build, exit 0):** every theorem of the list at the top, on the axioms printed beside
it; the eight copied declarations elaborate; the nine characterisations (`ModuleSemantic.lean`, `lake env lean`).
**By the kernel at the release's pin (Lean v4.34.1, `lake`-free, nothing written there):** the same nine
characterisations over the release's constants; the release's eight declarations exist with the printed terms.
**By my instruments, each with a control seen to fire:** the 24 quotations; the eight stored terms equal across the
pins; the 21 records' axiom sets as filed. **By reading, one mind:** the level-one table's eight differences; the
release's scope lines; that the docstrings say what the statements say.
**By nobody here:** Mathlib between the tags below the constants the statements name (and the five primitives the
characterisations bottom out in); the release's proofs as mathematics (the audit's list stands); the audit scripts'
self-tests, the vacuity scan and the whole gate on a joined tree.
