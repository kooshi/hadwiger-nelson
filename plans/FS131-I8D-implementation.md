# FS131-I8D — wave 8, the semi-hub rows' second module and the outer-adjacency row

*Job FS131-I8D (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8d` (cut from `fs131-w8b` at `6e0cf10d`). Brief:
`data/fs131/briefs/FS131-I8D-wave8-semihub.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` (the planner's record, Stages
6–10) and `plans/FS131-I8B-implementation.md` (the join job's record, its section "For the two implementers who start from here").
Working files: `data/fs131/i8d/`. Tools: `tools/fs131_i8d_*.py`.*

## Theorems this phase proved

*Filled stage by stage; each line is read against its row. Until the wave's join every leaf here that cites a statement of
`Plane/RingCalculus/SemiHub` rests on that module's open leaves (FS131-I8C's, proved in a tree of its own): the line says which.*

(none yet — Stage 1 is the readback)

## Stage 1 — SAVED (FS131-I8D): the readback, the branch built as given

### 1.1 What I may and may not change

- **May**: the proofs of the six open leaves of `Plane/RingCalculus/SemiHubPlaces` and of `outerAdj` in `Plane/RingCalculus/Empty`;
  helper declarations under names no other module declares; a new module of my own beside them, with its `Proofs.lean` and
  `ARCHITECTURE.md` lines; docstrings; a block "FS131-I8D" in `scripts/Axioms.lean` above the PURCHASED banner; this record;
  `tools/fs131_i8d_*.py`; `data/fs131/i8d/`; `data/fs131/reports/FS131-I8D.md`.
- **May not**: any statement or definition; the shared module `Plane/RingCalculus/StarChart` (a change to it is a message to the
  coordinator); `Plane/RingCalculus/SemiHub` (FS131-I8C's); the wave's other modules; any landed module; `main`; an `axiom`;
  `native_decide`; a merge of another branch; the gate.

### 1.2 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i8d_quotes.py` (the form of the join job's `tools/fs131_i8b_quotes.py`, which is another job's and is not edited) reads
every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace collapsed, in the source:
**27 quotations, 27 found verbatim, 0 missing** (`data/fs131/i8d/logs/quotes.log`, exit 0). Planted fault (`--fault`, one letter of the
first quotation changed): exit 1, one `MISS`, the other 26 `ok` (`data/fs131/i8d/logs/quotes-fault.log`).

One note on the sources, not a defect of wording: the fourteen quotations of statements are first lines of longer signatures, and the
seven of the plan are headings; each was read whole (§ 1.3, § 1.4).

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record, Stages 6–10 whole (§ 7.4 on `outerAdj`; § 8.3 the statements against their rows; § 8.4 the attacks; § 9.1 the
  three carrying lemmas; § 9.3 the six routes and the case table of `semiHub_places`; § 9.4 the plan for `outerAdj`; §§ 9.5–9.8).
- The join job's record: Stages 2–5 and "For the two implementers who start from here" whole (its seven notes on what will not go as
  the plan writes it).
- The wave's modules in this tree, in full: `Plane/RingCalculus/Basic`, `Star`, `SemiHub`, `SemiHubPlaces`, `SoleTip` (the template for
  `outerAdj`); of `Empty` the header and the section of `outerAdj`; of `Plane/LocalMap` the vocabulary (ll. 60–300: cones, germs,
  ring arcs, (Q), change points, hubs).
- The rows' entries (`data/fs131/k8/rows-extract.md`: FS116-N3-SEMI, FS116-N3-CROSS, FS116-RING-TRANSFER-QC, FS129-SR3-OUTERADJ) and
  their arguments: `plans/FS116-N3-proof.md` §§ 2.1–2.4, 3.1, 3.2; `plans/FS116-V5-verification.md` §§ 3.2–3.4;
  `plans/FS129-SR3-audit.md` Stage 3 whole (§ 3.1).

### 1.4 The leaves as the kernel has them

`#check @…` on the seven leaves and on eight shared lemmas, from the built modules (`data/fs131/i8d/logs/leaf-signatures.log`):
**every hypothesis of every leaf is a binder of its kernel statement** — the two modules declare only `{k}` and `{F}` as section
variables, and each leaf's printed type carries `F.Valid`, `F.NonSiamese` and every named hypothesis of its source text, in order.
No leaf lacks a hypothesis its row reads (inventory item 556's check); nothing to message.

### 1.5 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, log `data/fs131/i8d/logs/build-1-as-given.log`:
"build: OK — all 1812 modules already up to date, nothing built, 3 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"` on
`Proofs/HadwigerNelson/Plane/RingCalculus/`: `SemiHub` 17, `SemiHubPlaces` 6, `Empty` 1 — 24 leaves, seven of them this job's.
