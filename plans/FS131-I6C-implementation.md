# FS131-I6C — wave 6's bridge, line C: unit-speed curves with 1-Lipschitz tangent (`Curve`), then the local graph off the cusps (`LocalGraph`)

*de Bruijn, the implementer (Opus 5.5), on branch `fs131-w6c` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c`, cut from
`fs131-w6` at `32f2ab4c`. Brief: `data/fs131/briefs/FS131-I6C-wave6-bridge.md` (main tree; its Amendment 1 of 2026-10-06 is part of it).
Started 2026-10-06.*

## Theorems this phase proved

*Filled stage by stage; each line names the declaration, its module, its axioms as printed from the build's oleans, and the entry it was read
against. "Wired" means proved here over a child that is still `sorry` on this branch — not yet a kernel theorem.*

Kernel theorems, on `[propext, Classical.choice, Quot.sound]` (Stage 2; build `data/fs131/i6c/logs/build-1-curve.log`, axioms
`data/fs131/i6c/logs/axioms-1-curve.out`, whose control `c11_discs` reads `sorryAx`), all in `Plane/Saturated/Curve`:
- `HadwigerNelson.Plane.IsUnitCurve.chord` — FS131-E8 § 3.2 (1), the chord bound (C1).
- `HadwigerNelson.Plane.IsUnitCurve.sin_le_inner` — FS131-E8 § 3.3's displayed inequality (C2).
- `HadwigerNelson.Plane.IsUnitCurve.strictMonoOn_dist` — FS131-E8-BETA's "the distance from z is strictly increasing".
- `HadwigerNelson.Plane.IsUnitCurve.norm_sub_le` — FS131-E8 § 3.3's `|γ(s) − z − sT(0)| ≤ s²/2`.
- `HadwigerNelson.Plane.IsUnitCurve.one_le_dist` — FS131-E8-OUTSIDE (the deriver's § 6.3; the planner's assembly).
- `HadwigerNelson.Plane.lipschitzOnWith_of_chord` — the last sentence of the erratum under FS131-E8-LOCAL.
- Children (mine): `IsUnitCurve.sin_add_sin_le` (C1 and C2 as one inequality, at length `ℓ ≤ π`), `IsUnitCurve.hasDerivWithinAt_re_mul`,
  `IsUnitCurve.hasDerivWithinAt_norm_sq`, `IsUnitCurve.abs_sub_le`, `IsUnitCurve.one_le_dist_of_sign`, `two_sin_le_norm_e_sub_e`,
  `lt_mul_of_two_sin_le`, `le_add_of_chord`; `isUnitCurve_circle` (the unit circle, the sharpness example the plan's § 12.2 owed).

Kernel theorems, on `[propext, Classical.choice, Quot.sound]` (Stage 3; build `data/fs131/i6c/logs/build-2-small.log`, axioms
`logs/axioms-2-small.out`, same control), in `Plane/Saturated/LocalGraph` unless said:
- `HadwigerNelson.Plane.AeColouring.ae_one_colour_of_isConnected` — **FS131-E8-DELTA** (E8 § 3.5).
- `HadwigerNelson.Plane.AeColouring.closure_essBdry_subset` — E8 § 3.1 (0); FS121-V5-OFF; FS121-V5-LOC (i).
- `HadwigerNelson.Plane.AeColouring.notMem_essBdry_of_mem_densitySet` — a density point of a class is no essential boundary point.
- Children (mine): `AeColouring.exists_densitySet_of_notMem`, `AeColouring.isOpen_setOf_forall_notMem_essSupport`,
  `AeColouring.mem_densitySet_of_forall_notMem_essSupport`; in `Curve`: `IsUnitCurve.strictMonoOn_dist_of_le_pi` (the leaf at length `π`).

Kernel theorems, on `[propext, Classical.choice, Quot.sound]` (Stage 4; build `logs/build-3-lens.log`, axioms `logs/axioms-3-lens.out`) —
children of `local_graph`, none a backlog row of its own:
- in `Curve`: `HadwigerNelson.Plane.exists_lens_point` (E8 § 3.1 (3)(c) and the erratum's midpoint, one statement), `exists_lens_point_far`,
  `lens_point_real`, `lens_ineq_real`;
- in `LocalGraph`: `TwoColourOn.false_of_mem_inter` ("an open set is not almost everywhere of two colours"),
  `TwoColourOn.notMem_essClosure_of_mem_densitySet`, `TwoColourOn.mem_interior_densitySet_of_notMem`,
  `TwoColourOn.mem_interior_densitySet_or` (E8 § 3.1 (1): `N = O_a ⊔ O_b ⊔ Z` off the cusps), `exists_arclength_inverse` (the arclength
  reparametrization the plan's (h) names as missing from Mathlib).

Wired over `Pinch`'s `TwoColourOn.essBoundary_inter_eq` only (Stage 4): `HasTwoDiscsAt.one_le_norm_sub` (E8 § 3.1 (3)(b)),
`HasTwoDiscsAt.norm_sub_le` (**the normal is 1-Lipschitz, sharp** — § 3.1 (3)(c) with the erratum), `HasTwoDiscsAt.normal_unique`.

Kernel theorems, on `[propext, Classical.choice, Quot.sound]` (Stage 5; build `logs/build-4-local.log`, axioms `logs/axioms-4-local.out`),
in `LocalGraph` — children of `local_graph`:
- `HadwigerNelson.Plane.exists_unit_curve_of_two_discs` — **the graph theorem**: E8 § 3.1 (4) (*Uniqueness*, `|g(u)| ≤ u²`, *Regularity* by
  the erratum's route) in graph coordinates, with no measure and no colouring in its statement;
- `hasDerivAt_of_sq_bound`, `abs_le_of_two_disc_bound`, `hasDerivAt_of_two_disc_bound` (`g′ = −n₁/n₂` from (3)(b)), `abs_inner_le_of_one_le`,
  `im_ge_of_norm_sub_I_le`, `e_neg_arcsin_re`; `isConnected_graph_side` (the two sides of a graph in a rectangle);
  `interior_densitySet_inter_ae_le`, `HasTwoDiscsAt.subset_interior_densitySet`, `TwoColourOn.exists_mem_essBoundary_of_continuous`
  (E8 § 3.1 (4), *Existence*), `TwoColourOn.ae_le_of_isPreconnected` (*Sides*).

**Wired over two leaves of `Pinch` only** (Stage 5; axioms `[propext, sorryAx, Classical.choice, Quot.sound]`; `LocalGraph` and `Curve` hold
no `sorry`): **`HadwigerNelson.Plane.local_graph` — FS131-E8-LOCAL** = FS111-M-C11 (ii) with "no cusp in the neighbourhood" =
FS111-W-NOBEND. It becomes a kernel theorem when `c11_discs` and `TwoColourOn.essBoundary_inter_eq` land (line P).

Stage 6, in `LocalGraph`: kernel theorems `sq9_not_isCuspAt_near_edge` (no cusp of the two classes in the edge ball: the fact the
inhabitant note owed), `sqEdgePt_mem_essBoundary`; wired over `local_graph`: `sq9_exists_isInterfaceChart` (the inhabitant: every hypothesis of
`local_graph` at once on `sq9`).

Wired (over `sorry` children; axioms `[propext, sorryAx, Classical.choice, Quot.sound]`): `HadwigerNelson.Plane.AeColouring.local_graph`
(FS121-V5-LOC (ii)) — over `local_graph` (mine, open) and `TwoColourOn.essBoundary_inter_eq` (`Pinch`, another line's leaf) through
`TwoColourNhd.mem_essBoundary`.

## What I may and may not change (the brief's `touches:` and § Done means, item 4)

- **May**: the proofs of the eleven leaves of `Proofs/HadwigerNelson/Plane/Saturated/Curve.lean` (six) and `.../LocalGraph.lean` (five); new
  helper declarations in those two files, under names no other module declares (checked by grep over `Proofs/` before each is added; the join's
  `dupnames.sh` is the gate's); a new module of my own beside them, with its line in `Proofs.lean` and `ARCHITECTURE.md`; a block headed
  "FS131-I6C" in `scripts/Axioms.lean` above the `=== PURCHASED ===` banner; this record; `tools/fs131_i6c_*.py`; `data/fs131/i6c/`;
  `data/fs131/reports/FS131-I6C.md`.
- **May not**: any statement or definition (`IsUnitCurve`, `IsInterfaceChart`, the eleven theorem statements — checked against `32f2ab4c` at
  every saved stage by `tools/fs131_i6c_statements.py`); `Basic`, `Pinch`, `MapColouring`, `Fan`, `FanExamples`, `FanBridge`; the planners' record;
  any landed module beyond new declarations; `main`; no `axiom`, no `native_decide`; no merge of another branch; the gate is not mine to run.
- **Rest on, as stated** (another implementer's leaves, `sorry` on this branch): `c11_discs`, `TwoColourOn.essBoundary_inter_eq` (`Pinch`). A
  theorem of mine that uses one is *wired*, and its axioms print shows `sorryAx` until the join.

## Stage 1 — SAVED (FS131-I6C): the readback, the as-given build

### 1.1 The brief's quotations against their sources (standing rule 3)

By script (`tools/fs131_i6c_quotes.py`: exact substring match of each `>`-block against the file its `— source:` line names; it exits 2 if the
brief holds no quotation, so an empty read cannot pass; output `data/fs131/i6c/logs/quotes.out`): **24 quotations, 24 exact, 0 mismatched**,
exit 0. With one character of the first quotation altered (`--plant`) it reports 1 mismatch and exits 1 (`quotes-plant.out`). No finding about the
brief.

### 1.2 Read, in order

The brief with its amendment; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` §§ Building, Make the gate fail; the planners' record
`plans/FS131-w6-kernel-plan.md` Stages 8–12 whole (§ 9 for the foundation; §§ 11.3–11.5, 12.1–12.2 for my leaves); the deriver's record
`plans/FS131-E8-derivation.md` (main) §§ 3.1–3.7 with the erratum under § 3.1 and the note under FS131-E8-FAN, and Stage 6 whole (§ 6.3 is the
check of `one_le_dist`, § 6.4 of the planner's `3.5δ`, § 6.5 the read-backs — `local_graph`'s `bdry` is about `essBoundary A`, "a line the
colouring form owes"); inventory items 499, 501, 502; the modules `Plane/Saturated/Basic`, `Pinch`, `Curve`, `LocalGraph` whole, and `Plane/Chord`,
`Plane/Cover`, `Plane/UnitPairs`, `Plane/AeColouring` for the definitions the leaves read. **Not yet read**: `Fan`, `FanExamples`, `FanBridge`
(read where a leaf needs them: `notMem_essClosure_of_mem_densitySet` lives in `Fan`, which `LocalGraph` does not import — see § 1.4).

### 1.3 The branch builds as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: **OK — all 1804 modules already up to date, nothing built, 5
modules with warnings**, exit 0 (read from the file the driver wrote, `data/fs131/i6c/logs/build-0-as-given.exit`; log
`build-0-as-given.log`; `build/gate/build/20261006T144523Z-729186.log`). Every warning is `declaration uses sorry`: **31** — `Curve` 6,
`LocalGraph` 5, `FanBridge` 12, `Pinch` 7, `MapColouring` 1. Eleven are mine.

### 1.4 What the readback found before any proof was written

1. **`Curve`'s six leaves need no integral.** The plan's routes are integrals of cosines (`intervalIntegral.integral_eq_sub_of_hasDeriv_right`,
   with one-sided derivatives at the ends of `Icc` named as the hard part). Each inequality is instead the monotonicity of one auxiliary real
   function on `[0, ℓ]` whose derivative has a sign (`monotoneOn_of_hasDerivWithinAt_nonneg`, which reads the derivative on the interior only), so
   the end-point derivatives are never read. Registered before writing: **C1 and C2 are one lemma** —
   `sin (s − u₀) + sin u₀ ≤ ⟨γ s − γ 0, e (ψ u₀)⟩` for `s, u₀ ∈ [0, ℓ]`, from `G u = ⟨γ u − γ 0, e (ψ u₀)⟩ − sin (u − u₀)`,
   `G′ u = cos (ψ u − ψ u₀) − cos (u − u₀) ≥ 0` — and **it reads `ℓ ≤ π`, not `ℓ ≤ π/2`** (a route note, to be confirmed by the proof: the
   statements' `π/2` is then stronger than `chord` and `sin_le_inner` need; `one_le_dist` does read `π/2`, for the sine's monotonicity).
2. **`lipschitzOnWith_of_chord` without subdivision**: the plan's route sums `2 arcsin (Δ/2)` over `n` pieces and takes `n → ∞`. Planned
   instead: `image_le_of_liminf_slope_right_le_deriv_boundary` (Mathlib's comparison for a continuous function whose right slopes are frequently
   below `r` for every `r > 1`) with `B x = ψ u + (x − u)`; the slope bound from `‖e a − e b‖ = 2 |sin ((a − b)/2)|` and
   `x − x³/4 < sin x` near `0`. To be confirmed by the proof.
3. **`notMem_essClosure_of_mem_densitySet` is in `Plane/Saturated/Fan`**, which `LocalGraph` does not import (the plan's row says "import
   it"). `Fan` is not mine to edit and an import line is not a statement; if the three small leaves need it I add the import to `LocalGraph`
   (its consumer `FanBridge` already imports `Fan` through `FanExamples`, so no cycle), and say so in the stage.

### 1.5 Registered expectations (before the first proof)

| # | expectation | probability / interval |
|---|---|---|
| Z1 | `Curve`'s six leaves close in this job, with no statement defect | 0.9 |
| Z2 | the plan's price for `Curve` (2.5 d = 20 h) is high by a factor of at least five by my count of elaborations | 0.7 |
| Z3 | `LocalGraph`'s three small leaves close in this job | 0.85 |
| Z4 | `local_graph` closes in this job (over `c11_discs` and `essBoundary_inter_eq` as statements) | 0.35; if not, children (a)–(g) stated and proved and (h), (i) left with a work list: 0.4 |
| Z5 | a statement defect among my eleven (a hypothesis missing, not a route note) | 0.2; the likeliest: `IsInterfaceChart.sides` or `.bdry` against what the square gives (the chart `Q` must be chosen so that `Q ∖ γ` is exactly two connected open sets); `local_graph`'s `hsatA`/`hsatB` against `c11_discs`' contact hypotheses |
| Z6 | `TwoColourOn.disj` is read in `local_graph` at exactly one step (the amendment's question) | 0.6 |

## Stage 2 — SAVED (FS131-I6C): `Curve`'s six leaves, the unit circle, the re-pricing

### 2.1 What was proved, and by which route

All six leaves of `Plane/Saturated/Curve` are closed; the module has no `sorry`. **No integral is taken** (§ 1.4 item 1, confirmed): each
inequality is the monotonicity on `[0, ℓ]` of one real function whose derivative has a sign, read on the open interval only
(`monotoneOn_of_hasDerivWithinAt_nonneg`, `strictMonoOn_of_hasDerivWithinAt_pos`), so the plan's "hard part" (one-sided derivatives at the ends of
`Icc`) does not arise.

| leaf | route (as proved) | against its entry (verbatim words in quotes) |
|---|---|---|
| `IsUnitCurve.chord` | `sin_add_sin_le` at `u₀ = 0`, `s = ℓ` | E8 § 3.2 (1): "`⟨γ(ℓ) − γ(0), T(0)⟩ … ≥ … sin ℓ`" for "`ℓ ≤ π/2`" — `((γ ℓ − γ 0) * conj (e (ψ 0))).re` is the real inner product with `T(0) = e(ψ 0)`. As stated |
| `IsUnitCurve.sin_le_inner` | `sin_add_sin_le` at `u₀ = s` | E8 § 3.3: "`2⟨γ(s) − z, T(s)⟩ … ≥ … 2 sin s`", `z = γ(0)` — as stated, on the closed interval |
| `IsUnitCurve.strictMonoOn_dist` | `(d/du)‖γ u − γ 0‖² = 2⟨γ u − γ 0, T(u)⟩ ≥ 2 sin u > 0` on `(0, ℓ)`; then the square root | E8-BETA: "the distance from z is strictly increasing" — on `[0, ℓ]`, ends included |
| `IsUnitCurve.norm_sub_le` | `image_norm_le_of_norm_deriv_right_le_deriv_boundary` with `B u = u²/2`; `‖e(ψ u) − e(ψ 0)‖ ≤ u` (`norm_e_sub_e_le`, wave 1) | E8 § 3.3: "`|γ(s) − z − sT(0)| ≤ … ≤ s²/2`" — no bound on `ℓ`, as stated |
| `IsUnitCurve.one_le_dist` | `one_le_dist_of_sign` for `σ = ±1`: `‖γ u − γ 0 − σ i e(ψ 0)‖²` has derivative `2⟨γ u − γ 0, T(u)⟩ − 2σ sin(ψ u − ψ 0) ≥ 2 sin u − 2 sin u` | FS131-E8-OUTSIDE: "stays outside the two open unit discs tangent to it at its starting point" — the planner's three lines, the deriver's § 6.3 |
| `lipschitzOnWith_of_chord` | `le_add_of_chord` for `ψ` and for `−ψ`: the right slopes of `ψ` are eventually below every `r > 1` (`two_sin_le_norm_e_sub_e`, `lt_mul_of_two_sin_le` from `x − x³/6 < sin x`), then `image_le_of_liminf_slope_right_le_deriv_boundary` | the erratum under FS131-E8-LOCAL: "a continuous tangent angle with that property is 1-Lipschitz" — **no subdivision** and no limit of `n · 2 arcsin (d/2n)` (§ 1.4 item 2, confirmed) |

**The one inequality** (`IsUnitCurve.sin_add_sin_le`): for `s, u₀ ∈ [0, ℓ]` and `ℓ ≤ π`,
`sin (s − u₀) + sin u₀ ≤ ⟨γ s − γ 0, e (ψ u₀)⟩` — from `G u = ⟨γ u − γ 0, e (ψ u₀)⟩ − sin (u − u₀)`, `G′ u = cos (ψ u − ψ u₀) − cos (u − u₀) ≥ 0`.

**A generalization, kernel-checked for two of the three** (route note, no defect): `chord` and `sin_le_inner` hold for `ℓ ≤ π`, not only
`ℓ ≤ π/2` — `sin_add_sin_le` is proved at `ℓ ≤ π` and the two leaves are its cases. `strictMonoOn_dist` holds for `ℓ ≤ π` by the same proof
(`sin u > 0` on `(0, π)`); stated at `π` in the next stage as a child, so that it is checked and not claimed. `one_le_dist` does read `π/2` (the
sine's monotonicity on `[−π/2, π/2]`), and `gamma`'s `L ≤ π/2` is from `R ≤ 1/2`, not from these.

**A docstring edited, no statement**: `lipschitzOnWith_of_chord`'s docstring named the route not taken ("subdivide: `2 arcsin (d/2n)` summed over
`n` pieces tends to `d`"); it now names the route taken. The module docstring gained two bullets. The statement check (below) is on statements.

**The sharpness example** (the plan's § 12.2, owed): `isUnitCurve_circle (J) : IsUnitCurve e (fun s => s + π/2) J`, and two `example`s: on the
unit circle `chord`'s and `sin_le_inner`'s right-hand sides are exactly `sin s`, and the distance to the centre `γ 0 + i e(ψ 0) = 0` of one of
the two tangent discs is exactly `1`.

### 2.2 Checks

- **Build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` — OK, 466 of 466 batches, 4 modules rebuilt (`Curve`,
  `LocalGraph`, `FanBridge`, `Proofs`), exit 0 (`data/fs131/i6c/logs/build-1-curve.exit`; `build-1-curve.log`;
  `build/gate/build/20261006T145204Z-752120.log`). Warnings: 25, every one `declaration uses sorry` — `LocalGraph` 5, `FanBridge` 12, `Pinch` 7,
  `MapColouring` 1; **`Curve` none** (31 − 6).
- **Axioms** (`data/fs131/i6c/I6cAxioms.lean`, run with `lake env lean` on the build's oleans; output `logs/axioms-1-curve.out`): the control
  `c11_discs` prints `[propext, sorryAx, Classical.choice, Quot.sound]` — the reader reports `sorry` where there is one — and each of the fifteen
  declarations of this stage prints `[propext, Classical.choice, Quot.sound]`. The fifteen lines are in `scripts/Axioms.lean`'s new block
  "FS131-I6C", above the `=== PURCHASED ===` banner.
- **Statements** (`tools/fs131_i6c_statements.py`, against `32f2ab4c`; `logs/statements-2.out`): 16 of 16 the same, no `axiom`, no
  `native_decide`; with one character altered (`--plant`, `logs/statements-plant.out`) it reports the changed declaration and exits 1.
- **Names**: each new name grepped over `Proofs/` and `scripts/` before it was added (0 hits each); `norm_e_sub_e_eq` exists in
  `Plane/ValidMap`, which `Curve` does not import, so the chord inequality is stated under a name of its own, `two_sin_le_norm_e_sub_e`
  (an inequality, not that equality).

### 2.3 The re-pricing (the brief's item 2)

The plan priced `Curve` at 2.5 agent-days (20 h): 4, 3, 3, 2, 3, 5 h. As done: the six leaves, eight children and the circle in **six
elaborations** of 2.5 s each and one build — well under an hour of work. The plan expected its computational prices "high by a factor of two to
three"; **they are high by more than ten** (Z2 met). For what is left, re-priced from these: `LocalGraph`'s three small leaves (10.5 h in the
plan) — about an hour; `local_graph`'s children (a)–(g), (i) (27 h in the plan) are of the same computational kind and I price them at half a
day together; (h), the curve by arclength (2 d in the plan), is the one I do not re-price down from these leaves — its difficulty is a missing
construction (an arclength reparametrization), not a computation — and it carries the width.

## Stage 3 — SAVED (FS131-I6C): `LocalGraph`'s three small leaves; the colouring form wired; two generalizations

### 3.1 What was proved, and by which route

| leaf | route (as proved) | against its entry |
|---|---|---|
| `AeColouring.notMem_essBdry_of_mem_densitySet` | the class itself by the definition of `essBoundary`; another class by `notMem_essClosure_of_mem_densitySet` (`Plane/Saturated/Fan`) | the plan's row, as stated |
| `AeColouring.ae_one_colour_of_isConnected` | the sets `O_j = {y : ∀ i ≠ j, y ∉ supp (cls i)}` are open in the plane (supports are closed), `O_j ⊆ S̃_j` (so pairwise disjoint), and every point of `W` lies in one (`exists_densitySet_of_notMem`: no essential boundary, no cusp); a preconnected `W` lies in one `O_j` (`IsPreconnected.subset_left_of_subset_union`); then `W ∖ cls j ⊆ S̃_j ∖ cls j`, null (`volume_densitySet_diff`) | E8 § 3.5, sentence by sentence: "some `j(x)` has `x ∈ S̃_{j(x)}`; every other class … is null near `x`" is `exists_densitySet_of_notMem`; "`j(·)` is locally constant on `W`, hence constant" is the open cover. FS131-E8-DELTA: "a connected open set that meets the essential boundary of no class and holds no cusp of any class is almost everywhere of one colour" — as stated |
| `AeColouring.closure_essBdry_subset` | **shorter than the plan's and the entry's**: no sequence and no pigeonhole. If `x` is neither an essential boundary point nor a cusp, `x ∈ O_j` for one `j`; `O_j` is open and every point of it is a density point of `cls j` (`mem_densitySet_of_forall_notMem_essSupport`), so it misses the essential boundary; so `x` is not in its closure | E8 § 3.1 (0): "The closure of the essential boundary lies in `∂_e ∪ Σ`" — stated with the cusps in place of `Σ` (stronger: the cusps lie in `Σ`), as the planner read it |

`AeColouring.local_graph` (the colouring's form) is **wired** from `local_graph` as the plan's row says: the two-colour ball at an interface
point (`exists_twoColourNhd_of_mem_interfaceSet`), `U′ = U ∩ ball y ρ`, cusps lie in `Σ`, `TwoColourNhd.mem_essBoundary`, then `local_graph`.
It carries `sorryAx` until `local_graph` and `Pinch`'s `essBoundary_inter_eq` land.

### 3.2 Two generalizations (sent to the coordinator mid-job; neither is a defect)

1. **`ae_one_colour_of_isConnected` does not read `hW : IsOpen W`.** The sets `O_j` are open *in the plane*, so any connected `W` — open
   or not — that meets no essential boundary and no cusp is almost everywhere of one colour. The hypothesis stays in the statement (fixed), and
   the proof names it with `have _ := hW` and a comment, so the unused-variable linter is silent (`LEAN.md` § The gate, the linters' bullet).
   Kind: *the statement carries a hypothesis its proof does not read* — a generalization, for the errata; no consumer is hurt (`FanBridge` applies
   it to open regions).
2. **`IsUnitCurve.chord`, `.sin_le_inner`, `.strictMonoOn_dist` hold for `ℓ ≤ π`** (Stage 2's note), now all three kernel-checked at that
   length: `sin_add_sin_le`, `strictMonoOn_dist_of_le_pi`. Same kind.

### 3.3 An import added, and the module map

`LocalGraph` now imports `Plane/Saturated/Fan` (for `notMem_essClosure_of_mem_densitySet`; the plan's § 11.4 row says "import it"). `Fan` imports
`Basic` only and `FanBridge` already reaches it through `FanExamples`, so the import graph gains no cycle. `ARCHITECTURE.md`'s row for
`Plane/Saturated/LocalGraph` gained the import in its imports cell — one cell, nothing else — and `tools/check_architecture.py` reads PASS with
it (`data/fs131/i6c/logs/check-architecture-1.log`) and FAIL without it, naming the module and the import
(`check-architecture-1-control.log`: "imports of Plane/Saturated/LocalGraph: stated-only [], real-only ['Plane/Saturated/Fan']").

### 3.4 Checks

- **Build**: OK — 466 of 466 batches, 4 modules rebuilt, exit 0 (`logs/build-2-small.exit`, `build-2-small.log`;
  `build/gate/build/20261006T150524Z-820491.log`). Warnings: 21, every one `declaration uses sorry` — `LocalGraph` 1 (`local_graph`),
  `FanBridge` 12, `Pinch` 7, `MapColouring` 1.
- **Axioms** (`logs/axioms-2-small.out`): the control `c11_discs` and the wired `AeColouring.local_graph` print `sorryAx`; the seven new
  declarations print the standard three; their lines are in `scripts/Axioms.lean`'s block (the wired one is not, until it is clean).
- **Statements** (`logs/statements-3.out`): 16 of 16 the same.

### 3.5 Where the job stands, and the plan for `local_graph`

Ten of my eleven leaves are closed or wired; `local_graph` is the one `sorry` left in my two files. Its decomposition, fixed here before any
of it is written into the module (children under names of my own; each proved child is a kernel theorem or wired over `Pinch`'s two leaves):

| child | statement (informal) | status at this stage |
|---|---|---|
| L1 `exists_lens_point` (`Curve`, no measure) | unit normals at `x`, `x′` with `‖ν − ν′‖ > ‖x − x′‖`, each point outside two of the open unit discs at the other, `4‖x − x′‖ ≤ τ`: a point within `τ` of `x` in two opposite open discs. Far regime (`> 6‖x − x′‖`): E8 § 3.1 (3)(c)'s point `x + s(ν′ − ν)`; near regime: the midpoint of two centres less than 2 apart (`norm_sub_le_of_discs`) | elaborated on a scratch copy (`data/fs131/i6c/scratch/lens.lean`), not yet in the module |
| L2 `TwoColourOn` facts | an open subset of `N` is not a.e. in both sets (**the one place `disj` is read so far**); a density point of `A` in `N` is outside `B`'s essential closure; off the essential boundary and the cusps a point of `N` is interior to `S̃_A` or to `S̃_B` | planned |
| L3 `HasTwoDiscsAt.norm_sub_le` | the normal of the two discs is 1-Lipschitz on the common essential boundary, at pairs with `closedBall x (4‖x − x′‖) ⊆ N` — E8 § 3.1 (3)(b), (c) and the erratum, in one statement; in particular the normal is unique | planned (L1, L2, `Pinch`'s `essBoundary_inter_eq`) |
| L4 the graph | in the frame of `ν(y)`: each normal segment over `|u| < h` holds exactly one essential boundary point, at height `|g u| ≤ u²` (E8 § 3.1 (4) existence, uniqueness) | planned |
| L5 `g` differentiable | `g′ = −n₁/n₂` from (b) at the graph's points; `n₁`, `n₂` continuous | planned |
| L6 arclength | `S u = ∫₀^u 1/n₂` (clamped to a global continuous integrand), an order isomorphism of `ℝ`; its inverse has derivative `n₂`; `γ = y + (U s + i g (U s)) τ₀`, `ψ = θ₀ − arcsin (n₁ ∘ U)`; `lipschitzOnWith_of_chord` with L3 | planned — the plan's (h) |
| L7 the chart | `Q` a rectangle in the frame, `bdry`, `injOn`, `discs`, the two sides connected (each a union of normal segments meeting one convex strip) | planned — the plan's (i) |

## Stage 4 — SAVED (FS131-I6C): `local_graph`'s children L1–L3 and the arclength inverse

**L1, the lens point** (`Curve`, no measure): `exists_lens_point` — unit normals `ν`, `ν′` at `x`, `x′` with `‖ν − ν′‖ > ‖x − x′‖`, `x′`
outside the open unit disc about `x + ν`, `x` outside the one about `x′ − ν′`, and `4‖x − x′‖ ≤ τ`: a point within `τ` of `x` in two opposite
open unit discs. Far regime (`> 6‖x − x′‖`, `exists_lens_point_far`): E8 § 3.1 (3)(c)'s point, written `x + s(ν′ − ν)` with
`s = min(L/2, τ)/L`, the two squared distances being `1 − s(1 − s)L²` and at most `1 + 2δ² − s(1 − s)L²` (`lens_point_real`: two
`linear_combination`s and one five-variable inequality, `lens_ineq_real`, kept apart from the large context as `LEAN.md` § Searching says).
Near regime: the midpoint of two centres less than `2` apart (`norm_sub_le_of_discs`' contrapositive), within `3.5‖x − x′‖` of `x`.
**Read of the four disc conditions: two** — the far point reads only `x′ ∉ B(x + ν, 1)` and `x ∉ B(x′ − ν′, 1)` (the two lower bounds on the
inner products); E8's (3)(c) quotes (b) "at `x″`" for both signs. A route note.

**L2, L3** (`LocalGraph`): as the table of § 3.5. `HasTwoDiscsAt.norm_sub_le` is E8 § 3.1 (3)(c) and the erratum in one statement:
`‖ν − ν′‖ ≤ ‖x − x′‖` for essential boundary points of `N` with their two discs, whenever `closedBall x τ ⊆ N` with `τ ≥ 4‖x − x′‖` — the
crude `6δ` is inside `exists_lens_point` and is exported nowhere.

**The arclength inverse** (`exists_arclength_inverse`, no measure in its statement): for a continuous `σ ≥ 1` on `[−h, h]`, an inverse `V` of
`u ↦ ∫₀^u σ` on a symmetric `(−ℓ, ℓ)`, onto an interval `(a, b) ∋ 0` in `[−h, h]`, with `V′ = 1/σ ∘ V`. The integrand is `σ` clamped to
`[−h, h]`, so the arclength is an order isomorphism of the line (`StrictMono.orderIsoOfSurjective`) and its inverse is continuous for free
(`HasDerivAt.of_local_left_inverse`). About fifty lines; the plan priced (h) at two days.

**Amendment 1, item 2 — where `TwoColourOn.disj` is read, so far**: in `TwoColourOn.false_of_mem_inter` (two opposite open discs cannot share a
point of `N`: the lens step, as the third planner expected) and in `TwoColourOn.notMem_essClosure_of_mem_densitySet` (a density point of `A`
is outside `B`'s essential closure — read by `mem_interior_densitySet_or`, i.e. by "off the essential boundary a point is interior to one
density set": E8 § 3.1 (1)'s `N = O_a ⊔ O_b ⊔ Z`). **Two steps, not one.** Also through `Pinch`'s `essBoundary_inter_eq` and `c11_discs`, as
stated there. The final count is in the last stage.

**Checks.** Build OK — 466 of 466 batches, 4 modules rebuilt, exit 0 (`logs/build-3-lens.exit`, `build-3-lens.log`;
`build/gate/build/20261006T151942Z-892855.log`); 21 warnings, every one `declaration uses sorry` (`LocalGraph` 1). Axioms
(`logs/axioms-3-lens.out`): nine declarations on the standard three, in `scripts/Axioms.lean`'s block; three wired ones print `sorryAx`
(not in the block). Statements: 16 of 16 the same (`logs/statements-4.out`). Names grepped before adding (0 hits each).

**Next** (elaborated on scratch copies under `data/fs131/i6c/scratch/`, not yet in the module): `graph.lean` holds
`exists_unit_curve_of_two_discs` — E8 § 3.1 (4) in graph coordinates with no measure (uniqueness on vertical segments, `|g u| ≤ u²`,
`g′ = −n₁/n₂` from `hasDerivAt_of_two_disc_bound`, the arclength inverse, `φ = −arcsin n₁`, `lipschitzOnWith_of_chord`) — elaborated with
`#print axioms` reading the standard three under `lake env lean` (iteration only). Left: the frame transfer, existence on normal segments by
connectedness, the two sides, the chart.

## Stage 5 — SAVED (FS131-I6C): `local_graph` proved from its children — no `sorry` left in `Curve` or `LocalGraph`

### 5.1 The proof, child by child (the plan's (a)–(i); E8 § 3.1 (1)–(4) with the erratum)

| plan's child | as proved | E8's words |
|---|---|---|
| (a) the boundary in `U` | `TwoColourOn.mem_interior_densitySet_or`: off `∂_e A` and the cusps a point of `N` is interior to `S̃_A` or to `S̃_B` (the interiors play `O_a`, `O_b`); `essBoundary A ∩ N = essBoundary B ∩ N` is `Pinch`'s leaf, used as stated | § 3.1 (1): "`N = O_a ⊔ O_b ⊔ Z`" |
| (b) the discs | `c11_discs` (`Pinch`'s leaf, as stated) at every point of `∂_e A ∩ U`, one `N`; the normal chosen by `choose`, unique by `HasTwoDiscsAt.normal_unique` | § 3.1 (2) |
| (c) `|⟨x″ − x′, ν′⟩| ≤ δ²/2` | `HasTwoDiscsAt.one_le_norm_sub`, in coordinates `abs_inner_le_of_one_le` | § 3.1 (3)(b) |
| (d), (e) the normal 1-Lipschitz | `exists_lens_point` and `HasTwoDiscsAt.norm_sub_le` (Stage 4): the crude `6δ` and the sharp bound in one statement | § 3.1 (3)(c); the erratum |
| (f) existence | `TwoColourOn.exists_mem_essBoundary_of_continuous` on the normal segment `v ↦ Φ(u + iv)`, `|v| ≤ h₁`, its ends in the two tangent discs at `y` (`u² + (h₁ − 1)² < 1`) | § 3.1 (4) *Existence* |
| (g) uniqueness, `|g u| ≤ u²` | inside `exists_unit_curve_of_two_discs` | § 3.1 (4) *Uniqueness* |
| (h) the curve | inside `exists_unit_curve_of_two_discs`: `g′ = −n₁/n₂` (`hasDerivAt_of_two_disc_bound`: no "`O(|Δu|²)`" left informal — the constants are `|Δg| ≤ 6|Δu|`, remainder `37 Δu²`); `exists_arclength_inverse` with `σ = 1/n₂`; `ζ s = V s + i g(V s)`, `φ s = −arcsin n₁(V s)` so that `e(φ) = n₂ − i n₁` (`e_neg_arcsin_re`), no continuous lift needed; `lipschitzOnWith_of_chord` with the sharp normal bound and `‖ζ s − ζ s′‖ ≤ |s − s′|` | § 3.1 (4) *Regularity*, by the erratum: "No second derivative is taken" — and none is |
| (i) the sides | `isConnected_graph_side` (each point joined to the point over the middle at height `±3h₁/4` by a vertical and a horizontal segment), `TwoColourOn.ae_le_of_isPreconnected` with the anchor points `Φ(±(3h₁/4) i)` in the two tangent discs at `y` | § 3.1 (4) *Sides* |

**The frame.** `τ₀ = −i ν(y)`, `Φ z = y + z τ₀`, `Ψ p = (p − y) conj τ₀`; `Z_f = Φ⁻¹(∂_e A ∩ U)`, `n z = ν(Φ z) conj τ₀`; `h₁ = min(ρ, 1)/32` with
`B(y, ρ) ⊆ U` (E8 takes `/24`: with the sharp bound read at `τ = 16h₁`, `2h₁ + 16h₁ < 32h₁ ≤ ρ`). **The chart**: `Q = Ψ⁻¹((a, b) × (−h₁, h₁))` — a
rectangle, not E8's square, because `IsInterfaceChart` asks a symmetric parameter interval `(−ℓ, ℓ)` and the arclength of the graph over
`(−h₁, h₁)` is not symmetric about `0`; `(a, b) = V((−ℓ, ℓ))`. `γ s = Φ(ζ s)`, `ψ s = θ₀ + φ s` with `e θ₀ = τ₀` (`Complex.arg`).

### 5.2 `local_graph` read against FS131-E8-LOCAL

"every point y of the interface set in U is the centre of an open square inside U in which the interface set is the graph, over the tangent
line at y, of a C^{1,1} function whose unit tangent is 1-Lipschitz in arclength, the two sides of the graph in the square being connected open
sets, each almost everywhere of one colour, of two different colours" — the Lean conclusion `∃ Q γ ψ h′, Q ⊆ U ∧ IsInterfaceChart A B N y Q γ ψ h′`
gives: an open `Q ∋ y` inside `U` (a rectangle in the frame: the entry's "square" is the proof's, as the planner's read-back said); in `Q`
the essential boundary of `A` is exactly the image of an injective unit-speed curve through `y` with 1-Lipschitz tangent angle (`bdry`,
`curve`, `injOn`, `zero`); the two unit discs at each of its points with normal `i e(ψ s)` into `B` (`discs`: the planner's addition); `Q` off
the curve is two connected open sets, one almost everywhere in `A` and one in `B` (`sides`). Hypotheses: two measurable sets with null unit
pairs on a two-colour open set, no cusp in `U ⊆ N`, contacts at the essential boundary points of `U` — the statement as the planner fixed it,
unchanged. Not claimed, and not proved: a lower bound on the chart's size; that `Q_a`, `Q_b` are disjoint (they are, but `sides` does not say
so).

### 5.3 Amendment 1, item 2 — where the proof of `local_graph` reads `TwoColourOn.disj`, by step

**Not at one step: at four, through two lemmas** (and through `Pinch`'s two leaves, whose proofs are another line's).
- `TwoColourOn.false_of_mem_inter` ("an open set is not almost everywhere of two colours" — `disj` read directly), used at:
  1. **the lens** — `HasTwoDiscsAt.norm_sub_le` (§ 3.1 (3)(c), the erratum): the third planner's expected step;
  2. **existence** — `exists_mem_essBoundary_of_continuous`: the two open sets `int S̃_A`, `int S̃_B` are disjoint in `N`, so the normal
     segment cannot be covered by them (§ 3.1 (4): "two disjoint non-empty relatively open sets");
  3. **the sides** — `ae_le_of_isPreconnected`: the same disjointness, to put a connected side in one of the two.
- `TwoColourOn.notMem_essClosure_of_mem_densitySet` (`disj` read directly), used at:
  4. **the trichotomy** — `mem_interior_densitySet_or` (§ 3.1 (1): a point of `N` off `∂_e A` and the cusps is interior to one density
     set), read by steps 2 and 3.
For two sets that may overlap: steps 2–4 are false as they stand (through an overlap region of positive measure a path passes from `int S̃_A`
to `int S̃_B` without meeting `∂_e A`; there both have density 1), so a restatement is of a different lemma — its essential boundary would
be that of `A ∖ B` or of the overlap. `cover` is read at `mem_interior_densitySet_of_notMem`; (H2) only inside `Pinch`'s leaves.

### 5.4 Checks

- **Build**: OK — 466 of 466 batches, 3 modules rebuilt (`LocalGraph`, `FanBridge`, `Proofs`), exit 0 (`logs/build-4-local.exit`,
  `build-4-local.log`; `build/gate/build/20261006T153610Z-992176.log`). Warnings: **20**, every one `declaration uses sorry` — `FanBridge` 12,
  `Pinch` 7, `MapColouring` 1; **`Curve` 0, `LocalGraph` 0** (31 − 11). `grep -c sorry` on the two files: 0, 0.
- **Axioms** (`logs/axioms-4-local.out`): twelve new declarations on the standard three (in `scripts/Axioms.lean`'s block); `local_graph`
  prints `sorryAx`. Its only references to open leaves are `c11_discs` and `essBoundary_inter_eq` (grep of the module: `hkey`, `hdisc` in
  `local_graph`; `one_le_norm_sub`; `AeColouring.local_graph` through `TwoColourNhd.mem_essBoundary`) — every other declaration of the two
  modules prints clean, so the `sorryAx` is theirs. This is an argument from the prints and the grep, not a print of its own: the join's audit
  is the check.
- **Statements**: 16 of 16 the same (`logs/statements-5.out`).

## Stage 6 — SAVED (FS131-I6C): the inhabitant, the final checks, the expectations scored

### 6.1 The inhabitant of `local_graph` (the plan's § 12.2, "owed")

`sq9_not_isCuspAt_near_edge`: for `x ∈ B(sqEdgePt, 1/8)` neither `sq9.cls sqColA` nor `sq9.cls sqColB` has a cusp at `x` — on its own closed
side a class has positive upper density (`sq9Sq_subset_essClosure`, wave 2), strictly on the other side it is absent from a ball about `x`
(`sq9Col_near_edge`). `sqEdgePt_mem_essBoundary`: both squares have positive upper density at the edge point. **`sq9_exists_isInterfaceChart`**
applies `local_graph` to `sq9.cls sqColA`, `sq9.cls sqColB`, `N = U = B(sqEdgePt, 1/8)`, `y = sqEdgePt`: `sq9_twoColourNhd.two`, the classes'
measurability and null unit pairs, no cusp, `sq9_tight_saturated.2.1` for both contact hypotheses — every hypothesis at once, at `k = 9`. It is
wired (it is `local_graph`). The module docstring's inhabitant paragraph now names these in place of "owed".

### 6.2 Final checks

- **Build**: OK — 466 of 466 batches, 3 modules rebuilt, exit 0 (`logs/build-5-inhabitant.exit`, `build-5-inhabitant.log`;
  `build/gate/build/20261006T154908Z-1100474.log`). Warnings: 20, every one `declaration uses sorry`: `FanBridge` 12, `Pinch` 7,
  `MapColouring` 1. **`Curve` and `LocalGraph`: none.**
- **Axioms** (`data/fs131/i6c/I6cAxioms.lean` → `logs/axioms-5-final.out`): 52 prints, no error — **45 on the standard three**, **7 with
  `sorryAx`**: the control `c11_discs`, and the six wired declarations (`HasTwoDiscsAt.one_le_norm_sub`, `.norm_sub_le`, `.normal_unique`,
  `local_graph`, `AeColouring.local_graph`, `sq9_exists_isInterfaceChart`). `scripts/Axioms.lean`'s block "FS131-I6C" holds the 45 clean
  lines and none of the wired ones (counted: 45).
- **Statements** against `32f2ab4c` (`logs/statements-6.out`): 16 of 16 the same; no `axiom`, no `native_decide`. The brief's quotations
  re-run: 24 of 24 exact.
- **Module map**: `tools/check_architecture.py` PASS (`logs/check-architecture-2.log`).
- **Not run, not mine**: the gate (`axioms.sh`, `vacuity.sh`, `dupnames.sh`, linters). `lake env lean` on both files prints no warning of
  any linter; every new name was grepped over `Proofs/` and `scripts/` before it was added.
- **Processes**: none left; the five builds each wrote an exit file, read directly.

### 6.3 Expectations scored (§ 1.5)

| # | registered | outcome |
|---|---|---|
| Z1 | `Curve`'s six close, no statement defect, 0.9 | met |
| Z2 | the plan's price for `Curve` high by at least five, 0.7 | met — more than ten |
| Z3 | `LocalGraph`'s three small leaves close, 0.85 | met |
| Z4 | `local_graph` closes in this job, 0.35 | **met, against the odds I gave**: the plan's five days (its (h) two) were one stage. What I mispriced: (h) was a missing construction, and it was fifty lines once the integrand was clamped to make the arclength an order isomorphism of the line |
| Z5 | a statement defect among my eleven, 0.2 | none. Generalizations only (§ 3.2; Stage 4's "two of the four disc conditions") |
| Z6 | `disj` read at exactly one step, 0.6 | **not met** — four steps through two lemmas (§ 5.3) |

**Price, for the planners' next table**: the plan priced lines C at 9 agent-days (`Curve` 2.5, `LocalGraph` 6.5). Done in one job, six stages,
five builds of about nine minutes each; about 1,300 lines added to the two modules. Its "computational leaves high by two to three" was low by
an order of magnitude, and so was "the large ones are not re-priced by them".

## Drafts for the front page

*For Keryx's pen; I edit none of these files. The gate was not run on this branch (not mine, and `Pinch`, `MapColouring`, `FanBridge` hold
`sorry`), so no gate count is drafted: the counts are the join's.*

1. **`CLAUDE.md` § Trust ledger, the audit sentence** — at the join that lands wave 6: the clean count grows by this job's **45** records
   (`scripts/Axioms.lean`, block "FS131-I6C"); six more become clean, and are to be appended to that block, when `Pinch`'s `c11_discs` and
   `TwoColourOn.essBoundary_inter_eq` land: `HasTwoDiscsAt.one_le_norm_sub`, `HasTwoDiscsAt.norm_sub_le`, `HasTwoDiscsAt.normal_unique`,
   `local_graph`, `AeColouring.local_graph`, `sq9_exists_isInterfaceChart` (each `HadwigerNelson.Plane.`…). No purchase, no import.
2. **Grades, for the wave's rows when it is filed** (`plans/FS131-E8-derivation.md`'s entries; each on `[propext, Classical.choice, Quot.sound]`
   with no assumption beyond its stated hypotheses unless said):
   - FS131-E8-DELTA → **[kernel]**: `HadwigerNelson.Plane.AeColouring.ae_one_colour_of_isConnected` (its `IsOpen W` is not read).
   - FS131-E8-OUTSIDE → **[kernel]**: `HadwigerNelson.Plane.IsUnitCurve.one_le_dist`.
   - FS121-V5-OFF and FS121-V5-LOC (i) → **[kernel]**: `AeColouring.closure_essBdry_subset`, `AeColouring.notMem_essBdry_of_mem_densitySet`.
   - The curve parts of FS131-E8-GAMMA and -BETA (C1, C2, the growth of the distance, the `s²/2` bound) → **[kernel]** as lemmas:
     `IsUnitCurve.chord`, `.sin_le_inner`, `.strictMonoOn_dist`, `.norm_sub_le`; the entries themselves are `FanBridge`'s (`gamma`, `beta`), open.
   - FS131-E8-LOCAL = FS111-M-C11 (ii) (with "no cusp in the neighbourhood") = FS111-W-NOBEND, and FS121-V5-LOC (ii): **proved over two
     named leaves** — `local_graph`, `AeColouring.local_graph` rest on `c11_discs` (FS111-M-C11 (i)) and `TwoColourOn.essBoundary_inter_eq`
     (`Plane/Saturated/Pinch`), and on nothing else open; [kernel] when those land.
3. **`ARCHITECTURE.md` § 3.11, two rows** (the imports cell of the second is already updated on this branch; the descriptions still say
   "skeleton"): in the row `Plane/Saturated/Curve`, replace "**FS-131 wave 6, skeleton** (job FS131-K6b;" by "**FS-131 wave 6** (jobs
   FS131-K6b, FS131-I6C: every leaf proved;" and after "proved: `norm_sub_le_of_discs`" add "; `IsUnitCurve.sin_add_sin_le` (C1 and C2 as one
   inequality, at length `π`), `exists_lens_point`, `isUnitCurve_circle`". In the row `Plane/Saturated/LocalGraph`, replace "**FS-131 wave 6,
   skeleton** (job FS131-K6b)." by "**FS-131 wave 6** (jobs FS131-K6b, FS131-I6C: every leaf proved, `local_graph` over `Pinch`'s `c11_discs` and
   `essBoundary_inter_eq`); children `HasTwoDiscsAt.norm_sub_le`, `exists_arclength_inverse`, `exists_unit_curve_of_two_discs`,
   `isConnected_graph_side`; inhabitant `sq9_exists_isInterfaceChart`."
4. **Frontier line and Proof Atlas**: no change of state from this job alone (FS-131 in flight; wave 6 lands at its gate). Atlas grade changes
   are item 2's.
5. **Errata for `plans/FS131-E8-derivation.md`** (the deriver's pen): under FS131-E8-DELTA, "connected open set" — openness is not read;
   under FS131-E8-GAMMA's § 3.2 (1) and -BETA's § 3.3, the inequalities C1, C2 and the growth of the distance hold for length at most `π`;
   under FS131-E8-LOCAL's § 3.1 (3)(c), the lens point reads two of (b)'s four inequalities (`x″ ∉ B(x′ + ν′, 1)`, `x′ ∉ B(x″ − ν″, 1)`); under
   § 3.1 (4), the chart with a symmetric arclength interval is a rectangle `(a, b) × (−h, h)` in the frame, `h = min(ρ, 1)/32`.

## What is left, and its route

- **In `Curve` and `LocalGraph`: nothing.** Eleven of eleven leaves closed; ten are kernel theorems or will be at the join; `local_graph` and
  its colouring form wait on line P's `c11_discs` and `TwoColourOn.essBoundary_inter_eq` — used exactly as stated at `32f2ab4c`.
- **For line F (`FanBridge`)**, tools this job leaves beyond the statements it was promised: `IsUnitCurve.sin_add_sin_le` (the chord bound
  between any two parameters `u₀`, `s` of a curve of length at most `π` — `gamma`'s injectivity on the closed interval is its case
  `s₂ − s₁`); `exists_unit_curve_of_two_discs` and `isConnected_graph_side` (no measure); `HasTwoDiscsAt.norm_sub_le`, `.normal_unique`;
  `TwoColourOn.mem_interior_densitySet_or`, `.ae_le_of_isPreconnected` (a connected set off the essential boundary and the cusps is of one
  colour, for two sets — DELTA's two-set form). **What `IsInterfaceChart` does not export** and `gamma`'s gluing may want: that `Q_a`, `Q_b`
  are disjoint; that `Q` is a rectangle in a frame; the graph function. They are in `local_graph`'s proof; if a consumer needs one, the
  cheap route is a second chart lemma beside `local_graph` with the richer conclusion (the proof is the same up to its last `refine`), never
  a change to `IsInterfaceChart`.
- **Not stated, the planner's § 11.5 (5)**: the agreement of the two readings of `Σ` under saturation; `local_graph` is now available for it.
