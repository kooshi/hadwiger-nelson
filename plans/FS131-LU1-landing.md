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

## Stage 4 — SAVED (FS131-LU1): what the library assumes — one entry retired on the landing's word, and a sentence about the tool that was not true

`./scripts/assumptions.sh --self-test` first (`data/fs131/lu1/probes/assumptions-selftest-first.log`): exit 0, "OK —
all 33 checks behaved: every planted fault fired, and every partner stayed silent".

### What the step said before any edit — and what it did not say

On the merged, built tree, `scripts/` as on `main` but for the audit block (`probes/assumptions-given.log`; the full
output `probes/receipt-assumptions-given.log`): **exit 1, seven failures, one kind** —

```
FAIL unlisted-consumer HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain :: the scan finds 'TAKES HadwigerNelson.SpectralChain.BochnerHerglotz HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain' and the ledger does not list it
… the same for Interface.APlusOfR88, Interface.Count, Interface.EFPlus, Interface.PE2, Interface.RU, InvariantMeasureOnClosed
```

— the seven named hypotheses the new theorem takes, which the scan finds by itself. **It did not fail on `hUpper`.**
The brief (Done means, 4), the planner (§ D (4)) and FS131-IV1 (drafts § 3) each say the step fails until the upper
half leaves the declared list, because `UpperHalf.chromaticNumber_planeOver_le_localBound` now proves that binder over
the theorem's own variables. The receipt reads otherwise: line 65, `ASSUMPTION inline:UpperHalf form=inline kind=ours
ref=row:52 consumers=1`; line 209, `SITE inline:UpperHalf HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound
hUpper :: (…).chromaticNumber ≤ HadwigerNelson.SpectralChain.localBound F`; no `FAIL` names it.

**The mechanism, read in `scripts/Assumptions.lean`.** `FAIL discharged <H> :: <theorem> proves it in general`
(line 673) runs over `general` — the pairs (named former `H`, theorem) in which the theorem "concludes `H x₁ … xₙ` over
its own distinct variables with no hypothesis" (line 380). A hypothesis written out in a binder is declared by
`.site` as (theorem, binder name, label): the step checks that the binder exists, that the label's sources agree and
that the label is taken; **nothing compares the binder's type with any theorem's conclusion**. The self-test's
control for the rule (`scripts/assumptions-controls.txt`, `## control discharged`) plants a named former. So
`LEAN.md` § The gate's clause "or one a theorem proves over its own variables" holds of a named hypothesis only; an
entry written out in a binder is retired, as it is declared, on the landing's own word. The coordinator was told
before the gate (the brief's Amendment 1 rules: retire it); drafts 9 and 10 carry the corrected sentence and the line
for the tooling list.

### The three edits (FS131-IV1's draft), on the landing's reading

In `scripts/Assumptions.lean`, `AssumptionAudit.declared`:
- **out**: `.site ``HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound `hUpper "UpperHalf" .ours "row 52 (the
  upper half χ(F²) ≤ L(F), at ring level; the field step is row 57's gap)"` — the label's only site, so the inline
  hypothesis `UpperHalf` leaves with it. A four-line `--` comment stands where it was and says why.
- **in**, for `UpperHalf.chromaticNumber_eq_localBound_of_chain`, each with its label's source character for
  character: `` `hRow99 "Row99" .ours "row 99 (χ(F²) = L(F) at L(F) ≤ 4)" `` and `` `hCLS "CLS" .ours "X23D-CLS (L(F) ≥ 5 ⟹
  T-C(A) at S = ∅; X23V § 2.2)" ``. Before they were declared the receipt printed both as `COHYP` rows of the new
  theorem — hypotheses the step "counts and prints, and cannot decide": these two are hand results of this project
  written out over the theorem's own variables, which only a landing's word can declare.

**With the list edited and the ledger not yet written** (`probes/assumptions-edited.log`): exit 1, **ten failures,
the ledger comparison red in both directions** — nine `unlisted-consumer` (the seven named and `inline:CLS`,
`inline:Row99` for the new theorem) and one `stale-consumer` ("the ledger lists 'TAKES inline:UpperHalf
HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound' and the scan does not find it").

**The ledger, written with the script's own flag** (`./scripts/assumptions.sh --write-ledger`;
`probes/assumptions-write-ledger.log`: "ledger written (133 rows) — read the rows above; a row is a theorem that is
conditional"). `git diff scripts/assumptions-ledger.txt`: **nine rows gained, one lost**, and the header's count line:

```
+TAKES HadwigerNelson.SpectralChain.BochnerHerglotz HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES HadwigerNelson.SpectralChain.Interface.APlusOfR88 HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES HadwigerNelson.SpectralChain.Interface.Count HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES HadwigerNelson.SpectralChain.Interface.EFPlus HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES HadwigerNelson.SpectralChain.Interface.PE2 HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES HadwigerNelson.SpectralChain.Interface.RU HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES HadwigerNelson.SpectralChain.InvariantMeasureOnClosed HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES inline:CLS HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
+TAKES inline:Row99 HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
-TAKES inline:UpperHalf HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound
-#   axioms=3 rests=26 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1
+#   axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1
```

Each row read: the nine gained say that the new theorem — `χ(F²) = L(F)` for `L(F) ≤ 5` at a totally real number
field, the headline with its upper half discharged — is conditional on nine things, two outside theorems
(Herglotz–Bochner, Markov–Kakutani) and seven hand results of this project (the count, A⁺ from R88-TCA, R-U, PE-2,
EF_F⁺, CLS, row 99). The one lost says the headline no longer lists the upper half as an assumption: its binder
`hUpper` is still in its statement and is now a condition a library theorem discharges.

After it (`probes/assumptions-second.log`; full output `probes/receipt-assumptions-second.log`): **exit 0** —
"assumptions: OK — 3 outside theorem(s) as axioms, with 26 theorem(s) resting on them; 19 named and 15 inline
hypotheses (7 outside, 22 ours, 5 open), taken by 106 statement(s) and mentioned by 1"; "recorded counts in
scripts/assumptions-ledger.txt's header: match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "inline
16 → 15, ours 23 → 22, takes 98 → 106" (draft 3).

### Against the prediction

| | predicted (the brief; FS131-IV1's drafts § 3, with `rests` as the last landing left it) | the step, after the edits |
|---|---|---|
| the nine | axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1 | **axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1** |

**The nine counts come out as predicted, each one.** What did not is the sentence about why the entry had to leave
(above). In words: thirty-four hypotheses, nineteen named and fifteen written out in a binder — seven standing for
outside theorems, twenty-two for hand results of ours and five declared as open questions — taken in 106 (hypothesis,
statement) pairs by 52 statements (51 on `main`: the new theorem; counted from the ledger's `TAKES` rows).

| | `main` (FS131-LC1's gated scan) | this tree |
|---|---|---|
| `scanned` | constants=15071 theorems=11257 formers=362 hypotheses=19578 closed=1473 | constants=15140 theorems=11323 formers=362 hypotheses=19705 closed=1473 |
| the rest | sites=30 conditions=40 … cohyp=58 hints=0 unseen=17512 fails=0 | sites=31 conditions=40 … cohyp=60 hints=0 unseen=17589 fails=0 |

No closed hypothesis enters (`closed=1473`), and no new `Prop`-former (`formers=362`): `IsUsablePrime` was declared a
condition by an earlier landing and stays one — no library *theorem* concludes it; the instances file exhibits one in
an `example` and builds one inside a proof.

**The hypotheses the step counts and cannot decide (`unseen` 17512 → 17589), read by hand, on this job's word.** One
of the 77 is the headline's `hUpper`, now undeclared: a condition proved by the library. Every other hypothesis of
the three modules but those of `chromaticNumber_eq_localBound_of_chain` is a condition on its theorem's own variables
— a prime usable or of a given cardinality (`h𝔭`, `hcard`, `hp`, `hp2`, `hp4`), a level (`hm`), a difference in the
local ring (`hd`), conjugation trivial modulo a given prime (`hram`), a valuation subring proper and stable (`hA`,
`hσ`), a nonzero natural (`hn`), radicands that are nonzero squares or divisible once (`hD`, `hs`, `hs0`, `hd0`, `hq`,
`hq2`, `_hd`, `_hd1`), a generator and its square (`hπ`, `hgen`), a colouring of a finite plane (`hk`), a unit vector
(`hu`). None is a hand result of this project or an outside theorem written out in a binder. The chain theorem's own
remaining co-hypothesis is `hL : localBound F ≤ 5`, a condition on the field.

**`ARCHITECTURE.md`** § Trust, "Assumed as hypotheses", brought to what the step prints: "106 pairs, 52 statements";
thirty-four entries; "Hand results of ours — twenty-two: twelve named, ten written out in a binder", the row `hUpper`
gone and the sentence saying where it went; nine rows' counts of takers each one higher (`BochnerHerglotz` 14,
`InvariantMeasureOnClosed` 8, `RU`, `PE2`, `EFPlus` 7, `APlusOfR88`, `Count` 4, `hRow99`, `hCLS` 4). Two older sentences
of the map that the landing makes false, corrected: § 7's "Field-level statements rest on hand arguments. Two steps
are not in the kernel …" (both steps are `Arith/UpperHalf`'s and `Arith/PlaceHom`'s now; what a named field still
needs is its primes), and the row `Instances/SqrtEleven`'s "The upper bound χ ≤ 4 … is not in the kernel".
`tools/check_architecture.py`: exit 0, "RESULT: PASS" (`probes/arch-probe.out`).

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/assumptions.sh` | 106–122 s | 0.65–0.72 GiB | 4.55 GiB |
| `./scripts/assumptions.sh --self-test` (33 checks) | 119 s | 0.70 GiB | 4.59 GiB |

## Stage 5 — SAVED (FS131-LU1): the vacuity step — the scan is silent on the module, so every model is named by hand

`./scripts/vacuity.sh` on the built tree (`data/fs131/lu1/probes/vacuity-given.log`; its full output
`probes/receipt-vacuity-given.log`): **exit 0, "vacuity: OK"**. Its self-test (`probes/vacuity-selftest-probe.log`):
"OK — all 65 controls behaved: every one fired, and the silent ones stayed silent."

| | `main` (FS131-LC1's gated scan) | this tree |
|---|---|---|
| declarations | 15969 | **16029** (+60: the three modules' constants that are not internal, 36 + 14 + 10) |
| refutations-skipped | 228 | 228 |
| sites | 1454 | 1454 |
| vacuous / stale / declared / witnessed / generic / unknown | 0 / 0 / 3 / 38 / 1411 / 2 | 0 / 0 / 3 / 38 / 1411 / 2 |

**How the scan classes every new site: there is none.** Row for row against the last landing's gated scan
(`tools/fs131_l5_vacdiff.py`, `probes/vacdiff-probe.txt`): "main rows 1535, landing rows 1535; lost 0 …; added 0";
"module Arith.QuadraticPrime: declarations 0 -> 14", "Arith.UpperHalf: 0 -> 36", "Instances.UpperHalfValues: 0 -> 10";
"by module: declarations +60, refutations +0: equal to the scans difference"; "vacdiff: PASS". No declaration of the
module is skipped as a refutation; nothing reads `VACUOUS`, `STALE` or `UNKNOWN`; the baseline's two entries are as on
`main`. **The scan reads none of the module's binders**: no hypothesis is a colouring structure, the one
colourability hypothesis (`hk : (finitePlane p).Colorable k`) is a proposition the scan does not track, and the
structures the theorems range over — a usable prime, a stable prime — are not its carriers. **Silence is not
evidence** (`LEAN.md` § The gate), so each model is named below.

**The baseline header's count line refiled from this scan** (`scripts/gate_report.py header` on the scan's output,
written into `scripts/vacuity-baseline.txt`; no entry touched): `declarations=15969` → `declarations=16029`. Refiled
before the pass, so that the gated commit holds the header its own scan confirms.

**The model of each hypothesis of the headlines, by hand**, and whether the kernel holds it — "library" is a theorem
or an `example` of a module, checked in the build; "term" is a theorem of `data/fs131/lu1/checks.lean`, kernel-checked
when the gate's pass elaborates it and not a library theorem (every term on the standard three unless said). The
table is FS131-IV1's (its drafts § 2), each line read again against the built modules:

| statement | its hypotheses | the model | held |
|---|---|---|---|
| the five NF1-S1A statements (`nonempty_hom_unitQuadrance` … `colorable_planeOver_of_finitePlane`) | a real number field; `IsUsablePrime 𝔭`; for three of them `p` prime with `Nat.card (𝓞 F ⧸ 𝔭) = p` | **`ℚ(√11)` at 7 — the library's first model of `IsUsablePrime`**: the instances file's third `example`, through `QuadraticPrime.exists_maximal_card_eq`; `chromaticNumber_planeOver_eleven` runs the bound there, and the two other instance theorems at `ℚ(√167)`, 23 and `ℚ(√47)`, 11. `FS131LU1.usablePrime_model` holds every hypothesis and both bounds at once | library; the joint form a term |
| the NF1-S1B statements (`mem_localRing` … `exists_hom_levelTarget`, `chromaticNumber_planeOver_le_levelTarget`) | a real number field; `P : StablePrime F`; `1 ≤ m`; in the formula, a difference in `𝓞_P` | **two fields**: `ℚ` with `UpperHalf.exists_stablePrime_rat` (the instances file's second `example`: `Nonempty (StablePrime ⊥)`), and the standing field with `StandingFive.exists_stablePrime_two` (an older theorem). Every `m ≥ 1` (at `m = 0` the statement is false and its docstring says why); the formula's hypothesis holds of any two points one unit apart (`mem_localRing_of_mul_conj_eq_one`: the proof uses it exactly there) | library at `ℚ`; at the standing field a term (`FS131LU1.hom_standing_model`) |
| `chromaticNumber_planeOver_le_localBound` | a real number field | no hypothesis to model; **not empty of content at `ℚ`**: the infimum is over an inhabited family (the instances file's first two `example`s), and `2 ≤ L(ℚ)` (`FS131LU1.two_le_localBound_rat`). At a field with no stable prime it would read `χ ≤ ⊤`; that every real number field has one is not in the kernel | library; the lower bound on `L(ℚ)` a term |
| **`two_mem_of_conj_trivial`, `colorable_two_planeOver_of_ramified`** | `P : StablePrime F` and **`hram : ∀ x, conjO F x - x ∈ P.P`** | **the stable prime of the rational field**: `UpperHalf.exists_stablePrime_rat`'s third clause, at `F = ⊥` with `instNumberFieldBot`. `UpperHalf.chromaticNumber_planeOver_rat` applies the two-colour theorem at it. **It is the only inhabitant the library holds**, and `hram` is a real condition: at the standing field it fails at every stable prime (`StandingFive.exists_conjO_sub_notMem`; `FS131LU1.hram_fails_at_standingField`) | library (`chromaticNumber_planeOver_rat`); `two_mem_of_conj_trivial` at it a term (`two_mem_model`) |
| `exists_stablePrime_of_valuationSubring` | `A ≠ ⊤`; `A` stable under conjugation | `𝓞_P` for any stable `P` (`localRing_ne_top`, `conj_mem_localRing`, same file); its consumer `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` uses it in general | library through the consumer; at `ℚ` a term (`converse_rat_model`) |
| `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` | a real number field; `n ≠ 0` | both sides of the iff occur: `n = 2` at `ℚ`, where a stable prime holds 2 and so `1/2 ∉ ℤ[U_ℚ]` (`wall_rat_model`); `n = 1` at the standing field, where both sides hold (`one_standing_model`) | terms |
| `chromaticNumber_eq_localBound_of_chain` | a totally real number field; `BochnerHerglotz`, `InvariantMeasureOnClosed`, an `Interface` with `Count`, `APlusOfR88`, `RU`; `hMR`, `hCLS`, `hRow99`; `localBound F ≤ 5` | **none in the kernel, and none is expected here**: nine of these are the chain's declared assumptions (stage 4), not conditions with a model; the theorem is the older headline less one hypothesis, and is as conditional as the ledger says | — (as on `main` for the headline) |
| `exists_ringHom_zmod_of_padic`, `exists_maximal_card_of_padic`, `isMaximal_ker_and_card` | a ring homomorphism `K →+* ℚ_[p]`; a prime `p` and `f : R →+* ZMod p` | `algebraMap ℚ ℚ_[5]`: `Arith/QuadraticPrime`'s first `example` | library |
| `exists_padicInt_sq_eq`, `nonempty_ringHom_padic`, `exists_maximal_card_eq`, `exists_maximal_card_eq_sqrt` | an odd prime; every radicand a nonzero square modulo it (and, for the last, `Squarefree d`, `1 < d`, `d ≡ s²`, `s ≢ 0`) | `({11}, 7)` and `(47, 11, s = 5)`: its second and third `example`s | library |
| `exists_maximal_card_eq_of_ramified` | the same on `D`; `p ∣ q`; `¬ p² ∣ q` | `D = {3}`, `q = 11`, `p = 11`, the field `ℚ(√3, √11)`: its fourth `example` — every hypothesis at once. **Jointly satisfiable only at `q ∉ D`, `q ≠ 0`** (`FS131LU1.ramified_radicand_notMem`, `ramified_radicand_ne_zero`): its docstring now says so. The dated line's counterexample is refused by `hD` (`two_notMem_of_hD`; the file's fifth `example`) | library; the two facts terms |
| `nonempty_ringHom_zmod_of_ramified_sqrt` | a subfield `K₀` embedded in `ℚ_p`, `p` odd, `π² = q`, `p ∣ q`, `¬ p² ∣ q`, `K₀ ∪ {π}` generating `K` | no `example` of its own: the model is built inside the proof of `exists_maximal_card_eq_of_ramified` (`K₀` the copy of `ℚ(√D)` in `ℚ(√D, √q)`, `π = √q`) and instantiated by the fourth `example` at `ℚ(√3) ⊂ ℚ(√3, √11)` | library, through that proof |
| `numberField_fieldOfRadicands`, `instNumberFieldFieldOfRadicands`, `numberField_bot` | `D` finite | `{3, 11, 5}`: the sixth `example`; `∅` for `ℚ` | library |
| `colorable_planeOver_fieldOfRadicands` | `D` finite; a prime `p ≡ 3 (mod 4)`; every radicand a nonzero square modulo it; **`(finitePlane p).Colorable k`** | `({11}, 7, 4)` with `finitePlane7_colorable_four`; `({167}, 23, 8)` with `CayleyCert.colorable_finitePlane23_eight`; `({47}, 11, 5)` with `chromaticNumber_finitePlane11` — the three instance theorems, each an older kernel theorem on the standard three | library |
| `two_le_chromaticNumber_planeOver` | none (any subfield of `ℝ`) | — | — |

**No hypothesis of a headline that is a condition is without a kernel model; four are held as terms only**
(open gate item 3). **No older statement is emptied or made vacuous by this landing**: it brings no axiom and no
carrier. **One older hypothesis is made provable**: `hUpper` (stage 4).

| step, this machine | wall | peak (charged) | max-rss |
|---|---|---|---|
| `./scripts/vacuity.sh` | 138 s | 0.59 GiB | 4.48 GiB |
| `./scripts/vacuity.sh --self-test` (65 controls) | 138 s | 0.60 GiB | 4.50 GiB |

## Stage 6 — SAVED (FS131-LU1): read aloud — each headline against its claim line and the dated lines

*Read from the kernel's side: the statements below are as `#check` prints them from the built modules
(`data/fs131/lu1/probes/checks-given.log`), not as the files print them. Throughout: "a real number field `F`" is
`F : Subfield ℝ` with `[NumberField ↥F]` — a subfield of `ℝ` of finite degree over `ℚ`; its plane is `planeOver F ⊆ ℂ`,
the points whose two coordinates lie in `F`; `χ` of it is `((unitDistance ℂ).induce (planeOver F)).chromaticNumber`,
Mathlib's `SimpleGraph.chromaticNumber`, a value in `ℕ∞` — the least `n` with a proper `n`-colouring, `⊤` if none. The
coordinator was sent the differences before the gate; they are accepted (the brief's Amendment 1) and are the claim
list's dated line of 20:39 UTC.*

### NF1-S1A — term for term

> NF1-S1A: For a real number field `F` and `𝔭` with `Arith.IsUsablePrime 𝔭`: `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))`; and `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime.

| the claim's clause | the kernel's statement | read |
|---|---|---|
| `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))` | `UpperHalf.chromaticNumber_planeOver_le_unitQuadrance : ∀ (F : Subfield ℝ) [NumberField ↥F] {𝔭 : Ideal (𝓞 ↥F)}, Arith.IsUsablePrime 𝔭 → (induce (planeOver F) (unitDistance ℂ)).chromaticNumber ≤ (unitQuadrance (𝓞 ↥F ⧸ 𝔭)).chromaticNumber` | every clause; **no hypothesis Lean has that the claim lacks, none the claim has that Lean does not need** |
| `≤ χ(finitePlane p)` when `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime | `UpperHalf.chromaticNumber_planeOver_le_finitePlane : … → ∀ {p : ℕ}, Nat.Prime p → Nat.card (𝓞 ↥F ⧸ 𝔭) = p → … ≤ (finitePlane p).chromaticNumber` | every clause. The two hypotheses force `p ≡ 3 (mod 4)` (`FS131LU1.usable_card_mod_four`); the claim does not say so and need not |

Beside them, with no claim line of their own and saying no more: the homomorphisms themselves
(`nonempty_hom_unitQuadrance`, `nonempty_hom_finitePlane`: `Nonempty (… →g …)`, a homomorphism **into** the target)
and the form the instances call (`colorable_planeOver_of_finitePlane`). The dated line ("both clauses follow in four
lines from `Arith.placeHom_base` and `Arith.exists_hom_of_isPlaceHom`") is what the proofs read.

### NF1-S1B — the claim's forms are corollaries; one hypothesis more in the wider form

> NF1-S1B: For a real number field `F` and `P : SpectralChain.StablePrime F`: a graph homomorphism from the unit-distance graph on `planeOver F` into `SpectralChain.levelTarget P 1`; so `χ(planeOver F) ≤ SpectralChain.localBound F`. Converse half for row 105: a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime.

| the claim's clause | the kernel's statement | read |
|---|---|---|
| a graph homomorphism … into `levelTarget P 1` | `UpperHalf.nonempty_hom_levelTarget_one : ∀ {F : Subfield ℝ} [NumberField ↥F] (P : StablePrime F), Nonempty (induce (planeOver F) (unitDistance ℂ) →g levelTarget P 1)` | term for term. **Into**: nothing here or in its proof is a surjection, and the module docstring says the target is every norm-one element of the quotient, not the image of the unit vectors |
| (the dated line: every level `m ≥ 1`) | `UpperHalf.exists_hom_levelTarget : … (P : StablePrime F) {m : ℕ}, 1 ≤ m → ∃ h, ∀ (x y : ↑(planeOver F)) (hd : ⟨↑x, ⋯⟩ - ⟨↑y, ⋯⟩ ∈ P.localRing), h x - h y = (P.residue m) ⟨⟨↑x, ⋯⟩ - ⟨↑y, ⋯⟩, hd⟩`; `chromaticNumber_planeOver_le_levelTarget` | **Lean has `1 ≤ m`, which the claim (at `m = 1`) does not need to say**; at `m = 0` the statement is false. Wider than the claim by the level and by the formula, which names the map on each coset of `𝓞_P` and on nothing else: the homomorphism is not canonical (an additive constant per coset is chosen) |
| so `χ(planeOver F) ≤ localBound F` | `UpperHalf.chromaticNumber_planeOver_le_localBound : ∀ (F : Subfield ℝ) [NumberField ↥F], (induce (planeOver F) (unitDistance ℂ)).chromaticNumber ≤ localBound F` | term for term. `localBound F` is an infimum in `ℕ∞` over the stable primes; with none it is `⊤` and the statement says nothing — its docstring says so |
| a conjugation-stable valuation subring of `fieldI F` other than the field is the localization at a stable prime | `UpperHalf.exists_stablePrime_of_valuationSubring : … (A : ValuationSubring ↥(fieldI F)), A ≠ ⊤ → (∀ z ∈ A, (conjOn ⋯) z ∈ A) → ∃ P, P.localRing = A` | "other than the field" is `A ≠ ⊤`; "conjugation-stable" is "conjugation maps `A` into `A`" (an involution: then onto); "the localization" is `P.localRing`, Mathlib's `valuationSubringAtPrime`, whose elements are the `a / s` with `s ∉ P` (`mem_localRing`). Existence only: uniqueness of `P` is true and not stated |

`[NumberField ↥F]` is the claim's "real number field" in every line. With `conj_mem_localRing` and
`localRing_ne_top` the correspondence runs both ways.

### NF1-S2 — the first sentence in two forms, one wider than the dated line; the second as corrected

> NF1-S2: For squarefree `d > 1`, `F = ℚ(√d) ⊂ ℝ` with its `NumberField` instance, and an odd prime `p` with `d ≡ s² ≢ 0 (mod p)`: a maximal ideal `𝔭` of `𝓞 F` with `Nat.card (𝓞 F ⧸ 𝔭) = p`. The same for a multiquadratic field at a prime where every radicand is a square, a ramified radicand included (11 in `K`).

| the claim's clause | the kernel's statement | read |
|---|---|---|
| the first sentence, as claimed | `QuadraticPrime.exists_maximal_card_eq_sqrt : ∀ {d : ℕ}, Squarefree d → 1 < d → ∀ {p : ℕ}, Nat.Prime p → p ≠ 2 → ∀ {s : ℕ}, ↑d = ↑s ^ 2 → ↑s ≠ 0 → ∃ 𝔭, 𝔭.IsMaximal ∧ Nat.card (𝓞 ↥(fieldOfRadicands {d}) ⧸ 𝔭) = p` | clause for clause; the casts are into `ZMod p`. **Two hypotheses the claim has and Lean does not need**: `Squarefree d` and `1 < d` are carried and unused (the docstring says so). "With its `NumberField` instance" is not a hypothesis of the statement — `𝓞` is defined for any field — and is a theorem and an instance of their own (`numberField_fieldOfRadicands`, `instNumberFieldFieldOfRadicands`) |
| (the dated line: neither squarefree nor `d > 1`; "any finite set of such radicands") | `QuadraticPrime.exists_maximal_card_eq : ∀ (D : Set ℕ) {p : ℕ}, Nat.Prime p → p ≠ 2 → (∀ d ∈ D, ↑d ≠ 0 ∧ IsSquare ↑d) → ∃ 𝔭, 𝔭.IsMaximal ∧ Nat.card (𝓞 ↥(fieldOfRadicands D) ⧸ 𝔭) = p` | **says more than the dated line: any set `D`, finite or not.** True as stated; for infinite `D` the ring is all algebraic integers of an infinite extension, no Dedekind domain, and no consumer reads it there (the instances take `[Finite ↑D]`) |
| the second sentence, false as written, standing with the dated line's hypothesis | `QuadraticPrime.exists_maximal_card_eq_of_ramified : ∀ (D : Set ℕ) (q : ℕ) {p : ℕ}, Nat.Prime p → p ≠ 2 → (∀ d ∈ D, ↑d ≠ 0 ∧ IsSquare ↑d) → p ∣ q → ¬p ^ 2 ∣ q → ∃ 𝔭, 𝔭.IsMaximal ∧ Nat.card (𝓞 ↥(fieldOfRadicands (insert q D)) ⧸ 𝔭) = p` | "the other radicands nonzero squares modulo `p`, at most one radicand divisible by `p`, and `p²` not dividing it": one radicand divisible is this theorem, none is the line above. "11 in `K`" is its fourth `example`, `ℚ(√3, √11)` at 11. Its hypotheses can hold together only at `q ∉ D` (stage 2's note) |

Under these, as theorems of their own and with no claim line: `exists_maximal_card_of_padic` and
`exists_ringHom_zmod_of_padic` (any field that embeds in `ℚ_p`, **`p = 2` included**), `isMaximal_ker_and_card`,
`exists_padicInt_sq_eq`, `nonempty_ringHom_padic`, `nonempty_ringHom_zmod_of_ramified_sqrt`.

### NF1-MODULE — the four values, and the kernel theorem that holds each other half

| the claim's value | the kernel's statement | upper half | lower half, by name, with its axioms as `#print axioms` gives them |
|---|---|---|---|
| `χ(ℚ(√11)²) = 4` | `UpperHalf.chromaticNumber_planeOver_eleven : (induce (planeOver (fieldOfRadicands {11})) (unitDistance ℂ)).chromaticNumber = 4` | this module, the prime above 7 (`11 ≡ 2²`), with the older `finitePlane7_colorable_four` | **`four_le_chromaticNumber_planeOver_eleven`** (`Instances/SqrtEleven`, row 73; a 204-point witness) — `[propext, Classical.choice, Quot.sound]` |
| `χ(ℚ²) = 2` | `UpperHalf.chromaticNumber_planeOver_rat : (induce (planeOver ⊥) (unitDistance ℂ)).chromaticNumber = 2` (`⊥ : Subfield ℝ` is the image of `ℚ`) | `colorable_two_planeOver_of_ramified` at `exists_stablePrime_rat`, over the older `colorable_two_unitDistance_induce_of_valuationSubring` | **`UpperHalf.two_le_chromaticNumber_planeOver`** (this module: `0` and `1` are a unit apart) — the standard three. The map said the kernel held this half; it did not by name |
| `χ(ℚ(√167)²) ≤ 8` | `UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight : … ≤ 8` | the prime above 23 (`167 ≡ 11²`), with the older `CayleyCert.colorable_finitePlane23_eight` | no equality is claimed. The held lower bound is `four_le_chromaticNumber_planeOver_sqrt167` (row 119), the standard three: `4 ≤ χ ≤ 8` |
| `χ(ℚ(√47)²) ≤ 5`, the control | `UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime : … ≤ 5` | the prime above 11 (`47 ≡ 5²`), with the older `chromaticNumber_finitePlane11` | no equality is claimed. **The same statement** as `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five` (its field `F47` is an abbreviation of `fieldOfRadicands {47}`): an equation between the two proofs typechecks by `rfl` (`checks.lean`, its last `example`) — two proofs of one proposition |

Each of the eight older theorems named above prints `[propext, Classical.choice, Quot.sound]` (the pass's
`checks-final.out`). The general statement they are instances of is `colorable_planeOver_fieldOfRadicands`.

### NF1-NC — clause by clause, with the dated line of 20:39 UTC

- "any lower bound for a plane over a field" — **the module holds one**: `two_le_chromaticNumber_planeOver`, `2 ≤ χ`
  for the plane over every subfield of `ℝ`. The dated line now reads the clause as "no lower bound above two". The
  equality at `ℚ(√11)` does state `4 ≤ χ`; that half is the older theorem's, as the claim's last clause says.
- "anything above level one of a tower" — true at usable primes (`𝓞 F ⧸ 𝔭` only); at stable primes the dated line's
  widening stands, every level `m ≥ 1`.
- "`[S2]` at a prime where some radicand is not a square" — not stated: `hD` asks every member of `D` to be a nonzero
  square, and the dated line's counterexample is refused (`FS131LU1.two_notMem_of_hD`).
- "that an instance's value is new mathematics" — no docstring says so: the instances file's header ("**Not
  claimed:** that any of these values is new mathematics"), `χ(ℚ(√11)²) = 4` ("The upper bound is `[Fischer1990]`'s;
  the kernel proof of both halves is what is here"), `χ(ℚ²) = 2` ("Woodall's value").
- "that the upper half alone gives any exact value" — each of the two equalities is `le_antisymm` of this module's
  upper half and a lower half named above.

### Theorems of the module with no claim line

`two_mem_of_conj_trivial` and `colorable_two_planeOver_of_ramified` (row 63's two-colour theorem at a real number
field; needed for `χ(ℚ²) = 2`); `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` (row 105 read over the stable
primes — the one reader of the converse half); `chromaticNumber_eq_localBound_of_chain` (below); the API of the three
definitions (`mem_localRing`, `residue_algebraMap`, `residue_div`, `residue_conj`, `isUnit_mk_pow`, …).

### The brief's four sentences (§ Why this job)

- "a plane over a real number field maps homomorphically into each of its residue targets, so it needs no more
  colours than they do" — `nonempty_hom_unitQuadrance`, `exists_hom_levelTarget` and the three inequalities. Into.
- "the bound by the local bound for every real number field" — `chromaticNumber_planeOver_le_localBound`, the
  standard three.
- "the five-colour chain's headline with one of its named hypotheses discharged" —
  `UpperHalf.chromaticNumber_eq_localBound_of_chain`. As the kernel prints the two, the new theorem is
  `SpectralChain.chromaticNumber_eq_localBound` with exactly one binder gone, `(induce (planeOver F) (unitDistance
  ℂ)).chromaticNumber ≤ localBound F`, and every other binder the same in the same order. **Two things a reader
  should be told**: it is a new theorem beside the headline — the headline's own statement is unchanged and still
  takes `hUpper`; and "on the standard three axioms" is true of its `#print axioms` and it remains conditional on nine
  declared hypotheses (stage 4), none of which this module touches.
- "the plane over the field of the square root of 11 needs exactly four colours; the rational plane exactly two" —
  the two equalities, each on the standard three, each with its lower half named above.

### What the read-aloud changed in the module's docstrings

Five edits, no statement (stage 2 lists them): the three the brief names, and two found here — the wrong file name
and "exhibited" in `Arith/UpperHalf`'s header, and "Not claimed: anything at `p = 2`" in `Arith/QuadraticPrime`'s.

**One word for the drafts**: the planner's draft for `LEDGER.md` row 57 says "a homomorphism of the plane onto every
level target". It is **into**; this record's draft says so, and the coordinator files that wording.
