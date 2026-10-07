# FS132-I1 — the import of `[OAIMath2026]` family 158: two declared outside theorems, the measure bridge, and the forms this library cites

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I1-import.md` on `main` at `fda06767`.
Branch `fs132-wi1`, cut from `main` at `8386c256`; worktree `.claude/worktrees/fs132-wi1`. Working files: `data/fs132/i1/`.
Tools: `tools/fs132_i1_quotes.py`, `tools/fs132_i1_readback.py`.*

## Theorems this phase proved

*(filled at the stage that proves them; stage 1 proved none)*

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
