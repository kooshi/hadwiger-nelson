# FS132-I3 — the step lemma and the shift's calculus: implementation record

*de Bruijn, the implementer (Opus 5.5). Brief: `data/fs132/briefs/FS132-I3-step-lemma.md` (on `main`). Branch `fs132-wi3`,
cut from `fs132-wk1` at `e0c95ec1`. Two modules: `Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` (eight leaves) and
`Proofs/HadwigerNelson/Plane/SixRing/Shift.lean` (seven).*

## Theorems this phase proved

*One line per kernel theorem, with its declaration and its axioms. All in namespace `HadwigerNelson.SixRing`; "the
standard three" is `[propext, Classical.choice, Quot.sound]`, as printed (`data/fs132/i3/logs/axioms-steplemma.out`).*

`Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` (stage 2; every leaf of the module, no `sorry` left in it):

- **`step_lemma`** — Lemma S (C132-M-ORBIT, step M8): under (†) a measurable set of angles is, within `κ/4` of `t` and up
  to a null set, a half-line. [kernel], the standard three. Statement unchanged.
- `exists_step_or_density_triple` — on an interval a measurable set is a.e. an initial or final segment, or has three
  density points in the pattern in–out–in or out–in–out. [kernel], the standard three. Statement unchanged.
- `exists_window` — the dyadic window about the middle density point. [kernel], the standard three. Unchanged.
- `exists_shiftMap` — the map `g` at one outer pair, with slopes in `[7/8, 9/8]`. [kernel], the standard three.
  **Statement changed by permission (1)**: the hypothesis `huw : u < w` is dropped (the proof does not use it).
- `exists_density_pair` — a base point `v` with `v`, `g v` density points of the window's set. [kernel], the standard
  three. Unchanged.
- `volume_pattern_pos` — the forbidden pattern has positive measure in every cube about a base point of four density
  points. [kernel], the standard three. Unchanged.
- `step_at_of_change` — the jump is at the change point. [kernel], the standard three. Unchanged.
- `volume_change_pairs_pos` — M3's first sentence: at a change point the split pairs have positive measure.
  [kernel], the standard three. **Statement changed by permission (1)**: the hypothesis `hS : MeasurableSet S` is
  dropped (the proof does not use it); it has no call site yet (`State.exists_tip` is a `sorry`).
- helpers, new, all [kernel] on the standard three: `ae_mem_imp_isDensityPt`, `IsDensityPt.mono`,
  `isDensityPt_of_mem_nhds`, `IsDensityPt.eventually_lt`, `IsDensityPt.eventually_compl_le`,
  `IsDensityPt.eventually_lt_Ioo`, `IsDensityPt.not_compl`, `volume_le_mul_volume_image`, `noDoubleChange_compl`,
  `density_triple_false` (the contradiction of Lemma S, from the four children), `change_Iio`.

`Proofs/HadwigerNelson/Plane/SixRing/Shift.lean` (stage 3; every leaf of the module, no `sorry` left in it; axioms as
printed in `data/fs132/i3/logs/axioms-block.out`):

- **`exists_shiftBounds`** — M7's display: for some `κ ∈ (0, 1/4]` the chart's shift is positive, at most
  `min(d, d')/16` and `1/32`-Lipschitz in each variable on `(0, κ)²`. Proved by the planner from the leaves; with
  the leaves proved it is [kernel], the standard three. Statement unchanged.
- **`dist_chart_chart_shift`** — M7's unit-pair relation: `dist (Z(α, d)) (Z(α + ε + d' + π/3, d')) = 1` on
  `[0, 1/4]²`. [kernel], the standard three. Unchanged.
- `shift_pos` — M7's sign, `0 < ε` on `(0, 1/4]²`. [kernel], the standard three. Unchanged.
- `exists_shift_lipschitz` — M7's "`|∇ε| ≤ 1/32`", in one variable on a closed square `[0, κ]²`. [kernel], the
  standard three. Unchanged.
- `ringRadius_mem`, `shift_comm`, `shift_zero_right`, `shift_zero_left`, `measurable_shift` — [kernel], the standard
  three. Unchanged.
- helpers, new, all [kernel] on the standard three: `ringRadius_eq`, `chart_eq_polar_shift` (the statement of
  `Chart.chart_eq_polar`, another lot's leaf, under a name of its own), `norm_sq_polar_sub` (the law of cosines in
  polar form), `shiftCos_mem`, `shift_sign_identity` (row 148's straddle identity in the chart's variables).

## Stage 1 — SAVED (FS132-I3): the readback

**Quotations.** `data/fs132/i3/readback.py` reads every block quotation of the brief and looks for it, whitespace
normalized, as a literal substring of the source it names: `quotations=17 matched=17 mismatched=0`, exit 0. Its control
(`--fault`: one quotation altered by one letter) reads `matched=16 mismatched=1`, exit 1. The seventeen: Kooshi's two
(the request file; `CLAUDE.md` § Counter-priors), twelve first lines of leaves (eight in `StepLemma.lean`, four in
`Shift.lean`), three of the planner's record's Stage 5.

**Read whole.** The brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; the planner's record `plans/FS132-kernel-plan.md` Stage 3 § 3.1–3.3 and Stage 5 (§ 5.1–5.4); the hand
argument `plans/FS132-E3-derivation.md` Stage 3, steps M7 and M8 with Lemma S (ll. 241–292, and M9 for the use made of
the lemma), at `main`'s copy; `plans/FS132-derivation.md` § 1 (the entry C132-M-ORBIT, its table of who did what);
`StepLemma.lean`, `Shift.lean`, `Basic.lean` and `Chart.lean` of `Plane/SixRing/`, whole.

**The two files as given.** `StepLemma.lean`: 8 `sorry` — `exists_step_or_density_triple`, `exists_window`,
`exists_shiftMap`, `exists_density_pair`, `volume_pattern_pos`, `step_lemma`, `step_at_of_change`,
`volume_change_pairs_pos`. `Shift.lean`: 7 `sorry` — `ringRadius_mem`, `shift_comm`, `shift_zero_right`,
`dist_chart_chart_shift`, `shift_pos`, `exists_shift_lipschitz`, `measurable_shift`; `shift_zero_left` and
`exists_shiftBounds` are proved from them.

**Built as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`: exit 0, "all 1860
modules already up to date", warnings `declaration uses sorry` only (`data/fs132/i3/logs/build-0-as-given.out`).

**What the statements say, in my words, before any proof** (the reading aloud of `step_lemma` against Lemma S is
stage 2's, when it is proved):

- `IsDensityPt E x` is the two-sided closed-ball form: `vol(E ∩ [x − r, x + r]) / vol([x − r, x + r]) → 1` as `r → 0⁺`.
- `NoDoubleChange ε S t κ` is (†): for a.e. `(α, d, d')` in the box `|α − t| < κ`, `0 < d, d' < κ`, not both
  `(α − d ∈ S ↔ α ∉ S)` and `(α + ε ∈ S ↔ α + ε + d' ∉ S)`.
- `step_lemma` concludes on `|θ − t| < κ/4` — the derivation's `J = (ψ₁ − κ₁/4, ψ₁ + κ₁/4)`.
- `ShiftBounds ε κ` gives, on `(0, κ)²`: `0 < ε`, `ε ≤ d/16`, `ε ≤ d'/16`, and `1/32`-Lipschitz in each variable.
  **It gives no measurability of `ε`.** `volume_pattern_pos` and `step_lemma` conclude about sets defined through `ε`;
  a positivity statement `0 < volume A` for a possibly non-measurable `A` is about outer measure, so the route must be
  one that never integrates over `(d, d')` an expression in `ε` — noted here before the proof, to be decided at the leaf.

Token count at this stage: own estimate ≈ 130k (the launch context is most of it).

## Stage 2 — SAVED (FS132-I3): the step lemma's module, every leaf proved

**State.** `Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean`: 768 lines, no `sorry`. Built under the slot
(`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`): **exit 0**, 5 modules rebuilt (`StepLemma`, `State`, `Kill`, `Orbit`,
`Proofs`), `StepLemma` built with no warning; the build's sorry-warning count fell from 12 modules to 11
(`data/fs132/i3/logs/build-1-steplemma.out`). Axioms, printed from the built module by
`data/fs132/i3/probe/AxStep.lean` (`data/fs132/i3/logs/axioms-steplemma.out`): `step_lemma`, its five children,
`density_triple_false`, `step_at_of_change` and `volume_change_pairs_pos` each read `[propext, Classical.choice,
Quot.sound]`; **the control fires** — `chart_step_false` (`Kill.lean`), which calls `step_lemma` beside leaves still
unproved, reads `[propext, sorryAx, Classical.choice, Quot.sound]` in the same print.

**Which route the kernel accepted: the planner's variant** (dyadic window; a base point of four density points; no
integration over the outer pair), with three changes of route inside leaves, none of statement:

1. `volume_pattern_pos` — the planner's plan integrates (`Measure.prod_apply` / `lintegral_prod`). That needs the set of
   triples measurable, hence `ε` measurable, and `ShiftBounds` gives no measurability. Proved instead by contradiction
   through sections: if the set were null, `Measure.measure_ae_null_of_prod_null` (which asks no measurability) makes
   almost every section at fixed `(d₁, d₂)` null; but for *every* `(d₁, d₂)` within `r` of `(d, d')` the section is a
   measurable set of angles of positive measure — the window `[α − r, α + r]` is covered by it and four translates of
   the sets `closedBall xᵢ (3r) \ Eᵢ`, each of measure at most `r/8` (density at one scale, `δ = 1/24`, in place of the
   plan's four radii). The displacement of the third and fourth angle is at most `r/16` by the two Lipschitz clauses.
2. `exists_density_pair` — the image bound `vol F ≤ (8/7) vol (g '' F)` is `AntilipschitzWith.le_hausdorffMeasure_image`
   for the restriction of `g` to the subtype `↥F` with `hausdorffMeasure_real`, not a Lipschitz bound for an inverse
   (`volume_le_mul_volume_image`: no measurability of `F`, `g` or the image). The density points are taken off a
   measurable null set (`toMeasurable`), so the set `F \ N` in the disjoint-union count is measurable and the image
   need not be.
3. `volume_change_pairs_pos` — two shears `(x, y) ↦ (x, x − y)` and its composite with the swap, each measure
   preserving (`measurePreserving_prod_add` after a reflection); the product `(S ∩ I) × (Sᶜ ∩ I)` lies in the union
   of the two preimages. No measurability of `S` is read.

The other leaves follow the plan: `exists_step_or_density_triple` by `sSup` of the density points of the earlier
value (with `IsDensityPt.not_compl`: no point is a density point of a set and of its complement — the plan's sketch
needs it and does not name it); `exists_window` by `Nat.find` on the dyadic radii; `exists_shiftMap` by
`intermediate_value_Icc` for `D ↦ D + ε (v − u) D` on `[(w − v)/2, w − v]` and two triangle inequalities;
`step_lemma` from `density_triple_false` twice (for `S` and, by `noDoubleChange_compl`, for `Sᶜ`).

**Is any leaf false, vacuous or short of a hypothesis?** None. Each leaf is proved as stated, two of them with one
hypothesis fewer. Each has a model of its hypotheses in the file, as an `example` that applies the leaf:
`E = (−1, 1)` between `−2` and `2` (`exists_window`); the product shift on `(0, 1/4)` (`exists_shiftMap`); the whole
interval moved by `1/16` (`exists_density_pair`); the product shift with both sets the line (`volume_pattern_pos`);
the half-line (`step_at_of_change`, `volume_change_pairs_pos`, through `change_Iio`; and (†), the planner's
`example`). `density_triple_false` concludes `False`: its docstring says no model can exist and names a model of each
hypothesis alone.

**`step_lemma` read aloud against Lemma S.** The informal statement (`plans/FS132-E3-derivation.md`, Stage 3, M8):

> **Lemma S.** *If (†) holds almost everywhere, `s` is almost everywhere equal, on `J = (ψ_1 − κ_1/4, ψ_1 + κ_1/4)`, to a
> function with at most one jump.*

with

> (†) not both `s(α − d) ≠ s(α)` and `s(α + ε) ≠ s(α + ε + d′)`, `ε = ε(d, d′)`.

"for almost every `(α, d, d′)` with `|α − ψ_1| < κ_1` and `0 < d, d′ < κ_1`". The Lean statement, as the kernel holds it
(`#check @step_lemma`, same log):

```
@HadwigerNelson.SixRing.step_lemma : ∀ {ε : ℝ → ℝ → ℝ} {κ : ℝ},
  0 < κ → ShiftBounds ε κ → ∀ {S : Set ℝ}, MeasurableSet S → ∀ {t : ℝ}, NoDoubleChange ε S t κ →
    ∃ t', (∀ᵐ (θ : ℝ), |θ - t| < κ / 4 → (θ ∈ S ↔ θ < t')) ∨ ∀ᵐ (θ : ℝ), |θ - t| < κ / 4 → (θ ∈ S ↔ t' < θ)
```

Aloud: for every function `ε` of two reals and every `κ > 0` such that on the open square `(0, κ)²` the function is
positive, at most a sixteenth of each argument and `1/32`-Lipschitz in each argument; for every measurable set `S` of
reals and every real `t`: if for Lebesgue-almost every triple `(α, d, d')` with `|α − t| < κ`, `0 < d < κ`,
`0 < d' < κ` it is not the case that both [`α − d ∈ S` exactly when `α ∉ S`] and [`α + ε(d, d') ∈ S` exactly when
`α + ε(d, d') + d' ∉ S`], then there is a real `t'` such that either almost every `θ` with `|θ − t| < κ/4` lies in `S`
exactly when `θ < t'`, or almost every such `θ` lies in `S` exactly when `t' < θ`.

Clause against clause:

| Lemma S | `step_lemma` | same? |
|---|---|---|
| `s`, a two-valued state (`X` or `Y`), defined almost everywhere near the six directions | `S`, a measurable set of reals: the level set `{s = X}`; defined everywhere | the Lean is the more general (any measurable set; nothing about palettes). "`s(x) ≠ s(y)`" is "exactly one of `x`, `y` in `S`", written `x ∈ S ↔ y ∉ S` |
| (†), for a.e. `(α, d, d′)` with `\|α − ψ_1\| < κ_1`, `0 < d, d′ < κ_1` | `NoDoubleChange ε S t κ`, the same box with `t = ψ_1`, `κ = κ_1`, Lebesgue measure on `ℝ × ℝ × ℝ` | yes |
| `ε = ε(d, d′)`, M7's shift: smooth, `0 < ε ≤ min(d, d′)/16`, `\|∇ε\| ≤ 1/32` on `(0, κ_1)²` | any `ε` with `ShiftBounds ε κ`: positive, `≤ d/16`, `≤ d'/16`, `1/32`-Lipschitz in each variable, on `(0, κ)²` | the Lean assumes less: no smoothness, no measurability; the gradient bound gives the two Lipschitz clauses on the convex square |
| on `J = (ψ_1 − κ_1/4, ψ_1 + κ_1/4)` | `\|θ − t\| < κ/4` | yes |
| "almost everywhere equal to a function with at most one jump" | `∃ t'`: a.e. on `J`, `θ ∈ S ↔ θ < t'`; or a.e. on `J`, `θ ∈ S ↔ t' < θ` | yes for a two-valued function: no jump is `t'` outside `J`; one jump is `t'` inside, in either orientation. A function with one jump whose two values are equal is the constant case |
| — | `0 < κ` | an extra hypothesis the proof needs nowhere in logic (for `κ ≤ 0` the conclusion is empty); kept, as the planner stated it, and used to choose a radius |

Not said by either: where the jump is (that is M8's last line, `step_at_of_change`, with M1's change point); anything
about a colouring. **Verdict of the reading: `step_lemma` is Lemma S, for one level set of a two-valued state, under
weaker assumptions on the shift.** One reading, mine, with both texts open.

**Statement changes, both by the planner's permission (1)** (a hypothesis a proof does not use is dropped):
`exists_shiftMap` loses `huw : u < w` (its one call site, `density_triple_false`, is in this file);
`volume_change_pairs_pos` loses `hS : MeasurableSet S` (no call site exists: `State.exists_tip`, whose plan names it,
is a `sorry`). `step_lemma`, `step_at_of_change` (the two called from `Kill.lean`) and the other four are as given.

**Price, measured.** 8 leaves and 11 helpers; the file went from 146 to 768 lines; 2 builds under the slot (the
as-given one, 4 s; this one, 8 min 54 s, of which the module itself 4.6 s); about 25 `lake env lean` iterations of
2–5 s; 7 elaboration errors in all, none a mathematical one (one pair of `min` arguments, one `norm_num` step, and in
`volume_pattern_pos`, five: a membership coercion, a filter lemma's form, two beta-redexes, one unnamed measure). No
dispatch to a companion. The planner's estimate for the module was 550 lines.

Token count at this stage: own estimate ≈ 230k.

## Stage 3 — SAVED (FS132-I3): the shift's module, every leaf proved; the checks after the last green build

**State.** `Proofs/HadwigerNelson/Plane/SixRing/Shift.lean`: 290 lines, no `sorry`; `StepLemma.lean`: 769 lines, no
`sorry` (one docstring line more than at stage 2: `exists_shiftMap`'s now says its interval may be empty). The last
build under the slot (`--mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`): **exit 0**, 7 modules rebuilt (`Shift`, `StepLemma`,
`ChartMeasure`, `State`, `Kill`, `Orbit`, `Proofs`), no warning in either of the two modules; the build's
sorry-warning count stands at 10 modules, from 12 as given (`data/fs132/i3/logs/build-3-final.out`; the build after
`Shift` alone is `build-2-shift.out`, exit 0).

**Routes, leaf by leaf, and where they leave the plan.**

- `ringRadius_mem` — the plan's: `r(d) = cos(d/2) − √3 sin(d/2)` (`ringRadius_eq`), then `1 − x²/2 ≤ cos x`,
  `sin x ≤ x`, `√3 < 2`.
- `shift_comm` — `ring_nf` on the definition. `shift_zero_right` — the quotient is `r(d)/2 = cos(π/3 + d/2)`;
  `Real.arccos_cos`.
- `dist_chart_chart_shift` — the plan's: the chart in polar form, the law of cosines, `Real.cos_arccos` with
  `−1 ≤ Q ≤ 1` (`shiftCos_mem`, from `(r − r')² ≤ 1 ≤ (r + r')²`). **The polar form is proved here under a name of
  this module's own, `chart_eq_polar_shift`**: `Chart.chart_eq_polar` is another lot's leaf, a `sorry` there, and this
  module does not import `Chart` (`LEAN.md` § Searching: a line that needs another line's lemma before they meet
  states it under a name of its own and says so). At the join one of the two goes.
- `shift_pos` — the plan's identity, **not through `Plane.twoCirc_identity`**: the same identity is proved in the
  chart's variables (`shift_sign_identity`), as a polynomial identity in the sines and cosines of `d/2`, `d'/2` and
  `√3` modulo the three Pythagorean relations, by `linear_combination`. The multipliers were computed, not found by
  hand: `data/fs132/i3/shift_identity.py` (sympy's `reduced`; remainder 0, exit 0; **its control fires** — `--fault`
  changes the identity's `8` to `7`, remainder `−ca·cb·sa·sb + sa²·sb²`, exit 1). The kernel checks the identity; the
  script only supplied coefficients. Then `Q < cos(π/3 + (d + d')/2)` and `Real.strictAntiOn_arccos`.
- `exists_shift_lipschitz` — the plan's tool (`ContDiffAt.exists_lipschitzOnWith_of_nnnorm_lt` with `K = 1/32`), **with
  no derivative computed**: the shift is `C¹` at the origin (a composition; `Real.contDiffAt_arccos` at `Q = 1/2`), it
  vanishes on both positive axes (`shift_zero_right`, `shift_zero_left`), so its derivative at the origin kills
  `(1, 0)` and `(0, 1)` — a one-sided derivative, `uniqueDiffWithinAt_Ici` — and is zero. The neighbourhood contains a
  sup-norm ball, which is a square. **The `κ` is not explicit**: the plan's "numerically `κ = 1/50` works" is not
  proved and is not needed; the statement asks for some `κ ∈ (0, 1/4]`. An honest estimate of the gradient on a named
  square would be a different, longer leaf; nothing in the assembly reads the value of `κ`.
- `measurable_shift` — `fun_prop` on the unfolded definition.

**The statements read against M7** (`plans/FS132-E3-derivation.md`, Stage 3, M7), for the theorems the assembly uses:

| M7 | Lean | same? |
|---|---|---|
| "`\|z − z′\| = 1` holds on `α′ = α + π/3 + d′ + ε(d, d′)`, independent of `α`", `z = Z(α, d)`, `z′ = Z(α′, d′)`, `d, d′ ≥ 0` near `0` | `dist_chart_chart_shift`: for every `p`, `α` and `0 ≤ d, d' ≤ 1/4`, `dist (chart p α d) (chart p (α + shift d d' + d' + π / 3) d') = 1` | the direction used (on the locus the distance is `1`; not "only there"), on a named square, with `ε` the explicit `shift`. The derivation's `ε` is this function near `0`: its `g = ε + (d + d')/2` solves `cos(π/3 + g) = Q` with `π/3 + g` near `π/3`, the principal branch |
| "`0 < ε(d, d′) ≤ min(d, d′)/16` and `\|∇ε\| ≤ 1/32` for `0 < d, d′ < κ_1`", some `κ_1 ≤ κ_*/3` | `exists_shiftBounds`: `∃ κ, 0 < κ ∧ κ ≤ 1/4 ∧ ShiftBounds shift κ` | the sign and the two bounds by a sixteenth as written; the gradient bound as the two one-variable Lipschitz clauses it implies (what M8 and M9 read); `κ ≤ 1/4` in place of `κ_1 ≤ κ_*/3` — the caller (`chart_step_false`) takes the minimum with its own `κ/3` |
| "for `d′ = 0` … `ε(d, 0) = 0`; for `d = 0` … `ε(0, d′) = 0`" | `shift_zero_right`, `shift_zero_left`, on `[0, 1/4]` | yes |
| "`h(0, 0) = 2/√3`" (the expansion) | not stated, not used: the sign comes from the exact identity at zero shift, the bound by a sixteenth from the Lipschitz clauses and the vanishing on the axes (the planner's design) | — |

One reading, mine, with both texts open.

**Every leaf as the kernel holds it, against the skeleton.** `data/fs132/i3/sigs.py` splits the planner's print of the
leaves at the skeleton (`data/fs132/k2/probe/Sigs.out`) and a print made now (`data/fs132/i3/probe/SigsNow.lean`,
`logs/sigs-now.out`) into records and compares the sixteen names of my two modules that the planner printed:
`leaves=16 same=14 changed=2 missing=0 … verdict=OK`, exit 0; the two changed are `exists_shiftMap` and
`volume_change_pairs_pos`, each by the one dropped hypothesis and nothing else (`logs/sigs-compare.out` prints both
forms). **Its control fires**: `--fault` deletes `0 < κ →` from `step_lemma`'s record of the new print; `changed=3`,
`verdict=FAIL`, exit 1. The seventeenth theorem, `shift_zero_left`, was already proved in the skeleton and is not in
the planner's print; its statement line is not in `git diff e0c95ec1`.

**After the last green build** (each output saved under `data/fs132/i3/logs/`):

| check | result |
|---|---|
| my block in `scripts/Axioms.lean`, headed "FS132-I3", above the PURCHASED banner: 33 records (19 of `StepLemma`, 14 of `Shift`) | written from one list by script; the same 33 lines printed alone by `data/fs132/i3/probe/AxBlock.lean`: **33 of 33 read `[propext, Classical.choice, Quot.sound]`**; the control in the same print, `chart_step_false`, reads `sorryAx` (`axioms-block.out`) |
| `tools/check_architecture.py` | exit 0, `RESULT: PASS` (`check-architecture.out`) |
| `./scripts/dupnames.sh` (under the slot, `--mem 16`) | exit 0, "no name is declared by two modules (23 generated on demand)" (`dupnames.out`) |
| `lake lint --no-build -- --no-build --trace` (under the slot, `--mem 8`) | exit 0, 14 linters each `(2/2) Passed!`, `-- Linting passed for Proofs.` (`lint.out`); `unusedArguments` among them |

**Not run, and why**: `scripts/axioms.sh` (the audit of the whole file; my block was printed alone), `vacuity.sh`,
`assumptions.sh`, any `--self-test` — the brief keeps the full gate for the landing. So the controls watched here are
mine: the sorry control in both axiom prints, the readback's, the identity script's and the signature comparison's;
I planted no fault in `dupnames.sh`, `check_architecture.py` or the lint. The build's own unused-variable linter was
seen to fire, unplanted, on each of the two hypotheses before it was dropped (`huw`, `hS`).

**Price, measured, both modules.** 15 leaves (8 + 7) and 16 helpers (11 + 5); 237 lines as given (146 + 91), 1,059 now
(769 + 290); 4 builds under the slot (4 s as given; 8 min 54 s; 9 min 7 s; 8 min 52 s — each walks all 477 batches and
compiles 5–7 modules, my two in 4–5 s each); about 40 `lake env lean` iterations; 12 elaboration errors in all (7 in
`StepLemma`, 5 in `Shift`: a rewrite that took the wrong sum, a notation scope, a point written `0` against `(0, 0)`,
an `ext` that bound no vector, and one `ring` that closed only by its fallback), none mathematical; no dispatch to a
companion. The planner's estimate for the two modules was 550 + 180 lines, with `exists_shift_lipschitz` "the heavy
calculus leaf" at 60: it is 62 with its statement, and no derivative is computed in it — the gradient at the origin
is read off the axes.

Token count at this stage: own estimate ≈ 300k.

## Drafts for the front page

*Each names its slot. Nothing here is filed by me. The milestone is not closed by this job: two of its twelve modules
are proved; the counts of the full gate are the landing's.*

1. **`ARCHITECTURE.md`, the module map, the two rows `Plane/SixRing/Shift` and `Plane/SixRing/StepLemma`** (I did not
   edit them: the brief gives me whole new lines for new modules only, and I added none). In each row replace
   "**FS-132 (FS132-K2), branch `fs132-wk1`. SKELETON.**" by "**FS-132 (FS132-K2 stated, FS132-I3 proved). No `sorry`.**";
   in the `Shift` row replace "(leaves); `shift_zero_left` and `exists_shiftBounds` proved from them." by
   "; `shift_zero_left` and `exists_shiftBounds` from them; helpers `ringRadius_eq`, `chart_eq_polar_shift`,
   `norm_sq_polar_sub`, `shiftCos_mem`, `shift_sign_identity`."; in the `StepLemma` row add after
   "`volume_change_pairs_pos`" the words "; `density_triple_false`; the density tools (`ae_mem_imp_isDensityPt`,
   `IsDensityPt.mono`, `.eventually_lt`, `.eventually_compl_le`, `.not_compl`, `isDensityPt_of_mem_nhds`),
   `volume_le_mul_volume_image`; a model of each leaf's hypotheses".
2. **`plans/FS132-derivation.md` § 1, the table "Who did what, step by step"** — a column or a dated line under it,
   in these words: "M8, the step lemma (Lemma S): **[kernel]** — `HadwigerNelson.SixRing.step_lemma`
   (`Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean`), axioms `[propext, Classical.choice, Quot.sound]`, no
   assumption; along the planner's variant; for any shift with `ShiftBounds`, with no measurability of the shift
   (FS132-I3, branch `fs132-wi3`). M7, the shift: **[kernel]** for the unit-pair relation in the direction used
   (`dist_chart_chart_shift`), the sign (`shift_pos`), the vanishing on the axes, the bounds
   (`exists_shiftBounds`) and measurability (`measurable_shift`), same axioms; M7's last sentence — that the map `Φ`
   carries null sets to null sets — is `ChartMeasure.unitPair_chart_ae`, another lot's leaf, not proved here." The
   entry's `grade:` and `minds:` fields are the coordinator's; C132-M-ORBIT itself is [kernel] only when the other
   ten modules land.
3. **`LEAN.md` § Searching — Lean**, three lines to follow the last bullet:
   - "Positivity of the measure of a set that need not be measurable goes through sections:
     `Measure.measure_ae_null_of_prod_null` asks no measurability, so a null set has almost every section null, and
     one positive section on a set of positive measure refutes it (`SixRing.volume_pattern_pos`, FS132-I3)."
   - "`vol F ≤ K · vol (g '' F)` on the line for a map that shrinks no distance on `F` by more than `K`, with no
     measurability of `F`, `g` or the image: `AntilipschitzWith.le_hausdorffMeasure_image` for `F.restrict g`,
     `Isometry.hausdorffMeasure_image` for the coercion, `hausdorffMeasure_real` (import
     `Mathlib.MeasureTheory.Measure.Hausdorff`; `SixRing.volume_le_mul_volume_image`, FS132-I3)."
   - "A `ring` that cannot close a goal and whose fallback `ring_nf` does prints `Try this: ring_nf` as information,
     with no file position in `lake env lean`'s plain output: `lake env lean --json` gives the line. And `ext` on a
     continuous linear map out of a product applies `prod_ext` and binds no vector: write
     `ContinuousLinearMap.ext fun v => _` (FS132-I3)."
4. **`CLAUDE.md` § Trust ledger and § The gate** — no count from me: I did not run the audits. What the landing should
   expect from this block alone: 33 more records, all clean, no purchase, no import, no assumption in hypothesis form
   (neither module takes a named hypothesis; `ShiftBounds` is a condition on a parameter, inhabited by
   `shiftBounds_model` and by `exists_shiftBounds`).
