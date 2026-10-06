# FS131-I8C — wave 8, the semi-hub rows' first module (`Plane/RingCalculus/SemiHub`)

*Job FS131-I8C (de Bruijn, the implementer), 2026-10-06, branch `fs131-w8c` (cut from `fs131-w8b` at `6e0cf10d`). Brief:
`data/fs131/briefs/FS131-I8C-wave8-semihub.md` (on `main`). The plans: `plans/FS131-w8-kernel-plan.md` Stages 6–10 (the planner's
record, FS131-K8b) and `plans/FS131-I8B-implementation.md` (the join job's record: the shared lemmas and its section for the two
implementers). Working files: `data/fs131/i8c/`. Tools: `tools/fs131_i8c_*.py`.*

## Theorems this phase proved

*(filled at each saved stage; the list at the last stage is the record)*

## Stage 1 — SAVED (FS131-I8C): the readback, the leaves' kernel signatures, the branch built as given

### 1.1 What I may and may not change

- **May**: the proofs of the 17 `sorry` leaves of `Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean`, and new helper
  declarations there under names no other module declares; a new module of my own beside it (with `Proofs.lean` and
  `ARCHITECTURE.md`); a block "FS131-I8C" in `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record;
  `tools/fs131_i8c_*.py`; `data/fs131/i8c/`; `data/fs131/reports/FS131-I8C.md`. Docstrings may be corrected (the plan's § 9.8).
- **May not**: any statement or definition; the shared module `StarChart` (a change to it is a message to the coordinator);
  `SemiHubPlaces` and `outerAdj` (FS131-I8D's); the wave's other modules; any landed module; `main`; an `axiom`;
  `native_decide`; a merge of another branch; the gate.

### 1.2 The brief's quotations against their sources (standing rule 3)

`tools/fs131_i8c_quotes.py` (the form of the join job's `tools/fs131_i8b_quotes.py`, which is another job's and is not edited)
reads every `> …` block of the brief with its `> — source:` line and looks for the text, whitespace collapsed, in the source:
**36 quotations, 36 found verbatim, 0 missing** (`data/fs131/i8c/logs/quotes.log`, exit 0). Planted fault (`--fault`, one letter
of the first quotation changed): exit 1, one `MISS` (`data/fs131/i8c/logs/quotes-fault.log`).

One note on the sources, no defect of wording: the seventeen statement quotations and the seven shared-lemma quotations are the
first lines of their declarations; each was read whole in the module (§ 1.3) and from the kernel (§ 1.4).

### 1.3 What was read

- The brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- The planner's record, Stages 6–10 whole (§ 7.5 the three words; § 8 the model, what the pass changed, the statements against
  their rows and attacked; § 9.1–9.2 the routes; § 9.5, 9.6, 9.8). The join job's record whole (its § 3.2 statements, § 3.3 on K2,
  and "For the two implementers who start from here", notes 1–7).
- The module `Plane/RingCalculus/SemiHub` in full; `Plane/LocalMap` in full; `Plane/RingCalculus/Basic` (definitions and first
  consequences); `Plane/RingCalculus/StarChart` (statements, and the proofs of G1, `ncard_tileAt_eq`, K1); the landed lemmas each
  leaf cites, at their statements (named per leaf in the later stages).

### 1.4 The leaves' kernel signatures (inventory item 556)

`#check @…` on the seventeen leaves from the built modules (`data/fs131/i8c/logs/leaf-signatures-as-given.log`): **every hypothesis
its statement names is a binder of the kernel's statement; no section variable carries one** (the module declares only `{k}` and
`{F}`). `isRingArc_of_edge` reads no validity and no non-Siamese hypothesis, as its docstring says ("Any map"); `qcol_inner_tile`,
the two sub-arc lemmas and `germPair_inner_ne` read no *simple*; the four `ringTile_*` read `F.Covers p 1`, `4 ≤ ncard`,
`k ≤ ncard + 2` and a change point; the five star leaves read `p ∈ F.dom`, `F.SimpleOn {p}` and `ncard = 4`.

### 1.5 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, log `data/fs131/i8c/logs/build-1-as-given.log`:
"build: OK — all 1812 modules already up to date, nothing built, 3 module(s) with warnings", `EXIT=0`. `rg -c "^\s*sorry"` on
`Proofs/HadwigerNelson/Plane/RingCalculus/`: `SemiHub` 17, `SemiHubPlaces` 6, `Empty` 1 — the 24 the join job handed on.
