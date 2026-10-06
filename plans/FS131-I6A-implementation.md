# FS131-I6A — wave 6, the pinch at a two-colour point: the open leaves of `Plane/Saturated/Pinch` (de Bruijn, the implementer)

*Job FS131-I6A, de Bruijn (Opus 5.5), launched 2026-10-06 in the worktree `.claude/worktrees/fs131-w6p` on branch `fs131-w6p`, cut from
`fs131-w6` at `3928644b`. Brief `/home/kooshi/source/lean-dir/data/fs131/briefs/FS131-I6A-wave6.md` (on `main`), with
`plans/STANDING-RULES.md`, `LEAN.md` and `RUNNING.md` § Building and § Make the gate fail, and watch it fail. The planners' record is
`plans/FS131-w6-kernel-plan.md` (Stages 1–9). Working files `data/fs131/i6a/`; tools `tools/fs131_i6a_*.py`.*

**What this job may change, and what it may not.**
- *May*: the proofs of the seven open leaves of `Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean` (`pinch_not_in_in`, `pinch`,
  `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`, `half_upperDensity`, `sq9_isTangentAt`); new helper declarations there, under
  names no other module declares; a new module of its own beside it, with `Proofs.lean` and `ARCHITECTURE.md` for it; a docstring line naming
  a Lean model (brief, Done means 3); `scripts/Axioms.lean` (a block headed "FS131-I6A", above the `=== PURCHASED ===` banner); this record;
  `tools/fs131_i6a_*.py`; `data/fs131/i6a/`; `data/fs131/reports/FS131-I6A.md`.
- *May not*: any statement or definition (a hypothesis, a conclusion, a binder) of `Pinch` or `Basic`; `Plane/Saturated/Basic.lean` at all
  (a need there is a message to the coordinator); `Plane/Saturated/MapColouring.lean` (the other implementer's); the planners' record; any
  landed module beyond new declarations; `main`; a new `axiom`; `native_decide`. It runs no gate, merges no branch, starts no agent.

## Theorems this phase proved

*(One line per kernel theorem, with its declaration and its axioms; filled as the stages save. Built by the worktree's
`./scripts/build.sh`; the axiom audit is the gate's, the prints here are this job's own, on a scratch file with the module's imports.)*

- none yet (Stage 1 is the readback).

## Stage 1 — SAVED (FS131-I6A): the readback and the as-given build

### 1.1 The brief's quotations against their sources (standing rule 3)

By script (`tools/fs131_i6a_quotes.py`: exact substring match of each `>`-block against the file its `— source:` line names; a relative
path read in the main tree; output `data/fs131/i6a/logs/quotes.out`): **15 quotations, 15 exact, 0 mismatched**, exit 0. With one
character of the first quotation altered (`--plant`) it reports 1 mismatch and exits 1 (`quotes-plant.out`); a brief with no quotation
would exit 2. No finding about the brief.

### 1.2 Read, in order

The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the gate fail, and watch it fail;
`Plane/Saturated/Pinch` and `Plane/Saturated/Basic` whole; the planners' record, Stages 1–9 whole; `plans/FS111-M-regularity.md` §§ 2.1,
3.1–3.6 (the pinch's derivation: M-PINCH, M-C11, the controls, the verdict); inventory items 486, 490, 495 (on `main`); of the landed
library, `Plane/UnitPairs` whole, and the parts of `Plane/Cover`, `Plane/DensityPoints` and `Plane/CoverExamples` the leaves read
(`essSupport_*`, `densityRatio_add_compl`, `tendsto_densityRatio_of_notMem_essClosure`, `subset_densitySet_of_isOpen_ae_subset`,
`upperDensityAt_pos_of_balls`, `hullset`, `sq9Sq`, `sq9Sq_subset_essClosure`).

### 1.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1799 modules already up to date, nothing
built, 2 modules with warnings**, every warning `declaration uses sorry` (8: `Pinch` 7, at lines 131, 140, 150, 162, 169, 218, 237;
`MapColouring` 1), exit 0 (`build/gate/build/20261006T125530Z-4155157.log`; driver log `data/fs131/i6a/logs/build-0-as-given.log`).

### 1.4 The statement check

`tools/fs131_i6a_statements.py` compares `Pinch.lean` and `Basic.lean` in the tree against `3928644b`: every base declaration's statement
— the text from its keyword to its first `:=` — byte-identical; the body of every declaration the base proved byte-identical; `Basic.lean`
and the module docstring byte-identical; a base docstring may differ only at `half_upperDensity` and `pinch` (the brief's model line), and
there only by added lines; a new `axiom` or a `native_decide` fails; helpers are listed. Run on the tree as given
(`data/fs131/i6a/logs/statements-0.out`): 19 base declarations, 0 helpers, 7 `sorry` leaves, 0 failures, exit 0. **Planted faults, each
watched to fire** (in-memory copies, the tree untouched; `statements-plant-*.out`): `hyp` (`pinch` without `hx`) — "STATEMENT differs";
`doc` (a word of `c11_split`'s docstring) — "docstring differs"; `basic` (one character of `Basic.lean`) — "Basic.lean differs";
`axiom` — "new axiom"; `proof` (a name in `half_dichotomy`'s body) — "the body of a base-proved declaration differs". Each exits 1 with
exactly one failure; a base that parses to no declaration exits 2.

### 1.5 Registered before the first proof

The plans price the seven leaves at 1.5 + 6 + 3 + 1 + 4 + 6 + 0.5 = 22 agent-hours, and expect to be high by a factor of two to three.
My expectation, written before any leaf: all seven close in this job with probability 0.7; the leaf most likely to resist is
`half_upperDensity` (the plan's "strip of width `r²`" needs an area estimate in `ENNReal`), then `c11_split` (two quarter-density bounds
at a point of the circle); a statement defect among the seven: 0.15 (the likeliest: a boundary case of `c11_split` at a point of
`sphere y 1 ∩ N` where `N` is small, or `half_upperDensity` at `P` unbounded).
