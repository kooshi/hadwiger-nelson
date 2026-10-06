# FS131-I8A — wave 8's first implementer: the route to `emptyNS` (`Plane/RingCalculus/Empty`), then `Star`'s two leaves

*Job FS131-I8A (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8a` (cut from `fs131-w8` at `f1c13612`). Brief:
`data/fs131/briefs/FS131-I8A-wave8-first.md` (on `main`). The plan: `plans/FS131-w8-kernel-plan.md` (the planner's record, FS131-K8).
Working files: `data/fs131/i8a/`. Tools: `tools/fs131_i8a_*.py`.*

## Theorems this phase proved

(Filled at each saved stage; each line: the declaration, its axioms, the row it was read against.)

- none yet (Stage 1 is the readback).

## Stage 1 — SAVED (FS131-I8A): the readback, the branch built as given, the statement instrument

### 1.1 What I may and may not change

- **May**: the proofs of `ringPt_sixth_dist_le_one`, `v6_count`, `exists_ne_mem_closure_inter_of_split`, `v6_hug`, `v6_hubs`, `emptyNS`
  (`Plane/RingCalculus/Empty`), then of `star_recip`, `star_anti` (`…/Star`) if budget remains; new helper declarations under names no
  other module declares; a new module of my own beside them, with its `Proofs.lean` and `ARCHITECTURE.md` lines; a block "FS131-I8A" in
  `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i8a_*.py`; `data/fs131/i8a/`;
  `data/fs131/reports/FS131-I8A.md`. A docstring may be corrected (the plan's § 5.6).
- **May not**: any statement or definition (a false or unprovable leaf is a message to the coordinator); the foundation
  (`…/Basic`) or any landed module beyond new declarations; the planner's record; `outerAdj`, `doubleTip` (they wait for the second
  planning pass and keep their `sorry`); `v6_hubs`, `v6_hug` stay public with their `VACUITY DECLARED` lines and the companions
  `v6_hubs_vacuous`, `v6_hug_vacuous` stay as they are (ruling 518); no `axiom`, no `native_decide`; no nine-colour map of my own and no
  merge of `fs131-w6m` (the model of `emptyNS` is a later job's, ruling 525 (c) as amended by item 530); no merge, no gate, no `main`.

### 1.2 The brief's quotations against their sources (standing rule 3)

Checked by script (`grep -cF` of each quoted first line in its source file; 31 quotations): **every one is found exactly once,
verbatim** — the Counter-priors sentence (`CLAUDE.md`), inventory items 518, 524, 525 (`plans/FS131-close-inventory.md` on `main`,
ll. 5495, 5613, 5636), the ten statements' first lines (`Empty.lean`, `Star.lean`), and the plan's headings and bullets.

One finding about the brief, not a mismatch of wording: the two table rows it quotes under "### 5.4 The statements, attacked" (the rows
for `emptyNS` and for `star_flank`, …) stand in the plan's **§ 5.5** table ("Inhabitants and vacuity"), ll. 287 and 291, not in § 5.4.

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full (with the two facts the launch message names: the section-`variable` bullet
  and the closed-`Nat`-term bullet); `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record whole (`plans/FS131-w8-kernel-plan.md`, Stages 1–5).
- My files and what they import, in full: `Plane/RingCalculus/Empty`, `…/Star`, `…/Basic`, `Plane/ArcMap`, `Plane/LocalMap`. The
  statement surface (every signature, extracted by script) of `Plane/Tiles`, `Plane/Chord`, `Plane/RingGerm`, `Plane/LocalStructure`;
  their proofs are read where a leaf uses them.
- The rows' argument: `plans/FS116-V6-verification.md` § 2.1–2.2 (V6-DIAM … V6-COUNT, the whole route to EMPTY), ll. 91–191.
- Inventory items 518, 524, 525, 530 whole.

### 1.4 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: `data/fs131/i8a/logs/build-1-as-given.log` ends
"build: OK — all 1805 modules already up to date, nothing built, 2 module(s) with warnings", `EXIT=0`; the warnings are ten
`declaration uses sorry` lines — eight in `Empty.lean` (ll. 86, 97, 109, 125, 136, 148, 180, 193), two in `Star.lean` — the ten the
brief counts.

### 1.5 The leaves as the kernel has them (`LEAN.md` § Searching — Lean, last bullet)

`tools/fs131_i8a_stmt.py` elaborates each of the two modules twice — the source at `f1c13612` (`git show`) and the working source — with
one appended command that prints every declaration of the module from the environment (`ConstantInfo.type`: its structural hash and its
printed form with full names; a definition's value hash), and compares by name. It is a comparison of elaborated signatures, not of text.

- Baseline, saved: `data/fs131/i8a/sigs-base.tsv` (23 declarations: `Empty` 12, `Star` 11).
- **Each of the ten leaves, read from that print, is the statement the file shows**: the three leaves stated under the section
  `variable {k : ℕ} {F : ArcMap k}` are `exists_ne_mem_closure_inter_of_split` (which names `F`, and the kernel's statement begins
  `∀ {k : ℕ} {F : ArcMap k} {p : ℂ}, p ∈ F.dom → …`), `ringPt_sixth_dist_le_one` and `v6_count` (which name no map, and the kernel's
  statements have none — as intended: pure trigonometry and finite combinatorics); the other seven carry their own `{F : ArcMap 6}`.
  No leaf has lost a hypothesis to the section-variable rule.
- Controls, each watched to fire (`data/fs131/i8a/logs/stmt-selftest-1.log`): `text` (a hypothesis of `v6_count` altered: exit 1, names
  `v6_count`); `include` (`include hbad in` above `ringPt_sixth_dist_le_one` — the statement's text unchanged, the kernel's statement
  gains `0 = 1 →`: exit 1, names it; this is the class a text diff passes); `def` (`v6_anti`'s conclusion altered: exit 1, names it).
  The instrument's own failure is exit 2 and was seen once (a wrong option name in the printer: "INSTRUMENT FAILURE … the printer did
  not report"), never a pass.

### 1.6 Working method

- Helpers go in new modules beside `Empty` (one per leaf group), imported by `Empty`; the leaves stay in `Empty` with their statements.
- Iteration by `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false` (2.4 s on `Empty` as given); evidence only from
  `./scripts/build.sh` under the slot.
- At each save: the build's log, the statement check against `f1c13612`, the axioms print of the stage's declarations with a `sorry`
  control beside it, commit by explicit path, push.
