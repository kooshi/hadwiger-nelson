# FS131-CC1 — lane C of the collar bend (de Bruijn, the implementer)

*Job FS131-CC1, de Bruijn (Opus 5.5), launched 2026-10-05 on branch `fs131-w5k`, cut from `fs131-w5` at `2736ab8c` (CG1's move commit;
worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k`). Brief `data/fs131/briefs/FS131-CC1-collar.md` (on `main`), with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building and § Make the gate fail. No fence (inventory ruling 1). Working files
`data/fs131/cc/`; tools `tools/fs131_cc_*.py`. The planner's record is `fs131-w5`'s `plans/FS131-collar-kernel-plan.md` (KP2, with lane G's
stages from 7 on); this file is lane C's.*

## Theorems this phase proved

None yet (filled at each saved stage).

## Stage 1 — SAVED (FS131-CC1): the readback, the as-given build, and what this job may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_cc_quotes.py` reads each quotation from the brief itself on `main` (the `> ` line above each `> — source:` line) and requires it
verbatim in the source the brief names: KP2's plan on `fs131-w5` at `2736ab8c` and at `fs131-w5`'s head (both), `CLAUDE.md` and the inventory
on `main`. Result `data/fs131/cc/quotes.txt`: **PASS, 9 of 9 verbatim**. `--self-test` (`data/fs131/cc/quotes-selftest.txt`): one changed
character in each quotation in turn, and one quotation pointed at a source that does not hold it — **10 of 10 plants fired**, the unplanted
partner PASS.

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim |
| 2–4 | lane C's row of § 5.2, C's order, "Interfaces" | KP2's plan § 5.2 at `2736ab8c` and at `fs131-w5`'s head | verbatim |
| 5–9 | items 394, 395, 396, 390, 378 (first lines) | `plans/FS131-close-inventory.md` on `main` | verbatim |

No mismatch.

Read in full: KP2's plan (Stages 1–6, with lane G's Stages 7–8), KB2's design (`plans/FS131-I5-implementation.md` § 44), `Pushforward.lean`,
`BendCollar.lean`, `CollarMap.lean`, `RadialPush.lean`, and the chart machinery they cite (`LocalStructure` § The sector structure,
`ValidMap/Sectors`, `ValidMap/Surgery`'s germ arcs and sector counts).

### 1.2 The as-given build (`2736ab8c`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` at `2736ab8c`: **OK — 455 of 455 batches, 9 modules rebuilt
(`Pushforward`, `RadialPush`, `CollarMap`, `BendCollar`, `Terminal`, `Dense`, `BaseWalk`, `BaseDense`, `Proofs` — the tree's `.lake/build` was
copied from `fs131-w5c`), 7 with warnings, every warning `declaration uses 'sorry'`**, exit 0, 9 min 3 s (`build/gate/build/20261005T120300Z-4055015.log`,
which ends "Build completed successfully (5791 jobs)"; driver log `data/fs131/cc/build-asgiven.log`). `sorry` declarations in lane C's files:
`Pushforward` 7, `BendCollar` 14 (the fourteen of KP2's C row; `bend_toward_collar` none of its own).

### 1.3 What this job may change, and what it may not

**May change**: `Proofs/HadwigerNelson/Plane/ValidMap/Pushforward.lean` (proofs of its seven children, and new supporting declarations);
in `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` the proofs of lane C's fourteen declarations (`exists_collarFit`, `degree_openArc`,
`map_degree_lensCurve`, `map_degree_end`, `map_hasDegree`, `map_hasRepeatedColour`, `map_ringArcsWithin`, `sides_end`, `map_R1`, `map_R2`,
`map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`) and new children beside them; the new child B0 `collarModel` (with its
statement, which is this lane's to write: plan § 4); `scripts/Axioms.lean` (a block of my own, headed "FS131-CC1", above the
`=== PURCHASED ===` banner); this record; `tools/fs131_cc_*.py`; `data/fs131/cc/`; `data/fs131/reports/FS131-CC1.md`.

**May not change**: any statement in the skeleton — a hypothesis, a conclusion, a docstring, a definition the statements use — and no new
`axiom`, no `native_decide`; `RadialPush.lean` and `CollarMap.lean` (lane G's), `BaseDense`, `HexRing`, `BaseWalk`, `Proofs.lean` and
`ARCHITECTURE.md` (unless I add a module). A lane-G statement I need changed is a message to the coordinator. No merge into `fs131-w5`, no
`main` taken in, no gate run, nothing on `main`.

## Stage 1 — SAVED (FS131-CC1)
