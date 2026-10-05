# FS-131 — the collar bend's construction: the kernel plan (de Bruijn, the planner)

*Job FS131-KP2, de Bruijn (Opus 5.5), launched 2026-10-05 on branch `fs131-w5` at `ae881022` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`). Brief `data/fs131/briefs/FS131-KP2-collar.md` (on `main`), with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building. No fence (inventory ruling 1). Working files `data/fs131/kp2/`; tools
`tools/fs131_kp2_*.py`.*

## Theorems this phase proved

None yet (updated at each saved stage). A planning job: it lays `bend_toward_collar` out as named children with `sorry` at each; a child
short enough to prove here is proved and listed here with its grade and address.

## Stage 1 — SAVED: the readback, the as-given build, and what this job plans

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script, 2026-10-05: `tools/fs131_kp2_quotes.py` reads each quotation from the brief itself (the `> ` line above each
`> — source:` line) and requires it verbatim in the source the brief names — the leaf at `ae881022`, KB2's record at `ae881022`, the
inventory and `CLAUDE.md` on `main`. Result `data/fs131/kp2/quotes.txt`: **PASS, 9 of 9 verbatim**; `--self-test` changes one character in
each quotation in turn and requires the check to fail: **9 of 9 plants fired** (`data/fs131/kp2/quotes-selftest.txt`).

| # | quotation (opening words) | source | result |
|---|---|---|---|
| 1 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | verbatim (two sentences of Kooshi's longer quotation) |
| 2 | "theorem bend_toward_collar (hF : F.Valid) {P : ℂ} …" | `Plane/ValidMap/BendCollar.lean` at `ae881022` | verbatim (its first line) |
| 3 | "- **The lens boundary `β`**: `C_A`, `C_B`, …" | `plans/FS131-I5-implementation.md` § 44.3 | verbatim (its first line) |
| 4–9 | items 359, 365, 369, 378, 386, 387 (first lines) | `plans/FS131-close-inventory.md` on `main` | verbatim |

No mismatch. One note on the brief's wording, not a defect: "Done means" item 2 lists `RingArcsWithin` among "the child's clauses"; the
statement of `bend_toward_collar` has no `RingArcsWithin` clause — R1 (`M.IsRingArc → F.IsRingArc`) is its constant-sided form. The
construction gives `M.RingArcsWithin F` anyway (every arc it adds has radius `≠ 1`), and this plan states it as a child because R1 is proved
through it (§ 3).

### 1.2 The as-given build (`ae881022`)

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1781 modules already up to date, nothing built,
4 modules with warnings, every warning `declaration uses 'sorry'`**, exit 0 (`build/gate/build/20261005T104808Z-3479001.log`; driver log
`data/fs131/kp2/build-asgiven.log`). The `sorry` declarations: `BendCollar` 1 (`bend_toward_collar`, line 31), `HexRing` 1 (`bv_l3`),
`BaseDense` 4 (three `exists_preBend` children and `cv_exists`'s stale copy), `Terminal` 9 (stale; the `Terminal` lane's).

### 1.3 What this job plans, and what it may change

**Planned**: the construction of `ArcMap.bend_toward_collar` (`Plane/ValidMap/BendCollar`), whose statement is fixed — reduced to named
children, each with `sorry`, each read back against what its consumer needs, a plan and a price per child, the obligation pass, inhabitants
for any structure a child takes as a hypothesis, and a handoff that two implementers can split by file. A child provable in about an hour is
proved here.

**May change**: `Plane/ValidMap/BendCollar.lean` (new declarations; `bend_toward_collar`'s docstring and statement byte-for-byte unchanged,
checked by script), new modules upstream of it, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g",
extended), this record, `tools/fs131_kp2_*.py`, `data/fs131/kp2/`, `data/fs131/reports/FS131-KP2.md`.

**May not change**: any declaration `main` brought (new declarations only — so `bendMap`, `cutArcs`, `toward_clear`, `bend_toward` are cited
or re-proved under new names, never edited); `BaseDense` (the remaining `exists_preBend` children are another job's), `HexRing`,
`BaseWalk`, `Terminal`. No merge of another branch, no gate run, nothing on `main`. No new `axiom`, no `native_decide`.

## Stage 1 — SAVED
