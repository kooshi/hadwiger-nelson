# FS131-IQP3 — the p-adic plane to the gate: the ruled drops, five colours at 23, lint, the gate, the read-aloud and the drafts

*de Bruijn, the kernel lane's implementer. Brief `data/fs131/briefs/FS131-IQP3-padic.md` (on `main`; a copy is
`data/fs131/iqp3/brief-copy.md`). Worktree `.claude/worktrees/il5`, branch `fs131-kpa1`, from `f8ebf37f5`. The successor of
FS131-IQP2 (record `plans/FS131-IQP2-padic.md`, stopped at stage 1 at a pause Kooshi called) and FS131-IQP1 (record
`plans/FS131-IQP1-padic.md`); the plan is `plans/FS131-KPA1-padic-plan.md`. No fence. Started 2026-10-16.*

## Theorems this phase proved

To be filled at the gate, with each theorem's axioms as `#print axioms` gives them.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

The brief's four quotations (inventory items 1018, 1020, 1014 and 1002, `plans/FS131-close-inventory.md`), checked with
line breaks folded by the planner's checker, unchanged (`tools/fs131_kpa1_quotes.py`):

- against this worktree's copy of the inventory: **all four verbatim** (`data/fs131/iqp3/quotes.out`, exit 0);
- against `main`'s copy (`--root /home/kooshi/source/lean-dir`): **all four verbatim** (`data/fs131/iqp3/quotes-main.out`,
  exit 0);
- the planted control (one character of the first quotation changed) is refused: exit 1, `[0] NOT FOUND`
  (`data/fs131/iqp3/quotes-plant.out`).

The branch is at `f8ebf37f5`, as the brief says; `git status` showed no tracked change at the start (only the first job's
untracked logs under `data/fs131/iqp1/` and `data/fs131/kpa1/`). The worktree's `.lake/build` holds no `.olean` of the
eight landing modules (`PadicPlane/*`, `Arith/FibreCert7*`): it is `main`'s build, so the first build compiles them.

### 1.2 What is left, in order (FS131-IQP2's § 1.2, checked against the source)

Each line number of FS131-IQP2's § 1.2 was read against `PadicPlane/Tower.lean` at `f8ebf37f5` and holds: the binder
`(hk : 1 ≤ k)` at l. 346 and its `have _ := hk` at ll. 349–350, the call at l. 421; the binder `hpP` of
`charSum_levelOne_of_unitCircle` at l. 442, its `have _ := hpP` at ll. 447–448, the call at l. 486. `exists_levelEmbedding`
reads `hpP` (its own, for `p ≠ 2` and `charP_quot_pow`), which stays. No other file of `Proofs/` or `scripts/` names either
theorem (`grep -rn`). One correction to the route at 23: FS131-IQP1 and item 1002 give `κ ≈ 7.97`; the exact least cosine
sum over the circle of `𝔽₂₃²` is `−7.9606871…` (a float evaluation, for the docstring only; stage 2) and `circleCos_ge`'s
certificate (`M = 7960687200`, `κ₀ = M/(24·10⁹)`) gives `κ = 24κ₀ = M/10⁹ = 7.9606872`, so `1 + 24/κ = 4.0148…`; the value
`⌈·⌉ = 5` is unchanged.

The order: (1) the two drops; (2) `five_le_borelChromaticNumber_padicPlane_twentyThree` in place of `four_le_…`, with the
module docstring and `ARCHITECTURE.md`'s row brought to it; (3) the build and the lint — a saved stage; (4) the gate on one
commit with the statement comparison, the ruled changes listed, the vacuity scan's new sites and `#print axioms` of every
head statement — a saved stage; (5) the read-aloud — a saved stage; (6) the drafts — a saved stage; (7) the report.
