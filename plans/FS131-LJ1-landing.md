# FS131-LJ1 — the landing of the three-and-four-colours line: six files through the gate

*Job record of FS131-LJ1 (brief: `data/fs131/briefs/FS131-LJ1-landing.md`; de Bruijn, the implementer, as the lander of
one finished line of six files; branch `fs131-wj1`, worktree `.claude/worktrees/fs131-wrc`; the laptop: 12 cores,
31 GB). The line is FS131-KN4's statements (passes FS131-KN5) with the leaves proved by FS131-IC1
(`Proofs/HadwigerNelson/Arith/ThreeColourCharacter.lean`), FS131-IT1 (`Arith/TorsionExtraction.lean`), FS131-IN1
(`Arith/ThreeColourCriterion.lean`), FS131-ID1 (`Arith/DyadicQuadratic.lean`) and joined, extended and proved by
FS131-KJ1 (`Arith/ThreeFourColours.lean`, `Instances/UpperHalfCorollaries.lean`; record
`plans/FS131-KJ1-joining-module.md`). This job proves nothing and changes no statement: it takes the line through the
gate. Working files: `data/fs131/lj1/` (this job's scripts are there, not under `tools/`: the brief's list of what the
job touches names that directory and not `tools/`). Times are UTC.*

## Theorems this phase proved

*Filled at the green line: § "Theorems this phase proved, final". This job proved no theorem of the library.*

## Stage 1 — SAVED (FS131-LJ1): the readback, what was read, `main` merged, the six modules dumped before any edit

### The brief's quotations

`data/fs131/lj1/readback_check.py` (FS131-LU1's script pointed at this brief; every block quote must occur character
for character in the file its source line names), read as `git show main:…` at `16b181f48` because the brief itself
reached this tree only with the merge: **5 of 5 MATCH** (`readback.out`) — Kooshi's word W2 against
`data/fs131/REQUEST-2026-10-13.md`; NF4-THEOREM, NF4-NC and the dated line of the joining job against
`data/fs131/claims-NF4.md`; inventory item 720 against `plans/FS131-close-inventory.md`. With `--fault` (one character
of each altered): **5 of 5 MISMATCH** (`readback-fault.out`), so the check can fire. No finding about the brief's
quotations. **One fact of the brief that had moved**: it names `main` at `0b56f33ee`; `main` stood at `16b181f48`, one
commit later, and that commit adds the brief and nothing else (`git diff --stat 0b56f33ee 16b181f48`: one file).

### What was read

The brief and `plans/STANDING-RULES.md` in full; `LEAN.md` in full as it stands on `main`; `RUNNING.md` § Building and
§ Make the gate fail, and watch it fail; the joining job's record in full; the last landing's record
(`plans/FS131-LU1-landing.md`): its head, stages 1 to 5, 7 and 8 and the first five drafts in full, **its stage 6, the
rest of its drafts, its open gate items and its slips by their headings only**; that landing's scripts under
`data/fs131/lu1/` (the runner, the two wrappers, the dump, the lister, the text check, the readback), each of which this
job's is a copy or an adaptation of and says so in its first lines. **Of the six modules**: the joining module's head
and its lines 536–800 and 858–925 (clause (b), row 99, the table, the two dyadic statements, the spec section) line by
line; `Arith/ThreeColourCriterion`'s module docstring; the head (statement up to `:=`) of every public declaration of
all six (`data/fs131/kj1/heads.py`); the docstrings of the dictionary statements J1–J4. **Not read: the proofs** — the
kernel read them — and the docstrings of the four proved modules beyond the heads (the joining job read each credit in
them against the paper, its stage 4).

### `main` merged

Trial first (`git merge-tree --write-tree HEAD main`, `data/fs131/lj1/merge-trial.out`): exit 0, **no conflict
named**. Since this branch's last merge of `main` (`39fee2edb`), `main` changed four files outside `data/` and
`plans/` — `CLAUDE.md`, `LEAN.md`, `LEDGER.md` and `tools/claude_md_fact_audit.py`, the last landing's filing — and
nothing under `Proofs/` or `scripts/`. Merged by hash, automatic: `fb76f2890` (`merge-main.out`). Both sides kept,
checked: against `main` the branch differs under `Proofs/`, `Proofs.lean`, `scripts/`, `tools/`, `ARCHITECTURE.md`, the
lakefile, the toolchain, the manifest, `CLAUDE.md`, `LEAN.md` and `LEDGER.md` by **the six modules (3,734 lines), six
import lines and six rows of the map, and nothing else**.

### The build — current as given, and still current after the merge; nothing copied

`lake build --no-build Proofs` under the slot's cap, on the tree as given (`dec3b73ce`;
`probes/uptodate-given.log`): exit 0, "All targets up-to-date (6005 jobs)", 3.7 s. Again after the merge: the same
line — the merge brought no Lean source. **No compiled file was copied from another tree by this job** (the joining
job's copy from `fs131-wnf` is in its record, stage 2). The first build of this job is stage 2's, for the docstrings.

### Before any edit and before the merge: the six modules as the kernel held them

On the tree as given (`dec3b73ce`; `statements/before.commit`): `data/fs131/lj1/StatementDump.lean` (FS131-LU1's with
the module list changed) prints every constant of the six modules' compiled data — 22 + 52 + 44 + 131 + 73 + 4 = **326
constants** — kept compact as `data/fs131/lj1/statements/before.compact` (`tools/fs124_l2_statements.py compact`; the
raw print, 8.4 MB, SHA-256 `211a30c8…1fd9f0dd` with the slot's line and the exit line, is not kept:
`probes/statements-before.note`). **96 of the 326 are not internal** — the joining job's count of public records.
`data/fs131/lj1/decls.lean` on the merged tree (`probes/decls-given.log`): 96 constants that are not internal — 11, 20,
17, 13, 31 and 4 by module — **every one a declaration a person typed: 94 theorems and 2 definitions**
(`ThreeColourCriterion.conjR`, `TorsionExtraction.inv5`); none is the elaborator's. The private helpers have internal
names and are in neither count (the joining job's `data/fs131/kj1/logs/axioms-final.txt` has theirs: 232 rows over
nine files).

### The tree as merged and built, before any registration

*Every step under the slot with this machine's budget (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`), through
`data/fs131/lj1/m.sh` and `in-scope.sh` (FS131-LC1's wrappers through FS131-LU1: each step's exit status, wall time,
the scope's charged `memory.peak` and the largest single process's resident set, appended to
`data/fs131/lj1/probes/measure.txt`), from a snapshot copy of `data/fs131/lj1/probe-given.sh`, on the merge commit
`fb76f2890` with `scripts/` as on `main`.*

| step | result | wall | peak (charged) | max-rss |
|---|---|---|---|---|
| is the build current? `lake build --no-build Proofs` | exit 0, "All targets up-to-date (6005 jobs)" | 3.7 s | 0.21 GiB | 0.87 GiB |
| the six modules' constants as stored (`StatementDump.lean`) | 326 constants, 96 not internal | 5.2 s | 0.57 GiB | 4.39 GiB |
| the six modules' declarations (`decls.lean`) | 96 not internal; 94 theorems, 2 definitions, all typed | 64.8 s | 0.55 GiB | 4.38 GiB |
| `./scripts/dupnames.sh` | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" — **the join made no doubled name** | 5.0 s | 0.53 GiB | 4.36 GiB |
| `./scripts/assumptions.sh --self-test` | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent" | 128 s | 0.68 GiB | 4.58 GiB |
| `./scripts/assumptions.sh`, `./scripts/vacuity.sh` | stages 4 and 5 | | | |
