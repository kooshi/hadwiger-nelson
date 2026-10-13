# FS131-LC1 — the landing of the measurable-number module: `χ(ℝ²) = χ_m(ℝ²)`, Lebesgue-measurable classes, every unit pair

*Job record of FS131-LC1 (brief: `data/fs131/briefs/FS131-LC1-landing.md`; de Bruijn, the implementer, as the lander of
one finished module; branch `fs131-wkc`, worktree `.claude/worktrees/fs131-wkc`; the laptop: 12 cores, 31 GB). The
module is FS131-KC1's (`Proofs/HadwigerNelson/Plane/LebesgueNumber.lean`; its record
`plans/FS131-KC1-measurable-number-plan.md`). **The mathematics is other people's**: a printed lemma (`[Davies2026]`
Lemma B.1, p. 44), formalized by FS131-KC1 with its printed proof; a declared outside theorem
(`Outside.OAI158.proper_to_borel_weak`, `[OAIMath2026]` family 158); a composition. This job proves nothing and changes
no statement: it takes the module through the gate. Working files: `data/fs131/lc1/` (this job's scripts are there, not
under `tools/`: the brief's list of what the job touches names that directory and not `tools/`).*

## Theorems this phase proved

*Filled at the green line from the gate's saved logs (§ "Theorems this phase proved, final"). Until the gate is green on
one commit nothing below is "held".*

## Stage 1 — SAVED (FS131-LC1): the readback, what was read, `main` merged, the tree as given probed before any edit

### The brief's quotations

`data/fs131/lc1/readback_check.py` (FS131-KC1's script pointed at this brief: every block quote must occur character
for character in the file its source line names): **7 of 7 MATCH** (`readback.out`); with `--fault` (one character of
each altered) **7 of 7 MISMATCH** (`readback-fault.out`), so the check can fire. A count, not a mismatch: the brief's
§ Done means says "the six quoted lines"; there are seven block quotes — two of Kooshi's words (W2, W3), four claim
lines (NF3-PRINTED, -WEAK-TO-PROPER, -PLANE, -NC) and the dated line of 16:51 UTC.

### What was read

The brief and `plans/STANDING-RULES.md` in full; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; the planner's record and its report (all seven drafts); the module, every line; the last landing's
record (`plans/FS124-L2-landing.md`) stages 3 to 9, the head of its drafts and its open gate items, and its runner
`data/fs124/l2/run-gate.sh`. **The paper, first-hand from the rendered pages** (`~/source/library/pdf/Davies2026-…pdf`):
p. 1 (title, author, "arXiv:2610.12301v1 [math.CO] 8 Oct 2026"), p. 2 (the definitions), p. 44 (Appendix B's standing
hypotheses, the sentence before the lemma, Lemma B.1 and its proof), p. 46 (the density-point argument). And, from a
text extraction of the library copy, the end of the proof of Lemma 5.6 of `[DeCorteOliveiraVallentin2022]` (printed
p. 22: "Let I be the set of density points in the support of f … Claim: I is independent") — the passage `[Davies2026]`
p. 46 cites as "the density-point argument in [24, proof of Lemma 5.6]". Stage 6 reads the statements against these.

### `main` merged

`main` had moved from the branch point `4410f75fc` to `3fd0d9ba3`: **15 paths, `data/` 12 and `plans/` 3, nothing
else** (`data/fs131/lc1/merge-main-diff.out`; the list of paths outside `plans/` and `data/` is empty), and no path in
common with the branch's own changes (`ARCHITECTURE.md`, `Proofs.lean`, the module, `data/` 8, `plans/` 1). Merged by
hash, automatic: `b6e5abfab` (`merge-main.out`).

### The tree as given, before any edit

*Every step under the slot with this machine's budget (`SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6`), through
`data/fs131/lc1/m.sh`, which runs the step inside the slot's scope under `data/fs131/lc1/in-scope.sh` and appends one
line per step to `data/fs131/lc1/probes/measure.txt`: exit status, wall time, and **two memory numbers that measure
different things** — `peak`, the scope's `memory.peak` (what the kernel charged the step: private memory and the file
pages it was first to read; `.olean` pages already in the page cache are not charged again, so on a warm machine it is
far below a cold run's cost), and `max-rss`, the largest resident set of any one process of the step (GNU `time`:
private memory plus every mapped `.olean` page it touched). The instrument's control: a process holding 300 MiB reads
`peak=0.30 GiB max-rss=0.30 GiB`; a step that exits 7 is recorded `exit=7`.*

| step, on the tree as given (`b6e5abfab`) | result | wall | peak (charged) | max-rss |
|---|---|---|---|---|
| is the build current? `lake build --no-build Proofs` (compiles nothing) | exit 0, "All targets up-to-date (5995 jobs)" | 3.2 s | 0.21 GiB | — |
| the module's constants as the kernel lists them (`decls.lean`) | 41 constants in `Plane/LebesgueNumber`; **34 a person typed: 31 theorems, 3 definitions** (`HasDensityOneAt`, `AeColouring.core`, `chiLebesgue`); 7 the elaborator's (`HasDensityOneAt.eq_1`, six `match_1_n`) | 59.3 s | 0.55 GiB | — |
| every constant of the three modules to be edited, stored type and value (`StatementDump.lean` → `statements/before.compact`, at `statements/before.commit`) | 137 constants (`Plane/AeColouring` 22, `Plane/FalconerReduction` 72, `Plane/LebesgueNumber` 43); 87 named; the reader's four plants fire | 3.0 s | 0.52 GiB | 4.34 GiB |
| the statements by `#check`, their axioms, the model terms (`checks.lean`; `probes/checks-before.log`) | no error, no warning; eleven headline theorems on `[propext, Classical.choice, Quot.sound]`, three on those and `Outside.OAI158.proper_to_borel_weak` | 3.9 s | 0.55 GiB | 4.37 GiB |
| the guarded lint | exit 0, "-- Linting passed for Proofs.", every linter "(2/2) Passed!" | 9.2 s | 1.05 GiB | 4.92 GiB |
| `./scripts/dupnames.sh` | "dupnames: OK — no name is declared by two modules (24 generated on demand, listed above)" | 4.0 s | 0.52 GiB | 4.35 GiB |
| `./scripts/vacuity.sh` | "vacuity: OK"; against this tree's previous run (FS124-L1's): declarations 15370 → 15969, refutations-skipped 226 → 228, sites 1448 → 1454, generic 1405 → 1411; **six new sites, all `GENERIC`, all the binder `AeColouring k`** (stage 5) | 117.9 s | 0.59 GiB | 4.50 GiB |
| `./scripts/assumptions.sh` | **exit 1, three failures, one kind, expected**: `FAIL unlisted-consumer` for the three theorems that rest on `proper_to_borel_weak` and are not yet in the ledger; "rests 23 → 26"; nothing else fails (stage 4) | 105.7 s | 0.66 GiB | 4.55 GiB |

**Why the scans ran first.** The order of the steps before the final pass is this job's to choose, and the docstring
corrections recompile 117 modules (stage 2): had a scan asked for a word in the new module's docstrings, a second
build would have followed. None does: the lint is clean on the module as given, the vacuity scan fails nothing, and
the assumptions step fails only on the ledger rows the landing is to write.
