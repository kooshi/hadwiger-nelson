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

*The gate is green on one commit, `c2f4e4f54` (stage 8). This job proved no theorem: it landed the module's three
files — 49 theorems and 3 definitions, each [kernel], each on exactly the standard three axioms — and the list, one
line per declaration with its banner and its axioms as the audit printed them, is § "Theorems this phase proved,
final". In short: for every real number field the plane maps homomorphically into each of its residue targets, so
`χ(F²) ≤ χ(Γ_q)` at a usable prime and `χ(F²) ≤ L(F)`; a degree-one prime at fields of square roots; `χ(ℚ(√11)²) = 4`
and `χ(ℚ²) = 2` in both halves, `χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` a second way; the chain's headline without its
upper half, conditional on nine declared hypotheses. **None of the values is new mathematics.***

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

Each of the seven older theorems named above, and this module's `two_le_chromaticNumber_planeOver`, prints
`[propext, Classical.choice, Quot.sound]` (the pass's `checks-final.out`). The general statement they are instances of is `colorable_planeOver_fieldOfRadicands`.

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

## Stage 7 — SAVED (FS131-LU1): before the pass — `main` merged once more, the copied files' manifest, the two planted controls

**`main` merged in again** (`data/fs131/lu1/merge-2.out`): it had moved to `3087fe75d` — 11 paths, `data/` and
`plans/` only — carrying the brief's Amendment 1 and the claim list's dated line of 20:39 UTC; trial clean, merged by
hash, automatic (`6e6cf60a2`), so that the commit the gate reads holds them. The brief's quotations checked again on
the merged tree: 8 of 8 (`readback-tree.out`). The drafts' slots read on `main` at that commit
(`data/fs131/lu1/drafts-slots.py`): 29 of 29 found exactly once, the control absent.

**The tree the compiled modules were copied from is gone.** `.claude/worktrees/fs131-wkc` was removed by another
hand at about 20:25 UTC (the directory `worktrees/` was last written then; `git worktree list` no longer shows it) —
after this job's copy and its after-check (20:21 UTC) and during its first build. Nothing of this job's wrote there
(`rsync` from it, no `--delete`). So the comparison of stage 1 cannot be made again; what stands in its place:
- the three listings made then (`rsync-dry.out`, `rsync-real.out`; the dry run after the copy listed only the three
  excluded sourceless modules);
- **a manifest of every `.olean` of `Proofs` in this tree** — SHA-256 and time — made after the first build
  (`data/fs131/lu1/olean-manifest.txt`, 1,902 files; `compiled_unchanged.py`): every file but the four this landing
  recompiles carries a time **earlier than the copy** — the latest is 19:44:17 UTC, `Plane/LebesgueNumber`, the last
  landing's final pass; the import's ten modules carry 18:32–18:39 UTC, its 47-minute build — so no compiler has
  written any of them in this tree. The pass checks the tree against the manifest again; its four plants (a hash
  altered, a time moved past the copy, a file gone, a file added) each fire;
- from the kernel's side, the pass dumps the last landing's three modules as this tree stores them and compares with
  that landing's own final dump (`data/fs131/lc1/gate/statements-final.compact`).

**The zero-`sorry` search's plant** (`data/fs131/lu1/sorry-plant.sh`, FS131-LC1's pointed at this module;
`sorry-plant.out`): a theorem with a `sorry` body appended to `Instances/UpperHalfValues.lean`, never built, never
committed — narrow lines 0 before, 1 with the plant, "PLANT FIRED: the search finds the planted sorry and nothing
else"; restored by `git checkout`, "RESTORED: the module is the text it was" (digest `09fe50cb…` before and after),
narrow lines 0 again, 0 tracked files modified.

**The lint's negative control** (`data/fs131/lu1/lint-plant.sh`; `lint-plant-run.out`): `theorem zz_lu1_lint_plant
[Nonempty ℕ] : (1 : ℕ) = 1 := rfl` planted at the end of `Instances/UpperHalfValues.lean` (never committed), built —
"build: OK — 200 of 200 batches, 3 module(s) rebuilt, **0 module(s) with warnings**, 6m11s" at `BATCH=10`
(`lint-plant-build.log`: `Arith.QuadraticPrime`, whose docstring had moved since the first build, the planted module,
the root; the build's own linters do not see the plant) — then the guarded lint: **exit 1**, "`unusedArguments`:
(2/2) Failed with 1 messages", "error: @zz_lu1_lint_plant 1 unused argument", and `synTaut` on the same plant
(`lint-plant.log`). Restored by `git checkout` under a trap: the digest is the one taken before, the plant's name in
the file 0 times. The script's last line reads "tracked files modified: 1": that one file is
`data/fs131/lu1/probes/measure.txt`, to which a probe of this job's own appended a line while the plant was building
(a slip: nothing should run beside a plant) — not the module. The pass's build recompiles the module and the root
from the restored text.

## Stage 8 — SAVED (FS131-LU1): the full gate on one commit — `c2f4e4f54` — green on its first pass

One pass is every step in order, one at a time under the slot (`data/fs131/lu1/run-gate.sh final 3087fe75d 10`,
launched from a snapshot copy; every log under `data/fs131/lu1/gate/` with its exit status on its last line;
`run-gate-final.head` records the commit — `c2f4e4f546c93f833d9c04a692d138a9a897cbc1` — and that no tracked file was
modified at its start; `run-pass-final.out` holds every step's exit; `measure-final.txt` every step's wall time and
memory; `summary-final.txt` the lines quoted below; 21:02Z–21:24Z, 22 minutes). **Every step exit 0 but the one planted
control that must exit 1** (the scan difference's plants); "tracked files modified after the pass: 0". It is the
**first** full pass of this job. Counts below are read from the saved logs.

| step | result, read from its saved log (`data/fs131/lu1/gate/`, tag `final`) | log | wall | peak (charged) / max-rss |
|---|---|---|---|---|
| build (`BATCH=10`, `--mem 10 --cpus 8`) | "build: OK — 200 of 200 batches, 2 module(s) rebuilt, **0 module(s) with warnings**, 5m48s" (`Instances.UpperHalfValues` and the root, recompiled from the text restored after the lint's control); lines holding "warning" in the build log: 1, that sentence; in Lake's full log: 0. Then `lake build --no-build Proofs`: "All targets up-to-date (5999 jobs)" | `build-final.log`, `receipt-build-final.log`, `build-final.rss`, `uptodate-final.log` | 352 s | the one compiler 4.3 GiB resident |
| `sorry` | narrow pattern over `Proofs/` and `Proofs.lean`: **0** lines; `\bsorry\b`: 24, all prose, `main`'s count; the search's plant fired before the pass (stage 7) | `sorry-narrow-final.txt`, `sorry-wide-final.txt`; `../sorry-plant.out` | — | — |
| `axiom` lines in `Proofs/` | 4 line-initial, as on `main` (three axioms and one line of a docstring's code block). **The landing brings none** | `axiom-lines-final.txt` | — | — |
| doubled names, after the build and before the audit | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)"; its self-test "OK — all 15 controls behaved: every planted fault fired, and every partner passed" | `dupnames-final.log`, `dupnames-selftest-final.log` | 5.2 s; 28 s | 0.52 / 4.35 GiB; 0.76 / 1.53 |
| every declaration in a block, before the audit | "declarations the landing brings: 52 (of 60 constants in 3 modules); with one line: 52; unfiled: 0; doubled: 0; `#print axioms` lines in the script: 7506, names twice: 0" | `unfiled-final.txt`, `decls-final.out` | 64 s (the dump) | 0.54 / 4.37 |
| axioms | "audited: **7506 records — 7447 clean on the standard axioms, 28 axiom-free, 26 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "axioms: OK". `CLAUDE.md` § Trust ledger flagged stale, "7395 clean → 7447" (draft 1) | `axioms-final.log`, `receipt-axioms-final.log` | 8.8 s | 0.71 / 4.51 |
| its self-test | "axioms self-test: OK — every planted fault fired, and every partner passed." (23 of 23; its two state-reading controls did not move: stage 3) | `axioms-selftest-final.log`, `receipt-axioms-self-test-final.log.xz` | 197 s | 1.18 / 4.92 |
| every declaration of the landing filed on what it rests on (`data/fs131/lu1/lu1_records.py`) | "records: PASS" — 52 under CLEAN on exactly the three; headlines 31 of 31; over the whole log 26 under IMPORTED (8 + 6 + 12), none of the landing's, none carrying two imports, none `sorryAx`; "plants: every one of 15 fired; the unplanted lists pass" | `records-final.txt`, `records-plant-final.txt`, `theorem-lines-final.txt` | — | — |
| the import's block with its two controls; the generated modules against the generator (regression checks: the audit script they read is edited) | "block: PASS — every record as filed; both controls fired"; "CHECK OK"; "SELF-TEST OK: 10 plants refused and 1 partner accepted" | `block-final.txt`, `port-check-final.txt`, `port-selftest-final.txt` | 43 s | (the tool's own slots) |
| vacuity | "scanned: **declarations=16029 refutations-skipped=228**"; "sites: **sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2**"; "vacuity: OK"; "recorded counts in scripts/vacuity-baseline.txt's header: match (9 of 9 compared)". Flagged stale, not failed: `CLAUDE.md` § The gate ("declarations 15969 → 16029"; draft 2) | `vacuity-final.log`, `receipt-vacuity-final.log` | 127 s | 0.60 / 4.50 |
| the scan against the last landing's, row for row | "main rows 1535, landing rows 1535; lost 0 …; added 0"; "by module: declarations +60, refutations +0: equal to the scans difference"; "vacdiff: PASS"; its plants: exit 1, as they must | `vacdiff-final.txt`, `vacdiff-plant-final.txt`, `count-modules-final.out` | 69 s (the counter) | 0.54 / 4.44 |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | `vacuity-selftest-final.log` | 130 s | 0.59 / 4.51 |
| assumptions | "assumptions: OK — 3 outside theorem(s) as axioms, with 26 theorem(s) resting on them; 19 named and **15** inline hypotheses (7 outside, **22** ours, 5 open), taken by **106** statement(s) and mentioned by 1"; "assumed: **axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1**"; the ledger's header "match (9 of 9 compared)"; `CLAUDE.md` § Trust ledger flagged stale, "inline 16 → 15, ours 23 → 22, takes 98 → 106" (draft 3); its self-test "OK — all 33 checks behaved" | `assumptions-final.log`, `receipt-assumptions-final.log`, `assumptions-selftest-final.log` | 114 s; 118 s | 0.66 / 4.56; 0.69 / 4.60 |
| architecture | "RESULT: PASS" | `arch-final.txt` | 4.0 s | — |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "Passed!"; its control red before the pass (stage 7) | `lint-final.log`; `../lint-plant.log` | 9.1 s | 0.85 / 4.93 |
| notes, as the last landing ran them | "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", `main`'s count (the check reads QA4's modules, none of this landing's); "self-test: OK (6 controls, 1 planted)" | `notes-l5-final.txt`, `notes-qa4-selftest-final.txt` | 3.7 s | — |
| **the statements as stored, against the dump made before the merge and before any edit** | "statements: PASS: no statement and no definition changed — 52 named constants compared in 3 module(s)"; "plants: every one of 4 fired; the unplanted pair passes" | `statements-final.txt`, `statements-plant-final.txt`, `statements-final.compact` | 4.2 s | 0.63 / 4.45 |
| the three edited files in text, block comments removed, against the commit before the edits (`0585a35c4`) | "SAME" three times (17,276, 18,686 and 8,063 characters of code); the plant "DIFFERS" three times; under `Proofs/` and `Proofs.lean` those three files differ from that commit and no other | `code-only-final.txt`, `code-only-plant-final.txt`, `proofs-diff-final.txt` | — | — |
| the statements by `#check`, their axioms, the models | no error, no warning; 46 prints: 45 on `[propext, Classical.choice, Quot.sound]` — the eighteen headline theorems; the ten that hold the other halves and the models' ground, nine older theorems and this module's `two_le_chromaticNumber_planeOver`; seventeen model terms — and one term on `[propext]`; the `rfl` between the two proofs at `ℚ(√47)` elaborates | `checks-final.out` | 3.2 s | 0.54 / 4.37 |
| the compiled library against the manifest (stage 7) | ".olean files of Proofs: 1902 in the tree, 1902 in the manifest; allowed to move: 4 (moved since the manifest: 3 …)"; "every other file: same SHA-256, same mtime, written before the copy (2026-10-13T20:21:30Z); the latest of them: 2026-10-13T19:44:17Z"; the import's ten modules and the last landing's three "identical"; "compiled-unchanged: PASS"; "plants: every one of 4 fired" | `compiled-unchanged-final.txt`, `compiled-unchanged-plant-final.txt` | 2.2 s | — |
| the last landing's three modules as this tree stores them, against that landing's own final dump | "statements: PASS: no statement and no definition changed — 87 named constants compared in 3 module(s)" | `statements-lc1-final.txt`, `statements-lc1-final.compact` | 2.7 s | 0.52 / 4.34 |
| the baseline and the scans' sources | "baseline entries: unchanged from main's (2)"; lines that differ from `main`'s (`3087fe75d`): `scripts/Axioms.lean` 67 (the block), `scripts/Assumptions.lean` 8, `scripts/assumptions-ledger.txt` 12, `scripts/vacuity-baseline.txt` 2 (the header's count line), and 0 in each of `scripts/Vacuity.lean`, the four control files, `DupNames.lean`, `gate_report.py`, the four gate scripts and `build.sh` | `baseline-final.txt` | — | — |
| the three digests against the previous landing's receipts (`data/fs131/lc1/gate/receipt-*-final.log`) | axioms: **52 rows added, none removed**, all CLEAN; vacuity: one count moves, "rows: none changed"; assumptions: `inline 16 → 15, ours 23 → 22, takes 98 → 106` — the entry, the site and the `TAKES` row of `inline:UpperHalf` removed; two `SITE` and nine `TAKES` rows added for the new theorem; nine hypotheses' counts of takers each one higher; two `COHYP` rows added (the headline's `hUpper`, now undeclared, and the new theorem's `hL`). **Stale against the front page until the drafts are filed, exactly these lines**: `CLAUDE.md` § Trust ledger — "7395 clean → 7447" and "inline 16 → 15, ours 23 → 22, takes 98 → 106"; `CLAUDE.md` § The gate — "declarations 15969 → 16029". The two headers on the branch match | `digest-axioms-final.txt`, `digest-vacuity-final.txt`, `digest-assumptions-final.txt` | — | — |

**What the measurements say, for the next landing on this machine**: as the last landing found — every
whole-library step is one `lean` process of 4.3 to 4.9 GiB resident, charged 0.5 to 1.2 GiB with the `.olean` pages
cached; `--mem 8` held every one. The whole pass is 22 minutes, six of them the walk.

**Read aloud against the informal claim.** The claim of this landing: "a plane over a real number field maps
homomorphically into each of its residue targets, so it needs no more colours than they do — at a usable prime, and at
a conjugation-fixed prime of `F(i)` at every level, hence `χ(F²) ≤ L(F)`; fields of square roots have a degree-one
prime at every odd prime modulo which their radicands are nonzero squares; so the plane over `ℚ(√11)` needs exactly
four colours and the rational plane exactly two, the plane over `ℚ(√167)` at most eight and over `ℚ(√47)` at most
five; and the chain's headline no longer assumes its upper half — all on the standard three axioms, none of the
values new." What the gate shows: no `axiom` and no `sorry` enters `Proofs/`; each of the 52 declarations the three
modules bring has one record under CLEAN on exactly the standard three; no name is declared twice, so each printed
list is the list of the proof the kernel checked; the one conditional theorem is listed in the ledger of what the
library assumes under each of its nine hypotheses, and the hypothesis the module proves has left that ledger; no
statement moved between the planner's skeleton, the implementers' builds and this commit. **What the gate does not
show, and this record says**: that each statement is its claim — stage 6, clause by clause; that the hypotheses can
be met — stage 5 names each model and how it is held, since the scan saw none of them; that the assumptions step
would have noticed the discharged hypothesis — it would not (stage 4); that the 117 modules the merge brought were
compiled here — they were copied (stages 1, 7); that any value is new — none is.

## Drafts for the front page (FS131-LU1)

*For the coordinator to file; nothing here is filed by this job. Each names its slot — the file, the section, and **the
exact words on `main` it replaces or follows**, each asserted to occur exactly once on `main`
(`data/fs131/lu1/drafts-slots.py`, output `drafts-slots.out`: 29 of 29, the control absent; read last on `main` at `b937f33d1`) — and the log line it comes from. The
gated commit is `c2f4e4f546c93f833d9c04a692d138a9a897cbc1`; its logs are `data/fs131/lu1/gate/*-final.*` (`receipt-axioms-final.log`,
`receipt-vacuity-final.log`, `receipt-assumptions-final.log` are the three scans' full outputs). **Every draft says
whose the mathematics is: the values and the upper bounds are prior art; the kernel proofs are this project's; nothing
moves the answer.** "Into" is the word for every homomorphism of a plane to a residue target.*

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 7395 clean and 5 declared
purchases, and 26 imported (and 28 axiom-free; 7,454 records at the landing of FS-131's measurable number, FS131-LC1,
2026-10-13)" — from `axioms-final.log`, "audited: 7506 records — 7447 clean on the standard axioms, 28 axiom-free, 26
imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 7447 clean and 5 declared purchases, and 26 imported (and 28 axiom-free; 7,506 records at the
> landing of FS-131's first number-field module, the residue upper half, FS131-LU1, 2026-10-13)

7395 + 52 = 7447 (the landing's 52 records, each under CLEAN on exactly the three: `records-final.txt`); 7,454 + 52 =
7,506; axiom-free, imported and purchases do not move. Until it is filed the audit flags the sentence stale (not
failed): "7395 clean → 7447". The rest of the paragraph stands: the landing brings no import and no purchase.

**2. `CLAUDE.md` § The gate, the vacuity scan's two count lines.** *Replaces* "`declarations=15969
refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." — from
`vacuity-final.log`, "scanned: declarations=16029 refutations-skipped=228", "sites: sites=1454 vacuous=0 stale=0
declared=3 witnessed=38 generic=1411 unknown=2" (runs of spaces collapsed):

> `declarations=16029 refutations-skipped=228 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

One count moves: declarations +60 (the three modules' constants that are not internal). **No site is added**: the
scan is silent on the module (stage 5). The sentences on the baseline's two entries stand; the baseline's header is
refiled on the branch from the scan.

**3. `CLAUDE.md` § Trust ledger, the nine assumption counts and their sentence.** *Replaces* "`axioms=3 rests=26
named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1` — three outside theorems declared as axioms, with
twenty-six theorems resting on them; thirty-five hypotheses, nineteen named and sixteen written out in a binder —
seven standing for outside theorems, twenty-three for hand results of ours and five declared as open questions — taken
in 98 (hypothesis, statement) pairs by 51 statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5,
2026-10-06)" — from `receipt-assumptions-final.log`, its `=== TOTALS ===` line, "axioms=3 rests=26 named=19 inline=15
outside=7 ours=22 open=5 takes=106 mentions=1":

> `axioms=3 rests=26 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1` — three outside theorems declared
> as axioms, with twenty-six theorems resting on them; thirty-four hypotheses, nineteen named and fifteen written out in
> a binder — seven standing for outside theorems, twenty-two for hand results of ours and five declared as open
> questions — taken in 106 (hypothesis, statement) pairs by 52 statements (`scripts/assumptions-ledger.txt` lists each
> pair; FS131-LT5, 2026-10-06; one hand result left the list at FS131-LU1, 2026-10-13: the upper half `χ(F²) ≤ L(F)` is
> the theorem `UpperHalf.chromaticNumber_planeOver_le_localBound`)

Three of the nine move: `inline` 16 → 15 and `ours` 23 → 22 (the entry `inline:UpperHalf` retired), `takes` 98 → 106
(one pair gone, nine entered: `UpperHalf.chromaticNumber_eq_localBound_of_chain` under each of the chain's nine
remaining hypotheses). The ledger is rewritten on the branch by the script (`--write-ledger`: nine rows gained, one
lost, 133 rows). The rest of the paragraph stands.

**4. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`** — one entry after the last (`(("7364", "5"), ("7395", "5")):`):

```python
    (("7395", "5"), ("7447", "5")): "FS-131, the landing of its first number-field module, the residue upper half — chi(F^2) <= chi of each residue target for every real number field (a homomorphism into each), a degree-one prime at fields of square roots, chi(Q(sqrt 11)^2) = 4 and chi(Q^2) = 2 in both halves, the chain's headline with its upper half discharged; known values and bounds, the kernel proofs ours (FS131-LU1; copy data/fs131/lu1/gate/receipt-axioms-final.log, gated commit c2f4e4f54): 7,506 records, 7,447 clean, 28 axiom-free, 26 imported, 5 purchases",
```

and, in the same file's table of superseded counts, in that table's own form: `"7395"` (7447 clean), `"7,454"` (7,506
records), `declarations=15969` (16029), `inline=16` (15), `ours=23` (22), `takes=98` (106), "thirty-five hypotheses"
(thirty-four), "sixteen written out" (fifteen), "twenty-three for hand results" (twenty-two), "98 (hypothesis,
statement) pairs by 51 statements" (106 by 52) — "superseded gate count, refiled at FS131-LU1's landing from
data/fs131/lu1/gate/receipt-axioms-final.log (the vacuity count from receipt-vacuity-final.log, the assumption counts
from receipt-assumptions-final.log); the old count stays in data/fs131/lc1/gate/ and in GATE_CHANGES". **The next
landing's previous receipts are `data/fs131/lu1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**5. `CLAUDE.md` § Grokkings, "The theory in one paragraph" — the sentence that says the upper bound is by hand.**
*Replaces* "A real number field's residue targets bound its plane, χ(F²) ≤ L(F) (row 52, G64; [hand]), and through"
*by*

> A real number field's residue targets bound its plane, χ(F²) ≤ L(F) (row 52, G64; [kernel] since FS131-LU1,
> `UpperHalf.chromaticNumber_planeOver_le_localBound`; the bound is prior art, the kernel proof ours), and through

The rest of that sentence ("through five the bound is exact … [hand]") stands: the lower halves are untouched.

**6. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval".** *Replaces* "**χ(ℚ(√11)²)
≥ 4** and the 3-adic barrier (rows 72–73);" *by*

> **χ(ℚ(√11)²) = 4**, both halves (`UpperHalf.chromaticNumber_planeOver_eleven`; the upper bound is `[Moorhouse2010]`'s
> and `[Fischer1990]`'s, the lower half row 73's witness, the kernel proof ours) and the 3-adic barrier (rows 72–73);
> **the residue upper half at every real number field** — the plane maps homomorphically into each residue target, so
> `χ(F²) ≤ χ(Γ_q)` at a usable prime and `χ(F²) ≤ L(F)` (`UpperHalf.chromaticNumber_planeOver_le_finitePlane`,
> `UpperHalf.chromaticNumber_planeOver_le_localBound`); a prime with residue field `𝔽_p` at every field of square roots
> whose radicands are nonzero squares modulo an odd `p`, one more radicand divisible by `p` once
> (`QuadraticPrime.exists_maximal_card_eq`, `…_of_ramified`); and with them `χ(ℚ²) = 2` in both halves (Woodall's
> value; the two-colour theorem's first instance over a real field), `χ(ℚ(√167)²) ≤ 8` and `χ(ℚ(√47)²) ≤ 5` a second way
> (rows 52, 57, 63, 105, 119, 121; FS131-LU1; known values and bounds, the kernel proofs ours);

**7. `CLAUDE.md`, the sentences on the field of the square root of 47 — each stays true as written; one gains a
clause.** The landing gives **no lower bound** at `ℚ(√47)`: unconditionally the kernel still holds one inequality
there, `χ(ℚ(√47)²) ≤ 5`, now by two proofs; `= 5` is in the kernel only given the chain's hypotheses. So "not in the
kernel, where row 127 holds it only over named hypotheses" (§ Where the problem stands) and "in the kernel only in row
127's conditional form" (§ Publication) **are not changed**. *Replaces* "**FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`,
and the main clause through five over named hypotheses (row 127);" *by*

> **FS-101's first slot** — `χ(ℚ(√47)²) ≤ 5`, and the main clause through five over named hypotheses, the upper half no
> longer one of them (row 127; `UpperHalf.chromaticNumber_eq_localBound_of_chain`, FS131-LU1: nine hypotheses remain);

*(Optional, § The local–global conjecture: "at least six at **ℚ(√167)**, proven 4 in the kernel (row 119) and ≥ 5 at
[hand] (row 123)" may add "and at most 8 in the kernel (the plane at 23, FS131-LU1)". Not drafted as a replacement: the
sentence is true as it stands.)*

**8. `LEDGER.md`, ten rows — each only as far as its leaf landed. Row 52's two values `χ(K(√5)²) = χ(K(√247)²) = 5`
are not in this module and stay [hand + tools].** The planner's drafts (`plans/FS131-KN2-upper-half-plan.md` § Stage
5) and FS131-IQ1's amendment, checked against what landed: every declaration named below is a theorem of the gated
commit under CLEAN on exactly the standard three (`records-final.txt`, `theorem-lines-final.txt`).

- **Row 52.** *Replaces the grade at the row's head* "| 52 | [hand + tools] **The finite-plane bound" *by* "| 52 |
  [kernel for the bound; hand + tools for the two values] **The finite-plane bound". *Follows* "and this row's bound
  says nothing about his field (G43)." —
  > **In the kernel** (the standard three): the residue homomorphism at a usable prime of any real number field
  > (`Arith.exists_placeHom`, FS-131 wave 2; with no transcendental, `UpperHalf.nonempty_hom_unitQuadrance`) and, since
  > FS131-LU1, the bound as an inequality of chromatic numbers (`UpperHalf.chromaticNumber_planeOver_le_unitQuadrance`,
  > `UpperHalf.chromaticNumber_planeOver_le_finitePlane`); a prime with residue field `𝔽_p` at every field of square roots whose
  > radicands are nonzero squares modulo an odd `p` (`QuadraticPrime.exists_maximal_card_eq`), and with one more
  > radicand divisible by `p` exactly once (`QuadraticPrime.exists_maximal_card_eq_of_ramified`). The two values stay
  > [hand + tools] until the ramified clause is applied at 11 to `K(√5)` and `K(√247)`: no file states those instances.
- **Row 57.** *Replaces* "**Not proved:** that a number field with a conjugation-fixed prime supplies the valuation
  subring with residue field of size N(𝔭)." *by*
  > **Proved for every real number field `F` and every conjugation-fixed prime `P` of `F(i)`** (FS131-LU1; [kernel],
  > the standard three): the valuation subring `𝓞_P` — Mathlib's localization at the prime, conjugation-stable
  > (`StablePrime.localRing`, `UpperHalf.mem_localRing`, `UpperHalf.conj_mem_localRing`) — with its residue map to
  > `𝓞 ⧸ P^m`, which commutes with conjugation (`StablePrime.residue`, `UpperHalf.residue_conj`); a homomorphism of the
  > plane **into** the level-`m` target for every `m ≥ 1` (`UpperHalf.exists_hom_levelTarget`); and conversely every
  > conjugation-stable valuation subring of `F(i)` other than `F(i)` is `𝓞_P` for such a prime
  > (`UpperHalf.exists_stablePrime_of_valuationSubring`). **Not stated:** the size of the residue field; that the
  > homomorphism is onto its target; that every real number field has such a prime.
- **Row 63.** *Replaces* "its plane and valuation forms have **no instance over a real field yet**; the only
  inhabitant is the ring form on ℤ[i], deferred to FS-37" *by*
  > over a real number field it is `UpperHalf.colorable_two_planeOver_of_ramified` — two colours at a
  > conjugation-fixed prime of `F(i)` modulo which conjugation is the identity, which then holds 2
  > (`UpperHalf.two_mem_of_conj_trivial`) — with **`χ(ℚ²) = 2`** as its instance, both halves
  > (`UpperHalf.chromaticNumber_planeOver_rat`, at `UpperHalf.exists_stablePrime_rat`; FS131-LU1, [kernel], the standard
  > three; the value is Woodall's); `ℚ` is the only field at which the library exhibits such a prime
- **Row 73.** *Replaces* "with the plane at 7 (`[Moorhouse2010]`, `[Fischer1990]`) **χ(ℚ(√11)²) = 4**." *by*
  > with the plane at 7 (`[Moorhouse2010]`, `[Fischer1990]`) **χ(ℚ(√11)²) = 4 — both halves [kernel] since FS131-LU1**
  > (`UpperHalf.chromaticNumber_planeOver_eleven`, the standard three: the upper half is the residue homomorphism at a
  > prime above 7 into `UD(𝔽₇, 2)` with `finitePlane7_colorable_four`; the upper bound is theirs, the kernel proof ours).
- **Row 99.** *Follows* "a kernel proof (FS-75)" (in the row's "Not claimed") —
  > — of which one leaf is in the kernel since FS131-LU1, the upper half `χ(F²) ≤ L(F)` for every real number field
  > (`UpperHalf.chromaticNumber_planeOver_le_localBound`); every other step of the row stays [hand]
- **Row 105.** *Replaces* "**Not claimed:** the number-field reading — the `σ`-stable valuation subrings with `p` in
  the maximal ideal are the conjugation-stable primes above `p` — which is row 57's gap (FS-37), and with it
  `ASTRA-2026-09-14-T7` beyond `K(√7)`; Lemma R." *by*
  > **The number-field reading, [kernel] since FS131-LU1**: for a real number field `F` and `n ≠ 0`, `1/n ∈ ℤ[U_F]` iff no
  > conjugation-fixed prime of `F(i)` holds `n` (`UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`), the
  > conjugation-stable valuation subrings of `F(i)` other than `F(i)` being the localizations at those primes
  > (`UpperHalf.exists_stablePrime_of_valuationSubring`). **Not claimed:** the reading applied at any named field
  > (`K(√7)`'s "every prime above 2 splits in `K(√7)(i)`" is not stated); `ASTRA-2026-09-14-T7` beyond `K(√7)`; Lemma R.
- **Row 119.** *Follows* "The conjecture's widest gap has its kernel lower end here (four; five at [hand], row 123; at
  least six predicted; G59)." —
  > Its kernel upper end is eight: `χ(ℚ(√167)²) ≤ 8` (`UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight`, FS131-LU1:
  > the residue homomorphism at a prime above 23 with `CayleyCert.colorable_finitePlane23_eight`), so `4 ≤ χ ≤ 8` in the
  > kernel.
- **Row 121.** *Follows* "in the kernel only over named hypotheses, row 127" (inside the grade's bracket) —
  > ; the upper half `χ ≤ 5` alone is [kernel] with no hypothesis, by two proofs of one statement
  > (`SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`; `UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime`,
  > the residue homomorphism at a prime above 11, FS131-LU1)
- **Row 123.** *Follows* "the upper half is the residue map at the place realising `L(F)` (row 52)" —
  > — [kernel] since FS131-LU1 for every real number field (`UpperHalf.chromaticNumber_planeOver_le_localBound`)
- **Row 127.** *Replaces* "and, for the equality, the upper half `hUpper` (row 57's gap);" *by*
  > and, for the equality, the upper half `hUpper` — **a theorem since FS131-LU1**
  > (`UpperHalf.chromaticNumber_planeOver_le_localBound`), so that `UpperHalf.chromaticNumber_eq_localBound_of_chain` is
  > the equality without it, on the standard three and on the nine hypotheses that remain (`BochnerHerglotz`,
  > `InvariantMeasureOnClosed`, `Interface.Count`, `Interface.APlusOfR88`, `Interface.RU`, `Interface.PE2`,
  > `Interface.EFPlus`, and the two written out, CLS and row 99);

**9. `LEAN.md` § The gate, the bullet on `./scripts/assumptions.sh` — the corrected sentence** (asked for by the
brief's Amendment 1). *Replaces* "on a declared hypothesis no statement takes, or one a theorem proves over its own
variables;" *by*

> on a declared hypothesis no statement takes, or — **a named hypothesis only** — one a theorem proves over its own
> variables (`FAIL discharged`); **an assumption written out in a binder and declared by `.site` is retired, as it is
> declared, on the landing's own word**: the step compares no binder's type with any theorem's conclusion, so it
> passes with a discharged entry left in (`hUpper` of `SpectralChain.chromaticNumber_eq_localBound`, proved by
> `UpperHalf.chromaticNumber_planeOver_le_localBound` and retired by FS131-LU1 — its record's stage 4 has the
> receipt);

**10. The tooling list — one line** (asked for by the brief's Amendment 1; the list is the coordinator's):

> `scripts/Assumptions.lean` finds a discharged named hypothesis (`FAIL discharged`: a theorem concluding `H x₁ … xₙ`
> over its own distinct variables with no hypothesis) and cannot find a discharged `.site`. A check on a site (theorem
> `T`, binder `h`) would have to read `h`'s stored type under `T`'s earlier binders and ask whether some library
> theorem other than `T` and its own corollaries proves it there — its conclusion unifying with that type up to
> instance arguments, its hypotheses among `T`'s earlier binders or instances; a first cut compares head symbol and
> constants and then tries one `isDefEq` per candidate. Found at FS131-LU1: the step passed with `hUpper` declared
> and proved (`data/fs131/lu1/probes/receipt-assumptions-given.log`, lines 65 and 209).

**11. `LEAN.md`, further facts.**

*§ The gate, the bullet on `./scripts/vacuity.sh`, following* "(FS131-LC1, its record's stage 5: seven and nine; five
and below; six).":

> A module whose theorems range over number-theoretic structures (a usable prime, a conjugation-fixed prime) and whose
> one colourability hypothesis is `Colorable k` of a finite graph adds declarations and **no site**: the scan is silent
> on it, and the landing names each structure's kernel model and says whether it is a library theorem or a term
> (FS131-LU1, its record's stage 5: `ℚ(√11)` at 7; the prime of `ℚ(i)` above 2, the one inhabitant of the two-colour
> theorems' hypothesis).

*§ Building, following* "plan a cap from the largest process's resident set (`data/fs131/lc1/in-scope.sh` records
both) (FS131-LC1).":

> - **After a merge that brings another landing's docstring edits, the modules they made stale need not be
>   recompiled where a tree holds that landing's gated build**: copy its `.lake/build` in by checksum (`rsync -a
>   --checksum`, no `--delete`), then `./scripts/build.sh` — Lake decides by the hash of a module's source and of its
>   imports' compiled files, never by where or when it was compiled, and recompiles what this tree changed (FS131-LU1:
>   117 modules stale after the merge, 4 recompiled, 5 m 34 s against 47 m). A module that imports an edited docstring
>   recompiles to the same `.olean` bytes — only its `.trace` moves (113 of 114 dependents, by checksum). Take the
>   checksum listing before and after the copy, and a manifest of every `.olean`'s hash and time once it is in
>   (`data/fs131/lu1/compiled_unchanged.py`): the source tree can be removed under you (it was, four minutes later),
>   and the manifest is then what shows that no copied file has been rewritten.

*§ Searching — Lean, following* "both stored-term comparisons with the release are run again (FS131-LC1)." *— the
planner's three lines, FS131-IU1's four, FS131-IQ1's four and FS131-IV1's five, each copied from its record by
`data/fs131/lu1/lean-lines.py` (output `lean-lines.out`, quoted below), each identifier it names checked to occur in
the gated modules or in Mathlib at the pin as the modules use it:*

> - Mathlib at the pin holds the localization of a Dedekind domain at a prime as a valuation subring of its fraction
>   field, with its `IsLocalization` and `Ring.KrullDimLE 1` instances:
>   `IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`
>   (`Mathlib/RingTheory/DedekindDomain/AdicValuation.lean`); a valuation subring above it other than `⊤` is it
>   (`ValuationSubring.eq_of_le_of_ne_top`). `Arith/PlaceHom`'s two localization lemmas predate the reading
>   (FS131-KN2).
> - A field generated by algebraic elements maps to any field in which their minimal polynomials split:
>   `IntermediateField.nonempty_algHom_adjoin_of_splits`; at the pin `Polynomial.Splits` is a predicate on one
>   polynomial (`(p.map f).Splits`), and `Polynomial.splits_of_splits_of_dvd`, `Polynomial.splits_X_sub_C` are
>   deprecated for `Polynomial.Splits.of_dvd`, `Polynomial.Splits.X_sub_C` (FS131-KN2).
> - A maximal ideal with `p` elements in its quotient is the kernel of a ring homomorphism to `ZMod p`
>   (`ZMod.ringHom_surjective`, `RingHom.ker_isMaximal_of_surjective`, `RingHom.quotientKerEquivOfSurjective`): no
>   ring of integers need be computed to exhibit a degree-one prime (`QuadraticPrime.isMaximal_ker_and_card`;
>   FS131-KN2).
> - The coercion `𝓞 K → K` is `RingOfIntegers.val`, an `abbrev` for `algebraMap (𝓞 K) K`: `rw [map_mul]`, `rw
>   [map_one]` do not fire on `↑(a * b)`, `↑1` (the head symbol is `val`); `simp` does, `RingOfIntegers.coe_injective`
>   gives a goal stated with `algebraMap` where they fire, and a term `(map_mul (algebraMap _ _) a b).symm` is
>   accepted for `↑a * ↑b = ↑(a * b)`. `RingOfIntegers.coe_eq_zero_iff` is injectivity at `0` (FS131-IU1).
> - A footer that prints stored types gives two texts for one statement when the two copies are elaborated at two
>   paths: an instance binder's stored name carries the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`).
>   Elaborate the skeleton and the candidate at one path in turn (`data/fs131/iu1/statements.sh`); and a private
>   declaration's stored name (`_private.<module>.0.<name>`) is `Name.isInternalDetail`, so a reader that skips
>   internal names skips the private helpers — list them through `privateToUserName?` (FS131-IU1).
> - In a subfield of `ℂ` whose carrier is a set of the library (`fieldI F`, carrier `planeOver F`), `simp` rewrites
>   `(⟨↑x, _⟩ - ⟨↑y, _⟩ : fieldI F)` for `x y : planeOver F` to the coercion of `x - y` and then cannot use a
>   hypothesis about `↑x - ↑y`; state the fact in `ℂ` and close with `Subtype.ext` (`UpperHalf.sub_mul_conj_eq_one`;
>   FS131-IU1).
> - `(conjOn hL).restrict A.toSubring A.toSubring hσ` has type `↥A.toSubring →+* ↥A.toSubring`; an `algebraMap R ↥A`
>   applied under it is then asked for `Algebra R ↥A.toSubring`, which Mathlib's `valuationSubringAtPrime` does not
>   declare. Name the map by a `let` ascribed `A →+* A` (`UpperHalf.residue_conj`; FS131-IU1).
> - `rw [h] at hx` where `hx : ↑x ∈ S` and `x : ↥S` fails with "motive is not type correct"; read an equation of
>   subfields at a point: `(SetLike.ext_iff.1 h (x : ℝ)).1 x.2` (FS131-IQ1).
> - `rw [map_one]` (and `map_mul`, `map_add`) does not see `((1 : 𝓞 K) : K)`: the coercion is the abbreviation
>   `RingOfIntegers.val`; `show … (algebraMap (𝓞 K) K 1) …` first, or use `simp` (FS131-IQ1).
> - A quadratic extension `K₀(π)` given only by `Subfield.closure (↑K₀ ∪ {π}) = ⊤` gets its coordinates from
>   `Subfield.closure_induction` with no subfield built, and `choose` turns existence into the two coordinate
>   functions (`QuadraticPrime.exists_coords`, private; FS131-IQ1).
> - The `p`-adic valuation of a natural number divisible by `p` exactly once is `1` by `Padic.valuation_natCast` and
>   `padicValNat_dvd_iff_le`; parity arguments on `ℚ_p` go through `Padic.valuation_mul`, `Padic.valuation_pow`,
>   `Padic.norm_le_one_iff_val_nonneg` and `omega` (FS131-IQ1).
> - `rw [Subfield.bot_eq_of_charZero] at hx` fails with "motive is not type correct" when `hx` speaks of an element
>   whose type mentions `⊥` (`x : 𝓞 (fieldI ⊥)`): state "an element of `⊥ : Subfield ℝ` is a rational" for a real
>   number once (`∀ r : ℝ, r ∈ (⊥ : Subfield ℝ) → ∃ q : ℚ, (q : ℝ) = r`) and apply it (FS131-IV1).
> - `simp` does not reduce `((2 : 𝓞 K) : K)` read in `ℂ` through a subfield's coercion (the line of FS131-I10C, one
>   coercion further): `rw [two_mul]` before taking coordinates, or state the fact without the numeral (`x + conjO x =
>   m + m`) and finish in the commutative ring with `linear_combination` (`UpperHalf.exists_stablePrime_rat`;
>   FS131-IV1).
> - `Complex.isIntegral_int_I` is not a name at the pin; `IsIntegral.of_pow (n := 2) (by norm_num) (by rw
>   [Complex.I_sq]; exact isIntegral_one.neg)`. A rational that is integral over `ℤ` in `ℂ` is an integer by
>   `isIntegral_algebraMap_iff` and `IsIntegrallyClosed.isIntegral_iff`; trace, norm and `(z̄ − z)·i` are
>   `Complex.add_conj`, `Complex.mul_conj`, `Complex.sub_conj` (FS131-IV1).
> - `omega` takes a square as an atom: a parity contradiction such as `(2m+1)² + (2k)² = 4n` closes with one `ring`
>   identity stated as a `have` and `omega` (FS131-IV1).
> - `tools/check_architecture.py` fails on a row's imports cell and on module coverage; a misnamed identifier in a
>   row's description is listed under `[3]` and does not fail (FS131-IV1, two plants on copies).

*(The planner's fourth line and FS131-IV1's sixth are about this machine's builds and about a `#print axioms` file run
before a join; the § Building bullet above and FS131-LC1's carry the first, and the second is FS131-IV1's record's.)*

**12. `plans/FS131-KN1-number-field-kernel-map.md` — the planner's three corrections, each with its slot** (the map
is its writer's or the coordinator's):
- § X1, row `[S1b]`, size column. *Replaces* "those two localization lemmas are stated for `F : Subfield ℝ` and must be
  restated for a number field given as `fieldI F : Subfield ℂ`. Proofs not read in full: unknown" *by* "retired
  (FS131-KN2): Mathlib at the pin holds the localization of a Dedekind domain at a prime as a valuation subring
  (`IsDedekindDomain.HeightOneSpectrum.valuationSubringAtPrime`, with `ValuationSubring.eq_of_le_of_ne_top`); landed
  as `Arith/UpperHalf` (FS131-LU1)".
- § X1, row `[S2]`. *Follows* "The same for a multiquadratic field at a prime where every radicand is a square, a
  ramified radicand included (11 in `K`)." — "**False as written with two radicands divisible by `p`** (`ℚ(√11, √22)`
  at 11; `data/fs131/claims-NF1.md`, the dated line of 16:36 UTC); it stands for one radicand divisible by `p`
  exactly once: `QuadraticPrime.exists_maximal_card_eq_of_ramified` (FS131-LU1)."
- § X8. *Follows* "`[S1a]` and `[S2]` at `(11, 7)`; the lower half and the colouring of `Γ₇` are held." — "(True of
  `ℚ(√11)`. For `ℚ` the lower half `2 ≤ χ(ℚ²)` was not held by name: it is `UpperHalf.two_le_chromaticNumber_planeOver`,
  a leaf of the module, FS131-LU1.)"

**13. `data/fs131/claims-NF1.md`, a dated line** — *follows* the line of 20:39 UTC (ending "a draft that says "onto" is
wrong and is not filed."):

> - 2026-10-13 21:24 UTC — **Through the gate (FS131-LU1; gated commit `c2f4e4f54`; record
>   `plans/FS131-LU1-landing.md`).** NF1-S1A: **[kernel]**, the standard three, term for term
>   (`UpperHalf.chromaticNumber_planeOver_le_unitQuadrance`, `…_le_finitePlane`). NF1-S1B: **[kernel]**, the standard
>   three — the homomorphism into the level-one target as claimed and into every level `m ≥ 1`
>   (`UpperHalf.nonempty_hom_levelTarget_one`, `exists_hom_levelTarget`), `χ ≤ L` (`chromaticNumber_planeOver_le_localBound`),
>   the converse half (`exists_stablePrime_of_valuationSubring`). NF1-S2: **[kernel]**, the standard three — the first
>   sentence as claimed and for any set of radicands (`QuadraticPrime.exists_maximal_card_eq_sqrt`,
>   `exists_maximal_card_eq`), the second as the dated line of 16:36 UTC corrects it (`…_of_ramified`). NF1-MODULE's
>   four values: **[kernel]**, the standard three — `χ(ℚ(√11)²) = 4` and `χ(ℚ²) = 2` in both halves, `χ(ℚ(√167)²) ≤ 8`,
>   `χ(ℚ(√47)²) ≤ 5` a second way; the chain's headline without its upper half
>   (`UpperHalf.chromaticNumber_eq_localBound_of_chain`) is conditional on nine declared hypotheses. NF1-NC holds of
>   every docstring as read, with the dated line of 20:39 UTC.

**14. The Frontier line and the Proof Atlas.** *Frontier, "Last filed"* — a clause in that list's own form, placed
first:

> **the landing of FS-131's first number-field module, the residue upper half** (FS131-LU1, 2026-10-13:
> `Arith/UpperHalf`, `Arith/QuadraticPrime`, `Instances/UpperHalfValues` through the gate — 49 theorems and 3
> definitions on the standard three axioms; a plane over a real number field maps homomorphically into each of its
> residue targets, so `χ(F²) ≤ χ(Γ_q)` at a usable prime and `χ(F²) ≤ L(F)`; a degree-one prime at fields of square
> roots; `χ(ℚ(√11)²) = 4` and `χ(ℚ²) = 2` in both halves, `χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` a second way; the
> chain's headline loses its hypothesis `hUpper`; known values and bounds, the kernel proofs ours; no value moved)

*Proof Atlas*, grade changes: row 73's value `χ(ℚ(√11)²) = 4` (kernel below, the plane at 7 by citation above) →
**[kernel]** in both halves, `UpperHalf.chromaticNumber_planeOver_eleven`; row 63's instance `χ(ℚ²) = 2` →
**[kernel]**, `UpperHalf.chromaticNumber_planeOver_rat`; row 52's bound (not its two values) → **[kernel]**,
`UpperHalf.chromaticNumber_planeOver_le_unitQuadrance`, `…_le_finitePlane`, `QuadraticPrime.exists_maximal_card_eq`;
row 57's "Not proved" clause → **[kernel]**, `UpperHalf.exists_hom_levelTarget`,
`UpperHalf.exists_stablePrime_of_valuationSubring`; row 105's number-field reading → **[kernel]**,
`UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`; row 119's upper end `≤ 8` → **[kernel]**; rows 99,
123, 127: the node of the upper half `χ(F²) ≤ L(F)` → **[kernel]**,
`UpperHalf.chromaticNumber_planeOver_le_localBound`, every other node of the chain as it was. Each of these rests on
the standard three and on no assumption, except `UpperHalf.chromaticNumber_eq_localBound_of_chain`, which rests on
the chain's nine remaining hypotheses by name: `BochnerHerglotz`, `InvariantMeasureOnClosed`, `Interface.Count`,
`Interface.APlusOfR88`, `Interface.RU`, `Interface.PE2`, `Interface.EFPlus`, `inline:CLS`, `inline:Row99`. **No value
moves; no lower bound is gained but `2 ≤ χ` of every plane.**

**15. `ARCHITECTURE.md`**: nothing to file — the three rows, § Trust's table of assumed hypotheses and the two
corrected sentences are on the branch as landed (stages 3 and 4).

**16. `BIBLIOGRAPHY.md`** — additions to "what of ours rests on it", none re-read by this job: `[Fischer1990]` and
`[Moorhouse2010]` — "the upper bound `χ(ℚ(√11)²) ≤ 4` is kernel-checked since FS131-LU1
(`UpperHalf.chromaticNumber_planeOver_eleven`)"; `[Woodall1973]` — "`χ(ℚ²) = 2` is kernel-checked since FS131-LU1
(`UpperHalf.chromaticNumber_planeOver_rat`), through a prime above 2 of `ℚ(i)` and not through his parity colouring
written out".

## Open gate items at this landing

1. **Older docstrings that still call the upper half a hypothesis, or its consequences absent — not edited here** (a
   docstring in an upstream module recompiles everything above it; the brief's word for the first two):
   `SpectralChain.lean:240` and `:624–625` ("given … the upper half `χ(F²) ≤ L(F)` (row 52 at ring level; the field
   step is row 57's gap), named `hUpper`"); `Instances/SqrtEleven.lean:29` ("`χ(ℚ(√11)²) ≤ 4` … is **not** in the
   kernel" — true of that module, false of the library since this landing); `UnitRing.lean:98`, `:106`, `:189` and
   `Instances/SevenUnitRing.lean:11`, `:45` ("the number-field reading is row 57's gap");
   `FanGap.lean:33` and `TwoAdicTower.lean:26` name "row 57's gap" for older routes and want a reading before a word.
   The map's two sentences of the same kind are corrected on the branch (stage 4).
2. **The headline still carries `hUpper`.** `SpectralChain.chromaticNumber_eq_localBound` is unchanged — a gated
   statement, not this job's to touch; `UpperHalf.chromaticNumber_eq_localBound_of_chain` is the same equality without
   the binder. The ledger of assumptions lists both, nine rows each. A later job keeps both or restates the headline.
3. **Models that are terms of an iteration file, not library theorems** (`data/fs131/lu1/checks.lean`; the gate's pass
   elaborates them, each on the standard three but one on `[propext]`): the standing field's four
   (`stablePrime_standing_model`, `hom_standing_model`, `one_standing_model`, `hram_fails_at_standingField` —
   `Arith/UpperHalf` does not import `Arith/StandingFive`); at `ℚ`, `two_mem_model`, `converse_rat_model`,
   `wall_rat_model` (a statement in its own right: `1/2 ∉ ℤ[U_ℚ]`), `two_le_localBound_rat`; `usablePrime_model` (every
   NF1-S1A hypothesis and both bounds at once), `usable_card_mod_four`; `ramified_radicand_notMem`,
   `ramified_radicand_ne_zero`, `two_notMem_of_hD`; and the `rfl` between the two proofs of `χ(ℚ(√47)²) ≤ 5`.
4. **Not in the kernel: that `L(ℚ)` is a number, and that every real number field has a conjugation-fixed prime.**
   The kernel holds that `L(ℚ)`'s infimum is over an inhabited family and (a term) `2 ≤ L(ℚ)`; `localBound ⊥ ≠ ⊤` needs
   a colouring of the level-one target at `ℚ`'s prime, which no theorem gives. The line comment at
   `Instances/UpperHalfValues.lean:200` says "`L(ℚ)` is a number (a stable prime exists)": true, and one step more
   than the library proves. At a field with no such prime `chromaticNumber_planeOver_le_localBound` reads `χ ≤ ⊤`.
5. **`exists_stablePrime_rat` exhibits no ideal.** The proof takes any maximal ideal over `(2)`; that it is
   `(1 + i)`, and that it is the only one, are not stated (FS131-IV1's reading: its private lemma with its symmetric
   half is `𝓞 (ℚ(i)) ⊆ ℤ[i]`). `ℚ` is the one field at which the library exhibits a prime with the two-colour
   theorems' hypothesis.
6. **Corollaries the module now reaches and no file states** (each a planner's to type; none checked here beyond the
   reading): `localBound F = 2 → χ(F²) = 2` (`le_antisymm` of the upper half and `two_le_chromaticNumber_planeOver`);
   row 52's two values — `exists_maximal_card_eq_of_ramified` at 11 for `K(√5)` and `K(√247)` with
   `colorable_planeOver_of_finitePlane`, `chromaticNumber_finitePlane11` and the lower halves the map names; row 105's
   reading at `K(√7)`; row 103's upper end, which needs a prime above 2 of `ℚ(√2, √3)(i)` and so is out of
   `Arith/QuadraticPrime`'s reach (odd primes only).
7. **Wider forms the implementers saw and did not type** (their records' lists): every valuation subring of a number
   field other than the field is the localization at a maximal ideal of its integers (`exists_centre`, private, and
   five lines); `isUnit_mk_pow` for any maximal ideal of any commutative ring; `exists_padicInt_sq_eq` for an integer;
   the ramified step for any element of valuation one.
8. **The assumptions step cannot find a discharged `.site`** (stage 4; drafts 9 and 10). Until the tool reads binders,
   a landing that proves a statement the library carries in a binder finds it by hand: the declared list is searched
   for the row or the label. This landing searched for `UpperHalf` and for rows 52 and 57: the one site.
9. **The vacuity scan decides nothing about this module**: sixty declarations, no site. The notes check reads QA4's
   modules only: no instrument reads the three files' "Inhabitants" notes; stage 5 read them.
10. **The compiled library was brought current by copy, and the tree it was copied from is gone** (stages 1 and 7).
    117 modules of `Plane/` and `Outside/` were compiled by the last landing in another tree; Lake's trace check took
    each; the manifest shows none rewritten here; the last landing's three modules store the statements that landing's
    final dump holds. No cold build of the whole library has been run on the joined tree. The coordinator ruled that
    none is wanted before the fast-forward (the brief's Amendment 1); the publication gate replays every module.
11. **Not run in this pass**: the import's and the port's stored-term comparisons with the release — no module they
    read was recompiled; the ten files carry the bytes and the times they were copied in with.
12. **Whether a landing files its definitions and its private helpers is still practice, not a written rule.** This
    landing files every public declaration a person typed — 52 records, 3 of them definitions — and none of the sixteen
    private theorems, which no line of the audit script can name; their prints are FS131-IV1's footer file, made
    before this job's docstring edits and not made again.
13. **Two global named instances, both of a proposition**: `QuadraticPrime.instNumberFieldFieldOfRadicands (D) [Finite
    D]` and `UpperHalf.instNumberFieldBot`, on two types that are equal at `D = ∅` by a proof and not by definition.
    `NumberField` carries no data, so nothing can disagree; the doubled-name check is clean.
14. **An attribution this job did not re-read**: `Instances/SqrtEleven.lean:29` gives the upper bound at `ℚ(√11)` as
    "`[Fischer1990]` Thm 9 and `[Moorhouse2010]` Thm 8.1"; `BIBLIOGRAPHY.md`'s row for `[Fischer1990]` lists its
    Theorems 8–10 as two colours, three colours for `N ≢ 2 (mod 3)`, four colours for `N ≡ 3 (mod 8)` — and 11 is
    `2 (mod 3)` and `3 (mod 8)`, which reads as the third of the three. The new module and the ledger's row 73 say
    "`[Fischer1990]`'s" with no number, and so do this record's drafts.
15. **`two_le_chromaticNumber_planeOver` lives in an instances file** and is about every subfield of `ℝ`; a second
    reader would want it beside `planeOver`.
16. **Nothing is pushed**: the remote is unreachable; every commit is local on
    `fs131-wnf`. `lean4checker` is the publication gate and was not run.
17. **The memory numbers are warm-cache numbers**: charged peaks of 0.2 to 1.3 GiB are what the kernel charged steps
    whose `.olean` pages were already cached; the resident sets (4.3 to 5.1 GiB) are the numbers to plan a cap from.

## Theorems this phase proved, final

*Each [kernel], through the full gate at `c2f4e4f54`. This job proved none of them: the statements are FS131-KN2's
(nine of them proved by the planner as corollaries of the library), the leaves' proofs FS131-IU1's, FS131-IQ1's and
FS131-IV1's. **None of the values is new mathematics**: `χ(ℚ(√11)²) ≤ 4` is `[Fischer1990]`'s and
`[Moorhouse2010]`'s, `χ(ℚ²) = 2` is Woodall's, the finite-plane bound is `[Moorhouse2010]`'s, `[Manturov2012]`'s and
`[Madore2015]`'s (`LEDGER.md` row 52 and § The claim list); what is this project's is the kernel proof. Printed from
the gate's own logs (`data/fs131/lu1/lu1_records.py … --lines` on `gate/decls-final.out` and
`gate/receipt-axioms-final.log`; output `gate/theorem-lines-final.txt`): every declaration the landing brings — 49
theorems and 3 definitions — with the banner its record is under and its axioms as the audit printed them. Namespace
`HadwigerNelson`.*

**The informal statement each headline was read against** (stage 6):
- `UpperHalf.chromaticNumber_planeOver_le_unitQuadrance`, `…_le_finitePlane` (with `nonempty_hom_unitQuadrance`,
  `nonempty_hom_finitePlane`, `colorable_planeOver_of_finitePlane`) — NF1-S1A: "For a real number field `F` and `𝔭`
  with `Arith.IsUsablePrime 𝔭`: `χ(planeOver F) ≤ χ(unitQuadrance (𝓞 F ⧸ 𝔭))`; and `≤ χ(finitePlane p)` when
  `Nat.card (𝓞 F ⧸ 𝔭) = p` is prime." Term for term.
- `UpperHalf.nonempty_hom_levelTarget_one`, `exists_hom_levelTarget`, `chromaticNumber_planeOver_le_levelTarget`,
  `chromaticNumber_planeOver_le_localBound`, `exists_stablePrime_of_valuationSubring` — NF1-S1B: "a graph
  homomorphism from the unit-distance graph on `planeOver F` into `SpectralChain.levelTarget P 1`; so `χ(planeOver F)
  ≤ SpectralChain.localBound F`. Converse half for row 105: a conjugation-stable valuation subring of `fieldI F` other
  than the field is the localization at a stable prime", with the dated line's every level `m ≥ 1`. Into.
- `QuadraticPrime.exists_maximal_card_eq_sqrt`, `exists_maximal_card_eq`, `exists_maximal_card_eq_of_ramified`
  (with `numberField_fieldOfRadicands` and the instance) — NF1-S2 as its two dated lines of 16:36 UTC leave it: the
  first sentence as claimed and for any set of radicands; the second for one radicand divisible by `p` exactly once.
- `UpperHalf.chromaticNumber_planeOver_eleven`, `chromaticNumber_planeOver_rat`,
  `chromaticNumber_planeOver_sqrt167_le_eight`, `chromaticNumber_planeOver_sqrt47_le_five_of_prime` (with
  `colorable_planeOver_fieldOfRadicands`, `two_le_chromaticNumber_planeOver`, `exists_stablePrime_rat`) —
  NF1-MODULE's four values: "`χ(ℚ(√11)²) = 4`, `χ(ℚ²) = 2`, `χ(ℚ(√167)²) ≤ 8`, `χ(ℚ(√47)²) ≤ 5` again as the control
  against `SqrtFortySeven`". The lower halves: `four_le_chromaticNumber_planeOver_eleven` (older) and
  `two_le_chromaticNumber_planeOver` (this module), each on the standard three.
- `UpperHalf.chromaticNumber_eq_localBound_of_chain` — "the five-colour chain's headline with one of its named
  hypotheses discharged" (the brief): on the standard three **and on nine declared hypotheses**.
- `UpperHalf.colorable_two_planeOver_of_ramified`, `two_mem_of_conj_trivial`,
  `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` — no claim line; rows 63 and 105 (the claim list's dated line
  of 20:39 UTC, (d)).

*`Arith/UpperHalf`*
- `SpectralChain.StablePrime.heightOne` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `SpectralChain.StablePrime.localRing` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `SpectralChain.StablePrime.residue` — definition; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_eq_localBound_of_chain` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_le_finitePlane` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_le_levelTarget` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_le_localBound` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_le_unitQuadrance` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.coe_conjO` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.coe_mem_nonunits_localRing_iff` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.colorable_planeOver_of_finitePlane` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.colorable_two_planeOver_of_ramified` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.conjO_conjO` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.conjO_mem_iff` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.conj_mem_localRing` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.exists_hom_levelTarget` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.exists_stablePrime_of_valuationSubring` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.heightOne_asIdeal` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.isUnit_mk_pow` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.localRing_ne_top` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.mem_localRing` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.mem_localRing_of_mul_conj_eq_one` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.nonempty_hom_finitePlane` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.nonempty_hom_levelTarget_one` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.nonempty_hom_unitQuadrance` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.residue_algebraMap` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.residue_conj` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.residue_div` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.two_mem_of_conj_trivial` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
*`Arith/QuadraticPrime`*
- `QuadraticPrime.exists_maximal_card_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.exists_maximal_card_eq_of_ramified` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.exists_maximal_card_eq_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.exists_maximal_card_of_padic` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.exists_padicInt_sq_eq` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.exists_ringHom_zmod_of_padic` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.fieldOfRadicands_eq_adjoin` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.instNumberFieldFieldOfRadicands` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.isIntegral_sqrt_natCast` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.isMaximal_ker_and_card` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.nonempty_ringHom_padic` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.nonempty_ringHom_zmod_of_ramified_sqrt` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `QuadraticPrime.numberField_fieldOfRadicands` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
*`Instances/UpperHalfValues`*
- `UpperHalf.chromaticNumber_planeOver_eleven` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_rat` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.colorable_planeOver_fieldOfRadicands` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.exists_stablePrime_rat` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.instNumberFieldBot` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.numberField_bot` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
- `UpperHalf.two_le_chromaticNumber_planeOver` — theorem; [kernel]; under CLEAN; axioms: [propext, Classical.choice, Quot.sound]
(52 declarations of 60 constants in 3 modules)

## Slips, my own

1. **Two probe logs overwritten by a later step of the same name**: `probes/uptodate-given.log` and
   `probes/decls-given.log` were first written on the tree as given (`d83fdd8c7`, before the merge) and written again
   by `probe-given.sh` after the first build. Their first results are in stage 1's text and in `probes/measure.txt`'s
   first lines ("All targets up-to-date (5998 jobs)"; 60 constants), not in a file of their own.
2. **A probe run beside a plant**: while the lint's control was building I ran one measured `lake env lean` on a
   scratch file; the wrapper appended a line to the tracked `probes/measure.txt`, so the plant's script ended on
   "tracked files modified: 1". The module's digest and the plant's absence are what show the restore; the count was
   mine to keep at zero.
3. **A cross-tree check written before looking whether the other tree was still there**: `compiled-identical.sh`
   was written for the pass, failed on its first run ("no build at …/fs131-wkc"), and was replaced by the manifest
   check; it was never committed.
4. **The record's stage numbers run one ahead of the brief's items from the gate on**, as the last landing's did:
   "before the pass" is saved as stage 7, the pass is stage 8.
5. **The docstring edit on `p = 2` was made after the first build**, so one probe run (the audit and the scans of
   stages 3 to 5) read compiled modules one docstring behind their source; the pass's build compiled the committed
   text and every step of the pass read that.
6. **A count in stage 6 corrected in place after its commit**: it said "each of the eight older theorems named above";
   seven are older and the eighth, `two_le_chromaticNumber_planeOver`, is this module's. The sentence now says so.
7. **One slot of the drafts' check was wider than its draft**: the map's `[S2]` sentence was first checked with the
   table's next cell attached, on a wrong reading that the sentence occurs twice in the file; it occurs once, and the
   check now holds the sentence alone (29 of 29 both times).
