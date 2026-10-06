# FS131-T4 — the gate's doubled-name check, and what Lean does with one name declared by two modules

*Record of job FS131-T4 (de Bruijn, the implementer; a tooling job). Brief: `data/fs131/briefs/FS131-T4-dupnames.md` (on `main`; it was
committed after this branch was cut, so it is read from the main checkout). Branch `fs131-t4`, worktree
`.claude/worktrees/fs131-wop`. Toolchain `leanprover/lean4:v4.32.0`.*

## Theorems this phase proved

None. This is a tooling job: it adds no declaration under `Proofs/` and changes none.

## What the job found, in five lines

1. **`#print axioms` and the kernel read different copies of a doubled name.** For a theorem declared under one name and type by two
   modules, neither importing the other, the environment keeps the constant of the module imported **last**, and `#print axioms`
   reads the axiom list stored by the module imported **first**. Measured, twelve scenarios (§ Stage 2).
2. **So a print can be clean over a `sorry` the environment holds**: clean copy imported first, `sorry` copy last (S2/TopBA). The
   same with a copy resting on a declared axiom (S3) or on `native_decide` (S7).
3. **Hygiene, not soundness — by argument, not by experiment** (§ 2.4): a clean stored list belongs to a copy that is a clean proof
   of the same type. What is lost is the audit's faithfulness to the term the environment holds.
4. **`main`'s library holds one doubled name, `HadwigerNelson.Plane.conj_e`**, both copies on the standard three, each read where
   it was compiled; and 22 names Lean generates on demand in several modules, which are not failures (§ Stage 3). No audited print
   is affected.
5. **The check**: `scripts/DupNames.lean` with `scripts/dupnames.sh` (§ Stages 3–4).

## Stage 1 — SAVED (FS131-T4): the readback, the as-given build

### 1.1 The brief's quotations against their sources (standing rule 3)

`python3 tools/fs131_t4_readback.py --plant` → exit 0: **10 quotations read, 10 found verbatim** (each is the start of a line of its
source, whitespace runs collapsed); with one character of each changed in memory, all 10 `MISMATCH` (the control). Sources: `CLAUDE.md`
§ The standard of evidence; `plans/FS131-close-inventory.md` items 443, 458, 459; `Proofs/HadwigerNelson/Plane/Chord.lean` l. 276 and
`Plane/SixFragment.lean` l. 342 (`conj_e`, one statement); `Lean/Environment.lean` (v4.32.0) `subsumesInfo` and its two theorem
cases; FS131-M7's § 6.3 heading (`fs131-w5c`'s `plans/FS131-M7-sync.md` l. 476). **No mismatch.**

One note on the brief, not a defect of a quotation: the brief file is not on this branch (cut from `95194481`; the brief is commit
`d16431db` on `main`), so the readback tool reads it from the main checkout and prints the path it used.

### 1.2 Read for this job

- The importer, `Lean/Environment.lean` l. 2195–2310, whole: `subsumesInfo` and `finalizeImport`. Two maps with two rules — the
  constant map keeps the **new** constant when it subsumes the old (l. 2279–2280), and `const2ModIdx` is `insertIfNew` (l. 2283), so
  the module a name is attributed to is the **first** to declare it. FS131-M7 had noted the two maps; neither it nor the brief had
  the next file in view.
- **`Lean/Util/CollectAxioms.lean`, whole — the file that decides the experiment.** `collectAxioms` does not walk an imported
  constant's body. Each module writes, with its `.olean`, an axiom list per declaration (`exportedAxiomsExt`, "computed once …
  when the olean is serialized"), and a downstream lookup goes through `env.getModuleIdxFor? c`: "axiom collection never crosses
  module boundaries".
- `Lean/ResolveName.lean` (`isReservedName`) and `Lean/Elab/DeclModifiers.lean` l. 45 ("is a reserved name"): the class of names
  Lean generates on demand, which no author can declare by hand.
- FS131-M7's § 6.3 and its scanner `tools/fs131_m7_dupes.py` (textual; its NORM-TWICE class has the false-pair defect it states).
- The gate's two Lean-side steps as models: `scripts/Axioms.lean` with `scripts/axioms.sh` and `scripts/axioms-controls.txt`;
  `scripts/Vacuity.lean` with `scripts/vacuity.sh`; `scripts/gate-log.sh`; `scripts/gate_report.py` (its two digests).
- `plans/STANDING-RULES.md`, `LEAN.md` in full, `RUNNING.md` § Building and § Make the gate fail, and watch it fail.

### 1.3 The as-given build

`scripts/slot.py --mem 16 --cpus 8 -- env MEMMAX=16G ./scripts/build.sh` → exit 0, `data/fs131/t4/logs/build-as-given.log`:
"All targets up-to-date (5750 jobs)", "all 1767 modules already up to date, nothing built, 0 module(s) with warnings, 2s". And
`git diff --stat HEAD origin/main -- Proofs Proofs.lean` is empty against `origin/main` at `50cf44ec`: this tree's library is `main`'s.

## Stage 1 — SAVED (FS131-T4)

## Stage 2 — SAVED (FS131-T4): the experiment

### 2.1 The instrument

`tools/fs131_t4_experiment.py` writes the scratch package `data/fs131/t4/exp/` (core Lean only, 172 files, on the repository's
toolchain file), builds its leaf modules with `lake` there, elaborates 120 consumers, and writes each one's output under
`data/fs131/t4/exp-out/` and the table **`data/fs131/t4/experiment-table.md`** — the table is the result; what follows is its reading.
Twelve scenarios, each two sibling modules `A` and `B` declaring one name, and ten consumers: each sibling alone (the partners), both in
each order with a theorem `down` declared in the consumer, a module `UseA` / `UseB` compiled against one sibling alone and then
imported beside the other in each order, and one sibling imported with the other's declarations written in the file ("one module
upstream of the other"). A probe command in each consumer reads the environment's own data: which modules' compiled data declare the
name, which copy the environment holds (each clean copy's proof is a marker theorem named for its module), the module the environment
attributes the name to, the axioms `collectAxioms` reports, and the axioms of the value actually held.

Run: `scripts/slot.py --mem 4 --cpus 4 -- python3 tools/fs131_t4_experiment.py` → exit 0, 120 consumers, 0 problems
(`data/fs131/t4/logs/experiment-run1.log`). `--check` re-runs everything and compares with the committed files: 145 outputs and the
table, 0 differ. `--plant`: two faults planted in the probe, each caught by the check written for it — a probe that calls every
declaring module's copy the held one (3 problems, "held copy and the held value's axioms disagree about `sorry`"), and a probe that
reports no axioms for the name (1 problem, "the partner's two axiom readings differ"). `lake build` of each `Top` module agrees with
`lake env lean` on the status and on the axioms printed, so the result is not an artefact of running a file outside Lake.

**The key row with no instrument of mine in the file** (run by hand before the tool was finished): a file `import T4Exp.S2.B` (clean),
`import T4Exp.S2.A` (`sorry`), `theorem down : 2 + 2 = 4 := T4.S2.dup`, then three plain commands printed
`'down' does not depend on any axioms`, `'T4.S2.dup' does not depend on any axioms`, and, from `#print T4.S2.dup`,
`theorem T4.S2.dup : 2 + 2 = 4 := sorry`.

### 2.2 What the table shows

| | scenario | importing both | the environment holds | `#print axioms` of the name reads |
|---|---|---|---|---|
| S1 | (i) both clean | builds | the **last**-imported copy | the **first**-imported module's list |
| S2 | (ii) one `sorry` | builds | the last-imported copy | the first-imported module's list |
| S3 | (iii) one through a declared `axiom` | builds | the last-imported copy | the first-imported module's list |
| S4 | (iv) one an `axiom` of the name, one a theorem | builds | **the theorem, in either order** | the first-imported module's list |
| S5 | (v) the types differ | **`import … failed, environment already contains 'T4.S5.dup' from …`** | — | — |
| S6 | both `axiom`s of one proposition | builds | (the copies are indistinguishable) | `[the axiom]` |
| S7 | one by `native_decide` | builds | the last-imported copy | the first-imported module's list |
| S8 | one type up to bound-variable names | builds | the last-imported copy | the first-imported module's list |
| S9 | a `Prop`-valued instance, generated name `instNonemptyTok` | builds — **the kernel holds it as a theorem** | the last-imported copy | the first-imported module's list |
| S10 | a data-valued instance, generated name, one body | `environment already contains` | — | — |
| S11 | two `def`s, one name, type and body | `environment already contains` | — | — |
| S12 | an equation lemma generated on demand in both (`T4.fn.eq_1`) | builds | (the copies are identical) | either |

Read off the rows (each a line of the table, each with its output file):

1. **Which copy is kept**: theorem over theorem, the last-imported (S1–S3, S7–S9, both orders); theorem over axiom, the theorem
   whichever comes first (S4).
2. **Which module the name is attributed to** (`Environment.getModuleIdxFor?`): always the first-imported.
3. **`#print axioms` of the name**: the first-imported module's stored list — so, for two theorems, **never the copy the environment
   holds**. S2/TopAB (`sorry` first): prints `[sorryAx]`, holds the clean proof. S2/TopBA (clean first): prints clean, holds `sorry`.
4. **`#print axioms` of a theorem declared downstream that uses the name** (`down`): follows 3 — clean over a held `sorry` in
   S2/TopBA, over a held axiom-resting copy in S3/TopBA, over a held native purchase in S7/TopBA.
5. **`#print axioms` of an imported theorem** (`useA`, `useB`): the list stored when *its* module was compiled — the copy it was
   compiled against, whatever else is imported and in whatever order. `useA` (compiled against the `sorry` copy) prints `[sorryAx]`
   in both orders, also where the environment holds the clean copy (S2/UseA_B); `useB` prints clean in both orders, also where the
   environment holds the `sorry` copy (S2/UseB_A).
6. **An `axiom` shadowed by a theorem of its name** (S4): the environment holds the theorem, so the axiom is not among the
   environment's constants at all; the print follows import order (`[T4.S4.dup]` when the axiom's module is first, though a theorem
   is held; clean when the theorem's is).
7. **One module upstream of the other**: every hand-written pair is the elaboration error `` `…` has already been declared `` —
   theorem over theorem, theorem over axiom and axiom over theorem, axiom over axiom, `def` over `def`, and with types differing
   (S1–S8, S11, both directions). Two things are not errors: a second **anonymous instance** gets a fresh name
   (`instNonemptyTok_1`, `instInhabitedTok_1`: S9, S10 — two instances then stand, under two names), and a generated equation
   lemma already imported is reused (S12).
8. **The build's only sign of a `sorry` copy** in the consumer: Lake replays the `sorry` module's own warning
   (`data/fs131/t4/exp-out/S2/TopBA.lake-build.out`: ``warning: T4Exp/S2/A.lean:5:8: declaration uses `sorry` ``, "Replayed
   T4Exp.S2.A"); the consumer itself raises none.

### 2.3 Against the two readings

- **Ruling 459 (a)** (`plans/FS131-close-inventory.md`): "a `#print axioms` downstream follows the copy the importer kept (the later
  one, when it subsumes)". **Contradicted**: it follows the first-imported module's stored list (rows 3–4), and for an imported
  theorem the list stored at that theorem's own compile (row 5). The coordinator was messaged when S2/TopBA was read and has
  withdrawn the reading (its inventory item 462).
- **FS131-M7 § 6.3**: "with one copy `sorry` and one proved, a downstream `#print axioms` could follow either (read from the
  importer's code; I did not test such a pair, and the module a constant is attributed to and the copy kept are held in two maps with
  different rules)". **Right as far as it goes, and it named the two maps**; what it did not have is that the print reads a stored
  list through the attribution map, which is what makes the print and the kept copy *always* differ for two theorems.
- M7's "the build catches a doubled theorem only when one declaring module is upstream of the other": **confirmed** (row 7), with the
  two exceptions there.

### 2.4 Hygiene or soundness

**Hygiene, by argument; the experiment cannot show it.** What the experiment shows is narrower: in every row where a print is clean,
a clean copy exists (the partners `OnlyA` / `OnlyB` show the `sorry` copy alone printing `[sorryAx]`, so the print can show it). The
argument, one mind, [hand]: only theorems and axioms can be merged at import, and only with one type (S5, S10, S11 are errors), so
every definition is the same constant in every environment that holds it. Claim: for each copy of each constant, its type is provable
from the axioms in the list its module stored. By induction along the import graph and, inside a module, along dependencies: the list
is the union, over the constants the copy's proof uses, of their lists — local ones walked, imported ones read from the module the
name is attributed to; that copy has the same type as the copy the kernel checked the proof against; so each used statement is
provable from its list, and so is this one. Hence a clean print never certifies a statement with no clean proof in the library.
**What a doubled name does break**: the print is not about the proof term the environment holds, and "resting on `sorry`" or
"resting on a purchase" can be hidden from the axiom audit by import order.

### 2.5 What the gate's other steps would and would not have seen

Of a pair with one copy not clean, by the rows above (not each tested against the gate's scripts):

- **the axiom audit** (`scripts/Axioms.lean`): each record prints a stored list — the name's own record, the first-imported
  module's; a consumer's, its own module's. It can print clean over a held `sorry` or purchase (rows 3–5).
- **`AxiomAudit.libraryAxioms`** walks the environment's constants: an `axiom` shadowed by a theorem of its name is not there
  (row 6), so "every axiom the library declares" would miss it. An axiom a `sorry`-free copy rests on (S3's `axA`) is still listed.
- **the `sorry` check by `grep`** and **the build's warning** read the source and each module's own compile, and see a `sorry` copy
  whatever is imported (row 8).
- **the vacuity scan** and **the linters** walk the environment's constants: one row per name, the held copy.

## Stage 2 — SAVED (FS131-T4)

## Stage 3 — SAVED (FS131-T4): the scan, and its first run on `main`'s library

*Done ahead of the tool's wrapper and controls at the coordinator's word (its message after S2/TopBA: the scan on `main` first).*

### 3.1 The scan

`scripts/DupNames.lean` (`import Proofs`, then `#eval DupNames.scan #[`Proofs]`). It reads **each imported module's own compiled
constants** (`env.header.moduleData`), before the importer merges them — walking the environment's constants cannot work, since the
environment holds one copy. It reports every name declared by a module of the package and by any other imported module, of the
package or of a dependency; a name shared by two dependencies' modules and by none of ours is not reported. Per name: `DOUBLED` or
`GENERATED`, then one `COPY` line per declaring module in import order — kind, whether it is the copy the environment holds, whether
its module is the one the name is attributed to, and the axioms of that copy's own type and proof.

**The one exclusion, and its justification.** `GENERATED` = the name is a **reserved name** (`Lean.isReservedName`), every copy is a
theorem, and all copies have one type. These are the theorems Lean generates on demand in whichever module first asks (`f.eq_1`,
`f.congr_simp`, …) — the importer's own stated reason for merging theorems (`subsumesInfo`'s comment: "We want to generate
equational theorems on demand and potentially in different files"). No author can enter the class by choosing a name: measured,
`theorem T4.fn.eq_1 : True := trivial` is the error `` `T4.fn.eq_1` is a reserved name ``. The class is counted and listed, never
silent, and a member whose copies' axioms differ still fails (none does today).

### 3.2 The first run

`scripts/slot.py --mem 16 --cpus 8 -- lake env lean scripts/DupNames.lean` → exit 0; `data/fs131/t4/logs/dupnames-first-run.out`:

```
SCANNED modules=7257 package-modules=1767 package-constants=18081 other-constants=503787
DOUBLED HadwigerNelson.Plane.conj_e :: modules=2 types=same axioms=same reserved=false
COPY HadwigerNelson.Plane.conj_e :: Proofs.HadwigerNelson.Plane.Chord kind=theorem held=false attributed=true package=true axioms=[propext, Classical.choice, Quot.sound]
COPY HadwigerNelson.Plane.conj_e :: Proofs.HadwigerNelson.Plane.SixFragment kind=theorem held=true attributed=false package=true axioms=[propext, Classical.choice, Quot.sound]
TOTALS doubled=1 generated=22 generated-axioms-differ=0
```

- **One doubled name: `HadwigerNelson.Plane.conj_e`**, in `Plane/Chord` and `Plane/SixFragment`. Under `import Proofs` the environment
  holds `SixFragment`'s proof and `#print axioms` reads `Chord`'s list. **No second pair**: no instance, no derived or macro-made
  declaration, no name shared with Mathlib. FS131-M7's textual finding stands, now from the kernel's side.
- **Each copy where it was compiled** (`data/fs131/t4/conj-e/OnlyChord.lean`, `OnlySixFragment.lean`, each importing its module alone;
  outputs beside them): both print `[propext, Classical.choice, Quot.sound]`; the two proof terms differ (`rw [e, e, …]` against
  `unfold e`).
- **22 generated names**, in two to six modules each: 17 `….eq_1` / `….eq_2`, 5 `….congr_simp`; every copy a theorem, one type, the
  copies of each identical (every `COPY` line reads `held=true`), their axioms equal. Four are for dependencies' definitions; three
  of those have a copy in a Mathlib or Std module (`Nonempty.some.congr_simp`, five Mathlib modules and one of ours;
  `LinearEquiv.toContinuousLinearEquiv.congr_simp`; `Std.Sat.CNF.Clause.eval.eq_1`), and `SimpleGraph.Coloring.mk.congr_simp` has
  both copies in ours. (My message to the coordinator said all four have a dependency's copy: a slip, three do.)
- `package-modules=1767` is every module of the library (the build's count, § 1.3).

### 3.3 Could the pair have changed a filed count?

**No.** The axiom audit holds one record for the doubled name (`scripts/Axioms.lean` l. 2748, `#print axioms
HadwigerNelson.Plane.conj_e`): it prints the list `Chord` stored while the environment holds `SixFragment`'s proof, and both are the
standard three, so the record is in the right section either way; every record downstream of `conj_e` reads lists built from one or
the other, the same three. The vacuity scan's `declarations=` counts names of the environment (`isOurs` goes through
`getModuleIdxFor?`), so the pair is one declaration there, and making it one declaration in a shared module leaves the count where it
is. **What would have moved a count**: a pair with one copy not clean (§ 2.5).

## Stage 3 — SAVED (FS131-T4)
