# FS131-IM — wave 4's three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) in `Plane/ValidMap/Moves`

*The record of FS131-IM1 (de Bruijn, the implementer, on Opus), branch `fs131-w4m` from `fs131-w4c` at `d4f946ae`, in the worktree
`.claude/worktrees/fs131-w4m`. Brief: `data/fs131/briefs/FS131-IM1-moves.md` (on `main`). Report: `data/fs131/reports/FS131-IM1.md`.*

## Theorems this phase proved

Kernel-checked in this job's build (`build/gate/build/20261004T220917Z-2800792.log`), axioms printed against that build's oleans
(`data/fs131/im/axioms-stage3.txt`), all in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`:

- `HadwigerNelson.Plane.e_sub_e_two_mul` — [kernel], `[propext, Classical.choice, Quot.sound]`
- `HadwigerNelson.Plane.branchPt_eq_circle` — [kernel], the standard three
- `HadwigerNelson.Plane.abs_half_le_one` — [kernel], the standard three
- `HadwigerNelson.Plane.carrier_germArc` — [kernel], the standard three
- `HadwigerNelson.Plane.germArc_nondegenerate` — [kernel], the standard three
- `HadwigerNelson.Plane.germArc_isUnitArc_iff` — [kernel], the standard three
- `HadwigerNelson.Plane.ArcMap.isClear_of_mem_closure` — [kernel], the standard three

None of the three moves is proved: `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux` read `sorryAx` besides the standard three.

## Stage 1 — SAVED: the readback, the as-given build, what I may and may not change

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation checked against its source by reading the source at the address given (the quotations are prefixes of the source text, cut
with `…`):

| quotation | source | result |
|---|---|---|
| "236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (…) to a parallel implementer in a" | `plans/FS131-close-inventory.md` l. 1692 (on `main`) | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | **verbatim** |
| "3. **`exists_shave`** (H, about a session). `F′ = F` plus two arcs — the branch of curvature `σ` from `v` to radius `ρ` (`Arc.circ` with explicit" | `.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md` § Stage 2, item 3 | **verbatim** |
| "4. **`exists_rayMerge`, `exists_merge`** (H each, a session each). **The plan's claim (§ 13.1 engine 3: "the moves of Contact add arcs and recolour; they" | the same, item 4 | **verbatim** |
| "- **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc" | `fs131-w4`'s kernel plan § 14.5 | **verbatim** |
| "223. **Engine 2 written once** (item 218 (g)): FS131-I4i wrote `ringArcsWithin_of_Γ_subset` in `Plane/ValidMap/Basic` on `fs131-w4` (`3f7ea033`, Basic.lean only," | `plans/FS131-close-inventory.md` l. 1596 | **verbatim** |

The paraphrase after the IC quotations ("SHAVE adds two arcs from `v`; the merges each need **a cut at `v`** …; `exists_shave` keeps its statement though it
does not assume `g ≠ c` or `h ≠ c`, so the case `g = c`, `σ < κ₂` needs the same cut") matches IC's items 3–4 in substance.

**One small difference, not a defect:** ruling 236 says `Moves` imports "`Basic`, `Sectors`, `SVMap`"; the brief says "what `Contact` imports — `Plane/ValidMap/Basic`,
`Plane/Tiles`, `Plane/SVMap`". `SVMap` imports `Sectors`, so importing `Contact`'s three satisfies both; I follow the brief.

The three statements are at `Contact.lean` l. 4019 (`exists_shave`), 4033 (`exists_rayMerge`), 4049 (`exists_merge`) at `d4f946ae` — checked.

### 1.2 What I may and may not change

**May** (brief § What is yours to decide; kernel plan § 14.2): add children in the new module `Plane/ValidMap/Moves` or, statements unchanged, in
`Plane/ValidMap/Basic`; bring engine 2's exact hunk (`3f7ea033`) into `Basic`; edit `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (my own block,
headed "FS131-IM1"), this record, `tools/fs131_im_*.py`, `data/fs131/im/`, `data/fs131/reports/FS131-IM1.md`.

**May not**: change any statement of the three moves (they are copied by script, hypotheses, binders and conclusion verbatim, as `…_aux`); change any
definition of `Plane/ValidMap/Basic`; edit `Contact.lean` (FS131-IC4's) or wave 4's other modules (`BaseSteps`, `UnitArc`, `Sectors`, `SVMap`, `StuckChain`);
add an `axiom` or use `native_decide`; merge into `fs131-w4c` or `fs131-w4`; run wave 4's gate; push to `main`; start agents. A move that cannot be proved as
written is a message to Keryx with the declaration, the reason and the smallest counterexample or missing hypothesis; a `Contact` lemma a move needs is a
message too (that lemma then moves to `Moves`, by Keryx), never a copy.

### 1.3 The branch builds as given

`d4f946ae`, built under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, 444 of 444 batches, 4 modules
rebuilt (the worktree's `.lake/build` is a copy from `fs131-w5b`), warnings only `declaration uses 'sorry'`, in `BaseSteps`, `UnitArc` and `Contact` (its four
leaves: the three moves and `stuck_structure`). Log `build/gate/build/20261004T214859Z-2681059.log`; the run's terminal output `data/fs131/im/build-asgiven.log`.

## Stage 2 — SAVED: engine 2, the block moved to `Cone`, `Moves` created with the three statements

### 2.1 Engine 2

`git diff 3f7ea033~1 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean | git apply` applied cleanly (112 lines: `mem_closure_ringArc_diff_finite`,
`ringArc_subset_Γ_of_finite`, `ringArcsWithin_of_Γ_subset`, `segPlane` and its spec example). Checked: `git diff 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean`
is empty, so `Basic` on this branch is byte-identical to `Basic` at `3f7ea033` and the copies meet without conflict at the merge. (The hunk has no
`condition5_of_ringArcsWithin`; the moves' Condition-5 clause will be proved per move, from the cut arcs lying in old carriers and the new arcs not being unit
arcs, `Arc.finite_inter_sphere_or_eq_circ`.)

### 2.2 The block moved to `Plane/ValidMap/Cone` (inventory items 253–254, the amendment of the brief)

`tools/fs131_im_move_cone.py --write` generated `Cone.lean` and the trimmed `Contact.lean` from `git show d4f946ae:…/Contact.lean`; `--check` passes:

- the head block, ruled as "l. 27–1030", is **l. 26–1056** at `d4f946ae`: l. 27 is `frameX_add_smul`'s first line and its docstring is l. 26; l. 1030 falls
  inside `mem_coneAt_hornSet` (l. 1026–1056), so the range is rounded out to whole declarations — 1031 lines, from `frameX_add_smul` to `mem_coneAt_hornSet`,
  including the N3-CONF section's `namespace ArcMap … end ArcMap` (l. 425–680);
- `hornSet_mono_radius` (l. 1716–1718, top level), `not_mem_interiorPts_of_mem_closure_sector` (l. 1373–1386) and `IsSector.eq_of_mem` (l. 2627–2632), the
  latter two placed in `namespace ArcMap` with `Contact`'s `variable {k : ℕ} {F : ArcMap k}`;
- each range found verbatim, in order, in `Cone.lean`; `Contact.lean` equals `d4f946ae`'s minus exactly those ranges (each with its trailing blank line)
  plus the one line `import Proofs.HadwigerNelson.Plane.ValidMap.Cone`.

**Negative control, watched**: changing `(h : κ ≤ κ')` to `(h : κ < κ')` in `Cone.lean`'s `tanHeight_anti` made `--check` exit 1 naming the head block and
the regenerated text (`data/fs131/im/move-control.txt`); `--write` restored it and `--check` passed again.

`Cone` imports `Contact`'s three (`Plane/ValidMap/Basic`, `Plane/Tiles`, `Plane/SVMap`); `Contact` and `Moves` import `Cone`. `Proofs.lean` gains `Cone` and
`Moves`; `ARCHITECTURE.md` gains their rows and `Cone` in `Contact`'s Imports cell; `tools/check_architecture.py`: PASS (209 rows, 0 import mismatches).
`tools/fs131_k4_decls.py --check`: exit 0 (its two "missing" names are the `_root_`-prefixed `BranchGerms.frameY_lt_of_mem`/`lt_frameY_of_mem` of `Contact`,
a parse of the tool's that predates this job, not a moved declaration).

### 2.3 `Moves` and the three statements

`tools/fs131_im_statements.py --print` extracted each statement from `Contact` at `d4f946ae` (from `theorem <name>` to the `:= by` ending its last line) and
renamed it `…_aux`; `Moves.lean` holds the three with `sorry`. `--check` compares each `…_aux` statement with `Contact`'s, after the name: **the diff is
empty for all three** (8, 7 and 6 lines). **Negative control, watched**: planting `(h2 : κ₂ < 1)` for `(h2 : κ₂ ≤ 1)` in `exists_shave_aux` made `--check`
exit 1 with the one-line diff (`data/fs131/im/statements-control.txt`); restored, it passes. `scripts/Axioms.lean` gains the block "FS-131 wave 4, `Moves`
(job FS131-IM1)" with the three `…_aux` records.

### 2.4 The build of stages 2–3

Under the slot, as in § 1.3: **OK**, 445 of 445 batches, 10 modules rebuilt (`Basic`, `StuckChain`, `Sectors`, `SVMap`, `Cone`, `Moves`, `UnitArc`, `Contact`,
`BaseSteps`, `Proofs`); `Cone` with no warning; `Moves` with exactly three, `declaration uses 'sorry'` at the three `…_aux`; `Contact` with its same four
leaves (`exists_shave`, `exists_rayMerge`, `exists_merge`, `stuck_structure`); no other warning. Log `build/gate/build/20261004T220917Z-2800792.log`; terminal
output `data/fs131/im/build-stage2.log`.

## Stage 3 — SAVED: the germ arc and clearness at limits proved; the plan for the three moves (my reading, for whoever proves them; no statement changes)

**Proved here** (in `Moves`, sorry-free, the standard three axioms): `germArc v β κ ρ`, the arc whose carrier is the branch `branchPt v β κ '' [0, ρ]`
(`carrier_germArc`; via `branchPt_eq_circle`, a branch point as a point of its circle, and `e_sub_e_two_mul`), non-degenerate for `ρ > 0`
(`germArc_nondegenerate`), a unit arc iff `|κ| = 1` (`germArc_isUnitArc_iff`), with a spec example (the curvature-`1` germ is a unit arc and holds its branch
point, the straight one is not); and `isClear_of_mem_closure` (a limit of points clear for `c` is clear for `c`). Both are children every move needs: the
σ-arc and the cut's re-added branches are germ arcs, and a cut branch is clear because the recoloured region beside it is. **Re-pricing from them**: the germ
arc took about 15k tokens of work (one elaboration round of fixes); the surgery as a whole is larger than IC1's "about a session each" — see § 3.5.

### 3.1 One surgery, three instances

Every move builds `F'` with `F'.dom = F.dom`, `F'.col = F.col` off the recoloured region `R ⊆ B(v, ρ)`, and
`F'.arcs = {a ∈ F.arcs | a.carrier ∩ B̄(v, ρ) = ∅} ∪ ⋃_{a meets B̄(v,ρ)} outer(a) ∪ {germArc v (β i) (κ i) ρ | i kept} ∪ A_new`:

- **`germArc v β κ ρ`** (proved in `Moves` at this stage) is the arc whose
  carrier is exactly the branch `branchPt v β κ '' [0, ρ]` (`carrier_germArc`, `|κ| ρ ≤ 2`): a segment for `κ = 0`, an arc of the circle of radius `1/|κ|`
  about `v + n/κ` otherwise; non-degenerate for `ρ > 0`; a unit arc iff `|κ| = 1` (`germArc_isUnitArc_iff`). It serves twice: the new σ-arc of SHAVE is
  `germArc v α σ ρ`, and **the cut re-adds the kept chart branches as germ arcs** instead of matching each old arc to the germs it carries (an old arc may carry
  zero, one or two branches at `v`, and several arcs may carry one branch; the chart's `branches` field, `(F.Γ ∩ B(v, r₀)) ∖ {v} = ⋃ᵢ branchᵢ`, describes the
  union, which is all the sector count reads).
- **`outer(a)`**, for an old arc through `v` (all arcs meeting `B̄(v, ρ)` pass through `v` below a `GoodAt` radius), is `a.carrier ∖ B(v, ρ)` as at most four
  arcs: split `a` at `v`'s parameter into its two sides; on a side `[θ_v, θ₁]` of a circle of radius `R > ρ/2` the outer part is `[θ_v + δ, min(θ₁, θ_v + 2π − δ)]`,
  `δ = 2 arcsin(ρ/2R)` (because `‖e θ − e θ_v‖ = 2 sin((θ − θ_v)/2)` on `[0, 2π]`), and the mirror on `[θ₀, θ_v]`; on a segment side `[v, w]`, `[v + ρ(w − v)/|w − v|, w]`.
  No far-end or full-circle case analysis is needed for the carrier identity; non-degeneracy needs only that no end of a nearby arc lies on `∂B(v, ρ)` —
  finitely many ends, so true for all but finitely many `ρ` (choose `ρ` by `Filter.Eventually`).
- **Engines**: validity by engine 1 (`Valid.of_agreesOff`) — `R`'s clearness, plus "no unit pair of one colour inside `R`" (`R ⊆ B(v, ρ)`, `ρ < 1/2`);
  `RingArcsWithin` by engine 2 with `A' = A_new` (the cut arcs' carriers lie in old carriers, so in `F.Γ`); Condition 5 per arc (cut arcs: subsets of old
  carriers; new arcs: radius `ρ < 1` or `1/|σ|` with `|σ| < 1`, so `Arc.finite_inter_sphere_or_eq_circ`).
- **The sector count** by `isSector_iff_of_partition` (`Sectors`) at every `r < ρ`, `r ≤ r₀`: `F'.interiorPts ∩ B(v, r)` is the untouched chart sectors plus the
  new pieces; count the `c`-coloured ones (each chart sector has one colour, `IsSectorChart.exists_col`).
- **Rim colours** (`∀ x ∈ ∂B(v, ρ), (F'.coloursAt x).ncard ≤ 3`): put the whole circle `circ v ρ 0 2π` in `A_new` for SHAVE and RAY (not a unit arc; it
  changes no sector at radius `r < ρ`); then `F'.coloursAt x ⊆ F.coloursAt x ∪ {colours of R near x}`, and a point of the punctured chart ball carries at most
  two colours of `F` (a child to prove from the chart's polar description: near a point at distance `ρ` and direction `dirᵢ(ρ)` only sectors `i − 1` and `i`
  meet, the germ directions at distance `ρ` being strictly increasing). For MERGE the full circle is **wrong** — a rim point with one colour on both sides
  would carry a repeated colour, against its `¬ HasRepeatedColour` clause — so MERGE's rim arcs lie exactly where the colour changes.

### 3.2 SHAVE (`exists_shave_aux`): the cases the statement leaves open

The statement assumes neither `g ≠ c` nor `h ≠ c` (IC1's finding). Recolour the tip `H_ρ = hornSet v α κ₁ κ₂ ρ` by `col'(z) = g` above `σ`, `h` otherwise,
in every case; then:

| case | new arcs | cut | the new pieces at radius `r` | `c`-count |
|---|---|---|---|---|
| `g ≠ c`, `h ≠ c` | σ-arc iff `κ₁ < σ < κ₂` and `g ≠ h`; rim circle | none | `U_r` (colour `g`), `L_r` (colour `h`), the empty one dropped; one piece `H_r` if `g = h` | `n + 1 − 1` |
| `g = c` (any `h`) | σ-arc iff `κ₁ < σ < κ₂` and `h ≠ c`; rim circle | the `κ₂`-branch | `S_g ∪ branch ∪ U_r` (colour `c`), `L_r` (colour `h`) — or `S_g ∪ branch ∪ H_r` when `h = c` or `σ = κ₁` | `n + 1 − 2 + 1` |
| `g ≠ c`, `h = c` | σ-arc iff `κ₁ < σ < κ₂`; rim circle | the `κ₁`-branch | `U_r` (colour `g`), `L_r ∪ branch ∪ S_h` (colour `c`) | `n + 1 − 2 + 1` |

(`S_g`, `S_h`: the chart sectors holding the flank bands `hornSet v α κ₂ κ' r ⊆ F.region g`, `hornSet v α κ'' κ₁ r ⊆ F.region h`; `S_g ≠ H` since the band lies
above `κ₂`.) With `g = h = c` the σ-arc must **not** be added (it would leave `L_r` a separate `c`-sector). Openness of the merged piece at the cut branch is
explicit, without the chart: near a point of the `κ₂`-branch every point lies in `H`, on the `κ₂`-circle, or in the flank band. Clearness of the cut branch's
points for `c` follows from `R`'s clearness by openness of `F.region c` (a unit circle through a branch point meets a ball in `F.region c`; nearby horn points
then see it too). The chart facts SHAVE reads — the horn's chart index with both germs (`IsHorn.exists_chart_index`, `IsSectorChart.index_of_isSector_hornSet`),
a sector's single colour (`IsSectorChart.exists_col`), a flank's chart sector (`IsSectorChart.exists_flank_after`/`_before`) — are in `Contact` (l. 2252–2633 at
`d4f946ae`), **not** in the moved block: a second, smaller move upstream is needed before SHAVE's sector count can cite them (their Contact-local dependencies
should be computed by a parse of the proofs, not of the docstrings; my token scan over-approximated through docstring mentions).

### 3.3 RAY (`exists_rayMerge_aux`)

**Clearness** (the first conjunct), by an exact argument that replaces N4-RAY's "follow the circle until it exits": for `t` between the horns and `y ∈ F.region c`
with `dist t y = 1`, each horn, being a preconnected subset of `F.region c` in a valid map, lies wholly inside `B(y, 1)` or wholly outside `B̄(y, 1)`.
*Both inside*: on the vertical line through `t` (frame `x = x_t`) `u ↦ |z(u) − y|² − 1` is a convex quadratic, negative at points of both horns below and above
`t`, so negative at `t`: contradiction. *One inside, one outside*: `v` is in both closures, so `|v − y| = 1`; for horn points `|z − y|² − 1 = −2x·y_x + O(x²)`,
so `y_x = 0`, `y ∈ {N, S′}`, and both horns lie outside `B(N, 1)` (curvatures `≤ 1`) and outside `B(S′, 1)` (curvatures `≥ −1`): contradiction. *Both outside*:
the disc `B̄(y, 1) ∋ t` contains the lens `{t + w : |w|² ≤ 2 w·u}`, `u = y − t`; if `|u_y| ≥ 1/2` it holds a vertical segment of length `≥ 1` from `t`, reaching the
horn above or below; if `|u_x| ≥ √3/2` it holds vertical segments of half-length `≍ s` at `x = x_t ± s`, wider than the stack (`≍ x²`) once `x_t` is small:
contradiction. All three are exact frame algebra (`tanHeight`, `sq_dist_frame`).
**The merge**: recolouring the whole gap merges `H₁`, `H₂` *and every `c`-sector between them*, so the count is `n − m` with `m` such sectors; the right
construction merges `H₁` with the **nearest** `c`-horn above it (between `κ₂` and `κ₃`, or `H₂`), cutting every chart branch of direction `α` with curvature
in `[κ₂, κ_a]` and recolouring `hornSet v α κ₂ κ_a ρ` with `c` (clear by the first conjunct, a subset).

### 3.4 MERGE (`exists_merge_aux`)

Choose two `c`-sectors consecutive along `D_c(v)`'s arc of directions with the gap between them inside `D_c(v)` (the `c`-sectors' cones lie in `D_c(v)`,
`coneAt_subset_allowedCone`); cut every chart branch strictly inside the gap and the two bounding branches; recolour the gap's sectors in `B(v, ρ)` with `c`;
rim arcs only across the recoloured sectors. Clearness: N3-CLEAR (`clear_of_subset_interior_allowedCone`) at the gap's directions interior to `D_c(v)`, N3-UP
(`lens_dist_lt_one_of_up`, `lune_dist_le_of_up`) at a cusp end on `∂D_c(v)` — all now in `Cone`. The clauses MERGE adds over SHAVE (no point off the rim gains a
colour; the rim's new points carry at most three colours and none repeated; `D_c(v′)` unchanged off `B̄(v, ρ)`) each need their own child; the last is FS110's
"`cl R ∩ ω(v′) ⊆ {v}`" argument.

### 3.5 The handover: what is proved, what is left, the price

**Proved**: the seven children listed under "Theorems this phase proved"; engine 2 brought over byte-identical; the `Cone` block moved and checked; the three
statements in `Moves`, checked identical to `Contact`'s. **Left**: all three moves — `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux` each still
`sorry`; nothing in `Contact` changed beyond the ruled deletion and the import line.

**What SHAVE needs next, in order** (each a stated child; § 3.1–3.2 give the routes): (1) `outer(a)` — an old arc through `v` minus the open ball, as at most
four non-degenerate arcs in its carrier; (2) the surgery map and its `AgreesOff`, local finiteness and local constancy, over a `GoodAt` radius with no arc end
on the rim; (3) "a point of the punctured chart ball carries at most two colours"; (4) the second move upstream of `Contact`'s chart lemmas (§ 3.2's list), or
their re-derivation in `Moves` if Keryx so rules; (5) SHAVE's three cases over (1)–(4). RAY adds its clearness (§ 3.3, exact frame algebra, three cases) and
the multi-branch cut; MERGE adds the gap's choice and the rim and `D_c(v′)` clauses.

**Re-pricing** (standing order, from the first leaves): the germ arc, one of about a dozen children of comparable size SHAVE needs, took about 15k tokens of
work; with (1)–(5) SHAVE is about three of my sessions, RAY two more over SHAVE's machinery, MERGE two to three — against IC1's "about a session each". The
surgery engine ((1), (2), the counting partition) is shared and is most of SHAVE's cost; RAY and MERGE are cheaper once it stands.

## Stage 4 — SAVED: FS131-IM2's readback, the as-given build

*FS131-IM2 (de Bruijn, the implementer, on Opus) resumes this record at Stage 4 (standing rule 2): the last SAVED stage is 3, committed in
`8d075e9c` and reported in `dbedaf97` (`git log -- plans/FS131-IM-implementation.md`). Brief: `data/fs131/briefs/FS131-IM2-moves.md` (on `main`).
Report: `data/fs131/reports/FS131-IM2.md`.*

### 4.1 The brief's quotations against their sources (standing rule 3)

| quotation (a prefix, cut with `…`) | source | result |
|---|---|---|
| "236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (…) to a parallel implementer in a" | `plans/FS131-close-inventory.md` l. 1692 (on `main`) | **verbatim** |
| "262. **Corrections, slips and a tool defect from IM1's report.** (a) **Correction owed — N4-RAY's route**: recolouring the whole gap merges every `c`-sector" | the same, l. 1884 | **verbatim** |
| "263. **Ruling: the second move is a prefix move, into `Cone`, by IM1's successor on `fs131-w4m`.** Choice: FS131-IM2 moves **every declaration of `Contact` from" | the same, l. 1893 | **verbatim** |
| "Every move builds `F'` with `F'.dom = F.dom`, `F'.col = F.col` off the recoloured region `R ⊆ B(v, ρ)`, and" | this record § 3.1 | **verbatim** |
| "**Proved**: the seven children listed under "Theorems this phase proved"; engine 2 brought over byte-identical; the `Cone` block moved and checked; the three" | this record § 3.5 | **verbatim** |
| "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the" | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.2 | **verbatim** |
| "- **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc" | the same, § 14.5 | **verbatim** |

**One wording difference, not a defect**: ruling 263 says "the single lemma already moved stays moved"; **two** of IM1's three single lemmas lie inside
d4f946ae's l. 1057–2593 — `not_mem_interiorPts_of_mem_closure_sector` (l. 1373–1386) and `hornSet_mono_radius` (l. 1716–1718); the third,
`IsSector.eq_of_mem` (l. 2627–2632), lies below the range. Both stay where IM1 put them in `Cone`; the second move is the range minus those two holes.

The brief's state is as stated: branch head `dbedaf97`, tree clean, Lean sources at `8d075e9c`'s state.

### 4.2 The branch builds as given

`dbedaf97`, under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`): **OK**, all 1746 modules already up to date,
nothing built; warnings only `declaration uses 'sorry'` — `BaseSteps` 7, `UnitArc` 17, `Contact` 4 (the three moves and `stuck_structure`), `Moves` 3 (the three
`…_aux`). Log `build/gate/build/20261004T222624Z-2921733.log`; terminal output `data/fs131/im/build-im2-asgiven.log`.

## Stage 5 — SAVED: the second move (item 263), into `Cone`

**The range, by declarations** (inventory item 262 (c)'s lesson): from `e_eq_of_mem_coneAt_hornSet` (its docstring, d4f946ae's l. 1058) through
`IsSectorChart.index_of_isSector_hornSet` (its last line, l. 2592) — the ruling's "l. 1057–2593" with the blank line on each side. It holds the
module-doc headings and the `namespace ArcMap`/`variable` lines between (N3-DEG l. 1139–1635, N4-FLANK's mechanism l. 1637–2247, a horn's chart sector
and its flanks from l. 2249), minus the two single lemmas of the first move that lie inside it (`not_mem_interiorPts_of_mem_closure_sector`, l. 1373–1386;
`hornSet_mono_radius`, l. 1716–1718; each with its trailing blank line), which stay where IM1 put them. The range ends inside the `namespace ArcMap`
opened at l. 2322, so `Cone` closes it after the range, and `Contact` reopens `namespace ArcMap` and `variable {k : ℕ} {F : ArcMap k}` before
`woodallCone_isHorn`'s docstring (l. 2594).

**The tool**: `tools/fs131_im_move_cone.py` extended (`RANGE2`, `HOLES`, `REOPEN`); `--write` generated `Cone.lean` (2607 lines; its module doc now
names both moves) and the trimmed `Contact.lean` (1644 lines) from `git show d4f946ae:…/Contact.lean`; `--check` passes: every first-move range and the
second move's three pieces (l. 1058–1372, 1388–1715, 1720–2592) found verbatim, in order, in `Cone`; `Cone` equal to the regenerated text; `Contact` equal
to d4f946ae's minus exactly the moved ranges (with their trailing blank lines), plus the import line and the reopening. The tool also checks that each
hole is a first-move range inside the second move's range and that the reopening point is the line after the range's trailing blank line.

**Negative controls, watched** (`data/fs131/im/move-control-im2.txt`): (1) renaming `woodallCone_strict` in `Cone` (inside the second move) made
`--check` exit 1 naming source l. 1388–1715 and the regenerated text; (2) deleting the reopened `namespace ArcMap` from `Contact` made it exit 1 naming
`Contact`; (3) a copy of the tool with a hole off its first-move range (`(1716, 1717)`) exits 1 naming the hole. Each restored by `--write`, `--check`
passing again.

**Other checks**: `tools/fs131_im_statements.py --check` PASS (the three `…_aux` statements equal `Contact`'s, diffs empty); `tools/fs131_k4_decls.py --check`
exit 0 with its two pre-existing `_root_` parse misses (item 262 (d)); `tools/check_architecture.py`: 209 rows, 0 import mismatches; it exits 1 on
"purchase ledgers disagree" (its check [5]), which it does identically on the tree before this stage (checked by stashing the stage's edits) — not this
job's. `ARCHITECTURE.md`'s `Cone` row names the second move. No `private` declaration in the range (item 263); the `scripts/Axioms.lean` records are by
name and unchanged.

**The build** (under the slot, as in § 4.2): **OK**, 445 of 445 batches, 4 modules rebuilt (`Cone` 22 s, `Moves`, `Contact`, `Proofs`); warnings only
`declaration uses 'sorry'` — `Contact` 4 (the three moves and `stuck_structure`), `Moves` 3, `BaseSteps` 7, `UnitArc` 17 (unchanged); none in `Cone`.
Log `build/gate/build/20261004T222948Z-2949144.log`; terminal output `data/fs131/im/build-stage5.log`.
