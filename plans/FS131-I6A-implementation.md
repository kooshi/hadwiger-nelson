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

All in `Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean`, namespace `HadwigerNelson.Plane`. Built by the worktree's
`./scripts/build.sh` (§ 3.4); grade **[kernel] once the wave's gate passes** — the gate is not this job's (brief, Done means 4). Axioms
by this job's own print (`tools/fs131_i6a_axioms.py`, 37 records, § 3.4): **every declaration below rests on exactly
`[propext, Classical.choice, Quot.sound]`**; no `axiom`, no `native_decide`, no named hypothesis beyond the statement's own.

- **FS111-M-PINCH** — `pinch` (two measurable sets with null unit pairs on a two-colour open set, any point of it, given contacts: one
  contact and the split type either way round, or antipodal contacts and the tangent type), over the cells `isSplitAt_of_in_out` and
  `hasTwoDiscsAt_of_out_out`; `pinch_not_in_in` ("the case (in, in) is impossible"). With them the planner's `pinch_interface`
  (every interface point of a family, where it is saturated) is free of `sorry`. Read against row 26 of
  `data/fs131/k6/backlog-rows-w6.md` (§ 2.2).
- **FS111-M-HALF**, the density clause — `half_upperDensity` (upper density at most `1/2` at a point with a contact, for every
  preconnected piece of the density set); the row's first clause before the blow-up — `half_sq_norm_le_inner_of_mem_closedBall`,
  `inner_le_half_sq_norm_of_notMem_ball` (with the planner's `half_dichotomy`: the piece lies in the closed half-plane facing an inner
  contact, or facing away from an outer one, up to `|z − x|²/2`). Read against row 25 (§ 3.2).
- **FS111-M-C11 (i)** — `c11_discs` (every point of the one `N` with both contacts carries the two tangent unit discs), over
  `IsSplitAt.hasTwoDiscsAt`; the planner's `c11_discs_interface` is free of `sorry`. **(iii)** — `c11_split` (the essential boundary of
  each set in `N` is the unit circle's part in `N`), over `essBoundary_inter_congr`, `essBoundary_ball_one`,
  `essBoundary_compl_closedBall_one`. Read against row 27 (§ 3.2). Clause (ii) is not this job's (FS131-E8-LOCAL).
- **The foundation's owed leaf** — `TwoColourOn.essBoundary_inter_eq` (in a two-colour open set the two sets have one essential
  boundary), over `TwoColourOn.essBoundary_inter_subset`; the planner's `TwoColourNhd.mem_essBoundary` is free of `sorry`, so the
  equivalence of `singularSet` with the frozen wording ((H2)'s clause `x ∈ cl P_a ∩ cl P_b`, plan § 9.1 item 2) no longer rests on a
  hand argument.
- **The inhabitant** — `sq9_isTangentAt` (`sq9` at `sqEdgePt` is of tangent type with normal `1`); the split type's model
  `isSplitAt_ball_compl_closedBall`; six `example`s under "The models" that apply `pinch`, `half_upperDensity`, `c11_discs`,
  `TwoColourOn.essBoundary_inter_eq`, `c11_split` and `IsSplitAt.hasTwoDiscsAt` to them.
- Supporting, each a new declaration with a docstring: `norm_sq_mul_sub_of_norm_eq_one`, `dist_add_mul_lt_one`, `one_lt_dist_add_mul`,
  `exists_add_mul_mem_of_isOpen`, `real_inner_lt_one_of_ne`, `neg_one_lt_real_inner_of_ne_neg`, `subset_of_isOpen_ae_le_isClosed`;
  `densityRatio_add_of_cover`; `densityRatio_eventuallyEq_of_ae_eq_inter`, `mem_essBoundary_of_balls`,
  `exists_ball_subset_ball_of_mem_sphere`, `exists_ball_subset_compl_closedBall_of_mem_sphere`;
  `volume_halfPlane_inter_closedBall_le`, `volume_shifted_halfPlane_inter_closedBall_le`, `densityRatio_le_of_subset_halfPlane`,
  `tendsto_ofReal_one_add_sq_div_two`; `dist_sqEdgePt_add_one`.

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
error, a `simp` normal form in the orthogonality step), **seven minutes of wall time** after the stage-1 commit (07:57:02 to the
build's launch at 13:04:03, UTC, by the commit's timestamp and the build log's name); the cost of the save was the build's walk
(8m27s for two modules, 464 batches). **So the plan's prices for the pure leaves are high by well over an order of magnitude, not by
two to three.** The remaining five (priced 3 + 1 + 4 + 6 + 0.5 = 14.5 h) are re-priced at under half an hour together, and one build;
their proofs elaborated in scratch while this stage's build walked (§ 3). What the number measures: wall time to a proof that
elaborates under `lake env lean` with `autoImplicit` off, for leaves whose statements were already right and whose plans named the
route; it says nothing about leaves that need a statement changed, and there was none here.

Own count at this stage: about 230k (the harness's is not visible to me).

## Stage 3 — SAVED (FS131-I6A): the other five leaves, the models; `Pinch` has no `sorry`

### 3.1 The routes, and where they left the plan

- **`TwoColourOn.essBoundary_inter_eq`** — the plan's route (§ 9.4): `densityRatio_add_of_cover` (in an open set a.e. `A ∪ B` with
  `A ∩ B` null there, the two density ratios on a closed ball inside it sum to `1`), then one inclusion
  (`TwoColourOn.essBoundary_inter_subset`) twice, by `h.symm`.
- **`c11_discs`** — the plan's route: contacts to `essSupport`, `pinch`, and `IsSplitAt.hasTwoDiscsAt` (normal `x − y`; the far disc
  about `2x − y` misses the closed disc about `y`) for the two split cases, `hasTwoDiscsAt_comm` for the reversed one.
- **`c11_split`** — **changed**. The plan asked, per set, for two quarter-density bounds at a point of the circle. The statement has no
  measurability hypothesis on `A` or `B`, and needs none: within an open `N` the density ratios at a point of `N` read a set only up to
  a null set of `N` (`densityRatio_eventuallyEq_of_ae_eq_inter`), so `essBoundary A ∩ N = essBoundary S ∩ N` whenever
  `A ∩ N =ᵐ S ∩ N` (`essBoundary_inter_congr`). The split type says `A` is a disc and `B` the exterior of one within `N`; so the leaf
  is `essBoundary (ball y 1) = sphere y 1` and `essBoundary (closedBall y 1)ᶜ = sphere y 1`, two facts about explicit sets
  (`mem_essBoundary_of_balls` over wave 2's `upperDensityAt_pos_of_balls`, with the quarter-balls `r/2` towards and away from `y`).
- **`half_upperDensity`** — **changed**. The plan's "out" case needed the area of the strip between two tangent circles, through
  `Complex.volume_preserving_equiv_real_prod`, and its "in" case a null line. Neither is used. The piece lies behind the parabola
  `⟨z − x, ν⟩ ≤ |z − x|²/2` for a unit `ν` (`x − y` in the case "in", `y − x` in the case "out": the two pointwise lemmas above), so
  within `B̄(x, r)` behind the line at distance `r²`; translating by `−r² ν` puts that inside the open half of `B̄(x, r + r²)` behind
  `x`, and the reflection `z ↦ 2x − z` (`Measure.measurePreserving_sub_left`) shows an open half of a disc is at most half of it
  (`volume_halfPlane_inter_closedBall_le`: the half and its mirror image are disjoint, with no null set to discard). So
  `densityRatio P x r ≤ (1 + r)²/2` for every `r > 0`, in both cases, and the `limsup` is at most `1/2`. No rotation, no rectangle,
  no measurability of `P`.
- **`sq9_isTangentAt`** — the plan's shorter route (§ 9.4): `sqEdgePt + 1 ∈ sq9Sq 3 0`, `sqEdgePt − 1 ∈ sq9Sq (−2) 0`,
  `sq9Sq_subset_essClosure`, `essClosure_subset_essSupport`; the colours by `decide`.
- **The row's first clause, exported** (not a leaf of the skeleton): `half_sq_norm_le_inner_of_mem_closedBall` and
  `inner_le_half_sq_norm_of_notMem_ball` are "lies in a closed half-plane in every blow-up" before the blow-up, pointwise and with no
  set: FS111-M-C11 (ii)'s step "every `x″` lies outside both open discs at `x′`, so `|⟨x″ − x′, n(x′)⟩| ≤ |x″ − x′|²/2`"
  (`plans/FS111-M-regularity.md` § 3.2) is the second one applied to each disc.

### 3.2 The leaves against their rows (`data/fs131/k6/backlog-rows-w6.md`)

- Row 25, FS111-M-HALF, verbatim: "at a point x saturated for j, every path-connected piece of S̃_j with x in its closure lies in a
  closed half-plane in every blow-up at x, so has upper density at most 1/2 at x: no colour takes a reflex angle at a saturated point".
  `half_upperDensity`: `A` measurable with null unit pairs, a contact `y ∈ closure (densitySet A)` at distance `1` ("saturated for j"),
  `P` preconnected inside `densitySet A` ("path-connected piece of S̃_j": wider), conclusion `upperDensityAt P x ≤ 1/2`. "With x in its
  closure" is not read (if `x` is not in the closure the density is `0`). Read aloud: yes, the "so" clause; the first clause is
  `half_dichotomy` with the two pointwise lemmas.
- Row 27, FS111-M-C11, verbatim: "if M-PINCH's hypotheses hold at every essential boundary point in N, then ∂_e S_a ∩ N′ (N′ ⋐ N) is a
  C^{1,1} curve with curvature in [−1, 1] and unit-parallel partners on both sides; a single unit arc if any of its points is of the
  split type". `c11_discs`: at every point of the one `N` with a contact of each set, two tangent unit discs, one in each set within
  `N` — the planner's reading of "unit-parallel partners on both sides" (its § 9.2). `c11_split`: "a single unit arc if any of its
  points is of the split type" — `essBoundary A ∩ N = sphere y 1 ∩ N`, and the same for `B`. Read aloud: (i) and (iii), yes; the
  `C^{1,1}` curve is not claimed here.
- `TwoColourOn.essBoundary_inter_eq` has no row: it is the leaf under the planner's reading of the frozen (H2) (its § 9.1 item 2).
- `sq9_isTangentAt` has no row: it is `IsTangentAt`'s inhabitant, and the model's contacts.

### 3.3 What the proofs read (against the second planner's mutation audit, its § 9.2)

- `c11_split` reads `hN` (the audit: without it, false) and the two a.e. equalities of `IsSplitAt`. **It never reads `dist x y = 1`,
  nor the point `x`**: the conclusion is about `N`, `y` and the two sets. A generalization, reported: for any open `N` in which `A` is
  a.e. the open unit disc about `y` and `B` a.e. the complement of the closed one. It reads no measurability (the statement asks none).
- `TwoColourOn.essBoundary_inter_eq` reads `isOpen`, `cover`, `disj` and the two measurabilities — one per inclusion. **It never reads
  (H2)**: any two measurable sets that cover an open set almost everywhere and are almost disjoint there have one essential boundary in
  it. A generalization, reported.
- `c11_discs` reads everything, through `pinch`. `half_upperDensity` reads everything, through `half_dichotomy`; `P` is not asked to
  be measurable and is not.
- `pinch`: § 2.3 ((H2)'s openness and non-emptiness of `P` are never read).

### 3.4 The save

- **Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` — **OK — 464 of 464 batches, 2 modules
  rebuilt (`Pinch`, `Proofs`), 1 module with warnings**: `MapColouring.lean:194`, `declaration uses sorry` (the other implementer's
  `sat_inP`), 8m22s, exit 0 (`build/gate/build/20261006T131817Z-122361.log`; driver log
  `data/fs131/i6a/logs/build-2-all-leaves.log`). `Pinch`: no warning, no `sorry` (`grep -c sorry` reads 0).
- **Axioms** (this job's print): 37 records, 37 clean, each exactly the standard three; the planted `sorry` fired
  (`data/fs131/i6a/logs/axioms-2.out`). The block "FS131-I6A" of `scripts/Axioms.lean` lists the seven leaves, the 27 named helpers and
  the planner's three theorems the leaves freed (`pinch_interface`, `c11_discs_interface`, `TwoColourNhd.mem_essBoundary`, which no
  block listed while they rested on `sorry`).
- **Statement check** against `3928644b`: 19 base declarations, every statement identical, every base-proved body identical,
  `Basic.lean` and the module docstring byte-identical; the two allowed docstrings (`half_upperDensity`, `pinch`) changed by added
  lines only; 33 helpers (27 named, 6 `example`s); 0 `sorry`; 0 failures, exit 0 (`statements-2.out`).
- **The module's own negative controls** (`tools/fs131_i6a_plants.py`, on scratch copies outside the library; `plants.out`): the
  unplanted copy is green, and each of six plants is red — a false `example` (the file is elaborated, not skipped); the pinch model's
  contact moved to `sqEdgePt + 2`; the HALF model's bound sharpened to `1/3`; the split model's centre moved; `hasTwoDiscsAt_of_out_out`
  with `hdisj` replaced by `True`; `pinch_not_in_in` with `hcover` replaced by `True`.
- **Doubled names**: `scripts/slot.py --mem 10 --cpus 4 -- ./scripts/dupnames.sh` on this tree — OK, no name declared by two modules
  (`data/fs131/i6a/logs/dupnames.log`). Across branches, by `git grep` for `theorem <name>` on `origin/main` (`10753a6f`),
  `origin/fs131-w6` (`32f2ab4c`) and the wave's other branches (`fs131-w6c`, `-w6f`, `-w6g`, `-w6m`), 2026-10-06: none of the 27
  names is declared elsewhere. The join's own `dupnames` run is still the check that counts.

### 3.5 Slips and instruments, disclosed

1. **A tool defect of mine, found by its own false alarm.** `tools/fs131_i6a_statements.py` first keyed anonymous `example`s by their
   position in the file; the models added above the base's second `example` shifted it and the check reported "STATEMENT differs" for
   a statement nobody had touched. Repaired (an anonymous declaration is keyed by a hash of its statement), a sixth plant added
   (`example`), and all six plants re-run red (`statements-plant-*.out`). It failed loud, in the direction that costs a look, not in
   the one that passes a change.
2. **Two queued builds stopped by PID before they started**, to add the examples' docstrings and then the two pointwise lemmas while
   no build held the file: each was waiting on the slot ("ledger 80 + 40 > budget 90"), found by the log file it held open, signalled
   by PID, and confirmed gone by `ps`; each log ended `EXIT 143`. Forfeited: a place in the queue. The build of § 3.4 is the third
   launch and the only one that ran.
3. **The module docstring of `Pinch` is now behind the file**: it marks FALLSAT, HALF's dichotomy and EROSION-DIAM "**Proved.**" and
   says nothing of PINCH, C11 (i), (iii) and HALF's density clause, which are proved. My statement check holds the module docstring
   byte-identical, and the brief allows docstring lines for the models only, so I did not touch it: a correction owed at the join.

### 3.6 Expectations scored (§ 1.5)

All seven leaves closed in this job (registered 0.7). Neither leaf I named as likely to resist did: `half_upperDensity` and
`c11_split` each went through on a route that avoids the plan's hard part (§ 3.1); no leaf took a second route, and no companion skill
was needed. No statement defect among the seven (registered 0.15). Price: the plans' 22 agent-hours against **thirty minutes of wall
time** from the stage-1 commit (12:57:02 UTC) to the end of the final build (13:26:41 UTC) for the seven leaves, their 27 named helpers
and six models — seventeen of those minutes the two builds' walks (8m27s, 8m22s), and some of the rest two waits on the slot.

Own count at this stage: about 330k (the harness's is not visible to me).

## Drafts for the front page

*Keryx files; I edit none of these files. Each draft names its slot.*

1. **`CLAUDE.md` § The gate and § Trust ledger — no count drafted.** This job ran no gate (brief, Done means 4): the audit's and the
   vacuity scan's counts move at the wave's join, not here. What the join will see from this job: 37 more `#print axioms` records under
   CLEAN (the block "FS131-I6A"), no purchase, no import; in `Pinch`, 33 new declarations (27 named theorems, 6 `example`s), every
   theorem; of the skeleton's leaves, `pinch`, `half_upperDensity`, `c11_discs`, `TwoColourOn.essBoundary_inter_eq` and `c11_split` each
   have an `example` under "The models" that applies them to an inhabitant of all their hypotheses at once (`sq9` at `sqEdgePt`; for
   `c11_split` the disc and its exterior), and `pinch_not_in_in` concludes `False`, its docstring naming the model of the hypotheses it
   does not refute. The helpers are parametric in their sets and points and name no model of their own.
2. **`LEDGER.md` § B, three lines of row 140** (slot: the lines beginning `| FS111-M-PINCH |`, `| FS111-M-C11 |`, `| FS111-M-HALF |`;
   the last column, now "queued (FS-113)", "queued (FS-113)", "declined"), to be filed when wave 6's gate passes:
   - FS111-M-PINCH — **[kernel]**: `HadwigerNelson.Plane.pinch`, `pinch_not_in_in`, `pinch_interface`
     (`Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean`), on the standard three axioms, no assumption; at a wider class than filed
     (two measurable sets with null unit pairs on an open set; no colouring, no third class).
   - FS111-M-C11 — **clauses (i) and (iii) [kernel]**: `c11_discs`, `c11_discs_interface`, `c11_split`, on the standard three axioms,
     no assumption; **clause (ii), the `C^{1,1}` curve, stays [derived]** until FS131-E8-LOCAL's module lands.
   - FS111-M-HALF — **[kernel]**: `half_dichotomy`, `half_sq_norm_le_inner_of_mem_closedBall`,
     `inner_le_half_sq_norm_of_notMem_ball`, `half_upperDensity`, on the standard three axioms, no assumption; for one measurable set
     with null unit pairs (no colouring, no saturation beyond the one contact).
3. **`LEDGER.md` row 140's text** (slot: after "(FS111-M-PINCH, M-C11"): no change of content; its grade for the pinch, the two discs
   and the split arc becomes [kernel] with the wave's gate, the `C^{1,1}` clause staying [hand].
4. **`CLAUDE.md` § Frontier, "Open milestones"** — no line of its own: wave 6 is not closed by this job (the Ladder, the Fragment rows,
   the bridge and `sat_inP` are open on other branches). For the inventory: "FS131-I6A: `Plane/Saturated/Pinch` has no `sorry` on
   `fs131-w6p`".
5. **Proof Atlas** — grade changes to make when the wave's gate passes, none before: FS111-M-PINCH, FS111-M-HALF, FS111-M-C11 (i),
   (iii) from derived to kernel.
6. **`LEAN.md` § Searching — Lean**, two facts offered (slot: new bullets):
   - "The reflection `z ↦ g − z` preserves an invariant measure: `MeasureTheory.Measure.measurePreserving_sub_left` (the name is under
     `Measure`, not under `MeasureTheory`). With a translation it bounds a half-disc or a strip without rotating the plane: an open
     half of a disc and its mirror image are disjoint (FS131-I6A, `volume_halfPlane_inter_closedBall_le`)."
   - "For sets, `s ≤ᵐ[μ] t` is `∀ᵐ z, z ∈ s → z ∈ t`: prove it with `filter_upwards […] with z … hz`, or from an inclusion as
     `Eventually.of_forall fun z hz => h hz`; `Eventually.of_forall h` with `h : s ⊆ t` does not elaborate, and
     `HasSubset.Subset.eventuallyLE` is deprecated at the pin."
7. **`plans/GROKKING-INSTANCES.md` § What compute actually helps** (slot: a new instance under "re-price a kernel phase from its first
   two leaves"): "FS131-I6A, wave 6's `Pinch`: seven leaves priced at 22 agent-hours by two planners, who expected to be high by a
   factor of two to three; closed in thirty minutes of wall time after the readback, seventeen of them two build walks, the first two
     leaves in seven — high by a factor of about forty. (What it measures: leaves whose statements were right and whose plans named
     the route; wall time between a commit's timestamp and a build log's.)"
