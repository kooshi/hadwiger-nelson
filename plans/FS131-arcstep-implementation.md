# FS131-IA1 — the arc step's groundwork (`exists_arcStep`): the record

*de Bruijn, the implementer, on branch `fs131-w5a` (cut from `fs131-w5c` at `ebb0b292`). Brief: `data/fs131/briefs/FS131-IA1-arc-step.md` (on
`main`'s tree). Working files: `data/fs131/ia/`. Tools: `tools/fs131_ia_*.py`.*

## Theorems this phase proved

(Filled stage by stage; each line: the declaration, its module, its axioms.)

## Stage 1 — SAVED (FS131-IA1): the readback, the as-given build, what I may change

### 1.1 The brief's quotations against their sources (standing rule 3)

`tools/fs131_ia_quotes.py` (a copy of IR1's checker under this job's prefix) on the brief: **17 quotations, 0 failures**, exit 0
(`data/fs131/ia/quotes.txt`); its self-test plants a one-letter change in the first quotation and exits non-zero naming it
(`data/fs131/ia/quotes-selftest.txt`: "17 quotations, 1 failures", "SELF-TEST: FIRED (good)"). The nine inventory lines are the head lines of
items 427, 421, 420, 424, 416, 385, 411, 372 on `main`'s `plans/FS131-close-inventory.md`; the two lines of `exists_arcStep` are `Procedure.lean`
l. 812 and l. 821 at `ebb0b292`; the three plan rows are KL1's § 3.1 and § 3.3 and IR1's § 17.3 in `plans/FS131-limit-kernel-plan.md`; the
three bends' first lines are `UnitArc.lean` l. 3776, l. 3968 and `fs131-w5`'s `BendCollar.lean` l. 1403. No mismatch.

### 1.2 Read for this job

- `exists_arcStep` whole with its docstring, and its one consumer `exists_procStep` (`Procedure.lean` l. 1046–1171), clause by clause.
- KL1's §§ 3.1, 3.3; IR1's Stages 14–17; E6's § 4.4 row and § 4.5's owed clause (`plans/FS131-E6-derivation.md` l. 386–397, 445–453).
- `UnitArc.lean`: `bendCol`, `bend_hlc`, `bendMap` and its seven lemmas, `toward_clear`, `away_clear`, `bend_toward`, `bend_away_whole` (proofs read).
- `fs131-w5` at `8ca5fc67`: `bend_toward_collar` whole; `CollarMap.lean` (`CollarFit`, `homeo`, `collarArcs`, `map`, `map_Γ`, `map_lens`,
  `map_agreesOff`); `Pushforward.lean`'s outline; `BendCollar.lean`'s header.
- `fs131-w4ba` at `71cca146`: `bend_away`'s statement and docstring, and `iso` (FS112-ISO).

### 1.3 The as-given build (`ebb0b292`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — 457 of 457 batches, 10 modules rebuilt, 5 with
warnings, 9 min 48 s, exit 0** (`build/gate/build/20261006T042652Z-914089.log`; driver log `data/fs131/ia/build-stage1-asgiven.log`). Every
warning is `declaration uses 'sorry'`: `Procedure` 2 (l. 795 `exists_vertexStep`, l. 812 `exists_arcStep`), `Terminal` 1 (l. 3592), and, not
this line's, `BaseDense` 3, `BendCollar` 1, `HexRing` 1 (this branch's stale copies; `fs131-w5` proved them, Stage 2 brings them).

### 1.4 What I may and may not change

- **May**: the merge's files; a new module `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` with its `Proofs.lean` line and
  `ARCHITECTURE.md` row; **new declarations only** in `UnitArc.lean`; a block "FS131-IA1" in `scripts/Axioms.lean` above `=== PURCHASED ===`;
  this record; `tools/fs131_ia_*.py`; `data/fs131/ia/`; the report.
- **May not**: any statement or definition anywhere; `Procedure.lean` beyond what the merge brings; `Terminal.lean`; the move modules; `main`;
  `fs131-w5c`; the gate. No `axiom`, no `native_decide`.

### 1.5 Found at the reading, sent to Keryx at once (by message, 2026-10-06)

Two clauses of `exists_arcStep` are false as stated (hand grade, one mind; details in Stage 3):

- **D1 — the degree clause** `(∀ x m, F.HasDegree x m → F'.HasDegree x m)`: an interior point of the bent arc has degree `≥ 2` in the clean
  map `F` and degree `1` after any bend; with both maps clean the clause forces `Γ' = Γ`. Its consumer reads it only at the points of `T`
  (`exists_procStep` l. 1146, `intro x _`). Proposed: `(∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m, F'.HasDegree x m')`.
- **D2 — `F'.badCount P < F.badCount P` on fragments**: the step assumes `Valid` and `IsClean` only, and on a punctured disc carrying
  infinitely many maximal bad arcs of `ω(P)` both counts are `⊤`. Proposed: add `(hP : F.IsPlaneMap)`.

## Stage 1 — SAVED (FS131-IA1)
