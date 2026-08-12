# M38 — The coarse-cell bound: dropping the coset hypothesis
# (SUBPLAN — §0 registered 2026-08-12, desktop, before any Lean)

*Under Kooshi's autonomy authorization (expiring 12:00 UTC 2026-08-12). Direct
continuation of M37, which closed the lattice-coset family at exactly seven and
whose closing grokking (G22) named the remaining gap precisely: the theorem needs
the colour map to be a HOMOMORPHISM, and "the gap between coset and arbitrary is
exactly where a six-colouring would have to live." This milestone removes that
hypothesis — in the coarse regime, completely.*

## The mission

**Drop the homomorphism.** Let the colouring be constant on the nearest-point
cells of the triangular lattice at scale `p` and otherwise ARBITRARY — the colour
of a cell is any label, with no algebraic relation between cells. Then for every
`p` in the coarse window the colouring still needs at least seven colours.

The reason is a change of viewpoint: with the coset hypothesis gone, the object
is the **constraint graph on the lattice** — join two addresses when their cells
contain a pair of points one unit apart — and the theorem is a statement about
that graph's clique. In the coarse regime the constraint set is exactly the first
three shells `Q ∈ {1, 3, 4}`, so the closed first shell is a **7-clique**, and
seven colours are forced with no algebra at all. That shell is M35's hex-shell K₇
and M37's rainbow, appearing a third time — now as a clique of a Cayley graph.

**Why it is a rung.** It converts M37's family bound into a *regime* statement:
above `p = 1/2` the cell-constant family is closed at seven, so **any
six-colouring of the plane must have colour classes finer than half the unit
distance in every lattice's cells** — the search space for `χ(ℝ²) ≤ 6` shrinks to
the fine regime, which is exactly where M36's §0l pixel probes were capped
undecided. Naming the boundary is the rung.

---

# §0 — Registered before any Lean run

## §0a — The derivation (worked by hand, committed before it is checked)

**C1 — The constraint condition.** Two addresses `u ≠ v` are *constrained* when
their cells contain a pair of points at distance exactly 1. Using only the
inscribed disc of radius `p/2` (M37's `nearestUnique_zero`), the pair
`addr u − σ·e`, `addr v + σ·e` along `e = addr (v − u)` realizes every distance
in `(‖d‖ − p, ‖d‖ + p)` where `d = v − u`. So `u, v` are constrained whenever
`|1/p − √(Q d)| < 1`.

**C2 — The coarse window.** For the three shell differences:
`Q = 1` gives `p > 1/2`; `Q = 3` gives `p ∈ (1/(√3+1), 1/(√3−1)) = (0.366, 1.366)`;
`Q = 4` gives `p ∈ (1/3, 1)`. **All three hold exactly on `p ∈ (1/2, 1)`** — and
`p > 1/2` is the binding one, from the nearest-neighbour shell. So on that window
the seven closed-shell addresses are pairwise constrained.

**C3 — The conclusion.** A cell-constant colouring assigns one label per address;
constrained addresses must differ; the shell is a 7-clique; hence at least seven
labels. No homomorphism, no ideal, no arithmetic — the Loeschian gap of M37 is
replaced by the clique, which is why the hypothesis can go.

**C4 — What it costs and what it does not cover.** Below `p = 1/2` the
nearest-neighbour constraint lapses (`(0, 2p) ∌ 1`) and the argument stops: at
fine scales the constraint graph is a thin annulus graph whose chromatic number
is the plane's own open question. That boundary is the finding, not a defect —
and it says where to look.

**C5 — Sharpness is inherited.** M37's `exists_proper_coset_colouring` is a
cell-constant colouring with seven colours at `p = 6/7 ∈ (1/2, 1)`, so the bound
is attained on the window and the coarse-cell chromatic number is exactly seven.

## §0b — Contracts

* `Coset.lean` gains a generalized sweep, `sweep_pair`, which PRODUCES the
  unit-distance pair from two addresses rather than deriving `False` from a
  kernel vector — the honest shape, of which M37's `collinear_sweep` becomes an
  instance. Modeling note: this is the M37 domain pass's D5 (one interface to the
  rounding) applied one level up; the experience pass is inherited unchanged
  (same module, same consumers), and the obligation pass's finding is recorded in
  §0c below.
* New theorems: `constrained_of_window` (C1/C2) and `seven_le_of_cell_constant`
  (C3), plus the exactly-seven corollary on the window.
* No instruments, no scripts, no SAT. `build/m38-design.py` re-derives the three
  window conditions in exact arithmetic as the independent check.

## §0c — Registered predictions

* **P1 [high]** — the three window conditions are exactly `p > 1/2`,
  `p ∈ (0.366, 1.366)`, `p ∈ (1/3, 1)`, so the binding window is `(1/2, 1)`.
* **P2 [high]** — `sweep_pair` subsumes `collinear_sweep` with no loss: M37's
  theorems re-derive from it unchanged.
* **P3 [medium-high]** — the whole milestone is ≤ 200 new lines and lands with
  axioms exactly `[propext, Classical.choice, Quot.sound]`.
* **P4 [medium]** — the obligation shape is 21 pairs handled uniformly by ONE
  lemma parametrized on `Q ∈ {1,3,4}`, not 21 cases; the shell's difference table
  is already a `decide`.
* **P5 [low]** — a bonus: the same argument at `Q = 7` shows the window's upper
  end is where the ideal's own vectors start being constrained, which is the
  M37 sharpness window seen from the constraint side. Recorded only if it falls
  out for free.

## §0d — Failure clauses

* If `sweep_pair` cannot be stated without duplicating M37's proof, keep
  `collinear_sweep` and add the pair version beside it, with the duplication
  named rather than hidden.
* If the window arithmetic needs `Real.sqrt 3` in an awkward place, state the
  conditions in squared form (`(1−p)² < p²·Q < (1+p)²`) — radical-free, as M37's
  gap lemma already is.
* Any segfault: HALT and report to Kooshi (standing).


---

# §R — Results (2026-08-12; every verdict at face value)

* **P1 CONFIRMED exactly** (`build/m38-design.py`, exact rationals): the three
  shell-difference windows are `Q = 1 → p > 1/2`, `Q = 3 → (0.366, 1.366)`,
  `Q = 4 → (1/3, 1)`, intersecting in **exactly `(1/2, 1)`**, binding at the
  nearest-neighbour shell; the radical-free form `(1−p)² < p²Q < (1+p)²` agrees
  with the radical form on all 5,997 probed rows; the shell's 21 difference
  norms are `{1, 3, 4}`; and the planted red fires — at `p = 1/2` and below, the
  `Q = 1` offset is NOT constrained, which is exactly why the window closes
  there.
* **P2 CONFIRMED** — `exists_unit_pair` (two addresses and a direction produce an
  actual unit-distance pair, one point in each cell, with no mention of colour)
  subsumes M37's `sweep_exact` with no loss; the M37 theorems re-derive from it
  unchanged.
* **P3 CONFIRMED** — the milestone is ~140 new lines; axioms exactly
  `[propext, Classical.choice, Quot.sound]`; build green, lint silent, zero
  `sorry`, 463 clean.
* **P4 CONFIRMED** — the 21 pairs are handled by ONE lemma
  (`exists_unit_pair_of_window`) plus the three-case norm table, not 21 cases.
* **P5 — not pursued** (it was the low-priority bonus); the constraint-side
  reading of the M37 sharpness window is recorded in the plan and not
  formalized.

**What landed**: `seven_labels_of_cell_constant` and
`seven_le_card_of_cell_constant` — for `1/2 < p < 1`, ANY colouring constant on
the lattice's nearest-point cells, with no algebraic relation between the
labels, gives the seven closed-shell addresses seven distinct labels — and
`cell_chromatic_eq_seven`, which pairs that with M37's witness at `p = 6/7`.

## What was NOT done (honesty ledger)

* **The fine regime is untouched, and that is the point.** Below `p = 1/2` the
  argument stops because the nearest-neighbour offset stops being constrained;
  the constraint graph there is a thin annulus graph on a fine lattice, whose
  chromatic number is the plane's own open question. Nothing here bounds it.
* Only the triangular lattice, as in M37. The general-lattice case is priced in
  M37's ledger and unchanged.
* The window's endpoints are not claimed sharp as a statement about colourings —
  `p ≤ 1/2` means *this argument* stops, not that a cheaper colouring exists.
