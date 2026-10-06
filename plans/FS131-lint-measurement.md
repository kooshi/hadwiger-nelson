# FS131-LN1 — the environment linters over `main`, measured

*The record of job FS131-LN1 (de Bruijn, the implementer). Brief: `data/fs131/briefs/FS131-LN1-lint.md`. Branch `fs131-wop`, which is
`main`'s line. Everything this record cites is under `data/fs131/ln/`.*

## Theorems this phase proved

None. This is a measurement job: it proves no theorem and changes no declaration of the library.

## Stage 1 — SAVED (FS131-LN1)

*2026-10-06T03:20Z (2026-10-06 03:20 UTC). Tree: `.claude/worktrees/fs131-wop` at `333ecaa1`.*

### What I may and may not change

- **May write**: this record; `tools/fs131_ln_*.py`; `data/fs131/ln/`; `data/fs131/reports/FS131-LN1.md`.
- **May edit, for the planted control only**: one library file of my choice, restored byte for byte (checksum before and after) before
  anything is committed. The plant is never committed.
- **May not change**: any other file under `Proofs/`; `scripts/`; `lakefile.toml`; the shared `.lake/packages` (every worktree's
  `.lake/packages` is a symlink to `/home/kooshi/source/lean-dir/.lake/packages`); `main`. No statement, no docstring, no `nolint`:
  the job fixes nothing.
- **May not run**: `lake build`, bare or named. Builds go through `scripts/build.sh` under `scripts/slot.py`. `lake lint` is the one
  Lake command this job runs, and it must not rebuild anything.

### The readback

Every quotation of the brief, checked against its source by `tools/fs131_ln_quotes.py` (a quoted line must occur character for
character inside one line of the source file):

| brief line | source | verdict |
|---|---|---|
| 30 | `plans/FS131-close-inventory.md:3726` (item 414) | verbatim |
| 33 | `plans/FS131-close-inventory.md:3748` (item 415) | verbatim |
| 40 | `LEAN.md:162` | verbatim |
| 43 | `lakefile.toml:4` | verbatim |
| 46 | `lakefile.toml:9` | verbatim |
| 49 | `data/crunch-2026-09-25/briefs/J23b-M2-close-math.md:24` | verbatim |
| 52 | `data/crunch-2026-09-25/briefs/J23b-M2-close-math.md:26` | verbatim |
| 55 | `data/crunch-2026-09-25/reports/J23b.md:2` | verbatim |
| 60 | `data/fs73/records/phase-P5.md:124` | verbatim |

9 quoted lines, 9 found verbatim, 0 missing (`data/fs131/ln/quotes.txt`, exit 0). **The check's control**
(`--self-test`, `data/fs131/ln/quotes-selftest.txt`, exit 0): one character altered in each quoted line in turn, 9 plants, each
reported alone at its own line; a brief with no quotation fails ("nothing was checked") instead of passing.

One thing the brief's header says that the quotations do not carry: the brief is dated 2026-10-06 and this session's clock reads
2026-10-06 03:20 UTC, which is 2026-10-06 03:20 UTC. The two agree under inventory item 415 (a): dates are the gate logs' UTC date.

### The tree

- `git merge --ff-only origin/main`: `7189bdcf..333ecaa1`, fast-forward. The five files it brought are `CLAUDE.md`, the brief,
  `plans/FS131-close-inventory.md`, `plans/SESSION-HANDOFF-2026-10-04.md` and `tools/claude_md_fact_audit.py`: nothing the build reads.
- **The build, once, under the slot** (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): exit 0,
  read from the tool into `data/fs131/ln/build-readback.exit`. The slot waited (the ledger held 80 GiB in two other trees' builds
  against a budget of 90) and then admitted it. `==> build: OK — all 1767 modules already up to date, nothing built, 0 module(s) with
  warnings, 2s`; the gate log is `All targets up-to-date (5750 jobs).` (`data/fs131/ln/build-readback.out`,
  `data/fs131/ln/build-readback.gate.log`, a copy of `build/gate/build/20261006T031956Z-517785.log`).
- The built root module names the newest landing: `.lake/build/lib/lean/Proofs.olean` contains the string `OpenMove`.

### How the linters run here, read from the source before running them

`lake lint` (Lake 5.0.0, `$(lean --print-prefix)/src/lean/lake/Lake/CLI/Main.lean:1057`, `Lake/CLI/Actions.lean:89`) does two things.

1. **It asks Lake to build the driver** — `runBuild exe.fetch buildConfig` on the executable `batteries/runLinter` — and then runs
   that binary with `lintDriverArgs` (`["Proofs"]`) and whatever follows `--` on the command line. This is the one place Lake itself
   can start compiling: if it judges the driver, or a Batteries module the driver imports, out of date, it rebuilds into the shared
   `.lake/packages/batteries/.lake/build`. Lake's own `--no-build` option reaches this call (`noBuild := opts.noBuild`,
   `Main.lean:137`): with it Lake exits instead of building.
2. **The driver** (`.lake/packages/batteries/scripts/runLinter.lean:100–176`) looks for `Proofs.olean` and
   `Batteries/Tactic/Lint.olean`; if either is missing it spawns `lake build +<module>` — the second place a build can start, and the
   one that would build the library outside `scripts/build.sh`. Its own `--no-build` flag makes it exit 1 instead. It then imports
   `Proofs` and `Batteries.Tactic.Lint`, takes every declaration whose module's root is `Proofs` (`getDeclsInPackage`), runs every
   enabled `@[env_linter]` in the environment, slow ones included, and removes the pairs listed in `scripts/nolints.json` — a file
   this repository does not have, so nothing is removed. If any linter reports, it prints the findings and exits 1; otherwise it
   prints `-- Linting passed for Proofs.` and exits 0.

**What follows for the run.** A passing run prints one line and no count; a failing run prints
`-- Found N errors in D declarations (plus A automatically generated ones) in Proofs with L linters`. The driver's `--trace` flag adds
one line per linter, `(2/2) Passed!` or `(2/2) Failed with n messages`, which is the positive signal for the linters that found
nothing, and a per-linter count to hold the parser against. So the run is

```
scripts/slot.py --mem 40 --cpus 8 -- lake lint --no-build -- --no-build --trace
```

It is the brief's `lake lint` with three additions, none of which changes what is linted: Lake's `--no-build` (before `--`) and the
driver's `--no-build` (after it) turn "watch for a rebuild and kill it by PID" into "a rebuild cannot start: the tool exits non-zero
and says why"; `--trace` adds lines and changes no verdict. The M2 close ran the same pair of driver flags on its second run
(`plans/M2-kernel-lane.md` §R-close stage 0, row 2: 14 linters, 3.5 s wall, 4.2 GB peak, over 11,817 declarations).

Both `.olean`s the driver needs are present (`.lake/build/lib/lean/Proofs.olean`;
`.lake/packages/batteries/.lake/build/lib/lean/Batteries/Tactic/Lint.olean`), and the driver's binary is built
(`.lake/packages/batteries/.lake/build/bin/runLinter`, 240 MB, sha256 `21bc14b3…16e2fcf3`, Lake's `runLinter.hash` `543fc84530ef03e7`).
Its checksum is taken again after every run: a changed binary is a rebuild that happened.

### Where the line between this milestone's modules and older ones is drawn

By git, on the library's files. The last commit before FS-131 that touches `Proofs/` is `077fa8b0` (X11K3, 2026-09-26); the first
FS-131 one is `3ec3b6c2` (FS131-K1, 2026-10-03).

- **Added by FS-131**: a module whose file does not exist at `077fa8b0`. There are 52 (`git diff --name-status 077fa8b0 HEAD --
  Proofs/`: 52 added, none modified, none deleted; `Proofs.lean`, the import list, is the only older file FS-131 changed).
- **Older**: a module whose file exists at `077fa8b0`: 1,714 files under `Proofs/`, each byte-identical to its state there.

A second line is kept beside it, because it bears on the proposal: **the last recorded passing `lake lint`** is the M2 close's, at
`39513500` (2026-09-25). Between it and `077fa8b0` seven modules were added and one changed (`Instances/SqrtFortySeven`,
`Instances/SqrtOneSixSeven`, `Instances/SqrtOneSixSeven/Cert`, `SpectralChain`, `ThetaCert`, `ThetaPlane`, `ThreeColour`;
`Transcendental` changed). I found no record of `lake lint` run over those; they are "older" by the first line and "never linted" by
the second, and the count reports them as their own class.

## Stage 2 — SAVED (FS131-LN1)

*2026-10-06T03:27Z. The run, and the count.*

### The run

`data/fs131/ln/run-lint.sh baseline` (the script is the command of Stage 1, with its bookkeeping; it was run from a snapshot copy):

```
scripts/slot.py --mem 40 --cpus 8 -- /usr/bin/time -v -o … lake lint --no-build -- --no-build --trace
```

| what | value | where |
|---|---|---|
| exit status, read from the tool | **1** | `data/fs131/ln/lint-baseline.exit`; GNU time's own `Exit status: 1` in `lint-baseline.time` |
| the driver's line | `-- Found 3 errors in 9643 declarations (plus 8414 automatically generated ones) in Proofs with 14 linters` | `lint-baseline.out:63` |
| linters | 14: `checkType`, `defsWithUnderscore`, `deprecatedNoSince`, `docBlame`, `impossibleInstance`, `nonClassInstance`, `simpComm`, `simpNF`, `structureInType`, `subsetDotNotationLinter`, `synTaut`, `tacticDocs`, `unusedArguments`, `unusedHavesSuffices` — the M2 close's 14 | `lint-baseline.out:4–17` |
| per-linter verdicts | 13 × `(2/2) Passed!`; `unusedArguments: (2/2) Failed with 3 messages` | `lint-baseline.out:32–59` |
| wall clock, peak resident set | 4.89 s, 4.83 GB (4,828,476 kB) | `lint-baseline.time` |
| the slot | waited from 03:21:53Z (two other trees held 80 of the ledger's 90 GiB), admitted, finished 03:27:03Z | `lint-baseline.err`, `.start`, `.end` |
| `scripts/nolints.json` | absent; the driver's summary of it is empty | `lint-baseline.out:61–62` |

**Nothing was rebuilt** — shown by effect, three ways: the driver's binary has the same sha256 before and after
(`lint-baseline.driver-before` = `lint-baseline.driver-after` = `21bc14b3…16e2fcf3`); no file under the shared `.lake/packages` was
modified between the run's start and its end (`lint-baseline.newer-packages`, 0 lines, written by a `find -newer` against a marker
made before the run); none under this tree's `.lake/build` (`lint-baseline.newer-build`, 0 lines). Both lists exist and are empty,
and both `find`s ran without error (their `.err` files are empty). Lake printed nothing of its own: `lint-baseline.err` holds only
the slot's two lines.

**The population.** 9,643 declarations and 8,414 automatically generated ones, 18,057 in all, against the M2 close's 11,817 "(the
auto-generated ones included)" — 6,240 more.

### The count

Made by `tools/fs131_ln_count.py data/fs131/ln/lint-baseline.out --json data/fs131/ln/count-baseline.json --md
data/fs131/ln/count-baseline.md` (exit 0). The script refuses to print a table unless what it parsed agrees with the driver's own
numbers: per linter with the trace's `Failed with n messages`, in total with `-- Found N errors`, in number of linters with `with L
linters`, and each finding's path with its `-- Module` header.

| linter | findings | in FS-131's modules | in post-M2 modules | in older modules |
|---|---:|---:|---:|---:|
| `unusedArguments` | 3 | 3 | 0 | 0 |
| each of the other 13 | 0 | 0 | 0 | 0 |
| **all** | **3** | **3** | **0** | **0** |

Modules: 52 added by FS-131, 8 post-M2 (7 added and 1 changed between the M2 close and FS-131), 1,706 older; **3 have a finding**,
so the "ten modules with the most" are these three, one finding each:

| # | module | class | findings |
|---:|---|---|---:|
| 1 | `Proofs.HadwigerNelson.Arith.Dyadic` | FS-131 (wave 2) | 1 |
| 2 | `Proofs.HadwigerNelson.Arith.FalconerField` | FS-131 (wave 2) | 1 |
| 3 | `Proofs.HadwigerNelson.Arith.PlaceHom` | FS-131 (wave 2) | 1 |

The three findings, each quoted in full (`lint-baseline.out:68–78`; the paths are this worktree's):

```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Arith/Dyadic.lean:36:1: error: @HadwigerNelson.Arith.DyadicSqrt3Conclusion 1 unused argument:
  argument 5: [NumberField L]
```
```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Arith/FalconerField.lean:179:1: error: HadwigerNelson.Arith.falconerFan_five_placeHom 1 unused argument:
  argument 2: [NumberField ↥F]
```
```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Arith/PlaceHom.lean:219:1: error: HadwigerNelson.Arith.placeHom_step 1 unused argument:
  argument 2: [NumberField ↥F]
```

The position is the declaration's first line, its docstring's (`Dyadic.lean:36` is the `/--` above `def DyadicSqrt3Conclusion` at
line 38).

**The count script's control** (`tools/fs131_ln_count.py --self-test`, exit 0, `data/fs131/ln/count-selftest.txt`): two inputs
counted exactly (a failing run with a two-line message, and a passing run); 13 plants, each refused for its own reason — a finding
line deleted, one added, the trace's count altered, the `-- Found` total altered, a failed linter with no report section, a linter's
trace line missing, a run with no trace at all, an empty file, a passing run cut before its last line, a `passed` line over a failed
trace, a finding under the wrong module, a declaration reported twice, stray text inside a section; `--diff` names a planted finding
alone; the three module classes are each inhabited and four named modules fall in the class they should (`OpenMove` FS-131,
`ThetaCert` post-M2, `Transcendental` post-M2, `Kempe` older). **What the control does not reach**: a linter that silently skipped
declarations. The driver's declaration count and the planted fault of Stage 3 are the instruments for that.

### What the three findings are, read in the source

All three are one shape: **a `[NumberField _]` instance argument that neither the statement nor the proof uses.**

| declaration | kind | the unused binder | what uses the declaration |
|---|---|---|---|
| `HadwigerNelson.Arith.DyadicSqrt3Conclusion` (`Arith/Dyadic.lean:38`) | a `def … : Prop`, the conclusion of FS129-SA1-SQRT3-LOCAL | `[NumberField L]`: the body reads `𝓞 L`, which needs `[Field L]` only | five theorems of the same file state it (`Dyadic.lean:517, 638, 652, 671, 679`), each as `DyadicSqrt3Conclusion L P`; named as an OUT carrier in `scripts/Vacuity.lean:279` |
| `HadwigerNelson.Arith.placeHom_step` (`Arith/PlaceHom.lean:222`) | a theorem, a child of `exists_isPlaceHom` | `[NumberField F]`: `IsPlaceHom F 𝔭 E₀ V₀ φ₀` (`PlaceHom.lean:34`) takes no such instance | one call, `placeHom_step F h₀ hlast` (`PlaceHom.lean:303`); an audited record (`scripts/Axioms.lean:3201`) |
| `HadwigerNelson.Arith.falconerFan_five_placeHom` (`Arith/FalconerField.lean:182`) | a theorem, a milestone row: FS129-SA1-FALC-RES (ii) | `[NumberField F]` | no caller in the library; an audited record (`scripts/Axioms.lean:2993`); named in `ARCHITECTURE.md:546` |

None of the three is on a hypothesis a ruling kept: `NumberField` occurs nowhere in `plans/FS131-close-inventory.md` nor in
`plans/FS131-w2-kernel-plan.md` (`rg -n NumberField`, no line). `falconerFan_five_placeHom` does carry a hypothesis kept on purpose
— `ht : AlgebraicIndependent F t`, referenced by `have _ := ht` under the comment "clause (ii) reads only the pair's properties, not
the transcendence of `t` (a generalization; § 15)" — and the linter does not report it, because a referenced hypothesis is a used
one.

### What "linters silent" does not see here

Two things the run cannot report, both read from the linter's source and both in use in this library:

- **An underscore-named unused argument is exempt.** `unusedArguments` at this pin skips an argument whose name has a component
  beginning with `_` (`.lake/packages/batteries/Batteries/Tactic/Lint/Misc.lean:55–58`: "We allow unused arguments whose names start
  with `_`, similar to the syntax linter", by `Name.isInternal`, `Lean/Data/Name.lean:125`). So the binders renamed by rulings 185 and
  244 (`_hF`, `_h`) are not findings and never will be at this pin.
- **A hypothesis referenced by `have _ := h` is used.**

By text pattern over the 52 FS-131 modules (`data/fs131/ln/silenced-fs131.txt`; a grep, not a reading of the environment): 31 lines
of the form `have _ := <identifier>`, 12 of them in `Plane/ValidMap/UnitArc`; and 14 signature lines carrying an underscore-named
binder (18 binders by the one-name pattern). These are the hypotheses kept on purpose; the linters are silent about all of them.

### Predictions scored (`data/fs131/ln/prediction.txt`, written 03:25Z while the run waited for the slot, its output file empty)

| | prediction | p | outcome |
|---|---|---:|---|
| P1 | the baseline exits 1 | 0.90 | met |
| P2 | Lake rebuilds nothing | 0.85 | met |
| P3 | total findings: < 20 at 0.20, 20–300 at 0.60, > 300 at 0.20 | — | **3: the 0.20 bucket.** I expected a debt in proportion to the new text; the build's own linters had already taken nearly all of it |
| P4 | `unusedArguments` has the most | 0.60 | met (it has all of them) |
| P5 | at least 80 % in FS-131's modules | 0.70 | met (3 of 3) |
| P6 | `docBlame` has none | 0.60 | met |
| P7 | 14 linters | 0.90 | met |
| P8 | declarations between 14,000 and 20,000, against the M2 close's 11,817 | 0.70 | met on the comparable figure, 18,057 with the automatic ones; the driver's first number, 9,643, is the non-automatic part |

### Before Stage 3

Stage 3 plants a fault in `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` and takes it out (`data/fs131/ln/plant.sh`). **If
this record ends here and `git status` shows that file modified**, the session stopped between the two: run `data/fs131/ln/plant.sh
restore` (or `git checkout HEAD -- Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean`) and build through `scripts/build.sh` under
the slot. The plant is never committed.

## Stage 3 — SAVED (FS131-LN1)

*2026-10-06T03:48Z. The control, watched to fire, and the file put back.*

`data/fs131/ln/control.sh`, run from a snapshot copy, does plant → build → lint → restore → build → lint, with the restore also on
an `EXIT` trap; every step's exit status is in `data/fs131/ln/control.log`. The plant (`data/fs131/ln/plant.diff`), appended to
`Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean`, which `Proofs.lean` alone imports:

```lean

/-- FS131-LN1's planted fault, for the linters' negative control: `m` is unused. Never committed. -/
def fs131LnLintPlant (n m : ℕ) : ℕ := n
```

| step | exit | what it showed | where |
|---|---:|---|---|
| plant | 0 | sha256 `bab8c249…db75ab4` → `e12c4fa8…5f8fa804`; the `def` at line 2877, its docstring at 2876 | `plant.sha256-before`, `plant.sha256-planted` |
| build, planted (`scripts/build.sh` under the slot, `MEMMAX=40G BATCH=4`) | 0 | `2 module(s) rebuilt, 1 module(s) with warnings, 8m15s`: `Plane.ValidMap.OpenMove` (10 s) and `Proofs` (1.5 s). **The build's own linter fired too**: `warning: Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean:2877:24: Variable name `m` is not explicitly referenced.` | `build-plant.out:446–464`, `build-plant.exit`, `build-plant.gate.log` |
| lint, planted | **1** | `-- Found 4 errors in 9644 declarations (plus 8414 automatically generated ones) in Proofs with 14 linters`; `unusedArguments: (2/2) Failed with 4 messages`; 4.94 s, 4.78 GB | `lint-plant.out:57, 63`, `lint-plant.exit`, `lint-plant.time` |
| restore | 0 | sha256 back to `bab8c249…db75ab4`, `git diff` empty, the plant's name absent from the file | `plant.sha256-after`, `control.log` |
| build, restored | 0 | `2 module(s) rebuilt, 0 module(s) with warnings, 8m18s` | `build-restored.out`, `build-restored.exit`, `build-restored.gate.log` |
| lint, restored | 1 | the baseline again: `lint-restored.out` is **byte-identical** to `lint-baseline.out` (`cmp`) | `lint-restored.out`, `diff-baseline-restored.txt` |
| `git status` over `Proofs/`, `Proofs.lean`, `scripts/`, `lakefile.toml` | — | 0 lines | `control.git-status` |

**The plant, named at its source position among the rest** (`tools/fs131_ln_count.py --diff lint-baseline.out lint-plant.out`,
`data/fs131/ln/diff-baseline-plant.txt`): added 1, removed 0, changed 0 —

```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean:2876:1: error: fs131LnLintPlant 1 unused argument:
  argument 2: (m : ℕ)
```

under `-- Proofs.HadwigerNelson.Plane.ValidMap.OpenMove` (`lint-plant.out:80–82`). The declaration count rose by exactly one
(9,643 → 9,644) and fell back: the linters read the newest landing's module, and a count is not an empty scan.

**Neither lint run rebuilt anything**: the driver's sha256 is unchanged across all three runs, and each run's two `find -newer`
lists are empty. The only writes into `.lake/build` were `scripts/build.sh`'s, for the two modules named.

The three predictions for the control were met exactly (C1: two modules, exit 0, one warning module; C2: one added finding,
`unusedArguments` on `fs131LnLintPlant` at `OpenMove.lean:2876:1`; C3: declarations +1, automatic +0), and C4 (the third run equals
the baseline) to the byte. No background process is left: nothing holds `control.log` open, and the slot ledger shows no slot of
this job.

## Stage 4 — SAVED (FS131-LN1)

*2026-10-06T03:49Z. The proposal.*

### What clearing a finding takes

All three findings are an unused anonymous instance binder, `[NumberField _]`. There are three ways to clear one, and they differ in
what they do to the statement.

| way | the edit | the statement | needs a ruling |
|---|---|---|---|
| **remove** | delete the binder | **changes**: the two theorems lose a hypothesis and become strictly stronger; the definition loses an argument, so the five statements that mention it elaborate to a different term from the same text | yes |
| **underscore** | name the binder: `[_hL : NumberField L]` | the type is unchanged (a binder's name is not part of it); the linter exempts the name | the form of rulings 185 and 244, extended from an explicit hypothesis to an instance one |
| **nolint** | `@[nolint unusedArguments]`, the reason in the docstring | unchanged | no; but it switches a linter off where the underscore says why |

**Checked, not only read**: `data/fs131/ln/UnderscoreInst.lean`, a scratch file outside the library run by `lake env lean` (exit 1,
`UnderscoreInst.out`), has three theorems with an unused `NumberField F` instance: anonymous, underscore-named, and referenced by
`have _ := hF`. `#lint only unusedArguments` reports the anonymous one alone — `Found 1 error in 3 declarations`, `#check fs131LnAnon
/- 1 unused argument: argument 3: [NumberField F] -/`. The anonymous theorem is the control that fires; the other two pass.

**The count the brief asks for.** Cleared by removal, 3 of 3 change a statement and need a ruling: two theorems
(`placeHom_step`; `falconerFan_five_placeHom`, which is the milestone row FS129-SA1-FALC-RES (ii)) and one definition that
statements use (`DyadicSqrt3Conclusion`). **None of the three sits on a hypothesis a ruling kept on purpose**; no docstring is
owed; no `simp` form is wrong.

**As the kernel reads them, the two theorems are proved without the hypothesis.** The linter reports an argument when the proof
term and the type do not mention it, so the same term proves each statement with `[NumberField F]` deleted: `placeHom_step` and
`falconerFan_five_placeHom` hold for every subfield `F` of `ℝ`. That is a generalization of each (small: `𝓞 F ⧸ 𝔭` of cardinality 11
or 19 is where the content is), and it is the reason I recommend removal over the other two ways for them: a statement weaker than
what was proved is the wrong record. For `DyadicSqrt3Conclusion` the unused instance is an obligation every later mention of the
definition must discharge for nothing.

### The price

- **The edit**: three binders in three files (`Arith/Dyadic.lean:38`, `Arith/PlaceHom.lean:222`, `Arith/FalconerField.lean:182`).
  No call site names the argument: the definition is used as `DyadicSqrt3Conclusion L P` five times in its own file, `placeHom_step`
  once as `placeHom_step F h₀ hlast`, `falconerFan_five_placeHom` nowhere.
- **The build**: four modules at most — `Arith.Dyadic` (imported by `Proofs.lean` alone), `Arith.PlaceHom` (by
  `Arith.FalconerField` and `Proofs.lean`), `Arith.FalconerField` (by `Proofs.lean` alone), `Proofs`. Measured in Stage 3: when
  anything is stale `scripts/build.sh` takes about 8 minutes of wall clock for its walk over 451 batches at `BATCH=4`, however small
  the change (the two rebuilt modules took 11.5 s of it).
- **The gate**: by underscore or nolint the types are unchanged, so the axiom and vacuity receipts should not move — to be read, not
  assumed, by whoever makes the edit. By removal three types change: the two records in `scripts/Axioms.lean` (lines 2993, 3201)
  keep their names; whether the vacuity scan counts an instance binder as a site I did not check, so its counts in `CLAUDE.md` § The
  gate may move by up to three and would be refiled.
- **Agent cost** (my estimate, not a measurement): as one more line in a landing job that already runs the gate, about 10k tokens
  and no extra gate run. As a job of its own, the launch context and a full gate run dominate: 40–60k.

### When

**Not as a job of its own, and not left to the close: with the next landing, and the guarded lint added to every landing's gate.**

1. **The debt is three, all in wave 2's `Arith/` modules.** The other 49 modules FS-131 added, the 8 post-M2 ones and the 1,706
   older ones have none. "Wave by wave" has one wave to do.
2. **Why so few**: the build's own linters (`linter.unusedVariables`, `linter.missingDocs`), read at every landing as "0 warnings",
   already take what `unusedArguments` and `docBlame` would report. What they do not see is exactly the kind found here. An anonymous
   instance binder has no name for the syntax linter to warn about: the full walk of Stage 3's restored build reports `0 module(s) with warnings`
   over all 1,767 modules, these three among them, while the plant's explicit `(m : ℕ)` got a build warning and a lint finding both. So the debt that accrues silently between two runs of `lake
   lint` is unused instance arguments, plus whatever the other 13 linters watch, which over 18,057 declarations is nothing.
3. **The reason to run it only at the close has been measured away.** Ruling 415 (c) weighed running it at every landing and
   declined because "it starts Lake outside `scripts/build.sh`". With both `--no-build` flags it cannot start a build: Lake exits
   instead of rebuilding the driver, and the driver exits instead of spawning `lake build +Proofs`. Three runs here, beside two other
   trees' builds: about 4.9 s and 4.8 GB each, the driver's binary and both `.lake` trees untouched. At that price a landing can run
   it after its green build, and the close then has nothing to find. The command, for a landing brief:

   ```
   scripts/slot.py --mem 8 --cpus 8 -- lake lint --no-build -- --no-build --trace
   ```

   read as: exit 0 and `-- Linting passed for Proofs.`, and 14 lines `(2/2) Passed!`. (`--mem 8` is my proposal for a measured
   4.8 GB peak, **not run at that cap**: the three runs here were under the brief's 40, which made the first wait five minutes for
   another tree's build to leave the ledger.) The firing control costs two eight-minute builds, so it
   belongs at the close and wherever the driver or the pin changes, not at every landing; `tools/fs131_ln_count.py` reads any
   run's output and refuses one that did not finish or was made without `--trace`.
4. **For the planner's lane**, one habit removes the kind at its source: a skeleton that carries `[NumberField F]`-style instance
   binders from a row's wording checks, at the first green build, that each is used — or names it with an underscore.

**What I would rule, were it mine** (it is the coordinator's): remove the binder in the two theorems, as generalizations, each
with a one-line note in its docstring that the row's number-field hypothesis is not needed; remove it in `DyadicSqrt3Conclusion`;
do all three in the next landing's tree before its gate run. If no statement may move before the close, the underscore form clears
all three with no type changed.

## Drafts for the front page

*For Keryx to file or decline; I write none of these files. This job proved no theorem, so there is no ledger row, no Frontier
line and no Proof Atlas grade change.*

1. **`LEAN.md` § The gate**, after the sentence ending "linters silent, spec examples passing." — a new bullet in the list below it:

   > - **The environment linters** are `lake lint --no-build -- --no-build --trace` under the slot (about 5 s, 4.8 GB): Lake's
   >   `--no-build` exits instead of rebuilding the driver, the driver's exits instead of building the library, and `--trace` prints
   >   one verdict per linter. Green is exit 0, `-- Linting passed for Proofs.`, and every linter `(2/2) Passed!`. An unused argument
   >   named with an underscore, or referenced by `have _ := h`, is not reported; an unused anonymous instance binder is, and the
   >   build's own linters do not warn about it.

2. **`plans/FS131-close-inventory.md`**, a new item:

   > **`lake lint` over `main` at `333ecaa1`, measured: FS131-LN1 done** (record `plans/FS131-lint-measurement.md`, data
   > `data/fs131/ln/`). Exit 1: 3 findings in 9,643 declarations (plus 8,414 automatically generated) with 14 linters, 13 of them
   > passing; all three `unusedArguments`, each an unused anonymous `[NumberField _]` instance binder, all in wave 2's `Arith/`
   > (`DyadicSqrt3Conclusion`, `placeHom_step`, `falconerFan_five_placeHom`); none on a hypothesis a ruling kept. 4.9 s, 4.8 GB,
   > nothing rebuilt. Control: a planted unused argument in `OpenMove` reported at `OpenMove.lean:2876:1`, exit 1, the file restored
   > byte for byte, the third run byte-identical to the first.

3. **`CLAUDE.md` § The gate**: no count of mine belongs there today. If the guarded lint becomes a landing's gate item, its
   recorded state would be one clause after the vacuity counts — "environment linters: 14, passing over N declarations" — filed
   by the landing that first sees it pass.
