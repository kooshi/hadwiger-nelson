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

Each is in `Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean`, namespace `HadwigerNelson.Plane`; axioms by this job's print
(`tools/fs131_i6a_axioms.py`, § 2.4): the standard three, `[propext, Classical.choice, Quot.sound]`, for every line below.

- **FS111-M-PINCH, "(in, in) is impossible"** — `pinch_not_in_in` (Stage 2). Read against the row: "the case (in, in) is impossible".
- **FS111-M-PINCH** — `pinch` (Stage 2), over the cells `isSplitAt_of_in_out` and `hasTwoDiscsAt_of_out_out` (new; each at a wider class
  than `pinch`: no (H2), no measurability). Read against the row: split with one contact, either way round, or antipodal contacts and
  the tangent type.

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

## Stage 2 — SAVED (FS131-I6A): `pinch_not_in_in` and `pinch`; the re-pricing

### 2.1 The route, and where it left the plan

The plan's "one real-variable identity serves all four cells" is kept, stated once with the real inner product of `ℂ`:
`norm_sq_mul_sub_of_norm_eq_one` — for a unit `u`, `‖t w − u‖² = 1 − 2 t ⟨w, u⟩ + t² ‖w‖²`. Two consequences carry every cell:
`dist_add_mul_lt_one` (from `x` on the unit circle about `y`, along `w` with `‖w‖² ≤ 2⟨w, y − x⟩` and `⟨w, y − x⟩ > 0`, the point
`x + t w` is inside the open disc for `0 < t < 1`) and `one_lt_dist_add_mul` (along `w ≠ 0` with `⟨w, y − x⟩ ≤ 0` it is outside the
closed disc for every `t > 0`). With `u = ya − x`, `v = yb − x`, `c = ⟨u, v⟩`, the directions are the plan's: (in, in) `w = −(u + v)`,
or `i u` when `v = −u`; (in, out) `w = v − u`; (out, out) `w = u + v`. No coordinates and no `nlinarith` over a large context: each
inequality is a small lemma with its own hypotheses (`LEAN.md` § Searching — Lean).

**Changed from the plan:**
1. *The two non-trivial cells are theorems of their own, at a wider class than `pinch`*: `isSplitAt_of_in_out` (reads `N` open, `cover`,
   the two one-sided a.e. inclusions) and `hasTwoDiscsAt_of_out_out` (those and `disj`). Neither reads (H2) nor measurability; `pinch`
   is Step 1 (`half_dichotomy` on (H2)'s `P` for each set) followed by the 2 × 2 table over them. The (out, in) cell is the (in, out)
   cell with the sets exchanged.
2. *`pinch_not_in_in` is moved above `pinch`* in the file (its docstring and statement byte-identical; `pinch` uses it). No declaration
   was renamed or restated.
3. *(P4) is one lemma*, `subset_of_isOpen_ae_le_isClosed`: an open set almost everywhere inside a closed set is inside it.

**New declarations** (all in `Plane/Saturated/Pinch`, each with a docstring; names checked unused in the tree, on `origin/main`, on
`origin/fs131-w6` and in Mathlib, 2026-10-06): `norm_sq_mul_sub_of_norm_eq_one`, `dist_add_mul_lt_one`, `one_lt_dist_add_mul`,
`exists_add_mul_mem_of_isOpen`, `real_inner_lt_one_of_ne`, `neg_one_lt_real_inner_of_ne_neg`, `subset_of_isOpen_ae_le_isClosed`,
`isSplitAt_of_in_out`, `hasTwoDiscsAt_of_out_out`.

### 2.2 The two leaves against their row (`data/fs131/k6/backlog-rows-w6.md`, row 26, FS111-M-PINCH)

The row, verbatim: "at a saturated point x of an honest a.e.-proper colouring with a neighbourhood N in which only two colours a, b have
positive measure and each is a.e. one connected open set of density points (H1, H2): either N is split by one unit circle T₁(y) with a
inside and b outside or the reverse, y a contact of both colours, or two open unit discs tangent at x from opposite sides lie a.e. in S_a
and in S_b; the case (in, in) is impossible; no positive density of the partner is needed".

- `pinch_not_in_in` — "the case (in, in) is impossible": with `N` open and a.e. `A ∪ B`, `x ∈ N` on both unit circles, `A ∩ N` a.e. in
  `B̄(ya, 1)` and `B ∩ N` a.e. in `B̄(yb, 1)` give `False`. Read aloud: yes, that clause, at the class the planner fixed.
- `pinch` — "either N is split by one unit circle … with a inside and b outside or the reverse, y a contact of both colours": the first
  disjunct, `ya = yb ∧ (IsSplitAt A B N x ya ∨ IsSplitAt B A N x ya)`; "or two open unit discs tangent at x from opposite sides lie a.e.
  in S_a and in S_b": the second, `yb − x = −(ya − x) ∧ IsTangentAt A B N x (ya − x)`, the tangent type carrying its contacts (ruled,
  inventory item 481). "No positive density of the partner is needed": the contacts are points of `essSupport` only. Read aloud: yes.

### 2.3 What the proofs read (against the second planner's mutation audit, its § 9.2)

- `pinch_not_in_in` reads every hypothesis it has.
- `pinch` reads `hA`, `hAn`, `hB`, `hBn` (through `half_dichotomy`), `h.isOpen`, `h.cover`, `h.disj` (in the (out, out) cell only, as the
  audit says), `hx`, both contacts and both distances. **Of (H2) it reads less than `H2On` carries**: `P` preconnected, `P ⊆ densitySet A`
  and `A ∩ N =ᵐ P`. That `P` is open and that `P` is non-empty are never read (`obtain ⟨Pa, -, hPac, …⟩`, and only
  `hPac.isPreconnected`). A generalization, reported: the pinch holds with (H2) weakened to "within `N` the set is a.e. one preconnected
  set of density points". (The derivation's own note on openness, `plans/FS111-M-regularity.md` § 3 l. 311, places its use at M-EXTREME,
  not at the pinch.)

### 2.4 The save

- **Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` — **OK — 464 of 464 batches, 2 modules
  rebuilt (`Pinch`, `Proofs`), 2 modules with warnings**, every warning `declaration uses sorry` (6: `Pinch` 5 — `half_upperDensity`,
  `sq9_isTangentAt`, `TwoColourOn.essBoundary_inter_eq`, `c11_discs`, `c11_split`; `MapColouring` 1), 8m27s, exit 0
  (`build/gate/build/20261006T130403Z-4185233.log`; driver log `data/fs131/i6a/logs/build-1-pinch.log`).
- **Axioms** (this job's print, not the gate's audit): `tools/fs131_i6a_axioms.py` reads the names of `scripts/Axioms.lean`'s block
  "FS131-I6A", prints each on a scratch file importing the module (`data/fs131/i6a/AxiomsScratch.lean`), and checks each record as a set.
  11 records, 11 clean, each exactly `[propext, Classical.choice, Quot.sound]` (`data/fs131/i6a/logs/axioms-1.out`). **Controls that
  fire**: the planted `theorem … := sorry` in the scratch file comes back `[sorryAx]` on every run (exit 3 if it does not); and with
  `--also HadwigerNelson.Plane.c11_split` — a leaf still on `sorry` — the run reports `NOT CLEAN | … c11_split: ['sorryAx']` and exits 1
  (`axioms-1-control.out`).
- **Statement check** against `3928644b`: 19 base declarations, statements identical; 9 helpers; 5 `sorry` leaves; 0 failures, exit 0
  (`data/fs131/i6a/logs/statements-1.out`).

### 2.5 Re-priced from the first two leaves

The plans priced these two at 1.5 h + 6 h. Measured: both, with their nine helpers, elaborated in two rounds of `lake env lean` (one
error, a `simp` normal form in the orthogonality step), inside half an hour of agent time; the cost of the save was the build's walk
(8m27s for two modules, 464 batches). **So the plan's prices for the pure leaves are high by an order of magnitude, not by two to
three.** The remaining five (priced 3 + 1 + 4 + 6 + 0.5 = 14.5 h) are re-priced at under an hour together, and one build; their proofs
already elaborate in scratch against this stage's module (§ 3). What the number measures: agent time to a proof that elaborates under
`lake env lean` with `autoImplicit` off, for leaves whose statements were already right; it says nothing about leaves that need a
statement changed, and there was none here.

Own count at this stage: about 230k (the harness's is not visible to me).
