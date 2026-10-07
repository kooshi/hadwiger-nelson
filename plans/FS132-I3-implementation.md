# FS132-I3 — the step lemma and the shift's calculus: implementation record

*de Bruijn, the implementer (Opus 5.5). Brief: `data/fs132/briefs/FS132-I3-step-lemma.md` (on `main`). Branch `fs132-wi3`,
cut from `fs132-wk1` at `e0c95ec1`. Two modules: `Proofs/HadwigerNelson/Plane/SixRing/StepLemma.lean` (eight leaves) and
`Proofs/HadwigerNelson/Plane/SixRing/Shift.lean` (seven).*

## Theorems this phase proved

*(filled stage by stage; one line per kernel theorem, with its declaration and its axioms)*

- none yet (stage 1 is the readback).

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
