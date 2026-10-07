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
2–5 s; 7 elaboration errors in all, none a mathematical one (two `min` arguments, one `norm_num` step, four in
`volume_pattern_pos`: a membership coercion, a filter lemma's form, two beta-redexes, one unnamed measure). No
dispatch to a companion. The planner's estimate for the module was 550 lines.

Token count at this stage: own estimate ≈ 230k.
