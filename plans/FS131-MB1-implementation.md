# FS131-MB1 — the example maps built, half B: `Plane/Models/Stuck` and `Plane/Models/Bends` (de Bruijn, the implementer)

*Brief: `data/fs131/briefs/FS131-MB1-models-stuck.md` (on `main`). Branch `fs131-wmb`, worktree `.claude/worktrees/fs131-wmb`, cut from the
planner's tip `fe9d6d32`. Started 2026-10-06 08:59 UTC. The plan is `plans/FS131-models-kernel-plan.md` (FS131-KM1), whose § 3.5 prices each leaf.*

## Theorems this phase proved

Listed at the last saved stage, in the section "Theorems this phase proved, at the last saved stage" at the end of this file.

## Stage 1 — SAVED (FS131-MB1): the readback

### 1.1 The brief's quotations (standing rule 3)

`tools/fs131_mb_quotes.py` reads each `> text` / `> — source: path` pair of the brief and counts the text in the file its source line
names (a relative path is read from the main checkout, where Keryx's files live). Output `data/fs131/mb/quotes.out`: **9 quotations, 9
found verbatim, each once; none missing**, exit 0. `--self-test` changes the last character of every quotation and requires all 9 to be
reported missing, beside the faithful run, which must report none: `9 of 9 … faithful run 0 missing -> OK`, exit 0.

### 1.2 What was read, and how far

| file | read |
|---|---|
| the brief; `plans/STANDING-RULES.md`; `LEAN.md` (main checkout, with today's naming rule) | whole |
| `RUNNING.md` § Building, § Make the gate fail, and watch it fail | § Building whole; the second to its l. 295 |
| `plans/FS131-models-kernel-plan.md` (FS131-KM1) | whole |
| `plans/FS131-close-inventory.md` | items 460, 461 whole (461 (c): a plane-map model of `bend_away_whole` is wanted, about 30 lines beside `awayModel`) |
| `plans/FS131-E7-derivation.md` | § 7 (`P₅`) whole; § 6 not yet (read when `shadowModel` is begun) |
| `Plane/Models/Paint`, `Stuck`, `Bends` | whole, every docstring |
| `Plane/ArcMap` | whole |
| `Plane/ValidMap/Basic` | l. 1–300: every definition a leaf names |
| `Plane/LocalMap` | l. 56–319 |
| `Plane/ValidMap/Sectors` | `isSector_iff_of_partition`, `encard_sectors_of_partition`; the cusp fragment whole (l. 445–744) |
| `Plane/ValidMap/BaseSteps` | the bowtie at `E`: `bowtie_coloursAt_zero`, `_isHorn`, `_flanks` (l. 2804–2905), `bowtie_hornSet_zero` … `bowtie_not_shave_zero` (l. 3798–4025); the rest by heads |
| `Plane/ValidMap/UnitArc` | `isRingArc_of_clean`'s head, `l60Frag_isRingArc` (the pattern), `bend_toward`, `bend_away_whole` (statements and docstrings) |
| `Plane/ValidMap/Contact` | `flank_ne_of_doublyShadowed` (statement and docstring) |
| `Plane/ValidMap/Surgery`, `Cone`, `Moves`, `OpenMove` | `germArc`, `carrier_germArc`; by statement: `isOpen_hornSet`, `isPreconnected_hornSet`, `eq_branchPt_of_tanHeight_eq_zero`, `encard_sectorsOf_of_partition`, `dist_branchPt_one`, `mem_coneAt_hornSet`, `e_eq_of_mem_coneAt_hornSet`, `hornSet_curv_eq`, `ne_hornSet_of_interior_coneAt`, `mem_germArc_iff_of_mem_hornSet` |

### 1.3 The build as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in the worktree: `build: OK — 452 of 452 batches, 5
module(s) rebuilt, 4 module(s) with warnings, 8m6s`, exit 0 (`data/fs131/mb/build-0.log`; the full log, copied from
`build/gate/build/`, is `build-0-full.log`). The full log holds 131 warning lines, **all** `declaration uses 'sorry'` (0 others); distinct:
**59** — `Paint` 13, `Moves` 18, `Stuck` 21, `Bends` 7. As the brief says.

### 1.4 What I may and may not change

**Mine**: the proofs of the `sorry` leaves of `Proofs/HadwigerNelson/Plane/Models/Stuck.lean` and `Bends.lean`; new helper declarations in
those two files; a block "FS131-MB1" in `scripts/Axioms.lean`; this record; `tools/fs131_mb_*.py`; `data/fs131/mb/`; the report.

**Not mine**: any statement of the skeleton — a theorem's head, and the definitions `poleSq`, `poleSqArcs`, `stuckW`, `stuckArcs`,
`stuckCol`, `stuckModel`, `shadowWg`, `shadowWh`, `shadowArcs`, `shadowCol`, `shadowModel`, `awayP`, `awayW`, `awayArcs`, `awayModel`
(a definition is a statement); `Plane/Models/Paint.lean` and `Moves.lean` (implementer A's: I use `Paint`'s open leaves by their
statements, so on this branch whatever reads them rests on `sorryAx` **through `Paint` alone** until A's branch joins); every landed
module; `main`; the files Keryx alone writes. No new `axiom`, no `native_decide`. A false leaf is a message to the coordinator.

**The naming rule** (`LEAN.md` § Searching — Lean, last bullet): a helper of mine begins with its model's name (`stuckModel_…`,
`shadowModel_…`, `awayModel_…`, `cuspArc_…`/`cuspFrag_…`), and each new name is checked against every worktree's `Proofs/` before it is
committed (§ 1.6).

### 1.5 The order, and why it is not the planner's

The planner's order for this half is `Stuck` then `Bends`. I take **the cusp fragment's ring arc first** (three leaves of `Bends`), then
`stuckModel`, then `shadowModel`, then `awayModel`. Reason: the cusp arc reads nothing of `Paint`, so its two model theorems
(`cuspFrag_bend_away`, `cuspFrag_bend_toward`) are the only ones in my files whose receipt can read the standard three **on this
branch**; it is the cheapest whole model, and it prices the lane from two leaves, as the brief asks. The order within the plan's
dependencies is mine by the brief; nothing downstream reads the order.

### 1.6 Tools, each with a planted fault watched to fire

- `tools/fs131_mb_quotes.py` — § 1.1.
- `tools/fs131_mb_statements.py` — **the statement check**: every declaration of the skeleton at `fe9d6d32` in `Stuck` and `Bends` (a
  theorem by its head through the first `:=`, a definition whole) occurs verbatim, once, in the working file; and no path differs from
  `fe9d6d32` outside this job's paths. Output `data/fs131/mb/statements.out`. `--self-test` changes one character of each head in turn
  (53 plants) and requires each reported, beside the faithful run: `53 of 53 … faithful run 0 missing -> OK`.
- `data/fs131/mb/MBAxioms.lean` — the receipt by `lake env lean`: for each record its axioms **and the declarations of its dependency
  closure that are themselves proved by `sorry`, with their modules**, so that "rests on `sorryAx` through `Paint` alone" is read off,
  not asserted. Verdicts `STANDARD-THREE`, `SORRY-VIA-PAINT-ONLY`, `SORRY-IN-OWN-FILES`, `OTHER-AXIOM`. Its control is the skeleton
  itself: every record still open must read `SORRY-IN-OWN-FILES` and name its own leaf.
