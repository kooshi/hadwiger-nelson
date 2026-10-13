# FS131-LU1 — the landing of the first number-field module: the residue upper half, and the four values it closes

*Job record of FS131-LU1 (brief: `data/fs131/briefs/FS131-LU1-landing.md`; de Bruijn, the implementer, as the lander of
one finished module of three files; branch `fs131-wnf`, worktree `.claude/worktrees/fs131-wnf`; the laptop: 12 cores,
31 GB). The module is FS131-KN2's statements (`plans/FS131-KN2-upper-half-plan.md`) with the leaves proved by FS131-IU1
(`Proofs/HadwigerNelson/Arith/UpperHalf.lean`), FS131-IQ1 (`Arith/QuadraticPrime.lean`) and FS131-IV1
(`Instances/UpperHalfValues.lean`). **None of the values is new mathematics**: the upper bounds are prior art
(`LEDGER.md` § The claim list; `[Fischer1990]`, `[Moorhouse2010]`, `[Woodall1973]`), and what is this project's is the
kernel proof. This job proves nothing and changes no statement: it takes the module through the gate. Working files:
`data/fs131/lu1/` (this job's scripts are there, not under `tools/`: the brief's list of what the job touches names that
directory and not `tools/`).*

## Theorems this phase proved

*This job proved no theorem. The list of what it landed — one line per declaration with its banner and its axioms as
the audit printed them — is § "Theorems this phase proved, final", written when the gate is green on one commit; until
that section exists none of it is "held".*

## Stage 1 — SAVED (FS131-LU1): the readback, what was read, `main` merged, the build brought current, the tree as given probed

### The brief's quotations

`data/fs131/lu1/readback_check.py` (FS131-LC1's script pointed at this brief; every block quote must occur character
for character in the file its source line names): **8 of 8 MATCH** — Kooshi's word W2 against
`data/fs131/REQUEST-2026-10-13.md`, and seven lines against `data/fs131/claims-NF1.md` (NF1-S1A, -S1B, -S2, -MODULE, -NC
and the two dated lines of 16:36 UTC). Read first as `git show 7a0a20cb9:…` (`readback.out`), because this tree's copy
of the claim list did not hold the two dated lines until `main` was merged; again on the merged tree
(`readback-tree.out`): 8 of 8. With `--fault` (one character of each altered): **8 of 8 MISMATCH**
(`readback-fault.out`), so the check can fire. The brief's "seven quoted lines checked against the claim list" is the
seven; the eighth block is W2.

### What was read

The brief and `plans/STANDING-RULES.md` in full; `LEAN.md` in full as it stands on `main`; `RUNNING.md` § Building and
§ Make the gate fail, and watch it fail; FS131-IV1's record in full (it gathers the drafts); the planner's record, its
head, stages 1 and 2, § D and stage 5; FS131-IU1's record, its head, stage 5 and its drafts; FS131-IQ1's record, its head
and its drafts; **the three modules, every line** (442, 458 and 212 lines); the last landing's record
(`plans/FS131-LC1-landing.md`) stages 1 to 5 and 7 to 9, its drafts, open gate items and slips — **its stage 6 by its
headings only** (another module's read-aloud) — and its scripts under `data/fs131/lc1/` (the runner, the measuring
wrapper, the two plants, the slots check, the records tool), each of which this job's is a copy or an adaptation of and
says so in its first line.

### `main` merged

`main` stood at `7a0a20cb9`, two commits past the `147e38bc8` the brief names; those two touch `data/` and `plans/`
only (4 paths, none outside them). Trial first (`git merge-tree --write-tree`, `data/fs131/lu1/merge-trial.out`): exit
0, **no conflict named**, though `ARCHITECTURE.md` and `Proofs.lean` were changed on both sides. Merged by hash,
automatic: `0585a35c4` (`merge-main.out`). Both sides kept, checked: `Proofs.lean` imports `Plane.LebesgueNumber` and
the module's three files; against `main` the branch differs under `Proofs/`, `Proofs.lean`, `scripts/`, `tools/`,
`ARCHITECTURE.md`, the lakefile, the toolchain, the manifest, `CLAUDE.md`, `LEAN.md` and `LEDGER.md` by **the three
modules, three import lines and three rows of the map, and nothing else**.

### The build brought current — by copying the last gate's compiled modules, a decision of this job

**What the merge left stale**: `main` holds the last landing's module and its docstring edits to `Plane/AeColouring`
and `Plane/FalconerReduction`, which this tree's build (current for `d83fdd8c7`: "All targets up-to-date (5998 jobs)")
had never compiled; FS131-LC1 measured the rebuild of those and their 114 dependents on this machine at 47 m 22 s.

**What was done instead** (2026-10-13 20:20–20:21 UTC, before any build): the compiled files of the tree the last
landing gated in (`.claude/worktrees/fs131-wkc`, whose sources under `Proofs/` are `main`'s: `git diff` empty) were
compared with this tree's by checksum (`rsync -a --checksum --dry-run`, `data/fs131/lu1/rsync-dry.out`) and the
differing ones copied in (`rsync-real.out`; no `--delete`; nothing was written in the other tree). What the comparison
showed, before anything was copied:
- **three `.olean` files differ in content** — the root's, `Plane/AeColouring`'s and `Plane/FalconerReduction`'s: the
  two modules whose docstrings the last landing edited, and the root;
- **169 `.olean` files are byte for byte the same and differ in time only** — among them 113 of the 114 dependents of
  those two that the last landing recompiled (`data/fs131/lu1/dependents.out`; the 114th is the root): a module that
  imports an edited docstring recompiles to the same bytes, and only its trace moves;
- 172 `.trace` files and 160-odd `.setup.json` files differ (a trace holds the hash of its inputs and the command line
  of the tree it was compiled in);
- `Plane/LebesgueNumber`'s eight files are new; three modules compiled in the other tree and with no source in either
  (`Arith/LevelGraph`, `PlaceFilter`, `UsablePlace`) were **not** copied.
After the copy the same comparison lists only those three excluded modules.

**Why this is the same evidence a build gives, and what it is not.** Lake decides whether a module is current from
the hash of its source and of its imports' compiled files, never from where or when it was compiled; this tree's own
build is a chain of such copies (its traces name `fs124-wk1`). The build that followed (below) asked Lake about every
module of this tree's sources and **recompiled four — this job's three and the root — and none of the copied
ones**: each copied module's trace matched this tree's source and imports. So "the build is green on this commit"
rests, for the 117 modules the merge brought, on Lake's trace check of files compiled in the last landing's gated
tree, exactly as it rests for every module a pass does not recompile. **It is not a cold rebuild**, and no module of
`Plane/` or `Outside/` was compiled by this job. The decision is this job's (the brief gives it the builds' batch
sizes and the order of steps, and says "Build"); it reads another tree and writes nothing there. If a cold rebuild of
the 117 is wanted before the fast-forward, it is 47 minutes at `BATCH=2` on this machine. One consequence that is in
the landing's favour: `Outside/OAI158` and the nine ported modules are, byte for byte, the files the last landing's
two stored-term comparisons with the release read — nothing of the import was recompiled here.

### Before any edit: the three modules as the kernel held them

On the tree as given (`d83fdd8c7`, before the merge): `data/fs131/lu1/StatementDump.lean` (FS131-LC1's with the module
list changed) prints every constant of the three modules' compiled data — 56 + 25 + 18 = **99 constants**, the count
FS131-IV1's dump after its build has — kept compact as `data/fs131/lu1/statements/before.compact`
(`tools/fs124_l2_statements.py compact`; the raw print, 25.8 MB, SHA-256 `d25adf10…f9cb29d` with the slot's line and
the exit line, is not kept). `data/fs131/lu1/decls.lean`: 60 constants that are not internal; **52 a person typed — 49
theorems and 3 definitions** (`StablePrime.heightOne`, `.localRing`, `.residue`); 8 the elaborator's. The sixteen
private helpers have internal names and are in neither count (`data/fs131/iv1/axioms-footer.txt` has theirs).

### The tree as merged and built, before any registration

*Every step under the slot with this machine's budget (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`), through
`data/fs131/lu1/m.sh` and `in-scope.sh` (FS131-LC1's wrappers: each step's exit status, wall time, the scope's charged
`memory.peak` and the largest single process's resident set, appended to `data/fs131/lu1/probes/measure.txt`). The steps
below ran from `data/fs131/lu1/probe-given.sh` on the commit built (`9aeb4fc7d`: the merge and four docstring edits,
stage 2), no tracked file modified.*

| step | result | wall | peak (charged) | max-rss |
|---|---|---|---|---|
| is the build current? `lake build --no-build Proofs` | exit 0, "All targets up-to-date (5999 jobs)" | 3.6 s | 0.21 GiB | 0.87 GiB |
| the statements by `#check`, their axioms, the model terms (`checks.lean`) | no error, no warning; 46 prints, 45 on `[propext, Classical.choice, Quot.sound]` and one term of this job's on `[propext]` | 3.6 s | 0.55 GiB | 4.36 GiB |
| the three modules' constants (`decls.lean`) | 60 constants that are not internal (36 + 14 + 10); **52 a person typed: 49 theorems, 3 definitions** | 66 s | 0.54 GiB | 4.35 GiB |
| `./scripts/dupnames.sh` | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" | 4.7 s | 0.54 GiB | 4.34 GiB |
| the guarded lint | exit 0, "-- Linting passed for Proofs.", fourteen linters, fourteen "Passed!" | 10.9 s | 0.84 GiB | 4.91 GiB |
| `./scripts/vacuity.sh` | "vacuity: OK"; against the last landing's gated scan: declarations 15969 → **16029 (+60)**, every other count as it was — **the module adds no site** (stage 5) | 138 s | 0.59 GiB | 4.48 GiB |
| `./scripts/assumptions.sh` | **exit 1, seven failures, one kind**: `FAIL unlisted-consumer` for `UpperHalf.chromaticNumber_eq_localBound_of_chain` under each of the seven named hypotheses it takes. **No failure names `hUpper`** (stage 4) | 106 s | 0.72 GiB | 4.54 GiB |

**Why the scans ran first.** The order before the pass is this job's; a scan that asked for a word in a docstring
would have cost a second build. None does.

## Stage 2 — SAVED (FS131-LU1): the docstring corrections and the first build

### The corrections (docstrings and one module header only; no statement, no code character)

**The three the brief names**, each from the implementers' notes checked against the proof:
- `UpperHalf.exists_stablePrime_rat` (`Instances/UpperHalfValues`) — **described by the proof's own route**. Was: "The
  stable prime of `ℚ(i)` above 2 … (the ideal `(1 + i)`; `x̄ − x = −2·Im(x)·i` and `Im(x) ∈ ℤ` …)". Now: "A stable prime
  of `ℚ(i)` above 2 … Existence only, and the proof exhibits no ideal: it takes any maximal ideal over `(2)`
  (`Ideal.exists_le_maximal`; `2` is not a unit because the real part of an integer of `ℚ(i)` is an integer …), and
  conjugation is the identity on `𝓞 (ℚ(i))` modulo `2` — `x̄ − x = 2·(Re x − x)` — so every maximal ideal holding `2` is
  fixed by conjugation and has the third clause. In `ℤ[i]` that ideal is `(1 + i)`; neither that, nor that it is the
  only one, is stated or proved here." The article moved from "The" to "A": uniqueness is not in the statement.
- `QuadraticPrime.nonempty_ringHom_zmod_of_ramified_sqrt` — "`a + bπ ↦ a − bπ` is a ring automorphism" → "is a ring
  homomorphism `K → K`": the proof builds `conj : K →+* K` and never its inverse.
- `QuadraticPrime.exists_maximal_card_eq_of_ramified` — **the reader's note**, added: "`hD` and `hq` can hold together
  only when `q ∉ D` — `hD` makes every member of `D` nonzero modulo `p` and `hq` makes `q` zero there — so the statement
  is about a radicand outside `D` without saying so, and `hq2` excludes `q = 0`; each hypothesis is satisfiable alone,
  and all of them at `D = {3}`, `q = 11`, `p = 11` (the spec's fourth `example`)." Both halves of the note are
  kernel-checked as terms of `data/fs131/lu1/checks.lean` (`FS131LU1.ramified_radicand_notMem`,
  `ramified_radicand_ne_zero`), and the model as `ramified_model`.

**Two more, found by reading the three files, in files this job already recompiles** (the coordinator was told before
the gate):
- `Arith/UpperHalf`'s module docstring, § Inhabitants: it named the instances file `Instances/UpperHalf` — the file is
  `Instances/UpperHalfValues` — and said a usable prime "is exhibited at `ℚ(√11)`, `ℚ(√47)` and `ℚ(√167)`": it is
  exhibited at `ℚ(√11)` (an `example`) and used at the other two inside the instance theorems. Reworded to say so, and
  to name `exists_stablePrime_rat`.
- `Arith/QuadraticPrime`'s module docstring, "**Not claimed:** anything at `p = 2`": three public theorems of the file
  carry no `p ≠ 2` and hold at 2 as stated (`isMaximal_ker_and_card`, `exists_ringHom_zmod_of_padic`,
  `exists_maximal_card_of_padic`). Now: "NF1-S2 at `p = 2` (each statement here about a square root and a prime asks
  `p ≠ 2`; [the three], which name no square root, do not ask it and hold at `p = 2` as stated)". Made after the first
  build: the pass's build compiles it.

**Not edited, by the brief's word**: `Proofs/HadwigerNelson/SpectralChain.lean:240` and `:624–625` still call the upper
half a hypothesis "named `hUpper`" (open gate item 1). **And one line comment left as it is** (a `--` comment is not a
docstring, and this job's text check counts it as code): `Instances/UpperHalfValues.lean:200`, "`L(ℚ)` is a number (a
stable prime exists)" — what the kernel holds is that the infimum is over an inhabited family and `2 ≤ L(ℚ)`
(`FS131LU1.two_le_localBound_rat`, a term); that `L(ℚ)` is finite is true and is no theorem here (open gate item 4).

**No statement changed, in text** (`data/fs131/lu1/code_only_diff.py`, FS131-LC1's: every block comment removed,
against the merge commit `0585a35c4`): `Arith/UpperHalf` 17,276 characters of code before and after, `Arith/QuadraticPrime`
18,686, `Instances/UpperHalfValues` 8,063 — "SAME" three times (`code-only.out`); its plant, one code character altered,
reads "DIFFERS" three times (`code-only-plant.out`). Each edited file elaborates alone with the lakefile's three options
and no message (`probes/syntax-*.log`). **From the kernel's side** the comparison is the pass's (stage 8): the dump of
the three modules made before the merge (`statements/before.compact`) against the dump after the last build.

### The build

`data/fs131/lu1/run-build.sh 1 10 8 10` — `./scripts/build.sh` under the slot, `--mem 10 --cpus 8`, `MEMMAX=10G
BATCH=10`, on the committed text `9aeb4fc7d` (`data/fs131/lu1/build-1.log`; Lake's full output
`build/gate/build/20261013T202403Z-828017.log`, 0 lines holding "warning"; 20:24:02–20:29:47 UTC):

> ==> build: OK — 200 of 200 batches, 4 module(s) rebuilt, 0 module(s) with warnings, 5m34s

Rebuilt: `Arith.QuadraticPrime` (5.9 s), `Arith.UpperHalf` (4.3 s), `Instances.UpperHalfValues` (3.4 s), `Proofs`
(2.6 s) — this job's three, for their docstrings, and the root, for its imports. **None of the 117 modules the merge
brought was recompiled**: Lake's trace check took each copied file (stage 1). Largest compiler 4.2 GiB resident (the
root; `build-1.rss`, 68 samples). Had it died: the same command again; the redo is the batch in flight and the walk.

## Stage 3 — SAVED (FS131-LU1): the registrations

**What the landing brings, as the kernel lists it** (`data/fs131/lu1/decls.lean`; `probes/decls-given.log`): 60
constants that are not internal in the three modules — `Arith/UpperHalf` 36, `Arith/QuadraticPrime` 14,
`Instances/UpperHalfValues` 10; **52 declarations a person typed — 49 theorems and 3 definitions** (30, 13 and 9); the
other eight are the elaborator's. The sixteen private theorems (6, 8, 2) have internal names: no line of the audit
script can name one, each is read by a public record, and their own prints are FS131-IV1's
(`data/fs131/iv1/axioms-footer.txt`: 68 rows, 52 public and 16 private, each on the standard three).

**Fifty-two records in `scripts/Axioms.lean`, one block, all under CLEAN**, just above the PURCHASED banner, headed
"FS131-LU1": the lines are FS131-IV1's block (`data/fs131/iv1/audit-block.txt`, made from the compiled modules, each
file in its own order), with this job's header and three sub-banners. Nothing goes under IMPORTED: none of the three
modules reads a declared outside theorem. `lu1_records.py … --unfiled`: "declarations the landing brings: 52 (of 60
constants in 3 modules); with one line: 52; unfiled: 0; doubled: 0"; the script holds 7,506 `#print axioms` lines
(`main`'s 7,454 + 52), no name twice.

**The audit on the registered tree** (`./scripts/axioms.sh`; `probes/axioms-probe.log`): exit 0 —

> audited: 7506 records — 7447 clean on the standard axioms, 28 axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)

Against `main` (7395 clean, 28 axiom-free, 26 imported, 7,454 records): **clean +52, records +52; axiom-free, imported
and purchases do not move.** The digest reads `CLAUDE.md` § Trust ledger as stale ("7395 clean → 7447"), as it must
until refiled (draft 1).

**Each filed on what it rests on, read from the audit's own output** (`data/fs131/lu1/lu1_records.py`, after
FS131-LC1's `records.py`, which it loads by path under another name and whose table of the twenty-six imported records
it reads; `probes/records-probe.txt`): "records: PASS" — "landing records on exactly the three: 52"; "headlines under
CLEAN on exactly the three: 31 of 31"; over the whole log "records carrying kloosterman_bound: 8 (filed: 8); of the
landing's: 0", "no_proper_five_coloring: 6 (filed: 6); of the landing's: 0", "proper_to_borel_weak: 12 (filed: 12); of
the landing's: 0"; "records under IMPORTED 26; carrying two imports 0; carrying sorryAx 0". **Fifteen plants, in
memory, one at a time, every one fired** (`probes/records-plant-probe.txt`): a record dropped; doubled; `sorryAx` under
one; a landing record on Weil's bound; one filed under IMPORTED; one under PURCHASED; a native auxiliary; a record on
two axioms only; **`χ(ℚ(√11)²) = 4` resting on the five-colour import**; **the upper half printed under IMPORTED**;
`χ(ℚ²) = 2` with no record; a theorem with no record; an earlier imported record stripped of its import; a module
absent from the dump; a declaration absent from the kernel's list.

**The audit's self-test** (`probes/axioms-selftest-probe.log`): exit 0, "axioms self-test: OK — every planted fault
fired, and every partner passed" (23 of 23). **Its two controls that read the library's state did not go red**: they
count the records under IMPORTED and the declared imports, and this landing moves neither, so
`scripts/axioms-controls.txt` is untouched.

**`ARCHITECTURE.md`**: the module's three rows are FS131-IV1's and stand as merged; § Trust's table of what the
library assumes in hypothesis form moves with stage 4. `tools/check_architecture.py` runs in the pass.

**The doubled-name check on the built tree** (`./scripts/dupnames.sh`; `probes/dupnames-given.log`): exit 0,
"dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)". The planner's worry —
`coe_conjO`, `conjO_conjO` beside `StandingFive`'s own — is answered by the scan: no clash.

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/axioms.sh` (7,506 records) | 7.3 s | 1.14 GiB | 4.92 GiB |
| `./scripts/axioms.sh --self-test` (23 controls) | 178 s | 1.30 GiB | 5.04 GiB |
