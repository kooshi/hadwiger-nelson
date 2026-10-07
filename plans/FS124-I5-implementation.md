# FS-124 — the implementation of three arcs from a point: the twenty leaves of `Plane/ThreeArcs` (job FS124-I5)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I5-three-arcs.md` (on `main`). The module:
`Proofs/HadwigerNelson/Plane/ThreeArcs.lean`, on branch `fs124-wk3`, from the planner's tip `8cd74a6b`. The plan:
`plans/FS124-kernel-plan-3.md` (§ 4.3, the route per leaf). Working files: `data/fs124/i5/`. The record is written in
stages; each is committed before the next starts.*

## Theorems this phase proved

On branch `fs124-wk3` only (nothing here is on `main`, and the module has not been through the gate). Each **[kernel, on
a branch]**, all in `Proofs/HadwigerNelson/Plane/ThreeArcs.lean`, namespace `HadwigerNelson.Plane`; axioms as printed
from the built library (`data/fs124/i5/axioms.txt`, checked by `data/fs124/i5/axioms.py check`, with three controls
that fire): **`[propext, Classical.choice, Quot.sound]`** for every one but the three marked. No import, no declared
hypothesis, no `native_decide`.

The twenty leaves of the planner's skeleton (statements unchanged, as the elaborator stores them:
`data/fs124/i5/logs/statements.txt`):
1. `exists_arc_range_subset_inter` — an arc from a point has an initial part, an arc again, inside any neighbourhood
   of the point.
2. `IsTriod.range_subset_of_isPreconnected` — a preconnected subset of the three arcs that holds two far ends holds
   the whole arc to each.
3. `IsTriod.apply_one_eq_polarPt` — a far end is the rim point at its own argument.
4. `IsTriod.exists_rimOrder` — the three far ends have an order round the rim.
5. `IsTriod.notMem_iUnion_range_of_mem_Ioo` — a rim point strictly between consecutive far ends is on no arc.
6. `IsTriodCut.piece_subset_ball` — a piece lies in the open disc.
7. `IsTriodCut.disjoint_iUnion_range` — a piece misses the arcs.
8. `IsTriodCut.exists_unique_mem_closure` — a rim point off the far ends is in the closure of exactly one piece.
9. `IsTriodCut.closure_inter_closure_subset` — two pieces' closures meet on the arcs only.
10. `IsTriodCut.exists_forall_rimArc` — one piece all along an arc of the rim between far ends.
11. `IsTriodCut.ne_of_rimOrder` — the pieces at consecutive arcs of the rim are different (the crossing lemma).
12. `IsTriodCut.exists_rimPieces` — the pieces at the three arcs of the rim are three.
13. `IsTriodCut.closure_inter_nonempty` — every piece's closure meets the arcs.
14. `IsTriodCut.isPreconnected_closure_inter` — the part of the three arcs in one piece's closure is preconnected
    (the closed disc's unicoherence).
15. `IsTriodCut.rimPiece_spec` — the piece at an arc of the rim has the two arcs to its ends whole in its closure,
    and of the third arc the point `x` only.
16. **`IsTriodCut.exists_opposite` — the θ-lemma**: a bijection `opp` from arcs to pieces with each arc in the
    closure of the two pieces other than its opposite, and meeting the closure of its opposite at `x` only.
17. `IsTriodCut.exists_range_subset` — every two pieces share a whole arc.
18. `IsTriodCut.closure_inter_closure_inter_ball` — inside the disc the common boundary of two pieces is one arc.
19. `IsTriodCut.mem_closure` — the point is in the closure of every piece.
20. **`IsTriodCut.exists_arc`** — every two pieces share an arc from `x` inside any neighbourhood of `x` (the form
    `ThreePiece.IsSector.hasArcEdges` reads).

Ten helpers, new in this job: `polarPt_add_turn`; `fin_three_eq_or_of_ne` (**no axiom**), `exists_ne_ne_fin_three`
(**`[propext, Quot.sound]`**), `fin_three_add_one_ne` (**`[propext]`**); `IsTriod.polarPt_mem_sphere`;
`IsTriodCut.mem_diff_of_mem`, `IsTriodCut.exists_mem_piece`, `IsTriodCut.eq_of_mem_of_mem_closure`,
`IsTriodCut.closure_piece_subset_closedBall`, `IsTriodCut.disjoint_range_union_range`.

With the planner's 21, the module holds **51 theorems and no `sorry`**. **Not proved here, and not this job's**: the
leaf `ThreePiece.IsSector.hasArcEdges` (`Plane/SectorPoint`, another job's file — its two lines elaborate against this
module, Stage 4), and the model of `IsTriodCut`, `sectorPoint_isSector`, which is a `sorry` on this branch (Stage 4,
the read-aloud).

## Stage 1 — SAVED (FS124-I5): the readback and the build as given

**The quotations.** `data/fs124/i5/readback.py` (the planner's reader, copied unchanged but for its first line) on the
brief: **9 of 9 quotations found in their sources**, exit 0 (`data/fs124/i5/logs/readback.txt`); the control (one
letter of each quotation changed) finds none of the nine, exit 0 (`data/fs124/i5/logs/readback-control.txt`). No
mismatch.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the planner's record `plans/FS124-kernel-plan-3.md` (Stages 1–5); the module (513 lines: 41 theorems, 21
proved, 20 `sorry`); and the statements the route reads from outside it — `exists_inter_of_finite_closed_cover`
(`Plane/PlaneTopology`), `inter_nonempty_of_interleaved_radius` and `polarPt_ne_of_sub` (`Plane/ValidMap/MapTopology`),
`polarPt`, `norm_polarPt_sub` (`Plane/LocalStructure`), `e`, `e_add_two_pi` (`Plane/Basic`).

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from this
worktree at `8cd74a6b`: `EXIT 0`, "all 1854 modules already up to date, nothing built", **26 `declaration uses sorry`
warnings and no other** — 3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint`, 20 in `Plane/ThreeArcs`
(`data/fs124/i5/logs/build-as-given.log`).

**How I iterate.** `data/fs124/k3/lean1.sh` (`lake env lean` with the lakefile's two options and the docstring linter):
never evidence. Evidence is the build under the slot at each saved stage.

## Stage 2 — SAVED (FS124-I5): leaves 1–5

**Proved, by the planner's route each** (`plans/FS124-kernel-plan-3.md` § 4.3, rows 1–5):
`exists_arc_range_subset_inter`, `IsTriod.range_subset_of_isPreconnected`, `IsTriod.apply_one_eq_polarPt`,
`IsTriod.exists_rimOrder` (the sort: `Tuple.sort`, `Tuple.monotone_sort`), `IsTriod.notMem_iUnion_range_of_mem_Ioo`.
One helper, new: `IsTriod.polarPt_mem_sphere` (a point at radius `r` about `x` is on the rim; searched by shape —
`rg "polarPt.*(sphere|closedBall)"` over `Proofs/` — and held nowhere as a lemma).

**The build** (`data/fs124/i5/logs/build-1.log`): `EXIT 0`, 477 of 477 batches, 2 modules rebuilt (`Plane/ThreeArcs`,
`Proofs`), **21 `declaration uses sorry` warnings and no other** — the 6 as given and 15 in `Plane/ThreeArcs`.

**The statement check, built at this stage** (`data/fs124/i5/statements.sh`, with
`data/fs124/i5/lean/StatementDump.footer`): the planner's skeleton (`git show 8cd74a6b:…/ThreeArcs.lean`) and a
candidate file are each elaborated with a footer that prints every declaration's stored type and its hash; the check
passes iff every line of the skeleton's print is a line of the candidate's. It reads the statements as the elaborator
stored them, not as text (`LEAN.md` § Searching — Lean, on reading a leaf as the kernel has it). Its own check: each
of the 41 `theorem` names written in the skeleton must be in the skeleton's print. **Control**
(`data/fs124/i5/logs/statements-control.txt`): one hypothesis added to `IsTriodCut.mem_closure` in a copy — the check
exits 1 and names that theorem.

## Stage 3 — SAVED (FS124-I5): leaves 6–20 — the module holds no `sorry`

**Proved, in the order of § 4.3 (rows 6–20), each by the planner's route**: `IsTriodCut.piece_subset_ball`,
`disjoint_iUnion_range`, `exists_unique_mem_closure`, `closure_inter_closure_subset`, `exists_forall_rimArc`,
`ne_of_rimOrder`, `exists_rimPieces`, `closure_inter_nonempty`, `isPreconnected_closure_inter`, `rimPiece_spec`,
`exists_opposite` (**the θ-lemma**), `exists_range_subset`, `closure_inter_closure_inter_ball`, `mem_closure`,
`exists_arc`. No leaf failed an attempt on its route; no leaf is left `sorry`; no companion was dispatched to.

**Where a proof's shape differs from the plan's row** (the route is the same):
- row 14 (`isPreconnected_closure_inter`): the second closed set is `⋃ j : {j // j ≠ i}, (T ∪ closure (P j))` — a union
  over the two other pieces as a subtype — not the union over all `j` with an `if`; closed by
  `isClosed_iUnion_of_finite`, preconnected by `isPreconnected_iUnion` through `x`, each member by
  `IsPreconnected.union` at a point of `closure (P j) ∩ T` (row 13).
- row 16 (`exists_opposite`): `opp` is `Equiv.ofBijective` of the `if`-function, its bijectivity from surjectivity
  (`Finite.injective_iff_surjective`), which is three cases; the two conjuncts by nine and three cases.
- row 10: the midpoint's piece, then `exists_inter_of_finite_closed_cover` as planned; the uniqueness clause is proved
  first and the closed arc read from it.

**Nine more helpers** (ten with stage 2's), each under a name no other module declares (`rg` over `Proofs/` for each
name: no hit outside this module), each searched by its statement's shape first:
- `polarPt_add_turn` — `polarPt x r (φ + 2π) = polarPt x r φ`. **The same statement is held as `polarPt_add_two_pi`
  in `Plane/Saturated/FanBridge`, which is outside this module's import closure** (the planner's § 4.3 note); it is
  restated here under a name of its own (`LEAN.md` § Searching — Lean: a line that needs another line's lemma states
  it under its own name and says so). The landing may keep both or move one.
- `fin_three_eq_or_of_ne`, `exists_ne_ne_fin_three`, `fin_three_add_one_ne` — three facts of `Fin 3` by `decide`
  (the shape of the first is `RimOrder.eq_or`'s, without the order; `Topology/SpernerGrid` holds it for its own
  structure `Rainbow`, outside the closure).
- `IsTriodCut.mem_diff_of_mem`, `exists_mem_piece` — the fill clause read in each direction;
  `eq_of_mem_of_mem_closure` — a point of a piece is in no other piece's closure (Mathlib's
  `Disjoint.closure_right`); `closure_piece_subset_closedBall`; `disjoint_range_union_range`.

**An unused hypothesis, reported and not dropped** (the brief's § Done means, 3): `IsTriodCut.exists_range_subset`'s
`hij : i ≠ j` is not read by its proof — for `i = j` the statement says a piece's closure holds a whole arc, which is
true as well. The statement is unchanged; the proof holds `have _ := hij` with a comment, so that no linter reports
the binder.

**The statements are unchanged** (`data/fs124/i5/logs/statements.txt`): `statements.sh` on the module — the skeleton
prints 79 declarations (62 theorems to the kernel: the 41 written and the structures' fields), the module 89 (the ten
helpers more), and **every declaration of the skeleton is in the module with the same stored type**, exit 0.

**The build** (`data/fs124/i5/logs/build-2.log`): `EXIT 0`, 477 of 477 batches, 2 modules rebuilt (`Plane/ThreeArcs`,
`Proofs`), **6 `declaration uses sorry` warnings and no other** — the 6 as given (3 in `Plane/ClosePairModel`, 3 in
`Plane/SectorPoint`), **none in `Plane/ThreeArcs`**.

**The axioms, from the built library** (`data/fs124/i5/lean/Axioms.lean`, generated by `data/fs124/i5/axioms.py gen`
from the module's own `theorem` lines; the print: `data/fs124/i5/axioms.txt`; the verdict:
`data/fs124/i5/logs/axioms-verdict.txt`): **51 theorems written in the module, 51 printed on a subset of `[propext,
Classical.choice, Quot.sound]`**, exit 0. The module's last theorem:

> 'HadwigerNelson.Plane.IsTriodCut.exists_arc' depends on axioms: [propext, Classical.choice, Quot.sound]
> — source: data/fs124/i5/axioms.txt

**Controls, each watched to fire**: a theorem closed by `sorry` in the scratch file prints `sorryAx`; a theorem on a
planted axiom prints that axiom; and the checker run on the library as built at stage 2 (fifteen leaves open) exits 1
— it names the fifteen on `sorryAx` and the nine helpers not yet there
(`data/fs124/i5/logs/axioms-control-build1-verdict.txt`).

**A slip, disclosed**: the brief asks for a saved stage after every five leaves. Leaves 6–20 were written against a
working copy while the build of leaves 1–5 walked (nine minutes), all fifteen elaborated before it ended, and they
are saved here in one stage after one build, not three. Nothing was at risk meanwhile but the nine minutes of the
build: the working copy was on disk.

## Stage 4 — SAVED (FS124-I5): the closing checks, the read-aloud, the price

**The two lines of the planner's § 3.1, against the finished module** (`data/fs124/i5/lean/Bridge.lean`, the
planner's file copied; `data/fs124/i5/logs/bridge.txt`): both `example`s elaborate with no message — the data of an
`IsSector` is an `IsTriodCut` field for field, and `ThreePiece.IsSector.hasArcEdges` follows from
`IsTriodCut.exists_arc` in the two lines as written. The same file prints `IsTriodCut.exists_opposite` and
`IsTriodCut.exists_arc` on `[propext, Classical.choice, Quot.sound]` from the built library. `lake env lean`: an
iteration check, not a build; the consumer's file is not edited.

**`tools/check_architecture.py`**: `RESULT: PASS`, exit 0 (`data/fs124/i5/logs/check-architecture.txt`).
**`./scripts/dupnames.sh`** (under the slot, 16 GiB): "OK — no name is declared by two modules (23 generated on
demand)", exit 0 (`data/fs124/i5/logs/dupnames.txt`). Its `--self-test` was not run by this job. Beside it, by `rg`
over `main`'s tree and every worktree's `Proofs/`: none of the ten helper names is declared outside this module today.
**The environment linters** (`lake lint --no-build -- --no-build --trace`, under the slot; one item more than the
brief lists, read-only): exit 0, "Linting passed for Proofs", every linter `(2/2) Passed!`
(`data/fs124/i5/logs/lint.txt`). **Not run, as the brief says**: the full gate (`axioms.sh`, `assumptions.sh`,
`vacuity.sh`, their self-tests); no branch merged; `main` untouched.

### The read-aloud

The sentence: *"each of three arcs from the centre of a disc to its rim borders exactly two of the three complementary
regions, and every two regions share one"*.

> theorem exists_opposite (h : IsTriodCut x r J P) :
>     ∃ opp : Equiv.Perm (Fin 3), (∀ m i, i ≠ opp m → range (J m) ⊆ closure (P i)) ∧
>       ∀ m, closure (P (opp m)) ∩ range (J m) = {x} := by
> — source: Proofs/HadwigerNelson/Plane/ThreeArcs.lean

- *"three arcs from the centre of a disc to its rim"* — `IsTriod x r J` inside `IsTriodCut`: `0 < r`; each `J m`
  continuous and injective on `[0, 1]`; `J m 0 = x`; `dist (J m 1) x = r`; `dist (J m t) x < r` for `t ≠ 1`; two
  different arcs meet at `x` only. Nothing tame is asked of an arc.
- *"borders"* — `range (J m) ⊆ closure (P i)`: the **whole** arc is in the piece's closure; since a piece is open and
  misses the arcs (`disjoint_iUnion_range`), that is: the whole arc is in the piece's frontier.
- *"exactly two of the three"* — `Fin 3` has three elements and `opp m` is one: for the two others the arc is in the
  closure (first conjunct); for `opp m` the arc meets the closure **at `x` only** (second conjunct). That is stronger
  than "is not contained in the third closure", and it is the form the hand entries read (C136-PARTNERS, by the
  planner's § 3.4: "inside the disc an edge is one arc").
- *"and every two regions share one"* — `opp` is a bijection (`Equiv.Perm`): for two pieces `i ≠ j` the third piece
  `k` is `opp m` for one arc `m`, and that arc is in both closures. Stated by itself: `exists_range_subset`; and
  inside the disc the common boundary of `P i` and `P j` **is** that arc (`closure_inter_closure_inter_ball`).
- *"the three complementary regions"* — the hypothesis, not a conclusion: `P 0`, `P 1`, `P 2` open, preconnected,
  pairwise disjoint, with `⋃ i, P i = ball x r \ ⋃ m, range (J m)`.

> theorem exists_arc (h : IsTriodCut x r J P) {N : Set ℂ} (hN : N ∈ 𝓝 x) {i j : Fin 3} (hij : i ≠ j) :
>     ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = x ∧ range γ ⊆ closure (P i) ∩ closure (P j) ∩ N := by
> — source: Proofs/HadwigerNelson/Plane/ThreeArcs.lean

The second clause of the sentence, cut down to a neighbourhood: every two regions share an arc **from the centre**
(injective, continuous, starting at `x`) lying in both closures and inside any given neighbourhood `N` of `x` — an
initial part of the arc they share. Nothing more is said (not that the arc is the whole common boundary: that is
`closure_inter_closure_inter_ball`).

**Which half of the classical fact the hypotheses assume.** The classical θ-curve fact has two halves: (i) the disc
less the three arcs has **exactly three components**; (ii) each arc borders exactly two of them and every two share
one. **`IsTriodCut` assumes (i)** — in the form "three open preconnected pairwise disjoint sets fill the cut disc" —
**and the module proves (ii) from it.** That the cut disc has three components is proved nowhere here and used
nowhere. Two things that look like hypotheses are conclusions: no piece is empty, and `x` is in every piece's closure
(`mem_closure`); with them the three sets are the components of the cut disc.

**The model, and what the kernel holds of it.** By hand (one mind): `x = 0`, `r = 1`, the three radii `t ↦ t·e(2πm/3)`
and the three open sectors between them satisfy every clause — each sector convex (an angle of `2π/3`), open, the
three disjoint and filling the disc less the radii — and on it the conclusion reads as the picture: each radius is in
the closure of its two adjacent sectors and meets the opposite one's at `0` only. **In the kernel, on this branch:
nothing.** The planner names `sectorPoint_isSector` (`Plane/SectorPoint`) as the inhabitant; it is a `sorry` here,
another job's leaf. Until it is proved, `IsTriodCut`'s satisfiability rests on the hand model above.

### The price, as measured

| | planned (§ 4.3, Stage 5) | measured |
|---|---|---|
| leaves | 20 | 20 proved, 0 left |
| lines of proof, the 20 | about 420 | **310** |
| helpers | — | 10, in 17 lines of proof |
| the module | "near 600 lines of proof" | 489 lines of proof (162 the planner's 21, 310, 17); 855 lines of file (was 513) |
| attempts that failed on a route | — | none (three one-line repairs at elaboration: a lemma's name, a `linarith` that needed its bounds named, an implicit function in `subset_iUnion`) |
| builds under the slot | — | 3: as given (2 s, nothing to build), after leaves 1–5 (8 min 58 s), after leaves 6–20 (8 min 59 s) |

The module elaborates in about 3 s under `lake env lean`; the nine minutes of a build are the walk over 477 batches.

## Drafts for the front page

*None is applied by this job; each names its slot. The module is on a branch and has not been through the gate, so
no count of the gate is drafted as a number that holds on `main`.*

1. **`scripts/Axioms.lean`, the CLEAN section, a new block** — the file `data/fs124/i5/axioms-block.lean` (51 records,
   header and end line in the form of the FS124-I1 block), to be placed with the landing's other FS-124 blocks.
   **The count of records**: 51 more, every one CLEAN (48 on the standard three, `exists_ne_ne_fin_three` on
   `[propext, Quot.sound]`, `fin_three_add_one_ne` on `[propext]`, `fin_three_eq_or_of_ne` on none — the last is one
   more for the audit's axiom-free count).
2. **`CLAUDE.md` § Trust ledger and § The gate** — the audit's and the vacuity scan's counts are the landing's to
   read from its own run. What this module brings, for that reading: 51 clean records; no axiom, no declared
   hypothesis (nothing for `scripts/Assumptions.lean`; the nine counts do not move by it); no `VACUITY DECLARED`
   marker; the vacuity scan is expected silent on it (its hypotheses are predicates on maps and sets), so the landing
   names the model in words — `sectorPoint_isSector`, once the kernel holds it.
3. **`ARCHITECTURE.md`, the row for `Plane/ThreeArcs`** — the words "a skeleton on branch `fs124-wk3`" become "complete
   on branch `fs124-wk3` (51 theorems, no `sorry`; FS124-K3 planned, FS124-I5 proved)" until the landing, and at the
   landing drop the branch.
4. **`plans/FS124-derivation.md`, C124-FORCED, `uses only:`** — the planner's draft (`plans/FS124-kernel-plan-3.md`
   § 4.5, first item) is now due in its own words: its condition "once the 20 are closed" is met on the branch
   ([kernel, on a branch]; not through the gate).
5. **`CLAUDE.md` § Frontier, Paths forward, Open milestones, the sentence on FS-124's Lean modules** — after the
   words on its first module: "the plane topology under the sector point (`Plane/ThreeArcs`: for three pieces given
   as filling a disc cut by three arcs from its centre, each arc borders exactly two and every two share one —
   `IsTriodCut.exists_opposite`, from this library's unicoherence and crossing lemma, with no Jordan curve theorem)
   is complete on branch `fs124-wk3` (51 theorems; kernel-checked on a branch, not through the gate)".
6. **Ledger rows and the Proof Atlas** — this module regrades no ledger row by itself: it is the leaf under
   `ThreePiece.IsSector.hasArcEdges`, and the rows of FS-124 that read a sector point are regraded by the join that
   lands the sector module, not here. For the Atlas, one grade change when that join lands: the input of C124-FORCED
   cited as "the θ-curve form of the Jordan–Schoenflies theorem: recalled, not read" becomes [kernel] for the half
   used (the incidence, given the three pieces); the count of components stays unproved and unused.
7. **`LEAN.md` § Searching — Lean**, two lines beside the planner's (§ 4.5, second item):
   - "A filled skeleton's statements are compared with the skeleton's as the elaborator stores them: elaborate both
     with one footer that prints every declaration's type and its hash, and require each line of the skeleton's
     print in the module's (`data/fs124/i5/statements.sh`; its control adds a hypothesis in a copy and is named). A
     structure's `Prop` fields are theorems in that print: count the written theorems from the source (FS124-I5)."
   - "A module elaborates under `lake env lean` in seconds where a build walks nine minutes: later leaves are written
     against a copy under `data/` while a build walks, never in the module the walk will read; the copy goes over
     the module between builds (FS124-I5)."
